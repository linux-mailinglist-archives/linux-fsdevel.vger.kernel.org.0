Return-Path: <linux-fsdevel+bounces-20141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB528CEBDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 23:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DD62828DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103B82D91;
	Fri, 24 May 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqAXqqaU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6yu/XCh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15D7494
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587010; cv=fail; b=HZ54OhYOujLZrSxVQyDwtBgvIZgZCk2njjZox5lrxo4FrFvtbIYsJfK5KA8WG4XZkpfEnnO5veJhtBT2QTqp47L2kLTodGSH3oG9jJ7cMTWUC5WvDKqRZSW2hbsEQWYbhFM2g33X29d+zZiVzdoGqo5v7PfEtwQicUdLFLEef1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587010; c=relaxed/simple;
	bh=1DKJs2DsI+RFiNDOvGErzLcQnYD3xKgyYJqCXkrr4Qg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AzPpC1n8tMjRPySW/t4PZLe/3nAW3lI3h0KHGqLV52J4MaE+7zX8eaXsqJPbGadNz4s12LdSMpeECTJLrY58fDZ0QHFiks67xWPbEr2k5/Q6PoDpSNxf1bDi4POIp019LWngfiOFZYDQAjvJO2BumOZxMKpvKt2t0TtYpZI9//U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqAXqqaU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6yu/XCh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OKp1pe008573;
	Fri, 24 May 2024 21:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CFWu3BknDnkHJvu8QjkHwgE2KRKKBLhIBV2/YctjY4Y=;
 b=RqAXqqaUxEtgKO0isDNQxf66uDbvH/233jOBkE2xazr/Oi5Hdaz2lLob5GH4YtproPVg
 SjxQZWJ/HhQeZvRKLXI82h9rGxQ36kBMSHf6P4krVb31QZ2DE8CtvAIQ9cWOhf0dLcAj
 Hs8W0V6yJHYbtLtB+Q/kjWJlKRNuJNwooN8ozWQWFsgpxUpV+YtZtngOxSm0B1yUDvU2
 V290VApNYa+j6glFYw8Yfv125qF44Xg0t+TFSUy0Jgas5oZ3e1ZoD1XbB3RBzHv5Eq69
 Nw1WEReTPVjQm7lzLLRc1pA2BXp74KAboEEqciASGSByYAp3zttIrCkuWHTFyms/7IMy Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvdg0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:43:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OJpRwv038415;
	Fri, 24 May 2024 21:43:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsjdcat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:43:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y81g8Me2/KvS1VJ/ZMNY/4QgSU32tmBdpd9M/kDZQ3ajlKYb6pz7kdps++9cYQWXhRkViO7WncgcuuK4el4MSwiAa3z9mk8/n1i+ahQy7QHssNc7xPYbCOh9GzCyy79ZM1Ue9Iu/Y3Jdk2MFQfhNkSubSYtxzVYl56lD/qN5RD3JXl2sDTze3l5xrbbdtoFDlAIBXpN80kk/NNzYT4Awo1rhXrW/oJQ/xJd9nKM4EKfdOIlRUpzfMe6Os0dFC7Ge3XQ99bV5/ozdSJ+eqevRmK3pEATQ11JrrI5pBjBa+P4XKvtM3gM+v9FO/CejfnkwocyhchZSoLXzqH7tGmA/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFWu3BknDnkHJvu8QjkHwgE2KRKKBLhIBV2/YctjY4Y=;
 b=dAxZq45CacZ1YS1Xd5ckY6f9OMjoAwvqdDYoYspkmSax+DyVtBbQXfKe8iExdh69L4BH4VEVKKga3A0WA4866hdklDpGrx84QKWv4PvHawFYmPbeZy2gfZCljmcxSWb6sgBekd8B8HI/KJOB5aDjcUGOVtIme86QG2rUmPI95mWXjMlLHpysjaNJfs8AahsxagadLWhTUlsC2wud9Evnn4diBzvNnIhP8BmGY7LjdCVDyjosPj3wYbgHYDTYEgtTOBccitAtQc7Ia76S3OQioxTWlphXZUGTk27EJOSoMApquNZqB4bCkaGB2+O8P62gjpnCtBPH60i12+mK5iPh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFWu3BknDnkHJvu8QjkHwgE2KRKKBLhIBV2/YctjY4Y=;
 b=x6yu/XChCcl4/uyPgw+BHWHfuul7Ga+U1wyE0SiWTwi73nPYIR3w/1vTnCe0mPe/ZSMwIz85ky04bj9VOCvn4rNCdDe+YGazBMaCK2HoViOwR2+uLXw4eOAuyRSt/1vggcx8Ier4WtHTZMcErsYCrEi7Br0pVBkCUY7dcixY9Cs=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS0PR10MB7456.namprd10.prod.outlook.com (2603:10b6:8:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 21:42:42 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%3]) with mapi id 15.20.7587.035; Fri, 24 May 2024
 21:42:42 +0000
Message-ID: <ddc61ae8-a4de-452f-b546-2696a783012a@oracle.com>
Date: Fri, 24 May 2024 16:42:40 -0500
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 00/13] JFS folio conversion
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20240417175659.818299-1-willy@infradead.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:610:b3::17) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS0PR10MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a0ca78-c75e-4eb8-63d5-08dc7c3a70ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ODh4bmt4Lzk0YmdyQkpUYkgyS3gzb1daUVlkaWVTekIwNlF0bElCZW5oRVBa?=
 =?utf-8?B?Q2t2VzMxTDNzRk5IdDh1UHo3VjBtc084MGdBRWQwK3U1dnZuYzUvQ09DVStT?=
 =?utf-8?B?ZFFwbWtQNHMxZXA0a3B2cnk3aWFKRmUrYTZBWTVEMXBXZDFYZ1psNmVtWVFq?=
 =?utf-8?B?bjFmTVUrMDF6Z293bW83RGJWNFdoL3FoVzA5NFREZWVWYUFPaVY0Uy9QbWVT?=
 =?utf-8?B?cDJJQVlaTGxBdnE2TmI4SUltUG9ZbVhUQUdOblBXUXBtZFVieGVxd09LQ1ly?=
 =?utf-8?B?dUxER3lielJZUUpZOGhWSDhUcUNLRnQyS252WVBkQWd1MTRVbHlTeHR4TUEx?=
 =?utf-8?B?K2VoWHRwZTIwdkJkYjJhdGZHeXdaKzJXdXZxNFU0bjR5Z09Xc1FpcW04RnNY?=
 =?utf-8?B?SVM5RVRONkY2YjFobWp4SW9tbm16bUJkT2NxQVhiNnpBOFNhQ3pCYjhhWUF2?=
 =?utf-8?B?SlBRV01jVXVmZEtaTGd0ZUszTStvMlR1ZkRKUTlsaFAwcDBUcVNkeDZpbE5P?=
 =?utf-8?B?NGFrN09zbGk3WFY4MCtHVFZqNDBzMmY3d1hGRHdWNHEvWFZPSVYvRDNML0JQ?=
 =?utf-8?B?d2VMU1kvREgzSldaZEphdUFEVmVIRHl4UVB2TEp2TXRMaDBVL3RRZmFlOHJI?=
 =?utf-8?B?c2hKREZ3VGhTaHI4ZUZzNzlTTC9jVWRyNXFIYk9rVC8xckVQai9CMTUvSE1p?=
 =?utf-8?B?TmJnL1c3M2hyc0NoOTM0N3VnYkUwWnB0VGF3dDFtdzRpK1loeFZReE05cVJp?=
 =?utf-8?B?Q0ZJQVFpSmJXdHFnV3N6SUw2UEMwVTl2d1BtRjdRZ3dmMkNEYWE5djB3b3Ro?=
 =?utf-8?B?YWEvRTd5NGZkd1J5dC96UVpobkVBenRUNXZHeldxaGRVRWVSbHlyZTJZdGE0?=
 =?utf-8?B?VVphTVVnNjVtOURGYmZEQloyVEY4eWh6WU5ld1lFTDZDaGdDTEFzN3pNcWNN?=
 =?utf-8?B?RHdHSDBnRVkzSTFuWWpLaG9IWm9XTjVVVUJabllJdDFhVFpWNmNsMHJJOHBY?=
 =?utf-8?B?SkE2eldKaVdma2NBZGgxaFNBeTc0SkdSR0Vob1lZWHl0cjVqMDFHU1laNHZk?=
 =?utf-8?B?MGVlb2hhd293Y3cvZFRrVVQyYm1QSTU0cmpZV2hRYkcrNmpZUkwvWG9qKzJt?=
 =?utf-8?B?M2hWK2Q4V2dhK0t5c2lzdlIrVyt5NmZuNkNrelZqK2xxYjhFU0g2Z0thT3VZ?=
 =?utf-8?B?R25kQnRmR1BaK0hFa0k0MXBxdEFmZ2QwOWE4dnJjczdQVjV6NjFTNUdKd2ww?=
 =?utf-8?B?Z2ZHQXZjNXp5NmwxU2dDTUxUMVhxN256MUtVUjA4Q0ZJeS9Za3BoT05iT2t5?=
 =?utf-8?B?WC90Z2JxV1NUKytoM3pkUWFLL1h3Wlp0ZTY3Ri91OENxYW9ZMFdpeENUVEF1?=
 =?utf-8?B?S3FSaTFDbmNxVVFLL1VMWlJaNTVXcVlIZWFIQmluSGxRUTZoNlRPOTNlbWFx?=
 =?utf-8?B?UTFHQmltcXByLzBsSStvcXd6bHdFWU5qUlY0ZkNBZDgzbndFYWcwd1JrdmVW?=
 =?utf-8?B?aTdXTUdKajBMdy9oM1FBZndtU1Y1eWhFTHlrZC9ydnNQWFZVakV3dm9Zc3JY?=
 =?utf-8?B?SW5ScGNjSmQ5OG9neGZYV0xOOXhmTkszSzdsYVhCaFFwSUFVYWlsWDM0Zzcx?=
 =?utf-8?B?TTBRZlVVRE10SGg2cGh3TWlWc3RUdGVaUHlLSEtXNC9acmFNWGMwUWRhRHRZ?=
 =?utf-8?B?ZXluRm4zR3hROGNXV2dCRXVVamIwcCtibTdpcXRLVDExaHhGLzJ6UnZ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFVjV3hGWWN5WnNLQU5LMTZNSzhaR3BiR09BZXJ2Y2p3LzJ6c1ovVXV0Y3N2?=
 =?utf-8?B?MEduemlBeXRpeEVxVXk4amJyeDlPMjNnUEZLUUNXRTVBeDdHaGt6VzRCaTJj?=
 =?utf-8?B?Wk5lMWNQb2N2RzlVZjJ5cGkzdFpGb2NGaU9nZ2J4c3VwSHJCdjJFT2F0T21E?=
 =?utf-8?B?NEluN1BkS09hZTN1cFJWWnphd0x2S3M2cTVXOVdPaHNOQ2cwMzJ0YWlQcjZj?=
 =?utf-8?B?cTFjMmVDRUltNklMb2N5UnJFcUpCa1ZjT3dlY0FPckRqUm1KaTJDYkwwZGRL?=
 =?utf-8?B?STZnODdMRmx2MGdHdHhCTnJoN0xkQ3Foc1phL1p0elZLVjdCQnBMb1MzYll3?=
 =?utf-8?B?M1dlUC9EdTU5TENJUFlBQ1RpMHpEM2NVQVBjcXNQM1NXdnM3dmZHOVFLOC9X?=
 =?utf-8?B?bzk5UEY0dVBGSUNOcE4xQjFSb1NxUWZIb3hHOHJjeERZZmo0Y29GQjNnajJU?=
 =?utf-8?B?a3Q4K1d6cytvN2xPNlRZUUptQXRJOUVHdlFSV3M5VGxPRVhkdjYzNmtDNmQ5?=
 =?utf-8?B?c3gzVTcxd2F1aVNpR2NDcXZGY05tQTZxUnBoZGQ5WWFLVDA5T09ERzU4SFBs?=
 =?utf-8?B?K3kyVmZtVGxxQmRURXZ2ZGtQVG5DNy9XLzJlaFZXYWhxMG4zYlcyeHJ4dk1o?=
 =?utf-8?B?Y2FZSzZFZTZ5dGl4OFdIOXRycDVxenBrNXdlSE9vdnhGTWVqbmRvVXVoemY2?=
 =?utf-8?B?VGEzUDNmR3gyUkJHR1F6L1BlMkFJT1oyNVl1a1JjZmJycVhZeWRrSUV2S0FD?=
 =?utf-8?B?eHBxSHVVUUhLaVgrbG1qTEt2UnVIWEJCUktJc0tpSXRGdVREU0o4cHljRnVw?=
 =?utf-8?B?d3U5b0pkMW93cHNyV3hvZjExdVdyelE5S2pyZXNLVTZheWRBTVVvRjd4bHFp?=
 =?utf-8?B?eUt6WDdHZGY2ZHQ2ZXR0b2plUXNORTE2N1lVWHpGb2U0czBOaXlaTm8rREo2?=
 =?utf-8?B?cVZZMk9WekY3WEZJOHdqMW1QZTRjSngzVkEwNXNIbTBCKzNhN1BLa1ZpL1p2?=
 =?utf-8?B?VDFpUEJ5Y3o2ekRkSDVPOU15TXk5c0tBd0JFdXVKZkhhZXM4dlowVStnRVV1?=
 =?utf-8?B?SUF6OTlRbHRFM2VQK3BMbTV5eXljenZPQmNIcjhoYmxrTnNWYU1RcHpoVk9u?=
 =?utf-8?B?QWRJQ1dURmU1NTdMVXFoS2dUVytDazdnNWk0aTQvSTZJbmduVlJTUEEwTWJq?=
 =?utf-8?B?YjZnUmVvb0hTUURKNHNucU9TT2VsRC9HT1RKQjdEY2VrT0V5ZEZJcDVkK1k5?=
 =?utf-8?B?dVIwd3dyVllmRGVhbG1OK0FaOEoxTGIzVXhJWnVwRDloQnl3NzdqTGNHU3Jv?=
 =?utf-8?B?RS8yM2VHd20zRFpGRnNPR0tkYUw0NU1Vcy9ZSjdOclFCSUxMb2daL2w0T09s?=
 =?utf-8?B?dkw5Ry8vT1FYaHdoUTJaRVdhRGY5c2llQWF4UG5zZUM2OFFCM1g5RWxQQXVX?=
 =?utf-8?B?ejNES3NHTUJLSG0xZFhaa0dyQzc2NjJKUG04dXRjNEVoZnFJbHc0OXp6QzdD?=
 =?utf-8?B?Vk5FWHZsdC9nZVNoRHFDTUpZSzNia0V1SFlUSGdUMmRjUUpwenQybzFDWW5K?=
 =?utf-8?B?aldncU5sT2R3aXpLZ3JZNlpFVXFNclhDRlJiWmlqYnlGeXhuemtsRXFHeFEx?=
 =?utf-8?B?R3l2ZVR2elFwUTM0RjhwMVptSC9lVVdGLytaZDRPMzQzTnczV1lpSlU4TkZP?=
 =?utf-8?B?VUZDVE5WZkE4eWxWTTBxcndtT0c5UnFLWFMreEY5OUoyakdYWktvZ0dpWWxx?=
 =?utf-8?B?Zzl3bnlDSTl3VlorWkZweXRNek8zOHBYT2VtQnF0REJmK2pHUStzcy92VWdj?=
 =?utf-8?B?YlpXYXgzM09uaW9oNXlzaCtTK1d0cmFIYVJ4YVB5S0EyNC9ZUGhFZFpiK1VN?=
 =?utf-8?B?VE5tWjByWG5rYmJkVjg4eEx5b2tkUytYekRkWTdJQU4rdnEzMUdJcXYrQXRZ?=
 =?utf-8?B?Rzg0UXc1d2RhQ1B2eWJYTXp2ampYbTZKZ20yRmc5VWJPbzNyTlE1cHdQYVRs?=
 =?utf-8?B?SEE5Mit0N2hXYkJuUGJnL0N1d2kyOEFGWW8xaXFJd0dYNFdKcDJ0REt1dzFS?=
 =?utf-8?B?ck1ZSFArSk9MaTlOOTI0cnZLcTJXWXd2S2h5K2V2QWMvSHZJNURVOGdwT05U?=
 =?utf-8?B?ZVBWYXFKZUM5MkFYYWVEUzNKRUc5S0doRUNMdXBodlNGOFVvUlRoVEdnamgy?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uE5RhFfPPnkFLVl4AU7rqETP5qaMa1/vYQ0z5E5MoP1EYDXhvb9Ly9bWjQ3CaAZ2mrjjOAVgtgLdCk8PzyYtZGaCjl8wcmo6m/r41GPxoAu954ob8Oim023QqCe/e7DeInAHoDF3gMr+EIiIxtztP2iea4YYgr0XQQguwWPEEGwooqWo+fkucgYCDIGIDVnHRMIJFQGIK8PbK0FtLcxo8pfNNZBrBujLHnNkklqkT7sYe5HisW2LzKILyhcYsKXtQJqoprSdnkq4ZHBs8YZHh7qhinVAY7LB/MU9c63potByN1B6VhbOASNWeSeR8ZbHeuFjFC2D1f1cEOetR00ICbQeHved/Sgg2kBlFBrf0ZGItKvcOOSICIag9VwRgcWa3A3m5koM763Raqv6q2+X715Ov8SFeiK2l7de8kPSyXMffKztMTCN3M+Dk81iazlAh6l+K5XVEOuXf/wWDWEQ4cuPBr0hb8FwcL+ikaaQuz+ahQrOGfcMpnQ0ROzTudCQ1TZfPEyLzdSRM0S/TIFKIwHOg7U+bsaQYTR82ExV4dacc817yeqylK2WMEuYMiNcrYdLeGShVVWVex+Y6pyuXkHDWJMmA/xvNp+PFlLKQB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a0ca78-c75e-4eb8-63d5-08dc7c3a70ed
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 21:42:42.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGBnNjsYS/kqiIOQd5/M1cKHBFryw346qPtUPt7EpaCnD82AbGxD5DMhUWzwaUxyFN8ogBi0jibYFeLWren/IS0fdrGCKVNRFDdETGtFlGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=948 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240156
X-Proofpoint-GUID: FoBESod_gC2I2RNWa-Pa0jObxsHALcqB
X-Proofpoint-ORIG-GUID: FoBESod_gC2I2RNWa-Pa0jObxsHALcqB

On 4/17/24 12:56PM, Matthew Wilcox (Oracle) wrote:
> This patchset removes uses of struct page from the I/O paths of JFS.
> write_begin and write_end are still passed a struct page, but they convert
> to a folio as their first thing.  The logmgr still uses a struct page,
> but I think that's one we actually don't want to convert since it's
> never inserted into the page cache.
> 
> I've included the removal of i_blocks_per_page() in this series as JFS
> is the last user.
> 
> Tested with xfstests; some failures observed, but they don't seem to be
> related to these patches.  I haven't tried with PAGE_SIZE > 4kB, so the
> MPS_PER_PAGE > 1 paths are untested.

These patches look good to me. I'm pushing to linux-next. I'm sorry I 
didn't get them reviewed in time for the 6.10 merge window, but I'll 
target 6.11.

Shaggy

> 
> v2:
>   - Fix build errors on machines with PAGE_SIZE > 4096
> 
> Matthew Wilcox (Oracle) (13):
>    jfs: Convert metapage_read_folio to use folio APIs
>    jfs: Convert metapage_writepage to metapage_write_folio
>    jfs: Convert __get_metapage to use a folio
>    jfs: Convert insert_metapage() to take a folio
>    jfs; Convert release_metapage to use a folio
>    jfs: Convert drop_metapage and remove_metapage to take a folio
>    jfs: Convert dec_io to take a folio
>    jfs; Convert __invalidate_metapages to use a folio
>    jfs: Convert page_to_mp to folio_to_mp
>    jfs: Convert inc_io to take a folio
>    jfs: Convert force_metapage to use a folio
>    jfs: Change metapage->page to metapage->folio
>    fs: Remove i_blocks_per_page
> 
>   fs/jfs/jfs_logmgr.c     |   2 +-
>   fs/jfs/jfs_metapage.c   | 299 ++++++++++++++++++++--------------------
>   fs/jfs/jfs_metapage.h   |  16 +--
>   include/linux/pagemap.h |   6 -
>   4 files changed, 156 insertions(+), 167 deletions(-)
> 

