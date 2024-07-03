Return-Path: <linux-fsdevel+bounces-23023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFB925FB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32AFB238C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C26172BCE;
	Wed,  3 Jul 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDYp3h48";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HQ2rgKK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6EA172BB9;
	Wed,  3 Jul 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007920; cv=fail; b=SgwvVUqcoWWnz5QJDXtvJ/ylV+k7kueDciEUwuZkzfQ6zrxOgCOZFSPDlTC+lhOdDl1ur6iG/Yiul9/tpHDgnEvMBME+pbHuYORkm10nlVw3y7e5DNPCF9UKcOaaBTaxPLu272SAB7m2QhymhG4s6MOFVE4vkd8RI0hMshrVLQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007920; c=relaxed/simple;
	bh=JltLHE5YYphSx828bd7CaZPSmrySLJMeSTV3VyntmEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l94ugMGu5aqlMsyzdkJJGLi2/jqjGctQtOsqE1BFkcj92BAEAtIzlCvgJ0yNHJE5N1FnD6QPt78K/kG6tpt+9dwS+rJ3BaJ14DEDg9F62HGXmsDa/+hYzeFaRjKqkVXpMx2h4xyevu6Pr8T8mL99OmaqPsLjuJOpo6J8YpfTNkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kDYp3h48; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HQ2rgKK2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OAOB015973;
	Wed, 3 Jul 2024 11:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=; b=
	kDYp3h48FRV3+7DplVLFgm/4tjqL/Hjaie9ZKZzTiRdrXHyF7PJYzFjRPLIs2ylT
	t7GsNBy/kLJihTKMj9lM/15N75c9JiMyRHfzJa3wWSWILU9IgedjRgC5RWxrAzKW
	goHuNMPys8E9DlI7mAFoGBzsV5NLnvXDJmhckKF2ga5vvfltF/J8BCAAjVYzfGwP
	5lAZweqdg6idku9+p3DtgR7MoiupSi1dbeK0XA6ldd7yROAF5LEy4YRz7mk9mgCW
	TOfb/G0OSu4aKuUBuYYOKXHXdnCaqje2t90Tzn6/+N6wwC+H6wvhpphPwomA69pP
	SZDAR6JDIkYgbpuUiO+sAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a597t2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BT5VU035737;
	Wed, 3 Jul 2024 11:58:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8use7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaYcuRUC+MlHPPh7DDn1Zme0olUD3OBhR0qQib8Rw0pFo3divxlnGY7D5iWHvY2A3auvZpIHN2v8UTXndPcqsRxB1FSSFtyxfj1loGEvZuj0oYc+KeK8/k3auAt9NBcq/cilc567XEPdGsHEpLpDrSQ6sNVoWqLZ4dlfCa+oHYlimKNZjTQJKT4gO2PS1p9/+DNUgwucknWfZG1t/wZq6Rvr/LsrteNPVbVhfKtoyAR7KCbZKS5jLaS1vxwKgIcKM3fXTk9LYtUIkbd0hFlEuDXTnCSidXBtkZRIMTGWdi80jjggxUgIKkAcd5DFHbnQdF5ngYu1eJH2iisFaE7zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=;
 b=fvNmzbg8tNASKPlct9VcX3uW6PRvH+CyZJaff7/AAnCVyfZf0n6eoN6p483Bp/AD5p/GR0tdI0fbCRSRZ6bMcz2g0iCwF7P9dL7NFPOp4Z36CeG95N64HqoIMVqdiSFy/Ld5zg0UFMzZHrcXQGWt/RTX7L5Gi/k0IBGpgB/8+Z8gtGKoPe49h63xzA5/3RwAbkiEGuxa5bnNA+0eucPuZHdgbWM35I9zagM0nimb5ZHRnI4ABocsh2ZrbuWtVeAPh9DWMObfnYXeOEl8LUwkCZBxeP6tbVi29ohAQBeWBqmrFa2RoJ8f+upPHQaWlJY9eZZRduKW0nGLHO2726d5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=;
 b=HQ2rgKK22BAzl2J+v6kuq7nr0ig5UeCuHk8xe1bX72I4hC6V8kCBGkaEKdy3wHRybLnRWeF9rV2vz/9spE/3Hjr5hkR5TTPHxTHNjOYSV6OrFzIjbng6hU/0XcoYsOPb2GVQpnWkSolGqw331pBMdPX4KEeoFenJ5mUKQ5oHt24=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4676.namprd10.prod.outlook.com (2603:10b6:303:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 11:58:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:58:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 6/7] tools: separate out shared radix-tree components
Date: Wed,  3 Jul 2024 12:57:37 +0100
Message-ID: <0fee58da66ff8e397ad5e0e8a3ca1da85c3e2d78.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0170.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d23bf4-91f0-474b-023f-08dc9b576d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?n4BlJFKafeJ/pW3X9/la1WV7gS+niUTNGRYRLsnph/kqxYTLiHJOpyz2P+n+?=
 =?us-ascii?Q?qfY5m3zxlT4gmiGcxzJ7lLzdqHPH3zEpFcFpi0Sub6Ebf1qD6Uu49EtEQWgb?=
 =?us-ascii?Q?ouDljDYMvObvJbumIR188onANCshOY2ZoILez80uwe/OXzdF/F2ST37KJhz0?=
 =?us-ascii?Q?fQ64lQ6AjFovJkJuOFIgUOm/GRLes0FrNtdQ+b2X4Jbf/3zWSzv7fprTInBn?=
 =?us-ascii?Q?A5G0GKNi/thlWNc9dEfuJUHzfGZ9tycDUAZyo0BIBGLNp0Go2dtiH7a2Tviq?=
 =?us-ascii?Q?U9ZTUtd57mnpH5Xsc8xpOdAj19umTY6DPjYxgadtpk2sHDZ/ZWBn31nMTSC4?=
 =?us-ascii?Q?X700FdWuK4WwG2A5oSP2TaCmtJO8t5v3MiY953VXCAO19DGRNLvRx3iCtaQ/?=
 =?us-ascii?Q?p5PR83j3Sqq6RYfsoDAYsvvHoQhOAXSwA5rnItGDQYGNMx8c3DkjLta7ggDQ?=
 =?us-ascii?Q?3wCBLq945yifY1HhBsZcmhzBiqwFTYjDrC0+9Acz3g+mlaNrqoI5vjropszt?=
 =?us-ascii?Q?uq4SExwuu4VtcO05dVcZoGl6qsncN6kr+JAZ+X7vPPQ4VY1UKz/V9cKy6yEZ?=
 =?us-ascii?Q?txgWEDiXgxboq2o8Q8FiM+ZWvgvTgKjZ98j7v38jBuWWyIiKdLj1qr/JR5c/?=
 =?us-ascii?Q?TdkvdbQi41FnZ4X+CAyxPZLi+MWyqPELKajAOgU7lrOn2OHaKQz3E2nvgAzY?=
 =?us-ascii?Q?p1d4at6wsajSSZxBTKwD4Ywz3fB9VuRfoPZfO7kd/lzGH2H5R99QZ4lfuQ++?=
 =?us-ascii?Q?gPW1lgQTw79vDbBP0/NDf9qzawGHgfsheVVqMnqb2ryclfJtThCzG+/lhoUJ?=
 =?us-ascii?Q?Dc8JdJT4VjJhR12zQno9PLiMz4QM0ZIAp3bf+VO+x5dwS1Ct18w0uTZTMm0K?=
 =?us-ascii?Q?n5QCCRlkDNDl133bT1GLRQbRgO5IjNjyUcfp4pAz4p13eHxM1n+Ob573SI2/?=
 =?us-ascii?Q?F5vlvBcpEzte+8RC6UA/kXrE8QdbINt1dpQNgFZIO7T8/Vw97ng3jhCua4MH?=
 =?us-ascii?Q?3UrqXmQOREXTaa10+If/BW8D8Z2uJhMfOd38As3Ou3Ge2YiDmQgTP6bgt4vv?=
 =?us-ascii?Q?mN9nV4lKagTTdTYUUKIPQKvI3CHX+o9V97UBZAybnvg8Vq+gJKyFIwsK/BGD?=
 =?us-ascii?Q?nDYQcGl5/2DmlURfKgsMARV9JPkr8mTVQc3eWmuROF6ono6otgvCzj4NamoX?=
 =?us-ascii?Q?DDqgSdEBxP56Q/q1zeLQNUHC7xFfT4svdBBQIzUTe8Y3Dq1PH3fdX882Z3xc?=
 =?us-ascii?Q?1DLsiEMa98tuX0caqHkFhsgOqKdrCYB2rzr91Ls7bN+kGMS0nAqEgUn121LN?=
 =?us-ascii?Q?N1ag41+U75M+R4qkXGUgUGz5JLGJjTeXfWJvKo47zb9QxQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lbUChdWWNFCEJeZAFeMg/57o69CfFsBA3zGMNcA7NLfuH8EGA6juL2jr/mt/?=
 =?us-ascii?Q?uyxuVo4U0hHwBtseO1/m8/Pv3RFLEmKlrOJ76omIK1pzCDlG1Ae9V8CEI/38?=
 =?us-ascii?Q?7eZ0mWTDtm8IYwnGwFYjHbG6DCuAUnbG+i8QVRUDoirLuR/rnE9ua6Ij3R5D?=
 =?us-ascii?Q?I0F1Of20oZANTJRfiIbxDSNvnY3eJgOPrOjLHVs86vVRsTSeGNWo7gpm3E3v?=
 =?us-ascii?Q?m4sf4z8F8tOAw84jN0V1710i9Ay1tQ0ngIthR1Vdf/FrcwSSTTIwanZqhgjd?=
 =?us-ascii?Q?Fx3iL9w1ilnW/lqh8/qvgtYugcx376QsoeIeMjvo/esmVZBGPm111/H2nsno?=
 =?us-ascii?Q?azpIhIPmbmqBs69+/ESTsA/pIBlz/dzkqLt48xP1J1K2R4Hx1O4YxhCgDNKp?=
 =?us-ascii?Q?XJppu1p6nLPdLHqO7njVqhXC025SUgHbtcJJGYzTAqt6dbBAKoNKotnE2I+I?=
 =?us-ascii?Q?D8Wm77CBedzEBzx7+tEfzZisb+ZNZhVRKptT/3JZI15i9dIT4FnBdTIP9UoY?=
 =?us-ascii?Q?rh+3jF4w44wJ0qdgOpghB2jDjMIGTcOdpLg7txDibVgGWvoyap/INNXr920r?=
 =?us-ascii?Q?ZsaER8Vovm95k17BVIGd6YGXYczcmwhxYJsaUg9j2FqMCCybohUGY8jptQBK?=
 =?us-ascii?Q?nkH3Z4bZC8N+H3lIRWOzLmgDi9as44D0JRAsi5+FzsiGk4to+IGC78IRZ4vo?=
 =?us-ascii?Q?5CnXGpwHxfEw6AoIV6QPB6bUrvZK2r7smNW7m3QDSGPS2z1o1i6WqMjfwsq6?=
 =?us-ascii?Q?xkfIS/60jsPpGTB7X7Lh3/NyWgnyP9D2Y+Ql3YJ26uC6JsLRZXwOyDUoVWof?=
 =?us-ascii?Q?tRe4to2nKVW/WF89JpVbXwGhuDjSKzjxnS2Owsr+AN0Sxa7tS7gZF0AXeACY?=
 =?us-ascii?Q?f0T885I3lN+7WKPL9sGaYSqvvzv1HlH60jXCq9gyk/OftHVCER2GB8UBZ0cA?=
 =?us-ascii?Q?w7dT/TftyVspX0t6FVfGmg0r+linjdGGhQCJsr+TWRkR78hXWeyQsK3VdOQP?=
 =?us-ascii?Q?Jh4YcXoSDiVQSxZNRMiaQRxbwrIKcsuGnFgQyONDZwssdQZIh9UqRdPFKxpy?=
 =?us-ascii?Q?fdLRFdtu5fLNb2gWIdIZT40y4+nOchkxRK5RUH3oeffzjhFGrxl8GpimexQU?=
 =?us-ascii?Q?C8S+98Ip3I7zg6fCDl7fWdX7tT5vEICMvxDOqAZJ5j2U7MO8FTMVeuX5hA+F?=
 =?us-ascii?Q?W5mUReyXJia/mMOY0RdhzNF7eHvo8y+kq/9vbjtco5sYmEmMfhiO562+jCT8?=
 =?us-ascii?Q?IFTVYzfTt8I9ngISYly/qHsg1cSTey4agiO9M0I3D1y60UMrTMeBqUF8z+Vn?=
 =?us-ascii?Q?iLW2nScOX34Fk8BblhFLdqFgfb4sWpDrTEiYmMz4VrdWwjbo+9fl86ONOqfv?=
 =?us-ascii?Q?CAPvbUhW3/v2Bcan48akQQM+ywW1ajjoUofRS3ecEwl8CghzwPv0CRrxMoVq?=
 =?us-ascii?Q?IcJ3MQTE1rxTVkU7EVtjfKyfVyKZEEKvGnyKeg4B7YPJetMAhxYqLbsEqsVw?=
 =?us-ascii?Q?7pXTmKeISjLMQo0UlT6jmakQUQ29SCSWJiEUQ+XgNeIKk5lwxnrZ4hxmVNSL?=
 =?us-ascii?Q?Peupk/wJXmmn5fseFgj7o7uj4qjc6nKj3dXPRjU7vqPFQIYngwOr+tgY8OsF?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9DWrnOD7ozzGkf+pjcWRZXhh+h8S9tOiYzLVv90gq4t171jlxIiwfDwtPxfXyloPmeYvKWS2MF5TlTv2TVJfAI3syGYiLojWGFispm+fQra4EiAelpEMG/SoB1+NqMUfdo6HIndvp7PozZcIwv8WoqIY4m+hqzIvfjQxFeQ1GsFiDMP9OarR3MFqY68Ye0wFAqksPXtSJrQRc9OPCp0AqcRgcIs1zykiJ8R5Ntaj/heQTPOr1N7HyT6uKSlihfaDIL2JNJBCM7y2Ie870eQvGv53WuHujMJGsFo9DvyN8mnneG3exdDGF+1qdzOh7g+lf35doTHH6fcCRfSWELWz3Yyb2Sx9fvpCL6Y/whACjdUV0p2M8jIe6lv8/p0e+fxmipn7dKtMkaEZq7vdS1c/4AYXL22fxLqXM55ejxrRwsVCKWFsYnydsIfnL62Gw0PkSyS4orLR8ADOoNAtzhlt2wUbjGM8RMMp9B6CzgkcFXhy+mQZv2ztlgLWm84u11lpeSrStI2RI4I03VhzR4VItUqSNdCer00e5lFW/4bQ2ohy169gLKSyK9ANLRVLA7ZatfAS6xPwv495RhTeUySgKLQimH7pgvngzzSBaJatl7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d23bf4-91f0-474b-023f-08dc9b576d78
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:58:18.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uTXXUC3VIG+LTbbTcb0BhnBBJ1Nb2UiKEx6CqiIJl+eTMI/8pB8ZDXxgDb6DBupPf9h0mLlrKNAQw77Kn0W8+czKq8GsF/7JZBX+ahYLzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030087
X-Proofpoint-GUID: nfaXVTjIAr6sReLTZYNL97w0AQ8_6NqF
X-Proofpoint-ORIG-GUID: nfaXVTjIAr6sReLTZYNL97w0AQ8_6NqF

The core components contained within the radix-tree tests which provide
shims for kernel headers and access to the maple tree are useful for
testing other things, so separate them out and make the radix tree tests
dependent on the shared components.

This lays the groundwork for us to add VMA tests of the newly introduced
vma.c file.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/radix-tree/Makefile             | 68 +++----------------
 tools/testing/radix-tree/maple.c              | 14 +---
 tools/testing/radix-tree/xarray.c             |  9 +--
 tools/testing/shared/autoconf.h               |  2 +
 tools/testing/{radix-tree => shared}/bitmap.c |  0
 tools/testing/{radix-tree => shared}/linux.c  |  0
 .../{radix-tree => shared}/linux/bug.h        |  0
 .../{radix-tree => shared}/linux/cpu.h        |  0
 .../{radix-tree => shared}/linux/idr.h        |  0
 .../{radix-tree => shared}/linux/init.h       |  0
 .../{radix-tree => shared}/linux/kconfig.h    |  0
 .../{radix-tree => shared}/linux/kernel.h     |  0
 .../{radix-tree => shared}/linux/kmemleak.h   |  0
 .../{radix-tree => shared}/linux/local_lock.h |  0
 .../{radix-tree => shared}/linux/lockdep.h    |  0
 .../{radix-tree => shared}/linux/maple_tree.h |  0
 .../{radix-tree => shared}/linux/percpu.h     |  0
 .../{radix-tree => shared}/linux/preempt.h    |  0
 .../{radix-tree => shared}/linux/radix-tree.h |  0
 .../{radix-tree => shared}/linux/rcupdate.h   |  0
 .../{radix-tree => shared}/linux/xarray.h     |  0
 tools/testing/shared/maple-shared.h           |  9 +++
 tools/testing/shared/maple-shim.c             |  7 ++
 tools/testing/shared/shared.h                 | 34 ++++++++++
 tools/testing/shared/shared.mk                | 68 +++++++++++++++++++
 .../testing/shared/trace/events/maple_tree.h  |  5 ++
 tools/testing/shared/xarray-shared.c          |  5 ++
 tools/testing/shared/xarray-shared.h          |  4 ++
 28 files changed, 147 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 7527f738b4a1..29d607063749 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,29 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0

-CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
-	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
-LDFLAGS += -fsanitize=address -fsanitize=undefined
-LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
-			 slab.o maple.o
-OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
-	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
-	 iteration_check_2.o benchmark.o
+.PHONY: default

-ifndef SHIFT
-	SHIFT=3
-endif
+default: main

-ifeq ($(BUILD), 32)
-	CFLAGS += -m32
-	LDFLAGS += -m32
-LONG_BIT := 32
-endif
+include ../shared/shared.mk

-ifndef LONG_BIT
-LONG_BIT := $(shell getconf LONG_BIT)
-endif
+TARGETS = main idr-test multiorder xarray maple
+CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
+OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
+	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
+	iteration_check.o iteration_check_2.o benchmark.o

 targets: generated/map-shift.h generated/bit-length.h $(TARGETS)

@@ -32,46 +19,13 @@ main:	$(OFILES)
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)

-xarray: $(CORE_OFILES)
+xarray: $(CORE_OFILES) xarray.o

-maple: $(CORE_OFILES)
+maple: $(CORE_OFILES) maple.o

 multiorder: multiorder.o $(CORE_OFILES)

 clean:
 	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h

-vpath %.c ../../lib
-
-$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
-	../../include/linux/*.h \
-	../../include/asm/*.h \
-	../../../include/linux/xarray.h \
-	../../../include/linux/maple_tree.h \
-	../../../include/linux/radix-tree.h \
-	../../../lib/radix-tree.h \
-	../../../include/linux/idr.h
-
-radix-tree.c: ../../../lib/radix-tree.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-idr.c: ../../../lib/idr.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
-
-maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
-
-generated/map-shift.h:
-	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
-		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
-				generated/map-shift.h;			\
-	fi
-
-generated/bit-length.h: FORCE
-	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
-		echo "Generating $@";                                        \
-		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
-	fi
-
-FORCE: ;
+$(OFILES): $(SHARED_DEPS) *.h */*.h
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..5b53ecf22fc4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,20 +8,8 @@
  * difficult to handle in kernel tests.
  */

-#define CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_MAPLE_SEARCH
-#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "maple-shared.h"
 #include "test.h"
-#include <stdlib.h>
-#include <time.h>
-#include "linux/init.h"
-
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"

diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index f20e12cbbfd4..253208a8541b 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -4,16 +4,9 @@
  * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
  */

-#define XA_DEBUG
+#include "xarray-shared.h"
 #include "test.h"

-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
-#include "../../../lib/xarray.c"
 #undef XA_DEBUG
 #include "../../../lib/test_xarray.c"

diff --git a/tools/testing/shared/autoconf.h b/tools/testing/shared/autoconf.h
new file mode 100644
index 000000000000..92dc474c349b
--- /dev/null
+++ b/tools/testing/shared/autoconf.h
@@ -0,0 +1,2 @@
+#include "bit-length.h"
+#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/shared/bitmap.c
similarity index 100%
rename from tools/testing/radix-tree/bitmap.c
rename to tools/testing/shared/bitmap.c
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
similarity index 100%
rename from tools/testing/radix-tree/linux.c
rename to tools/testing/shared/linux.c
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
similarity index 100%
rename from tools/testing/radix-tree/linux/bug.h
rename to tools/testing/shared/linux/bug.h
diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/cpu.h
rename to tools/testing/shared/linux/cpu.h
diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
similarity index 100%
rename from tools/testing/radix-tree/linux/idr.h
rename to tools/testing/shared/linux/idr.h
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
similarity index 100%
rename from tools/testing/radix-tree/linux/init.h
rename to tools/testing/shared/linux/init.h
diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kconfig.h
rename to tools/testing/shared/linux/kconfig.h
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kernel.h
rename to tools/testing/shared/linux/kernel.h
diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kmemleak.h
rename to tools/testing/shared/linux/kmemleak.h
diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
similarity index 100%
rename from tools/testing/radix-tree/linux/local_lock.h
rename to tools/testing/shared/linux/local_lock.h
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
similarity index 100%
rename from tools/testing/radix-tree/linux/lockdep.h
rename to tools/testing/shared/linux/lockdep.h
diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/maple_tree.h
rename to tools/testing/shared/linux/maple_tree.h
diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/percpu.h
rename to tools/testing/shared/linux/percpu.h
diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
similarity index 100%
rename from tools/testing/radix-tree/linux/preempt.h
rename to tools/testing/shared/linux/preempt.h
diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/radix-tree.h
rename to tools/testing/shared/linux/radix-tree.h
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
similarity index 100%
rename from tools/testing/radix-tree/linux/rcupdate.h
rename to tools/testing/shared/linux/rcupdate.h
diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
similarity index 100%
rename from tools/testing/radix-tree/linux/xarray.h
rename to tools/testing/shared/linux/xarray.h
diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
new file mode 100644
index 000000000000..3d847edd149d
--- /dev/null
+++ b/tools/testing/shared/maple-shared.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define CONFIG_DEBUG_MAPLE_TREE
+#define CONFIG_MAPLE_SEARCH
+#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "shared.h"
+#include <stdlib.h>
+#include <time.h>
+#include "linux/init.h"
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
new file mode 100644
index 000000000000..640df76f483e
--- /dev/null
+++ b/tools/testing/shared/maple-shim.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Very simple shim around the maple tree. */
+
+#include "maple-shared.h"
+
+#include "../../../lib/maple_tree.c"
diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
new file mode 100644
index 000000000000..495602e60b65
--- /dev/null
+++ b/tools/testing/shared/shared.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+
+#ifndef module_init
+#define module_init(x)
+#endif
+
+#ifndef module_exit
+#define module_exit(x)
+#endif
+
+#ifndef MODULE_AUTHOR
+#define MODULE_AUTHOR(x)
+#endif
+
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
+#endif
+
+#ifndef MODULE_DESCRIPTION
+#define MODULE_DESCRIPTION(x)
+#endif
+
+#ifndef dump_stack
+#define dump_stack()	assert(0)
+#endif
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
new file mode 100644
index 000000000000..6b0226400ed0
--- /dev/null
+++ b/tools/testing/shared/shared.mk
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
+	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
+LDFLAGS += -fsanitize=address -fsanitize=undefined
+LDLIBS += -lpthread -lurcu
+SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o find_bit.o bitmap.o \
+	slab.o
+SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
+	generated/bit-length.h generated/autoconf.h \
+	../../include/linux/*.h \
+	../../include/asm/*.h \
+	../../../include/linux/xarray.h \
+	../../../include/linux/maple_tree.h \
+	../../../include/linux/radix-tree.h \
+	../../../lib/radix-tree.h \
+	../../../include/linux/idr.h
+
+ifndef SHIFT
+	SHIFT=3
+endif
+
+ifeq ($(BUILD), 32)
+	CFLAGS += -m32
+	LDFLAGS += -m32
+LONG_BIT := 32
+endif
+
+ifndef LONG_BIT
+LONG_BIT := $(shell getconf LONG_BIT)
+endif
+
+%.o: ../shared/%.c
+	$(CC) -c $(CFLAGS) $< -o $@
+
+vpath %.c ../../lib
+
+$(SHARED_OFILES): $(SHARED_DEPS)
+
+radix-tree.c: ../../../lib/radix-tree.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+idr.c: ../../../lib/idr.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
+	../../../lib/test_xarray.c
+
+maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
+	../../../lib/test_maple_tree.c
+
+generated/autoconf.h:
+	cp ../shared/autoconf.h generated/autoconf.h
+
+generated/map-shift.h:
+	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
+		echo "Generating $@";                                   \
+		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
+				generated/map-shift.h;                  \
+	fi
+
+generated/bit-length.h: FORCE
+	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
+		echo "Generating $@";                                        \
+		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
+	fi
+
+FORCE: ;
diff --git a/tools/testing/shared/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
new file mode 100644
index 000000000000..97d0e1ddcf08
--- /dev/null
+++ b/tools/testing/shared/trace/events/maple_tree.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define trace_ma_op(a, b) do {} while (0)
+#define trace_ma_read(a, b) do {} while (0)
+#define trace_ma_write(a, b, c, d) do {} while (0)
diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
new file mode 100644
index 000000000000..e90901958dcd
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "xarray-shared.h"
+
+#include "../../../lib/xarray.c"
diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
new file mode 100644
index 000000000000..ac2d16ff53ae
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define XA_DEBUG
+#include "shared.h"
--
2.45.2

