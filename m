Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1820434D1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTOLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:11:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTOLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:11:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3324121A99;
        Wed, 20 Oct 2021 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634738960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KnXBhUNJv/WVWUSlwFenArlKHt1VS6I2BmO/6T0kJ8=;
        b=qcuaAHEcPdC9FePAFNwae55kxjFmlWxYmLRIceAaO5OQ/FNqR86mGU0FNpPF9m86q/polV
        35WorJzj+gLQyMZ89I1LXK4L8ydc1LqDeukrEimFs5od0BfqJWxElYZ0A3vOieTRppoxKJ
        VWKKXtvLZuOHeZ9y6y45DToP6+KmknA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E038A13B55;
        Wed, 20 Oct 2021 14:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WCQ7NA8jcGG1EgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Oct 2021 14:09:19 +0000
Subject: Re: [PATCH v11 02/10] btrfs-progs: receive: dynamically allocate
 sctx->read_buf
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <01efd9dd3a70c1a765549b16d6aa5c4cec8a67e4.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c30108b4-3001-2f6f-dd01-d3fb31f5d4da@suse.com>
Date:   Wed, 20 Oct 2021 17:09:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01efd9dd3a70c1a765549b16d6aa5c4cec8a67e4.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> In send stream v2, write commands can now be an arbitrary size. For that
> reason, we can no longer allocate a fixed array in sctx for read_cmd.
> Instead, read_cmd dynamically allocates sctx->read_buf. To avoid
> needless reallocations, we reuse read_buf between read_cmd calls by also
> keeping track of the size of the allocated buffer in sctx->read_buf_sz.
> 
> We do the first allocation of the old default size at the start of
> processing the stream, and we only reallocate if we encounter a command
> that needs a larger buffer.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/send-stream.c | 55 ++++++++++++++++++++++++++++----------------
>  send.h               |  2 +-
>  2 files changed, 36 insertions(+), 21 deletions(-)
> 

<snip>

> @@ -124,18 +125,22 @@ static int read_cmd(struct btrfs_send_stream *sctx)
>  		goto out;
>  	}
>  
> -	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
> -	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
> -	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
> -
> -	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
> -		ret = -EINVAL;
> -		error("command length %u too big for buffer %zu",
> -				cmd_len, sizeof(sctx->read_buf));
> -		goto out;
> +	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
> +	cmd_len = le32_to_cpu(cmd_hdr->len);
> +	cmd = le16_to_cpu(cmd_hdr->cmd);
> +	buf_len = sizeof(*cmd_hdr) + cmd_len;
> +	if (sctx->read_buf_sz < buf_len) {
> +		sctx->read_buf = realloc(sctx->read_buf, buf_len);
> +		if (!sctx->read_buf) {

nit: This is prone to a memory leak, because according to
https://en.cppreference.com/w/c/memory/realloc

If there is not enough memory, the old memory block is not freed and
null pointer is returned.


This means if realloc fails it will overwrite sctx->read_buf with NULL,
yet the old memory won't be freed which will cause a memory leak. It can
be argued that's not critical since we'll very quickly terminate the
program afterwards but still.


<snip>

