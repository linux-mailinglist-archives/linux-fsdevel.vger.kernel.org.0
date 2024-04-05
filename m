Return-Path: <linux-fsdevel+bounces-16225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8218F89A4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17647281636
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51E172BC9;
	Fri,  5 Apr 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y89oozBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18345172BBC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345018; cv=none; b=j943iirCqpsDsw1cG0zfAkwQIF4SRib55ssftDrCgxsY+A+Ug7aqLT14HGBMg5upoWzxLg657J6/vEklA8VD1J9e7oEzrX769yq50dAf7jXQn4Kd0PSx9+zfMEVHqoQwBnx2CW9E+JIE+jy+rV1q0YNWW5K1G3pCc9qokLsKqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345018; c=relaxed/simple;
	bh=nkqHwe55YJ9zTx4pJGKNQXEgxCDOoQOns9N0daTk1J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv4yjE1TPTv9GGWIYi3vnJCGzLxVUgpz2/qR5N/h127Ow2IrsHaAFomsr+COAa0GCI88pnvvzrv7T7+fNs8Nqj7YG9MQ86+O4/nazN3Vd10SazRDStv91eMsxuCUL0kIxYU8u7ozNT90dGxGwG0m8mKzRrdhgCDKvHKIN8wTRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y89oozBU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O035s/ElEy1jmyHtvDTa4n9h4zo4uhAS6t7qctQ3LN4=; b=Y89oozBUAFlVaUbPlFxR+YbiIF
	/QsP4lJDJBplRp4KCjrr9paGPpSobgMKEQG8cBs5KVt9HwLJRdQS1DOsDjcGSjZd+1Px9hZMN9eBw
	zLoDsSbUr+WRvyBwt8HAbDZQOfIQq3ddqO7XLXFJtkjV7Df0+LW5sgbaGqv9K5VjCUXA/47ksoW/s
	GIb9aovGCwog9KFjZ2Q5pm6mVYq9pvsAsRzoM4dStUMSwVLUTJu6pi8OG64d8IW0jy1riam8oLyU1
	A2VOhXEjAZz8kyv2zVw2kGKODJc4LLxAf2lC4TFI7wt2hevCd3JDx0jddoEwtpba9Y0kC7WkIoRJ8
	K4Jpduxw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsp9w-0000000B7qg-1i0v;
	Fri, 05 Apr 2024 19:23:32 +0000
Date: Fri, 5 Apr 2024 20:23:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [FIX] proc: rewrite stable_page_flags()
Message-ID: <ZhBPtCYfSuFuUMEz@casper.infradead.org>
References: <1a6dc6a5-b5b6-494c-b94b-f6655da51bb9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6dc6a5-b5b6-494c-b94b-f6655da51bb9@moroto.mountain>

On Wed, Apr 03, 2024 at 12:01:35PM +0300, Dan Carpenter wrote:
> Hello Matthew Wilcox (Oracle),
> 
> Commit ea1be2228bb6 ("proc: rewrite stable_page_flags()") from Mar
> 26, 2024 (linux-next), leads to the following Smatch static checker
> warning:
> 
> fs/proc/page.c:156 stable_page_flags() warn: bit shifter 'PG_lru' used for logical '&'
> fs/proc/page.c:207 stable_page_flags() warn: bit shifter 'KPF_HUGE' used for logical '&'

Thanks.  I thought I sent this out on Tuesday, but it doesn't seem to
have left my machine.  Andrew, can you add this -fix patch?

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 5bc82828c6aa..55b01535eb22 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -175,6 +175,8 @@ u64 stable_page_flags(const struct page *page)
 		u |= 1 << KPF_OFFLINE;
 	if (PageTable(page))
 		u |= 1 << KPF_PGTABLE;
+	if (folio_test_slab(folio))
+		u |= 1 << KPF_SLAB;
 
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
@@ -184,7 +186,6 @@ u64 stable_page_flags(const struct page *page)
 #endif
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index 1d3a90d93fe2..270c28a0d098 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -146,12 +146,11 @@ def detect_kernel_config():
 
 
 def for_each_slab(prog):
-    PGSlab = 1 << prog.constant('PG_slab')
-    PGHead = 1 << prog.constant('PG_head')
+    PGSlab = ~prog.constant('PG_slab')
 
     for page in for_each_page(prog):
         try:
-            if page.flags.value_() & PGSlab:
+            if page.page_type.value_() == PGSlab:
                 yield cast('struct slab *', page)
         except FaultError:
             pass

