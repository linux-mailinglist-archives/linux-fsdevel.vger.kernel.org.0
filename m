Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93751349FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgAHSAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:00:43 -0500
Received: from verein.lst.de ([213.95.11.211]:50548 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgAHSAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:00:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E89868BFE; Wed,  8 Jan 2020 19:00:40 +0100 (CET)
Date:   Wed, 8 Jan 2020 19:00:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 06/13] exfat: add exfat entry operations
Message-ID: <20200108180040.GB14650@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082404epcas1p4a28c34799df317165ddf8bd5a0b433e9@epcas1p4.samsung.com> <20200102082036.29643-7-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-7-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +int exfat_ent_get(struct super_block *sb, unsigned int loc,
> +		unsigned int *content)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	int err;
> +
> +	if (!is_valid_cluster(sbi, loc)) {
> +		exfat_fs_error(sb, "invalid access to FAT (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	err = __exfat_ent_get(sb, loc, content);
> +	if (err) {
> +		exfat_fs_error(sb,
> +			"failed to access to FAT (entry 0x%08x, err:%d)",
> +			loc, err);
> +		return err;
> +	}
> +
> +	if (!is_reserved_cluster(*content) &&
> +			!is_valid_cluster(sbi, *content)) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
> +			loc, *content);
> +		return -EIO;
> +	}
> +
> +	if (*content == EXFAT_FREE_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT free cluster (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	if (*content == EXFAT_BAD_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT bad cluster (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +	return 0;

Maybe these explicit checks should move up, and then is_reserved_cluster
can be replaced with an explicit check just for EXFAT_EOF_CLUSTER?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
