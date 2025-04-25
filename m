Return-Path: <linux-fsdevel+bounces-47309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3DA9BC1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99534A3BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499717BD3;
	Fri, 25 Apr 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ns8LHUCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DD35958
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543200; cv=fail; b=ds/yqaDHSI85Ah1pTg5vX/T9W2fkiM3ogEviQnF2zYJhMj2Pkzvok4CBPDkwSpqu+3gQ6ci/+iMeWTLyEsFZbxE8LLZE8sRjQo5az3h7QU6si2iI3MSnNb5br9KLzigfA0LdW2PJ4Efj7GgYGchLPV3y8XthfK0NkjbE+HCdTBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543200; c=relaxed/simple;
	bh=wFQLkD2TqZbhttJt5zCQDwsBrpP3zxs/QVNFPNizZOU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=emNb+9d9T1UtuRs0jr7kinCYZTJqwgd+xtZKnlb+ZEXgZC76o58KWQwMQplk/nYj8iYqpH1XmsYVzu443dnUH9wAfEKGPBlQ5ZjcjRO+XZQY49nk0UXl1IlcFS1Q9HpZoydRiocRJt+8PB565TxtfpkLR2FS4UuzRcF2oT2AiR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ns8LHUCx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OLdRTb006660;
	Fri, 25 Apr 2025 01:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wFQLkD2TqZbhttJt5zCQDwsBrpP3zxs/QVNFPNizZOU=; b=Ns8LHUCx
	LP5n48JYAmP2l2pUOPfqq1O5YU8GleOcPO487RSJiPoAA1pYmo4shZVTnNNWSE38
	Z1ClMPlrGqd3Kgtu84EhB6Y/Mx28fpsJJ2GYQME1OMxV6J00O+csTuE6bVRH4MrG
	K1iVylnmfDQrfksCtvKNzCTxSmeJ7HlDwHonWgMv5Y6voMzLuNVCMjXGGjlc5eRN
	33+w+xF+PrlKjNihwRFlMttG6One3YZ2KlE6IutI4Yq8guWIdfbGpsRQRvwUyLlj
	eM3rCqIJOUQTELAyMt2V/EsJNEd4wHZUKzypNkkm4yddZuZChO2s7l044zpY00jV
	hckgieXt7vDLgA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9gnpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 01:06:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB0Pn4bGlqY/Q70L7ZtUc/CCkxTHy32EYXb6B1DmtlijE0dvuuOHgSQk5t/DHxFUBLBE4298YSKg2mZ3B7pzANbdpvVzijVmtLwKOPjURiGboyVz2CurBiYwqki9zot0GnmocolZ/fZ2fWZQ5UOOpWPH1nQVz7kBfAMoFnt+w+09XlvAYL1EFsqvlz/Or4BrvADAKQvNX3ka6S8YN7mJWrJw0T0OI3aEpn6r8kpvFdRZTDkNJXwI5gV36D98eGB8EIYB558fKi6R2cvHEs3yZuQCYj43wxzHZdJF2eRCDmvLOsN7UDs6kQt8kdu6sf0DLMfIav5nVWLThjCOXclXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFQLkD2TqZbhttJt5zCQDwsBrpP3zxs/QVNFPNizZOU=;
 b=jqyZgQGhSzD6ZLo10LBqqdjCu/QU2PC4YhdzW1PKbPj1iLxJKoySFzBZtMOvp9ErgiveAblZxC3KVYmeq3r71qfIPeP2GDpzxzHF3hPBEadMHa46ykXlvGkrzdlCZUdb504dENvg0hCLGUo07VIhKUJcCyRKwBbAB557dnQnCUPeOsB3IDC8xetk0pY9BohxqwUY6YifdsoUKm1/b9u3WdE/R8Yhn6ffehBYwkwiHiIl9HPcMEHk12MSum/zrQrv9ig/4Sr4m2Phv/vR5DfhvrBSrd85exMjgxnBgIx2uLCma2YLeMyOePJAkMZyA9JTma4jNiV/JOWfWW78hPBUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4529.namprd15.prod.outlook.com (2603:10b6:806:198::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 01:06:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 01:06:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Thread-Topic: [EXTERNAL] Re: HFS/HFS+ maintainership action items
Thread-Index: AQHbswekna2OCwxWoE2e/XeZ/ACbe7Ovn+GAgACQiQCAAAnhgIAAAEsAgANb3oA=
Date: Fri, 25 Apr 2025 01:06:23 +0000
Message-ID: <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
References: <f06f324d5e91eb25b42aea188d60def17093c2c7.camel@ibm.com>
				 <2a7218cdc136359c5315342cef5e3fa2a9bf0e69.camel@physik.fu-berlin.de>
			 <1d543ef5e5d925484179aca7a5aa1ebe2ff66b3e.camel@ibm.com>
		 <d4e0f37aa8d4daf83aa2eb352415cf110c846101.camel@physik.fu-berlin.de>
	 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
In-Reply-To:
 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4529:EE_
x-ms-office365-filtering-correlation-id: 4fade8a5-4c09-44a4-a733-08dd839565b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDB2cXFvYWJJVFlRb2lFRXB6MXpOQnl5eW9YVGo1L3E5UWtqZnhaRlhiQnpa?=
 =?utf-8?B?UFBUdW9CRURvU0s5cnFZMzZEOEJaOGg5SGc1V2p5MDJIcGxYK1NhNmdIVFVZ?=
 =?utf-8?B?dmlzZG5rRDVMT2RSd05TemIrSEk0SHp4UEJZWDMzU1U1RWV4dml2T2crUlhH?=
 =?utf-8?B?bkFFUmJjRTZPbnVZc1NURHhldVhXYjVWN0hWV0xKS2ZXUE0rTFh3dmEyRGdV?=
 =?utf-8?B?SjNlR0FuNVdwRzVrdDh6b05vZFRyazBsZ1liTGh6UmFSSjVvVmwzU2F1TmZO?=
 =?utf-8?B?dDUvZUdZU3VBRVloQUNGRVBaRXdWaFpXOVI0T3JyZ1d0N1lHRHFodUVPZUFp?=
 =?utf-8?B?TWQ0UTBhS3BVbEN5R1BFUkpia2I2NEx0a0FJRm5uT2ZJaithalZ5S0ljKzho?=
 =?utf-8?B?c2xnME1Ud2xlc0NUTnVMSW9vM0oxMlkxdEpVRnltcFhWenFzS2ZnMi9JMkpi?=
 =?utf-8?B?b0I5RzNKcDVQTi9OSUc0VmxockJQVVZLekwwMzBKeklIRHlOSnlPQVM1UHVJ?=
 =?utf-8?B?WWdJODl5MUFjOE9DKzJhcDV1L3k1aHQ3ejhuL1JVQzFURUdyajg4UFptSVh5?=
 =?utf-8?B?bWlqMXJTUnMycUkrVFQ3dkpBZ0RxVk41Q2RJWmV6ekI1OE1RL1JYNUw3Wmk5?=
 =?utf-8?B?RWQ3emZ3K3NHTWFYZnUyNEtiMTF0bXBPRndOcFV1SGVCWWFQODBHNStjZHRp?=
 =?utf-8?B?RHgxS2F6N2xERmJ2TjhpWDFvWDFGeGJSQ00xK1FsUFM0WEltNm1kQjAxeEJD?=
 =?utf-8?B?WERSaGVJekdUU2hyNDNSdExBUDFKZHlZRGlwbkVCMiszeUhnYW9GVVdWREtW?=
 =?utf-8?B?UE9aUGM4SGY0M0Z0U3UreGFpeExjenFmTW5hS2xpWTVKY2gvMG01OHpQNXNJ?=
 =?utf-8?B?d01GaHpEUWpnbXVEcDR2VEJqakJ6NHMzTnk3RmVFM3c3VmtDMVJqQWNVRThH?=
 =?utf-8?B?aWJ1NmJ6UC9UTDk4a0lMSExlc0pudyttQ2syKzVDa3RDNHcxcDNrcUxoczhw?=
 =?utf-8?B?NzVuM0dFbnRWaTJsRk5lRDF3REhES3hWbnVaYXp4M0NlUlQxbUxVM254eGF0?=
 =?utf-8?B?Y3ZWdHZjYjFYcndmYzVLVU1jRHJLbFhGa0ZMZ0swVnpwdm1nc0ZDNjFDTXRk?=
 =?utf-8?B?QWZiVkQ3YmEzK0l3MFNHYWRGeHA2WVNMb2s5S1F0TXBTSzA5eDg1MWlha25E?=
 =?utf-8?B?OXZOTlZsQm1WYWNjaEJDNUVrZzVmaUFZRHlYMGNYVTRQUXFZNmp0VTZSdGht?=
 =?utf-8?B?WXFJc1JpVDlmdTJRYlV2UW0zVnVFUU4yTlpzWDlvRDRsS0lYTUZYbFpzWVox?=
 =?utf-8?B?VlpwU0RKUFFmWHBGYm8wb3p0NHg4eFIzS1p4YklaeTJudTRSTFhaUGtOY3RZ?=
 =?utf-8?B?SVZTSTBuWHJtMG1Bb1FLVHBJOTNFeTRmUjJhMlVTWVEzZHp3SGpyWE94ZjRp?=
 =?utf-8?B?dE9hUU94RDQ5d1pzd2J2U0FDbFhuZWsyMW5IY1FUTDYzRXJHbzhsczVydVBX?=
 =?utf-8?B?cFNEOFZxU29TSFZqOURqSW9hLzhqSVU0UGp3b3JWWGdDT3lrdGJZMU12YWpJ?=
 =?utf-8?B?S0VMUTVaUjV1a1NnK3YwWnhjSUUzZU9odEFzSVRjMHpDbTNPV3VBUlBMNUlj?=
 =?utf-8?B?TStZUENZZElHeWFFcFlDWDFRVWtQMnJQZTZXNDFzOVNOU2JsVnd1NHdVaERJ?=
 =?utf-8?B?NWNMMGw2a1RBR1I5a3h5N2MxSXBvQ2M5bUp1MjhvWGplWU4xeW9ZUmtWSXV3?=
 =?utf-8?B?UTg3Mi9OOEcvMC9LVnQ4eC9lc3FVcHdxcjJQUzBudTlQdXpvcmpCQnZaWTQ1?=
 =?utf-8?B?M0hYSWpnTCswczdaVjEyUzkvMWJhT3BoRVZsSGNnd2pwczZUVTN1TkxsQUla?=
 =?utf-8?B?Q1RmejRZYjhwVzRUcUVhQjdkQUplZVdDWkxoOTVGSE9pQmhxMWhpdHByNVhz?=
 =?utf-8?B?aW03MjRDbFVnTnZ5c2pWeUIxbWRFcUgxNHl4Wmw1Qm53MWc3TmdoRkpIQ0dN?=
 =?utf-8?Q?vAgEciP9s/+3v/HTvd41wBgldidOb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1JPRzd2dm4rNHpBVXZ0TTZZaUZ3V1BsQ0xDYVovUzZZREJpZUdmNWhvNXFl?=
 =?utf-8?B?S1YxS3VXcDFFYWdQSkxGcjlTQ1V3MnlkdkZ3eUc2UjlEU1BFU2xlTzNLRFRW?=
 =?utf-8?B?QU1kaVIwN1pxZk9wZzlyYWExMkYzM1ZMRVhzTUZON1hFQ2dhdmJocWR2bXR1?=
 =?utf-8?B?YlFCMytQQjdsblBBTVkyZVJ1SVp5Q2RvUFJldk8xM2ZJZ1dObnpRMFZiVTFD?=
 =?utf-8?B?VUxNOWkwMG02ZDV2Z2NObElYVHVKYmsyci95S0NNMGZlMU13T2lwdytCM2dh?=
 =?utf-8?B?QXJVMEw2SjNFdEJMMW1pbEFnRzllRGxSR2VGZnF2K1FJUjhzNXNHSVM4MDdn?=
 =?utf-8?B?Y3lqQU00SU0rL052dnl4V2p0dVBXcE5Xd2VtVFRyTDdVU29HWGdEd0QvZ1pP?=
 =?utf-8?B?R3RqNjNrSTFZbUVoTWpiUENhRVNHVlZISS9FcFFEUFZGS0VFeStERkRFeHg4?=
 =?utf-8?B?MDM3Q1oxWGRBeFhNUXdNSGI5eUU2RGxSelJUa09LRURHTEV2S2Q5bEtsYXZC?=
 =?utf-8?B?K0pLQ3pyS1JFK3RBTzdIZzk0c2ZUZHZHZ1lSNGUwYmw5ZlBONXRrS3UrcUo5?=
 =?utf-8?B?NXk3NEFpMU1NOHNObjhDdG9wcy9NSjdtcUtLYWJoTytTMGFtOVMrdVcrdExO?=
 =?utf-8?B?cWZKbXhCVW9aMnBZQ0hUbTZtL09hMFZvYjdkUWV2emZ1U25Mcm1VZFB2eUlZ?=
 =?utf-8?B?TW5JeEFveExEdkhQb1ZUbWpFTUpvRXB2bkdvVG80OGxOdzRoY2hDRmdRbmJ4?=
 =?utf-8?B?REUzeFRmdVRweVJyTG4wNGIzOEJYU2k2WC9PM20yMVJ3b3hUcFlGOTlBd3ZQ?=
 =?utf-8?B?cnJid2JUTXhyTzFWVDBRTEpyUWs1TlBEZHJLcEVhSWtsSkdaWXpkei80YTNK?=
 =?utf-8?B?cnBFb0NHcVp3NUpXZmhFWHJhYlkzQ2xJMEtubG9ueVFES2d0b3dadzdsNm03?=
 =?utf-8?B?bHNCODVLL2d0K3JzNE1aZGs3MVR2QlRnNzhiUFlNVUl3K1M3U25LWW9UblBR?=
 =?utf-8?B?d0o4NW9ZSk1rRXpORFk1WjEzRFRhUWc2K2hlckZNNDhpUDQ3TVpQRmkycVlv?=
 =?utf-8?B?OHhNcXJqVzc5bGxpMEMxSFE5KytIVlhKNlk0M1FmWUlwMTdsRFFMcVJCNCsr?=
 =?utf-8?B?Qm4yWEZOSjg2dkNORnRUY2dZZTNQREhRQlFYY1FPN08wenlNVGJjaEVuMVp0?=
 =?utf-8?B?N1FXcURwM0ZUQXovd2tNaTZPdER1R29QMWdoOW05elZ2WW1xV3VYSU04TE5x?=
 =?utf-8?B?MjNXc3NFK1ZLKzkwWHNYaTFOZ01kMGI2RGhpK3ZsSlpkUUNwdkljc3didHU4?=
 =?utf-8?B?WE1Ea0Rybmh4ZnFyL3FaUVhUSVMzMlZoZVBWd2dGZlhpYkM0WlNnaXF1OFdI?=
 =?utf-8?B?M21BZ0NPL2tFZ1h4MTZtQmhQSUVzK1V1dTRKdjJheThFenF5cEgrUEladUlj?=
 =?utf-8?B?bWhoVWJSaXBtVGUxclRVTVI2NGY0eENVVVEvNkdkK3FEK0ZSRk5FRWorMzVZ?=
 =?utf-8?B?NjYzdnI1cGl2enAwS3gzQUQzWmt3UEx6Q3JEREh1VlZXTUVaUnJRM1ZTNldK?=
 =?utf-8?B?ZzlpOWZaNGlSd0RUMnJrdStYUHhsL0Yvd3JhWFNqWWpUdWEwNnF3OERNTk5G?=
 =?utf-8?B?YXNiLzEvRnRUWnVvbngwMG5oWEtDQUdXK2EzS2tkVzQ0WlVONUJ3eVV2QUtj?=
 =?utf-8?B?TnByNm5nNkhXdFFrUFFyaDZCd2lxNmwrR2Rzc0hZMXpCY1pzVlNyMC9MeHJw?=
 =?utf-8?B?dEtra2JYYTZpTmJkL3FCNk5HWkREMVZ5bElzbVI0NHZZd1BtWHBOMFJ2RGhC?=
 =?utf-8?B?MVJ6OEhPS3E2MEREVklzNWxhSEdvZlNNajFRL0NpbDB0bXMyRlRwWlJVbVdx?=
 =?utf-8?B?d1BFVm1DNGF5STJKL3FYNkNSQmdGZUlkSHEvanpOVmdIZ21ydVBEclprek5o?=
 =?utf-8?B?cEh2K1QvcTB4amtiYnVUalVhTnlpVmdGUjE4dmNGeWsrUTFkUnpOUHV6RzFQ?=
 =?utf-8?B?SFFWSU8raktGSXZQeFJCTnBrd1VyUUhib0lVbUpwL2pWWlpQa3AxbzkrSTFl?=
 =?utf-8?B?aVV1c2RUanZ3Q2Q5L3k4WEo0Z3djMkYxd3c5T0NZdWNtOHZsMmhQT2kzUVc1?=
 =?utf-8?B?VS9HZ05zcmtleTE0SjEybDFmNFE4RUppMlpNMDVMcG9POE9DRXRCK0s0bjRU?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9823F2C16C45F245B5BA956F3D667A2E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fade8a5-4c09-44a4-a733-08dd839565b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 01:06:23.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOfs5SgP3qd/ZZa2w2TFlt73o+Nk6ysstc8Jb/kOQ6Gmcyqox56CduPfSm7WwklTC1U4Vy/v6yLaVoJbvTKgSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4529
X-Proofpoint-GUID: NHQhGsHj6C6A4j0JcOIdc7yg1aRcJg45
X-Proofpoint-ORIG-GUID: NHQhGsHj6C6A4j0JcOIdc7yg1aRcJg45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAwNiBTYWx0ZWRfX0mEm0PPBl6ec EjFddmnbXc6PIxO+uzfoAjEjJ+1vtw2uvW3eRJLB4P04Nsu2HiCPs3WZvuM1j/MoPjb6RWOANBT hvbYSP5NFggFNM8g4IG/tHQeOin5TUs8ZlfsT2uTULBms1gAwsjfBZCooJnUGqrMbK1WmdMLYvC
 XsQAGsVm9Z2B1DsM2HdMW8P/quHNMmHfAdxn2BL07RCmhtPL0U2+urDj54vk5zSv/jgAOVR4Pfj 70dUVDfVcbyNKwAJupWPPSfaFInRQwXQMBooQCJTch6SiNK/QwXGdOQfJFJgxRwR1G7hHawEUrn 37c0ZXZJqi4sAK/p500cmYJslLvhbk5NYgSHkyENrIjQltpJawEmar7UwtC5aae7xBzKBm+48ji
 XKXnw8frRkKqaUHzyiqaXqeQLLEMY9UBj+cih4uTouUud4BKw/XzygWhzlrWwtSoyMgHOB57
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680ae012 cx=c_pps a=OxY2RB2sa7x8oI2LU21LDQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=BhNgAXSiCbHGp-1EalUA:9 a=QEXdDO2ut3YA:10
Subject: RE: HFS/HFS+ maintainership action items
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=839 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250006

SGkgQWRyaWFuLCBZYW5ndGFvLA0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCB4ZnN0ZXN0cyBydW5z
IGhhdmUgc3VjaCByZXN1bHRzOg0KDQpIRlMgY2FzZQ0KDQpzdWRvIC4vY2hlY2sgLWcgcXVpY2sN
CkZTVFlQICAgICAgICAgLS0gaGZzDQpQTEFURk9STSAgICAgIC0tIExpbnV4L3g4Nl82NCBoZnNw
bHVzLXRlc3RpbmctMDAwMSA2LjE1LjAtcmMyKyAjMiBTTVANClBSRUVNUFRfRFlOQU1JQyBNb24g
QXByIDIxIDE1OjI1OjE4IFBEVCAyMDI1DQpNS0ZTX09QVElPTlMgIC0tIC9kZXYvc2RhMg0KTU9V
TlRfT1BUSU9OUyAtLSAvZGV2L3NkYTIgL21udC9zY3JhdGNoDQoNCjxza2lwcGVkPg0KDQpGYWls
ZWQgMTAwIG9mIDYxNCB0ZXN0cw0KDQpGYWlsZWQgdGVzdCBjYXNlczoNCmdlbmVyaWMvMDAxDQpn
ZW5lcmljLzAwMw0KZ2VuZXJpYy8wMDYNCmdlbmVyaWMvMDA3DQpnZW5lcmljLzAxMQ0KZ2VuZXJp
Yy8wMTMNCmdlbmVyaWMvMDI4DQpnZW5lcmljLzAzNA0KZ2VuZXJpYy8wMzUNCmdlbmVyaWMvMDcz
DQpnZW5lcmljLzA3NQ0KZ2VuZXJpYy8wODANCmdlbmVyaWMvMDg0DQpnZW5lcmljLzA4Nw0KZ2Vu
ZXJpYy8wODgNCmdlbmVyaWMvMDkxDQpnZW5lcmljLzA5NQ0KZ2VuZXJpYy8xMDENCmdlbmVyaWMv
MTEyDQpnZW5lcmljLzExMw0KZ2VuZXJpYy8xMjANCmdlbmVyaWMvMTI0DQpnZW5lcmljLzEzMQ0K
Z2VuZXJpYy8xOTgNCmdlbmVyaWMvMjA3DQpnZW5lcmljLzIxMA0KZ2VuZXJpYy8yMTENCmdlbmVy
aWMvMjEyDQpnZW5lcmljLzIxNQ0KZ2VuZXJpYy8yMjENCmdlbmVyaWMvMjQ1DQpnZW5lcmljLzI0
Ng0KZ2VuZXJpYy8yNDcNCmdlbmVyaWMvMjQ4DQpnZW5lcmljLzI0OQ0KZ2VuZXJpYy8yNTcNCmdl
bmVyaWMvMjU4DQpnZW5lcmljLzI2Mw0KZ2VuZXJpYy8zMDgNCmdlbmVyaWMvMzA5DQpnZW5lcmlj
LzMxMw0KZ2VuZXJpYy8zMjENCmdlbmVyaWMvMzIyDQpnZW5lcmljLzMzNQ0KZ2VuZXJpYy8zMzgN
CmdlbmVyaWMvMzQxDQpnZW5lcmljLzM0Mg0KZ2VuZXJpYy8zNjINCmdlbmVyaWMvMzY0DQpnZW5l
cmljLzM3Ng0KZ2VuZXJpYy8zNzcNCmdlbmVyaWMvMzk0DQpnZW5lcmljLzQwOQ0KZ2VuZXJpYy80
MTANCmdlbmVyaWMvNDExDQpnZW5lcmljLzQxMg0KZ2VuZXJpYy80MjgNCmdlbmVyaWMvNDM3DQpn
ZW5lcmljLzQ0Mw0KZ2VuZXJpYy80NDgNCmdlbmVyaWMvNDUxDQpnZW5lcmljLzQ1Mg0KZ2VuZXJp
Yy80NzENCmdlbmVyaWMvNDc4DQpnZW5lcmljLzQ4MQ0KZ2VuZXJpYy80OTANCmdlbmVyaWMvNTA0
DQpnZW5lcmljLzUxMA0KZ2VuZXJpYy81MzINCmdlbmVyaWMvNTM0DQpnZW5lcmljLzUzNQ0KZ2Vu
ZXJpYy81NDcNCmdlbmVyaWMvNTUyDQpnZW5lcmljLzU1Nw0KZ2VuZXJpYy81NjMNCmdlbmVyaWMv
NTcxDQpnZW5lcmljLzU5MQ0KZ2VuZXJpYy82MDkNCmdlbmVyaWMvNjMyDQpnZW5lcmljLzYzNw0K
Z2VuZXJpYy82MzgNCmdlbmVyaWMvNjM5DQpnZW5lcmljLzY0MA0KZ2VuZXJpYy82NDcNCmdlbmVy
aWMvNjc2DQpnZW5lcmljLzY3OA0KZ2VuZXJpYy83MDQNCmdlbmVyaWMvNzA2DQpnZW5lcmljLzcw
OA0KZ2VuZXJpYy83MjkNCmdlbmVyaWMvNzMwDQpnZW5lcmljLzczMQ0KZ2VuZXJpYy83MzINCmdl
bmVyaWMvNzM2DQpnZW5lcmljLzc0MA0KZ2VuZXJpYy83NDENCmdlbmVyaWMvNzU1DQpnZW5lcmlj
Lzc1OQ0KZ2VuZXJpYy83NjANCmdlbmVyaWMvNzYzDQpnZW5lcmljLzc2NA0KDQpIRlMrIGNhc2UN
Cg0Kc3VkbyAuL2NoZWNrIC1nIHF1aWNrDQpGU1RZUCAgICAgICAgIC0tIGhmc3BsdXMNClBMQVRG
T1JNICAgICAgLS0gTGludXgveDg2XzY0IGhmc3BsdXMtdGVzdGluZy0wMDAxIDYuMTUuMC1yYzIr
ICMyIFNNUA0KUFJFRU1QVF9EWU5BTUlDIE1vbiBBcHIgMjEgMTU6MjU6MTggUERUIDIwMjUNCk1L
RlNfT1BUSU9OUyAgLS0gL2Rldi9zZGEyDQpNT1VOVF9PUFRJT05TIC0tIC9kZXYvc2RhMiAvbW50
L3NjcmF0Y2gNCg0KPHNraXBwZWQ+DQoNCkZhaWxlZCAxNDIgb2YgNjE0IHRlc3RzDQoNCkZhaWxl
ZCB0ZXN0IGNhc2VzOg0KZ2VuZXJpYy8wMDMNCmdlbmVyaWMvMDEzDQpnZW5lcmljLzAyMA0KZ2Vu
ZXJpYy8wMjMNCmdlbmVyaWMvMDI0DQpnZW5lcmljLzAyOA0KZ2VuZXJpYy8wMzQNCmdlbmVyaWMv
MDM1DQpnZW5lcmljLzAzOQ0KZ2VuZXJpYy8wNDANCmdlbmVyaWMvMDQxDQpnZW5lcmljLzA1Ng0K
Z2VuZXJpYy8wNTcNCmdlbmVyaWMvMDYyDQpnZW5lcmljLzA2NQ0KZ2VuZXJpYy8wNjYNCmdlbmVy
aWMvMDY3DQpnZW5lcmljLzA2OQ0KZ2VuZXJpYy8wNzANCmdlbmVyaWMvMDczDQpnZW5lcmljLzA3
NQ0KZ2VuZXJpYy8wNzkNCmdlbmVyaWMvMDgwDQpnZW5lcmljLzA4Nw0KZ2VuZXJpYy8wODgNCmdl
bmVyaWMvMDkwDQpnZW5lcmljLzA5MQ0KZ2VuZXJpYy8wOTUNCmdlbmVyaWMvMDk3DQpnZW5lcmlj
LzEwMQ0KZ2VuZXJpYy8xMDQNCmdlbmVyaWMvMTA2DQpnZW5lcmljLzEwNw0KZ2VuZXJpYy8xMTIN
CmdlbmVyaWMvMTEzDQpnZW5lcmljLzEyNA0KZ2VuZXJpYy8xMjYNCmdlbmVyaWMvMTMxDQpnZW5l
cmljLzE4NA0KZ2VuZXJpYy8xOTgNCmdlbmVyaWMvMjA3DQpnZW5lcmljLzIxMA0KZ2VuZXJpYy8y
MTENCmdlbmVyaWMvMjEyDQpnZW5lcmljLzIxNQ0KZ2VuZXJpYy8yMjENCmdlbmVyaWMvMjM2DQpn
ZW5lcmljLzI0NQ0KZ2VuZXJpYy8yNDYNCmdlbmVyaWMvMjQ3DQpnZW5lcmljLzI0OA0KZ2VuZXJp
Yy8yNDkNCmdlbmVyaWMvMjU3DQpnZW5lcmljLzI1OA0KZ2VuZXJpYy8yNjMNCmdlbmVyaWMvMzA2
DQpnZW5lcmljLzMwOA0KZ2VuZXJpYy8zMDkNCmdlbmVyaWMvMzEzDQpnZW5lcmljLzMyMQ0KZ2Vu
ZXJpYy8zMjINCmdlbmVyaWMvMzM1DQpnZW5lcmljLzMzNg0KZ2VuZXJpYy8zMzcNCmdlbmVyaWMv
MzQxDQpnZW5lcmljLzM0Mg0KZ2VuZXJpYy8zNDMNCmdlbmVyaWMvMzQ4DQpnZW5lcmljLzM2MA0K
Z2VuZXJpYy8zNjINCmdlbmVyaWMvMzY0DQpnZW5lcmljLzM3Ng0KZ2VuZXJpYy8zNzcNCmdlbmVy
aWMvMzk0DQpnZW5lcmljLzQwOQ0KZ2VuZXJpYy80MTANCmdlbmVyaWMvNDExDQpnZW5lcmljLzQx
Mg0KZ2VuZXJpYy80MjMNCmdlbmVyaWMvNDI0DQpnZW5lcmljLzQyOA0KZ2VuZXJpYy80MzcNCmdl
bmVyaWMvNDQzDQpnZW5lcmljLzQ0OA0KZ2VuZXJpYy80NTANCmdlbmVyaWMvNDUxDQpnZW5lcmlj
LzQ3MQ0KZ2VuZXJpYy80NzgNCmdlbmVyaWMvNDc5DQpnZW5lcmljLzQ4MA0KZ2VuZXJpYy80ODEN
CmdlbmVyaWMvNDg5DQpnZW5lcmljLzQ5MA0KZ2VuZXJpYy80OTgNCmdlbmVyaWMvNTAyDQpnZW5l
cmljLzUwNA0KZ2VuZXJpYy81MTANCmdlbmVyaWMvNTIzDQpnZW5lcmljLzUyNQ0KZ2VuZXJpYy81
MjYNCmdlbmVyaWMvNTI3DQpnZW5lcmljLzUyOA0KZ2VuZXJpYy81MzINCmdlbmVyaWMvNTMzDQpn
ZW5lcmljLzUzNA0KZ2VuZXJpYy81MzUNCmdlbmVyaWMvNTM4DQpnZW5lcmljLzU0NQ0KZ2VuZXJp
Yy81NDcNCmdlbmVyaWMvNTUyDQpnZW5lcmljLzU1NQ0KZ2VuZXJpYy81NTcNCmdlbmVyaWMvNTYz
DQpnZW5lcmljLzU3MQ0KZ2VuZXJpYy81OTENCmdlbmVyaWMvNjA5DQpnZW5lcmljLzYzMg0KZ2Vu
ZXJpYy82MzcNCmdlbmVyaWMvNjM4DQpnZW5lcmljLzYzOQ0KZ2VuZXJpYy82NDANCmdlbmVyaWMv
NjQ3DQpnZW5lcmljLzY3Ng0KZ2VuZXJpYy82NzgNCmdlbmVyaWMvNjkwDQpnZW5lcmljLzcwNA0K
Z2VuZXJpYy83MDYNCmdlbmVyaWMvNzA4DQpnZW5lcmljLzcyOA0KZ2VuZXJpYy83MjkNCmdlbmVy
aWMvNzMwDQpnZW5lcmljLzczMQ0KZ2VuZXJpYy83MzINCmdlbmVyaWMvNzM2DQpnZW5lcmljLzc0
MA0KZ2VuZXJpYy83NDENCmdlbmVyaWMvNzU1DQpnZW5lcmljLzc1OQ0KZ2VuZXJpYy83NjANCmdl
bmVyaWMvNzYzDQpnZW5lcmljLzc2NA0KDQpTbywgd2UgbmVlZCBhdCBmaXJzdCB0byBjaGVjayB0
aGVzZSBpc3N1ZXMuIEFuZCBpdCdzIGEgbG90IG9mIHdvcmsuIDopDQoNClRoYW5rcywNClNsYXZh
Lg0KDQo=

