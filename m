Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D585143225F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhJRPO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:14:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhJRPOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:14:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D285921976;
        Mon, 18 Oct 2021 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634569915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwyDdigqEdyFnQWv95tqpblmK7gEFiPJmdvE8htyh14=;
        b=JYOQyvktmAUYexlAjd7Ilv46uxJ6tTzL5UUjS2p3e/wPRUiGrBP60Q7QrxevMCPn//6tio
        j3PRlGuUAWjDeuUVI4IPnr2D1nQe7Ux6Xvhk8imAgC4hajr+v3ai6cE6CSGsbJrdSJOJUG
        ECwYzqpARNCjUECeiw3LT+H4Axf8p3o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8843C13CC9;
        Mon, 18 Oct 2021 15:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QkOrHruObWEfFgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Oct 2021 15:11:55 +0000
Subject: Re: [PATCH v11 10/14] btrfs: add send stream v2 definitions
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f94e2e0d-0cf9-1c9d-0dfb-b21438fe852d@suse.com>
Date:   Mon, 18 Oct 2021 18:11:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds the definitions of the new commands for send stream version 2
> and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> chattr), and encoded writes. It also documents two changes to the send
> stream format in v2: the receiver shouldn't assume a maximum command
> size, and the DATA attribute is encoded differently to allow for writes
> larger than 64k. These will be implemented in subsequent changes, and
> then the ioctl will accept the new flags.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/send.c            |  2 +-
>  fs/btrfs/send.h            | 30 +++++++++++++++++++++++++++++-
>  include/uapi/linux/btrfs.h | 13 +++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index afdcbe7844e0..2ec07943f173 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -7287,7 +7287,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>  
>  	sctx->clone_roots_cnt = arg->clone_sources_count;
>  
> -	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
> +	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
>  	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
>  	if (!sctx->send_buf) {
>  		ret = -ENOMEM;
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index de91488b7cd0..9f4f7b96b1eb 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -12,7 +12,11 @@
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>  #define BTRFS_SEND_STREAM_VERSION 1
>  
> -#define BTRFS_SEND_BUF_SIZE SZ_64K
> +/*
> + * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> + * should be assumed.
> + */
> +#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
>  
>  enum btrfs_tlv_type {
>  	BTRFS_TLV_U8,
> @@ -76,6 +80,13 @@ enum btrfs_send_cmd {
>  
>  	BTRFS_SEND_C_END,
>  	BTRFS_SEND_C_UPDATE_EXTENT,
> +
> +	/* The following commands were added in send stream v2. */
> +
> +	BTRFS_SEND_C_FALLOCATE,
> +	BTRFS_SEND_C_SETFLAGS,
> +	BTRFS_SEND_C_ENCODED_WRITE,
> +
>  	__BTRFS_SEND_C_MAX,
>  };
>  #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
> @@ -106,6 +117,11 @@ enum {
>  	BTRFS_SEND_A_PATH_LINK,
>  
>  	BTRFS_SEND_A_FILE_OFFSET,
> +	/*
> +	 * In send stream v2, this attribute is special: it must be the last
> +	 * attribute in a command, its header contains only the type, and its
> +	 * length is implicitly the remaining length of the command.
> +	 */
>  	BTRFS_SEND_A_DATA,

Now that I think more about this, it would be best if this logic is
actually codified in the code. I.e first set of SEND_A_DATA would set
some bool/flag in the sctx and subsequent calls would be able to
ASSERT/WARN ?


