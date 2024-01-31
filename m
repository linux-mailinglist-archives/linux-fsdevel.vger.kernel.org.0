Return-Path: <linux-fsdevel+bounces-9616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27598435EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316391C225FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A353D962;
	Wed, 31 Jan 2024 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ugn1b+/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06733D548;
	Wed, 31 Jan 2024 05:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677954; cv=fail; b=ub3cP1FctQHWXopYT209VhEgHrmXyNechRM4EGVrAuEa04N0jdNM/ZJHhsHdt9rZwHXVSOWTtPNVaLb6amjh+JxO5OhGsYSMWZDmj3GNdKrqDLZSp56G609H33//P8gmHASh3CnXW61Mx7CYJaipq28yNTGaFIssBH9Q8OvCKsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677954; c=relaxed/simple;
	bh=Pa2GbEDS619nUEgdNXgkpvNVANqYDGOvAEzL0IItvDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wi155J/WBTUhdkaPEHCMgtAWtu1+7X7g6ttQ2wVe5UjFW7pSRmY9GSQnKnDOvwwFG+9G6L9BDfGcqjG9P9M1HCPANTdaQ9MjqidevMBtugiAsTKexMaOeCrjfW6PYtQcKV9YGbtQagT0C5PGle5YpCLWt0xdJZJ8vKWsfsw6qB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ugn1b+/E; arc=fail smtp.client-ip=40.107.94.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsqY2h+u/z9aRiuNJVLNxCGJ5po0BEoAVdP3YQRfAYk2dWswO5ZNEan2DX2bOaPN2JjolAwM9wxS5OmY+iYoH94b8oJExfO1CiYdbmm0F/6IJj1XkTxyloiJR/sHRwiUhbkAH7NfiQKVX3aWz81nb8WXJfM0EHFNZyeUyqBeHRjLXdk0N7vaS77XU4PULVrXd/FLhHMgVrvdtbkx8QRae+kSGWJeK7k3A0q+HvyOYVu2cCaozl/AKIsv2LGsJSEza5tus0sFcvGVDFRIlo2BKcDVqsfraB8J4T8iVTLnf/oOIwIGuw9x+k8G5C0c/on7ydVvfSWol06W/UBMZOHsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzy+08+X5nBwtfZjcfR/cB+0TAoxQzf92ItY0JBaz90=;
 b=DMAKegLl6C1QO3VS428XQP5h+30G+XbSV2laUTabi1B5aL1klnHh5c9QAu7170G4gYgHxinJV4wJxaaPi4FpJxWAvr8uNTK6ftlaGSkEhSk++4RD5LxCbE6R9piXNGRVNXVvb4tjCADeEAmp+jyhha0k/o5ChAZnSdwOp+I2h688XddFmra+9YHGSTuYExUEacIEr2FgQRCgiT5zfuhDFbgha/UE0tWjdrtJEtTo3HiVC8icvs/h3aR0ZLxgzGJ4FMRxNUC13Yuu+3HHUBAOVUn3H2W8T6iEz5QBashKzPwbKh54umohE0LD7gYQJwmULu+RMfh8Cqs+ewGDrc1ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzy+08+X5nBwtfZjcfR/cB+0TAoxQzf92ItY0JBaz90=;
 b=ugn1b+/EUA41NEkn0fp/BoFoeooLv8ri6gZLPEU4OROgVJsu1y4P5/vKLS+/Nfj3C6LMFTF04n/rDIhELxqIvmjBxMoz3LYDGRMQ/Hv+lFAuZ5fSFNkglmMslPYSdQ9L8dc2erGpyEQOFb+5eKpGmNtsvtgCT/4SeRObtymaR9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6545.namprd17.prod.outlook.com (2603:10b6:a03:4e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 05:12:29 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:12:29 +0000
Date: Wed, 31 Jan 2024 00:12:24 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, corbet@lwn.net,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, mhocko@kernel.org, ying.huang@intel.com,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v4 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <ZbnWuB4dRCEFRz2m@memverge.com>
References: <20240130182046.74278-1-gregory.price@memverge.com>
 <20240130182046.74278-4-gregory.price@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130182046.74278-4-gregory.price@memverge.com>
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 300ffd92-869a-4cdb-7f9e-08dc221b38c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fwt57qkiFFw65TQQDi9XwnDOyJr/4HfNiAGlVv6WRp1gzvcFtrRbkufpdr7aYwOjZdm1jEMMPVH0UOR8ZVFbC1bqi6jaPemQCXiR+g9Em6LxXryxwweNafXHW1MczoRixbQc9Iq4blort3ZiE9aljZTZ2Yg+BVK8os2dMExaeMnU9LJ/B8PCX634oo172wxgGrHmW/SdO2BKgxIhH/XrAqf2bLjxE7J6gmfXRKKTWYDIWLqEWFtTZCUjnd0E/jP15diKcMk6spJP6LS0/TQDePKtmgf/PdVaADmlOLMF7wmujQRf7GKaXIgbOu6cqyrzSDyoc9myktmk21amMOpF5kB1HHGKNWM8q6tNCdeA5Vu7ItRveKHKQr37fBt13ZZuZpjjU6+KOtAYfIj5ThVyDXivxCZA6ENZJlMz0Qsl855rmn22yHtlhViVVWGLQ70Qi3M56/O/AJJKz8klaPPY+pZXjGe+Ur6yQRBXHH7PoMjrfJDKTzbBFD8JQSEaKeNRsS88kM2H5+9kPAN2E/ch2Zyj5br96j9QS9Vyjn2tOyF0/gk+RdKIqj3MD+NDVRgyunZkuBjSqxgIfOdI8gfUVSwoRV+Dek525vSPbAlN0Cwnw7fGVTzVTQXK4dczzaog
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(8676002)(4326008)(7416002)(2906002)(44832011)(5660300002)(6486002)(86362001)(316002)(6916009)(66556008)(66476007)(66946007)(36756003)(38100700002)(6512007)(6506007)(478600001)(6666004)(2616005)(83380400001)(26005)(41300700001)(16393002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPbAhSkvl212xHi2ccUmrZTOnxxlLdtv/4zn576q1csZf0L/4TbX18f92Sk9?=
 =?us-ascii?Q?TVDgpCgWq6RBP/XMqPODOjNHJbyYbssvKxIhWlvlXGt+zUGJkksDIveSY8Qd?=
 =?us-ascii?Q?+sQJFjqd+idFWcNiWve1Z+E416gTFKV/JlaX0xO2AKXV8CYl/R21Lp+3KdMP?=
 =?us-ascii?Q?h8PKGs0E//CSbXI8OiQb/zZV7sbzzUmKkDQIHnpMmOofgIyRfvZo6D2Tn3uZ?=
 =?us-ascii?Q?xft20U9unyYhMeEP+iB5l6zFD/TFjmCdkmnnnWeC6PniGS3WVu3psnE+ptpc?=
 =?us-ascii?Q?zg5NxQ3QfLPqW2gyHihbyK97M4gxTnQCQOZmLjgs/H7z4izejihcYBip7hZF?=
 =?us-ascii?Q?+EAXYw450ix4r/7WlmXakf2ma65n2bHAHva2/IxJmamCAQz4UVbVDatKpuDX?=
 =?us-ascii?Q?z/JsSFLW+u4G1hq3FHUyGhJBkeNuj/ZpYapKkX36GQmGE4m+UNlw/pUyWvBo?=
 =?us-ascii?Q?w9XKZbyerE0ERrO8UjZ266ufvCkJ5CsybbRO+lDWNr/Gfn8sMKvLYbRdhiDc?=
 =?us-ascii?Q?vRsoHIXW5DbJDg36QgUEbLnUNYSOTULvyr8AN1ssmqo95UKUlvW5rM/KdGQe?=
 =?us-ascii?Q?9qDn6OZzTNHOKaEr1RoN6AGQgBy6tTKIK/tcVtxk/T8MwXymyYAEHkKHLz5V?=
 =?us-ascii?Q?VKZ2deQg/aIY+Lve4h2TY5WuiDxxnr7IHiXl1ecLgU3xeqWXFc2ZDYK8nPFD?=
 =?us-ascii?Q?sKWCivg/uRZ3cdbTz9r6U9s3AV/gKL0QZ6wwxccqNOGwc2kvpd/oaCplDdd6?=
 =?us-ascii?Q?NSNMsZmO8kbL7n3hhqYtDpXY+FcEZc6V3+AAedBSNoU4anw4+rdhBM4/uB5n?=
 =?us-ascii?Q?2zClObbFkvO4e53jVU7G2cwFMt+0eH4MPGTgYzaG7HiGeVyd5vcDWje28BGc?=
 =?us-ascii?Q?xztVrxK2WxgxwC/sOC3XhUAWOlfCfJKyUNxfegmDywlkQG5pq0hXHHbDrtgJ?=
 =?us-ascii?Q?Cf44NbsoB0dy5i0JHXrGHA6QNb6J49aMKMIGPKFj1DbHzPIp6tH/R+g/Hs+8?=
 =?us-ascii?Q?VMKSTBCwm3U+zCDvpkZ3VOdspiMiMcfXBd+YYxEZvSxu35d4D7CSb0jrSc5V?=
 =?us-ascii?Q?7MpZ0Xhu32mn77d/JGKiO1neFcb6njxFBSIezpaj/IByX0ScivPGBAUbvzno?=
 =?us-ascii?Q?A3cJquTA3mCUC3NHTT2fHfnEPSY57Puag/8LLmbeNLzzQd4V45QuiPteTG42?=
 =?us-ascii?Q?kiWc5vgc3mZezOHNRVTDGCevUViVGtYV40dnaE6MvrGKCTT2Q2JlwgwoPlsm?=
 =?us-ascii?Q?2CxJghcdyI/UYvaFx62wE9G4ODc253a/8uLpWrRlwurn2b9GgsSjXfdJeIAk?=
 =?us-ascii?Q?vPbW7b1ASE3U/ir92qeImfk5X2bNli17C16+xZiKnpGImIpK2lyecgxZwkLa?=
 =?us-ascii?Q?SAVx8IymJF+pRKaDTpnYt9wvUvbAWJ934rv+vbJLCP5zEzSlY4hs5hYUVc/E?=
 =?us-ascii?Q?xOE74ALsoTtw7UfksZIHWxI+aAGMZx78HF57Xx0tw8oucS7GW+jOUva7B/OV?=
 =?us-ascii?Q?usPK8tQRzRMY6YrLKmQ3nEVjCaLwTDDLJO6Y0IZqfSf5Mv8VPIX/zBVwU2Hq?=
 =?us-ascii?Q?Ublr2hUJw2KNOhm0l3VL4J7zVrjfZ1Nfq6rhBUAdcSlmFOoNcEsIzwSbG5/T?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300ffd92-869a-4cdb-7f9e-08dc221b38c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:12:29.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMKIXlFUq2MdZNrWoPp+n0uRXYOPtozAPyNnm+haqdluevK5a0rEiPsjLZCEg/36T6XvL1mV9730e0uCHk0JCNDKd/K37fD0mnxUrGgzLSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6545

On Tue, Jan 30, 2024 at 01:20:46PM -0500, Gregory Price wrote:
> +	/* Continue allocating from most recent node and adjust the nr_pages */
> +	node = me->il_prev;
> +	weight = me->il_weight;
> +	if (weight && node_isset(node, nodes)) {
> +		node_pages = min(rem_pages, weight);
> +		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +						  NULL, page_array);
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +		/* if that's all the pages, no need to interleave */
> +		if (rem_pages < weight) {
> +			/* stay on current node, adjust il_weight */
> +			me->il_weight -= rem_pages;
> +			return total_allocated;
> +		} else if (rem_pages == weight) {
> +			/* move to next node / weight */
> +			me->il_prev = next_node_in(node, nodes);
> +			me->il_weight = get_il_weight(next_node);

Sigh, I managed to miss a small update that killed next_node in favor of
operating directly on il_prev. Can you squash this fix into the patch?
Otherwise I can submit a separate patch.

~Gregory


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7cd92f4ec0d7..2c1aef8eab70 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2382,7 +2382,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
        unsigned int weight_total = 0;
        unsigned long rem_pages = nr_pages;
        nodemask_t nodes;
-       int nnodes, node, next_node;
+       int nnodes, node;
        int resume_node = MAX_NUMNODES - 1;
        u8 resume_weight = 0;
        int prev_node;
@@ -2412,7 +2412,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
                } else if (rem_pages == weight) {
                        /* move to next node / weight */
                        me->il_prev = next_node_in(node, nodes);
-                       me->il_weight = get_il_weight(next_node);
+                       me->il_weight = get_il_weight(me->il_prev);
                        return total_allocated;
                }
                /* Otherwise we adjust remaining pages, continue from there */


