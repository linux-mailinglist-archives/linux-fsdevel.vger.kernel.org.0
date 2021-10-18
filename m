Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6900431991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJRMqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 08:46:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59022 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRMqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:46:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF201FD7A;
        Mon, 18 Oct 2021 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634561064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6PrWi/knub5lZJm9+0SpBdxmfEmYLgb3m1jGWsWAI0=;
        b=rBOkWbweBMczi1g9wxtO3J7Q0bcd2lrytPe9mBG39tLQSMkcxPqYlrNAMJ7mo/MDgua/Tw
        0QlHE21ZTY+hnHGZhHBSCRTWI6VwOuD29odgjiJn/N7HkZw4pI8ZV37737R9Sw+65Qzbno
        T1XJ/TXi9EIU6DN0VehMIQBsfvKewAA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C854913D41;
        Mon, 18 Oct 2021 12:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eQZkLidsbWH7RAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 12:44:23 +0000
Subject: Re: [PATCH v11 14/14] btrfs: send: enable support for stream v2 and
 compressed writes
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <61a4a5b6bf694c7441b2ba04b724d012997fa3f7.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <878b7f1f-a160-0b88-2048-37c64413ca3d@suse.com>
Date:   Mon, 18 Oct 2021 15:44:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <61a4a5b6bf694c7441b2ba04b724d012997fa3f7.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Now that the new support is implemented, allow the ioctl to accept the
> flags and update the version in sysfs.

This seems like an appropriate place to bring up the discussion about
versioned streams. SO instead of adding a BTRFS_SEND_FLAG_STREAM_V2
flag, which implies that for the next version we have to add
BTRFS_SEND_FLAG_STREAM_V3 etc. Why not generalize the flag to
BTRFS_SEND_FLAG_STREAM_VERSIONED and carve an u32 from one of the
reserved fields so that in the future we simply increment the version field?


> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/send.c            | 10 +++++++++-
>  fs/btrfs/send.h            |  2 +-
>  include/uapi/linux/btrfs.h |  4 +++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 0ba8dc3a9f56..90ca915fed78 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -671,7 +671,10 @@ static int send_header(struct send_ctx *sctx)
>  	struct btrfs_stream_header hdr;
>  
>  	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
> -	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
> +	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2)
> +		hdr.version = cpu_to_le32(2);
> +	else
> +		hdr.version = cpu_to_le32(1);
>  
>  	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
>  					&sctx->send_off);
> @@ -7466,6 +7469,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  		ret = -EINVAL;
>  		goto out;
>  	}
> +	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
> +	    !(arg->flags & BTRFS_SEND_FLAG_STREAM_V2)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
>  	sctx = kzalloc(sizeof(struct send_ctx), GFP_KERNEL);
>  	if (!sctx) {
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index 9f4f7b96b1eb..9c83e14a43b2 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -10,7 +10,7 @@
>  #include "ctree.h"
>  
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
> -#define BTRFS_SEND_STREAM_VERSION 1
> +#define BTRFS_SEND_STREAM_VERSION 2
>  
>  /*
>   * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 4f875f355e83..5c13e407982f 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -787,7 +787,9 @@ struct btrfs_ioctl_received_subvol_args {
>  #define BTRFS_SEND_FLAG_MASK \
>  	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
>  	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
> -	 BTRFS_SEND_FLAG_OMIT_END_CMD)
> +	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
> +	 BTRFS_SEND_FLAG_STREAM_V2 | \
> +	 BTRFS_SEND_FLAG_COMPRESSED)
>  
>  struct btrfs_ioctl_send_args {
>  	__s64 send_fd;			/* in */
> 
