Return-Path: <linux-fsdevel+bounces-44413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB4A68644
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C9618971C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19C24FC1F;
	Wed, 19 Mar 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ih0aDDqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2041.outbound.protection.outlook.com [40.92.47.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84454E552;
	Wed, 19 Mar 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371176; cv=fail; b=MnRCVMt8708YEfT2V1OmY7/BcWMOr0qXauARnFvTqceEnc7SbBpM4/jtt1Roz/7aYfUenL4RFznWH7WxnF6YKlwP2jdVEgl0gyPQlh9PeS1GY9ZIRbCOCEvdhw2YGDMhAizclD5l2I+luW1gUxnfE2wgF5KD4L9bUgj9BmULMo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371176; c=relaxed/simple;
	bh=a7kuoficIJ3865IH73sEwgofOLfmEZta+pBu2LFLKbY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ix3+SjhQOw2t7JEDylXLE/4CTs72mNBaT4/7WG/LQc7kDz6Wui4W2+KOcCRTBV5uf0f5+8uTJFoKuTGHdgdGYOHWv0Mb6WtIVEHbh/7MzfxfFHv5LNMaPrRwLdaRxtIV6V1ALV/cXOfmHmMjVZFXiCX61yt50DufAadvA9561jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ih0aDDqk; arc=fail smtp.client-ip=40.92.47.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJL45rnsGF/omSMcSi5o1UHtv+eiKYnVCYsy60YWLJaYYKvhbr0uqmmwruJwMIp/loDKo3tpmywXI2+EqmjqM4TzUEwn3BYZQWQqj4Uwcxjp//ulz6CHi3Pslp0+6/E41dcFY5FCCXTlhhghNwll4We7yFrqWmIDUwYTT429BZ9MFVjadW7VVCnTF5r31uuQaD1eat3RWXehnKEXLjbSjFLn9RdYJ7YM0N5/J+6UJ48ni/0IJS7K3sHXFutbD3J7K8xVQPLjL4AS86G+K6BJbSj4V+eoZ73x6Ja5jG26p2K7yHVPV6WZsf8ouH/nBxZVoSa1+IZYid/2oJqG0dLotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk0gEpTEz1WDzuHd3XUENiLjSe7yZ8nolTwGj49VSF8=;
 b=Kbrz+cvTeClkCGfzDDXuXUlKZrGw3YB5ujIUtAuzcnfnaGR/rsnHLN8T6b2y6gz08tYxBsBxh5s1PEAiqqQTFcZDopcrhZwR43seuTBW6038yKpmjwkw8ljkdd9OBPzdUh/g9RZyIDxWreg4Y0Mdc3C/6XQkPAUQpigCzzF9z+fOPThrrBIazdZ6BO+AL2R90iepW/OsRgdV8/fwDcDaKz75mCFBUiBVpd6GNRdD5Lyu4TQlvl/8CmkIztWlVTj61Rz3MtJS1hAYWqyOoAlqSfMf1uV+mRZLb1IHSuzWcFRIW+WLc+NdXCz9EnJ85WR+xiFjvwLdoYcvUG4axS/7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk0gEpTEz1WDzuHd3XUENiLjSe7yZ8nolTwGj49VSF8=;
 b=ih0aDDqkq94DbXEpJulPBqW7vVRgL6/RdZg72QNymzeZw0+raWEvWvBPAUtB89UqldBK/kZBcGlFgc66BKITr5jZ2XxL19AFenSpKL/SBCEXviYceVTodV375vv97aYNGRkEBQh4rNm6HeRHocZtxhSTpKVFr9MJWhEucmAOWnB8YmEB/c9P81e79WcLCiORYnhth+IpS4vRW9onc92bihMO2xhKqzzUvVfieNDsqpGoN7fEzhccMNSc01W2I8hfEo2DeISQrdHX1FbGSXSS0alUJ3nmGj2N7U6mqiB5SqXQ1s+s78i4wpQNpV2T8eb0w8A+AJUwhb+A+9bDKhXEvg==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 07:59:31 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 07:59:31 +0000
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, David Disseldorp <ddiss@suse.de>
CC: "jsperbeck@google.com" <jsperbeck@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"wufan@linux.microsoft.com" <wufan@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Topic: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Thread-Index: AQHbmKTYpUwqyBSJDU6CvzaMkV07IQ==
Date: Wed, 19 Mar 2025 07:59:31 +0000
Message-ID:
 <BYAPR12MB32059646E1837EC3EDB678B9D5D92@BYAPR12MB3205.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|MN0PR12MB5857:EE_
x-ms-office365-filtering-correlation-id: ab96285e-6e2b-43ff-d33a-08dd66bbfb38
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|15030799003|19110799003|15080799006|440099028|3412199025|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cz85IePy8rA8v8aM2QChc5ZX43gMDOr958KLLHoha4uw07uZGK8k7yxDQL?=
 =?iso-8859-1?Q?/jiYxZqrmxBKjwZ3FyfVqxpJMEeBgKOafDhIPf/N7W06NDPhjVyq3J0oSD?=
 =?iso-8859-1?Q?ylivBnIu86prmEJPukV1JPBTmZSstSSSqeyPwSVPtI2hFGyywTDZXDPe4L?=
 =?iso-8859-1?Q?qo4q084S0ERWhbl0/gmD67EBV0dh8sxJMygD9CrUG4FlAO0KABsomSlKR2?=
 =?iso-8859-1?Q?ZtQvbqX0/AJ87G8JUXYcznWg7puKdc+SenKe4cX91roaMaLghQHTgisBEF?=
 =?iso-8859-1?Q?w1LJfEE18j5CgCFMHt41B9pleoZYInszLlrEVq3cOxk5UwgjSYjZbJ3b9E?=
 =?iso-8859-1?Q?FIqLSHHhu+3uPtuetPtZMfF2PWOfG7NbXz7TmCikzK7JNinZOTFtc8lDnZ?=
 =?iso-8859-1?Q?fX624ExmgIvtw4R0oz3GHs9MsHvYrj0mBBeEBFMogLVLW423gn1OgXWZfw?=
 =?iso-8859-1?Q?g0F8+t2D8U0dz6fSinNxth8NcV0Zr6s8Qw7ICEIOM8FwjiknNlO+84AFZP?=
 =?iso-8859-1?Q?i4tU5vvq7gg+qVXfD+4PCeBj0BVK5XECx2LIHRoSjXm9BnIhqzFYCYqtqW?=
 =?iso-8859-1?Q?VgMwo3IOQZ9bfzt5fGLa0ic9pi2LVJj14n3RXjtCIbKVY6gQ8oKDPMzW5I?=
 =?iso-8859-1?Q?R9igwGHs50i0ktd+V/S6OwgFQKGsiouzWN3OZ46Hs72ec1bm8y/h4X5fRb?=
 =?iso-8859-1?Q?PYxZjCPovtZNvqxD/VNDDixjyJvpIEqIthVVv6EE+cb3jxdZ2O/5OnOyib?=
 =?iso-8859-1?Q?pROBG+NLQHa+qekAbAJMq2mHfiqi0InBu5le/uXBQhUjIHyh4etOJMyHnd?=
 =?iso-8859-1?Q?E+DH6bT+t9GB2iCuHGrf/TN/wyB+y/Ezc/kPy8hLbrR+zFceseVHTx8ijm?=
 =?iso-8859-1?Q?4GXGXOThVjFCryUJn/ehaeULWbWc0GD5Hiyn22vZmzmfUU6cWHCjvXbBiQ?=
 =?iso-8859-1?Q?tLo2IexKekf07vLIZnzmDumkiwkGHCp3U1cNxN/q3reyhC/YbZHiFyxVhK?=
 =?iso-8859-1?Q?NA49z9vgJRlEHyM08GabeXQKPiuUxoDjlbCG75TgvGowo6cly7paBP91bT?=
 =?iso-8859-1?Q?gJ6J8OwoFML+9asLwbOs0IgHCDhf1IojvdvKx+X30ZorE/RuK6XoUiSP0/?=
 =?iso-8859-1?Q?TG4bzd0DJ4uMMbof9jAz4rIZLNhudMbZoHmIvyyHnNprFMdBbn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LkzAYiy8zac56eLn3DBwJfZPm1PqwS5PboZUA6Ltf/j0rc7s3HM0WyWg9W?=
 =?iso-8859-1?Q?Z3eQpDLavyJ+sZrss/R5vUNzcwStZWCt0fAt/9hsaDeei5voTSHP5Y6iin?=
 =?iso-8859-1?Q?5DuevqFV1vO0S3ma1kCj3X5ZzEM0pGlQxVKEwGL9ZXSox/m3trz0djhHWZ?=
 =?iso-8859-1?Q?10LCyaYMN82Hzzn8mqxxwYbA4Ef3gvjzAMUphppaDTFIUYtwbP5PyqZRPN?=
 =?iso-8859-1?Q?AjsGcBpSmP+BTGTTGEZK2EiOK/rIefag3Ckj80YPcd5FDcx52V93flLvDY?=
 =?iso-8859-1?Q?IijDrjv4aj5Q09r4zkSdeU0P1q/9L9pQYrQM/m/xZMnGBabhiBYyS0DSWb?=
 =?iso-8859-1?Q?ZnPlYFqG6iTAg/f8RWFrV1PXYvISQMh6p0FezYif0U5pDOahLpuAZJR7qZ?=
 =?iso-8859-1?Q?UMCZomcARDag8Gn5N9FW1AR5S0l5M0vcE7Oe1GPpJSzyZ+jlShYU05Ww9L?=
 =?iso-8859-1?Q?UnIeXwEJK0brvziPxHM9jP/2JJmQSmCNCbVn4Q1agdTmAeOffOLaKzEODt?=
 =?iso-8859-1?Q?YYu69QHK5YZFBx+8kdos1DuXs+bw7piGAL9TeDa1+a7FdcbYcktE6LF3Vq?=
 =?iso-8859-1?Q?Sl1/W8wZQdFf2LsYBqgQi11S5d9HmQpF1CuqLkxQRut1VZeHo35W1tbGou?=
 =?iso-8859-1?Q?qGlA28naZdzn670h2JTWn4Q5vqIxnB2y6bIyzRIp97pU4T+Srf8NaiJ4O/?=
 =?iso-8859-1?Q?tttKSWtmwnQh5FCZREZsQsZMOL15f/218JjelpWA56AL7L1XNXmGRJk2Gc?=
 =?iso-8859-1?Q?gJP2dNEUEf1F5Qar0T+yIu4BXI2ogkeeV7sIu0sH5k7zgvO2P+mP98fWg/?=
 =?iso-8859-1?Q?AsTxrQJlrP7E/Oc55XjD1rKHnW+y8Xjwo3kE7+BLFDxAVvP5VyDdweoexP?=
 =?iso-8859-1?Q?e1F6y17WmMeR1OYrWqgGVpjpZ9XmcXl6F3dD75kXGIYVgIYNffyeX2HJdi?=
 =?iso-8859-1?Q?3yNPAk6t+9daJDYC5c2p7ko11U2ptJp1Ab1649ermARqU7SXlafONWDc25?=
 =?iso-8859-1?Q?qNnTOx23aVRYgxxT/n/v2403QXITHR+z5apMAd9G2Ac8mpyfhQkuMHtKao?=
 =?iso-8859-1?Q?yPNtr1ssvQ2Q2dgBSHIfki/td6QrOV4MEm0XotovE5cEyb5NxIh8dWfEkk?=
 =?iso-8859-1?Q?pHX8y0ITUNzm/eDMpK8IEPl77xj6uX3m/vWPhVAVceK2d0aSbqWsUqg6U7?=
 =?iso-8859-1?Q?jNh81S7uVJ3AnWlc6Tr2BloUv+WUUtl/ueAsgDM+qiiGbgSr0SjKppu2gy?=
 =?iso-8859-1?Q?XcIe3tm4TTHi+3rehf1FupABIyZJaAaqGSt8kEBRI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96285e-6e2b-43ff-d33a-08dd66bbfb38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 07:59:31.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

On Wednesday, March 19, 2025 03:01, Krzysztof Kozlowski  wrote:=0A=
> What is this header doing this? Use standard mailing list response=0A=
> style, not some copy-paste and then quote entire irrelevant context.=0A=
oh....sorry, My email client carries these contents...=0A=
I will be more careful in the future. Apologies for the disruption to the=
=0A=
email thread.=0A=
=0A=
Thanks,=0A=
Stephen=

