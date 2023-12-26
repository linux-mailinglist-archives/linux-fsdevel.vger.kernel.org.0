Return-Path: <linux-fsdevel+bounces-6963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2781F087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D2B2823E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52984503B;
	Wed, 27 Dec 2023 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="qQeefBJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31A45026;
	Wed, 27 Dec 2023 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oknz5d5J98lHJAQTx6cG5JRqITBt4AAy92CMOBXxlBYstwDFDtjlujRG9e/pxP6wzqxCmkRfcSZXfaU9LmOrLGDZ1g4ZO1x9phlspegl2JRG+lO2fXnzlwEaNIW/CyqNSGTIR6zK0Awp/BmSk1NT5Kj3gf3tr++AxyUKFsWrImO2FakMlR7ggBClyYAviHd5rfh1cRG7wWfQ+4NHLkybl/iYrey/fLMdDFxDK9BX39Qep2S/5UFgPlyKm6KNHxrISAXWQMTNqAIA5nepy3Kp625n42GLArfqoilU4CC4VBhEeFYfQmmtLEcVM5f0Lf9iy/I3bOj2xu4cwqz6AuVSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIJo9Ct4jBIJ1AVfs3m25acIbzGYsAkqBsjceiMrTHU=;
 b=nNVH7qL9vE6vCX81EHYGmBL/8XTTXjTLOwcaBEO0O/ZIh6iAsiwduCkBSwLHJ0W1wQPN42SoOSUw6dcAPctNK1t1qa0fuG+Gy4a4cmhzE+I+sZcRaMBYH38yhtcYEdNyse8zPmeq0KyVR0rXdzkwruqkp70U25lbJOzKBAZPkqe535Hq79Sf+qT8RmQ+EZdG5fgzyLLPsrvUQIwiP7z4cNKDua6oGHL7wiuwpiNvuLQq5qnkDu9xIq7Tq+zfP7BbP65aH5yh+9VOc9z9Jil6id+1WFal4M8MlCF8gT+GSjup6hlGYi6KmYf8iQHm4mQH3hxhMNzza+Kch+tAO+qaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIJo9Ct4jBIJ1AVfs3m25acIbzGYsAkqBsjceiMrTHU=;
 b=qQeefBJmwNmSeMWkP7SlB2Tym03gFitlc/KDw1wYZ3e3gTo8Z/+m3DlB4LCHak9Jirdjcx/zhq39fBmDE2BL3WqL6GcYV2YYjyp3nkcdhGQ7j/9kUbQsA5RaAii5IQmjr7YvsY+tniS11KZpuoiSE2M2LQ4FV6gunLbGQEZA11k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB6007.namprd17.prod.outlook.com (2603:10b6:303:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 16:41:22 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 16:41:22 +0000
Date: Tue, 26 Dec 2023 03:06:01 -0500
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
Message-ID: <ZYqJaXaFCKvuwu3H@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-3-gregory.price@memverge.com>
 <8734vof3kq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp6ZRLZQVtTHest@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYp6ZRLZQVtTHest@memverge.com>
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f121a5-d16e-46b6-8970-08dc06faa8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RR2mG3WLgthAt8fOfDfZS4nGAKw1esUciI4LHk9W8pGrH0m49ZVKlQPKZr4sPs8NYagAtKxUi/HzO7Dfa/Pat2xtMM+VTH6m1jkQ29ML7JFS1pHmF1VSh3TntY2Pv0umDSPujCIwVUSD77Pm0SzFF1v2VNIzIdCw7sQleV07KUvLPlVmECzB6HEjpZGxzAURUh88dO3G5B0dk+rqVcUeyluFZ2c3UrpnOz0PfLkNEkqGXM/lD/O+LGzFVgiV9nPQMXJECSJzuuc+K2BwUabH7smrLqG6oPAFZUTbxkz2Mn82qVfmytmfNVngpHh5WRT7E3Kk1MzmGOGssb7m9U6wpQiQk/hmC5+sZJsM0lVM5P8tLrwf8P/jsEmOasIThwTjiV/EbNuTlAOTt0GNWIBK4NE5TjItHH2KAJojaY9F7yJLOx8jZj4DYILTfu6/jn6uej6Ghflvfo7WcZWiMJUMLYDsCGE66600ZXfkYHKsJzxwouF/czlx4+VrrxN0d5xGwMz2aYG1pXRW0TbJbDzowthPCqwy271YLZZDXYsf0jH20sMYFX0vXzHw8noc0RwrrxRO6rvyAN/Jm/HfDBGhRywrQNuzq8Teo8qgADltpx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(2616005)(26005)(86362001)(36756003)(7406005)(38100700002)(4326008)(8676002)(44832011)(5660300002)(7416002)(6512007)(6916009)(6486002)(66556008)(66946007)(316002)(54906003)(66476007)(478600001)(41300700001)(8936002)(4744005)(2906002)(6666004)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pzzh2MKzW2aX74emyV/M6UMC4IO7gXtLA2f55978OhecDq0SoPiqjuc0YOjc?=
 =?us-ascii?Q?eGpOuQONKa2BGdY2cAvXItTMjTXwsHcAuTFr+sraELL4us8AZWmodUgK/QlE?=
 =?us-ascii?Q?sh8Cwc8ro9mkvKAW4bcZ/v1gvxQZiBHkelJHQVh6GtyUCDs6JmPu367zYfbS?=
 =?us-ascii?Q?J/L24Nu9KUHQS0KHMLdEX/ZSbqX+z9JgJojCDntTadTOyNRj/iqY1S65LQ+W?=
 =?us-ascii?Q?rLLKMA42/MrYMHXxaYpFZW/Q+gfZRgpMNhbgIm+vuzABxqNfFTgrht2jaU89?=
 =?us-ascii?Q?OoDnAGFI8Nxe+D0bNcbaM8RgLyxI6HPHTAKIMkquwdd6Zd8y9TdhW3LQD37C?=
 =?us-ascii?Q?r+peQIgT4AOmODXZcfm9H4vs+59l9sgJOfZ3LB8aR7/u0XCM8xWpYXW3GdOs?=
 =?us-ascii?Q?OAMhbLFpJtP28l/W3HC4ZyS9As+R1b3D9O40yU3HGzSyBKzN0xq5GXvqT29X?=
 =?us-ascii?Q?NCSX+s5xRbERqjlGVAA9kw06cjw7bN78VkxSRH1dyBJ3C6nQDqBmqaqa0LRo?=
 =?us-ascii?Q?ki9dcqasnMtsgeDKhy7MQgiz0t8EgZjTR1FiM1YEjDJAsCtKdyctE5NUv56e?=
 =?us-ascii?Q?Bj+swfn2edvobkJyF+Iy1umbAu63ud8UEyjS25XLhE7TQZH8jO+syVuY+rGt?=
 =?us-ascii?Q?sEMQh4h5uOF1+8wZeySf91kT8Ab2NgXLMVKLlLLk4h1h1+shR8eYtz1KqYm1?=
 =?us-ascii?Q?itnKBrb9xrRoEfco3zWogThvLn8yR2seRbrOfSTHSNTpy5/OTk59dzlR3UnA?=
 =?us-ascii?Q?Z19BUXXMbLivyW4uS426GPrEaqhMVK6vfn4kzUe9P15Wx9HEGW/wR/4z4sT6?=
 =?us-ascii?Q?+JO2h8lQ2lTrsNdO40QD/aF5zvPJFESoa5K/7lKfqfmKtupcejlathpF9y9q?=
 =?us-ascii?Q?TW/kZkqI+ON7TJLrrkoUsl0HzCZt7Ps82AnOY2PIqT0PP6vsutEIjeIHLD4A?=
 =?us-ascii?Q?8pOHgpYXbUF0Wr0eRLr1Rnod2H0WGUZXu1IuVJDHfu25zXp1vGVaxDXfq6Pd?=
 =?us-ascii?Q?M2oEUwKIERqydqDG90q1WWQAVjaSpjjKW/dNEKpLBxNYMYwy7r5Sdc1CNcLD?=
 =?us-ascii?Q?FnaKJJ7XJ3B1u713GdxwvuJYOUc/MqsDWIXz82ittKn9aI/2asf0beyXCIE9?=
 =?us-ascii?Q?4DqaaCxaQEDjfgCrMGlsaaWgDPFzZFtZ847TtB0EIm0idkuz6FWCTcJoBGYI?=
 =?us-ascii?Q?m6tByt3GFtgTn5jJ9Sdm0/Xo3WrJzZxZQWub8MUMu7/2lyQwGICSsBG+jOIz?=
 =?us-ascii?Q?pYCmq9kmzzGljrIm7PAY319FxH4AkO2OP4JPuGC7wyjEqhA4eFdz4vSu1VGD?=
 =?us-ascii?Q?ANZqVtFD5jXM4R0pSIkHNAoE8Jd4zmMWuVXudY5PUm9wwybd+5DvcH2AhCKH?=
 =?us-ascii?Q?GzG5ZCf4pPr6JlxmiT002Mvc7Xd3+/8IKcxSfhsBo0RIao/U6mUA5WXs3CmB?=
 =?us-ascii?Q?Sk1VFLk2zeDC5HhGnAx25wyd/jU3R7ifQ4fK1mVkOpWff0U8RWDnMAi6FiVa?=
 =?us-ascii?Q?zFa1k/kDcn/Rm8qOLyMh9yDXawsOBvuFlBi70fDz+nCog+v83pQ9NUcZOtNX?=
 =?us-ascii?Q?JmuoRHdu5YYSf5xxpSUtnBvGaa7DPjxIVFZPTRo8wdbs0AGhqpY1FSJIY/sO?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f121a5-d16e-46b6-8970-08dc06faa8ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 16:41:22.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwTWaCspUqQgzHzOiXY8TMnvGftm6jmGck3EemkC25b4aLCVqPTrsmV+nPdOqifOD/c0sQvYLXiFfVdIfwmtydO1U8ZGOHGwdBOe42h8f9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB6007

On Tue, Dec 26, 2023 at 02:01:57AM -0500, Gregory Price wrote:
> > 
> > If pol->wil.cur_weight == 0, prev_node will be used without being
> > initialized below.
> > 
> 
> pol->wil.cur_weight is not used below.
> 

disregard, i misread your comment. prev_node should be initialized, to 
NO_NUMA_NODE.  Will fix.

~Gregory

