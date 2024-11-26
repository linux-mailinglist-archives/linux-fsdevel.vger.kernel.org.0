Return-Path: <linux-fsdevel+bounces-35882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE39D93D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3D6B22FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F11B394E;
	Tue, 26 Nov 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="isQdYFqh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a5eJ1AP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2871B4159;
	Tue, 26 Nov 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612162; cv=fail; b=t9owv8L+QJlrLNHkdg5FZcvfzUv1UTfSot4kl20NUqV0hHqECy9V45dtZmVayXEevwF4Zzuxw4nckKZuxqo3mnaOkxi5rKHVk+aKbR7qBQa941lKd2tvwUxdnYk7axnYtOYhIaHFtrbgL6AsWTX74lbGNBOqzphkpEyEr3ofbkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612162; c=relaxed/simple;
	bh=WMMia0MccjLiJBpJt3IvjIbM37pDUSz9xz3jp7ztaHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0UzPjh80R3ROudCidLRyyjjOvZjqiVjZ3n/xUHa2FJPFf/VbmlUCahxz87ub6MyVvBpwefqShcum4JGZNVkbwrmNm8hU4xgfBKOuYZIxXnJuZlcR/Dyz62XSA05CzjPQG7Xhck0taeUFbLHo9VCmwVhpb7DIgztKGYbceezuag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=isQdYFqh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a5eJ1AP2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1Me0o006452;
	Tue, 26 Nov 2024 09:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EjVOv5qjVlXG8IKVG76FfiiNUOgUkmWh607NKzq/qhA=; b=
	isQdYFqhO2Vrr4efeoeNr+QVjoLknS92tHL+uGtRyBmrxP4YNTmJHvqic7F0dQc2
	l3D5O6URHLsrX7Gwrcxy2EmvUjK/KhiD6dYXCDm4KFw8du3+4YWzUSP1B5Dk0+MV
	lwAEXzEvPF2obf65I8B8rjBSmkS61ddPTENZEx3FWdu0Swsd+CtLi8qO4yzfFZHM
	Lus1L8p60UQMlnHAyx+4WPynAaHY3D3g4qMdGQhOTbPCtvAPGGBx4IlT8OWbyCZU
	fbwcZIZ/UszktmdDwpQO4DyQS1W5exN3JZKSPE2mIdici/pdHrvTj8RYNA8OM8oi
	o+TVVdTHdn8BT+HH0SsA0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385umyg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:09:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ7OFOs002638;
	Tue, 26 Nov 2024 09:08:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8w6au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4Yrn7YRx5gbZKuvq4c2MGYLTCXUmv/wtO1lmyBbrhQSfYfrC0NjkeEp58B9pPgwa+c5Z5la6UfKqR3PsN71PUPQcBE9nfOA+2cZNtFZrDZG03RVl0phUrbxB5p1yNWSMubshISjdLtW2/rN9MOZNIdv0yHYmCp06GRmd/JAOF0nnYw4kyJMWAS6Hw3BPZJDZaOAO92KOtgyWJ5QXwXjCeXjMIKyCHL0/0HR52RvEPFw4vbDv1lVK8Jy3Ll2XRg6vcyBKH/ICvil9Bq/nhUeivp4bWRyzDg0rhX67u4CMWMwS0w7VicvdIkahv7vMpp+Xm/YcXie8hdhV/cjg3jyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjVOv5qjVlXG8IKVG76FfiiNUOgUkmWh607NKzq/qhA=;
 b=PsthMJEydSb3npiqhJUcOMrFnx9r5GEW9MM02EfnXyMuXFb33VvUSnSBE3ae2QOVLHbmnGZ0QnlSbwoH6XvlhEFbDrw9jXR7+u2i5qetG6RoiIUJKBT4pXjm9kVgMEzXEovHFx415MOHUFn5hv8qB5x0tfTP5417kO2JAn36v0WojBXBr7Iixdq9LiqhWyA96cATj1UsZ/vks7o3hSDML/y3dxgQZRNqwi6Gs5jb+U1k662zi56Tcumj8bMEi12Wfac16Y8jB6Eu6eo+zNQUi5AY1ylA94sPq9Ej4gUJTrnV2wqu4J8/l8GxwG5BlVQSOEM0Er74piMQV07Zsx7bvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjVOv5qjVlXG8IKVG76FfiiNUOgUkmWh607NKzq/qhA=;
 b=a5eJ1AP2JtlMIW7PU4qzjJEc2YXeQeY49JS4RAkLo9dwmNbryhwN6ue8oipltXJWInDvW/gxEdBMkhv7NlzQCabBDzxp3Z1gK1Wm8Hl0rII+cP2iy4iijdvISPSPHRnmKH4CQns+sdCT8soOC2fWdcP1MJoZ+aRlycWLvebs0sA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 09:08:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:08:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, dalias@libc.org,
        brauner@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/2] io_submit.2: Document RWF_NOAPPEND flag
Date: Tue, 26 Nov 2024 09:08:47 +0000
Message-Id: <20241126090847.297371-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241126090847.297371-1-john.g.garry@oracle.com>
References: <20241126090847.297371-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 593c7ea4-292e-43c1-9ee3-08dd0df9f547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SoYWh4HCkZfTucycEIB2Pil+tavsYFhuHVkH19ZSglg6k4Ggm79uynIwkxa6?=
 =?us-ascii?Q?K9ZauFp1n9Sv5G0kBahGhuRM3g2VeorVFuQpwbbEfzaha5lQ2yD7St2eUm3I?=
 =?us-ascii?Q?sfOVCkb+W8Fp+UGAk87bQhxSgkoVyHDHSVvLuHaLCWnqdGaIH+OeIUW0CpYu?=
 =?us-ascii?Q?3bVXbr39d4mvNpU0A27Zm5m6t17EIWh3V/IR9Zpn2mAhzxYsjy/GDtPwxsu/?=
 =?us-ascii?Q?VRyZfUuWaUZL/xutPrwNa2FJVQfvMmbtb88sskla5wddgrw2K/ipOsXT+F18?=
 =?us-ascii?Q?pCrahwuwZbVbwMXi6hUrFvvyJ5YJaZnu9JoFGrYEIiHV2XjW1Oj9cpv51W9y?=
 =?us-ascii?Q?fKjnWLMk64XtYPlazX3hqlyNXfU3MPjveBcEALn0Yejsz4cIlYVoeP9d5kMo?=
 =?us-ascii?Q?6FYUwbiwF1xkQ31fswAfe68yl80WHOmPi3CYNNKzAN1Vg1ZcNHjX4ydOGiTL?=
 =?us-ascii?Q?ERxUImxK7rD8QQyqwI34c0RFQyevuPWxlzTd9ipcQcpx9u6cGaVrUH+WrSbc?=
 =?us-ascii?Q?+TeOpjRZqrOimkCwA3A1zsqbshwOcKDbdOSx/nRLbsi8N6n+2a1BVlJcZqsm?=
 =?us-ascii?Q?M/ZdovjNPm8xBEjb97UlIPecrc+MIC33YzZem3BXcBbA06I16DIuQV8YbeLW?=
 =?us-ascii?Q?Hi5klNWQ9Vwzhn1W5t73vY3oJMLvNNqvwhqG9HL36jD3AGvwV/qEtMxe02xv?=
 =?us-ascii?Q?THvluk39Ptdxp2aWpecxW1FYCGpZc90/r3NZ80RpRJa++SGrVWVK7RN+AIgl?=
 =?us-ascii?Q?+jreg25Sr/zI5N6qhyuKYNCmXdLrVsq7CD5jPBjJwAsnDqZ669T4rK9vlEtv?=
 =?us-ascii?Q?X6hgB1LByJyabEMhvy+cfjWX48SqBmD7P9dj6pjpiGn2sF0IaNxxU1g0qUaO?=
 =?us-ascii?Q?tg+raS8ePjEwyEpqaBLpziYXyp3MfcBv785gPFSwtA9eAsg1XjkhBbCMOfTx?=
 =?us-ascii?Q?+kXT09+VxFyRA9WB3U6KKaQTGgm9q5KBasI1FADPhFpX2X98pEO8+obnRk8I?=
 =?us-ascii?Q?ylBZ3Nmh8CmfAzAs0VO/prgB7B+DFg7I0x/9JJOqsPKkIPR0/k4RHLkaEmcA?=
 =?us-ascii?Q?NqQUe0TQLMkmvANi03sxw+3Ew4vY4ROvBZlTsj7Whah4E6tsrM6gcRSiUDyw?=
 =?us-ascii?Q?S7BMJ5zPbFHqQtqSEuqSekRUUaKxYMswapfQ5phYChM0dQH1TCrqISmc6/QZ?=
 =?us-ascii?Q?AB7LzMOmCiuWBZK2oCeOwENUkJqVKmkupuc8dW1FKVXF9jr6cNhNSxlC29Ux?=
 =?us-ascii?Q?Ko8y/4J2l2JDfhCic7YqqMCpwiV4ABcE3eaaW+KWxHV2PgAGQaFbJOm/q1y5?=
 =?us-ascii?Q?/dtBZm1OYQG/YvwjMW0/u9KwcK2oIY06WXn07eD1fw7tHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKJTRoeDsApW7nE5XLGdqQXADFyXkB9TeBVw2PwAZSJsg2eVINYUZEjpqGGX?=
 =?us-ascii?Q?mmycL/+45VhTH97wvCA5CLT1wfW8jD5yFQ78Y+1jyDfAs/Uf86Jj0OUcZ1NO?=
 =?us-ascii?Q?t0rvWUKj44ctQsxPDz9fAz8X+dxi4+5P/Rp2e439Kj2iu87XkMtnE2dMvIX4?=
 =?us-ascii?Q?nrsxFgyeHaC5fDBizxqnpCY165JxTTklJFsHzX9HqQHi19yOLBH6URMKU8T/?=
 =?us-ascii?Q?NCQLnpTzT2Pr7pYvKaWsfbyGV7u1CKKJ/O1BLZyxOz7Dj3TtQ+geyckJ7llN?=
 =?us-ascii?Q?5JZaEbU3BSfvdmWme47Wddk9S9i5GfrLzYa4rkEqydI8xDa1gJK2xgftoGHj?=
 =?us-ascii?Q?X5Zegj6o2LgYOhPGJ8fHP2P8A/01WomCExOzwJYRHicrZSJJaogjsMUtBEyz?=
 =?us-ascii?Q?a5tAH+VEiLKVzREnYdPTBQ0TjkA/Er6IMyKGJ5rSBfXd5km3hl+6bNakTlXl?=
 =?us-ascii?Q?wROcIM4DvGEOIhbyazLs8yXSk2a5W/5rqL6u+SeNJE4iTeLjvtxtoOZVXSW/?=
 =?us-ascii?Q?6xrQylorJqY4QBjkEmtiKGB9yyZEOcBUjaJjkxBQhEOLsLRLDOQGxmb9j9AF?=
 =?us-ascii?Q?arOqDHkEI9ZOypQ66peQS1l7gwBBOeRfeUhRGdoLxEmocME6g8rjigEQ0ZkO?=
 =?us-ascii?Q?KLKoK7a+gRTgDPQgzWyrQ2AOp6+gnlWtn7HNIPOyNMnyaBI2fK0N5crhppbK?=
 =?us-ascii?Q?0RGFhHj8tCw4uOWy1MY/zV7KrGZJAvK2kDQS+iZsUCgNQNFA8q55jnG2qTd3?=
 =?us-ascii?Q?gM3FVIJ50zvfl3PNvsfReP9Ih0ra96OcClBu7pnmLwoXsyPVN/IdbgFURg+/?=
 =?us-ascii?Q?Env7ASKjVXFTol/jDsQQoTbe0M5uexAvPukeBgufzK0ST44LgCibVzC1zopW?=
 =?us-ascii?Q?q+MesBjg8cceNkm/yVEx3oLS43cqTaN5/oev/EEn0ouvYRC3O3yREvtrAGpO?=
 =?us-ascii?Q?YFggHXrvgamGpP/THa2pND8SwWbIXIyOG1HN0vquTWqgVWV1O6G8faU0HC16?=
 =?us-ascii?Q?gQsvRzYeKvA5Cjt3Gk/P2eA56xIBWxBgpm+j5PaohdUKwwXCrdVq1yse3omF?=
 =?us-ascii?Q?H//iS8c+Ettbp59BGicix+iUMpZxl/Gh2dgElknWTPGByLSGwHWH2cUBGGrU?=
 =?us-ascii?Q?4j2IH7ns+JGw0INPixDtKUe4VY2SKVar578K8Fne34k4xdsiRxyxnrsaRDgh?=
 =?us-ascii?Q?kZ8Ur3ZG8YrxhqB8wTfqwZtHIpqzY/6LrXQ4Us34gw4WMPnbz+eEWx0C28hf?=
 =?us-ascii?Q?InXgkABKfNlEUfLAaw+7r9GB6b3/15uedqMegGKx1gfrdhhwdWVpsDCkHrqf?=
 =?us-ascii?Q?AwFYsTkJdwJaJreKSXwIcJptSaXB1+McFRQ3tusyC+RgsdCnJVlxvgEc63aA?=
 =?us-ascii?Q?bE+udqq/wV58LmYF8mHOM33JG1bkSJrSe57m7RZy2QL4CaoYwHidSdPVi/hj?=
 =?us-ascii?Q?PGOCTVXw5CqRJFpLtY5Anq8MuhR+CttjBF8RZnGCS5FyybPl4cynrr7EQTJF?=
 =?us-ascii?Q?jpflv+zklcYY8O/fmpTy0vOSBIJzy1IIUkYgUUw0Ze1SPZsqfSDVDLBxLe9x?=
 =?us-ascii?Q?fiZJqHPdNqO/1hcMzgqa2pw9cLU3m+kJLkJF+itbrrjQNlmUJWZL2iP5+4j/?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3LUM8W2WP74j8x/1GOt1Ee/IqWYM2nqe9eXF1VuJukJjSEd3/C4NleT1qoshVeaTGwPJ9Ap5cT/xt3JU3UJadSyKeWA6fiOTfIR9zp1oZ/vbgptUQ28rFf1/Z9F51NUXD5io5kRLDhCFnbdxiIqi2J9sqVvVY/hdly2221g7cETdAPSKP5/KmJDFuV9SP+DLbC16UT9bwXX22/0gUDtLzHcNX1gD2f87jSVnJDnuiSSCA9WUXSbWACYCjQqavj141uscvlKsEyX80DKSyw0+49A5UALfyc1wBoOPcfbJw8CGqnyHnE0gvHLc/X6bEJLNyl/VHvlDm7pIbsg2X6H3wusCt0brtzJjKciW/77rIxX6zbGSnoojjYoQmsBApsjTEpcMm8Z/i0uoMgshWh7YJUJzbeImifITQLcNLv3+LPiDdKkuWwnBur3GyQFmgrnsher7L2JJ4mYMdscWNNzFf5fvhrFlAOeo7WtI/SthcMpIDRuHk523Qvo78mhvUNtrIl1H+YiuG11ubGEGsuk3bB2kAgC0DMOV/sPQwnGvSSUO73QIiRbgEgOCfVczSVPVTfZENf8gGovJoiM49qRN5JPSirmeQ0lTOBfWAc0nLE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593c7ea4-292e-43c1-9ee3-08dd0df9f547
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 09:08:57.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEPUy3Ghge63N1Z9uuxlO9kJ/TEQnlhys8IxQn5tDoKat2iaLeEKZrMjL1jq2CQ4tmwjutuEPaj8bqwLTYe1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_07,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260071
X-Proofpoint-GUID: OjeMEyfS_z6INB8RkT1RwbSJTIZNa7k7
X-Proofpoint-ORIG-GUID: OjeMEyfS_z6INB8RkT1RwbSJTIZNa7k7

Document flag introduced in Linux v6.9

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/io_submit.2 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
index c3d86b4c4..64292037d 100644
--- a/man/man2/io_submit.2
+++ b/man/man2/io_submit.2
@@ -141,6 +141,16 @@ as well the description of
 in
 .BR open (2).
 .TP
+.BR RWF_NOAPPEND " (since Linux 6.9)"
+Do not honor
+.B O_APPEND
+.BR open (2)
+flag.
+See the description of
+.B RWF_NOAPPEND
+in
+.BR pwritev2 (2).
+.TP
 .BR RWF_ATOMIC " (since Linux 6.11)"
 Write a block of data such that
 a write will never be torn from power fail or similar.
-- 
2.31.1


