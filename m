Return-Path: <linux-fsdevel+bounces-55272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389CB09267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87DA4E655A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272E2FE364;
	Thu, 17 Jul 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cn74VHv6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bkQJNV6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC2FE32C;
	Thu, 17 Jul 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771450; cv=fail; b=BLsj/4dFYNdIa2OIorutGGUrzkiTn4AnktD392XEL0ezasuS/spKAOpjA4K76sP/895CDqKkaFRBbZO6YwQTyiL4tW//LVJ2Ok234FvEnyxkNFI16gGlV9n6XxM/RWSQPniev/LTo74cyqgJOEFpeVsiQbaTEwwJi3LzAgmbHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771450; c=relaxed/simple;
	bh=McCBi+VvqX1Zxj5L7eEFT8ZX1KapoxNJK1jIiEzqvwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtB9uCBkdcEMZmOBjBbkgwNyV/TLnx4QUQjXRP9sdD1OnhBrdao3pWknCw8fnVpmCCyqVjwbXJNDtYYdyCRrHYsnbXmKhu7+RswMCLrs5hhJRr00Vp6WkCzhDjZzei8/dzcjF+aI5vKMTTBc5NnPM2AMWgs6+LqN17PehXK7F0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cn74VHv6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bkQJNV6H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGBxpl019289;
	Thu, 17 Jul 2025 16:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kQsSArn56jCkB+0sWd16+BoPi7MhkHz9kw0i1cLUxeE=; b=
	cn74VHv6BcU2LRygTYXaCwOqY3Kbpl1HYRZAGcAm25E4QyYfo2ToQdKv1SBnOswu
	Ms4ipzKIp+9YoUjYiByzdaHuq+BNnPyboTZHneVO22OnwtADpEssvGULU3wU/xXg
	SpnXEHJbHgHgFtPpGRiv6F3v2OKAeFzY64PY52RwHXLHb6BX0gjSb5z0aT6zj33y
	gBkwUAkAgC0o0kGVObQgMT3iabQ7Duz8zQ1SDa0xuh49YHrFdET+XMUv1aw5vwHQ
	s8aJYRu/w2dOHgjrJfSsUoeu/tUAltc8zdyKtp0S5FXZCibEXnh9x9mnXs8Ms+6w
	Mb6X60NkOBZ6dN6VPfSzhw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3kak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFvfDP029665;
	Thu, 17 Jul 2025 16:56:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cxe7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NddIKeF2tcl0O173/E4f/Ylc1+kM+jPmDhm7fQg2xzohMpI2bekJJCjyGuHUnWNWD1DKRewoApoUlm1c40L/uZtj9GXdExrU9cb2Eo8vS0o5eHENwLVGfNa0Z5AlWz8e00IzsEqc5EumxjPoBwzPsniSfzAi+uTmJh8HGdgLwCYDXAkID8qaOXEXymClVNyUQX34/cNIZA8i5ZuMzgTeVTlJcYI8grGwYS/jlGo9jhG29Gm0wdfwHI65ISCrf55inCQ1QBiFyoqDnXPAuXL9f81ZBYXRGelAci6JfSWuRV7VYtV1mZTZQoj34TEQntPVtVeKy/RrmUNF8a7opgtUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQsSArn56jCkB+0sWd16+BoPi7MhkHz9kw0i1cLUxeE=;
 b=VnKF6yAj97LwyhR8uA1EXarss2XzShhBy3Te/haTQoJ1MPB8IN4QFVwBvq93p890Qazw1yCjCU4HCE+xoQj0hx29v9DQ1mUbioA5pPyKT+HV7aRS2lpt28CDrhquUGXhwq7pXohhrPR8AezQ9zNIaWFErsiUcUvSjTFlWxyaR+0o7Xv7ZunToE9+1K5pLSzHxMQgq0SD2sgTr0FbsFVLGaob+grWTCVXY7HcM3+KIET7ehO63vLJVT3sw4cZj+vgMIfdEppwQ1JGeHywEvK+yGgUuQMG9b/PZcYyO8+YUBzKaHalhtB8luRadr0pbpp71phxw1Dig/oYW0XaHyyouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQsSArn56jCkB+0sWd16+BoPi7MhkHz9kw0i1cLUxeE=;
 b=bkQJNV6H6Sei3Z4c14bC81kDv4xE/igPbuX0ZoUJ+P6kVZrYqa3aBzsx5zwwXP6of8jyLfvFCDaSDyBRqXURabnF3IhVNcYpAJOxyq4kGuHLgqOrx5FsNQ1KoZ68QCWr37fsVTd2H3H6fvcPgPrWp2NARRxFrY+WGNRnvfv9+3E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 05/10] mm/mremap: use an explicit uffd failure path for mremap
Date: Thu, 17 Jul 2025 17:55:55 +0100
Message-ID: <a70e8a1f7bce9f43d1431065b414e0f212297297.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cebbdf-2df5-421a-882f-08ddc552d9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWMBbQVHBtaPgqb3JYGt6EZdhe1q6+VVm/T33enO9No2LCcqfUrZRFfqqU9T?=
 =?us-ascii?Q?Ad8RB/Cfo/kLxY4PE7CqljL+udCQwrm0eFJB2uO6Aair6/TJoHB7EtKbMYAb?=
 =?us-ascii?Q?BOnZCZzSxookwG7bVpye/f8CQVWgansbDl2AewOkUyS5Ysn4nJ3xrHWcKhuU?=
 =?us-ascii?Q?c2nfBXeDRLMTWZ4HeyB6xexgVy9yvr9vEYGuuYgvDU0IvAF1cLFnXutPYYE1?=
 =?us-ascii?Q?JDhXn2FTPNJ4JH25C83HasOcviZKIdYWttQWaBKsjeFEGJUPK5Zf4yvluvAX?=
 =?us-ascii?Q?VuKdNWQEcgXExJ34pExbWJdESBRj9Uell0AzTf/Kte7ny1FM8WV2UUT5hT7q?=
 =?us-ascii?Q?3MkVTvq6CmXA/QNtDL1VpKZPvJHwcmrBEsiyMpET22gxzSeKsPpkc7LGvGDf?=
 =?us-ascii?Q?VD7yJ2GkXgG+SIZUyB3IS7xYzIbAwwSSDGYVrGb3/vPJYFHNX2ClZIth2l2n?=
 =?us-ascii?Q?IMotqYiZAkV5oZDqJEzYbzT9LNcDQZnzFC/IHxHBRBVkM4jozAU/n8GOHTmg?=
 =?us-ascii?Q?6+bp96wxLpYJ0vGd1+DOTjOFVpLIbFzmaeEObVEXtwwwGRAoY6tsvE0g/fe2?=
 =?us-ascii?Q?5cN31oKXl2wV1c4PU7Fq3qZUvTRiI2ofGFsDrFLas+Q2jZochkJw3V9SPoqo?=
 =?us-ascii?Q?NXfoytLigJG6h6bH/rQNANWtjLraNNyOoqfpoKnCI9LtdYAtUHYRlSUwfD9u?=
 =?us-ascii?Q?AhMZ0R3ZoXK6NOleUgp5yNrYAONvNUGU/hQxk3ukK8GS56SwgiGjdkZzjzAW?=
 =?us-ascii?Q?1ic6P8xtsaDymBOW9IBxCyyvSRXmfieooJuUIJ3VIThb5LOXH2Nj7F95eq+8?=
 =?us-ascii?Q?wZluquF9Hc8EDBHzEYsPFUBfOi6bh+I73TUzhL6hGG4aUo3J7woFtYNMxlV7?=
 =?us-ascii?Q?m8yibhDlnyN6OTqwMgjyM9Ec34UpkpbY25Zww2/UIHk0GbLwDsKWXuKx2bo7?=
 =?us-ascii?Q?sD9uWH2GQgk9eBB/YeFlGIBiIaNPxbcfNQnFhdYCpFdXTGmpfLbGTVB4n+3Y?=
 =?us-ascii?Q?n18PiKKJ/5MS5JPOum4/H/+hnr5Ghafc/+90hOhnzDivwR+JZ0Pujx+Op/Jd?=
 =?us-ascii?Q?c3bd2ka4RT85tka8OxmtquGOyx9+1VRL4qWVhQsT/b6tcmh4lOulnhinFJ57?=
 =?us-ascii?Q?6l8DaYygUU3pwVEPikeurs63UEnzdmQwBjC/YPb+RfwaGwiqrIN7UQ+Zr50y?=
 =?us-ascii?Q?zsH9XzNH9FFcsliXcKqcMNeg5qLme36olB5c6EzHU+elrkq+bWIye0P949z1?=
 =?us-ascii?Q?ybODJk6g7o0VB6WvDgRVDGJ0zjOGAFco6GTswtm83FlJnheYTps6oaV5Np++?=
 =?us-ascii?Q?4+SjSr2HhkLSTJ5aRKR5dkUCE4qE2XTHbi/jdza+8wEHt7EH040FrIy8ojdR?=
 =?us-ascii?Q?6T9z7u1srYxZZvTSHvFfaL9uoOVbdx3xCF8dCJanqwYYDmV9xwfwdwayPQVp?=
 =?us-ascii?Q?errkPIoF/L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6b0cK90NZdqM88C6Eg0oPlAnj24MrdntM9GJXwRx+ehGdKT9Qu9CvRMDUQ/G?=
 =?us-ascii?Q?CajAPuGgAJeP9wfa/6yJ9Amou4VKb5elhC3u1FXmLnuFxMh3ZtP940Ir4f30?=
 =?us-ascii?Q?idoMIaZyQTK9a0MroHL4UoFY3/tjPgDclbbl2WEfeBRFoHCb/bleZuaVxu6H?=
 =?us-ascii?Q?5k93M3lVZSeo4jJ3bdG4ugVEJjXpG/IBPI9W+cXPxWsNwysby+o4he8JxCjA?=
 =?us-ascii?Q?UHs42T50uX2HN4X64UTFoy/PtXDTzX0Akhl/8Efwlk/DeMCB9Hiodw30u/y5?=
 =?us-ascii?Q?cBDWIJlRB/RP7Iypwz/lvLzDSwtO8Oa53zZmc1mwQ28ftfMT65QLbcl5KTPt?=
 =?us-ascii?Q?HQSqA3tdWup9z0JrL05BYNiAdDvtleodfXnVLDJWdRyvZlvVCuERgDLl8ZK5?=
 =?us-ascii?Q?XX8QFTRPkFxMI6z3uydAGYWEvf1Rfu8FJ6zR/etAmlWWorMuBR3uhnUwNpLt?=
 =?us-ascii?Q?z6bV4Ud5pTRFBNrXfM2ziLUniEYqvjXtmVEF7a2ropKG3OKhp7Xu5dpELQJC?=
 =?us-ascii?Q?8jLTIWirmt/WjCgoczz9xx3tTDaF6Tu31Qd2UXnB/2YKiWrxZE1gVdZkJr3y?=
 =?us-ascii?Q?ghyVXLihYUGMz/hg8yt/JcHb/uRpOP8UNPmOTGHY7jBYEb3WlMGqf973YYN0?=
 =?us-ascii?Q?CBNv84PdfSgP17MMZp0du9Lqb/sxMG+ASotCf0cPFb9Fwr5zxxNm9WhDkJXX?=
 =?us-ascii?Q?MCI9WHWcHi5oypV80cGt1Jcv9Pi2FMHTS/D1iVcn7azn72niNErUqqbtSivU?=
 =?us-ascii?Q?YhkskhYRmSCO7JdCof+xcuY4lllF8PaLiP35EzUmyCvsHrbZT5utPyJQL+B+?=
 =?us-ascii?Q?Rvyaggtx9p7tcCmt1+cyj6UJEqq5qST4pOZzH4lyd+sjq0OD489vcG2yPIY+?=
 =?us-ascii?Q?doI5FNLiHJ7hqJLsiQa+2wKUgUd7Mpa2wNaGRGn9kO2R3c7pqFE+0rviMPia?=
 =?us-ascii?Q?84s2AVpOKGigdesmr6G7aQl2ko3d+6KE6ifZjT77KSVPQ7VHC/iTXrfk7khL?=
 =?us-ascii?Q?0xwZ2l8O0NliSpM+5s4YA1neP0WR34YPCn0P6hcupta7SoORODvHNtp8gVEJ?=
 =?us-ascii?Q?rG5vNgyYqHxzJV+SIRa24sS+FVjr7LjrBdbNW0qgVN0d+2DbkeoTz1Ip4tvz?=
 =?us-ascii?Q?mUmHIHkEx65/IY+V2i482LTjzyAGFCz4iEE+ckh2FQpRTSbKqD2noAdhWXQ5?=
 =?us-ascii?Q?JRctYz4AOAgUJwAAyQiFdmBVLKsqOLVF/p4bNYIOumjm8nhlBqUoBwCRD5lN?=
 =?us-ascii?Q?7ubWC7GWTN93FjrDim/WR5G2wA/zwKDu7gNtLj9PsL9Ee4Tu1i8aUSKg5c2y?=
 =?us-ascii?Q?bgmv7eqTCrOn3kdJtDElnQoDmPJm1hsm/wvUG7d7t+FPUSXqJzgaFJnQOCrk?=
 =?us-ascii?Q?5HdX7ri0D+gr0+agbIadzPgubhHxDZwdaB4p5hB7dgVz7YVQeAeTfqYiF6Hi?=
 =?us-ascii?Q?Q3xScrQSvj/VxwNx5hHwyJbgwgCRa6jXIbLg2466WNu0Fyz3JUlPiugYrx5+?=
 =?us-ascii?Q?nnFOAMlhKLOZ5tBvgB3Wb7ELaTgtAzNkcQo1uft6LmtTOduXVd6r5ZiUkXj7?=
 =?us-ascii?Q?FPFCt/0uP+4IT9hll0NTGCymi+i5ESNRBK+Jd3jLaGnIlGyq5TFt5ghfWP7G?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VWvotsu7YjFMK9iUFK4XK+hu90RWMFNGwpAFsIVxFc+8vYXNMZvS8SP5j6r7r+ffxmaCc6wfxp6KAWsy5fG13/5E2TPAHJsT4Km2vkIaHTEL9TqSJa8ehjX6rJjqjqzGs3yIpCyxkMiCyjkUHzKQ/ScqSetjI923X1ROJHhGiazx+M9LKeW9D1CISg9WfAiCj6zhn7mSnZJ7l1feZHvYeVo5/bReEzlFh08kw/neX9gVWP299BNvGO+LtoJikN0Pi7Ns9YABxD4K3Ku8Z5lOkvKaXjpwPEthimfPuSRcr19iJsFdTeRJUWLqGwYtfB7Yaxgt1/YqYN0YmeG3I1+GnOQwWNj+p6MHTGHDBETMTe0vy5Vr2JBYlPmVdhsZzd2EcijoyFh6ndw83baAo7ac0Zv+a3ITZ5418Q19RynS+7R1GusLc5hr369tIqt503qAw8XoAk1mlJ6J1QV3fjZE1K/n6uf1NBGZDBUOzq6qZamOrBMdMXiV8bmLVeyiS/gDUebRm8Z/SDnEgtGvb0PgICZ+xusNSsehR/4XdZbq1w4JSTplqw5Or67WscDqT3CwX+8WZ+SgHV1WCfjXIggrGh5T0pr0gAwsRAbB/b+Tm4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cebbdf-2df5-421a-882f-08ddc552d9b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:18.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyGMHycV/alTLWnaKq1Sl5UUvO6BqlUItHEv3YDW9qo4LXh+B/JV3OOWILHHLfiU528i3HCYeqlw0bvtx7wPl2E3DsOvlgUnLw2J04gAhVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507170149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX5HF2QzRCWkwH uIRUnbhUpUALrL6JgckrKsmS0oUYqO3v/ZIBx4f9DgpTL/1fK8P4AYU6JBHyi3EjAyirNyNlH6j aeTzUtxP+0WLUwI8CHkzqzj/nF5zyjyasT/i1GazN8WuWOyqEhR5QXFa03tZOLD4jXQlMHZAdNM
 UqdU6JLdBOa23bP8ryJbeP0tDcnuo3bGFXCU2DDsxQhwMacB4ryOjZz2XvUtqITPTuQVbmb694B 6gBSIQS1qKjoCn2y3oNx1mHdJ+DmMD2nS9UHS8XdoKu5yWL/foZ2LRcbbRt9jAQGOpIrK9Vghyf kTWp0PwaSVJH2+Z+n5tN10yGT8t2UlSVqZ7KzJT9Z2AvAro/TUvOvzLp2kfA8NE69G1Zgte78An
 +wg6m/o8kMYZiiKtdtIaWYfvjOX/hsnsQfVSHKgaWVQr3BwDYKorw38DMuKFdNXDQFuMEnE2
X-Proofpoint-GUID: rCheRdin7uny2tczm2K7rFgjxva_WsO2
X-Proofpoint-ORIG-GUID: rCheRdin7uny2tczm2K7rFgjxva_WsO2
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68792b38 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bndKLP8RKODzzNnHxwIA:9

Right now it appears that the code is relying upon the returned
destination address having bits outside PAGE_MASK to indicate whether an
error value is specified, and decrementing the increased refcount on the
uffd ctx if so.

This is not a safe means of determining an error value, so instead, be
specific.  It makes far more sense to do so in a dedicated error path, so
add mremap_userfaultfd_fail() for this purpose and use this when an error
arises.

A vm_userfaultfd_ctx is not established until we are at the point where
mremap_userfaultfd_prep() is invoked in copy_vma_and_data(), so this is a
no-op until this happens.

That is - uffd remap notification only occurs if the VMA is actually moved
- at which point a UFFD_EVENT_REMAP event is raised.

No errors can occur after this point currently, though it's certainly not
guaranteed this will always remain the case, and we mustn't rely on this.

However, the reason for needing to handle this case is that, when an error
arises on a VMA move at the point of adjusting page tables, we revert this
operation, and propagate the error.

At this point, it is not correct to raise a uffd remap event, and we must
handle it.

This refactoring makes it abundantly clear what we are doing.

We assume vrm->new_addr is always valid, which a prior change made the
case even for mremap() invocations which don't move the VMA, however given
no uffd context would be set up in this case it's immaterial to this
change anyway.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/userfaultfd.c              | 15 ++++++++++-----
 include/linux/userfaultfd_k.h |  5 +++++
 mm/mremap.c                   | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2a644aa1a510..54c6cc7fe9c6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -750,11 +750,6 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	if (!ctx)
 		return;
 
-	if (to & ~PAGE_MASK) {
-		userfaultfd_ctx_put(ctx);
-		return;
-	}
-
 	msg_init(&ewq.msg);
 
 	ewq.msg.event = UFFD_EVENT_REMAP;
@@ -765,6 +760,16 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	userfaultfd_event_wait_completion(ctx, &ewq);
 }
 
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
+{
+	struct userfaultfd_ctx *ctx = vm_ctx->ctx;
+
+	if (!ctx)
+		return;
+
+	userfaultfd_ctx_put(ctx);
+}
+
 bool userfaultfd_remove(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index df85330bcfa6..c0e716aec26a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -259,6 +259,7 @@ extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 extern void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *,
 					unsigned long from, unsigned long to,
 					unsigned long len);
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *);
 
 extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
@@ -371,6 +372,10 @@ static inline void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *ctx,
 {
 }
 
+static inline void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *ctx)
+{
+}
+
 static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 				      unsigned long start,
 				      unsigned long end)
diff --git a/mm/mremap.c b/mm/mremap.c
index 53447761e55d..db7e773d0884 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1729,12 +1729,17 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
 
+	/* Regardless of success/failure, we always notify of any unmaps. */
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
@@ -1742,6 +1747,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long res;
+	bool failed;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1763,13 +1769,15 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
+	failed = IS_ERR_VALUE(res);
+
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
-	notify_uffd(vrm, res);
+	notify_uffd(vrm, failed);
 	return res;
 }
 
-- 
2.50.1


