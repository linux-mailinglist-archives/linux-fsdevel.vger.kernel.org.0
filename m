Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28A4F818B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiDGO1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiDGO1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C33189A03;
        Thu,  7 Apr 2022 07:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D015561C65;
        Thu,  7 Apr 2022 14:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C17C385A4;
        Thu,  7 Apr 2022 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649341455;
        bh=w14ZPYdK01Rmbqc8luZ4J6X6VeW7r2KK5+F7YTyBwz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAywI+GpgGL/Hf8yI/GiNlm9V0dtjIj9Bvl5Gu4n2WRg/h7qkd/wJYaCSqlt9cqQe
         fmNv865oCZado3Q6vyk2+lOqad6zUlSl/UsBVWG0hNDkQvL4wDTOrnXozI8fHJggof
         rs1HdivX/eU+DNFyI7xMA/CKAls9YF/shkA24ZcFnDaOTQOtB3RLxQHyvsUNMLoq2Z
         l5djZGerUM2bENo/OBKaLrS8agNtgFPak3QAFtgFBUHj5QJmaVTySEvpWKXKVdUwkr
         D28tWH1kajSkzEUI+goASr/y2KNmCtXje9f+geWHPshF6yubJii+Gb9xHwC3PJ7N5Z
         BgMvOFK3AWovA==
Date:   Thu, 7 Apr 2022 22:24:05 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 17/20] erofs: implement fscache-based data read for
 non-inline layout
Message-ID: <Yk70BTzzoaOvET5c@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-18-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-18-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:09PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for non-inline layout.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  5 +++++
>  fs/erofs/internal.h |  2 ++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 158cc273f8fb..65de1c754e80 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -60,10 +60,62 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage(struct file *file, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct inode *inode = folio_file_mapping(folio)->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_map_blocks map;
> +	struct erofs_map_dev mdev;
> +	erofs_off_t pos;
> +	loff_t pstart;
> +	int ret = 0;
> +
> +	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
> +
> +	pos = folio_pos(folio);
> +	map.m_la = pos;
> +
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		folio_zero_range(folio, 0, folio_size(folio));
> +		goto out_uptodate;
> +	}
> +
> +	/* no-inline readpage */
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map.m_deviceid,
> +		.m_pa = map.m_pa,
> +	};
> +
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	pstart = mdev.m_pa + (pos - map.m_la);
> +	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> +			folio_file_mapping(folio), folio_pos(folio),
> +			folio_size(folio), pstart);
> +
> +out_uptodate:
> +	if (!ret)
> +		folio_mark_uptodate(folio);
> +out_unlock:
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  	.readpage = erofs_fscache_meta_readpage,
>  };
>  
> +const struct address_space_operations erofs_fscache_access_aops = {
> +	.readpage = erofs_fscache_readpage,
> +};
> +
>  /*
>   * Get the page cache of data blob at the index offset.
>   * Return: up to date page on success, ERR_PTR() on failure.
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..88b51b5fb53f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -296,7 +296,12 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  		err = z_erofs_fill_inode(inode);
>  		goto out_unlock;
>  	}
> +

unnecessary modification.

Otherwise looks good:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +	if (erofs_is_fscache_mode(inode->i_sb))
> +		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> +#endif
>  
>  out_unlock:
>  	erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index e186051f0640..336d19647c96 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -642,6 +642,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  
>  struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index);
> +
> +extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> -- 
> 2.27.0
> 
