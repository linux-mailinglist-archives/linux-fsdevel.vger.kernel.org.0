Return-Path: <linux-fsdevel+bounces-7408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C282487D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20EBB24DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5628E32;
	Thu,  4 Jan 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UB/s7/iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222302C190;
	Thu,  4 Jan 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K58tQZ/paax4WwF/anP+UctikYPJpL6jJOpble2V0iOqrLZm2lMVlG0ya6TGWj2Vw8inZF/IbXUcBDHf/2dYza+Lu8QFUt0BRMSMo2sdaVp4wNhGv1C131zSptGeaK/W7lFWoGcUsCu4FJXxHXU+KRJucl/pfEPMRQwBugVnxWOvasRXKoBe/DC12Tmp/p7z39/GCpLVAVJ2PWhssBJ0+u1HPl+fRC9uXqiMGtEXWYCfkjrefjNDxg5ceXzbo9MqjCP+YzqduWzI76bs3E5LQsimmEV/7p4zcqejvPtbACygzlraqn+N4i9AcNUcC6qIHzzWK505hzJ4Hr6nKGgQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXTpUkxTXAFp0L9rKPHpEXeP4N6EpdCqIuQ2q2LMdcQ=;
 b=l/hBi05S/RWk2UlkM81dfIiw9id/OzZvmhsWS1gEmTXRwNF/zQzp6gF03pmcjYTLBKhPZalE3/C8vpcRvR8l4eizAZVCa49SXc+hUE+bHTlGzUpmgDSF6QmNNvIEcMYqtSPElaX/TAFK9pueePC/8UsiaVG9qbsjtbLk+tJROFUkcnX1xzHiwNu/Emc2fte4oBQIyyOx5EmL+D5o1XkavYh73dFK21Xc4Xo/kvt5IOT9fgF/JImNPaMQKfxy0UKwibZqPE/tpRZJGuULz/8F1WHTIGTW2Vc96SNPYuwYIyFrumP9MNBvdmRQ07uo52QlttERbGRZMEo2RzmqpD5OKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXTpUkxTXAFp0L9rKPHpEXeP4N6EpdCqIuQ2q2LMdcQ=;
 b=UB/s7/iDQHz/9G74hmP+R0WejWFQyLhy7xWZrMQPmji/k9rOkmqtAFsXGGEbBMjNE/4hbGtu46WHOHvUegTdvCXZG2FB6tx6l74LqSnCEB8a7q4r8KG+K+H5YkgONdmfo31dWofUw/0uXrXvBHNFMIWTTG7GUE72ciZn+kPLlIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY1PR17MB7045.namprd17.prod.outlook.com (2603:10b6:a03:532::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 18:59:45 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 18:59:44 +0000
Date: Thu, 4 Jan 2024 13:59:35 -0500
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
Message-ID: <ZZcAF4zIpsVN3dLd@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
 <878r58dt31.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZRybDPSoLme8Ldh@memverge.com>
 <87mstnc6jz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZZXbN4+2nVbE/lRe@memverge.com>
 <875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y09d5d8.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY1PR17MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 559856d7-5c9d-4d35-6aa5-08dc0d57509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S1fC7//sixNWkF461pph33cjEWAHaWEmbz0U7cSOb3pEay2cCPKDSohMNtMlHMeHeumqERS8KsN/jdWauOWVfI4huVshFrqrdy56kWxdzT1N2lDo0RsprFpIbQpqqvQTg6HFV0pyNwtVbDnNT0FJwwML08qw1+h1ZBedfZnLHu0vF73AbmlG3aP3PRMQv5UdKLz9ZepnikufFrXEtOd6OYaNcVgqF7u/Nj/gMPa9NpaXl9ZxZ3x+3iyuvI4dLObuFXFUcNPKPCGJhAXDFegZRrAAghOk9MQZiTzMr2PKH85GqU91odI+BrTCMyBRi+2cQBVmbQyYUFsAZUzEYX6yFgDfRrghQqmRbwK0rJhSpJs5n6qMb2/QrTauXh781KguQEnrfPNbdexB5Nfo+8kpIIc8XjKpubvRoqXG/zxtKX3AfV9TEkn0UVS5y3873RjXsHjlliVvb+koaIMlN/r5Z6/pep7Ha6O1cU372HC5HVzLxbEyesy47KzMWqVVMIlzGtqWXZxrQdElx00mlnjrL5TF1FrWxy78G1b7uV2TC62/puA1rQjPv/KO14og0tP1eQde+RMwngdYwk1ajzb3xo9Ud/AlwYVVM/UoH473p1hTBe9GgA7swoSbdH5TVZjv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39840400004)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(7416002)(7406005)(5660300002)(38100700002)(86362001)(41300700001)(26005)(6486002)(2616005)(44832011)(36756003)(83380400001)(2906002)(6512007)(478600001)(6506007)(6666004)(4326008)(8676002)(8936002)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XvGvJYtaJmUH0Mh/OK9NforlbTnnL5leqhHyBOXXE7R+zs7xDc+Qd3DpIYa7?=
 =?us-ascii?Q?CiE/YB4HiK8tjNgzVUv9r6i51mnapr2B5cBA1sIlTASQvqzVypiLkIkCI2Q+?=
 =?us-ascii?Q?MZ3Het22KP/iN7xEROLEGlw0B/WOt6R20YFeZl+H0k7DZ7R/R9hRT6js+zjR?=
 =?us-ascii?Q?xZHTnZ1u14nJ8aKdE/FwVRuhCd3Uo7IcfEOwBqOYY7qFGbCmd02b3h99bsDZ?=
 =?us-ascii?Q?J94PvRbGR1FNMKUj2IkbSZD6AtKxGbJkHOf/PCHsclK5BynRcafxvqyJfzDM?=
 =?us-ascii?Q?XvpA9iBvxWN6shfrRLch6tgnwSkUsN/k8meFDTcyuBs/T65H15IhrKvc5cb+?=
 =?us-ascii?Q?8dOIIKHKbC2a0mEHfcJgBADUTiEc9jt0bhaVjqJ4dYXT4b6AOkBP/3iHohmt?=
 =?us-ascii?Q?/luJkiKF1dX0HGqcOYNporTVZUVJ63pKaKB7ZGkf8vkvSj0CQTTT5GO5EvpF?=
 =?us-ascii?Q?GprOu5Tk5tzo1wYNA+/twTi6il+rzhHuA1wGgQgWYTMULT0tkoOnmmKa9moy?=
 =?us-ascii?Q?bX+MG3XkFM1TZa3FJQIs2ouIeeIGeJQ9QJSwcdY5IjuHn6GLyn/ECTqo0/3I?=
 =?us-ascii?Q?bGnTVZFwDMAKemT4Kz1ELt9jkzTojBY7dWMwHZQibYhJ8O0d3/Sqg0C5URen?=
 =?us-ascii?Q?0LMH3qF4UQBvDJgBw1CMOd8X8QwsLUoCDsnGaZOomzmX3bI4zTIUpnjQKENZ?=
 =?us-ascii?Q?VaLUR0O7o7LJ3ht7KFWOqfUQjyzDRv/jAXN/QsXl+syihOU1v0RaILf7J7Ol?=
 =?us-ascii?Q?Po2aPHeWmziKPLnbRl4zkORSffzfqHQp/hUKVl3HV1asBgN/4hsjNIHCg+gG?=
 =?us-ascii?Q?YeCzfdmM2RHcBcVHKClRS4pQpkWOEv6ovTvf8AYWR8rQrDEbtpOzydQR4bDp?=
 =?us-ascii?Q?rHeEhpoy5+iNVV7L5oc1tblNkMyMX60gtkrBvSMaj8JkYm5KWufn6we/byiS?=
 =?us-ascii?Q?Rf6gDq7OiAzG6F6KmwEkn2ysJktTxGQsO/7Rgw2E5sDfYMOdDmm49R42dHLy?=
 =?us-ascii?Q?eYAG/Fv2CM0pcd6us0PIzHhYfvHo4pPfWZM1OZgIaAPAOU+XcD1jlFxJJ5UK?=
 =?us-ascii?Q?m0bJdVWlFIkfPQdG6QE2UmxBwzoWix+4qKnZGU/9UAXV2oW2vej6Iph/k6Un?=
 =?us-ascii?Q?l9qUqmi/kCpftoX+kKiVXNh270T4Rfja5GzCFeavoi1Luda2XNgZgVlXM7EA?=
 =?us-ascii?Q?qBWl6aWHYcwnB8EsQTfTVtLjmdYxaRQ5ECK5qnjtVKnGa0vv8645qfRI4WaM?=
 =?us-ascii?Q?O5v7lr3jI+R2aWKcbIooixoHKYsGM0DYJV+N7L+9+GwbVTWecGM0S50NCYIj?=
 =?us-ascii?Q?gO/eNHiuthDZDV5a+7K3cqHwjs7qdSqAKrZd1MENqsw1X0Vn8C/xMSb42DYf?=
 =?us-ascii?Q?O6tdOjjsiEtZkXO4oLghp717G61F6IMvNx4Ve9/+5DgCaAH/zy3XiaIpB2XE?=
 =?us-ascii?Q?RPFCo0jYNULkQ8cwW+uKeIDPW6jhpMvGFAZ2Bd+rH+qQ/LmmcqVqRzaDSOIg?=
 =?us-ascii?Q?T7PljKtblAEapjIuo9WReMi7EJ+hjQdrqmHlNavxthb28OcPPhMP3+tBAWZU?=
 =?us-ascii?Q?2bq1eeFY2KE+EaC+QbjfGqsrhlyH/K4EL8pUDqM5fgus7mp7N1cyBNVN9082?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559856d7-5c9d-4d35-6aa5-08dc0d57509b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:59:44.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAG0tN0pLhNGePQ4dnYcJOySN9m5ISLE7VgMvFzfo0DbXD1xvZ6K/Zm88rCjQxnTn9GBo/h3w/Jnq2CtrTHcNNSZ9vlPYZw5/7F8nfr0X7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR17MB7045

On Thu, Jan 04, 2024 at 01:39:31PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Wed, Jan 03, 2024 at 01:46:56PM +0800, Huang, Ying wrote:
> >> Gregory Price <gregory.price@memverge.com> writes:
> >> > I'm specifically concerned about:
> >> > 	weighted_interleave_nid
> >> > 	alloc_pages_bulk_array_weighted_interleave
> >> >
> >> > I'm unsure whether kmalloc/kfree is safe (and non-offensive) in those
> >> > contexts. If kmalloc/kfree is safe fine, this problem is trivial.
> >> >
> >> > If not, there is no good solution to this without pre-allocating a
> >> > scratch area per-task.
> >> 
> >> You need to audit whether it's safe for all callers.  I guess that you
> >> need to allocate pages after calling, so you can use the same GFP flags
> >> here.
> >> 
> >
> > After picking away i realized that this code is usually going to get
> > called during page fault handling - duh.  So kmalloc is almost never
> > safe (or can fail), and we it's nasty to try to handle those errors.
> 
> Why not just OOM for allocation failure?
>

2 notes:

1) callers of weighted_interleave_nid do not expect OOM conditions, they
   expect a node selection.  On error, we would simply return the local
   numa node without indication of failure.

2) callers of alloc_pages_bulk_array_weighted_interleave receive the
   total number of pages allocated, and they are expected to detect
   pages allocated != pages requested, and then handle whether to
   OOM or simply retry (allocation may fail for a variety of reasons).

By introducing an allocation into this area, if an allocation failure
occurs, we would essentially need to silently squash it and return
either local_node (interleave_nid) or return 0 (bulk allocator) and
allow the allocation logic to handle any subsequent OOM condition.

That felt less desirable than just allocating a scratch space up front
in the mempolicy and avoiding the issue altogether.

> > Instead of doing that, I simply chose to implement the scratch space
> > in the mempolicy structure
> >
> > mempolicy->wil.scratch_weights[MAX_NUMNODES].
> >
> > We eat an extra 1kb of memory in the mempolicy, but it gives us a safe
> > scratch space we can use any time the task is allocating memory, and
> > prevents the need for any fancy error handling.  That seems like a
> > perfectly reasonable tradeoff.
> 
> I don't think that this is a good idea.  The weight array is temporary.
> 

It's temporary, but it's also only used in the context of the task while
the alloc lock is held.

If you think it's fine to introduce another potential OOM generating
spot, then I'll just go ahead and allocate the memory on the fly.

I do want to point out, though, that weighted_interleave_nid is called
per allocated page.  So now we're not just collecting weights to
calculate the offset, we're doing an allocation (that can fail) per page
allocated for that region.

The bulk allocator amortizes the cost of this allocation by doing it
once while allocating a chunk of pages - but the weighted_interleave_nid
function is called per-page.

By comparison, the memory cost to just allocate a static scratch area in
the mempolicy struct is only incurred by tasks with a mempolicy.


So we're talking ~1MB for 1024 threads with mempolicies to avoid error
conditions mid-page-allocation and to reduce the cost associated with
applying weighted interleave.

~Gregory

