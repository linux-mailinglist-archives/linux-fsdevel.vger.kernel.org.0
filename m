Return-Path: <linux-fsdevel+bounces-46476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D92A89DAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B304617A05D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861929A3D8;
	Tue, 15 Apr 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ix38LpXv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OwC+Wt0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DB297A42;
	Tue, 15 Apr 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719429; cv=fail; b=CRwfc4vy1LtgMsFj0Y0GnQ6dqEa5Ca+4qNz9gMCM8TlbTXLbT5RRYmHMeemcSLvJ+LoQBD5A69ZUEVfKNRyOiAhgf0NzqTND/dEOBvIdUKC35AyrA5c+PnNIhUfmwNMqpnmpEB6A5xEUDcKESZ4/5zEBuPqWD9zbg3bM/AhrLek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719429; c=relaxed/simple;
	bh=d5yCf8JRP2BfzZh5/5rEeBNmu1S/rD5zWnteV7p/pCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQ8SErpoVG+Ye3Oxvjum2LzPjqF/hFKGsjfW0qK6SbmCTl/WatxzSb1hO8qhBrh0A4XDleRSvTTsEhRY5hpGjbAku6DgW7BAEkukGapsOWiVxfKZeonRKMUqO/KZIEBNHeT2Mju13S3767/eHk8kNhF5uIv/sygm9qfQnhGmRpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ix38LpXv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OwC+Wt0A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6g0GI021298;
	Tue, 15 Apr 2025 12:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RSbfSixaIwWjSP1CCzi/eVtTJd67PSLpI+WWNVt1x9k=; b=
	ix38LpXvN9oK9huHk6+5PsSFo/pLpYV2AA3goWt98e0Av0TeUIaDTr0hdJzMVajU
	W6supvI44ee6qWwFB1+exxujxAPVEhP9sRLEm2/w+IhloUPE6VMbJSC/+JaIFRSS
	oVLTxLRT24mtKjcx7YcuJs9+kCq13DXhQF/tu2MeVWWpGN8wZwnJ+OaXadBtSEfC
	5Z/HmkgpzhyCVRLktCMfOdbRqAcz7aojEp2wV5gnLcTIFAdNpYGKBMEhFcIDKkEr
	PNlAHOEm+0Rm8Yez7o1HTdWjtZmNee/YcJpVHzFS9yY4bA8KNNDo346xejklKpGy
	IZq7Y8B7DQ+C6ZnOKVjpfQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185msf8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBpWCE005917;
	Tue, 15 Apr 2025 12:14:57 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5v5nwb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvy1v5wDTEZCLZd7fAZLaZz6oV8Wm8jId/JYP0Jdzv3SgdlL163C35IfU4bNjUJ91khciJkmAcgaKrEaUjzStGuvkq8+TQzKfr4zKAedpO7ccHObxbIb2QCMO20TuwNwvQMN+cyM+uO5LaCbLy9Yvt3NYSFwT7lF/VDgqMn0uyvjbpwHmMm6I8O00hgiyMUHPds0dY5n7/c1XL1DoLI4oRvqOm7O/SSbMtBP2MMpg9YNy4yQX8QH+R55fC+L3MZWFdkIwBu9Vxio9zlQKxSvfWZh/GgWT+68u6H1EodloXCHz2RoCGeLIuiWokKWQU+uHurYvCChsBeit6sEmo9jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSbfSixaIwWjSP1CCzi/eVtTJd67PSLpI+WWNVt1x9k=;
 b=li6UGAtcYgzf/pbL8N4ZZ4Hm0w/uLMJ/syyA4rIRKnri3ejuYzNGrYbLmXS2LaSfXrj5t6DcKeMZNAbW1rFataADjJzPyjZDtsqHE6mC4fOkOqEhjOWfncnmAu/TmfNRSg8eE9/wTTK1/KX5IyzTg4WqTqGma1DlMw0P6J4SjRBGs2S96a1YN/t/pls2c6ciniph1KAbsLkg+iyUZR5L5KE3excTjBl58AEAWNVgkEeOHg13/eX37TdS19f1+ex3+y3DvrTqwpiZzgnTYs40we8RSDNLxgRkOomfXT/wbj6AoZsZZCQx2TzxF3F9/V8pklzjAfZ3N5oy1b0fAIJahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSbfSixaIwWjSP1CCzi/eVtTJd67PSLpI+WWNVt1x9k=;
 b=OwC+Wt0Ay2zIpf8BhmYTtlyQt3b2N+wP5rHsrXNzsOaVUYm7mfy9wqNPYM8qyT8cKQvwjbGOnEU2CXjstFqdxjB0XbpU+kQ2QpxNvLau6w7Ac8IKQD3QxG+yj2psp05/QPNjT28xxuwTTSU9eSBRDRzduF/Ei+0fEGZHYsMlpvw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Date: Tue, 15 Apr 2025 12:14:22 +0000
Message-Id: <20250415121425.4146847-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: f797d628-27fc-4b8d-5d59-08dd7c172181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LORVigT96QbVKHzBDS40O87Nk11HYp409FH2UBl4oSussgvTeYYvRjwV5Yc9?=
 =?us-ascii?Q?2d+Wi0nHXzFozuolaIce1BaDIEjYWcHHOSqMth54yv0MKjZP5wyeyELhle75?=
 =?us-ascii?Q?kSclEvUMhXd9W4Z68xgJ4yRmds6MXAFHsc8eIhSc9lSZJJmyiU9UzQgib+hB?=
 =?us-ascii?Q?XUoySpRnAQMUzpW1z7yzmz9cArF/zFgdRjVagQdCCdU6pMDIxe30/VyPfvLl?=
 =?us-ascii?Q?8CoBmfEfvfGYdmm00CCXclT2hne4az9mRLRGYvz/a0dEAPUo67HBcTPSs9lB?=
 =?us-ascii?Q?POiePF+pkhIBVgvirWd9ACmnZRbhuZ+ehJLPqGS0Zir7j4PlOLmXH4YYCSmc?=
 =?us-ascii?Q?Y4DZtfcSGCj8ErcrSM18Xl43CFYjKHGNJ4ldhQJyyftsjowILbi6ff8o8AR+?=
 =?us-ascii?Q?IMPqsFAJiof1Cy4pT81BqvpLXG8tGHItPDhC2uEVveG/s/f6YycT5yFs/Q5J?=
 =?us-ascii?Q?91AmlO7IgIldoWhT0mZbZuYMxu3g88hRr8+bFEquOuJnSgTSMZK+UTpgCgW5?=
 =?us-ascii?Q?paRzyif/wi4btF5sUgJalPzJWxHbDu2Zh2SncMN9EgyzKn6l6EN4t4sfyAzD?=
 =?us-ascii?Q?QYDo+h8mAnitDggVk259wsmFhUh3lqD/VvxfKTXm8cstCjpSoezZN49no786?=
 =?us-ascii?Q?BVpaBk55RuQ8adVSfg4169j8IJ070qVzoGz1GW4bRAIsJNadWztW/PMcVh0X?=
 =?us-ascii?Q?THzLis49y1Yqo6xzhk4o/DBWM41+W+TGF8nhyin3pbn12pBoqUv39+ALQJb8?=
 =?us-ascii?Q?DSHbSawyd3TDiZ+58lzpEcUbC+uxL3N2spFaJT9XwouUmFi6Dq5Z08Qu2yUs?=
 =?us-ascii?Q?tpufLlR5NfQ1fh/Zgf/0jvC+CkZC6xOc8qq1fLZ2gznlP53YFBhFv2/oprLE?=
 =?us-ascii?Q?fee5gQXA7myeMPHnDHeEgn3heTrI4SJ6RA3r3uhX4yEftjE/H5BnzCMTi9cQ?=
 =?us-ascii?Q?WsiJwqjV5ZY12f6aJ8sgX2rKha/TsxyS6vUtQX0KTekMznZs1FXsa69hOwTN?=
 =?us-ascii?Q?XYLpd9Aew+1gMNf1cJ9jos/a0BvAnywuLJPFIdAGNjqtz19M11bR5+eBqDnk?=
 =?us-ascii?Q?xUSmSMHslYM8UbHheTAFQ0gSScy4uQIJ83hThzUOZh8VkqYkEEb76NFNJe1G?=
 =?us-ascii?Q?1BlwHiPqV8ckYyzx5GK9dQssAYYSc2TxrokdO9tMmEzfMbwvU56ONJtCSsUL?=
 =?us-ascii?Q?Ed1VYTXAMr0YzeeYNnq1+MkQM7N9Wz/s8d70ulmWhMHn9tXNglgjUA7Dr4Oc?=
 =?us-ascii?Q?FyBUOf3UKWIN8hpdWl1FblveTpcLN+vyt1GVi5ZjrAAR8hpKKAI8qfwYclQL?=
 =?us-ascii?Q?tJ4sNMScrpVsxR01jfTil6Xx4xaGyEqDB44yWy+k3E9XWmUw+ab67Nzs9XhK?=
 =?us-ascii?Q?0R92cm1m0k3Q/I2Wk0b2elgW598/czrwbiVwO0pZ7ijmmwsRJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alRJhDUIMXMY8Gz9j9ZYMl0aThmHvJHqgr2ZCSj4JcB11Z34U3sWANqCUomh?=
 =?us-ascii?Q?skbFxbWoAyIJYeJl/7GY5FMyEVQ5xXQs6pjFUpXrxbnxtui7KpZCf6da4nLi?=
 =?us-ascii?Q?fTCoDytXu/U/C5tA20fPWgE9jh2o3fDsUTLHU9RDHtQ0AFPN74I6+lG4z1G8?=
 =?us-ascii?Q?/+TCPZxsrVUZp6LxuUassm71Q1BUDZ/CYN+4+lfh8k9XYP/JyIDvI8G5NG6U?=
 =?us-ascii?Q?c+HGWqm5NPuoKXxdUnjGvMUwfZnsC1JpX1KgLBJITvBHAn7B1Hql/tFk3VZN?=
 =?us-ascii?Q?uzdjCOkpWxX0gwnBtQHNDnYfgV7B9cofpyRD0nLyWIsGXoYq3zDDhxF7Sr1+?=
 =?us-ascii?Q?fV1IBeYy26J7MnRBr+LyphRzQSIVnnfiETnyllt6fXZNkjJ5BPpifpvw3p3i?=
 =?us-ascii?Q?1riNCQZvzmwIXP4jC88/8uhXtiIIVpys/vb5XyGvlUSrePGpG8MeJs5h3Won?=
 =?us-ascii?Q?/YYHWWTc9wJVaLnGrLBochpDjxQnoQT6R32uZBby3ERroeLrDWHx9KIChNSr?=
 =?us-ascii?Q?HQ+O+TUPXAAXAj6yjwpFmfT6hJNKPtS+h3r915O4bkbrvf3jjPjyHQl7wreI?=
 =?us-ascii?Q?0z4+QVujOGE0V9W/5UlPCVGK42J800r4vfv8oU/Omt3e08IT+rQE55h2uQTC?=
 =?us-ascii?Q?24Vv3ADMZFAH5g4NyYMlHpbZOrpKQx3vM/tvY9DJPWvxx6Fl+1MbjrUdo8ae?=
 =?us-ascii?Q?YlJxdm4YF0Lm2lqLp4jumhKm3N7qRjudotnM2XjD2ZlgQ3c4J+jqcH7go6zZ?=
 =?us-ascii?Q?vlcHpMlKYYVf2+ty49wNDnjZm2PfBQjvJ9Eu8I9Yy+4KI1YeVp+nN0SwlNgW?=
 =?us-ascii?Q?6E7OF6wDX31DTBtwoITwSx/SC6vsRDJ61fiA+9jESSTV4nk7oU50O87aezw0?=
 =?us-ascii?Q?I01qwuUuVeI9WYOWybpmFOjGgDIRjIIdbOJbCyDA7ygsu6tV0MPwr0rIq1Cj?=
 =?us-ascii?Q?MYZz1BCHl8mBXEpCeDXZdDNs+s7V2wXR9zAd3yVkTn09fBpd5DNVtSmwZyo3?=
 =?us-ascii?Q?s3QxVtZLgvt9NiK8cU6a0qcaG5c99AQ/7Hr7Mvq5qvVTa/AtnIjZ2M+2TTTN?=
 =?us-ascii?Q?RfTaRTq8aqL20AQC8Eb+L/aRSkLMw9mgzqVi1quNJHX+vw1kVluhSrO/oNlP?=
 =?us-ascii?Q?Qk/lZIWQ4V8TZYj7BMCT7Dd37rNUARges1a5J1D2KK+WjYA0LQITGx4RXycT?=
 =?us-ascii?Q?AqmJcFWkltLNZtFEO4GRbxer9E0lv0z+0WQ2q61MmSQCuuME3e2T8GF6rYMc?=
 =?us-ascii?Q?iXOktJ4hx2g1iAeVMQNyeiFuM5SjN7TMDjH54UrrYEBQxSttJvFXY54BlR8G?=
 =?us-ascii?Q?gf7zJJtvcGUB2DwzEjnt5VPkPhklXHudkNCcNOF7pnqhTZlmivDyF97kXu3k?=
 =?us-ascii?Q?RzAMGZRTkOODiHjllI4A6/Q+zaQ8BwwyCFT2Dk8jzJrqUEkIYWSg3U+DvFeA?=
 =?us-ascii?Q?Fd0XvWl0Zy0yHiZNS0nlzcNq0QTieDf1SBmfjU3Yckj9ckCmw2riandPRmqT?=
 =?us-ascii?Q?FU/wm671Z6ao4hW+Uq9/CZqjiZowWXj0IO9D1tEjX1wqqaFRTxe7Z2p+x38C?=
 =?us-ascii?Q?HlvHIJBt9MwMklPNV+aBI+fAemsBQ/BbnCcYGnmXLLtWoRHsJzBd1mBT8mxC?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f/KdewMMj/j8ICmhJo7U8V4+HzYNYWmUJnWhNZFB+TswtohtZHZ90kxknDSjVz47e3m2FYKGZthJ5pMndh7YdKYq8buGkVJQT13KREKlg5ErcO81ybMgxSE58hs1VheZN1R9eAipzzULOahhu6R1uauWWSDEklEhdGZF8z6fcqSaWDddVGPeZhjbIYL/2gSXBRuqCBReCF9dnt9AKDY+eJcwfyEBnb2H5sZFoAZ9sYRRUyvoSpU1AyupKVfpU2hzLiGgGYhqF4zx3XVJNcZptumU1L5tc539919r7WmycIcAXHuGd8HwSxsTQQASCnyocIByJuUsKKorVx3F0Doakntf2hU9bC6VLC+R/uAX3YRAocM6ByH+BjcMwdS7VdV6KQcl9TezdBnU59jGYS85sBPCbZ8IovkOSae30clfwAspfFuZw3SvgP68hC1PrjA5YldnF+GKMX/tOjDoMXJy4zm+HsxVpaI7TMCDVYH+bPrx+20s1HrtCkaGD7dKWTAkn7dQSbNChlwVaAS5wvQt3vZ3M9cL0WzAXBVAuXWDye+WKMz9ABWW9CNH6JWiN6NAAh0ZU1rWYbEIDwZnFVmiXgIRpu/WMElBj/eJZA0WEuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f797d628-27fc-4b8d-5d59-08dd7c172181
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:54.6126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUMbdbQZQnLlWMs6IMb1oodMr+if6FZ05CIe1g4+5NUmPBPZepRmaeygdm4XB5rWITGRClWWAZAnfjus2sI/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: DNfVSNxR8gmmHaoJSPCjuFknhwBnNSz1
X-Proofpoint-GUID: DNfVSNxR8gmmHaoJSPCjuFknhwBnNSz1

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

The function works based on two operating modes:
- HW offload, i.e. REQ_ATOMIC-based
- CoW based with out-of-places write and atomic extent remapping

The preferred method is HW offload as it will be faster. If HW offload is
not possible, then we fallback to the CoW-based method.

HW offload would not be possible for the write length exceeding the HW
offload limit, the write spanning multiple extents, unaligned disk blocks,
etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload can only be detected in the iomap handling for the write. As
such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload
not possible.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ba4b02abc6e4..81a377f65aa3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


