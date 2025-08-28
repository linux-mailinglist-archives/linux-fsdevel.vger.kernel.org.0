Return-Path: <linux-fsdevel+bounces-59519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85DB3AB11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 21:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FE71B235B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FEF273811;
	Thu, 28 Aug 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WkYyVQOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568613AD38;
	Thu, 28 Aug 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410391; cv=fail; b=d9iJCm/e77k/djMMWgkjJUCUsYrhyqIRNSZat9/9n7ZahaxwS5NyiDx4FA2S3AQ74TxX0gMjWN7moLX+94XNoxwbhdmX1Tp/R18gBBgs9CXuIG4JR24gKorbgM0knh5y0LVFufl7eoq2YR3AyitJuMbthVm/hqgdUiLLf24KUuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410391; c=relaxed/simple;
	bh=4lbnSuw26WbemcgjtoQ/u82Q2oBt1Jhxi9RmO2OWEi0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Bvu5q4dN4aCwtlfa3XLR7rqyDsshpkvBKh0giScuOlPWBcpqaJJz2B698WSO8gArNPnh0+QX41ac/Ok9p37o9H/F8po9gWG/yIv4A6q3MiR7aQyvv0SKvimiYS7NHJhgTJwcZ+WtcdxkjZE+q0CFIi1xzwQDP2Rc+zL9ziczGzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WkYyVQOH; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SFnwSg007760;
	Thu, 28 Aug 2025 19:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4lbnSuw26WbemcgjtoQ/u82Q2oBt1Jhxi9RmO2OWEi0=; b=WkYyVQOH
	IDZyaACvXBeZr8pKXtlEnI7Kbvl4oQe6RjSEDJuT19b1lWKuh1MfTY0fRKLG24zh
	cezqwidEgStXY61HfeeuJ/KicVQpQUEiRgruw8chbU86CboquwzK6YvMlmBjw5B/
	kVeWs6HWaTTsucKHZ94KHUiA0fda8En97gmamw1JbtvnGlnglKHoa+Jvd8ZTx1uc
	uRzsPqfCFUIaNZ2bsO/8IXmiYYaRc3/xJJ6J2gkvQyPNYOVNk3aHap5dIo4mJsny
	epbTAlM2OdUwBJY4vWvmyF4POzaqy/Z2DVfAKsWv3wKro8pCJWDtW1L9MOs36fSF
	N1rfKQpytdHh8A==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqbqnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 19:46:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF/xcpxVXKAtOwenDRrDjZHdkWug/5ntwEqjS1Ii3HvypjyMGhuXa+tDRQMzkbt0DuGZV5dxVaJ5KIRcczaSCkwjecWtq1pFVigodC6QH6yGFvAj+e8csZVsTaLH94mVKp+vL6OmLfvtH91VvCS5o0WRpfOP1SfYu51DhJGJFyHw4XnxsAQ8VBXRh7vsJOwZ+krg8DRqpQfI39PfRpMvmirQ3bxk2ZBYhJrHnw1dbw0wtfVb+CmyzZyfA1RkIhZv+ia8JZr0FHDOpFyIFGBuk0qypRkm81/bk5a7lZIVIEnP7SF9BYewBJA2oajVg0R9vwmTIMkJLUTETDeSkAoFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lbnSuw26WbemcgjtoQ/u82Q2oBt1Jhxi9RmO2OWEi0=;
 b=f+zAA4zSX6uQKvmxsB85GJHfqoKiW3O+OQ/+7+eotuNjwkcNIsx4lVBlx1RU4C79AB/engY+ACqdN9IYV+q8lgOLlV6sVKg1UZ33fHX42RCRv7WTjjP20PXQhJhkDYxdR1bbVJGS6+MBy8z+diEqcg5I4TpnvaZqzBCDaUlx5Reh915JMfAFs65TLFBDF+T4VqvesvXEdGBB5EYagtdxgDX1XM+hGBaODbPWqoINwxHH+PmGMrCoGTxPSqXg0lN0DSwIq0aaCDOYfGfgjtMHzt9E0eRKoHMFFjbop0MBSbPEBYN2AQL+2eV8804EWM28RUZPXaPZJTxvUB6tehaQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5499.namprd15.prod.outlook.com (2603:10b6:510:1f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 19:46:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9031.023; Thu, 28 Aug 2025
 19:46:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "yang.chenzhi@vivo.com" <yang.chenzhi@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v2] hfs: add return values to
 hfs_brec_lenoff and hfs_bnode_read to improve robustness
Thread-Index: AQHcGBg3saiB2JEAQkGhiX1Nh27YALR4eKaA
Date: Thu, 28 Aug 2025 19:46:17 +0000
Message-ID: <20ca1d6dc2b4216246b14233373a2e06e29ca0dc.camel@ibm.com>
References: <20250827064018.327046-1-yang.chenzhi@vivo.com>
	 <2913155abcc272d83d369ff4f81a08483be021dc.camel@dubeyko.com>
	 <5114cb2e-1b94-42e5-ad71-adc8cce9d574@vivo.com>
In-Reply-To: <5114cb2e-1b94-42e5-ad71-adc8cce9d574@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5499:EE_
x-ms-office365-filtering-correlation-id: acca3883-6060-4042-3243-08dde66b8e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXhlVUh5Ulc4ZEJESCtDOUtMRUdtRVhsdnBDbTRpQ3g3TWJqaHZGbHRjc2dP?=
 =?utf-8?B?WTE2WkZrZVdQVDBqUXBranFGUGkzR0hkUFp6aXpJYlpHSkFSbHNZaXJwRDhk?=
 =?utf-8?B?ZmZvNnhuTnMvWjJYUVNvNEV6RWNlUVNBYzlaSTdkbWRZQVdWVmtQTGhqSnBh?=
 =?utf-8?B?SFV1dXBpRE9yT1VFWWM0ZWRYNFh0ajIwTlNlckw0ZExpV2Z4SllEaEs2TnVq?=
 =?utf-8?B?N0lpMEtNOE9yQzdwRTFpaGxVUndTMUZWcGNrRldVL0JiZjhibnVmVkFCMDlW?=
 =?utf-8?B?TXJ4U25yaytBRWpnU1dIZjVJZ2VseWdiQ3Y4SFlFcmp2MEFxbWxaa0Z0STZ4?=
 =?utf-8?B?SUhvb1p5SFJuY2FPY25wb1lTNnpmQ1VueXRRenNKd1VobGR3dFUvMElrT1dL?=
 =?utf-8?B?ZjVyY0FOWncyVmNJdXpMcHV3YW5CaXVudXJicnMzaXgyQXR5TEFFeUpOWk9E?=
 =?utf-8?B?Y01sK3RaREh6Qk5xRDIxa0IvakhSN2pqdVhyYU84YXZFdmJxRzk4UXc4ZGhy?=
 =?utf-8?B?RkpzUUw5RmdqRnRvdFZYY3lBaERRZWlWWU4wVHUySmFSTm14UVRDWlZyTm9H?=
 =?utf-8?B?bGJ6eDVNQ0pHQ2xsYyt0djJUYThHN1ZKdzBqVGZoOSs1cFR1ckg3T1pLMkJ6?=
 =?utf-8?B?Q0NvNG0rWndXdkhIZFJjblBHcVM1OEhWSG1ZSjQvdFZCdmZ4Z0VxdVU3ajZZ?=
 =?utf-8?B?aDEzRmV1S1VlZDlVZXNuRnhpNndObjRqZUxrZFFHdzhFYVdENVYrRHRONWkr?=
 =?utf-8?B?TmIvWEIrZE5SZEVtWE8zWWwyVzIvblpGSEUzdEhVaHpEMVh6QlNUQWpuS1E0?=
 =?utf-8?B?akxMVU1aSU8wc1ZZS04wem5tdGQrZUJGcEZWalk1blBHWEJpd3JBMjNMa1pa?=
 =?utf-8?B?SC9JcjhsUWU1enVTdWJwNzNlR0JKV2x3R09HMUFMdVNkYVNFK2xLbzBNODNJ?=
 =?utf-8?B?NjFWdDRuY2d2Q2FaWVhGTFc0cVN6V0R4R2dRS1N5Z3MzaGNmL0NGdWpHdVow?=
 =?utf-8?B?R0lNMjBmbTB1ZkxnUHdzWHBwYUt6djM4V056UVhhUENZR1VXODA3R1p2S1hF?=
 =?utf-8?B?bE1PVFh0SjA3OFg2ZEJBK3pYSjJNT013MjV0MUxtUFlpYmllZmN4SHpWV2My?=
 =?utf-8?B?RFRmMzdMOFMxUDFhQlU0V0V0Ny9JWlNIS3R5L0MyMkRuRUlDQzgwZ0w4WitB?=
 =?utf-8?B?VGd0RFIwUThmL0lEdEF1bFpJRFdrNXA1Ymo1cGVxcFA1OUMya0txQnhPNk9Z?=
 =?utf-8?B?ZkZQcnY2UjlzUTR4cEpuMm5PYi9sVGdySUg1aHY0eXhYY1VDRkJRNk9QbGpl?=
 =?utf-8?B?eDJyaUExWWFMQWt2KzJ2Zm9vZWJIbUZXWHM3dEE1Q1VUM0w4RWlCNWp3WGhM?=
 =?utf-8?B?TE9aczViSENtYWZFRlhWMFFZUmNEZGh4RmhXL3lxTm1aWjk5YmdPNHdxTlRG?=
 =?utf-8?B?M0NBMnh2MDVMZEVvOWxSNWJmcHBjSmZzTVlDVEpLcUJ3SDN4eFNtS0RINXps?=
 =?utf-8?B?UjdIZWc5Q2NZeldvcFFWTUVPeGxRVVdFT0ZmZVZpaWhHTG5yTGpEM3RFWUIw?=
 =?utf-8?B?QmR4RUEvSE5KQW5XS29kd1h1bXUwVjhtVEljRkE4M21OOUpVdHQzYkxjcnpq?=
 =?utf-8?B?b0RTWVFidFdXRFdNcjBhU2hpNnZDcjcvV28yQU5DZlFIT1JSeWZBTUVUYS9j?=
 =?utf-8?B?YytCU2VISERyTDh4QXNIQWM3eEZTb3FEa3ptNHVwci9uVVFrNmNOb2luL1h1?=
 =?utf-8?B?dkgvcmk3SFdPdGd2V3Bta0JOSTV3Nkt0SktCb0hOUHE4bi9LRVRTdWM2S0Z5?=
 =?utf-8?B?YitzbFlEenE5SzNGMUZRZGdhRWJLb1hOM0N4TWpBMWxyN2ppYU1xVk4xc050?=
 =?utf-8?B?WTlMSW9LYmN4WThRcHV2S0o5NXJ0aHEydG9CN0lkd1luUHQ3TWlzcW8zSENX?=
 =?utf-8?Q?zfD3oXWnR2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhJbTZtblJLK2JzZ3liSzQrZlp1enRvMDBMU1dhZXpZdVdqREd3ODdUT1c4?=
 =?utf-8?B?aGh1Vi9ZL2EzYS90eHY5VFRTZzJudWw2dWNmNW0zVFRIUDArRVNaR3ZXR2Mw?=
 =?utf-8?B?dnk5cS9ldGZHdU5CTThjMkMrU3g1NUlEVWRQQVRtSVpHQzZTTEtOWVpoWHA3?=
 =?utf-8?B?bks3VW96ZUkxRVFzbzFaU2pxWUx6Ylgxb2pSaWR3TXBLOXNEV2wxT3RpQUFL?=
 =?utf-8?B?Rzc3R1UrZXJZWHpEQ05BZlhrdlpPM3V4VGFHeStCVFlldGxzUjdPMVlFTjNm?=
 =?utf-8?B?NjBwdUc2NnA1OTZtaGplWU13YTBaQVVpUjMrS2w0N1JPaFd0c3VXdGQxYWJ5?=
 =?utf-8?B?QVZHcVh5U1FyZlZSaVJGWVYvN0dHbzU5RkFaYWdjOThZTFN2QzEzYXpndmVD?=
 =?utf-8?B?QXN1bmIwMUE4dms1YUhhVk1qMHRFQmpoOWI3bHFLbkdEbC9ia3hWbndJRmdR?=
 =?utf-8?B?SkJ6OVFNSE1jWWJudVVuNVVPenJIN0crL1dYaHVuQjQ4dmlyY3RZNVVZNGhV?=
 =?utf-8?B?NWJGUy9QUHVsUm5tMWhUN3RCdVhkSHk3Rng0WEpWQk40bm81SHdkdHpYVWVt?=
 =?utf-8?B?RGE4V2lHVXFtem5WMjB5Qk5hSkloOHUydVFPdUd6bG1Jc1U2SmNpYnVFcENN?=
 =?utf-8?B?a0grclNzWDFDWHR1SVNxbVZMMVQ5SXFYMEtCQ2N3aGdHZlB0MmlPOFM1QWds?=
 =?utf-8?B?bWFINkw2NlM3cEpnUlQ4alJOdVFkOUs2UjlwTGFzNmkyck5SdUU5VkFKZWhQ?=
 =?utf-8?B?VVdkeEdYYURiSE9BSEZPUmRyL3FPRE1GOGo4NXNSU1hWLzJ1M0VUMDRhRnpX?=
 =?utf-8?B?ZGt6MXFHeVJJWTUva1R4d3dudUZEU0RvdGpWMUlFLzZhSTRDRGVOM2QyOUts?=
 =?utf-8?B?eENOTktmWnVLS3RkWjhpSDJIZEhRcjN0TXVhNGFIY1ZNcmZhWFRzTDh0RkJw?=
 =?utf-8?B?V3I2KzMxN2VOTGJsMXFMV3hjUTBlMElPQTR5bmtwUHdPQzUxUzcwQXlHVWkw?=
 =?utf-8?B?ZE80TnNPSGNJOVpYclllUWloSW9iMyszM2kwejcyQ0pLM0JwS1BobytzY09S?=
 =?utf-8?B?aFNybkN3VVNFTnpqQWJnNTFoeVBpVnlrcCtHUXBZT0ZHbFpvVS9lMTZ2UFZz?=
 =?utf-8?B?SGFVb2xROGY1UzJDdjNzNTZlQ2R1YkwwczVVNXkwN3NFK2xDTERoZUFjWktU?=
 =?utf-8?B?QUlaRWkxR28vOVRyangyUlNHYUNhbWU1OFlWeEo5ZnhiQlFYVTdqbVFlQWdB?=
 =?utf-8?B?cTJlZXZkTitGbm1EMmxRMnVhbFllaDhyWEQ0UGVEQ05uelBXeERUWmhBRXVX?=
 =?utf-8?B?bFEvOS9RRTdXYSswUDRkUzhnVHFSUVkrZE04WWtmaFpGRmZMTS9BTGpiMitJ?=
 =?utf-8?B?eHJYa1lHMk1WMTdnSDZqLzFYNW1SdFZMcXVFTkZVSTZKd2QvcFY1QkNMSERa?=
 =?utf-8?B?RFpqU1ZPVFFqUHdodTBjWDBFcEFYTzVCMDB4YjhXQ1A4OER1dmc0MDNvcG1Q?=
 =?utf-8?B?UlRLZEE5YjIvUU5KSER5blpkZWd6VVRQRzBQODNhYkRqdHV2Q3ZndUN6a0s4?=
 =?utf-8?B?NnVMNW9pT0FlcUhiQlU2SU5ubVlSRzRPUzM5NldPMHdpbEN5TXZ4UERaSjdT?=
 =?utf-8?B?eEFQd0dQSTY5K3Jrdi9jRWx3YkVDUlhRMGRxdDJwV2dQc2xEelJ6SHpzZzVn?=
 =?utf-8?B?bFJMWlZMT3lUU1VmUUxjQmZFcGFySjBDb0lWNjkzY2Z2L1kvU0hoa1pieTlV?=
 =?utf-8?B?ckFLeHZaanowUTJhMDBPbnlrT2xvQno0K1R3bWtKaXp6VE15a1FRN0tTMUFy?=
 =?utf-8?B?MzkrRzNUK3VvWTkva3UxMldFNzNvOWIydytEYkdjTzdpZUQvTEcrK3Z0WitY?=
 =?utf-8?B?b2VhVy9ZdkozODc5c1JwazRuRDFvNXAyL0x1cTdQRmh5Skt2RnVNbnFPN0wy?=
 =?utf-8?B?R3dtYytsV05NKzliVE1vWm5aRndGcy8yYWFLK0VEWjlGeGtUYjZJRFFxNjda?=
 =?utf-8?B?SWg4aGVoU29DZ0tHNEdFQUtVTERDcU0waDFSTW85eEFCY1ZNalNpYVRPS1lI?=
 =?utf-8?B?aktEaDl2MkRmVjArdXZIM2FVRnZlcnkzbXpodFRuWm5jRU5YQVFPZ3BNb203?=
 =?utf-8?B?cGRwZktwcEdVaXN4SEFRQUxHYWo4RFl3Q1I0YktPdjV2RWhLVWYydVp2b1hm?=
 =?utf-8?Q?cJmFpIxN+HSjmagbmly0YhY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B49CAD11CA68E47BE79FF1F011933AA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca3883-6060-4042-3243-08dde66b8e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 19:46:18.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/5bpWvMEpxhus0vkwJ4Qr75AWx0XnwFeZ5gS0YbcfNduZnrwu3JbKKsFdHGtN6jIX/69OSewXocU/FkZqo6Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5499
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX047g0Q1SBoV5
 FeSvJ5wOdfapfdBSemqRqE9G1fKkeaux6/zENIhuY+zjuTm/2fv1nOex82q7CIdPGm0UvM6GUJy
 EEYhVO7Rm+zFJF0FKHaAiywo77AEV88SHM8PNI/sOFFfjU/CCzcA89nthj17/e+8BTHntRnhh/e
 c7yfKxxBHvsVN8M4FTbx9C37oYVCmKujAxYPXhOJOKm6uKVfmH2AJi8wbgiU7rAnvUq1IpRQ3Gw
 7IDMmdGmP7wRybukMiD3MkT8cm9Hg5tEYOK8INwQsAWN3sgg6xsatxl+ZSizNhv6bhimgf/cxmK
 PwgyuLcEArUJNTQTsSpuF7aYzR7aUMwn+vFMtZd1Y5lHDjv2I5urWCmIJcew/5m/fZ+sJrgAN9L
 th3tB+WO
X-Proofpoint-ORIG-GUID: 4bm-_MsIbamASZkzxJ9lpIgCyyqSsyK8
X-Proofpoint-GUID: 4bm-_MsIbamASZkzxJ9lpIgCyyqSsyK8
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68b0b211 cx=c_pps
 a=g3lrz8Yd6sxTX8gyr7xK9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=B53AHJvh2pqn8ue9VsIA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
Subject: RE: [RFC PATCH v2] hfs: add return values to hfs_brec_lenoff and
 hfs_bnode_read to improve robustness
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDEyOjM1ICswMDAwLCDmnajmmajlv5cgd3JvdGU6DQo+IOWc
qCAyMDI1LzgvMjggNDowNCwgVmlhY2hlc2xhdiBEdWJleWtvIOWGmemBkzoNCj4gPiBGcmFua2x5
IHNwZWFraW5nLCBJIGRvbid0IHRoaW5rIHRoYXQgcmV3b3JraW5nIHRoaXMgbWV0aG9kIGZvcg0K
PiA+IHJldHVybmluZyB0aGUgZXJyb3IgY29kZSBpcyBuZWNlc3NhcnkuIEN1cnJlbnRseSwgd2Ug
cmV0dXJuIHRoZSBsZW5ndGgNCj4gPiB2YWx1ZSAodTE2KSBhbmQgd2UgY2FuIHJldHVybiBVMTZf
TUFYIGFzIGZvciBvZmYgYXMgZm9yIGxlbiBmb3IgdGhlDQo+ID4gY2FzZSBvZiBpbmNvcnJlY3Qg
b2Zmc2V0IG9yIGVycm9uZW91cyBsb2dpYy4gV2UgY2FuIHRyZWF0IFUxNl9NQVggYXMNCj4gPiBl
cnJvciBjb25kaXRpb24gYW5kIHdlIGNhbiBjaGVjayBvZmYgYW5kIGxlbiBmb3IgdGhpcyB2YWx1
ZS4gVXN1YWxseSwNCj4gPiBIRlMgYi10cmVlIG5vZGUgaGFzIDUxMiBieXRlcyBpbiBzaXplIGFu
ZCBhcyBvZmZzZXQgYXMgbGVuZ3RoIGNhbm5vdCBiZQ0KPiA+IGVxdWFsIHRvIFUxNl9NQVggKG9y
IGJpZ2dlcikuIEFuZCB3ZSBkb24ndCBuZWVkIHRvIGNoYW5nZSB0aGUgaW5wdXQgYW5kDQo+ID4g
b3V0cHV0IGFyZ3VtZW50cyBpZiB3ZSB3aWxsIGNoZWNrIGZvciBVMTZfTUFYIHZhbHVlLg0KPiAN
Cj4gVXNpbmcgVTE2X01BWCBhcyB0aGUgZXJyb3IgcmV0dXJuIHZhbHVlIGlzIHJlYXNvbmFibGUu
IFRoaXMgY2hhbmdlIGFsc28gDQo+IGFwcGxpZXMgdG8gaGZzcGx1cywgc2luY2UgdGhlIG1heGlt
dW0gbm9kZV9zaXplIGluIGhmc3BsdXMgaXMgMzI3NjggDQo+ICgweDgwMDApLCB3aGljaCBpcyBs
ZXNzIHRoYW4gVTE2X01BWC4gQWRvcHRpbmcgdGhpcyBhcHByb2FjaCBoZWxwcyBhdm9pZCANCj4g
ZXh0ZW5zaXZlIGludGVyZmFjZSBjaGFuZ2VzLiBJIGFncmVlIHdpdGggeW91ciBwb2ludC4NCj4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzL2Jub2RlLmMgYi9mcy9oZnMvYm5vZGUuYw0KPiA+
ID4gaW5kZXggZThjZDFhMzFmMjQ3Li5iMGJiYWYwMTZiOGQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9m
cy9oZnMvYm5vZGUuYw0KPiA+ID4gKysrIGIvZnMvaGZzL2Jub2RlLmMNCj4gPiA+IEBAIC01Nywy
NiArNTcsMTYgQEAgaW50IGNoZWNrX2FuZF9jb3JyZWN0X3JlcXVlc3RlZF9sZW5ndGgoc3RydWN0
DQo+ID4gPiBoZnNfYm5vZGUgKm5vZGUsIGludCBvZmYsIGludCBsZW4pDQo+ID4gPiAgwqAJcmV0
dXJuIGxlbjsNCj4gPiA+ICDCoH0NCj4gPiA+ICAgDQo+ID4gPiAtdm9pZCBoZnNfYm5vZGVfcmVh
ZChzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB2b2lkICpidWYsIGludCBvZmYsIGludA0KPiA+ID4g
bGVuKQ0KPiA+ID4gK2ludCBfX2hmc19ibm9kZV9yZWFkKHN0cnVjdCBoZnNfYm5vZGUgKm5vZGUs
IHZvaWQgKmJ1ZiwgdTE2IG9mZiwgdTE2DQo+ID4gPiBsZW4pDQo+ID4gDQo+ID4gSSBkb24ndCBm
b2xsb3cgd2h5IGRvIHdlIG5lZWQgdG8gaW50cm9kdWNlIF9faGZzX2Jub2RlX3JlYWQoKS4gT25l
DQo+ID4gbWV0aG9kIGZvciBhbGwgaXMgZW5vdWdoLiBBbmQgSSB0aGluayB3ZSBzdGlsbCBjYW4g
dXNlIG9ubHkNCj4gPiBoZnNfYm5vZGVfcmVhZCgpLiBCZWNhdXNlLCB3ZSBjYW4gaW5pdGlhbGl6
ZSB0aGUgYnVmZmVyIGJ5IDB4MDAgb3IgMHhGRg0KPiA+IGluIHRoZSBjYXNlIHdlIGNhbm5vdCBy
ZWFkIGlmIG9mZnNldCBvciBsZW5ndGggYXJlIGludmFsaWQuIFVzdWFsbHksDQo+ID4gZXZlcnkg
bWV0aG9kIGNoZWNrcyAob3Igc2hvdWxkKSBjaGVjayB0aGUgcmV0dXJuaW5nIHZhbHVlIG9mDQo+
ID4gaGZzX2Jub2RlX3JlYWQoKS4NCj4gPiANCj4gPiA+ICDCoHsNCj4gPiA+ICDCoAlzdHJ1Y3Qg
cGFnZSAqcGFnZTsNCj4gPiA+ICDCoAlpbnQgcGFnZW51bTsNCj4gPiA+ICDCoAlpbnQgYnl0ZXNf
cmVhZDsNCj4gPiA+ICDCoAlpbnQgYnl0ZXNfdG9fcmVhZDsNCj4gPiA+ICAgDQo+ID4gPiAtCWlm
ICghaXNfYm5vZGVfb2Zmc2V0X3ZhbGlkKG5vZGUsIG9mZikpDQo+ID4gPiAtCQlyZXR1cm47DQo+
ID4gPiAtDQo+ID4gPiAtCWlmIChsZW4gPT0gMCkgew0KPiA+ID4gLQkJcHJfZXJyKCJyZXF1ZXN0
ZWQgemVybyBsZW5ndGg6ICINCj4gPiA+IC0JCcKgwqDCoMKgwqDCoCAiTk9ERTogaWQgJXUsIHR5
cGUgJSN4LCBoZWlnaHQgJXUsICINCj4gPiA+IC0JCcKgwqDCoMKgwqDCoCAibm9kZV9zaXplICV1
LCBvZmZzZXQgJWQsIGxlbiAlZFxuIiwNCj4gPiA+IC0JCcKgwqDCoMKgwqDCoCBub2RlLT50aGlz
LCBub2RlLT50eXBlLCBub2RlLT5oZWlnaHQsDQo+ID4gPiAtCQnCoMKgwqDCoMKgwqAgbm9kZS0+
dHJlZS0+bm9kZV9zaXplLCBvZmYsIGxlbik7DQo+ID4gPiAtCQlyZXR1cm47DQo+ID4gPiAtCX0N
Cj4gPiA+IC0NCj4gPiA+IC0JbGVuID0gY2hlY2tfYW5kX2NvcnJlY3RfcmVxdWVzdGVkX2xlbmd0
aChub2RlLCBvZmYsIGxlbik7DQo+ID4gPiArCS8qIGxlbiA9IDAgaXMgaW52YWxpZDogcHJldmVu
dCB1c2Ugb2YgYW4gdW5pbml0YWxpemVkDQo+ID4gPiBidWZmZXIqLw0KPiA+ID4gKwlpZiAoIWxl
biB8fCAhaGZzX29mZl9hbmRfbGVuX2lzX3ZhbGlkKG5vZGUsIG9mZiwgbGVuKSkNCj4gPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ID4gICANCj4gPiA+ICDCoAlvZmYgKz0gbm9kZS0+cGFnZV9v
ZmZzZXQ7DQo+ID4gPiAgwqAJcGFnZW51bSA9IG9mZiA+PiBQQUdFX1NISUZUOw0KPiA+ID4gQEAg
LTkzLDYgKzgzLDQ3IEBAIHZvaWQgaGZzX2Jub2RlX3JlYWQoc3RydWN0IGhmc19ibm9kZSAqbm9k
ZSwgdm9pZA0KPiA+ID4gKmJ1ZiwgaW50IG9mZiwgaW50IGxlbikNCj4gPiA+ICDCoAkJcGFnZW51
bSsrOw0KPiA+ID4gIMKgCQlvZmYgPSAwOyAvKiBwYWdlIG9mZnNldCBvbmx5IGFwcGxpZXMgdG8g
dGhlIGZpcnN0DQo+ID4gPiBwYWdlICovDQo+ID4gPiAgwqAJfQ0KPiA+ID4gKw0KPiA+ID4gKwly
ZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBfX2hmc19ibm9k
ZV9yZWFkX3UxNihzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MTYqIGJ1ZiwNCj4gPiA+IHUxNiBv
ZmYpDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgdGhlIHBvaW50IHRvIGludHJvZHVjZSBhbm90aGVy
IHZlcnNpb24gb2YgbWV0aG9kIGJlY2F1c2Ugd2UNCj4gPiBjYW4gcmV0dXJuIFUxNl9NQVggYXMg
aW52YWxpZCB2YWx1ZS4NCj4gPiANCj4gPiA+ICt7DQo+ID4gPiArCV9fYmUxNiBkYXRhOw0KPiA+
ID4gKwlpbnQgcmVzOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXMgPSBfX2hmc19ibm9kZV9yZWFkKG5v
ZGUsICh2b2lkKikoJmRhdGEpLCBvZmYsIDIpOw0KPiA+ID4gKwlpZiAocmVzKQ0KPiA+ID4gKwkJ
cmV0dXJuIHJlczsNCj4gPiA+ICsJKmJ1ZiA9IGJlMTZfdG9fY3B1KGRhdGEpOw0KPiA+ID4gKwly
ZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBf
X2hmc19ibm9kZV9yZWFkX3U4KHN0cnVjdCBoZnNfYm5vZGUgKm5vZGUsIHU4KiBidWYsIHUxNg0K
PiA+ID4gb2ZmKQ0KPiA+IA0KPiA+IEFuZCB3ZSBjYW4gcmV0dXJuIFU4X01BWCBhcyBpbnZhbGlk
IHZhbHVlIGhlcmUgdG9vLg0KPiANCj4gTXkgb3JpZ2luYWwgcGxhbiB3YXMgdG8gYWRkIGEgcmV0
dXJuIHZhbHVlIHRvIGhmc19ibm9kZV9yZWFkKCkuIEhvd2V2ZXIsIA0KPiBzaW5jZSBtb2RpZnlp
bmcgdGhpcyBpbnRlcmZhY2Ugd291bGQgcmVxdWlyZSBjaGFuZ2VzIGFjcm9zcyBkb3plbnMgb2Yg
DQo+IGNhbGwgc2l0ZXPigJR3aGljaCBzZWVtcyB0b28gZXh0ZW5zaXZl4oCUYW5kIGludHJvZHVj
aW5nIGEgcmV0dXJuIHZhbHVlIA0KPiBtaWdodCBuZWNlc3NpdGF0ZSBhZGRpdGlvbmFsIGVycm9y
IGhhbmRsaW5nIGluIGNlcnRhaW4gZnVuY3Rpb25zIChlLmcuLCANCj4gaGZzX2Jub2RlX3NwbGl0
KCkpLCBJIHdhc27igJl0IGVudGlyZWx5IHN1cmUgaG93IHRvIHByb2NlZWQuDQo+IA0KPiBUaGVy
ZWZvcmUsIEkgY3JlYXRlZCBfX2hmc19ibm9kZV9yZWFkKCkgLS0gYSBmdW5jdGlvbiB0aGF0IGJl
aGF2ZXMgDQo+IGlkZW50aWNhbGx5IHRvIGhmc19ibm9kZV9yZWFkIGJ1dCBpbmNsdWRlcyBhIHJl
dHVybiB2YWx1ZeKAlGFzIGEgd2F5IHRvIA0KPiBleHBlcmltZW50IGFuZCBmYWNpbGl0YXRlIGRp
c2N1c3Npb24uIEkgZG9u4oCZdCB0aGluayB3ZSB1bHRpbWF0ZWx5IG5lZWQgDQo+IGFuIGFkZGl0
aW9uYWwgZnVuY3Rpb247IGl0cyBwdXJwb3NlIGlzIHN0cmljdGx5IHRvIGhlbHAgZXZhbHVhdGUs
IHdpdGhpbiANCj4gdGhpcyBSRkMgcGF0Y2gsIHdoZXRoZXIgYWRkaW5nIGEgcmV0dXJuIHZhbHVl
IHRvIGhmc19ibm9kZV9yZWFkIGlzIA0KPiBkZXNpcmFibGUgYW5kIHdoZXRoZXIgdGhlIGFwcHJv
YWNoIHRha2VuIGluIF9faGZzX2Jub2RlX3JlYWQoKSB3b3VsZCBiZSANCj4gc3VpdGFibGUuDQo+
IA0KPiBJIGFncmVlIHRoYXQgd2Ugc2hvdWxkIGNoZWNrIHJldHVybiB2YWx1ZXMgYXQgZXZlcnkg
Y2FsbCBzaXRl4oCUdGhlcmUgYXJlIA0KPiB0b28gbWFueSBpc3N1ZXMgaW4gSEZTIGNhdXNlZCBi
eSBtaXNzaW5nIGNoZWNrcy4gSG93ZXZlciwgSeKAmW0gYSBiaXQgDQo+IGNvbmZ1c2VkIGJ5IHRo
ZSBzdWdnZXN0aW9uIHRvIHZhbGlkYXRlIHRoZSBoZnNfYm5vZGVfcmVhZCBidWZmZXIgDQo+IGRp
cmVjdGx5LiBJZiB0aGUgYnVmZmVyIGlzIGEgc3RydWN0dXJlZCB0eXBlIChzdWNoIGFzIGJ0cmVl
X2tleSksIA0KPiBkZXRlY3RpbmcgZXJyb3JzIGJlY29tZXMgbW9yZSBjaGFsbGVuZ2luZy4gSW4g
c3VjaCBjYXNlcywgd2UgbWF5IG5lZWQgdG8gDQo+IHJlbHkgb24gbWV0aG9kcyBsaWtlIG1lbWNt
cCgpIG9yIG1lbWNocl9pbnYoKS4gRnJvbSB0aGF0IHBlcnNwZWN0aXZlLCANCj4gYWRkaW5nIGEg
cmV0dXJuIHZhbHVlIHRvIGhmc19ibm9kZV9yZWFkIHNlZW1zIGFuIGVhc2llciB3YXkuDQo+IA0K
PiBJZiB5b3UgaGF2ZSBhIGxpZ2h0d2VpZ2h0IG1ldGhvZCB0byBxdWlja2x5IHZlcmlmeSB0aGUg
dmFsaWRpdHkgb2YgYSANCj4gcmVhZCB3aXRob3V0IGludHJvZHVjaW5nIGEgcmV0dXJuIHZhbHVl
LCBwbGVhc2UgbGV0IG1lIGtub3cuIEkgY2FuIA0KPiBmb2xsb3cgdXAgd2l0aCBhIG5ldyBwYXRj
aCB0byBhZGRyZXNzIGl0Lg0KDQpNeSBpbml0aWFsIGlkZWEgd2FzIHRvIGNoZWNrIHRoZSBmaWVs
ZHMgb2YgdGhlIHJlY29yZC4gRm9yIGV4YW1wbGUsIGxpa2UgdGhpcw0KWzFdOg0KDQpoZnNfYm5v
ZGVfcmVhZChmZC5ibm9kZSwgJmVudHJ5LCBmZC5lbnRyeW9mZnNldCwgZmQuZW50cnlsZW5ndGgp
Ow0KaWYgKGVudHJ5LnR5cGUgIT0gSEZTX0NEUl9USEQpIHsNCiAgICAgcHJfZXJyKCJiYWQgY2F0
YWxvZyBmb2xkZXIgdGhyZWFkXG4iKTsNCiAgICAgZXJyID0gLUVJTzsNCiAgICAgZ290byBvdXQ7
DQp9DQoNCkhvd2V2ZXIsIHVuZm9ydHVuYXRlbHksIHdlIGFsc28gaGF2ZSBzdWNoIHBhdHRlcm5z
IFsyXToNCg0KaGZzX2Jub2RlX3JlYWQobm9kZSwgJm5vZGVfZGVzYywgMCwgc2l6ZW9mKG5vZGVf
ZGVzYykpOw0Kbm9kZV9kZXNjLm5leHQgPSBjcHVfdG9fYmUzMihub2RlLT5uZXh0KTsNCm5vZGVf
ZGVzYy5udW1fcmVjcyA9IGNwdV90b19iZTE2KG5vZGUtPm51bV9yZWNzKTsNCmhmc19ibm9kZV93
cml0ZShub2RlLCAmbm9kZV9kZXNjLCAwLCBzaXplb2Yobm9kZV9kZXNjKSk7DQoNCk9mIGNvdXJz
ZSwgdGVjaG5pY2FsbHkgc3BlYWtpbmcsIGl0IGlzIHBvc3NpYmxlIHRyeSB0byBjaGVjayB0aGUg
cmVjb3JkJ3MgZmllbGRzDQpidXQgd2UgY291bGQgbWlzcyBzb21ldGhpbmcsIGl0IGlzIGNvbXBs
aWNhdGVkIGFuZCBpdCBjb3VsZCBiZSBtb3JlIGNvbXB1dGUtDQppbnRlbnNpdmUuIFNvLCBpdCBp
cyBtdWNoIHNpbXBsZXIgc2ltcGx5IHRvIGNoZWNrIHRoZSByZXR1cm5lZCBlcnJvci4gVGhlDQpx
dWVzdGlvbiBoZXJlOiBob3cgdG8gbWluaW1pemUgdGhlIHJlcXVpcmVkIGNoYW5nZXM/IFNvLCBy
ZXR1cm5pbmcgZXJyb3IgY29kZQ0KZnJvbSBoZnNfYm5vZGVfcmVhZCgpIGNvdWxkIGJlIHRoZSBz
aW1wbGVzdCBzb2x1dGlvbi4NCg0KSG93ZXZlciwgSSBkb247dCBjb21wbGV0ZWx5IGFncmVlIHdp
dGggaGZzX29mZl9hbmRfbGVuX2lzX3ZhbGlkKCkgbG9naWM6DQoNCitzdGF0aWMgaW5saW5lDQor
Ym9vbCBoZnNfb2ZmX2FuZF9sZW5faXNfdmFsaWQoc3RydWN0IGhmc19ibm9kZSAqbm9kZSwgdTE2
IG9mZiwgdTE2IGxlbikNCit7DQorCWJvb2wgcmV0ID0gdHJ1ZTsNCisJaWYgKG9mZiA+IG5vZGUt
PnRyZWUtPm5vZGVfc2l6ZSB8fA0KKwkJCW9mZiArIGxlbiA+IG5vZGUtPnRyZWUtPm5vZGVfc2l6
ZSkNCisJCXJldCA9IGZhbHNlOw0KKw0KKwlpZiAoIXJldCkgew0KKwkJcHJfZXJyKCJyZXF1ZXN0
ZWQgaW52YWxpZCBvZmZzZXQ6ICINCisJCSAgICAgICAiTk9ERTogaWQgJXUsIHR5cGUgJSN4LCBo
ZWlnaHQgJXUsICINCisJCSAgICAgICAibm9kZV9zaXplICV1LCBvZmZzZXQgJXUsIGxlbmd0aCAl
dVxuIiwNCisJCSAgICAgICBub2RlLT50aGlzLCBub2RlLT50eXBlLCBub2RlLT5oZWlnaHQsDQor
CQkgICAgICAgbm9kZS0+dHJlZS0+bm9kZV9zaXplLCBvZmYsIGxlbik7DQorCX0NCisNCisJcmV0
dXJuIHJldDsNCit9DQoNCklmIG9mZnNldCBpcyBvdXQgb2Ygbm9kZSBzaXplLCB0aGVuLCBvZiBj
b3Vyc2UsIHdlIGNhbm5vdCByZWFkIGFueXRoaW5nLiBCdXQgaWYNCnRoZSBvZmZzZXQgaXMgaW5z
aWRlIG5vZGUgYW5kIChvZmZzZXQgKyBsZW5ndGgpIGlzIGJpZ2dlciB0aGFuIG5vZGUgc2l6ZSwg
dGhlbg0Kd2UgY2FuIHNpbXBseSBjb3JyZWN0IHRoZSBsZW5ndGggYW5kIHJlYWQgYW55d2F5LiBU
aGUgcXVlc3Rpb24gaGVyZTogaGFzIGJ1ZmZlcg0KZW5vdWdoIGFsbG9jYXRlZCBtZW1vcnkgdG8g
cmVjZWl2ZSB0aGUgcmVhZCBkYXRhPyBCdXQgdGhpcyBjaGVjayBpcyBzaG91bGQgYmUNCmRvbmUg
YnkgY2FsbGVyLiBQb3RlbnRpYWxseSwgaXQgaXMgcG9zc2libGUgdG8gcmVjZWl2ZSBhIGdyYW51
bGFyaXR5IHNpemUgb2YNCnJlcXVlc3RlZCBtZXRhZGF0YSBzdHJ1Y3R1cmUgYW5kIHRvIGNvbXBh
cmUgd2l0aCB0aGUgcmVxdWVzdGVkIGxlbmd0aC4NCk90aGVyd2lzZSwgd2UgY2Fubm90IG1ha2Ug
YW55IG90aGVyIHJlYXNvbmFibGUgY29uY2x1c2lvbi4NCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwg
d2UgaGF2ZSBhcm91bmQgMjUgY2FsbHMgb2YgaGZzX2Jub2RlX3JlYWQoKSBhbmQgbW9zdGx5DQpm
dW5jdGlvbnMgYXJlIHJlYWR5IHRvIHJldHVybiBlcnJvci4gU28sIHdlIGNhbiBjYXJlZnVsbHkg
cmV3b3JrIHRoaXMgbG9naWMuDQpUaGUgaGZzX2JyZWNfbGVub2ZmKCksIGhmc19ibm9kZV9yZWFk
X3UxNigpIGNhbiByZXR1cm4gVTE2X01BWCBhbmQNCmhmc19ibm9kZV9yZWFkX3U4KCkgY2FuIHJl
dHVybiBVOF9NQVguIFRoZSBoZnNfYm5vZGVfcmVhZF9rZXkoKSBpcyB1bmRlcg0KcXVlc3Rpb24g
eWV0LiBTaG91bGQgd2UgcmV0dXJuIGVycm9yIGNvZGUgaGVyZSBvciBjYWxsaW5nIG1lbXNldCgp
IHdpbGwgYmUNCmVub3VnaD8gSSB0aGluayBoZnNfYm5vZGVfZHVtcCgpIGRvZXNuJ3QgcmVxdWly
ZSBzaWduaWZpY2FudCByZXdvcmsgYmVjYXVzZSBpdA0KaXMgbW9zdGx5IGRlYnVnZ2luZyBmdW5j
dGlvbiBhbmQgaXQgc2hvdWxkIGR1bXAgYXMgbXVjaCBhcyBwb3NzaWJsZSBuZXZlcnRoZWxlc3MN
Cm9mIGRldGVjdGVkIGVycm9ycy4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92Ni4xNy1yYzMvc291cmNlL2ZzL2hmcy9kaXIuYyNMODIN
ClsyXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xNy1yYzMvc291cmNlL2Zz
L2hmcy9icmVjLmMjTDMyNw0KDQo+ID4gDQo=

