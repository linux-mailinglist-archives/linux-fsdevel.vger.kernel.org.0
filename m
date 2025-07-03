Return-Path: <linux-fsdevel+bounces-53851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF32AF8364
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FECF583BBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 22:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144C2BDC35;
	Thu,  3 Jul 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="L/HbKUtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1122882C5;
	Thu,  3 Jul 2025 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581630; cv=fail; b=oS6SuTRP9TP2uPYnaPFbHUzZPmkhLxXf5/S7PPCM5Br40PbxTWqALJHXYZDeTPyab6eByV+bji9zKAsIm4sH1Aysr1owqOIhe9kbeKNhGQx5KamwvQXMQnpo0bNeJi70ZT3wlXc3uRFW6HYN6Z+DjseLO5qkDXPuq+jDdg59u1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581630; c=relaxed/simple;
	bh=AHBgPStSPFALfyw3+hb8peF2eIwGORQ5YXKy5VrN9Mc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iJyvz0RYPIWffGZLQgo087NY82kdkkYnFavFr8jiu3zdlUngQBeVHs+/QgCSM0vVFCCEpAVw3bDYGja7rU725ZfuCrfJDacalBUTax/iGCnoWa7/+kePDuy/TyCPMEMfkL8hteMOGRvtKNhqkgBvbDC0Wb14QHQ9uXNK/9Qn0Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=L/HbKUtm; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563ISpS9008088;
	Thu, 3 Jul 2025 15:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=AHBgPStSPFALfyw3+hb8peF2eIwGORQ5YXKy5VrN9Mc=; b=
	L/HbKUtmDqwg0rioCQBXFWT1bDq7K5O+OjQIUmemJUJ7xbGtwH4WSKgDaSye3Ci8
	xC9AgvZIacGTGeN+MNaUyldMp6MCSl0SD4XnWnZaqd96twP/ttRMR0AvrKg3TbuR
	k11PVrciHSeA8szHuM0/zlfnNimH2xBXs2cidLTWuK3AQEUUHxsqEPtoEgeM0WVf
	kstKA682nHoKbFflpubjsLkXCVJc77+fvo9nuBNZjKXfqJcoaTczfiYfVQB0bQh5
	oBubsYGSclWS1dK//8QS2SRo5PW7CWjj0l1N0UjhIi8W0iTLDbRg3+6ixkkfmlUh
	iwaAp2OwJHGLT1jM9hQcJA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47njwspgr7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 15:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr0ZomVboRj8NisjkZ28Zeh61ydBBfn0R+exni+x0TboH2i2ryPDSkSCuz7xI7e00QGhQJfTtI7qwVAycv3o0wd87l4pwgkkya3X9n1WCCU7QmkpToA64GFVlK40R5PQPw5pOTQBV6X7Oz5eDqSsONWlpErgUD+TC5xtq2VRFlpPOUMQLJ1ycuaU9hUCP58a7mvOUoFGiS9CHbnM6Pz5HBewLMazmJqa7TPC709ptoBj6hvC2exJFIoZFuxc4VviL55Go0SxacEwC2fIGFbFdfkm8/Vn/qkHq7I2crjNWobx4z1czE91GYo2OMheTwwi7Ur2EGimcsDIqNGLzJa7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHBgPStSPFALfyw3+hb8peF2eIwGORQ5YXKy5VrN9Mc=;
 b=Zc0gmrpwXeP0V2+sbXL6sR8sTsRW/oJmaTcmf/B3pwOq0cJHbCxK4X5ScBm+CHVZ+HwRPEeO87QmGIEY87PSV+I+bRxiI7RFtO8eR+tNb2pq44X4GnS/nmKgnQ16uTjhGzVXU2FqIGf5usHxbRLJ47WPbJ4idM4oNk8z4ZK6mIIRbn8QupoRhNYEPYiW+vvoDT11wwbneR9SByoFFOwrMfS8K+C6/s4CsOWxrqXbT6eK6RQpFHrVrIuw1r8VgM+u0bD+tGxpGK5+mjZ6zRJnkndc8PoIFqjUW2jGNP0Ea5mhz+61nCUDLRImmZN0H6zQPmSoEPMZyu4nHCkPlXXh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA6PR15MB6527.namprd15.prod.outlook.com (2603:10b6:806:41c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 22:27:02 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 22:27:02 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: Song Liu <song@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "m@maowtm.org"
	<m@maowtm.org>, "neil@brown.name" <neil@brown.name>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>,
        Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Thread-Topic: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Thread-Index: AQHb306vhFvWAuyNskacGFvhkKgz3rQg0kIAgABCRgA=
Date: Thu, 3 Jul 2025 22:27:02 +0000
Message-ID: <C62BF1A0-8A3C-4B58-8CC8-5BD1A17B1BDB@meta.com>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-3-song@kernel.org>
 <20250703.ogh0eis8Ahxu@digikod.net>
In-Reply-To: <20250703.ogh0eis8Ahxu@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA6PR15MB6527:EE_
x-ms-office365-filtering-correlation-id: fbf9d725-79fc-4b5f-160f-08ddba80bbb8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzJYYmtPNlZEWnlBV0lTWGRoQVVmanRtMThwWjRrNGtrTUdBY3phUjluS2dh?=
 =?utf-8?B?endZNm8xTitpNG44WUR1aU0vY2VTVjJqU25lV2h6NlVpZ2NFYlZsa1hTRko3?=
 =?utf-8?B?M2l0b1g0ZTk5U0xnZW9oVlRQRWkrRnNMcCtkK05idmZtaERyNHZHb3NkTXR2?=
 =?utf-8?B?NTNoYUZ5QVIzV05tT2lWa0wyTEpsWU00LzVyQ01jNi8vNmJWTEVDTUxVeGpN?=
 =?utf-8?B?M3lIOU8wZW5UT3hCVTl4QkdRTDJBNTVCODBMdlFvZXB1TmRMbGRWTjJTTVpu?=
 =?utf-8?B?c3dnZ1MrYVN5TVE3Wm41UWN1Rk9KOTFRUm1lTXhUelBlRW5MKzRLa3VGaUxX?=
 =?utf-8?B?YTRVTjB4RHpmNUw2Vk0xRVhBSkRVNUdoZmJMQ3h1ZzRQdEczRnJlYkdKNVov?=
 =?utf-8?B?K0dXTEppRk1tTzZnbTlRMWpTbkJON2ptMEJnZldqR3cwNzgxd0xzdkluaVdL?=
 =?utf-8?B?Y2xqZ3k4bTZ3QmdVL2RuUUJ4OXRQS3I2S1Q4SmlaSlZkSVZEeW5taGFVNTRh?=
 =?utf-8?B?UHB2YURINjhkdjNvMitvQVJyblpwUnY3MEF5SVlXUmFmeG9xallmMHpkT1NJ?=
 =?utf-8?B?TGlZUDhoL2lFMXZlNmRYdWUzSWJOMkR6STlHd2ZaY1IrNHNyOXhod215QVFT?=
 =?utf-8?B?bzlOZzdrVVZwYkh3MzhlclFEeHpzQ0V0M1JaS3d5SG1SekEzV0djRGtaSThB?=
 =?utf-8?B?UzVBSVRySnJvVjFRMWpZYkNWRDBtRW8vR3haU2F6TlpCWTJtZndiSUxpTWR5?=
 =?utf-8?B?Mi90WERVUmVvZWF3OSt4M0x4UjR6c256U0Y1MXFSbkRrbHNBQ2toMUxCdEUy?=
 =?utf-8?B?Z2U4WWtMdHhHd09KMTZFWVBzdE5ibFZTVW1Md1NsU2FPcHFMcEdXY3JQUUJN?=
 =?utf-8?B?K3dyVXJNZ244M0JkTzNiTmt4QWxaL3AzbGVNTTFPL1dEUXRFK0p5aUNkMTFZ?=
 =?utf-8?B?Ry9nenZZdWNZVVh4RHJUL1dEc0dmYThxT0FEcWxLWGZHS1NJeDM1S0lXR1Fl?=
 =?utf-8?B?SXRUQ2JaemNKOStrY0lsQ095TkxkTjhRYWgwTWJaWGtRbWxDUXoxdk55Q3hM?=
 =?utf-8?B?QUtiQlBoN2dmbTVSVDZ4R1g5eE4xQ3lCZG1ydDFMUGpQWHByUm8xa2VqZkhv?=
 =?utf-8?B?NGkyV2tyVWZzN01HZnpyQWdEVnNJeDZvc20wNGVadWZVTXFwQjlpUHNhVU9Y?=
 =?utf-8?B?UzNhTG42K01FajYvaUROQ0EwTHQ1RGFpSGJjVnZJaTBwOTdjSUJERjQxaWpp?=
 =?utf-8?B?ZExwQ0wxb01KcFV6NWFZR3lzZkxPcnRyVmJmM2FlVm5jV3MxODdLalV1QTJ4?=
 =?utf-8?B?TU01SDZMUWhEcVJBY1RsZndPQU5ac3Q2QkNmQ1ZyNzVFc002dVc5akpoNEJU?=
 =?utf-8?B?Ym9EL20xNzJYVDE1d1Y1SnNmZjRQQlhEdFc2NFNjNHdJZ25sZXY0Rlp6VzRH?=
 =?utf-8?B?SFZLUkVTM3B4dS9SRk5QSHh4Q0l5bUtRUXJwNFpad3lHcWwzbkdqZXQ2VW45?=
 =?utf-8?B?ckZQeFhQeGFCWDZMVzdLaTZsRm11UEhnaGZTM1pyNHpZQUNyMS9TSndXdVNC?=
 =?utf-8?B?Rm1xK28rMWpjUTNBSFNvZXJvVG1FczBEOEJzanNUMmlsREREajlwTVk0aEh3?=
 =?utf-8?B?Zlpmd01WMnFhQ1E4bVNNdjRYYUJDMEo0QUs1Zm9wUDFDYVJCMHBzZkFTRHBS?=
 =?utf-8?B?OExyQjJUazhVSVBjaDA1NnhDd2U5ckJzRTBSQzM4TkhoQTdoL2VoVXVEanVk?=
 =?utf-8?B?RytTakJLd3NQbkNicEV0RkRQbmdmU241ZFlVaXhBZFlBbHNLOC9VOFMvUStE?=
 =?utf-8?B?TXBGeGFhOU9iVEdwSHB2bHZQOEFwWVZCVDN3RENHTVlDMU9Ld2g0RlpENTZM?=
 =?utf-8?B?K055TGg5KzVkQ3l6M1JGWk1DY3lCVElSa2lmWXpCdllNK2hqSjczS3JDemZ2?=
 =?utf-8?B?MlJVcjZIZ2k4cFkxcEpVbiswSnhLY0JBYkJtOW5KY09CWXJlcjdxR0tMdkh6?=
 =?utf-8?Q?k/rTS6PHCQmQ4xOk2xTiQ9lQi0QzkY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjViamNTQVd6ekFWWmZkUi9Kam9vQitTamkxSnZtTlM3cW5DMExlOHd2dkpM?=
 =?utf-8?B?cDZST29jbHoxanJmR0ZPS1JmQTlGVEZqQUNRNnJweVlKVmRDcTVhaUtZRU8x?=
 =?utf-8?B?UkxaVkZwZGtBYnBqRjRiSjR0bkJGeURTcFRNUW9ybjJ5MHY0RmR1Wmp4Q1gx?=
 =?utf-8?B?bjZQY1FCL0FUVGcybDgzTUpLTlJ5WVhLZTQ1Y0VWWGFIMDVvY2xpK2FkMnNS?=
 =?utf-8?B?WlVuY1NjSDREekpYS1l2QjBEZ255cFQ5OVBJVzBjRE9iNnVFT1NOdHdNRUZ0?=
 =?utf-8?B?V3VMU3NQQWdlak0vMGhRWnIxMmZFTUFtb3Bla0ZQMG1meDhTVDgybXkxdFM2?=
 =?utf-8?B?M2Fwa3A1UDlLZC9iN2hxMVlZVEdQSGU5M3VjT2xGWEJENitXODdKY0djNFU4?=
 =?utf-8?B?aDVWZTd0a2RTUFlHS2N0WVVNeFZkb1c1Qjd5amNQeUZhTWJ4TEt3V1UrODht?=
 =?utf-8?B?cFArK29QTlZwcTVQd3NVSWErd2FhL0JvSTdUMDdrdC9TZy96L1VJM0w0Uytl?=
 =?utf-8?B?amhOTW5JK0hkTXIzUExqVU8vTTAxUko2cEtkYVRRNU8zM1dPMndCTWltKzFx?=
 =?utf-8?B?V0tGT1cyS0hueHB3SE5DNisvRXdNdUFkcUtmZTdES00wc01BQXA3ZVZyVFgw?=
 =?utf-8?B?ZXJGRUd3ak1MY2tjR3BlMXk2OVpRdmR5Q1NZZHBiYjRRVmdhSEhHN0dFMWhM?=
 =?utf-8?B?TW80TTRucXZvREtDRHBNMTFDeDM4cEZjMmVBR3VPdDV2R3JIWE1yUTVUditP?=
 =?utf-8?B?djlSY2Y4V0ZVRjFNcTI2WnZ4NWlNdlU3WjllTVd0MW5uT042S3cxUFpWTnBt?=
 =?utf-8?B?cXhOa0EyM1NpMHVpWjZHdnVleXp4NUsvMkt0WmhlK0RkaFc5eWEzQVUyRCs3?=
 =?utf-8?B?RWJySXVKdlQ1U0llQVpManZwTVRvdTYwZFJkS1JNSXdpT3FjRm9iNkgvVXRj?=
 =?utf-8?B?Q2EvQXRPSmZCaTRvY0RRNk5LZ29MT3RiU3kzTnpEQWk0LytWa052ZUtEQUlC?=
 =?utf-8?B?V3RnUGFwakp4b0tteEFyLytDcmZ4M0JDRDdaSjJKdWF0Rlo2V05VUG00Ymo4?=
 =?utf-8?B?VmtaUUNMdUl4eEU3N05wVzBXMS9BbWwrbzZxTFhNU2hncnZleDZkQ3F2QUE4?=
 =?utf-8?B?dldwTHRCcXhVWTVWb2RKdXFlMXZPNU1jUGhmY0dHaFE0RjQvVWNZb0ZnZHc4?=
 =?utf-8?B?Q1dnVmxhbnkvbGFDNWxTcFA3ZDZQRks4OVNYdDg1dzY0OHpjclRUZlo4NXRQ?=
 =?utf-8?B?aXBYUHBzVENwOHdHdk1HOVYzV01oZmJTRTgxWTJhc0YyMEFraExSUjh2WEFW?=
 =?utf-8?B?NnJ4Q1JMVHE1RGpBTTRZODJwTXRWUjl2NzlEYVVod0ordjNGemRsbEN3Y3Bt?=
 =?utf-8?B?RFZza2JlU2tVYjFoWGZvSlVYRmdFclYvbUdMbG5xejAzRjUzZzAweVFuanhQ?=
 =?utf-8?B?YnVnQzhFNGVBMFhDNlNwbWtrVUxUM3gySmlxUExRN3ZZY3A4cmJNUU53d21J?=
 =?utf-8?B?RlNabXo0amNCK3lldElPVSsxKzkrSUpaRDBBajE1WC9KZndRL1RQUzBMOHBW?=
 =?utf-8?B?ZzZuYUxFTW56MEM2LzVHeGsxTUlXR3RsbUJWZlFlemdYVlUvVHdTZWw3ZGJ5?=
 =?utf-8?B?eGlwcnZKV3NuaTAxc04xK1BBZVJieExUczZSRmZNQmQxMC9KN1FRbWY0UjRX?=
 =?utf-8?B?NS9LZzVUNjBLL3JNVTVsOWtGckZUdGl0RU52Q0pxcG01T1VHRS9SZ0gxbEtj?=
 =?utf-8?B?ZUxFUVZOSHkyM2lHVlhiM0dveVd6azdUUjBwN04vSkRHeVNJZndqd2V2RjNl?=
 =?utf-8?B?dmE0bEZ4VEZWYlBTSjdXV1l1UWhiaWhYNFc0Q2puei9oa0gxMldxV0xRdXNV?=
 =?utf-8?B?cklOeXphL2lOSHZzbkhoZzlsK25MdTFBR0dVTnJ3bE45djJZcHcvRy94NVdM?=
 =?utf-8?B?VThkWTBsTUJhNE82MnVNSUtvLzdBQmh6S0gxWTBFVHh4dnBkam1mckgwYVQy?=
 =?utf-8?B?eXpaZzJkbHZTVkFFb1FwVllEWXlKRjNUYkVOR2toR3BJWmZ4Mml2aDNsTzR1?=
 =?utf-8?B?MGhhVTVMb01Xc215UE1kRnRCZVp4bzlCK3dtL25TYU5mOVQybndxMG82TE9T?=
 =?utf-8?B?T0ViNWM3bUhiY001dEsxOTNCdllQb1BCVjdlUXphVjcwSjN0YnJ6MnNFckFj?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A111C12875E6884EA8A99A1634681A46@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf9d725-79fc-4b5f-160f-08ddba80bbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 22:27:02.3922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmYCKHJLLpELPUBtWwfdawGFTB8PlHazH5k/tA7JFPRtjP7N5XUDqxBnK763k1S7uz6cbEnLL5Xsau355M6Cqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6527
X-Authority-Analysis: v=2.4 cv=eak9f6EH c=1 sm=1 tr=0 ts=686703bb cx=c_pps a=EG6cR7ip44laGZmQKVicOg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=edGIuiaXAAAA:8 a=drOt6m5kAAAA:8 a=WfYqB7A8Tb2HllLE2XYA:9 a=QEXdDO2ut3YA:10 a=4kyDAASA-Eebq_PzFVE6:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: zpJOkRpo62SXhmzuY0aLxpAatKBVOxz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE4NSBTYWx0ZWRfX/qswT01+l3YC 9aC4tplhqQ4tcE43VWAvIaWZfhWcZc/czZxKTv/e70VwlGp9zWi4Fas46KX/vW9q08YpLwd5Y5/ jNE4WLuUhA3oOeytdAP6N3vv3rHznIYbOl7Nsz3JipmaqzBuSu69LJozliSEWFgS6SWABkx1mVx
 jMV9xqULHM2eeiGqc6p6/tfDLcHhqAgXmBb7FP5V421PIbjzD7D7hn6D8f0day+tNYqeYizxikp 5aFWzgvKB0W8FYzu4XJVzCKSEXVqgAHoZ5piy7G5Azw7LhqA9WIHfNfrhSinCZqievcE/vD2R4C oav0fWZgn3RU8jMxUHUOJdAInH6WSiArspZ+BS+Di6OEGKbKwxm6ZjuixL1RnZW9kWb+GEN3nbm
 doYwuCl/+Vi5YhZOQsoQTx2AZn1fHGO7k1Dm6uBbFmi16UWxbg0KehA8CWRWONKWJXyg0mUZ
X-Proofpoint-ORIG-GUID: zpJOkRpo62SXhmzuY0aLxpAatKBVOxz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_06,2025-07-02_04,2025-03-28_01

SGkgTWlja2HDq2wsDQoNCj4gT24gSnVsIDMsIDIwMjUsIGF0IDExOjI54oCvQU0sIE1pY2thw6ts
IFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAxNiwg
MjAyNSBhdCAxMToxMToxM1BNIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4+IFVzZSBwYXRoX3dh
bGtfcGFyZW50KCkgdG8gd2FsayBhIHBhdGggdXAgdG8gaXRzIHBhcmVudC4NCj4+IA0KPj4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2VzIGludGVuZGVkLg0KPiANCj4gVXNpbmcgdGhpcyBoZWxwZXIgYWN0
dWFseSBmaXhlcyB0aGUgaXNzdWUgaGlnaGxpZ2h0ZWQgYnkgQWwuICBFdmVuIGlmIGl0DQo+IHdh
cyByZXBvcnRlZCBhZnRlciB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIHNlcmllcywg
dGhlIGlzc3VlDQo+IHNob3VsZCBiZSBleHBsYWluZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFu
ZCB0aGVzZSB0YWdzIHNob3VsZCBiZQ0KPiBhZGRlZDoNCj4gDQo+IFJlcG9ydGVkLWJ5OiBBbCBW
aXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjUwNTI5MjMxMDE4LkdQMjAyMzIxN0BaZW5JViANCj4gRml4ZXM6IGNiMmM3
ZDFhMTc3NiAoImxhbmRsb2NrOiBTdXBwb3J0IGZpbGVzeXN0ZW0gYWNjZXNzLWNvbnRyb2wiKQ0K
PiANCj4gSSBsaWtlIHRoaXMgbmV3IGhlbHBlciBidXQgd2Ugc2hvdWxkIGhhdmUgYSBjbGVhciBw
bGFuIHRvIGJlIGFibGUgdG8NCj4gY2FsbCBzdWNoIGhlbHBlciBpbiBhIFJDVSByZWFkLXNpZGUg
Y3JpdGljYWwgc2VjdGlvbiBiZWZvcmUgd2UgbWVyZ2UNCj4gdGhpcyBzZXJpZXMuICBXZSdyZSBz
dGlsbCB3YWl0aW5nIGZvciBDaHJpc3RpYW4uDQo+IA0KPiBJIHNlbnQgYSBwYXRjaCB0byBmaXgg
dGhlIGhhbmRsaW5nIG9mIGRpc2Nvbm5lY3RlZCBkaXJlY3RvcmllcyBmb3INCj4gTGFuZGxvY2ss
IGFuZCBpdCB3aWxsIG5lZWQgdG8gYmUgYmFja3BvcnRlZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjUwNzAxMTgzODEyLjMyMDEyMzEtMS1taWNAZGlnaWtvZC5uZXQvDQo+IFVu
Zm9ydHVuYXRlbHkgYSByZWJhc2Ugd291bGQgYmUgbmVlZGVkIGZvciB0aGUgcGF0aF93YWxrX3Bh
cmVudCBwYXRjaCwNCj4gYnV0IEkgY2FuIHRha2UgaXQgaW4gbXkgdHJlZSBpZiBldmVyeW9uZSBp
cyBPSy4NCg0KVGhlIGZpeCBhYm92ZSBhbHNvIHRvdWNoZXMgVkZTIGNvZGUgKG1ha2VzIHBhdGhf
Y29ubmVjdGVkIGF2YWlsYWJsZSANCm91dCBvZiBuYW1laS5jLiBJdCBwcm9iYWJseSBzaG91bGQg
YWxzbyBnbyB0aHJvdWdoIFZGUyB0cmVlPyANCg0KTWF5YmUgeW91IGNhbiBzZW5kIDEvNSBhbmQg
Mi81IG9mIHRoaXMgc2V0ICh3aXRoIG5lY2Vzc2FyeSBjaGFuZ2VzKSANCmFuZCB5b3VyIGZpeCB0
b2dldGhlciB0byBWRlMgdHJlZS4gVGhlbiwgSSB3aWxsIHNlZSBob3cgdG8gcm91dGUgdGhlDQpC
UEYgc2lkZSBwYXRjaGVzLiANCg0KVGhhbmtzLA0KU29uZw0KDQoNCg==

