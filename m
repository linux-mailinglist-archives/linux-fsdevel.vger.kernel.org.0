Return-Path: <linux-fsdevel+bounces-54545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D788AB00BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C075C299B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC7287514;
	Thu, 10 Jul 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pE/i7QU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6A21CC63
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174074; cv=fail; b=HVb5TXCwdP6BfVqQbNNkG66IiR7xHKRbvbjalUIyb5oFrUUp7wjcs6zFF9+erVny3XPL72M/n9RCoq0154vKOe0+umUIBuooLJ+AKtWSfttRW54Lc0ofXzxpP/Sq+FyZCC1JW1K1NCm6txpPMrhVBYo1HHSdMf/sStKYTK24mJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174074; c=relaxed/simple;
	bh=EsC7GM8at15BsP6SYAbu4HeA8/+6GeYiCAW/E239agI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Db/jgFBvFZj8lPvy8N9BJvLujUvrmiFg34Ga3aP0z9w36d/EWk8nWiY+H1KAUSzljOkvCMXD6C0lvvH/MioFAsdYNWkZAqPJsc13X69hOrR6zw7HH8ZZuJcRpv3XOxIHHGVz7KBQrnv+IYHC23LDHU2t8azvVcoW1oS5SYJySN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pE/i7QU3; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AASpwb006954;
	Thu, 10 Jul 2025 19:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=EsC7GM8at15BsP6SYAbu4HeA8/+6GeYiCAW/E239agI=; b=pE/i7QU3
	YVvmwC70uQBGh606VOoIXAHHZRj3JdujSnIvhzBA6X6nm1PuTty/9+3qYNLCZ6wk
	L6V1hZQbCbZ5GdEKbhZQO9A9PPDptNsMazKMUO4zYlWfuYXbv2laTLxDovHUWt2g
	zwNgtEZtKdxk84z1+ZPR8hgd4tYz6kWUYcjkrnmJXLFcU9Hc/AhDtafsVQ3OBUGo
	R9mUZAx16s/pfQgIcreZh2OrzNqMrFX95sj8CVTKN3FSeBEn3wTqlU/I8/pbGHm6
	grpLaNHrlF9JJkJiOzLraWSkhc4VTOWXSvmaipIGvWwgPTEKLEOoKh83BY6oqvKD
	Y7Aq+HDQBrcLHg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnnk8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 19:01:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlUymipJC02/MDCXymJShhm95HMzZ5kw3GWdnpqQJhJUhGIwpmDsDg3yFzGkBdEI0rAL4hhNJq0oHcfivvJ40zbSjf6wXgEALofCIvpyM8fYL90xm7b6GMIbJv4Q45Ppthtkv9GplJX46Gsc85eA1Qr2NBPGPfUX/cpWoB5wxRG30G0UNlwcGi/I52QEz18T16N893c50Kt8A0W2V/KDLdMVQZuhCZmdOsg8tYa0qEMpTM1qASJ6CdqJHDifjui8SKdG0oGlbr45eCmBqWyIs+zwY4U/WHAN1x7RrYFyOrpHkYVyD2EpyCjJp7HZsxgYTVqHxqlnYdCjr5DI05u0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsC7GM8at15BsP6SYAbu4HeA8/+6GeYiCAW/E239agI=;
 b=Ix7u6l4SIHT4xaq3wKNye5F2vQGRn7ZV+2oOdzWrRpS1UM2qzcghR3rw87tj6t5al/XpKX61Xf+JdQME2PCKgHRf9Q/vihc1MRXWjCBA1OxK92uhIWaOf19Nf6LezI2fVxJNv4Fdw1uGcSH0ykU21lcJGPUTt5tgb/KC/ocwAoekEWikYoE+/4IDdNVXARZvRSaz9LxZviaFpfvGlVPwnDbaqpy+hZuphUoUuZ5xVa92xDEP487JuiIfEZ+7VaDelKKPeiHAfE333ZRvRBhFDmn1cGBvKCIlp8xy+BROtrf665CmGpdG0AjW0RnoKKZcynxQtoNTY5WoSuaMyq4T1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH4PR15MB6580.namprd15.prod.outlook.com (2603:10b6:610:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 19:01:01 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Thu, 10 Jul 2025
 19:01:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: don't set REQ_SYNC for
 hfsplus_submit_bio()
Thread-Index: AQHb8WTuR5FW7oG7PEayzgcz1h0aIbQrtykA
Date: Thu, 10 Jul 2025 19:01:00 +0000
Message-ID: <f6b3e1e8aaee19b03df0bd3d9e924b5714fc8bd4.camel@ibm.com>
References: <20250710063553.4805-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20250710063553.4805-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH4PR15MB6580:EE_
x-ms-office365-filtering-correlation-id: 391763d2-af92-4fd2-d3b1-08ddbfe41c8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFFpMkxYVHA1TDdvbzhtL2dNUXdDcHpQdGdhcGlpMFd1ZUZvaUN4d0FnMmor?=
 =?utf-8?B?NER3c0laaFR5MStHMG0xMFRMOUlsUXZQUVZOQTAySUd6WHhYejJkTVNxQTZo?=
 =?utf-8?B?VStBdUpZbk9waElVZHFOVjh2ZmhUZWJ5Z0txTHV2U2N4OUpyMU5ScS9MVmRn?=
 =?utf-8?B?YVdiZmRWbDV2eGRzOC9RdWhTYXNOdFRDZmNvQVo5UFZFNUxERnZzVnppNm5o?=
 =?utf-8?B?NklhVlVNRFBGQXhRbjVmVUxlSm5rMVpoSWxKTTRIS0trbVZqZEZxdGdhUlB4?=
 =?utf-8?B?NUJVRWdLRmhRaVFCL2kvTk8yenhxd1lqNktNS3hmdlh0eFdTNjJvSjRvR3Ni?=
 =?utf-8?B?aVRaWE5laUFsNXdWN0dRT0xkUVY4QXpGNlB2RWNJdHZ1bVpxQXBZK1pIenhy?=
 =?utf-8?B?QUdwVksvTkJTeDVlK1cyL1M3aGc2dUhXVmdYZ2VNZUZ2Q3AvczJNM0lyV1hw?=
 =?utf-8?B?V0k1U3V5WnUrVW1PRnlkaU9mYnoyTHc3NzAvUTZGR1gzVUhHY1NrY29CeGlF?=
 =?utf-8?B?QTRpazR1UnI3eDFKa1NjTUx0TFNBYjhycW42eU9NZ2taM0g2R3dUbWQweUt6?=
 =?utf-8?B?Wm1ieWhXQms5Mi91QytMd0YrQ2VNMnRSNHhtVCtPZ2NUSE9lTzRCWS9qVXZz?=
 =?utf-8?B?aSs0WVVRbmRuRkpSSFRDRFY2b3h6V0FYZ2hINFpscTJ5c0ZsS0Q0L2pKSEhr?=
 =?utf-8?B?QnZqaktQTHNiKzJNTGlwZE12QXhtN3YxeHdDc05ocnY2aVptVnFwQTVWdysv?=
 =?utf-8?B?Z29iNC9ySlZRRThEdEQ3TnR3ekdlVUhrbFpyYkMvWFE0L2hMUURiSFNOQmd1?=
 =?utf-8?B?c2pzMnp1cjRPVzZza2RTbFdYSEJ0ekFBeHQwZWFTNnlYQ1RNU1NLdTlqQVlj?=
 =?utf-8?B?V0JEbktzZXVJYjdFb2pHU21FdnRBOEQ0MlArcGs3dVVwUHFRRk4vMGZTT2hi?=
 =?utf-8?B?aWQ3aEx0eXVuRWNFMnJ1dE5NMldwb25qRmY3WEVBT2JVOWJIWmYzWlEwNUU3?=
 =?utf-8?B?SzNNbkNNWEJRTCtYMWpiaWVKNEtWNkZSY2dVQUdmTTZadzljQVlkcWhjRGwy?=
 =?utf-8?B?Q0QxT01IdGRESldYcFFtVmdmSmJIRW1URG1zaWhUVUVXc0VNSEpGSUJ3OW9k?=
 =?utf-8?B?MXZidjZRcWcwMmJsKzAzcEVyY2lhTWNGRGFiODhMcmdnYzBHREVVZWR5Tk16?=
 =?utf-8?B?Q1FXcjgxdUxvL3pKRk1PeWxBbVRjU0N5eGQyZGFjT1B5dnNSTlVyb21JdG1l?=
 =?utf-8?B?SG0yV1dhalpGekdVT1JzZ2JvYzBXYUVGZzRmeVdrdGhuQyswQVlqRGk3OFd0?=
 =?utf-8?B?L2R4V0VINkM4TnlHT3FIcXVoWGExUVRwK2d3b1hwa3dmZkRJTHhRRnBMNEdL?=
 =?utf-8?B?NnJHajZiQWUya2pFQUN2ZmM2b1NmakRmem1BdmZOSzN6YTJybG1lU3F4Vk04?=
 =?utf-8?B?REtFelR2YmNrK3ppbDVHdVhhYW0wOGd5RmU1ZTRDZW9ORjkza0FhT084a01u?=
 =?utf-8?B?YkRjcTZVREQrY2VpNFJ0Vnc4ekRUSFRJeXJRbElEVkNRam51dnA3Qm9GNkZo?=
 =?utf-8?B?UXRpU1JzazRxSUxOSkdqZGZnNHZJdk5pUjY3ZnF2cVBwYUJnNjVzT1ZUZmdi?=
 =?utf-8?B?M3d0K1ZDVFFkeHNFbEl5bTdzR0FhMkZFb2tza3ZYTUdpRHRPVThHSmtXb3dk?=
 =?utf-8?B?YkljbFNRUEl6eUlBTmhUSWdOSWhSdE1DZU91aHVaSEhmMlhKdnFOenNmNXBh?=
 =?utf-8?B?dE1LU2dQcGRDMGloVTJ6ZlpySTJoTHRYMFEvNngrbVV4U1ljSXZhWTFONFly?=
 =?utf-8?B?V3RIdDlIakhsQnh3SmtuYldiN0tNeU1HQXFUTjAyNGRBUUJ0TGo2Q1hKRjV6?=
 =?utf-8?B?Y2I1ZDhuNWNkT1lDcWZTSWIxVUNVT2ZmK0FEbVVVTkxocmNFSHNnZnZEYUdH?=
 =?utf-8?B?RHY1NXRNUDljVUVwRE9NVm4yYkZyYjlJWkJWMUc2Mk0rWGNCVlI1enVad1Za?=
 =?utf-8?B?UTE1bWVYeFFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWFhZm01WEt0cVNDMmVRYk1DZUFyUHlCRjZSLzdRY1lsNFJWQzZSaU1IdWls?=
 =?utf-8?B?R1JnZWZyWUl0QWczVC9UK0s1eTdBM05hOVFrc3o3cllKRStLcUxvOCttbGo3?=
 =?utf-8?B?WDVhemRseXBjdU5rSlZhR3VPQWd6YkpGbXg2TGhyVFVzWmFGajRtdkxXS01x?=
 =?utf-8?B?VFdSUDRIYXBhd1VjeWtUQWRDc2p2S1ZTaW1paStJUnAzS1cvSGs1MkRNMHZ1?=
 =?utf-8?B?K1VzeFZvdXdkaFVIYk9BZ3poQkR3Q3dHK0ZpRGR6cGhwd0E3VFYvVS9CcXpk?=
 =?utf-8?B?NTNzcWpkYy9wZmp5anJydFVnR1ZNYWVla2MrTXpMTjdhODdCYVZRNExhMS9a?=
 =?utf-8?B?alVxWENtRURHTGlhZG8wUUtuZkpMZVdHb0lNeEdQNk41Z2g5TEl6bzRWWTRZ?=
 =?utf-8?B?Mk1qZFc3SGdQK3UvQmNtTTVMTUdCSnRYY1VBa2hMdWNzaWp3Ri9JckhHSkFS?=
 =?utf-8?B?K1FKVlBVdGZ2OEJoL3dWRmtRNDZ2b2F4R1ZCZTNZZTlxUVRHS0xTdTJ1MWpG?=
 =?utf-8?B?ekVoQlJRbjQ3ZnBOWDhEMnlDUlVsVWI5YnNiWGc5cFBDbHg0c0Jwd0xUS1Y1?=
 =?utf-8?B?WGgzRUVSRXV3ejhXQmdiZDlCcWJNOTQxeCtvT2xjVElmcWlQMFRHU2JnREdH?=
 =?utf-8?B?a1hDOEw3NDkyaUNyN1gxNU1RSVhZeWxxK3lNcTdvSFNKSTJzYXBRQ2c5TDZQ?=
 =?utf-8?B?TE03OEpHeG5DTTcxcEIwSXg3aTJTMWcxUDAwSDlVOXJveHFvWDBDYzRaSzdt?=
 =?utf-8?B?RUtXS0tCS2VEZDRzWjIwdDN2OGNaRjJzZjZOeHFGaWpucG11N0MzbGVKeVpX?=
 =?utf-8?B?TXdldHMzUmFhKzNpMGp6S0JxUEM4dUloYUxsWElsT01Ec1d1b2g1cnlxNkFt?=
 =?utf-8?B?bHBmMVVGSVIvNEtJUXI2QjFqNWpnblQyNFgyTCtiMlNUNUIvck1iZ1NaY0hZ?=
 =?utf-8?B?cmRNNmZFUkFTT3pETVhCZGdGOWQxU3A3blRCSis4R0plVHdzWnY2L0h6SERR?=
 =?utf-8?B?NDQ3Z0Z0MGxzUXZ3QWJYY1FteXBLRWM3RGhRMVVKRHpNZEdXMjQ0Z3JWOTd2?=
 =?utf-8?B?VHZaT3U3UDRHOGErREdhVzY4aXoreC80KytNdGF6aVQ5bGZ4ZVZITng2djJq?=
 =?utf-8?B?MDJxUHJWamJ3M2Q3TWlHSFo3czVYNm43bW1IcDIxTE56YWdxZEVHTExuNGNp?=
 =?utf-8?B?N055cnlVTWR6N0xZWEk3TklKd3ZFdXdpTXVQeWRSOW16Z0d1VEsxbjlDNDlX?=
 =?utf-8?B?OTdsaTZNOWdaalRCdGlNNWVhT0RJYkJRZ1htaWllSk1ZV1NOc2JEK0x3Mmt3?=
 =?utf-8?B?bk8yc0hvWlJXcUdlMGxKYndJQ1RvWGtEUlhHbHVidkRBZzdoTitvdDdRaTFk?=
 =?utf-8?B?YmVWOVdkelhXNkNxbHBxcXE0ZHpTbXhXTjByUFZDek5WUUd0MFYzV1ZzWUQy?=
 =?utf-8?B?c1E1UnRoR2RoWFBiVTlaNmdWRjY1TmJOREl6UTE2WnV4Z0pYUmVrYTg1b2Za?=
 =?utf-8?B?dmdqeTRzb0N0eHI4Sk9DY3QzZDlsZzRCY0JrRnNsV01wVDRDUHNyYUpHRWN2?=
 =?utf-8?B?VXZubTdTOWlvcHBUZUhEclFkM25vRUE5NElubVBtb1V1bE9Sa0FuREdBTGFI?=
 =?utf-8?B?OTFFVWNxYm1nZS9NazRGREJCdExNOGZaWStyUURJRlA4MUJXdlY1dXZEWXIz?=
 =?utf-8?B?emZIaCtWdnU4WUo5R1o5eHR4ZTh1c3pZVURvU1BQN3VOR1RHUFY1UGkzWXdU?=
 =?utf-8?B?QWZvSEQ2TkxLMUh2SlZPVVczSXgvRi9mMGlpd2lhaS9CTytzNytGMHRtTFky?=
 =?utf-8?B?RTBKa3AyWWlaR2FWeFJOaXl2VjBwWFNsYUtHMWxFU1ZXQURweEgzcnR3L2R0?=
 =?utf-8?B?WlY1eks4ZFRsTVFwWE9ZdjRBekhWdWpGdzdXWWhvcEUybnc1N1lRMGRFT2hx?=
 =?utf-8?B?VWNHTm9sNXFLbmxEM1lTN255SjlXNUw4T2daUnk1RmtZbkN3c2EreXVBYm41?=
 =?utf-8?B?ZXVPUFBTL1VCVWpuOGQrbm1XSE1SVU1ERlVVV0VjNVl5OGI5eFFaY05Kdkg3?=
 =?utf-8?B?RXg4N3BEL1haT05FRmNybWowS1VmRys2aUV1TVVQcnBDRmhwZmVtUkJOYjhH?=
 =?utf-8?B?K1J4ZHVnVTIxT3FITUpuTDVkc2toZk1lWnJWRGZ0STNiTzR3d0ZPRmxVWUtD?=
 =?utf-8?Q?/hkl4muG4IpO3pxNVJwytKM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA6F384B94921C449E91C683DA9B4575@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 391763d2-af92-4fd2-d3b1-08ddbfe41c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 19:01:00.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iFMZ471ikRmfndNivQpBRx+bSLnTUWhDf68o/P2sg0smYmnEHJseYNc7xrA5C527tpT+R4QfY43VyzZkpKzsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR15MB6580
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=68700df1 cx=c_pps p=wCmvBT1CAAAA:8 a=2h7+rz15EAxDzAjAtcO37Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=JF9118EUAAAA:8 a=Vw_SRoFIOPaLThrT0C8A:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: AW4WwglCkO5r2ncsKe1VM_KxC6DJ4ibV
X-Proofpoint-ORIG-GUID: AW4WwglCkO5r2ncsKe1VM_KxC6DJ4ibV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE1OSBTYWx0ZWRfXw9LE29tqPhhP SRwyQ9WwZ5jQkzA7uOj02EgqLAUfoF101k5EmKuv6WsRquJkgViKcNfON6WDAMbGq8YFtMVc4Ha DFCBXzk6qUK6V/uggzQwFq328OXjGBZ3VA0Zd/G2Ss0iJIhHh6VQ+fu+WjQ4A+GHMonNsPzYI2t
 nVY2Dt1H2cztISMp4aUBleTrVgGg88Wr1MTYSUV1/m0wog6WeCVmMyp6PzfGac8hc5vIEHuy5B1 FW1X4MacgXwiQjYuLtKdvpQMKDRB5RtTap5Lv+iZRpBcSaeYofgonEdsp4gQinE+M+7zoAviaNn s50N85kIRRv0EDlJ2zgS8lUacNxmhW+3dqzFU1v+FjLPfRkFTWVWApXV/F0+prNcyySTE++pFjs
 CcGb+sGjERlIL0eYjIgL/VhfrVTBM0G7Zcb+qYaQFQnUU1GIt24QM0a+lIcl1Xr5OmWUf94l
Subject: Re:  [PATCH] hfsplus: don't set REQ_SYNC for hfsplus_submit_bio()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100159

T24gVGh1LCAyMDI1LTA3LTEwIGF0IDA4OjM1ICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IGhmc3BsdXNfc3VibWl0X2JpbygpIGNhbGxlZCBieSBoZnNwbHVzX3N5bmNfZnMoKSB1
c2VzIGJkZXZfdmlydF9ydygpIHdoaWNoDQo+IGluIHR1cm4gdXNlcyBzdWJtaXRfYmlvX3dhaXQo
KSB0byBzdWJtaXQgdGhlIEJJTy4NCj4gDQo+IEJ1dCBzdWJtaXRfYmlvX3dhaXQoKSBhbHJlYWR5
IHNldHMgdGhlIFJFUV9TWU5DIGZsYWcgb24gdGhlIEJJTyBzbyB0aGVyZQ0KPiBpcyBubyBuZWVk
IGZvciBzZXR0aW5nIHRoZSBmbGFnIGluIGhmc3BsdXNfc3luY19mcygpIHdoZW4gY2FsbGluZw0K
PiBoZnNwbHVzX3N1Ym1pdF9iaW8oKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IC0tLQ0KPiAgZnMvaGZzcGx1
cy9zdXBlci5jIHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIv
ZnMvaGZzcGx1cy9zdXBlci5jDQo+IGluZGV4IDk0OGI4YWFlZTMzZS4uODUyN2U0ZWM0MDZlIDEw
MDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9zdXBl
ci5jDQo+IEBAIC0yMjIsOCArMjIyLDcgQEAgc3RhdGljIGludCBoZnNwbHVzX3N5bmNfZnMoc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgaW50IHdhaXQpDQo+ICANCj4gIAllcnJvcjIgPSBoZnNwbHVz
X3N1Ym1pdF9iaW8oc2IsDQo+ICAJCQkJICAgc2JpLT5wYXJ0X3N0YXJ0ICsgSEZTUExVU19WT0xI
RUFEX1NFQ1RPUiwNCj4gLQkJCQkgICBzYmktPnNfdmhkcl9idWYsIE5VTEwsIFJFUV9PUF9XUklU
RSB8DQo+IC0JCQkJICAgUkVRX1NZTkMpOw0KPiArCQkJCSAgIHNiaS0+c192aGRyX2J1ZiwgTlVM
TCwgUkVRX09QX1dSSVRFKTsNCj4gIAlpZiAoIWVycm9yKQ0KPiAgCQllcnJvciA9IGVycm9yMjsN
Cj4gIAlpZiAoIXdyaXRlX2JhY2t1cCkNCj4gQEAgLTIzMSw4ICsyMzAsNyBAQCBzdGF0aWMgaW50
IGhmc3BsdXNfc3luY19mcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBpbnQgd2FpdCkNCj4gIA0K
PiAgCWVycm9yMiA9IGhmc3BsdXNfc3VibWl0X2JpbyhzYiwNCj4gIAkJCQkgIHNiaS0+cGFydF9z
dGFydCArIHNiaS0+c2VjdF9jb3VudCAtIDIsDQo+IC0JCQkJICBzYmktPnNfYmFja3VwX3ZoZHJf
YnVmLCBOVUxMLCBSRVFfT1BfV1JJVEUgfA0KPiAtCQkJCSAgUkVRX1NZTkMpOw0KPiArCQkJCSAg
c2JpLT5zX2JhY2t1cF92aGRyX2J1ZiwgTlVMTCwgUkVRX09QX1dSSVRFKTsNCj4gIAlpZiAoIWVy
cm9yKQ0KPiAgCQllcnJvcjIgPSBlcnJvcjsNCj4gIG91dDoNCg0KTG9va3MgZ29vZCEgTmljZSBj
bGVhbnVwLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtv
LmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

