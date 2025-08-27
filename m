Return-Path: <linux-fsdevel+bounces-59336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE381B3786F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F67516AAEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A628306D35;
	Wed, 27 Aug 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CPHhue3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFD19DF6A;
	Wed, 27 Aug 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264028; cv=fail; b=s5bSa83QJTMt2peCOGe5F5Jv7n/D8sCF/yy/4ezuQJzxM7L0Rau0siF6UDD3i0h3t4oI7tro4CSNXBCZt5NrEQnE/x7AT97dXF8m10B30YvQfYu1W8wWRJQPzdbKlVZ6D0292p0J5BlUSIGmajLPfoZf4z+t2hOZncQQeOl13lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264028; c=relaxed/simple;
	bh=Sok38emu2b6biv8m/YeGEtvnZr8gAjaI2RrP/Awv6Wo=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iF4Exb+9h/QHGtaqcrm9de6QkqkUp4mnNK10+4BOXZQn+pij00cedYonUa9wuoGu8atX2Mz7csn/szXl+hAgVxxU+UnZqoRRgG4lrUolIfKiGbt0bvG49LyZYbdj2DsKU4FEv9/9ekG+Uk/DWcUxc8jCqa1mEkwSNKsH/EaE2v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CPHhue3G; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QML3Yb010495;
	Wed, 27 Aug 2025 03:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Sok38emu2b6biv8m/YeGEtvnZr8gAjaI2RrP/Awv6Wo=; b=CPHhue3G
	LQ4E4veDggoCXuXwnre43qquBgBUaK4rUxXSFz8QaRd9C2z+AR0oRuMb1KYQ1cVP
	MC5vpiAbnTHzWDHJfNNvwsBq405bYmH3yu7ImQwwMpN1khchkVn05Sgbx0uTC06o
	FuHcn8SxwbsTMHD/8/XF+2IzmaYCO+YcK62otQMQGUnbtTTT1FE5XDxPjxz6QiiT
	pTXWc4h/ftuJe0O9g/+QUhivDHxV71U9ZJn862j6hYUQsXwS6xs5/5rnjVo+rzg+
	k+wRBbBGacb0tdcAP+h5WgiOG5TEfDqkKghpVB007xrYx7+Z7gaJMOvj1BtHXCH8
	0C/VMKKRM8jO8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvw1dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 03:06:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57R35NJP021616;
	Wed, 27 Aug 2025 03:06:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvw1ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 03:06:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXYKeVjl43T6ohI2Jf644ysrGUSLhGY+KP2ElN/n7PrCLpQTPoc+MEjd723lFM9nrihoU4J5cX27on2WMzlX/LoGx5d0e+nqQ86/Iy+0iwi8RKIFF8ko8ciY+NY8U+AligVmDDImk54XS3tQukw1hmljexu5HMmrxx0EUgq21hM06BmZZzJUsExEXbbQkAWQxAlsE6j4EwzrDHkOiQL3V+LMgjLhAne00e3QlDFYFEzp0NJvQIVjRUkKbjF14O0fD+8MvTHbME5yYirHZ6wsHsesDptow2DCc57lA/ozy0rrtg2TMn7JaOAuI9GUp9WPJLRef4Mp7DeMbX9UF0YHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sok38emu2b6biv8m/YeGEtvnZr8gAjaI2RrP/Awv6Wo=;
 b=sOqxwxcYY+u+6QJndnLositxltxd2GsHHFIJ1PB3mv3j4dbBLDQImZGM0tydNqpk+pupdts01aKYj/EJlciH7+rRrAFdtWrwNx22rUVFvEiG9GrS1vfVAhJww73OujNr7qSvprQzWlmmDanlKnwBAg3yV7s52dZv2encz1ZhNsx38LsxyDNFl/q2/n0P8M5+kO+CkM2tNWlRYKyP7cKPE9hwYtJpg9B3qVXmIihF4H+U6tqzJTBb5laLvpMVmxe3YADvWHoKJL0k6pEoJ3XTLfRTQM5hCgDoJu3Buypodq5vdITkT6kSfMlOx2UM5P8xjEFqDgUISOsCgANXMZviGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF3EEE25392.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 03:06:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9031.023; Wed, 27 Aug 2025
 03:06:55 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        Patrick Donnelly <pdonnell@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 3/4] ceph: introduce
 ceph_submit_write() method
Thread-Index: AQHbfyUJV+HgPSNl2UGP49ZlSz2c/LR2rRGAgAAHm4CAAAWcgIAARrYA
Date: Wed, 27 Aug 2025 03:06:54 +0000
Message-ID: <4a75d243b3002ae8608b6e2530452924d192524f.camel@ibm.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
	 <20250205000249.123054-4-slava@dubeyko.com>
	 <Z6-xg-p_mi3I1aMq@casper.infradead.org> <aK4v548CId5GIKG1@swift.blarg.de>
	 <c2b5eafc60e753cba2f7ffe88941f10d65cefa64.camel@ibm.com>
	 <aK46_c261i65FZ2f@swift.blarg.de>
In-Reply-To: <aK46_c261i65FZ2f@swift.blarg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF3EEE25392:EE_
x-ms-office365-filtering-correlation-id: 79815a31-266d-4feb-7cb8-08dde516c726
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHF2dkdqcWkvL1NIV0hsblRNWlRvY3JPaHNXTm1DdHVYS25zbTdYcTlMMlFo?=
 =?utf-8?B?VWZzK21yMVd4VkkxbXB3bUIxNURWa2FsZUx6UVRXR3dqVCs4bEhrU0hXOUdw?=
 =?utf-8?B?K1JXZEJPcE5sS0F3bWlRaStGTWVCNy9nMmVoTElHNmFOSEQxMDhVUmdmWDZa?=
 =?utf-8?B?SHpnUTdtdXM2U3orTGxJNGE5cmdKTmRGU1RMN1hwNWVldWZnMDg3QWQ0T2F6?=
 =?utf-8?B?TkRXU2ZTSkkrZmRFRzNxaFk0UWdFcHdzWTJ2NjR3MUJvTVI0SC9FZUtRaE8z?=
 =?utf-8?B?U0E5WUZxek5uSFpOR1JCWWduQm40OEorc2pVc1JkZEpuelFKaXRuYXpqR1RF?=
 =?utf-8?B?NE95Q2plWmp0SVNEWGhFZWw5WGt6Z1p3dTBudXFINGY0MGh6a2xmNnN3c3Zl?=
 =?utf-8?B?UFZ0aWxKQ2NoYURmTklUVjZDVTkyNGkyRUhvRXdzd09wcTV5Tnc1dnJGUXJY?=
 =?utf-8?B?U1o1aDhVaUduVkJSa1AzRyswMGlEWXYxajRBeU9hd01TTUFxRmNwOTgxYkVh?=
 =?utf-8?B?RktQdUhhOWVuTVNlODZudURhRlpwM1k1VEdnV0dXaEFMOFkramdxOHhhMDJq?=
 =?utf-8?B?eTR4YVprbExGZm1rSHRrbFBCM0NTdWQzaFRZYU9VY2s2L2hrVGllczArbmU4?=
 =?utf-8?B?dUV2N09lcjI3UjdsQkNMR3QxNHprTnNXdFJtZkpOV29NWFFCZHhLdDBWaDZw?=
 =?utf-8?B?YXlFOU9Zd3pzVXJQN3BLWERheUNrazRYUENoNk0wTlR5dEVuaE9QRTRTVG9X?=
 =?utf-8?B?VjY1cjdwVFpEUGlrSVI4UTVGc251NVlhVUhiV0JrUk1ncTZFTFh1d0craWlQ?=
 =?utf-8?B?ZHlacDd0RzlWSitRU01HYkpQSXFKL3p4SDd1ZjZPbHlXWHhOcGd5SEhXQ0E3?=
 =?utf-8?B?TW82MVRvU1J0bjFBelhyZW80SmpqbGFDOUQ3bHpHOFhVelpJOGg3cmVGZk1O?=
 =?utf-8?B?ZFY3QStlSVdZeFpONkRJUVdWRUJyN3FlYklJRm4rWVF1M3BwcTk5N3hXUm1t?=
 =?utf-8?B?QW1XTWRPdkpGNUxuT054S3RCdWpxWFk5Y05MMDJ1UlF3cUpRcDg1dzUzNHFo?=
 =?utf-8?B?YjVFZ1dUQ2laN3V2VHBHWEV2NUpwU0djWTNGV2VuRzh3VWR1cjhheEJ1bHln?=
 =?utf-8?B?VlVqVWdKTElxblV5TlgxT2YwaUxna0ZVZSt0dkZIRlYvUEtpUVQvVGxVcEpB?=
 =?utf-8?B?UTBadGI4b2xaSVFKWE5mcmRoWnBnUFZZZU9KamkvN0tSak50TS9JVTMvdlk3?=
 =?utf-8?B?aXdaU2hTdEVaaFdYVFgrVEIxcHRkTUl5QVRhaGFzdi9tbDlwRm5aNTFaQ1dn?=
 =?utf-8?B?TUEzdHNKQkhVbVhOZ1VLd1Z1dzdHYjVDWmQ2dmhxejlsbnlVaDg5bVdxK2RJ?=
 =?utf-8?B?dFNwNzNxK1NrVUtzMmxnRFFhR21ZSU83b0RqaGpyK3RLK2lwUDhFbFBLenND?=
 =?utf-8?B?b3RYQ3FKdENSdkx0UDAwdnRnYkdiOFJFUDJ6clNTektPYnlqc0JEMUtHckRj?=
 =?utf-8?B?T0NHSjluaWVmaUJJRmRqVGpVRkN1NWUraVNMRCtMamxGcGp5c2l1ZkVVT09M?=
 =?utf-8?B?Q29IcW9Sak1sanlRTmExNWhvRWJnV1VsWmd6SmRMWW9IREFGbWhSTUZPUUp0?=
 =?utf-8?B?VCtKc2tHOFowVTFzMnVrY0VvWXcyMnNjRzZPa2dBbGhKdDFSU3JWZ05YeDM5?=
 =?utf-8?B?MEl5WWFrbzJESWo1WXdpZTNxaEZEbDhiZkJzaC8wTFNMK2RoaDI3b3MyVFhh?=
 =?utf-8?B?eWtKVVRBL0FreE5Vc3Exd1padFBFQTkrVHBiN0dEaE9CQnRva29xdW5SSDJV?=
 =?utf-8?B?RmlZZ2I1MFRYZlhLdFE3RFdjamxrVHVWNnMrQVhsNlpFditGcUNPUUIvbDNq?=
 =?utf-8?B?ZG51M09wRGRkTFg4SklBQXBQQ2NtbEo3UU5ReUhTRnRxMExqM0RZK01LZktO?=
 =?utf-8?B?TllrVmpzZFJoYnRuUmxqS3paWURqUlFJREtzQWs1b0ZQRE11OFhaYmZ4OU14?=
 =?utf-8?Q?l4kQCboJDlFbkpeuZI7gfn8cKIusIc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejgzb3F6aXZBUC9teGZwY0haVWJuMG92eGd3SWgzblpIRERMLzJWOFp4Wkc3?=
 =?utf-8?B?dkZ3R21heEZRTjRVazRFN2h2NFRvbHQ0V3dlUTR0Njd4V2NhYjc3Sk5Hc2Za?=
 =?utf-8?B?bUlDMkJ6SnlSWjZoZTNoQnRobkFxQ2Z0OVlBWTh5ZklwaCs4Umo3MmdPVGx2?=
 =?utf-8?B?YjlGc0FSZXZvTy9Ma0lHWndxZS9oRWlMRVVPM3FKTmtoS0xZcVZVbEIwdXk0?=
 =?utf-8?B?MjVObGI3bW5vU0FNYmltT3QyYnhDdlZKdkdXamN2WkJWQmlLbHZ0c3A0OHhz?=
 =?utf-8?B?TzZsaEU1MmhiaUVnTlE3MEZUTFNoQ3RCZFJ5N0oydmdiQkJmTWIxOG51ay9D?=
 =?utf-8?B?YWkwbGVMUXhSQ0dodW52SG1hWWRqTGswdXcrMkhjMTZia2Z5d2EzVUw0MkMw?=
 =?utf-8?B?N002UlpqYVNuWkJaNHByM2RucEs1VmJpNEl1azV4ODR5MXNvQS9LUXlnTklH?=
 =?utf-8?B?UTlLZDRydnNyT2xMMTNMNE02RjhMaGEzQjdHaGxLSGFzVmw5aHl0Ky9XY1ov?=
 =?utf-8?B?c3NVQUVuS0VzYjY0MXFSOGlqZW43bDlseGlNRkdHMHRJS1REWmlzQWQ3UHpl?=
 =?utf-8?B?a1pOaFE3U3d3OVpQbHQ0eDZLYVRWWUdpbkxMMlZjYzBteWRqZk1ZckNJUVpl?=
 =?utf-8?B?NVNMYzdDcCtpU2dzVU5ybkIvc29MSGF4N0w0OFpNOE53K2FncTR0RUc1TWNS?=
 =?utf-8?B?RmNOS3dNRTArNE1Gc0RaRnBpc3JpMkNnUWRRK2p1YmVhUHFMRGUxbXdGSkFJ?=
 =?utf-8?B?R2dPQ212V1pUSDBBOTVZK1VMeHovWEZJaXZycnFsYmQzbXcrQmk2TEVoaFJW?=
 =?utf-8?B?dGliVng1Szh4ZnNwU0hpcE1qT2o3aHdldU1KcytENjEwMW5Fd0xIS3BwZFI0?=
 =?utf-8?B?Q2tQeG84Q09COTBWOXl6M3VsLytzWGJaR2M4V0RvTWp5M2NjRmFaNzBmS0xy?=
 =?utf-8?B?eHlBQWFkb1Jsd1RXaVZhYVJqYUVjVWNiV0xSdEpScG11WDVBdDBWdHU2WGNO?=
 =?utf-8?B?RklDQ3Z0bDMzd0pwcHdjdWRWU2dIK01keFd1emErdGtreEw2elhMb1NsalJN?=
 =?utf-8?B?eklydm9CdWRWV2NKVUdHWUU5Q1RXK3NQWllCRTZ4eG55YkVBaWtCTDhoUG5v?=
 =?utf-8?B?SzQ1SVBiNlpzWlRlaHFvdnJsQ0JnUjEwNTVKVDZPNWlnU29GQXN5ZlBhMStV?=
 =?utf-8?B?eWpkbW9VSXZHb25Ed1k5UTVtUnI1dWlWUFBuaFFTZjg2Sjc0WDIxc3dna2VG?=
 =?utf-8?B?ZTN3WExIemtoTWE2OUNaTzhseHM5WHdHK3JvY3N5eEo5N3ZpWXo2MFVaZXZO?=
 =?utf-8?B?SDN2b3ZqSnBzUVliZjRsa28rb2ZpMktNZDN4R29yNnl6NERuRm5hSk5ZN0dH?=
 =?utf-8?B?RmZNRkRITTg3N0FKd3lVeFhIaWYxbmthb2Zsc2RsVHZXbmIrQVJQTThBOXdk?=
 =?utf-8?B?Nnh5RGpudVFuM0dabG1UUDM0elRFT3JHWFdWWXRNSjJrTVFSbEFXMzIraWxs?=
 =?utf-8?B?UXFtMEllaHpsOFVuNGh3Uzg0UTRVYUZGWS9TY0lreXVtdEk4MzBiSHl6MzY2?=
 =?utf-8?B?M2cydEZVaytrOElqTjhZT3dxYXVTL2swVnM5SXh0SUpGdTFEb1J3L2dvL3BF?=
 =?utf-8?B?a05MRmZCN2tRTkV4aTR6WHFxS216ejNCbjlpYkxieEgvMjBacmFtcW90RFA5?=
 =?utf-8?B?citveHBic1JnMlNiK0o1QUgyUXIzL0xQUjBKT2tna1lvb1pTVnJJSnl1SHJC?=
 =?utf-8?B?TGh5cDBxYTQzWlArbWcwODhSZ0h1bE44d3Fkd3pxeERtM1gzNXBXdXBaZkU1?=
 =?utf-8?B?QUExZklpNHhYU1NucFNhSHBmWExaeUdBKzhnQ0wwbjFFeGR3SnhHZUFmVkVj?=
 =?utf-8?B?dHNCL2k3SW9rbHdrZXQ1Mm1Mc2FIN0dNWGJVY1JmeThuWlh0aTFkTDBzLzE3?=
 =?utf-8?B?MWdOcms3bDlwQVBFV0hIN1N6RjlYemYxQnhZbE01bzhEOG5PclgrK0ZZMGo0?=
 =?utf-8?B?alZZVnRSbEZ3eGlRWFpLSUNRT1crVjV6M3IrQktpdlNRc2tWbm9CaElRMzZW?=
 =?utf-8?B?Q1c2SU5yd1BKNFNOdDZXWGNQUmlHRi94WHh2cUVMTGFjUXJYY3FjeWxGSk5I?=
 =?utf-8?B?NE5yaTgxV0dnd2RlZEF1UW9IbGJVbTVDNUErSi9WeVhXbGNwUXhaM0JKbk5T?=
 =?utf-8?Q?D12EIVNV2otTPEHYeHZvp+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EECE0AA32EF43449009B5BBF8F3D7A8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79815a31-266d-4feb-7cb8-08dde516c726
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 03:06:54.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKUEDZC8SB6CGrBtOJMZJ5AZYDXelYLrU/u1fS80PnXBBidcmU0qPGVhaW6pSwCG3kXGAZlVFM1j2PZy7hb2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF3EEE25392
X-Proofpoint-ORIG-GUID: F7i1FxvNtSEbrkxjNPt3zySsZn7LsZEe
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68ae7652 cx=c_pps
 a=JdlQBdRp28aqpLEMyktm7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=SJrgzFR0ngKUFzEPqi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jYzO3ICiUsVBJiC8OdxCxFv-bKeXjx64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfXwcoWnd2z2NAu
 N2wgftQgnGlMbUoVYdV7kz8G3QGs3+q1IfUPEBqfLbnugiw7EGmxMWNtsvwLKGF2SDLSNejLT9b
 tle+Cplqfo62mF7OOhDZ6I340GmqG5gUzL4uke3trLotm59mpze2UkkzvvFBp92oYwnIEez4piU
 GSeM4WynyiUU/Yj4THYeAtEC6CO3uuIeU0YBFsx+cQcC1gz5rBZvOdDLv1HOrJoHoOtQsEG2wEE
 fgt8uenOmzA9Pv9caOWpL9asoggvZtw0SOTTALBso4jSgbSsDl2eyOTOC3fj7UVENg/Ar63MiYs
 hk6KV5/wGGP5lLFlM8Y9fm+QMWdob8NdWU+SKtTjeHfcS6KpqrBtQ3iMYJI/cd6sUYh5jGgHt/3
 6BFcELMI
Subject: RE: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

T24gV2VkLCAyMDI1LTA4LTI3IGF0IDAwOjUzICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gT24gMjAyNS8wOC8yNyAwMDozMywgVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtv
QGlibS5jb20+IHdyb3RlOg0KPiA+IE9mIGNvdXJzZSwgd2UgY2FuIHJldmVydCBhbnkgcGF0Y2gu
IFRoaXMgcGF0Y2hzZXQgaGFzIGJlZW4gc2VudCBub3Qgd2l0aCB0aGUNCj4gPiBnb2FsIG9mIHB1
cmUgcmVmYWN0b3JpbmcgYnV0IGl0IGZpeGVzIHNldmVyYWwgYnVncy4gUmV2ZXJ0aW5nIG1lYW5z
IHJldHVybmluZw0KPiA+IHRoZXNlIGJ1Z3MgYmFjay4NCj4gDQo+IFlvdSBzaG91bGQgaGF2ZSBs
aXN0ZW5lZCBvZiBNYXR0aGV3IGFuZCBzdWJtaXQgc2VwYXJhdGUgbWluaW1hbA0KPiBidWctZml4
aW5nIHBhdGNoZXMgaW5zdGVhZCBvZiBwb3N0aW5nIGh1Z2UgcGF0Y2hlcyB3aGljaCBtb3ZlIGNv
ZGUNCj4gYXJvdW5kLCBjaGFuZ2Ugc2VtYW50aWNzIGFuZCBoaWRkZW4gc29tZXdoZXJlIGRlZXAg
d2l0aGluIGZpeCBzb21lIGJ1Zw0KPiAoYW5kIHRoZW4gaW50cm9kdWNlIG5ldyBidWdzKS4NCj4g
DQo+ID4gVGhpcyBwYXRjaHNldCB3YXMgYXZhaWxhYmxlIGZvciByZXZpZXcgZm9yIGEgbG9uZyB0
aW1lLg0KPiANCj4gVGhlcmUgd2FzIGV4YWN0bHkgb25lIHJldmlldywgYW5kIG5vLCB5b3Ugd2Vy
ZSBub3QgImhhcHB5IHRvIHJld29yaw0KPiBhbmQgdG8gbWFrZSBhbnkgcGF0Y2ggbW9yZSBiZXR0
ZXIiIC0geW91IG9wZW5seSByZWplY3RlZCBNYXR0aGV3J3MNCj4gcmV2aWV3Lg0KPiANCj4gPiBG
cm9tIG15IHBvaW50IG9mIHZpZXcsIHJldmVydGluZyBpcyBub3QgYW5zd2VyIGFuZCBpdCBtYWtl
cyBzZW5zZSB0bw0KPiA+IGNvbnRpbnVlIGZpeCBidWdzIGFuZCB0byBtYWtlIENlcGhGUyBjb2Rl
IG1vcmUgc3RhYmxlLg0KPiANCj4gWW91ciBhcmd1bWVudCBvbmx5IGFwcGVhcnMgdG8gc291bmQg
cmlnaHQsIGJ1dCBpdCBpcyBkZXRhY2hlZCBmcm9tIHRoZQ0KPiByZWFsaXR5IEknbSBsaXZpbmcg
aW4uDQo+IA0KPiBZb3VyIHBhdGNoZXMgbWFkZSBDZXBoIGxlc3Mgc3RhYmxlLiAgNi4xNCBoYWQg
b25lIENlcGgtcmVsYXRlZCBjcmFzaA0KPiBldmVyeSBvdGhlciB3ZWVrLCBidXQgNi4xNSB3aXRo
IHlvdXIgcGF0Y2hlcyBtYWRlIGFsbCBzZXJ2ZXJzIGNyYXNoDQo+IHdpdGhpbiBob3Vycy4NCj4g
DQo+IFRoZSBwb2ludCBpczogdGhlIExpbnV4IGtlcm5lbCB3YXMgYmV0dGVyIHdpdGhvdXQgeW91
ciBwYXRjaGVzLiAgWW91cg0KPiBwYXRjaGVzIG1heSBoYXZlIGZpeGVkIGEgYnVnLCBidXQgaGF2
ZSBpbnRyb2R1Y2VkIGEgZG96ZW4gbmV3IGJ1Z3MsDQo+IGluY2x1ZGluZyBvbmUgdGhhdCB2ZXJ5
IHF1aWNrbHkgY3Jhc2hlcyB0aGUgd2hvbGUga2VybmVsLCBvbmUgdGhhdCB3YXMNCj4gcmVhbGx5
IG9idmlvdXMgZW5vdWdoLCBqdXN0IG5vYm9keSBjYXJlZCBlbm91Z2ggdG8gcmVhZCBkZWVwbHkg
ZW5vdWdoDQo+IGFmdGVyIHlvdSByZWplY3RlZCBNYXR0aGV3J3MgcmV2aWV3LiAgVG9vIGJhZCBu
byBtYWludGFpbmVyIHN0b3BwZWQNCj4geW91IQ0KPiANCj4gT2YgY291cnNlLCB0aGUgYnVnIHRo
YXQgd2FzIGZpeGVkIGJ5IHlvdXIgcGF0Y2ggc2V0IHNob3VsZCBiZSBmaXhlZCAtDQo+IGJ1dCBu
b3QgdGhlIHdheSB5b3UgZGlkIGl0LiAgRXZlcnkgYXNwZWN0IG9mIHlvdXIgYXBwcm9hY2ggdG8g
Zml4aW5nDQo+IHRoZSBidWcgd2FzIGJhZC4NCj4gDQo+IFRoZSBiZXN0IHdheSBmb3J3YXJkIGZv
ciB5b3Ugd291bGQgYmUgdG8gcmV2ZXJ0IHRoaXMgcGF0Y2ggc2V0IGFuZA0KPiB3cml0ZSBhIG1p
bmltYWwgcGF0Y2ggdGhhdCBvbmx5IGZpeGVzIHRoZSBidWcuICBJZiB5b3Ugd2FudCB0byBiZQ0K
PiBoZWxwZnVsIGhlcmUsIHBsZWFzZSBnaXZlIHRoaXMgYSB0cnkuDQo+IA0KPiANCg0KVGhpcyBw
YXRjaHNldCBoYWQgYmVlbiB0ZXN0ZWQgYnkgeGZzdGVzdHMgYW5kIG5vIGlzc3VlIGhhZCBiZWVu
IHRyaWdnZXJlZC4gV2UNCmhhdmUgbm90IGVub3VnaCBDZXBoIHJlbGF0ZWQgdGVzdC1jYXNlcy4g
U28sIHlvdSBhcmUgd2VsY29tZSB0byBhZGQgYSB0ZXN0LWNhc2UNCmZvciB0aGUgaXNzdWUuDQoN
ClRoaXMgaXNzdWUgaGFkIGJlZW4gcmVwb3J0ZWQgbW9yZSB0aGFuIGEgbW9udGggYWdvLiBJIHRy
aWVkIHRvIHJlcHJvZHVjZSBpdCBidXQNCkkgaGFkIG5vIGx1Y2suIFNvLCBpZiB5b3UgYXJlIGx1
Y2t5IGVub3VnaCwgdGhlbiBzaW1wbHkgc2hhcmUgdGhlIHBhdGNoIG9yIHRoZQ0Kd2F5IHRvIHJl
cHJvZHVjZSB0aGUgaXNzdWUuIFRoZSBwYXRjaHNldCBzaW1wbHkgcGxhY2VkIG9sZCBjb2RlIGlu
dG8gZGVkaWNhdGVkDQpmdW5jdGlvbnMgd2l0aCB0aGUgZ29hbCB0byBtYW5hZ2UgY29tcGxleGl0
eS4gU28sIHRoZSBvbGQgY29kZSBpcyBzdGlsbCB0aGVyZQ0KYW5kIHRoZSBwYXRjaCBjYW5ub3Qg
aW50cm9kdWNlICJkb3plbiBuZXcgYnVncyIuIE90aGVyd2lzZSwgeGZzdGVzdHMgY2FuIGVhc2ls
eQ0KcmVwcm9kdWNlIHRoZXNlIGdhemlsaW9uIG9mIGJ1Z3MuIDopIEN1cnJlbnRseSwgd2UgaGF2
ZSBvbmx5IG9uZSBpc3N1ZSByZXBvcnRlZC4NCg0KVGhlIG9wZW4tc291cmNlIGlzIHNwYWNlIGZv
ciBjb2xsYWJvcmF0aW9uIGFuZCByZXNwZWN0IG9mIGVhY2ggb3RoZXIuIEl0IGlzIG5vdA0Kc3Bh
Y2UgZm9yIG9mZmVuc2l2ZSBvciBidWxseWluZyBiZWhhdmlvci4NCg0KVGhhbmtzLA0KU2xhdmEu
DQo=

