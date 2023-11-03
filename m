Return-Path: <linux-fsdevel+bounces-1915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2A7E02D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BADBB21395
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C62168AB;
	Fri,  3 Nov 2023 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cD5iKM/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAB1549C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 12:28:57 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3161B2;
	Fri,  3 Nov 2023 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a77meOT79I7dsPYCFbUcAK9S3K/ZvqB8pXsH6tW8Eq8=; b=cD5iKM/B6l25pNkN82s2dlw0zo
	2JuheD/f34EG4MV2LGnlMzHIBWbW+dvhH3ikgmnDuwj812/djsSe/ZDt03LwgJJZ1/DBWMYAwf9/P
	djFt50UfGn0D9q5o81C2B9/5kJHlU8d+WWH+UL/EIxODhmO8e0EZeeWZYZRKS84230nuufL8PD5LH
	tl/0Lqf1KHEPNn69kV705BodIWmWmerpZtPeb9YbM3YCL7QzXXgC48Qle84woCcv60Dqt4uiwrNQ8
	u5bGqSpKVseETjeTyLB4nAKnzRvSdTM7+Kx5rigI4sCjGhkGJa90SXMkA00ZYKltV8uIJj8vz4+u/
	Zyf435Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qytI7-005Lgd-4u; Fri, 03 Nov 2023 12:28:47 +0000
Date: Fri, 3 Nov 2023 12:28:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] fs/proc/page: use a folio in stable_page_flags()
Message-ID: <ZUTnf/hnbPqI9HSB@casper.infradead.org>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
 <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103072906.2000381-5-wangkefeng.wang@huawei.com>

On Fri, Nov 03, 2023 at 03:29:05PM +0800, Kefeng Wang wrote:
> Replace ten compound_head() calls with one page_folio().

This is going to conflict with Gregory Price's work:

https://lore.kernel.org/linux-mm/ZUCD1dsbrFjdZgVv@memverge.com/

Perhaps the two of you can collaborate on a patch series?

>  	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
> -	if (PageTail(page) && PageSlab(page))
> +	if (PageTail(page) && folio_test_slab(folio))
>  		u |= 1 << KPF_SLAB;

This doesn't make sense ...

