Return-Path: <linux-fsdevel+bounces-55901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AEB0FA6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AD617190A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B295221F2F;
	Wed, 23 Jul 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2fvlVvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03A219319
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296193; cv=fail; b=FIS9EGA7l8m0NtDxsqq9XBKT+XzafZpPIqGwjOUbGjhHYgQvLNY+Rid4bu4CuIg4pCY5l//l0tbRFPiYqmiJqXxXRGKuSo/JrMRiZ3WGPlgR9tp8L+El8i5FwJ+plKgx4sZz9lHIIhObF8eRcVYHhhiAPoXagQsNTWg11M/gtM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296193; c=relaxed/simple;
	bh=qqxkoDsqoK4fvwynHFMU632wbLqxAN4DDWcBfapG1FU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lUbUNn573eOAtIsngbHHuXn2YWwM72JOriEFpu9Y13d8Xg/xVHXJ5aLUjobbIqbNOCvFkhJ9xkoixmgyqtbZP5hYwNGHuDrNLS2TJSxfIof3OL3IUQ1Frhv6viHfQ4gLeMcTt32NWGVaOEQtOuuDzHW6jp8cU/wmUXbcNoFNuM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h2fvlVvd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDiOUg004401
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 18:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2+ftE4smSIoso+aYevhvGAxiLjfLi95sNbwSkr+ZvEs=; b=h2fvlVvd
	CQ9YGGpBtDQcks6I1IQyp+t6Tsm235LfJYIVvgv7aPbPZQukHo6uQJQx82rLowiK
	pfBkdFKHD0EY+KVxpQU3HLNh9tk2RuO/mP5T1XYfn3XCtiLvLuoyU4aNUhzO+otH
	rX4DwgRKtG+sDtAVpp6jjfBaF2RP5UhqtyaoyBhIJYmqTM0qnAuPCG6xrAi1eXGS
	8R9SJrpIt4HBVcywC9ooDqt1VeHe6eGFNwo4BncNqdgMguz330R2v9khe2xhAnBK
	8HOShgB1Ql+Z+kxv+Q/aq1EIYNIpJ2p3tKgnu13Ya5BEHgj1BcEOcPGutFpXRBDZ
	wR1k6nKliJLE4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff4xhp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 18:43:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56NIhAUh013594
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 18:43:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff4xhny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 18:43:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKB5bx6P6bxL9TFnGaa/4ZJBPYSwgmmuD+9rY2Ht81LtreEv/2sjDcT/W1+BUcRzd+t1M3eniigyn8//Z5n1fS/3Hle1mqZ8snpgr3UC0GqhbYD0lb0TDc3De6EMLNasx9Uin12/PLkHzFWsXkEXGbKB3iYu1e+CRGvsVM2WvebBHdlV8Q1dOMGnRLeY5pVCPjDjGRsdcFqWu2uGFDY4S4pp8hR8GOyz589K6vSpjnlerzouSzrkwBUX1l/du3vmSaXDfdHEsuv8Ch3X2BRYovhbfH20VBrz4TQW2Ak1v1ZAELo4Q4MLRiGGAd05SkGLerw8vJ5A5L1mQlJrxvYc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnWZwlQcfmyQ+8RBMWTRo0osmWo/CnHJL59mkAds1ok=;
 b=Cu3iy2GAKP+M+PrI71YkW6+SkI5ydoaHxgN8otMLJFI2+FgOx5eH9ST3HMlT0oIfHoQkCDoz6W5s+XPJdEeHVpF7xWpDbumY795uocbdEhho0nQuNHBhY4WfLB0BPVQqm7mgK2K9dGpMHTgW9PzPoY4U2eqyqww17GHu2TLXU+O8Z2WWS53j3H0vv7HqmZfoBWOWUX/KVzNj+FgrWEy/CgbE4WsjhWaUnaF55FT50B1uWmo0FiQmYDcvcMcDRUhjVOrjnFpnPiE2IJdxH6oPfqitGEb/3Z4VPqj/Walnt1MnjLc0cRPTOEe1Hcw0j+Bl0so7cHhwC07qsVGasxWIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB5804.namprd15.prod.outlook.com (2603:10b6:a03:4fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:43:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 23 Jul 2025
 18:43:07 +0000
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
Thread-Topic: [EXTERNAL] RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAA==
Date: Wed, 23 Jul 2025 18:43:07 +0000
Message-ID: <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
		 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
		 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
		 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
		 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
		 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
		 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
		 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
		 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
		 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
		 <aH-enGSS7zWq0jFf@casper.infradead.org>
		 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
		 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
		 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
In-Reply-To: <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB5804:EE_
x-ms-office365-filtering-correlation-id: b7d42b83-766c-40ae-5d5a-08ddca18c3fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzdOTHF6SFlWSkhkczI4K1YvS0ozM21aVFVkQ2Y4MzE3WVJmbG5UbVlLOUV2?=
 =?utf-8?B?L2NnejJ3K3k1WkxOVms1Y25maUgwWUZBSXkxZkpOVjVZNWNORXJlakxkelVm?=
 =?utf-8?B?M0paRHhRZDZ0SDhWa2NPYWtXVUJoaXNMMTJRRVUySDN0c042V094bkVzNVBF?=
 =?utf-8?B?R1RRQnRETFlDa1NocGJVN2lTditydklTY2dvbTVPdlNOeUhzNGppN2NzU2xk?=
 =?utf-8?B?OHh1VlhkMWcrWFkzVUVHdHNrOTBSWHlhOXg5S01DejM2MmQybit1ay9rZGdN?=
 =?utf-8?B?QmxOc0xqcW5PM24zelRKZmFNQVlVdit4N3h0Q0NYM0RLd0ZmNnNERG51bng2?=
 =?utf-8?B?Vm05ckxqMGFTVlR5Qnoyd1B1cmdOYS8wRTlqQTFrWlhsVEV3eGpDemQvbVFv?=
 =?utf-8?B?ekxzY1lORHdOTXFMZC9tS2lzTldxTWl2aGV4NEtWKzdPTDYrS3dPaGVDL094?=
 =?utf-8?B?dWVqamhMcDVOYlFVRXZrUmt4ZHAvTHorMEp1WlZoc0VWcUpHWDhxbEJVcXVt?=
 =?utf-8?B?bTRuTFlNZTFDZzQwK3QzNkpvTEw2cFpXc3g1bWZKZjMyT0ZORy9sZDBYS2FR?=
 =?utf-8?B?WWVLZEw2WTJZb1NXOFBhTWJlQ0s3cEgvYlZaMUN3Y3d0VmdzektwUWl0VDlu?=
 =?utf-8?B?ajl1RlpQc1BXRlNjMVBocFltaHUzWWswaGtWZ1VJT1hSdUovUFdTSjBSaUwz?=
 =?utf-8?B?Wk10MjVrdGhBMXUweXdnM0FsRVRQWGJTdFArWDYxN3dPR0NQbDRHeHVmSVNR?=
 =?utf-8?B?Uk41b3Fwd0xTN0VnM25XTlhxd2tiekVUWmpabHZtbWNoOTZWYnhqc1d3dG1h?=
 =?utf-8?B?c3BUVlFFR0xnbEhSaVBWVER2RFRJSlFmOHlHVmFib1RjMlVWSTR0bXJJVE5K?=
 =?utf-8?B?ak9IeDlDRUQ2cFZ2TmxpSjFMS2cyMjVvOXZUbW5EWTJES1g4N1pzS1RMcnpX?=
 =?utf-8?B?djhCMDdESnBXelkraWZyTWI0M294WXAxVGtOMFE0N0I2MFZnbU5FT1FyM21S?=
 =?utf-8?B?REptMjFxdVdQRi9GTzg2c05EN1prUVVZa09jbHl6dlpJRkZRRkZMUktMaHJO?=
 =?utf-8?B?ZjR4MVIzaFBDRDNnQWpOb3JxNFgyMTVRZms5NWtuKyt1bzVvZWd6Qnd6bi9v?=
 =?utf-8?B?bE9wNUh4aTBXbXZGNFNNVWxiQVNla3JQdHAzNFRLb254UzVNckhJdjNIeXN4?=
 =?utf-8?B?bG1IVUdadE1wc0EzbUJJUEVLV2Nta3ZpekNoZDI4R0xHZytXOG9MeVdEcXRi?=
 =?utf-8?B?Um9UQXZiNGE4RCticGNmRFVQNDc0eGt4ZlE4aGNRNlRDU3BhcUdwS1ZobStO?=
 =?utf-8?B?OVFYbTQ4RUpzTkFoWElKYXlNbGNvUi9yK2tDeXh5Z1BuYkdmRytJYUppQUhE?=
 =?utf-8?B?TTBsQzZWR3pNSnlWVkJQR2Faeko2NllyL2FQdm42Kzh6UkM2bHVOajFraGlC?=
 =?utf-8?B?SmcwWUV3a2NOd01OenNPMWk2eEJzM3dSMjZSTmxYSkt5ekZQT05kbTFSamlI?=
 =?utf-8?B?UnBvRWxJa0NPbTRRM0V0M2NzZkFNK0o5eklRd1cyQjFvL0k1UlZ4NzdidVZy?=
 =?utf-8?B?L0xVVXZEbU1nZVRPdEdkNzZlQk1hNnlzUHllNnUwdk0wK1U3WnFTUzVnUmJ1?=
 =?utf-8?B?VzNBME5FbjhqQ2NtWlR6SWVkL3d6eU8yU3NvdDR3UEVZZnE2aktDNE95aFg3?=
 =?utf-8?B?ZFUyR1pUTEprRTZqVDhMdFhrSld6UEpCTTRuNmJiVUdSRC9KdHR4N1lGVDdL?=
 =?utf-8?B?VzlJMnJCOFJGOUVzZCtBNjdQclJCcTJTOE9vQmN1dVIyNHZOWkVvWUI5U1pT?=
 =?utf-8?B?YnQrWnlqVW5aZkpDWDFJZ0hONVdYNnVDWGVOUTB3NjczcTgvOEQwbWxyWklU?=
 =?utf-8?B?cGQvSFM2OEhhUWJjQjA3SDdVVk51SFBWK1lLeDE0ZXZsUGtlNE1zdnRISE9u?=
 =?utf-8?Q?dUtxsWLDlYI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVhaZFd3K1Bkbk9nYktUNVN4L0gvK0xaRHdicm41czRpZ0VzTk9vM1NCYWNM?=
 =?utf-8?B?NUQ0aGlnSUo4YnpTVVZTczNCUGFydUt2VVA3N3ZwYzU3WUJOMHRPTjZNY21F?=
 =?utf-8?B?NUlOdjdqR3gvNlYrNTNleFhjZ1pDdkRtZ3pHU09PMXVIMXgwOU1QNkt3d1F1?=
 =?utf-8?B?ZTFPdFZsRDBoK3hGR2tvSnI2QXorQkNzbk1uU1U2RWdBWUVXd0IxTC9GVmZr?=
 =?utf-8?B?VUkwVEtTM3J0QW12NGQyRXRFV3U4cDR4eFJFeWxUV1RDUEZiZ29nRG12aUk3?=
 =?utf-8?B?WThBbVZaVnFBQk40NXQvaGdRYjZGMmNMVWVGUXBOVlhEK09KUVV4bHRsbC96?=
 =?utf-8?B?WTFpb2RtYmp4SDdpeFhIcWtjZmtwNlFMYWZOaWpNR0VXejRRNjdOUFU0OHV0?=
 =?utf-8?B?WHJpeUZmMDZWcWp4STBHYU1oajZ0ZElxeENtUnRyUE51RjlwTm1BRFRPbm8x?=
 =?utf-8?B?OEtnZHlvd1dOMk9kbXNZVDZnbHA1a3NFNnZHV3ozc3ZEdzU3WEdDVkc0YmVa?=
 =?utf-8?B?czV5Q09JQlVZNndwYUU4MERLVFpsa1BNVmpFeSswaTRSVThvVFZ3QWNGZ1ZR?=
 =?utf-8?B?T2pMSU9rbWNnZlNFS3ZsR252NUpieTZrOVRPcTRMaTVWTSs4dWdjZHcvZzh3?=
 =?utf-8?B?TFFkaW1pTzRDc1I3YVkzTkVVcm5NRXJSVVZ2ODVQTG5ZTlZ4bHFpbXRpT0NJ?=
 =?utf-8?B?WHpOKzEvNzcrRWhwcGdDR0d1ZkljWm44UVNwZ1IrWVNaSEdhQUtyU2VJK2pD?=
 =?utf-8?B?VDFHQ1p3M1BSMlRRZHdNdnRCYVo4TGl2dG5FbGg0b0tpWWxYbGRIS0dIQUJ2?=
 =?utf-8?B?WFNPWGRFek9FVENVSk9XS21jNWl0MWJSTHpwTUlXS3QzSXNxOXQ3TjdVdis0?=
 =?utf-8?B?R293OGpTR1ZuN2FVY2t1cnlBbmFiMDFqeWRlamtmUkVURlo4NUE3cUZFb2hI?=
 =?utf-8?B?Wm0zTmdpL3ZuS1lTNXhIb2pmZytuUkFuMy9LZkFGNFFINjhRTUhFVGFBVWhM?=
 =?utf-8?B?dERkVlNWZDg2emdOdzZPSUI0Y21CeVNLQkF6R3kwa1gweWdmUzB4b2Jra3do?=
 =?utf-8?B?U2wzY0I5UkNrN3FDRmM1cnBQKzBSZE8ra2VNZEhqM00wdkExZFo2VmYvbW0x?=
 =?utf-8?B?UDcwR09qbHZxcktHc1h6N1VPMm9MdjlESmVkTFVHYklBejVyQkRsdVZnV09L?=
 =?utf-8?B?MXBmVVh3TElxYVJLOTRxODJxeG1aWmYrZWhEUWVQU3UxVnNtNnNBck15SjR3?=
 =?utf-8?B?V0U1bDJiVmlwemRNNFlTblpCUmx4eDVnYnRkZitpOXlmRkZqK1VKOTlldnNK?=
 =?utf-8?B?aHlHZ0xBMFdNQitTZ2tZdUVNenFkbDJTa284SVlWYXg3YW9ZdFh2UExobUtq?=
 =?utf-8?B?T3E3Y1RoYm1NV0xQbEVnRGhZa2tMQU1JUUduYnV2bGY3Qlc4cDJHNHBYNGVM?=
 =?utf-8?B?bDN4dG8zTjJYV2tHdi8rNWNvb2c1YUxuUVdDTXE5UHNSOU9lTEVNMFVIbGZa?=
 =?utf-8?B?WWIzUHB4NGFXRFJJdHNhSzBOWGl3ZSs1RjA5QWpONUpaLys4SzJ4cGFpUW5I?=
 =?utf-8?B?WUtybG1oaGhZVGNZOTN2Sm8wcXpkdmpFOGJpYno5MFJpVnVheEl1WGhWTFho?=
 =?utf-8?B?Y043U3l1UWx3ZDNiTmhlOFIyZVZwTHZEamdGR05rQzhGUnlHVVRPUWhVdlhv?=
 =?utf-8?B?ajJsc2k1dXA3SHVJZDZoSEprTzR5ZEZhK09DUUNzYmo5Q0N1M2xncXZZU1px?=
 =?utf-8?B?Q3RiZUJrWEhoNk9Ic05HcGozZ2FDT2UyYWszTkI3MXFtMkJ6ZFNBRk9NbGky?=
 =?utf-8?B?L2lFWHZ6SzFmbVNLZlJlRFdGSGcxZVppMUlMR243d0szQlFFRVg0VnYybjcx?=
 =?utf-8?B?QTg1QThPR0hPcExNMVZoMXJGVFRwakpTYzY1emx5SGlXbXl2ZWFGd1VOWlR4?=
 =?utf-8?B?Yy8rckcxTmoza1dFVkFOV1gvVnQyZVNLSUlhUFJJeFJXRExXd0VzZ2FINlJj?=
 =?utf-8?B?QUR4eS9YWFhRZzNZV0I5Z0JOTllKcGZwOFlWWGdjUzg4bkszQmc4QVVHL3ha?=
 =?utf-8?B?MVdpdHZEMDlzYW5iWW1BQ2dBNS9LWlhoRzN0aFBhcy8xYW5iZnBMVU8rL3FJ?=
 =?utf-8?B?ckdiUzB6V0ZQT3A5MGlnUk1laG1IaUxDRDlyOWhlbXRqOC93Nk5QOHl5VU1k?=
 =?utf-8?Q?er5PpChDDTNI8LSh8D+v6kE=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d42b83-766c-40ae-5d5a-08ddca18c3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 18:43:07.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wl2TIBwJxpUBRwYSkDClKPUHeJPN9lZ3PRxGdjYB42GeoCOXcFWGY8BFmyZRvJegHR2Ot+lvvNmnhYaXVfgahg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5804
X-Proofpoint-ORIG-GUID: PYLl7W7h6NRWlyZvlGmyQJX1c95evNkH
X-Proofpoint-GUID: PYLl7W7h6NRWlyZvlGmyQJX1c95evNkH
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=68812d3e cx=c_pps
 a=lUYDfCFJ8uif96mLs61nOg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8
 a=YqfRdqakL3QWTn8MrhgA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE1OSBTYWx0ZWRfX0LQo7P+Nz1nY
 Xb7N0K9kU/oEZUEfb9O4LR04lEgTRcRREK4MGtebZf6lDFom0lQRpPj2j3m/spDLPeocRAAKgZA
 nHagD2+2s0/jNcRA9IAFrvTXN9+xsr/BTUngM9DPvIc5kzmw4rhKXjpyNZb8sfix/2S8toz8hRN
 RP+fHlr1ryEErqnqDbWB+OZizIvuA2+0QhxjHXbdmkoTcLLSDkoZrPgC0dVy+Qi6RKpwu/jS3gp
 nZPIac4Cc7AVv4zZASVnUPbU4RKCuj5Z0jVSePzTO2X8zSxieD5JVvkfs86fbaBnKaY8C2SY5cJ
 vj6pv7TjVPR7Tkif1Nnqqcv66j1+UwB0AhQggS6981SIdzjQWuevpkARqe9POJYQxEGd9YmNjRv
 b2zpxLmLPUXiRGpMAZA4OPvQsGr+R8Vb3VOCLfzecYuNjBTVpZQixFFVRgMliqEZsDhIn+/0
Content-Type: text/plain; charset="utf-8"
Content-ID: <978EFF04F927A0489634EDB32744ABE1@namprd15.prod.outlook.com>
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
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507230159

On Wed, 2025-07-23 at 18:19 +0000, Viacheslav Dubeyko wrote:
> On Wed, 2025-07-23 at 11:16 +0900, Tetsuo Handa wrote:
> > With below change, legitimate HFS filesystem images can be mounted.
> >=20
> > But is crafted HFS filesystem images can not be mounted expected result?
> >=20
> >   # losetup -a
> >   /dev/loop0: [0001]:7185 (/memfd:syzkaller (deleted))
> >   # mount -t hfs /dev/loop0 /mnt/
> >   mount: /mnt: filesystem was mounted, but any subsequent operation fai=
led: Operation not permitted.
> >   # fsck.hfs /dev/loop0
> >   ** /dev/loop0
> >      Executing fsck_hfs (version 540.1-Linux).
> >   ** Checking HFS volume.
> >      Invalid extent entry
> >   (3, 0)
> >   ** The volume   could not be verified completely.
> >   # mount -t hfs /dev/loop0 /mnt/
> >   mount: /mnt: filesystem was mounted, but any subsequent operation fai=
led: Operation not permitted.
> >=20
> > Also, are IDs which should be excluded from make_bad_inode() conditions
> > same for HFS_CDR_FIL and HFS_CDR_DIR ?
> >=20
> >=20
> > --- a/fs/hfs/inode.c
> > +++ b/fs/hfs/inode.c
> > @@ -358,6 +358,8 @@ static int hfs_read_inode(struct inode *inode, void=
 *data)
> >                 inode->i_op =3D &hfs_file_inode_operations;
> >                 inode->i_fop =3D &hfs_file_operations;
> >                 inode->i_mapping->a_ops =3D &hfs_aops;
> > +               if (inode->i_ino < HFS_FIRSTUSER_CNID)
> > +                       goto check_reserved_ino;
> >                 break;
> >         case HFS_CDR_DIR:
> >                 inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> > @@ -368,6 +370,24 @@ static int hfs_read_inode(struct inode *inode, voi=
d *data)
> >                                       inode_set_atime_to_ts(inode, inod=
e_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
> >                 inode->i_op =3D &hfs_dir_inode_operations;
> >                 inode->i_fop =3D &hfs_dir_operations;
> > +               if (inode->i_ino < HFS_FIRSTUSER_CNID)
> > +                       goto check_reserved_ino;
> > +               break;
> > +       default:
> > +               make_bad_inode(inode);
> > +       }
> > +       return 0;
> > +check_reserved_ino:
> > +       switch (inode->i_ino) {
> > +       case HFS_POR_CNID:
> > +       case HFS_ROOT_CNID:
> > +       case HFS_EXT_CNID:
> > +       case HFS_CAT_CNID:
> > +       case HFS_BAD_CNID:
> > +       case HFS_ALLOC_CNID:
> > +       case HFS_START_CNID:
> > +       case HFS_ATTR_CNID:
> > +       case HFS_EXCH_CNID:
> >                 break;
> >         default:
> >                 make_bad_inode(inode);
>=20
> I have missed that this list contains [1]:
>=20
> #define HFS_POR_CNID		1	/* Parent Of the Root */
> #define HFS_ROOT_CNID		2	/* ROOT directory */
>=20
> Of course, hfs_read_inode() can be called for the root directory and pare=
nt of
> the root cases. So, HFS_POR_CNID and HFS_ROOT_CNID are legitimate values.
> However, the other constants cannot be used because they should be descri=
bed in
> superblock (MDB) and Catalog File cannot have the records for them.
>=20

I have checked the HFS specification. So, additional corrections:

#define HFS_POR_CNID		1	/* Parent Of the Root */
#define HFS_ROOT_CNID		2	/* ROOT directory */

These values are legitimate values.

#define HFS_EXT_CNID		3	/* EXTents B-tree */
#define HFS_CAT_CNID		4	/* CATalog B-tree */

This metadata structures are defined in MDB.

#define HFS_BAD_CNID		5	/* BAD blocks file */

This could be defined in Catalog File because MDB has nothing for this meta=
data
structure. However, it's ancient technology.

#define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
#define HFS_START_CNID		7	/* STARTup file (HFS+) */
#define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */

These value are invalid for HFS.

#define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */

This could be defined in Catalog File (maybe not). I didn't find anything
related to this in HFS specification.

> Thanks,
> Slava.
>=20
> [1] https://elixir.bootlin.com/linux/v6.16-rc7/source/fs/hfs/hfs.h#L41 =20

