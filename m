Return-Path: <linux-fsdevel+bounces-54954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D513DB05A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E753B5DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F21A5B8A;
	Tue, 15 Jul 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cs41llZL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="luGxJIl0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233751805E;
	Tue, 15 Jul 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583529; cv=fail; b=uenznJKh8ZVqmIaGCpijfNGpl2TK3X9ZBMn59f8KaloAc8JS+CgHwxDcC/EE9cHRnFzP0K4vh+QFFhCA9tMDlbkOhhxUtB+KGHiJpW3VR0XK1JdzqHlF8CvVUrTsQ3igXy7X/NISdm0H7ybGlbGzuAXg4KHbWAVUUZWeekGEYiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583529; c=relaxed/simple;
	bh=2opo9z7RrkunIW93mTVvtMSQUL88rK3V8lXKUwsPtjs=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=eddIC8jzc4jR5v2XothZgUQSoID3OghSpC55o7OTz7uRwDTRtV3SDbyBjbW5m544ojzh7oynDpNb70+SeNvutjXw/qBh8D8qJdbgamEoEBnrTDq0yu5aXsuRxH20jHvlmOo5Bua7L3f5Psknj0nk2TnXzyicm6ydNMOZyp5uAkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cs41llZL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=luGxJIl0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Yq4l020381;
	Tue, 15 Jul 2025 12:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KWBWCHVtbq5IG7iRSf
	7FSUR/jzQN9Wa3rDfQ6jd8OoQ=; b=Cs41llZLbdUbfN0R5CxsucfMCNTQN5SYoO
	D+g+pEgn3nPsPCcxAJ+hoXBn3V0D9Mcs9QmKvfzJUXCTJ7PrtNCsp8ND3gg7b7LF
	CdHPxIC/SI4L1csfSN/c9uMgWmbkxWnlpW8F1gpYzTU7RHwRrJTdw4YIGPnkhKBo
	YL7bI593Tgai7+jy1tRtDbSd8dYLmMhATT8+AFDfUbO5KvMOg6Hz7oA/7O5wyvxs
	abSJye+L9tA4M6zYw286x2twlXDYc4JJLP480aH189+Is/WfhH92X/hx8UIWhk1M
	u9FOG2Uw1cvnRYPx3dQ6s4g84WBGDuAfq57kHonNcOh7zDIQQtbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf6yxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 12:45:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBXnVF013013;
	Tue, 15 Jul 2025 12:45:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59dwje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 12:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4bthIArN6VzNAWrtx69itvkjZByZ63eCmwgRmke5SdyqMyz5ZUFj81ZkqzZSmH8co6J9wx3HYx/fv9Z19RHs+F+eVVIgWx5rwkfXYyI/3SX/1BCNxgYKiFy5bjxeDsqj3LyB7t8oe9olf2fuYxMxBCy5Eh0dRXMlp8Y1YeknrH5AgqB9VTA7d4AH5ab59H5PypX9YA6PijbkYUe058TSPDPZ8Go/QM/tX43F8lEEdCa5wP2ZKDiIs6HuVQn2/K2e/4YDfZOT1hDWRem5YzF6lE8mp24jtNlzgsZ1sTcDZo45zza4qCfxZyQl8L6J2jDtG/KuYlJKnzWB3q4H56jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWBWCHVtbq5IG7iRSf7FSUR/jzQN9Wa3rDfQ6jd8OoQ=;
 b=kiL/zr8wMY4AhRI9b4AB+EtOifWACkJV06e++/HHo9v9vWrDgW14bYZ1VJXPPuJ8Q6yHqZyyorCG9tv1p7WEE8r5NcDRTSEjgL6Bq36iwt+JSdROBxNncmvWV7Gi2BP3mvwkWsBX5BtPf/51srkvHcDplDMrarEBlbX0dBu2RQJ2wsrv5iPz5ZwPNxzsr2rSO7NOeaaoyARF3+IjJd3VLWDtFUB1eqJWd2JpnsdCaf1BUBIGAFVWIseSMLbdXhD3ulxDKbkww2ftSi++PymgKnZnvvbJ7mwLlEnXHhJNJHWnoZ2MJgWoEgEpC3wUuaNYTqCkU3HmxYwzehIabT3ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWBWCHVtbq5IG7iRSf7FSUR/jzQN9Wa3rDfQ6jd8OoQ=;
 b=luGxJIl00ru04NoxM9Uv5QIOnOJQQQW+g/ldbet8fUQFIRiNYa0n8dn59obLYAwro2zguPtA1AQr87CkC3zWmxkv9mW4zOyWbUnl8kupxPIVmccI7N3wjdo1DsoshAws5oLb26SFH5LwiWUVJMP8DXWOUMGYpKmk5+vmAFSN1kM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CO1PR10MB4692.namprd10.prod.outlook.com (2603:10b6:303:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 12:45:13 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:45:13 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Theodore Ts'o
 <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250715060044.GB18349@lst.de> (Christoph Hellwig's message of
	"Tue, 15 Jul 2025 08:00:44 +0200")
Organization: Oracle Corporation
Message-ID: <yq15xft65vi.fsf@ca-mkp.ca.oracle.com>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu>
	<20250714133014.GA10090@lst.de> <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
	<20250715060044.GB18349@lst.de>
Date: Tue, 15 Jul 2025 08:45:07 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CO1PR10MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf011f6-6193-41d5-e817-08ddc39d70b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9XVY/ZkGIo7W4/bgowUMbmm3mYKVs2F540CaQpGWfP3ZyhH3G8IbNjPqjWl?=
 =?us-ascii?Q?VwtSjFtV3IHFfQBieLCUBrVy7lxMfhYdPhQWD8p41S5FSMpLvc6zRWxtyjPa?=
 =?us-ascii?Q?9baB2uebJyelPwvvWWKVgi3Y8Pty0g1GDUPzDoVi06XOLoMG5fSzvNx5LgRW?=
 =?us-ascii?Q?rRBbshJplg+oCW3ZuQqvKzvAqcrutpBTgWmIRbi2EWjNIggHowNYw7oY36Lu?=
 =?us-ascii?Q?z4RRf7JRVv8EEG6+YbrtUiyLlhyE73c+6gPEck6oQox24k2vdegw5wkyRLDf?=
 =?us-ascii?Q?yqMsw/xe+GSt2UhSvcEcriAze6xz0797RVndfVF+qRt4cl6pQ3Z/46c4vK5G?=
 =?us-ascii?Q?haz1QAqfomfH+rVZwR12MAyj8oj+XFS3VKIq4ucwLyJoemizYuFKRUDAwykR?=
 =?us-ascii?Q?K1ylQWCJ2Rsj6uH0VN8Yns+ZBc0RKa8qm+7rJM+NOkuLMO48Zp91KY2RSrvd?=
 =?us-ascii?Q?MPNkTGy5+IHHVIpJqUPmikKGX/SzDkaBblGqrHcZlhjsFSFgkOvxMZXktGJN?=
 =?us-ascii?Q?/ZdGk7ypPs6Mq/Hcggbgbcl+PynaClzTfwFry4pQmdH0RtnoDl3gUbI25hpT?=
 =?us-ascii?Q?wtr5U5cPoHtqgkrU+AtjJN0fYuFePaHyjiskSzsR0BqVwFVfvp49q6lmiLPr?=
 =?us-ascii?Q?hUr0N0vLjVW8j3s8m0xr59O10uRHq249hdgu9mZN2KFU90D28qaE5xXva/3P?=
 =?us-ascii?Q?WFPqGO02TutISHo/d7RjLOtNjY+tgUr2XwdGnYp16tUiogB9nPEMM1dyakQ+?=
 =?us-ascii?Q?QsstaJxxKjSnqpYc6UkCNTOZiX8dGN4046OK9AcWKuPiL6HWfTLPHb7mxLwK?=
 =?us-ascii?Q?hOQ5OaaEeByNb7dZMeR+4MQ5USew6skv4vQwZ1RmujNpGJ5TUjvZ4NMoYXaE?=
 =?us-ascii?Q?QNh3fXUd//C1QpHQdxpJuRbHGZUeXbTcWeQb2wL5gE+TFrb37daqAgjvh4hv?=
 =?us-ascii?Q?joIIWbweJbg907siInEa8WJP2VkexfnXq1q22KIXHt4EKIqRmb1wOGJ/2tsI?=
 =?us-ascii?Q?PgqQcqqNvFkYgtfxT0ebJ26adicRu5TyqLNO55F9QaAEX64BtIm/nmjT3tu4?=
 =?us-ascii?Q?ORowlzKQMJ3hsvV15z3dWw4907mjQhba+JJj4gtk8x7M8nrW3RCvK29p2KCr?=
 =?us-ascii?Q?BKQiPeVcaxVeQZeZXIt0tCqQB5WWxhdnBmuyE1c0N9LPp+O8JmprTlEy0gkp?=
 =?us-ascii?Q?MZkVv2bmCNxSEQ2nc1hG5nDbolG9ZwLT7XsYiGm8/XKuGq92O/rDanqHaZAX?=
 =?us-ascii?Q?PXBp/Ek98ckUaljRy0oiC51J0jL5ATa7JVxgZ1l5zQCKqn1aQiBclV74gnVF?=
 =?us-ascii?Q?TEH+ExRJHhI9+3Su5WMWrWQVWSZYxqxZTHZGwZ6uquHjT56YX0wQG/POSFpr?=
 =?us-ascii?Q?TM/NOjPKaJM/JfQfy0vmS1Vfy+EsNyHLR3sAf/fgInojSymqYvLhKunJymcK?=
 =?us-ascii?Q?kg2ciyFk798=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUSgiIofAfI+DXoh5UYlg2IqWfOdlIEeis1yEjZeUPRj+Ur9sETbBF9kVrAP?=
 =?us-ascii?Q?urnLcS7fehwniwDbuDZeYnqfUmgJeB1qOiS3eY/BrQ0Msi3WHTlawq5j8kX9?=
 =?us-ascii?Q?XJoc5Vrh7xbrsp/mFbmiQj4vEZLsDINFrMVLBVQl4l7bKGKR/9kNFAzyfybC?=
 =?us-ascii?Q?AYh7ghuOxR3Wxm4WuTWBl2onMJsICauWMfcq+k3lOT+CFPBOh/nyBnSCWeiU?=
 =?us-ascii?Q?b+bFmIAAdEkl79l6Vu+eV9Rz41O4fJYuYjsd4oM8xQwIu5qERTHUm97lYXQC?=
 =?us-ascii?Q?blY238qGShYIFGUQgez6uSgYQndbN7LmHllcrgWlC7/DNiIeeD7/UWHWkNLJ?=
 =?us-ascii?Q?akEboT7kCFNFaxHPUBfMhcCsFl1uDbTwS8QTitjoYZdZVssSN7X/GZVqOigx?=
 =?us-ascii?Q?PDwaRM8XlWNvIKmJAt/7Pf+dXZdYTjGatU4pfT3xYcuvi62cOpcP6QZYBrwh?=
 =?us-ascii?Q?LN/gUmhNaLxC26Y4sErcPGCBCH0v3kuEjrR0ikLk9mWLduOHmbXacu+v5kI/?=
 =?us-ascii?Q?Bt0L4Qg7Ap5P/crlooQJooZtB7y9SYpee8osj5kECqp7wM3XXNdhecC9ddrU?=
 =?us-ascii?Q?6q+GkqTo1jSEvi6wqdtPeE/q1QdWo9lyVydzb4BIOw3HiblAnJyN7zQKDh5q?=
 =?us-ascii?Q?ZHY5wai89UL6iGzbNhIhB2ia8VMJWygFyDEqtEglezEphFmX6NQWyhfqJwDX?=
 =?us-ascii?Q?wzu2eLHZthmUNQbKqjniH6rI8Vh6vSGthfBMPVZiSn6InDx0EMDQ4nO2Oy7x?=
 =?us-ascii?Q?KH4oCti5ScWx8BGC0m+lUsNQI373FIdQAA9gxUUHcrPk4oXkMxc6AVXQ/r8O?=
 =?us-ascii?Q?y1URJkCeKEY7nu5zxZdsxRioAliRuIP/98zkbtWCCELqjBAlsUK8iZPvIEVD?=
 =?us-ascii?Q?+7xx7uApIdmxne6SzeDDafFEkaoG2mDtBVm/nEOXE8le5MApBCAqPMNPumhe?=
 =?us-ascii?Q?UNj/5mxqJ7c0WHaNyjyszNa6osBODfObV9TUElw+ECM7m7VvY/4O3hzMcAKh?=
 =?us-ascii?Q?//FoXW1EJjbCvBbrFOXjk29y/1Oe5A158Uwg1GwazvCkLlY2YrlhHm07HnPT?=
 =?us-ascii?Q?zHAXDT4SdtljrhIMGjTmXao1td9uAm20cDhcdKivlTGeChxlgmT0K5qLNdu9?=
 =?us-ascii?Q?B31buU4cRbUZ+NPkMviR4oY3m6qTZQmdOxXIYPquac77SiyYiwdQQSoBDBvu?=
 =?us-ascii?Q?THwiJkqIhEI1c/ekZ4QAqz+P9YVj9hD4vdmRA4kxcL928DG+/EfWRPFlktWZ?=
 =?us-ascii?Q?q3+Mhm15cjNtOarJT/DKFjwqGMexg6HHDDK+AXJgMeftzJT4lZ95LHCxBI7/?=
 =?us-ascii?Q?eSxYNw1aH4HqLRR4lvEM0+T7sB7aPsERWZNnVvuqF1CWqEgDiuQakU3BuDHO?=
 =?us-ascii?Q?1z+RFLAKWlXtGcHy9XCN2SjE2m9CHvwrdvf5EcG1WBSZzdxC8wyZdqzBXOB0?=
 =?us-ascii?Q?3/+t/P7yEipQ3i3rh2NTJw5G6gx3aTStjxvRxD+Q+jmnAmQWf9r8gBjWVHAP?=
 =?us-ascii?Q?ylMA8Fh8YJ/TzWwApa0AuP1yRKgl4Zjq2OjI/Gpoa4jF7QrqSygKTbLxOZes?=
 =?us-ascii?Q?x856QDuDAxqo15CCAn1D4qlRfI8MDKLweMob2IRf4Eha7LHzx1kB66rpaetL?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NPXmMH0ZYxqoLGAreaXuWNbe31x+8bxc+ZzCmm6Ty2i6NxXGnDNjETpoyCbIR7Z6OTrIz4Q4na0auMLyMziXv0qUnfZz2z0t6HzuqVQSQyE27bWdG2E5BTw+DWr2xBDa6bwKa2YwC6Yzvqr57RJYowxKhXD2BzKnSW5n2KsT41CkM5zzYAQYtOYWdUMydVyPYl1ofxJRSItcrl20rhTVTuYl7NhMoctI8bvmtA5Y83lzKezd+cPmnpcFAblub7Au+J7cE414E5CRpAkCm67lVRfz+PAFFL5xk4MdRbZzI+0fOOuY18xyO5m04+FTkZX3T/aXC8JXjeWMNHJezDnfMz23MwCUFUEYg5yrQeyDzazZf2FdaezgHREt4b/LG8MxcU4tHqZN8ZtoP5zii+glhnE+LWQAO8WiTfsE7nurAml58QIquBOeDSTOodmcjv/OdisV+dV5MpBs9AvuqoSLF6ghvuGL4XkVTteA56nVP7T9eQaB8snu2dwiICfin4dsjbNaDMXHb81PhkM0wxi2dwvU5mP7yFhICpDHQEjY1480mN9sNtJH+RefaIlv/nzfa7fIqoX8RY5xIC176IBTb/0/y61/Dvm6HacUqC/qSZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf011f6-6193-41d5-e817-08ddc39d70b2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:45:13.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz4BH6ASx2VCHCcw/4IJ72dvj6O8FnUrMqH6L+lWlHF3IYgOK5VeFPlwpyPvtYkviTfCxYIezcdnPft2nhBXgcJibiszTkkCMhgkZ0HM6BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=663 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150116
X-Proofpoint-GUID: gYum-rEum9XZZ-wFjoM86-o9HQaO0iHD
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68764d5d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=mqeI6qIbdLNxZsQMqRYA:9 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: gYum-rEum9XZZ-wFjoM86-o9HQaO0iHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNiBTYWx0ZWRfX9agEsQi+WTG+ IvhSbU8ARV+0CsNneSlOmDs8nsP0kNHWVvspi7Xhlsb5Z6ZItvObSW1a05JeSsPeKrPxFe+L5z5 Jy6ked1zM6smGAENHMruFFtVS3st/7tF4LgFFswDBvjY4Ro5GNMr7cA0vVs967cTnxpgkInPoC+
 UX8i7MPky7tQEtEXKnQooK8p/W8yYEl6j6kbbhsc5MAhQ6XguW+zn4lL0Ox6fIktksMhD/rD+s9 dE8ZU5nzOaZIGYGx/o6qVKQHsRchPt1FAtSWizRuh5W1ghr3CWsMsQWm3B4ERDqggew2A6zZIFC bF0ihkuo5igFhGv7JqPfH1l1bLLtkat4XOUNlbNAn2HpGumJFa1ibj3MPRvxKIAqjM95mwn8Wlv
 D8IV9C2IBaYug8XZnl/dUQu3pP2Sgc2k2SbZ+H8zsIlhGT8TMHnHQLYg0/yHjGvF73C8gNRv


Hi Christoph!

>> For PCIe transport devices maybe we could consider adding an additional
>> heuristic based on something like PLP or VWC?
>
> What would you check there?  Atomic writes work perfectly fine if not
> better with volatile write caches.

What I propose is making sure we only enable atomics when several
independent device-reported values line up and are mutually consistent.
Just like we do in SCSI.

Maybe something like this:

  if (NSFEAT & NSABP &&
      is_power_of_2(NAWUPF) &&
      NAWUPF <= NAWUN &&
      NAWUPF <= MDTS &&
      NAWUPF % NPWG == 0)

It would be good to have more Identify Controller data in there to
validate against. But since we want to fix up AWUN and AWUPF in the
spec, we shouldn't depend on those.

I just wonder if there is something else from either PCIe config space
or Identify Controller we could add to weed out rando consumer devices
that seed their Identify buffers with garbage. A heuristic like "you
wouldn't possibly want to enable atomics unless the drive also supported
feature XYZ"...

-- 
Martin K. Petersen

