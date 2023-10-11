Return-Path: <linux-fsdevel+bounces-19-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4C7C4745
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0562F1C20B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4120E0;
	Wed, 11 Oct 2023 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BulmC2Ch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B4MIHHzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA180D;
	Wed, 11 Oct 2023 01:29:55 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE68F;
	Tue, 10 Oct 2023 18:29:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ALha4G025248;
	Wed, 11 Oct 2023 01:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=LmA56ONXg/+gFAWs2xo8m99EMeGYygeMuQIxTRiDbvI=;
 b=BulmC2ChrZiLvM01RutdSp1LbYYJesg9b+NNKgiac+bq6CF2tgHZOfK9Xvos4L1s+5cq
 F2dBV5SJ8+l2efCYf7Q986EZynXglL4HmahVx+TpXJKo82WZtpLV6IKoRr47nRIlyYwD
 0dZ5tn18s8ApOftnkFkItkNwJNMwViyLg7W0OUtc0tTsKg60MQfWnKLwt50fHYNwWkC7
 d2OTnv1Di7VqNKOFQRDjn1Kni3nBNqyPbtvIXodujOSr6CyyjfaCGMjpUppN99i8DZFL
 NfScFoyorrZ5YQmc1fe62BXoc1CWk000g6eKvbM19dsvSeYwtx+XkFtjFAT3nTAZ8Sip VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89v4c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 01:29:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B1FJ3e020719;
	Wed, 11 Oct 2023 01:28:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsdeajd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 01:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPZNzHGqH1Yq4pMbxf2+a605I3yxDErVmJBJkzxHujPr2w0eBiUEXA1Wxx7GmJf4tte88CtGZpBDELzumhjhwE8sPD+DhCX8O9GR69LgpXi4A1y2+ORnnbQiJilC3lnSEg8luXCZJ7kHzOoZoJLk+D9sGkC6vnWeLLvRIT6ZbFupFqWJObVToaLqvhMRNeuMRwB4qRXlZjtAbx4csXpcpuQW2REWehXisamGxbQoP9dynDpN+d5hfINqFPiQ63bBWAHWHv9WEJEzFyW3B9QtkXEXui1aEwM31JDzDpVEh9c8VZckr7YAwhs3sq2zJJF1DaWsRTU7RaHQxTWhWIb4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmA56ONXg/+gFAWs2xo8m99EMeGYygeMuQIxTRiDbvI=;
 b=kKR+IwkUnRlup/Z9N1lyHc4zvNsUMB8srM+ouCjoh5z9vqQNV/v6JS74TxfYEvK5IuMw2Jz6gQC49Jsk4Rp6FQlDjLzowqj+NFTGQk67zNDhAZWUOIaz6KadDGZtQjuGAhSGTRdF8VphqYt7sYtKjj2vg6K/iBC1BIOMtVhfyyPtGYn+/OfdRwTTZ8RyOW7rgLVsRsho6BkXDq1OyJi46WtXlDyuAITp+IZunWeTPngZfgj1hHKHU1ErYIMtd7wBma8l8ZaGQ/gNqsdBz0YrYfofmLLLYDjuGAxR8hhxkNURfIZC+MtiQY7bytbTSIxxf3dec70NPm4JkMKmMJR33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmA56ONXg/+gFAWs2xo8m99EMeGYygeMuQIxTRiDbvI=;
 b=B4MIHHzQM9R8qM8mT2hIoM3uyVRUtD0cuUyRC4wJNdC8yMAATVQ8LDGchhhvxjuNmQSYdunY2Lw57OMxWnVV/L2Jh2Jryob6Jc9HvIPwIdq0NsPdVuCKemGnHZ6849K9CWf0I29QyLtuqrIPIrHm2OAIkJwPY5G1IB5h1bTFPkY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 01:28:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 01:28:53 +0000
Date: Tue, 10 Oct 2023 21:28:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231011012849.3awzg5sfdk3sqmvo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
 <20231009090320.64565-11-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009090320.64565-11-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 47325d40-5d58-40ee-b68d-08dbc9f96e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XEXPxEEGhSGeRx+7CzP2TJwqRUZMAtZLITh/E2AFQs3xXSKhOAYUa3LFysr2Pe7bNEyX0aZFNdK+QMEn+SlrdY7im6UOVoc6yOxWzm8DjZTPEKe/GEcLbfoawpE44/sy+fE1YonLYT7dcwJ/xakWs6Ou5r6C3tmeR9RuA6iqXmGFQnIWdTBLfitDZqdJB/wwO9hkfzAX8jS3aPh2AtvV+P8Ztj+flreZToXjumDqdoUMjzb6DkNZP/f73+lstxx52grTJtsUoOyqSEaQyOY7RhhYJhajuVj7ABhHhZ6l0qrwHrIdysCKFrjf/ku4YhLA94Vby4RHloW5iRQJSncX6HTo3XMqWfjzSIDCAW6ImknXIFjliFUJN9TC8QzjFPx7rLcuzC4OWztxbuaz8tQay+dlHaWwUozB++hlQUZav73gjLzLoLWjLEpc0Pmf2bbzC4xQy1oM0IreM5rN9kO79bV2n7BRg6pYGJ4e7U9No/Zk01Ycj95W2AdVxMJq31++0AjskNVpmy1n902NhoH1EGYcb+Dc5NHedhHYE3HePb8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(7416002)(1076003)(6486002)(966005)(478600001)(6506007)(9686003)(86362001)(33716001)(5660300002)(6666004)(6512007)(38100700002)(66556008)(41300700001)(66946007)(6916009)(316002)(30864003)(4326008)(8936002)(40140700001)(2906002)(8676002)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UHhSpoqgdR6b7e6fUQrdtMurf+f3/vQoyZ5yvkVlexB3Eoy2wJm2fE0sTFFj?=
 =?us-ascii?Q?rN2ekGH2Dt/JuNLhMoUNrd2ara5tkcX0PxkcHwdmEikuWyUsyzFP3pk0eGuu?=
 =?us-ascii?Q?AQXB5AC9yL+7nFYIyPIdaN1Nky/+y6gxozSHVFvP3G/pXLxZEIV0m8hoXjIf?=
 =?us-ascii?Q?zkT7135R5xjjV6oXe/3TS1RNJN275QEpdCXygaa7dJ1mlJfFbq8KJlSe0hKA?=
 =?us-ascii?Q?AUIctu9R6SDvzCr8cZdoBSZcvEaHRdE2O9O9UM/YLAocRpCiEVGK01sg91B1?=
 =?us-ascii?Q?TUbgHQkxep3qaARXJn7jPPZ4eDdPq3leWH0NXiSFHMNekDiJA8cjdXVL835F?=
 =?us-ascii?Q?OvJIEa2VutAQOMdZj6YQ0IpUITth5g0CkljHTGqn57yBmMUEuV+SZ4l5lu42?=
 =?us-ascii?Q?edrFRlaXtVv7/kf9hoXdNjxw7tPJHSNnpihkk+s9R10Y3VSLMiGU6GM7DlhB?=
 =?us-ascii?Q?2HlFXypU8fuKVEIOjgrRoOzA2fkViXvTAAJmGxbU+GJn61yW9GMlxGPjyYwN?=
 =?us-ascii?Q?9hhrCUnTYjyGx9zD81fQyQB9oK+YI/TnlI2o6KkjmaTduWjeaZj/weE1X35d?=
 =?us-ascii?Q?t/B4pXcB0WAGiTpX4CGys6GxujJYkXFhVBVw7clwJSaHdD0zFSvPYOtY3sCy?=
 =?us-ascii?Q?B8vOEvmmCNDJLDFJ0WVHyEA15epqunvpGJa87VlBVKiWUfgmlIz8asMiklEV?=
 =?us-ascii?Q?x1rHb0G/Tq/B2X0h0jOvUSMeoHD3+R9ggJ/cIWdkS4kPb+BhAzGDyUely6pQ?=
 =?us-ascii?Q?wYmEbH4QwXxqrxDuzBJWnQmtJ2eg7B/mswNKEo9kPXCOpakcsaaYwwthOTZk?=
 =?us-ascii?Q?8vb4z0+Xu62+tMBXfuk+KkzEQTzOlZEH+5LB3gXgqLei00z4m4yVtF05X8d1?=
 =?us-ascii?Q?u11PBs2Kr4oSr2EPUQ4CcDMrXqCPnFB5c19/6wfp6PnDpdb5eJ4lIjW+RGY0?=
 =?us-ascii?Q?qc7tjheGCFQxvl21w8OC60qn5CNW30N2jfj+EI1uRsX54fVq0WFCJ3kxkYfM?=
 =?us-ascii?Q?3bqis4CjYh6jdTAmrGi8JGt7+1x0qXvQVGYPDdrpYaBdBVWfvgkqVOO1oNo3?=
 =?us-ascii?Q?s5IovWDM0nr+gpXtbjE8/NAe2ZxUNnTXbhoKc0IxEq93azbhZQ99WZkxOLVY?=
 =?us-ascii?Q?PKwjqyR7LvJMNB1n75O6gc5uKJHU0z8zjAAQtVuWuk01lrX14KbWFpJ3vxBp?=
 =?us-ascii?Q?paBF4xyiC8J7GhMvcfor2GDPuZu9Xyd30YIjk7VlTVeIY6sfT4AHDWKnxguI?=
 =?us-ascii?Q?e0yibBsYZSlaKIei1GKrdr4SUZantKcLxA1Oy09OOxb4o5kLs59vLliJW0Wq?=
 =?us-ascii?Q?XpgndW2e/Zegt1zErHPeGdjHgKvOq0t1PhGjU7nnZLGyZgGGxCZpCE4uCkoT?=
 =?us-ascii?Q?rooO7VWcm+5MIlAi5E9UGKKbQjgdIFLf4Re1Xn/Q0miN8rbgkaRwWY5La1hg?=
 =?us-ascii?Q?NP4yILGqZUDzcuQKn3tArhL4mPcPAhS/ljgHvAnG9W7TGjrWC6h9oeGoXP/V?=
 =?us-ascii?Q?NBk9mmOPO367D6oiSea10smGDmLA3EXIk9u1oiCjQmucTvvJgLTS4O3vrZ+U?=
 =?us-ascii?Q?x/bQuOZjGI3PsGOsFFoqmf4/pyPleBmqN0I8AAnt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?9pcbFdWz2LR3/O/GjvLf/ebFAPc0DwiYkhSPt7xVWdWwFaibLv1SVjAu1kWs?=
 =?us-ascii?Q?rjcgGZJzIrUUfrELWl+y7C0JQ9rLMOStb45T3y3A+RqBq5WxwleGerbAezvc?=
 =?us-ascii?Q?qIzJgVVN8W172RXKeKUpsIUuDp3MNm8EjVYJyyHmqgbcsALsb1Vd9utxfm6u?=
 =?us-ascii?Q?7ppJ3QAb83iSSECOl9CNjld0Jxe7lFhZzTMIzM/CGRAPPcvT1ERfwr3vDNKz?=
 =?us-ascii?Q?AWCxa2ZgzvSOMLtLUYJwvz1mQjNBe5ARbJgTOur6mureRL/CSupVGygOntYr?=
 =?us-ascii?Q?DeLO1WC/RDl/ks4FD4Xg83g/f3+l4m8tdg54lZoEecce5w8ZNrKNJtDm7rtf?=
 =?us-ascii?Q?AiJWbGNRqiT9F5ElXUGdjk8GGJXsn3g/fwxphZPi4k5G+t3aZ67tHTBJQxFC?=
 =?us-ascii?Q?EhnOaobS+tWsF8NSQtXm0Y40yVPK24MsAZPtu93FwEucR9bhUGlLvjA2vi90?=
 =?us-ascii?Q?PR2TvGYc/NAavdpOnS6d69L36v9WYJSlD38LqjbYw7xOU1/HH7FHx9C+6yBo?=
 =?us-ascii?Q?neQjFogL3iKPByWwpEgBhzFzqwdEl4EeMStmGE1npDpnxyqoQDd0J7xG1/I/?=
 =?us-ascii?Q?mDl/8QK3Q1+A6rbZJnGIUk/HBMqYf9HKKzbfa796Az5jeOG+bo0+DX2xOdS6?=
 =?us-ascii?Q?HtLpJsi3FEpg7d4+JlYxI1Km8hdiBsNmvK96X2FtmKIJbIkP+eu7dkTic2Yl?=
 =?us-ascii?Q?R1y3jfBJzkN0VKX0QW9lBoOKBSfAVYfGtEHZ6Ze/NcfQlCfRgTmuJW/7fNsW?=
 =?us-ascii?Q?sDjDDqcb2eAjfhGhWuGDCDJZV6ZzHRYZOUa0fHfErrB2rYRKgqjNkTDvaBHw?=
 =?us-ascii?Q?RJ4X0N7ljHnKqbcj09tFKEZy5ujjS2/mEAApnEIEDWvzKfc2JlrK+N/ZJDWz?=
 =?us-ascii?Q?aBJzhM6c+C77iV0ux8gsk5wLFU0/2E+uzzZLIivsfrWAdzCOLJKWKztEtxVL?=
 =?us-ascii?Q?P057o9kRkuPQ9Kj6msEL5+s2iYiQnM2zPOC7ifyMfbZ7pvGiiTHURNiGgTsN?=
 =?us-ascii?Q?ozNykcOl5eQhgBBlO/iGbeNWsuPv2MoK3o7WSZbLsB2fl5FJDvLcuOZzCqfb?=
 =?us-ascii?Q?M+C79A73NDeKiMjTz5R0RP1BnA9JeQTqqO/dBYROf6if3HkKH5+F+oSZGEwj?=
 =?us-ascii?Q?E+Pbs9gruLHoo/Rim6UZCE71r43gbnduKtdQVh2tAS3nCsYsndwUOlM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47325d40-5d58-40ee-b68d-08dbc9f96e38
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 01:28:53.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNync9xvKSMD/3sIhH6fItwktsw40Q8D2fh+FATdUgXg89VBwiMXIYikcZ9giTfwvfOY1TDc0YVDGooDHfCbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110012
X-Proofpoint-GUID: igobkkOmdeUD-eeADHI8X7NGWy6XoYNU
X-Proofpoint-ORIG-GUID: igobkkOmdeUD-eeADHI8X7NGWy6XoYNU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Peng Zhang <zhangpeng.00@bytedance.com> [231009 05:04]:
> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
> directly replacing the entries of VMAs in the new maple tree can result
> in better performance. __mt_dup() uses DFS pre-order to duplicate the
> maple tree, so it is efficient.
> 
> The average time complexity of __mt_dup() is O(n), where n is the number
> of VMAs. The proof of the time complexity is provided in the commit log
> that introduces __mt_dup(). After duplicating the maple tree, each element
> is traversed and replaced (ignoring the cases of deletion, which are rare).
> Since it is only a replacement operation for each element, this process is
> also O(n).
> 
> Analyzing the exact time complexity of the previous algorithm is
> challenging because each insertion can involve appending to a node, pushing
> data to adjacent nodes, or even splitting nodes. The frequency of each
> action is difficult to calculate. The worst-case scenario for a single
> insertion is when the tree undergoes splitting at every level. If we
> consider each insertion as the worst-case scenario, we can determine that
> the upper bound of the time complexity is O(n*log(n)), although this is a
> loose upper bound. However, based on the test data, it appears that the
> actual time complexity is likely to be O(n).
> 
> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
> fails, there will be a portion of VMAs that have not been duplicated in
> the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
> To solve this problem, undo_dup_mmap() is introduced to handle the failure
> of dup_mmap(). I have carefully tested the failure path and so far it
> seems there are no issues.
> 
> There is a "spawn" in byte-unixbench[1], which can be used to test the
> performance of fork(). I modified it slightly to make it work with
> different number of VMAs.
> 
> Below are the test results. The first row shows the number of VMAs.
> The second and third rows show the number of fork() calls per ten seconds,
> corresponding to next-20231006 and the this patchset, respectively. The
> test results were obtained with CPU binding to avoid scheduler load
> balancing that could cause unstable results. There are still some
> fluctuations in the test results, but at least they are better than the
> original performance.
> 
> 21     121   221    421    821    1621   3221   6421   12821  25621  51221
> 112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
> 114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
> 2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%
> 
> [1] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/mm.h |  1 +
>  kernel/fork.c      | 34 +++++++++++++++++++++----------
>  mm/internal.h      |  3 ++-
>  mm/memory.c        |  7 ++++---
>  mm/mmap.c          | 50 ++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 78 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 14e50925b76d..d039f10d258e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3248,6 +3248,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
>  extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
> +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
>  extern void exit_mmap(struct mm_struct *);
>  
>  static inline int check_data_rlimit(unsigned long rlim,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0ff2e0cd4109..5f24f6d68ea4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	int retval;
>  	unsigned long charge = 0;
>  	LIST_HEAD(uf);
> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	uprobe_start_dup_mmap();
> @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  	khugepaged_fork(mm, oldmm);
>  
> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> -	if (retval)
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> +	if (unlikely(retval))
>  		goto out;
>  
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(old_vmi, mpnt) {
> +	for_each_vma(vmi, mpnt) {
>  		struct file *file;
>  
>  		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
> +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> +
> +			/* If failed, undo all completed duplications. */
> +			if (unlikely(mas_is_err(&vmi.mas))) {
> +				retval = xa_err(vmi.mas.node);
> +				goto loop_out;
> +			}
> +
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));

I am not sure how we are getting away with this, but the mm stats are
copied before we enter this loop, so I'm surprised that we aren't
getting complaints about the VMAs that are later than the failure.  I
don't think this needs to be fixed, it's just odd and it existed before
this change as well.

>  			continue;
>  		}
> @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (is_vm_hugetlb_page(tmp))
>  			hugetlb_dup_vma_private(tmp);
>  
> -		/* Link the vma into the MT */
> -		if (vma_iter_bulk_store(&vmi, tmp))
> -			goto fail_nomem_vmi_store;
> +		/*
> +		 * Link the vma into the MT. After using __mt_dup(), memory
> +		 * allocation is not necessary here, so it cannot fail.
> +		 */
> +		mas_store(&vmi.mas, tmp);
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
>  
> -		if (retval)
> +		if (retval) {
> +			mpnt = vma_next(&vmi);
>  			goto loop_out;
> +		}
>  	}
>  	/* a new mm has just been created */
>  	retval = arch_dup_mmap(oldmm, mm);
>  loop_out:
>  	vma_iter_free(&vmi);
> -	if (!retval)
> +	if (likely(!retval))
>  		mt_set_in_rcu(vmi.mas.tree);
> +	else
> +		undo_dup_mmap(mm, mpnt);
>  out:
>  	mmap_write_unlock(mm);
>  	flush_tlb_mm(oldmm);
> @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	uprobe_end_dup_mmap();
>  	return retval;
>  
> -fail_nomem_vmi_store:
> -	unlink_anon_vmas(tmp);
>  fail_nomem_anon_vma_fork:
>  	mpol_put(vma_policy(tmp));
>  fail_nomem_policy:
> diff --git a/mm/internal.h b/mm/internal.h
> index 18e360fa53bc..bcd92a5b5474 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *start_vma, unsigned long floor,
> -		   unsigned long ceiling, bool mm_wr_locked);
> +		   unsigned long ceiling, unsigned long tree_end,
> +		   bool mm_wr_locked);
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>  
>  struct zap_details;
> diff --git a/mm/memory.c b/mm/memory.c
> index b320af6466cc..51bb1d16a54e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -363,7 +363,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>  
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *vma, unsigned long floor,
> -		   unsigned long ceiling, bool mm_wr_locked)
> +		   unsigned long ceiling, unsigned long tree_end,
> +		   bool mm_wr_locked)
>  {
>  	do {
>  		unsigned long addr = vma->vm_start;
> @@ -373,7 +374,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
>  		 * be 0.  This will underflow and is okay.
>  		 */
> -		next = mas_find(mas, ceiling - 1);
> +		next = mas_find(mas, tree_end - 1);
>  
>  		/*
>  		 * Hide vma from rmap and truncate_pagecache before freeing
> @@ -394,7 +395,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
> -				next = mas_find(mas, ceiling - 1);
> +				next = mas_find(mas, tree_end - 1);
>  				if (mm_wr_locked)
>  					vma_start_write(vma);
>  				unlink_anon_vmas(vma);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1855a2d84200..d044d68d1361 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2337,7 +2337,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  	mas_set(mas, mt_start);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>  				 next ? next->vm_start : USER_PGTABLES_CEILING,
> -				 mm_wr_locked);
> +				 tree_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
>  }
>  
> @@ -3197,6 +3197,52 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>  }
>  EXPORT_SYMBOL(vm_brk_flags);
>  
> +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
> +{
> +	unsigned long tree_end = USER_PGTABLES_CEILING;
> +	VMA_ITERATOR(vmi, mm, 0);
> +	struct vm_area_struct *vma;
> +	unsigned long nr_accounted = 0;
> +	int count = 0;
> +
> +	/*
> +	 * vma_end points to the first VMA that has not been duplicated. We need
> +	 * to unmap all VMAs before it.
> +	 * If vma_end is NULL, it means that all VMAs in the maple tree have
> +	 * been duplicated, so setting tree_end to USER_PGTABLES_CEILING will
> +	 * unmap all VMAs in the maple tree.
> +	 */
> +	if (vma_end) {
> +		tree_end = vma_end->vm_start;
> +		if (tree_end == 0)
> +			goto destroy;
> +	}
> +
> +	vma = vma_find(&vmi, tree_end);
> +	if (!vma)
> +		goto destroy;
> +
> +	arch_unmap(mm, vma->vm_start, tree_end);
> +
> +	vma_iter_set(&vmi, vma->vm_end);

FYI, This missing vma_iter_set() in v3 was not caught by your testing
because it would not cause an issue, just avoid the optimisation in the
gathering of page tables.

> +	unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end, tree_end, true);
> +

I really don't like having to modify unmap_region() and free_pgtables()
for a rare error case.  Looking into the issue, you are correct in the
rounding that is happening in free_pgd_range() and this alignment to
avoid "unnecessary work" is causing us issues.  However, if we open code
it a lot like what exit_mmap() does, we can avoid changing these
functions:

+       lru_add_drain();
+       tlb_gather_mmu(&tlb, mm);
+       update_hiwater_rss(mm);
+       unmap_vmas(&tlb, &vmi.mas, vma, 0, tree_end, tree_end, true);
+       vma_iter_set(&vmi, vma->vm_end);
+       free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS, vma_end->vm_start,
+                     true);
+       free_pgd_range(&tlb, vma->vm_start, vma_end->vm_start,
+                      FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+       tlb_finish_mmu(&tlb);

Effectively, we do unmap_region() on our own with an extra
free_pgd_range() call with the necessary range adjustment.

We have to add the tlb to this function as well, but it avoids adding
identical arguments to all other callers.

I have tested (something like) this with your provided test and it does
not provide errors on failures.

What do you think?

> +	vma_iter_set(&vmi, vma->vm_end);
> +	do {
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			nr_accounted += vma_pages(vma);
> +		remove_vma(vma, true);
> +		count++;
> +		cond_resched();
> +	} for_each_vma_range(vmi, vma, tree_end);
> +
> +	BUG_ON(count != mm->map_count);
> +	vm_unacct_memory(nr_accounted);
> +
> +destroy:
> +	__mt_destroy(&mm->mm_mt);
> +}
> +
>  /* Release all mmaps. */
>  void exit_mmap(struct mm_struct *mm)
>  {
> @@ -3236,7 +3282,7 @@ void exit_mmap(struct mm_struct *mm)
>  	mt_clear_in_rcu(&mm->mm_mt);
>  	mas_set(&mas, vma->vm_end);
>  	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> -		      USER_PGTABLES_CEILING, true);
> +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
>  	tlb_finish_mmu(&tlb);
>  
>  	/*
> -- 
> 2.20.1
> 

