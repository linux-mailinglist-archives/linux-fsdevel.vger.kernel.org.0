Return-Path: <linux-fsdevel+bounces-9077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B204C83DE21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C81281992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABE1D54A;
	Fri, 26 Jan 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="XG7svLqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90A1D524;
	Fri, 26 Jan 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284686; cv=fail; b=ZmHKG9IjbZCn4ClllhYb4hEXnxdw4dpovPaW2+9YG1eFProG8x5dnFfzARH0Fyc2zQERm9UZi6LKXtcTNj1Rw62aXMu2EtNRxQWjZ2Z7nmGJH6P01eCvpJQPtoRlh2yUoZjY11KRDVqoCH9AWoZ0mqYXsJSG9Pr4p7XqBM/JZUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284686; c=relaxed/simple;
	bh=lYcOliWRmbP/1ltfOlNR5RIqg8of5cYX81dLNWtLlDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nh/pIM3S2wUn2Bl8mSuibOTW5kw+EJrHkbEHKOGpD358Bv9cZYf+qAmZEYUWtaJEYZU3cH38fPNgYrCTaaqygRjIiSv2YOD6glLcZoT8veg5pYmQyuZaYmKz1swQmLYG7a5t+lpxxhdHXE3wnRG1FJSTdWv6BS+gw7KellCbwR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=XG7svLqJ; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHLxqprvVE02iUMSoN1G9ZqPgsLX5pcepiZfeVsXJA62Fjq2Cf4wVgajZHFycm3lijmMScvPdQ4hwJUE+CwLkb1NGX3B9zZ1D2ExAHMxqpQvQfDjjB7i3dutAVYJy6c7MoeZUr7VBywCmexsHUqv94+CLnwjodganp432h2tV9E/vXciRkNXmmavAy/LYNDLCmV2sLKfWQNHcvlze+kSxnSIau4Sfxm9ZMxHr9GSF3PeDmY/2WSz8EE/cZDiHdf3NynO7DFhZfbNqjhX3uraE3Xe/uTt6pEXCXallrYSVVY0pdyxnKje7Tdk5GcSFHsuGn8x+69qqNrHnTwvy09JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb130topw67USQiscNpzmFuEhJSAJxamPy+hXIECiUE=;
 b=HWaz9dnEQFT8/j91FQTcgWn+5ol9eJ+KnBNwrp/6Qms27O3vhGOi2gaFIX7pw9/v6plrRmiLT8+UpcPCCKJqhFeUigqPJtXn7xSfUIUTzy16whGoPLYnmF8qDt2WmjJlEPFiYM9Ywng8z7nukCt/zlF2zoIpzA2sfn4/WUXIZV0A0qq88zIe7n+4GcNNfscTBvarhQxrG1Gv2rfU0d/9Sjxe9YldEeOGDA+nXFeWSaM8pHrVoRFLpZVmjH2K3qR7ZOjgZK2R7KVD3QIlLV/wgBJyaKhke8VVL3TfPv8saeuNOxhRTdjCLAF0BabN2iARacbuBidWDcf4KW23Rcbycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb130topw67USQiscNpzmFuEhJSAJxamPy+hXIECiUE=;
 b=XG7svLqJ6gqCWA4/lyixVL3feOeUaP7w/ihv9NP6W/HMGaO9L1dLg2cexDjJlUxD+vhsh7DsQHhw3Hk3VYhtvbZN8KVb8fRsBDZLZoO6jtSU+c1LCaRA0dQOC8YI+XV+30Nnlg9qrn0oYTgcF2rIg7xB7kZOmp3CvXr56SVW9qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB3970.namprd17.prod.outlook.com (2603:10b6:a03:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:57:59 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 15:57:59 +0000
Date: Fri, 26 Jan 2024 10:57:51 -0500
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
	hannes@cmpxchg.org, dan.j.williams@intel.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: Re: [PATCH v3 3/4] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE
 for weighted interleaving
Message-ID: <ZbPWf9HbUNA1MELh@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-4-gregory.price@memverge.com>
 <87y1cclgcm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1cclgcm.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB3970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7161fa-f726-433c-28db-08dc1e8791d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yFnOD0sZD5ARSnVqreV3OnHDWE3YkWeHs4AVsTt52rhhLHDwvkfNaHZ5ok+Af8fQJrkz8h+3cqDTDLm8ueVDK5NjBFUQZrkc9p92AG1lTNGF5iVZr9gtAFG+wNreuiGGernUKUe1eFZswA3JrYTmW9YxalY2Dj1RgTV/xJYocrXGTRCOe8JDR9h/vuUh0uyZ5Dc1PGYoJcOlbUrFhlDrGZwWMMUrj/19YxDv8L1Lb+ghYEf7MTNRQXmF3XFx0j0Vja8sqXLB1vOOIEy9O48C1/Z66fyveftaoqroBujMaOUDcER4vY3B9SkdxMWjKViev5ZF9+5Z4WWY84FNVCsh17TM/9/Nttl1NTAR6zaSiIxLVuGKqwyaHarzh24HXgrRzT+VZTH0LB/VK8jAKK6KdVP9o2wkutM6e4Qfw0YiBxlPkdlwE2ZcZC9Ywuw/36sRLW86uSvnlQhKKoRhP8QtyKA4XJ2W5O0qmnvwTq4acMQ0SllltroAnZz0zj+LlLnhNrZDUPZTQksykJe+Fuzm/wTiCZsP2YuwTamHZResMYTQhK4+Rk8UMKL/I8yIYuPcqIhAqZ+2ndFmeZFC/S4NufQQI9b6bkAVDcmE5sHx8Xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39830400003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(36756003)(2616005)(86362001)(4326008)(8936002)(8676002)(44832011)(5660300002)(38100700002)(26005)(316002)(66476007)(54906003)(66556008)(6916009)(66946007)(7416002)(966005)(41300700001)(6506007)(6666004)(6486002)(478600001)(2906002)(6512007)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrH88WMf52Ju+zKKucgLzly9lNONU4Ol3zjv1fJLnoZ5PuA/i1EquPrjwi+p?=
 =?us-ascii?Q?iD7ieJvRcO7aSUl4NETyI9R9dwB6AGqRoRZFL9+p653bVIwTYOu79TU5WTmb?=
 =?us-ascii?Q?tU7Qh52t3E6aYa1dolyD8JdtH+OZiAwe7cC3LvbOUMU3Iysbd7AwZqcp8gup?=
 =?us-ascii?Q?mCOWwcajDH6NUXAEuNbM7PCoKskIax3c7ZlwqBkHtk/XbcTdGHe47Rjz2TGG?=
 =?us-ascii?Q?7hClHtbiilFq5JZ0/E/KkR+qGMhqqgvBFeGIMF9py35uyTRyj+VHQ2ch3O/R?=
 =?us-ascii?Q?LeP4mR0ztBHRVbpzEymX/Eh2f7G/C4zxRivTtRM1zdKMo4u/seJy/ZBBDord?=
 =?us-ascii?Q?5k8y7wKph9AP6d4AVNT2gqbj90ktLiT/Nf7VctgZ66NX1S1GqENJyF1mALOS?=
 =?us-ascii?Q?CWNe/Uw0s3N6EID1B93cFdtppA/C53pQevv+gIqOCNbXpLX9CJNuJfnTe3a1?=
 =?us-ascii?Q?2H8bp5IRnh4xc9e1CnsdAecPrfEVyfJopZu36q9kPE++UZZmesqTGIFtDMou?=
 =?us-ascii?Q?xjW+B9+mIpVCONDWKCjW9wwVDs64XOoLYG6T7sCqsWf9+5mZyT06vo7PWVOL?=
 =?us-ascii?Q?vYCDNSByBKABYkVhz8+81zNSUTDb9rhdHmoX0oDqFUOCzYP7rt6oXjfN1GWN?=
 =?us-ascii?Q?wDl7zwn1nfuauF0JE3cOXFn8SYy0sE+rSENcN6U7HcXTyHRvSIALjF862kFz?=
 =?us-ascii?Q?qzwzIY2D9qRTr+Cu9AkvT0ddNwBOTtBh3GfZqe1TZQ63oHpx4+ocSDUpZ681?=
 =?us-ascii?Q?n2M5+rsUZ05jJrqfPzK1iEnctLK0OPAqcFOGWB3HR/jPaI5XVRlBjTzngwDU?=
 =?us-ascii?Q?ehnn7m4ypvRHcqVa5FspRcQ5RGXbVomp6Tf6OJ3PrsE7Ujtf3XB9bh+qii1J?=
 =?us-ascii?Q?OO7OtMLYsCtUhK92niiAqr5+7L5tW5P+iSMMX6l3G3T7yFK7diZiEhR4MhRL?=
 =?us-ascii?Q?4FK0ItQ5YO/H4LyECjZZIvTSW/O+nRZEXskAuy0D2niDI4A8EW5KrkbWnQqB?=
 =?us-ascii?Q?7HxxBlEJce4j9xdJqo+1BQewkVjGBl1EBhRB0nvNs03sy3b4FyFfw/whRE7A?=
 =?us-ascii?Q?0bq11UqrT6+JIzjNyyOSQgOgZYK0rehvmZJIbQ5X94S3IFiw5TbcIlsjVmlF?=
 =?us-ascii?Q?2Z+/C7qA4f8MvswSxRGZdTfg0xAXwMK6JjI+U1Yy7N3V0os+X9Rtl6hwNu88?=
 =?us-ascii?Q?sR/NYv17TcdoC/Z05c7btaGr71Wnsi1D+Snhyf8mIyB9TLebDDIknZ2QupyA?=
 =?us-ascii?Q?YEOV449fweAPShMkBxx+0wSvYlBgfdctkwJWIBAdDSOUOS3K3DVuyNwJgVvC?=
 =?us-ascii?Q?Y5hXvbMAt8eZadEqHHMUB+8MbsaAdZd6Ra82uPNQQais7C5KX/LLosuVAua1?=
 =?us-ascii?Q?ettMWKMJmmkP12ZSCbjgAmmf3PnfP7hv9WpCsUgP8DMolhrcXPk0V3o/9fKX?=
 =?us-ascii?Q?s6zLpf+/g/RUs5WYG+3O8orpB8n855yZwIokcN1dXFMBoHTlzS7LtZwBoiu2?=
 =?us-ascii?Q?YHO+T6yW+TGtdCepforgr22/OaOZn8PTJ6vsJK7Q7wvdjgJ2FG5/Ebyfh3rs?=
 =?us-ascii?Q?3qkM2y2Qk0DJF4xtaiYben45TN7RQdLMDV1fnCW0xr/aoDqxXuVzfkxMZ5mj?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7161fa-f726-433c-28db-08dc1e8791d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:57:59.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiiCuQHjpP1DUAoDCQw20CD2iYp+gRc4MVkMi9aHSDpsua+ITfw4kKE1J+0eYHL0D7YW/pjm/3RFlFcP+tf0ujaGRVK2Imyq8nrijqRR9vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3970

On Fri, Jan 26, 2024 at 03:10:49PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > +		} else if (pol == current->mempolicy &&
> > +				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
> > +			if (pol->cur_il_weight)
> > +				*policy = current->il_prev;
> > +			else
> > +				*policy = next_node_in(current->il_prev,
> > +						       pol->nodes);
> 
> It appears that my previous comments about this is ignored.
> 
> https://lore.kernel.org/linux-mm/875xzkv3x2.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> Please correct me if I am wrong.
>

The fix is in the following patch.  I'd originally planned to squash the
atomic patch into this one, but decided against it because it probably
warranted isolated scrutiny.

@@ -973,8 +974,10 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
                        *policy = next_node_in(current->il_prev, pol->nodes);
                } else if (pol == current->mempolicy &&
                                (pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
-                       if (pol->cur_il_weight)
-                               *policy = current->il_prev;
+                       int cweight = atomic_read(&pol->cur_il_weight);
+
+                       if (cweight & 0xFF)
+                               *policy = cweight >> 8;

in this we return the node the weight applies to, otherwise we return
whatever is after il_prev.

I can pull this fix ahead.

> > +	/* if now at 0, move to next node and set up that node's weight */
> > +	if (unlikely(!policy->cur_il_weight)) {
> > +		me->il_prev = node;
> > +		next = next_node_in(node, policy->nodes);
> > +		rcu_read_lock();
> > +		table = rcu_dereference(iw_table);
> > +		/* detect system-default values */
> > +		weight = table ? table[next] : 1;
> > +		policy->cur_il_weight = weight ? weight : 1;
> > +		rcu_read_unlock();
> > +	}
> 
> It appears that the code could be more concise if we allow
> policy->cur_il_weight == 0.  Duplicated code are in
> alloc_pages_bulk_array_weighted_interleave() too.  Anyway, can we define
> some function to reduce duplicated code.
> 

This is kind of complicated by the next patch, which places the node and
the weight into the same field to resolve the stale weight issue.

In that patch (cur_il_weight = 0) means "cur_il_weight invalid",
because the weight part can only be 0 when:

a) an error occuring during bulk allocation
b) a rebind event

I'll take some time to think about whether we can do away with
task->il_prev (as your next patch notes mentioned).


> > +		/* Otherwise we adjust nr_pages down, and continue from there */
> > +		rem_pages -= pol->cur_il_weight;
> > +		pol->cur_il_weight = 0;
> 
> This break the rule to keep pol->cur_il_weight != 0 except after initial
> setup.  Is it OK?
> 

The only way cur_il_weight can leave this function 0 at this point is if
an error occurs (specifically the failure to kmalloc immediately next).

If we don't clear cur_il_weight here, then we have a stale weight, and
the next allocation pass will over-allocate on the current node.

This semantic also changes a bit in the next patch, but is basically the
same.  If il_weight is 0, then either an error occurred or a rebind
event occured.

> > +				/* resume from this node w/ remaining weight */
> > +				resume_node = prev_node;
> > +				resume_weight = weight - (node_pages % weight);
> 
> resume_weight = weight - delta; ?
>

ack

~Gregory

