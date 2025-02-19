Return-Path: <linux-fsdevel+bounces-42119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18DA3C96A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C362165F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62822DFA9;
	Wed, 19 Feb 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kbwHaM5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5B22D7AE;
	Wed, 19 Feb 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996009; cv=fail; b=P3Qyyy8no7QPXMP/h77I9CUn3CkjjKHzBEPK6VQAHKeWDOdHSvOUHX3fu1pnLmGc8KssmuC1wADso8H0FMWKQYkL4KxclhNKW2RFVoSWj+kGeuzL+luKrPyiL7JxbSX3w0hftFV5T3iLnELs0dCoDRSa9WMDxovEpkNH4LWV9WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996009; c=relaxed/simple;
	bh=qNUG3SQWyW+fM2N/wCpWLjI/k6yHkTqL3itfUkgW2G0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NB15AWncc6hayTqXZPfWNyBc77U39zBnERt0+B1rzWH7VsqLi8t8vlJSdzsgZu/PCVKP0aEt6VAJFaFR6QxqgVbQiBDQV2Sse5/dRCk7NeIEmf932yt5ypkfUeeTNEpkzRRvgi/vNiSpwYERDjLaiJkwjcXhN6WQlnjQlj3lyUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kbwHaM5/; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFdhNs002482;
	Wed, 19 Feb 2025 20:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=qNUG3SQWyW+fM2N/wCpWLjI/k6yHkTqL3itfUkgW2G0=; b=kbwHaM5/
	39HVAz8la+/gvixZmd0HYhhiZvfuE6GqyYKHcC1f3xE5wWjTLjKt12bc44t9SaSl
	lNCh1XArnvOBoUgi9cuEJK4OH7yqzDfz/sw8mRPtBlHHCA6ZiCddnl+q0gZ4FJZg
	osMeQ5awrULXN/UB+vWfrCTzgDf7D0hg1TKNQVSUuzGkqroP70oAO3eRuy3SEfSc
	WgH7fXZfR0lTAflbjx6YMj8QennmEGFacs/b/+MTxku7nvGizIre0VHjY0Jax+v6
	f0fso8ytgZfLrt/ycZIKZUw59l0cgfpa0jTDg91bYg4ldPnQNSJMKJB2LR0CFxav
	KLC1CzV+bh1k4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wj4thd3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 20:13:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51JK8bU1003976;
	Wed, 19 Feb 2025 20:13:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wj4thd3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 20:13:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFIvUgoH7WgX247RknMfTYAN6QH4OleI6WG/8Oob5kKPUeZL+6pLnGJseGVrmAJdunAyF20poKGOwjAMV1X7Kmv7/Nkz7hfia8pHejUlAEd1Ri0rNf5qEmlcK/togaDz0j3bnxxa6Y1fVoXbYleNQHofQfIXQd22HukAap5VeVPlQl7DFgzOlivEKtDZXsyvUYYxf3lkUyB+QWtGisfyL1Ar7N1hPJKSbK1TW4efW9d0MfjSFhQ8XLnTtAVE15Ov15gs9cZjOGctxFuJ4OM0+hK/QgpSEFLHsDPS9rGth3n5kk5apKbe58CveaR8lYbDpBiK9+2gr44ZGtN3cJJBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNUG3SQWyW+fM2N/wCpWLjI/k6yHkTqL3itfUkgW2G0=;
 b=IDUFNjj8L0BlJohaxO6xvU6xYZjBux2xnCvv4ZbXrDTXeSBLDa1VSuDM2lyBpR/gOWOreqwEHgpfThlRmuaWcikphdvn9cuh96Zjqk+5LOSgmonowkOSbtgl6pP+SDTmUp4aX31OBUBdZJX9NK68DtHkPBFq3CmYc9RcenJaNMS/3ARxZ1FBC04JnzA2BkAVKa5hDWNkLCoBuF1zztwVljKzhwgT3FvDVA9RU2q1auU0fcF8+vfpcCsKFkEMfvoeug7UeV5GI4srQbYC7Lk1CwRXnk/OG43x9LzoSHWg4xh33sbYH084TMX1AIK1GBCUs5sD2W5TbcYKsgmLjpKHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6624.namprd15.prod.outlook.com (2603:10b6:208:520::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 20:13:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 20:13:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>,
        David Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHbgswSFOetK3CmSU29/fUzZmt7ubNPD9UA
Date: Wed, 19 Feb 2025 20:13:18 +0000
Message-ID: <8b6bcbf5ba377180fed3a31115b1a20b31f0b7df.camel@ibm.com>
References: <20250219003419.241017-1-slava@dubeyko.com>
	 <CAO8a2SjeD0_OryT7i028WgdOG5kB=FyNMe+KnPHEujVtU1p7WQ@mail.gmail.com>
In-Reply-To:
 <CAO8a2SjeD0_OryT7i028WgdOG5kB=FyNMe+KnPHEujVtU1p7WQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6624:EE_
x-ms-office365-filtering-correlation-id: da9ae793-5ea3-4d7e-5df3-08dd5121d9f7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlpOa2pYSFdtVEVFMXRoZ3ZldVpFMmhMUStveHJoMCtoWG84MlpWZlJjbkZo?=
 =?utf-8?B?QjJlRm5HeHVaYzgzazdLUGZBRkhDMlRwZS9NT0xQMTBFNTVxRnNPdkFsV3NV?=
 =?utf-8?B?ZjVtMFBBQjNyRXZTRWhJRjFZZVU4MEhwaGJ1a2pvbDVxWE9pRTRVbjI4S1Za?=
 =?utf-8?B?NGk1a3lzVTlLMk5TWEFSZjhVUVhFV08yQ2dNL3ZES3lvUG5XWEFRK1lncUtk?=
 =?utf-8?B?QmRHaDdld3NraVhUT1ZMY1F4dEd6MzRtNmRVUUErTWlKN0tyR1M0Wlk2L2Nn?=
 =?utf-8?B?VElaY0ZmNXpCS2lkWHR3V3oxS3ZnRFVZOHV2Nk02bFlpa3h4TmUvUXBCdnI2?=
 =?utf-8?B?b1BxTWpLZEJwWXNLVjFGTU8zeXZ2UDZUcFJ2TjlkK3Z6VWFBUkdrZUY3T2lU?=
 =?utf-8?B?eGdaNmRwN1RwbVE2emlxYzNTLy9aZ3BXQ2Naeko4azlRdC8xSDNmdTRVQ3hB?=
 =?utf-8?B?aUFER1lnZkc3bU5hL01SbXdYRFNPWlR6NlVZVjFiTW01N2NYTEhsVGpOeS9n?=
 =?utf-8?B?dFJUUW5DOU1ORldxemJvYlVGS0F1OXN2cUxYSjNqck1USm5kMGR3bXN5aFhh?=
 =?utf-8?B?ZkJTU0lEMU9mNzBOR01TbFUxSzJqV3dvWGgvYUFxREd6aldTd2E5U01td2I4?=
 =?utf-8?B?cDdBVjZuTThpQjM1Z1FLQkhQWE1rVEx2VTZFUENYUlRQSXNuUmlwMVIvNHZ4?=
 =?utf-8?B?dWJDQ2NwV3RBMDNCV296d1djTjlzekU0ZDdCRjFYRHJXWGRYeHBZQXU0d3ox?=
 =?utf-8?B?aW5Wb1IwNjlGYkVKYXgzNEtudGo3Wi9pZ080RGs5Q2paZTRqWm1CT1UrbVAv?=
 =?utf-8?B?bzRRUE03VldkWlZVVTErMGtPNnRaTUNERS9oT09rcnlaaWlPdUJjSDhyeVRz?=
 =?utf-8?B?aThlN0ZXd1V1eHpNWlpOMzM2ZVF1aUlXdmNLMnZPRDhFaHNIN2RhSUpncE1O?=
 =?utf-8?B?YzdUMmdVVEJrUElnMGlickJWZUM3cHZKMkE3T2g0ZlZqYXZPN1hYTjFJcks2?=
 =?utf-8?B?UnNYNUVCY3VHV2l4VjUwVlpEYVBES2doS2tWQVZYVmFYUGZ5NVE1dUlPblZJ?=
 =?utf-8?B?MmhmRFBXQUFvd0dTT3RKK2gyUExlaVpSd2ZiTW5BeGpGY05lbHFMVnVPdWRV?=
 =?utf-8?B?T2I4dEVFN1g2MHNyZTFyUWVVaFFRSzhWaHhoTFpjNWEwOE14ZVVQYlJ0Ky8y?=
 =?utf-8?B?S2FQVlU0c1grTHY1TCtUTjBNRHptcStLajJQcTVoSERBSG5lM3JjcTFQdTdB?=
 =?utf-8?B?YW5qZm84RVNXd0xqR25RU2x2MGpIbGpqQng2ZlYxaHNWSWlUckh6bVhGM2NS?=
 =?utf-8?B?bTBMZUNNOHJ3MXpEMkJFY1EyZG12MllrYUhkQ29weTBsRjd2bDB4YXdVbkNr?=
 =?utf-8?B?OUFiWEVtMXZUeDA3bkJvRmFrTnY2TnQrZzlWV2MxbG52WGg3S1NGYzlUZEtt?=
 =?utf-8?B?cUlRNlFPYWRhTE1YZzQwTFM5S3VEZU95K0djVUpNcnBaTTdNYklNcE1mS1BR?=
 =?utf-8?B?VXBST0hSd2ZvakI2ZmRoVTMzQ2lQbUFGMHc0bW5kdnh5bnFxWjlEMDExeHJu?=
 =?utf-8?B?T0t2b1pCaGRsUTNpTUNRMXR0RXZLMWozQnFvUE5xZzVsanViTk9pSS9xSHVL?=
 =?utf-8?B?YWxBejB2cENWOG1IOEFCSjg3OGlEbThCWENpN2dYVEo3V0h1U2FMcStuRGUw?=
 =?utf-8?B?VkhkM2tkaGFsaVZBT1RvV21nN3R2K0czeXFlaFM3S0JralhsTndoemJOUXln?=
 =?utf-8?B?aW5aUEw2UDRwUHZ1YUZaWkNDYnJzQjBMYTRGYytWNmQvQXdpV2VIb2lLekxt?=
 =?utf-8?B?cXZucXlrbGV3SlJscGl6SUJ2TWFHcnM4K09uUU9iTGJOK2l4djliWlFySlIw?=
 =?utf-8?B?ZmloY0trc0gra2Z6QUZSODdUQTJidW91ZUR4NWkrVmUxTGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVVTME9teDR1TmdDZ1NNSEhZR1VPbG9ZcVY0N2xoWWN5ZWxGWVJGZUdPU3dD?=
 =?utf-8?B?ZWJqVXBEam1hajkyVGdHa01pMGNQdzh0c3hCU01UUUgrbklnRnpiSC9UMVV5?=
 =?utf-8?B?cElTTnpWNlZzVUM1WEVyMTNMSklucXdvbk9nMk9wVUl3T0UxV1BxcFpoemNp?=
 =?utf-8?B?NEs4dGZmT0Z5VUxTbTBKZjJIQ3UzSDl0M0VSS2t2U1A0TnhTMWhDWUlqNFBO?=
 =?utf-8?B?TE5WMjZLVVZsUlZRZFVGTElZaHk4SnV6RGU1UzN3SklkOTc0Wkw0aGdVdi8r?=
 =?utf-8?B?cjZCQVQrV2VKZEhWakJFQll1dEEwR01IRGxWRld2N3Q0cXkxMEF6QWJEUzdD?=
 =?utf-8?B?WW8vWktmM0E5UDdNM01GckJFdUxvSWk0eUx6eCtYSUQ4L0hQNkI5WUkwTHcx?=
 =?utf-8?B?azdYVTJBaTFVb0Q5QkFqZTIwWlBrdUV2bTliTjFOZkdsVW1hNHB0N3gxUGRQ?=
 =?utf-8?B?WTN3R2tyQmhHSkRidkNjNVVFZzUxa2ZEc1k0ZlloKzlmellHeDJ0UGI1YkZr?=
 =?utf-8?B?RFlkWHV0UHBDaWRkeW5rMWh3VVJXTHJ5UzFCdStxS2hwK29IVjdMVEpDUEtl?=
 =?utf-8?B?UWUvTUJyVkRlbk13dkxrdVcwN0lkQ3dMU2V1QkZ5akpyVnVHM0d4T0dZcjd6?=
 =?utf-8?B?dDdIMTFOK2FxdUNCdC9ZQW01VDlUVExBQzczRElFaWU1UFp5NDgwRUg4R0xB?=
 =?utf-8?B?c1Q2QVpNTm9SL2t3VTgzaklubkFpdll1S1U2VG8zQkxpckQvMkJ1SUhDajZv?=
 =?utf-8?B?Sjl4eWFFL25PYjMrZXNkTVVCd2l0YnVPdkxuMy9hZzBQVDh4eGkvYTIvN3g0?=
 =?utf-8?B?cTVySmM3WXZmZ3lwbGJlQzZxT1pvZjdNbUV0QXpFSTNRb3JGMExHamFpRlRO?=
 =?utf-8?B?YzQ5V1U4T04xNk96dkxudVNlZU0waHpCWU9yc2tZNXFyYlQveUVENm1qRHo3?=
 =?utf-8?B?SExtcTRDeUJOZW02bGlENkVmNjJRcjVxQmVRalhMaEFSOGhJUlNsZFFFY2kv?=
 =?utf-8?B?QXBSUVlFTTc4N2t4Q3BkdE1Zbis3OFU2STJ2SWdLaHpMNjVmNjhPNi9hNnNv?=
 =?utf-8?B?QzRWckUxMWpVZktsZlNmSFp2Tk5qZkdSaXl1bml4RlNId0ZVUkdDelpMOXNL?=
 =?utf-8?B?VTZYQVBncFp1Qnd1Qkh4eTRnbmtoa3BvNjhWM29hWTY1QUdTTVJmaVNrMFhy?=
 =?utf-8?B?THNsa3hUcTUzeHFLMHpqeDlYVmcxYTVKZUV5VnU4Rzd5V1UrMDFXRUpEU3Vu?=
 =?utf-8?B?VFQrNlRHd3U2RUd2T2R1UjRGT1VVSXpXd3lvSTdPQXF6T1JqdUVGMWszRTRT?=
 =?utf-8?B?blY4M0QxNkRQdTBsclArdlRUZXpxQld3eTVZaHZmZ2ZlanJodGJFZWl2cHlm?=
 =?utf-8?B?TTlWYzk0WXpieVR0QUw3cERGS1cxd3U2Rm02bVBPK0UxeFZocDhlQUpmZzhQ?=
 =?utf-8?B?ZlJUMFhwTUViOENjVmZXajZvVHAxTURxSzdwR3FDNkV6N0VGQnpaTHQvZ1BU?=
 =?utf-8?B?U0JxRjd0MzlMaHhlQ0IzSmE4NUd6M2VWaVZGSTZJTjhoN1lrbTJsalJhZ2x4?=
 =?utf-8?B?WlJJWlppYzkxT2JVMFpkMnhlbXA1Sm1lQWFnYWxBRFZ5NmJvWEx1WDRvbDRx?=
 =?utf-8?B?ZCszUmNUekozVXJra2FOZDNCS09hQldOLzE5ZS9oQjY3cDc2NXNRc3lxLzdr?=
 =?utf-8?B?eDAycHF5S3ZYYlRwYlJFNDNiSFBSMlhnS2c5dTUyZHBSSXcxTTlTaDBOVENB?=
 =?utf-8?B?UHVIeDM0T2ptdEI5bVArV3VEMUJ1dzBrOTNseGc5RFF3M1JZRnY3ak5BVlB0?=
 =?utf-8?B?YVo3TzU3OWdqNUErdnVUVE0zT3ZHTTBKTWtKNXNhZmIrT25DdDlRNUl6b0Ix?=
 =?utf-8?B?NCtibkJyYVI1cTRZc2E2NHhnVVBzRU0xenJ3dzMydktvbWpManNTWUQ1Zm4y?=
 =?utf-8?B?bU9YbXVncExBZW9EdHNQRFJIUzRYTGFVYzFKTHFoMGtEQVV1RTliL2F4R1RS?=
 =?utf-8?B?V1NwbmFzNjREVlBUSENLQnBOSmlFZkZBWGQrVWhvVjh4K2l4b2hvZVhwekRt?=
 =?utf-8?B?Sk16RFV2azVSUnp4Tk9QdzBWM1dqRFMyRkU2SldwMFU5V1ovZFlBUjI2T3ZY?=
 =?utf-8?B?Q1ZSQjBYZCtLa25TOENvSGo4VEErbmFDbVQyWGU0YzJvRmhtOUpjazVDV3Vn?=
 =?utf-8?Q?rUoOOaYnm/N4BGBMMryQEZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FF54CBB3CB9984AA0A5C34B12CF19CF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da9ae793-5ea3-4d7e-5df3-08dd5121d9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 20:13:18.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MtbMy9l+oP5/LKhj/w2sh1Wwuz8UfWGLFMDIXE9QE6akT+8FX82O3SM0f0qoQnSxrsGduQo1tUNYCXHuHEtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6624
X-Proofpoint-GUID: -79CAf7S__1jjlUjMnTelMXAB2AIAX1b
X-Proofpoint-ORIG-GUID: 80EB3hoYbiyzsRHelcABBRISWmKzZWFC
Subject: RE: [PATCH] ceph: fix slab-use-after-free in have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190154

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE0OjQ0ICswMjAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IFRoaXMgZml4ZXMgdGhlIFRPQ1RPVSBwcm9ibGVtIG9mIGFjY2Vzc2luZyB0aGUgZXBvY2ggZmll
bGQgYWZ0ZXIgbWFwLWZyZWUuDQo+IEknZCBsaWtlIHRvIGtub3cgaWYgaXQncyBub3QgbGVhdmlu
ZyBhIGNvcnJlY3RuZXNzIHByb2JsZW0gaW5zdGVhZC4gSXMNCj4gdGhlIHJldHVybiB2YWx1ZSBv
ZiAgaGF2ZV9tb25fYW5kX29zZF9tYXAgc3RpbGwgdmFsaWQgYW5kIHJlbGV2YW50IGluDQo+IHRo
aXMgY2FzZSwgd2hlcmUgaXQgaXMgYmVpbmcgY29uY3VycmVudGx5IGZyZWVkPw0KPiANCg0KRnJh
bmtseSBzcGVha2luZywgSSBkb24ndCBxdWl0ZSBmb2xsb3cgeW91ciBwb2ludC4NCg0KVGhlIGhh
bmRsZV9vbmVfbWFwKCkgWzFdIGNhbiBjaGFuZ2UgdGhlIG9sZCBtYXAgb24gbmV3IG9uZToNCg0K
CWlmIChuZXdtYXAgIT0gb3NkYy0+b3NkbWFwKSB7DQogICAgICAgICAgICAgICAgPHNraXBwZWQ+
DQoJCWNlcGhfb3NkbWFwX2Rlc3Ryb3kob3NkYy0+b3NkbWFwKTsNCjwtLS0gVGhyZWFkIGNvdWxk
IHNsZWVwIGhlcmUgLS0tPg0KCQlvc2RjLT5vc2RtYXAgPSBuZXdtYXA7DQoJfQ0KDQpBbmQgaGF2
ZV9tb25fYW5kX29zZF9tYXAoKSBbMl0gY2FuIHRyeSB0byBhY2Nlc3Mgb3NkYy0+b3NkbWFwDQpp
biB0aGUgbWlkZGxlIG9mIHRoaXMgY2hhbmdlIG9wZXJhdGlvbiB3aXRob3V0IHVzaW5nIHRoZSBs
b2NrLA0KYmVjYXVzZSB0aGlzIG9zZG1hcCBjaGFuZ2UgaXMgZXhlY3V0aW5nIHVuZGVyIG9zZGMu
bG9jay4NCg0KU28sIGRvIHlvdSBtZWFuIHRoYXQgaXQgaXMgaW1wb3NzaWJsZSBjYXNlPyBPciBk
byB5b3UgbWVhbiB0aGF0DQp0aGUgc3VnZ2VzdGVkIGZpeCBpcyBub3QgZW5vdWdoIGZvciBmaXhp
bmcgdGhlIGlzc3VlPyBXaGF0IGlzIHlvdXINCnZpc2lvbiBvZiB0aGUgZml4IHRoZW4/IDopDQoN
ClRoZSBpc3N1ZSBpcyBub3QgYWJvdXQgY29tcGxldGUgc3RvcCBidXQgYWJvdXQgb2Ygc3dpdGNo
aW5nIGZyb20NCm9uZSBvc2RtYXAgdG8gYW5vdGhlciBvbmUuIEFuZCBoYXZlX21vbl9hbmRfb3Nk
X21hcCgpIGlzIHVzZWQNCmluIF9fY2VwaF9vcGVuX3Nlc3Npb24oKSBbM10gdG8gam9pbiB0aGUg
Y2VwaCBjbHVzdGVyLCBhbmQgb3Blbg0Kcm9vdCBkaXJlY3Rvcnk6DQoNCi8qDQogKiBtb3VudDog
am9pbiB0aGUgY2VwaCBjbHVzdGVyLCBhbmQgb3BlbiByb290IGRpcmVjdG9yeS4NCiAqLw0KaW50
IF9fY2VwaF9vcGVuX3Nlc3Npb24oc3RydWN0IGNlcGhfY2xpZW50ICpjbGllbnQsIHVuc2lnbmVk
IGxvbmcgc3RhcnRlZCkNCnsNCgl1bnNpZ25lZCBsb25nIHRpbWVvdXQgPSBjbGllbnQtPm9wdGlv
bnMtPm1vdW50X3RpbWVvdXQ7DQoJbG9uZyBlcnI7DQoNCgkvKiBvcGVuIHNlc3Npb24sIGFuZCB3
YWl0IGZvciBtb24gYW5kIG9zZCBtYXBzICovDQoJZXJyID0gY2VwaF9tb25jX29wZW5fc2Vzc2lv
bigmY2xpZW50LT5tb25jKTsNCglpZiAoZXJyIDwgMCkNCgkJcmV0dXJuIGVycjsNCg0KCXdoaWxl
ICghaGF2ZV9tb25fYW5kX29zZF9tYXAoY2xpZW50KSkgew0KCQlpZiAodGltZW91dCAmJiB0aW1l
X2FmdGVyX2VxKGppZmZpZXMsIHN0YXJ0ZWQgKyB0aW1lb3V0KSkNCgkJCXJldHVybiAtRVRJTUVE
T1VUOw0KDQoJCS8qIHdhaXQgKi8NCgkJZG91dCgibW91bnQgd2FpdGluZyBmb3IgbW9uX21hcFxu
Iik7DQoJCWVyciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KGNsaWVudC0+YXV0
aF93cSwNCgkJCWhhdmVfbW9uX2FuZF9vc2RfbWFwKGNsaWVudCkgfHwgKGNsaWVudC0+YXV0aF9l
cnIgPCAwKSwNCgkJCWNlcGhfdGltZW91dF9qaWZmaWVzKHRpbWVvdXQpKTsNCgkJaWYgKGVyciA8
IDApDQoJCQlyZXR1cm4gZXJyOw0KCQlpZiAoY2xpZW50LT5hdXRoX2VyciA8IDApDQoJCQlyZXR1
cm4gY2xpZW50LT5hdXRoX2VycjsNCgl9DQoNCglwcl9pbmZvKCJjbGllbnQlbGx1IGZzaWQgJXBV
XG4iLCBjZXBoX2NsaWVudF9naWQoY2xpZW50KSwNCgkJJmNsaWVudC0+ZnNpZCk7DQoJY2VwaF9k
ZWJ1Z2ZzX2NsaWVudF9pbml0KGNsaWVudCk7DQoNCglyZXR1cm4gMDsNCn0NCkVYUE9SVF9TWU1C
T0woX19jZXBoX29wZW5fc2Vzc2lvbik7DQoNClNvLCB3ZSBzaW1wbHkgbmVlZCB0byBiZSBzdXJl
IHRoYXQgc29tZSBvc2RtYXAgaXMgYXZhaWxhYmxlLA0KYXMgZmFyIGFzIEkgY2FuIHNlZS4gUG90
ZW50aWFsbHksIG1heWJlLCB3ZSBuZWVkIHRvIE5VTEwNCnRoZSBvc2RjLT5vc2RtYXAgaW4gY2Vw
aF9vc2RjX3N0b3AoKSBbNF06DQoNCnZvaWQgY2VwaF9vc2RjX3N0b3Aoc3RydWN0IGNlcGhfb3Nk
X2NsaWVudCAqb3NkYykNCnsNCglkZXN0cm95X3dvcmtxdWV1ZShvc2RjLT5jb21wbGV0aW9uX3dx
KTsNCglkZXN0cm95X3dvcmtxdWV1ZShvc2RjLT5ub3RpZnlfd3EpOw0KCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmb3NkYy0+dGltZW91dF93b3JrKTsNCgljYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoJm9zZGMtPm9zZHNfdGltZW91dF93b3JrKTsNCg0KCWRvd25fd3JpdGUoJm9zZGMtPmxvY2sp
Ow0KCXdoaWxlICghUkJfRU1QVFlfUk9PVCgmb3NkYy0+b3NkcykpIHsNCgkJc3RydWN0IGNlcGhf
b3NkICpvc2QgPSByYl9lbnRyeShyYl9maXJzdCgmb3NkYy0+b3NkcyksDQoJCQkJCQlzdHJ1Y3Qg
Y2VwaF9vc2QsIG9fbm9kZSk7DQoJCWNsb3NlX29zZChvc2QpOw0KCX0NCgl1cF93cml0ZSgmb3Nk
Yy0+bG9jayk7DQoJV0FSTl9PTihyZWZjb3VudF9yZWFkKCZvc2RjLT5ob21lbGVzc19vc2Qub19y
ZWYpICE9IDEpOw0KCW9zZF9jbGVhbnVwKCZvc2RjLT5ob21lbGVzc19vc2QpOw0KDQoJV0FSTl9P
TighbGlzdF9lbXB0eSgmb3NkYy0+b3NkX2xydSkpOw0KCVdBUk5fT04oIVJCX0VNUFRZX1JPT1Qo
Jm9zZGMtPmxpbmdlcl9yZXF1ZXN0cykpOw0KCVdBUk5fT04oIVJCX0VNUFRZX1JPT1QoJm9zZGMt
Pm1hcF9jaGVja3MpKTsNCglXQVJOX09OKCFSQl9FTVBUWV9ST09UKCZvc2RjLT5saW5nZXJfbWFw
X2NoZWNrcykpOw0KCVdBUk5fT04oYXRvbWljX3JlYWQoJm9zZGMtPm51bV9yZXF1ZXN0cykpOw0K
CVdBUk5fT04oYXRvbWljX3JlYWQoJm9zZGMtPm51bV9ob21lbGVzcykpOw0KDQoJY2VwaF9vc2Rt
YXBfZGVzdHJveShvc2RjLT5vc2RtYXApOyA8LS0tIEhlcmUsIHdlIG5lZWQgdG8gTlVMTCB0aGUN
CnBvaW5lcg0KCW1lbXBvb2xfZGVzdHJveShvc2RjLT5yZXFfbWVtcG9vbCk7DQoJY2VwaF9tc2dw
b29sX2Rlc3Ryb3koJm9zZGMtPm1zZ3Bvb2xfb3ApOw0KCWNlcGhfbXNncG9vbF9kZXN0cm95KCZv
c2RjLT5tc2dwb29sX29wX3JlcGx5KTsNCn0NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXQ0KaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQtcmMyL3NvdXJjZS9uZXQvY2VwaC9v
c2RfY2xpZW50LmMjTDQwMjUNClsyXQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuMTQtcmMyL3NvdXJjZS9uZXQvY2VwaC9jZXBoX2NvbW1vbi5jI0w3OTENClszXQ0KaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTQtcmMyL3NvdXJjZS9uZXQvY2VwaC9jZXBo
X2NvbW1vbi5jI0w4MDANCls0XQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYu
MTQtcmMyL3NvdXJjZS9uZXQvY2VwaC9vc2RfY2xpZW50LmMjTDUyODUNCg0KDQoNCg==

