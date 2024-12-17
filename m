Return-Path: <linux-fsdevel+bounces-37600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169C9F42AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA745188C12B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF01156C76;
	Tue, 17 Dec 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIaxQ3OS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CF70827;
	Tue, 17 Dec 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412830; cv=fail; b=uJXA0sOkJQv7ORM6+yzt2W3oOD4M6XSDlB71W8GE0fVhocuddlZhKGUqgDbT8cWwfxGU4o7WtAPKrrzJ/VUsSxb6rlOY0ID+W1w4LhE26s6dJHYquvT0hGcNBMkJEPza9pffIJ34dkOIBMAn5MhvysqOyzJuA/POC6+Dh5jsB30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412830; c=relaxed/simple;
	bh=TH0/J7jkDiGdPJ0Ds2v/16UcFlaCz/myujfevBQ+3gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZ5GQLujULu/VTdAY1Z8ggoLx/BwEdhbD0kQ049Su6Bl3896hiGRSazc2TabCYbHL2bPxt2tzHga+ClQR8SS7iy84QBFMNsa76fm+1dWegQWDDFLz67/lXYJq4e5ho1svxGO8BtRJCCF1ZBvJJ1PdEjmey8V2cF+jfPvg1TyFsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIaxQ3OS; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQAj8FuPjY5h2P2mlWhW0mf/ZTrH5SNcr3PoS4wQfgXBvgI/ayVWEmsM9xQHJ1VBn4bmhjwxKZHxkHohubIG2XwshrcnvzB+FyBFanVM7CIBIQzZ6TWpCcb9oVGhIfOTg9lwelQoUlUbdgILrCK1LqH5nbHEWOSM0tWoBdzcmaISmuVNqM/50jwQRjEm4S2U7rJGdXvlglgbRs61bqhoxRB+IW5/oX9AmVlIkJXvfSP6goiyd9NAqaZCZUIdXcBHzNdonEpsV0/4/tz/OwS8CkjPLnA8PBby2mHGtBn/ZN3Wh8+uq+izpKXbfAS7nBDaoroyoJCiI9wiLfEwZ8eANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUM0Rt68ReLzLmETvsu4CJMhlxrGsD+rTS8nWDDVnrM=;
 b=r2y9IA8h5IHW3mOSyWQps0DC2sXjOgzbzEoHk/vzQrJjal0nU8fPNtaKp5BPdEi+ZdBzLWwCS+jWZwzn6enwJEK8n2GA3QNfI4OsYt67fBDl8A0kCF7Fl2+I7m9xprONF7g2Wrg3QuHHI+hS66INGOvmd8Hi6HD8aEIA5FUXvKq4Q3cSqoMPbkIAc3gIZBJ4qNMTxdG1xg2P6VjLXQIRqMhxhm0EYUQC9v5MAOfwqTVzT9xMhlrismqRKswCkeZAZYlxqXMPt6v0S2uXS98M4WmmBJ8dOLSMKlsuS/0bMjUgRwMeXfSHB7LjGSBQDhEy6ER3/0P4FaYeeeRcUqDmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUM0Rt68ReLzLmETvsu4CJMhlxrGsD+rTS8nWDDVnrM=;
 b=dIaxQ3OS8YFbhw+m+gnK+U64KvUglsJEWa9yLrgC68mYVvzRmQ00hwarLM8zjVdD8TzbN7/NGLAhrrLeVwHC6rM77RrhoXZeHS9JigQx7Ff9gB5Dy1Zk2scmYPv6ErQ2QFCFCIfNPMSa09Z5UdKU4JF5seBpfZnqW8cDteBTRuYd5ijQ/OYqbiKtV7sL+cIOAZ4vsy8kjdE0txLKm2aogzob99hdZYjmUZ14p5rUGqL3y5Pvx0f9OhXysY3B8Z96FFtz16xYMRC8anup7YFaB8BgfS6Jir80eUdnqnlsxmx1VZu7UZl0TRQ654MtWcBvtIJ/qkkDflbVij5MvADzFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Tue, 17 Dec
 2024 05:20:26 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:20:26 +0000
Date: Tue, 17 Dec 2024 16:20:21 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	sfr@canb.auug.org.au
Subject: Re: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <jn3j4pdzfnlai4oqr4g7ldl6cq6awiyugg5gbny3l3g5y67abe@rm6zpap7y2gh>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <675ce1e5a3d68_fad0294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <45555f72-e82a-4196-94af-22d05d6ac947@redhat.com>
 <wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
 <20241215222655.ef0b15148120a2e2b06b2234@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215222655.ef0b15148120a2e2b06b2234@linux-foundation.org>
X-ClientProxiedBy: SY5PR01CA0124.ausprd01.prod.outlook.com
 (2603:10c6:10:246::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fa143f-a910-44de-2d86-08dd1e5a83b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBdXMM9hvanblBDkFHsB8ujSjjRbgeudu2hTvExnLnMn7WrHn4AIO8oQF781?=
 =?us-ascii?Q?RPOG+7QqfOjwC8C+A6hqXrTubsX3OWhUCqn3OzQU3KMsfT9sBmzMgISqZdsw?=
 =?us-ascii?Q?uVWTYRdFv9CBo1NesnL7w4OiDfaHCcM7wx1Jo5a6KlExbiytVX9Y1YWSbxCX?=
 =?us-ascii?Q?91eJaKVTDKqLs2AW5A+CPBSIX/swPvAw+m2pK4XceEoGJJGatVHXJJWHEhwA?=
 =?us-ascii?Q?dlsz+Q1oo2wR7hc2VD7NPzpQhu/pVgBj9kiFIuapApg3XqagqFwQM4YjrYaU?=
 =?us-ascii?Q?TakNFv27+yodAAOVbbBB+Y2waECYHAqs8nM6qmHbofDULxaAFx48nQLtrVhd?=
 =?us-ascii?Q?55IdfVTWHW3SUhmCE26NgkTYvnWAIhLCpTbC66akrUUhseM8ybswuyZHI145?=
 =?us-ascii?Q?wundWigCsQk+Cz7uGpDdDU+na8eRIi2LUih2B4cTpZikC7jKezRwXR7gjeJu?=
 =?us-ascii?Q?9taaPGqSxtKvbfA0SuqCbep1274qBBR+s74ffpg9whH6op5SyBEEXXMItHpr?=
 =?us-ascii?Q?J/FtVft5PoZRBlDPSOjVRSqsKjRDbL93oYtONCq2h6ZUsdD6q9yw+HjI1wq2?=
 =?us-ascii?Q?jnkcmahjg5sfGtKEoqBH2ddG4YAzyrnHc9hsxQWBO5vLAYrs7jouqjpZWj/P?=
 =?us-ascii?Q?Z1NKBhm89Q2XaSmmpo3jU4nBkWKGZYuyr8JsecDQFqfGrXs2BMiyMaKG56UK?=
 =?us-ascii?Q?2PM8b86YGyqfCSuD+rDHUYxTHRUmcHWypX9yD8Y/x+5jEFy8G14SFejnFBe5?=
 =?us-ascii?Q?VOf1+z90v/6LsF58Bp01pm+Qa5UUKiiKt/+AcH7v9IFwyemHivkP82uDvC1x?=
 =?us-ascii?Q?4ncBq9oMn0ju1NcZhNSgcZNz486vhivhacfKmELebmOczWND65Kotv9uJ6Io?=
 =?us-ascii?Q?haJJ3o+xGvFoA0s2PA0B37Du6g+Fj7QaZMQO/WpznTf9baNghmwCFtIpxMFI?=
 =?us-ascii?Q?3pHXW04yVfp1wVjVL8UXToSj2n7Opo0T4P8EZ3AJmC5grvuYiyy0Pft3WOiD?=
 =?us-ascii?Q?BVEvPMLSmXKTgQpcM/t4JZdEI5zWdQH3XrwZl+pvhbFVfjJT0Z54yjZukH7k?=
 =?us-ascii?Q?TruXCOT/S+gbMaFgWY+RswQKkiSIuPOd4XRNimpOJa8b3z5MI/JJLlPwCDZD?=
 =?us-ascii?Q?2fDP7bsUiCqgf/Kd+pIKWqhWiPNMjlweKSki76hfsApCaxTX2hnaukhdEcES?=
 =?us-ascii?Q?5mF2eKQ+TGcuiphbamAkeMm7QPBQSV7/NR9Ug/bekAD2KyLSBGelnF+sCEK8?=
 =?us-ascii?Q?+zNwxg1i7m8s0NjceOd2OHzqt/n2722PNQIMv1ImsbGDNdCaJDWNT23rMvzM?=
 =?us-ascii?Q?78Uojf5LBYEJ7Y22RMRNTDV83bX1PynXX/O4mRGN035kCApB66UCj9b+luCf?=
 =?us-ascii?Q?BAL114gVgYugwEV9qYa7j9Sr0oMy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?If3rDZo0rrZtk2bYOSVorabobhcJHrJANKix73jInXYC631Hz1gslodt+1eQ?=
 =?us-ascii?Q?SVjnw8FxlKhoUpEFkubBh7FWgzcJ2QPbzuar+302UzShc/LdZrsvy4MeD4O5?=
 =?us-ascii?Q?luvAjNfne6gCbuuXmRVgfezok987ceNREQ9ApDP2M9CbCm1oQwGzkeKzT9lB?=
 =?us-ascii?Q?73jAPS3cu47c8M4122w/l2Gz10WBnyhjvvnp4YS2F4u25JHIaBqAN+l6ihfw?=
 =?us-ascii?Q?MOIp8WjMNVRe6GBwqfBSOEbpuczSC9DxpA30E3OStrxIgXkbGr0J+Q3C0NZn?=
 =?us-ascii?Q?fDc/FtiGSWge2NxsCbnurhLrLxLD6r1xtr7LE3UTUzMQMTyYsJ1IE+0dsn36?=
 =?us-ascii?Q?vMgn6sJru0mRm9oppmGmqfXkeYSkSzsaxx59VsEjVfDsC4msRqrWPIa/+KvV?=
 =?us-ascii?Q?hf9/RGWiAC1FWdqlClQmuqh2K3RWuQy48JDhU5MHpaFPP+Kq6Bk1VEpahRs9?=
 =?us-ascii?Q?OsSMQaYN6tm3WTiptZGqEhKgRSdaOyYrgo+/+Tgx650TvYD5slt/0tUtdKKT?=
 =?us-ascii?Q?uyqcrE8ozSheJT1UC/dsFfWnC4HCkVLs2Ji2x4KrZSzAYCezjbWzcfEiPzCH?=
 =?us-ascii?Q?KKyXZCDWrBVWWgnIKbiHpohdIWB1j3ijHDf7STq+zZzs8Rd/e2RSp9Yph/RG?=
 =?us-ascii?Q?Ut5iDm4MPH1/rcklUc/SOIJlwbxVq7TFbrtEGyzM8ifoLpM/WEXCiZN4S8q1?=
 =?us-ascii?Q?CTR15UI7dH9GZZkJ70d5Njb1CGW8StWVqblNmEdrH8bvI9ttpD76Kw9oZq4d?=
 =?us-ascii?Q?uoljqVsz3h5MWs4c34Ip6IWFsVFGSiOm3GzETo5UfguSnZdmucm8NNLAGn9q?=
 =?us-ascii?Q?oOTF+UxCfOpUU8jNuOBhWioivK+LkqUuF1TRiub25CCzoHml8dxL3OWd8cLZ?=
 =?us-ascii?Q?IRrpW2DI4EV7FSJdbp/c0G4PN7+aaeXqzOXDBQYDtTjTggYDTvp8ae1ZqdNg?=
 =?us-ascii?Q?4ztyKmBi32FHYNK4ra+Uj6c7i42OsE04CQeVZDIlfIpv90rDegt0mfRKuvl9?=
 =?us-ascii?Q?3P0vHvMimsO+APzDQ64dSEtJ8Tr1ekigM660o8F5fMyRQ9pL8Pgy8zxZiLQn?=
 =?us-ascii?Q?tPtFyom3ZnznSkzkDa2Ul6f5jbMDF0ogbRJx00CUvJWeclVgb8FgktJLMLBN?=
 =?us-ascii?Q?gqQdvOJW2X9/sHhIdXdCa8yhbjIupAO88hWmYvuzgx1HBIdRBIk0AnDRjsqp?=
 =?us-ascii?Q?ndo5jnp3FGnYQdM91TxvSWFIqM5q8OVGUN/l7h0uozK7u83rgrSh6zUDQMkT?=
 =?us-ascii?Q?3GjNuhO6z8SV2B5U+y0Jvq5+zUoQ3DuK2IPih53761J5IrkfPuFn5Ew88/uF?=
 =?us-ascii?Q?JxZlFTJ917Qm8/iwWA1HS0VdOu09crfja7Il8LIEq41L6Nci0fiwG782C9Rr?=
 =?us-ascii?Q?dPmYlRBDkDlLK1NQU2uaHYVtSYCQ8BNm/d4CLvkQXbJTo3ycljAmV/9Y2LzS?=
 =?us-ascii?Q?zAddgPU+gwJykiyZfhTQueeUBUTsPGbdDaQ+uCIG4xpPv9P2xY1/iAqG2zTD?=
 =?us-ascii?Q?ThtzLu0JP1OrDG4ytv5idBAMALtIvlorck3iIBd4Zat48gKLPEI3dYEwWl4/?=
 =?us-ascii?Q?JB3uX3u0U1mvezMFr517YULLQny+zwsvFXTyYHA2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fa143f-a910-44de-2d86-08dd1e5a83b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:20:26.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKTLzMSyKZXfXNqtjImIlrzOrgbEx1lh4Cs/sguu9pMSnEumBaYEnXphL9j7mi7OPU3ShQkHej54X8xNV2Otqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260

On Sun, Dec 15, 2024 at 10:26:55PM -0800, Andrew Morton wrote:
> On Mon, 16 Dec 2024 11:55:30 +1100 Alistair Popple <apopple@nvidia.com> wrote:
> 
> > The remainder are more -mm focussed. However they do depend on the fs/dax
> > cleanups in the first half so the trick would be making sure Andrew only takes
> > them if the nvdimm.git changes have made it into -next. I'm happy with either
> > approach, so let me know if I should split the series or not.
> 
> My inclination is to put it all into the nvdimm tree, with appropriate
> MM developer acks.
> 
> But I'm having difficulty determining how practical that is because the
> v3 series is almost a month old so my test merging was quite ugly.
> 
> Perhaps you could prepare a new-doesn't-need-to-be-final version for
> people to look at and to aid with this head-scratching?

I have just sent a new-maybe-almost-final v4 rebased on top of next-20241216 to
help with the head-scratching. I haven't yet done extensive build tests or a full
xfs-test run on it yet because it sounded better to get it out sooner. So no doubt
the kernel build bot will find some fat finger of mine somewhere :-)

That said the rebase wasn't awful so let me know if it should be rebased on a
different tree.

 - Alistair

