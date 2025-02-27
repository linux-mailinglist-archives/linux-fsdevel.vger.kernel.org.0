Return-Path: <linux-fsdevel+bounces-42770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDABA48758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DDB3B9860
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52824BBE5;
	Thu, 27 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KyG7fJi7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QS3I2590"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50520409A;
	Thu, 27 Feb 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679726; cv=fail; b=TQmfhzaRr8814ixs1/g8UB9InMBi8tkx5SjOvPpKI7PJWn4STSwbOeRTaWQZBteIR5yLzNXK19BD6xLw8A2WadsyIVE8rjebrDwMfF5ETWmIAlYPlt6/kyhnKm5YJWugzX93mbeJz7DHAvnRTbUMaaAc+Z8mGe3bD90drTz5QVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679726; c=relaxed/simple;
	bh=BLbwDKiELBy2e+k1mUIiQb8HZkntx+nDiWZLSXEh5kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNCtURAnOy+0Cb2xehYlhPPTClo28hjVVj3+m1A5Qk85jfBoh/RgezVUJw6C7Q/IjDvK3tvfMd5QKvK3DYT3jFgl0n5KjJx7F/i4QHXOIJRr0yxnbw3Kov4/fi9qMHUBAnM7S1UIkCJJCksf2Mm2xaavooM+Y3n9Zvbg8QGvmZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KyG7fJi7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QS3I2590; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfhhd027299;
	Thu, 27 Feb 2025 18:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=; b=
	KyG7fJi7Sld+jzPG6tZWq/du/gxPzbSe87OYV9Hp+SDgYFjwK8jAyOFnH0UMbe7P
	TajnMBFW2qZWxmwnuQ+iV5QotWPocfQc1QxdVD08HYmLhyKj0ubP63csDbDqxbqT
	LB0ugMR+kj4gvjFDuoPJkKSL851gRiu4sQCHeWYPigl3Vrx+z8OTsm2laVyIceCH
	R5oikxRlTOkskwVttakB554egoIOUOrtOPTe8cVydg1x/ZcwEIHGsHXDC3+5hXMe
	nev8KTsvgokHqlwvzgaOEhCXa8zTyh4mSX2EkysYXcDMTcru6+7M1baL/THccqYm
	L9zQk+RjLhGuOqZ2lB11rg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf41hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHKVtw007383;
	Thu, 27 Feb 2025 18:08:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51jhqq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIwf49WgdZE8VlGSiqZSA35D7/BagGoDsAFtJ7eS4Gdg3Z1AwJUeFfqtmPvXIrWF2MBjAyMcYDeknvdeoKI+5hE8lhPOAw5YHsZfxyL6Yd2ps1u7U+i0yjf/paCntaDpXzfxVj/EuakjzwiEVDAG9jYpaDxgx+AVJtDzIushv2uM66N3+vxoOTo3DFjJOvruvMAGQm0AD4SGDn466+MKi3C5kD+a4z0Z7N8kPmfrT8YY52AGVGqz7Wyc/fb3OmPLwP2jX7G/KBuGYdTsbAzOC47E8Zm380qdjPDHfyhPMQqMwBBf350QHAkaM7ghEXT3VLw9BYNvXzdVybgUD7mTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=;
 b=WyRjF7w2XT4v4J6DHPOUL74DvR+1YjvIrPVcGxtwZ7mLczJJ+RXqOXlliuLTNMxuSo/KcKC9PczdUXrmviMofpJJtdLtv/422/0TXdO0Ev96Uojeceu2HRGbecEJHFghMJs+sCSXZnL3XBlHKGE7e5rzBLQWh6LGl3vp52i6QOAFG5PL6nuHr2TX+PO8W43oPiu4QHu6RiJA2skbU56zaVnOpsbo0pvkgJEkh2W1WHHzKaNBaDz0kz68mcGfeKdQh+BBJC+WIHCtAwyQmovt9I/36aCqaCdc8TlHYosSl8joBS2LNl+w9MC88Jy9H/daC9Xzc+draeOZYIc9/WO9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=;
 b=QS3I2590azu5mgkqfvBMggJqHokz/JKiTTucpgly1IAmhiWl7xNlngg4c/qH599bKsN6Qb4EnfsxdH7TTWfTWc9vWy91V+CK76IHdZ/PAD3/BKHbAvr7WF0Kn2tk7HhcarDguq5Taz1DkBzOMeJnGNXGJGec8qPp8ZwQ3biENYg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:34 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/12] xfs: Refactor xfs_reflink_end_cow_extent()
Date: Thu, 27 Feb 2025 18:08:05 +0000
Message-Id: <20250227180813.1553404-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: b772e176-9c81-4762-e837-08dd5759c023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GsxGfWkB+lgpi6h/CXv7ZhxIsnGe7IJZgqUYBTtlKgDQvCEUimcQ52A5qc41?=
 =?us-ascii?Q?t5Zbdbsq2LSyxqEBj3crgfMOmG2VHXgMNk+KeiUa5FLUL6AxrNso1oo/aUVE?=
 =?us-ascii?Q?Vx5IXAOzoGVQUhBu6CUP5VBUmbvsqm1nNqnsvaDadlpmFpLTq44qcDjeh/59?=
 =?us-ascii?Q?tMSoVmZEqxF9Qe8JDEdqow+5m8Ygmx4T8oH8HM9iw8yZs6bl+aFXvwziU3rl?=
 =?us-ascii?Q?InfXXcYa9uJ0r/w1ONukD0eX2U7DCgbSGzpsKM8flieQqJ4J9y3eQdzKpiGv?=
 =?us-ascii?Q?hF34siKDnPiQ0X+h8LXCpZ95YPrFkkiunDviIKVHYwOqFB+M9v46GloGHgjv?=
 =?us-ascii?Q?yusv+7Aqg/3DUGqTFv7M4vMaNyI3epI4asrpg3VJMhJgJYFYEF5iI2nKmKAe?=
 =?us-ascii?Q?tKe9j0W9+R5cKOguWejnVN+4vIDYUbZIzHaNdwTIPuAHo2EU/Gvx7NLjj04h?=
 =?us-ascii?Q?KCQdfQTqsoJ/zVbXqEAKbK81sWrslnM1pvmURBQjSSehsN8tZhF/bAuMoWD4?=
 =?us-ascii?Q?EK74keNMMneThV2n4AxvHl+QH50u2ffAwDVfK7xX3OTl6fn/2GMa0FD0jyMf?=
 =?us-ascii?Q?BipZCr739uKIGcoW0QwlGHLbCxmO9XTSWtAwywzUme0hqJo7DE3nZWcV8DQw?=
 =?us-ascii?Q?z/4C4ChPGhHvLpOfPAc3/RLOHfyyETOb2Nwe2L/B8OAhXnNHiQTunCrvC0+q?=
 =?us-ascii?Q?qootIsxxypyAqISUdjKja/C7EpXbSpTDIrIFU/vhiLK/JhHEY4D6vmX3jTw7?=
 =?us-ascii?Q?n1XQiTJepKx8KlgBEmTowau+1Dert6jmP3YLS4hBVDOaNPwf1xPU7luwRY7R?=
 =?us-ascii?Q?rRTtOjAsSLQ1sT/dOs2gbAMUJIQIzxkAvcHUwdxfW1W6uRikk0ttABZzHsyC?=
 =?us-ascii?Q?sJcFE8gTC7nYhVCXq85Rt6h/x4l7l3THYu2KBHNfm51KRsFo9H/wDjqJEpHK?=
 =?us-ascii?Q?JOA0Gl1Zuv+vuEZ5587CxuBzwEJFMEIml3TSpnxO2R5KaI9JOq7I209fC36P?=
 =?us-ascii?Q?P76AwvZ4OF5rOvK3P99cmhE4JBBGSXOtfLpNkUQEzrlH929V1jcz5PLaTyNX?=
 =?us-ascii?Q?eSNe5jf3RzuMxAv9AJ7FEkm7mSoBnYey9uz/ikgXeisIjHzPv6+mV1Xh4vfV?=
 =?us-ascii?Q?DGHuwmJITl1fsTyakBHu1BI+CD2qP5J+kyU9q0tUrkHb/mz3JLNzn08r00eS?=
 =?us-ascii?Q?QXt32VuN5Ok2TxakGoEB0FrqFCTOo5Fsu64Uz2ORGH1QyZsLNsSV3XWJLrqD?=
 =?us-ascii?Q?nbnUZ18r84fJxxFLzGXC6I3BQobLcaCKU7BkU/GAZcSnUnJFb20LsyFZvDG+?=
 =?us-ascii?Q?1JrGNcELQ+jN52KvqAdphGfFTZLPL56dGtHbpBhQawyhTtOJCOkFgtOwIIMB?=
 =?us-ascii?Q?+JStQpK26A53W2c7vPBqzotKf2et?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIav+dCJmb0Ya+Er7DHIvTNCRGbaR8ot7BIL3bmf6ySEr6KcjSkkWiQ4FH8J?=
 =?us-ascii?Q?HFh8m7W4wWY49DhrgkM0lPUl+o7YiM+tdq0RX4RF/hLSI9XSAF0d4VfXcP3S?=
 =?us-ascii?Q?/rT7MwnsqbkIuVV1gqvvX5qpxrnBHS8nv2m6ZFeX2cu2Q0QqmtQzycCqUenQ?=
 =?us-ascii?Q?ujaiV31gmTK+EAeNNwhGDoXzI9pYqLqQ4ZeAOLr13FShkk4vuvzqiZAjYWi2?=
 =?us-ascii?Q?GNxEd28tX7PGh9Ppiyf3c1i0h7EpYnfaI7tTg9RjTNrfHArT5JY2B7uMKHbR?=
 =?us-ascii?Q?PkpUW01XWnhqB0Bv+XkcKNJ8OUL0lROMwh5EZDz0fw0lgsWZD/d7vpTPva2e?=
 =?us-ascii?Q?rB0T02I3pcUHqEw7Ss2wv+T1/9lbAmNy2KoWJMCMZHGnuhvZ9cE7fYmuwTdx?=
 =?us-ascii?Q?LzOAI1aO4XrWqwzKaoUJCu9RLWGePu9/P6V503DUMXBNvqcGikS8Dsbs6Yhe?=
 =?us-ascii?Q?pm0sGyT39LhZRcEwbHnDGEVBXHZiQY2jePs0oMj7y4cwZMSASnxOMiaFyo9H?=
 =?us-ascii?Q?6Nho2ajEaDq9nWOi9ocS5vOZM5lLQme23hzk+bQAN4aS+HttBb3PQvQFpbGN?=
 =?us-ascii?Q?vNAcmaeLrNvqp7wSkn/f6M+h2ml6SY+hY2nwEuGLbDINi1JWM5Q+VAT92bd+?=
 =?us-ascii?Q?XyU72qGF5NqclFz96eFYu4asj3g6L5L3mhLtmbiFtJ7BzcQ/KjWM9rwEwLUY?=
 =?us-ascii?Q?Sbyuqrn9WQ2EdsxpT60a/pfjPMQSdnkxQqtyBfeIjEwjB2zz+LxDxXq2QMdz?=
 =?us-ascii?Q?7OUxVzhi5/Y88iM5xmj6RRpZIXvYIn+07h5HL/7fITMZW6gAjQmhvv8aynJS?=
 =?us-ascii?Q?vrjvvzyxeV02BSqYor6PC5NX07CBgUQJaWeo4sP/gMTvRa8crgmjrSKAJznl?=
 =?us-ascii?Q?NDPq+6B1Uoy5hF72M8f0ZWmaKzQRBibkyAfWWE5PO3YLIeHVaenfqVpng5HP?=
 =?us-ascii?Q?9XrXqGdHLQRZ1kMyG84N9CwsCzk5aahrcvYWSAwwkj0IeI2oDp2K1qt987Tv?=
 =?us-ascii?Q?cfw8ZQ+RGCQlJjUE+ljFLb1/07mcACaeJ5Fyi2kzFCzCXXPQtZNIAaOPF0hD?=
 =?us-ascii?Q?YV0TWzHI59wrpAw9jST8tl7N/8uoi1/jQGJNsp1w4BAYP6y9i4EoQcOOUs1+?=
 =?us-ascii?Q?mqrTi+ov0aphY2Ne901kuo0agFXwP8UdMxRHn/TUWDsh9WLAbw2HBI5BTC8c?=
 =?us-ascii?Q?b3AdUF0v13rUEE52F7DO0/j0K0oxJ//wZDwSYFrgwEazHDxTcgbr3cz3swfS?=
 =?us-ascii?Q?qWoZd+vk/texMuL/kZM8ejH/m6sOR43j3c7GR0H2Dq/eyohzumTmfHhIhuAd?=
 =?us-ascii?Q?GRYxuT3Wzfo2nyAi7pvVYvPweG+CRTU0LeQdXseD16xP9rNgVuxF7B/5RpeK?=
 =?us-ascii?Q?1fvDipC29j4JsRiVrNyyIOJk87hh9CWZ0Ww6ssHObC5/ZzLS1vWDlD7U4RZ7?=
 =?us-ascii?Q?AwtjZ+E5tt0CaJ1Is2zSkrJDvPDAB6jVvcf7bHTLcBd2MHkEtiUd7gJoJ9UD?=
 =?us-ascii?Q?atxjUODEEqveLb3G7KCn0O2EiZjbOaG9tDer7WpAvlIXtl/FQZLhprbvKm8y?=
 =?us-ascii?Q?7rLUTtsibOxjqhx6BX2YHW1RYX8WFbr21TJ2uUsVW/3eK4RHPyAqjQS9PvRr?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CL6Ni4rmNcpC1rb1HaI1t1eOxjfVzJa+GiGe6+3UQFTJWYed6FTZoixGx0kMkzVgLrRWRxv9es77jwc7n69wbVkd7LxDwEwtVIIQMfM6oW6DHa9bAx+6bfSDwFyl3u5+rkT833cAp8KxWalqi5nbT0f/bENqWZQ/0BmSk9ZbcXQsoFYXEaBES2k4ZwmRgZFdHcDKmiRJQKgiQaK0JhlPz9ZOyufmBw8dY5ceCKabZib2T9UK7RlzWawL/EQNWxUwr6eJ+KHigs5aQWRLlQiPjNxW8pqnGISm+IROaz5YzxZpDFX1HkesXoAYYobfjP+BvNNPhyLDUxm+qU4nMMxSK6o0x1N0y57M5MXxBx+L6W6PQkV4t+6sUz+1vsnb7AemiQ/SyECExtu1LJUk6wbBI9CdaX1oQl/26RIk+Misd+j0RgNUMhgNS4aGjST7LbMd0CsqN2UB6ntrzFzRwPGogzZnbBY8Z31dNH/6M4ppyATh6uj055AjxPBwm9uZtMttLO5lfKQDb578Lj/FP+lUOkEZm2/sblEvBd64dQGlXocGm6env4YJ1SbTtKt8v9P0vcbJu0zeXI61PC1k/BCx5UNpE9+70+Q4+PTJpPaPVPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b772e176-9c81-4762-e837-08dd5759c023
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:34.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcDsZZLEs7qDI4wtouJnJ2rK04K7HK7MUd7wJSaSf6B4lENwMK0XJxt0Ky3nZJOA9962q3PWM/ubH/OVxLpE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: 1yfz2xJjFuIgEjg-KBNE1UrwAXsjNA3v
X-Proofpoint-GUID: 1yfz2xJjFuIgEjg-KBNE1UrwAXsjNA3v

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 0eb2670fc6fb..3b1b7a56af34 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -788,35 +788,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -825,7 +809,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -839,7 +823,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -848,14 +832,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -884,7 +868,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -901,17 +885,46 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


