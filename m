Return-Path: <linux-fsdevel+bounces-42574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D4A43D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FDF3A11AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CA2676F6;
	Tue, 25 Feb 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KFv6p+Ey";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F9VQ7Plz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A71A239E;
	Tue, 25 Feb 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482240; cv=fail; b=G7n8xTJ/tER/NWUFrLcdQ+lWo7k+HSU9tMQNzDflOxUrjg0DTe0TdFAxoBmJ9E6SqP+YTZzAHjOSgTo3hhkx/4FoOKYgQoCFzzD01/gwKuOhD1D/u+lJpPvZETrlHL7rve9zrb9alrjAJ8V7Hhqn6UIcck/oT/HQK8fw3zGikM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482240; c=relaxed/simple;
	bh=r4+EZnBnQkf9745/QDHYpoaBo0b3TFICzWkQXdQIcoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZtueHu3ahopKYZVlX9pFlE7PNFI2cvADNXFlgviSxXBka0FKKF2C2KyxTS6YMQL2tQDIIwlKSh/uiSoRtB5Q/tTxoRsMM7Szkltt6yftyJZhaEqDxQE0RCY/BbUitmCt8jX7K7rbHewtFaouplaD0zB1Xi3VG5NbL0JLNVn5Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KFv6p+Ey; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F9VQ7Plz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABi4A013345;
	Tue, 25 Feb 2025 11:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GRf25Wj9M7Bn0fj4mtcwbkBNtkVtfLGBEuNNX2dJOck=; b=
	KFv6p+Ey7ZiC2elmj9buCJCIDNcUfdNcf9gm0i9/Lyupsw2WW6pCqHnOuu2FgJQa
	7CdHvaeTXptid/ZX+cusYguCDNiRyLO0aOwpuykR9a7EHSIufz7P77ewFOu+uBQW
	Io2B68IXwwR81Rp2yT/WdBnXvXVfKDdj5Gm9kRmth4EYX53Zg2j3oCeQrkk2Jp3f
	3AfwRpt2Ipg2m7z3f/rYXoZEU75JmQBHrHX87Yt2N+nvPqoyxASn6oW2edfB5KBs
	pJZvf12FSMgEIo3WJ6aIsvtBR8wyMqpXsEjXu0nLT9Xcf5E4+D8h41R417g78aBy
	4Ra/zywu82LanIifMa9UQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604vun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:17:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAV1AC024302;
	Tue, 25 Feb 2025 11:17:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51911jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 11:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TleTe7vXbfC278Q+UHAhpvppOdJ3+e69sxhgjAzmOVc9LY1BfoFi0+edSKAOsOnooHfxXgFnqZlRsbpMIoWOc1cht9dbUmq9e70LlAc2kN1PiID8JSQ9VQgFWsl/4RfTA7ZCgrbGw/i571LzxxrV313LkREaMgXcAheNyiLRgyUpmn5oOXuy55ijNaebmnTDhVVoGRvJq5epkCB6Xuin0o7MC5Y1P0HqT/sv/49h4onTTtvPm30IOK4Uv5XCsXkyPYdtVY/BK2N2Rfy9aNUfj4FPJkG3SuyxurvOzBfVzR4Pqorewakt8MvDofrjhIrZCqbJkKQm2M6f2/w2DXK5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRf25Wj9M7Bn0fj4mtcwbkBNtkVtfLGBEuNNX2dJOck=;
 b=QhCx/x+h2zuLtSHmeTgiYxMJ+q0te7vq+dOaZpxKxtD6DlT2H20MGvPF/ZA6/sBfwMq6irC1aao4yKk+9114g5Bd9eFxmEyBuusy5J0YGYm2ltqM56dVWTk25htJgFH9OBaArlDk4B78c49kkj9XYP8Ygp6JKwMReKdCJFexbjLoQtPQSw8tgBlix+UhGpikcrZpSH5SfFcbh5gSM4gY53Lh2tzdIt7Cgbg0Ms/pKK0Vhq7EWSemclFXsKIavdurYqy/hBkGFa0nMmoF93cV3n/y4G01XGifd8N+oAu8pxmYPViv13CH942DJJ6ICcbO2D9+YhKHM/280PU++S9C8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRf25Wj9M7Bn0fj4mtcwbkBNtkVtfLGBEuNNX2dJOck=;
 b=F9VQ7PlzzevFAVk1ZYbOilDP93r99OBHF1kDseNzvDcF5qgpjTDvJxiryzuoWcQEzookZ9VkiFHvGR0h+hhRgbfL+MLWEtXIU7VyBFd+riiCxY5iHzatXHQ5B5+MBa2X7KU64LkIVsdvBhsebsdYTciQebduYvNVAu9qKYtH6jQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:17:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:17:04 +0000
Message-ID: <2f9ec6ae-46ef-4d32-a838-e01828058a88@oracle.com>
Date: Tue, 25 Feb 2025 11:17:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] xfs: Allow block allocator to take an alignment
 hint
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-12-john.g.garry@oracle.com>
 <20250224203737.GL21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224203737.GL21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 133bcf95-5cbe-4192-7268-08dd558deee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm5XaVl6Nm9CbHJOeXZYWlRXWFZPUGZHYkpheldNT3pCMUcvVUhxTGh5ZWhP?=
 =?utf-8?B?RVNVYW1Ra081VnpuME9yWTQwMUxoTlZHcVl4cG5JbkRJaFBaWTVwY1E2bmFX?=
 =?utf-8?B?TmVBYWpRQWUzbVJEN2tSWktNZVRyYUNNdTJRNDAyMVdHRjQ2WXBmS01UNnlD?=
 =?utf-8?B?WGNRNlMvMHpWZkpSOXl1M29ZdlhTOE9aZ0J5R1ByK2p4aGpZKzAzSDdwTmZY?=
 =?utf-8?B?ZUZmWUlyRnBKY2NBczAycmwzQ0VobUFRYlIrSGJVQ00xMTh0cVp4dGp6cEZ4?=
 =?utf-8?B?clR6SVVXZ0hIZWFHVGxBdXpIMUsyRkJPendlVGNSZnlyWGJFeEx2Um9LVzFn?=
 =?utf-8?B?L1NyMkpaY216SUZBQit1YVh0K29ka3AyMjVUNUdZbWovdjk1NkpobkdkSjA5?=
 =?utf-8?B?eklnOUFKekhiRmZ0Qlh1WEd0ZHBPemF3OS9lRGljUDZSSEpnSGxmVEFsdE1k?=
 =?utf-8?B?dTJma2FQb1EyM0drRGpqa0xqMXUrTFozV2pxNGdyU3dRMFRKU3pTbEczMys3?=
 =?utf-8?B?bDBtL0FoQzNwT0FFT2R2ZTdyanJsb1lVSnlPUjU3SC9mZFNyTEVxUkJUU3I5?=
 =?utf-8?B?V3Fndi9tWVIrUjV3Y2I1S3NVM3o5NUJianB2L01mNzF0TGtkb21kQUQrNDl5?=
 =?utf-8?B?blcyenJXNU9jYlA5Y1VXR2l4Sk11UDFEZXluSzRKcWY0UndVZ3ZydkFNejJw?=
 =?utf-8?B?L05tNlViYlFBV0xIVTFwR2pHR2QvcjcwNFppOEJsOVV6WVQyVzFwZ0FXK3cx?=
 =?utf-8?B?VldRbVVsc3lNOVBvWVFUQ0U2bE9IOGFmem8wU0VjblJSOGsvMFY2YnJMTWxE?=
 =?utf-8?B?STI3enNkNnhCSUtzWDAxbkNwVGs0MmhVUWQ2Z1h3Q3FZdFR4aTFtTlFYZExR?=
 =?utf-8?B?bW5wcFlPeDYvU1hXWUw4c0FtcjBHVDJMbHJWYW9GM1gvUmNQOVdlbVBpZlNF?=
 =?utf-8?B?WkJPdXl1S2RwUENDeTJvZ2VvL2hCa2pURFdSNUZRSkp1M0ZCOFhQWXZmM2Yz?=
 =?utf-8?B?aUUzc0ZidzJLQVRQcWl3SXRSelIza2ZBTnYwYzRqNnVicmc3VFNBSlk3QTV5?=
 =?utf-8?B?bG8zYlBrdExNL2xLcXVqVTU0WXhVUlp6WTg4bzM0S1FQbHhzZG0wMUlTRnN3?=
 =?utf-8?B?OG5IYUNGdTREMm5NWkJIeGZzTlNHcnF2aG52dURJY2twSVZiTE90TGMvb1JK?=
 =?utf-8?B?RVVZUXlld1pTWFJyNU01Qm16c0xOUFE0bDcvQmVCVkVCV0t1NXhDL2V6eTJ0?=
 =?utf-8?B?M24vT0ZOc2JhalJmYVd6MTZNZW1EcGRDbjhxeGlhdjRtdVBCY2hudzJnVDRE?=
 =?utf-8?B?NkxlUzVYWkhHdkZPMnNoWWhRRnpxb0RZUDFzM2xyWThYYVZvR2RWU3RCRXc5?=
 =?utf-8?B?ckFXOW9INGtMZmxSUUc1dkRsdXc4czR1MU9HVUp0VDdkbHZDZUZiSWNMbFRi?=
 =?utf-8?B?MjlrdjdkRGJtM0dRZFhFREJwci83WEhqa3dYTi9PYSt1SThBQllxTHYvZWJk?=
 =?utf-8?B?L1lPOEw2VlRna25PSlpVbmZwcmtYZWk0aHRWdnViU1hzNU5IbTdrVk9CcC9s?=
 =?utf-8?B?enZNTVdMVkFzSEpxMndtWEswT0dZcG1ubVFjczlXMzY5dWZEdTdJTmdGWmhB?=
 =?utf-8?B?YjMyREJ0bHQ0a3dmYlpROVFHbHdYQ0xHTEhFMjNWaHAxS0VUbHlLODU2TU85?=
 =?utf-8?B?dThOMnpXazdhZFA1M2VkUHlWVVNwaXE5alZQRHU3cTV4a0pMNHJ4N3hNaHpS?=
 =?utf-8?B?NUR3TDRQekcvenB4bCt4cEt4Ky82TnFHcVRjb2VxUGY2WndpSkUwcXlxdGRk?=
 =?utf-8?B?akFscWlYSHI2UjNEM2pUZE9MUVZEWWdaMTdQd000dWtXTEYraVlSa3FyU1BR?=
 =?utf-8?Q?QFFKkcd5irSz4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUFGaGFHSHAxaDltRlIrOXpuajNNbGJyOHlhYXZXMnBtb044R0RhVzluTEQr?=
 =?utf-8?B?MkpCeUtyKzBqWVBDa3hBMFNrOUhCdEpOM1NxRnhKcnlFRnY5ZHBuQTF5YW4z?=
 =?utf-8?B?aEcyeXBScUZ3WjFYS1IwT2NRcEtveWw2UDZNZGRZRlRJY2haem11a2lEU055?=
 =?utf-8?B?MDBVVVo4bENBckc2dnlURzdsaDVNU0NBdEg5NExoSlRCcHN1UTBvbkowRExq?=
 =?utf-8?B?OXc0RkJuNHUyOHdSSnUwVFh1eWhSSzBPVVRLZmFORVc0MFJYaERzZ2xNN2Ev?=
 =?utf-8?B?WkdTUTlRdE03dzFuYVB5Z3VXVGtQTzVsbVM4ZVgzd3FuZC96SkthY2pzRERB?=
 =?utf-8?B?aUxRK0ZTUWdpRkQ3VEtpTzBpN0lKbXk4ckhMNWs1UmI4SGR5T2MyZ1p5bVNt?=
 =?utf-8?B?RDBwTzg0eDJQRjFJTGZmemtQNTdLTFVSSmdzV1BxZkVURG8reS9tZHNwN3Bz?=
 =?utf-8?B?ZDVFWUpjczhoUHNUSGI3NjB3K1NFL0VOT3dEa2tuTmtPcFpsNmZheE9haHNo?=
 =?utf-8?B?T2NTQW9Rc3NOdzhPbENQRm1KSmNJc1dtRkxpazJhWldCckJNekxSZWlvR2x1?=
 =?utf-8?B?SjUzcEhoMnM5UmMrQytPZzN4aGNNSFdGTHd4dlZqbnMveEc2aGVmdWhscGlO?=
 =?utf-8?B?RzF4c2FoaFJuYXlQN1IrRUNIOEFsalR0TVEzWDMyMkdZeXh3THlDb1NIUGJW?=
 =?utf-8?B?eTJxZXBzK1pGQWhKa3c4THM3ODk3UTdTZ1VNWjR3RXhrZHM3UVVJemhCaHZ5?=
 =?utf-8?B?TzNlbURkMzJBak5zTHVHRzdwVlhUaDBGRzhQM0JXeEZLaE5aWExJbzcyV0Nx?=
 =?utf-8?B?Q1l5MFJXa0VDVzlaVVowNGJiN2w5MWxMVmNjUVlmVUs4NFBhSDhiaFRpbTlR?=
 =?utf-8?B?UEI5eDNTbWZtMVk5bWFwUi9KaUs0UEpRZStrRkcxQmMyamVwUVltVWNQTGdD?=
 =?utf-8?B?cklwSGtHS2NROGJ6c1JsRTNyVWliRktFeVBib3pESlExLytaL2w4cHVtdm9I?=
 =?utf-8?B?RUxrdnNIN0VMK1E3UnRPdmwwcEVhRGd1RGpFa3RUTjJPTlpyb0JhMnpRN0VE?=
 =?utf-8?B?UFNveDdOZFBMSEJid3ZjQ2ZRdUVRdEVIUWM5VkFMT2IrOUpEOHpia0RsSzJu?=
 =?utf-8?B?bmJWcXVVZFJDZStZSU1xOXpiaUQ5QlE4UW5jdHAvQUpOZ2huT1pMNlhnbjE4?=
 =?utf-8?B?MStIQy9KYkZOOXhuY0szSlh2VHRkbHJ3UFh1RWVZd1dsN3lRcGxCWTF2UElx?=
 =?utf-8?B?K2hFMHBGTmxTczIwdXpKMUI2TERFU0doaDhzblZvMUlyanBsdGQvN2RhQ0ww?=
 =?utf-8?B?dUhRc0pld3laRUo4Wk03MlNEa0o5aGNqVllXVWVRWE8rQldpdzB1emVwQ2lG?=
 =?utf-8?B?UG02OVdJRkJOMUJCQjM1TzhZYmNySFM3L3BmVWhka1ZzaHlaRVBXb0VMSk5n?=
 =?utf-8?B?Z2d6UzZPRlcxTkMvZ3N5ZDRINExabGZjUnpxdFArcXVOa255eWV0UkxnanNO?=
 =?utf-8?B?am5SNDVrM01ENEM4eHo1aTg4a0NxbnBOUHlpUTR3cmpETklMUTE1T0g5bHJ6?=
 =?utf-8?B?N0J2S1ZUWTZzcE9FVDRBM1JCWEpLNmRvZ0hFeThiNU9GRlVYTTI1ZFdUSVJQ?=
 =?utf-8?B?ME5oR2ROWFkrV1pHUG1rTzk4SjJnbUlJRUZNa2dyN1dDUk5ESXQ5dERVaXMx?=
 =?utf-8?B?U0VwSVZhbEpRcTNreUZwV0RpeExubEUrZ3g4K1FOS2w3S1d1NEp2bnJQN2Vt?=
 =?utf-8?B?elltL2FNQW54aU1BVENBV2ZBek5lUDUwRkpKY0xwVTBiN1JnS2piSWJiOTJk?=
 =?utf-8?B?RWJ3eExXSURpZ1NrUzduVUJ1QTZEQ3ppc3FDVlY5STI3OU84eDVJczF6UlE3?=
 =?utf-8?B?WXJWblhTMitIWWJRbUo0ekNLNEc4MWRnOTcxR2RVcHJpeExjSzZrRTJjTzhj?=
 =?utf-8?B?Z0VvTEZhZmxXT283MUxnWWtqN2hScTU4WUx5QTBsWE8yeFI1THFFY2xTTmhT?=
 =?utf-8?B?Z1hWMHBicnA0L2J0M1crWDRRSm5tMitlejJJZjA0UC9Kb05nMkZoTW9iaGdq?=
 =?utf-8?B?Z09tWXZubVRSRW9uRENlYjgvUnFWQ1pUUGhjay9ZeUloWGVUUzFkYWdmTjNa?=
 =?utf-8?B?K3ZYVkpFQ1ZJRkMvU1dtanlXTXNsUEpzelFEUnV6bVdIaktUWWdSOWprZUhm?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jqci+HJpzvH1jY6HMcqZYlwgEjJVIeFfV/gcsQQodF/I91/z0xsiyzVyv1UkQfPVjugPgckKGUMLcQioaEkfIiaJhUdSps7Bl9SyoVA73s0SbOKJtW00E3IvHli/Ps4RQOTLnBb0mBdSrlOThlGfFZi2tBY7QEXFhsGbpxa31QvISbeeSTsXwBCak3JRMCSFwYUrEGC4tnuImSjrS5/IFCXOV4gcc+Of2LPb+avqOAWT035I8glfIFtR/lxYZaXk3U5IPqMJ84Hqe/mjr4qF5ZUFCtmLX3FdkOCtby4BMWWZyGIGEeDgq0xZnvyckMIyzj0ohAEE2wdjU38IFb0uB5UXcKdjCrKrpGA4zfOcdczllgfVY0pXotzG9dNi2pYIEPbmTaV84SgkHJiS8OuLsI3Wf2h8aAaPh39NModzqOHBxaWIVtKULA6LMQgGFjm+MtpLdvv6SQF0tx5Q9f6WKQJF0cnFZpRUoY6rjTemHKM3ggkqnGgxFA/DZ8DPppmxbeh5eAqWpZbdNBgmZgGbr885CBqUpT/VuaDQ5TVFCjFoRpQJtzY4lKAuY2I/8t46LdzVNLhUfqjYmRnI2yK7VQ9gvRpO2cVAoY2EojmpZ4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133bcf95-5cbe-4192-7268-08dd558deee5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:17:04.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo5OzlD4W9NkJuBD1W80D4iCLc+88oLbxg/8pOWTjSuWagXfN1x/DxdGPt32f+Z/38XntsRR3ycJd2BgY+AlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250080
X-Proofpoint-GUID: DwkLYFl-eyJlnbO09uW0IyZ8rXpqtpKn
X-Proofpoint-ORIG-GUID: DwkLYFl-eyJlnbO09uW0IyZ8rXpqtpKn

On 24/02/2025 20:37, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 01:56:19PM +0000, John Garry wrote:
>> When issuing an atomic write by the CoW method, give the block allocator a
>> hint to naturally align the data blocks.
>>
>> This means that we have a better chance to issuing the atomic write via
>> HW offload next time.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
>>   fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>>   fs/xfs/xfs_reflink.c     | 8 ++++++--
>>   3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 0ef19f1469ec..9bfdfb7cdcae 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
>>   		align = xfs_get_cowextsz_hint(ap->ip);
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
>> +		args->alignment = align;
>> +	else
>> +		args->alignment = 1;
>> +
>>   	if (align) {
>>   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>>   					ap->eof, 0, ap->conv, &ap->offset,
>> @@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
>>   		.wasdel		= ap->wasdel,
>>   		.resv		= XFS_AG_RESV_NONE,
>>   		.datatype	= ap->datatype,
>> -		.alignment	= 1,
>>   		.minalignslop	= 0,
>>   	};
>>   	xfs_fileoff_t		orig_offset;
>> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
>> index 4b721d935994..7a31697331dc 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.h
>> +++ b/fs/xfs/libxfs/xfs_bmap.h
>> @@ -87,6 +87,9 @@ struct xfs_bmalloca {
>>   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
>>   #define XFS_BMAPI_NORMAP	(1u << 10)
>>   
>> +/* Try to naturally align allocations to extsz hint */
>> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> 
> IMO "naturally" makes things confusing here -- are we aligning to the
> extent size hint, or are we aligning to the length requested?  Or
> whatever it is that "naturally" means.

We align to extsz hint, not length.

As for use of word "naturally", I'll try to avoid using that word.

> 
> (FWIW you and I have bumped over this repeatedly, so maybe this is
> simple one of those cognitive friction things where block storage always
> deals with powers of two and "naturally" means a lot, vs. filesystems
> where we don't usually enforce alignment anywhere.)
> 
> I suggest "Try to align allocations to the extent size hint" for the
> comment, and with that:

that's fine

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 

cheers,
John

