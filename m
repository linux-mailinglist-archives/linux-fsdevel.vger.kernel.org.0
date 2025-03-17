Return-Path: <linux-fsdevel+bounces-44208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338ABA65909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 17:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C70168B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1B1CAA73;
	Mon, 17 Mar 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rPpEQd5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAA1A3155;
	Mon, 17 Mar 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229966; cv=fail; b=Fv6cYmcuKcsXsM9qg+kj06LImDXK82yN/PowTXPcmTJN1aWqFXQU/gqlqzjO02YTKRtXvz3kwdnIVwsPXwqOq2ZS8eBsaaUXRXMuD6ZpyZvHuT66kEfBEQRWTd13YPVa7ESAMKUA+BQViAiKRSXp52Sd9Imbqj/mOyi/m8OsCgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229966; c=relaxed/simple;
	bh=ByKQGivlZtq4jo7OjiKW92pnX4je31C8HrPM6F9Z3mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fHlqxv12htRciX71dsnYvPgoDxqOshn9lKGI527EhO4koy76ilu+F6OZ7QH9L5ALU9HH4EUiYY/lO+6eiHMiT53tw9pEkoMBBZAZvY9C6swAbFEcH0EUOOCIARIRQSdMpOXcQa18HzqbEfzeK/w5o6n+SDQxktSJfX7jYQbk5BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rPpEQd5N; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad7WrH6VMmVteF0+uysPb++Kt87H/56jLyjY2KrwPfsl9vMoLCZRESrbGDV6Rp29ijSwoMyl05WMxcJGUICgYTOpXJewKN/zx7AhE3OZk5wp4lTUIJfHkYDppc5a5du+MimpWeCAnK7hwAAxkl14NZmFZHQt6kBSkcZajRfhfMAsfm7szkCMHP8ReVkvy3//mq6xNKD58+vt/KRCT54//EbYtK5WA5jTJfjWUy8jz1/GZxQwM39oQbRySYn08KZKDuKgH1aBO6Xj9IX+qeDVg9NrByLiBVnqN0q4LybBKiikkgNfXQoig071nCyoj5kS9q30k/sLGfRoYuiKc55IKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFDg9516p7Xnp2MSZZPQ+ApbktlB5E5Rn8d86Y2t3Jk=;
 b=NwOO+SUGsjRPLdjU0IMsvUBXR+Mx+qKKBb1YT+TCHT9keU9eovcjwyRXaGM07FHmGH0Gi/JLmvO/jHvxh3UAu4k57MlGtlwV2SN/xjWPN9pPSCErOfSHnKb6lNgyceQe7+eWbHyfaS49z2Xj3f+GotYE8kUOaJSHdRMQOqzRyxWGhhbypOsEouREysbn8iuaxhvphFOJmYpskm0AU9NzJ4E+75syqMm23AvRM5eFracnfbfjWluX1AiL1/ZUfvs9vUGSLQM4nlbsGlp1JIL+g9zxXO8VHN8g84+TJGT4GOD/cYEvjYGRoB/6AETZxcAgB97DbBV59+T23ioFu/KMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFDg9516p7Xnp2MSZZPQ+ApbktlB5E5Rn8d86Y2t3Jk=;
 b=rPpEQd5NEirWSkOBjmKiL6+rJp1qQRrEC9cX6+Vl/gdQCpw6d/rWnZEJKCt90f6koVZPjGwBXslOp69QCmpnADnkm1qmE+fwJ8M6zx6O92d9+n4giCu9brMIlDOlnJTkz2a9RHeL5hHuNIZpJfnMGd5fqG7mRFpxe87ZPTYHHeMm9DxjU3ee2MMwdm9zWHGhUg+3a5IYTUCKqgmbloGjVWn/RA/wpKrT0u6FCUwsS3nIvPjhZ6LPLN7leoZ72GewF0omkbBxFsxfcflLbrlM3dvfQPgJFYypC0r7JG3OgDDMVxiCTaN/1eusdTlUHzl7z7HwHVZtk3YyjU1pgPC1Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 16:46:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:46:01 +0000
Date: Mon, 17 Mar 2025 13:46:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250317164600.GM9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <20250307151417.GQ354511@nvidia.com>
 <20250308-wutanfall-ersetzbar-2aedc820d80d@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-wutanfall-ersetzbar-2aedc820d80d@brauner>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ec5bdd-2f37-4e50-fdf8-08dd6573333a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G85XgDF1tmweZjf+IH0gvSzyac4muHco2kgwpMZoT2dwAmqj1nCWuOehh3XT?=
 =?us-ascii?Q?9yvVZOKpSWiHwAl+Y3nq0b6SqutCMX5VabIq3y9gXUcM7ouLd5QohiJwGA63?=
 =?us-ascii?Q?OeIoh0LudTZK4o4ajJXFf9m84jmpNinbCXHHqP6D/eXa5FpQyNWstNNNbyjn?=
 =?us-ascii?Q?EZyA9FE+bNcOMiMvor6uYJ5O71NcVwuowrj9XlfefQ13XdUuDo5/WdB8UZN8?=
 =?us-ascii?Q?zPYI5qfSxJxW/xO7MJobmbxdRv+0nZ7HU9sc6b8YZpqvOh/vH3efZ0btDmj6?=
 =?us-ascii?Q?vZVDt2LCuA/fzw03X3YoJXyNJPTZw9/Q7HvkRnC1VmUF+75ggs3Ekk8Ud97t?=
 =?us-ascii?Q?V85KGraYZhjgjWJxtLJkee6qQ3DnxwMB5MeDJbyMjq9z2StwkR9mKWW56hmX?=
 =?us-ascii?Q?NFAauEty8GJSdkIADbFP2A4sciB5m0dokI9OH7hxzXNmrbi61g8HtuhSfVAb?=
 =?us-ascii?Q?keD804bKLfVMERsoqCpAogQVO+eY1CkARWMscPMm5mst9YwIENOi+n/2KIaq?=
 =?us-ascii?Q?N6po6EVBlj7nDxFH3vJbb0F8j3iYnXT5HybS9LFNGjfVu3xaVhb2Rx/f1E9G?=
 =?us-ascii?Q?+neQQ3LlJptm1oQJEYljpbI6CxNYu3YCtc4JkUuCD6HY1ksyXzBavZW+OcNP?=
 =?us-ascii?Q?4+xoAv1TR1kYzy/9XnkTx1OoGx+va8nNhQnRNTKjGBTqL3Qhw9i+xLwIYK2S?=
 =?us-ascii?Q?jvdWMm2ef9MJqGtAZ0yXmmHnJ6v/Tt450OhiQUzIw5ZsfMkb+c+H8RTxqujr?=
 =?us-ascii?Q?FHPgb7qgMMwFlY4b2h3RX096hHyqj9GyuzzczzK919noH3uMJvIP38go1z1K?=
 =?us-ascii?Q?YYeV19YjaZp0+C0bU0lCer3zsxrDwDWuowGRfHiJyQil45Yu7qtsesYtmMiG?=
 =?us-ascii?Q?bQLJhm4P+u8NpFEvp3rlxQCJwgCRyWOfezxeDNEDU2ic8nnnF4o1CDhDeyc9?=
 =?us-ascii?Q?YYma9I1eIMxdyfl3h3xgBwv9AurIs9E5ieRRW/1NG1eVJqe2eYLYs+9943AH?=
 =?us-ascii?Q?cj1Vp2XPiX0Q6DQpm79/Fd53oyknKYP5eZkrWvqOHCyiEFeEaZ2dMb94gV8Q?=
 =?us-ascii?Q?Xi7zw8Rn6A1kIV8/ronWNtWpJABZTqSCbUN+ymfD5HswWIEw5Im4REgdx08X?=
 =?us-ascii?Q?zZV3pBhYFFJN0IWS1rK8FqiSZdOWL6Ddpj5KNbQKc45i75S4bwAwRg5BFqSP?=
 =?us-ascii?Q?etc1UgkUEhT9iz060fjEgz88S0JU/WEIkox6/i4xwH2OecLv4IqBDLa2YerT?=
 =?us-ascii?Q?QamsMdVVduaPUAftgxBolL4eurFWtTeFSDtzI+KGDJ6Rf1TFpEWTiEy3cbec?=
 =?us-ascii?Q?wjUbEua8tKjlfL0cNT4nAPFssHpWRoXVLl7Ov1xwL0SWx74N8eaqD5MAUJsN?=
 =?us-ascii?Q?3B9uF4KMZYCpMOzMDt8lUdbkd2GH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSxEyvU07zcscwyu3JXPhXqGaBATOY0/CZl9Bm/mTQUs+/qJe2b3Ba2U/+rD?=
 =?us-ascii?Q?VMekQk8dtpqB0UgDfiMBlewssqFMWB+yhA7ZKHhjSsmLGvt31+bVZyrh7TWi?=
 =?us-ascii?Q?xku4GJAFUVwvg7wjmyabZbyHtdGpcB5TPhCzPjuWY7ByWrQ92hlaBQuN7sKN?=
 =?us-ascii?Q?gbdCkm/nSjESUyVERjfT/gxQuVuIpnSqxIVOyz9yRb6gv7WfgaPGez8mpRw7?=
 =?us-ascii?Q?2Y6IROhxlIQBW6zfOBV1Dj5n7xSTVGnjpYIxZcbmDdgkpBjSo+iI2KkpYw9y?=
 =?us-ascii?Q?VEQ7EsQLOUBYmGGNJrUmlal1m4jve8hfXP8zE8O9YzACSZiuFRc2unZFM7Jo?=
 =?us-ascii?Q?ea84mimo+fziSxzIzQqx6P1LTTidX+x3sm4OXnsP6mpPMifIdF8ekMy5dPUC?=
 =?us-ascii?Q?L8MaUWbeT/1zYL7dEU8i8LJr+opkpFLsaexSt7XUT3VxS1NLKnrgts2QMJFw?=
 =?us-ascii?Q?2MCwyJdzrlheBcD9jNSPfEBgVHoPq4xi3fUei0zz0xrbc0/mq0BPLR+MBIiK?=
 =?us-ascii?Q?2nHBx65/hOGtvnBjQIuPjT6SlPpPw6canAzTnmwhN+tvyQNZyD5EhoICR9Zw?=
 =?us-ascii?Q?wksYZeqmFo9x8M2nNG44lBV/JAmUENGRMTnSE8KDGiYmWdLcxNgT1CoTJv+F?=
 =?us-ascii?Q?5VOsyKo+dQd0pZ8RSW9bPSJF3dTT48e2lkLnBdji5JXw3WftvvmC/zrKb3M9?=
 =?us-ascii?Q?N3PK6vGxw407Wnn0OEU1YHAZaCKa2kh1Y4h9njoNQirvx2M0joY2B9A234Od?=
 =?us-ascii?Q?rRaJm2aut4NVTk9+kDNqHR4HxxPXkVo52vaJ6tWSYsPguMUAxJroEbgvXPVH?=
 =?us-ascii?Q?YrOzUi8r5VDpI4kHKUR5BlIMt9lL5KrTHJnTcMHNltCgE9Bv5hHhLXxcJgJs?=
 =?us-ascii?Q?XgCmSzIDKhR2qSqiuWJ+WXzGQgQyp/I86gh8h39HNozV1gzCCN15zfB+QfiT?=
 =?us-ascii?Q?dXQX1291xuGM5NrPg4kkHLz4PisCUSHfvoEqwyiM9DnGtY1zpPIbzrE4up6U?=
 =?us-ascii?Q?s3OqEoqks9v3HsqCMIW84lliw6dMQ2lom0XWhbXT+iUTk8iUeDyZTvfEP5tK?=
 =?us-ascii?Q?tUpwvYX8tHdH87JFG+jl/5v09OMDMRtrZ5HnrOUZxa2lGd9jLRF9HKVtejp+?=
 =?us-ascii?Q?QDZanhWPVaI5jTX8tbnWfDz7UVA6JTihpSfxYW5wUefgtqmWkSdBtsySwv4f?=
 =?us-ascii?Q?62SU1509Rq5DG4GNyw9j7g2+AlIypMxRcvt+qWFviHTV78T8rCI3KbWiRmfK?=
 =?us-ascii?Q?GbN1fAzXME0Yye57upfnwsLI7VcoYMqcuSy1CkvuY1TtgbZYhBMtzl5Re5j8?=
 =?us-ascii?Q?t3NKf8GMORXyDekVFPIHFKnJk0YRJxyWyMRCrCI/pR8pcpke1nsTYrSQoMzi?=
 =?us-ascii?Q?IoNc/ZpktD7Mr5QvP/2k8pJxgt7JvQl78QJBdlYloveKcYPYQhapQvsp7kk+?=
 =?us-ascii?Q?PvwO82pMa6KLX8HdYYUj69GcsUj40JGDPVuYcASlyxIca4h/iwMZu2li+9oy?=
 =?us-ascii?Q?s/Zdi5+AsLMygXZSXv14oobpCF+UhnVIWrV5A+CkKVdpqZ/ZLPEtvSGJGGy6?=
 =?us-ascii?Q?X8atK1bWWEWDABq4r0D1cj47cBw+ltIhhC2v2kFw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ec5bdd-2f37-4e50-fdf8-08dd6573333a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:46:01.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfbtNOXWrQ/ZK64B3FV8+LRlHU7BVaJ6iOGSMO+Mfnti3KPC9Omqn9T+R0wPDdvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

On Sat, Mar 08, 2025 at 12:09:53PM +0100, Christian Brauner wrote:
> On Fri, Mar 07, 2025 at 11:14:17AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 07, 2025 at 10:31:39AM +0100, Christian Brauner wrote:
> > > On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> > > > The File Descriptor Box (FDBox) is a mechanism for userspace to name
> > > > file descriptors and give them over to the kernel to hold. They can
> > > > later be retrieved by passing in the same name.
> > > > 
> > > > The primary purpose of FDBox is to be used with Kexec Handover (KHO).
> > > > There are many kinds anonymous file descriptors in the kernel like
> > > > memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
> > > > using KHO. To be able to do that, there needs to be a mechanism to label
> > > > FDs that allows userspace to set the label before doing KHO and to use
> > > > the label to map them back after KHO. FDBox achieves that purpose by
> > > > exposing a miscdevice which exposes ioctls to label and transfer FDs
> > > > between the kernel and userspace. FDBox is not intended to work with any
> > > > generic file descriptor. Support for each kind of FDs must be explicitly
> > > > enabled.
> > > 
> > > This makes no sense as a generic concept. If you want to restore shmem
> > > and possibly anonymous inodes files via KHO then tailor the solution to
> > > shmem and anon inodes but don't make this generic infrastructure. This
> > > has zero chances to cover generic files.
> > 
> > We need it to cover a range of FD types in the kernel like iommufd and
> 
> anonymous inode
> 
> > vfio.
> 
> anonymous inode

Yes, I think Pratyush did not really capture that point, that it is
really only for very limited FD types. Realistically probably only
anonymous like things.

> > It is not "generic" in the sense every FD in the kernel magicaly works
> > with fdbox, but that any driver/subsystem providing a FD could be
> > enlightened to support it.
> > 
> > Very much do not want the infrastructure tied to just shmem and memfd.
> 
> Anything you can reasonably want will either be an internal shmem mount,
> devtmpfs, or anonymous inodes. Anything else isn't going to work.

Yes.
 
> I'm not yet sold that this needs to be a character device. Because
> that's fundamentally limiting in how useful this can be.

It is part of KHO, and I think KHO wants a character device for other
reasons anyhow.

The whole concept is tied to KHO intrinsically because this new
file_operations callback is going to be calling KHO related functions
to register the information contained in the FD with KHO.

Also, I kind of expect it to be semi-destructive to the FDs in
someway, especially for VFIO and iommufd. The FD will have to be
prepared to go into the KHO first.

> It might be way more useful if this ended up being a separate tiny
> filesystem where such preserved files are simply shown as named entries
> that you can open instead of ioctl()ing your way through character
> devices. But I need to think about that.

It could be possible, but I think this is more complex, and not really
too useful. How do you store a iommufd anonymous inode in a new
special filesystem? What permissions does it have after kexec? How
does open work? What if you open the same path multiple times? What
about the single-open rules of VFIO? How do you "open" co-linked FDs
like VFIO & iommufd?

A char device can give pretty reasonable answers to these questions
when we don't have to pretend to be a filesytem..

Jason

