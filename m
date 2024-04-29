Return-Path: <linux-fsdevel+bounces-18143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9B8B608D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3751728118A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE812B141;
	Mon, 29 Apr 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xlv7S2xS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WNDhmIzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC11292FC;
	Mon, 29 Apr 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412974; cv=fail; b=pk+5RSkM9yEXeksrI4PlKu8Bme5ie/XVV57PMCnA9/TdxbiRRnIQOWw0+1acDC10q3Ob+tb6ez9iC05dShKZpPtC/v3sm4TJUJja3RiAR+roVqAPNWUanQey9Dtqn7dhTyGtzE4UdhnibyDQ3pGZAlcm5NDghZDC/jcXzg6h2iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412974; c=relaxed/simple;
	bh=iHCHI6mi1dkX8hWRb5N7guyQSaNUC7ecYv4z32iAUgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHLuVv1x+DKBnMhtqyZDIIuXiCzPRy51Au1Qx5VPdikOQxShi3mrlpFG33wy1G1EzQ6DHqVBQKBvBqpk7V2rbAQyIydd/lgGVaMEKZzW4KxZacDlBOWWLPi+INAOEM9u/P4Ipc2EmuIumjshvwOYsiq9h5gEj1JLmSuTcxZrKtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xlv7S2xS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WNDhmIzE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxRa5020045;
	Mon, 29 Apr 2024 17:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=z5fiq6XyRE51nFIbwNmIhlOIF8X5RoQbq2JLAjay9UQ=;
 b=Xlv7S2xSHLXhF5xZDY4IB2h5scu2TrRuQd7L0Dv2sDuj5bacptZag3Rk6i8q1Q81DcQD
 NpxCyHOXu7KjvXaT7P7Hn+mvuj5uayN3ZAJ0Q/WO+QnRfDEHbZjZCx2/OxOQRHuNTmg9
 +O3uYlbcVTLIXZasstPSf7F9FDdQG4BLI0OcZTjjQvz+0X9BKk5LBr21VGTsfaLNjUHs
 yN3EhDtcv0BZFd+5jiHAmfY8ctK0KY4pBQbtQhyei2UzSO+wyFZwFTDsWfmVFEX365Sg
 s0il3Ij0SOHw1XLFZehZ/s4PEV++/MVNd3vL8YheRqGY0S/NN0pCdVTM5Kj46a2FFwh3 ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8ck67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUL004324;
	Mon, 29 Apr 2024 17:48:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqs01GnvTOmmeUgelUSsy16Djgn1fX1vh00EiWQCCRubU8gfxcWmr8fBEJFmmqFKBwyIM7bDZ3VHVjhN8ZLhMtK3YzneYu4baFiIJF2vQIPslMTF+u9SGKis0orIIVgOdlUdUyr9K/hjiikbuspAsCfHy226YfK4sZAgKDMIk6zJEiGBEJbnO61C+8+lZpgZDDmHj/WqiSM7ulljDWKMAI28+XqQ2Vtc5XwIVu1c1nTQmLo3vUQNGlRmOO5mi36P4kD73UVOY7eSP6rOjgVHfMZwZAnxvWKAy8QihDeTR3Lk57yYr0i171X8hMNSZJvKODcgAwDb5siHOiwhyvihZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5fiq6XyRE51nFIbwNmIhlOIF8X5RoQbq2JLAjay9UQ=;
 b=dRlujkZ15p+28AKI18cSffwUiF5tFndBoXbwcoMW05SeK59Y9py6fD7MYb+wASXIFrtrRvF/7upG5BEnXdl3lVQkJHaQXzGftZJ94jd7HPc5p83VWZ99wNWU4RckfJ2prVxUDN61uAwZh98L4Ejx2jvfY+cVoRepT16w0y2UWELGp+pF2OP3eesP2BIb/WKRYn3w69B7Bds9rb2A4QYVrAyCxgTmcRrsJsVVenZKfdTeILHcaMBcdzMNgP1kqJF43dSIZ28KniHQ/U/O+S98IgtBJzOlpgKaLXb0ER7mXV0CbW5//dTpgkxVTlYnhMBTHzUNkH6Wp3fKegNorbUnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5fiq6XyRE51nFIbwNmIhlOIF8X5RoQbq2JLAjay9UQ=;
 b=WNDhmIzEGjfjA1lT6jJ1PKxFwjrX+cqUdKRd8bz8XIDRfkpPeBl0tcwG/uvmAGTsq2uAEy0OT96QtFQYDxC3h1tP0UY9iqNoXJ/7HYdn/cg5AQajwpCO/ZoG1GtmMMb3aXGq/reJFLuj1XfV+kKArw00G4fmr+O1janPfdoCLzM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 01/21] fs: Add generic_atomic_write_valid_size()
Date: Mon, 29 Apr 2024 17:47:26 +0000
Message-Id: <20240429174746.2132161-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbfbcf3-4c58-4f31-f6b9-08dc68748610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K99eoXrHtu8GM/dQZ4N0ugIJO9pvSbf0zPMgiBrluj9qjGqJhus2SJlt6pyV?=
 =?us-ascii?Q?3fkVJ4tPdgwLtG7lDzCJBpL46t0wFqnt6Jg9AxSMf0pBWTGHkz37oZY70NSc?=
 =?us-ascii?Q?Bi9bGg0g3D8G0awuD8ZEdbV7wv+2oVrV2nvRJ8IUUnh8PQGD3OHbbWDLVnon?=
 =?us-ascii?Q?9NA7geoDvCVq39Su8KEsopvZFhW2p1zVUNAUbOCHaueXrV2ixh4QddpkgPdu?=
 =?us-ascii?Q?K44dJkF181ckql+z3c4qARnVW8zqwSQ8uOnItVx1Bd7beKbM68oYY85GRscK?=
 =?us-ascii?Q?Z4g4wpY0uwBmoTQfsr9HNn14Fj6hW/OQhZv3dPAnNKVmaUsB3f9dvZIkwygg?=
 =?us-ascii?Q?Hkbdye89WNO0Xp6rr9Q8LyjcY1euDGGvjd4Rc3uNZyeEp1lsebfQsUbdTdnP?=
 =?us-ascii?Q?EW4Dv29+HnFYr2gS0ZKQ7lrXx5q2HC2Of+QmJ96VEM6yTUBRXNh0ut59k8PB?=
 =?us-ascii?Q?/sIotYVgSDiZT+OeSBjiJ5uUte1of/wg4ss66ODjKKjzVX9MhwtNYWJM2I9Y?=
 =?us-ascii?Q?4QlXrM7JnMxJwq13Uyw3WuxpeE9Af38tvhPsn9Ecnv2Lw+TCHqGPx6gnuxZP?=
 =?us-ascii?Q?IkRoaa1HuCRacfZyxP/id5DqCrVxGYLuGV7/n80fQe6EE5HUMi6zhawOzwIY?=
 =?us-ascii?Q?ia7N1rO7fzV/cniQSbFzKcODc2XkJfEC20RIufuMPKbukQlMFIgXdIganbQ9?=
 =?us-ascii?Q?BoRn+wHweeuo6TfOy4nLNYfoJV05quZwSA+AmSw5U07Uu/acPISqzyLdIJhu?=
 =?us-ascii?Q?Bk7yLRyxHPClDjUJKWPC1jWEvAgThYt93dCmMhoVKL9wUk/49qNPrTjcZdd6?=
 =?us-ascii?Q?2rJ6uYBlNDSQe0so1XE/9Us/BdP2zhe/sovjBdZJQ5Jro1R8MiPkSdFZBCRp?=
 =?us-ascii?Q?LEc27hUEXjFBbA5mGWEWszIv/c5gOsDmHxoRKp5jbYCzZJsiSVIFUjOtjxbT?=
 =?us-ascii?Q?cMxPGAns3X2NmYW93h7WDRnUxi29PIhgoAq3epJyxd5TBru5rgXsK8NVvAIx?=
 =?us-ascii?Q?oJY3qqhgDnjiEauK5F+07PeY8wjidepO2W3toZ24nZCX7wpnl+LKZzDcjD4v?=
 =?us-ascii?Q?akd/FFzPw4VvLeZ0PwMcAoOOC0SuUTRTZGK+cvsSo+2bdeCzGEPhnDMi4Yb2?=
 =?us-ascii?Q?2oxXbHqTtm2uzvEhla7npkb5RUSK8UI2xJ7Hts/gre5PcGpY33cVW0iCuZj0?=
 =?us-ascii?Q?sqamWmVPc9NQaG+4kIzhxeyS7ivtWeZ6r6/FFuR8e1tzUj3qR7pOYUyip1cQ?=
 =?us-ascii?Q?khy03I1IyDKwRjO5oxfQvMre1oedgNNjN/yzs/plMw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jqs6r7/eOgqb6n6nBqvWAXyRXIrO3BWMG5ksZF0ZHkzRcOCWL970nVBwbHKu?=
 =?us-ascii?Q?M9pBFhPx6SH+Yaw5yTY+OhRfOJfohUyDOc6icKnG+iVa6pdsWvbYCj3tjKdI?=
 =?us-ascii?Q?Ju3AJtRG212dUwiFjO1rHWIKtznXJQooSg/VYXC2FCHI+GWwAISvbgzLQ4Cz?=
 =?us-ascii?Q?wUHPA7CeOrr/txjvq4J0Io+7E4ktOSqn1SmoIaQq8m260ZhjVMV7iWk3UcwG?=
 =?us-ascii?Q?aw/vEaFv+c6XLAp2forGfsEXW0luloeEkWCpVdN/tJHEzrF+FFzARzjATR8r?=
 =?us-ascii?Q?QOkXASMHdGy8Va3/lfwV3YDY1bznFPs+huhMhDFhK2woIqjryMNODqpN7riA?=
 =?us-ascii?Q?O5XmdXWErb4SvIq/A5RSblFlUZRWjq1k64IOviRsB+uJBdLksYWSadhznlZ6?=
 =?us-ascii?Q?bUvmETkz67zjhSWeL3fjayriHOcSbNNEUuVr9KvvK1+lyy9ry1aV5sUeVj/P?=
 =?us-ascii?Q?IAvD8K4fU51e+xGxEUGlqD7BgSQHyR8e+YLtLP650s3laRFQQdZl3qIfcvn4?=
 =?us-ascii?Q?wJX/Ej/LEUfGCBmA6Y8/QEFPg4Z7Z6yBoYeso0D+dAd9/3ts5Qae9rHogI4q?=
 =?us-ascii?Q?8l7wv13SnTRuFrGqszwooP/8FIyHs9ss4PccanaTPyJMIPRJHXHZwL+8Cb7E?=
 =?us-ascii?Q?AwboqNiRcvXDKr69SF76kQzZbrtxrf6kHUShLq5xcx7NfkXIZbqYuIxaKWmQ?=
 =?us-ascii?Q?53AkaMIJ6lJJw9aj6cy/hvY752io/yxFparScfaWHSklDIlddNiD/uauBen9?=
 =?us-ascii?Q?bNAo8hoMuUYe9ooNn+VyRgHyuSIm1QfQmAwCxRoX2WvmmZkFpVPXPUDz8cAy?=
 =?us-ascii?Q?EelzjdErwuCOtr7cHW8rM1bEFEgUtVp8Ni/BmdgrEIC4F32mWKZP0JmngFr0?=
 =?us-ascii?Q?JQ/mwfqKF5iKw0dh8reVc+ILEpnltJGuUQeb4JTM4hIhf0nOg40EtoN1xbVp?=
 =?us-ascii?Q?1JRoh+lDrDjTnJINkwerwHLhDX5uMdTxYCnKsSmXcgcm7jBwmpfDl9QDtObL?=
 =?us-ascii?Q?VZY5boqLVGpNfLTL2bqLewMIGbNXbOnNdx1VCJwvVh4Hl4vU8yOOBra+rK6O?=
 =?us-ascii?Q?JKKyB1SgkV1iPfBWbkEzwboqTFr/4jiZ/B/kNL13SV6+rjbjcG1U+d1l2mZw?=
 =?us-ascii?Q?o27IcFEFaynzmbqo86nZHFsA0TaBd18ZeVaiBhm0WewpzrO1hzilz5kuKMgi?=
 =?us-ascii?Q?s0rW2lHINgC8S15fKoDAPrzPso8ATuMjBDorP0e9ajEHleM/ly4apK/uN8p5?=
 =?us-ascii?Q?WFXN5LtNbqVl7VVEjhZpkcpSxsdlm0s4NkaumEmbaB1GeEy4r2j9ucs5jU0J?=
 =?us-ascii?Q?5JdY3ZWDsoO3d0e6o20JwEAUoaL6IGCgrcLSkuoZUKHFj2m4o0s8RjCYf/qJ?=
 =?us-ascii?Q?CwsK3Q//aAO/Mv3CXQQeZEbhoDZsLrpNIJGjWXlHg129eSnzhBSqcs7pwtGi?=
 =?us-ascii?Q?VyVT8W39TmCM4YT8yxABaC+zlyHNh/y9tf2LvYny+4FmSymfFZQMJuJWT2Jj?=
 =?us-ascii?Q?Jddg1ZtOJwmM0bNDfQ3GQpXHAUw8wV5CUWAL5cV1MKwLRxkzEtHcAB+Pw7QC?=
 =?us-ascii?Q?1y1Y4Xys5a7cueESnd95gq2hiIK6GtHXaYkyt2huyqtXsR4DWqJljAuKngWv?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BHscyP2YmJjeZq01X69J1MnViHx14w0xfGz2XOgsXAq6rEsItEclego0TbHLXD5TA35WAE8jpFHkHj+r8fIpF2esznxad+wy7hl+wZDUnTUxZ5rJ4icti9lWEc0cr0KtQxL3XZ+akQWT21bCZ7MDJBvBm/GsSnlnoqmm+ui+5LM5sw3OWKkjEVOqS7nU6jCpeyuNLZxexdb1h89+ZGsThrdzqp8OluJ+0yIpUgCWOJ3ZksofTEvvaUihm4Tlz4RiM9nS7OnEKVMIfgtbZcRscRWz37mHzpTXMLJKtFmFa1IDq4Z335EHXOEJea0tzfRJmTJsolYRykrUZUIH23cebrAkij+zaTWkBsikLOmKKC4k5sASxoVz2U0UM1pR1ultWPsbIMsPfH2T03xaa8GyJuEUvY75uIoTZLCFP6QQMk3gKWkLsjNcuxi443BzyCrNooxdMr/6R4XCJDGA2VVuYbk7VLBW3TYCgKRVPpqVMK1GqJdwtAB9R9XP4tIOK+kqsKlcbhsJtlmrumrr2DuaJ/qhD3JgrVSJrfWllb/zGmLv1zzfG08Mtsjpklm0A6gvMCwJ2kgnCtw0H4i30ruTqiO7JwFllZC0UwstW8zNSwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbfbcf3-4c58-4f31-f6b9-08dc68748610
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:05.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTaK3K2KET+EgypJFluXHVK8BOzJ/P+kyJc6dANu0K6CDsNdf0aCop4dZGOxZk1w5UrEwC63er1+41NJfBTYwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: 3UAwMplDnlAEfmpLs6lZIu2HfnyQCLzq
X-Proofpoint-ORIG-GUID: 3UAwMplDnlAEfmpLs6lZIu2HfnyQCLzq

Add a generic helper for FSes to validate that an atomic write is
appropriately sized (along with the other checks).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/fs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ebefb079740..9bfa9b68d800 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3648,4 +3648,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
 	return true;
 }
 
+static inline
+bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
+				unsigned int unit_min, unsigned int unit_max)
+{
+	size_t len = iov_iter_count(iter);
+
+	if (len < unit_min || len > unit_max)
+		return false;
+
+	return generic_atomic_write_valid(pos, iter);
+}
+
 #endif /* _LINUX_FS_H */
-- 
2.31.1


