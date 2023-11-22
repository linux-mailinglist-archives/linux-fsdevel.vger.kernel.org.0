Return-Path: <linux-fsdevel+bounces-3492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F57F535D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 23:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32B281690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076D208BE;
	Wed, 22 Nov 2023 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="wQXeFXEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34810C;
	Wed, 22 Nov 2023 14:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg9GaFx7pTsEd+PXJ937GL9JOFCOHLvRxbUSEB6QXM+RQH1MNLvNtdudktk4bfA4Xg1/oqARhrGjewl93W5t5CU/J2Z+WTcAmzx8Tytfj4n9940+QoAS9ineasq8NGbKZcgF+G4JDcQyoolyVhWFkRUgOfNqAfqdhnZo7j6hu3FfXW/pKyNzuPHWpO2OtETNLHVv92c5PbWfz6Sycjo6JevL3sAqKxoiUjE4DgxVDRoz1PvnkbrXhVbEDH7LMbUCxFWHjxclYWil1gl+P12IL21DMwwLInK9fHe/p1d3AaGL5Tj4IeoEUoD9OLNsmCRR9Avv56MSUwX06oUdDghVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLbawjEst2sNB0SgW6v0JahIf9wUcRrGUHSs+UZJzVw=;
 b=XnhjzB6k1HwZwIk+Bwha7Lzww19mmx4kOyJpZA7ecfNSL6OyBvhLROurByOed1Blc0nTrOp0Q3eP71wpoIw64AO0gxmR1wS+sR1bQwmvLMtulGxxmeSnkqXNyAmB4pEwVE+otMRrgiqhMae9f1osacD6FlvOXHLwcQ0YAU4ucQGSCNGaoEG0oMyJ8zBSrKu+vwWkoVowmXsIegwRZYHREiBRJWoQdyFO7jH5/MOzu314mlLxDY1XEJdyeouFMuH+E2CQAXtLi3He2z5VWD2M1fmqB2uVikVa7+oRF78ZAUOiQyzBa+yL7KKiC6losoLa1BAuKEcDX2YisKTOPaUEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLbawjEst2sNB0SgW6v0JahIf9wUcRrGUHSs+UZJzVw=;
 b=wQXeFXEA9+SF3PDY5jfJTTbffbcl/R04FpMtSar+tMpZE8g0kCP3Vdhz/vzhnUEcLxZTNcOalwehAml8BubBnAG6p1Kpjl6U58Gi3sqyoy/mZ1/EoMLAvq94MqbLtGh2VjqbEtwxJ/Gr7GkcDU8Sy+mktGhyPyE9lB4FbliDKzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6944.namprd17.prod.outlook.com (2603:10b6:8:155::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 22:24:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 22:24:23 +0000
Date: Wed, 22 Nov 2023 17:24:10 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-ID: <ZV5/ilfUoqC2PW0D@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: dceb0dca-2163-4cd2-9ac2-08dbeba9c772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rx7ufuPfgIsbUTYhEgnAJkgRvQCMH256ICHUeGsndJGWB/5QDpd9g5nM8sIqMX8CkxlGpt7NjbnKQUNLaCkS32F62RsaqhiAHmAQewDFH+DUUwq/ssPGIdLtnLs9YBIOy5gswxb+tHI2y01qdbzh8IDunsK3dCj42c7u892AB0Ms9X0KhUE5EPspJ6PpU8cP7ZrCS3gximx0/9BgOmjYEQPqs4pDSExWR+y0x7UYyLaFMRm9cHOjSqTnIHQe/kh+ZyCvGRiSr9rXs+RaJ6tDDbXLtaqo342nOWFMfv9Nke1DfaJ6FWXA/OJRj6MEYnVhgGsrUg7aK3/0em0HrWimQRoWQ2ESsq27W1qvuzlOhY8eUyYGqltwIaKvWjAgTmsI2WMDXJ6EYU7TcDTK476mzckZgmA5nAwscjybbplUTuGecgHBzhXqrFy6Y1GpoFEOOFYH3AkUJxWEQqEt+dsmFAXdzoeP0sT+IvOXMV2v18f8KjNkhzBPCi8KSWK4ZUS9BqnucSd3QD5tfdLHW8817ioCfTML63GpnzFfMl5UL8UdNG/0yugNu1bgzq0/pJGz/DBoX0tXVEeZRWVDQOEBw1+vEC4w+AKQaH5mW7eodaEuqsBwiD8X8uu3VTMw4YjY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(396003)(136003)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(36756003)(478600001)(83380400001)(66556008)(66476007)(66899024)(66946007)(38100700002)(6916009)(316002)(2616005)(6512007)(6486002)(41300700001)(8936002)(5660300002)(86362001)(44832011)(6666004)(6506007)(4326008)(8676002)(7416002)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgvkHpW2Bmw1HZlUX7USn4MyZlq/C+S4Xutun8nVRtenYxdjSsQoatGUuPQc?=
 =?us-ascii?Q?xSjs4jUlu+YLo3L6i0/0fzRad3REuD/TaMrU50trhzEP4MHVmfts1xPQF0lh?=
 =?us-ascii?Q?SpUgGnJ3y+CVH1Kt7DkQq+KR+HzyL+BjCUQO6oZERE8wLw5VQcT3gFVtwmAp?=
 =?us-ascii?Q?ADJrH2HTFjbwoN6i7HmrpJPnq14fLv5AVW46M1aQtNrwUeJrnoKjZiERRQWk?=
 =?us-ascii?Q?jpJJ952qdfTs/r5TAxkCcmF349nsafzzB1e9D2HzGog8xIG89rAEsAxlPH1j?=
 =?us-ascii?Q?xO+sr4WfptXozaCMutWWUKYGeJuEBSB2DDevWB8FFJZ9NIr1t3Ig3aRl9DDl?=
 =?us-ascii?Q?m2TrYmrxyUzeXN8o4rtGn4PKHOC0bz1KEgh3n/EG5mzSi3HJoIhFJSCuliOl?=
 =?us-ascii?Q?tGsM3umXx78zmzvWlATKzBRPsoEGUpR888ndJ+llBs0UImEtpR+vdPkdoZ0s?=
 =?us-ascii?Q?4o0iAbje+SSis6PbLKb8Rjy2n85VLEQ0GVnfKLsJ3pYb6JFUHo7Rtui/SK2x?=
 =?us-ascii?Q?R+jrMx1wc4FQcjfksQapqit1D+3fPefGjYn8eXsIBZSxfKinvfhHIYIFmeQI?=
 =?us-ascii?Q?c/Txq6wnj1IEV6Ryou01uBs0VRZ8LcO+j8jGOOULp3EsVRjW+jBnUfLpr/95?=
 =?us-ascii?Q?WAu5+eY/JYZI846cN6/MeenjXLx9Vk5Py8RAhGFOX0J0/+p9TkQ8hK8Fgg2N?=
 =?us-ascii?Q?g46IfgbmIQO5GSmEUpRu2pcuCyfFXR6zdV1dgU4jPMY+O3nZAWsW3Me5qRya?=
 =?us-ascii?Q?8ZjlNN8qKxCTCfsvIJmIXoCnvRdZAPlnVg+ouGLg4QCW+oeMa8iysM4CZFzO?=
 =?us-ascii?Q?jmPlozN6dk1rGpTfjQft4zw6kxm0tXxwOVwnYhmg+9nPnQPCn6K+uEnh6+MO?=
 =?us-ascii?Q?/qx3+TZS55syRC0mpEN8P4qnhFBkITn9wZ2cFCXSGzEVtoQEtk86s42CyJ7m?=
 =?us-ascii?Q?XO6eixodj20N9VZRLUAVLv0l8MJUJ34xFycJodKjwwCldW720nCPwvTZbif0?=
 =?us-ascii?Q?YJOQOFo1qyqBrekQRlFR698U9H3qY+m951X/hD/ElOhfXbG8UeQnjWfNvGWQ?=
 =?us-ascii?Q?MLm2I/Zb/BQJZPnqCTljzKKvjfEe5yEx5lCHBTbDQHgUkjaRJKXoJbh26WmI?=
 =?us-ascii?Q?ysgyEOxC3+3RZvjCLDf+63Dzy7J7cAPmwTRBw9+ZSwAMGoiJUrkdGcb5zLbz?=
 =?us-ascii?Q?jU7EEaHv8D4n+WZPZZnclUI4J/xsBIN2UZIgM3CkbGX0uSUn2iYya9358YK7?=
 =?us-ascii?Q?6nArobCvTD0xAqH3pgWVJvEqAyP7j44Srl3QBwNkENP4EArlR8yGV0t/GT27?=
 =?us-ascii?Q?iRt8gUTW3yfHExJgqkEhOpmjXJALt3lUnOqvgZZCQGd6sAlqj5Ga1GnY9rpR?=
 =?us-ascii?Q?2mLa6SBq+WQvyEblilR0xl+PeAVhdqhUXuxaVzbN8ctLW8WY/DqB89mKIsvb?=
 =?us-ascii?Q?3L00plnaiIMjuWpjr1AKyzEACv0mW4yQAcBmhGowoonIIe72XHWHjpE1VQyr?=
 =?us-ascii?Q?gSkPJ65/nuBEnCm/tpBY1Szl0e5Xc24Ib46g4/PZOWiGEl5MCJGXZ7m+Wmns?=
 =?us-ascii?Q?M1XCqEjV9S31+c1ZqgeqEVrlzxv05OGbSSbDRHarzWbxkwpKRBZD45FS7QkI?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dceb0dca-2163-4cd2-9ac2-08dbeba9c772
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:24:23.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKctZiMujSVdy7TnMypwI38sv/bTXXCvJSyL+HuVGT0xNuODLP5YbsUNgRPo5K0Ml76z4/KEJpS7ZV3nxjOxdf5Oni93i3YaxeMp2gBnDHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6944

On Wed, Nov 22, 2023 at 01:33:48PM -0800, Andrew Morton wrote:
> On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > The patch set changes task->mempolicy to be modifiable by tasks other
> > than just current.
> > 
> > The ultimate goal is to make mempolicy more flexible and extensible,
> > such as adding interleave weights (which may need to change at runtime
> > due to hotplug events).  Making mempolicy externally modifiable allows
> > for userland daemons to make runtime performance adjustments to running
> > tasks without that software needing to be made numa-aware.
> 
> Please add to this [0/N] a full description of the security aspect: who
> can modify whose mempolicy, along with a full description of the
> reasoning behind this decision.
> 

Will do. For the sake of v0 for now:

1) the task itself (task == current)
   for obvious reasons: it already can

2) from external interfaces: CAP_SYS_NICE

There might be an argument for CAP_SYS_ADMIN, but CAP_SYS_NICE has
access to scheduling controls, and mbind uses CAP_SYS_NICE to validate
whether shared pages can be migrated.  The same is true of migrate_pages
and other memory management controls.  For this reason, I chose to gate
the task syscalls behind CAP_SYS_NICE unless (task == current).

I'm by no means an expert in this area, so slap away if i'm egregiously
wrong here.

I will add additional security context to v2 as to what impacts changing
a mempolicy can have at runtime.  This will mostly be related to cpusets
implications, as mempolicy itself is not a "constraining" interface in
terms of security. For example: one can mbind/interleave/whatever a set
of nodes, and then use migrate_pages or move_pages to violate that
mempolicy. This is explicitly allowed and discussed in the
implementation of the existing syscalls / libnuma.

However, if cpusets must be respected.

This is why i refactored out replace_mempolicy and reused it, because
this enforcement is already handled by checking task->mems_allowed.

> > 3. Add external interfaces which allow for a task mempolicy to be
> >    modified by another task.  This is implemented in 4 syscalls
> >    and a procfs interface:
> >         sys_set_task_mempolicy
> >         sys_get_task_mempolicy
> >         sys_set_task_mempolicy_home_node
> >         sys_task_mbind
> >         /proc/[pid]/mempolicy
> 
> Why is the procfs interface needed?  Doesn't it simply duplicate the
> syscall interface?  Please update [0/N] with a description of this
> decision.
> 

Honestly I wrote the procfs interface first, and then came back around
to just implement the syscalls.  mbind is not friendly to being procfs'd
so if the preference is to have only one, not both, then it should
probably be the syscalls.

That said, when I introduce weighted interleave on top of this, having a
simple procfs interface to those weights would be valuable, so I
imagined something like `proc/mempolicy` to determine if interleave was
being used and something like `proc/mpol_interleave_weights` for a clean
interface to update weights.

However, in the same breath, I have a prior RFC with set/get_mempolicy2
which could probably take all future mempolicy extensions and wrap them
up into one pair of syscalls, instead of us ending up with 200 more
sys_mempolicy_whatever as memory attached fabrics become more common.

So... yeah... the is one area I think the community very much needs to
comment:  set/get_mempolicy2, many new mempolicy syscalls, procfs? All
of the above?

The procfs route provides a command-line user a nice, clean way to
update policies without the need for an additional tool, but if there is
an "all or nothing" preference on mempolicy controls - then procfs is
probably not the way to go.

This RFC at least shows there are options. I very much welcome input in
this particular area.

> > The new syscalls are the same as their current-task counterparts,
> > except that they take a pid as an argument.  The exception is
> > task_mbind, which required a new struct due to the number of args.
> > 
> > The /proc/pid/mempolicy re-uses the interface mpol_parse_str format
> > to enable get/set of mempolicy via procsfs.
> > 
> > mpol_parse_str format:
> >             <mode>[=<flags>][:<nodelist>]
> > 
> > Example usage:
> > 
> > echo "default" > /proc/pid/mempolicy
> > echo "prefer=relative:0" > /proc/pid/mempolicy
> > echo "interleave:0-3" > /proc/pid/mempolicy
> 
> What do we get when we read from this?  Please add to changelog.
>
> Also a description of the permissions for this procfs file, along with
> reasoning.  If it has global readability, and there's something
> interesting in there, let's show that the security implications have
> been fully considered.
> 

Ah, should have included that.  Will add.  For the sake of v0:

Current permissions: (S_IRUSR|S_IWUSR)
Which presumes the owner and obviosly root.  Tried parity the syscall.

the total set of (current) policy outputs are:

"default"
"local"
"prefer:node"
"prefer=static:node"
"prefer=relative:node"
"prefer (many):nodelist"
"prefer (many)=static:nodelist"
"prefer (many)=relative:nodelist"
"interleave:nodelist"
"interleave=static:nodelist"
"interleave=relative:nodelist"
"bind:nodelist"
"bind=static:nodelist"
"bind=relative:nodelist"

There doesn't seem to be much of a security implication here, at least
not anything that can't already be gleaned via something like numa_maps,
but it does provide *some* level of memory placement imformation, so
it's still probably best gated behind owner/root.

That said, changing this policy may not imply it is actually used,
because individual VMA policies can override this policy. So it really
doesn't provide much info at all.

Something I just noticed: mpol_parse_str does not presently support the
numa balancing flag, so that would have to be added to achieve parity
with the set_mempolicy syscall.

> > Changing the mempolicy does not induce memory migrations via the
> > procfs interface (which is the exact same behavior as set_mempolicy).
> > 
>

Thanks for taking a quick look!
~Gregory

