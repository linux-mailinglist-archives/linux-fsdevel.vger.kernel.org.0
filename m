Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC52CF440
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgLDSmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 13:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgLDSmQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:42:16 -0500
Date:   Fri, 4 Dec 2020 10:41:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607107295;
        bh=25oeJh7b6yTNs1uUjAz7FURgo0slNPpUweE8Jq1EW2U=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQJGYf8Sv9pjnoC8grlmknSQ7fK2DeQW3ZN4xj/sHziOSYiJYQgvgmY7naIbepwhj
         58MNntm9lXg1LjFRiUzFe3x5wvBUaZAyJ5BdbApGZyEe7dSwuffMMkO7YtshfTpdvr
         pRIXYQ/TVzPZwEz7drZlSGXoYQ+dBTbR7by6VGLscHXBsjpi/rVkRMp/Hf6ZjejDDY
         Ajqv47VBbzRMdg0zEV1xaZclxA4/apnHKrA9kkxTbtZfGiY738obJt0Jy9uuPW0s0k
         oMz1ZYOrs6PtW4cDPXi4sHJuVqePMCfTkdzPgaL6ZyCkRLabb2lxkS4ZwTE2Qtf1ed
         UA1xt6u5fWz/w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de
Subject: Re: [PATCH v14 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <X8qC3NaNv1kmCO4c@sol.localdomain>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
 <20201204154600.1546096-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204154600.1546096-5-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:45:54PM +0300, Konstantin Komarov wrote:
> +/* external compression lzx/xpress */
> +static int decompress_lzx_xpress(struct ntfs_sb_info *sbi, const char *cmpr,
> +				 size_t cmpr_size, void *unc, size_t unc_size,
> +				 u32 frame_size)
> +{
> +	int err;
> +	void *ctx;
> +
> +	if (cmpr_size == unc_size) {
> +		/* frame not compressed */
> +		memcpy(unc, cmpr, unc_size);
> +		return 0;
> +	}
> +
> +	err = 0;
> +	ctx = NULL;
> +	spin_lock(&sbi->compress.lock);
> +	if (frame_size == 0x8000) {
> +		/* LZX: frame compressed */
> +		if (!sbi->compress.lzx) {
> +			/* Lazy initialize lzx decompress context */
> +			spin_unlock(&sbi->compress.lock);
> +			ctx = lzx_allocate_decompressor(0x8000);
> +			if (!ctx)
> +				return -ENOMEM;
> +			if (IS_ERR(ctx)) {
> +				/* should never failed */
> +				err = PTR_ERR(ctx);
> +				goto out;
> +			}
> +
> +			spin_lock(&sbi->compress.lock);
> +			if (!sbi->compress.lzx) {
> +				sbi->compress.lzx = ctx;
> +				ctx = NULL;
> +			}
> +		}
> +
> +		if (lzx_decompress(sbi->compress.lzx, cmpr, cmpr_size, unc,
> +				   unc_size)) {
> +			err = -EINVAL;
> +		}
> +	} else {
> +		/* XPRESS: frame compressed */
> +		if (!sbi->compress.xpress) {
> +			/* Lazy initialize xpress decompress context */
> +			spin_unlock(&sbi->compress.lock);
> +			ctx = xpress_allocate_decompressor();
> +			if (!ctx)
> +				return -ENOMEM;
> +
> +			spin_lock(&sbi->compress.lock);
> +			if (!sbi->compress.xpress) {
> +				sbi->compress.xpress = ctx;
> +				ctx = NULL;
> +			}
> +		}
> +
> +		if (xpress_decompress(sbi->compress.xpress, cmpr, cmpr_size,
> +				      unc, unc_size)) {
> +			err = -EINVAL;
> +		}
> +	}
> +	spin_unlock(&sbi->compress.lock);
> +out:
> +	ntfs_free(ctx);
> +	return err;
> +}

Decompression is a somewhat heavyweight operation.  Not the type of thing that
should be done while holding a spin lock.

- Eric
