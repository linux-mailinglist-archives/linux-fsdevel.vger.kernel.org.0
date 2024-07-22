Return-Path: <linux-fsdevel+bounces-24062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE330938E69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E5281DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52016D4C4;
	Mon, 22 Jul 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bT04Av4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dXMqCUtc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E6916CD3B;
	Mon, 22 Jul 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649062; cv=fail; b=u5IMZlCb8Xhs7aRkB21XK9BpxgTUUM8uAjOjnHFHKOBYLkTl4yDMBzNQSj9paiSndk6a2kiw80Lj6Tn/+5LXA8MWvAQbvVn7zLBx88dCV0eIpMSZj20Lu4XT4j6gh1PNpH44+ag8Tl3AfxTyvBdakaPXuY57eUPmgE0GYzC1kkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649062; c=relaxed/simple;
	bh=9qekXl/TRMsgNAOQVcJZzJVlQfyesO58MnK8CyTGr4A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s6+mkAEYZ8Nk19gS36s31Cvs/Skt59wrpqhKRo9vCEJiIVTZwwjcV6TREqQd7odyJQNzj7TeTDoVpAsQzLh6bXKJK/dTXHncpU3cpwZFIAebWkGW6L7+ZShjP2OzS4fEN05KSNc3Rp6YMKI/GM1ZX1Z/GFyc/Yyu1BvnmGUroM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bT04Av4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dXMqCUtc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7dDud003276;
	Mon, 22 Jul 2024 11:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ZbMGJ692RthV/V
	v2fPae2rYNKc2xRn7vLEvphuTLGqU=; b=bT04Av4E2sV8UtfYKXuZAszMuEXSNR
	8UdaHLb/ZtbKWLpKHSiF80DstFiXSRKuRlxc4OsSl5pApuwPXNi/PY0W57mBgkbM
	JRFBOrHR+K2FgQfYLxw+wLvXtmLB5Quggg8x/YJpwpRCBiZBNqn62tkZ09tAZQe3
	gGRKKt2oj0I9JbjqQJEK1funrh0HjchB6JXNXbU7MrDmQVuaahFG7xEf4xM2hCw6
	/zNLyZ52eXyolnybgTCINXlOgOzo3a+I4Pn5URA5VGzs0UObQ3RzZus0rAB0noHS
	2MH/SgzZo0AlIwbDG41F/PVmtdFiIZgNKRqg2r9TxPvBSMKfOEErelRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft09j0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARU8v023756;
	Mon, 22 Jul 2024 11:50:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h267tvsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrJeqlGCFBwr19SSFvyf1hbB6Ax8rvi5Oo5NOIGDIGKjCC5RCd3KUqA5S9j6vh6EfhKXBx67q1KNKinDIzPhqkS+cweE+6cACPEVa0+E9j+P0TuT93KlI4xN/BTKOqc98HemetXec8Y7n/KX2Hq5PC/mZO7ZfqcC2yabji5/h8NHpRZmpvYak+0mB/vPNFbeQ7yUTlWVbD6ajbeNVehPdLhdaAj93s2kDio2B6NCxqd9/5oEFsfTcgm4qtYGLddj2VrPT01816+Ry0x19KazQhTNxwKcLLghRNk2WBV1LYagDa+PweGchnLOQImjHenCOtoCjFHiWZ1Nb6t+1pz82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbMGJ692RthV/Vv2fPae2rYNKc2xRn7vLEvphuTLGqU=;
 b=DjvlcoPtuH26SOXdB9e5VOBAmhnXZfX/RBUmmflD+vwMqoIBcfhDtvCkhIow+y/wZJirmDr8A9Ash3F497EHKOfWfDylyv2sIDoqOP4wnqS9nRjCgJ+f8+Sh0+tUhU3oUqZkJpiLEph1kCq4bDK0+j/cFSbrYOiyVqDW1dI06LvQ7yW/4O65l/3LxP9RXXqwGbRy8qt97JPVfcVzLfaTFIllRZ+Od7oiR9yIFsHEO4FrIXz50VoNSKoDq5tFyRlGcebWN8NhTlgs0UFetUyVBFTGxd98v0J+Cj/xLJtgfrwz9QnfA7iM4oH0paCjYPMaQnDjBCr20O+bp5PG5hW0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbMGJ692RthV/Vv2fPae2rYNKc2xRn7vLEvphuTLGqU=;
 b=dXMqCUtcm1kJ3hXnOg7B2KlLJw4W25mXxqq9d8JrTSU38K4SLQ9OeHppjxnOUlDVA84FUQxf4DFiLafrY9XqKraIVHoPAbWaZGtZGF0iIwiOSc+sT09GAU3C5ZVtnveyNN6rR+FeEQ1r9NF26KX2dWTohGhJvTgL34GgpdeuRog=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:32 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v3 0/7] Make core VMA operations internal and testable
Date: Mon, 22 Jul 2024 12:50:18 +0100
Message-ID: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f84f6f-5029-4529-9138-08dcaa447d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DWy0Ucxyrp7P+kIn3pmVWhiaJCmRa6qoPbxizFZqYc9dAjkvYtr7/BiBhgqf?=
 =?us-ascii?Q?AE5WVg53mpaWjCMUwPxWdn1nzcJg6oHfxGC6brqR+oB+Jfhtj7tD6ezonY6T?=
 =?us-ascii?Q?AdSlHscbSJA0eu1Q9ffWq+HTHSpp6bmGE6vOk5drlxeLqVHoIWFPdYYLIH5Y?=
 =?us-ascii?Q?7tTvAaUArrJ5WAUfEEzl0p7c+pVWUEulycUtoUZToQuezKYo/tjCrt4Pgua1?=
 =?us-ascii?Q?UfQtzg6Vg4z1T/3SaxrDXYrxiJLAVQ1qCFWHsvCYbOiymiOHkK6atGMTrClV?=
 =?us-ascii?Q?ypPjWJAalkS0OOCyagsG9zep34sAfH6vFMLVs2QpqdSE9CeWgrBPVyF9+Le0?=
 =?us-ascii?Q?x3TwV50dmwrXtWilI6HIUpOWu9xAE7QB2stfoEsaGy/L0Rx/GbTShDNGKHXu?=
 =?us-ascii?Q?uCfCeNFhjN23REe30y6N9FYn2AuzBhWZx/kJOCw19Xy8bU4VenF0i1EvFLvH?=
 =?us-ascii?Q?TO71uy6eoc3z0vBgeTLQaJbj13VxgSUdVAfNsZXynZ6sIfhxGS8hTbyVLNC0?=
 =?us-ascii?Q?kp20Br4jtRLYWxJ9S60f9p5/rPEoQ53M4xFebpj4dtlWsdttXRd3ecXCPtxf?=
 =?us-ascii?Q?vr4SfnKplCOOcSVhusCrIlJ46btmpkThW1piJexzmIpiwJHRE5Kdulj7x/fg?=
 =?us-ascii?Q?okYoEK53PGYDimVzfdb/3ndUo81Li529SZgiMIAHCf2CQ7E+UIgyOkcRWaqR?=
 =?us-ascii?Q?32nrUq6EdDOgyq1PB8mcIpUEXgcCgs/UaNCQ3PWiJKDiwxL0F8rQ5qxyvPY1?=
 =?us-ascii?Q?N0K3PHS8m8TQSHcdXyQpC8V9TM3Zm4WkgwhviikaXsBCkGnSOkOPRjKYyvys?=
 =?us-ascii?Q?29TGFMmhawTEoqTaANXC1Eh6CP+Xiy/flTm/dU/AxA9bfTjQ1lx4gAp2+OAf?=
 =?us-ascii?Q?QrOTRY2F7Ia+KmeZ8iRufZXz90dpnrMh+fKNmGgd32d8nn1eicYtSBKWIfLF?=
 =?us-ascii?Q?q6o4iwAQalPoqrhdn7EVALkxGhkuXH7QsveQJz0UF3LOx1MzQnSIZlNafcdo?=
 =?us-ascii?Q?crga7Pq5ykovK7+INCNx8PM8ytFUDthlpOYd0pj/DUgIGHHvkhyVRvTc6/yn?=
 =?us-ascii?Q?TL4m6/ZOP6lh2dPCYQzgBdb4yIRZJXJ6FmRIC9n2pMwD4R6Khwr+LHtlu5L5?=
 =?us-ascii?Q?yXwWce/9N+ZhuS6k67fDA2zUWZAiQEG5nlLr+lxJlrTp9zEx5+TCSwgL/GRC?=
 =?us-ascii?Q?+DqxbK/luUa5EME11RzomCkfdVyD69DU40FIgolh+UYshPmfdyiF/30BNyOc?=
 =?us-ascii?Q?QzpXRk4Ip/guXOjhsSVe7tPuuotI4pCZPPuC2h1yBUNFrcPxFAVMDda3Xzvi?=
 =?us-ascii?Q?2SdXtzcM3Lzh1zItm5OmQbxT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqT2OS2+qWisRFNGmd7KAqEL+tbupfIp6rOuc8YOaufC3kxeqiqgXcSWMevm?=
 =?us-ascii?Q?ikOIy3e3tHO9+sZDQlzmL0RiYc1NfWcL406xDx0bUetkLMXwriGOnU2HLlRT?=
 =?us-ascii?Q?fi9xdkTY5YBEIr4yebZfWddw+xFfrMcUyjRvZFy4v3o+Xu/TcnAXQlnoYSOC?=
 =?us-ascii?Q?pXgp28S2sGmbSubpL+OHFmw1evZNzkKrPEm0PF3/gyIJxEklGU+V84jf5Xll?=
 =?us-ascii?Q?UJO4r2IPuMahXEjpbuZqL8K/5B4oWbVxw+bsnCqSzqrovAEcDo1L1rd0NwH+?=
 =?us-ascii?Q?xB58G/OBlZavHzxLOgEeBPIiR9KSP9MK2NUHuly5nr8Ow+saoKsddzgQAmSk?=
 =?us-ascii?Q?5ivfbObJUwtX11Dx1mB1vHzrUyqHRY9rt+iT1e9AZ0GN2UwCe0+clgHCLr/H?=
 =?us-ascii?Q?UGaflmMYmSijmOaKlRerPWKpVWiTszomzal86kBihQKh3hEZE0axKw4zCEfK?=
 =?us-ascii?Q?o2hANdIm0G0GjSvJwyvhU4d5VgAgsv0KGRSj+LSfbCiGlHtXqv7tRp4CljET?=
 =?us-ascii?Q?8a9z7Z6I3nhYQdHxQeDWCanRVAF7pTdze2z5Nz2UK6We6HbzKSyeYhCxYewd?=
 =?us-ascii?Q?SLaGg5WdWZBXLwSOdwpwt3NXOH3omR5wNeIoBDIYPXA9a4p/SXH0WJTqx6CI?=
 =?us-ascii?Q?Kg9EtbbHwD2OmgTDjVUxhwMFKnWkAd6p6/hFwZCnFxFUmvj8+/drGGc5C01Y?=
 =?us-ascii?Q?GgsIBLkC76wxr/CogK4BNHw5aBnnF8kXSXMIlxjg9UG8pSzRrKGsVj7GLVaT?=
 =?us-ascii?Q?wq2+e8Yb0DNwNcYRQMxHvHjHI2HMFo2OxJyeV7Ew3+wCO8ap3+DScvwgzSD8?=
 =?us-ascii?Q?kTD50v1ujfnmF1JEWmyp9uqd0nG21Sk6eM1qS5GMYfFhXc6saZFJ1Fpaplf+?=
 =?us-ascii?Q?O6HiJ0rKDo0okdDHGBKavleOBDuXj5GRIjPPwvvOWWhr3S4hFHsdBaOB74tN?=
 =?us-ascii?Q?vGH/LGPKqkE6pIjc3lOj77QOpsNjUVoXkfCD94ylYHA2KqfHb5R/ECR2JMAV?=
 =?us-ascii?Q?x6UBw0vKUf+DngkBxh9zLeAlSX1FTOX162Xj9+9wz0JpfjIUCzLu0ZVWEz8+?=
 =?us-ascii?Q?AFB9IQP3ObXq+672qmPPnwuZSLgC2lhQX1zSdab2znNgOut8I1caAuue9no3?=
 =?us-ascii?Q?VoBktY/cU8tzgEghhjb6ThNgTTPnGfV6bEkoat3dmoEaq3hiPehs/KjNPrVN?=
 =?us-ascii?Q?bvcL+hOlTNySYY91AcrsvKacpAobp6WF4Zf0719zSrYnnte8hp0eMZy8rF33?=
 =?us-ascii?Q?uwUgb78s+mpzkz0OokFCfo4zYuVMhDQwiwbSP7UOQ0184YjTVTrmohQRWqZe?=
 =?us-ascii?Q?A8qsv1Zyv9u8ENbUrskaV87GliW7WFez4IYOZjrOzMNwy2xU+q9pCWEhBWC5?=
 =?us-ascii?Q?v/nneeIbhNX1iuP6LG7Zr8rXHCQXVqfVosqpy/92xucY+6rCt5Nm6dVj4gbG?=
 =?us-ascii?Q?w2aCvN2DAjx5SfWAXBb5D7pCN7fkTxxkL+4fJtu8ZyAOPvPeJj6UcDM+1/1O?=
 =?us-ascii?Q?KDWUyfTekPcsVODHNr2TlKpQwu44zGH7eFA753L1R7pR9ofIH/88QokwOviq?=
 =?us-ascii?Q?hnuXtpS4cpWRzLDaN8x1I7z86ZZjfx+pK8PJR/d5Yd0ANIIeWyRCPrTclZnX?=
 =?us-ascii?Q?SHipZ8XOYfm1FM3ZvLTB5810wet/KY3u5LDgSYKkgSwaLPOwR7DY0IU0ZRQc?=
 =?us-ascii?Q?AHB8Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7PAORQb3qLYA3TBxYi68FFLcOyGIaeWpK9FLjZRy5aNS3+X7gp83Wl+eobJRZq7G/WzwTClO9nE3+IooKWVzLfEsoT3/Ji9MkyxAj6lClSHmFD0f9kcJ/aC1pG+nku1HId7Y97HnQngPd7e3UOfgxqJ5W+ndXx3S+axxLCBfJCBG4ND84eYT2PCKVIuy/XA/cZ8rWWa6WQUfZH/0oLLAuWIh1jGRqAT5lAW5JIo56NBv3g6ZnEMUFZxedEv0ItSpMXXzFvabmJrppxCK8hl9cJgIXaGcLJ/lYPO19kZ25sWyV4ZOPnn/+eSq9bA11YFYUHy/pzkr0gTmRlGMjNa6/NhkhdYhyVL14EuIRJl97ExmInh06G2f9RWXf8TKXaIYHedwk8UG0bJK2A1k+expqp7M2q3USx4rOc+4NXtzzW0h04ExgTzeEIv91fI2XNtK3wnkMdK4W6vaJEqfOXx3T+xo5bwgzvBaznRg2dR++ihr72ph/QcTL1vTABsM8yno2Cqs+d3+c0Mlg3xvflJjptZC2rS57WPuAtr3IxWPB+apLYgOz1o8JBfAcdUsS+WRjDoUaTt2P3VwCscsI+PVWn89qP+tevBgnOvU2d2B5Lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f84f6f-5029-4529-9138-08dcaa447d71
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:31.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQoHP89jOgD2wuHwsPIfl9fR0cYikSEcZMkWywQeyYMXu7DWgkKHgpXKZpcv3yOK7KukLRouYCdyhpFXQMddNKmaCsRYb52gLmkmo4wnu60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: GAiiU06SKDWyr1w2hlmthqNonsLv4qT4
X-Proofpoint-ORIG-GUID: GAiiU06SKDWyr1w2hlmthqNonsLv4qT4

There are a number of "core" VMA manipulation functions implemented in
mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
expanding and shrinking, which logically don't belong there.

More importantly this functionality represents an internal implementation
detail of memory management and should not be exposed outside of mm/
itself.

This patch series isolates core VMA manipulation functionality into its own
file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.

Importantly, it also carefully implements mm/vma_internal.h, which
specifies which headers need to be imported by vma.c, leading to the very
useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.

This means we can then re-implement vma_internal.h in userland, adding
shims for kernel mechanisms as required, allowing us to unit test internal
VMA functionality.

This testing is useful as opposed to an e.g. kunit implementation as this
way we can avoid all external kernel side-effects while testing, run tests
VERY quickly, and iterate on and debug problems quickly.

Excitingly this opens the door to, in the future, recreating precise
problems observed in production in userland and very quickly debugging
problems that might otherwise be very difficult to reproduce.

This patch series takes advantage of existing shim logic and full userland
maple tree support contained in tools/testing/radix-tree/ and
tools/include/linux/, separating out shared components of the radix tree
implementation to provide this testing.

Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
which contains a fully functional userland vma_internal.h file and which
imports mm/vma.c and mm/vma.h to be directly tested from userland.

A simple, skeleton testing implementation is provided in
tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality work
correctly.

v3:
* Rebase on Linus's tree.
* Remove unnecessary use of extern keyword.

v2:
* NOMMU fixup in mm/vma.h.
* Fixup minor incorrect header edits and remove accidentally included empty
  test file, and incorrect license header.
* Remove generated/autoconf.h file from tools/testing/vma/ and create
  directory if doesn't already exist.
* Have vma binary return an error code if any tests fail.
https://lore.kernel.org/all/cover.1720121068.git.lorenzo.stoakes@oracle.com/

v1:
* Fix test_simple_modify() to specify correct prev.
* Improve vma test Makefile so it picks up dependency changes correctly.
* Rename relocate_vma() to relocate_vma_down().
* Remove shift_arg_pages() and invoked relocate_vma_down() directly from
  setup_arg_pages().
* MAINTAINERS fixups.
https://lore.kernel.org/all/cover.1720006125.git.lorenzo.stoakes@oracle.com/

RFC v2:
* Reword commit messages.
* Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
* Make move_page_tables() internal too.
* Have internal.h import vma.h.
* Use header guards to more cleanly implement userland testing code.
* Rename main.c to vma.c.
* Update mm/vma_internal.h to have fewer superfluous comments.
* Rework testing logic so we count test failures, and output test results.
* Correct some SPDX license prefixes.
* Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
* Update VMA tests to correctly free memory, and re-enable ASAN leak
  detection.
https://lore.kernel.org/all/cover.1719584707.git.lstoakes@gmail.com/

RFC v1:
https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/


Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: move vma_shrink(), vma_expand() to internal header
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   81 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/mm.h                            |  112 +-
 include/linux/userfaultfd_k.h                 |   18 +
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |  167 +-
 mm/mmap.c                                     | 2069 ++---------------
 mm/mmu_notifier.c                             |    2 +
 mm/userfaultfd.c                              |  168 ++
 mm/vma.c                                      | 1766 ++++++++++++++
 mm/vma.h                                      |  364 +++
 mm/vma_internal.h                             |   52 +
 tools/testing/radix-tree/Makefile             |   68 +-
 tools/testing/radix-tree/maple.c              |   15 +-
 tools/testing/radix-tree/xarray.c             |   10 +-
 tools/testing/shared/autoconf.h               |    2 +
 tools/testing/{radix-tree => shared}/bitmap.c |    0
 tools/testing/{radix-tree => shared}/linux.c  |    0
 .../{radix-tree => shared}/linux/bug.h        |    0
 .../{radix-tree => shared}/linux/cpu.h        |    0
 .../{radix-tree => shared}/linux/idr.h        |    0
 .../{radix-tree => shared}/linux/init.h       |    0
 .../{radix-tree => shared}/linux/kconfig.h    |    0
 .../{radix-tree => shared}/linux/kernel.h     |    0
 .../{radix-tree => shared}/linux/kmemleak.h   |    0
 .../{radix-tree => shared}/linux/local_lock.h |    0
 .../{radix-tree => shared}/linux/lockdep.h    |    0
 .../{radix-tree => shared}/linux/maple_tree.h |    0
 .../{radix-tree => shared}/linux/percpu.h     |    0
 .../{radix-tree => shared}/linux/preempt.h    |    0
 .../{radix-tree => shared}/linux/radix-tree.h |    0
 .../{radix-tree => shared}/linux/rcupdate.h   |    0
 .../{radix-tree => shared}/linux/xarray.h     |    0
 tools/testing/shared/maple-shared.h           |    9 +
 tools/testing/shared/maple-shim.c             |    7 +
 tools/testing/shared/shared.h                 |   34 +
 tools/testing/shared/shared.mk                |   71 +
 .../testing/shared/trace/events/maple_tree.h  |    5 +
 tools/testing/shared/xarray-shared.c          |    5 +
 tools/testing/shared/xarray-shared.h          |    4 +
 tools/testing/vma/.gitignore                  |    7 +
 tools/testing/vma/Makefile                    |   16 +
 tools/testing/vma/linux/atomic.h              |   12 +
 tools/testing/vma/linux/mmzone.h              |   38 +
 tools/testing/vma/vma.c                       |  207 ++
 tools/testing/vma/vma_internal.h              |  882 +++++++
 47 files changed, 3914 insertions(+), 2453 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h
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
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

--
2.45.2

