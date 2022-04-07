Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9294F81B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiDGOeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbiDGOeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68D31A4D55;
        Thu,  7 Apr 2022 07:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4985161CC0;
        Thu,  7 Apr 2022 14:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DF6C385A0;
        Thu,  7 Apr 2022 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649341922;
        bh=1mo8AG4FIR1/02YpFR4zJU4OcpMYkIGir1YVgUBVtjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inxngaAvGk4ci4lL9D9ebkrGzcMpUuh0DxcHhPClkg9ctSXRjUR+WDfkTT1nVwwAt
         hTrjaa7ywrI4/z+Mzm+XFo7OKykHYTfaUGj9wY6tvuuVo5glndB2vBfM/6JZonyuAx
         us5csSm0foMRHB+fOnpT5tBy1jPaDO5maUHCK/jHcRUVWv2veIyZCSIvWSH3/Vly0Z
         WCZLy6y3URLTMcrRfaTGyhEWrYjAAMEMMcWdXEuMlADTwGpCHCb/gx9Ir3dgYHZiLg
         ouQpoqYiFYo4txOAeu9SJj2Jhc++HixksTam/lMcrGo9TaGLIFS002BA17+j2kcood
         8fQvGjtOcWTCg==
Date:   Thu, 7 Apr 2022 22:31:54 +0800
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
Subject: Re: [PATCH v8 18/20] erofs: implement fscache-based data read for
 inline layout
Message-ID: <Yk712oM2xrEUmbhZ@debian>
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
 <20220406075612.60298-19-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-19-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:10PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for inline layout.
> 
> For the heading non-inline part, the data plane for non-inline layout is
> reused, while only the tail packing part needs special handling.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 65de1c754e80..d32cb5840c6d 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -60,6 +60,40 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage_inline(struct folio *folio,
> +					 struct erofs_map_blocks *map)
> +{
> +	struct inode *inode = folio_file_mapping(folio)->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	erofs_blk_t blknr;
> +	size_t offset, len;
> +	void *src, *dst;
> +
> +	/*
> +	 * For inline (tail packing) layout, the offset may be non-zero, which
> +	 * can be calculated from corresponding physical address directly.
> +	 */
> +	offset = erofs_blkoff(map->m_pa);
> +	blknr = erofs_blknr(map->m_pa);
> +	len = map->m_llen;
> +
> +	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
> +	if (IS_ERR(src))
> +		return PTR_ERR(src);
> +
> +	DBG_BUGON(folio_size(folio) != PAGE_SIZE);
> +
> +	dst = kmap(folio_page(folio, 0));

kmap_local_folio?

> +	memcpy(dst, src + offset, len);
> +	memset(dst + len, 0, PAGE_SIZE - len);
> +	kunmap(folio_page(folio, 0));
> +
> +	erofs_put_metabuf(&buf);
> +
> +	return 0;
> +}
> +
>  static int erofs_fscache_readpage(struct file *file, struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> @@ -85,6 +119,12 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  		goto out_uptodate;
>  	}
>  
> +	/* inline readpage */

I think the code below is self-explained.

> +	if (map.m_flags & EROFS_MAP_META) {
> +		ret = erofs_fscache_readpage_inline(folio, &map);
> +		goto out_uptodate;
> +	}
> +
>  	/* no-inline readpage */

Same here.

Thanks,
Gao Xiang

>  	mdev = (struct erofs_map_dev) {
>  		.m_deviceid = map.m_deviceid,
> -- 
> 2.27.0
> 
