Return-Path: <linux-fsdevel+bounces-13468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70CA870243
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D865288481
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A33F9EC;
	Mon,  4 Mar 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+ZcCZpY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="shJrmZI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A813F8E6;
	Mon,  4 Mar 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557662; cv=fail; b=TDBwBkV4OeqdlaDcH6UOIouR6RYQtR5qb5nidrJNPOH4JQoUwUTqvNt5NPFKyAKd/ijj2Jf7ltpjmWew6x6fSF3qqe97ofovqOl1WfsYqe0mom+QFLTd02rOTGu+P9rCleSqoDLlYsOJk5FFPcoD+PFrOtKEsg96Eq+xIXJ8Oqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557662; c=relaxed/simple;
	bh=4/0UaAWrYPV3jf2pMqAzhPTGodEsep2086jP9lBYW2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ypa4Z01Bj4cCMi3rOyCIPTGvIecmdaB41BojoTH+8144vu6YCKo8cl3HNc3HrXb820uSZ0Ac76nSN7zx9pgq7ADMuG3DgQfpuHE07ySUbXHpdxbm4faAAwn2eT0oOE9fY34zwHUzsl0S52XrK6O1J1vigxBVO8bHR+8D0rlQsW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+ZcCZpY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=shJrmZI8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTmKP006052;
	Mon, 4 Mar 2024 13:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=e3OmCewsJ2y5E6Njd6QGlj9m0X84Mk2nVaejCFbJo1k=;
 b=J+ZcCZpYRjXhbZh1ZMDzjipzcaU27SOolCTgq0PoUwb/QHbyzm72i2oFuyf00ZRDVaxK
 TmpJ+sBS+RcAw/J+Kl7r0FqxbHP9lQPsWR6wd+1fH+Uk4kE1N8iJg1VAJvsO7xu18sKd
 PLdTPgZHwDZiHbMF2G9Og8GkXmmbDEu0wZGofkE6pL+TVy7PUE8J7SPBPX06rx74FqKJ
 16RbiBDGi/YiZDh/HQXOoyDubKhL5BwPVgVgzlaLhHsQb4SKUprrq5x11uXA4TRow5iM
 ++BcUaDwLhOiz5bcBq8O4SegpcT699cyCVeQWptKjjSWj/1w4ipyuNKGYnAxFst6frYw vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cbh84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424C4NK4033209;
	Mon, 4 Mar 2024 13:05:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj63tpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty9ZmO9okuJ4DUESCzHRC1bzR4jHF3bCP41HDjND6aEY5U71ZKDicpz8zoofn5dIjxE0Q1u2Y1LO/QBynFOOmKlZGFIuWFLDL6v7ak43+vTS4+BrF5DaFVy3tr8TzcjpDIfM4fd/Gk7DGA2PtgFxEUqnSSCXU1n900rcgsE+b+B7DE4QaPTz2Mvjd1ddyo3a1CnGONJk+mpQ6XUkGBkDVKjG/enn2kfZoD3hRUDqyAF9/DREm+n8lV8fuD4BIQ12LuamMRkcQseZtMnIjny02+5ClADOEE/KS+w3kQY7kH8pRY1X9Ch2suVf2tOGc0fP/BKa8YIQ7wt0Ggs1lXHX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3OmCewsJ2y5E6Njd6QGlj9m0X84Mk2nVaejCFbJo1k=;
 b=eR8VPTelGXOUi91dBvBSZ1IlzVTNKeg5kHNQ/m4Nj3aKdOloHYcwyJ8r5IVGhMMiHqE13owslmABs+kmTdBn73XtKSmZnQDCdrtl8RYFC8JBRVnsAPpimflVeego7oQIf2PesfdlvoPV+EsI0UzaCIw3Rp4oqvXBnI12yASXTl7rJAWc2n5/Jtwo0+tb51iJt9XaWLB73hIa54/AMUMVW167yeKQ7Tp4rELQfHRwxb1+2XKK6vwCRk8GG4DgvC9VHOqSYv7L71+IwbOSqzoF6r1/klNKX9FKtjVEuRKrB9bfKzdDyuwqPPIasslRC9ssRuV6Fp8v3beZiXyGfuvOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3OmCewsJ2y5E6Njd6QGlj9m0X84Mk2nVaejCFbJo1k=;
 b=shJrmZI8gP3riY36Vhg80o3fD2pXaXenk3z2wL+SJAstgyXiof7faMYc+GuW/k+kPciG/NZqWk86H7pShXOBgs43IqgAH471S+FhsZm4JVdpb5YvyTtZf6sYN7jufrPoaNPcc/ukZe7niHOMEpb9Uczz7SKDe0brd/mCuowLkP0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:05:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/14] fs: xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Date: Mon,  4 Mar 2024 13:04:25 +0000
Message-Id: <20240304130428.13026-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 1685b78a-afed-47d4-c930-08dc3c4bbf4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vt27Gf6rfrfwXpvp463+ZzZDPVR7ikMJtbYbY6+W2TXo4tWN0qPI9djsIMwh1EvswKgk672/1LMwLHKnWeBkq5dvMIl7NGROBekliozSp2eCfFYLVw6f62gJHwmzQvsjpBBMgt5tstupaqndGey6xe+n8t+vnilQxVW590wuwWq5wSeDIYBkgntbNLpMksk/aEreDJj8XocTi9/2MPdfaXj3sSI/lPzyO2whoLEfUaj6xUoYdkEADZgwO76M6AmmFSvRfqITdXK5O+r2J9gwcbPeOK2bSb+bw1EoJMjw6Nsu9K7a8CiKsI6EsNfDjWpd6NYPNlT3yHUFtmevkIrjofvmbWPsM7fy8ZfFmvtZlhzxIPYPu6GMky/mHE0W9Zg4SoIL7hoxcP+Ektf4s7cHd4CXiklmizGaCaRd/vN5Uav66BhXOwdTM+mHO561H5s7xFG7OWyRhwutbenKUxV9/AfL80GNrovydEerC/z3AfDwCco3yL7O/RbXjaCYQIZXdtq+FtM4yGtUiITRJugOjN+sttYC7PH1Z7Y+4Msa3vPlSF8VLpb/739ksQxO33DNwTV9VidQ6gc6bFQfOADFjCaPXkWZQGSESV3ESQ2BApvCMVHXzp0SyXJ6TqH2dE3HRRd0mY/6GDWqruCU8BaM7JbtvePKjA/QxwLdfzK7F/0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ahCPfA5vhq6aBzPQjOOJoJ8U6JRGrpIwBX3d4IVkvlToBtD3hVje9zIbGukw?=
 =?us-ascii?Q?AJFQZNCfoR4tJ6A4uLTWRyHdnofwTqEAb6FbXK9nUhb2ZVXCtWW9xHb2pW3I?=
 =?us-ascii?Q?smZmZd/bUs2WylrolH/PVFcDAZ6uD9S0Wbm1EaVdhZTMSPpwakFnJ5h28vpj?=
 =?us-ascii?Q?e9VTqknNjYBrMib4sCQ1lMSfSUrbACqFya+o1zYJWkkNNy9Xels07q3uvxfV?=
 =?us-ascii?Q?pwYpLOug59m/NRExsBjnXLY6qtFThh1mSkDz+oIroKZfO5J3PlyWK8sHwcYY?=
 =?us-ascii?Q?jG38s5arc0jVJz6Ah9nYheG0Cq1mRNuD2VAAn9hXNEVrewWqzVr6tZhPAk62?=
 =?us-ascii?Q?ogormB25NAbPhngHW8LWgZxbfHR2p7Sn/zdJ35+yhGFsgzE2+6+SGXda4UKw?=
 =?us-ascii?Q?OXmZIl4mpbQSqbs0jrVx5SnEoZz/XSuoniLIE/D1KWJ7PZcGDJWbrpuGvCUL?=
 =?us-ascii?Q?KP02VwGpxX3WSHLjNGBhMtgdx0n5VZPaBYzlty+3VK42xh2ugytfraUC30ye?=
 =?us-ascii?Q?8Zt6ktRyFEnNQg4fRY7cTnZcOn2ElVTKF5jMGlWV6hZiY+3gdaPGLQhKebsU?=
 =?us-ascii?Q?by2ZG6NdoHROo2kVx+48JQZj8JQyT6glHC7mC9W6NJjmiNEvVF76yV/ARNj5?=
 =?us-ascii?Q?/sRXTSqsxn04hbrwjLLLsXdv2fV8ihZVPU/aBxRXvHewtwFmW8o5Dz0gU4K/?=
 =?us-ascii?Q?uNbdSBt+1GlsO9D2tlSmf2R/k4TfQ1dNd5V5xcJW9iFvstT/OkUX/Sx8AyMq?=
 =?us-ascii?Q?0eWVzE4zEwWH8WF9lWfDJPZ9aS/OCEMI9q0yo85hZJ5a3rDwldfDDLye6p/h?=
 =?us-ascii?Q?4fCvDtiOOCDKPPmrlMfFELKly4QtQLAuNB1gm1ifgkU0J3Bnrq2vhLwDpeVm?=
 =?us-ascii?Q?qNT8O382eZMNvfZpF0F5/+45w8m8PgoLhP9z93MOS1TtWWZs96tEOKcV1hM9?=
 =?us-ascii?Q?/aWrVjtO7ocPc4k/oSnwLBK52xjpgdeYsBKiJwThSGT9ossTZATBCNbzvcx/?=
 =?us-ascii?Q?BuRZl0UU66zC5Hm3psGOOLH0FGpeNFs7J+eBN2hCueOEEIBpKOsVlP2pbWno?=
 =?us-ascii?Q?RxoOgI19OVoQeMvaumIgBpVvJpGb1Sp6xDteOLat1jATILFQoAKCHT0hgT/d?=
 =?us-ascii?Q?CTzuebQN/17LyGDzfCnZH1po4YLuZmfmAhkPHnI6djlKqBPmlzlShrLmdfJq?=
 =?us-ascii?Q?ZEPw7WEDiIWph2vYqrq3XY+2sImUDkL17/jrL+EZzvSsgzn/9HN3WHRxcqvc?=
 =?us-ascii?Q?iUdvMYMpqAIW+HK0dBSIiXWWXjagncqshQd75cp9d5WuYXuh8HnwSXdWC4kV?=
 =?us-ascii?Q?1eeUFUpk8ks6b+SGmuo1Fk88WZ2WxsOgY7EXvJ+f3225G/dEQeO095G2GnhW?=
 =?us-ascii?Q?ARnzGp3xF6ljGguOTNKmbafLtGl6aJI7SkUC/aCke7i9bLXhX7LTEAiE/Sho?=
 =?us-ascii?Q?fHlZmAbV0/DBbzrduKBvE20Abt5j0LuD20exruCtZBdcHpeDqGXTyC+VwC05?=
 =?us-ascii?Q?GqHKKZoC/CeVPMqpzkjQHkjm8hjrqvlD6DA4hijbC9gmqhQ+cjbgbVwrz1oR?=
 =?us-ascii?Q?hS/Q1J0YtIRv8QtCNzPIlFgpq6Jxgy/VSolmKfctF4jC2ycQNfGOEXJBw42g?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fCVrRGWQ6f+cvswBGzjfKGvPYSE8RKIVGj1XTcnohX9aRUseWSyOHbT+sk/ZcPyMg5ZVQtUphjpTu/6mBoC9bNDDhT+y09U5Hj0Ak3GC3t6MnkRUUda5e2Av3D00GzwNEmQ0dAWW/VEg6ZqhA7GIyYmL4xqRmTKBm7PM1nva/uXOOkwGb5tpTvMZeQ4+d1uCL1RhCxWrlRia07T9oF/gohNUITggp/HuV4Ssey8sU4M9jg2a/UNxVlIkzyFgutcu3xTY2TUkU1x6iUja/D2yIotMlHDFpsmJ8zjreZ/3NOBWX1qvgPCqCxbX0Ozp3i5D5GF78Es5jeNQ+WvWg7mDwahRWhj3DeO9v9Gg7I5mfAFVvV/f+Qs0foyk9UWy9uBbcYoR0oa/I+8HlwNovF69bBA+zplwTS+uHAIYdog3QVFf6zg/mR9mjFfooSOiOip2hCtw4u8Q+kpxuPvixo68QIqjT/43fC/8RoWMoI8bZA38PNYYKpefFvpEoKgP+wp114v4v7I4O//dinNM9UI1YbgE2NP1gOFab1bYHJCJ0wUp2tWA7WNQR9cAah/HUc1eH44CHZ9iFEm3Q5iWlvRHkcDHtcaHpg1JfnqBvm2t06I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1685b78a-afed-47d4-c930-08dc3c4bbf4b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:21.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpN6fTFGdVHmhyaGYHc+/KMORZTZazmFlDL7yFg1jLEw6JvPaZ1X0BfT0hLarNNd9sqBGRjCGGXDIq+PmowJng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 51tZ7tmXIsdxhnYh6LACNUw2hQ1_5-BD
X-Proofpoint-GUID: 51tZ7tmXIsdxhnYh6LACNUw2hQ1_5-BD

Add initial support for FS_XFLAG_ATOMICWRITES for forcealign enabled.

Current kernel support for atomic writes is based on HW support (for atomic
writes). As such, it is required to ensure extent alignment with
atomic_write_unit_max so that an atomic write can result in a single
HW-compliant IO operation.

rtvol also guarantees extent alignment, but we are basing support initially
on forcealign, which is not supported for rtvol yet.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h | 13 ++++++++++---
 fs/xfs/libxfs/xfs_sb.c     |  2 ++
 fs/xfs/xfs_inode.c         |  2 ++
 fs/xfs/xfs_inode.h         |  5 +++++
 fs/xfs/xfs_ioctl.c         | 15 +++++++++++++--
 fs/xfs/xfs_mount.h         |  2 ++
 fs/xfs/xfs_super.c         |  4 ++++
 7 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 2d9f5430efc3..5f54f9b3755e 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -354,12 +354,16 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
-		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \
+		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN| \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1089,6 +1093,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define XFS_DIFLAG2_FORCEALIGN_BIT 5
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
@@ -1096,10 +1101,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
 #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index f2c16a028fae..d7bb3e34dd69 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -165,6 +165,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_INOBTCNT;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
 		features |= XFS_FEAT_FORCEALIGN;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index bbb8886f1d32..14020ab1450c 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -645,6 +645,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_COWEXTSIZE;
 		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
 			flags |= FS_XFLAG_FORCEALIGN;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index b6c42c27943e..f56bdbb74ad7 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -310,6 +310,11 @@ static inline bool xfs_inode_forcealign(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
+static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 867d8d51a3d0..f118a1ae39b5 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1112,6 +1112,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
 	if (xflags & FS_XFLAG_FORCEALIGN)
 		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -1124,10 +1126,12 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
 	uint64_t		i_flags2;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or atomic flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    atomic_writes != xfs_inode_atomicwrites(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -1164,6 +1168,13 @@ xfs_ioctl_setattr_xflags(
 			return -EINVAL;
 	}
 
+	if (atomic_writes) {
+		if (!xfs_has_atomicwrites(mp))
+			return -EINVAL;
+		if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
+			return -EINVAL;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e1ef31675db3..3b60d8a1d396 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -290,6 +290,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_FORCEALIGN	(1ULL << 27)	/* aligned file data extents */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -354,6 +355,7 @@ __XFS_HAS_FEAT(bigtime, BIGTIME)
 __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
 __XFS_HAS_FEAT(large_extent_counts, NREXT64)
 __XFS_HAS_FEAT(forcealign, FORCEALIGN)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 74dcafddf6a9..efe4b4234b2e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1712,6 +1712,10 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 "EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
-- 
2.31.1


