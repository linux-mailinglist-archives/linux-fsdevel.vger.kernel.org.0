Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E51D92BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393664AbfJPNmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 09:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfJPNmo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB4EF10CC211;
        Wed, 16 Oct 2019 13:42:44 +0000 (UTC)
Received: from work (ovpn-204-131.brq.redhat.com [10.40.204.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8393A66A07;
        Wed, 16 Oct 2019 13:42:42 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:42:38 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Handle fs_param_neg_with_empty
Message-ID: <20191016134238.mzzmrn3wucgjqdvz@work>
References: <157122227425.17182.1135743644487819585.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157122227425.17182.1135743644487819585.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 16 Oct 2019 13:42:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:37:54AM +0100, David Howells wrote:
> Make fs_param_neg_with_empty work.  It says that a parameter with no value
> or and empty value should be marked as negated.
> 
> This is intended for use with ext4, which hadn't yet been converted.

Hi David,

thanks for the fix, this seems to be working fine for me. However this
will only work for fs_param_is_string, not anything else. I do not need
anything else, but unless you want to make it work for all the value types
some changes in documentation might be needed as well.

Thanks!
-Lukas

> 
> Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fs_parser.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index d1930adce68d..f95997a76738 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -129,6 +129,11 @@ int fs_parse(struct fs_context *fc,
>  	case fs_param_is_string:
>  		if (param->type != fs_value_is_string)
>  			goto bad_value;
> +		if ((p->flags & fs_param_neg_with_empty) &&
> +		    (!result->has_value || !param->string[0])) {
> +			result->negated = true;
> +			goto okay;
> +		}
>  		if (!result->has_value) {
>  			if (p->flags & fs_param_v_optional)
>  				goto okay;
> 
