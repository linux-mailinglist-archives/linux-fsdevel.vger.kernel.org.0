Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0913492D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgAHRVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:21:39 -0500
Received: from verein.lst.de ([213.95.11.211]:50368 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgAHRVi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:21:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B37DB68BFE; Wed,  8 Jan 2020 18:21:35 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:21:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 02/13] exfat: add super block operations
Message-ID: <20200108172135.GC13388@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082401epcas1p2f33f3c11ecedabff2165ba216854d8fe@epcas1p2.samsung.com> <20200102082036.29643-3-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-3-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good, modulo a few nitpicks below:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Thu, Jan 02, 2020 at 04:20:25PM +0800, Namjae Jeon wrote:
> +static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	struct super_block *sb = dentry->d_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	unsigned long long id = huge_encode_dev(sb->s_bdev->bd_dev);

> +	if (sbi->used_clusters == ~0u) {

Various other places use UINT_MAX here instead.  Maybe it makes sense
to add a EXFAT_CLUSTERS_UNTRACKED or similar define and use that in all
places?

> +	if ((new_flag == VOL_DIRTY) && (!buffer_dirty(sbi->pbr_bh)))

No need for both sets of inner braces.

> +static bool is_exfat(struct pbr *pbr)
> +{
> +	int i = MUST_BE_ZERO_LEN;
> +
> +	do {
> +		if (pbr->bpb.f64.res_zero[i - 1])
> +			break;
> +	} while (--i);
> +	return i ? false : true;
> +}

I find the MUST_BE_ZERO_LEN a little weird here.  Maybe that should
be something like PBP64_RESERVED_LEN?

Also I think this could be simplified by just using memchr_inv in the
caller

	if (memchr_inv(pbr->bpb.f64.res_zero, 0,
			sizeof(pbr->bpb.f64.res_zero)))
		ret = -EINVAL;
		goto free_bh;
	}

> +	/* set maximum file size for exFAT */
> +	sb->s_maxbytes = 0x7fffffffffffffffLL;

That this is setting the max size is pretty obvious.  Maybe the comment
should be updated to mention how this max file size is calculated?
