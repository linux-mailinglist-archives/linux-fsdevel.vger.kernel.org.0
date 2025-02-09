Return-Path: <linux-fsdevel+bounces-41344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BEA2E184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 00:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D991884528
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09914B092;
	Sun,  9 Feb 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWbcZzF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6614B08A;
	Sun,  9 Feb 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144147; cv=fail; b=pRkcUgZEpNnupDfXyPVNcqGAyMK6568fVuDeenFt0I4/OP51xyotHorfQVvFJM1BSDaae2S7+SY7NvvlBdujIZs98eAyxlKuGrt1sgv6458R7sHioi3esveIwiac9XufsGD4I1dYQwGMRySycHSOjFNvwNqaD+0oQgsjm4Oy1Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144147; c=relaxed/simple;
	bh=c2fEmCjUA0TQPxvPEKs8KpvEfEdQRuw19IXDXnu0+AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IOFcYlwSmQq/wL5vVcNlubxIu+GYypNj473aymLE2Wen5zCKGHFT56KWJt8GOfCIgZoBQk2hOz7fvxbP3JJG49pPg4kPp6kanb6vwZ0dFCYonkMnrDObADb0wXGnoiMyyZKpcR3rZuXFAifUtQsYwpXxg3b9uoCiY+cgmbkylQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWbcZzF9; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ydslxx6D0K7oIvicwlFr/zMkf6MVV+c9jy5M8S/Ji8b2ynoGNHrPM+QY03Mzp3WtGdZ+b3SiCFxLV2g3GligS3pDQw2s+cPzIPm4cKNUEBmm+Qvy+AApEVNQkvR7BV6JPnxAeKX78sEBROleChasESFx7BVevtnikx4Q+siYVdqh3mPG/luvkPTE8cGfYC+x1d/xZozDscJArHbPVfx7mn8aJJNwKSng7m94rfZboTDadYwHt0PGqCc8AHY3gdpIGBNXOvuzPf9Kd9pmNHzyWC8jN9GADFZaLsBQTGDuUpsIJBTkId667KElh+m0xRqI4udCfksLJG33kjVBdjzuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQTkoXlLWvzGTmDQMcZPGJnDbOoTMlLaKU7mfTe5CYA=;
 b=Vvr5jtcvz2N+x6cv1iqwdYgWilnOlNJhSnzcIBi4hXWp9eDBA056c6gaZuiEOq5b5HTUr2nuDjsg1wQRFuTTJ9pYchtQVFEQQ33FcetHpeScD2qiW0lfJCDSpoNQgnDzJE7mJ79i7PA24BMymhZC6lp48jWgqatijjsuc89Yuu/UjbZJgHDX+BhQUflOSP/LmiI/2K6Epv+fA3RcprstaPR3kRpIn8RJPO7Hw4YOlKpKMmeA1G7S1BA442O60B234E1cUFygskZRQftgpOvSLii5ZiKC2Y7DcDoTNZvl2iUGpffTYNco+qKVLps7Oma9fZNhm8j9DLTNv3ObpLchdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQTkoXlLWvzGTmDQMcZPGJnDbOoTMlLaKU7mfTe5CYA=;
 b=AWbcZzF9lK4hXXH7H35X38/z6nRfUTlOlz2TOwfKW8HtvHf1ENIZToST4lI6Z4YjbbqHawe4hIexZJ63WiSvgf8ZGW1SGNU7jCZlpnZYtslqNwX4EWi8wHtyLE6nPYkWSmIrj3YD5gqnXnVvaV2hcrLmjHOvXVGFwdrScXPKytZ3v8ahedvLyrAbr9lZ9hbM5QYHec9XuVU8m9/kINRmT4tQVYvgNMjvtEgpToLZldNxnmkxARPdw4yyhjjy6Q3QfnOKT7hCklkslHGsR2b8RD4CqOHV/GPDMMTYdANMO1ZYzaYZ0ThEIAoL7TG6Pua/2+p4QFqncfqVQct8rQzkxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.15; Sun, 9 Feb 2025 23:35:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 23:35:40 +0000
Date: Mon, 10 Feb 2025 10:35:35 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 21/26] fs/dax: Properly refcount fs dax pages
Message-ID: <y2uilkilpl4k5snzxntt4x62z4d3mumxqyog3gy3zrey3jewuz@x3ftslqihoil>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b2175bb80d5be44032da2e2944403d97b48e2985.1736488799.git-series.apopple@nvidia.com>
 <6785db6bdd17d_20fa294fc@dwillia2-xfh.jf.intel.com.notmuch>
 <zbvq7pr2v7zkaghxda2d3bnyt64kicyxuwart6jt5cbtm7a2tr@nkursuyanyoe>
 <67a59f0f7832c_2d1e294fa@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a59f0f7832c_2d1e294fa@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SYBPR01CA0205.ausprd01.prod.outlook.com
 (2603:10c6:10:16::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 653b3e5d-9b6f-45b4-b85f-08dd49627681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/RdVMZG+bmXjNksHgrBHcdy738bNYHywwjd9mPQl8n4TgFMgbvlusl8SWN/v?=
 =?us-ascii?Q?Ga0tJc0TBHksquIiF+Bt6tyZxvHnN+HQoy/DCMVF7/bJI/JY+/R/sjqh/wdr?=
 =?us-ascii?Q?F++TlHjX6f0S7OYP8mg5aN1MhszwQpTBnQr/cfFv6XMwc/Cvr/xF/6bd8We4?=
 =?us-ascii?Q?5HnVKKU3suWNqdGnqzZyAeWPS8EkVIn+TZ1E4KIyv0tpbol/7b61z417eQ85?=
 =?us-ascii?Q?yBnnRJ50AqxbbpjhvTDuoa4LTrat8RH5QMnqUxxoBSQHI+M8fdmiF9nEI/x4?=
 =?us-ascii?Q?l8wVjIUxtoORvs22cGezE3Xkbno56pYy7gbUNbtbAod4K2iJuLKFBzVWW5d3?=
 =?us-ascii?Q?4lRJYgMYzvP7MSdzCtM542jFgylvN1+JOFUXB9XLnzYy3LGK0rcIbMBnhZTe?=
 =?us-ascii?Q?cZI4dt6k5Pltva0PyMD98/M4t/o0BheujShlj/PgOX0uZY8qm8vcp7xGOIg8?=
 =?us-ascii?Q?/jHRJ+EynWZ3Ome7R+iZozwuj0x42YNNUw+ZdNiKuSHeZ2KQmLavv/fl+45H?=
 =?us-ascii?Q?Q419SJ9OHj0kyMZIpu1T0hRogdGNe50TAxN6ylmgXQvwDi2QJ2rWbd53i4oh?=
 =?us-ascii?Q?n32ksdYBfosvBb1M1+4A8hSJCMz2lcWqpQjy+NzORDb0arR6cKZeitwZdFuX?=
 =?us-ascii?Q?gdEkQ6Qk5sJn+LGKVkUHuGMSsm7qdH2KU77Ef8Mb0Q2vyPMoVdKUmPpkJKZR?=
 =?us-ascii?Q?0sJUQD5w8Fh8r4oSoBs4vHhvxIjYsucREEjSjEAPUmpdbazqsxDlzkIblFUe?=
 =?us-ascii?Q?wNfIpQy3eXV7QxzFPIvtWcKzc+CDvsySO2o/WjeVkLY1jmYEvqTY2uXW++dp?=
 =?us-ascii?Q?7syCTgBIWIqajD5oPkF8FeBh9/QebIzBMC4I4U9t2KTRA1RV+AYVh1WMqcPr?=
 =?us-ascii?Q?yIgLT5Q/feiWPOV1pfx0sVW5156aSUgnKMympk+CmNhjk/fdkr7esp+z1QvL?=
 =?us-ascii?Q?P8T8XOfy6goUYa5o7gFbP+2pus/325Jx1QeXHsR8wIl59rKyhsoDenuhrqoa?=
 =?us-ascii?Q?QUSQgJSCacVexhSdIl8nO2dYxOstqdGiCjw5rJ6Fve6l1bIK0QNy9tLDtW6w?=
 =?us-ascii?Q?Imid3L5PCblDDBzf6LMvx+kKxNTW1x4rU7MSeAFR2H4WM/7b1vMdEPxt/4U9?=
 =?us-ascii?Q?znlbW3Vmu8FUIIHJM7I/hEYMfkNlaId/TO8qKTI/04Jd7zCiQDyuYeD+NnKM?=
 =?us-ascii?Q?yC1bnpVJbVvhtgc2GRcM10+D4RpAh6WpZwYT4GF/J9sE6lIRUwirv2GuZu0J?=
 =?us-ascii?Q?JgdKDuje/yAtdEUdeRPS7silLMYCb3UIO1UvgEEQu4CjnLHkBzW1GKdUs97c?=
 =?us-ascii?Q?gbH95lyrjcPE/+aQyAwxnsHj86G4g8e/089nOTnyGqhzyLi7W1eZww0rvqx4?=
 =?us-ascii?Q?es6iV0lLLkdh21Hy6T4D3kWOHS75?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5X8FxttLxLQ321QhCDIKXrhO1VIYJgl8Vngx9GONhcnrnJuPj99h4EupFLG?=
 =?us-ascii?Q?pewdZP5CEFR1EUV/4b1HeSUGwGBqAk8zDj5J3zh87kVvlk6wKwBwiOd89qfW?=
 =?us-ascii?Q?ot6Cspd4t3ScymfCZC17cxW5TlaswZ5OL3LUZ8P5XsyzT6FrzjFZpcC+xT6x?=
 =?us-ascii?Q?ETBJVghGKQSEsOOP/MwUmopuNSymwUrs4lxV36creKiaJWw75ysc2TAAX1Ki?=
 =?us-ascii?Q?74pHnCg1u6mtW6ownm1oi+mna1E54m1FOdPAQ2+1bW1QAKoWxUxfFcu+BCVy?=
 =?us-ascii?Q?Avr/vl+vziUcEe3cKpMPXHbWOWI8GR5Hl/PBj//pIs2gRVYmu4FoI/zSvlrQ?=
 =?us-ascii?Q?Q1Efv9gYlwLVszwMmU0LmtyvkUTJTcUPu+um9dtb6lPKlsKAEJaTxHZIiQhL?=
 =?us-ascii?Q?zmqCyVjxNBwzxGNCsdEeV8V2WhWdAJr2XeucV8p+/zglaikc1SVZ4hxBwdN/?=
 =?us-ascii?Q?sSQDIhol3gG5EBvLIcgpJyEb6YWpeZrsTcjS8a7/nEgKMnoqJ3u2MVvMztC2?=
 =?us-ascii?Q?vrSBchJz1kHZRc08+e2q9au218klLt7UcLOfMOPaOoquTKQMlWnWCVu/vg35?=
 =?us-ascii?Q?cq3Gel41b6IvG5CkjH8ndjPavN8HuY7R9YkvCP1igwyHtNku1scVaNO5mUIM?=
 =?us-ascii?Q?dio3KafV50hjttiG1Y4AAI6lTmh0jjayPcQyWJvfbDUXbT0sDWMnGC+b6mxe?=
 =?us-ascii?Q?UtOeMa+hb83zCiIxp6/TDZlRo9lG1710hfMq1t/r4V4z+tua9SaIKSDZzu6X?=
 =?us-ascii?Q?SwG8VT+upCHozTAkbwvmnTw1kuC5Et2EPh5lSAyiWC1hc9psDVhijWUahdEz?=
 =?us-ascii?Q?pfqZ3uB13yP9KxMDNBJuhNHpL6oZgOAWiY7zjG7wSNYJdO59ISVei7InukoF?=
 =?us-ascii?Q?D4O2H/cjAbcHaf+U3H1HiycPW44yTHgX2jCuDSt5EPGUV0VWZG9fQf43DIiB?=
 =?us-ascii?Q?cQP8ebNqvng/lqIT67OTVYIELfh9fo7+bpZMmMUg/sTuguw4s4tik81ehhUk?=
 =?us-ascii?Q?38P7ex9xl8GQELsofjtbHMA1IW7v7tB+2XV8ze6yAK0cjD2Vrp47TR7kyl4D?=
 =?us-ascii?Q?Kv8uaWY+Rw8TCgKbZW958NkOp83tHnPL6x4wg9mriz2EqmxP9F++FbwfwsT0?=
 =?us-ascii?Q?cjDqxtggszaBRZXuhSAU3WBUKRzMPbAbEKWdtzP8OFXv85uBPJjJ9z84arIM?=
 =?us-ascii?Q?mU2ovJ5jGl7EA8NXp6140FtuYPkEAlIaxw4RACm1VHwQ4iP1ebdSrGXKXQF4?=
 =?us-ascii?Q?V+xAlbY7X24/RE2l/RlIeUzc6271UVsn2sq9tK2SlLOn6/hAj/UuaoEHiC2Z?=
 =?us-ascii?Q?XOM9jjkiyKGp/4TArRsCOo9IrxwjBaI//r2VqJWbIje9UngIyEWWsRLaJ97k?=
 =?us-ascii?Q?9n4PBzw5HUqY/0F8CbTuHoKz/0yXQf+KSkIg2FHNxOFKapz9YLXuuopGR0zY?=
 =?us-ascii?Q?JkXaXz4Cre2WfL2hYmnl5jrGErmXIIny5sMHrqHUZ/AN3v1MVnXdmPi13xbj?=
 =?us-ascii?Q?OOZqiJaZmut6xPBGUxmUz0BCxfxEeJbcc3aByiHjP2TKtkVktzDQnU1xfykc?=
 =?us-ascii?Q?xPVfyjLVnVa6AztiInwEc30HhIYUVZtpux9+DBN/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b3e5d-9b6f-45b4-b85f-08dd49627681
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 23:35:40.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi2g87gCeu5dWYEMg2cHR7DQFaXnebvK5/Vz0gJSRQTusr1SemD5AGwuXQkupA/oqF2Tl9XqFBLiSehrsyZ+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464

On Thu, Feb 06, 2025 at 09:50:07PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > On Mon, Jan 13, 2025 at 07:35:07PM -0800, Dan Williams wrote:
> > > Alistair Popple wrote:
> > 
> > [...]
> > 
> > > ...and here is that aformentioned patch:
> > 
> > This patch is different from what you originally posted here:
> > https://yhbt.net/lore/linux-s390/172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > > -- 8< --
> > > Subject: dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
> > > 
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > 
> > > The dcssblk driver has long needed special case supoprt to enable
> > > limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
> > > works around the incomplete support for ZONE_DEVICE on s390 by forgoing
> > > the ability of dax-mapped pages to support GUP.
> > > 
> > > Now, pending cleanups to fsdax that fix its reference counting [1] depend on
> > > the ability of all dax drivers to supply ZONE_DEVICE pages.
> > > 
> > > To allow that work to move forward, dax support needs to be paused for
> > > dcssblk until ZONE_DEVICE support arrives. That work has been known for
> > > a few years [2], and the removal of "pte_devmap" requirements [3] makes the
> > > conversion easier.
> > > 
> > > For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> > > (dcssblk was the only user).
> > 
> > Specifically it no longer removes PFN_SPECIAL. Was this intentional? Or should I
> > really have picked up the original patch from the mailing list?
> 
> I think this patch that only removes the dccsblk usage of PFN_SPECIAL is
> sufficient. Leave the rest to the pfn_t cleanup.

Makes sense. I noticed it when rebaing the pfn_t cleanup because previously it
did remove PFN_SPECIAL so was just wondering if it was intentional. I will add
a patch removing PFN_SPECIAL to the pfn_t/pXX_devmap cleanup series I'm writing
now.

