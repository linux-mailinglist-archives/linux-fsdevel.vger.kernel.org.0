Return-Path: <linux-fsdevel+bounces-47944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38707AA7A17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30861B6748B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF91F12FA;
	Fri,  2 May 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KRfFvVuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2AD1AA1E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213271; cv=fail; b=r2VyZEOtXEzmb3yqnVzLNvNfqLSFCHoeuqDbScl1IFszOk9sMEB3mvg2MF7az/XpgVX41g1OnVI4LcbYI1U/q+jHLxkdbNm2mnmOcPZ5+DV7YpmZBqzMYgyfS62PPyN3cAdKSaj8IiFrb2CRICP1iHJe8Eg6WDrivpp8nKr/B3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213271; c=relaxed/simple;
	bh=4l8d+k54r0n3oU1zSFUXYWBSLkaIAcsuudNLSh6MOXI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sFjoTYgY+ubmgdNKQucfXjM9UXc8m2epvCt/2Smf+7oiLUZeCgb6bwYXfrVd/uVcjSAzMdXJPQK1tY5NambqYkQPOUfzHNWk+aCmkS4CLuvqxFGDZE+eYRD/J0FGPea3FE1XjsdKTdZHG/+2eJGoEWpcc5xpJdNxaV602/Ja2co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KRfFvVuq; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542IvMNi030663
	for <linux-fsdevel@vger.kernel.org>; Fri, 2 May 2025 19:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=K7bEFAguGpWWyP5SH3HvLbxPqPdhzB1+1rSiddhE9ms=; b=KRfFvVuq
	w+lt4mW46s3lx62ltBUCKaeZIwcRQ2er5HQiaY5FetEaKq5IOE6rbzLGj6oKk5IW
	OQAmbX07FMlO+W1/cbFgOyWDHjdglpb5Sm4MbSwBMraVsQPjdGNiXklP/f3KSmND
	YxGwcNEeHOlp3iFpwJJ3PHE2F0nTzRp310DgwKpbmwhycjdy8MHn7wFA8WWGl25L
	DWQpwqQnxFuHvzQ3j2HN+T0E3ua2DKCyiFRlzTo/rdMr4QSaEbezOs23Dxl3uD5Z
	lP2LquZngNCx0Aok5yZBWJuFdHYW0/HlvmFQil3Y0hVFA7AJuZ2Kg4HrZGOSGrdN
	MiscuzJPHPdnBQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cuykaa3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 19:14:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 542J8Vcx004449
	for <linux-fsdevel@vger.kernel.org>; Fri, 2 May 2025 19:14:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46cuykaa34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 19:14:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anka0owpBCQ9o6PsNAEsTW3y6gVb2LGJcJ+bXVlF0hRUBi3HwDyFAiaBA46X5w/Gk2yIffTRk7fQXPjikpUTAw5oJyGuk3iSdTQMyKg0yV/yOPD7ojja8bcdpKE04KNOjGOjxm3yTiGy3tviJ77BKNA7yL0cc/gb6pfjZjSl+9HXeJJZNPaR2OHWyaBXtXD7fVA83pUTfx/m5uv1yLXoOXFgA1CsBXQfrmkwmg8rcTjgYvRHLfLO6da8aa68iSSK01n7sSlxsiMt8cIWFoHGPKuFJROA2350hELcbtggQ7cG7FxFTxlikxshxOMRBR+O2W4ANcAKp12gbN1NJ62DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uspOIDX14duchjy6Fo82orOxMoYy8ivmTRYntT0rlbQ=;
 b=K/WLPrQNMpo35pmJVe4j/ktB4wj9cIKsLytB9sSQmL7IarNoR4gd0OwZFqhsG+0KbIal5kqbQkHRdBVAQDDLljVopne5af0rzyyBbbe/w3nGy6vlj5DLAPcPbG4D/sCSArGQ4mC2MCsmZ5V6KmHZ2taYE8OSE/vV46JT7YSeULIZm8DOD1Nhx47dDdxIK4CVgm9g9kO6uAjUrlxVSd9d0ic8gneF7WO+aJ17kKUOIOaPMUZnupUoFcXtZboQU6PIuuZCzz5GXgMnhwXS89W9wkYbdBya9ymUFHYmmX9CMN6gKoVlpSi2YbIbVq7tnbjyZPycbF5InfHJC0e+NC75cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4421.namprd15.prod.outlook.com (2603:10b6:a03:372::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 19:14:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:14:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSBSZTog5Zue5aSNOiAg5Zue5aSNOiAg5Zue5aSNOiDlm54=?=
 =?utf-8?B?5aSNOiBIRlMvSEZTKyBtYWludGFpbmVyc2hpcCBhY3Rpb24gaXRlbXM=?=
Thread-Index: AQHbuw53qFDnaUF3rUaiuT9fy8DnH7O/triA
Date: Fri, 2 May 2025 19:14:26 +0000
Message-ID: <471a4f96e399d84ead760528cb0b049464f83845.camel@ibm.com>
References:
 <7f81ec6af1c0f89596713e144abd89d486d9d986.camel@physik.fu-berlin.de>
	 <787a6449b3ba3dce8c163b6e5b9c3d1ec1b302e4.camel@ibm.com>
	 <TYZPR06MB527574C2A8265BF6912994E6E8842@TYZPR06MB5275.apcprd06.prod.outlook.com>
	 <84ebd3fb27957d926fc145a28b38c1ac737c5953.camel@physik.fu-berlin.de>
	 <SEZPR06MB5269CBE385E73704B368001AE8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <d35a7b6e8fce1e894e74133d7e2fbe0461c2d0a5.camel@ibm.com>
	 <SEZPR06MB5269BB960025304C687D6270E8842@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <97cd591a7b5a2f8e544f0c00aeea98cd88f19349.camel@ibm.com>
	 <SEZPR06MB52699F3D7B651C40266E4445E8872@SEZPR06MB5269.apcprd06.prod.outlook.com>
	 <7b76ad938f586658950d2e878759d9cbcd8644e1.camel@ibm.com>
	 <20250502030108.GC205188@mit.edu>
In-Reply-To: <20250502030108.GC205188@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4421:EE_
x-ms-office365-filtering-correlation-id: 8996db5c-0b91-4d9d-8e68-08dd89ad8e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVVZL2J0RExlVHhCYVlvQXRWK09FVm5DbXM5c0QvRHA5OUUrelJqZXExQnZi?=
 =?utf-8?B?dzNPS0JJWFZvT3lpSVlHRWhYWVJCRUdKOHJvdmI1VzJjTWtSdXJFVTZZdSti?=
 =?utf-8?B?ektRaGMwcEhDYml0WjlxdkJTcGNWUkhQY05pVllpTjIyYW94eXBkZzc0WUJt?=
 =?utf-8?B?T2ZyMzBXSnlMZnpiNFhwckxrVWRBNkUxR1VXaHFmOG9RTGcxMFZvSEhkS2du?=
 =?utf-8?B?RDhTRGszSlRjSTJ5ZFovQ1VEWjZPNFNnUjk0d3BoejBsN1VYYy8rZ08yNi9H?=
 =?utf-8?B?TjJJSXovc1lMTUNlaTB1eVRrQ1dOT2xYdWp6cUlHeUhjTzNFY2gxTnpYK0VR?=
 =?utf-8?B?cFZWYi9LSHlGcG9mQ1ZtZlpMdkQ1OXJSYmJNYlJ6Y0F4UmxvMUlYbGUvalM3?=
 =?utf-8?B?NnRBbzVxUVVDVTZWY0t5cmkycU1zc01zT0tRd1VCbXdkRGtMM0ZCRG11UzVX?=
 =?utf-8?B?ZWVNWHZnRjFxNXZBSlJ0YzZBQVVZVjVveFd1MDZKOXFuVFRPcFpyeHdZWnRs?=
 =?utf-8?B?eDBUQ2hOS1BsZnZxNGMzWDVVRkhiSW9XSG5YU2ZNVjVndlZpSGRWNG44WE5D?=
 =?utf-8?B?Y3V5Z0M2MVRVd1lwTkVVYXB3Tyt6UWJlZVNZMUs5bTdsanlpejRZbWdPd1M0?=
 =?utf-8?B?TERIME9OZ2tRNExiM25rOStBdVN0ZHRyTU8yVDZBaEhPMkdpNEdEd2F0dDlO?=
 =?utf-8?B?aURWMitGaUV1WWRpUExUY1ZMOTFheUN0QTYzSVZES0pTdGxvblhWanlCRWN5?=
 =?utf-8?B?c0Rjc3FBT0dqQU5pMi91ai9xeTBlMmdYVFg3MnJJZVNSdFoxbEVsb1NZVm4w?=
 =?utf-8?B?QUYzZDZybnBHR3lFTUVBc2Fwakw2Yll4R0ptODV6Y3Bza1dvUHZsNVg1TUhZ?=
 =?utf-8?B?QjE5a0NweXZJeHVwcjRLTDRPTTVLbkhOUm9ZRmZGcytROUJWOUtuU09uN1pq?=
 =?utf-8?B?Wmk0RVNHdFBNdVFsS2g0L2svZFBYdVdMSDBqNDI1N2oxVFAvTDNNREpqeGRB?=
 =?utf-8?B?S1p1MGpsYXgrNVJnb3g0cEs2U0FySzFDYXNpbTZYcExnQkhNODFmUjBVMzF6?=
 =?utf-8?B?ZVR1NnN4NEdLMzlqa01nYTFmUm54cWMvTmFaUmlMbm9wejVrMHZuSVY4RkhV?=
 =?utf-8?B?RnBsV1hKUWdJRGhjTUVnRitWeUZUemdJYU05QzBNbUNFMVV0Vkt1VGdXdGdk?=
 =?utf-8?B?TUxrZWN1bDc3TlBVc0VDTTRmUlF5S0UvUkczSXlFaUtDb3IvTU05ZHp2amx0?=
 =?utf-8?B?Y3M5NUprSWkyNmZBMU1sRUZaVHJONEtYZkIxd2JQdXptZjZmdlJTblZXVUNI?=
 =?utf-8?B?YkoyZVpUUlo1VmFVbU9TakZzOFJNL01lWDZJd3FIdksraE5WRTA0bUFpN3hG?=
 =?utf-8?B?ZkxVOUxrOFhmakRHZUo2dzVOc2o4UkRrU3pNdEhrWEhERjViYzhOWnVKbmJO?=
 =?utf-8?B?N1pPUVI2KzJpc3NsaThibHJKSXBYNW83NFlXdzNveXl3ZExuZDUxOGwwdHgy?=
 =?utf-8?B?SFBZcUIvV1VqUzVzeWlZaUNMcjl1WTFzZ2dHNFlnT3lDQlZzSEYvUUJmYXBv?=
 =?utf-8?B?K0h2WUoremp1NDNVZDZaaUdVRUN1YlhHQ3dsV3Z1M0VzMWg1cTEyaTBzWU44?=
 =?utf-8?B?NmoxMHB2K0NiMUViZFZUMjhtN3NYNG52b3EwNWwwTHBsS2pnaC83T3loV2pJ?=
 =?utf-8?B?aGFsNnRwMzFzRjRyMmsveDdWZTJKMFNieEduaEtXazFZMUcvcU9mRERVN2xl?=
 =?utf-8?B?MUk5ejYrOTN2SXhyTlpibXJsU0NDSFgwUk5ueDdDM3pnd1NwaURXMmY2YnMr?=
 =?utf-8?B?SExqcnNCQkpQQStjbXFiOGxMMFhsZUhtb2RkSFJHMXArYnVHYURJRkhkZVNx?=
 =?utf-8?B?eGcwMWFYNC9YcEFycDRIMFdXSFhYQ3AwT1hubjk2Wks5R2JDV29YaVBtK2pm?=
 =?utf-8?Q?uYm94oj9rAA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEYwZHVCV2xacm5jWFkxOTVJNWVlclBnU1FlZ1VRMnRvcFVlWnFIemxQSTJ6?=
 =?utf-8?B?Y2dGWTVZblJkaW9uQ2VwM0orY2ZHTXgwTXgvOFZnUjJWV1BlbmtXcElJT3Fi?=
 =?utf-8?B?WERSb3ZkQmVManRGMWJVOFl6OElCRGF1VDVFVlBBR2FkY2U2NVNXU2tObG5S?=
 =?utf-8?B?NnZvelJpaVZkUW1aSkdpdWlab3RvK3E1R2xhNUcvV2NqdGU2NFlyQWtYRUtT?=
 =?utf-8?B?TDBnODNqQ3VUaHpIQnVUaERxUVJYQjB0NTkvb2ZKa2xGTG0xNCtoWE9sM1FT?=
 =?utf-8?B?ZTdJZmE0OHJXRGh4ZjFycVpIbmU0cnVqbEI3SUgwQzRBdGxzVlVtb2dHTWhm?=
 =?utf-8?B?WHVTVzhISE93YThkRGZnZjhhOTNETzNQam0zWUZuM2N2SURrUkVOb0thWHNq?=
 =?utf-8?B?dFpCbFBmSUFjS1BveTNJQnp4cGxNZUdyTjdpb29oQTROR1UzL2hZY3Y0NGZT?=
 =?utf-8?B?TmhlcCtQMjR1WjhFQytReURVdUJVNC9Vb2xram5Nc0p2VDEvS1d4ek95bVRu?=
 =?utf-8?B?dFhUY0JFeXA2dWk1YmV0bW5qa0Z3M3FVR3A1ZmlZZWdrMUV4NTdhc1ZpNklH?=
 =?utf-8?B?MlpxeFFEYVVhLytXR24ra3JXbWVZRHdUaVdvbVBWMjdkVG1NalZOTitJbjF2?=
 =?utf-8?B?SFg0TmF6RTZ5V3dqMkphYm5adGhqeTlDWk1OaGN2cDVuUStLMXZmVW5IdHdU?=
 =?utf-8?B?cmdrdUZYbnVicHZScHVXeVBCQ2NrR1hpcERhNXZUSG90d3A3RVNqSkJ3NWht?=
 =?utf-8?B?V3QvSXJ6QVlRV08vOTEyaWd3WjN6V0djWGF5bHpEUmJEUWJqVTNZYUI0L3NJ?=
 =?utf-8?B?RnRnU1lQeHpvNTAwQ25keWpxRExpUEhTOU84RERMT3dHb3Rlck8rUFBsa28z?=
 =?utf-8?B?NGppSmVoR0hBaDk0Vnk5U09nWURJN0laV3Y4VkNMOXdiZ3hpMkUvWkRlVGdQ?=
 =?utf-8?B?ek1mTTVrdExobWJEcXY0Ni9BRllIVlVUVXYwNkFLZXVZcUtnZkQyVllyMmlC?=
 =?utf-8?B?NkZSeDltZEkveTJqY2VwZEg3SWJwbnpHdEllMzY2bGdxc3JPbGNudzdvMnFo?=
 =?utf-8?B?amJWMFFaZWpETmQrSjZzNnRLWGMvaVFPaFBZVndBYjFPNTBRQWZobkh2V0xC?=
 =?utf-8?B?SWVLbnBCMXpTek9sazJCcFZIdDdwQW1pNWF2b240STNXU1JjUjZqZy9YVkcv?=
 =?utf-8?B?d1VmYVNvKzVJRVNHYTVBU2pXUVArZGE3RjFpdVBZNTRuMUhod25HdUN2bVQ1?=
 =?utf-8?B?VnYwZW15a1BvSlZHck9SbWY4UjQwa2JZdjE5UlBZYWtqS1JGbXU1LzlNdm5Z?=
 =?utf-8?B?VzlnYWd2RGoxL0ppRE9hZHl5c1h3SXlHNHk0WFYzcEh6RFV5MUhPa3hKc1BP?=
 =?utf-8?B?RkVjMkFmaTFWZyt5dDZndlpPM3dyL0pBaUpsVkVZeGlmb2txN0EzMGtWVkU3?=
 =?utf-8?B?NHYvaCtZc3BSbFJjZU45T3V6cFdYR3lZdjQrb0N6bkc5L29hNTFWYkxoZndl?=
 =?utf-8?B?b3NON0p6bzNnRW50V3pnd0RGQVpDQk5sMllyUXRITE5kanpHdDViRG1jaldl?=
 =?utf-8?B?bUdZazVBdmRJZW9SU0c0R2RWZm9qTFF1dHVOSWhzSUJ2TEIzbmpnOUd3MUpM?=
 =?utf-8?B?S3pjWDczdVpKQmpOWlJZejVUNHRtby80eENtUUxtWWV5Uk9zRjNoa1RpQWxw?=
 =?utf-8?B?Nzh5aEVlNkE4MStHWjVwKzVsNnhPZDQ1NVhycHRiYk4xSUhOV2s3Ym5UdnI1?=
 =?utf-8?B?QVdYNHVya0lWM1RvUHV0amJ0cmZsVjVFVXNUYmQyY2xYVmZwWENjSGluQ3pI?=
 =?utf-8?B?Z2Rzb0IwbFVtK2xUUFM4UjdRZkt4R2FSdTlMMTZsRTFsK2FqZGJHZnlzb0NM?=
 =?utf-8?B?aFMvWWlYazcrd3FFWjFURUxPQTNQalFObEQxTVcrNlRsc0FvM2hOaXIxUEZN?=
 =?utf-8?B?dHZtcVZsaFdSNG9lMmg0T0wrTVlPTnVpUjBvK0JvK0w5VWxlSjJwTnh1Y1Bx?=
 =?utf-8?B?MkFFeC91SVplVnJCL1RoR3dDUFBUNXBBeWM2RnMxWVpzYzM1SHFHZFhFL2lu?=
 =?utf-8?B?QlRPTm0xSzg0dVF2OXBkMWZpOTNDSEhjVnNPWVZEa050WjJtRmpLR0ZMWHBu?=
 =?utf-8?B?NVFCV0NIYWo3UUlPTlByci9FU1l0MXg1bHM3YTVSNTVKNzJzZ3FmUmFVODRh?=
 =?utf-8?Q?QjpWyq8WCGT1UU2sPBh60Ks=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8996db5c-0b91-4d9d-8e68-08dd89ad8e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 19:14:26.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7FpI6qriymNysy3cIHJEsl1J2LHOgl3KZiBFLJg+J7+uCmjKihjTI/8UI7kigOTGjfYiGlj/1nJEC7Rr8S/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4421
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE1NCBTYWx0ZWRfX5253r+vwWrLt fr7joyAQzGXpXmA+dlFHbWlf9Wm64Bz9YaSLr2l1IHz9C77tjjrazsC9m7T9/gS2LeTmyBDYsua f1dhXkpV0mzBKyf0jJHoYDqDRB9vho07nH7goxvPDFkF8AOhgsCMT8JpsncYinWK+qITDcp8xQd
 5Qv7IirYwuZQldinZKF7d73OGCGrQm7O8g9TcdHwr0O97PqWDCNkZZW+IbSs6FIwEIGzScUHuuT TvhO5oFi2pGpZO7jiGI2e7stJ5uWJGrFXuB5ZIdCrXDBaia8dW6PPoZDQu+ACWV48KfAQl/LO7a L6RSCIsvLGX8yE4YuFErFAGmQA8OHohojz6pDUuHkCSrVGZcnsan7RrIj5O1c31qF4eJKf8TmWd
 t2x4mqhrIz0liH4kabvQTdCJ4Pvby/3ddkepmm4E8wsU/We0m0babER67Y/SzzBZg+2Qw9Qd
X-Authority-Analysis: v=2.4 cv=KYTSsRYD c=1 sm=1 tr=0 ts=68151994 cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=sJbc32M6AAAA:8 a=NEAV23lmAAAA:8 a=cBpDRw46GpB0-F08FZQA:9 a=QEXdDO2ut3YA:10 a=dKgTKMx5mwBRCdX1GUW1:22
X-Proofpoint-GUID: rUzJn0uXc1JXHEhudRXMK2dqiOvS9-Kl
X-Proofpoint-ORIG-GUID: rUzJn0uXc1JXHEhudRXMK2dqiOvS9-Kl
Content-Type: text/plain; charset="utf-8"
Content-ID: <B15E5C514BA3394E8BD76DE47B31BD8B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?RE:_=E5=9B=9E=E5=A4=8D:__=E5=9B=9E=E5=A4=8D:__=E5=9B=9E?=
 =?UTF-8?Q?=E5=A4=8D:_=E5=9B=9E=E5=A4=8D:_HFS/HFS+_maintainership_action_i?=
 =?UTF-8?Q?tems?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 mlxlogscore=860 malwarescore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2504070000
 definitions=main-2505020154

On Thu, 2025-05-01 at 23:01 -0400, Theodore Ts'o wrote:
> Hey, in case it would be helpfui, I've added hfs support to the
> kvm-xfstests/gce-xfstests[1] test appliance.  Following the
> instructions at [2], you can now run "kvm-xfstests -c hfs -g auto" to
> run all of the tests in the auto group.  If you want to replicate the
> failure in generic/001, you could run "kvm-fstests -c hfs generic/001".
>=20

Yes, it is really helpful! Sounds great! Let me try this framework for HFS/=
HFS+.
Thanks a lot.

> [1] http://thunk.org/gce-xfstests =20
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-q=
uickstart.md =20
>=20
> Your IBM colleages Ritesh Harjani and Ojaswin Mujoo use this framework
> for testing ext4, and have contributed towards this test framework.
> So if you have any questions, you could reach out to them.  I'm quite
> willing to help as well, of course!
>=20

Make sense. I will do. Thanks again.

Thanks,
Slava.

