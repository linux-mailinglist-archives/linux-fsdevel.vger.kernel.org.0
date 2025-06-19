Return-Path: <linux-fsdevel+bounces-52244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93BAE0AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012C1189F871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BBD2367D8;
	Thu, 19 Jun 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="We7jS2Tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C25221F02;
	Thu, 19 Jun 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347212; cv=fail; b=IimVGqxHNIziwhy5oBhdJJoVdexLmBC464nOUDRRUiSDfYd3es83ZVdvzevLl113GTD/uynNDkOw4Kt378YedxN7sfXV3HbX2ENp7o1Rv2CfHQwceuZADaM37+3SwGX2QrzuYqZh5A/8VnBzAehOR8MeBDdDWYgZKUunBaRdhB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347212; c=relaxed/simple;
	bh=+cgwHUZvsEoabJRYKh9yilLVwO8YHc8sShOvCROw99g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNJRZGdIXcLlX1cGKzx2CccOeOQILl+qcm1bqdLciqzngtNppZUUDYrkuAJmQFODCFe4jYuh7UKTMuOTbrLXQ9ofW+4c8ufCleVoBEgPdVQ2zSgLIUAr2SHfMxLyvEYhH09AV1dNXuJswEDxlsFrzhZ80vNuFOB/OdJdq5w5G7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=We7jS2Tf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 55JA4cq8027390;
	Thu, 19 Jun 2025 08:33:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=+cgwHUZvsEoabJRYKh9yilLVwO8YHc8sShOvCROw99g=; b=
	We7jS2TfoLCOHM1PkEzAZHtvrDS6Vt7uWyOJIHHeMy4mzX9eOq5qTqCupFoqSLki
	PI1v2xcnPR3/2l//dM41FukDqml1nuOQTSfixLuLI3z2PUag7Czd05NiSgxO+29Z
	yq2NScST8xucplOuTnm+D94KWi0AoMGL92CirWlw1vycHwQd9FmTktAfalPoBqgY
	9urZaMIRQd9AE0pPHLeYxdMaZcOPV9c2F/FmgWv1YfrvdADTbN7PX8FivWCjFoJA
	0rKbggzSafgXGlfT9a/z4XLKEYJO1g5Cm3lcAiAD0AwDa/+I7D3e1L3t5gY0Pfnv
	DAgTXm7hgKZ8wyux8qJUFA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by m0001303.ppops.net (PPS) with ESMTPS id 47bf8x78rx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 08:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4mYhCKu7lCCkaRxdtK+Mpq8TuZgxZsb2bMl9dfpiZeM7cr8kCSYeuk94EY6v/grh/TBvtjEV44W8Djggm2L2Ae1ZDNxW38QY24KHlFf9Zae730XXqPkuXFA1niuHKMqfXBHGsa6ABNddyRAC78YOobQqIvFol2lW2QHObk4AoKpXqShjDQQe2eDLmSwvUXd5n4t7YAypmS2hu+SUuRHUCjdYML0/diwds/VWT1C3rUVwtC8A21azaYML0nvEGxrQNeV9+3parGKllFMBbrgGbBf5zaKvWjCyfoM1zOykgsyxCWIi9O5iQhBuDH07SeKXlAAaXOBFrSVenw7pQQRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cgwHUZvsEoabJRYKh9yilLVwO8YHc8sShOvCROw99g=;
 b=Yq4raHFYuXTiGwVMK3a1FExf02yDKi/8qcEk1NHkmoZ2RvAyyKqwQQZtcWqsaRaiLacF+PMRADBXTSTSLDbisZMmtYGvzEzA+IYrSFrAKhvntyYdjQwAiBFGoYpobVInBe5J/Sak2MpN5aG87GOt778/T0cufseH/xfXWSsP5tYCUVJ1RYKEnjMQ6JOQqkMcW6vIPe/vUmuCLOIWupDqCJZ1H6EwrlqfNj7riFIpZWxSE97Sz0nmv1csM2byxRsXXZ8ukt6qaz40Jj6F6hypWG+zUD1y6fIsdQ8y1Z1FXIkblRfYgvmSa+0cOEuFqmDm3glU8re3BwKc+VB8Y/qC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB5248.namprd15.prod.outlook.com (2603:10b6:a03:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 15:33:15 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:33:14 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <song@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Thread-Topic: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Thread-Index: AQHb4KoZzqRBZbDKukOs57XHxvbLErQKQOCAgABcsQA=
Date: Thu, 19 Jun 2025 15:33:14 +0000
Message-ID: <7B510F85-E964-43FF-A418-7A6CEF8B0308@meta.com>
References: <20250618233739.189106-1-song@kernel.org>
 <20250618233739.189106-2-song@kernel.org>
 <20250619-kaulquappen-absagen-27377e154bc0@brauner>
In-Reply-To: <20250619-kaulquappen-absagen-27377e154bc0@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB5248:EE_
x-ms-office365-filtering-correlation-id: 698f3daa-d87b-4c11-d0e5-08ddaf469b6d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1gvd1g4ZFQrMGlrd2VCOEpvS2JJQS9jemQ2aUt3VXRjeDliMEMyZDl6V1F4?=
 =?utf-8?B?bllkUnBLUTFTaTZOVzNuK0U3b2RZZVp0cjRDaGFoME9nUEFFUXhHMDk4Smxh?=
 =?utf-8?B?STdjU0NGZ3RxUzRQRlVZZERoZWI2cjhVQ0VpaEJzWUl6TytKN2Z5Wm85NXQ5?=
 =?utf-8?B?WG91dGh4a0FBcTVNaHpjM3VIcmtxalN2SmRWQnFLQlNjNkI3Q0hnbmFhN0M2?=
 =?utf-8?B?MnlOYVlEdjJHL0hZam9BNm9ENnVGa01ueFNtYnc4NXRZQ0xNT3YybjR5VkRa?=
 =?utf-8?B?aHcvOXdaZG5YL1NnTjhqZVEvWmpia3FqbkVnbG03R0JXOC9qU2tyeDE4Q1Ey?=
 =?utf-8?B?RzdadmxSaU1qNlFNUndzQUQrUDhRYlZsV1BHVlpDZFZnYnJvcDcybm5XZXpC?=
 =?utf-8?B?N3A4a0JFcGtTcms5aU13UlhnUDFvNTVVYTlMRWU4TVRjWXZUUlgyYlZ3LzVQ?=
 =?utf-8?B?VEFLdGlXTGkxaGFIWEhQWnVyVGRDQy9nUTlTU0lnZVZJNG1kZHBhV3hFNzZM?=
 =?utf-8?B?VkJET2xSSDhQM3Q5eG1CWmU2dWptelphVTdNbVJBN3lWMTIyQ0xneWorRzdC?=
 =?utf-8?B?VEFVN0xNTThSY2NySjRmdjl2RHYxNnl2aXJkWFRxK2RUM3lpTVBoMnRsU2Vq?=
 =?utf-8?B?WUJOZGpEL1JLeGE0S1piU2xTQlRpUjY1MkRoR2NqS1hyMEQvL3dqTFpxVHlK?=
 =?utf-8?B?blMvWlcyNlhCOUR0RHUyTEhKcmgzL1RzWE5KKzM2RHNtajYvZ1hLejFqNEF0?=
 =?utf-8?B?ZWoxalhqbm5LbkVCUHordlIzZGtBMld0cFFLU0xhcmZDb1RHVmhXUzVsbEp5?=
 =?utf-8?B?MFVaV0hJNlJCbHg3RW02bTZvMlFBNVJ5ZGF1N1BON2RLK3Jrc1ZPWkpkSUw4?=
 =?utf-8?B?OFRxbWh3VnVDNUdubVV2REhSdHd6RGdnL3NqR1dISGpVL2tWVkUrYisxRzkv?=
 =?utf-8?B?T0o5eU5CWDFYTHJ4UzRzTm9QRHNrRGFPemxLZk9NaCtsK1pKM3JaMFVUZXNm?=
 =?utf-8?B?UTd3Mjd6eWhzd2thMGVHb0lwNlk4QnJpMWRidUZ1dGpJaTJyRDY5Z1lQalpZ?=
 =?utf-8?B?NHVOb09pa21OT1o1eUQvZmNLaXV3UW5CRjl6RnpxRG0xRG91eHhyV1lGdFZV?=
 =?utf-8?B?aVBkb1FZSVhRb0k1Y1lkcEJ3Z0plWnZVaFczTWdKSFBUa3NHZVptMVJXc2hp?=
 =?utf-8?B?b25jUytEZWdISVd4aVpsTFBUMmVWczZLa3o1enNZOVpCTk43QmZKWUlISFlI?=
 =?utf-8?B?emtwZ2REQnBWZ3FWdG9WTGo2S2k5SndSWW5rMFVYNXE4c01yVHV1Y1NaZ25P?=
 =?utf-8?B?ZmFqakh5ZXgvREFqRXY2aUNqalVGU2R2djB1VUtmVmJnRmV0TlZwQTZWdEVu?=
 =?utf-8?B?WlVmZ1ROUkxRc2lONjJicVhzWWpSdjROdk5aTWxTSlNteWo0UFRiZ01yNXhn?=
 =?utf-8?B?TzAvaTJOWlBTMkRSOHJzZjJQcnZRWHU0Zld3aHE5bkQ4UFQwYnc4NXZvQnNS?=
 =?utf-8?B?MTNUM3NaMFI3ZFdhMG5WNmp3a0NuZVdDUU85WEJFdzF3MllSKzdTbWdEYndL?=
 =?utf-8?B?ejZob1EybFMrM3FrSG04N3pFdlA4M3ZQaGpTSXdHNXh4ZUNvTEZ1Ym93dEF6?=
 =?utf-8?B?N0ZrK05Nbm1Bb3ZWT3ZaeVQ0ZTM4VFV2MGwvRzlIbVIwNzFCM3ZZeFMxSU1I?=
 =?utf-8?B?WVQvaC82Tm1TdFFRNEhwWE5KaXVBMXFMSVM1UE5uRklWSC9wVVlUa1FqSFky?=
 =?utf-8?B?TmpWcWt4ZWc3Wk1zS21IUXRDSDg2Mll1RHBoOVhHWTBXUDhsL1ZkTFI0a1Z6?=
 =?utf-8?B?KzZyY20zdmN4TTN1eXl5OXpDK3lUYVFzZkNsclNKeExxb2JhOEZ2bGtaWEpD?=
 =?utf-8?B?VU5VaFZQYXJQRkFEVUpBeUZnaWJZZ0ppZVphbXI4bWNwVzRMaEJrL3pDQ1BU?=
 =?utf-8?B?Wkcyejd2Zm54cURVNGtrZm5KNDRDcExNVFNFS0I4NG5DY1ZwOHgrc29zV3p6?=
 =?utf-8?Q?rf4sG/ULcopqy1N/e71MJlCpqYfW0g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlNxTWlPeWNCR3U4SzBaY05vSCtBN2NLK0xqbmZwWjhQWWxweWNrRjdzRzJQ?=
 =?utf-8?B?eDFZbFJkRlY4THFzYUtRZnFtdHg1aGtlSFZaK1ZnWk9UdStiN01UQW1mcUta?=
 =?utf-8?B?aWUrWFNSaUk1K3pjZ0dYMXJ4bFF2bFhSVXBkUmU4dkVMWDdzVjJEaU1XcXR0?=
 =?utf-8?B?ZTlBZmdySzRmMFI4enp1UzdKbGdUa0s0VVc5cy92NU04bUtQZ0M4amFQMkY5?=
 =?utf-8?B?UEVkWDBESWt4UXc1dkk0NENxc1dDUVJxb244NGJaTTRWR2IvSUd3eTdnd2ZX?=
 =?utf-8?B?a0h6Tnh0dWlTWDFlTEY2T2lOdUorYWNGWFdXWW41R2ZqTCtUUjF1QjhGT3l1?=
 =?utf-8?B?YTcxVk5TbVB4cXZjNGVvc0hrQW4rdmVTSjgvOHFYc2RqMGQxQkJGRkVXZjRy?=
 =?utf-8?B?c2FkbGErMHZKSStRRzROYVkzMFJYcFNFcUJNaDI0MWt0THFLd0hnVFRWcVNy?=
 =?utf-8?B?QjZmOU82RlZ2d2sxdGdNdWY3RGZYc2krVnJ4MTZNOU9BUUdkMDFGUERuSFpa?=
 =?utf-8?B?UGRiRWZDc09XME9Tc294KzFSN3U0TllzeHJHOGd4c05HZFVDNmFRM0JQNCt3?=
 =?utf-8?B?WTNRcjJxakNLUDI1VjdJa0pIMXFza2YzOG1Wb0w3dkl2eWg1UVJyQ0FTa1FD?=
 =?utf-8?B?ZHg4VmlQSG9WdEV4QkUreFc4NjgxTi8xTjlXNVdvaTlOek5NMktzTW1RQlpO?=
 =?utf-8?B?N01mbk8rcWY5ejMzemlKbUJRRVFQeG15Q3hyelNJTzc5elo0SXMyTzdXSEZM?=
 =?utf-8?B?anJsbCtLa2RDanc5NU9mWGkyNjN3MHY4cml3dnFabUJHeVgwTis2VHY4NGp5?=
 =?utf-8?B?TDI3MndaY3A2NjQvdGk4aUFOb1VQZHEyZVNvT3NKaWlWYTFaalR5RE54YlFX?=
 =?utf-8?B?VnhGMmRuOVZBTHNDZUZIcHM0WnY0dnY0TTJkRWkxaHc0eDk1dEQ2U2gydFhS?=
 =?utf-8?B?TU1oNU1nUm1JK2ZIeVZqRklYbzlrSUNUUFZaUTVUUXprckNRSEtSYkJoT3JZ?=
 =?utf-8?B?UUhxOWJHeHpud1NMbHAvbTFyZjZRWTJVMktPc0V4VFV2RkxkK3ZEZHlsOHgw?=
 =?utf-8?B?VklqTHUwaW1qL2cxVTVsNzZmc0RwQXoyd2o2OHhjbkx0RmRkdWZNV0hrZi96?=
 =?utf-8?B?RlNHVDRvQkRFRWEzQmZvT2lqV1FRaEN4QnE4d3M1MkhlRDYvdHZiUzlNTVRT?=
 =?utf-8?B?SmUzUDNhZHVFbGNWZWxTUWxmUUdoMS9vOXhialBpSUVWN3lPTkVNYmVsWFo3?=
 =?utf-8?B?dXVhVkg2dExWemtwN3ZNR3B3Wm1WMWdkakF1YXB5WWU1SHpubWhVWFc0clVr?=
 =?utf-8?B?RDFPcllzN2Jnc0ZtOFh0V1hZT3ZKV29ISXUrUDdlNFk1R1BRSWZhL2FLbmFu?=
 =?utf-8?B?NXZZUlpCcWRwS0lCSmFnTUZFVjlLZWQrVFlKS2l5cG43WXM3azFUK29NaGlB?=
 =?utf-8?B?bkk2dnBOVld5UHVvZURqUXMydmJDaWFYaWtGb2IvT3BsNlFDUDR2M095c1FW?=
 =?utf-8?B?cEY1SDVFNDE0Sjd5WVQxdzQyL0YycXF3MDNSQ1lVd3M2ekZCc3ArdlMzdDAz?=
 =?utf-8?B?MFNmNERQZjZzZkkrV3VqV2NKQ1RNeEpuWnVLaGkzelB3c25lQzBJYlkzMk5J?=
 =?utf-8?B?dFVlYno3MUNWWjhOVHBIeEduamVMaE1PdWhsVFVlSkx6M2Rqd0RBVm1OK3FD?=
 =?utf-8?B?T3c4OTlFRysvTDlwTHk3eTNaNlYrQTVmUm91RGt0WStCQUxXSnowbTZmaW1t?=
 =?utf-8?B?SjFLTWVTS0pRN25Ua2NKalZBOTFhVUFTeXRTTStLM1hENFcwc1N0WGxPTWhW?=
 =?utf-8?B?cGtNU2dLZmpuOG9zZmpBZWs2TEltbWk5WGVHc1hUTmVlWWpNcWR0bFJZejE0?=
 =?utf-8?B?K3pKMzBUUkY1SEpwbmpUaXZBWUo0UU9uSkhjZUFsN0pScFZlZzlOYXBiV0tU?=
 =?utf-8?B?TmJ2RHNNcC94M2lGRytyNHIwb2JaUVk5Tk5PY0xJVmtSU1pvdmFwZEhYeXVE?=
 =?utf-8?B?WklzSzlHSS9oWm1LMnBHVXFCb2NJTm5aTXNqOW5PWnFvaS9mb211T0QrN0dv?=
 =?utf-8?B?YkJNNHdiRkRWc2EvelNGMDFuOVo1dnZFb0prYm9VR1FkTzJ6dDV3Wjdab0hk?=
 =?utf-8?B?b1ZFN1FHNWVTamNlbWIvZHdUUVkwUk5mUXM0MnpYb3phR2dYbkl3c2pKNmk2?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF75978F765934E8B3F44108DADA12F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 698f3daa-d87b-4c11-d0e5-08ddaf469b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 15:33:14.6466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wc/eSqdlVlkWRF21IAkWNVgdncbSJxZOcHBVDvOrPaKte5U4Nz4kQx3UcXBi1mwFbFjvD5eW/ThBm064+E0lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5248
X-Authority-Analysis: v=2.4 cv=Ycm95xRf c=1 sm=1 tr=0 ts=68542dbe cx=c_pps a=KGbl5jcDRhx1529k24t0jQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=-oqBJOsOOzvZTEZkZKcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N3aAVNwT5VLHfod9YKlZv3NeuncXPqhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyOCBTYWx0ZWRfX2wm+TFzHneFA bEhq2djOF1dXpCC9St0JEYg1LMBmUSzi28lZXE1sX/DE72WZgsk15dQ85yUhIURoiaYXrR2FfuI mI7YQ6QGTwiaCJULNE8Ftqw/Z2KSv5Fn3pnmfCWdZqguOqLlH3zBVUceiz6OzDXFZ0Zj+m72O++
 2c02UxJm6DUcnM775RQNRQx4/z89sDG0ysj34i9AuSjODAmq2by6uYr8g35FDvjXow8WKIp+BED Foi7UkLBmoAys3TkKDyKH30nPiw7nFFruVrz51KDQF8U81gB3D0KEypOQmzv8anE0Tjm9dZWEZt jZzWjpblbkN5lQmqX+W/mB40aMO1MtmxIqjbbZgkxiO/UEjwYgwwZja6GgPiBZ5uNvY38XAM200
 xbOludlEN/MvlBBtB5K4DxKA31XSDPBvrGypcd+ZIGFIn0KINQ+rm7onQtamYbEdZKO5VIZV
X-Proofpoint-GUID: N3aAVNwT5VLHfod9YKlZv3NeuncXPqhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01

DQoNCj4gT24gSnVuIDE5LCAyMDI1LCBhdCAzOjAx4oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQg
MDQ6Mzc6MzZQTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBFeGlzdGluZyBrZXJuZnNfeGF0
dHJfZ2V0KCkgbG9ja3MgaWF0dHJfbXV0ZXgsIHNvIGl0IGNhbm5vdCBiZSB1c2VkIGluDQo+PiBS
Q1UgY3JpdGljYWwgc2VjdGlvbnMuIEludHJvZHVjZSBfX2tlcm5mc194YXR0cl9nZXQoKSwgd2hp
Y2ggcmVhZHMgeGF0dHINCj4+IHVuZGVyIFJDVSByZWFkIGxvY2suIFRoaXMgY2FuIGJlIHVzZWQg
YnkgQlBGIHByb2dyYW1zIHRvIGFjY2VzcyBjZ3JvdXBmcw0KPj4geGF0dHJzLg0KPj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBmcy9r
ZXJuZnMvaW5vZGUuYyAgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4+IGluY2x1ZGUvbGludXgv
a2VybmZzLmggfCAgMiArKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+
PiANCj4+IGRpZmYgLS1naXQgYS9mcy9rZXJuZnMvaW5vZGUuYyBiL2ZzL2tlcm5mcy9pbm9kZS5j
DQo+PiBpbmRleCBiODMwNTRkYTY4YjMuLjBjYTIzMWQyMDEyYyAxMDA2NDQNCj4+IC0tLSBhL2Zz
L2tlcm5mcy9pbm9kZS5jDQo+PiArKysgYi9mcy9rZXJuZnMvaW5vZGUuYw0KPj4gQEAgLTMwMiw2
ICszMDIsMjAgQEAgaW50IGtlcm5mc194YXR0cl9nZXQoc3RydWN0IGtlcm5mc19ub2RlICprbiwg
Y29uc3QgY2hhciAqbmFtZSwNCj4+IHJldHVybiBzaW1wbGVfeGF0dHJfZ2V0KCZhdHRycy0+eGF0
dHJzLCBuYW1lLCB2YWx1ZSwgc2l6ZSk7DQo+PiB9DQo+PiANCj4+ICtpbnQgX19rZXJuZnNfeGF0
dHJfZ2V0KHN0cnVjdCBrZXJuZnNfbm9kZSAqa24sIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiArICAg
ICAgIHZvaWQgKnZhbHVlLCBzaXplX3Qgc2l6ZSkNCj4+ICt7DQo+PiArIHN0cnVjdCBrZXJuZnNf
aWF0dHJzICphdHRyczsNCj4+ICsNCj4+ICsgV0FSTl9PTl9PTkNFKCFyY3VfcmVhZF9sb2NrX2hl
bGQoKSk7DQo+PiArDQo+PiArIGF0dHJzID0gcmN1X2RlcmVmZXJlbmNlKGtuLT5pYXR0cik7DQo+
PiArIGlmICghYXR0cnMpDQo+PiArIHJldHVybiAtRU5PREFUQTsNCj4gDQo+IEhtLCB0aGF0IGxv
b2tzIGEgYml0IHNpbGx5LiBXaGljaCBpc24ndCB5b3VyIGZhdWx0LiBJJ20gbG9va2luZyBhdCB0
aGUNCj4ga2VybmZzIGNvZGUgdGhhdCBkb2VzIHRoZSB4YXR0ciBhbGxvY2F0aW9ucyBhbmQgSSB0
aGluayB0aGF0J3MgdGhlDQo+IG9yaWdpbiBvZiB0aGUgc2lsbGluZXNzLiBJdCB1c2VzIGEgc2lu
Z2xlIGdsb2JhbCBtdXRleCBmb3IgYWxsIGtlcm5mcw0KPiB1c2VycyB0aHVzIHNlcmlhbGl6aW5n
IGFsbCBhbGxvY2F0aW9ucyBmb3Iga2VybmZzLT5pYXR0ci4gVGhhdCBzZWVtcw0KPiBjcmF6eSBi
dXQgbWF5YmUgSSdtIG1pc3NpbmcgYSBnb29kIHJlYXNvbi4NCj4gDQo+IEknbSBhcHBlbmRpbmcg
YSBwYXRjaCB0byByZW1vdmUgdGhhdCBtdXRleC4gQEdyZWcsIEBUZWp1biwgY2FuIHlvdSB0YWtl
DQo+IGEgbG9vayB3aGV0aGVyIHRoYXQgbWFrZXMgc2Vuc2UgdG8geW91LiBUaGVuIEkgY2FuIHRh
a2UgdGhhdCBwYXRjaCBhbmQNCj4geW91IGNhbiBidWlsZCB5b3VycyBvbiB0b3Agb2YgdGhlIHNl
cmllcyBhbmQgSSdsbCBwaWNrIGl0IGFsbCB1cCBpbiBvbmUNCj4gZ28uDQo+IA0KPiBZb3Ugc2hv
dWxkIHRoZW4ganVzdCB1c2UgUkVBRF9PTkNFKGtuLT5pYXR0cikgb3IgdGhlDQo+IGtlcm5mc19p
YXR0cnNfbm9hbGxvYyhrbikgaGVscGVyIGluIHlvdXIga2Z1bmMuDQo+IDwwMDAxLWtlcm5mcy1y
ZW1vdmUtaWF0dHJfbXV0ZXgucGF0Y2g+DQoNClRoaXMgbG9va3MgYmV0dGVyIGluZGVlZC4gDQoN
Ckkgd2lsbCBkcm9wIDEvNCBhbmQgaW5jbHVkZSB0aGlzIHBhdGNoLiANCg0KVGhhbmtzLA0KU29u
Zw0KDQo=

