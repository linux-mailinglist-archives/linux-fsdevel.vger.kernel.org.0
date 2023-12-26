Return-Path: <linux-fsdevel+bounces-6972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86081F1C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 21:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7351C22404
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFC47F5A;
	Wed, 27 Dec 2023 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="eLM/2AZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0447A4E;
	Wed, 27 Dec 2023 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ0LdbOhknycNV2Kn4h9fcK6KLkNqT0G+WnTkMM/9F+bgGP4f9/CYPQ2/UZSdqqiEpmn3YYzB44n/1t3rJZQFQI4asu8h+HAeXc9WqoFtt9b+pZ8YA0UGPphep+Ko3OeGm27PpMAHnYGmo1jrjzfsuWqeV/B19rrhoooloRco3vhRR0cmqqQuvl5b5WTA0LuoikHp54Y5FI2osim2gwCTD4Vts6YoY8m46YkjeJy7/QmLPZuauMXBbF7U/0zAKpObEIWjA89jFY3q0r246t7VrUqzOgNKyoRoAM0N4rf8+JXnjvBLIIBYWhGYKMok3hpJqxOnG8b/Q4nBxHWzILiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mqZ9GUrVivXwKJL1Ar1SgstFRRf9UsTvA7mW+n08PQ=;
 b=YEF6YChxcyyhsVIBN5QCzziywM/zq2vv3E895D637KO8+/AiJdyfqFZvxSTxzMEv2Bd0jdr+8SIt3gELRVIP2k7ZwaK6zEaptnII7hIHasXSEdKCnOmQwHAIjF51+OmsrH9s2w9+lsad4pTmLSxPZYiZWNxbNFA4MYljMh1RhxBT+xG2e6BGsQBFZvEIaWcIwUkT1IRBBlHLh67T3bQDLaXhENd2ZcRBBsLRPHAWa6ZgBTuOCF9hlKKPrEK24e8oWCtqoEutbJPMrmeDzx5DPd/rS1o4USFvtDU2kjzVoDjfr0R0bor+DxKTKwH7qs5gHpfB8s3otVFyzmboiGs4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqZ9GUrVivXwKJL1Ar1SgstFRRf9UsTvA7mW+n08PQ=;
 b=eLM/2AZBmDuhcGUW3aSRRZwI62YWWjm5Kl5UK5tyok53uepq3/fOWy0p0TUlNRkLN1zRB0gH1tY6z3hNT6KCsl8oWeyTKxIpehCG8v+ebnWHgqZDejGdD5Skz3GdR4GEi8UYnXrbgXCXpLe8mab5m7DaPJJG57mwSYmXpdnXNDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5557.namprd17.prod.outlook.com (2603:10b6:a03:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Wed, 27 Dec
 2023 20:06:44 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 20:06:44 +0000
Date: Tue, 26 Dec 2023 06:48:34 -0500
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
Message-ID: <ZYq9klTts4yg8RhG@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
 <20231223181101.1954-4-gregory.price@memverge.com>
 <87y1dgdoou.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZYp7P1fH8nvkr4o0@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYp7P1fH8nvkr4o0@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9240133c-ad2a-48b1-0e87-08dc07175907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nOwoOGkQ9rpy9Hbz3FQj9I9gcl9+/ENmPvacqq/Hpl5nbeAX2mMbwKXGhAazU/t/OdkqEcHr/eBhmXtR3p2pettmm9sQ/rbUXi8WEtkQjF3zywD2sFhgf2sO6r41FsR3oLEuv2FBXumlMIwvSBRb0hh5ZS/jXls4BI0nZDYMB6F9LWw9WNey6vTH2j/hvgl9pxZQEgGmXljBjmkHSQQWVeSgpKtdrTbcesSiDcwTVZcKgu/al0Gsc9t3bvrU2ldS7IBF8I/5Gp9MgOZDBcCNbH/3h3w79ZWokkFpvrYa1TgkMOSrMNLJt6cM6CaPAT1zGkKOExSz5WjGKUK1diyRgNlE0Zt2VMtF6R/9T4JFJXf682/RRfFnW57uJbLaUYOyW23JxhezNBaYKHPU3YsdzUfrPaDYaq6yPZwLaW8iQQKh8HCCNpDUbMiYbpB8cDtXzpSYRKEStAJnB8UmLcM50p9WpccJfxKpgxZoEZqxnODC9hH2tX+srz5Q0gHaOOBsdF7vtHQteOdNX2k9hrOXKA/iIsvPzKOdrJ65/FXLEGlB7HeJKDfeOuwjmo3DgOV6bSFm+DIKVdNsag78n1WO2rSG6nw7Lv08PZJJLAYvZ+FNjfUpEVbQQlEGyO8NvVTX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39850400004)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(6486002)(8936002)(4326008)(478600001)(6666004)(38100700002)(44832011)(26005)(2616005)(6916009)(66946007)(86362001)(8676002)(316002)(83380400001)(66476007)(6512007)(6506007)(66556008)(7406005)(2906002)(7416002)(5660300002)(4744005)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/3AInaXmXZ7xvZbMWxN7K6GudR3mdt56bOrVs0xJTPL2CWgVGjCrZHeVQpV?=
 =?us-ascii?Q?7+PEhMoCtNkv3Wnes5AWH92Cm8Ae64Obk2t4UAQbvCnzPbyLxaQKYmDE2xsG?=
 =?us-ascii?Q?I2eWf+tsLbt8xNswnz+TKYgz9U16Ke49inAWHGs6kwmXIL6TjpTAXfQW8jCX?=
 =?us-ascii?Q?vSXLPbuHNgU4Eho1JN6PkptCvgz0c+5oYnfCotxfJd0LDraxzNFkthWQbS1G?=
 =?us-ascii?Q?Fb8LFfN15h/Shgmvuc9bX7P6Kw9u0q8jIAtL/qYyEO+X6v+Qond9Hnjzqoih?=
 =?us-ascii?Q?tPqhH9A1mFOV8009ijHDktMHFBD+Kurhxdn6q2ENuWIkCnf9qompro7FXWqz?=
 =?us-ascii?Q?g7r+IXuU3N38/VIH2MvZwDXP4ZIWu94TxkUut4unLqEIHQmTBjxXBZbb93OH?=
 =?us-ascii?Q?JMNHobEquVX9c1LAT05qs9OvjWBOnBVmvavUZRvMOnGwZWWoKp2/tG7ikPhC?=
 =?us-ascii?Q?V/V9UoZx24bP5dpUHdpp6OpVG8bcrhu3fPSnaOmwz52bRzAs9eA/WDldVs/R?=
 =?us-ascii?Q?IntcvJ9awkH0iUSwucO9qULgLzHo+p4zOrP/5tGwzSPSmBXzJCu1wgcce2ze?=
 =?us-ascii?Q?cLlG+58buNmm+bhStgaqOOcnmQit7vHJMgRFp+CVER9bGaEW9Cv1FWLUdAHd?=
 =?us-ascii?Q?wTZi6qSGYuMy+FZ5vCKVv7pBznLZcxiUCTMZB4Y/m1I7/5qgE8kazCTJLpmR?=
 =?us-ascii?Q?upzYGSKHrq4+tSOqncRfVoge6ati3K56p/T6jBKfVcp8qhD4Ya/u/avErlrD?=
 =?us-ascii?Q?PB2u9C2dR8WRs9vQOnY2ZP2C75byu030OH9caBdobAiGxJ7t9NU9jVHv/LNM?=
 =?us-ascii?Q?h1OjPsW15ea6xHD+WmYWjKmbVkohMsTv0DGgh7ATx8ewIPxQXtD12FwxOe5N?=
 =?us-ascii?Q?pxd8pVPhg3Th0WnLUGakNZ+l17H7AsX8EY417jTnDhvUhlL6HdfbUDFQVJ3d?=
 =?us-ascii?Q?eBOAx6QYY34ESijvbFm32LX7gm3lyBd77Lp3hevhNLazOt6TNpLFoGMkNLIz?=
 =?us-ascii?Q?1mlw2t77MFB2wzrtJJhAYb1ziFJ1jh+EPYz2sqaw7U779dQIrpwz/31uqUu5?=
 =?us-ascii?Q?P3IM5HjZ9vLSzktWLAKhxo9YNoX+ZAOvGyT+nEOvacp84VQ+DCxM9+NabVHu?=
 =?us-ascii?Q?fw73hYn/vA7vhfmcHRjDl7O1JFXlwYI8nBSVG6o3oOnDRTN3OK4D/W4Wowvx?=
 =?us-ascii?Q?dqoEqBIF+B04z1r0fkdHdcyBe+jXAXmv+8TAjph7HkXNJa4rTcq+RFEvniC4?=
 =?us-ascii?Q?Tu35LExoaI1R2tDFZpCGxbe4Gja0hjY+BM5+OCD/8AYYsBGqTtQGJAJ0F5ur?=
 =?us-ascii?Q?MP5U3ToF4vwjUb7f5dc/m8nP08UvJkMTS1vXtX/B6fZ/Xj9ZOlHSTPovql6Z?=
 =?us-ascii?Q?VXLFiq+RkR/FUWtmFrVi5bFP00//N6Abys/JyIVbzs6cegeTIbKt2HjAWI4F?=
 =?us-ascii?Q?Gk8tWuugvBNvYcRMVDY/RE7LCsfRf1XuxBOYSxGFvdy1/b9PuiEJWF7yJBhW?=
 =?us-ascii?Q?Xo8snziHLpVb2zQ6YohgPWl4KtCcdA3sKZO7ALSXufykzMH0Wu7AEWiOIwRx?=
 =?us-ascii?Q?Y+6klJn7SrhOrwLbb84yYdg4YkkORT8MCKKi+4Qy4XPe+tUIgUdZ8vPQ+BCA?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9240133c-ad2a-48b1-0e87-08dc07175907
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 20:06:44.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beeW25LLMbz3SOuU5qIB4ohX36Mxlu29wurzwW6THd4AmAsZ90awEMAXW74BK3DoIPHWEd7kDQYRse++sXnRS9rFqz1WrHHnwItjw6Akmqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5557

On Tue, Dec 26, 2023 at 02:05:35AM -0500, Gregory Price wrote:
> On Wed, Dec 27, 2023 at 04:39:29PM +0800, Huang, Ying wrote:
> > Gregory Price <gourry.memverge@gmail.com> writes:
> > 
> > > +	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
> > > +
> > > +	*flags = *mode_arg & MPOL_MODE_FLAGS;
> > > +	*mode_arg = mode;
> > 
> > It appears that it's unnecessary to introduce a local variable to split
> > mode/flags.  Just reuse the original code?
> > 

Revisiting during fixes: Note the change from int to short.

I chose to make this explicit because validate_mpol_flags takes a short.

I'm fairly sure changing it back throws a truncation warning.

~Gregroy

