Return-Path: <linux-fsdevel+bounces-18493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF048B9753
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E440B20BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73A53E20;
	Thu,  2 May 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YQNXxV5w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OvvZm7Ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94A535AF;
	Thu,  2 May 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641190; cv=fail; b=Ln7WuivHmLqr8lej75WAiIAZTQQWoZm3l8ZueSxv0BCZotF5NICEc0mQUJu4izJinlKlCRfPbM+VzMRx87s27Rx/AjiWSUUgaQCqlz7tZ+lR6V/B3uwnOGKAr9PfSssjT+8dzbqlZ6VKuKwnPvwQNF4yjswW62MCK6Ie2epmX1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641190; c=relaxed/simple;
	bh=E/5MAverJAYUiXrchq2us5dNtxjYYnkKlJ75xmTqTNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NL/QwuEMZ3uLy5QKx7Pt4j99m5MeTuX5dUDZRa62OX8qZS2x+euhMXHWjXXZFIsrmDRF4tT3zoyTc39QmQxQFyKQaJ5zzCRt29mDjZuS4LuqOaKS8NBv0SRXCGVFBBZAaLn+DKpG6GZUjLH5NRpHEqE/Gm5YxuG/YN+LR/SrJmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YQNXxV5w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OvvZm7Ar; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44283wfl023982;
	Thu, 2 May 2024 09:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5vESaDxPxHjwB+SqkBToXnFELro3IAZlMX6MrNOOGKU=;
 b=YQNXxV5wxUA7A63eWUg5Y5fHAHJKDhhntaoeJE7OIhF3Z1aU/Sqh7RFT2BS3q0IS5Ygr
 ctBsBS9LdmWynuNBEh8h1V0qK5MsOGQJ9qecd8OBecwEc3SSZyBWUTn3Ivo2DUbKISM2
 jlSnPbFzL59QkWjO6YUs2/PUXfCCQY3jgQLcXzdKJr4NGra94DNBqOif2kiWsRFMCrMJ
 vvU1qRtHsthUF5t4C5/UG4tESI86kBQnMfzFDqa625SD+9t/6oCwywQ04gX06sQH4JsN
 YM26crsSBcnVxwzu4UBmO45kL3+10SY+LLe/uM5RBArc8vU5rQNmZBZ2JXR0UjSzO9em wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdey134-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 09:12:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4428oDBK019913;
	Thu, 2 May 2024 09:12:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqta4u30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 09:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxJYoR8/oBP1o9wrjGfDXpul2UJlDdgIequn83yE4aOJuRxpdZGWHIhEBAlFPivUYpJt3s2SrFk+zXoEB6S7Zpuf1n4gJbWTGX+nyLEjWSsK0s/D3bg7ICAc0orLDd6vzUB/I4KUEga2nAbGKBtPafRzwOtOFNHr4xJ4+73xu11R6mxJCJibPx27Z9LWBXlRqZCF231f+Q3XEHEyj5dJ58Mi4lQAAv4AtLPEYNl5q//1zKF6mw5254KrIjCQulpmPYxRq452JeXFbQzo3uCXEdswJF7QSDrNOkNLwNXIcn9wwmZBDzd0mTSvJm7oYNOJbP7aLOAdaNVqdGxIfZbnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vESaDxPxHjwB+SqkBToXnFELro3IAZlMX6MrNOOGKU=;
 b=ht2NWlenD/DjCcCnvxke8eTpDcKUbf6VhTau1gYMGrhyf2DGWDaRUqFNUwtUIsnfRT1fo1K2ZLiUfc2tSjEEneOaHLI5wmLIzznceWheZiezVuiD4EW8HKK35LkdpmcxpxsnyXNT2vRYXWH5tnweQ1k9x00qx3pcJQ3bH39RC8hTbdDD0h0QouylNMnTRXScVGSUH6boMpaMbU5OYcsndM7dtWER5fcPjKJVDL/3Rp4yUJoWV9Amz2eh97xiE/Reul8V5vb6zY3ljgh1IaV36wCL1P85urlDgukFpYb9JyybQaAUJlq6hPNk8t8biTWWxdBxTbEER53SKvVT4felKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vESaDxPxHjwB+SqkBToXnFELro3IAZlMX6MrNOOGKU=;
 b=OvvZm7Ar7fGEazOi5vfhDPqjiyV8U6yjWBw/vQAuhf0kBGHxA8VnaoOAnot0RUaiipOFhBIkqZeoFCDgRhjg2Q7va60CtyisXBOlvf8BrWWhZYwZZfrbcR8/Xe1jYrG3CwgkTAfgaRpDJV76RPXW29e1eLUY9ZxiZKPIyVlr+n8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 09:12:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:12:41 +0000
Message-ID: <70bc1a7f-1218-46d6-a8e8-96b667d393b7@oracle.com>
Date: Thu, 2 May 2024 10:12:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/21] iomap: Atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-18-john.g.garry@oracle.com>
 <ZjGfOyJl5y3D49fC@dread.disaster.area>
 <d39c46b7-185c-4175-b909-2ba307c177c9@oracle.com>
 <ZjLvw3Y5m9AxH71u@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjLvw3Y5m9AxH71u@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4697ec-caa5-4a18-2781-08dc6a880516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHpiTXplY2xNOE41cWFtR2pFaFpHbkgwVTZvbVlPWkt6Vi9nTTEwMDlqTGJo?=
 =?utf-8?B?b2Y1ZG5hODBtRjRLQURSR0JHK2U4NVZkM2RTalFSUkNjVjZGMldsbnJxQ0VQ?=
 =?utf-8?B?SElFaUNHTXNoVGM1VnFwK0xFUXovQzVpU3FYME1TOFBWMCs1dk0zUjgyQXRD?=
 =?utf-8?B?NTRlb3BCSTU0bXlzUUw2dXlTZkpDR3ZYeC9KRzYzankyaXJQczZMVTRNVEhm?=
 =?utf-8?B?VndmVEpydVFKWnFkUkEyS0Z4UXp1NGdYbWxRSXp2dHZ3SFNiVUV2R0t3WkJM?=
 =?utf-8?B?NnQ2SmdVcDF2UDNOb1lZZjVlaUJzbHdlWndrUEtTUS9qRzZrSEJzSUptUzlU?=
 =?utf-8?B?UEJzaDdWSmY4c0hGMkxQcHloTEFtMjNCWnU2bWVxaEdOeHdjZTAramdxWnR4?=
 =?utf-8?B?VXdJZ0hRY0FZK1hBcjhna01iaFR1c1Jtb29vc1NwSUxOZk9MNjFtUElPWDFJ?=
 =?utf-8?B?WUlEK3RvcTZRUWRVYU4yeHI2cS9LYWQxSWZhaktGR2d5S2lXR2RFSkFBUmNk?=
 =?utf-8?B?YU5id3d4ek5DVk9ock0yNEYzc2ptN20xMkZMMTAyWkVkWkN3T0J4Y015WXk2?=
 =?utf-8?B?NW1maUFlcEVjVkFvZm0yaFlNUDhBaUZqL2V4OVdXUUpzOGVCdmxVT0w1czY1?=
 =?utf-8?B?SnhQRGdQL3d3OGI2UjFDRlRXNHR5alJMOVBnL2VKTVNxbnNRNUZIQnRhdWEw?=
 =?utf-8?B?ZVIwaURmM2huS2J5dUdZb0hLQXMwZzZwM3laV2xSMjR6czJtcWhOMXNpd0lr?=
 =?utf-8?B?MzRiVEE1Wi9mTExUSkdUUzdITHJYVDBIalRsNWtVck5iWDVSR2pGT1drOXdy?=
 =?utf-8?B?S3VRLy9JcnBtLzFTbGxQdS93NWJjNk5KTXBhUTVXTzVEZ1A3KzNUWVJZS2FD?=
 =?utf-8?B?VzZVa29YeHRxTVNPbnVwZXB0c1JiZHFMcnpHdk5GQ0hTSXAyVGFFQllENEN0?=
 =?utf-8?B?R2ZwbHlZcHgxYVl3eXFvVlZ4NERsRmtEYlczVkM2TDEyaWlWd1RjWTg4WmIx?=
 =?utf-8?B?OWhCS2UwTXVKVjlJVTFDV2xoUzBOb2hKQllocU9TeXRUWUpRKzZEQ3BjRVJn?=
 =?utf-8?B?MTk3QmJCUFp6cUV2RW84UTZQUWhvTWMrQ1RKcWVob3NHUEM5RitJd2pJYzZu?=
 =?utf-8?B?dkhmVWljQTVJVnRqdE8xekhLZ3dJcENQbnE1V2ZONTgybmJpdWdoYXUxRXlS?=
 =?utf-8?B?RkZwL0xKWDljZmk0ajdHTHNZMmVHK1NQRTR6YkZ0ZFFGZEhCdUlEOHBnWkxC?=
 =?utf-8?B?Nk9vQ3NzRlVvMTlyWHA5U25KbEZibDFiRlUxcVZON2JkQWdud1RBMFFvYnJR?=
 =?utf-8?B?MFJJLzAxYlZTYjdDeHBzTncxU1cwT3FTVkRrZEFuZFBRQWkzT0xnUitvTUhs?=
 =?utf-8?B?djkrdGdLNEx0cndYYjlUWnpyT0k4MWJvd3ArcSs5Q2kzOVE4Y2ZISXJHQjR0?=
 =?utf-8?B?ZjlydVZIWEk1NzZrRnFNd1IzRnhOMFNGVnhENlREeFlBNWNzYkVaZTVzYTBR?=
 =?utf-8?B?QXJieTlEZDY0YlA4eGM2S1JkdUdlOEk2djBQSEdBQjV3SFhXbExnY0dwUVZZ?=
 =?utf-8?B?UHJaeWlIOUpXZUNQdzZMWkM3Wktxb2NQZ1BtR3RWVkxmcTc3UHhKVEo4YVBt?=
 =?utf-8?B?R1JxeTJDNm8weXFLNFNNb2JzUHoyWDVSSmYxTGw3c29Yc2JiZ2RLcTlVT1Nq?=
 =?utf-8?B?K3c4YWJiaGFtNU4vaEVmeFZDaDhHWTV6MDFRS0JscXEzbEkwM21UclRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTR4d0ZMQ1hqSVI5RWtaL244bGVMbTBYd3FIamRNWlQzZlI4b2RzZ1NpdVZK?=
 =?utf-8?B?Z1lyZlVkRzhjNGI4Q0tsTnFGUkw1ZHZWRGorek5TQ3FJOE5FbU5QZ1pOeDlv?=
 =?utf-8?B?VHphZHdlbjE2VXl0NHMwaCtzczdaOHpIYVR5Y2VFUk9jVjlOYTdoTmxjZ2dD?=
 =?utf-8?B?STdYdHVBQWhzS0U4Y0pHRFMxTjJWbXNmQlRKZkg4LzV6a3hmZHFTQ2ZhVlVS?=
 =?utf-8?B?RUxqYk9FczFhOWIwOGhBUWNNd2tYc3YvNE5uVTM0UG1wdWIrNEllREpvTHZD?=
 =?utf-8?B?VmNHRzloQTlOUVZWRlBhSjM5cFY0ZDhtTHM4T2g0SjRUblZ0dkJFOTNzd2tu?=
 =?utf-8?B?dDVxTERVZ1JCZjIwYTFZdENOd3BqRWtWV2d0WFEzcWpMR0MrM1lqMUVmMTUw?=
 =?utf-8?B?TmtjVHFtSHFpNXkrb3dpZ2FCU3FrL2crM0JBcHpGT2dtZXNFbno0NVByNllU?=
 =?utf-8?B?bnd5clB1bFVSTUlpUlFmdUFXWGJMUTNzUFBxZ3FOVThaSStjdStVZW1tZjVp?=
 =?utf-8?B?YjluWGtWbFJsbndUK3RMWjJWbWcvZG0vYTVyU092VlQrQXpDSGxUNndkMXBU?=
 =?utf-8?B?U01vQ09lMlVYOUx6cTZVbjZBVnFabXE4dHJEOFdyS1R0eU4yUEVIUGJNemtk?=
 =?utf-8?B?T3VDZUNCZmEvWGU5Vmg4RWlaQWFjcldsbG14ZVA5OVlyMHFweWZWdDlTQy9Y?=
 =?utf-8?B?NkgrU0JTcXBsVVdXMXdGcEZ2UmExUmJoa2VvK2NFK2lwNGZaWjhlWVBBVk13?=
 =?utf-8?B?SUlmQ1NjTHl4WmpNb21VZzhxa2FOcnV5NG5FdG1HSG5tYkYxeS9OcTBNbDBX?=
 =?utf-8?B?TmNpQnp5R2MwZXBuSk91WHFxSVNHMFNDczFiMngweFl3bVEvYUVLZG13V1cz?=
 =?utf-8?B?aTVFcWRleDVTTE50bFcyM0s5UmJWeWhDK2FsSlVva1ZJSFhFZWUrbHBscmR6?=
 =?utf-8?B?MndNS0s0M3Vvd3VPdnZSZ0pNVVErUU1rc3hNaEk3Z1c2MXVyL0MySUIvc2FH?=
 =?utf-8?B?TWw2TWRrV0luUFI3NGVqMml6RjBkbVdQWWlRbmJqM3NwUmlBSlNiYTdwRTdo?=
 =?utf-8?B?aUZqWHFDZmNUQWFPcCtqOUtaZSs1M3VVTmltQ1UrUFhIUHFoUGRXQysxVEY4?=
 =?utf-8?B?YUtnNWg3UklGTmJONEl6eXZQVFdEUXNsZXZzakczUVA3dzZ3QUIvWUx1TlJx?=
 =?utf-8?B?UzdSWEhvbnpCOU9EY1hBMjNHSmE0OElmL0RROElHM08xSUVPZkt4QTlvVnNF?=
 =?utf-8?B?S0k2ZSswTkdzYlNsdFhMeFRjSlBacGMyd2pYdmVPaTA1U2lWWnB2NUtnUy9I?=
 =?utf-8?B?R3pmckJibytlRjQzUDNqUzFpeGxjcloxQnE4TCtVTjAxRUN4YzBYWUE0UGdE?=
 =?utf-8?B?b0JJU0lsMm1RQTVocVRoaEVqenBPckhIbnpuMFN3QURxQTNlenQrNFdBb2tE?=
 =?utf-8?B?b0xaRVkrQlZ1QTdON0xPZGh5azJrYisrYkYzQ3lyVTIxUlVoRHl2RlJNZEpZ?=
 =?utf-8?B?cWRxVmJDdjh2Z2FKWkpuZUNnaDE4eDludGdXRXRObVVRWTFRTzBmUkZVT0NU?=
 =?utf-8?B?eWVmYmZjZTM0T2svY25iMmNXY2JCejdrZW1NSFNyMXl0YXlpc0ZINVJXdWtW?=
 =?utf-8?B?SHZ6djMwMlQ3SU9TY1ZoMzdPSWtXaytMZXlubnpQTllESm81ZUJKU0g5SVE2?=
 =?utf-8?B?MVJMNWIrTEdGNTZxTWhOR28rbGpKQ1lTbE1WbXBXWnlUV1IzU1BWRFUyakVZ?=
 =?utf-8?B?L2k0R3ZxSzBjKzNWenFSWUNOemVDQjlUdzBReUJBL2w1c0h4QnFLeFZyT3VU?=
 =?utf-8?B?YVFGSkxMT1B0SDBPTFZyb2tES1FIZm5OUkRvYXNjaDkzTGlxd0FzQWNlbFFv?=
 =?utf-8?B?WGlGcUFMQlhtK3NhMnFSTDhXc2haZ2RPcmJnSmx4R2ptcE1HSk5oanlYMm9u?=
 =?utf-8?B?RjQyL2c1T0pMZ3BOYnl4UWZxS2F0Z0hZMG92NEQrdHdOQ1k3a1FJT2ZTaEow?=
 =?utf-8?B?cVc3NXlDT0FjQnV4Snk0ZTdWUWswa2RyTng3RFNnamQxUlMyTFUvNmt5a0ds?=
 =?utf-8?B?S3RzUmZnWXhnMVBPRnhsNkVTUys4RW1tc3lBU0Judjg5Z0c4cFFMMWpnYVNw?=
 =?utf-8?B?QUlSV3p3OHpxNkd4SlVuN3hIVzdzdFFLdkFrMUVwcE5TeXRFcmxETE1yZ2Iv?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SPuPmj8h+h0L0ZkEAK1QgbLvCQPY53v6k/cBEsIOLca9goktXj/6V5J5g0K6XjLApvU9CoaA+JNpZGvqfr47/ntKPX+MVSXgd3prfZ7qhm6eW57Mg1VV9cZasNVKVv1pw5mDJC81IN5RbW44OCwlCLFJtZaMDQc3ii6YRYWCHR0KB9rZxKlnoHvdSqmc/ExUGhCJKeilc0qeWI4WDTcJa8p9x/x9ftelMHzgDCXfXqsTzYlJmOMIexSPaV7MXqK/qrNTS7CFPzERhseAc8fyQJQIcgyqM7c96d+GvGPj/AuDn78eLD6JoGb6wvJqJjzTpwpOApx4RrB+2NWcRpzNdZhOnyrSUlBImeoemBPN1RRUbBox0lacIfnykd2yjZoRa0loTVRvAP+CrJYrx5aiJIpfW0lwzWnlKsOzAXcr0/a4NIDxc23Je4aHnk4NSD0fZ5XCNGZmSSzuez3Ysd9gBS7PYuRC5RzDM9eXzRsZALtPoG9gDhE4QvrUQQO8kBGfzp82oVnsWWDlWFR0/LQku24KoEXgDxkMoYQbB671TKFvr9Nkxw/MrlI0kzp0kNiuE+mr2hXHKuLqZ1SAAA12m7/WBMUGfvqP9qgEqozQkAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4697ec-caa5-4a18-2781-08dc6a880516
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:12:41.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKyv/LsqK8ik1SlurbAC1hn2R+AzvH2t4BnULhh1ncQzSnYcQWGACQnAa6KiJga8iXzfk81xJGoEiYUWsHUYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020055
X-Proofpoint-GUID: _Urs7rg-u3vz-OgQSVRyYz7_cooE-weu
X-Proofpoint-ORIG-GUID: _Urs7rg-u3vz-OgQSVRyYz7_cooE-weu

On 02/05/2024 02:43, Dave Chinner wrote:
> On Wed, May 01, 2024 at 12:08:34PM +0100, John Garry wrote:
>> On 01/05/2024 02:47, Dave Chinner wrote:
>>> On Mon, Apr 29, 2024 at 05:47:42PM +0000, John Garry wrote:
>>>> Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.
>>>>
>>>> We rely on the FS to guarantee extent alignment, such that an atomic write
>>>> should never straddle two or more extents. The FS should also check for
>>>> validity of an atomic write length/alignment.
>>>>
>>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>> ---
> ...
>>>> +
>>>>    		bio->bi_private = dio;
>>>>    		bio->bi_end_io = iomap_dio_bio_end_io;
>>>> @@ -403,6 +407,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>>>    		}
>>>>    		n = bio->bi_iter.bi_size;
>>>> +		if (is_atomic && n != orig_count) {
>>>> +			/* This bio should have covered the complete length */
>>>> +			ret = -EINVAL;
>>>> +			bio_put(bio);
>>>> +			goto out;
>>>> +		}
>>>
>>> What happens now if we've done zeroing IO before this? I suspect we
>>> might expose stale data if the partial block zeroing converts the
>>> unwritten extent in full...
>>
>> We use iomap_dio.ref to ensure that __iomap_dio_rw() does not return until
>> any zeroing and actual sub-io block write completes. See iomap_dio_zero() ->
>> iomap_dio_submit_bio() -> atomic_inc(&dio->ref) callchain. I meant to add
>> such info to the commit message, as you questioned this previously.
> 
> Yes, I get that. But my point is that we may have only done -part-
> of a block unaligned IO.
> 
> This is effectively a failure from a bio_iov_iter_get_pages() call.
> What does the bio_iov_iter_get_pages() failure case do that this new
> failure case not do? Why does this case have different failure
> handling?
> 

So you are saying that if we fail here (that is the (is_atomic && n != 
orig_count) check), anything unwritten in the atomic write region and 
zerotail region could expose stale data, right?

If so, I would say that we need to zero the complete unwritten atomic 
write and zerotail regions - similar to the bio_iov_iter_get_pages() 
failure handling - and still report an -EINVAL error.

How does that sound?

Thanks,
John



