Return-Path: <linux-fsdevel+bounces-55611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C795B0C932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD01896D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B572E0924;
	Mon, 21 Jul 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Id9YmM/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEE2C9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117465; cv=fail; b=mfIlx0qNP4o8nWHShBiu3W5TvUuYY1OQjAzodKPOE7n2+ZMxWI4WTCW/TSa51tkQuD/FH/HD1PkXpjNGVzsbmQJvfdYNC7ZMoXb0j/QIWraKNWJL3MPXaNW35a48s6l4ZsuxMC7B4ToewuQ9j7kSyTfH2SRSeGwywE3eL8NlziQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117465; c=relaxed/simple;
	bh=ACGYQhQjkGDpq2+SdjzCb5NrOdg9oZNmj88svrcXcAQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ol40ZtBePYv7cyGANahA5gTBTGfIQovuyjSw0JSaatksaTrpMXF2cZXzTQikbdRWXmJVc+uJwhKObkWVTmtsuK8R97QhpjsMIKqt33DA0tAQ9HXLXPlUTPV9l1PUZKyfzHhLYMxfVulAhI7B0PcVtn21F+MnslZNPDxS4MILvk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Id9YmM/7; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBFTVd001039
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 17:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XsYWCMzAJzXBikxmYUQn4LpkGBOpviKGbSHzPUC3lX4=; b=Id9YmM/7
	P7e8uRYjcrAwHjUBWV1hlVEKqjMDBw2ANyKkv+ECfLwx+C5+iiV86saIau2L2nHd
	z+PByw0+g6i3P6+/W24HIr4asMf2lwbFgsPA/Lx3MBVG8mNo5ERKAv4GMbcJ2nQw
	2bvEFpe0eB3OCEQHSYSpP1reOoZ3I/DI75fXsF+6kenxrqEKrZIYfhoR3tQzOwpf
	oc5Kn7G0LIv2CJCEJ9va0kIc+gZH7Czc/l46fI133BHKxuzVvTJI26/ZLy6siGyR
	52Sj/pFZCqplUmxZWpH6+Ld/AqcXnqYWF41vQgihcHNkDsdjSuaNtBa68K+ETj+s
	fJ/fSfyg2I+hQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v9yha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 17:04:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56LH4M8d027300
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 17:04:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v9ygx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 17:04:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSZOBBUSF8u8zxiJoR4VSMVrTrUA57dpu1u/cRy4IIlgKriIazJsVDduutztNbaAcVDPPiZELZ1vCsh87qjS88f4ON2MPqFaGvh4kj2MrWgnlBgZ8hbD6M9x2pFuCLocF73el9/+Xz7pVHrT06U4USFJmLD4dXL8Q8nSJ8wYK0AhqjHULFU61Jrno1Sh4a55DvFtzBrLl6oxkujuPo3XiCtZkWqHXy9Izwl5UHJQS+jhx+JavnOOQbOH13i4RsMIBlqTCR1pVoEk/tNAmjX6/4TNvJda71yosA/Tc/w+VmYf94lnnnAZ1X0M4Cf3eoxM+YYX2laUU45aXXUk7BtRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3UfAapX8HfOKCsros9nOhY0XLiYuAPwGAbocX5C6Ic=;
 b=iw4a8bQC58hcb4sUpdnxR5WiUbPPXAXE+e5/afHj9/OPO7++16fkZUyT6AY+fkTVHnOD1X3fT3ijSvW8LS3ojvRiGV0qop+xgo4ntiKF08J8LGr3CyU1JNvD1jXBPGi5K9b/nWugDbswzuyC8f5S+n6omHUhxe69A2oRHDkVAtTYsZQyUUWrqRoJ7jxXmrboeKaEOK3c2rOsGggl03PRG6SV3hVPV7CsrpToUhRnnuCFvu0I8pLjwtGU/hpFLqSVA8+4anWopKwEgyqLpW1FTsmDUlQuZwBrEsTrOs/9+E28/mt4/nJqNc9G0KIBzMicn7/jyCuK4wdrAsP3pfRZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4917.namprd15.prod.outlook.com (2603:10b6:806:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 17:04:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 21 Jul 2025
 17:04:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org" <willy@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index: AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAA==
Date: Mon, 21 Jul 2025 17:04:17 +0000
Message-ID: <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
	 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
	 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
	 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
	 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
	 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
	 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
	 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
	 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
In-Reply-To: <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4917:EE_
x-ms-office365-filtering-correlation-id: df6aec17-52e7-4606-e0cf-08ddc878a141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amdGelVybTIzbEJnTCsvbzdDL1RxVUkxYWp0RVV2Ylg3djgvTUF4ZzZ6Rzlt?=
 =?utf-8?B?a3VPVzFJalVrR1gzeDlpL1ltcCttWHRFSjNETmZSNStWMTlkVXVFQ1lGYXM1?=
 =?utf-8?B?bXRtc0RtZ0NSQWl1bjhVdlEyNVF0S1BibTlNdXFsdmlrTXk1bjBld09TZVR5?=
 =?utf-8?B?Zlk0VnFBblpFMmF0WVRBRHQ5SmwrT3dISXA4WnJmWVdhNEl2RjNrTzRlQmw0?=
 =?utf-8?B?MkdyRWxNNDFLVTlWWjdhS29wbkRRWlYyQjA1NE80WFpRZ24zaW1RR1M4bXA4?=
 =?utf-8?B?akNaTkVaM3ZmNHgvQVZDT1o5em1kL2lDU0hsMXpuM1l6Yit1cWd4K1hCWG1U?=
 =?utf-8?B?eHRNSTJxT29Hc1k2cXR3VE0yNEQ4SERmbXdyQ1JpVUVkcURsZlBPbHoxTmww?=
 =?utf-8?B?RktGT2EwbXhGMm01eSs0aFlpRUZiZzhkdWRhalZhSTNZcnJTRFA0NWtvL0g3?=
 =?utf-8?B?RTE3aGNQaHZhK0UrR0xENHVZL01NNEFhUW1tbXdIMzhJem1JcU1TNExYbHB2?=
 =?utf-8?B?S2pQS2piaTNtWVIyMDl3c0kyNmR3LzlHNDJqTXM1d1FkNFlYNzQwVXRuUjBu?=
 =?utf-8?B?VTNKVmpMaDNQKzlNYjI0Q3JIRzArcndQeHdnanNUUnkwQ2RJY05wMmV3U2lx?=
 =?utf-8?B?MVFCMksvVmRLaThCUFloZFBvMkFWaFc4cmJTbVZ2N0VGdkJyQmd3T0hMaHA0?=
 =?utf-8?B?Z0FrNUo0NytkTHlJU203RUhhcWtDckhGWkUxT2REUStGWElVVjZtaW1tU2hT?=
 =?utf-8?B?NXhFckw2MWdmTGVxT29mM2tZQWJjczh1OFBaellxbXRWUmR5SkxXRmlTY21i?=
 =?utf-8?B?T3YxcWIyeXg0WEgrblFEWjBNZUFuUHYxN3BnQUhkUllkZHpmR3lZSy9lQjhp?=
 =?utf-8?B?eEJUcDdTWlFqRjdNTW02S293Umd6WExxemo5MDVpVHJjTlg3MlR3TVZoK01M?=
 =?utf-8?B?UHM0eklUdWJ4SnpoYjVHMk9OV2FUYk9vVEMvT1dueXlxbEVLNjE2OGFqQTNL?=
 =?utf-8?B?NU55bEVEdDd1ZHlINU1tUXRYWDE0blhMbllDSmI5bCtPOHZLV2k2dG5JMld1?=
 =?utf-8?B?Si9JN090UUo1ci9kWWsxbU1pZ3NObWx1SytSSnpXV2puMC9kQTRodXZOTEQ0?=
 =?utf-8?B?ZWJkU0t4eUhYYXVwYkFIR2JXYUFQUVFrZC9JNU5YcHBseWJRTFJXU0cvMmdy?=
 =?utf-8?B?MUNpRGFlRmorSDBrWjZWc3ZPd0hOcS9GQzV5SVpUbWgrbWZ1dlJqa3gzNXBM?=
 =?utf-8?B?a0Vva1hNc3BVRG9IKzkwNllUMXdyOWF3aWpjZ0FOaFFKaHpKYUY2U25CbXRp?=
 =?utf-8?B?ZVIzbHJXaGJnNFpUVkI2WjA1OVlKT0VXL1hQOVB2WlF5Y1ozNXFWaTFNaUxJ?=
 =?utf-8?B?N1dIM1JkV3NMRzNtYjRpdTkwV01seHFkQTZVa3ZLWjNmaTh1WGdJTnFDdGdr?=
 =?utf-8?B?Y3FzZi8ydXllM2ZRMWJoSC9CUU1JSkxzVnJFZXBzN2E2Q3lSR3hTVEpEWlov?=
 =?utf-8?B?TFhBVFVrL1h2ck9iS1FXSEJyZk8ybXhDZWlIamd6U0crTHpaUkFjUHlwYXhV?=
 =?utf-8?B?eFlBNzBvTXduOE9lTDYxY0RvQU5SOG12eWdjRjdyTmdhTHFIMGdhRThHK3Nm?=
 =?utf-8?B?MmxZUTRoVmtWdEoyblJCREhlY3NoeTZBUkEwVDYrM1ZuYkhDUmV2RGU5WENP?=
 =?utf-8?B?SW82d2VQb25IR2JBZ0NDV2Q1M0Z3RUtQczAyUUNLbmc0d3krekl3a1hrU3hJ?=
 =?utf-8?B?WjJvNEk2U25uZ0xOOHJyQjhNNGlEbHA0QjNwZGR4Y0FhR2ZtVFpxQ3REZHpY?=
 =?utf-8?B?QmVMbHA3WHdKQVZRQlZQbmJSRFlOM3N6MFVyWE1ldWJxR1I3QW5sekdROVZt?=
 =?utf-8?B?cE1YdXdrZnZXdjk2a2JrYUFoR25RSWQwU3ljcUk2clFxWVYrQWk3TnlLcEo2?=
 =?utf-8?Q?G2z8jiq3eNk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmdNaS92ZDFLR1BIdy9tMXU5TTk3TCtGYkFMZTBxTGxZMjVCSDVFYk9nN3Nj?=
 =?utf-8?B?djBzSjFxMmpxeEU4L05SS3gvc2FnNVlvbXJsTld4d003eGdBNzQrSTZMMGtm?=
 =?utf-8?B?ZzQ4MWsrMWlmWDFGT3RKSzhyYTExODYyYlM3SXo4dU84bWEvY2ZyZm11WjVY?=
 =?utf-8?B?NDhsYitSSU8xbzUyQmU2cVUvRXRFSWk4TXhQMFN0TUxOMzRtN2crR3RKQVpJ?=
 =?utf-8?B?djZnbVVSOE1PQlhJQ2tHbkhtbVVNblovcUF1cGZrMjI1WktPd1cxMUxHMEdW?=
 =?utf-8?B?dWxGUHZoMXN4MGU5S2cxYjNVWDZlQmN0d1N4U3NmdEhMY0FFUDlXQW95Rmhr?=
 =?utf-8?B?T3I1VzZFdjR5MGdrVCtmVmlWOHFKRS9yQ2QzVVFoekN4WWxiNjc2dkdxNGh6?=
 =?utf-8?B?L0xqTFVtZjBvbmFmNjM1elVFQnJBRUEybkx3ZlVQL0tsemltTXNzdDFSMFJr?=
 =?utf-8?B?UU9vNkpYbUxDTjJmcHNUVUxITnk2cWk4WWtZWWsyUGI3cXlUVG1CR1JPaFdY?=
 =?utf-8?B?MWdscUhVZFpYYktpVzMvUUF2cFc3QzMxUWYycUJVc0xRODlBWGxWcVJ3YTZ5?=
 =?utf-8?B?RkNOR1dnZ28rQ2VhWlU5ZGYzSTBBeWdpbDZkS0JmbkFRSksyVzluVlYvZFJN?=
 =?utf-8?B?dmE3NTB6dmFDYmZjeVJ6ZGxES2FUMjNLaUkvSlhWOE5IMUR4eVBtN3pOYVoy?=
 =?utf-8?B?dzJ0VGdwbmxHQWJmZGUrblFnYlJwZ0xFZmtYTjdydjd4UWlQYTFlcEFXWHla?=
 =?utf-8?B?Nk5vUTlrMzR1YW5MbTA1bkF1bzhOSjI2R3A4VFNIR0tyOGViUWJlWjRXMHlz?=
 =?utf-8?B?cjZ0eWFRenFlTk9CSVV6c0I3WUZyRkR5NG8yNjBiWUl4Vm9uN2U0cGFJTzdi?=
 =?utf-8?B?dUZIS05QQW5IR1B1VG40enJVRmFRUVJ5TXlodjdXTzNBVmhYbEQxQTFNMEdD?=
 =?utf-8?B?eDdqYjRGVTV4bjNoUmdiNUlYTVEvWDlqUnhpS29ML3ZIdHdhK3pkSXo1SGs1?=
 =?utf-8?B?UkhMd0VoOGdWazJJOU00aDZmUFFNYXp1SGVlOEZlTzM0Rm5PaUJ2cHRtYm9l?=
 =?utf-8?B?dlBFTUllakRYWkVGTXFqTVFnSTIvTXVoemZ2Y3FOYXJ3Q01rZmxQNWdYdEZo?=
 =?utf-8?B?UGErQys3NGpGMFdFZy9iRktkd3JILyttblhTTGl0V2RNNExtZWd3WkNXLzFt?=
 =?utf-8?B?ZW1DT0RaejBQTnp4emVwcFlzNXlncmUwRTVRTGwxWVRwc3d3RnVFb3U1eU52?=
 =?utf-8?B?QkxtNjdnTlEyL1FwRXVtVU4yZXVNN1VQVkpGQVB5U2hIT25sRVg3OEM0aHJE?=
 =?utf-8?B?OFZ6TWVhRzJhVGRtcnBwZnNPdkpVUm1zdCsxSkxSdmhEMUduWWJTRG9aZ3Ry?=
 =?utf-8?B?dFJSQWtieUZocHQzM1Z4ZnJFU2ZpMjE5Um5QUkZnaTRLcFZKSzFRU3psRWRo?=
 =?utf-8?B?TEx1RVFOUTIwcTFBYnVyMWU3enZQTmR6bXN5bkFaMTJISE81TzdtSGx4L2Jj?=
 =?utf-8?B?OHVWazk1ZVNGSnNrREZVcm5KQnprcnJyUUNjM1hKN2w2WHBPeEVxcXRUNW12?=
 =?utf-8?B?ZXlwbzB0Sko3elV6Rk1CTlZQaTFDUUdvUkxYYWRzM3dQSStTaEZTTlVLOGFa?=
 =?utf-8?B?NkEzME4zRVE1VnpBSVM3andKNWZGZVhJeENrWlFJTzhmdEJpTDdIc282bm1n?=
 =?utf-8?B?VFljdUdUbGYyaTkraHQ3UFUxVnpWSFRERWprRDArK0FzMldxRHZjNEVkQzFI?=
 =?utf-8?B?ZGY2YzFGOS9jWmRxd2RtS094TEQwa2hkYlRXdEFQRXVLeCtSN2pJbmQrTTgr?=
 =?utf-8?B?eENQZW5IdU5nUGZjaVBCR1ZudHJuUUdXNzdKTS9BbWZQUWFMZkhqNFRUYnIx?=
 =?utf-8?B?M1VkUzdJRnRUQXc2R3h6ZUh3emh1bnEweENNL0Rka0F6ZG9HYm5FcFRySGN4?=
 =?utf-8?B?Ymowem1pRlBkWU14RExIZ21NVUpxcEtSSWhhc0ZGVXhreVV0VWJpVHA5VURG?=
 =?utf-8?B?SEthMVZXUWhHNm9ZempwQmJGdWEwd2VHNE1WcjhIMmxwN2NjVkhtUEdKd0hG?=
 =?utf-8?B?YTNpd3JJWEY2V3MvWnlaYlN4eS9NTWtTcERvczcxSlM3eFFPUnJYaEozeVor?=
 =?utf-8?B?UUhkRks4b3JXUXRrNFZ3VHJjeWY0NG1XL25UWkFkTEp3QTVINzMyTGVxbDlq?=
 =?utf-8?Q?BwRQgXP1wtQc7Kre5an5R+0=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6aec17-52e7-4606-e0cf-08ddc878a141
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 17:04:18.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lxDVnYjvub6/gOPA0e0FjZHwchPvJ1jYsdMaS4Paz8ep0qO8W3H2FIoVcsW/EVcO9abYhxvJH+aoBXmHJiZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4917
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE0OCBTYWx0ZWRfXx6OmbwWBseGw
 wF9dlCwXyz39jKs10p0ipiMVjbujBEejrLKu5lB1JPuvD+7ZStsbRrlfi14gauUYgmCLDtsefAs
 1Gejz/qekJIkeZcU+A4pGcq4JHSEG5KOAh4z2B95EOPGTcxi9I7wgaZ1MjWxc/uTWxNKig8I1Id
 Z1x1EgwYzoF3gv29wev+4a9tqEGM55Ttq2PhzyQ5Ak/QsZT6E0NZkfUfJ0dMMsvJiqAT2VHSw1n
 0krVeeM3sNDw8vqhxRHNonT13zzHeOoiSzsgz/+/aVuX9qA3DgJFtde5cuTo1jgYPr/t+y6Cw6m
 u886w6frBi+tF+HLl5MpI4hdKSppjXTC2nLphm1YdUbfcoxaAh0a7vc71gCGP5vV8KpbkhwOrHD
 F+waBPjNft7Z9WTyalpfVR6wm0tBBucDXmxNJ42De0an3mUPsBW64wC+SA/G6AqDCb1Uoy1x
X-Proofpoint-ORIG-GUID: R2ezfohRzAOXpIpJb30GCDAzTChjwPkW
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687e7316 cx=c_pps
 a=B4bUw2QgNwGTCAXqIx8Ikg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=qBMF0ZKKsQTWjMwbaAQA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: R2ezfohRzAOXpIpJb30GCDAzTChjwPkW
Content-Type: text/plain; charset="utf-8"
Content-ID: <B484D8483FFFA046BF36C118381FBCE1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507210148

On Fri, 2025-07-18 at 07:08 +0900, Tetsuo Handa wrote:
> On 2025/07/18 4:49, Viacheslav Dubeyko wrote:
> > I assume if we created the inode as normal with i_ino =3D=3D 0, then we=
 can make it
> > as a dirty. Because, inode will be made as bad inode here [2] only if r=
ec->type
> > is invalid. But if it is valid, then we can create the normal inode eve=
n with
> > i_ino =3D=3D 0.
>=20
> You are right. The crafted filesystem image in the reproducer is hitting =
HFS_CDR_DIR with
> inode->i_ino =3D 0 ( https://elixir.bootlin.com/linux/v6.16-rc6/source/fs=
/hfs/inode.c#L363   ).

So, any plans to rework the patch?

Thanks,
Slava.

