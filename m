Return-Path: <linux-fsdevel+bounces-44792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6AA6CBC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 19:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094A0163B2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469C0230270;
	Sat, 22 Mar 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="HN6Cb8bN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020089.outbound.protection.outlook.com [52.101.171.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17D9443;
	Sat, 22 Mar 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742667826; cv=fail; b=d30eQ/Fs7IaoXF65aZDOVZ5+56uXJXwCQOwlFeIGNmklFqLy2Wr77vezptweCr/DjVlAHy9UAMxa0VH7FjsVfOYL5nxJtZp8K7KvqoiqsJWa5G+nfbL10cJSqKUmdsuix1amzbofrTVc57wmpxsZ2OfXud02AKjfoHcugxdiHVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742667826; c=relaxed/simple;
	bh=jVxC2nKX5ALLFeeqfJoyuuAplV0ySy7YujQvb4c998M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcAbXuZcyAxuDT/pcLk8X8R6znAgu6AIsxcrAsvpz1QRmKlBtnuwhFrsZvGvgjMUMtPHoCAXPE6TAl18GYGmKB3iHNOjq1UJCtZwM2IHkYFmLlZCbVnGbhB7KaaAu5xsQHW8WC/aLbqT81NaVkkoXJyS3TUpBjguxXJlhBEFb68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de; spf=pass smtp.mailfrom=cyberus-technology.de; dkim=pass (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b=HN6Cb8bN; arc=fail smtp.client-ip=52.101.171.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyberus-technology.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberus-technology.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLQckQlbrcFFxBfE5L/L58oHRS8rBP0rDkJUPQq4iaKDuHhi0cZh6JmcJfWh8klvLG2Zvhq2aE2QILVN+xpNL90NFyArzXYpfEiPFNLoRm7TnzfsiFq8HmS784ZPEUHaA4IQuiyHgkjVsguFU9dscw4S/v3Om+U0KJv/986wPYuwJcq9BYzChTKT2FT9+2vFi+rMZlDE89psc7Y8o4f2Ar+3gjUq4/LouQ43hmhz4eG8jYVIVfck1BHhw10YriPPU8PiTpH0f54eQApRHb0i1w5YyhG7DCJsuEtJhLW/cHE15Lls8y0OVKoETY3ApaTnnSWk3oXeaN5KE95ergr3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVxC2nKX5ALLFeeqfJoyuuAplV0ySy7YujQvb4c998M=;
 b=kBgqP3RFwgi8DLMNnTU1yiK7irq2L4cCDe+QYznxePxIADPHp9vQ92iPA4ahs9kqlesPHLYie8elUowhLg2pNukOW9lcl0I0kFkboEWASzk//5wWXnMo85jXOBFGi34v3WJSSks1abQdiJTzlKivBPYVsINNhgZC3wW7EWBiB/AdIqLgjw2wXQrOcbe40i1niua3asvw6RU5uIOsqp7h0iGY8sSYtaXXN5rWv9uUDKDkzIIviizYoD1ts/vdvStqToi9LvEqE0Ne8NhToc8cXEfH28sXCDD3RAszF8pb/SAu84l8MEDX0r+P+SIvkRzsBqWJoChd9d8/Uva7/MB12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyberus-technology.de; dmarc=pass action=none
 header.from=cyberus-technology.de; dkim=pass header.d=cyberus-technology.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberus-technology.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVxC2nKX5ALLFeeqfJoyuuAplV0ySy7YujQvb4c998M=;
 b=HN6Cb8bNC/i7kK6qfb5q6/YcB7LoaGpWlS7qv45GOM2N4LgIJqnNIDEDAKiAH6rXB0XlzEop4GxYN6HnPVSPKEBH0bTtNc27GzgLK1otQxP2v11ukGK/vyXsoHI9mxQjZ/zzSmQpKuO3UFRELyxe9ieqkK7JK8M/5DZUkbswuoJCTN7i3dyHNnHLbBC+caNm4mHCaDWbktnF71Mch1naHC4dnWzlwh/6mwAdvh4l5ALkawBbP+Rcpzny0YDJKY2Y0S20aLa2mHEIv0A+cAe0epICW6hxftfc/lrS+VFbT/dgK85XGOMGVzG8rYl1l8bvtkaHzLseXF4Hm7gWUupLQw==
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::7) by
 FR2P281MB1853.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Sat, 22 Mar 2025 18:23:40 +0000
Received: from FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423]) by FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bf0d:16fc:a18c:c423%3]) with mapi id 15.20.8534.040; Sat, 22 Mar 2025
 18:23:40 +0000
From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
To: "hch@lst.de" <hch@lst.de>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] initrd: resize /dev/ram as needed
Thread-Topic: [PATCH RFC] initrd: resize /dev/ram as needed
Thread-Index: AQHbmdDGHLetamW2LE+ET3Lq8ZYdkrN9CQ8AgAJyXwA=
Date: Sat, 22 Mar 2025 18:23:39 +0000
Message-ID:
 <4b6434f738cdf10b6622b3d4f0987e29b0175da4.camel@cyberus-technology.de>
References:
 <20250320-initrd-autoresize-v1-1-a9a5930205f8@cyberus-technology.de>
	 <20250321050146.GD1831@lst.de>
In-Reply-To: <20250321050146.GD1831@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyberus-technology.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2329:EE_|FR2P281MB1853:EE_
x-ms-office365-filtering-correlation-id: 8c1a3d77-f233-48f4-0b60-08dd696eab7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHZzak02QWJpUVhkZG5ENSt0OWwxc041VzZoclh1VmViVlFMaktybVlJYXEr?=
 =?utf-8?B?VFJtRnM0WlpuT1hBTytRY08rVmdhN1BQb2NISDNvNzJTa2NJRkRFRWhoUUdF?=
 =?utf-8?B?cVhINlNsYmxoVVQ4L2dQblVnWlhYZmo0UE82dzd6UmxKOWpvU3JhMGRzY0t1?=
 =?utf-8?B?U3JVSUtkTmtXM2JQYUFZUzJTcVJzUkFybWxoTVg1UGZmLzFRc0JOWkxIRmNa?=
 =?utf-8?B?VFZzeXg3TU84aEVuQi8wNUgrZjJkQUw5SVZQaVQ2VkZQNEZ0andTTGJ3REE4?=
 =?utf-8?B?Snd6aXdPMW4rYjJNa2JHWEF6R3BQa0I1aEZUcjFWQ2F2WGRHSm8veHVmWndB?=
 =?utf-8?B?d0htN1Fld2hxSTlMMlVkajZ6cHJwY0s1bGdxeHdxNVNrWGdkMnFXQy9PYU9r?=
 =?utf-8?B?cXh6RXpZL1IrZ3JnQ2dEQldXbTRWbUZJKzg3c01YRXp5NkRCOVFsbjJQR04z?=
 =?utf-8?B?TXhkcFo4a2pnb0MvT0Q4SjhES2R5M3N5ZE0zYnkvMlBGc1JSWnlVb1JIWWp3?=
 =?utf-8?B?cTBLU2g2VDJVY3orOHhJaS9YTGVQZE9SWXc5QkpYa2VQNjMzUFAwZ1pqSmxV?=
 =?utf-8?B?QnJ5cDMvK0M3UjBlSjhpNE5RTU5sZE5PTGdCNmdiTitjYzBTQmQyRTEwYXNY?=
 =?utf-8?B?YlRqLzV2L2lyWVNNUjJjQlFCcWxZTjdnWlV6RnUwd2JWc1Y4dTVzeEZBRHVU?=
 =?utf-8?B?RzcrVy9SMWlFZXZjZVMxeEl4L3MxbTJ0UDIwYTE1bmZ2TEo0ZGh4SU92TDgr?=
 =?utf-8?B?LzdENjdWblFWclBXTEdVWW1tenlDL1hZOERDUU5ONG16ZEtJOTVRb3BiOGNn?=
 =?utf-8?B?bG5qZ25rTjMrMTFQVi8xOEFaWmdJNHhHSmRxTzNWS1paeU96Mzl6YzFpdkhS?=
 =?utf-8?B?OVUwb21jVmJHenVRTWtVS0UyTGN4aE0wUEtualo4dlVNMDdseUFqd1had25H?=
 =?utf-8?B?Y2VuSUJid0ZLajB1ZGFRTUpzcndhV1VEcHlmVlFCbGxPRjdvUXBYVmQyUmto?=
 =?utf-8?B?QisranJHUENJenMxdEJSLzhuTG43WjVrMytVM0IrbjZOdEJVdjdsNzdzaUI3?=
 =?utf-8?B?amRubmZiaXVNUm5XVVc4V2tldm5MRjBlSEptcmdwcEw2V3hqN3BhUWk5Q1dS?=
 =?utf-8?B?bVYwTHVNWTV5NDZRa1NpT1JnWDEybTNra0tMeHE3S0ZVR295YW9NekYybERC?=
 =?utf-8?B?aUZQTU1tR0pWT0hJcStubzlUSytndHpUV3ZNanlIS0psSXh5eEM4NklxYjdZ?=
 =?utf-8?B?VTdmLzZudUxWL2JUS0ZQYUNwN255a2ZTdEY2dTlmSm8xTEFmQldRT3F3ekZJ?=
 =?utf-8?B?b1gwcjVkZWVKZzdqMHpwZkRrYnFzd1B5RkpYTVVhMlczLzJvSDFsM2lFdUNY?=
 =?utf-8?B?T2tJYXlkSzFCZk9ZM0dVZlBiQWVsbUptQ0R6N1IvVkI0dWhjRnQxRzlEdlMw?=
 =?utf-8?B?aWlobXd3cU5Nb2JGdHFaZ3UvbE9CaHlLMDNnR3o5VnV3cmtPN0hyZHA1UGVn?=
 =?utf-8?B?YmR0RUx5MEFCaG14RUVsZkN2MDZpQ1h2dTcxSGQ4dGhlRzN0UU4wZ2tabHVX?=
 =?utf-8?B?U29hUWRUMFdqQzJRZGtGRGxwMFoxOHhpL0hKUktNNU1rNUFjQk9GQi8yYUZJ?=
 =?utf-8?B?aHNDSlpKSjcxZGFEbmFGRGE1cXNqcWZzY3NROHVpVlhFTmlDWUNYRTYrcUhr?=
 =?utf-8?B?MTdXR1E4aHQ0TW1VTXNkLytGMFVKak1xWHZsSlAwUU1PcXZjTkg2K05JMlNs?=
 =?utf-8?B?VjN3NUdGeXcwVG1MTktQSlpSQ1FTdk5jMVdhbHU0ZlZDSHFGdkorQ3FjRlRI?=
 =?utf-8?B?VWVZaHp0NTJKWHdtQ2RVaTRnT2gvcXFMWWRGYnVBak5ncnJndXArN1FFYnZs?=
 =?utf-8?B?Y0F1NzBVOTJoaGxtMXBKUDg5T01ZY1B5MytycEI5Y01lTVl2VUpGcHpTelVN?=
 =?utf-8?B?cjRzTFNtUTNaT1hyYmpxV1NYRk9YNEl2VVVhSlRtbG9tM1BlTHl0b3M1S1Er?=
 =?utf-8?B?ZmxmemZ0SjhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXFTVEx4czhGYzlDcFl3VDAvZ2NZU1VpWVcxUkoraXR6ZlZrYTEyOXhRTFZX?=
 =?utf-8?B?MTVvaWFSZEdMT1JOS2JDdkxJdlFwNDVETzQ4bFhOT1RLV3JzR2RlOEFSZ0FP?=
 =?utf-8?B?cmZSNE9lY3dTeUw4RUQ0Zm9QbWNnVGdVVFB0VERWdTUwbFNtYzZteEZTNE1a?=
 =?utf-8?B?N0UzOHVHdDE4UVlsdW5EcjNzbjlheUgxd2p5Mi8yU1lsWjg2R0xrRnZmaHVW?=
 =?utf-8?B?TmFDWHdQSkppYWpwUXFoLzhUNXJ6M2FhaE11SWZBL3dyKzVoYjYwU2tzZWlq?=
 =?utf-8?B?aUlCSnR0cDVVUVA4SzFrZjdqWCsrYUJsNWcveUxsRmpSenAwRkFQbkFQVVN2?=
 =?utf-8?B?YUMxZG81TDAyV3hiZ2FkRmlLYmFyWkV3T05jMkNVYys0UnFDcmc1a3o4Nk1l?=
 =?utf-8?B?Mjl0WG8vbFJuaE9pMGhSd3ZwSGNKVmNnNWV4ZzBxS2VENmxSdFlPZ2FFaVFQ?=
 =?utf-8?B?Y1AxcTRoYXRMbTZHUmVwanRpVWRPRldTNUZ0ejhZVU8zVjFUUXN3U0F5YkQz?=
 =?utf-8?B?Qjdtd0orT0t6MHpVRWVGUU85aE9UL1BISGowYlZVSGdCVFd5Q1Z2TjJRTG5N?=
 =?utf-8?B?dWE1NWlaUmhKMWhPbmtQNmZ6dVNCc05jSHgxUThpTUd2eVVDaWhJWjBBS1NW?=
 =?utf-8?B?S3B5bEdlUi9ySnRnTzVEbWFNcmEyRkcyR3k4NUhiQW1Ib0FxdkxSSXBkQTVj?=
 =?utf-8?B?VHNXVE5ybU8zQ0ZDeDBxSUVOeThJOTdLYkVqanZ4eFRreFFIb1o2aytWVEJB?=
 =?utf-8?B?b1dpdGprQWhkektqbUxoaW9lNWlINUVRUitIMm1aUHhLbE13ZjlqQ0tIK0Nm?=
 =?utf-8?B?VHI2YVBQK3hoTzJOK3hVMGFMRFd5aVA0aXhZMm92S2lkaVJoRjRhejh5amI2?=
 =?utf-8?B?c2prK1pKWDVRRzIrT3dPcUdLM2FvUG95SVh0SjJaWlZWdHNWRVkydU5tc1lW?=
 =?utf-8?B?WisrQ21iaGJJUW14WDVPZUFoSWUwaHIvWnRuVHZtQ0d4YmhNWmlxODNKSzZC?=
 =?utf-8?B?ZlVsTUJ3WHZrUlpYNGFkRW8xZXIwVjEzTFFVUTJjOTl5OHJXWVkweFB6T1pJ?=
 =?utf-8?B?TkkramZyQWZ1cG5LWEFpc1ROeE9wejlnWUd0ellPNWVZK04rYjdHTnV4REVi?=
 =?utf-8?B?N1VxTG5tcTQ1U3lmZVpNNENQb1AvVytsSURaYVZ4MXIrMUhVTVFtSFBpTEJm?=
 =?utf-8?B?NHRVSGZoMkRsMmZCcDVZQXg0RlNmTkJSZmh6Y3RsVHl0aTZMblRyVC9ZOEdZ?=
 =?utf-8?B?aVN0QW5DRUhBZmZLcFY0V3RFN3dnSSt4ZzU5dlY0cFFWSjBHQmdSd2lOSExM?=
 =?utf-8?B?M1ZhaDVDbk5vdmVaSDNkVjZkOGFXa0wrR1lRVHdqeDQwbm41S3RKTmp4K3dt?=
 =?utf-8?B?VUlHRGNDekprT0ZJSnY2Umk1Q3VtQ1BZS2g1OWphNkFJWEM1UWNtYzBuTkhz?=
 =?utf-8?B?N0FqQkJ1SkhOVFpXNnUwMUpUSm96L1Vkbkd6L3BhOEhmNDVtRmpucmJEeHBw?=
 =?utf-8?B?T1FCSFRSRHpPY3RqQnFiTkd6cE5xby9QZU12UGhpZGUwdU4rRlRBS3l5QkxL?=
 =?utf-8?B?UmZtbExxSGswK3AyQWlCMnFGdlFTN0ZTYmtPbENJRFcvcGdxK2JxcXdXOFJS?=
 =?utf-8?B?T1lsSmtFNzBnN2E4WFl4WlhGM21yZHJTYTNBTVJ0TlkzYWh2OU4xOXljTmpo?=
 =?utf-8?B?WnB0M2tUSEl4cXBYWDgvRklFQkxGZ29lREloUk56UDJrZkdqdDdSZUtNeXpD?=
 =?utf-8?B?WU43eENsQVpnT2FzMG93UDhleFJqc1FoTnkvakhZU3h5cVdTRGZNYU5qcDVF?=
 =?utf-8?B?TlBZZlNNSmlCTEt4SVZSd1A1RVJDdE9oVCtHL1Ivb2xtaDdzYno3VzNERWti?=
 =?utf-8?B?Z0xIc2tGS0JsaEVmWWRTc0R5RUptYjA4cFVXT2RwTGxaSVNkSlRMcnFPbHNa?=
 =?utf-8?B?dnBUb3VUTXJyWXplZ2dHL1VFU1UzSFloakEremFSdnZJdS8zc3RzUlk5WG5C?=
 =?utf-8?B?OXVMVmkrclA5ZUlvL0lSNEEyaUx6NXU3ZWFheFZ5ZXFGWUUzSEszRGk3enVn?=
 =?utf-8?B?NmhIUXlKbVROc09RRXRheFdMU3poT1JVeUpmMVlKTmVSN05aMHA2aXJFL3Bl?=
 =?utf-8?B?dFJoL0pwbnFvdHVhSGtQZ0ZtaVhHZ2UwOUtOb051Mi81dWpqNmpqbmtYa2U4?=
 =?utf-8?Q?D0hgn08dZFC2naTexlApYTJRrcr382+M7MFZwe5tXDjv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <682AE0ADC4A22C499704084F7062C985@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cyberus-technology.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2329.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a3d77-f233-48f4-0b60-08dd696eab7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2025 18:23:40.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4e0f4e0-9d68-4bd6-a95b-0cba36dbac2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaFmB/rIV+8Zra971iEL+cFODik2u2w4cHZImx944O+tL4kKakXtEPcaOReQSeRCBfDb35zjNezB4ysNddJTjPHdDsliQqtuM1NgYpc9VkF2b1ZCVt/gI5R+NZ2hLBX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1853

SGkgQ2hyaXN0b3BoLA0KDQpPbiBGcmksIDIwMjUtMDMtMjEgYXQgMDY6MDEgKzAxMDAsIENocmlz
dG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUaHUsIE1hciAyMCwgMjAyNSBhdCAwODo0NjoxNFBN
ICswMTAwLCBKdWxpYW4gU3RlY2tsaW5hIHZpYSBCNCBSZWxheSB3cm90ZToNCj4gPiBGcm9tOiBK
dWxpYW4gU3RlY2tsaW5hIDxqdWxpYW4uc3RlY2tsaW5hQGN5YmVydXMtdGVjaG5vbG9neS5kZT4N
Cj4gPiANCj4gPiBXaGVuIHRoZSBpbml0cmQgZG9lc24ndCBmaXQgaW50byB0aGUgUkFNIGRpc2ss
IHdlIGN1cnJlbnRseSBqdXN0IGRpZS4NCj4gPiBUaGlzIGlzIHVuZm9ydHVuYXRlLCBiZWNhdXNl
IHVzZXJzIGhhdmUgdG8gbWFudWFsbHkgY29uZmlndXJlIHRoZSBSQU0NCj4gPiBkaXNrIHNpemUg
Zm9yIG5vIGdvb2QgcmVhc29uLiBJdCBhbHNvIG1lYW5zIHRoYXQgdGhlIGtlcm5lbCBjb21tYW5k
DQo+ID4gbGluZSBuZWVkcyB0byBiZSBjaGFuZ2VkIGZvciBkaWZmZXJlbnQgaW5pdHJkcywgd2hp
Y2ggaXMgc29tZXRpbWVzDQo+ID4gY3VtYmVyc29tZS4NCj4gPiANCj4gPiBBdHRlbXB0IHJlc2l6
aW5nIC9kZXYvcmFtIHRvIGZpdCB0aGUgUkFNIGRpc2sgc2l6ZSBpbnN0ZWFkLiBUaGlzIG1ha2Vz
DQo+ID4gaW5pdHJkIGltYWdlcyB3b3JrIGEgYml0IG1vcmUgbGlrZSBpbml0cmFtZnMgaW1hZ2Vz
IGluIHRoYXQgdGhleSBqdXN0DQo+ID4gd29yay4NCj4gPiANCj4gPiBPZiBjb3Vyc2UsIHRoaXMg
b25seSB3b3JrcywgYmVjYXVzZSB3ZSBrbm93IHRoYXQgL2Rldi9yYW0gaXMgYSBSQU0NCj4gPiBk
aXNrIGFuZCB3ZSBjYW4gcmVzaXplIGl0IGZyZWVseS4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgSSd2
ZSB1c2VkIHRoZQ0KPiA+IGJsb2NrZGV2IEFQSXMgaGVyZSBpbiBhIHNhbmUgd2F5LiBJZiBub3Qs
IHBsZWFzZSBhZHZpc2UhDQo+IA0KPiBKdXN0IHVzZSBhbiBpbml0cmFtZnMgYW5kIGF2b2lkIGFs
bCB0aGVzZSBwcm9ibGVtcy4NCj4gDQoNCldlbGwsIGFzIEdhbyBYaWFuZyBwdXQgaXQgaW4gdGhl
IG90aGVyIG1haWw6IENQSU8gaXMgc29tZXdoYXQgaW5mbGV4aWJsZS4gU28NCmhlcmUgd2UgYXJl
LiA6KQ0KDQpUaGF0IGJlaW5nIHNhaWQsIEkgc2F3IHRoYXQgdGhlIFJBTSBkaXNrIGNvZGUgYWxs
b2NhdGVzIG1lbW9yeSBvbiBkZW1hbmQsIHNvDQp0aGVyZSBpcyBubyBkb3duc2l6ZSB0byBzZXQg
dGhlIGRlZmF1bHQgc2l6ZSB0byAxRyBhbmQgbm90IGJvdGhlciB3aXRoIHJlc2l6aW5nDQppdC4g
UHJvYmxlbSBzb2x2ZWQhIFBhdGNoIG5vdCBuZWVkZWQuDQoNCkp1bGlhbg0K

