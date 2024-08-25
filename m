Return-Path: <linux-fsdevel+bounces-27062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1095E417
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881CA1C20B36
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95E156673;
	Sun, 25 Aug 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSIpiQZW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EmqPGN55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469538DF9;
	Sun, 25 Aug 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598806; cv=fail; b=dVTDsdiJA7GB05jY0bmmSTs02FgOcm9ol3oNfpghBnUQby6JiUHj82RNiGz1sk/d1FGR+TtQ7GtpuYGRB+3i1L9qqSjk6itVFrhQvmukuNdQIxtqUKhRow/Qbgeoufwi+vdYpAlrfAnfRa29UtABYBMiNPW0fB1iFR7F/qF7yZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598806; c=relaxed/simple;
	bh=DJ7s+zzHkW4IHUprlC16Vod+dsq3QBI5teLTPdZ2ILU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tuFT7I/plCweoALDF0QpAFQugtiuNChfV30j842EPWWr9jX3jfglyYv0M9B6hgG0SOgLx4aUYQ+N7dVkYKS0JH1gPYmAbYHBy9XbtxnysWMyC5ny60KYEhLv8ogg774tFYfutx7F0rU/O8LDKvRn4EblGV+u+y1biWQQ6iDFGUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hSIpiQZW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EmqPGN55; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P4Cg7S005918;
	Sun, 25 Aug 2024 15:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=PZuxVQmS1mYQ/ACD7rO7a+CQdMihHKJPd8TICihvGXo=; b=
	hSIpiQZW7Rr9IPC6Uj8tbYk6JIdiG4oYTfaXESJCF8HGUuVW6fgsbHIdy8PqSMAK
	vgzpoiSHWwu+KceGoqytbHcuXY0kNgcIjP+dYN2UbJ87s2wJvV4GprA0xxAGsGqZ
	kBFiImlEtnLMc+as8sIDGEZybOEzqg0Nsiai1B692yHhPQYlEScCXwMXXPeaH/Xi
	P+lrdi/Fr8UMyxQbwoslVQxKHphCwHO/cAmOKrOPrPIBtx7OTbe3GlGHybgzGQ9v
	96N/tZAhYoe9qeOs080A3rwcwK+oYX9c31xEYIcFY3vVZBip0lLEZvBpoU8tUwVp
	xKiLxuSRO7VGDzQQ4Qs3ug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177np9jm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:13:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PDE1Gj025589;
	Sun, 25 Aug 2024 15:13:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4185amsva0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udtAzw9bNIcYE2liD1eYQ+EMLOLR+xy0GSwXmAcSCsD7vhqY4iCret8jUDDk/HTIKFlkwbBVdBeUa76L/u1fljC+xglTGQea6ImdflZUhkfktZ/JGhZuVEEabyxxjdvs13ak7oNGwW26O/rNpLS0rNOKHdhdrDIH1+6yFPgLkAqKINS23a0cKll8AcQd7WfWsNGjAjR8GUdAQFF4SZOwyIEDLuhYqqyu+l2DNf7xodgA51bOSDHu04D33W5lqSvRivkD4H4aWbA9QQhL2vALbLPBSZideZH4MltMP2MIQa/pjwNAhjMdroMDc8GNCWzQ26ChVJWnuLeuweIo2UaeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZuxVQmS1mYQ/ACD7rO7a+CQdMihHKJPd8TICihvGXo=;
 b=JMFJS7vX8qSE/O6RAWl9A6qxnvEHPTqcyUcAGD1UuS13EBVFXocf+FHOqDyBB/HRe2a4ThdSeJjbkLaOkhdWuT25we/T+m2NpnkbqM1llvVMM52ScCc8dOU+zTFB5D/aFWu2Pb8K9IXKBdSYTm6LBd0xUunjrFIkBNk2u2i9WaVWy+GrAc3KQPQ6232BpReZ5LZKxQiMYwYMHgKZzeEuuBGfddwOksy2eP9zGe1LhMCXrKPubrDC5wdsV0FYsdPSaCgmwOXoXufdAsuoUVSFAJiM38Y3QF/9rrYaa7ZH4dOZNKdfhMY5gzTK6sqtW6ffJVgxH0IytyemU0arkbE1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZuxVQmS1mYQ/ACD7rO7a+CQdMihHKJPd8TICihvGXo=;
 b=EmqPGN55ciBqYihEyte87aGzwafK+21MlzOBSslPjKxiz1azqiGCwW3HfjpxrChLE9/2RAn3R/Pi2jGiZtv/sayHw6skxnNt7BZheoL0rjjDRFCCxKS1Rq26ER+oWvsRXOxBRHUkRqxsc3YpHO7Tsk4w5Wu5N1OPVNDTRsTkPHo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 15:13:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:13:05 +0000
Date: Sun, 25 Aug 2024 11:13:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/19] nfsd: add localio support
Message-ID: <ZstJ/3U8wzurV9uS@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-11-snitzer@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823181423.20458-11-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR14CA0059.namprd14.prod.outlook.com
 (2603:10b6:610:56::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9de018-7266-4687-427b-08dcc5186bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2daY2FmUllqZlN1cVFPRHlxQ0MraUV2QjRReUIwYlFTbktaTmk3TkRDcm9l?=
 =?utf-8?B?YXlYMzQzdlVoeTBhOWxmL2VDWGdHVVlCREtUSVgwZWZGNnhWT1RPaThoQWs4?=
 =?utf-8?B?bUJBN3V0RWVtTlJoSTR5b0hvK0JIYjNEUlE0b0xLTmsrWmlJM2pTcTdXY1ZE?=
 =?utf-8?B?SEFCMjMxYU1mM2VON0U4WTNWbk9HOWRDVzMxZThMOUppZ0IxSnU2ZkhVaXZL?=
 =?utf-8?B?VlZCSjZDZ25EK1FEcllMb3hjTmJPRmRIZXpDcXNoVzBvNW81cUZrYWFoVVB3?=
 =?utf-8?B?N1ZnY0FTVjhEOVFpbng5K3NuUmI1OVFGMTVVMFhtOXFIa2RuRjFIaTVEVmQv?=
 =?utf-8?B?Zm1mb3BmNzNuUXRPb1M1UDZTZzRvQ2JRWllkbHYrbWMwRVdGYTlQdlJ5QVVa?=
 =?utf-8?B?eDhBaHpLN3BxdkxscHhreXMrTFJ5SnZ3TWI4VS9PUU96RTRkUlRyNVRhaGUz?=
 =?utf-8?B?NlRXdytQcVIxOUcyczRURFpnc1IxY0JRMzFBYXlJdys5K2p4K2ZIcmJlWjd2?=
 =?utf-8?B?VjRxY2R4cENwdURiMzcyaWtDOCtITUZIbVd5dzYwWEFlRGdkQ2xiK1RZcHN4?=
 =?utf-8?B?NC9TRHJ5SStmdi9haXJpWGpsUUJLWVV6MFM2Q01Vd1d3aEtvS1hCNTNPUmIr?=
 =?utf-8?B?QXdMTzV1TkZxWWsrS0VzbHRxekV5L2VacTJUeldLVFYwY3FEaEc3bkF0NkxO?=
 =?utf-8?B?UyswZkNnTnRvV3FRNm1pZEtWZnVuYW9jbmJ0bXVnZHRYN3hkWVN1K0cyUisy?=
 =?utf-8?B?Z2gwaHFlOXc4Y3hRRDY5OTNsZUFzNXBPeFhxd0Y4THBCNHBZQnoxUDZCLzNI?=
 =?utf-8?B?Q1RKNWYrS2VjTmVVRTBiV2lSaGdqa2xKenRKNkoxa1hiMHlSVVFGb0M0L1E5?=
 =?utf-8?B?RDBWUnVLMFJ6elpRaTUrWnZkSW8yUFN2M3NLOFNnNEhqczhjK0pxV202eWd5?=
 =?utf-8?B?enBmd1FBb0ZhUk1ENmdtTGhycUNqZXNqc3VybXk2Q25WMDJoUWZCQmdBU3dr?=
 =?utf-8?B?RWIzdlY5Q2ZkYTVUUEVycU92czJLWEVBd2twellRV0hOdXprQ0loa05reTBl?=
 =?utf-8?B?TVNqYk9lWTVlVUFIdHRQTUIrS3ZjMmtrV25SRG84Q0VJOVV4cTRMNVlER2Jo?=
 =?utf-8?B?QUsvSGo5eUl4b0d2dkp0M3F0TG8rcm8rSDlMaC9YSnZZM2U1TlpESTdDTTVq?=
 =?utf-8?B?aDRWVm4rTzRyMDFXdXMwTmYxTzRJdUZyVzlVSEUxcXNVRUw5MlZYd1NxWCtq?=
 =?utf-8?B?YXBhMmJoOWlYU0R4bUlXYWdkNnk4UWhORm9oclFYekZPTUdnSGRrQWQxbVpL?=
 =?utf-8?B?Q05BTkh0dGFUdjBNSnJibi9UTnBqV2c1Z0NBUFl4b24xa3Z0NzloRlc4eCsv?=
 =?utf-8?B?dVZYdkRwMENMUVQ5NkVrT1o5RUdGUEpOMm91ZVcvK2laM1JrejRCQUh1VlpO?=
 =?utf-8?B?dURWYmducjVHck8rWjlxb2Z4K0lIZjc5OTB4Vm1vK1pIS0J2N1BZY0tiV1FV?=
 =?utf-8?B?eTB6Q04ycDlvRGVBOGtIMUJXSDZtSVpDWTU2MURQdjlZcGl6NndoL0paa3Yz?=
 =?utf-8?B?WnhUZUIwU2RSaHN5MmtvbzZaajlCL0hFQzVIaUZkNURBeXlXWUtLNmRuNVZw?=
 =?utf-8?B?MmJVUXFCc3FrUDUrZk5wMzlsN2F1TEJpUTFVSDJNOVNTKzhJODUwMHNVS3hG?=
 =?utf-8?B?ampJbC9PYW8vMXpNbG1MVitzRFI0Zkk0UkkyUC9hdDlCNW5KQWlpNSs1VU5w?=
 =?utf-8?B?bUxtSExXSFVwNGtLYTBGdGNNS1JoT0tHbHUycWY2SVdndlZUQjd5K1dYd2V2?=
 =?utf-8?B?aEFIT1N6WDlad0NsNXNrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFhqWFZmT0xBZ3pEVTlQa05mZlpKVmdOODdOZW5RVjdIeDg2dmE3cy9RMXJF?=
 =?utf-8?B?Kzdsbms1WEM2NFIvKy82Rk9IajZpUUluMnhEa1cwK1ZMRHk4d0FkcTVwdS8w?=
 =?utf-8?B?YjBrTXl0MTBtSmphTE9oVUZLdnZyc1pCMjhiUXh6LzB0dmdqV29TS2V2Nmpz?=
 =?utf-8?B?b2N6YUdGTXRVQUh3SjZNTHgxc205Zm1Gd3lneWZNSEVLYkZySHVqejRFVXFx?=
 =?utf-8?B?dXdqeCtOaytXQjBIVlM0RDg3c2tGei9kVmRHTzFmQ2FUVlV4TktRNGREZWRT?=
 =?utf-8?B?cWpWZUdBQkh0ejlRRE9BSkM2T29zUXJnY2ptR0ttYXRlZUxMZnlRcGkyUEZk?=
 =?utf-8?B?RklVZnVwSTVnazFUbDhaK2lnSHI2ZVJuamRmVjN2T1RGWFhFaFpkMndTWmcx?=
 =?utf-8?B?djNnR3JsN09jU1NQT2VCQ2c1RXEvejZvOHl1U3ZFb3BXamR1cVlkZGFvVFVV?=
 =?utf-8?B?YmdVL3BzT1EvNm5pKyt5Q2p1eGZNRWc5NEh1aDdTMGpxMGI0TWtKRExpOXR2?=
 =?utf-8?B?NGdjRmRKM2ptaVI4RWhsd2FCaVh5YXhmUEY4TXJVVFdTbGF4M1lHZ0M4WW9i?=
 =?utf-8?B?ZndYNXdITzVvK3RUenc1bmJabGxpeDYyL3hjTmJScFZER0o5K2xZcHBzaDVo?=
 =?utf-8?B?YkxIWjFuY1ltVTF2R3ZsY1pyUGRuWDI4dGVyeUtRSzQ2aE5JOFNQdVc4TWhs?=
 =?utf-8?B?QnZkM1ZaWDVQbVpVcnkwUnFHbVgzWTdBdnNVcC9vREpQclIySGg4R2YzRTFx?=
 =?utf-8?B?YldjSU5SVW1tQ2tzTlpIbGpRcEJ6ODhJUTVlYkJaRTQ5Y3M1MzNvMmpFK2Fn?=
 =?utf-8?B?dVNxUncyWWVUR3Zhd1dUNERZYmlTdjJpSEVrbERBSzJOVklKOGI2cVhwT0xk?=
 =?utf-8?B?Rm85RXA1SGl5NC83amNSQlNqTnNCZmNzNGVabitqaEYzbmQ4MkNJcDBMVXVl?=
 =?utf-8?B?R1JiMXpucE8yRjRRRG5QaW1rS3lPNEtQVDVqOXVZT1FXRjc2UU5KbU0wbDZH?=
 =?utf-8?B?clVucFlWaTlCdURZOWVDU25QM2pXY01wN0RESFVXdmo1SkxQT295a2dPZElw?=
 =?utf-8?B?azlTMytNTkpMMDhzQ1pvNG1qR1N3NXd0YnV1dDRKZzA3TWhDOU43VjdiRjgr?=
 =?utf-8?B?RWl2WG1LbE5wWklaVGVtRG5JVmpzTzJWZjZPQ0ZWN1NHUjg1VWRTTjU2VllN?=
 =?utf-8?B?Y0hUU0lOU1duY2I0VUhxYnAxdlNlaUE2WUM0cHlvcGhGVkFCallCUStuMHhR?=
 =?utf-8?B?Tyt5cVJZRWRncUxjMnBlU0xYSTA3aDdLN2hhWjFaa0VRQk5BdDdmRnhSanpX?=
 =?utf-8?B?VVRnQWkyOWd2TmpyMWFnOWlaWWhXcndGQ05Jb0pGKzFDekszVmo3OTNVQ3NQ?=
 =?utf-8?B?MjVpSXkzcy9YS3VtQ2c4b0o2d3Vxb3M3OGhxalpqemJkaHIycFQ0V0NXZTE4?=
 =?utf-8?B?amJ4TEZXWlF0aUhaZ2h4NUYzMjZvTHBjUHV0V1pNWVVPbW5RWGpzTTlKSHNo?=
 =?utf-8?B?NERmeXZ2ay9XNzJZdERpNWQvVWJSc1NSTUdWSEVPbVgyN0pMNERKVDdnYkJJ?=
 =?utf-8?B?Wm9oYXpBODB5YWNTcUd4ek1uZFo3RDVVZXRwS2pIRXBWUEk4TXdaSThvaEQ1?=
 =?utf-8?B?ams0cWR6VUpJUTU4SkczQUFRNHAxdUpabk5yU2dwM2FQQUxPdXI3SU53SXhx?=
 =?utf-8?B?SkJ2RzY4NDRqRzVzRi9oSDRSZ09PT1p4SHRVZVVhM2k1RWRtbmI1cFNFNzNo?=
 =?utf-8?B?RlZsbG9FUDAxUTEvS2Z4R1ZKK3lCUVdyblpMaExoTEZtT3dFY2NZcHRVcVNR?=
 =?utf-8?B?SGhjV3dDT3dWREpkRWk5MXlJZDM3THNUTmtpQzJrbTljRjZZdmJuOVBkc0g4?=
 =?utf-8?B?ODlQMDRVRWFNNVNJZ3RUWWZld2R5Ryt4S0J3ZTk1SC95OGxsUFhveDMwN3BT?=
 =?utf-8?B?VUxibC8yL2NQV25xcFpJY3N1M0wrNkcrVkdBQVFoaUVxZUp4ZHpxTWUxV3lz?=
 =?utf-8?B?TlV0VUQ3dlVBOXBndnBVRmYvN1Zhb0psYjlsR3NwSzgxT0c4VHgxS0I0Rkd0?=
 =?utf-8?B?dExLZnYwcVNTNlRkOXp0bHBhdU1lNTNkQUk2cko3OUVzcE1kUjJTd1RIQmJJ?=
 =?utf-8?Q?VfhqkoGxE06etnXW4Ve1Oas3c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dxyzN7+Ef/nlr1MEMccOAxE4E1ikSVibCR/ew5SGVOhlvnkUFc2d8fSg2wUoFiY4QhgcCZJVPr7EH1DlpRH3toW7nXaq6Xmv7RaXoNRFH518KmorHbxOcS1bn4ESeaEgHZqih1EuPqUiNYmR7iHnhvwC4bhI+yxilS7caVE/JjvlMpfwU1xi/p1KCUUA1641YpwVO05ZnL0r05TEXdmhmjDCSvjSTp7wJvlxacXaWqw92aELQqWTIU6Zpci2x69aOG0+jGApD0f/o4k6/hrj/3Qi/zoYNb/T4NV3jIR7HFcDjWFXbnYd5akXLzY5/EtKRg3nHSTnz1U4ibFLi78okLRWhsyuPgC3H7d7GrgA0I2Lqwr8sQEFbv9BIAJ71AOCzUBVKHsvKGPqmnYJr+nyyA+wIOWP7G23rIec+ZKX1ybEBR0353FftfDysqu6hxNJ7XQmx9T37gajUJzH+WMW8N8Uz+PVhC9yf9RBn06NCF6RyCR8Yfn2TSwJkLaFkW6jEmb8HnDrEex5FXzG5MlilJRMMBQCcX3gnUXRo8D86BL46ZFxOaeBJ/NXjODHYnD3Zpsrg3mk9z1GPfuST6CPRAjRGH2C7VMxrVlvNSaJGS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9de018-7266-4687-427b-08dcc5186bd3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:13:05.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXU9ALo0+z8vhtk8jDebr9mOL6blwCb+jHsK0V4lWw+pS9ND+tHOc7Jv/xD7qWbawrgjMKpu1qx+1pZj9Q5/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250121
X-Proofpoint-GUID: 62sI3yvEDZHbTvTriL2RpzodKquZa07Y
X-Proofpoint-ORIG-GUID: 62sI3yvEDZHbTvTriL2RpzodKquZa07Y

On Fri, Aug 23, 2024 at 02:14:08PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add server support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when both the client and server are
> running on the same host.
> 
> If nfsd_open_local_fh() fails then the NFS client will both retry and
> fallback to normal network-based read, write and commit operations if
> localio is no longer supported.
> 
> Care is taken to ensure the same NFS security mechanisms are used
> (authentication, etc) regardless of whether localio or regular NFS
> access is used.  The auth_domain established as part of the traditional
> NFS client access to the NFS server is also used for localio.  Store
> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> if it is local to the server.
> 
> Relative to containers, localio gives the client access to the network
> namespace the server has.  This is required to allow the client to
> access the server's per-namespace nfsd_net struct.
> 
> CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> A later commit will add CONFIG_NFS_LOCALIO to allow the client
> enablement.
> 
> This commit also introduces the use of a percpu_ref to interlock
> nfsd_destroy_serv and nfsd_open_local_fh, and warrants a more
> detailed explanation:
> 
> Introduce nfsd_serv_try_get and nfsd_serv_put and update the nfsd code
> to prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> client initiated localio calls to nfsd (that are _not_ in the context
> of nfsd) are complete.
> 
> nfsd_open_local_fh is updated to nfsd_serv_try_get before opening its
> file handle and then drop the reference using nfsd_serv_put at the end
> of nfsd_open_local_fh.
> 
> This "interlock" working relies heavily on nfsd_open_local_fh()'s
> maybe_get_net() safely dealing with the possibility that the struct
> net (and nfsd_net by association) may have been destroyed by
> nfsd_destroy_serv() via nfsd_shutdown_net().
> 
> Verified to fix an easy to hit crash that would occur if an nfsd
> instance running in a container, with a localio client mounted, is
> shutdown. Upon restart of the container and associated nfsd the client
> would go on to crash due to NULL pointer dereference that occuured due
> to the nfs client's localio attempting to nfsd_open_local_fh(), using
> nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> 
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/Kconfig          |   3 ++
>  fs/nfsd/Kconfig     |  14 ++++++
>  fs/nfsd/Makefile    |   1 +
>  fs/nfsd/filecache.c |   2 +-
>  fs/nfsd/localio.c   | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/netns.h     |   8 +++-
>  fs/nfsd/nfssvc.c    |  39 ++++++++++++++++
>  fs/nfsd/trace.h     |   3 +-
>  fs/nfsd/vfs.h       |  10 ++++
>  9 files changed, 185 insertions(+), 3 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..1b8a5edbddff 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
>  	tristate
>  	select FS_POSIX_ACL
>  
> +config NFS_COMMON_LOCALIO_SUPPORT
> +	bool
> +
>  config NFS_COMMON
>  	bool
>  	depends on NFSD || NFS_FS || LOCKD
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index c0bd1509ccd4..1fca57c79c60 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -90,6 +90,20 @@ config NFSD_V4
>  
>  	  If unsure, say N.
>  
> +config NFSD_LOCALIO
> +	bool "NFS server support for the LOCALIO auxiliary protocol"
> +	depends on NFSD
> +	select NFS_COMMON_LOCALIO_SUPPORT

Because this is a new and experimental facility that is still under
development, CONFIG_NFSD_LOCALIO should default N.


> +	help
> +	  Some NFS servers support an auxiliary NFS LOCALIO protocol
> +	  that is not an official part of the NFS protocol.
> +
> +	  This option enables support for the LOCALIO protocol in the
> +	  kernel's NFS server.  Enable this to bypass using the NFS
> +	  protocol when issuing reads, writes and commits to the server.

I found the last sentence in this paragraph confusing. Consider
instead: “Enable this to permit local NFS clients to bypass the
network when issuing reads and write to the local NFS server.”


> +
> +	  If unsure, say N.
> +
>  config NFSD_PNFS
>  	bool
>  
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 2a79c45ca27a..d7c6122231f4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -53,7 +53,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
>  
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..8e0cce835f81
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/nfs_common.h>
> +#include <linux/nfslocalio.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +/**
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> + *
> + * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
> + * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
> + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> + * @cred: cred that the client established
> + * @nfs_fh: filehandle to lookup
> + * @fmode: fmode_t to use for open
> + * @pnf: returned nfsd_file pointer that maps to @nfs_fh
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * On successful return, caller is responsible for calling nfsd_file_put. Also
> + * note that this is called from nfs.ko via find_symbol() to avoid an explicit
> + * dependency on knfsd. So, there is no forward declaration in a header file
> + * for it that is shared with the client.
> + */
> +int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> +			 struct auth_domain *cl_nfssvc_dom,
> +			 struct rpc_clnt *rpc_clnt,
> +			 const struct cred *cred,
> +			 const struct nfs_fh *nfs_fh,
> +			 const fmode_t fmode,
> +			 struct nfsd_file **pnf)
> +{
> +	int mayflags = NFSD_MAY_LOCALIO;
> +	int status = 0;
> +	struct nfsd_net *nn;
> +	const struct cred *save_cred;
> +	struct svc_cred rq_cred;
> +	struct svc_fh fh;
> +	__be32 beres;
> +
> +	if (nfs_fh->size > NFS4_FHSIZE)
> +		return -EINVAL;
> +
> +	/* Not running in nfsd context, must safely get reference on nfsd_serv */
> +	cl_nfssvc_net = maybe_get_net(cl_nfssvc_net);
> +	if (!cl_nfssvc_net)
> +		return -ENXIO;
> +	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
> +
> +	/* The server may already be shutting down, disallow new localio */
> +	if (unlikely(!nfsd_serv_try_get(nn))) {
> +		status = -ENXIO;
> +		goto out_net;
> +	}
> +
> +	/* Save client creds before calling nfsd_file_acquire_local which calls nfsd_setuser */
> +	save_cred = get_current_cred();
> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size = nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |= NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |= NFSD_MAY_WRITE;
> +
> +	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> +
> +	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_clnt->cl_vers,
> +					cl_nfssvc_dom, &fh, mayflags, pnf);
> +	if (beres) {
> +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> +		goto out_fh_put;
> +	}
> +out_fh_put:
> +	fh_put(&fh);
> +	if (rq_cred.cr_group_info)
> +		put_group_info(rq_cred.cr_group_info);
> +	revert_creds(save_cred);
> +	nfsd_serv_put(nn);
> +out_net:
> +	put_net(cl_nfssvc_net);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 238fc4e56e53..e2d953f21dde 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -13,6 +13,7 @@
>  #include <linux/filelock.h>
>  #include <linux/nfs4.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
>  
> @@ -139,7 +140,9 @@ struct nfsd_net {
>  
>  	struct svc_info nfsd_info;
>  #define nfsd_serv nfsd_info.serv
> -
> +	struct percpu_ref nfsd_serv_ref;
> +	struct completion nfsd_serv_confirm_done;
> +	struct completion nfsd_serv_free_done;
>  
>  	/*
>  	 * clientid and stateid data for construction of net unique COPY
> @@ -221,6 +224,9 @@ struct nfsd_net {
>  extern bool nfsd_support_version(int vers);
>  extern unsigned int nfsd_net_id;
>  
> +bool nfsd_serv_try_get(struct nfsd_net *nn);
> +void nfsd_serv_put(struct nfsd_net *nn);
> +
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
>  void nfsd_reset_write_verifier(struct nfsd_net *nn);
>  #endif /* __NFSD_NETNS_H__ */
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b02eaaea7d62..c639fbe4d8c2 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -192,6 +192,30 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
>  	return 0;
>  }
>  
> +bool nfsd_serv_try_get(struct nfsd_net *nn)
> +{
> +	return percpu_ref_tryget_live(&nn->nfsd_serv_ref);
> +}
> +
> +void nfsd_serv_put(struct nfsd_net *nn)
> +{
> +	percpu_ref_put(&nn->nfsd_serv_ref);
> +}
> +
> +static void nfsd_serv_done(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> +
> +	complete(&nn->nfsd_serv_confirm_done);
> +}
> +
> +static void nfsd_serv_free(struct percpu_ref *ref)
> +{
> +	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
> +
> +	complete(&nn->nfsd_serv_free_done);
> +}
> +

Neil set a good precedent here: Perhaps nfsd_serv_try_get() and
friends should be added as a separate patch with a patch description
that explains their purpose and operation


>  /*
>   * Maximum number of nfsd processes
>   */
> @@ -391,6 +415,7 @@ static void nfsd_shutdown_net(struct net *net)
>  		lockd_down(net);
>  		nn->lockd_up = false;
>  	}
> +	percpu_ref_exit(&nn->nfsd_serv_ref);
>  	nn->nfsd_net_up = false;
>  	nfsd_shutdown_generic();
>  }
> @@ -470,6 +495,13 @@ void nfsd_destroy_serv(struct net *net)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv = nn->nfsd_serv;
>  
> +	lockdep_assert_held(&nfsd_mutex);
> +
> +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
> +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> +	wait_for_completion(&nn->nfsd_serv_free_done);
> +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> +
>  	spin_lock(&nfsd_notifier_lock);
>  	nn->nfsd_serv = NULL;
>  	spin_unlock(&nfsd_notifier_lock);
> @@ -594,6 +626,13 @@ int nfsd_create_serv(struct net *net)
>  	if (nn->nfsd_serv)
>  		return 0;
>  
> +	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
> +				0, GFP_KERNEL);
> +	if (error)
> +		return error;
> +	init_completion(&nn->nfsd_serv_free_done);
> +	init_completion(&nn->nfsd_serv_confirm_done);
> +
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 01947561d375..ec8a8aae540b 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
>  
>  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
>  
> +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
> +
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
>  
> @@ -158,6 +160,14 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>  
>  void		nfsd_filp_close(struct file *fp);
>  
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct auth_domain *dom,
> +				   struct rpc_clnt *rpc_clnt,
> +				   const struct cred *cred,
> +				   const struct nfs_fh *nfs_fh,
> +				   const fmode_t fmode,
> +				   struct nfsd_file **pnf);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;
> -- 
> 2.44.0
> 

-- 
Chuck Lever

