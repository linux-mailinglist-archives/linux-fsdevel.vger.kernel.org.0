Return-Path: <linux-fsdevel+bounces-56157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACFB14286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F55540D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA527817F;
	Mon, 28 Jul 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MLqt/FlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6481EDA2C;
	Mon, 28 Jul 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731454; cv=fail; b=QfCJgXLhUid2xQXUyAHgh+WrxAYYVLdBk5PXk3uZNswI5jh0SE9OoxyiRd5+NSOvtxZCRFSqH4SE/WnVI/4Jz7CGY47//j2C4nbxgIKqsHa1hKpBID5+pfMZ9mGn2aDA0rtYI9rgjwCaOOc4y/L3SVxE8WMu4oM+zRTrCHj9hpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731454; c=relaxed/simple;
	bh=MBesyPTZVHVgxXYsfIZDhamLT6txjbCK3CgCuCAo0po=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VZn6JMIfEYGQWQzTIIaIvfze6ZAzXviR5bz19p/o20LRBxRtEc/oqIS78WDHqGOAb/zgUnLz1/jutrXn7Hgqaf7eXCp75KOJz4rvfUCBGX7T0hKrk0QHyfw7M8iX6rkWdQvD4otgqtMpqDQGbUJVBgGdykn8uIjFjGeCupFxPVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MLqt/FlZ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFo4gf010113;
	Mon, 28 Jul 2025 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MBesyPTZVHVgxXYsfIZDhamLT6txjbCK3CgCuCAo0po=; b=MLqt/FlZ
	h8ezBxb3UdmvmRz9ZQc68W25aIvm5eQ7tBFS+rVO2Eo6LAGO94bBJwXQ3UNXxePG
	h0b6IztL1CMQ0/giYsUAMzFg3hmGZfBfc9/ukrhqjYrOJzFAoybzGJbB7LU+XjN1
	S6fFaugCQhfHeWqA/ysTQ+NNcPN5vEvHO8bLm+iOrRZHvWAjDnevw7H78kLf3A9w
	YWqKOOLzdW9PTHJMd8Cs7Tr7/r9nG/vg1lyq57RrNva3b+eqh2/ru3SYxghxggh9
	zqxVnZiKjJ/CAMYTGIhNL/eyr+P57WUF7snWLkoro+PHEgsRcwb96/sbS3uLGKrp
	xbfMbHU/g0almw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hgxmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 19:37:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvI5PnT2poWSuunZDIAPZ3o0j40YSmAhDOLStCIrzSj6IVAVDQtDgP1l69bJTQZ1YEnl/0bCq6kwKnBJoGgRaksfd9veAiDzkkWxIkwZBaV4KfjyBnBs0FyLZ+8pchO/wrLkqh8xd5tbFYeAsrWXECSDBeRYQ+LI52dNOX6gpD5V67Q5ztnvv86JMeOHk8dONyv1xv9+gV/PvxOMS6Pvba8OfKXHRmQRGFbjIikLWC8pTGDiUguh/Btf2I75g9tpYYW+yBr+lrxJeFusuV3Oe7y7x7caEnU/HStjdmtMyGCSScxl2u0sElmaeWEyvjP0kvYICDUiXWTMn9i0I7t9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBesyPTZVHVgxXYsfIZDhamLT6txjbCK3CgCuCAo0po=;
 b=oYx9Nh+8e88+ItZPDskomnvikY3vsi0nzGtePX3HXawBS2ei2S+RLiz8QBpfj43/491EQ3+hOWhlaF/9t2xWSkTor3l7mNhPRppHabX0UM7gI6u+DjyEvP+xwXKjLhFVs6OOfY70V8ekJsdsBsxAmqPF37WnrAzsxLe6Mkzi6on3r5hSzFXFMF726g2FntTvmPgknxaRejh9WHyrt0oLd8CttJhCrkcYR9SvsgDGboKbCK0OPC5GewKPsdxa1zfVKJYtBOLqKqqAW0Qg4/QoScfgpr2iWrdiHRJF8LsJ02NFU8e/FWYAt28eFHjZR03wFMzvHZeuQfQMPer7mX28RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPF1D1D3130B.namprd15.prod.outlook.com (2603:10b6:f:fc00::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Mon, 28 Jul
 2025 19:37:13 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Mon, 28 Jul 2025
 19:37:13 +0000
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
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAIAAzLAAgADYSYCAACXrAIAAFPAAgABSngCAAOLPgIAAREmAgASRPAA=
Date: Mon, 28 Jul 2025 19:37:13 +0000
Message-ID: <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
	 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
	 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
	 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
	 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
In-Reply-To: <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPF1D1D3130B:EE_
x-ms-office365-filtering-correlation-id: 0b48e79d-73c2-4e71-77cc-08ddce0e26da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDdhV2FQQkgwcTFVNlpmQklyUE80ZUxkMzdUK1ZKQzJ0ZFFyRlJzMFdyem9C?=
 =?utf-8?B?ZEszdTJUTk4rY1VrUDJ3Zk1pRkdxTFR5d3VLeXhDTSs3Y2RTLy9JMjliL0JG?=
 =?utf-8?B?YUpKNjl6MWRIOVlEQjU4V3VzMGordHNOa0VJSHJOa0s4SktkVWFrbGRMaWhm?=
 =?utf-8?B?Sm5wNEloRno5NU5jbFBZNkdLWGVkM0ZCbkxoOE05ZEQxNGpkU1Mxa2YvZUgz?=
 =?utf-8?B?NjhoZU90Q21BR2lsUG9BZXFaSGVHWXhkc2Vkc3VlcHI3ZTFBVkFabVlIK2Rj?=
 =?utf-8?B?MkxMUjVLK1pTVlZDOFEyeHAza2ZHb1ppSDJ6UVR1VXRMbU5KQVhDTXlzODA1?=
 =?utf-8?B?TlRJNW95MUg5cnJuVDFqL3V6bUQ1UWE4dHQvT1AvME1XTk9JL2hMRVJKOHcy?=
 =?utf-8?B?dWl0V3Jhd2tOU3drYzVDaUJGV2hVbGpNYzZqVTZJNGRpTGkyNTJtTlcvcHQ0?=
 =?utf-8?B?T1l0bkpsZG1Ra25zTVJsZk9uWDRncGNKS0tnQldYQXVaUEVVS01MOEtwTnUw?=
 =?utf-8?B?VitEVmliZzdVc1FJcnBsRXFGcnZqOXJmZHJTeXB3Tkc2Ty84dlhYSmd6REpY?=
 =?utf-8?B?R3NmSTBIQmk2NndjSERWODZrck1xOXBhSWcxcVBNQ2ZHdTcvOStzTUVraHRE?=
 =?utf-8?B?T3BmRmtqSUxxZ0UycTlwVFZldm5Qdkd6ZHVtVjEzbTRlODJkbTNrYjhRSm1R?=
 =?utf-8?B?SEZRZXVsaENtcGNqRnhTYlVNQkUzZjZNMHZHdDVtYlpsaFNXWHpsZHFMYjg1?=
 =?utf-8?B?YXlMOHNyazBEZzVVVWF5SHJuL1NPeUJYcjh2YnlBV0pwUkNlR2F1RzBjZndC?=
 =?utf-8?B?UHlTbk8rK2ljaSs3Q25zQktFYjJzM0dTbVNieEdRRmg1bjlhK01RbzFWaTBR?=
 =?utf-8?B?b0RUQXBzZGVUNzNoNlRCMGUzOHI2aTcwTWtvQzh5WUwrZ3BtaEUwOE1OWVdH?=
 =?utf-8?B?S2dXVUYvL2VQZXpiRVRGSG91WUV3ek1MSDdVQTl4SzJsMjgyc0x1S0FBWkh0?=
 =?utf-8?B?QWYvUitMV2dvVHA1NHU4K25pYzFCUy9HWHhBR2ZLd2JIMjdvNGJ4K0wzV21B?=
 =?utf-8?B?Y2xQM043WUx3b2hQcXl2TUd4OWhRWUVZNkFGVmlIdjZmUlpCelIrem5QTFpQ?=
 =?utf-8?B?cWNBNjA3L0xrWVROWEVvcU5leVU0TEdKQk1GdCtaOC93NG9hMzhJdzBETlZj?=
 =?utf-8?B?SWtxdTJsOXRENVF5YTUzZHJkY0Fjajk0M3lCWkJhWWlFYUpZTzBGZnR4NUNG?=
 =?utf-8?B?VDNUTFdHSWxCVTR4RzlwTE5oRjJ0WndwYndWUmJ3UktxRFJDamZlZzJUMHBr?=
 =?utf-8?B?QnpraDJtQTlCeElTRFQ2Q0t3RVcvY095bW1rclU4NnBabFJHK3ZXZXJOZ1JV?=
 =?utf-8?B?VTczQkNzQUhrNFF1OVVKNVdoUTVoTWxzeXlHRkJ6TURUSjU4WWZFb0RKTDdV?=
 =?utf-8?B?MXJTS1NhODZBbFRXZ0tBamxEbXZpbVpmelFTUzdyRlAxellGZHpvNGhFMU9p?=
 =?utf-8?B?c2NldWtWdTlEd2EzamxpbW9lRFptYmhWaERENFdVSFZhYVFoaWhWTlI4RXRm?=
 =?utf-8?B?MURJcHFQaDhLQS9vc1lmeHhJZEsydFBVNUp6U0dBc0syQUZ6RXJlNXNFMVhY?=
 =?utf-8?B?UlJMZTNjUjZldXJtTWlZOXYwcWtTWEs0bVJEemt2VUdQOUlSMHJDa3BGL0tn?=
 =?utf-8?B?SW8wTmxiT2ZucWY0T01aZ2NOTUtDZ0taWkJ5NExGUjE1WmIrSlllRGdmMGcz?=
 =?utf-8?B?N2xLYkhUSUdubm5kaWtGZkdyRVRGNzhOZFFtUFhaSms5eEZDcDMxdDdFOWRn?=
 =?utf-8?B?UzBKOWtQS2o2YW9PV3k4RWw2M3BMTXhvQmNKd2NxSWlkd1R6TTYwV3RleWZY?=
 =?utf-8?B?ZlVQbmVuc1JEcitqUGdHWitOcXN3QVJKK2xLb3JtREpuaUlacUxqZTNNNEY4?=
 =?utf-8?B?a0o2ejBPVVYvb0IvMUJualVlNWxSVE1MM1hleWJIb1Rpci9uQzJZWWNwQnZ0?=
 =?utf-8?B?TndNSUhHRmlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnVuQWhNa0VHT3lEK1IyWFpqc1pHc0xCdGF2SXpEUG54M3ZRbHBFblhIR1dv?=
 =?utf-8?B?UGFLdnErTzNob0d1dmZ2MmlFZ24zSDA2UnRFdlZIZVJIN2U2WHlaeG5QVVNP?=
 =?utf-8?B?Q29JRkZNQnhoL3RvdTVxczVUcVQ4b00reklnWmVQeVdRNzNTdjN3NGVwQ09Z?=
 =?utf-8?B?UFNzejMvWU16OE40NmlpSGpTejB2ZVhna09QVVVRZndEL0hPeUtuT21NY1Jm?=
 =?utf-8?B?WnNyNys1QnltRTdLc2ZGdUNaU2VGN2lJYlRNMGNTNWZzdWlFMkNGVzE3NEMv?=
 =?utf-8?B?bWJkMnJyYmVaZ1M1N25LdkNXMjB3Rmp3YmphUCtVZ01PWmhKdW1IVkhGdVV6?=
 =?utf-8?B?a2pFNHc1bWQ0VlIrREx0UGNlUkpWcjc3QjRCRGt4d3JHL0traTlkejNqbFRK?=
 =?utf-8?B?L0I5ZEhLUTM3c24xQ1lTcXhSU1VsNVRlSjF0NVdhUnJYbThUaTBveXBoZTlS?=
 =?utf-8?B?WXhzd21yWjB1RHpsWjVBcHBTbnBwYjN3YnU5REVSV3Z2YTcrc1MzZWJoUUhJ?=
 =?utf-8?B?TDhRZzJiRU1OOGRzZlVQejNDbjBDR003elVtOTNUTm9XYkJLT245Tk4wTXFS?=
 =?utf-8?B?eDdmWVlKdzZ4eEdVd1lhQzVzdXJ3aXNoK1E1VFBXTE9RdWVtY25qanh3SXRz?=
 =?utf-8?B?WFIrb0h3UjljRThmVGlaUzQ0aE1abytSSEdDb0t4MVBQdUx4V0dZR3VxVmlN?=
 =?utf-8?B?MFZIUjV3WE8vMFdWdVcrODB2K05aWDl1RUlsZzdNbTNvRWFvWHo4bnBZK2Fy?=
 =?utf-8?B?TEFpUUtHMEhFWmFMQ1o3Mk5oSURqZnU4aEV5eXY2K2NWSkkzbjV1amhVWTBn?=
 =?utf-8?B?amg4d1FDTUFPck5IL3FnU2hlSk5NYTBXeFU5RG05NWVYdXMxVHYxS01CMTZw?=
 =?utf-8?B?dis2bmdTVTlFMFYzS0RtS1NGM2ZaR29IeUd4YmZyU0lkcEdtc1Q0V3l4dzVo?=
 =?utf-8?B?K2ZZZUg0dVBMVTZwTkNHNkpuZVh4djhvSEF4ZVJkd0hTZ003VGN1UEhOT1dB?=
 =?utf-8?B?WUdUOUVoYUl3ZVdUTDRvU2lLZUtjTmxsbHRYWm1OMjk1RkNEa0MxVWJZem1h?=
 =?utf-8?B?WVNHdFVWNElySk1qSWxibUc0QmYwVzcxemlhNGNHYnY2aWNQVldXMGhyUE1q?=
 =?utf-8?B?R1hTNnBtNDNGZVJ5bDU4S0p0SlppNFBCem1iRHM0UzFra3o4UWtXSStOMDBv?=
 =?utf-8?B?N3BIKzFyUlBjUk11eVVOMVRuMmd4MGF1MEpMb3ZLbmxaZFNDNkEzd3JzbDNL?=
 =?utf-8?B?NDVCQkRUR2sxK3pTUkN0Zy9OZDJ0K1JHUXJVRi92cUFEMDdWdDgwb3pXK2py?=
 =?utf-8?B?Y2VHSmRHV3R5RFFNK0k5Rjd2WEY3dUt5b0xxdWZuTDZZb2VpSUZ2M0pyMW5W?=
 =?utf-8?B?dy9jNExIVkZnb1VIcnZnVVVTbG5wTGxWU0owNGZ0M2RjdmVWOGdJTVBKOWpG?=
 =?utf-8?B?U2RqNURVRHJ5UnlGdmhCT2dldUlyaG9YWCtxZXBjd1doZmcrbTd4blRFcmdk?=
 =?utf-8?B?SmROUXY0ODZ1N2dORXdwMkhMem5IUXF0L2NMZnBHU0JPNk9VMEFtS0p1cGli?=
 =?utf-8?B?dy9QRTl4T05PTzdibk12VHowUkVjOXYvcEJicUV0V1lHdEJsZUpnUnJMeDNL?=
 =?utf-8?B?NitSZXBLZFhlMGdLb0FzUkkzM3lYN0ZBOVNCaXNmREtLaGkrUkxxNTg5VTFl?=
 =?utf-8?B?M3VpSnliSmJvUjNpdExmaUVYMEZ6TEVsaDJQVnFVS1FicWpVcFM4bG1WZE81?=
 =?utf-8?B?MlIzeWF4UXEwS2lqb1cvZzBSdlBwWkNIZ2VQcUVURmp1YjlxSWtiOVEvZGNl?=
 =?utf-8?B?eUkyQS9PanVIRVgxUDRpZHloVHNQcEZ2WG0vWXMzcktsYkFoaGIyR2trTDhS?=
 =?utf-8?B?Yko2eHpFN0JCNjlSZmJUMTYyejlWV0NCakVhWHByQ040RXVpMnJacFZNbGhl?=
 =?utf-8?B?d29RYS8rQTdOS3V6RkZiWjFxVVRlWVFtaXlsampINjBIUHJ3VGNVRkZ3WTBl?=
 =?utf-8?B?WUk5bG5LUUxZQ0dqK1o3UnZrbm1naURsTEJjczdyMGdKTjdDMklnNlpHdXR3?=
 =?utf-8?B?T0ZEZDJjR1RFR29ad2NEQXhrb3Bib084L2c3cXpOOTBvekxHbnQ4K2xIWnd4?=
 =?utf-8?B?MFRlVjF2U1JDVGduK0YvZXZSTnRkaFJVZkpIVVNkRDl5RkRiUk1pUnl3TW9X?=
 =?utf-8?Q?F8SIkf7PmIgHtM/VsoLG59A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7035F5D94F59B4288C574109D42FC17@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b48e79d-73c2-4e71-77cc-08ddce0e26da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 19:37:13.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quefqD2RebKyjG4dnvGxC3APK3nWARfM8aLT/g0v7IxKedTBzfdWXnHc8a77qKI/7d7cR2VHAFCyypLm+2qxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1D1D3130B
X-Proofpoint-GUID: P5V9WWUTfehsiYpJ5x7S8ZPRQt-nBNkt
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6887d16e cx=c_pps
 a=gu6RomWtnwV9OjqK3d0IpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=6RBEbOY57HQNCRqSbaYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P5V9WWUTfehsiYpJ5x7S8ZPRQt-nBNkt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0MiBTYWx0ZWRfXyUdZyyps6qIy
 VUbfAhHxMQCxqgWDmIyVYowttYVUwioihc/DcfIgjytcLlkVUnigtBiZBi040xKbEx2s4998Yok
 W65RcE1KA+/35HNuY7/YeU8sbfhNms0saEcQUWT8Hi7qVJbhfnbZ7or+xGBlPhTQORvDeqUPJWx
 44fzR8xUpb/hz8jSczi7Z7xriDFKAaerAFX6QaWuZ4ixSqVWGnnDhjxZfTKKnlC+359EKnob/qW
 Mb01lljtNCZ5vNeolzsM8wR99hqj6GHd1hwRjlFvet9+YWEyac+Caw27VjWpB1lB4oh/cFIWMjl
 6GInjeYtqJ5qpqJRsD6+zIMcf6Bay30SUoRNqYbQ6WD+/Wl30YXpYtFkVSdg3mmzlBNu2HhvVXc
 kpZaIFLHEl+TLnz2p0sl+yhcC/873a8yZE34BeOftYgrpAMNP5jBlLxExZ1x1zmOIcmbTFLf
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280142

T24gU2F0LCAyMDI1LTA3LTI2IGF0IDA2OjUyICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMDcvMjYgMjo0NywgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gSSBt
YW5hZ2VkIHRvIGZpbmQgdGhlIG9mZnNldCBvZiByZWMtPmRpci5EaXJJRCBpbiB0aGUgZmlsZXN5
c3RlbSBpbWFnZSB1c2VkIGJ5DQo+ID4gPiB0aGUgcmVwcm9kdWNlciwgYW5kIGNvbmZpcm1lZCB0
aGF0IGFueSAwLi4uMTUgdmFsdWVzIGV4Y2VwdCAyLi40IHNoYWxsIGhpdCBCVUcoKQ0KPiA+ID4g
aW4gaGZzX3dyaXRlX2lub2RlKCkuDQo+ID4gPiANCj4gPiA+IEFsc28sIGEgbGVnaXRpbWF0ZSBm
aWxlc3lzdGVtIGltYWdlIHNlZW1zIHRvIGhhdmUgcmVjLT5kaXIuRGlySUQgPT0gMi4NCj4gPiA+
IA0KPiA+ID4gVGhhdCBpcywgdGhlIG9ubHkgYXBwcm9hY2ggdGhhdCBjYW4gYXZvaWQgaGl0dGlu
ZyBCVUcoKSB3aXRob3V0IHJlbW92aW5nIEJVRygpDQo+ID4gPiB3b3VsZCBiZSB0byB2ZXJpZnkg
dGhhdCByZWMudHlwZSBpcyBIRlNfQ0RSX0RJUiBhbmQgcmVjLmRpci5EaXJJRCBpcyBIRlNfUk9P
VF9DTklELg0KPiA+ID4gDQo+ID4gPiAtLS0gYS9mcy9oZnMvc3VwZXIuYw0KPiA+ID4gKysrIGIv
ZnMvaGZzL3N1cGVyLmMNCj4gPiA+IEBAIC0zNTQsNyArMzU0LDcgQEAgc3RhdGljIGludCBoZnNf
ZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMp
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGJhaWxfaGZzX2ZpbmQ7DQo+ID4g
PiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gICAgICAgICAgICAgICAgIGhmc19ibm9kZV9yZWFk
KGZkLmJub2RlLCAmcmVjLCBmZC5lbnRyeW9mZnNldCwgZmQuZW50cnlsZW5ndGgpOw0KPiA+ID4g
LSAgICAgICAgICAgICAgIGlmIChyZWMudHlwZSAhPSBIRlNfQ0RSX0RJUikNCj4gPiA+ICsgICAg
ICAgICAgICAgICBpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9ESVIgfHwgcmVjLmRpci5EaXJJRCAh
PSBjcHVfdG9fYmUzMihIRlNfUk9PVF9DTklEKSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlcyA9IC1FSU87DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+ICAgICAgICAgaWYgKHJlcykN
Cj4gPiA+IA0KPiA+ID4gSXMgdGhpcyBjb25kaXRpb24gY29ycmVjdD8NCj4gDQo+IFBsZWFzZSBl
eHBsaWNpdGx5IGFuc3dlciB0aGlzIHF1ZXN0aW9uLg0KPiANCj4gSXMgdGhpcyB2YWxpZGF0aW9u
IGNvcnJlY3QgdGhhdCByZWMuZGlyLkRpcklEIGhhcyB0byBiZSBIRlNfUk9PVF9DTklEID8NCj4g
DQo+ICAJcmVzID0gaGZzX2NhdF9maW5kX2JyZWMoc2IsIEhGU19ST09UX0NOSUQsICZmZCk7DQo+
ICAJaWYgKCFyZXMpIHsNCj4gIAkJaWYgKGZkLmVudHJ5bGVuZ3RoICE9IHNpemVvZihyZWMuZGly
KSkgew0KPiAgCQkJcmVzID0gIC1FSU87DQo+ICAJCQlnb3RvIGJhaWxfaGZzX2ZpbmQ7DQo+ICAJ
CX0NCj4gIAkJaGZzX2Jub2RlX3JlYWQoZmQuYm5vZGUsICZyZWMsIGZkLmVudHJ5b2Zmc2V0LCBm
ZC5lbnRyeWxlbmd0aCk7DQo+IC0JCWlmIChyZWMudHlwZSAhPSBIRlNfQ0RSX0RJUikNCj4gKwkJ
aWYgKHJlYy50eXBlICE9IEhGU19DRFJfRElSIHx8IHJlYy5kaXIuRGlySUQgIT0gY3B1X3RvX2Jl
MzIoSEZTX1JPT1RfQ05JRCkpDQo+ICAJCQlyZXMgPSAtRUlPOw0KPiAgCX0NCj4gDQo+IEkgaG9w
ZSB0aGF0IHRoaXMgdmFsaWRhdGlvbiBpcyBjb3JyZWN0IGJlY2F1c2UgdGhlICJyZWMiIHdoaWNo
IGhmc19ibm9kZV9yZWFkKCkNCj4gcmVhZHMgaXMgY29udHJvbGxlZCBieSB0aGUgcmVzdWx0IG9m
IGhmc19jYXRfZmluZF9icmVjKEhGU19ST09UX0NOSUQpLg0KPiANCg0KSSBkb24ndCBzZWUgdGhl
IHBvaW50IG9mIG1ha2luZyBtb2RpZmljYXRpb25zIGhlcmUuIFRoZSBtb2RpZmljYXRpb24gb2YN
Cmhmc19yZWFkX2lub2RlKCkgc2hvdWxkIGJlIGVub3VnaC4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

