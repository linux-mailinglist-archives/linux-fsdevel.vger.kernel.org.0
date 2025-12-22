Return-Path: <linux-fsdevel+bounces-71838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1CCD7141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E094301E927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71130BF62;
	Mon, 22 Dec 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WVPtq2sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E32F3C22
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435319; cv=fail; b=kC95VFxqS45NQZN6cUAFQY79qvwkifb1k91U1X988Cb0AbAIj/SEP26T8cT993wPT27Ho/6jCiybAfyM85nJv7F6fIex8ekrME/nUtCi6L7tST8HtYqB93otRuAL7CgqU6b6APxRK45Jzq9T7+WTytWp9sd+ppIr50+KiALRxps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435319; c=relaxed/simple;
	bh=WwC3xSlqzVQbUfMJzqlUfGJN+n5ehrjQZs3g15YOMHQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=EqpqtcBdL2XH6l8XNU+wgBg0zKkPJLKBPx9avXwWl80XUOd8oY9nO5iLtq7PVi+mWCmGrFQpF4zEuF/m1lGlRE2Dl1KDGv5WrJ9Eoo6nrGRb6sDRZzuP1O0IxigpWezkPWTo0+YWBJkbNljuxCzcjqNNlZMZRc3SGcTfiHCUh9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WVPtq2sd; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM8qpU6013384
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=5DxGKhV3HKXdPo3xaJ9SrK7f25AomtWKkUNlKhVmtFA=; b=WVPtq2sd
	GDgs/zZaXjiCTtuWUQNWYxhxHNzkfcuXwtyTyzewLu3CNEktBK+/YMSFKyZW0hCo
	+/ADCGzlICRlxl02ot9lp3b4o/7cylmA7Ci+ylszBYW5ZNgOQTihbFkCZxVQ57P8
	XjJ/RdhT66eIcqfdEESXqvs/32irT0NufcbAjBVvn8Q3ad+P5IDigQxYZalonVnI
	T+d9X6vIe02oSV5l7xd5ams2ROu9GNbedPnEUzoB3m4V2fOKeHhgaj3a37URMO+Q
	aE0rSggN1RjanOmcMIgtLa5u+bD8KrMrVWwtblyTrowEekhL4HZMOjwdQoNA8Bvp
	vYDM1DKqbJDUlQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka3a30g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:28:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMKSanq020520
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 20:28:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka3a30a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:28:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMKRZFh017875;
	Mon, 22 Dec 2025 20:28:35 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka3a305-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:28:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfpPXMr5VNr5ZmkTEOKhVeeIvy8y4ktWqeFwWOBANv6ZQtqsSWPNTNucbX+1SDyS8mtmXfAuIKXvUz9+UUZ5Zy/zkYLZGstsYhAwQ1zv7FC76jlRf9wPyvw23glSMNsje30o0yKFtzJERbIgqYvpPA4GnXWj+Wqjf4ACxBj/BIMJJZ9uMjAXGmVLA5RxVkDMm6A1B8asOXJZYtLBAzWVPZ4fZWjAtZsBE2y5Twd7s7rtTdtgm0o0uBmXf9Plz8ZS2z+ZMaCSLyAwJey9qiUW5/vXTAR2iBp3bF27nV731ZiwDHhOZvgOfeHBPmGwZSVtzKtk03Rl0oO1e5UN76u/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbKwt+Gie+picmeY+o7U2suPzp5HMuUOYrm8xav6gZk=;
 b=zWvrkwZgwS6+xqRlHVR3k4b9ip8/UbKdpEfCZgIrU8pBKh0Yz0CiuKP64bap8+/kqqTGFDOtvSIfax7QtueFJuxEYAUQddzM/TvtYtX7WkUtM/L4oElD299fqA9VeDckDY3SUuSoRECtcNe8ZtmsdHjBDF3EJoBLXeLj8OMFtZr17ShLIyJ1iWPBaO5JFud4Epw17Nufc6Cy3Nj6aibbX7EXbsBZpXMR+vChBbLqJ0BmOWQ4pdUKdv8NU61O7KkiLQxtP4TlnVtof2n41ulOZI+9rM2L/H1uVCVUnxAPYD+NUhX+fNV7XXYjLy2olPcV2kRPTjDk71PIdehu1t7vJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5503.namprd15.prod.outlook.com (2603:10b6:8:bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 20:28:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 20:28:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Patrick Donnelly <pdonnell@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index:
 AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAP6yAIAAZyuAgAFGR4CAADd8AIAEfJMA
Date: Mon, 22 Dec 2025 20:28:30 +0000
Message-ID: <dce8ca6d1d25e12c8365ca2302697c1763c4b6aa.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
	 <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com>
	 <CA+2bHPaxwf5iVo5N9HgOeCQtVTL8+LrHN_=K3EB-z+jujdGbuQ@mail.gmail.com>
	 <87994d8c04ecb211005c0ad63f63e750b41070bd.camel@ibm.com>
	 <CA+2bHPZjUqwPfGiCMLkktszx+E2iatE80O0FHk4pr=K08GJH8g@mail.gmail.com>
In-Reply-To:
 <CA+2bHPZjUqwPfGiCMLkktszx+E2iatE80O0FHk4pr=K08GJH8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5503:EE_
x-ms-office365-filtering-correlation-id: 8063252f-2fb6-44f5-9c9c-08de4198abd3
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjE3QVNPTW52VkZVS0YrN2hWZTBUeUNxZ2dmWXhkYXBiVE41QXZYRDNmRzAw?=
 =?utf-8?B?YWpUSTUzWStMd2Jvb244azRUcTI4Z01xdEllTHJBT3lQZm5kOGwxVVNBMVN4?=
 =?utf-8?B?V2hKbm10OTI0VUFUdXJUTUYyQStIbnpFUFhoMzRESFNkSHRoYW5xZVVWaHVj?=
 =?utf-8?B?TmtrLzIvdUxyaHR1V2J6WUdTL0NJKy82U1k4YUt2clBkdVZ6TFRUTjBrSUxD?=
 =?utf-8?B?VlFmSW5jNWlNMmlaYS9tUE1Dd0ZUNHVvMFpaU21IVEtiTUVWaXlxRUJycXB3?=
 =?utf-8?B?N2VCT0RsRmxlbUtiSFNnWnFRVW5abFNyOGJkemlCeFUrVHpwSWJkSG1YdVoy?=
 =?utf-8?B?U3A3eTR0ZEFQWFh4UVZURWpMbmlTS05RY3gxL2w0VlIzdVRtQjBKNFl1VElK?=
 =?utf-8?B?RTEwVUtXeVA0WEJvWGViTzY0YUpRVGdKNzQ3STlaM242dWliSDRJemRWZHg4?=
 =?utf-8?B?Y2ZpeU9rUC8vcHNnT25hNzlBRFhUcitrai93UmxtWkMxVWZ4WHc4U1FFaURk?=
 =?utf-8?B?TmhhVTVHYVJxcWluYjVzaGNzdVp1azcvZ2tLM3Y3NEZuSmozRzVEWTlZVDVt?=
 =?utf-8?B?TkI2SlcxSnVNaDRKWWJ5WEZGdDltZGRUVTFMbzVpcDJMUHVPT2huOGlnTkxJ?=
 =?utf-8?B?NFlWZVppMERaQkFyaVNoZFZ1OWo2YkZJYjZKTnpwS1hDVkpzcmswTUQwSFNo?=
 =?utf-8?B?ZmtrczVtTW1Sa2srVnAwTll5Rk5TN05seklHZUhCeUg0TTc5Rzg0OGpzMWJH?=
 =?utf-8?B?TkppSUJxcmZDRnFqWERVQXdiOXFPdE9aNU1vYmRvMnAzZ3EyQ1VBbFBRNHFC?=
 =?utf-8?B?OGR1Q3pEOGpGeDd3ZFhKZXludE15aHdtK3BCakcvTVNGQnJTMi9lQTBxQVgv?=
 =?utf-8?B?RllacEJOYnpGaFNvMFVPdGlSSjdrNEpKNzNGVFkyUDQxTCtVOUdoOWVlN0g4?=
 =?utf-8?B?UjIvOHdSU1EvR0xKckh6UnNkTzNqcG9oSFhjYVBlYW5sdzB3KzY2OTJZaEVN?=
 =?utf-8?B?c1lVai84V0ozbmdWU29ZWXl1ejhLa0RPZW5hMXp1QUJQcm05WnBiTDlHeExn?=
 =?utf-8?B?cjRCRGZnd3Fpa1RTdkVpVGJFd0g1cnRWNE00SE1SbGo1cmEzdytsZDh0bzh3?=
 =?utf-8?B?Y1E1MXhWRktOWmQ2US84emRUUlg3aE5XSG9KY1RmUGNSbFdFT2d3QUs2K1h2?=
 =?utf-8?B?eEU0dkEzTWpmd3E2MjR4Q2Rna09VVkN5ckJTa0YzY0ZzVm5ieGtCK2Q4UU5W?=
 =?utf-8?B?S3VDaldVOTVjdWtNV3crSGh2MlpreGVDV3U4dEVFSFJENXdqWWFDdThOQzJ0?=
 =?utf-8?B?cG8rZ3BuV1dTQW9vTXZqaVhGMGpxSkxkd1V1Z1ljODZxYTIwUkhVd2tLTHBM?=
 =?utf-8?B?bWRQT3dsenFRR0NQbUVscnZKTzMzK05SZU9BZi9tdnVEaUMwWUx1akpaZm9v?=
 =?utf-8?B?TkpUYWx3eUgzeEtKTVFWZkh1SC9TQXgxcmtlUW1EdXNPYXp6TG5KUGcrdE92?=
 =?utf-8?B?UmtsN0gxYTgwSVZQeE55b2ZneXdNTC9Wd1NsRTZnRVljWGtMd0JEZlV3aXoz?=
 =?utf-8?B?REN1RFNvR213YWtULzF4SUh4MUFtMWJuNUVxRHFyY1JxbEE5UjRacE5XeHhl?=
 =?utf-8?B?TEVOcDhpQXFLTEsrdkh1cFhDS3ZTZnpvTnQ4SXFLaVRJK2tYNkl3d3BNYWE0?=
 =?utf-8?B?YVozWE5uaTRNblM1ODNQK2ttK3RaMlA1d0ZUa2pxY3Z0TFFKVndyNHlkdndC?=
 =?utf-8?B?OE45TWNvYWlFUzVkUDkxUFJDT295SDNQRzRpYXlrell4MUpZQnBSQzlheUhS?=
 =?utf-8?B?KytGTFUzbVQ3WXhXVlVYVFRSbGg5SmpwQ0Z2OFJnL05SRnlqU0J0cUVpTHJH?=
 =?utf-8?B?T3BRQnp0ZjVwcUFpSW1KaHk4c0lMemwyVTl5L0dVYmY4QTZWVkhKdjFXTU9q?=
 =?utf-8?B?bzBkc0dTazZVN2tPS0dQTDFWREhIYlFONXNxUGJlN1cxV2kxbFh0U3FheTJ2?=
 =?utf-8?B?akliSHVmbzVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2NsSmhvd3ZCbFA3a1hPTzNrcFNodUlmZlVFT1Raa2llMXBLTDlSdXVkazhn?=
 =?utf-8?B?OHlmbm1JMUs2dk56cGFpdmxkWTRUZDNkNE92TDlwK2NwOXl6MkgvVWV2NXBF?=
 =?utf-8?B?Z0ZyMGJ4Y3hKeUt4S1BOb3hXdE50NDhzZFAzeTFnTUNFL1NoQmNMeWdlZXpP?=
 =?utf-8?B?N0pwYzlvTElmSlp0eXRjellQS1pGaGhTMG41YWxWTTgvZ0dmQkhUZjM4a0lv?=
 =?utf-8?B?bGtzWXZxVEZJMEZacmx3MnpLMk9JZU5aNS9Jc0t2UDBoaDFaTVovMTRBVkNm?=
 =?utf-8?B?djIrWEtkZXorc2FUMTF4SjRsVnRyUXFyYlpJNVFCRXhvdThra0liaGlVWXJz?=
 =?utf-8?B?OXV0RHhrYmwyTndxeWhOenI0NWFWajh6YmhXdlpqWnZXMEpOd09RWHZIQjVV?=
 =?utf-8?B?WUYwU3pXTnlRdFU3V05JbGJwOStycVQ3VmFlQ0k3a0hWQVJFczVXd2kybGoy?=
 =?utf-8?B?bCtGQXJHYzQ2Y0RzOGt0WXZaQkFVWTlJVkE2bzk1Rm16NkM1M0dBRzk5Tm9T?=
 =?utf-8?B?dXZjY2UyNHByMHFkVURUS0QzZ0Z1bElEUit1clpucFZsdnBtS1FlOG9kcVo4?=
 =?utf-8?B?VFEvb1c2aXRIOVRuZ25jaWRTbGE1UUF1UHhHengrRnU1YVYyV0NJQXIwUTJt?=
 =?utf-8?B?d2tGZ0lDT1VqOHc2U0dHVGdaSVpoSFdtcStxY0xnZFFMSm0vV2Q5K2picm1D?=
 =?utf-8?B?S1VRNG9sL2xZUGlMRVZLbEh3Z0Z2ak1GanI1cHVHYm11Z3hOOWVYdEFJS25q?=
 =?utf-8?B?cmpPaFV4UW5WVFhEQTRsc1ZRZ1ZXbUNobWJyNFRJeUpOTkNCSmpxRk13WlZZ?=
 =?utf-8?B?TmVpYXhOYVpiUVI4YjJXeHdHamdPWWs2ekY1WU1ocjBLSkdvTW80RGlWaHRT?=
 =?utf-8?B?d3VHeEJUNUhVd1JOcmo1cnZ4Y2kxUUtQWjdEZDVkS3dCU1hMZ1Nrd1JERmJo?=
 =?utf-8?B?YU1Obm10UGp5ZFhBa0JkbmhVMHBFY3JkYjJwVFFPYmhjNHJYZ2RtSXp5cisz?=
 =?utf-8?B?b0ppWXlGQ0UyOEhmZURpTUZXSU1hbHRLbUdQQm1HWUR3YkoxbVkzREV3bmxB?=
 =?utf-8?B?SlcyaGpBNUgvZW9VQkQrSjZMNTdnbmFjVkZDbzU3S1E2VFlaMWdMRmlJVWtW?=
 =?utf-8?B?K2tEbGtmRUhvZlJvbVJ2TjBEN0EvTmVtS1ZLT0t4V2VnWVQrSjI1enhsMFp6?=
 =?utf-8?B?TVBNZkc3V3ZBMVhCZDRBUGNJVFdLTUc2QWloUGdEdUlEbnk5UHM4ZnU3aXlk?=
 =?utf-8?B?QTlYelliV2tyTCtEL2J2N1VwWTcrMG9ZalovR2ZkR1cyUXdVSHMrS25ZajZL?=
 =?utf-8?B?ZVZweHdCN1Bqejh2bzFWbnVrcmxwWTdPNlNTUWpRZ0JXMTl1VzZGS0RuamJ3?=
 =?utf-8?B?dmlYZVB5V3QrMTJkR0JQRFBCTER2aDhPWnVxaTRUYjIxTlBNdnpyT1BiczBq?=
 =?utf-8?B?V1ZoeTVqa05LUmZZS01lNDJmQVI1ZmxWeStYL1pSYnVyT2dveUJqbDBmNFVF?=
 =?utf-8?B?WEZsYjgwa25yckpoTDJBaGJjY0tNcVM0bzFuaXdVTWlNdnR1cW1PVzh1WWZw?=
 =?utf-8?B?ZGl0TjhPOWpscXlTZFRGWmdpckYzWW5ualFIaytlZnZrM0dOaHhoQzhCb0lP?=
 =?utf-8?B?WmZwUVRQTTJ6eHo4WGN6K0srTWRFcFBKNzBzV1MxQ0NKWlZwQWtiTVNGYlB2?=
 =?utf-8?B?ZHRYbURYRVVVcUNzd3o1T3U2MEJQcUpYd2w0OFoxeFZyT1A3OVdsK3dZcnNu?=
 =?utf-8?B?MlF0K1FCcTMxMHloWXdydVpIejRGZ2YwWThLWEcyVW5oVm1BdFh6UjZ1Z1ZC?=
 =?utf-8?B?Z0ZSRmlvYzJGRDVESy9mNFI2NnF3QUJ1Ti9KQklNdWYzSDREdS9QRUdDY2ZY?=
 =?utf-8?B?eUtjZUZMd3F0VEl2TnJhTUxBN0prdktUUWJQZ04vdVBNdWdvQ3lkUVhBemU1?=
 =?utf-8?B?ZFZ3VnNDK0F5Mm9GSDhidUl1L1Q2dUZsMUVwdVBYQ0JLTUR5Y2RENVltU1Rj?=
 =?utf-8?B?Y2dXdmsvaTg0TGExWTc0NUUwRXYrZDl1RjFnVGdOTUdaZFJiYXJieFNGYUFI?=
 =?utf-8?B?aFJLQTJqWmZVeWFYcHJzUW01THp4Yk9tMFFnYU9MNXkyZjI0MkM2Z2lQeUJU?=
 =?utf-8?B?WngrR3BWcUtJc1ZJTmF2aDk1N2x5QnpxTGx5WmpKUG5VaFBZakI1Z25keURu?=
 =?utf-8?B?dGlyVmlPNCtZNWMzUjFLQ0FmVkdXQUhhcDFObkc4dmU0bkg3VkhITGROb2dm?=
 =?utf-8?B?MzRpQ0RMelJjdVJucmRiWGU4YzNIS1JzbDh6YXZkMkZhdFZ6VFVaR0lWdzho?=
 =?utf-8?B?M0NScU5renBZZnlTTlFnRVd2SG1vMG1ZWDFyaGRQWnFxVWdFS2N6TTVMVGcy?=
 =?utf-8?Q?zbi8oPrwG6n1rxrlWhVsG9yNLMHUaUin3RDHq?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8063252f-2fb6-44f5-9c9c-08de4198abd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 20:28:30.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZWsMZ3ZhmKkMl14R+H9dgbniGZ8MFacNlzxNhPdi2Q8VO+GbhtUIhxkLe5c7GEZKpd4slJEM/FRnbveN76BSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5503
X-Proofpoint-GUID: WTOBw9PspvnI2xSX-nTmUMI1rhIquKbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE4NiBTYWx0ZWRfX18U2m+dAEFcB
 Fdet21wqqg5yOwdHNl+UMly2Rz0p/6a3ywQ49fZE0MA4WNoi7nl5BsBkfQzqzyYlMZlbfAT6NdS
 ShqPKoJ5H238CK1iqWyelEN9n6xDyI/wlYTem2+W4TWlRAuZKNKRW+bJ9waaqGckWMJMwn9Fl7/
 8fIvB0muGLKKJntq7qQ0k0AadZRKBtKHq2UzvygcFhP7C68kscaVNGW127HiXaHsfj9hWFFmjuZ
 DET6y8LkCs/+I5+DuBcj74MoLqpwVcV6/aHm7r7G09j69PB7KXc8PucoVRcmn+X2Zhc8WM8nadU
 S5ZERti0B2gg4fZI5YAxk86LjAvtZsfEmgoWdk75lXdNuRrtj71lVdX8nCxY7OmelE/sFZz+gb0
 suihKh+7hOTOv4i8t9mQQoTA0H0VrZMQlQI9EvH6uGwkN8+lr3n/YVQ9aV3zXfLAp3YxrPD6SyZ
 9YtT5BK/b+LiQusyDhw==
X-Proofpoint-ORIG-GUID: fTTxBsbjMN1XG_qPGufr7so3lDwYQQmA
X-Authority-Analysis: v=2.4 cv=dqHWylg4 c=1 sm=1 tr=0 ts=6949a9f4 cx=c_pps
 a=eQn4vQZDn50HuGbH8T6KOA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=A2VhLGvBAAAA:20
 a=4u6H09k7AAAA:8 a=VnNF1IyMAAAA:8 a=0YJr3vf45kOuuNllAs8A:9 a=QEXdDO2ut3YA:10
 a=5yerskEF2kbSkDMynNst:22 a=bA3UWDv6hWIuX7UZL3qL:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AF3192BFFFE54F8456C081C7A6E2C4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2512120000
 definitions=main-2512220186

On Fri, 2025-12-19 at 18:57 -0500, Patrick Donnelly wrote:
> On Fri, Dec 19, 2025 at 3:39=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > On Thu, 2025-12-18 at 20:11 -0500, Patrick Donnelly wrote:
> > > On Thu, Dec 18, 2025 at 2:02=E2=80=AFPM Viacheslav Dubeyko
> > > <Slava.Dubeyko@ibm.com> wrote:
> > > >=20
> > > > On Wed, 2025-12-17 at 22:50 -0500, Patrick Donnelly wrote:
> > > > > On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
> > > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > > >=20
> > > > > > On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > > > > > > Hi Slava,
> > > > > > >=20
> > > > > > > A few things:
> > > > > > >=20
> > > > > > > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
> > > > > >=20
> > > > > > Yeah, sure :) My bad.
> > > > > >=20
> > > > > > > * The comment "name for "old" CephFS file systems," appears t=
wice.
> > > > > > > Probably only necessary in the header.
> > > > > >=20
> > > > > > Makes sense.
> > > > > >=20
> > > > > > > * You also need to update ceph_mds_auth_match to call
> > > > > > > namespace_equals.
> > > > > > >=20
> > > > > >=20
> > > > > > Do you mean this code [1]?
> > > > >=20
> > > > > Yes, that's it.
> > > > >=20
> > > > > > >  Suggest documenting (in the man page) that
> > > > > > > mds_namespace mntopt can be "*" now.
> > > > > > >=20
> > > > > >=20
> > > > > > Agreed. Which man page do you mean? Because 'man mount' contain=
s no info about
> > > > > > Ceph. And it is my worry that we have nothing there. We should =
do something
> > > > > > about it. Do I miss something here?
> > > > >=20
> > > > > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50ae=
cf1b0c41e/doc/man/8/mount.ceph.rst =20
> > > > >=20
> > > > > ^ that file. (There may be others but I think that's the main one
> > > > > users look at.)
> > > >=20
> > > > So, should we consider to add CephFS mount options' details into
> > > > man page for generic mount command?
> > >=20
> > > For the generic mount command? No, only in mount.ceph(8).
> > >=20
> >=20
> > I meant that, currently, we have no information about CephFS mount opti=
ons in
> > man page for generic mount command. From my point of view, it makes sen=
se to
> > have some explanation of CephFS mount options there. So, I see the poin=
t to send
> > a patch for adding the explanation of CephFS mount options into man pag=
e of
> > generic mount command. As a result, we will have brief information in m=
an page
> > for generic mount command and detailed explanation in mount.ceph(8). Ho=
w do you
> > feel about it?
>=20
> I didn't realize that the mount(8) manpage had FS specific options.
> That would be good to add, certainly. I would also recommend pointing
> out in that same man page that mount.ceph has some user-friendly
> helpers (like pulling information out of the ceph.conf) so we
> recommend using it routinely.

OK. Sounds good. Let me create a ticket in https://tracker.ceph.com for this
task.

Thanks,
Slava.

