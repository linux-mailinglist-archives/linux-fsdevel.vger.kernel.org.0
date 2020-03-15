Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755E1185EA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgCORQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 13:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbgCORQy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:16:54 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC567206E9;
        Sun, 15 Mar 2020 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584292614;
        bh=+lmpvdxUBRgyrzSD7k7JSLFEM42g3oWA97s0+PhrLF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fz8xheLuuQR+wB/DfIa8fMDHBJ96eTBl6qoUQEPumGFkmN+p2eeRitOsIvPQcwEWX
         sRdvJhFc0FfCr/6CNrztD5Ta/DRrUiu5/aYHe+U70wAB9I8f7fFCSoPsWq5PyGQl0F
         bbS551kFvD0b5ZrLw8+8RdX4rlEDR7PjNypkYRrs=
Date:   Sun, 15 Mar 2020 10:16:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 10/11] f2fs: add inline encryption support
Message-ID: <20200315171652.GA1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-11-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-11-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:52AM -0700, Satya Tangirala wrote:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5355be6b6755..75817f0dc6f8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -139,6 +139,9 @@ struct f2fs_mount_info {
>  	int alloc_mode;			/* segment allocation policy */
>  	int fsync_mode;			/* fsync policy */
>  	bool test_dummy_encryption;	/* test dummy encryption */
> +#ifdef CONFIG_FS_ENCRYPTION
> +	bool inlinecrypt;		/* inline encryption enabled */
> +#endif
>  	block_t unusable_cap;		/* Amount of space allowed to be
>  					 * unusable when disabling checkpoint
>  					 */

This bool is unused now.

> @@ -1568,6 +1577,9 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
>  	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
> +#ifdef CONFIG_FS_ENCRYPTION
> +	sbi->sb->s_flags &= ~SB_INLINECRYPT;
> +#endif

This really should be CONFIG_FS_ENCRYPTION_INLINE_CRYPT, but actually there's no
need for the #ifdef at all.  Just clear the flag unconditionally.

- Eric
