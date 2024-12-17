Return-Path: <linux-fsdevel+bounces-37675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2217E9F59D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFF1706D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B41F9A98;
	Tue, 17 Dec 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mnZ54llD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C84A23;
	Tue, 17 Dec 2024 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475643; cv=fail; b=a7wW4RvQSTf6Qj+al3u1Sf1T5z/0QW+8t2GBQ/d9Vufj8QdPl+EEh5Ysr9ESKWeJfkxJqOGtqjcC55yfEgVA3eRU9CPg1fZzGuSecIkTVZ8EdnwOSMENCje8HmkRc2H4AY0GsmboqiBZo6ObZ6RREW3CBTnVs3FVqsm3AAq05bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475643; c=relaxed/simple;
	bh=NLiwe3DOTOUD6EpHmPUv+YkXIMzEqifzdeuVnKV/HGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZekXZovA4tpXEJUJZ5EHo4HZOOTnZdlnu2joI15a1HyuO/o0HCLWiSHszHNC+tJs59puFpjGga7WxRP0lULAw0ADdyiRoHu71eNtL4Qk9cCeGaCwxMuoygGPxMqiUx0m+yGqOYI5/5SKzP2lneiNLxKxUzT8h4TcSZg43xcSYvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mnZ54llD; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHJNtxV029848;
	Tue, 17 Dec 2024 14:47:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=NLiwe3DOTOUD6EpHmPUv+YkXIMzEqifzdeuVnKV/HGY=; b=
	mnZ54llD+2QGutr8BCKYNPF4qgqoFtEU7XzJHOyZYbOMZurzDz2SQLhlAvgzqwzi
	CZWt/Z65fuf4Fh+Qy1J22kHVBTXDfKRnTIyXCZoSlK1TKBLmkvyIC8O6/B0gTFxU
	y8HvB7Elh2IvTEcrzDeluZRPvJt3yGwW0U4ZpCYG1eDaVLsAqkvYiv7b9hwQrIe2
	Ielhv/UVPXMyOD91DBBFNp9oxZujwO9tPlqGWrkvvVm2foVPmCVUEJrkd6rEXqCF
	FzCUOPrqywPb81eR65GEVhyFIh4HdcetNO6A9YsRxO+oX7DN50WGQHrSTj/6A5gA
	Xj/33OQJCwUhx+kJwsyc2A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kfdtsb9y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTWOyfEqSr/A7uYJxqYcqugj0Zhn0LDg5Q0uqLRxt3nK99iUsqgbS3NcUViN0XZBqthCBbfy/KBEK1Qq2iE9OM6+FHPgR3Ce5KTv2zKBYGBjTbPFJyXPVVXL9P+oGrBNoJzgECrkQPR6gb2fM2zye0OFjtSgPhw1ZDg0GVaR9SWyGssrmyelR+K1ahKOJm0XfvtsrG5DNdUos+Yatjb/G7Fezj8gaLH+vGa+z4EOqau2rT9MLcsFikjzTwKvEIMi9xbbvm+FKkwwIBhVQvDJXJjLwa+l7+Zs8US9hcIHIQvc0zUOlmxWt/qmmSluz2Pdbo9Wf3QgbZdF3TEPDm/wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLiwe3DOTOUD6EpHmPUv+YkXIMzEqifzdeuVnKV/HGY=;
 b=gGxBXFm1zYh3ZZXX2ZAlRHhIbz6OTU/MrsETQ7qTsj+L2hkfOnbJhjTLPibiFoquMdse9cunuUu/nhZiE8KhzPy/QjfGBWoZCoW7eOMSpLEfdCWHj5kgd+FRjVEgCrwOjH1J0sW1Z0V3SGikVPOH0O08hpiHef6aVivHp9+th0z4OGQx93EvgNTk/fW9bYL9UGiTbMnVTgIlfyO/6rQBJXG9EpvHHpkeyJWsV+PFbeHlg4t8TsmbgpJs2pfChMGHpqY0VS9Vn/eT8xbor9xGruDnJ1UDoBGK94NUcAB2lVxXwD6POvJLwRoHzmN7KpXPD0Pam6VRpzzk8Mzw/KVJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB6274.namprd15.prod.outlook.com (2603:10b6:8:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 22:47:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 22:47:13 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Paul Moore <paul@paul-moore.com>,
        Casey Schaufler
	<casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index: AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAIjYCAAAEqgIAADAaA
Date: Tue, 17 Dec 2024 22:47:13 +0000
Message-ID: <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
In-Reply-To: <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB6274:EE_
x-ms-office365-filtering-correlation-id: f46d54ad-4125-45b3-623b-08dd1eecc000
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0orSGN4cVhPQzFYN013SlZwY2c5VkhBdnRZL0ZqdHl4TWZGcXZLZXY2cTlm?=
 =?utf-8?B?Z2xCWWgyLzdTVW1ZSmloUFZ1aldKenBqODdDQ0RVeXBRMURrYk5zNmV3enMz?=
 =?utf-8?B?R1U0Nkw5UkMvWWJkaEI5bVBsdVR3Yk0xckJjSGV4OGtjLys2NEpSSVlBUlBi?=
 =?utf-8?B?dmRLaHJHeUI1aXVPbzlPQloyYmRmQTJsbzJ3bXMvTEl4blNRVkdWRE81R2Fo?=
 =?utf-8?B?UW9vbjJDSFFKem1sSnF6MlFVeVFLQ2pTYStZSTVJQVo4eHZLNXFVcG9jSnBa?=
 =?utf-8?B?WDZGbDVFaEVJWUNTT3NveGVZTXdIMldVb2pIMFhlTVNTUzJUZXB4ejFmNHYz?=
 =?utf-8?B?WllMUWtxKzFLOGVXdnJQdnFEZG1zbWtJdW81SVRyMmZaYVpIWHozUFdJTVZD?=
 =?utf-8?B?Vmw5WXZCdU04QjBvRi9ncTJDN1l0ZmhKN0xSL0N4Uk1WbGMwZ0ZwYXNIUmYx?=
 =?utf-8?B?bVhad2M0NDVQcDhvYmowRlNldjMzZUpMamRsUmtnbTI0TUkvRlhMZUZjMW1U?=
 =?utf-8?B?QkVxZWg1UGNNMjBLOXZIRWdId09MRzc2Y0ZFVElYa2FKTU9pVlVzSEF0b2xZ?=
 =?utf-8?B?SGNMeU8vVnFpUnUzdk0veldseFBsOEJMV1NaRi84MFJPeEZCZ255Q3YzdlM2?=
 =?utf-8?B?cjNMZlRrOG9tVEtRSjB1S3UyL1JEVUczeUhlaHBzYmJlOVlFYzRIb3FpSjRm?=
 =?utf-8?B?bTczRi9UT3VLbXRXVk9tc3c0L1JENklLUVUrdkwzUXJRSVRJMHRHM1R0MzBO?=
 =?utf-8?B?RXpyNCtBVXhnRFVtdWMyM2tlWFpzZlZZSTgrVGNnenRKU2dIMmF5ajhpRUJ1?=
 =?utf-8?B?WGl3dWJNalI4VVhmdmJmdVZmcVVLc0hKU2RndWk0eVFCMklIY0U4MTAvTzBi?=
 =?utf-8?B?NXV2cEFPVTZvL2FtQmtSSVQ3Nmp1Q2RGYzYrK2xSTktrUmxLMlpDNml5TjBZ?=
 =?utf-8?B?S1Y0L2NPWjlYWEN6VWJDZklqVVp2dFVTVlFxR3MybTQvYU9wZEVSdWdBMm5n?=
 =?utf-8?B?Y2lOZmVZMXNyUW95ZHZwOUdyNG5LWnBHejc1S0FJelNIU1pQcnA1RlJvR0ky?=
 =?utf-8?B?RzlHelF1ZE9vbnIvcTlsYjhiZi9XYWo3ay9uN0o1VXNsdkxLcnptd0IxMUtG?=
 =?utf-8?B?cUd5dDY0NG90V0RjQVdLNzBXcDJQaW5TWE83U2ZkdFlpSjFHRGpIbmROUk9x?=
 =?utf-8?B?T0lQU1RKSE1NNGRtNzNmVEExYnhZU09LRjVYNk56YzI1dFdGSnBkSWJNeXZM?=
 =?utf-8?B?U2FNanRHZmNiN09PRnErLzR5cHd0OU1mUjV0RjRKU0xvSFdhcStaMmR2MEhK?=
 =?utf-8?B?YmNraWRKK1dnUmpvYmRQUlZueUhjODFBRVdGdDVMTkRhMW5jMklHTGNLTldo?=
 =?utf-8?B?Z1dwUUluano5dkhJVG8xL2hBY0lBdWxmWjZnd0QySDRuYTdXWFVMSTN4enU3?=
 =?utf-8?B?Sys4SVJvQ1V3dFY3eDUvV09GV2hicnJJdkZzaE5IR0pWdThaQ3JkS3V3ZmVJ?=
 =?utf-8?B?bVRCNGNJaGcvSXBleUJGaG5PV3FjZlJBd2w5SGEzcmhvTEkvcms1MjJLcVFt?=
 =?utf-8?B?enFoelhZTUc0OFpLM1hjczdDQ2lqbkhvcjE1TEczREtUdmlDYXBNNjl3V1ZY?=
 =?utf-8?B?MXU5aHMxZkJLQ1BNUkJEeFU0aFdVQTlKNENIdUlzbjVTbkttWXVkbkxrb1l4?=
 =?utf-8?B?Q1QwQXRSUjRUNmd3QzIvWDI3d2hoc3F0Vk9YRHJxZS9XekxBL1lsUE9uK01H?=
 =?utf-8?B?U3hWd0lFMVdnaFRiR2ZESEZjZW9DOTlISlpXTzQ3a1NTVVJpcnNTOTZTWUw0?=
 =?utf-8?B?Q2xxOFE2YkhLM1FxRHlVOTNhWkFhOVFsVzdsVUhJREpraE9iWXJueXlYN2Zk?=
 =?utf-8?B?TVMzckJwSkNPNmIzYllKMEtjMThwSmwrV1R4MHMwelJqc0tLZ2pyOHIxVXFQ?=
 =?utf-8?Q?RxAp6ACWgbNJ2xrtijr15TfnrV/z096B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWo4MU5Pa2JDeDR0eFRyNDRoR2syUVhYTlpxQUxEN3VZNlhTVlBOUFcvQVRX?=
 =?utf-8?B?OWovN0U4Y3JlaVBONEllZlRkY0FxNHRMV00vK3R1T1kyTVJpZENQYUE2RTk2?=
 =?utf-8?B?ZHBRMHZXbisxN1I5dC9OYkhWLzlsbGVIdTV5WWh3NDd6aEh1VGN2MXU2VS91?=
 =?utf-8?B?M2RrR2xFaHJTclhYRkpIbjBqNkJtL0xPSmVqUGtoM0JYVEkrak1RR1dsRm41?=
 =?utf-8?B?RklSd0NabnRKNE1PVlRuSVlveDZzL002S0dRMmJReUhOUG5sTnNrdVBlUVJX?=
 =?utf-8?B?NnR4QVNnNG54ZkZLN25ra3JLU1NMNXE1K3NROHJmeTFLQVF2d2MxeG1ZTDY0?=
 =?utf-8?B?Vm5zSUpTOWJnM3FmMlFpcDNDUzdpa1NDZmN6a2ZUQm1xekhsSk9GaTFRWWd0?=
 =?utf-8?B?cmlDOUlmbXhRS3BwMm1nSGtta3oyRUwzS3BHZytNejFXd3hRTE5xUkowRlpS?=
 =?utf-8?B?OXcxenhKMUFjNE53c0FLQ3RnMXNrOEYyVGw1VTY2V0NmbE5wQXo0eFZrS05O?=
 =?utf-8?B?c0ZMK3lUVHp0M3E5cjNWRGI4bUNTc24wb1o3NTlBWk5iREk5N240K2p2TVFK?=
 =?utf-8?B?cEpJQU80TmdXWmV1WWVSVFBpSVpUcVU2Y2lsbjVvamg0d1kxaG9PQWVZSmpt?=
 =?utf-8?B?SmNFVlVUMEoxM2FGNGhpZ0k2ZzdXcmZVZVB5czZsWnNwWU9pOE8xQWVxQ0tG?=
 =?utf-8?B?Tk5QQnBuVFcrUDBJTlovZTM4UUV5SlphcCtqU1h4eWpHeGhIeDlzcFc1RmhE?=
 =?utf-8?B?RjhnbTNjYkNyeWNlOWc1WXE3ODlOUkxiVWQ1cHF3L3FFMkJERDhLU1djdFRH?=
 =?utf-8?B?Q1E1TUxQWFhBMVI2REVMYWJNRDZ2WmV5dHNzZldDSlZ6UDhwQ2pXcWVheTh0?=
 =?utf-8?B?QnNURlB4MjVEVG9rWnArRExWcmZJK3E1bTFNTFR5WU4yS0htSnZOUFJoaEdG?=
 =?utf-8?B?RHVNQ21pTjNXeXliZ1ZsQmRPS3NWaDZ5K0h1djE2K20xSHB6NEQ3TGlVZStZ?=
 =?utf-8?B?QWcrYktyNndCL3gxY0dsTk5DUkNJUVZ3cEpFYjNmS09ZN1lHMzU2MFZKVXJI?=
 =?utf-8?B?ZjBDRmVOUUl2djY5c0FTQnpidm1ESlhBU2M2dkkzbS9GUU4xV1VuQno4WXha?=
 =?utf-8?B?YkRYZndwb0NnWG9xc2ZHSDZXTkpuYUVPQmV6cnl6aXpYdmxEM1UySm40M0t4?=
 =?utf-8?B?Qlgxa21IUTFmY0k2am9VcE5nUVdqV05VVGdraWNoWVlTdlo2VVRwNDdSbmIy?=
 =?utf-8?B?enpXMjJZTkROQkZhMEF3U0NKWTJ1ZHd4emtzZmhoa0xJdGMwdk1nOWVjajFh?=
 =?utf-8?B?ejMrNUxJUG1VTVU4R0F5bEV3UW9tODJJd0Q1V3VNeU1QU21GcTREeE1SYnBr?=
 =?utf-8?B?aHlzbWRpYVNEdmpoaFJvaVg1dzUvNzNOeE9sN09TVmNLb05qcnhBTFlkRWYz?=
 =?utf-8?B?Sk1vc3pJNlBzZmc1TE4wWWlNWTVqdUNZd3dLNjJxSzY4dVZHS1pVYy9aTVZ0?=
 =?utf-8?B?TXJGbW5MSDY5bHRUbjRXTFJsaXcvRzNDS3MrbmdPcDcrS3hjdG8zTGozSjZ6?=
 =?utf-8?B?eEdoVnJ0dmJRUmlyQmxTY0Z3NGVDVDg2eFUyZHNiL01HUW8vN1N5eEQ3Y2JP?=
 =?utf-8?B?a0graERybkZUczhlZUw1ZUJqb3lKN0hQU0Fmdk01T3BqUWdwM01qRHVZMzR5?=
 =?utf-8?B?Y2NXUjlFbFErVHliQ1hTUnJ6VWsrd2w4cjBZOExBRDJwb0RSbFFDMWpOVTFx?=
 =?utf-8?B?UlpnRldiTExiV0hpMkFwZkJVYnhINjlUOGZQd0hRdSs5cm5VWlhWTXpXUjE0?=
 =?utf-8?B?alpQVGtteFpxdlJYRFlmZjN6OURobytYdDB6RHp6ckxldzFaMDJ1ZlRpVmh5?=
 =?utf-8?B?REIrTjBORmZnVldrMWFHZGgrTVlxVFNqL0RZVFI2dWJ6YkRpbm5maFJuUGJj?=
 =?utf-8?B?MzBZM3ZIMFpkS3dKRXhjYW42ckFYRkJSNGdyelpLeUhpTld6T2N5bzA3Ulpw?=
 =?utf-8?B?NmJJZFFVWWNMYlFTU1FsU2pnWENNRHJ4TFA4WVNsaThsV3hqUUI0aXJleGFD?=
 =?utf-8?B?SzBHdzBRU1BsUHhNN29ybFNiZjZ0OTdGdUhjcCsrYU1BbXNycU1Pa1padDNs?=
 =?utf-8?B?VWdZWVBZeWJVVlJNekhPRlR4SUptckRLWTJSSzQyUytaeWdRNU9YUWI2emF0?=
 =?utf-8?Q?Avxfeo6gDZYwz5oXH5WV4ac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D3C679FADCC2C4DB49DFD757D43AD92@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46d54ad-4125-45b3-623b-08dd1eecc000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 22:47:13.8469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvzB38n955UgA1lWr8nh+kAfov1wwIfxCTNvYv/u1zIENhXNMN+ArAk1/ZA+u1mkbarEPwxFC1sxcq6B68Hilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6274
X-Proofpoint-ORIG-GUID: 8s5JYPiyKP6wpUER2h1_EeHcY3efzYDH
X-Proofpoint-GUID: 8s5JYPiyKP6wpUER2h1_EeHcY3efzYDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE3LCAyMDI0LCBhdCAyOjA04oCvUE0sIFNvbmcgTGl1IDxzb25nbGl1YnJh
dmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBEZWMgMTcsIDIwMjQsIGF0
IDE6NTnigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IE9uIFR1ZSwgRGVjIDE3LCAyMDI0IGF0IDQ6MjnigK9QTSBDYXNleSBTY2hhdWZsZXIgPGNh
c2V5QHNjaGF1Zmxlci1jYS5jb20+IHdyb3RlOg0KPj4+IE9uIDEyLzE3LzIwMjQgMTI6MjUgUE0s
IFNvbmcgTGl1IHdyb3RlOg0KPj4+PiBXaGlsZSByZWFkaW5nIGFuZCB0ZXN0aW5nIExTTSBjb2Rl
LCBJIGZvdW5kIElNQS9FVk0gY29uc3VtZSBwZXIgaW5vZGUNCj4+Pj4gc3RvcmFnZSBldmVuIHdo
ZW4gdGhleSBhcmUgbm90IGluIHVzZS4gQWRkIG9wdGlvbnMgdG8gZGlhYmxlIHRoZW0gaW4NCj4+
Pj4ga2VybmVsIGNvbW1hbmQgbGluZS4gVGhlIGxvZ2ljIGFuZCBzeW50YXggaXMgbW9zdGx5IGJv
cnJvd2VkIGZyb20gYW4NCj4+Pj4gb2xkIHNlcmlvdXMgWzFdLg0KPj4+IA0KPj4+IFdoeSBub3Qg
b21pdCBpbWEgYW5kIGV2bSBmcm9tIHRoZSBsc209IHBhcmFtZXRlcj8NCj4+IA0KPj4gRXhhY3Rs
eS4gIEhlcmUgaXMgYSBsaW5rIHRvIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbiBpZiBhbnlvbmUg
aXMNCj4+IGludGVyZXN0ZWQgKHNlYXJjaCBmb3IgImxzbSIpOg0KPj4gDQo+PiBodHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy5odG1sDQo+PiANCj4+
IEl0IGlzIHdvcnRoIG1lbnRpb25pbmcgdGhhdCB0aGlzIHdvcmtzIGZvciBhbGwgdGhlIExTTXMu
DQo+IA0KPiBJIGd1ZXNzIHRoaXMgaXMgYSBidWcgdGhhdCBpbWEgYW5kIGV2bSBkbyBjYW5ub3Qg
YmUgZGlzYWJsZWQNCj4gYnkgKG5vdCBiZWluZyBhZGQgdG8pIGxzbT0gcGFyYW1ldGVyPw0KDQpJ
ZiB3ZSB1c2UgbHNtPSB0byBjb250cm9sIGltYSBhbmQgZXZtLCB3ZSB3aWxsIG5lZWQgdGhlIGZv
bGxvd2luZw0KY2hhbmdlcyBpbiBvcmRlcmVkX2xzbV9wYXJzZSgpLiBXZSBzdGlsbCBuZWVkIHN1
cHBvcnRpbmcgbG9naWMNCmluIGltYSBhbmQgZXZtIHNpZGUsIHNvIHRoYXQgaW1hIGFuZCBldm0g
YXJlIG9ubHkgaW5pdGlhbGl6ZWQgDQp3aGVuIHRoZXkgYXJlIGluIGxzbT0uICANCg0KRG9lcyB0
aGlzIHNvdW5kIHRoZSByaWdodCB3YXkgZm9yd2FyZD8NCg0KVGhhbmtzLA0KU29uZw0KDQoNCg0K
DQoNCmRpZmYgLS1naXQgaS9zZWN1cml0eS9zZWN1cml0eS5jIHcvc2VjdXJpdHkvc2VjdXJpdHku
Yw0KaW5kZXggMDk2NjRlMDlmZWM5Li4wMDI3MWJlM2IwYzEgMTAwNjQ0DQotLS0gaS9zZWN1cml0
eS9zZWN1cml0eS5jDQorKysgdy9zZWN1cml0eS9zZWN1cml0eS5jDQpAQCAtMzY1LDYgKzM2NSw5
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvcmRlcmVkX2xzbV9wYXJzZShjb25zdCBjaGFyICpvcmRl
ciwgY29uc3QgY2hhciAqb3JpZ2luKQ0KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHN0cmNt
cChsc20tPm5hbWUsIG5hbWUpID09IDApIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGxzbS0+b3JkZXIgPT0gTFNNX09SREVSX01VVEFCTEUpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYXBwZW5kX29yZGVyZWRfbHNtKGxzbSwgb3JpZ2luKTsN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAobHNtLT5vcmRlciA9PSBM
U01fT1JERVJfTEFTVCkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
ZXRfZW5hYmxlZChsc20sIHRydWUpOw0KKw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmb3VuZCA9IHRydWU7DQogICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAg
ICAgfQ0KQEAgLTM4Niw3ICszODksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb3JkZXJlZF9sc21f
cGFyc2UoY29uc3QgY2hhciAqb3JkZXIsIGNvbnN0IGNoYXIgKm9yaWdpbikNCg0KICAgICAgICAv
KiBMU01fT1JERVJfTEFTVCBpcyBhbHdheXMgbGFzdC4gKi8NCiAgICAgICAgZm9yIChsc20gPSBf
X3N0YXJ0X2xzbV9pbmZvOyBsc20gPCBfX2VuZF9sc21faW5mbzsgbHNtKyspIHsNCi0gICAgICAg
ICAgICAgICBpZiAobHNtLT5vcmRlciA9PSBMU01fT1JERVJfTEFTVCkNCisgICAgICAgICAgICAg
ICBpZiAobHNtLT5vcmRlciA9PSBMU01fT1JERVJfTEFTVCAmJiBpc19lbmFibGVkKGxzbSkpDQog
ICAgICAgICAgICAgICAgICAgICAgICBhcHBlbmRfb3JkZXJlZF9sc20obHNtLCAiICAgbGFzdCIp
Ow0KICAgICAgICB9DQoNCg==

