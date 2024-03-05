Return-Path: <linux-fsdevel+bounces-13631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5D87229E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57CC1F22D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BB11272CC;
	Tue,  5 Mar 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dreWo5P3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EXObYJgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4791272A2;
	Tue,  5 Mar 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652227; cv=fail; b=eYJI536pyVJuneB7HAHkQTgFj8BRcEMyy7wZ+/q0cSjkwT5Vlj/0Hk0vw6KSPKx8j7SWbhaatdm8xEfPeiuzAu/DVoEjuKFLfk9KsJerjeKoh129kqj0CTRG3OmXn6SwgWdDw/EaedCZW+4w1N1R8cp/T5ISJa74h31UulKvGNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652227; c=relaxed/simple;
	bh=85memOErp+IyWnYuJ+JCYoUDum1PAH/Cu5w2UNo6CWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TN3H3CYvNFjdUmb8yJUqm/4MNvRN6lMtrvvvEfZKrXT8WbL/MYoVtZ8In8Se55JN2CLvAflgy5sCChM35EjVQdc/1EMkkZBuveOG/s4Oebs32wzHAwPc3tHg/bautEws5QWcfNCnKPcrn7vFoIJtNuH6dOpAAvEFJdoSE2PNJ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dreWo5P3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EXObYJgk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425DafRK025143;
	Tue, 5 Mar 2024 15:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WDBC9lW4AFyKucv8Z9cUaCvzE9E5L041NTB0FIOsO0M=;
 b=dreWo5P3jBVQS5Jo25TTHdBC9hx3jQpC9SIVEgCSvi8WRHWBN9EMWBVHpD+70oNAf6+1
 MVqHPBen8NuwfxlIft1iwksQvyT2Fp1ofa5Fvx9dDZuVVcQKEZSWJKQPBsiM0YmuXYNj
 eByl0tkwahIHCfbvaYnE/WkPVqW0+WIZzF+oAv2rDnQXL/dMeX3akfI+S/XcAzc0xGDm
 TZC5jSxj4H/zuUmKJmFazWt9DNwPFNpMCS529ToYuytkTArfxr9Fm75U1apfMlFpV18N
 5UKGrSzbaJZcybjFVEYyAikgDrDxEYPKDEGQcO8ysWNXbo04x9oZXX7kzbNkAHblRgGH 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq26jsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 15:23:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425EVAQG016078;
	Tue, 5 Mar 2024 15:23:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj80huv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 15:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6oESMXF73hTPbSiSvuiT2eFpwgJhlU5buw7rMNkI90vT+FTVsxY3FZ8uPPb2oUuxxuMt9aniR1MVjDGk5z5afzPxqLiBE0aVkgeS0lL3n03gi+KbhI3aomPe5YoW+wFb43gjkexRs8PuRjj5C95AKaOF6IUJwGnr66TfKWpjNyrFfvLZ+gc3kOHFUoBCBi7IK31dqpms89ls8hgiXLvFM1uf1P/WW2Kt3KLsAzvov5Ca/j46dy52hLWWWFjij1TMGeWvjHO+2bz5tcTmM86Ft/ywRvzM7ref+lyLBXsyFW8F7ah/BzzW9cZKEkad1bFdLTKfCV68SydAdDFDDzNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDBC9lW4AFyKucv8Z9cUaCvzE9E5L041NTB0FIOsO0M=;
 b=JWb99m7GPox9GRNo8zYtLaNS3m+l3pFgTumHbjNwuRZaEtOpD3LwIYcg+N+aNjksGp4UxPDg7LLRB9BnfE9LdSUpJjP9sidp9Lsef7LHew91RM2gX+UWDKLZJAXwPnZ+L4SQA0w2MLpc5gQmAt6Cf/fG9dqYcINO6MiJd9Rv73HxYc9gXLJ2knuFyOE8PPP5pijR5hJ0i6+fakVCxeUthMk7A9DbfUupKPMJh0OAh3w2Mh58cZ9C9Utl503S2sZPVMNarrCo+og1XPJltbQ66tXISC8npJPwllqWWI1WD4pAN3Rlt6iLjS0KZAo9opynoS3hOO3Nv/ijpoy4hXufRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDBC9lW4AFyKucv8Z9cUaCvzE9E5L041NTB0FIOsO0M=;
 b=EXObYJgk4sJ5+piT1wE9bgEZNQQtiJ2AbhAQCZ8J26DYi0g5g7dCpjUWnwHVEryTm/aBuhyl39XWUIDvCDxc3w9xPM24zn4/PZ22Za3+UF4ocMDdkL5rZY4lpemYHjTSvTykyEelx7pD6rW8Si0aOutJQSzplsrDjZwaBEMXFrs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6159.namprd10.prod.outlook.com (2603:10b6:8:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 15:22:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:22:58 +0000
Message-ID: <f569d971-222a-4824-b5fe-2e0d8dc400cc@oracle.com>
Date: Tue, 5 Mar 2024 15:22:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] fs: xfs: Make file data allocations observe the
 'forcealign' flag
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-5-john.g.garry@oracle.com>
 <ZeZq0hRLeEV0PNd6@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeZq0hRLeEV0PNd6@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aab0da-fb54-4cdc-43df-08dc3d282340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cdvzQSsoZRXdyUcFmLPdlqycDEO9G/IdhBzyv/DlMSRImTpudT1bjV10LDBGvzsAfs2swJUsVNV6yxEw5loDMWQ9RQEEgIdhWXb9he2fke2jXBK6uNmpUN7ryNQbGaegsh3Dv5L3T5Fuu9zvagZe1Mg1N4R29wFSqa4Bo04f1bUl71U0Ii1Ih4KCG67Qu8c9r7fafw+/CyZ+0X43nZoQars6o7y+iQ67MTNEbfPXTJZaAyxU89liBFAm86/wlNpSvhPvb7gPxeQx5fRRS9CtZ3GNsu5Pzbs1YWvc9Xddy7k1BVoban+U0yAqxHAIVCdKubpiZAcbR4dc+A01OcywW9UGFHZ0yJWRD24+V+6+f9tt3yZNZUPtsM4c+X6xGryNfBmci22LxuzVH2slloENOLBvlBKQA+HeZJdl/M+2Lu4wOx8xO6p6frW/XMpUk3pF2Mpn7Eo+LIrrcGOr+Or/HSoTU8OGVxVMBmywiZpevIKEsmv78RiDu+JaEH2FGFUjmL9/UFub1DHKw9P5RWs0rNdcjznfM1j71MVH+Lwd2J+iOy9/rSSzAkbBb4yIPq2bGbv2+6beScGw5+850xFz/M7kBXVTt4k10LyVMmHEKjnYZHVvBFQfY2ZMHj8sUZcgqdVF2uSkKTX/dEjf4L5EC1uWKKOk3FzpOGkZmWFaHfU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnIwbG5pcmJGRCtmN0ZFbDIwb29wSDE5MjV3YXpiMEphY2w0WE52bDljWVVM?=
 =?utf-8?B?R1J1citrcE8xcnIxYTVrSFdUL1pxc3RLbVhMU2ozNGxTYUJOMnZrM1JMOEdY?=
 =?utf-8?B?Q1lscENTdHVwQUxaTmxJdko2MXJzMjBibU5EbHFPci9jYnZTQ3hmM3U2ODZn?=
 =?utf-8?B?cHFLVkNlOVZPZy8rcWRodDR3YS9EZVRhTEJhYS9UWDhXWHcxZC84MHRMSi9q?=
 =?utf-8?B?V3FjV3dhRXMxWGZicmhDMXhOOFQ0UCtqcjlqTXMvb1VjeVpmUjRUelJoenZC?=
 =?utf-8?B?YndyZVR3YWdadTBqMFU0eVd2YXRzVm90UXRnTUI5SHA1TkdGK2kzY05SajR2?=
 =?utf-8?B?ZlFIOW9XUVh4VjYwbHJtSCtkMW5VZDNYMFpFWk8rKzEvREIrbUQ5UDZOZHNu?=
 =?utf-8?B?ZUZNc0piaXhpNWFaRjJTQVFQMy84MVI0MURCbUJIZ3RGbWNIZ1V4L3dYY0Fh?=
 =?utf-8?B?UFpXR3NwckkyNjBIU0E4QnJQTmFEZFBlVTVXejYwd2FVbHNsMUdpampkYWVT?=
 =?utf-8?B?U3FFUTJ5SzZMNWQxM2RBdW1mU05RZ1h4dXYxaW5SdHJ1U2lwdXlQZ2VkOHdy?=
 =?utf-8?B?T21RVFVDLytLL24zdmZhUmxLc3JrN0M0UVRkdzBqa21hRnNJYTlRRmNIZW54?=
 =?utf-8?B?RDdRNk5scGRLanlZVmhKTjR0cXZIU0FZUmpWUDlZU3hSclFlb0g1NzJDdko2?=
 =?utf-8?B?dXlpVGpMRS9HTldVWGQwZjJ4RllGZEgwTjdIUFkzd1pIdGcyaWhXd2s0bGpN?=
 =?utf-8?B?b2VHMWJJc0dYUG5FWWNVUnZZc3VoMkRCWW44ZytjeTJyRzUxSjZDOHZuT1NK?=
 =?utf-8?B?YjdSaEVUV2gxQVB6SURacUN1UFJOcEpmR1NXc0lXMVU0TUxiSmUrbmV6Q0F1?=
 =?utf-8?B?VlJud3RmcS9pcjl3Qk1WOTBhL0xLeE91dFRrd0RRZjN6RWt1UUIzcjVHTmht?=
 =?utf-8?B?dkpFZkdDdlJIWjFUNktiSkFsb3dmNVNURVlmVEdjM3hpa1pwSkRqdHRGVkZD?=
 =?utf-8?B?OHBVN0YxMk9hQVFIV0YxbHRuZUJkT093THQyY1dkcVFWRFRBemtRd1d2WGU1?=
 =?utf-8?B?UVBRQ0ZXOElJdjQ0aFYwcExvUWlhT0svN1ZzcWdLd0sycUl6RmtXM2E5Q2R4?=
 =?utf-8?B?WkszdElWalNONU9CL2xSK1pRRGVkaS9aU2FCZThkQ3IrZGZWaTFxSHlmUE9l?=
 =?utf-8?B?MVBaUy9rbW9IalRDM21Xc2pLVTkxTWZNVUI4VkRPZnA0b2dvS1dnQmtxbnlE?=
 =?utf-8?B?OFV0ZTNFcTNSTy9ZVmtTSUlHWkEyZnFaNStxZnRQTnhrUDd5SEU4dTV2ZWlZ?=
 =?utf-8?B?eFFuWHNJWUJGQXJHK3JCaS90dGR0WHZRc3l6Y1FZSHk2Z29mUzFNMGExSmdh?=
 =?utf-8?B?RWJGRjVTeGU5Z2VHdDltV2pjRHFtMWt3SVpDYVFISkYyNDdBU2dFMmRmUlNT?=
 =?utf-8?B?UzhJMnV4QTliR1ZqY0xJT0VQOGdwMFNsTWZ3WnlEREs5ZE0rVnl0dkhLdWlH?=
 =?utf-8?B?bWljZ01QaTdVSVNIczZTZlJINlBZb0YzTThiTThRQWQzeTY4Yy9NSmMzYVYy?=
 =?utf-8?B?R1hSQnZsM3c2UDBnQ1RUWWdIM0tqNERDL2hOczY5dUNTZVV2L2ZQL2sraHEw?=
 =?utf-8?B?cG5Ba0xKTXU4SEZLZVYvclNVQjF6VU1JNHpXdHhQL1ZBTHNxV2JCb0F2YUlv?=
 =?utf-8?B?L0hhYk01Ui9MUDMxUk9qL0ZHQlBIOUIrN1FrZDZhcXI3VmtFbjFueFhZT0dm?=
 =?utf-8?B?dUdUb0greFdkNXV3U09TV0gxaFF4ZEdoR0JPaEh0RGtFZytYdkh6K3BlSjlj?=
 =?utf-8?B?L2hHNWJyRXlmTHpmNDFESWJlZi9vY0ZJdEpwUGZUZkxkcXg1NXlYQklueUFz?=
 =?utf-8?B?K3ZpalNXQ2kvTlZXb0RDNlc4M08rUnE0RnVza3dGcm5LcGpzNWl6QWNzK1Zi?=
 =?utf-8?B?NnJlKzVvY204YnZiRE1VRFBNTWNwaHdSL0c3OEhEOVNSYnhkZHJZbVI5OU43?=
 =?utf-8?B?ZHBBZmgxQ1dENktrWFgvSVZRVkpOdlYyT1BEU05WZTVGWUorVVJpN2JGaHY5?=
 =?utf-8?B?V3JQam9XZHhWaUhtTTFrQlE3OHcwbG9jYzR0NnZSQm9VVStJU2VxVERJd3pF?=
 =?utf-8?B?Y244L0tQTld5akhmM2t3dmczZU90RUEyazY4VkVEdXFEcEVtS3ZOeTVneXZJ?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LmX8zBCMESHep8kA3N9m64LgNqSOsVp7S0+qAxunitmKn3wyiNZ0bqc2RaXbY+Lib2kV9EYyS8I0127Fav3zr1rrVWDq+/xR68+J2CaY8HxJqh/dK3V5I8xJtGMng8/oezNMPNq/rCSJzWisKnMrQZbpF+ovwd7GbnuT+FrAqPctXyEnt/x7jyRvzKt1D1yy6hHnDLbKQYyrirnyDsUsMyYs9K6WZNKnkmBdgIPh5gJgLSMiDnKWiPZgD9CcJ+NtMIMyoBRSQ5Yhdi2KrOnn7SkAuV2advusC98gO/XqzQSo2kzA6MjW19+Y6doLEtVmuD2sViRQZ0mDQ/ZJYITHNHtmVOxw/UBRkm9KyEF+KKbItzg2IEvas4WDCNbW4JiiGONUNVIR0rRwy6fuDZ0YvwcZtxqsDjsMvWIAX91FY4aOs0k3cmM6/NDgdLoMNuR06w6/WNG5DQ2kyL7GWifBMWkpPYYIV1lNZXykn53tXYKYb1Lui3mRe3Yni1mVryfLgNR+Oh7ALrD4D8yFwlRJqBSKNyW+gXeAZ8OcplmckchooG5uqVWLUK0jdOl9LslaXuH7XyKXF+xluTb9EivP6KVkihfqXrAP4Bd6yV8gZio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aab0da-fb54-4cdc-43df-08dc3d282340
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:22:58.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5ZYnEbXUltlTOORd+J12v16+MiSaNjR4XOgynCwim3r8N2Zog10PPd8dS0ND/IzXJnsc98uPDM/CkLQ9QWsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050123
X-Proofpoint-GUID: E_HHXQbGS0txQA7NBXTC1-wWjY0IKglQ
X-Proofpoint-ORIG-GUID: E_HHXQbGS0txQA7NBXTC1-wWjY0IKglQ

On 05/03/2024 00:44, Dave Chinner wrote:
> On Mon, Mar 04, 2024 at 01:04:18PM +0000, John Garry wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> The existing extsize hint code already did the work of expanding file
>> range mapping requests so that the range is aligned to the hint value.
>> Now add the code we need to guarantee that the space allocations are
>> also always aligned.
>>
>> XXX: still need to check all this with reflink
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> Co-developed-by: John Garry <john.g.garry@oracle.com>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
>>   fs/xfs/xfs_iomap.c       |  4 +++-
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 60d100134280..8dee60795cf4 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3343,6 +3343,19 @@ xfs_bmap_compute_alignments(
>>   		align = xfs_get_cowextsz_hint(ap->ip);
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	/*
>> +	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
>> +	 * set as forcealign and cowextsz_hint are mutually exclusive
>> +	 */
>> +	if (xfs_inode_forcealign(ap->ip) && align) {
>> +		args->alignment = align;
>> +		if (stripe_align % align)
>> +			stripe_align = align;
> 
> This kinda does the right thing, but it strikes me as the wrong
> thing to be doing - it seems to conflates two different physical
> alignment properties in potentially bad ways, and we should never
> get this far into the allocator to discover these issues.
> 
> Stripe alignment is alignment to physical disks in a RAID array.
> Inode forced alignment is file offset alignment to specificly
> defined LBA address ranges.  The stripe unit/width is set at mkfs
> time, the inode extent size hint at runtime.
> 
> These can only work together in specific situations:
> 
> 	1. max sized RWF_ATOMIC IO must be the same or smaller size
> 	   than the stripe unit. Alternatively: stripe unit must be
> 	   an integer (power of 2?) multiple of max atomic IO size.

Sure, it would not make sense to have max sized RWF_ATOMIC IO > stripe 
alignment.

> 
> 	   IOWs, stripe unit vs atomic IO constraints must be
> 	   resolved in a compatible manner at mkfs time. If they
> 	   can't be resolved (e.g. non-power of 2 stripe unit) then
> 	   atomic IO cannot be done on the filesystem at all. Stripe
> 	   unit constraints always win over atomic IO.

We can could do that. Indeed, I thought our xfsprogs was doing that, but 
we have had a few versions now for forcealign ...

> 
> 	2. min sized RWF_ATOMIC IO must be an integer divider of
> 	   stripe unit so that small atomic IOs are always correctly
> 	   aligned to the stripe unit.

That's a given from atomic write rules and point 1.

> 
> 	3. Inode forced alignment constraints set at runtime (i.e.
> 	   extsize hints) must fit within the above stripe unit vs
> 	   min/max atomic IO requirements.
>  > 	   i.e. extent size hint will typically need to an integer
> 	   multiple of stripe unit size which will always be
> 	   compatible with stripe unit and atomic IO size and
> 	   alignments...

I think that any extsize hint for forcealign needs to comply with stripe 
unit, same as point 1.

> 
> IOWs, these are static geometry constraints and so should be checked
> and rejected at the point where alignments are specified (i.e.
> mkfs, mount and ioctls). Then the allocator can simply assume that
> forced inode alignments are always stripe alignment compatible and
> we don't need separate handling of two possibly incompatible
> alignments.

ok, makes sense.

Please note in case missed, I am mandating extsize hint for forcealign 
needs to be a power-of-2. It just makes life easier for all the 
sub-extent zero'ing later on.

Also we need to enforce that the AG count to be compliant with the 
extsize hint for forcealign; but since the extsize hint for forcealign 
needs to be compliant with stripe unit, above, and stripe unit would be 
compliant wth AG count (right?), then this would be a given.

> 
> Regardless, I think the code as it stands won't work correctly when
> a stripe unit is not set.
> 
> The correct functioning of this code appears to be dependent on
> stripe_align being set >= the extent size hint. If stripe align is
> not set, then what does (0 % align) return? If my checks are
> correct, this will return 0,

Correct

> and so the above code will end up with
> stripe_align = 0.
> 
> Now, consider that args->alignment is used to signal to the
> allocator what the -start alignment- of the allocation is supposed
> to be, whilst args->prod/args->mod are used to tell the allocator
> what the tail adjustment is supposed to be.
> 
> Stripe alignment wants start alignment, extent size hints want tail
> adjustment and force aligned allocation wants both start alignment
> and tail adjustment.

Right

> 
> However, the allocator overrides these depending on what it is
> doing. e.g. exact block EOF allocation turns off start alignment but
> has to ensure space is reserved for start alignment if it fails.
> This reserves space for stripe_align in args->minalignslop, but if
> force alignment has a start alignment requirement larger than stripe
> unit alignment, this code fails to reserve the necessary alignment
> slop for the force alignment code.
> 
> If we aren't doing exact block EOF allocation, then we do stripe
> unit alignment. Again, if this fails and the forced alignment is
> larger than stripe alignment, this code does not reserve space for
> the larger alignment in args->minalignslop, so it will also do the
> wrong when we fall back to an args->alignment > 1 allocation.
> 
> Failing to correctly account for minalignslop is known to cause
> accounting problems when the AG is very near empty, and the usual
> result of that is cancelling of a dirty allocation transaction and a
> forced shutdown. So this is something we need to get right.

For sure

> 
> More below....
> 
>> +	} else {
>> +		args->alignment = 1;
>> +	}
> 
> Just initialise the allocation args structure with a value of 1 like
> we already do?

It was being done in this way to have just a single place where the 
value is initialised. It can easily be kept as is.

> 
>> +
>>   	if (align) {
>>   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>>   					ap->eof, 0, ap->conv, &ap->offset,
>> @@ -3438,7 +3451,6 @@ xfs_bmap_exact_minlen_extent_alloc(
>>   	args.minlen = args.maxlen = ap->minlen;
>>   	args.total = ap->total;
>>   
>> -	args.alignment = 1;
>>   	args.minalignslop = 0;
> 
> This likely breaks the debug code. This isn't intended for testing
> atomic write capability, it's for exercising low space allocation
> algorithms with worst case fragmentation patterns. This is only
> called when error injection is turned on to trigger this path, so we
> shouldn't need to support forced IO alignment here.

ok, it can be left untouched.

> 
>>   
>>   	args.minleft = ap->minleft;
>> @@ -3484,6 +3496,7 @@ xfs_bmap_btalloc_at_eof(
>>   {
>>   	struct xfs_mount	*mp = args->mp;
>>   	struct xfs_perag	*caller_pag = args->pag;
>> +	int			orig_alignment = args->alignment;
>>   	int			error;
>>   
>>   	/*
>> @@ -3558,10 +3571,10 @@ xfs_bmap_btalloc_at_eof(
>>   
>>   	/*
>>   	 * Allocation failed, so turn return the allocation args to their
>> -	 * original non-aligned state so the caller can proceed on allocation
>> -	 * failure as if this function was never called.
>> +	 * original state so the caller can proceed on allocation failure as
>> +	 * if this function was never called.
>>   	 */
>> -	args->alignment = 1;
>> +	args->alignment = orig_alignment;
>>   	return 0;
>>   }
> 
> As I said above, we can't set an alignment of > 1 here if we haven't
> accounted for that alignment in args->minalignslop above. This leads
> to unexpected ENOSPC conditions and filesystem shutdowns.
> 
> I suspect what we need to do is get rid of the separate stripe_align
> variable altogether and always just set args->alignment to what we
> need the extent start alignment to be, regardless of whether it is
> from stripe alignment or forced alignment.

ok, it sounds a bit simpler at least

> 
> Then the code in xfs_bmap_btalloc_at_eof() doesn't need to know what
> 'stripe_align' is - the exact EOF block allocation can simply save
> and restore the args->alignment value and use it for minalignslop
> calculations for the initial exact block allocation.
> 
> Then, if xfs_bmap_btalloc_at_eof() fails and xfs_inode_forcealign()
> is true, we can abort allocation immediately, and not bother to fall
> back on further aligned/unaligned attempts that will also fail or do
> the wrong them.

ok

> 
> Similarly, if we aren't doing EOF allocation, having args->alignment
> set means it will do the right thing for the first allocation
> attempt. Again, if that fails, we can check if
> xfs_inode_forcealign() is true and fail the aligned allocation
> instead of running the low space algorithm. This now makes it clear
> that we're failing the allocation because of the forced alignment
> requirement, and now the low space allocation code can explicitly
> turn off start alignment as it isn't required...

are you saying that low-space allocator can set args->alignment = 1 to 
be explicit?

> 
> 
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 18c8f168b153..70fe873951f3 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -181,7 +181,9 @@ xfs_eof_alignment(
>>   		 * If mounted with the "-o swalloc" option the alignment is
>>   		 * increased from the strip unit size to the stripe width.
>>   		 */
>> -		if (mp->m_swidth && xfs_has_swalloc(mp))
>> +		if (xfs_inode_forcealign(ip))

I actually thought that I dropped this chunk as it was causing alignment 
issues. I need to check that again.

>> +			align = xfs_get_extsz_hint(ip);
>> +		else if (mp->m_swidth && xfs_has_swalloc(mp))
>>   			align = mp->m_swidth;
>>   		else if (mp->m_dalign)
>>   			align = mp->m_dalign;
> 
> This doesn't work for files with a current size of less than
> "align". The next line of code does:
> 
> 	if (align && XFS_ISIZE(ip) < XFS_FSB_TO_B(mp, align))
> 		align = 0;
> 
> IOWs, the first aligned write allocation will occur with a file size
> of zero, and that will result in this function returning 0. i.e.
> speculative post EOF delalloc doesn't turn on and align the EOF
> until writes up to offset == align have already been completed.

Maybe it was working as I have the change to keep EOF aligned for 
forcealign. I'll check that.

> 
> Essentially, this code wants to be:
> 
> 	if (xfs_inode_forcealign(ip))
> 		return xfs_get_extsz_hint(ip);
> 
> So that any write to the a force aligned inode will always trigger
> extent size hint EOF alignment.
> 

ok, sounds reasonable.

Thanks,
John


