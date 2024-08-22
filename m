Return-Path: <linux-fsdevel+bounces-26828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B995BDE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A33C1C23379
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633F1D0491;
	Thu, 22 Aug 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B1z85Zv0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WQMgPmIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744C1CFEAC;
	Thu, 22 Aug 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349863; cv=fail; b=G80zmBMM0MQ24PDsYYIpAt1zvlfEGPWelpevXPKN6cyFBlOFJlarhOBiT5lkkB6uO3/6EhunKEMg/2xdEb4w24vLnB4stLJzToLtZcoA9oSYFvSwPME4uEXnT3gYKWbVtFs/G09JFxDIZzCimmjR5fKvKLkEIUSsLltp1+MULz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349863; c=relaxed/simple;
	bh=vZ27JTB6bwsUlkecEDaxBSJ4R0jEaUei7VxXFq8wLfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nIqDvcAfmMeFqbz602BSvrvueOUUkmewOWrbKO6byh1mraNrSi/Rc/wAccyHgjKR78sKeClXJkHr5TZbsIHNqDylaxfbM/Z+hJBFwMDSBK4vbyuxu+U43g8ckNWFUYZdbWplSjH5qSFLmC/LjHFbIkq/f9N+lTzaYL2pK+ykgxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B1z85Zv0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WQMgPmIh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQRmN015832;
	Thu, 22 Aug 2024 18:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=s0g1wPWA7YAW6nWRg4+9zsQaHhJb3uMPpCfCn3KLpYc=; b=
	B1z85Zv0pFq1ROhBzsXaqRpMvYAF9shyJ6fbZ+I/6CekOCCXjNnmzK32N09jGupS
	EhvEAUDkxC+aFcBywXLpc0xtDQgD7NXtVeNsAaE+g3dEQE9DmZIVguMDdZ9IPtgx
	5dSXMxjaLU9EKkGrgI1cnPXcpPbcTIuMY3gYH4NENpGWLliBby8gv7p35y03oxkZ
	qzGo1t7NHvaDTqg8V6/MriyCg+daBIQLmlIMQYaB8MIoFi11/1848m65iSmY7Q+0
	4vO33AB3eY81ov2KmOotXdP7TO5q7Fi/2VldW2C/V09tMx+qrVhVfX45lmpcr5rt
	CHYB+HDK+vC31Dn0axBv/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dtykq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:04:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MHaUQ5028999;
	Thu, 22 Aug 2024 18:04:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4169vn960c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 18:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO5iL9pIUJvNmtwBPwt4dNDY5uIo1an6LJG6eOvXfLFBgV526fS8a5OfEbrXkYZH76fE0YMkswnxGAh7vlY8LhtC5zOzqVcFtvzR88X/vn9lm7ftPmtHbf4GUunCfoCW4QEbKJOBK7IKslSib7PutHfydGZxSYtwCgr20+ll2yD1fhMmPV+f9YIZw7FgOnrJUqffXU50HBl/1LWwUM+pWIXC0jRFbhcBMaRo0xzeksD1tDvad3qtBQQyIgEMwNY80xIiv7cUgyz0LDKgNTqomgGFmCsXYZJc4xkeZoj99wVwIYUmCMLNPjeQA0XjFpeBranpnYlPOXiBkWW0QCwDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0g1wPWA7YAW6nWRg4+9zsQaHhJb3uMPpCfCn3KLpYc=;
 b=c4P2aBhBG6nDIXftkxeCg9qDH6VCqglV6qWcigBcRpl9lHiDc/QpOINKGiUltw9js4PBC+oeRmDNjcTAZ2Kh8uZCzzHEsX70zn4oPkAMIoRCqRTdSjn1C6V0Z/VpRZVi17URV5Al0zTOPeprdPjgdSIykKh9KPeqV4n8KH6ik63waeIAkNn26Zkh7GHWZSvnf0JpRpQp7Sik2hdTp7tSI9wEfSQ9sXo4mkKW44NNJJB50IMcV3s6fTFBWC1zP4Tb4c6JJG/9PNTTIHfWQvckjRBzbSUiaeZvQ/Tkdc5SrBsCq9HT4zoKdIVI4VqYDSCE8dELNCly51RF27obW9QNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0g1wPWA7YAW6nWRg4+9zsQaHhJb3uMPpCfCn3KLpYc=;
 b=WQMgPmIhIkfV8E3rSpxk0MEnDzNn5dCUyiTRPuFJzf1PBjLhJfyVA1sTa4PokE7tQ9CAoSGmXfg12nADzqxnPA+v2DLAR4Qpn3JZPU6VD0eHQEO8fzmmSa1jjrYVSBLe6VvoJ2HGB3ZQwMF28Pa4vVo2jUPlC1QY3pAzYHgXxaY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB6989.namprd10.prod.outlook.com (2603:10b6:a03:4cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Thu, 22 Aug
 2024 18:04:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Thu, 22 Aug 2024
 18:04:06 +0000
Message-ID: <7c5fdd14-5c59-4292-b4b5-b0d49ba1bce6@oracle.com>
Date: Thu, 22 Aug 2024 19:04:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-8-john.g.garry@oracle.com>
 <20240821171142.GM865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240821171142.GM865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5183cc-9afc-4ef0-e143-08dcc2d4d048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9Selk0WEQxQTJnRkxjVTYrN3F6bExVTTRJWEdKNjdhbFo5RCtIQnZBNGxu?=
 =?utf-8?B?RjVuL25QZ2x0dXVTZ2prRmh1RGNHa215WTVSZm9IM1NDNkpZMXJtVWErZ2dI?=
 =?utf-8?B?VkN1aGR1MDg4NDZXRk1ZWHJ6Z1p0R2l5Q01UWC90enc4MnJKaWFEeWJjMnpz?=
 =?utf-8?B?dHhkTlNZeTBLbEgzNS9FeVl4TEhLN2k3Mm5KaG9kaVFoNVRKKy94K1pNME9x?=
 =?utf-8?B?YUdEdzRvVG5rMFc0ZmlaSXN0M0ppeEtsUk82Y0NTUkZ4QU14Z2xtd0pxYlVx?=
 =?utf-8?B?SmRzbmxvUWJpekdoeHNBMzJLTHUrckRqV2FZbmpSc1BmNy9hVFM1OElFNTVy?=
 =?utf-8?B?aVNCdG11N2VNOHV5bzdjYUZVaGQxa1BYTFh2N0FuTEJhKzFpSW9vUUdyWk5x?=
 =?utf-8?B?Z0NDMExBellqTlQycGxUdkRXNG1oQ0NOZEZ5TlpjYkhwaFNuQTA2Zkh5M1FE?=
 =?utf-8?B?MW9JcGdmaUJVZ1lCZ0tOUWpSdXQ3am5GdjUwRVBvMnhwOGduK0FHaVEveVY2?=
 =?utf-8?B?Q0pPbktabGtJQzhKZGJQMlhReXV3WDNqNEZhVWJoSWl3UEJUeWkxZG5zbFVo?=
 =?utf-8?B?ajJaazMraHRFQ2g5QWU0NXFYazhiZ01SV2JRbXBDYTlOeHM2aEJLR3FDZGdZ?=
 =?utf-8?B?Rjl2OXlVU2MzVXEwT2xwU3Y0aEYvTkcvTjY0S3pmbWg3T0QxL2dVY0RXQkVN?=
 =?utf-8?B?UUhiSlJwRXRnSUhmNWlQdzluMkRuRVEzb0liVGtPODY5UEoxS3c1NnJmbEJx?=
 =?utf-8?B?dmhDUGUvTWF2YWswTnFZeUI5Q1lKODFzSHo3M1JkbmtWSkdXaEpoK05Fa05j?=
 =?utf-8?B?akVHeXpVTTI5R3JYMkcxbHlObm1WdFFWbXIveEdqd2owbkpPSktQNTM5b0E2?=
 =?utf-8?B?blprR3NnYVhpblNKOFQ4ZHl4U3gydmpqTHp6SVlNREtUMTNqRU9TNkpaeUl0?=
 =?utf-8?B?aHJSRUtIbm4xb2F6WEdvYlh5SGtDWFZjRVk4Y0ZIQUo5bDA0eW9DaDJ6WWtr?=
 =?utf-8?B?RDRkNGFQQTNvVVRyMFB6aTQ5djVsa3Erek9wRUhiaGFZaHVmZ1JhQ1ZQdmMw?=
 =?utf-8?B?NmhrQzg2V2Vhdyt0UHNGQTBVTnpveHF1Z015UTNFemtEeUxLaW0xRlJ1Z3Ix?=
 =?utf-8?B?MUUvNURoalJ0NmpWc1pKWDB0bU5jRVhhSVhYcC8vWElFVW1oeitoY1FrYVpj?=
 =?utf-8?B?dER2VjNXYkg4R3I5OFVVK25jVCtVVUpXQ0dmWUpxa3BZRFA2TVo5SHhyeVI5?=
 =?utf-8?B?Q1hiODZrdUE1TmtUV2Q4SEtDaG5jL2lJdzJ4WjNkUFROVEhpcmY2UER1NFd2?=
 =?utf-8?B?NEJlU2wwblBCMlJCeW5IRHBtZC9CNllScnhISXNBTFhvaXUzWEdqWnd3SGF1?=
 =?utf-8?B?VktrQ2xJajNwZ053aTVSaEQzZnl4OFF6cDUzSVlpUmwzQnpKWXc3MU1RUWsr?=
 =?utf-8?B?QmR0ZWhpVC95bHl1dnFGWVZxcW12RFN6OEU2TG85YXNMeSsva1NKc09Bb0Nk?=
 =?utf-8?B?N0ozQkhjZFJDRmNwZnk1VGxvSlA3YjVPdDd5eGkyS3pobW5NUW9wNE0wNUNR?=
 =?utf-8?B?ME5jM3Yya1pMb3FZS2M5dVFrZ3BaZTdybFVLUVcvNS9Zd1ZnY3I1RXRTaWN6?=
 =?utf-8?B?Zm1BRG9YTUs2UzNBNUxvUTBialQ5QVRDMjFJZk5jdVVqMUxoRXRva1NRNEpC?=
 =?utf-8?B?MGZ6ZkVQY0hhMWJxc3BIWmFuNi83ckNrU3VWSlRFWHFLQkhKdjVGRnBad2t0?=
 =?utf-8?B?RjRqNkp2R1dST3dqWGJUbSszZnZKN0MzcTE0OUd5amRoQllVRitYQjJIVFdk?=
 =?utf-8?B?N29CcmpURVBPS09sT2hvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNFVHNtc0JEd2t3em1sMkdUQUFLaExLSjZJRFBrUG5OeTZUbTFtRXR3ellI?=
 =?utf-8?B?Qk9YVzdGT3VrQSt6RzF1Yk9TUEl2VE5pU2tWOHVwZVh4dWZUb0s0SUQwOUxH?=
 =?utf-8?B?UzBrQno1b0kvSjBuTFVicEUxQmwrclFZOXl5MHFVUG1ZcUhQWi9zSHZ1eG1G?=
 =?utf-8?B?SE9qYUR6Yzl6cHBDRi92elZVc1JsaVFzVWdvVHhwOGt5aTJvTHJuaEZKZDZF?=
 =?utf-8?B?RGRidDF5UG1oVGhBbUpGV0NQK285S1ErVVl6NkJYYmtaY3B1UkVYbXhsQnV5?=
 =?utf-8?B?b2V1RnluUXhqQmI3cmtHMy9weUlBSnFXTVR4R3Q4cWRQQmtobGFBY2tFL0Qw?=
 =?utf-8?B?MXpXSkdXRXRLRTd1UDZrVzhHWG1kWXMvalZ2WVg5cmltc0xHejFEUGl2UTRF?=
 =?utf-8?B?REtqZmVnbGhDV3F3S1MrdFpBVzcwZFE0d01XUUVNRitWbXhwSjZLZ1J4dXYz?=
 =?utf-8?B?VVAxWSt1Tm0zU01MR0NyL3pYTmN3WnVJZFFJb29pTVZmbXI4VVF6YXVGdkRC?=
 =?utf-8?B?YTRLV1VOWXNlbEhxN3owT25MeFZMbTNJUWxPejJvTElQUGc5NHhwTXhkd1NU?=
 =?utf-8?B?bUJiUW14bHlrUllPYU9hUVMyQmU2UTJ2YTh5MXlrcUpyQXpDeDZVdHBUNmUz?=
 =?utf-8?B?WmZEc2tTeVh4QTNrU2h1eWdxM09rY0VLQ3BXd3VIb0V2UXVDUjl4T3ZxdlB3?=
 =?utf-8?B?dzRxSjQ1cVNXbmlwWmhNVG9UUlBtWWRRczdvVmJZb0E3MjlOdkY4NFNrT3Rn?=
 =?utf-8?B?WG9QektVUWJTT3RuM1BDV3ovaVhUME45Tmtsb0MyTVc1UEN4N2JPaVNnV2E3?=
 =?utf-8?B?SURoNGRGNGw3QjdJNXVrUk9kQ3ZSL2poalByZlVIdXh2eFd0MlJWbmxhaGJ3?=
 =?utf-8?B?WG9hUTJ0Q2FIbmF5bWQ2a1ZvU0kweUoyMnJzS0VvQjZQSDRPMDZ3WisrSkkz?=
 =?utf-8?B?QXRwbTBHeDRpUWt0WGx6anRTNk9ZMllRMmMvS2JJTlI4YkV0Wk9UK0VDZzhM?=
 =?utf-8?B?THhva1FLZXVDTkVKRWcvS1pPMzdCZDF3aVowYkdJTG9CanVJNDBoMmIwYU9V?=
 =?utf-8?B?SVd4WDBueE5SNW80cHNQMVp2RXhrZzZZWldVTUVLSlJqK1YvVEd2MHkyaHph?=
 =?utf-8?B?UDR3eXZFbzdaSkFra282RThVeUFOWWRkZDhJZkxrSUpESEhKSHRFcDZoc0dY?=
 =?utf-8?B?NkdPT0ZkYm9tNWhZNHBpU1lBMDI3QXhBSDM5cURwWTVZUHFHUVRWV0xLSUww?=
 =?utf-8?B?azl6bUxVWndPUm04bkZMc0dnMnpBTzhKSjgvaHVyM2R3c0FYUFlXenhqUitZ?=
 =?utf-8?B?VVplUnRqQTlneW82bXRWYlRMQTg0NEZRK3BONi9uUjhYbDd4cmFYOTU3RVNJ?=
 =?utf-8?B?d3F6am5WWXpFOGJoSElGZ1RLVDdGYmlsWTIxcEtPMjVOUjJveFZnTllZNnMz?=
 =?utf-8?B?SnJkUHhxZDRqOEI5U2V6ZHg3QkVqd00rMmRZeXQxVm9vaUtTK1o0Mlh3MWlP?=
 =?utf-8?B?Vk1VZWxOeGc1QXA0UW9nVmFPblhqSTVaYnJZMG1JSktyMHRDUDdNMnpJZ2M2?=
 =?utf-8?B?SldKZEVmT2xTTUJTMStxMVh5T2VwYUFmYWliZ3h0TkI2Ymsxc0NhdStTZUg1?=
 =?utf-8?B?UXlBT0k4V0tvZEluM1pCb2Y3MUtxSVZQWDRyMWJzMXc1NFIxcGpMVkc5VGp4?=
 =?utf-8?B?WkVIUFp3SXVxdVlHRGJwSDNWRm9TOWlBL1YzZUxLZVNmRjQ2OGdDL1daVlR0?=
 =?utf-8?B?VXN2UVpISUNlWEt2OXNtM2VpZHYwY08wN1RheHFOS2ZHTmJQVk9kMFFTYzNC?=
 =?utf-8?B?OEVrRnJ5c2lRMmg0QnIyQ1dTd1dOdkhBNVc2STU5ODBDN2VYcFp5TE5Nenls?=
 =?utf-8?B?Wmx1dVh1MWw0RWl1WkdzYXRiZEN5a1VicWErZ1J4aXZJSE1hbkdMRUhkMzBW?=
 =?utf-8?B?WEdpTEx3anI3L2ZIOWdVZXB5elg5NnpPbjk0eWlDblpUczI4bXczZFBFd2xL?=
 =?utf-8?B?dzAraXJRWG45ZFgrTlBQY1oyRVgwR2RDRlNoZ2FDREV4OEd1NGJMdmljaVRD?=
 =?utf-8?B?aCtVY2U1am4vTE5yQ3o1YjhmL3FMbkkvdzFreXc1U3BwaXgrTFIvOGhtWXdW?=
 =?utf-8?Q?BFH8tswnCmfr5ZhXeiONMhLKs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GOiallz4MQeMDL8zghJj2gPmby0SP8N3mteSWoK8KkhPzrs3av0kEFvVsK/CK5z7QwYM7u5IT2k0kuPYcdN1Co5ceIFkgrJMIGL8uCMbi83dCSuntY+e4N4KD+dEcUXcBiaQABFpoeLErf+Xsr0kXz4QLkSHR+Yfy1+vrcpzDBCHEAvEFTOVRYAlz/5HryxlwQK/RSq4vV3Hyq6WCmrOjV1E3Sc1bQgM/1C5njIYby6BHLMqBmxgcd/btUrPXjuAs20g+QBcchuJ4ZbOME6a8393saUmriYIZZqpGzemDjfRI96JOS3hce0JSdpc3uljYo+/nXB9cZAb1Vd0W1KbhpWB6zHMj2zT1LW+Mtg3gZAjtoUyMLfLWE7hFm2u92iEdGpM2GWmDpi7Nza7F6NnenhRbdcP41dO1XndQoYkwAkzg8A7I1wXT4V9oD3TD7aqG7pGcveqHur9PfdT4nH/ioNYpR1a1sJCC42diTd19xhwd6r3TrE71jLOKnUUIJCWfA87lDR8YyOo4Mldp2tjrRswJXKL49xrv7AAm8m2DpcMnthxUCIiZC5XhWqWjoWGkhwABXhNDCkQkOPEtakcuiQHB63cxACu7cMiAvRJ9HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5183cc-9afc-4ef0-e143-08dcc2d4d048
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 18:04:06.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vrkm/QJtB5vnUzhlVgAHTarTwr3xw49ANH/AiVu+snFgwHPy5jn/UWgfmDrE/uJ9dTp2MMXABvwXjKNJNsttvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_11,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220135
X-Proofpoint-ORIG-GUID: pCbEShhC6f9S04hjD79h8fW7tlLB9-nP
X-Proofpoint-GUID: pCbEShhC6f9S04hjD79h8fW7tlLB9-nP

On 21/08/2024 18:11, Darrick J. Wong wrote:
> On Sat, Aug 17, 2024 at 09:48:00AM +0000, John Garry wrote:
>> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
>> flag. Only direct IO is currently supported, so check for that also.
>>
>> We rely on the block layer to reject atomic writes which exceed the bdev
>> request_queue limits, so don't bother checking any such thing here.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 9b6530a4eb4a..3489d478809e 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -1149,6 +1149,18 @@ xfs_file_remap_range(
>>   	return remapped > 0 ? remapped : ret;
>>   }
>>   
>> +static bool xfs_file_open_can_atomicwrite(
>> +	struct inode		*inode,
>> +	struct file		*file)
>> +{
>> +	struct xfs_inode	*ip = XFS_I(inode);
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return false;
>> +
>> +	return xfs_inode_has_atomicwrites(ip);
> 
> ...and here too.  I do like the shift to having an incore flag that
> controls whether you get untorn write support or not.

Do you mean that add a new member to xfs_inode to record this? If yes, 
it sounds ok, but we need to maintain consistency (of that member) 
whenever anything which can affect it changes, which is always a bit 
painful.

John

