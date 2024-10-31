Return-Path: <linux-fsdevel+bounces-33313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3C9B7240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 02:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454251F21795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076877112;
	Thu, 31 Oct 2024 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="de3e5V8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C4881E;
	Thu, 31 Oct 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339537; cv=fail; b=ajuvWUBd12CE8zj1vpJk16EDc06Z5RU7fArKZ26kfAB8A1QTSSlG0Psfs3xnfZEwCBdgZ0VLEcBtFVosYunTXBi+7yMowGWpq0AMpRlhmALO1pKk/OqvhOZ1jvrroantZ9CUYU5GwJpIypYZ1gDT7DxIx3EaEsvZbkmqLmDPQUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339537; c=relaxed/simple;
	bh=iRjGWuOsls1mO/QYIQVwcvBO8x8vosPl721AyWeuKoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4ZahJke9EO93AmqjPDf8416o12aSZAVLP8bycwjG202eeSmybzNbW/ZqHYdkmcYLL6PEddeNXZpE/EM+Z5tnNRhO21jy/68SjvXvivbj32aUEWvFXfEvCXSoZ6C9RLuUh+1HzzqftaJrm81ErWyGBfJhk1ZlCcNGaWAJyUixjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=de3e5V8s; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49UNDNdg027699;
	Wed, 30 Oct 2024 18:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=iRjGWuOsls1mO/QYIQVwcvBO8x8vosPl721AyWeuKoA=; b=
	de3e5V8str73lVds6aJyvmqgy6Rr65vOMkYjSXwTUBkqZlTNSio08yYGPAKLooX5
	PPDQEcMIz5SMc9okh5R2tNEEnqqLeLp0x9w6BwEd3y2O4C+WvhT5sot9S8/SbU1x
	7uh55ayxKZEUyL8a7QGEryJkJmfx8ADDKnYvM3aKvQ+Ousf6HEl9lGd/XUDKqAuU
	+YK/QAkcLVK+AJNuvLvuYBPwQsTPfZuh9iUDs2H5oC6FNvIWmwviJowjNqNFRmrm
	TBwU5ePwzIVPwSOLDgkSwCYCxFL0mibvpbRnmaBZuqwn6bv42JQMb0OwmPvqra26
	rNQSJJDc5Nj4AteY4bogLg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by m0001303.ppops.net (PPS) with ESMTPS id 42kx9f8u18-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 18:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9RjWAEk1Cef3OIfOfJTQayKWjhKUhmCaVZvrzvELnMaoFDCnjnJetezBUAjly9g6fukTsaCNoBGgMRum1V2QdgywHEDthnogdVqednQAPweY9K8Uq4Aort1XQqGfwQlHsc3ryGOzOoJJt1pmJGsw2YtNSslil1PRtZZ3O9qgW/w0JP4Vb4MXUneSb43TpbWk6i/Yjmtgwu0p19xm2KaI4wxU2XpG6lY3X1AsMPbwkPtTkByaHRJV0zlJHqt9drtToZN2VEKYQQrY/rbWnY1y3GpUb4B5+kj8aUPkiMdKLj4hsV6hhReq2lI2r+CFI04EHmeLEo/7fNc0w6bkCDq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRjGWuOsls1mO/QYIQVwcvBO8x8vosPl721AyWeuKoA=;
 b=aTUGs+725rcS4PKJiJuAZ6Z5nE9OBlVkhUhauzX+RAWkXhLUFrQ2pnK1+5SkusZK73OUVdeYV+uTdcbUggp1XBFh1iyMOqLfyAWE9WpcdUySr9HcjYVnZ5gIcDcCkM7/zL6jBUUzesPj9JU1STrzYYNqgsanZut0E1m2K5rPH2jM7fX4UFM43PBkIGeJ4UUvZqH8s/KHTXgUlvl5Hb+kHbf9zxRvkfi+G4OHmAFZ30HYO5rT0pGfX6LphWueVRCNj6b/2KMw15JhEClPoxGVAGNqy10AyUkOw9Ml5/lbrKKT63/on6Gn733SSeqM5zkEKYYK50HZK5rDbI4gDOvW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5660.namprd15.prod.outlook.com (2603:10b6:510:287::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 01:52:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8093.025; Thu, 31 Oct 2024
 01:52:10 +0000
From: Song Liu <songliubraving@meta.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index: AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKfQ4eAgAB824CAAEEOAIAAGNGA
Date: Thu, 31 Oct 2024 01:52:09 +0000
Message-ID: <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
 <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
In-Reply-To: <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5660:EE_
x-ms-office365-filtering-correlation-id: 0bd78dbf-7cfa-4e6f-b112-08dcf94ea1fd
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHJxYkk0dEx0dE15clJVTkdmRlh2QlFWMEJTdEI3VHhWVExXbkdDdlVTR0l2?=
 =?utf-8?B?Y2hVbk9WclBDdFY3NXBtTDJlRk5uUDVnMWpCU2dJbkJYaU5iZU1WNTZyZjlq?=
 =?utf-8?B?ci9JbzdZaXZZZjh3RSt0cjBrckJxNDdZOUVYcUJQWEQvT1RSSWZHZlRTaHMz?=
 =?utf-8?B?akJKV3ErbTRpbWNTNjljZ1pRZkdnQXBybHVIalVSQWk3QkJlU1k2M0xibFFY?=
 =?utf-8?B?S1U1T1NSc2o0Wll2Y3lYZ1JXUm1SblFxSjFENlpPNjJ6L1VHQkZnNk8wWmVu?=
 =?utf-8?B?YS9tZEl0Vm9uV0dOd0I2R3NacTcra3lYcS9tNEZveWVTaWUzM1QzTmY3VVN3?=
 =?utf-8?B?cE5vNVRLaVlkUERRQ3ZMSzdtRWhISEpmZ3dVWTNRaURmWGtKOGpnd3F5Y255?=
 =?utf-8?B?K2lvUisrK3k5ejF0V01jdVhxZ3RkUHRLR1BkcEh5Zm5ZVVNDLzlrZ2dXaFdx?=
 =?utf-8?B?OCtOSmsrU0paK1JEUVBJWVB6cURjQm04Q1ZiVktOMnhta25PYWtTOXpDckxu?=
 =?utf-8?B?dTNUVThOTEFQWldyME12MXF2TXBxM2FEd0xSR2ZWUHhyWHp5WHA1NzhxY2tX?=
 =?utf-8?B?OFAxT1B2MGJpRlAyV2RjN1M1cjNGcU0wNGZ1Q1VOK1pJZ3VvYktheTVmbWIv?=
 =?utf-8?B?ekp2dmVNTmNQSEgvaWdKMUFvajZPYkpUMlpvMzFIZ1phWWNEYjNzSXBNb1VQ?=
 =?utf-8?B?ckFpOVFwN2tZZ3dIVlRjS3VOZzVBdDlhT2VhelJUZDJYdW83ajFkR3VoOVBn?=
 =?utf-8?B?VFJ0dklEWHRKN3FLcS9mZms2bWU5WXN3SEkvS1VSUUtWY0lFUFMxSXJ2Sm0w?=
 =?utf-8?B?cE9wUDBYTEQ5RXdDYjBhR0xGTThDUUxBTk5PVGlNbEJ1RzhBVW1NeDl3RGpX?=
 =?utf-8?B?RkRNVEpoR3lBQjRhYjhjbnkvU0w2Vm42ejN0Y1ZMR0JRb2RXMTB1VFg0aGpJ?=
 =?utf-8?B?eDRPVk1LZGt5ejI3WURZQittMXFHNHJNMmRteERobDRrQTFhN0FpVFZjaFBv?=
 =?utf-8?B?cndqSVhXQ1h0dnRwT2k5V0FUV3VUdDI3NUFjMi9hbmpuaU8xVnp3UndFdi9M?=
 =?utf-8?B?aHMvVGczeFJHNDI2Rys3cTIxUmxYMXdaTUxkbDZ2WU5OY1BMZTBjWCtyZmJV?=
 =?utf-8?B?NzIxQVNWeCtOa3FuZ3ZwVFdNdml2V0pYcUFxS1gzcHBLRHhDVzR4dVR3TkZv?=
 =?utf-8?B?YWhtL1NETlkwb1lkaGRYelA0NThLZ3hUM3dzVFUvcTNUak9DZEJtblpFTUNR?=
 =?utf-8?B?azNBNG4rckluQnp2QlFPdUFBQ1dVVE5iMjhkUTBKck9vaDhPSGIvRHplRm90?=
 =?utf-8?B?VDhjazZORWx1TkIwRWx0d1dISHNmemhHY0tKaGZvdjJpczZnckRrV21FTzli?=
 =?utf-8?B?c2lYbFBjdklyenZvbkg1ZzUwK0ZvaWp5UFBQTnBLbW5jUzRSYVcrVHM2eVdD?=
 =?utf-8?B?ZG1ycVdVZ0Zpdlo3ektubnJsdWxGTHY1U29zNUVMVWhJYURXZk5nNGZxVWdw?=
 =?utf-8?B?Z3I5NEtmVCtVV0JOdDU1MXlYMG5CRTk5SXNaN2kxeTBqc25Bd1ZJYU1wR0NE?=
 =?utf-8?B?UDZWZmdjS0cwamxTcHdhRVJ4cm8weFRYRnRMNGU1VEpXTlFmM2NxUmY5QVBM?=
 =?utf-8?B?bUl5YlVVV2piRWV0WnovdkIvN3l4QTRzZzMyUHNqcWtqb1ZVMjhpQmFIMEYz?=
 =?utf-8?B?dG8rSkdVNnFMdE82enQ3cmtydmI4YU1IVlIzVGZLQzhwbDBBVitISXV5eHl4?=
 =?utf-8?B?YVQySi9kZFA4V0s0Rk9lK1oyS09CdmE2b3hQbXFveElNWmhjekhYeVlFQnZX?=
 =?utf-8?Q?udPf3SvEnaPt3Jw5QVqaVU++Vpsdqj98x2RhE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnhoZHk4MjZzK0l2Q2V0Q0pRcmhJVVJ2dmFUZHo4MkgxTmhiQWpOdUR0Wm42?=
 =?utf-8?B?Q3NkazBhV2FxZ0hJc284aktMYkNHR0hmL0NxVHhSeVpaSjdBT0gwQlFCa2N5?=
 =?utf-8?B?TTZzajc2VU8wUURNd1d2VnhjRlhoemhURG5LenRWT09IejRsSVM1MENoNkN3?=
 =?utf-8?B?OXVsdG0ycXYzajFmMHl0eDV1SVBXTUxUZS9PTTU2dk9ib2s4MWcya1dlSGFL?=
 =?utf-8?B?ejRZQ1lmRm95RlU3S3oyMlpjMlptaUNZcTliSWV2LzIwU0JjZUVxc0h3Uk1T?=
 =?utf-8?B?d01IWkxkM3JYeVE3SDdXSzNxQkJwWExINzJzMDhISXlBcXZsaW5hdDY0U0hz?=
 =?utf-8?B?M2RjMDFWb0k3UVdUYWFQVDA1U2wycmlHRnB0bFQ3TXRtSDJTNEFwd1dtSlZx?=
 =?utf-8?B?aFQ1N0VJTFlZRE1EWFRJT045bkNXU0N5QlVqK0FPWmoxRzdma0g1ZjkzZ0Jw?=
 =?utf-8?B?U3NJQWFCeTYwa09xdCt6eHVPamhBcFByVjJLNENNL1FsR1BKK1pTWG5mR2c3?=
 =?utf-8?B?Y0x3SjNKajZ2bTdzdTU1aEFmRG5CNWJTNmoxUzBQK3hyYSs4anZsQWRuREtU?=
 =?utf-8?B?bVlHVzNpRmdoa1pBZ0ROQjAwREtYaXZZWGpBNlFXSGh3T2JrMlZzWGkwOXJk?=
 =?utf-8?B?QlJNZzVWck1JZmFCSjRoYzdJTFpKVXYzbTB2Y0w3ODVhbUFJMlpxamZiZFgx?=
 =?utf-8?B?dkZ6cHNpWG01eXhJWDFzNEM5Q1BrN3hYcS9JWEJuZStsR2ZjdmRDRlFwZjFk?=
 =?utf-8?B?ZGQxZS9aNWs0TVVYVmZrdVJhZVh4cHpZa0hTTkVLWG5XeiszUlJMaWZWVUt4?=
 =?utf-8?B?bDJzRkR1RzFmRW1HazVCOFBoOTFDRzdlbVd0R0R2b3cyaU9iTkxLRDhLcUxD?=
 =?utf-8?B?eEp4MGxzbjZQV2cxTjZESm5YdkRqWmZMRy9NVGJDVVpleDQrYUtEenU3cmhu?=
 =?utf-8?B?dCtuNU1ObUZ0S2VKeDhKaWo5eUQrSmpYZ0krOGNWRTZ6TUVpTXArQ0ZHWjRw?=
 =?utf-8?B?akcxMVFOejZDTmZudm1ScnZjTVVNRlNTZ0txaUY0aVJtN0RwYk5WUktNTmVz?=
 =?utf-8?B?ZEpDRFgxVHJ4RHE5ODZrc0tOYmRKV1loY0ZCUkZIKzBMbis3eFYrb0MvNTdq?=
 =?utf-8?B?d3N1OHIxRmlSZjlmZ0dVZXBSNmd6dmhBYUFFWVlEWFM2SzYvR3VWQ0lRelFE?=
 =?utf-8?B?b21maXVlTkU0aHBDUWxiRnJKUkgrNGFmWlh0WDZCbm1kaThEUy8zcHg4dkw3?=
 =?utf-8?B?ZFdWa1BLdmpWK1kxM1NITWpFTC9aUnNIUTdzZ3BYbkhSeTRORDByUHExV1Ju?=
 =?utf-8?B?US84bXI4TkpLbmJuMVFTWTgzcUFIeTZjSlRwbUxFQlpicExrNWNQbWRTZEhr?=
 =?utf-8?B?Z0UrT29ZZkpQOEdRamE4a3duaXVLVVdONEc2NG9abW1VRHNjcXJFemd1ME9Y?=
 =?utf-8?B?RWRIUG9rNE9Nck5Xajdaa2o2alcwSEFrMk90cE5uNXlBQjluc1JpY3NpL1RU?=
 =?utf-8?B?L3lDZHR3bkJUOFJ2QzJDSDNzSlB4VGYyMTRwS1RUY09VMWZGYkJNTTVma09Z?=
 =?utf-8?B?UUZWcjkvR0V5bk9JOU1nRTJUUUgzY2h5T1pFRjJQWlJYV1lrbTdycDNNc3pU?=
 =?utf-8?B?S2tCdDJmUTUwZ0ljSTljZEJCWjZKU0dZajJxUDZHZ2M2NXJubVNackRSOWFw?=
 =?utf-8?B?cG9OTFd3ek95M2wvWFZZdmY0ZDR5VXorM1lma28zWXN4dFZ1ZGxoZWNuUm5N?=
 =?utf-8?B?V291S3VuOWZJWC9jb0tQREdrMFlKSnZhT2FPSTc4YnVpTWpSdFJVWHV2YmlH?=
 =?utf-8?B?UW5nYjlPU3pZNzVaaDFpSnB2TzFxU2JLUXZSUHhFbTkxWVhNVFdxSDM4dXhi?=
 =?utf-8?B?OG9SMXpWREx0eFJZaU1Wb3VTUGUzYUlMWEt5RXZvZEJoOTJiR1daZFhTZXNn?=
 =?utf-8?B?WVdqV1pTcjByVDB2amQzemorbWlrS2xMSG9RR2lpL3pOVWRRcEJ5eGZwV0Vk?=
 =?utf-8?B?U3dqNExybHpFZDZxd3lUY3pNRHhFcjJ1ZTdaSDdGZVBSa3JvMlJDNDB4STkz?=
 =?utf-8?B?K0NldktDVjhXd3g2OFBSeDE2ZkcrQzNWbXRZUjVScW1PcnkxKzF2aTk2Zzl0?=
 =?utf-8?B?eXFhZkg5RWNVcU11MmI0K2kyb0x3bW5FWHE2cDF4RU9xZ2NPZmg2MWIrdDZu?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEF1729DC9D86541841DC2370E7E0E98@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd78dbf-7cfa-4e6f-b112-08dcf94ea1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 01:52:09.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnDe5CUMDTaJtCJu/d251pTGCayIttYCmaMRH4IWoTWE6HA7ytGo9hr86SvjR7RXVgL3L6cb6+PcPxffhKNgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5660
X-Proofpoint-GUID: qOsSIMXwYGOQ6LN851pKW7H-3GIe9cJo
X-Proofpoint-ORIG-GUID: qOsSIMXwYGOQ6LN851pKW7H-3GIe9cJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgSmVmZiwgDQoNCj4gT24gT2N0IDMwLCAyMDI0LCBhdCA1OjIz4oCvUE0sIEplZmYgTGF5dG9u
IDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiBJZiB0aGUgc3VidHJl
ZSBpcyBhbGwgaW4gdGhlIHNhbWUgZmlsZSBzeXN0ZW0sIHdlIGNhbiBhdHRhY2ggZmFub3RpZnkg
dG8gDQo+PiB0aGUgd2hvbGUgZmlsZSBzeXN0ZW0sIGFuZCB0aGVuIHVzZSBzb21lIGRnZXRfcGFy
ZW50KCkgYW5kIGZvbGxvd191cCgpIA0KPj4gdG8gd2FsayB1cCB0aGUgZGlyZWN0b3J5IHRyZWUg
aW4gdGhlIGZhc3RwYXRoIGhhbmRsZXIuIEhvd2V2ZXIsIGlmIHRoZXJlDQo+PiBhcmUgb3RoZXIg
bW91bnQgcG9pbnRzIGluIHRoZSBzdWJ0cmVlLCB3ZSB3aWxsIG5lZWQgbW9yZSBsb2dpYyB0byBo
YW5kbGUNCj4+IHRoZXNlIG1vdW50IHBvaW50cy4gDQo+PiANCj4gDQo+IE15IDIgY2VudHMuLi4N
Cj4gDQo+IEknZCBqdXN0IGNvbmZpbmUgaXQgdG8gYSBzaW5nbGUgdmZzbW91bnQuIElmIHlvdSB3
YW50IHRvIG1vbml0b3IgaW4NCj4gc2V2ZXJhbCBzdWJtb3VudHMsIHRoZW4geW91IG5lZWQgdG8g
YWRkIG5ldyBmYW5vdGlmeSB3YXRjaGVzLg0KPiANCj4gQWx0ZXJuYXRlbHksIG1heWJlIHRoZXJl
IGlzIHNvbWUgd2F5IHRvIGRlc2lnbmF0ZSB0aGF0IGFuIGVudGlyZQ0KPiB2ZnNtb3VudCBpcyBh
IGNoaWxkIG9mIGEgd2F0Y2hlZCAob3IgaWdub3JlZCkgZGlyZWN0b3J5Pw0KPiANCj4+IEBDaHJp
c3RpYW4sIEkgd291bGQgbGlrZSB0byBrbm93IHlvdXIgdGhvdWdodHMgb24gdGhpcyAod2Fsa2lu
ZyB1cCB0aGUgDQo+PiBkaXJlY3RvcnkgdHJlZSBpbiBmYW5vdGlmeSBmYXN0cGF0aCBoYW5kbGVy
KS4gSXQgY2FuIGJlIGV4cGVuc2l2ZSBmb3IgDQo+PiB2ZXJ5IHZlcnkgZGVlcCBzdWJ0cmVlLiAN
Cj4+IA0KPiANCj4gSSdtIG5vdCBDaHJpc3RpYW4sIGJ1dCBJJ2xsIG1ha2UgdGhlIGNhc2UgZm9y
IGl0LiBJdCdzIGJhc2ljYWxseSBhDQo+IGJ1bmNoIG9mIHBvaW50ZXIgY2hhc2luZy4gVGhhdCdz
IHByb2JhYmx5IG5vdCAiY2hlYXAiLCBidXQgaWYgeW91IGNhbg0KPiBkbyBpdCB1bmRlciBSQ1Ug
aXQgbWlnaHQgbm90IGJlIHRvbyBhd2Z1bC4gSXQgbWlnaHQgc3RpbGwgc3VjayB3aXRoDQo+IHJl
YWxseSBkZWVwIHBhdGhzLCBidXQgdGhpcyBpcyBhIHNhbXBsZSBtb2R1bGUuIEl0J3Mgbm90IGV4
cGVjdGVkIHRoYXQNCj4gZXZlcnlvbmUgd2lsbCB3YW50IHRvIHVzZSBpdCBhbnl3YXkuDQoNClRo
YW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIEkgd2lsbCB0cnkgdG8gZG8gaXQgdW5kZXIgUkNVLiAN
Cg0KPiANCj4+IEhvdyBzaG91bGQgd2UgcGFzcyBpbiB0aGUgc3VidHJlZT8gSSBndWVzcyB3ZSBj
YW4ganVzdCB1c2UgZnVsbCBwYXRoIGluDQo+PiBhIHN0cmluZyBhcyB0aGUgYXJndW1lbnQuDQo+
PiANCj4gDQo+IEknZCBzdGF5IGF3YXkgZnJvbSBzdHJpbmcgcGFyc2luZy4gSG93IGFib3V0IHRo
aXMgaW5zdGVhZD8NCj4gDQo+IEFsbG93IGEgcHJvY2VzcyB0byBvcGVuIGEgZGlyZWN0b3J5IGZk
LCBhbmQgdGhlbiBoYW5kIHRoYXQgZmQgdG8gYW4NCj4gZmFub3RpZnkgaW9jdGwgdGhhdCBzYXlz
IHRoYXQgeW91IHdhbnQgdG8gaWdub3JlIGV2ZXJ5dGhpbmcgdGhhdCBoYXMNCj4gdGhhdCBkaXJl
Y3RvcnkgYXMgYW4gYW5jZXN0b3IuIE9yLCBtYXliZSBtYWtlIGl0IHNvIHRoYXQgeW91IG9ubHkg
d2F0Y2gNCj4gZGVudHJpZXMgdGhhdCBoYXZlIHRoYXQgZGlyZWN0b3J5IGFzIGFuIGFuY2VzdG9y
PyBJJ20gbm90IHN1cmUgd2hhdA0KPiBtYWtlcyB0aGUgbW9zdCBzZW5zZS4NCg0KWWVzLCBkaXJl
Y3RvcnkgZmQgaXMgYW5vdGhlciBvcHRpb24uIEN1cnJlbnRseSwgdGhlICJhdHRhY2ggdG8gZ3Jv
dXAiDQpmdW5jdGlvbiBvbmx5IHRha2VzIGEgc3RyaW5nIGFzIGlucHV0LiBJIGd1ZXNzIGl0IG1h
a2VzIHNlbnNlIHRvIGFsbG93DQp0YWtpbmcgYSBmZCwgb3IgbWF5YmUgd2Ugc2hvdWxkIGFsbG93
IGFueSByYW5kb20gZm9ybWF0IChwYXNzIGluIGEgDQpwb2ludGVyIHRvIGEgc3RydWN0dXJlLiBM
ZXQgbWUgZ2l2ZSBpdCBhIHRyeS4gDQoNClRoYW5rcyBhZ2FpbiENCg0KU29uZw0KDQo+IA0KPiBU
aGVuLCB3aGVuIHlvdSBnZXQgYSBkZW50cnktYmFzZWQgZXZlbnQsIHlvdSBqdXN0IHdhbGsgdGhl
IGRfcGFyZW50DQo+IHBvaW50ZXJzIGJhY2sgdXAgdG8gdGhlIHJvb3Qgb2YgdGhlIHZmc21vdW50
LiBJZiBvbmUgb2YgdGhlbSBtYXRjaGVzDQo+IHRoZSBkZW50cnkgaW4geW91ciBmZCB0aGVuIHlv
dSdyZSBkb25lLiBJZiB5b3UgaGl0IHRoZSByb290IG9mIHRoZQ0KPiB2ZnNtb3VudCwgdGhlbiB5
b3UncmUgYWxzbyBkb25lIChhbmQga25vdyB0aGF0IGl0J3Mgbm90IGEgY2hpbGQgb2YgdGhhdA0K
PiBkZW50cnkpLg0KPiAtLSANCj4gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCg0K

