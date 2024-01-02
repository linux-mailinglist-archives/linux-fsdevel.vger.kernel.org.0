Return-Path: <linux-fsdevel+bounces-7140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E12822292
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 21:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C02D1C22A89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18A1641F;
	Tue,  2 Jan 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="mTHMD9/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4B16408;
	Tue,  2 Jan 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzm+qAZPIPbJFyrM/bFLheJhatu11JLeWvKZ7hRJ4VTxI8C/eIQ3Nei3fjFDMJ1EWoxvcV71vy7JYuSxSpbfx4WHuQISopVg6V18t6Kp7XFYQQS/fS0MH4hdfNLixxETnzKqqZv0uEvBWaZN8E7G8rYLd9H2WcObMWmAL8b4MoZmzR0QrSbiDJOIR3KBtUQ6Dv1PvN+BUcMytNph9LQGL3mjvJoirVrdhCxjF34yIUGCavIUgjlc5Xf/o+v/9RZVkNnd1a1iShDIYuxDRJhTjJe4ptdwmu6BHM5I283ICq66hPveFiQD82tod86xpCRBMVfPNr2c5gWkPM6bpS1VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKekLbY9ar3qm9zcUFARVS5GPrln+ELFs3VCR0OZix0=;
 b=XBbIUKZ2jBYVdcHpi31WNSN5NR2lNWfeZqzJsaiSa2yUQwn6WuiNlqK3Qd0FqTCE5NpLAtoliixntZde2gAoazI4NU7iMEIn578lBnWIdIzr53FzUgijuasRFYKg5zVDGi8JmIWzw3C0bMfg0Wf7ox238vgIPgxN3Ay5O8JcqhPiyZiYwERWcmFU5TXHwpoALtgazQWkZ0EuDVU6vMMWo2c0MO51RjFzq8l74uNLVtPxP5ou+M74IoHf8HWunSCSnZ9zYXsZWsOD22ummYlSdB28semPk5cBqkomYYOwIjmeBKDpL5A5XP+Sq1NRt4I2n6YbjQOgF5fBUYr15Cq9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKekLbY9ar3qm9zcUFARVS5GPrln+ELFs3VCR0OZix0=;
 b=mTHMD9/dWvBUFLDtwZF3oSs8Wo9MiOzD774r2yq2KZfWcvgtD1a2/5YODIz4XoNiHMGNGigcLrHbOTZKVCjpSk8ypbz7gVvthO90EgDLNKKP6joTaEnZtY50nntykDjRE1l34p7NDF2UuSPynij3bA/FVOAkN+nhzOplCcxPmGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5097.namprd17.prod.outlook.com (2603:10b6:303:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 20:30:45 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:30:45 +0000
Date: Tue, 2 Jan 2024 15:30:36 -0500
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
Message-ID: <ZZRybDPSoLme8Ldh@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
 <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: bff1201f-a7d1-4eff-c3b6-08dc0bd1b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KW94kQAaxztRfqaezpfhTN8+r0/fFRUlK5MWDFki0SQ7qKR/VFVcI/wDPCzJmnYrlYrwae2Kr8lWonPfPrIDDVp4CZd2D6yt4gCHfPRGLbdb1VOF3OEuq91awv15SsScF6NLtdz4LELDZE3eHVazF/btHKpIlcQ0GJekuAm+oGBDNyzYhFWeADklv3E5/JQAwNH6lXp7Hf1VlV+iB7SQrJuayOFH4ygEY7jrTxrWeqNxWuAlyhd2+B+WqlrApKbHel8nNm8Xy1UtxoB7MwEpSxIv+0Cd59WtAYJb9diIAUSHKPn4Uo1t4pnT0QprOxG1RXspsrXPtsPIJ7szrCEmRSzvvm0tihtb1ZtP7BAyzigjhzvglGcb2FNn/Jg24YKbJFl0pU2IwC48EqAAfYt7NUbksWqeJ0dIdgA4iOGjMs222h138eT6KyqqOUmwQ/r65sz4w8lDbFQvJdG+syWKH5ASlU/yuapjEzWIFVDFuq68rRmt4vrPQfM4oGWIB+AxF/GYQ91B5w2yru91O8GBzryrlxJ986NGqE+6+N16A4IDQy5uDVWRxgGmFwLA+5ci2dswXHYxmb0AQpffSAGKgdOA1lFvd+35B7lchcc3mVlIeuwYlHHeMeiHo50LggKv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39840400004)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(36756003)(86362001)(2616005)(26005)(6506007)(6512007)(6666004)(54906003)(4326008)(8676002)(6486002)(478600001)(8936002)(316002)(83380400001)(66899024)(66476007)(66946007)(66556008)(6916009)(44832011)(41300700001)(5660300002)(7406005)(7416002)(2906002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G72LK6C5nAFz/2vRSXkuPlDEy3Ou93xXpYl11aAPVAhUOuEx4LV2eWpfe+Mu?=
 =?us-ascii?Q?pmMgW7/PCgbGxAhPeWuUbhI7DDGfzh/OQfNgnwj3M+WbUsGAQmgj0BP7ILIM?=
 =?us-ascii?Q?kzd+OtiEb6WACYRCYlOm/jDml5kgVaIU9VKlx9DaCQqWMHeSsm5+O16TkLSR?=
 =?us-ascii?Q?QaY9yZyEWJWT22n+aQnpwZZ9yUdTBHpo3SZg8yrlg+MuldTL1HFdAU+eGmNT?=
 =?us-ascii?Q?cut2wTze39qkJIwThnSb6MPeFuxlYmAhUgLPel7OfLGwpidzgDTqMXKPOklH?=
 =?us-ascii?Q?p5cT2hHK0c18v+NXzRUx4EtpfAtcq4RtUgKJmi0pF+nz5TfYJ6CUYTpL8VFz?=
 =?us-ascii?Q?AqFr9fjNSCiVxBo+Hc65M/lvaQ98PGG4Z0psEUsLyDy7q+vIonx+/eFLwder?=
 =?us-ascii?Q?p00ZRQ5oMjbHx3Y7/7H7E5xAVpsS4u85AOiZqec+nqFNm/LLXfDgrW1mBC/s?=
 =?us-ascii?Q?k/b/nstbY87ALzkboNnIHo6i643kwWccQvWd8qZkzWNVaJpXxnUNinSq0vBP?=
 =?us-ascii?Q?Xfwx4juzOlKXFXZk6RB1+OYnbq17Cw4lpbiNdbKbOTo9xVWEYV5bKabS4DYc?=
 =?us-ascii?Q?65xAdYSjOtTTDRni6kZ0LVVSAevXZPbUK4KWPeEUGO72DFlDZ/pgm8yjcqB6?=
 =?us-ascii?Q?YS4/qnqHyVn5aQ0Oz2oaGbX2M27mO6F9ODX+iWldHADLraz6ssX+/4I7qXtK?=
 =?us-ascii?Q?BqcKYT2x6v951ukMgzosZ+wQk8FMvMzl8tiUmvWnZLBTnpYmv3BaltdjDiG7?=
 =?us-ascii?Q?cT6K0736djmhN/1YXjSdf2oREA2XR45RNFSt7AVI49C7ZYLF4zux7c9n62uF?=
 =?us-ascii?Q?5AtFu9fT4boBo85P+60i9mr6XeaECfEfPFKzc14/Jqy5gOqsd6QOU7q57MXe?=
 =?us-ascii?Q?Y7j4q3chks8rMQErWaV1yLDVoA2J0MWN3RyDletY3jyUDfrWuJA/6XBI1yKl?=
 =?us-ascii?Q?7VYS7X9+N7X4VdxvNAEp2gBqwDw2rF7gAALZK05iVCabNF/sN4/2JuS5eZ2d?=
 =?us-ascii?Q?7GSzTGUChrlkqCXCMd1h5FbUvfS9nCn1Gjwx32WsXu3Ro7+MBFiU7Qx/3nbl?=
 =?us-ascii?Q?ZwHx6+bBT864s7UaEr1xchlq4+/YVEEXNz0f8ODqkggW0k9TKO3LYdcVMI0G?=
 =?us-ascii?Q?sUmq2Pb9jna8TEehkpUuqGsP4wpHptFy+hTFo7NzvHfas0lMTuJOtOganuzi?=
 =?us-ascii?Q?oF6m6/EkcjSGOITli7t/NLsX7NAq0xPw09nKq1ampnI//cGrImVJJ5FrRlxt?=
 =?us-ascii?Q?66y/nif9BQLJhzwm8yU143W7WlgceG8ZeQCX7AmqhBzszh+GMxn7qUPpGB0p?=
 =?us-ascii?Q?Lgchh/ouvfNhGCHT2ioSIAZem9ju7/62M0mn7Eyk428mRupfJmlMVi6HJbrv?=
 =?us-ascii?Q?uYDOo34U9UA/8WMnhTsZiP3kTRJs9xULRCpMlQ6ku0n7cToU2oRkUjDTyzUm?=
 =?us-ascii?Q?guXTCZphrtDgRL5lfCwBXgd7u6xg6EOIRsGeB9h30juS5kqlO1O2eI5s0VZb?=
 =?us-ascii?Q?X/sXV7zxGEJoNCJFGRv/gcbfo1KFnbTvUfO+eRx6/MPea7aoretHpr5FKopk?=
 =?us-ascii?Q?/JhJcvkqAM3phK0cdjZo+AIsQzS9n770M2wn2dXCk8hFiYFE+E3UzjQAbT1G?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff1201f-a7d1-4eff-c3b6-08dc0bd1b248
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:30:44.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odvArhBh75ZY2duUMbLImJYIfXZtR1hkH6WI/j4rQi6mCwmDufbluL0V9zyEssDasb3MUKmXJBxl0TSNbTQGIMZ/0EVdtWRsYn7T1I+nRjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5097

On Tue, Jan 02, 2024 at 04:42:42PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Wed, Dec 27, 2023 at 04:32:37PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry.memverge@gmail.com> writes:
> >> 
> >> > +static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> >> > +{
> >> > +	nodemask_t nodemask = pol->nodes;
> >> > +	unsigned int target, weight_total = 0;
> >> > +	int nid;
> >> > +	unsigned char weights[MAX_NUMNODES];
> >> 
> >> MAX_NUMNODSE could be as large as 1024.  1KB stack space may be too
> >> large?
> >> 
> >
> > I've been struggling with a good solution to this.  We need a local copy
> > of weights to prevent weights from changing out from under us during
> > allocation (which may take quite some time), but it seemed unwise to
> > to allocate 1KB heap in this particular path.
> >
> > Is my concern unfounded?  If so, I can go ahead and add the allocation
> > code.
> 
> Please take a look at NODEMASK_ALLOC().
>

This is not my question. NODEMASK_ALLOC calls kmalloc/kfree. 

Some of the allocations on the stack can be replaced with a scratch
allocation, that's no big deal.

I'm specifically concerned about:
	weighted_interleave_nid
	alloc_pages_bulk_array_weighted_interleave

I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
contexts. If kmalloc/kfree is safe fine, this problem is trivial.

If not, there is no good solution to this without pre-allocating a
scratch area per-task.

> >> I don't think barrier() is needed to wait for memory operations for
> >> stack.  It's usually used for cross-processor memory order.
> >>
> >
> > This is present in the old interleave code.  To the best of my
> > understanding, the concern is for mempolicy->nodemask rebinding that can
> > occur when cgroups.cpusets.mems_allowed changes.
> >
> > so we can't iterate over (mempolicy->nodemask), we have to take a local
> > copy.
> >
> > My *best* understanding of the barrier here is to prevent the compiler
> > from reordering operations such that it attempts to optimize out the
> > local copy (or do lazy-fetch).
> >
> > It is present in the original interleave code, so I pulled it forward to
> > this, but I have not tested whether this is a bit paranoid or not.
> >
> > from `interleave_nid`:
> >
> >  /*
> >   * The barrier will stabilize the nodemask in a register or on
> >   * the stack so that it will stop changing under the code.
> >   *
> >   * Between first_node() and next_node(), pol->nodes could be changed
> >   * by other threads. So we put pol->nodes in a local stack.
> >   */
> >  barrier();
> 
> Got it.  This is kind of READ_ONCE() for nodemask.  To avoid to add
> comments all over the place.  Can we implement a wrapper for it?  For
> example, memcpy_once().  __read_once_size() in
> tools/include/linux/compiler.h can be used as reference.
> 
> Because node_weights[] may be changed simultaneously too.  We may need
> to consider similar issue for it too.  But RCU seems more appropriate
> for node_weights[].
> 

Weights are collected individually onto the stack because we have to sum
them up before we actually apply the weights.

A stale weight is not offensive.  RCU is not needed and doesn't help.

The reason the barrier is needed is not weights, it's the nodemask.

So you basically just want to replace barrier() with this and drop the
copy/pasted comments:

static void read_once_policy_nodemask(struct mempolicy *pol, nodemask_t *mask)
{
        /*
         * The barrier will stabilize the nodemask in a register or on
         * the stack so that it will stop changing under the code.
         *
         * Between first_node() and next_node(), pol->nodes could be changed
         * by other threads. So we put pol->nodes in a local stack.
         */
        barrier();
        __builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));
        barrier();
}

- nodemask_t nodemask = pol->nodemask
- barrier()
+ nodemask_t nodemask;
+ read_once_policy_nodemask(pol, &nodemask)

Is that right?

~Gregory

