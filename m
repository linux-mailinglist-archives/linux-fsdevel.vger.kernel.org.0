Return-Path: <linux-fsdevel+bounces-40740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35420A270E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DF03A5FE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5820F087;
	Tue,  4 Feb 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bV5aXdH4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KoP+wCBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E1DC745;
	Tue,  4 Feb 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670631; cv=fail; b=ejhYfVQ/ztFJjbsV05F6Mg3Qudig4rwFYCN6DxE/jQpjgxJAjLn/8p08oxx85iHQ+hvOqiHZJAVqT6jMhRdMJbINb91krpRDm33mPc8zpM+0/zR2FE/D9PDlZLuchNiQl5X8QgCd2a84rlgjkTwKGRNTzNHfawNr/lVzh3re6to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670631; c=relaxed/simple;
	bh=QQkvml8jgU7naXTmB8Te/WrkaaGfVdTAyGeY1Ne7B5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4pLYCMkSfmcEt0aMGgKkltznFuCyF+DpVYxyiBMCz0zeM/Rm/B5ct1riim7Jf/9UBb931TmpyTm17XJMqHKVxp21rPyBkyHn2Zfm22Um2RtddgOEhssd1VgGP7G28fo7TgxJvk1BWZMNklCCP/HErfrgAyos4abfE1k1GfkMaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bV5aXdH4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KoP+wCBd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfTWt013644;
	Tue, 4 Feb 2025 12:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oZbN1zRdMffhDHa79Nqa9CMBQoGdTiLjKtz+pMOo8Gg=; b=
	bV5aXdH4D3kFptwJXZdL3HZ6ZSgyOhSJlAPHbBw4z2M/DcyWeI23gjajgF760IzT
	3VE9IRQbi0dKOthYE9254DvJJNrSNiLOkEkWoc/kUi8unVnUTMvOIsZCz+zASp65
	UWNGwOghB2f0aCDkaWZtz4ZnS3nyu8+vabj3WGeGdtOsS6T8bfMo5gUfPYrLvf/J
	xhq7b4mkjh+tULmhCsgSkVpqm15S6BoQ2SQUTsCwGyAAXPMLIV2SqVTbH9mGYb5C
	ryPj51Zd65IaAvQKT75UnitO6MKEX7fZL5hIMRQL9df0E78bjOs2uwPKjUaZPMG1
	apZqiIe1WbslZjZ1xQp4MQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv4ps7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514B2Hts005581;
	Tue, 4 Feb 2025 12:01:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fnwaqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHGQPBDXSTnZe78EZHohL763n5H7Fl10jY3hnLKiP6p2In+mKMEWQC6By1CEe5TF+bAtOCXIc2OGLWB4qTzZW43kq0D/JCvVi2lg0e/uT3skbQNdz5glZNFiNLcGmrF180XjgQYg1B0tPwLcyRKQb6bC/qslImUkXAxY17SRpGIDV8jmydwRzIOuZWXMCeB0lr+G3CPtwiX2ZKxtaJcqx5dv+CXmU/tiNy7lUvVs/O3ReGE/fdX5ObMjDXFwsEL4At/fNdxgzkUQ6JkC76L6i+VrnDX5Hw8t7rtMYV0SKaG7IHGLLRzLpanV5ZBtxomntYg12AMgdzK8N+BIVTYUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZbN1zRdMffhDHa79Nqa9CMBQoGdTiLjKtz+pMOo8Gg=;
 b=lG97tmtVoAPyfmJmkDe+gdNXF6tnqNHKlxcCrM6dX8v2SIJUc2vtE31hgdHhgj49zPkTnyNE+rKLZGh5tKwh6YJRuocD4DUCKOCum3V5VBaXAgikfVyyvRBDJwE+UY5avjS8+T2Zs1wcc29H6pJO3Ud9GUdcx775PNMBW4Z1R2R5hQstR8RDsyI0+sNRigiMZlgjP301FUeRL5zh6wnfTuxl9EGk9XLKtw9dhlKHloK1WGFQccWYi/TGzRh3I+HBLZLb1PiiC3NGXES/9dv+g3YRfKrfd5oaJX+JB9TMVswkZ2i7fhFOMsa4pOtbYl33dPywhSRtQTfmFEck0VuyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZbN1zRdMffhDHa79Nqa9CMBQoGdTiLjKtz+pMOo8Gg=;
 b=KoP+wCBd415xyANYz2nHK9ND4zjCDSsYsWY7AWveFg02rM0prcyvcDL85Z75qlsglofXXLToPNnWQ6OJIF28OpNuGYFi8ZUPZkzvmH3tC2LBkxos2ZSNYf7j93Jm4s/HSvVRY/LGt9J5iClU+MYlLjpPIzq0eHgdUUuxbc7r2hs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 05/10] xfs: Reflink CoW-based atomic write support
Date: Tue,  4 Feb 2025 12:01:22 +0000
Message-Id: <20250204120127.2396727-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:408:e5::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f33154-9aa4-47d4-fc32-08dd4513b464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6w+TT6rZ67bsDarRcrmwsDfiNDkSzNlsXpevs2/mu9dZeqv/yMvZCNbl3Q6q?=
 =?us-ascii?Q?/n26/j7tW550ZicV6uzuIt9ryJBgoMvw34jmUz4E3KinaRixYeec01+993tl?=
 =?us-ascii?Q?c05cNb2d+ByvJIhVAnhxHGNOO/PppZudDO/zKAie9vXA+J+o6GF4T8m/Hdso?=
 =?us-ascii?Q?MKWIMf3C0mf4mo2pMIQJqq+FahMdzS2oY4MeMkLamWHaRw5H+ZyjKnqjz09s?=
 =?us-ascii?Q?EhlSpcoU6zRyKUF2/oBtGWPkLuUQAMj207GENRrpTf6wLexop9eNf1o5zuV3?=
 =?us-ascii?Q?y+HGBd4VuUoFiSyf8Bz4nwl0d79UKHDc0xLb+cZEK67SSAaSLtrghaJU7WMF?=
 =?us-ascii?Q?3l6fyB5cV3FrZA8Gbb3dqC3Q4ksBYVTFLA4XK3UliI/oyOYXvZOXX0OUIp4j?=
 =?us-ascii?Q?eV8XfdsZajN4FfLXNMTPLdo6kA7SNHnfbkgiZNT8YE/UYx9puP/AEJtwim3f?=
 =?us-ascii?Q?Jaq495pYGsQFYWFiWxmfP87NtrvYhs9KeryuSA+//9s/gCp0ZUFDmn/rNyFk?=
 =?us-ascii?Q?BubBh67AI0l42K6JytRds4rrT7aA+5ef6NuIOOqKLDNMNnbARE5+CpU0HJkO?=
 =?us-ascii?Q?vy0xlE0XKBEx561vDWe9lM8pGYvYLjq6j4ghEDbRCgYNZycAwj+WSKyDON6j?=
 =?us-ascii?Q?TCyBvDTxaisLdEgLflFK9Nbujiunxgrpwwc3ChpBuGfZW6qKaSka399ZHy6U?=
 =?us-ascii?Q?n1G8QnZyFkyCFh+pgFiYQoop/36LWJLvjHTRUChTQ5z/XU2BVge4PKYea+xb?=
 =?us-ascii?Q?5wk/HPPTHylahLMtoQuBAvKzIbCPm8czJDmMTZJBXtQHZy+D1m+f1ER6xW0i?=
 =?us-ascii?Q?0d8Ox9SzmUg5fpZCfAXF2KtJSOX+/gT1T/EjSwA0EKWI3Y0rjyWe707pRthV?=
 =?us-ascii?Q?XdABWOmqG1EN8868Fg+zuO6+D5b20JnciM/5uaXVXfXnY20KQUqEh/hAQ59Y?=
 =?us-ascii?Q?qJR/chWHYSgsisstBpysoAxYdCXba8jXxwJP8SEwZCmO0gHHUupJNJGtJZYa?=
 =?us-ascii?Q?mkZAN/IxbitK2yApUZCVLhaL+TQrC94wgFyU65vl3L3Pivh6+Ic5xdVp0bdv?=
 =?us-ascii?Q?sAB5ZYFsXwepahc2t1CJeIaTfrAgGKquj0XsijJEuM7U5vFhFWRJpqLiCS78?=
 =?us-ascii?Q?Nbt9XbRqaEOnkuG4Qqn2lLcTADrJvzBTHORzJtq0tpkjKJQUxctq/obqzXpN?=
 =?us-ascii?Q?Qxx8yvodG4BT6Pm4b+rXZMS8fKMYFBcZ+LOhYccxDtBsjDJAiuGPcJtFdcFs?=
 =?us-ascii?Q?bW8bqQhKA0JMgnQ9+GI7QLpFurl7wFe7IC4tbiySu8sbu5/S6mv6IDlt6F5a?=
 =?us-ascii?Q?A3ewPbwVT5IxNB8jD98PvQuw0KuamKaWUEvUb+ZZdHzwqMkuCZuspdON87E6?=
 =?us-ascii?Q?vmHsFbOAMVQSJ68W9Lf4wKKwC9qW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00ORsU3DOOOaNwZIeZ5k2sNL1A96ruBifjww5jJyDDP7dP4uU7D7oEzilZen?=
 =?us-ascii?Q?S5ZBTHQHnhITgFmdjJ8F4Bbebb3Rq70499gkdfSM84DEe6HLXtVsl5JSvDrd?=
 =?us-ascii?Q?3s60TzD70XtNFU9sI6B2iCQt6Sqc+YDnCIUDLonyY6aXHkV9DILTS8DISho0?=
 =?us-ascii?Q?nWuPQOcu1X0hMhiuCHiEwEXg6sKRpt2hz1Tmcj6t3TSJng64KY160919Fswu?=
 =?us-ascii?Q?3WdM+17EEkRME/7zCpzouJfsk91qpadskhXFZ5dh/1+z1oJNlgxYEe9Yt9MW?=
 =?us-ascii?Q?zGks4zkM4zW2uDk2UBmPMbO+hp3pkWo4Sw0uuOnhplVgbMIBW6w1ydf/+VMz?=
 =?us-ascii?Q?S/Ahs5qS8WfscApa5wUuLJTuNlhmyqAHcU0RLyr47XvM88g9ZM9B/fr9Zp9A?=
 =?us-ascii?Q?P6/Eev/OJFsA6PaHzHG+/+XVXckIHcCHdSEzbTgqdG5giXgsTHoIj2wJvVOX?=
 =?us-ascii?Q?DJnCSJ3MWVBsL3WCi5bgDQdtfehVngPQ+BKIRVk6BmPHpn4+7j0b6+rTwU4i?=
 =?us-ascii?Q?CX6Fy9AMtIW/T/OG8HCqN7L+AhmMfYJt3/Jv6fHQnRMBeDm1XLy7YvunXmNO?=
 =?us-ascii?Q?rcLMZ5sNmLXPogvnXN05trn4WMqs/XYEtgEuzE/QK9/HAwR7dA3656JGCEqZ?=
 =?us-ascii?Q?rNbbdjMOsYosX1VYGWRpviz6nTJA3skfVnIi86eHVqIGiI0TiNtSSjFXG5t1?=
 =?us-ascii?Q?E2QbT69dB6B5p1Z5v8GrFF1MNZ36pgS3cMw0US15f44aMvA7H6MwRnU1u7El?=
 =?us-ascii?Q?gCTGHNu5WHF0hst7OmoAiyrEzUntz7gpqFtmEhviXN5+VL/HSn7wsdpZfOL4?=
 =?us-ascii?Q?xFwsQxExvNbe0U4jeoXrrwNrvndNInB8z/WhljJ3LuuUBkCaU6Nt+B+ZRphV?=
 =?us-ascii?Q?84xDeikGlfPwzKJfzi30RQrTXuxvb71hjk2LHP21lVRfR7tPmhNJki+kphGL?=
 =?us-ascii?Q?1OwfhLjTv8Cl4m6de2mjhC3qXRZZMoWGycF4CfJ+pfrK+M2I/OFb/r1EPnXH?=
 =?us-ascii?Q?2JecUTre6bFucnb/BkPhelebIqZUCgcUQRNrSgCUrBZSvQ187O4yF1bv68pC?=
 =?us-ascii?Q?OIyslyvZs806JsCnp3Xb5w5cQS/0QvurBv8o7KPkUl4NBfJiUS8legdIqKxz?=
 =?us-ascii?Q?CvUFfcXIStOzDi0zgmR+cJ9p0KVHpb9cbEBR11F7baTfYUqhQ3AP84MnVk6B?=
 =?us-ascii?Q?tWOveSFYXxQKwOfh+elOz8ZS+6fb2/2Gc0jQeRLt1Lof2QHRp1l8wgw8RjSP?=
 =?us-ascii?Q?/tsFa8+wTsvHsqxIVsWAL8Szfb/88W506gvaIx41LzPviofb7xJ9DeaZGTle?=
 =?us-ascii?Q?oH2aQjFnfvm44YtUDJQXOZz3ErnenUo+cqyJxDNLZii34fMjThU9BvfZq28X?=
 =?us-ascii?Q?lei/t8B/+NzLWLCVo0vS4hETmFBg0ZfXSXKrDeRZGwk9xesAijnzMRTaB4sT?=
 =?us-ascii?Q?HiI6YB0kVzjxnEtqrtMUd2fmwSwmrzNSYjJ79GAakjB7N1q78jxSMNUepD/J?=
 =?us-ascii?Q?HnALHXpKO9IGGyvOpLTViv+dnqa0OffzZQ89gkTAa9kVkkX2HWNFcc+XQ4zN?=
 =?us-ascii?Q?4byH1uWm3Gv18HEmmocv/bxmw74mdoxSK7rJX/A5GAGdWFduYxTRVmK7P2kq?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RJVBLOmOYMUhYfMcTHbCsMvQ1hk6/vFaevjf6YtXb2B88ngF/3pSr7cdQl8V3It80cTFRi1eed3Is+aEs4/REEhWm4/gY5JJZhcb3gXkehASGkrRbBqyGN7n9Ac5CxKhEqyQU/Y0pN3CMz/zSbnXlzs+FFCxvgTcEi59sYoDWfH8JFsONrZTs4u7AMxHb5KG8HXyjN9HoRpfS/Zh+29cF8r4ZTqRQzYWqKbF8rhRDXZxiypR5+0r6704JrFgH/dFsPZN5e/KAUGJ49lamXBMefq7eHjVH/Z8lc8u1qnRiPYz8/1q6OrcTSLC61QLXdts6mY8/smYDckqI7Hu0xSao0Zi+nFFRHShgQT+sjaKIOkEvlbp3Hf2jV+AWuuetJ+lX+YA7ZOElD2tZqDxBlII2iFap8LacTiCPcBOV4OQpcHBqwzDjVYUbxioBHjxV2cfM5PEwx8lIeMUtXV5zHyQfvvqBtzlkToTwYMoaiABsoKdb8z+X52IamPGPLRj4NY0s2rTZgL3JSqW/hhMC4i1BANLsMjzkRgpu6OwzlcCPN54VFYakYrGNgosgJn/1rMdDfArJ4vIhWQu9/neCGuzF59Vq/mWzezyJuN/vk8Ca7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f33154-9aa4-47d4-fc32-08dd4513b464
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:49.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0UgbITv6sBJ/pkejx5Uum8VubfTkpdWpbN2s14+7n9aJXOJcHLwY3I+ScT1vyOohGOO0lgR8UhZ1jskPh8vqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: BXaS2gAsBG6blA8dXpe3aRoZhre7ZxAk
X-Proofpoint-ORIG-GUID: BXaS2gAsBG6blA8dXpe3aRoZhre7ZxAk

For CoW-based atomic write support, always allocate a cow hole in
xfs_reflink_allocate_cow() to write the new data.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  2 +-
 fs/xfs/xfs_reflink.c | 12 +++++++-----
 fs/xfs/xfs_reflink.h |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 50fa3ef89f6c..ae3755ed00e6 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode,
-				(flags & IOMAP_DIRECT) || IS_DAX(inode));
+				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index b28fb632b9e6..dbce333b60eb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	bool			convert_now,
+	bool			atomic)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -566,7 +567,8 @@ xfs_reflink_allocate_cow(
 	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
-	bool			convert_now)
+	bool			convert_now,
+	bool 			atomic)
 {
 	int			error;
 	bool			found;
@@ -578,7 +580,7 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !atomic))
 		return error;
 
 	/* CoW fork has a real extent */
@@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
 	 */
 	if (cmap->br_startoff > imap->br_startoff)
 		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
-				lockmode, convert_now);
+				lockmode, convert_now, atomic);
 
 	/*
 	 * CoW fork has a delalloc reservation. Replace it with a real extent.
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index a328b25e68da..ef5c8b2398d8 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -32,7 +32,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 
 int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
-		bool convert_now);
+		bool convert_now, bool atomic);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
 int xfs_find_trim_cow_extent(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
-- 
2.31.1


