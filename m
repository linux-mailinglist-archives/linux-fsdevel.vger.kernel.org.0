Return-Path: <linux-fsdevel+bounces-31843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A699C096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731E61F2317F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB25145FEB;
	Mon, 14 Oct 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbzVm7yL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF836B;
	Mon, 14 Oct 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889282; cv=fail; b=WDBwXw/H9sTnefSZkwQaect5ACa74VDqHuAp3comNhD0PvelT/L/OGvkVTN164MJ5KDU7lQZnATYno3xJZY3/fFau2QGroUXHmITD2n2SbjKeqKo3ZRf0TAcgV4JbdmKtb6+EEN0ZWwQxW253vscAHSl5/gD8csW2oP+IHWudRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889282; c=relaxed/simple;
	bh=l8aYE8+XBc5wQ9id9Dr4a3Sucg89rd5NETTVlvQbj64=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=hcuMtJknAWdxlD0J/qobrO+IIPkbiDjnC1+GVIZE977VgRZa1IoahS2r/k7gyEfPMcFlRsf/+Fq4Bt2ejRrWyV9XTIseiHHGydoz8ODgdNQcGZSwk/A5t4VFDiie4/fwuYzrsJFZlwtlysG5YZJOMWkxDfHjLxVzwfxYEQ9pmnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbzVm7yL; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZH8W7m8RDZvTzQWZF4kfcvbB23XHRuv0y4bclDlJ16RIdzQ2FXRDQNLymL8mPvWk05wKBAwTFzYLC1wYLG/7Php2LKG5hs+0FzKCHT3nbbrVM268ohWZ5NAyFJqXI2BJEvVnzMm7xJndsMsjUO3kDr35dCiBwOfneKZDiWWSaL7pczulOZa6t44tEbfn0zfvwvsOn8iVOjrtoR8i4IBeVsrsReSjBvqt6nyqvjlLzDjMsB23rABFe9hhbb7Ffjx5QXOSc5QlQ+IMU1VD6mifi3VzRBArhjtIrTqQw3jCf34F4dFzFUXHsykQSlwxBSTgLdGlHXMkwa8gto9XEy4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rj4liE+nAGg3enls3Y5AUIvOCOxDAKVnKTLG4VPep8=;
 b=IiVqo9QC7LTLIinGxdwbPGUPtiLF31wj0TZ256ixpObSWdTQcrwNdq6DpNCw/tHD2K9UJYF0fbh+rfuk+L/vZ/2LLLFeE2RhVeW4zqag2veakbLbp03r1nj83wCKfHhhzlGiCo0ez8QroMM3f42gEEreGDHKad9VLw4LIS6XPgtfZVp6Aq3Hx2JKwi+4H8DFhOygZHt/YbvIqRMmoTWr4tTPG6MZYaVwFqvhNmPC3D3h1Od9JjRo9YnCRLy6vNWYFf9IWg2T/iS+gRcWH/NWNPTLNBtveiJQETMN5Y9qyeoTMeFiUO+pAAeiuY0RR+c6v08ulVnt6362UdG0bKv/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rj4liE+nAGg3enls3Y5AUIvOCOxDAKVnKTLG4VPep8=;
 b=DbzVm7yL+7v/jqR//jgdbw4u4hnyVXui6H5+iWpUznqt8Jg781uvlikekFrQRe57tFsR+H19aYfKGOqeo2hwJTiwI+Tr0yEM6smE9z5V7WH81S5tnjJduuhiqkHXp61XYhBhUCU2rWQtV6gqj272Xk1YrSxlG6PI5H66nxBX62MVBHgNYX+NlSoz+g2s+HN6JlbJWCnvFGgVycZR/cm/31+jdrtf3bBOO3u8+DZBOlLQHK88G1r1YdYhPEC5DoPTqyrEoqmQ+jr8fIH7IqSMJm7rBfgeZUGt3wgdYjpdRKU8zbz1+NGrACELO3kEWPbhmXNkRrd9e/OQd996B+6fSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 07:01:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:01:17 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <b63e8b07ceed8cf7b9cd07332132d6713853c777.1725941415.git-series.apopple@nvidia.com>
 <66f61ce4da80_964f2294fb@dwillia2-xfh.jf.intel.com.notmuch>
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
Subject: Re: [PATCH 07/12] huge_memory: Allow mappings of PMD sized pages
Date: Mon, 14 Oct 2024 17:53:31 +1100
In-reply-to: <66f61ce4da80_964f2294fb@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87bjznnp6v.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: b26c1e96-3370-46c8-ceb0-08dcec1dffee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGDF1BXGH0UDQ7Xs0LKKj0xdRK6gz7LGKn5hinc8r/rHB9V6qMC8AO97CGCu?=
 =?us-ascii?Q?vZZNvAJMF0bpJaJbfGckDjkeEOjwu6pLXj+FY1YgvGSu5gtUpeCGnbK/EY1K?=
 =?us-ascii?Q?JwR00Kgfb4cWNStMTbMX85AZC8md1v4a/s/zMCVoLHsYdgdYKoPG3AYu7ReY?=
 =?us-ascii?Q?ELxZ2n6T11lZaayiqQGTM4lOVdTTRJMwsLXLO01Qz7mi+i+La6ub0GMQOCXD?=
 =?us-ascii?Q?6ZKj3IQvLozwjWzRZTkfHGJRWQPJwseSUdRfZGoKfzt94lQVS5hbCzhJXK5X?=
 =?us-ascii?Q?tdXH4xaqPUseT7wnA1L+kRcFfMeZdPKulDjZJJpCCD4gHB0eTyTKFTntI+Jn?=
 =?us-ascii?Q?Rq4NhxwTsgNDHIEiD0n6ZQf3oz7ePDQeUzx2XoElX1SVqRli4qVqFHCIvJIc?=
 =?us-ascii?Q?+r0J8oPeg17dzFDk33BFs83RpRyZm+BPYe7wa4/8nzzVw7KVsdaW4BktXgH4?=
 =?us-ascii?Q?gwWNaQXH/dBisipk+zLcSKdUMYcNnOKVWXgxTDAsXnQyOnn3ORt1DdhXFHfX?=
 =?us-ascii?Q?l9Q5nD84INng0XQSB2ccPla5tjfz5ORrjkYOZo7akfGkqgfSNRaGSQHOcEVY?=
 =?us-ascii?Q?2xU548VWt4mcicDyXDAOVwaCcCXoTw5m7SLdghSZDzydbPE9GpHoBEQx25WX?=
 =?us-ascii?Q?snYI5uK37tI7NfwPazwIvfBylvtFWqaDrP2QFpD/Yhs9pGjWA1dUdVfc3B3d?=
 =?us-ascii?Q?DisOpZ8TR4V1nFsGqETiLeAdgYUxEQhxZ5V6xzZ6GV6jJh/Jv91u4aFwMBPX?=
 =?us-ascii?Q?oYdZwxgm2q7UVX60+Y1OOipWSwHB6CGjrgnsE0nrJDNj1ncNbszs0uZ1w419?=
 =?us-ascii?Q?hgiGikyQJSCLp0F1AfBZw8fyrIpahW3ATdg7JkurNxLyyMElAmJEMoRPuqhl?=
 =?us-ascii?Q?dZtjaiI/+1KPja+IG6KwTgtj2PVFj73ZyqO7HX7ny8rtuMgdyD7qEIwb+4GO?=
 =?us-ascii?Q?riOk/7iC/uKCCZVmCuOwzaNxeJ2rDMWORIn3n/vEiU093xF5qzkpqUwUeSO5?=
 =?us-ascii?Q?yCdK01GBVztuBmOJUmtAv+YzM/Vcq2jDfR413fqJX0/TMZ+BgFEL9swqI4Zk?=
 =?us-ascii?Q?0Zvit1aa0NL2pkPsmaZU2fGeXWWctv5Sa3zJvEaKv+1QUo0KFtJHkKEREypu?=
 =?us-ascii?Q?4SDTfCw31W/jRYyeW6TAvukbrVT0bwtxbwEXduxaD5U2VtFaCz4uzcVZapLJ?=
 =?us-ascii?Q?ZKTf8IFLnDPGiFF9et+9fvpfdFVS3jJUoq2pO6MFJiG8uqkxgq3CUe9b8O8B?=
 =?us-ascii?Q?TmvjMHM0696jCzy3YBR0DKhGBNLH6pvGmMoWm+PnqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0TPU1SvhHpmmA1JjJ/LmeZi3naKyOFBl9goRzu4U9IV2Z7iPL3ENRar+OceS?=
 =?us-ascii?Q?xb5VC9B3fa7/U1qhQa8ZPkGAJIvuKovo6a7KED1kwnGCMT02RzD0+fa4nWBS?=
 =?us-ascii?Q?yBJjqGJZoh4ysHTbUBZM0Tw3pckuaU0lSi8UAJT6YsBr5ZQalOKJDlYBzYvT?=
 =?us-ascii?Q?Go4sTUlblDhXj1txcMqb0N3QtAub3NKI9Z3gjaKoFHaGvjMjyBl8e6NKxH4M?=
 =?us-ascii?Q?MKku3QZQMACwCtdJm4mt6rMIYbptn1rw7VZTIyTYAoxBkeKW0dsO8CRzH1hW?=
 =?us-ascii?Q?1nIfIGW8IjBSAFVwZLxTTlYG+WhRQ75Rt6wR6D8g5LT/JCSCgKsShOhVM2a7?=
 =?us-ascii?Q?CQluY3zC35ACQsAiH+5RfaNaUPet3DcGOol0cE3OmWgk4cfcnywnnr4im0FY?=
 =?us-ascii?Q?d5QUvxOCEJlZT7+7DiHwevLFPuz+z+zLzvSRmPSqoqiBvoIkBpfmbl0JibFJ?=
 =?us-ascii?Q?hWwLPnwb8EAMijCVvJCaYPyZQ5oMz3LjNRfyx2x3gJY1xPQC6fw9DsQctoQF?=
 =?us-ascii?Q?bEdjzDgtF/nt6tYAuBI5eJdPnENZk/EcoWVTL5wYWWjmCdftJfDv0uMbvGwO?=
 =?us-ascii?Q?wW23t2VAFN90Z3PuN9ZAAElrV6RBZELBgjtKLM2Doj//raSCErT6FTwHlWDT?=
 =?us-ascii?Q?yEu7VQxw16Wff4pjkZhcMs8JfsmK85NsWqDEZ2g6T/06UpANcD+y3T+J8VZG?=
 =?us-ascii?Q?O+ycWcgwGAR9mp8JLvDevKHeYEGxuxxzOVB7hA0FhN1FAQOsezZBVxMOnIfQ?=
 =?us-ascii?Q?Rdmgw3VnqRNMc8BlfrzXHHLduhUizraBU3iQLQ6fm0MV5QowgWUDZV1407cb?=
 =?us-ascii?Q?W1G1FQKm58k9StkxzaWBY3pV5NNLbox6GorjaYPAYG+SVALpl3bSysGUcetl?=
 =?us-ascii?Q?hUBXb22O16IEjQHmpD0hXytS1cg0V+CXOraBVUz3Wro42dswAo+2koaKMofg?=
 =?us-ascii?Q?Fil01qZuMKDlhDSIyh80iyiDXr+qZfWa8keYpl7VODYXRKUwF+nRLnKXgoG6?=
 =?us-ascii?Q?esPmN++6KMJgzrt4Dd26Fk3IeeiArdoN6nQ8InfUmquO45FrHjw5DWhzN4xD?=
 =?us-ascii?Q?BxKlyi/5CpZ0wbMY2A8CG+X4Ih+Ak0xBG90XYk8Mu6KskogVjWhamxAF5PBU?=
 =?us-ascii?Q?ZJDc8/+U/eQxJAhvByVvW8anL/scNWATxJo7SwbswtWDQagDeCKHfRnHsp+A?=
 =?us-ascii?Q?zoxf14hEh4SzlJLXKJUbnRqbd2n8OGzAjt5B/955wN3H1VcjySQmNsIy+zp7?=
 =?us-ascii?Q?niFwlaJw1tcurk6zdQBTpbS+yfC3BamRUWYrNEqUQzzJqkcRbo4IUQ6C5BQI?=
 =?us-ascii?Q?j0NB+eP0c/IV8CR4r41f/1/VSuKxwVUzFaQLErbJMgeVgdnRF+5mQcejLrd5?=
 =?us-ascii?Q?Y38CBwvDMV0QhAdcroXqRSktGdLuZbxDccWudR/fOAdpqQ+Y2rDGpbnXn7A7?=
 =?us-ascii?Q?/p9h4b/F3rSuuDVcxA2UfLFwQPzqY3VSRVKSoN1G/oqnD8rmh64k7lNWQZUA?=
 =?us-ascii?Q?0P1czWotIbR6NK62NFB+Lpaiz5Y+SSO29cOtIetIvZXYtrZfwIpwIXbY2uaY?=
 =?us-ascii?Q?mHRg2xRaZbfxNzHaBHBlC/TBLXZ/Kb6gLu99xBFL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26c1e96-3370-46c8-ceb0-08dcec1dffee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:01:17.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTGz8qtewlcvtX+p/StLfJ9DC29aqKXiXfCALHUO+zb1unIPGISE4yJelwmAKk0kuFHkYin9wOloNYPvljI24g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> Currently DAX folio/page reference counts are managed differently to
>> normal pages. To allow these to be managed the same as normal pages
>> introduce dax_insert_pfn_pmd. This will map the entire PMD-sized folio
>> and take references as it would for a normally mapped page.
>> 
>> This is distinct from the current mechanism, vmf_insert_pfn_pmd, which
>> simply inserts a special devmap PMD entry into the page table without
>> holding a reference to the page for the mapping.
>
> It would be useful to mention the rationale for the locking changes and
> your understanding of the new "pgtable deposit" handling, because those
> things make this not a trivial conversion.

My intent was not to change the locking for the existing
vmf_insert_pfn_pmd() but just to move it up a level in the stack so
dax_insert_pfn_pmd() could do the metadata manipulation while holding
the lock. Looks like I didn't get that quite right though, so I will
review it for the next version.

>> 
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  include/linux/huge_mm.h |  1 +-
>>  mm/huge_memory.c        | 57 ++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 48 insertions(+), 10 deletions(-)
>> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index d3a1872..eaf3f78 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -40,6 +40,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  
>>  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>> +vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>>  
>>  enum transparent_hugepage_flag {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e8985a4..790041e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1237,14 +1237,12 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>  {
>>  	struct mm_struct *mm = vma->vm_mm;
>>  	pmd_t entry;
>> -	spinlock_t *ptl;
>>  
>> -	ptl = pmd_lock(mm, pmd);
>>  	if (!pmd_none(*pmd)) {
>>  		if (write) {
>>  			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
>>  				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
>> -				goto out_unlock;
>> +				return;
>>  			}
>>  			entry = pmd_mkyoung(*pmd);
>>  			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>> @@ -1252,7 +1250,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>  				update_mmu_cache_pmd(vma, addr, pmd);
>>  		}
>>  
>> -		goto out_unlock;
>> +		return;
>>  	}
>>  
>>  	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>> @@ -1271,11 +1269,6 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>>  
>>  	set_pmd_at(mm, addr, pmd, entry);
>>  	update_mmu_cache_pmd(vma, addr, pmd);
>> -
>> -out_unlock:
>> -	spin_unlock(ptl);
>> -	if (pgtable)
>> -		pte_free(mm, pgtable);
>>  }
>>  
>>  /**
>> @@ -1294,6 +1287,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
>>  	struct vm_area_struct *vma = vmf->vma;
>>  	pgprot_t pgprot = vma->vm_page_prot;
>>  	pgtable_t pgtable = NULL;
>> +	spinlock_t *ptl;
>>  
>>  	/*
>>  	 * If we had pmd_special, we could avoid all these restrictions,
>> @@ -1316,12 +1310,55 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
>>  	}
>>  
>>  	track_pfn_insert(vma, &pgprot, pfn);
>> -
>> +	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>  	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
>> +	spin_unlock(ptl);
>> +	if (pgtable)
>> +		pte_free(vma->vm_mm, pgtable);
>> +
>>  	return VM_FAULT_NOPAGE;
>>  }
>>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
>>  
>> +vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	unsigned long addr = vmf->address & PMD_MASK;
>> +	struct mm_struct *mm = vma->vm_mm;
>> +	spinlock_t *ptl;
>> +	pgtable_t pgtable = NULL;
>> +	struct folio *folio;
>> +	struct page *page;
>> +
>> +	if (addr < vma->vm_start || addr >= vma->vm_end)
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	if (arch_needs_pgtable_deposit()) {
>> +		pgtable = pte_alloc_one(vma->vm_mm);
>> +		if (!pgtable)
>> +			return VM_FAULT_OOM;
>> +	}
>> +
>> +	track_pfn_insert(vma, &vma->vm_page_prot, pfn);
>> +
>> +	ptl = pmd_lock(mm, vmf->pmd);
>> +	if (pmd_none(*vmf->pmd)) {
>> +		page = pfn_t_to_page(pfn);
>> +		folio = page_folio(page);
>> +		folio_get(folio);
>> +		folio_add_file_rmap_pmd(folio, page, vma);
>> +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
>> +	}
>> +	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, vma->vm_page_prot,
>> +		write, pgtable);
>> +	spin_unlock(ptl);
>> +	if (pgtable)
>> +		pte_free(mm, pgtable);
>
> Are not the deposit rules that the extra page table stick around for the
> lifetime of the inserted pte? So would that not require this incremental
> change?

Yeah, thanks for catching this.

> ---
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ea65c2db2bb1..5ef1e5d21a96 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1232,7 +1232,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  
>  static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			   pmd_t *pmd, unsigned long pfn, pgprot_t prot,
> -			   bool write, pgtable_t pgtable)
> +			   bool write, pgtable_t *pgtable)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	pmd_t entry;
> @@ -1258,10 +1258,10 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		entry = maybe_pmd_mkwrite(entry, vma);
>  	}
>  
> -	if (pgtable) {
> -		pgtable_trans_huge_deposit(mm, pmd, pgtable);
> +	if (*pgtable) {
> +		pgtable_trans_huge_deposit(mm, pmd, *pgtable);
>  		mm_inc_nr_ptes(mm);
> -		pgtable = NULL;
> +		*pgtable = NULL;
>  	}
>  
>  	set_pmd_at(mm, addr, pmd, entry);
> @@ -1306,7 +1306,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool writ
>  
>  	track_pfn_insert(vma, &pgprot, pfn);
>  	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
> +	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, &pgtable);
>  	spin_unlock(ptl);
>  	if (pgtable)
>  		pte_free(vma->vm_mm, pgtable);
> @@ -1344,8 +1344,8 @@ vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool writ
>  		folio_add_file_rmap_pmd(folio, page, vma);
>  		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
>  	}
> -	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, vma->vm_page_prot,
> -		write, pgtable);
> +	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, vma->vm_page_prot, write,
> +		       &pgtable);
>  	spin_unlock(ptl);
>  	if (pgtable)
>  		pte_free(mm, pgtable);
> ---
>
> Along these lines it would be lovely if someone from the PowerPC side
> could test these changes, or if someone has a canned qemu command line
> to test radix vs hash with pmem+dax that they can share?

Michael, Nick, do you know of a qemu command or anyone who might?

>> +
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_insert_pfn_pmd);
>
> Like I mentioned before, lets make the exported function
> vmf_insert_folio() and move the pte, pmd, pud internal private / static
> details of the implementation. The "dax_" specific aspect of this was
> removed at the conversion of a dax_pfn to a folio.

Ok, let me try that. Note that vmf_insert_pfn{_pmd|_pud} will have to
stick around though.

