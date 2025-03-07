Return-Path: <linux-fsdevel+bounces-43446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2FA56B99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFEF189B775
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0B21D583;
	Fri,  7 Mar 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GkS2HEE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512C21D596;
	Fri,  7 Mar 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360464; cv=fail; b=Bna/Qy5nTo1ERe976YTxDnJ5Rl3UV6uOa1Cf6A4j6QuFhzpz/NuEqCdQKjEXKR1HKeZJody8mftQit2jFrfB7JWdK2vJaH7u0WR++r6iDi0HjOp0YwcL0RJrsuGUeePjHIzV70iteoOHncrIcYJ3hAYaJ6iKFi5wPstRAN7oYAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360464; c=relaxed/simple;
	bh=jGMm6h/aoTd1CFNEWwFTqh2/U8rAphNDpBkMBGmzK7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=niIDVCUJHUXNPsY31g2Yps7OwzgMy9UMpC5Ez4cS6pYhrEUsE6CJxUhedlAIOnyUXT1jIys5OhBwepa/+51JraSiwNXEbFf1C6qrGXk53WJmlWRjXUrLjfpRGDbVb/NAbvQAj+0sBaUmHDreQ4k5cLFg5ivShK+Lr8wrRi+49/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GkS2HEE8; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Txu4h2fzFsU5Y4jt3MeG7aEq47IaqSSj8HZ/+sSj8/+i1Yp6uIabRHtULMMDqMKJbE0pnCDJVkGP6WwQWGdUg/i0bwd4wfT6122wz3v048hRDhQhQhOVZeMrfqAQtmGMByq/QqipfcEUoea67COKVtjbRwqUshxItgvEJBOngv4rr+1D2TzLTZL5sxTjDhyh6zeHXeZd3kwkas95653PAqPn+DP49B2XiTNA/5bs+O/EahAlQ6K4h6zLi48v/IiIBqDTD0ZxU4XGhcHW29JNxROFMoZCWVJlVymYvdSkH9U+VyufovRm/yBT50lQ0h14pGFO1I9oV0152SBhtetGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hxm+V7PlelwUAl+JpzMwrbVK7spdNtBOJxfwWJxcyA=;
 b=UmMuKoyiV2ytSHrYrpNkbu0NoWOBLJSFFksBSgSbcAl9JcsKKcI2e7eR5Cr93GTgD7NDvo9kCalQzwFMLFp+hwCYmhxY3JKAk6Sq68oH+N/a+7PE3O8dx6IEAGjTQ+pfzVEokPo6OL8q63svL8GL0ScTTx9XII4VnS2VZi97eCuNhgHKYA3vXf1rqgZd1pTQQDWmIoYjuMxZAG4h6ZqLxIZS+JTb6lc8qJByNNBdloC3Ry9U66hJpVzhOuju+pSZzOqrT/EovyS+2CSYv+brp+fqGX6KyhSFZbLzklrBO2AvnriDV9kWqPk8PCMbYbKR8sOzPlIALvzYMPMAQ+auvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hxm+V7PlelwUAl+JpzMwrbVK7spdNtBOJxfwWJxcyA=;
 b=GkS2HEE8QR32ZfjvA17jzViNG5/XG8M4HDewzMxuZKA6tuOt7ddwed8FpSgkBI39CLNcG8NFVd0xhPumBsF4YhgRbArOgRno53bSvN8nLnvtlNDfIKYZUqqI1AgTSrcH3YuqVssY19NDsjVzXmFQrmnbaIfAASRgfRPUtmHIMdp3aN8QgxnvzejyRCBtT3euGT2RgPbzQDLWp3K1j+Acb402NJeGhSogVofSIk3JGlPFlQI6qAySZR8xQHjj5a8NTQIygc05zrI9zHv943EgFZBjqVR1HMdL6TYimamsAOjZ5lV/igrgPzJsRHF+LwxgQiep+Mqgsb1uw+Fws4m05g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:14:19 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:14:19 +0000
Date: Fri, 7 Mar 2025 11:14:17 -0400
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
Message-ID: <20250307151417.GQ354511@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-sachte-stolz-18d43ffea782@brauner>
X-ClientProxiedBy: BN9PR03CA0872.namprd03.prod.outlook.com
 (2603:10b6:408:13c::7) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a2e814-51eb-4f83-dfff-08dd5d8abb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89UNm2TcdpvZIGJw3ctH91wFvXPFgHD44Gi4AQzNHLuMxYYIqTfZekcBwnnR?=
 =?us-ascii?Q?rfh2frF5BUQq5YbLaU43ubk827F3CdbE1jrpBr/tzmWqscPRz/SIgBlXjhey?=
 =?us-ascii?Q?sS6D0egv8Kr8jwq3gMgsvSksSqJp0svtp3gkS0GKu4HDsU3CZN5TLRa9wQht?=
 =?us-ascii?Q?8ovBUNzuqXd6/LUjwCt5EIQQFnx6vgmx3jVhHAbfPiurz6ZlieVwFrU8UGn5?=
 =?us-ascii?Q?+WZiF250fUjaf5Zamf0JxGigiU2tQ80bh7UCL5/LsWBmQP3E4HtXn6IhyC1H?=
 =?us-ascii?Q?ZlK6oh8uN7RLJnFdj114T1K11PTcB+WLBWSbvaotrL/qCHDR/iObjGbvM1/t?=
 =?us-ascii?Q?I1kzVuAUSUaVRkipkM/BCjbFpv7qzgS2U6d3O5chclOjh1kb47tsk182Pg9s?=
 =?us-ascii?Q?KeYR9WEZWljq6NEGrqW/rAgqxnPqLicYQ7xdne1EBp8e3bBCRzvwSDazEL2C?=
 =?us-ascii?Q?a3xeykaTJHCy027CfFnRFQkfwZMJzxk05sy678dmZMPclVelQzYceiKV1kFb?=
 =?us-ascii?Q?iRb3RLXUmmg/l3yAevWIOGPCESMCcrpts8lhkuzfdz5Z77sk3t7MHUnIibyv?=
 =?us-ascii?Q?p79s325CIWPC7UkZ5Mh02RD0Osu7YTSVEaihge1yrjPiL/KwdDVQBMnkGMmQ?=
 =?us-ascii?Q?VgNBlabjhrfVdIgbx5a5X8YWS6lfO5t7AChJJ2hqt+xsIL8DPjLW7ax2VWdd?=
 =?us-ascii?Q?AEEWUlhA5DsXgRiaUvDVffLqlBseP6Rh6aUTPcJ4lPvUM3zq4Gr3yia3YZQ2?=
 =?us-ascii?Q?SRtwrRnfz9MNBZnSy9lO6L+Tjkc13Yh9Wc6jA2cpQHO4SEfB1aO7PYBT//Ak?=
 =?us-ascii?Q?jIerqb6pzJl1axO9+VxNnRsNS+rg22gETv30+QI1HEwLQc8nbIXHJdFaiKoA?=
 =?us-ascii?Q?spVZQOVcfsBcWCLlpD5+jDthh+NhKYaRbtPE88ATxjNW48cQZkJXlCMZm2LM?=
 =?us-ascii?Q?SdqUHFy7i02uKpi2B38ZXH7mjVPRCiVeU7HhjfLPwTzS9Or1G3mX+AgGmIcZ?=
 =?us-ascii?Q?eOcxbvkf0eW+nofabgA1PndEZBaOiQRA09P/szJ8VvvOEJdbsI72M6QgMpiI?=
 =?us-ascii?Q?o/PIrXFuUxpS7WW1PSIeLYtND8aL8Bj3pUKd4yjOJWn3jIKWrgHFmvaC+NQ5?=
 =?us-ascii?Q?oAHQKa1ZlVjvxACmHEPI/dx2rFSmYj4Zzffxm/fzsFXaW1O6cFcOYZ5Oa0bJ?=
 =?us-ascii?Q?kaDOeim56iGypKwV79t1XExd+fTX44L8W+Y15erJLyvZRPwrzZNzBdAtpznc?=
 =?us-ascii?Q?BrzkYv9QroGTeJwycGt7Lui8oRR/m9O9CMFUjoFjlMwF+BT0QxZMzVxdXwSA?=
 =?us-ascii?Q?82tOjQ2A5uLvXqDSUG2feUe/dWuDf4iLvPpGIOcrdJIav+JvJTEPYxOu/L77?=
 =?us-ascii?Q?pPYmsWrotmgg8rDgy8elFZhyeHjY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyiL3WkWmOWgBee2X+P3ysH7+g9yXxtuVJhCavtFosbEFyWou29DP3CJPyGB?=
 =?us-ascii?Q?CzrZM5gC/Mj/RoOcl+V+o9yNzocbZQyhiF+l9MESIiTe23/k+OPfUiLIOXxI?=
 =?us-ascii?Q?pt5AcIRqECWQV/ULTtHe1MwXjsU7WCzj5BdtNcokxrUcBEEUup8n7TLIo2iy?=
 =?us-ascii?Q?GvozsRQaAlz9OuqS/O4aTo/dApnMxQunzLn+F1BdjjVfBnUpSs8Zcu1JQb0q?=
 =?us-ascii?Q?x1uygGKv5kRksFS/W+5RZbzqNcen0bor/p2XiqhI7nCljZ5so4nUVVPerlyq?=
 =?us-ascii?Q?uutwmSC4k0EAFoR7qc/VOMyTZwPh1xESWEWS5VJOR7jErHgwnChp6v7WlFl0?=
 =?us-ascii?Q?Yqh6pyN0V8QzIVNi9D8Bv2m399AJ7PUOGw5ygXTAPp9GJ+m5f8Rg1wiflJTe?=
 =?us-ascii?Q?O+NolMV2ORGX0QIDwOASpppE4isBxMEUkesfvbowCZDSAXGB6I/NCGSMMNVF?=
 =?us-ascii?Q?tSlrnJubvb278/XboBnOB1dWP2LFk0QVgLq2NM71ByePuos6HZmKFXE7nN7V?=
 =?us-ascii?Q?TSYXXMlu54L+8EC9Bq1J8c8/cn3VjywiEiECcbKW5SL1tiEUKRs6l65zaABJ?=
 =?us-ascii?Q?Ic6g2Q+Cn9LY38LV4vIkDm3wHg2z3HZ+GlLICIkev9Xbj//x2oqe7eYUxGFp?=
 =?us-ascii?Q?wY5Rpb9bjzBcPEd+fqDPnVvz9fsmk8rWIW9969u98kpqgbXOH5ZHhcHNPq/T?=
 =?us-ascii?Q?3ZJYw2ap4OK7fMTD54mg7PSaMEKFPPmeImo1MvSvGsLEQ6ejrXfjK/hfjbXy?=
 =?us-ascii?Q?eOLYR5ZHngzB4/ButpuvneotFBmajtwGF5yjJfFGllTy666fI7GviH7SmJ03?=
 =?us-ascii?Q?FaRXN0Ho6OnX3JHsMoVr+2wnkM0332WPnclDO9YvgIjimP2UBaFTRjY169uO?=
 =?us-ascii?Q?cMqsVIpNswHbo7JwNHINVBUUih4+zmfw4R8+ymxLDxjqC1DHfTcHCphkvHcA?=
 =?us-ascii?Q?z4cxxqwXCcLBIaIEhzQYV7lbRAeKR4PZtrK1LYSnhAOEd0wN7mM6mAwdmi6d?=
 =?us-ascii?Q?Pf5OJyaN+nYO9JnLZGTl+rq9yAZ1ZVykGcSF/gDA0LTy/54mKS7OTiXClwdE?=
 =?us-ascii?Q?0DAUItm+0zOz3KTf3xUkZ7sXw8mJv3iwQT9ycxg1lMVy3u4JI6sAbBOCs8+u?=
 =?us-ascii?Q?Vn8uEtv8ZqC6W8E0ksqRWMVGlfYy59strQ7TE4RSxrvgqK5hey615g4DGMMw?=
 =?us-ascii?Q?hFGcSMeH9roYesRDIacEoGvZAJKXHTbZR98Mxb1LLulHjKkVFi62HSo/nlr2?=
 =?us-ascii?Q?l/jreDZqPzojkFkIz3D1BbQTKgB2QPyy00P1epYXq/6NnAgMJHiL75Ju+6+f?=
 =?us-ascii?Q?/fOTwPWFgKQ8ySRYaBz8w2iGN3SdqHDPujEgUBHUE4jASdE7X43Kb14rmmLk?=
 =?us-ascii?Q?3fVGT/cNf6hqI39Q14R6lDmhhGaeg/DSxPYAUiGsrx9SFkn/yqpOfJ2HUKye?=
 =?us-ascii?Q?ruG199AJkIErIWfhj9vJuXU/iNir3XBmRTUJ8lzpTeMZnh1FNAvZTz5i0LDo?=
 =?us-ascii?Q?VNQLT0B0igYlfqHxHGolb85zuzQoM4QTH09T9POO3sPWPDoAAn2JRPEttOl6?=
 =?us-ascii?Q?9svULuoJR4VV4ABaIAEvGLpHeZ397aTUUXyc0H18?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a2e814-51eb-4f83-dfff-08dd5d8abb83
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:14:19.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+yGrvHgQaDk2ILmZaF/it++XhBJtDwBiFxYivQjPtKZbaoIxwnep5GlTuEJ3vPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836

On Fri, Mar 07, 2025 at 10:31:39AM +0100, Christian Brauner wrote:
> On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> > The File Descriptor Box (FDBox) is a mechanism for userspace to name
> > file descriptors and give them over to the kernel to hold. They can
> > later be retrieved by passing in the same name.
> > 
> > The primary purpose of FDBox is to be used with Kexec Handover (KHO).
> > There are many kinds anonymous file descriptors in the kernel like
> > memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
> > using KHO. To be able to do that, there needs to be a mechanism to label
> > FDs that allows userspace to set the label before doing KHO and to use
> > the label to map them back after KHO. FDBox achieves that purpose by
> > exposing a miscdevice which exposes ioctls to label and transfer FDs
> > between the kernel and userspace. FDBox is not intended to work with any
> > generic file descriptor. Support for each kind of FDs must be explicitly
> > enabled.
> 
> This makes no sense as a generic concept. If you want to restore shmem
> and possibly anonymous inodes files via KHO then tailor the solution to
> shmem and anon inodes but don't make this generic infrastructure. This
> has zero chances to cover generic files.

We need it to cover a range of FD types in the kernel like iommufd and
vfio.

It is not "generic" in the sense every FD in the kernel magicaly works
with fdbox, but that any driver/subsystem providing a FD could be
enlightened to support it.

Very much do not want the infrastructure tied to just shmem and memfd.

> As soon as you're dealing with non-kernel internal mounts that are not
> guaranteed to always be there or something that depends on superblock or
> mount specific information that can change you're already screwed.

This is really targetting at anonymous or character device file
descriptors that don't have issues with mounts.

Same remark about inode permissions and what not. The successor
kernel would be responsible to secure the FDBOX and when it takes
anything out it has to relabel it if required.

inode #s and things can change because this is not something like CRIU
that would have state linked to inode numbers. The applications in the
sucessor kernels are already very special, they will need to cope with
inode number changes along with all the other special stuff they do.

> And struct file should have zero to do with this KHO stuff. It doesn't
> need to carry new operations and it doesn't need to waste precious space
> for any of this.

Yeah, it should go through file_operations in some way.

Jason

