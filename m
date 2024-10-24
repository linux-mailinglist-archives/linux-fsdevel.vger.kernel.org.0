Return-Path: <linux-fsdevel+bounces-32700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DD9ADE47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D99283244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D391B3936;
	Thu, 24 Oct 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qa1LKxnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EF1B21AF;
	Thu, 24 Oct 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756377; cv=fail; b=EfweaSpeGqvGexuQpMxOgrhcpsQtEhgzWXbb6i95d0cftzmCsPYNSjH8Q6Tf4tJo2r3bPL7i8ShjGJr8TVZQ4Pth+vP3JMYXVzI+MosCNAcPcYwc+eyBVE+iosnPXmAXJWAfH/T6Dx6OIKZAyFlRzv9sBTFl2Yg/kMBFDeNQark=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756377; c=relaxed/simple;
	bh=8I/dbkx6r4A3QaX8+hsPzJZacq4QuOJB0/EttvddgtA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=vFv8Ixg0mv9rTsVbzb84UDz/rYGtxYWQEvGTXGzUx4taZP2FtzlY8JJewEKslokXWINgA+4ij0lg5l4YeiVF6CHLUG2awwuKIPQWrGOonS4pRMZkjmmFwux9y2QTL3F8jqugNYspB1dhy21VTuzn7UpCC1k98TzsF24usKMXrlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qa1LKxnO; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM6Agh0DGGbkbw0DOVBTrYeRCeLwVm8jmwNSdtx3zVR12QNKTUvg8n/J9TCZToa8Mz/d3peXVxofxhXaNG3A9y5719p6vasemHnBLNXBvkmOJTCWSujGY1wVlUKiv6xIILXx/KU11+6Fjq7S7tZlE1tE0Y+zDyQTOH4ClOyBHCKcZEilwO1MQJl7Yp+pRWP7TAF/i4XFTZMBCE2SdHc6MWyl9nGAofMN8Dkyzl2RTdllHHLJdOwThbCCPY4JLYLvcYnuKSosNCzlvU7mzaADACj/vMrbZGePZ9d2w3B5BqHLSFC2UGGW11alnYWqzQoEdBTb8vULWemgnnsPiSx19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1qBagrf6SdFe4M1Fl25yO+qDQiiBIPtuBRBTp9Sis=;
 b=NVZVtkNt56143fNmspFsHo5w6QA2IoQWLqBV5mObbMnXnPb1f5gBltc7mL1OBpzO8KOPVRgdbGya+6meN45jwsMA5hhOIkhY6wywPyU8mGmlFgTphPjXFjkoVHjpPqu3M0yw0V1vme+eFfd3Ou8ksP4Q55tE6iK3fqbqpIF1NgVip1Ee1NO+HVKB2GwjfTKFGuwSUnUWGwwmY7HavrN7ulodVAK9YMXjdYl3N4BUH68rDLjN8VASy/hB3ozdaY5M5aFi29r1W+duvOKTWkFrj+QzBk4Bas2e8Rb0gihRr+MD2wbcU+q1kLwivYsJCQRzTwJyOysTmVoROHD8UnNtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s1qBagrf6SdFe4M1Fl25yO+qDQiiBIPtuBRBTp9Sis=;
 b=qa1LKxnO9JsPBIbLEOaTym7w9IDIzel8nJnMi5FvcFdfNB8DqbhEJmVqjthT29Vw+NUXXsyT9o2M95XAJOB9kE8u89v8CHkBVdjg+5JYPibv6kXwbF0UVRvkd/ErRw2VqeLkfUBmHhr56ZW9tzvaLIRkjuykwcYOp3EKxvjTOmfaOffuF84TKjuaP8FXCzfxo9ypjU+2ocBppTWxKQ6InnAqSVnjff+bAuKfiFNmbC+uhVw5iLUV7bZTOg8ubH0NYtHLfhCsAYlxMDfr3hoXrSV69DN6smn27zOzLZVgHcoXL/0qqJqWB011I8O/0djz33pNPZsJCHFK9Qy9aJt1EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Thu, 24 Oct 2024 07:52:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:52:49 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Date: Thu, 24 Oct 2024 18:52:23 +1100
In-reply-to: <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <871q06c4z7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0109.ausprd01.prod.outlook.com
 (2603:10c6:10:246::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 79288846-09d7-4f76-bb08-08dcf400dae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s41AXCno/zWEc8P4VEDDImdFImGKpTlZthretlMmI8AYfg9E7Mnf8tPdrsvp?=
 =?us-ascii?Q?2Ap2TArqSt5bKrud1aikydCZc+fnKM9CPJUG6HNGGA1U86POO7ZC0WzqWqkl?=
 =?us-ascii?Q?rLQaRXGUeCyo4jMmi0Fj4RqVFcfGkctEav0Bjd4TlA+g1Y4E1HcopKMR1GMm?=
 =?us-ascii?Q?9tyW2leQK2AxzvAQ/G+2lIUFXE/FNaqaap3W3y/CpR7Z82RJwbEnwL2DYSoe?=
 =?us-ascii?Q?JEV+4ikE+Tgxijl5FNss2ba3+oxtYUAhBE0fVixH+syWRqtXzjiMPZNQeP/W?=
 =?us-ascii?Q?LGy5ctd3oZBkzoFWLFFgdDlbBz+CqaYkFefJIhqGg0C5kCvx0kRdjHuYVbpW?=
 =?us-ascii?Q?HUCIAY6DR/PSpM1z4EiSBKbmTo1tD13FSyi0WaZB7OQERnOFSo/8DKfYTkUk?=
 =?us-ascii?Q?A9zv+Nq0avuU7meaEy/nsfQ9NnNKz2yyXRPWEtHtjgtAUlntbQU07m+NeC2V?=
 =?us-ascii?Q?qpi7L9p0+BDj0xlKVRgH44hpOPyUGdCBdMQ4XKBJc9seUq5YJwBDUiyG8JEj?=
 =?us-ascii?Q?8owvj6wfGpxyJHej6ZARmBELD5dzPv/uwoL/+i1QCXapnN3yM3ptjSw/ZThy?=
 =?us-ascii?Q?ceNjmN+etrZjR/AahNBQpihSp9jsq6gQYMlJHUxK2axC3j45Ps+SlaQ8IeEB?=
 =?us-ascii?Q?RreHQz0bYq3L6BQEx3KsZe6zJN0cc8ustXRo7/fQpgES1NnRA+e5KjxnvAOO?=
 =?us-ascii?Q?guJxrcIC7+7MKjiB57Llpk4jgQORS3qoAB+1VuqBM4uSECZSqyAZiWz+MkUc?=
 =?us-ascii?Q?2S+y6mXekPYpkOREAP4T4BVtWrcnpvy4MXLlIri/v3hdw7au4gJd3mszJXrb?=
 =?us-ascii?Q?6yUt13Gck6QDFWwXyHUvYL3eu3oD9maFID5fk87S0g2KIey8kvnYRPJzkwqw?=
 =?us-ascii?Q?zY0ltgMi6qV0z+QMSFEJW8uDGQBn0xmeS95Ok2M2gHBH+pSW+j5rzXqPTzcH?=
 =?us-ascii?Q?6ekuIF7dxQ2eUmLo0BlvhF1/zFPVCs+mtpsEyMZDsgr3LmcW1xEIEEupuD4i?=
 =?us-ascii?Q?LTW2v7ImmSWjkvz/XxzIhFYOFkTaB/8gt2/NFFrJHQh/WSxVUSfb8U7FXQjq?=
 =?us-ascii?Q?WNrdXOUCyh6oxvVyQxc5QCQKbNUvpjJ+oVIZt/4DrAJxeST+RZ+se4shVQFm?=
 =?us-ascii?Q?xlw9iOtt9xAkiCAWqj3nUNjfnYzg7ZEjpsn/gVKgUJ5UalpwERkHib8PXQSI?=
 =?us-ascii?Q?QbfHRlX3iPvvt1wu8H71aPvsC4kaibXXdo8ZWK5TUdV5BC67Nq5XSkp+3q1w?=
 =?us-ascii?Q?mUqI8x9ULPq2HJmCRk4SDzC7UbQOCfFQ3Iaz0y0taMMMaPVvduiZw8tzFpBh?=
 =?us-ascii?Q?jEqvS/W2u1Fnhp3LsLZW23fU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bI4z6hSK+kmLTFYbqBVE/3XTChMcYLBxFbCkDiVaD8bRwsDLRoH1CDro84Z/?=
 =?us-ascii?Q?VqTzkHEhs3znQHOyvz8M1cszMT/rva8A144x9EKpHf6BquvupIBoFqk8ifx/?=
 =?us-ascii?Q?XRDMeO2c03XJHi436FDdwwFxe8mOZZbV/LY2fwnfLv9pi+e1S8+tCUGIduup?=
 =?us-ascii?Q?YUpzbpby9KQQkmV4oE/AwrcVOLYD1wSme/6urfB6xSaOAPsk742/lJGXXNrB?=
 =?us-ascii?Q?1sNO7LTWyYriYwzdpQlRWdtmy5YPQYb7NBRudOqR73z1cZ30KA0bhqpA7X8b?=
 =?us-ascii?Q?CCPlNsLd1qxrvDNBDBktbJaY+Jx2alfm2whfUOgG7KRe877oszOb9q+ymm4T?=
 =?us-ascii?Q?kYMhyGk1EzF/67v4ytP4FY4u9+Y6/5qmAwi/K+ax1JH4WM3pVFXb2ec6/1mB?=
 =?us-ascii?Q?oXakCZGitL4tx9rRyK+3Gm+gartfI9KtdbBTeC07JIuB4tEUTzagvvFP9BRY?=
 =?us-ascii?Q?6YSZ3ACl3iUnSyBOzmBBxrzCkSC7MDVuyvRfwunvNNWR1l1OdUBBY+qoYxH8?=
 =?us-ascii?Q?ycLUs+gqMoAReZj04vITkIvSoP2q9LwM5HMdT06XRO2GorvAOQhpy4Cv4HI7?=
 =?us-ascii?Q?khvctqZXfJvRQS1YvJmTjNXHMkKxebuZDK5PpvOLzlUW79o+uJOtLNsMwDXU?=
 =?us-ascii?Q?ryO6RMLupxRbboqlkpw5q+g30ZO622hYeR0a89OlhpKhkmqI5mUOe0VKGn5p?=
 =?us-ascii?Q?/zIvksHXe8IJm+gIyWMIGrFKbgC/dl8xSZdkRuCWJJK+00YMzB3HPjhQPHTy?=
 =?us-ascii?Q?QLxqjN5/eIjF6BkU4gpCXO9LbiJCXiIaKkPodBHLYQ0e/+Uk2DDO3W+4jPgJ?=
 =?us-ascii?Q?46JyluJke1krQa5DA6+thBRWyetP1ImkmqXye7RQ/6mSBWHIm1w6g5+rxeJD?=
 =?us-ascii?Q?cuh7z/a8XGXW/fn+5eFv6cOgWru8ElAGg06votbVxwlfJwHEK7i2CilRK1bL?=
 =?us-ascii?Q?LEaSNw8iuAoJc0V3YpsK73aCTbeSL+nYGzqFMJPRdf5f9NHIVaMVVdIREuK1?=
 =?us-ascii?Q?bZyaMgbfOojAPUDlpVN3dTGPf97vMwjQDWH2AGKRT/2Cfrrx5CKO4Y/RNkre?=
 =?us-ascii?Q?WlsxOIhH9XHaSgSVQkLRI0wUoBnvBkU7N2E4uE9d/TpALqxbPMAOC0cRXIIJ?=
 =?us-ascii?Q?xsSJ6E0j4Bx+yA0i5XBKhVTbGvxLbruL7S22M2sSm8HMSOT6dWc6Up0kG3x1?=
 =?us-ascii?Q?gUD+MrAT9Ru1lMr3Ov4ZFk5kpDwJbOy3xesNXYUDtudiQvbS/bhrXib2UjW+?=
 =?us-ascii?Q?hFKpJUwCTWNE2bh+h+yah8FXwdMzU1D1AR7ksDOzF0Z0xRTmEV7x4nnulghJ?=
 =?us-ascii?Q?Vy6vSHlovmtGI0B3Juf+2BbUIRASdjwvFJZZVnGIhcSNlZLRAKWFn5iQqr2M?=
 =?us-ascii?Q?1GIU4aG0xygNsWzIJQgMXRPedOLJHN+ORz1R6HX0+FdfKL2aJx7QMm75qZwc?=
 =?us-ascii?Q?lGJ802gCeDedABFBEiiZI79xyF+KvgVjGtfVChEWUxxUEBmYruonwKTV6XWw?=
 =?us-ascii?Q?VKq4PXaAINx4OAeVguaSO/ZwU5k7zTdT2MVgWyJVB6xLx71IMETDK3823QxZ?=
 =?us-ascii?Q?u5Rm2G44dVy4qkZUe1HWWCC0mvxg5b80pyJNumth?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79288846-09d7-4f76-bb08-08dcf400dae3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:52:49.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96GJJa4QqIFQ4AjrmDWlWqvdaS9iRDvuU2sOoDmqCGz7lvUc4tZORi2Oi82LsjpOb4sFR3T6F2qtoiDdlE6JNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:

[...]

>> @@ -318,85 +323,58 @@ static unsigned long dax_end_pfn(void *entry)
>>   */
>>  #define for_each_mapped_pfn(entry, pfn) \
>>  	for (pfn = dax_to_pfn(entry); \
>> -			pfn < dax_end_pfn(entry); pfn++)
>> +		pfn < dax_end_pfn(entry); pfn++)
>>  
>> -static inline bool dax_page_is_shared(struct page *page)
>> +static void dax_device_folio_init(struct folio *folio, int order)
>>  {
>> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
>> -}
>> +	int orig_order = folio_order(folio);
>> +	int i;
>>  
>> -/*
>> - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
>> - * refcount.
>> - */
>> -static inline void dax_page_share_get(struct page *page)
>> -{
>> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
>> -		/*
>> -		 * Reset the index if the page was already mapped
>> -		 * regularly before.
>> -		 */
>> -		if (page->mapping)
>> -			page->share = 1;
>> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
>> -	}
>> -	page->share++;
>> -}
>> +	if (orig_order != order) {
>> +		struct dev_pagemap *pgmap = page_dev_pagemap(&folio->page);
>
> Was there a discussion I missed about why the conversion to typical
> folios allows the page->share accounting to be dropped.

The problem with keeping it is we now treat DAX pages as "normal"
pages according to vm_normal_page(). As such we use the normal paths
for unmapping pages.

Specifically page->share accounting relies on PAGE_MAPPING_DAX_SHARED
aka PAGE_MAPPING_ANON which causes folio_test_anon(), PageAnon(),
etc. to return true leading to all sorts of issues in at least the
unmap paths.

There hasn't been a previous discussion on this, but given this is
only used to print warnings it seemed easier to get rid of it. I
probably should have called that out more clearly in the commit
message though.

> I assume this is because the page->mapping validation was dropped, which
> I think might be useful to keep at least for one development cycle to
> make sure this conversion is not triggering any of the old warnings.
>
> Otherwise, the ->share field of 'struct page' can also be cleaned up.

Yes, we should also clean up the ->share field, unless you have an
alternate suggestion to solve the above issue.

>> -static inline unsigned long dax_page_share_put(struct page *page)
>> -{
>> -	return --page->share;
>> -}
>> +		for (i = 0; i < (1UL << orig_order); i++) {
>> +			struct page *page = folio_page(folio, i);
>>  
>> -/*
>> - * When it is called in dax_insert_entry(), the shared flag will indicate that
>> - * whether this entry is shared by multiple files.  If so, set the page->mapping
>> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
>> - */
>> -static void dax_associate_entry(void *entry, struct address_space *mapping,
>> -		struct vm_area_struct *vma, unsigned long address, bool shared)
>> -{
>> -	unsigned long size = dax_entry_size(entry), pfn, index;
>> -	int i = 0;
>> +			ClearPageHead(page);
>> +			clear_compound_head(page);
>>  
>> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>> -		return;
>> -
>> -	index = linear_page_index(vma, address & ~(size - 1));
>> -	for_each_mapped_pfn(entry, pfn) {
>> -		struct page *page = pfn_to_page(pfn);
>> +			/*
>> +			 * Reset pgmap which was over-written by
>> +			 * prep_compound_page().
>> +			 */
>> +			page_folio(page)->pgmap = pgmap;
>>  
>> -		if (shared) {
>> -			dax_page_share_get(page);
>> -		} else {
>> -			WARN_ON_ONCE(page->mapping);
>> -			page->mapping = mapping;
>> -			page->index = index + i++;
>> +			/* Make sure this isn't set to TAIL_MAPPING */
>> +			page->mapping = NULL;
>>  		}
>>  	}
>> +
>> +	if (order > 0) {
>> +		prep_compound_page(&folio->page, order);
>> +		if (order > 1)
>> +			INIT_LIST_HEAD(&folio->_deferred_list);
>> +	}
>>  }
>>  
>> -static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>> -		bool trunc)
>> +static void dax_associate_new_entry(void *entry, struct address_space *mapping,
>> +				pgoff_t index)
>
> Lets call this dax_create_folio(), to mirror filemap_create_folio() and
> have it transition the folio refcount from 0 to 1 to indicate that it is
> allocated.
>
> While I am not sure anything requires that, it seems odd that page cache
> pages have an elevated refcount at map time and dax pages do not.

The refcount gets elevated further up the call stack, but I agree it
would be clearer to move it here.

> It does have implications for the dax dma-idle tracking thought, see
> below.
>
>>  {
>> -	unsigned long pfn;
>> +	unsigned long order = dax_entry_order(entry);
>> +	struct folio *folio = dax_to_folio(entry);
>>  
>> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>> +	if (!dax_entry_size(entry))
>>  		return;
>>  
>> -	for_each_mapped_pfn(entry, pfn) {
>> -		struct page *page = pfn_to_page(pfn);
>> -
>> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>> -		if (dax_page_is_shared(page)) {
>> -			/* keep the shared flag if this page is still shared */
>> -			if (dax_page_share_put(page) > 0)
>> -				continue;
>> -		} else
>> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>> -		page->mapping = NULL;
>> -		page->index = 0;
>> -	}
>> +	/*
>> +	 * We don't hold a reference for the DAX pagecache entry for the
>> +	 * page. But we need to initialise the folio so we can hand it
>> +	 * out. Nothing else should have a reference either.
>> +	 */
>> +	WARN_ON_ONCE(folio_ref_count(folio));
>
> Per above I would feel more comfortable if we kept the paranoia around
> to ensure that all the pages in this folio have dropped all references
> and cleared ->mapping and ->index.
>
> That paranoia can be placed behind a CONFIG_DEBUB_VM check, and we can
> delete in a follow-on development cycle, but in the meantime it helps to
> prove the correctness of the conversion.

I'm ok with paranoia, but as noted above the issue is that at a minimum
page->mapping (and probably index) now needs to be valid for any code
that might walk the page tables.

> [..]
>> @@ -1189,11 +1165,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>>  	struct inode *inode = iter->inode;
>>  	unsigned long vaddr = vmf->address;
>>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
>> +	struct page *page = pfn_t_to_page(pfn);
>>  	vm_fault_t ret;
>>  
>>  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
>>  
>> -	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>> +	page_ref_inc(page);
>> +	ret = dax_insert_pfn(vmf, pfn, false);
>> +	put_page(page);
>
> Per above I think it is problematic to have pages live in the system
> without a refcount.

I'm a bit confused by this - the pages have a reference taken on them
when they are mapped. They only live in the system without a refcount
when the mm considers them free (except for the bit between getting
created in dax_associate_entry() and actually getting mapped but as
noted I will fix that).

> One scenario where this might be needed is invalidate_inode_pages() vs
> DMA. The invaldation should pause and wait for DMA pins to be dropped
> before the mapping xarray is cleaned up and the dax folio is marked
> free.

I'm not really following this scenario, or at least how it relates to
the comment above. If the page is pinned for DMA it will have taken a
refcount on it and so the page won't be considered free/idle per
dax_wait_page_idle() or any of the other mm code.

> I think this may be a gap in the current code. I'll attempt to write a
> test for this to check.

Ok, let me know if you come up with anything there as it might help
explain the problem more clearly.

> [..]
>> @@ -1649,9 +1627,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>>  	bool write = iter->flags & IOMAP_WRITE;
>>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
>> -	int err = 0;
>> +	int ret, err = 0;
>>  	pfn_t pfn;
>>  	void *kaddr;
>> +	struct page *page;
>>  
>>  	if (!pmd && vmf->cow_page)
>>  		return dax_fault_cow_page(vmf, iter);
>> @@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>  	if (dax_fault_is_synchronous(iter, vmf->vma))
>>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>>  
>> -	/* insert PMD pfn */
>> +	page = pfn_t_to_page(pfn);
>
> I think this is clearer if dax_insert_entry() returns folios with an
> elevated refrence count that is dropped when the folio is invalidated
> out of the mapping.

I presume this comment is for the next line:

+	page_ref_inc(page);
 
I can move that into dax_insert_entry(), but we would still need to
drop it after calling vmf_insert_*() to ensure we get the 1 -> 0
transition when the page is unmapped and therefore
freed. Alternatively we can make it so vmf_insert_*() don't take
references on the page, and instead ownership of the reference is
transfered to the mapping. Personally I prefered having those
functions take their own reference but let me know what you think.

> [..]
>> @@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
>>  	lock_page(page);
>>  }
>>  EXPORT_SYMBOL_GPL(zone_device_page_init);
>> -
>> -#ifdef CONFIG_FS_DAX
>> -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
>> -{
>> -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
>> -		return false;
>> -
>> -	/*
>> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
>> -	 * refcount is 1, then the page is free and the refcount is
>> -	 * stable because nobody holds a reference on the page.
>> -	 */
>> -	if (folio_ref_sub_return(folio, refs) == 1)
>> -		wake_up_var(&folio->_refcount);
>> -	return true;
>
> It follow from the refcount disvussion above that I think there is an
> argument to still keep this wakeup based on the 2->1 transitition.
> pagecache pages are refcount==1 when they are dma-idle but still
> allocated. To keep the same semantics for dax a dax_folio would have an
> elevated refcount whenever it is referenced by mapping entry.

I'm not sold on keeping it as it doesn't seem to offer any benefit
IMHO. I know both Jason and Christoph were keen to see it go so it be
good to get their feedback too. Also one of the primary goals of this
series was to refcount the page normally so we could remove the whole
"page is free with a refcount of 1" semantics.

  - Alistair

