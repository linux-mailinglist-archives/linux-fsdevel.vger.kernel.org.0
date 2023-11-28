Return-Path: <linux-fsdevel+bounces-4025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE87FBB21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06660B21533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6C5788C;
	Tue, 28 Nov 2023 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="XehbtVxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423D10DA;
	Tue, 28 Nov 2023 05:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJOIfd5U8xDrH+PFdd/+dqaLlEs2KCXGZl9bT/2xUtE7HWarXhzBEB8KxNTO9o9AQh4iLBBjRCYsGZl39HapcR9MGa0MbPU1Tf0HM/stiNMz7DnRM2Cn6taS7RizjYFkkU7lELIe30M6VM8M5MC/yQQE8RvjAmlw0nRIRLL3BAAeJH5n3+BjSLOfw7X9Qp2tCfQ9fjPIrb9x1T7XWVoGQOO1SdDWzeBuTVXAzkXuxNkl5Mf472ArwXh1b+mdRPbDRPdTPKUlsNc0wJth9WOjtC/5rIwE9dTwJWVeIffo7buFnim4E511haoLl9yBvKO3WDBd3piTh6oh+FUeVpHLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6F+FZjJpfn1HoLaBjoBNRhDjZr23NPVpqCE8ERdGn4=;
 b=VZsQ2Ck9hA9CxfhzJPE0/T6LYFC/Mf0hBmkK3cw/MaP3CqtGyFbGUnjUhu+2vMeGu5oz7TzUx/JnYFY2cjNjWHmbUUvesZbG8Mdc5tL+LP8deTFzPWywchORQwGiYVHqnaoeGhja1xxECUDjtsBmay5q/heLZAUQf6CXRGSnV0kFpFTBT501gG5kgVkIaOUGolOW4TCORrsFFSQXvqbc0BBRrJrSa14KPUGzLn52JH9cXGrbJ/CZwZWgzw6k7u9q32BzSeemd23U4uDrGQ0sLufuFTUAXIUnRH3tvzPeP94HHhFU5W5hMb4xx5QEc7WVmFAKw1Ck5YBrczxW3F013A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6F+FZjJpfn1HoLaBjoBNRhDjZr23NPVpqCE8ERdGn4=;
 b=XehbtVxPTeygWLjYKcbwhEs4QjkSviA8BooXAQ8p26cULY5t02JtH2X5AEZHWWc2ehr6RQeTZ2/my7yHNjLr0AmFNKUTvSlrl14AFLjHHr7xS4vd8Mn60Jx4Mkk9NIjFmLIxPwXSLKX8RyKn5sbCBMtX9Kxry3eXX2m4DnzjcHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SN7PR17MB6819.namprd17.prod.outlook.com (2603:10b6:806:2dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 13:15:57 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 13:15:57 +0000
Date: Tue, 28 Nov 2023 08:15:47 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-ID: <ZWXoA6udt0OJ0P7c@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
 <ZV5/ilfUoqC2PW0D@memverge.com>
 <ZWS19JFHm_LFSsFd@tiehlicka>
 <ZWTAdKnBVO0+5bbR@memverge.com>
 <ZWW2ngGhM9af5qJW@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWW2ngGhM9af5qJW@tiehlicka>
X-ClientProxiedBy: PH8PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SN7PR17MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 445cccf6-4b18-48b0-524e-08dbf014282d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WpD2q9HNIfPSkVkDRJ9xAFpNUqDEsugVivYPJbazTOElYAzctbzbgMtJ1uHj+Y+ZmNsRU169TFhlnS4qJ4D8g+w6iRxW+ESdZhZ9PtZIyuMPQSwdfNTojYJw/PtkzO6abnXtcmqX4g6KDVG1np0jvhgwMaZYWnjEvKScqG8BvPU3qv8ncdFV+c9js8s0lfjoog5PV6qs8jG+01eRIFLbwxUsbSb1NvYWZRCR4G8Ru+2sw21ae9C7CS8R0VEp5YNorqO5wlYrblr/RrF/svv7LSEkI2w8X0J6p6Ut1G50GI2fFyfxpgqRyIwkdCgumTQql82+zgSPCzjlQTNDM0Mf1Ht38fszkYLLsbEvZySO4IHj8fu97a+z1U1Rg30zNpg4vLqNMaofbKQjvJq73aBOwdfQ++ilTCZZZ24xZlnIgUjq4knck9t7zLZJxiOI7VCfm15A4VWV7wP7cmLcP+Y9BOLogeb//TYhK/S1bVpNcG09wvLBE78TL2qUUMwysYxBF/ee84Rrs99g+ODFI/IDKXuckv/QqR1Mb/ghnc44Pm54d+DPy13g44qlSTeETtGj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(7416002)(44832011)(478600001)(86362001)(2616005)(26005)(83380400001)(6506007)(6512007)(2906002)(38100700002)(6666004)(36756003)(41300700001)(8936002)(4326008)(8676002)(316002)(54906003)(66556008)(66476007)(6916009)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5Qor0B7Twu074At4B6PPb7RyIGi2ZAyvc2rS7qIhMgiBbwzphTYAtgCCnid?=
 =?us-ascii?Q?GSvwTr5DPjziXHMNZ5KPuVq3PW4lUpBx1vKaN1oP2LyopKqVycjPNW0FEsoN?=
 =?us-ascii?Q?cEMJHImRnhvaDii6OOaHvIrkx0vHOE5SuC1XpGMcSeK+p9PTk+hXYnJCHCma?=
 =?us-ascii?Q?NYUdAd9C2wMf46knHwTcWbo2UyyOsEKFa7IiOe9M1kN2+19aoHeqSRv+3fNA?=
 =?us-ascii?Q?6HAjIPNXfdtXDw0Twv22IG2ZCLsdPhOoAni5vpF3mGBHayo/NZTOWdcGpxpJ?=
 =?us-ascii?Q?1AGjMmCOBE4QJCCDveEmlQv/8Zfj3TfeE1a4/qUrS+3E0Oy70sMGaoLjwUNu?=
 =?us-ascii?Q?hjygpK9UALYkqrYspXjaM/S1gegLuliUIgkxaJ+B6VKZhuZPMBqz6RhUy2E8?=
 =?us-ascii?Q?S5NcjX8ljQe14HTC1Qz7t7Q94yM/ad2h6wYHkSJCvQyoXcI8tjMlyfbncBAl?=
 =?us-ascii?Q?v+0DzSaaJj3l9z94GM24V8JlpqoFSBJqUp61CN0zK99jHPxWkcEp0I1Xd/Ec?=
 =?us-ascii?Q?L79qPncaBDH15Q0cfpea+gtyTSK3OfqDr2yrwsPNtoBuVcp3zaxtdMn8Y7ZL?=
 =?us-ascii?Q?LGw7WXUCzBYinQDGwtauZNxoJbvFZutdpqGtx9g6tUOPje1L0dqXDmTblaqO?=
 =?us-ascii?Q?UA394oLuMACZTICZ8KORMyrQqE2EsUrdv2Ah/6h5FBhJwtUMflY0cxjiPi28?=
 =?us-ascii?Q?q+j4YN72Xs3Ovem/eAb6laahk41V4bUkPc5MwoEBSo6X7vASPdVpVcRmfBpG?=
 =?us-ascii?Q?C2bj/Epf1jzck3o0HVl5U7HtQq++x+7ej5V53y1bHpdmXmG6+tHQyMbYEnwA?=
 =?us-ascii?Q?DjBZj2CKMY1H3hXRTICD2uI/sFA+KPzG7Zw6uBNZH88it9DlzThhKqUQ8J/O?=
 =?us-ascii?Q?eEOzzQtwZEVKVYOQGVKFoiyvE+5Tgx+sBSqYpUGLL4AYMBpfIZpiy+eLxr2H?=
 =?us-ascii?Q?LKHT4XstN4nkFIJdl/oXgF5LQpTIeGadmleE4OyIZI2uv3OOJwt5+W5E9ckI?=
 =?us-ascii?Q?4s5gWg5zoyobCdAst7Zyhg19wk/0JR+wXJgJmnqVafDrPSIAJkwOw/BWxSiL?=
 =?us-ascii?Q?pnP4li0H8Z0h8qYfAzOa4+xWpIWLagsSMdZ+CH7Ot+AUi9FhzJTFF4f64vhI?=
 =?us-ascii?Q?ZHWl9eLJicHPLIK7GNkAVe62dn6TKikeGpkMUgJrz2b45ZrLkEQ9qWOOUFAM?=
 =?us-ascii?Q?S/4Hrvexv5SBvkkRXFPkWfr7FJAnjojcNXorkYMfdintXyrtUQPmjnn48DKe?=
 =?us-ascii?Q?svQ32eBgtzpdbdAAYBfxOs/tbwwmYZdU62r0oOHQHutY6awaa85xFMMs5RZb?=
 =?us-ascii?Q?phJGb4oQP/dRmH1QxukTQTmTA1Dh5wABbhIqcE73tfNj5SqSz3Ztv/znOFND?=
 =?us-ascii?Q?s42yNiFifwCGLnh8EYhuxGeMDfcpgilBb0TtAowN7THzDiVWWHC4BupG94tz?=
 =?us-ascii?Q?Y6IrGCjWxV2Y4s/RygnwVs0KVoJL/OnMpFLpAAUl5YCvmtl+zcSjYlSNFhdN?=
 =?us-ascii?Q?idpFlmcoz4ICMmTP4Hl0JKwazV9yYVSQAzB55KOKTpuxa4RvKo+Kdar7C31R?=
 =?us-ascii?Q?hGFxdHNVxE35DxYXh2A6X5Y3Ylpfbm/O9JTHmjBdoxLm78B8wfAwt2Htyd8q?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445cccf6-4b18-48b0-524e-08dbf014282d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 13:15:56.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSAS0MTUmHqSiLoI6cXLkN5Idgdy+kYxHMYHNKYKYiITftFYV1ojROZhEqklh0b8bw1ypKG9UdnvxIxLIo+apS+iH7yR6UsHm1SLHs6niLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR17MB6819

On Tue, Nov 28, 2023 at 10:45:02AM +0100, Michal Hocko wrote:
> > 2) Should we combine all the existing operations into set_mempolicy2 and
> >    add an operation arg.
> > 
> >    set_mempolicy2(pidfd, arg_struct, len)
> > 
> >    struct {
> >      int pidfd; /* optional */
> >      int operation; /* describe which op_args to use */
> >      union {
> >        struct {
> >        } set_mempolicy;
> >        struct {
> >        } set_vma_home_node;
> >        struct {
> >        } mbind;
> >        ...
> >      } op_args;
> >    } args;
> > 
> >    capturing:
> >      sys_set_mempolicy
> >      sys_set_mempolicy_home_node
> >      sys_mbind
> > 
> >    or should we just make a separate interface for mbind/home_node to
> >    limit complexity of the single syscall?
> 
> My preference would be to go with specific syscalls. Multiplexing
> syscalls have turned much more complex and less flexible over time.
> Just have a look at futex.

got it, that simplifies things a bit.  I can pull my set/get mempolicy2
work forward and just keep the interfaces pretty much the same. Only
difference being an argument structure that is extensible and possibly
some additional refactoring in do_get_mempolicy to make things a bit
cleaner.

~Gregory

