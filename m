Return-Path: <linux-fsdevel+bounces-55895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BBB0F9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BF13A5D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0802236F7;
	Wed, 23 Jul 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A+AvZ61t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A12212FB6;
	Wed, 23 Jul 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293490; cv=fail; b=lnNDpu9k5cZOpx5hcAn9FGVrwatpEQgwPPAp0XWjjU0GLzqEUFxrZvUhh8bi/UlZ+3P5AXQOAbkF2uWZ67NWDTNSveFmQ24mBGgBPnzZPGM8yNr8OBfOOV1etQQlEpH5hn5B3BcEZBKoKm6unZ8NUTQs3qId2ds+0k0SRG1nDNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293490; c=relaxed/simple;
	bh=rDT7VsKpHO581oeS4R3PM1iv6zTiEIKsM4Un5WCaMjA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NOC1dsym9Afhv6mLSAIpZKx5534lpXZW/55To/KJFOC1rf6T/XO1SEI0fijmm05Vsrvsu8D7QPoxfwSsuHKwln6jtNjC6OrI/7/ZYHC60coD8PMDwh8fC2tneHRD+ugeTD6Waeir7TkPgq/7B9bxAhrKqHdBwkN0MiMxayO/b8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A+AvZ61t; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDq7AW027659;
	Wed, 23 Jul 2025 17:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rDT7VsKpHO581oeS4R3PM1iv6zTiEIKsM4Un5WCaMjA=; b=A+AvZ61t
	jfohAanQ3VVYl9TDJvM+j9qD6lZk6AAChS7HlFKxdnzLTV+X3GpjjQrsZMVKeP6+
	TYcqNJiTKzQKadCdbwmdPLbf1poLhsRa6U0Cv2t5b8jBCrj/QPyBOs3SyuguHVwz
	yf4QZGZJx0HgXDrlYd5fbJ+Kv4ToudQ8chNlZYBjhQ29HqCo7sKqqJ55FKjc1msN
	87YBGda3bEDJkSIN4+6588GD1+oYBnR2GwG3qIKhV7GmBGkSf7L0CCKTcS2TY/y/
	+EaKUwE1j+d2X0caGKUmOn8h8Nh+u+1RSMYnONRPPD7ScfvrCgN5kY8YoxtaTeKt
	ZqTMBiSfiVNbkw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5pa6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 17:58:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAIBWAlnz/qnZNsjJKFM6lqdpl0jxOVw/Dt/NtYjPSwlBBM9LAJTUgPazZ3qZmufypcHS017F0WcdCoo+86igjlUzwG14iLnPipky6I8dozFYLvrfBcwehvbaTV9/4gp6/HK81gwPBJ6IEsypiKf6Jaxj2dSjZJCx9ay37AfzxlbST/nAXa0kcRI+Qj16cSSBpSnXxXM94enZikccPNh/Ijys+iyB5qaf0T/CfP18sgYOsxFJq1EwI8UIPreBCK8MllPvi0ogInP53jGwQaldd6VoIvlat+CLNGiL2+UyLxXAZ7JrY6cHwYnr9ubN/Kf5DcHYoJJdRlYrCCtc1Oqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDT7VsKpHO581oeS4R3PM1iv6zTiEIKsM4Un5WCaMjA=;
 b=OWX6pOzEv1IJsc3qDeFK1GOLTj7/g3e3XQgnVaFwYOPYTg/B2IkyyhPBpMVfAgX2lDs9W1XfPbiaBcpLeKDRfW0WYfEQRg+odJnfZCWZ0SqRXJ5pOGJ+rfBEzVApjrEkBqLi1WXHq8oVO+vYqqROChDCI8W3QBdcxUM/gI8ORH5RzN2fNzp1J5vMhyFOGji52IbGqG90/isIj12ksmt85SG/aSksTB2FfS0K/Y/hkKj5mdvFWxfa5D3wPWoY6BPUBl2aVviVxFHTEbXuxgLdjgN6n7YmzTrn1/09Oa9V8dO3i/dx5AxiKcEHAZbBR9lvA0L2fAu7fkWD858+Wvl5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM6PR15MB3928.namprd15.prod.outlook.com (2603:10b6:5:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:58:01 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 23 Jul 2025
 17:58:01 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/3] hfsplus: fix to update ctime after
 rename
Thread-Index: AQHb+3oV9Rb3lJ0HqkigH70nQmJRlLQ//7SA
Date: Wed, 23 Jul 2025 17:58:01 +0000
Message-ID: <cce1a29f2f55baf679c3fe83269d9bceb3c4fd6c.camel@ibm.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
	 <20250723023233.GL2580412@ZenIV>
In-Reply-To: <20250723023233.GL2580412@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM6PR15MB3928:EE_
x-ms-office365-filtering-correlation-id: 08c6bee3-eb86-44a3-bc58-08ddca127761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Umc1TnFHZkErU2JhUXhnbFQySjV2RUhoVmwwZkk3LzRtWGM4T1kwMEliZVpD?=
 =?utf-8?B?RkF0M3Jqb3RwNitha3VPcmpXV2ZaaFo2TmVrd0pKY0xwNFN0UnM1cHRZRllj?=
 =?utf-8?B?VDVEeml6d3dOMVpSSGI3a0trRTZIUHNtVnJvd3BKSzJMOWFqWlNmcXRwdEhn?=
 =?utf-8?B?VmVvSTdBa01NRmhpQ2pHMU5ZcjluWW5DSE5rWXQwT3NPVnF3VmRQNENlTzVF?=
 =?utf-8?B?M1F0bGtlbzFtWHlFN21EdTRmU3gvYmZjRk9OTGJnU3NFd2pVRENaY1Bhb3lJ?=
 =?utf-8?B?NXRpaEZBQkNPWk5qUG14R2ErbmZVUWJ2TUNLc0MzRytqb2pGRWROaDAySHR3?=
 =?utf-8?B?U1lMbjdXRzdzN0t3bE1KTERyc1VHd2tOU3FyYnIwZy9Xd3dGU2Z0UEJMNDkv?=
 =?utf-8?B?MVhaRnZXK2tKaC9aVWFHbk9KOG91L0hLdTFWTUwvMzU4dHJ2ZS9iVExrUUQr?=
 =?utf-8?B?TVZqcStBTUdFaTVlcmdpUENiSERicEZZSnp4QldRb2JsaEs5czdvK2ZDaUdD?=
 =?utf-8?B?NzVpVE5KRDM5RHIvbXJYTi9yb0lFaUF5V0xUZU9Rd0p4bmhDK2pFOHU3MFBM?=
 =?utf-8?B?UlBGUVowellKWnNJWWxaOU1pemp3cHdnWjNLeWl3YmhpOGtiSm91U3pyRUVU?=
 =?utf-8?B?cG5yY3J0UEZDUkxkaWZWeHVsTlNVcUQvemVDTVY0MExUbHlETEllOU1LUmNs?=
 =?utf-8?B?cUtEbzFhSElMVWt2VUM3a0ovU25iU1FBNXZocWJWYTBiUU50NTBtdm1uYWhn?=
 =?utf-8?B?OWYvWnJ0T2JLMVNnWVNkWTdKODNpOTdsUUJyeVYxd3BPdUdVWjExbVlkWEJD?=
 =?utf-8?B?dW1WaFQ2YSthaVlxOFV6bmlEWFJ4V1hkdlFWUllEOFU2NjJkRFpiN2xUNXJZ?=
 =?utf-8?B?WkhhNWJMVnNzblNSbU5scldGb1dsNDZCTnFKN0hZZmthNFFENEZpSWY5WWlE?=
 =?utf-8?B?UlRmUExNajJZekpYRVBaM05NQk80Wlc5ZDRNdFduNk9qSy95blFOSVBLSUtQ?=
 =?utf-8?B?L3FYaTJBdHB1SnYzRWZZT1lYYzR1V2pSb3ZoVTdXYURHL1l6S3ppQytHVzM2?=
 =?utf-8?B?N1BTcVQycXhsZEpHaWpFcGhrRnNYM3BGR2lJM09rMEhBNkJBQjRJZ210Wk9W?=
 =?utf-8?B?ZkFWZEt2YWYvSEVUR3pZZ3RnVXZnOTYzbWpocDdNWnlaK2thenpZMTlublMv?=
 =?utf-8?B?d1g3RXRJeVhQTlVlTHV5a2ppQlk2bmVrZTM4TXhjMG9yeDY1SlNYcTd4ZDFO?=
 =?utf-8?B?M21qVE11bDg4TWIyVmQwdkFKQVRlL2VhWVA1c2dVc3hZbzBRYWl2WGZtSHgz?=
 =?utf-8?B?aHBVVDd1T3NhTTcvb3pFaWt1OWVJMlA5eEVoNE5SdU1YS290THlOamdGMVN0?=
 =?utf-8?B?UE5tUXJaZU1OblRleUFiZGp5Q2RuUmZuUGw3Qy9ENEx2YitLTHdWZWl5cWo0?=
 =?utf-8?B?MVlJM2Q4Lytid0NKa1NsdnJiMys3TmlkMDF2bDJtUjQyVEo5QTd3ZnlsbTdE?=
 =?utf-8?B?UUdzcklvUStiYzdEYzVrcVpHN2pkUnU1MDIyTW1aTHVEZGFuYmNUQmliUjhI?=
 =?utf-8?B?TlNZdU1FeVhXOW42Q0xkVkF2ODRpWDJjL3NzVk5YWG1HdmpTQTRXakJhd0hu?=
 =?utf-8?B?NU1uMlp0YnhhUHJzbG1QVTJOTk5NRWIybTc1bG15aHhmcG9Jbmx5ZEhwQWYw?=
 =?utf-8?B?aktLTEcyVHpudHJhODRLM1Q4NGVoTkxWRzFaNGRTMXJIMWN2TjcrdStRb0Nk?=
 =?utf-8?B?WHRhUU5zQjNhVXdlUHJGMDlsa29WdjZHN3g4a0FHVkJwQWNhVkxLYnRmSVNZ?=
 =?utf-8?B?Wnp0UWd2M3hsMk0yamNpUWxFQjdHYVYrZzV3d0dYNE5ZeU9pMFpxVXdZYUNT?=
 =?utf-8?B?bUJIcklVVTRYSU5aM093a3dQcmQwbmYybWUydEk4dWRTMkVocXBXc2VBb2Fa?=
 =?utf-8?Q?KdooMk3zOO4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Snh4WmszMFVvVFkzeTRGWTU2Q3c0RUR2VThaWFVtdzdoaHd4K2xsS3lOVkF5?=
 =?utf-8?B?MlltTU5wdGMyVURIWEoxR2hOZzFxWUliSCsxVFowd2F6STFzcjJsTnpSK3lz?=
 =?utf-8?B?SUIwV0liTDRxc3l5czJadjB2OFE4SXpJdFBtcEh3R09zanRhMWgxVW1qR1RU?=
 =?utf-8?B?UE9YQ2k4Yll1Zk9IZFcyZnpRMDMwalVuOWttNkV5V1FpY1JWNGNYcnkwaklx?=
 =?utf-8?B?QThrUVVCZUxQUk9yOUJ6VW1uWHpMQUVuV2J6NWtORUxxWjlzTG9CdHgrK2VW?=
 =?utf-8?B?Sk5NUlI3amUzK2dKdXUwUi9OUTR2SGRpQ2VYNWx1dzNOSFRscVBZV0NSWjhi?=
 =?utf-8?B?RmNKSUdYT1V6VnlEaDdHcFVobUFYWmlUMVQ0RGVsSEVnQ2dUY0g1bGpobjBv?=
 =?utf-8?B?OHVKaEl3T2ViT3Q3LytISzg5NGgyRHRWMERMbXFPb2p3QkNNTWFZc2dicmow?=
 =?utf-8?B?MmxhMGFtTnQzRVg5RmxVTFJZU2trYnJ4NDBOa2JtZmliM201bHYyMHdjVzJq?=
 =?utf-8?B?eit1NkwzT1lQM25oWi9LN1Rza3YzSStUUXBkTFZIcmdCMTdRODNRcUV6QzZu?=
 =?utf-8?B?V2VsSVR5UXlkZjBzTnhKVC9oOHc5SHBGUnArZlpqR0x3bjl3RXUyeksrWjVL?=
 =?utf-8?B?eU1BWTJrbVdpSC9iYnkra24veVBWUGdLRDlkaE1ldGRPSE1mSnF2eDYvRWdh?=
 =?utf-8?B?WEFXcWdrdk9DMXBMbFlYYUxIY2RkSG1TZmY5ZnlVQ0NmMHZJVENhcTh2MTZR?=
 =?utf-8?B?V3BrdjVUZ0N1RDh3K2JmYUNxbi9ZWTJsWDlPM1k5cW11WjZqSFZyaEFCYksw?=
 =?utf-8?B?S1h6cGxLZVZONHFVanZpZzMxQXlJU0FiYUhBekd5bEQ4UVNaQlU4RERONDlM?=
 =?utf-8?B?T2NhdWxhTWhXc2ZrMTkwYzNwQko1Umx0dkxGN1VpWnIrcFNlV1RtbTdxTU9X?=
 =?utf-8?B?ZFBqVithQTZoTFUrdEFPMnE4cnp6aWprMUZuYWRZZ3lURHJGeUdVVXlyWTlh?=
 =?utf-8?B?VEJRc2U5WHBXdllINzZJRjY3UWdxVGJ4UFVpRkIzZ3pWaDhkNlA2Y2c4VnRZ?=
 =?utf-8?B?Rjd6UGkxWkQySWoxWEZrOU90TlVVY0U5M0RFRzNjUWl1eHVKdGdqQ3hpdEZi?=
 =?utf-8?B?clYxWjhJOTZTZkpiUHYvd0dpUVhhSVhSUm9QMFFuR2cvSXZjUk1UbFlacEF6?=
 =?utf-8?B?VE02L3pJZWZsdHZPalVnYkRMVTZOMDJpLzZnc2cxNEtSZ1o4Y21paGphZ01s?=
 =?utf-8?B?Ykhxa0lEWVh1UythbTJpVk53QVd3cG5wR0YyMGo5SEtMYkZVRUFrL2RJeit4?=
 =?utf-8?B?d3V2NURBYTZvSGRVdm44UVdtN1pBcVN0SDRnSzVReTZJZnA4Q0ZUQmRvY3dk?=
 =?utf-8?B?QkpyM2JtcGRQZ04xRVFqSlRTczBIT0tRRlFMakNHWE9FZ00wUDNiVGE2a3VU?=
 =?utf-8?B?UWFOQ3F0Y3V3VEFLek9lc0xJSVR3UHhBWkxCaGpOdnJkaXI5cVBveHpFRERG?=
 =?utf-8?B?RXNQNWZ1cFI4WmZyYmNGeUdlaWRwUHFJQThDTW1KWkszMXNva1l6aEZqcGMx?=
 =?utf-8?B?V3hDcGw4NE5CQ1d2RDVQTTJibmNwWDdwUEtuaFlpdGJWNEFnWm1OeFhwVEtZ?=
 =?utf-8?B?OGJaNmNqWUo4UTB5anBRR3A2RkI4MHN0TmE0S3BnOVYvMFRTeEJlYnM5QUxi?=
 =?utf-8?B?QzcwZ1lOTGw3ODNHc2hma1JLbjVoa2FIUnZzcjZCVHR6ZUJrckVvdk1LSTY5?=
 =?utf-8?B?cHhrVEc5aUUvQ0RndkJuWHpvRE5ERUM4M2M0SFdlN3RqUUY1dGNRdEFFS3Rx?=
 =?utf-8?B?aDhmS29tR2FWSExGNzJtZVJ6Y3dJb2hqbXJvZ3J0TzlVUDBzSFBGNmorRHl4?=
 =?utf-8?B?d1phaDMyYzJhVWxKZEYzd3N5LzFYZmlHQUlEczR0bmorVW8vUTRSOTZQS0o2?=
 =?utf-8?B?akZNTDhwOWNIZE9FUDRyUUZKTVhKaHNWbnlJeTh3QTJvVE90QXc3MUVuNTNq?=
 =?utf-8?B?SmRITXN4aEZ0VUlyZlMwcU50K2R0WUFqM2R0Z2lIbTEwem9TMFIralJXNUpV?=
 =?utf-8?B?aVFqamFxeEM5U3IxbzA4bW5Za3F1cjhxNWlCamdVWHcvc01QS2M2L2xPSzg1?=
 =?utf-8?B?dmZIRk5OVTVvVlhscGJoeTJKNzBuVDU4N2p2UVkybFU0enUxbWhJYVYxNHR3?=
 =?utf-8?Q?UPmPxV4T4ZP5rW+596WX8nE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1348224F60CA4D4D8B96A834F27F8CEF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c6bee3-eb86-44a3-bc58-08ddca127761
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 17:58:01.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FofD+aFC+1BcS2NFd5bludKQURjKmmyP3gvqqhGzxPiyo3o0r1dX7rOQXPFk/XTrGWUqgdAnS84jzigbQYYKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3928
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE1MyBTYWx0ZWRfX3umS5abnGxkU
 xwYOMkAY9yS0xudolGLZaTJj86Wy7MzcH92S0DSLJ6skqp1ieTFlUN7ZgYqqJM8f/1lnk+2sLKH
 qffeIaPKh/gdtWv1HeUGae7+EUkPHLsYtaXViTcqo2GE6NLdvRS47c0u/k3+Q1Dd3MVG9OV2aJQ
 9Q/fGK0KxzReBdpmcXjGA+Q5SxwboytVWwT4NyjzC2x2Rxxn+wnshhnxzJoMa1YTNOTFwPRg+vL
 9emPyAvXMtr5Zo4P0qYH+r4XNgjv9I/lRcMPHyVnan+2sQDmtlKCWEpxFC1FT5Y7gje1wPfNudl
 YHlEG97R0cPpFogolMfHQXPqOmuExrtujDKL3NwLzNPsaudnyzbS8HOr4Cgwyhgj6CnQ7u4iE9D
 W2fFJX3I+sgUJ4JfTSdesIOTS3DKfn8n41/YbKgTkDL8sggSrs4EN/qIT5beqj7LK06a2TJR
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=688122ac cx=c_pps
 a=B4bUw2QgNwGTCAXqIx8Ikg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=-0mzata3yMjZ4mvSgx8A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: _z9Di603lnUXXEcU8SJ_d9NW816QdF91
X-Proofpoint-ORIG-GUID: _z9Di603lnUXXEcU8SJ_d9NW816QdF91
Subject: RE: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230153

T24gV2VkLCAyMDI1LTA3LTIzIGF0IDAzOjMyICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEp1bCAyMiwgMjAyNSBhdCAwMToxMzo0NUFNIC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0K
PiANCj4gPiBAQCAtNTUyLDkgKzU1MywxMyBAQCBzdGF0aWMgaW50IGhmc3BsdXNfcmVuYW1lKHN0
cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KPiA+ICAJcmVzID0gaGZzcGx1c19yZW5hbWVfY2F0KCh1
MzIpKHVuc2lnbmVkIGxvbmcpb2xkX2RlbnRyeS0+ZF9mc2RhdGEsDQo+ID4gIAkJCQkgb2xkX2Rp
ciwgJm9sZF9kZW50cnktPmRfbmFtZSwNCj4gPiAgCQkJCSBuZXdfZGlyLCAmbmV3X2RlbnRyeS0+
ZF9uYW1lKTsNCj4gPiAtCWlmICghcmVzKQ0KPiA+IC0JCW5ld19kZW50cnktPmRfZnNkYXRhID0g
b2xkX2RlbnRyeS0+ZF9mc2RhdGE7DQo+ID4gLQlyZXR1cm4gcmVzOw0KPiA+ICsJaWYgKHJlcykN
Cj4gPiArCQlyZXR1cm4gcmVzOw0KPiA+ICsNCj4gPiArCW5ld19kZW50cnktPmRfZnNkYXRhID0g
b2xkX2RlbnRyeS0+ZF9mc2RhdGE7DQo+IA0KPiAJVW1tLi4uICBJcyB0aGF0IGFzc2lnbm1lbnQg
KGVpdGhlciBiZWZvcmUgb3IgYWZ0ZXIgdGhhdCBwYXRjaCkNCj4gYWN0dWFsbHkgY29ycmVjdD8N
Cj4gDQo+IAlOb3RlIHRoYXQgbmV3X2RlbnRyeSBlc3NlbnRpYWxseSBnb3QgdW5saW5rZWQgaGVy
ZTsgb2xkX2RlbnRyeQ0KPiBpcyBhYm91dCB0byBoYXZlIGl0cyBwYXJlbnQvbmFtZSBjaGFuZ2Vk
IGJ5IHRoZSBjYWxsZXIgb2YgLT5yZW5hbWUoKSwNCj4gc28uLi4gIHRoYXQgbG9va3MgdmVyeSBv
ZGQuDQo+IA0KPiAJV2hhdCBpcyB0aGF0IGxpbmUgYWJvdXQ/DQoNClNvLCBhcyBmYXIgYXMgSSBj
YW4gc2VlLCB0aGUgZGVudHJ5IHN0cnVjdHVyZSBbMV0gaGFzOg0KDQp2b2lkICpkX2ZzZGF0YTsJ
CQkvKiBmcy1zcGVjaWZpYyBkYXRhICovDQoNCkFuZCBIRlMrIGlzIHVzaW5nIHRoaXMgZmllbGQg
dG8gc3RvcmUgQ2F0YWxvZyBGaWxlJ3MgSUQgKENOSUQpIG9mDQp0aGUgZmlsZSBvciBmb2xkZXIs
IGZvciBleGFtcGxlIFsyXToNCg0Kc3RhdGljIGlubGluZSB2b2lkIGhmc3BsdXNfaW5zdGFudGlh
dGUoc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KCQkJCSAgICAgICBzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCB1MzIgY25pZCkNCnsNCglkZW50cnktPmRfZnNkYXRhID0gKHZvaWQgKikodW5zaWduZWQgbG9u
ZyljbmlkOw0KCWRfaW5zdGFudGlhdGUoZGVudHJ5LCBpbm9kZSk7DQp9DQoNClNvLCB0aGlzIGxp
bmUgc2ltcGx5IGNvcGllcyBDTklEIGZyb20gb2xkX2RlbnRyeS0+ZF9mc2RhdGEgdG8NCm5ld19k
ZW50cnktPmRfZnNkYXRhIGR1cmluZyB0aGUgcmVuYW1lIG9wZXJhdGlvbi4gSSBhc3N1bWUgdGhh
dA0KLT5mc19kYXRhIHNob3VsZCBiZSB1bnRvdWNoZWQgYnkgZ2VuZXJpYyBsb2dpYyBvZiBkZW50
cmllcyBwcm9jZXNzaW5nLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KWzFdDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xNi1yYzYvc291cmNlL2luY2x1ZGUvbGludXgvZGNhY2hl
LmgjTDEwOA0KWzJdIA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTYtcmM3
L3NvdXJjZS9mcy9oZnNwbHVzL2Rpci5jI0wyNQ0K

