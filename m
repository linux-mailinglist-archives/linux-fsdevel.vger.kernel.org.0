Return-Path: <linux-fsdevel+bounces-32240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044E9A2A69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27251285ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478881DFDBB;
	Thu, 17 Oct 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KFB/8q3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479E1DF96A;
	Thu, 17 Oct 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184966; cv=fail; b=LCGWEzDeSFB2m+c0ypUW4WaTJ0IGwBe8HVd8UJUc7w0CSgejkqy5zGsdpyDGe+hU2ItDsuvgPggdGTU6SUOYw4v2XBbFZTtKw30tHgNFDI8opwTUUPOwutBvo5383nW4awnp33xMmKq8mI0AJa5Jicz1LoHBdcm/o5O8vgH7X/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184966; c=relaxed/simple;
	bh=Gdh/Op2xcBLZz0rqe0j2CU2g23vOr6TOef+aK+B86SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l0ZesE5J88FjPcQvTSWK24ChECCyCFNGp1ZfF7v801f9JHGsvVsrUkN3nmKmhWPhyxCEtL16MwzjMpe7jie2car2+FVfRUBl/zGbZtpESl5hiOiXOdKhkCmuWht/UBxWjwtDMlcBFpyvkeMQsuIBys48V3AzeDaWRCWhgyeLXKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KFB/8q3y; arc=fail smtp.client-ip=40.107.220.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe0xYASLBZhUWiF8W/360+NfIPQ5dXpuyARzs7vTeVkB1K9r69fXImg/loeaZDs7JvCx8Zz9GFuV2xL6oHMZIKbjr696Sp7GuWsZ1Tr1tQ5Tj94duWhAIXxXsqv+IzEn/yjBpxiKzfdeRauhkznlUsVUpNjy1quIR5LeZCEfdasl/deDasStuqk5Z5EJ6kIl6+1q8N7rqgDBxlVuEoqP311L0za7cgjUv1HOmP9xeo1f4dc6wnoKRx+FZ7me0M1ND30qQqJ6ITiPA9NOn8JWjdIk+NAyrJzq+AqBobya0v/Mic+qIJDxApdqrweXOYa49kZbeUxZKCsQxeXSuEU46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdh/Op2xcBLZz0rqe0j2CU2g23vOr6TOef+aK+B86SU=;
 b=eimBaCj/+mDOFQC4hlMFpoIhPMX6ENHMWrJX9Sug21JZtcOLu8d+v8vwce9Z/TEosgUNV3g7YnY8b3Cr48S0bZGfbV97sCYsR9VnZkyInk+vYay5bagOPjW32d4Iw7C3ZTyA1XHMDnJXxUK6AKIwfc8zSmuyqGBVk2fmHO4Gofg+ld9frirw7+0TBgsAVH7hfhEnYGKMwyIW4i6mJkUThIrtEf7kcS3gCUg6iB6MhaaGi8KiaoNE5q0v9W26o+LZx4gual+GpKaImUI91Oulo9YMhojtWJfFHEXfsDgHowASRgFzofA97+pZ8yapjhCs7JFTM85r4B48aE4tegyDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdh/Op2xcBLZz0rqe0j2CU2g23vOr6TOef+aK+B86SU=;
 b=KFB/8q3y/GC6Sohiy1Qacw4nlzGsazz+rlxoSoX5sOY3EJbCtA//FwUJLxqKo8GJNCss/H93DknNw/LpBZ49Pv/nGhV8haT+2UhVAnB6MKZylD9NdZw7U1muw1hUDcsiVQWuENruyNDkNWrCEgsQ6cTSqlw+9BcW6tn0cPR2KTU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH4PR13MB6881.namprd13.prod.outlook.com (2603:10b6:610:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 17:09:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:09:17 +0000
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
 AQHbGy5eU/FRIA4nekOvU14n2ka3FbKJd3QAgACR5YCAAQKOgIAABpcAgAABKICAAATigIAAHsIAgAAA8AA=
Date: Thu, 17 Oct 2024 17:09:17 +0000
Message-ID: <8d9ebbb8201c642bd06818a1ca1051c5b1077aea.camel@hammerspace.com>
References: <20241010152649.849254-1-mic@digikod.net>
	 <20241016-mitdenken-bankdaten-afb403982468@brauner>
	 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
	 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
	 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
	 <ZxEmDbIClGM1F7e6@infradead.org>
	 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
	 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
In-Reply-To: <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH4PR13MB6881:EE_
x-ms-office365-filtering-correlation-id: 133d2243-e8ac-4b35-873f-08dceece6ef9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3kvY3F3M0ZNNkoxek01emtFUjRRVWZpN0VUNHhzY3F4ZENpYnNwaEVlcHdz?=
 =?utf-8?B?dGMwOFNmeHpxV2RFMGh6MWJZbFF2UG0ybGd3alIrRlpOL2FjbFpETGtzS2Zo?=
 =?utf-8?B?S2RhdXZJWWxiSWFBc1BzVk5SUDVkVEdDNzMwM3pKUWZ4dGEzK29WQmtkelhx?=
 =?utf-8?B?WWEyVnF0akVQNS9JOVNNN0FVaGtkQ0dheVpQV0JHemRDK3R0dElVcmZuSzZU?=
 =?utf-8?B?R01WN1NtVE5pb1VRZk5oZHF6a3IwNHVBTWtrdlFZcVBvenBkWjc3a2JtWnNS?=
 =?utf-8?B?SUJHVE8zOFdxK1Y2N2ZuVi9pbFljd3NhTm1Gem5qblMwZTQwSXEranVJbHZE?=
 =?utf-8?B?ejFETnFPdE1FMFViR1VEUU14Y3pYam15dUFZbFY4Wm1YM25QLzJYWko2NUc4?=
 =?utf-8?B?MlkySXFXQ2RwK2Foek5COUcxVUFZS0lKSE53dEZiWGIxN00zKzZSaHM4YllZ?=
 =?utf-8?B?Q2s3ZlRsMmFQd3dSZUtBNitsNmFyaHVxOGZjUHNkTFhZSkZXMUZnQnkrc0FK?=
 =?utf-8?B?dW8vaDZLa3BKQ3lpbndUMC9VbmtQOUsyM095cEVOMkJRVG54KzVkUitjQUht?=
 =?utf-8?B?SnVDNm1sYk9GdTdneWkrc3k0Y1M2TVZxSnNqRkRPOUR1c3c3SHlJdjRPV0Zv?=
 =?utf-8?B?NkE4dHNTZjYzWVNRaEFTbFJxOUYwK1A0SHgvelFXTW1XYjdFelRKUGtjMER5?=
 =?utf-8?B?d3RPeTVPNno2Tjk3VXY3Z3pIUWlmUEFGZkNpRWhOSXQvK2x6TDA0WlN6ZkN5?=
 =?utf-8?B?a1FSQ3J2cTBhMVdibEg5aHpOUkxCZVQrdjBIYkQzZWhxVlpmbEhXYk1udVNv?=
 =?utf-8?B?WktwTzJkZ1BDTzRLeXBwQzVKVTFDbjYwQ2REVkhaWWJrZ29nSTZYUzh6V1Q1?=
 =?utf-8?B?bFdhMlNSQXhEMkRtWS9IR0FTdzJQeDhhMUJkVXlCblpkT2syL2xGZTBUZnQ0?=
 =?utf-8?B?SHBEYm4vN2N5MWY2OStkWW15TkpoaUNERTJMM2dLYWFsc0h0c0lDSFExSUlZ?=
 =?utf-8?B?Q0tzb2ErOWdQSWozeHQwbnRjbG5VN0w4UFk0c2VhWUNuMVBlU0EyQlM3N0ZZ?=
 =?utf-8?B?TCtBcUFDbzFHeVd3SEtGM1pheVhqY0hxaStsTjllZ09mTDR5QmwwM1owN0tO?=
 =?utf-8?B?VzdHNGhBS0RmRDczUkdOV2ladXg1cUlDUDVUUjhFeVJTUHlsRzdjUDRYSWpP?=
 =?utf-8?B?akpveWNScTYyWXRjeExIUVlCNE9GRFlkaEp5SEpYZzNTN2FiTGVEWmswTmZr?=
 =?utf-8?B?WHlhQ0cwVDJZWHdrQ1BHRDdJZ2R0aDBCeFdzVmpUQ09xSTJ2OGNZWUlCZnpF?=
 =?utf-8?B?OXorUGpsTHBsbkN3bklFOGI3RDVRRjM1UDZEb3ZUcTNjWjNYb25GMzBIdnkw?=
 =?utf-8?B?ektnalhhNFRRelJnK1BqdktreVNIZ2Rwc3hSZ2cxMUwzUW5hcTdMbG5IWG5J?=
 =?utf-8?B?ZlduZk94VXVLVE9ONUxtci9HQmdQZ0NWYmYxd3pweVc0TTEyUHpkdWtwY0ty?=
 =?utf-8?B?bk5jWkFWeFNlc3BiYk8yeEN4M3g3aGN4aEJJU0RhcEdmbzNsT2pha1ZuMFlG?=
 =?utf-8?B?M1RvOEMxK1lXcUtnTHJRa0RycEVlV2ZsU0lneSsyRm1EU2ZJSEwrellKbWpV?=
 =?utf-8?B?REIxWXM1TTdPajVDaUpIL1hUNDRqbzdMZ1p6SmQ5STFQdlY1SDNPblpoSUtJ?=
 =?utf-8?B?TEY0eVZyYWVuSXlVVFdLWGVObEtkcXJVR21pWFYzYlF6TTJLYVNtL2tVSVVi?=
 =?utf-8?B?TjJjNGQxaFhraUNzcDV2Nm9WS1YvdTV4TmY5d0xuU0V5RE05V1BuTmIvdDhS?=
 =?utf-8?Q?rVRkUoUz2duspaU3OHkhYWhmcVIxXCj5QYCA0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUhGUkZOb0V2cGZIeVFJTjhHZ3pYMWVPR3UwQlJMcDlya2Z1Y3pqNS9ZV05V?=
 =?utf-8?B?OVZuc3BKZjlWRWZZSS9QZlREbVdQb0d3MTF3ZDE1cmtPRlNDRVlxR2wraHZL?=
 =?utf-8?B?RmZaaXNsbkg0T0s0bnhpRFlhZ0ZiT3l3Y2NHb1YwVXI1RVVGN0hNR2NNc0pr?=
 =?utf-8?B?bmc1YkczSjNJNlZIOExnRW9DSEx4OVpPa3NCc1BoOHZDNzFTOHUwYWhjY0Zz?=
 =?utf-8?B?QnlibUdJV25KVytBMTJNNURUT0RkbXYxaHVMdXM1NDAzak9POHhOR3grMjNp?=
 =?utf-8?B?R1Y0NE1UYkxqSXVWcCtiSVVQd3pId29uZGp0MHBldnBCcTNJdXFVOHk0U0xr?=
 =?utf-8?B?RlZtVi8zN0lkMEkzd1VGMjZra2EvTVpzbWpnWW1PZjljWThIWnBpbkJEVDBB?=
 =?utf-8?B?c0l2bGFuUlB4eGR6bHVPZ1M0b0FaZzRFN3FxQnZVNGlLc0NvL1RCZThrV2xW?=
 =?utf-8?B?OG0wenZjR284YWhwcURaaEI2Q0R5NUtjNEtBOXJaazlhenZxYkttSU1qcVlo?=
 =?utf-8?B?bjRUT3R4UTBsdk1DdW1nUEVnak9OYmxXU2RyWjN0ZkZXZVRuSVg3eEZZS2FR?=
 =?utf-8?B?cGMzMzJobzRDWm5sd0xqNnR1RUtqTmwwS293Slo4ZUtGU3prTEdELzlXQno3?=
 =?utf-8?B?bUZCcUdaQjQ4aDVoMlZyemF3eXZxTTBVTi9zQzBsRnN2TmZhYmhsRXdWRlBM?=
 =?utf-8?B?bWpoMmpJUksra3ZRaWVUdCthZU9taC91V1VRcVV1ZG94NUFJZWhoVW0rRFZs?=
 =?utf-8?B?SGZBbStOcDVHbWpxclZkK2Q5YzRRekxMa2ZPUE1Gc0VWTVk5YjBqM0xKbi9J?=
 =?utf-8?B?cnJZTUNNWUt2aTlZR0trakVyOWxZcDQ1VzJOQVVvMHJ2WEp1U2ZnTE0yUCtV?=
 =?utf-8?B?RHdZM29iNEtYdHB1SkJJREQ5ZlVkY2FabHIvSUUvZTg0QjJjVXlNK3RSWjlp?=
 =?utf-8?B?VitURk9JVjRxR2JUSVdaVDBwMG5MNnBOL1ZBdW9EeGhVdXFRampTRDZ2WVBj?=
 =?utf-8?B?c0lJL3V4UnBGQkFnTEpjK1g5NFV3UWFoVXl3NnE4M0txa0ZydGordDdEYmlw?=
 =?utf-8?B?bE9nakFTeUg4YTMramRsUnNyYkVUNmJPVDZ3UFBqK2VuRFBVVENGbi93MFQ2?=
 =?utf-8?B?aG9pOUh2WWpEcXd4bHdwbU8zN05ldlAyeVQwNFljaGpaMGtyWVdwTVdtVFhH?=
 =?utf-8?B?TXovZXlmcUF6NzhpUHpFM2lBdDk1V1J2R3pONUwrNmlKNENjK2RmMGNpSHh5?=
 =?utf-8?B?S2xYWm4rNnErS1h4YnRnUXhJVFNncDhtN0VEWXVSMVIxbTlVbWdzVXdXTWJ5?=
 =?utf-8?B?VU1mN2RLeUpseDE3U3dseVh2SWJCOFF1a3VEdDU3N0ZWcHR2N0Z1a3dJRkNG?=
 =?utf-8?B?bUVYdTV4WkFvdXhyYk5LN1dUSjg0Z0pRbHI1a3FPKzk0b1JCQ2NRbGo0MWZt?=
 =?utf-8?B?WFJhNHV4aDBPUDJ5YkphQzBoaFhOc21lK0VLQml2SDdJOCs4cWlTV2hvVkFo?=
 =?utf-8?B?KzYxT3NiMjFrN2xuMnYrUURzRjc0d2l6VXpNMzhrNTVOWDV0TEdLM1pGL2wy?=
 =?utf-8?B?dFRCTExnSy81NVU4ZVpzVzU4am5IQ0R6YTREOTZyZWFlVm8wUkhCZUhzYnIw?=
 =?utf-8?B?RWVsWENOWHhrNllMZHFzakZsYUFaQkx6VGE0ZzBUbEIvdTVBb2M0d0d2V2Qy?=
 =?utf-8?B?anFvREFzZklJclY0c2IreXdZQU95RUhnWTUxcmV3N05nZTYzWFlyQnYzMUN2?=
 =?utf-8?B?MERCYk5pMGFsNHNnVTM4M1RvQStJTE11bW9LaFhDOWtxQi9CY1FOeWlnZ1FE?=
 =?utf-8?B?cks1MExFRWxsSDFYRDJ0S0V4THBqOGN0QW9WRFYxbHMvR1dtL0dld3RjeGZw?=
 =?utf-8?B?UDNwSW5KRXE1R0NKYWJ3RktpK3RoWmdYeU1mM1BaakZDRmpYMFh5Mi9uUU1U?=
 =?utf-8?B?M0VWTEtWUWc1aTArL2U4WGxLRWlSTVd1NHQ5azBYa1lFYkh5WHd2NC9EZHhx?=
 =?utf-8?B?RWo4QmFUWnl5bm0rd1hJUmVibXJoY3NIVXB0QStVZDg5RnlyM3g3alBlZUpl?=
 =?utf-8?B?VGJ0Z1BaVmhzVmhPRVIxcFB5ZXNmUVlEbmdmNGljdlVmaVd0bzJsQTQ0bFd4?=
 =?utf-8?B?Q0hrUVJySmVyZDJQVjFLRXY5bHozRTlXTU1iSTFTQ1V4OWVkemR4dUtEeDRS?=
 =?utf-8?B?QkNEWTlabzVoc082eDB0ODFHYzhlWDc3NHFlMW1Ma1cwSG1VTDVBV1BRUjgx?=
 =?utf-8?B?VStwNUdzeDBXYjBteUxKa2d2RnZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4734D2C482866C4385A726CB4BBF8A54@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 133d2243-e8ac-4b35-873f-08dceece6ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 17:09:17.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnLYxQOoB+rBe+zmNkSKRkKY9hZpjmYedQxDsHnPfa47KNa79b7Qd91/tVMeL8ciphvY+fu3O/VRN/jC/bxxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR13MB6881

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDEzOjA1IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI0LTEwLTE3IGF0IDExOjE1IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOg0KPiA+
IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDEwOjU44oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcNCj4g
PiA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBPY3QgMTcsIDIwMjQg
YXQgMTA6NTQ6MTJBTSAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToNCj4gPiA+ID4gT2theSwgZ29v
ZCB0byBrbm93LCBidXQgSSB3YXMgaG9waW5nIHRoYXQgdGhlcmUgd2UgY291bGQgY29tZQ0KPiA+
ID4gPiB1cCB3aXRoDQo+ID4gPiA+IGFuIGV4cGxpY2l0IGxpc3Qgb2YgZmlsZXN5c3RlbXMgdGhh
dCBtYWludGFpbiB0aGVpciBvd24gcHJpdmF0ZQ0KPiA+ID4gPiBpbm9kZQ0KPiA+ID4gPiBudW1i
ZXJzIG91dHNpZGUgb2YgaW5vZGUtaV9pbm8uDQo+ID4gPiANCj4gPiA+IEFueXRoaW5nIHVzaW5n
IGlnZXQ1X2xvY2tlZCBpcyBhIGdvb2Qgc3RhcnQuwqAgQWRkIHRvIHRoYXQgZmlsZQ0KPiA+ID4g
c3lzdGVtcw0KPiA+ID4gaW1wbGVtZW50aW5nIHRoZWlyIG93biBpbm9kZSBjYWNoZSAoYXQgbGVh
c3QgeGZzIGFuZCBiY2FjaGVmcykuDQo+ID4gDQo+ID4gQWxzbyBnb29kIHRvIGtub3csIHRoYW5r
cy7CoCBIb3dldmVyLCBhdCB0aGlzIHBvaW50IHRoZSBsYWNrIG9mIGENCj4gPiBjbGVhcg0KPiA+
IGFuc3dlciBpcyBtYWtpbmcgbWUgd29uZGVyIGEgYml0IG1vcmUgYWJvdXQgaW5vZGUgbnVtYmVy
cyBpbiB0aGUNCj4gPiB2aWV3DQo+ID4gb2YgVkZTIGRldmVsb3BlcnM7IGRvIHlvdSBmb2xrcyBj
YXJlIGFib3V0IGlub2RlIG51bWJlcnM/wqAgSSdtIG5vdA0KPiA+IGFza2luZyB0byBzdGFydCBh
biBhcmd1bWVudCwgaXQncyBhIGdlbnVpbmUgcXVlc3Rpb24gc28gSSBjYW4gZ2V0IGENCj4gPiBi
ZXR0ZXIgdW5kZXJzdGFuZGluZyBhYm91dCB0aGUgZHVyYWJpbGl0eSBhbmQgc3VzdGFpbmFiaWxp
dHkgb2YNCj4gPiBpbm9kZS0+aV9uby7CoCBJZiBhbGwgb2YgeW91ICh0aGUgVkZTIGZvbGtzKSBh
cmVuJ3QgY29uY2VybmVkIGFib3V0DQo+ID4gaW5vZGUgbnVtYmVycywgSSBzdXNwZWN0IHdlIGFy
ZSBnb2luZyB0byBoYXZlIHNpbWlsYXIgaXNzdWVzIGluIHRoZQ0KPiA+IGZ1dHVyZSBhbmQgd2Ug
KHRoZSBMU00gZm9sa3MpIGxpa2VseSBuZWVkIHRvIG1vdmUgYXdheSBmcm9tDQo+ID4gcmVwb3J0
aW5nDQo+ID4gaW5vZGUgbnVtYmVycyBhcyB0aGV5IGFyZW4ndCByZWxpYWJseSBtYWludGFpbmVk
IGJ5IHRoZSBWRlMgbGF5ZXIuDQo+ID4gDQo+IA0KPiBMaWtlIENocmlzdG9waCBzYWlkLCB0aGUg
a2VybmVsIGRvZXNuJ3QgY2FyZSBtdWNoIGFib3V0IGlub2RlDQo+IG51bWJlcnMuDQo+IA0KPiBQ
ZW9wbGUgY2FyZSBhYm91dCB0aGVtIHRob3VnaCwgYW5kIHNvbWV0aW1lcyB3ZSBoYXZlIHRoaW5n
cyBpbiB0aGUNCj4ga2VybmVsIHRoYXQgcmVwb3J0IHRoZW0gaW4gc29tZSBmYXNoaW9uICh0cmFj
ZXBvaW50cywgcHJvY2ZpbGVzLA0KPiBhdWRpdA0KPiBldmVudHMsIGV0Yy4pLiBIYXZpbmcgdGhv
c2UgbWF0Y2ggd2hhdCB0aGUgdXNlcmxhbmQgc3RhdCgpIHN0X2lubw0KPiBmaWVsZA0KPiB0ZWxs
cyB5b3UgaXMgaWRlYWwsIGFuZCBmb3IgdGhlIG1vc3QgcGFydCB0aGF0J3MgdGhlIHdheSBpdCB3
b3Jrcy4NCj4gDQo+IFRoZSBtYWluIGV4Y2VwdGlvbiBpcyB3aGVuIHBlb3BsZSB1c2UgMzItYml0
IGludGVyZmFjZXMgKHNvbWV3aGF0DQo+IHJhcmUNCj4gdGhlc2UgZGF5cyksIG9yIHRoZXkgaGF2
ZSBhIDMyLWJpdCBrZXJuZWwgd2l0aCBhIGZpbGVzeXN0ZW0gdGhhdCBoYXMNCj4gYQ0KPiA2NC1i
aXQgaW5vZGUgbnVtYmVyIHNwYWNlIChORlMgYmVpbmcgb25lIG9mIHRob3NlKS4gVGhlIE5GUyBj
bGllbnQNCj4gaGFzDQo+IGJhc2ljYWxseSBoYWNrZWQgYXJvdW5kIHRoaXMgZm9yIHllYXJzIGJ5
IHRyYWNraW5nIGl0cyBvd24gZmlsZWlkDQo+IGZpZWxkDQo+IGluIGl0cyBpbm9kZS4gVGhhdCdz
IHJlYWxseSBhIHdhc3RlIHRob3VnaC4gVGhhdCBjb3VsZCBiZSBjb252ZXJ0ZWQNCj4gb3ZlciB0
byB1c2UgaV9pbm8gaW5zdGVhZCBpZiBpdCB3ZXJlIGFsd2F5cyB3aWRlIGVub3VnaC4NCj4gDQo+
IEl0J2QgYmUgYmV0dGVyIHRvIHN0b3Agd2l0aCB0aGVzZSBzb3J0IG9mIGhhY2tzIGFuZCBqdXN0
IGZpeCB0aGlzIHRoZQ0KPiByaWdodCB3YXkgb25jZSBhbmQgZm9yIGFsbCwgYnkgbWFraW5nIGlf
aW5vIDY0IGJpdHMgZXZlcnl3aGVyZS4NCg0KTm9wZS4NCg0KVGhhdCB3b24ndCBmaXggZ2xpYmMs
IHdoaWNoIGlzIHRoZSBtYWluIHByb2JsZW0gTkZTIGhhcyB0byB3b3JrIGFyb3VuZC4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

