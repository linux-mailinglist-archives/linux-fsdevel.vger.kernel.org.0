Return-Path: <linux-fsdevel+bounces-75894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKoNGZDJe2kQIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:56:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACBB45EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B9DA3016EDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1F35A95C;
	Thu, 29 Jan 2026 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RwQbU0+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AD35A945;
	Thu, 29 Jan 2026 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720201; cv=fail; b=WP3B8p0equg7IE095Od2yOOe0aGAgjfWaU4pLRWdPKJKTMmpgK5mwzhvS7AVoElfCoN4S8/+AuOPOnDlSLm4CwcHcadm/u9oKWsUg31v+cxffW4rOEFF1Sr+lGLLlP55i+4ruGAWz6ONRDG086NRForqwH02QWA5IlWwnEC/+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720201; c=relaxed/simple;
	bh=obXZem71u3XbJQrFGFylVCrjd/33dRxLPh0MAjMLAhQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LDaR6irYv1ZIyPTVoNxsIZu0yaj+hVJJXLC99ao8vrNtVEG+EpREYMD5K7QVWfOTN05X6sQvvx7r8ED1v4XL3V1fH3QjjY2TZ90iqLdVsyt3/gbx7YGosYzZyYO1LPuUsgic7H6GPjqmofJb6CKLknJzvPsVf//jTOhU61c3l/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RwQbU0+Q; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEHHJu011234;
	Thu, 29 Jan 2026 20:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=obXZem71u3XbJQrFGFylVCrjd/33dRxLPh0MAjMLAhQ=; b=RwQbU0+Q
	tB2lRCbHurl7KG+Ti05j/w3jW78E5FyLW+dkzaKk0ugadf7ziRxiTfgcxtAaZtAt
	ti1KYcW7R5oT2tdcXEx62gsJJzRUEBFX7xrWm8xFMuYLCv9Xzu4hwYzMYGN7ynsC
	DfEMMH7srkKl5oBqWsjYZC5CZ3HQl8YJd2fpUbzuRqK5u7+ygR9kGhJEtUiA4vkH
	KtxHHIafMbzKAak3lRCkFXAXWU3P13HAj/ouifo0M1/WeFhuhwhV1a24JU2Ny96G
	nl0rgSxqk8HFyLfkoUVQLL6Fw+SSxVxNKvAS2Zl6fOue2UoFp9qAjt5WmNIZgCy6
	nUGRwR4tjSnt6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg88t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 20:56:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60TKuYVY002742;
	Thu, 29 Jan 2026 20:56:34 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg88t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 20:56:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVq5ljVKte1fefSpGNXsNi+OD3zLlOjB7TCTf71cDqOGampebw9eIVlvW8f55nTQsrGyUrXKkQmmjWTwt1xTYxxXKu4xFpeun4WG35sypYs3FY3X7xUkmo9AymJw+AyHrRTFceDEpunFKdc1MkCHc/ECdbOhuEGdU3H4WDsVEglyo1oYUERIairAw/EoSypkg52PbPOoCThhxHYGDwwA0GtYEwX463hJaXop1cbx0iARVeM0pL/XCXkNbXd798fvXAjjXVPSocO0mc71/LoV+AKT3+vD7dqMhjkEQzJReZPmb43RBekzrSU/L0bCLQrGsU8stoOSCO71MaX75dLZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obXZem71u3XbJQrFGFylVCrjd/33dRxLPh0MAjMLAhQ=;
 b=pDvtzZH90s9mJx0ECGPt07P1x6XANwaMFvADZao0oHMxGKD78SX+N+nm7l2ApwxTs0virGwXw7Bh6024ytyOGy1zuE+FyhIGdi10LvPlHT96A8Cs+q4Z0RAVbiTci8KMomXKoTZiOT5/DmkPoWaJr6jSAJyE6f/RnLk+AWQa7jU3kzha/PcGlgclh8wt6YoqlEhJi4DaORTFAfsUdRXn56QRcWTsgEN5C6TlgtXEiXY7I/s7F8EFT6yNU/3pUqkz8KwrlHaYKREa4mgQYh1ns3DIjEj8MsPQZvhy2hMsyz05X9zKrcx0Jx56uHIApSI5pm6IDFgo2SwBR8y02UALdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPF81A6374A2.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 20:56:25 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 20:56:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index:
 AQHcip7gBQv9tICp4U+VJX3elcUj9bVdDvkAgAHwkYCAAWlAgIAAOTuAgARP5ACAAMSKAIAA+5yAgABV+4CAAqYtAA==
Date: Thu, 29 Jan 2026 20:56:25 +0000
Message-ID: <1403eb390fd4332d5e63e3df3e31f6e4f32f96a3.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
	 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
	 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
	 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
	 <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
	 <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
	 <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
	 <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com>
	 <CADhLXY54yiFoqGghDQ9=p7PQXSo7caJ17pBrGS3Ck3uuRDOB5A@mail.gmail.com>
	 <eac09a9664142abbc801197041d34fef44b05435.camel@ibm.com>
	 <CADhLXY6WTN1gTYZ72_GvMyS2RJArX=6-h5-NmpwBGRU_m5FjQA@mail.gmail.com>
In-Reply-To:
 <CADhLXY6WTN1gTYZ72_GvMyS2RJArX=6-h5-NmpwBGRU_m5FjQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPF81A6374A2:EE_
x-ms-office365-filtering-correlation-id: b08d266d-b51c-4ed5-e719-08de5f78dda9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHJRSzdYZWpvVjZub1pVbU0vNjVQbFBtajdpdDlVNk03N29CSW96bW93NVFv?=
 =?utf-8?B?K3hFWHhIeGsrMFRFNjBHaGxPQVltMUNYNnlJOG0rdzJaWkNFTlBpMDBwUVNa?=
 =?utf-8?B?aHQ0WWp6emgrQ3lVSSt2UjIyYVNPMytwMGNXUXo0NTB5REVKeFVRcUMrVnNn?=
 =?utf-8?B?WFJmb00xajBBR2JOd3QrTzlXcktTQ1dLeW00eTllV3pxaU51WGlXNnlJMzVr?=
 =?utf-8?B?SGVjQmpDZ281VExCa2tybDBKeWl4VENiUU4zZ3VCL1FyNTZwbGEzd2pxVGw3?=
 =?utf-8?B?YnlUZE5wQm1LbDdFWU5KKzE5Q2V0MFloWmZlK3I4L2ZaZm9SU0sxM3pOSSs2?=
 =?utf-8?B?L1U3dzROMTY0QjBrTFl0RzZ2YWhaQndBYko0MEw3QTVHczBZYmJNSEErR3pt?=
 =?utf-8?B?OE5jaHRsLzIyOURaVGVEMFR3N01XZnlwNjd1V0UrdVNYRVhuLzI1aVEzbmtG?=
 =?utf-8?B?dU5MeWlHcVpnK1h0WHpDNWM1WGRoUVRINnFISCt5dzVwY3F0Y3ZYWXlwbDd6?=
 =?utf-8?B?ODVKTk8wWnQxK00yZTlsRmFIbThQVlI1VURteUxpQ0FCNHNScWI4U0l2TW0w?=
 =?utf-8?B?UWFtVHY4NjRIWUhiK2F0eHVyL0xLbWY4RkhvSTdEV2dzays5NVF3SWYyU3d1?=
 =?utf-8?B?K2tyc29VVG53bWhtVllMZCswWTgvOGVscU5CNkpaa1kwRnlTUmpTSFM2Nlhq?=
 =?utf-8?B?QXZaZGs4OXR5T3VoQnMwbjRxK2RCWklQVHpZKzZOaXNvWm5hWjVoMW1pYnlI?=
 =?utf-8?B?UmQ0Uk9XSDVYb1RocEliR2NJVFk4OVB2dWx6Ny9LL3hUUGp2TjFaUDBwNEFU?=
 =?utf-8?B?d1d5dGduWTgwNkRQdnJEZDhseGN2dnAwcmlrQzdqUzVGL2xySVF1a2lxeWgy?=
 =?utf-8?B?SUdvYStlMS9pUFh1NzZoSWRQOERTQWZuWUtjSnoxTmpNZUhvNllLTG1saUF2?=
 =?utf-8?B?dlI0NEJpNjRwNitCKy9wdWtnclgxd1d0QWxNNjNoZ0NVWmZXc2pjSXRqV0p3?=
 =?utf-8?B?eFMvdUVDY3VsTml2VW5pbEd1NjBWeFJoNldIeWZIKys1M1Q2ZnVaT1NBekRV?=
 =?utf-8?B?UFNjRWwwTHFEQjVobHJiai80WVRCNXB0UGdoU3FMWnQxWnk4cmFzUERLV205?=
 =?utf-8?B?d3NOb0Raay9pdUw1Z3BhcHZ5aXdKVUFoanZqNmhoRVRJbDdDV0FSTkJ5N1RV?=
 =?utf-8?B?UlVKQUFXc3JrYjlpdjBrdHZQcnIvYzFsOTE5Wk5ONUV0TlRHYU1WL3V2Mi9X?=
 =?utf-8?B?MnV5c1ZIblZrczhEYkxlckVYdWVkWUxaT2ZYTkczS2RrT2NOSDdldXJqd25u?=
 =?utf-8?B?d3M5cVV5NGViUkJQVmZmQktZdG1RU2VpMUpjV0xxb1dQTnNucTAxOUNvek5I?=
 =?utf-8?B?dXB2VURkNWE5ZkQ0a0FCeEZUbm1VY1F1SGF4WFFuTkN6UC9jYzhCUnBGZGFU?=
 =?utf-8?B?NTVYS2RUU2lMeXdNdThvMHpZSUNhaWprdVJFSWFlSW1uUEdFd0JQN0lDckFE?=
 =?utf-8?B?cCtHSE9BQklVeVZObDNzRkRwNVU2T1hDb2lBaFIzYjg5aHdyWEtIUS9Yam40?=
 =?utf-8?B?Y1Iyand5RjZqc0FnRHBKQVA2UGVGM25CRDhDa3FwbWNMY3lubFFudnJnY2Nx?=
 =?utf-8?B?bzFIUkNHY1lnUEgxdVd2YUFtNlpwZm1CenFGY2tRR0RLcG5PaERKOWpPQ0pI?=
 =?utf-8?B?UCsvY1RIQ3Rwc0s4S2ZFSW5qdlhzaStuYnNZa2F0OGQ4TWgzZFR6WC9lbkF4?=
 =?utf-8?B?UVpzZi90THVTZzFNNUtqd2xqNlYrYjhRT0VpSzJIcFd1TzJlME1lQXVnZ3Nj?=
 =?utf-8?B?bkVFakFvdTVqYnh2YlRxRFpCRFhWRlJVMURaNlp6eXNTN3pvakh6RDcvaEhq?=
 =?utf-8?B?ZC9XRnR4b214OXJvNkF2QnUwblQ5VFVpQWhabzR0dUc2VWR6WGIyOU9tYU5Z?=
 =?utf-8?B?RW9QWFA5ZHc1d2k2M3FMZzhVTlljUVBySlpxSCtDNThaMk9ZUjJVck1jOTB0?=
 =?utf-8?B?Zi9lOG94bE0wbHhnaXZDQ2c1TVpXenI0elo3cEZtNnBtRXFEaGpZRUNUVkE3?=
 =?utf-8?B?T3FTM1hDcms2SXhqZjBqYnhXcjgyWnRRcTloMGNPZ2Rhd0JNNlpBL1AwcVVB?=
 =?utf-8?Q?sSEA4TEQjyTV/BlpSfXHlDk28?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWhYT3VHekp5aVlhdklPNm9ySG01Mmh2TGpNdmNZUkVPOHFkTGx3QkdzYWY2?=
 =?utf-8?B?ZEd1cXFVNjBFTFFpQ1cyQkJFQWpOOC9XQUxKTUVXTlJVemdwSDlrZzl6SXRp?=
 =?utf-8?B?RFBKaGpZaVlUdWZBVHRScFRVcWl6MENENmxobWY2MWhVcGhRaVNwb1hhUS9R?=
 =?utf-8?B?dXBCdjNZK2JCWEFOd2k0bE9NODRnYjVueW1MY1hidGtlWjdsYTIybDNnV0JL?=
 =?utf-8?B?bkJxNFJFenJQY1Fiem1rVk1SL2NrZUdWZFZvVk1VMElKWlVQTjA1b2hHM0R1?=
 =?utf-8?B?bjQxd0FnNUdSMjdWVXhJMzJHTDltWW8xVjhoc1l3d29aaUJFOWp0YytGNC9Z?=
 =?utf-8?B?UFNFUTZQQ254eW5KVmtpakpHV1oxVmZnY1ZBamp6RjVUN01pNVVVT08zSnZ1?=
 =?utf-8?B?dTBQTVFrdEx6SnVJTTV3c0JnMkxKc1ZzTWZvWVV5YVJ0TkdJSVcrNEd2Q3lq?=
 =?utf-8?B?RHg2T0xwajlhcG9MTkUzZ3dQeVRtYkR2RWIrN0JkZ3NJMlpmcXJEOXlSYVFW?=
 =?utf-8?B?NlFEdllqNDlMejhBcFl0TEYxY0lVMlpkYjl6dWwyK215SjVOOUFZbXlCYXc2?=
 =?utf-8?B?M3BaRFJQQWF0NUdCNk4wYmIzVU9Nb2FqQnZ6N3hqWkxnNmJ3MVdjUHo2QlZC?=
 =?utf-8?B?QjEvcnFDRUhOeU5HT29rRmxHUjZQTnlQN095dmZtL0ZNL2ZBeUUvMi8zbFU2?=
 =?utf-8?B?ZWJBb1BCMlJIOFEvSXkvSHI4cDhMeWt2SEZralU5d1JTdnNMdkp2ZmtibVRz?=
 =?utf-8?B?RGc3L2NDeGxyem1QcmY5dGc2d2FkSm4xRlpsc3FvQkwvMkdPSmoxeHRoUzhn?=
 =?utf-8?B?dDFvVG5HZVNWTU9zYm9MeWNCQkMwU21MVkNrOEphamVqcEx1dnUrTVA0ei9s?=
 =?utf-8?B?VHR2bGVrMGNIQ2wxOWdzYWU0clV1OElGdjVoamRpeVZBMXpiREdsVTN3d01M?=
 =?utf-8?B?WURoZG11L1M2cEtTcGo4WEdIemRUM3hWd2hQUEVVS0dXZDBCVldlYzR1eTVt?=
 =?utf-8?B?aUplMU5uVXpEU0Z0RWpBd2F2M3V0RnVpemFBTFJ3cGlaUG1aVDRzdTZKcUNy?=
 =?utf-8?B?TmZkdTNYcDVwZ0JyZG5nblIraGx3elJnNzlRdkpqdnpMUmJaRDJ1dE5jaFAw?=
 =?utf-8?B?NC9XKy9wcHQ4ZWlTZEJEUW5MbEoraXppazYzSHNVVTJlNHpwR2FaUXZvUFVo?=
 =?utf-8?B?amcvSXdmMm5meTF4a0pIZW1XdUVaYmZrc25iZjR1UmlOSDZiWjZwRndlL3Ax?=
 =?utf-8?B?Q2plSi9XUVN4TlZhRC9lVDBGQUlEMWpEQm4raGVGc1Z1eEdzcDhsVXBuREZ5?=
 =?utf-8?B?U285dUllUkYzdkxqRTZLejVZYUFRQ1hma0k4bGs2dlpGNGNiZmpRODg1YTVo?=
 =?utf-8?B?T2ZTb2krMGprOXpZejJWbzA5bWhqcnowSCt3TENreW1lck1CWnZmcXVDbWY3?=
 =?utf-8?B?R1ZpaVNCOFoxYU00eFJZMUpvUnVTQWpMQUNuM1o2YjhZTGRTQUpxUXJBVWlj?=
 =?utf-8?B?SUlNL3VVZDBDTzIreHM5a3lMRUdyM1ZhbGVNS1hlMFFUcFVLRzl0bi8wZ3Fn?=
 =?utf-8?B?b253V1JiT05XaVgyZmhCWmhNaTc1c3FRZGVsYzJlNXFaZTk0ekc0ZjEwZXI4?=
 =?utf-8?B?NTJYZzJKVjMzOGs4OTFDQ25BaXRYY25CMU45dFpaWGRJN0JaUVo5S1RXTDRI?=
 =?utf-8?B?dTRQYmhGSVNyNlNTcW41S0VDNG9QVlVFbUNrZzhPYUR4aHJuNFpZQXRYTklJ?=
 =?utf-8?B?QnN3blBMZ29DdVVPcUljOGdhM2RIZHpGS1hLUXNNWng2cmdsWlVTRUpGRFJo?=
 =?utf-8?B?M0dzWUwzcnV0RzdaQnFzY1daR3NxUk1NTDVxbnoxMkxlakloTXRheVUzVStu?=
 =?utf-8?B?NTc5dXloRWpjYnBSQlBaVzQ2OWZXdDBHbVFOZXluN0NCYmwyUzZlclczWk1Z?=
 =?utf-8?B?TmJZNDBjZFVGWWUxMU9NYUFxZXl5em9Xa1UxM0lMSWhjODd4cGVJTHlkOTFq?=
 =?utf-8?B?WmMwQzhCTjFVNGNiTS9QQmdxb0tDTlRlOVlZMlVVaUd5azJSK2ZKT3BiUSsy?=
 =?utf-8?B?VS9MRmtEYVprUHNlQXl1R3ZTMGJoRmJyWmkyL3EyVWQ3V1RIUmd5bDZLWHBs?=
 =?utf-8?B?YkNPT2tzWGc2b2VjRXBITFdPSkpucmlmUjFhSFYrZC9YSzFKNGJJRTVjejlH?=
 =?utf-8?B?SGR1RkVCdTlnTWd2YnVwajF6MHBTZmVnOTBjMnF4WTRnemVqRU1tVVMxN2FN?=
 =?utf-8?B?bXltT3ZHN2tqRUxHSDNNaUkxSDhWNmcvdXArZW9ObWs2bjZTNEkvZ09CWHI0?=
 =?utf-8?B?Z2hJYWV2RHpnYUt4K1VSUjdFNWxiSkhLSS9JYzBrWXJhRWE0cS9IekVxWFJT?=
 =?utf-8?Q?AvoKuoH+aEZumzYTFF6cH4wGoL0q/2NJQfIPy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA0149ADBD276740A5E74C0949A3BE6F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b08d266d-b51c-4ed5-e719-08de5f78dda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 20:56:25.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVgQOjXlhV8RolU/2/W+tJ4W9nhXPWJGrprcgNzW5EDbswiRLu9AG2SLRArGHuw2JllhryYex55IaygpRKasAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF81A6374A2
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697bc982 cx=c_pps
 a=jCxDXDPT0EaKR6BOOOS6sQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=3fAkOviwHhMMiOw6NwUA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: uPzp9ckbE17rv16Rrv2HrG187ka-Nxul
X-Proofpoint-ORIG-GUID: I5Dmd73_wjtV60F2_8ZwdwAC5UMWCkd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1MSBTYWx0ZWRfX7zlP+6HU14pj
 +J0qs0oDzxNqYYcTivgVBk1GWFWf2FC/ti7gYGIYVHDNu21kqy64fO14A+GszaTjz+vCXh1Nwc3
 fgTt1N+brjF6ywJvwjN6sSrH7qQ9EKVDd9RLKfSdiae3D71Z9n0U21Tink4mjR3fxdtpWb+X11k
 AQrVsI/qrUDQTiScRzYg5N9fb6+w9xRF0NV6lLBYaJyYagm+OTJ4VnmNTgbNXehLVqyVrZa8KCT
 4YOQv4mdHdsBifK4hWm1AIlTZoRRto4oA/AECSSWNO1aBDni+U1QzpAMTG5zK8Kg7ahIGzDOybN
 0g9zavhrF1L1vltOmWB8qa0b5/TGHyR/i13/ADNzEGxTZDOM57RHzo8SruGcnsn/bhA4pRJY3Ib
 1qdevxmdbaUrpHSpIh8Fs9EMGQlHs1OSbYvIEJ6Bu0FxY2okozOd7341+PBHn7uR9c6pRWjGQ71
 OS4k5bTjn/L5OkGyssg==
Subject: RE: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75894-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proofpoint.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CFACBB45EF
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDA5OjU5ICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IE9uIFdlZCwgSmFuIDI4LCAyMDI2IGF0IDQ6NTHigK9BTSBWaWFjaGVzbGF2IER1YmV5
a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gQXMgZmFyIGFzIEkgY2Fu
IHNlZSwgaGZzX2JyZWNfcmVhZCgpIG1vc3RseSB1c2VkIGZvciBvcGVyYXRpb25zIHdpdGggQ2F0
YWxvZw0KPiA+IEZpbGUuIEFuZCB3ZSBhbHdheXMgcmVhZCBoZnNwbHVzX2NhdF9lbnRyeSB1bmlv
bi4gQW5kIHlvdSBjYW4gc2VlIHRoYXQgaXQgc3RhcnRzDQo+ID4gZnJvbSB0eXBlIGZpZWxkLg0K
PiA+IA0KPiA+IHR5cGVkZWYgdW5pb24gew0KPiA+ICAgICAgICAgX19iZTE2IHR5cGU7DQo+ID4g
ICAgICAgICBzdHJ1Y3QgaGZzcGx1c19jYXRfZm9sZGVyIGZvbGRlcjsNCj4gPiAgICAgICAgIHN0
cnVjdCBoZnNwbHVzX2NhdF9maWxlIGZpbGU7DQo+ID4gICAgICAgICBzdHJ1Y3QgaGZzcGx1c19j
YXRfdGhyZWFkIHRocmVhZDsNCj4gPiB9IF9fcGFja2VkIGhmc3BsdXNfY2F0X2VudHJ5Ow0KPiA+
IA0KPiA+IFNvLCB5b3UgY2FuIHVzZSB0aGlzIGZpZWxkIHRvIG1ha2UgYSBkZWNpc2lvbiB3aGlj
aCB0eXBlIG9mIHJlY29yZCBpcyB1bmRlcg0KPiA+IGNoZWNrLiBTbywgSSB0aGluayB3ZSBuZWVk
IHRvIGltcGxlbWVudCBnZW5lcmljIGxvZ2ljLCBhbnl3YXkuDQo+ID4gDQo+ID4gVGhhbmtzLA0K
PiA+IFNsYXZhLg0KPiA+IA0KPiA+IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX2VsaXhpci5ib290bGluLmNvbV9saW51eF92Ni4xOS0yRHJj
NV9zb3VyY2VfZnNfaGZzcGx1c19zdXBlci5jLTIzTDU3MCZkPUR3SUZhUSZjPUJTRGljcUJRQkRq
REk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAw
Jm09RXZVamlXRm41N0dPZ2lQRDAyWW1wd1Zhckk2RDdCQWtlM2pDcU5IS0R2RGUxYzFaMVFOQ1NF
czl4aEozZVp1ayZzPTUtdXRvSFRHd1AtVVZ0Sl9EX3ZWY0ZHNTJJZURIeTk0YmRCQUhXN1d3VUkm
ZT0gDQo+ID4gWzJdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1o
dHRwcy0zQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X3Y2LjE5LTJEcmM1X3NvdXJjZV9mc19o
ZnNwbHVzX2Rpci5jLTIzTDUyJmQ9RHdJRmFRJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1
YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1FdlVqaVdGbjU3R09n
aVBEMDJZbXB3VmFySTZEN0JBa2UzakNxTkhLRHZEZTFjMVoxUU5DU0VzOXhoSjNlWnVrJnM9ZzVN
WVZyRVpKWmRIYWtHSHBucEFsUnhBSmp2YTByVVFmNkxYS0FVZ3VoOCZlPSANCj4gPiBbM10gaHR0
cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19lbGl4aXIu
Ym9vdGxpbi5jb21fbGludXhfdjYuMTktMkRyYzVfc291cmNlX2ZzX2hmc3BsdXNfY2F0YWxvZy5j
LTIzTDIwMiZkPUR3SUZhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhO
SnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09RXZVamlXRm41N0dPZ2lQRDAyWW1wd1Zh
ckk2RDdCQWtlM2pDcU5IS0R2RGUxYzFaMVFOQ1NFczl4aEozZVp1ayZzPUJZaEhBdjN2U0hobnpt
dTNhZ0RmcTBMWUhqcDVqaVdJYzliSGk0dHVjTFkmZT0gDQo+IA0KPiANCj4gSGkgU2xhdmEsDQo+
IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBndWlkYW5jZSEgWW91J3JlIHJpZ2h0IC0gd2UgbmVlZCBh
IGdlbmVyaWMgc29sdXRpb24gaW4NCj4gaGZzX2JyZWNfcmVhZCgpIHRoYXQgdmFsaWRhdGVzIGJh
c2VkIG9uIHRoZSBhY3R1YWwgcmVjb3JkIHR5cGUgcmVhZC4NCj4gDQo+IEhlcmUncyBteSB1bmRl
cnN0YW5kaW5nIG9mIHRoZSBhcHByb2FjaDoNCj4gDQo+IC0tLQ0KPiANCj4gaW50IGhmc19icmVj
X3JlYWQoc3RydWN0IGhmc19maW5kX2RhdGEgKmZkLCB2b2lkICpyZWMsIHUzMiByZWNfbGVuKQ0K
PiB7DQo+IGludCByZXM7DQo+IHUxNiB0eXBlOw0KPiB1MzIgbWluX3NpemU7DQoNCkkgc3RpbGwg
ZG9uJ3QgcXVpdGUgZm9sbG93IHdoeSB0aGUgbmFtZSBpcyBtaW5fc2l6ZS4gTXkgdW5kZXJzdGFu
ZGluZyB0aGF0IHdlDQpoYXZlIHRvIGhhdmUgdGhlIGV4YWN0IHNhbWUgbGVuZ3RoLiBTbywgaXQg
c291bmRzIHRvIG1lIGxpa2Ugbm90IG1pbl9zaXplLg0KDQo+IGhmc3BsdXNfY2F0X2VudHJ5ICpl
bnRyeSA9IHJlYzsNCg0KVGhlIGhmc19icmVjX3JlYWQoKSBpcyBnZW5lcmljIGZ1bmN0aW9uIGZy
b20gb25lIHBvaW50IG9mIHZpZXcuIFNvLCBtYXliZSwgd2UNCm5lZWQgdG8gaGF2ZSBhIHNwZWNp
YWxpemVkIHdyYXBwZXIgZnVuY3Rpb24gZm9yIENhdGFsb2cgRmlsZSB0aGF0IHdpbGwgY2FsbA0K
aGZzX2JyZWNfcmVhZCgpIGFuZCB0byBjaGVjayB0aGUgY29ycmVjdG5lc3Mgb2YgdGhlIGxlbmd0
aC4gRG9lcyBpdCBtYWtlIHNlbnNlPw0KDQo+IA0KPiByZXMgPSBoZnNfYnJlY19maW5kKGZkLCBo
ZnNfZmluZF9yZWNfYnlfa2V5KTsNCj4gaWYgKHJlcykNCj4gcmV0dXJuIHJlczsNCj4gaWYgKGZk
LT5lbnRyeWxlbmd0aCA+IHJlY19sZW4pDQo+IHJldHVybiAtRUlOVkFMOw0KPiBoZnNfYm5vZGVf
cmVhZChmZC0+Ym5vZGUsIHJlYywgZmQtPmVudHJ5b2Zmc2V0LCBmZC0+ZW50cnlsZW5ndGgpOw0K
PiArKyAvKiBWYWxpZGF0ZSBiYXNlZCBvbiByZWNvcmQgdHlwZSAqLw0KPiArKyB0eXBlID0gYmUx
Nl90b19jcHUoZW50cnktPnR5cGUpOw0KPiArKw0KDQpQb3RlbnRpYWxseSwgd2UgY291bGQgbm90
IGludHJvZHVjZSB0aGUgbG9jYWwgdmFyaWFibGUgYnV0IHRvIGNoZWNrIGxpa2UgdGhpczoNCg0K
c3dpdGNoIChiZTE2X3RvX2NwdShlbnRyeS0+dHlwZSkpDQoNCj4gKysgc3dpdGNoICh0eXBlKSB7
DQo+ICsrIGNhc2UgSEZTUExVU19GT0xERVI6DQo+ICsrIG1pbl9zaXplID0gc2l6ZW9mKHN0cnVj
dCBoZnNwbHVzX2NhdF9mb2xkZXIpOw0KPiArKyBicmVhazsNCj4gKysgY2FzZSBIRlNQTFVTX0ZJ
TEU6DQo+ICsrIG1pbl9zaXplID0gc2l6ZW9mKHN0cnVjdCBoZnNwbHVzX2NhdF9maWxlKTsNCj4g
KysgYnJlYWs7DQo+ICsrIGNhc2UgSEZTUExVU19GT0xERVJfVEhSRUFEOg0KPiArKyBjYXNlIEhG
U1BMVVNfRklMRV9USFJFQUQ6DQo+ICsrIC8qIEZvciB0aHJlYWRzLCBzaXplIGRlcGVuZHMgb24g
c3RyaW5nIGxlbmd0aCAqLw0KPiArKyBtaW5fc2l6ZSA9IG9mZnNldG9mKGhmc3BsdXNfY2F0X2Vu
dHJ5LCB0aHJlYWQubm9kZU5hbWUpICsNCg0KWW91IGNhbiB1c2Ugc3RydWN0IGhmc3BsdXNfY2F0
X3RocmVhZCBoZXJlLg0KDQo+ICsrICAgIG9mZnNldG9mKHN0cnVjdCBoZnNwbHVzX3VuaXN0ciwg
dW5pY29kZSkgKw0KPiArKyAgICBiZTE2X3RvX2NwdShlbnRyeS0+dGhyZWFkLm5vZGVOYW1lLmxl
bmd0aCkgKiAyOw0KDQpJIGFzc3VtZSB5b3UgbWVhbiBzaXplb2YoaGZzcGx1c191bmljaHIpLiBB
bmQgaXQncyBiZXR0ZXIgdG8gaGF2ZSBpdCBpbnN0ZWFkIG9mDQpoYXJkY29kZWQgdmFsdWUuDQoN
ClRoZSB3aG9sZSBjYWxjdWxhdGlvbiBsb29rcyBsaWtlIGEgZ29vZCBjYW5kaWRhdGUgZm9yIGlu
bGluZSBmdW5jdGlvbiBvciBtYWNyby4NCg0KPiArKyBicmVhazsNCj4gKysgZGVmYXVsdDoNCj4g
KysgcHJfZXJyKCJ1bmtub3duIGNhdGFsb2cgcmVjb3JkIHR5cGUgJWRcbiIsIHR5cGUpOw0KPiAr
KyByZXR1cm4gLUVJTzsNCj4gKysgfQ0KPiArKw0KPiArKyBpZiAoZmQtPmVudHJ5bGVuZ3RoIDwg
bWluX3NpemUpIHsNCg0KSSB0aGluayB3ZSBleHBlY3QgdGhhdCBmZC0+ZW50cnlsZW5ndGggc2hv
dWxkIGJlIGVxdWFsIHRvIG1pbl9zaXplLg0KDQo+ICsrIHByX2VycigiaW5jb21wbGV0ZSByZWNv
cmQgcmVhZCAodHlwZSAlZCwgZ290ICV1LCBuZWVkICV1KVxuIiwNCj4gKysgICAgICAgIHR5cGUs
IGZkLT5lbnRyeWxlbmd0aCwgbWluX3NpemUpOw0KPiArKyByZXR1cm4gLUVJTzsNCj4gKysgfQ0K
PiByZXR1cm4gMDsNCj4gfQ0KPiANCj4gQW5kIGluIGhmc3BsdXNfZmluZF9jYXQoKToNCj4gDQo+
IGludCBoZnNwbHVzX2ZpbmRfY2F0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHUzMiBjbmlkLA0K
PiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpDQo+IHsNCj4g
LS0gaGZzcGx1c19jYXRfZW50cnkgdG1wOw0KPiArKyBoZnNwbHVzX2NhdF9lbnRyeSB0bXAgPSB7
MH07DQo+IGludCBlcnI7DQo+IHUxNiB0eXBlOw0KPiBoZnNwbHVzX2NhdF9idWlsZF9rZXlfd2l0
aF9jbmlkKHNiLCBmZC0+c2VhcmNoX2tleSwgY25pZCk7DQo+IGVyciA9IGhmc19icmVjX3JlYWQo
ZmQsICZ0bXAsIHNpemVvZihoZnNwbHVzX2NhdF9lbnRyeSkpOw0KPiBpZiAoZXJyKQ0KPiByZXR1
cm4gZXJyOw0KPiAvKiBoZnNfYnJlY19yZWFkKCkgYWxyZWFkeSB2YWxpZGF0ZWQgdGhlIHJlY29y
ZCAqLw0KPiAuLi4NCj4gfQ0KPiANCj4gLS0tDQo+IA0KPiBUaGlzIHdheToNCj4gMS4gR2VuZXJp
YyB2YWxpZGF0aW9uIGluIGhmc19icmVjX3JlYWQoKSB1c2luZyB0aGUgdHlwZSBmaWVsZA0KPiAy
LiBXb3JrcyBmb3IgYWxsIGNhbGxlcnMgKGZvbGRlciwgZmlsZSwgdGhyZWFkIHJlY29yZHMpDQo+
IDMuIFZhcmlhYmxlLXNpemUgdmFsaWRhdGlvbiBmb3IgdGhyZWFkIHJlY29yZHMgYmFzZWQgb24g
c3RyaW5nIGxlbmd0aA0KPiA0LiBGaXhlZC1zaXplIHZhbGlkYXRpb24gZm9yIGZvbGRlciBhbmQg
ZmlsZSByZWNvcmRzDQo+IDUuIEluaXRpYWxpemUgdG1wID0gezB9IGFzIGRlZmVuc2l2ZSBwcm9n
cmFtbWluZw0KPiANCj4gRG9lcyB0aGlzIGFwcHJvYWNoIGxvb2sgY29ycmVjdD8gU2hvdWxkIEkg
aGFuZGxlIGFueSBvdGhlciByZWNvcmQgdHlwZXMgaW4NCj4gdGhlIHN3aXRjaCBzdGF0ZW1lbnQ/
DQoNClBsZWFzZSwgc2VlIG15IGNvbW1lbnRzIGFib3ZlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

