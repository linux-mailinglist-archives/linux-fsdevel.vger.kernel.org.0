Return-Path: <linux-fsdevel+bounces-56528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D5B18752
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BB03A386A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC928CF74;
	Fri,  1 Aug 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFaFC1rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D23288C37
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072799; cv=fail; b=dNsvt6IAgYDrCmSABQ19bxe5JcY6Nh/Puo2RCAcQNYSKdtpiJAhctGsJEssCfpsmGNgxzppI9uJzxe9fo3qhX6ZPsBOtEbUzXO/WiO9cv/FRcEEl+KyN/u5lJ9CyGLnkz+4Bgoo0Fyeh4k+xPYHCXmGqRppE56y2li5O875QTuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072799; c=relaxed/simple;
	bh=8TQ9xXv0tfea56U70sIW1jzcPDH7BPfD5eSmzXrSJNk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=GJSilbDu9cvbYcGEb7bkBHCGmiJH+3mbcp8aKI3Yc0VxIIRmB9HpQzy9nIHIC2lBaXuExx8B8S7Om1Ehgf+r6e90BDY+QScTN2ff7Sd9bOip+fJwOKRI1YLtSUSZzCW0xmTqxHc/N231cfa/SniVtPZ+NsKNanbOLn+orMJo8T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFaFC1rh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571IJ36n008880
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 18:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=CFM2yyUBeTLOaf07X6R1xkv2So162FuOoFJpcyhZnsA=; b=ZFaFC1rh
	EuKHfgHY1UN4X90NK2PWCzVeHe1QjyC1Fl+7r9pZnUf15cATVMaoaAH/NoQ4nLye
	gt4nGuz9fSzEUAsPm0HVMBS72uaPzfQoNrEGp42NE/flcoD/kI5/kMonUXjMQnto
	QRrq5MW9fAtmAc8oMmYUOZJpIEEMaqx/CyMhNT+VeCxTT7I3VubX8s+JFof8ZhXZ
	E8P0Ywm9WDtX4izhFpKgLxpKEwmVIJ/5j3IPvQdyWyO5su8kE8pYzb4fvKquvUd+
	fQEz5ZQmckpFOwIcqT3gWJhlY4EyPF/YwbtOSyDeFsDW5lb6FoeZSsJH6e4zodSq
	N5AAAvB3DYmiYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgjc55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 18:26:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 571IN7DE021039;
	Fri, 1 Aug 2025 18:26:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgjc4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 18:26:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtU1vYgjRB1ECuGpU2p1PmgYu2uOPsMqqPi/VU5DBxvSeTiPzfzQU4BcYizwsF3l6/8cG5A9ElXYr5wvgOo0+P9UwmRcJ/ZYXVMtdzLkDh5+nZd17OIgWwqrxpdk2dSL06ooXMozrkQjSYi93HhaiTGEmEEh0OnQLqedCUQesDCugtlP8z9NBLlzFjSi9TWbPB1e46uPwR5cP/kxNNc1PwY+l3rQVT5YLXZ7F1jnUM55sW+KBRhjbfQmUHG8BiCCNtZNPTgdCFjWnWHAu97cw0T5ouHACn+TkqQ0g8Wk5Yc+irIRG58bEXsDmAoXWn6Pw4WCoBrKgqV+QH15jXoJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjBBczGv/pgb3ciQXmSmFWEPL1mSnAbbn+ePxTNkoO8=;
 b=CrjGQnu2MZzKakxCAcnewiflXVIrN6N9BxyZd+jIeCv/uLP4nYnMLr6DouyTxp5INm15+O7AbUjprC1ZEExAUvSJLIAaq0EEVN7RCf6uo+JEJvB049wRE7nnAVatW0Wwj/ARQ+iFsu5xHGxIm+2HvUUZzrpT+uA30/F9+kS5LbYXmjeLoerVzOC+fkFkWJFN+pJ6PbUKcTx1yXJxAmGTIVeyWD3iw1WkF0HmdEpJPZH4yzU4zmnSAZzz3qZ44sLwdTYDEruzQ0lIhGePHvW8zvAD5zofvPMluwvUl58mEMSOhG2hcKEpllkVO8ShxRaelFbuqVjZRY/nVD4VqcWb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5058.namprd15.prod.outlook.com (2603:10b6:a03:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 18:26:31 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 1 Aug 2025
 18:26:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] hfs: update sanity check of the root
 record
Thread-Index: AQHcAZ226FeYjwYD5E6Yi5amYuG9G7RMh5GAgAA02oCAAWP0gA==
Date: Fri, 1 Aug 2025 18:26:31 +0000
Message-ID: <06bea1c3fc9080b5798e6b5ad1ad533a145bf036.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
	 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
	 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
	 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
	 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
	 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
	 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
	 <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
	 <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
	 <5f0769cd-2cbb-4349-8be4-dfdc74c2c5f8@I-love.SAKURA.ne.jp>
In-Reply-To: <5f0769cd-2cbb-4349-8be4-dfdc74c2c5f8@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5058:EE_
x-ms-office365-filtering-correlation-id: fd76be57-953c-48d6-66e8-08ddd128f057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1QvOXJQTEg3REhVY1FORmdncVlnc0thbjI4QVgxS2VSTHpyV3hDVFIwM3Vn?=
 =?utf-8?B?UEsxUGg0dlI5NlgvVXE2OVBLNkhBbXBkem9KY0I0MFFUUHhpa096ZDUzTERr?=
 =?utf-8?B?UlV3c0RzTmUvOWVFOSs4c0ZLWFpnSVh1ZGNDL3pjTjNpME5kK2dkS25ZQjR4?=
 =?utf-8?B?L1lGYlRwa1JiWnZHQnpxM3d2eUE3VHViQWVYOHR2eVZIcXRIV0lXeDhpangz?=
 =?utf-8?B?ajNTM0ZCUzcvTEJTT0NRZzAvTDB6TmNrcWxtaHlqNitwTWpWU25FenZvc2JV?=
 =?utf-8?B?QmNkY1prNFRBQnpjOHZpMjFjYkd0REVTcTdON3M5Q3FER0RCb2hOVmF2TW9T?=
 =?utf-8?B?b2dHM3dSUkxxQnNkMGQ0cDZ5aDN5UlVEaFdoaS9hN3JzdHFFeUFQV2xnNGVB?=
 =?utf-8?B?Q3FlVjhoMHZreVFMWEVnUkFEVjUwb21maE5DNUJZa3g0ODZwalpQYlFZM28w?=
 =?utf-8?B?TlRUMTFIL0d5VmlRVUlCN0U3c0E5U0dIc0VXZ2FwT2dLQ2lKMnJqVGUrNGhl?=
 =?utf-8?B?Nzd0dXN4dXhVTXVwUnhTenpRaGlOZXdiTDJlaUFKOG5sOVhJeWo5TmF4OXg0?=
 =?utf-8?B?N3dJbG1ZMGVrOGxWZXNMNVBHTDNINm9QSkQ5WnpDakNXaWU3OWphdEVDUW9Q?=
 =?utf-8?B?alFNWEZTTkFjaW1vT2dqcnZ2elNSS2ZJb0VEcHM2M1loZXFwZXFvTUwyaS9V?=
 =?utf-8?B?T3Q5N1FrTHhiTVRoNkF4b0RKUm04TkQyVEMyM0V4WHgzUlRHN1JBekk0enlZ?=
 =?utf-8?B?aVdCZUV2ZzVDYkphOTVLVjVKdTlsRjA4eWt0TXhZMHVpMUhyak9YYnJrSWMx?=
 =?utf-8?B?Y2Nycyt6Rm5uZ0owOXRPYjNDVW9CMFIzRFBqOVhac2RvSmNSMURJYjlwWFNa?=
 =?utf-8?B?UWhlUjZmdlFaUGlqakFhemx2QjNxV2o5RldEelU1bkpnQTcxYkJYcEF2bVR4?=
 =?utf-8?B?NldjRkRrUkcweWpwa1dnMCtOVVQ3aDJnTmUvSDU1OHBGZWR0aHlnU3dWT0E3?=
 =?utf-8?B?bFFpdnd2QzVFZTZCWEQ5MVV5T3NDckw2M1BaWU11K1J2Tnc1QWE4Wkx3eW9S?=
 =?utf-8?B?dStkd0krbkVvS2ZwSEJBSWxGR3ArOWVsWGNaUDJVL2F5ZWxSaXk0ZmYrczBt?=
 =?utf-8?B?czM3a0lkeFFhbnh5WkRwRy9pd0h5c3VtU0NhVFJzZFhBdDBsN04wL0NWbDZj?=
 =?utf-8?B?SmJOMkVKaXcrd0R6YmlYaGFPekxJSFVzajBIV25CTHdJMGlXWjR1eitjUHQ2?=
 =?utf-8?B?c2JkalJpYUNuYU5ZeU1FY1FzQndYejRpeng4b0xrNUdvSzhVaDRLR1JpMjYx?=
 =?utf-8?B?Q2tIYlBWbG4yRER3MnFNU0lLa1NBZGlYTWpqSGNxTmtnUkRQRkdGaDlHTkU2?=
 =?utf-8?B?bFFRZWYxR3hiU3QyY3hVT0o3RGpXQ1ViaXdXMGU0am9kRXVTM3pZZ21lUWdQ?=
 =?utf-8?B?Zllpa2ZGOVhZbkw4ZHZLcjYvTUdodHlIT2dsTTd0cmpGSVBmZjlMWmVHVEpz?=
 =?utf-8?B?dURmQjliMkhocUJqRnY0NGNZVmRpd09Cc3hxamcxZlZ0bUdhVU1sRUVNYzFp?=
 =?utf-8?B?SjBGcjFHdUtyOC9BZjBDQzF6ektvc2hYUjRrb3B3MStISjkzNnp4bUVCNlFY?=
 =?utf-8?B?MVpyM05YNkRadUlicXpEbHdHWllqRGxoYWNYSlBlTk5iMW1xRDB5YW1zcnM4?=
 =?utf-8?B?Zjl6anJkL3BIZ0RiV0phczhYNGk1U2V3QkRVNjJ3RStvNEk3SGJMZStnNEw2?=
 =?utf-8?B?b29reU1Wb3gxY2svWkRKSmFLUHdBTGdFSmNtNkZUVUVEYVVVSE4yM0IyTk5R?=
 =?utf-8?B?eXI1d3dRcXk4WjdNVFJXNDVkYjhWZTA0dUs0ZnlrdEY3OG5jNWdpY0ZBdElV?=
 =?utf-8?B?VzJCc05ZQnI0ODJ5UGtoRjFlVzBUN1pUYjVUM2pVVW5tQ3lyc0lkTEljeVND?=
 =?utf-8?B?dHZEbDdXcUtXWVRJK1IrbzEyMTVsdE53N2VaYTFPUnc0TUZnWEtoWENlNHNN?=
 =?utf-8?Q?YC2mb7zfqEBdzZKCUlWntVoI/Pmkz4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFlQeFRSdHlwVUtOaVg1SVVWeHdja1RzdU5LSlltblBkUCtvc08wN2xZRDR5?=
 =?utf-8?B?WlBRb1c5SFBwZWZzbnRhcXYxODNTa0sybk5RdUV6MlQwUWFSUWxjbTAzNFdI?=
 =?utf-8?B?OXJXenNxRjFCMTBSQWhMR3ZWK013NHNmcU1pQmxMWEhneEtjNWVHK3p4OVAw?=
 =?utf-8?B?UVFHa0RZNm8yNnNZV3VheDZjZ3VrQW0zY0lRdUk1MGFxMm5IZG5lbFY2SHJG?=
 =?utf-8?B?Q2ptMGpzUkZ2bm1KNGxWSTczOXRQL0QweC9NUVF2dllXb2xRVVhNTnpiRnpn?=
 =?utf-8?B?RnJHTVVqV0UvL0YvTlhCVWNpKzkxeFVGaEYrZWdNeWkvWXArOEg0bzdHT3lp?=
 =?utf-8?B?WDNYOXpWV2ZTNGhQSkxURERqb2xvT1k1QXBkaXRWMnkvR0NyNWc4NXBub2Zy?=
 =?utf-8?B?Uk9tN0xTNm9XV1FmclFPT2ExeG9XMWpzK1VNaHMvQyt1dWltMStzeWZrWUlx?=
 =?utf-8?B?eFdRODJKMU5MU2NjbUluek5RMXFlVCsyTmJBRmNwTmV1d3Y3UEFwUVJxNXpE?=
 =?utf-8?B?ZFJQYWJaalRFb1NLd2hBVHZ6UGNkdUM5eElZYkhoeEN2Mm9QWkFWYXM3cnJR?=
 =?utf-8?B?M2N2MGN1Z01kdWNyQ3JaR0xzZ1FxRXUyczMwZWtkNlFSSjkrcGZ4blJpcm9K?=
 =?utf-8?B?WUdUd0kzSjNTUURMQXNiek91MHBDcjlTK3V2MitGN3o1WG9GQzN3VlNIOHFJ?=
 =?utf-8?B?Tit2OXpmWTJsN29Ma1Bzblp4MjFPRGNaQnF2R2ErUzJteWdvVU03UVN0RnZM?=
 =?utf-8?B?cmY2ek93T0JRdzJGRFd4NTN5YlZheC9vckx3elZ2SWhCa1ZoeHpxSXZ5aWRl?=
 =?utf-8?B?Z0ZyQjBuMURnT1lLRWF3ejJtRm5uTTNDUU5PZnBPb3ZHbnlkVzhubWFWcHow?=
 =?utf-8?B?MmErU2VKWVRUUXcxTGcvM3VsZWQ1dGdMWTlNOFl6THVYMzQ0UkNLQVo1MU1W?=
 =?utf-8?B?Yi9OdlhiSE15eHdSczJuSEVvRi9FWHRIZkh1aGZKMkFRTS9nWnBvOUVBclJ4?=
 =?utf-8?B?eUkyQzRIR0hidWZvVHZ3bkVHQWhKbmUwUmpCdVhsWk5rcmFzY1ZZWlN1ZTdl?=
 =?utf-8?B?QzJxdDdEc1ZhcC8vM29lYmlZQ0p6elNJcGRCZ25RSUtLTGZlcFFVOHRSMGc1?=
 =?utf-8?B?bTdHdXoreFBVTU9YKzZTNnk4TE9iQ0grNVdmVkdmdVovcm84K05rV0h3TmZN?=
 =?utf-8?B?SlV1N0VmZ2ZlbHJieWxsTzFoUEVJVkNRTmhXeVE2d1ZHeGRUMTdtU1NqU202?=
 =?utf-8?B?bm9OU3hzdGd0V3hkUGx5RHBSRFRuMWdZcWlUKzB0cnpSMXJJYjRkYUV4dStp?=
 =?utf-8?B?QTI2cjY1MGM2SFdvRk1tOE83OTFQaUlLVEtFOGxBZ092S05rNmFnRytBM1Zi?=
 =?utf-8?B?emI1OUVFdGxjZW53OUpLWkIzZjRza3Z0OFRGQ2I4QkxCVFBxbkdyY0ViSzJp?=
 =?utf-8?B?ZTRRMGhvaTJOMjExTklrRnRiMjNnUVdZTi8vQzJ3RjVnLzk3bXpqbFh0N3J6?=
 =?utf-8?B?aCsyYjAxaktydEdTQUw2ZE05YTM0UjVjUnIvNTQwNUVWcjlnaTJoNFBxSTJJ?=
 =?utf-8?B?djArN1pwcm9SM1RZNHBlUDk4UnQyS0tRTWFROUdLN2VKakFwYXBMZUpZaEJE?=
 =?utf-8?B?ZjlPcWFQVzJjcGlhK0g3eW9CNnRLYjVaK3dQeXVDKzQzVVRxU3U4U2ppQnl1?=
 =?utf-8?B?L2FKME5KYWk4YnRNVWpWSnVDTzFMVWhVUFNDeC9ZeG1kM2RrVWFmMlArTlhI?=
 =?utf-8?B?MWRUSERBN3FGS2tuQ21kbVhtWStoakpQeTJoZHdMY20wWVZ0WmVRTTR0TG1Z?=
 =?utf-8?B?OFZ0eDFVNFVDMkhYN21ObmpoZmNsTk9KNE4zSFJBM00yMmE1SEJWVGZmRjh4?=
 =?utf-8?B?NDZsTjVGU0VZeVBrTndYdUZLUGpxbzluVE05c0NnQ2JYT01tOForL01nVUpv?=
 =?utf-8?B?K1pzNlQwMDF1aEtCSmlPT0VHOGhtaHd0Y2NTS01jNUY1aDhaZXh3ak9UMFdB?=
 =?utf-8?B?T256ZWpuT21iS2ZnMllsYlVjYk50Z0dkdG4zVlk0TjNQS1BiYmx6cVpVZTdJ?=
 =?utf-8?B?bkpnRzgwRVJmOEc5eFp0NUZaNUZ0ZDZ3MnBhWm94TDgwRi9rUnNkNitMQUNZ?=
 =?utf-8?B?eFFVUFRWWkUyakxyeFVBK1ovQjdibzd6ekZjdGY2MmJ2S1ZvakF1bzNwRVJo?=
 =?utf-8?Q?GyzEw+y2tM1olafZy5fj8Q8=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd76be57-953c-48d6-66e8-08ddd128f057
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 18:26:31.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnmOXaB5sL3z2THrzhv+bH3f3l8JYBhX5IMa2ogx3WpRhQnM75hmAnXKGtF/EghlJBXoElgOoqAjEL9VKOYWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE0MyBTYWx0ZWRfX/+pNlrH88haJ
 /ebYTmJn0ge6Ae34yXBMVRkr82yxPsqkrPrRXPUD1/SonHhpIakInJeOtwEo3TtLiIw4JgXU+Kh
 ATZpqu8GCZQZxe+XYQoGjy7QH8lJCT3t48pgtjnyuCcoQU+qkpuWqJEsrO8LW5dnxf4ECAedseD
 VG4N1/xm3ycqxkK7tAr0zFPcZWqRlxM3Bf9cTe9j7rBqa7TzvfAT91AcRmPFN1Cp8XcoAFViPHE
 2vU06ZZt4WGaqJUZvRNjjwr4gNRQai/Il/KuJHy1ZjIdObtS6VeeHimy7awc+9JcgoyCjGgmtov
 XcGvKEKHyc0TpmZeEhw3Q7Jo1nMQMA7tfuLCTUWLD9tskYQSkeMn0GW3GXILQ+/sARMtBMxReFi
 uRKmDpz8vz5dF1jJN7U4eW7+Gbk4/h+Ebd3uMQbqkeyO24yTOMzYh5j818hIxJTCqWC/ovwU
X-Proofpoint-ORIG-GUID: Qg2yoeSJaHmEUQFtqi0MBAUO6MvD6BRk
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688d06db cx=c_pps
 a=ZwOCfSBgJ6FT52HY8rp51w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=6_xc5hxnFEAcoja6hBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3bHf7z5wTBJVa9IjK7er1QlnYx1eYpXK
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F0B57CB94111409D0BD8161D994F6E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v4] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010143

On Fri, 2025-08-01 at 06:12 +0900, Tetsuo Handa wrote:
> On 2025/08/01 3:03, Viacheslav Dubeyko wrote:
> > On Thu, 2025-07-31 at 07:02 +0900, Tetsuo Handa wrote:
> > > On 2025/07/31 4:24, Viacheslav Dubeyko wrote:
> > > > If we considering case HFS_CDR_DIR in hfs_read_inode(), then we kno=
w that it
> > > > could be HFS_POR_CNID, HFS_ROOT_CNID, or >=3D HFS_FIRSTUSER_CNID. D=
o you mean that
> > > > HFS_POR_CNID could be a problem in hfs_write_inode()?
> > >=20
> > > Yes. Passing one of 1, 5 or 15 instead of 2 from hfs_fill_super() tri=
ggers BUG()
> > > in hfs_write_inode(). We *MUST* validate at hfs_fill_super(), or hfs_=
read_inode()
> > > shall have to also reject 1, 5 and 15 (and as a result only accept 2).
> >=20
> > The fix should be in hfs_read_inode(). Currently, suggested solution hi=
des the
> > issue but not fix the problem.
>=20
> Not fixing this problem might be hiding other issues, by hitting BUG() be=
fore
> other issues shows up.
>=20

I am not going to start a philosophical discussion. We simply need to fix t=
he
bug. The suggested patch doesn't fix the issue.

> > Because b-tree nodes could contain multiple
> > corrupted records. Now, this patch checks only record for root folder. =
Let's
> > imagine that root folder record will be OK but another record(s) will be
> > corrupted in such way.
>=20
> Can the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) be something other than HFS_ROOT_CNID ?
>=20
> If the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) must be HFS_ROOT_CNID, this patch itself=
 will be
> a complete fix for this problem.
>=20

You are working with corrupted volume. In this case, you can extract any st=
ate
of the Catalog File's record.

> > Finally, we will have successful mount but operation with
> > corrupted record(s) will trigger this issue. So, I cannot consider this=
 patch as
> > a complete fix of the problem.
>=20
> Did you try what you think as a fix of this problem (I guess something li=
ke
> shown below will be needed for avoid hitting BUG()) using
> https://lkml.kernel.org/r/a8f8da77-f099-499b-98e0-39ed159b6a2d@I-love.SAK=
URA.ne.jp   ?
>=20

If you believe that you have another version of the patch, then simply send=
 it
and I will review it. Sorry, I haven't enough time to discuss every movemen=
t of
your thoughts.

> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..d60395111ed5 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,8 @@ static bool hfs_release_folio(struct folio *folio, gfp_=
t mask)
>  		tree =3D HFS_SB(sb)->cat_tree;
>  		break;
>  	default:
> -		BUG();
> +		pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n=
",
> +		       inode->i_ino);
>  		return false;
>  	}
> =20
> @@ -305,11 +306,31 @@ static int hfs_test_inode(struct inode *inode, void=
 *data)
>  	case HFS_CDR_FIL:
>  		return inode->i_ino =3D=3D be32_to_cpu(rec->file.FlNum);
>  	default:
> -		BUG();
> +		pr_err("detected unknown type %u, running fsck.hfs is recommended.\n",=
 rec->type);
>  		return 1;
>  	}
>  }
> =20
> +static bool is_bad_id(unsigned long ino)
> +{
> +	switch (ino) {
> +	case 0:
> +	case 3:
> +	case 4:
> +	case 6:
> +	case 7:
> +	case 8:
> +	case 9:
> +	case 10:
> +	case 11:
> +	case 12:
> +	case 13:
> +	case 14:
> +		return true;
> +	}
> +	return false;
> +}

Please, don't use hardcoded value. I already shared the point that we must =
use
the declared constants.

This function is incorrect and it cannot work for folders and files at the =
same
time.

Thanks,
Slava.

> +
>  /*
>   * hfs_read_inode
>   */
> @@ -348,6 +369,10 @@ static int hfs_read_inode(struct inode *inode, void =
*data)
>  		}
> =20
>  		inode->i_ino =3D be32_to_cpu(rec->file.FlNum);
> +		if (is_bad_id(inode->i_ino)) {
> +			make_bad_inode(inode);
> +			break;
> +		}
>  		inode->i_mode =3D S_IRUGO | S_IXUGO;
>  		if (!(rec->file.Flags & HFS_FIL_LOCK))
>  			inode->i_mode |=3D S_IWUGO;
> @@ -358,9 +383,15 @@ static int hfs_read_inode(struct inode *inode, void =
*data)
>  		inode->i_op =3D &hfs_file_inode_operations;
>  		inode->i_fop =3D &hfs_file_operations;
>  		inode->i_mapping->a_ops =3D &hfs_aops;
> +		if (inode->i_ino < 16)
> +			pr_info("HFS_CDR_FIL i_ino=3D%ld\n", inode->i_ino);
>  		break;
>  	case HFS_CDR_DIR:
>  		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> +		if (is_bad_id(inode->i_ino)) {
> +			make_bad_inode(inode);
> +			break;
> +		}
>  		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
>  		HFS_I(inode)->fs_blocks =3D 0;
>  		inode->i_mode =3D S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
> @@ -368,6 +399,8 @@ static int hfs_read_inode(struct inode *inode, void *=
data)
>  				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_=
m_to_utime(rec->dir.MdDat))));
>  		inode->i_op =3D &hfs_dir_inode_operations;
>  		inode->i_fop =3D &hfs_dir_operations;
> +		if (inode->i_ino < 16)
> +			pr_info("HFS_CDR_DIR i_ino=3D%ld\n", inode->i_ino);
>  		break;
>  	default:
>  		make_bad_inode(inode);
> @@ -441,7 +474,8 @@ int hfs_write_inode(struct inode *inode, struct write=
back_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
> +			pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\=
n",
> +			       inode->i_ino);
>  			return -EIO;
>  		}
>  	}
>=20
>=20
> # for i in $(seq 0 15); do timeout 1 unshare -m ./hfs $i; done
> # dmesg | grep fsck
> [   52.563547] [    T479] hfs: detected unknown inode 1, running fsck.hfs=
 is recommended.
> [   56.606238] [    T255] hfs: detected unknown inode 5, running fsck.hfs=
 is recommended.
> [   66.694795] [    T500] hfs: detected unknown inode 15, running fsck.hf=
s is recommended.

