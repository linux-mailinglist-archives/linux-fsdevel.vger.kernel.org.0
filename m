Return-Path: <linux-fsdevel+bounces-45762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F2A7BE07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D319D3B8ECB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D481F0E51;
	Fri,  4 Apr 2025 13:38:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED61EBFE2;
	Fri,  4 Apr 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773891; cv=none; b=k3nM2sPTdG17RWJMjpFzuMoTEHEfCCeLed7HJ2kemzjBttpt0x/79k1+dZ9HWbue6y0qEINbGRvLRsBNGO+0D1lOh0d6tAoORK4z6pKkBvAwIUnBLT96l/mNdKGtfZsRQTqhq4VJ63yipzG0zL6EUlROmvz4vR5MzDDMy4Efcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773891; c=relaxed/simple;
	bh=1E2ytAN49mBdglAR3XwbcrZ9OmV6c1AqR4x/hfqhtV0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQkRZN4Ye7cvoKG3t43qTkIEGFSBqRI7KZkkMQNplobt4tY4P87RIdHXcDwG0Pbugxsa8XXYbF1nmkG3fO/XW9MpFBs0h/N8vsJX/lKPqFjj7Gs4Ux8I5sWbR8Bd1Jip+vuPX6HpQ8HJMBDJHsNosFExcrEKNCZktpdmdPsJ6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTfhy6s8fz6K9Br;
	Fri,  4 Apr 2025 21:34:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 977C714062A;
	Fri,  4 Apr 2025 21:38:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:38:06 +0200
Date: Fri, 4 Apr 2025 14:38:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<ming.li@zohomail.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huang.ying.caritas@gmail.com>,
	<yaoxt.fnst@fujitsu.com>, <peterz@infradead.org>,
	<gregkh@linuxfoundation.org>, <quic_jjohnson@quicinc.com>,
	<ilpo.jarvinen@linux.intel.com>, <bhelgaas@google.com>,
	<andriy.shevchenko@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<akpm@linux-foundation.org>, <gourry@gourry.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rrichter@amd.com>, <benjamin.cheatham@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 4/4] cxl/dax: Delay consumption of SOFT RESERVE
 resources
Message-ID: <20250404143804.00005291@huawei.com>
In-Reply-To: <20250403183315.286710-5-terry.bowman@amd.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
	<20250403183315.286710-5-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Apr 2025 13:33:15 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Nathan Fontenot <nathan.fontenot@amd.com>
> 
> The dax hmem device initialization will consume any iomem
> SOFT RESERVE resources prior to CXL region creation. To allow
> for the CXL driver to complete region creation and trim any
> SOFT RESERVE resources before the dax driver consumes them
> we need to delay the dax driver's search for SOFT RESERVEs.
> 
> To do this the dax driver hmem device initialization code
> skips the walk of the iomem resource tree if the CXL ACPI
> driver is enabled. This allows the CXL driver to complete
> region creation and trim any SOFT RESERVES. Once the CXL
> driver completes this, the CXL driver then registers any
> remaining SOFT RESERVE resources with the dax hmem driver.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Looks fine to me, but I'm not feeling confident enough of
this area of the kernel to give a tag.

Jonathan



