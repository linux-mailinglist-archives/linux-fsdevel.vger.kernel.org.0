Return-Path: <linux-fsdevel+bounces-70751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D547CA5F04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 03:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E0E315FCED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 02:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FE2DEA89;
	Fri,  5 Dec 2025 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="B+kPhPhv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011005.outbound.protection.outlook.com [52.101.125.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D5221277;
	Fri,  5 Dec 2025 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903258; cv=fail; b=HgfqFbuN/SMUu4HnFcKBlpuxtrgej0owCnMGihdwjvN6BXeqSA2WtiOCPC61XxyQr2Iilkw1oW4ybEBHBh264JPhiJIsw7Od+auHHuDYqzq3r7kxnm00opOqZ8G1GfGYfWUd/FKwyvTlTbiXWX5yrjJoBrQUJoqEC4RXcX7fZQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903258; c=relaxed/simple;
	bh=jqnsxW0RSdiqCWufR+FSNsT6rAHSd0Y1zHpU9yjwRYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCkjdjcil0Pu2ITrjdF/hIvA7C6j2BnoBOoiQQ+GkugwoWa22A4sh/zdBNVW3W6uOrOlChJOY99qgwY7RiC65MaG3HmmE9+vaNYMa+x1F3aX4ZVvlBZIyO+JevRKQMhiAJKGUNyPg0TuIklvWTirIIk1n2+mpiutSIyfq/G7wqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=B+kPhPhv; arc=fail smtp.client-ip=52.101.125.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew1TYPHTCEGlyKfx+yig0QZS28rxT88030d/PVZFc8eosr54AM/J5leT/LKVIsJ0LgD8afUPOQzfGfAE0BSq6nL84mheBEsVRey+WLD6mSeTs30h5i7YWPksdT1WZnNls4Sv3349Ew4Qe/kzCybZW5uSzoSFH7oUktxXqp24mmM/Q4RyhYJr/bZF26pqLsVEkn7vcEng5+9Nf8t9E1BCmd919QnP1sPS2Cl5bshFVYAl+iO4ecSrBmdk3LMMx5thLEEbwdb4boLcK6aKGtpeOGttxvr0YD22Ra1Hb4ZR97OMUNpdUPX1RFA+MCnyy0d1ChUGTh9YNj2hVGovCE0J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqnsxW0RSdiqCWufR+FSNsT6rAHSd0Y1zHpU9yjwRYE=;
 b=GW9EAeJa98gRFwizcbQVO2IonRVUxoR80zGEegsQEzOXbP2wk8LJ7uK068IlOuOyRWF2QlRaHGk3baY4Drk9wfPvNRdAMDcRCfKbYpUGVmDPXVTj7m8ZnPhTrhnRiZBn/Yv4+7b4V4Qm0cjMXAermAlwzycBE9vCFubRXb9C4hjjHCXd0OgCWwb+Bun1JAgNXoxawH8F7vsnR4eaiL+At8N20FRnrb0ZX67sDKSa0qOjIPVerH8btFDlTId3bfVd/4whilZJbfxDGECFYpF3Rl5vV1UV3wQ8aPjfzjeQbn0fL2HixsgHo/wwBbvECYsIeMk+6A6rpN3rpcnTuVSk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqnsxW0RSdiqCWufR+FSNsT6rAHSd0Y1zHpU9yjwRYE=;
 b=B+kPhPhvqURUhd4zqG5OtpOMjvW5HUqwYSG+QW9VtUP+fb1sa61M7624fS/Lsy2ne/EQyd9dZeO3xeEn5o9I72cZlU58hmtptgn9d9xiPpIp+x4JuG7KDMjDgRcyi8d04dzzQqMekELN0AxM/h0y6kl49ucQnDo5L2+rYVZAs1gcycpIV3tpml9urLrEYXrWSKWGEb3+dLaqFudVziCR/eGt/Pg8Id47B235QRMvPnrU2j4RMBSKL8QN8mhrC5+rzH2lPzmwdpMZ3KW+5ZkWLQssK2eKsE9xzhpG3AY7pF2qbSmoC1iZgaeR/gArIw0wWVKFDJMgxawGslDwTWErDA==
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com (2603:1096:604:2e2::9)
 by OSAPR01MB7197.jpnprd01.prod.outlook.com (2603:1096:604:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.3; Fri, 5 Dec
 2025 02:54:14 +0000
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::8bd2:26a8:7301:ef13]) by OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::8bd2:26a8:7301:ef13%6]) with mapi id 15.20.9412.000; Fri, 5 Dec 2025
 02:54:13 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>, "Tomasz Wolski
 (Fujitsu)" <tomasz.wolski@fujitsu.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "jeff.johnson@oss.qualcomm.com"
	<jeff.johnson@oss.qualcomm.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "len.brown@intel.com" <len.brown@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"nathan.fontenot@amd.com" <nathan.fontenot@amd.com>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "pavel@kernel.org" <pavel@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "rrichter@amd.com" <rrichter@amd.com>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>
Subject: RE: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Topic: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Index: AQHcWcyJqnu4U4CtbEafj46B/wkCu7UNRXEAgAK6YQCAAI6XgIAB2zCw
Date: Fri, 5 Dec 2025 02:54:13 +0000
Message-ID:
 <OS9PR01MB124214C25B1A4A4FA1075CADA90A7A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
References: <aS3y0j96t1ygwJsR@aschofie-mobl2.lan>
 <20251203133552.15468-1-tomasz.wolski@fujitsu.com>
 <6930b447c48d6_198110029@dwillia2-mobl4.notmuch>
In-Reply-To: <6930b447c48d6_198110029@dwillia2-mobl4.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9M2E3MzUzZTMtM2U5Zi00NDBkLWJjNTQtYTY0Y2Q4ZDQ0?=
 =?utf-8?B?NTc3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMTItMDVUMDI6MjY6NDRaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12421:EE_|OSAPR01MB7197:EE_
x-ms-office365-filtering-correlation-id: c2bb92ad-b40a-4050-0e14-08de33a992d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmpUUmJxN0Q1Mk0zVklGUW9lT3Zpb2FoRUs2UzZhL20vRmJWOFFQSUduZXFl?=
 =?utf-8?B?VURrR29oaisvTHY3MjBrZWRRNHBUODJWYmNwU0dCelBZQzM4SE8rWXZzNEY4?=
 =?utf-8?B?U014ZS9JcTBJaDVMYnhDbXloYjI2OFFlOGhHd1ZGTzZscGlVKytFZUZLZ3VH?=
 =?utf-8?B?bHZnamI3SFBVd3ppREdVdDM3dHdHWGY1a2ZKbm5INE5FKzZ2aHRhOUo2OHE1?=
 =?utf-8?B?L3M1MWxnWVVqSFJMcmdtbkhjL1UwQnFSVENXZHh5eFZROWoya1lYSHhIUjF3?=
 =?utf-8?B?ckgvVHBUck4xTGRJL3BmT0g2b0F0NURXRmZ6azFmcnhXS0l6eTdqQWxSYTkw?=
 =?utf-8?B?cklyTEphS0JGeU9ITGNLUGMxdHlsYmN3Q005MWpRemFnUDUyYStQcElkN093?=
 =?utf-8?B?bEJUZzhsQ1l2RkVVUFRId29IcWhKeXhTRnFtcnd0eElxeStpSDFtYWRCdk1F?=
 =?utf-8?B?ZHVwb3UzenVLWkFZVGpCZ28xSCtpREN6c3p1Ui8wOU5HMkJIb0t1OCswaUlQ?=
 =?utf-8?B?a1Vmc1FuZXlWQlBQZTVVd3pFUGxFSVFaaWIzL1ZmSlVKWUFpcS9GME1lNnlX?=
 =?utf-8?B?WGluSlF5MDd2L3hhNy9qM0xUdktYNkNDUE5iSXFaWCthd3BBWDFaWTRQMDYw?=
 =?utf-8?B?SzlTWXBJNmcxNzdDd0w1K1dId012Z3ROOWVVdjlmbzBPb0FxdTZUejcrdUtu?=
 =?utf-8?B?bW5mTFFkUkFzWXYyTThaajRCdzhra3YrKzRwaDdhaDNVOGtRcmhiTTVsZTNB?=
 =?utf-8?B?L1NDSWpuZ3k3Zi9CWmhMS3BtdS9CdGxhQ0krV0k5UlVURll4STJ6ckJYOUtu?=
 =?utf-8?B?UjBXMytMckhlNG5XSncyMzFHN3laOG9GZXVTaFlZMjlGWWl1bTVPbFR5N1kw?=
 =?utf-8?B?SlZWWjVVcXFTb0RCTmprOWdkc0RHZWVBT2V4K2R1VDBlQzJHbmlHRm9aZHZs?=
 =?utf-8?B?WjhnSDFQSjBHcFFQbWlaNDdkbkcxMHN6S2x6VlNGWk9KKzR4NnZPeGFMdHlw?=
 =?utf-8?B?aldrYXgzVDJyN3FUU2FhL3NZa0UxNXdDT1g0b0VGbCsraXpQR0Y3U3Ywc0dH?=
 =?utf-8?B?MU9uSDRXbXUrMlJqcVY0eFd0a3QrdVFsTmZLOXBzRk1vQzR5RUxLZ0ZTY2xH?=
 =?utf-8?B?Q1Q4ZjJzeTd1RGJ6VCtndVRlaWxKMkZNV2tyZmY4N0N3Rm5PVUFGeEFHTG9G?=
 =?utf-8?B?Mzl6NjVLRHkvM2VkalJLbk05S1RFTlAwdzlIL3JSemY0RGk3dGwxU1o3WkFU?=
 =?utf-8?B?UWxiWVE4ckxsbDJZNFRaV2JBcmFDZG5GWmREejFSWEQ4VFh2eGIrWWlNUHRP?=
 =?utf-8?B?eFdvWlg5U3V5SVgrZ0JJMU5LU1BHUkhwOVB5WUdmUEY3L2RadnF0K2JNUkhh?=
 =?utf-8?B?YjlMZDJ6RGoyY2VQWDE4Zm9kT3pwS0QzMi9ucmdSQ0FTSlJoK1hNb0FoYmtE?=
 =?utf-8?B?NGJHbFRGWHM0SHhOWkhZUW5UYkc4bWdmTzFPR1BjZnRSZUV4MzNja3NCY2V0?=
 =?utf-8?B?VDA1dHdjZkowTm1RM3ZaNGozcDc1ZzVGL0JodGVkQ0Y4QXprd2VqMjBiem5N?=
 =?utf-8?B?VmwwUVlobkgwUHQyK2Y2TVRLczRxdkh6QWRETUhFbnJ4UmZ1eU9rK3BKanVF?=
 =?utf-8?B?SDVQVWZJVlRqd3c3OEM0YUplaDJWWXZ3M3hFNmlLaEJ2cmU0MDJzemZFdE5w?=
 =?utf-8?B?VmJmeE1nRU81YnJzUkxRdks1enQ1WWRaKzB5Wk16MUFYWndMOHpiYUF0MEhy?=
 =?utf-8?B?clpqcUZ1bUEyY1NZTDRXNmNrbUNvUndDS2pzWlZBZERES0ZpZm9KWGNKWkF2?=
 =?utf-8?B?Nm5UTUNuTk1zcjVrVHl5TGFhbHZkcDZpZ0puYm5MZFhCWlFzRW93ZzRsc0xT?=
 =?utf-8?B?MDNLaDVLRDJaZTdUOHovRWlRajJnTCtyMlVFaXdmemwvcWJ5cGkxUmVBbUMr?=
 =?utf-8?B?NHJLUzBTOFlDZ2ZYNjdGaDh5QXhCRXpKNmMzQUdOeVFGWjBWMEg4L2dILytL?=
 =?utf-8?B?bEwxR3YwcVBVTWRlU3VLWUhYM2JBd3prcnZNL2Q1d0pIWGgvbnV0N093NjAw?=
 =?utf-8?B?QmJINVBPa2JGQnczT243UE83dkJFKy9NSWd4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12421.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm1TYzZuUkY0UlJleTl4Z1JKd1I1bG1mMWdxYXYxbVpoNzJIV3ArL1lwbWY5?=
 =?utf-8?B?OFl5MXljdnorbHRVbFVJNWRkTXRsbEoxT3VoRFhqVkxTMmtPMEV4OURoV0hM?=
 =?utf-8?B?Rlo2a0p2L3Y4UkRFNVRxMXdrUUVjRDhUT1NDeVJDak02RG1ieklnZWYraXhD?=
 =?utf-8?B?ajlPNWxnOG40anJoMFNBWGRTVWtvWXNrSU9KbjRXNDVNdys5N2sxRmNxYXVR?=
 =?utf-8?B?WmN5UkVhNjZzTGlmcG14OHcySUZYa2M2NE5kMjVxRjdhSWJKS2lwL1UwZVdj?=
 =?utf-8?B?WnliVmNKMjZjL2g2TTI0OFlzMEdLTXVFYUNYVmhSUWdpejRIYmtHV0ZHdEJT?=
 =?utf-8?B?cWhCYVFlRjNySThhczVuMitYM1NoN3E2amZjcEpxdGRsNER6K3diWkhyMXRi?=
 =?utf-8?B?ZDJCUmd0eHlzREs0WjFLM0RDaXQzWVA5bm0yWmUwNTZhanJoRVlrcUs5WVlT?=
 =?utf-8?B?eUc1VnlsV1hKV0ZFWUdKbkhFb05zaXQ1MHY4NC82UjJxdVc0ZXJuMHlRaFdI?=
 =?utf-8?B?ZGkxSHRtYnRwZkpTSTVYOWM2bEhqdVJwYWZndTMxS3ZjU2VSWTNCcVQxeUYr?=
 =?utf-8?B?WE8rQVZXQjhSLzZkeDF3OUlNVEVuTDg3RElWemlFckxUekg5UTVHN3NwTnlF?=
 =?utf-8?B?YUhWWjFRMEt1VlIwelhPenZVRG14M3FWUHFVRTFRb0VpNEJlQnRELzRUZkdP?=
 =?utf-8?B?QkNyUlhFZzVaTlFPZ2FJQ1JKREFVZVFjZm9oYlpLRzMzUmY3aUxNeU45RzFz?=
 =?utf-8?B?MjFxcnhyZGU4Qm1XQnlEaDdwbnJYQkl6cFoyZWdERm5NSEhKeXN1TmNlc2JL?=
 =?utf-8?B?QTdMTjdvaSs5TVdzYmpSZDEwQ1AySUtUZ1VVckpOUmxKRFFjdTdmWGx3R3pD?=
 =?utf-8?B?d01NSld6aUFIK0phVVE1THc0cFpMU2hoSkZtRXJHNzUvU2EraUJtS2pWU1ZE?=
 =?utf-8?B?QUtxRjIrcEVvdEtLVjhTaysxMXZuV3lnR3BOL2cyQ2V6ci9Pby9rYnVzVGQx?=
 =?utf-8?B?ZXRoOWtJRUVZeW5nd0tWbFp3V2JheEVvRlRPV095ZFhQRENZK0RjUWFlN1pj?=
 =?utf-8?B?MEtvT1hZMGV1d3VNTzFHTFZ2WHlBb2hoK0F4b3dOcitDVk5VOXZNcVhDWXY5?=
 =?utf-8?B?N2lSRERVL2M1S0QrcGw2NjVSaVdNK0U4QW01STBUcTdaRnVRSkNpL2dMNUF5?=
 =?utf-8?B?aWloVWpCaTRUcUtRenF1ejU0RFAwM0VJNkxYbXF5QzhpdVRzTlR4cEo3UXRu?=
 =?utf-8?B?dXdJc3Jqd0x2VnRkNnM1MUFBL3lDWEV4Y2xrQzdFdkMvRVNUV2JiTmp4Mndk?=
 =?utf-8?B?aFd4Z2hVekFyaExpNm9FalN1WDVxOGhNUDdRVkNOcmdaR2FyYVhkSE9PQ1Nm?=
 =?utf-8?B?TDZLRWpsNzVwR05ROUFSS1F6TWxUNVJDdTNhUkhvOGJMUzFnQ1pmYXlpWnFj?=
 =?utf-8?B?QVExOW5Qd3cwK1NpN0hlVVNlbWpSNmlwc0xNVWdvdHFBUjZwQnZyS0NmeVA3?=
 =?utf-8?B?N2d4UnE5NVRNRHp4SFRCc0ZQc1ByRDNaQWZjdGIwZjRzOWNKSXBYZm1QY2k3?=
 =?utf-8?B?QmJ6VnlWZGV4alhqVkp4Ym5RbzlaZ0VUUW1UY3lNdEpmSHhBNE1TYjdQR0FG?=
 =?utf-8?B?K044Z3UvN2pCMXQ0VUcwYm5pcm44Y0FRZXd4V1pKbXJ2WElUWElXc1l5cnhP?=
 =?utf-8?B?L0ZlY0tiNVpNQlpmQy94dkdzN2pJWlhJcTNnbkM3OU5tcDI0OUUvOG9FQ3d0?=
 =?utf-8?B?YUdyWmowV2FTVGkvbytDaUkySDdwdnhCRXlYajFUVHRQbnNpdzRLTDZZaWRk?=
 =?utf-8?B?N00xKzFDZlVET0IwSWMzY0xRWFhQbUdZU1ViYVZMbnc0eU5yODREYldOelVD?=
 =?utf-8?B?d0t3YjhWMEVwT2dSb2JnN0p5cHJwdk5JQzAzQzA5YXAzd0J5ODRmeFhrZlFk?=
 =?utf-8?B?RWNnUHhSL1M3MmY5WENuZU9oNUdEeDBhRzBYc0xZZE11WURXSFhMSXJQdzFJ?=
 =?utf-8?B?MDZTOW02RCtoalZaa3NmenFzeHlFY3JoeEFwZmdnRXRucjlnOThiQXlmOTgv?=
 =?utf-8?B?bzZycTEzNnFwRm9rZ2U4ZjdSQ2FVQ2w3TG4weFdtR1ovYmxWTGloU3MwMGNC?=
 =?utf-8?Q?nX6bbcdG1U07YN644PGYCMUtH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12421.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bb92ad-b40a-4050-0e14-08de33a992d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 02:54:13.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfR9QxuAZOuAHz72zq/0WRWwXqXZxKXjhPRY4RA8Gpo33wwcdlaV8R3ZOdGVWxPHy+GyahqyGDCsYJ7V2cApjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7197

SGksDQpKdXN0IG9uZSBjb21tZW50Lg0KDQoNCj4gPiBbNF0gUGh5c2ljYWwgbWFjaGluZTogMiBD
Rk1XUyArIEhvc3QtYnJpZGdlICsgMiBDWEwgZGV2aWNlcw0KPiA+DQo+ID4ga2VybmVsOiBCSU9T
LWU4MjA6IFttZW0gMHgwMDAwMDAyMDcwMDAwMDAwLTB4MDAwMDAwYTA2ZmZmZmZmZl0gc29mdA0K
PiA+IHJlc2VydmVkDQo+ID4NCj4gPiAyMDcwMDAwMDAwLTYwNmZmZmZmZmYgOiBDWEwgV2luZG93
IDANCj4gPiAgIDIwNzAwMDAwMDAtNjA2ZmZmZmZmZiA6IHJlZ2lvbjANCj4gPiAgICAgMjA3MDAw
MDAwMC02MDZmZmZmZmZmIDogZGF4MC4wDQo+ID4gICAgICAgMjA3MDAwMDAwMC02MDZmZmZmZmZm
IDogU3lzdGVtIFJBTSAoa21lbSkgNjA3MDAwMDAwMC1hMDZmZmZmZmZmDQo+ID4gOiBDWEwgV2lu
ZG93IDENCj4gPiAgIDYwNzAwMDAwMDAtYTA2ZmZmZmZmZiA6IHJlZ2lvbjENCj4gPiAgICAgNjA3
MDAwMDAwMC1hMDZmZmZmZmZmIDogZGF4MS4wDQo+ID4gICAgICAgNjA3MDAwMDAwMC1hMDZmZmZm
ZmZmIDogU3lzdGVtIFJBTSAoa21lbSkNCj4gDQo+IE9rLCBzbyBhIHJlYWwgd29ybGQgbWFjaGlu
ZyB0aGF0IGNyZWF0ZXMgYSBtZXJnZWQNCj4gMHgwMDAwMDAyMDcwMDAwMDAwLTB4MDAwMDAwYTA2
ZmZmZmZmZiByYW5nZS4gQ2FuIHlvdSBjb25maXJtIHRoYXQgdGhlIFNSQVQNCj4gaGFzIHNlcGFy
YXRlIGVudHJpZXMgZm9yIHRob3NlIHJhbmdlcz8gT3RoZXJ3aXNlLCBuZWVkIHRvIHJldGhpbmsg
aG93IHRvIGtlZXANCj4gdGhpcyBmYWxsYmFjayBhbGdvcml0aG0gc2ltcGxlIGFuZCBwcmVkaWN0
YWJsZS4NCj4gDQo+ID4ga2VybmVsOiBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAyMDcwMDAwMDAw
LTB4MDAwMDAwYTA2ZmZmZmZmZl0gc29mdA0KPiA+IHJlc2VydmVkDQo+ID4NCj4gPiA9PSByZWdp
b24gMSB0ZWFyZG93biBhbmQgdW5wbHVnICh0aGUgdW5wbHVnIHdhcyBkb25lIHZpYSB1YmluZC9y
ZW1vdmUNCj4gPiBpbiAvc3lzL2J1cy9wY2kvZGV2aWNlcykNCj4gDQo+IE5vdGUgdGhhdCB5b3Ug
bmVlZCB0byBleHBsaWNpdGx5IGRlc3Ryb3kgdGhlIHJlZ2lvbiBmb3IgdGhlIHBoeXNpY2FsIHJl
bW92YWwgY2FzZS4NCj4gT3RoZXJ3aXNlLCBkZWNvZGVycyBzdGF5IGNvbW1pdHRlZCB0aHJvdWdo
b3V0IHRoZSBoaWVyYXJjaHkuIFNpbXBsZSB1bmJpbmQgLw0KPiBQQ0kgZGV2aWNlIHJlbW92YWwg
ZG9lcyBub3QgbWFuYWdlIENYTCBkZWNvZGVycy4NCj4gDQo+ID4NCj4gPiAyMDcwMDAwMDAwLTYw
NmZmZmZmZmYgOiBDWEwgV2luZG93IDANCj4gPiAgIDIwNzAwMDAwMDAtNjA2ZmZmZmZmZiA6IHJl
Z2lvbjANCj4gPiAgICAgMjA3MDAwMDAwMC02MDZmZmZmZmZmIDogZGF4MC4wDQo+ID4gICAgICAg
MjA3MDAwMDAwMC02MDZmZmZmZmZmIDogU3lzdGVtIFJBTSAoa21lbSkgNjA3MDAwMDAwMC1hMDZm
ZmZmZmZmDQo+ID4gOiBDWEwgV2luZG93IDENCj4gPg0KPiA+ID09IHBsdWcgLSBhZnRlciBQQ0kg
cmVzY2FuIGNhbm5vdCBjcmVhdGUgaG1lbSA2MDcwMDAwMDAwLWEwNmZmZmZmZmYgOg0KPiA+IENY
TCBXaW5kb3cgMQ0KPiA+ICAgNjA3MDAwMDAwMC1hMDZmZmZmZmZmIDogcmVnaW9uMQ0KPiA+DQo+
ID4ga2VybmVsOiBjeGxfcmVnaW9uIHJlZ2lvbjE6IGNvbmZpZyBzdGF0ZTogMA0KPiA+IGtlcm5l
bDogY3hsX2FjcGkgQUNQSTAwMTc6MDA6IGRlY29kZXIwLjE6IGNyZWF0ZWQgcmVnaW9uMQ0KPiA+
IGtlcm5lbDogY3hsX3BjaSAwMDAwOjA0OjAwLjA6IG1lbTE6ZGVjb2RlcjEwLjA6IF9fY29uc3Ry
dWN0X3JlZ2lvbg0KPiA+IHJlZ2lvbjEgcmVzOiBbbWVtIDB4NjA3MDAwMDAwMC0weGEwNmZmZmZm
ZmYgZmxhZ3MgMHgyMDBdIGl3OiAxIGlnOg0KPiA+IDQwOTYNCj4gPiBrZXJuZWw6IGN4bF9tZW0g
bWVtMTogZGVjb2RlcjpkZWNvZGVyMTAuMCBwYXJlbnQ6MDAwMDowNDowMC4wDQo+ID4gcG9ydDpl
bmRwb2ludDEwIHJhbmdlOjB4NjA3MDAwMDAwMC0weGEwNmZmZmZmZmYgcG9zOjANCj4gPiBrZXJu
ZWw6IGN4bCByZWdpb24xOiByZWdpb24gc29ydCBzdWNjZXNzZnVsDQo+ID4ga2VybmVsOiBjeGwg
cmVnaW9uMTogbWVtMTplbmRwb2ludDEwIGRlY29kZXIxMC4wIGFkZDogbWVtMTpkZWNvZGVyMTAu
MA0KPiA+IEAgMCBuZXh0OiBub25lIG5yX2VwczogMSBucl90YXJnZXRzOiAxDQo+ID4ga2VybmVs
OiBjeGwgcmVnaW9uMTogcGNpMDAwMDowMDpwb3J0MiBkZWNvZGVyMi4xIGFkZDogbWVtMTpkZWNv
ZGVyMTAuMA0KPiA+IEAgMCBuZXh0OiBtZW0xIG5yX2VwczogMSBucl90YXJnZXRzOiAxDQo+ID4g
a2VybmVsOiBjeGwgcmVnaW9uMTogcGNpMDAwMDowMDpwb3J0MiBjeGxfcG9ydF9zZXR1cF90YXJn
ZXRzIGV4cGVjdGVkDQo+ID4gaXc6IDEgaWc6IDQwOTYgW21lbSAweDYwNzAwMDAwMDAtMHhhMDZm
ZmZmZmZmIGZsYWdzIDB4MjAwXQ0KPiA+IGtlcm5lbDogY3hsIHJlZ2lvbjE6IHBjaTAwMDA6MDA6
cG9ydDIgY3hsX3BvcnRfc2V0dXBfdGFyZ2V0cyBnb3QgaXc6IDENCj4gPiBpZzogMjU2IHN0YXRl
OiBkaXNhYmxlZCAweDYwNzAwMDAwMDA6MHhhMDZmZmZmZmZmDQo+IA0KPiBEaWQgdGhlIGRldmlj
ZSBnZXQgcmVzZXQgaW4gdGhlIHByb2Nlc3M/IFRoaXMgbG9va3MgbGlrZSBkZWNvZGVycyBib3Vu
Y2VkIGluIGFuDQo+IGluY29uc2lzdGVudCBmYXNoaW9uIGZyb20gdW5wbHVnIHRvIHJlcGx1ZyBh
bmQgYXV0b2Rpc2NvdmVyeS4NCg0KWW91IGFyZSBjb3JyZWN0Lg0KVGhpcyBlbnZpcm9ubWVudCBk
b2VzIG5vdCBzdXBwb3J0IGFjdHVhbCBQQ0llIGhvdHBsdWcuDQpFdmVuIGlmIHdlIHBlcmZvcm0g
UENJZSBob3RwbHVnIGVtdWxhdGlvbiBieSBtYW5pcHVsYXRpbmcgc3lzZnMsIHNvbWUgQ1hMIERl
Y29kZXIgcmVnaXN0ZXJzLA0Kd2hpY2ggaGF2ZSByZWFkLW9ubHkgYXR0cmlidXRlcywgYXJlIG5v
dCBpbml0aWFsaXplZC4NCkkgY29uZmlybWVkIGFib3V0IGEgbW9udGggYW5kIGEgaGFsZiBhZ28g
dGhhdCB0aGlzIHdhcyBjYXVzaW5nIHRoZSBob3QtYWRkIHByb2Nlc3MgdG8gZmFpbC4NCkkgc3Vz
cGVjdCB0aGF0IHN1Y2ggcmVnaXN0ZXJzIG11c3QgYmUgaW5pdGlhbGl6ZWQgYnkgdGhlIGhhcmR3
YXJlIHdoZW4gYSBob3QtYWRkIG9jY3Vycy4NCg0KSSBzaG91bGQgaGF2ZSBpbmZvcm1lZCBXb2xz
a2ktc2FuIGFib3V0IHRoaXMgaW4gYWR2YW5jZS4gTXkgYXBvbG9naWVzLg0KDQpUaGFuayB5b3Us
DQotLS0NCllhc3Vub3JpIEdvdG8NCg0K

