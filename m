Return-Path: <linux-fsdevel+bounces-41538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEFA31573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D154F162149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2E26E633;
	Tue, 11 Feb 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hF8MgWmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D826E620;
	Tue, 11 Feb 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302345; cv=fail; b=iYxFXvUbS1JJHttAn/2OstPU3hRKAyrF/Ua638QhFBAK3GVGxtnq+gS/mn8oiw+DItyqn6cXflirbA8YxJ1ZqyMfpx8JU8Mt9Kcj+3C1WusDsDu7JjB8PuzRvAcNaBLYZX3fGCHzu9bvjIeCOI0mjIhDxnl26MvWSjEJpj6oNeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302345; c=relaxed/simple;
	bh=7rDbazxandex4U9ZP3cw3efsOpNJtV/D25FaTqcr6gQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=TTl7NxlzfNnKn0QUr3+oFAwwHHZu4WUfgDpBvWLLKRbW2roppLpAOM41seuSaCEyXc4+HswXAN/g8WtMMSxqkxgH5OmlWOMvXVjuK8Uy37PPP+dh+H7iAMG4R1qUGoWztmZs38bDSsxYfVXvOV5NPfr6qbC00faq/AIpR5k+6qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hF8MgWmd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BFdcLg020787;
	Tue, 11 Feb 2025 19:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7rDbazxandex4U9ZP3cw3efsOpNJtV/D25FaTqcr6gQ=; b=hF8MgWmd
	TKpkLu3MKlsI/TQVh/U7Qj+VHQXFBsM3kwNvwZVA5MWoeWukHbHK0b+DSgn1ei9U
	Qdn5XmA+RPXk27cEbiKOmWYpDnA+Xl6o5PYE0rhHQa9LJUuKtfa/Eu+Ya1QX4YtW
	EE9Dp7CfZapWaTLcaVeBk99eKMg0XPNhGrUnU6c5gcuu7a1rtxLb18vQH2e+4PxC
	Wyv/GIAe7U9/U6bOhcPMg44i4PQ+ybCWAeXiJSuEdn/G7bhuJO/8ejhkNd+nfOew
	07H1vGhOZqOq6QbUyrmrGMZsXM6aZtANn5pwL9KsFV9rNiCZd2z4uLwGyr+rV3RD
	7Vm3Zsnu9Jssyg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r9cu979b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 19:32:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51BJTEAU026549;
	Tue, 11 Feb 2025 19:32:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r9cu9796-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 19:32:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLSZyA7Htp12q5D9sZJcevIi2lNeURlRusyw/yGFAiaytmniD+wpHsTuCz1VAjTObQAVPOabYvUDdwEUPhKz1cMwN0e3VkJG0YIUC8ChZ7x4NTAfwDfl1CQ/XRgrGup/MIWVYumaRiB/ppUrzmCnBZGtc59gfaJRhOVgXjGl1eD4u9XcHX0D+jqmGtOrZYxh3TMeWeSWcl7/RQ/MBf6naf3W9D38tnXSAIugQOhD+IMLHzIrt9XH/sBgdSQWU+QygXbw8Mh+BjqkqAPXRsBxd223qTTOYkhRFjyww2qEuG4fQyQVK4ptA1X7loin21kHKYprZ58rB3MMM2wxIwLHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rDbazxandex4U9ZP3cw3efsOpNJtV/D25FaTqcr6gQ=;
 b=ienDC2/RniCxJOUVlrAdDJ5rsRu75WkGUTMQF01QHVbGMqF4bZhLPM/paQeyBsutdd2SivrQOxmB44fhTxBK/2USLJ+Fr/ONCU07EcZBxmA4V+HHPAagM7rD5l+KWY52L0enHhj/6AIibNMqEC01NMCzL5nIkpbuGecUKO8qG4cI0LAvRZUxDbnCw4+QqQAHDVvBjPMoM4PhSoUB4mDj76doGX1pEn3LSR4gOEtWfqzu2aLabPHPIIP4m2QitBO7KgG1q5jTec9Cju3ygYcNqtmc4auAZ3gracEoN1mgGcnL38GUmJFB8ApBKbM4qyaPyVGNYqy+KCrF3YRAxbj8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6059.namprd15.prod.outlook.com (2603:10b6:510:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:32:16 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 19:32:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Thread-Index:
 AQHbcTHI6MoXeV145U6GsShlXuSWerMs1eMAgAAdZwCAFFxvAIAAAfaAgAEp1oCAABC4gIAACK8A
Date: Tue, 11 Feb 2025 19:32:16 +0000
Message-ID: <36afe0ca1c80a97962858b81619501e5a5483fe1.camel@ibm.com>
References: <20250128011023.55012-1-slava@dubeyko.com>
	 <20250128030728.GN1977892@ZenIV>
	 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
	 <20250129011218.GP1977892@ZenIV>
	 <37677603fd082e3435a1fa76224c09ab6141dc22.camel@ibm.com>
	 <20250211001521.GF1977892@ZenIV>
	 <01dc18199e660f7f9b9ea78c89aa0c24ba09a173.camel@ibm.com>
	 <20250211190111.GH1977892@ZenIV>
In-Reply-To: <20250211190111.GH1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6059:EE_
x-ms-office365-filtering-correlation-id: d28cfc80-1fe3-4c68-1e1b-08dd4ad2cb2c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjFzeVFsblVEcWdYWnVnK1YwaTB5TkR1SUwwWDg1bFFDUnYzbTZySVpzYjNO?=
 =?utf-8?B?a0VUV3lxck5XT05kZjRMM3Q3ZUZtdzBSNWtWRUYwc2piVFV4OHNqR1Buc3kw?=
 =?utf-8?B?bUx3MzdoN1VQUmkrNG1sQ1h2TzYyTGNsZzBFR0JERHVHSjc3bU1PcEE3cGt6?=
 =?utf-8?B?SEtDcU5pbkJjTXFGd3NQcFlMdUR3NSsrMitkT1FxUSsybGwwMEZVV0dqTzha?=
 =?utf-8?B?bXJkQ2ozWE9WQmpDZFZQNzc5UEVyTUhvU3YyemxSd1BHUEFPaXlkZ3FjSlEz?=
 =?utf-8?B?K2xOR1h5NjlwOElZSWdlYXZJTjJzbXhnd3llM2NJQUFRcHpPTkJBdHJDZGlx?=
 =?utf-8?B?TVNsRXV0TVEvUjBFakVMWTM1R01RVnZxamVLdUI2VHlubEhHczdFR3RLZTFz?=
 =?utf-8?B?cmV5K0thYUNha2tBOU5CeVhTaHJROVlNNlhxZ1FKd3RzVG5OamovN0x6MFNl?=
 =?utf-8?B?UW0xaTcrYTZ4NGlleHgvbmdJMCtDZFQ4TTJPbUxYcGtaaWVXYlFBaGFZQVdu?=
 =?utf-8?B?YUhmdnZNaW50cVlwVUc2OExRVEpjT0hudnhwSzlMVTRBekRLQVNuNWR0WnI3?=
 =?utf-8?B?VnZVWDVVWkgyMTR1UTJNMFN2OHQyYndMSG9kRXk4cnBuc3JINTZjcmNkcXBR?=
 =?utf-8?B?VVdHa0pzZmxnbXRYb1JxUjdWcUVUWDVOWDQwQTFTMUR0UVlPMkx5QnZjejVE?=
 =?utf-8?B?cThIb2dvTGk1bnV6YVVsSkhEZ3loNGR1WUFuaWtrRjNWem1OWjNZR3R5ZmxU?=
 =?utf-8?B?UEU4NWt4dG43YnlaaUU2cWxCNy9kY3VqdUkvNDIyd2NNV21XeUpRcmlOSk5L?=
 =?utf-8?B?a1A5amhqQjdpbXpDenlkank2QUtrTEhOY3ExV0xzSUlBTjRmbWVLWmJpRlFQ?=
 =?utf-8?B?QjRxNlhPcThEeXpRbmFrVkxpdTZRN1NzditVZzZmL29oQlJabFh0azZMSW8z?=
 =?utf-8?B?NUpkRTArbEY3UGlaUmNQNXd1MVZRbjVVb3BqUkxWeHVtcEhVQkR5VlVJU0hH?=
 =?utf-8?B?dEY1VnlrczFvQ0cwUFduQldtVjJNalFScnhlMVlrMVYwc0JsS2dEb1c1Z1Zs?=
 =?utf-8?B?Vmt6UjhZS0VGN0RBUEkrdStUNWh4YzNBRjdESGc2aEg4NmVZbjluWjYyYVRj?=
 =?utf-8?B?TUhMQTVLREhzRHBYZVRZa09KYjlJN3VOYzBsTC9tcWE0aXAvYmJzYnQ3RjB3?=
 =?utf-8?B?bHRWdXRndTBRNG5qbmI5OE5GOERGZmUvU1pCUFBpNmtkN3ZwZm9WczFibFp6?=
 =?utf-8?B?OGFPTjR0U0h2dDdpODdLNUJ6UXl3MEdiTlk0Wnc4bUJadjNGTE55U1MyQmY5?=
 =?utf-8?B?LzJUTXNSTUxRaHduZkpLVW94QkpyUWpmVU9vTnJFMy91d3RVQVBCVTJOVDJG?=
 =?utf-8?B?aW1hamlpNElsZ0hWM0FKeEkwa2JTWDJGcHpSMGJBRlJPV2NBck1pTjAzSjlj?=
 =?utf-8?B?akxDZm1iaUlPSnN4SlUxREpsUnZCVklicW5hRWZ2ZHBnSEI0VFVnT1padDdz?=
 =?utf-8?B?SllDK2VwV2E4eER6dGMvRzhCcCtFcUlIbXVyOThrc2phS2FZS2NwYzd5Y05F?=
 =?utf-8?B?K0UxNEc2d2hXVktOcmlzdUZNaTVIbm5Ta0ttNmFreHFRZ2lUQjZLZU5LMHFt?=
 =?utf-8?B?MW1lMEE0WFhSNkg5RmE3YVphdllkeFNKaGRKZVp0S1I2QVhScXZIcVlOR3k0?=
 =?utf-8?B?V05UVzM2OTFyYVVOWmliWHVVdFRHeDM5OE5teTVDdTRMVzZOek9VT1piU003?=
 =?utf-8?B?ODFXSlY0Z1ZZOThXNFFOczhhQk1lMTBqbU90NjM4cE5Rck5DRG8xeTR5NEk5?=
 =?utf-8?B?REo5NWxNR3VsREVmQWd6eHNDTlJrT1hxV1h4NGlKRExVUVhyWXd2N1RPTVVM?=
 =?utf-8?B?Z2hVYTBBWEEyM0paNXRlM1o3STA1WlVSMzJ6dDBzYjkwQW53Y1FoRElKSWI3?=
 =?utf-8?Q?7ynCJ6/l2dI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGh6WFBYMndMV2g0anp2eUpkMFVoZ01VTXdzVDljeGNyZ1pqWitvNlR2TVpo?=
 =?utf-8?B?dC9odExxZmJ4N1BOZVk4ZHA0NWlQZGNsaXYraEpTd0lXMmVGVXVBSUdkeFJq?=
 =?utf-8?B?QVlXUkRMVVBVVG16djIyN0xsSWN2VFJ6cCthcERQZnpYU1hON29zOEJkaExi?=
 =?utf-8?B?NzRnV05reFNoQnpZd3F1UVNhajhqeG9WM3ZMRXJaNjhKYUdCWmNTejJpMGlu?=
 =?utf-8?B?aHpJNFVpK0dWNXlYU0VSL1pPZURnUzByb2QrcDdISkRkMTVBOWxhTnpJczlw?=
 =?utf-8?B?ZVMyOUk2d2JndVRxQWJYRVlwQ1hEQjNnZGlObmVHcktGdXMvbXl1NmZTTnln?=
 =?utf-8?B?NDFhSFRIaTJ0SDRtbGIrVXRnNDVjYnYzcHlQaGJIaXErWHhXUHI4Ynd6cjVP?=
 =?utf-8?B?UHNZVlpwUTVsNTZGTFZRc3JSMHRJT2xiaGVybTBVaExGZ1RMVnRBNzNGbURK?=
 =?utf-8?B?QnV4T0c5dC9LSXBZeWNEUW5WSnJCYUNUSG93a2FiM21SQXV6MkJnU1JacUho?=
 =?utf-8?B?WXpLeW01amtRUFZVdU8rYXRJSGZRZmNIWmhyM29waWZvRWxOM2M5WVQzTmgw?=
 =?utf-8?B?N3NUV0F4OUFHUjNUSDNOQWpYWXNMdUZsNUI2MFJBYmkwY2IvcU5iRXZuMkww?=
 =?utf-8?B?K1VQNkhFN09IWEJaeENZMDdnVFUwc2ZUc2hrZ1N0Szh0SkVway9mZmNRLzdD?=
 =?utf-8?B?TGgybEJLS0xSVnBMdE5JZzJib3pTNUh1RDdUVktieTJka0c3cVpvb0pSenpi?=
 =?utf-8?B?YTlva3lmdzkwWUlXMGMwTVgyMERCeXNGQXM5anU3Q0hwSXdpV2RTMnZHRDVi?=
 =?utf-8?B?WlZtclhqN0dNYVRIUVNZb2xoYy9CS0NTR1ZxRWxHR3EvbG41bjZ4K3VWb2FD?=
 =?utf-8?B?dDVJTGZrK2daOWp3OWJvYVNBSVY0RVhMZDlyRERGUDFESTZlRXVqTjBNOVhM?=
 =?utf-8?B?QWZxNUVzMXc3dGhpaStEVWNRUHJSaEtic2JhOFIvYWF1eTJxaWQrMVpra3hy?=
 =?utf-8?B?c2RRWXVkQlU2eWloVjhadlluczNtc3JwZXhuNThnajI5VTc4WXZKWnNYYStF?=
 =?utf-8?B?TEJIM1ZXWUFHREJsbnYwYlhhaW5GMERzRWFOOWYycmVQMGJqZXZnTTM2eTFy?=
 =?utf-8?B?VTBsa2hRR0NMQjE1KzVBaHFMQ1o2RlgwVDFUWUtFdkpJZERqMVR1UkU3ODE4?=
 =?utf-8?B?Uk9ZTGtzVlFaRnZWOVFLU000bHN1d1c0ZjFzR1NtTEtOS2NtVE5QRk13Rkw5?=
 =?utf-8?B?RUM1aFd5Mkt4bTBiR2UvTUpwL1dTOWpndjQ3MHMvNW5OQTIzU0FxMVhyQ1hm?=
 =?utf-8?B?UjBZOXBwMFROSWlOT2trRDZJZ2VaT01IR1FURzBKbExwY1E1K2FEdmFJRklT?=
 =?utf-8?B?KzlseVlwV05BZCt0MU9YRTJockw4bE5sTklyMklEMVVlMlQxZk1zWUFZKzky?=
 =?utf-8?B?Z3ZBZXQ3eVU1eUxXZzk4RUpRajRhZSswc2ZMTzI3YWFMSWdpNksxSnJMT1Qx?=
 =?utf-8?B?Z0VTY3FzZllJNW84U2lLd2VPRTBqREFxZlpPV040SFppVXN2N2haZDJVaXFH?=
 =?utf-8?B?VFBUaXZXTmxQWGJCall2TU5LTEFxL0RvZ2cvVkk3RTB5NTVvSEIzbXdtSmgr?=
 =?utf-8?B?NTRXc3FxYVlJa0hFS0xpT2UxU2wvUi8xeFlUdnppMnp5YkdNOUE3bXpwU1hV?=
 =?utf-8?B?cXo4cVZLTWc3YjM2RGtPT1ZrWi84Y2N2c0Yybm5qMzA3cDdjQjB2NlBrOEVx?=
 =?utf-8?B?Y3doaVdzOWM2clpaQ1hyeDh3SDE4dFVJaEpJa2RjOVRvMG9aWC9Gd1dIaXJh?=
 =?utf-8?B?ZWFMd2tLRXZMdkErNVFSWldRK3RSZjV0bDhiMkhDRlVuVWFXNTlQeHMzTmZr?=
 =?utf-8?B?dUxUejVad3E3V09zYVZubjFXbVNmK3FoaHNpNnlYQTJhY2EzaGtRYldNRDYr?=
 =?utf-8?B?WTQ0UWRLd2NZM2JHYzdNUkQvZGpjUWw1aG1sRW1lN0hxTTBDSC9DbGhsb2x4?=
 =?utf-8?B?dndRSTZpVUNrRzF6NTdGelFkNEhBQTJ5Sk1hb3JmNWVVRjkrL001c21TVzll?=
 =?utf-8?B?UjJXWWs4YlJVaEQxODFPYWR3TnlPcElGSTNvWlpFa3J2blo1UjRYUkNWZ2R2?=
 =?utf-8?B?MFNhc2RaaDlXbXFFK0Y1T3d4YU94Y29QUFc1OXdHZnQxaTdXVnUwR3BtQWhk?=
 =?utf-8?Q?kgwcr9ADHWf4D0kvj4OvJ1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5236ED43D50EAD40A4FC383EA0A36E15@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d28cfc80-1fe3-4c68-1e1b-08dd4ad2cb2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 19:32:16.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8Y/Kr7YuC617PljHqD/AhJ9EZq0HDjTZDMDnpmNeWOe1YnbbLrcG5ClacjIYwsQxheFNyLbcTrW4Ie98OMmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6059
X-Proofpoint-ORIG-GUID: 08hEQCeaHn9l9k48pjziEZx9IKnzwhnh
X-Proofpoint-GUID: oVN99r_v9rqCVXyqy9T7IwHGuTXL5DqV
Subject: RE: [PATCH] ceph: is_root_ceph_dentry() cleanup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxlogscore=932 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110126

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE5OjAxICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAxMSwgMjAyNSBhdCAwNjowMToyMVBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+IA0KPiA+IEFmdGVyIHNvbWUgY29uc2lkZXJhdGlvbnMsIEkgYmVsaWV2ZSB3ZSBj
YW4gZm9sbG93IHN1Y2ggc2ltcGxlIGxvZ2ljLg0KPiA+IENvcnJlY3QgbWUgaWYgSSB3aWxsIGJl
IHdyb25nIGhlcmUuIFRoZSBjZXBoX2xvb2t1cCgpIG1ldGhvZCdzIHJlc3BvbnNpYmlsaXR5IGlz
DQo+ID4gdG8gImxvb2sgdXAgYSBzaW5nbGUgZGlyIGVudHJ5Ii4gSXQgc291bmRzIGZvciBtZSB0
aGF0IGlmIHdlIGhhdmUgcG9zaXRpdmUNCj4gPiBkZW50cnksDQo+ID4gdGhlbiBpdCBkb2Vzbid0
IG1ha2Ugc2Vuc2UgdG8gY2FsbCB0aGUgY2VwaF9sb29rdXAoKS4gQW5kIGlmIGNlcGhfbG9va3Vw
KCkgaGFzDQo+ID4gYmVlbg0KPiA+IGNhbGxlZCBmb3IgdGhlIHBvc2l0aXZlIGRlbnRyeSwgdGhl
biBzb21ldGhpbmcgd3JvbmcgaXMgaGFwcGVuaW5nLg0KPiANCj4gVkZTIG5ldmVyIGNhbGxzIGl0
IHRoYXQgd2F5OyBjZXBoIGl0c2VsZiBtaWdodCwgaWYgY2VwaF9oYW5kbGVfbm90cmFjZV9jcmVh
dGUoKQ0KPiBpcyBjYWxsZWQgd2l0aCBwb3NpdGl2ZSBkZW50cnkuDQo+IA0KPiA+IEJ1dCBhbGwg
dGhpcyBsb2dpYyBpcyBub3QgYWJvdXQgbmVnYXRpdmUgZGVudHJ5LCBpdCdzIGFib3V0IGxvY2Fs
IGNoZWNrDQo+ID4gYmVmb3JlIHNlbmRpbmcgcmVxdWVzdCB0byBNRFMgc2VydmVyLiBTbywgSSB0
aGluayB3ZSBuZWVkIHRvIGNoYW5nZSB0aGUgbG9naWMNCj4gPiBpbiBsaWtld2lzZSB3YXk6DQo+
ID4gDQo+ID4gaWYgKDx3ZSBjYW4gY2hlY2sgbG9jYWxseT4pIHsNCj4gPiAgICAgPGRvIGNoZWNr
IGxvY2FsbHk+DQo+ID4gICAgIGlmICgtRU5PRU5UKQ0KPiA+ICAgICAgICAgcmV0dXJuIE5VTEw7
DQo+ID4gfSBlbHNlIHsNCj4gPiAgICA8c2VuZCByZXF1ZXN0IHRvIE1EUyBzZXJ2ZXI+DQo+ID4g
fQ0KPiA+IA0KPiA+IEFtIEkgcmlnaHQgaGVyZT8gOikgTGV0IG1lIGNoYW5nZSB0aGUgbG9naWMg
aW4gdGhpcyB3YXkgYW5kIHRvIHRlc3QgaXQuDQo+IA0KPiBGaXJzdCBvZiBhbGwsIHJldHVybmlu
ZyBOVUxMIGRvZXMgKm5vdCogbWVhbiAiaXQncyBuZWdhdGl2ZSI7IGRfYWRkKGRlbnRyeSwgTlVM
TCkNCj4gZG9lcyB0aGF0LiAgV2hhdCB3b3VsZCAid2UgY2FuIGNoZWNrIGxvY2FsbHkiIGJlPyAg
QUZBSUNTLCB0aGUgY2hlY2tzIGluDQo+IF9fY2VwaF9kaXJfaXNfY29tcGxldGUoKSBhbmQgbmVh
ciBpdCBhcmUgZG9pbmcganVzdCB0aGF0Li4uDQo+IA0KDQpDdXJyZW50bHksIHdlIGhhdmU6DQoN
CmlmIChkX3JlYWxseV9pc19uZWdhdGl2ZShkZW50cnkpKSB7DQogICAgPGV4ZWN1dGUgbG9naWM+
DQp9DQoNCk15IHBvaW50IGlzIHNpbXBseSB0byBkZWxldGUgdGhlIGRfcmVhbGx5X2lzX25lZ2F0
aXZlKCkgY2hlY2sgYW5kIGV4ZWN1dGUNCnRoaXMgbG9naWMgd2l0aG91dCB0aGUgY2hlY2suDQoN
Cj4gVGhlIHJlYWxseSB1bnBsZWFzYW50IHF1ZXN0aW9uIGlzIHdoZXRoZXIgY2VwaF9oYW5kbGVf
bm90cmFjZV9jcmVhdGUoKSBjb3VsZA0KPiBlbmQgdXAgZmVlZGluZyBhbiBhbHJlYWR5LXBvc2l0
aXZlIGRlbnRyeSB0byBkaXJlY3QgY2FsbCBvZiBjZXBoX2xvb2t1cCgpLi4uDQoNCldlIGhhdmUg
Y2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoKSBjYWxsIGluIHNldmVyYWwgbWV0aG9kczoNCigx
KSBjZXBoX21rbm9kKCkNCigyKSBjZXBoX3N5bWxpbmsoKQ0KKDMpIGNlcGhfbWtkaXIoKQ0KKDQp
IGNlcGhfYXRvbWljX29wZW4oKQ0KDQpFdmVyeSB0aW1lIHdlIGNyZWF0ZSBvYmplY3QgYXQgZmly
c3QgYW5kLCB0aGVuLCB3ZSBjYWxsDQpjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZSgpIGlmIGNy
ZWF0aW9uIHdhcyBzdWNjZXNzZnVsLiBXZSBoYXZlIHN1Y2ggcGF0dGVybjoNCg0KcmVxID0gY2Vw
aF9tZHNjX2NyZWF0ZV9yZXF1ZXN0KG1kc2MsIENFUEhfTURTX09QX01LTk9ELCBVU0VfQVVUSF9N
RFMpOw0KDQo8c2tpcHBlZD4NCg0KZXJyID0gY2VwaF9tZHNjX2RvX3JlcXVlc3QobWRzYywgZGly
LCByZXEpOw0KaWYgKCFlcnIgJiYgIXJlcS0+cl9yZXBseV9pbmZvLmhlYWQtPmlzX2RlbnRyeSkN
CiAgICAgZXJyID0gY2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoZGlyLCBkZW50cnkpOw0KDQpB
bmQgY2VwaF9sb29rdXAoKSBoYXMgc3VjaCBsb2dpYzoNCg0KaWYgKGRfcmVhbGx5X2lzX25lZ2F0
aXZlKGRlbnRyeSkpIHsNCiAgICA8ZXhlY3V0ZSBsb2dpYz4NCiAgICBpZiAoLUVOT0VOVCkNCiAg
ICAgICAgcmV0dXJuIE5VTEw7DQp9DQoNCnJlcSA9IGNlcGhfbWRzY19jcmVhdGVfcmVxdWVzdCht
ZHNjLCBvcCwgVVNFX0FOWV9NRFMpOw0KDQo8c2tpcHBlZD4NCg0KZXJyID0gY2VwaF9tZHNjX2Rv
X3JlcXVlc3QobWRzYywgTlVMTCwgcmVxKTsNCg0KU28sIHdlIGhhdmUgdHdvIGRpZmZlcmVudCB0
eXBlIG9mIHJlcXVlc3RzIGhlcmU6DQooMSkgY2VwaF9tZHNjX2NyZWF0ZV9yZXF1ZXN0KG1kc2Ms
IENFUEhfTURTX09QX01LTk9ELCBVU0VfQVVUSF9NRFMpDQooMikgY2VwaF9tZHNjX2NyZWF0ZV9y
ZXF1ZXN0KG1kc2MsIG9wLCBVU0VfQU5ZX01EUykNCg0KVGhlIGZpcnN0IHJlcXVlc3QgY3JlYXRl
cyBhbiBvYmplY3Qgb24gTURTIHNpZGUgYW5kIHNlY29uZCBvbmUgY2hlY2tzIHRoYXQgdGhpcw0K
b2JqZWN0IGV4aXN0cyBvbiBNRFMgc2lkZSBieSBsb29rdXAuIEkgYXNzdW1lIHRoYXQgZmlyc3Qg
cmVxdWVzdCBzaW1wbHkgcmVwb3J0cw0Kc3VjY2VzcyBvciBmYWlsdXJlIG9mIG9iamVjdCBjcmVh
dGlvbi4gQW5kIG9ubHkgc2Vjb25kIG9uZSBjYW4gZXh0cmFjdCBtZXRhZGF0YQ0KZnJvbSBNRFMg
c2lkZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

