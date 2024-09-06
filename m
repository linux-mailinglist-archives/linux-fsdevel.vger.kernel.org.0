Return-Path: <linux-fsdevel+bounces-28829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DE96EA1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616591C23314
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 06:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C613BC0D;
	Fri,  6 Sep 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l2wdSrAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2327450;
	Fri,  6 Sep 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603959; cv=fail; b=hDxvA8H1HPv+YoLkcIh8LjeAgtTjBPp4Z9P451XaNtmjDBZQoBCnPQ/mhV5QXThlG/x8d3XQGjz2brs0oOZXwKF7KCOjr4kKrA8E3LZzw3kxFfAOrHh6XCOEQKnIXGw2l5An46OonRzGu6EhrkhDF7HFFRZtrWN6odzY2zo58go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603959; c=relaxed/simple;
	bh=Gv53wYvcgEdApdjwhKnz+T59tYpyYUtENz6vyriFHIU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=rThPZEdnQ1oX2+EjL2erkzgwWkKN1lu2nRk0mhbvBnOUmFiHCGPf+PNGx63n+tPzgp4ikWhMgM/wZWr0p6Fx645JGD0q5LhnkI954Hyuk/M+WXc+L1RABG14mo5GL5zJ3/hmYqQG2mDaSMNGuCshB/SJGBIml/TkTb13NZZX+I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l2wdSrAl; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frBlN4lIKwr0sTea2C9PIWE7ggpGCoa1t6aJIXQDzETEZJfm68tSD8fIC0EyVwtumw8qZrKfBdj2LJRKzd1RHUmcWypQbwbx3BXlcqtpq640VSg/sXPexlwCxvyaXy6KJgN7o9x7mocgVpGUn6i34UE+BMBzg5PwHIN8obVEAOQ1HPXcE6D6AHZeHvcn24+lo+ngQntgQWzErxOgReV+PiqTtyFpKhZT1ujnsq2jr6WXDJdKQEn+odmu8D9HfOOixuqSnxBo8NcLlBaB8lC6+lsV+D/tyEYfO3uHEwr5FiQ2k4wWV5DRWzHznWqVFuFbNh4GlmmQ1ISVkyIIiIi6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yoTby9ct0vxVKAUMvwbhURvMRMtDZTCIToUhzGW0YM=;
 b=FduCfRaija00nJHm0D0EPSlQ9rW+yCfuTcuIEtudr2m6CXXK3JXBlyZE38jWt/zYRgaOgxYUS6PVpQwJdTdZzvEp1LZmpQb0qjN1Cb5lYNzWJU7M6T5m/tgH8SYEIMcyLiXOMkV+muZbYpOXAZunH1wqvDdHJAh/lCbB/5VFGK84n3Hfgy4q4r1KFW15M8d0ZlG10Y85R0FA7BQHoO1qWDbbrMWAcu8Pko5kNRS2EZ+V1ySmSnwOJ64JInk5qmBf/jJv/Xcak3odp1IsZ3Yg0ZXYJSj0hmcgFRhBRn7vzZ67WRBAv69kcZNY9GTMZktxiyqbcJhuwRAdCRlxAM3xHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yoTby9ct0vxVKAUMvwbhURvMRMtDZTCIToUhzGW0YM=;
 b=l2wdSrAlU/FIKYuVfapFH0x+wgyF7aREg08YlaafPP5QP/9Gc4Rg9UGtgbp0kkXIAmkcoQ7uBhzeJpUktY7r4C8r+uDB3IlfV0Mfy3CgEbtOHjROfI4G5bg7Y8vj1zcn0RQPCrr4PRT+UPomCxOkoSQoCh+sWdkBZVLzB+u/nlsaCF21a0g8Jc+3fbiskhQYX6SyeHetiWS5FaNvFaxYGmsSopUON4ak6gQ4+TzYPIEmDhImeNz5gRuEsVDGtpL3qHk9S9gkThUAMRfdWX9wXJXw1oee7IX/LwTsN5CsTodYMJpRp+cgi0g/Vyy7YhiQ8vfSOkDgxkcj2IKA82nPCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 06:25:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:25:55 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
 <20240627113328.ozqkzhloufrpsdcr@quack3>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Jan Kara <jack@suse.cz>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 06/13] mm/memory: Add dax_insert_pfn
Date: Fri, 06 Sep 2024 16:21:53 +1000
In-reply-to: <20240627113328.ozqkzhloufrpsdcr@quack3>
Message-ID: <87seudb8nm.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::34) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: d1de8f71-9409-408a-0f4b-08dcce3cc320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tOlp9WHQB+SRopOWA1znLKekTVpxl1+0qy/BNtXEJ9XDOfHKUMH7zynvu/Q?=
 =?us-ascii?Q?50Mcygz/PTpkQR08YjUHKpEXia60P8QdQitKZ4eeoBDFi40eHC/ttgw0oHSb?=
 =?us-ascii?Q?/9ggp9Oq6bDek1rP0TN9KRnTVjBsFLSkKytgW32n/n4f+bSy4XKCWboMgb5p?=
 =?us-ascii?Q?ouK9netXEel2AW4ViSTO3Rm9OItA/kften8CWhY+t9f6TpqIWz4fSulNYp5O?=
 =?us-ascii?Q?qeJQp38NnZoGalWR7014UPjzEdzOkRf+oVLL6JvXZHzDF97iVsPi9zriwEct?=
 =?us-ascii?Q?XGHBs/bY64Y6gQweDbrgarg7BJrXpv6pWUu/n5gQ5nXUr9gwt0iCL+bDmSHK?=
 =?us-ascii?Q?B8jC8bp2UxBkWGBfA3D3WcqXEyYH6g2fZqPL71mr/xani/gOh3mYI6KYTxB1?=
 =?us-ascii?Q?307xuXNJExlbO7YM5gshdmX6epZfFAbyNhMkwRQoPAB/ZJ0XRukV1LIAby3k?=
 =?us-ascii?Q?NgjfKqP7y+wWX2pMg3Rz0S8OKeCGabBQcsndNgnSSFGM+yJknMz8L5vKHTvp?=
 =?us-ascii?Q?9h/zaB4HEzC+4y0ZMEDhJcRioMDnrlzoqyYvBPbjyy5pmFAg5n9eAB2Owxlo?=
 =?us-ascii?Q?nFsgDRKaEUdFXka5y8jT5fKq5csHygKXKwEFBDEqSS2QTs2Go048REhbthid?=
 =?us-ascii?Q?WMOcl0NDxGeU8QoYIqRoHh6jvtAlYw4MHA2pFH6kb2HDaXxeAIVHZq4ZQj3C?=
 =?us-ascii?Q?vh/gMeZY6SOw0aA/trOPod2kO8wDT2v9W4ONJZUz7lnQipOXA9aegDifJNCx?=
 =?us-ascii?Q?ZtPXXu3MAhbCHWRcuxZ5MoSsAzHy7S9k3uELbh8oScwiszl1BujyJOePlGCU?=
 =?us-ascii?Q?uXzOMc6CTbctHJgVUhRh8FeMYnQWTVdVn8nFeyAipcAtrLIyUlx63qrZWsjD?=
 =?us-ascii?Q?kyRmo8+AmZuveSj8bGkkhBciGGnLFg3HQjIb7Ool7DaWjBRPhmuxjJNPWUPV?=
 =?us-ascii?Q?MrNnik3GsyIc1n1jKBxU54oyuvwk2lrAdLWG6ltnoDqVAhjmhD0turmt7eT5?=
 =?us-ascii?Q?4eBFQ6QqXtj5VWzafnj43XbDeyS/cYDvCfzF/MCkZOGJmzGj91BPajMqxjB6?=
 =?us-ascii?Q?mrGh/+73tDvcuTzn6ESz2IPaTpgs/LcpjiXxXd/U23coEWXkWMOqP2TlB75a?=
 =?us-ascii?Q?fojTqfUXaUkJI82SFqHo5A2MoaRhYMuYIuZKoBDwrIqpPhCKTCcCX/DW4y00?=
 =?us-ascii?Q?h7Wu2RYzLi1BERBQHJp3jEL8sW2VYl/aXfa2ENKdF2D+Lw/QO2dzqwbR8vWW?=
 =?us-ascii?Q?SKWJ1RVPxUnOKHvAMIkRB+UOH1r2yIjaWRQVk+0gjNfod6sYhtOyStJAgbxo?=
 =?us-ascii?Q?+4I3Kx9Xc87ah6dsT+h26nWp5o1K4A/Uy9eP9SEXY1bhqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5re1mP/kGCdhCmJabWt2lZoVI4qc2rueOJciGra+YBTCenLV9nBpRwR1RC3?=
 =?us-ascii?Q?MJrvZQs09ied6+J0iKzgnhKh2ovopftWp1KRdf2oBlj706eghm9Ro8DZkSgT?=
 =?us-ascii?Q?SYmQgVvWsUbZ/CbNZ3kQNCixhDTcQhaMPdjPP+DkvTUz/92bAbjsZFZ0tJJ+?=
 =?us-ascii?Q?08iQtOtNySu878H/YyXUlTwyKqJNspFe0pm7lo3lrZBA0ekKXO0g3DqQh7Pf?=
 =?us-ascii?Q?T4Y0seetLSsrBXRECIsSN/oMFZ0gR/XR9TuU/6dP3UwfcCJE8s/WnupP6KxA?=
 =?us-ascii?Q?EWi8PDbyKSPEJ9Ego1MgV31E4Je6K3FXjnO1d23wqqtjXaneH/9G3Ja6UPg5?=
 =?us-ascii?Q?/AWibFuLU/dPHUogy3bc6Wol1OzMG2SQjtX7PYV0ZaB2OLgtCH0pF9k2TGhC?=
 =?us-ascii?Q?aqpOVszXZo9DfDLzKHrZC988LZa5U4ne0FbDAubKZ3h0qDkymcWsjpcMvLx+?=
 =?us-ascii?Q?gBbTeJIUON89Q/9NfVoV20awkbmufkZRKvZUoO/6epEez/8R0+1GC29gjvoX?=
 =?us-ascii?Q?oQKMEUCtz9avbVk2mbWo80Vx4q6qOakUUeoaulBnVNc/vQFnv/sU5Wdvsrcs?=
 =?us-ascii?Q?dW9f8BLTajRt1LI/HOWVFbpJnZPClPiPLFfTlce7rcSlx9wXXsbtOb7z7I11?=
 =?us-ascii?Q?U6juQc67I/jIsnPt7XoKxc/i4SU130Sxq8j5U8ITXZ9CgWJ4bpFra0syFnd5?=
 =?us-ascii?Q?TZFrBVt29nfWoKUOY9IQYcgi3xFKKTjta2djJLMw6L/iEYyKok0F/QuCn2eM?=
 =?us-ascii?Q?8/qhiY7qRT7oK/+ndgF0QWn3UYjVg/THE2vpIrN3iCvcfr5CvAEFjDLiOmvw?=
 =?us-ascii?Q?iPnHFsrz/YrenIVS5FXykAN2U+9L6gn/GTUlmN8XL36Rp2jJZcynsLi7wyto?=
 =?us-ascii?Q?HUAzGLn2YC3LRQY7xKiny+oIjVQ7SwYs6pFVAs+udzdHmhjmlzRLxocR+NRg?=
 =?us-ascii?Q?R20LbDITiiFG9OLb4g8dP+s6gBgkMuaP2wClJwtLPyN4kzTEl1t0kEvO18XJ?=
 =?us-ascii?Q?H62BvTQQkfRCT6XsEAJnlpPoIjLIbVUVtePmcsmSGJDFE4XWGj7vJ2ZkhoHD?=
 =?us-ascii?Q?dC/MXcHdQKBFavVM5C+60OrGD9SpAhW/rIfLXV3qKCcQGvFvB+m6y67kJxGz?=
 =?us-ascii?Q?ZXPklaqAj6VTcf+l8xOsa6O1/+OrWmDHJxD21H3aPzeCkDTGTmq3Tz+enDp1?=
 =?us-ascii?Q?dHyQSqZw5wYrIaflUd3awxp+w6PxkvPR4nQYcWPpZ/lOwaav7dusbPkdiDn7?=
 =?us-ascii?Q?nHvlkR/m/DSYUIr1iX6N6b89QCgxw9l9IOC4kW8kd1YTk70D2TMXW5JI8t0t?=
 =?us-ascii?Q?EpAn+DnEVFoFDDK5vXCu6J0UvGtylPJDLbjdhtLYow83REcLJLNT7Gci/Do8?=
 =?us-ascii?Q?OSbWoRjx8AAssnmOCgIebiHMce6hHstneD3EqBTl39HNH2ZIaFpOFXLKtSfr?=
 =?us-ascii?Q?WyPoFfaYa5lBhAbDrwIwdf1VxE6l5Hae6D3sS3TgZ7VWnihV8Bo2TNcA1q17?=
 =?us-ascii?Q?b/tFpmLwi60h37d3dn7c41jTN6FuyLcWYai1SZaYPUV68vRVoVcL0jS89Z9j?=
 =?us-ascii?Q?VnJxyaXARoRK2W3Eh8VUJ5qHB1EBFV4SoxJhKYrg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de8f71-9409-408a-0f4b-08dcce3cc320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:25:54.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWWF6kKX3e17lDUexyK5K3VWsHWh6s5wuAQONjytzomouWbo2hW1wZtSa53qWwo1/Oq8GG/krsEFCz9+cj/a3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815


Jan Kara <jack@suse.cz> writes:

> On Thu 27-06-24 10:54:21, Alistair Popple wrote:
>> Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
>> creates a special devmap PTE entry for the pfn but does not take a
>> reference on the underlying struct page for the mapping. This is
>> because DAX page refcounts are treated specially, as indicated by the
>> presence of a devmap entry.
>> 
>> To allow DAX page refcounts to be managed the same as normal page
>> refcounts introduce dax_insert_pfn. This will take a reference on the
>> underlying page much the same as vmf_insert_page, except it also
>> permits upgrading an existing mapping to be writable if
>> requested/possible.
>> 
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>
> Overall this looks good to me. Some comments below.
>
>> ---
>>  include/linux/mm.h |  4 ++-
>>  mm/memory.c        | 79 ++++++++++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 76 insertions(+), 7 deletions(-)
>> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 9a5652c..b84368b 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1080,6 +1080,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>>  struct mmu_gather;
>>  struct inode;
>>  
>> +extern void prep_compound_page(struct page *page, unsigned int order);
>> +
>
> You don't seem to use this function in this patch?

Thanks, bad rebase splitting this up. It belongs later in the series.

>> diff --git a/mm/memory.c b/mm/memory.c
>> index ce48a05..4f26a1f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1989,14 +1989,42 @@ static int validate_page_before_insert(struct page *page)
>>  }
>>  
>>  static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
>> -			unsigned long addr, struct page *page, pgprot_t prot)
>> +			unsigned long addr, struct page *page, pgprot_t prot, bool mkwrite)
>>  {
>>  	struct folio *folio = page_folio(page);
>> +	pte_t entry = ptep_get(pte);
>>  
>> -	if (!pte_none(ptep_get(pte)))
>> +	if (!pte_none(entry)) {
>> +		if (mkwrite) {
>> +			/*
>> +			 * For read faults on private mappings the PFN passed
>> +			 * in may not match the PFN we have mapped if the
>> +			 * mapped PFN is a writeable COW page.  In the mkwrite
>> +			 * case we are creating a writable PTE for a shared
>> +			 * mapping and we expect the PFNs to match. If they
>> +			 * don't match, we are likely racing with block
>> +			 * allocation and mapping invalidation so just skip the
>> +			 * update.
>> +			 */
>> +			if (pte_pfn(entry) != page_to_pfn(page)) {
>> +				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
>> +				return -EFAULT;
>> +			}
>> +			entry = maybe_mkwrite(entry, vma);
>> +			entry = pte_mkyoung(entry);
>> +			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
>> +				update_mmu_cache(vma, addr, pte);
>> +			return 0;
>> +		}
>>  		return -EBUSY;
>
> If you do this like:
>
> 		if (!mkwrite)
> 			return -EBUSY;
>
> You can reduce indentation of the big block and also making the flow more
> obvious...

Good idea.

>> +	}
>> +
>>  	/* Ok, finally just insert the thing.. */
>>  	folio_get(folio);
>> +	if (mkwrite)
>> +		entry = maybe_mkwrite(mk_pte(page, prot), vma);
>> +	else
>> +		entry = mk_pte(page, prot);
>
> I'd prefer:
>
> 	entry = mk_pte(page, prot);
> 	if (mkwrite)
> 		entry = maybe_mkwrite(entry, vma);
>
> but I don't insist. Also insert_pfn() additionally has pte_mkyoung() and
> pte_mkdirty(). Why was it left out here?

An oversight by me, thanks for pointing it out!

> 								Honza


