Return-Path: <linux-fsdevel+bounces-17395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793128ACFAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3170B2849AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFCD152DE4;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUi1MXUm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mcTCa1SB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA0136988;
	Mon, 22 Apr 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796859; cv=fail; b=rcokqZJnvRKY/B2692CDrRk+Ce9QlnLvZPwo3Vmzg/RTJPuiKAluSBUo3K3kkyuJp1cgQMx4Zbq7ZX0y8bN3v/Wzz88ovv/Jx3X51wq9ARRRtT58+bnCFTHs2ot2H6OibwqXmXjPo9iumUgcAjyYXVMv7VBPa6Z/Xx2xGdMMd2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796859; c=relaxed/simple;
	bh=yXg7sp4hk1jqIHnV1Mc7hv2S3RUsHXAi68bmDFkkrEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExRkfEoDOfKdiMS9ICgOp7Jx2xLdRAzDaGwApfzk7s1LbOn+59/mxc6mqWX3fRGPEwT4LCydGGJ1ENAFbJ9b0g1M2PWqcESTJT4ppOt5w9c9KIrsDgEbG6pGu+D535LqIHkZzIFABuNiFts/IwdEsABYswONxQut8C4NuiA+XIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZUi1MXUm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mcTCa1SB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDZCwK020759;
	Mon, 22 Apr 2024 14:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=U019sOBA7Tr3hBdd6zCAzE9UG7fqx/aDZtB3xmfwiDA=;
 b=ZUi1MXUmW+XHiUWdaYjQ20f/ab/y/RhRAPdbQ+irnnN09HyaIsPLIEH1GerGIr3qMpan
 8pNV51QnvW75h82EIzkI1sAHzPlzoc44JgG83P5jbVybWT1KAqC+5cpuDZ8xMoRz+l9W
 BWeWpnvJt0nRmAYgU+11c3mlIUVQV2aFI3H0T+FxPkrqwhcwlzB4ARljLRmJAEwKQqMa
 ZknNfPf0XZ+icqt2A51Ec4V/4W/n/ZR5vIeIbI4ZLqatSO7Qarl7zNj+rQhzUVFJGJ99
 HYh/o7Zg2tUmvEWuWXRgCTaDzsZBJY0pE1Y8+dFERr+mvVBhF67wkCfRfCFjjT3KWEtK /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md2vsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtjG4006759;
	Mon, 22 Apr 2024 14:40:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455qkvn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZN2IsXA1lyXRMt3Be/ekdtuT2x9sn18xXC/kI3ZnQiEFUGAccccrvbUG8YLWJduy2mpu7ItJW48s8QNHZdXyEPNENNOA1S4nbDtvYBhoBDfBdM98zE2+Rtcu+Tf0vhY2k6yuCz2naS4Th8ddXF1vObMxoRELft+Zv4SeT77zBxTEUtTlpAXM8kEhPJ7+GDuwxWGmy8P4XCL/F1iTKjctrz6mHm33l/WIKY9c5qvMZsZopA1b/gQabKbxwL1itMbcv1svs1zA7FQyctLVIgMtsK46iJVu+HLHHa3GroB+5XHorfOuSFEgxFKjPh2waE/Nqc+T5wgQMbnwEZg27GUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U019sOBA7Tr3hBdd6zCAzE9UG7fqx/aDZtB3xmfwiDA=;
 b=GTMRfIkpPdDbv/773VyjO/IsdM9bZ9yzCnIbvOAGQYjPSRJT5789oelYAJl6Yu+POPHbutMwULkZDzK5G0FDPNPllJ9lkS4HjNVH0XUPuqlj4kcfgui8AETFF51NBaHKJX6nKbO6fdSLQp+I2fquuMR8uy1Vy+VlZU/WckysrH6UJLP1fKIPvTN5JUJy/ANcdw2rpna2cMUsrT74mnF32Vn+mDM3yfP6tb/d2+/jkq6XEsm8XumJUO+KKUo0u80R2vPa5b+ZtEIluGnJMz6iosrCIBFZGnt7TG8SkCd9aS13gvEimykhIrcJOY8SgdAyd+LCFSk0vj7Q+wRGaPQCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U019sOBA7Tr3hBdd6zCAzE9UG7fqx/aDZtB3xmfwiDA=;
 b=mcTCa1SBa6DN2Cf1bzRhhYJr8m1GAqfBjEOiHa+1kVbEJvxsjArZnloEDZEoG4iEazvXigClp04NR9wLs5l7pdImzRyU2XZlxqETcGjJqEKN2THVUAfmIkAI6v4C4rUtvsxtxZhoXwyCZiRrPEleLmjQxHzM2ShDlZJR0MKkVfg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 3/7] mm: Add PG_atomic
Date: Mon, 22 Apr 2024 14:39:19 +0000
Message-Id: <20240422143923.3927601-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea15031-45a0-4566-b7b1-08dc62da2263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Mcguabszj3MJDFuMdkJ5jJ6YEHSQPMLGjq9QFURznBUBLlxCLJyatz6oLzaV?=
 =?us-ascii?Q?8ANif6nXVqr4MaBtTSpvrBs0xhm1Grdw7NRl55ycEILDjomhDjrsrDFjd6vz?=
 =?us-ascii?Q?rQUtO4+d8y+D2C86UVDMQj7B44HKPnyAx9J22IVV6hCoer8TNGXYe8pL8qOP?=
 =?us-ascii?Q?iUrRZRnUs/JTnlF6fjj5tmdLnx7AZeFLtm1P5TR+BbV0t8uK2jwrdagoefJj?=
 =?us-ascii?Q?/H1c1Rp3Un4RUcyisXL5U9YVXjXQhnmnYG50usTnO2lYp0kN+GdvWtRREi4n?=
 =?us-ascii?Q?KmALtFTLMCfyAMX2YX3kqjxLENvjdiRqgSibWX6WRwHjJWur0kqCqdxEwyc9?=
 =?us-ascii?Q?heRyKAdwnTfJo79DfK/eFdvHrNrTY/aEhDhkgKnD5XBbNmC2W9je3JRfQlkD?=
 =?us-ascii?Q?rTMcLRQ4g/7xuuGrS8bqDsyUlaTCz1xEQk+cHbjk1z9xm7fm+d1HA2Snwp73?=
 =?us-ascii?Q?LbX2QTUvRrO+fZ9Rl5Xw2HHGP3hchMt2iHHjlsYjGYbFPOgx/4YF37ZE5o81?=
 =?us-ascii?Q?JXJ+y3RksNWsj7f3bLT0ZTls1UjmdO36csz/XVd7IJ8dGVSJ+2jmFn2k5bZQ?=
 =?us-ascii?Q?/umR+UKtJQC+fzVISAhjZYNqvVAzOB6IfJDqzo7VoKRjcIIrK4+/bGqwi5kl?=
 =?us-ascii?Q?B3oqyBcHw6ohhtT+RySogkQWwaeLX8t9twst91paLcBnpzClCFedc9laS4J0?=
 =?us-ascii?Q?EYB+teMXhYbcmYsggOqgvUpmyypGCSAXPzS5vBMq5kI91b9RBKSbjhpUjZ2q?=
 =?us-ascii?Q?+e1d2f3E9xFvNBfmz0hi2GMlnEyTBTpb/XEBtpPHiO9/5zEMhtIxNWsvsNaQ?=
 =?us-ascii?Q?x16vGxNI1QHoK4KUW7QH7CuWQq+P47rwWM4jWSXl94Qn757EWXRV1yN3V8DV?=
 =?us-ascii?Q?zgmUEwGox6zdDCO3nSLVN9wKv0E5EpNyHNCricjKHld9Kp5UdsM5vTz/hfGD?=
 =?us-ascii?Q?ctYjOiIbX35yJXczCdIjKuKSxJccM4pEMTKLnYFhoOHjieydVUA4vxeFxtvy?=
 =?us-ascii?Q?vhuGbZCGkkPf9fflToO4GNIEUJCDYUIjSO6Y5N03wJOpgnJvkfBzXqsysxpy?=
 =?us-ascii?Q?4PQjdyHZuf2sEJo224XceOYUp7d3Bka2XjZBowQ1e9NGFcDZDuaHPSgUaAyO?=
 =?us-ascii?Q?hHc/g5/n0mBR1qnE4jrLMXBoNKfGNrohlj1/rcsm00uOcioJ7QXBgy4B7s6Y?=
 =?us-ascii?Q?V24lOkWOD07NCQSAHBjFaz98G6p6860kX74/rSR2ExymovK2zrCpcBcp5Od/?=
 =?us-ascii?Q?iX7bS2YhgAf8cHykA8qPbfz1zS595R0FNE5DD1z3rb3VKZs7Z5rTMzbDc0dh?=
 =?us-ascii?Q?4SZuSX/KggIHyLrfULbdgLpZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jCOzNgL/l+cQG3vPm8CE+Uadf+u2m6X58RG58dvcX2/BPlIcV1QaAXUGk9+8?=
 =?us-ascii?Q?snFUEw5INaKnmtkvjFjBm/WPjsePmjqjbcLkokcxbVDZk697nv1cjEzcZpqx?=
 =?us-ascii?Q?jyidpwIQKkR3cgW0K4s2eoQoOuJVbcm3ERa7cV2N2eB2GAoN2sPQbiQbVREc?=
 =?us-ascii?Q?smTUK+bOjcRMjeAd03nOUg1jubkQ8MOKV1HpQehvDX4J1P0fWynZOXhs60Z9?=
 =?us-ascii?Q?60/bZNYqtpr3TbxT2L+1FG89tyeojr3FYmxEb9fFR8BxgnBb4aJ5XJYWoenx?=
 =?us-ascii?Q?Cg8JeEa6vmUdYanjrD+VYR6jrAn2Ps1hEbvlYnni5z10iluRH2Wp/JaAi8/Q?=
 =?us-ascii?Q?/tzUsIU/Q+OoWNEVIm6zFBE6DX848dBsDiibqOhY6F+yaqvc/3n0Gs+dN921?=
 =?us-ascii?Q?zi90GCNkiR4g+q8jLZf8L3n8Xl3Lwu8F3LI2+C17Qu1pK81LOgF2tKUny0H4?=
 =?us-ascii?Q?6LjEJOl6+QTBRtkjuLtVPd9w6xw9/wbBe8phNJH+ULhirAAfaw1qr0Up489K?=
 =?us-ascii?Q?4TwRGoA+FzRMDQXeYk7eIQ4PSpaWMBjcT7Z55PotPw1YKhHY6h06rabAT9Ks?=
 =?us-ascii?Q?JBUC6GSm5rdtXNjWL1kHrah9IcthN1qS5ErlzCIqRBGLAjmDHWNvoOyYILC7?=
 =?us-ascii?Q?Z7CXAW4wZPo/XqFFgbcAOW3KcsDeiFzap3df7a+wgqY3Brso+YT5nJjsmTLk?=
 =?us-ascii?Q?it0uEoBHgCgSMeupwCJ24r6lYIX+SsOzUV4Wu6D713JKJ21qIn8J9Udw+PyT?=
 =?us-ascii?Q?EbtQFuHNY/15blTUEqOd7mrJAzR/WRECp9jK9XBxJT2EUhWrTBF+r+RNpj66?=
 =?us-ascii?Q?lhYTWmQKwMPIpReRDYCuR9Dv8YIzdfvuy5RUUxaK0dWBC6OZQDnT0PclM6Yw?=
 =?us-ascii?Q?yUJDi+bDR3XFlLSRE8+AMtaUH1tGoAF61L412PX9TJIYmzaqyEgUv1gVP4dP?=
 =?us-ascii?Q?lA9dLjkXqTOTjgRzejjGxg+4tm6ch5nKFxya5xMR1706El4Zwso8D0lqA7B6?=
 =?us-ascii?Q?dRe/r8QKTJnpDZR7QKU5ImpMtqbK3aL+tN8LYoY4PPKe5SE5JF5AYpS1g0IC?=
 =?us-ascii?Q?mf5OcgSY99gTZEV3bCNTKT446ryt5Du1GtP0b7IQa9VaFQ5VAsgwtd6Vzx4r?=
 =?us-ascii?Q?du4GM0qWrtwEcxg0AapnN6y3C9Xn7w0kzNlYvBvnkP6N6B7vv7P/eCEd0kYT?=
 =?us-ascii?Q?ilrOnXYdxnCOyQP5XXfJJQZ46fs03K7x6376Cr1JIKmQ3o8f3m4lrco8iGAo?=
 =?us-ascii?Q?6OMnLnyPfUin4hOV5MkhfcOpsSkUjIRpbYYqSgSBzwOVrzLONl78jSXW5k/O?=
 =?us-ascii?Q?wFb5SdZeOyh+AdWIMFtHHUGhs4B9jnxktG5eL0bMVRPLcOwydxhIYoDe/iHC?=
 =?us-ascii?Q?GvlImd95oSwkUcfhLOA5zDlaFsxbUxbT5P/hwXzytxu0J6I7Kv++vhNKbJC9?=
 =?us-ascii?Q?bvh00o2aTStgLbNafhkf6TUmBgS3nciiJ94HTI0Dj66+EoZQ1xgn2mQf5rVG?=
 =?us-ascii?Q?DkgBY8Ix7UeuJYgS82WqDX/atwXrR3Hh2CWtqnNj9qCG6+/FboSNjXaGWbhj?=
 =?us-ascii?Q?NYRr0lxhdQsHOFewhjUNTU+LDgrpWNyUCthA2aXRaIz93a6cEglgZgLkXLqz?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	omMSYl1mVrp5Jdk02TpoY4Pbap9ziCb1YFeIr/Tq9zgwrB8J52Afmu9rjQOMnroj+uuhKkvcDQ62DP+5I1OpUCPBtJpcVjEzIxwVtG4OYOMnBejUQA5WDKtqfLhzQbYS6dMnjnaKB3PJHeBdJdWKNlRGLmApF3LFHv5pTPnbJ+GEG0lszeVdGyX8CUfE9SJCUrvhjnHsVZcuFsCq1uoWAIk1tnv9nVRBWus5c313edIsfGoCB9pjrZJDyBzn9MU30+ssszA1TO4OFP4wovPYFH/m2oW5OCm73Ejt9UcXi6Ra7a5JTc/25EdMAgonZmEIetiBL0GhdvxlwrowMyu4t8Fy6dfb646vpDVQqYNomqxrPTOLI1R0+fxwJD5Wbp2PUQSIPE12KrGDUca2UbXpMG85WhEuudNxqwQpVTEYyOKhUBmZg4UAeTtk27Zdu/Zlhs0b5f2rdlkRsxFmLgpOzxsdTxb1GF8Od5U/uqtbCfSqRTh3JNUJ2JfhSB6I2WEq3AkRXoonBPiCepdR2asJf6D9yen4d1LzIK9JYwSguu00qpiPk1SZWTeUIyLjaMI4LMa1GdtVWNM1BCvvTZ6l2cjD3w8CQqLdGyOqb/0OT2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea15031-45a0-4566-b7b1-08dc62da2263
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:20.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqHnCLDSVcqtiwTfWkzMxj9kvoiLlATzjbf4Ff9ud9UNUEmhAu6MQcdakpQlUC9qYJCM3Nt+WI4xl3shVl+Dug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: TiVG24EcCOMRGxlQURS2tmXuWrAhvNU0
X-Proofpoint-GUID: TiVG24EcCOMRGxlQURS2tmXuWrAhvNU0

Add page flag PG_atomic, meaning that a folio needs to be written back
atomically.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 652d77805e99..e777b2e7daaf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -119,6 +119,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_atomic,
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -579,6 +580,10 @@ PAGEFLAG(Unevictable, unevictable, PF_HEAD)
 	__CLEARPAGEFLAG(Unevictable, unevictable, PF_HEAD)
 	TESTCLEARFLAG(Unevictable, unevictable, PF_HEAD)
 
+PAGEFLAG(Atomic, atomic, PF_HEAD)
+	__CLEARPAGEFLAG(Atomic, atomic, PF_HEAD)
+	TESTCLEARFLAG(Atomic, atomic, PF_HEAD)
+
 #ifdef CONFIG_MMU
 PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
 	__CLEARPAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index d801409b33cf..3c83e7b93898 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -118,7 +118,8 @@
 	DEF_PAGEFLAG_NAME(mappedtodisk),				\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(atomic)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
-- 
2.31.1


