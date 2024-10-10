Return-Path: <linux-fsdevel+bounces-31622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB6998F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5574A1C247F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274E1CF2B0;
	Thu, 10 Oct 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCa1iDt0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kACLuJiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299E1CF282;
	Thu, 10 Oct 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584176; cv=fail; b=kKO/hvuzg6Bbjj/iIL75o7d6ztk6qxUjC3EDtS6UUAze4WxYkkOOksOM1EZI4ZumxlixDboXdPdKhnC5ztUIoLqLTs+wnwQf1U5VV8KtTmi1Fx40N35ilGsUZgJxRj0Pp7G7fhJy+1YsIpybq2/KpP5Bt2CKZBaC0Zuo32ErgJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584176; c=relaxed/simple;
	bh=VGMkHzBs031nVI/l8gFbxz09UsGpUu/M7LgaJA0esxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=larffOAFcagzK7Eti1hkIH36+lVM6/V1CTDbETZd2DKUCAhFSjIUQzLootyI/i/ENFsGXOPmh5ey1FBHv6IjZaQlaGZtzxTGZ/EYd7AMaoOrHnFN2XOYDLhmiFCzDS8LCOsBSJgtS/OYxhouyrJVciS7GfEatdjr9c3D1ERHwo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nCa1iDt0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kACLuJiy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtdrn013529;
	Thu, 10 Oct 2024 18:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YGsMJ89EHfHWpqvg+1cE2NG8PMFwvAfUZSszICkBT4E=; b=
	nCa1iDt00ID9Pk6RcM3uIjqztm7WKbGNTs1fyBCmKVL1d4DqsVq6vW/Y1MZ10gNc
	PpwzCi5rB/oVCy95vcRSoAi53gHZ5+ms3pCQBLKJcD2h8qmQ7iFGp8YKbHqOi5v2
	pqszFuGDrcMLDtyAXh7JWJMZs1Ysoajprmjn78tf4j/b9CoTSAKKlbdISpnRaiVP
	pJCFcdzuGP6jcba2armVunLYH6t6GK3nRBjAWdO7FpIHbfcKPV/EFzpBuCqhXlVj
	MFzu2cDeWBbE1VNNJnOTMITElWCwdZ3WfAdRePU+NnYTO2M/Z1mnzehOl5Odb2qk
	+C/zmXsANqQ2kAQJXP7WBw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk8p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHG4jN017547;
	Thu, 10 Oct 2024 18:15:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwag77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzYDtgO6EHiM3MCh2cEF+Mj10F0QwKkBWq3clH0da5o8uA5jHDBtPgWjh1ljuLAxxw4O+1ySU8Xu+JEDwp1IGKOny0JGCHoVpXwEcxfBGIzIX2Ie5fm1XTmmkS8YMjsFXm6Nm4iiejyIIx+QcHLWpyDztuQPTWBl27DLPYhHJtcIGr9neEEvbjMAwKlkezqBOk5hJQqyTgdF21jb24QPPpk2r1eBrr/BeZ93CHI51gxvRt0Gwu6VvKQr8aQUPHPeKpC+hzn/deYJ2NPqT8lWUNzC9abh4Uoz0jsW/ru9mKVvBH6a3H6MVSHaSP+DrmfOg2sv9+xb+a9G/uYTJ0UG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGsMJ89EHfHWpqvg+1cE2NG8PMFwvAfUZSszICkBT4E=;
 b=EXtp675OxYiYK2+MvCcvhanuAdlUmuRLj+nq646/lUXM6sr3hM78r0NFrHXlnhTbHU1bQkfqOR7ZNH3nWRm+kcUrnSvGgj479FC8SXTCZz9BYnNmUu4rG9dKpQi4ua1ExV71aQ7YVslQ+V075IAY7WPZq+xk7CR+b7Z3zzkaAklJNsAZ89KKc8HXqLlFQfagmISSn9p/DEWxcqRHiMZOHmE+O2ANBRvaX16whpdxgkcIqse3z0spj02THmXdU8dQ15zYR4RsKyOet0KuKa+s0Kq1xktDwQrdX11k+NWpE9bBzY0TAp2UrLyxdTgh4w0fSaBZXtdFTwfvhVIAE091Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGsMJ89EHfHWpqvg+1cE2NG8PMFwvAfUZSszICkBT4E=;
 b=kACLuJiyJ/8bJR1+CZ7Lvur9Wbg5UmWtRUpOp7fCDxEhqy9+IKu2Z9LmI9WglqO4LttK7MjVE0ZaTVf8KWeV8uWqhvvwdU8rEGjPvsxz2JT1SNomMPWHW1pPLL8E8ZCEL7G/w342cBTK5KoOjWUBJo2UXnO2FigomAuhNIvUIFY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7826.namprd10.prod.outlook.com (2603:10b6:a03:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:15:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:15:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
Date: Thu, 10 Oct 2024 19:15:44 +0100
Message-ID: <e03b9b06ec58433e1d4d284ddc978177a12b4196.1728578231.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0429.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd2b124-fd38-4ebc-9c53-08dce9579480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8qwq3le7UrSvLX0QzEHM1cAw0GuLIOSrMReslPJPAkPSrEw+XsFfOE2Vk2s?=
 =?us-ascii?Q?sb7bvXcDWAkZmFQvASf1k66p/XL5K+gpoIWscZFRBO3sE/DUdiG+BRS156qs?=
 =?us-ascii?Q?8yGFYOoPXfSeQjJsYUqvWvbeVZZH4XXvfMTHm1hPUHAq1i2EF5748dlznQu5?=
 =?us-ascii?Q?WF6/HRXNrU0BnemuB9BTKR9+nOlHz6tttyzX/0oxj2DmnmvKAYPFNzvxJk9m?=
 =?us-ascii?Q?kmezMVs7ZxV6O+JKLX904Aab10oTV+bNEJwyZTgcHqDxFCPTUfdauuTBA/ye?=
 =?us-ascii?Q?jh4r2WVG39Jxs5QXBlgzaYSs0c7Aj83rgF5phR3+eTzkIWKq5HWhinBQch03?=
 =?us-ascii?Q?OoWWPlxb/MdUXvy1Sb4YFCUmJwm+2QJwTeb0w2s+XPWzEjNEkYWdZUSTx4h0?=
 =?us-ascii?Q?JqY93BTXcHYlyWctAJZD6x72i7ceBtxz92Ij+wgmveH4iRAaknyeZFc2mBIw?=
 =?us-ascii?Q?9Ithnb2yf8JiS4AqohbYYQB2DkKYj7K5tK+6/LlaxEnE7sQ7eDzpnZxNGACF?=
 =?us-ascii?Q?1PjjSywRrzDJ3YCvIhnsE/7j4eR0XYn6lYitL4VOXm72LEC34SJRJIQxHctR?=
 =?us-ascii?Q?EWH9xLA/QRUmWZSSchljOtqEfSqDlm6CIZDK95EdAEVryGJyb5LmrUCeEBO4?=
 =?us-ascii?Q?98qQPZl8DhyGdZVAmuXRVJygxCK2PnJuqDyjoGekOAx6JZ0T2x2RChL9zCfj?=
 =?us-ascii?Q?ST6jp7txANAnPoexiwNGL53b7ho7AnOlPmXwuv4G9VVIgD/FOIwSWsGONfeh?=
 =?us-ascii?Q?Rvat3YvIIENrsU4kYjwYLl6uvoghYWAB+zZfqTIISBBI+z5v/+O3Jx0p6SDP?=
 =?us-ascii?Q?7Q9nYtWThsvwk0/iFeJVf6g5sRbuHfROjwM5UQt/7/5X+xhdBFCWHKPd4djd?=
 =?us-ascii?Q?YGG/HX39qn3npDTfwiSj9ipWALc02WWPxbqKEObGNok4z9aXJ06eTbtbcYfE?=
 =?us-ascii?Q?rHdHE80WDSH8id7W05avVErrrHTuXP/ZcJMkhWi0VrdeUBIOhRTS2v1ia1g9?=
 =?us-ascii?Q?GcYxb/nq5ShW1xFR3dCMzqX7nzHSLPRtHaNQauTCr+S+6DJOTFcIYQoMCqe3?=
 =?us-ascii?Q?kSdV6giD4GoljKpLjU7csk9JraJJuFh0/64AN+6XjYr7UzPajqsd3zu/HeHf?=
 =?us-ascii?Q?rYW5TH4j91epv1G//MSFOCkCnPYDGbZUiBnmMdszpB//GRokb6gxIm6u7PL6?=
 =?us-ascii?Q?ad8U/HvYs8J7PbIJs5TpMD1BgQ+tCtQNFtRvC8UIBmOuAhXPfyLShGwGG/pS?=
 =?us-ascii?Q?UM5sxPS/uwlFlbwHMb7Okt/JzGT9I8NxYdwWA7Tm/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QBkI1JOPkgWpBT3phKOtQmV46Dl2P6/S3TuWeiShC0gtrGiTPaihfB/uVyl?=
 =?us-ascii?Q?dJLXW0XZDITuW8ALgLev5cAHNVyEQerAjSNTBfGt+HJfWY74HDeTnK2iI0PA?=
 =?us-ascii?Q?3SDyNGBjQxqWja0PMipv6CkaH9+e8OP3C+8RXI6v3V53laJyWKe2H0yFSgF5?=
 =?us-ascii?Q?2f5q9dRC0ePJnScVSBu3yQGzMkrKXRkq5eJRFK9cREuMAiJtGAvV5l/7AQth?=
 =?us-ascii?Q?NvAiPFzxHONHnag+wVxIQE2VwC60b0Veu6hEceJBbLx4wrCe6RnkQFpE4GaF?=
 =?us-ascii?Q?laphRd87cOrJKYNGaIyr6gnY7fnNd19xxAkEwnxKK9wxe2p6Wn96zDqYbWQj?=
 =?us-ascii?Q?GcNUelHw+yYajLkjX1/7scn58kzz4xPiMbUt/KFfrzZ8zdhVrGp/Ss0e5vBT?=
 =?us-ascii?Q?n0x2hPcJvBEWFi6hBJIysy5cBJxgdGJdwLea8mkEU1sfSEYvZ4JK2kwhHs+M?=
 =?us-ascii?Q?mLlXKocGg+WikSQ951KAWVQwitFihBDnZXoe48FHput3aBxkIQHg7z2QJl8c?=
 =?us-ascii?Q?to+1pQisQoUAaoEIL9o2mjs0hzxXBGKjIhKqZRlmDQNq1MJ5pC4sw2PFe0P7?=
 =?us-ascii?Q?rLH+Xsyj8mDjPyDhIjeAEt86nU9gQ6Rj7qrnUPqckd8htMCbBUIBjNqpi/0B?=
 =?us-ascii?Q?knWah7Am+IeVdY/x62So9xo0/TG8pp1ULOUPTquUoYTfHj4A/yvM1YjbD6N5?=
 =?us-ascii?Q?lDE3IJuYD09Xt/iHQTpHJQVtaz0bJ6PWsWvTQhakFU8FvQH1nDAD9wjWYrVn?=
 =?us-ascii?Q?/f8IWpyw+Nbygc13aeHwE5eCKAQ7PqKLc9Wz3Z8LeCShEO0tysciia4qhcJZ?=
 =?us-ascii?Q?geOzXMGERr15tLDtA+3cYt0FXzONxLnQbksoXk1GUyidzww7TekCP4gALuQp?=
 =?us-ascii?Q?dlIFE9sUStF9B3OQi0jxaYHb1pTtJG3B/sZ9Ll9M0aN14IRJaLwCbIcwOyqi?=
 =?us-ascii?Q?K/BrjIydJb4RAYDmhz4CLV6T9YrXOImSwSqnX9541zCwaw76PGFS70aCwTNz?=
 =?us-ascii?Q?/V1EFK+ouxvy25kDMqblzZJCww5jFSbvCpvfT3myCk5TkcT50XGMlMecaTBr?=
 =?us-ascii?Q?9d+RW2+7jpituxIVzqQ1hyx5bT3oEClKfijQawDC0UrNts7U5sy8nc//C7sg?=
 =?us-ascii?Q?34vn9f7oxO0YVI7zv1KLauq/fSyrsh3JV6s+JA6jFBmDMlo6D6Soz2JWM7zk?=
 =?us-ascii?Q?SxRdZgBJ7Lfyint0THFyDgfPHgb56aPUJR2MKKRP0fGaPnBJqETIfNbfFfyD?=
 =?us-ascii?Q?SOadTDyyYCb3Lz5fZQm9w8S3cHMvCkfYr2KGKGGioFC95uL1GoXr2AmGFPYA?=
 =?us-ascii?Q?pVAzbCN+peFy46Ki8FeFu+D6xtgjxa1+4IcnUk2Oux1M713YllLDAeZXSpOa?=
 =?us-ascii?Q?spCAHQ5oaCfg3vl7bjVJ04r2u37tVgX3+fBmibmmodWonbrz8eY4n8HLAKAS?=
 =?us-ascii?Q?GsgGFMkzZrILZT0mqd7NadvAob9VQaZnoaPhMukTGoLPYNIrNSThAvOSJgdp?=
 =?us-ascii?Q?hWAi50IR09+X1KajylRbUIKxtiYEexowseQgNhW1UvRjFDs6ULXU+F6jsFPs?=
 =?us-ascii?Q?DF1BE3BWRuuXGDkHQ8zW57GeBOYLk71EofVLauWZEngDiNPyAbmXa61i4s6n?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NsBZ1Hicglu18lL2jXMniK0Jij6xlgW6bGcgXr5VF4elH4FaOULpYh0STR2jbU09vNuEV1dBHZBNlogL4q9neU8UcvkfNX8VetFNiFsPdFJRbhz5kiIIy2IFMpB/tW/2i+BVMjrAY6YH9tN5LpgrWZfjTpJb6YoIIb6VYBbjxVYmZQEN+aSbFXcpm+L2C2bdVU42k+td2yJoqWQItpwU5fnZOp3cAMy4fvwZKYqhkTTx/asnzqxBARMYsB1u0AUbAsLl2ANVkWaa0zkczmhtJw0nd3zeTcq5f9tvOdf7qVNBeNxdm++Df4gJSXDP1imnFSkEnvFVh+MSol6PnsX4R1ZDv65o8mSr02Ive5qFO9ui8iF8qXToh43NDY1tioEohUQkviUOSPLCECh2LVvAxPIi7Z7UKZIFLJT64WDwGbWoXMugFafzu6BAgWL92vKid0SleyC9siRxJ6Dn+Y8xuXXnMhJMGXFO/+wIqRWsTSX/qUvNqf8JIuTCS7burFi0RI0cHe6ymmG/MEgE1kaWcqBgwWhzegwU7m68VrJPigrGPPgiod51RuI0gBPlHhCq324L/+VuQGm07EO404Xsla7Cuzd9BytE6WY5VA5/DL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2b124-fd38-4ebc-9c53-08dce9579480
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:15:54.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF1BACghZQQQOX9ERbKM9aSQzLl+yrQIy1YRrhVd6C64EXa7I1txuUgmhLJi7mZQckmoqo8Yb9FfpzGbKTuC6B6ITRalBNVyeFhjriESi5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: frTi7iFCRY5pC-kfceov9tqY0sywy46C
X-Proofpoint-GUID: frTi7iFCRY5pC-kfceov9tqY0sywy46C

It is useful to be able to utilise pidfd mechanisms to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

In the pidfd_send_signal() system call, we can continue to fdput() the
struct fd output by pidfs_to_pid_proc() even if PIDFD_SELF* is specified,
as this will be empty and the invocation will be a no-op.

This change implicitly provides PIDFD_SELF* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  9 +++---
 include/uapi/linux/pidfd.h | 15 +++++++++
 kernel/exit.c              |  3 +-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 65 +++++++++++++++++++++++---------------
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 68b02eab7509..7c9ed1b5d16f 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,18 +77,19 @@ struct file;
 /**
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
- * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ * @pidfd:      The pidfd whose pid we want, the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @pin_pid:    If set, then the reference counter of the returned pid is
  *              incremented. If not set, then @fd should be provided to pin the
  *              pidfd.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here. If PIDFD_SELF_* set, this is zero.
  * @fd:         Output variable, if non-NULL, then the pidfd reference will
  *              remain elevated and the caller will need to decrement it
- *              themselves.
+ *              themselves. If PIDFD_SELF_* set, this is empty.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..f4db20d76f4b 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,19 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)

+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-100 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-200 /* Current thread group leader. */
+
+static inline bool pidfd_is_self_sentinel(pid_t pid)
+{
+	return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
+}
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3eb20f8252ee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>

+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>

 #include <asm/unistd.h>
@@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && !pidfd_is_self_sentinel(upid))
 			return -EINVAL;

 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;

+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;

diff --git a/kernel/pid.c b/kernel/pid.c
index 25cc1c36a1b1..0f8943ecc471 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,22 +539,31 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 			    bool allow_proc, unsigned int *flags,
 			    struct fd *fd)
 {
-	struct file *file;
+	struct file *file = NULL;
 	struct pid *pid;
-	struct fd f = fdget(pidfd);
-
-	file = fd_file(f);
-	if (!file)
-		return ERR_PTR(-EBADF);
-
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
-
-	if (IS_ERR(pid)) {
-		fdput(f);
-		return pid;
+	unsigned int f_flags = 0;
+	struct fd f = {};
+
+	if (pidfd == PIDFD_SELF_THREAD) {
+		pid = *task_pid_ptr(current, PIDTYPE_PID);
+		f_flags = PIDFD_THREAD;
+	} else if (pidfd == PIDFD_SELF_THREAD_GROUP) {
+		pid = *task_pid_ptr(current, PIDTYPE_TGID);
+	} else {
+		f = fdget(pidfd);
+		file = fd_file(f);
+		if (!file)
+			return ERR_PTR(-EBADF);
+
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
+
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
 	}

 	if (pin_pid)
@@ -562,18 +571,22 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 	else
 		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */

-	if (flags)
-		*flags = file->f_flags;
+	if (file) {
+		f_flags = file->f_flags;

-	/*
-	 * If the user provides an fd output then it will handle decrementing
-	 * its reference counter.
-	 */
-	if (fd)
-		*fd = f;
-	else
-		/* Otherwise we release it. */
-		fdput(f);
+		/*
+		 * If the user provides an fd output then it will handle decrementing
+		 * its reference counter.
+		 */
+		if (fd)
+			*fd = f;
+		else
+			/* Otherwise we release it. */
+			fdput(f);
+	}
+
+	if (flags)
+		*flags = f_flags;

 	return pid;
 }
--
2.46.2

