Return-Path: <linux-fsdevel+bounces-51958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04080ADDB38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA64402C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B8217F40;
	Tue, 17 Jun 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T6JIf9Ze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34512EBB84;
	Tue, 17 Jun 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184457; cv=fail; b=r0JDVqul7kdoWH/0MqMjR7D/2w6ZqpFXktovT02RaFWqXaUsHIxtqendHiBgVZiT6rIYH/DcNgyx7LAJNlR63TbVm4DjGEIW8EG1MLz7dxBr3hpa6SX7C9ob0pi9HjDOrK1j+3ZJsUy604o0XRWXGCLXqL2k9HEKlHLpFCML5u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184457; c=relaxed/simple;
	bh=k/An17L9PuXDi2osFYcQeoQL8ht1amf9NYBDqIXOgSc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Jx4QMFSTZBvjL5QfnmYSgWs1SL3DFXYvzoXNwmgSEUSgxTKvV/yiIFoI5pFnpLwn6ROiKRGf6ykJBJuguyiTlCmIA2xC4P88NzhXcWkz5KhHyK1pTr4ApnwBVYJ96xigt/GQMPkGcdKtqjNVLCwGRhuguw6+8Nm2Zml54qpLw6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T6JIf9Ze; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HGkWt4018030;
	Tue, 17 Jun 2025 18:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=k/An17L9PuXDi2osFYcQeoQL8ht1amf9NYBDqIXOgSc=; b=T6JIf9Ze
	UUxL9cpvHhNMi9qIGsVlqvdBveYiK1z0z88EPXAtAx98isuhfYMVsr+O6OKp8D91
	DmQSi43QEYdSZbRPmx6dVNLWPvo2JsMo1nxXzaB71JGVbKVT1d4/cReRz8pr76d6
	qrd3l+my41R4xghXna9Ipyu6R9kOlNUDVB92zkK/XIIIMt3sPFIRsX9aeSQuG8Gq
	VGu7B1e1am3nrB0nIyLJds+DjNjnJdbXEGdd8J9ZFUDexata0hT3qvo3diU3Is4l
	nF6xSzYtb4IU8qjbbQr05FUImA5+hECwn5fBr1mVuHgqrp9fQkbQ+sn5f87LL3P2
	cZFOfHX3it4uGg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790te28p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 18:20:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5Itow41IUefBwclNWNk3r6Ly6XBhm9CCIDDSZoEWXLzxDtiBaaAsuFtmD4J2lIeGG0bN+kTiId2q7XznhfgMPQtqYcwx3DJAunXrRMkztA6uPz6UFWKNPCUg9HxbjbX4uDTgOzfIMLwahgyDjaEqxdjOKSZk6xEhh3/A2AzpGvqTcxxS3P7dBv69iWQJPSYnEFXRS5BRMyj3pYh7roB9CZa7kAJ2XI4x2JiIacHs8eoK2ZN8USvlJtDIAx6JtvM7XfXKhOs3xrOAFJ2Y6Z5huHaWzDHwRp5h0eJ7eZ2D3ylIxZ9PqV6Y8AF53IvhmYimdtf3UQWIRst0uUF/07MSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/An17L9PuXDi2osFYcQeoQL8ht1amf9NYBDqIXOgSc=;
 b=Hfc8ffT5bSqZUQBtTKAHv7mBs59ZbovGtpQDa6RkY1BVbGNoUamg0xazrh7NZmSqMaPvp2VLH+mHJoqxe/GcQQqOI5dYdHEv/xc6MW17mtL4dOtOlJZVXMXRVosFaaRIMmjaqY+yI8c4jw5pMblQN4ygetNgl+eUA+DA6DiOACbm0/3P+sQ+W6KXCfZ4F3/kyPjNKbGe7p2tKkb7EX/uh1QzQViy6FwEb0YWg7QcBpHRMijZ5MtmQKwMze4t62h7pl4d0+Zc4SGj9QR5+lNXB27dnntRN/+O+vKEayS6BjPnCcNIOfhcHlHYBjlcbljO4hBBSYM6iJ49M+v0VV+gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5554.namprd15.prod.outlook.com (2603:10b6:930:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 18:20:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:20:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/3] prep for ceph_encode_encrypted_fname()
 fixes
Thread-Index: AQHb3PTIJEzMW5TiMEGk8IhK3VQKvbQHrzMA
Date: Tue, 17 Jun 2025 18:20:52 +0000
Message-ID: <0d15d93a7997037252cb20cfd71fdf5339142520.camel@ibm.com>
References: <20250614062051.GC1880847@ZenIV>
	 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
	 <20250614062257.535594-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20250614062257.535594-2-viro@zeniv.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5554:EE_
x-ms-office365-filtering-correlation-id: 1058c2c5-8f71-4af2-3928-08ddadcbb1ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2JadGwwWUM0NEt0dXpFOHNxaXNjcDJJWlh1clNjQjZyb1JaQnNOOUZEY0hL?=
 =?utf-8?B?cFdpTTRxWnk3NjJnamlRZzFkcEJjZW9keTRzMzZETCtBRldvc0E1Q3pBai8y?=
 =?utf-8?B?NkdyVENKSCtGTjgwSXFKNEVhN21rYm5VQmthY2xONGtUZzBlc1B5Z25aTGF5?=
 =?utf-8?B?U3ZxS1BGNEtXOTVFWXB0UDVxZk95d2x1WmpQMGVOSzlkQUdaREFXYkUvZS9F?=
 =?utf-8?B?RXJTMFhud3pnaWVzN3FCMDdBeWFLbmROcmtuSklyZHltRFZtb1VidS9ORHlJ?=
 =?utf-8?B?YmwxVzE0UmVPMldmUVkxRGRiYUZyMWx0UVJUU1BLK1ZZT2NoQmZwNGc4a294?=
 =?utf-8?B?VFNkVEVPR0hBdnpGcXBaMHlaWHFnZktEV25CVGtLd3pkaHNGMW1mTXlPaEto?=
 =?utf-8?B?MkMyM1RWZC9QYWp6NHBqejVxUUdGaWZadEdBdUJnaHpLeTFJMTZKTU1ydlJO?=
 =?utf-8?B?S3ZUN2Y1WmNiQ08vRzA5azM5azNUVHRMcjRlSDFrTis4bnNtaFloRjJtSTI0?=
 =?utf-8?B?aWtXSGJSOWU2K0xYRmxsa2g0WndtK0x2MlB2bWVjS0FhT0E5WHV5ZEtxWTNl?=
 =?utf-8?B?R1E2Q0toUXMwdXlPNWRQTWd0bjJVWWdES3Z0YzdRQXMySkdQTFY0dEtMZHl0?=
 =?utf-8?B?eFRjNWFFc1NtWDNob0tSRVMzSG1heC9KQXgyM1J5Z2QyOWxqbU1JdGZDVll4?=
 =?utf-8?B?RVFXNGd2MkF2L1p4bGY1aU92T3RwQUJJR2NQYUo2dlFaZHJabVBOMEhMVGlx?=
 =?utf-8?B?R1NjbmtKSjdnWUprcjF4UnVrSkRXQmp2WFhyNy9UTWJEQW1kZ1pIWmZyY2Ur?=
 =?utf-8?B?UytubUx5TFJrbWFvdkJSN0xqMTFrQVErTnJEMGVjaXdsbEhkcThabUIzLzFW?=
 =?utf-8?B?QVdoa012OStwcys0SmRBSWY2eEdIT25OSmI3UWlIK1A1MmJ6K2pmV1cvTXdV?=
 =?utf-8?B?RVl0aUQxWDBwaUFVdzBMRnRhUHhTSjlMcVNEOSs1RWsvVGQ1Y0xmY0pTdHU2?=
 =?utf-8?B?WnR1YjB5VUFzc2QzWGtmcjFRVGFtd1pja2J5cWlLWi9ZdWVZKzBTeUpUVWds?=
 =?utf-8?B?ek12Z0Q5OWkrb01QNkYwRWg0SXdRQzc2M281TmdPMFFkakozZmhHd2V4RTJK?=
 =?utf-8?B?TGw0dnpzcHJHaDVkUXBCWjRvTEQ1QzE2TWlOL1h1VjcvOE9jM1hBUVl6NkE5?=
 =?utf-8?B?SjZDVWk5b2dGQnZPaVl3bEVaSUhtWXdWdXdRS1N1VjBKOHFvbXhTRE05S1dM?=
 =?utf-8?B?VUpJQWRiUWFBVWlwcHFKUmdtckRRYkJScWEvcmRkVG9pNG1Tc0NJQXArVysr?=
 =?utf-8?B?eDgxcEYxcmhUeHZjL3Z4R1d5WDdrVHJwRU5FN2E4c2J4R1hQa1lsODdXSi92?=
 =?utf-8?B?bkY1ZFBCbkJ6ZTJ3b3pUbTNibTJsTnFaV21QdnZvRjIraGx6R20yK3FsU0lG?=
 =?utf-8?B?QUxWNDNvMjFGL1BrTk9aQmdxMXNBdDU3OHBqZGF3Q01rTWc2dGR3bUJ3ZWtN?=
 =?utf-8?B?N2tKU2NtaExEbXNEVW5Dc25PREkvMXAza3A0M1lIOXlDaW9nNnlIRDJsNWs3?=
 =?utf-8?B?Y2xHYzBLaFliV0hSUVQ1Q2pjQTVSOE9EOHdWOERRYlBHMDBzRXZDajBveGF5?=
 =?utf-8?B?SGJDSzhnTnhwY3U0R3BSQnZXckxNUmdXMzVTanBUZmM4MUJmTE52TzRBL1Jo?=
 =?utf-8?B?aUE1d1FVSFZ0bkFzR3dzS1dVRXZ5NXMvUFVubVJkdWYwRm01R0VaMWRmbHNo?=
 =?utf-8?B?V2t1dE5UMEdmcW1FYStianhsaEFTcjBSamJkaGVWQk1JKzA5VlZFUFp5M2R5?=
 =?utf-8?B?dlNxZDZYSU1RRGxNYWJ6VU45V0wwTmwvcXZnMjBXZ0tpdEkyZzJ2UFRpTHZP?=
 =?utf-8?B?T2luNmZHZWdlRURVUVlEbVY5d2JIaUVPYncyYTN2THAvVGZ5TXlrcXF6ZHhO?=
 =?utf-8?B?b2Nkd1FiM3h2emxzbHdUL3AyZ3NIemR1c3Y3QlFpMFNRc05GRTViN0RteE9t?=
 =?utf-8?Q?u6Mq3vpPWEh+7V4uba+w47k1gQDy9A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTMrT1ZsZTVodmUwd2daMlFlcGg0cjM5MUVXVlZ6b0RWNEpkZmZ4N1k3eVFq?=
 =?utf-8?B?Q3U1RS9sYWxuR09FVlJ1TG5nRm1kdldycnpnSi9DQXlTclk4YzN0VUxYL2Vl?=
 =?utf-8?B?c093bDFPMkt6cHpWbnpFanFHdXpqaDBsalo3WDlpTnZTdVZDZEcxd3U2Kzc3?=
 =?utf-8?B?enpXMTAreHpDK1dBZW41a0VRMUh3aXYzaFNSUDFUN25ZUit4VHJabjNTQVls?=
 =?utf-8?B?TitIU0hMZkVHNzVZbHh0WGtrS0N3WUxBSU56VkRTdSsyNXBOcjRlajdMQUwr?=
 =?utf-8?B?blRvV09Ya2dic2wwWElnOHc4eHdIbC9MMkFCT0JDNHJ6NTNhVlRUaFVDMVor?=
 =?utf-8?B?U3dULytlbGxBMjJRanRXbTNJR2VMWW16Z1hKSW03RHRFM2gzRWM3aUU5dGdo?=
 =?utf-8?B?ZUthd2FGK3RpUENlcWdabDk1MzVkYkcxc05zZnh3K0pwclFVMzgrTUo3UGZC?=
 =?utf-8?B?SCtyRnA3bkgxcXc2SzAvaUd1OXRRS25wWHpTaWZLeit4KzgxeFpydVk0cXVv?=
 =?utf-8?B?K3lMZ28rNHNjb1cxNzA0Z1JMR1VsLzNhcDFGVi9GTE50aklBZHRQYVcrNUsy?=
 =?utf-8?B?VC9nbmpZQVBPWFp1czNFWGYzVzg5VlNIUGZWdWVoK2FJblZ6WExvRDczeHhm?=
 =?utf-8?B?cktkQlM4b2tWVTJod2dNMC90d2duamNUNEdPM1RHUCtUUTFBeXozNVVFNEI2?=
 =?utf-8?B?Sm1SV3JvdWlvUVVxb1pZU0dRTzdmdUVBQnlCVnV5bjhPRUhId1NYMlVQOXNt?=
 =?utf-8?B?WHFrL0dRMFFyQmc5UmpSbHRlWkQ4NnU1ZXh2VndQQTBhRG56d2dlVWFNcml3?=
 =?utf-8?B?Q052UC9MeVlhNzVtdlZpQWVHSmlWM3lXU0tBblFNUXFuTUxWZnlVNG82cmhm?=
 =?utf-8?B?SWp2NUxwVjU1RDkzaTNibExodW1ONDBueTBXZzlpdVVpaWpMU2UySnBMbXRt?=
 =?utf-8?B?THFnaURXY2t5VGFyMHYwbFFZUzM4QmhILy9HMjdvSGErMkIyN2c1Smt2blRa?=
 =?utf-8?B?WlZLSnB4NUJxemlWS2d0SWdid1YzTXFBcnMwTFdhMWFaRHlEcXcwb2JGamZ1?=
 =?utf-8?B?T3RtRGMwcnh3alJBRkpkNjZGUUx4YTFZSXlScG43clBvbWQ1RXphbWN5djZa?=
 =?utf-8?B?WW1ITS9BbnRiN3ppdE0vTnpPOVd2bWRGcVU0RUxSRTEybkQxSmhkcEJqNEZv?=
 =?utf-8?B?WDdTNE9DNW92Z1V5UTAzUEJBa0RjeFphL0tVcXJIMEh5QWxQNC9UNEthWkd5?=
 =?utf-8?B?emxNajQ5QUxIamIzNXNZQlhweGRML0YyVUVENVlTb0tUeDFaZFRiMEUycTZI?=
 =?utf-8?B?R054YVNPVHVudVBaVmdJSHlBZ1R4czZwMjBjc1lqRlZKNWZsSThPbG5ZdXhM?=
 =?utf-8?B?VnNxc0MzVXNaek55WStkMWtvQlB3TjVBb3loMkZ3dWVOUU9hYkFmaTNvQXhq?=
 =?utf-8?B?cnNXSDM5TlREazNjOHBtdExCM2hjRTg3UFRHQXZKR3pzbzdZSWFqT3dLbjhG?=
 =?utf-8?B?c3pENm41TWR0ZXR4VFQ5dVlYSlgxeks4N1FGTEhhakZycFBGdE5BVFZrOVlU?=
 =?utf-8?B?VWxCUjhFeit1UWoxdERiaG95SmkzSHMvL1ZQcEVIUDhaTElJRElUbnFzLzRk?=
 =?utf-8?B?d1liK2QzaG5BRHE1ekRYelcydHE1K3kwVmp0cXJ1bDRxYUxmMFJ4OUMzSE5y?=
 =?utf-8?B?dVQyNU9GWmdjcUlTalAzdklsVkxBaFhNVzMxdVRGVXZCYzBab2s3Ky9pVGNn?=
 =?utf-8?B?azRVVDg3cEJZZzNVQ3hHL0lUTUV1ZFZHTERaSlMwSk1KQ2VlZnBUUUZZbFI0?=
 =?utf-8?B?QkZRbU01RXpORWdMRG0xV1dlVDJyaFJGOTcwZmJRbHlTZU00OWFHRjExdzRq?=
 =?utf-8?B?U3V6dkJJSktjbC9RN1hKMHJlOWlQUGtPRnAzMmdaNTBlK0FJRytMVEkzWmlY?=
 =?utf-8?B?ZlNYSEVlbDNsdTRjaEt4bXUxMTdqY28rdTdNY1dFT3J0Z1lCeTB0WXRRbHFh?=
 =?utf-8?B?OGVBT2xDR0pOMjVqdUdyWCtiQ29CNTFha0NRL1VCdWprWk0rL2hIbTJaU3FW?=
 =?utf-8?B?KzR6RjUrMUdQS3cwQWI4ZnpOWm9YMjhIM3hnSjE5VGptclBrZXhGOUkvZGFG?=
 =?utf-8?B?ejRQYjlKTDFEQmhjT0tzcjFzcUZZSTIxa0wrK0ROZFczMUVVOURkTlE4WXBh?=
 =?utf-8?Q?onNDAwDYaYVMzD2+nApZnag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5C23F39E1C5004E9F5F58838EC6935A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1058c2c5-8f71-4af2-3928-08ddadcbb1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 18:20:52.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GvBLCM/5iAnOFAlWZztafoHeP1qL1LPuP0yaz4lodRWudVFzSwv8TBhOF9PrOay1RltpR4GsK+TJNoo+5EzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5554
X-Proofpoint-ORIG-GUID: BZetifmAdmRbPnkKvgn2PxI2ivxtUnUz
X-Proofpoint-GUID: BZetifmAdmRbPnkKvgn2PxI2ivxtUnUz
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=6851b206 cx=c_pps a=Uo4aFAHIxFRcms0b5QyC6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=QQsNdw10hod4fGk9vjIA:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE0NiBTYWx0ZWRfXyG0t6UDvOKwD MzrtTO8w2gDCloK1DEmhnqD1TZzU1KgU2ThNVh2MLVteE+NU9Z5RlrMUCXHl6uvaXcaqzDy/wWJ F/hBorO4Qt16JAw1GFA1bXmFfpshnzaj/j3q2hOK2CO0IhkZVoF5D5+JbWuXtaIGphA+PNKOKtP
 6ZROhaQCT6Uhn4iI2TIg2k2KaFYD3odai72mdELH5FVKAXP++qby9y4HDL+AoLG8MptuYTXvkgS Be1Cna76lZtIQZnezevzJXPDV3zra2hSne+CbmQafVZlX0YGbMKaLVU3H1S5Mz7PBTipG7cHIVc AGNGgCsFW6ySsYZLzGB9XZcGZ7k6YbG8LyEg/FplGegPgXnTrfbk0n2tx8e/6fmECxVmlRZ2WMj
 E/faEg+v5QTwZt8oOnRZlZh7aVAFPK2qj/Z1r+Mt5Wpff5VXBZ+2fY1jb6HFItxNP5uf3Qur
Subject: Re:  [PATCH 2/3] prep for ceph_encode_encrypted_fname() fixes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170146

T24gU2F0LCAyMDI1LTA2LTE0IGF0IDA3OjIyICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBjZXBo
X2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoKSB3b3VsZCBiZSBiZXR0ZXIgb2ZmIHdpdGggcGxhaW50
ZXh0IG5hbWUNCj4gYWxyZWFkeSBjb3BpZWQgaW50byBidWZmZXI7IHdlJ2xsIGxpZnQgdGhhdCBp
bnRvIHRoZSBjYWxsZXJzIG9uIHRoZQ0KPiBuZXh0IHN0ZXAsIHdoaWNoIHdpbGwgYWxsb3cgdG8g
Zml4IFVBRiBvbiByYWNlcyB3aXRoIHJlbmFtZTsgZm9yIG5vdw0KPiBjb3B5IGl0IGluIHRoZSB2
ZXJ5IGJlZ2lubmluZyBvZiBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoKS4NCj4gDQo+IFRo
YXQgaGFzIGEgcGxlYXNhbnQgc2lkZSBiZW5lZml0IC0gd2UgZG9uJ3QgbmVlZCB0byBtZXNzIHdp
dGggdG1wX2J1Zg0KPiBhbnltb3JlIChpLmUuIHRoYXQncyAyNTYgYnl0ZXMgb2ZmIHRoZSBzdGFj
ayBmb290cHJpbnQpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWwgVmlybyA8dmlyb0B6ZW5pdi5s
aW51eC5vcmcudWs+DQo+IC0tLQ0KPiAgZnMvY2VwaC9jcnlwdG8uYyB8IDQwICsrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQoNClRlc3RlZC1ieTogVmlhY2hlc2xhdiBE
dWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBE
dWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0KDQo+IGRp
ZmYgLS1naXQgYS9mcy9jZXBoL2NyeXB0by5jIGIvZnMvY2VwaC9jcnlwdG8uYw0KPiBpbmRleCA5
YzcwNjIyNDU4ODAuLjJhZWY1NmZjNjI3NSAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9jcnlwdG8u
Yw0KPiArKysgYi9mcy9jZXBoL2NyeXB0by5jDQo+IEBAIC0yNTgsMzEgKzI1OCwyOCBAQCBpbnQg
Y2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBzdHJ1Y3Qg
cXN0ciAqZF9uYW1lLA0KPiAgew0KPiAgCXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBjZXBoX2lu
b2RlX3RvX2NsaWVudChwYXJlbnQpOw0KPiAgCXN0cnVjdCBpbm9kZSAqZGlyID0gcGFyZW50Ow0K
PiAtCXN0cnVjdCBxc3RyIGluYW1lOw0KPiArCWNoYXIgKnAgPSBidWY7DQo+ICAJdTMyIGxlbjsN
Cj4gIAlpbnQgbmFtZV9sZW47DQo+ICAJaW50IGVsZW47DQo+ICAJaW50IHJldDsNCj4gIAl1OCAq
Y3J5cHRidWYgPSBOVUxMOw0KPiAgDQo+IC0JaW5hbWUubmFtZSA9IGRfbmFtZS0+bmFtZTsNCj4g
LQluYW1lX2xlbiA9IGRfbmFtZS0+bGVuOw0KPiArCW1lbWNweShidWYsIGRfbmFtZS0+bmFtZSwg
ZF9uYW1lLT5sZW4pOw0KPiArCWVsZW4gPSBkX25hbWUtPmxlbjsNCj4gKw0KPiArCW5hbWVfbGVu
ID0gZWxlbjsNCj4gIA0KPiAgCS8qIEhhbmRsZSB0aGUgc3BlY2lhbCBjYXNlIG9mIHNuYXBzaG90
IG5hbWVzIHRoYXQgc3RhcnQgd2l0aCAnXycgKi8NCj4gLQlpZiAoKGNlcGhfc25hcChkaXIpID09
IENFUEhfU05BUERJUikgJiYgKG5hbWVfbGVuID4gMCkgJiYNCj4gLQkgICAgKGluYW1lLm5hbWVb
MF0gPT0gJ18nKSkgew0KPiAtCQlkaXIgPSBwYXJzZV9sb25nbmFtZShwYXJlbnQsIGluYW1lLm5h
bWUsICZuYW1lX2xlbik7DQo+ICsJaWYgKGNlcGhfc25hcChkaXIpID09IENFUEhfU05BUERJUiAm
JiAqcCA9PSAnXycpIHsNCj4gKwkJZGlyID0gcGFyc2VfbG9uZ25hbWUocGFyZW50LCBwLCAmbmFt
ZV9sZW4pOw0KPiAgCQlpZiAoSVNfRVJSKGRpcikpDQo+ICAJCQlyZXR1cm4gUFRSX0VSUihkaXIp
Ow0KPiAtCQlpbmFtZS5uYW1lKys7IC8qIHNraXAgaW5pdGlhbCAnXycgKi8NCj4gKwkJcCsrOyAv
KiBza2lwIGluaXRpYWwgJ18nICovDQo+ICAJfQ0KPiAtCWluYW1lLmxlbiA9IG5hbWVfbGVuOw0K
PiAgDQo+IC0JaWYgKCFmc2NyeXB0X2hhc19lbmNyeXB0aW9uX2tleShkaXIpKSB7DQo+IC0JCW1l
bWNweShidWYsIGRfbmFtZS0+bmFtZSwgZF9uYW1lLT5sZW4pOw0KPiAtCQllbGVuID0gZF9uYW1l
LT5sZW47DQo+ICsJaWYgKCFmc2NyeXB0X2hhc19lbmNyeXB0aW9uX2tleShkaXIpKQ0KPiAgCQln
b3RvIG91dDsNCj4gLQl9DQo+ICANCj4gIAkvKg0KPiAgCSAqIENvbnZlcnQgY2xlYXJ0ZXh0IGRf
bmFtZSB0byBjaXBoZXJ0ZXh0LiBJZiByZXN1bHQgaXMgbG9uZ2VyIHRoYW4NCj4gQEAgLTI5MCw3
ICsyODcsNyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAq
cGFyZW50LCBzdHJ1Y3QgcXN0ciAqZF9uYW1lLA0KPiAgCSAqDQo+ICAJICogU2VlOiBmc2NyeXB0
X3NldHVwX2ZpbGVuYW1lDQo+ICAJICovDQo+IC0JaWYgKCFmc2NyeXB0X2ZuYW1lX2VuY3J5cHRl
ZF9zaXplKGRpciwgaW5hbWUubGVuLCBOQU1FX01BWCwgJmxlbikpIHsNCj4gKwlpZiAoIWZzY3J5
cHRfZm5hbWVfZW5jcnlwdGVkX3NpemUoZGlyLCBuYW1lX2xlbiwgTkFNRV9NQVgsICZsZW4pKSB7
DQo+ICAJCWVsZW4gPSAtRU5BTUVUT09MT05HOw0KPiAgCQlnb3RvIG91dDsNCj4gIAl9DQo+IEBA
IC0zMDMsNyArMzAwLDkgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3Qg
aW5vZGUgKnBhcmVudCwgc3RydWN0IHFzdHIgKmRfbmFtZSwNCj4gIAkJZ290byBvdXQ7DQo+ICAJ
fQ0KPiAgDQo+IC0JcmV0ID0gZnNjcnlwdF9mbmFtZV9lbmNyeXB0KGRpciwgJmluYW1lLCBjcnlw
dGJ1ZiwgbGVuKTsNCj4gKwlyZXQgPSBmc2NyeXB0X2ZuYW1lX2VuY3J5cHQoZGlyLA0KPiArCQkJ
CSAgICAmKHN0cnVjdCBxc3RyKVFTVFJfSU5JVChwLCBuYW1lX2xlbiksDQo+ICsJCQkJICAgIGNy
eXB0YnVmLCBsZW4pOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZWxlbiA9IHJldDsNCj4gIAkJZ290
byBvdXQ7DQo+IEBAIC0zMjQsMTggKzMyMywxMyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVk
X2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBzdHJ1Y3QgcXN0ciAqZF9uYW1lLA0KPiAgCX0N
Cj4gIA0KPiAgCS8qIGJhc2U2NCBlbmNvZGUgdGhlIGVuY3J5cHRlZCBuYW1lICovDQo+IC0JZWxl
biA9IGNlcGhfYmFzZTY0X2VuY29kZShjcnlwdGJ1ZiwgbGVuLCBidWYpOw0KPiAtCWRvdXRjKGNs
LCAiYmFzZTY0LWVuY29kZWQgY2lwaGVydGV4dCBuYW1lID0gJS4qc1xuIiwgZWxlbiwgYnVmKTsN
Cj4gKwllbGVuID0gY2VwaF9iYXNlNjRfZW5jb2RlKGNyeXB0YnVmLCBsZW4sIHApOw0KPiArCWRv
dXRjKGNsLCAiYmFzZTY0LWVuY29kZWQgY2lwaGVydGV4dCBuYW1lID0gJS4qc1xuIiwgZWxlbiwg
cCk7DQo+ICANCj4gIAkvKiBUbyB1bmRlcnN0YW5kIHRoZSAyNDAgbGltaXQsIHNlZSBDRVBIX05P
SEFTSF9OQU1FX01BWCBjb21tZW50cyAqLw0KPiAgCVdBUk5fT04oZWxlbiA+IDI0MCk7DQo+IC0J
aWYgKChlbGVuID4gMCkgJiYgKGRpciAhPSBwYXJlbnQpKSB7DQo+IC0JCWNoYXIgdG1wX2J1ZltO
QU1FX01BWF07DQo+IC0NCj4gLQkJZWxlbiA9IHNucHJpbnRmKHRtcF9idWYsIHNpemVvZih0bXBf
YnVmKSwgIl8lLipzXyVsZCIsDQo+IC0JCQkJZWxlbiwgYnVmLCBkaXItPmlfaW5vKTsNCj4gLQkJ
bWVtY3B5KGJ1ZiwgdG1wX2J1ZiwgZWxlbik7DQo+IC0JfQ0KPiArCWlmIChkaXIgIT0gcGFyZW50
KSAvLyBsZWFkaW5nIF8gaXMgYWxyZWFkeSB0aGVyZTsgYXBwZW5kIF88aW51bT4NCj4gKwkJZWxl
biArPSAxICsgc3ByaW50ZihwICsgZWxlbiwgIl8lbGQiLCBkaXItPmlfaW5vKTsNCj4gIA0KPiAg
b3V0Og0KPiAgCWtmcmVlKGNyeXB0YnVmKTsNCg==

