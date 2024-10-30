Return-Path: <linux-fsdevel+bounces-33231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A719B5B97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7BB22863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650251D0F74;
	Wed, 30 Oct 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HMCJhhVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A631D0E2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268750; cv=fail; b=bn259fYPWpvpcsUx6HYf2rpw/5GBvuJZk3spLyYKr5mYmx19dR/KhvH4xEfZ5ooP7uk0K8NBL74p0GYRSzljGluKJcWkFfmUG6Y/oLI9h1Smny6h5F2Qgsj2Lu0KQ8Ce1OD45UsOE/JzJveNCk8WZrxDPQjj2SOfdap0U1tK8fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268750; c=relaxed/simple;
	bh=n51TQmwjw+cBQ6KSKXdEGqqeFJP5AKYEt6r56UR6ol8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gxfb0y2pIx8Zw9FvifYxEi7KJNWTIcdRIPIOT59sqS/E9gFHGPwPecoxcTJCNg1CqDTt4RIxi0J0HnjgCEwsAKaqF/VOfhZwnM8p+xrMYTr19EuiyFURUv9OSo1jGYxcPej9QIFPBh9BaQQ+7tINl0S+RkzJ6c7D0H1OFrtvHRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=HMCJhhVa; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U5wJjL018773;
	Wed, 30 Oct 2024 06:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=n51TQmwjw+cBQ6KSKXdEGqqeFJP5A
	KYEt6r56UR6ol8=; b=HMCJhhVaLY2a3D82HkXuZ+zsLhjovwudSao7YTJKhfUEj
	Z18RKQC+PQZs0curfeCbGYISTHDuRAuER/3aD0Kkunvty9kHkxP6DHCI+EvRKE0V
	O+sqDSvux+gI3JAIxeNEm9sz1ihwJmkduYOCjPvoIMlO5mfR1zFYCFfgov5QqcqU
	qHzMzpZHaRmFvvrumtvASyeLsEEJJ6lfOJtM5q0JetGzGJ2OOSxDaJM17/NvMhWe
	v3yTtYikIMcaSFmhCwg0xP7VcId9+skSYqBzRqPO9QO+lrQAkkZ0SgNPDYJvMEBM
	sMJaU1Ub1XsCkvRdgBFMADhFPhbhWiAmmWxQndZVg==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2ypgkdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 06:12:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlI387CvDtxOVpIum5KD8/l7dNspSagP4yzFjLdbL+8YeqSkECf7LzIZn0K6R4duY1+FMXz67FI1stdU0Ws8Sb65vQhhr7Dm9sfvWzKivrfltBs7jyfgdp6I5xt9uA08uSPhW8fZ8nk0j16z5c3AYLP6XYXj3M8x3kd9C8MXvQ0znfcNHc0sdkYLpu95yIStQVACNw+hXpdTDkCZSRU0Io7GYsh8HW65Beom2WJ35qPLCTyONxUTgOuu+dYZnoaaVWw0YDyYd+tYoYE9vzkjRCNlC7K6uVVuKusYOxyCejIWOLY7vBRdXBNoajIumWsUei3C8ze5teYsx4lZ6C2dCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n51TQmwjw+cBQ6KSKXdEGqqeFJP5AKYEt6r56UR6ol8=;
 b=tCGqBgTNsWEVaVFEUlBbLChGgl2IOzrsPUjWEQMgsZZk5AvOfbqO19zQ3vb8zDsAWYK9DLMhr/Q8nDUxZvNScGW/zarqeS0QXZ32Fj4Pb9XiOuu/Fl0hKx92PIcen4kRxM8XXUu7Pt2L/9hRW42URUksalvioEuWShpba3LP4Z5xCQvi0rYl10ntj4zYUOZzkvDRCqy00g0p2G8PdX7GqguTFJ7rF5e5HcsoL2AMsAREpuwrfUeSlncWJ4KmvbFWzalOieuFfL7nR50D9cJWauRua1kyYA5M1G+vFTNtNEfpn2uLdMOp+RpCUSLy7yoL/1lDGgY6VLa+oiZV740kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB6268.apcprd04.prod.outlook.com (2603:1096:400:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 06:11:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 06:11:56 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/6] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v1 0/6] exfat: reduce FAT chain traversal
Thread-Index: Adsqi1tpQFrMRPIkTR2RKUgj0ngLWgABHjpA
Date: Wed, 30 Oct 2024 06:11:56 +0000
Message-ID:
 <PUZPR04MB63164B1F3E8FFEA10105095881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB6268:EE_
x-ms-office365-filtering-correlation-id: 6a652a17-9717-4c23-34ff-08dcf8a9c19c
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVN6eFdwQlhxTnpSbFVydk03MGEwWFFJZy82R2grVkZIK3NWcVAvVWc1UzNQ?=
 =?utf-8?B?S3BwS29RTWhYcStJa0xEbktJWlZjTEV2bVFEdkdnSTJpUVluZTlXWGh0MHFz?=
 =?utf-8?B?YlkrT2kzejAxTGxrT2F4SUtqRjJNd1dCNUZLa3d0K084cW40RldneVl4Z1Bi?=
 =?utf-8?B?WW9pUjlTcUxrRWxHQ0pGRlpacFRCTmNVY3hld0R1MWpIQmNuaThVdExDaXIz?=
 =?utf-8?B?YXp0UjZUWnBCSnFONEtDaVNxU1BDQXFSYmVPaS80clZaT3JReUZFeGl4RXVI?=
 =?utf-8?B?U21pS2xZMWx5V0NMVzE1QXJKTHNiWWI2STczYnBhYVlmbEVRa1hBMXNDbjhj?=
 =?utf-8?B?T2pNdmRYUkFjL2t1T3dhYUYxQmlPYUFNeDcxNmdGUlNlZnpRNTE2U0loMUpO?=
 =?utf-8?B?RlY5MzVwZUpMaHhJZkI3WE9TdGFhUzVYM1lWVXdyU0twNGdoQUEyK0NRbVM4?=
 =?utf-8?B?ek1iVXp0Z1dJOXNVWTQrVUFrT21CTWlPd2VjZk1MR2d1OU1MTFlHZlVCOHNY?=
 =?utf-8?B?dXBsSnhGMXJ2dUhnZVJ6cVhOWE5tSTlQYUFoZE9mbUtPcnBGN1NaclZNaVUv?=
 =?utf-8?B?UFQrV3hrYVc0Wkc3RUU4T0c2S0YrNUlqVkFJd2YzaG5xRnhmU29hMkljczlN?=
 =?utf-8?B?Q3lhVG9PNzYyeGtBNHd6V0hlQlNkbk9hUTJFYVVKZGVCUzh6cDdTazh1MDFW?=
 =?utf-8?B?d2tZSnpDUncyQzFXOTI5SUFHMGhPd2g5ZlNFQ0JLMGZOVTZpZmtIL3IrM2Vq?=
 =?utf-8?B?eFpoS0JqM1A3cEZCa2NHbm5Id29mNitrMTF5YlVpV255T2FLK28yVUNxVjV0?=
 =?utf-8?B?MVNzdUhjMld6NUpOR3Z4cGtkWjlCbzErMUErMll5anI1c2FkeHZCMDFuMC9N?=
 =?utf-8?B?WWxkalVIdTh2K29MS2oxdk0yaGVSeTJHU2NLVVhnVU9NTGZoYUNtMzFEdCtW?=
 =?utf-8?B?eXYvTUxPSXZ2OVBEWnBZZGcrcXF5Zng1TUVrTlJBSitvSndzL0g1Q0JKVnZq?=
 =?utf-8?B?T2c4aHd0ZkZLVmhoNTNieks3MHZ5aGE3VXI3T2VKWFVNaHp4bk51Wlo4KzlF?=
 =?utf-8?B?UWs2ZG5aQTUxano1clFMcE5kSzBNTkhPc1JuS1FHUFEwRmxQSHB6KzNmN0tw?=
 =?utf-8?B?MHhJL1haNFNyMXNndTRvSTA2d1YvbExkNzZRNE10YlBJMUo1ZGVxYTZ2c3F0?=
 =?utf-8?B?WFdBaHVzTlFCM1VaMy9FQk5zQlBFclRQWThpUlZYV3ZPQjZnSXRjK01JSVdF?=
 =?utf-8?B?NTM1Y290NVB5Z0d5NzIyR3dRU0NyekwxaVZtN1N5NS9LVFd0Q1Yxd1lNcG4z?=
 =?utf-8?B?c3pHV1A1UUZKcTZJS0V6ZVUycFFoVVZqNG5mNVhWVkp5bjNHNWp4T1FuWlR5?=
 =?utf-8?B?Q3IrSnB3WjFkOWthZGhkaHhpbk1RNmFuYUo3aHNkSDBUTjBOR2Q3Y2ZxYkNN?=
 =?utf-8?B?TEp2RnNVZldxSklWcUg5Ni9zUW5FN0pmZVNFWWdkU2pmY2lIYmpqSXFXNFkr?=
 =?utf-8?B?RDM2NFVqb2srN2ptREI1WGJydkZ2eXk2QmlqNWdOSlJIMjdhTEpZeDU5ZDF2?=
 =?utf-8?B?WWlXYWd3dW9zVmM5RENVNjJqNUgwT0UxUmV0a2xNOUJNM28rckMvaTU4WmpP?=
 =?utf-8?B?U0R3UXBtT2psU25HUWFuVHMvVTJ1dld2RlRZSm9DNDVsaG9BY0N2K3B5eWRj?=
 =?utf-8?B?M0ZYZzk5V25CTXRldjBvYWJxZ01wSVV6NGJ6QVA2VmN4S0hUV21RcHBaUXcy?=
 =?utf-8?B?QXY5RkpuWldidzJkakVxQy90Rm5xZ01uQUlkMlAxRnFmTTIrOVZWVWI0clNv?=
 =?utf-8?Q?HdshCD1u1HlyhlHKBL6/Pe8CQFpCH90k58CnQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0tuWXkzZEFNM0ZLSUE2ZFdSN2RGbm0xaFZET3E1T1oyNk9hcllwSXJ2cFVF?=
 =?utf-8?B?U01yektkZVl0MUFSVzhlUXgreElMM2lCQURudU5lY3dmeXp3WVlXN2F3VWlZ?=
 =?utf-8?B?UDhXRjNKdnVBUFdXSElyWVZkbUVaUmNDOWRHR1c0YzdSb3VmSVpJMFVyK2tk?=
 =?utf-8?B?S0t0NVRjaGozbWhhQVNpMXcrYms2L0lRazdxTUhZQzdZQ1hNQUFyMFpWNHlI?=
 =?utf-8?B?NDQ3LzV5SVRrdlgyNHcyamtHQ1ZXY29uZEpMaGFWMDdRbVhvSVp6V0ZtL1gr?=
 =?utf-8?B?TEZhYXhydHJCcUZuRTg5SHByQkJvVTFNTG10VlZQT2VlbTBtZVoxY3dyVjJH?=
 =?utf-8?B?WW9GY3dCVG80UHRETlFTVytHbGlPdFgvY3JXTFlsYnZCa015L2JjS3NBamNo?=
 =?utf-8?B?RVUyMlF3YWhNQ0lWUWJVSWFHaWZsSEpSNlZkc1AvRzJjekRwbXRFL3ZnOFFS?=
 =?utf-8?B?L0xyUERIL3Z4cWdFcmsxUzdyd3VSUXFOZXIveG9tb0JRQjJVWFhFVFhjeG11?=
 =?utf-8?B?djdDdFU0bFlmNkdqNkg0NVRCKzR3S0FucVV4aW9KWERBaVBkOEt0cFlwZ21C?=
 =?utf-8?B?ajVOUVVHSUdzZCt1YW4xWC8xMGMxK2ZxVzFLNitHMTI5S2dzWjQ2SGVRZVdZ?=
 =?utf-8?B?NFlZd0FYQkE1S1FETXdBRDAyeWVqQkZwS0pFeWtpNTkrcU5CL3VCU2M0VHE5?=
 =?utf-8?B?d0VmUXlIVmN4TGdqcUNoaUlTaVVac21sQUFpOFNjalFsQ2lCSWNkcUhockF3?=
 =?utf-8?B?TXpDS0dzV3RiWW9ybXJwYXJnZ1kxT1VuSkVGa2VNZ2wzaW9BbmprUjFOcFky?=
 =?utf-8?B?bHZwUzNQNkovL084emc2WkJZelFUU1BhSEkrOEdFL3ZTUWprNnZhNURQczV0?=
 =?utf-8?B?NHRJckJ3ckdoeldJamxGOEhnclFVUUY0Tys5QU15cGlPVUVtL3NxZ3NEN3Bj?=
 =?utf-8?B?R1UzWDZGTDkwS3ZQYU5sQzEyamh4WFg0SVlaTElCT3VFVEltZXNXTmtETFBZ?=
 =?utf-8?B?WFBhbk1NVEdqT2pzYzEvYlJXZFlaTnd4YW9yNytEZWt6amd0STZNU3l0TDls?=
 =?utf-8?B?TVg0ZDBTY1NiZElKY3F2dGRia2NhUlpvL3VpWExhbGRUenEwNFlEbFBCR0hK?=
 =?utf-8?B?WWJOZ05nUkhRSVVHc09sM0syN2Q3WHlCbGVhbk5mRlBQYlFXUk9nWXIxSmxF?=
 =?utf-8?B?T2tBUTVmc0xuUUZ4OTdRdTE3NENIWk03VW1PN044Qm80aWVTTWUzbnJTc0x2?=
 =?utf-8?B?MlU2aHVQalUvOEsrTk5rTlV3blVOK3Y5TVhNZ05VblRNRDViRSsxKzI1OGc3?=
 =?utf-8?B?L0kvY0lSNHFESnRDOGQ1L2dLMVZGK3FTblBNZjZ4QXpuWGM2NU5uU3JJQnRN?=
 =?utf-8?B?MEI5cWt6VnVYVk5IS1prcXlsMktwZ2VseWxDRU1xNEt0a1ZEc2YvdEJGKzFh?=
 =?utf-8?B?UlJLSDJGUzd6OVhTRzlGZVByUisvdnBCMlE3YUtLSGp3bXNBcVZ3eTRqOWZU?=
 =?utf-8?B?WHhrSm9GNkJYQ1B1WXF4M0doeGRSZ1g3WGpSOXZyQUsrSHJ3bDJLRWFTNHZ2?=
 =?utf-8?B?ZHJwRHpINVVxQkFQcWVRRFpDVitGQUwySG9xRlllSGxKYjUwbWUrSnJxbm1E?=
 =?utf-8?B?VDlDeGF3RE1EUkh5eitjS3greU40NHBhZFhBMkJ1VXVua29rZlVEaGpkTWEw?=
 =?utf-8?B?ejFITzR4TkMyZnBya09hMGpNNXRQQUNxR0JveGd1dzM0Y2FPVE5rVnVVU0w1?=
 =?utf-8?B?MGNOaUtybXNTMWdpVlEzMHZEc3BLNi9LUnl5UEpPL09qdHVHdHR2ZGVHN2dr?=
 =?utf-8?B?YVBVYWludUpMYnNCMEYrYjRZUnVHUjFZZWZuTUhzRTJIUVpsTGtUVU8zeWNt?=
 =?utf-8?B?YUhDcm9XL3FLZnlXdHBSNURnOWNvcEh2cCs2UGZxemw1QnVSMllDbnNOaW5i?=
 =?utf-8?B?alJoQldYeXNDUTk5NlB2SVV1Y1FHcE1tTGRoZGpoamJ3aEMzVWdZemJobTU2?=
 =?utf-8?B?aXRkZE01aTFBejBJeDZqK1pQTnhJUjNURm5zSmVRbERuOGMzKzN3UXN2SzNU?=
 =?utf-8?B?aCtMUUM1R3hIQnhEN3p5UGdlMEphc2dsdGhTcXRRUVREWjk3MS9iZDBmRnp5?=
 =?utf-8?Q?oXUwLRMiA4wPAZPAgZU8pp6b+?=
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
	5HglG82Idux0HVFeB0vf3Tcdn4XGMKqJMforXzw2uHvTC8N1HPDGNS5mfiHg3MMdd+OT6XRZpKLCvW7h6gKbcJHlTUQR/KmsTqVAUHYmbMFuYQqQjIAfPoXU9/05uDJ+ape5K7ShE3kUdr3k0cDq6CBeBhpL2ukNEMt9ct44m287BW5mCiKILKgG2jG41mIKg5GqhytJZZYa0na+7iNzbBrO8dEsEbWEn4hk4r8slFc1yatDtcyMwQHXItgoD1yiEsdNydRknz/s3Ge+t+4fAx1L8yJTVHYFr0nmOloViLmLqUA2CM3P2ohV4JrvuGhGzOj5E7KOat25orUhyCMGA2hDqHryIuwBOcl0Ng35gshRkh9hGCN2p/LnMqulnHB0i1JI2e/ryPGlaq/PaD7A6cEz5IOiXB4VQWbAstmIC4lDI4RIJ4W0jD2cOu/drQUsQ4FgpZgfliQQ+WpuGMic1ZKfDzweRWTfYvCH1Wkuxnv/zI44GVem7E86th9g09Be7g03MhEDGVLWv62tnhW9eVixIMQ/bQZbjtZr/ktwM+fUiPBEoxXEjAoEUj6eZLW0ZFW5xMs/vtDfE0Yndpoc69hBbhTFUeW0zw3ZbRc7Kw+jnBjeqComI3GCO+7Q/UoA
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a652a17-9717-4c23-34ff-08dcf8a9c19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:11:56.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X253Wfyd1uUWbGnfJRfrXPQdZK47qVJpnElfgO1gt3d2oA2cFn2SxggEyPQMfnhcr3ZXR9AUjCTpZl6fexhwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6268
X-Proofpoint-GUID: t47Pcka3ryT1vOuOlZvVm92I--Rk2_LF
X-Proofpoint-ORIG-GUID: t47Pcka3ryT1vOuOlZvVm92I--Rk2_LF
X-Sony-Outbound-GUID: t47Pcka3ryT1vOuOlZvVm92I--Rk2_LF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-29_01,2024-09-30_01

VGhpcyBwYXRjaCBzZXQgaXMgZGVzaWduZWQgdG8gcmVkdWNlIEZBVCB0cmF2ZXJzYWwsIGl0IGlu
Y2x1ZGVzIHRoZQ0KcGF0Y2ggdG8gaW1wbGVtZW50IHRoaXMgZmVhdHVyZSBhcyB3ZWxsIGFzIHRo
ZSBwYXRjaGVzIHRvIG9wdGltaXplIGFuZA0KY2xlYW4gdXAgdGhlIGNvZGUgdG8gZmFjaWxpdGF0
ZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhpcyBmZWF0dXJlLg0KDQpZdWV6aGFuZyBNbyAoNik6
DQogIGV4ZmF0OiByZW1vdmUgdW5uZWNlc3NhcnkgcmVhZCBlbnRyeSBpbiBfX2V4ZmF0X3JlbmFt
ZSgpDQogIGV4ZmF0OiBhZGQgZXhmYXRfZ2V0X2RlbnRyeV9zZXRfYnlfaW5vZGUoKSBoZWxwZXIN
CiAgZXhmYXQ6IG1vdmUgZXhmYXRfY2hhaW5fc2V0KCkgb3V0IG9mIF9fZXhmYXRfcmVzb2x2ZV9w
YXRoKCkNCiAgZXhmYXQ6IHJlbW92ZSBhcmd1bWVudCAncF9kaXInIGZyb20gZXhmYXRfYWRkX2Vu
dHJ5KCkNCiAgZXhmYXQ6IGNvZGUgY2xlYW51cCBmb3IgZXhmYXRfcmVhZGRpcigpDQogIGV4ZmF0
OiByZWR1Y2UgRkFUIGNoYWluIHRyYXZlcnNhbA0KDQogZnMvZXhmYXQvZGlyLmMgICAgICB8ICAz
OCArKysrLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgIDIgKw0KIGZzL2V4ZmF0L2lu
b2RlLmMgICAgfCAgIDIgKy0NCiBmcy9leGZhdC9uYW1laS5jICAgIHwgMTU1ICsrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA4MiBp
bnNlcnRpb25zKCspLCAxMTUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40My4wDQoNCg==

