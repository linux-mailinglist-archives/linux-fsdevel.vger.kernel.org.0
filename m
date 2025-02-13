Return-Path: <linux-fsdevel+bounces-41657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE42A34147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7C3A4021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623526EFC0;
	Thu, 13 Feb 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uj/Jpiha";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzghFqwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB12659E8;
	Thu, 13 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455172; cv=fail; b=tgFWZPgp0ZP3YYrT2bD9EmLFm53y/KSrmYcV5AOd4l8fnVZniRDxe8RUuTkgKw2qlLCTyINH9Hv/7xhUJhz9mHezO5ID3UUWIWGAQWV5OoQE/xfSCCMw0d8SitfTpS60Vf3NPB5xRI+E+WsKscPWSOk13J6LzDIkBUJqnweuW7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455172; c=relaxed/simple;
	bh=Hg3E5RDUi8XSuwJFbI9aUTC2UvkFSH8RNuzLj+2uB50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqPvFGJVanHmDd8Qd4UwsoFpu9lWNKhEWbTf4uiVvaS6Uv/pYdrbCWpnIBuC/IdtI6qr44K+f0tfHVcUhL/K1Mv9v9e5Ve9mEettSI92iBO4RjlYP9xmNoGctHiXl0TdTpe/pTzi0NCs4njIthBDGwo7W6qLkiregN3UzGMsWLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uj/Jpiha; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzghFqwK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fhEZ022452;
	Thu, 13 Feb 2025 13:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=42aOc8c8O/+sEmVC3yfUGvyJcnVa34F6YaCkxEOsdIY=; b=
	Uj/JpihabXgLpUQ6PQgJcFeLdd10rjNy448Ippv9sfEHlxDjGNN6eOHcYQgnJiz5
	U+anp9bNUTfCeAzZ5ZNiiZqEqnljWToUWIRZZUaEuWNzy3Y2HztK8NYh2LGMXCCM
	/d2APb8B2TtfJZrNmi+6Ps9WDxJJNtOURL8K0V1Z/YmLMGQhTwFJ4dT+tKq+ZIza
	zrdy3ql5u16d6sM4Bs1GktBNmcuy4pBD1GS8gPpLYPWgDufhQv/bBa0kGVL/+Obj
	eR5z4OSiFLM6X7jrbsQWXe3JmA7zFEEsQXEH3vNz76EJz6I9v/sWjItKObBRBq4z
	OKTcGVyFEOa/6q2xWkORVQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s41mcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDWqmr009852;
	Thu, 13 Feb 2025 13:57:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj1u15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz2bcQo/IAzyvCkkaFYfOXyUylEB7NPiNWuRuOcgk4wjmiIuDSVSGGr3U5403dQfPkO+vbm0WEkH9HV7wq82T0uDr+gNpQWSUkneTogdxv0ILsUg9Tr0KGehKljwKdoZcIMz+w1Yn8AplWiYrROzrvAmwIt61Pe9Nuyu8+4NqWD5QWrVHAn0yGyW+y/NyFQ3wCwnlgNWtIfCbEMQ/1iYPj3Zp9yJ2nrLtYiAQ4J/jFNjqmdgf9/bOaBheQb02g+XdVobTeYQdWUtWvYNt7H9Q7LcBGth+Tx4b8UiYv+GQ/YHkeS3hKdZYNyZi6Xi55KauqvOdRypHjnUJiGvRq4FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42aOc8c8O/+sEmVC3yfUGvyJcnVa34F6YaCkxEOsdIY=;
 b=XrYfSqaNDB0uA3b0Ser7WiE53t3leYxpo/ku/IpyWq8Gb+q7a9RdFLOrjIXbWh4fA5xrRZJutMNyQ6N6Y1OlD28imLsKGbLoXmOZC739PGNsq/KWnp+5eKjiLEQa+43xPUVrjOWxtiQheZ7JkUnKNTNJzJMEEsu9OucxMGWykVhSgrw22cHapwoksSqVVY175GBWSLOmZqehyr7abhjLd/dG5qwxx5jzBiK6uuLgg13Ht569GvMbJalC1mhVGS2BVMSgYX5PvWjuBjwF/un/+VHaI55wExjhRELU5Ww40vCvjWxgU19wVbvU47DSaow1/sGCLFrgxTnGns6LJvPqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42aOc8c8O/+sEmVC3yfUGvyJcnVa34F6YaCkxEOsdIY=;
 b=TzghFqwK5I0BQF+eBwrjActPjCq4wgMNcbPzfaBIDU0IHbQnLWRUGMvUrKPZw7JepgO9e2yhHb3Tn7jGVmIgDpNdz2/tgXhg4vDYwMfgGuLHXhEQwAQi+8T1pE7S6LsaCPxQS+ZENEbxPxMt910IkITYSS5kgbA9YcVmy6icER8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/11] xfs: Commit CoW-based atomic writes atomically
Date: Thu, 13 Feb 2025 13:56:17 +0000
Message-Id: <20250213135619.1148432-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 11262d57-3124-4204-f941-08dd4c365134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dz8RYzObx6L4UHdkgL4oBT+6AUTCMg5rnHQmuliufDLABUmlrRjDiQUXd8L7?=
 =?us-ascii?Q?5HPhhGTPpBAUYU8gBsH0MkeiEEkEBn0vczgPVgXBoM7sewsOn7lxnt6PVPCt?=
 =?us-ascii?Q?wdI/K6IW8QkuxcYpMQUh1VVVdZk+hDw7d+xt0UnN667UImpitfB8NrtbIKqv?=
 =?us-ascii?Q?KPPpk0lJ/JyHWvGHi718UEGDQH6l58WvqTeM9OEcICD0ESTSEVJkNUY/yWdc?=
 =?us-ascii?Q?YFf6ehCZhDFtYY/gMcaUhlg77NDTUlpBy10drUQ9vm1sQqA5rSVu4/GxiYj4?=
 =?us-ascii?Q?Nffmv1MvsnvIsd65KB9q0YdM/ZzdaicqBm8+pgxpjeCu+VZKMbb2xZa4lB7H?=
 =?us-ascii?Q?/8wCarHFCojLwejTbYp81cKb+lKSEIuJ6TADkcgXK20TxKK3/EwgEQI3jx2W?=
 =?us-ascii?Q?arLulhW5NZ63zHJXV2c2P2xTmot6cWbwcvav70HYAEQEJX6WyXQdBb9b75/4?=
 =?us-ascii?Q?emk++3ZZ3qIrwFnJ8EFzKZnHgXJK8TO9sOqydySJTMA85WSZTrJYetOrQt03?=
 =?us-ascii?Q?gjRUCl0QBQRH+C9YKDFp3qFcKRnYTsdXzs1EzFAOJKsd8IAwUukd56F6t4by?=
 =?us-ascii?Q?SXYU2CkMAiBfwDwosMpdoWpFwTdTTJ3AtEfLj5oTsHPO05uDIcrEo4z3HFgX?=
 =?us-ascii?Q?Krz1876oHUYLtDEEbiNzs0EG2+52QIZAvJET58XNDXagr0/EHaz+thGRNscc?=
 =?us-ascii?Q?s+w5WxK5zTDxIIDAXmZVwSj1xU4dmPFMI3O9TUl53dqjU3kdaL9nx20GtU+3?=
 =?us-ascii?Q?J6AAl7F16/UfNuoI4hsA3t2SSz12O6ZSL8meHEbH7P4nrt1osWEVYPCilqBr?=
 =?us-ascii?Q?m+jv+CFBN+/GNJwiU9v1Fh504/+nv/tftsLS+q0H4xeG3SpBWrQRpJhxscGn?=
 =?us-ascii?Q?CZAIG4MjRkXvAatr7bSDLdtkPPmHJCceqGi/io6ItmCh+0i8BAk1MGJzaC5G?=
 =?us-ascii?Q?dXsILGWR9Dyd/zba0/1ONh4sdNPQ+MBGRhfbKFEpAiYb1PN0k5LAaNkcAEuL?=
 =?us-ascii?Q?2WpBlrJyD64v48KVjWgi19RbgT0uaUSaJRZjQ5F7aRDRBWRARIDkllaLa+sm?=
 =?us-ascii?Q?Dy+/VD90y0cThrAcY793CJfCNtpbea7oMvj3dYT4MHjaqJUY46D+OmD290eh?=
 =?us-ascii?Q?cSdeJkX4BbFO+jZAISosrIXliUPprDQnEp44AwFuGiNIOOJiZuiHOEpAV0U0?=
 =?us-ascii?Q?I1wta+vWyRpF9oLwwzIfaMghjEx+udLng8fg7F8LzurMC+PQmbrmPBkWKi9J?=
 =?us-ascii?Q?rCNLh7IzcUU+Q303lhWmHlm+YP18AKEJZ1/GqgSDPwmLSfrj6DZh3JqnhrN1?=
 =?us-ascii?Q?YBCQX/YmjGGOl1JAlr2H7U92tz3Ib5N3Duzc4H3Cb0hGb/YqtaXmW5sMgTAl?=
 =?us-ascii?Q?b21rseXI8culWrLFs0QKFvN8QKE1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PM3pFystvImxcIJ6YXwRK6wp6co4erYQQXjFfUV1TU0OSBxtSMNjlhKbJS/G?=
 =?us-ascii?Q?7T6oFcShbxM+cN25o3f08oUbTKZox2FrNR42WFB/cAlgXmXEAt0l8nwQRkrG?=
 =?us-ascii?Q?SZCHWdCxUmJCd4GFL3de3sNmaK31JzuXMEqP4QofYpbQiUxfDF1dGXZw2G64?=
 =?us-ascii?Q?3Jm/33GYtvwjvFVQO44ZvLzuWbf6q+Avh67VyzlUrunkRYphmbsR5zsdYH9T?=
 =?us-ascii?Q?M2bJ7qr+PsxhqGbbvV4gHYgzB8f1uxJG9Hnur8jZKCWsKkjFWLzNKqxlEKOH?=
 =?us-ascii?Q?YSvd8AW6Rw6dQHYaDsjnPjA8FJ6/wL0FjvTUpYpr9Vf61LCAVvEeGeiwAD5A?=
 =?us-ascii?Q?mOWKmq5blVVNM3UCoV8CFTjXpQhYa/JHUKpxH7ISIvUHI3WU1MBdDnAUx6Fg?=
 =?us-ascii?Q?sIsRvNnJc0hsV1FkNxHgtaKTmpImDdUXJoweeV3ctuQ8yD1BIGGfieT9Q9P9?=
 =?us-ascii?Q?ihXODSsJcocbF9JRG+faNWcKjraA7ddvGllNN2l1D91qBxJzw6lfpTuc1L60?=
 =?us-ascii?Q?zI8cVmUI3m0L3ofRufnrWx7A/aS9Rq9Uk3pTZHWJDpHr/acfO8ZSI1QVx62k?=
 =?us-ascii?Q?LgPryg7O843AEvbtrTWUrtlxaosFLCZwfW3YiWtsuU0Y5CrHyzEdSdcuJvPO?=
 =?us-ascii?Q?8t/49H6Nr1Kx1LI7f9gOmeQBtHVV/R/c4xLUNMLqaD7vPygHJ8yVMmM6eLO0?=
 =?us-ascii?Q?M1qn5TIUS3n4j9gsGRYBFqTyQ4IMcqNuBs6w03jNND0xnZHB4NVtYjBeSfu6?=
 =?us-ascii?Q?5yzkqg54GwX4Zuh6FKB6SINxYK9GKTD4ML7ATAELkyfedyk4HPtSa1x8Ivg9?=
 =?us-ascii?Q?7Tg4EI00K7Actqrgrv5SAs85Df56aUDn3nl7kLlEM0nLUKNNJXDK0o/UpLSZ?=
 =?us-ascii?Q?CuZ0xqCtv9xJ1mey2vilalar8QZQNbMEmeNmt+8QViwPUVoPPNXb4jCOFk/W?=
 =?us-ascii?Q?+ir6kcADwiTaCHQo2lVC16ATd2zms4/7kWidZ0QC6T3EO3VqEYTr1iD/dI7r?=
 =?us-ascii?Q?kYCejjzIxOaDXbqLcHykWK2eEqe2rkV2sBpZOSN1nAmXZLZzmbAa5XzvHa5D?=
 =?us-ascii?Q?2roFnozy+EwosnQDoCNpIrCMi6YpWp0H7QfFU0yQVMqGrWMjLEBzTJwJs5Hn?=
 =?us-ascii?Q?T9AwV6MBcL+U8q/fa7q7w6opnt+uYDodBNrk8lHcVbe/sLVLydLf5t6J3iTV?=
 =?us-ascii?Q?GLB69HxXbVh5Z34r2GjXNKaOtQPhD9ibx1y71+rdQR3Ms9XWe6YYPOTRRf2o?=
 =?us-ascii?Q?IHPEsdyVdWZooyua2DkxzX3dTl3DVWGchW+6I8TA5IcAM7RUUNjRaZgMx3IN?=
 =?us-ascii?Q?XA4ABIoIFOy83Sa+jYwsMILGrh+ApJNPDFzi6ti/l8rn0t+dVbjwWKmSXiGY?=
 =?us-ascii?Q?91yPuYDZjnGXbF5u53BFDYZ68LQFqHwcVwLfRDh2MwiC0h1TyZ33dlCx2RaV?=
 =?us-ascii?Q?xwEBEcEEc1tBbwu+rvbFjDnaEzi10ONC8aGgFnXDlYYzpPt3jxaE0rQa5MWm?=
 =?us-ascii?Q?FxdMnWnoYpt7/EqheRMMLO6teOJV3CIXL+Un7ebHL5N7sG0ccozJZJn8sXQd?=
 =?us-ascii?Q?0ssvK17/kMoy7c3V97+aH0hNk64FA8j1aii1XJd+UNMGgMKnCZZkmEXBsj1B?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQECZHk63VjoDeYfzoHX1AF7LyfJ8upCdVlQCU3+2mRDAUoiXnaq0dGMAYhcv7GqQOCsgbdkKHXjTvvxsSOTjM8k5iktJCOGuQ7qp46Y281YYFYKjDRf6cYRebxUE5DneL9pJCFsdApv05CjA6s/5Qoxv6FpxfrJU+niblqgYmbrNHYU/0Korb5pAr26eUxbAyjX4JoOB9+IThc+7GltGH34DFzrR/BC3A8H3mUzZGIUyB5uWPgehqLU7L3/5GUJaZgStLzVjQGP7v7msfVVm2jgboxRsSUyL0bEvHWbb5HODOP/vH3vb5/S2mNRZ7GJ+Tvn9PnjrghNPu1G0SOiCJGAl2tVQ9KfQkhKSE03pTxcppXTo0YpHj2JOoaY49FKnpAAWf1u1LkVh8HDSx27y9WUBWvfNUbwhOz1E7YL47/7pSr4yQwlBJCplGgIJVa7YfEcjIhtpz7TRQLmIV5YyGRsYy9CY8VuzCckY0CARHUsMAzLnuDReX4Yjn5V7qC3loLQ0Sns+mIlFVJu1zdiZuMPuhX+GSopl5Ice5qniCI3cDTUcGXSrBDqmZ6GC+lTMD9Cub9P/ayoiIcADJEwIJeQWfCZEAFwlSQa36RIxaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11262d57-3124-4204-f941-08dd4c365134
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:13.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y3W8Qa6/gqqAZuTw+juH/Fd5bpkttTT61fOwk11agUxbaOcZojk9ekv5/P71a0EXGlw4XIfHO/efMOkyRG5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: T5vJzB_VEIgubyjC2fOpcafD8FPDkS3W
X-Proofpoint-ORIG-GUID: T5vJzB_VEIgubyjC2fOpcafD8FPDkS3W

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  3 +++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9762fa503a41..243640fe4874 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -527,7 +527,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 3dab3ba900a3..d097d33dc000 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -986,6 +986,51 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
+	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
+
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error)
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+							end_fsb);
+
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return 0;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 754d2bb692d3..ca945d98e823 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -43,6 +43,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+		int
+xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


