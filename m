Return-Path: <linux-fsdevel+bounces-44828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370BA6CF67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD3A3A9B00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB24B29;
	Sun, 23 Mar 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJlbESsk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yl3BEk09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBA12B63;
	Sun, 23 Mar 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742735264; cv=fail; b=imm3qysdY4vyjjuOdXfIAn37V1xNfnPQSAKfKBvuCvhRB93bRt8yfBctWDBQrL8LsbSsii5oUZ3yhLNx0d868kgIcMleJPYz7XrSIfZaZjRIGdYaBxOOT5tNRJTOmh8kljhRUizZyhleG1udSm6zs7Ki/QOSmCQjhboG54kWqfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742735264; c=relaxed/simple;
	bh=MDhiZ5h2mi5HBEpk0B3+xvB8N6fsozOKEDCF4sloPZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccF1rK5THBEyQj3TUxktjfs9DLGVITvMhwmLPqUtCJTCVyaFPMzCbsagnUHLMrDJHoQehPFvoNcBSKdlAIj/+6VLNgne/e313b5qBe3r+t3pV+sWzm99O2RYqXZX2k0/WxpqdydiHPVKpXGGNOBAOaeFsTZbRmFQGJqDADyv41Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GJlbESsk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yl3BEk09; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NBWx0U019193;
	Sun, 23 Mar 2025 13:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8Qe9acBaPj52zbYwQB90WKywwgF6xs1LR8xaLLSlslA=; b=
	GJlbESskDycW6KYir7kj6pmiDqqZqTP9d9sqRLffhb3R5fSCBfY1OBqkFDTvg5Ui
	93Dh+VcTTwCCijXlmFi4ymqvbnoEjELYh1KnoedLjtUD/5eQPqnW6FAvKGgFbi98
	noUfU8mi0E29zqMIWL7TkRb079RAZOI68k0LarQUKidDyRofJ5Q6KermfaJ8XJ18
	wFDVbN4SQlZiSK99SGZIU040+Gn8ZJ3lt3r0tHV5Vlspv0sxLc9gygIEFXXw8iXF
	lAyOC/Uo9DCIL9p7m+mdhB3FZ520YDFxJM2zZJGkqNptdwipLsZDNmXMLWW5poeT
	Fcv7sIv0jStGJP3VuxlAwA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsa3y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 13:07:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52NCInYd008201;
	Sun, 23 Mar 2025 13:07:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6rgrrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 13:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA20EaMtQzcQ2BryyfymmQHcKvJ0aFCZ/2fwDJzQN2lmFL0b+nAkxJ2vW/cw7zTvWEdBHi4jxkjfKb0Zgby3TRlxaUYhipCSp68yuoz1bmN3hLfG3QHxjocOsXUYR0ORIsg1Y7fhVNEKvsa3nkvuQR2NT37Ddsjq/OjCLoEFrIKLvP9PWToWD/hvkpqwPQ/gGumxGGpQ37XE+Y5665dSrTPB3CjXQceHA8fCGgZ9aplcwTWogVI2oJFXx8geGGR2jZySD+7Y6AU1C3zc3Lx4i7KzKMQKcjesjAzoqcwLRmjXrVu6DQCktgnEhKtNPAAzxYKvUFcjYoZItp+BseAKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qe9acBaPj52zbYwQB90WKywwgF6xs1LR8xaLLSlslA=;
 b=nzw8aiVvaho7BZFtr00HNC0ekO6eHHxHE0c/XzdzmEhlCCQYhvMNT/t4BqBEEOgrkPruUAnzoLuReflsCZEvrnmVniZCf63FZTfcBXZmodC26RwemLfrX3M7EwGtfjPUp/EExI/XlrWEhEVIFD5tAz0jyHItdcB8DJrK5t+T7cY5WY+xrlvr9I0bBf0dxaMJIFeOc7MWe2aSUxRD2OCQ+xe7SZ67HdBl7oqL6xk9io7jPcJHJEFu9sWn2Zyb0EHBGP78BYgBv6wE77e6YZ3UpeyhQkC1tF1HVquzMvwcinq2TS00Tz48pj4KnB3HytEz1lJJ2BgSdVtKZ6AdGPMhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qe9acBaPj52zbYwQB90WKywwgF6xs1LR8xaLLSlslA=;
 b=Yl3BEk09stPCabLdYDT1TtKrMFHDZjCx6ajFPDL0NwgO/wyrJw/QA39nyp5Kcu6plPLzwLXbHkZp/nagmyC1oxJs3/T1J2mA6eVjy/8CSUV6Vn4tBXIOKY2mUZCN1yVPusmuKTBs1uEDWaxeJrtJTVFozuVj81ERUvpYu9lm2Mc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 13:07:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 13:07:24 +0000
Message-ID: <811387e4-eee2-4e68-91e1-e0a56671c5ff@oracle.com>
Date: Sun, 23 Mar 2025 13:07:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
To: Christoph Hellwig <hch@lst.de>, Ritesh Harjani <ritesh.list@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
 <20250320120250.4087011-4-john.g.garry@oracle.com> <87cye8sv9f.fsf@gmail.com>
 <20250323063850.GA30703@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250323063850.GA30703@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: e226e9c8-f778-4f5d-5fbd-08dd6a0ba737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVNrUlJIRTN5MEhKU0VZUStqRmxOcUNEcC9EaUU2b25NU205QlVPKzFrWGpC?=
 =?utf-8?B?NmlaWTRneURDbTlnVlBQUEZONlF4djZENFFYZldMZlJhRXozYlNuL3RvOElC?=
 =?utf-8?B?NlYxdzhabnpCd1J5S09mZ0FiSkVySXBIOGpPenZIUi83cU8yLzM5UXRkbmxZ?=
 =?utf-8?B?dEdycE93dzcvcFN0MTFZdGdxbVRwSmVPWlJld1lQT1ZLbmVYd204RmswS2N5?=
 =?utf-8?B?NzA0eWd6STdZNTUwTnN5NFZEVGRjM2VNK25xb0thVzE5S2czVGdlS3M5dTZW?=
 =?utf-8?B?WWRQcDNQRTRpUXNLdTA5c0lFZGJ6M3JpdjlPSytkS1NVNGVtbFpsdlVEaGh5?=
 =?utf-8?B?V0tkckhOUUhUQnFDWExoa0Z0aUxHQUJ3U0gzMGdEWEx1MEVLWWZRNkhnNnNo?=
 =?utf-8?B?WHJPaHRyVTBnL2Via01CT0t0U2hlZXdHTFBYZ1dBVXMzVnRaMVBiV3NocSs3?=
 =?utf-8?B?ZjJNZ200aGNoVnUxcW1zNEp1M0RpTHdRTmpJeWNTazdMa1l5NjAzeTRRczBI?=
 =?utf-8?B?ckIyaXE1RTVWcnVjc0FqOFJvaXFkd3FwVnFqaFNnTENTWEhxZlllMnRPTVM3?=
 =?utf-8?B?VitIOXJOc21iQlFkaGFzTDlGWXEybi8wWkZTdkljTmc5REpqMDVlRC9NbEVS?=
 =?utf-8?B?UHpoR0ltQjlLOEcxdWlEQ1VYVmNlcWZFbFJocFN3VVdMMTA4WWxIcTFEK0d3?=
 =?utf-8?B?bk1lc0Y5cndZYndRTzVQSkhYbWxUZUZLRjRHRUkxeTBGcllycVBJVVV6V2xI?=
 =?utf-8?B?NDI4V0Fwa3pUMjdiQlBBZWI4b3dZWE92VjRlM1gvd1R3ekNpY1Q1ZHNsVDBH?=
 =?utf-8?B?Zkk2elpQK2k0eENJZWdYY1F1VFYzejVsUmJvdi85YWVZbjNWSXgvRjRXTEVX?=
 =?utf-8?B?NVY2czVlak0ycHZOb0drTVU0N0tvQkEvOEhManpmaTRZOHVwZnRTcjMzNEc5?=
 =?utf-8?B?S3JaVHppSHVVRDk4OXVPdUVYTjg4VERUVWJmcEtHYnJBUStERmh0N0prK3Yw?=
 =?utf-8?B?VTNxSWdYM3F4bW5JM2ZqV29EZTIxalhBSWh4Y0NSMFVZMU1GTVduMWMzWWJV?=
 =?utf-8?B?V0JjSnlBdEFMbXJKQ0MvaTNSRVBhL2NjSDRaRGdLVWRFWFRTMzVoRFVibE1H?=
 =?utf-8?B?UmJkTjlZTXJMcVpmRmRRVU1xaGRWaXJhb01GQVpsYTE0bTh3OEtBSldxQm8w?=
 =?utf-8?B?UlRITkhCd2tJVmhXcEZ2VE8zdHE2SXJqVjVpS1g5OThjVzJDWmpHTkpJcS81?=
 =?utf-8?B?VGtMbHdIOHpwelpDSzZMTnYyVUYzbVE5WS9BNHE3MUNKNWVyc2o1R0ZDNFZY?=
 =?utf-8?B?dW5GUWZsR2JRK3F2UlBsQnRTUlZIM0g5SUlpY3VSNkNzalA3eXh1REl1cWRp?=
 =?utf-8?B?T1JWNVdmMmsyZENYRFZLbjlHQTdlNkkrbEo5YmFjb25YTGpZNkpEd2JNQlNW?=
 =?utf-8?B?RTcwdUNjQW50a3p0QkJLOFJOYTJKR25QWGhjcHZORXVSVDIwUXJDd0syTTBE?=
 =?utf-8?B?ODZHSGpHa3JZdWI4clo5TnpsU3FKZkxBaXAya0dZSThST3RudVlHMCtYRklX?=
 =?utf-8?B?dE5lS2dqbEJTSUhtNng2RW9ZTDQyVnNMblZqcGx0Wks3aCtWWHRiRmpJN3Bi?=
 =?utf-8?B?ektwNUgrcWxjeEtORjlXdGswSWxvckxCRmRteXYwS2VuRTd3TzZUMGpMM0xo?=
 =?utf-8?B?N21ZYnRBSXNnVTRocjMvcnVSZFpKSFBERWNDclJxRDNQTDlmZm9MM0g0OHhM?=
 =?utf-8?B?dERCODRKTVVMU1hqRWNtNDR5bjNYL1RSWFZGZkwrNzQrb0kvbjNMQ21VMFVr?=
 =?utf-8?B?SE1UL2pUazI3M1hLN0RJWkFWOEhDcjdoaDllTGZScFYyZHNSM2dnc1c2Ulhk?=
 =?utf-8?Q?ReBDNhYQJqF65?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjg1clh3cDV6N1pZcnRzKzlqaVN6OFdLYmRIU0s3dnFaQXllWG9yaGlhcHN6?=
 =?utf-8?B?YVozbnVPK3dUeUVESkFTeXQyWlIwRkFVL3FNdTVpbzU3bXY5RXc4a2JzcE1K?=
 =?utf-8?B?OHlvYlg5MkVnN1BaV1VQOVl1S3BGTWhZNHlSL3phTGliWFN4c2dybXhYR29u?=
 =?utf-8?B?TEYyUXNnbDNrWHA2WDdjaE9FaTJsczlaaytXbXpjTDJxSFprMXFFZ21XMEtv?=
 =?utf-8?B?Nmxudnk0V3dYU0JRQWNxMFNrOTVRSTVETWovN0dwRis1K0U0WWdha0FlMXVM?=
 =?utf-8?B?TXYyTnhydEVlYWdpMW15andTU0U0M1ByQThDT21ZQS82MkM1THFMaUQ1T1Vk?=
 =?utf-8?B?NnFIUVBwbWVsWjVRZnl5Rzl4ekZiSGdiY0pZUnY4VDB0MWVBSXZEcFgzVkNw?=
 =?utf-8?B?MlpPeWl6aThPbUpHWGZpWkZCR2RXU2FJMksrNzl4dzlxU0Z3eHk4bk1aWTBR?=
 =?utf-8?B?T29uM05HNTFSU2thTHp4Uzg5ZTQ5U0RoTUdXLytNbEc2LzJnVWdKY3ZzZ2Yx?=
 =?utf-8?B?UnFpbS9FMm90T1liekZFamtMY3FxNHovemVpTUwzYUo2T01ucktkNnkvOUlR?=
 =?utf-8?B?OGQvL2pJb090eDI0VVFDYjVBY2tOMHA1azFOZlFsdzhZaWFsV2tOWWdUQVNP?=
 =?utf-8?B?ankybytkQ0JSV29LcS9HcDJpSU9TVlE3aEtVWjgyMHFFbkRZcXJhTnIxbmd3?=
 =?utf-8?B?bElZWGxKSnVoa1lib0FrV3BBalhBWG5GaFQwYllBKzV4UDlNbk84b3hVM3o5?=
 =?utf-8?B?RjFTZmU3dEhBUzhIL3BxdmUzYmFRL09yRkxUTGZoSFp1ZEh1dkpCSllSckpQ?=
 =?utf-8?B?ek9PWG91eTJ5SHg3MWxML1RoUDE0Q2ZCa3ZDRGpjSUQwWmFjc1RBUlFMaUVv?=
 =?utf-8?B?MXdPdlQ1bVZhMnBteGhaZXBXN2JEQ2hPR0hkYWRoemlJaG5HUE9FL2p4c005?=
 =?utf-8?B?RXVIZ21GMmVtWWpIL1hYRGtUQWtKZzNqbnFJb0dVTFpMOTV2eE80VFFCZlNK?=
 =?utf-8?B?V0ZLanB0a2N2Qjc0cDQyaTJwcWgwbHRIZm5sRHVRT1ZjVHFiREVZWlFJUGVs?=
 =?utf-8?B?cGovOHp3eFFtdS9mR1dSQUdGUXBWRmtEWXVHYUQvLzBjSkhoZE96Ym5LODlD?=
 =?utf-8?B?UlRoVGFETXpOVzJaZFVFUnE4WnBTdG5reU5QejFMb1ZJVWxPTmRmbHk2L1Fy?=
 =?utf-8?B?eXpVL1JpZXhPRVZlZG1icFluSHhuaEt1bWdBUzRzZU1KWXBDTWF0Mi9qWU9s?=
 =?utf-8?B?Q3R1aUx3eFZiLzAvWEhKbWF6a2hES2ZqVjZ6dmNvUSt4clNSdCtnSXNPTU5T?=
 =?utf-8?B?a2tQNGF5bVE1TktUUHFlN2NSWnBTRU1qL3Ircmk5WFovaVNNbzQ0bUFWTDBI?=
 =?utf-8?B?cFJOVVV0QkZxRXhMdzUzQkMwQ1NtOHJwNk85N1RuSjlyWm80WmhvK3hhM2h5?=
 =?utf-8?B?RjVoNWYwMDZqdFNaUXFtSWdPSmpzaUJMUGV0VTVsOEhlemtJMklqTHlSeHIz?=
 =?utf-8?B?OVNMeU9uQUVJNEZ2cXNsWmtLaEFqOHQ3eFpxTzhRWGwwVmJiU2JSakY0RTd1?=
 =?utf-8?B?NENZeHhMRUNrSDRJOXh2V01ueFVERk5melFnNkFnMmhlOFN1dk5PS0cvMDZv?=
 =?utf-8?B?c2tYWndsd1YraVJTMXhJZGR3Q2s5WHZxbUVwaXl0dFliTk0yZjIwT1pGYTVm?=
 =?utf-8?B?b2ZJVE00NkN2TDd4VkplN0RSZXd1V0JZbnBjOTVVeFhzcHFrcHkzZzdpOHNJ?=
 =?utf-8?B?NWhPOG9Ybm16RUF6OG56UEJyRFJja25ieFcrV2IwcnRlMlhubys5M2xxbmhn?=
 =?utf-8?B?SEl6T0hWY1VvcVZlcVlwRmZJQll5TWZLODdjc0VaL3hYQzU1dStBQ1UyQjla?=
 =?utf-8?B?ZnBzeGEzL2Zhc2pkSDIxOVkyUm1HVkZEYS9nZUFFQ21XRlhnZFhHcVRSTmtS?=
 =?utf-8?B?b0lvdS9qRDBDeWlFWkRYZFl1WUZEY2ZnYWVuaHdtalVhbkk0MDI4d0tLM21V?=
 =?utf-8?B?b3VDd3dNS3NIV1pBQTFGT2hZZTBBaHFMMUEycVFQdk5FdDhtRjN6cW5HR2NH?=
 =?utf-8?B?eFBYaGx0RkVXZVpTN2ZHcUdBbkswbzBvMEI1R0I4M2xWUUUwNFBxb3ZmOXJt?=
 =?utf-8?B?elVhcjJUUVE5dUFxY2g4eDUvRzZaQzZRTWZZUTQySTJGNFBCem5qMG0xWTUy?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3C6F9Xlnq1ItKMGJdixFvydzCW4OMutOzWXqE8Cfy5N5GXvi+Wa/vvyB+J3dSSQWyngkRXjS7bnCzZfKwhn+FBQBZDF2HZw1ng1TiHey3XxrRZb3EzqtzpBfzVY5bL4YpV7Y0mTYCaRv7i1OHOwirCStgs3GlGfvpsNZDaAY6UGdtzX9h2yU51JGV2ivRkIu12eAuqst3u5ym8MwrZ0jyOxgonLdPCPbBdFiop+tY35XuTNfJHRGQIisWDa67mLeifm6wqqU3om4GstSiP+UOS5d/fPiSMJAoUgD+E4O+AwiT/ob40aezDItj8KXW5yDzchUYaZQkWfOoflglaKGTA2dxGiUJRq/RKFnizTV+4zhjjBLhVvACm+i9DXn7Lm8PjF47acscBvsQpKax3Glv0yCayiLj7lHJ9xIlhUr8LuEAFNmbUyurl79fj6WEFZzekQ/mKZJQXtEOc1Zw8UwKVJa8Gh6NbTu9dkKLV9m6UodDCu87vdnt+koPbv4BxidBA0JEjoaBBNvBQC5/QAuiIxUb5tS/ZGXcIexPy4VBeR6G3vDXc5UuZbCN422E8uh9n/PeyRhdLmGOZOOje6DnIRUWrf6QG+LrXaDtmHgvVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e226e9c8-f778-4f5d-5fbd-08dd6a0ba737
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 13:07:24.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsDkVZVgF1Zv8ioWdB1NM4FZBeM0uCglzjWrGBv/6q/ZZhVmtNtR2WO8pJzrFglkM/f6JdM8RfAmQMPwYct6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=947 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503230094
X-Proofpoint-GUID: 8OUDpmpK3Hcp99TQO3BSFn5l9cW1hbTh
X-Proofpoint-ORIG-GUID: 8OUDpmpK3Hcp99TQO3BSFn5l9cW1hbTh

On 23/03/2025 06:38, Christoph Hellwig wrote:
> On Sun, Mar 23, 2025 at 01:17:08AM +0530, Ritesh Harjani wrote:

@ Ritesh, thanks for the notice - are you ok to send a fix for this? At 
a glance, it seems that those two conflicting flags won't cross paths in 
practice (but obvs still need to fix this).

> 
> [full quote deleted, can you please properly trim your replies?]
> 
>> So, I guess we can shift IOMAP_F_SIZE_CHANGED and IOMAP_F_STALE by
>> 1 bit. So it will all look like..
> 
> Let's create some more space to avoid this for the next round, e.g.
> count the core set flags from 31 down, and limit IOMAP_F_PRIVATE to a
> single flag, which is how it is used.
> 


