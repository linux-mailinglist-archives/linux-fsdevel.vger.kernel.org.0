Return-Path: <linux-fsdevel+bounces-33013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21B9B15E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FA4B2209B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BD1C1AC8;
	Sat, 26 Oct 2024 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FKjxNgI0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rb3ZBBtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837B1925B2;
	Sat, 26 Oct 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927541; cv=fail; b=R82+Mmvno32+KmfB+Qel/gKmLCqI3B86cH/BgNGY5guzhdmbbvbQQVYuHSDns5b1ZDn8wPCv0GRh4lN+yCkdvBEY/VKflyxQnxbu4/qHejQPfPmQ0ZbFUX8kTgeSsBxrOkXMbJfhoAivMsdpwUR1CXQGOmLkgcHScSy4fVYC50s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927541; c=relaxed/simple;
	bh=kGXVtdaQIb521qU3APu1XFO+uq3Q/fUT3w4fjLT70e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+oiib80ihL/yepYmQwWMJTouJqXcPxzBABwQVcOl/qPVIeF3rrdNS8CQ76o1s9LaA3yCEm/CIQ/4BPfI/GZV40nnx7ryZ57iGxEKI+nvvFV8z1aBtqs6sRnCvzZbJ2JZb+07UMsrrf4bLSMOl++niIXv2aalV1arffqv27SqQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FKjxNgI0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rb3ZBBtg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4CPtA019896;
	Sat, 26 Oct 2024 07:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=; b=
	FKjxNgI0jpufHS7K0sdlNOuPC+tXa37xtdLgGhxvYQD6elrrSrq0iXrFNn7fUpES
	S/FvXQSfrgOsr7kEUYxnv1I+B1sfuqCfZoc1hrNP7Rcq9I6pHz0yCMwkRkvrr3u6
	C3rJTv8FmtnBRAj5ppS7e7kXv2ttLTUklXUgEeJdDFisdzdtx2suC37KqkVqCnsu
	sc5fBjUqUc4EcJVSHI25zEJOQ+b4XcyHwPlmrsitDVqqRl2juAbys/WPF9uTr62T
	ApYPZ7MG7p0nMcAO5s+gKNr+ZQ70th/yF1dEV0dgJ+8avBHEZLxhVeRnaz6/YwxE
	caDK6lgRX6LirL4QYJBHHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgw84md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q71Gbd016456;
	Sat, 26 Oct 2024 07:25:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv44vtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHEECgoInfWP09Qa6wRPpev3IO2Q+D9VAB4nPnFaKM9QL5Lcd4QQIArVQvnCpYhy25ohSDRMyyW6e4bMUtp59MlXaet7TR8oo0R5SosWfvKlUwDo6zLHiZjfzFovqXpLUk5Q2lteKcEpJUqAwg/TpDjtS24D2WX8+dAchLEXawnQQeY93qrdsmiUSqTP2orCByFj3q8X84KqS8j/o9cvhYrFs5BIvx1GKK3d7gF/Sg2I1Pc7pW3Vda9GyNzwvoA9lPv1vyZyxFUd82fwgR9DP1nTtIndCmRCYL7l3ymc/4A4D6RKF9H8yToJzkksP6NIqeJyxruwtYwAdYV7j7gK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=;
 b=X8c0MolUxsGy0+tNJXh5DBLzi0QIeNkqDABZ7GxOHPtKOgHnsvHllchqg/yVAOI9sYxdI+Zs8TyxLpPAjWyQh/OALgXEydbB2SFGoVsdnvkvtJ5mNHYfS/R2hOcQ7hZkQz9DVnOg/i5qLeKnH6gjgTV0RUsgAaMGaAUfyGDWHgZbMKjcoKOLQq6+rb11VksxfnMLPLLoP7fC6hzO9NBUXFQZf0qeK/3YOa4q4jftnmri8C6JBQEIxjnIqPLrT4PyB9//b4QtOKIiCiL865lzmyyqvC44BFvUDfbHWi8jPTjlEt1J+M5J4NCp3DKkcO/zJZmYqRUj6VJAGkoSibXBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//aIKsfakC4UDo1gdtqhmI6TrmfLl1HZuQqSyReu2Fg=;
 b=rb3ZBBtgd6llz+TWLplmkYOYmrzqoU6zaVu1VV1t32phWPVPHbACeqen8+IZlf3L3F0jPv/pL8n7pJbGMkwZD3otu+lQ4nkO3eYTuEYVpN8gqjmy3Mc7LRdB8zbU4HTqekkQmRglpsrXhT7ylEgjQSt31UWJrgd4nLU8psSEbWk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:19 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 4/5] selftests: pidfd: add pidfd.h UAPI wrapper
Date: Sat, 26 Oct 2024 08:25:00 +0100
Message-ID: <185b546439c29e9c36272462768af014a262985a.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d26bbb-28f9-4e84-126c-08dcf58f58b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Am2cCXO6PfuZ7ExJlpXoaxYpeAtgIA5DfV2Cn8Fmy/ia53WY/82hMq1nWrsu?=
 =?us-ascii?Q?pqwSqVnGWPRjHLeaHQgXrpi6y/PEAwjV/zOzoh+SgeOiejuAgT10hrTBNfC5?=
 =?us-ascii?Q?pk5rewGCn/JFaAV3hni4jTOiozLIA2isTU+9dNCLkmPv7YqGC+CZWxdSyOf7?=
 =?us-ascii?Q?dLzS0ic+twJgLhvzUYhxMQa9/F+sHZwSye/zToFxw9bbO+2Lk4n/WqHRGVGR?=
 =?us-ascii?Q?Fhihlv+IEbbX+Zs7AehKerQ7RD66hn40XE5SG5iKeSLIiJrikyTOLqgpx8tm?=
 =?us-ascii?Q?GeLuTlHzpZJAESqm7ZlOp6CD0wIEBDJADM44+8x+pN8AN8muWwvqOITmvMvi?=
 =?us-ascii?Q?M5wPD1P883cP8NmJ2QqoTL8mnVOszWpjzUuPvVi+U5JGwQ7GIoOeS4UPBIe6?=
 =?us-ascii?Q?0Sa94U5yYUKpOoX/hkx+zDNqtSQK31llc1js6YPcjarpA1VNE0NyhGH+Go80?=
 =?us-ascii?Q?g9v1wYHhdJ002OJyDMDf3IbCqVnxz3hJIPG6njTzFe2DtIDh9/+535waba+p?=
 =?us-ascii?Q?65skN+xCxc4wDIhMD5C70RqbGaC8D41JjY8RNAl/YoRsgaY3mqjzx61crUb1?=
 =?us-ascii?Q?g/BF9CXYDg04TkCSMXumCQhg2c0U3MGD/8qECwfvsSSGGgJl6xC8WWiil1Pe?=
 =?us-ascii?Q?2YOGYKL/wlUUWlJyAELvQn4fcI7393SohcNuIcnvkqynwzL9JzcTArY6p77d?=
 =?us-ascii?Q?pJt6RSRRgx1fhJ6X0QDPWxP68LYqebHZfNSrqBWZe4FsAR+gIm2JdOwZOt3+?=
 =?us-ascii?Q?ZSu9Z2sClAjwju3AWqpJ59VIR4RQV3WpBLsTxOG1nGqPFfsvUmQGrcTdhjh6?=
 =?us-ascii?Q?E3r8CbClQ/AH+dpBaBvRS2N1/lZD8YK4EVEmF3sGWE85Pa2Ed+7+kMndvFGB?=
 =?us-ascii?Q?UeqrNS4MX7yGt+xz7NX3N9qwsrwZq/YljHUTA/53Z0Nmq/lX8p5Eys3By4aw?=
 =?us-ascii?Q?/ivSTsUru/kihMKjKYUD+nIcsvwuspcYrH7mZjQWwxao6Rq8W+pHgLNAXmf2?=
 =?us-ascii?Q?pOg/AM7bYjHAa+W9uP14Ddy6Xgdv8dQ9qojtYcnwpnPeYjz7bF7C2SxRARy9?=
 =?us-ascii?Q?06GwQnc+i+/QH/uwK+LjbrE4q1r2UHQD7+R//n4E59FOwBbRDBhdw9Vu94Qb?=
 =?us-ascii?Q?RAe0PWGTcPWBbIQGo2bewGWINJjnsw9STNPqdu9ilXLxzodleOH2/Akt6ZB3?=
 =?us-ascii?Q?084PC/DNWndJHFAPFUTWLOpF/Dc9Tu/nio2HzMOc1OWWL4VVgvYJAvmJ85vs?=
 =?us-ascii?Q?2rgnew4IRotpPXwAxs4EZYAx8un5Iax7T/Ga9BBeECiSSt3JbxKVc5sEuk3y?=
 =?us-ascii?Q?8/9TzmPKjEUeJL7NJ7s+wM8m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aw8tl1A8/mOq/6H8o1T9AdRHiuZxU0fBPIR+98nBHKQUrIts6UZPuy6M/t/l?=
 =?us-ascii?Q?u8LbVB290I6rTABLVuLmbPIQyISjk5Ux9J61lneZofTdlYIy63VJb8eVIUEP?=
 =?us-ascii?Q?9necLtrKYZwkWf55k56sG6q10LIMifIo836Tw99JCtUjmAPYydU3m/q+r8tQ?=
 =?us-ascii?Q?SaAqSmLP3HIaQi94TAoZdA0R44huLMBVBuvmOUYsLpO3RErzCmXFgGCE5rC2?=
 =?us-ascii?Q?sqGeUCfxT8G7AC2GtCGjuTVmE+gaxquk9UMuTqnyH2yJO9Dr4jnemUmUEqTw?=
 =?us-ascii?Q?nzZPaXS86v218CTYrESbObzOmp4+TtwO876IZyM3YT0kqnrRSnk2zEebpXRw?=
 =?us-ascii?Q?+eFhjV5kVTLm+5UlMfRZXa5dSRODtvdsncnSd3TGoC2W8DBIdEpAcYqwVxmZ?=
 =?us-ascii?Q?aZuK66oOMZc+0lkWHtNDjEJwOf6YCDcmJa5QHVgDRjQMIRlcO6pvVeA6ZUOX?=
 =?us-ascii?Q?gkXI7I1/kVyfikbJpTIEC+1uxB50Fy6ehO1AxnEyJXgWHK3jM8Wm73bpcGAz?=
 =?us-ascii?Q?OuDbuMamJAtEjzGnpBQPHDkFkh6cPbnT6RsowccR3vdwXNTtBV3EFfCbtO9i?=
 =?us-ascii?Q?0lQ4TGOVDWgX8K3yMzwYzkraGOHgv1Yw0uiM8sLq3cY6j+XzU2z04GOo8zh8?=
 =?us-ascii?Q?tSKvguWFoU1WAfWYvi0kxGvVZYK6NCqPjU6kepp+Dn8nt/uLo+c6a1dX2BqL?=
 =?us-ascii?Q?DKSk0TRXMof6jbdmRhx7TVjtfHbKLYjguCec9W/xcVIg0N1CTrTnaYTy890g?=
 =?us-ascii?Q?W4J0L9E6qaqI9J0GXSTiv39CZm/eaFtptVme2a31tKXLHRkE6KYaS1c+mkcD?=
 =?us-ascii?Q?t7ToZqwCo1N8Fbdtbpejv0xwpac+/BOegcsrl7QMq0XzrqYk7F+UQqVs9rQ5?=
 =?us-ascii?Q?b3wPcOjDCTgKu3rR8ICQDWF2D/xKwiNChBof5GJtkCNa4hkMj5Fd2Qd7EnSP?=
 =?us-ascii?Q?P0rWRTbZ30lQ+2WzmA/CukRWfKVdRDTmnxZd6d6f461MByAwh6x2QHWHFhB9?=
 =?us-ascii?Q?CYy+Mk1hp1IWLW7MkHOY+qC95Fdwh5g8R/UkbzBRNb/puZi+qovY7B7YbXAC?=
 =?us-ascii?Q?OTEkJhIHFWPAGZf1IC7GRft3jAQ7xNpKavJpu9EVLw9/kd06f8pYhbb6Rx0H?=
 =?us-ascii?Q?YPdZ2kO03TmPcyhTZUvdFRwUD0e2bqLXVcgH83sTj2sQBm7/6KdFdvQYefLo?=
 =?us-ascii?Q?b12e/nPDpj6wtkO/Ty+LZGkOR582GLSMQoaak9Eb0gLC/DYXNR7+4noobUrI?=
 =?us-ascii?Q?r9VIC5Snn7gn12IEs0dv27IRHXhAQHWswOFYMAp6ohaZVAYCPgGLCcg9J08N?=
 =?us-ascii?Q?lMY7IMP65dt6sSFkEM5ywRyHJ6/+g3dj1F1ydQbfZzIEu+iLU9fEL46me8+3?=
 =?us-ascii?Q?zfN2y/OHZHow+uJOS+NmtHfQIhOhFcVleQ72fVdt8scmkoJlYjXSkuIyCjKx?=
 =?us-ascii?Q?Wy4/qDBnq21BZY7l3D3kzoIPVxR1RxkDzWtk5tPsvb26wj+Y0b1J/CeqdSBg?=
 =?us-ascii?Q?z95BeRsVEu5ruWP3+LNRkzfBDNy+81mObJd/QX8BOFpWf+Odlb7eZWlVdrxD?=
 =?us-ascii?Q?PfSW32weIVvVtPJa5BzuO2vMLDPyHjerQXaoxzxqz0VeMx0ER+UuVfKx1+es?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpCkyleklZU5WYV/Q+RZB/FUXQR+JMWnXSbbF2oN0A8XHNZpd5uLm1WxRRzuLODRSihElNDbW/O2/4oIukTBT9sl8U2wWRYGM9li6mlYPtDG94FeEUGhK1PI/xqJeoErfObbDWng1QgMSCpyLFWMOXzGxe/gsQZLWuEiI5s/UB/bNqOi35ld2aKM0T13+fs6u6molsGt0dRJyq2/CVK3y0RrqGcjYGS3WIQYB2VDoMXFhyDvqgX3ERR2wqPfj4E8lABt8+ClNXsbsO7emaIWvkP1lHKH010xTdMxNtW+qkxFVVo3ENnJ+A7pzmbUsq+aRsS1cSJ9CoNd1B7/dJcGLOFwLD9wXRSLqMpANtrQSqC4Fyq2vM482b/1qWY+kcU5g+av3ZmTCJQnusF2Ko5jPUWW9KeZB9M8TXXNQP+LM7N1KyIIgxmbZtVrqbTbxUnv+JnlE8iq1a8nOshdFRXkSrUVkqj6qvBT2d72ZU8FJZWMxi8/SxX7gn/TiESHjffR5oY0qmpd1DJXJ5wrV8UkQER9n1upsh1KvAulI6OUQ82N0GKGZQ7648qZg0G/Y0n+K/8QsiboIbIM5EpenkcU66oxKTEydbCB4y6/QdfD3a4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d26bbb-28f9-4e84-126c-08dcf58f58b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:19.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3ruLJlrA+9xs1Vrn7L6iGYzhcHuDMqJmhkxwiwQVzJKD49dMrZT3g4Vp/mPTMIa8zYFBQYD8/5HeCOfrcNVdT9QzEjBUcJGpuzz9LISliw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260060
X-Proofpoint-ORIG-GUID: Gaq-OBWvUkuEf77HGwlNH2BC56nN9RUp
X-Proofpoint-GUID: Gaq-OBWvUkuEf77HGwlNH2BC56nN9RUp

Conflicts can arise between system fcntl.h and linux/fcntl.h, imported by
the linux/pidfd.h UAPI header.

Work around this by adding a wrapper for linux/pidfd.h to
tools/include/ which sets the linux/fcntl.h header guard ahead of
importing the pidfd.h header file.

Adjust the pidfd selftests Makefile to reference this include directory and
put it at a higher precidence than any make header installed headers to
ensure the wrapper is preferred.

This way we can directly import the UAPI header file without issue, use the
latest system header file without having to duplicate anything.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/pidfd.h            | 14 ++++++++++++++
 tools/testing/selftests/pidfd/Makefile |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h

diff --git a/tools/include/linux/pidfd.h b/tools/include/linux/pidfd.h
new file mode 100644
index 000000000000..113c8023072d
--- /dev/null
+++ b/tools/include/linux/pidfd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_PIDFD_H
+#define _TOOLS_LINUX_PIDFD_H
+
+/*
+ * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
+ * work around this by setting the header guard.
+ */
+#define _LINUX_FCNTL_H
+#include "../../../include/uapi/linux/pidfd.h"
+#undef _LINUX_FCNTL_H
+
+#endif /* _TOOLS_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index d731e3e76d5b..f5038c9dae14 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
+CFLAGS += -g -isystem $(top_srcdir)/tools/include $(KHDR_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
 
 include ../lib.mk
-
-- 
2.47.0


