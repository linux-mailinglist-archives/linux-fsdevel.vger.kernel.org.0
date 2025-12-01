Return-Path: <linux-fsdevel+bounces-70372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F798C98FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB163344E92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D9269CE7;
	Mon,  1 Dec 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sS2MkJqX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD1260578;
	Mon,  1 Dec 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620092; cv=fail; b=fJyp6V6yffLMCqQhRvKP8bLAlpBjF/WdFuCEYrmFREpn18CkslfocLyoP1AWEQfP2avClaZe7nZ6+Vh9kZmMWEzLiNuP2E80Pm1dke9JMve0aHXW9UFul3prno1e6A20TzFQpbmbPb3qIRCcHnpabObW0GtXn1a80940oC30xcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620092; c=relaxed/simple;
	bh=SVXL0lOSrOOGgAyOuW8tSHH7lgpDeZx607IIqPv7N7k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fUlN+qsawFMlyTeOH8+Q8hzhjKnUjj5vDb24cSWtgDjqRgYT4q55cRjPpdsLSUQuxD/hzjkcZMixHfHUkV3X6ZLtLduxHf6fiid2G4d23G6Wedtor5dMiciq7ltPhCq0d9C5WDdyvv2cweEiMRHMxlN97oxd1qjSPDz7coPBfHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sS2MkJqX; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1H9c1U013242;
	Mon, 1 Dec 2025 20:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=SVXL0lOSrOOGgAyOuW8tSHH7lgpDeZx607IIqPv7N7k=; b=sS2MkJqX
	mc2alkX9do1em2gYhrZ6wjwO1simq3RI5EdfsAhSDhQR6tH9PfIB0sYAmSv123Jt
	quxQTNzvtBQI3KpClWTKYZKUvA6E7KzflPJIvM0G1ilRg+CLPoVfPu6b3MzsCGEx
	ooir1MUgD4DDeargKEAQZAKG1Hr6WGFNEf02I2epD2LwKw42SZ09bOjDMJXRnYsV
	tJnrzQhUH5mQwBbfnnjRlRhdZAxNV2Z7aAyvn02dBdr43WvWl4XMEuaYd40CtGEZ
	Wb0js4FEXeJNLSWEZktpm5OtmOIMBy45se5lXXyrM19PVNPjGcuIF9d73poz3yPO
	qnFL3r7Rkfx4ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uh760-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:14:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1KBMu8012140;
	Mon, 1 Dec 2025 20:14:45 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uh75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:14:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX16Ldt357d1UVP8LB0hGtr5AedjH3EJ2U5eJL6r99RQ+1Q0rqnQFZaHzWELbSfasEaWK4nOWa9rPBDsfT+PhtSKipvUjmGgExA7zKOBTZf7aLF57qj/4DlsnSo69/xb0PtpOaPKue+kLVXt0vJCZLld/okifILpx/sEY+bodkqMi59JwfNcTw3JDAavXD+aUaiP81iTKznwdqkCUY0SlOKP2jYar97Yuca3Rw3+lB42QjrGchg5TamB1l0zx8tBzhGmKKYaAam7SGcIWX3G6B2YueheLb4bSbTdzhWHRjbKLmQTSh4o6DAYqbt0C0N0PVAFTy4OMR53yzqVsOszOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVXL0lOSrOOGgAyOuW8tSHH7lgpDeZx607IIqPv7N7k=;
 b=BMxrOGpm1a4ommQAdiWvQMoPBiTjOoxsOAMDvt+QwepynZ4XaPa/PbbYy3QDFTuGCpDSxpbIYnDAwzNCdd8MhB+s6MHgipwXr0V7I7oThkfv0pZpcaiUfy/adngLS9M+8LiqLpFQ2r2o9lcLu2GQy+7G/LXvBNsuAi/qCQDZ8cMKOwcJ7S9D7xun/BnJ6VuZkyZTdbAnKL37iJ4yulAPUVH9jfGaBMINt2/MGRbeGmVYapG24IZkmvaL7vgrw2c3yFebunGokFBg53vLJX98ATQ3I6Ckd+gsmgA5n+d5/Y3IfElcv4j32tHYkSKpHCwU6HzB++6gvytpAZts1DjtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4771.namprd15.prod.outlook.com (2603:10b6:806:19f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:14:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:14:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 0/3] ceph: add subvolume metrics reporting
 support
Thread-Index: AQHcX6R7+Mzzidw5tU+OpPHGpWJMULUNPvYA
Date: Mon, 1 Dec 2025 20:14:40 +0000
Message-ID: <2711e9a7e3f01502e122b8d8f38b9b6ae4930e7e.camel@ibm.com>
References: <20251127134620.2035796-1-amarkuze@redhat.com>
In-Reply-To: <20251127134620.2035796-1-amarkuze@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4771:EE_
x-ms-office365-filtering-correlation-id: f50ac5fc-9451-4285-c49f-08de31164271
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTkrRElJUDN4NFYzMk1Eb213c1BHZCtRZmpzWHVEazQyYXZmV3ByK2NYamR1?=
 =?utf-8?B?cHVzNzdmdUxrM0tUQ2t3RGRENDBJaVhrQ3lnZTcyaG9qTlhTUUF3T25nZy9O?=
 =?utf-8?B?L3lVR0xzOWJqUHAvaVFSaUpLR2pUOHJpSTFIZkRvdzdRUEJXQWNWOExhcUJO?=
 =?utf-8?B?VE5acCtuMHRtb1d0VEVmLy9TTUVFdGR6aGJqOG8zZ0daRHBqVmJpUmNzc1pt?=
 =?utf-8?B?bmQ4RktpQkJTUTNhY1ptcEcxUWthSk5BWGdMcGpXVFhBcUFSbkp5QkVnbGc0?=
 =?utf-8?B?VnVKdjhXSXhXME96eVNLSzlhRG92OHZlM3NGTTRPeElwaVpHaW4wbTRBK3ln?=
 =?utf-8?B?ejdmQkhnM3AxVFpIWCtUUVYvZEJWZ0U5T1pUbWtjRGJ5UndqZk1KLzVGaTNa?=
 =?utf-8?B?Ums4ejdjTm9GRG9IdUY4aEl4SzRNeTVCcVZ3SnlZcG1NbnlSd0FvS0NIdndh?=
 =?utf-8?B?T1Jva3BOM3NGSlFZTDRzcEI0eElLcVdlbWZXZFJvWTdaUUY1T256M1paWDZO?=
 =?utf-8?B?VjcyMUd1b3lhSlNHb25vU2o4ZjRoUHJmZ3djYUZuemd0QU54TUx3bmNSQjdR?=
 =?utf-8?B?L2hNOVAvVkpzSWJlejRrZ0ZTUDJlNURERUI5MjVLZUk5RVorWWs0OTlOY0Rx?=
 =?utf-8?B?eVV3RG9BK28rWXBZMGE2Tnp2TjFlZko1U2FvV3UycW40Y1RwKy9yNGFueVQy?=
 =?utf-8?B?SzZuRTZ2QnluRmRlVEJrMmJjNnRaYWFlc0x2b0crZGJ6VUhROERzSkw2dGly?=
 =?utf-8?B?ZHRFT1lFWXhTY0I2Mi9PcU1PVUlhUDB0OFRsMnlpNzlLQkRBS09odkZqNGNF?=
 =?utf-8?B?REtCVHZrYjJSNTNVWjNLZ1VuZFUzSlhKR3FaclI1a3VNNUtvV2ZXRjVZRzl5?=
 =?utf-8?B?czlvMFdwdWN6S2VYQmxlQ3NVdVA0UlZabjFRc0tYQ0hONkhxb0VFZ29VdFVN?=
 =?utf-8?B?aXpCaFpYeVpDNHNlMy9WQkV6Z3AxNGpkdGEyU2RmU3dVWjdYTG03eHcvbndl?=
 =?utf-8?B?VVNhN2llK1RoQXNEbWVlREJ1NFpHK3dYNE5UdXZkRmwwTkkwSHZnQmJ5dVpW?=
 =?utf-8?B?dkpDTXBVbXp0NmFKUGZ3NzZ2SDhaQlFZQ2NJUm1nVXlFRnVNeCtBVzRreXMx?=
 =?utf-8?B?YzdFRjBUUTFWM1p4MjcvTXpyZFFJYlFmVWY0aHh1L2J3MExVSXFzUW9VMVpt?=
 =?utf-8?B?UHpEeUNwRmlvRVdFaGxMTzZmWUFzU0h6TjFGbnI2cHNBWGF5YjI0NHYySWxL?=
 =?utf-8?B?YVFFV0V2QkphaUdGK28zUnpwNi9FMDJhbWlxMGNMT2NMMkNacFRTcEdiZFVL?=
 =?utf-8?B?cHRGbHBFeTV3dHRPMVdtaHlSOVFqTkRCaUczUGJuSjZvdCtPcWhPVkJseXcy?=
 =?utf-8?B?dFpPQXRoY0VoT2ZFTmNJUktzVmhjN3ZPNXY5Vk5lUXBoR1ZsMEthd1J5cTlN?=
 =?utf-8?B?WTNocVRMMmJvZW1Ob0gwWUhHTW9pN2k4bkVLNldobDFhOGVUNXM3RW5HWGVS?=
 =?utf-8?B?V0ZRSmlRekVSOWFTS3RCWkwxaDBQRVQ4T1RpMVFhZ2NIVTk3V2RyQjRpUjFY?=
 =?utf-8?B?ZXlobDBtMHJoTTd6Z3FWWTBjUWVxdzl1ektNY1NaWDE4Sk14bFJqbzFoZmk1?=
 =?utf-8?B?QWVBNjJvYnQzeFZRT0RvUHJyb1I1RnZZRTE2Z1cvTkJjOHNlWjV2U2IrSFlC?=
 =?utf-8?B?dDhkRnNNQVFUMG9vODR4dTRXcE9KNFR4Z1Q4Ym8wUFRRenhGejRCUVcvOHI2?=
 =?utf-8?B?RVhsN3pDN2FQMzZ2NEdCVHNvd0pDY205cTNyZklrMzhHU1NETklQc1J2YVVm?=
 =?utf-8?B?VUV5RG9XNXh5VUFlYnBJUHg5d09DMURrM095UG01TzRwQVYzTjlIM0MwN1NX?=
 =?utf-8?B?bDczbEtDd0F3YTlJTXVwVGpkaUtQb1llVUFLTFpwVDh3ZUk0Smh5SlVvVmRo?=
 =?utf-8?B?aVphd3MvSWIzVlhJcjBXYU1SajB0NVh6cFVNNCt2dlI2TldERWZXajFsRmE2?=
 =?utf-8?B?M2VSWVNqOVBmeTdQUVpTbm9vSXJyR0lxbDF5a2JKaUcxWWFVK1d3czYrM1Qy?=
 =?utf-8?Q?2RBY5R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjNIQzVNWXkzZWMrSGRMaGkwWXV5dGNkaTFwbkNub1UvTFlYTUEyT3Q0d1p4?=
 =?utf-8?B?cGlONTRaOWlDRjZGQVYzamFUazEzU0oybndsL29YZUZ3M3I3OUxKMVBLdSs3?=
 =?utf-8?B?ajYzOGpzZi9Od1dRbkw1REVuUGdYMDBOa2ZYSTRqbUV0OUFHY3hoYmxuWTVz?=
 =?utf-8?B?OFYvOW1mc3puQTZFck5UOXJYekdZVkFaSVZCRkRaU2l4MjJldjBFRFl5RnBq?=
 =?utf-8?B?b24zdVRjSFM0aTRUUTV3eVpLUWZGc2RZZVJpemFhSVlDNjAyMmRZaU9nMGF5?=
 =?utf-8?B?L2FNTWM5TFI4UXdQeXFlRFpiTDRBVGVoaHJMQkJVTWlXd1NNOWNrek9ZbkxD?=
 =?utf-8?B?UklQaDJOeTJFMkZpTWpIWUJTTXYwRTNHT3ZBQm55L3ZJU2xvZUlCUHlCeElI?=
 =?utf-8?B?U0dNWkluUlJsNE51LytxYXpTV3YrMzg1NEZGT0ZhaGR6QkhZYVJ0YmJLSmk4?=
 =?utf-8?B?S3BMRnNXekFvWmF4Njk4bWpQN25sVmlaeDM2VlhSNlNLeG1hT0F5cEg1eDZ3?=
 =?utf-8?B?dTlGTWdtS25nRHk1ZVY5ZGd6RXJidy9SeEZEa2tGR3U5Ymh6YzNJRWJGbzZ2?=
 =?utf-8?B?d3BpS1FzVnM2REVEVWU1c2dqT3prcmk1Uk9KVTAwckdpa3FmMVBNMlF4SnhE?=
 =?utf-8?B?b2o0NkROK1NDdTNHakIwYlpiaCtpNmlacXE2eFRRYnFuL1B3K2ZKeEhOSXZr?=
 =?utf-8?B?VURqc2Q2ejhnSXRKbXZhQTlKSElFRWUyakNnbmNab0FVZXJPK1diNytSOVNu?=
 =?utf-8?B?bzlIaEpFakZubXJBWEhiQ0k3LytMaXM2clpQbkt5VnBoa3IwdEJXaWQ5cGJv?=
 =?utf-8?B?MEM0bnM2YWt3cUNSeklYbjN3MzFMb1RxOWZhZ3UxYzNjMURZRW5lRmpLQUdq?=
 =?utf-8?B?S1hXWnhnUGtucDBnNkU3S0QrSXVTeHNMR2QzZ2JtT3FtRkxyQ1pSY2VBQkJk?=
 =?utf-8?B?UFdiQXIyeDJ2dlNEWjgzNTJjRGpTV2g0c1R5YzZoR3BuSk55TUJ6YWlKWm1m?=
 =?utf-8?B?MmZGYktSa1Z4SWNRb2xQVGo5a2FnZnRyUzAxaFRibVRZSDB6VU03SVQzSHZa?=
 =?utf-8?B?UXRGMHJ3bzVoU0FUaEkveUFUOXMxcmhEdkF2aUp6SkpVY3BlZDNRanFkOXRB?=
 =?utf-8?B?YkxwRmpJRHdsU2oxeVlUcTIrbFN2SUtGNTcrSFNQWmlPbkl2Nll5dW9iYnAz?=
 =?utf-8?B?MSt6OG5RRkx1RlpQOHA0d2NKUFh5Z1R0MUZQYTFIdysvWkFZSG9jcFBoUjJk?=
 =?utf-8?B?eng3VFJpc2o5aFJ3TktHWWlSZ05aUll6N1dWTTFJeHYrdGV0Y0dWTU1adVcw?=
 =?utf-8?B?Qjh4dEtrL1hkK2JSeVpvYlNFdEk4U1pDSStjR3dudll0QnBuM2ZOYnZXUnZN?=
 =?utf-8?B?Q1lkV3NKTVVVaXF4VE9vY2RhV3ZGY0NLTGdjVjVjaHVGSmNSNmc1ekJhMDBj?=
 =?utf-8?B?Zmo0NTdyamlVcUNFRkxUUWVWSjBMek5KSmVYcktjcFVOYXN1WlJ4ZGswRXBQ?=
 =?utf-8?B?R3h0Nnp6VStxT2NNN0FHUzk5V2VGQ3hQU3lFbzhaS2VOS2ZKc2llNkxQYWgv?=
 =?utf-8?B?RWovTjd3SW02T1FlVENMaVNuN0RRSDY1ZnlPbjlLK2RUUnFtUGlIdnNYOTIy?=
 =?utf-8?B?UEVpSGZwWENFVGNFVnRSZU1DNE9TbzgwTkc2NlFWVG9hbWx2VzU0S1hFb2RS?=
 =?utf-8?B?SFltNTNmdStIZ3VTRWZwNldLMWFXc1pQNDROZlZCOGdpSWlZQ1A5RG9wZkxh?=
 =?utf-8?B?RGIvNTQwck1HQkdGWHEyYjNKRy84K3AvOHRJZXdtSmZVSjhMekE5Rk45WmRu?=
 =?utf-8?B?bG5hbWxNcnBwNjNYMGJGOHdrVkljdmJmaktqNzdpMUFSSUQvL0YvL1loUDAz?=
 =?utf-8?B?ejFQdzhZcDhWK2toVFRqOG5uOTFaVU5zQmdpd3ZTWnRibFJVUGNsVEtMZzRZ?=
 =?utf-8?B?YjR2QTVyODNRdExDVnlmK2g5bGxIclQ4UklTZW9ZTThOaGJhQjRJaVo3OWF3?=
 =?utf-8?B?dHo5NEMxTGNVc09Dc09KcC8wdTRpMEZ6MzJBUGVVaVplbEJzQXJMaGt4MGY3?=
 =?utf-8?B?THVDMk5sODEwTUJMZjRYeWt4Ny9qZ1crTCtNZmlEL3FPRERTMG1sUU5EVE92?=
 =?utf-8?B?VVpnbUxPNUVuRFcxTmxpb1VVL2VBVTFiQjVPd2pseHA3TlQxeVlkOHNOeGpK?=
 =?utf-8?Q?gzMPoKDClc6e7b2Qwj/mmY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DE87388A7E03140AAD3B0EBB40BF0D2@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f50ac5fc-9451-4285-c49f-08de31164271
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 20:14:40.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FsanxtnehbpmoHu6B8LQbyK08dG3Z5WykJxhfHwxtWVfLgCMZs66R88WdYQKQ/SsevZuv5pcCZjONWoolmIjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4771
X-Proofpoint-ORIG-GUID: G_sL7pDHUvNa2cxIQha47np-dswmv102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfXxTdOB9huDizy
 jmUZ01XHZg3lK0Wz1in3QONiu3Ea3OTA7W6HjwjOiJ9s2/ukDv1WyPh1zFxsXvLkjvZBIM6SRI8
 PP430k3Lrfg+fR/IkAovcaifTC4XbyEDOpNczlG0C+TLF1hfuzYKFz3GTiNqLlZB4WEbs8YDzrL
 Fli9hUdV9Iwg6eKtbfXUtcDUx/vR4z84frnRPo8Vcwac4EsRTwbcwzfw/DiNuQjZLoZpefwRYnP
 SmrVBuy00/TvXfsLOSLHEadiOGnVNpgzkvPQaJ77o5fb0v2z3R40kGoKqAylDtNTlbsGMTyFb4M
 lA+yk0GF+9F/BVyq4lRdRt0ZSa655RqC/W9ivriXfH4TKwAhGTn6g6t9oa6DPy67vX5NFbFVC8Y
 JnV27rZv1ooD1x2S5CVBYYZv07GM+w==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692df735 cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=L7nPj8gBwv4XBK4i24wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Oj_JpPmSXfLmXw1mPuAkXIags8FaMbES
Subject: Re:  [PATCH 0/3] ceph: add subvolume metrics reporting support
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

T24gVGh1LCAyMDI1LTExLTI3IGF0IDEzOjQ2ICswMDAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgcGVyLXN1YnZvbHVtZSBJL08gbWV0
cmljcyBjb2xsZWN0aW9uDQo+IGFuZCByZXBvcnRpbmcgdG8gdGhlIE1EUy4gVGhpcyBlbmFibGVz
IGFkbWluaXN0cmF0b3JzIHRvIG1vbml0b3IgSS9PDQo+IHBhdHRlcm5zIGF0IHRoZSBzdWJ2b2x1
bWUgZ3JhbnVsYXJpdHksIHdoaWNoIGlzIHVzZWZ1bCBmb3IgbXVsdGktdGVuYW50DQo+IENlcGhG
UyBkZXBsb3ltZW50cyB3aGVyZSBkaWZmZXJlbnQgc3Vidm9sdW1lcyBtYXkgYmUgYWxsb2NhdGVk
IHRvDQo+IGRpZmZlcmVudCB1c2VycyBvciBhcHBsaWNhdGlvbnMuDQo+IA0KPiBUaGUgaW1wbGVt
ZW50YXRpb24gcmVxdWlyZXMgcHJvdG9jb2wgY2hhbmdlcyB0byByZWNlaXZlIHRoZSBzdWJ2b2x1
bWVfaWQNCj4gZnJvbSB0aGUgTURTIChJbm9kZVN0YXQgdjkpLCBhbmQgaW50cm9kdWNlcyBhIG5l
dyBtZXRyaWNzIHR5cGUNCj4gKENMSUVOVF9NRVRSSUNfVFlQRV9TVUJWT0xVTUVfTUVUUklDUykg
Zm9yIHJlcG9ydGluZyBhZ2dyZWdhdGVkIEkvTw0KPiBzdGF0aXN0aWNzIGJhY2sgdG8gdGhlIE1E
Uy4NCj4gDQo+IFBhdGNoIDEgYWRkcyBmb3J3YXJkLWNvbXBhdGlibGUgaGFuZGxpbmcgZm9yIElu
b2RlU3RhdCB2OC4gVGhlIE1EUyB2OA0KPiBlbmNvZGluZyBhZGRlZCBhIHZlcnNpb25lZCBvcHRt
ZXRhZGF0YSBmaWVsZCBjb250YWluaW5nIG9wdGlvbmFsIGlub2RlDQoNCldoYXQgaXMgIm9wdG1l
dGFkYXRhIj8gRG8geW91IG1lYW4gIm9wdCBtZXRhZGF0YSIgaGVyZT8gRG9lcyBpdCBleGFjdCBu
YW1lIG9mDQp0aGUgZmllbGQ/DQoNClRoYW5rcywNClNsYXZhLg0KDQo+IG1ldGFkYXRhIHN1Y2gg
YXMgY2hhcm1hcCAoZm9yIGNhc2UtaW5zZW5zaXRpdmUvY2FzZS1wcmVzZXJ2aW5nIGZpbGUNCj4g
c3lzdGVtcykuIFRoZSBrZXJuZWwgY2xpZW50IGRvZXMgbm90IGN1cnJlbnRseSBzdXBwb3J0IGNh
c2UtaW5zZW5zaXRpdmUNCj4gbG9va3Vwcywgc28gdGhpcyBmaWVsZCBpcyBza2lwcGVkIHJhdGhl
ciB0aGFuIHBhcnNlZC4gVGhpcyBlbnN1cmVzDQo+IGZvcndhcmQgY29tcGF0aWJpbGl0eSB3aXRo
IG5ld2VyIE1EUyBzZXJ2ZXJzIHdpdGhvdXQgcmVxdWlyaW5nIHRoZQ0KPiBmdWxsIGNhc2UtaW5z
ZW5zaXRpdml0eSBmZWF0dXJlIGltcGxlbWVudGF0aW9uLg0KPiANCj4gUGF0Y2ggMiBhZGRzIHN1
cHBvcnQgZm9yIHBhcnNpbmcgdGhlIHN1YnZvbHVtZV9pZCBmaWVsZCBmcm9tIElub2RlU3RhdA0K
PiB2OSBhbmQgc3RvcmluZyBpdCBpbiB0aGUgaW5vZGUgc3RydWN0dXJlIGZvciBsYXRlciB1c2Uu
DQo+IA0KPiBQYXRjaCAzIGFkZHMgdGhlIGNvbXBsZXRlIHN1YnZvbHVtZSBtZXRyaWNzIGluZnJh
c3RydWN0dXJlOg0KPiAtIENFUEhGU19GRUFUVVJFX1NVQlZPTFVNRV9NRVRSSUNTIGZlYXR1cmUg
ZmxhZyBmb3IgTURTIG5lZ290aWF0aW9uDQo+IC0gUmVkLWJsYWNrIHRyZWUgYmFzZWQgbWV0cmlj
cyB0cmFja2VyIGZvciBlZmZpY2llbnQgcGVyLXN1YnZvbHVtZQ0KPiAgIGFnZ3JlZ2F0aW9uDQo+
IC0gV2lyZSBmb3JtYXQgZW5jb2RpbmcgbWF0Y2hpbmcgdGhlIE1EUyBDKysgQWdncmVnYXRlZElP
TWV0cmljcyBzdHJ1Y3QNCj4gLSBJbnRlZ3JhdGlvbiB3aXRoIHRoZSBleGlzdGluZyBDTElFTlRf
TUVUUklDUyBtZXNzYWdlDQo+IC0gUmVjb3JkaW5nIG9mIEkvTyBvcGVyYXRpb25zIGZyb20gZmls
ZSByZWFkL3dyaXRlIGFuZCB3cml0ZWJhY2sgcGF0aHMNCj4gLSBEZWJ1Z2ZzIGludGVyZmFjZXMg
Zm9yIG1vbml0b3JpbmcNCj4gDQo+IE1ldHJpY3MgdHJhY2tlZCBwZXIgc3Vidm9sdW1lIGluY2x1
ZGU6DQo+IC0gUmVhZC93cml0ZSBvcGVyYXRpb24gY291bnRzDQo+IC0gUmVhZC93cml0ZSBieXRl
IGNvdW50cw0KPiAtIFJlYWQvd3JpdGUgbGF0ZW5jeSBzdW1zIChmb3IgYXZlcmFnZSBjYWxjdWxh
dGlvbikNCj4gDQo+IFRoZSBtZXRyaWNzIGFyZSBwZXJpb2RpY2FsbHkgc2VudCB0byB0aGUgTURT
IGFzIHBhcnQgb2YgdGhlIGV4aXN0aW5nDQo+IG1ldHJpY3MgcmVwb3J0aW5nIGluZnJhc3RydWN0
dXJlIHdoZW4gdGhlIE1EUyBhZHZlcnRpc2VzIHN1cHBvcnQgZm9yDQo+IHRoZSBTVUJWT0xVTUVf
TUVUUklDUyBmZWF0dXJlLg0KPiANCj4gRGVidWdmcyBhZGRpdGlvbnMgaW4gUGF0Y2ggMzoNCj4g
LSBtZXRyaWNzL3N1YnZvbHVtZXM6IGRpc3BsYXlzIGxhc3Qgc2VudCBhbmQgcGVuZGluZyBzdWJ2
b2x1bWUgbWV0cmljcw0KPiAtIG1ldHJpY3MvbWV0cmljX2ZlYXR1cmVzOiBkaXNwbGF5cyBNRFMg
c2Vzc2lvbiBmZWF0dXJlIG5lZ290aWF0aW9uDQo+ICAgc3RhdHVzLCBzaG93aW5nIHdoaWNoIG1l
dHJpYy1yZWxhdGVkIGZlYXR1cmVzIGFyZSBlbmFibGVkIChpbmNsdWRpbmcNCj4gICBNRVRSSUNf
Q09MTEVDVCBhbmQgU1VCVk9MVU1FX01FVFJJQ1MpDQo+IA0KPiBBbGV4IE1hcmt1emUgKDMpOg0K
PiAgIGNlcGg6IGhhbmRsZSBJbm9kZVN0YXQgdjggdmVyc2lvbmVkIGZpZWxkIGluIHJlcGx5IHBh
cnNpbmcNCj4gICBjZXBoOiBwYXJzZSBzdWJ2b2x1bWVfaWQgZnJvbSBJbm9kZVN0YXQgdjkgYW5k
IHN0b3JlIGluIGlub2RlDQo+ICAgY2VwaDogYWRkIHN1YnZvbHVtZSBtZXRyaWNzIGNvbGxlY3Rp
b24gYW5kIHJlcG9ydGluZw0KPiANCj4gIGZzL2NlcGgvTWFrZWZpbGUgICAgICAgICAgICB8ICAg
MiArLQ0KPiAgZnMvY2VwaC9hZGRyLmMgICAgICAgICAgICAgIHwgIDEwICsNCj4gIGZzL2NlcGgv
ZGVidWdmcy5jICAgICAgICAgICB8IDE1MyArKysrKysrKysrKysrKw0KPiAgZnMvY2VwaC9maWxl
LmMgICAgICAgICAgICAgIHwgIDU4ICsrKystDQo+ICBmcy9jZXBoL2lub2RlLmMgICAgICAgICAg
ICAgfCAgMTkgKysNCj4gIGZzL2NlcGgvbWRzX2NsaWVudC5jICAgICAgICB8ICA4OSArKysrKyst
LQ0KPiAgZnMvY2VwaC9tZHNfY2xpZW50LmggICAgICAgIHwgIDE0ICstDQo+ICBmcy9jZXBoL21l
dHJpYy5jICAgICAgICAgICAgfCAxNzIgKysrKysrKysrKysrKystDQo+ICBmcy9jZXBoL21ldHJp
Yy5oICAgICAgICAgICAgfCAgMjcgKystDQo+ICBmcy9jZXBoL3N1YnZvbHVtZV9tZXRyaWNzLmMg
fCA0MDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBmcy9jZXBoL3N1
YnZvbHVtZV9tZXRyaWNzLmggfCAgNjggKysrKysrDQo+ICBmcy9jZXBoL3N1cGVyLmMgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgZnMvY2VwaC9zdXBlci5oICAgICAgICAgICAgIHwgICAzICsNCj4g
IDEzIGZpbGVzIGNoYW5nZWQsIDk5NyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9jZXBoL3N1YnZvbHVtZV9tZXRyaWNzLmMNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBmcy9jZXBoL3N1YnZvbHVtZV9tZXRyaWNzLmgNCg==

