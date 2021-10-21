Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0143630B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhJUNfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 09:35:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhJUNfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:35:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 972D61FDB1;
        Thu, 21 Oct 2021 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634823181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPrqI71oBRVB+ASAfc1St2RUxc6i32toDb2Ovtt2Hjk=;
        b=V9y71gi5mZ2QpCixyhX5xdHNrlfm1o9O2htepANXMJakxiRjtJzW9hAv+upn7QGocgzPz3
        QfLPlH4OJT4KlkbolB8tul4NX/hJPk33wmu9hY84Z5VDBXXrlMTGW6e5NbO0RpYL1EBn8Y
        GDZyfa90xi3Id/AdRExWghUmEqRcOpo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A1F13BA5;
        Thu, 21 Oct 2021 13:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z5+JEQ1scWGkJQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 13:33:01 +0000
Subject: Re: [PATCH v11 05/10] btrfs-progs: receive: process encoded_write
 commands
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <a06e83a401e0f66725975016bf6e6a23d5c8ea3d.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <dff53e1a-9717-4b92-09c3-36127ed966d9@suse.com>
Date:   Thu, 21 Oct 2021 16:33:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a06e83a401e0f66725975016bf6e6a23d5c8ea3d.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <borisb@fb.com>
> 
<snip>

> +/* Data is not compressed. */
> +#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
> +/* Data is compressed as a single zlib stream. */
> +#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
> +/*
> + * Data is compressed as a single zstd frame with the windowLog compression
> + * parameter set to no more than 17.
> + */
> +#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
> +/*
> + * Data is compressed page by page (using the page size indicated by the name of
> + * the constant) with LZO1X and wrapped in the format documented in
> + * fs/btrfs/lzo.c. For writes, the compression page size must match the
> + * filesystem page size.
> + */
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
> +#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
> +#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8

nit: Make those an enum ? Same applies for the kernel counterpart patch.

> +
> +/* Data is not encrypted. */
> +#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
> +#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
> +
>  /* Error codes as returned by the kernel */
>  enum btrfs_err_code {
>  	notused,
> @@ -949,6 +1077,10 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
>  				struct btrfs_ioctl_ino_lookup_user_args)
>  #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
>  				   struct btrfs_ioctl_vol_args_v2)
> +#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
> +				    struct btrfs_ioctl_encoded_io_args)
> +#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
> +				     struct btrfs_ioctl_encoded_io_args)
>  
>  #ifdef __cplusplus
>  }
> 
