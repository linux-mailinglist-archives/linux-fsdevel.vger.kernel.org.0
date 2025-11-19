Return-Path: <linux-fsdevel+bounces-69141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75481C70EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 913C84E0631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC646371DC3;
	Wed, 19 Nov 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVhDTZZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC1335063
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582319; cv=fail; b=Evxu50phKMUq7pXSNSnPOnUQTymmA1hGTni4nJJI1l5alIinFV5FaKA0TvwzmE7uPNHhueRj24bMKUynPFlP/NZ12gY2D8KWb2oGx/LLbyL5daA3PzehHjyoedtK2HPaqViwxYSnis6m9ociNeThLv+AcsKzVPYFMFyb+QDm8JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582319; c=relaxed/simple;
	bh=4J0mbeP9UoiKDzHu0Nv2pqucFJuf9Bxxa/5wKiMwm34=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KohBjMiimDbfGvOn4hUAlVOXJ/DN0CIwbKHlxuepR5YNuXsTkx57DkForrSZgNYBQeA7uJ7H/7qjow70h6YGZgne9kUuzYfWq4rYTdyoSxoGRBxCukSLQZopcn0NYjI+VJ0JMjauUwsEfBE/xwglmDibiwhnrPCNtoZzNiyek/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVhDTZZt; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJGX8gD007419
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7AwBvm9c5VMrSggCW3f+zmcHvb2XX7poD6hFc0sSXsI=; b=CVhDTZZt
	3uj+1jst838HEJtcICxOt4o42DWehj5SSJj7ii4T//QI2dSNMn6Lz8e7OeC0TpM2
	qLr84fwWlrlDyK1A45ikSensuDfcbfJch6Whiz35Fhppta2NwhbHe01WtEmWasKO
	I6ozvrDCrwwUbT4DokpWc9rbMMBD5KU1YZi3+fJJ4PM11/29+7nP0wIjU+1+hh4x
	uyisAByXXN4u+PA67JxSUEzaHWJM00BfGn6nG9smyICKsbWwj02CHdJTvk9OSyDl
	m2tvtK2P3Z1VwHOJ00sqrNzrc0E/NmORut10iUIoeOrUhQou3sKvIxXdQFDb0HQA
	yy/ry4eqTQtPMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmssqgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:58:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJJvitH022986
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:58:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmssqgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 19:58:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJJuWYv021207;
	Wed, 19 Nov 2025 19:58:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmssqg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 19:58:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqCVyT+YCJExCKhjungnKn9c6yTPrnVdTLwRGFE6E51Ad7RP1P4Z1opryCBx1YsZNdYJQ3lyu4hLld+Q0DGeMDiBJN/OGv88jLekfuASWq29hudvfR2d47XCQrSwItQWhBoKsWe72AMOoc8euxx1v5ykpG/g2i+QG5IATku+21bYAKWuNX5IOO9V/6BHTDGw8LWg64lM4rqMH6lZdM1mqD/s2dhYFjg2apfqyB8PZSy8BZN2elARxDJzpYbtTAdJ3IPC4sO8Ky19RdUm4uUcDGArKbt6/Mi1GzU6Jv5qMKQFc/oYY1jbh3dHxy2ZX5OaaXoggonqVcspQHD28cgong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7CQK197n/I4q+DaVnrS9VZj6h1iYUnNqc0VaDTzfH8=;
 b=T0j7LdWHfK4jIim89mPM4UacN2hkKphe7mZiimU7r9uTjv3guvQqFwalwMDv/bXP6iLIBrrpgiNkrzTxMwgj6Io8ufwgb0BLZwBPZJOHD67QYZFbGWkmWFrDGzgpDn3X2FLUqXwimYWQL4BMvbg4WeP77ItlyN9C7f65RUPJxwvb2m/vcfKqg0yroCD9KRjknBni9Axpju3jHTs9HQ+YtLShe82ETkhU5dt1iOG7ORROeJ+hsPkAWN2gDVEgZhK0s4o2PvG1WywTB7aRrYT0YH29acNj23cpjbuSaOMeMqBt8wMESByst0ungEkV2yqAjUzUizUXPO7HDdvl1p6KbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS7PR15MB5373.namprd15.prod.outlook.com (2603:10b6:8:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 19:58:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 19:58:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz"
	<jack@suse.cz>
CC: "khalid@kernel.org" <khalid@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcWR9ty5Q5xjyqPEathwxTb1N/vbT6a3YA
Date: Wed, 19 Nov 2025 19:58:21 +0000
Message-ID: <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS7PR15MB5373:EE_
x-ms-office365-filtering-correlation-id: 23824871-9e84-4142-eccc-08de27a5fdac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0RuSDlYeXpBOHR0VDBGcytGWXNlRUZhRTlTQzNjMWtUZDVpUkxVSXZkcG5X?=
 =?utf-8?B?RVRzdE5BeVI0OHlwRmhtdGpFTUNtcHFmay9tODhXdTg0aGpaajNDSmNFc1JP?=
 =?utf-8?B?K0F2SHNSSlRsUjhtU2g0NWVLMVViZFBqSWpqS3QwQmlwSUJ1R1BwNldzMWJ1?=
 =?utf-8?B?N3l1cjBmS0tvOWxGYlRoVEMrakxXMzVlaHVYS0V4Z1B3eG9LWE01Z2FVM1Zm?=
 =?utf-8?B?SUlNTW1WWTVwOGVhREtKNmZJemkvbHJRVk01RVIzVEZ6NXZRUXdjcTZOVTds?=
 =?utf-8?B?LzNGUVRZU2twVGgra2lHcmxlck9naXdzOFV5Smd0ZnI5aUVFVjlXTHBhRXNz?=
 =?utf-8?B?dkpvTGhMOENwR0xpTkhEUFA0T08zWU8vOU04YWgveHpRdm9tc2d6MjY5QS9Y?=
 =?utf-8?B?WURKRGFiUSs2QnB6NkdnZjM5dnRML0xmNFVaRWQ5ZktwNlZ5NFJ2YTNYMVls?=
 =?utf-8?B?Mk9hcDBLVHZvbmw2R3A2b3N3RzIrYkJVRkVidFk3d3hwZkljaHpzN2d6SVg3?=
 =?utf-8?B?ZVBSMkNTVzFnNnVpWHZQUmlLL0NTaUJ4Sk1XRkxpWU85Qm4zeUVXeHBtcEtm?=
 =?utf-8?B?eExkcXVvUWd6ZjlkMnhNZDZEMGIrL2VmWkcveXhzMlZEUmdTbWlBNFBvWk5B?=
 =?utf-8?B?SjNRcHl4L2JqakMybFhuWWlIS3pGdWRHd01XS1AzUWtXM0VNbWFmRGw2eXdT?=
 =?utf-8?B?ZlNTRVRqZk1MWWZ2ZjlKQUVlVkI0VWtwT3BVRzE5clRaUTVKNG1DYSt5MWk3?=
 =?utf-8?B?MFdsNmNJbDlzOHpJZW14WGJySzl2MXlPdmlpaTRCUkNTYkdnNkY1enJheWlL?=
 =?utf-8?B?V1VteThNUmNLYWR3dmlOQzlkWDlNSDRjOW9tSlUwdzAyVDNPMjZUNUpxYzNp?=
 =?utf-8?B?ekdtWW5HN3RnbnJqdmFLWTRacGlkZGQ2dlZJcG1lcTVMc2FaMkdpRTlGeXN3?=
 =?utf-8?B?M1hGYVk1enRhdlpaRFpTRGg0eG05d1g1QUh6NG9aMmxlMTQvRlJRUzNEdUV2?=
 =?utf-8?B?YzlRT0JpZVlybzVPMDluRXJPYVU5dW5DSVl1MndaWFYyMXZLMDdKTzNQRHgw?=
 =?utf-8?B?MTFGZkRoZHhPb0FqV2pPT1FCd1prajY1SVoyd3hwY092cHhaMys5ZnpEM0VC?=
 =?utf-8?B?OTRKVk9hS2E4NzVMU0V1NVRhcG9DWlBrSkpkT0I5cWtpRGRiZUhCM2xlem1P?=
 =?utf-8?B?dThuWkxIQTEzVHZmaXhjQVFhWStSWjdVeWJ1MHR3K2I5Rmg3S0FBODdzZnp1?=
 =?utf-8?B?VlNRN255Q0tsaHEzVVQ1cUVFeXVJT3pFQzkvaGJqblZzbURYelFxT011MkVw?=
 =?utf-8?B?bDFFTTQ2OXZXV0lKdGFLM3pxeS9pamNsTWRxU204SlE5WFNId1gwSzZNVENB?=
 =?utf-8?B?UTJyVGxZeXUwb3UwbVZWVnJtSmpZR3pGamt1TUlsTkNCK2dhR1c1WmRsKzln?=
 =?utf-8?B?QllFNzdTQy9RUFlhYUZOV3RYeGsvUEVxZHplUGxXZ0MzbzdSU0YzWlFzeDdJ?=
 =?utf-8?B?aXhzWmhzZDhzeHZxMThobkpzVkVtYWJSTHBTR2JWU2NiWUxIVlJvR3RPbnc2?=
 =?utf-8?B?YStzYVBWUFlJQkJQSDdjN3JZK0FkWDFSbDZLNWpvYTZmQWNueUJhMC9sY2ho?=
 =?utf-8?B?bDVVRUlJWnFTcXdLMmh1VksvSlU5MGhncjIxRUlqY2R4cjV6TGJXczNva0ZO?=
 =?utf-8?B?Uk11R2Y0UXhreG1IZTBndkFhM0dkOVgrZlFRSk01N0FmTXhxa0l6MTEwV2d5?=
 =?utf-8?B?d1dCSlpoWWJYZXpOMVJQMEZJREFKeTVXNktkNlV0UEkxUTFFSkpsQWJ4UXAy?=
 =?utf-8?B?WEJ0RHNObEhNT29PaFptS3lDWEpFUDRMZWdJWksxbU56T0xuVVBHd2owZ3ZZ?=
 =?utf-8?B?TnlPK0hIS1h1STllNkpaSUptck5rSHZqMEYzbXRwZy9lNmcxZTVQNzJ3NWJu?=
 =?utf-8?B?a1FtYmFHcWhkSkZ5RkhaUmFtNlZobzlZdVZWVEZHY2hTeFkyT2dYZ1MwZ0Rh?=
 =?utf-8?B?TmZYK3dlejJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2t4Z3dQUGJxaWNJbHdSZkNhWWY0R1hZcHQ0UlNsQy81UlpEenN5UXVZZG5r?=
 =?utf-8?B?YjNnUmlqNzNFc1JsNTI5VWkwSnhaZGtYL2F2MnpuT2QvUGdha0VIWFhEc1E0?=
 =?utf-8?B?VklBUkl1Rm5DT1JWcHRWbjJhMktHMWRxdEtydHZOaXY3L1RCajJydk10ZEpo?=
 =?utf-8?B?NXR5c3BmYk40ZjZDbW05Nnd6YW1DWmlURm9RKzRQc2VDL0VFdHQ2Y1ROTFdI?=
 =?utf-8?B?LzJlMlJtTnp1cmtDTXhYTm5WUVlkZXhCWHRESEtQaUh2T3BsMnl5NCtDS0ZF?=
 =?utf-8?B?R0xPSnMxNTJldjREakFJVVVSTlJBcmIyL0tKK2lYMFltRmp0SGZSZ3o2L3pz?=
 =?utf-8?B?Q0ROeWg1V2JqSkdjNUlwdXUxZlhxM0hleUtXSlJIc0RUM2E3WVVLdDNjaExH?=
 =?utf-8?B?RmpDZ3BEbmd0Z3AwN1crYUhTdHI0dFFoOGdaMWVaUzR3ZWFiM2U2RzA1Nm1p?=
 =?utf-8?B?UXIyWkZpMHVrbWFqQTV1ZUNvTVlTWmFkWVg0SFdLSTBWeE5PRkp4YUE5M0g2?=
 =?utf-8?B?RzcyNzg2TVJacWR4OWV1NGtZVmFRb1NocjhjdGttR2FMaXljZytpbjZueDV6?=
 =?utf-8?B?Mm9jWnUySXFONm9OSUxCWjZ6Y2ZwUFd5QW1QeUlsdzFUZW5NaDlwY0hoQksr?=
 =?utf-8?B?VnRUNEdSMGFZMVJheUR3SG0rZWJYSFJQMGcxNE5XcGRMMVlySFBzZDdXNXpF?=
 =?utf-8?B?SWJ6QVBKOEFxVnZ2eWlmQzI4NW10UUhXUzl4RVNQbXJka0lCcEFNSHM3Y0Fr?=
 =?utf-8?B?WDAwSHg2K2lhWWVnbFFLZEZrdXBPTU5zb3F0cGtrNzFQWm5QQmFTamI3OHcx?=
 =?utf-8?B?MGNmK21FeDl5dzlKTXdFanBycjcvbTNrL0JRakpiY3pJLzVORkNER1lMZ3Vh?=
 =?utf-8?B?ZUZrRWZBMVZyWmNGaEdYd3hOWDl1UEV1aUNWdTZNS25YS0lML3ZvUFZvRlk2?=
 =?utf-8?B?Y1labHRCY0twcG91d3pVbEpQd1lvZ0FaV01TNGZTS3ppbUJpNlJzTjBHaDJK?=
 =?utf-8?B?cHY5eDlLYkhRSDE5UzhLVUhUUVIyeTl0QTkxOFZyYUdtVGJaQWhSRUFNZ1Zt?=
 =?utf-8?B?VTJIRlJ3dHh5LzM1bHlNd25CWDhZWW5EYTU1OXNrSjk4TnQ4U2pCSGNBQ0JR?=
 =?utf-8?B?WDNhZllOYlZNNXREeGovWmhocEZoNFFzR05qT3FsZldDM01UWE1HcGdQQi9y?=
 =?utf-8?B?L0x0RE9mVVg4OWVDUUlabDhtRWw3cC84SCsyWWZUdnRvU2YzWG9RMmY1eXpD?=
 =?utf-8?B?VDc5Y3VDYmJGZmkwc0RWd2pRNGtlY1FyanlPWGpmWFgrdE5RdmFYTDRYVVRN?=
 =?utf-8?B?TXVXdyt5a1pKdEk1YWRsZFp6a0dIVlFERVdzVUF5ejNyaHRsSkd4QzNkai95?=
 =?utf-8?B?VXUzYThKS2tva3hTRFV4b216VzdXZkd2NlR3eW83bUFQY2Nma3Jabm9jMFFq?=
 =?utf-8?B?K1RuZkx0dGxhNm5SY2ZZR3BUc21GZkNLY3Y4YnluUmUzU2t2TjFsVHR0eU9G?=
 =?utf-8?B?QkFjVC9lODhodGsvRkZKSWtEaXJiQ3NXd3lMbDBrZ3dFQ0VFNTh4ZEtDVEZX?=
 =?utf-8?B?dHpEMmQxb3lWVFFxcHpZbWRPVGhUa1pBbTlDOXFFNExySzMzOUh0M2xKOWpK?=
 =?utf-8?B?YmhOTDZnMFlvZW5LQk5wSFRaeFBTSndTU3hSanB5bTFURWI5QWFCRkRzeTR1?=
 =?utf-8?B?WlZyUjIvSEp3SkZoQkhJVXp0VHlRZGtXeWhlYTJMckEvTkdOS0hzQ3Rkd0dO?=
 =?utf-8?B?T1R4YjlIL2d2MVhZQ0hFTmFHTE1HaytvVHpNL3hSeXRnbXljQWFrQzUremMv?=
 =?utf-8?B?dTNxU0ZuUWo3VGhZY3BiY0VtVVlNRHV1dXFVbGdWWHVjNWZpdU9LSjlWSmZi?=
 =?utf-8?B?cmc5R2VuMXZSb28rYzlPdjBYMGMydDNSVDRNOUlvamhoL1RGYW13T0o1OVFh?=
 =?utf-8?B?Ym5jR2JxeldkY29JTzVDSExZYytoK0tCcjIwdnczQ3MyWm0rSHNYVlFHT292?=
 =?utf-8?B?K3RCSXRZSnNCczJOWlFuVm15UVJmV1FuWDFJeVhEYndvZS9yMGRFemJST1Jm?=
 =?utf-8?B?S3BnTVEyRXRKVWN1RXcxQ043RUJSWTArUGlKRTVQKzRWNWJZU1dVaS9qZWlE?=
 =?utf-8?B?N0JMYUVuMFpsbGFYb3d3RjJyN3g1c3FEb3VocS9sN3liazYxWWV0UzltcDRR?=
 =?utf-8?Q?ZhVD2BvLhdMFlxhOmfhjdzk=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23824871-9e84-4142-eccc-08de27a5fdac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 19:58:21.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H318SKuFnEIY8o7j+W6xDXiLMMBmO0rIGMnVoOXcEcLmwMzkxLNAGnf8yIF15YjJ3N8p2eLhzx4gznME7jw/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5373
X-Proofpoint-ORIG-GUID: A_Xpjq83uWZ0jjbibCo8iwxUxfW8J_V6
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691e2169 cx=c_pps
 a=guboMCJq5DUNhCsQxgR9jQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=drOt6m5kAAAA:8 a=DF6y-yaMG2C3zxs3KisA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: -W3V6IYQlGq0f1Y9WzNgwsUso5TDikmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX9Nb5pQaUrym7
 dA2nD1tum9thU4myDUFY5gdwlNVA1IbNCANhv3rg4/djPphxmjcG9Zp3ltZAXqrawuRvI1m50fw
 A4NBsIMdbDvdCIFqVwHdle1ME0d3Dz3KZHKtch8KKeZjKrfVf+AvVF5Eff8oD4NmyT2B+X/LKt8
 0lfHZI/TFxky4dG4kZU/B66fDalzXVxBaVhgueRn78oGY9WLXBB4IbIwmSIyJ1OyXfmYGlz5Hcp
 7yNYhWNdcMu80vd4Vt54Pvh62a6/y9Er7Ta2hzTRT+Br8zrdORglGibTSLJwOBHqTYv05pcRwNz
 Wt1Gqm7F+radiPOMw3H7Hp6aNnjGG3/6JXVHmxX0WqFWLhUNvZB1CWLC5V1JAMJoOcWgxKc4jMJ
 hJd5NMxof6eT/eVsFmwnfC6RTo7Ueg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B379FEEC37B640894A214F2211E73D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511150032

On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> The regression introduced by commit aca740cecbe5 ("fs: open block device
> after superblock creation") allows setup_bdev_super() to fail after a new
> superblock has been allocated by sget_fc(), but before hfs_fill_super()
> takes ownership of the filesystem-specific s_fs_info data.
>=20
> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
> unreleased.The default kill_block_super() teardown also does not free=20
> HFS-specific resources, resulting in a memory leak on early mount failure.
>=20
> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
> hfs_kill_sb() implementation. This ensures that both normal unmount and
> early teardown paths (including setup_bdev_super() failure) correctly
> release HFS metadata.
>=20
> This also preserves the intended layering: generic_shutdown_super()
> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
> afterwards.
>=20
> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7df6 =20
> Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> ChangeLog:
>=20
> Changes from v1:
>=20
> -Changed the patch direction to focus on hfs changes specifically as=20
> suggested by al viro
>=20
> Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhe=
lifa@gmail.com/ =20
>=20
> Note:This patch might need some more testing as I only did run selftests=
=20
> with no regression, check dmesg output for no regression, run reproducer=
=20
> with no bug and test it with syzbot as well.

Have you run xfstests for the patch? Unfortunately, we have multiple xfstes=
ts
failures for HFS now. And you can check the list of known issues here [1]. =
The
main point of such run of xfstests is to check that maybe some issue(s) cou=
ld be
fixed by the patch. And, more important that you don't introduce new issues=
. ;)

>=20
>  fs/hfs/super.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..06e1c25e47dc 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
>  {
>  	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
>  	hfs_mdb_close(sb);
> -	/* release the MDB's resources */
> -	hfs_mdb_put(sb);
>  }
> =20
>  static void flush_mdb(struct work_struct *work)
> @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  bail_no_root:
>  	pr_err("get root inode failed\n");
>  bail:
> -	hfs_mdb_put(sb);
>  	return res;
>  }
> =20
> @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *f=
c)
>  	return 0;
>  }
> =20
> +static void hfs_kill_sb(struct super_block *sb)
> +{
> +	generic_shutdown_super(sb);
> +	hfs_mdb_put(sb);
> +	if (sb->s_bdev) {
> +		sync_blockdev(sb->s_bdev);
> +		bdev_fput(sb->s_bdev_file);
> +	}
> +
> +}
> +
>  static struct file_system_type hfs_fs_type =3D {
>  	.owner		=3D THIS_MODULE,
>  	.name		=3D "hfs",
> -	.kill_sb	=3D kill_block_super,

It looks like we have the same issue for the case of HFS+ [2]. Could you pl=
ease
double check that HFS+ should be fixed too?

Thanks,
Slava.

> +	.kill_sb	=3D hfs_kill_sb,
>  	.fs_flags	=3D FS_REQUIRES_DEV,
>  	.init_fs_context =3D hfs_init_fs_context,
>  };

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues
[2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfsplus/super.c#L6=
94

