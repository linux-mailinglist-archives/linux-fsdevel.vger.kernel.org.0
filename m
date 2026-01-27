Return-Path: <linux-fsdevel+bounces-75648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK/yAmQieWnMvgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:39:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197C9A63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7773030E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296D32F747;
	Tue, 27 Jan 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYqtVFcU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXd/MvMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419F230BE9;
	Tue, 27 Jan 2026 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546331; cv=fail; b=U2x9MbmogDpTWWOXleQLj7t6VBa9airBheuDa70ozoVFyl5s/naTaneGX9ytuSuL3HKh7Mx9O0jpG4SYqf3/yDaqZ+K7WhCRVcoXTcIrK68xw3BsDEzBhDnwEqLAjPGqy3CjEupACqpypN6Cw/h1bdMj6atDB8fmT5x9wjNHO4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546331; c=relaxed/simple;
	bh=y3uLZpj8zm+rLdTZMSyoWvolTHbPwqXuFg3/agIlMkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLML76OJfnuaU5IjbQ5V9PUd92IyOWaC4vuGm/VWePq/N50NChznse+xMVU3TcDr2eIVvQr6NQk00jyXm0LBKreJ1oFDYDyhsthxjDdG3ljHiKuJXfChlkjWYWkL9WmeeVsfWKe/BAIF3s35IRpud3IgQM76cu7HmUAyUp9Tb7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYqtVFcU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXd/MvMV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RJwE5g621775;
	Tue, 27 Jan 2026 20:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lTFfS0PswHCSRu7Lbj0Y6mtY1g5YGgQE/d/y6UKxHbU=; b=
	EYqtVFcUWCtPEyGdZxODm7RTAAeeV01vyvWWp5/FQSEtxMT6VmBAPmGkLSQM0s17
	JafLcB7lLyQJtuXdNKddfjfv2UUwupSLKtd0KBGUgPVkV27yuVOa1N3feF5jbof+
	XOxE2PAQ5O8d6zzBGo+BHDiqBub0cSM2iRhaAGC1OAOqJHUOY2XU4PHMf1D0f3uB
	RyHfKRx63ycHa4iUcF88qCjpkxeEb1DqzXYsjBD9zW+AETtxXlwqz3ksveEPHmDG
	i6+Oh/JcnsVBxnIdaFiPkDFuDCiLZUFSd0DR98P3KAefZjwnErGQ2srrhdjGSACS
	rR03FR7Lc6r/CBO3eF5zJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbvunj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:38:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RKJlWb019762;
	Tue, 27 Jan 2026 20:38:36 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhf8uvk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0rrSAm7R514zsF4CTb7km1VYApTT6TTunA5x3NOYQ7wCROqrhrfZHAxsGP3JeO0V72jO2GH482bbMpB8G7nw+AxKz6Nmmm01ZN1opaLgZzqlZ4fQ2uCc/YHH3TTru6EiSNzDTboF0/yVdmwsVp+iCeG/cIKZEOVhJdBhyNPJHM/CuKj/nfXvYQE337yoXEz1GhhbW8KmccJLF8QUpFGmdckua789r6iBW+AsIe7gVJs33ViwE7tJKnzMzmPBVVsPlldfut3TvFX4jOBzTZhq37gM8mTM4CNeieKvsuWWxo7T+betq5l9LQXVqQsJKDDSfWwLEnuIvZtRTUtDQN3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTFfS0PswHCSRu7Lbj0Y6mtY1g5YGgQE/d/y6UKxHbU=;
 b=XVGygq1li1ego2qToLc7Q6il0wtxwWnme4yG/Lq5bN7pB8nt99VQnQdsBLpwEsbayqsTSgYORn8wCCjn1+INIbUlPFxoEOvOUps3aDB7yhZBKcSuXxVJ6smA4B6ed1etURZQjiVnCGOX1UhLR6Gjg7Owhu9mlqfCLivc7gcA7tR1gtbLlqUN7jQ7/1KC4pAddLkPJl1RPJLrdnDIctVjpeK1/bboLFhaADR/nFlW+xgxyLEck9B/hyG+6yM9Ax+Yly5UF4se3UsrDl6T/KbbFn7biRMrG8aNCHwOgt5dApHK773co8vVaaM2DCmGeWsyjpNcBAh7+eC4BgeCajS8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTFfS0PswHCSRu7Lbj0Y6mtY1g5YGgQE/d/y6UKxHbU=;
 b=aXd/MvMVvd5ofSPW/yBDYyWUIZIkS6yxoXTjj6YgIeRTZEEh0OXu+xMSmpPRSHJjAm5dzjxMTeFnBnRtoyt4OtBqu5Mcd3e7G41lT3yNINM1QntFN2pld0o/wcP9L8LGVNn1FVoxr4+B4oD3T72qhhPTt66Bad4Fj793bO7xDfw=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS4PPF109C7C399.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 20:38:04 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 20:38:03 +0000
Message-ID: <93798e6a-671d-4cde-a31e-4fcffa0ea5e8@oracle.com>
Date: Tue, 27 Jan 2026 12:38:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <88a3edc5-4928-4235-a555-a7017d5ca502@app.fastmail.com>
 <d4bcac6c312a5ea1691536e9b029fb00d8c77cac.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <d4bcac6c312a5ea1691536e9b029fb00d8c77cac.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS4PPF109C7C399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a81e1e0-e55b-4eb9-0bdd-08de5de3f7b5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXRhTHFVV2QxaTFXd0w0YVdiZmxMbmU0SC9SUnNSVXZpTlNBRnBxRnMwemRD?=
 =?utf-8?B?aWtvdjVjZzBCNUVYRWcxWnMxdkJKZlVSb3dHYnZaYlBmdFB5Y0Z3NTRqa3No?=
 =?utf-8?B?ellEN1kwT3k0dmtOYk9BM3pYUnZSTk0wUDJUU0RadW5iNWxuaERSc2Nxb1gx?=
 =?utf-8?B?VjBtVldPTXFrZEVpOWRZakhJZ2Z6QTArYVdGd0xiR2dLSm1na2cwSXpSUG9K?=
 =?utf-8?B?VXFoVktiZExPNXBVMU9SdGdMdEw4L2dzdUhpaU12YlNHZmRvZnRvMnllZUJz?=
 =?utf-8?B?YjFrWkVLT2NrbTdoNjcxZWFtMUhxWkJ0c2FweS9Ja1M0VDAxQ1diSGgvNEpn?=
 =?utf-8?B?WlZhMDVYMmZlcDR0cXpNYUxZY2ttK2RwdEp4aHVTdmZXSVJzMWQ5N2pYOVJ3?=
 =?utf-8?B?RkRsMDlEbzdGMzEzTVpEd2RjZk45SnptSU9JM3ZYMWRRY0R4TjNDV2V6S0ls?=
 =?utf-8?B?cWt0UUlMY0IwMmdFdU1POVE1SzhHbUJGUEJ5N05pZzQ0SUxCcHl3eFAvNnNu?=
 =?utf-8?B?UlVrM0JrZ2phN0ZOa1hiejAyQ1JQa2dVT2RIWFZqR1JCaDcyRnBhTEErVWFl?=
 =?utf-8?B?VUFqWXBRN005NXJFeFlWYnhhNldiYk1Ya1RmdUxRREN3ZkQvdEVCd01ESWtS?=
 =?utf-8?B?Z01DZE9Oa2NjRVBUb25LdCtFdTIzRHZGWjNqUUtWRm42dUU0c0NBZFNBVUMy?=
 =?utf-8?B?ZklOSDQ3NzkxTjhQeFpnQmoybitqU0VIZWI5TktML1pmS0krbW5KU2dGR2cy?=
 =?utf-8?B?UjlFcnV6bWFkMzhuQUpLNzh4QXgwYllBdVEydFlOYVFEUkM1Ym1oL285Snoz?=
 =?utf-8?B?QnBPWDk1eGtuWmRIWmJsRWxXZmJNR3M2Q1YxSjUzMEJWSnEwcWJYeFpFOUJ0?=
 =?utf-8?B?enZXOUd4aGVIa0Z4OWM3SENaZnlxcUkxWDZ0ajJzRFh1OExiK3Y0MDliY2J0?=
 =?utf-8?B?bUdxY1pHazFoa0t4MGhxQWJ2VGVTNVhjbWp2YUhQSlRXOUdmSWRnL09yVmJD?=
 =?utf-8?B?V1hsZkdobjN5L29mYzRaU3RvaGxYOVFMYkl0QzY1NVd6UU5sZzQwR0FndzJp?=
 =?utf-8?B?d0IxbE1xekU3eGZvU0grQUlWaWxhbk4xS2lmVXpBRUhnMDZFWkZqbXVyZlFE?=
 =?utf-8?B?L1lycmpxVHg1eUZmVExVNG9vaDJRdC91eExpN1JOWURuRUNkb0ZmTU4xbTBt?=
 =?utf-8?B?L2FRUEZ3NXVxTXZ5eS9lRUttbG01U2RXYk1UaUhIQUtxaU4yOFV0MVFCYk04?=
 =?utf-8?B?a3JLSW1rYmpLMGVWemZHSUVVbkhsbVV4NFYrYVgyRGRlYzkybUpJOWovZG5v?=
 =?utf-8?B?WDFxUnFzSk9GelBGVzJQcExDa1VTNytQT1lTdXdScUZIUThXVVExRENLTEpU?=
 =?utf-8?B?Uk5TRG0xOTUzM3ZkSDlYL1RLNGlrV2J6b3c4QVdCRWhHWUdDMFdXYTRCNkQz?=
 =?utf-8?B?bzRLekE3cU1pYTNYSXdnbDJvZnA5MFNtWHBtYmJVWFBTQkpCSGpqdklGUnR1?=
 =?utf-8?B?dHpPaWdoMURHWWRHVkhkSWZRQzUwS3RkNEhjUFZMdEN5UWdmNG02dWhJMjYy?=
 =?utf-8?B?czMxRUZRUVVBN0Y0OVFqQ2MxY3FzdlhjbWFBNVFjTGpIVDBYL085c01URHps?=
 =?utf-8?B?blV6NWsxT0NZTnFOcy9sUW5MVitCeUJxdVZPV0xjKzc5SUw5dXhPWXdrenJo?=
 =?utf-8?B?SVVWc1Vxbk1ZbmdyaDQ2ZzNuM1JaVmJIZWlVWkszOUpuQ0JnUjFnRFRaVDYr?=
 =?utf-8?B?V1NOU0FhYW9pSnk1OHZ1VEl5MVJ5d3VaVVBFY1NaNHZIS0JUNjN1QVBJMmxz?=
 =?utf-8?B?eTJNV0dONzBjU0xXaXU1ZGRVdFQxRm1QU0VrR3IxZkh4V05rS1R2Y1FaVERj?=
 =?utf-8?B?bWRNYS9aK293NWg1UFdSbXBrelRYL2xGS1BaVzVSSjQraTIvTENxSE1ZdUVx?=
 =?utf-8?B?bElQVG8xeEU3NTFHaktPdEhqSGNHV2Z6a005U3RGbFhQKzkxekpFZTl5OEkr?=
 =?utf-8?B?VHdxL0k0OVV3Kzczc3FMbXNGallBclFEVU5yU3BrT1Q0WDVNbjl0aVZVbWxB?=
 =?utf-8?B?TnhEK2dKdWIyTGZDYTkvakI3dHdwaDRHVG1WbzdYQnQ0NlhHNzZDdy9kaWJY?=
 =?utf-8?B?UHVkR0xRT3ViVDVOT1g5dGlmNi82WnJVSzJScXVjOXhsVGlpL3crc01NZkxp?=
 =?utf-8?B?dGc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cUlrSGVGWmgxWUN3cHRsNnRoelRWbEptVmNGa0VhclhTc0dHVm00dHlIeFRy?=
 =?utf-8?B?NXExcDJpNHVoVGZjUmdMb3NncmlKSzQrNVRRdDdPSUJJUzVZVkpVZTNTdWZV?=
 =?utf-8?B?OGRoaTYzS0xUNWhUR3lWQ0k3VG4vVUp6c3Z4QTUvcEEyNUFRa1hGN2d5R3NP?=
 =?utf-8?B?d3pWOWkzMFNSSGpyTU9vTkw1Y2dvV0ExUjlBZmdKajNXekx2WTRuS2lNdFlp?=
 =?utf-8?B?eWNNeHJoeHoyOVl3TXJYUUNLeXpYU01ubktBa3c1L0swbXZKaWxvMitsbDRU?=
 =?utf-8?B?V204OFlIOEZpcUdzYzlTenBFNm0va2ZrZXlxYVBCUUdEQ2ZON3JuQXBTTEVV?=
 =?utf-8?B?VWxDN0VlOVYxSElxRTBTdVRVM1hXTEtzNDduM3RmcFNxS0Z2VWVoLzNtZW92?=
 =?utf-8?B?cmNtSEc3ODBKN3NpVm1uRC9VTUk4YVpvZytHS09JTGRKZ0J4TUV3Mm1mOXlD?=
 =?utf-8?B?cWM3dElrem03MTFXaWZGcjN2MHljS1RIanllL0FadVRtRUMySk9IRHJSVy9L?=
 =?utf-8?B?ZFBRV05ZcjR2aDllU1JVVXV3RmtHdGxGMkJOM3dKT3NCODcwaDIva0lGN0ZR?=
 =?utf-8?B?UE5XSlM0L1l6TDd4OC9jVnNBdm52cjlUeUE3K1lTRU80cEVTY3cyeWVIcFdF?=
 =?utf-8?B?bEEzQm41TDBQVmxqeXFZOGJRSzZKRXJzNExVTmtRVnJpaGhiMk8waVlCMTFa?=
 =?utf-8?B?QWJVa0YvYWZySFJDY2JXUVhFbG1zdU1RZDNUSVFjSzlZL0pCN1U1UmMrNURN?=
 =?utf-8?B?WW83cnR2K1dwWUxNaVk2Z1ZoRXZOV3hkWHRqRnJYcmlNZEt6TGtlZ2lqSStM?=
 =?utf-8?B?RE53OTJVdGdrYTBnU01CVys3M0xrakkrQWYxS1FnNTdVd291YjQvSytYK1pS?=
 =?utf-8?B?ei92R09sVjBncC9YMkIzZ29TRHhOR3dic055RFhvUnlTeTVUUTdncFBJYWZr?=
 =?utf-8?B?V0VuMGQzMC94eWtiNG5Na2dJM2VpR3RiazlJQS9CamtFWGthVXlDMVErTGNn?=
 =?utf-8?B?VVlnVVUxbTN6UW16amk5V09mRTRPUVMvS3lJMnRJQW0zQmNNbkJtdHlhSnJX?=
 =?utf-8?B?VWJwaWNlRk9nVXRPUS82RGp5dnRhZEVPR1o1eFVXN3dyQVRzcTh0d1ZuQVVt?=
 =?utf-8?B?K2tVdDdxL3htTEFJbm5vL01oSVJVL0J3WWtVd0hwaVRYVEdFN2hpbTVqYkFr?=
 =?utf-8?B?TFFTekNwMEhXU1BYb0pyS1BQZ3V0d0Rtek5KcmpxcDV3WFNLWXd4OUNzckpw?=
 =?utf-8?B?U2lNcW1KL0s4enNwZnpLTnRnU2J2MVVsdFBHeUxkMEd3ZGNTcWlNc25aenB6?=
 =?utf-8?B?YkJsOUxPdFlxc3NCaHRXNXRGSDRMMkcrZVF3RlpHQm1lNFFJamN6WFVKcnZV?=
 =?utf-8?B?MFRlMDNNeFFlRWw4VDQwUDg2UGJWaHExc2tuK2RBRGtQUjZqV3IwcUdoN3lj?=
 =?utf-8?B?K1prVStMRUNOT1pxVkRmOUNzUnl0cHoxYm5ydTJVTFpRUnJrUzc3b1M2c0tH?=
 =?utf-8?B?cEFTR3YzUE1aQ2N1MUNIQ3RDdVI1cjlTc3Vic0hmTm1qRDNRYzhlUG52REhk?=
 =?utf-8?B?K0pXZ3k3ajJSOHl4emhjRHhsV3hRY1VBVmlsclFLWUVyWnA3TGFJV3BnRWVy?=
 =?utf-8?B?RFdpa3UyMWl3QzdLSmRhSkQ4UDhrT3lMMXdpeFp1QVZmdW5YUm1TaUI1TDlU?=
 =?utf-8?B?NFpwYVVGUStCV0Jqa1hDU3ltNTBFaXVqZXh5bmt5WWhmSEphN2ZKMy9Ca2pF?=
 =?utf-8?B?dVltcEFPS3ZzREdUVHQ0VXNRbFVhT2ZBemhseG44Tk4yU2w0ZEtTTk9QNi9C?=
 =?utf-8?B?M2UzWHhNTFNtN2Vibm81L05WTkhkNUdGTFliSUxRMGJhTUw4K3c1QzBDUGIr?=
 =?utf-8?B?TGx0eEhiUFZmWnlna2RncTU3Q055dXpiK0xsdG9BeCsyQ0NzS1VoMmRJSlQ2?=
 =?utf-8?B?eHp4R0lpc0sveUdiZU8wOFo3aDNHRWxJYkw3OUpTU2xOdDhVcENtRVVhUHg0?=
 =?utf-8?B?czFlZHNqNDAxYXBzdkJJWDNoazBrdmgzbHN6VXQralhxZGw1RTZhM1ZwOVJo?=
 =?utf-8?B?ejRYVzlKZVI4M29DWnZuMmNmdVFwVUFmRnQ2T29MTzdFY1NYM0tCV3ZUMUlZ?=
 =?utf-8?B?MktqWGlXREpxZUdYQjJpaTJsdG0zdDAxMkU4NnYrcmRoeG42V1ZEZDVzenJY?=
 =?utf-8?B?YS80RWxSQi9rMnpCNy9oalE4Um4zY0VubWtIQVFNcHBTaForWk95REYwdjRZ?=
 =?utf-8?B?Z0duSFBJbHhFZ3Mvd2E2cUZielRhM0owMGV0SEhUdXhiVXF3MTJCQ2JjVVk5?=
 =?utf-8?B?YXZaYkllc2MraHRkSllscFJvTzVWc1FsaDYrVWtkOHFpeEZqeEpvdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4n7yL70xubJxnP0GrmB86ZFjcleKwC3M/2c5jfy1q2shmTRjs/mpGfbmS4EfoBLVbBvZsxWJGmFn0u9yjVDUPQ2SRd1h7n9iNDxQ9E5j0xhj+RhiHL4EDfwmPrh4uxm9BmTRk7Nuy5sOIVkMw52ZUAbf6ry66h9Lib6Jjcmyr6xeQhzfH4RKGY4l7wNb4mbnhXF1wSwesPTAI8PRPumcZrfjgHS9Z4HaQbVGKAP/HIE6X14sbKvdd3Z5m0pAgGsOuJuoVTa8GyNI5NdVhHgIehc8Yy7CSoPIVzAjSHETXyMEcYb+Ybsaf6qZFW/s4Lcz4j2Lsgl9k1kQT9e03R6EJ3ej9rz5PDuZipQH0YMCza/8/8UeSYyxltAakkMEmIdv6PAEuzkhNf23oxmrfzNuCzzi9+s8tLQhQPzngyCP49KlY5/uyLtIv5vplDhWnvoVqBitQug4gJC9UDrD1KB1NN9jLzjBFi+dOsmj3CBnO1RQ+xrFo8C13kTe7wilqnAStH4rXXa9kDnlzmlzlKGs7ox6NxhrtfNQ7RMjusunVY+c62djs7g2ncSfLAD2S4mTKw6Aa+JeOLz8YROuhyGA252eutstLefbjfmX56VLr6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a81e1e0-e55b-4eb9-0bdd-08de5de3f7b5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:38:02.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtAnANECz8ESIVgOxyhNA5nerG/Ze5OyGRzVOzhntNQSSXhLBzoINOCGjx8NfLUP7TkPtJB9lSsCapkcIZEO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF109C7C399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270168
X-Proofpoint-ORIG-GUID: 7xchZ33XYNq2jseWHAbWi9pHGeNp0mWv
X-Proofpoint-GUID: 7xchZ33XYNq2jseWHAbWi9pHGeNp0mWv
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=6979224c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KqAWQ4ntwCd7Ca5LbgEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE2OCBTYWx0ZWRfX9Ze/whesFxRo
 jA6VZSZZUXE0e1nllKPx49W7WrrVwr5dQvjKc6qI8IdI/QHn0c/KmF5DJL0lhoj9pCWiqP4IMpA
 esG1fMu3dq9T6S6azh42WGnHmcyWURcWDvUKfOa+9cCnEEZf54XYkorQZ9KpaU5XRiBEDeTAJlN
 zSYi7FvgSc7IE3mlczarThB06tEkBzPO68vZtFN5tI9FT0PZSkyWLTjCnCFjbWDwS8oqtz4+AjO
 ccPXwkRB9GrdomU8zMwtiRAQ3z69m1GRWl52rxcvgp/w+VuN7CHPXwFCV5AojegP4OF+IaBfxAG
 3I4Zjs5IbaqgB8VJ4b0ZguZrjotRmxsI2Rg2K9MhyRrTZ82m9qDTG952VEX4Tslm4YLjiC3ht9D
 u00W0RkYRAkB14krytc3+VzctX10uBHvKpFglnjJhfA+O+AFw4q32DBKSb8vJNLcJqy7wX+mYDe
 LdlPKqrPCU319diyUBCaWAN0IqXImSNdNCK/W34s=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75648-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6197C9A63C
X-Rspamd-Action: no action


On 1/27/26 10:14 AM, Jeff Layton wrote:
> On Tue, 2026-01-27 at 12:11 -0500, Chuck Lever wrote:
>>> +
>>> +	if (work_busy(&ls->ls_fence_work.work))
>>> +		return false;
>>> +	/* Schedule work to do the fence operation */
>>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>>> +	if (!ret) {
>>> +		/*
>>> +		 * If there is no pending work, mod_delayed_work queues
>>> +		 * new task. While fencing is in progress, a reference
>>> +		 * count is added to the layout stateid to ensure its
>>> +		 * validity. This reference count is released once fencing
>>> +		 * has been completed.
>>> +		 */
>>> +		refcount_inc(&ls->ls_stid.sc_count);
>>> +		++ls->ls_fence_retry_cnt;
>>> +		return true;
>>> +	}
>> Incrementing after the mod_delayed_work() call is racy. Instead:
>>
>> refcount_inc(&ls->ls_stid.sc_count);
>> ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> if (ret) {
>>      refcount_dec(&ls->ls_stid.sc_count);
>>      ....
>> }
>>
> Is that safe? That's done in nfsd_break_one_deleg() for similar
> reasons, but there is a comment over that function explaining why it's
> OK.
>
> We'll need to validate that the lease is always released before the
> sc_count goes to 0 here too. At first glance, it doesn't look like that
> is the case.

No, it's not safe. I have to think of other ways to make sure the
layout statid is valid when the fence worker runs.

-Dai

>
>

