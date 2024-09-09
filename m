Return-Path: <linux-fsdevel+bounces-28956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1A971EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B3284BAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92813B797;
	Mon,  9 Sep 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNQxoNWs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i2D3Yw2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BEC156;
	Mon,  9 Sep 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898751; cv=fail; b=sjZf3rd6HX2m978K9GYP3p8WHCB6/2g+NySVqUE8RpU6cOMVhuWyb4jsZ2LbQ6PUd1pZ/M6Ss5kKn83OEHqbTKPWu0AN/VU8l3RFDOigCqtwlgJi1HxZ14ZbtxNQL+xPZavnwPIVzcBjZGSi1ZwBg4fTRx9Hfys+DZYdQG8PEQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898751; c=relaxed/simple;
	bh=jqjt7WdZHhtJFnoq1He5dMGHHR78bxAqueZN2u5hKtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFLxj+Cchx0wp+Q/rpFvxVtOlbra3UCjSm6O/1fAGwhef1drfSargQ4tLVF9qizfWt3SeFMiMBXexF3P1/OcE6SF817nbWhmErHhgn8g+sSbDfVmQNbJ/U7i5JU0RAG08yBg4MJBMD0X/lA8HBnf9eWS3sB8qEkFQpS/Vuk3Q+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNQxoNWs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i2D3Yw2h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489G0R9Z018694;
	Mon, 9 Sep 2024 16:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CTW+c5Twg8t8zA3QU8+GxhU2lqKIwTuYcJkZ27+JLNs=; b=
	eNQxoNWsaJPsY5HUqrJP1DH7vdasYeRvRfnYykYC6BoMs0WPCghBr7vGpz+/hLyc
	aE0RcX03k5uqS/VRPSvchs4kKBh3Y4CB/rUfoP0GqSHLmtSD7zEH8KUkeTL1/zUL
	6ydKYVacuGkj4WzEepmnRL2+9VycxfzF/PQ6j5PTtuyWr8+u4mibG6YFxgNnsAs9
	q8iBFUj6zvg9H/6dk/209+YEbpCDhk9LbkN7MWISmycQ19GofqbfDWxrK/jZvCkz
	sF8RjjLewS5RdqrpP/Aow8My7c7jgm+7p/mrq6P6VUTA2UbCV8ciIcLZ4gp9B+Id
	UnUL+gBJAroYdPsybNFzLg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevckea1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 16:18:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489FTWYG005756;
	Mon, 9 Sep 2024 16:18:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd97ddfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 16:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3oPk/Tim31hsQyTkAkNvLXT5goD/SsWxnQyCY1d+EPVjVz90SjDhhZ3wj4IKac38bV9PcrzhQ/rUMmZPYLi3E8e2QtwmQYKHDiau6ubq1rudwOGWDhm4VeHfT5oBRN2Scbc2E1uU2QbbaTdoge3bFPuWhUjPJRALkswxs4RZn/uGjh3xxDtZqiSHsq6MHPR+Z+DoiQOLfrmJ28QANZ7JInGyIkdBc7JbQaowuYH5jAjoUAQtyMMiFbkCthjXduhFvefIL7hw75SzaI+5iRDJO6COFlVxb2kY7KT9lbLmrnR3iVazfBl3dVSf2d/BLlz9LELdXdYo1Z40fbPbp61wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTW+c5Twg8t8zA3QU8+GxhU2lqKIwTuYcJkZ27+JLNs=;
 b=G3gO9woGJXWlWu3uNsqk+8icaAW9WA1yZnyHr5mt06aJKG6xAJd2pixrrCzyiSHNGrnf/EVNiclBXDUxhLtwbqRDMrOFUeIOtnNPe92PNB+te2fZTpGhK3Pa0zUZ89E0XyJCDVQzqF3ZAT1/nfBzk2Q5q5GxrRhV91sl3NWrVuu/5xqFNwPuxrpNgpWzpW5DgE4pBJ8WaXpfIgJT5v3ZsNAGRfPEvqbbpozAogfb/7yptNgDODcEL941M7F3qTHu0QtnhbSnWdhBdYz10mKEaJG60n8asFgS7d+44MkNGrjvH6u4NHhuZi11gbJQWhZq92w458vpIfuRhXHIOJd6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTW+c5Twg8t8zA3QU8+GxhU2lqKIwTuYcJkZ27+JLNs=;
 b=i2D3Yw2hXZIXlin2L/q9RT4PkMn9bzna9YL5JO8ps28XnMORaPZHQeFJAbE+GcwmGuLP9qEO/WMU0t21PeyQMTBjkiP7kQfMuQObGTS5JCRtDWY5bdb9Iwpz4FZi11oi5KMRH2fAJrGwTcXfTnAIbuB7HP27hWbnThDG5cDsS9s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.9; Mon, 9 Sep
 2024 16:18:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7962.008; Mon, 9 Sep 2024
 16:18:48 +0000
Message-ID: <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
Date: Mon, 9 Sep 2024 17:18:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: f2417ba3-aa03-449b-3c87-08dcd0eb15f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXp6UXJEc3R4Qi9xOURPRkF4NGhLNFJhcXVUb0ZhQ1FsVGUxZGp0UnIxQnRB?=
 =?utf-8?B?czJKSGN3S3JUZUo5SU1VbWxFSm92azlyS2NuenQ5NlBvS1oxVFcvZEUvUDdJ?=
 =?utf-8?B?d0gzdiswMjZGeHNzQk5GOXc3blVPdko5WURoZVBqUnFRYXJLSnJDcHI2Z1RI?=
 =?utf-8?B?VUorOFBOaUZVY05taGdQdHpxckJORjE5TjRRUTA5bm1OMWZpaUt5WVkxTEYr?=
 =?utf-8?B?Qk5FMXRRdUhYTnZuNFFZb2lGQkdmckY5ZEREWDhnL0k4Zmh3RzhGbUVEeTZ4?=
 =?utf-8?B?MEQrMkhtd2NFdDVlem04WnRSNGxHN2N5eWl1TTJCMVN6bjVKb2hRRXRjdmdk?=
 =?utf-8?B?V0R3MFlXR0psUW1RMGlWMFd4SzVMVVlwYkNRSjJWbW11aERMd3JpQXZ3VmVH?=
 =?utf-8?B?Qno5Z0M4WHl0M1Y4YlR3NkZ5aDBZQnA5RmRjT0VYZ2ZUcWhmR3UySkpON0hz?=
 =?utf-8?B?L21nOUhBSEQzaXJrQ2lUQ1dtckw4SncrdXNDV0IvMENpanlQNVVmdWF5dkdp?=
 =?utf-8?B?YnZmTW9iZERIZjUyNFBCY2FwS01PRDdoWTZLY3dKaUlpUE42cVhhQVg0OVFH?=
 =?utf-8?B?TVRYbHpjQ0JrQ3lVQi9EWUdxMldMeTBMTUxGUTQvRFkyQ1hOLzZPR0N1ckt3?=
 =?utf-8?B?RzdVK0VnR2RKb2RqdUtjYjE0aWZnb3Q4OE5NMENMZndIRUFVVjRhbkxhczMz?=
 =?utf-8?B?UEhSMlZKVjYvMjEwdU1Eb3B6RDBGUzZSV2VIMUVhOEp0WURWc3BQZzFGdkx1?=
 =?utf-8?B?NVE0RHRPRGpDbXFxOXVnUHJaU2h0emR6b0FkMm9POU9EY0p1bDRCWjg2WWU5?=
 =?utf-8?B?WlZVNXIyN1hBM093aHVYeEFEc0VGSUtQcnlYQ1JXbUpqdU9mYisrVFl6QTFm?=
 =?utf-8?B?a1FLNmpwMlQ0MlRPNG9HKzBwaDEzdDF5ZDdzZG8xdVRhR0dGSXUrZEE1SXVs?=
 =?utf-8?B?NkhpRGdqbHBXS3B2SnBONXJOYko1NVlhcTgyRm5pTWplbmc5VWloYTJqOG5C?=
 =?utf-8?B?bnJBdDNqS25rYXcxWHc5c0hrbUxhbFFNSElhY0RReHNlRXFXdFhTYm51Znk3?=
 =?utf-8?B?VlJka3krVVdhNThVcE5qWlpXUFdQVHZMYk9ZYmEvTHhsR21aSDA0NnJXQThZ?=
 =?utf-8?B?TzZNMk94cldQZjI5L2l5WUJRamtqTUFtMnZ1SzYxOXlwRjJqdUNObUkyUFJB?=
 =?utf-8?B?eFk2aDRWdVkvb1ZSeWQ4OWdxTTNQWURFMWk2M1YxM1RtS3ZTWmt4c2xTUzZz?=
 =?utf-8?B?anFCZlIzckdMdkw2aElJR2ZWVUZkL2trVnZoRTIraVkxbVlWK1VUUEdib3Fa?=
 =?utf-8?B?UGE4VU1oeS8rVTlrTGNiZzZOQnhnUWRaR0VldUhmOE11RFNxNVQ2QUtINm9q?=
 =?utf-8?B?Y1BtcHBLaEZVVjFEbmhJT1pHcWdtaktRcXJ5T0FQaHRrSGR2RmJOemViUkg5?=
 =?utf-8?B?b3NIbWNzSjBIOEVsU1gyVXM0b1I4ak5FcEZXWXNwZGxMVFJoa2xDWDZBOEVj?=
 =?utf-8?B?ZXFGVEVqdXJieE4vd3VlRTBVQWVjSVB6THhrVEo3UTJCY0ZCM3AxNlhLa3Fk?=
 =?utf-8?B?QStJNHhUQm1BZ1hiNmUyUmI0WHowUFVrU011YUFyYWNxbWZOUnIxVGdhcERU?=
 =?utf-8?B?REdYWFdQNnBJSjlEV2tKaEdSbkpBY2REUEIxVVBHYno3aVhoeVdhK0lJMmRm?=
 =?utf-8?B?YW1RQWg1NFVVUjJqRWdYRklZQnFKY0E0QlFIRW9CalpsOUUxdTVDaG9GOFdN?=
 =?utf-8?B?YW53S1FYTjB3MFdzWnhKV1NUeDI3Y2tTTVdKRVNiMld1WW1CcXZ0Rk5FVUJj?=
 =?utf-8?Q?h9nHezun4/11XuKsCmkAjTwAUXnsW0gpDcvNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkF0MnM2WjVKU2xuNjI1dEUxeWY4bzRBekN1N2FDbVkxM3ZEMEIvTDFoRW1a?=
 =?utf-8?B?RU5wcXNrdzN6SWtjb09oZWpVVmJ4d2lXM1FQNEdHL1JwYmhzYTkxN3kyR3dB?=
 =?utf-8?B?TXFDRGYyTlFNcEVCMFl1eDlVMUcvenZaR2s5akJtVEdjRFZkK0pTU1hSa3da?=
 =?utf-8?B?Zk9GT1R1Zlh3WiszYW04ME41cXdGSFJ6K01VV0VvTXJXZjVxRE9LVXkzK3Jk?=
 =?utf-8?B?V0xwa0JRZHZTRnNyandxSm56ZDExUXN6Z056Ti9NL0pVOEZXWEx4QXRObWlJ?=
 =?utf-8?B?clpCN2xGalk4VHNCK1FDNjFuRjlKditwRUUvNG5qODljaWQzNENsMVdHenZD?=
 =?utf-8?B?M0VsNzBHbCtkMjhYcFh1VmVVcmFwWEFsaHpMd2F5dzE4WEhHbyttMzZ3N2Vh?=
 =?utf-8?B?SzFOTXBYNGVXRjdjenQ4aERNTFd6ZjZoeitORW5RUlBFNTgrR0YwdUpIdkty?=
 =?utf-8?B?SEZZbFRoZHUzSTVVMmpEVU1vbVFNMTBaOWRpc3lDRmtsWi9MdTNORUV3V1lI?=
 =?utf-8?B?Z2d6RlhVd2hXT3d3aElXZCtESEU2aGlQeTRvNFViN2xIVWpWYS9pUWJOK3pQ?=
 =?utf-8?B?QW45ZVJKanUxQkM3WUJ4YzVDVjdvYUh5bDdZcGdBdWltQktlUHFoakl5NXpS?=
 =?utf-8?B?ZE5QMGZwTEN5Wnl6cmNTYmgvWjRsM2sxMUR1S3p1U0pIa0R4ZmJRdE1PWlBo?=
 =?utf-8?B?YmdJR3ZxSFc4WFBIWkZNaUppdk4wWjZIWTVzWmNncHVvTHhOdUdsNXByRklq?=
 =?utf-8?B?K21nZ0N0c1ZkWkx5WDNvQ3J1ejdqR29SYzZ4aTFHWUVLWmlubXFXVUg5Zkl0?=
 =?utf-8?B?b3JuRkQ3MUxDRWdlNjBwbUJHbnlXdTR2YmdZY0VqUjlVYkkvRmptdmZBY3Fz?=
 =?utf-8?B?WkJhR3dab3paUUlESUxlblpIWnhaRkFDZ1A2MFZRRExtTTU5aHpVZ3ZJYmJG?=
 =?utf-8?B?ekN1THJuVkdGRzBaTm1DNll2NkpXSStNU0FPbVZhRE5zdTIvNDdTUnprZFUv?=
 =?utf-8?B?dm92MVVsb2hFNkFMTVlqTGtsNExaT2d2UlBaRTlVNzVXUlFwb3NoZzBqcFJ2?=
 =?utf-8?B?M3dHaFoyT2YyZG16bEowQmxHc2ZyUHAveldVZnNpdHpsbFNIam1tQU1mYk15?=
 =?utf-8?B?bUJNRmtxU0xFN3p3MlRWRnVZWGFwZzVQcWdzcXVvNE5zYitCVVB3WjlHaDE3?=
 =?utf-8?B?YWtYejN6R2h1TGx4SzJBZ2trYU1IZ0xmSjQ5WFc1ZXVtNWdNUDV0NThCVkU1?=
 =?utf-8?B?cDZOeWZEZUxrWmFHSWpuN0VSeXR5T1Z5ZUhPMWRaRUlaSUNETFdsOUVqNERZ?=
 =?utf-8?B?YkJpOTN5U01iS1NiZFliWEZ1SDV3QURDSUY5K1lsb2ZwbVFVd0Z1bk0xUXg4?=
 =?utf-8?B?a29kRjFtQ0FJS0R5ZDdBNmFVTUMrYStHRFZpUWlvQmlZU04yWWNOcGt4Umtm?=
 =?utf-8?B?ZGZka0FkSXRvbDdSVVRGS3l5Ymc2dXh1bDJOQmQ2VmE1a2Noa1Z2dGp5RWhT?=
 =?utf-8?B?SEo5ZXBzS2VKS0oyY0pNbWR6QzI5N000VEM0NHduWDBWV1ZucTB4WFVBTkl0?=
 =?utf-8?B?bTFNeG1HVGR5U3RMUXFTVjBlcWMzNTFnTytCYlpzOWIxbUhaSGV3R25oWlQ1?=
 =?utf-8?B?Qjlvc3JMdVhpaFVzSEJybHc0a20wYlBpUHpqMnNrTjI2YkdQaDlFRTFiUkFo?=
 =?utf-8?B?SWNuVjdVV3lSL2JndjZoRkdvcUpWV2QxSXR3djcwVVRCU0RrN2VYc0h4K21s?=
 =?utf-8?B?bDVCRkJJY3lBejl1RnRDWmpNcE95S2VaaXdQeFZadVlRQk84K0lsTUJIeGxH?=
 =?utf-8?B?bDU1NWFUYk9YK3RiZ3dTUEFIb2NoekQreENmVTlRWFNrZnRFeHpqN2NRV0hT?=
 =?utf-8?B?S0hhc01TMWxjeDBlTFBCTTVYK3JwODE0eHVuZEFqV29JRXNHWjRiRVV2c0p6?=
 =?utf-8?B?S3d2VURYL0o3YytJWGE2Y0hjQzBlMGN6Z3JFTEg0NXYwSmhOYjloNGc4aEZB?=
 =?utf-8?B?Q2tPNCtWSThoMG94TGljL3YzUFlVeVBRRHJ5UjFzdnpjd0RwbndQRXpwVklZ?=
 =?utf-8?B?M2ZxOHZZMFZNbXpiQUNHNzlBSWpDUjZGQ2pUU2ZxOFh6WlFZTXFYU1Q5WWtC?=
 =?utf-8?Q?MC+oKKZ6eI2W8Qw+JRAnnZOT0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5+HZspF8mVoP1PmqjkG0sBHgA1IQpmBsYxpg2zDDm8D2jSKK9FijaWV9DzmmQC5Lu8s3Sa0nBiOXi79cyfziRBnIXfB2WysBB6RusqlgD5F+q1AZLWspxAuRgpW/OVai1C4+bjRUTHhfG3A9hO5Fa0OezNhaQfb09CwmYSm7xFu6cZOh9JRSaGty+yOiNsZvUCQQXVv1k8GZr4QzvXJ/Gh/+FR08F1wmorfA3xOBxXBgdY+iAJR2EhWHFJdOwlYzgqsIsuzjB5gDwWczGmCiRYuOUvmpgDrdfSE+KB7gwpGwHycKtDIjsz/Nxr3jMa9F5ESWk5Y5aaNEsFfW+1nrytGBDQSkqnsa9qkXJMRM6uDjmx4cZvCTmSM5rzLGOUwf++7aQ0WsBKa1xdAbkPipQtOppGKfy8MkNYH6y7jnHbmZGzoNH55eLNGyRhJzkCsxyOKvesuVKtZ/gSmVVPVrG+JvBu/Hv3PReLHje33ij0vZ4QW7c0vKW6DftWItlUZSbTyUYKAKbp3RQDJG04GC5LV+SbVVEG8FK1Jcd35TVfR9bu68iItTZc2gqB77pBqS2NBfUeEDUWN/aMIZCVUHmc1EeISPuu8skwjeIKgAqLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2417ba3-aa03-449b-3c87-08dcd0eb15f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 16:18:48.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeaROz+Nw1AjdJRKUfu6aFphShs46hsw6zOSw6+2jtJZDPZLiptVyVch1hvDoJRN4sAdcJldQXZnvibWW8y5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_08,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090129
X-Proofpoint-ORIG-GUID: yTh91DCISMMrVlWOPy5g5Yeq4spspJR8
X-Proofpoint-GUID: yTh91DCISMMrVlWOPy5g5Yeq4spspJR8

>>
>> AFAICS, forcealign behaviour is same as RT, so then this would be a mainline
>> bug, right?
> 
> No, I don't think so. I think this is a case where forcealign and RT
> behaviours differ, primarily because RT doesn't actually care about
> file offset -> physical offset alignment and can do unaligned IO
> whenever it wants. Hence having an unaligned written->unwritten
> extent state transition doesnt' affect anything for rt files...

ok

> 
>>
>>>> We change the space reservation in xfs-setattr_size() for this case
>>> (patch 9) but then don't do any alignment there - it relies on
>>> xfs_itruncate_extents_flags() to do the right thing w.r.t. extent
>>> removal alignment w.r.t. the new EOF.
>>>
>>> i.e. The xfs_setattr_size() code takes care of EOF block zeroing and
>>> page cache removal so the user doesn't see old data beyond EOF,
>>> whilst xfs_itruncate_extents_flags() is supposed to take care of the
>>> extent removal and the details of that operation (e.g. alignment).
>>
>> So we should roundup the unmap block to the alloc unit, correct? I have my
>> doubts about that, and thought that xfs_bunmapi_range() takes care of any
>> alignment handling.
> 
> The start should round up, yes. And, no, xfs_bunmapi_range() isn't
> specifically "taking care" of alignment. It's just marking a partial
> alloc unit range as unwritten, which means we now have -unaligned
> extents- in the BMBT.

Yes, I have noticed this previously.

> 
>>
>>>
>>> Patch 10 also modifies xfs_can_free_eofblocks() to take alignment
>>> into account for the post-eof block removal, but doesn't change
>>> xfs_free_eofblocks() at all. i.e  it also relies on
>>> xfs_itruncate_extents_flags() to do the right thing for force
>>> aligned inodes.
>>
>> What state should the blocks post-EOF blocks be? A simple example of
>> partially truncating an alloc unit is:
>>
>> $xfs_io -c "extsize" mnt/file
>> [16384] mnt/file
>>
>>
>> $xfs_bmap -vvp mnt/file
>> mnt/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>>     0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
>>
>>
>> $truncate -s 10461184 mnt/file # 10M - 6FSB
>>
>> $xfs_bmap -vvp mnt/file
>> mnt/file:
>>   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>>     0: [0..20431]:      192..20623        0 (192..20623)     20432 000000
>>     1: [20432..20447]:  20624..20639      0 (20624..20639)      16 010000
>>   FLAG Values:
>>      0010000 Unwritten preallocated extent
>>
>> Is that incorrect state?
> 
> Think about it: what happens if you now truncate it back up to 10MB
> (i.e. aligned length) and then do an aligned atomic write on it.
> 
> First: What happens when you truncate up?
> 
> ......
> 
> Yes, iomap_zero_range() will see the unwritten extent and skip it.
> i.e. The unwritten extent stays as an unwritten extent, it's now
> within EOF. That written->unwritten extent boundary is not on an
> aligned file offset.

Right

> 
> Second: What happens when you do a correctly aligned atomic write
> that spans this range now?
> 
> ......
> 
> Iomap only maps a single extent at a time, so it will only map the
> written range from the start of the IO (aligned) to the start of the
> unwritten extent (unaligned).  Hence the atomic write will be
> rejected because we can't do the atomic write to such an unaligned
> extent.

It was being considered to change this handling for atomic writes. More 
below at *.

> 
> That's not a bug in the atomic write path - this failure occurs
> because of the truncate behaviour doing post-eof unwritten extent
> conversion....
> 
> Yes, I agree that the entire -physical- extent is still correctly
> aligned on disk so you could argue that the unwritten conversion
> that xfs_bunmapi_range is doing is valid forced alignment behaviour.
> However, the fact is that breaking the aligned physical extent into
> two unaligned contiguous extents in different states in the BMBT
> means that they are treated as two seperate unaligned extents, not
> one contiguous aligned physical extent.

Right, this is problematic.

* I guess that you had not been following the recent discussion on this 
topic in the latest xfs atomic writes series @ 
https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/ 
and also mentioned earlier in 
https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/

There I dropped the sub-alloc unit zeroing. The concept to iter for a 
single bio seems sane, but as Darrick mentioned, we have issue of 
non-atomically committing all the extent conversions.

FWIW, this is how I think that the change according to Darrick's idea 
would look:

---->8----

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 72c981e3dc92..ec76d6a8750d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -244,7 +244,8 @@ xfs_iomap_write_direct(
  	xfs_fileoff_t		count_fsb,
  	unsigned int		flags,
  	struct xfs_bmbt_irec	*imap,
-	u64			*seq)
+	u64			*seq,
+	bool			zeroing)
  {
  	struct xfs_mount	*mp = ip->i_mount;
  	struct xfs_trans	*tp;
@@ -285,7 +286,7 @@ xfs_iomap_write_direct(
  	 * the reserve block pool for bmbt block allocation if there is no space
  	 * left but we need to do unwritten extent conversion.
  	 */
+	if (zeroing)
+		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
	if (flags & IOMAP_DAX) {
  		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
  		if (imap->br_state == XFS_EXT_UNWRITTEN) {
  			force = true;
@@ -780,6 +781,11 @@ xfs_direct_write_iomap_begin(
  	u16			iomap_flags = 0;
  	unsigned int		lockmode;
  	u64			seq;
+	bool			atomic = flags & IOMAP_ATOMIC;
+	struct xfs_bmbt_irec	imap2[XFS_BMAP_MAX_NMAP];
+	xfs_fileoff_t		_offset_fsb = xfs_inode_rounddown_alloc_unit(ip, 
offset_fsb);
+	xfs_fileoff_t		_end_fsb = xfs_inode_roundup_alloc_unit(ip, end_fsb);
+	int loop_index;

  	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));

@@ -843,6 +849,9 @@ xfs_direct_write_iomap_begin(
  	if (imap_needs_alloc(inode, flags, &imap, nimaps))
  		goto allocate_blocks;

+	if (atomic && !imap_spans_range(&imap, offset_fsb, end_fsb))
+		goto out_atomic;
+
  	/*
  	 * NOWAIT and OVERWRITE I/O needs to span the entire requested I/O with
  	 * a single map so that we avoid partial IO failures due to the rest of
@@ -897,7 +906,7 @@ xfs_direct_write_iomap_begin(
  	xfs_iunlock(ip, lockmode);

  	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
-			flags, &imap, &seq);
+			flags, &imap, &seq, false);
  	if (error)
  		return error;

@@ -918,6 +927,28 @@ xfs_direct_write_iomap_begin(
  	xfs_iunlock(ip, lockmode);
  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);

+out_atomic:
+	nimaps = XFS_BMAP_MAX_NMAP;
+
+	error = xfs_bmapi_read(ip, _offset_fsb, _end_fsb - _offset_fsb, &imap2[0],
+			       &nimaps, 0);
+	for (loop_index = 0; loop_index < nimaps; loop_index++) {
+		struct xfs_bmbt_irec *_imap2 = &imap2[loop_index];
+
+		if (_imap2->br_state == XFS_EXT_UNWRITTEN) {
+
+			xfs_iunlock(ip, lockmode);
+
+			error = xfs_iomap_write_direct(ip, _imap2->br_startoff, 
_imap2->br_blockcount,
+					flags, &imap, &seq, true);
+			if (error)
+				return error;
+			goto relock;
+		}
+	}
+	/* We should not reach this, but TODO better handling */
+	error = -EINVAL;
+
  out_unlock:
  	if (lockmode)
  		xfs_iunlock(ip, lockmode);

-----8<----

But I have my doubts about using XFS_BMAPI_ZERO, even if it is just for 
pre-zeroing unwritten parts of the alloc unit for an atomic write.

> 
> This extent state discontiunity is results in breaking physical IO
> across the extent state boundary. Hence such an unaligned extent
> state change violates the physical IO alignment guarantees that
> forced alignment is supposed to provide atomic writes...

Yes

> 
> This is the reason why operations like hole punching round to extent
> size for forced alignment at the highest level. i.e. We cannot allow
> xfs_bunmapi_range() to "take care" of alignment handling because
> managing partial extent unmappings with sub-alloc-unit unwritten
> extents does not work for forced alignment.
> 
> Again, this is different to the traditional RT file behaviour - it
> can use unwritten extents for sub-alloc-unit alignment unmaps
> because the RT device can align file offset to any physical offset,
> and issue unaligned sector sized IO without any restrictions. Forced
> alignment does not have this freedom, and when we extend forced
> alignment to RT files, it will not have the freedom to use
> unwritten extents for sub-alloc-unit unmapping, either.
> 
So how do you think that we should actually implement 
xfs_itruncate_extents_flags() properly for forcealign? Would it simply 
be like:

--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
                 WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
                 return 0;
         }
+	if (xfs_inode_has_forcealign(ip))
+	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip, 
first_unmap_block);
         error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,

Thanks,
John


