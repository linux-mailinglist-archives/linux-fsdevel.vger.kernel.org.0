Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E749E057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiA0LMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 06:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiA0LMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:12:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ECBC061714;
        Thu, 27 Jan 2022 03:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55F3DB821EE;
        Thu, 27 Jan 2022 11:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0ECC340E4;
        Thu, 27 Jan 2022 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643281939;
        bh=V5HYgTWJFQ5JJsKuBtDbntq5jM8gqYnHqlB+WwVQUg0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qs+oygNUvOkZojCS4tbIHBbHNnN2c83jSwVTtC+PXReiKpUgTryV/Jn9i4kA11TCx
         wQIA8T/xXWysKr5FVnBsdp7s6T57gZuXoA8b+6AKW4GBWhPcMDiC878wFDfjGOUfSX
         5ddnmsg5pr+FfS6jpyfRuWWfH+qIetrTGJZM1PAYwXCjUJyQB7D1Wcs5o++QKht+ze
         N6Qaj6XKvoxOKPWxiTmKIzgNkaDO61bAS7aaPRXf+qfG+7pz/a1932PlgtYdjIokd4
         zXshthMZgvLd9Pe0iKyNgu1FzP9P91fWoKA6y5OydLOCZNYRF9sJ2Iz0TLFNBDx5FN
         vYRqTrnWEMhKw==
Message-ID: <2e66ef3e8f5df0529d3c289f8ed0be6a051d95ea.camel@kernel.org>
Subject: Re: [PATCH 5/9] cephfs: don't set/clear bdi_congestion
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 27 Jan 2022 06:12:15 -0500
In-Reply-To: <164325158958.29787.8840004338500709466.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
         <164325158958.29787.8840004338500709466.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-01-27 at 13:46 +1100, NeilBrown wrote:
> The bdi congestion framework is no-longer used - writeback uses other
> mechanisms to manage throughput.
> 
> So remove calls to set_bdi_congested() and clear_bdi_congested(), and
> remove the writeback_count which is used only to guide the setting and
> clearing.
> 
> The congestion_kb mount option is no longer meaningful, but as it is
> visible to user-space, removing it needs more consideration.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/ceph/addr.c  |   27 ---------------------------
>  fs/ceph/super.c |    2 --
>  fs/ceph/super.h |    2 --
>  3 files changed, 31 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c98e5238a1b6..9147667f8cd5 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -57,11 +57,6 @@
>   * accounting is preserved.
>   */
>  
> -#define CONGESTION_ON_THRESH(congestion_kb) (congestion_kb >> (PAGE_SHIFT-10))
> -#define CONGESTION_OFF_THRESH(congestion_kb)				\
> -	(CONGESTION_ON_THRESH(congestion_kb) -				\
> -	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
> -
>  static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
>  					struct folio *folio, void **_fsdata);
>  
> @@ -561,10 +556,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
>  	     inode, page, page->index, page_off, len, snapc, snapc->seq);
>  
> -	if (atomic_long_inc_return(&fsc->writeback_count) >
> -	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
> -		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
> -
>  	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode), page_off, &len, 0, 1,
>  				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE, snapc,
>  				    ceph_wbc.truncate_seq, ceph_wbc.truncate_size,
> @@ -621,10 +612,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>  	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
>  	ceph_put_snap_context(snapc);  /* page's reference */
>  
> -	if (atomic_long_dec_return(&fsc->writeback_count) <
> -	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
> -		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
> -
>  	return err;
>  }
>  
> @@ -704,12 +691,6 @@ static void writepages_finish(struct ceph_osd_request *req)
>  			BUG_ON(!page);
>  			WARN_ON(!PageUptodate(page));
>  
> -			if (atomic_long_dec_return(&fsc->writeback_count) <
> -			     CONGESTION_OFF_THRESH(
> -					fsc->mount_options->congestion_kb))
> -				clear_bdi_congested(inode_to_bdi(inode),
> -						    BLK_RW_ASYNC);
> -
>  			ceph_put_snap_context(detach_page_private(page));
>  			end_page_writeback(page);
>  			dout("unlocking %p\n", page);
> @@ -952,14 +933,6 @@ static int ceph_writepages_start(struct address_space *mapping,
>  			dout("%p will write page %p idx %lu\n",
>  			     inode, page, page->index);
>  
> -			if (atomic_long_inc_return(&fsc->writeback_count) >
> -			    CONGESTION_ON_THRESH(
> -				    fsc->mount_options->congestion_kb)) {
> -				set_bdi_congested(inode_to_bdi(inode),
> -						  BLK_RW_ASYNC);
> -			}
> -
> -
>  			pages[locked_pages++] = page;
>  			pvec.pages[i] = NULL;
>  
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index bf79f369aec6..b2f38af9fca8 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -801,8 +801,6 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
>  	fsc->filp_gen = 1;
>  	fsc->have_copy_from2 = true;
>  
> -	atomic_long_set(&fsc->writeback_count, 0);
> -
>  	err = -ENOMEM;
>  	/*
>  	 * The number of concurrent works can be high but they don't need
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 67f145e1ae7a..fc58adf1d36a 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -120,8 +120,6 @@ struct ceph_fs_client {
>  
>  	struct ceph_mds_client *mdsc;
>  
> -	atomic_long_t writeback_count;
> -
>  	struct workqueue_struct *inode_wq;
>  	struct workqueue_struct *cap_wq;
>  
> 
> 

Thanks Neil.

I'll plan to pull this into the ceph testing branch and do some testing
with it, but at a quick glance I don't forsee any issues. This should
make v5.18, but we may be able to get it in sooner.
-- 
Jeff Layton <jlayton@kernel.org>
