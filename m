Return-Path: <linux-fsdevel+bounces-42563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECDA43B61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684AC3A7570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74252676CD;
	Tue, 25 Feb 2025 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ciBWGBto";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0HLR6/TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCB265610;
	Tue, 25 Feb 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478815; cv=fail; b=oQ1uCB5gzyo6spEUE8B3ihn8vn4Sh9XnstfUC89PRZ+cBhzPVXLzDa3z6xw3YBnTQhjrkZRJGTrtfbpW2gKSCd4CtTMWGA+OtbGGxOkc7m32dLy42O5o9KbfUAe2rILijFV/9j7t7gTpOc97BjdkpoPOu6WJhHSoUHyUd5om3M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478815; c=relaxed/simple;
	bh=ZtX+6wKdXWWm87YYmpbTCdE/azUGpggc/YJOqYQvR1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1jWyFRly0No4kaPmOwd7OaZcEcidvdZQzywpqd9B90o4bZnwHTt1a3ZEl72D8mOx09lpM34PJZI1Gza4sNa/phoicHCfYlrdvzhqz6qZUMx8o4PIjlUHZJKvxhXY8yeaBh82OvqKMrOgqclHJCG9p39x/qrrn9var0/29jX9qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ciBWGBto; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0HLR6/TA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABhjP013339;
	Tue, 25 Feb 2025 10:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cIGItMlEbNoOmm5eyNiC7T+tr8wD7qlAISYLc4EI/to=; b=
	ciBWGBtoZfMyTdoBLICWgPhfyoFFo9Zwc58U4zeUREEVPwJbtgQWidOdqboKPQaF
	Y/AJB8F4oL9GdGehH4seIIX1dIc9mkPuC2jH2jUrxQaibGKcW6UgVxX0FsGeXpIo
	oB6keS5dx5krkt+z//n28gKH1xinkQZKWMFhZ2UvAhkdELaV/e5fux5Y5vvx94bi
	rvmQBKnvDNEpW2HCGawsT0+RLAHEJOVMv5l3g12HLxrG0UjBO+uosff45+B1hHOT
	JJZXlIrLSshxeHBzmMOJh7gH7vauYNbIj1PL67/mlp6bc49jplGHSV5e5wTgDbJx
	V4mUKbNj+qIZfvYAANndAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604rvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:20:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8EQ9C010336;
	Tue, 25 Feb 2025 10:20:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518pd56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/X5PmA5KXi7nD64LCuxgvoebe/mjcNLKeAPPxtt+q51xC3qoQKtLSgij8ti9920Sp/ti+VfRMGUERpVToXLyBidMKzEWA2Ng+YCY9tA/HwMoGUJdbwgUguUHB2uaCh/c9V/1rhM+HJ0GTMoj2Y5TfTUm1jfxAYm9AOjuKA7VmeOt/ejPlXR5AQE89z7K5+6LE8qoQOOXYatnNvDoE7iMT2LVVZSTD41W6MKGtTEmb0cfWTwN+39uu+s7fSD5vMfv2QcSMMsZpjAE55AgOlr894hZPi9p/rMTy4wmzyrbk13AvQaId0bybyktX0PmgYj8UOrpJoiHl0kS70ujd5v6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIGItMlEbNoOmm5eyNiC7T+tr8wD7qlAISYLc4EI/to=;
 b=Xi1kpliWwfOTnzr8vr61zz2CJHq0wt9UTFlVtThizgcmNS3kVXMzk9VxJgeKnMH26R660SQLwp7a6TzZkvsAEXxJPwt4xkMdHEgSffcWsAIiAnfxyvFGhR/7FGT8QottwazRAZizTC+Ddx4j3eLGq9GZ+BEtmR18AmOSO5OUwEQagwMf1idnXfqXPQ6FcGOiAc7bfz03y1ZmzetlzMTFRpSwxrllSZtrCjOBkctlPgI7X+b2J2Pep8mgNUfbgPbtv3HrNEt3c95oSMGbIDaze5dhFRbEnRhJNnTFmjEZtjnTbbyb31i21Mn3eHYObijUqcsjyHaN2IZYPrftPbcGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIGItMlEbNoOmm5eyNiC7T+tr8wD7qlAISYLc4EI/to=;
 b=0HLR6/TAXlv5abrrukON7ZHybrmB1gbmnxM7UiI88TKIdd1eKKhTsQ8hS+iLJh5pKSMEfUc8kmL5BqVlWt5By+uJQRcnq/bX0IE+WdMv9C2RJQ+w5VT7R6ze5CaeupSYkEiU4dgLowFmGZCIaLcnUYLQ8VRKndflwijHDHJBUR8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6201.namprd10.prod.outlook.com (2603:10b6:510:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Tue, 25 Feb
 2025 10:19:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 10:19:53 +0000
Message-ID: <c3958187-e83e-46a1-a204-87b342583a4a@oracle.com>
Date: Tue, 25 Feb 2025 10:19:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] iomap: Support CoW-based atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-5-john.g.garry@oracle.com>
 <20250224195912.GC21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224195912.GC21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: dec43bcd-1432-4d9e-48c3-08dd5585f203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1M4UnBLZlM3WE02bjVHVUlNQTJBd0V1VjVCMTltRFRLOEk2ZDI1bnl1Y1RO?=
 =?utf-8?B?cWhiaXNiTnZkUFZBSnZHc25FWEgxOXFTMWR0TlFYcVIwV3dZeEZCaFVoaDhW?=
 =?utf-8?B?NHBOMnp3c2Z4NFpFMmFPb0FTelVlbFlMSEpQdWtLempoUXcwY2pqZnNZNDdx?=
 =?utf-8?B?QU9GNFRTMFZsN2FqUVYzQXNqdDdIdnQvUWVPUU4yVXNrRnBuZTRIQ1FVMTJu?=
 =?utf-8?B?KzBpSTBBcHFWWG9CVEU0czhJemszZ1dCOFJFbXNQUHFZbnVvZmFNMWRLUlkw?=
 =?utf-8?B?b0JGR0N4cHdTS3dPeUJzL1lEZVVFZ0tpRzR4N1Y2UUlHUldraW9NYmFWSkdi?=
 =?utf-8?B?eitwcU5EcWI1RzlveDd2ai85dHNSTHdyeWt3dnYxYUJnWXlJRi83Njk4T2xF?=
 =?utf-8?B?dlB6K3BBYU5VcER1UU8vbkN2RDV1RHhBT2dHZXVDSVFaZENLWHFoQ1VaQUJz?=
 =?utf-8?B?cGd6di90Z09MRmZndkd3RlVRVVJ1VEc1V3VsNys3RzlEbVJBano4eHAvMEhY?=
 =?utf-8?B?bjdTc0VJTW5KVWRzUkNlT0sxQkQ4cW03UjJKODBRU3loOHl4TWRkODIwSVNK?=
 =?utf-8?B?SEJ3Wm8wNEc1UWNKbW5zTEVEOUpORGhNcmdhbW5zMGF6NXQ0MTV4Ujd2T3Vo?=
 =?utf-8?B?dzhnczMzK2xNQy9MQlk1MEhKR3FBcWplL3oxSGhTbTc2NGdvMGM0VEJnS0hL?=
 =?utf-8?B?RVI2QUk0VUcrVzhxOVFpQzBLM21GMVh6V3JNenVha3hTZ3ZBd3FMVDV1YW5J?=
 =?utf-8?B?cEdwYkpJN2s4Z0I1dFFiY2grdVFjOFVCN3V1YUhEL2VEVFU0YUYyVFZnNWJ4?=
 =?utf-8?B?a1RoODZvVlpTT1phck1TMXBLTGs5b2IxZzZQTHVqcW9BK2hGK2JxN0hZaDBO?=
 =?utf-8?B?WjVkdG1xN1VQWUdNYmw4c1FMMGc3bWtGVWQ5azB1Y3lMeUhSOXRwcEkvOHAv?=
 =?utf-8?B?ZHZ5dDZJSEFTaXhQNkN2ZTY3VFUvVGo4Q2sxdFd0TXFhNURteVhXOGJVK05Q?=
 =?utf-8?B?cDRRbFFFeFNldVNRQXdEUGRVaHkxTXlXb0NsRmZSNGRlQTZ1cTlpRk5nTVYr?=
 =?utf-8?B?UER2R2R6K2NVRTJKQmoxc0phUGg4VkozMnQwcFcyRVo4dFUwaWFpQ01tWURM?=
 =?utf-8?B?NVN0SnZocDVOZmdCbUw5TGllMmF6SHVJT2lFYTNSOVBJWWN6aWl4VG9YNzFh?=
 =?utf-8?B?NnoxNUdhMGZVcWMraFNtdDRJOWFkWGFDaWhZbFRNYS9FMURHN090UnhvSjQ1?=
 =?utf-8?B?UHA1TE9DdkdUOW9qMWhpTXpjZjl0YnEyclZ2VjRRQjdyYmorZmg5WE9KeW1F?=
 =?utf-8?B?UTIrbDFvekN3RzJJYUJoZm5tOVRXalpQbjMyMGJIc1lBSncvOGxhWGtVTmJI?=
 =?utf-8?B?TElZWFFBUytZY21jMkNvOXVkb2Rsbmp3ZmVjbVRTZHlmYkNpMTQwMjVTbnVu?=
 =?utf-8?B?MnVacVphYndqVjZyM0d2djlXaG1idzJHcEE3d2hvNWVMTTVPMy9nZ0NGZ0Vm?=
 =?utf-8?B?MWdoTmt6ZHRYM3VpNWhtWlR1aXA1bmxKV0xHK1JhWnhGOTRuc21aOU9BVHh5?=
 =?utf-8?B?ekdnSi9SYVpBSlljWEhMRUdPaXJYZ0ZuZDg2SnlGYmF6VFpUcTRqOEtEYk1E?=
 =?utf-8?B?cWpXK0JueGdIZmRXcklzWUs0VU5XSXZMbnNDZHBOVVRKMjVPdkdTK09UY3Zn?=
 =?utf-8?B?MXBiSDNZbmNkckFrY3U1Y21PVHpicUJMdnI3QUM2Y3dZZEp2blI0YU5jazJj?=
 =?utf-8?B?MHlOelVBOUlNU3U2UXVXVlFlSHQzV1RqZjJROTlQbDE4NmRSVWR6VjNHenFB?=
 =?utf-8?B?MDZBWDA2NVVhVkNqK2dMcDBUMSsxQnY3WEQwSWh3NHN0d2lUeHBrdkZuUXNJ?=
 =?utf-8?Q?Z5tEfmkofXRt4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmcwYTJLNnZuR28xQ3duRUk1c2I2YmlmOW5GOW1RR0pkM2ZhSkM0eTZTWFAx?=
 =?utf-8?B?aFBIZjdXamJqNW9HMzFvSDJJSGIxU0xPZDZjWHVCbHFpSjdIb2pDTk1jRytT?=
 =?utf-8?B?R3oyU1oydGMrbUZWeG1BSHJYYlJQQVBMdnNtZ3ErbDVHZ0JRMWdhbHB2MGps?=
 =?utf-8?B?QW9Qa0kxRWtmK3Y1TVFpeHV2L0JpZVJ1cURkS0FBckUxaGprc3o3VlEwb2Jk?=
 =?utf-8?B?YUwwajRVOXFMMlY3cUMzbUx3b1RUa2cwVXZXNUZ3UCtXc1FaUCtsT2Z5YXV3?=
 =?utf-8?B?TGNDUU4razVFTXJQTnJuSFJUVDZWakN0L0t0RFFsUzJ5NWZyWDZsSG8ydzMz?=
 =?utf-8?B?UW0rQjJmam5HOFlzQWs4VTh4QStSaE5aTURiRjRnQW5nNFhpZm5zSXAxU3Yy?=
 =?utf-8?B?UE1Da29ZVXF4WmJQY1d1TEtvUEl5a0NjcE9mM0UrK3BXejdwdGUyZ0N0MWJI?=
 =?utf-8?B?QjFLNy9GNlFKSUR5WlRjaWN0ZzI0bDlaSmZGZzBqUFhLcnRuaEdSN3JLanRS?=
 =?utf-8?B?WnhNRTFBVUdrZm00OGlYSHhPWWtJaDM4UW5WYmUyTEpqbzRPK0l1WEszYjJR?=
 =?utf-8?B?NXdIaVpady8xa0hxY2twMHdxdHp1aU1BYy9zZlVwK1hJV1dRUGdGRDZ2b3px?=
 =?utf-8?B?Q2hzVUtacDA4eDg1SkkrcXlvc1R3b2pXR3c2Qll5dE1ZZDlZMHA5VzFBU1lU?=
 =?utf-8?B?L2ZKdGZrV28wbFVsUmxZYWFDRC85TWVyazZURW5hK21RcVZwUEZLZXRPUDlr?=
 =?utf-8?B?dnJSWG1kb1A4eldVVjI3MW5nZG0yMWxxbjZHZ1RoVXNCaW56blBBUDd6MVNL?=
 =?utf-8?B?d05QYkRlZzJsTXBRUWNDWUNJMEpKNFQySzRQV0VSQVZSZkJ6MDZ3YzlseVRk?=
 =?utf-8?B?VTlCdzYxa1FnSGJVa0g1K2RZdVVSQldSN01tR1VYaS9uYjVxMWdrMXk3N29y?=
 =?utf-8?B?eUlQdXFiQWg1cWs1Y0gxbC8welFXZlB5ZFhKeVZxZjhiK0lIbVAxQllNWkhr?=
 =?utf-8?B?d05ENEtGdUdwZlJMZGlHWkRsN2x4LzZhdlJEWVNBL2VUYW1GU0taWm96ZGp6?=
 =?utf-8?B?S3ZtK2RwNi80b2h3ZmJKUncvem1vZmNGN1FsOVU2QVhLeGNob3Jya0R3ODR3?=
 =?utf-8?B?WG9nUTNicE1mM1JDYVdBdjMzOFRHQUw4VVU0SkZtL0hPVzVnK0p2bTdTd0JK?=
 =?utf-8?B?S3NoVTRnaUkvYTZlT0lsVFdsazhmNndGSlVhY29TVEp6LzJ3bFFtVjZyVmJ4?=
 =?utf-8?B?Z0dWbkxSMUhmRXVpN0g3N0cxWkZaa1NBUXoxNkEwQzhya2diRnZwVHdZNXQz?=
 =?utf-8?B?WE8wenVyc0k4Um5CR29tV3hQNG5PVUZjZitKSUVaMlRpdkdFbkg5ZXFFcU1k?=
 =?utf-8?B?bEhYUzc4MzZmRXNSWlN1Nmh2VHBodzh3TmRVOW1lWGd3cFFLSnFodm5YQjVq?=
 =?utf-8?B?K0NzUTlYWjVCRk9ZZnVMZkNwR1Zmck56TzgzeUtCMWxYVmNNOEJPMEQxL2hh?=
 =?utf-8?B?UnJrUGw5SmtsYlZtUGY5c2FlMkpGaVBxdVhyOTU3aFMrRXdxUXNCbFU3MTA3?=
 =?utf-8?B?MlFrK1JBQ3hWZmZQblJGQnpSbjNETE9SYS8xdDdpSW0wNUU3YkF2SXN3YnNS?=
 =?utf-8?B?dE1aTXcyR3ZlNHBYSGdXNGRDYVN2Z0NFTHRWdWh0a2dZTlloelV6eFd4OXdR?=
 =?utf-8?B?ZzRlMzdxQkMrYTlIOEs2alVialhlYlU2a0QyNUpUbzhhMjliM0x1OHpGcHpK?=
 =?utf-8?B?L25IckZpbWp3UGV2RXlkZFFNTFhxWUZYUysvdmtPUFlJQ3ZVZ2xScnV4S2Z2?=
 =?utf-8?B?ZXppcjhLV3VQNFo0dHhJZ2t0OXZoRXVoZWt3M01NdTV0d0dBZkxnSDcrNCtE?=
 =?utf-8?B?OTdZMUxpN1NwSU5TZjBuZDAxSE5LQkd2VWF1RWdMNGl2c2FBQmJvNEpZeVlL?=
 =?utf-8?B?aGg4L0haV1pXSEkya3FTV0tTdzlxOW1hcktJU2trdkFpTUdiTzR2SEt5VVBR?=
 =?utf-8?B?NmFibitBamtjMGdxallUTG94ckRpSUhVZFc4VGRTR0g3Y0ZKUmo3ZTd2aUNG?=
 =?utf-8?B?cVFWdS81dUc0ZUhXcFR6WEd0MzQyNmlZUHdvZ3FrTFFQblFHWkRpMjRRN1BE?=
 =?utf-8?B?WngwUW9EYWszUGcxUkNPN3F0K3ROWlRCV3NsMWw4eG13dUFySC9SenJicm5D?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	86qC+BSUppigQAWbM0ttgNn1Sq7GO6uvGPMOPrkBk1lUbAZiifKQuw95mGRu2txzxt9S8Q5W5z1Cd/5Apod9CD4RnxzFXfYEIWBpYaMxgQgsKIuUjvVTyh8QpcylDyLKEiy1jAvtVdQvB6HTQXR1jnApXd8Y3P7ZbevEAVnDiVaDFX9GGluTfdNvExRuhx0NjpITeKvS+WHHXF73bwsJqNGDaYy8/22N2Rkwp3zUi3dHoIMKNEsOSi0u2k28TCRdIv08cMH3IkzrVrT2qKMLSgnj7c3X/m3Zaq1KGdWOthRTYMVhwY5GKZYz4yqwenSEB5qu79kub/bDkyhVdGpuM3nOTLe/lzRpY1894YwLrElbSlPz/ddExqCA9HCtsr8uJaB14rjUCpsvfpENyUgKDpeoThbe76mIgSckmbMwnZeqsZuilcC7ciiT1HYCKYIJDClbzb6I5Ul9GFz2coP3ICMH9XZcFkooBEX0uUofceDkNXx459rIXMxzUXoV8yRnnUOWOeSolr1M/yC+B+dtyEBaO49xS2NJ+F0k+t0M6uuuCxEEUCjb/22PgMBzrTBxVFkbzzNhIhXc87yjPLDu1ekQdNFDFmX0iTy5+aG4Rww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec43bcd-1432-4d9e-48c3-08dd5585f203
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:19:53.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COQsIrHEkIQjyfDLSzLk44LvFqTlTj0wYYnRhJVc+cZbSwL1ILqP4QGr43eiXrhvHiQmBG94awCM5NVYDD3IxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250072
X-Proofpoint-GUID: VMDvAN1dcaJt8uLP99rFVTG7sO5To-js
X-Proofpoint-ORIG-GUID: VMDvAN1dcaJt8uLP99rFVTG7sO5To-js

On 24/02/2025 19:59, Darrick J. Wong wrote:
>> + * ``IOMAP_ATOMIC_COW``: This write is being issued with torn-write
>> +   protection based on CoW support.
> I think using "COW" here results in a misnamed flag.  Consider:
> 
> "IOMAP_ATOMIC_SW:

ok, fine

> This write is being issued with torn-write protection
> via a software fallback provided by the filesystem."

I'm not sure that we really need to even mention software fallback. 
Indeed, xfs could just use IOMAP_ATOMIC_SW always when the bdev does not 
support HW offload. Maybe I can mention that typically it can be used as 
a software fallback when HW offload is not possible.

> 
> iomap itself doesn't care*how* the filesystem guarantees that the
> direct write isn't torn, right? 

Correct. iomap just ensures that for IOMAP_ATOMIC_HW we produce a single 
bio - that's the only check really.

> The fs' io completion handler has to
> ensure that the mapping update(s) are either applied fully or discarded
> fully.

right

> 
> In theory if you had a bunch of physical space mapped to the same
> file but with different unwritten states, you could gang together all
> the unwritten extent conversions in a single transaction, which would
> provide the necessary tearing prevention without the out of place write.
> Nobody does that right now, but I think that's the only option for ext4.

ok, maybe. But ext4 still does have bigalloc or opportunity to support 
forcealign (to always use IOMAP_ATOMIC_HW for large untorn writes).

Thanks,
John




