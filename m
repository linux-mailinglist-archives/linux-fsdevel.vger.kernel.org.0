Return-Path: <linux-fsdevel+bounces-9426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8AE8411CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FE1F26A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076F4CB54;
	Mon, 29 Jan 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="sADWarc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910276030;
	Mon, 29 Jan 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551902; cv=fail; b=IAfpiVRBMX2LBQusehS0G9SQinESiJfqm7Tyl96PLqpHJFZzJURWb/mfcAbI+XOkX4YprxC5zB5NG3qeAitsCEx7bo4mhRvk3BEaABqffaJScOiQzUGJ9mZrTYO2Xjb10pA0aDlD5srO6UEaFrb+ZNWqF359hweYPEVbT6Qvg90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551902; c=relaxed/simple;
	bh=b9hiTyCxh65eg8y93lz4sQRj8/E1SpCo8om0aMZRswY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f0ay/C1SwZQuhylb9W7xVtT8Fmpku5QUnlPdZS+cwulmU9FVySQsAb5hWy5t33V5CULZCvPg48IRztHgpY/hrYz76S+nfw9ZHM9bpPUwcfYnez05qatnSTnY6pyqqaU6Oecy/f1CNthFCi9ujJkFP0qAYR7QwPJY3lAyCo1iuEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=sADWarc0; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdMzskedH8hIq9gmSUvT/SGP01Z5QttU/xNna+1DrePzR9XTf3Af9wc2aY9Tv8yVzdBxl7Dky1e05iBedOeLp5DfPcpuS7v+phx01E2u2a9spiZhjxrClZVgGDP7AhImqV0nSVSbezbr5RH2B1wXkfwidDxDEqPWk2rJDg6aQGRpOq2awrcRDtvpyLvoPqVq3y3l0ZkJ3HYcShYDVzZBsmAfAldThqj9gFOvjTJYTHH1mk8nBZyflcjExxoJX6feRaAyO0nrq54mgYMf0INmUE3SIcdBnUmcyfi94Pe7axE18yPgLnBLKIdNGEAEYH52jXKv1gLjb41nQqAae2FvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n71KXgM89t/zU7Y/QfBOQ7cVAjGHDK1h1IWu/wg8jI=;
 b=Meb0PTJOZrwNrNZ6sSrHxOMbVJ0dUP/DlKAwdluSCaoNqt0EIb+Ag9Pv9BPnhOkn5AORfBDrG5LTO6cXbJsPp8KCLlBb4NYVjtZ/u1epFABp2sx03gFeeIplBNXXWnN292wxKH+nDImbgRT6Lr4Gc3vPP93RkhxdoD4xdsF213/1l+KioZYNnRlmPnUjyQTkmrJ0iKZG3vq/Cud/HK+bGKl5XZUav8h9rEM525P1sA9KVY78+yZh44yGQRM/1wRKJf6xm7xiZmgK9g61bJ5USLW8bC68wBi7b9FIvxKcBoTb+eMT7R6lPBuyuc5M44xHFRXC+2dcbQIW79ttXvGifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n71KXgM89t/zU7Y/QfBOQ7cVAjGHDK1h1IWu/wg8jI=;
 b=sADWarc0rgeUh0btM6k92NFOq94jSgcT7UlTjuj/mpCJaBODUQ9alhnzccRxx3BO0RybXVPkgDNrTlu7NGZHdXivI1fUeuodUAP9geKBKnyABqaUWRxKDX3mEg2sChpbmrSx3QtqOuGosrE18Y0W3o/Of52iTSTe3JodJsjjYmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4798.namprd17.prod.outlook.com (2603:10b6:510:8a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 18:11:36 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:11:36 +0000
Date: Mon, 29 Jan 2024 13:11:32 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	corbet@lwn.net, akpm@linux-foundation.org, honggyu.kim@sk.com,
	rakie.kim@sk.com, hyeongtak.ji@sk.com, mhocko@kernel.org,
	vtavarespetr@micron.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
	hannes@cmpxchg.org, dan.j.williams@intel.com
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
Message-ID: <ZbfqVHA9+38/j3Mq@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-5-gregory.price@memverge.com>
 <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbPf6d2cQykdl3Eb@memverge.com>
 <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbfI3+nhgQlNKMPG@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfI3+nhgQlNKMPG@memverge.com>
X-ClientProxiedBy: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b458ffa-b1d6-4982-5cfe-08dc20f5bb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IrfQtKUB7TPUwgzhroaDORXD1YX5bztNw0ToYxXkmzrdBwT3I2xmU2Zq5R5sv3MRl8D4I5EAn3982FlEH+w2Cba+nhVHvYP95EGbVqw7gyq9pOCThFDVE6RUlFadwkmPb8gqLmBPN1UU7uChAyeSDuSmC91wF/duL9asl+1mOM/v1GYmu5S4akMmX8bniewUzzfAOGsWj6sMWaso/pQXTWxvPV5ozTxPvjT89MHgcQ6WjWGkDZBS75SSPdir1p7aevMn0BmcxzG/QXdN3HA/LP6SYUqb4/NZqSR5/6HSoa9zYX8heuksFF2erubnLVzxnT6eezTdbttvH0YiSGuRUMBoXxjBiEXvKCAtJEBd+T+ZFpx3zmSABv+YAIgCLrZmYZV/nzOH8GVFaTM42ZhmoCazKFs9jsdKGNpC857vWOwb7ry9Vcz6Sy51iiR+w69aD7MJuI/LJJyb4UkolAk/jati8+OoXR+GzIDSIFQy9/HXyt6N3npmz4G07n+36SM1tOHvxCH4TOkJPeaffOxGKs48ou6Qe1G+s9jKPeD+WbH5LI0FYlyN/h1AXdpnJ5U3sv3MncUAqpRC7YlgBcC+swTsl3rI75YEtbzDlGS3mKzCGYfqihyaTFn2ovFjrIDR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(26005)(6666004)(44832011)(6512007)(66476007)(38100700002)(7416002)(4326008)(5660300002)(41300700001)(8676002)(2906002)(8936002)(6486002)(478600001)(316002)(66556008)(6916009)(66946007)(36756003)(86362001)(2616005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izBJ6tXFsAcGpbNG3c8icBcb8MPY+B0WHRTdrUELcmx9PJC8zjBIpN9SX/5q?=
 =?us-ascii?Q?8FwwlEw0DeCckmIbHDhHlFveddo7FWAzmU5OU2apyBeIDJRJWgC12kNel5sN?=
 =?us-ascii?Q?WBk6kZkg+l95GWRRDdh9khUkkT+PyDfEOyuoiAJvNTvYc4sgUFCenm3eRse5?=
 =?us-ascii?Q?c2Ewa9TAY79/Fij3nmP20X1DiKxMP24zgh6f8uR0hS5bUyVUJr63h5lz5cle?=
 =?us-ascii?Q?1qVjfnqm1qK/zP3v4/VvyGmS7KVfAnPwRmLDav6AiK1NOVxLROLg8CWxCII6?=
 =?us-ascii?Q?ap7W2Zo7ro0DqiKSYbH+dXdbU4rH2ox86SfRWOfLGpxfE9A16Wp2tHnhN8Lf?=
 =?us-ascii?Q?iit3P9PmzhLIYnslfwQClPsqykZ6HluJPhTsdadriBWpyY9TUd2WBNSi1+Y1?=
 =?us-ascii?Q?MVEd8UozZNioRxS5D8rCI/v1n3Nplb0dwVP9xVjrXSl6K810c5SBIYdF+94B?=
 =?us-ascii?Q?WuWli3of7tZ6Z+w1z+CxJbbr5r+qAKo7x8cLnkod0A5z8/qLAclZpFwHRLxG?=
 =?us-ascii?Q?9GDrqFNgWg9Q1VbzJIKGWUftfFr7ELsaGGjacEPz6kjiywsdGuN43Cz4XmRZ?=
 =?us-ascii?Q?YtwCGePHfUZjubTw62nieCTHmecepldlLrjuhUTeat+MJgCcEnHHel3yl4V9?=
 =?us-ascii?Q?w9cLc4iqZR+bgkkFVrPn+1WhQwoixlAxVZwV3adtsrp31+NUrHESrx9tLBqh?=
 =?us-ascii?Q?mKkl/HmhPi0kSOfzReU+DC3N26hnqXNO1AwtSL01PmlwKK3Lmd+XBFUpeJ8q?=
 =?us-ascii?Q?cvzcs+ij61//mMMmGBkP8A3IKpIuzq+9Kn4DvRrgFgXzAni9uAx+senWV5F3?=
 =?us-ascii?Q?bhctLiBQzSVg3HxMTjrPO6/EZY2iGzbA4gyd0IFsj+iiM8CD7QB/xWAV3hc9?=
 =?us-ascii?Q?mdFBu302wb7uQNojBzpZomllZSVh4HQdX6SlVYHgrSrWvqgE7pabMVOtdZxQ?=
 =?us-ascii?Q?8dQ1EeQA9A3bEfCwqsMq0nGZPZ6TLFVvK6nfdHNQL/L0VMxXXS5VAnV7lPoC?=
 =?us-ascii?Q?osVsVsTD9rtUOWEQins3bGnF0fE2cP5KXylLhHQlItH2C5+YIB9R29Qx9bf7?=
 =?us-ascii?Q?ddEkAV1wmA9C6XWHxZaLzalTtK7xBfDJuFN0J55hIycKZqVVlYeQGyzF5k5e?=
 =?us-ascii?Q?bbpdptgVh3tjqHnq5Tj5zpoaybfV40a5RXDDl+bRr9zRxb5ZVAch6fZ0H2+3?=
 =?us-ascii?Q?LUP661nKZg9lU4s9vmMDJ7hmJf3oYmmBOFI1EjK+rG01S7Kv+vLQCu4567MM?=
 =?us-ascii?Q?mqnXvYHF+ckPOvA3akdU5bDxD0sepXgS1HzzEPEgJn6+U2xBkXL9QJdpXphw?=
 =?us-ascii?Q?lhv5lbTOar4T/4lZery1VOj78Nv+orz+eshKvlA8xxX49bgwEpqI9hCM1E82?=
 =?us-ascii?Q?8zF2UjIKL2qH6vCnhUYOZiTakpGMcI1UWKfVD73xRD28bHG7sqNOpYdpBXEE?=
 =?us-ascii?Q?JWq0ccsk2S3fU9DrLGiELU2gj/7e8hjWm0Dlvxpp8r61yLgd3nV6TsN+TMYC?=
 =?us-ascii?Q?fJlqD+Y05vmqivO7k5rG03IBRP8/HoRD96PAxErWK6OlgHxgXSkKA1Jy5DGi?=
 =?us-ascii?Q?srXFTq2hQmc+8GDLm0RWRlqWSrBToWw2SQW2lBt9NoKbrZ6u8NF3jpQBamzL?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b458ffa-b1d6-4982-5cfe-08dc20f5bb74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:11:36.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecVpDH1XQbLBakkjy0uawdF660g7CP8t/lNcAuVcf7jlWXMABFarKDb1ekq3gF1NWVqnDRZcvWht/wKYnGDBUcCfmq+AsHHOmffYZ41OmfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4798

On Mon, Jan 29, 2024 at 10:48:47AM -0500, Gregory Price wrote:
> On Mon, Jan 29, 2024 at 04:17:46PM +0800, Huang, Ying wrote:
> > Gregory Price <gregory.price@memverge.com> writes:
> > 
> > But, in contrast, it's bad to put task-local "current weight" in
> > mempolicy.  So, I think that it's better to move cur_il_weight to
> > task_struct.  And maybe combine it with current->il_prev.
> > 
> Style question: is it preferable add an anonymous union into task_struct:
> 
> union {
>     short il_prev;
>     atomic_t wil_node_weight;
> };
> 
> Or should I break out that union explicitly in mempolicy.h?
> 

Having attempted this, it looks like including mempolicy.h into sched.h
is a non-starter.  There are build issues likely associated from the
nested include of uapi/linux/mempolicy.h

So I went ahead and did the following.  Style-wise If it's better to just
integrate this as an anonymous union in task_struct, let me know, but it
seemed better to add some documentation here.

I also added static get/set functions to mempolicy.c to touch these
values accordingly.

As suggested, I changed things to allow 0-weight in il_prev.node_weight
adjusted the logic accordingly. Will be testing this for a day or so
before sending out new patches.

~Gregory



diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..f0d2af3bbc69 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -745,6 +745,29 @@ struct kmap_ctrl {
 #endif
 };

+
+/*
+ * Describes task_struct interleave settings
+ *
+ * Interleave uses mpol_interleave.node
+ *   last node allocated from
+ *   intended for use in next_node_in() on the next allocation
+ *
+ * Weighted interleave uses mpol_interleave.node_weight
+ *   node is the value of the current node to allocate from
+ *   weight is the number of allocations left on that node
+ *   when weight is 0, next_node_in(node) will be invoked
+ */
+union mpol_interleave {
+       struct {
+               short node;
+               short resv;
+       };
+       /* structure: short node; u8 resv; u8 weight; */
+       atomic_t node_weight;
+};
+
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
        /*
@@ -1258,7 +1281,7 @@ struct task_struct {
 #ifdef CONFIG_NUMA
        /* Protected by alloc_lock: */
        struct mempolicy                *mempolicy;
-       short                           il_prev;
+       union mpol_interleave           il_prev;
        short                           pref_node_fork;
 #endif
 #ifdef CONFIG_NUMA_BALANCING



diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 92740b8f0eb5..48e365b507b2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -149,6 +149,66 @@ static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);

+static u8 get_il_weight(int node)
+{
+       u8 __rcu *table;
+       u8 weight;
+
+       rcu_read_lock();
+       table = rcu_dereference(iw_table);
+       /* if no iw_table, use system default */
+       weight = table ? table[node] : 1;
+       /* if value in iw_table is 0, use system default */
+       weight = weight ? weight : 1;
+       rcu_read_unlock();
+       return weight;
+}
+
+/* Clear any interleave values from task->il_prev */
+static void clear_il_prev(void)
+{
+       int node_weight;
+
+       node_weight = MAKE_WIL_PREV(MAX_NUMNODES - 1, 0);
+       atomic_set(&current->il_prev.node_weight, node_weight);
+}
+
+/* get the next value for weighted interleave */
+static void get_wil_prev(int *node, u8 *weight)
+{
+       int node_weight;
+
+       node_weight = atomic_read(&current->il_prev.node_weight);
+       *node = WIL_NODE(node_weight);
+       *weight = WIL_WEIGHT(node_weight);
+}
+
+/* set the next value for weighted interleave */
+static void set_wil_prev(int node, u8 weight)
+{
+       int node_weight;
+
+       if (node == MAX_NUMNODES)
+               node -= 1;
+       node_weight = MAKE_WIL_PREV(node, weight);
+       atomic_set(&current->il_prev.node_weight, node_weight);
+}
+
+/* get the previous interleave node */
+static short get_il_prev(void)
+{
+       return current->il_prev.node;
+}
+
+/* set the previous interleave node */
+static void set_il_prev(int node)
+{
+       if (unlikely(node >= MAX_NUMNODES))
+               node = MAX_NUMNODES - 1;
+
+       current->il_prev.node = node;
+}
+

