Return-Path: <linux-fsdevel+bounces-32089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F99A0672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E470CB25827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699A206E95;
	Wed, 16 Oct 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGGF7Vjn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PCnyDUD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BC206E70;
	Wed, 16 Oct 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073048; cv=fail; b=qvL78pO8MPUwGLBAi0GAk/+IaOYztZ5J+TZIvYLc4aeItg8ZGE6v4k84od7/0H5b/BR38qbKCYyRWbXfj5oLAgVZzkdf/bmoF5r6RuyNQp42NjmqPVc8fq+/ti6TDqxQIRJj5s3ZyA8ioXNYx4PxLf3SWYOHKGEz2Hvqt+DTPI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073048; c=relaxed/simple;
	bh=KJAmP0gEIqFdsDHQw0vXq6kl8BLXN7Ilg5QGz9ewTHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmA1cV3XKVU14HEIn4z4dlFymOTuXmMHpLBIe5JdqGpmyuxjRXh5efdpDaWrc4GOowXWdIQKBbUrJUAMSz+c76cZwPBs6uEgUwLUdXi0hNC+ERqGLCFB9ekwdfIddCYZBg3jFABHlUiGbcTeR+ZipZ1z+rXbIBkO8wrDGhRtLuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGGF7Vjn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PCnyDUD8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tiA3012994;
	Wed, 16 Oct 2024 10:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=; b=
	DGGF7VjnCyE7RTfHt3M6gUW7NQyUJEl9Dq2Z36ozzeKf6d0ZVjkYBwNnNEX3GHy4
	XvXiPTlxkUbV1T3ZZvISWIyfs8OAQ+6kvBS3TyZEXoL2jYy8G/emzpzSm06aOSuV
	StwOF1C4A5S5JDPhDrdJYZeMJQBsV/g85Me3Nxs9SQ3+7zweJcoY7lileIhXu4nc
	h2L5kUi8xMsCXgFSlzmLUm13KeZflqFUwHOfj2QvFFctFCOixMtQk7L4dol3OgPP
	l1mOCsc9xd9cLZQY2ZBRZkmHsxhn9VCg04pDvSFL6vzx9Zs3vSTvZHxFc1vb3dAK
	m/mjrg0yCpYkyyO1FKxQ0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2kfar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9uuBk013985;
	Wed, 16 Oct 2024 10:03:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8kyqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOpD+p3JkI+tjwFiZqcfzkBR7aDBPHkAIEKuN3uDKDTXJJTwVSI5kykjhOX9ESTdRU6WWYFYo3WCGvvnjp3qMVnvvR+rlPsRbnHipuoE+v/MFr8mURwHFzP7sRqziBpnu7z7khn3d/t8iusArxds4EYcqwlZU/YVABzrDhioC+TQgNcpmrcmgvVEuRJycsorLiDaBQDJiD+ayPiO1HQLlDluBI9AFxgqVl+ANv6wKJqpF9gdRmaG8/yX5vQgOXZbqo4I6RFJhvhyZTiqX79lBb1GGf9vSf+Hh+pgvZm5bkXzTy/WzvEsBuDOAhsFMG9qWhXiqc5Og+0xiEW3DdsnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=;
 b=LZD1NR40eXQNP1hedxFpH0H2sRW6vtbktPq1aeBsFmIKRKwAIvxMmTrm6OTTBvsbUFUENmaX+BWfpW9pFaXdhflOcikdnNQOCG/MK+LkZP1v5VViIC3vnqYQ0e96jN6BLv2tHXDljem6HRoJJsRUniN0en56cTf6nbW3L/OSuBwS+QqNLqiYrRJKS8l1A09IPzazlzVOUR+d7CkdIvv1WKmeFXDAWoXRN8CxXnodhbXHN4GE66NxMvqh/mVWj9TAYd/TU32d4WZinf/SiXtXfT8lWiaHUa7MpRZzLvgUR3Xi43+BO0cCnLsfZoaxPxuNqtLytRgOMMRDFtTmXTu8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96/CSpPkbIkWeh3kdzb4Fh9gHbZM5oqNERcAoaBICl4=;
 b=PCnyDUD898wNTEI97ybGGtNyl2feO1qhZYhezmQSpWOoHtEDD75qQakYvI5ja/pIQDBtZvkWd0wZN1rNuMCPHRBjgZTw6LwEIeIeU9W7CHWz12PLqdIs6wMRWeYBR39/nVGZqoHrBGTg/e6XZsvUSXFPEDhNu6bVS8wWwTKcYFE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
Date: Wed, 16 Oct 2024 10:03:19 +0000
Message-Id: <20241016100325.3534494-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: a69f2582-a16b-4a70-695f-08dcedc9d364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AIKR34/FF8x/Fg17562qS20Vc07Awsfe3MyoN9uhGeQSVmr1jIqOHGLvceD?=
 =?us-ascii?Q?O0W1xUlAKz0sMaYUT6LWWpgARcUsUSVqKpQAE8euiYyIDt1A3jLwfZH962Es?=
 =?us-ascii?Q?JU8OPDJBXy3xyPWqHYEf50aZ+JL5pXEHxEdXZrX5ItcjfrTihjrxyaxSG6lJ?=
 =?us-ascii?Q?6s9oSlQfQBY1kK00OlVK+u++J+404rCKnyt8eiL5fNCcnBiGneBy3vkVFN8P?=
 =?us-ascii?Q?dCSu4vX5No51fJxNQxaBeMQ3arUmgb9yXnEcYSbPgqgEBLGMNCqrZ3LQp1cO?=
 =?us-ascii?Q?bUY99WnyXbqhTxSQ6mQfJBUgGM8NBmCyHsxV0bDMm40q07tV2EVClgyWSyF+?=
 =?us-ascii?Q?jSKRkzXK+nkjUsI/QvWrgL+OrK0UKJEz5U6il58We5AgU1Sh8aNPKGJaJS7p?=
 =?us-ascii?Q?lpl0sgacQ0UgqGUTYaNpEWfAjE7/FCqjnlxqFyhg4lnwK43SryLHs7+8ezLb?=
 =?us-ascii?Q?vebROuZH8Tc2YocChx2HLXGyXboQ/Ot9QzZoVHo7y2Y3p/liQUWP5a2OMe2D?=
 =?us-ascii?Q?+IR+RyvJS7HbhLlMd+83ezlUfD8Let0kbfI6hK0go/nSOsEIpXA06jk4dJM0?=
 =?us-ascii?Q?qfqn7zvU+/wRW7Ro6PELZIBrhgmB1zJUbXvz+4/6r8pf83qmScxJO1tgg2hJ?=
 =?us-ascii?Q?TS/UYxYvyxad68zhUzegWspwB0lj3aeX/sos6y/P/i81FgSZjeCvB+z4dBeq?=
 =?us-ascii?Q?AygJh4TateyvxSsTEJhFleWUkS6gjN/ugua4In/WmmtJUuWTRskn1RN6qf9G?=
 =?us-ascii?Q?cHp1KvXw96tCpkGcu6dLZbb6vyeCZebuCvtxiUWAz98hvqTvVe6KOPlJEmO4?=
 =?us-ascii?Q?K1e3+Ctfiqo5OdDkBW2wPdlNRi1qYmNWByc3lG4Ij+gUJgERL46QUAnm0NVS?=
 =?us-ascii?Q?pdufALK1p1i2MD6BMWFdOx58KMIDyYFbuyMHSMmyMj1uPDzxj2FeIMfA/H5o?=
 =?us-ascii?Q?jPHQpYF4yMyNXvzAOh9dtkrA/uIM7CRu6+vVr4CrX4G8ANPbnrDtZnvFclNl?=
 =?us-ascii?Q?SfAu/MVR0MDk7+batLMFT2kagNST2O/2KnTriQaBXqdZ0SMEywixVkM/qAFG?=
 =?us-ascii?Q?37NT22S8WplCEzzKybFNKMRDhQ3t8MxIaHQgWGH/oEhwmJ1gb4OOY4aPoAyj?=
 =?us-ascii?Q?dS313mtIqXqL/0rMNyoFQhhfzh0uH4IPRZgUkCiDFnog+N+IKmPRaR3k104c?=
 =?us-ascii?Q?2iAyCoPLEQWxHb3h7+8USHy80HmtLLQIJyLOI19ySuyt9q9wI4eJUtCkBJh7?=
 =?us-ascii?Q?ZDt1QVsLiA61nobwkenVK8zElMuGQrB5WkipZwQeMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gD91Ysr5PvG5faQKLEITC1T1rmo7csumUT3o0Z66hOIhxB2qE52eqL2KqJQO?=
 =?us-ascii?Q?QxktEnt1fYHyUQJC7vLc2OB42HzndImqFRodTlnKLLfRVb/mRfPXzdEB7YoO?=
 =?us-ascii?Q?9U3U6hzwaS0if8SguojjTHTiqqN0QxuATbJ2EUrit1BkAUZTTgitbhrkBAnw?=
 =?us-ascii?Q?/KxMNRtpDT+f1E4HIzYxOlf+OUt7xGAH3+LpydKA749WRnc+mX7Jp/v6kqIV?=
 =?us-ascii?Q?JVy8m9YnKNYWM0LaDT2Fwhcp9PV6O4LrTLGzxgVxCkuPUm24Nr+p1eWdEt/0?=
 =?us-ascii?Q?xZ+KLngKyopVGOy9Ig1edBtZAFBUqZt+MjdWpG6A0m2lTT/a+VLCfK0L8/k2?=
 =?us-ascii?Q?KxK6ptNxoSSXejN6UA9r3Ria0MWYVDsMvWdXlEB3VDPtMxFiJjkqWN9jA1Rh?=
 =?us-ascii?Q?cgArEbkhwmXJ9PvCcYG7iE1PqNpDLw0PodCT/tCDeYkQ3VGF8iNnE2mjtvyK?=
 =?us-ascii?Q?nBRDfpUrXUDPJAvkc55cV+VBI5t4h+0VdH/D/qotChEi7SlW/OrNBH+A0Ngf?=
 =?us-ascii?Q?QkgoNOqzNTb9qQbxSEgE1uen3Oxw2gpvW8MgIU77A8zdDKLSqouteEftTijR?=
 =?us-ascii?Q?01FmEK4YpGCUEsHu9sLziVQ6GNJ3JuWU2k+cjcXdHLHQc8UYpO0wiVsHDDeH?=
 =?us-ascii?Q?a8EJ9w+2UI3ka7594olnjP8W8aefmeEEElZAPROst73gjtk1ifadkJw2yYcz?=
 =?us-ascii?Q?RaLXY5AV86tJtb1dgJ9kaPos9Dy5bif4+gmx6CA5wbJ105od1xl9XRLaOIVK?=
 =?us-ascii?Q?q7/utWNFChWE5bn44jSGjNxJPq2ZviAuXL4UQRdr05cbq1YyQwJEjeXaaaHq?=
 =?us-ascii?Q?DZXMh06LJzjo5HwEulgW59NFyALko9F2+tajPd2eiCR7Lmsva2FrpBaM6Bdi?=
 =?us-ascii?Q?qkUqRO9u78IEjV2NftTimAPww2z/jacbEKEBzQj5JkkwMcXgMN2rfcZt9i8C?=
 =?us-ascii?Q?BQ/si7TAbGoEfP3ZrgODFTvEjp0TNDwkUKVEaig8GFi0jPGGu8F4qeLwdw3D?=
 =?us-ascii?Q?Clup3pWzL1VEHnnbDTb1nCwHGV1YIeXvn8Rd5RVVED4I9Hqd4o8hNzUK3Yq5?=
 =?us-ascii?Q?7jZsIfZCXQEbFwqe8YlE2gNC8WCj6O+i/+2OKrkxEDBbG3ejK8VVxLj9KxrZ?=
 =?us-ascii?Q?zzkQbm9x+9srohETl1cgzIGlV89a8jLZN/DinDn//fM9KDUySH6xYX44jswj?=
 =?us-ascii?Q?tnBwlCkCeU7yq/RQzZsl+CFbaoOvotQgKlyLk7vdULky4kk2n1YXj1BjqnLd?=
 =?us-ascii?Q?gruu0aVluMRk/HwJOL0a3wdY8WtsbE6qSfht97QVVxZLYz+fStZgHl9rHyDl?=
 =?us-ascii?Q?MwJzsnu+zMMzpVq/Fzs8Je7EyY3Dl7RU2Vrt62HOaYrHb2p2cQIbOuamTPZ8?=
 =?us-ascii?Q?uBjUopa5C8t39xKI2H5enw3dJroQlCd2VAot4Hkcr7gIuy74aamAgFNHPuUN?=
 =?us-ascii?Q?2FSKLEuxLvFICIdsNx6D139RK6OVGEOIdZPesiuAlKSHMhx9G8HmRdVBGfwf?=
 =?us-ascii?Q?XWR1pc6928zcNdHm1evd6LDizi9vX78W9DEbzazry05w0+evWOJ4qC01a3DL?=
 =?us-ascii?Q?p95V3XTyypLDrEytnhIyvx5KIHU4G2rzfiUuE0ZyWzkHHcpu7OttItAIXJ8u?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJt46lh8o7XqRXaLmMQXxrdzPiRDcZBYJAGr1I1/WJWnxn3p4cveDMljWAg9Rfj4yEPankMrHjLumzCNBBrK662Xmplu1WaxIwmH69WwzMDJ3c64izYQSJvzrIvLH2IvxThzpjfA3bEdbthx+mEkFEa8JB5KtuQpy0RE0CV2gzXxwhYPULrwVCTcjU35ZRYlaZRNDJcUHWzzBZLP4Y6N6rctqQgbIlLpvoEgyPMBTWTB3a+SAxNBTlA9bxEsg+D1+0IbYokLCWBtzXqBIVV8OqX3IaupMUK/Hy40vGqvPQe5RE9IXicLgAIOI1RNDzlKUZmyRr/qh8aMI0FxpBdcGLJcczRmLXyHaNyU1BDB11yFUXF8XAy2fETHOz2HAL87ecnI1/fad/hBZJaVhfhC3hidf54P29OqMcnclyKZV6I5XvpDJhkBjRVj/el5O0rkqN9tNHZppRFbNr1ixtUmoFGmad9Dk3LPzTzsAZSvZ/DDJQzT0G4AmawsKv7Z0HcQG682AP+6j/g+/y2rxeZcDgNZgS1NVrqPVE1NqjO2IK1SwTBlo68BvKplPHkUqn8vYM6ExQ8U0pStOJzG1iC8yxCdsuShV1rUmrrlYA+xzp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69f2582-a16b-4a70-695f-08dcedc9d364
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:47.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGo9bSTQMwjPrg7vVwz9XDdIqbK38k8CGvZoGPfndKDssJC98cL9dEsOl5xlMMVNQINi8DKIZKBSKs1z1sG0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-GUID: QhhghyGrfitnPOPi03m6qC4mR6KG0eoO
X-Proofpoint-ORIG-GUID: QhhghyGrfitnPOPi03m6qC4mR6KG0eoO

Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
the file is open for direct IO. This does not work if the file is not
opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.

Change to check for direct IO on a per-IO basis in
generic_atomic_write_valid(). Since we want to report -EOPNOTSUPP for
non-direct IO for an atomic write, change to return an error code.

Relocate the block fops atomic write checks to the common write path, as to
catch non-direct IO.

Fixes: c34fc6f26ab8 ("fs: Initial atomic write support")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c       | 18 ++++++++++--------
 fs/read_write.c    | 13 ++++++++-----
 include/linux/fs.h |  2 +-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 968b47b615c4..2d01c9007681 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -36,11 +36,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 }
 
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
-				struct iov_iter *iter, bool is_atomic)
+				struct iov_iter *iter)
 {
-	if (is_atomic && !generic_atomic_write_valid(iocb, iter))
-		return true;
-
 	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -368,13 +365,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
-	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_invalid(bdev, iocb, iter, is_atomic))
+	if (blkdev_dio_invalid(bdev, iocb, iter))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
@@ -383,7 +379,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, bdev,
 							nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
-	} else if (is_atomic) {
+	} else if (iocb->ki_flags & IOCB_ATOMIC) {
 		return -EINVAL;
 	}
 	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
@@ -625,7 +621,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
-	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
+	if (bdev_can_atomic_write(bdev))
 		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
@@ -700,6 +696,12 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = generic_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
 		shorted = iov_iter_count(from) - size;
diff --git a/fs/read_write.c b/fs/read_write.c
index 2c3263530828..befec0b5c537 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1830,18 +1830,21 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
 	size_t len = iov_iter_count(iter);
 
 	if (!iter_is_ubuf(iter))
-		return false;
+		return -EINVAL;
 
 	if (!is_power_of_2(len))
-		return false;
+		return -EINVAL;
 
 	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return false;
+		return -EINVAL;
 
-	return true;
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return -EOPNOTSUPP;
+
+	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbfa032d1d90..ba47fb283730 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3721,6 +3721,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 	return !c;
 }
 
-bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
+int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 #endif /* _LINUX_FS_H */
-- 
2.31.1


