Return-Path: <linux-fsdevel+bounces-35178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F69D2117
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1021F216A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52D15748F;
	Tue, 19 Nov 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T91XDcUt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832E1EA90
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003195; cv=none; b=ogz7I+1cccn9lZGNMv0QX0RuwES562sC/5TMTW6IUT/GEazInxZ1yeZ0T23scetgavCAtTvw3UgKjPbg9ersrEbj6HjaMvYhRX/GDo4unmsZ7herBKBtbQjFXUlFBw/2s5llA9ST/d5sJbHowdvoH7tmvjCqT+WkN52zblOVvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003195; c=relaxed/simple;
	bh=tDmcsNW5eoKB/sc6cKTUOP9+VsP5fkY57RMsbopaNE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIW/do6594qZfT70PNWD8MNKx1K19/y8Od6A7F9s3NpMR9paxAZ5JW230olvFUzLxkehELINXr4qAhNUfGpSbyQDaiJd0fI9QfY31J2Y7nzLD5WGNLYmu1KxFjMGbDtvb5n1A/ftJOgpX4XzMbMGe+craDHQHBYAUkWbdbA1JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T91XDcUt; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732003185; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2uwBes63mJHUjyBEtDo6LVibDIhDGrZOK/V6jhMLb3g=;
	b=T91XDcUtiOHrpUN+RuDUySN9+tABiInUNskmR0tc7PUWsi0/872sEnaV7H6nsp6S5bo2oWhIG8SozzCnmnxsPe8OplB8kpU/k19yds/tyY0CkaxnzLCqiNlJQ4vmylw95Atvvqm0at+1h03Gy3N69Wj9obeKxPb/YKYP+Fj+kbo=
Received: from 30.221.144.210(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WJnYvtT_1732003183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 Nov 2024 15:59:45 +0800
Message-ID: <89aef56a-6d1b-449d-8fbc-94d305bae78c@linux.alibaba.com>
Date: Tue, 19 Nov 2024 15:59:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241115224459.427610-6-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/24 6:44 AM, Joanne Koong wrote:




> @@ -1838,7 +1748,7 @@ static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  
>  	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> -	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
> +	node_stat_sub_folio(folio, NR_WRITEBACK);

Now fuse_writepage_finish_stat() has only one caller and we could make
it embedded into its only caller.


>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> -					  struct folio *tmp_folio, uint32_t folio_index)
> +					  uint32_t folio_index)
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  
> -	folio_copy(tmp_folio, folio);
> -
> -	ap->folios[folio_index] = tmp_folio;
> +	ap->folios[folio_index] = folio;
>  	ap->descs[folio_index].offset = 0;
>  	ap->descs[folio_index].length = PAGE_SIZE;
>  
>  	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> -	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> +	node_stat_add_folio(folio, NR_WRITEBACK);

This inc NR_WRITEBACK counter along with the corresponding dec
NR_WRITEBACK counter in fuse_writepage_finish_stat() seems unnecessary,
as folio_start_writeback() will increase the NR_WRITEBACK counter, while
folio_end_writeback() will decrease the NR_WRITEBACK counter.





-- 
Thanks,
Jingbo

