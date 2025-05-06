Return-Path: <linux-fsdevel+bounces-48188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F824AABE42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3708C7A6A7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8426B0BE;
	Tue,  6 May 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rt1pfyOb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0KajI5jL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9A267B02;
	Tue,  6 May 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522331; cv=fail; b=Y9vQaZ2xut3AqDW+JtLsx2IZ60Pog1MTfxQ/x5iILrtJTFYs/vcCfQGXFs+7iEiEDI0s+LcJHgq17VjUOjqhxxq4NvpMs6SdObbGjBoBpCrmTuMyKGAyqOGFZ2LhJIFwSRZGnYsy5VXCjFXmqzs7CFvQ7SUIm2leBiy3recH4MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522331; c=relaxed/simple;
	bh=s9umRKRFfgTIQlD4/bOES5+0zQw8uME5kwsNul37vHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PrwBes4yXsM2KL6rf4sWHXlJrMtLncbxjhNoZoQrJq5hBOk8AFNL6wv5Mdu43lCGRJHBcB5rTw2Sqvq+cafo+N2ufYzf/ZTefiPuX0IaP1lv5XbkXVCJwaZHHpHq2lgwaFVH5er5Zd43lRNLaWlXFkASo2FBzH3/tzAYYPVIYJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rt1pfyOb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0KajI5jL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54682CI1003142;
	Tue, 6 May 2025 09:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=; b=
	Rt1pfyObK2ABPDmzZSPgWaXGW7HYzyzamEJ8hZlNFd8BN5wgtrDnYHmuluzsFWD+
	C2wIlSAdoG2QLUqhqxuhOtoYQexqp+qxGMpoMaX8BsNcuGv9fYfRqs6aHyZUpEov
	V6p0RPCnr1GZ/IBKi09IKZQegfZ3ngnXkfHDt7D/eb2BBsOiw3Gj41Mwf6Rcg6qW
	1uTobOhbHQ3GEWZlykBdJZFLyPDbBGJIvKomPz8tueRvE1/NAwtmg++rsbE5Wyaz
	lJSw+WtGnNBxHqCFzrQ3SQA3RmgDkw9vP0HQkm9sfSmdQm1S5BAPAwiwVu3FIqke
	TyEXu5Zj/h+o2pvMpvcfpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fejbr4w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468CAR3035353;
	Tue, 6 May 2025 09:05:16 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9UUE9i49iHNWTDPs53KHxFQMsf3tX4vvfZr11qBIxs5Y0yib0Xsq5E2tHyK9O1CRu2RQ5IE0SBKNkafj8EmX29KCWlOq5cuBOGRtjIb4enVKHRgXuMvrgjvMR7JddNlEsmeqavPNqTACtsQFdq/PzvxJrJWlKPqatQStudjvIISz7Xn2IiRkBoDbszEJIhFkTZ2vCms8QXyV43RKavNQ4xL6fASqUDYi2BHOYjJT9W//Aaji0Fa+7g0/8C6lAKRWz7SvoNI3Omwdi0kS6tM9B8uQGVY6zjGxzZOCLIHGT6FjxJxnJ85m1mTfDvzBZfsCCHryfPI6aQTK7obW5ydxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=c5OdRZ4ad2EX9T5GjB2j3j3+u6T/YUnEPyjUH7TV6XRMcoAOolVY8KC4pWGgTAKGqlAIihAGoechyNaGHs9jkiXS7YpWa8pNadyJdZ5W8b92p6CPH6FI0wsaGJve/Un+BLmt5xaln94S1D4QDkmJNWmq6a+B6AAF2CcDNui2A2WJsxpB5kldy306EJIKCEGh0vd35qbqA6etGbvrmfIv2gNLcEyE/c4pF45cKZYNaeJTKQqMFat9Nz6WY50zl8obZwKonT3rDv5c5cdjJ2NHKYLKoO1D7yljjUtLenrzoSZouMSD6Y84T6UF1pMyogYI0Ffts2lej3gP9SxRNZ3zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=0KajI5jL5GsOHbou9vsFTO/QvuQkHvYYjsaS7S+HEBZfSjhDnMrBD7n3kZSp307JOYrlZGmkl25WNTt80np1jsgMFsyQ9InOTxaRavOcKZfAZQUGbscrgQ798PV1ubGDIBNmaRH0Hs7DH5Knx4DfwIERkc8zsHTEA8PNtOLCOvg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 01/17] fs: add atomic write unit max opt to statx
Date: Tue,  6 May 2025 09:04:11 +0000
Message-Id: <20250506090427.2549456-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: bad0ed4a-dc46-4020-e597-08dd8c7d1735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYHQO8PoFxvjezHXOQPceDI3a3aXkhCf/Fhal/W3PVIYHtnW6frwt8N7udYT?=
 =?us-ascii?Q?Tf90FEGU0W1lOj19fpCgOqPJAl9P+BmWQWHWPU4UqgxTgE1jcz1oE4Y+viIy?=
 =?us-ascii?Q?ihaOmgjyQABoFmoqeNYJ8AW5BneDGk50FF6L9M2ZpYvOJsU57fnWAJwnXW2x?=
 =?us-ascii?Q?+bEbggX7CEA2P3DofuQiojtFK/bN8o/QS89BEy10IWr6BhtQl3XmO0unX1tv?=
 =?us-ascii?Q?M6qoJbQJTq3h2df7ar9CZQaueaHJqsRgtZo7F89L+KiyUsQqx00CA3/OC1q+?=
 =?us-ascii?Q?ErznSqaEobE3e5d6n+ePyIQnrEOq4v6nWZavRuNh8k62kalbjD6N8j2GQKmj?=
 =?us-ascii?Q?Q+Q0qfoR4lkF8cvVsvQP5GgIZlwU7hngVbgxYM8YS/i2PoQHMNACVq7F13/a?=
 =?us-ascii?Q?woXLOTMSF1R4ZWdrOX9ltJGDi6HxWGbr/tJU7raFZgleviJGJ0Eb9DmcjZcC?=
 =?us-ascii?Q?dn46sAxc8o+jEZ308wvYWlcB5/b85W/04ud+YyDO8Nu+pOWU0DEkW5m1ICFk?=
 =?us-ascii?Q?A7M2gP0GAQazhjkLbex//D2swn3YK+POMWVtStR0+mENBxH1Z48KzwzYm8VL?=
 =?us-ascii?Q?gQuSFa1+mhQKnXNOtWonuSX3f378TqRTG5V4B6YlyXXA2LteQCfsaMxX4B2S?=
 =?us-ascii?Q?atJqVj40pAIHtyTQpAvhAdrmiDU4Ktt51TrEG8n6mmtv5nO8+Aa6TwdiFTrM?=
 =?us-ascii?Q?2djZS3CdNqhKBJTuDHElpDH0FfhFzjU0G3oQJUUhxu1x7AFTyN0x0VPlX9/1?=
 =?us-ascii?Q?smf207HssBGGE6W/eW+bJP5Wms8+tYTmhq0Cw2Bnx5ZDmwGW1d3ziJaHAzUp?=
 =?us-ascii?Q?JDwM+XfWUCKIQyY3qXREaFp1JI5Skllb1c/nebGDmaeClPdhWjIaAJ9r4KhJ?=
 =?us-ascii?Q?dne+J1AzrsXVIlUY8HEpm/0RtWLsQCdsBBI6ubnLUAdZHMGi1lW5N8zSFifI?=
 =?us-ascii?Q?L5mEF7efzE1CbiW+KYL0OwUokd4fb1l4/Y7eoPIyMLLoRHrLGhMkuxXGJ+xW?=
 =?us-ascii?Q?b4qB4x4SWTvyzo2KLSzUumQkSpwQ3DP+Po0ennPn/LBrr4oZIKwP2EBAm9I3?=
 =?us-ascii?Q?3AiwhBd2c3aTAKjmQuuih1Ke5heBWLYMbA6Kpiq+uXx/0n5XfOvgQ/6pkecp?=
 =?us-ascii?Q?JL5woL8LarXGENX9bowmRgQetKUKD5gnjnqBoFqdCc/flceGlOGmZu3cUnRX?=
 =?us-ascii?Q?R+QLFGI5EybP9U2nuVJ2DDkvlM0moAN5dwEf/lIKRHOhKkRclMy+FmrEV4W5?=
 =?us-ascii?Q?MuTdAzDLpMJ1r9SY5QlPEwjCQYYgRPZ2VhH/enmXXZtx9iV4TJFyAItC6cxr?=
 =?us-ascii?Q?GdVwEgeZnzAEpwJS8w4HEm22Yzqfrkeuq0rktNbmTXj0aA/AqFwjaBOoV/BN?=
 =?us-ascii?Q?1ZgAWPcnS0k6wuUZQ+4gsEZ8eIcLBYKPAkrbJxRvUjDfkv2Lx8Q67ZHwsCZ3?=
 =?us-ascii?Q?H64geYWThlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMWw0TFjeEiap1H7zWZoRGUO09GtALfhcj/3aZbH5LZgPJve/JINwmPLEkvo?=
 =?us-ascii?Q?MAnhfsxD7FN8sKYUvz9QHoW0MrMlzg5SlvE4+gmEXQCbQq/T7WfDm6OjjHDu?=
 =?us-ascii?Q?NKYfVSYAXJmbpruYQNVcwEDgpOWQDDrLi2AwDT3q3ol63yuypC0cOtnhP2DG?=
 =?us-ascii?Q?dCOSnChUMC9XvKnKSLbGeDRz+c9NxEWRijsCwDDOCSrSxnZ4u6gIoWaDudTy?=
 =?us-ascii?Q?qKoG2VR9yHvTEXMfD15iww6KYUk4/9HxaXRmBfl6sEpAsxWxm0IWkjeYsQ5a?=
 =?us-ascii?Q?SX0Zv1B55AajGD+019g1psxJCuZQi2ro7GnQeIWJJYiVWuRIRUdE0YkXXqTy?=
 =?us-ascii?Q?cZh9EKMIRqdPHyqbDB0fzwqBKn1XEDApJrl7S+fB+MS8tdsSNW4+RFZdbeti?=
 =?us-ascii?Q?uKz+DtHuZDySu1hdcM4O9eAs0ZuQ+E4ctzBkKvZNyVICe/VSucthScYEe/xn?=
 =?us-ascii?Q?frUz+vZ+hy/oRqCbwc/uZUDs/wFEEfLLEI2NdjOzeaB8m0DP2h2Ls2LT/JbA?=
 =?us-ascii?Q?Gh33P/luyCgqXl14ETSxqjn7t+7yM9PRV+JsZ8B6muLW+Tl61pRIQ+ItzU1c?=
 =?us-ascii?Q?xkgWuCUemDG64b/H3GiqK/E/l8Dp1K3TINaS5UVuE4ENnchzbfnwUTGgbCgn?=
 =?us-ascii?Q?xjsJskwBtYLRP7mKGmPPDgSLk1a8OcXXAmF6KEShvbvhU4Tken6LCxb228uQ?=
 =?us-ascii?Q?6Wz268W18LOaap60yJlCwGYEDZIJKUt9x4XXmSHN7RQBdqLMVUvS8Va/iXhI?=
 =?us-ascii?Q?Q+OFbmVNJJGnqtcJ5tfTTpUh7Pm3C/8DJk1/cHtx9xPeWsNgxhpSjGRhgOdn?=
 =?us-ascii?Q?PJiufmtemORXujE6A1H+aQVf0dL7nVXFMHCPKDccXjpypZ5wbd+T+hdDexNb?=
 =?us-ascii?Q?YwwECC8efYFm689tmp9f+dZvJiFfbI861LLZuQv8vIB0zugbibuzZX6zOOGb?=
 =?us-ascii?Q?5hh8PXVVesg/+NZZ8tXbhT6dPNCHu2j/j6bPmsxu11Jn0QPvXaNBw2778gp5?=
 =?us-ascii?Q?u1fJhTzUE60YE66Xac610qVH/M9WKLj9XMmGVZgb49ACLadlT3jmOyzItGuT?=
 =?us-ascii?Q?ZMJF29ibfR8L2mhEmm/76Lh3An/NyZghu9K0eS9bu6Y3yqjVlo0ODUE/3SN/?=
 =?us-ascii?Q?z/JA5ViGzG9xJYycAMPSBv9bQTJgDytRez4viOVqriL3xj5HJ4yYmY9gjyRx?=
 =?us-ascii?Q?idaiGMJp8qckrt+91ZUGmXzEkaibingC3RCPGPc7WTzLcVIqfwCGMI2bI6nK?=
 =?us-ascii?Q?CRTfr1lT0iwvKZ9i4jpL4jRtXWvZ30kJkspAzzpnFzACqSAhHBHGx9QiS+SB?=
 =?us-ascii?Q?Tb4PSB0juenlx1EhP79GzLZlY1K85ZLMRvXb4El7nSFo+dKlc5rdeIwBB9dQ?=
 =?us-ascii?Q?h/gMBZwS/cxYXy58OEBYpoqHFt1xtGLhDXRKJyJYZ38hP9JmSqfFVy/n4cjn?=
 =?us-ascii?Q?h5yk5ux/ckzWJWxLybuUAcHonB85yR3eOV7yDCYnd4La//YYNKmdsSTskuKp?=
 =?us-ascii?Q?07VaA2NDhkvlw7Zc72ifQ+NkJ3gLuSxYlCVN7wzfdsGj1NA/Jn88iLlYDSWl?=
 =?us-ascii?Q?7UqzvTNztm4fgAvXrwTFMK658aI/LYEmjCDEFF+CKHAt55Sh3NNaamJbSmxq?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0q7mWFenJkdhYCswJumsB0Mw4ERFn0nnyzqYQDVG+n5F/LOeWLAX25UHdNKChy5tSBc8RN73DM9jnFT3mpdHmOaPgClgmZSRjLkCUYxmvJsitIU0F2EQFd24TDboX6sNRYxHf9q2vVwtOiSkeCWjAW5SKo/tt+fwT8Z60seImxbDInBLzRN5vdiofrd1Nnm4gPpPptddhdYrnGA4GSjRLGG2d9w5+pzCiu7H7P1QiVtyFlr/1QYx9+D9vmyC2YeJSClUnnL4tlE+ysQRVjNw4oUbM9rsrovSRpe4fZ39LLA8b5EXv4xe9UBK1qZcyfvYsd7IGu7xeCHIhS07qLPW3CaxTCvAsJeEW1xoAzpbQM2/hRPQbuu38XI+vYlyRYAjvLmGd5yJH695YLOMWLlF7tyrRdvNa4b9CPovIbrbee7NjZhcIh44CXLX2OHkza8mv+NtGi8Bb6GErjUDGkgYuiWbq968bK7pAm4eMxtr3gEUG4ckzqFZzoIFMPZJh8XDqeOtHp9HV3xUYrDhpgnI8weE2VKEbP2sxpdgdUFZmy+2qDLmCqkjl6tZTV+cYhhpnat3VIT/JPpxFWVhi+XeN40Jg5H3vl8NBa0S/AmVVg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad0ed4a-dc46-4020-e597-08dd8c7d1735
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:04.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq88098Ay4yMN29Mt4yf8q2Ue9nFOIQMrFCNhB0hnuCs2sWwtxMFL9E/4TejLuGZxw+VejcUi4ueec3s5roLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-GUID: nKP6bicrdlggxku_lsQqzFXFWHJ-Kcdv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXzOubu86h/VGp Tr/Ciil+jB5ksvLnMyUBenCjRd3bCQFFCNMfDkGHTvvhZwxY7e8knlZKOWoYDP6pqlTxihsj0ZT Hwpr7BlQx2RLs7gcrURHBuRpEM2IHzalDNw8U/B9Q/teSQfdSv/b84WSmql5FsNjusiVkbT9+N5
 7q6yuGhyUjHPBRjIiGIrc2SF1x/jDV4Y1vQq7bD5p7Fa3qrfaeDb8FS/3y2kPoLM+o2zdHnN8q3 LOncFAxXm0ZdPjfwf2NJ+3f+MnfTMPcyBnfBOnpBfaM+3Gp1rbG/lrAZ10GD3qC0+SRYxoFzSoQ JO39kdDYsMU1LuzHTPAmDD0Lo2nUja7DF7VRcs5U8CwVA8YlENET5m9MoQffvP9zvNnwHgKzfUu
 yYBzH8Jig+EDsZNV9rZf6hXMA6JpeZviirn0j4y5d0vwxsrLnrYIgi7rdg/1HY/JKe4kPTRf
X-Proofpoint-ORIG-GUID: nKP6bicrdlggxku_lsQqzFXFWHJ-Kcdv
X-Authority-Analysis: v=2.4 cv=PoOTbxM3 c=1 sm=1 tr=0 ts=6819d0cd b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ihQL3A0VzzIQ68P4lnIA:9

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 520515e4e64e..9f321fb94bac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1336,7 +1336,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


