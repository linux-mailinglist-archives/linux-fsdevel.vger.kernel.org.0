Return-Path: <linux-fsdevel+bounces-18938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA2A8BEB3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFFB1F26A6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414916DECA;
	Tue,  7 May 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4lpDSqI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bDebXpyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098B16C870;
	Tue,  7 May 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105456; cv=fail; b=QdUcpvxZ8jKt5wjmvN0Aq1tsd2xN4ZJ9DZYyNT1l8GH7b3jCvcf49q+x3/KGDlPLr5RYcWa8Q1smW/heqnQAiTofaoTeUo4LKYglgFPdVkinw8wpDNl4c4P/b96ppytKfnttu01Gw16N0U/3DL/4yXCfMcBxDEJQVTv6xDIRc2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105456; c=relaxed/simple;
	bh=RuliEWxdByhJfy6LevH8jj7lQE/6H9l/UFzRa2lnSYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jO46YBXihpDrD98yG1zwJXWfqGLZ+iFV1VnFzl6qN76BNGY1iESopkL4M3J+99yX4HehaL5kv8ch+lVxBku5ikbL/gpKNNToJs4C6ilzqRbO0HsdcrNcWTg1lQQPbgQT/IeWoftljvIe2RCqXYzQ3TXsbhzTFaveoJDcWb94fms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4lpDSqI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bDebXpyM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GMvXB021771;
	Tue, 7 May 2024 18:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=rdBHNuXf062ZgCw6MMADL0+yAvASM9CNDVDfxkMB0nE=;
 b=l4lpDSqIpLzzqT0dE6ts6CLN614O1suAf4iuhqavLxWMvxW/hjt9eF8whNJVU/0kTO+8
 uN2txNwRebkgyXS7Akftjwzo/g1Nmooz3cGycKJ+FCmHS5BLUrbNcQzEC5XOrj+PQW+g
 +HkzVoRTd2FOQpdG0JVNZx7czT7CuiVHmIdkIfTRUQDTciRehsWP8gyouvuSF9ctf+o7
 pKEN/LrJDr55xWlHRyYXyY8gkJjO55W3Fk6UWY3Dzo390joqZUiGjZdFO8JGK+BTUHtO
 Vf73K52EdRdFp8SJOmQGmB5RhkMFSwI5tQUtYVdpsOGcbu6wWIumQXwyaGryf3PWRxvd uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5nseh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:10:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447Hab5x039392;
	Tue, 7 May 2024 18:10:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7d2p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khSXICLoiFPTuomxPeA/RXwFTcGBOhmvqkZOq1kJdVCiZLM4NDK3TpOHJ6Ln1g6TwnBm8aVRwlo7S9P6PlUXcBBz89PA19NOYSqRLY0Y705ynjNTjx72fJXg4G5M62n40wJBi9iyMYwoqzJBgxz/x13CzrtJ0KNkAZwouG7cc1F6oPnKpFOR+6HI4212Ix0NiraWakXFjIgBL+KfIwWWCBkN+7BCRitohbgCwyLhC6ix9UNNm29egHG+Ll6hPmTb3btI2KFp9IM2nTcbnyeEjDPUrsC1EEFSEtNj+BZeThAWZUNch4ZeO6nZUWBoURG/9Q7M/+5sM/DWyIaTVCoL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdBHNuXf062ZgCw6MMADL0+yAvASM9CNDVDfxkMB0nE=;
 b=e8elRFMp+16OZPwtnBuCdR/XXazEO0EwLgumHar1mMB4JH+nVERxlHttepyNf8bSL5QIdxNXV74YNk4X4eJm9+8LS+n3NSdozCs5WGqijcjSqa0g9Fow/a+6Ca6KSQN6R+oY2mwkcIeRdJ7PUZMEUOiiX6c4ohjXWHE8lueMVU+2Hp3Kdxels17qp1ogXL9+c/JWE/+LpQmKH+sSC2/iBFd/B0Se+nTJ1lrhwTRb07Dzf/eY636A+o0gGVNuPvwEFT1nZTyivXUV2Q9pIEhL5WboqrrnM1R3iaQxjipFsaeM66IP1kiak+09wHfZdyJt6xEinS+9WZH3AzjqpmIc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdBHNuXf062ZgCw6MMADL0+yAvASM9CNDVDfxkMB0nE=;
 b=bDebXpyMbHJKiSRmD1T9H3eyhzYNK1hlg9dyC/RVtcrho8hJPNTpzajTgfN6OGnK9DQ7sQeF8BIiIZTt3Le5DFq7o6kvgcXrBCJ4Wz2dgz5S0kEWfc4e8Csm3Y3ne2N2J36LYqbMSjVXa3AMniQYgEtCfAXR6stAthOLHiYPOss=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 18:10:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:10:39 +0000
Date: Tue, 7 May 2024 14:10:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <gn5i3p6w7ih3pabh6r3vryyauotiajpfnd4ftdn4akt7f242pa@thxj3gzzofnl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-3-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504003006.3303334-3-andrii@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 94236246-4a6e-48d3-aade-08dc6ec10046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lLt+80rVyKLG2eQ8shg/bIHUZm3hg2SRDFw+husCECxzWxMGgb052y3qLAtC?=
 =?us-ascii?Q?RCvo3ZfIr3FAuSo3qLqndPS5Nvwj9kJM3KRittOjfuqLAWr5/9nE/PiVWPcU?=
 =?us-ascii?Q?ESpJFAa4sPjRkKmBtlmjo2RxALoqFpYEZa8XoqOl1/+OE8HNZlP5aQBIdoHc?=
 =?us-ascii?Q?1l32iK0jHTSS39tDV2fKliRwDz3m1Rea6UN6mKV3laPXTjWqkkPBQ1ASt3Xg?=
 =?us-ascii?Q?djBWYoUIckx7SGKOlxcaOsh564X4Qo8c3tyjCDpg5d4i+kYiliwPJn/KuLAc?=
 =?us-ascii?Q?ZwO/f5mooJ5LVd5FY6is9dvcxDs5iZyrvD1JiwH14LFXSSeHw4HdJmTWsZ2U?=
 =?us-ascii?Q?kPKeoIr6BdrKE9eVGidUBJc8xLT1VvIm/+hn1BVMKdQezbryEg1QXnmlvUeT?=
 =?us-ascii?Q?dhVEXfB1Kwxel2m3xVvuwYpg7/p6ekTw2K6jAAY6uqvr5F5OORmoOXQbFNfS?=
 =?us-ascii?Q?+hEObeiYsW+PS8GlPoeUWEGtFTFUcOKUXKKjOUQRs1iEVqpX2LTGVNwRIKej?=
 =?us-ascii?Q?1HiTiSBYQ4rkotH/c07RC1oeujOP/Hfa6+C3nY957xTxNTEJmdB71Lz+kZvk?=
 =?us-ascii?Q?DCpPXFanDZVsdg3encEoIuYLJOcFsllt15PfOzkNPPxIqplKE1Z4+wf2RLgb?=
 =?us-ascii?Q?Jktwmd5d5tJe9KLh2wWi8gc2wAJtkKkF/3zOkzRSQlroDTNv2YlzUtulcOIB?=
 =?us-ascii?Q?lH169k0/9VwT298KVO4N0V6Gumm/SmeO4U5jXT1OR1FIpstXffO3gQD2zJ9q?=
 =?us-ascii?Q?ThLuzRKbODrkPDqSsTeOqTc8/y7+plIxdd7XKhUQ08JiJSGDEJbQchJRoS70?=
 =?us-ascii?Q?FZfRUig5mt3fjdBDirMWs97kDEzi9bDw93c1v15zPx6ahfHY88CyKNTBIGiJ?=
 =?us-ascii?Q?xYwriz/dWRquhoUbnapn9wO0CSm6vWRYV66uB2PLYWi5jX6P55T8REM8ztf/?=
 =?us-ascii?Q?34KMPZkshd5/01yu5ltXQ7hoeF3psty49VcVooTQeMq9Hil9Pq87e7jFIsR5?=
 =?us-ascii?Q?5pPkFOYjcu3uNHG69hq1l3yyWH/myl4sWNczlS9LiqspLxNRUQuIa1evom0t?=
 =?us-ascii?Q?4/Exmntg3FdlBD4H0TqdwCnNewg5gr8tbG/B98DHO4v1xdljUaAEGPuIZlFC?=
 =?us-ascii?Q?r9CJTBKF3deBDFNWRK26AUurI6EUcpA0bf6CShr5RmfQh64jJMHglZsuvGxj?=
 =?us-ascii?Q?ZyKkKnV1TOryOnUYLEY+GrSI1PoouLPbWL23QigvgNWE2hWh3b6spNx5vQIC?=
 =?us-ascii?Q?xjiCv5QVkEi4EzsIZ1WmBKElZXyFtNrJFYs3+u/RXQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Mgs8dY5kTMRuvlw7uilBVyE49lluASfqRkYR/bMpkBszPnReGepp0yscZdtH?=
 =?us-ascii?Q?IWHmprilq3AOo3E7SgdWTfwfn4ls5YoIFKFkQTxaFU40vESibJNkPFsnbPva?=
 =?us-ascii?Q?osm5v1JtIbHOGK6fKhzJBKrSJu4IdHHHg1RPQYzVX+7DE0yPX/aqsHhj+HRl?=
 =?us-ascii?Q?V337hcM+RVaFRKJsxXSewhVJsNcEG8l0ZAaN+/JoWsHBqImbkbSFYVY8EKeG?=
 =?us-ascii?Q?rGlaOv28MqxpMe24W69WZ0tiGEGTLG86hN7UhIZ6l8vA90SEPgbdbQgeB4X9?=
 =?us-ascii?Q?Y7hYQNrWe5JFyGfTpYGWpEiPBaT/UrFhmYrupG4BABmVJTT+Sszl4nj7f25n?=
 =?us-ascii?Q?9k6Q/w3IfF9882jbc+0HQuqjFXzltqNS4YIoSvpnbjWLrkWUO+1xJV70HX8e?=
 =?us-ascii?Q?FVuDuCndfVc1QaNYH7WhDTaKwz9MBZ9+ycbCLGuAvD54cSCVjtWn22ih6jUA?=
 =?us-ascii?Q?Fdp8QiiwX6z0GhN/2aBUPem0uwJrr0ugPJADWPYKpBuAS0OjFvFpJIw5veZq?=
 =?us-ascii?Q?pQPIpeN4npMcAhcgxrcwdzPJ3Bn5l5kDLYf9AUgXA8YYOp5tCTrdRc7+m1ji?=
 =?us-ascii?Q?j4FkHZDXplcq7JgtpSlxDJSdhh+dUYNpV4oqyihZ+LoAvW7aNOqzW27rkiyO?=
 =?us-ascii?Q?oXtj87ynONQhK+NjIEC+guQA0OK1TMMRhPvR/deMDdrDhwbTK+iuHZvx+rK7?=
 =?us-ascii?Q?xtztu8aM3yKph2pbrSg8BvrQGnE7gsign/eotUcETz7b2zAkv+1iYD7YEDOR?=
 =?us-ascii?Q?88+907pt9k+IlikyyOntc02mWw/eSR3xJIgJtIpmy5y6bY2dcfAomr1G6c2K?=
 =?us-ascii?Q?nP58KZsARHb1orGxLsjTAQVNRvBRX6lyOBcsF2j3sFApZry+Q98xc8uIPZz2?=
 =?us-ascii?Q?tvw3L3O+U7umKG1KGVIWQ0E1Djb4Auz/nkgwaTPsWh6G2qgEhRLJ+Z53viGo?=
 =?us-ascii?Q?YxxReJWYkuYX4YzRkgEi8m7xDOfFrywg/2uKo2zsZSkD7JjDa0vY1Sr0jJWy?=
 =?us-ascii?Q?kLvfzjhYPJvmQFi74HzLgmljVaXFCgau6fPB1GDL3WS876jVyL4/jppu15UR?=
 =?us-ascii?Q?VXDAHkpgsqVt6Ex+PIjMlYmOO2dnWLIBUv2fMoMp2/0sKKKGAVec/Z2zCN8N?=
 =?us-ascii?Q?O7RSPyDG7q1rTbWlln0elxkoRzUc6PvTThXhUUmrD7WvSXIEwnbBRQsyufzp?=
 =?us-ascii?Q?qs4lj7RIpV15kABZwlER/DhrCjMWMkBIQaKz3JK7eadF9sqHgxYFa3YDjzd6?=
 =?us-ascii?Q?OLoCmo6B45uslTkVfSySHsNHIK0wtyn88Uvchugi2ua7e+f45t7/F6Fe3ppE?=
 =?us-ascii?Q?GUfAMLPDopx/D7i56dURkX5fzMTCUSB1q3RxdnC78X+OfJPGLm+nrCAi9i4Y?=
 =?us-ascii?Q?VSjf4K8zG7JZ+BJJWMoRieAVtZ0O9XtVxM6WlT0s44RWD1CJZwSzwvcpmJ5m?=
 =?us-ascii?Q?JuktT93vw9Cwi6DfsSTHTWi58oS9V3Yae1PplinpAIesuZ31pnna4b6XYrJd?=
 =?us-ascii?Q?c6sZeTEKxpUrHT/rO9Ze6k4k/ZhNYgD7LmZ/yM58MYLl74ZyFaM9n1qSj7rQ?=
 =?us-ascii?Q?naXqifP0uSA5BhgV2m/cjJvQvlyYoXmiHv3z3cTlZ7pWhN9uur5c8nCwEohp?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HTixbqiXBOAn51KqMNpV2dSKhMJ2F5w/6qSeAsb+nhYAfpU6ZVKnRFzFadvz6XGWvf7HmH2dxRR5F1lr7TvWW6UCf55Bd1wVKxLwF1NmYRqjJBqeKVq+hPIH7GHA2JYNrTTtoVd6bAvc7GZ40Y3rDFyG97cp9Cc+KLqzXbarv28B8QZshskRyAwZ+K1XhXzRPRuo8SrwbC4IOwMA44PN+thrIkDEwVFK8yvw2/mV6q5mMfVzHG2AaRZRxh+wC5WmNVkL4catojYg/2UYU2xK9JUkUG4FkzBy42Pos8hKjLXvB+dwPqjPm+Fizk0vQCmaDdEzLd8W4+Be8alwyPk9AozgrJDY4Pi+1I/YI5mnP2PF+m5V4BDpTpdXr6BNRAvWKfflTWKd+2iMAwa+D+3Vsi6Q0dixIkmXfeA/2Sr/qC9L90scB0pZ3C7HqcWj7jg9GJcpZ80++FMI4K/sKgjiKo0TvVaVgcWWFvq22uPOB1aEYldb5a3QuzHrGp4CaAegDVm0lwgFqIK+tEi977cTEeucS33bujGrh5nNIv/jwq/gumjzaqWWqF63eOfz6dBJSinPWisNfImtw4SENYNffIjVcYymZK+sx34l5kjdYGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94236246-4a6e-48d3-aade-08dc6ec10046
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:10:39.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22oKqp4ePV9efqwt+46l6mV0LJ10iTu08pZqNs1eF9EfN7zB63wfmaawB+db3jXAlUtdx19tn9u/uKpT/gNyWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070126
X-Proofpoint-GUID: 7QslGM8QGpVtmsApifI7R0wDIrTFoxAO
X-Proofpoint-ORIG-GUID: 7QslGM8QGpVtmsApifI7R0wDIrTFoxAO

* Andrii Nakryiko <andrii@kernel.org> [240503 20:30]:
> /proc/<pid>/maps file is extremely useful in practice for various tasks
> involving figuring out process memory layout, what files are backing any
> given memory range, etc. One important class of applications that
> absolutely rely on this are profilers/stack symbolizers. They would
> normally capture stack trace containing absolute memory addresses of
> some functions, and would then use /proc/<pid>/maps file to file
> corresponding backing ELF files, file offsets within them, and then
> continue from there to get yet more information (ELF symbols, DWARF
> information) to get human-readable symbolic information.
> 
> As such, there are both performance and correctness requirement
> involved. This address to VMA information translation has to be done as
> efficiently as possible, but also not miss any VMA (especially in the
> case of loading/unloading shared libraries).
> 
> Unfortunately, for all the /proc/<pid>/maps file universality and
> usefulness, it doesn't fit the above 100%.
> 
> First, it's text based, which makes its programmatic use from
> applications and libraries unnecessarily cumbersome and slow due to the
> need to do text parsing to get necessary pieces of information.
> 
> Second, it's main purpose is to emit all VMAs sequentially, but in
> practice captured addresses would fall only into a small subset of all
> process' VMAs, mainly containing executable text. Yet, library would
> need to parse most or all of the contents to find needed VMAs, as there
> is no way to skip VMAs that are of no use. Efficient library can do the
> linear pass and it is still relatively efficient, but it's definitely an
> overhead that can be avoided, if there was a way to do more targeted
> querying of the relevant VMA information.
> 
> Another problem when writing generic stack trace symbolization library
> is an unfortunate performance-vs-correctness tradeoff that needs to be
> made. Library has to make a decision to either cache parsed contents of
> /proc/<pid>/maps for service future requests (if application requests to
> symbolize another set of addresses, captured at some later time, which
> is typical for periodic/continuous profiling cases) to avoid higher
> costs of needed to re-parse this file or caching the contents in memory
> to speed up future requests. In the former case, more memory is used for
> the cache and there is a risk of getting stale data if application
> loaded/unloaded shared libraries, or otherwise changed its set of VMAs
> through additiona mmap() calls (and other means of altering memory
> address space). In the latter case, it's the performance hit that comes
> from re-opening the file and re-reading/re-parsing its contents all over
> again.
> 
> This patch aims to solve this problem by providing a new API built on
> top of /proc/<pid>/maps. It is ioctl()-based and built as a binary
> interface, avoiding the cost and awkwardness of textual representation
> for programmatic use. It's designed to be extensible and
> forward/backward compatible by including user-specified field size and
> using copy_struct_from_user() approach. But, most importantly, it allows
> to do point queries for specific single address, specified by user. And
> this is done efficiently using VMA iterator.
> 
> User has a choice to pick either getting VMA that covers provided
> address or -ENOENT if none is found (exact, least surprising, case). Or,
> with an extra query flag (PROCFS_PROCMAP_EXACT_OR_NEXT_VMA), they can
> get either VMA that covers the address (if there is one), or the closest
> next VMA (i.e., VMA with the smallest vm_start > addr). The later allows
> more efficient use, but, given it could be a surprising behavior,
> requires an explicit opt-in.
> 
> Basing this ioctl()-based API on top of /proc/<pid>/maps's FD makes
> sense given it's querying the same set of VMA data. All the permissions
> checks performed on /proc/<pid>/maps opening fit here as well.
> ioctl-based implementation is fetching remembered mm_struct reference,
> but otherwise doesn't interfere with seq_file-based implementation of
> /proc/<pid>/maps textual interface, and so could be used together or
> independently without paying any price for that.
> 
> There is one extra thing that /proc/<pid>/maps doesn't currently
> provide, and that's an ability to fetch ELF build ID, if present. User
> has control over whether this piece of information is requested or not
> by either setting build_id_size field to zero or non-zero maximum buffer
> size they provided through build_id_addr field (which encodes user
> pointer as __u64 field).
> 
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this,
> requiring applications to open underlying ELF binary through
> /proc/<pid>/map_files/<start>-<end> symlink, which adds an extra
> permissions implications due giving a full access to the binary from
> (potentially) another process, while all application is interested in is
> build ID. Giving an ability to request just build ID doesn't introduce
> any additional security concerns, on top of what /proc/<pid>/maps is
> already concerned with, simplifying the overall logic.
> 
> Kernel already implements build ID fetching, which is used from BPF
> subsystem. We are reusing this code here, but plan a follow up changes
> to make it work better under more relaxed assumption (compared to what
> existing code assumes) of being called from user process context, in
> which page faults are allowed. BPF-specific implementation currently
> bails out if necessary part of ELF file is not paged in, all due to
> extra BPF-specific restrictions (like the need to fetch build ID in
> restrictive contexts such as NMI handler).
> 
> Note also, that fetching VMA name (e.g., backing file path, or special
> hard-coded or user-provided names) is optional just like build ID. If
> user sets vma_name_size to zero, kernel code won't attempt to retrieve
> it, saving resources.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  fs/proc/task_mmu.c      | 165 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  32 ++++++++
>  2 files changed, 197 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8e503a1635b7..cb7b1ff1a144 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/minmax.h>
>  #include <linux/overflow.h>
> +#include <linux/buildid.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -375,11 +376,175 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  	return do_maps_open(inode, file, &proc_pid_maps_op);
>  }
>  
> +static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> +{
> +	struct procfs_procmap_query karg;
> +	struct vma_iterator iter;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +	const char *name = NULL;
> +	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
> +	__u64 usize;
> +	int err;
> +
> +	if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> +		return -EFAULT;
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +	if (usize < offsetofend(struct procfs_procmap_query, query_addr))
> +		return -EINVAL;
> +	err = copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> +	if (err)
> +		return err;
> +
> +	if (karg.query_flags & ~PROCFS_PROCMAP_EXACT_OR_NEXT_VMA)
> +		return -EINVAL;
> +	if (!!karg.vma_name_size != !!karg.vma_name_addr)
> +		return -EINVAL;
> +	if (!!karg.build_id_size != !!karg.build_id_addr)
> +		return -EINVAL;
> +
> +	mm = priv->mm;
> +	if (!mm || !mmget_not_zero(mm))
> +		return -ESRCH;
> +	if (mmap_read_lock_killable(mm)) {
> +		mmput(mm);
> +		return -EINTR;
> +	}

Using the rcu lookup here will allow for more success rate with less
lock contention.

> +
> +	vma_iter_init(&iter, mm, karg.query_addr);
> +	vma = vma_next(&iter);
> +	if (!vma) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +	/* user wants covering VMA, not the closest next one */
> +	if (!(karg.query_flags & PROCFS_PROCMAP_EXACT_OR_NEXT_VMA) &&
> +	    vma->vm_start > karg.query_addr) {
> +		err = -ENOENT;
> +		goto out;
> +	}

The interface you are using is a start address to search from to the end
of the address space, so this won't work as you intended with the
PROCFS_PROCMAP_EXACT_OR_NEXT_VMA flag.  I do not think the vma iterator
has the desired interface you want as the single address lookup doesn't
use the vma iterator.  I'd just run the vma_next() and check the limits.
See find_exact_vma() for the limit checks.

> +
> +	karg.vma_start = vma->vm_start;
> +	karg.vma_end = vma->vm_end;
> +
> +	if (vma->vm_file) {
> +		const struct inode *inode = file_user_inode(vma->vm_file);
> +
> +		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
> +		karg.dev_major = MAJOR(inode->i_sb->s_dev);
> +		karg.dev_minor = MINOR(inode->i_sb->s_dev);
> +		karg.inode = inode->i_ino;
> +	} else {
> +		karg.vma_offset = 0;
> +		karg.dev_major = 0;
> +		karg.dev_minor = 0;
> +		karg.inode = 0;
> +	}
> +
> +	karg.vma_flags = 0;
> +	if (vma->vm_flags & VM_READ)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_READABLE;
> +	if (vma->vm_flags & VM_WRITE)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_WRITABLE;
> +	if (vma->vm_flags & VM_EXEC)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_EXECUTABLE;
> +	if (vma->vm_flags & VM_MAYSHARE)
> +		karg.vma_flags |= PROCFS_PROCMAP_VMA_SHARED;
> +
> +	if (karg.build_id_size) {
> +		__u32 build_id_sz = BUILD_ID_SIZE_MAX;
> +
> +		err = build_id_parse(vma, build_id_buf, &build_id_sz);
> +		if (!err) {
> +			if (karg.build_id_size < build_id_sz) {
> +				err = -ENAMETOOLONG;
> +				goto out;
> +			}
> +			karg.build_id_size = build_id_sz;
> +		}
> +	}
> +
> +	if (karg.vma_name_size) {
> +		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
> +		const struct path *path;
> +		const char *name_fmt;
> +		size_t name_sz = 0;
> +
> +		get_vma_name(vma, &path, &name, &name_fmt);
> +
> +		if (path || name_fmt || name) {
> +			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
> +			if (!name_buf) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +		}
> +		if (path) {
> +			name = d_path(path, name_buf, name_buf_sz);
> +			if (IS_ERR(name)) {
> +				err = PTR_ERR(name);
> +				goto out;
> +			}
> +			name_sz = name_buf + name_buf_sz - name;
> +		} else if (name || name_fmt) {
> +			name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
> +			name = name_buf;
> +		}
> +		if (name_sz > name_buf_sz) {
> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}
> +		karg.vma_name_size = name_sz;
> +	}
> +
> +	/* unlock and put mm_struct before copying data to user */
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
> +					       name, karg.vma_name_size)) {
> +		kfree(name_buf);
> +		return -EFAULT;
> +	}
> +	kfree(name_buf);
> +
> +	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
> +					       build_id_buf, karg.build_id_size))
> +		return -EFAULT;
> +
> +	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
> +		return -EFAULT;
> +
> +	return 0;
> +
> +out:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	kfree(name_buf);
> +	return err;
> +}
> +
> +static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct seq_file *seq = file->private_data;
> +	struct proc_maps_private *priv = seq->private;
> +
> +	switch (cmd) {
> +	case PROCFS_PROCMAP_QUERY:
> +		return do_procmap_query(priv, (void __user *)arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  const struct file_operations proc_pid_maps_operations = {
>  	.open		= pid_maps_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
>  	.release	= proc_map_release,
> +	.unlocked_ioctl = procfs_procmap_ioctl,
> +	.compat_ioctl	= procfs_procmap_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 45e4e64fd664..fe8924a8d916 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -393,4 +393,36 @@ struct pm_scan_arg {
>  	__u64 return_mask;
>  };
>  
> +/* /proc/<pid>/maps ioctl */
> +#define PROCFS_IOCTL_MAGIC 0x9f
> +#define PROCFS_PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 1, struct procfs_procmap_query)
> +
> +enum procmap_query_flags {
> +	PROCFS_PROCMAP_EXACT_OR_NEXT_VMA = 0x01,
> +};
> +
> +enum procmap_vma_flags {
> +	PROCFS_PROCMAP_VMA_READABLE = 0x01,
> +	PROCFS_PROCMAP_VMA_WRITABLE = 0x02,
> +	PROCFS_PROCMAP_VMA_EXECUTABLE = 0x04,
> +	PROCFS_PROCMAP_VMA_SHARED = 0x08,
> +};
> +
> +struct procfs_procmap_query {
> +	__u64 size;
> +	__u64 query_flags;		/* in */
> +	__u64 query_addr;		/* in */
> +	__u64 vma_start;		/* out */
> +	__u64 vma_end;			/* out */
> +	__u64 vma_flags;		/* out */
> +	__u64 vma_offset;		/* out */
> +	__u64 inode;			/* out */
> +	__u32 dev_major;		/* out */
> +	__u32 dev_minor;		/* out */
> +	__u32 vma_name_size;		/* in/out */
> +	__u32 build_id_size;		/* in/out */
> +	__u64 vma_name_addr;		/* in */
> +	__u64 build_id_addr;		/* in */
> +};
> +
>  #endif /* _UAPI_LINUX_FS_H */
> -- 
> 2.43.0
> 
> 

