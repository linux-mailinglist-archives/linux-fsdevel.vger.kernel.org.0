Return-Path: <linux-fsdevel+bounces-43661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F69DA5A33F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E216B4B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D4239089;
	Mon, 10 Mar 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FWEKh3Pe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DgeeZkzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB816238172;
	Mon, 10 Mar 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632021; cv=fail; b=PXoOUNZueBvB33RNApSOl2AOgWK8XgN6vfn+sdd80wcNimLxYJ1ou0pP3zMF7qIqL9764XfOburD7YFGO/I5oDXIiJnx+To8L1wtX/wc42acvokyo4WHN842bFjq62eDW+A5kT6+IOZ73IqnauOqybBYpVnN55+7EjkW9oZduco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632021; c=relaxed/simple;
	bh=B75sDQnS8j2I2rxT4XXtMlxEEcgZiviHmZocGv8QSWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOYeSAZqcIIQiUHjWJ13oIGldwg0XeOqzEiU0oDHeSoMMfkvNUQaQUDOVFrJnmcraRf7uNQn+XKZFLYe0S8YhJsOO4IkG2n4K/oV/yBLnoiYvBsdZAEfnw9yNtVrfZZlySPadNEwX7iaTptbbsKX4SG3Jq4/cngU0pf+wjsBIuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FWEKh3Pe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DgeeZkzq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfioj011056;
	Mon, 10 Mar 2025 18:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Dlc+2fXxsIuW1dmQEtrS+/ldWln/GWH+XV12JdjRhac=; b=
	FWEKh3Pey27DvrZBfQ3/HUx7uueiFYjcl99vNmFDtoWYSMPvTxzVQ/uJhbe3IuFO
	mfCcmGTIGc0hncjgvzyMC30aJgmsg3jjivcfOf0k+7R+TbBZt6HzRcKMdXs10tX0
	rqsgrW4MGSm7DmgcqLmeFKOlU+u5vFvnkSyccoC1OcpHbDv6Hzo/cF2+PjWc2vC3
	woymgQp5tb7JGWtpKGD9mNDBlSzkPnlLAH+oMG2LUcjQvclMkcdc4fWffWrLD1wO
	PL4EF5beIOHkwokU2dMudz6EuGs1d9XrUyLyc4gmirGA0YW97tlj3+PuN4rVoC28
	ILfB3/TunY1TGLIXV9BU9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458eeu39ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AHQQHY019262;
	Mon, 10 Mar 2025 18:40:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbegxfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT4xKttyaHSP9B9s/ar0t9S4SnVBsU0KCkyUwNMCtirGvkZivkqACjsU58xNKv6QGTYYZ8+gKU1nX1g4RIYqNY0W5T0WIzcwqMrnqKSK/khIJZE4G+gU7sFJcuWZs8BPe/WU3pxqVL1ggdmN89myGdprsgqV7PMgRqGVDuB+CLQw6VgnjFsk4KJJ6AX0SKuta5oX+2KVyGB4Ra7JwRI+nx9X5JOFShhhtGdB1eUoIQUBCpBb/9Ac5lne55nQT6cgWJdU6UJzMa5aekroCQQUQ4hDFjwDMcUzY9xO7X913EfzeTvGIs6NRUyZrbG2Cjg4l5znL8dizjLirnWCgJFj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlc+2fXxsIuW1dmQEtrS+/ldWln/GWH+XV12JdjRhac=;
 b=m2Ql8KlmoebdcKV/HuIX0D/zVXZgqxIpx9K5CPCekQ4V+GrzEUy6Ng06SVZjQ8ECAy0k7+yTZdxPDTV3ieSn2TE4uwYZSKKME4PN+oDGvhA1dg0qjlcySHmP280aQExfqFwEVRVmMdg0cZGr+6BJ7D7v7fuU0PhhwMpu54Zq8O6N4ObUISykdRrbbZw2gVX5ZtkpDN8Xh7XoraFGRszp8STCIdpPYBrxMacKptdMn90YOPO4G79Z+f2B/1mYpI+Nogup1W8kxyPb5mDpV1vxLKusoSHJwLvvN70e4FzQQMqZE/h/23B4jKZNFqpoqx//tOcU1ZZy4j1K2MI5XH9lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlc+2fXxsIuW1dmQEtrS+/ldWln/GWH+XV12JdjRhac=;
 b=DgeeZkzqFxzAIhiNZT3oRxC6ZHB5Gr1wJBCuGCfKaJRlvSYMLcI6SRqrUppFpi9eytyG9JaE+lOkpAIQE9iiOFLmTKhF0u770wZpol6Cgz3B/OJUz27GQwYtymJ8rD9JyDDiuANmqQZUN7fNHUdAijj5d91z7eFIREOKgbWFLaM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 04/10] xfs: Reflink CoW-based atomic write support
Date: Mon, 10 Mar 2025 18:39:40 +0000
Message-Id: <20250310183946.932054-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: a7983268-8943-42a7-7b3e-08dd6002fbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G12qFCADfetkYNTCa07CXdsz5aATHIDqTc6B2JqVN6tHwUuu0H48QRQ8H6Gu?=
 =?us-ascii?Q?5vvcp+fzN8dbx96egm7uAGTuOwOg5npPFnqf8u0HyExY7AOA0bRA89UOiNyE?=
 =?us-ascii?Q?KWziuDsxMELNaG8zciuh9/wZMJ8hDpUaeiG/i1FWhUjzFnPjiuAm59m0d/Wt?=
 =?us-ascii?Q?m5jeO2a887CmCVi599yjg3+tPM/1RpcKiT7N2HYFlP7Bhz3qeND43D6pDt8d?=
 =?us-ascii?Q?VE/1/tq6u9jeb00XBI6AQvgNEEolUELg7aAd6gqNGzZSWQgUybCJHY2OowcK?=
 =?us-ascii?Q?Is+RS/hICU0PLbgMesy0z1Wv9KdiZSUs4HlxfBgqBRmVqCJmvpmazyaJNLeN?=
 =?us-ascii?Q?0N9A476CDcoyUdzzxJDVpm1jH3JOTk7wsj1/hEc8a1PclZGU3npV+ojNA2jX?=
 =?us-ascii?Q?uCVaI2nptKUS3bbKFIWVTtXy2ydyY6/2DaI+rKumB0oVAOOD63SCj8+glDT6?=
 =?us-ascii?Q?UysaBkOF4LNzr7zt6g8X0NL4HUdXRbqogbbxk2ODLqgQ45MghpOmo0Nw2otR?=
 =?us-ascii?Q?A6xBzrTfR/qQXXGQt71lIaRWTp8UtrPe6TaBq3Ja07+s/K87uZr8MG+f5LoH?=
 =?us-ascii?Q?NAD3EjnDPkN5y4eB/YePOaMAku/ZCIhYJsETfmhQWG5aPibunxJJPpczytRP?=
 =?us-ascii?Q?V+6Ul6+Rr00VuPyzsZRsp6OIVSfus0XQ8j9HeeEWVsjSTUmeJI4+tF9NQySK?=
 =?us-ascii?Q?0KrlGdeV6TmYOgIE2FQ4ekVYwTV7ixx8+ES3QHvempFA2sBDRWgRMDyCmXXY?=
 =?us-ascii?Q?MEeK4xZ+4g5pUsMtZPoSw5IWrPzBeO8lh9ZD3flwvZu4C85Dk82XzjXcxYXC?=
 =?us-ascii?Q?FTC7wFfHZgtgQSNf+Cg6+Seu8rrk+j6Egj/X6vAtPw6bqTh3vcda043FKpiH?=
 =?us-ascii?Q?fKOYFAUTtSqRtp56loytmfnbs7EC/S/0hT3Q3vpkumjFEiHZIo5y5Q7Wd+Yw?=
 =?us-ascii?Q?lrhEJEsMJUtNw8xSDX4U6Yla3xe7o4dPW2ElHIfy/ThQ4h7h/S0OGzzuRVY8?=
 =?us-ascii?Q?bYG8H+oyFmf8PoRLVaBOCCv9xEwWDlfCnPLag96VTOC0MWoBmc3q0zc0ergL?=
 =?us-ascii?Q?lNzEWlETPuWq1w9wt4fRe/J4dxewxMogzI1KXfX/c8gog0HYQpv4C89xoXNK?=
 =?us-ascii?Q?ORBM2cEcCRHdyv2GMUNDnPnsVQTET1IVLZ9ViA2uFB9uSZ1n9RtyB1MiO1FM?=
 =?us-ascii?Q?0ReiWjNoHN3tS/gi2fxeoGQbIZe2yZSzRHJyQoTgRxvJFf8SQe8LmvT2hjwr?=
 =?us-ascii?Q?x/9AcAA7i+pDhQDFfIdgVdByDEUWKNaqcR8K0PaLzNqKPlBwW44GJ9tj7GQf?=
 =?us-ascii?Q?9I6UHcXIpiWbXp9Uh5abSy6VO3ZFXoLrLBe2fGtV53nuV0TVy5QtplWrbpTL?=
 =?us-ascii?Q?D3iMRPJ5qNCvLMkNvekhV0wu2crh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnoOXyaUrYCwEbkpQSR3aV51WHsUQFiFCilz/9VxydcJd96hRRA6lSXbYAsx?=
 =?us-ascii?Q?7qHUYbim1yIGYfstJuzbrv5ZC0DdleoUXwqK4q/tXH/vFM3q5/PEFl5JBeQ1?=
 =?us-ascii?Q?nefFPmzTVf+ZuSwpcFXOEc7MUJClmX8gjNFiPZTSnZjDaH63GFEbQrXU9ot/?=
 =?us-ascii?Q?e5rLh233TrBjr20GbmHEmZxVV+iOQrsj/QdPRLe57ImOQ1qll4rChl4FQLAX?=
 =?us-ascii?Q?z7tgINY8mDBgqhB783taCFWrMZq44rrOrGfsFeWZZQts+izOqu7NgJaM5bNU?=
 =?us-ascii?Q?SRTTft2cdjSXtR8E8S+HBe5Pba0Bl3dZ2qNizetUehh7bMJIW4T7byGb1bL1?=
 =?us-ascii?Q?AMdsnQLr6ZrJlLylQzLYOF18X/yMeINK1yuXJf9AehrFhUvnOw4nzjUlEMH0?=
 =?us-ascii?Q?0Bb10eYlvM5CO7of3WmOLBgYqKB7W5LW+uaDWjMIAbdqTMF+y+MjiJiZW26o?=
 =?us-ascii?Q?h/A5he/Zd8h/ILB7poqq17T7NKQfgpkWeULOE6OjX4+1bY8Pv9a56YpVp7u4?=
 =?us-ascii?Q?bsRJxFsk71i6lZdAj4kHTSnlzydeQwzCqUO/j+gEPXyqypljNvAWKKrLbVXh?=
 =?us-ascii?Q?o3EjgbNX2H49LAw+nx+yiiqnjqy20dgeb6k26jTXDBb0ogbVPzyz9t43dLck?=
 =?us-ascii?Q?33+I9SdGse7vfrLMATeNoMP+f3a9iq9Yv7jCsfI/HK3ILgQKfdJpsxwvyU+d?=
 =?us-ascii?Q?MvLdZoDttqc9nOpNGAjH+etW4B84D35cNiwhvRGgibKkB8lDRz6nITRFONIS?=
 =?us-ascii?Q?QyXR/dQxBnHpVneaYHFuSu5aD+gmuzt5WWWc8kpv02ACK4ZfXBF01RtEHWz2?=
 =?us-ascii?Q?J+Fe9tvv5Y2EvgWzHizdpdXBqKj1zgzYK2rtdzcs5zZ/5Ww8wPGyVYK01INf?=
 =?us-ascii?Q?fy+PK4u+9Qg+HWHI9jNLjDu1ANpc8nhQcUMh0StzZ480qTdjfEBUMQo8/xPf?=
 =?us-ascii?Q?IhMis1elrzLesM7Eg5223SpZeQcpOEPSZYSIm8B2M3X+rwBDIwtGy25TdlTT?=
 =?us-ascii?Q?sXwDFw/88uwcIpJ0wXKclSUVHaLayoo9GlvOayl9qp0/7GeCILwOldNCkR85?=
 =?us-ascii?Q?lR3MC87EQLiDJ9IAa3p2y09TUvzOpC5WOm+6Zhduy89Ex0SIpGtSdGXMWtUa?=
 =?us-ascii?Q?6XWX7ynaU5Xj7Efd5TVSYRQllPxbEhUaO5GREsRJmlrZdJvaHzvJxsDCk/rC?=
 =?us-ascii?Q?UeRQGRGEdLoHWG4gq81r9iAS37j5VO0VzIxf6u8KoGvEv0FtZhA9FD2MyuRn?=
 =?us-ascii?Q?3AhigT9X63b6y705KiGEYPuCtbfQdgM7YRtTROhH+ydxWtGsEQePf1zTgqlw?=
 =?us-ascii?Q?mIhO3XTrOvIMwDNyUU8mtDT0xfdSvKBSEynhwIf/vn0OAe6P0yhJ3fE/tf2D?=
 =?us-ascii?Q?fyleC3VCPy0twWRMax9/Vd05BgE9vlrxSJdmUYdaSKtI6n8aoNGqPEJfDWNM?=
 =?us-ascii?Q?VCpRdrqLXSaeeZWHKX254nrbkjNYy/0h3HXmE+/M/EE9YSu1wCObr+XjgTLJ?=
 =?us-ascii?Q?9MalT7yYBfsLDrVraluVwdJOT6wPFm9tH3+cZObRkrc3A/N71VVevbH4hIdh?=
 =?us-ascii?Q?nQmm4Ok/D3fKFVmqCnUXRoOHGZtfzZobSm3LwmgIuufZ45nOHDl2OfA/uGPS?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E+6B3GzQjOhL8NstEcRy9QsN4j5x65+XgJgDc9Mvg4mTHVRR8uFOTPGFgIpuYstPLuCjaJAskwmFVGTrPhQvY7xqy18TZKx7Pyukygg0rxJ1fSUKpCIOFNHyoTgogITAhpclRGFg0VMpSJk1j16G3682TbPEkQ7hjAebgrcesc4UN7c19IbpbJ7K7vRwwaqaIsswfe8546O+GVhrpIYnfnqyVWhdV9H6vv68okWuSXQjFNNO4BtJGDYNWPxXyCpNMdGV2ObrmJKJgELArLo52j8OrN0viuXqpcip5HOuIavvt3A/SN5KAKvfAZxJSNJlIWauMVDpfYKJKJXkGn2nQ6LTfuyQRlicGbmkvR0K+4JLrMIbpgqnr9UppzEmneevq5IKx/wbIc02lyurcLo/XxydCVJOrE5ODOcoUnSXKzqp5CpbUmzxEwdwAugLKdsgbEEg6fn6qbU2YFLi7nY5m8nUlg5iEZyuiZNkA2haPHeqHZq05zRH6/TJJY/84OCgxdLXtryLCf3uOiQn92SXcNKweqyajIs9sNMFtcFkBTCgzFU0OJB4Ia/j103o1F09yJb1wSWzkrXuNWr9P7V3XswTNFtLg5tZ4Qf5J0s6Li0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7983268-8943-42a7-7b3e-08dd6002fbc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:08.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nMNpld2iionEiNeYYvqWLRk0J29aRXlzVBJcJHbXs0MBpPR0red5NUD5gSpZwgLplizd5vW8JMF3uzPw4P31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: nbVbZQF2D5fM0R2W86SGF11PJAGXd50Z
X-Proofpoint-GUID: nbVbZQF2D5fM0R2W86SGF11PJAGXd50Z

Base SW-based atomic writes on CoW.

For SW-based atomic write support, always allocate a cow hole in
xfs_reflink_allocate_cow() to write the new data.

The semantics is that if @atomic_sw is set, we will be passed a CoW fork
extent mapping for no error returned.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 5 +++--
 fs/xfs/xfs_reflink.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index e3e594c65745..0949d6ba2b3b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -444,6 +444,7 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic_sw))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -580,7 +581,7 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !(flags & XFS_REFLINK_ATOMIC_SW)))
 		return error;
 
 	/* CoW fork has a real extent */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cdbd73d58822..dfd94e51e2b4 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -10,6 +10,7 @@
  * Flags for xfs_reflink_allocate_cow()
  */
 #define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
+#define XFS_REFLINK_ATOMIC_SW	(1u << 1) /* alloc for SW-based atomic write */
 
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
-- 
2.31.1


