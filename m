Return-Path: <linux-fsdevel+bounces-39005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A39A0AEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 06:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3E23A6B2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791C231A3D;
	Mon, 13 Jan 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mzg08LgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2A14B07A;
	Mon, 13 Jan 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747326; cv=fail; b=B8Fgs7XfScKS6G7s6yx6pQ/vt2jmTmiTULGVJrB0ofObCFc1JI/5FPJSWuMU1gKVjohAaCB4HCpTfgpTvXFyVcukpHKL8jVGMPMU2H7U7qPjjYJXpCnH/9SWAhNFaIfFgDGblUjcbCvvEDMAqdF7TEjrxbHqqa7SWgYn6mEOWhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747326; c=relaxed/simple;
	bh=slz+6fF7BGUjSwIVUVURWoWYoUilEzxaXsgr0fyhrxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N1XS1WnZU3Mm2+onOA8GVmiOJvqWakf5y36y1KB1dJKjT1aL6Gk7VB1SMqv5LewRjXJyHbfW5y2VDJ5OLX0ri+kkRkDR55mIJqX8AFKuVIbx8qiXlZ1N10Q9WwycpX6Z3rEXJh1uy6wf/YNoPNEK/YVpoUQ3RFVaTRcmfqM8tSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mzg08LgE; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNB5QhAgTWkkkcRv4zPKaQ2RJdELFIiblnOHAJbubudL3LKW/4TSv9kOExawWFrNxQc6upeVb+fL2pOl1dbe4nuRU4rwItkV+LACrdHGnKJdLX0xlQFXLSIRmJ7SqPRiBLoNoQWPwiO72ztX0D5MP0mooNsmpwj6oatX1Z3DESPoe9qEOXLUtEMpQ6h6QHzWm9sjy1gy5HJiZtw23je1uZFjdLx3OE3wp5Ghux+07wQGBewXF8VWwSd8qyebyqg4cw+2YvLsTR404imWeeY94IDJLOUTBJ9DVdBLDYNtnc5xZEGz/pzUYlQVVXdaDV1mHAhEqO8AXiaD4hX5J3izqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyLBBxDHcOb9935DJaPURz+sg3QRC7hdeLrMTbZsnQk=;
 b=U0Iuz/6eM0NevbolWOCwIa3XJyVKikulCvMaOfD5JlwpK15kkon6HbcF8F6DXwkmCUX6ovGrRExK/s9TSxeO8H6BdkERzrxQ4Xj7r3G+kuNDYXfBz1lvn3IyOwLMY6euyB9ZPWcJzbYBZAIGGxfLD7D5NQ3xjF0ADdSPKfBFHZA8hVfknrgI38U64+rm+dz2d1tDzfrycPMZ6H8JShyO8L5d1draDYreee7NF/f2EugnPADsTm1Hogb3zKXoaG9FrdPZvVl4KWzVUMUXkYJmloJoukSdlC8bdcokuwjVhKHJFo1Zc8KQkoQ+FnLE+2oaKSj8mwu4JKfzVdZSRvkKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyLBBxDHcOb9935DJaPURz+sg3QRC7hdeLrMTbZsnQk=;
 b=Mzg08LgEdIXt43i3LqpEaVmIlh/H/XC9aOWT8H/P51nAQr71giXe8IDF2splDyMigHwJ9M62cYhHWBiP8LSsHQ4q4Hih+Gz0/HDKnIEb2qwmK13ku089OwYKvoluxorPjO0aM+Qfd15MgkIgkI3WIieSNCGrS7m1jkMMP6MmeLivNnZ+T4ehSWCVXFfdkfVWILFf2j4cI8P5yEvVsFGXPOOC2FUmoh2iIVqNWU17ebOJCIMtvWkarnyeNTqE11oT7lbQ+/Zc7rQHAvPrF4119okt1vQsqpV7U3LbMoH4SH3PqT6sF/uWb7Or9I9dHN+F9frbHtipRcQ1XYPxrNyjrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Mon, 13 Jan 2025 05:48:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 05:48:41 +0000
Date: Mon, 13 Jan 2025 16:48:31 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 07/26] fs/dax: Ensure all pages are idle prior to
 filesystem unmount
Message-ID: <o4zau42ynlekxemrzubcmfxhdk7v73ffhevdyle6w6dpqaeziq@5dvnxtrwj25b>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>
 <20250110165019.GK6156@frogsfrogsfrogs>
 <p5vmaqlzge3dkkpnwceewi4io5ngqaczfa7ysujwa45kkevnam@sqc5usu7vgde>
 <20250113024940.GW1306365@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113024940.GW1306365@frogsfrogsfrogs>
X-ClientProxiedBy: SY5PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: c7395742-a74b-406a-6f2d-08dd3395ef48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZlBBq5u1aZHCvb1bbWN0/Ks3S0FrFr+EwnRhjCPRvmou9yATlShZORvbbjE?=
 =?us-ascii?Q?IvxyyB4uf3SbJbzgOHk8ogxNv3JMaA4ywHnFZXNGShZAF925ppCPG7BeUh3x?=
 =?us-ascii?Q?0h/mlG/Xwp2nz1FEDbw56fzO+FT5k4onVHJeCeEda8OzIqbhWjypsntevEUG?=
 =?us-ascii?Q?F47WtBw1ELESko3Y2Vrbu/CBL9qboe8Zs/SGrXD8eRj1uccXC+K+Zy8EfF53?=
 =?us-ascii?Q?KgigDfEpSKwB7U0rFAPhCnOD6EoB/pAB6IwOB0kbFhDIIcSSOAVy3PVJhqWM?=
 =?us-ascii?Q?ia0Ib6VnhyrdgpBrJ0eU8srNCBbSVO1Oa1SpYxnGAyBzFz70AUdSKXVdN+cI?=
 =?us-ascii?Q?iFi1VoGSUFTW6s4sHcIQ6AV+YHnUAFBgErf7iCmLU7+ulxqYeNROZcNOvfOS?=
 =?us-ascii?Q?udGgJvT1yCed/395bcmabAoZXc7kfTpKs1lB8yj6CEegQ9UBwko15i8e9Fwp?=
 =?us-ascii?Q?z/mLRcN4/W/MJKvardjCOkivE7lGIDNJM5I5AVHO8Nsz5vpMMhuOn3iZZxGc?=
 =?us-ascii?Q?1WLLloPu+PjixmBj80zEu/237Yny4Hlg4GE2omHeT3wL9qOh7cAxIb2yJ0cb?=
 =?us-ascii?Q?jeCMyUhgJ5/LcydKzyNEaEl4609o6XitshVUimhNFxaxT62c1eCm5Y66mdai?=
 =?us-ascii?Q?Mbm4ZNdXBQg777ggztCd28e2csJiYHT553VCSnsoF7wmCYkUkMrxO0DIUPzD?=
 =?us-ascii?Q?Kee2GJsXSRBxu30KX5oYo6itJMCtSps8DXoLv4v2WX32rSXlDVDFShzDuKiU?=
 =?us-ascii?Q?JWns9JQnLThByX297GzlGixGajfzVeWUea2zxCyWX6+JCccm3A1Ks/OGmBDF?=
 =?us-ascii?Q?o/G1bY3TmQhILVAIBZjMtsbUaS1Lwuxp/Vc38y3CayvHDXJ8bNJMCP+6bUxy?=
 =?us-ascii?Q?TcrotTXK5df8X+v2uA1wRdhdbVyOZRU6ZdILTzDXfcC2Hs14059mkav5oZcE?=
 =?us-ascii?Q?ght5SAaGytL8Ng07LjB+L//C9mOKgdIhcWH2eVkAd+tVvagqADydWFRAPwtl?=
 =?us-ascii?Q?IKa6EPBylugPFsHqiDjmOcTiAZPjbwEfdKxqOVYkdz8wb+/ugWeA3zWd2+Oh?=
 =?us-ascii?Q?xxCNm0qOZ4Bqc4/aOcvoU9uOL1uNcplgGXvl5Jt+Om9SnmDUzmCsbfLA7XnN?=
 =?us-ascii?Q?ZK2/6z4tWCjKqzD7J/cIdF7Rf78INffLsPmNqa7uE7t3GAXT1CKgXnLEOrYJ?=
 =?us-ascii?Q?ouSFJks+OjsGIFf65YdFXPck9CxlTIsD/6kVOZvXLMnyIMDV0hSY/1aFHn5t?=
 =?us-ascii?Q?INmUOSHb2Dw1JUwy5Hp9bkfMQXz66R8LFJhy2m01js1F8kKtQrPXYekr8quF?=
 =?us-ascii?Q?mUSYPQovZG66iP3OeCaYYNZ5Uf8Dg3LF29iJ6JkhBOxJByyrez3nfSG5icjX?=
 =?us-ascii?Q?NH5RLLLJzRKVanQlrbhBPfqraG3X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vX/WYsjz3sYB/cUQfHKWGkDztq09QdiRjD6wIuKoY2ckoaFa6bNpzIqDpWVt?=
 =?us-ascii?Q?OkNZnf4MXuaj8gBRzVAj51ssEyqDfPCsOYlzrlMHRgeTXyYGNhBkprW5RTgl?=
 =?us-ascii?Q?4lvZ0SiquhivCKL/+IP9HaTPMKMzpGcpNMR/uupIInjiCGX67hPK0N+kEFpH?=
 =?us-ascii?Q?DMoz9xT1BTQ9NWMGnN6os62xMHNQJOjTNBYV7c4DBRP8F+oanqLvBCXJVCZL?=
 =?us-ascii?Q?FCznK46t69+cgbifS3WdJYSroiL9pI21umnuVeUNYXGTwWJdKZ2OodzVA3JJ?=
 =?us-ascii?Q?5f+CQW2nsgO/nW+Wsp4Pit5PJKD41gGm8in4ILmozJ4FzT20Aic7hcLiMjn+?=
 =?us-ascii?Q?Ns/c4HCtvNo44oUDw357UdotrpLg252C52+s5GiYemv2MWDHLym1sa5yxyjy?=
 =?us-ascii?Q?G0MtLrYfz9JAeJ97K9FiWS4v2jHy7LGmUGnllkyfY5G8II+uS+FrU9Wmq4bm?=
 =?us-ascii?Q?osnb+sskFad9CdaTFZmHKfUsr7z3pbarSFM+uxWwgrvVcB2sjoiO7qKka4aH?=
 =?us-ascii?Q?PJMnxMLVoE/KzlDRiFHz5aBKX2CpM7XnqS0lwSklN4uMQ7DVLmL8BDqNvyCy?=
 =?us-ascii?Q?e/Msow/0cskyX0luXCZ6nQmBf6vJlAEAnOjQ0cK745UM9vio1WhipG8slwb0?=
 =?us-ascii?Q?rZFmp2v1RXa1GYZSxAHv1T5fnBTvGxb1Qu4XTX9NVYMZIAq9E0RBYRzZfOWk?=
 =?us-ascii?Q?U7jicKZ0+2yRmr8R+2wf4GDPbnVUjnof+aVaw6/9bzaF9n6AnbFy4ZvZgRmJ?=
 =?us-ascii?Q?JL3qxQr4V7g4dFdVx2tnm2gAuizh3W6j/57VPEFFhq401xikzW3Ly+k32703?=
 =?us-ascii?Q?fdoe7A5SS0PAMUn1aflNky1tHuFJseesd12R0+zx9S3aBBnqRX00Zq+k0Tqy?=
 =?us-ascii?Q?ifwympFVVAl4VgvEJueeV3dXaq5cj3xEtrYR0CG/mU1VmjwREYPB5TWZ2WYg?=
 =?us-ascii?Q?Yudl8XsZ916iYk+sPKqCGfLuau2FmB7K3/Xooj0XXwzrHp7/MQZwVZP7Lln4?=
 =?us-ascii?Q?YdcHofpUoFz8U7gJJQ+UPAZ9iDNpLlGSgKgettzqUNJN6dm4/zqSCKKJqFOM?=
 =?us-ascii?Q?IhlgDZuKvFeSjMcMvwcmzN92a5ZEaxeTequTg+bLQ1HvA/MgSS20k6bWUJMi?=
 =?us-ascii?Q?n+QqG5bZgGUg9R1ToZqoLU9co4d7kuLRJ3JkYOWMTep4MoGagPh8rLpbe8o3?=
 =?us-ascii?Q?CG69HK6WWi4rbRhAf2/jQ34qz05PD0RQ/OR+az+5tj7GpH7maq3sbANs1Nrr?=
 =?us-ascii?Q?xQV/UKH5jK0vsCF/Sa8ho859EmqwEmlcwC8FKXt+/HWtQSWjYz4Sst4y/mSZ?=
 =?us-ascii?Q?hZZIl37Yt3KWgdp/l6B+7txB4fuj2pQFkrc+JJSchIqC3aqobxj8HRFY6mPd?=
 =?us-ascii?Q?k0tv6SRMQkVQWD2zl8JzhuUv2/OiVCFBj8/eT7GHQ+UGPx1hK/lVa5U2k5Z9?=
 =?us-ascii?Q?Qq9O17XorKOdqrBmmLe/7Fj8be4T5fJAyR1k43xzhP6zL0Sj0TV2F16Dc5aw?=
 =?us-ascii?Q?Qwa9PGI5IcJqZbygsUUnpYS+Ko6u0xB7WRfbgQXM/mCLU8vARkyI8Tga+WcM?=
 =?us-ascii?Q?/sweEY/py7NJccRLusphg0Y40WB0frqbqZ4LmcXO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7395742-a74b-406a-6f2d-08dd3395ef48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 05:48:41.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PJYgRrkhtmF0bArM7LdV/HOhMSea/V1XZ391hMIt15xnleulnW+oDlJ1SYdhXsS/etbIwYblRph36qsCJaqaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446

On Sun, Jan 12, 2025 at 06:49:40PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 13, 2025 at 11:57:18AM +1100, Alistair Popple wrote:
> > On Fri, Jan 10, 2025 at 08:50:19AM -0800, Darrick J. Wong wrote:
> > > On Fri, Jan 10, 2025 at 05:00:35PM +1100, Alistair Popple wrote:
> > > > File systems call dax_break_mapping() prior to reallocating file
> > > > system blocks to ensure the page is not undergoing any DMA or other
> > > > accesses. Generally this is needed when a file is truncated to ensure
> > > > that if a block is reallocated nothing is writing to it. However
> > > > filesystems currently don't call this when an FS DAX inode is evicted.
> > > > 
> > > > This can cause problems when the file system is unmounted as a page
> > > > can continue to be under going DMA or other remote access after
> > > > unmount. This means if the file system is remounted any truncate or
> > > > other operation which requires the underlying file system block to be
> > > > freed will not wait for the remote access to complete. Therefore a
> > > > busy block may be reallocated to a new file leading to corruption.
> > > > 
> > > > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > > > 
> > > > ---
> > > > 
> > > > Changes for v5:
> > > > 
> > > >  - Don't wait for pages to be idle in non-DAX mappings
> > > > ---
> > > >  fs/dax.c            | 29 +++++++++++++++++++++++++++++
> > > >  fs/ext4/inode.c     | 32 ++++++++++++++------------------
> > > >  fs/xfs/xfs_inode.c  |  9 +++++++++
> > > >  fs/xfs/xfs_inode.h  |  1 +
> > > >  fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
> > > >  include/linux/dax.h |  2 ++
> > > >  6 files changed, 73 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > index 7008a73..4e49cc4 100644
> > > > --- a/fs/dax.c
> > > > +++ b/fs/dax.c
> > > > @@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
> > > >  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> > > >  }
> > > >  
> > > > +static void wait_page_idle_uninterruptible(struct page *page,
> > > > +					void (cb)(struct inode *),
> > > > +					struct inode *inode)
> > > > +{
> > > > +	___wait_var_event(page, page_ref_count(page) == 1,
> > > > +			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
> > > > +}
> > > > +
> > > >  /*
> > > >   * Unmaps the inode and waits for any DMA to complete prior to deleting the
> > > >   * DAX mapping entries for the range.
> > > > @@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dax_break_mapping);
> > > >  
> > > > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > > > +				void (cb)(struct inode *))
> > > > +{
> > > > +	struct page *page;
> > > > +
> > > > +	if (!dax_mapping(inode->i_mapping))
> > > > +		return;
> > > > +
> > > > +	do {
> > > > +		page = dax_layout_busy_page_range(inode->i_mapping, 0,
> > > > +						LLONG_MAX);
> > > > +		if (!page)
> > > > +			break;
> > > > +
> > > > +		wait_page_idle_uninterruptible(page, cb, inode);
> > > > +	} while (true);
> > > > +
> > > > +	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
> > > > +
> > > >  /*
> > > >   * Invalidate DAX entry if it is clean.
> > > >   */
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index ee8e83f..fa35161 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
> > > >  	       (inode->i_size < EXT4_N_BLOCKS * 4);
> > > >  }
> > > >  
> > > > +static void ext4_wait_dax_page(struct inode *inode)
> > > > +{
> > > > +	filemap_invalidate_unlock(inode->i_mapping);
> > > > +	schedule();
> > > > +	filemap_invalidate_lock(inode->i_mapping);
> > > > +}
> > > > +
> > > > +int ext4_break_layouts(struct inode *inode)
> > > > +{
> > > > +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Called at the last iput() if i_nlink is zero.
> > > >   */
> > > > @@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
> > > >  
> > > >  	trace_ext4_evict_inode(inode);
> > > >  
> > > > +	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
> > > > +
> > > >  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
> > > >  		ext4_evict_ea_inode(inode);
> > > >  	if (inode->i_nlink) {
> > > > @@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > -static void ext4_wait_dax_page(struct inode *inode)
> > > > -{
> > > > -	filemap_invalidate_unlock(inode->i_mapping);
> > > > -	schedule();
> > > > -	filemap_invalidate_lock(inode->i_mapping);
> > > > -}
> > > > -
> > > > -int ext4_break_layouts(struct inode *inode)
> > > > -{
> > > > -	struct page *page;
> > > > -	int error;
> > > > -
> > > > -	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
> > > > -		return -EINVAL;
> > > > -
> > > > -	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > > > -}
> > > > -
> > > >  /*
> > > >   * ext4_punch_hole: punches a hole in a file by releasing the blocks
> > > >   * associated with the given offset and length
> > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > index 4410b42..c7ec5ab 100644
> > > > --- a/fs/xfs/xfs_inode.c
> > > > +++ b/fs/xfs/xfs_inode.c
> > > > @@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
> > > >  	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
> > > >  }
> > > >  
> > > > +void
> > > > +xfs_break_dax_layouts_uninterruptible(
> > > > +	struct inode		*inode)
> > > > +{
> > > > +	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> > > > +
> > > > +	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
> > > > +}
> > > > +
> > > >  int
> > > >  xfs_break_layouts(
> > > >  	struct inode		*inode,
> > > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > > index c4f03f6..613797a 100644
> > > > --- a/fs/xfs/xfs_inode.h
> > > > +++ b/fs/xfs/xfs_inode.h
> > > > @@ -594,6 +594,7 @@ xfs_itruncate_extents(
> > > >  }
> > > >  
> > > >  int	xfs_break_dax_layouts(struct inode *inode);
> > > > +void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
> > > >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> > > >  		enum layout_break_reason reason);
> > > >  
> > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > index 8524b9d..73ec060 100644
> > > > --- a/fs/xfs/xfs_super.c
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -751,6 +751,23 @@ xfs_fs_drop_inode(
> > > >  	return generic_drop_inode(inode);
> > > >  }
> > > >  
> > > > +STATIC void
> > > > +xfs_fs_evict_inode(
> > > > +	struct inode		*inode)
> > > > +{
> > > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > > > +
> > > > +	if (IS_DAX(inode)) {
> > > > +		xfs_ilock(ip, iolock);
> > > > +		xfs_break_dax_layouts_uninterruptible(inode);
> > > > +		xfs_iunlock(ip, iolock);
> > > 
> > > If we're evicting the inode, why is it necessary to take i_rwsem and the
> > > mmap invalidation lock?  Shouldn't the evicting thread be the only one
> > > with access to this inode?
> > 
> > Hmm, good point. I think you're right. I can easily stop taking
> > XFS_IOLOCK_EXCL. Not taking XFS_MMAPLOCK_EXCL is slightly more difficult because
> > xfs_wait_dax_page() expects it to be taken. Do you think it is worth creating a
> > separate callback (xfs_wait_dax_page_unlocked()?) specifically for this path or
> > would you be happy with a comment explaining why we take the XFS_MMAPLOCK_EXCL
> > lock here?
> 
> There shouldn't be any other threads removing "pages" from i_mapping
> during eviction, right?  If so, I think you can just call schedule()
> directly from dax_break_mapping_uninterruptble.

Oh right, and I guess you are saying the same would apply to ext4 so no need to
cycle the filemap lock there either, which I've just noticed is buggy anyway. So
I can just remove the callback entirely for dax_break_mapping_uninterruptible.

> (dax mappings aren't allowed supposed to persist beyond unmount /
> eviction, just like regular pagecache, right??)

Right they're not *supposed* to, but until at least this patch is applied they
can ;-)

 - Alistair

> --D
> 
> >  - Alistair
> > 
> > > --D
> > > 
> > > > +	}
> > > > +
> > > > +	truncate_inode_pages_final(&inode->i_data);
> > > > +	clear_inode(inode);
> > > > +}
> > > > +
> > > >  static void
> > > >  xfs_mount_free(
> > > >  	struct xfs_mount	*mp)
> > > > @@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
> > > >  	.destroy_inode		= xfs_fs_destroy_inode,
> > > >  	.dirty_inode		= xfs_fs_dirty_inode,
> > > >  	.drop_inode		= xfs_fs_drop_inode,
> > > > +	.evict_inode		= xfs_fs_evict_inode,
> > > >  	.put_super		= xfs_fs_put_super,
> > > >  	.sync_fs		= xfs_fs_sync_fs,
> > > >  	.freeze_fs		= xfs_fs_freeze,
> > > > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > > > index ef9e02c..7c3773f 100644
> > > > --- a/include/linux/dax.h
> > > > +++ b/include/linux/dax.h
> > > > @@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> > > >  {
> > > >  	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> > > >  }
> > > > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > > > +				void (cb)(struct inode *));
> > > >  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > >  				  struct inode *dest, loff_t destoff,
> > > >  				  loff_t len, bool *is_same,
> > > > -- 
> > > > git-series 0.9.1
> > > > 
> > 

