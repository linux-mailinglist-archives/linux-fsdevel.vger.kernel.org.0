Return-Path: <linux-fsdevel+bounces-51148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BCAD323F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4130F1882865
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2928B4E2;
	Tue, 10 Jun 2025 09:37:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB821CFEC;
	Tue, 10 Jun 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548231; cv=none; b=AW08Vl1KzisZr05bA4qH2OuBYG2S2+ppxZmDDpem1ZP2rFycgonHzmBF/cuoZb1ApxC082NoNeOJs8YzVwXW8TD8NMB3kc2NIJohw6FlF/PwTX8D7IfAM/pBkCCTqhiwoJ1fVBfJz1ncbAZo8AEzUlALZJgG2n9HKUF37bdmEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548231; c=relaxed/simple;
	bh=F6ncpGupYU2VphrbmEqVC1lkKwUVvG5DdDUf7ZEhLRY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J334T800np1sBdM662tuKstu6A8UMtTlce/NWnepuvTfcXelMveGJTHmTp+OUGRw7i0QVZCV6Q3LMZd5Z5zsIMuGj31hcgjM2ZjJMAIk/ZKVkvz0eQchPwGooL56GxEBd7s7IbN1zBKSlz03Is3/s0PX+Bb+BhFrzETBH3q074Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGkFm2Xqmz6LCsb;
	Tue, 10 Jun 2025 17:36:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EB30D140558;
	Tue, 10 Jun 2025 17:37:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 11:37:05 +0200
Date: Tue, 10 Jun 2025 10:37:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	"Nathan Fontenot" <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Message-ID: <20250610103704.000023c4@huawei.com>
In-Reply-To: <f157ff2c-0849-4446-9870-19d4df9d29c5@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
	<20250609135444.0000703f@huawei.com>
	<f157ff2c-0849-4446-9870-19d4df9d29c5@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Smita,

> >> +/*
> >> + * normalize_resource
> >> + *
> >> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
> >> + * to the actual resource in the iomem_resource tree. As a result,
> >> + * __release_resource() which relies on pointer equality will fail.  
> > 
> > Probably want some statement on why nothing can race with this give
> > the resource_lock is not being held.  
> 
> Hmm, probably you are right that normalize_resource() is accessing the 
> resource tree without holding resource_lock, which could lead to races.
> 
> I will update the function to take a read_lock(&resource_lock) before 
> walking res->parent->child..
> 
> Let me know if you'd prefer this locking be handled before calling 
> normalize_resource() instead..
I don't mind either way - see what looks better to you.


