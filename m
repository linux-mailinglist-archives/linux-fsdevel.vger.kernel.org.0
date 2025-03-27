Return-Path: <linux-fsdevel+bounces-45140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE37A734FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAFB188F162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BDC218845;
	Thu, 27 Mar 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bX2V9li8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57979E1;
	Thu, 27 Mar 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087000; cv=fail; b=eC/25Eqa3KcG4WJGcvWFNzyWLmPTvzaEnsmI6dKDauntiL/NUGS7tEu6RfhBsOzEMUz2QTFAYeeFDncFJ3UmUcqXR+qe9un7nsPugKiemBPLhWrhXlCMbauwELiMRwc+INo/BeknGc+QpvsSnwvdjasbQGSPvmCCDeSIDOhjbDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087000; c=relaxed/simple;
	bh=v+Qa0m5NUBPi7wqpulo5Ff8E3dAHXm4yuandj29rR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u+5gLxb2S9ilRLyBoR1WZCDG3FOlpex6jnthLXcs06kaSykRHvAzuaaSrUnaix6t+WlVncGcIH9BPyl3OcpBllCgL5lKFrn6Svh9eJMUZDvA1bO/AuUspBBz7YPGBNvV9PMtHuskmrxolO+E+brT8R4kkQ2ezePogb0cEZoO0iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bX2V9li8; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOYB61+Jil1tvwtNiN89Ijhg5L322c7DDUi3aj0C7oe2m5fJyczZ4E3ess8PIKAvcrQCU2N5dJaqmUvoDqWUYzd/SQXFJGKETk4/bCunjkRAm/PehBOTfYTZa35zeGV5F6UEzOEP5z7MPVjNneMcV7nZ1aquB2wG+GS52I+nJuIccBgFYzsNLOOUvhm5h0cvhqBg5U7+R+tLk32lEO2mbMO0BLZCLQx8foDeFi5N4W84e0DM7ilwWTjkotzXVF2WhWwaN9AYbrswOGWvv0ANMAwi+PJpY5SKoSDXB6WC7kkUv3skOVrJ2tnjCmHB3Z+uAUR8N31odPndQOmDA7/WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taK75GSgOINkRwYN91eeHKeOiAD7kVmtQe5VcG7uzc4=;
 b=FGy8WbjxBaqes4CoJyRGpTcdOaSsPE6R4unP8X1NPvDvgHUSPFxpbhC9yy7JBMl0ae/EmnA2FdU8Mm4HWmOj1CU/uIQKAhvERwktpnWJ1sZddqT9NzeB/ZZlBT0HOTZUkqfQLKCBPq31mA+B75qKd8W9MEWl+imWRNqQQGHl97I7I3A2t3RSuoWux//phllGJCJta/xvYqcggHlkLk8PT/iPDByCIcYxDsLpWc0DBeGYE136t6kAvLodQ5O3NA3hebUNWBODhPts1C9BSzoaZdnehJqO16Sb8jYqF6fPKlyExLp1DqACNB7lbL56rWKB5gu0KPD14LE0aAn0BdMjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taK75GSgOINkRwYN91eeHKeOiAD7kVmtQe5VcG7uzc4=;
 b=bX2V9li80K7fLyJw93gHjFBUIJ8FG7bYuPUofRHtDmq4SJTdmmSod2bYtgnMkdk54z9ZHdD3cKacKjQboykre3BJQVTsDM8GUk3iAZN5dqWC5wi4rQHxexrl8JT1TUkEgup66kOrARKRfkJFkUVZRd5S1zASl3fZNWhsYYLH+pVf94x1Pkyn1lrZiYhvdHjwF2GAdcHr7RaV4ffc5gbtB5+NK/V31EdwPL9yOxb0wj6fpBdNL1K0fbpnf25xWFBKBtNGQW63dtNuNS52Z7yqPpGJUB6+mmkBikgVLyiE9qEyzmUoKIM4GQM2ZVur0s8C2v1CPb/KNEsCi2M6KVGmYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:49:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:49:55 +0000
Date: Thu, 27 Mar 2025 07:49:47 -0700
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Message-ID: <jcrkl6my4u3tyjmaoibor4lwe2diox4moo4ap52eu4v3yxhnn3@mmahcrjxeiba>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
 <Z9e7Vye7OHSbEEx_@infradead.org>
 <Z-NjI8DO6bvWphO3@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-NjI8DO6bvWphO3@casper.infradead.org>
X-ClientProxiedBy: SY5PR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: ac99069f-9c21-400f-294c-08dd6d3ea36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3F/Uj4lBraIFT7QtmiF2SYEuKeDGAUddXLC1cAd7KcpIy6LH4SbUQcoFDTs?=
 =?us-ascii?Q?bbfOXZd/s+ekj+L3N5xC9CJYsSRyCgQF3atYI5N1VdOG9F85mJ4UkMBB+8pT?=
 =?us-ascii?Q?67qXyPCgVhDRWAT6uQY0eiz8oaJ30KLbdNCDXXHjOa5W+sudl2qzLcuvT4+6?=
 =?us-ascii?Q?bTIkBQUoyxKPXCpe7WTro2tWJPgHqKa1l33IVJWZfTbUcwxprtdf6kvPaJRe?=
 =?us-ascii?Q?73FrgUEC7ZouUBXCfPaOmgeWHQsxGiwLWogCD6cxq7J9omtFpcrECgx4xxBq?=
 =?us-ascii?Q?VIJblLnolJFWfyt96ohGbFnrbNKY10nREQZvNH+uFmpIjVEqtyQF/11ns4+g?=
 =?us-ascii?Q?4WWUTXGOR38jeYeYtiv8XZD8dBaGBbvb0UG055Ag4M3zIPlf/A2gBVOgfMtI?=
 =?us-ascii?Q?etYgDhLJNiyb/rmvb4adamdxnXxUERTRgN42pVIPtq1CCNjcVZZeeTV6YYPw?=
 =?us-ascii?Q?CSq8nEH8o4G/QmKewrLm2TaFgnfrMra/PvwOwb5RTd2F7t32V0wkauXZlYxJ?=
 =?us-ascii?Q?+PkrucvC/BwoFO5Z5HSftSqwtla3XnOFUbeG5ZHBe3nsc4TGypoMJqCpXe/o?=
 =?us-ascii?Q?yX/2MaDpd3pdoPLMmErjKfypMSr6G8O5vNq3eIlmPUus14QKeOK0oW7sbqsT?=
 =?us-ascii?Q?LZFi7rMcy6eEL2Mv++/Kx/SepVnMyqQhJXOhHXCjgudHynI90/6pCVuCYgi0?=
 =?us-ascii?Q?hqnahJoI9EPbP9eVGbaFfptZIVkKkP1go8E2HK6mwdY61lp660VZQmMC7J3Y?=
 =?us-ascii?Q?8XgTsdY5YN5i2HIZGXmKgDo5sj4IaudDCGtRdlhndFpDbJaavo8aMq2Sgs/P?=
 =?us-ascii?Q?6ZmCWPLTFIRea5YJj7se4Z0GEl6tnz/MRbazaIwa4J+oy3h27PCH+z5FPaez?=
 =?us-ascii?Q?/kAX6Y7DgMlxbA7uVtOlyKlrBKW7zxdcvC+1HnlQPSEfsFZbW+hO/JyKllNY?=
 =?us-ascii?Q?SJ0TMR6d87QiLd6g+Wr1hrkXMKcrF4/Djd9h4bcMTJzs/SIj1Mta+5E6lRH+?=
 =?us-ascii?Q?2glBxSRERKf5SO1IsbdH+c/A3akRyLIKh9NIYJLJyKXkSy3gh6Ye3n0Hl5aE?=
 =?us-ascii?Q?QsLslDSN6UOCXbLvUG+4Egqrn1RSnjr/472uxUVWfdrCPBnqLZdqRVGSE92p?=
 =?us-ascii?Q?wJbd6KqWMP/xBb/2JW0xhMixn+VlHgFOoNxFFRW5HIacb5RA8iZNeo2/QQZY?=
 =?us-ascii?Q?z8tN6ixadE6VgPmMy9um0gmFHT3QFfFYKmbJEfBg3E8eKcX5KkCofFHst1ai?=
 =?us-ascii?Q?QLwc1e9wzV23qC3lqkWhfam9M6uj7ov/6/NknCDIOZ60l68gpOH2SwzR6y1B?=
 =?us-ascii?Q?v22GilgeKBkiN+zJ9h5JATTF0edJL1bqcvuk7s+YO6nLQNpxszxBtpnFvSnD?=
 =?us-ascii?Q?dsnbePpCfcoiFWYDG6dNpm+f/ogrM4Nw+yc6TNYAgI7i5F/GyToll2ufpyBe?=
 =?us-ascii?Q?kGu4eMJIe+++frqTGpAnKmhD7S7r7XBw6xKsPLlCq9E1a7JUEnpKrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3n6BDz46x5fmSWQqi7T/dpPgISZutz5MWzeycv2AoFDejS9XGkeHhiiJNyRR?=
 =?us-ascii?Q?qg/YZzqpp//i3STmVSu6wkJHjBehfZrAIlnOyX4YUizZo1Rly2Rc2JrGup6X?=
 =?us-ascii?Q?7cdRFe/18BkBseCx/7x/K2hzyb1brv1RtEQhjk3ecyqMByfzomNfFPYw79mz?=
 =?us-ascii?Q?TSicS9I5EmV7s7Etfgh+nRXXyPHInc7oh6xmlWm6f5hJdg6K0z01llAxDMeJ?=
 =?us-ascii?Q?BbUs8/KXGA0fTQlGNhGbNDyPQR4zrCQ2rT/V/ap2p/BYYfHeWz2P4awdpqpF?=
 =?us-ascii?Q?N2BYH9X5x+3C7RbV7RzHqllBk/ULzp8iQP6WmkUpmeIaQ63ut5Fwb8rLeEvh?=
 =?us-ascii?Q?L8xdM/fjSwo8stgVw/3PrWlzYVOpffpjIAYPc5KE+iBeQYWRkUBpnGXM69C+?=
 =?us-ascii?Q?M3H1IpZrix6h36l399+Tyz3isGgcgwo+lNDrDHjnPMRdo+rPhfwiRsz78JgZ?=
 =?us-ascii?Q?9d0hcKo7LEa+wOsRFPMNd3Nplb+8wyKPDsQuW75ulwSiYJ875OcLX1UkphJf?=
 =?us-ascii?Q?nN25VHQl0pUdkNNJsHxNUzOjEQMlp6xIf/0gGn17T0As46V6geQOz25RHe5V?=
 =?us-ascii?Q?WadbDk4wYmhXDeShSqL830EzVpu6nZnqO+2uj3ZnBdIe+6b5mVmENCpdT7NB?=
 =?us-ascii?Q?IpZAAyOoZqU4xGLXPyobc7QtnhTcqPnIpdwfOH9DyCmX93gEQTpLSbevcdVQ?=
 =?us-ascii?Q?DG01ASokjriq79bFo+a58KbOd3POe/HQBaTG2+bxeDgD17MlJrfBktPm+kn2?=
 =?us-ascii?Q?3j7As0YIgdXt3iAkyq/n/wFONw8qyhMiZCHGa+ZC38S5LemPsZgq5f1Zo4Tg?=
 =?us-ascii?Q?GdlGVrvx4fcYFA9cmBfoQNXVuyHwjrK5kqLEZtbPkw5e516HqEpWd/FSpM3v?=
 =?us-ascii?Q?ZcziaurF6TewGkL0eG2WnJ8omsVxZdfUG0tQxeBt+8rl056T3NkDwZU/Z0v5?=
 =?us-ascii?Q?kOa5z1Gq6agpwDmdMrSkPUQyESsS1A4VFwLU9aHYurzunysl7CDOPmBxovx6?=
 =?us-ascii?Q?/1PgDumS6KKHqedcyOFU9o2EbZT9sZgiQmNGlBNkF4opj758p6/aLm+mqA2/?=
 =?us-ascii?Q?WfdYCDv7eYVggxQ8whsOmh0rePMv9RgGBzxFz7Ruvppl9db6/1WNaQYaeFsx?=
 =?us-ascii?Q?twRKB7lSg6aa8pWN8MUvXc9qI5RMo9zs4I0uGuSZPY5hck9zaP3itYAtLIAv?=
 =?us-ascii?Q?jTI68NDl3pVMRBgyxGlqtwecCR1zkR6eC0BpD6CC3t3kJT/ECMbsVr9iBDxj?=
 =?us-ascii?Q?xBlw1N77XHdmA7eRd3y01rZaTMIxiY8lf5XaUkyFm5cD7yAJAtWpqFz6rTOU?=
 =?us-ascii?Q?t+yNkzWPOHVXnP8PwZo4bYvwJVT6fNBYmzDCAWSZCPEIFUF9lDRfI7aU5ILu?=
 =?us-ascii?Q?991yccWCDBHl1Fn9o48bPa5dOVWEGUf8cq7m8M2vPGxqdV7Gw3Dc/JgE0aIM?=
 =?us-ascii?Q?MAqL7Q1lqQo0GuFAZ+GsQFSPFauxYF28nkWxty7csKGlH2qEmxl6v5W0+O1Y?=
 =?us-ascii?Q?6OFAj0xaRd+OHZ5CPqF+lpBIFHW11u69tDoqB38GYmiKWXpQqy+KkFA84yap?=
 =?us-ascii?Q?x3Cx53tcUBAo+pSjMVPzHsULcFQO+tJEscAPDk4g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99069f-9c21-400f-294c-08dd6d3ea36f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:49:55.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPsvmwSFcm308oX3qA8e0L1rfdA5zmz4oJwvQAsRtOLKa0A0QmdXVgtIRDrRkflF06j9h0cITaUfn6Fes2baxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

On Wed, Mar 26, 2025 at 02:14:59AM +0000, Matthew Wilcox wrote:
> On Sun, Mar 16, 2025 at 11:04:07PM -0700, Christoph Hellwig wrote:
> > On Sun, Mar 16, 2025 at 03:29:23PM +1100, Alistair Popple wrote:
> > > This series lifts that restriction by allowing ZONE_DEVICE private pages to
> > > exist in the pagecache.
> > 
> > You'd better provide a really good argument for why we'd even want
> > to do that.  So far this cover letter fails to do that.
> 
> Alistair and I discussed this during his session at LSFMM today.
> Here's what I think we agreed to.

Thanks for writing up this summary.

> 
> The use case is a file containing a potentially very large data set.
> Some phases of processing that data set are best done on the GPU, other
> phases on the CPU.  We agreed that shared writable mmap was not actually
> needed (it might need to be supported for correctness, but it's not a
> performance requirement).

Right. I agree we don't currently have a good usecase for writeback so the next
revision will definitely only support read-only access.

> So, there's no need to put DEVICE_PRIVATE pages in the page cache.
> Instead the GPU will take a copy of the page(s).  We agreed that there
> will have to be some indication (probably a folio flag?) that the GPU has
> or may have a copy of (some of) the folio so that it can be invalidated
> if the page is removed due to truncation / eviction.
>
> Alistair, let me know if that's not what you think we agreed to ;-)

That all looks about right. I think the flag/indication is a good idea and is
probably the best solution, but I will need to write the code to truely convince
myself of that :-)

