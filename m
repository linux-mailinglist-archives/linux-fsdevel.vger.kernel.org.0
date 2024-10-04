Return-Path: <linux-fsdevel+bounces-30948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499E98FFA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD7D1F23AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C4154BE0;
	Fri,  4 Oct 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQzQZ0mq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e7Hm7u8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1A14D2B3;
	Fri,  4 Oct 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033841; cv=fail; b=Msr8UFDhREwxQR3/Nc9tQnm7b2ePJEUXS9R965NSY7R3dM1xVSEYbt104jMT9ll1C+d/u1PwU6ENvX3S8OKyMtTMH3NAaT0cNJO/fzOQFQGrlOkJ/No2ZmzuElaWO5T+VQcM7R7nndrhbxC7beS8d2rCIALu+4sB3RTMmcsFgxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033841; c=relaxed/simple;
	bh=Ao5wS8zFqjiWuLBEFQKIpdd74u7Jy6t5sEuht///BAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJb9H+YvUuBR1MZWPJQxdJgxaEjU1NQrwWGFMOTDgjMOtFAQXqpUe7UreQXtzKqkPggUk5iSSW5MnkzFjuGHn4Bg6ywIxnIvSSckMwoo/fdL8rCbdUWo5y1ezokAXp8DSwgo3wldM9rNNJ/3SP74RPYGWKng2y5oNtyX4vmayfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EQzQZ0mq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e7Hm7u8p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tdts013481;
	Fri, 4 Oct 2024 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=jIyXK717ZbzgZ9k0xICFVe7kia4cyLIACzQgT4x7Hzc=; b=
	EQzQZ0mqbV/2LJpCckfdLfVk8C2dvavjdLvTL2Zu6OSHgnCgnfImKaCHKVJz1dns
	0EP4geJSAv8OwX5sJspqnxrp6bbqA5FtEEzjIeqC92U9c5atnaDqskxKM3LDkFed
	NYgmIGDC/sFJ0JPi25VxlTS6R2applHU7XWEj9NnSkZrlaNEtvb+MYB/S1saleDD
	ENjuLTju5vzQjtP33i9evUy2Se28S08G+L+X2ySdzihzQVOArBjaaBiajAhkJ6+O
	gzRWO0S2KRMs06VRWxTcsZRFGFLx+8H3v2Dz5AeHSXSgcP0XHAzlkJP7G33NucJy
	k78tZHGoE3WHCfosGWbsog==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204es6pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49495IE8038110;
	Fri, 4 Oct 2024 09:23:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057118t-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLX5gjfvcNSVKmEpZfgldghYPibH/mdAcjAJPHHZcEC2PgGKyMUucYTndf5k+F43xYtJkhpun7Cspe8f4EzmpBZ0b8qZH8siwKR6hcQ/BoY4Cu27/VvRqz43UBGD1/gmI8Cz6G2U5In+XQ+JCYaozIxqiuhryrXnQWquH/qFY4COhjJi9Z8AF4GWmZRNVKxIKt8ldjLZREABBgJBo1N5e3cC5NLlW6pe47EoRHB2hxxaW8kZcbhgbDdDIFM9MfIwwWMlTyL+olRhGIkC1oBC5Xu0QUN1gqzc54P2GuU59AWgJ0EjVK7an49btZuWS99aVWAaQLIptxsOPpiw898W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIyXK717ZbzgZ9k0xICFVe7kia4cyLIACzQgT4x7Hzc=;
 b=LDFEQNmVT/j2uzXDLtcFtz+3ige7dlEsMpq84iAssGBWi74Upje9EJcFY6hb4Yhcw+PeSbVPuAfHagw/N26tP9wDkDzIdo5XhXA/GWI/SxsTqf42fdhV6tREmLEAWKdjNQTGPB15J3CM/IGjbL5gzsH/X8THPwnC4OiHqVON7iH0u9b7H6yAT5X1llmHNl9CHsbByH4/ziAKkDajZj1CqiD7V5umsPZ46Z6hTOK3vytMZCOgOjrVtjlVnISRGLLHfKeq0ysEPd1SoAL/v5QqXTmp6It6Z2PHzGi4qzJWG+e9KyV6qupfS6dGmhEQxjhdNWFWOM5uR7pn06NX/xt9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIyXK717ZbzgZ9k0xICFVe7kia4cyLIACzQgT4x7Hzc=;
 b=e7Hm7u8p/XBHDqk93Febu/KXJ41Jjgnyb546bSeaO4ilN1rXR+pt2+BbkTvw5mTfZUACWnaHCUk2SybRninVGMMW89LEDQnRobmUFxyOfsmQhzQzg5tdd6Aq8Uiy1WEM7BOFUNkbp5fGbO8uk87VUyvMYLeuiqa/PNcDCWNjfps=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 8/8] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Fri,  4 Oct 2024 09:22:54 +0000
Message-Id: <20241004092254.3759210-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1bf6f3-d93e-4567-2c26-08dce45638c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QCnupAp6852IJuaJvri6PIG0+2Cej1r0HwAgB0DF86ia2ngsqojJUTFoTo3?=
 =?us-ascii?Q?bUf7GdxpdcouQs6yYrpdnJTXWFhg9VMGi1Vy1PkfsiJGT1o34B5n/jDCip+6?=
 =?us-ascii?Q?zdhA8p1WFWyAT1i2weidy7vkDboypJB7oIFNiboW7qu/SEPif2lQR2xM8Hcc?=
 =?us-ascii?Q?RLB/yE8G7O1uA8mKSgLYVCA8o4mCquIf8+61RVY0P/6AT2a1IhXW3KPykQ1f?=
 =?us-ascii?Q?tmR2XGu4/LSA0eC5yz75ZspZSr9gl8IdfC/B9lOCDcfyYnzzhpynhnKzWKPq?=
 =?us-ascii?Q?NkpZIWxeOzil5q3YrqMdML1/Ki2Vx5jCWAXPoDXNAV7K0EDr0FOPC19fsW1A?=
 =?us-ascii?Q?It9MIeSgcIzjDEzfgOPcDMJ35xXuwZ1ur5uBxpjgVgjlUNs4yzm3Vta4N4S4?=
 =?us-ascii?Q?ccGHNxAuwiFc/M78qmPOjVIzRkSUodDLIcrVvKUK8B5/ScmIff9eFQKe9THY?=
 =?us-ascii?Q?yl90rfyqeWyGvy3zov7a6s9Ur9Ao/fryur5hzn+KfMGTS6DfnGWf71EwPF02?=
 =?us-ascii?Q?qQNgIiStoQSMbrOTI7SRizV8LjCBJEM3Pyv8nmTJq0lWOnolkHMhd1FA2Yvd?=
 =?us-ascii?Q?VFSEIyjlVd+4gUyYcJ9yoo6p9B7qIDO36Oe3175LGl13txfr4DrOiV1ZiuiU?=
 =?us-ascii?Q?o6ZNt8UjR6sU8QAJhM8LHRVItcK47cqYRmioKLkaknskgeF3Ge5aXKGtDBq4?=
 =?us-ascii?Q?x7ymAuO8U3P6Hfvzm8JPeSw61c/i1Kx1knAOGFLUd3IaujQUJ15ICBwUvcNb?=
 =?us-ascii?Q?6EEtApXCPTef1OXLBQwH7vOz6ui02nMr1NuXxbK991KJ9vpSF69PrPta+0PZ?=
 =?us-ascii?Q?dsE7zKrfrPjQRmt22yBxnFc2cn0UxNqOdqVPeuJBvkHJlo5yDuI5yLI6NpsY?=
 =?us-ascii?Q?zhG6FmHr0nfzVRGCjUvlCTyznqRUJ/P1aZPuCal05WKHKJqcNPDcD4XeleQh?=
 =?us-ascii?Q?R1yWqwch32PtUojF8wEJS/bQ8+iL35cqZKlbDz7jzNMNB57GoxytN2cjlpTJ?=
 =?us-ascii?Q?1w/b6q5GU7CQR0o1hLWSw1M7ERHjbHPRY/Iq7ltecpVvbXeH02/No6WTJwFi?=
 =?us-ascii?Q?Ax/hHidqlwzjntKjIohKBnV00US7PLY5H/zSe/zhZ/QDi0oLkFj02mLdRTYH?=
 =?us-ascii?Q?LUHKF8H6NSUArtuc+3YIsYEDVQ49bL/pZkRoCorsxB3EkZLKACdofCQI+HB4?=
 =?us-ascii?Q?LRkEskgfBreSqexgYAQwk94aRlc09wfW1LDBWF+1e6f6QBVRZtZG4LCx3KDe?=
 =?us-ascii?Q?Gbqvs6Nk/AO7/qfT30PhJ1jIsVlE3gYu36M81dviHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0uhcQYIpcAF7bBeRdfo33J2neHTgKtSLII2f5HPPdwk7IT+2GLd51ERBNlf?=
 =?us-ascii?Q?z1Isjqc/CStLrInLyUWj7UMPuHUjNnaTbM9qljycRGnrbzqq0FF2knie8Ldi?=
 =?us-ascii?Q?Ym8ttjP9nk3ExbRMdNimObbu0bcQQ3isZWQlDACEyZ1QEPeRZR47PRIL569f?=
 =?us-ascii?Q?q6eGguMew7/BcwBKwCkLiWnUL3UF9QZd5scuohvbZd8gWBeD3VNG1jJlYRom?=
 =?us-ascii?Q?LlxjzZ+mq3f/TA6NXfUPFfaYFAC56IkfyMXnvkPNJUUg0BVfpr2wFi2NXk2E?=
 =?us-ascii?Q?O9sjn2rRKDC4dke9UFW+zklhzkhJgsKB+x15NSBdmS4uYkRgDkKYNzrF2SHK?=
 =?us-ascii?Q?QZK0l7oNa1ljVACuuf7NHOHA8udZJgDHXr3FBygWMzvSphTvRu+Eup87wZNl?=
 =?us-ascii?Q?q5RT+JGp7mU631FK6HEEX5DLI2/B7I/hasgEb1Ph3DwHZJS5PF+rncFO/f5o?=
 =?us-ascii?Q?F66JNZ40JpMbW4+RM8PoreR52U+8gbVjcQmrDh4FixziocDCB+rKXs3VzKoX?=
 =?us-ascii?Q?mhyY8IQU/2mTGLs2fb8x89bdPaONsXW8VCVMdncQVdUrVs6gVaoBVhpcfUNy?=
 =?us-ascii?Q?MWDI9RRsVDuVA4Hem7NXJiROvM2/Vdl/05iD53BAN1MtduYw5woKTi3fHfok?=
 =?us-ascii?Q?i4eDWDUNpr7lZbic9fbuDtjkVKjnl7BHrKasr2xvfJ6rD2tHWq/bzHMaGIEt?=
 =?us-ascii?Q?yhcCVziKhD+VysjwBm6hv5qyW/WVSk2/zeOQEuNB+vsx57rsIwHZ7caVOfRl?=
 =?us-ascii?Q?uecRB6iMmnx15kD/XpHjp2QntyAOtlotVpvZOfJHDuPzhda5sW4gRXAclCtU?=
 =?us-ascii?Q?o5jYWcnWvy7uyVLqWAO/BgUyIy3hgR6VkekphTb2WYEJB/fwyH2yoH7vNESa?=
 =?us-ascii?Q?iKoWiwVMYvDEfuwXQkVz2WEUg1RdiTgfDzpDStHEL/iVqDO8ofzNNcHA/tH1?=
 =?us-ascii?Q?p+AiBhIsNMQ7beT1Juj7nM9kHWPIHbOKznUKqTrPL/9slQw9RQMEgIEOCFuU?=
 =?us-ascii?Q?jVQXz6Q0GvcNtyNnkACTGlf30m5HZ4nVO2zhtilStuM0DH6J/ZVZjN0IRmju?=
 =?us-ascii?Q?+WzVGt0pHuZKrsCJpy+j9sFoJW9ssJ4R5bTGPBWusbtKe5upNuGdBPR+2C8/?=
 =?us-ascii?Q?kHHwjKFCXi0DPYvj/p4M9iV2NGoIE9FGwSxGYzWeoeZMqegyLy8lEd2wxGEb?=
 =?us-ascii?Q?mh5EogC+BRr9xH+x8qd9jayym9AcAjGPa7We+bkCzUsLTaJh+VjYIHV/mFBG?=
 =?us-ascii?Q?XR0WFJymF+4g23R3a94wfv+JTtrgMIO6goOa70OLhSqnY4VBcpZ+sKyVVoDw?=
 =?us-ascii?Q?L6yVIxMJ5+6vzX0S2Eopb83gAr3uBbmG93PgrSWcT3wQEVlk0a44/CLRHeIK?=
 =?us-ascii?Q?XtrgTNBO0r/XpDSeSu3euLggtKkJ+UeMu/lh5w5ZwtoDU2kRp/s2TQ8eqiu0?=
 =?us-ascii?Q?/ReoMueQ0rEk/J2dFY4GtNZeqwCXKSNGPJU4SmF2Jh7x2/JA6tUy17lcJNBK?=
 =?us-ascii?Q?8hEgftYD8RO5HqRimduxJF+IgLrcl120gzLxpPl4e5U2zZrHwLVHefvUjBet?=
 =?us-ascii?Q?8hPN8RYlrsRNRDXsadpU7ZqYBk8jm8ikimju1TYmQOt0jqlJNQw2v2CcodBh?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hhqfeC2M3Qa2uL0mhbwCTlHKh/fhDhs9qNmUL6w+o8WYkYOXUDohAgjKVCLnqzxKRmZii/xlZmQU/MatOsADU1FzR4vcZIriZPLYBVgdEyvoxzjTFXDXVlegoEF9BiR/vvV4DuwJibCAl4dp5Un4JooFnGnRvTySRo7cupI8oPqQagQEkC4HnXJgMMC32BqdAyYCgIeO+LI8FaNzawojRODMBp21WeuCxIk0rMsJ5/uv2soZG0D5HUIWAY5RLbiM++8hvuYT+H7LC+5GSNVXJeULMfz1SdEjA78MqWVUo2Cwv0+SXlgh2NRAGYS2uSiQViMdT8maDtdFzyRe4l4aSyEvF9EIDRNGHPOsobKGqRu3LVR+mdxcCTjbcH0kL56zKLxgVwxWWReZfBbRe+g+X24Zdeaj3cWY4h+Wm+RN9QqYl5mLLu4MEkjMEeQ5nolUjQBDsTZd1TaEIKATE9umEtPMfZ61h6hnRGOXeHBavpanWvy15YZdm7OzZK+B7ctNg7S6f2Sx213g+spDDwoyuzVHrQn4TaVcmif5p6Rv9kGSMxtvp0ddSyvIEQ8smvgLgP32ISlYAr/V2VuRH9622Xm6NAirBpx3e8dWVUaOZIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1bf6f3-d93e-4567-2c26-08dce45638c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:35.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTZtMDCaznVQ7ZrUeORUST4QVNVcBEY1zg0Ub4l65UgWtg/YnnNffP4b5IwUSXhwupjdjvujVEFsOzutTAFN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-GUID: mseplWj3gWzu3gU3DRiBwvhOMBHNuA9v
X-Proofpoint-ORIG-GUID: mseplWj3gWzu3gU3DRiBwvhOMBHNuA9v

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3a0a35e7826a..e4a3a9882b0a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1217,6 +1217,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


