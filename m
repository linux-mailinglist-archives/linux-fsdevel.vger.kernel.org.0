Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03A33CEEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhCPHzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 03:55:53 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:52268 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhCPHzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:55:47 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E55839DF127;
        Tue, 16 Mar 2021 08:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1615881343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aijw2piyTmWM3nPGPTDspc29jfHo5VHmK9SZOCF9d0=;
        b=K9+37aRpuHWW4fVZ7yU5SmEWRvaEB9lUwp3U6V4rw+tMUc0reE4W/8D4d3q9AJTY/JIiHA
        NC7kUx81dp63noj/gQnJA0ZblP/D0DVWiT86wAzSZO1ea+hl3fPTdKyPyYXULfKQ4NcU+f
        h78ZQIkejrSaLUbcSznxBaDNLsbvIiU=
Date:   Tue, 16 Mar 2021 08:55:42 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v23 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210316075542.z33ekalae7hgpfjc@spock.localdomain>
References: <20210315144414.3365314-1-almaz.alexandrovich@paragon-software.com>
 <20210315144414.3365314-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315144414.3365314-3-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

On Mon, Mar 15, 2021 at 05:44:06PM +0300, Konstantin Komarov wrote:
> This adds initialization of super block
>
> ...SNIP...
> 
> +
> +/*
> + * Helper for ntfs_loadlog_and_replay
> + * fill on-disk logfile range by (-1)
> + * this means empty logfile
> + */
> +int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
> +{
> +	int err = 0;
> +	struct super_block *sb = sbi->sb;
> +	struct block_device *bdev = sb->s_bdev;
> +	u8 cluster_bits = sbi->cluster_bits;
> +	struct bio *new, *bio = NULL;
> +	CLST lcn, clen;
> +	u64 lbo, len;
> +	size_t run_idx;
> +	struct page *fill;
> +	void *kaddr;
> +	struct blk_plug plug;
> +
> +	fill = alloc_page(GFP_KERNEL);
> +	if (!fill)
> +		return -ENOMEM;
> +
> +	kaddr = kmap_atomic(fill);
> +	memset(kaddr, -1, PAGE_SIZE);
> +	kunmap_atomic(kaddr);
> +	flush_dcache_page(fill);
> +	lock_page(fill);
> +
> +	if (!run_lookup_entry(run, 0, &lcn, &clen, &run_idx)) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	/*
> +	 * TODO: try blkdev_issue_write_same
> +	 */
> +	blk_start_plug(&plug);
> +	do {
> +		lbo = (u64)lcn << cluster_bits;
> +		len = (u64)clen << cluster_bits;
> +new_bio:
> +		new = ntfs_alloc_bio(BIO_MAX_PAGES);
                             ^^^^^^^^^^^^^
this was renamed to BIO_MAX_VECS recently.

> +		if (!new) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +		if (bio) {
> +			bio_chain(bio, new);
> +			submit_bio(bio);
> +		}
> +		bio = new;
> +		bio_set_dev(bio, bdev);
> +		bio->bi_opf = REQ_OP_WRITE;
> +		bio->bi_iter.bi_sector = lbo >> 9;
> +
> +		for (;;) {
> +			u32 add = len > PAGE_SIZE ? PAGE_SIZE : len;
> +
> +			if (bio_add_page(bio, fill, add, 0) < add)
> +				goto new_bio;
> +
> +			lbo += add;
> +			if (len <= add)
> +				break;
> +			len -= add;
> +		}
> +	} while (run_get_entry(run, ++run_idx, NULL, &lcn, &clen));
> +
> +	if (bio) {
> +		if (!err)
> +			err = submit_bio_wait(bio);
> +		bio_put(bio);
> +	}
> +	blk_finish_plug(&plug);
> +out:
> +	unlock_page(fill);
> +	put_page(fill);
> +
> +	return err;
> +}
>
> ...SNIP...
>

-- 
  Oleksandr Natalenko (post-factum)
