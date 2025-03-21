Return-Path: <linux-fsdevel+bounces-44697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF54A6B807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB957AA207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDB1F152F;
	Fri, 21 Mar 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/IKHSwY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tLF8Gl+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994EF1F0E37;
	Fri, 21 Mar 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550580; cv=fail; b=RIfoRSBWTxF2wIwTgmKBtsR/VBUbV0NZP7oj7GVoPyH98eGfP5IJBdUrfkcfFdX+jp0Ge9TdbCe9JiyYz7y2L+Fm9r/z96x9KqbyEJCf3iQA10i+kgbwml1tVjoOOEi9JGLFW7mK7wREPNSH5kfwX4xdfJMgANhJsFTgGfqk+MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550580; c=relaxed/simple;
	bh=eu0pkQ9vvWXZBBVJFJjg3w3gkVvVQPLp7VDNqxImDaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkgueGOhPMkElHFNiRnfYdSBSKprJxVpxFPQziqp4RLI2mHfsz8M3JhOsWr9evOR+mPvuwUCAEWfNCaRTDaVJaC+BU6ASr9wJ+pBox9/L9tG1tbzeBCbEL84xNIW01CvkAcAbJfLmnEJ6wq7Ef85nVrXNW9IUnPO+Syg5d2JnkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/IKHSwY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tLF8Gl+I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4uIhI021683;
	Fri, 21 Mar 2025 09:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eu0pkQ9vvWXZBBVJFJjg3w3gkVvVQPLp7VDNqxImDaY=; b=
	H/IKHSwYiuNJwsOCf7mWyo7Hum4sSQ+cZKOX9VKjXkDrHVOaznbx0Vumh/Bof3RL
	DxmI9Au6exJxpM+JpXdxZJvlx19EPKQdfMo86XnCz110lxfqFcuTB+dHunn59DXP
	IwSmaXXKdFMp/X7wuKe/qVv17x+yu7zmusIjPxjhPbmN9GyCo8YveyJwCsUhjX1k
	BdJEWHClAWJsa9qkVq2Xb085kqIf82OZOoHwySLLCUV+PqCrCwm1xA11e+IJTutW
	38LbyHXUzg9sGmvxCzl1E5GBx4P3lRVJb197CCHFtguy1tAllg32PxxpmDNEi2n9
	2lbca4lKKECq35Orf/D2/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m181pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:49:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52L9Anqc018464;
	Fri, 21 Mar 2025 09:49:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdq8gf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmsq2ZIBQUPEzIJNRLZZsPhZ5pGnQbxGbJu4OUxCg3kF1dziwkBzA4QmY4l2Qe/ZnviyIzryCYWpZm6YeJIUUW1d5AMPqDTIHVyP6cNCzPuKDBbwmZKyjsel0L5vI5gHpvyHAFeG1GyKyEE0Nzwzo5g8u1KUhPcqZObzKfn3T5mQ/XrpSbLnNu/gjziThgw07kX0fTBbJJuBxyP2QqTTzr7w/5Sew21Xg2etrsf4/KB62qu64rg/jiw4ciS/nJ97T929R5O6l9kNxXi2LjaEAKhUyeaHXEn+UHs8NN1ZkNzmvdLQRxs4sFxcsJOnBJ+emAbrX6NsP5P8FY4S/CkB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu0pkQ9vvWXZBBVJFJjg3w3gkVvVQPLp7VDNqxImDaY=;
 b=Yjh/GWkW6jXNX296xTCvJnT01pcBeLadWjq/O8IoD8Z3Ct5TVLK+JQl9Ncl8ZXvTP4FDJ4JFb9/MOEOTPd6HvmdXMV5NgjxkGVcEa9lr38GvoLkywdLzryrQBa8smITgf75of+D3dJ7qckV6U2zFJfYMniSkQK3FBf7e8vNQpgNd28h/ipuuwKcFIo7FBBqcOmrc9VjkDhg0c6FFGpr9HE0YMAxB1yUq6cJIYJ+boQTFklp4hm/7TTrD4glAvsDZkzZexJERJog8Gqu9LGmO3JgmQv4BdZiyixyWkz7LAXp5jyHy3We32aqQ2TmUra6iwzn11LQvD3ZngwOWlYnE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu0pkQ9vvWXZBBVJFJjg3w3gkVvVQPLp7VDNqxImDaY=;
 b=tLF8Gl+IuJMAYn2mv67EikJjAzLpb9kevM7pD0mFzvmQpp49pxTy1OItNf3uwclI/jqf6WmIg6h2EN8NjuPZ5NyyJNPOFII9Rn3oaP8R/bBQ8JlA4Bsvtpy4PfrARwDazVFQo4yBZzScqvShSVqvY5z4+VVF0wcph10Q2esmAKM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:49:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 09:49:14 +0000
Date: Fri, 21 Mar 2025 09:49:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, criu@lists.linux.dev,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCH 0/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report
Message-ID: <6585818e-905f-4cba-b29d-a3e6390c66fa@lucifer.local>
References: <20250320063903.2685882-1-avagin@google.com>
 <24d6f7a9-82db-4240-a8d6-2c8b58861521@lucifer.local>
 <CANaxB-xuND3OoUqDrFQfN+xLwiWzY0SMRJ_RvF1+-emTuqNZkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-xuND3OoUqDrFQfN+xLwiWzY0SMRJ_RvF1+-emTuqNZkA@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 512c86d9-1299-4ff3-ed48-08dd685da39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3cyN09iSUo2NTdpR2VXQzRjZXYvMFgxM2ZneW94T0dVNWE4OGZjNUUrejJL?=
 =?utf-8?B?dnE0UXJxMGNwMWtId1BNV1pGRmhwQktiRFZWdGFhY1J6TEZyamhlajVGZWxo?=
 =?utf-8?B?eDdwdSs4ZEJqRTRpSUpYQkN2eW1SZDdJMjJENzZlSHg1UWtlSEh6MlAwTVNx?=
 =?utf-8?B?SmxvekJ1WVU1emVFY3RuOW5SR2tOUG9CNlJTVWlhUWIwVjVBazZyMDFlMVFz?=
 =?utf-8?B?cHc1a3R0TlFyMEVsb2FBaDdReCtYcTlHakp2VUtBbzgzLy9Da0NtVjZERWoz?=
 =?utf-8?B?WjcxbTE0OWtPNWo2TlMyZ2pQMzBnSUZtY1FESlc0SGtjQjdYMUVEVithZG5j?=
 =?utf-8?B?NGV6RVdBdW5pZkxucDZMRUlXNEp5MDV6cGdMYnNVTWFWZEo4UGFKWFFFNHVX?=
 =?utf-8?B?VkliUnNFdllTZGFvS3VyWVBOYldVaEFvcXVURmpybllpb3VOVEdYY2l4QUlK?=
 =?utf-8?B?aSsyMStaK1lzM3d0b3hmMGRCZkkyUDhqNVh3YVZ3a0x4Uy85dVpsbEJHOGFw?=
 =?utf-8?B?SElmNm5aYmJCNSsvWU5NcDVpWUZIc1BhSHNvc3ZvalVlY1Zpekt3bmRiQlFy?=
 =?utf-8?B?NHVEMytpeE5uQjZiYVZZaTdvUWFPaHkxUUhsR0RHZDFIOEgrbWJ0aEgyTk1u?=
 =?utf-8?B?K1dFaHNSM2FMQURQb284NG90dWhyQ2NweTJlSEV0enkzQ2ZGSE5Od3VNdTJF?=
 =?utf-8?B?amR0Sjh4emRGV1RCeEZlZHNCaEw0aWRHVUFucXRhamV3NDU4MXNUMWtRSDA0?=
 =?utf-8?B?bXJUVnpvVUVoWjlNNHF0ZG1qdmFQSWFHemN2cUtkdnI5Nm90MWZneEhRZkRJ?=
 =?utf-8?B?czBHUXM3am9XU3hqb0RTT1hFcFc5R3drZlRUVWpGTGg4SWtHVVZFemdWODZr?=
 =?utf-8?B?Y3EycFI5bTIvd21kN2plVGZlVjRGQ2JwdkwwaXcwKytLMkJiV3dDWG9OcGp1?=
 =?utf-8?B?S3JmaFhkZmZITVRVemVVR214OVYvQ1E5Q2ZsMzNoY3FEdFlFRWtUeDUvK3NJ?=
 =?utf-8?B?OFYyeENKcWJHQ0kxc2NVSWUyRUpDK0Fqb0pqYjR3L0FqOHpZaWNHY3pEdGhJ?=
 =?utf-8?B?dU5McnRJd2l5b1AzV0tQaVpXRU5BQms2bHhsQWtNRk1DTFB4TjZ4ZEtkRDRC?=
 =?utf-8?B?VlVzRU8wK043Z2t0WDdZUDNtdnNCT0tQT1JGSEhPaEJlWlBlaE1BYVUzanlx?=
 =?utf-8?B?ZUc5c2JpbnF0WWZTejVCbW9hK1VCeU9NWlNlMmRESk9jQ3JTalJOSGNudTBN?=
 =?utf-8?B?aFpRM3BDU1g2b2wwVmlXcTVMUW1YYzMwbnpNWU5scXBxS3ZXdW1qN1QrZFlm?=
 =?utf-8?B?Vm9OTklRTjg1aUZETnhjbGQwNGVvRlhjTHNlbERUVEVJMTRKQmtlR3EvdndC?=
 =?utf-8?B?MXNoNWlOYUhlZXpjTFl5Ty9jM2ZKZHNHMG9pUkdxeHdZV3Vvb1huTUNwK3pU?=
 =?utf-8?B?MlQxbWhCSngzamFIdWJsSEFNa2hpaXFvbzR5Y1V2WHZ0WHQ4aFdhdWR2Z0tS?=
 =?utf-8?B?U0JTdlpXZjd3ZVdIZ3ZSWXJyajk5cWJEMitjUkozZWt2RVh1aXNVVTVMVXNh?=
 =?utf-8?B?UUl5SHVpbkF3cVVvQlFERnppeE80ZjJYZFNWalEzSE5IdzFDYm41djM1eE1i?=
 =?utf-8?B?T1AybTB6UW83cTNSb2lNeTFXMGZDQjFJZ1RvQzZMVWZaK1RoaWZwVzAyeG84?=
 =?utf-8?B?VWRteDdxc29ITmRxSFJ1VDdJMnczMTFuc2NEQVdzSEpqZFgvRmZYRTA4dUkr?=
 =?utf-8?B?dDRmWFRwMzQ5b0U4czI1S2wyZTcraHZDR2ZGRXdBK0Z0cURxemNoSEVsYXo1?=
 =?utf-8?B?eW91aW5ROTVsUHp0andlcnNVZXlGTTg3ZTI5blA1TnIrOHVVZzZSM1lacXgw?=
 =?utf-8?Q?8rldyHEno+0yV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzIyUWM3ZzMwaGlwQkppSm5yd2ZIWndYNlZEekQvYXpaa0JKUmpDMUg2NE1r?=
 =?utf-8?B?UjJrdXp2VGc4ZDFUb3lBVi9yMGxVNkJKSlFSVDU3STlzQUkxdS9hT3RwL3A0?=
 =?utf-8?B?K1J3bHczaVhJL0FFamxCVEpVcDFvVDlOdEpvTk84dngvZU5NdDd1S1dNSmtZ?=
 =?utf-8?B?S21NZ2xiZ084WktzbFRzMU1pUlhOV1BDVE5SSUFqY3kyTzdaWTB5S09tZVVT?=
 =?utf-8?B?dWhXOGs4WUFxYTJKT293bHlNcHhjM20xSUh5Z1BtZXBvVDNmenNJbGdlUHNm?=
 =?utf-8?B?azloU2VpbXZWVnBrSFhYL3M2UUFSMEhHZmNGcG5hdjRPUFBjQmhIWlRhcjN1?=
 =?utf-8?B?TjdTMWpzeUNiTC9QT0FQTk1UTG4rWWZQK3pFRVVlalo0ZjcrZVRZbUFtcWQ2?=
 =?utf-8?B?by9SOVcrdm9SL2pBWHBxbHljV0llazV1VzhNT1NWdHkxcVRzK0U4ZUJpbkRn?=
 =?utf-8?B?YjRrSVJ2UzA1U2NRSGJiLy81K2Yzamo5akhFRDhXSE1qZDNFWDlhSE9rc2xB?=
 =?utf-8?B?TXJPZ0JDVlFZOFhlQjJGK3YrTDJrM2hlUEsxYmJiTGNXOEtmdzVMLytRbHhl?=
 =?utf-8?B?czI0WFJIa25TYXZSQlU1RGlmZlhYY1pLMVEzOTMxM1JlZjFJTUF1NVhZbDdl?=
 =?utf-8?B?eXllejlqZDZNbExRd3g2L2hvUHE5TlNPUytQQmJwZFkwbFFOdHdNVVpMZjhB?=
 =?utf-8?B?NmdsNDRpUmhuRGh1QUFoTTRoWnFhTUJvU29RVFhJN3cyK29GWGlQNG9aK1l1?=
 =?utf-8?B?ZFVnNkFER25zSFhyVXVjWkQwYVA0MkFLdjhaT3B5ZmdXM2toOE5Icjl4TUpE?=
 =?utf-8?B?OTI5Qit3Tk9xeVlLOVYzZUlyWGVkLzQrWFFZQTZUZGNxRml2SldnVUtDaTRp?=
 =?utf-8?B?L1AvR216YnFsL1R5S09xMURCQ3VTWkNVVXNEa0lEQkk0Mm8yZElUMWNoQWZV?=
 =?utf-8?B?Mm5ZS1k0TldsS0VjL0I1SGFoVDg4QjI3WFg1b2NqSFpFczd5ZFNhRHREUFZM?=
 =?utf-8?B?SjZpdklaMFNFSGhKMXFPUUpXTTduR1VxNXFwVjlXdkN6TGdDT0ZPSUdWYlJL?=
 =?utf-8?B?bXdJa2pDR3gydWlFdkdMYU1HbHRXMnFybXZ5eVlVdzZoajhVc0ovUFFNYUJX?=
 =?utf-8?B?amNCQnlSRU04TXorVDZRY3JHb2ZRTXg1aUZMdXZVbHpWNndjVUtBRGFDQjFt?=
 =?utf-8?B?VWwxS1VGcDZJMjNNbndPYWpBd1RWYkNzNEZuZHZ4NEZiY21SVmw3Z1BBYnlw?=
 =?utf-8?B?UVprSXcyRHVUOVlTd0lrdDhWNGMwRnBvNjRLa0tCWFZIQVdNYU8wTXVsWVdB?=
 =?utf-8?B?clJHRXdEVUpjcmRJbDhmb0RIUUZuMG5ISXdoenZ6WFd5cTlkZzZ6OFVlUGhh?=
 =?utf-8?B?UUNsZDFUY0xrbHpVS0xUUDFvdHJRUjllaWdybmJkcVd6ejJlWU1mbi9KditT?=
 =?utf-8?B?YU1RQUhaeHYxRXYxdGtoTlhCTVNpWWtoMExWQWRjWGxPSDJ4cFZjZkJCVWps?=
 =?utf-8?B?YUVXQjZwR0ZYM1IrYlk1YjY0WjlaYml5RkgzM281WjNVSC81MFVqTERmNmNJ?=
 =?utf-8?B?WkFIZjEyekFXYjF3NDd0TzhyNnpHNVJXc3ZZd21ubGpGTDBsOE03MDRuYS9h?=
 =?utf-8?B?dU1Ya1JTellWM1EyQk9RaHIxTUwrZzR4SFNrK3hIc0hObFVYaVNid1laaU1i?=
 =?utf-8?B?Q3FVQmZpME5zU0RlVDZnL2pkYnVyajEvd3ZOUzA2azAwNFdxb2EzVGRLRHZq?=
 =?utf-8?B?bGpwZWJaTy9Fa01lQVFrQ2RmVjhjZnJSUnNGYlBaSUJ1dm1XTC8zT3Jvckgz?=
 =?utf-8?B?RTB0K0VSNG0zYTZUWmdOVHQwQVZvVGY0cS9QdHJzNWsra0dSZ0ROQm1obTJH?=
 =?utf-8?B?am81TUVTSndnRUw5Vkk4VkQ4bENjU3JLSlJjZ0U3TUNWWHhlNndRNFBXYlZR?=
 =?utf-8?B?bGE3QnFrSk1OOXN5SzZBRFBYaXpDdVdjdFEzRlYyeDZoM3NKTWtGbEVMVkhV?=
 =?utf-8?B?eWoySnpQUDZEMUVLVGdrbG1nNmUrNDFzZWwwTlRsVFNUYlY5NmdQNVA0T1RP?=
 =?utf-8?B?dFpKczNDei9INWRmYUZlSEt2VDE4UnB5Q0NzQ3pEbTF6UFRkdjNtbEo0K3h3?=
 =?utf-8?B?MnJBamtBdmptM050WW9YUnVZNjFUMlYrdUhJTHlCTm5tYUxxd1psTXpkMWNt?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SH/hHzL3wB1X5Ec2hXSY64syLC2OuRpqaGA/dPK8IYuDi5SU/KAySeJbj5vq2enfcEHA4JkxmlEptGxqjYSTmnogeqYtoYI/bKlrgf2wmU2hanqH4J3DLiZcxDIzntrXOO4m4znwJBuUpbOFG1ehSu8xiEfoeyRnV3AhF/SRRc4uedrvydszSYZIRU9Mg7ajqlcDzbK4kepVtPzcnbcpAQPOVpBm8oC6VrJl1UUurYDHPPLEcxz1L/q3CRE8qeNeatOkYst9xrCJsimuzxiYdwFAecLOXTI0S00eLXDw3WVXD+lIn4ruu0dmTPvVImdbYEDD0/lJJfzxuRj5k7oy+Jmmh0+vkbbHj4VOyYX0HSx0raKVayZ0oPb38my3lB6Nk2dZxHywE3XFdYeeSG2+IfomBB/hPdK/6B+ur3bLzAh0zVCeBDuiRQPFIjY+nmS3QPUJ5LagssmKfZ/Pm/AkfVidTEnvHOfptSgsm9yvELnCsPodDC1Ocn1QdC7Ibs2CiVos18WZ/lIvxY8c4hxyFKLE7IfGlk6iH0duEnI7ob/ryP15FiSrN9mbZusFKZnJ+2hI/AbnOjiI4ad/FxCd3qiJjGVCYaT8b5JXj82tEJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512c86d9-1299-4ff3-ed48-08dd685da39e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 09:49:14.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TO9Dwm/NE+NcWEEPKyi9Jwco05SBtAPnwh1aaUscAi7/XN/U3xz2woZwbMu4KnNTb41zwp0wo6smGSbl4jM/p6+ihLwnfpQVJFyEQfD2Nlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210072
X-Proofpoint-GUID: VyykzMOovYesaIS6Psx1xo10imtnRB8A
X-Proofpoint-ORIG-GUID: VyykzMOovYesaIS6Psx1xo10imtnRB8A

On Thu, Mar 20, 2025 at 08:00:36AM -0700, Andrei Vagin wrote:
> On Thu, Mar 20, 2025 at 4:04 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Well I guess it couldn't wait ;) we're (very!) late in the cycle and
> > immediately pre-LSF (will you be there btw?) so this is 6.16 for sure.
> >
> > Kinda wish you'd mentioned you wanted to do it as I'd rearranged my
> > schedule to tackle this as a priority post-LSF, but you've done a good job
> > so we're all good! Just a little heads up would have been nice ;)
> >
> > Some nits and you need to fix the test header thing but otherwise good.
>
> I wasn't rushing these changes. Just trying to help and save you some
> time:). We'd like to backport this to older releases, but that's a separate
> task. I'll submit backport requests to the stable branches and hope
> (fingers crossed) the maintainers approve them. Sorry I didn't let you know
> I could help with this.

Please don't submit any backport requests yet, let me handle that for
both. I mean I'm a maintainer of memory mapping bits, at least, so I
approve from my side :)

Andrew's input is necessary for rest, but let me handle that just so we
don't step on each other's toes here too much!

>
> Thanks for the review.
>
> P.S. I don't think I made the CRIU urgency clear enough earlier. We're not
> in panic mode, and we do have time to handle this. The lightweight guard
> regions are in glibc, but aren't in any distro releases yet. We found the
> problem when CRIU tests started failing on Fedora Rawhide. We probably have
> a few months before the new glibc hits official distros and becomes a real
> issue for CRIU users.

Good! I am eager to avoid any issues here. You'll find us in mm to be
responsive :)

>
> Thanks,
> Andrei

Cheers, Lorenzo

