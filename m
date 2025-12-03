Return-Path: <linux-fsdevel+bounces-70593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03684CA1798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20AE3304B97E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D03148DA;
	Wed,  3 Dec 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IQRhZmPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E070398F98
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791317; cv=fail; b=lFpaEtatfZPpO2KrRRMWYM8nsYLtesyz8ySSUQl5uC8zadfWD+PIH8ZlGLwVUFLNOTVc/EqyiZH7LlAfw/p0w72Zq0RL9l4yXUk1ejwXMRsicCje+Yabni7qTvepFugqFEQosDNrrqdNL0L1BMpmejeCNMb+fwLXwHhVGleSgjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791317; c=relaxed/simple;
	bh=BtEClDV+F+5FmB+dwsjMy1H1Y1lU8gpWsIzNuixiIQE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HcNgtz6vbUuOL8S4qygersNb3PhaF4aSrOLhqaG7kuh8vn7zh/2Aeb0kBbLIFLMBKK3/RG4mR/RNMLjYp1xN6gH13HkIMcudM7Wv93hEuyfVU+JzQiSYEnJcjNLvo2IPL4ooXOI16CyV00lSrIIpvZbCJmd7VBwanJrohpVR9HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IQRhZmPg; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Fb8gL021715
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Dec 2025 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nMAOPiLX9tmqq2uoxiHLnkaVY2+oSJuXJEBqQ7sMkJY=; b=IQRhZmPg
	/BB7FmAPpCYkYXJuBhL9Pvt0GQ/05bQpbRAGcDbafIg1F26HMuIB0BCj/SkVplv3
	eVdzTWbKgOlEAwnL/j5AJvWhaPj8VpokqTiMGjsX+WcBOEXQLOcs2t99M5b4pTE6
	FCKviRI9R8PxORfsU8rjs7UWD00LJ/WrO8uadjose0ENbBahZ/XWIFFrJXPOsOsI
	/DWB6j2rcZLl99+bSf5bAmzZdeRpvGYUtajhWN9WL/BZZrp1LEZ9NrfWi9WgVgIb
	9CzYH1n9LdmvJ2o+u41yUa1Le2TODky6cy30s+W+zWWIr7LVfJxp4JyQjfPMUgxT
	OuZGw60KIQnpTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5m86t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 19:48:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3Jjhox020554
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Dec 2025 19:48:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5m86j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 19:48:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B3JiMCF015720;
	Wed, 3 Dec 2025 19:48:32 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5m86c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 19:48:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU2ktLxniGLbsw9NIGjhRSg3NB7M2GsMtRwdzp+WdP1MfrvuQCzUdXBOWZloepkEQhs353jRFOCqRVhVusOLzCwwd6d6N+7CmDkMnYY0xflw2OkK0OxOy32hoIVlRkjM6oBRuFz2zmCNi/twxMiSdVn48wvUxFPDUT4OSGjzlVQw3mxhp7oFrLrFKdjYqyRbZ7DnhJTMV2ukJzon9GacJEYQqEH61K8YEccfjfwR5O4LhH7IC7Udnh9FKIW64QTZNVbIZ3jsr6OPjem/LkbOvvlFzENr8LLwgW4cF2PHZcGvOxU2CHzNoVseSRR9xjA3etbqbE8lzwB2K/oeclce/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLrYDFQ/T5zBhqq1AfgGZ0oGK0YJ+lHxOl7pFGZPo0U=;
 b=huqvp2k5hfGyXLMBEfpR7a4blGEOwWOeVQMkPVgX1oAAplzrcMOCsGnCl7+smSIC8uNB3DJDSpnaCd81f1nijGdA1LIf+xYVy4s22TdvPiIjxIPwUw3qUZl0SAFWl1nCuukyecdJGxnWk0ZsYQ1yZIrilfYVFP7EKM3yvh6b5VKr+oRc3FfbXKG8T4ownVIA+3ST1F4CqYwkh2pN6/LzKs3fEvSNyIx9r/3I/ZB+FnnwrYoGU6jPam7eAYD+ncr3/+EngKkWi1ascuJTWGvbaAb8kO82pus/OYjXrI/RuSaFUnBrLtnYtNDYmBjey/No3bfLaV8V1owO/EO2wXq00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB5042.namprd15.prod.outlook.com (2603:10b6:a03:3c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 19:48:27 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 19:48:27 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
CC: Venky Shankar <vshankar@redhat.com>,
        Viacheslav Dubeyko
	<vdubeyko@redhat.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Gregory Farnum <gfarnum@redhat.com>,
        Alex
 Markuze <amarkuze@redhat.com>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix kernel crash in ceph_open()
Thread-Index:
 AQHcWaV/RIaAnir5XkifXtXvNFHQibT6mqKAgAADQICAAAQCAIAA/JgAgABjqoCABjjgAIAAH60AgAPSMYCABxs4AIABArkAgACUUACAAYklgA==
Date: Wed, 3 Dec 2025 19:48:27 +0000
Message-ID: <1b58d80ba65d66028474e1150aaa651d2a5df675.camel@ibm.com>
References: <20251119193745.595930-2-slava@dubeyko.com>
	 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
	 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com>
	 <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
	 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
	 <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
	 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
	 <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
	 <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com>
	 <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
	 <6b405f0ea9e8cb38238d98f57eba9047ffb069c7.camel@ibm.com>
	 <CAOi1vP83qU-J4b1HyQ4awYN_F=xQAaP8dGYFfXxnxoryBC1c7w@mail.gmail.com>
	 <CA+2bHPYLsoFCPnhgOsd7VbSAmrbzXPJDiGW1WZWpPZvdduA6xQ@mail.gmail.com>
In-Reply-To:
 <CA+2bHPYLsoFCPnhgOsd7VbSAmrbzXPJDiGW1WZWpPZvdduA6xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB5042:EE_
x-ms-office365-filtering-correlation-id: 3d38c622-213b-46c0-5cc7-08de32a4edb4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2R1cFB6b3dNOGhWdEZFbEdPYTRuQVRoRkVwRnF2ZURGdmR2ejAyNWlLbjdy?=
 =?utf-8?B?MkRsSUx2OWdITW84d2NVazlveC9rK3hpQStTR0FQdXhOUWZyb2xsWitFUmUw?=
 =?utf-8?B?dlhKMVJZd1FSVVhYRG15MkI2YThPUXgreDRKcXhaeTFHU1NXSWJJeWFBdktX?=
 =?utf-8?B?WDZZdHNXNCtoNzlVdkpUL214c1V0RHV0SnA4V3dZbGVOYnFsRmg2bHk0ZEd6?=
 =?utf-8?B?TnluSXZlY0JrSHlmSStSNTVZVkhNVng5RTNlODZ5eWNsVWtXTzRicmVEOHpC?=
 =?utf-8?B?WDhPcEJwUWFiZDNSRGk4ODBzU0ZsOWUrYzVUOTk5alhGWkVKR2x2YTRsUk9a?=
 =?utf-8?B?N21HMGdlVHpqNjJ4bC9DTkV5L1ZUWXBTUHdtREVRWHdzZ3UwNFRLdmVKV1Zy?=
 =?utf-8?B?OVVyQlQwM3kwSldGdnNBMGFRK05DbkIyZVVIekQ0eGpOcUt3akFWN0VJRTVl?=
 =?utf-8?B?dlRtR090dHVYTitoaUE4Z2hIVll0MWtlZ3VqVEo4N2tvNy9MSnhJbXk1a0M5?=
 =?utf-8?B?M0RjMC9jOCtjZSszSTcrVVFLTVJCdWtxTVFsWENIUFltOXBxS25NWSs3YmtN?=
 =?utf-8?B?V1hIL2Q1QVJnM080eGVEdU9sUXgrSEQzZWtvYzg0dGlxK0dXRFc1eVQxczlj?=
 =?utf-8?B?YmtZZU44UHdQaVFqV1JRaU1lWU1XeVlZWnhzanpOWVdnV1RsQlp0bGpCRW52?=
 =?utf-8?B?SFBTWi9BdjhvWU1BRDRXdFlQUExDK2ZIaW9tQUZZVXZkK0w1cWhFakl5TEY2?=
 =?utf-8?B?eUVwVUd1QVlQajlEZ2g3azh5c09PVkNFb00yVnJ1SVBCYVF2cE0rN0RpMUFn?=
 =?utf-8?B?eGhWM3pPYXlqT0w4K1Z3ZU9DblFUNTVVYjJSYzBzVmtzWmthNkdvS1lLaUow?=
 =?utf-8?B?ZnJrb3BVSW1OSG5zOFp4Y1hGaTN1V2IxZTdaelRhR200NnR1K1BYMGZpZzU0?=
 =?utf-8?B?U2xGMGJKYllzZUg0b1E1YmxCVGxJMlUxSnRpTGVKTzlGcnJPRWI4d0VKcG9S?=
 =?utf-8?B?SEcyNzV5eTAzYUNHRXNENThHTDFJUXZVL2ZYeVAzK0NsMTc2bjBtdDAxMEtj?=
 =?utf-8?B?YmZDL0lKblN2anYva284WGVBcDN1dUNMMkpkeWxGS3ZPVzZibjgyVlpSTXpD?=
 =?utf-8?B?UDRkWGs2YXdhTVlaUm9rK3lyeTl4ODJRSk9qcEx4a25ER25uSU9sYUVpdU1u?=
 =?utf-8?B?WUt6Q29vRFE2K3BCQzl2Wk1DdzRVOC9oNjF4NU15ekxUUFJEY21IUm5PTU9t?=
 =?utf-8?B?S3BDLzd2K3RXYk9IVER1YzhBaWptcXRURTdaTzlBb2hJVEtjK1VVYnBPbHR6?=
 =?utf-8?B?MVVlV042WXoram5kRkJ2cENEYlpyNm5Ld25RS1B0NUNIQ1YxVlo0aFVzZFdo?=
 =?utf-8?B?Z1dtSDY4VUZOV0Q1dmFRdUd6TDdlZ3YzREU1UWJBZmVmWFRLRzRKMWY0UnNS?=
 =?utf-8?B?YU9wTmtMaGh5dU5rUVplekpsMzBibk9tUk9UYm9vakdObzNMVy9Qd1QrdEkw?=
 =?utf-8?B?b1gzZldZZ1N2a0RuT2FwKzZtUlh6dURwc2ZCY2tDL0pwazMxRGVjeHBabWtV?=
 =?utf-8?B?OGxGMUNrdmwwd2FJZCt3c1Z0UjR3VG9abzJtamFkVWZiS1d6cFEvNWlGUUFu?=
 =?utf-8?B?ZmIySmRnNjk4bjhZWEprZnRXeFFuMWJiOGQ5Wk42Z2lIampycGxTRjhPNWpu?=
 =?utf-8?B?cWRXWCtZOGp0bERUOUVpVi8vWi9Jd2VFR09la1lHLzlRQk4vWnB2bjBYR2ZZ?=
 =?utf-8?B?WXZEWlBPUGxXZGNiOW1UWGxSNWQ2dVlkc0hOelowTVJ3eWd3elM4aWh2OXJB?=
 =?utf-8?B?RDdTV0NPcVNlSklaSExKTzhQcDhYaHM3Sk9mdzc2b3Z2NEZSdTM0RmJ0MUtC?=
 =?utf-8?B?NytZL0IyR0ZSaTlKT1EycnJVQlArUWg4ZE5yclBHZ3dIY1k5SVpEd0luaGF3?=
 =?utf-8?B?bkVQSCtyZkxwUFo2MC8vY1FPRUwxSU4xeTZ4aFRNWXpvZEtHM1FmTmRtN29w?=
 =?utf-8?B?U2lqemtlV1lCTkErNkYvbVhONTNKek5VcHJBWXl0ZTNJZTU5ME5OWSs3VjBV?=
 =?utf-8?Q?84ELjB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0pyRGpYVTArK1FuenlBOHBWVm43cUN6czBLSnFZcDk2Z0g4ZmNFRFN4c3Bs?=
 =?utf-8?B?QXNxa1FlZUl6NkM0NHpkUG5EVGt0L0pTM3RuK2R5WlFGcS81N0Q4QnNRcU5Q?=
 =?utf-8?B?R05TU3RKcFdTK01oaFlPck1QcWVLL1lLSkdrVVJwM3E4MktVVFdSUTdsblpG?=
 =?utf-8?B?MXhIUUw5dGNPcTFFRDlQYzYxaDVpazdFWWxXdkQ1ays3M2dUNGphZG1NTFpX?=
 =?utf-8?B?RFh6YktnTXByaElnN0VCa2FrSmhmTlNTWkpaQmRGZVU4aTdFbEdnbkVBUW5F?=
 =?utf-8?B?U3BKS3pSeEUwZmU0clZCQndhVVBqdUlCY3JOd3l3SjR0R2xnbTBVaFNDR0V6?=
 =?utf-8?B?WHVraE1DOVJBc1hEa29yd0pETFFDbTJVd25lNE1MdTM2YW0yU2pocEhQU2tx?=
 =?utf-8?B?MUh2NWJCZnNtRmNrclVnKzgyMWYwSlZQS2Z0YzFPNjI1V0RPVkJLTXNBb2xv?=
 =?utf-8?B?blBxMkN0T3dtV285dWFUNE5hZmZqN1JxU3J1ektOUkV1dm9oU2xaN0E3WVRi?=
 =?utf-8?B?UkpYUXNqWmV5SlVUNy9RcFVkQjZRVkxpR1FhbC91S2JlNnlZcjcyN0dHaWUr?=
 =?utf-8?B?NGIxOXQ0dll6ZFdZMXZaazFncEs5clE4UE1UNVdnQnQ3UWNIRzRkSlg0TkxS?=
 =?utf-8?B?K29IcXdqMmwyb0xOdWN0aytlTjZSSGZPVHdsYUtSN0Z2RTlQKzRuK3IyNnpo?=
 =?utf-8?B?aStVQU1NK0hVckRYKzJJSnNmVThKaHZxSXZuaEIzY3lSYVJxeCtCRzNwS2tm?=
 =?utf-8?B?Tk1jdkVSZm8yajkwQkwxRnNEOHJuL3AzS0ZxWDhMQ0k5OWNJM1EyUzlBblM0?=
 =?utf-8?B?aFllOEVHd0daOW1JMmIxN3hzRzJ3NUtRWGxRTFp0ckFGYXBqYWRHYVhIU2M5?=
 =?utf-8?B?bW05bktYYjd6dG1ITlZteS83b2xFR0ZoM01yOE1yWmxvVkFaSWFmNXNCTEpQ?=
 =?utf-8?B?YUlzYWxvaWdZd2xBMlpNNTQyaUU0UmI2RC9EQi94d0FWaldqK1d2Zm9RbENS?=
 =?utf-8?B?d01kbnp1Q3pLQ0U4WThsSHlubzRvdEZncjFOSTBvY0k3RjBKR2RPSURIbFUz?=
 =?utf-8?B?REcwRE41SUgrSlBWSE1Hd0cvSjZETXFIRUlZUWpTSWlSajZhQnBLVklaS1I5?=
 =?utf-8?B?cE9hSEUxNVA0am9raHJvMTF3c0xvYXhyRVdhYnYvN3pUTGRMeTN0cENpWmNi?=
 =?utf-8?B?UDczSVRjNm5jWFp5Y08vOW1FSmZyNUZQREJLZG1GNTJRWmduRUNEUjlUdWNk?=
 =?utf-8?B?aW5wZEs1d1FCNGdvMWNTcEJ3NzV1R2gxZzlIcktXeDgzcFZwQ2xrTnhTRDI3?=
 =?utf-8?B?SitKVURnWlQ5KzJ2RnJwbDZodDVyOGZ5bWJyb0lib2pNUEwxbDVOVFdlWUN5?=
 =?utf-8?B?eG83ejN4bHVRRzFvZ2p2SzJwdEh1YVl3dENjdlAwUW1QWWpIM1A3cjJpQXJ4?=
 =?utf-8?B?NW43NnJDZkFEQU1vTWMwYW1LOUJWUllnTjJBa1prM3BYRDh1cTA2OGpCbkkv?=
 =?utf-8?B?V1luY25xNHVXM2RmNFR1NDJtNC9ON3llTXRIdzh5WHVkZVdBYjlNZGNSTzky?=
 =?utf-8?B?MjFucTZnYS9FNmo1VHpxWFMwc1JVV0M1TGl4NStUVEgwL3VHYkZBS3dSZEg4?=
 =?utf-8?B?b1dLM1JrWmpYOXNJbDhzeEtiZFNUL1A4NjNZWndIOFNGSnUxKzI3b2dFSkhL?=
 =?utf-8?B?anlPL2NoOHBQUjRLNmZNdXA5WEtsaWlNa1RjbUVMVHRxSGp3WUZLUVRQbjdB?=
 =?utf-8?B?OEV6RTJFNk42bThpNWNtZ1cxVXFOa0ZERk1lV0tKVU8wS1YwVnhWZzhVR3o2?=
 =?utf-8?B?WDVyckpSMzVQaHV1MTFadzdoa3B6WDRtTStPcHVlRnU2UkRFU0hZOVhFNVFX?=
 =?utf-8?B?aXRNL2xlbWJHa1EvS0w0ME5SK3F1N0NmRUYrNmJJd05zMGhsWWFsYUZlSllj?=
 =?utf-8?B?blpvS200NmF5N1pyRHFLNUdMZituSGtiNzlwRWR6TzNHeStIKzByVHlTU0Jm?=
 =?utf-8?B?RzRQYU5FeWIyZTl1RjQxVjl1a1pzcUFla3d5RFFXZ3IvRjRVVGp2dm1mZFlm?=
 =?utf-8?B?M1dZaXJVTU9wVzV3UGVtM3ZGQU9UdkpKZGlZbkF4K3J3WXlvNFdFWnA3SUhk?=
 =?utf-8?B?QnFZR2VzRzAzQkZlR1psSTdYaWpXZGlRQng3RHRzRDFDNjc0K05LQ0twQ29V?=
 =?utf-8?Q?eN8+tmtdqtWVQfvNvaz7cTg=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d38c622-213b-46c0-5cc7-08de32a4edb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 19:48:27.6946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 959AeBcBKhsHln2n0OUpwPMDW5CpmQ85KGBwK8sO7RaoMYQRzcHrfS9T/sw2fuyUlZ+adYiVjiGFMw0poLGMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5042
X-Proofpoint-ORIG-GUID: cEgDFwNF0nGXljf4TsEwLG0cD3dz0IrT
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=69309411 cx=c_pps
 a=RA+XJ41QLaSqwPGKFjpXOA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=lZ319WGNnjkplgRFdJAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX+HjKLiqHO0ti
 X1ZOP0FAfZYWEBtjg8VCqLrbk5hTPqfrCvflO2PbhWu7GRr/6JaTWBo8bdATTFtkOQAwcm4Y8vQ
 oqzmSmo2+owkCc34o8S1/hQtSvTNXnTREtbKs+j0ogT+rhhFNuunI59BZitZrZs1LG7yjwR+f+V
 nehFL9vWjEIqwBBfuz+ar0uQEhy4hiR8Dw7jGkcnd66X3jRu5gcb6ie0464qfxNdeStYIPAgzSn
 OqWJg2YtnpCV5rLMJHQzGpNEfcNkw98vQnyciNledbHb30xfESHL1JOQHi3+GqLjjy7NWO7/kOR
 g5BJsy9IhHHyWnyv1RlBSZJrn3IhpPU7KYcCAIu49QG/BZl7cr1/zfzFgySWbLJPrf9EXOw+w2+
 coBlN1cOG8tvQ6WEWK+gc/GQY5hhyg==
X-Proofpoint-GUID: WPkUnqwIk945Hww5f-Zi6IqBPT0hy9Tm
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8987DF99374A542A58A949EED974BA2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511290020

Hi Patrick,

On Tue, 2025-12-02 at 15:21 -0500, Patrick Donnelly wrote:
> I started work on a patch and it is largely in agreement with what
> Ilya suggested below.
>=20
> On Tue, Dec 2, 2025 at 6:30=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> > Hi Slava,
> >=20
> > I think the right solution would be a patch that establishes
> > consistency with the userspace client.  What does ceph-fuse do when
> > --client_fs option isn't passed?  It's the exact equivalent of
> > mds_namespace mount option (--client_mds_namespace is what it used to
> > be named), so the kernel client just needs to be made to do exactly the
> > same.
> >=20
> > After taking a deeper look I doubt that using the default fs_name for
> > the comparison would be sufficient and not prone to edge cases.  First,
> > even putting the NULL dereference aside, both the existing check by
> > Kotresh
> >=20
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name))
> >         /* mismatch */
> >=20
> > and your proposed check
> >=20
> >     if (!fs_name1 || !fs_name2)
> >         /* match */
> >=20
> >     if (strcmp(fs_name1, fs_name2))
> >         /* mismatch */
> >=20
> > aren't equivalent to
> >=20
> >   bool match_fs(std::string_view target_fs) const {
> >     return fs_name =3D=3D target_fs || fs_name.empty() || fs_name =3D=
=3D "*";
> >   }
> >=20
> > in src/mds/MDSAuthCaps.h -- "*" isn't handled at all.
> >=20
> > Second, I'm not following a reason to only "validate" fs_name against
> > mds_namespace option in ceph_mdsmap_decode().  Why not hold onto it and
> > actually use it in ceph_mds_auth_match() for the comparison as done in
> > src/client/Client.cc?
> >=20
> > int Client::mds_check_access(std::string& path, const UserPerm& perms, =
int mask)
> > {
> >   ...
> >   std::string_view fs_name =3D mdsmap->get_fs_name();   <---------
> >   for (auto& s: cap_auths) {
> >     ...
> >     if (s.match.match(fs_name, path, perms.uid(), perms.gid(), &gid_lis=
t)) {
> >       /* match */
> >=20
> > AFAIU the default fs_name would come into the picture only in case of
> > a super ancient cluster with prior to mdsmap v8 encoding.
> >=20
> > I haven't really looked at this code before, so it's possible that
> > there are other things that are missing/inconsistent here.  I'd ask
> > that the final patch is formally reviewed by Venky and Patrick as
> > they were the approvers on https://github.com/ceph/ceph/pull/64550 =20
> > in userspace.
>=20
> We should match the ceph-fuse client behavior.
>=20
> Attached is the patch (I've not built) which roughly gets us there.
> The missing bit will be the "*" glob matching.
>=20
> In summary, we should definitely start decoding `fs_name` from the
> MDSMap and do strict authorizations checks against it. Note that the
> `--mds_namespace` should only be used for selecting the file system to
> mount and nothing else. It's possible no mds_namespace is specified
> but the kernel will mount the only file system that exists which may
> have name "foo".
>=20
>=20

Is the attached patch ready for review and testing? Should we wait the final
version of the patch?

Thanks,
Slava.

