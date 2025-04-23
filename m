Return-Path: <linux-fsdevel+bounces-47119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C1A99599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF66D3B9681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2349284B4E;
	Wed, 23 Apr 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ww+Q78bX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yTmFv935"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1C264A84;
	Wed, 23 Apr 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426354; cv=fail; b=mMsedS2aYZw1xzREyk53oXdXGDgoLlFIA0dUg8/SMjB1+tC0b41/CZTXkzDVqWLL8pXKnnBdSUJf6dwWgcXxo9LmmaEh0ARdYA41hSGYaXbhnZb+zSmMqut3iDtocV8bMXaZQwefXXIoHn3dxgoGxZ12rjy9xBVg/cv+D62mixY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426354; c=relaxed/simple;
	bh=5ziSJepTDqCIqHZhcnsohXnoisTdaxc3M3aET9eC1xQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VaxgOJmEIDYRhrkNl1mUmc2a7xjrq7xa1T5iZ/Q5KsVN5N9VAoSjdwsJPNjaweos5piw7Qf+KEO0b3kHnn8gxg+xLkuVAI7dSVlKT9RCblYXvRVRSNPLJ4zLIuAhXpz/sHNdwuJEu0XUx8SqSFzpv/mz9Hk0NYP68F5EB5J0lfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ww+Q78bX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yTmFv935; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGMtNS024172;
	Wed, 23 Apr 2025 16:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MSeKPZSQNpzncbiFAG5sniIChW14mmhJwU4Lj/VwMG8=; b=
	Ww+Q78bXsNujHMSTcfbxVt3K/LRMFsc0dR9RWmnICOxoaJRTNQl2LGw8AhqLPb5C
	30dfIs1M89zCjJ7/wNzWOFaYoq4MRoyfyUJLXCuxaXBgT2E6eokX9WDX6x/s2TkN
	1IiDKxMfrIRkuA3XVam17z6QMthBqWkR8jGrKZycqc+Si2HtuZah5pyQCLYlxufj
	MHcw3lAk5OyDqaPqN5F3ZVd4WgFbj6DdCehYNH8FCU4mRuE/LxVq9Q7vaXjmlAaU
	FpRAOwyxRhp18BRq2U91VDGoRkmcWi9n4qzslgdUhsgaItshw3P2vbaB1ogLuk5g
	7ywL3uGCw+eErYJV1/F3zg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha1q2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:39:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NFKKmO025069;
	Wed, 23 Apr 2025 16:38:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbqw548-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvDcbmFWI0FAc7O7DJj13kZq9ia2pHXH6NVFVShz8Wk4n6m6xp2dbTSlCxZsGjLysDCv4gOV3M8dKUrJTfA1bNDk78mqkPrgNhZ70PNKzsZQFr9Rtv2AviYwoJjac9prSpx7q6gecKwGYJrjkrFAT31tKmy3Xi8Gg7m6mAzmlNN5GtapEY9knI6VuyvHlLyjXDkiSeyr3aY1c9EYrxUAA1aazRE5LYhIcHrIyw/NBaE1WRpvV9aVdSiRhiNIPaTa9WbRfhq1025xCQsz+xCvjbwPqWYhb+izN2O2IEN1qAejyLQMGRc6imj3Z1rf97MN89lwSiC+xz6kA63h4gUbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSeKPZSQNpzncbiFAG5sniIChW14mmhJwU4Lj/VwMG8=;
 b=TiA2uTcg+OHpM3Lsv1zPEnkdin2wy1ikUgFcO0G2jJIe4l+RcQuOwyc9nJ2zu0P8gnOjhmSlWHSMy0sxm3us66phVazrsBYVzuymHa0R3v3oWu4ASc9s1yzp9gUUY7JYCgJ2wX18QCqso7cXgTjpZjgRiXdlH4k1E6hT2c5E29FYuR69sAk6YDuCdUygxCE+/mS7XhcYerwBzwGbO/7Z1e6IxMKc1LFOShrRfhgKDFCACSLBDxMA9Aw68azDGpRZ8yO7XAv7PkOv0lF4yxB9IpyfwFo2yMxGqih9bfhzvF9gF0r51x5FafKzCR4B85kKGqHaQ9a206tFcDP8lmE3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSeKPZSQNpzncbiFAG5sniIChW14mmhJwU4Lj/VwMG8=;
 b=yTmFv935jLD6uv2HfHPDvU1ppa9JnR1h0HICAiux7knipiSF9jL/wqvSBt4rg4dle1LmBZb5mWXo8MruIPQ02qdheUIUJK0rXJXd8MCVKWYOprJs1T8/gS88TwYKu4MkEoiNJHw8Z9xeLSKp1nzaioC3l40sz8yAtDlvQkXI/jU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 23 Apr
 2025 16:38:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 16:38:55 +0000
Message-ID: <2e1fd760-1074-4576-8164-d2ced5f5aac7@oracle.com>
Date: Wed, 23 Apr 2025 17:38:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/15] xfs: commit CoW-based atomic writes atomically
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-12-john.g.garry@oracle.com>
 <20250423082307.GA29539@lst.de> <20250423145850.GA25675@frogsfrogsfrogs>
 <20250423155340.GA32225@lst.de> <20250423155851.GL25700@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423155851.GL25700@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f007089-bcb4-4e75-84a6-08dd82855653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2kyczEvWVZHL1FKbkZBUkNaWEw0dkFucGlKcll4T1lmL201emh3K2RuYkF5?=
 =?utf-8?B?ME01MXNBUlhZWUc5ZU1GcUpkNmJxamZ4cnpaZyt5b1ZRandjNlcvVy82UTkv?=
 =?utf-8?B?dU51cjRmSjBSRHVObXNSenErS21LMHZLaSt3VExIcmVYWnBsbS9ZZmhEU2Vk?=
 =?utf-8?B?cnAxdDlZMTZEaDZNd1hkL0lPU0JrRy9GTmZoeE4way8xNUY0NENCeXF3eFpl?=
 =?utf-8?B?RVhpTjBCb1F3aWlBY0FlTTh0TUw4R3QvNHdseC94YzVVYTh6MS9sMjZPMWN4?=
 =?utf-8?B?ZHZhcVJIdk9aUG01c2ZxdE05QS8yWC80ZGRFbGxZVVBDTU8zbUZabFlvYnZU?=
 =?utf-8?B?bUFnMDVkUDQrL3Vmc2pOSERiRlhmTXhTTm1Dc0N1V3ZlcXRmQ3hSKzVHSi9r?=
 =?utf-8?B?RS94VGhSWUxMdGcyN1oyOGx4bHVLVGpULzJEd09ZS2tnTDJYb0Y0dDhHdXl0?=
 =?utf-8?B?OC9CNnVHSVQ2ZjVIM2lLMDhWVlRJUGJyaHZUQWFSWWdSZ2RBN2E4a0RzK2R6?=
 =?utf-8?B?bW04SVlzalM2M3M0RFREaVBES1c4b2ZDZjJjRGF4cFRlY2RTSGpzRjVsYitE?=
 =?utf-8?B?R3FRVUIzZEEydFFLMkNrcHhqdkxRVm5SMFl6K1YzKytXU21wNHlwZUZ3b0Ev?=
 =?utf-8?B?emRnNGlhWTRpNndGMWl2S1FHWC9RWUdBVjhEZ2RtY1BjbitMNmRiZ014dXNh?=
 =?utf-8?B?V3daS3JueCs5bFNxbkJpUnNoYkNRSWt4TlFmaG5tZXF2cENrTjJQd0EwVVVS?=
 =?utf-8?B?NitFWjhyQVhScmNvWko0MlBQQTNySmtPblF6enBBbjFCaUdGaEVLRTYyWFFy?=
 =?utf-8?B?dGtJVmlKVWM0ZFZtdUpHdzhkamtNYXNpUytMQVN6MEMzWWRzTm84eXhqYlNN?=
 =?utf-8?B?TER2Y1libzZ4TzUwcHFDTU54YnozMTBHMHVUaEh6V3Y4V3lTOVV4RDgySmN1?=
 =?utf-8?B?dFR4Yk1iNkEraHNHcWNGK2VLRmcwWlJRcnloMzR1RXFBMFRnWVVPOW5wQS9Z?=
 =?utf-8?B?dHo4aURQYlYzRms1R2FBYzVFTzVVQ0pjSjIxSmZSSTRabVd5U3JybTB4c040?=
 =?utf-8?B?clFrS0JtWElnQXc3VVN6OFY2ZWRaL0tMUzdhVHNpVFR6UDJTT2JIaWxjaDZW?=
 =?utf-8?B?WS8rd0hFTUJuY3doR1IyNVRybVNmNjRra2RnV01kYURzSndwQi9GbnF0UFdY?=
 =?utf-8?B?YmEwaG9RZGx0ZVRreWx0QkkwZ3hVNnpVMHg0WHlCZFVmMVVUYytWNnVobDRC?=
 =?utf-8?B?a1dIV0sxdlhqS0s4K1kvTVZaa203d2h6d2NIaHB4a3dkbXNyTGc0bFJuRnF6?=
 =?utf-8?B?RjVsbGtHMm1UTHgvbG90cU5ybVVwRDRRakZ4WjB3WUpwdWVqNGZpaWI1bHJI?=
 =?utf-8?B?M0cwMXhlbUNXVjZJaFF3QnlSYjQ1UnRLTjM3M3ZMK0hibU1lVXcwWTkvWURI?=
 =?utf-8?B?ejd0aTNrQy9zM1h0R2E3d0NQaWd1Uk5FNzk2VlY4NzZZd3d6VkNIQUprLy85?=
 =?utf-8?B?ckE0YU1RaTRMNFppb3RoOWN0aHpYdytMZUhqT1VRMWIzSGdlSWdUV2lzQU85?=
 =?utf-8?B?Q3lxQlhFZHRxY2Y0TTdaTkZCNS9ZS1BOVDh3bkRCR0N4b1RzRHhmTGlXdm1j?=
 =?utf-8?B?Z3hCaS9xN1lQRFBQNm9QdmJiS0o3d3EzbXVhWndXd0NHbUtCK2YrWkU5aTVu?=
 =?utf-8?B?aGRTbjUrbVVGQnBGNGNrdldaR0NnSmdJeTFTZjlMcHpsSWlDTW9rM21lS0pD?=
 =?utf-8?B?c1k0eDIrSnhTd1daSEx2NGRGeXFnL2ZsbWZnMkhLaVRwNGUvU2FQR1RpV0wr?=
 =?utf-8?B?bE10cTFXVFdabktIUFNxL0pGMUE5NnNZc0pIanhxVGZXc3RINi9nY2ZxR1J0?=
 =?utf-8?B?MmlwOFVSMGM4Y2N2LzNsRXpoU2ZCZ2t2U0NSVDlSUkNHYVdKZXlEY29ENEQr?=
 =?utf-8?Q?jI4GVQb/45Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTIxb2pjR3h4aVlEeG5saWsyYkw1SUJVY01xb1dYZXE4VXkremx2MnBwT0Nm?=
 =?utf-8?B?b0JiQ2xyZXpOeVd0Y0xMTDFHU08reDdJNjZzRExMZjJQb1NCVjBqREk0Z0Nv?=
 =?utf-8?B?eFE2U09VendhNTZHYTh5TjRIZEVnQSs4dGRzVTB6TE1qTjhtUjJYeXJ4V2pp?=
 =?utf-8?B?dkc4Q2lncUxMWC8vdDZpTmgrdGpEdjVaSExGU01ZY21ucS9tR01INEF5YmpG?=
 =?utf-8?B?UFA0RkdXcjdGc3g5ZEFDcEhSSDhocHRJaE9SMXljb1FReTYxYVFuQUI0TXMz?=
 =?utf-8?B?Ukp3ejlSS05yUUpmWWhVbXlQSEpURTlkT3lxMkVFSDJOd0tVSnVtZzVvUCts?=
 =?utf-8?B?cGsvSXBZWHcyM3JYZDAyMHJ2anBxOUFEeHZ1MVNjYWtGakRkMk1nWktkNDZV?=
 =?utf-8?B?WUNvaVlJdWMxS2dUVlNJVFRsS2FtdTNrKzI5dHR1Q0t4bVFUNTk4SEk1dW80?=
 =?utf-8?B?S1o4ck85VmU1bGZCbld0ZTRIY1JVd2c2Wm9jSlF2WmZqTjBLQUViUHJPWDZY?=
 =?utf-8?B?L1FBbE9TM3dsL2dXa3c0VktxVG9qV2MyTlREMzE2am5Ubnc5L01hWlZ5amJj?=
 =?utf-8?B?UGJqd0hRQ29vb3lUcTRNWmdJN2MwVCtvTnFBQXRlc1RldG9HbmQ1eEJUT3hy?=
 =?utf-8?B?cmRRZUdUUGJCQVNNVHdpV1k5NWViLzk4c2hiM1NoZVIxWksweDZTdkp6S3ZC?=
 =?utf-8?B?UHVVYktxQTVBc0VkQjAvdFMvdWtaMXdQNWhWSG5SZzVPSWMxUFkwbE5hZUpz?=
 =?utf-8?B?Q3l5NXNRTjhSK3ZId1VHUjB5b1J2bDI4dnFoYU1sZHMwcnNhRjQrcG9vRSsv?=
 =?utf-8?B?VDFyaDhVOVl0NG9hYzNmUGlzRHhmYXBnTW1mdkVLTWhrWWZoTTVtMHVlaGJy?=
 =?utf-8?B?T3ZUQlJMOTJ1WGpBOGprditvYTFmamFUSjVLajV4d0VBSGtGU2duZ05SV21m?=
 =?utf-8?B?MSs4dGdjNUk1RXAzZjEvR1djcVNKUGNzYnUwdjdlMlNGbjlJa3U1cS9lMlZG?=
 =?utf-8?B?OC9rdWl2K1gyNlNpZUVVMEFPRHBGd09NRkw2YjZPaGxkbG1nbkZrVkxnYTYz?=
 =?utf-8?B?NXdKVkh3Q2lybGIwWmRnQTlWMzkxTEF3REVxaEZaTy9zM2hzekFSeExIVXZH?=
 =?utf-8?B?SGVVMjEzdS9qMzl2VEtOYXRTczU2TVJVc1JYbkV3eVpYR0VZZjhsNVJoTUlU?=
 =?utf-8?B?RXJVbE83aGZXVW5YM2dQdVNPUFcvRGxvT0FCK0pEZjh3c0dORVRzOXBqcjNx?=
 =?utf-8?B?UHBYak9iTGp2SU1zRHVHWUZPRkplTkxsSE9RcVdEM29ZSEdiZ2dqSVVFVGQ0?=
 =?utf-8?B?endCb0NjTTk5d0lKanorV2FLWFQ4c0dkR202Um8wekdEZGIvcWZqNjRPV3lU?=
 =?utf-8?B?TmFwekFDQkNrVkdKWEdiNDMzWEpVWjk2a2RMNE9nS01ud1BkODl3U0Z3enNJ?=
 =?utf-8?B?dVYxVEhIWHBESktwd0VyUVVsdjcvSUY3Rk56RjdpQzF2UG52ZVNjMmsyQ3VO?=
 =?utf-8?B?WXlkcit5NlZMZlRoVnIvN3U0UjRqU0tDcHVETlErZXlUb3dsYmZkbE5ycjcv?=
 =?utf-8?B?alhpSlJhcEYzMUFvZ1cxSkYwKzVKd1dkT1RnYkJxKytEZ0s3Tk1wVU93MDFU?=
 =?utf-8?B?SVpBaG5kREVlb1UwWHZOUFJ6eEZwU3BOWW5tb1VZR21kWUFyUENrbzl5Vk0z?=
 =?utf-8?B?TEJRWkZvMjVqUUFTeERGL2VrMGVUeXpUekdzbnhrZEpxSEIwVGQyR3hnUjAw?=
 =?utf-8?B?OTY4NThyMmJzYWplM0M5U2NUZTc5TjJ3OFJtdkNzWWQ1UVhCN0kvV1NRalNh?=
 =?utf-8?B?WFMvYW5TVEt2VlNYS2J6czRqRnJqT3RWWWoyVTdKUElxQnVpVHgxSktOMmEz?=
 =?utf-8?B?VExHMDY3UkhJVTdNOGRkQS93SUFEU3c1ODAyanYwMGw4NlRGMTRXbGpyYzFV?=
 =?utf-8?B?TkZCTjNJZzk2Mko2WGxEcE1mMFA3UUVaeStqdW4rV0MxbU01OEQyOUd2VGdJ?=
 =?utf-8?B?MElBRGhLZkd5V01NMU03aE11eFE5Y3BCUnRkblYreDF3WlFtQmJLUzdTOWJ0?=
 =?utf-8?B?Q3EvdVZOVC9oRm1JOUgrMmpkbWlKM054eUo4UTNpSVFtdm56TmsrQU9yWHNM?=
 =?utf-8?B?OWxWNmFHMHdUc0RxNVdaenlPbzRnNzFTbEpRTk1ndW56NnExdGRCR1Y1Vk9y?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N2b39JCskC0Bkxx0LHVH3BGmvYywGRrTLOaIxxTaTg/Qr9ColeFaC0NHZaahn9JPDfkYiswVHjp2Lsso4+EVZ7q/0nlvt1gB9oBv/7dETmj9vcm01BGcwsnyUwc+lGM0wgRNem/a1DfleO2Tb5k8n7UjziCgRK6y2KBo1Lk9kfQ2y7pm/Fj3JbGPvTtEvKhXXu7+j7hufgRDDESPx7ZzOMsFQHiXDyg9pFbXyb3hHBmeSAM2YZedN48Jl5e+MY/NL+wBz9zsSysHV+JgoLTgw3meSKZ9IAQw3I6jcEU+dqPvzLHm80x/4KR+wSCHAoq8uu+1jEFktEZgm5D75W7AfceMDEpGuBDrzMIsPXT1trsI+WEPgnPg7lSTTMMWLyVQqHRtaXVF6GsKaL/RmyQtjOC4wgO7Eji0fhzBdXVSnlqx70VO0DV/ukAsnXiyhifvUgSeihfw6oYExR1UXSyRoZ35gInqUZB011IJDK3FlIFKwFnb7YaZMqL0hHfOwiPX5GaPxjNfixVa3oM/+NvuyW957X53gNwQ/bz9NUN/34E7Bij2R4Hbu/BN1bINML1aaQYPTWKhvz3LTinf5qZyasMK6k5xd1SMzxIViwYJO8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f007089-bcb4-4e75-84a6-08dd82855653
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:38:54.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwi+8LHMQ0F8r24nrEfQ0OB0IpfTy7RvpSZuPWryrrrA1YzRF9hIKEQcQmpzYZaUrECPlcePaCpcbvYod20e4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_09,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDExNiBTYWx0ZWRfXwVoRkTXpBqpp JbyD1TsP/HltecfGo+HyinlfBsux8D9M90HHOu59+BOcK5NFUjCHk1GmMASPmEtr1pAtqoHNUlM jlzw5sy6Bhvwk6BbSFkeA7ADOo1CDVa2oFBiWLn9pKcBifTpZUVPDL9m4VjA3dIHcdqmoYzLqbt
 zSnQDkh3d2YKls3IZrpVzOWnAXXzECFyLu2J/YDw60weiWxMzMgYawE3+hYqW8UcJjMa/32r6Pb YufiJVrha6gw/FuOjFW2KW9Zpo0Neq1b34DGH+6IYuM/ealxIF6OC/m71x1G0ALyDNV0vafOdif hjw78TekyA7cjTqetqlI71iYPcw9B+mwYOPMhkojJMS3qA1polB5A0PefOLnHsEqPn6XUWHmopU 7mIpA/49
X-Proofpoint-GUID: 39QDsMxDrkODzOD-8WaCKOHi5mBisyVD
X-Proofpoint-ORIG-GUID: 39QDsMxDrkODzOD-8WaCKOHi5mBisyVD

On 23/04/2025 16:58, Darrick J. Wong wrote:
> <nod> John, who should work on the next round, you or me?

If you can just share your changes then I can re-post. I can fix up the 
smaller things, like commit messages.

Thanks,
John

