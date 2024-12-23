Return-Path: <linux-fsdevel+bounces-38064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91059FB3BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D0116655B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB11B87D7;
	Mon, 23 Dec 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mKYTZ0oL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i9WvPbqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0497F9;
	Mon, 23 Dec 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976495; cv=fail; b=KSn31g2V1vMB1siB0tic/spRmrG4IKzuGUZdB/cNEkSoZZ53HJDjRbnUK2QCSE2oAEm/76TH8L9fAYXqDV+9ns56/h+lnvUpx6zhQvD+S845N/asZ7vxfDKk93jwJIEzYuDe5cpX+N54CA3DDpTviK8OsMxnlNRal7ZkMn++8K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976495; c=relaxed/simple;
	bh=u3h/sMBisGTaSsvxdnu9gHRgSx7+BuHBjqhDDmMGIBw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PR15+1b27J168lffQNy7C72QrSKwADVvt1tCJjNLu32qSZF6u3A1Bi0bKHRvLnGDR3xH6M0FeqrmH9dKZTd8uHlR+JyLZM9EP9elrs8YlP3bB8CeEYeWa4JV42Poe7PRcGQV5CX7R+TwVBhlvJF9lLlSDTysphFYUlm6TmgnknY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mKYTZ0oL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i9WvPbqB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGumZ3011861;
	Mon, 23 Dec 2024 17:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nikNw+Y0VBw9wqP/wWQ0D6FC4z0rbfD8Q/IUN8LrVKU=; b=
	mKYTZ0oL5ZE1d7eJGV75qHc1oXmhfGj9TDOx44OFdaQPMuJjLOeT5ClP4y5RyRkE
	72UiwlLUJ+pC2HB4GbPPlsEKWOIqqGSrDQSOa2+1c39JSglQn5kQ8y3h1giZMEau
	UVdZNgs2YYDph9E8KQ/l6uEy6C9XEKGI8cMea0IRfZIHllg/nXZbor2P2JD8TNdv
	BSkBq8AxTHtqOLy3J3GXtMn7xSZ6PJK7zZiCSwuW2AE+9AR2vLNV4040igbbBd0e
	QVNtIVvc3cyn3tpms/cipsDr+yesYY+XbBqKrfD01fa4VBRMlsuiuTHq4TiQ5aKH
	KprI+ay/p6q2lvwz2DadBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rjyrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:54:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGIUPO004792;
	Mon, 23 Dec 2024 17:54:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdg0yrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 17:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVEQAdGfs5oLsW6+1ogD/s41k+/gayFLuAjuE7CnNxEi9xdZ6mJwDtnIwKUnGX1Z/0SFjjzPMR8xDsM/i48OP2s8n/Lma2JYGzvD7TvNZ0lctJIXMU1dFo38iPOL5l6h8G9c3a7EBCtTsibP1247Cn7L/G+RaSt+q+1khnT6UkNOH+f4fS4bUKUkM4M7e/VBtmC10BGZKOoovpwcM941sgAXM4j+5b2td+3G4RZ+WT2BewrOuU2X2W8aNhgByBq4efqCrWX18S1NhnSeI3Aw+NQqLErfg56Xq6u8ckpJTDGBcmsrHoCcRNWcYreYVlHHbjctU9vqdSH/pxXKEsvQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nikNw+Y0VBw9wqP/wWQ0D6FC4z0rbfD8Q/IUN8LrVKU=;
 b=AzvPKQAC/6xBqdsw5lwBLy+yPhVj6A7xRMJFF/mzNxNU85CrkJhAaAsLCIglQyGMeJfgr51ABsD1oei2r9m6gA/p6/1PXwzpKGKH9OraL9W6HT06lWF2lDuzApnToRnvWEAc/1fZfWBgxt9OWH4e/Ik5GCdfn94AmlXE80XRmydZQRjW8k7dIL1iOu3HXLgtlSL1igmioIdXExuJlwBJPWVeeO2gvJWlYG2zE4OKWL3La0adG9ra1633Uf6x86tEp1sxOiSlQN1u6c6btlUK8NOv7JXT9Wk5YylFzVlUNn+gk5SzCgOVFZb/tJ2HAiKBrpjwLKudHHVt//dIxKzXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nikNw+Y0VBw9wqP/wWQ0D6FC4z0rbfD8Q/IUN8LrVKU=;
 b=i9WvPbqBQgMHekUVG8zzhMOOEmJUEal1wQqzIZnXJtDc+YXxDbzSpQmsttEJw4bTw+H7cLLpvWVccMdkldRcN4wAYZ8Vt9uL+CkKz31nYPCP8Zd2AmH+6bzAyEhv+Y0cTkqV2aXJK1Oz8zKQvzOBmZhH3D57gR0R5SsO/edJFWI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8041.namprd10.prod.outlook.com (2603:10b6:208:514::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 17:54:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:54:22 +0000
Message-ID: <7b281006-7486-4882-97e0-1be789987f45@oracle.com>
Date: Mon, 23 Dec 2024 12:54:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, cel@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huaweicloud.com,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Yang Erkun <yangerkun@huawei.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-2-cel@kernel.org>
 <4kwscifcoyb6sp47hkcr67mzobthvgnf5dnqnu66bonsplhw5s@edczkt76er2x>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4kwscifcoyb6sp47hkcr67mzobthvgnf5dnqnu66bonsplhw5s@edczkt76er2x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:610:56::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fed1a0-1274-4454-04c2-08dd237ad4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVE4TGdYaVkzVlNFVWpnMjlXbFNuR1pEbnc2Ymo5dFN1V2FsbEtUSXZpOC90?=
 =?utf-8?B?cDFWTmJFSktHSVZmSmxyUUxPSU9FNXNEcjFvZFFUcUdHVktmVlBzT1A2NHA2?=
 =?utf-8?B?R3dlcE1hTktFSThOa2R0eGhSWEJZU1ZWd3lvK24xcXMwczRodHBNbWx2UUVM?=
 =?utf-8?B?Rnp4SERtSVM3bUt1ZjlORE5PMytkclZ5NitMcWF4VS83Z2wrK3h0bkFQMEN2?=
 =?utf-8?B?U1ZYSnl1dzZLRW9yaHFrRUo1L3Z3QThISENtekJjSEdTcERMcFUrTUZYem5m?=
 =?utf-8?B?QXNVV3pSOFMyczNsZzRmZCtRMlFSd3Fqc1pjY2w0eXFEcjFkeXRQNnd5ZTRx?=
 =?utf-8?B?TkRwYUxIQUFTbW1PYld2YlpOcy9zd3ErRXl3L3ZjZFIwdVNrMC9ub1djNkdv?=
 =?utf-8?B?V3FIVXExK04rcEZNdGRYQjc0aTlqellJeHJUN0FNWUczOHhqNzEvcXFCMDRO?=
 =?utf-8?B?YmhmK0YxbDNqN25PQm9mOEdzdGQ4ZFhxTGFnK2swTXk0d2piQWxPeWh2MG52?=
 =?utf-8?B?UUtQOW1PSHhub2djM1V0V0xuMFRqYnpmM2RtN0lEbTEwT2UzMDVnYzBEaFM2?=
 =?utf-8?B?bkFRNTJzeitzSlMvQXFDOUR4d2tyUHIwUzQ3QXVXU3N3S2EyK2hkVzFKelMv?=
 =?utf-8?B?ckk5QkpuTEJsVmZXbUtNaTVhMmlIYXZ2TTZpWmlHdGNrWkFBaHhtL004bUtH?=
 =?utf-8?B?ZHpSUStJdGRQR0g5djFvanRWQkpkRmY3aE5LSUNBWTdIRlVlWDBVM0FvR2FJ?=
 =?utf-8?B?M2FGQUVwcVJ4TmZ4M2QwTWREQU54STgzSk9Od29ZWDFONGtvNDY0S3lVa1VO?=
 =?utf-8?B?cFEzRXdFMTVqR2tPWU9RM1lsQXBxd3dyOUY3bTVqd09EZDI0a0Nid0ZNM05w?=
 =?utf-8?B?MW40b1hrR0dNMGZGMG1PQ2ZDbWJQY0p0Qk5aZjdzSnJTaW5QeG1EUlNRU043?=
 =?utf-8?B?emEwa0JRdkZCMktHOUpyQ1hadkJhTndHN3krL1RwL0lpaVBOaENCWGs4ekFj?=
 =?utf-8?B?bzR5b0tEcnJ0N0RKWk5ncUVqUWppUndITjVNbVhXNmRHaHRNZXJrK2ppN1Ba?=
 =?utf-8?B?VUl3M2VjMkszbGdyZFBDSDVkSmtaaCt5alNSYVpjMnc0RU5sOUtGakpoUzJB?=
 =?utf-8?B?TTRUcG1Yc1pxalZjdnJuTGJ4YXBLaVFkNGdzWElwN1prQytZTUUxMW5kU2c4?=
 =?utf-8?B?dGxQcFVqOG9lOEdxTzFoMyt4UWhzR3NGRmZCOVVvYVJ2N2lnVkl6dHB4UEda?=
 =?utf-8?B?enlmb0hPNVJFVVdVdzdSZXFxL05CL0o5N1AybFZFeEs2eXRtdURCR2R6QkRt?=
 =?utf-8?B?OWZRZTBZRHVUbFNuQVBEMUZieDdXWTFSZkx3VU1NTGg4VHVLeHNLWGRoN2l3?=
 =?utf-8?B?ZFFSd1VieFdlN0Y0aGtlL25xRm93MlpCZnVHR2t0RmVrcG0rWm9laHpUOGd1?=
 =?utf-8?B?SXpEYTBlclpaWG5lZEd5TzJ6WDZvR1BWV3ZLS2hOakhxL3hRK3FYM2trSk55?=
 =?utf-8?B?OXNNcFltalU1OW92NXZDSXJNTmc4STRINzNSVDRiVlBBL2piVFFxK21qK2Fn?=
 =?utf-8?B?OFNLNFM2MExIK2VEQUx1dnRDSmp4Umc1NGR3RWRmUVNpdjdoNnEya3Z4a0F0?=
 =?utf-8?B?dHBaRFlLdk1jcnpJY05XNHNNeGtJd2I5UGhDbU1rL0huSVo5WE9ZU3NnTVk5?=
 =?utf-8?B?STN1YUVtbHhoYS96QU43WGVCeXV1dDhXTklmZVpFNW9pQUNiVFplZkNqcGll?=
 =?utf-8?B?Z3YrSko1NTQxV0hqV3djUTNxQ05aZGd5WU5VdTZlciszallCN0VSbHVUSDlQ?=
 =?utf-8?B?eEZTSzdkL1pWYjJHbjV0UjEzRmxFQnB0M082RjFMTUVRZXd3VE81U2cvbG10?=
 =?utf-8?B?TzV3S1B6VUZJWWhtY2xjYWRHRnRUckFKcEFWUjVkVm01TnB0b1BFQnBUeU0x?=
 =?utf-8?Q?HaCpzntuZmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklJMGpCcElOVFYvam1wUTlHV2pBaXVVRVZPNTBmRGpQMjVoMHZ0b0VXa1pC?=
 =?utf-8?B?YXdBYUE5VTZZcTdqcHVOeEY1RFBwaVV1NEs5TFBsQ29IMzFPNnJQeUZ3Y0x6?=
 =?utf-8?B?WjdzVUp0aGtxWFFHRVVWcTR5cjJ3Ukd2eHRjVDNRb2lVL0wyRXNSdGVGTjRY?=
 =?utf-8?B?aU1CbnRNKzM3YXR4dnM2eWZaN2tkZFZ3emxzR2U0Y3VXTm9yM05FYkZEc3l6?=
 =?utf-8?B?L3R3ck0vKzc5WUFhQXhBUlZGNWUwdmZENWtYV0FkdDlpZ2J1SmovQjJZNm1h?=
 =?utf-8?B?VTU0Z2F1OVNtdGtQcUw2QzFjMzFLak0xM0J2RmEyZzVQb3RTZ05wZGY4SE05?=
 =?utf-8?B?MG8vQXNtY1cvVWhxNEZHMnNheFVhd0E1ZHJtdFh4ZTg5NjJiOVUrQ0Z1Z0Rr?=
 =?utf-8?B?V0lCcDJkVjYwNjMrQ3lDZ0trN0Z5VHE2RjNVSUFrOThpQVNhS0pBbDBuRmdZ?=
 =?utf-8?B?UStNQzhmRXU3NEo2VE41ZmwwYWJIUFhYcmU3a0RBMVRqdHlVZDZzb2IzQktW?=
 =?utf-8?B?b2FIejdoVHZhRS9LMzZrbURrTVVRYkJiVGQ5elVXWW55d1lPVFhXQlMxcTFG?=
 =?utf-8?B?OHNHUlkwZG1zVUErZ2E0ZWVSM0NlR21kVnJIUUNvYWpKZW5vTkFwNEg3SzZZ?=
 =?utf-8?B?RCsxcS9NaU9NTVNEeEIwOXNHOTU3VkJDYUZ5ZStxVTZWWWpEK1NmenJJWFpo?=
 =?utf-8?B?K1ZIWm1ncU5KQW5KaENtdkJrRS9VY0g1eUJKQ25PVUJlNXhLbTdTanNvay9u?=
 =?utf-8?B?eWRuWjRYTkE2RkdRMllEcWZzak5vZnZwblVtaWpMUDZNazFmVXBJL1lJeFV2?=
 =?utf-8?B?c3dvZ1c2eEZSRzZ6eHAxeHZLSXJINUJVd1dxaTZHbkdDTEY4WnRTSXNYT1lI?=
 =?utf-8?B?K2xtdlcrYTlNdEpiRk9nMjdNVlBZUEk4ZkUxZ0NyMTRraUsvakFrMEtGUkpw?=
 =?utf-8?B?bVZzL0FoY1VMaVpQM0lBQiswNmFsZ1NCYi9Oa093eTNGbCtDMXBOeHFYQVFU?=
 =?utf-8?B?Z01GazF6QkhmZmc2TVpBdjhTRzRnOFFaZ2dmQTFOMjByVE0zTVU2TDdqS0Z2?=
 =?utf-8?B?dUMxcnQ4bUtGc0p0REFmc3pIREJIS0VjYWpOK29Cc2E3emJkVDk0Ymt0MjhQ?=
 =?utf-8?B?T2V4dFM2OVVSRlEyRU43NjM3MlM4RmlCQmpYQzMrbTNxM1FMRW9FUUhoMzBp?=
 =?utf-8?B?Z0pZV0QxOEpXK25zNkkydWQxQlJCTmdrT0E1eld0cFFRL2p2MzN2K3Z0Tkpu?=
 =?utf-8?B?eFFvcTBCOTZ4VW50MXNKRFdOa2o1eVJZbFR3R1NRMFV2YitBWWhGWGJpaVFZ?=
 =?utf-8?B?RmtMQllPQmNuMUJWZ3JwVVZtNUg1QnNTam5mMDQ4b0s4dE94TmRZcFphVmFp?=
 =?utf-8?B?Q2ZPSnFlNTk4REI0ZWJGMFN2MFFzbFprdVQ5S0g3VWFxTTByUHlrOGt6YkIy?=
 =?utf-8?B?RVc4QmlWUmR6ckJETGRJRnhaRmNBemlkWlloYVJRWEtZeFI0Sm9vK0NTZUxx?=
 =?utf-8?B?c0ZBd0NhSUJuQis0WWRKaDUwTkRpWU5iOUh0RkI4UXdHdEJhdE9Wc1dNUUNv?=
 =?utf-8?B?VUJaKzhrNlY2RFJDV3NiQlM2M1FIdjlZeitxZjg3WWc1RlNjRmVFZ0VJR0tN?=
 =?utf-8?B?T2R0M1prbWU0ckR4ZUs3NWQzNWROajU4UlJBZVRHQlNiMmRTaUF3UXlwWDBY?=
 =?utf-8?B?TDhxYlFTMjZnS05mbUNxMTVQY1o5SFMvVTA0THozd3RCUlRVY1VmOU8xM1dO?=
 =?utf-8?B?ZTA4bzNoTGhLT1B1ZS9vc3lzU09wQkJySmN6OEN0M1Z1WTZFSkVBTWNZYmJl?=
 =?utf-8?B?YkFrSWFmYzJEaGZtYm5ra3YyV01aYmlZVWRrR0ZLbnVoMVQ2cFBIdzQvbEVh?=
 =?utf-8?B?QVVlcmtFT2NUWHlVUjQ3eGZBV3RQWUp6TGxIWHBUVjlYazVOeFBCbTVpck9u?=
 =?utf-8?B?RFVmbTVnTDVqVnhuSmxlaDRlMDF4QXBPUjIvUEhHYUw0ei8wRXdYSEZTQXZ3?=
 =?utf-8?B?TmlFQ1pxb2hlOVFTVUtYQXJKU3c5ai9iYWE1Z2FkU3d1T0lEV3ZkNFRXMXY3?=
 =?utf-8?B?bURvMGk0c3JuQWFRaDFMb0dna0M2YXZ3cTBYcG11NjlwQzArZzBqYlVUc2Z4?=
 =?utf-8?B?NjFaREFic1I0SzFxOG1PV05FeEhIbVBLOUtFbjVwdzh6WjNOaDdlUXJsNURJ?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/XgEEEQZTFiC1bUXLy4f4yEJ3CrjE5jAN6n9XxDacm2t8BjDYXtOHAcGSrtZZVbFwQ/U+KFnCO3DVFNBUzfVafbmsah3GowSZfMV67YFKyFAZhSGooAbY0sOoo1VMgs2WBGqnVtTIay4OpnBvWOTnjEWxTBkSgfc2ICmTi2rR2whj0Z5reHizWtMjVQD9qAyXOdXDfoLsHA61CYLHwTrCnEvcVh5unVYTuCIC1XBnHY8awOnxREbpER5iyr3XbHKofQXMx1zSXzGY5FotmG98m8d8tXAujXh3qLsh7Z6qL/tsooai0uI/pObsrUklEqbkFR3wMXm2+VKMywevGiKfhS8DfP8ycCspB8pzAVSpU67wE19PW84Ifc3X69Zg5S4BRftK7VuIxst2acfFKXfpDfugbWjIzMwSW/GR7iMoR+13Fxhh6dco1+YrY+VBWSG1npd9aoUcNsgq4u2PP7Uiutxt8Za1zQfB1WAXCjqsIRyh7QRhfs/FG47Zlj3QA7bU88i+5xiXnUxgEBDLs2fdbAbF8GY+b2gjm9X41bvPEi/hi9caCGR+FY/X5Sfc9BE+TM9hg/K+uHyS/jTIJpFna1azmIxbwlBKxyluwJeXb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fed1a0-1274-4454-04c2-08dd237ad4d6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:54:22.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNTrEyjvHmfoNVo36Ew7TEyS7H5zBvq+gJsbB9hLkh6OiAd8SSC4ir1G/N7QT5oX8Jgfjr7JInL1skmIll4KiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412230159
X-Proofpoint-GUID: lU9pzzC8M3qkvK8qALtIhLcxzu0Yg8cy
X-Proofpoint-ORIG-GUID: lU9pzzC8M3qkvK8qALtIhLcxzu0Yg8cy

On 12/23/24 11:28 AM, Liam R. Howlett wrote:
> * cel@kernel.org <cel@kernel.org> [241220 10:33]:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
>> leaks into user space. The ERRORS section of "man creat(2)" says:
>>
>>> 	EBUSY	O_EXCL was specified in flags and pathname refers
>>> 		to a block device that is in use by the system
>>> 		(e.g., it is mounted).
>>
>> ENOSPC is closer to what applications expect in this situation.
> 
> Should the tree be returning ENOSPC in this case as apposed to
> translating it here?

ENOSPC means "No space left on device." which has a certain
filesystem-like ring to it. So translation in a filesystem caller
seems sensible to me.

If you change mtree_alloc_cyclic() wouldn't you also need to update
other mtree and xarray APIs as well, for consistency? That could be
a lot of bother.

But if you'd like to change the mtree API, I won't argue. It's not
a crazy idea.


>> Note that the normal range of simple directory offset values is
>> 2..2^63, so hitting this error is going to be rare to impossible.
>>
>> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
>> Cc: <stable@vger.kernel.org> # v6.9+
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Reviewed-by: Yang Erkun <yangerkun@huawei.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/libfs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 748ac5923154..3da58a92f48f 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -292,8 +292,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>>   
>>   	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>>   				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (unlikely(ret < 0))
>> +		return ret == -EBUSY ? -ENOSPC : ret;
>>   
>>   	offset_set(dentry, offset);
>>   	return 0;
>> -- 
>> 2.47.0
>>
>>


-- 
Chuck Lever

