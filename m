Return-Path: <linux-fsdevel+bounces-50097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A7AC822A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5833D7A1897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C0D230BFB;
	Thu, 29 May 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+BriQaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05354A06;
	Thu, 29 May 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543314; cv=fail; b=QWSCT79AVPfpyK+T8QhjwGXgAZ0y+ycnlweP7AikYv0pLFW5vCmUoYCbW2z0Dc4kk5m+Z1bNX/D+z2H2XRsgGny2nGZRDyb+6myUj84i3oQPnBw8WDIuGO60b1Suo+lJsPS6ALG/hxk45ZytysiqoNH+kgMWfwUyl0hrai5N6lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543314; c=relaxed/simple;
	bh=sZl2CBaz8QXibA5IUx99kmotdoK+WX5+z9hxHj2dLDc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qbLsAPkeNnbaFkAfH0+U6uapD3iDIFL0p5VJj8i7krPfg2rZAHuL9YxnHh5SzWTkiRmEeze8o/xreM6N505D/7pwTXNWJvV6wE5Q6MqCDf5Xfx9Pt6GXDQDeW+Sr47BEveYf72RJw9blQmg7rCIBX0fXxj7G6+l7EgfKQnM04sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+BriQaD; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDZReh012304;
	Thu, 29 May 2025 18:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sZl2CBaz8QXibA5IUx99kmotdoK+WX5+z9hxHj2dLDc=; b=P+BriQaD
	Wy97IhdGKrFqHH6Gr4BmHfRGz8c4XxscfGyLUbGkwiDUTNEAX9zfTOl9l2zf7x+O
	o+7LRYB1u+1AW/6fhRafDjdVEXgnsVNY7jnUswMxfe9B0JEMTewDX5WyS7ZeNMxa
	GJaCKm0E15k/jAv/qMfjxKb7OGfQW9w7KXtFjXZ9486S9Jr+i+gcUUfA+pOBXz5U
	EavPDZYr4Wgd21yMr7Ntihj0dnqzt3zPUiVghNmx/9SyQksDKMg6qY6ixpLl5/Lh
	AVipK1VCA0Q3KwW9Q9VnA7zkA9FYfToKpDGbqIIfxcYB6HlsxVILB/d/S5avhx0G
	Af/h38a20xUGlQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kfa06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:28:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvmjmKAjOAm+vOgS1PoPS3WOTEeHuD3B2FwLll8aqQnbVRr6gn8xpcCk1ipoG2Pj4Kh9OEFFdTl+Tq3m8cXskcKEevXhe0qdsLz2aj37lnbcXdbYLaz20/qiQEueiIQ6kOiu1P4qoK34Wxp54N2baEZfH2IF//vvW0Zi5fxiOg6tQbdQ5Ksl60nNnpVHxG3Zy8QB1nGPgN0wNdXVN2AxjARHViy5+LsDuQBwaJ1tLFugbvKAlN5a0laAlgrUo4gnO0233p9TBJbixirw6ki6IIaBK/clM2JBpygeMVVNpzuPM5/M3vSs6qzY/yyyyUFvWKpEieAEU1mOW7lXqSm2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZl2CBaz8QXibA5IUx99kmotdoK+WX5+z9hxHj2dLDc=;
 b=av11lJh0XxG/u0tGteBMz9ry2dryKJAbnq8xXGE1jU6keMGBAN7/IIKPr1ENhyTIjpjH8KZV9i9lMQIim4fZvisgo17FfoK1vspnan58F33Hzkn16x2dPO9SMDh7eph2+pR47G9hLB+tRJKbvdUYg/rnZBrdGr96WyoHsOeQ+Uc2q3RmbRYdjbg0XCkr1m18l5ZGM0ULNTMKJYVDQQHmmkm5Mz3C6yT/5+sc5lECQSOgdX+YQbS+kcssdgWYuIjSZB701MFG7pu2etOre031ddrRf3K429G2YYUoNAX+tHoFv5R0fYBi/vegx4Taw3zz1G7IkV0sQQ1bjs3qkqh7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5712.namprd15.prod.outlook.com (2603:10b6:510:28c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 29 May
 2025 18:28:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 18:28:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kees@kernel.org"
	<kees@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/2] hfs: make splice write available again
Thread-Index: AQHb0J8/5h6eX6Yw9EGZv/fjr+tfvrPp7aiA
Date: Thu, 29 May 2025 18:28:19 +0000
Message-ID: <604cca238cdecbbe3dee499b8363f31ddd9e63bc.camel@ibm.com>
References: <20250529140033.2296791-1-frank.li@vivo.com>
	 <20250529140033.2296791-2-frank.li@vivo.com>
In-Reply-To: <20250529140033.2296791-2-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5712:EE_
x-ms-office365-filtering-correlation-id: 00d38a70-9c36-4531-0ef8-08dd9ede9658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2FzOFg4NGlJT0VNL0trNjl4dnNJeW9yemhqcVZJYUhrdTVObUxkd3lyREFv?=
 =?utf-8?B?M2J1OU0ralFCUW5BVWZRZVlGSzNDSm51UisrbWZxZy9BbHNSMzBaWjRhcm5a?=
 =?utf-8?B?VE9GSFZoaFlCWk9MTy9nOEc1cmFiNXAxclRnRnJ5eGdsNTA0cU5YS1FnOHpS?=
 =?utf-8?B?dXpPMWVBQjh3TUJLUXE0dk5BaVpFcktMTGs3NXVWbnlRd1QyMXJ3SlFkY3la?=
 =?utf-8?B?R3FZNlgxZE42TXBjb3ViajFreXdsL29wQjdybThzMzl4U0ZadFdva3M0cng4?=
 =?utf-8?B?VHhvRE8xcVVlYWhMN1FCVTU0Qkg4MjZnazJ2Z3NHVDRTY3lCZENycUd3dFF3?=
 =?utf-8?B?d2x3N3RDQTZaZW5pdTVpQzZUbm5UMVgrQStLbkdUcXVTVkdNREdmTkhQazBH?=
 =?utf-8?B?L2JVeEdRVDNiLzA5aUN1WjE5SjBjQk0zSjFzNDNJUktFOXZYc0U1R1NvZlBI?=
 =?utf-8?B?ZzIxSzg4VHpHREVJeDkxRjNPajZuTElkNUZLVlVXMWZJWG9qMUsxNUd1YnQ0?=
 =?utf-8?B?K1FjRFd5UmxGakxTUHRvbTVyb2FIVkg1T1NvdnBhL0FVK3JVM04vVnBkUXVk?=
 =?utf-8?B?R1ZnYnowZlFvMzV1L0QrdFMwUVNJc0oxR3hXQmx6TE1nS2wwdVlhbi9wK2Rk?=
 =?utf-8?B?SGlvSDNpWElHT1Y3ZVp1TFZqNXQwbStiV0thUWpydStDNGEwU25DOGpnUjVX?=
 =?utf-8?B?OHptWk5XQzJmK1JLZjJ3WnhJM0hBSmo0WHVHQmxFeExpUTVWa3k3Rlp2MjJZ?=
 =?utf-8?B?emVGTFQ2S0tJWHFzWHp5cVFEMElWWDZGM1NRWWh2ckNtMWJQKzhyVUsxRFZt?=
 =?utf-8?B?Uno1TlRSbEhOWlJZMnZkaXlGaUY5aDZ0MjExa0RaS01Fd2Z0UVJpamQ4SG5v?=
 =?utf-8?B?aWlqZXFQd3dsZXB0VVU5V3RzMG9MYVVnWWZRNUxSL0xyMHVXOG16RmNTUTl6?=
 =?utf-8?B?UzFEbldMcmFPOStmRmtnMGh2QmlKMkFQZVlYWW1mdWpxbElORFhaSzBnVFd2?=
 =?utf-8?B?eXlUOGltUFVTcVEyRGdOSlNtQTdLOVhTbzVXNVh3ZjNsb3U3aHcxMDBqQ0Z6?=
 =?utf-8?B?MERHN0xDVE9UUnRUQmJFSmlacHNiOHFhYXRpaFFNR2FLTG5oVW9IdmFvTUJI?=
 =?utf-8?B?OElFTUlHdlV1dDJZc0xiWTREbGhHUnFNZmhsem1TM3NKYWsrcjZmTllQTEor?=
 =?utf-8?B?L0lSRURvL2YxanhMYk1CMlhtVVk2WFRlZUJTWHllZzZjempuS1hqM3poVXk4?=
 =?utf-8?B?azMrU1FLajI0VWRFZ1hzamFDaWE2d2NFb2pibnlIRU0rTUZYd0lXNm50Tm9s?=
 =?utf-8?B?RzBoWjVMcHNlSElrMnNYeFh4bldHL3RRZFJlN3V2dy94cnByOWVyemdXZDR6?=
 =?utf-8?B?bTQ0dGFIWnZJZXNuaFdZakJUbExnMWNRTEh1Z0poSUxRZUVrODNuenoyWSta?=
 =?utf-8?B?MXAvWUNSQ096T2tOWG1tZ1RjUjNMV2NhREZTQXFETGF5Vmt1alNQeVdhY2ZN?=
 =?utf-8?B?M21HZUJBU1E5NzJSL2VPczIrRnVvY1g4VHc3NzN1Z05ER2ZBd3c4bDV2c01K?=
 =?utf-8?B?RFV1aVMxVk1qNG9xRjVBMXljaUNKRGJLak5oeis0QWpod1RSYng1M2xGZmVy?=
 =?utf-8?B?eVU3UXZoSm9uOXlraTNjMTNRYysyMEtERWdwK3FaN1NMaksxMVIzS0pOZ0Uv?=
 =?utf-8?B?UVphc2lZdzYxUlZVZGZqOWdnazNRYjN2WmhFN1F5bXI4UlIzaDJFQ2hpak5W?=
 =?utf-8?B?VjFMb0RTTzVCTjJ3UTdqZlJ5bUJtL3VLY3JaOU9hM3R1dEZZTTd2aXdEWTRH?=
 =?utf-8?B?M1ZDSUtUNGpJOG0yY3FjSU83K3FsT0tneUJraEVpT1ZZMllwcys3Q01hVFVm?=
 =?utf-8?B?bG9sQjNQdjlkYTBtVjlrRytpeFFoUDdJWi9EYThRVmtxQUxmVWJxTmQzWmVE?=
 =?utf-8?B?eWtnZWFsRFBoSVpLTm5xay85RmZmbS9ybVh5YWgyTUhCM0cxM3JtZVdhYzBZ?=
 =?utf-8?B?bGE3RlB6bWN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SW9nSTd1WDRuMjRxMjY2aksxS3pzN1RyRXltT2NKK3FqWE5OOCsvZ3k4TkMx?=
 =?utf-8?B?ZlMwVnFrc1VwdEJxdlVjb2lCUWNITDVyanZqNUlaMUgzaEJ3VFk4b1BNVG5T?=
 =?utf-8?B?MHBCYkNVOHA2dzc3MWZPQW5QZGVMdFRQNW9yQi83TVh3cjhtUkc5aVpQMG5a?=
 =?utf-8?B?WDN5cUFoTjYwWDNJRFBkenVKZk44Qnc4YWpsKzltVU90MXUrUFFJQWtUSGNW?=
 =?utf-8?B?bEFsYUxQUlhWSFlJTmZ4UTVCV3RmRkxWZU0waTVjTUxPZmpNRFAyM1VvZ3B4?=
 =?utf-8?B?cHBlL1hxK2xLV2NnMm1FTS93SEdYR1Z4ODVhUUd0L1hSbzgrdlFSaEpBc0FB?=
 =?utf-8?B?T3EvK0x0UzNScG9DZmoya0U2OTFlcnowTGRDWmZ6SHlOL0haNGorcHp1NnZO?=
 =?utf-8?B?UjhRVEZpMitVNnNEanR5V3VTVGhvTDJaeHUxZUFYckRFL1IvVnVicFd3aE05?=
 =?utf-8?B?QnhnSG9xYWxuVHQ2TzFaenNMU2F3Uzh1OG1vbjhEU2pjc0kxMDdBdzVjR3kz?=
 =?utf-8?B?eENnbjR5ejcyN1RTbFpPeDVOdmxQNnl4WStwSlR3eHZncGNiVDdGM3pJL3VB?=
 =?utf-8?B?b0E0Nnd3MWFEMWZLZGZQZEFoaTVXS0tSOVl5UWkrN1NURndWSDJCcnFxbXpF?=
 =?utf-8?B?T1BmRUV0SThuSVJ0YjZEd0pUdG8rakNqTGRNWXJhaXBDc294K21DZmNrUkxp?=
 =?utf-8?B?cXJQbTd5dnhiL1Q1dTFpTmZSRUNJZU9WSFd6Z05VbTlZNmN1empvZkI0SlFt?=
 =?utf-8?B?SDhUMDlFcUxNWW1xMkY1MS9rY1J3aCtvWTJvN2lhNTJUcENqM1puRVJGVDlD?=
 =?utf-8?B?RzU1L1oyK0ZZQWw2N2M2MVNnNWxnTDdGaDJ3M1hEVnZCeFdIRTZiRXB4bmJK?=
 =?utf-8?B?aTlDeldMWG9nSTdmSzZsM1pxUFRaWmgrYWhJZ2RSYTdKNVd0K0I0YWt3QVV4?=
 =?utf-8?B?aTF1c3FiZS96VUZRdWZRZEk1RnZVZVhNSEJDNkV0M3k0SEJnNi9SQTcwRUFs?=
 =?utf-8?B?aFVBNXl5NGZKQkkxbTh4R2VybzA1NU9wOGZRQXJyNDloZGhHZ0VuVnRkV1VW?=
 =?utf-8?B?VlNFWmNmaTRiVHYvcGxzNi9VODNIUWNUMjJRME1KWjBndTJEdytKN1BNdVh1?=
 =?utf-8?B?YU11SEQzTFplYzB3dmdNREdmMUNDNGsyQUltbW9TUnZQR3VvUzM1STY1clI0?=
 =?utf-8?B?UG5Nb2N5MTZLWVNpdEU5aFU1Y0V1RU5JWnl4N3Fsdm9NM1d1akZ1RVN2NXpB?=
 =?utf-8?B?T3dLenFLNWdmTEpXODFUaDI5ck1vM0d4OWJoS2twZ0VLZjJCakdRbFJlNCtD?=
 =?utf-8?B?MHB1eHlSL296MWtjL0NJMjJ2TUZ5cTBtZGF2RFp2ekZDNHBSZXE0bE45bEwy?=
 =?utf-8?B?dVd2N1MwZXhubEFoT2E0SEgxTGZUT0ZJdkVEYmJWa0l3cWRyRWh1b016Qlpi?=
 =?utf-8?B?M3dVK3BmUHlBVmRKNkVQSUVWajJhSGx6QTNjc1pvcWVVQ3p4MG5vUkJxZ0Qv?=
 =?utf-8?B?RWdDUk84cm16dE1TbTZqUFJYMS9ZTkNicENjWmVaZTg5UFpDMCtQTEFuUnJn?=
 =?utf-8?B?UE9Oc0I4SEo2eTg0M281NWN0aU9NTGxGd29RM1VEOWtXOG5RcFduVTJKUHA0?=
 =?utf-8?B?R0pCYUxsN2xmNTYwMyt3dHI1VmpEaC9xREdEUzA3enloVy8yQU5Rbi8xM0tN?=
 =?utf-8?B?MEIwUVNRSlkzSHpVSUMvVFFNUGVoZmo3OG5aNVRmSzllM2I1NEROWUpydnJH?=
 =?utf-8?B?RU51YkZMVXNNTndscGYxZzhreGxMMUdMSlRqeUpoWVpDUHJhZkV5b2tKS0Fr?=
 =?utf-8?B?VGNhVmdzdnJJNjZLdUtzR0owM1ZqT2VQMDJGWmhERzZUdFZSQVNHekN0S2RD?=
 =?utf-8?B?SkpxZ2p1Y3JWaWZvTEdRQkZ1QkpoZ2hQbHZsRUt0OE1Qck5Tanp5cHdZZGZa?=
 =?utf-8?B?MmF0S2xTejFPRWZlUVpheHArTjM5ZGFKaXJVa2lWRGIyTGUwbmhmL2o0NkNi?=
 =?utf-8?B?ZEpON3FTTjZTd2tuN2hmR0Jxa2pRb0xkeWpsOWlOYytuVUFDWVE5WUFwSFEz?=
 =?utf-8?B?d244MHdPWC9YNytVUTluWm9TempocXYwclE5N1hvZkF3Qy9kaHNvU1lYV1hY?=
 =?utf-8?B?Zlkvbm1vcXFxQ1M3VktMWStuM2xqY2d1bDNIa2ZEa1FBT0JvMEZRQlV2N3ZI?=
 =?utf-8?Q?DjrBzNS/hXDo7+6qxplCUcY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4826A5C9700FB42A77C25809DA4D867@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d38a70-9c36-4531-0ef8-08dd9ede9658
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 18:28:19.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzkHOyvXkK5Cs+ho42vl8VvKjym44m2t6dROPU72EB+DpQYo6ZR4lD7I2GUyW9RwhkCFaWl8IiRgNOpycqJnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5712
X-Proofpoint-ORIG-GUID: iJDmhIr7StlVpZCBgketdrUw_FBabOpK
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6838a749 cx=c_pps p=wCmvBT1CAAAA:8 a=0de+TxTBwdPc9w0nPmKirg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=SYwEjaAwvO_-fa4-q80A:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: iJDmhIr7StlVpZCBgketdrUw_FBabOpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE3NSBTYWx0ZWRfXysb73XAmM8xW bSUxHVYcMyZGkXeMDYmfXNRihZh0WrauvIAF2Vn56YGgQPXtmYEJTJA2/4+AA1A7bpBCAYA+NgF occXQRJ0uD23uxjBwq0XMWfn5rPD4EySZp2dB5z7IMeFg+Gr5jjThDVWfWDDpLhD73EO9Peie7L
 NiWVk14qwX/Te8tFPF4bo89pjuHd0WQGG36gRzPtkgFJkF8SBjYw+13sDcCj0AZB/8F2W5hvPBp pbnvJg2odstpagEvWIrG9ojKaBAOHcoW00e9aEW2WrfqzDOPT4HdTj22axjNFjmAT9eSdNogklT rpyXUFd33Ut+6fRRaa1xkFVXzryghU3AHeAJpRo2iFN3n/0+Ap7jsH/H1ffgfPeDXkDvFockmNT
 EthXMw6u1+XnqDDrxTa2414DngrVUV0pNoHNPwhmRiiPGXLbllKGOnf5AMM9mFGwtNm1m962
Subject: Re:  [PATCH 2/2] hfs: make splice write available again
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=964 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=99 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290175

T24gVGh1LCAyMDI1LTA1LTI5IGF0IDA4OjAwIC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBT
aW5jZSA1LjEwLCBzcGxpY2UoKSBvciBzZW5kZmlsZSgpIHJldHVybiBFSU5WQUwuIFRoaXMgd2Fz
DQo+IGNhdXNlZCBieSBjb21taXQgMzZlMmM3NDIxZjAyICgiZnM6IGRvbid0IGFsbG93IHNwbGlj
ZSByZWFkL3dyaXRlDQo+IHdpdGhvdXQgZXhwbGljaXQgb3BzIikuDQo+IA0KPiBUaGlzIHBhdGNo
IGluaXRpYWxpemVzIHRoZSBzcGxpY2Vfd3JpdGUgZmllbGQgaW4gZmlsZV9vcGVyYXRpb25zLCBs
aWtlDQo+IG1vc3QgZmlsZSBzeXN0ZW1zIGRvLCB0byByZXN0b3JlIHRoZSBmdW5jdGlvbmFsaXR5
Lg0KPiANCj4gRml4ZXM6IDM2ZTJjNzQyMWYwMiAoImZzOiBkb24ndCBhbGxvdyBzcGxpY2UgcmVh
ZC93cml0ZSB3aXRob3V0IGV4cGxpY2l0IG9wcyIpDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8g
TGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmcy9pbm9kZS5jIHwgMSArDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9o
ZnMvaW5vZGUuYyBiL2ZzL2hmcy9pbm9kZS5jDQo+IGluZGV4IGE4MWNlN2E3NDBiOS4uNDUxMTE1
MzYwZjczIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvaW5vZGUuYw0KPiArKysgYi9mcy9oZnMvaW5v
ZGUuYw0KPiBAQCAtNjkyLDYgKzY5Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIGhmc19maWxlX29wZXJhdGlvbnMgPSB7DQo+ICAJLndyaXRlX2l0ZXIJPSBnZW5lcmlj
X2ZpbGVfd3JpdGVfaXRlciwNCj4gIAkubW1hcAkJPSBnZW5lcmljX2ZpbGVfbW1hcCwNCj4gIAku
c3BsaWNlX3JlYWQJPSBmaWxlbWFwX3NwbGljZV9yZWFkLA0KPiArCS5zcGxpY2Vfd3JpdGUJPSBp
dGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KPiAgCS5mc3luYwkJPSBoZnNfZmlsZV9mc3luYywNCj4g
IAkub3BlbgkJPSBoZnNfZmlsZV9vcGVuLA0KPiAgCS5yZWxlYXNlCT0gaGZzX2ZpbGVfcmVsZWFz
ZSwNCg0KTWFrZXMgc2Vuc2UuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNs
YXZhQGR1YmV5a28uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

