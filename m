Return-Path: <linux-fsdevel+bounces-21099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B98FE36D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266401F258EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995617F363;
	Thu,  6 Jun 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RvjOZxE/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KArtnexy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7D17E46A;
	Thu,  6 Jun 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667471; cv=fail; b=U/l5I1bOZ6Dc/Uad9pLARPPUT2mwSa+fmHbkwNWDIg+tq3b9O6ENkL8ZwTdOOJKa9Y4CuqGz1Kdxxwy0UbvgTGaI1oy/GN7LsYTCAXaq2jAif2iNOxXhs0qoFqgqh0wwV+4jG9eeUw1Ijc97wjKntEDjwjBRb2/2t8jQlsh4JIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667471; c=relaxed/simple;
	bh=NctryPK7fAlKQlY7odVmwPJ7AbHHfuL9Z0GOct1XSQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rt8D3DdLXV3z10c1XnJUpTBMOrGVo+AVTTHkRT8EHkOy69JVEu/Ou7h7RLwIZGZtTTabXU6nKCqMubNHO1PAVrspq3ZZjfxqbFCxmI6P6JL2Pbo8Nf1Dvd1+JA0wBdv82bsdr4DNx1fULuVJmtHrGuwISbjSQ3CAa07+qLhQUAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RvjOZxE/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KArtnexy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568i6Fm014110;
	Thu, 6 Jun 2024 09:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=+ZY1PRfCMFZqAJ+PF0w/LM6t/x81YQnaLq9bxrS44v4=;
 b=RvjOZxE/05o0whc+hKaDV5UMKVL/E0f6eYl4CNbGsWTulLwe9sV5bUC7vOpIkUO09WYB
 qjxocLSMaLM8LRKnatimw9TFxz23GnFFVLWp6cg0NXNKQMpNcqi+JeMgq+9CdP3gV3PS
 1GohctctsIUfemwsqZLxdrVFjDWUP5ETSOtm02HtPeKEKMTeHiuqe/LbOTQExi/kkFiZ
 yjG15wYDbB8GsGs9ZVld+YYFk6FupCRCABotmy2bqE3EKZALrsuU16yfW17d/U/J7zXL
 2Wp3hlMfFnN/Hiw9n+JqE1UOGYvhvFo7pBmq/jerabpntifRt3Y4iGd+7Rd0IAgpMlC7 TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsq34h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 09:50:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4568uRlD016160;
	Thu, 6 Jun 2024 09:50:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsctup6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 09:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WErRiwKaVW9z2SCPdCVCBulqGuczk92sWqOfBBDXA5ck0ZGSbJEG8XXlo/9UuJFiUkCqIokF6KdcZRXCrgLC+PYoQSxXLg2w/pGSI2XV9KD+ARh6cXdBosSwrgW/vOtFOo4bspa2XzXoL1bmCUXczX+tChoJaKgh3EExAz1+XiPwNjzDBPM+tpK3tcgB0P/G+Uj4cxTBZiZC4yercxKF1rpbS+h5XQwTLc6SdzQ/DNjR8H2WD6uq4T0iM8hoq3/tDCYcArDmQcrLeex7HMNa9HJw4rNV3YCDx1HOLbVOESlP4qKvdFsLTKzfrcyDNn6hARlvapgy7UxcWezqiRzhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZY1PRfCMFZqAJ+PF0w/LM6t/x81YQnaLq9bxrS44v4=;
 b=cpmifYQsqxAtyzt2ZFwzQVST/mSTNkdUvF2glgV9ycas8aVGnKaWKAOOJWKsuNP1BW54U1eq6AqcQyg6fZDzzzIj3FDuBS4jVWRIh6WpHOonLZBMHq+C5LNqgGzKi6c8vP7ZIXVEbCeVSpU/Bp7m/01QiQscGJwxQNuhIJpR/4oXBgT/U2laglZChstpj4qqHqlbtzxsn615G40kUdD++Dz+MphVuiK3y0CSfpMuznYMqkmlL8e2oFyrggbXHAPljtyg+P0se2XkVdkChCprp4BgAg8FwdIrr/DJn088+0ZpehBYLx687Zc/FeQkO281ldG0KkZAkHX8y6a1I5tfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZY1PRfCMFZqAJ+PF0w/LM6t/x81YQnaLq9bxrS44v4=;
 b=KArtnexy/4QbYRbdef5GLzlaVIWSzHx5NARJii6UgNGet8By8Upj+DTiYaeKoy3KUs+oBkkAoq0qMVpFh7DwybHr/zxxbrJJ1K8LG+J2EFljV2plbM+0rrtNU/624ufJ81Is4rZF5iYccSfLMZud9zuR9/bQyRiMxp1o/+y35Vk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 09:50:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.032; Thu, 6 Jun 2024
 09:50:40 +0000
Message-ID: <d96c6e91-44f0-41c5-bebc-a092dc8a8406@oracle.com>
Date: Thu, 6 Jun 2024 10:50:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 11/21] xfs: Unmap blocks according to forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-12-john.g.garry@oracle.com>
 <ZjGIktQV12qas14f@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGIktQV12qas14f@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e35ac58-05a2-455c-e2cd-08dc860e2001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjFydzhoZFlGUkdyZ2FZWmFOWFh6dUU1bDFrdXI2SjRXSnYvYmk5amo5RUZF?=
 =?utf-8?B?TnB3b1dFVjFFaDR0bWdHS3o0Yk1ZV3VTQTBWQjJMSGFDa3lLSU14N1N4Wkt5?=
 =?utf-8?B?U2lNOGozS1dBOVhnelBpaWNzZU9QWGpXajU5SEp6R09yWlBlcmtuR21lbk1Z?=
 =?utf-8?B?cnFIN01iODBxdURnVVA4dFlWdmJSb2YwcmRZaDk2eDVpUytuTFkydHhEbEVT?=
 =?utf-8?B?NWVGdWZVNkFUQmdJUWtzN3h2VDVjaUZ3azFUZUo3OHp3aWFXOUp1TFJpNFh1?=
 =?utf-8?B?eXNMMlc5RytzWTN4dFRuOEp4WTl6T3psbmdaWDNXK3hJYnlEZ253Lzk3N3NW?=
 =?utf-8?B?b2taOFVGaFdLUTJCWUw5d2ZoUktPM2ZMdHZNUFdEVXdPNWJKZk5SMGw1WVBy?=
 =?utf-8?B?bWhMU01jZXVEamNGOUVpQ0t1dEZYSFFtS3BSd0xHeTRFbER2Ti9CcFA0QVQ4?=
 =?utf-8?B?dFNQZkJ1cTZXMG9wcnVQTlRRd0kzVDdPUDVrL3hVbkZiZ2NFU1R0azZVTDlX?=
 =?utf-8?B?QnFCRmR1U2RXSXN5WEJZRjJaUytRWk11dlBocWZVRUxsa1oxUDFKem05TUZ0?=
 =?utf-8?B?NEhzYVUyWE5qL3FHTHZ6UGxCWDd2MnZWZTFsRHNSMUtKakFpYTNGTm1FYW1u?=
 =?utf-8?B?RUpaQWhxK1ptbkxIL2VvU2Fob3Z4ZlZIZ1VjbURKRlMzL0l6MTVEbnBiaXZ5?=
 =?utf-8?B?TGh4N3lyVjlqQXp6ak00K1E1RWg4WlVmd0d2YUs4RXpOU2Npb3dCVGZ2Nnpl?=
 =?utf-8?B?VnRYeTJsWDlyNERjcUhPdDIySlhmbW9hQWdXVXpUTXlYMzJaQXorMC9mL3pO?=
 =?utf-8?B?Z2psZzhBRFpyYlM5MWlhNUkxTHVIQVJKRHFEc2NwczdrU2tnM0gwRWVUaW1w?=
 =?utf-8?B?cUM0SXlLcVRXWXhQMUR0cFJzQjQvV1FXVy9kVnZIaVhNeGE0U2Ria1FEYWJx?=
 =?utf-8?B?Vk93SHRCYXo0NEJmM2NvcUFNbzlDMTRhTFFpelJFNVJzM1RyYW5kcnRzdE5T?=
 =?utf-8?B?Z2JLWDRIZERhSXVvYzFPTHFQREwxTlFkTklZSWNML09iMVRmREg2aEZDVktG?=
 =?utf-8?B?VThBN2hzZHdVWVRWZmxneHdCSVIxTUFndndEZ3pZdERJdVNWQnA2dGhJUEM2?=
 =?utf-8?B?NDdwdHFQU1liN0x5YzhTc21SMXVtUnJ1WXNWU1BRMm52SjVQb0JhaVg4c3Zr?=
 =?utf-8?B?bVl3TkwzU1U4bVVRZHlpTStRTWYvNEMyVEMyMHBOc0tWQ2Q3NVI5L08wTFdB?=
 =?utf-8?B?NDVlcUUrOUhHalA1b1NzZTBmcmxlOEMwb1VYbTdBVk5ubmRvYnhLM1gyTEJj?=
 =?utf-8?B?NmpON1lYbVhNakQ3ZHlNdGltdlFjV011dzJyemJ0NTJnT2d2eXoxMy9ZVDBm?=
 =?utf-8?B?V1RVdGc2MXJ2bHZIaVM3SWxhd01qS2xXNzR4V0dVYVZIVUpGZzJWS1BhWEF6?=
 =?utf-8?B?UFAzclMrMXk3MzhWQkxRaHMvNitYYUNuNnBKTE4rZUgrQlE2UGd3NWF3cnlW?=
 =?utf-8?B?T09QUkluSEYxemFKcE5sdkUzdVE2SVBDM3QxenhsRWhRQjRlTlVyQXd0ZEww?=
 =?utf-8?B?bFRyZEg5S2FHcGRaRlVKVFdvWWwyb1hnaS9Jb2Y1YUFGRDFsVW8rb2JDWnRH?=
 =?utf-8?B?YW9ITGtHZTB6NXlvMVNKR1lNaEVtWi9zSmpnSGlPdlJYUHhpN3o4bmxRMlJL?=
 =?utf-8?Q?bYmPRKB6+BTUowDwknpx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekxqSWNPbWV3MHM1QTdBQUs3dkVIVnY0Q2F3UmVvZzVaN1d2ajN5b3FZQ2xt?=
 =?utf-8?B?UW1odXVEQ0hlMXphNlg0NkQxbGROS2RKK1doL1drekpzRHIyaDZhT1cwT2xY?=
 =?utf-8?B?S2FMWEU2K3ZuSGNIZEJ0WUV1dFhobVVCYU9CbWlwM083aElMWnZhRHFETWdG?=
 =?utf-8?B?T1VlSGFkdXJJQWVKMEQyajZTdzNTb05OanYzdk9LbmdZbGd0ZXZHTVF6VmIv?=
 =?utf-8?B?YUR6RXJBRksxRjlzQ1ZERTcyeHJkN3E3QUNZZitkcVN2SUU2WmNseDkzMFlJ?=
 =?utf-8?B?VHpkR2pHV3JTUzVzK0NxSzNPdFhLSFFMOUVSdW96WElOUzBZdCtpQnZmeDB1?=
 =?utf-8?B?dUlsUDZacm9vbmFlUHdaT2NNQkN6dElnd3JQYzRjVml0YVE0NEtWM3JvbFNB?=
 =?utf-8?B?eWtCTUJnR2dsK2NkbkZ1TklQbjI3Mk1Zem0xTGpEQVJiSnlDTm1hODJsdExV?=
 =?utf-8?B?aUZUL2ZBdEFsc0FrRnJvOHAvcW1Sd2R3MkZVY2RVZVlKOXpRRjkwWlhxc05p?=
 =?utf-8?B?YVMwcTRQTnNEUjRyODJGMHVFWnFiYzlsTkpKemN5TzM2RDVLQzdkZktEcHBO?=
 =?utf-8?B?ejFMRHlIRmJQR1AvTGRha2V0T0dhZ2xQZU5nYTlBcWs5MEVOQnFnWFJueEVY?=
 =?utf-8?B?bmF1NnlFcG5SVWVpcklFR054bXZXWWdiU0k2NW1WRTdYTkthSDR5eklwZE1V?=
 =?utf-8?B?MlpFL0dSd05yOFRjVVIwcFJ4c2VwVXUyc0ZKMFZHdU5XL0duTE41Y0NxWTZy?=
 =?utf-8?B?NkQxYngvRFl4R3kwZ25Xb3NGalF4NE8rQ21VY0JnK1ppUUpiRlpoNkZ0em1y?=
 =?utf-8?B?dHV4NkpyNm5pTkZieDBibVJ3Z04xOUM2V1g2ekIvV1gwWWdjcTB3Z0QvRzE3?=
 =?utf-8?B?aXFnaG5LSU43RnNWaVFubzZwekVSbHVBcEJVenl5YVg4TzB3emhuRVg3dXgr?=
 =?utf-8?B?T0ZSeGdmd1dHeU85ZnhQanVHUURCWkNhbFVZNG1VSjBuY0N0bU42T0xJcWt0?=
 =?utf-8?B?N0hvV1ZLd0E2SlcvaWpDMlMxd3dSTWpKZC96MXRaTWtlWUhPSGswYTZsM2NB?=
 =?utf-8?B?ZUp6Tk52MWpURjBpYXdPaExja3dPRVN3U3IrQjVES1hURURtT1grZ0J0V3BZ?=
 =?utf-8?B?N0llVVdEVFNDSUYxUEo2YmlCRThMUjRUN3c5aDhmNmNWWENLVG51ZjJLTVla?=
 =?utf-8?B?SjNRc2g4VkE5Z1UrOTBjSlhKSUJ3Qk56bFRFMVpPSUF2end1UEVrY3VpbEhj?=
 =?utf-8?B?bGxZdEEyS3M1WU9VRU9qMWhEcnY3Z0FLS1dHcTFvdjF1ejhuWWN1U1dQWmQz?=
 =?utf-8?B?ZkNKYStxSlZGS2FLdFJwcmdmcEtTaWxiKzQ1cndqU0JzT3NKQ3dPdWU5ekV3?=
 =?utf-8?B?QzR3Yk5nQXhWODdHVEtUS2x0QkREUlI0eVJnWnJUY3NEbjZtOERnOTFlZUY0?=
 =?utf-8?B?TTBNVDh1cFJLc0RLTG9XSVpNS0xmZWlScHVBS0x1Y3RjTjk4NkU0SmowOFA2?=
 =?utf-8?B?VU9kZGsxeU1SZkIva0JrRFVIQWxuUGlCZ1kvb0NZL2diekwrNWw2Z2hjL0sz?=
 =?utf-8?B?aFVrNTBkNkFPMlRwWCtuMlBvWVBuWWU5UVNNYm9EcThUWWREOStBZWdxM2pz?=
 =?utf-8?B?d3BITHV2ZHJ6Vlo1SGdYZ0dRaVg1OVdoWEtmQjZackVBbkR3UTlUYlZ2TmRB?=
 =?utf-8?B?RlpuMDRKV28vT2RCZ3F6blB6bnRpNFhXQUxEcWxPcWFYcmhWd3pUSXVRcHUz?=
 =?utf-8?B?N1BFR3NDRERnTXB5cDZZMnJJUndSUDNud1dUVWFUN2ZHK0xFOHF2U1RzdnNv?=
 =?utf-8?B?WitlMVd6V0ppTlNOU0tlazJnWVBnb2dZTjFYOGFUTU1qTUtxcUZjYmwzRFVU?=
 =?utf-8?B?VkxRbjZyOWlGVFRlYkQyZTJYZjVhbG5BVFRVK0x0K0NSZWM2ODNyL1NJWjZC?=
 =?utf-8?B?ZTRXZUFtVzlCbUN5ZVNoL1RXL1FWYUVtTnlvTXgwZUYvRTMyQXppUjVBT1My?=
 =?utf-8?B?RXozTGdDU1BUWFNJSUxNNlVDSTZOeWIvTVNwbTcrckM2R1pyc09EZFY1Q0cw?=
 =?utf-8?B?Zi9lMXA2NEh0ZE1qVzVieDh0UFhpYUd1S0VaZlRpQjZJL2YvODMxNERTSGgy?=
 =?utf-8?Q?ss9sM4faxb/zIx88XC4mgdZDx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vxrRHl4O9y3kSeqXQQllvH2eHIZmc3SaDXjcJnGhRDFkRPcszvf55t0DEH0JKJwf2nGkQ0Sew/F84+V5Y0MVkW7RsaWjOWbe8QReufYaL6I23b5VhiuvFxDsRiM/fUnkiDcZ6v4miNzsbPoQT15jsI3APt+zDl6AYPKNmbqT1TGhjfmfVN6jz8AvNFz3Pxr1V3mK2vtoaReZgLVJZnOUky2v58PFLKv5TxrajOh5fOyHgKj98eSrpLaHgF53+ZRemD6Z1htfWZssIxaqLbScZUnuH9EIq2R3c7vOGGibVf+O8nHhYmCboeyaJn+JduFrt9jnfRADcUYRMMaljtdVhhqNuYrdXVFoT6Y5vLh5VpK4dReGt344oYS0U7zKqWSUQLJgY+gBuvomSQCVAW2gQB6RaJL0grCMMgnu3FmiKGGjl05/sLXSmKWQYDwhJ5fHawjrov9VoITDcqqmpPW+dsn7s4KA0OxLb9/LKYL4Chw83KJT0WspoddWoo6nzPMp9HgmeVE40/RWJmRGzrbJeIhtuMNKbqWIhjJrd39LliZz3B/iBdGXBsPN1pTgXhuZcVW+PgBEueU5txsDYJPQ7G0DJZMhu3iXkmFNoNPNI1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35ac58-05a2-455c-e2cd-08dc860e2001
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:50:40.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki1SnNKv7H9uq5AfETYeEgVs6QwgFd2gwW7AyMvrCbwnwiihum3NmaVOFjKTXkhR/lGXSNwh9MGta/uiV4Uciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060072
X-Proofpoint-GUID: lvVaajQCwM00l0NsRaQGDXUyzGLk8b4J
X-Proofpoint-ORIG-GUID: lvVaajQCwM00l0NsRaQGDXUyzGLk8b4J

Hi Dave,

>>   
>>   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
>> @@ -5459,11 +5472,15 @@ __xfs_bunmapi(
>>   		if (del.br_startoff + del.br_blockcount > end + 1)
>>   			del.br_blockcount = end + 1 - del.br_startoff;
>>   
>> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
>> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>>   			goto delete;
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp,
>> -				del.br_startblock + del.br_blockcount);
>> +		if (isrt)
>> +			mod = xfs_rtb_to_rtxoff(mp,
>> +					del.br_startblock + del.br_blockcount);
>> +		else if (isforcealign)
>> +			mod = xfs_forcealign_extent_offset(ip,
>> +					del.br_startblock + del.br_blockcount);
> There's got to be a cleaner way to do this.
> 
> We already know that either isrt or isforcealign must be set here,
> so there's no need for the "else if" construct.
> 
> Also, forcealign should take precedence over realtime, so that
> forcealign will work on realtime devices as well. I'd change this
> code to call a wrapper like:
> 
> 		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
> 
> static xfs_extlen_t
> xfs_bunmapi_align(
> 	struct xfs_inode	*ip,
> 	xfs_fsblock_t		bno)
> {
> 	if (!XFS_INODE_IS_REALTIME(ip)) {
> 		ASSERT(xfs_inode_has_forcealign(ip))
> 		if (is_power_of_2(ip->i_extsize))
> 			return bno & (ip->i_extsize - 1);
> 		return do_div(bno, ip->i_extsize);
> 	}
> 	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> }

I have made that change according to your suggestion.

However, now that the forcealign power-of-2 extsize restriction has been 
lifted, I am finding another bug.

I will just mention this now, as I want to go back to that other issue 
https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#mebd7e97dfd0f12219bf92f289c41f62bf2abcff5

However this new one is pretty simple to reproduce.

We create a file:

ext:  logical_offset:        physical_offset: length:   expected: flags:
0:    0..    1775:      40200..     41975:   1776:            last,eof
/root/mnt2/file_22: 1 extent found

The forcealign extsize is 98304, i.e. 24 blks.

And then try to delete it, and get this:

[   17.604237] XFS: Assertion failed: tp->t_blk_res > 0, file: 
fs/xfs/libxfs/xfs_bmap.c, line: 5599
[   17.605908] ------------[ cut here ]------------
[   17.606884] kernel BUG at fs/xfs/xfs_message.c:102!
[   17.607917] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   17.609134] CPU: 3 PID: 240 Comm: kworker/3:2 Not tainted 
6.10.0-rc1-00096-g759a4497daa7-dirty #2553
[   17.610606] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[   17.612619] Workqueue: xfs-inodegc/sda xfs_inodegc_worker
[   17.613682] RIP: 0010:assfail+0x36/0x40
[   17.614134] Code: c2 18 1e 1d 9d 48 89 f1 48 89 fe 48 c7 c7 43 f2 12 
9d e8 7d fd ff ff 80 3d ae 86 8d 01 00 75 09 90 0f 0b 90 c3 cc cc cc cc 
90 <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 900
[   17.616478] RSP: 0018:ff4887cac0973c28 EFLAGS: 00010202
[   17.617080] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
000000007fffffff
[   17.617899] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffffff9d12f243
[   17.618717] RBP: ff4887cac0973d40 R08: 0000000000000000 R09: 
000000000000000a
[   17.619548] R10: 000000000000000a R11: f000000000000000 R12: 
ff360ff881d88000[   17.620360] R13: 0000000000000000 R14: 
ff360ff8efa32040 R15: 000ffffffffe0000
[   17.620367] FS:  0000000000000000(0000) GS:ff360ffa75cc0000(0000) 
knlGS:0000000000000000
[   17.620369] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.620371] CR2: 00007f213b4ef008 CR3: 000000011cfca003 CR4: 
0000000000771ef0
[   17.620372] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   17.620374] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   17.620375] PKRU: 55555554
[   17.620376] Call Trace:
[   17.620384]  <TASK>
[   17.624278]  ? die+0x32/0x90
[   17.624284]  ? do_trap+0xd8/0x100
[   17.624286]  ? assfail+0x36/0x40
[   17.624288]  ? do_error_trap+0x60/0x80
[   17.624289]  ? assfail+0x36/0x40
[   17.624292]  ? exc_invalid_op+0x53/0x70
[   17.628287]  ? assfail+0x36/0x40
[   17.628291]  ? asm_exc_invalid_op+0x1a/0x20
[   17.628295]  ? assfail+0x36/0x40
[   17.628297]  ? assfail+0x23/0x40
[   17.628299]  __xfs_bunmapi+0xb87/0xeb0
[   17.628304]  ? xfs_log_reserve+0x18f/0x210
[   17.629447]  xfs_bunmapi_range+0x62/0xd0
[   17.631699]  xfs_itruncate_extents_flags+0x1c4/0x410
[   17.631703]  xfs_inactive_truncate+0xba/0x140
[   17.631705]  xfs_inactive+0x331/0x3d0
[   17.631707]  xfs_inodegc_worker+0xb8/0x190
[   17.631709]  process_one_work+0x157/0x380
[   17.633949]  worker_thread+0x2ba/0x3e0
[   17.633953]  ? __pfx_worker_thread+0x10/0x10
[   17.633954]  kthread+0xce/0x100
[   17.633958]  ? __pfx_kthread+0x10/0x10
[   17.633960]  ret_from_fork+0x2c/0x50
[   17.633963]  ? __pfx_kthread+0x10/0x10
[   17.633965]  ret_from_fork_asm+0x1a/0x30
[   17.636314]  </TASK>
[   17.640377] Modules linked in:
[   17.642375] ---[ end trace 0000000000000000 ]---

Maybe something is going wrong with the AG bno vs fsbno indexing.

That extent allocated has fsbno=50552 (% 24 != 0). The agsize is 22416 fsb.

That 50552 comes from xfs_alloc_vextent_finish() with args->fsbno=50552 
= XFS_AGB_TO_FSB(mp, agno=1, agbno=17784) = 32K 
(=roundup_power_of_2(22416)) + 17784

So the agbno is aligned, but the fsbno is not.

In __xfs_bunmapi(), at this point:

	mod = xfs_bunmapi_align(ip, del.br_startblock);

	if (mod) {
		xfs_extlen_t off;

		if (isforcealign) {
			off = ip->i_extsize - mod;
		} else {
			ASSERT(isrt);
			off = mp->m_sb.sb_rextsize - mod;
		}

		/*
		 * Realtime extent is lined up at the end but not
		 * at the front.  We'll get rid of full extents if
		 * we can.
		 */

mod=8 del.br_startblock(48776) + del.br_blockcount(1776)=50552

Since this code was originally only used for rt, we may be missing 
setting some struct members which were being set for rt. For example, 
xfs_trans_alloc() accepts rtextents value, and maybe we should be doing 
similar for forcealign. Or xfs_fsb_to_db() has special RT handling, but 
I doubt this is the problem.

I have no such issue in using a power-of-2 extsize.

I do realise that I need to share the full code, but I'm reluctant to 
post with known bugs.

Please let me know if you have an idea. I'll look at this further when I 
get a chance.

Thanks,
John

