Return-Path: <linux-fsdevel+bounces-18140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF48B6081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A71F21580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A5128829;
	Mon, 29 Apr 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XH10qUr/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XhTCcEXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F91128396;
	Mon, 29 Apr 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412944; cv=fail; b=iWnarW9wqirTDBZ4iL1WsGjB5nPgcTdNy14S1bTXkW/cfwDZKY8JR2v1iG1Z4rQwYOqGU4+jVrcgHLAcH84DeBxEmPn5tY1jJB82ziCER1CD0FKMFbtQ1/wEUlPBejOdheMNm7GHbnxDIL7OfnXg2azgEGAKB5s2T9rPG+q04Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412944; c=relaxed/simple;
	bh=CelsyOz6xL/rUB1Lt34waX7pfJegaXuezpaYTEGpoIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VY2ycf+VWU58r/VcSFbwS8d3wk0hyCFlPclFyM2S7fZlk1X0933f5kJV2bajVh+GHKcqKnJUcjAL+7iB6GjNvRQkisQTu50ep7Us4aunLOOpRXE9xsK8nkKR1ayhYuy94GpVyrL7tPINb0zmvJX5b5iYozDXEmr9iat58xg3ekY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XH10qUr/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XhTCcEXf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxRJV019992;
	Mon, 29 Apr 2024 17:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=VrLs352xxRW0JJbIYwLtyCQy+MOFRrqjiqzwUpMO8m4=;
 b=XH10qUr/uRRWhEJOmP2Kk+HRjfbPe1aUjplArd7Qwj1fwZuzmD9Meiy8EQ68b+4eAPo5
 IEktnsf7y/xjGgI28VP9QfHhXsR5zmycR+PsK6aIDeXMlztKMXECLnQBvUeghEebJHkn
 foEoE+0dNErqlYE16YqCnDFdD6f31WuhE9yuTa14KVwCa0ONXVsQo4RvrgBeazbey2m2
 8oNHzIHX74GF4A4lqiYYS0/J3BsYLNuzfz5fQeidr2aJReq7OKcfh9n6dVUm2cseWOF4
 i2zQPPSZ5Q9qSvTKA4slN4J+P/jIxT19VIeQQaJLmZB8uX8cGIV+S+qMg5TcwsbZUQH2 LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8ck699-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGLjY2005030;
	Mon, 29 Apr 2024 17:48:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt67byv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxpsmyrta6KFaDIkUxTqIF2TkCh7MVCIakHIjF5xkC3hnj3m7IjlY9W0+XHEmSWlArbGwDG2GzqjPrYdFaIAjMQP/citLJBawIJE1XdET6eKCW65MCLLFdWJf1jXnOmk2n95MXGDToYSjeeh3Ptn8/VUkCnSqntQvBDhZkGAzZvB4ox8m5JT/wVxJAd+tnQ3Xfdrt3i4l1kPP7YfAZJZyhQJZ35tgJgTwwdSbzd4p7WSmks+iWGKv+Ydxky/RAbK1Rb5vi5GwsWO2yFNKq1WwsS21mynJma8VNJS9065kUKM4DqrV5vi7Xc9nnBCrVzzeeH4KHeQGYzHSXf+dto/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrLs352xxRW0JJbIYwLtyCQy+MOFRrqjiqzwUpMO8m4=;
 b=jZLjhDSy1D7ArqxT8l98A6ldbHa5LJsJReobh1sh0c9fqwFuKQwIWtoXGhky18movxGl2Yr0Z6dRl9E6ASCkVFhVMSHfSK8OPsuTXdNF6/3y7I9CnS0hoqFZvhn+qPZy5SFo4ZS7I+F1pH+QnAh2pafBmG9AXkfAHDoRMqwcReYw5xOS875FWfpIME9MRSX1dd2R1nIXvnK7jjBPFbkI4It1rcZQeEm9tamYn1k1caRsqd9QHrY/5v7VRFMQ6vYgK7hgXyu1MVrCckiOSfNXb6mInST2SC/uQ6B0eSKRtGE7ZVSXma4AkkFqGGLqKGI9kPmR6PHhoAw/OjEyAws0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrLs352xxRW0JJbIYwLtyCQy+MOFRrqjiqzwUpMO8m4=;
 b=XhTCcEXfAXoxb5G/IhTBkEKMvZRMIV2hLVh067cMhSIuAcjg7YV3cEnM2EXoqvh0MStfZDG4jQDSnoAdA5wRrUA7VVSSmdeo8qmoSIyNSta64xRTNpF1w1QZaY1xw5nKrCKtM8sZ6tp6xY4MM4b4gKt+7nLHK8+e+hN0ZNkVy5M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 15/21] fs: xfs: iomap: Sub-extent zeroing
Date: Mon, 29 Apr 2024 17:47:40 +0000
Message-Id: <20240429174746.2132161-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6738c47f-df69-4c98-9105-08dc687499e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S1zN4gkvUrHF41dz7oDOkyJOAZSCMoNL/54H8k6Dmi0ZCbr1IJg9LrqE0sBC?=
 =?us-ascii?Q?Ti3S+8hK2FdMua09gdkg+vb/kLyHtABsUTa8Zv+zyS59FDuGGu9ZswdzNbzi?=
 =?us-ascii?Q?8kYp+Vg7sJSrjQ+VmRt3ruRmHGb6pSow3YDp9F8KbmMRLkf7ohiUmiEqrglB?=
 =?us-ascii?Q?XvZ84m3QGhFOUfG4U727zQKzrueUpKF1bn9iCsSufvwqL4hAa4Dh/Ieqo3Jx?=
 =?us-ascii?Q?Yh8AuZePyARCKQyLO19GcWHgnSTgRIxN0/TFLIuMkt/H5ltm8LtiTWsjqduP?=
 =?us-ascii?Q?E9O26rwkviBut1eWsL7Lp9RN/4WKCI7dfyMWPJoxzXrMoQLE0/L7md0mR+6Q?=
 =?us-ascii?Q?xzHJItKrV4gYthocX/655nkdHw5GZEbTX71hLchI6imHzxkZWfuMVjNBoQ9z?=
 =?us-ascii?Q?7kMKWUafmS/LLC4O8mZlEcinZUCoVOjDM4AvEyXBe+VRMyp/mSzsQUOBVcq6?=
 =?us-ascii?Q?2aGR9M5LMvAXy4Etp7REMay1/0KOFNzWbMJ/rUs0Zyj6ktoCMsqBSWLFxB5o?=
 =?us-ascii?Q?D7NS5QtaSme/GrL0cOPDzyfkwrivyqKKboERjp7qgIdD4I8uftjjHakqBUe8?=
 =?us-ascii?Q?zlwos9Y2KBUN6hyt7o5xx2hZTEJVo0PUM3neC9ae4gHccgy6gVqA5vl2FmGz?=
 =?us-ascii?Q?8olx2QDCRMpAEGngtyShNNrset0GCVNj8icfE9Uae5tu3CG4lPkqCqH4Jchv?=
 =?us-ascii?Q?qCjTOzqrRxf+bwXqpvOpEt6YQoyiSWHClK3W5Kaw+282HvKFIMDgEqPNz727?=
 =?us-ascii?Q?mWUppQz6Mn6KW5+TrjgzeHbmupZQT48YFgMRyqUeku8s6SOGu0UxL/Bex8Ck?=
 =?us-ascii?Q?Hy5VYh2PmB3X/GNPCVeeIVtg7e+3Vzf8/9n6IF2qIwMM3Q32WE/a4Oqah7ED?=
 =?us-ascii?Q?1c84zlyPT4QX2Pe1T3gWaZSipHF7lEFakxAC6ls4FWFF1/gBuDqnDnutDeTT?=
 =?us-ascii?Q?u6ssdld9YUahV+94IpL4mAOgoX3MUM+MQNxSpQmLBAS9G9HES76H9md27C0R?=
 =?us-ascii?Q?CX+FCyeLeJ0KWmDc5/O4d5ni8PjyvmF2zCq1Ulx8DkrHfNbzQMPNM1QnpVxD?=
 =?us-ascii?Q?3UrOUPI/sXhhCtqw9z77MlanPEO1sSY2ecl+ykmbR01voNPfclgv0AhxOHai?=
 =?us-ascii?Q?H91eexBjtKQ123U7F2rIxGbOQF9lOlupQsl/IMA+W/o79zoc3zpUy/2F+jGN?=
 =?us-ascii?Q?pCL4Wo2MQI+kgTs2Y+bNxfcvQ3Jab4B6sM9NbmG3zvLl+bWHCLUzi/A38S2u?=
 =?us-ascii?Q?tiyBaKXcC90DeowKC38PaZRQxKKq3JEJCxX82LfXRw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fUAgLrXUR9QguHpEbiEDgl0RazXiJY2ylklow7OaaIqmGg3tu/RmYYL2Yk1k?=
 =?us-ascii?Q?kUIMbY0DV3ozXvnXfpVuNzPCrgDK1hoG9xgsmq49ybedJTfUPavJUhASvsIb?=
 =?us-ascii?Q?ibrxlleIl4w3hdjaI8robHzxtov/HkMIVRs1pF6sMfLWk61LraQTM79lCN2u?=
 =?us-ascii?Q?qbcMfGRBc6Z6IThly8soxief18taw7TbJcOnvlh8IiFxcqmBH30X/5OKfllH?=
 =?us-ascii?Q?amsWoAXNo2CrSsLDL/w3mky65Z6LMJm3sRt1j8Fdvl+98fnF47OJ7BG2rD0D?=
 =?us-ascii?Q?VaeUsrmAhKGhQZes0iB4bceXRq/IcQfZkMVTe+9aN5Sp17kRBk9wUmDizjTh?=
 =?us-ascii?Q?UOjmzyhjcSAdlf8fX4adnWgYPxHVMzKdJl2vVbd7Znj1xDxBBzuaEwkwOkvN?=
 =?us-ascii?Q?Q7iSdDkCmN9FWs5pAsIbWwF4YiT+ym3usgW6Y/DSatgJV0Cu0XwnYVdJMZQl?=
 =?us-ascii?Q?eHelqgQy8zBNid/xuU/q371CEU6/3XrJ3/KKLgiydD6BncyyDo9TJBRbavtX?=
 =?us-ascii?Q?a5yJJlcBccEVB9/bFiBX4vbLdu085Qkzu39Du5BmFmf3O84BgYUoBSc5CIIO?=
 =?us-ascii?Q?pJqlDoi62HT+tGtmnly2UGlCSRfDTWkHKJz9sI+RcIWfczZwuLVwCvzRdqvf?=
 =?us-ascii?Q?5Eer2PMaN49ksMW0LmD9AoVzBZW4NJVW95b8f/G1COKwLunAWpFwsneEOVP6?=
 =?us-ascii?Q?KBU0fRvvJbz3L/KmKdVpmYLx7+UgOzg6amX/azCRLrPgH/CQPGABC0VlSosy?=
 =?us-ascii?Q?nHrVJv2UEkVbjA5Lz59C8gINsY8pbwL4VUU/AtLP/WKtB8il4oXaCZ4cFlDj?=
 =?us-ascii?Q?9Wl3fXPxJhH0XZLELJ33myHDJ9Iqpp6EoMUXlsr8fNp4CxQ68CUuxvLEN5Ve?=
 =?us-ascii?Q?e8NI9/1fadiFc096PTfJ02j+jNqx043HAk+um6XCo01Ef1om7qFBXa58WhQR?=
 =?us-ascii?Q?/CAmy8sDEcE4XAQ5ps3Y0DFY2eJxtjodStqfJ7j5MlvSfQfGN4mLzRo9uqdi?=
 =?us-ascii?Q?8ykgRO2A+up3b5v69ORbbd4SxutB636FYFldHEZmTcidqABlcxy5e2M8rbpK?=
 =?us-ascii?Q?eWbjuec3lE0do+G55GeVHt74TCu8/nDRBLOph/7bgsXwZwK16vuby12hFtQm?=
 =?us-ascii?Q?zpdykccOomAfbVcv6TwU97Fmy2VaVCO+uRkTh5w+nYyiNVLev9LNnAxfhacE?=
 =?us-ascii?Q?PjNpBRmnRdI4SlO1cvKN4JxpmKLFjMGvxEVGxTdq3gEMcXwhvX9mXOaQXuhF?=
 =?us-ascii?Q?RRT21bQap5Ut/0KqhKKwmqrlwMB2svJExbqR7of1btBKgHWD0TlfdRcMqC7s?=
 =?us-ascii?Q?6vfrcZhBWFxMXTMJCXb/JFBngEwg0WBGY1vatT37+kuu2q1F/JpYEawEzFVb?=
 =?us-ascii?Q?WrdQ6hLhuM35RPkrJfHmVBXAeeLet7KcKUUNSZeDkx0p1rbf0Q3X8Ap0Q8J4?=
 =?us-ascii?Q?CEXDgay7VH8mpT5tHQaAGGcOxu9EDM9vawDoOfX6rqckqtlNqW+x/5Lo3lT1?=
 =?us-ascii?Q?iovfp1MLVue9XGAokbiDr07Yc9uocCld/gQtreJ/E3H/aeZ9gLRbXuD+kBsi?=
 =?us-ascii?Q?SeksSuywlXvnGHjTC8YlrZPqWkU5cedT1lAxtN8rP3nhJ4VmzFODt/oqTqtO?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sp9SaSsEzkWhs94lSbpJg5qFNARxxtXHBEzXbwaNl+3wWxE5JspglT+bhysKnb121rVHyDlDxK8wgIixj4qpVwEwboJtCVNkR5YHnCaHJCb4Slhn0OTTLPGTzmcXVop3f4T+59f70+BSWvFtkHQ0OzzHmK4Kr3cKPBgOv2aC9QNfVcRRFwX4ueck/hVp7y+X1WUE8rkM0QUgc92uZI2HIAT0KArM1bL8Sg9tYpUMMZ+4ALecaaO1As59a7daPfiwJmiVTDbBLykHzf28+CHWho2ikbsWej6JvEViGj3GbKeBWUN8AIBsHoyj49eYEeRZJeAEhC3Ut8wl+fBzoikTpiogPc+SP4lGuzh0syK3anwRL10xbjPq9xummqiOI0V4z6tNLrs9fKXDPf8v6hSkicZCuax8Wfqb5wpUtR4ZrVTJ4+Eklm6AyligdE8Mq6P9je4XKTseW5bzVIxK+StEZzg7vdC0kp6Pu8A5YSKx9ublPtcUdH5yud8goc6Aw0kdV2hBDEitKEBp2rUHZI54QqwPYqL+lplDP24JpMSAI0O2cL+ghutROy6csR+9u7t2nRfzw9hdHNagnUz4e8qQz531jqy4P8K6QdTLjiE0yFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6738c47f-df69-4c98-9105-08dc687499e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:38.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3TjdIDH23t6mlWkC+lwJ7GE47TdhWrI6Ps653D4xeuqQ5PtnN/wZxxvw77RU6v5tot8QOBgBnNB7bynIJXMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290115
X-Proofpoint-GUID: 0Lw-b671ApsmBz-E6o1J_h4fPx9gAtd0
X-Proofpoint-ORIG-GUID: 0Lw-b671ApsmBz-E6o1J_h4fPx9gAtd0

Set iomap->extent_size when sub-extent zeroing is required.

We treat a sub-extent write same as an unaligned write, so we can leverage
the existing sub-FSblock unaligned write support, i.e. try a shared lock
with IOMAP_DIO_OVERWRITE_ONLY flag, if this fails then try the exclusive
lock.

In xfs_iomap_write_unwritten(), FSB calcs are now based on the extsize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 35 ++++++++++++++++++++++-------------
 fs/xfs/xfs_iomap.c | 13 +++++++++++--
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e81e01e6b22b..ee4f94cf6f4e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -620,18 +620,19 @@ xfs_file_dio_write_aligned(
  * Handle block unaligned direct I/O writes
  *
  * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
- * them to be done in parallel with reads and other direct I/O writes.  However,
- * if the I/O is not aligned to filesystem blocks, the direct I/O layer may need
- * to do sub-block zeroing and that requires serialisation against other direct
- * I/O to the same block.  In this case we need to serialise the submission of
- * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
- * In the case where sub-block zeroing is not required, we can do concurrent
- * sub-block dios to the same block successfully.
+ * them to be done in parallel with reads and other direct I/O writes.
+ * However if the I/O is not aligned to filesystem blocks/extent, the direct
+ * I/O layer may need to do sub-block/extent zeroing and that requires
+ * serialisation against other direct I/O to the same block/extent.  In this
+ * case we need to serialise the submission of the unaligned I/O so that we
+ * don't get racing block/extent zeroing in the dio layer.
+ * In the case where sub-block/extent zeroing is not required, we can do
+ * concurrent sub-block/extent dios to the same block/extent successfully.
  *
  * Optimistically submit the I/O using the shared lock first, but use the
  * IOMAP_DIO_OVERWRITE_ONLY flag to tell the lower layers to return -EAGAIN
- * if block allocation or partial block zeroing would be required.  In that case
- * we try again with the exclusive lock.
+ * if block/extent allocation or partial block/extent zeroing would be
+ * required.  In that case we try again with the exclusive lock.
  */
 static noinline ssize_t
 xfs_file_dio_write_unaligned(
@@ -646,9 +647,9 @@ xfs_file_dio_write_unaligned(
 	ssize_t			ret;
 
 	/*
-	 * Extending writes need exclusivity because of the sub-block zeroing
-	 * that the DIO code always does for partial tail blocks beyond EOF, so
-	 * don't even bother trying the fast path in this case.
+	 * Extending writes need exclusivity because of the sub-block/extent
+	 * zeroing that the DIO code always does for partial tail blocks
+	 * beyond EOF, so don't even bother trying the fast path in this case.
 	 */
 	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -714,11 +715,19 @@ xfs_file_dio_write(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
+	struct xfs_mount	*mp = ip->i_mount;
+	unsigned int		blockmask;
 
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
+
+	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
+		blockmask = XFS_FSB_TO_B(mp, ip->i_extsize) - 1;
+	else
+		blockmask = mp->m_blockmask;
+
+	if ((iocb->ki_pos | count) & blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4087af7f3c9f..1a3692bbc84d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -138,6 +138,8 @@ xfs_bmbt_to_iomap(
 
 	iomap->validity_cookie = sequence_cookie;
 	iomap->folio_ops = &xfs_iomap_folio_ops;
+	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
+		iomap->extent_size = XFS_FSB_TO_B(mp, ip->i_extsize);
 	return 0;
 }
 
@@ -570,8 +572,15 @@ xfs_iomap_write_unwritten(
 
 	trace_xfs_unwritten_convert(ip, offset, count);
 
-	offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
+	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
+		xfs_extlen_t extsize_bytes = mp->m_sb.sb_blocksize * ip->i_extsize;
+
+		offset_fsb = XFS_B_TO_FSBT(mp, round_down(offset, extsize_bytes));
+		count_fsb = XFS_B_TO_FSB(mp, round_up(offset + count, extsize_bytes));
+	} else {
+		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+		count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
+	}
 	count_fsb = (xfs_filblks_t)(count_fsb - offset_fsb);
 
 	/*
-- 
2.31.1


