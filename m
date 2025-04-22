Return-Path: <linux-fsdevel+bounces-46939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BFA969F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD8189F0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2C2820A1;
	Tue, 22 Apr 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IjuB/oa9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CS0Mcnzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCD281500;
	Tue, 22 Apr 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325068; cv=fail; b=e4Vz2jd47YTHt0MkjR9urbKfTOG6LdSvtPpK0nG8bLu+xnn60/W6iuf459kD0zW96eoiHoPDvB1cL7+nc8WSv0msSvDc4NEat/vcT2+Q4WDUsgrraFGvmg3GPs+rGRJDxmVZjGUQV/Xlr2PeGbzr//F8A4PJ/kUf0F5pGa2Z+kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325068; c=relaxed/simple;
	bh=s1rv24EBXPydx4NqYWkXeYbXMAMlqEWdFT6HvPEXIrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSmwWi4eJn69JtUMyGof0h+cMbe3iFCV2T1rAODPSNoBv/skhwNPFY3NDsxsPoUS3A9HcJsV2ekVJj7R8xH6F9gbQRSgl6dcpf61mzifAUampaI66b/m8tMD57WnQpJK0IIkCAdQUnXihfdQqD2ekkn4yFednyOIY5TKjiGzumM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IjuB/oa9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CS0Mcnzf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3PZU008455;
	Tue, 22 Apr 2025 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DPVFbFiC6SQWQbtGsc2yh92T0CmYbgowiG4bRgdKF8U=; b=
	IjuB/oa96j9ffqfrOkf06gs+xxGqLDuwB3dWSSGLbdCkFkcaNtvQfZC96JCtKOO0
	wEdO7aEEbDi5pfJ8Zxe4zkYcyLmM4b8k8s4zJUJP5gOE5dg3ejC2d4YOtQr6zbSH
	fCyOXLWCraSdM29U16PndmvU6+TvyyiGgbjKlV4ROQsD83X+pWN2onAJSuxPYo9x
	Oe+so+n3WgGqh22H3aHdsXbguZkafz7fireXQrRkKzuzspkOLqfzGOUp1zRTpSaC
	+xHzjFSR2cf+OKsHRmnQB+K1XEV3IjuqIYYWgP4bTCRgQBRTDDjEcVqZKKAf0dPo
	INVtb0guzEAy9QOAQY0fDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cdex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBtH9Q002293;
	Tue, 22 Apr 2025 12:28:54 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999v45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOmtpLgQtJdrWAn3yQVmcopnblLRY81timlWbd9f26QLJp5iRTGW4PHsowN9BZApMKFxFE8Hen4634c6+/iyVPLCkKs8G09ZSRXcYvredtJbJJ5mK7x3y5GhLvezo5skUyUHyRw8s9rBTzAVICSVEdj8VXbN0qhoEipp+F8rEIoCHC/TInpdhdG+hy9M2o7ER33ZtcxeRraZolK40afavpZLDgv1472IVDI6w2B0NOKTpLVmUVW/Nhu6adUpLQ/Qfccaxebz1Lav23iC4mJfxoP4MN8QAQLcKGZQmZUPFAeg3jHmtOIJthXnGbfFpbP21V/+u/T64U/L4+s2goa1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPVFbFiC6SQWQbtGsc2yh92T0CmYbgowiG4bRgdKF8U=;
 b=SZtdVyyfAUQlnyZd6moe20rNqd9jIbquxGeDHkd6Vl7k42gY+YTFouopwHG3pAF2wJe/S72A6bTqKrHwrFWpW9R2qv17pMwilO9M1prybd+H5zZpj6RtieKmw0T5bGcq2eZeylTqqZd5BnjusirqqJfIo+DvfGc+OKPywp/CHoKzj98ZwevOOhEvoPofr1N2+8mkneBBm/EXPnvWRDhs2HqgeGggNPIXQUW/9GXzWx22yma3wnEeL0cCadw1GRQAaaNKrI2a1oVaSGIK2vw+xViYplwZM1RLaOigxiSXxSA4I/G5Y2lhbIBlSkXgQYxY+jingl0H1po9r8SZscS8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPVFbFiC6SQWQbtGsc2yh92T0CmYbgowiG4bRgdKF8U=;
 b=CS0Mcnzf3UM9uE5Aynb3W4rsY58+uHlFq/Lp1zyH22/TdPk/CgaZw24O8WLAgwkp07dl5BA29elomQWBd6YG1p4XSWQu8oZDgdD8hgskuwdHt9WXMgRH9kVg0lAUYDesbg7B3IW5mZp7XPSaVgSX2P9ZswWv7tmqLZVgTnkX6t4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 12/15] xfs: add xfs_file_dio_write_atomic()
Date: Tue, 22 Apr 2025 12:27:36 +0000
Message-Id: <20250422122739.2230121-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0576.namprd03.prod.outlook.com
 (2603:10b6:408:10d::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 88eed099-28a4-41e6-85db-08dd81993592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42ojm/L9eY+OJ9+m0Ocn6KAkrVZ1KH4NY02pIFdBixiCrJjtFILGVwqrNv9A?=
 =?us-ascii?Q?1KoMPttfMxabYI0wiVUqPwgBMbS9cMWuoHyhnsg6gdsNHRQ7gdU3MwR3GxOZ?=
 =?us-ascii?Q?uEgc1wSDF6X6hJOapTF47vF5c7A4fQ/mgAbVS8HkJpzWa0Gx2GbgTtJ6f9eb?=
 =?us-ascii?Q?rsTDgtw5ae8+uTN6uPaoSgNaOEmNk9LbSyXsVb0plWO8PP4jBOpuXMS5T9tI?=
 =?us-ascii?Q?nZYQX2WNOVNrJmF8qAyF0xY97I/JW9iMEJipLeL8A0iVHOU24pe3XlRJnQu5?=
 =?us-ascii?Q?3YAePKy2BrKqMfJvyMgj0UoESCWE93Qxujv24N1o5JKmICVbj9UNg58Ie4am?=
 =?us-ascii?Q?+ElC/zWpCKei/GAKnYfgAqrTqduk+eZsbdN3UjR4kl0CPVIi2oKOPl2ZcGYw?=
 =?us-ascii?Q?0nvLSn2jy58T2WbIMtg1J332nK+Q+5noNGyA5Ku6YltdCESbiF4bsD9Yn51+?=
 =?us-ascii?Q?MJ90NOqh7eQ1TDVfWf/VrOSA/VifwHzieS4JI7KVWW4ExhQZdxl1l5smiFyZ?=
 =?us-ascii?Q?iXzrrwbQgFXVIT7P/B3lp/0m5v1soKblUvsg6zxA72RbNW/90GrZaUvPsezR?=
 =?us-ascii?Q?eCuy1IwkAoVbKpwK7kA8G9k6UAjknsXRv5OsHSy+ovSsB9+dohfBiRuD7wgx?=
 =?us-ascii?Q?qWnwcXvRs4c03i4AInjHvegJZdrPWWQJ4Nt3H5kNrrZATOfcEli10GPQjD1c?=
 =?us-ascii?Q?R6zLCdvwh0U7fp6sNjK8ds1arx0gIgaQ810pHD9vnWtSbaU4oOq6c6JMRuN8?=
 =?us-ascii?Q?0JDZszcnxNAvkP5aZmqhxPJnPBo5+DS0MGfs8l8WHm3x1NY0dgf38IsQtvG9?=
 =?us-ascii?Q?Z02YQyH6qwxRA5H0y+SxHsJU+Hw1PpEeR8Z71urpxZ6djP9KUlYC7WOT6eSz?=
 =?us-ascii?Q?agZyOUaJYTEf/3L92OCY1bwIaqO2MdKuFX2L1xuOIIkY1kkYo8vSl8Hh6yyO?=
 =?us-ascii?Q?OX/XzgP+lkRokikBOhNmw45oxLg7M27FMskks29sJh88Nd2e/3IU8vo5CYCY?=
 =?us-ascii?Q?apvTtJ40sMXI2DAc7xD6iGxVdgxJWf/POs6OKChGIHGxOTsCYnACu2ojxRIE?=
 =?us-ascii?Q?8xGevyPXYqsoxIciinHZRcGdhlLCvIC/7VIgtXflx372CHy1ErOa6HfFT/k4?=
 =?us-ascii?Q?pmdCmLcLzcX5db98vNY1Y1gmk2D6LFBGde+JTSG6xL/JLv1vof7tVzRd2g2M?=
 =?us-ascii?Q?643RZG9RCWyzs0Nf50lvaWVgtPqn81PLf3sxRHH3EqJT+HInCWLk9LK8TqU0?=
 =?us-ascii?Q?SQk2nlGs1BtjPVPqg1ZKNkU7ANfaOugxRnA0WraSCGqLJpb20WzaBU2MPOvg?=
 =?us-ascii?Q?RDZnn+docEoEvZ3LCoP9/9DPuHNesoKPD1puTFT+oI6RQI9EVRs+Aqvdaw9A?=
 =?us-ascii?Q?EL1Y7MYwrqkCaWn06a8WjS1zGMWCyhJXRJSH326KLa6rcCvEuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVhP0b4jUCbGt8OPAkCYew/Hw8z9ouqVQNvI9Wdg4DQ2AxfmhE3JEFKR8jx4?=
 =?us-ascii?Q?5RMJEx8q3+AYgHLqcUWLZzLcpvDYuT12vMLFPLbCi3gQwztIAlY1XHqJFGIF?=
 =?us-ascii?Q?hqyhexTQBvsyiAPDFZLA+ZnjyjRbIJtk8eVOuyYeh3ztA3xlHKBxN3rL7DgO?=
 =?us-ascii?Q?5eCEepV843BtQ7QcvZ2+Rbuc7XAHGVJoXAXnrk/HmY6873TcONjSq4NBrbY+?=
 =?us-ascii?Q?Gqr1mnVgRVRDBvd9t5Suh0mzyYs6idQc7J81t6WzmY3PsyIuKB8jia5GCAiP?=
 =?us-ascii?Q?nV1F2mvS52JLUbDxgGbmg9XPzOi9ug5bw9JX5fYLaHGWM0y2CsZBQYpwwiuQ?=
 =?us-ascii?Q?W7i18faiXN6cyJ78Ve7o7am0s8f9LkQz+gd4A3D2udas6eyc80sF5QhhPQY7?=
 =?us-ascii?Q?xhAnXRJu2G+LpyIKp6AUiKACLNRy9563sGYrwycGb/Wwwjkg7IiMKv3U8g7Q?=
 =?us-ascii?Q?BXzGG+VpziKKrG9cJ6KvC5DiPppLkLDuIgiRAnO1UuJ3ee1DD4DnsiozCLDf?=
 =?us-ascii?Q?7lREqK7r2rmHpjmTI5zpL6FLgsKiQ3ZT3vNuQLP3AdUovUkUQooyfsIxY9Bs?=
 =?us-ascii?Q?hRpuZSK/elr6UXOrdrgwGARkK3+QjfftkrAT4/R8MGD9Rmj5P457RexicD8S?=
 =?us-ascii?Q?t5QmuIdFAT6mPz7g409aenQgUrnmBqOtNH+6+nPR1+tIB19fDgOlw5erdB9g?=
 =?us-ascii?Q?iBzGuMg9IDR/5/YIH2YKMzz3LrMSwKeQJrrtP55U/k8T5eNLNQJvsGg4f78/?=
 =?us-ascii?Q?Jy4IWgmyigHJ6MvXxprVe+0DArphGkD5ctXG03EGtvuSjp1PdHw2hz9c4xZK?=
 =?us-ascii?Q?W9Kwe/GgM4M4f89k7KM14n0SqiDD4qq164qUDbzGcMLqho1D/gpkivonjDO0?=
 =?us-ascii?Q?j3HPDmdoHrV3rh80XnZkMZLAU5NIISZmg4NOYf2iSI2c/oflwA52BP6bzWbp?=
 =?us-ascii?Q?erAVXQOqlgWgykcnd2MfcZ/XRDc6OmGN6ZFs1w/t0L54jmDdc5JV6tbS2SiW?=
 =?us-ascii?Q?NbONBnHa+8Ug9yox9wCv12F68GOCTOJ08+sHeOzg6VJKhGpqhVreZzn2oQ4Q?=
 =?us-ascii?Q?o3iJRcnB2ph2hYWVqt7I/bPy5BBX37SMqM/KfBncUlGzeBgoCHMYJjfIWKwO?=
 =?us-ascii?Q?qJl3vHiniHwDYFPkWb/LgnHMlSYVniKQA+UE9Swk2Bn5NVhy5nH6Kd5w43mH?=
 =?us-ascii?Q?8cqPtsbFHRiiW9CHDOma54y+SnQCc9VRE8izdSFZCpfs2/Qj2McVt4XLYJyq?=
 =?us-ascii?Q?DCANdn7R7LapBPnRDOx+HTjrdjReV7Bh/55XBfnyWhHuPgVBXN5kV+96NZ0c?=
 =?us-ascii?Q?MaiFvEq7VJxnVak9duCFVIw+UDpdOS6VprEaU0ZeJS/NoISmA/EhjuK/ptj8?=
 =?us-ascii?Q?g7H2r8lkn7WzhSnK80/VQ5+R8XhNd9itplrrNZL9I3Fp3MW9tKPfFgB2GVyY?=
 =?us-ascii?Q?NO4/wkRAn27moi6rptLzRKTcO8/kqHVPhabZ7+rA12qBhKPt2ENRNqaWYPXs?=
 =?us-ascii?Q?brCOtzswQVtlkc6H4YimNhyHHjhNfEga9y31nzvqknK8uIEZZsV8IjUv71AP?=
 =?us-ascii?Q?qnWX3v5j1641BoN9tSWELbJor95sTPGpD9oAzKLFqyG0lo/0a/95Mbu7UHM2?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aclDEr35Lcf8xoIL1m7oe4c0p0XDHxHJ8cwZQD80Nm06iLenWejnk+VELBN3IC+e/G5SBjaj8LcZzwHzGwdnVCwd8qwsP+bpswo1Sg05kD16aiU4iUiWK6poutiE891rHl+BAJoRXz0JZxcMryKrd+wdGblyxvPWnMbxwfDYTUp/4bDEwrIQ/WJq3CPlY9NWD/S1UpIuzJYgavZSAsCkVLtcZF/G8ZuvqhvDLZX2X7bO8IkvyjYLxz2epZbAs1P8TC9G1gSnisdoKR0MOrKdkFgJpQ1//jmFyXvOsvdCPpfoJi5hUybxa+MHiQap2Y6KRKKBL82dVkjfLjBM7GSlGum4Wzrc8b70yfvsf1VJ9YVsW6Joja3iKZ3OTRxs9ZYxQEDe89cpW+D/hqZFkXQUVQlMRJ+ctPncTYVr6G2g0BPvAGJaCji7QqnzfzrJWlq7vkLpes0W0woYh/Gf9XDpr7tx7C5H6GyY869KAj6/Ygsy3IKkHw9Lp+kjSsGOgtpzVycNKZvk3/qmnG4cfZTxB9BoxG2BViHX4KQa2o3Z3NmVtrVGuqiEJq89hm0EweEP8omKBpg4b/RVOjIHAChq7POPjUifhrBEGRzTVWlQWpA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eed099-28a4-41e6-85db-08dd81993592
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:38.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKcu6Hnr2ojXuCaJsXYULwzwf7xyoMJSf3ikaSLbGJJrZ11BLIUb4/8D+52+8YLTc0DkPHy5UO/w72Z1og3HPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-GUID: twUFcU340FPUreyORMvLY0los9no5Krh
X-Proofpoint-ORIG-GUID: twUFcU340FPUreyORMvLY0los9no5Krh

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
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ba4b02abc6e4..000bbb0d1413 100644
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
+	if (ocount > xfs_inode_hw_atomicwrite_max(ip))
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


