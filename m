Return-Path: <linux-fsdevel+bounces-32647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD439AC7A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E711B1F2329C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897F1A00FE;
	Wed, 23 Oct 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9GXgJFO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARaf+KRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7C19E97B;
	Wed, 23 Oct 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678785; cv=fail; b=ijwkrqJ6oZRv1I1GuYt99wbS4cuyGzzHKk7mB7FranERZk+v9Vi+i2BoN4d0BW9+J3fdcOERgsSkdxGasqVrKhCDjYIHTXSS4S/lPIVGeUgHrdb4k6hf0kQcwR+H3x8M9gdkspbw8YuVEEYGlcDFdHAQPAdjwfnZRPQ2T2H7i1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678785; c=relaxed/simple;
	bh=ngWNSxugh5dQ+bozXNHDZZ0qND3N6YwhoGsfEIdKnFw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=NJEH9dTd1gkVR/EuInUsPVvmETIfoKrNYymKzCYv0Li2/02r4QIxmsn7ZyLZmInjGJ3/q4vM7evXg1UtBTe0SqDHHgPehG+S1oFP2uhD4l07zxcU3QtYL+FT9FLXGO8uWVo9nceK76+zaixCgTFqLuu5X3sUdtv02AA5eUjbqPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9GXgJFO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ARaf+KRb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7tfZQ025345;
	Wed, 23 Oct 2024 10:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=7a86aDhaUL+oz6B0
	Mi7HOWyyeFjS4qvQQZdZ3F8eaHk=; b=Y9GXgJFOQs28w926uCpDlLGosk1e7Y/G
	s2UpI7yWTzz0VHTYXO0V9t+ENVmefQqJQbMGQAIb0USjbATm337t3ifnHLsDWvZC
	oCL4CIHEM8uIQkCS0+FfnwKqs5YdwQVKLV0krrMBJfBQ+cWyndP1Xb5GNwkJHpQY
	4DNm86toDrVCyLmnnTyJTtZbvZmEmfmtsVE6OtSF2MGxrQnrVq2ieJY4n7s4JODL
	lAIUk5TBpGmHY6HlcMQTeQgV8Aw8yYQY7NweyA/60zLR60BplEQmZ13ErKp6syjh
	A8aLu4jujYt/sllWhQ6Qvc46AkIYs3IlJ7OqMopE2XarhMLoBb/jEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asfrt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 10:19:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8eAxb025479;
	Wed, 23 Oct 2024 10:19:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9b0gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 10:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAAsrb4KLO/XE+joPTiEH2SNgm5HlpZAhGvroIPn51zeknqh8TvYYI1ARC0VMr+8M+98EP87P+B41hBfE5cDgGQXA91g6YDKrb8T1aTkLmAepPX5xK/ln+ECA1nn0xZ0j96pavrlV3uwkY/u83JDN1ey1Yu8bwcME9ydL2tbhPKM4kgYX6elsilQc9V1WcIFbdEsn/eGYlgXO2Qd8GG9RIXB5Dhe37Yg+Pk6XcIaIqlE6QHKo/qq93IZ9cZXvs3TJQCnS0gBPIrQjcNq3p5GbBWZH0ewVkk47TGAezEbvHgenKIFR79a/9fhVy6iMuJ/WJ1dCz6SzgVgJGc4MMGaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a86aDhaUL+oz6B0Mi7HOWyyeFjS4qvQQZdZ3F8eaHk=;
 b=LA3fAQvjWrS6q5wuKBr1BIgxdKedzGKjIHUl1nZI6PV3rdtqKLdZ8a/uG6Zpb1DwEzBia2fcHs3CNpDvWW5SBMaiPXyruA4IJtOoyvxzrsRlMaXeAmUBuoDgsuHwAcQcyiPj5/mDshgO3YP3TX6nHcvYRVgVUTncqiHUZCVCi/oURntkXo+fp4BzESiVqKwEAswNnnu/Ejqy2+6CshK0i32IXyBwIU/u4TdhIUVGBl8WIHQVwnSSMoBbUziwdt2q2oaXLLnjvhKhdY6subygLxJNSlcZ98At9BHGn7oWaXl4kllpq5ojwTGWBi8s1pQgTJgYA3Cq2YFW9N5KrWqvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a86aDhaUL+oz6B0Mi7HOWyyeFjS4qvQQZdZ3F8eaHk=;
 b=ARaf+KRbYwrhNmnnT7N1sAX3zGCqwORCggAYM+FlRDnTULnjbEt7rzea6UEXoUKwnOVUJbBgVDSKWzm3J/UL9I0B3AsVjAWRr0lUeDD89TINgl3OQ+5rjZJC9/sV7BvRUH2HQfXArGN+D2nJ1Qj8nJHDD/P0eImduq+TI8LsWbo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 10:19:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 10:19:27 +0000
Message-ID: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
Date: Wed, 23 Oct 2024 11:19:24 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: v6.12-rc workqueue lockups
To: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Language: en-US
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: befc0991-0f6f-43d9-17fa-08dcf34c2c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZERUZFhtQkZJaHVnUC9aY0V2bHZaWlBCQzRIWTNOR1pLNXRlTWFqYjl1bnJs?=
 =?utf-8?B?MmlmM0hEc1MzaHBncGZvWVdMNkxYcTZJMmFsZlJCYXBLeENwa2VmT3hpVW9T?=
 =?utf-8?B?T2N5MGRKWkdiaUNUeEY2dzRXVHRwdHVXQUdCYzBSZGtqTWhrSmVWdFNjandz?=
 =?utf-8?B?ZFNZZzdWSU9TNTBUQnRjUkk0UTNzMStoNGRSWkVtL2t3N1VhTXZCSjJUWVdi?=
 =?utf-8?B?QTNEVFNRaTFXbnJjb1hvN3Bwc3plZ3lOQlpGUVRNNXJndmNFdVJseHk4V1JG?=
 =?utf-8?B?Yk10d2ZLTkRldURMckswczgrcWhwUzUwOW56Ti9qTXExUHdrUUs1aFR4Wk1E?=
 =?utf-8?B?YkN4b2NZeUYzMG93amMxM1dSL1YvTEZ6Z2YxK2lBRTVOZFV5RGhOVHBLMWpp?=
 =?utf-8?B?MDJacmxqd0hJN0VGSDVGSmRTc0h6d1pYWFJlcnZNUFh1aE5sdzZyRnZFR200?=
 =?utf-8?B?ejVyL3BjZWF3Ykpnc0JiaTBuS3BvUGwzdzRQbURYbmFOMGFZTUdJK3R2U2g1?=
 =?utf-8?B?SEthSlkzUUFYS00xaWU4TFh4RzlINXluOFhyVW5yT1A0UzZMT3ZuRHREdjZh?=
 =?utf-8?B?Q3liSmVjQ1h4MFgvaTA5bm1hbHJjZUwzTHVkdjB6S0QzT2k0YmgwaUxzdlp2?=
 =?utf-8?B?dFhXNDVacXpiTzJ6SVJib2lWbG9NL1FZYjBGK0hoMzhRQkIvQ2VTNTdERWo4?=
 =?utf-8?B?eENzaEZmY2c4V2dMTVY0WDFJTGlEdGhnazNMcVVIMFI5aGVQTTBoemQ5ODBh?=
 =?utf-8?B?Yk92WW1Ya3BKT3l1ZlBNdThBekROK2E0TnVNdzhKTHFUaU5uSy8wY09DSjZv?=
 =?utf-8?B?b2RldTV3N2QzSXNKQlpwSXVJTTd6N3ZQSnB1dEF2eFRrcU1FTnZaYkV1enBs?=
 =?utf-8?B?L0djUlNXcVZJMXN4YkN1YTF5dnhsWTErQVRqcmMwYmhUSGVaVFMxME9TV21h?=
 =?utf-8?B?Q2hQVEdvdkpsOVZsaVVyVjdSQTJ1OGxGV3A3MjdROTBYSms3MGFmcmNVSmhn?=
 =?utf-8?B?eDA5UWVzVGN2b3ZyTm1lTm1HbitGa0JTaEFPVTFib3FMMElnTmNibWpkSWxl?=
 =?utf-8?B?SXF6OXpJUVhoWUJ6TDA0eU5kNVNLdDhWL2E4ZTB2aFR1bFRoYUJUN01NbEV3?=
 =?utf-8?B?OVR4b1JUYmZIcnZNZWo3bHBpaXp3L1FaZmNEbWJhWE1PY1duNG9EVHpHdkZX?=
 =?utf-8?B?MDZNY0tWQ1VaeWM2ZEtLeHdzUkkvUENVTlczbGN0MGp6cERJUmJRVEs3RzVU?=
 =?utf-8?B?RjhkVWxOOHJqNlZMNW9saEllOVkxUkYzNTNZNXo1YnVPdEhjU0ZMbmE4bWxs?=
 =?utf-8?B?YVdzeFZkK1JSZUVrY3lHTWpkRTJndktFWU9WQm1KRFFHSEZ3SnJaWUoxQ2d2?=
 =?utf-8?B?VzlHa1RvTHJGSy9tWTJjWEk5Vm1xNjh3ajcweWRwakZndVNtT3REWmt3M0hK?=
 =?utf-8?B?Z3p0bTJCSU9uT1Rhb2J0SFh4WS9Ob2hId1g0OGc2THdTSERWZjZBNGJiNCs4?=
 =?utf-8?B?R1Q0QTJwQUhmL2x2WTYzbGFmV0k2Qll5SUhVb1RDV3gzbEZ6SVdpYnRwbkdQ?=
 =?utf-8?B?VWhwUmlpOCtlcWNrMERrOXRlNEkwZ2Y3Q0VaMGdTM2FwQWpJVy9EblI5QUly?=
 =?utf-8?B?Ujd0UmpSZVE2dG5lYThPV2JxdkZDVkkyU3FYczg3OTZraTgyTFRQVFM4ZitI?=
 =?utf-8?B?MnZWdW1XcEYwbndoUWV2a2syQ21RZ2hWSnV3T3hiTjJKd2xaZzN5TEtRRHRs?=
 =?utf-8?Q?0mupBnyaUFyF18gOo8KdHY8gyWlnsGx8BeBICaE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBNUHJSZm53RGJqd3QwbjlobnE2UDNzWkoxSXJ1RjBPZEI1VWFPMm5XN3NY?=
 =?utf-8?B?UWQ0bWN5WllUdWRuSXBrckFZRXkxN0JhSUdVZFZmeVRXaVB0d1dvL0lYbm1V?=
 =?utf-8?B?cXhYTVpFSjB3RnRDbjIwQXFHUXBCN0xjRVRBWWtKSEhocDRhSjlUOHk2dFJi?=
 =?utf-8?B?MXBTYklLYjFlWXp6b1Avb3Nza2dCQmJOUnVCckM4cGZNMmxmQS9ibUZKa01X?=
 =?utf-8?B?Q0lqdUVudDZCcXdqK05OenJzaXIyeDNscjRTNXNQZTR0aHMvR1gzWVoyWG5T?=
 =?utf-8?B?b2ZRQ3hXY3hsbFl4eWpVTFlzM3hTd0djai9oLzlxNzdaaGpaV3pQR0VtMUps?=
 =?utf-8?B?UGJkcFV3UUc3SUI2Y2ZaQVIvNGltaFVvb2ErVTBkZVBaL3FhQ1ZlVGt0YXd0?=
 =?utf-8?B?aWNUbURwVmJVa3VxSmxoLzJPVTVzT0wzYTRzckZlMkJyc1FHemVsNVN0ZFg2?=
 =?utf-8?B?OEhjSm50ZWJsVkZGeUhKZEkvYW1OOW1TMys4RHhrdHIraWdMYmZodVdPYit2?=
 =?utf-8?B?Qy9wZk5icXNBajRHNzRacW0vNTJ5Nm9lb01Jc2V0SDh2Z2NHR0tJMFhBc2VI?=
 =?utf-8?B?SnNQQ1pjQlM4ekZaZXpmdGl6N3FoejY4eWJiaHdSM0hoNkRCY28zd0VjbnhI?=
 =?utf-8?B?MFRnSmJuN29HK2gxTEwrZ3NuS3Z4Z3orOWZVWDdLd0dzUVNUK1lQeC9IaTNQ?=
 =?utf-8?B?bEdkRkZnUnV1YVovdHc3Zk9FTnhGWnpFM2tyMGhzVWlxV2RaSm5vWjNVNjg5?=
 =?utf-8?B?MjVPbGppQ0ZnKzAzMGVxdldjeENMRkZRRkgzNWx4ZlJTQ2YxWFVKam9DMlcz?=
 =?utf-8?B?Zlk2VkdvRURFK3FwaXNZY0dFdWtaZTN0Ymk0akJVNTVUVXByOVlVbDFWUk1o?=
 =?utf-8?B?ZHlyRGZncGFPc0piTDhhOU5mcGsrU25welVvcDlIbHNwcmVVOWdFS3MwOFJQ?=
 =?utf-8?B?Sml2Wmk4YXg0dXZaQUltZEUzMzJtNU1HWHc0VzhYYzdGMmQzM29vS1Zja2wz?=
 =?utf-8?B?Skl5SGRSK2g3UzhiVmdCcmZSVkRjMHgrb3c1a2ROcy9tTjQ5cEQyZFlNZnZK?=
 =?utf-8?B?RVdoMG40WGNna3EvK2RqUno4ZXZYZ0twNlpXNklEcUZBVDNEVmZzUjdKOW0z?=
 =?utf-8?B?Q3JNaWRua1p6c3poSXkvTHBuai9MdWcrVVZURzJZLzVBZWtWZE9kRGZXZVNB?=
 =?utf-8?B?VzJkSzlicTRsUDlmUDFPbm9LbWZxQnpHZkdqQjQwQklxbkxaZWlBRkpLNTdG?=
 =?utf-8?B?TC9BU2ZkUFlqVWtuOW9hVUJ5bXQ2Qjdva0tXZGc5bWlHMXVwWEdjWWFvQVpV?=
 =?utf-8?B?bloybDMwYVFEUThzWjRiTEhpNUpnZW4yZEtMMlZpeUtMNDlTanBTYmROV1d4?=
 =?utf-8?B?MDJKMlVFcmwybXFtT3ZwODlwNWJtNUw2b3ovWkNJaWJiTGoxNUwwK2JkVUVt?=
 =?utf-8?B?WERJbmNRbm80cFhmeFp0NjNxODhiS1pHMFRKQ2Ira3BCdzkrUm02OGhtTU9V?=
 =?utf-8?B?VnVYcUVFaTJuc281d2hodlpITFNTTjZEQVVXV3A0Q3pNRXZxTmFxVk9IYkFK?=
 =?utf-8?B?MGJzVG9yZlRHL3JXUmE2R0MvSkNKeTZRTVlRMHdRTnNrZmNZMWlmYm9VM1Vo?=
 =?utf-8?B?RVRUSmlSTVVGZkRrWGt3M01FS3dSdHVRUXFaQkVnOGtMOTZZeDJPUm53cU1p?=
 =?utf-8?B?MnRYUGlzcmtpUjJqUTYySERoT3c4NmdNdHNRMkxQNDdjM0Q1WVA1RitxdzhS?=
 =?utf-8?B?eFZKblVWaUx3V0J4L1d3MXJjT1BYT3JncFA5cUJod2dhYms4TWRNeHVQT2JL?=
 =?utf-8?B?all6ZSt1MTlJZTlwZmEwZEJYUy9WdE5RRS9jL2w2bDhQNkFJVFBSUkowMEVP?=
 =?utf-8?B?WUE4aVVUMjRGeGRabVB6ODdEUlRibklDVGNTUm5BSTIvcTh6ekZJQlYybHpP?=
 =?utf-8?B?Wm1UMko5d3JvU3FiQnlrMTNzdk96eUZQR2RZdDIwL25oUjJFK1lHcDNrWmUx?=
 =?utf-8?B?UWgyMWRMZ054ak90Wk9TY3NFdWM5MG53NEJMS25QMlZmb2x5RG9rdVRkVnpR?=
 =?utf-8?B?VEhGMFBFbmV1VWZKcmRBV05MMXlPRFo4MlFnNXpKZzM2YndvUmVIMFdsYUVX?=
 =?utf-8?Q?Kni7EurgrarC5JrTnBS+BCSBn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X9sU1XC0qe5H3ZzYbVWE/MVpmwePyDwpLRnzzCM9QFug8CqnUFDfe/tly5kgk9gJpqA0TiPBoWBHuBFgRXDIvgl+legk4MNlf3RosWUbluBbZjp1DtWQsojzGuxUgisVDe/s+0Gx0O8l1iOi19krCTjr22jXM4X4djgZKekPXj598TiFRag+Kcl3QNbed7KcxX8+syKftz7z45NJCjkBF13stHTtVGjMUpRCuNFfgf6oU2GKhqKh9285WpiaYzDadef8R45dLecQIM9PSd7Rbgz/77YaAajHLtuCfjPmotR6+qutt/Dl8f00qg+BGO0nWNHrzoJNx1j2+gBZdelIb8gyF86E7s9EvdRVjOieed05yghPtZtxFi5WjCMugfFhlHVohY4J84sgSz8f1b7ukkXrUXygGq+E3kSlfDDOCipkBEHhXJewfUtnvu/zVgSEWwVCh5iahnDgMJxeX9u9FrDOszNqlDhN+f4ofqqYHD62a86fWS63SXMFSOHfid6v5JEJv/t1aocdUXpyZLVUFLtdr6gbSAHH8R190D81tY/sg2bRjA6+TIPAhvgOFyZwLNVtOcevDWXBdzRsKgsSod412L+Aos9+OUDfGfXKPEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befc0991-0f6f-43d9-17fa-08dcf34c2c7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:19:27.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le0KEI0QdYty/qoX5iKfjrq5bZ2ZqmUFSe6tJWr8ygvUrW7UraaQ71sDj6oFZ47YBYnAAruvY9Z+VMmF2LcBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_08,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230063
X-Proofpoint-GUID: vyTGV9ZS0brnXGINdeFfcwIhAlRvxUd0
X-Proofpoint-ORIG-GUID: vyTGV9ZS0brnXGINdeFfcwIhAlRvxUd0

Hi All,

I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus' 
master branch:

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 22 09:07:15 ...
  kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 22 09:08:07 ...
  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 
stuck for 44s!

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 22 09:08:07 ...
  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 
stuck for 35s!

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 22 09:08:07 ...
  kernel:BUG: workqueue lockup - pool cpus=10 node=0 flags=0x0 nice=0 
stuck for 33s!

This is while doing some server MySQL performance testing. v6.11 has no 
such issue.

I added some debug, and we seem to be spending a lot of time in FS 
writeback, specifically wb_workfn() -> wb_do_writeback() - ring any bells?

My config:
https://pastebin.com/Y7DXnMG2

early (available) dmesg is below.

Cheers,
John


[root@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 opc]# dmesg
[    0.000000] Linux version 6.12.0-rc4-ge8f994e752e1 
(opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221) (gcc (GCC) 
8.5.0 20210514 (Red Hat 8.5.0-20.0.1), GNU ld version 2.30-123.0.1.el8) 
#32 SMP PREEMPT_DYNAMIC Mon Oct 21 09:44:56 GMT 2024
[    0.000000] Command line: 
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-rc4-ge8f994e752e1 
root=/dev/mapper/ocivolume-root ro crashkernel=auto LANG=en_US.UTF-8 
console=tty0 console=ttyS0,115200 rd.luks=0 rd.md=0 rd.dm=0 
rd.lvm.vg=ocivolume rd.lvm.lv=ocivolume/root rd.net.timeout.carrier=5 
netroot=iscsi:169.254.0.2:::1:iqn.2015-02.oracle.boot:uefi 
rd.iscsi.param=node.session.timeo.replacement_timeout=6000 net.ifnames=1 
nvme_core.shutdown_timeout=10 ipmi_si.tryacpi=0 ipmi_si.trydmi=0 
libiscsi.debug_libiscsi_eh=1 loglevel=4 ip=dhcp,dhcp6 
rd.net.timeout.dhcp=10 crash_kexec_post_notifiers
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000007fffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000800000-0x0000000000807fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000808000-0x000000000080ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000810000-0x00000000008fffff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000900000-0x00000000bf6eefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf6ef000-0x00000000bf96efff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf96f000-0x00000000bf97efff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bf97f000-0x00000000bf9fefff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf9ff000-0x00000000bfe7bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfe7c000-0x00000000bfefffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bff00000-0x00000000bfffffff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000203fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0xbe1fa018-0xbe203457] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 
0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 
0x0000000000100000-0x00000000007fffff] usable
[    0.000000] reserve setup_data: [mem 
0x0000000000800000-0x0000000000807fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x0000000000808000-0x000000000080ffff] usable
[    0.000000] reserve setup_data: [mem 
0x0000000000810000-0x00000000008fffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x0000000000900000-0x00000000be1fa017] usable
[    0.000000] reserve setup_data: [mem 
0x00000000be1fa018-0x00000000be203457] usable
[    0.000000] reserve setup_data: [mem 
0x00000000be203458-0x00000000bf6eefff] usable
[    0.000000] reserve setup_data: [mem 
0x00000000bf6ef000-0x00000000bf96efff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000bf96f000-0x00000000bf97efff] ACPI data
[    0.000000] reserve setup_data: [mem 
0x00000000bf97f000-0x00000000bf9fefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x00000000bf9ff000-0x00000000bfe7bfff] usable
[    0.000000] reserve setup_data: [mem 
0x00000000bfe7c000-0x00000000bfefffff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000bff00000-0x00000000bfffffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x00000000ffc00000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 
0x0000000100000000-0x000000203fffffff] usable
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0xbf741000 ACPI=0xbf97e000 ACPI 
2.0=0xbf97e014 MEMATTR=0xbe7dc698 MOKvar=0xbf73c000
[    0.000000] efi: Remove mem100: MMIO range=[0xffc00000-0xffffffff] 
(4MB) from e820 map
[    0.000000] e820: remove [mem 0xffc00000-0xffffffff] reserved
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.5.1 
06/16/2021
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 6371798537501154 cycles
[    0.000001] clocksource: kvm-clock: mask: 0xffffffffffffffff 
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004] tsc: Detected 2445.322 MHz processor
[    0.000100] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000102] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000108] last_pfn = 0x2040000 max_arch_pfn = 0x400000000
[    0.000136] MTRR map: 4 entries (2 fixed + 2 variable; max 18), built 
from 8 variable MTRRs
[    0.000138] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000189] last_pfn = 0xbfe7c max_arch_pfn = 0x400000000
[    0.004285] Using GB pages for direct mapping
[    0.004770] Secure boot disabled
[    0.004771] RAMDISK: [mem 0x57dbf000-0x5c573fff]
[    0.004775] ACPI: Early table checksum verification disabled
[    0.004777] ACPI: RSDP 0x00000000BF97E014 000024 (v02 BOCHS )
[    0.004781] ACPI: XSDT 0x00000000BF97D0E8 000044 (v01 BOCHS  BXPCFACP 
00000001      01000013)
[    0.004785] ACPI: FACP 0x00000000BF979000 000074 (v01 BOCHS  BXPCFACP 
00000001 BXPC 00000001)
[    0.004789] ACPI: DSDT 0x00000000BF97A000 002862 (v01 BOCHS  BXPCDSDT 
00000001 BXPC 00000001)
[    0.004792] ACPI: FACS 0x00000000BF9DD000 000040
[    0.004794] ACPI: APIC 0x00000000BF978000 0000F0 (v01 BOCHS  BXPCAPIC 
00000001 BXPC 00000001)
[    0.004796] ACPI: HPET 0x00000000BF977000 000038 (v01 BOCHS  BXPCHPET 
00000001 BXPC 00000001)
[    0.004798] ACPI: BGRT 0x00000000BF976000 000038 (v01 INTEL  EDK2 
00000002      01000013)
[    0.004799] ACPI: Reserving FACP table memory at [mem 
0xbf979000-0xbf979073]
[    0.004800] ACPI: Reserving DSDT table memory at [mem 
0xbf97a000-0xbf97c861]
[    0.004801] ACPI: Reserving FACS table memory at [mem 
0xbf9dd000-0xbf9dd03f]
[    0.004802] ACPI: Reserving APIC table memory at [mem 
0xbf978000-0xbf9780ef]
[    0.004803] ACPI: Reserving HPET table memory at [mem 
0xbf977000-0xbf977037]
[    0.004803] ACPI: Reserving BGRT table memory at [mem 
0xbf976000-0xbf976037]
[    0.005076] No NUMA configuration found
[    0.005076] Faking a node at [mem 0x0000000000000000-0x000000203fffffff]
[    0.005084] NODE_DATA(0) allocated [mem 0x203ffd5a00-0x203fffffff]
[    0.005313] crashkernel: memory value expected
[    0.005433] Zone ranges:
[    0.005434]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005435]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005436]   Normal   [mem 0x0000000100000000-0x000000203fffffff]
[    0.005437]   Device   empty
[    0.005438] Movable zone start for each node
[    0.005440] Early memory node ranges
[    0.005440]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.005441]   node   0: [mem 0x0000000000100000-0x00000000007fffff]
[    0.005442]   node   0: [mem 0x0000000000808000-0x000000000080ffff]
[    0.005443]   node   0: [mem 0x0000000000900000-0x00000000bf6eefff]
[    0.005444]   node   0: [mem 0x00000000bf9ff000-0x00000000bfe7bfff]
[    0.005444]   node   0: [mem 0x0000000100000000-0x000000203fffffff]
[    0.005455] Initmem setup node 0 [mem 
0x0000000000001000-0x000000203fffffff]
[    0.005464] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005475] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.005476] On node 0, zone DMA: 8 pages in unavailable ranges
[    0.005487] On node 0, zone DMA: 240 pages in unavailable ranges
[    0.009255] On node 0, zone DMA32: 784 pages in unavailable ranges
[    0.009460] On node 0, zone Normal: 388 pages in unavailable ranges
[    0.010254] ACPI: PM-Timer IO Port: 0xb008
[    0.010265] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.010286] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 
0-23
[    0.010288] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.010290] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.010291] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.010292] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.010293] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.010296] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.010297] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.010305] e820: update [mem 0xbe204000-0xbe20cfff] usable ==> reserved
[    0.010313] TSC deadline timer available
[    0.010317] CPU topo: Max. logical packages:   1
[    0.010318] CPU topo: Max. logical dies:       1
[    0.010319] CPU topo: Max. dies per package:   1
[    0.010323] CPU topo: Max. threads per core:   2
[    0.010324] CPU topo: Num. cores per package:     8
[    0.010324] CPU topo: Num. threads per package:  16
[    0.010325] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.010341] kvm-guest: APIC: eoi() replaced with 
kvm_guest_apic_eoi_write()
[    0.010349] kvm-guest: KVM setup pv remote TLB flush
[    0.010351] kvm-guest: setup PV sched yield
[    0.010362] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.010364] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000fffff]
[    0.010365] PM: hibernation: Registered nosave memory: [mem 
0x00800000-0x00807fff]
[    0.010366] PM: hibernation: Registered nosave memory: [mem 
0x00810000-0x008fffff]
[    0.010368] PM: hibernation: Registered nosave memory: [mem 
0xbe1fa000-0xbe1fafff]
[    0.010369] PM: hibernation: Registered nosave memory: [mem 
0xbe203000-0xbe203fff]
[    0.010369] PM: hibernation: Registered nosave memory: [mem 
0xbe204000-0xbe20cfff]
[    0.010371] PM: hibernation: Registered nosave memory: [mem 
0xbf6ef000-0xbf96efff]
[    0.010371] PM: hibernation: Registered nosave memory: [mem 
0xbf96f000-0xbf97efff]
[    0.010372] PM: hibernation: Registered nosave memory: [mem 
0xbf97f000-0xbf9fefff]
[    0.010373] PM: hibernation: Registered nosave memory: [mem 
0xbfe7c000-0xbfefffff]
[    0.010373] PM: hibernation: Registered nosave memory: [mem 
0xbff00000-0xbfffffff]
[    0.010374] PM: hibernation: Registered nosave memory: [mem 
0xc0000000-0xffffffff]
[    0.010376] [mem 0xc0000000-0xffffffff] available for PCI devices
[    0.010377] Booting paravirtualized kernel on KVM
[    0.010379] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.015938] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 
nr_cpu_ids:16 nr_node_ids:1
[    0.016565] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.016571] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.016573] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.016577] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.016602] kvm-guest: PV spinlocks enabled
[    0.016604] PV qspinlock hash table entries: 256 (order: 0, 4096 
bytes, linear)
[    0.016607] Kernel command line: 
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-rc4-ge8f994e752e1 
root=/dev/mapper/ocivolume-root ro crashkernel=auto LANG=en_US.UTF-8 
console=tty0 console=ttyS0,115200 rd.luks=0 rd.md=0 rd.dm=0 
rd.lvm.vg=ocivolume rd.lvm.lv=ocivolume/root rd.net.timeout.carrier=5 
netroot=iscsi:169.254.0.2:::1:iqn.2015-02.oracle.boot:uefi 
rd.iscsi.param=node.session.timeo.replacement_timeout=6000 net.ifnames=1 
nvme_core.shutdown_timeout=10 ipmi_si.tryacpi=0 ipmi_si.trydmi=0 
libiscsi.debug_libiscsi_eh=1 loglevel=4 ip=dhcp,dhcp6 
rd.net.timeout.dhcp=10 crash_kexec_post_notifiers
[    0.016877] Unknown kernel command line parameters 
"BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-rc4-ge8f994e752e1 LANG=en_US.UTF-8 
netroot=iscsi:169.254.0.2:::1:iqn.2015-02.oracle.boot:uefi 
ip=dhcp,dhcp6", will be passed to user space.
[    0.016897] random: crng init done
[    0.020224] Dentry cache hash table entries: 8388608 (order: 14, 
67108864 bytes, linear)
[    0.021894] Inode-cache hash table entries: 4194304 (order: 13, 
33554432 bytes, linear)
[    0.021997] Fallback order for Node 0: 0
[    0.022001] Built 1 zonelists, mobility grouping on.  Total pages: 
33552915
[    0.022002] Policy zone: Normal
[    0.022004] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.022009] software IO TLB: area num 16.
[    0.043364] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.043396] ftrace: allocating 54211 entries in 212 pages
[    0.054792] ftrace: allocated 212 pages with 4 groups
[    0.055553] Dynamic Preempt: voluntary
[    0.055620] rcu: Preemptible hierarchical RCU implementation.
[    0.055621] rcu:     RCU restricting CPUs from NR_CPUS=8192 to 
nr_cpu_ids=16.
[    0.055622]  Trampoline variant of Tasks RCU enabled.
[    0.055623]  Rude variant of Tasks RCU enabled.
[    0.055623]  Tracing variant of Tasks RCU enabled.
[    0.055623] rcu: RCU calculated value of scheduler-enlistment delay 
is 100 jiffies.
[    0.055624] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.055634] RCU Tasks: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.055636] RCU Tasks Rude: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.055638] RCU Tasks Trace: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.058342] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.058536] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.058593] Console: colour dummy device 80x25
[    0.058595] printk: legacy console [tty0] enabled
[    0.058669] printk: legacy console [ttyS0] enabled
[    0.058708] ACPI: Core revision 20240827
[    0.058825] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604467 ns
[    0.058914] APIC: Switch to symmetric I/O mode setup
[    0.059050] x2apic enabled
[    0.059241] APIC: Switched APIC routing to: physical x2apic
[    0.059245] kvm-guest: APIC: send_IPI_mask() replaced with 
kvm_send_ipi_mask()
[    0.059248] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with 
kvm_send_ipi_mask_allbutself()
[    0.059250] kvm-guest: setup PV IPIs
[    0.059932] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.059948] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x233f75bfd04, max_idle_ns: 440795297075 ns
[    0.059953] Calibrating delay loop (skipped) preset value.. 4890.64 
BogoMIPS (lpj=2445322)
[    0.060034] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.060091] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.060092] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.060098] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.060101] Spectre V2 : Mitigation: Retpolines
[    0.060102] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.060103] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.060104] Spectre V2 : Enabling Restricted Speculation for firmware 
calls
[    0.060106] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[    0.060107] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.060110] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[    0.060111] Speculative Return Stack Overflow: IBPB-extending 
microcode not applied!
[    0.060112] Speculative Return Stack Overflow: WARNING: See 
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for 
mitigation options.
[    0.060113] Speculative Return Stack Overflow: Vulnerable: Safe RET, 
no microcode
[    0.060126] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.060128] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.060128] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.060129] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys 
User registers'
[    0.060131] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.060132] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.060133] x86/fpu: Enabled xstate features 0x207, context size is 
840 bytes, using 'compacted' format.
[    0.089741] Freeing SMP alternatives memory: 44K
[    0.089745] pid_max: default: 32768 minimum: 301
[    0.092531] LSM: initializing 
lsm=lockdown,capability,yama,selinux,ima,evm
[    0.092582] Yama: becoming mindful.
[    0.092591] SELinux:  Initializing.
[    0.092964] Mount-cache hash table entries: 131072 (order: 8, 1048576 
bytes, linear)
[    0.093025] Mountpoint-cache hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    0.093346] smpboot: CPU0: AMD EPYC 7J13 64-Core Processor (family: 
0x19, model: 0x1, stepping: 0x1)
[    0.094118] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.094151] ... version:                0
[    0.094153] ... bit width:              48
[    0.094154] ... generic registers:      6
[    0.094156] ... value mask:             0000ffffffffffff
[    0.094158] ... max period:             00007fffffffffff
[    0.094160] ... fixed-purpose events:   0
[    0.094161] ... event mask:             000000000000003f
[    0.094267] signal: max sigframe size: 3376
[    0.094304] rcu: Hierarchical SRCU implementation.
[    0.094306] rcu:     Max phase no-delay instances is 400.
[    0.094361] Timer migration: 2 hierarchy levels; 8 children per 
group; 2 crossnode level
[    0.098965] smp: Bringing up secondary CPUs ...
[    0.099114] smpboot: x86: Booting SMP configuration:
[    0.099116] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14 #1 
  #3  #5  #7  #9 #11 #13 #15
[    0.108037] smp: Brought up 1 node, 16 CPUs
[    0.108043] smpboot: Total of 16 processors activated (78250.30 BogoMIPS)
[    0.159990] node 0 deferred pages initialised in 51ms
[    0.160046] Memory: 131807404K/134211660K available (18432K kernel 
code, 5906K rwdata, 8816K rodata, 4636K init, 6600K bss, 2391816K 
reserved, 0K cma-reserved)
[    0.163026] devtmpfs: initialized
[    0.163026] x86/mm: Memory block size: 1024MB
[    0.166139] ACPI: PM: Registering ACPI NVS region [mem 
0x00800000-0x00807fff] (32768 bytes)
[    0.166139] ACPI: PM: Registering ACPI NVS region [mem 
0x00810000-0x008fffff] (983040 bytes)
[    0.166139] ACPI: PM: Registering ACPI NVS region [mem 
0xbf97f000-0xbf9fefff] (524288 bytes)
[    0.166139] ACPI: PM: Registering ACPI NVS region [mem 
0xbff00000-0xbfffffff] (1048576 bytes)
[    0.166139] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.166139] futex hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[    0.166203] pinctrl core: initialized pinctrl subsystem
[    0.166930] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.167265] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic 
allocations
[    0.167271] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.167275] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.167285] audit: initializing netlink subsys (disabled)
[    0.167298] audit: type=2000 audit(1729591723.425:1): 
state=initialized audit_enabled=0 res=1
[    0.167298] thermal_sys: Registered thermal governor 'fair_share'
[    0.167298] thermal_sys: Registered thermal governor 'bang_bang'
[    0.167298] thermal_sys: Registered thermal governor 'step_wise'
[    0.167298] thermal_sys: Registered thermal governor 'user_space'
[    0.167298] cpuidle: using governor menu
[    0.168318] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.168477] PCI: Using configuration type 1 for base access
[    0.168479] PCI: Using configuration type 1 for extended access
[    0.169170] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.169170] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.169170] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.169170] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.169170] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.170111] ACPI: Added _OSI(Module Device)
[    0.170111] ACPI: Added _OSI(Processor Device)
[    0.170111] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.170111] ACPI: Added _OSI(Processor Aggregator Device)
[    0.172032] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.173301] ACPI: Interpreter enabled
[    0.173301] ACPI: PM: (supports S0 S3 S4 S5)
[    0.173301] ACPI: Using IOAPIC for interrupt routing
[    0.173301] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.173301] PCI: Using E820 reservations for host bridge windows
[    0.173301] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.180029] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.180036] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI EDR HPX-Type3]
[    0.180744] acpiphp: Slot [3] registered
[    0.180777] acpiphp: Slot [4] registered
[    0.180798] acpiphp: Slot [5] registered
[    0.180820] acpiphp: Slot [6] registered
[    0.180843] acpiphp: Slot [7] registered
[    0.180861] acpiphp: Slot [8] registered
[    0.180878] acpiphp: Slot [9] registered
[    0.180895] acpiphp: Slot [10] registered
[    0.180912] acpiphp: Slot [11] registered
[    0.180929] acpiphp: Slot [12] registered
[    0.180973] acpiphp: Slot [15] registered
[    0.180989] acpiphp: Slot [16] registered
[    0.181006] acpiphp: Slot [17] registered
[    0.181022] acpiphp: Slot [18] registered
[    0.181040] acpiphp: Slot [19] registered
[    0.181056] acpiphp: Slot [20] registered
[    0.181072] acpiphp: Slot [21] registered
[    0.181089] acpiphp: Slot [22] registered
[    0.181105] acpiphp: Slot [23] registered
[    0.181121] acpiphp: Slot [24] registered
[    0.181137] acpiphp: Slot [25] registered
[    0.181154] acpiphp: Slot [26] registered
[    0.181171] acpiphp: Slot [27] registered
[    0.181187] acpiphp: Slot [28] registered
[    0.181205] acpiphp: Slot [29] registered
[    0.181221] acpiphp: Slot [30] registered
[    0.181237] acpiphp: Slot [31] registered
[    0.181247] PCI host bridge to bus 0000:00
[    0.181252] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.181255] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.181258] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.181260] pci_bus 0000:00: root bus resource [mem 
0xc0000000-0xfebfffff window]
[    0.181262] pci_bus 0000:00: root bus resource [mem 
0x2800000000-0x287fffffff window]
[    0.181265] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.181389] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 
conventional PCI endpoint
[    0.181762] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 
conventional PCI endpoint
[    0.182209] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 
conventional PCI endpoint
[    0.185434] pci 0000:00:01.1: BAR 4 [io  0xe020-0xe02f]
[    0.186229] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.186232] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.186234] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.186236] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.186357] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300 
conventional PCI endpoint
[    0.188399] pci 0000:00:01.2: BAR 4 [io  0xe000-0xe01f]
[    0.189321] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 
conventional PCI endpoint
[    0.189644] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by 
PIIX4 ACPI
[    0.189653] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by 
PIIX4 SMB
[    0.189851] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000 
conventional PCI endpoint
[    0.192958] pci 0000:00:02.0: BAR 0 [mem 0xc0000000-0xc0ffffff pref]
[    0.196725] pci 0000:00:02.0: BAR 2 [mem 0xc1410000-0xc1410fff]
[    0.201736] pci 0000:00:02.0: ROM [mem 0xffff0000-0xffffffff pref]
[    0.201788] pci 0000:00:02.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.202164] pci 0000:00:03.0: [15b3:101e] type 00 class 0x020000 PCIe 
Endpoint
[    0.203427] pci 0000:00:03.0: BAR 0 [mem 0x2800000000-0x28001fffff 
64bit pref]
[    0.209424] pci 0000:00:03.0: enabling Extended Tags
[    0.210042] pci 0000:00:03.0: 0.000 Gb/s available PCIe bandwidth, 
limited by Unknown x0 link at 0000:00:03.0 (capable of 126.024 Gb/s with 
16.0 GT/s PCIe x8 link)
[    0.210318] pci 0000:00:0d.0: [1b36:0001] type 01 class 0x060400 
conventional PCI bridge
[    0.211303] pci 0000:00:0d.0: BAR 0 [mem 0x2800401000-0x28004010ff 64bit]
[    0.211964] pci 0000:00:0d.0: PCI bridge to [bus 01]
[    0.211983] pci 0000:00:0d.0:   bridge window [io  0xd000-0xdfff]
[    0.211996] pci 0000:00:0d.0:   bridge window [mem 0xc1200000-0xc13fffff]
[    0.212368] pci 0000:00:0d.0:   bridge window [mem 
0x2800200000-0x28002fffff 64bit pref]
[    0.213036] pci 0000:00:0e.0: [1b36:0001] type 01 class 0x060400 
conventional PCI bridge
[    0.213955] pci 0000:00:0e.0: BAR 0 [mem 0x2800400000-0x28004000ff 64bit]
[    0.214631] pci 0000:00:0e.0: PCI bridge to [bus 02]
[    0.214650] pci 0000:00:0e.0:   bridge window [io  0xc000-0xcfff]
[    0.214663] pci 0000:00:0e.0:   bridge window [mem 0xc1000000-0xc11fffff]
[    0.214978] pci 0000:00:0e.0:   bridge window [mem 
0x2800300000-0x28003fffff 64bit pref]
[    0.217732] pci_bus 0000:01: extended config space not accessible
[    0.218041] acpiphp: Slot [0] registered
[    0.218070] acpiphp: Slot [1] registered
[    0.218087] acpiphp: Slot [2] registered
[    0.218108] acpiphp: Slot [3-2] registered
[    0.218129] acpiphp: Slot [4-2] registered
[    0.218149] acpiphp: Slot [5-2] registered
[    0.218179] acpiphp: Slot [6-2] registered
[    0.218200] acpiphp: Slot [7-2] registered
[    0.218221] acpiphp: Slot [8-2] registered
[    0.218241] acpiphp: Slot [9-2] registered
[    0.218261] acpiphp: Slot [10-2] registered
[    0.218282] acpiphp: Slot [11-2] registered
[    0.218304] acpiphp: Slot [12-2] registered
[    0.218321] acpiphp: Slot [13] registered
[    0.218338] acpiphp: Slot [14] registered
[    0.218358] acpiphp: Slot [15-2] registered
[    0.218380] acpiphp: Slot [16-2] registered
[    0.218400] acpiphp: Slot [17-2] registered
[    0.218421] acpiphp: Slot [18-2] registered
[    0.218441] acpiphp: Slot [19-2] registered
[    0.218461] acpiphp: Slot [20-2] registered
[    0.218482] acpiphp: Slot [21-2] registered
[    0.218503] acpiphp: Slot [22-2] registered
[    0.218524] acpiphp: Slot [23-2] registered
[    0.218544] acpiphp: Slot [24-2] registered
[    0.218565] acpiphp: Slot [25-2] registered
[    0.218585] acpiphp: Slot [26-2] registered
[    0.218605] acpiphp: Slot [27-2] registered
[    0.218625] acpiphp: Slot [28-2] registered
[    0.218648] acpiphp: Slot [29-2] registered
[    0.218668] acpiphp: Slot [30-2] registered
[    0.218690] acpiphp: Slot [31-2] registered
[    0.218763] pci 0000:01:00.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.219367] pci 0000:01:00.0: BAR 0 [io  0xd000-0xd03f]
[    0.219955] pci 0000:01:00.0: BAR 1 [mem 0xc1200000-0xc1200fff]
[    0.222955] pci 0000:01:00.0: BAR 4 [mem 0x2800200000-0x2800203fff 
64bit pref]
[    0.224516] pci 0000:00:0d.0: PCI bridge to [bus 01]
[    0.225060] pci_bus 0000:02: extended config space not accessible
[    0.225375] acpiphp: Slot [0-2] registered
[    0.225398] acpiphp: Slot [1-2] registered
[    0.225422] acpiphp: Slot [2-2] registered
[    0.225443] acpiphp: Slot [3-3] registered
[    0.225465] acpiphp: Slot [4-3] registered
[    0.225486] acpiphp: Slot [5-3] registered
[    0.225507] acpiphp: Slot [6-3] registered
[    0.225528] acpiphp: Slot [7-3] registered
[    0.225549] acpiphp: Slot [8-3] registered
[    0.225571] acpiphp: Slot [9-3] registered
[    0.225593] acpiphp: Slot [10-3] registered
[    0.225618] acpiphp: Slot [11-3] registered
[    0.225646] acpiphp: Slot [12-3] registered
[    0.225670] acpiphp: Slot [13-2] registered
[    0.225690] acpiphp: Slot [14-2] registered
[    0.225712] acpiphp: Slot [15-3] registered
[    0.225733] acpiphp: Slot [16-3] registered
[    0.225756] acpiphp: Slot [17-3] registered
[    0.225777] acpiphp: Slot [18-3] registered
[    0.225799] acpiphp: Slot [19-3] registered
[    0.225834] acpiphp: Slot [20-3] registered
[    0.225856] acpiphp: Slot [21-3] registered
[    0.225878] acpiphp: Slot [22-3] registered
[    0.225899] acpiphp: Slot [23-3] registered
[    0.225923] acpiphp: Slot [24-3] registered
[    0.225945] acpiphp: Slot [25-3] registered
[    0.225969] acpiphp: Slot [26-3] registered
[    0.225991] acpiphp: Slot [27-3] registered
[    0.226013] acpiphp: Slot [28-3] registered
[    0.226034] acpiphp: Slot [29-3] registered
[    0.226056] acpiphp: Slot [30-3] registered
[    0.226078] acpiphp: Slot [31-3] registered
[    0.226153] pci 0000:02:00.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.228394] pci 0000:02:00.0: BAR 0 [io  0xc140-0xc17f]
[    0.228956] pci 0000:02:00.0: BAR 1 [mem 0xc1005000-0xc1005fff]
[    0.231955] pci 0000:02:00.0: BAR 4 [mem 0x2800314000-0x2800317fff 
64bit pref]
[    0.233232] pci 0000:02:01.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.233958] pci 0000:02:01.0: BAR 0 [io  0xc100-0xc13f]
[    0.234955] pci 0000:02:01.0: BAR 1 [mem 0xc1004000-0xc1004fff]
[    0.240454] pci 0000:02:01.0: BAR 4 [mem 0x2800310000-0x2800313fff 
64bit pref]
[    0.241425] pci 0000:02:02.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.242585] pci 0000:02:02.0: BAR 0 [io  0xc0c0-0xc0ff]
[    0.243592] pci 0000:02:02.0: BAR 1 [mem 0xc1003000-0xc1003fff]
[    0.247599] pci 0000:02:02.0: BAR 4 [mem 0x280030c000-0x280030ffff 
64bit pref]
[    0.249045] pci 0000:02:03.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.251490] pci 0000:02:03.0: BAR 0 [io  0xc080-0xc0bf]
[    0.252436] pci 0000:02:03.0: BAR 1 [mem 0xc1002000-0xc1002fff]
[    0.255443] pci 0000:02:03.0: BAR 4 [mem 0x2800308000-0x280030bfff 
64bit pref]
[    0.257432] pci 0000:02:04.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.258575] pci 0000:02:04.0: BAR 0 [io  0xc040-0xc07f]
[    0.259572] pci 0000:02:04.0: BAR 1 [mem 0xc1001000-0xc1001fff]
[    0.263835] pci 0000:02:04.0: BAR 4 [mem 0x2800304000-0x2800307fff 
64bit pref]
[    0.265839] pci 0000:02:05.0: [1af4:1004] type 00 class 0x010000 
conventional PCI endpoint
[    0.266385] pci 0000:02:05.0: BAR 0 [io  0xc000-0xc03f]
[    0.266955] pci 0000:02:05.0: BAR 1 [mem 0xc1000000-0xc1000fff]
[    0.269955] pci 0000:02:05.0: BAR 4 [mem 0x2800300000-0x2800303fff 
64bit pref]
[    0.271486] pci 0000:00:0e.0: PCI bridge to [bus 02]
[    0.275010] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.275112] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.275205] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.275296] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.275344] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.276299] iommu: Default domain type: Passthrough
[    0.276299] SCSI subsystem initialized
[    0.276299] ACPI: bus type USB registered
[    0.276299] usbcore: registered new interface driver usbfs
[    0.276299] usbcore: registered new interface driver hub
[    0.276299] usbcore: registered new device driver usb
[    0.276299] pps_core: LinuxPPS API ver. 1 registered
[    0.276299] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.276299] PTP clock support registered
[    0.276977] EDAC MC: Ver: 3.0.0
[    0.277122] efivars: Registered efivars operations
[    0.277241] NetLabel: Initializing
[    0.277243] NetLabel:  domain hash size = 128
[    0.277245] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.277265] NetLabel:  unlabeled traffic allowed by default
[    0.277267] PCI: Using ACPI for IRQ routing
[    0.277269] PCI: pci_cache_line_size set to 64 bytes
[    0.277471] e820: reserve RAM buffer [mem 0x00810000-0x008fffff]
[    0.277474] e820: reserve RAM buffer [mem 0xbe1fa018-0xbfffffff]
[    0.277476] e820: reserve RAM buffer [mem 0xbe204000-0xbfffffff]
[    0.277478] e820: reserve RAM buffer [mem 0xbf6ef000-0xbfffffff]
[    0.277480] e820: reserve RAM buffer [mem 0xbfe7c000-0xbfffffff]
[    0.278004] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.278004] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.278004] pci 0000:00:02.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.278004] vgaarb: loaded
[    0.278177] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.278185] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.282053] clocksource: Switched to clocksource kvm-clock
[    0.282381] VFS: Disk quotas dquot_6.6.0
[    0.282393] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.282461] pnp: PnP ACPI init
[    0.282580] pnp 00:03: [dma 2]
[    0.282936] pnp: PnP ACPI: found 5 devices
[    0.290539] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.290610] NET: Registered PF_INET protocol family
[    0.290745] IP idents hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.293435] tcp_listen_portaddr_hash hash table entries: 65536 
(order: 8, 1048576 bytes, linear)
[    0.293512] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.293520] TCP established hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.293876] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.294012] TCP: Hash tables configured (established 524288 bind 65536)
[    0.294196] MPTCP token hash table entries: 65536 (order: 8, 1572864 
bytes, linear)
[    0.294259] UDP hash table entries: 65536 (order: 9, 2097152 bytes, 
linear)
[    0.294455] UDP-Lite hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.294684] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.294692] NET: Registered PF_XDP protocol family
[    0.294701] pci 0000:00:0d.0: PCI bridge to [bus 01]
[    0.294717] pci 0000:00:0d.0:   bridge window [io  0xd000-0xdfff]
[    0.295517] pci 0000:00:0d.0:   bridge window [mem 0xc1200000-0xc13fffff]
[    0.296000] pci 0000:00:0d.0:   bridge window [mem 
0x2800200000-0x28002fffff 64bit pref]
[    0.296922] pci 0000:00:0e.0: PCI bridge to [bus 02]
[    0.296946] pci 0000:00:0e.0:   bridge window [io  0xc000-0xcfff]
[    0.297640] pci 0000:00:0e.0:   bridge window [mem 0xc1000000-0xc11fffff]
[    0.298105] pci 0000:00:0e.0:   bridge window [mem 
0x2800300000-0x28003fffff 64bit pref]
[    0.299021] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.299025] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.299027] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.299030] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff 
window]
[    0.299032] pci_bus 0000:00: resource 8 [mem 
0x2800000000-0x287fffffff window]
[    0.299035] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.299037] pci_bus 0000:01: resource 1 [mem 0xc1200000-0xc13fffff]
[    0.299040] pci_bus 0000:01: resource 2 [mem 
0x2800200000-0x28002fffff 64bit pref]
[    0.299042] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.299044] pci_bus 0000:02: resource 1 [mem 0xc1000000-0xc11fffff]
[    0.299047] pci_bus 0000:02: resource 2 [mem 
0x2800300000-0x28003fffff 64bit pref]
[    0.299181] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.299194] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.330370] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.361660] pci 0000:00:01.2: quirk_usb_early_handoff+0x0/0x6c0 took 
60970 usecs
[    0.361776] PCI: CLS 0 bytes, default 64
[    0.361816] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.361818] software IO TLB: mapped [mem 
0x00000000b7dfe000-0x00000000bbdfe000] (64MB)
[    0.361884] Trying to unpack rootfs image as initramfs...
[    0.366339] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x233f75bfd04, max_idle_ns: 440795297075 ns
[    0.370487] Initialise system trusted keyrings
[    0.370503] Key type blacklist registered
[    0.370580] workingset: timestamp_bits=36 max_order=25 bucket_order=0
[    0.370590] zbud: loaded
[    0.371461] integrity: Platform Keyring initialized
[    0.371467] integrity: Machine keyring initialized
[    0.371469] Allocating IMA blacklist keyring.
[    0.383287] NET: Registered PF_ALG protocol family
[    0.383292] Key type asymmetric registered
[    0.383294] Asymmetric key parser 'x509' registered
[    0.383296] Key type pkcs7_test registered
[    1.184057] Freeing initrd memory: 73428K
[    1.188531] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 246)
[    1.188605] io scheduler mq-deadline registered
[    1.188608] io scheduler kyber registered
[    1.188625] io scheduler bfq registered
[    1.190588] atomic64_test: passed for x86-64 platform with CX8 and 
with SSE
[    1.191032] shpchp 0000:00:0d.0: Requesting control of SHPC hotplug 
via OSHP (\_SB_.PCI0.S68_)
[    1.191042] shpchp 0000:00:0d.0: Requesting control of SHPC hotplug 
via OSHP (\_SB_.PCI0)
[    1.191050] shpchp 0000:00:0d.0: Cannot get control of SHPC hotplug
[    1.191087] shpchp 0000:00:0e.0: Requesting control of SHPC hotplug 
via OSHP (\_SB_.PCI0.S70_)
[    1.191094] shpchp 0000:00:0e.0: Requesting control of SHPC hotplug 
via OSHP (\_SB_.PCI0)
[    1.191098] shpchp 0000:00:0e.0: Cannot get control of SHPC hotplug
[    1.191108] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.191262] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.191358] ACPI: button: Power Button [PWRF]
[    1.191401] input: Sleep Button as 
/devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    1.191461] ACPI: button: Sleep Button [SLPF]
[    1.192870] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.193046] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    1.193688] Non-volatile memory driver v1.3
[    1.193691] Linux agpgart interface v0.103
[    1.195189] rdac: device handler registered
[    1.195253] hp_sw: device handler registered
[    1.195256] emc: device handler registered
[    1.195306] alua: device handler registered
[    1.195560] VFIO - User Level meta-driver version: 0.3
[    1.227222] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    1.227304] uhci_hcd 0000:00:01.2: new USB bus registered, assigned 
bus number 1
[    1.227321] uhci_hcd 0000:00:01.2: detected 2 ports
[    1.227410] uhci_hcd 0000:00:01.2: irq 11, io port 0x0000e000
[    1.227524] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0001, bcdDevice= 6.12
[    1.227528] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    1.227530] usb usb1: Product: UHCI Host Controller
[    1.227532] usb usb1: Manufacturer: Linux 6.12.0-rc4-ge8f994e752e1 
uhci_hcd
[    1.227535] usb usb1: SerialNumber: 0000:00:01.2
[    1.227677] hub 1-0:1.0: USB hub found
[    1.227687] hub 1-0:1.0: 2 ports detected
[    1.227867] usbcore: registered new interface driver usbserial_generic
[    1.227874] usbserial: USB Serial support registered for generic
[    1.227913] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 
0x60,0x64 irq 1,12
[    1.228538] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.228545] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.228666] mousedev: PS/2 mouse device common for all mice
[    1.228977] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input2
[    1.229107] rtc_cmos 00:00: RTC can wake from S4
[    1.229881] input: VirtualPS/2 VMware VMMouse as 
/devices/platform/i8042/serio1/input/input5
[    1.230218] input: VirtualPS/2 VMware VMMouse as 
/devices/platform/i8042/serio1/input/input4
[    1.230314] rtc_cmos 00:00: registered as rtc0
[    1.230379] rtc_cmos 00:00: setting system clock to 
2024-10-22T10:08:44 UTC (1729591724)
[    1.230445] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram
[    1.230674] amd_pstate: the _CPC object is not present in SBIOS or 
ACPI disabled
[    1.230802] efifb: probing for efifb
[    1.230826] efifb: showing boot graphics
[    1.231517] efifb: framebuffer at 0xc0000000, using 1876k, total 1875k
[    1.231519] efifb: mode is 800x600x32, linelength=3200, pages=1
[    1.231522] efifb: scrolling: redraw
[    1.231523] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.231584] fbcon: Deferring console take-over
[    1.231586] fb0: EFI VGA frame buffer device
[    1.231611] hid: raw HID events driver (C) Jiri Kosina
[    1.231732] usbcore: registered new interface driver usbhid
[    1.231734] usbhid: USB HID core driver
[    1.231800] drop_monitor: Initializing network drop monitor service
[    1.231891] Initializing XFRM netlink socket
[    1.231921] NET: Registered PF_INET6 protocol family
[    1.232303] Segment Routing with IPv6
[    1.232314] In-situ OAM (IOAM) with IPv6
[    1.232336] NET: Registered PF_PACKET protocol family
[    1.232345] bridge: filtering via arp/ip/ip6tables is no longer 
available by default. Update your scripts to load br_netfilter if you 
need this.
[    1.232472] sctp: Hash tables configured (bind 2048/2048)
[    1.232508] tipc: Activated (version 2.0.0)
[    1.232530] NET: Registered PF_TIPC protocol family
[    1.232566] tipc: Started in single node mode
[    1.233858] IPI shorthand broadcast: enabled
[    1.236388] sched_clock: Marking stable (1235002986, 
409682)->(1238644994, -3232326)
[    1.236687] registered taskstats version 1
[    1.237696] Loading compiled-in X.509 certificates
[    1.245277] Loaded X.509 cert 'Build time autogenerated kernel key: 
0ec1ef2cc4b8a3e8d8d68ea1e6a2a1b1fa52a0e7'
[    1.248603] Demotion targets for Node 0: null
[    1.248612] page_owner is disabled
[    1.248816] Key type .fscrypt registered
[    1.248819] Key type fscrypt-provisioning registered
[    1.254132] cryptd: max_cpu_qlen set to 1000
[    1.257270] AES CTR mode by8 optimization enabled
[    1.271994] Key type encrypted registered
[    1.272087] ima: No TPM chip found, activating TPM-bypass!
[    1.272091] Loading compiled-in module X.509 certificates
[    1.272520] Loaded X.509 cert 'Build time autogenerated kernel key: 
0ec1ef2cc4b8a3e8d8d68ea1e6a2a1b1fa52a0e7'
[    1.272524] ima: Allocated hash algorithm: sha256
[    1.272535] ima: No architecture policies found
[    1.272555] evm: Initialising EVM extended attributes:
[    1.272556] evm: security.selinux
[    1.272558] evm: security.SMACK64 (disabled)
[    1.272560] evm: security.SMACK64EXEC (disabled)
[    1.272562] evm: security.SMACK64TRANSMUTE (disabled)
[    1.272563] evm: security.SMACK64MMAP (disabled)
[    1.272565] evm: security.apparmor (disabled)
[    1.272566] evm: security.ima
[    1.272568] evm: security.capability
[    1.272569] evm: HMAC attrs: 0x1
[    1.278150] RAS: Correctable Errors collector initialized.
[    1.278221] clk: Disabling unused clocks
[    1.278601] integrity: Unable to open file: /etc/keys/x509_ima.der (-2)
[    1.280221] Freeing unused decrypted memory: 2028K
[    1.280768] fbcon: Taking over console
[    1.281428] Freeing unused kernel image (initmem) memory: 4636K
[    1.281441] Write protecting the kernel read-only data: 28672k
[    1.282052] Freeing unused kernel image (rodata/data gap) memory: 1424K
[    1.282057] rodata_test: all tests were successful
[    1.282065] Run /init as init process
[    1.282066]   with arguments:
[    1.282068]     /init
[    1.282070]   with environment:
[    1.282072]     HOME=/
[    1.282074]     TERM=linux
[    1.282076]     BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.12.0-rc4-ge8f994e752e1
[    1.282078]     LANG=en_US.UTF-8
[    1.282079] netroot=iscsi:169.254.0.2:::1:iqn.2015-02.oracle.boot:uefi
[    1.282081]     ip=dhcp,dhcp6
[    1.282175] Console: switching to colour frame buffer device 100x37
[    1.292802] systemd[1]: systemd 239 (239-78.0.3.el8) running in 
system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP 
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS 
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[    1.292847] systemd[1]: Detected virtualization kvm.
[    1.292851] systemd[1]: Detected architecture x86-64.
[    1.292854] systemd[1]: Running in initial RAM disk.
[    1.306900] systemd[1]: No hostname configured.
[    1.306906] systemd[1]: Set hostname to <localhost>.
[    1.306967] systemd[1]: Initializing machine ID from KVM UUID.
[    1.366385] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.367054] systemd[1]: Listening on Open-iSCSI iscsid Socket.
[    1.367792] systemd[1]: Reached target Swap.
[    1.411190] Loading iSCSI transport class v2.0-870.
[    1.456433] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.608667] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    1.608708] device-mapper: uevent: version 1.0.3
[    1.608810] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[    1.622063] usb 1-1: New USB device found, idVendor=0627, 
idProduct=0001, bcdDevice= 0.00
[    1.622069] usb 1-1: New USB device strings: Mfr=1, Product=3, 
SerialNumber=10
[    1.622072] usb 1-1: Product: QEMU USB Tablet
[    1.622074] usb 1-1: Manufacturer: QEMU
[    1.622077] usb 1-1: SerialNumber: 28754-0000:00:01.2-1
[    1.630374] input: QEMU QEMU USB Tablet as 
/devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input6
[    1.630546] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID 
v0.01 Mouse [QEMU QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.670213] RPC: Registered named UNIX socket transport module.
[    1.670217] RPC: Registered udp transport module.
[    1.670219] RPC: Registered tcp transport module.
[    1.670220] RPC: Registered tcp-with-tls transport module.
[    1.670222] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.912115] libata version 3.00 loaded.
[    1.914119] ata_piix 0000:00:01.1: version 2.13
[    1.915467] scsi host0: scsi_eh_0: sleeping
[    1.915623] scsi host0: ata_piix
[    1.915803] scsi host1: scsi_eh_1: sleeping
[    1.915872] scsi host1: ata_piix
[    1.915930] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe020 
irq 14 lpm-pol 0
[    1.915934] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe028 
irq 15 lpm-pol 0
[    1.915978] scsi host0: scsi_eh_0: waking up 1/0/0
[    1.915987] scsi host1: scsi_eh_1: waking up 1/0/0
[    1.916066] scsi host0: waking up host to restart
[    1.916071] scsi host0: scsi_eh_0: sleeping
[    1.916135] scsi host1: waking up host to restart
[    1.916140] scsi host1: scsi_eh_1: sleeping
[    1.936504] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    2.003188] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    2.066454] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    2.132878] mlx5_core 0000:00:03.0: PTM is not supported by PCIe
[    2.132920] mlx5_core 0000:00:03.0: firmware version: 22.31.1660
[    2.200058] scsi host2: scsi_eh_2: sleeping
[    2.200149] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    2.200807] scsi host2: Virtio SCSI HBA
[    2.203783] scsi host3: scsi_eh_3: sleeping
[    2.203871] virtio_scsi virtio1: 1/0/0 default/read/poll queues
[    2.204196] scsi 2:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.204520] scsi host3: Virtio SCSI HBA
[    2.207209] scsi host4: scsi_eh_4: sleeping
[    2.207345] virtio_scsi virtio2: 1/0/0 default/read/poll queues
[    2.207439] scsi 3:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.208011] scsi host4: Virtio SCSI HBA
[    2.210543] scsi host5: scsi_eh_5: sleeping
[    2.210636] virtio_scsi virtio3: 1/0/0 default/read/poll queues
[    2.210856] scsi 4:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.211564] scsi host5: Virtio SCSI HBA
[    2.214638] scsi host6: scsi_eh_6: sleeping
[    2.214752] virtio_scsi virtio4: 1/0/0 default/read/poll queues
[    2.214846] scsi 5:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.215637] scsi host6: Virtio SCSI HBA
[    2.215838] scsi 2:0:1:1: alua: supports implicit and explicit TPGS
[    2.215846] scsi 2:0:1:1: alua: device 
naa.600140516a734e90bb1003022747ab09 port group 0 rel port 1
[    2.218762] scsi host7: scsi_eh_7: sleeping
[    2.218900] virtio_scsi virtio5: 1/0/0 default/read/poll queues
[    2.218931] scsi 6:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.219711] scsi 3:0:1:1: alua: supports implicit and explicit TPGS
[    2.219718] scsi 3:0:1:1: alua: device 
naa.6001405bcbd343a198f2444be1e421e3 port group 0 rel port 1
[    2.219943] scsi host7: Virtio SCSI HBA
[    2.223079] scsi host8: scsi_eh_8: sleeping
[    2.223251] virtio_scsi virtio6: 1/0/0 default/read/poll queues
[    2.223328] scsi 7:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.224139] scsi host8: Virtio SCSI HBA
[    2.225772] scsi 4:0:1:1: alua: supports implicit and explicit TPGS
[    2.225779] scsi 4:0:1:1: alua: device 
naa.6001405e745a4a428e2051af8471bcfc port group 0 rel port 1
[    2.227439] scsi 8:0:1:1: Direct-Access     ORACLE   BlockVolume 1.0 
PQ: 0 ANSI: 5
[    2.228198] scsi 5:0:1:1: alua: supports implicit and explicit TPGS
[    2.228205] scsi 5:0:1:1: alua: device 
naa.600140541ab847d580575aaa275fba74 port group 0 rel port 1
[    2.232192] scsi 6:0:1:1: alua: supports implicit and explicit TPGS
[    2.232199] scsi 6:0:1:1: alua: device 
naa.6001405e527541efa8f364650591481c port group 0 rel port 1
[    2.235143] scsi 7:0:1:1: alua: supports implicit and explicit TPGS
[    2.235148] scsi 7:0:1:1: alua: device 
naa.60014059e21a4073a4b86c0926e500df port group 0 rel port 1
[    2.238873] scsi 8:0:1:1: alua: supports implicit and explicit TPGS
[    2.238879] scsi 8:0:1:1: alua: device 
naa.600140513a73428e9ccd548ba60a71c5 port group 0 rel port 1
[    2.244256] scsi 2:0:1:1: Attached scsi generic sg0 type 0
[    2.244307] scsi 3:0:1:1: Attached scsi generic sg1 type 0
[    2.244352] scsi 4:0:1:1: Attached scsi generic sg2 type 0
[    2.244391] scsi 5:0:1:1: Attached scsi generic sg3 type 0
[    2.244505] scsi 6:0:1:1: Attached scsi generic sg4 type 0
[    2.244561] scsi 7:0:1:1: Attached scsi generic sg5 type 0
[    2.244605] scsi 8:0:1:1: Attached scsi generic sg6 type 0
[    2.247768] sd 4:0:1:1: [sdb] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247775] sd 4:0:1:1: [sdb] 4096-byte physical blocks
[    2.247812] sd 8:0:1:1: [sdf] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247814] sd 4:0:1:1: [sdb] Write Protect is off
[    2.247817] sd 4:0:1:1: [sdb] Mode Sense: 43 00 00 08
[    2.247818] sd 8:0:1:1: [sdf] 4096-byte physical blocks
[    2.247822] sd 2:0:1:1: [sda] 97677312 512-byte logical blocks: (50.0 
GB/46.6 GiB)
[    2.247828] sd 2:0:1:1: [sda] 4096-byte physical blocks
[    2.247884] sd 2:0:1:1: [sda] Write Protect is off
[    2.247885] sd 8:0:1:1: [sdf] Write Protect is off
[    2.247889] sd 8:0:1:1: [sdf] Mode Sense: 43 00 00 08
[    2.247889] sd 2:0:1:1: [sda] Mode Sense: 43 00 00 08
[    2.247915] sd 4:0:1:1: [sdb] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.247931] sd 5:0:1:1: [sdd] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247937] sd 5:0:1:1: [sdd] 4096-byte physical blocks
[    2.247937] sd 6:0:1:1: [sde] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247941] sd 6:0:1:1: [sde] 4096-byte physical blocks
[    2.247955] sd 2:0:1:1: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.247956] sd 3:0:1:1: [sdc] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247971] sd 3:0:1:1: [sdc] 4096-byte physical blocks
[    2.247980] sd 8:0:1:1: [sdf] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.247995] sd 7:0:1:1: [sdg] 2147483648 512-byte logical blocks: 
(1.10 TB/1.00 TiB)
[    2.247998] sd 5:0:1:1: [sdd] Write Protect is off
[    2.247999] sd 7:0:1:1: [sdg] 4096-byte physical blocks
[    2.248003] sd 5:0:1:1: [sdd] Mode Sense: 43 00 00 08
[    2.248028] sd 7:0:1:1: [sdg] Write Protect is off
[    2.248032] sd 7:0:1:1: [sdg] Mode Sense: 43 00 00 08
[    2.248066] sd 8:0:1:1: [sdf] Preferred minimum I/O size 4096 bytes
[    2.248067] sd 5:0:1:1: [sdd] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.248070] sd 8:0:1:1: [sdf] Optimal transfer size 1048576 bytes
[    2.248088] sd 7:0:1:1: [sdg] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.248127] sd 5:0:1:1: [sdd] Preferred minimum I/O size 4096 bytes
[    2.248130] sd 5:0:1:1: [sdd] Optimal transfer size 1048576 bytes
[    2.248146] sd 7:0:1:1: [sdg] Preferred minimum I/O size 4096 bytes
[    2.248150] sd 7:0:1:1: [sdg] Optimal transfer size 1048576 bytes
[    2.261489] sd 3:0:1:1: [sdc] Write Protect is off
[    2.261494] sd 3:0:1:1: [sdc] Mode Sense: 43 00 00 08
[    2.261505] sd 6:0:1:1: [sde] Write Protect is off
[    2.261510] sd 6:0:1:1: [sde] Mode Sense: 43 00 00 08
[    2.261593] sd 3:0:1:1: [sdc] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.261624] sd 6:0:1:1: [sde] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.261648] sd 3:0:1:1: [sdc] Preferred minimum I/O size 4096 bytes
[    2.261651] sd 3:0:1:1: [sdc] Optimal transfer size 1048576 bytes
[    2.261690] sd 6:0:1:1: [sde] Preferred minimum I/O size 4096 bytes
[    2.261693] sd 6:0:1:1: [sde] Optimal transfer size 1048576 bytes
[    2.263621] sd 5:0:1:1: [sdd] Attached SCSI disk
[    2.265605] sd 7:0:1:1: [sdg] Attached SCSI disk
[    2.307864] mlx5_core 0000:00:03.0: Rate limit: 127 rates are 
supported, range: 0Mbps to 48828Mbps
[    2.397844] sd 2:0:1:1: [sda] Preferred minimum I/O size 4096 bytes
[    2.397848] sd 2:0:1:1: [sda] Optimal transfer size 1048576 bytes
[    2.397876] sd 4:0:1:1: [sdb] Preferred minimum I/O size 4096 bytes
[    2.397882] sd 4:0:1:1: [sdb] Optimal transfer size 1048576 bytes
[    2.404886] sd 3:0:1:1: [sdc] Attached SCSI disk
[    2.405607] sd 8:0:1:1: [sdf] Attached SCSI disk
[    2.413331] sd 6:0:1:1: [sde] Attached SCSI disk
[    2.432677] sd 4:0:1:1: [sdb] Attached SCSI disk
[    2.436518]  sda: sda1 sda2 sda3
[    2.436726] sd 2:0:1:1: [sda] Attached SCSI disk
[    2.495972] mlx5_core 0000:00:03.0: MLX5E: StrdRq(1) RqSz(8) 
StrdSz(2048) RxCqeCmprss(0 basic)
[    2.498736] mlx5_core 0000:00:03.0 ens3: renamed from eth0
[    2.785798] mlx5_core 0000:00:03.0 ens3: Link up
[    7.197671] iscsi: registered transport (tcp)
[   12.708818] SGI XFS with ACLs, security attributes, realtime, scrub, 
repair, quota, no debug enabled
[   12.711995] XFS (dm-0): Mounting V5 Filesystem 
8b8d3b19-9faa-4dee-b3ba-765c3515b283
[   12.768728] XFS (dm-0): Starting recovery (logdev: internal)
[   12.791358] XFS (dm-0): Ending recovery (logdev: internal)
[   13.281956] printk: systemd: 30 output lines suppressed due to 
ratelimiting
[   13.320686] audit: type=1404 audit(1729591736.590:2): enforcing=1 
old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 
lsm=selinux res=1
[   13.449726] SELinux:  Permission watch in class filesystem not 
defined in policy.
[   13.449733] SELinux:  Permission watch in class file not defined in 
policy.
[   13.449735] SELinux:  Permission watch_mount in class file not 
defined in policy.
[   13.449737] SELinux:  Permission watch_sb in class file not defined 
in policy.
[   13.449738] SELinux:  Permission watch_with_perm in class file not 
defined in policy.
[   13.449740] SELinux:  Permission watch_reads in class file not 
defined in policy.
[   13.449743] SELinux:  Permission watch in class dir not defined in 
policy.
[   13.449745] SELinux:  Permission watch_mount in class dir not defined 
in policy.
[   13.449747] SELinux:  Permission watch_sb in class dir not defined in 
policy.
[   13.449749] SELinux:  Permission watch_with_perm in class dir not 
defined in policy.
[   13.449750] SELinux:  Permission watch_reads in class dir not defined 
in policy.
[   13.449755] SELinux:  Permission watch in class lnk_file not defined 
in policy.
[   13.449756] SELinux:  Permission watch_mount in class lnk_file not 
defined in policy.
[   13.449758] SELinux:  Permission watch_sb in class lnk_file not 
defined in policy.
[   13.449760] SELinux:  Permission watch_with_perm in class lnk_file 
not defined in policy.
[   13.449761] SELinux:  Permission watch_reads in class lnk_file not 
defined in policy.
[   13.449764] SELinux:  Permission watch in class chr_file not defined 
in policy.
[   13.449766] SELinux:  Permission watch_mount in class chr_file not 
defined in policy.
[   13.449767] SELinux:  Permission watch_sb in class chr_file not 
defined in policy.
[   13.449769] SELinux:  Permission watch_with_perm in class chr_file 
not defined in policy.
[   13.449771] SELinux:  Permission watch_reads in class chr_file not 
defined in policy.
[   13.449773] SELinux:  Permission watch in class blk_file not defined 
in policy.
[   13.449775] SELinux:  Permission watch_mount in class blk_file not 
defined in policy.
[   13.449776] SELinux:  Permission watch_sb in class blk_file not 
defined in policy.
[   13.449778] SELinux:  Permission watch_with_perm in class blk_file 
not defined in policy.
[   13.449780] SELinux:  Permission watch_reads in class blk_file not 
defined in policy.
[   13.449782] SELinux:  Permission watch in class sock_file not defined 
in policy.
[   13.449784] SELinux:  Permission watch_mount in class sock_file not 
defined in policy.
[   13.449786] SELinux:  Permission watch_sb in class sock_file not 
defined in policy.
[   13.449787] SELinux:  Permission watch_with_perm in class sock_file 
not defined in policy.
[   13.449789] SELinux:  Permission watch_reads in class sock_file not 
defined in policy.
[   13.449792] SELinux:  Permission watch in class fifo_file not defined 
in policy.
[   13.449793] SELinux:  Permission watch_mount in class fifo_file not 
defined in policy.
[   13.449795] SELinux:  Permission watch_sb in class fifo_file not 
defined in policy.
[   13.449796] SELinux:  Permission watch_with_perm in class fifo_file 
not defined in policy.
[   13.449798] SELinux:  Permission watch_reads in class fifo_file not 
defined in policy.
[   13.449842] SELinux:  Permission perfmon in class capability2 not 
defined in policy.
[   13.449843] SELinux:  Permission bpf in class capability2 not defined 
in policy.
[   13.449850] SELinux:  Permission perfmon in class cap2_userns not 
defined in policy.
[   13.449851] SELinux:  Permission bpf in class cap2_userns not defined 
in policy.
[   13.449884] SELinux:  Class mctp_socket not defined in policy.
[   13.449886] SELinux:  Class anon_inode not defined in policy.
[   13.449888] SELinux:  Class io_uring not defined in policy.
[   13.449890] SELinux:  Class user_namespace not defined in policy.
[   13.449891] SELinux: the above unknown classes and permissions will 
be allowed
[   13.452920] SELinux:  policy capability network_peer_controls=1
[   13.452923] SELinux:  policy capability open_perms=1
[   13.452924] SELinux:  policy capability extended_socket_class=1
[   13.452926] SELinux:  policy capability always_check_network=0
[   13.452927] SELinux:  policy capability cgroup_seclabel=1
[   13.452929] SELinux:  policy capability nnp_nosuid_transition=1
[   13.452930] SELinux:  policy capability genfs_seclabel_symlinks=0
[   13.452932] SELinux:  policy capability ioctl_skip_cloexec=0
[   13.452933] SELinux:  policy capability userspace_initial_context=0
[   13.495918] audit: type=1403 audit(1729591736.765:3): auid=4294967295 
ses=4294967295 lsm=selinux res=1
[   13.497553] systemd[1]: Successfully loaded SELinux policy in 177.640ms.
[   13.537137] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 
25.294ms.
[   13.539979] systemd[1]: systemd 239 (239-78.0.3.el8) running in 
system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP 
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS 
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=legacy)
[   13.540014] systemd[1]: Detected virtualization kvm.
[   13.540019] systemd[1]: Detected architecture x86-64.
[   13.543914] systemd[1]: Set hostname to 
<jgarry-atomic-write-exp-e4-8-instance-20231214-1221>.
[   13.920513] systemd[1]: Configuration file 
/usr/lib/systemd/system/wlp-agent-osqueryd.service is marked executable. 
Please remove executable permission bits. Proceeding anyway.
[   13.920519] systemd[1]: Configuration file 
/usr/lib/systemd/system/wlp-agent-osqueryd.service is marked 
world-inaccessible. This has no effect as configuration data is 
accessible via APIs without restrictions. Proceeding anyway.
[   14.050676] systemd[1]: initrd-switch-root.service: Succeeded.
[   14.051194] systemd[1]: Stopped Switch Root.
[   14.052258] systemd[1]: systemd-journald.service: Service has no 
hold-off time (RestartSec=0), scheduling restart.
[   14.052311] systemd[1]: systemd-journald.service: Scheduled restart 
job, restart counter is at 1.
[   14.088998] xfs filesystem being remounted at / supports timestamps 
until 2038-01-19 (0x7fffffff)
[   14.136047] Adding 8132604k swap on /.swapfile.  Priority:-2 
extents:2 across:35280552k
[   14.547999] piix4_smbus 0000:00:01.3: SMBus Host Controller at 
0xb100, revision 0
[   14.548040] i2c i2c-0: Memory type 0x07 not supported yet, not 
instantiating SPD
[   14.577631] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   14.582701] ACPI: bus type drm_connector registered
[   14.702381] Console: switching to colour dummy device 80x25
[   14.702434] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   14.702546] [drm] Found bochs VGA, ID 0xb0c5.
[   14.702550] [drm] Framebuffer size 16384 kB @ 0xc0000000, mmio @ 
0xc1410000.
[   14.704103] [drm] Found EDID data blob.
[   14.704367] [drm] Initialized bochs-drm 1.0.0 for 0000:00:02.0 on minor 0
[   14.705273] fbcon: bochs-drmdrmfb (fb0) is primary device
[   14.717166] kvm_amd: Nested Virtualization enabled
[   14.717169] kvm_amd: Nested Paging enabled
[   14.754315] Console: switching to colour frame buffer device 128x48
[   14.756440] bochs-drm 0000:00:02.0: [drm] fb0: bochs-drmdrmfb frame 
buffer device
[   14.798565] md127: detected capacity change from 0 to 8588877824
[   15.020099] XFS (dm-1): Mounting V5 Filesystem 
21d53c77-7876-4a1c-b4e1-a8cd74d1938c
[   15.020499] XFS (sdf): Mounting V5 Filesystem 
d9dc5ab6-ac4f-4994-8a72-33d087459466
[   15.021945] XFS (sda2): Mounting V5 Filesystem 
f7cf63bd-4975-44bb-ba99-b81e037be7e1
[   15.024276] XFS (sdc): EXPERIMENTAL: V5 Filesystem with Large Block 
Size (16384 bytes) enabled.
[   15.024890] XFS (sdc): Mounting V5 Filesystem 
714d73f3-408e-4b1a-b21d-6505fbf27bc6
[   15.079368] XFS (sda2): Ending clean mount
[   15.086230] XFS (sdc): Ending clean mount
[   15.088004] xfs filesystem being mounted at /boot supports timestamps 
until 2038-01-19 (0x7fffffff)
[   15.094004] xfs filesystem being mounted at /home/opc/mnt_16k 
supports timestamps until 2038-01-19 (0x7fffffff)
[   15.137815] XFS (sdf): Starting recovery (logdev: internal)
[   15.192601] XFS (sdf): Ending recovery (logdev: internal)
[   15.194230] XFS (dm-1): Starting recovery (logdev: internal)
[   15.199394] xfs filesystem being mounted at /home/opc/mnt_4k supports 
timestamps until 2038-01-19 (0x7fffffff)
[   15.216710] XFS (dm-1): Ending recovery (logdev: internal)
[   15.223689] xfs filesystem being mounted at /var/oled supports 
timestamps until 2038-01-19 (0x7fffffff)
[   15.536223] fuse: init (API version 7.41)
[root@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 opc]#


