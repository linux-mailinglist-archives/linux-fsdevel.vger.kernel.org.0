Return-Path: <linux-fsdevel+bounces-74739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIv1HCX4b2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:48:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D64C82F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D098960EFC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12A44A725;
	Tue, 20 Jan 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZuzZnZkV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s5+EMWiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A643E9CD;
	Tue, 20 Jan 2026 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945346; cv=fail; b=WmNadoVYUcEZMJWjoE2woXx09we6wR+1wQuqhatq80TPp790ssLpl5A5tAZpFJ1sjQBuLGNTnjs1Bn5wVw5I5caVfiJqGhztFrhFFZdSxYCBVZ3nXAuzsU0sshO3jVhqbpuC14IofM7ce5yiLp37AH3TLDIeZUujefQSmjRa3Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945346; c=relaxed/simple;
	bh=1xzOhMqnP344kxqlVAOgwNAo+EtrKu9WQLWg6PHCDog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIb5iudmzdx9K60T9uXQcG3cd2EDakvJy/yyjWCVav8owiiJqkHJaQX3OSuhRZ6Tjm9B/nm7Ml5uiRSNeUBd3tg/Y3DV4Vz/W+XKHzfFGnNRbrBwEQjySidgYl9rNcH0F8bGUoVZ9IB7RSLqsqw8tTi1Xc3WTH2FlpJDhIe7yj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZuzZnZkV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s5+EMWiG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKqU7e420947;
	Tue, 20 Jan 2026 21:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=96bXjUTf1L2M+fA/h3bNpq9ZygwO9lP5vSI4MFQIAJ8=; b=
	ZuzZnZkVncJ4P/q5yntAxAMBeYT6ne3XSDySbgrIdqvkRG1H2RgUlkjMPJX8xMZ9
	5g/Q/SywlZ0SzxGQ7kV7Wr46O8ktaPAtswuhj29ImsQt1MHKlwZVOlsQu1kFdbxI
	16cDpWyoYC39S3QYNedw/55dhdJmvLcMZCwbyha1rKsi5bfVcraBc+Gxw2yBIyv8
	FFYUW0JJMffcrnuukDeNtrUofcV4DWQ6kS5LO/Pxay/bm3+pAH500W5ZugNCOvR0
	dUmTYzcV/jlbHurANKex/llcJTe8rExuG4ihk7ijrltqX4gpu13m8lrvImcC8m9/
	imtRkcd3ges+FOXAKUzPOw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcs03j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 21:42:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KKldwA022480;
	Tue, 20 Jan 2026 21:42:09 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0ve2446-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 21:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHgQ1thuMlzdiqWG3szjB0vgmLFH55J3TWdGhbUkJkv8Y2XZcm1ILMj0wj1KyN+LcEXFrBgtBf7QFKhoYo5fgKZb6y5lLCvrGVFjRwLIrZZps4WIU14gZugHAWJdqzUTL3XBcT+TKd8CXrcLjJsOL2K8tDupcFI5ezebnwaltJT6Rw46ddP8BrF8ymDvzrJx53GYrKfgsacnjffN/QQUjaeh67lDhZuf0u/siCadTRwP/QZR8+p5ocrBOG5Tpo+i63FtZB2Y9yHGeFFr0LScCbaDhy2mqNzK2kPtfCO7bJsdC1SFY+GLOTl1IKauGLQkIMpJ1cgS8W48pc2A5LE2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96bXjUTf1L2M+fA/h3bNpq9ZygwO9lP5vSI4MFQIAJ8=;
 b=lPFVBRX8M1MxG7FsPWb6JE/wFJKouwmfJTIeJyVmu/zvp+I0bnHsJZhMbDyfYkhPM8cWzk6VhRnh3w0zYekd7k2NAo5Gx10BWcVkRgEewtRPWoPtgXJ+d7xeoWpqvuFJ6qMI4IrhV3zHJzYCEHKn3+Ak8eB44eKfy4Mwe8m+tTG2tOXVS3jS1mco3W4pVDNSzYtqqmJa9UFJQv6qResvbBnIss/MRRDZw0UwiWSDg1ZBgs7pBQj+fgQMZfk381FrEBYxJiPBnWO9yxK8F+cMfmQ98YR0m1DKvu2U2WT9cAgcn6KmEhUGezl0f/6GMQBsL7yYTvFEwECxrJE3qwIWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96bXjUTf1L2M+fA/h3bNpq9ZygwO9lP5vSI4MFQIAJ8=;
 b=s5+EMWiGOEdJPhGB8f/ST9xP2CtzRu6eNKc9GJyd0fTX896nCS4Kxm1jGgG4arwqrYAKu0E84DVZOxv8oBUrlcUFP8udxYChNwq0xZ0VzZOXy/pbB2lVLehbyAQWws4vmkDzufqkvb8+6AyahTjjQW11fdnNAlE2WnJNIs2kmsw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 21:42:05 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:42:04 +0000
Message-ID: <59921524-57d4-4880-9374-b9b420104266@oracle.com>
Date: Tue, 20 Jan 2026 13:42:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <f02d32dc80e1a51f4a91c5e3ce2a5fe10680e4ea.camel@kernel.org>
 <a1dc8306-6422-45c8-a5b0-8d10a4d89279@oracle.com>
 <f2203e755aca4da45b099b18aac03b0a9d299343.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f2203e755aca4da45b099b18aac03b0a9d299343.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:207:3d::38) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: cd13bcd3-ee8b-4abc-27a6-08de586cc0a9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OVFOQi9sb216Y1RrMjJJeVZ0RnBKM2NxN1NyRWRiWDNncGkzNnQ3NVY4ZHVh?=
 =?utf-8?B?by9iZ1hTbzFGMTFkVjZablgvT1IvbHM4bXZaY2RLbjY4dndnR0tQcCtXSEtj?=
 =?utf-8?B?ZzRFSW9tNmdVWm55MU5DV3ZFMzRiYlovcEgvTEFGc1ZRR2RORGRibXRKVUJO?=
 =?utf-8?B?Sk4zQk5XYmdGcEhhL0Mzc0FoYlRMc29jWldVTkVydHdacnkwTEhtVGV2ZU1a?=
 =?utf-8?B?MlNaaWQ0cEhzQ0JMdUMrVDE4WGREaS9KMmVLeWRBZUQ5VnNaWWhTVHd4TjRm?=
 =?utf-8?B?dVJsUmZZM0pIZXVXTmhHVjNnZVVGN2szbWhOanVDM3Z4OW41Q2lDeHpiajBU?=
 =?utf-8?B?R1VWV3JERlUzRWtmWEJxcmNMaEZRVXRTaFVTRjlMQTJmSjdhQTgxSnozUlQr?=
 =?utf-8?B?MkZueUJHazJ5aklTNzRobU91RUEvM1J1VWo5K3l2c3Y1eDJYdFpzaTNoeVJi?=
 =?utf-8?B?UkMvVVNmR01ONTZRVFZUOTI2TTNNOHBRMXp2SnpPbEdiMStKTEdyc01ObzBs?=
 =?utf-8?B?NXFWaHdlZTBjRTNYcnFUQkVMWEdnZHA5cEF3RlAzRFFXRUd4L29OUFBPQlVN?=
 =?utf-8?B?b2M1dDR0REE5MmVxTFJnc0hKWlVLMmxRZ01oL2p2U0Q5REdJcndXVU5uUTl2?=
 =?utf-8?B?eDBEU1I5aWd1ZTBvNUcrQ3VZZkJ1dXZtRjVmdEpOcWZvdU1pL256QmxCRzlW?=
 =?utf-8?B?c3c1TlR3bVM2TVcxTkFnVUlOU2h5MkFnaldzYUpvR0VXNm1aZytyeXJLL0hx?=
 =?utf-8?B?eGExVEl6T2JyZ0FZWUhYZ1A2V0lIOVp6aWdvQWdaaStSbjNiNS8rdHhUcWtl?=
 =?utf-8?B?d0Y2UVkxU001R2dHWjVPekR5eENVaHlPVnBQN2U3UWw0TWhLYkppTkJoR0Z4?=
 =?utf-8?B?aWhwRnFaYU1Ea3BMNHUxR2ZMb1F0UEZXU3AvbU9oK3lGUDc3N0FxV25Qc3dF?=
 =?utf-8?B?QVNxNkFwYzQ5ZE9nK3EybWlJR1dXamJBeFNYclBYakFLcmdiSXpZRkJQbXNO?=
 =?utf-8?B?bUtNc0h1NW5qamhOK3lWc3E3b2lyMi9GUTFPTEsyVUJJQ0NScExpQ2JFOHJR?=
 =?utf-8?B?NzYwR0pyc1R5OVAxeENtMHFiUW1GSVFTc1ZZdk1aNHJiMU45MWN6Rjlic1B4?=
 =?utf-8?B?RTVtMHRzelBEd2xVSm1PWm1tZU14WHJHY0kzSkVNcU9Ua2hUeG9XaHNYeWpY?=
 =?utf-8?B?OFdlNEJEbkE2UDZOQ21Tc1U1cmlnNVFpSDZmYVhQUXF1MmZBTWZoQTVkbXVG?=
 =?utf-8?B?akQ3UmY1Mm82T3VJVVlTL1RvYnhJU1pqQXZBKzk0V1l2MVZlblROVTVTcDhT?=
 =?utf-8?B?blFXSGMrMVVEWjMrWWtzSVg1VUdYbEJXSXRNYnA2ZHdocHh0OER3SW1paU9L?=
 =?utf-8?B?OHg0M3llb2ROb2lrdkRZVFBjYnZUNytxTzFzeE90SFdYSjkvMDlSTy9scGNp?=
 =?utf-8?B?WVBRWThUVXROcDBOUllja0NwZlVqbk1DZDl1R0E0ZVRodkh1cENxWk5XeDR6?=
 =?utf-8?B?TWNUUjFBaEV2VG5vaE90RTVGZWZrTDRtbnl5VXdGY3BWSS9FNVpoSjAzUHpF?=
 =?utf-8?B?OWw1Y0E0TUxOWjBmdVUzN2VjNy9rTUdkSG5ldXRWZ05OUGxaRUVQRkFaQkU4?=
 =?utf-8?B?REtxMkxQcWdCOVRCOXpGMmJ3SUpKTEF5b2Y4Vis0akpELzRmc09uQlIzVTJH?=
 =?utf-8?B?Rno0ZS9rOStMTGgyenJsNm5LczE5dlNDTUNTbG5vMzBvUHhRWWROb0hnYVp5?=
 =?utf-8?B?VW1RdkdQNjVsUjNFOW1JbnNhd3hBTlBmd05rWS9ZRVBnU2hMTVp6WXRTT2JF?=
 =?utf-8?B?azNRYWlSYVFmcXFsYmhMOWdvckhHZUE4dmpRYm05aThYck9ONDJtY1haS1FZ?=
 =?utf-8?B?WThhYmZqUHhpOVI0ZmZhcFFFbktPUEpkZ1RKR1VJcURzdlB6ZktOeEhpTmJR?=
 =?utf-8?B?cE5pS0U4MXFhYzFzN1RxRDdKaUpYeW9vWlVMWTg4eW5NNmkwZGNVMWs5TWpC?=
 =?utf-8?B?ZzRia3ROVWM3NUl4QThNM2VCMGhxTTZqRzQ4UmZaOFVZTVN2Y3dUYnA0aUoz?=
 =?utf-8?B?bmtYOENiR24vaVltUDdkalRUUGNxeHpTL0xoTW9RSzYyZUtaajNiY0wrV1Nn?=
 =?utf-8?Q?a+dI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U0FPYjFwUFlVMWlmTkRxMFlLT01XRVhLVVlNcnFoamJFSExJQ1pyU2tNcXZn?=
 =?utf-8?B?NDArREV4SGtqOElrOXFmUUdVcWR1dVFhY3FVSldncEYrWVBUYmI0dk1uUUZi?=
 =?utf-8?B?bWZMWVhpNWIrNmtWL3NaSG9NSGRTWkt6VnZNdXRBSWhDVVdCM0d3TDIxZ01X?=
 =?utf-8?B?U1FNc2ZLeXlydVV5bXJSdzJxTkpmcWR0bGRIcm14RXd5aWtxVG1ibDBOYVhW?=
 =?utf-8?B?RXdOTGxVSUxpRGw3TmVBYzc5RTN5NUR4dGdXUVlOd21DT2ZERCtXdjhqL0xk?=
 =?utf-8?B?V1JsdWZ5WUIyYWtwVW9kdFZRbFpIUzAxQkZWc3BlWThncFU4ei9LME03eGFB?=
 =?utf-8?B?RG1Eb2JPUnpKS2NIVm05enhvYm9Jd3EzaGp2MHRHQXpZMTd2VTJ2bVpOMHJs?=
 =?utf-8?B?REJhcmI5N2FHMjN2bzMvMGhNdGxUdHpzaFRXQ0FCL1hWQVlBQWpqdlBwblNQ?=
 =?utf-8?B?dHN6Yk1jaFMxckRPSWF2Yi9UTDlGSXlkRGJIMUxHb0NLeUEwYkNxWE1tU2Ez?=
 =?utf-8?B?T1BPN2xVc0tlcElMcXdOVkwvVmpiY1JuRjRRcW82Zng0MTM0Y0NxUTg2Z2xz?=
 =?utf-8?B?QUp6aUpaZ0N6ZXhFcG1ZNTIvRXZnZTBSbUROYWVFQWZZZHV2aWJCeFNkRTNL?=
 =?utf-8?B?bWFzSWtMYVVNS0hQVmtVN1pZNy9OWEVqc0hyV2RzTDJTV3c2VXJxMnV0VDJs?=
 =?utf-8?B?Rm9YWEgxSUtJaEE0T2Z2R2FOaVVFUlVtRS94aDJlMWxwUmhGU3hiQTJBOWlP?=
 =?utf-8?B?ZW11djZlckZjOVRERmR0NlJBR3JpRWhTbEtkYkcyNWtFMk5vaWZ2R0VGK050?=
 =?utf-8?B?TzZHd2hXUjdHRzUrbUdRZ2U5bWxIUXRyV2ZPV3ZzUTdjNjcrU2pHVUVLVHJ5?=
 =?utf-8?B?TTlOMDdSVjdkSGFFVHV6OC94TkpSNmNYcklZNERlVG9lcHdlUnZpWFpOZFNi?=
 =?utf-8?B?YVFHbFZKOE1VTVdsalFjQTdBK2gvYXczcVpVamtadHVrNE5QUEtoaGFjTmUz?=
 =?utf-8?B?OFQzWkJXeVNDWjVYR3FhWURoUEJOelE5bG55NmdLVk05ajBoR0VoeGJ4SFJN?=
 =?utf-8?B?d2daK2tCQVhGaTdjQ3RuS3F5L2M0VExuWDNBcmtKNDI0ZS9GTitadlJ1THdW?=
 =?utf-8?B?MFd3S0l5Nlhpc0JXWEt4MXlFL2ViZ2x3YURlNmJTc0FiY3NuS3FpVFdlTVUy?=
 =?utf-8?B?S013SktnR2QvZlRhSStaSk8yeVVTMmRPUno4OEp6ekdRcHQvcVpFRlBQQXRo?=
 =?utf-8?B?YXMzR2R6WlRaNFZoR28xRXJRVkZNaTc5SXliekhqWkpRd0VNam1xZWVBVnB4?=
 =?utf-8?B?cUlObmVud1F3V0ZDQWc5UitJTjA4OHN3ME1YMU5QcndmTFRQU1pjSHdRTDZK?=
 =?utf-8?B?dW10WkpVTGE2aEFnaGkyZEh1bmp5MS9ndnc3MkdnZDZHeWhwVDBBTzFLVlNX?=
 =?utf-8?B?RUhLRW9rNVhxK1ZHRGZiQldZSkVBYmhOMFprdTRoZmx5a1FSQUI4cWtIdm1a?=
 =?utf-8?B?SlhwTGZYenV2RHZPaDBiNEh3cktkalM1N3JIN3RuRmxUV1oyNTg0RlJZMDdx?=
 =?utf-8?B?SmVGNy9VYi9FMDlONFJnOEVPY3BBRklvUWZ4bnA5V2F0cUpVakZudGNvRzZ5?=
 =?utf-8?B?MGV2SUp1cEhCaGx5bC9sZmxaWVQzUnNWNmFVemcvQUdmWTd0bnNUVXFYVHRI?=
 =?utf-8?B?TGNMbU43TkhYS2RKOUNaeFUrQVpvYjNQYTcwcnAyOTlsOVRGZ1dhWjhHMlI4?=
 =?utf-8?B?OGhOL3p4Y0FVb1d3Uko3R1A3RUJPQ0tJWHhzanhiN0FWY2gwbnA4T2dreS9y?=
 =?utf-8?B?eTM1M0NxM3Q3THUrRlZlK3cvU3VGcVR2SEtUYUhFTW9STDliVnU2c0YraFZa?=
 =?utf-8?B?UWdOOHY3L1FWU2ZWNkJ2cHVrWjhWZVZYeGlCZWlOK3QxMXRiaGYwVjVXZ3RL?=
 =?utf-8?B?Z3FrcVM5aHREUnBBYWZHZXZENlhuUTVGcVZndzlWUnVmMlNLeldkM0xWaWU3?=
 =?utf-8?B?U3JtSmo0UHZtV29RUEZGMVA4c0JZcDRkcHJOZU5HckFrYlBTMlE1aG9jV3lO?=
 =?utf-8?B?Zks3YTZuZUpLMHJhVjRyWTRCU3FLOStFazIvdkVFTWpwTS8wNzlSQWFkbi82?=
 =?utf-8?B?LzYyNEErbzlTVDI2MEphSkxHdVV0K2RHampjcFRyTXZWblNocW1DdVRKQjlB?=
 =?utf-8?B?YVkzUzVPSStxdm5QUTZqYVI0M0s3bXhDTGxXRzhPWS9Uc0NDTkR5Mks1WFlZ?=
 =?utf-8?B?dE95Ykx4dDVRNUErQnNPL09PT0NmeU9OWlE0NmdWT1M2YnhYdkNJWkNQM0FU?=
 =?utf-8?B?VmxXUXQxVitZWS9ZZklWTTduekNrSWFlQ2RqdXVXdHRZUUtwUEIxdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QOl9I9c1HLIn6483Caqs+8KJuk/rpTF05Nqm6j5cHsFwZ2vvANW3IvTK07UK49dk+69HPAJ2oktZ/6+34LsqK7QG5qRaP/nNkK1sblNshmLG/bBOVbTsYEjppSZZnsfLiQrpHlXgGrphDoYY0dh0V1VK2xGolC2bsAs3icqxa95vesndGUuk9a+sSmgLkpV1F7w5GKUgmvF188Z74AptA6NtsnKc1RQgxgDfX50OBBPeExOIAPJ1FhVq+3pvdMUNYwS5sHt08gjoRrYwCm8X0TpZ+Lc9D8LJzuvWCx6/ACnv3HSs6aBSPjlOLd9/NVCbvlC311zuusn57kW0FI639wc0ZR6RjIR0GANqn6wbk6khLgidfDdhiDknUpgZep6sSH+avR4l5ZraWboiyEg3XubRg1MvHf9SkEvPh8wXjd5HL2lSB4XQ6yStxbZV17M3wa9IBzQgpLVJNjaZkV9GpvFMtJWAdDpeshTVLNFGmBdrb/3yV8J9RBUBjGqiDPv11kn7XAIRdysE0vG6WeJJU4mPwe0c5E4AFfAEOfclRPVld9CvVSwRbYDpKatQRxIO/s7iPiZ6qJolqcSQULeu1Fgi9bqURG/z+NTsZZTiPD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd13bcd3-ee8b-4abc-27a6-08de586cc0a9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:42:04.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LA62kyymqJtTV6tkpZccYehXCCT5S7VzGrfMv1t1TyIh26gmQ6Jph37yfZjS7GuR6e7rFhpP1wpBRQTH1PHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200181
X-Proofpoint-ORIG-GUID: 2ZSQfGigr3XG3LLMNxyT0vLdtG7CVoW1
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=696ff6b2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=XVlZSN03RrDhwIXDFo0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4MSBTYWx0ZWRfX5bJDQfw5fXun
 77gU/rn5jJ08nlghTJptR0P9Xxjo6Szj9aYoueRI6+gndrjK0xcKw3T5dzvZu7jsbM70Tj7nGuY
 b1u52hsmPD0ykfuIP1vzMCiSygDnV+52X9qo0pkj/r/c/G5J+cOBCjuhnmJebNH9h343FnNZdZ+
 sFHS96kTg3AdmLb7y8/SY9QdkMOeH2NDeJKghrM9LfaWuTLZQO7+EsqD0zJ52Mgh4qvwrtiwxTt
 Ah65nmXTtZ5w6HkIhzIQPWYpauO9987OA9ezWi7RTVyIDZLhlak8yYY4B6WLLAIoyU9BrW4mr5G
 /NtgiYysHBFOLQnnDAnXLMNMdzAnaCCmzACH1YxQB23UllWyFIOdX6eGujy2UsDYOyH1mJCnAgE
 iKUdnP+ebBnB1aPjzlAfinzK1U7z3SfwVhtJYSuXBVssRR+jtCWiA0Hq7UtHDfop+y3928LhjpX
 vmIZIcv56c1UxLL7uDuY/Wm7Af89YgrUyMYQLYGY=
X-Proofpoint-GUID: 2ZSQfGigr3XG3LLMNxyT0vLdtG7CVoW1
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_FROM(0.00)[bounces-74739-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 162D64C82F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/20/26 1:28 PM, Jeff Layton wrote:
> On Tue, 2026-01-20 at 13:22 -0800, Dai Ngo wrote:
>> On 1/20/26 12:41 PM, Jeff Layton wrote:
>>> On Mon, 2026-01-19 at 09:47 -0800, Dai Ngo wrote:
>>>> When a layout conflict triggers a recall, enforcing a timeout
>>>> is necessary to prevent excessive nfsd threads from being tied
>>>> up in __break_lease and ensure the server can continue servicing
>>>> incoming requests efficiently.
>>>>
>>>> This patch introduces two new functions in lease_manager_operations:
>>>>
>>>> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>>>>      allowing the lease manager to take appropriate action.
>>>>
>>>>      The NFSD lease manager uses this to handle layout recall
>>>>      timeouts. If the layout type supports fencing, a fence
>>>>      operation is issued to prevent the client from accessing
>>>>      the block device.
>>>>
>>>> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>>>>      This allows the lease manager to instruct __break_lease
>>>>      to return an error to the caller, prompting a retry of
>>>>      the conflicting operation.
>>>>
>>>>      The NFSD lease manager uses this to avoid excessive nfsd
>>>>      from being blocked in __break_lease, which could hinder
>>>>      the server's ability to service incoming requests.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |  4 ++
>>>>    fs/locks.c                            | 29 +++++++++++-
>>>>    fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>>>>    include/linux/filelock.h              |  7 +++
>>>>    4 files changed, 100 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 04c7691e50e0..ae9a1b207b95 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,8 @@ prototypes::
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>> +        bool (*lm_need_to_retry)(struct file_lease *, struct file_lock_context *);
>>>>    
>>>>    locking rules:
>>>>    
>>>> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>>>>    lm_lock_expirable	yes		no			no
>>>>    lm_expire_lock		no		no			yes
>>>>    lm_open_conflict	yes		no			no
>>>> +lm_breaker_timedout     no              no                      yes
>>>> +lm_need_to_retry        yes             no                      no
>>>>    ======================	=============	=================	=========
>>>>    
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 46f229f740c8..cd08642ab8bb 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>>>>    	while (!list_empty(dispose)) {
>>>>    		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>>>    		list_del_init(&flc->flc_list);
>>>> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>>>> +			struct file_lease *fl;
>>>> +
>>>> +			fl = file_lease(flc);
>>>> +			if (fl->fl_lmops &&
>>>> +					fl->fl_lmops->lm_breaker_timedout)
>>>> +				fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +		}
>>>>    		locks_free_lease(file_lease(flc));
>>>>    	}
>>>>    }
>>>> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    		trace_time_out_leases(inode, fl);
>>>>    		if (past_time(fl->fl_downgrade_time))
>>>>    			lease_modify(fl, F_RDLCK, dispose);
>>>> -		if (past_time(fl->fl_break_time))
>>>> +		if (past_time(fl->fl_break_time)) {
>>>>    			lease_modify(fl, F_UNLCK, dispose);
>>>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>>>> +		}
>>> When the lease times out, you go ahead and remove it but then mark it
>>> with FL_BREAKER_TIMEDOUT. Then later, you call ->lm_breaker_timedout if
>>> that's set.
>>>
>>> That means that when this happens, there is a window of time where
>>> there is no lease, but the rogue client isn't yet fenced. That sounds
>>> like a problem as you could allow competing access.
>> I have to think more about the implication of competing access. Since
>> the thread that detects the conflict is in the process of fencing the
>> other client and has not accessed the file data yet, I don't see the
>> problem of allowing the other client to continue access the file until
>> fence operation completed.
>>
> Isn't the whole point of write layout leases to grant exclusive access
> to an external client? At the point where you lose the lease, any
> competing access can then proceed. Maybe a local file writer starts
> writing to the file at that point. But...what if the client is still
> writing stuff to the backing store? Won't that corrupt data (and maybe
> metadata)?

The lease is removed but in_conflict is set. Doesn't that prevent other
client to access the file until in_conflict is cleared?

>
>>> I think you'll have to do this in reverse order: fence the client and
>>> then remove the lease.
>>>
>>>>    	}
>>>>    }
>>>>    
>>>> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>>>>    		if (!leases_conflict(&fl->c, &new_fl->c))
>>>>    			continue;
>>>> +		if (new_fl->fl_lmops != fl->fl_lmops)
>>>> +			new_fl->fl_lmops = fl->fl_lmops;
>>>>    		if (want_write) {
>>>>    			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>>>>    				continue;
>>>> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    		goto out;
>>>>    	}
>>>>    
>>>> +	/*
>>>> +	 * Check whether the lease manager wants the operation
>>>> +	 * causing the conflict to be retried.
>>>> +	 */
>>>> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
>>>> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
>>>> +		trace_break_lease_noblock(inode, new_fl);
>>>> +		error = -ERESTARTSYS;
>>>> +		goto out;
>>>> +	}
>>>> +	ctx->flc_in_conflict = true;
>>>> +
>>> I guess flc_in_conflict is supposed to indicate "hey, we're already
>>> doing a layout break on this inode". That seems reasonable, if a little
>>> klunky.
>>>
>>> It would be nice if you could track this flag inside of nfsd's data
>>> structures instead (since only it cares about the flag), but I don't
>>> think it has any convenient per-inode structures to set this in.
>> Can we move this flag in to nfsd_file? set the flag there and clear
>> the flag when fencing completed.
>>
> No, there can be several nfsd_file objects per inode. I think that'd be
> hard to do.

ok I see. Can we leave in_conflict flag there for now until we can come
up with better solution?

-Dai

>
>>>>    restart:
>>>>    	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>>>    	break_time = fl->fl_break_time;
>>>> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    	spin_unlock(&ctx->flc_lock);
>>>>    	percpu_up_read(&file_rwsem);
>>>>    	lease_dispose_list(&dispose);
>>>> +	spin_lock(&ctx->flc_lock);
>>>> +	ctx->flc_in_conflict = false;
>>>> +	spin_unlock(&ctx->flc_lock);
>>>>    free_lock:
>>>>    	locks_free_lease(new_fl);
>>>>    	return error;
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index ad7af8cfcf1f..e7777d6ee8d0 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -747,11 +747,9 @@ static bool
>>>>    nfsd4_layout_lm_break(struct file_lease *fl)
>>>>    {
>>>>    	/*
>>>> -	 * We don't want the locks code to timeout the lease for us;
>>>> -	 * we'll remove it ourself if a layout isn't returned
>>>> -	 * in time:
>>>> +	 * Enforce break lease timeout to prevent NFSD
>>>> +	 * thread from hanging in __break_lease.
>>>>    	 */
>>>> -	fl->fl_break_time = 0;
>>>>    	nfsd4_recall_file_layout(fl->c.flc_owner);
>>>>    	return false;
>>>>    }
>>>> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +/**
>>>> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
>>> Please fix this kdoc header.
>> I noticed this too, will fix in v2.
>>
>>>> + * If the layout type supports fence operation then do it to stop
>>>> + * the client from accessing the block device.
>>>> + *
>>>> + * @fl: file to check
>>>> + *
>>>> + * Return value: None.
>>>> + */
>>>> +static void
>>>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>>>> +{
>>>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>>> +	struct nfsd_file *nf;
>>>> +	u32 type;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	nf = nfsd_file_get(ls->ls_file);
>>>> +	rcu_read_unlock();
>>>> +	if (!nf)
>>>> +		return;
>>>> +	type = ls->ls_layout_type;
>>>> +	if (nfsd4_layout_ops[type]->fence_client)
>>>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>>>> +	nfsd_file_put(nf);
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
>>> kdoc header is wrong here. This should be for nfsd4_layout_lm_retry().
>> I noticed this too, will fix in v2. Kernel test robot also
>> complains about this.
>>
>>>> + *
>>>> + * This function is called from __break_lease when a conflict occurs.
>>>> + * For layout conflicts on the same file, each conflict triggers a
>>>> + * layout  recall. Only the thread handling the first conflict needs
>>>> + * to remain in __break_lease to manage the timeout for these recalls;
>>>> + * subsequent threads should not wait in __break_lease.
>>>> + *
>>>> + * This is done to prevent excessive nfsd threads from becoming tied up
>>>> + * in __break_lease, which could hinder the server's ability to service
>>>> + * incoming requests.
>>>> + *
>>>> + * Return true if thread should not wait in __break_lease else return
>>>> + * false.
>>>> + */
>>>> +static bool
>>>> +nfsd4_layout_lm_retry(struct file_lease *fl,
>>>> +				struct file_lock_context *ctx)
>>>> +{
>>>> +	struct svc_rqst *rqstp;
>>>> +
>>>> +	rqstp = nfsd_current_rqst();
>>>> +	if (!rqstp)
>>>> +		return false;
>>>> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
>>> This should never be called for anything but a FL_LAYOUT lease, since
>>> you're only setting this in nfsd4_layouts_lm_ops.
>> I will remove the check for FL_LAYOUT in v2.
>>
>> Thanks,
>> -Dai
>>
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>>    	.lm_break		= nfsd4_layout_lm_break,
>>>>    	.lm_change		= nfsd4_layout_lm_change,
>>>>    	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>>>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>>> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>>>>    };
>>>>    
>>>>    int
>>>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>>>> index 2f5e5588ee07..6967af8b7fd2 100644
>>>> --- a/include/linux/filelock.h
>>>> +++ b/include/linux/filelock.h
>>>> @@ -17,6 +17,7 @@
>>>>    #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>>>    #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>>>    #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>>>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>>>    
>>>>    #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>>>    
>>>> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>>>>    	void (*lm_setup)(struct file_lease *, void **);
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>>>    	int (*lm_open_conflict)(struct file *, int);
>>>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>>>> +	bool (*lm_need_to_retry)(struct file_lease *fl,
>>>> +			struct file_lock_context *ctx);
>>>>    };
>>>>    
>>>>    struct lock_manager {
>>>> @@ -145,6 +149,9 @@ struct file_lock_context {
>>>>    	struct list_head	flc_flock;
>>>>    	struct list_head	flc_posix;
>>>>    	struct list_head	flc_lease;
>>>> +
>>>> +	/* for FL_LAYOUT */
>>>> +	bool			flc_in_conflict;
>>>>    };
>>>>    
>>>>    #ifdef CONFIG_FILE_LOCKING

