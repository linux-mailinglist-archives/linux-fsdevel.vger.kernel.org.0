Return-Path: <linux-fsdevel+bounces-66858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB3C2DF83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 21:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357E74ED354
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B962BDC14;
	Mon,  3 Nov 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="axZ2PKd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4A1F9F70;
	Mon,  3 Nov 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200221; cv=fail; b=QIX8vqrwX++oIziHxaX7Kh88AbO3/MIWoDUAen/PDv/8zCL+WdAmO1KCSAnCqDPU2CMCOJ61YOK3SFKztVWmXmgqIRbeWarjkMcyZZSQPGgVitsjJCxSn1/XNe13t10oPcIlIgs7fIXVLr1ocDEqesr8oAjC90he8Ckfxz/VLG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200221; c=relaxed/simple;
	bh=XD7fGJfIM3UFJkuzBNps8NPmyKyY5sW5hKt7hdZAYjY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=II4ylm5dFHvWFxCUAUivV8SE20+EX9lRaNnbk1Z0DwDpuMPfFjWe1zxO0OWyzii4nv/g+a2Rsr8Unoy6Q4VJynBiMAf70As0lmEZRQ3nyzv6NNWc9ldOYm3i7ZilKiJNofW5RK15E5qUavScviAXRuONfnKKfO9c64XssSqNB+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=axZ2PKd8; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3F63Cj003919;
	Mon, 3 Nov 2025 20:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=XD7fGJfIM3UFJkuzBNps8NPmyKyY5sW5hKt7hdZAYjY=; b=axZ2PKd8
	iObhXcf4fmWjJk4CsjTWlCeV+kCA9RYd2I1n9paFL8poN0Ioa4MG+7Rv8AhJS1p0
	Sp6v6BqN/nVXhlxClpvKIKbGyxy6qpkH+opY0GRia726PptGTw3P/FGphv8yCFe9
	Mh9BIn6ZP30Vt/lIAe2mBs2Tma8p1UgmvQWrvkcDfCaB5mPtYn+e4NSciioPYeWp
	nfMUq0jT+hZDMjKV99/gp9k0BbkyVlAW6Zt/16uigv2pYn8zGUvoWw8zEPgv5zyY
	r9Z3p+4JAVyol82OzEtF9+AjfRlSGIV8w6GhnuXFVjNRpTCLfKVLxtDkmChEsKN/
	2kz/QgJ8PiVjEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr0jv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 20:03:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A3K3ZuQ013148;
	Mon, 3 Nov 2025 20:03:35 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr0jv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 20:03:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0NfRKOF7xtOE3iSofwzzb0u4N2l6Siqa7FzuMvTbstnYegdaKqVizYjyqzVsfcuPHm6NiJcAAIZpRnQoFsjsJh4tT5L1Ggr84CLxiO96R7C9MsCHHyF+GV3sg21ToqqYx4GJgODxWySV/5GmOdrG/Id7/BLW4TLGDagqGXXoI9RUg0PWYsZHmh8s/X7LecXSiaaL/MXPFxRs6A/I/EXAtXQ1mblB+STplPC1/C+wBRFHbwHE1Rk7vFP//o1rpA/p6Ywf9ApHvshR8nu9lWzHXdA3LVot724Uq04UCGvyXL3rFzf+xE/QLMs496wwu6EzcZLM7b485jd+9I89BIvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD7fGJfIM3UFJkuzBNps8NPmyKyY5sW5hKt7hdZAYjY=;
 b=C2tyOh0ADmck7P1eYCSGbNG/p37FW+2G4nK/wwfEFgKD1XAlwqN5TQtxacMc+ZbP7Jz456rMLM8FD5HxlAOrj+s8LChAyO/vuHUXjtfMXcq+LIy9LfAP1AMpn9sfVfF4eEpriQKPJQ3LRfMImIhAZYnrJkrbJXzsBnSLrcbIO7uQqXvA7Us94kn7B7xI2H95JO33YPE6BXQf7JxD6ngccUTeejBW2QFbI+wLOp0W1+NKONhTPH9ihRe/B6lRb39+uzqElZIWGERpKsqNX7ftbnBQWDxPbwu721IsTzzm7F8Q8nhqsgAQam6K7CUq8l1QGJNtHfPP7tujfrCk2mGcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV3PR15MB6522.namprd15.prod.outlook.com (2603:10b6:408:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 20:03:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:03:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>,
        David Howells <dhowells@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v8] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
Thread-Index: AQHcO7ga6oyZDsxRZkChtS4Ibmk3cLTXyTUAgAm34QCAAAFTAA==
Date: Mon, 3 Nov 2025 20:03:31 +0000
Message-ID: <881fc89959217e1ea6a01b61e8e3d104d481dc81.camel@ibm.com>
References: <20250821225147.37125-2-slava@dubeyko.com>
	 <CAOi1vP_ELOunNHzg5LgDPPAye-hYviMPNED0NQ-f9bGaHiEy8A@mail.gmail.com>
	 <5e6418fa61bce3f165ffe3b6b3a2ea5a9323b2c7.camel@ibm.com>
	 <CAOi1vP8PCByY3dKu9cSDWo8B9QMaqRT23BYzkd1Q2H0Vs=YjxA@mail.gmail.com>
In-Reply-To:
 <CAOi1vP8PCByY3dKu9cSDWo8B9QMaqRT23BYzkd1Q2H0Vs=YjxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV3PR15MB6522:EE_
x-ms-office365-filtering-correlation-id: 83853f09-e47f-4faf-3280-08de1b140fe8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2x0Tkx2VW5zZmsyYk4wMGRram1rQ21vUUVKemhPNDZmbkY4TjYxZ3IxTkww?=
 =?utf-8?B?aERCbUV2Ky90aFVMaS90UjRIMlNZRlNOdTMzSFQ3ZG12c1BOM3pXK1pnTmV6?=
 =?utf-8?B?a0c2K3dxRGh1MmhsZzNlZSsxaHExUXZJTzRKYkt1UHIvZnJhV1hmdUhWeW1C?=
 =?utf-8?B?bnk0SDNCZ3R2UVQrcURCd0ovRnNSQkF5UFdSRHg4a3Fmb3l6Rm16OWdsaE0v?=
 =?utf-8?B?WXVScGx3ZURmekhuUEt1RVlkd1Vtc1VTLzZnWUpkTnVlcXhMYXNjQjVLRHlI?=
 =?utf-8?B?L3NJZXByQ0dKaXAvT1N2MzEvZWF5cWhROXpiNmRaaGpRZWs1K1g3UFIrRFR6?=
 =?utf-8?B?MlFETGIzZU9McU1HY0YxSzdBK0QySmpiT1R2czJkeDBmRXBNZ2lJNXlMdmdx?=
 =?utf-8?B?OW5lRkl4VkJxS2JXZjBmUG9aWVlzZXQ0RmJuaXJlem1BWGx4ZFJ3cFpTT3dY?=
 =?utf-8?B?Sk8wNUpMdTFqay8xTlg1WnpmMk13N2wrTlVacWNYMUhaaTRQOFp5dE5zYWZN?=
 =?utf-8?B?MDdsWDRHLzVnbzI0S0NyY1JXeUVjMkNCRGt3N05nNDR2clZKbUJ0Q0RuVkdu?=
 =?utf-8?B?bzcyK05kVHZua3VxeGZnK3A3Z0RoaWN4UW15ZWdNS25wdUdVSDVsMUtBeVpq?=
 =?utf-8?B?RmhKZmx3dEZZVXVqQTdlWjRqZjMrdDlRckJuUExHNndvcXA2Q1RRVUtKbE9u?=
 =?utf-8?B?ZGFxOVNXN3hJUUFldnNKN0lpZW0xNThoeFNuUkI2WExNN1l2WTBoaUM0RXJn?=
 =?utf-8?B?S1gydlczQ3dYM1AvQlh5TCtZRzNIUzFCOC9CRDBFdTZnbE4zRVh3Rk1nM0F5?=
 =?utf-8?B?YUVNcEhzUGtPRktINEwyVSsvdmNyYlkyMU91NTA3dzVyUjJwL1hNcTkxd0RF?=
 =?utf-8?B?UldFZkptaStHZTBubkNRUUJKbkF2MXF0cnUzV2F2QUg4VTlSUlo5eUdvWFdO?=
 =?utf-8?B?cFQrNzZubUJtd3c0a2hHQmRrSVBCMWhySG9iZzJTZGtWMnpEV2grNW52Vzho?=
 =?utf-8?B?K25IK256SFVtNEJkbllzTm5FOVZQZ0xUYU9LQk9JeStHZG9ORTlEWjJ1ajgx?=
 =?utf-8?B?a3crN282M3RXUDBVQkMyaEUxQ0lzZDI4M2lVaDBLSG00ZEJ1SmFDRUwwS2lY?=
 =?utf-8?B?YlFmMWY0Ync4ZUg1RURLNkFXcVhJQld3WlFvTk9KOGNjNXFMcVdtUU0wOXJ2?=
 =?utf-8?B?emQ0SVhIVVlpUDc4U1QrRm5LSmVZd1psek9LUWRwVGZldGNJM1Npak5qNE92?=
 =?utf-8?B?eWdyYWRadEl3dWJzdkJ0R2hjYjlwd3ZDMktoT3hUNjZqVUZoUjVlaHZJNU4v?=
 =?utf-8?B?bWs2K3IzT2l4R0hMeE5KU1B6bmZnVzNnY1ZJbXhEaXlBejZCeU5VMVJDdDdP?=
 =?utf-8?B?STJZcVNQOGtPV3JpR3FteUV3M0I3TkNSelJtRlUrWHNzVC9jbHdhbWhBOXFy?=
 =?utf-8?B?VnlTa2x0d0RIZTM2RWJKOWpRUE5GeGc1WmdBbGRyYmY4WEtkL09xSmlEWGRI?=
 =?utf-8?B?SytPdUZBUXNkZmp3NjU0QVFZR3h3b2xpekx6Wm1tNXZFTFRvbnZsN3pMbEhE?=
 =?utf-8?B?TklJSXMvTGtac3NnRXZKK1hqZUVET2FUanRVTXRuMGtGNmxvbHRSejUwVHB5?=
 =?utf-8?B?N25MOHhPV2E2QXZaZzQzMWVadTNNemZvbzR4TGpYSW94VDBpY1htYmxIdTcx?=
 =?utf-8?B?MVA1bmhVMWF4TjlhenlCSHIwa1U5dDVHN2ZoYXdOR2plbHdSR2RrSUExOFJC?=
 =?utf-8?B?L21GMkphc1ZZK1JUQ21PcnEzWmFQTUpuK3NDZDg0QmdocUt2R05Tdkc1Rzcy?=
 =?utf-8?B?QVdXdXhPdFAxNTZuK3Y0VDdVUTkzd3B0UnNKL1B5cVhQR1lRNWFNd2pjRGdP?=
 =?utf-8?B?aWpOWW9pQVA2eWc2aGJ5aUJNSFNoMnpoa3RGU1BmZDg4bXBIaGNLdk5nemVP?=
 =?utf-8?B?bHovM1hXK3pvUzFQREZrMDZKNkNQbWhGMnovMGU1TFdEbkF0TWFaRjF2VjZ6?=
 =?utf-8?B?MnBRUXErVjFBUGdLcm9LL3lwaWl5M2Jsc0tKM0JsMzQ1NVgzUE5CLzhnUUFP?=
 =?utf-8?Q?4z2kxs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rjk0bytmQjVvOFpmTFl6VWVZdHhMZ2NJK204RUV3dWVVbVMwbGdRakg4YjNP?=
 =?utf-8?B?L1QzTEprK0dvaGlFRTY3cGRTR09OWkZBVDBzaUNxakY3a1VHVTFFc0xDUEVL?=
 =?utf-8?B?WEVRS2pkbVJ5Zk9BaHM5OE5RZzQ4ZXZDOU04bEtLN0ttMG9ubFZIZTJpRm91?=
 =?utf-8?B?dzJQMm9vZ3BzMk1MWFF4dWlyZ1JDa3VQZE5NM3JNWWN4ZEV4dTMwY0gxM3lq?=
 =?utf-8?B?Rkl0ditMUGZRdXlsczd4dmZBNmNUbThIYzFCRGxET3lzd2F0TzlSeE5FdWVU?=
 =?utf-8?B?RTlQY3hQYklIYjJnVHphVzZNM3FiZzBvd1M1K1JtTVIyM3B6K3lEaEdxcklG?=
 =?utf-8?B?eHhKTmQrVzdYL2VZLzQ1RE5haUVZdFlXSm5TWlpWY2lYSWxlTXptVnM2K2Vt?=
 =?utf-8?B?dDE4T01PSFN5UUtuSHdUejlIMCtYMzNQUGFiRUVqVXJ3azgrRXFwZmRhRDNQ?=
 =?utf-8?B?bEVhRDJjOS9RMUJ1Qm45OEVlZW1raXdvNHVNRjkzV2o0K0ZhZEptck1BU2Vn?=
 =?utf-8?B?dWMybUZMalFId3N4Y29QN0hGN0ZqbklhMnFsV0VTcklIREFNbDlIaTB0VWhX?=
 =?utf-8?B?K25aOXpCei9wYjJaMWk4THoyeFhqVkVIMjRXZEdrWGZ5dkY1azJZVWpUVGk2?=
 =?utf-8?B?WUNaTXoxWmZMVis4YWN5TlI2RlovYVBteWNWbDZzbWJubk4vS0trNkxBUVdL?=
 =?utf-8?B?aG85c2g4bGoxQ0c2bTZ2L3p2a3hmNjNKcGdISElSRVlwQTlzVUNWOWwraHQw?=
 =?utf-8?B?YWFiTmlvL2xoeTlsTzNSaTF2OTI2dGRwbXphWGI1eVk4bW1Ka3BMa1poeDYw?=
 =?utf-8?B?NmN3LzJRUHpDRzAydWgvS0swajNFaWdmWC9LT210UTBJc2k2TUE5Q0l6ZFJj?=
 =?utf-8?B?WHBXcXZCVXZNaThvT1ZyQ1l2UTBXK3pYWnFwQkE4V1R3VUJWRlB4Vmdma3Zk?=
 =?utf-8?B?MXAyYXdONmpGaTZ0RTg1U29oYksweHdpcTMwRXRKSFpGYTRtaGFydmZaYWJm?=
 =?utf-8?B?T25xbk96TUlad2JyMjJwajRVMUJXMGgwYVpVNktKVzZzdnJEZFNSdFhJWWZQ?=
 =?utf-8?B?U3NYUFozczF3Q2hQd0g4NHpBaERkWFJhMXl0V3lwM211TXluTmpsb0wxeTYw?=
 =?utf-8?B?dnZaUG9pRS9MV0NNWDVUV0hmY1VQbGNJcThvV0xicUQvWEZUZWtxV0ZVdnRy?=
 =?utf-8?B?Z2hWNi9sb3BpNzROK0l0a3dvU3BNeUtXaE1FTk13M1N3Y2NCQ1kweUdoYUxP?=
 =?utf-8?B?N2VSbzV0d1ZKdEVwcDN4cW10dVNXaGM1ckJhWVZrOW1LUXQ1U3h0eEp0NC9H?=
 =?utf-8?B?YzN4czJFcHY4SXJ2MHZSYzYreCtqY1VZVytuTCtZRlMxMC9jWkZOL1hJWUFC?=
 =?utf-8?B?TTFDZmE4MGxMRFY5ekFoZmlBS0NwQklDRS9LMCtVSm82WWRhRTFybHE2UlBH?=
 =?utf-8?B?WkpOWHJXaC9yQkFVRk83dUVndy93QVFQdUNwZ2ZBK3N5L0ZzQytjU1J6N2pK?=
 =?utf-8?B?Z2NMRzR3N3ZmOGxhemlTVWJxV2hWL0pqcWV2aEphS3ZZejdBOFdocldqQk52?=
 =?utf-8?B?T0x3ZTRkU2wyUzNlUkNBTWFOSHpQaU5icnUvYmtSTm9aZ3RNaDg2aitMVXV6?=
 =?utf-8?B?VWhFOHFzM0FqbU5Rb0RQWFJkYy9pNy81VGY0L0pVV1ZXeG4wRVg0VHVOc05F?=
 =?utf-8?B?OW1TSFUxVVBuK2NFRGJLY0tYNmRVY2hFbWZQbUNiOVhYQ1RXV1dVZkp0Y0Mv?=
 =?utf-8?B?MW13aUZaQS84bGlRdU9JeXcxeXVCSlVEWkJBNWJaUlo2aG1aWnMyUHVrNi9v?=
 =?utf-8?B?a1Y5SC9jNWxNazhEOVNQWk15ZVBNMThUcXdYcWxITFZaaW85WTdHR0xCUFdu?=
 =?utf-8?B?RmxwL3cyM3dzWG16TGpCdHh6Y3hjaFdRWlZXekM1a1Vqa2VieTdGT0tDV2Rn?=
 =?utf-8?B?bklVM3B4aHp1ZHVxRHhGMjE1dWcxWlZDcTdTZm1wbk1yaEF3OXF6T0ZFMEZE?=
 =?utf-8?B?bFdkaWRCdUE5bjNoYkloemlTMys3aXg5U0Ztd3hZWVJobTVsVEJXdXZHYTYr?=
 =?utf-8?B?T3hUVEg5WmV2TGVlaGYyYmtxczZIS2pNMWtHYVBhVzdObmw1V05yL1EweWRO?=
 =?utf-8?B?dEhKRkR1cGhZZEU3c2x0aVA3RlAzOTZOQk9NS00vK25UWExqT1h6a3VIdnNk?=
 =?utf-8?Q?Bv+gPrG+TUfZzTjE8T932ts=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21AD646B7884F1489C543AE6D7957F9C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83853f09-e47f-4faf-3280-08de1b140fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 20:03:31.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zudYlaafDqtI6MIsTuSeMluT2XtgByjKA1n+8bm6YATchjwTsXHmMXU3g8DGZDo9rWqCx8lpcYK6/Z3pNR3gzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6522
X-Proofpoint-GUID: qX7YL1Od7Fzy9LPei2Al1O--3P3XWqyb
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=69090a98 cx=c_pps
 a=9fOKxQ6q+1oHddUNM5AUXA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=cTB1gfLUPZyutIN7_PYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yBpUC6CANpubu50aLvwYAFLwMSGkrP7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX2yd99xq5+XR4
 KsI1C66AzQtwO0tY/97ybldMCRjFNjzAs4Xi/lZzw5UotVxfxkylu1yuuJFQwGs4y2D/KosBASd
 cmeTVf5pyaQI+9dFPstfvPSpu7dgmo4q4A71DRXcR5zo0YoD3kuzkWBUXaFQmJ7D4Z1NK/+JQbH
 W/1ys3c4v3rPp5EdQjut5mUSu/gDTNqszkPxG483bJf+y2Fx9NfnYlcyFi8d3EAg7TgFj4sujeI
 57qt8ppjY2QsTtEIstKY1gIB9N3RNct6ruiy8sy+beYHTGdXMBedphXfzaCHRHTn+9h7trTwPCU
 rASw+M5225OBbUmRmZeRFGlg1zso7xoWiMVs0o5aceGPkX9BrDt4B1w1eqDffSBlNEp/tbulhcK
 q5MJs+P2grlgY+eSdVJjc8DtxtTgiA==
Subject: RE: [PATCH v8] ceph: fix slab-use-after-free in
 have_mon_and_osd_map()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

T24gTW9uLCAyMDI1LTExLTAzIGF0IDIwOjU4ICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIFR1ZSwgT2N0IDI4LCAyMDI1IGF0IDQ6MzTigK9QTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gPiANCg0KPHNraXBwZWQ+DQoNCj4g
PiANCj4gPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCB3ZSBhcmUgc3R1Y2sgaW4gdGhlIGRpc2N1c3Np
b24uIEkgdGhpbmsgaXQgd2lsbCBiZSBtb3JlDQo+ID4gcHJvZHVjdGl2ZSBpZiB5b3UgY2FuIHdy
aXRlIHlvdXIgb3duIHZpc2lvbiBvZiB0aGlzIHBpZWNlIG9mIGNvZGUuIFdlIGFyZSBzdGlsbA0K
PiA+IG5vdCBvbiB0aGUgc2FtZSBwYWdlIGFuZCB3ZSBjYW4gY29udGludWUgdGhpcyBoaWRlIGFu
ZCBzZWVrIGdhbWUgZm9yIGEgbG9uZyB0aW1lDQo+ID4geWV0LiBDb3VsZCB5b3UgcGxlYXNlIHdy
aXRlIHlvdXIgdmlzaW9uIG9mIHRoaXMgcGllY2Ugb2YgbW9kaWZpY2F0aW9uPw0KPiANCj4gSGkg
U2xhdmEsDQo+IA0KPiBTdXJlLCBJIGNhbiB0YWtlIG92ZXIgYW5kIG9mZmVyIG15IG93biBwYXRj
aC4NCj4gDQo+IA0KDQpTb3VuZHMgZ3JlYXQhIExldCdzIGZpbmFsbHkgZmluaXNoIGl0LiA6KQ0K
DQpUaGFua3MsDQpTbGF2YS4gDQo=

