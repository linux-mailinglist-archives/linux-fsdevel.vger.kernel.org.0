Return-Path: <linux-fsdevel+bounces-42980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0890A4CA1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45B13AA8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA93256C71;
	Mon,  3 Mar 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGzBU8Y0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WJPK5IAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7F255E4D;
	Mon,  3 Mar 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021932; cv=fail; b=KGkLRqLhh1BUByCJpIWgqD+hBqoTMDpuVsDVo2AwqzJeSI7LMpnjdlYejZKfTRgDgkvegh20JI3y8ElGEvx8SklV9CwGBwlkwxk7WJmK3GKNKOuLltQC424fgyiDIiWtBelYdDYXe7VDURuOWdBDSq/UREYJEIy2m+UQUl6tKe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021932; c=relaxed/simple;
	bh=0jcjH7lflg/OATJdR4jfdprbTFFCtiNiBDv5pXzbqaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOSSyAQAMVE//Eyxvil/mc/vh1W46r18up8ZypUmsvP0wKiOHpXHfBw3fMJsWt3QXyqsYi+ZeyE6yW/KATQmAVvJr2kLLxlsXq+y7a+EisYwhEAma3xeW1zw1NvmTUoRn1Z+LrgM98HJPn+HWUwfcQKDQcknOoIa9e129eBGSUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGzBU8Y0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WJPK5IAQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GKg44007122;
	Mon, 3 Mar 2025 17:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RxWGVWTUVOBCFzJUUzYwcwqWtU/bQPxhvpIVkGxnxf0=; b=
	CGzBU8Y0LU7m5ikmLLO/xbU0Q+Q6wT2XbeReZbAjwr+Q/waRRf0eTTy4+bhuOBXS
	6UBkrwVL1vJS9EX1w6XIJMHtz0WFmskERK9ztCsIEe+yKEPk7pPpEB7pg1vpXUXJ
	MIuYhdJVv5dDXMZ/NJJA/i7jeNudmogiaK91J0S9Nzz9QO/oRAC1LsKU3a3HCJ0F
	dtQRj6jPiVwOrL2UeBPh01UXQ13HAESd+SXKs6xvAst6greRv1GbN/zAK1ebfR1h
	fCKNs6DmQfnTeX2MIdN3bZPBVV1Qu1Y+6m7FKrX4OcBknKxdcLrQ4NZA9ifx6XMq
	HHXR1+olls0FfquN1B5I+g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub735xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GTgoc003239;
	Mon, 3 Mar 2025 17:12:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7sj4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4ABV+r9rpsKqrxT2fI2BkP9nOIYdMSUYleW0UJs06hXEwB6Q8UQQ2HYYsJg6rSJwTBpCP5Tka8C51UK8HZFncVQsBdSXAtsHEXs5lDQ/MDHywpG90kAHboPF5NWqNGiOoxEDbVotqQIUdeUYmyztjZhTj5PnOj2B4nDGo8u2oPdv1pNQesFP7157l7r3k4RjwXIlVwkCMfTWFQvGcJ8jmp3u+klcovn9ZvHYL4bxEJyQEbhttFh/ptYA1fZZ4zmMq2GPwGRRvu/5Szawp37Ud4NMU0PwavoTsA4MPIuyNhvECZbCbKkOZ2eOG0Ok7JZb25h/ej+QiHExHKq3unwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxWGVWTUVOBCFzJUUzYwcwqWtU/bQPxhvpIVkGxnxf0=;
 b=SrUq6Gipraw+FbudlfJUu+nZRmbgrfCPkKGJR+QGGivG0l4wIzWvSJHhcKKkuwelOFS+FUlc3cWA2ed4eq0Jl9nOkKb81QLvzfjfavGTd6Lr4UOoQ/1OJ0Yfsc6YotCYgFWSegW1pM4MDb68IGdRaXGPPb0aclDhHmvCUyA83tLN2rsYD6bXcYNF1DGL5PoJPT2XFb0Ox/LgEOU1bmM7Cchdk6hOxMrlukKlvjMaDhj2z777sZ6ylV8jeGvsDhhQtDeWHPTEmZLOXz/g+uEcmWkGMHCqzHR0CHaIFp6Ocvg3PGy50GVMbvJueIFLfI6NJG1nM5KzEnWZBsFzgSJkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxWGVWTUVOBCFzJUUzYwcwqWtU/bQPxhvpIVkGxnxf0=;
 b=WJPK5IAQ5ejTjWcwraDumjlqIYma27wapj+/GjDCxU4q1LHqKKwmM5vpIrG4O2t+eX6fj+pxxi4dPg/jofqTygsxeBnOOxWA2wc41B/M8x2FSwA9OOcKUHefLI9+gA0VIH7bvKOCthJhaifeOWH4jIzO4OJHSHe4QVNnZ3aydww=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 08/12] xfs: Iomap SW-based atomic write support
Date: Mon,  3 Mar 2025 17:11:16 +0000
Message-Id: <20250303171120.2837067-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: daadc72e-5f29-4cb4-cf02-08dd5a7681e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sQ2Jw9qYUSWpkKxXTWQ1PtmKbXRFEvAfxA9S+tEcgOfMJT5IZ54Ja5dldw1?=
 =?us-ascii?Q?UVa/mHosxOUvQSSq/Ivbnk/ccgTsTkkvACBfNrAOPXs/ZlIneTMrxU4yQAUt?=
 =?us-ascii?Q?h1fERF4WHQC5flgYZTw2GtmqFoXCYyJayAb07aMgNQ77sv3YShp0KcIhpuVT?=
 =?us-ascii?Q?mFkIr+whsCKtbwSX6PW5d0MO22wQdvyRcn8zkQcHrnnFWKrsDO8nWXbzNas4?=
 =?us-ascii?Q?BdBBDe9KuvvRa7i3wStmCSTMRFwMZFTQu0Z1t4jJjSd9Yt6P0h0iQVcyc0vH?=
 =?us-ascii?Q?KmydIOnezYDTdL4As6AW0MppHhJgU4zwy4Q5yQUN9Z56bJJ23xLSaOYT18hL?=
 =?us-ascii?Q?xlZKrDIx3FP05kxfM5ej/63rk48U/qN52gPLArAdsVeCwGUC5q52g/3S4NPI?=
 =?us-ascii?Q?vwG5kqo1JhPWvAhP12feoVljxSOiPUDrzySecmu02BgcEe47E9WBNYztWz8h?=
 =?us-ascii?Q?JTGzFMa/p1GOJPU/4BFE3uYd40nYjUTX9gV+jBXyP85ypGsiOnBKdx3P/eDK?=
 =?us-ascii?Q?nd/jUNC7KWPxGhJHkntuZou+awUqX9g5cI6rPkwPOdDCLHgLUke+NIQZ0Kpd?=
 =?us-ascii?Q?Yo/OVoabN8xPG2lBOvE1dmCz7WpFg37yQjAZ5YD/xI/2xBfAlpmxo4CzK5wp?=
 =?us-ascii?Q?Aer+oJd3Q7jgO5ifGFw1ZPxZ48HKR4d0OFNbWgBn7pXUtZvoorSjZnyeNJza?=
 =?us-ascii?Q?VJIAev49IzjjDnsFM2TGq2oHBcJ7wVfZtTdiMPaW8rAHQqI7NXM82noQOnKY?=
 =?us-ascii?Q?7qm3BCbb2/9CrA8I8/N/Lqe3r6Vw2g5+xEMoxSJuRUdXYYhADvkfswchUFei?=
 =?us-ascii?Q?P8TQjHRH2IC18UbzGb03UdYHkfWTxFpH9MMXBkHA7OmapDacCFYO+qCp44/u?=
 =?us-ascii?Q?A7awS21xu2trJD4tTLZdNXtI0SmL73EOfdgi+lBkGp4eUzMEtayNjqqSMvg6?=
 =?us-ascii?Q?PIbWxNIwMfrMdlEggnuH0+H8lq8D1z6rXde/zF4iPWVb80wROoQvY9qNhLjg?=
 =?us-ascii?Q?VvsGsCh/NPGxlfq3hX+kkTZ1Sc2THSF3x6Ofm2A9HJeil8PJLEg8MG5MZ8xR?=
 =?us-ascii?Q?S8R2iPdFOD9ndzDieJY3gbzUPjxlWiiYu4ui+8zjBzg3mMjGjrHLKZAmlNq+?=
 =?us-ascii?Q?L9rZ1tXRxnE8XI3KZSGFY6gS3Xs+iXrU15WOv0iegUsaCgPGQAJYR8r0Ev6U?=
 =?us-ascii?Q?TvzR1qzKe8qVxyt9My18VeP3sXgMtUN4yrUkXy3FPYuyzoLsDjgwGd58dZfa?=
 =?us-ascii?Q?ySDlkOCHvR0cZArcvRmhcKEAGUyZHeg0BMJCCJ1qSM0g3t1VqLMb1mwIijV9?=
 =?us-ascii?Q?Nd1W5PrLw5zideP6H7ewEAPHCJs8SWj4maV9CQjo7Np2AYyyrHUPhlDc3RAo?=
 =?us-ascii?Q?8bmVT4YHZFkXlcBuFtcpSHt2/+/k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TuyK6dKxHLGiHBQRT/PO9mWewTEFV8WLTVbieu5xdU+E+z2Rdg1bKLVuZfWc?=
 =?us-ascii?Q?nVjmMz50k3REua6pvU1PrVoi3ho5LIZ2b03VFHPVMmhAUc3k3K0WalqGRt51?=
 =?us-ascii?Q?iR5z13eMtGAQ5TUAPfOLsca8XLRGQTW5FK2LY/HJoKKTP4wOnKHHzvpEAa7e?=
 =?us-ascii?Q?6Rt8mRmn/r3ObzNvLxD3d0b+Vzolb3RQzMdl+a27AuKEPui/c4vGGHgu7JOi?=
 =?us-ascii?Q?ZyKs8TIu7caJ6vZ95etOcXW05PvAIRN0KHHsUXlNLRme/BYvolNSkf9SAWxR?=
 =?us-ascii?Q?n21reGc4ISz5ST0t6iTs68LFYDFJqO03AnP/p2Xx/NRC9PpctqLwcHWPJosl?=
 =?us-ascii?Q?rAzm42OCaCwe3zYC1QBjnxzi4WYFPYTHf15mGquhpnxofxOQr2xuvNk0Iv65?=
 =?us-ascii?Q?uTCvDRj3gHlCxMvYiu0H14cZ8+y/YhcN82h024qCWf/aQY+mkBe5VFyq/g8I?=
 =?us-ascii?Q?jXaH/GjM1SpHnC5AiHad7GiqgygTFO6LtgbfP0C8qJaAdjFCJZAwlkbRrvXv?=
 =?us-ascii?Q?1gTU4WD0irXCzd6wn54PbnSeggLFop+VeX8khgTcvlI8NaRQxEE9Vm1F84U1?=
 =?us-ascii?Q?CtOzwwKH2jF0IhBZyexE+P7ll23ZBt/qbRSphOXqbcaKEGa2HB1a/RKPYCxw?=
 =?us-ascii?Q?3q13Drgt3bjspYNcdpy4hMHYv4FHhjNPwvMqOVslwEGDfxeeaCcbMnMNLCFt?=
 =?us-ascii?Q?1yyL9JLiYMk3CKcHxiKGEzLWfpmsOk/2vCGoUGc3eEkE4mNqTLUUagQNB3HO?=
 =?us-ascii?Q?g+d6uIjsXDObgndPgWvpNHPFDNy+ose9lQPPwJSEtk1T+rJvhr9q4Lw1OdIk?=
 =?us-ascii?Q?8OAYZHHDRlH6b6SdSJnEGUtEMcetEVl4mSHzyixrqnETlI6JKkilhRTdU2hL?=
 =?us-ascii?Q?Gt8qtusIlgTL3nSp8THRSLjeX0hGRf6/bybgpI2VMbt6n6U403WA4TZlNU+H?=
 =?us-ascii?Q?AfPM0qvARw4N0aZWMosZ6VGm6FYHc3d8PbQhOHBLTSdVpolAK2/HKp04gwgj?=
 =?us-ascii?Q?MgCE5RXsBNG6AxeTZwK2xPq7as8I6CBmIta6n2xH+e93sys6lJV37qiH8RXB?=
 =?us-ascii?Q?sYqeGyjhdAELHW7dEFSvTVRcvas+Wt390thLNBzCxV56yhugM90lfl1Z40vU?=
 =?us-ascii?Q?rOCZZUSIzvRqzbBR++BD0/hDVJR3gU9Cm5G89MgKfrnKQS0gkwejvAB4y0U4?=
 =?us-ascii?Q?TfC8xGczoU2kBUO+vfSebYdUJpFUTGNfZ2X3brXrch6GKAfcw3kP09c7rIwH?=
 =?us-ascii?Q?2Bagmd20IbImeeckDOt2fmPKs04u9e4IncdrN+XCbE6EBZIQLrkLagSB56ci?=
 =?us-ascii?Q?5Z630l9DHGK1Oq+KQZo77sOiiXpE9N6fDYwzgBdNm+FaTly9AVWQHlsC4/vT?=
 =?us-ascii?Q?S6Vl3N5KCLasUFkfJY/znlmUEzM6j34MMg7RTSpATEAynx4tdps76XZGzMuj?=
 =?us-ascii?Q?H3LbCMErB0iLh7rNLo469WOXA7fDS7zpCxRRjF1ZcHUo06ldRtzH343gilY9?=
 =?us-ascii?Q?pQY2Lz8OaGPFJpt/gek/6iHzRB51LC0+XtQQnOaKEMsvdkSORwTxA3ezW5zZ?=
 =?us-ascii?Q?moH7E22kkVf9Z4lfJueS13LJnisHGoQ37WBHYYo23dAivnhRM3p8mUP1uMzl?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RYS60jSQ1BRC1+a3bxZzwdlpxgQkCzCwEoJv5XwwvphFet9yABj1e6ClJk82vG/ZlWI26Z9M3x8h4hyIhV6ASbho6l3eu4TNW941AKowWPRz6ZzANUHg6iP1miHV7XkVpg+57dkMLnowtBvbPdf7vLmT1ZlwHAt7QyOe3AopcbHqJM4ENu27C4MHS4bzSlC1HFcPojti1B5OBfjuq+iEbefpoLoeP7LGHWTich5kLSlVyBJUzQ1D5ReW0wWiGXxosQmObUrCw50AOgfj9bIFdxm94v2kW7fQXOyMmtbZPVPaYtkVOUAbHq/+RuY1o97JCnRhdRe9uGnLA5lU33JfLQ7lLHZaHyAWXkBhDRwrD4wyZmre3nG+RPWDqWBHWhMMi2Eb2zjnYYNG1Y/FwTdsjnPwh4UwRi/zvpdbkaIzSC7jQHLY/36pJuq24gjEuQdzh/X/cTdsbVRl0rkXEW+GIFP0dfugyL1klZ65nt8fueHe+aQ79QYCzTIbq4v2YFuN4GUtRbgGtpGmktpaNUxfmRDVTrem28xRh0TMqlgW0JxvOBfgOVNw5x/Uu36QxmXgPCSFS/gkp129qwsZMVdVg7UrzQNukzNYf78wG9wAy/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daadc72e-5f29-4cb4-cf02-08dd5a7681e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:59.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mV7VKRLLEB+uqa/WJLBRHdkMdcT1z5jxu1w9JWtQyxV2CJ3TS9g7RZnO5TblYYJ1vnVFSLO3m/MiXx/uwVwfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-GUID: 8IgxhTLfCVgz79hbldXrwY3FUVhYS3YL
X-Proofpoint-ORIG-GUID: 8IgxhTLfCVgz79hbldXrwY3FUVhYS3YL

In cases of an atomic write occurs for misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regular DIO writes are handled.

For normal HW-based mode, when the range which we are atomic writing to
covers a shared data extent, try to allocate a new CoW fork. However, if
we find that what we allocated does not meet atomic write requirements
in terms of length and alignment, then fallback on the CoW-based mode
for the atomic write.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 137 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h |   1 +
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2e9230fa1140..2228330deebe 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -795,6 +795,23 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_valid_for_atomic_write(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	/* Misaligned start block wrt size */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/* Discontiguous or mixed extents */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -809,10 +826,13 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
+	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
 	int			nimaps = 1, error = 0;
 	unsigned int		reflink_flags = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -871,13 +891,37 @@ xfs_direct_write_iomap_begin(
 				&lockmode, reflink_flags);
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if (atomic_hw &&
+			    !xfs_bmap_valid_for_atomic_write(&cmap,
+					offset_fsb, end_fsb)) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (atomic_hw) {
+		error = -EAGAIN;
+		/*
+		 * Use CoW method for when we need to alloc > 1 block,
+		 * otherwise we might allocate less than what we need here and
+		 * have multiple mappings.
+		*/
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_valid_for_atomic_write(&imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
@@ -965,6 +1009,95 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_atomic_write_sw_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_bmbt_irec	imap, cmap;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	int			nimaps = 1, error;
+	bool			shared = false;
+	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u64			seq;
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_has_reflink(mp))
+		return -EINVAL;
+
+	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	if (error)
+		return error;
+
+	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
+			&nimaps, 0);
+	if (error)
+		goto out_unlock;
+
+	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+			&lockmode, XFS_REFLINK_CONVERT |
+			XFS_REFLINK_ATOMIC_SW);
+	/*
+	 * Don't check @shared. For atomic writes, we should error when
+	 * we don't get a COW mapping
+	 */
+	if (error)
+		goto out_unlock;
+
+	end_fsb = imap.br_startoff + imap.br_blockcount;
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	if (imap.br_startblock != HOLESTARTBLOCK) {
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		if (error)
+			goto out_unlock;
+	}
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, lockmode);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	if (lockmode)
+		xfs_iunlock(ip, lockmode);
+	return error;
+}
+
+static int
+xfs_atomic_write_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (flags & IOMAP_ATOMIC_SW)
+		return xfs_atomic_write_sw_iomap_begin(inode, offset, length,
+				flags, iomap, srcmap);
+
+	ASSERT(flags & IOMAP_ATOMIC_HW);
+	return xfs_direct_write_iomap_begin(inode, offset, length, flags,
+			iomap, srcmap);
+}
+
+const struct iomap_ops xfs_atomic_write_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 8347268af727..b7fbbc909943 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -53,5 +53,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
-- 
2.31.1


