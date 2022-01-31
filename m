Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35234A4EAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356904AbiAaSnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:43:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59774 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350447AbiAaSnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:43:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E128C6115C;
        Mon, 31 Jan 2022 18:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1109C340E8;
        Mon, 31 Jan 2022 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643654600;
        bh=MlCVNXyMLH8N9zlEgC505sGgVhNwmsbLQHiBxPE+K58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IM19ayOIddG1TmaKYhEGPvyzdDS/gGRO9UoQES/v9E/djUqXQnoHmovXnNkwq+E2A
         SAzWRVnV9+s8D2WaIhSak1rGr3hDcSJXijPTAGmX17QgXTdzot2WlNR3qs4mC9vDPc
         OdHOzwN16WNYk3f1ZJTpWV1VyQ9VkieVJ49eYWHvUFP87xvXEQF56xxVz72r/aubyk
         46vIfIe3et2S7mxrUOFaIqUnuWp8F8qolITZ5Mc8ACd5aYeZ2sgQ5wCxt7iyLPqTC5
         bGEvhZ07U3Kj53WNWx/9u8HcAjqxU+vUr8LDftcXRn+kujXAETeSKpoSv3HNjwI2xU
         fsbb0Rx5MWmrQ==
Message-ID: <cc2a90295935c8841abf5d0538590eb5202a745c.camel@kernel.org>
Subject: Re: [PATCH] cachefiles: Fix the volume coherency check
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 13:43:18 -0500
In-Reply-To: <164365156782.2040161.8222945480682704501.stgit@warthog.procyon.org.uk>
References: <164365156782.2040161.8222945480682704501.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-31 at 17:52 +0000, David Howells wrote:
> Fix the cache volume coherency attribute check.  It was copied from the
> file coherency check which uses as struct to lay out the xattr, and so
> needs to add a bit on to find the coherency data - but the volume coherency
> attribute only contains the coherency data, so we shouldn't be using the
> layout struct for it.
> 
> This has passed unnoticed so far because it only affects cifs at the
> moment, and cifs had its fscache component disabled.
> 
> This can now be checked by enabling CONFIG_CIFS_FSCACHE, enabling the
> following tracepoint:
> 
> 	/sys/kernel/debug/tracing/events/cachefiles/cachefiles_vol_coherency/enable
> 
> and making a cifs mount.  Without this change, the trace shows a
> cachefiles_vol_coherency line with "VOL BAD cmp" in it; with this change it
> shows "VOL OK" instead.
> 
> Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <smfrench@gmail.com>
> cc: linux-cifs@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/cachefiles/xattr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
> index 83f41bd0c3a9..c6171e818a7c 100644
> --- a/fs/cachefiles/xattr.c
> +++ b/fs/cachefiles/xattr.c
> @@ -218,10 +218,10 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
>   */
>  int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
>  {
> -	struct cachefiles_xattr *buf;
>  	struct dentry *dentry = volume->dentry;
>  	unsigned int len = volume->vcookie->coherency_len;
>  	const void *p = volume->vcookie->coherency;
> +	void *buf;
>  	enum cachefiles_coherency_trace why;
>  	ssize_t xlen;
>  	int ret = -ESTALE;
> @@ -245,7 +245,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
>  					"Failed to read xattr with error %zd", xlen);
>  		}
>  		why = cachefiles_coherency_vol_check_xattr;
> -	} else if (memcmp(buf->data, p, len) != 0) {
> +	} else if (memcmp(buf, p, len) != 0) {
>  		why = cachefiles_coherency_vol_check_cmp;
>  	} else {
>  		why = cachefiles_coherency_vol_check_ok;
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
