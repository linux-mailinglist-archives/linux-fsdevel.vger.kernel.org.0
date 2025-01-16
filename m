Return-Path: <linux-fsdevel+bounces-39348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1F5A13102
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 03:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A716416F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09B50285;
	Thu, 16 Jan 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFned7xM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081E24A7C2;
	Thu, 16 Jan 2025 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992919; cv=fail; b=kT8X2iU/HnT+qMsdzCwFyOH/+O/SKbmeZWmat5i+B/wEO2NLc5Ee3uO0SeszWIbf4TbfoB0dQ1z/5O+FuLHFVsG8CQjoStVHjMxMRuK/P1FkwBh0W/YrBI7m3Uem1S9qaDaPETzwHct4hadhwWn1MtsAJU9Apdf/bf/EDK4kpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992919; c=relaxed/simple;
	bh=u3+Gp7yXAZTDt3xDAZIkYBx0FpIkHnnHOGTJ8wxKLJM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fdrk0mKdM/faOY3YCUlh1b6Mymc0J/98i6REbHCrtWBwZjw/3YZfNAgIVN2jGMKtDPhENzL78zVn8MGawNRWj0+ES3evWsC6H13iHRoiefmBoavEiVp3+6Hy27TSMpTpu+Vpq5zMRuIiKrzJV8CpiAOIkW70kRXohNtJeBix4p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFned7xM; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FNaihD022861;
	Thu, 16 Jan 2025 02:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=u3+Gp7yXAZTDt3xDAZIkYBx0FpIkHnnHOGTJ8wxKLJM=; b=sFned7xM
	EBM3ZSMgz4vDt864aFiVD1OSePbu8Kc0A8kZKQMNPjW1PXK6HfZmC/vOhFsa1swA
	KxOcxR0ou/2IcTTHUYYa2wTUosglEvG2TB2iAGK9Ip2obxlvRzouhgI1t5G2mYzn
	07eNxmsGSr1F3VB51+vwgrURGD4R+5RG36UGRsKNa1EFdGhaevQSwxg/ooNR7aUM
	WuVkabv5eWONROVGNwYEPkBkBlWizKGpHfwAiFn8aWKZnugTJcMzULCJIUjJ7pkH
	96zFEFmZgypmyHNPNDTG8keFYXPRANfeQ6ZQAkL2zFEc8xLOF8EJGA8XuR25C+l0
	uYuLfO3FlTpU3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub0dty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 02:01:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50G21swr011281;
	Thu, 16 Jan 2025 02:01:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub0dtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 02:01:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7vgwpVJCnwxF/00mov/ToLyEt1wkKBpRBS26jYk/eFBBuD/O+NBEg57MYS03HJ8ZgSXrDk8mIIWbZb9OLExcopCLWCgVTp9IltmqF04tAxKaut5EYigY1l1nHzdN+tT9Ld0ZkaFPJxEjAdZFeU7EBYmAfcvSavju1iMKJ/gX0h1l4KZlgU6lYvxa0AcUZ6cIC8Igfe5cWSGk9nLf9qTGs9nYv8YN8EcTSDpF2ki10/rKJ+VqYilDLTynMCSX7te45aXkJsfzXb4nV/wlRBviEqSsOBqHjACDWgm71XiEu/himX9adIjy6147IDs/L9wtl2eksgrLrqJ/PXnQdAQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3+Gp7yXAZTDt3xDAZIkYBx0FpIkHnnHOGTJ8wxKLJM=;
 b=hDorjFCH3YJ0Mp2hlsXbEUsb2r+Nf3+YasP1heCaL9MTYye41TTaz2Y+9qjSFPAojSaBfWSR7eWgwrVX7dd7Dn4LIygLHU5W7oKcr3EFYIFMfPtoOysJH+wmXB92MFL0w4tDSVS4kDy5YxOlpwXaeVkTCaaIBSe28mGzd/utqTea3EMFuEblRP0geQKpwPtlq3NfTXzD+m0f7XPiAVL6WP+DOLtZ+UBj/BW10vsCklKvpZ2lbxuNQmmDgHt7Ye4EBFTft/zkgPrWwA+6Iq8OEzUmBjqx+cowG8cpTcenCywebO7TTG8C7jj2kKjFuL+wogUmukhXXUbzpNiaZK5Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB6375.namprd15.prod.outlook.com (2603:10b6:806:3aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 02:01:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 02:01:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: Introduce CONFIG_CEPH_LIB_DEBUG and
 CONFIG_CEPH_FS_DEBUG
Thread-Index: AQHbZuYrmixXUxLwSkCVdEFmX2XVpbMYdcuAgAAxoQA=
Date: Thu, 16 Jan 2025 02:01:52 +0000
Message-ID: <6d4a79f4f0ac82f9287168a55694b7768d5b235d.camel@ibm.com>
References: <9a168461fc4665edffde6d8606920a34312f8932.camel@ibm.com>
	 <CAOi1vP9uiR_7R-sa7-5tBU853uNVo6wPBBHDpEib3CyRvWsqLQ@mail.gmail.com>
In-Reply-To:
 <CAOi1vP9uiR_7R-sa7-5tBU853uNVo6wPBBHDpEib3CyRvWsqLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB6375:EE_
x-ms-office365-filtering-correlation-id: a8334e37-048a-4e37-c278-08dd35d1bf37
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTlKaVdQT0hzQ1ZqRlhrYW8vYjg0Y3dOcS9yWTVQNHFLa1dBSThwYndCVGl0?=
 =?utf-8?B?Sk9yN1pVYzZHekdWbnRZN2tGTWNzQ1hzR04vRm9sd2lDRHVta3Z4dzZEN252?=
 =?utf-8?B?L2pucHllallDRjVGT0lmR3g0TEpTd2RMNCtRdDVOTjBrcTM5bTNWYmN4YnhU?=
 =?utf-8?B?c0RHeDU5N2EyRW5MK0dNTC84aHpLNGNvTExqNFdRSzE0V0hKRndmMlVjcjdM?=
 =?utf-8?B?b2gzV09uU2lpRDN3bW5SUHU3ZGU4Tld3N29jMjhwVHlvMXBUOE14VDdOQi9F?=
 =?utf-8?B?UjNFQnBPZ3VEa0VLZlU2VmxhV1JLMFpFNXJWbnJwYlFQSUV2R2s0Ti93b1BS?=
 =?utf-8?B?WEl5eHZpOWc4ek5KaXhOelBCTzlXMTdsWk1OOHU0aWhCYWc2NVJjUXZvblF6?=
 =?utf-8?B?V2lKd3NEaEdJM3pSQ3VHMmVnMjNqNFUxVGp1TWxmN2NQUFoxaVhDUU85QnU3?=
 =?utf-8?B?MDV5cVZxVmJHQ1NiV3MvU3RSa2hqSytZR1JaQXJwMTBUZDB0bFlOVlFMaUs0?=
 =?utf-8?B?alcyQ3JHWlhCTSt3aTlSRnNEWDk2T1ZxN1dmaWF6R00yMktIUDU5VjROYjBw?=
 =?utf-8?B?NjZZMjJmakMrVm12SnZ6R1BvRFIzRm8yVDJZVEtlalFwbzN1bSs1UC9aSGxH?=
 =?utf-8?B?T202VzJoNVlrbkRVelJONnFEVHBMMDVvWnh0Y2VjVU1FRDZYTFVFVjNja3FD?=
 =?utf-8?B?ZGlPK2wwWVhCSU5XYk5qV0tkRUZkU1VBTUR5UGt1bnlNUGxyWXBxWlBmMkpt?=
 =?utf-8?B?N1FIdEVEVWo1QVR1bGtUU1d6Mm1RM21JUWJ4K0dvZTdBenpITmhvVHZQMGZ0?=
 =?utf-8?B?KzFKcnVGYXNOTmtqTmw5dmlxS2N2YXFsd0FSa1FXdEhGdDNxUDJVM2NOaHpj?=
 =?utf-8?B?V20xK0RVcWdvdEdDVWlsOEhCaWhuajJMNWxHcmpwaDh5bGlNMkNIc1R1Q09O?=
 =?utf-8?B?Y05yZFZaRXVXYjI1eFFJY2tSUmVNS0l0cXZJNmFPZWlWeU5OQ3pEQ2pEbDZH?=
 =?utf-8?B?RmhmMDVpSkpEdzIxa3hQWFVoRzY1T2lnRjVVMWQzK2ZLZVdHOHpXQTl3VGx3?=
 =?utf-8?B?V0IrVnJxem5BV1ZBdGg2UXB3WDNKZGlVNDc1MklDYWdmdERXZjdRbmhFTys5?=
 =?utf-8?B?a0RDL0dIb2VES0RqQStCV0V5c1psSFFSNy9lQXR0bmtJb1VZVmhibWVzTU5N?=
 =?utf-8?B?TlN0eExEVG96dzFqMlBVOEdkaHR6bnlIdm9CK3BDaFJXbFpZdzdTSkdHZU9S?=
 =?utf-8?B?MzB2dmRpUDB4QmVkMG1mZ0V5eVhHeDhnQlFaaDhRQnJ2aFZoV3o3SnZZV2o1?=
 =?utf-8?B?SHJWckh1bEc2NEtwNmd4SUlWR2VwakpCK1c5d1BaLzA1QWdaTWpsenczTi80?=
 =?utf-8?B?ZFVLS2g0WnluZGsvK0RFUGxoRCs3RmJsRWI5dU5lQTMzUXR2Ly8vOG1LaUE0?=
 =?utf-8?B?eEFYbVpOZG1yclNnVEF6Mi9BbHFkcERGdEp4UFE1WkVPOEhJMDFsbDhTNlhR?=
 =?utf-8?B?NXpxZ0J4ZUpWTy9odE16NHlCcG9NUzFxTHJYL1ErUTV4b3luSG9ud2xrQUFT?=
 =?utf-8?B?VkdzNFRxRWlLSDRvQ2pQcnQxWG5pN1UyNXByS1lyK21CbDM0RlA5VWtMSFFY?=
 =?utf-8?B?aVNUVTZwOGpmNDVNTzJFb2pVUDRzRGtHdkVISS9DdFNqRDk1Sy9hT05lOUh6?=
 =?utf-8?B?R2hTVVMzMktDOGNTS2NZUjUxeVRnTmhjeVh3NnhIcEFKSFhPSEo1Q0QrYjBz?=
 =?utf-8?B?VHhCRUoraUJJY2FFSFQ3Uzl3UVdwT0FobjlDdG0wYXVnOUhycy9hRVp2NUpF?=
 =?utf-8?B?MXZGamExUUhwKzJWTGlVdzJMcWI4MVlqMEgwYVV5SUE3ak5qNEhDYUlYakZM?=
 =?utf-8?B?ZE9Ca0cwcTJpUW9hTGRiRlNrMUtSajZrK2RzQjVVOHZEVEJFa2trdy9mNXNp?=
 =?utf-8?Q?X7VMPeoXkDZsAyBWQomLO8CLIBzn/g9p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHFuV3pia1Mvc1F3VEt0UGd1TTlReHJHRVVDeVFHTU1hOHNHQm5mNHU3bEpU?=
 =?utf-8?B?a2EwdE9XY1NlSk1jVkxLYkNwcDdKaFNxTCtoUFJzNEErVXllYU14V05ueGVn?=
 =?utf-8?B?WVp6bW11cmg5LzNTQnpnTzBoQk1MRWNvZ2VTRFpPK3JIaUNiNDlOQjAzVDFI?=
 =?utf-8?B?WkVzUkE1SDVWUHY0MHV4cFFDeENpdHdqSWZCdEtoLyt4MENPdDlBZjhCQVZt?=
 =?utf-8?B?Sk83b0J6eUlUbnJoWG5WMmVDemlJcUplbVV0bjFYbEhrQlZicjc2UFVnK2x5?=
 =?utf-8?B?NkRzUWJ0MEZPc05PNnR1WXlrV1N6L0NUNTMyN1VldWdRbzRreDdzNUVGVHZl?=
 =?utf-8?B?OXRTaWZTN1c1UEVpaWV3MDFnY1BUQUZDRHlaSW9lNEFlMS9yeHNOR3lLekdp?=
 =?utf-8?B?R0F0dmdYdlFXTXRaWW15dFowaWRCWW9LNDd1VDRzekkyWnR6Y3ozV0d3QVhw?=
 =?utf-8?B?QmdHb3d3Ri9PZm0vTlY4dEVWTE5JRU04dk80MDF3NGZvY3RBOFhId05lVjlY?=
 =?utf-8?B?YlF0ajZ0VlAxeHlsOXNjRUtTUGJrR2lTZWEzcklBaUQrMVk2d2RvbE9HY25O?=
 =?utf-8?B?MTJFdWc1eE53Tk5weDlEQkZudzBwUWpXQ1VldjBhY3lDUktFbHplVGdMNDd0?=
 =?utf-8?B?VXk3dmlCMGQxUWYwRlJjOWdVZElvYnNsaENQM2sxVXJya0Q5TzhUSWY5QzJK?=
 =?utf-8?B?TThpN3dKN3lIM05zRFN3WmtUUm1NU3Rkbnc2M1JTdksxWHZEM1p1eEFkSGRG?=
 =?utf-8?B?VGdzeE16OWoweG96ZHdvMDNrSmRzSnN0eDRjZzBKWTZONENuem1GbHNQRll0?=
 =?utf-8?B?djBQcGh1NVNsbThGOFpVNUZCTjVZNEZ1VW5ucjM5TkNsVFhmcENibTZ0ekkv?=
 =?utf-8?B?ZWlFWVVwb012ZEtjMS8ycDNJR2tRZjZ2Y1lLYjlkYmRXNzdsS0tZcXNQYmk0?=
 =?utf-8?B?SFJra3AxeklYVjI5UURIUGpYWGFwbWhvU1RwajhMTFNyU1djcVFFa3psNTFt?=
 =?utf-8?B?Y1U4TGJPS2plVnNyVlJaM3dxRElQTlhyY0FlOFBkV0xFK3h3SGgva0RvTHFQ?=
 =?utf-8?B?dXlmQ0VWOEZ2YjNJN1ROZXFwZmhHN3dvMlRIem5aQ0ROUi9BQ2VWamJndUFY?=
 =?utf-8?B?NXZTRTRROEVGc0VPNzBNSjB6aGVnZkp2WlhlNEE3Wm1RS1NsaVMxVkZkckFn?=
 =?utf-8?B?S25Kem15STFBSzZxQytwcTdGblFkRlQydE5uL1NrOG9JZGxxMnRqVWwwQVVM?=
 =?utf-8?B?L0Z4ZE4xS3ZNbXl4WTY3SFVXeDBqcWJCZStjdTA3bGxKZFNick1WWEVhcVpU?=
 =?utf-8?B?YWJESUN3WGowU2FTNElLNk9BVU40T2Y5VDFKYW1QVjdiQzExaFBZVFRPK1BT?=
 =?utf-8?B?dlpZd1RKRFkyc2wvdjI1bWRuRSt6MElPVUptV0p2TEJhZ2xWc3JvQ2hzSDNp?=
 =?utf-8?B?d0pzWmxCS29wNGk4VHpiK1Z2ck5MemJtNzVrc3QwUEhVcUNYZnd3OWxnN0hR?=
 =?utf-8?B?cm85VUoyUzB6dGh5OGREYmZJY242ejVQb3FwSStBY0dCS2NZWTk2QzVET2Yw?=
 =?utf-8?B?VVZIRnAwVEFTL2N4L1RieDRsandYd0dlMS9OUjNtanQ2S2FjSTVmNGliaHVN?=
 =?utf-8?B?em8wNVFXd0hFT25nY2VYWjZaS3VRMm9mRG5jaW5Ub2tPVmxCdmNVakVWaTlT?=
 =?utf-8?B?TFBQR2FVMmZMdUMvY1VWaHR0OVJzNnlqcG5YcjdwM1Fsc1ljbGNUYmhJa1d1?=
 =?utf-8?B?N3pzbWtteFdJMnJRTEFtS1FNclp6d2JBUEplekJsSXk1MnFCYkVEdVBiYlZM?=
 =?utf-8?B?Vzl2NmxLQzNZMXpqcUVJY3RBMGpXU01xVXJURzYvb0hrOGVoOHllQit5dElu?=
 =?utf-8?B?alRES3plMWl2c1Q5ejdBc1dLaDZiNkE4SVM1bm1Pd3dKNTdlVks2UTBxSFNP?=
 =?utf-8?B?OENwUDM0SFpXdmFGQW1ZNGI2RGlHQnZlL3QvejBSSFZ3UmxieWM1US9NR212?=
 =?utf-8?B?NXRuQk5VU25VOVlDRzllOWpwL01LMk0zeDJXWVorOGk3aVFPdW0vR0Q3OElQ?=
 =?utf-8?B?NEtOWFpQbXpwbEQ3Mjd1SEFwcXY4M3U1NGQ0bTU5RUw5dFZvVno2ZlA5K1NX?=
 =?utf-8?B?Q0JoMXVOYmVSWW5mSlZ2NTZIWG1OSWs3dE9DK0hQNWlRL3Z5d3A2UnQ5RU1G?=
 =?utf-8?Q?7ouNMXDId2RR1Pnh3/8m6+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A050E02151F5B4D9C60E6BC602C1B0C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8334e37-048a-4e37-c278-08dd35d1bf37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 02:01:52.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkYJH8hZb+6ImWtXLGCEeRmcTKJInhIsZlZsycg4y+PaL18xKIfglyXcF/rR8NWnIKUfSQ+oj/cFDv/ejC1TIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6375
X-Proofpoint-GUID: TpIqGC92NERMbO8nzC4WzHnR8M_D38fI
X-Proofpoint-ORIG-GUID: Tx-aBB_f-wssJV26QPXrys5EwgKLGs3x
Subject: RE: [PATCH] ceph: Introduce CONFIG_CEPH_LIB_DEBUG and CONFIG_CEPH_FS_DEBUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_11,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160013

SGkgSWx5YSwNCg0KT24gVGh1LCAyMDI1LTAxLTE2IGF0IDAwOjA0ICswMTAwLCBJbHlhIERyeW9t
b3Ygd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDE1LCAyMDI1IGF0IDE6NDHigK9BTSBWaWFjaGVzbGF2
IER1YmV5a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gDQoN
Cjxza2lwcGVkPg0KDQo+ID4gDQo+ID4gLXZvaWQgY2VwaF9tc2dfZGF0YV9jdXJzb3JfaW5pdChz
dHJ1Y3QgY2VwaF9tc2dfZGF0YV9jdXJzb3INCj4gPiAqY3Vyc29yLA0KPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBj
ZXBoX21zZyAqbXNnLCBzaXplX3QgbGVuZ3RoKQ0KPiA+ICtpbnQgY2VwaF9tc2dfZGF0YV9jdXJz
b3JfaW5pdChzdHJ1Y3QgY2VwaF9tc2dfZGF0YV9jdXJzb3IgKmN1cnNvciwNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGNlcGhfbXNnICptc2csIHNpemVfdCBsZW5ndGgpDQo+ID4gwqB7DQo+ID4gKyNpZmRlZiBDT05G
SUdfQ0VQSF9MSUJfREVCVUcNCj4gPiDCoMKgwqDCoMKgwqDCoCBCVUdfT04oIWxlbmd0aCk7DQo+
ID4gwqDCoMKgwqDCoMKgwqAgQlVHX09OKGxlbmd0aCA+IG1zZy0+ZGF0YV9sZW5ndGgpOw0KPiA+
IMKgwqDCoMKgwqDCoMKgIEJVR19PTighbXNnLT5udW1fZGF0YV9pdGVtcyk7DQo+ID4gKyNlbHNl
DQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIWxlbmd0aCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAo
bGVuZ3RoID4gbXNnLT5kYXRhX2xlbmd0aCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIW1zZy0+
bnVtX2RhdGFfaXRlbXMpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfQ0VQSF9MSUJfREVCVUcgKi8NCj4gDQo+
IEhpIFNsYXZhLA0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGEgZ29vZCBpZGVhLsKgIEkn
bSBhbGwgZm9yIHJldHVybmluZyBlcnJvcnMNCj4gd2hlcmUNCj4gaXQgbWFrZXMgc2Vuc2UgYW5k
IGlzIHBvc3NpYmxlIGFuZCBzdWNoIGNhc2VzIGRvbid0IGFjdHVhbGx5IG5lZWQgdG8NCj4gYmUN
Cj4gY29uZGl0aW9uZWQgb24gYSBDT05GSUcgb3B0aW9uLsKgIEhlcmUsIHRoaXMgRUlOVkFMIGVy
cm9yIHdvdWxkIGJlDQo+IHJhaXNlZCB2ZXJ5IGZhciBhd2F5IGZyb20gdGhlIGNhdXNlIC0tIHBv
dGVudGlhbGx5IHNlY29uZHMgbGF0ZXIgYW5kDQo+IGluDQo+IGEgZGlmZmVyZW50IHRocmVhZCBv
ciBldmVuIGEgZGlmZmVyZW50IGtlcm5lbCBtb2R1bGUuwqAgSXQgd291bGQgc3RpbGwNCj4gKGV2
ZW50dWFsbHkpIGhhbmcgdGhlIGNsaWVudCBiZWNhdXNlIHRoZSBtZXNzZW5nZXIgd291bGRuJ3Qg
YmUgYWJsZQ0KPiB0bw0KPiBtYWtlIHByb2dyZXNzIGZvciB0aGF0IGNvbm5lY3Rpb24vc2Vzc2lv
bi4NCj4gDQoNCkZpcnN0IG9mIGFsbCwgbGV0J3Mgc3BsaXQgdGhlIHBhdGNoIG9uIHR3byBwYXJ0
czoNCigxKSBDT05GSUcgb3B0aW9ucyBzdWdnZXN0aW9uOw0KKDIpIHByYWN0aWNhbCBhcHBsaWNh
dGlvbiBvZiBDT05GSUcgb3B0aW9uLg0KDQpJIGJlbGlldmUgdGhhdCBzdWNoIENPTkZJRyBvcHRp
b24gaXMgdXNlZnVsIGZvciBhZGRpbmcNCnByZS1jb25kaXRpb24gYW5kIHBvc3QtY29uZGl0aW9u
IGNoZWNrcyBpbiBtZXRob2RzIHRoYXQNCmNvdWxkIGJlIGV4ZWN1dGVkIGluIGRlYnVnIGNvbXBp
bGF0aW9uIGFuZCBpdCB3aWxsIGJlDQpleGNsdWRlZCBmcm9tIHJlbGVhc2UgY29tcGlsYXRpb24g
Zm9yIHByb2R1Y3Rpb24gY2FzZS4NCg0KUG90ZW50aWFsbHksIHRoZSBmaXJzdCBhcHBsaWNhdGlv
biBvZiB0aGlzIENPTkZJRyBvcHRpb24NCmlzIG5vdCBnb29kIGVub3VnaC4gSG93ZXZlciwgdGhl
IGtlcm5lbCBjcmFzaCBpcyBnb29kIGZvcg0KdGhlIHByb2JsZW0gaW52ZXN0aWdhdGlvbiAoZGVi
dWcgY29tcGlsYXRpb24sIGZvciBleGFtcGxlKSwNCmJ1dCBlbmQtdXNlciB3b3VsZCBsaWtlIHRv
IHNlZSB3b3JraW5nIGtlcm5lbCBidXQgbm90IGNyYXNoZWQgb25lLg0KQW5kIHJldHVybmluZyBl
cnJvciBpcyBhIHdheSB0byBiZWhhdmUgaW4gYSBuaWNlIHdheSwNCmZyb20gbXkgcG9pbnQgb2Yg
dmlldy4NCg0KPiBXaXRoIHRoaXMgcGF0Y2ggaW4gcGxhY2UsIGluIHRoZSBzY2VuYXJpbyB0aGF0
IHlvdSBoYXZlIGJlZW4gY2hhc2luZw0KPiB3aGVyZSBDZXBoRlMgYXBwYXJlbnRseSBhc2tzIHRv
IHJlYWQgWCBieXRlcyBidXQgc2V0cyB1cCBhIHJlcGx5DQo+IG1lc3NhZ2Ugd2l0aCBhIGRhdGEg
YnVmZmVyIHRoYXQgaXMgc21hbGxlciB0aGFuIFggYnl0ZXMsIHRoZQ0KPiBtZXNzZW5nZXINCj4g
d291bGQgZW50ZXIgYSBidXN5IGxvb3AsIGVuZGxlc3NseSByZXBvcnRpbmcgdGhlIG5ldyBlcnJv
ciwNCj4gImZhdWx0aW5nIiwNCj4gcmVlc3RhYmxpc2hpbmcgdGhlIHNlc3Npb24sIHJlc2VuZGlu
ZyB0aGUgb3V0c3RhbmRpbmcgcmVhZCByZXF1ZXN0DQo+IGFuZA0KPiBhdHRlbXB0aW5nIHRvIGZp
dCB0aGUgcmVwbHkgaW50byB0aGUgc2FtZSAoc2hvcnQpIHJlcGx5IG1lc3NhZ2UuwqAgSSdkDQo+
IGFyZ3VlIHRoYXQgYW4gZW5kbGVzcyBsb29wIGlzIHdvcnNlIHRoYW4gYW4gZWFzaWx5IGlkZW50
aWZpYWJsZQ0KPiBCVUdfT04NCj4gaW4gb25lIG9mIHRoZSBrd29ya2VyIHRocmVhZHMuDQo+IA0K
PiBUaGVyZSBpcyBubyBnb29kIHdheSB0byBwcm9jZXNzIHRoZSBuZXcgZXJyb3IsIGF0IGxlYXN0
IG5vdCB3aXRoIHRoZQ0KPiBjdXJyZW50IHN0cnVjdHVyZSBvZiB0aGUgbWVzc2VuZ2VyLsKgIElu
IHRoZW9yeSwgdGhlIHJlYWQgcmVxdWVzdA0KPiBjb3VsZA0KPiBiZSBmYWlsZWQsIGJ1dCB0aGF0
IHdvdWxkIHJlcXVpcmUgd2lkZXIgY2hhbmdlcyBhbmQgYSBidW5jaCBvZg0KPiBzcGVjaWFsDQo+
IGNhc2UgY29kZSB0aGF0IHdvdWxkIGJlIHRoZXJlIGp1c3QgdG8gcmVjb3ZlciBmcm9tIHdoYXQg
Y291bGQgaGF2ZQ0KPiBiZWVuDQo+IGEgQlVHX09OIGZvciBhbiBvYnZpb3VzIHByb2dyYW1taW5n
IGVycm9yLg0KPiANCg0KWWVzLCBJIHRvdGFsbHkgc2VlIHlvdXIgcG9pbnQuIEJ1dCBJIGJlbGll
dmUgdGhhdCBhcyBrZXJuZWwgY3Jhc2ggYXMNCmJ1c3kgbG9vcCBpcyB3cm9uZyBiZWhhdmlvci4g
SWRlYWxseSwgd2UgbmVlZCB0byByZXBvcnQgdGhlIGVycm9yIGFuZA0KY29udGludWUgdG8gd29y
ayB3aXRob3V0IGtlcm5lbCBjcmFzaCBvciBidXN5IGxvb3AuIFdvdWxkIHdlIHJld29yaw0KdGhl
IGxvZ2ljIHRvIGJlIG1vcmUgdXNlci1mcmllbmRseSBhbmQgdG8gYmVoYXZlIG1vcmUgbmljZWx5
Pw0KSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5IGRvIHdlIGhhdmUgYnVzeSBsb29wIGV2ZW4gaWYg
d2Uga25vdyB0aGF0DQpyZXF1ZXN0IGlzIGZhaWxlZD8gR2VuZXJhbGx5IHNwZWFraW5nLCBmYWls
ZWQgcmVxdWVzdCBzaG91bGQgYmUNCmRpc2NhcmRlZCwgZnJvbSB0aGUgY29tbW9uIHNlbnNlLiA6
KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

