Return-Path: <linux-fsdevel+bounces-36285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896109E0DF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 22:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3645C281C1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0401DEFF4;
	Mon,  2 Dec 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YLtCJDxv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZCyHbqDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195F70800
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175353; cv=fail; b=JPZ7Xt6eUZudQufFQo47BRyBiFNr1nBXF7FU2PbHNfT0MGReGRTtG/k8QrtpqZdPPuB/DKv+VhPJlioszGwFCUtvz8LCfROrDX7QxbFm2tHG6VGzcHEe1Yz4uQsQsWBKkkZewOSuyEplfCYEIFN/8iJK7Q9MgJ3M/ZYsRa8oLIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175353; c=relaxed/simple;
	bh=u41t7OwAmGYwRYZcvUbDUFgb7kGPGqRsLsWgW/qu1co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZePLAGpBnxvLR3A1siFjVmLfiBThQxSxAOVfN2+hqK4w1H9WKFi3D21H5Fv/G/pBzlh0wF5kvXKSW97w3oz/3VEv888xHlswL/vstoBEoj3YKNmEQelKLTLCLf2Lj8EWT8P5FS9f955FjjM43Gh//37ZgR4jydl0EEFd3DP1QLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YLtCJDxv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZCyHbqDS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2KtYO4013765;
	Mon, 2 Dec 2024 21:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GYqkA+rFzMk2V2+is3Q681es0PyDVMqu7JtQs0i8wzs=; b=
	YLtCJDxvqyEi22wRojGM7VXaardZ0gGI9gVc09oNrWCf3+l/S6VwF2/OzoHV6jPX
	O3dyZany+P6ajkU3u53aJ5Ps+eiwBr3YCm/Kr5nrzMvmPnNN6e/O3Dg/fsTK8LfZ
	jJVtGK6UDGsqJn4bp3PseNgfGWzt+826bJyBR8UpmdXH5mP45QA64pOaTJLH3wCU
	I5cJO6D/aRQYElI+BBNhcGbscFRRPYtKgrsQn2rTpV4mA/irh4B1VDKODNumF/Bx
	RBjkKIReZ9Sv3GC5GuyuFl1gn1VpnqXoieIpd2C7V/hDua0c36F1xbcoegxBdMHr
	jyyW5b+JrQvuSEP0DZtyBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c4qxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 21:35:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2L4TCh001117;
	Mon, 2 Dec 2024 21:35:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s572h32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 21:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoyqXEZES6r5nJwMADLsVs/hMwcy8kXsWle/PsqROJYgThoKFvtnXn8pkVj0mApu3Ezfx8a+/reTfDtJnDQeGe7XmvhfkIJ4zGD6XXvoY2P5ksGpYLnqbawJpdLA56sxTmXZEq0zzRpVou9otXd0OYsIrDLFahTynIXXLAB0Xj5QEn0evI3grXO/bcHoTmiYkQm1a1hyv70kOlIhyFYrQ7+yn07x6m6xq6tANjmJCPzEEeTcEH6891l+QeMhwAiagAt6UFnUPu/YRZvyNewUQSi6gbkVOrm429HJZyhae+q203znKFcb6mRdfHbAb77ez3au6AjXeBa9gV46p/tlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYqkA+rFzMk2V2+is3Q681es0PyDVMqu7JtQs0i8wzs=;
 b=IAQZUSsrr21FG0CHh3jN1xY/xQqk/Ut4MQdxZ/l2Dvungue09pArHtaCbR9VXr7whGh1FVH2haVoZRFBAuLsw4THxjxJMTehZj9DDl7jNExkgZIYVy7us9k3v4ph+pzrSKLQ57W8edVtdnk9UFB55BfmFnNNSfOSwb/eHpYgNhUqtEcdHLOq8yrwIVTRugJMUwFF7lyhr+xVBn6rIFMhvJNj7kdO/drzPapxX/hpn2oFWRM3LbBva4Smq15Hbf9VF8J/VgVWsFEL8YihC/YRF0nNkpN8BqDVu/k11F03Be8Ozn1VhvkVcu85QSjMkzK2uK0V7M7C3veXbr15SEwJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYqkA+rFzMk2V2+is3Q681es0PyDVMqu7JtQs0i8wzs=;
 b=ZCyHbqDSMylUoN4liXrcchTdDop4M/ZTulh2/nnk5TmBieV9KbYlE68FhMfsEjinHwdwyaQSEKFDHBtEWvr7KZcxv5K1zaMfVLZaoC4gDlkislBiOt55+NWEFgzAlRTAenfCdOKtl6SoK/wHaAwy2W1ETX5K0OTQvqhI/W+EVy0=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BN0PR10MB5029.namprd10.prod.outlook.com (2603:10b6:408:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 21:35:37 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:35:37 +0000
Message-ID: <9ec6ea5a-2722-4560-8e1a-95c725c62b87@oracle.com>
Date: Mon, 2 Dec 2024 15:35:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: reject on-disk inodes of an unsupported type
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com
References: <20241107054228.26540-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20241107054228.26540-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BN0PR10MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: ea24c92a-5b7a-478f-a7ca-08dd131942d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVhVNW5ockIyRWd5TCtndzJPM0VzMHQ2MnpHaExDdDNuUmRLVUFCT1dFR3FY?=
 =?utf-8?B?MXk2cTh0NmZpWFlid1FMTDNFekpKN29ZZDArdXRzRWpXdytGRTdHQ2ttbXFF?=
 =?utf-8?B?NmprcHMwTURjWDNQZ1JWTGhJUWlMTzVFRUhya2hkRzNmdTVIWlRER0tWMUlx?=
 =?utf-8?B?Q1UvV2VSdEdJY1BGdlFmNkp2NlV4T1dWaVpVTGlqYnE2YldOQVFaL1hkQzlQ?=
 =?utf-8?B?Vkp1UlphQndtaWVoWEg0VktSYmxSdFgvckREUjVJb0ZDZEZtTXgrVlNhbyti?=
 =?utf-8?B?MGd1Z3VDakZTWmppT1V5a0xYU0xrNU04L0ZGMG5pYUpvNHpzbjQ5NTFna1pv?=
 =?utf-8?B?VmZhVG9TODBmYTA5QXZFWjRpeHI5SFRCZFJIUW9xTktxdVlTdmNQZG9YV3RX?=
 =?utf-8?B?dU4wVy90L3U5WEtObFNKaVNHWGp0OFh4Y1RsTzlGRXBhazBSRXo2c2ZObnhI?=
 =?utf-8?B?VXZ0UkRpU1lDSjhybnRCbC9sOFBLVUc0cGF0R0pGbmU5U1BMRkF3Z3lNNGt3?=
 =?utf-8?B?STdEQlFGb25RZUhiK1BTVWgwS0h3b3FmOEVPSUVKN3FpSlhIUGh5ZjYyb0xD?=
 =?utf-8?B?aWUzU1FzOTBOcGRXejNRR09Vdnd6d3hXVjREY0VoVGUzWUMxSjZlQjhpS0Fl?=
 =?utf-8?B?QzdSSHhLMFNkNm5GMUhNb1hWSklGcDRuNXFtRTQ2T2FINDJsTjRSVm4zVTdw?=
 =?utf-8?B?UFdQUjVIcEtTVVZNU0t6bzZFM3h5dXZGNHFqUUZxdlQ5WnB0NUpWWS91K2R2?=
 =?utf-8?B?bXFWdWFjZERuT2Q4SXRhMVRSdmgyR1Q3TnNuR0Q2WnJuWEpQUEVhRXZRUmQ4?=
 =?utf-8?B?bEJadDQ1cmF6T1BDdS9CK1F6SFBvNVovdmk4QUh4bER2dWx1Yi9rdXQyb3VL?=
 =?utf-8?B?RStLbnpFNFRJR0lRTS8wWnhneVlHa0pyanZ2VHkzbkN3a05LVnQyd3kxL3g1?=
 =?utf-8?B?SG1HVEZ5S2VzeG1LMTJraktQbloxNmwxSEZHdjBlY1Y4Zm0vb3VMT1k0MllT?=
 =?utf-8?B?a3g5WVNFSWRhZ3kwazZuM0RKYkFZcG04UncrOFRRYzdHWE5JRjFCdHhPNG5E?=
 =?utf-8?B?d2VmbDJUdlJNd01USEhzRUtZc3J6eVhsWEttcUFkZlkxdnlDNEh0L3dGZEk4?=
 =?utf-8?B?eFI0MndQVUlNUHU0YXpsOW9EQTNHLzU4QnBVL0lHVTdhU2ZLdTE1cDhCeVNK?=
 =?utf-8?B?ZkozRTF2UVJBb2ltcXpjazVHQ3p5V3Mwd3VLQmplQVJUSEcxbUwyeUUrK3A2?=
 =?utf-8?B?dXNoRHFhK09WTWlYNERiZ0ZjbWg2SlVXMDJsS2xlTW5BejJUeCtaR2s4SXla?=
 =?utf-8?B?N3N0eGl2aXpLenNuNmNTNHkydVlGdzZzWFQ1MjJwdDg4T29SNkY1Q3dQeUZv?=
 =?utf-8?B?TUZLU0YycVlLTXBBT1FCVHd0L2JxUVRIYi8zNU9jZjZoTytVbkVocm0zOUxL?=
 =?utf-8?B?a1JMOEovZlBrdDBQdVo2QkhaTTlOakRSZHZnblFXMWRZMXZtL1RZbXBhNUkw?=
 =?utf-8?B?REUvb25pSWlTOHg1N0U0blIwWkVHS3JYeHpuUFhFWStPRUJTL3RPUkdaQmIx?=
 =?utf-8?B?V0owbWpnWEFrbEtwV3ZnRkJoRjRVOW0vaUVadXhyMW5oZ0NsN2VxeDA1WDhC?=
 =?utf-8?B?eFRzZVhGblc2RGQyczRzSGwyc0VLWEZSUnllSEhxVWRhK0tMNmpzY1pIZHcv?=
 =?utf-8?B?MVl0OFBId3A2alE4ekpNcTVBVmpsd3l1Y0NVWEdpdG5nb2M3clZoRzlWdTYx?=
 =?utf-8?Q?+HxKEEhzP544CMbgO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kzh6RWFxSTNLQ0wreDJNWWo5MjRTZlJPa0wzWUZxZDZXcC9xSUxicWdWMUw2?=
 =?utf-8?B?K1FJZ1ZZbXlmU29QVVZiM2Y2MWVkYVNFV0x4eWZPZlN3TWpWTEpzdGlScGJm?=
 =?utf-8?B?eDRUYXcrQSt0Yk1oV2NqbWRZMk1ZVFprZFRFNGlqc1l3YnNJTGlmNXVxSkEv?=
 =?utf-8?B?NFR0Y204OU13dlRHb0RTYlF6eWQwb0lkV2hFNDFBVllFenloNitxK2l6ekxV?=
 =?utf-8?B?MDJkKzRvTDNXOEY2STRncy9velFEVFYydW01MFh2aUd3R3B0Ty83TExkRjhk?=
 =?utf-8?B?c1JMaWRYYnB5d3lqaitFemkwNC9GMmFvR3dJV2VZWnJmWHRZRlNFRFlKK001?=
 =?utf-8?B?YUY3bkFPaVN0c0M1WHNUeDcxTTU2amhMYkpqVzJwUnFhUXJQcEFZYlh0L2Jo?=
 =?utf-8?B?WERHU3FyeG1vYnA1RlNhVGJVcGJTVXM3a2VHWWtQeDd2aEZ6c2lMYlNXU1Ex?=
 =?utf-8?B?bC9SVndXMUpRSVZkSFNhaC9vRVVvdHJubEdlVDIxTncrTVdybkxhbU5LUVJv?=
 =?utf-8?B?YlFTQy9wekhDeFhXazdsUG9rV3JTNkt0Vm5TVVJUemwwbVl6ZTdFZnFmZFdJ?=
 =?utf-8?B?Um16V203WFp3R1ZEU1FkMC9SRFpVZTF5dnNtazd0M3RybTVBdnFib3lka0dv?=
 =?utf-8?B?SE5aTmgxa0tSNTYxbWdhS1d2dmU1dGY2R2pPZ2VCblpiVzd6amNVTUxqRFhq?=
 =?utf-8?B?L3k3KzJDQndxSU1KVzVkLy9DRnN4TTBhSWJsOHNPRS8zOFRZVXJCTTBOTzBr?=
 =?utf-8?B?M2VBOTJwQnU4MEFvdk5KcW9kVWI5M1BkaTdMT0hZZmJVRWprdTFUeWQ3Y2ZJ?=
 =?utf-8?B?cytubGxaSWs4WjdSMHV3OVFjTTk0V3Z1ZzNhZlZsTzBTcnYxdU5xZnVXbXZr?=
 =?utf-8?B?YUV2Y2dmNU83akpvUy9hSGc2T3pLWWZaazVHTnZNYlNqL2k2WTR6NTVCZG1G?=
 =?utf-8?B?Mi82RDEvR1NTcG0xU29kMjlmcWE4VEtQRDIvdDVENmRBTml6OVJoTTc1Wklo?=
 =?utf-8?B?S3hyZE0yUm8rcDVMYlJmNVJPRjNLQ1ZQSFpFMDVZaHQ2bi9PdnhRQUFmZjQ0?=
 =?utf-8?B?MTBOMFZ1Vjg5TmZUZWc1R0s0dzl5VlFla1VvUWtpbjRPTUlHQ0o4OGh6K1kx?=
 =?utf-8?B?alBYTk9PNkt2VnR1NFJPS0J3cGUzSE5LNXZBWG9qYzNiN3Z0L01LaTl4SE1q?=
 =?utf-8?B?dFFaWkdwOFBOQVYzTDJjRzBMeCtyTEV6aTJYYUxTbEgyWHIxU0dnaWMyMXlI?=
 =?utf-8?B?bjg0VEQ0QUFOdTY3bml2VS91U1lCa1NiTm1pMFdiQitRekw3MmRVMmxXVDIy?=
 =?utf-8?B?aEd4cXgrQTZaTDZ0Ulg1UHBHSWt6SWJFbE1Cd1NPa1ZoSkFjQWZEblhPNzlx?=
 =?utf-8?B?NlNmVDdXN0V0cU9IZmZOZTdodFVObHp0cUZZRnB2UG9JbHFRTEhBM09HL29o?=
 =?utf-8?B?THg3NmRTb0I3SkRjT3NnZnRDYW5FMUdRYndJaGxZeXhzZVhQVVB6a3JiQzVr?=
 =?utf-8?B?L0EwY1gvZDJqcnUrTlZDSjNaS3BFK1oyNFoyY1dFem1DemtPcHVlcW5FSEIw?=
 =?utf-8?B?S0I1TWRtWjZ3c2d6Zk9PV3BsdUtoQytRN2Q1YnpvVTc2TEp2UWpmcXQzaXRx?=
 =?utf-8?B?V1A2RmlqWWdtMDJLQlFhL05hRlhZckF0RFhsQmliRWxkUVRiSXBIY1pHbk1W?=
 =?utf-8?B?QXd2WE5ja1pRUUhyL3BwaG1iYWRNcUFBbWE2Sngzc09Sc25hRjRjMzExQTg4?=
 =?utf-8?B?bGdTTG44b3ROckdKRXJrSGFwWW9YNkkzcUJ0R05sQXFnUVlEV25FTlFlWXZQ?=
 =?utf-8?B?eC94VE5XdThTM1NsYi9sVTFOYzB0UnRVd3BMK1NjaVl2SmNodndOU0RrdHpP?=
 =?utf-8?B?QjhFMlNobFRPZyttTUNlMGpFVzEzZjlNaUxhM1EvdUVMWU9zRFpKb2RrYlRR?=
 =?utf-8?B?R1R2cHUyWnJQc1BoNGhsQmE3SjlCZG5ydzJoZGc3Z2xPZjU3REhEVFNpaHFI?=
 =?utf-8?B?bWdTUmJ4Nkt3SldZdmI4aE53NXNDZ1pEenFmaDN3RllGQitTeGpuVEd3ZHZB?=
 =?utf-8?B?b1ltYm8weCsyY1k5dTFvcEZrQ0FmTmQvRkhxWHVhUmtUMEhzMGpZN0g2ZlVr?=
 =?utf-8?B?TWcydkoranViblRmdGpmbUE3Q1NNWTVRZmR3bjRaYklqRTBnYVhIM3dlcnNo?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T7VvHQ6RqPINFdwvuMTg5hOOOeVLXV9wlvfrgs3u6oJxmxw1v9tarv9W0gKnL0eN+ZKvQpekPOqI2eHhqPh532DS2/Kf0dZIDH3ok+lH7qiSIzuZCOMKKwuVScKSLxJvqOLg44dqP+DbC6H41B4VKsUgewTZT6LK1HncMOP1oISETs4Tl7fU8OgRO/EAYvirLfvY9dp7kamAkOR9Em2DQixI993esaBiENqyOhK9buy5wNZiaG1zBQfitNKjwSrt4cq6pwtrgj98d31s0qA4swkffLFPuKXi6zPz+SDUIYzjuifzb6HDdiKgM5NZ1u/WeKwXOvGdhAnn8IjR+vsyXOkIAS3GVLiiCqPXx+046AwlPDs/5RHGcUDW9hEXSEirpFhwQXE3/7Hwidc7EuAmKJVUyOIlTowqrbY9AjnqxQCAwVrYlbOw84eBErT5pnu6E4MwFrdJ+nvyLgAwvsXlJ1NvM4Z/ScwVOPUFn0/z4G3SXzTFiorvHNF2Bwizgb5L+sRXky3hZL/fTtOwiTQGpjYVID3UVeGkHyXs5zsCh16DScN06DR0lv3UJFhtn2gRM6KPVamrrNZSjgyhQYKoXcYcNt7R+rLPrFvS6gU7lXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea24c92a-5b7a-478f-a7ca-08dd131942d3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:35:37.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I68wPbcxMY4P9joxR50R+YH6rRtqOjVFnp80Dc2ycV34kakemqc8slB6R96W0cR3HIhAzX+XSPR8qujFro0y8N3XevtW8GB67SDi5aPkD8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020180
X-Proofpoint-ORIG-GUID: MLOQBJ40YbWv9H_J3xxB_rxLkxsMwtDd
X-Proofpoint-GUID: MLOQBJ40YbWv9H_J3xxB_rxLkxsMwtDd

On 11/6/24 11:42PM, Dmitry Antipov wrote:
> Syzbot has reported the following BUG:
> 
> kernel BUG at fs/inode.c:668!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 3 UID: 0 PID: 139 Comm: jfsCommit Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> RIP: 0010:clear_inode+0x168/0x190
> Code: 4c 89 f7 e8 ba fe e5 ff e9 61 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c1 4c 89 f7 e8 90 ff e5 ff eb b7
>   0b e8 01 5d 7f ff 90 0f 0b e8 f9 5c 7f ff 90 0f 0b e8 f1 5c 7f
> RSP: 0018:ffffc900027dfae8 EFLAGS: 00010093
> RAX: ffffffff82157a87 RBX: 0000000000000001 RCX: ffff888104d4b980
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc900027dfc90 R08: ffffffff82157977 R09: fffff520004fbf38
> R10: dffffc0000000000 R11: fffff520004fbf38 R12: dffffc0000000000
> R13: ffff88811315bc00 R14: ffff88811315bda8 R15: ffff88811315bb80
> FS:  0000000000000000(0000) GS:ffff888135f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005565222e0578 CR3: 0000000026ef0000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? __die_body+0x5f/0xb0
>   ? die+0x9e/0xc0
>   ? do_trap+0x15a/0x3a0
>   ? clear_inode+0x168/0x190
>   ? do_error_trap+0x1dc/0x2c0
>   ? clear_inode+0x168/0x190
>   ? __pfx_do_error_trap+0x10/0x10
>   ? report_bug+0x3cd/0x500
>   ? handle_invalid_op+0x34/0x40
>   ? clear_inode+0x168/0x190
>   ? exc_invalid_op+0x38/0x50
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? clear_inode+0x57/0x190
>   ? clear_inode+0x167/0x190
>   ? clear_inode+0x168/0x190
>   ? clear_inode+0x167/0x190
>   jfs_evict_inode+0xb5/0x440
>   ? __pfx_jfs_evict_inode+0x10/0x10
>   evict+0x4ea/0x9b0
>   ? __pfx_evict+0x10/0x10
>   ? iput+0x713/0xa50
>   txUpdateMap+0x931/0xb10
>   ? __pfx_txUpdateMap+0x10/0x10
>   jfs_lazycommit+0x49a/0xb80
>   ? _raw_spin_unlock_irqrestore+0x8f/0x140
>   ? lockdep_hardirqs_on+0x99/0x150
>   ? __pfx_jfs_lazycommit+0x10/0x10
>   ? __pfx_default_wake_function+0x10/0x10
>   ? __kthread_parkme+0x169/0x1d0
>   ? __pfx_jfs_lazycommit+0x10/0x10
>   kthread+0x2f2/0x390
>   ? __pfx_jfs_lazycommit+0x10/0x10
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x4d/0x80
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> This happens when 'clear_inode()' makes an attempt to finalize an underlying
> JFS inode of unknown type. According to JFS layout description from
> https://jfs.sourceforge.net/project/pub/jfslayout.pdf, inode types from 5 to
> 15 are reserved for future extensions and should not be encountered on a valid
> filesystem. So add an extra check for valid inode type in 'copy_from_dinode()'
> and fix 'jfs_lookup()' to handle possible -EINVAL.

I like the first part of this patch, but I don't see the need for the 
second part. d_splice_alias() handles IS_ERR(ip) just fine.

Would you object to me just keeping the change to jfs_imap.c?

Shaggy

> 
> Reported-by: syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ac2116e48989e84a2893
> Fixes: 79ac5a46c5c1 ("jfs_lookup(): don't bother with . or ..")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   fs/jfs/jfs_imap.c | 13 +++++++++++--
>   fs/jfs/namei.c    | 10 ++++++++--
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index a360b24ed320..debfc1389cb3 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -3029,14 +3029,23 @@ static void duplicateIXtree(struct super_block *sb, s64 blkno,
>    *
>    * RETURN VALUES:
>    *	0	- success
> - *	-ENOMEM	- insufficient memory
> + *	-EINVAL	- unexpected inode type
>    */
>   static int copy_from_dinode(struct dinode * dip, struct inode *ip)
>   {
>   	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
>   	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
> +	int fileset = le32_to_cpu(dip->di_fileset);
> +
> +	switch (fileset) {
> +	case AGGR_RESERVED_I: case AGGREGATE_I: case BMAP_I:
> +	case LOG_I: case BADBLOCK_I: case FILESYSTEM_I:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>   
> -	jfs_ip->fileset = le32_to_cpu(dip->di_fileset);
> +	jfs_ip->fileset = fileset;
>   	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
>   	jfs_set_inode_flags(ip);
>   
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index d68a4e6ac345..845abc598334 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -1467,8 +1467,14 @@ static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry, unsig
>   		ip = ERR_PTR(rc);
>   	} else {
>   		ip = jfs_iget(dip->i_sb, inum);
> -		if (IS_ERR(ip))
> -			jfs_err("jfs_lookup: iget failed on inum %d", (uint)inum);
> +		if (IS_ERR(ip)) {
> +			long err = PTR_ERR(ip);
> +
> +			jfs_err("%s: iget failed on inum %d with error"
> +				" %ld, consider running 'jfs_fsck -f /dev/%s'",
> +				__func__, (uint)inum, err, dip->i_sb->s_id);
> +			return ERR_PTR(err);
> +		}
>   	}
>   
>   	return d_splice_alias(ip, dentry);

