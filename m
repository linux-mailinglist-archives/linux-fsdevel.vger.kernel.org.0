Return-Path: <linux-fsdevel+bounces-7141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E65E822296
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 21:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967B32847B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347F16419;
	Tue,  2 Jan 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="kmNqZJGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EB168A5;
	Tue,  2 Jan 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxlo1Hg1twDDOlW/bp1oQ6WYhAvdDnMtu5ygkf/Lfeq6vfibLd0q33f01ShzI8LDGZit82tPcrhAmtcgSCT2Yd6PkJok2yfOQgY1ldcTDbrwu9DepaOfRVhmZSbyyGtPxmZb4Bdebz89+7ov4oSpYR6BAUNezx+VBe+y/Kvw6uZ6DBx3Cp319k7w1d8jr5JPmQz3sLCZJ8MSvlo8BiJ6FGjvWzg2bFc7UN/T1gwImzTw/q3QtzcDW8bRyJMDsrnjCnzHzP2PzkDjEgHz4AbnyP9dRTdORMGskdcWRN6ifTK/ibfsjUXO6TR0nyN+k6izUTlPGeiJMXjE6uGrcschuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY1DBzUJqqFNYaauge9NDoRiToCo4Bt425Rf9Rm6xFg=;
 b=T3SVkvDnphXAuNyhltkgAUk/CylDGgi5Vbbg7VQh33lHbOrR+LU3ZXv+Glz8iNSafYAYekpBdMnDXhr2mOXMOX8aGRol6jNCnhF+fHAFn9nEid9u7SWNu+k2B9ST9XWe9Y77o6hyk329RoS5WgZbgadC9lO6BcTiw52j+UaNPao1AfFwBiSYUKOeYBO/ME7sfJ4UlOzNAMMFN/nZFuOjVlrZt5lyKf3bejBKAYdnydvQEQsuroA+cE9N/ZqKZSnXwd/OyZ+yYt6AoTGknME4b5vLbuIs+26qc98tU+ZrRIOif0wWcLxjy9FBtZkDgx4vsN5jYUALtADyMGWOBui09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY1DBzUJqqFNYaauge9NDoRiToCo4Bt425Rf9Rm6xFg=;
 b=kmNqZJGoxdZi7nEl0fe+VRBYtWL0S/JEcxN9Df7Zj51Bcx24PeX3gliJjHd3EOqNS3xSZv7ZcGiRqsi5/Y5GEpJFhrYn4WtmLLX0Wysvw8TUf8PC/YbuaMw00Q6MA+vHnJy0Sg/rCQ56sYSDLAjccIqS2xjH4s37QKzS6iILghI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5123.namprd17.prod.outlook.com (2603:10b6:806:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 20:32:18 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:32:18 +0000
Date: Tue, 2 Jan 2024 15:32:13 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: Re: [PATCH v5 03/11] mm/mempolicy: refactor sanitize_mpol_flags for
 reuse
Message-ID: <ZZRyzRjHCkbqpSTv@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-4-gregory.price@memverge.com>
 <87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp7P1fH8nvkr4o0@memverge.com>
 <ZYq9klTts4yg8RhG@memverge.com>
 <871qb0drto.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qb0drto.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 78023ec1-06d1-45dc-daad-08dc0bd1ea14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b3Wo2/Y2yrutfss3Q+F1YBxqLU8n03+5PzmiGo6UXTQyWarsDpa4U4iqzcpy/Ghp+CXqp+FB0M74ZcVDhgkTwgSwchAeRaRGGjGYz+t6KJcwprDBSZ2276NuR1Ut4h2YvscBymjOwITAWmm3TyoCzvdeYVrC3bbeLjEqiUW2LrPvw5ysvjA4VTEWoqx8znXPKGWCBsYkN1gib9y4Eg4lwrbblyXSOiHSBg5LQLK+ckWE4sZxby5yK4McclutT431Nzb1Mqz3j88/Yze398GYcli8ugTMW9R2+vFW4wk6St7qSprFXp8GC5CwM7oPVFJqWoqAIssVspwj9xsHMneq7Vbk9MbgAemMcdjHa5FT9EncL5dSp8L7ama1ujhiT89oqt0C4ej4lKaY36mcE5Vv4tRHJ41vzxc0zhDDPlZCTHY0MjTSTpWJrTEEgez/Eu4ROCcCf50K7+0j3/L8+sNuWto7IP2F8niKz0SGfDPwZ8TkzAFKcyn46H4Irn1tuUHwwa8y3V0RAiRr8+1x4uIclFhD9/ik/8v6sV6NJ38avUDyKSpjkBgL3C8uF7ihZCd3B8WS2fCPEl2j5mpvMSHqW2KQBF03/lSebO1LQhlaAym42fZpFhYNMJdU523ET9/v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39840400004)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(66946007)(6486002)(44832011)(4326008)(316002)(6916009)(8936002)(8676002)(2616005)(26005)(83380400001)(6666004)(478600001)(6512007)(41300700001)(7406005)(2906002)(7416002)(5660300002)(36756003)(38100700002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJn7bGMwi4NR3gerqH6sgWdcAwFm77ubDpolHCFdSZwkCmlUvfrwfh88nmo+?=
 =?us-ascii?Q?MPRDC+3WE04OI6gvynlxeMNP0B4SSMcVyYgfy5Cm5fjsJsRMW0emT0WPNQMl?=
 =?us-ascii?Q?SNNGw96ezUOW4aL0w0Rw6DBBii3spyIrfm5TOjfznqibRd7dNZi5G+X3TraT?=
 =?us-ascii?Q?IMUtkxuoYNv7dG0ZUZile/RlDRiLTCS4eYGOXmo7SRUVLQ7Fm58jlgR+s18M?=
 =?us-ascii?Q?kk29UUDj712ArEts1Qg+50T4fjW9MSY/CdoHZMlTvaRkrb82WkP0UE9g2GjW?=
 =?us-ascii?Q?KHTFDNaZIvOeTtSIbXgH4d89UnkpX+RWu/y0XuPX5cYM11QWMhO4lZL91nVi?=
 =?us-ascii?Q?gSpTGQYsHHMWKXEmKtHXqJbFbaJXCaNMAQgq+GGFb88hXgGb2IjSlAqwd6fM?=
 =?us-ascii?Q?ffaXyRogeGVlLSQP7Vdps3PgBpoxZsZScujssoIlb4H0m6R0bjXac0YVeiOp?=
 =?us-ascii?Q?aLMJgzCm3+BcWYSljQ7+5qECjBjAmHEI5es5ZfAKa/ri22kgH5kCHuVsyf7y?=
 =?us-ascii?Q?e7zlXQJmvp/1eN3ICw2neHepjh4j/kkRsHNS80W1bo2bD88mxZ0tOWdcmQgm?=
 =?us-ascii?Q?zkj1rLvP9XfKvyoldjeCrnyw0ayVef6LxvuTQ8Dv+hvrqj8SHfxlM0A9B4/7?=
 =?us-ascii?Q?jSvGwEetessHTiVcwKqWMzeIH2opyW+G92s0GLZum0LtKvzwO5oz0PqWGaK2?=
 =?us-ascii?Q?PCSbiJiCFDp5+72BYYtd7Tic6jV9C0zrQXH2woNbCq5fUH2IkwzyS2cgWOLM?=
 =?us-ascii?Q?uR/a40LfJ+bF9dDmZGcPrIj1EAo0LW6RRiHjMMWGJxAZF4MWShZ0Lbf+jnXK?=
 =?us-ascii?Q?/108csTJv7cuXp7f9wy4NoiL1pC8RKUCGKWlnsEe3oNsInXU0QnRT98rWD1t?=
 =?us-ascii?Q?AYPFclla26zPBkUHEPWbkOWy6Hgxm2cmAtVT3TG1Sv5NM6gFvYDVsw/TmA7h?=
 =?us-ascii?Q?CVWwQylincPB8fe/yP6teks0cVcB1tcdDcV4wd8unI0MqfkUTsgqn0Yc+cwo?=
 =?us-ascii?Q?pM/U85UL7IHwoGQZNnTS3Ex3UQIBSx3pBppIK4xYzzuyYzpMFagurOdajfXy?=
 =?us-ascii?Q?PKhw8UpTLzghBsk0kyFYicX6zzqgZwZZjWA3FZuiYbj0wIAoPykA71kv4kdP?=
 =?us-ascii?Q?fXaHzlKrWXzQ2wIFUKsAYC9G/1V/ku1TdR8ISNXJJ/MM4V+Ajy4GeTgeqlq4?=
 =?us-ascii?Q?DDa5YhTS04JCwc+wWAqLl6ZZNrj6FydABwxIEUTXlGbXFaSTcCd7+ON5CYBV?=
 =?us-ascii?Q?5XP68TJCnFnsPFPyZXsKwijIZrs8HBOEFPYfvc8VtcD89n2Y+7V5qeDSnNi0?=
 =?us-ascii?Q?mlW8DgaL81tdH9Hn78v1rYH5lCx6/TBZgJ1H+9R9Q/PJ32ZohqbaMd3oDYD/?=
 =?us-ascii?Q?eISPFGf9jkcAThgUrg1EgzV1FPLoz3Hn92dVZTjyqvSzKTs4OwBWfHb0yXty?=
 =?us-ascii?Q?sehl6bI9u5CMLpSRf3nTRKj7A9FJ8UCdtlicgCW7UoggWTtRt4rTTyihz6zT?=
 =?us-ascii?Q?TZ75ac+oI5yD5fLlhk9eBYlQZ5HOYW0RvgWvFBoLNDWBI5j3qoIvYiwVAI8M?=
 =?us-ascii?Q?rnwLQhaQACAK+Pt5JGlBuZYpGnSrH+ZO4KjyK3EHIoJg9YQwDMtAd3RSZtKr?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78023ec1-06d1-45dc-daad-08dc0bd1ea14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:32:18.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcQxF1DYDcLEy6VmAkpWQUcaknbpQ4B7Zai+qWD4pKNpqk8esZUZ77HzXt+jZgJHdV8n0tWJ0Rwa+Ecd7jOEIWLQIhiNWfL/qvCS0bq5Lz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5123

On Tue, Jan 02, 2024 at 05:09:55PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Tue, Dec 26, 2023 at 02:05:35AM -0500, Gregory Price wrote:
> >> On Wed, Dec 27, 2023 at 04:39:29PM +0800, Huang, Ying wrote:
> >> > Gregory Price <gourry.memverge@gmail.com> writes:
> >> > 
> >> > > +	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
> >> > > +
> >> > > +	*flags = *mode_arg & MPOL_MODE_FLAGS;
> >> > > +	*mode_arg = mode;
> >> > 
> >> > It appears that it's unnecessary to introduce a local variable to split
> >> > mode/flags.  Just reuse the original code?
> >> > 
> >
> > Revisiting during fixes: Note the change from int to short.
> >
> > I chose to make this explicit because validate_mpol_flags takes a short.
> >
> > I'm fairly sure changing it back throws a truncation warning.
> 
> Why something like below doesn't work?
> 
> int sanitize_mpol_flags(int *mode, unsigned short *flags)
> {
>         *flags = *mode & MPOL_MODE_FLAGS;
>         *mode &= ~MPOL_MODE_FLAGS;
> 
>         return validate_mpol_flags(*mode, flags);
> }

was concerned with silent truncation of (*mode) (int) to short.

*shrug* happy to change it

~Gregory

