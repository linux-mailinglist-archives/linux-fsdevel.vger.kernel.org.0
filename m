Return-Path: <linux-fsdevel+bounces-37769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270E9F7097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 00:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137AE7A045F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDC1FCF4F;
	Wed, 18 Dec 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/J58188"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1321FCD12;
	Wed, 18 Dec 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563504; cv=fail; b=lnngiYJ/b31uS7paZcSr0m1Ee+XzC6lsJG0h7Vi8dDCzRjeMYlJOzH8JYbaxeQz8MTitf0n3hd4GydthYsKxMjgxgW2cw/wmPoeQPpCt2UbrL/BLpuUsuLrqsBjxMzvN1/NVrCo1AHBnkQjVNdVX1KhtXRJ3K5u/wtHysh8JWFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563504; c=relaxed/simple;
	bh=kIZpCQwyeSegGsaqWCF2kVb9Ul6z3zjDbkNsj1LmkP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W7wQVBTgfzDw/rLGssBZg3KPGO7a1EtpWXle3Rj/uzs4K4xlNCj5cx6TfU/HfAHttPquDI6gwma6x7EuVHBfROL1+iqi2VZXaGXDtJYXuaKSQYf0mIEiTtITdoItaANXHalxIwMX6ROvf/CDxv1Y6CSaoOW2itCndl/nzNkv9Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/J58188; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN6uRTAoL6hS5Hcg9nelBIR+GXmpteCPBmWhoa/xjl0zPiR/LiAp0Iw+KwjjRKdnj3pgt7dXHIX77ukZdBPYkEr2V5PHJJ7TodbVDcyRHiNGUOltYuWHUI/P6Lypr3fIcP6e9CPQ2/OZbUGa/VL1qF1KPHYI3HwbN85CfCaKLpHNXYYV5IUc0AB/3oMcdr/MVxPOdIgWCG9Q/A6AGd+xvszuFT8cgsB3pCFi5xYZZBFXbZc7qzqHn2NpoXrpf5HfHy+B4ZJ14Cs8y4CpbkWfwpKWhYTR5nWRwtW78d6zBN+ex+YVaSW/N1dGu08WTNWXbmquyoPQJYGnQhA1lbIsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMuW1HuKrDDL11w68KPlaqPrNFH/HxVVdX3ONM4QpFY=;
 b=rc2j/Tpy+zuJnfmq/2Pt93Fg/6rCWOw+ARIE4O/ToTZsfywO5EnfN/2qlLLlr1pdGasdRhecrTiDizxQALy4o6+U4weyTI6XbJMm97DGAjQGwZ66xfG6h5pU4sCNmOrPOYyZFECg2W4x1Gw40BBDf8ZP5iMbQO25pp52ptZ9ApqW+egVYoTiEFeS2Hm/HLP15gAUC4pEIo7I6FhfCiU2ACVKFebBXS/bqb6oyWGhMXWWjhgYwRgMBQ4UZVYDV8M19fn1azb1KR2zcZtkIvCARCH+4dTka+cG6KeSH+5SkF8GlJpoPkx+CzhIU+j67h7oEUR364GAOXCSwmA5oC0gHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMuW1HuKrDDL11w68KPlaqPrNFH/HxVVdX3ONM4QpFY=;
 b=Q/J58188nMFeNhElQ9yTK3dIa8Ah1OVicT5yo1tf/KtK8zansP0j42c9mLBUbjgz8HOLq54US+BzwvalBXSY9VRNC2lxeE6l6UffBaHYLEkWcv7OCo0Yg9lSwwEttLA7tqtqP1Mkkrwy0NBjhnIbhWWlml9qVi+AMf7zbpr4xvTxzJDJzfe/D/lYwarC8iIoqs8SXHFapPJMjFb+pNeTvupo35Hm0gEC5MqVDWvm03I5v1Pc4GeS2XHseMIPN5LsbBRqaQh37+kaPn72X1ts2r+2ntF1pw1ZSuy9VXdT35ebLVwuGkEk7vfEUxgNZo60YWEEkuicKSIgAoSPhpRE4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.14; Wed, 18 Dec 2024 23:11:37 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:11:36 +0000
Date: Thu, 19 Dec 2024 10:11:32 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v4 19/25] proc/task_mmu: Ignore ZONE_DEVICE pages
Message-ID: <37rxl2bjda3psdknhboexhbg3hahf5ifmublp5fw7ltdoyqllc@udbz76jklmnu>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <f3ebda542373feb70ed3e5d83b276a2e8347609f.1734407924.git-series.apopple@nvidia.com>
 <c7bd9b00-6920-4dc0-8e2e-36c16ef7ad5a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bd9b00-6920-4dc0-8e2e-36c16ef7ad5a@redhat.com>
X-ClientProxiedBy: SY5P282CA0058.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: bd34e276-bcc1-454b-e7bf-08dd1fb95232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KFwjg3hR0+PlTJ/wxSR1Xi6W0CdrPF1+xzr4h2Rv6XDAQYpb66lTzar5HD0N?=
 =?us-ascii?Q?r/NVM7YUDHtQyrI5ikFeRACCZ+b31vaCbuEAqjUhfxVUYPTXQnpGfMUUJ8z5?=
 =?us-ascii?Q?V4BPKKWwFEDgHpNfAlCWHd/mKJsFoAkTdxf5hOSETmT4jiZPaYPa5tr6rSTP?=
 =?us-ascii?Q?3hdnnVdCPUjMHoZyM54rRKMbIVpktb0C3f/Ek+L8fENQ4PEsH4R6AtjfleWy?=
 =?us-ascii?Q?xwa4rmgbMucb7fg5EhQz2N7o4MqfUy2Z4b0PyPMq0Sn6WxvYWTKra6GWfvmG?=
 =?us-ascii?Q?sutqEtJzDpXnNmd/WXcD1I4AQ2S1J0/fZ+UwtimXOPJYA9gma/h1F8OyAxt5?=
 =?us-ascii?Q?1ZUzMrWKrLXWjti36RwVbqb3j5aaVOKrBXgFL7A6EeKrVQH/udF4Uk0sJKe3?=
 =?us-ascii?Q?nWhKYSOIW1NURRrXPuN3eZITsGTDCKdRiXrCst1DG7J2eDxX5F3AohUxF1Ht?=
 =?us-ascii?Q?7mXRQXup2hJq35fR4ypqwNPBxnjTqAiflQxvnWGY3rqN/a05suQ00NRloBpt?=
 =?us-ascii?Q?dL6ytSmTIKtLN0nlClg5ccFCZrfMRmx+a96Cej/UHFbh/7ww1oPfGng6kYr/?=
 =?us-ascii?Q?mHo9wr1uU5jW2rihxhWaEUF2EnPMKk2SF4I2Ix9ImVpbDftXBBp6il5C5MYa?=
 =?us-ascii?Q?6hIWqGiGaAUMb+kuaqtzcAY6v0qT6MQidRgewtKFrdTz4789shlbHVf1OZ75?=
 =?us-ascii?Q?b33BqQ10GwOPTxdQysZT48+O1GjFIyXiuCI8rZOqc3WbFlZh1IbuXhZt89iT?=
 =?us-ascii?Q?Cqwutz4yR7lbCEUECKTbR2X0XIImr1Fx5S5hf5YF8x74mNEbV+Tg1WcZEPKu?=
 =?us-ascii?Q?MKE3Dy7NrabtMSDSC2nwh41XE7fI/FO//ffnZi5XD7j+pC2exu6Xjs34CL7B?=
 =?us-ascii?Q?3/6zHJLnNclCQUbHbMTps5F+aaxymRlu21uReVs7KQk88ihqovAwsGQgsFlu?=
 =?us-ascii?Q?p27qwq6DVuVrMU745aG3017G9Bo/Nm6ER2siq++DajXVQkbi0+SdC2Ws5jWi?=
 =?us-ascii?Q?ZgW8/dpaGq8DGjcprTYmJpMkxSuf14s2NJnW8YUIoTfWIN4rWEjz+0IKrLoJ?=
 =?us-ascii?Q?q/cdZyequV/lIv1aa7J4hKthc2Du1QB2yH+Bis2ruOIhUB622iFBGl4MU+Q1?=
 =?us-ascii?Q?dDprvtpahn2qeliByIT5TO/i3qrZzSTn//hwZtgJOp2CpX/wrAouVO4pZ4UX?=
 =?us-ascii?Q?+m/gswyVIylE6qM4OqN3nWvi5Tjp70BjcBN5QPaylVDIxMmqY8Fz6rhPdaTU?=
 =?us-ascii?Q?q/124USv1Bq2XgK1an/eLg+jY0y7g6Amy8p14P1suUEuPZDBMZ7tWokU37PX?=
 =?us-ascii?Q?Eaj05v90SLZauq7sqRKiwRXOin16JNKnJlIV+PVqKlUhF95/W4VsecVCbZqP?=
 =?us-ascii?Q?ecdxluvtt+iwSfzYxbKKv6BdTAAZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHHLt3Uh7ON00avJsddDi8Soq8DD4Etil/lQg/xoC6KXA1xsBaf01graQSjB?=
 =?us-ascii?Q?f6d/Y9PFxfKBvnLPMVykaw0A2xgRMTYT/pJxWAXCij0hhNP6+Re+8+r+I9nH?=
 =?us-ascii?Q?jqbRcgQu9D6/00v+KVY7s2g3HXxGU+8rBQtm5ZGQUYlNzyTbBKI+1G9ka5Pm?=
 =?us-ascii?Q?TP5jjYZWxxoXqZwtSvYTIGaTXIlRI6vpIb8HLE0UQdWbgRfc159ZgDMyQsFx?=
 =?us-ascii?Q?fwgKYLsSPW/CPjrLBx8dHKAz9u6BuQ6Y0K/EAMAPb23e3wvmG94ab6ky3zRJ?=
 =?us-ascii?Q?P7qG3KhoA8EATqRsreUmgXFd/mEfurDikNZmb1rMcvol25sYGiKyWskgSyIF?=
 =?us-ascii?Q?ns2ZKEiu0yjtqiDg+OLxeOGCD+iPY6KBKnPqx8Vd1Vf+MntOavluONAHt0Pw?=
 =?us-ascii?Q?8tleWZzgMTNDgLPJ4653aRFnii5p9V8F9V9m+fFaZg5QXyOlcp7u17+66iGU?=
 =?us-ascii?Q?2MqvbVs/DfYvxzT/Nr6vOEQqVzFrIyiwlak0fy4uO9fOaH6bHNxQMjhxWO+3?=
 =?us-ascii?Q?1bTo0rM+NIWQ6oiioGTbBnyc7+h8W3gMWxmjDVxKzKDu/pIdNzXI89EKomW1?=
 =?us-ascii?Q?JNi6TwNroM/TE6P+YxPPgpDa433LOec417zZfU9BDJvN39cOFVMyUuGTdGaF?=
 =?us-ascii?Q?o0Z2q9hndmKpldOmou4LqoaPg4uKum3OnY2tftANo1QbQvOTaLZuc7Q/rLn0?=
 =?us-ascii?Q?ltznrv0BSYlfOUmhBpNZOh3NNzVdoHvSafQHQeVO0gNs9D+K58WsJtK/n5je?=
 =?us-ascii?Q?0cILQn3556yK1nKGDYhYBU258rtPUByZPYUUOAFwGMWV0nKl+zSyfm8TMmJ1?=
 =?us-ascii?Q?JZ62/lMoEt/s7FCaouRkIvYh4Ad/Odhc/SD/ldStd+2KM+uY8Z19cP+534J3?=
 =?us-ascii?Q?ov1CSrVOF0wnBGOVgG1mVmVBuY8l8vI2esoq4ZPmJWjmqqOeNL1fEukhxGMh?=
 =?us-ascii?Q?6TrbgREoAqL8pqCViRqIDnBSvQlLZIua+eWmxjz7X3BEQMxIAqzMPgiCeRjX?=
 =?us-ascii?Q?NtMAxFvUCvRoymNQB9Dl6ttzSnMVbpjLj1tcGB1v5txAHzb1P6lvfMTEj1ZQ?=
 =?us-ascii?Q?gi4cpOfiiW6bQSblad3tb/7d7Ny+Yya2oh3RDRnPpY51hl37Ry3shuk54Js/?=
 =?us-ascii?Q?LI1eLMu2Nfvu+aDgL2d7hIrfX4nE2RNkTxNuEsQmRQ0ZaeRvjf8NOCXf1Gbs?=
 =?us-ascii?Q?09GfavQccsEF9kDkS0un7KMjSpHwAdldXLomf34o4iKKhV/zul8sec97fILL?=
 =?us-ascii?Q?6Z9G3xyP4QdcZfdo7KB+5NLPPd3QbI/K/1piOxwClO0h/gztcqMtAyz/u4qS?=
 =?us-ascii?Q?Ox7Ek1wxpuA5xVnomRzfhlwcAOVyxTjmXlf1tcyO0IXORq8ifYvOcYyt7Iuf?=
 =?us-ascii?Q?AvvAkXJbhRzfZc3S1oXpmZ5bFF2Wrfg17r02aMPtq5czFiduEJXd7VOd7/Bs?=
 =?us-ascii?Q?HFFuksTuPoVCSBX4e7ReRO9fkVPb2qdLVm39tST70QVdq8p3GkDpTfqDN9vZ?=
 =?us-ascii?Q?pES7YSoPztpobLU8QV/15KxIT7xcVuCUpUuT3YhLR/0pa9tT0uc+ikgP/tRi?=
 =?us-ascii?Q?1WunqrikR+tbtMhI+XefMpNXGjqkwKBe010N83ZW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34e276-bcc1-454b-e7bf-08dd1fb95232
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:11:36.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0jL7FfPpkkA/DbvFeAQMsP25CPFHHjCafDov62PNtlrThhnvDnia+3X46k0mr/EnEYno604xBlzGeXuF6d8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

On Tue, Dec 17, 2024 at 11:31:25PM +0100, David Hildenbrand wrote:
> On 17.12.24 06:13, Alistair Popple wrote:
> > The procfs mmu files such as smaps currently ignore device dax and fs
> > dax pages because these pages are considered special. To maintain
> > existing behaviour once these pages are treated as normal pages and
> > returned from vm_normal_page() add tests to explicitly skip them.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >   fs/proc/task_mmu.c | 18 ++++++++++++++----
> >   1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 38a5a3e..c9b227a 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -801,6 +801,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> >   	if (pte_present(ptent)) {
> >   		page = vm_normal_page(vma, addr, ptent);
> > +		if (page && (is_device_dax_page(page) || is_fsdax_page(page)))
> 
> This "is_device_dax_page(page) || is_fsdax_page(page)" is a common theme
> here, likely we should have a special helper?

Sounds good, will add is_dax_page() if there are enough callers left after any
review comments.
 
> But, don't we actually want to include them in the smaps output now? I think
> we want.

I'm not an expert in what callers of vm_normal_page() think of as a "normal"
page. So my philosphy here was to ensure anything calling vm_normal_page()
didn't accidentally start seeing DAX pages, either by checking existing filters
(lots of callers already call vma_is_special_huge() or some equivalent) or
explicitly filtering them out in the hope someone smarter than me could tell me
it was unneccssary.

That stategy seems to have worked, and so I agree we likely do want them in
smaps. I just didn't want to silently do it without this kind of discussion
first.

> The rmap code will indicate these pages in /proc/meminfo, per-node info, in
> the memcg ... as "Mapped:" etc.
> 
> So likely we just want to also indicate them here, or is there any downsides
> we know of?

I don't know of any, and I think it makes sense to also indicate them so will
drop this check in the respin.

> -- 
> Cheers,
> 
> David / dhildenb
> 

