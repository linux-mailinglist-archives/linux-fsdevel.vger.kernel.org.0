Return-Path: <linux-fsdevel+bounces-36136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CD9DC2F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE64281FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9A199EA3;
	Fri, 29 Nov 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Podrz/b5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WFF/y9ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CC132C38;
	Fri, 29 Nov 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880205; cv=fail; b=ntwWWKp+/2sTSlEoVTuyOBC0Yu2RlE/kqAPOoRSpn7RruYjDxyHopGzwnRnFjHgCPS/jyLJVcpEL8P5oCJT8TTxObPwpeg2boJEkyV6llDrPrnSDR2SsTCOTqNOxaXFbB8CfbQjMrgIjxPH7KrxDeEnHf8jc/Kh5IHPf5/AsX9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880205; c=relaxed/simple;
	bh=6GHVUydFVBjBVvq3YWnX1T7YU8Qwkoco39dP2cbvLUU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUP7aCgV+WZp2W+6B38mLIkxvq/utW9FkCV1LSabdAgbasLDMhJmgTf8TRK+/FuK5tSQhe6P0TvQgnUvdYF1+zvYsVZsBjZ9b430oTjvd7qKXjW/QVsjtrl7IVqQwnah0z5F4KrXjlnPcWw1sX52jjLPNSL3PjPoTOC7/s9z53M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Podrz/b5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WFF/y9ek; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fpWk022215;
	Fri, 29 Nov 2024 11:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q7I106FINMQGdVs+8qNDGgNaPyc44t75PY2XcRnwLos=; b=
	Podrz/b5z9NB0m/EAo/dpeC9RFTX8TDFCIBpjPZmNcGFztf6dMJYM6H8bg6i8abT
	ps4Fi/EMxDUq0yqNVaiRVzy32IworMEy5shM6Gg4H452WcAdfPXedDoXQTTJKH1h
	qsR7edxmc96xCG5xsBBaysVRrH7+sHvuhv52F6i8ybWskFxHZWfoPZGYkIROZpPZ
	t3XS5zFd1I0V8sU3Gdjr+7+WINeN9RD+85tGVSLr7o8gRHrLwE0TEdbbeIEZroYg
	XVR+lGyR6L+vCY4kj4gSP2o+ws8KFhiasLl+X2yqYYmuY8NzFJGTs4AaU8YI6LXs
	jye8xAkJ1DBXBN3/DIHntg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyb7hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:36:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT9Caj8027534;
	Fri, 29 Nov 2024 11:36:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43670530ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ34/6hSxFYe6VRn5r2Q5/ujsH5ldXlTiforGpZ5lDIEVvkvNS8wmrSe/meExqtRPnY+1/cTlXwOeOVokoZ8lAR9BqqObTLhVxUvfBZxV2qiNXfzKB/F4yPPHGPOsyHMEm4J35VNuhIxvwQBN+Js7BrqBnF8ddgOaDwh/aF5+/2PmyynG4tlB4RtWutvQ6UjhEowTu5qvlpIXOtL7yhpSm2GsQ0mQoWKrKypsA1EMDFyXgTS15DTo2ljp/6sb63s9EoH4i67w2yEooA5F4/KJOvXJFxto8GVJaHRM1gTZmRVlNMcoL8MWTN8EKqQJ0oenbPbCKgodajfdQjApIcmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7I106FINMQGdVs+8qNDGgNaPyc44t75PY2XcRnwLos=;
 b=XUrYAqlBRkeaU53b3tEGftrdsS/cbEX9USYFBuJxoiny2bIZN2txB4EUdD0GmU0aRDHIRRyduJqGbmZnr4VH0orIiKOUaTLOburFuGqsu5Lp1/ONFbi/++0xM+E1XHR+6a5vGwnZk3tImxaU19iUhwNAsgJVmz2I33nWRo1jKC1V0qpFlPbxSnH9xe4xXDeYbSsvTDjEUK+LW2Q5uHLPMWw9ZDb9MuoVpJFrmxb4qTTGmfHAyDGVnEkLYNEjXAnZoTS5RCfKO2FTi7Tqoc7frNwn6PG8MLGcIpAVhkJSJDJfdfZdlY44Diuw7Rbo0R4v1q7DmWmpl0MUP3OoaxYnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7I106FINMQGdVs+8qNDGgNaPyc44t75PY2XcRnwLos=;
 b=WFF/y9ek7GTXSOjR9RhSOQMhEjmp7NaLuGvSPz00rFSMtgVa3SEpiCjUtNEmTNe4lBiyyxPPKZQwhaDX3Dls/AL03CR2BaudmpNXczcffhzXYed2l5SaQBoA0OJjK/Maa02X6FllSmbxgZDB2DIO6/wqiZucyTUQyrGCgVO7KdE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 11:36:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:36:17 +0000
Message-ID: <333e6a95-b827-4938-9477-ad5ff5398cbe@oracle.com>
Date: Fri, 29 Nov 2024 11:36:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani
 <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <Zun+yci6CeiuNS2o@dread.disaster.area>
 <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
 <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de>
 <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
 <20240923120715.GA13585@lst.de>
 <c702379b-3f37-448d-ac28-ec1e248a6c65@oracle.com>
 <20240924061719.GA11211@lst.de>
 <a099f4fd-bde8-4a0c-b1d8-d302895374ff@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <a099f4fd-bde8-4a0c-b1d8-d302895374ff@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: ad477d6e-9434-43e0-41ff-08dd106a095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnVjZm1FU0c3RnVFMjdENVh6amNHMk53Q01uRjg2Zi8xK2FQcjRMb3F2TlZz?=
 =?utf-8?B?QlhvMlAyekxScmVEOFNZOXhtR1JmaXdzdFFSUFo3UXpwbmNPR01JYWJxR0Qw?=
 =?utf-8?B?eW1INGhMMkIySGpYWXJPSVZlVCtHSmw4Ym9maXJSaTZkaUxHYmhxYytyM3hL?=
 =?utf-8?B?Q2VKYzNFRVlrRkw1M0M3MGhacmxxRUJ1UFpGeTNuM3BQVW1LL0tmVjNrNmdo?=
 =?utf-8?B?bmhKSFhkWHpNY3ZlaC93b3lxTXg1RHU0dDNCWGlNVVNhWlJXbEVXMjR1UHhT?=
 =?utf-8?B?TEtlN0lTT25BTE5nWXZhbndReTNZalFQZ3RiaVM5V2ZDZk9CQTVib2t6cUJ6?=
 =?utf-8?B?WThwMElVNk1VRWwxVFBNQUJiamhDNjhBZHZpQVhtTHltKzF1ZUw4UHR3dUlp?=
 =?utf-8?B?OTlZeUtOQ043ejJnWC96cTQ1Yjk3Wm5rRGx6UHBhcWlCWDVEbEpkTEk0YStC?=
 =?utf-8?B?NWVRQlZ0UEFBUGI5MUtzRzZxdCtrL3U4U2VXdUtYNGNtVHZZUllGdzR6dDho?=
 =?utf-8?B?VUhwMzdEanBWMURqTUh5bXhOU3pDVUpJK3FGU3JpcWI1YkxMeXNTWW1FS2hW?=
 =?utf-8?B?N1JMYkhTOUFnVnJva0c1U3dnRXVSS3JEM3puOFJQUnc5VDM3Zzk2dlo5RjJi?=
 =?utf-8?B?cGVMaEN5TFIwTlFlcHJBMmdKZC8vdEttTEIvZjF6NjgrdTlXbkZhWjNkZ2NP?=
 =?utf-8?B?N2cwUlJsSGJGS1dYK2EvWDhsam5KT1ErUURqU1owVHdoa0VXWSt0L2g2RHZ0?=
 =?utf-8?B?bEdXMFZIN2pvRHhaUml1VHorSFM3VUpsVjBReHJFZUYxU2VyUC9zODFwcThh?=
 =?utf-8?B?Si8xK2ZtMnFoUGNrR3VNenczRGtXY3MvbTJQellTQ241dnB0TjY4YStKNXJD?=
 =?utf-8?B?RmtITzJQc3FudmpSU2ZoVjRId3lEMlZ1Mld5dGFrY21TZjdVQktpOEpSRlpu?=
 =?utf-8?B?ZnVPbDNqcGg1Skpyb0JXa2N3UjlEeDlXbTZWd1drZ1ozVmhNNnIyS0VZMkdU?=
 =?utf-8?B?WlEvL0dSeHlqSk9NWThxZHJ2ZmVJcVdsclluSUJUb3dtaDFWT3BQaDZkQXNw?=
 =?utf-8?B?ZlpURDFjWURlMWtGNHNvdDhPWnlIZVFkdG16NjYzMWpYS01yM3BrVFRKVzJw?=
 =?utf-8?B?TGJRZmpuaHBvYkdkY3BFdUV2eVlaU2J6d1RCZzUrUVpLU0djZFM2TmlSdUla?=
 =?utf-8?B?amF1eDJLa3UrV1piU3cyRjhSZ0pnVE5JYmFXT2ZHSjArM0VJRm1qSjQ3ME5a?=
 =?utf-8?B?bFBMcmtqYUtUU3I0cUtVZkFqRFUxd2JPbWh5Y29aak8xVFBuVTFybXAvM29q?=
 =?utf-8?B?T25LbTdzL1dDUXZWeHpJRFFUOWtVWk5FUW5QcGZxRG9YcFF2UUdpbFRXc0lt?=
 =?utf-8?B?dnVQN3lEekY5NVNCVVI3b0VUMkE5R2dMajBzdkdjMWw2YkR0NldYd1poeVk1?=
 =?utf-8?B?YzBEZTdyOXE2SVQwSUZwaEtrdGVZTWoyZ3pHK1JjSXpDOThhSSt1VS9tK0ZL?=
 =?utf-8?B?Um5SeE1rN1NzZTZKYk81VEtKT3l4cWxDRnFrbFY5NVZmSURkVnV0QVNHNXdx?=
 =?utf-8?B?eDNmdHNrNzBrVUJXbUVJcFh5N0lzYXNEbTR4eWdWZ1V3QjBKWGRCYjlEdXdC?=
 =?utf-8?B?U1dkUjhQUkw5a2RLRWdKSEwvQk5sbThoNUNXSnJZc2JWZkNnQ1pOdTdvTzVS?=
 =?utf-8?B?RlFheUhiayt4dU5TUC93cFVoRTVha2hybThjTnlQWTVZenNUUVZNZXBiRUtN?=
 =?utf-8?B?K1RITXMwU0Y3U1Z4cG1rWUJvSVQ3SUEyZmtVZEdkRmtyZjc5UGVtRmNwVk9V?=
 =?utf-8?Q?2RwUXOVONNXbuhCa0igH1zgBlVmzPngmBr0Dc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5SUGxhZmZyV2s3anFmTUJlbDJOU3M2Z0ZxNXBMNlZTb0owNWZSWS96eE1K?=
 =?utf-8?B?UFc3OTdwN3FrSkFJMmZKbDQ5K2doU25sRldDSlFWLzNacXRlOERIc3RnQXBK?=
 =?utf-8?B?dkw2b201NUtpbm1wNlBBWjRjUXl4d0hTMEhNZzMwK0tad1BZTTJadWNpS1NG?=
 =?utf-8?B?RWNvb2RBa09ZVU5PcVF1WlVSdlY5OHNJRUd5a21VUXFadHcxR2p4WXRiMXpY?=
 =?utf-8?B?cGZTQ0d2cTZDcWYyT0thMmx5Vm5iTFcwUUtITGJ4Nm95emo3SnJCL0V0U3Jl?=
 =?utf-8?B?WFgxZkZraXVjd3JFRmtmdkN2dEZOb0xlTnpPZ0hKL05aWlBIenMxVFA2RHpp?=
 =?utf-8?B?OGtBNnJ6NEt1MlBCL0JYeHBscW5sOVdiWEsrdW42M01uYXpRTjV1S0c2cnA3?=
 =?utf-8?B?MzFVSXpOVlpXdklDU3pUeHB4QTVLR3NaSjJadFhybHZLb0xOUDhNSDZtNHRu?=
 =?utf-8?B?WVVtVDZUVHcwMmZVb0N5WDMwVWE4MThDVmFIMkkyS2hQZDJzR1hOWXArWjZJ?=
 =?utf-8?B?NTl1NUhIWE5oSXM4L1NPQktVajYwZnJzWE9lcytvY01yMTU3V2JhT1pmRXY0?=
 =?utf-8?B?MUJnQU4wUXYwRVRYL2pqUEZOU012ZS83a1BkaWJuN3B0bmMrclZYSXdqaHBx?=
 =?utf-8?B?eGNIL2pxZ1RGblZvYWpMQVBlcmFTd0pDVkZWNEVheWlENm1VaSt5Nng4N0lU?=
 =?utf-8?B?dGlQMTFIRDVzWldFUFRFVmhGMXlZL2F0ZkRjY0hDVDljZGhoMDQ3dUptOHFM?=
 =?utf-8?B?WjUvNi9lYjZ4a09Fc041dlM3RGRlUkh3c1U0VHVFYWNMNmV5OUNDSUF2NUxW?=
 =?utf-8?B?dVhhUSttMHV2WlhWTzBwdjQ5eEV5VmJ1TXpKbTlVaFlORTNsVHk0S29ZdWx1?=
 =?utf-8?B?ZkZpQy9kK2t2Q2FFWXcwTDlZMVNTa0J0MDJVY0M5UnAxSm5sdEdqZWY3eWpG?=
 =?utf-8?B?dVhrUHN6YkkzeG5LNld3RE1IOHlraUtpSWpUQnVGVW1JOG9LaEJnZEpEc3Z4?=
 =?utf-8?B?NjJ0SGptbEJsenlsOUtGa3daVmQ3bm50Z1dzQk1hamlwazNHOG1MNkdDdnZD?=
 =?utf-8?B?YVZRUHVYMlJqNTlLdVY3RGNWWkh2MkdYZnFjZjIza3ZyZmJCSHlHSTB0RXFU?=
 =?utf-8?B?alVyVVV5SWp1SUVzbjUyaWxBa3FQOURLZjlpakJ3UjY0RXVJRFEvdk9rTzF3?=
 =?utf-8?B?NjFPdjkwS3BSaTRyYmVCWHdiV1hUMTZHUHVGU29iYUZpMUM4V0c2enJMeUF0?=
 =?utf-8?B?R2IyU0kyMENWSnpWTjA3dlc1U2xCbnlnQW9Ub2RPcCtjQThxZnFWUnFITk9j?=
 =?utf-8?B?K21JWWxrd2RWT3Zwbk1vS0xDaWFja1I0NTI4V2FPWGJQN1o0b2xqa0gzaytk?=
 =?utf-8?B?KzBYb1RhVGxESFNUU1hZMWJTcXVFOGlJWFBYZVo1SCtZalU0UVVQMVNybGd5?=
 =?utf-8?B?RjdoRWJsYlZQR3JuaEppTjhTWm1HOGpSL0JVdEg5ZDRMZGFoOHMvQWVjU2dV?=
 =?utf-8?B?Q0cvRkRCMnc1cVdNNGhlVFNyUmZoSjdPZDI1MENIMHdDc1NzS2RIQ2VYY29O?=
 =?utf-8?B?RUhQRHVCZ3dzejRCeCtaVXh2ZXdpcUVMbVF3Zk0zRkhkeEp5NU11Y0k0Y20x?=
 =?utf-8?B?V0sxQ2dHMVl6ckd0Mm9QS09sWTRNeFRzSmNnTTd2M3VjWEY1eTBEa0ZhN0JT?=
 =?utf-8?B?MlFXNVB0VlcwaC85Ym53Wkd0c0F2TktxK0NsTGNSb1dtWUJ2SmhsU09uU1N1?=
 =?utf-8?B?TlBHQ3BZK0FNSHJ6bkFheVFSdWdXWXRYOTBLVEl2U0Z3UHpKVE0vYlhuSVJj?=
 =?utf-8?B?ZWZBVFhibnlOcTZRcCsrV2xEcWl6U2NsWFYvRXZKZFRRUlVRZ3cxUFhGdFpD?=
 =?utf-8?B?RENtb0Q1S01DeWd5SnQ0VlhoRmxhbmJvK3N0Y2tiN1FGemVINmxkMThqYmhi?=
 =?utf-8?B?MzczajhNQ01TMFc5eXYwRUU5Vmp4dEo0S0J0ZlpCQk83TFAwRExqQ2J6TXVZ?=
 =?utf-8?B?Ritwc21qQi9QYWU2YmRjcUIzVmk5SWs5YmViaEVlOTV2d2xmQXJtMlpjdXJ5?=
 =?utf-8?B?YVVsdWZiQWRwVVVLellHSEtGckZWbXYzVDVmUzg1dzg3am1rQTk0WC9Ea1Mx?=
 =?utf-8?B?NWFndGNBVTRmVFZ6QlpvbVVBdVFwWlF6eXpGb1RndU15c2JFTzAzSThvZzFm?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TWJG0ZywOO0yHKLEVuHDQ15tqRPgCQHdcKPQ7x8rXZqD+pR46BuRJ26bR/l9UY65V5goXnE5p/Bx2oSLkhWpikzz388xoPKJrslVR3pYkg/9gGWaiLu+R3sNemD2k0Gn3XqkJTPPK42VQU1P358mU28yO76SBDX8WhAjtvLtlEG8Fa/WTYg/9GnlxR/FsEpwpuQevC6ukPcOnZX0HeO8uiaJaDc0dtYwhfGWnocztMY1Og/wQPBPCGP1yCYXjWD/RdDEffKuNgQ6x/+F7ILxUYDcPopghmxOanq8nJ+NxXk5lzFiN4eB8VH5yXAU3glOHRMoJny/y5cyZLfGHJbeYzk2g6bgtiw7DrdSpCNP6+M2i7zSls20LSCNcTTdBdxwnuTLEvU/cT+GGEsk9JhEJ0J1Uo0pUnBLhYv0fFlhZ+DYb+gg4Y0tVGVtuIoHkGom/dGbVh3jMUSl1e8zDeYaQWZ16Zz4PIl/8PhdmxZKS7ZsWtm7tOSeDsZyqZa7BY6kljoppAjUrhjWJD4dHCKETjogPu2epmSQyavRgA+yZZt6vDkbDPrfiEQLJWIl7Uvl9ZJ7JHyVjf7XkeyotQlDVkDW4h4Eo5SIj90PPFzAShI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad477d6e-9434-43e0-41ff-08dd106a095b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:36:16.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4GQA8ssgXaW6voeD/Vm8H0o272BF5V4dVj14aXDni+Wr6cgj569snZs/g1bbi3gFCamc9R+0KFIpkJMZ/kikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_10,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290095
X-Proofpoint-ORIG-GUID: qPl5YISYR4niTB-n-AuJAgUwqrJi6M2q
X-Proofpoint-GUID: qPl5YISYR4niTB-n-AuJAgUwqrJi6M2q

On 24/09/2024 10:48, John Garry wrote:
>>
>>>
>>>> but more importantly not introducing
>>>> additional complexities by requiring to be able to write over the
>>>> written/unwritten boundaries created by either rtextentsize > 1 or
>>>> the forcealign stuff if you actually want atomic writes.
>>>
>>> The very original solution required a single mapping and in written 
>>> state
>>> for atomic writes. Reverting to that would save a lot of hassle in the
>>> kernel. It just means that the user needs to manually pre-zero.
>>
>> What atomic I/O sizes do your users require?  Would they fit into
>> a large sector size now supported by XFS (i.e. 32k for now).
>>
> 
> It could be used, but then we have 16KB filesystem block size, which 
> some just may not want. And we just don't want 16KB sector size, but I 
> don't think that we require that if we use RWF_ATOMIC.

Hi Christoph,

I want to come back to this topic of forcealign.

We have been doing much MySQL workload testing with following 
configurations:
a. 4k FS blocksize and RT 16K rextsize
b. 4k FS blocksize and forcealign 16K extsize
c. 16K FS blocksize

a. and b. show comparable performance, with b. slightly better overall. 
Generally c. shows significantly slower performance at lower thread 
count/lower load testing. We put that down to MySQL REDO log write 
amplification from larger FS blocksize. At higher loads, performance is 
comparable.

So we tried:
d. 4K FS blocksize for REDO log on 1x partition and 16K FS blocksize for 
DB pagesize atomic writes on 1x partition

For d., performance was good and comparable to a. and b., if not overall 
a bit better.

Unfortunately d. does not allow us to do a single FS snapshot, so not of 
much value for production.

I was talking to Martin on this log write topic, and he considers that 
there are many other scenarios where a larger FS blocksize can affect 
log writes latency, so quite undesirable (to have a large FS blocksize).

So we would still like to try for forcealign.

However, enabling large atomic writes for rtvol is quite simple and 
there would be overlap with enabling large atomic writes for forcealign 
- see 
https://github.com/johnpgarry/linux/commits/atomic-write-large-atomics-pre-v6.13/ 
- so I am thinking of trying for that first.

Let me know what you think.

Thanks,
John

