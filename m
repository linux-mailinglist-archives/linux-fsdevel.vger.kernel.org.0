Return-Path: <linux-fsdevel+bounces-32842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A069AF7AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 04:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6293CB21590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EA18B462;
	Fri, 25 Oct 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JYzKzjKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A733FE;
	Fri, 25 Oct 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824661; cv=fail; b=CsgCZnoH6FsTqxwdjUkDvlf1qkJF3eRQJUiA3lBX4nGG4aUETsFpGd7R7sUOGKmIKv/hRXBYAidYw11bvKVgZJkwciu9PTWn9ROIJVOIDckBxBKojAkvsi/hq0ceL7rhe9feGWAF1PrZLFQKpGS51RAt4XMVyXdLiBuI388wdDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824661; c=relaxed/simple;
	bh=XRMzeegvo1dbqyEIWrHODOBNW4vJ+kJOwxP7fkK7TaM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=OMCS+wRFbMG4SxRZpb+bHieHzvyxinbe84r045gMRK00pclUsQAPSllJGbxbPMTUaCXQR7zkd1k4Q+XNPHWNs1jWAyu9N5vkbMTP4JVaQZMHOeC7KInJmJlEWTRaHbkd4FZwEfGfFy24YuqLdOh5jo66Rjy+LqltOwvsK1lJSOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JYzKzjKj; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUCKl88CkkGpf6nm+f9j87XPL+aYXwEf7lqYJXoGJB7eXWDfQQdJnVB9CdGf6+4wBEA2WMN5ETWZ7Y0qaCpPbFYPJIvad++scSrf0Xb7UeZppwabaeFI0UfVGlg9qD2vQjRELqwwc/dfV2PgTiCafor7FPqupvGbTTr8YzatOchiYb0hiu2B4m9k4uFsG9/EIOT76JIbAF5hhuLk9K8BPMV2ZxESN8l00cKnOfy0DHIhD5biliTr8RlXfp/a+H/TgnXSyeWfk6iBevIdlPGO3ZJ4AQiy/udPBp0xjhd3YwfP+sBeEuw61t0QaboozXq29LuFoi7+uy3UyweaOERJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkG+uVth1OoTxfyLLPuX5muDMO7tVMEALUwB4D2e6dI=;
 b=NxHu3iMyrFekKfMkgObBLj4fucAzMM7987O5jaKpCKDUWqxY8zRLIoTb/J26WQOreC48NnumxZNIh39zTXrgqzaAAr76kCX8h5S8M/3J4d0P+2IilqRzOHiwOkxaqAlPYg/R1Mo8flet/vnz4Hpv3LcvyDgVmK84gyyRmppHB7+xT4mCamvIIelXGGoGMDmiFq46qUx2fFDjD4lGt4JBhTWmybseUneYDzw65cnaTmtmJuovBL3GKTEGAje3w3qhpZxrJ+p/R3dbyH2xUNVc1YmTRfmF73PWiHXWKoguJBWsfygdn6ipozdDQnuvLSWZ0ABz26rABlzH/OUiXCySIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkG+uVth1OoTxfyLLPuX5muDMO7tVMEALUwB4D2e6dI=;
 b=JYzKzjKjv6uUET4XvGl9+nqgTBNe8Uy5xXWU93Fl8UsjogIhPmaPx8i/5HOG9UTamHGqbsLw4eaVYwx62RX0Jyvp+MYWLBHMEs/cFJsYFmC3ovxIj0FWL19K7ookTIp5rd1FnIjGav+2Oi4Ycs5esTuHgowaEEBB7NATYBDsbre5mmZ72eXAlSj01RbVAqLdbCbLaqZnu26XJUs8aVnCKPdsH6JGXGKdouc2Gcf7evJaziNaognuSPbXxZwPNJkrcSQok/gCxgTCR04uCm5XjslW8a+tOtJARdrir49ZT2A1c0guNVkwaLop6UyeknQD1iYAmd/j9wtnKpy5sgoGzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 02:50:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 02:50:54 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
 <871q06c4z7.fsf@nvdebian.thelocal>
 <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
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
Date: Fri, 25 Oct 2024 13:46:30 +1100
In-reply-to: <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87seskvqt2.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0032.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c4c59a-1eb4-4fec-c6e5-08dcf49fd804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFiyYVcfpQXhCopRMqbzrF/8BDui77QmaZWzFYssmfAZ1TUiBHcyW+2xskqP?=
 =?us-ascii?Q?pdbGJ5le4If642wIdmGRM7vzNbS0qmvTQfvryMIsUydHtjJ72nnvf0kW2e8Q?=
 =?us-ascii?Q?5YRKKMUXW74JV99tof0XLYzCEmLxjfO3D9Q1IClJoofabxbmFw6LQ1AHCMsc?=
 =?us-ascii?Q?0rKaoMVh7mojs77sJFqkTKLf1wua0U8G9tCtVBrdyxlM3F7BPowF5hBfIqSX?=
 =?us-ascii?Q?TO/leKF8DSTWaCBnid36D6sMmcSyKrXOOfJH2l7M0X0ONvvMeiPkleF9wIOs?=
 =?us-ascii?Q?RzJl8TayCFq1ExQMZtrWludndCsr4STzU2GROiJtVVlYcjNbORxBonGxWK4Z?=
 =?us-ascii?Q?oXu5e2KWz45WJBJyQoHwknPn9v8XI+87LLrTSm8zyGYiMVxUa1QQ1um4U72+?=
 =?us-ascii?Q?qMBAngumFwz1Z9fvL1T6K29QWplRVi/Eq5Z23ledNg+v8DQAHg2cu4aZczRy?=
 =?us-ascii?Q?glb8ufxa8g70C+1CgzopnMNYCLNnp30JHMwfTRmzjUA1s4lQ0aNABueAmdgn?=
 =?us-ascii?Q?0K/wn7YZ4/e3wjeExoOdXpbv2jT+GGSwYjJxTNcf1vy2U1BGkpdKlADwA1yZ?=
 =?us-ascii?Q?ZnApfAlyLoMWGrQXKiN+RIqBLpP9MDy7jheYD9m883Q9liV/6OFP9mbJcJEb?=
 =?us-ascii?Q?6lrY86cFrwfMupJroLu8DOTTPcZS1PxFMzs1ADBXMNfb1nJN7/NXNSa3L10G?=
 =?us-ascii?Q?1LM93P2DaQddmMxoHSCFmtkZ3MRYCRlY5WR3aH7o4Cb9I/fRm07O4Kl6dCbG?=
 =?us-ascii?Q?MYsExgVbHfSyNpoh3g6GY+EW1tQsda0qXpGSXzlFKVxhMUIUd7EABEMJwgrH?=
 =?us-ascii?Q?2OXm9O34xh8KvEDGZaWA6hknEIDJf37VvMqtS1dl2X16KwLry7L7gcSI64l5?=
 =?us-ascii?Q?8ubFZ0GnwsDEJDLrcwBALbh7y2o5zC6uZtHqe4N4TaIWZi5aXhgxbQ6jGtRH?=
 =?us-ascii?Q?NW3yJFE/lGq2MV66TFF+BgWEvW2NM7pyVrtGR23H8iB0w6ew3K3C+lV2yHk8?=
 =?us-ascii?Q?cK85OZLWulyzkgqYuUKd0FNA05XKsZKxRWUsQRcMeONkQ9yp+/3de6IpsRC2?=
 =?us-ascii?Q?79/r28mveMK6CrT+WfhzLguLc6MjqrqQwnPcXZkHmO9p7rDOCvj3vWIbpzhg?=
 =?us-ascii?Q?49qANHJ8BoAbUVV62wJIc0TMAlKjkt9Lkn5GnID4TAK1yZQmoXborKMTywRe?=
 =?us-ascii?Q?QP6Qo2Mzp+DqtSOcBtwdhZ672Fbos1F+NXb04knYXfv/tyEodew+8hyu0bLk?=
 =?us-ascii?Q?EnIc5zYeBRa/N6+NhOR4rOZSV4hluCJTwdhsDIH223NZcVuIXTONQUsCoTtG?=
 =?us-ascii?Q?+cpuv2tESx5tsSZcn0po7a4p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muvGc1lHuFXH11dUwhS5/Lddz9uYwWAhyJPOwnrXCH3Ox5NV3VnLKgpyBquA?=
 =?us-ascii?Q?9I+p+/yR95vnWGUwW9zL1O9ODi86HJZMokP6zjAa87rPvfOOCL+wCqWDRtmt?=
 =?us-ascii?Q?dDzRMAYEvjA/4ImRZT9UmgQVyGQTo1Ir8jPtLj2YQCr6Z9k27LC0XGttdr1C?=
 =?us-ascii?Q?kcfnFYkHbq3HAncOaaPkuy0QZ9uCgSt7X+7avvQQO9WMAaj7FzEVxwe8IcM1?=
 =?us-ascii?Q?3K5LGY5U9nS9BReAA2Av25Mi7dQ8tYVyEEXd7kPalQwVh4aYP0XgeM6WaRHz?=
 =?us-ascii?Q?PjOr0pc1rTQaed9ovmAHYn4qrjFGQrOF0vWm/XrHav9R1eBUtH78rVWG4eLD?=
 =?us-ascii?Q?LM6UQ6jY8T1RJ9LziZMPG4XqcpyuethMKREiN6nxbAhSDgZk9dGG/j46+fbG?=
 =?us-ascii?Q?w7ajDoTiDCA+3+nvMGGxMzAzTsR9bUY56E97snIDsn5EqlgMwn2Rv5glE8V+?=
 =?us-ascii?Q?uyN+TrJfIz9JfFuRlRQ5Y6lyngt6IRe/Mj+6h9mDZFLPH8YBoIG/vW7BAWvj?=
 =?us-ascii?Q?/H7jadWhZLOtZjS6xvE+4iJoTlSZyZ/w9H+BBBuMjZkQJD+9sCY46+s0959L?=
 =?us-ascii?Q?7B3SoYicEXQGIESBEa2JZbmhS90BqXMD/nQS8nCFPvWajZBaelkY0suBQ4Vc?=
 =?us-ascii?Q?YoPNqxXktWH5M4mX0j2W+XunGC7aMwmocmflXUHeHEaIqsUeE+k2b+TE0yQn?=
 =?us-ascii?Q?LGgl0uquCsokeXcI5PfXCDY++T59jEMdGb5TvlhdInvLI/fKa1Zwd9J2p2PL?=
 =?us-ascii?Q?8plBwTQvnbzN/NFrmq6TaxeHdNEVMWA5ERSlNmNtpdCjp+fkHHpIFo2fsfbS?=
 =?us-ascii?Q?K7GIUL1QuaXqR1iBiAjbLE+f8VNpCs86xtotYgqBtRWx0RVY6ncFDWob5P6m?=
 =?us-ascii?Q?Hg0BGcyRdm7PJ4xz/kgNvR0rQUUQA/sKXIf9T81XN2+qynrlLv5p/p4iNlLW?=
 =?us-ascii?Q?UGS95Wq6XeaWaydOfmXF8nlS2kNPrCjgRPzeLvhSlldhK/CUuUcg4xHZsUh2?=
 =?us-ascii?Q?yVBY+uZ7CL6ezUu9Zle+efoase97kRRYjsXA7bkAM89ERxnFPPSmekquegqU?=
 =?us-ascii?Q?3IBAmL5D8kk8k/ez3ujONUd+FnCoHxo03LN4X9cu4BoAgLfS6wEyVG/Bx/mB?=
 =?us-ascii?Q?0PDFaui8byTlozIRIHPi5gzxAoq01vwGXkQL/vqBnmty5HJuBfGhIbOmuhnW?=
 =?us-ascii?Q?Ja42LpxLmPgHdqGUxY28ncr062cU30pPgqwx5fXgS0fBA0nAiQjRCNjSM9FF?=
 =?us-ascii?Q?JA40FO3gP/OH2y2qyG4W/kjYBbaOw4O1NwWVVSzhp/rJs/dqzkCMzOQ41g9h?=
 =?us-ascii?Q?PlaDKVu2lyi9IiBslOFcPxNBIMKPmwTfWsc0JJ+Urv46eydsy9yJrtKUe6rw?=
 =?us-ascii?Q?DYD/RpI1WABIUYgea5oHw5PVr1RruH6w1RFzC+sfQ1hA3VEGUr0wgJ+nlxSa?=
 =?us-ascii?Q?wnsDTMI+zczdaEC04sJznXfSURbhVQuhsgQ/yumYHFQGc6my1uwRBjWducQQ?=
 =?us-ascii?Q?bjazoEV8jTuGRFXX512yGwpg5hXTtiJIuzGrjK6Nps4d6L/XzDoOasKtTyOF?=
 =?us-ascii?Q?IukLV10CTcPWXyGW43WghkfD9Fq5MCfRn9GJOELc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c4c59a-1eb4-4fec-c6e5-08dcf49fd804
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:50:54.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVcbTI1QCpFpmxUyFycy/QZyd6tJdMTBuwZDrBG3S0DtWuJepMAyIwX3wzO33ek12haK6fcOsMVvMP0JMWk7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
> [..]
>> >
>> > Was there a discussion I missed about why the conversion to typical
>> > folios allows the page->share accounting to be dropped.
>> 
>> The problem with keeping it is we now treat DAX pages as "normal"
>> pages according to vm_normal_page(). As such we use the normal paths
>> for unmapping pages.
>> 
>> Specifically page->share accounting relies on PAGE_MAPPING_DAX_SHARED
>> aka PAGE_MAPPING_ANON which causes folio_test_anon(), PageAnon(),
>> etc. to return true leading to all sorts of issues in at least the
>> unmap paths.
>
> Oh, I missed that PAGE_MAPPING_DAX_SHARED aliases with
> PAGE_MAPPING_ANON.
>
>> There hasn't been a previous discussion on this, but given this is
>> only used to print warnings it seemed easier to get rid of it. I
>> probably should have called that out more clearly in the commit
>> message though.
>> 
>> > I assume this is because the page->mapping validation was dropped, which
>> > I think might be useful to keep at least for one development cycle to
>> > make sure this conversion is not triggering any of the old warnings.
>> >
>> > Otherwise, the ->share field of 'struct page' can also be cleaned up.
>> 
>> Yes, we should also clean up the ->share field, unless you have an
>> alternate suggestion to solve the above issue.
>
> kmalloc mininimum alignment is 8, so there is room to do this?

Oh right, given the aliasing I had assumed there wasn't room.

> ---
> diff --git a/fs/dax.c b/fs/dax.c
> index c62acd2812f8..a70f081c32cb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -322,7 +322,7 @@ static unsigned long dax_end_pfn(void *entry)
>  
>  static inline bool dax_page_is_shared(struct page *page)
>  {
> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> +	return folio_test_dax_shared(page_folio(page));
>  }
>  
>  /*
> @@ -331,14 +331,14 @@ static inline bool dax_page_is_shared(struct page *page)
>   */
>  static inline void dax_page_share_get(struct page *page)
>  {
> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> +	if (!dax_page_is_shared(page)) {
>  		/*
>  		 * Reset the index if the page was already mapped
>  		 * regularly before.
>  		 */
>  		if (page->mapping)
>  			page->share = 1;
> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> +		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;
>  	}
>  	page->share++;
>  }
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1b3a76710487..21b355999ce0 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -666,13 +666,14 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>  #define PAGE_MAPPING_ANON	0x1
>  #define PAGE_MAPPING_MOVABLE	0x2
>  #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
> -#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
> +/* to be removed once typical page refcounting for dax proves stable */
> +#define PAGE_MAPPING_DAX_SHARED	0x4
> +#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE | PAGE_MAPPING_DAX_SHARED)
>  
>  /*
>   * Different with flags above, this flag is used only for fsdax mode.  It
>   * indicates that this page->mapping is now under reflink case.
>   */
> -#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
>  
>  static __always_inline bool folio_mapping_flags(const struct folio *folio)
>  {
> @@ -689,6 +690,11 @@ static __always_inline bool folio_test_anon(const struct folio *folio)
>  	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
>  }
>  
> +static __always_inline bool folio_test_dax_shared(const struct folio *folio)
> +{
> +	return ((unsigned long)folio->mapping & PAGE_MAPPING_DAX_SHARED) != 0;
> +}
> +
>  static __always_inline bool PageAnon(const struct page *page)
>  {
>  	return folio_test_anon(page_folio(page));
> ---
>
> ...and keep the validation around at least for one post conversion
> development cycle?

Looks reasonable, will add that back for at least a development
cycle. In reality it will probably stay forever and I will add a comment
to the PAGE_MAPPING_DAX_SHARED definition saying it can be easily
removed if more flags are needed.

>> > It does have implications for the dax dma-idle tracking thought, see
>> > below.
>> >
>> >>  {
>> >> -	unsigned long pfn;
>> >> +	unsigned long order = dax_entry_order(entry);
>> >> +	struct folio *folio = dax_to_folio(entry);
>> >>  
>> >> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
>> >> +	if (!dax_entry_size(entry))
>> >>  		return;
>> >>  
>> >> -	for_each_mapped_pfn(entry, pfn) {
>> >> -		struct page *page = pfn_to_page(pfn);
>> >> -
>> >> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>> >> -		if (dax_page_is_shared(page)) {
>> >> -			/* keep the shared flag if this page is still shared */
>> >> -			if (dax_page_share_put(page) > 0)
>> >> -				continue;
>> >> -		} else
>> >> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>> >> -		page->mapping = NULL;
>> >> -		page->index = 0;
>> >> -	}
>> >> +	/*
>> >> +	 * We don't hold a reference for the DAX pagecache entry for the
>> >> +	 * page. But we need to initialise the folio so we can hand it
>> >> +	 * out. Nothing else should have a reference either.
>> >> +	 */
>> >> +	WARN_ON_ONCE(folio_ref_count(folio));
>> >
>> > Per above I would feel more comfortable if we kept the paranoia around
>> > to ensure that all the pages in this folio have dropped all references
>> > and cleared ->mapping and ->index.
>> >
>> > That paranoia can be placed behind a CONFIG_DEBUB_VM check, and we can
>> > delete in a follow-on development cycle, but in the meantime it helps to
>> > prove the correctness of the conversion.
>> 
>> I'm ok with paranoia, but as noted above the issue is that at a minimum
>> page->mapping (and probably index) now needs to be valid for any code
>> that might walk the page tables.
>
> A quick look seems to say the confusion is limited to aliasing
> PAGE_MAPPING_ANON.

Correct. Looks like we can solve that though.

>> > [..]
>> >> @@ -1189,11 +1165,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>> >>  	struct inode *inode = iter->inode;
>> >>  	unsigned long vaddr = vmf->address;
>> >>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
>> >> +	struct page *page = pfn_t_to_page(pfn);
>> >>  	vm_fault_t ret;
>> >>  
>> >>  	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
>> >>  
>> >> -	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>> >> +	page_ref_inc(page);
>> >> +	ret = dax_insert_pfn(vmf, pfn, false);
>> >> +	put_page(page);
>> >
>> > Per above I think it is problematic to have pages live in the system
>> > without a refcount.
>> 
>> I'm a bit confused by this - the pages have a reference taken on them
>> when they are mapped. They only live in the system without a refcount
>> when the mm considers them free (except for the bit between getting
>> created in dax_associate_entry() and actually getting mapped but as
>> noted I will fix that).
>> 
>> > One scenario where this might be needed is invalidate_inode_pages() vs
>> > DMA. The invaldation should pause and wait for DMA pins to be dropped
>> > before the mapping xarray is cleaned up and the dax folio is marked
>> > free.
>> 
>> I'm not really following this scenario, or at least how it relates to
>> the comment above. If the page is pinned for DMA it will have taken a
>> refcount on it and so the page won't be considered free/idle per
>> dax_wait_page_idle() or any of the other mm code.
>
> [ tl;dr: I think we're ok, analysis below, but I did talk myself into
> the proposed dax_busy_page() changes indeed being broken and needing to
> remain checking for refcount > 1, not > 0 ]
>
> It's not the mm code I am worried about. It's the filesystem block
> allocator staying in-sync with the allocation state of the page.
>
> fs/dax.c is charged with converting idle storage blocks to pfns to
> mapped folios. Once they are mapped, DMA can pin the folio, but nothing
> in fs/dax.c pins the mapping. In the pagecache case the page reference
> is sufficient to keep the DMA-busy page from being reused. In the dax
> case something needs to arrange for DMA to be idle before
> dax_delete_mapping_entry().

Ok. How does that work today? My current mental model is that something
has to call dax_layout_busy_page() whilst holding the correct locks to
prevent a new mapping being established prior to calling
dax_delete_mapping_entry(). Is that correct?

> However, looking at XFS it indeed makes that guarantee. First it does
> xfs_break_dax_layouts() then it does truncate_inode_pages() =>
> dax_delete_mapping_entry().
>
> It follows that that the DMA-idle condition still needs to look for the
> case where the refcount is > 1 rather than 0 since refcount == 1 is the
> page-mapped-but-DMA-idle condition.

Sorry, but I'm still not following this line of reasoning. If the
refcount == 1 the page is either mapped xor DMA-busy. So a refcount >= 1
is enough to conclude that the page cannot be reused because it is
either being accessed from userspace via a CPU mapping or from some
device DMA or some other in kernel user.

The current proposal is that dax_busy_page() returns true if refcount >=
1, and dax_wait_page_idle() will wait until the refcount ==
0. dax_busy_page() will try and force the refcount == 0 by unmapping it,
but obviously can't force other pinners to release their reference hence
the need to wait. Callers should already be holding locks to ensure new
mappings can't be established and hence can't become DMA-busy after the
unmap.

> [..]
>> >> @@ -1649,9 +1627,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>> >>  	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
>> >>  	bool write = iter->flags & IOMAP_WRITE;
>> >>  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
>> >> -	int err = 0;
>> >> +	int ret, err = 0;
>> >>  	pfn_t pfn;
>> >>  	void *kaddr;
>> >> +	struct page *page;
>> >>  
>> >>  	if (!pmd && vmf->cow_page)
>> >>  		return dax_fault_cow_page(vmf, iter);
>> >> @@ -1684,14 +1663,21 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>> >>  	if (dax_fault_is_synchronous(iter, vmf->vma))
>> >>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>> >>  
>> >> -	/* insert PMD pfn */
>> >> +	page = pfn_t_to_page(pfn);
>> >
>> > I think this is clearer if dax_insert_entry() returns folios with an
>> > elevated refrence count that is dropped when the folio is invalidated
>> > out of the mapping.
>> 
>> I presume this comment is for the next line:
>> 
>> +	page_ref_inc(page);
>>  
>> I can move that into dax_insert_entry(), but we would still need to
>> drop it after calling vmf_insert_*() to ensure we get the 1 -> 0
>> transition when the page is unmapped and therefore
>> freed. Alternatively we can make it so vmf_insert_*() don't take
>> references on the page, and instead ownership of the reference is
>> transfered to the mapping. Personally I prefered having those
>> functions take their own reference but let me know what you think.
>
> Oh, the model I was thinking was that until vmf_insert_XXX() succeeds
> then the page was never allocated because it was never mapped. What
> happens with the code as proposed is that put_page() triggers page-free
> semantics on vmf_insert_XXX() failures, right?

Right. And actually that means I can't move the page_ref_inc(page) into
what will be called dax_create_folio(), because an entry may have been
created previously that had a failed vmf_insert_XXX() which will
therefore have a zero refcount folio associated with it.

But I think that model is wrong. I think the model needs to be the page
gets allocated when the entry is first created (ie. when
dax_create_folio() is called). A subsequent free (ether due to
vmf_insert_XXX() failing or the page being unmapped or becoming
DMA-idle) should then delete the entry.

I think that makes the semantics around dax_busy_page() nicer as well -
no need for the truncate to have a special path to call
dax_delete_mapping_entry().

> There is no need to invoke the page-free / final-put path on
> vmf_insert_XXX() error because the storage-block / pfn never actually
> transitioned into a page / folio.

It's not mapping a page/folio that transitions a pfn into a page/folio
it is the allocation of the folio that happens in dax_create_folio()
(aka. dax_associate_new_entry()). So we need to delete the entry (as
noted above I don't do that currently) if the insertion fails.

>> > [..]
>> >> @@ -519,21 +529,3 @@ void zone_device_page_init(struct page *page)
>> >>  	lock_page(page);
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(zone_device_page_init);
>> >> -
>> >> -#ifdef CONFIG_FS_DAX
>> >> -bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
>> >> -{
>> >> -	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
>> >> -		return false;
>> >> -
>> >> -	/*
>> >> -	 * fsdax page refcounts are 1-based, rather than 0-based: if
>> >> -	 * refcount is 1, then the page is free and the refcount is
>> >> -	 * stable because nobody holds a reference on the page.
>> >> -	 */
>> >> -	if (folio_ref_sub_return(folio, refs) == 1)
>> >> -		wake_up_var(&folio->_refcount);
>> >> -	return true;
>> >
>> > It follow from the refcount disvussion above that I think there is an
>> > argument to still keep this wakeup based on the 2->1 transitition.
>> > pagecache pages are refcount==1 when they are dma-idle but still
>> > allocated. To keep the same semantics for dax a dax_folio would have an
>> > elevated refcount whenever it is referenced by mapping entry.
>> 
>> I'm not sold on keeping it as it doesn't seem to offer any benefit
>> IMHO. I know both Jason and Christoph were keen to see it go so it be
>> good to get their feedback too. Also one of the primary goals of this
>> series was to refcount the page normally so we could remove the whole
>> "page is free with a refcount of 1" semantics.
>
> The page is still free at refcount 0, no argument there. But, by
> introducing a new "page refcount is elevated while mapped" (as it
> should), it follows that "page is DMA idle at refcount == 1", right?

No. The page is either mapped xor DMA-busy - ie. not free. If we want
(need?) to tell the difference we can use folio_maybe_dma_pinned(),
assuming the driver doing DMA has called pin_user_pages() as it should.

That said I'm not sure why we care about the distinction between
DMA-idle and mapped? If the page is not free from the mm perspective the
block can't be reallocated by the filesystem.

> Otherwise, the current assumption that fileystems can have
> dax_layout_busy_page_range() poll on the state of the pfn in the mapping
> is broken because page refcount == 0 also means no page to mapping
> association.

And also means nothing from the mm (userspace mapping, DMA-busy, etc.)
is using the page so the page isn't busy and is free to be reallocated
right?

 - Alistair

