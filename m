Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9716F64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEHDCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 23:02:32 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:58118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHDCc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 23:02:32 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id C58DAE8031A6EC7146F9;
        Wed,  8 May 2019 11:02:29 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 8 May 2019 11:02:29 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 May 2019 11:02:28 +0800
Subject: Re: [RFC PATCH 4/4] f2fs: Wire up f2fs to use inline encryption via
 fscrypt
To:     Satya Tangirala <satyat@google.com>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-5-satyat@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <18ff678e-81eb-c883-eeb0-500c886f3580@huawei.com>
Date:   Wed, 8 May 2019 11:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-5-satyat@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

+Cc f2fs mailing list.

On 2019/5/7 6:35, Satya Tangirala wrote:
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/f2fs/data.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++---
>  fs/f2fs/super.c |  1 +
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9727944139f2..7ac6768a52a5 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -279,9 +279,18 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>  	return bio;
>  }
>  
> +static inline u64 hw_crypt_dun(struct inode *inode, struct page *page)
> +{
> +	return (((u64)inode->i_ino) << 32) | (page->index & 0xFFFFFFFF);
> +}
> +
>  static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  				struct bio *bio, enum page_type type)
>  {
> +	struct page *page;
> +	struct inode *inode;
> +	int err = 0;
> +
>  	if (!is_read_io(bio_op(bio))) {
>  		unsigned int start;
>  
> @@ -323,7 +332,21 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
>  	else
>  		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
> -	submit_bio(bio);
> +
> +	if (bio_has_data(bio)) {
> +		page = bio_page(bio);
> +		if (page && page->mapping && page->mapping->host) {
> +			inode = page->mapping->host;
> +			err = fscrypt_set_bio_crypt_ctx(inode, bio,

Should sanity check in fscrypt_set_bio_crypt_ctx() be necessary? as we have
already did the check in fscrypt_get_encryption_info().

If it's not necessary, we can relax to not care about the error handling.

> +						hw_crypt_dun(inode, page));
> +		}
> +	}
> +	if (err) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +	} else {
> +		submit_bio(bio);
> +	}
>  }
>  
>  static void __submit_merged_bio(struct f2fs_bio_info *io)
> @@ -484,6 +507,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
>  	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>  	struct page *bio_page;
> +	struct inode *fio_inode, *bio_inode;
> +	struct page *first_page;
> +	u64 next_dun = 0;
>  
>  	f2fs_bug_on(sbi, is_read_io(fio->op));
>  
> @@ -512,10 +538,29 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  
>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>  
> +	fio_inode = fio->page->mapping->host;
> +	bio_inode = NULL;
> +	first_page = NULL;
> +	next_dun = 0;
> +	if (io->bio) {
> +		first_page = bio_page(io->bio);
> +		if (first_page->mapping) {
> +			bio_inode = first_page->mapping->host;
> +			if (fscrypt_inode_is_hw_encrypted(bio_inode)) {
> +				next_dun =
> +					hw_crypt_dun(bio_inode, first_page) +
> +				    (io->bio->bi_iter.bi_size >> PAGE_SHIFT);
> +			}
> +		}
> +	}
>  	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
>  	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
> -			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
> +			!__same_bdev(sbi, fio->new_blkaddr, io->bio) ||
> +			!fscrypt_inode_crypt_mergeable(bio_inode, fio_inode) ||
> +			(fscrypt_inode_is_hw_encrypted(bio_inode) &&
> +			 next_dun != hw_crypt_dun(fio_inode, fio->page))))

The merge condition becomes so complicated and looks not so clean, I just
suggest we can introduce single static inline function to wrap all inline
encryption condition, which can help to make codes more clean.

>  		__submit_merged_bio(io);
> +
>  alloc_new:
>  	if (io->bio == NULL) {
>  		if ((fio->type == DATA || fio->type == NODE) &&
> @@ -570,7 +615,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  	bio->bi_end_io = f2fs_read_end_io;
>  	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
>  
> -	if (f2fs_encrypted_file(inode))
> +	if (f2fs_encrypted_file(inode) && !fscrypt_inode_is_hw_encrypted(inode))
>  		post_read_steps |= 1 << STEP_DECRYPT;
>  	if (post_read_steps) {
>  		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
> @@ -1525,6 +1570,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  	sector_t last_block_in_file;
>  	sector_t block_nr;
>  	struct f2fs_map_blocks map;
> +	u64 next_dun = 0;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
> @@ -1606,6 +1652,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  			__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  			bio = NULL;
>  		}
> +
> +		if (bio && fscrypt_inode_is_hw_encrypted(inode) &&
> +		    next_dun != hw_crypt_dun(inode, page)) {
> +			__submit_bio(F2FS_I_SB(inode), bio, DATA);
> +			bio = NULL;
> +		}
> +
>  		if (bio == NULL) {
>  			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
>  					is_readahead ? REQ_RAHEAD : 0);
> @@ -1624,6 +1677,9 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>  			goto submit_and_realloc;
>  
> +		if (fscrypt_inode_is_hw_encrypted(inode))
> +			next_dun = hw_crypt_dun(inode, page) + 1;
> +
>  		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>  		ClearPageError(page);
>  		last_block_in_bio = block_nr;
> @@ -2591,12 +2647,19 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  {
>  	struct f2fs_private_dio *dio;
>  	bool write = (bio_op(bio) == REQ_OP_WRITE);
> +	u64 data_unit_num = (((u64)inode->i_ino) << 32) |
> +			    ((file_offset >> PAGE_SHIFT) & 0xFFFFFFFF);

Can we allow hw_crypt_dun() to accept @offset as parameter instead of @page? so
we can use hw_crypt_dun() here to replace raw codes.

Thanks,

>  
>  	dio = f2fs_kzalloc(F2FS_I_SB(inode),
>  			sizeof(struct f2fs_private_dio), GFP_NOFS);
>  	if (!dio)
>  		goto out;
>  
> +	if (fscrypt_set_bio_crypt_ctx(inode, bio, data_unit_num) != 0) {
> +		kvfree(dio);
> +		goto out;
> +	}
> +
>  	dio->inode = inode;
>  	dio->orig_end_io = bio->bi_end_io;
>  	dio->orig_private = bio->bi_private;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f2aaa2cc6b3e..e98c85d42e8d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2225,6 +2225,7 @@ static const struct fscrypt_operations f2fs_cryptops = {
>  	.dummy_context	= f2fs_dummy_context,
>  	.empty_dir	= f2fs_empty_dir,
>  	.max_namelen	= F2FS_NAME_LEN,
> +	.hw_crypt_supp	= true,
>  };
>  #endif
>  
> 
