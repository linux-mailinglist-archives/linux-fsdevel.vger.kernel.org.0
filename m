Return-Path: <linux-fsdevel+bounces-8004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABBB82E216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53549283738
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097601B272;
	Mon, 15 Jan 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+ssklvg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sn3Wh3go"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BA1AACF;
	Mon, 15 Jan 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEa6Sd012219;
	Mon, 15 Jan 2024 21:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : cc : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=3XSbMk+0OJvR9mCRFdiLfzJWHQBkIJksH9ChODvMNfw=;
 b=b+ssklvggcxIy73I0hJ1z4aWrYTw8edAEHKBHSDZllaU7K2R50Hs8UHmK9cn7ONK5G+b
 x6o/C88qYrPSHE0gw9OFGMgXbJ294UMoxmMHs31nZNCEVjFJPbSYn7l1De/lXr2YKv89
 sDdC0gcr451K/DlSxMKIpB6wCJCL3R8Y/VykD6LHs5/c4TwCGEckUskUGULULrCdbu/3
 VPKZqI++cv3Uhi0dPX1w71xMkhbRlG8z9Bu4Q1sDx4/TKOGKjZ28SMz7394pT2btao1Z
 IGqFqkdU7CzUKzVxVvU5z9mI/tzM8Bw2sTSsNounReWPZy2zd8EbtIig8OjidHUCbcjY TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3gtx9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 21:05:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FKjkBG009387;
	Mon, 15 Jan 2024 21:05:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy6n9xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 21:05:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdT00qpPegaAGUPfPFLtPi8HOGbOlybgz9zW428uIaAShEfq9qRhhv6lsNsh6Iuuz816yYQiym1dI2Z3VuskHwY+QnzYZVdT+B/u4XDAq79yNx630MtLcir9fCnnVDZpQsiMhK8KXjwdG9siAiyPkxLbAr1RoLdtBcVuFlJUOZRG3Y+IdHTWKGJdvqYib0pb4nnXJkWwYCAlqM+vMnKYKrMklURrkGecJjTT7ys0kL7fp+2/a9tnhjRTlH6z3pVRm5CFCJiYtIyr3H0HixqR+qsJFoqsQeZidIpyrH13SZXx2E3EVb2M6pkjOlEgRRoFsIlYNjBkElH2G2Fr2xhcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XSbMk+0OJvR9mCRFdiLfzJWHQBkIJksH9ChODvMNfw=;
 b=DH3faA0Onkv5/f3V0pszuzTb2f5yV60z/lESSxEGKPnvjb87nrrNvGANw0YAk4hv88ge7/sqXY6nkeVdKFuoTmuD0gTKydTHH4WoKlZFIXLpNgvM0H5zqjEuzh+kS2i/RSl2oz8faOumvRLzQMIcqHiMlf8FBEDVm7nXuiGRJ0itfRWngBvswSGBPsrGKEcDBmXfyEABI0xu2cq2FNq6sNuJ7uwTvi73jIsQQnabWrKJ/oNof4+TexiRWlOeZTTYlkMc7/zxpJ0y14qQ2GafzYbxdH7GPCdARzS++bHqT2W5+QtLe2AMXEYh2vN2cWV4cCvFrM7T8+Ue4YtHf5jviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XSbMk+0OJvR9mCRFdiLfzJWHQBkIJksH9ChODvMNfw=;
 b=sn3Wh3godEmUuocL2Be2GS/lkxVwrbrY/BPcGUz0Y+A1DcBpHdSCZyKCRdX47Fli48aRB52N3u+ZkK0CppKfBTZVOdMTDqTtkLl6XDcceecZC2qw+Ueh3fwE0BImrJ2Sosffq1OzNOrW3R50/xc5rYn6+XTSPoC+hBKuzPD6W1I=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Mon, 15 Jan
 2024 21:05:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 21:05:40 +0000
Message-ID: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>
Date: Mon, 15 Jan 2024 13:05:37 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: dai.ngo@oracle.com
To: brauner@kernel.org, Jorge Mora <Jorge.Mora@netapp.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: nfstest_posix failed with 6.7 kernel (resend)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH0PR10MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: 2037b83a-a0db-4973-a57b-08dc160dbaf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4+UYnD50jPPoTJqTRxEPyoMWAmOOmXbvBHu7DVmvGKh3mRw0hqfck4+oXg1KwysbITOJ6l7GD2+SSOQMtib3bMtTYSYaTNh6493KM84OUrg4nbFWM7JmjKlyXvLEbAtqWcnkH0PkTbFCts5BGJBPsVTssXyZ7uMIkS877YFEOLfOrNeo1/ZVZ6hmbE9e3dqlF4TjY+LPF6UptbxMaMR2w3OFrEINTAX92/9mnZj5xsQgf2ZFUXpU03UUFlsnQPTgVKGCiA1FnhU8KtRjbP6OLgi5ki1wFExc//tqwGxHn0f8jDTLHKNvyf2JrmD8pAQdJPQfYOxWNH1EXw7dHdk8HzF2e7CXYuyOJjNa9gXfczCL8RnHNDWuYh8O/xPvFo6VlkpQVzebA7xc6tlpaxdWIey5H3oQcQwIqun0kY10AceOVXRIgltTqpaqzdDTkaV8qPZ1pgstWWTD8PVWe7eOH09HsVOkxwtGBaMC1IH84Zaq2j8mItd4otYmXdFNwfs35sLCbluzEuXmZXEV7pRaUgwyW2Rg811s9cCkVuTDu2JzRxDFZ9oL7UcZrM8vscgQAa7p3DWWL004lp2Qip+m2DgpkHbs7ECG6TAzHowPtseN5qtKKXkLeLKMbvhFYMjV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(36756003)(86362001)(41300700001)(31696002)(6916009)(4326008)(8936002)(6506007)(8676002)(316002)(66946007)(66476007)(54906003)(66556008)(26005)(2616005)(9686003)(6666004)(6512007)(31686004)(4744005)(478600001)(5660300002)(2906002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUdCTUVhYlBYWlFTMS94bHNjWUJkeUlScjEzM3NjYmFmTVBQbFNOaTQvU1VY?=
 =?utf-8?B?WGtoWndPUWNHT2J1ck1veVRQa0xiR1g1b0VtZUpYU24reDFOaS94Z1FGVGxj?=
 =?utf-8?B?aGl6RFZIeUVYa05VaDNRS29QakJ3WVZEK1pwR3VxcUp3SHBheDdIRFhjTTcy?=
 =?utf-8?B?TG9nOWFBcWtiY1JFY0NvZk54MkpXU1Z6dWZjZFczcEhBYkNVQ0dod09TUjFR?=
 =?utf-8?B?K28xTDdaWHJyWXA1SVVxM2c0RDQxdi83NXVSd0hieVBSeTB4SUd5NjdFQ3Az?=
 =?utf-8?B?UllZa0wwMitpNjdnV2xBZkM3bUJBU2R4K0dGalp1dFJSNHFsNm5EdG0vRG14?=
 =?utf-8?B?ejc5a0plSEZQUHBlS2VJSHc3NUpQYk1wNFdNZUFWZFQyTFJ6V3VVdnR2ZFpF?=
 =?utf-8?B?YU43YzlId0lLbFA0RVlSY3FBeHpSQzd2K09UcjNFRDh1U1VKRVoxL3FuOVN2?=
 =?utf-8?B?N0pYcmtzUXRQanZ2YWpMRmxrMDh5aDAzZWdXanAzcVlzc1ZOSzRHbE1rNGlS?=
 =?utf-8?B?ZmJFVWd4dEwzUERwNWNlbnMySzJrWVRoMmQrUlV0SWZMTDJYeStOT1JwSjJ4?=
 =?utf-8?B?VENhMHpJUTRGREM1dFkwK1EzNWhyTjFORlRXUkIrNlpIWFZ1bWRsUGMrcmpU?=
 =?utf-8?B?bHRkSCszZWRCbjhJaGFzRC8zaTNTNnNFSDVxWngwclllK2ZDVVp4R2dDU3dv?=
 =?utf-8?B?clRHQ1dnbjNMdFlvLzl6SlQ3bW94ZkxjYlREK3c5bWZ4aVFyeEZOaE56Z0JF?=
 =?utf-8?B?UitXaWVPSHY0dUdzT3ZkNzVob21mM3lnMytodWVpaU5EUUdkL1RMbnVpOVNi?=
 =?utf-8?B?dElnOEFLRzhLaU54MzZGdmVYK2tobCs0ME93N0dYVml4VWg2cXdKS0JuNi9o?=
 =?utf-8?B?VWZGYUtad2o0bHZaRnJrNXBMd050bWhXZVZtK3ZTUHpkSUM1ZS9rck9mc0NF?=
 =?utf-8?B?dEVHelYrWTNZTzBwamFKT0hzVGl2SnF5c0ZBWWh5aXJvSmdDbk8xeGM4bzFr?=
 =?utf-8?B?dXRLZzRaYlNyVG9RTUVnOGdwZVpmVjZIVEFkNzM4VnpxeWcyMisyMDNHNjYw?=
 =?utf-8?B?RWx1ZG83SlUvNmZtaFMra1VpaDd1VjBKa0Y4YlM0QnlNSW5NRHdCYm1WaXRO?=
 =?utf-8?B?Y2E4Vk9ZR2JZZjhIQTNQRUtnWVBlMnlQRC9keWo4cWIrSDJoaFR5ZFVyWTFH?=
 =?utf-8?B?Q2xsZnFxZEp1SUVGZlN6SWk3QmZxOS96RzdSNGxyZ3J3Q0lVdnZ0cHR0VTJN?=
 =?utf-8?B?aGlQYTBZSkYrT0pPTUZ0UjgrcWxCWFN3VHZTR1Z2NnhSZ0J5VGpZK25EZFpR?=
 =?utf-8?B?TXFoSGVKWUo4RjNvMktrRXFGMUlJdTZxVGlQNzJ5N1pTUGFKOXBhN1NwOE45?=
 =?utf-8?B?aEJTNlpxWjA0d3BTTFBIKzV6VFlVRlZqSjd2bThxL0Y1OUt3eXVzc1djRk02?=
 =?utf-8?B?eFluTUp4S3pJQ3BkRmJpMVJlM3RiemlzQzdvM2F2STBOdlBDalZLVDBmM29K?=
 =?utf-8?B?OEJlS0Noalg5MEV5OStJVlhqMlNlL0xzMVIrTUIvd1ZEdC91bThMV2VNdjlQ?=
 =?utf-8?B?b1RUOEFlNDR3VlA3WGxtU3FWUTVVZllvRC8rYWF2bUNRdmphMWdNa2VFNTMv?=
 =?utf-8?B?dHM0S2NsYWRKNEZSTUJ6Z3R0RW13UFZ5SE10cDdXdzhGTzZ6SkF6TnM5QlpJ?=
 =?utf-8?B?RW9jRUppZkhaV1hlMGpJRlN4bEJQMjRwamNER0NjK2VuVkJoazJ0alpuNVVD?=
 =?utf-8?B?QUxvQ2VoalBRNnowbTJZZkhnYmc1UTVITmdJUk5Lb1RYcXQ5ZVJ5SGdHSXI4?=
 =?utf-8?B?OUlna1ZYbWRMRUJMcXNyL1UwbUhORXdXRHRjcXJoNFE2b1dJdnBSNDdxYnF1?=
 =?utf-8?B?Slh5M1psb3BGRmx3L28vek1zN1BKMTlaS2NjYXRod0tyVU4rYlkwMXp4VTFn?=
 =?utf-8?B?SndwUlJyVkZJYm5WRytad1R3NzBDbmM2dm9Ld3c3S1pHRU9lb0xmZ3V6NGZB?=
 =?utf-8?B?KzlTK3N4Zi9HcTJFKzhSeWxzRkxlVkhZSEgxRnR1ejk5VGVsdmxtT3NTdDRv?=
 =?utf-8?B?Nkh0bTZSRXk0ZjFtR1RGd21aUWc4RXdWMjNHQkI4TG1sWXBrVzZsVE04dVVj?=
 =?utf-8?Q?oOs7ctD+jGN/ldPB2pFOWVd3t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZBERIhhgdWQ3nQB0h7q2tAbJPNcolrREyPyvZl2ywPKJRktnpsTFcFNqgB5xif/nEu/eVk/NFWZNJzeWZ/5T0YrVLHG4fLjjqkGHKYwPwrAe8AN4LqK3yQhhJf/OQ0dWDkb9fMNiQGz5b12sVH5lUMHr1N3YUh4bNVm/LR2QuWxJrwoFm2c9OZkFNjAvW+cgICv+yOIdi0VaamTRNkOf5ZorBfO1KWA0tWoq7Qb78n2a4d+IRMEebshsxEviNEO0PogX7J1f+J95UPjr3E+q9uxUpRXL+QZvBh96SJ6ADU98vP0zeFmDT8KflcsE7NkY7FXWHP5WgNCX62W6cQVNfa5OGyMAoHE7J/aV9dq7W3tZaL5nKI48vIljA3gbYbsgIneLKo19ccENWbU0+pjKeNEoj8mUtkip2+Y1+gMTDjgMtrIS1kxEdJVI6q/vQCVkBPrZKGx5J+9GazvMa/O+NeydGIYXyJJRe9s65hq3blvgj20Gk32CRMgR5s9NZA56puscNqWW32XymHeWYIED30yi6OPEU1aYG/8vC+wH6UxOD0JRGjsL7pL8PCOJS/8tDaUofWRkwZXNh+g+Lwzf72G5rU7LGB8Lh0e+0ktSYkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037b83a-a0db-4973-a57b-08dc160dbaf3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 21:05:40.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2AtzQITJvFCOlX/qOyRN5MWWhqxk1WtfMnp0gUuvoTBGd5WmygS01Go5l5++YpComhLVUTNpHrF3bmTrP03YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_14,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150156
X-Proofpoint-GUID: YsqwMbsBYbBVIsnksOHuWBaL_ySr6hIb
X-Proofpoint-ORIG-GUID: YsqwMbsBYbBVIsnksOHuWBaL_ySr6hIb

(resend with correct Jorge Mora address)

The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:

     FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
     FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)

The problem can be reproduced with both client and server running
6.7 kernel.

Bisecting points to commit 43b450632676:
43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT

This commit was introduced in 6.4-rc1 and back ported to LTS kernels.
I'm not sure if the fix for this should be in the fs or in nfstest_posix.
The commit 43b450632676 makes sense to me. No one should expect open(2)
to create the directory so the error returned should be EINVAL instead of
EEXIST as nfstest_posix expects.

-Dai



