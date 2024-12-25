Return-Path: <linux-fsdevel+bounces-38128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F99FC623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 18:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86591882C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E813213E;
	Wed, 25 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntplSBNc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kgk2wbwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E74C3D0;
	Wed, 25 Dec 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735147455; cv=fail; b=c+Nv8V6+aoNzd5vT9Ck/W3QfbUF3lOtQ3nGSXYfZwopshazPnpYLY2NKlFW6lac9bcqKlEjNGBjdU8tcUT+Npx+qkXRTOsE2sHGq8isWjL784sFUjXfGfmIC5VLs/m1ld0z1dlSVzlofcr0l2zbFxYPa3rQSL4VSJX4FpoTn1eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735147455; c=relaxed/simple;
	bh=YdW9hoHgGV2MiC3UzlCITu51UBcACtjvzOwAJKu14wY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g0NiM6/VVbaqzP7mNjnZGrUHFHQEvZEXWIeQi5HdP8fzUoOV1eGeVqN882EY286u1pTRikdFx8UpOKwJvSwsBVMAP4OMOiHNZyEVZnFpdJOE2uT2OoWK+JktuP+9gxyaynHYcwO02oWFJ8f3yVepEhsagDsR8/mbJmFhOTnPVHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntplSBNc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kgk2wbwY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BPDNilv024626;
	Wed, 25 Dec 2024 17:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BzHlVkjWGYFkK36H9TE/btp2lFec8rq61PqsFgw9kLc=; b=
	ntplSBNcv0I3afoxpjOVqNiewuGZ6ck8hwQRUJ2eYwEcPv+8nFb6N+KRQ6KPu3uK
	YBypOOy3fMN8M58qUmn3FgZ6rDEzsPgpQujPk+dA87eXQJGbbKHotGAOaoi/UNDf
	WiVR6R9G+PfPNrLmLiU0MQTXkmrWUFzcFD5uIOulb2h6m5cixIOu6vh3CtZmT2Rz
	wwr7mKXhpsMDS571uMozovqJDVI1ZMK4pdvtTHt2LJ5eKDHQxCupww8q2Ybdf8on
	HZjrU21wBdRoaGfAdrI1PIjohwvd99S2fOd+fZKhxp3OXN0xDhPrjewnDnsiT18W
	fzTDi3GvmMhtuFvgG3V5Fg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43qgeqt4c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 17:23:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BPEjBNU023167;
	Wed, 25 Dec 2024 17:23:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nm48u48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 17:23:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n45607uGAYm/rqOWI7S1zPTtFwxmZFcN5PXSi/PBR9+iY4WZS8z962MGpL5LYrm7EdTCz+ZyeSdhT6JOXBokk+b0hdU2OXoyMcs8ZiVo5LASRjDLekv8Kj1cJXLtakJEPROfXhpVCUC/xsnPHQJBgkSfWPrjXPfYznGMWWZUzQX8pyEc6CeorrYC7qDAVnZ7wLKGfdfT5YzdgQYfvN59QkvBfWv+JBiMjrq+m82R9YXUcz1qZuvNzI9+Ld6Bj55OyZtyydc8chZmUI5xYoelOTHhEkKzEe/IXvP32z+xNEMZIGXffOokEqdeqHOPRzcbEmClj60eldrJW0ix7+HTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzHlVkjWGYFkK36H9TE/btp2lFec8rq61PqsFgw9kLc=;
 b=hRDqUY3OkUl5H3/fPlvtFanF3yUqg0IAyZSAZoG2LwSjSYNUMcMPwjxHbwp01lpKpp7M9TVHPNgJXOJMwEw8Ee6ZT4J2wyTUufYP/5U9Mx1BzJEOBXXFy7ZiRlQQL+FpUZbaWv6JJU2xPQg9n71UMcesrdd1W67hWNWrCAWu+m409jEgDiSDBj0Yh8+PlTrlbLcJHsv4RYlQDmBCtyCgXwROQjcaJiTRVvD6aeSAfretT2HAAHRzKd2fou+B+tF85hOpozejouSfdQctfqOv3QWF+h44RObvgKW2FJ4MHzZMbIOhzQO8CLejulEyVJS7MxekE2OMOSuYcygYdbf9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzHlVkjWGYFkK36H9TE/btp2lFec8rq61PqsFgw9kLc=;
 b=Kgk2wbwYZzywSc49s1t5Gsf0Tx+Lt5jKm9gnz4eOW7xUD4ALBlY61U8pL2lCpqFEHy4c4u9asVVzDAHy1ZFkoJsub8RtCt/KYEArje2pOGmqF4NyZnttkVPHJJP4a8GPpYlhEO74+gCJZNcWF80x+zjeJXFjxKvHXc6mk3dIBA8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5897.namprd10.prod.outlook.com (2603:10b6:208:3d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Wed, 25 Dec
 2024 17:23:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 17:23:47 +0000
Message-ID: <f996eec0-30e1-4fbf-a936-49f3bedc09e9@oracle.com>
Date: Wed, 25 Dec 2024 12:23:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [libfs] d4849629a4:
 libhugetlbfs-test.32bit.gethugepagesizes.fail
To: kernel test robot <oliver.sang@intel.com>,
        Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org
References: <202412251039.eec88248-lkp@intel.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <202412251039.eec88248-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0411.namprd03.prod.outlook.com
 (2603:10b6:610:11b::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8883d3-b411-46b7-312d-08dd2508e456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lMUDA2MDk0Tkk3K01KaDZ2QUZmVjNrMGlhR1N2b0l5MDR2Sm80OWJpNWMy?=
 =?utf-8?B?cU5xM3BsUkJNd3QwZ1dHZFgwQVBmaW5OMW53ajIvMHVjeDBzR3k1bzh3M21q?=
 =?utf-8?B?dTVXUVNsUXZEY1ZaYk1pMy8yc0ovSXNTODMzZnlING1MNEx0UzB2OGlzbHBV?=
 =?utf-8?B?a09RakVFdXdER3Q0c01VSGZqaHZ5S2FQcitIYVlWZHpQVi9vOTc1MHAwdWFW?=
 =?utf-8?B?TmZmc2s4MlIxZitjWk1pUS9MT3pnNlhoWXIzOFNPb0NkN0YzVUJ0T2lOSEpY?=
 =?utf-8?B?MWVWdWsxUFg1amZPT0NQaGRQTThqT3REd0twMXNydi9Da3RJSm50NEE0QmJM?=
 =?utf-8?B?MlljZHBUbk5LakNSR0ZseEQxTEtSVWN1ejNpeXA5c043diszTnBzV0FnZkdo?=
 =?utf-8?B?L1U2NTA4WTVUZXRXQ2xCMDY1MFVDZUxuWGFPZ0dDMDF0TjNpV2FmNjdxOHFS?=
 =?utf-8?B?SkFuVXVUZTBYQTZ4ZDRoUWFleGRCOXp1dkZCR0tWQmRrMmRuWVpBNVJOYXZE?=
 =?utf-8?B?VmJrYTFOWlJvbC9xNU5NcFZqT2w5Rm5xa1l0OVVLeUpBSnhiL3Qzc0cxVnNR?=
 =?utf-8?B?NVBaTEZ6VmFCTytoendEaTk5UjZkeGhWcDhoMkxwMldLVnVqSXNDNE43dm9H?=
 =?utf-8?B?aVR2TXh2blVPaUZpSmEwemJNb0JQSlRsYmo3S3Uvd1loTjE2MUJlcFBkb1ZB?=
 =?utf-8?B?dW5TM0paRU5IY1FlL0lGdElSbG5LanhmN3dIdGpXbkZxVXhPZi95MUhjNHY4?=
 =?utf-8?B?UThiSzRMYjg5clpxU3ZSZGJrS1JQaHIvbEEyRW1ZWGM3MGd0QkVHdUZmSktM?=
 =?utf-8?B?S1VaSlhYcDRlVlRHVE9hZmxFTWp0UCs3b3Z4WWZ4eXg0OCtPWGFDNWRsU3kw?=
 =?utf-8?B?UDQ5Y25NNVZlYmhydEdhby82ZmVMYUFaMHo1dWVaK3d5Q2JMY1R1cm5NYWNZ?=
 =?utf-8?B?U3h4NlRpZUQzZjZoUEhjM3RyTGk4R3hMNE8zU3pRMEtSQzIwbW4wTGcxTzQw?=
 =?utf-8?B?cExzOXNwRVJldDdjeHE4V3RwZ2M2S2gvRDBEMmU5MHYwVWxQdWtWZ0tXWTQr?=
 =?utf-8?B?THZwZ0l3Q1NyL0YyS0R4b0tJNitOb1habGhJR1J5aFdQbnkxM2dvM2d2OWc0?=
 =?utf-8?B?TXREOVlvSS95KzRTMVoxR3diS0VVUU5tODVtb3Jlc2tjRnlaL3RsQ09rZHN5?=
 =?utf-8?B?Vzg1Z2pHYUlQM01ZMndoNXg2MkRndWI0QmJLNzdIcHhTK0MwTjUzcmFvZXFx?=
 =?utf-8?B?SEV3S1M4NlJGeTh2WWRyS1U5QndOYmVKczM2Sk1vdXV2WS9Jc1ppMzJCRzR2?=
 =?utf-8?B?Q0szU2lLQ3RURWR6N3BWZTNkcmQ2UEFtOFN0cFRlZkNUdnBLcjFvUWlnQWlX?=
 =?utf-8?B?MWl1R1NnNzZEVTEyQUI5NFJaaHRweEVQS1R3Y3A5NDJFOVUvRXdhWkZlREVT?=
 =?utf-8?B?UEZzODBjeXMycnVwTlNhK2RQK0lFdUxNRFVGQTF3TGoxUFpjNzRxN2t1ZHU1?=
 =?utf-8?B?ZWs1Uld1dGRLeW03T2ZTMktqb3NJTk9LS0FPbVdhT2ZSbTdSZXl3dUZwNCtZ?=
 =?utf-8?B?MnV0VjhlMXd6OVF3ZFBOMjY0TlZIMjFsZ29zK3V5MElkZzh5ZDdLdDdMbC9P?=
 =?utf-8?B?aHkyK2Y5eVpwMDZoUU91VklNaGJjZVNaUkNSWnBvNm9mejg1NU1PbkNUTnZC?=
 =?utf-8?B?bjdoUzVseXI0Rk5rMHlKdGpMeVAzT0Y4cFNSTDdQZEkrUTRtUE9kclBidFFX?=
 =?utf-8?B?RFJsYmRaaXBRMnhUUWVYSzBJcGhZUXpjRTJLbUlxbSt1WU1adGsxY0tML1R2?=
 =?utf-8?B?NEhYa2RJaGl5Y1p3UTN1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUoyWno5MVVjQTVMbzU4QXd4eU4rOXU4M2VEbXgxTS9HaHp5NFpwc2hISTcw?=
 =?utf-8?B?WUNuSzZ6NlY5RC8yOEhXMHVTV0N0bWgwSUVkeDdNTitSZms0aTBWUWR6S0t0?=
 =?utf-8?B?VG1yUjlTL0tpZktRcDlweGhIM3pxbWY5R01XSm05NDF1ZHpJc05NV3J2KzMv?=
 =?utf-8?B?aVZOS2VSZ1NtSGljWVZqV0ZCeUdvVmxEMHdhbGRSZU10cjluYm5pL2RGUTlp?=
 =?utf-8?B?TXp2NnMxbTRDNUVHdlpEZjM2bmhFQlBLS3BYWUhGbnZHOE5BTHJCSW1JOU9S?=
 =?utf-8?B?S1E0U0Y1dDdXYi92TFZxS1RBUmFONUNjdURLRm80dGh1S3JMTWFOMWhOaGwz?=
 =?utf-8?B?SC8zNjZtc3RvQjJ1Wno5UHQvSzJQenM4OEY3Q3p4aDViSEJoRUxXZFpNUjNG?=
 =?utf-8?B?TWEvMlBQT2JMRUQwU1JyNGwya25PMER2OFBpVEtjUE16VHFWdlp4S0dIL2gx?=
 =?utf-8?B?M29FdjVoZTlTWEozOXdsVEt0VUJhb3gvUmtXdnRseDkwc0FhMml4VlRqa0Nn?=
 =?utf-8?B?UEpmNUJJWlhtL2lzNDEwVWR5NVBDUjdRNEFDWUhFVTRheW5NY1REYmN3TExt?=
 =?utf-8?B?S0Q4WjZXWHdMampoZHd4OHdYZ3dSWEhhSk9TSjdycG5uWUs3ZUxBSm1pckhJ?=
 =?utf-8?B?Y0pGQktQSWs1cG9OdEZGY3ZoMytZMnEvRmJWbFBHMDRBN2pBeHN0MXhvMjRw?=
 =?utf-8?B?SGhMd3htRUI3azFCaVJEVnZaSUtCZDMyLzYwa1lpZzAwODEyWmR0UWFOek1L?=
 =?utf-8?B?RSsrSTh6bHlmRVNlL1VLbmxQT3h5b0UwRXhtazFKMlNjLzdHZ3cyUG5KQ3hD?=
 =?utf-8?B?SHhwdFJGMG5CM0dUcWtNbCt4RWVmWUNiZDNRZm5OcE9yN3ROYjcyUFI4ZklF?=
 =?utf-8?B?L0ZwODVCQUJ3SDJpbGw0K1hqd3VWZHAyZFBJT3htcnVQQXkrTHBNOHN6WU5l?=
 =?utf-8?B?U1BYcFNBbHZ1dWVvbkM4RzVPS2NJSDhPMkJKWDFGeVRNN1FCd04vMDFQN0M1?=
 =?utf-8?B?SlFkZ2QzSW5wemNscDA4WnR3N1hoUW9jaFJ4OEV1TW0zUEsxczJrRkFFcUkw?=
 =?utf-8?B?WktZL1RLdTlZaXl2Q1ZtaVdVKzlXc1F0UjB4WGhvQlZIb0xHc0k0UWlYQWo4?=
 =?utf-8?B?THN6OUZwWXVCZC9uYTcrYmN4MS9BY1JyS1lHTU10WkExeXUzN0FUZ0ZWVldm?=
 =?utf-8?B?WnVlY2VrbndpTjQ1UlhSQkREbmtyVDk1L2NMeDg3a3VzcDhaVW82dzFTMWRr?=
 =?utf-8?B?aE91QUFDc05BUkJXOUhhUjlUNlJFYnpHRU5TWGRTQ2pscEhaVVVobXRXL05Y?=
 =?utf-8?B?ZWV0UlQxZG1NZTg5RUtCbVNiZVNHOWQ5QnBubGpHQ0xXUFFldFc2ZkJ4eUsx?=
 =?utf-8?B?MjA5VW5vRThFbEN0dTU5NTFPUDZhaUJWQzhxNkw3YmNJcEJwVXI4R09lQW1O?=
 =?utf-8?B?Mk5taWpGenU5N2czSmNMaThYZEtMSFZoV1ptWTZBbVlTNThwcVI5TmYrdTAz?=
 =?utf-8?B?ZVNJOFF0M0pWaUVsc0hFanVMbmRNRzNvT2RKSS82OW1reW5CZVpmRTQxU2Iy?=
 =?utf-8?B?OVIvTEthWXYwMExydkpIb2NJbit2Q0JPNTNxU2Z0eG93TEpOL285QkJzUVZJ?=
 =?utf-8?B?ZGkxQlVjVlMvTGNZTlpCN20yU0VwbjdDb3FEWTMveWxMVEdLS1N4dEF3S1Jp?=
 =?utf-8?B?bURpVHdCL1BBek5HdDJIK2tuKzk2N0FGTlZiS0xleUpuWG9vM1I3Zit0d2tD?=
 =?utf-8?B?eFA0bDJoRm8xL0lzTVdsZlpra0ZmYitSNzNJRldhWkhVa1JkZ2hRZDhMa0dX?=
 =?utf-8?B?REVaWDhYaWtPaTFqS2JxUDBNY28xb0RqWW04Tjh4R1BUbURSSUtYcm80MXhX?=
 =?utf-8?B?N2Rrd1ZxeGZGWjluRnJqcE9aWHo5YitRampPQjd4d1NoZnFJVzlLNWt4aW9J?=
 =?utf-8?B?bkRpcG1JSzFHdHJNUExuRXRjSmZ3ZEJFdXFvK21OVGRyWWFnSWxyRit2RFFm?=
 =?utf-8?B?VkNyZEdFZ0Vjc3pDMTV1U0lDU1RDN1JYSE8zREFWUG5xbzBOREthMDJiVU1O?=
 =?utf-8?B?OVhnQ2lyWENCN0pjR3VnLzd4cXVLMkpoMExCV1IzTFlORnRwbWpGTkdUQUhw?=
 =?utf-8?Q?ycMv/Y+cP0SK1E8L1WKVfK+Ns?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hGndpmrrhXce4DaosOarubvZnMWPhWYxjd8yCpT8YhweV5bwjEMyO2QOGwzvV/vg2E8FKw3zydTZR1aqA9ar0eIyGeDw4arPkbgCo3JkSLqZwQwKcAOoEdJ7omQU+6rSie053eaIrHxCKde55xUozI38PRfZFL2piPjNMBrR+CXxjIiwWzZvasc9gvtpt0p05ZifQuyELZC1rISpFJCOB6SwqlER/cHxytfhcxPONHO1CuTSZRRSU7lwJKs9IMvFpbNwBQmyda4p50uDPgFsJas0HekxeQfHfDYgFvjMpczScrCUyribtdWcMro16saZaDe0FvGtb1kmcUcvF7j/CYNWSREM2Z92wJ2C3pM2lmB28DdfAhE5f36mbkw1V/gVu/i6E6mk3LWSDqxxPC3pxya0ghZRnjDPt6JkXqX9qdlXWvfI2k+CuR7JqBptB84CmHyitlMyKTzDtCHtFJcHA7Us5U0Z9VSML0AE2D4Ah49knApZ6wuc3N2YTTmxcwK0qFHjKQUXU8Ps/uzPXdgTqy92AOwGv+ms8MLbdRxsnwX4HUZcubTsxt5BxDekg7z2oU9WikBNeoq08zYj4i8jojJMDvZmxQEPGG5hK+0gXwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8883d3-b411-46b7-312d-08dd2508e456
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 17:23:47.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkN58NypP12koVv321d8kLesrm4qW3c0hOCKd35UrMjK10dnHVJjiV8jsLspVppkoRkMtno8iJJnHbDakuJmBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-25_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412250155
X-Proofpoint-ORIG-GUID: 6jsUqA6f8Lrdd-iqckwVa8YuUq0dgHw8
X-Proofpoint-GUID: 6jsUqA6f8Lrdd-iqckwVa8YuUq0dgHw8

On 12/24/24 9:49 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "libhugetlbfs-test.32bit.gethugepagesizes.fail" on:
> 
> commit: d4849629a4b7dcc73764f273e1879e76497acdc7 ("libfs: Replace simple_offset end-of-directory detection")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]
> 
> in testcase: libhugetlbfs-test
> version: libhugetlbfs-test-x86_64-6ddbae4-1_20241102
> with following parameters:
> 
> 	pagesize: 2MB
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412251039.eec88248-lkp@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241225/202412251039.eec88248-lkp@intel.com
> 
> 
> 
> gethugepagesize (2M: 32):	PASS
> gethugepagesize (2M: 64):	PASS
> gethugepagesizes (2M: 32):	FAIL	rmdir /tmp/sysfs-fPtma7: Directory not empty   <----
> gethugepagesizes (2M: 64):	PASS
> 
> 

I built libhugetlbfs on my Fedora 40 x86-64 system. The test results:

gethugepagesize (2M: 32):	PASS
gethugepagesize (2M: 64):	PASS
gethugepagesizes (2M: 32):	FAIL	rmdir /tmp/sysfs-LcBHPv: Directory not empty
gethugepagesizes (2M: 64):	PASS

I also tested after restricting the directory offset range to
3..S32_MAX. All tests pass in that case.

DIR_OFFSET_MAX is returned as the cookie in the last entry in
a directory. The value of this symbolic constant is LONG_MAX.

I suspect that a directory cookie value of LONG_MAX (64-bit)
will be problematic for emulated 32-bit environments. Actually
any directory cookie value larger than U32_MAX is likely to
be difficult in this environment.

fsdevel gurus, any thoughts on how to remedy this?


-- 
Chuck Lever

