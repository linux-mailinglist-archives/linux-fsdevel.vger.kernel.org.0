Return-Path: <linux-fsdevel+bounces-31647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC789997DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22DB1C2481D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55354194AD9;
	Fri, 11 Oct 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lxcv5cg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257922107;
	Fri, 11 Oct 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606067; cv=fail; b=h5yMUvICjyytJa+R/FfasynGNvtUx/R0kn73l/cJDp3S+sAq3jnNNws/Fk86QjeqxWsSKEzL/Q6KtkClDdDwbDKnDKfa9DQv/mu1yRmWvy67l7P/yY+ExP5v0rEMdzT2vuyHhtTsPCchMaQT11GLCSRxAdp94DCg+koRuLYBbhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606067; c=relaxed/simple;
	bh=UhlJOORSiePNaja/tfFLj699ZA92Y24ApLC7jQfIJOM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ctug/KbKXqIXOEUI+z9Pdj4znX5GsbEIjEWVr3esQruuobxl3X3PW4dA/5G28fFuK27VMzWmFZWD2DDOUKs1kSsD9TJ3XaqgBVhc3unXpQv8zpNv131fk8QeiHnAlHKoLVbVwWWMNzpcCy5zc9bL9n6DaqNpadQT++MGf/my4KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lxcv5cg6; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XasFqBX8WysBi/Y07/QLUk02TKPgSVzrjkisYJo5Mo2dchJtuJzsaLkOWHSo/C3K1yjJktjbUdqo7z9Y9xSLbiMpUVIoMT4mfNSkf/P7tQmSWwHXOINE4bRCd1uvY8/Gw70S8uLFWaUG/TPQCOA2OjbU0kNWUyfsMikgCE9hh4J5BW1+s0YPzwfT0OW9rW7s0wdjNq/wW5zT152OQsZiITD6WURF5ZJ5ef2UHotImiCtVX6MIw+vCNZIuMlASz+pURE8owyjxrrIl5QwanDVXH7eHS/bbYxh4lnom8lUX4K7/m8/QoFIreGt5Ej6rVqS7eekXlvCJG39Sh4cBDuKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDe4Gg0Ncrhhdu95WT6ZItmrm5Cnmkgs4KZzgV8WFQY=;
 b=Df71QhfDcMlLYGSimOao8P45MRFQTJttsajMuUj+rVzyCcVrEbt2s0Y2RXput/RdnLS0+5KeNnvtuWv/zJMShg9xHT+CQfyBWMywptcfOoiWJPtbA25ywvhakfdYtOomnjqWGgfuv8yi8NixcWQBhXVy/xQ08sGMwHWgjZvqVYgkV431/tuvbvL1INe3ueiuh0QM2TlMHUWm4ZT3+LW30m8xWIgflABE35SxE6/xR/OUSPDZy7cW9xNzw8ISzhNcP9PCI4xzAjVSUxkZGcNC1vh7kaq7It1lsB7Hp+8Hc8YBSFHAscZaeQtyJJP89QZU9xfBYKQ3ZRH1Gsy2e9ZlFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDe4Gg0Ncrhhdu95WT6ZItmrm5Cnmkgs4KZzgV8WFQY=;
 b=Lxcv5cg6Qw1FfahyZ97zVDm978KO0DtPRdqjCjceFFgpFImoqgkTGr2Y2BxeDd8Gu7vQJwrrGP/FUdrQTXhQBQLOrlQ/yOMqQ3cVubkDvobPYHPfouPS3/4FVCvC5Wd4rywVbwc/CZZPOHrOemN4KrhUwQVpBFhEVdeX3N3TFgcKooQHokYVv2H02DTI600LPmHF1mPLgK1E/YPCa02651ELtlvEE2fQUCqAFkYNV3fZ4aOxUTKTfDY97rnkEPK9afEak0DcKYDEPeaUJaO3Uipk1N1DbXWgSGcXAoJzDS9+s1w2dZSBqVLT4xqn0i72gxmtttT/NejzvBYpZ/GZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Fri, 11 Oct 2024 00:21:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 00:21:03 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>
 <6f3402ae-01ad-4764-8941-f88bc77f5227@deltatee.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
 dave.jiang@intel.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
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
Subject: Re: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
Date: Fri, 11 Oct 2024 11:20:03 +1100
In-reply-to: <6f3402ae-01ad-4764-8941-f88bc77f5227@deltatee.com>
Message-ID: <87ttdjxzf9.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: c91e47eb-77ab-4ac0-7062-08dce98a9732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+4UJ73iqY5GCP1+7egAxS3C14Jrwhpfx7towZ47gP/FTrfZFvdkMXRrf7w4?=
 =?us-ascii?Q?Q2Z+N+RqwrE1HEUrDhWk0wb/Yx3I4n7kszFIKcEyHc3Jq00m1Kngquzqqmsl?=
 =?us-ascii?Q?FqWqbOrYtA4GymeOqqSEPeFKwa223eY55iROTdP8S5TTXCVdILQBUDrNWU1z?=
 =?us-ascii?Q?gCYmWWKmZIMmyhhoiBLkO9APlXJLtgkeczdZvFnnnzQ8glsIob4xVRY6aOLi?=
 =?us-ascii?Q?DqCnKDs3tpp96Nh8VjlFfIwR7grnxjuWhvaVBVsQdcvSi78JnBpxL4ejrdfD?=
 =?us-ascii?Q?krrGtQC2mZ2K25Flu8sGwVAa/ZwfHQfmBshf2vxYVhn3055Xa8bMXmYJ1/DI?=
 =?us-ascii?Q?6dBTUvzXarDerrmgRSHOrjU2PzWVbOUCx8/cnX7lZ7a3m0LQAcs7CsPObNcF?=
 =?us-ascii?Q?0fOUbE1vztWFOP8P0NEjh0CwJ75Zfyt76KvdImVjoJyYT8py2YLR2dNdRd4R?=
 =?us-ascii?Q?fAUl6DcEZO61BTRiSEXxqslhgyFbFEWUieQlOqE2ZW+HHAo3FZnlP1s8E1cx?=
 =?us-ascii?Q?XfvIqVlJ5/RvXRM8g5QByNaoTWXy9mpC2btPU3lh4lsYgei/itavnDRJ8WH/?=
 =?us-ascii?Q?Ce20EgTBYZRcDPghAw49gx6ImcYdUlFb/5YnD782zEAefr+GAZCdWhVU/ZdS?=
 =?us-ascii?Q?G09tULESRQnkmA4YRV1xbJJgDRfvc0muaZdQaQKMnCcAU9ehQUyZWDHi4Zat?=
 =?us-ascii?Q?0IlGGv4Ejf5D9CTylyHjfMEp3YDEXvpex7YctMwI52awZTtspDuVkKPQ8zIr?=
 =?us-ascii?Q?f3XuC4iLTSpz9s3HDNx9iVkVoTrIG6g324eJIl3xnnMSfEgme1/QTxo4gZMI?=
 =?us-ascii?Q?8+J1qPbN4/zwyOFJhEyVUypvGIEK+cOBQLc8caIuLqCPwz63sH5xhmrDo2fF?=
 =?us-ascii?Q?VDZ9eIsX1+Afw3hg6JloRm8GEnhcd2GM+Z1ix+GOb8bLsH5Y1ApZ48qoIoTQ?=
 =?us-ascii?Q?GnAYa/A7VqHht8v3TbpN4p4AAFBpT4KJfbvu6At+NjXkf5GvgBmYlyI4O2tC?=
 =?us-ascii?Q?qsf0U/K8qmPsQo18x+phTFvt5tB+6nwg389CgSwYWNrBeuVcErEtLdNMECkL?=
 =?us-ascii?Q?2yS0MguThCSzUodGEZ7Wvdmu0r0mdhuLaAhNqPRRKDQMB8oIlBP7LNzKP1AF?=
 =?us-ascii?Q?S2n/Y2RnfdlED2VjueJ/R160MitGtqEj7nbDdJCpO+0I6fawdFJoXJwE4D39?=
 =?us-ascii?Q?IfjaQrL2jhYK9cCK7WWdKFKQ0WCAEvS6bnpRyc2eTDfOKRZV1Rws0C1WGF7e?=
 =?us-ascii?Q?IIy9ubmQ7qPD2zzdzp+euEzP5s0TuIk26uGGBe5iKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLAmfjGU8ICnI9TPxyjltd84Iu/es1D59C8h3GhKCCPu30NJGyxrzzJeUPPZ?=
 =?us-ascii?Q?KeE7U6etMbXXDO09lij/fk5qAAYz8/mXxHr0+KPDl6xMaQGJDv+G3oTAHAIW?=
 =?us-ascii?Q?NTuxkQgufD6T1tRW1PEwjWQN63foAM5y9UCWtfrWrh/Zjd4CM35oVEfJm/0x?=
 =?us-ascii?Q?jnUVd2dIDVihjE/HLK6O7nZUm8qudG+TsOX2ViabF5jbOqIpDI2WlufR0cfC?=
 =?us-ascii?Q?VNOZJ5ZYGPXqedZQVsnnrwLXd0YUeRt5IUprC/r8j59CmgK6GJ9JXBPxoqJ6?=
 =?us-ascii?Q?1ZiIe0RMLuSAuBqNDuOAAlfISCeAaA9nvY2zlpN9qRh0SIR0/zcn7kktX8WW?=
 =?us-ascii?Q?YrEE99hbzkCB345nZq1E8gAM9NcdHZWHEU/VWpZBQ+jNUe8Xy4n3yXnxZHjU?=
 =?us-ascii?Q?eLJcdpOEuVqdlHSCAGi18HptKGFsRPG8ZkG/im3UsnmzvUl5iM6FxGfi5MMb?=
 =?us-ascii?Q?7BGbXkWN6sAjtIbMvXn62FJIeV0grvEjbWO0vIJjWtQic4FWm/M7LeUB7fDj?=
 =?us-ascii?Q?sZz3ovBimeBNsYG4QgLUSEnCemuvrnTypFOJTHgeX8SiD0RFznBm6DaByJy5?=
 =?us-ascii?Q?mNHKBVtj9lEUm3QqYZDC+7mQ8SZRYKlbVUNr2kAVIS61h18OFexvnQZbpVCw?=
 =?us-ascii?Q?ent33hoiEXUyDgqlCL3pscTyL01Ke5xj1oNPjI6nHG1gWDqkubp4howAKOq5?=
 =?us-ascii?Q?XeZHgaWyyEiikkr2IzQR3gRTp6gTNOm0vIOX6gRtxMJ4DVjMbUDC/CMIOvCc?=
 =?us-ascii?Q?/pUjIftBIdbsEQ44uQQmxz8tWbnBkMe6ooP2R/Mp7YQUrf2Bg4BhGISje0C2?=
 =?us-ascii?Q?k9darQ7xW5Xu+5fGIQvilhmkHT3jtbijRWav6kzEZPfLVoSBKhwXifn3n6pV?=
 =?us-ascii?Q?H+N7CpAN7aXOV3SZs9oWOAougtTkUZe5ay8lQm6/4eIEE6QjJql8ORmINAsq?=
 =?us-ascii?Q?RWzXSa/KXk2+fpMVw6IGoTpI7sCCesOR7cyNBh35KSJ9b4TB69th2fLI5UYP?=
 =?us-ascii?Q?6m9/YmO/0Jf/pNkPq1f3oHWJe8OC1jhbfjybe5rQSSoR2o2MwvqGA29nkWPS?=
 =?us-ascii?Q?6RFJwDO0HXpQDqL3MLdeKWP5YeQt4fzb9r5umIHXD69+hTwtXxvHrFR9cBza?=
 =?us-ascii?Q?LyCAweagAH4m1K7togLykg3C5sqPMcgudvPWyGomxRu/BDpSWwYjQwbdi2pQ?=
 =?us-ascii?Q?lQzCvtIhvrWZcyYgR3C4RzwygxENwgfPUNhnD4jwqUmqhWrVz0agHWjT7jAU?=
 =?us-ascii?Q?MGe0h8oOEjIpFEXHPoCRgvvcu0ju1EpMJsHeR29hE1itA685NvQeg/t/gYiv?=
 =?us-ascii?Q?qNtt8ltpogKESNka0SJqxWs23fOjaHmoSas07KStBWTkv+j46E9Q1S+P2LPg?=
 =?us-ascii?Q?qFZr7t4LWxzxV76UardcWXPfTbp3NzSdlSU4W72FgrU9hWktPQGqWF8CkLoX?=
 =?us-ascii?Q?76kvCl2fo2LLxdRGT2brQlhiLuXGTonzH4aW0zk5ygV7PtM7R9k+eBz1hcOD?=
 =?us-ascii?Q?dP9t05ZGtn5RPXTe8TfJ/jSLKeVz7DSBZUMBo+GZojj/41eK9cobyg/fdFDG?=
 =?us-ascii?Q?qg/uHG+unqbKoZ7ebWDaq2MaXBvIWnySRQkiVbKQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e47eb-77ab-4ac0-7062-08dce98a9732
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 00:21:03.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KS4EGb1kQUqN5jHM+VhpV7qHMZN8MrIjIFw/WeYMaU5pIteO/QKr6p0HAm14hxmCTGyvuslaUGzOQjD73uVWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829


Logan Gunthorpe <logang@deltatee.com> writes:

> On 2024-09-09 22:14, Alistair Popple wrote:
>> The reference counts for ZONE_DEVICE private pages should be
>> initialised by the driver when the page is actually allocated by the
>> driver allocator, not when they are first created. This is currently
>> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
>> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
>> 
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>  drivers/pci/p2pdma.c |  6 ++++++
>>  mm/memremap.c        | 17 +++++++++++++----
>>  mm/mm_init.c         | 22 ++++++++++++++++++----
>>  3 files changed, 37 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 4f47a13..210b9f4 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -129,6 +129,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>>  	}
>>  
>>  	/*
>> +	 * Initialise the refcount for the freshly allocated page. As we have
>> +	 * just allocated the page no one else should be using it.
>> +	 */
>> +	set_page_count(virt_to_page(kaddr), 1);
>> +
>> +	/*
>>  	 * vm_insert_page() can sleep, so a reference is taken to mapping
>>  	 * such that rcu_read_unlock() can be done before inserting the
>>  	 * pages
> This seems to only set reference count to the first page, when there can
> be more than one page referenced by kaddr.

Good point.

> I suspect the page count adjustment should be done in the for loop
> that's a few lines lower than this.

Have moved it there for the next version, thanks!

> I think a similar mistake was made by other recent changes.
>
> Thanks,
>
> Logan


