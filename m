Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F2728345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjFHPK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjFHPK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:10:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DA2D72
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:10:11 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QcSHD4mbdzLqX3;
        Thu,  8 Jun 2023 23:07:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 23:10:06 +0800
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-5-willy@infradead.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <01518ef3-f963-ef25-abee-266cffa7ad28@huawei.com>
Date:   Thu, 8 Jun 2023 23:09:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230605165029.2908304-5-willy@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2023/6/6 0:50, Matthew Wilcox (Oracle) Ð´µÀ:

Hi
> Replace the call to SetPageError() with a call to mapping_set_error().
> Support large folios by using kmap_local_folio() and remapping each time
> we cross a page boundary.  Saves a lot of hidden calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/ubifs/file.c | 53 +++++++++++++++++++++++++++----------------------
>   1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index c0e68b3d7582..1b2055d5ec5f 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -900,60 +900,65 @@ static int ubifs_read_folio(struct file *file, struct folio *folio)
>   	return 0;
>   }
>   
> -static int do_writepage(struct page *page, int len)
> +static int do_writepage(struct folio *folio, size_t len)
>   {
>   	int err = 0, i, blen;
>   	unsigned int block;
>   	void *addr;
> +	size_t offset = 0;
>   	union ubifs_key key;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	struct ubifs_info *c = inode->i_sb->s_fs_info;
>   
>   #ifdef UBIFS_DEBUG
>   	struct ubifs_inode *ui = ubifs_inode(inode);
>   	spin_lock(&ui->ui_lock);
> -	ubifs_assert(c, page->index <= ui->synced_i_size >> PAGE_SHIFT);
> +	ubifs_assert(c, folio->index <= ui->synced_i_size >> PAGE_SHIFT);
>   	spin_unlock(&ui->ui_lock);
>   #endif
>   
> -	/* Update radix tree tags */
> -	set_page_writeback(page);
> +	folio_start_writeback(folio);
>   
> -	addr = kmap(page);
> -	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
> +	addr = kmap_local_folio(folio, offset);
> +	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
>   	i = 0;
> -	while (len) {
> -		blen = min_t(int, len, UBIFS_BLOCK_SIZE);
> +	for (;;) {
> +		blen = min_t(size_t, len, UBIFS_BLOCK_SIZE);
>   		data_key_init(c, &key, inode->i_ino, block);
>   		err = ubifs_jnl_write_data(c, inode, &key, addr, blen);
>   		if (err)
>   			break;
> -		if (++i >= UBIFS_BLOCKS_PER_PAGE)
> +		len -= blen;
> +		if (!len)
>   			break;
>   		block += 1;
>   		addr += blen;
> -		len -= blen;
> +		if (folio_test_highmem(folio) && !offset_in_page(addr)) {
> +			kunmap_local(addr - blen);
> +			offset += PAGE_SIZE;
> +			addr = kmap_local_folio(folio, offset);

I'm not sure whether it is a problem here, if we have a 64K PAGE_SIZE 
environment, UBIFS_BLOCK_SIZE is 4K. Given len is 64K, after one 
iteration, we might enter into this branch, ubifs has written 4K-size 
data, and offset becomes 64K, ubifs will write from page pos 64K rather 
4K in second iteration?

> +		} >   	}
> +	kunmap_local(addr);
>   	if (err) {
> -		SetPageError(page);
> -		ubifs_err(c, "cannot write page %lu of inode %lu, error %d",
> -			  page->index, inode->i_ino, err);
> +		mapping_set_error(folio->mapping, err);

I rhink we can add mapping_set_error in ubifs_writepage's error 
branch(eg, ->write_inode), just like I comment in patch 1.

> +		ubifs_err(c, "cannot write folio %lu of inode %lu, error %d",
> +			  folio->index, inode->i_ino, err);
>   		ubifs_ro_mode(c, err);
>   	}
>   
> -	ubifs_assert(c, PagePrivate(page));
> -	if (PageChecked(page))
> +	ubifs_assert(c, folio->private != NULL);
> +	if (folio_test_checked(folio))
>   		release_new_page_budget(c);
>   	else
>   		release_existing_page_budget(c);
>   
>   	atomic_long_dec(&c->dirty_pg_cnt);
> -	detach_page_private(page);
> -	ClearPageChecked(page);
> +	folio_detach_private(folio);
> +	folio_clear_checked(folio);
>   
> -	kunmap(page);
> -	unlock_page(page);
> -	end_page_writeback(page);
> +	folio_unlock(folio);
> +	folio_end_writeback(folio);
>   	return err;
>   }
>   
> @@ -1041,7 +1046,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
>   			 * with this.
>   			 */
>   		}
> -		return do_writepage(&folio->page, len);
> +		return do_writepage(folio, len);
>   	}
>   
>   	/*
> @@ -1060,7 +1065,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
>   			goto out_redirty;
>   	}
>   
> -	return do_writepage(&folio->page, len);
> +	return do_writepage(folio, len);
>   out_redirty:
>   	/*
>   	 * folio_redirty_for_writepage() won't call ubifs_dirty_inode() because
> @@ -1172,7 +1177,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
>   				if (UBIFS_BLOCKS_PER_PAGE_SHIFT)
>   					offset = offset_in_folio(folio,
>   							new_size);
> -				err = do_writepage(&folio->page, offset);
> +				err = do_writepage(folio, offset);
>   				folio_put(folio);
>   				if (err)
>   					goto out_budg;
> 

