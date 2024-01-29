Return-Path: <linux-fsdevel+bounces-9398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA87840A79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D752C28C5F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF0154BFA;
	Mon, 29 Jan 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="0Eg/1de2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97B15531C;
	Mon, 29 Jan 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543340; cv=fail; b=Ugc+juduCBLQE1bPCW2ZNLRg/4j0NEYN0EX6J5ZoJd6QEKheC/WpNxySF31GPQfo6gBpPaT3b9HmhNe8flDIpyu/WA8nVfBNSQ/ZJ6mCDkWXopgBvv2cmfeRliF9CuGMSfzUo4KGuaP1ibfgvyREX80fJr2HcYB2WHfJ/0B+vwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543340; c=relaxed/simple;
	bh=5G9pVet5oAyYXbNTF6sRgdiJKHUbhS6s/TOnDJ1hctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcE/up9++Mh7l+E4fnMjOtN8Ab8jjsQyhTTHaVEgICTndTqHfV9Kh9h4tP5j/e29XJNZbOyJdsO2MsPVmFGtfpwCIPhkeBInYtoDsGB5DDfPg9kL9PbZKk1A+T/3yfOnZcTwPBINJSkV4RFs6PRvLhWUFzyrnvYYrXAGaHr12O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=0Eg/1de2; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkzeT1f2YuMA6yJNHCCVWuoCJxKOIF3Ee9jcP8/L5r3BROX5yiknGHRc2ly3BaNxwj5sEuRhj9MXLGDFDOtj1DG+Kr+qIN14+RGrz+yMw371aC8FbWXr2uzUFPZhJUgSkC/80rye2eVVOL0H6Z5ElxSInyYoiAGZVCRLUE05lK7R32ScaWEMz6M+CYCK5DbD7cNdMWoast9eP1kVFQhMe1mikiOcnaJXK8iDLsr7RAG1DiGyokrixAY5HseIGGIaCIbG355GbVRYteJPotNQmMRlSYbZgbX2mMtkcmoskwo0PapOFmbUlWGLpJ7+K+dVU3a1iixYlhCFNcU8mPgStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmHQ/R5uh/8YvjKCi0vlntmngjiN2NtR67L7NkXvhvg=;
 b=RbDgD0zHYsHwzs5fRLsuOxQteYUG5dqLvOPhl1lgJ+XGEWrq6gxqogo1n1l9E12lQgJf2iVlZYoOzqWBrdHZr4awqem8KPZqr8Sj/uJLE0UxTCuaKE4f1BUSCaid6cmfzmu3vfiJ6YYvmh6OZfo7wQhj4qjyr3JraJV77GEToFmd0GBCNgEl4h2s/MDevTxKlpKdA+jEPC9IhgLi6U7eZ0B5T9cBjKzzXwZ/mKoOEiBf1Dgj3vQhd+jsr6Kg9TAu8MRM13XUQhjwjzbxfW7T/mEYoPglck1JwZOocQRmfP7TRZQ4aUu1wAgM4CFpzJDOE8jxH8+AJRnnJXhRfg9VLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmHQ/R5uh/8YvjKCi0vlntmngjiN2NtR67L7NkXvhvg=;
 b=0Eg/1de2LdFZedY6hoRHqSRKWGIOxQaUEbe2VZtczfcpOvD8CoPRv6ZlpaY+hyrkK4sm4AD+E6d8qi9UVqSCVU6Qw8BHYiyFjyMFdzKFb2Mwifrd1ybM+JS+x0U/7gPT7jLhS7TKBRrz+uV2uCvDt27C1c5W6IBQ7I5HTWqoR2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4303.namprd17.prod.outlook.com (2603:10b6:a03:298::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:48:55 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:48:55 +0000
Date: Mon, 29 Jan 2024 10:48:47 -0500
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
Message-ID: <ZbfI3+nhgQlNKMPG@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
 <20240125184345.47074-5-gregory.price@memverge.com>
 <87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZbPf6d2cQykdl3Eb@memverge.com>
 <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d86384f-02a6-4814-a6c7-08dc20e1ccaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ose/SujTTFN5DwEaWaJVFyWkoIcfcbXmmELCvqKGbG+9KLHvebP0oV6Ee/dGZYKvcTbNiSO67W0NWBcCk+/53jboDrdzTRtXzlSIB1Ek/jPtQMcDE/tNVtQNibmekJoSEM7xoWiKAS/+8zvmgx2QL/XNCxWn0sQBwMeb52agJBIusv3F/dSGVRLrn6aiQIhtCEMX36jHpbFXprL8kk6Z9dcUR4EKJPteoG0ZqS3No3BloGCjaSsyK9KcyvDtApucnIPM3Z0kC+gHXB8ozZnsO5kiNks9trUqM4oNow7GMOdSRIBAWqt4NWTOXpyzToAiKaxnlc6PoLTTq3jJ/R8jd4lB8P9U8sl1HvypDpSzKRWSCKScmrXR7CTYDwY9W3m9RTwy3owASgieYXKulodt97BJNgt1wpm6xeCRVHXjcPekTHaOnAExgOql4ggY+1xl/eBYS8bkI6XV6sIjwq371Xas189Q3hZYmJiodibyyz7MJHDLRRYx93YkPlQHhte/jd6mie9X7JD5sXlGMfNNIe2AQE1+gkrSAaf5B0aRJ8/dn2Kpzrh1+y/i2PzfBlmwg3Uzymc1PA2AkGOdCdF1ImwAiXCvdrpTSEL3J5SPqgGSF6jYn5f8mnfAxlW1K/YdMuvnYO5CUdP69O1md805zQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39840400004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(38100700002)(66556008)(6506007)(86362001)(316002)(6916009)(66946007)(66476007)(6486002)(8676002)(8936002)(44832011)(2616005)(5660300002)(6512007)(7416002)(26005)(478600001)(6666004)(2906002)(4326008)(83380400001)(36756003)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CeuUms+e7X+eFBk+MoNuTCY6oZj00nJnkDfuYDldeKdXQT+Mt4sRnh8EPAzq?=
 =?us-ascii?Q?I9xhKd5uKHdCwiPebmwKAvUi2Aef8CKKb/7AYbigNTh0aQHhs4PHteuM/nzo?=
 =?us-ascii?Q?KPcF1Putt0Byd2qpWyOu2XCmLrqbJcWsnu5PPgg5qRDPPAn+lUmDkm79dCps?=
 =?us-ascii?Q?IeSuhNSTUCfNPhXIi+GOYfChetUnYCLgLyxnCeTO5zaxunhD2wGOG2RMaIFo?=
 =?us-ascii?Q?XpChrxRVZafpYjXmQpHVuK5yuYRN5vpLiWp2ZRXqJfSsj9KEpCBl3yL2oDEd?=
 =?us-ascii?Q?tlQYI0d92twUzu+LLICS92sCpQUk4BclOulxTgBKtcl2wiAuOD0RNMe0RXwj?=
 =?us-ascii?Q?FZ1A5oKm9r9qr0B2BCrWoj7m41lx90GZAGWvjOShUzg7aTvIkG3Nl/ic4bk3?=
 =?us-ascii?Q?F2hEshtnVz6clk5DfbpC4aqIkJ8tlYPh2e2atzajJlbFZeoAZpPlIIkHk6Zl?=
 =?us-ascii?Q?rZr7wi3bSsm5HV1sHKcV7syCc4Zifqrfp0S4CzoXPxXya/4hcNeiVi2IOGGY?=
 =?us-ascii?Q?Hwmq1U3EQDgDrB8Vb6ipJ4y6qXIIlTZIuMjQsyQMw69F3x1MPH5c2LPYS36P?=
 =?us-ascii?Q?M9XS3cE/D8FzCqTKFwHha8d7s6CB/Xz4iCwtG+0FcWgIhFVmyuQuicwFjOM2?=
 =?us-ascii?Q?ffK6LALB35X3tirl3ycG0MECk0zYYwwqcpBrD3tMDRGPf1pm1QrDdixZEEFg?=
 =?us-ascii?Q?BvkdePgDatugXXKtCMiK3jssR+crNPlLNG5C3NDktmt63vdSQB6ykuCLyYDU?=
 =?us-ascii?Q?UnxLNmFI0/dXkjXYUpM1jj9+x2+eCNeq6NcCcpw0PmikHEq14s42boKtSNgU?=
 =?us-ascii?Q?RByRw4YSy5g5sClN8bFsRCEoSjO2rbaTSF/TGJlWD4m2GZu4almb3TxRDBzt?=
 =?us-ascii?Q?a97GQ7aVJsTA1qozNNTv97m6TBQKAVo2lmzcZBDtR+KCP9jVHd8V2E1/lkIi?=
 =?us-ascii?Q?eb2jYB/V3QaHTuMrZnb0B9d27lIfrChDo84u4q6io/l0JG5wr3/mKbRY16xh?=
 =?us-ascii?Q?1lN1Ow9lYhTTPnaMhQgk4Rd1t9698PnBcpSqqDHksG/t0APwCSKygkOF+Jnb?=
 =?us-ascii?Q?OialfFzKlQDnoO3pt6bCRlOvpzNGOldSschRS8k7Vnib0iCmEL3iP8oQ35a3?=
 =?us-ascii?Q?TqGk5wMzdfARzHkFRBkIBI+zvkWE+D07SoF3FNhW3XeB+mslHqqzlPCdOzd4?=
 =?us-ascii?Q?vC2gqKD2iPC2s1gftZ2s0UQzp+ry8Ed+gHwPDF6xG6hcpZQ4HHDQMjs5h+l7?=
 =?us-ascii?Q?XjZvBdNDLGIm7Ooj3dtEbhrr7L14tDP6X+KEu7l5hZWdzXNLUITeW4EtPR/j?=
 =?us-ascii?Q?hZgnaaq8gORZpIMzdMwPaLvy7Hs/WqsNzBwxYmmTRJgN5AlRWt/Cs2hYuaww?=
 =?us-ascii?Q?mcprfHAIVDRq/t7wlD9kJxP5lqpBnmzW+aMhs6FAebXCxo1fBiav+qPNJz5+?=
 =?us-ascii?Q?cJrofY3TntvZp9oMX1ATjdqpfN+Yo6RtXETaHCnIcX5N0zRhNgThZs9gKyfU?=
 =?us-ascii?Q?CqDWG97RjDxWEIWkfqKpE+CDJaXRLYeiJDZfD4xTeLGNXbfFI2zFi1bIzpZz?=
 =?us-ascii?Q?WE1badmujGsrg1wfd7jr/t+LuG96Up3/1SAiVhz3dOl/Ei4pw3K8QwwFBQTn?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d86384f-02a6-4814-a6c7-08dc20e1ccaa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:48:55.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzy/a/eFjFCdFOetbcN0/zick0p7FcLxetEhpcRpiEwP+aNmDXnki+71EvYqbBeJGNN4JIxRAO3FRcwp9TOIEkk0mP+UX8RkWWMhlQvYYF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4303

On Mon, Jan 29, 2024 at 04:17:46PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > Using current->il_prev between these two policies, is just plain incorrect,
> > so I will need to rethink this, and the existing code will need to be
> > updated such that weighted_interleave does not use current->il_prev.
> 
> IIUC, weighted_interleave_nodes() is only used for mempolicy of tasks
> (set_mempolicy()), as in the following code.
> 
> +		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
> +			weighted_interleave_nodes(pol) :
> +			weighted_interleave_nid(pol, ilx);
>

Was digging through this the past couple of days.  It does look like
this is true - because if (pol) comes from a vma, ilx will not be
NO_INTERLEAVE_INDEX.  If this changes in the future, however,
weighted_interleave_nodes may begin to miscount under heavy contention.

It may be worth documenting this explicitly, because this is incredibly
non-obvious.  I will add a comment to this chunk here.

> But, in contrast, it's bad to put task-local "current weight" in
> mempolicy.  So, I think that it's better to move cur_il_weight to
> task_struct.  And maybe combine it with current->il_prev.
> 

Given all of this, I think is reasonably. That is effectively what is
happening anyway for anyone that just uses `numactl -w --interleave=...`

Style question: is it preferable add an anonymous union into task_struct:

union {
    short il_prev;
    atomic_t wil_node_weight;
};

Or should I break out that union explicitly in mempolicy.h?

The latter involves additional code updates in mempolicy.c for the union
name (current->___.il_prev) but it lets us add documentation to mempolicy.h

~Gregory

