Return-Path: <linux-fsdevel+bounces-35052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89999D07B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 03:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18506B21949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AE929CF4;
	Mon, 18 Nov 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="DqX/+J30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8533E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895342; cv=fail; b=He08Fq+AhDobZtuGiVGCBYg22mrog6+7mj1879VmYBXmQQ7z0YqzSSr4I6QT/VNO68h2E0qJymHWmug0KGJtpQ7mEbvSTeDRboN9wK4wLYxLcmJldk6Gk+lBBx0BUQCpDt8EJ6dCrFpHhJbwRx9pc3heTZS/Zuai6ns/TPL1/LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895342; c=relaxed/simple;
	bh=rkrl6YX8xbN+xRG04wIpN0gi4doZWCF6YW6YuY41ie0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ltZmxM85G4brzAzZTK+VtPC44mBKdo0BIah3O8MPFsf0vTs5xbibsVJ/2FU5QR6yd1RoN4wCMbfK4LSUfgp48FlNYIjmr/lt+hifLYSzMtPn6G3NspaV1kZ/nRW8Vlqybfz8FVYaaSBmju9tOdGOQ+FVaFIs4HaW5TUWt7z1Qrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=DqX/+J30; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI0xxNI007562;
	Mon, 18 Nov 2024 02:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=rkrl6YX8xbN+xRG04wIpN0gi4doZW
	CF6YW6YuY41ie0=; b=DqX/+J30byApADko54JkpwUhS0dZqADOdIcPr/9Yxuq9P
	3hsd5X+0fTb8Pp3tjJT828cI9ZBnOgM/umo+zghAVMrCjJwCFdNXiQqPWQctxtY6
	29oWyFXSVWZzRnyZTIkh6M7/PITBLLYbcAtNpnR6vk9q5pIuLgLsrxdl7j6nRogr
	VMqYKXuGnItscOiCmbU7RanlJHrbnvrQjHyOR8ii0+LdvfT0sMb/e2qtXGa8sV3v
	4gMvh7LziPSAY9aAM8UkJd9eGGdjNaTTUtNX1HIlcotIyxoeiUKFv4v95vbgKCgZ
	dVWQazU6nWN2zVUCYODlq1/cOPHolw+7fgK2wrS3A==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2043.outbound.protection.outlook.com [104.47.110.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xmc3s3s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:01:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw+E0GX6EX0lnnYpqDbRigDS0SyLb/QRJDhKH2ytwX1kVMQbuomGCD0tAxu3/v7yE7rMPVpYJxNyWDKshEvU2vQ5+JeZrI3+r2UM6lPVWTJXYADu/T+0WBxKdEV+XqzfLibrtqhATZf7hP6Ww2Ax51Mv3cv5qNyhOhQfeYaOTlxSgbvq69+EEPYZpV0Udm484eDQAcVfm/8acWXL/5jV6MLTt0qM1xfjj7ChdxbKfnzwdzyelaFd7moAzOcZRi3UPbnbmaEvUGfpbDr8xnJXvNs65T7nnmBQBsLOkxiJ51vC/zMxEu30Ah7VTC0c29k6jIDCeOWjWSc5QstZlCuDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkrl6YX8xbN+xRG04wIpN0gi4doZWCF6YW6YuY41ie0=;
 b=KNsl4UCY6t1MqOQHU/q9033pQSCdjs025lmorQC4H1YWyLpbM+i0x0VKtjb5VTwR9gPAaSDghMyThy+SrKMJg2go5SZIt11ukN97zYeF5phuTMWodn1Q4TuMrAKZcWUV6rqJtxY/3FXeYYktHjDDF6FsXSB/d3bWg+iT4YYJ6G45k9TnlO65pusqk0RwBCmFS9KY6/30upeAm5LS+GYmZ7nb7/vinHGeqxfYxFrstQcZQu0Nosu+SGQVBy8WOr4/TLFHe8Rp9J50/VvTy4QUO9JhKY1+Fbiqz2qH9gFo1HE57C1O343sGOmjXHeSer6VLIrZYeLLfh0Kr/0phTqAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6119.apcprd04.prod.outlook.com (2603:1096:400:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:01:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Mon, 18 Nov 2024
 02:01:51 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v3 2/7] exfat: rename argument name for exfat_move_file and
 exfat_rename_file
Thread-Topic: [PATCH v3 2/7] exfat: rename argument name for exfat_move_file
 and exfat_rename_file
Thread-Index: Ads2/7nXFdJ14dydR3K7zKkd3b636wCXNCsA
Date: Mon, 18 Nov 2024 02:01:51 +0000
Message-ID:
 <PUZPR04MB6316AEFFC36194D9AC36A25581272@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6119:EE_
x-ms-office365-filtering-correlation-id: d42d29f2-7bdb-408d-4b62-08dd0774f83d
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWRZZXg5SHkzYWRvSEMvYUxpRGUxT3YwRDBGRGJqbTJuNFN4eUhoMTNpK1Vv?=
 =?utf-8?B?UmhXSDhOaXR2MHVya3NqMUUvMUo2SzM5Z1hLYzhNN1dvNXAvTXdoUlZ1L1ZW?=
 =?utf-8?B?MjVqcEd2U3VtM3VwMHprbVVBd2h2Mk5mblBKekRLSGNkYVpOdGxGNUJ6Z05l?=
 =?utf-8?B?b2hyVkZ6ellwbFZVc09MVVY0WmR2UGxUUEVySnBsWTBnRFpnVUM5bWtvbW4r?=
 =?utf-8?B?cTlMVjZ1UVN0bHlsa0pIVllrNG5iWG9jcU9ZWVFYUXVOYmtkQS9QK2MrajJ1?=
 =?utf-8?B?NEptMldwdHM3RmlIM1pyWUJvdnRxMUprVEN0WkxZdUVkK3ZLeE9mSTVMWXFt?=
 =?utf-8?B?T1RhM3V3UUdYZ0E1NkVka2poREhFTlBZSG0wRjBBM09ZYjRoamFtOTRudVRC?=
 =?utf-8?B?TUJYc1JTVTN4dFNibkZaNU1oMG9hU1Nyd2Q3ME9XbmFIYThxbDdwT1ZKRnFq?=
 =?utf-8?B?eDcrTkEwZWtmVjFnR0ZHVE94L2QvVTZLdkdlYWttMjQzWkNSWnBGQ1ZxT01F?=
 =?utf-8?B?Rzg3c0t4NXhvWk5uUTh3eVNXRVdQQk1PMjJaWGJxbTZ4dDJ2bGt4Mzh5bWt0?=
 =?utf-8?B?cHZ2SGZSUHJDamNMTUVPTFErb0pZcDZGQTgzN1h2VXEwL1pwUVJiL0pBNmlM?=
 =?utf-8?B?SCtUQlZ3eGxROXNPZkQzYzVOMk5mL2lRT01HVkFPOWdIWVVJSU9mVWx1UUNG?=
 =?utf-8?B?LytMTVA4WkFYTVVNS1BlTTVrTVVlVE5sNnNZN1BhczlDOWt2ejRrdlJISnZQ?=
 =?utf-8?B?d1BSZnNXRnlWVklQcVpIT1dGWDJSbTN2VzByVUVVUklNYzlUb29adU9ncmg0?=
 =?utf-8?B?TVdqbklYd2Y0Y0psci9IWUxhMmk0SXR2UlVOR1orZ1Q5d01MUHY4cXMyUnU2?=
 =?utf-8?B?ZzNQeWN6TFJrK2FWZnJXNUdROE1PRVgrQi8xZENBL3NHT2llLzhoaVJJc2Ey?=
 =?utf-8?B?KysyNU9oVnN2dGNhRVpOVDBkN2xCd2RwU0w5YmFLak5GV1FrdWhhY1FBZFp6?=
 =?utf-8?B?UmJwNTVvNVQvaFdIZnJqR0FBYUkxYVV1MlJLKzc1MDB4aHpQT2QvMVNxUmJJ?=
 =?utf-8?B?dVd5U3oyVHdUM2t2a1pOVVdrMnVHeWc3TTgvL3RpbGVnamhIZTQybUdBa1R6?=
 =?utf-8?B?YVFGMDFHZ05udGVwNnJFa1kxb2tVMlFONnB6SW5say9yWTExeDR4Zkl6Z0lE?=
 =?utf-8?B?UUpGV0ZsZHNUV1BwamRxVEFHQmFnbHJGWmtmSUpmOEZSUk9hUVVuaUN1Qlp4?=
 =?utf-8?B?Sy90Vmc2MnFQK3Z5TXUrQzZKMFVGbE11QVZkTXlqOUl0d3JwUzYrVStBMnBW?=
 =?utf-8?B?Qi9pQzArTnB5QUNBbkxyVDdXTmtQdFNtUW9Xd1hkUFhrRlBXSFRRMkNZdkpt?=
 =?utf-8?B?MmJORkZ2Skk3MFFscC9SUUk3aGU5YjZxU3R1OFBpWm51cm16Y3RrVVkydUtB?=
 =?utf-8?B?Titmekt0WVZnYmpRUVFTV0NqamF1aFY0M1ZhSks0T1RMZEYyU2pMYWVtS1Fw?=
 =?utf-8?B?czduSEVENDk3QXNYUWJONjlHMGZaQThVeGR3ZlFUMTlCelh5VzVkRzhnMzRt?=
 =?utf-8?B?aEdPRjl0M3pLbXVqdEJuWnVHSEdlSFV2RnR2V0l4bkVhT2RyUWZNUXR4Znhh?=
 =?utf-8?B?YVJ4VjlITjN0TTRwTURPdmRmTXhZK09sQ2ZNNGFOVGtvMkp5bXVPT0xxTGhv?=
 =?utf-8?B?eDdDb09FOGFKWkFpSEh2SFFsTkdBWnJFcFgzODRnK3V2WjNZSnBmb0Jzb3pL?=
 =?utf-8?B?cFZBTHV3bHJBTy9zdFNmWjB0UUh3ejl3ZDFVOWVXVUNmdndNSHpPZUJ6SzN0?=
 =?utf-8?Q?XdLVTmCkbqkz1fRWZ4+geja3efGc8xuYIY12M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2FsQW12TTdBUGYxZUJMeW5jZVE4Z2dHNU9YY3hXUk0vRjZvWHBYdm0vNC9w?=
 =?utf-8?B?bnJ6VDNyMWpnMWFYcWhNTGVEZFBXUzRXQmFvMHZ6YUtQdkVTYVExbWR6SFN2?=
 =?utf-8?B?MFhXZ1dobW9xSHZYeDVCdTVXbHNwR3BzeHRTQUZlK1lDOGQyN3liWVpOcUNL?=
 =?utf-8?B?a2t4dy9mc3FKMWlnWWFKbGVqaTl5dHBwZnkxZVQ5MFpvOVRoT3FGQnQybVpF?=
 =?utf-8?B?RE9oMFNRb05LTWgxRnpTRXFyNkQrbVoyUmplakxockxuMlJRVUNRbjY4bnpw?=
 =?utf-8?B?c1pCNy96djREUDR4RXJQaGlhMUQ4RXVBTStlTGJFcVN0QlZOSS9LQmpRQWRo?=
 =?utf-8?B?S2VRUzV2b1NlbWhIdmRUVWlQd3dPTGhrQ0FwKytpYm4xSzBrZ1lhL1dpUHJB?=
 =?utf-8?B?WWo3b3hVN3drUUJjQ1lNVHZuN2RUd0Yvd1Jkc09CYWNkZzFHQzZsTmw5UVZ4?=
 =?utf-8?B?NTJuZTFwRk1LWEZhR3FvMERvR2JnbTZVRXYwZ29pSGFiZnkva1NzenhpZW80?=
 =?utf-8?B?Szl5TUZ4TG9EaUZnQTZ6TERWMU1lOE1SV2oyZEJsMDJpMWZVdkRjckwzRlJF?=
 =?utf-8?B?MitrRFloNTZBYzZHeG1oU3M4VjVhaGZGNzU1cUpyNkg5aDM1UkVxZUZORStQ?=
 =?utf-8?B?TWptclRVQ1pjRzZ3emFuSE1mVkxGMnZiVTJKQm1aUGpIYlBYYmUrRzZJd3Y3?=
 =?utf-8?B?TUdnNTFtRjVzQml0RDBZSzJNUmVEc3hqaithVFhJR0RPeEkzOE83N3pUdFYv?=
 =?utf-8?B?Uisrb1kxZW1PdTRZVnpKREVpWktSVlBWcnZFQ0ZiU0JNeHdPQ0g5UUZTL0pr?=
 =?utf-8?B?YTBCUUM3UUs4WHhZT2RMVzJFYkNOVnBsazJKSCtka0FtMU10VmtMdFZNd0pa?=
 =?utf-8?B?eWJLYmg3QXB0ZFAySXE1c0tqaUhJUmVMckZpMi9jVU51MVdWblZpbTJSZjNu?=
 =?utf-8?B?YzB5TEM5dGZ1RVUrQXB4NDNySi9tYVdqK3dkVGVOWTFwc2JhNHVxbVdhN041?=
 =?utf-8?B?cTBqeWNjeS9yTFNtVFNudVJoM3hwVE00QzhoZlFtSHAxc3NNTzFISkRxbDFF?=
 =?utf-8?B?Tys3aThVQlNGR1J4eU9maG5KZGt0U1pId3lYcHJnZjFBdmcyWFkrdTV0ZEk3?=
 =?utf-8?B?b1dDRHJibWZtYjVIYms3RE4xcjBveXpMaStvU0lMaURERjMwdEZlY1RQbXNV?=
 =?utf-8?B?akNuUGUxblBCWlA2Z05EVS96NXIyeWNvMzZYamZLZnVTN0NneFhCMk1CRDNX?=
 =?utf-8?B?b1NZTjNmYXhaelZZWUJyODRQZXJwd1kzYWdhdTZhMmRvS21sTHptVEhrdjlr?=
 =?utf-8?B?ZW1iclFaV3BzSGdzSFU3UWdZdjdtbm9VZkszSzlDa0MzeVdTZWJkMFZ0L2Jo?=
 =?utf-8?B?Q2ROYTQydlZlQkxwdkRTMERTaUhXZVNBaC94cDJ6NUF5amZLc2hBWmloQnpH?=
 =?utf-8?B?TThoYW1pYjB3VVlyYzdoNElieWJpNW9DaGFVVXJucWJrVlc0TW40cDNOdnBr?=
 =?utf-8?B?aStCQkpBbHVrR3R6MTNvNWROMzBLMTZWcXd1Yk8wUEZIc0M0WDJZbEs4RjM4?=
 =?utf-8?B?K3k3S2hOaTB5TUVYVldKMm8wSXEvZlNFVXlaMDZPWGh5RUpTd3lpak1wbTdD?=
 =?utf-8?B?c1NMbTVjaTAvVVBrY2xRbnJ6TmhWNTFGMVp0Nno4RVN4L09BelpvQjl4dzBF?=
 =?utf-8?B?S3lpZ1lLYnhDVUdmOUk0NHc0cFpLNyt1TGtFOEdKQXFRc2RnOGFqVEIzOWUv?=
 =?utf-8?B?RkxrcmM4eUdDcG1CM2g0VHNWUkdBdDdTOXpFaUNyQUN6dURDMXdlaEpyaENm?=
 =?utf-8?B?alJzenJ5cW9RNCswRXRNblRqQy8zeVhSdjZnVXlCUHc5RkV3S245T3NTdjhW?=
 =?utf-8?B?U1Z0QW82N0kwQytBdWVDdlgxV2szeFltSVViak4vRXM1VjlIQms2cFFXNGRx?=
 =?utf-8?B?RSttZnZPMlV3d2tyU2l1RFFWK2ZFRnFkRVJ4aXJEYVpvVDVQWFArTXphaTNv?=
 =?utf-8?B?S2xoeFNyRHVNSWU3YWQwZGl2MXZERnZka2gxbCtCZjdwWlE2Vk04aEZZRjNp?=
 =?utf-8?B?Rm1EZXh6cUFXOVhYU2tSc1NVQ3RxbUJsSmE3TWhvUHR0WDl2ckpiSUt1TzZO?=
 =?utf-8?Q?qNWO14LfkXJsjEu2ueTF4TByL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PyFMMyOyn7BG8LZSpOGghKWWSBtu73KhnMrNed5Pq2Uebq258rtEiY+UlkMFlEpnOXxcyyaaa+y383QY+myv3WUwi2XBO5hPqKrkPRIIpUOHVsgJthqk/nNNDZ6KEPgE3fEXZuMdhdCV44cLH0Hk+Qvh7V0pEpFzZoPbU/c6r9aMFZzPMEdKtR2U1r5OfxmbIxpL42MLh+eZeFEsXYo/gj+1b5PxLSA4yVdWK4Ey3P+DaPw9rIoceX5YnCW1GRw5JTuj9RKkNCh8fVhabbc/JDJyI2a5RtT32pa0x01L9eKjmRfREe8p5XD/uaBJ54BFsbcxh/IToHSVsHUx5Z7fmizBQo4lYFXHPgwM21aJZdcZQdcqKB3I3arAZ3tEopx8ekZnPFBK1LKcW+LRYfQotX8WFgS2FIFNI0Y6n0LhXWLMBo4qDpFq2SQqvCpEa81Nfp/0aOiSNgulq2hR3ofU4eZ9fTzQY4+P4aPKRS51M/M/OUtCO2GN1oNCq2BEA+MlX2ZXQKpRFS9VwDwjlTNpeybLYCOieWB8rih10GPXZuGaxYb5JD2u8z/sOgPROFMQ6Ujvx5NL3sTS8DV+a4QbzM4Q/AitCZRybo64Nztn56CORtwArSn4OCDZ25vygm9+
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d29f2-7bdb-408d-4b62-08dd0774f83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:01:51.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGF+xItwGHq3Npj8tx+q+i0Sq3ad1Eiy2FnqL8Bzfye89ojuzt2P2z30BFMvYsFeYpg8Xbq5gTvAaX4fxbhX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6119
X-Proofpoint-GUID: 4haWbuVq3nTgNe0HXovKxn4rJzkhbDiY
X-Proofpoint-ORIG-GUID: 4haWbuVq3nTgNe0HXovKxn4rJzkhbDiY
X-Sony-Outbound-GUID: 4haWbuVq3nTgNe0HXovKxn4rJzkhbDiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01

SW4gdGhpcyBleGZhdCBpbXBsZW1lbnRhdGlvbiwgdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGlu
b2RlIGFuZCBlaQ0KaXMgZWk9RVhGQVRfSShpbm9kZSkuIEhvd2V2ZXIsIGluIHRoZSBhcmd1bWVu
dHMgb2YgZXhmYXRfbW92ZV9maWxlKCkNCmFuZCBleGZhdF9yZW5hbWVfZmlsZSgpLCBhcmd1bWVu
dCAnaW5vZGUnIGluZGljYXRlcyB0aGUgcGFyZW50DQpkaXJlY3RvcnksIGJ1dCBhcmd1bWVudCAn
ZWknIGluZGljYXRlcyB0aGUgdGFyZ2V0IGZpbGUgdG8gYmUgcmVuYW1lZC4NClRoZXkgZG8gbm90
IGhhdmUgdGhlIGFib3ZlIHJlbGF0aW9uc2hpcCwgd2hpY2ggaXMgbm90IGZyaWVuZGx5IHRvIGNv
ZGUNCnJlYWRlcnMuDQoNClNvIHRoaXMgY29tbWl0IHJlbmFtZXMgJ2lub2RlJyB0byAncGFyZW50
X2lub2RlJywgbWFraW5nIHRoZSBhcmd1bWVudA0KbmFtZSBtYXRjaCBpdHMgcm9sZS4NCg0KU2ln
bmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KLS0tDQogZnMv
ZXhmYXQvbmFtZWkuYyB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jDQppbmRleCA2NzIzMzk2ZGVhZTguLmM2
MWZkZGI5YjIzYyAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0
L25hbWVpLmMNCkBAIC05ODIsMTUgKzk4MiwxNSBAQCBzdGF0aWMgaW50IGV4ZmF0X3JtZGlyKHN0
cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQogCXJldHVybiBlcnI7DQog
fQ0KIA0KLXN0YXRpYyBpbnQgZXhmYXRfcmVuYW1lX2ZpbGUoc3RydWN0IGlub2RlICppbm9kZSwg
c3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCitzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZV9maWxl
KHN0cnVjdCBpbm9kZSAqcGFyZW50X2lub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0K
IAkJaW50IG9sZGVudHJ5LCBzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5pbmFtZSwNCiAJCXN0
cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSkNCiB7DQogCWludCByZXQsIG51bV9uZXdfZW50cmll
czsNCiAJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXBvbGQsICplcG5ldzsNCi0Jc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOw0KKwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gcGFy
ZW50X2lub2RlLT5pX3NiOw0KIAlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIG9sZF9lcywg
bmV3X2VzOw0KLQlpbnQgc3luYyA9IElTX0RJUlNZTkMoaW5vZGUpOw0KKwlpbnQgc3luYyA9IElT
X0RJUlNZTkMocGFyZW50X2lub2RlKTsNCiANCiAJaWYgKHVubGlrZWx5KGV4ZmF0X2ZvcmNlZF9z
aHV0ZG93bihzYikpKQ0KIAkJcmV0dXJuIC1FSU87DQpAQCAtMTAxMCw3ICsxMDEwLDcgQEAgc3Rh
dGljIGludCBleGZhdF9yZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhm
YXRfY2hhaW4gKnBfZGlyLA0KIAlpZiAob2xkX2VzLm51bV9lbnRyaWVzIDwgbnVtX25ld19lbnRy
aWVzKSB7DQogCQlpbnQgbmV3ZW50cnk7DQogDQotCQluZXdlbnRyeSA9IGV4ZmF0X2ZpbmRfZW1w
dHlfZW50cnkoaW5vZGUsIHBfZGlyLCBudW1fbmV3X2VudHJpZXMsDQorCQluZXdlbnRyeSA9IGV4
ZmF0X2ZpbmRfZW1wdHlfZW50cnkocGFyZW50X2lub2RlLCBwX2RpciwgbnVtX25ld19lbnRyaWVz
LA0KIAkJCQkmbmV3X2VzKTsNCiAJCWlmIChuZXdlbnRyeSA8IDApIHsNCiAJCQlyZXQgPSBuZXdl
bnRyeTsgLyogLUVJTyBvciAtRU5PU1BDICovDQpAQCAtMTAzNCw3ICsxMDM0LDcgQEAgc3RhdGlj
IGludCBleGZhdF9yZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRf
Y2hhaW4gKnBfZGlyLA0KIAkJaWYgKHJldCkNCiAJCQlnb3RvIHB1dF9vbGRfZXM7DQogDQotCQll
eGZhdF9yZW1vdmVfZW50cmllcyhpbm9kZSwgJm9sZF9lcywgRVNfSURYX0ZJTEUpOw0KKwkJZXhm
YXRfcmVtb3ZlX2VudHJpZXMocGFyZW50X2lub2RlLCAmb2xkX2VzLCBFU19JRFhfRklMRSk7DQog
CQllaS0+ZGlyID0gKnBfZGlyOw0KIAkJZWktPmVudHJ5ID0gbmV3ZW50cnk7DQogCX0gZWxzZSB7
DQpAQCAtMTA0Myw3ICsxMDQzLDcgQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWVfZmlsZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KIAkJCWVpLT5hdHRy
IHw9IEVYRkFUX0FUVFJfQVJDSElWRTsNCiAJCX0NCiANCi0JCWV4ZmF0X3JlbW92ZV9lbnRyaWVz
KGlub2RlLCAmb2xkX2VzLCBFU19JRFhfRklSU1RfRklMRU5BTUUgKyAxKTsNCisJCWV4ZmF0X3Jl
bW92ZV9lbnRyaWVzKHBhcmVudF9pbm9kZSwgJm9sZF9lcywgRVNfSURYX0ZJUlNUX0ZJTEVOQU1F
ICsgMSk7DQogCQlleGZhdF9pbml0X2V4dF9lbnRyeSgmb2xkX2VzLCBudW1fbmV3X2VudHJpZXMs
IHBfdW5pbmFtZSk7DQogCX0NCiAJcmV0dXJuIGV4ZmF0X3B1dF9kZW50cnlfc2V0KCZvbGRfZXMs
IHN5bmMpOw0KQEAgLTEwNTMsMTMgKzEwNTMsMTMgQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWVf
ZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KIAly
ZXR1cm4gcmV0Ow0KIH0NCiANCi1zdGF0aWMgaW50IGV4ZmF0X21vdmVfZmlsZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfb2xkZGlyLA0KK3N0YXRpYyBpbnQgZXhm
YXRfbW92ZV9maWxlKHN0cnVjdCBpbm9kZSAqcGFyZW50X2lub2RlLCBzdHJ1Y3QgZXhmYXRfY2hh
aW4gKnBfb2xkZGlyLA0KIAkJaW50IG9sZGVudHJ5LCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfbmV3
ZGlyLA0KIAkJc3RydWN0IGV4ZmF0X3VuaV9uYW1lICpwX3VuaW5hbWUsIHN0cnVjdCBleGZhdF9p
bm9kZV9pbmZvICplaSkNCiB7DQogCWludCByZXQsIG5ld2VudHJ5LCBudW1fbmV3X2VudHJpZXM7
DQogCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwbW92LCAqZXBuZXc7DQotCXN0cnVjdCBzdXBlcl9i
bG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCisJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IHBhcmVu
dF9pbm9kZS0+aV9zYjsNCiAJc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBtb3ZfZXMsIG5l
d19lczsNCiANCiAJbnVtX25ld19lbnRyaWVzID0gZXhmYXRfY2FsY19udW1fZW50cmllcyhwX3Vu
aW5hbWUpOw0KQEAgLTEwNzEsNyArMTA3MSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfbW92ZV9maWxl
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9vbGRkaXIsDQogCWlm
IChyZXQpDQogCQlyZXR1cm4gLUVJTzsNCiANCi0JbmV3ZW50cnkgPSBleGZhdF9maW5kX2VtcHR5
X2VudHJ5KGlub2RlLCBwX25ld2RpciwgbnVtX25ld19lbnRyaWVzLA0KKwluZXdlbnRyeSA9IGV4
ZmF0X2ZpbmRfZW1wdHlfZW50cnkocGFyZW50X2lub2RlLCBwX25ld2RpciwgbnVtX25ld19lbnRy
aWVzLA0KIAkJCSZuZXdfZXMpOw0KIAlpZiAobmV3ZW50cnkgPCAwKSB7DQogCQlyZXQgPSBuZXdl
bnRyeTsgLyogLUVJTyBvciAtRU5PU1BDICovDQpAQCAtMTA5MSwxOCArMTA5MSwxOCBAQCBzdGF0
aWMgaW50IGV4ZmF0X21vdmVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRf
Y2hhaW4gKnBfb2xkZGlyLA0KIAkqZXBuZXcgPSAqZXBtb3Y7DQogDQogCWV4ZmF0X2luaXRfZXh0
X2VudHJ5KCZuZXdfZXMsIG51bV9uZXdfZW50cmllcywgcF91bmluYW1lKTsNCi0JZXhmYXRfcmVt
b3ZlX2VudHJpZXMoaW5vZGUsICZtb3ZfZXMsIEVTX0lEWF9GSUxFKTsNCisJZXhmYXRfcmVtb3Zl
X2VudHJpZXMocGFyZW50X2lub2RlLCAmbW92X2VzLCBFU19JRFhfRklMRSk7DQogDQogCWV4ZmF0
X2NoYWluX3NldCgmZWktPmRpciwgcF9uZXdkaXItPmRpciwgcF9uZXdkaXItPnNpemUsDQogCQlw
X25ld2Rpci0+ZmxhZ3MpOw0KIA0KIAllaS0+ZW50cnkgPSBuZXdlbnRyeTsNCiANCi0JcmV0ID0g
ZXhmYXRfcHV0X2RlbnRyeV9zZXQoJm5ld19lcywgSVNfRElSU1lOQyhpbm9kZSkpOw0KKwlyZXQg
PSBleGZhdF9wdXRfZGVudHJ5X3NldCgmbmV3X2VzLCBJU19ESVJTWU5DKHBhcmVudF9pbm9kZSkp
Ow0KIAlpZiAocmV0KQ0KIAkJZ290byBwdXRfbW92X2VzOw0KIA0KLQlyZXR1cm4gZXhmYXRfcHV0
X2RlbnRyeV9zZXQoJm1vdl9lcywgSVNfRElSU1lOQyhpbm9kZSkpOw0KKwlyZXR1cm4gZXhmYXRf
cHV0X2RlbnRyeV9zZXQoJm1vdl9lcywgSVNfRElSU1lOQyhwYXJlbnRfaW5vZGUpKTsNCiANCiBw
dXRfbW92X2VzOg0KIAlleGZhdF9wdXRfZGVudHJ5X3NldCgmbW92X2VzLCBmYWxzZSk7DQotLSAN
CjIuNDMuMA0KDQo=

