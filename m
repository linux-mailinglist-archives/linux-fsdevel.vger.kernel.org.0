Return-Path: <linux-fsdevel+bounces-38063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F199FB2EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 17:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93279162893
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF151B415A;
	Mon, 23 Dec 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QlcsC3t2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UX0Od1JL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B413BAE3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971485; cv=fail; b=aNA/m3DTSoIfOmAmfgfAIaSeuk/jFXZJdaO8kBeOIERZC5Ywhy5IfENbSAEFXioSMUiRequ89TL7zUgitO4fkKF0HBfmZHtNuQbVQaZG+hRz/njSI5T5ef0h3V4BCfwvJuCgLbH6eS2DkAbCa2lsLS8LlYpJbWL50AhgcVS4fOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971485; c=relaxed/simple;
	bh=op+4jsngLyuD+koQTrZxoEj9vljMqupKTvIfPrTJtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OfzjzaPUqnTynO0vHwMYoskCx8FA/nT3qGaMG01CXrr9amWGTXEMVIKuYKSAGbDRSTrFtJJ9oRNzZP18QEIY2DTb62Jh0NM6/KXX8aUdlMxUYEQ1e2IuNUdy0YpJCXKJ0bdJPE53m8VfV0Lu8YFYMgMIM6Dp58vFvegXrjQxxc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QlcsC3t2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UX0Od1JL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGBpbL016774;
	Mon, 23 Dec 2024 16:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v5UbncBbVt8kcstOBc
	XWTbcrPgvcQMPg4ba/MM3Rpfg=; b=QlcsC3t2yHLivN126NXEgbIQJYNyN3DBl5
	gmszNL268IhWJpF99WbBfoVgVBcv7jRFP/z90YyTkq0YV4VVt/ZS5B1yCMQ511gq
	IDl0sOxw4XDfL/l+eb0GKGMSxmWBgOWLyTyVG+zS7sQYAEMJrXW+KhcF+MjsUB0d
	G3n3+OWQ3uDQOwWFfzTjbtjIsCNXXLw2eVLQgCOrho1PUBS+FoNrgQrqrL4R+FIP
	d3kxT1p3xTFny1mHKaXK4lv9e3rhQnYe1zZyAEqQCPMKBTB5YEWyGGD5qw42Ak7Q
	0O4+KTSw5hoxF2GaUz3APYjSsfntBg2tC5BbpJ1AmsfEu0HwpIGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq74auaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:30:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNEcN6j016707;
	Mon, 23 Dec 2024 16:30:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4dcqct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIHMj0qyDRih1DdvabO1ntpm2KNspALLESaXMk7+pyDku9cKviygXjmwgHum9EuZrgTLGi3omiI2VF0V/MnPq7TitHJVDt43sOuhE15z+FmOBzVDzAiGuOCWlelpxeSwTSADfzSjAgo7IBnPydBQ9gVe6CBS09gOYqnYLdM8rBVvFp3qZvmFHvoNAue3U9qOjXRCzQqLADg9dLZJ7NLflN4IjP4/jPg5k3F2hQ5Dvq2L++1glsgFuWqqnF1djFRDucGoWoCvj+AW/m9kgu0n1lmZd5baiEncESIwHKu/0+S7Fatrvj5hhkQaGaI019qeLuNBMh+cuZMTKw8eLcN4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5UbncBbVt8kcstOBcXWTbcrPgvcQMPg4ba/MM3Rpfg=;
 b=c5Rq1ybp3EbnPs05oqJSulswp0n2BFqaB2hMs442O3t1aHPcq/Jax5UlMiGiYW93yGpL8FuZrWg7uF0W6J+DqVU8iSQJVN9y6cL2ceH4VW6lNp/VmnYAKRZpKZTvYzvtkCZvzrLg2H1NiX2ID1B22i6ORUL7EYsmjHEr0Z6S88MIdUP+9xvOB+jHNgtq4AqZk+Pmwro39FxCZ6Kff4Yi4cmRIYwp8xyaV73wEUl2Urd3X62wxikp/sOeqhdkmdZiT2hM/IiK6GkNZeB8AhgHRFLuf+nr/V2AE1+2DUco2en/3YRrBN2LOZRXcOMtpjx9XUnmApltwkUFm89dRkzyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5UbncBbVt8kcstOBcXWTbcrPgvcQMPg4ba/MM3Rpfg=;
 b=UX0Od1JL4JIa/gHs+ThcgYJwoDiEFOlH3sZATX3tw8pQ32o0sp5JLfjMhkCxZvQVQgjMMEFRqp2+tRSeLpMJrhuSVzbxdpYfp0jTk8Itp65Y0xISWnsbrha3UFImeC0Sk68i6ysjbjFfFIgdKZcZ/Gl43je+OB+aNL96MvNv+ug=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Mon, 23 Dec
 2024 16:30:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 16:30:50 +0000
Date: Mon, 23 Dec 2024 11:30:47 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: cel@kernel.org
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v6 4/5] libfs: Replace simple_offset end-of-directory
 detection
Message-ID: <pguxas3azhbjaf5peijhzzaul45h26lmh44or2vsulpxbnvv7m@apmmkc3mewq5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	cel@kernel.org, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com, 
	Chuck Lever <chuck.lever@oracle.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-5-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220153314.5237-5-cel@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dac6c2f-7697-4de1-e49f-08dd236f2987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uw3E+pr8lAIINiCk0XikxWQyFvFfN73CbjGcO3CtbaswN6SsbdBxhnCq+c2T?=
 =?us-ascii?Q?T9Ktu/PK+AWj2pW/JvefDKUUwTAJLJr7Hxuctq3MIw57Z8yKXhZa87svTuQu?=
 =?us-ascii?Q?mlimo1eP/eXqJqPYtIxyL0DMOza9riJnfEQYv5DwyeEWvF0ZQMiQ6bwyXl5U?=
 =?us-ascii?Q?oAqwTyAjUvInm5kZaQEW7OcN+ga8Q+QBGTp9jT1A4m2redD/I+ggWwd+MrJM?=
 =?us-ascii?Q?W35FlqOyy4sV6GVV8DvKnK2/UStqpLOr8N8Ggc0WVv2SmMkcpW9tYQr4P5er?=
 =?us-ascii?Q?uO44k6n71V1N8+byCOFfeFunwIuCb36oXs5LfwJQWI8HgPrchQgtwSMCo3Vd?=
 =?us-ascii?Q?BWj9Daq+MfD6ai95U4Kz/t7WwDkxg1N+DpWUjq6yebrr/g+tTAVi3rU64i8j?=
 =?us-ascii?Q?lM+cTtmaTUuofpwldpPEOB6Bj1VeaRpQ7HThS8ictpZzvydNUYykaw1MPaeu?=
 =?us-ascii?Q?vBPLWcgB9/4y/CCbIU7N1AmYNCrqE95magnKJbrxY063eJ6o9W6WjvOc9lCy?=
 =?us-ascii?Q?SSAobyzeerpz/DDikaEaj1M+Lhf3ozw3lYQwitnoIYixJEL/aaSmlXhmvZ5I?=
 =?us-ascii?Q?clVwy3ZIAe2GnoOWvhTdKS4hvl7evVOvKQCxXgBEB5gIcoK3lqOwB0SsR/dG?=
 =?us-ascii?Q?0GouXsnHwtlyOPK6pcSYyzkL6XgwBqFCRlBiLHVQHfmAG3eLVusLoVla4T67?=
 =?us-ascii?Q?Q/mHHzaKKr48qyxllZGyhicauttGRSzKzClDPuIgAkGERTnHEJEbH+Ongkwp?=
 =?us-ascii?Q?OSc7OHt0t30GCscVXurOB53uBz0tiIrNiuVQW89sGAMClkB6tJzH6YFTLKjD?=
 =?us-ascii?Q?7LVHpl+sWxYs/gfac6/2YCf/aw76wx8od95ygGVUtCKE+DQNb2E9qkpw4Qk8?=
 =?us-ascii?Q?mDKqpn7c648Kh64MlsMuKw0SC/TrjDQ6ypbn34iyF4UPR0CbYHOTz95Qz9t4?=
 =?us-ascii?Q?NrT0KAHsY6H/KXlY4+ZrpBhtjdGpdwxTRUQBxWHd9hRgyeSZFUehH9s/G6vU?=
 =?us-ascii?Q?KBe4m+le9FU/t+ceK6sz1zQwLBqctTP40u4T/LMEYQeYZgXT5sC1XmBp7Kto?=
 =?us-ascii?Q?EkRpjhjw/BvZ/RfZPfFHqmBMfOR6AQ9tos+BrPxXEwPrCEmbFCqiNEG8hPoj?=
 =?us-ascii?Q?Pu/Ks7lDfNTq0W/54mKtLuHI8n/flph9VN+DMpzBgV0XnVSjaHZJN+jSd5Vf?=
 =?us-ascii?Q?D7FDOWUKocspsHavbYyC0SGyCG+AsIp8AAhB662lT2xXAJAr0PUdN9c29Zdi?=
 =?us-ascii?Q?fJSERMEGUSjQziwUQXC5UmmnhpTU6gQDp87PsgMumvGJjAY+sO9M5dfxOnck?=
 =?us-ascii?Q?0UPnNQTH3+GsEJO3md9e/z9YFuDUEAlQSBb0zaGqYTgMxxSl34sk4itQTel2?=
 =?us-ascii?Q?2oaFUXKTVc2kgyBCROo/EI8cRM4G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3cnvcjP614MlgvnjtTF9qyJMoRSD4H2Vbtf8YGZhx8X/M+IitE8AHGDX3IU?=
 =?us-ascii?Q?pLEJ22sNGP+6cPbM5uaa1L9V77JjUWTcb/T4yeJVHkH+e+3QL9YIQT1bst2Z?=
 =?us-ascii?Q?NGRAdtM4oJPBOPTBPW6iXVTWdvmIxpV9TgrfefOzY4zEuKtgDE4wmRJPCJrR?=
 =?us-ascii?Q?9y9/URAcJiDTdmEsWlanVso47ZdxdlRfZvoSu/nnZxew3VSjFE/UySIL2wpz?=
 =?us-ascii?Q?OLmwt2o67MSaPPAdff3hUx7LYQ2NF5o5CY3USM6ZR1mdsGRIfN8ylVRVrSIw?=
 =?us-ascii?Q?66CwlAR840MRlI/bMt01dYVQjl4MjboSJ2poQ/btn/g8/eSthOcKQyEnHE2F?=
 =?us-ascii?Q?ZZ6UCUk+NHGQw1uK/M8BRqUVN4KmeDxrjLqVYdeS8lgkWbc//6hVmnaa6dVW?=
 =?us-ascii?Q?sAB9yOicpLIpCmBRL/x4FYTR0FQPErp60Tc7G9f51wA19Un0X4rYc30zgd4g?=
 =?us-ascii?Q?aqbvI+tGR4aMPrrOBtSkbnSLzxxoAmKpk8F+OtQnCm9flCdBF5dH6rWEdSdp?=
 =?us-ascii?Q?c2MMuRlZSa5X0y7Q4sbCaSnUGfFIKuQcuBZz28vM2RkuRW5Szc7S8nbxD3uE?=
 =?us-ascii?Q?wwUoZldKiEnVM0p7/ai9tbMV6cGF27m9X18A7rsvY1m6fqLwM5O3sElFbOR/?=
 =?us-ascii?Q?TjBEVNPV4e6FNsWo82IbFU2u9DoCoJ3NGCvYyq677+I0eCtD/3/A/mO/zPdv?=
 =?us-ascii?Q?Hul/oGvB3LD1Rn2BbzB8WeJOJ2MbhfYmym8+Q63dkxj/AMTO3drQOvUtbAZn?=
 =?us-ascii?Q?3Gz6/AX+hw8SU0V7CdDBLRxDUqnkKRZrTRt3nagX0BuFFWuZAc/Yme7jui6+?=
 =?us-ascii?Q?sB8DFea8I1bG35fUB3tau1tXWCi2EF1ufTcRvNkgaCTdwBDdVXL9pTHImj93?=
 =?us-ascii?Q?H7dAB4D1PySygrLoUwZPA4qeDJrmVtOmQm019uTxzCOhFZJF3zDFOjrfQGOM?=
 =?us-ascii?Q?VDGR2dF/tlaUu/nr0SZ2iKJZOLoJrzOhxTlLa7x4BqdXpUV/1TPNJvJ5Kxce?=
 =?us-ascii?Q?DLDscgPqFeAM0jLhccNTAstDZm6UcilBFf25bris+YYNXYlqMXqGUwfiJYVu?=
 =?us-ascii?Q?W7a2t3t9ehBeToMpDHuZTBbJrtjlaRSEhr2dSZ9+fd5HlH0vXwi39boCucGR?=
 =?us-ascii?Q?FaALMEPfFbw68GZdS39p9P4Z5adpPSOTkttYt1G57O4RMXY5jlOfiKxRPJvW?=
 =?us-ascii?Q?o1bWFabSKjOp1hBKB/AiWoQvh0wPTFQyDFZMtuG+kKatc+aWmXiikGY7wjYU?=
 =?us-ascii?Q?djnIAzypYGMnSBW/U0Wwvip7q6FiN2PFPkTBwjkmvitZR1r3ddyq1zXqzmr2?=
 =?us-ascii?Q?TgHqJuNXZOWV3a/UEL3NqrJVQ4CURD9xTB+88rM+z7xZwefdI4u7pmWX4kDS?=
 =?us-ascii?Q?JwWtXeMNpdEd2ie6lqBOhDiNZabvCvIa37lVEveovrJ8xa7eO88eXYJX8jbf?=
 =?us-ascii?Q?/0k3Aja5lLgDBND1BzlEBROGZ/Y1VoUmKujYgD8ZpjFFfNC7LXrV0iKNj4H9?=
 =?us-ascii?Q?wl1JMLyN1aCxuUel3IBeoUIa+4V4JbDbs5IA3Q8am/16k/l5dSi/HC9Ceb5A?=
 =?us-ascii?Q?kxEWBGxKidbkQTFuao7bfVE6o2oAlUqpy+QG0MYK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vkepmsGPixDcELP7tmHfgJ9LvA0O50qeP40vhthEfKcwE2m9/gKkRiiKYkeyiILkmLH4q1+QBw+6BYM8ohu7/4rfld15XR5vZslNZJmRW3w3xOd7KkqejsAo6/Uqs5+QeUJDLY9ALS9HwIxB65qfUihzZpPDkgPyYlDYqTgDRkZxYlr2nQ2oOHqRNTOTx/0tzQN+sFYTY/WKzJS2Zy/ttFqQJV21LlfpYKzZmmPWtssAEANLilEKySZ728i/EOMl4oSY03EwS9sHiNaJxhR05HJNrf5ppRwLk6JKyaM4DNNyTEXZafhEFwHmdqLH8VQiD7nAuDz4G9hVTHRhR6cw0LDxMTK+/JB7FttF7odTA3J6iOLyXMcoxRyo0wNCmmNEVpXtkmm53LmapLY5v66jgfoGxJqWdzISWVIKMS2WPCRNoU5vYb1x3tcTENu7X045gqNIaVuN8PR1HHFRGKOGPzlA4WI2/6X152YCBlytNRwtZpn1LH5PI0N56IVhK3ck/wDJFVZzyu9Vgpy+uLGhV9Al+f/GYn0BkhvD+JMZLlWCXdNchr/nKx5hBZp/0742XHy6ZSmSYIEFt75KvOjYoDcVpG5pFHJMFERfq+2/0E0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dac6c2f-7697-4de1-e49f-08dd236f2987
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 16:30:50.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNmuCemNtGfkj6qs+9fiuoPiHtxpYfH5kCh8aAYdbLZaCIJobumE8cZKZ8wPWbaIthcd0Wcddv+4UgXVkk7GBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230146
X-Proofpoint-ORIG-GUID: kRCm4CowZJs0VJI8oggqDYL1QObnsvkP
X-Proofpoint-GUID: kRCm4CowZJs0VJI8oggqDYL1QObnsvkP

* cel@kernel.org <cel@kernel.org> [241220 10:33]:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> According to getdents(3), the d_off field in each returned directory
> entry points to the next entry in the directory. The d_off field in
> the last returned entry in the readdir buffer must contain a valid
> offset value, but if it points to an actual directory entry, then
> readdir/getdents can loop.
> 
> This patch introduces a specific fixed offset value that is placed
> in the d_off field of the last entry in a directory. Some user space
> applications assume that the EOD offset value is larger than the
> offsets of real directory entries, so the largest possible offset
> value is reserved for this purpose. This new value is never
> allocated by simple_offset_add().
> 
> When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
> value into the d_off field of the last valid entry in the readdir
> buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
> offset value so the last entry is updated to point to the EOD marker.
> 
> When trying to read the entry at the EOD offset, offset_readdir()
> terminates immediately.
> 
> It is worth noting that using a Maple tree for directory offset
> value allocation does not guarantee a 63-bit range of values --
> on platforms where "long" is a 32-bit type, the directory offset
> value range is still 0..(2^31 - 1).

I have a standing request to have 32-bit archs return 64-bit values.  Is
this another 'nice to have' 64 bit values on 32 bit archs?

> 
> Fixes: 796432efab1e ("libfs: getdents() should return 0 after reaching EOD")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8c9364a0174c..5c56783c03a5 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -245,9 +245,16 @@ const struct inode_operations simple_dir_inode_operations = {
>  };
>  EXPORT_SYMBOL(simple_dir_inode_operations);
>  
> -/* 0 is '.', 1 is '..', so always start with offset 2 or more */
> +/* simple_offset_add() allocation range */
>  enum {
> -	DIR_OFFSET_MIN	= 2,
> +	DIR_OFFSET_MIN		= 2,
> +	DIR_OFFSET_MAX		= LONG_MAX - 1,
> +};
> +
> +/* simple_offset_add() never assigns these to a dentry */
> +enum {
> +	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
> +
>  };
>  
>  static void offset_set(struct dentry *dentry, long offset)
> @@ -291,7 +298,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>  		return -EBUSY;
>  
>  	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
> -				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
> +				 DIR_OFFSET_MAX, &octx->next_offset,
> +				 GFP_KERNEL);
>  	if (unlikely(ret < 0))
>  		return ret == -EBUSY ? -ENOSPC : ret;
>  
> @@ -447,8 +455,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  		return -EINVAL;
>  	}
>  
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
>  	return vfs_setpos(file, offset, LONG_MAX);
>  }
>  
> @@ -458,7 +464,7 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
>  	struct dentry *child, *found = NULL;
>  
>  	rcu_read_lock();
> -	child = mas_find(&mas, LONG_MAX);
> +	child = mas_find(&mas, DIR_OFFSET_MAX);
>  	if (!child)
>  		goto out;
>  	spin_lock(&child->d_lock);
> @@ -479,7 +485,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
>  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
> @@ -487,7 +493,7 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(octx, ctx->pos);
>  		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			goto out_eod;
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> @@ -497,7 +503,10 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  		ctx->pos = dentry2offset(dentry) + 1;
>  		dput(dentry);
>  	}
> -	return NULL;
> +	return;
> +
> +out_eod:
> +	ctx->pos = DIR_OFFSET_EOD;
>  }
>  
>  /**
> @@ -517,6 +526,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   *
>   * On return, @ctx->pos contains an offset that will read the next entry
>   * in this directory when offset_readdir() is called again with @ctx.
> + * Caller places this value in the d_off field of the last entry in the
> + * user's buffer.
>   *
>   * Return values:
>   *   %0 - Complete
> @@ -529,13 +540,8 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
> -
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == DIR_OFFSET_MIN)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	if (ctx->pos != DIR_OFFSET_EOD)
> +		offset_iterate_dir(d_inode(dir), ctx);
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 
> 

