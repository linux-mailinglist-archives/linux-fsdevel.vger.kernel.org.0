Return-Path: <linux-fsdevel+bounces-32269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC09A2F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3755228571A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D51EE02D;
	Thu, 17 Oct 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PHIxcRmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D43DAC06;
	Thu, 17 Oct 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199213; cv=fail; b=UE9S1os/3ENkwn+tDt2Waj7P2Hs4lp9QbHdhPEdd8+9SUaDEMz+Ms9uDIFu8F4IOGKbEhIJ4vOiThexfJx1z4GkjMog4sbezhn6gLAikIWNDMOfDKLCbdP/nCK/9+XDMThWlNBAPnU00Uoem5xfhayctMdlwkKS5MXsI+JyjgrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199213; c=relaxed/simple;
	bh=CC8zLNlAVa1VlA80Wyue3XQIljmLo9AmgNKy+C06M7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omcPygAjM/068gVlGKFfoCJSvdKzr+CDGAf4Ti5SiGosD01RFKqB4pQMYZ8WRboCz8oI2JRs/90x5TJKYq9jEV5p0rvZD3+ua3T9D8v3SsXaEO78+fNUZ/88JQHCTx6Pvqwnb5c03xgVJvLmu++5TPvlNhwyC9ANRlmVSoVKVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PHIxcRmN; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTT5LEhjDRrNudDI/E910ZQ+yZ4uLvyYfYNfh0zffz3z1VhGQxIyol7Uf0EsLtcz+7Z+GMUZrrbe8Oo44kOpy+zqkGOq3uqVGBccIy6svAw0TmLsy6zWS96VvoalDv6S0vIduK3BVEeKAR7iADSOiONffHBnBbRr2QVdLhU9QT5rqp/zgNZzxG4XsPL//rQdCbryB5btJ15qSl8ZHko5sFyZWOQ5Gp7NGV6U8BVyUa484gN6y20S+lJWGw5wAzQkrDF7xiign+lDmmVNC1eAoSQstWsvz77g4Ko7lXoAvQNVYkWfZIsVQzgeURanLJUTrOU7dAD0JLNjdOZwh1jnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC8zLNlAVa1VlA80Wyue3XQIljmLo9AmgNKy+C06M7E=;
 b=G2vweBXqNSjKrwtc9z2r59sw8W/Kulb0U9suyy6JqfRUFptbDYI/g62/WPXI7N+1rHKgxo2uBe/S1bGVtdPT3bsKqtLJK7WLemO+Et0Xxt7ArXWdonUGhp15ZvBN3KIcHU1nx5nC7zZgiZxXyAEcCPoC0EX27+ecVscU6KSIl1D3QVKR4cu1AM7gTzAL0rUTjgAZkaBVqlb2hxV0ksL7ZP/2Ch9+SzmAX6/cTpeVN4vSZovAbBgMSwZV6M3hyCwhmQbPeTLBwU/CZzpzHiC6FwIUsAMEU5JoR5bl8mbpc/jjDCqug2Lq/HVJAhKBJ6iYFve3uSGl6KaBLz+tgPa9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC8zLNlAVa1VlA80Wyue3XQIljmLo9AmgNKy+C06M7E=;
 b=PHIxcRmN/XtEGchnIlvegFzz7+HbBAWbRszwNzFFo0k0vjOsNyfpKGe09sM50W9XtiaQU1Wg3y+RiyRnvYOfmBHrtJLpq2S1gJSXG26Or7R7qHlLJiTEDcs9x08QPnVOoRwkWdHpofYmn5xRwKJUdm5WGwRU68fqqMIdXWFVvH8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5549.namprd13.prod.outlook.com (2603:10b6:510:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 21:06:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:42 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "hch@infradead.org"
	<hch@infradead.org>, "paul@paul-moore.com" <paul@paul-moore.com>
CC: "jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"brauner@kernel.org" <brauner@kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "audit@vger.kernel.org"
	<audit@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Thread-Topic: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Thread-Index:
 AQHbGy5eU/FRIA4nekOvU14n2ka3FbKJd3QAgACR5YCAAQKOgIAABpcAgAABKICAAATigIAAHsIAgAAA8ACAAA35AIAANF2A
Date: Thu, 17 Oct 2024 21:06:42 +0000
Message-ID: <95a9bfa51d3a0e6b5f1b82a6db43b909dc7f20bf.camel@hammerspace.com>
References: <20241010152649.849254-1-mic@digikod.net>
	 <20241016-mitdenken-bankdaten-afb403982468@brauner>
	 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
	 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
	 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
	 <ZxEmDbIClGM1F7e6@infradead.org>
	 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
	 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
	 <8d9ebbb8201c642bd06818a1ca1051c5b1077aea.camel@hammerspace.com>
	 <5d7da19b803316e543c4ed7deb1b431c98f2f94b.camel@kernel.org>
In-Reply-To: <5d7da19b803316e543c4ed7deb1b431c98f2f94b.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH7PR13MB5549:EE_
x-ms-office365-filtering-correlation-id: ff02e4e3-3346-46df-af83-08dceeef99a4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDBDVGFIZTM1RHZNRWt2bWFTTWUxTGlLMkdhUUVVZmlNcVFrV2hFMzBzUGFD?=
 =?utf-8?B?blQ5L1kxNE9qSzZqb2xwY1NqcWIvZmVDNUk2aURJMHN6eXphcGVvZFFRdEtz?=
 =?utf-8?B?RWVBdjFKRDhEYVhiYmZJeWxPWW5kUlppNzM3WndSOXlBMEtMb3pZQVpGcUdW?=
 =?utf-8?B?ZHFLby9TY2Z5TjgzaEd2ZE5kbkw4YStwWDJUdXZud0hGb1RQNkdHK3dCWWll?=
 =?utf-8?B?R1ZVQmdoMGVIRnVnTzg2aXNta3h3RzN2UCttVkROVk80VVltY2p4bXlQR0U0?=
 =?utf-8?B?NGF3Z3NoNHREK0M3WGdNTk9uRGk2cUlyR3NnL2FUNURVMUd4TGNXTDdxVURq?=
 =?utf-8?B?c3B6TFRLdzNDSVZBNVl1YlNDVHpkQ0JWS0g4alowNkE1STFXazhPNlpLQ0pT?=
 =?utf-8?B?Uk9UaHQ5aWdLOVlWcG5zOTh6dXJ5UytpNjRrSERhT1hxSzdzMHIvNGhaOHF6?=
 =?utf-8?B?QWlTV2hDcjBSNytWUHowb01rMTFjU0w2RjQ5WnhVVHcvZWFvNitwcUd1S3VS?=
 =?utf-8?B?REIycjR2SGtJWm1pS05QM3JrcGlaWitZM0ZRSnZFaWY2WHlGbzVrVmlJclAz?=
 =?utf-8?B?ZnpJVFRlSGFnZ1lyb0ppc2g3bW5aUDVHUXhQU1YyV3piSmc5N1hSZUI5b1h6?=
 =?utf-8?B?QzJoTHZ0aDZvM1U4ejY4aXlPMjZIeHJvQ0FrQm1nQTZFOFhGcHdGYjhLZmph?=
 =?utf-8?B?RjJCeldQOGVJZ05kU0FPTkFlMEFxQXE4THVodGw3STRhNHVMSHRnam02TDdr?=
 =?utf-8?B?QmFwdmQ5RUNvR3o5ZDU4Y2Y0ZWFlQVdVMEFoUWhpNUt0VXhHSGI0NE9NZkcz?=
 =?utf-8?B?VjhkM0tNVW5rRXRvUXJUMUdZbUJaYUtZRU5PcmNRek5yTzdtWVZDQzRFamNI?=
 =?utf-8?B?WEJEZk1FNmVpU0IyZGk3UzRnYjZta3ZsWUpCR0RiYXpjcWttQlFBYjBZdXh0?=
 =?utf-8?B?U24vQklJM1NMNjllZURYUkNPTkJtYmhPVmM4TElPVnNrV0pYclorYURLV1Vl?=
 =?utf-8?B?WTA3a0MyY29aQ1d6VlZ4c1cwWjNZWEJPaWtwMmJ3ZnVsd2lncFV5VXgxb0Nm?=
 =?utf-8?B?VTVYTTRNbDNRSFk2ZW81RlhORzNwVWlBUkhabGVKRjhSTWE4dlBXdEYxQ1RO?=
 =?utf-8?B?RDlCZlByQ2x5ZTJyQlJnV215Q2p3MnFDZThaNE5zVmN3Rnlsc1ZNSUtxTUs2?=
 =?utf-8?B?WkwzdWxqdmFSUHBrUS9vV0Q4ZlVOcEhpVWZEWHlzQllSbDBGdjNVV2IvRktD?=
 =?utf-8?B?bCtBNGpSL3p0bmZlMkJ2S1dReWNNN0sxVzZrbTVWV1pFU2NPS3Mwck5kaDdq?=
 =?utf-8?B?cFE0QUgvTzFWUk9jcVh3SERlcFdiOGVUU3ZjRUl6a0c5UlVqSUpJeGRmdU9L?=
 =?utf-8?B?TmdiVXNJUkZtSVJXNTlEVnJBa0VBZElKamYvaXl4MFVPcldKYTFScTN6ZkUy?=
 =?utf-8?B?UUY2UzFCYmpScVllTVF4eE9DbkZSS0Z4a20zdXBSWVd6OWppQ2NaaHA4akp3?=
 =?utf-8?B?YnBqTzhRNXI5M0hCR1ZSb0hLZlc0eFFFUFNqaHM5U2R3RTJKaFUyclZMOC9V?=
 =?utf-8?B?K2YxelJDVE8xSWtNbndvbCtRYVUwazAyOHgrd1BxVml2U1FCZnd2a2VlV3J0?=
 =?utf-8?B?b0Z2VXVjcHpHYjlidHh6NS9YcWFFL2tMSWhJamFCamJaS21aNUd4UHFSRlR5?=
 =?utf-8?B?VmRkVzQ4TkozUXR4c0E2TnFlSE9qVWNPVWNvTkpXaXRocm9hTHkxVTZSdDhO?=
 =?utf-8?B?RGx5bXNzTjlmZGJ1cldlaXp0R3ZNZGhMakNBR21vTHZjNm53aGFmUnMyMUNy?=
 =?utf-8?Q?Va8VOxgkfhYk1cOu1iK7sUD04ql/WdTkvqF2w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TW1CRDFOMmRTN25DUWs0cUpWYktZOGQvWVlzWnNzcnQrOHc5MC9xeWlacCtG?=
 =?utf-8?B?N0crUGJTRUpoL29SWXlVNG5wSVAwYXkrcEZqcUZ6OWhLVXlFOXlEZjB2Zzl1?=
 =?utf-8?B?UTZqTWxVczd5V25Ib0JoblU2akFGbzJ0dmpVL21YaXJnR25LejVDOXBIQkJP?=
 =?utf-8?B?SXBrYWk3NWF6RThMZ1pWV2EvYjVrWlBMWHpkWkRsUzd1RjVPam9GZFM1RTh4?=
 =?utf-8?B?QjlYdHhHdkNwZ3BFZDJ4QnE3U2FTdjM5VjV2eW1DZ21SVklTYWpqaWZyWWVp?=
 =?utf-8?B?L0gwMDUyV0xWK0JwY3hVUUVGN0dwZlJ2cHVncm1Md29yZ0lBRVlsSjdmT0dt?=
 =?utf-8?B?akY1ZXJSaHRGbGVCT2NYSUNTTHVoMEl6Y2VWMmVNT1VuNHBZSUU1VUZNRDY4?=
 =?utf-8?B?TzFVRmJVUDlJd04yenFpM2U3UDliUnRyWFNtN25obWdLSFJ5WnNxMGlkNG1L?=
 =?utf-8?B?SjlsWm1YRjdUZFZ2WUZZcFhqVGdaMEcwN0tJMStQRXRDT3Fyb0JrK2VFQlFv?=
 =?utf-8?B?Zm9Nb05pUzJkSW5BMTVrS3ZseVRUY28wNEhVdlVGVWZEOFk5TVgzOTVOVlMy?=
 =?utf-8?B?Qm91bytMVENwL0wwVDMvVmFrcGJzeFVLa0haNUFyaE56S0dGSGh1ZXkvTXhL?=
 =?utf-8?B?dUk1dE51KzdiNHBzRUs4WDBRM0VLKzAvNk4rTyszOXNkNTNDRmE2Uk03VjFG?=
 =?utf-8?B?QzdDTFNOVlZ2R3NURnZvZzdrQ1dnU2kwdTROa3NVUGJ2Y1dNVldRUEIrVDE3?=
 =?utf-8?B?ZiszcTRYazFBVnpOUzcydkRMRTRzVjBwRVA4eHl0OUVNUU9UUTNuekxLcVl1?=
 =?utf-8?B?Rjd6L2g0bEFMZnVBcmgzQzkxU1ZpRXZXZ2hWMUlKZE9Zb0dIR1daWjhSUFBE?=
 =?utf-8?B?YkttdXhHdEhTWmNwRzVJbGw5TWhmb0FtU3VTbmxYNkRtM1ZPNTB0Ym9meWVO?=
 =?utf-8?B?WlVsamh3STRtRDlzeTdWblJHTlVweWpzMDlxNHI2VVpIZjZ0Z0hQWlJOWCsv?=
 =?utf-8?B?QWpiaDRvS1VnS3JROEh4MnprTHBLb3FuUUNsWUtXcUNVVlU4YVJneU5lRUhR?=
 =?utf-8?B?VVIzdXY3WmNQRWlmbFdMTjhUOEwvRmd4TmFMUHBneEp5WEI5SGoxdzBQdWhI?=
 =?utf-8?B?K0tNRkUrZTNQekwvYzd2Vm54bERIN3FrU2QwSFp3Ums4VTJ5ekUxQkxJVVhP?=
 =?utf-8?B?TjBGeW11SGhmMXdIU1h0Y0RDYzM2Y2paRmFzMXJwYVd1dW42SHN1OHFTclgw?=
 =?utf-8?B?a0pMM1NOaVVLaDd3VllFVHdEYkMzREgyY2dseTBBK0VkT0dtb0JFdmgrS1U2?=
 =?utf-8?B?bjB4K3FiV0FJV3FQd0QyL21EYXdvb2FUU3Nkb2h5WmpXUUd0VFFibDVKaFZO?=
 =?utf-8?B?YzZpVzNGTW12Y1NjeDVOV3F5d2pWQnVlSG5FWU9IUVVuaXJTMm4rcUkwVHV4?=
 =?utf-8?B?eEtsMkF2OWhnNWdhYThsQ0xub1MxNDVMNkFTN1ZVT0FMaTNYZUR0THEwV2Rj?=
 =?utf-8?B?UzB3Q1QzWmczREIyMzVWa3BRTmdmRUFjUjNCcnB6ODJFN2pia0I0QXdkZ3Js?=
 =?utf-8?B?NUZzT1RncDNlQi9GanU4Ynp6S1lxY29IaThnbzZXeEJJam41YUlPd3l3cU8y?=
 =?utf-8?B?My9JWGpwb1F1b1FLWSt1SGs0S1duTVVwNGt5V0JqY3R6U2hWNUxBdU1pVVZr?=
 =?utf-8?B?RG9nYWZMOFNCS3pyNjRnOVVTV2MyV1ZBcXV0Y0NBWTkvMmM5WHlwT1kydmxX?=
 =?utf-8?B?ZERsTXMxU1JnTUYxVFB3cXN6ajVzRjlwSWRNWFFRaGpuVWRFTjFHOGRsc0JH?=
 =?utf-8?B?ZWk5Q1BxKy9WVCs4UG5NVUFlZ3pYWGpZYmt2blA1aDVNcXpvQ2FMRlI3Nith?=
 =?utf-8?B?dmYwUWVmVld5aHZNVXRCZFBSaW5JMEo1MmdjMnRlZy80bmRKMGUvcGlrRlgx?=
 =?utf-8?B?MlFLaWI3UmZWYTNScXJpQ0pjQjFjR25jSVJCTCs1ejFlak9lN0lnSGhSaTh2?=
 =?utf-8?B?Y3gyN3N0MUdmWDFBVHJjc3FzQUNCVzNKanR6YUR4SUZvVTVKMGNtRjEwZ2lK?=
 =?utf-8?B?WEFQSU5iMnUrbE9aZmFoMTBQTUd5V240VDR4amNxb2hzQ2lkVWg0Snc5TG5B?=
 =?utf-8?B?Y1NEcEM5N25US3gwb0l0K1ViOXR6SjloalhtOXl4OU8yZ0VYazBCUndqSzA3?=
 =?utf-8?B?U2cxREt1SXdEY0Nmd0hSRnExUzRxRVhCOUMrWkpmT2R2cWE3cldKOFNDWlR1?=
 =?utf-8?B?QUJ6K1NyR3dkS1F3ZjFpMHp4N3VRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E659F491789E234D9BF91E7460BF7103@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff02e4e3-3346-46df-af83-08dceeef99a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 21:06:42.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtJmwFpmy8YeMl2k0+MU2rD5s+xdRuXpNvLkxNKwIzwDBuUWUvugQaoJEYB/nv5UIZPg2WTxIySB88bKd0ktWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5549

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDEzOjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI0LTEwLTE3IGF0IDE3OjA5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVGh1LCAyMDI0LTEwLTE3IGF0IDEzOjA1IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFRodSwgMjAyNC0xMC0xNyBhdCAxMToxNSAtMDQwMCwgUGF1bCBNb29yZSB3
cm90ZToNCj4gPiA+ID4gT24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMTA6NTjigK9BTSBDaHJpc3Rv
cGggSGVsbHdpZw0KPiA+ID4gPiA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+
IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDEwOjU0OjEyQU0gLTA0MDAsIFBhdWwgTW9vcmUgd3Jv
dGU6DQo+ID4gPiA+ID4gPiBPa2F5LCBnb29kIHRvIGtub3csIGJ1dCBJIHdhcyBob3BpbmcgdGhh
dCB0aGVyZSB3ZSBjb3VsZA0KPiA+ID4gPiA+ID4gY29tZQ0KPiA+ID4gPiA+ID4gdXAgd2l0aA0K
PiA+ID4gPiA+ID4gYW4gZXhwbGljaXQgbGlzdCBvZiBmaWxlc3lzdGVtcyB0aGF0IG1haW50YWlu
IHRoZWlyIG93bg0KPiA+ID4gPiA+ID4gcHJpdmF0ZQ0KPiA+ID4gPiA+ID4gaW5vZGUNCj4gPiA+
ID4gPiA+IG51bWJlcnMgb3V0c2lkZSBvZiBpbm9kZS1pX2luby4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBBbnl0aGluZyB1c2luZyBpZ2V0NV9sb2NrZWQgaXMgYSBnb29kIHN0YXJ0LsKgIEFkZCB0
byB0aGF0DQo+ID4gPiA+ID4gZmlsZQ0KPiA+ID4gPiA+IHN5c3RlbXMNCj4gPiA+ID4gPiBpbXBs
ZW1lbnRpbmcgdGhlaXIgb3duIGlub2RlIGNhY2hlIChhdCBsZWFzdCB4ZnMgYW5kDQo+ID4gPiA+
ID4gYmNhY2hlZnMpLg0KPiA+ID4gPiANCj4gPiA+ID4gQWxzbyBnb29kIHRvIGtub3csIHRoYW5r
cy7CoCBIb3dldmVyLCBhdCB0aGlzIHBvaW50IHRoZSBsYWNrIG9mDQo+ID4gPiA+IGENCj4gPiA+
ID4gY2xlYXINCj4gPiA+ID4gYW5zd2VyIGlzIG1ha2luZyBtZSB3b25kZXIgYSBiaXQgbW9yZSBh
Ym91dCBpbm9kZSBudW1iZXJzIGluDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiB2aWV3DQo+ID4gPiA+
IG9mIFZGUyBkZXZlbG9wZXJzOyBkbyB5b3UgZm9sa3MgY2FyZSBhYm91dCBpbm9kZSBudW1iZXJz
P8KgIEknbQ0KPiA+ID4gPiBub3QNCj4gPiA+ID4gYXNraW5nIHRvIHN0YXJ0IGFuIGFyZ3VtZW50
LCBpdCdzIGEgZ2VudWluZSBxdWVzdGlvbiBzbyBJIGNhbg0KPiA+ID4gPiBnZXQgYQ0KPiA+ID4g
PiBiZXR0ZXIgdW5kZXJzdGFuZGluZyBhYm91dCB0aGUgZHVyYWJpbGl0eSBhbmQgc3VzdGFpbmFi
aWxpdHkgb2YNCj4gPiA+ID4gaW5vZGUtPmlfbm8uwqAgSWYgYWxsIG9mIHlvdSAodGhlIFZGUyBm
b2xrcykgYXJlbid0IGNvbmNlcm5lZA0KPiA+ID4gPiBhYm91dA0KPiA+ID4gPiBpbm9kZSBudW1i
ZXJzLCBJIHN1c3BlY3Qgd2UgYXJlIGdvaW5nIHRvIGhhdmUgc2ltaWxhciBpc3N1ZXMgaW4NCj4g
PiA+ID4gdGhlDQo+ID4gPiA+IGZ1dHVyZSBhbmQgd2UgKHRoZSBMU00gZm9sa3MpIGxpa2VseSBu
ZWVkIHRvIG1vdmUgYXdheSBmcm9tDQo+ID4gPiA+IHJlcG9ydGluZw0KPiA+ID4gPiBpbm9kZSBu
dW1iZXJzIGFzIHRoZXkgYXJlbid0IHJlbGlhYmx5IG1haW50YWluZWQgYnkgdGhlIFZGUw0KPiA+
ID4gPiBsYXllci4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IExpa2UgQ2hyaXN0b3BoIHNhaWQs
IHRoZSBrZXJuZWwgZG9lc24ndCBjYXJlIG11Y2ggYWJvdXQgaW5vZGUNCj4gPiA+IG51bWJlcnMu
DQo+ID4gPiANCj4gPiA+IFBlb3BsZSBjYXJlIGFib3V0IHRoZW0gdGhvdWdoLCBhbmQgc29tZXRp
bWVzIHdlIGhhdmUgdGhpbmdzIGluDQo+ID4gPiB0aGUNCj4gPiA+IGtlcm5lbCB0aGF0IHJlcG9y
dCB0aGVtIGluIHNvbWUgZmFzaGlvbiAodHJhY2Vwb2ludHMsIHByb2NmaWxlcywNCj4gPiA+IGF1
ZGl0DQo+ID4gPiBldmVudHMsIGV0Yy4pLiBIYXZpbmcgdGhvc2UgbWF0Y2ggd2hhdCB0aGUgdXNl
cmxhbmQgc3RhdCgpIHN0X2lubw0KPiA+ID4gZmllbGQNCj4gPiA+IHRlbGxzIHlvdSBpcyBpZGVh
bCwgYW5kIGZvciB0aGUgbW9zdCBwYXJ0IHRoYXQncyB0aGUgd2F5IGl0DQo+ID4gPiB3b3Jrcy4N
Cj4gPiA+IA0KPiA+ID4gVGhlIG1haW4gZXhjZXB0aW9uIGlzIHdoZW4gcGVvcGxlIHVzZSAzMi1i
aXQgaW50ZXJmYWNlcyAoc29tZXdoYXQNCj4gPiA+IHJhcmUNCj4gPiA+IHRoZXNlIGRheXMpLCBv
ciB0aGV5IGhhdmUgYSAzMi1iaXQga2VybmVsIHdpdGggYSBmaWxlc3lzdGVtIHRoYXQNCj4gPiA+
IGhhcw0KPiA+ID4gYQ0KPiA+ID4gNjQtYml0IGlub2RlIG51bWJlciBzcGFjZSAoTkZTIGJlaW5n
IG9uZSBvZiB0aG9zZSkuIFRoZSBORlMNCj4gPiA+IGNsaWVudA0KPiA+ID4gaGFzDQo+ID4gPiBi
YXNpY2FsbHkgaGFja2VkIGFyb3VuZCB0aGlzIGZvciB5ZWFycyBieSB0cmFja2luZyBpdHMgb3du
IGZpbGVpZA0KPiA+ID4gZmllbGQNCj4gPiA+IGluIGl0cyBpbm9kZS4gVGhhdCdzIHJlYWxseSBh
IHdhc3RlIHRob3VnaC4gVGhhdCBjb3VsZCBiZQ0KPiA+ID4gY29udmVydGVkDQo+ID4gPiBvdmVy
IHRvIHVzZSBpX2lubyBpbnN0ZWFkIGlmIGl0IHdlcmUgYWx3YXlzIHdpZGUgZW5vdWdoLg0KPiA+
ID4gDQo+ID4gPiBJdCdkIGJlIGJldHRlciB0byBzdG9wIHdpdGggdGhlc2Ugc29ydCBvZiBoYWNr
cyBhbmQganVzdCBmaXggdGhpcw0KPiA+ID4gdGhlDQo+ID4gPiByaWdodCB3YXkgb25jZSBhbmQg
Zm9yIGFsbCwgYnkgbWFraW5nIGlfaW5vIDY0IGJpdHMgZXZlcnl3aGVyZS4NCj4gPiANCj4gPiBO
b3BlLg0KPiA+IA0KPiA+IFRoYXQgd29uJ3QgZml4IGdsaWJjLCB3aGljaCBpcyB0aGUgbWFpbiBw
cm9ibGVtIE5GUyBoYXMgdG8gd29yaw0KPiA+IGFyb3VuZC4NCj4gPiANCj4gDQo+IFRydWUsIGJ1
dCB0aGF0J3MgcmVhbGx5IGEgc2VwYXJhdGUgcHJvYmxlbS4NCg0KDQpDdXJyZW50bHksIHRoZSBw
cm9ibGVtIHdoZXJlIHRoZSBrZXJuZWwgbmVlZHMgdG8gdXNlIG9uZSBpbm9kZSBudW1iZXINCmlu
IGlnZXQ1KCkgYW5kIGEgZGlmZmVyZW50IG9uZSB3aGVuIHJlcGx5aW5nIHRvIHN0YXQoKSBpcyBs
aW1pdGVkIHRvDQp0aGUgc2V0IG9mIDY0LWJpdCBrZXJuZWxzIHRoYXQgY2FuIG9wZXJhdGUgaW4g
MzItYml0IHVzZXJsYW5kDQpjb21wYWJpbGl0eSBtb2RlLiBTbyBtYWlubHkgb24geDg2XzY0IGtl
cm5lbHMgdGhhdCBhcmUgc2V0IHVwIHRvIHJ1biBpbg0KaTM4NiB1c2VybGFuZCBjb21wYXRpYmls
aXR5IG1vZGUuDQoNCklmIHlvdSBub3cgZGVjcmVlIHRoYXQgYWxsIGtlcm5lbHMgd2lsbCB1c2Ug
NjQtYml0IGlub2RlIG51bWJlcnMNCmludGVybmFsbHksIHRoZW4geW91J3ZlIHN1ZGRlbmx5IGV4
cGFuZGVkIHRoZSBwcm9ibGVtIHRvIGVuY29tcGFzcyBhbGwNCnRoZSByZW1haW5pbmcgMzItYml0
IGtlcm5lbHMuIEluIG9yZGVyIHRvIGF2b2lkIHN0YXQoKSByZXR1cm5pbmcNCkVPVkVSRkxPVyB0
byB0aGUgYXBwbGljYXRpb25zLCB0aGV5IHRvbyB3aWxsIGhhdmUgdG8gc3RhcnQgZ2VuZXJhdGlu
Zw0Kc2VwYXJhdGUgMzItYml0IGlub2RlIG51bWJlcnMuDQoNCj4gDQo+IEl0IGFsc28gZG9lc24n
dCBpbmZvcm0gaG93IHdlIHRyYWNrIGlub2RlIG51bWJlcnMgaW5zaWRlIHRoZSBrZXJuZWwuDQo+
IElub2RlIG51bWJlcnMgaGF2ZSBiZWVuIDY0IGJpdHMgZm9yIHllYXJzIG9uICJyZWFsIiBmaWxl
c3lzdGVtcy4gSWYNCj4gd2UNCj4gd2VyZSBkZXNpZ25pbmcgdGhpcyB0b2RheSwgaV9pbm8gd291
bGQgYmUgYSB1NjQsIGFuZCB3ZSdkIG9ubHkgaGFzaA0KPiB0aGF0IGRvd24gdG8gMzIgYml0cyB3
aGVuIG5lY2Vzc2FyeS4NCg0KIkknbSBkb2luZyBhIChmcmVlKSBvcGVyYXRpbmcgc3lzdGVtIChq
dXN0IGEgaG9iYnksIHdvbid0IGJlIGJpZyBhbmQNCnByb2Zlc3Npb25hbCBsaWtlIGdudSkgZm9y
IDM4Nig0ODYpIEFUIGNsb25lcy4iDQoNCkhpc3RvcnkgaXMgYSBiaXRjaC4uLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

