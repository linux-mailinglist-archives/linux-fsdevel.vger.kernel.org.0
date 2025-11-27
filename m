Return-Path: <linux-fsdevel+bounces-70081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B68C901A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 21:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E63344E1426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03331076D;
	Thu, 27 Nov 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EeacqLdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC2223336
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764274761; cv=fail; b=a7UIV2d7c0GvWudVJm35KYEuLkammv65f5duIXEMkHxaFgDFi9Q9kCq5driR650OPqK9e0+VSWi1cWIozg+iHrc/vlTaoLG8j0IEFlU38hXN/5VLTBq6MKTXGQE8cKJc4mKN0Hc6X4EAPyYyk3Fdlwgyw+nl8YUYJuvCGzqg2V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764274761; c=relaxed/simple;
	bh=C0yyOsaV6wUvcJldFuBSwahn2ZVWTLnoubZJkSm9EzM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=URj0VcIMsoja0psZwkYh4v7DMAAR+r7xtmdx+I9nuKqMChku91McyvBpvXqA6m5QAE4nS2/jpzSdvviZX1kYbPT0Bxn939gwIuj6CtMp2ZE5zSf3DxZTRs2NICqZ4lEl3wdC9dVNMLMZtyiPxepuNXYDPRtVlt3drn/GwT7irdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeacqLdf; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARFacSN019760
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=SUJuTPN74/aCG8648wLr9jC3xDwBEDqyZKzUk9uhEe0=; b=EeacqLdf
	2/DaSQwfGcWKyTUh9p2R+g1N6VQNHiv3Xoy6e/7ylWROXinGG8JstMBFK6Zdtcw7
	DEZFC0QFBztqwdhXYAhMiW1RufKjUS2uNDq7XFTrhNEQ12yOna/1orsIXY3nolGw
	rsgduWH/hVRz6B/wftfjBTlzPgt2oy3ZiMrccgyu8eHjAjLW+0cYKd9KmCcV1QLt
	CX2E9GlxYqkfjabLTlRjAa3vJKpUe0dpV5xyJ2vQP9flvNbJw4P31xJ6o/j/knmd
	6Uk3vTxCRR6+az5yMoaHcseRqdVRt1L3/a+LL3xOvEEMD3RZxJn2Xg/jYZ3qE0go
	yCRznMISWpysuQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvkcb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:19:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ARKDdh2017821
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:19:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvkcb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 20:19:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ARKGvxI025008;
	Thu, 27 Nov 2025 20:19:17 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvkcax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 20:19:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHZ3HxvE+HAtcdEwFfg8dKSAIKvfGrx4yqjyiRZKjAmsDiuoT+a9CfNI0kzB7DkDFTHNEGA8Hqrq2Q5Xh1yLm8B+A4hQibweHB6CHOWmkWbvY3Efrh6nOqVIT+/pd5px0NpdBn7LgjXP54q6JicpHuGTVL5q+dxji1Mqx4PuSoYF8QSAJLnwOfXHIN57+GfO/mxtxxREBH5OkcOJ7eOrvSd2kRYgWzLICT67oaZaFwPONGxZyBp0KmUEIZZ6RUiJH5Rh5xBR6pjvANqxBaH1CANKRhAK8B1k8jFUcV4uCQpaEKEQywDMST6Q7vvE3EC4thAm3ROiLw0dLbIIodea7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE9DsXk1ht8xbcH6ph3McxQk2EQROuTFP02LCZEpook=;
 b=h2spD0t9m2pfy6Xk6pMdAW8FigdsROhvgNhBaim83wsb9IohQdvAg++BTwqqnSSzO7Kn3qcW/s79jA9w2wMOEIXAy8uhlWlNoqLOvUdFIr4mrRlTDflY6uAYNywbeQkVhirQzzkJ2yMD9IaMqpuAPaEegjYAoQSwVhKWecf5Q7Buz2c0F1PEXA1wq2IpIEgr5j2KuWr/UDoZM/Jr2Z7qlEQKL5AFz/M0PPgu1ONRldwEPPLbL3jJirT9gyH1d7BkkGzIDN1wA/Azg2Xy65MXUSdWUVyoJ151k0H985aQcPf8BQnYWs0Vl3AxeCWNojyfZQYWyZbj8AZN1eX6c6uaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by IA1PR15MB5895.namprd15.prod.outlook.com (2603:10b6:208:3da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 20:19:02 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 20:19:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>
CC: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "mehdi.benhadjkhelifa@gmail.com"
	<mehdi.benhadjkhelifa@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4CAAK/KgIAAvdEA
Date: Thu, 27 Nov 2025 20:19:02 +0000
Message-ID: <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
	 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
	 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
In-Reply-To: <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|IA1PR15MB5895:EE_
x-ms-office365-filtering-correlation-id: 622bd94a-e35e-4fa7-8e70-08de2df234ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzBMV1BlM2FITDlOQlR0NTFHRzdZb3hQNVRJRkl0aWhqOEtUdmFaMDFqSjlE?=
 =?utf-8?B?ZnN6RFhNd3NTV1VSNExHaWhjQkNybjVUS1JabE9JRHMxa1RTWGJnRHhPb3Ra?=
 =?utf-8?B?Z3g3N0lGbEtRS1kxOVU2bTR6Rk1tUHY2UkxoNHFxZXFyMnpZdVorNHBhZUZX?=
 =?utf-8?B?RHk3NDRaUlBzK29qdDVhMVNXOTNHZFlQWUhISFBpTmQwai9JNUxIY0t0Wm9J?=
 =?utf-8?B?a2ljcDRlM01aSDdrenNueW1DTG5BejJkamtFWlh3ak5qUnl1NWYyZzBWUjho?=
 =?utf-8?B?MkhNNmhTc2VoYmprZXlnYmpVV05vMTRCeVVzY2EwVDNXWkNObHMrZFB5MlFM?=
 =?utf-8?B?ZkxvUU1lcWZOSEpRbnlwSFVQQ0JzMWd1Yk9qQTZTVDMya3J5UTNTdTRNSVl2?=
 =?utf-8?B?S2JDai9oQUVvWmRBZ2hzWmM0cGk2RHdleW1veEV4aUVkZXVPZWtoU0hta21G?=
 =?utf-8?B?OVJxK0Erd2l2WnFsY1Q2S0tpaE9iN3FVdWVMeTRRSDhCQVZiQnFnY2JzUmlu?=
 =?utf-8?B?UXdUSFQ4UExPMTN0Z2lrLzlGbkR1N1dVOUFGMkRnbHM2MnRkd0wvQzNJdFhs?=
 =?utf-8?B?Y1Y4QU5iUWxzRlNXTkE5RnFIajNzZXlCWWwybk9Da2I1WVcreUdmQ0xUOGY4?=
 =?utf-8?B?OXYzRWM0aUxyLy9YKzg3QzVqVjYwMmk1bTNBWk5vN2xHQlZLZ1NHMmlJbk9j?=
 =?utf-8?B?Q3QzL1V1WWU0WFBZTk9UZVlrQUxBZjBLYVpQL2ZZZ3JPelNvTFVleHFGSEYy?=
 =?utf-8?B?UjZvbk5XQldTdmtBL21QTEU4c2tkb2VnVlFOOHYvZ0tNMDNjbXJ3Wm5VL2tl?=
 =?utf-8?B?b3JWU1l3YytsaTFMYVdYbVZCQVlNQTlOT1REMEE4dWxrNEpoVllnVHRPeUJ0?=
 =?utf-8?B?VXExQmpkUENKODNoaURiV3prRFB6ZzZVQkVyZ0s2MVhtM0svOE1iUndHdFJy?=
 =?utf-8?B?aEpWQXpTdERLUndGSmk4aDZvcjVWdm1FT1d3SWpCcHZ5dEtobmU4WkZmTWx2?=
 =?utf-8?B?M3ZMNVBGMUhXcDNDN3dyaHU0Y2VORnI0STFvREdFMzNiUlZobEtOMWdHRE1h?=
 =?utf-8?B?dWw4b2Z2UlZqV2N2R1lsTUs5eTJUd0tIOTNra0dzdEpiTk10YnlVdWRONlBm?=
 =?utf-8?B?NlhmemJ0aEFMM2t4akg3dGMxeW02ZHRwcjA4RGdWNzdMSDE4MllkRENPTU5u?=
 =?utf-8?B?S25wbEd4MzNLZkZFQjdOU25saTlLZVdncURtN0lMQVVCc2NTV3FpdThtbWx1?=
 =?utf-8?B?eExkK1YxNStpbnZIQmVKSndtZTBMQWRKWmE0NDJ2ZjVEUHN6dlkyMWZPU0p0?=
 =?utf-8?B?MXUzSkRIQlN0YlBLNVc4UVpPM2w3aG45ak9ueitUSmdxeUtOa2hUbVV6dXJG?=
 =?utf-8?B?cEliakJDYlptbmpEUDBibzlzNjRLWEI2KzRUbjNwK0lJaFBuSHNtaW5NdVRa?=
 =?utf-8?B?c0Nad2V4TU9iOGY3UTQ4ZlVGOWRHajFoODV6a0lDajJodUJ4bE1MdzQwVjNB?=
 =?utf-8?B?dmViUWtMbUg5bHl3RVpTcldVck5HTmYvUXluWWE4NG5XU3QwU0xXdHhDRFF6?=
 =?utf-8?B?WlVpbElNTWxLNTlpL2ZQSnR0UVFrZEQxUFhwRW5aRE4rUkxFeTRqeWhxbEd4?=
 =?utf-8?B?aWR4UllGTlpxeHg1cHM4OGVPYUFuUzlFMWpaTm1CZi9GWXV3Vkt6eXlYeG1r?=
 =?utf-8?B?ZUNwTDdlbEtTYkhyV0Q1QmtFaTlWam9lYnNTWE5CRXdsWTJ6V2ZpRDA5cHV4?=
 =?utf-8?B?aDlvYXpIeU5qU3U5NnB5MGJDQjlKZGRaWk1VbDdhazFZNlZ1bUcrTkhtc1Nx?=
 =?utf-8?B?RnF5MDhGV3lvcEFIYmxGWWo2TjFWYnN6Z2EzbVo3YmdTYWovTUhmaTgzWnVm?=
 =?utf-8?B?ZDZOQjFtRkJoNG0yNHUyOTB2cXlOZnN0TmpUZUJMTitPWGl6OElwU0laS0Q3?=
 =?utf-8?B?eGFiVTE0aWhqWXpuWXNzV0NWd3IwTjN1QTFidlhQelB3YVhTZVZXMEFZQzNV?=
 =?utf-8?B?WnZPc3Zwai93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTZpRzArbENWdnh2QXRkZ0VLZDJvMzNpTFdVaDBlaWQ1TnpCb2ZoSEt1WG1W?=
 =?utf-8?B?bWMrM2ppZmw4bEhXWTZCaUcwNGZ1cmdVQisvUXlOSGc5bkxGNVpvNlhQRjd4?=
 =?utf-8?B?UWIxYno5c056aU41VGFFMHJ6VTd1czJBRG1ORDh3bVFXTFZvWjZ4cTV3blgw?=
 =?utf-8?B?QVpqbmRnRDhqMkVqMlkzTWZrN1pNV0U4L3dKcG5ROCtkcEtsckVuV2xFTDFW?=
 =?utf-8?B?Z3g1NUtoZzIwMDcvTVo5U0VHSjY4STNPQ3N5UEx3RXI4NXYzOFhFQWk1RldO?=
 =?utf-8?B?Vm92RHFNQUp5MzlOdCtPeUFha0RxSFE4cXZZZTFQU2cycnpmTk93KytMYjN4?=
 =?utf-8?B?M0I1dklSc1hmUUtUNGNFNnNSSzV6UWNXdm1nRzU4S0RzYUxuV29KU1cyTU9a?=
 =?utf-8?B?eTFUNmRHS0lRK0RIRzdST01tR1dKRlNlRStHLzE2azdhVmhTWVdvWC9ueGtk?=
 =?utf-8?B?cFdKTlhmRTA1OEhrczlSUnZRZ1I1WmJ5b2ZlYTI2ZWMwRjE1NFFmS0REYzdr?=
 =?utf-8?B?N0ZkUzZxQ1h1Ym80TXIrWGdoRjEzc3NNZkhDcnJnWFZPb2RXZXBKV3owYk45?=
 =?utf-8?B?UlZMUnRBMVVidFpWclBhcUE5OUpKRDEwK05CQWQ5TTZ3OTQ3VUllcEhhcmJ2?=
 =?utf-8?B?MlFWMitLbmY4NXhBbnBRZnJtV2NNWFZsWFJ1Y2Y4OUd5R2J1QXNXTk1zYjFD?=
 =?utf-8?B?TUNwdnI4bWNNUW5VV3dlbklEbzl1UHllNnlSY2NMaHBoVmErK3ZORVlESkEz?=
 =?utf-8?B?VXlDaUJnYUk5aDU0c1I3cmtNUithb1hwZDU1R01rSStCaklpY0ZFVml2R1Bn?=
 =?utf-8?B?YVBLZEZpekwzcmVhLzRZWjdjbjFPdUM1bVljeStaV2pwZlNnT1hQeHBBVTJh?=
 =?utf-8?B?L2o0RFFPSmdlaVhyZnVhZFcxU3BoVDJCTmxvWC9nVjZBaE5LbThlKzA4RDM0?=
 =?utf-8?B?L25yRnorSjdkeGRvMXVHRmY1ZnAvbnY0VjQyUnAyamo3RHRickFMaHRNN09W?=
 =?utf-8?B?UWhqY3VITytPTVp4cEJJZFI1dTFSSUhOZEFta0dpaHR1M0hkMEg1cGtDTjE3?=
 =?utf-8?B?VjRFdWJuUmNheWFKSEhDT2RjWkk3d3lFWUpmUGVhbzg2ZEozZFRlbGdOUmtZ?=
 =?utf-8?B?aFh3dk1rUXBIdWNVclgwMkRWeTdXQzVLbjBmdlQ1RUhWVmgyTGxlUnRERVhV?=
 =?utf-8?B?RFFQN1hFajZUSjg4enhzSWtKS2ptYnQvVnFvV0lnMHRyY1ZtdjhsdTJCakVp?=
 =?utf-8?B?VnlRdkNqcHZQczRTaEZ3b2lzL1RUeVY0S0RoRmk2SUVjWHJuYlRoSlpsMXZy?=
 =?utf-8?B?T2VJTEowWTNsWEhYYlBoUlJTL21mdGF3WExHQ2VsMjVSNDJxbmtPR1A2eFJk?=
 =?utf-8?B?RUd1ek0zS2YyU1BGcnNwUWRkaksxZTFpenJNeGNOUXFpUDhqYVdKb3pxaGhM?=
 =?utf-8?B?SmxGS0ZQN3dLT0crWmlQemxOOVhaSEM5QnZJcUk3SE5DcG9JQ2hJZ21kd1J3?=
 =?utf-8?B?dTd6QldHTkpaNVFzd0orNUEvcC91Wk9TbGJkeGFpZzhzd2FxVzhGcWFSeFVI?=
 =?utf-8?B?ZnRna1VFZzJHb2xKN2NrR2tSZW5RSkloY1FLczlXTGl0MHg4L3BSR1FTai9B?=
 =?utf-8?B?V2dQMnkzbGRTU0xNY0lQc0QyUHdtQ08xL3p5enVPQ2FRbTk3c3piMWh3NlRG?=
 =?utf-8?B?bk1XZXV2RUEyUDA3cGpBOUtxb0xtTmVmSWdreDhPbHNQZ0tKUlJVR3Jyajdy?=
 =?utf-8?B?c0ZaWTFMQzUyRkhFRkpvUCtDdTk4dVI3eDQ1VW4wSnRJV3BrK1prT2l1NUJz?=
 =?utf-8?B?NTV4aTZNMlFzU2RCV3Q3ckJMTnYrWnJqR3NjVnlDcjJhbk1oSHkycHRvUGgy?=
 =?utf-8?B?NEdGNlpKU0o2aSt1VDh2Sllya1ptbVkyeE1ldzJVcjRIQ1hMaHM0R25pckNX?=
 =?utf-8?B?M29jR3JuL2Z3Rm5QdFdwcnZYOGkvaHk1ckVkQUpYczE1ZmJFRHJxNzBEOVds?=
 =?utf-8?B?S2JqQmJqOXovcEdGdnhwQURuRHRoSDhkemlXV1RiaVYyVG93TFJmRGpGVjFW?=
 =?utf-8?B?Zm96WnVIZnpDZWE5MkYrckllczFRMWdYaXp0ZDluNGJCS3paRjAySTlPMDV4?=
 =?utf-8?B?a2VEVzg2b3A1Ty9UcWtNT0F4cXdLMjI2VWFMTkQ3WTdHM2xwckVMdlJYRE9X?=
 =?utf-8?Q?84ndo0+Q12P8UeWJs2KEtMg=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622bd94a-e35e-4fa7-8e70-08de2df234ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 20:19:02.6210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlP7gxycghQfHt6nw+iraq1Vlsg0cm2nv+j0hlcfQTaFAG1WLBXiXpzyMPNrJRzF+ONYtvrc6TE7Hw2kn0ATDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5895
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=6928b246 cx=c_pps
 a=j0PM1b0aAxJgDjDzr34Dzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=drOt6m5kAAAA:8 a=6nToxPC8rXmNO398GfQA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX+OrZtl7ojOBo
 +6yPbBTWOSBzD8cM1p7KTP8k1zNknVWXX73355UnYx/+NViQ7oprNkh6xvnI5LwbQnjnveSLDHA
 Vu+3sw7G0UR34G32TnrStSVMMFhYKC6CT/CxpkaQCpmkZiXkzxbhDarV7ZQkySIEHe/1fZ1Lx9h
 of0lxe+AYGd95J5qAsAPBv4+gZSmq3LdXmWK+obbjR2VtcQ/Ho4HXpqCjWXI3f4HTgmatXO2V+j
 zMK1KsE67+ZtQuEAsbdMBx4N9GR4nGZBsNezRgBRDNwLPA4VET0JYz/B8PQD8AqOKA1h6fMKoyq
 mdlmw2btbTRkXYda1xkyRvsLsnxUTVFWYBZ4xz5c8ghzm+EM3YY94sx6sZiyLnz3Ye7BXZvPEZC
 9QfCe9ssT87rbyBYvGzaa/uqdRU+Ow==
X-Proofpoint-ORIG-GUID: WsNt7udqvPRBhparIjMqfWFJGJyIHasl
X-Proofpoint-GUID: TJ0KIM04ifAsSxdcHhHHujtUvotyyTi_
Content-Type: text/plain; charset="utf-8"
Content-ID: <796ACEEF7C65AF489867C09B28A63437@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511220021

On Thu, 2025-11-27 at 09:59 +0100, Christian Brauner wrote:
> On Wed, Nov 26, 2025 at 10:30:30PM +0000, Viacheslav Dubeyko wrote:
> > On Wed, 2025-11-26 at 17:06 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > On 11/26/25 2:48 PM, Christian Brauner wrote:
> > > > On Wed, Nov 19, 2025 at 07:58:21PM +0000, Viacheslav Dubeyko wrote:
> > > > > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > > > The regression introduced by commit aca740cecbe5 ("fs: open blo=
ck device
> > > > > > after superblock creation") allows setup_bdev_super() to fail a=
fter a new
> > > > > > superblock has been allocated by sget_fc(), but before hfs_fill=
_super()
> > > > > > takes ownership of the filesystem-specific s_fs_info data.
> > > > > >=20
> > > > > > In that case, hfs_put_super() and the failure paths of hfs_fill=
_super()
> > > > > > are never reached, leaving the HFS mdb structures attached to s=
->s_fs_info
> > > > > > unreleased.The default kill_block_super() teardown also does no=
t free
> > > > > > HFS-specific resources, resulting in a memory leak on early mou=
nt failure.
> > > > > >=20
> > > > > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) fr=
om
> > > > > > hfs_put_super() and the hfs_fill_super() failure path into a de=
dicated
> > > > > > hfs_kill_sb() implementation. This ensures that both normal unm=
ount and
> > > > > > early teardown paths (including setup_bdev_super() failure) cor=
rectly
> > > > > > release HFS metadata.
> > > > > >=20
> > > > > > This also preserves the intended layering: generic_shutdown_sup=
er()
> > > > > > handles VFS-side cleanup, while HFS filesystem state is fully d=
estroyed
> > > > > > afterwards.
> > > > > >=20
> > > > > > Fixes: aca740cecbe5 ("fs: open block device after superblock cr=
eation")
> > > > > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.=
com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c8877=
8ff7df6   =20
> > > > > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gma=
il.com>
> > > > > > ---
> > > > > > ChangeLog:
> > > > > >=20
> > > > > > Changes from v1:
> > > > > >=20
> > > > > > -Changed the patch direction to focus on hfs changes specifical=
ly as
> > > > > > suggested by al viro
> > > > > >=20
> > > > > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.=
benhadjkhelifa@gmail.com/   =20
> > > > > >=20
> > > > > > Note:This patch might need some more testing as I only did run =
selftests
> > > > > > with no regression, check dmesg output for no regression, run r=
eproducer
> > > > > > with no bug and test it with syzbot as well.
> > > > >=20
> > > > > Have you run xfstests for the patch? Unfortunately, we have multi=
ple xfstests
> > > > > failures for HFS now. And you can check the list of known issues =
here [1]. The
> > > > > main point of such run of xfstests is to check that maybe some is=
sue(s) could be
> > > > > fixed by the patch. And, more important that you don't introduce =
new issues. ;)
> > > > >=20
> > > > > >=20
> > > > > >   fs/hfs/super.c | 16 ++++++++++++----
> > > > > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > > > index 47f50fa555a4..06e1c25e47dc 100644
> > > > > > --- a/fs/hfs/super.c
> > > > > > +++ b/fs/hfs/super.c
> > > > > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block =
*sb)
> > > > > >   {
> > > > > >   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > > > > >   	hfs_mdb_close(sb);
> > > > > > -	/* release the MDB's resources */
> > > > > > -	hfs_mdb_put(sb);
> > > > > >   }
> > > > > >  =20
> > > > > >   static void flush_mdb(struct work_struct *work)
> > > > > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_bloc=
k *sb, struct fs_context *fc)
> > > > > >   bail_no_root:
> > > > > >   	pr_err("get root inode failed\n");
> > > > > >   bail:
> > > > > > -	hfs_mdb_put(sb);
> > > > > >   	return res;
> > > > > >   }
> > > > > >  =20
> > > > > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_=
context *fc)
> > > > > >   	return 0;
> > > > > >   }
> > > > > >  =20
> > > > > > +static void hfs_kill_sb(struct super_block *sb)
> > > > > > +{
> > > > > > +	generic_shutdown_super(sb);
> > > > > > +	hfs_mdb_put(sb);
> > > > > > +	if (sb->s_bdev) {
> > > > > > +		sync_blockdev(sb->s_bdev);
> > > > > > +		bdev_fput(sb->s_bdev_file);
> > > > > > +	}
> > > > > > +
> > > > > > +}
> > > > > > +
> > > > > >   static struct file_system_type hfs_fs_type =3D {
> > > > > >   	.owner		=3D THIS_MODULE,
> > > > > >   	.name		=3D "hfs",
> > > > > > -	.kill_sb	=3D kill_block_super,
> > > > >=20
> > > > > It looks like we have the same issue for the case of HFS+ [2]. Co=
uld you please
> > > > > double check that HFS+ should be fixed too?
> > > >=20
> > > > There's no need to open-code this unless I'm missing something. All=
 you
> > > > need is the following two patches - untested. Both issues were
> > > > introduced by the conversion to the new mount api.
> > > Yes, I don't think open-code is needed here IIUC, also as I mentionne=
d=20
> > > before I went by the suggestion of Al Viro in previous replies that's=
 my=20
> > > main reason for doing it that way in the first place.
> > >=20
> > > Also me and Slava are working on testing the mentionned patches, Shou=
ld=20
> > > I sent them from my part to the maintainers and mailing lists once=20
> > > testing has been done?
> > >=20
> > >=20
> >=20
> > I have run the xfstests on the latest kernel. Everything works as expec=
ted:
> >=20
> > sudo ./check -g auto=20
> > FSTYP         -- hfsplus
> > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7 #97 SMP
> > PREEMPT_DYNAMIC Tue Nov 25 15:12:42 PST 2025
> > MKFS_OPTIONS  -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/001 22s ...  53s
> > generic/002 17s ...  43s
> >=20
> > <skipped>
> >=20
> > Failures: generic/003 generic/013 generic/020 generic/034 generic/037
> > generic/039 generic/040 generic/041 generic/056 generic/057 generic/062
> > generic/065 generic/066 generic/069 generic/070 generic/073 generic/074
> > generic/079 generic/091 generic/097 generic/101 generic/104 generic/106
> > generic/107 generic/113 generic/127 generic/241 generic/258 generic/263
> > generic/285 generic/321 generic/322 generic/335 generic/336 generic/337
> > generic/339 generic/341 generic/342 generic/343 generic/348 generic/363
> > generic/376 generic/377 generic/405 generic/412 generic/418 generic/464
> > generic/471 generic/475 generic/479 generic/480 generic/481 generic/489
> > generic/490 generic/498 generic/502 generic/510 generic/523 generic/525
> > generic/526 generic/527 generic/533 generic/534 generic/535 generic/547
> > generic/551 generic/552 generic/557 generic/563 generic/564 generic/617
> > generic/631 generic/637 generic/640 generic/642 generic/647 generic/650
> > generic/690 generic/728 generic/729 generic/760 generic/764 generic/771
> > generic/776
> > Failed 84 of 767 tests
> >=20
> > Currently, failures are expected. But I don't see any serious crash, es=
pecially,
> > on every single test.
> >=20
> > So, I can apply two patches that Christian shared and test it on my sid=
e.
> >=20
> > I had impression that Christian has taken the patch for HFS already in =
his tree.
> > Am I wrong here? I can take both patches in HFS/HFS+ tree. Let me run x=
fstests
> > with applied patches at first.
>=20
> Feel free to taken them.

Sounds good!

So, I have xfestests run results:

HFS without patch:

sudo ./check -g auto=20
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7+ #98 SMP
PREEMPT_DYNAMIC Wed Nov 26 14:37:19 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

<skipped>

Failed 140 of 766 tests

HFS with patch:

sudo ./check -g auto=20
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7+ #98 SMP
PREEMPT_DYNAMIC Wed Nov 26 14:37:19 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

<skipped>

Failed 139 of 766 tests

HFS+ without patch:

sudo ./check -g auto=20
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7 #97 SMP
PREEMPT_DYNAMIC Tue Nov 25 15:12:42 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

<skipped>

Failed 84 of 767 tests

HFS+ with patch:

sudo ./check -g=20
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7+ #98 SMP
PREEMPT_DYNAMIC Wed Nov 26 14:37:19 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

<skipped>

Failed 81 of 767 tests

As far as I can see, the situation is improving with the patches. I can say=
 that
patches have been tested and I am ready to pick up the patches into HFS/HFS+
tree.

Mehdi, should I expect the formal patches from you? Or should I take the pa=
tches
as it is?

Thanks,
Slava.

