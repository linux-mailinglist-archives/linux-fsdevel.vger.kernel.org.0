Return-Path: <linux-fsdevel+bounces-7271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E95823784
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D581F25F26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB731DA4A;
	Wed,  3 Jan 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="e3Ehpu7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822C1DA26;
	Wed,  3 Jan 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZplnyw39cO6N2JI3bs6ssN+a+qrcj6ZqVv3pAqIYHKEyCxJAMaFyP7GGdf1mPdRPMOfe1s2qXBKDti3ePKT7VwzbQvk+eytrLf911ewowhvfWiIOGZvn19wPZ3Ab14z5ZaJSQmByf8bTwtHZX0gvgcKHo/L6SmelzL0z2K084UjMhryr70r7Bn0THatPawMBPPnr7HmKpyyR5GKkmsqlDGZdk7GovbKUjCo5jZyH6d8PvHgP1NDt5AmzF1VqG0h1ZTgWRSs879QRdgjuNSUuUBzT2AHosTfnoilmbgUs09g5NAxqoCKJIvDiXRi2rBkB0XO+S/o0lYv0/dKWo0dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUmLsqKpJn0fpO8Na1oIc12LqjLaT0D/w+jHs2mMXs8=;
 b=Jrv0dvPyPODfpdSd+8OI+TBsl1R8WmcPq6IIjAM1xXX62y2v0exVjsK2nQikEM7cPs4IQB+MW2tCLdeujs1fwftavtne7h62nxEW8pdLvpgBG7Mvj+S0NZY/lnyuDIn0ljcdKnENFLywhiBdJN1EquGJF0/3qx3oW6kDyXFWK/pYyE6Bx0oyfOzG0v8ATl5m7KBFDjDdmq/lDhuzHlXjcnz2KkRm0l5SiP6xy+9o8Wwwn77r/G+ZDnKrlGW2jWtT+Yy81LZF2kJirfdsA0vxEd3JD5f+PcTFOLNjHEqpYxPo4ObWoS+YPH35G/i+kDq7bVi4v/1HVikK4XC6nrgAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUmLsqKpJn0fpO8Na1oIc12LqjLaT0D/w+jHs2mMXs8=;
 b=e3Ehpu7hCp9pH3Y8rfMg1+yu3rCpeHNaXAqZtkcoIPPjDQL8xsNOhpWsj7byrkUqoOnBQX72RFiJcrTQYuEc2lDmBrbA/969KblRPfGX1WNlcJ8ngDwXDiQ8sVoasK7WSuwjfx1x0YbH7LzjkTzyidTTMZFt6FLJfk8R2STyC+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH8PR17MB6786.namprd17.prod.outlook.com (2603:10b6:510:239::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 22:10:09 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 22:10:09 +0000
Date: Wed, 3 Jan 2024 17:09:59 -0500
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
	seungjun.ha@samsung.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v5 02/11] mm/mempolicy: introduce
 MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Message-ID: <ZZXbN4+2nVbE/lRe@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
 <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZRybDPSoLme8Ldh@memverge.com>
 <87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH8PR17MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d55387-bc81-4944-03d3-08dc0ca8bfa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i4Ln7vGNB+9wqk43QPUPtwVM4iIWI9ae/cZZzVwjjmNQubBNAl4Lwps1er6VBLE8bnarz3SovEfejdrcLcpKwI2Sp6LCPXvddPy6tjlWzavSVw6p3PxJOZh3pmjbLVAPv2Yh/z5Yv0TKlUyWTpz0h0riWguZbftJCEiUEnETCdV6mkW6CG6bKm1CHk4sz+Ur49o8TYeKmAh+26GUV4GOaP2gKYIRCY9QU+aFZXpvQjJkFmfbnN4ZnqKnRFss21xLHCyHwtEAPq40AnNJX4QrijMDNzrVrd19u4/XahEjylu2CcozOVfWoUP3Gvevq47ayTGAbyWhBhcGOf9E+CXz3fMVprPonX1y/C09g58iuV1Gt8VDdloWCW63E2azMxq2Q2ieyFZd6HezYXmhm4kLry+FChwqT05EDfVs9fH3T78UQV0ZVEIB9jInMuDTQLAGwT+wSoPvyfLVj8K3EJZSooXYwA5+osVoJm0QC3sxmav1G8+d10xhkLRJ7ddUprcCWAJzamx6zCg6TQdiPQHodEI1PO50o8ZGvKGqxquZpF3pPexVMTvGMk74O61+DkIjwpYteFyfa0gzzShDoR8gapKXVGxOgswmyUleFf9kO9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39840400004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(478600001)(2616005)(6512007)(8936002)(8676002)(44832011)(6916009)(2906002)(41300700001)(66946007)(66556008)(7416002)(6486002)(6666004)(54906003)(7406005)(5660300002)(6506007)(66476007)(4326008)(316002)(86362001)(36756003)(38100700002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zL8jtbJxVZBzaUDntqQj2TQ1mCTsdZoeTkdzEoLdP2cxLsPFcZBb2OfWDkqC?=
 =?us-ascii?Q?/5dsoztCCSn1q+YMlHbf70cGFMa1ZCjVi8AIhwxnULDKcQEMAQfJE7sj4ky4?=
 =?us-ascii?Q?NDM7pP99PDMetyfXbDr540lXh1xiD5HJtDc6CVS/0xl0ApmDOXh6mmHdSJN8?=
 =?us-ascii?Q?UWz+PjTyJgY+ooQAw30sXbRC5JzRhR3soShXavVTbAoPBiupbp0lRzvso0pe?=
 =?us-ascii?Q?7QOOH/eaptYoM2mV+oeebcNAw9WHXOQ7QgVBotb0eOHPKDr939beomYGAafN?=
 =?us-ascii?Q?93+PEGBQhFvEsi/IRECgV9+tPe4h9kyNMOWAq7viKXp7XF0aIO9n+fuCzU/f?=
 =?us-ascii?Q?WYOlfOlldfNixiqfvoixhbmI54MAfN9x8QGl38jPmvNultcSfDL54YVnbbPt?=
 =?us-ascii?Q?36henJSa0ERytLcdT0+apZD5wdMTfN0XNx5zz8aILmP7fIsWbwW2a4PkEVjL?=
 =?us-ascii?Q?X2TneNHwSB9+L6QKTXktb9B1Cx7vrwiorMZyXLb/CSDmiWPbD3V1y98Gfof5?=
 =?us-ascii?Q?mNM9XYRyi3ERviBAz9DH40r2mXIgxkEhNMYHESBS3Q0WDjxgUptAu/0SQ32x?=
 =?us-ascii?Q?030lyJ05VhreccplCIKZWX3GJ1LlRBsfbtsb77PnAbN7MnnEIAdiR/CGhWk7?=
 =?us-ascii?Q?minXJamTDGIefru5c6dSy3CdxRp+7fKUB5diGB/tAy491MvRNIn5Rr97Lyes?=
 =?us-ascii?Q?tOYBp4r4ePhKw6gZ1l8qZ3dbzi43yTDnoINdLF5bO5uwsRrPRCzyZJwt2F1e?=
 =?us-ascii?Q?vRCuYc6bvd+vLrgZIz6o+b5h7KIExKUQNsg79QF/rcIEjc7e/egU00tkZjXG?=
 =?us-ascii?Q?tL+NLT0naJlswUjYlLIRALLr91vqAEUn0FYDn8UjCSiroTXyNkdqCyh1sVtv?=
 =?us-ascii?Q?ZfoHIAaQ67MzImNpyS4nmkTHMudpaZVZIvU+jIGSD1LHi8lGBS2HsK9NS7TV?=
 =?us-ascii?Q?yJZnT/vSCtcoJL/ST4+l29RUZViveIDY0h0CPmh+thycQCAdaS76ay98p9FN?=
 =?us-ascii?Q?2j3K2Kb7ny9m1e7WY5VhZ8tf//gj0d3eWJE1PebkhYJoi8d2mSNdW7BRNwr/?=
 =?us-ascii?Q?1Z6eHOSyfo5/Iw8F3yzG79RfCWUD9JcUNIJFyOVpYPtJDIARUQkKkAkOfAhS?=
 =?us-ascii?Q?y/pbjsNqKb4ZB4/yYfFwx4GnQUoqMS6niZ4ZKPUzUBbZ7pNT6Pwh2KPC33YQ?=
 =?us-ascii?Q?HuCYVNijoLoAZDqaUHDKFu/FhxhE2BfR/TwpIWw7GPetglzZDe82CqiMuOCg?=
 =?us-ascii?Q?NM4PcycfF4WLwfdQZeUH5vRG1BlhZq1WEpDb07HrFySeJ7W14n2rOiEhHh8P?=
 =?us-ascii?Q?9eCgN48DBXLF5vjqNfxlufBZPeKemPEXj6GEU+n4GlnDaI/FOMO3qYpFTvv1?=
 =?us-ascii?Q?thHcsPFa7dYcwT13H+8MfLH0+gZ+OyAZvh8egVNHJOfJRISaXRT/hSt+eLd+?=
 =?us-ascii?Q?CXSufqxswfoGNBM5Mr8sM1Xn4l7LEVJMkqe+TlrPXeatvaShnazvpa6txLXM?=
 =?us-ascii?Q?dN8J8qNgpAxvGimUJSw9xDe5bcwHeA2Ci6NbPIzZX+HOXzxEMbhcAtp21b3I?=
 =?us-ascii?Q?xCxWyJ8a144zx+l7XKYxDZBftObAnH6E8b77l5reNu+XJY91huQnX69gmEU8?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d55387-bc81-4944-03d3-08dc0ca8bfa9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:10:09.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZIVSZ7MvjqjEAL9nQR+KKWsRkzBVgMD4TZU01L1QQJpFP2aNz8PcaV1PU/sY/n506Zzb/sac4nncr/vGn/3uzIBWGUA6TYrhUh49Vc+yGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR17MB6786

On Wed, Jan 03, 2024 at 01:46:56PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> > I'm specifically concerned about:
> > 	weighted_interleave_nid
> > 	alloc_pages_bulk_array_weighted_interleave
> >
> > I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
> > contexts. If kmalloc/kfree is safe fine, this problem is trivial.
> >
> > If not, there is no good solution to this without pre-allocating a
> > scratch area per-task.
> 
> You need to audit whether it's safe for all callers.  I guess that you
> need to allocate pages after calling, so you can use the same GFP flags
> here.
> 

After picking away i realized that this code is usually going to get
called during page fault handling - duh.  So kmalloc is almost never
safe (or can fail), and we it's nasty to try to handle those errors.

Instead of doing that, I simply chose to implement the scratch space
in the mempolicy structure

mempolicy->wil.scratch_weights[MAX_NUMNODES].

We eat an extra 1kb of memory in the mempolicy, but it gives us a safe
scratch space we can use any time the task is allocating memory, and
prevents the need for any fancy error handling.  That seems like a
perfectly reasonable tradeoff.

> >
> > Weights are collected individually onto the stack because we have to sum
> > them up before we actually apply the weights.
> >
> > A stale weight is not offensive.  RCU is not needed and doesn't help.
> 
> When you copy weights from iw_table[] to stack, it's possible for
> compiler to cache its contents in register, or merge, split the memory
> operations.  At the same time, iw_table[] may be changed simultaneously
> via sysfs interface.  So, we need a mechanism to guarantee that we read
> the latest contents consistently.
> 

Fair enough, I went ahead and added a similar interaction.

~Gregoryg

