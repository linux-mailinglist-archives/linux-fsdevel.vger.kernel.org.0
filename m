Return-Path: <linux-fsdevel+bounces-36069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF489DB673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304A8163F21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF86197A92;
	Thu, 28 Nov 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TJ6hZO7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EF156641;
	Thu, 28 Nov 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793047; cv=fail; b=MYzs9AvhaHf43TnMxkGaQ/LDBW1jqXw0mdp16uY14R+c0wwQHBQLBHp3k4wIQSQbMMqXoBP5AyuavuvE2qau2GGeHwOchgHBrSExC7OFsbxLagQ+74LO4+zMlpirt/YU9NdpzToRcSZovOzXEV4JGPOEZTC9HZXbdeAWRuTN6XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793047; c=relaxed/simple;
	bh=6gT/sUd9ca3n9EtjpHnQxMp0X56JOobbwo2NZee2amk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HbP9VnhRYSC5rb/9hTSyDO9ouw5wcqiKOmF5sU7mnfXkQjDC6Qq3gro11b9VETciEOmRv0uGfKZmNdxmWUvLR+0Z9zC10TF2VCFGtZIieV/MAZmnHmuf+EKeHgDLlWQiSUh3F88oJ8r4pu+V3Egq4ubb7voolEOLXe9Dg4oyUe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TJ6hZO7O; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaJgHDnTIoR2IsrSXLE2QtVnAvO6LMIQfiTrCPg2vjSQfVX+Q+rDpx2KpBp7JC6UlHpMRmyo/3VyDx0YLZ7yF0bqG8k4w+vmTlkOCQQI4KhFBp4AhB9TfCZaU0h00ORkNaKyDSqeAi+COwoY7izZGbOyQ9MsZgevouR/pbToF7+6KL56iXzjI4+dbaYZpYgta8hrTMnsg8dncQQ0HyQp1N4e2FvJ6/IkBCuPyDAJzQHzOx/7yzJZ9ot3oUaSWsowUDClvvuAuDIZpwCZpmAyJduNZcKSb+Oy6GyVqmJmU6vCrw8w23Qre2NnC9b2O0+OCmFxdT9Otb1BRKavteYspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ0y/552WqL2yH42ivWmOYAAxJLOeKsH9WlwXOu8NPA=;
 b=MT+fdDXcKch2dD8goJQCAvfx3QwEeM3WjCjnDNzYGY23dy1Uho8QBWSCf8cxvNTEiGiFEd26B0jDl/jUl84qQU3Rvm88BmX9IBTQe4g+9LTnZS0VfINbpIDi6KMfnIaKrVnAmiIiHy2sJ/OMiCag5JsRZUjDVxz273j2mlAdOTWjv8AczeTPlN8q/be+L0BeKIH/yDbs9ZkG2sZhN1deuLluB3rD3Q27Pq8g8K3ZCT2lXkrgbqTXTcNFBYynavbYysjr1MNnEOHOCW0YBPaQsGjvnCtN07CKGqk2Nimqdq1Jel8+NQgnP1C8EZTL9XdnepNfUHsR7Pa8eRdZkJtpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ0y/552WqL2yH42ivWmOYAAxJLOeKsH9WlwXOu8NPA=;
 b=TJ6hZO7O8+ITg+Q0vq1mDU7x2CZPVgehU/lIbArzkyvrTYrkklvilkkr8qr47vWJh6HCeBIkDLiQ4Rst9tpXsbyEabBxN/F8GGOgtBMS2PM2U05I3h1IzraPy3pfMpKYeCrutfRjUTlFOn+E9sLhbRg3Tl3ehdyM5qRLlmto/CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 11:24:03 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8182.018; Thu, 28 Nov 2024
 11:24:03 +0000
Message-ID: <fb026d85-7f2e-4ab5-a7e1-48bf071260cf@amd.com>
Date: Thu, 28 Nov 2024 16:53:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
From: Bharata B Rao <bharata@amd.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
 <Z0fwCFCKD6lZVGg7@casper.infradead.org>
 <e59466b1-c3b7-495f-b10d-77438c2f07d8@amd.com>
Content-Language: en-US
In-Reply-To: <e59466b1-c3b7-495f-b10d-77438c2f07d8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e68314-479c-463c-48bc-08dd0f9f2989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVpby9wSktXVXYzVW51M2ZaNU1NUDNDMks1UUNjU2dhQ1BHNElqSWt1L1Mv?=
 =?utf-8?B?b0owL2p5UHBZOEovelV6ODdwZmdwREkwTHVsOFREdXB6SjRDY2pXdy9wY3Jk?=
 =?utf-8?B?T2tTYmN5THhraG9nNGh5d043aktjVlRMWHd1RmNnQ0c1M2ZWbCtUNzdsczUr?=
 =?utf-8?B?Sm1nZTk2L2d2bEdwK3FNZ0I3M2ZkVW56d042Tll3Tmp2NTNIMDNiVDBOR3JF?=
 =?utf-8?B?b2FFQmd5ak5nK0JpcUVDcTdHU2wwOXgzdFpiY0lIVzN2TzA5MStUQnYwNlpW?=
 =?utf-8?B?YWM2cDh3bG5QbE1tSU9ZNUN3ZE1lQTNVRHBneVcrbzRma2oxUnZQdWhFYXlu?=
 =?utf-8?B?MVZmNzF0L1lFU3V2SjRRWnlaak5oMTFRTlVwYUJKb1d0VDJoMFVEUjJVdDNx?=
 =?utf-8?B?MEpackp1Z1praE1YZ1Z6cjhFYXZ1bGVFS0F4czBlYXlVUTk2cFJCODM5WUpr?=
 =?utf-8?B?L1h4UjB0ZjRvN2JkY0l0R01GT1FpbFQralU1VTkvL2FUT3ZRUzZyUTZDS2ZH?=
 =?utf-8?B?c1ByQ0x3eEN1WlJKU2VVVGduMGE1ZkpyV2k3ZjdMZVl1cm8ydjJhNnZaaEp2?=
 =?utf-8?B?ZlZMM3ZoQlNnZE5aTXIyZ3REMnQydkttK1BBa0NROWE4eTRjZ3l1M3NMY0dH?=
 =?utf-8?B?ODJ4Y1doSXJKUng5NEdaeTNsdWQ1TnQxVStCOGZkSVVEY0R6T3NITnhDOW5v?=
 =?utf-8?B?YW55Y21BdXFCTmRCWlkwVFR5ZDhlUGc0K0RXeGhzbk1EWEwvY1Z0aWFzblli?=
 =?utf-8?B?Z1cyeTJEM2hLcEhSdTZVKzE2U0FMRVUyUUZuZmczL0Z0c1E0VlVSV0NuanZq?=
 =?utf-8?B?ZW9RM0s5dlljQ2JWb3p4eGlUWXlXdG9sMFZRUXVFSDUvNVd5UGh6Z3YvakVo?=
 =?utf-8?B?UmhmNERQSVcwUXlnWVdmSy92dW9nTW9EWlZlcy9JQTlNRW8vU1hyN3Vib1hq?=
 =?utf-8?B?U0FQbGkwaThTNFNLMXNzam5EbkErY0FEYXNoSGNUR0hybzhjYjUwODduTXdP?=
 =?utf-8?B?ZGNuQmRrbFUrd3NoZXNwQXRlckRsQXpNeWY5ajMyektDS2x6Wml5cXpGQTBi?=
 =?utf-8?B?Q1VmYXBMaGRuUnF4UXZidDAzVmNvYlNEbXEwZVpNL3BnTU5HT2FIL3V6Tzkr?=
 =?utf-8?B?MTdVSU5rSUNiRXFWc1dzVktINC9sajIwWlA1TXJ1eCt5bUpkTjh2NGd1Skh5?=
 =?utf-8?B?czJhcWREMzc5MlNhRExKTHBNRW5EUndjeGo3QThuY0kwN1BGTkE4Sk1XZm1K?=
 =?utf-8?B?bkVHckp0NnVpeS94ODZDK1Y1YXJHNGszcWJ6NTNxZm45dHIzTnU1R1NpZVFJ?=
 =?utf-8?B?YnVOcjN6cXFIMmFOTEZSeEh6cjVRVjd4Yjg2Mk8wVzBYWXFlalpBcXA2c25x?=
 =?utf-8?B?NDZjWmNRK2hzUDU5QVd0TzY3OW9LTzBIVEhsK0hMTXAwdHhEbzdLNm9iK1ov?=
 =?utf-8?B?ajY0YlpDR2NZRCs0dm1KeUdaREErM2VrbVRGNnVTci9iWXJkZlFmQ1Rzei95?=
 =?utf-8?B?TzIyaGFRbVQyVnhuM1hoNlBBSjh6S2hNMEIvSk5VSDJ1bVM0Y2hYZGxVM29I?=
 =?utf-8?B?TWs4RGMzRVpOcUs3TXVJQXZqdGt4dVAydjNpMFB4cWlMaGt6MVpGL1RPNEVt?=
 =?utf-8?B?RWFJN1BVOEpXZFZYak1objVBUE9YSWRnazhZdlpSbVJVSXJ1MHlvZWdDWVJo?=
 =?utf-8?B?UjU3SWpMeDJyUHBKY29SUjVJSjlwckxQY1RJWGtuVm0zazhQRTlvRE5hK1ZJ?=
 =?utf-8?B?WURYaXR6bTlGY3Exbkd6ZjdpMlZ5UTd1eUxHT3YzYkd2b1J5ejJVQWV1R3JG?=
 =?utf-8?B?K2t1UDJUYnF0U0k2N1E5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFhOTNpazRoQWdyVlZPcEt1bHNaa2RFMzRla0lxdyswRWx6SUpPQm5WZU5o?=
 =?utf-8?B?S0hmMVFlVjlqMjl5d0M4UXppUlFDRjZYQ0FOTklmeVNFN3RBRnBvTTZCbUhO?=
 =?utf-8?B?eGR3Q09POFYyZ0ZGMnR5c2hvV1pZVjJyR3g5WDkrSk9JdTE1YWo1aHowS2gv?=
 =?utf-8?B?T3dkKzE1a0FmRzVFeFM5Sjl3bjlyOVl1TFNZSDdEb096VFRTOFJOZ1BMYTYw?=
 =?utf-8?B?U3E5UUwrWW5KS0QrMnQzaHdJKzAyTGZ5SFo4Y1ZZcFlEOVQ1bmF0aWhzZDVM?=
 =?utf-8?B?cWZ1UitCZElHYjlaQm9KWC90ZE03NzBKMndLTlZ3aThUV2hRYnRHN25KUDdz?=
 =?utf-8?B?Q3paeXVTNm5GQTRrOU9BMGlaUDFkWnhsWlQxNERvMU9TNUwyZnY2UmdqMDZO?=
 =?utf-8?B?emJwRzhJcTRGNDRqZmdVSTVvdkxaT2p6c1ROeDBqM3NIVmV1aHQ4YVJUNE1C?=
 =?utf-8?B?MThSU25aVlZHY25GL3h6UjR5WFJBZEhHeFcvZjN5VGcycFVHV3N4a3JYd1cr?=
 =?utf-8?B?MlZsVXZGVTFVUTl6OGlub043RGRsRUZnZWdTWENhb0JRbGdwUnZJYVhrc1hS?=
 =?utf-8?B?UG9kWGhya3VSem1iU0M5ZmhUbXpVZ0tPK29WZmp5cThSejBvZzY3S1dmUTkv?=
 =?utf-8?B?dVYrNEpsSU5Ocjd3c3pTQkVDS0h1cFhmS2dtNmdGUlpZbUNGOE4xUncwYk42?=
 =?utf-8?B?bGVET3NRUkttWnJnODZZTmlxUE9WUDEyWkEySVcybmtTelM0Z3NkVXJ5ZGJ4?=
 =?utf-8?B?c0pVenltNU5JSjIzazFVa24zT3BhT1VMdCs5UWxFd0FZa2tUM1p6RG5OaHBl?=
 =?utf-8?B?cGxxN2ZnV3pSQklMNkRmb3pmNmJsd3E2eUExUDZKWmw3Q0xrRkUvSE5qTW5C?=
 =?utf-8?B?bk5MMWtjNi94cXJHM2o3M0FQaG5RQXQyaElHbkVZbXZqTndkWFNrRWtmRC9M?=
 =?utf-8?B?dUw1MlZLNHNnbWxDUjdMTGhyYkJ0QytycGpKaDYyRkswZi9YckJMRkpZc1px?=
 =?utf-8?B?Uk1DVmtlS0pMaTFJY2lSU080dnNVNjR0WW5jUURiYTQ1Z1NaTGFLUTJjdXI4?=
 =?utf-8?B?dWR1WmlpbnhuWjVpUmJ5ZUYxVlhFM1FtUC9ua3AxMXNEbDV6OXdFMCsxLzF5?=
 =?utf-8?B?RDl4VmZJbVdXbDdEc1hNSTVuSHkya1JTbC9YTktWUVlzcitLZXpFeCszZ1lP?=
 =?utf-8?B?RVZVRVNFZk50b3BrQzJyV1BLcllWdHZQY1VOWDRwKzFmd3dBUkcwbkRab1BD?=
 =?utf-8?B?MGhuTWVPL0hvL3YxaU1Pa0NWYmNqSXFYYnRldGNRakpMUTlYemtWS0JpYjFw?=
 =?utf-8?B?bzdGa1NQR1B3WEVRL0l3b3krMDIzajVsQkNlY1BMVmNtTnUvamhOREJtVDBi?=
 =?utf-8?B?WURwb040MVlNUUlnZHRNdE5MUUNPT1hqbi9rMjhuY1R5Q0E1YTlqa3hrdnRD?=
 =?utf-8?B?VGZJdVR5OVZMZkV5MU9qektidEs3aDljQlRhUCs5TUdobHFJRkIvTzZJRlRG?=
 =?utf-8?B?bVFyZlV0Q2RvTzV0S2dmOG9RaTBzV2pHZXQ4YnhyeHpMTy9MeWxBallEaXZR?=
 =?utf-8?B?em1iYzRuRVRCby91dWx0WFNQL2JKcWFUYkpoMUkzd3JZSkJvY0RvdUFSV3Q1?=
 =?utf-8?B?SG93ODhkYmhvUVN2WkJHMnN3YURua1RtcFludU9YUXZCZVA5cTljT2VDRzlG?=
 =?utf-8?B?SkpUTWlFRXovQ3JWdjFibUs0ZGxad0xPc3FVWFJTM0RGQUI3RHg3d1E4WDND?=
 =?utf-8?B?bzQzaTd1d1U1Y3NReHpsU0JOejZ1VzBva2pQMGx4WGdNOC9lMWdCS3BiL3pX?=
 =?utf-8?B?K3J2YUpyNGtrSEZXakpLWVk4a1RzMXVONlRRc1diSlRaRjA1ZElrU1BJbFk1?=
 =?utf-8?B?T2pYQllnckFvaWhDdS9kUUpRUEhGNlZ0VXVnb1oxTVdlQWxTZVZJdHV1Z0NF?=
 =?utf-8?B?a3lGNjIxWmZCOW1vSmJPYUpxQit2Q3ZtUlJramJKY0I0NVZ5ZU8ySnBKWWNv?=
 =?utf-8?B?V3hmMWp1UmE0ZURNSndtTTZQNEx2L3ltSDViMUJkdm1WdXlsR1hjWTI1K2d5?=
 =?utf-8?B?QUNSa25FMjI4UVJqeGVjcUltM09qVzRxV0U2K09zTnRBRGpoRG54T2FBR1BV?=
 =?utf-8?Q?BPlu3J7OV6cVG9NnQHxX296iA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e68314-479c-463c-48bc-08dd0f9f2989
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:24:03.0944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ak4D4SyvigsX5yRhOdL8vAKvxSzopnfOAdsckPK8Tkp6/HomFIbw9zHkRKeHT1mgHzqL+gxlS4SSV2jHP7WPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

On 28-Nov-24 10:07 AM, Bharata B Rao wrote:
> On 28-Nov-24 9:52 AM, Matthew Wilcox wrote:
>> On Thu, Nov 28, 2024 at 09:31:50AM +0530, Bharata B Rao wrote:
>>> However a point of concern is that FIO bandwidth comes down drastically
>>> after the change.
>>>
>>>         default                inode_lock-fix
>>> rw=30%
>>> Instance 1    r=55.7GiB/s,w=23.9GiB/s        r=9616MiB/s,w=4121MiB/s
>>> Instance 2    r=38.5GiB/s,w=16.5GiB/s        r=8482MiB/s,w=3635MiB/s
>>> Instance 3    r=37.5GiB/s,w=16.1GiB/s        r=8609MiB/s,w=3690MiB/s
>>> Instance 4    r=37.4GiB/s,w=16.0GiB/s        r=8486MiB/s,w=3637MiB/s
>>
>> Something this dramatic usually only happens when you enable a debugging
>> option.  Can you recheck that you're running both A and B with the same
>> debugging options both compiled in, and enabled?
> 
> It is the same kernel tree with and w/o Mateusz's inode_lock changes to 
> block/fops.c. I see the config remains same for both the builds.
> 
> Let me get a run for both base and patched case w/o running perf lock 
> contention to check if that makes a difference.

Without perf lock contention

                 default                         inode_lock-fix
rw=30%
Instance 1      r=54.6GiB/s,w=23.4GiB/s         r=11.4GiB/s,w=4992MiB/s
Instance 2      r=52.7GiB/s,w=22.6GiB/s         r=11.4GiB/s,w=4981MiB/s
Instance 3      r=53.3GiB/s,w=22.8GiB/s         r=12.7GiB/s,w=5575MiB/s
Instance 4      r=37.7GiB/s,w=16.2GiB/s         r=10.4GiB/s,w=4581MiB/s

> 
> Regards,
> Bharata.
> 


