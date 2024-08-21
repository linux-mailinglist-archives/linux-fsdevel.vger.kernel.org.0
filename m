Return-Path: <linux-fsdevel+bounces-26429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899AD959360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 05:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AE21F23CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40489158860;
	Wed, 21 Aug 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NKPaduCa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CED1803E;
	Wed, 21 Aug 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724211835; cv=fail; b=LGi5EOoqOfc7Q9q3hUy6c0qiIQSWl93fzYwjpdUSmRhadlvKGrGqq4PfiLnYkx9lZb2XfmPcwv6VmMVOXmSzX6t3HCBOemvBqyWai6dMvrzt7IYrsexty2JmrgnDJswZmRvGezBrI4yQfq4Pq01Ohsc/0DEFme+yXwUTXU9s7uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724211835; c=relaxed/simple;
	bh=HHlky/U0c5mjSAUe4C5TPXOeZNfyOfMpx7FO8R21+HA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HnYye9ZTNBO//mwqL8il1JnOlgDc9INJK0W+oLyFeaDhb2Qux5UCrAI9mQrdZctjbkeCkQZ19eZLi6H3DNdLhOXLqUCwBGdsdInhryDcFfiAUlvfjNlEyjOLiTOBHW56FQlaWaOwrGrDZWCeajZ3IM6F29k/YwQDSI0XopNZZDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NKPaduCa; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KKtaXF018032;
	Tue, 20 Aug 2024 20:43:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=HHlky/U0c5mjSAUe4C5TPXOeZNfyOfMpx7FO8R21+HA
	=; b=NKPaduCaMXWSYnTlSLVPBzTaRW3p/q1BwGddaQNn6sCWt/jr9bV6QGYgdr5
	Md4XhClQfjkVPL9rrJ7U0RQfinEyqr9VaUnL+cRt77WX90HuSI7hqbKupJq2wxAY
	aGmmQ1K5uHxLy4yXwoAWnMBAyEO67k/xR7td7T5pAqHkHcEI9foiPdcJq/PczuDL
	Blsoz0q+U1L4yCNBulelf8CHsPdFVfLN+9EBmfL8BTGgBSo8AM7skYD8kpVGu7rh
	BlUrCobgJygTyXu0BKOEv05ZhuNTz/A4wT4+zpKiQh7lXvZ/ieM7BhTve7n1j/Gp
	HxrAxwX6ANCEhiQqLHzersSZT8A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 414uewvy2v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 20:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1jbEK1fnjyOpXT0w9PNRR8lcPKA068HBwwedde8tfMSBqXqlqo/7r/4q7M9Wjk6rUujG5Mp4YsafRsxHvR6LlR9e1wHeN8ZwMMIjSMhEAkqTAOCLqYxvcYZy9S5R0bbibYayN9qs3NhBFi9uC3Aq+8UY7JRYFBTE1dofblqnA0ynOW5YnX9CswtYElHm7c95V3Mv1+2H+avohfFRUC3RiO+CDBiKXIhbkSid18sXIKYTwYcx1/+VkgTzWCRJzCraSXbK2y+sqObFKEa3P2+ghTmnTB4hi7x1kSyGQmRj59ziXnaub8dhPOrqhyi8QrOqgnbqbZG8OMKjcU1p1ydRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHlky/U0c5mjSAUe4C5TPXOeZNfyOfMpx7FO8R21+HA=;
 b=UlEIqxK1YOWpykhwIcp6PM/Rq8r6OpxrV1u3dCMta+fWmTfnqCeJv7qH0sUJQ1tC1VCPUYnKQMRIVsVPAyVjlHytCtUuslF+6jrE4tEe4Ayw0JSsJULp4EmDuXE2TAkkIKua08q8AofsX+zzulaECaiWiIto03tnXcq5yKMuxq2Xh+pLKhPmzzfq9lMLescKioXbdBKNixh/PrqAUfGzMMgDMyBWc2mGMYVduMmcIZFXwmx158y+wGZBo7P8+KQdYf3k0eR8wjR9C/uIwIc0x+/GD4kD+R3kDAzdsU6e635bOToh2iGo3JEhZ//S+qUjgvJG0/btSWIZPrz0LnYgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY1PR15MB6152.namprd15.prod.outlook.com (2603:10b6:a03:522::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 03:43:48 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 03:43:48 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Song Liu <songliubraving@meta.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>, Song Liu
	<song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart
	<liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?=
	<gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgAAgpoCAAHu3AIABDvwAgABS9gCAADpCAIAAba+A
Date: Wed, 21 Aug 2024 03:43:48 +0000
Message-ID: <7A37AEE2-7DEA-4CC4-B0DB-6F6326BE6596@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net>
 <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
 <20240820.eeshaiz3Zae6@digikod.net>
 <1FFB2F15-EB60-4EAD-AEB0-6895D3E216C1@fb.com>
 <CAHC9VhQ3Sq_vOCo_XJ4hEo6fA8RvRn28UDaxwXAM52BAdCkUSg@mail.gmail.com>
In-Reply-To:
 <CAHC9VhQ3Sq_vOCo_XJ4hEo6fA8RvRn28UDaxwXAM52BAdCkUSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY1PR15MB6152:EE_
x-ms-office365-filtering-correlation-id: 4774d108-47f3-4cd7-f728-08dcc1937749
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0NYcFNtWFViRS9kcVBhclp2ckJBbTFVYldlVjZOd01FMWdxdzJNYytzVC9r?=
 =?utf-8?B?bWR6UVJCc1pZVy9KWnA5OGluUVR5VDVLK3pQbHRHWTc2Z1ZTQmdaV1RTWUpj?=
 =?utf-8?B?MXlMUWRGZHlsL3UvejUrZDBlb3I2L1FvN3pqOTNOMEtjY1ZDaHNEa2tORlBt?=
 =?utf-8?B?QXB0Sll0TU5vMnZyRnI0VzZXYi95T0J2b1hQdlY5THZmM1ZwWnlpVFQrdW1G?=
 =?utf-8?B?R3ZFRkIyYVY0ZnYzaG5nNVNocTJYK3ljSHVUL3lmdythelRpRTF6enpLN1Ix?=
 =?utf-8?B?WVlOZDlZY0JUdW9aRVdkdXZ5R3IvVU5Sc280aDVUSmFYd2ZUYlVLRi9obmZp?=
 =?utf-8?B?UG9ISEEzS0tPRXo3VHV5cFRYY0hCa1pxUGg0LzhXZXRSZkovdzVCL2pwM3M5?=
 =?utf-8?B?cmc2UDBERHpWNzlDU1RhK2psK1k2S1l4dTUxc2VOTVdhN1IrTjN1S1JKMm50?=
 =?utf-8?B?azBpa1h6THBxdjdzRWZHTGFnclBYa3h3NHkwSnhHNnBhN1Z5d0pmMzdGbWdH?=
 =?utf-8?B?SWlNUitreWtvM2FnMzJvcnRGTDdEaDM1ZXE0eXRJdFVHZUV5UmlVZDF4WWlk?=
 =?utf-8?B?ZHJuMThIU2pmWFo3Rm5NSVZ0QW5QWnJrK0FQei8xbnFBR3hQbGJIMkFMUUZt?=
 =?utf-8?B?ZXQvSS9WVFhVd0p1Q2cvTVFGTmRBYVVCRittL2NudHN0VG14R2RydU1lVnR3?=
 =?utf-8?B?dUhqMVpWYjR5bVVyRDErajhNWUwrM0ZXN2FmcHZ3R2N2NFRRSXBlZFVPV3NB?=
 =?utf-8?B?MlpIOWZ3Q0kvSWdzVDhCSjFiSmc2TUt6aitmZ1poaERsL1hYNmxXVXp4VGFQ?=
 =?utf-8?B?Q3BXc3lINE9iL01iQlYrTGwzTFZjMWx0RCtrVWRxeE5CM0NibVdqdHg4VnM3?=
 =?utf-8?B?dGsvdmw1cmZNdDZBNWpmV1UzdWhvSHFNVU8xWnMwYjlzQ05kUnpJa3czLzIy?=
 =?utf-8?B?SFdnd3lGOTRZcHhBQUdBNlZmWnA5WVRGc1J4VnRTbHZXSFBpckJySmR4OVZx?=
 =?utf-8?B?VDJJWkJIbjFjVmJHcm5jVlI2c2NESEhqREYzRCttR2ZZMTlMTnJmMmczUTNK?=
 =?utf-8?B?Z0w0VkFJaE5xaUo5Wnp1cUFKMWxySTQ1YXVRRnpCakQzRVRJSC9RNHl2U3J3?=
 =?utf-8?B?YTFNR0hDTXhYTW0rZXljZjAvK2ZkSWFIeWhwM0pDTmhEeTZUaXdpSFBMTGNU?=
 =?utf-8?B?WkFOMUFyc0NjVTR0NFR0NFdKajEwK0l6RGJ4TTFRaVY0emU5eU93d2h3aDlt?=
 =?utf-8?B?UHc1ZEYxTnJrczVkakdtMGRMTG0wY0hqMVRhVk4xeUFZS0Vib25BSWVxWUNE?=
 =?utf-8?B?aEFSTEpZZXBUYWZIRCthM0xNbmtDQkthazVBVzd1SWhjZUJMQ05oaklUclUz?=
 =?utf-8?B?RENFMUp2SHIyb3M5Tm0zbS81NVJ2a3BCK0tkLzdwWjB5NzhsU0JzMEhBNFJD?=
 =?utf-8?B?UVpSVFdrcThicE15QVhEN3ZVUEJOYXI4aWZKU2R0a2VqUHRLQk8vVXJENzFS?=
 =?utf-8?B?enpaU1p0MkJ5em42Ukl1VTBnaVBJSGJxQVdRbUN5T2doTVJxV2VNU1dsd2Rs?=
 =?utf-8?B?WlAxL0FOZnVQclQrWlpucUVDckNIMDZCeDZYUmZxNGZPS1I4dHMxR1FyVUNw?=
 =?utf-8?B?Q0NNUnNHQ2MzZGExcysrTDFsYWFrZmJQRE54RjBZcjlrbWluL3R5UC9BUFUz?=
 =?utf-8?B?MytGYnFUdEJwTnhoaktFQk45UDRkTHZUbUxjVzRLT0V1ZDYwbnlzR2FKV3RZ?=
 =?utf-8?B?ZXEvYzIrVkxram54K0xiekZQMDNzNTZMbVgyNis1U0VFVk1KQmRua3FLRzNE?=
 =?utf-8?B?ZDduV044OHlreExkbDdBcXVLV0RhY0ZIOVdJUUttQlZyVDhlT2luazFyYnEv?=
 =?utf-8?B?dWorbVNpN1FJTGVrM2pTcUUvOFprenR4bWdzL29IRTM3RUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0NPbWF1bW5maG8rQ0puMXhldTlxZEhEUVpTNmh5cmtiVFQ4Znc3VitDbDRs?=
 =?utf-8?B?RVNKaEE3WHFWMG1jdzR3QzJQME5CMUFBUEY2aTdYaHl0akU3bUxyYVdHWG1p?=
 =?utf-8?B?TGFucVdPdTZVY3Ryc2NxM1dVb3AwWmtxRXNuNmY2MXoyRkpQRTJqTWFnNzJN?=
 =?utf-8?B?MDdvbkNyTmNTZjRhdDY2cVNsOVR4djBYdjZuRmRJbUpLeVZhWDVEY09WSjZv?=
 =?utf-8?B?Z1pkZEpvRDVncHVTbUN1aktSbkxUQmMvVkRXblJqam9ya1Bja3RwUUZ5WVNO?=
 =?utf-8?B?MHloek81UEdBNWtMRkJwY0lkbFp5WHlKdGJLODlhMU1Lc1ZMVklQSU53OGwx?=
 =?utf-8?B?allxajU5NDhWQlRMdFYvYWVMeEJPNDIzSitNQmlYdmNhWGRzQkpuUUVQUkVy?=
 =?utf-8?B?aEUyL3l2S0x3bWcvc0lWUXhZWm1VaFJiU0dhQlVXaStkcHV0SVlEbmRJRXgy?=
 =?utf-8?B?Snk4bENaSjVuUUdaWDVWREhJSzhydXNpcTA2Uzl0MlB6emlKSWFNYkE3aDNE?=
 =?utf-8?B?TjBXbmRxdEY4NVUrTmtLaUEvK2doaERscU9ZUGhsNFF2UnVNQzdCRjBFVCtB?=
 =?utf-8?B?UUJCU1Vhc2lydjVVVVBHOWJ6MG8rTXJqMXJoSDRiTjJ3K1d5VkR1QU9ubW9I?=
 =?utf-8?B?NUpGRUtZdFZ5cFZkaUdEUis0d0d5N3NwamJtZnRCd0tRSnB0dmV2U09NWTdk?=
 =?utf-8?B?NlcySGVkc1lWWkV5N3VybC91Y1owR24ySm1DZklPaWNCRTVreDFIbXlzRDRD?=
 =?utf-8?B?SzV2QzN5UkNqRlpEOHFDZ0NyVXc0UFpubnhIMTl4M0w0cjV2bUtQTisyWDU1?=
 =?utf-8?B?ZGNXSldGb0I0NGl1a1hSZ1haMzRrR1B5cDdRUlA4NHlSU2t0bEVTWVVEazMy?=
 =?utf-8?B?aExBTmdXNDg0amswa3lETkRyYm8wL3ZoZkVnc2FzaU9HS2ZqTlVkZzR6c1Nj?=
 =?utf-8?B?N01vVThuVkNBeUltc3JiSlcycURqV0IzWXVQazdGL1hMcG9nWmwyMGtiRDAz?=
 =?utf-8?B?YnQybjhKTURFNXZlQWh2VFlPOVpscmRtdVhYbnMzUzFBc0lFazMrcU5WbjBU?=
 =?utf-8?B?NnZaY1JLQWVUUVUxZ1FBMVk5MFIxUEljRlRtcHVWRlpQYy9KM2tQTXBZcEdk?=
 =?utf-8?B?WWtBVGtmS0oycDkvTEZENko1bVVZYVVZZjhibVRtTlJJWGUxNzRNVDNHS2Ux?=
 =?utf-8?B?OUoxVmg0SGtXcVVGd0JkNmFtck5vd3Qvdk56RTErVkZwK2pTNS91Z1loWnR1?=
 =?utf-8?B?cXFlbkFkSkV0SzU3UXA3aDg4eEM0L0I4VXFCRlhlU0R2UU5DSCtqSlN0Z3JN?=
 =?utf-8?B?VTZ3dkE2T2p5WG01aHAvTlRBdzJidGdieGpPQU5MK0lnRUJ5bjIxR0JJKzNi?=
 =?utf-8?B?QXZ6bnlFQW92Ulh5b2dKMkJ4RlVTQzRnRXJNRFRUT0RzTE5menRLZ2pVVVJM?=
 =?utf-8?B?OUhEcEhFOWJVNnVGanlMOWpvM0xZaGZTRHhROUFsZE82cHo0MTBqQXNMbEN3?=
 =?utf-8?B?RzY5a3dqcjVveTB6Qi9EMGwwNGk1bXVvZlUwd2lYcmZGR3dZTktaU3ZZMnVU?=
 =?utf-8?B?cXhvTEhJL0YrV2lxM2RRV3BFQjFHejVXaWNCaTROZTR0OG8vYy9oT3RiWmNi?=
 =?utf-8?B?UGYrMWFoNXcyYzVITGorUHQrMnZlck5nMS80YTFoaFBhVFZIb2dUOC8rUDFS?=
 =?utf-8?B?YWFPUkhodUFpbXBMSGZNcUM1TkFrOGwwWHhJK2lXYnNTdGVMb2YyUUd0K2Ji?=
 =?utf-8?B?aHlzZnBnRi94RFVTK2x5UnhtQ2V1QVVwK3oxbXZ4YzMySURVU3Vid3lvSDdN?=
 =?utf-8?B?b3VrZVVCUmFyYkFUUEpzc1k4ZmhQQ3hJYktzWTRQTXZMN3VGL3NLVjcveTRF?=
 =?utf-8?B?VzQzUnhDZy9vTW4yV3J6WVZGMGJVbDViNHNwdDhqQUFKS1o0VW9VNThsdE5u?=
 =?utf-8?B?TVFYL2gzQ1ZvdmVIaGRHYzYvRTZ3TGZVRmJDTDlNT1VTcytoOGpwYm5reXVU?=
 =?utf-8?B?WlhCTlRXdmtHQjdoUnVKM3Bvbk5aNExOZVBTK3ZFSmNnbzBRekpTUkhqOVVU?=
 =?utf-8?B?MEhYUHdZdmw3K3NqNSs3R2Q4ZDE1VjhCSlZtbnUzaXBWbmtJZyt1V1kxZGdz?=
 =?utf-8?B?NnZoVytPTVpCUTZVdnp6L3hsYVBNSUQ5VDREbzlZRDYvaitNTlhXWW9LZVcy?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E8D0DE001431C44A13108EB53D15309@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4774d108-47f3-4cd7-f728-08dcc1937749
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 03:43:48.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfkzgQi43Txsj1yj+Tf152zqfujD4+pC1iSwLc3t2ZxyZ1wdKDEx94DZ4+J+J/bAWe2K2J8Bh/1Z2Up3aCdUkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6152
X-Proofpoint-GUID: lJ0qKoTL-jKZN2tJWRA2PAqTXcgXq0Nl
X-Proofpoint-ORIG-GUID: lJ0qKoTL-jKZN2tJWRA2PAqTXcgXq0Nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_03,2024-08-19_03,2024-05-17_01

DQoNCj4gT24gQXVnIDIwLCAyMDI0LCBhdCAyOjEx4oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBBdWcgMjAsIDIwMjQgYXQgMTo0M+KA
r1BNIFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+Pj4gT24gQXVn
IDIwLCAyMDI0LCBhdCA1OjQ14oCvQU0sIE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5l
dD4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+Pj4gV2hhdCBhYm91dCBhZGRpbmcgQlBGIGhvb2tz
IHRvIExhbmRsb2NrPyAgVXNlciBzcGFjZSBjb3VsZCBjcmVhdGUNCj4+PiBMYW5kbG9jayBzYW5k
Ym94ZXMgdGhhdCB3b3VsZCBkZWxlZ2F0ZSB0aGUgZGVuaWFscyB0byBhIEJQRiBwcm9ncmFtLA0K
Pj4+IHdoaWNoIGNvdWxkIHRoZW4gYWxzbyBhbGxvdyBzdWNoIGFjY2VzcywgYnV0IHdpdGhvdXQg
ZGlyZWN0bHkgaGFuZGxpbmcNCj4+PiBub3IgcmVpbXBsZW1lbnRpbmcgZmlsZXN5c3RlbSBwYXRo
IHdhbGtzLiAgVGhlIExhbmRsb2NrIHVzZXIgc3BhY2UgQUJJDQo+Pj4gY2hhbmdlcyB3b3VsZCBt
YWlubHkgYmUgYSBuZXcgbGFuZGxvY2tfcnVsZXNldF9hdHRyIGZpZWxkIHRvIGV4cGxpY2l0bHkN
Cj4+PiBhc2sgZm9yIGEgKHN5c3RlbS13aWRlKSBCUEYgcHJvZ3JhbSB0byBoYW5kbGUgYWNjZXNz
IHJlcXVlc3RzIGlmIG5vDQo+Pj4gTGFuZGxvY2sgcnVsZSBhbGxvdyB0aGVtLiAgV2UgY291bGQg
YWxzbyB0aWUgYSBCUEYgZGF0YSAoaS5lLiBibG9iKSB0bw0KPj4+IExhbmRsb2NrIGRvbWFpbnMg
Zm9yIGNvbnNpc3RlbnQgc2FuZGJveCBtYW5hZ2VtZW50LiAgT25lIG9mIHRoZQ0KPj4+IGFkdmFu
dGFnZSBvZiB0aGlzIGFwcHJvYWNoIGlzIHRvIG9ubHkgcnVuIHJlbGF0ZWQgQlBGIHByb2dyYW1z
IGlmIHRoZQ0KPj4+IHNhbmRib3ggcG9saWN5IHdvdWxkIGRlbnkgdGhlIHJlcXVlc3QuICBBbm90
aGVyIGFkdmFudGFnZSB3b3VsZCBiZSB0bw0KPj4+IGxldmVyYWdlIHRoZSBMYW5kbG9jayB1c2Vy
IHNwYWNlIGludGVyZmFjZSB0byBsZXQgYW55IHByb2dyYW0gcGFydGlhbGx5DQo+Pj4gZGVmaW5l
IGFuZCBleHRlbmQgdGhlaXIgc2VjdXJpdHkgcG9saWN5Lg0KPj4gDQo+PiBHaXZlbiB0aGVyZSBp
cyBCUEYgTFNNLCBJIGhhdmUgbmV2ZXIgdGhvdWdodCBhYm91dCBhZGRpbmcgQlBGIGhvb2tzIHRv
DQo+PiBMYW5kbG9jayBvciBvdGhlciBMU01zLiBJIHBlcnNvbmFsbHkgd291bGQgcHJlZmVyIHRv
IGhhdmUgYSBjb21tb24gQVBJDQo+PiB0byB3YWxrIHRoZSBwYXRoLCBtYXliZSBzb21ldGhpbmcg
bGlrZSB2bWFfaXRlcmF0b3IuIEJ1dCBJIG5lZWQgdG8gcmVhZA0KPj4gbW9yZSBjb2RlIHRvIHVu
ZGVyc3RhbmQgd2hldGhlciB0aGlzIG1ha2VzIHNlbnNlPw0KPiANCj4gSnVzdCBzbyB0aGVyZSBp
c24ndCBhbnkgY29uZnVzaW9uLCBJIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgZXZlcnlvbmUNCj4g
aXMgY2xlYXIgdGhhdCAiYWRkaW5nIEJQRiBob29rcyB0byBMYW5kbG9jayIgc2hvdWxkIG1lYW4g
ImFkZCBhIG5ldw0KPiBMYW5kbG9jayBzcGVjaWZpYyBCUEYgaG9vayBpbnNpZGUgTGFuZGxvY2si
IGFuZCBub3QgInJldXNlIGV4aXN0aW5nDQo+IEJQRiBMU00gaG9va3MgaW5zaWRlIExhbmRsb2Nr
Ii4NCg0KSSB0aGluayB3ZSBhcmUgb24gdGhlIHNhbWUgcGFnZS4gTXkgdW5kZXJzdGFuZGluZyBv
ZiBNaWNrYcOrbCdzIGlkZWEgaXMNCnRvIGFkZCBzb21lIGJyYW5kIG5ldyBob29rcyB0byBMYW5k
bG9jayBjb2RlLCBzbyB0aGF0IExhbmRsb2NrIGNhbg0KdXNlIEJQRiBwcm9ncmFtIHRvIG1ha2Ug
c29tZSBkZWNpc2lvbnMuIA0KDQpUaGFua3MsDQpTb25nDQoNCg==

