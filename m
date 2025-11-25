Return-Path: <linux-fsdevel+bounces-69837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB69C86BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EBB3B053A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F268333423;
	Tue, 25 Nov 2025 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bd3DrFdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E7287247
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097353; cv=fail; b=SO6V471q4gGd66D+YuvK0OVbdNUnsKur/59K+wCPtmcfmMeW/5XTUPu+b9ZLU8WJ8qFEXQ9CXZBgKIoOXdL2Y4ojc9woiNEee/+zq+SH+zTLzMfvHRf5HKTqJOfFfSmo/67ED9qM90T8/Mlqz1BdHYCq8gJOYFTEfUQxfRARwSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097353; c=relaxed/simple;
	bh=9KwEUycpYzfc4Xl+3kHb2nY83VeEJ+dINKiUxg6lQps=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=JrWkKsjcGK5kqu6vBd1vePZUEnPoY6qzPv6vl3ZenFD2kywdYVQpL5kaj70OYwL6dz+1JWX53pBkmtcQ0mR3BVXYeK3Lgzq3zjjOuYgWjEbdv7lRBhfZik3E9fliFG84QpJAiIz9gAGmnqmWNHufgR26mlRhDdsg3ak1HeqXKkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bd3DrFdb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APCFJ3i023916
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 19:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=u28Nx2ygsZWE+D+pHkda9wgwnFmeOAuJxV5sJzLW2vU=; b=bd3DrFdb
	VeedmOh+44TZjy6QMw3pLI7nOBesF214uy/whUQr/Go1rovo7BrlAl4+XUzK97WA
	58JAqrcuqRE5ZpzFFpSoj6DgLVgmUMsXEIwGIt3eYQe5XV0Rn5glP9uhUePeMvYY
	2NTru+RvAQC07Pgq2THGQowh7oXNrdYVkywi3i7Z1C1aPoArwj5snuoNmS/KZdy4
	eR5bv76u5L/1lvApoHa5WjemCzjpmkG7+3suid++dsdQprnCrncf8oUTVmqIL49X
	hUyyz9EYjxWkRqx6jRiAiXMf0WIQFmVtiKjo820nQG3FGzVmJBful6Z8C4eyPxdJ
	6HUXxH0N42uQ/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjxy1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 19:02:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APJ2UxI018311
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 19:02:30 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjxy1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 19:02:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJWjgejj0W6DzAraofAv4wEGZAiCGH1OtwpPw7BWqmYuVPSf7poymDRXdhXZq341upCiGxxcYGdo5A1UV5H7RNUyEVxhzwfuBRakX36WQgqM0pktkshplLZaIOtJAT01MQnFHQYV+ZP9taFx8IPniYJselwT1BzXR6+M5btpvEUDnf5OPwL619AqzGfKSpg4JAXpAm38z+L47BwP0IwpafwtuUY9S4kQXIc9d9nEU0PbQjshjkUQM3lUe/8hvGu7Kp6110Mr34k1DitZVvxChfp78VfR1wpFFarh155vzphq9trx8Z3Wp3YQItCjqLOyO3hkld53ccvSzVUQb5vZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz2iXjOcrQ1R1WlMn3LCFtEK1rIs8ymKJawwz2CHuFI=;
 b=qjy4vNlmryx3buJICuL4unYvcKtGOYorvhL2jBa99Uw3I5pA6U+2C7om4BRvZHiqICQzKyV0+jQNWaFqr0/Tx0YeJnQvcGUFxXxpmAPOl2AqgmPZ1aGAodCiZTidukh4C6gSL2YGjBijzBaI7dm4aeZ36U4CeffGBC4SJa8KPls3ZcBHqwFSzhJ0jQudjpvsIbKf+31Y2drQCzyWEYBNeDKrjZ+30QmQWNdnKKH8kJFC39Vvd+vuB6zUlUzPxZPlp+z8enOAaA1m1h9kWzsIM/nL6+bHah1TjKQhAUjoR5C2t1eA00ncOJDiKqSN+nTHUG8AwI7Z0HqniekU13JC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5128.namprd15.prod.outlook.com (2603:10b6:510:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 19:02:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:02:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] hfs: Validate CNIDs in
 hfs_read_inode
Thread-Index: AQHcUp5BSokm2L2+yEOPPOOLb835xbTspIuAgBXa3oCAAVdsgA==
Date: Tue, 25 Nov 2025 19:02:25 +0000
Message-ID: <4ffa2a87db8520af687f38e54f57bb0b3ddde6c0.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
	 <e13da4581ff5e8230fa5488f6e5d97695fc349b0.camel@ibm.com>
	 <aRJ8uYyD0ydI8MUk@Bertha>
	 <10acb67e66aa0b05ef2340178e761bafaab20af9.camel@ibm.com>
	 <aSTdK2m2TInzWW6_@Bertha>
In-Reply-To: <aSTdK2m2TInzWW6_@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5128:EE_
x-ms-office365-filtering-correlation-id: 061c6bc4-3e24-4fb7-2507-08de2c552c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1BRNDZZY2tLZ0tnT2IwVHl5bVUxSHcvL3U2WDdLMmJRYU5uaHlNUFlwTW0y?=
 =?utf-8?B?T21qSkhQNDVMZjNObE5WMVVJcVNtNzUzcGFvYlRoZGJkZThXSTBCblFjVUl1?=
 =?utf-8?B?WTA4SkRUNkR1RS8yUStINzUyQ3MwUk5ZS29UOTBSczRrUkdQeGNJaEtwYW11?=
 =?utf-8?B?cU5SR1NxelZUd1h6ZWU4UEw3NkhIOWtmU3FNNFdLQ0dPaGZhSEZVNU9KU3JT?=
 =?utf-8?B?M01jUzNMQzlaOGpYZlZOamJ3SFZBTXZiUnpGWjJneXBuZTZPdGYyRUlXdWdL?=
 =?utf-8?B?YnRGZUdqRDloTHNZYnl2MldERGZ1NFJZUGlIWWdKekF1dVRSaUZUNDI2eVZM?=
 =?utf-8?B?SzRQTlhTRkRyWXpVbC9rUW43VUlKSDZZWnpkWlhFSVlaTDB0TXk5WWZEV3Ir?=
 =?utf-8?B?Uk14eWVCcmZYWXBSaGVob2RUY2dkNGxEWTBQUXZPYVpkdWRvNEk2VldsdG0w?=
 =?utf-8?B?Z2ZQNHRoS2xHRUFFQnhXZnpadU1FYUxhMU5DSE5vMU0zYnd5VWtnNGszNXdp?=
 =?utf-8?B?c091N015S1dxbUpaUjQzQjZ2eGJyYXdxaDlRU1RUdmRlYjFHZGZZMmFsdGJC?=
 =?utf-8?B?akNvLy9ZOC8ralBiR0dWcHUvSUlSQ0txdjhpRklEaGplcmRuUGxScWVIOTEz?=
 =?utf-8?B?YkFlTGp2cVFmTkYyOG9FVmpVb29LUkRFVldSYnRYWGtLMDNtSHNVWnpVZHhQ?=
 =?utf-8?B?RXZVVWdYRG94NHNrSUZuemZyRFI4Z3QrYU92WEhYNjdaWHlGdWVDbHNGUkJD?=
 =?utf-8?B?R2gwN2VrQnpOL3lmcWJGSENzQWVscExpUndmNE5sbzdJZEVuckQzZkYvTktq?=
 =?utf-8?B?dHpHUDcrSG14cXZsTy9QUEU3Y2hOYjhSaDhRT2t3TWFhQXRPTkpsN2ZXVUZJ?=
 =?utf-8?B?VFVjKy9ER2M3OFlyTHliSHZTOXNRZHZzRytiM2xhVHV6ak5pNWNISU1uZ09K?=
 =?utf-8?B?emJQTERDWElINDVOdnRWSk9VUVJxOXRmNTZMbG53RjRRcERhbTVmanlpTnVI?=
 =?utf-8?B?VERqTUw5WERBR1I1VE9RUlg1WnVNUit6ZFA2SW1odG93dnlRekZCaXhmWlBk?=
 =?utf-8?B?cCs5U0NnMWJMMGUyNzgvZHF5RHVsVFpDK3BDWTFNNzlPSDR2aWZvU2ZWVUlW?=
 =?utf-8?B?elZxeitjMEJSRXNVcVpxOERDU3U4eHhxelp6bGlmYVRLdVB3TmJSMWdtLzBN?=
 =?utf-8?B?dzJCQmFlWFJ0clNQbmFqQWc2ckFVbWluVC9JZTFsUmp0cWlBVmUwUExOb2Qx?=
 =?utf-8?B?SmlmZ01KajFmM3J2YlVoMkNhbThDRVJPZWl2R3hpbVJzMXBwbnViU3FwY29s?=
 =?utf-8?B?MThqcDVQVzBSdWE2ODZsVEt1NFppWE5UeXIyZ2VrelJkbFgwcG9xV1RLcVlL?=
 =?utf-8?B?UGh3YldDNmlHR2FJK0Y3WGhrT0dnRzE3UXRRc2RjQXIxY1NZVWJUemdHdnoz?=
 =?utf-8?B?YjZRTjRRd3FnUXBuTmxTakwyVlNBVTM1RStpYzRYY3BXaW9jMHFZUFNpSVdy?=
 =?utf-8?B?V0lRdmw5ZVp0TEdmYnlNQUVIMmpnU1RUeDJ6b2pwYytEM0x6NllBWlJWOVBO?=
 =?utf-8?B?cFVmU0lZVUFQa01yRnZhR3N0MHdSQk55Vlc5dmlvVHZkaXpZNkIrb2Q1cStO?=
 =?utf-8?B?akdnd1dXYk80NjB5cFBRNkt2azI3MGt4WjlyZUdTUUhydXZJem5nQjNNYTM1?=
 =?utf-8?B?YWFwOHJOQ2xJTEo5SlBhd2JHZCtzbFpXMEdVVFYxUlBOcm1RTVU1ZWdCWlVr?=
 =?utf-8?B?ODl5WmRNK3RNRXU4S05PSUU3VnpEdTg2bXBuZEtlUzJVYi94MXhxd0l6MVJt?=
 =?utf-8?B?dkhLdlkxUjlBZHVNTWp5dUR0Y0VsL0NHclM1cVpHRFovVG9lT0IxZDlhSDho?=
 =?utf-8?B?cE1XZkhSUFhRODFReENNTk5xWkNTbnlzZ2lCVTJoak1INmU3SHdubUdWaU9R?=
 =?utf-8?B?cUFSQzFwZmJCUEt0aTRuMlR5YnNmVlY4bmVla2JCRmo0VFROOWlvZ2FqV1dv?=
 =?utf-8?B?L0k2VW92SlpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGlMaWxaQ2JwNTc5MFhrQjREanQwOFhiSzhlSWtScUJHOHhsZy9CbHVkb1Nz?=
 =?utf-8?B?aHBKZG9ESlFPMUFLdVJ0YmIzbk1pSDBXR2ZJbkhKaHJsdEhpTjB3eDZ1aklM?=
 =?utf-8?B?Q3BtRHhlalFIV3FpVFduckplbDVkeE5IbTUrNGgyNU1WVm55MmMvclZveHF4?=
 =?utf-8?B?QjJ1M2hKeFJvam9iNFdXaU43bVlucW8vVW15ZTNpV0c0bzErRFVxSDExNElN?=
 =?utf-8?B?SWMvWVhIUkx1MXcvelRycVNGMDhxczBWSUFkMDRjYWg3T2pTaFp1MG9FWDRI?=
 =?utf-8?B?bnhqdWwyaWhPM2hnWTF4Tk50cWFscmpXZkFicmwydmo2OExwdWpXM3Z0SFBC?=
 =?utf-8?B?WnphWjAvUEN5NnFOY0g2aW5uOGY0bFJhQWFoUFNoT2lhMVhUUmVtK2ZoTU5v?=
 =?utf-8?B?MnM1ODJ4dncrMnAxTTFHbjIvT0l0UFN5TCtiMk0xOXlvOUtUZ2JDcVpucFBP?=
 =?utf-8?B?R0lCZDVPS2VXenljVldsMVRLSHNQY2VGajFUaE1KM05xUEZmdXMyKy8wa2Qw?=
 =?utf-8?B?bEJrWG5yb3ZncVN4U0g4KzBGd0V1b2VGQmcxZVg2Wk5DWGJVOGE4UFE5eTFh?=
 =?utf-8?B?WFlDV0hsSUMzem9yaVBHb0wzeGtwZ09RQ05LNHBoTHBrNGN5VVBZY09mVWV6?=
 =?utf-8?B?am9aTUk1ZmViNFJWbFZNcW00ZVpkVzBrbjdDMmRDM0t6ei9TcmdmcWo2R3BD?=
 =?utf-8?B?NHI4NytKSlBRc3UrRGdOSnMxTTBpdFlPVzJ1bG1ROGlMaXM0QW1ncTcyekIr?=
 =?utf-8?B?MHRlemMzV2htYmRSK0NkM1gxUGQ1b0NjenFJRXNHZlNHVGlJSW8waTNwUGU3?=
 =?utf-8?B?TFlnVTZhODMrTFNOQldNdnhaTkFFM2VKSmJrNW5POHp5TkF3SXdvUklWb1RU?=
 =?utf-8?B?U1R3ejJGVXp3eWE4RDF2MklyN2FsQkpKVW51NXNEMUtCaEdJUW13Rm5mTmRB?=
 =?utf-8?B?V1FVQjk5OEJLTDhBRzJLQmpra3doNTZheSt1WTJyZ1d3RTJMWTdYcCtlNCtV?=
 =?utf-8?B?SDRWQ1FuWEN3aW1PNUIxS2YrQkNPcDR5enZUcVpNNFhQbDVNOVg3YkZhay9J?=
 =?utf-8?B?OE9TanZwaDR5OWZLUE51RkE0dXBhSFNnZ2l0Z3NTSFYybHhONXVZOXJQbTNQ?=
 =?utf-8?B?Q2FrQ3NTcHBPZmF4ZWxHRERDRFBHSitBc1BkbFIzdm5ISUowSVhkc2t2aCtu?=
 =?utf-8?B?TXdpVE1hVSt0dEV0MHdxQTl0OFRWb05DL2FrMWExTlBHYUJjeE9Fek0rQmtB?=
 =?utf-8?B?ZEJ3L1V3S3pZZ0FJMDNDMFVZS09DWXExeDJIdDUwTmtKRE56ZEZWUk1lWUd0?=
 =?utf-8?B?dzU3dkUrRmp3V21wQmQrcG1TWFgrODhySFp3dDJoS2I0UGZXUGk4eU80K01B?=
 =?utf-8?B?bjc1UE9hbnBOdm9sTTVsbDNtbXM4Wk1VZ2UwV3ZUVk5uYnNPb2Rmd2s5L2lV?=
 =?utf-8?B?eS9EMDgzQjdFWmE0V3JMNVM0eEhhaGtLcjVpd1FUY05vQUt0K2xyMkRwMkQr?=
 =?utf-8?B?a1ZBQkVVc1Vpdy8rWXQ0RzgwMnpmd2F6NTNSYWJKdDMySUttdHZJK2lEclpH?=
 =?utf-8?B?V3ArUVNkVEJXdmpGWUpwV3hQM2ZyVURwdCs5TXhaVTR4cEE0TU9UUUZUZ3Mv?=
 =?utf-8?B?NHFOMWdMeUdBckpUT3QwNE9QNndFZkJJYXl4T0prZytvNWFwTENFbTFKYWQr?=
 =?utf-8?B?MWtGWDNSdTlDdCtDTDlmZUl2ZGw1TzlEaHdSbUZId2NrUFZCQjEwY0lZOTFy?=
 =?utf-8?B?QUVBMGNCeXpSRXFvbWFFdXlMRjZnM1FaWURrT3ErNm1uV0hlSU9kZlowdEtt?=
 =?utf-8?B?TTlhQ2pjbjE2cjVWa3JNMS9Db0xpQXBqZVJld2I3YWJmRFpxZGxEQUpHZTg3?=
 =?utf-8?B?UEt1RzlJQXNKRDVFRklWR0dTVitZMU1lVDN2MEwxVDZZS2VYTnN2V1hlbnJR?=
 =?utf-8?B?UXA0ZmdDVG1uOFR4U2cwS1VnWTJCQ2pRUldEQzBBTXZHTGI1Z0ZUaDlJZHlD?=
 =?utf-8?B?bGswV3M1cldPRFg2RWZaTGI3bTNiTW1jeDYrbFJtMkdYdjZ3b1RoUW5yemFv?=
 =?utf-8?B?NUtBNFNVcXRlYXZNU1JnRm1iUlpzV0NMMXdzWFgyeWtJUmt1Si95Vy9mNFJ5?=
 =?utf-8?B?UFlOb2NtYWdTZlh3R3ZYcm1iYlQvZG8xWlR1N0ppVWE5T09KSFBjd1pQWHhl?=
 =?utf-8?Q?Rq03i4TMWGBLU1RqtW4aXyA=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061c6bc4-3e24-4fb7-2507-08de2c552c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 19:02:25.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiPwEL96d5SOSDMFJszEn359c38CgVuXkF8WNSw4MIhg/ls8byg0YK2GBBLJ7Fwss/n0JWzw+G9vIggVqcqL0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5128
X-Proofpoint-GUID: bBJ1qoa7mcTAb0OyuyLSrD1jjwbEOXsP
X-Proofpoint-ORIG-GUID: bBJ1qoa7mcTAb0OyuyLSrD1jjwbEOXsP
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=6925fd45 cx=c_pps
 a=WMD2V7/OXcB8V+UEbxscyA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=3HEcARKfAAAA:8 a=bEbQfPWKLYVd5IIakzYA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX8AwDMQw8OPYc
 A/FsT/Gg7Bi/owUgHTI/sTlGZU6XlsvQ3DPj+q/FR05zCP0sqGbnl+kLkJPWv2dlDWmCwWTAcmJ
 6LEjM3mGuejPPakW74V0Ff5DOd83kWFIxqtH51H6ajd0nA22IlcI89/5A6PE5C8z0/K01VPuYTe
 KhATPY3+wKmMOzkL4f+21hf9vqJGTCL86KF1GtNrqgpBcX2CG95Ek7mJsJ0GPzoaOC1q01uZWpm
 7CutuERekVMhj4sVZaCXZUWj3+862D4c5e5cJQ5HttyZyPKYNLQsMsufPQ3lgTMLf28VUvp97j0
 LuJte+/OyxLnA7115WlrZ6bGa80LuMjUkM8mUD0UQbkvgTINKVfXWYEgEgJ3wBcdHerGZLsetLo
 T/a3g8pJ39ncjTyLenjm/xR8+XWosA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D59EDEAC3FA0894FA54044E5FA4830AA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511220008

On Mon, 2025-11-24 at 22:33 +0000, George Anthony Vernon wrote:
> On Tue, Nov 11, 2025 at 12:48:28AM +0000, Viacheslav Dubeyko wrote:
> > On Tue, 2025-11-11 at 00:00 +0000, George Anthony Vernon wrote:
> > > On Tue, Nov 04, 2025 at 10:34:15PM +0000, Viacheslav Dubeyko wrote:
> > > > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > > > hfs_read_inode previously did not validate CNIDs read from disk, =
thereby
> > > > > allowing inodes to be constructed with disallowed CNIDs and place=
d on
> > > > > the dirty list, eventually hitting a bug on writeback.
> > > > >=20
> > > > > Validate reserved CNIDs according to Apple technical note TN1150.
> > > >=20
> > > > The TN1150 technical note describes HFS+ file system and it needs t=
o take into
> > > > account the difference between HFS and HFS+. So, it is not complete=
ly correct
> > > > for the case of HFS to follow to the TN1150 technical note as it is.
> > >=20
> > > I've checked Inside Macintosh: Files Chapter 2 page 70 to make sure H=
FS
> > > is the same (CNIDs 1 - 5 are assigned, and all of 1-15 are reserved).
> > > I will add this to the commit message for V3.
> > >=20
> > > > >=20
> > > > > This issue was discussed at length on LKML previously, the discus=
sion
> > > > > is linked below.
> > > > >=20
> > > > > Syzbot tested this patch on mainline and the bug did not replicat=
e.
> > > > > This patch was regression tested by issuing various system calls =
on a
> > > > > mounted HFS filesystem and validating that file creation, deletio=
n,
> > > > > reads and writes all work.
> > > > >=20
> > > > > Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c=
4ae5b@     =20
> > > > > I-love.SAKURA.ne.jp/T/
> > > > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae80=
3d21b     =20
> > > > > Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > > > Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > > > ---
> > > > >  fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++-----=
------
> > > > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > > > > index 9cd449913dc8..bc346693941d 100644
> > > > > --- a/fs/hfs/inode.c
> > > > > +++ b/fs/hfs/inode.c
> > > > > @@ -321,6 +321,38 @@ static int hfs_test_inode(struct inode *inod=
e, void *data)
> > > > >  	}
> > > > >  }
> > > > > =20
> > > > > +/*
> > > > > + * is_valid_cnid
> > > > > + *
> > > > > + * Validate the CNID of a catalog record
> > > > > + */
> > > > > +static inline
> > > > > +bool is_valid_cnid(u32 cnid, u8 type)
> > > > > +{
> > > > > +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> > > > > +		return true;
> > > > > +
> > > > > +	switch (cnid) {
> > > > > +	case HFS_ROOT_CNID:
> > > > > +		return type =3D=3D HFS_CDR_DIR;
> > > > > +	case HFS_EXT_CNID:
> > > > > +	case HFS_CAT_CNID:
> > > > > +		return type =3D=3D HFS_CDR_FIL;
> > > > > +	case HFS_POR_CNID:
> > > > > +		/* No valid record with this CNID */
> > > > > +		break;
> > > > > +	case HFS_BAD_CNID:
> > > >=20
> > > > HFS is ancient file system that was needed to work with floppy disk=
s. And bad
> > > > sectors management was regular task and responsibility of HFS for t=
he case of
> > > > floppy disks (HDD was also not very reliable at that times). So, HF=
S implements
> > > > the bad block management. It means that, potentially, Linux kernel =
could need to
> > > > mount a file system volume that created by ancient Mac OS.
> > > >=20
> > > > I don't think that it's correct management of HFS_BAD_CNID. We must=
 to expect to
> > > > have such CNID for the case of HFS.
> > > >=20
> > >=20
> > > HFS_BAD_CNID is reserved for internal use of the filesystem
> > > implementation. Since we never intend to use it, there is no correct
> > > logical path that we should ever construct an inode with CNID 5. It d=
oes
> > > not correspond to a record that the user can open, as it is a special
> > > CNID used only for extent records used to mark blocks as allocated so
> > > they are not used, a behaviour which we do not implement in the Linux
> > > HFS or HFS+ drivers. Disallowing this CNID will not prevent correctly
> > > formed filesystems from being mounted. I also don't think that
> > > presenting an internal record-keeping structure to the VFS would make
> > > sense or would be consistent with other filesystems.
> > >=20
> >=20
> > Yes, we don't want to use it on Linux kernel side. But, potentially, th=
e file
> > for bad block management could or was been created/used on Mac OS side.=
 And if
> > anyone tries to mount the HFS volume with the bad block file, then we w=
ill
> > refuse to mount it on the Linux kernel side. This is my main worry here=
. But it
> > is not very probable situation, by the way.
> >=20
> The mount operation only requires reading the root inode, so the
> proposed change does not mean we would refuse to mount an HFS volume.
>=20
> It is okay if HFS_BAD_CNID already exists in the btree, we simply won't
> ever try to read or write it from disk.

The function is_valid_cnid() doesn't limit the context of it using. Logical=
ly,
HFS_BAD_CNID is valid CNID because the record with such CNID could present =
in
Catalog File. And if anybody tries to use is_valid_cnid() for checking the
Catalog File's record (for example, during traversing the Catalog File's
content), then this record will be treated like corrupted with current
implementation. However, it will be not correct conclusion. I am trying to =
have
logically correct function here that can be used in any reasonable context.

> > > > > +	case HFS_EXCH_CNID:
> > > > > +		/* Not implemented */
> > > > > +		break;
> > > > > +	default:
> > > > > +		/* Invalid reserved CNID */
> > > > > +		break;
> > > > > +	}
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * hfs_read_inode
> > > > >   */
> > > > > @@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode=
, void *data)
> > > > >  	rec =3D idata->rec;
> > > > >  	switch (rec->type) {
> > > > >  	case HFS_CDR_FIL:
> > > > > +		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
> > > > > +			goto make_bad_inode;
> > > > >  		if (!HFS_IS_RSRC(inode)) {
> > > > >  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
> > > > >  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> > > > > @@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode=
, void *data)
> > > > >  		inode->i_mapping->a_ops =3D &hfs_aops;
> > > > >  		break;
> > > > >  	case HFS_CDR_DIR:
> > > > > +		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
> > > > > +			goto make_bad_inode;
> > > > >  		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> > > > >  		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> > > > >  		HFS_I(inode)->fs_blocks =3D 0;
> > > > > @@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inod=
e, void *data)
> > > > >  		inode->i_op =3D &hfs_dir_inode_operations;
> > > > >  		inode->i_fop =3D &hfs_dir_operations;
> > > > >  		break;
> > > > > +	make_bad_inode:
> > > > > +		pr_warn("rejected cnid %lu. Volume is probably corrupted, try =
performing fsck.\n", inode->i_ino);
> > > >=20
> > > > The "invalid cnid" could sound more relevant than "rejected cnid" f=
or my taste.
> > > >=20
> > > > The whole message is too long. What's about to have two messages he=
re?
> > > >=20
> > > > pr_warn("invalid cnid %lu\n", inode->i_ino);
> > > > pr_warn("Volume is probably corrupted, try performing fsck.\n");
> > > >=20
> > > Good improvement!
> > > >=20
> > > > > +		fallthrough;
> > > > >  	default:
> > > > >  		make_bad_inode(inode);
> > > > > +		break;
> > > > >  	}
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, st=
ruct writeback_control *wbc)
> > > > >  	if (res)
> > > > >  		return res;
> > > > > =20
> > > > > -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> > > > > -		switch (inode->i_ino) {
> > > > > -		case HFS_ROOT_CNID:
> > > > > -			break;
> > > > > -		case HFS_EXT_CNID:
> > > > > -			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> > > > > -			return 0;
> > > > > -		case HFS_CAT_CNID:
> > > > > -			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> > > > > -			return 0;
> > > > > -		default:
> > > > > -			BUG();
> > > > > -			return -EIO;
> > > > > -		}
> > > > > +	if (!is_valid_cnid(inode->i_ino,
> > > > > +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
> > > >=20
> > > > What's about to introduce static inline function or local variable =
for
> > > > S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL? I don't like th=
is two line
> > > > implementation.
> > >=20
> > > Okay, I will rewrite this.
> > >=20
> > > >=20
> > > > > +		BUG();
> > > >=20
> > > > I am completely against of leaving BUG() here. Several fixes of syz=
bot issues
> > > > were the exchanging BUG() on returning error code. I don't want to =
investigate
> > > > the another syzbot issue that will involve this BUG() here. Let's r=
eturn error
> > > > code here.
> > > >=20
> > > > Usually, it makes sense to have BUG() for debug mode and to return =
error code
> > > > for the case of release mode. But we don't have the debug mode for =
HFS code.
> > >=20
> > > I prefer BUG() because I think it is a serious bug that we should not
> > > allow for a bad inode to be written. I am willing to take responsibil=
ity
> > > for investigating further issues if they appear as a result of this. =
Of
> > > course, the final say on BUG() or -EIO is yours as the maintainer.
> > >=20
> > > >=20
> >=20
> > The hfs_write_inode() will return error code and it is also bug case. B=
ut we
> > will not crash the kernel in such case. Why would you still like to cra=
sh the
> > kernel? :)
>=20
> I would like the kernel to crash so that a bug report is made and I can
> fix it, rather than something go wrong quietly. My logic about that
> could be wrong and I'm happy to return error code as you prefer.
>=20

The hfs_write_inode() will return error code and it means that request fail=
s.
Finally, kernel code will complain about it. You can add pr_err()/pr_warn()=
/pr_c
rit() message if you like to be more informative here. If we follow to your
approach, then all error codes in hfs_write_inode() needs to be converted i=
nto
BUG_ON(). But it sounds really weird to me. So, if you have error messages =
in
system log, then you will have the bug report, anyway.

Thanks,
Slava.


> >=20
> > I see your point that we should not be here because we must create the =
bad inode
> > in hfs_read_inode() for the case of corrupted Catalog File's records. L=
et me
> > sleep on it. :)
> >=20
> > Thanks,
> > Slava.
>=20
> Thanks,
>=20
> George


