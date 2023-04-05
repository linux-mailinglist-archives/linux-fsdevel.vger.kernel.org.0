Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA316D7287
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 04:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjDECeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 22:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjDECef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:34:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56710D2;
        Tue,  4 Apr 2023 19:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moH2PbKd5mnVs8PX6ZZlFM49EkrL49Uln7PoPRnIgy/U7boBJxWzUQSIGMcshjvBVb/MZTvXDGvwA9XZRthivpPY1YBLSD6R/QIfs49SZHfTseUKYYraXNXVdchEfO2T4i1ZMU+wCicddeXyVjlz53qNfVFZiZ0/4E+atknOpoAbP8xzk4pm7uRjTT7/2C2I9LdM8GIXVe4AcygtY3RjXYYwUm8JmILcYsmH0kGJO2XrgFrA0cnegAhqzJq5mAgni9zrskVJu/5T3kBeOm1BaxNfUOSsNmM76zgN21tCc2x8rp4gdolWOCOfJHdhq7O35i3k4poV+90fJBUvbyhr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/BY1NuL4idsBwr5OL0VExb/Nfzlt6t+15EhJt1x6Kc=;
 b=A/6ZorL5rGKDhcylSKusFN3xdYWvwzaywluRmcbuu4yWmyOwh6DYSFkbHRPq45FmTqyKD+ddfRUlxBbbsqdojRh5zVH/LIjG8rqEEE0iwz2vmlbYkyS+Aa9s5fE+UFQonMh9kqSh9MNlm/2y8RJq77nOd5XoLcaWjKp1zI/p1uoYko4YdXbnYegkIOaBLZ1w9zsEz0zTmjMISbibIv1T86+Km0g2HsjyOVmRvYxe0cz4UQ1lS7O2IOcB4kbQHYNR2t5QQmIgDkbzGbP5iVeBcZ53JSAwqrEZXybc4CSphOgNx5b1aw/mdJVwpBFBU50OvQ5csSXZSguw2pQ2aNJ3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/BY1NuL4idsBwr5OL0VExb/Nfzlt6t+15EhJt1x6Kc=;
 b=ScQtQ0mFOxvsh0xJQq6+qt6XKc+tNrki3Se8gtndBUIxiLy43q/FdHwLhvLrjfT7TYH/tf19vxNtbo9Rj7k5vWNxewRHzslwzhtKsB6nqeNXaam3lfYhwv4V8mC+CSfOTj2XAGVV4Zky3+1GRfgRLewnM0mg3CJNk+ziLyKCRwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4285.namprd17.prod.outlook.com (2603:10b6:a03:2a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 02:34:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 02:34:31 +0000
Date:   Tue, 4 Apr 2023 22:34:27 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Subject: Re: [External] RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM
 changes for CXL
Message-ID: <ZCzeM7IUehlrWR9E@memverge.com>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
 <ZCvgTA5uk/HcyMAk@kernel.org>
 <20230404175754.GA633356@bgt-140510-bm01>
 <ZCgMlc63gnhHgwuD@memverge.com>
 <D0C2ADD0-35C4-4BE4-9330-A81D7326A588@bytedance.com>
 <ZCgasNpBjtQje8k+@memverge.com>
 <642cb7ec58c71_21a829453@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <642cb7ec58c71_21a829453@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:208:329::23) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1781f2aa-fae5-4cee-05b3-08db357e4936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZBocbqeyvAwwbifwIYCpjVKFTA+dEx0jwigDFjiQ0plyriaT+Rvuvh1e3DN0ETBNmZYuDOxOVATI6W9BXqcTlVkRKpv+rkU2kwB6V4DXboSRfhDuWPS8fItl65y4IuNPf2QmhFHGxREg3F8CQncLlEpiVaNB2mi77rMjdAQ8c3VfbVpf1XkjIE52RTDf7H7Pt4pJ/Qu9V5XtSOrAWhVuZOuxdUJK0RtzmmWgIvy3a+B5bIZmvnKmfoLnXCaGLJinlTPodcHf+JQkjpCoyC4RWIDUYRaRLj4t5+PVL2cVY+pxPybHVzuQu7ghDZd87aqjVREvZVul+0dRVBGG3nsd/R0udi3xHKy9OhBvlkL9s7PG3yOWhZhjFBfldrSEp4XBK8472KcDqGEsjEoqhfJvhXk1fTT5ESDz/AQrZLrtYW9ShiYiHrJfg4DITdvGJrmsjkd7sU7kOVBI4qhugvqUUivv1OxID3wQ+XvRAUhyVXXTBocGhSY7k4xTQNzqaflHtXG48E4O6rl8pKD8v1Ei3VUxXufll1lfEjuxPw3hu3T4d3Th2fJSlMI8C7/k9tL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199021)(6486002)(2906002)(478600001)(54906003)(5660300002)(4744005)(7416002)(6506007)(6512007)(41300700001)(86362001)(8936002)(6666004)(186003)(26005)(2616005)(316002)(36756003)(8676002)(4326008)(6916009)(44832011)(66476007)(66556008)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2lblaxwvVQsXkPHi8RqjzSsoeZSx7fdchACt6kUQo/GAgFzmuH6FesYMwO?=
 =?iso-8859-1?Q?iJyOZyTa8htXGntpVvoueJbzaFRklpTZG2Wbt2DXhKnPZtCgRh5rwyCBYw?=
 =?iso-8859-1?Q?+Vr8YX3/zrRai+XLON2fYDagS2yonC6osHo1bopSAAGl80EEoPbVjAAfwh?=
 =?iso-8859-1?Q?rioX1wI6q3s7NXdywNsVARsBOIV6QhUmnODwX3vW9lNTu57mdc4BUvUPtR?=
 =?iso-8859-1?Q?28R+co90JtLKpthpxlLfzdRsRoDJLD68L84kzIhzKWkLQ3yz/+Ehg0AE3m?=
 =?iso-8859-1?Q?TWkysRJtV2ectrpfkpxUyAQNRFYrPerk4osXoSknqcY/osmh4vu0OY3Rk9?=
 =?iso-8859-1?Q?Y1sbNz+upytCi5sPyXzl9TsE5U5oycai6bRw3lO9MKBPj8wY/L8ukabkEK?=
 =?iso-8859-1?Q?tULMWt2DQgE8+smj3DI3Cd6uY46UHLkS43StO+C0xn+24lSmKr1K/o1KSM?=
 =?iso-8859-1?Q?V/Co7kQCA0Q6LLi+FyiRC3cInSg1Fhm4OFHxlWrH+UPxn1FmiAbdddoMID?=
 =?iso-8859-1?Q?gAvHeGk2G2hFV2xcd890c04tD3/W9rk9rUzixm0zu+3x+CKfRVE7M/pD1z?=
 =?iso-8859-1?Q?tMRUsfAdJdQd/jAOVmYytSaK44Ysa8lIo8cQn+tCis8L94HA7l7CjJziPK?=
 =?iso-8859-1?Q?PMZCIGppt/GNYjKgFIsZ58GxPU6gZoK6uKViP2lhN6ac52NYkvZt9WIvi/?=
 =?iso-8859-1?Q?6rmpaXM65uU8cg1KqZ7qRKbCfcOWxNeqq0gM4E0MWvndGPRet1TKwdQedC?=
 =?iso-8859-1?Q?kPCAmVTD0LSOExemDeDBKBdLDoTCPy86ZXsCMiypbRyroun10SesrWqtQ1?=
 =?iso-8859-1?Q?x/nJihxIlvaNHQ03yC1jejmeE8qi4Q4tykPP6YE5XpotoONYneudoCty9v?=
 =?iso-8859-1?Q?OVPxqCzz3Y/etnTV0qEHbCjoW+5yKxflr3baO+in7n78s/I8Z42mspNutN?=
 =?iso-8859-1?Q?z4j0bcvAp9P4NYjoakAQDAG+9+9sJYelMFNl9Vjh3l2vJCYetDOA8/kcrA?=
 =?iso-8859-1?Q?VfldxF/3pPlZFFXB/WcKTRJXGB0LlWBovmmjVBBnaBzSVZ4mDaDYA046VL?=
 =?iso-8859-1?Q?tvEA0j7W9XMg95AhKOdIxCePwGt6FY21T+WbxfDGMcwD+aZ/XYEByWXevr?=
 =?iso-8859-1?Q?C2OVsrpRnFrHFv4y/MXxaFntRXw4qyzMjTlHgkJf6k+QRvYIdpNa8LgAdX?=
 =?iso-8859-1?Q?Jipc0i8KljEq9eBgKNDCEGNDi3yDSrmWi2ODO57n7K2oiGhUDkrod2osRW?=
 =?iso-8859-1?Q?0yzPu1fxK1yWynKdNHMkMRmiclj+RTvT18n6img7iwf2Q0PDPYuNLAgnov?=
 =?iso-8859-1?Q?ULioN74E/PkbwdBKbETC+ljjtd45SzFNP1osJlO51Jto/ThZsCkTHG/Ot/?=
 =?iso-8859-1?Q?OLkgJfdE2AZcJTgA2fSjVLk8HS7uU5YUKQi7sxlgWQACXY+xzUGR+kSvQe?=
 =?iso-8859-1?Q?Dg7zk6MtiLzgjEBSPnr8zWOer32dm1MvaDReLGMMV5kRkJ4FIFLzK6gZ44?=
 =?iso-8859-1?Q?nQaEfPIPM3X+bNLMCrWDCh/DL85modwuzrTGVPfwFgtfbQqnStzq0iteAP?=
 =?iso-8859-1?Q?aC7BMmfRkXnDVVwOqQRV8rZh6cDqFT2WkR6vcxOnkoKeDWz2Icqzqi2PSQ?=
 =?iso-8859-1?Q?A3qQx88Hv7W1iK15gmUHYDyZfXVqk4K53Zw3D4wdIXDGcP6B+IyRYHkg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1781f2aa-fae5-4cee-05b3-08db357e4936
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 02:34:31.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAo0ol7DiD5gOoRaE3GT5LXtB1cI4o4gHYUHLmMEZWnzxPiKFYE9/kXOjG7zyf4Zohy34z3iTxKPIXjQtAJ+SXb8Ht6fWFMO3ntSDKqTIPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4285
X-Spam-Status: No, score=1.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:51:08PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> [..]
> > More generally, I think a cxl-swap (cswap? ;V) would be useful exactly to
> > help identify when watch-and-wait tiering becomes more performant than
> > promote-on-first-use.  If you can't beat a simple fast-swap, why bother?
> 
> I think it is instructive to look at what happened with PMEM, i.e.  a
> "pswap" idea never entered the discourse. The moment the memory is not
> byte-addressable, it might as well be an NVME device where it can
> support a queue-depth and async-dma.

touché, but then did pmem hit latencies as high as 1.5-2us?

(I honestly don't know).

I'm just wondering how useful a 2mb page of memory at 1.5us per fetch
is, and whether we'll find it's almost always beneficial to promote that
page one first/second/third cache line fetch in some interval.  If you
always promote on first use, it's basically just super-swap - even if
the memory is still itself still byte-addressable.
