Return-Path: <linux-fsdevel+bounces-13869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA713874DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D3EB23BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF812A149;
	Thu,  7 Mar 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EipTBU0o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EGm+QrsX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BC1292EC;
	Thu,  7 Mar 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811616; cv=fail; b=IDow/+CTkTxFvd7DMjb0Iv6hI3ZqJTKaRPMSLv57dYV7jJH0PYWnq0gYqFjlygT18aTHDcmuONOVe8O4ooImTQpajWBzVw6KMZXcVBiPuAZV1A3u4Qu3xRziOEqhzudVs47pIJ3NlqcvMjhVKGma8dFkHKwKUvwpTxZKhsf6WYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811616; c=relaxed/simple;
	bh=B99rGPUvBF835y3khroZlq3xQmn0nO7jXOgzTCdDIIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P0r/NfN7TDWVsSOdXMRmu0UiZEhTlrZF1jrRRT6MEfERSxquqhS0XYHQUPG+/OLwSjM7/oBkV2UW+mhPlF75Eplq56Onk3DXDZvj6HOxpDefrsS4/rnz5S/sFNSatf9cjZyyOIdk68dtviiH5y82qGMSCQ+mtr3FYWfm/cplTSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EipTBU0o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EGm+QrsX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279ndMZ020827;
	Thu, 7 Mar 2024 11:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mS6was8Y5UUd3IwtIDaMW7u2XxA2L14SO2QPbB+mpCY=;
 b=EipTBU0oGJ/nzgllCsHpiLCrDMw9+wZ73Pz6R1lx/mJEkQ3eTjXn3XZFhKgQtGytcaV9
 jZERZS7/dQA+fVfHR80X1nIzY7bxWq0sE5mj4Cj7P1YkNqtiYZttPslu+QbGtiU0ugbB
 bLYRWEEqvNFoYQ/iQh3z0r3QaE3+XC43TvFgAWhS35hNknxtGUxjQ9Cot4LDKQZMBKX6
 eeGXirMlrxWWYfqDeOt2itfqtFOfuWYCiAHHV1oj3vOmLSwDSHCmoXO4oq0PtxmIhq3O
 L+tIalKIBIWXAg4rnWm3CmWFr4CJeRV66t6irFoWOAPUVGdgfOIYaix991TJ5kNn/A5T Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2brwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:39:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427BaWeQ040811;
	Thu, 7 Mar 2024 11:39:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgvkfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8vA6Hi5RPhhe45q8RA0LsJUkHqIdVnUl7lCC8JO/1ptp5DtESG6Fcoc47EAV73oF+rOS+G1T3bZKOjnL3aIoSV1Szf/PxadM3CCOOhMGpIGpoe3vKRTtsHytySnrtMCQIjwR/Tefv0Dkb1Q3jNRPV6BWwBpRmbitJfvU9F+I7qqPwxA+5qCOJryLWc4R5a5q99jHIp0ZlDU18o6Pjn8N/tJV45NewZuBoqVu9Pw5ibPFmrHegro+X9vEWtasgWUwrixWavfgyHG9nXdTR4tD2Yg1ApEVN6RfObWlaX6JEd1S2IGjT26/qjxsFOGqXOL2XEq/sYgJVq5WRNSRP6VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS6was8Y5UUd3IwtIDaMW7u2XxA2L14SO2QPbB+mpCY=;
 b=XB1EhTMT2JkJIbaJcHklHoNHFqyqWEu+ve09LMYumjvdeyrg4bQczLQwbeK7TLKQxPG7wL3gmKlPvPdKgTNwZm5ynqysH8wuleg8URqdnFgcX1r3LF2MTBUKLyNX9m69DrQdr8yA2A2i/Ss/fAL9seFK50cKyOB0LwlfK6bEQxqsEJpivab/2hp9vpKo3ajxOw6RZU3Ysn/wbNdteoPG9tsUKxCsyclF3PyfW7jnFrViF8wc2mjEobagp3j8dthAG9k9bFxn5sFdRrxPt08Fo6+Una8JWq6rnTVopVKucauMH3yHoIIeXrSvL9fSlqb1OSlIDM0o2e7N/QKVC8mq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS6was8Y5UUd3IwtIDaMW7u2XxA2L14SO2QPbB+mpCY=;
 b=EGm+QrsXi/6jdzgx9M9ntzXvMfgCqUa2I0Fpr56lcwGg60hGSCU7qH0/qHzG0OeOvabFX7wBfskfjoWKg+lXgxdc5kvW8KXphmG+gZyS/7K6DCfKsfoKcJMuoMMsv+BmQJ5WTpX1C8ocATehVebIEU/5Cand/+RE0pHrXIErIYc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 11:38:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:38:59 +0000
Message-ID: <dac177e5-793a-4955-bc82-9838a1ce6dd5@oracle.com>
Date: Thu, 7 Mar 2024 11:38:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] fs: xfs: Do not free EOF blocks for forcealign
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-7-john.g.garry@oracle.com>
 <ZejbFuavNva4ut/3@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejbFuavNva4ut/3@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:208:be::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e8b0a3-8602-49d9-d663-08dc3e9b2dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R8ZRrmAtOuWxigUnnF7qH8gVn9XizHKJOTlYLw72bh5yKMzJ1Hx1ktw6Pgiu586CsoXobz/x1uG4uJxDxFxq3fc2QVcWt5pqb+9op9O83vMzYuDv9lYqHkGJnADt7a0+qQUCyT8B5gcX+YU8tgfJbkQ35DcJhIr7765lsLSRXntONqS4ciyfs1cGSdm+fRXT8c70eBJXMP+Pcc94mVHthQ+CcRS6Zz355oYVgzxaTDiVQlYiCqrvKp7BSZVm0Ja578XOTuWhNrqwfjGdwPuqSiqlH2CTToVq+bR3826uuVc0wNQrVL+N04vnAj7VBgs3Q+jxYzdwdbehWpBNh2x2ZcinQnHWBX+y/89RLZHBEEktkGZ+hdYQdNfcpr/oumyb4NrCeL5NVYupti+FmINFaTyRsx5eBSxn7H+GzpqX7Jk5VUpzKH5tTX7L0eAAWbeOHm6FcsC/VIod4E8VegvkgtDqIRR6KWXs9HQY0O9+RtO0TxZxVy08ERdb9vPDgnRHUaepUWSC1A0JblFdaNEolU3dcbSsThHvrE0GcjYIFjXyn2tmEnaYuFuLPZL/V9c0xmIcsenxId84/YWeIJVmTM6rpU+3lHn+CeGmAlXRIFaJvS2/GEWOPgsFYUM7FE+kRn72R2gk0xfbxLfyU9GtpA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkdLMTFzV1BDby82am5wYTRHZ3RPYU9nRmJiNEVPdUJVejJtWXMrSFIvbGla?=
 =?utf-8?B?T28xck5vN1ZTVUF2Z0szVzZKSkFFbnRocTdxVWU4MmlHMFBCam5pVmhyWmlI?=
 =?utf-8?B?bkduMlhmTnNVanlQWmErbXRwS3hkQnFRRWpVVG1jZUsvUDg4QkpUY3JvUHNL?=
 =?utf-8?B?N09QSE5pWmdBMzc5Vk51bUwrb0FicUVSNFcva3VhakhCZ0kyZTNXTE5PeE1w?=
 =?utf-8?B?Y2FLZWI4R3hhdjAyVGZrVVkrMlE3bDh6Yk5ONEZTWStZMmJzL043ME1rbk8r?=
 =?utf-8?B?TlhnVWRHTUxwTEtOejZZaVA4Z1hVSk1rcXErMVdYZWFPQXdjZzlKVHBXSVpJ?=
 =?utf-8?B?dm9LeUZSa1g5VE5uWUJEcHh6TlJWd1ZqdFVrTnJKUUZWRzJJUTRoZElHTHg4?=
 =?utf-8?B?Ymd1YmVVdHF1dURWTlJRVGJsbDR5aEhERDFjQXZId1V3WnU1NE1VMXE1R1F2?=
 =?utf-8?B?TUNpcXNMT1BoRUVKcWkxK1hzSnRoamlCOTJ1cWlsdzJkdjg5L3hlSmNKMzVU?=
 =?utf-8?B?MHRQbVJZNStZR0VhcFd4UzVRWDE2cDFlNXIzd0pPeFJuRnNsakg4ZkQ3TTRL?=
 =?utf-8?B?VFFWZitDYmtReGpuaWUvOFlHK3pUVjRyT3hkVi9Dc1JuWHB6b1hkNFJOQmxZ?=
 =?utf-8?B?dXVjQnhPSUowcldkL001ZDBtV0RGRkh5TUc5MkZ5cXl1bWw3eWszcUc1aXJY?=
 =?utf-8?B?b29nSEF6WnJsOHVoQ242WEpLWFJ0Tm0rWWloM3dMVE5laUpCL2RkMFpQUWds?=
 =?utf-8?B?bnhCS1owYVFmb0FqdWZmNkNOYzA4Ylp2em5BdmswTnhuS0RKeEVrcXVJaUtu?=
 =?utf-8?B?alFESmJXSXNpS0lPMXd1VSt3QTlJMVFPNDZHNXdsZ2FxOW44V3p6VlZIRm5o?=
 =?utf-8?B?WGZuc1pnQ1RZdGVPbkpQTVRMeEFKeWtwb09LRnFhZ0Ywampkc2xMS2wzQWli?=
 =?utf-8?B?d1FlWGJuWG1hdjZld0N2ZzN6Zk9SRytuSVVNOGljZ1lTWm5zcWJmUndKWWVw?=
 =?utf-8?B?WFZDMTVVSUsreDdnQlhMbm00WG4ra2lKNi9JQm9nUUgwS3F3Ym5BYmQrYVFa?=
 =?utf-8?B?Y1FMSmFrcTRxZ3Vqa0J1TU11dk9BOTBCcUllaTQraHZGeGwzQzhMZzFTY0V3?=
 =?utf-8?B?Wm1ZZE1ZbHJJSnl2cUV6RkxtZVF1VjZubkFBUm5tZVhVYXl2MVVVbW54MXJE?=
 =?utf-8?B?ck40bFhBNGZ3aTVGUlBvbFRiWUl5T25PVG1XaElYaWN3QjhhdXpaL1VZcjFE?=
 =?utf-8?B?cmxJVUpHZE1CWDNTOHVTRFJJZk9jNG04b1pjcHlmNXozVEcxN3ZRVVJsbXQr?=
 =?utf-8?B?Mmw3MTBqbDdOa1lWVkhSYjF5L1gwdkI2eVUxN3hmQTJqdnM3dXd1Q3FtR25L?=
 =?utf-8?B?VmVjcXlCWHdtYUI2Y2xsQ0V6TWNxZ05PZVJJL3B0c0xFdTdBTjZMRDQ0aytG?=
 =?utf-8?B?N3NmeEhlOURyZysyLzBRbDZuQys1V2d6Y2lrM21HTjFOWWNBMVVobDZnUUxa?=
 =?utf-8?B?bUZJa3Y3V3lvNVpWYk1wNjlLL0o5ZFR1Uy9qYks0M0V5WjNYQXZBOU9WSndr?=
 =?utf-8?B?QkxGeUxISUE2V2E2cUtJaXZVR3FDWGJEVE9oZFBFNE9XMTNTc2J0bDV1QUhP?=
 =?utf-8?B?NmFsckNMU0d1b3N6RXJuejhhR0R1bnI4YXVVMG5aS0xGUEtheXRwaU5ra0Zl?=
 =?utf-8?B?QzhUOUxDUTRMQ0tJcXFMUHJoUzltZmo1bTluNCttK25wMEx0Y1R6MUpuRTNQ?=
 =?utf-8?B?OVdCaXZyWFVaTDJhRHdVVmdYb0psV3hsR2FCRGVlTk5MU3RwenJGQkpPWXdq?=
 =?utf-8?B?MWJhc0tpUUF3Vml5UENVYlFsV2xza2JVQmFOS0FMMXlPaEtueGRDVkEvZU5q?=
 =?utf-8?B?V2p1UjRoRFN4Z0NaZjlNVTNQTUJCaFEvL21XemhmY3QrSlk2YkhIMTVnMGN1?=
 =?utf-8?B?bno1VlArN1labkRyd2dUN2RJWCtqWVdzVEUvRHBHRHNtRy91bW5ZaS9Gd053?=
 =?utf-8?B?aGVXMmRWN2thYnZRaUEwQ2ZYVnRCVHZrK1MrUEFZRFhVemsyaHQrOGUrb21J?=
 =?utf-8?B?Y0Y4VkZEZXgzVUNmaWlVK3VpNi95bWhHYkRKTjE1cWtkMnJpR0JrWnB2aDVu?=
 =?utf-8?B?RURhcHNOTHIxUWs2T2pTd0F5YW4rSjB0amprTURZYXRrNkd0b25oeEZIY0Mz?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7sfTzB2lXiS0AT71jTFgmvnE2FFMNZHeiAbku8oMJkRsCHTpQjfvAlkbkr0d/Fj5OzDYYhuq94FqEQs3+Lh4qVzx2buogUitrTWQ0ziVzQb0b1wL6l/n57uzTXv/0XkRd+YZqawCDTERK1R3UOetVTGY0GpIkcfmAiRedIMDhHLnSh53dT2poC86RwT1Ta4J5JZWLfSRGvkbaA8/JHVOMw9tfXLs5gEWCxtKX1Jq7iSVI+QDyyA31OXXGk5/+tfdWbrxuxCl6Bz+gCFdz+Gizp/U2nTyw0Le02+g3Gk3omXnjREQd7sPQB3fRzJSxoJznROJHn+31RvMV4+C6M+G88LG3onyLN0NmN3DWVrctzgjSnhTO8fiO8pD14UzrFexpgsswrdEp0mEvH9Hb2ZyuwQaG1/uIrsv9WVQKC/j3MWSDx+GjfEgFoL166IwBcqbzC7/DIuQG4UcGn+vhwx1jgPySfJ3WcfwBxe+Ra2KGY7pGx2ID74RjGlR52BOPP4wzfO0hcFR+matFdFI+Pf+bW795FfMQs5nnvPff9io9pjMR3ffOMBElluToYpijwW4IAQDv7o8V00puth3A/UfihFtyptub+SsBr5G7vu8UT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e8b0a3-8602-49d9-d663-08dc3e9b2dfa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:38:59.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjmtW0MioMQExLSmtLf7FpIFAKhUtW3G2zTXDrs6ae9scKdS9LVGusXlJi+JbWFH5CsflZWxEWqoG62219sS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: RIgtCKAgnlvoR4xADa97vC1wqfHqMR8u
X-Proofpoint-ORIG-GUID: RIgtCKAgnlvoR4xADa97vC1wqfHqMR8u


>>   	 */
>>   	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
>> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
>> +
>> +	/* Do not free blocks when forcing extent sizes */
> 
> That comment seems wrong - this just rounds up where we start
> trimming from to be aligned...

ok

> 
>> +	if (xfs_get_extsz(ip) > 1)
>> +		end_fsb = roundup_64(end_fsb, xfs_get_extsz(ip));
>> +	else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
>>   		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> 
> I think this would be better written as:
> 
> 	/*
> 	 * Forced extent alignment requires us to round up where we
> 	 * start trimming from so that result is correctly aligned.
> 	 */
> 	if (xfs_inode_forcealign(ip)) {
> 		if (ip->i_extsize > 1)
> 			end_fsb = roundup_64(end_fsb, ip->i_extsize);
> 		else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
> 			end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> 	}
> 
> Because we only want end-fsb alignment when forced alignment is
> required.

But why change current rtvol behaviour?

> 
> Which then makes me wonder: truncate needs this, too, doesn't it?
> And the various fallocate() ops like hole punching and extent
> shifting?
> 

Yes, I would think so. I quickly checked rtvol for truncate and it does 
the round up. I would need to check the relevant code for truncate and 
fallocate for forcealign now.

I do also wonder if we could factor out this rounding up code for 
truncate, facallocate, and whatever else.

>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 2c439df8c47f..bbb8886f1d32 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -65,6 +65,20 @@ xfs_get_extsz_hint(
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Helper function to extract extent size. It will return a power-of-2,
>> + * as forcealign requires this.
>> + */
>> +xfs_extlen_t
>> +xfs_get_extsz(
>> +	struct xfs_inode	*ip)
>> +{
>> +	if (xfs_inode_forcealign(ip) && ip->i_extsize)
>> +		return ip->i_extsize;
>> +
>> +	return 1;
>> +}
> 
> This can go away - if it is needed elsewhere, then I think it would
> be better open coded because it better documents what the code is
> doing...
> 

I would rather get rid of xfs_get_extsz() for sure.

Thanks,
John


