Return-Path: <linux-fsdevel+bounces-65672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8DC0C51F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9365D19A0EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF611E51EB;
	Mon, 27 Oct 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qAX/0326"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40881B040D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554039; cv=none; b=RnWqlBdVLhpJyGGaJb7BA01HR0AfsdXry6MAjx1n1Q3z4ZdkXK2EoniRtygSuKONkLm0ZV32shfvXD6x+jQW6gMgeWRXB2SwSU8tcL7gagOou3eyFUK6QR+1yAmo1Xr+gVvTENennAH7eg0yWxpoyPXynLFPqSvySA7atKuLgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554039; c=relaxed/simple;
	bh=ONYUxwLj6NLt0dbvoTmRpbt77e5fW9u6CzNNEKfbnAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1+SV+y2L9sx/NmGk2XE488+okEjT594fdBax0p8FhcVw5sk2Zl9nQjb7xqQue1GxrOnWQ4Pnl7gzUJ79sGigPts15rgo/pjxAHBHvYI3TG+OjqFsse2I2sydHKCKoIPJIotQ7RDMAUj6MGk6qsVeF7vXCDrat4lMKaAunkOjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qAX/0326; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761554034; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d3Bls5HH+ybxSPc0U9pigA/kPbOoHpfUV3O5m9VQ7UM=;
	b=qAX/0326EJovKrm4JbkMP0qX5fvqAC3Vp6LEa4TslXdQI+TU2WbTnTsBOSVXQOZmJUaG63z0EDvdt1tHmJgmJdRC9vihpq1b0TffY/eAYkGSdUSowJh8yoJe7q2VVg2Gr+sk9ZaAdUIU2gaiy5zeE64gg0mFDUwR0OJ1y6VNHks=
Received: from 30.221.128.238(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wr2ST4N_1761554033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 16:33:53 +0800
Message-ID: <518cc572-af28-414b-be1a-c69adce4b922@linux.alibaba.com>
Date: Mon, 27 Oct 2025 16:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] filemap: Add folio_next_pos()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@lists.linux.dev
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-2-willy@infradead.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251024170822.1427218-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/25 01:08, Matthew Wilcox (Oracle) wrote:
> Replace the open-coded implementation in ocfs2 (which loses the top
> 32 bits on 32-bit architectures) with a helper in pagemap.h.
> 
> Fixes: 35edec1d52c0 (ocfs2: update truncate handling of partial clusters)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/alloc.c        |  2 +-
>  include/linux/pagemap.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 162711cc5b20..b267ec580da9 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6892,7 +6892,7 @@ static void ocfs2_zero_cluster_folios(struct inode *inode, loff_t start,
>  		ocfs2_map_and_dirty_folio(inode, handle, from, to, folio, 1,
>  				&phys);
>  
> -		start = folio_next_index(folio) << PAGE_SHIFT;
> +		start = folio_next_pos(folio);
>  	}
>  out:
>  	if (folios)
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 09b581c1d878..e16576e3763a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -941,6 +941,17 @@ static inline pgoff_t folio_next_index(const struct folio *folio)
>  	return folio->index + folio_nr_pages(folio);
>  }
>  
> +/**
> + * folio_next_pos - Get the file position of the next folio.
> + * @folio: The current folio.
> + *
> + * Return: The position of the folio which follows this folio in the file.
> + */
> +static inline loff_t folio_next_pos(const struct folio *folio)
> +{
> +	return (loff_t)folio_next_index(folio) << PAGE_SHIFT;
> +}
> +
>  /**
>   * folio_file_page - The page for a particular index.
>   * @folio: The folio which contains this index.


