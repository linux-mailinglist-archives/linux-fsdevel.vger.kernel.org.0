Return-Path: <linux-fsdevel+bounces-25803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D4950A62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034E11C22A3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36AC1A707A;
	Tue, 13 Aug 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eP++CCFd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MilFklRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765291A2C02;
	Tue, 13 Aug 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567043; cv=fail; b=RkRVTBcJi46rTJPZYNGArTGRo7rsNLB5SUYFFDXnr9Eunv9DZL9mkrraYWrBB6XQzJR6zIabIJNWUlKFRyP9RDoDxXRykjMhh9l33cEu/Kq1uh0M1MglQO6kpvbzQLUvHGuycKaoYoacVmrP7A5WkLiVjx4D3omUc31ooY+9DI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567043; c=relaxed/simple;
	bh=2ClA1e2FmbSnIZpQLwZEWmkHuRXPdreDCtFLRpEHgwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKatpwoWLPGS0cAXdTmM3pVMkYR7UdG5gIqucNBsCjVYy1f4qMTaY9gntLyM4oS4E+oZIHfBxCV+YT9ihllFCyzCWNMD/FPqUE2Vsk7V3T8rha5MstKTd4/IakUMvjGsV8etihwHxOe3kavMa0r7YsHcsH2P2QEukJcttENswqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eP++CCFd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MilFklRG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBT0M022167;
	Tue, 13 Aug 2024 16:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2Oh1HQs/HrD8Y+07swwT6A+lkbWoAZZpvbgy9K0ChVM=; b=
	eP++CCFdOh2EyCnNRTUKIbxgowaq9yJL0BymtNp2ubb/moQ2/Sd7EW1z4FFLpQpt
	J66uoZN1DVwu98pfiG5vl/MRUiFgRYGYClukV7zSHniYfD2odBHAP2rVcCLO9eU3
	1HIrx953ql5Rcsu2MX2U8QexxJy5t5MRbPy9v+EjgHfQxzjFVZUBsDGwsjU/LNgJ
	YEcXQqTnCFirIp/lzNJqnSgH1s7zYs/ZGEJ+UY8Y+BXn6YcIYvuvajCMNkINGMx2
	uJwVlGeSYphKr4Sn4pec5Cz7JBnuwgPQVwBkgJV+Fi7cu3Hz/In14PgytlqVQDhd
	7AmmRTgZVrTni5g+Lr8pDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396a9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DFriCu021164;
	Tue, 13 Aug 2024 16:37:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnf93h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USl7WTjj1blGMaxZgcFLM4iyuvFLrzNDRF+OU0j82V+odE7D7QHrlmS8KuGmJjqpgclEvYQniDxeN64wwIYilutZjCvKl2OVjZ4tpOpt8CoCfbqAQkK29wLg+YdDbsiKdjy/VNr724jahe2xPUi2E0xFQSMFzP9M8ionUwg+OaCnO/vgCj4JGVsy3RzzYvct7AjziOshliBE+73zCnZl1MXurgC4XTQmZ1OXwVziARoQKPQRxfZ18cfqlTlAmBgt9SnjMQCI8tUmwLcVaPz147Wla92SSQFq6pC3pDRmXexO2DTa+6fyYi9FbQYUIqqd0vQh2wOPku5V3S3OTlvXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Oh1HQs/HrD8Y+07swwT6A+lkbWoAZZpvbgy9K0ChVM=;
 b=GBzPN3L+qP9kx1CztdNTqnr4ur8oEc5pEHzFjg0PV+zbh96DKbBMwuXN/DHyReDfzelzZL84RTSU0rR3FZiBKmckvGa8vMX3139cbDDKOYDlsHexPBcffXQezqu8DvtDg+7YXpn746YF4N5RphPF9axphGcYbPHI7erOKBEg3+ktlv9NUYSfy1Z+Bi5jlzaD1OpVEe/XgQ+fhKocP+cOhYTTwZZ/DUVR2ItXsTA4J3EegZFoNOiK17ChP7H2TVkPCTlzJH802J0GR/c+m3iSLBXnv2eO5JL1Vnk694aHj6FgiAW3sqTARKpfVTMF8JaMEx7sHiMnPA8rJeLGPksAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oh1HQs/HrD8Y+07swwT6A+lkbWoAZZpvbgy9K0ChVM=;
 b=MilFklRGNbLv1UegNSqO9/EuHH4rafLi/4rI2GKvyxNuBYA1G7Z4RoiqRKbHF54wVreaJtGTA0scxt6Leq9AAWmu3y/GOPFgQIfCAsBs/leNWMfYA+TYDdEe0Syg4yonqcmQIw4OGe4MYQDRmb+TWlHd+F2hA33xeO+4MxUMOmw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 08/14] xfs: Update xfs_inode_alloc_unitsize() for forcealign
Date: Tue, 13 Aug 2024 16:36:32 +0000
Message-Id: <20240813163638.3751939-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d2c33e-91c5-44e4-508f-08dcbbb629f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/IwiWZeNAcSLfBPgNnvoaCbVPADW8cQF0OIszBUJ+zrnNhlC7ZE5FqnpdLfE?=
 =?us-ascii?Q?6WF52HEQGx5/UQzEcpan3JgiDf+e3V9lDM542/ie+fSVELAkmR6nBwBLZrgL?=
 =?us-ascii?Q?yHWm7tAYQtXYgWmDYIeoYEIF1IKe9ZOrk3JnEIk/WF9i83tmkBKDtP/9IuTc?=
 =?us-ascii?Q?pwWUaIFNTalA/W1EgRF5mC1NNRkeStq1ZDLuN7u/Aq3gnPI+c7PrZ6t31D8W?=
 =?us-ascii?Q?+YPFq8Dgqg1qiyF7JD34Qg9KUrxnqx8lxXhf/+o9h2D7PdzjOUm3HJLNZq5E?=
 =?us-ascii?Q?+SimIrc7DWl18EAvUP7lBlwEiwN1KncGRtwWtHzAxqcJ2viWLZyFy/ZmlOZQ?=
 =?us-ascii?Q?/wJccX9ZJvneV34oniaz49HvsOOHcZ7WdiYPC0tRuzYrRfZdkRXVrmQQvjTg?=
 =?us-ascii?Q?7NKA0jvtsnoQx8y+98y6Dqh001K+LZDZ1AUZPDKwf/wllJVPQQaPreOrtbgc?=
 =?us-ascii?Q?IbrxM7WkFe/7jTz36dx3mugMKY/m2kWCraca3ejSGUex4jmDHk4tUNDKSyC5?=
 =?us-ascii?Q?BRQTBOIHzROkIFbo7Jm4n+edyU/D/cl0M3ToibG6mqS4aAHOygZU685rhY8a?=
 =?us-ascii?Q?dmXVohPVVVfplzYTVqI7t+bNd/uEKA+gIkK0jZOM+To6u6sEk+g1k0dFEM3T?=
 =?us-ascii?Q?nI6/7E0txplnNCSch9TPa9h1d8KPYxKNl3VjgJ+iL8qqXKTLMvkQEgzePqNb?=
 =?us-ascii?Q?C10CJS6SMMEwL02qTUewLdkAcBzx12aKTZQdXjBAIzF4GjuuhF+NBRLcsZMb?=
 =?us-ascii?Q?uW/leARDXn4ljLQ8kW4ZUFLWEp3R4YWgBzYTLeF5TVE+d8IBkMETKXCJQWAQ?=
 =?us-ascii?Q?QTaiAiuVRnS5ziot1tnhKLIGErk7SRA5/4iCM9XY3mTee4WMGqChZ4B7Mwl2?=
 =?us-ascii?Q?hj9wqph76yEIzwi1BnjeFN3bRPY0giDTeRAAAiMFEGlaEffs3sNt5lmW9V+X?=
 =?us-ascii?Q?Mfvd9dZTWt6+EAmat03YcjDSQ5EPkApfAAbBnjQP72zWNPx2CTBnnsHH9sQi?=
 =?us-ascii?Q?F2OZ5aydPRPAUSxx3QsYNagv1pgFsgspaB2FWAmOm3lGXEqdajHvxRiBG4q5?=
 =?us-ascii?Q?HqLhAAfSQs6QlwX2F9H0mjCfTZli6reKJi+6vca9sGHSSyEdwK8GEchVjN7X?=
 =?us-ascii?Q?DbJNmdIDPvHScuZeBFpjubjW3xp0YcQdEuj6ihP2bPJ0++a3HcBs3xiLZ/4X?=
 =?us-ascii?Q?RovTASGYNs4VBFlPo1KLewLxqL6C3LEMn4ElA45kkogS2Mo9dNgDKFKrc20S?=
 =?us-ascii?Q?+UNfoeH69Yio7mLxqk9uDfCOMJJega1Sm/Mysp9m71IZnVzkOJOvxfyiJPR4?=
 =?us-ascii?Q?U8ofD/tw+F8XyBf9nM+XGg7sdz8V0YrLQIlGoDfBclELpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+vK/PWQFEbGZlCGy+00CDuAzPqsHTtI1ocGTp7BfSKx5oqW5HE44DCoiCdW8?=
 =?us-ascii?Q?wdgSyQUySu/LxZeZneRW1VRvuH0DUgRD/uw2tzYE7ooycqmB+p3fpSlSbD+9?=
 =?us-ascii?Q?5eLSsecrpD61WT0rEF8VyifKHvKSNrJNdXO+bZ/evWpS53SXq6giIk07yfLm?=
 =?us-ascii?Q?xJmwE/2EyW0Rcv9dIEhbEgIbXuX+HNc7qGFniPpNlHXlJCOlZM6c0E9FS+fm?=
 =?us-ascii?Q?1Orf4/JFq+cy5wZ8OCsQvNHgXDgqWeWKlFJRn54LSSsipZB66Tgyajnhe03/?=
 =?us-ascii?Q?1BpZJh28rHM8EuOrwMm5Dn6i6sPQhOScyjujBQR0oHW78I1xgl8ZqeEJcFOB?=
 =?us-ascii?Q?mzVlXdmTQnSQhrH88csgSAWB/OrLSp6p7TbJYsyAEBEr2nFm2eLFIYGrFHTF?=
 =?us-ascii?Q?Pq0yRNijcp0/JwWogMr2h5Oke+xMIPGeXflfa7juhHjkf57vWxwvvzj0KUvl?=
 =?us-ascii?Q?b0HudbQAzkqPrvsGljP2zSAP5hKAXBdKsK6JTWroD0V7vnHzay2zvWbstB38?=
 =?us-ascii?Q?pMOhLCByt/bAhBGktIRfgjuiIYUQdnIdHPoCAfxCvuX1/eM2LIDw05ozp8MU?=
 =?us-ascii?Q?DialwMS7B/eDpozJvLyCgCbP0jM8hFRvAubfJXUnaI59Af5Th2OjABRUF9OT?=
 =?us-ascii?Q?kKzJ6LfmOuh4mEikVhvs/zWjSgwh/KR/j7aS23Spz4Pe5EGnADclxBGgXq5o?=
 =?us-ascii?Q?2xHkZoBLwJy9wq5v6m0tyN43zd906kM4spU9Ql+UQ5yWzgi3X6xKWrAjNOY4?=
 =?us-ascii?Q?Kbf9bgXTfZ5CY5+RLHEJBAzfA7rBg8fCU9TqVUnyYOBGXFzLQz8Om81o9Zbz?=
 =?us-ascii?Q?kSLZ3xpTIiGZkUxqFAIrkmdir7Yi29iWHzCj2xisT6tMNugME/F5xaaW75Pi?=
 =?us-ascii?Q?DL7X6SpLBSGIMLV6WalYx2N8sgJ3LYr/EqXrgIZZRFDYhEdPi8RSP1gVaH8x?=
 =?us-ascii?Q?xFF488UnyqQXr1WspL3BOzXYJwKK6hrDEr/b+LfQcLBSNvR779sBkvBfqX3M?=
 =?us-ascii?Q?6A5XbkT4+eDNwIQgpYUPIMTAT2jLmkXF2bZmhpVPQGZ+RYXZxHcNDo1+7fYf?=
 =?us-ascii?Q?1lRN1a7XWqetvH2Librq1PDvatV12EtKwI9EFpuNDIm05K4y3Elg4nQrcZ1g?=
 =?us-ascii?Q?FHoN2PLHvpdp3mBQUpWhI3SUfYSMyRjg9W0fl3rNRbXOP+4Ra85V6VJSu76H?=
 =?us-ascii?Q?FFsm4A9pthUe2HcF3jJdGZHdqr8HJRtJ0kBWZBadrQ6Wx+f1UX4Rc5c8p3ZG?=
 =?us-ascii?Q?HBTpwykSTscWfOXiXAP8BlSoKhQFOdtzlF1DNkZc/ROFOgj5B9Fnl88/O7j9?=
 =?us-ascii?Q?q342al0zUlTLbhn7gQVnwvwgP7gIxl2qOqqMAb9V3q33R2L9Q8f6b2tf36o7?=
 =?us-ascii?Q?W6N5G9lnUtmM4JRPjK4ez8Vd6SwviLKHtmqdkewqHNDiVONlit4ViOBwoUrn?=
 =?us-ascii?Q?4TbwBCKt30rDubigQjLGuksv5yqSfoGZbSgHPgngMeqqpuuIIMzyMX1p32ff?=
 =?us-ascii?Q?U2E5vfEcH8eey5Bt2P/+wuA+ux+gJpIUuJPe0EGPcHNeveC2fNsqakGDUwS6?=
 =?us-ascii?Q?0V5hpxe1eJtAmDTDF6dB8c0G0eMxi6EOEyQtZuRuVDKcBXiRWDFU1dkqIBAb?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8OlD1cCLtsf9HlE3nCNqQJMrbyZyAMFlXf1/NMYuhhDNeGngG1W3oGA8a/UlPkf97Iy+8Fbqt9koW8bn78VizWXo94F8kI/n6c+vF1wjWUNxHKI8jXA5XgPGjuG+9YpQXRmHONCxrkRHbHwtV1tUgYOvXGqsgOKY/xdxwAdcKot4d6MfO65E3+ZJN/7g+K2GZ+6mTQJ5dl4ax/w8SHj32j/ZvRxZ7O2zsaXpz35O0JsUqgRVaw2wV/k+wAvEoXEnTBW8jsMUyjTdI+3riOalI3nbvO3cIL5JvnW0K09k8GfzIQ3A6PQ7IGgEzqxF3GrqDQnG1MWzcO5QOg+asCTbO6n30HUsGUst4KgMwD4PgaE3Calg5Sz1KM2zBNXQvGgJ9ci+XWHSYkGN9mizs5X4y+U+smyKBZiivpXBqKm1xNFy/CMSpNnhnKjUYTNi6+jagknkNYQmDh72DWKxwtXwD5qtgDr9q6O2h7BC/iEf6Mx2k1f9oZUmwzCu/u5fvgHrVMVNpwcTMvCVD/xi5xSm6Za6o82EoGfaDW5J5f817ymqPq7O2nlncyJ0Zi6vDscIvd4xT1k6Hq+ZujVFKONuIDTkeTw1ssvKKqHO2A+Jt28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d2c33e-91c5-44e4-508f-08dcbbb629f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:04.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBgNHPnZvqs1PTf4ClQ46jbJ1IeGpNHMvUPZz5Y+gNU/cdgZ4RY6y4Q8WvvvVtDb6YIXh/7mdgMKGFZ/+rV4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: xsoGDamHn5hx5UZ1DBeIcKRFMWNGrSGx
X-Proofpoint-GUID: xsoGDamHn5hx5UZ1DBeIcKRFMWNGrSGx

For forcealign enabled, the allocation unit size is in ip->i_extsize, and
this must never be zero.

Add helper xfs_inode_alloc_fsbsize() to return alloc unit in FSBs, and use
it in xfs_inode_alloc_unitsize().

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.c | 17 +++++++++++++----
 fs/xfs/xfs_inode.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7dc6f326936c..5af12f35062d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3107,17 +3107,26 @@ xfs_break_layouts(
 	return error;
 }
 
-/* Returns the size of fundamental allocation unit for a file, in bytes. */
 unsigned int
-xfs_inode_alloc_unitsize(
+xfs_inode_alloc_fsbsize(
 	struct xfs_inode	*ip)
 {
 	unsigned int		blocks = 1;
 
-	if (XFS_IS_REALTIME_INODE(ip))
+	if (xfs_inode_has_forcealign(ip))
+		blocks = ip->i_extsize;
+	else if (XFS_IS_REALTIME_INODE(ip))
 		blocks = ip->i_mount->m_sb.sb_rextsize;
 
-	return XFS_FSB_TO_B(ip->i_mount, blocks);
+	return blocks;
+}
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
 }
 
 /* Should we always be using copy on write for file writes? */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3e7664ec4d6c..158afad8c7a4 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -641,6 +641,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
 bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
+unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
-- 
2.31.1


