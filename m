Return-Path: <linux-fsdevel+bounces-47388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE90A9CEAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4321A00204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663119CC02;
	Fri, 25 Apr 2025 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZGbeCPV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JCkNnGI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BF1F4C9D;
	Fri, 25 Apr 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599614; cv=fail; b=MR7DDV+hRzXlR44nquYSNFRTukCaPD878wN1ei/9RatuuESmoqa+cQuKYFxwW77iqRk6Ll7Tbv9V3ZjpBEwCFVuKL2/BZCSYRRmsDIbvROLI2CAq4FEbicxx0Eid3MNaTGvpS/C0RWM2OZjsX2zmqfS+G5fMPf2HYAjn0+O7FyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599614; c=relaxed/simple;
	bh=jqm7fYAYhKXt5ckh8xSbcWh9lpispFEL46zpzLPsbgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpf5KR8ln3CDwLyuVS/xIYsDiU+Xj6fUjPsZ17LFdhT9QS2uqNwT8DC75uoiB8l1Yga3u8S0Cn94LVNtFUwF5RV/vYApqYJctn0ZNlDygdPMYeVRxDH9WCLrc654F8weLtLXNOFL7hEfdlug6DCEH2o59iXLDJi5X4xMZ+zspQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZGbeCPV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JCkNnGI2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWOCO005244;
	Fri, 25 Apr 2025 16:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NJVjcZoDAD24LVZrqhExw7tkf0CM1ST4sbIgzXu/20U=; b=
	lZGbeCPVDz395/JcIb9jLKYV4KVDFv2nQNgdq3xq2iU77gcj750xmK3jUeiXvU3u
	oqWsGkruvxjpvh0rlqH3lGptVWSo35Pop+adtQPWvnCjMO97XqaRvaHnXrg+0Jqk
	hHlLZZXDq6yRM5DC7KzhSWJxr/uI7eTF1Fth2ojLysGKOofy8qp9CMnvlqJEBgXy
	NjLAL9ZJrwlQCOkLyZ8us0xDwRshEKRB8czU4zbcbquZloiN8CU1EO8c/F7aMOhC
	lQsZovHCPXcgnirKzKxikiU4Sc3x8S9Q2TVj5e+jM3X0/rZe2pHy7RTwxQk7zzLt
	7uLrcAPpPzQZy09Mvpskrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFgv4B031703;
	Fri, 25 Apr 2025 16:45:54 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsyt11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ6iG9Fz8XMMc5MribsxRTwuqkQYBMf/m3t6UhlJUppVO8IrQWsfWb+hjltsuRLUNHI1VNxUiq40WszXdfDB7EoaqpfZo67mAvqfct3hcDrOmiZQ8moNxsnHRYC0bAfXvsKV5CdoAeWTxm7z8UXMsnrp+zLrjjrkppFMwUBfg2VLjKRJmbS+6/dtH1wcYEHpJIWa4tBKIFgCRJ+Tg0uflJIKKxCFJR1tbqctCJO/dFlUjz5SGc0YVptiMbVyHqS6FfLD/XasYunozX1cTEkFb5DDVXKfY2Ruhm3kpRTc22z7OH4Znb/+Le+1kuVevgeRdqoBNizsHLMnVCvb7AFDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJVjcZoDAD24LVZrqhExw7tkf0CM1ST4sbIgzXu/20U=;
 b=bqKjKbQZqPWlE+7WHW6M35teX+oUZc5Z7NqOxhGBM0p/wuIWzpVaZJzqRJLXsRAfXo5ZCIXqSRXbma7dFgGJfIvacqW2dXrcxik2w7oN5Jco5JcAOTnnk7uynusSA+e7AlK6wrflcI8RQrJ/UafPBYnnMvdhIwUBwCtFqjQID1khnTzSuMRp4lMnJW47R8OqAQdJ5QvjdRqnf5NhPaQLp8ISc6ghjP9eK1J+c5xQtu2oCrTj6vKKNEGCR/FfhTmFoDBtKXqGD2iBUP0VMdamSRFTMx8T7iwrdgSMN9ORL5Vj1LlAK1MPH8g6zP4GKFNhY22Zxa/dD/pWQaBq05Cn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJVjcZoDAD24LVZrqhExw7tkf0CM1ST4sbIgzXu/20U=;
 b=JCkNnGI2A/WCAnfAfNmxBXlVrurVpNGVMfY80T/n/z6sggCqGmRuryP0mkbrPp90KNH7poz93PfVAIxT6QHUaCCYLul835XbOPHrliR7M8+/OSzFi4UW0M7+BBZ+nxcXBcKd/S+tYSYAftJuvmnldW1ZQObsjOIZSgRlCCvJrvQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 10/15] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Fri, 25 Apr 2025 16:44:59 +0000
Message-Id: <20250425164504.3263637-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: fe71ae54-0353-4386-19b8-08dd8418a2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gIrWCfPzAec5O+lN2AZWthrfjMzKfQ1GtIlidMAWD0vzFKM+9Y6BsVPd00QZ?=
 =?us-ascii?Q?3oiatTcOp1IxR68R69kL+GrA0SbcwF2VywaDtPex/2bxboJktIGrQ7908a2a?=
 =?us-ascii?Q?ljVpFQ73aaf1BcuEsZeD3fSX73FnCqm3ml7ZZ1aC3YXwrlmcOzXc7Ey3HQNW?=
 =?us-ascii?Q?Y22INlgLONjcAMl6Dmovb963VpWrPVVGiDn43JIVnEYE6Q6Xuo0nloQvw7zE?=
 =?us-ascii?Q?el/Gpd/6CRg248YamwpqRmQbjO/TwTQe55fI6ApqG7jtlwkriJJhJGYB8uvl?=
 =?us-ascii?Q?rUgUxkzIZA5TKQ90ihfDj9uuh0c6OU/GUlJaWFYrixJHUyk/3CCzXIRODddV?=
 =?us-ascii?Q?Qb72UYllgfgbKq9j4EyBEYkVY8tLgnxIv6GC/YcnBbr8tYg+2DUhT/yRosHp?=
 =?us-ascii?Q?TSp4VSMmzC3GueJ8u2dD4jDU9UO1Ut9Kfp8FSJU76Px72gtuWwa4X8vEcsMx?=
 =?us-ascii?Q?o158NlwDOJTu6br89edaFIHf+Klb5gzAH1H4G9qsKYplPO8DvAH6VBBbhoF9?=
 =?us-ascii?Q?P53d0M0GDsBe8jHyCX5rtVsBYnxB8+TUWeHRINoAlo53TT/KqzyKDuWljTTR?=
 =?us-ascii?Q?9Z12XaHMimVWMCwr2pCQsnBC6gTJbISSDYGohgceA9P+WPs2rzxp7v72dYSL?=
 =?us-ascii?Q?rKOlWXGWXDDY3RNgAkDrSw8BDTzpBJw6o8UzD5wj0t0hIfdQ2QP/mW4l2uX5?=
 =?us-ascii?Q?L910S/rApFU0JP/U6y3u8oBaaUx14acmu6Ggh4mB0iQXcz2E+1Dj/K4zRoPQ?=
 =?us-ascii?Q?jPn9RnJlA+yuy7OU4qyXV5c3LkUJtluc1JiT5EFouYZNCF/vPHTnVjrPtvNW?=
 =?us-ascii?Q?deJJU+a7DBxQF51t0SX67DSV8bNKUn5nbUwFh3t3jLuZCTUdzAHPm6VbT736?=
 =?us-ascii?Q?Vd8RD4sdJrCe3MsSHds9eD1vRguY59x+JNd2B+Q0IPerodY77H75Bzmlq1YD?=
 =?us-ascii?Q?giFbOjaVf6ZHUQLJ19+KOqmjfCw9HaBNafL8yvz6oNOaKLq064y1zsryMVPk?=
 =?us-ascii?Q?i3yX4L9cTD3MEwRfEKjy/3YuyXm0yfJq7fvN8DWhzWv7EfIaxtVRDKBxLBYt?=
 =?us-ascii?Q?/ceQAvVyElRlKU/Zp4ZGpQFSzcXqZVoOaGa8SbCzQiQda7zmdlGFW7xxWk0H?=
 =?us-ascii?Q?iL7oVqCcyvNysLtwsytVc3X2unnYF1FrhT52r80ICHvUokxJg2vbyCTBLiw5?=
 =?us-ascii?Q?tGjitZfBYh7Vghi0xzhADD6IPvALXfTq64A0mscnMg3Zn845NwkFI/FHxGnM?=
 =?us-ascii?Q?7ck0oXB/asSwxlponEUO+sH4u3Jh3mvnRbRtnE0ObLU4oVJOdHSPlV6aVnTC?=
 =?us-ascii?Q?MSVsu3a77DkOLZhKcXVOFVPeFbwrOATTqL1eWgGs5Eq0fJmUwEyMv21zAP3o?=
 =?us-ascii?Q?lleDyZJvHkv1kMvA46wJBt/Y0nNPE5/JczSGDG6qL2PsapXga6+mK0sm1+WJ?=
 =?us-ascii?Q?RfN4m9+Dk+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YMOUZV2CUJbGgnUHTSQtOvlTtza0cDodrZlDpf0WFyQ4GJ2fsaqrj8kvPKvg?=
 =?us-ascii?Q?gbxRb1uufssUU2A82p8U41fqX2U8sKDuFAGBkG2HMbzH0k3xC3ZYEJh+kFyk?=
 =?us-ascii?Q?pcrxipVTCR68PSp0wvrCsFlGp+6g7Usv6TY9A8GghlMBY8VvvM+Nr8snpi0Q?=
 =?us-ascii?Q?51xjUjL1Ev1I1au40knVN9FXyOL7LtWVTIZo7TVapD1zPhgKKA0lO7cad0+y?=
 =?us-ascii?Q?/rzRbUnvXpWukSWxu4HhibUXTbMUaPApWzB1rdGrp0h33/mIZIYHPlsikxsG?=
 =?us-ascii?Q?eZGoEOJGYngN0GX6TBpgGCxv56V6GzTFu+B9Jp7jpfpSO3T7HbUp4/Gau1qb?=
 =?us-ascii?Q?f1GMQXs/SRg8/fUo0VuqPGvkyh90v1GY+RUJcOvzdh5RqSpChe0KnV8LNMqG?=
 =?us-ascii?Q?TLiG5v0BjJnNuWZTh2Xz4CB+cOHEFGYPmBki0IBqUQmWCQ0G2VmktPONbfox?=
 =?us-ascii?Q?aTbGtzWF5BiUUYtH/DSNRgndNjuLvCppaMkla/qt/KVPwevyecLNYiUcEN90?=
 =?us-ascii?Q?eQouTZHk31kBEq0zvLAHRkKxchAVJo6vRfLezkDDe1kXPWPXBZL87YlTrihL?=
 =?us-ascii?Q?2lBlHX2KG+l7ZqAJnxR4Vumx3e8Y3apSntK3WWvoIPcqA5cN+FbDZN0BhrOi?=
 =?us-ascii?Q?cnwLY9jgxmJ6ocQU5KnmBrYIHPZCJkXSMb88XZGT4QAnZh7eyOBYssRTBe5r?=
 =?us-ascii?Q?OXgq9xUR/kuR6iSmJEg4a8WynmW4u7i4XuJrYcjy1Uqyuocf4shzThd3ayX9?=
 =?us-ascii?Q?r8ekxDnFcRtzvjxp2gVex5KCYIiULC3Z4fKBbhp44MFWu10n6WsJthi10dOK?=
 =?us-ascii?Q?+0cKOvc94aMKMibhGnP+mqeLXgUB6WYS4BTFHfHjSw3ROW62Z8LOfqTlEMYT?=
 =?us-ascii?Q?F37VhsQGpjIyX072uR/d5UKowfdtOSc/9GoV1MZUEpuLv8380s3arF1VeIhc?=
 =?us-ascii?Q?jl5A8hBN8hLXgBj5ZkXRsQiuCwQxnqshVpnmIWLrCucA7KxvhYMCkS42XHGi?=
 =?us-ascii?Q?TS8tHoP28rDb+6azA9ab8r+PetVFmNco1QCfuwbLSJ8v04+Ds9Iwp6MXHF+i?=
 =?us-ascii?Q?dZDFSuIDNsv69BuZ6MF5QbUV1XjT/hj8qsPJGUgqF+4bNGaqo2pcd7FolpvO?=
 =?us-ascii?Q?EmMoUpWj7mZtn9/UFQcSqek50b1IJyPZQsHHa8ToTnwwwuhlGb6YiNBYH8Ji?=
 =?us-ascii?Q?CvmuqZFk4/WP+rKj+0So2qWhOhvk8LhBM4b7TgLb5P3oCTZXSaP9A8XVLZa7?=
 =?us-ascii?Q?xp6qm4BYTu6OkBmESGQS0XTkqAw48X7AvifMgpEJarL3Bi3rl/WiYRgNrlqB?=
 =?us-ascii?Q?Mhk28NIgfTrEpAHNW5ghVpz4Zqc0hWn1B+TGNp6MG+9KFOZjn3UkCE3e4Boq?=
 =?us-ascii?Q?CQjntvyiW59CYgQFb3hfMeFmxnxc6+I+2iPB9Nn2zHrMqTOLCeQPUUfb7esg?=
 =?us-ascii?Q?QqurjRuvKuaFkZqV0e3Ch5Hvfh+owoqdNSz81kQUvqgh5dTwEyNL7zBK1sXd?=
 =?us-ascii?Q?hBqeRgpwW8izWpWpW+kFJ8HtEqRz+B3TL84Ax0bdzvlHk5h/T0wLxsrsJ5Vg?=
 =?us-ascii?Q?AkihbijRFzgIZ+AocE4z1pFgLGmex8nnRk2WmVYiVrIeJUsbIhvYZpzRc09X?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pPJeq1xRc+/f2c+Vs0y+OK1SvyIadG9wQaxUG8GCKU62F1Ej//FdGiORnoRjFFGeaH968ky6wHATlWMi0Upb7j6IYd8hGeT9KdSFuiWEf7DhIDZATKT5L3xZVWiTqfksQtK8IuK8wYfrDlKT0kQTB9fIP+xtRYlMMCgNc+au52+TZoUH09UMshKwBZCGXRpILf3dCyekxXGHaZ9T4Bt0jac/NH0GaCVnUwf5ypaNp10I9IDZXSq2twSG56rOMcLxFx7S3mekMRnD92Z0j1HS2OPG1TQ+9zCJn7BdYnfEajUeh2cgLkDZK2VqxJmkxrbPJh+W6sgmX/7afr/8nGpZG+UtDjL+sE3EDv1xZVfFuVMUk6Oh1iNTFi8cDLwbxB3DMkIOL9jsuZF71rd9RsU1CZTABuFIBEIVKpSms5WutVEeH2wquS0ypi57qve1Tm9KcaXzzFp1i3ivCD8amUQaKKlc6DEmzaVRBvRq1Yknp7bKLhXuQoEF4KARcxXBgeItTYOWdCOzlKTBaox2X9fdRGqiN9Irol48HSAPMOy380tqJJfuiIRP/Bsj3SZaCEkMHlU+O0JocAAyYey8cGKc92+h+Y/hCCR+gDK7VHqEDwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71ae54-0353-4386-19b8-08dd8418a2b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:50.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHtXn2nZ6pP3TI5HqmeWGPqKUO+S/v4xs2YAzyZFVCfUVhwKnbRkUEFgaC3N5VlQM36wGe1J3YhNjsAk0O18bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: 3AgQM1FhWiaNoAFCHKs-v66BqnsVPonW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX12G2djkt+dvR K3gH8EyYsxm2mIwuHEKUjqR5aSC9nkFZN+oBRxrbt8aalToJx+lyKS2swfzL8rR2t42Qr9ZAp29 DouWnIrY+XnEOPAiAUE6St7CUqfNCfo5M4xDOKQkmjrAAeRi9q4m+cqrqeDPCNMfcH268j+M5Ts
 HnuWEYalfu6dkf6GweyvNtv1dsvQNc8p+60OkefcC6zg6UsKsS4bf7TsO5Ay/wLO7FLJgZ3YtIC 0Y7I9iRkCyvPsA46J6PNBx8w77xWk5wropT3plyonQgCQ3vrshMo20fs2oAmtqjVu+hRixmaMDB nIJNrqJwWu6FJkS9LfDyX/pPXnhvBewNL6lKeQBtiVzT9/3DVfUM8nd7dnAdCDYzWWTcOHmz/dF m5y3QD7L
X-Proofpoint-GUID: 3AgQM1FhWiaNoAFCHKs-v66BqnsVPonW

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support
- no hardware support at all

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: various cleanups]
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 166fba2ff1ef..ff05e6b1b0bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,38 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	return len <= xfs_inode_buftarg(ip)->bt_bdev_awu_max;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +844,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +909,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
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
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


