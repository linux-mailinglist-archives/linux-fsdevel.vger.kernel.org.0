Return-Path: <linux-fsdevel+bounces-31840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936A99C02B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16A11F2381C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAF01474B7;
	Mon, 14 Oct 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7+QUykD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E7136353;
	Mon, 14 Oct 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888000; cv=fail; b=hhh9ESQIS+OVWiaH3+gi0sPiCTVThUwIwwjrDAWYaIwQzhtGo7rRXMLPMg6eVQEaPErrMxhwpnD3WoSWJwL2xn0UgEDREuHe855im740wRo+0DH5AJrgLQXtm0GgGV2GP98Cl78+1SiclGQ6hOh0L5+BUJSy58B+VXGKA7oKXnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888000; c=relaxed/simple;
	bh=noMkz18MKn7LshTx2/4u+iBQBzNBDbPHSc+QCVRSF5Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ntk/adZIf5KeMBHl7LFTGlP4+5CSuTb1ORuQYKkx4gTtWkRsVGG1zyET1CPlKDJ15fXofDFM7988Ff5xiBpyiyaHxRuHaGntWyKKiM9LIx9O4Zz0TUuuwbsQ2vLdnlPiqV1Hh5JlOCGQbZQFqhexZw14+5LWhmKh8cQlX/KqgPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7+QUykD; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxHMq/TaJJGnDMqjO5UqyhnGxiFNLIZ1cxjD8BD3mTFqSDpy9oun+z48IHTlKUinfSjAgdM7UevFbt5V6rSFPqLGdFW1vU/TTA51MIpvoAhfugS4ySbSMyHu8F7xup/rDJy2mh+XQfjcdLwekfTwqfdDXXfhcWwYZdaEiajhhzlvBx4MdrEiIss5VwBFsUVIsjEYpd0a7rorhN+FqlmkGXDEBonREP99zbJ8WhGHFw3TKC0LMFKeu5/PyXdrne5A51QIFdkPC8ILXEj910BXCAQSDc7Hs/tJJn2/DLtggl9w2piAoSA3QTnC7ZRJsUsR/47439ziVaRbKps72e4WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLwKn/nX+sP3oDAAmyugPEk1aoaJonzyN5virtYmjMc=;
 b=SzrbZP09NBuKdfOOH8uaHkwo8OmW58dXhFWO3VU8FV/525nv5FsJw9rELilGhH+CRY4cfpjrssScgR05/+diS4WmqfwNlJQjixlwgqZi4NMmPBSTAS/MAZUTPTiXyFQv9LIGEBwXvuX/ADCNI1i/3gux67lZcvr8K/yppI+3KPI1yWXqHKuCODWRoIkXUfYlcH8yuPUpA/ejWzIWn65Lhi6RzCnOHcvTL359GPlJJ799JmO3xKfORLSHJjCVTytHDqJI5W20jtatFSX+9WlU101QJpZvyAOvhw6+WMxs8ET4Xl1usLAUPLpzsohW3Vr6V9vJFpjD5X5eQcmte1kFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLwKn/nX+sP3oDAAmyugPEk1aoaJonzyN5virtYmjMc=;
 b=O7+QUykDbAxI8gkVj80mhIVEsy0h+ShJ1OKzovGSKkvXu+5HHc8B++bVLz09qbDa23qbxFApM9ITgy00FCmIDrqFqQ0jDUHoKdsV3MqZu2Ldq1KS/SrKeoBOpLYUarACLKShdxE9yWUJwSDKspXUFKeUDKWR0KyrmP52J9h06KtFR1ZJGO96fQ0hdkFYa6rIr2Kp+mNgtWXpIgfw+qYwfVc7RL6U4ZmUcp3rmWRvDVEilrEYVh4ZCftk783LO0z5TfAB6IO/4hFqZO2Sjdtyiy3q7ZVW3UfrhVkfHplGCWSOM2XBswJ3N33OBfYfDJRSDKvsSlo956Hp5M6gCxXsBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.24; Mon, 14 Oct 2024 06:39:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:39:55 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <3ce22c7c8f00cb62e68efa5be24137173a97d23c.1725941415.git-series.apopple@nvidia.com>
 <66ef7bf0b1dfd_10a032946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
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
Subject: Re: [PATCH 06/12] huge_memory: Allow mappings of PUD sized pages
Date: Mon, 14 Oct 2024 17:33:44 +1100
In-reply-to: <66ef7bf0b1dfd_10a032946e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Message-ID: <87froznq6h.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0176.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e477d4-d962-4f7f-9439-08dcec1b03bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h32W7q4roQzeMYRp1tquXAGKToSfvrhm51ISXAFvrok+ipmQJI6az/l29lZC?=
 =?us-ascii?Q?BH/VW6hLPrzmlcLjIrSdHc11U5tarDEspxE4I70sGbv3SC37UMqPiBtCsn3W?=
 =?us-ascii?Q?7MaBKZymAu4yuEFeutdMKLK9IUnVb3kEhp5J/qpVVu290yxgUk2V9zD+71t+?=
 =?us-ascii?Q?Px4MqJETf65RIcqlfnK9QV98Z/sI/9aLPqhPdFpZYkpV+Jr3ohA2PjHidoQ6?=
 =?us-ascii?Q?Nr1kKLxjes89lB9X91e+xEsQrvlCSp3ghYLBUkVZ6vMKgWKutjJRmlgFfSrx?=
 =?us-ascii?Q?qmOQ2eOlj7+FechriqTzly477pnJJV+9tOc1bOUuNi1DJV9gtBbS3uwceyma?=
 =?us-ascii?Q?iBjgNaLiRHVao3wW3/3xoL7aEzD3eFBwWwkZ4XTbYDBLjNOcLv/gIGnBsFch?=
 =?us-ascii?Q?upYkVWuQ+3wH2S681GGrRGNrtVvRN4orZ0zCkvgJKBSQGWVZQjgRTpgv/D9+?=
 =?us-ascii?Q?2F2IM3+zxPfxTf/wq5ZLlsCYR7BZnP00Dop0Iy20A2aJLNtXim2aaOOfBVFb?=
 =?us-ascii?Q?8oZIOZBsvL8ykCZ2tCgbTlQs8CofDVLHgOemRs2xy/vVQRRYUu/B/wouSi4/?=
 =?us-ascii?Q?zibBnlEgjcoYfzjm+eRPkhaKrNat/YpIIyaiJ0g4ctJJ1f3fw0CXhVWGg8Qv?=
 =?us-ascii?Q?J0y1VJe2v+SEnwCxVG+CxzeuIeudv+zPjYDVE79B+nYui+B4W2sxXutG0UUA?=
 =?us-ascii?Q?iACuSS1qrjIeHKTjSgjw0KwrYyVNjpKGT2V8JJCtbDnZn7zmJVZsrKKHjwuI?=
 =?us-ascii?Q?kU/Ewij8TycZbEoXZR9pjmNthFXo5+/z1QIsHV5kubrtC2tPk2A9toUC5yf2?=
 =?us-ascii?Q?3lEz/H1bejWvv8bHRRNoiyXdyB2hyzb9NXb4iOz8pTSH0TND3SRPnxcG/Xw1?=
 =?us-ascii?Q?vwSdUsv/OHVAWE6PDneWr4ExdFAHNBQHTUPJdqpMFxnwH5rfPgP4JWrsJIPD?=
 =?us-ascii?Q?E+Scv/BDY6o+FT+X3ijyHC+2eYDIPRiqCYt2gzOld6m2J4sWa58+SsFtWrNp?=
 =?us-ascii?Q?dLfFMLvcEgvcSBLvFR2o0ZFcVCcg/ziNvj/qC+Fc2NsnTcXazVJpyxJexCg1?=
 =?us-ascii?Q?82iDW8VR/7lwjdEXfUUzKYZVcygg8+F57E+70vpJxbZAd+tvEG0n/7C2b6/h?=
 =?us-ascii?Q?GIHWVBVPk8yy8tR26VZnAOETLaf22Dd9EQTolnHIgB0ogwJphVR/Mtn6CP4+?=
 =?us-ascii?Q?UZidRiGEz8ZnlIHdFq3lyuM3BZq/ZTDdzPlcFa9MVhhU1ouYUALbTndwOABp?=
 =?us-ascii?Q?yqFF0MZuCOeIiPQbfxjVbKyXxiPEzwz/77lzAkQyiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjY0A3OWhIXPzJb2r+YPjKdnok/ywnJ9twk2PJjH5KM5g8O/k4tjlE2/AFTr?=
 =?us-ascii?Q?+rBZ0FTy7kWUfb2urXtL/TB1BzBGIokg25w0VGqGkptuHzr0CUsHi3SlAGqS?=
 =?us-ascii?Q?kdIsINbxbBfv+IkUC7aSR/rzT+63MGAxonYVoHWqyXPM31jm7C10NuDrKQH9?=
 =?us-ascii?Q?z2pjopjA2H/whras8PLGHDYmb5adcIFfXkhVlOTZ8EiwdRUYokU2XK8uth80?=
 =?us-ascii?Q?Sv5xnRIV8sKoRD6t5f7Zrclj3zp0Z+5vlcmjZYMy7Q3cCapYROISYZfFQLvF?=
 =?us-ascii?Q?TSvaJ4NsEHplf7YNq5baAoDV3SXzrXMTUzDfpdVL4fSFHp9+dX6yQ7AD7TjN?=
 =?us-ascii?Q?wwZN6w54hyAL9ddylREyMspPAYaclGtIUDsrUrqGAsRZIknl33WugaRXc0Id?=
 =?us-ascii?Q?HwGflbwFwPuU5LH2el9FqOskr6kzebo1rJFZ61S2jqVmqQvURQXOfnc45UMj?=
 =?us-ascii?Q?bZk0K9XmQlZFGqhVitWjK0D3LYov6ex5XUdhS9g/JaQtFJ/I9R/anVjBE9h+?=
 =?us-ascii?Q?SlOsbtzOfiBRMjBAAQ90FGuqjBNUDOXuIPlezuKW/ZoaHmDML64W2wEKXYEg?=
 =?us-ascii?Q?EMunrlLlGAjO0lbVMtekEz/Y4zND+6NkZJiYzkT4cSAEpb7k5ewfm9VFts8G?=
 =?us-ascii?Q?eLCRXamLvC4M1/J/vxYWk/9d9Vq+nalXMRqjy7uraArrl8XJ9hlpR5kN0Z56?=
 =?us-ascii?Q?MbR8EKbPPq4zp3emCAdprZtYkokH+TWzijqAv2pxOGF9ix36cj7Iy+S02kzb?=
 =?us-ascii?Q?gN1Cr5rQ6jPY14eGd4UlyQlgchuzbRS8wgtHkiv2uBqNqAx+rB2LnGf2SnM4?=
 =?us-ascii?Q?Q7LAZoOPLPhgpsodiJH5NxkhSR3S7sKALx5NQ7cPtMm+1aXp6ps9lW5iRvsb?=
 =?us-ascii?Q?WtPFGZdi3CwymGEsDhxbb0/0edlmuKxpi0LQQG8Ysf7kRwXzNkPutP2PEdxo?=
 =?us-ascii?Q?FpF3q1IIMlmbC6d/el6UC6dOo2g4yvh5F85vDNUlXWGmA2xIpQQWSH4NaFTB?=
 =?us-ascii?Q?yqPzMle4SR/dWTS9JjbzWGAaFJ1S0Dlk1C6GYvbAwqmAhcVIh395LqG6kJDX?=
 =?us-ascii?Q?5GBs5scCQixrqgWX/j+7wS/4HYg2//XZaosTwkZtmrdeyDvFYi6O5nRGCFi7?=
 =?us-ascii?Q?CZxooYst3qI73912GD68DyqAn/lyD2h36OJ3qGoqQwHOnEdItOgb6O5+E5yn?=
 =?us-ascii?Q?cVnHXoPY0iSX/hELHf3szVZRmMJvmtgrX5vBdMW2pHcI/G6p3sVSuDBwuap3?=
 =?us-ascii?Q?wbkufHTbRV4PJ41cYcOxJth7K9ghWth3T3IIXZRs/J8qn9pNIcy0q4yKnqFZ?=
 =?us-ascii?Q?vzbvfQQYcjhG4i94Pg5hMsnNIJm9q1uX0WCutY7I2ts7WMHKFFVkRfravZOE?=
 =?us-ascii?Q?1mfJf53GlbnaX5Ww4PavEAHb45JoEgpg2D+vpl8Oyinyd3Wg0pnspYL77sw0?=
 =?us-ascii?Q?GRCCaOG2++t6Rvac3GHvm93mwizgXzpvqzpzSdiX0BynH9Wl8xmkVycIVnO7?=
 =?us-ascii?Q?RurYf0xKJoeAofIlId5nZUEBIQhSyLLQpW1gAH13tasfOlE5sTGdXkpYuHEm?=
 =?us-ascii?Q?19XsZgVgIf7ATS1ZoCJqX8jzLCAY7oNQd5e/B5T9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e477d4-d962-4f7f-9439-08dcec1b03bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:39:55.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWaXyxpfhXjj3UlczjtMzC9TvKQPgfpecgOaJqNUjyyRuyhCOm7SRx8kdygjsmgyI+DXSUjFttkEhc1NF12u/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> Currently DAX folio/page reference counts are managed differently to
>> normal pages. To allow these to be managed the same as normal pages
>> introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
>> and take references as it would for a normally mapped page.
>> 
>> This is distinct from the current mechanism, vmf_insert_pfn_pud, which
>> simply inserts a special devmap PUD entry into the page table without
>> holding a reference to the page for the mapping.
>
> This is missing some description or comment in the code about the
> differences. More questions below:
>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |  4 ++-
>>  include/linux/rmap.h    | 15 +++++++-
>>  mm/huge_memory.c        | 93 ++++++++++++++++++++++++++++++++++++------
>>  mm/rmap.c               | 49 ++++++++++++++++++++++-
>>  4 files changed, 149 insertions(+), 12 deletions(-)
>> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 6370026..d3a1872 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  
>>  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  
>>  enum transparent_hugepage_flag {
>>  	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>> @@ -114,6 +115,9 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>>  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>>  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>>  
>> +#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
>> +#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
>> +
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  
>>  extern unsigned long transparent_hugepage_flags;
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 91b5935..c465694 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
>>  enum rmap_level {
>>  	RMAP_LEVEL_PTE = 0,
>>  	RMAP_LEVEL_PMD,
>> +	RMAP_LEVEL_PUD,
>>  };
>>  
>>  static inline void __folio_rmap_sanity_checks(struct folio *folio,
>> @@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
>>  		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>>  		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>>  		break;
>> +	case RMAP_LEVEL_PUD:
>> +		/*
>> +		 * Asume that we are creating * a single "entire" mapping of the
>> +		 * folio.
>> +		 */
>> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
>> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
>> +		break;
>>  	default:
>>  		VM_WARN_ON_ONCE(true);
>>  	}
>> @@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>  	folio_add_file_rmap_ptes(folio, page, 1, vma)
>>  void folio_add_file_rmap_pmd(struct folio *, struct page *,
>>  		struct vm_area_struct *);
>> +void folio_add_file_rmap_pud(struct folio *, struct page *,
>> +		struct vm_area_struct *);
>>  void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>  		struct vm_area_struct *);
>>  #define folio_remove_rmap_pte(folio, page, vma) \
>>  	folio_remove_rmap_ptes(folio, page, 1, vma)
>>  void folio_remove_rmap_pmd(struct folio *, struct page *,
>>  		struct vm_area_struct *);
>> +void folio_remove_rmap_pud(struct folio *, struct page *,
>> +		struct vm_area_struct *);
>>  
>>  void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>  		unsigned long address, rmap_t flags);
>> @@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>>  		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>>  		break;
>>  	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>  		atomic_inc(&folio->_entire_mapcount);
>>  		atomic_inc(&folio->_large_mapcount);
>>  		break;
>> @@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>>  		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>>  		break;
>>  	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>  		if (PageAnonExclusive(page)) {
>>  			if (unlikely(maybe_pinned))
>>  				return -EBUSY;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c4b45ad..e8985a4 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1336,21 +1336,19 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>>  	struct mm_struct *mm = vma->vm_mm;
>>  	pgprot_t prot = vma->vm_page_prot;
>>  	pud_t entry;
>> -	spinlock_t *ptl;
>>  
>> -	ptl = pud_lock(mm, pud);
>>  	if (!pud_none(*pud)) {
>>  		if (write) {
>>  			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
>>  				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
>> -				goto out_unlock;
>> +				return;
>>  			}
>>  			entry = pud_mkyoung(*pud);
>>  			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
>>  			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
>>  				update_mmu_cache_pud(vma, addr, pud);
>>  		}
>> -		goto out_unlock;
>> +		return;
>>  	}
>>  
>>  	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
>> @@ -1362,9 +1360,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>>  	}
>>  	set_pud_at(mm, addr, pud, entry);
>>  	update_mmu_cache_pud(vma, addr, pud);
>> -
>> -out_unlock:
>> -	spin_unlock(ptl);
>>  }
>>  
>>  /**
>> @@ -1382,6 +1377,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>>  	unsigned long addr = vmf->address & PUD_MASK;
>>  	struct vm_area_struct *vma = vmf->vma;
>>  	pgprot_t pgprot = vma->vm_page_prot;
>> +	spinlock_t *ptl;
>>  
>>  	/*
>>  	 * If we had pud_special, we could avoid all these restrictions,
>> @@ -1399,10 +1395,52 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>>  
>>  	track_pfn_insert(vma, &pgprot, pfn);
>>  
>> +	ptl = pud_lock(vma->vm_mm, vmf->pud);
>>  	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
>> +	spin_unlock(ptl);
>> +
>>  	return VM_FAULT_NOPAGE;
>>  }
>>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
>> +
>> +/**
>> + * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
>> + * @vmf: Structure describing the fault
>> + * @pfn: pfn of the page to insert
>> + * @write: whether it's a write fault
>
> It strikes me that this documentation is not useful for recalling why
> both vmf_insert_pfn_pud() and dax_insert_pfn_pud() exist. It looks like
> the only difference is that the "dax_" flavor takes a reference on the
> page. So maybe all these dax_insert_pfn{,_pmd,_pud} helpers should be
> unified in a common vmf_insert_page() entry point where the caller is
> responsible for initializing the compound page metadata before calling
> the helper?

Honestly I'm impressed I wrote documentation at all :-) Even if it was
just a terrible cut-and-paste job. What exactly do you mean by
"initializing the compound page metadata" though? I assume this bit:

	folio_get(folio);
	folio_add_file_rmap_pud(folio, page, vma);
	add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);

Problem with doing that in the caller is that at the very least
folio_add_file_rmap_*() calls need to happen under PTL. Of course the
point on lack of documentation still stands, and as an aside my original
plan was to remove the vmf_insert_pfn* variants as dead-code once DAX
stopped using them, but Peter pointed out this series which added some
callers:

https://lore.kernel.org/all/20240826204353.2228736-20-peterx@redhat.com/T/

>> + *
>> + * Return: vm_fault_t value.
>> + */
>> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	unsigned long addr = vmf->address & PUD_MASK;
>> +	pud_t *pud = vmf->pud;
>> +	pgprot_t prot = vma->vm_page_prot;
>> +	struct mm_struct *mm = vma->vm_mm;
>> +	spinlock_t *ptl;
>> +	struct folio *folio;
>> +	struct page *page;
>> +
>> +	if (addr < vma->vm_start || addr >= vma->vm_end)
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	track_pfn_insert(vma, &prot, pfn);
>> +
>> +	ptl = pud_lock(mm, pud);
>> +	if (pud_none(*vmf->pud)) {
>> +		page = pfn_t_to_page(pfn);
>> +		folio = page_folio(page);
>> +		folio_get(folio);
>> +		folio_add_file_rmap_pud(folio, page, vma);
>> +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
>> +	}
>> +	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
>> +	spin_unlock(ptl);
>> +
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_insert_pfn_pud);
>>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>  
>>  void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>> @@ -1947,7 +1985,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  			zap_deposited_table(tlb->mm, pmd);
>>  		spin_unlock(ptl);
>>  	} else if (is_huge_zero_pmd(orig_pmd)) {
>> -		zap_deposited_table(tlb->mm, pmd);
>> +		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
>> +			zap_deposited_table(tlb->mm, pmd);
>
> This looks subtle to me. Why is it needed to skip zap_deposited_table()
> (I assume it is some THP assumption about the page being from the page
> allocator)? Why is it ok to to force the zap if the arch demands it?

We don't skip it - it happens in the "else" clause if required. Note
that vma_is_special_huge(dax_vma) == True. So the checks are to maintain
existing behaviour - previously a DAX VMA would take this path:

        if (vma_is_special_huge(vma)) {
                if (arch_needs_pgtable_deposit())
                        zap_deposited_table(tlb->mm, pmd);
                spin_unlock(ptl);

Now that DAX pages are treated normally we need to take the "else"
clause. So in the case of a zero pmd we only zap_deposited_table() if it
is not a DAX VMA or if it is a DAX VMA and the arch requires it, which is
the same as what would happen previously.

Of course that's not to say the previous behaviour was correct, I am far
from an expert on the pgtable deposit/withdraw code.

>>  		spin_unlock(ptl);
>>  	} else {
>>  		struct folio *folio = NULL;
>> @@ -2435,12 +2474,24 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
>>  	arch_check_zapped_pud(vma, orig_pud);
>>  	tlb_remove_pud_tlb_entry(tlb, pud, addr);
>> -	if (vma_is_special_huge(vma)) {
>> +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
>
> If vma_is_special_huge() is true vma_is_dax() will always be false, so
> not clear to me why this check is combined?

Because that's not true:

static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
{
	return vma_is_dax(vma) || (vma->vm_file &&
				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
}

I suppose there is a good argument to change that now though. Thoughts?

>>  		spin_unlock(ptl);
>>  		/* No zero page support yet */
>>  	} else {
>> -		/* No support for anonymous PUD pages yet */
>> -		BUG();
>> +		struct page *page = NULL;
>> +		struct folio *folio;
>> +
>> +		/* No support for anonymous PUD pages or migration yet */
>> +		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
>> +
>> +		page = pud_page(orig_pud);
>> +		folio = page_folio(page);
>> +		folio_remove_rmap_pud(folio, page, vma);
>> +		VM_BUG_ON_PAGE(!PageHead(page), page);
>> +		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
>> +
>> +		spin_unlock(ptl);
>> +		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
>>  	}
>>  	return 1;
>>  }
>> @@ -2448,6 +2499,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>  		unsigned long haddr)
>>  {
>> +	pud_t old_pud;
>> +
>>  	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
>>  	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>>  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
>> @@ -2455,7 +2508,23 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>  
>>  	count_vm_event(THP_SPLIT_PUD);
>>  
>> -	pudp_huge_clear_flush(vma, haddr, pud);
>> +	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
>> +	if (is_huge_zero_pud(old_pud))
>> +		return;
>> +
>> +	if (vma_is_dax(vma)) {
>> +		struct page *page = pud_page(old_pud);
>> +		struct folio *folio = page_folio(page);
>> +
>> +		if (!folio_test_dirty(folio) && pud_dirty(old_pud))
>> +			folio_mark_dirty(folio);
>> +		if (!folio_test_referenced(folio) && pud_young(old_pud))
>> +			folio_set_referenced(folio);
>> +		folio_remove_rmap_pud(folio, page, vma);
>> +		folio_put(folio);
>> +		add_mm_counter(vma->vm_mm, mm_counter_file(folio),
>> +			-HPAGE_PUD_NR);
>> +	}
>
> So this does not split anything (no follow-on set_ptes()) it just clears
> and updates some folio metadata. Something is wrong if we get this far
> since the only dax mechanism that attempts PUD mappings is device-dax,
> and device-dax is not prepared for PUD mappings to be fractured.

Ok. Current upstream will just clear them though, and this just
maintains that behaviour along with updating metadata. So are you saying
that we shouldn't be able to get here? Or that just clearing the PUD is
wrong? Because unless I've missed something I think we have been able to
get here since support for transparent PUD with DAX was added.

> Peter Xu recently fixed mprotect() vs DAX PUD mappings, I need to check
> how that interacts with this.


