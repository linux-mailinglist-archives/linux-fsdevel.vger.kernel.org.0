Return-Path: <linux-fsdevel+bounces-48389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6DAAE304
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E0540E3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2828B7E6;
	Wed,  7 May 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QZutaihi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127B4B1E69;
	Wed,  7 May 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627760; cv=fail; b=ua4SIh9UW9DJdjsz3EdpicU/Is0kY++WeDp6VZ8HAoTiKCicvKfqbeKv+HdmaNTO+oBPUgbF5xtjHofdfcDVOC7c6iyqQjeedNXB2Z5ArLCU9qdHdBRx17QyokXpOi4xvNWWv/D3UKI9TP6x1zsrrdiUZ7o9QdJ//1afo69AU9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627760; c=relaxed/simple;
	bh=RjWyXTDh8+5fiTJxC5BAhtDMycrZhsnOAc44Uz4b89g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQaKVv25ef4eH3L9YleCWrEAZa4O3hkSNGVXjm/bIevJ1/HJbOaeZfS3JZpu39szP5DmO0eGXpfH0nbnevhkUrtpRv+vQ13e+4jVMNEiimRcgyn4ImpPY7PWRPvEVoLfwFPv2mpbrh251aeoNcDBKFl2GKZooERfM1L9G4Y4htE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QZutaihi; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvmzUklKHsoP0pRktpqOt3sIF8XiHwdUZBx4TwqeXuUG3+Xkz1GuyFe/6Y+sehqp3vMeSzgWMqBvI696ZXVy6l/FOM0aH+Krr40MEepFKdODIlK0aubiOu1FERLCCpLXZBU4x360VxNFepIOhglELFSE2WKZ7NH29O+qVzdsT1HPZiFfJHpwg9FnXPjUzQqcMByl19ZslHGTOJhyo+AAcAWAWirNx3nvgAKZtJOLGkKdIzQE4yQ2vQZQmcUxyHovW1r3ZX5geFbb0Pu3CX2xJNZPLdhvdzboOnUxJRl0Gcue1Q/hxhgOlPSdVr9h2uGAVLCPEyrHO5eeTJFbdmJeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjWyXTDh8+5fiTJxC5BAhtDMycrZhsnOAc44Uz4b89g=;
 b=bkNBkcsgAkr0V8qDJvgYJWrkGvT3ysfYJpH5p+mGlEZ6mtx02x910Fq1XaQ0ZVTCL4X8B+aFqhfW66O6OkgEBKIGhZmWQjl6EiyigQqAAozTrjqj7k8b4YuIuw35fz55YwX2YXihVP0P7NcyFd2PTu6BgCIfg0YHuXh2UBCl53loT5eoEojHB9Kf1ntTmwNkf/UlwRivT0Jgh9KMS6nbdZA0HLSZNXH9JaDdAm9TScjPeFK9h0Bxx0d/ky7Se8dQYbQNH9/kAf5AmDeKJed9tKtQcNRvX03hML8tI0mlc0uEyiUChkvv/dYctU7pH3OJ/tmYI/t9PycoH2oVdSg6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjWyXTDh8+5fiTJxC5BAhtDMycrZhsnOAc44Uz4b89g=;
 b=QZutaihi+PnUVdYtlryBp/ofE3MruVnTl6vCsNc1dl3xDK8GDTd5+UMCH9osWIB4/mFR1mweIB/KPCgGQGR7moIbCbWKWzE+zM/+yeUczuoXdbe8omZw69hgfA8xeoCFqJ5kzMKaaZLK1yldGkC/GsMKu13hDWKW+kew2+Y+JN5xXjOIA7XoxMJGwLsWzUOvObyr6da/h6RGL/P/HJf3qUDWoWgf6apBIH9ktbvy0JTHYnB8/4aNOumPoKaURGgycw0EtpjncAPUu2MG4la9ZUwQhlCheM053VJSvbF/xVB/PE0o7F+IpSzeL7EjVJE4othZFfDsl5REbT7JRs/1SQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6365.apcprd06.prod.outlook.com (2603:1096:990:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 14:22:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8699.021; Wed, 7 May 2025
 14:22:33 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiAgW1BBVENIIDIvMl0gaGZzOiBmaXggdG8gdXBkYXRlIGN0aW1l?=
 =?utf-8?Q?_after_rename?=
Thread-Topic: [PATCH 2/2] hfs: fix to update ctime after rename
Thread-Index: AQHbuUClFvj8998Yt02X7oeCaQIiKbO+eNaAgAjKn9A=
Date: Wed, 7 May 2025 14:22:33 +0000
Message-ID:
 <SEZPR06MB5269E572825AE202D1E146A6E888A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
	 <20250429201517.101323-2-frank.li@vivo.com>
 <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
In-Reply-To: <24ef85453961b830e6ab49ea3f8f81ff7c472875.camel@ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|JH0PR06MB6365:EE_
x-ms-office365-filtering-correlation-id: 70c49406-6b5c-493d-067d-08dd8d729b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czVqV1Q1dWpmRDM2TlZDeVJGczd6cHR0Ri85RUVFcVdQV1JmOVUyenpGeXU1?=
 =?utf-8?B?MjJpRUhGUUhnWGlsS0MrSVZ1UkpkOEJFK2FpRE1YblMxdG9nMm1scXRrVTIv?=
 =?utf-8?B?dU1lQlJPVUp3QTRNZ0lyNmZxVjhFU3dZQTNVL3UwS2sxRzQ5dWV6Qmw4aFgx?=
 =?utf-8?B?M3dVUytGRGNReEdZU3c2RWhPd1hydEh0a3ZwdVpsVy9DN0pZQm9oeW56T0lN?=
 =?utf-8?B?enZPc2ZSU2J6Y0NDNm5WSW04MWI2L2Rza0hET0E4bC9TRHRVZVVEMnlsVXBT?=
 =?utf-8?B?TXlIQTRHcnQrS1o4ZENCRnlLM2dYVk1JQjhEZ2UrdlU3ZXEzN1VWQWxUeEFN?=
 =?utf-8?B?TytZSjE5eWNTTzBSR04zMytrRzdERlI2YXJQbmw4UXVMMm1Ea0poOEwvRGpq?=
 =?utf-8?B?eFpKZzJhT09uUXNLZGFkRGJPdzhUOFZnQ2ZvSmtYOVFVOEdBRTByY2JQQ2Zp?=
 =?utf-8?B?WGorNitONWlWend1aTJacC9rV0RDdGtWWThNbHl0Qmx1UDNpeUVPdGs4MzV1?=
 =?utf-8?B?Q0cvOHN0VmhNVUV3cGdNR3NZTTdMMVdsQXArYlJQclVqaFpuTzJ1MVErdXRp?=
 =?utf-8?B?ZGNkQUhZVDY2RnRvdFpRaWFSN3VsY0JuVUVYN0U0VTUzbWFCTU5vQ3ZuUHBO?=
 =?utf-8?B?c3VKQ09ybDgrMHB2ZGo0RWQvblo3VUtmS2Q0RTltQktvS1JqZDdVa2U0TEV6?=
 =?utf-8?B?WWVHbTQvZzAybm42TzBQdFVUYkdPeTZVNGEvODUvOTFTeXJoa3dNU2VyV25H?=
 =?utf-8?B?ci81b3BPUmQ1RVVodzJtcTZWV0lBUWVrejN2NnpReURpZE5ORmh1UGlMenZG?=
 =?utf-8?B?TG1PRndsVnVFSkx1TWFJb3p1cms4a1N4dmhOdUpjbHoxbVRETTRLREkxTERa?=
 =?utf-8?B?UFpkMjdGWWRwMkVrWHQ0SVIrRnhYMjFTbVFCakVBNExrdHQ5T0J3NkdDOG4r?=
 =?utf-8?B?S2xmWFg2T0lUODV5L0l4QVF5UWNvSldvYVNlOHpEOVorUktONFFodVR1eGc0?=
 =?utf-8?B?cnROWWJGN0g3cmdoOFdDUmN0ZlU0VjNVQzd5YWluWE1jTVdHblRGU3hOL01L?=
 =?utf-8?B?VXc3RElCV2c4N094MEZ0ZDBoeXdDcnNBK3NNeC83aDRiTFFKam4rZW1TNVkr?=
 =?utf-8?B?K1pQRExhWFpBc0tBZ3YrZW8zOURCMCttdHJ0TG1yVmRya3k0QmhGcTM4NmNH?=
 =?utf-8?B?emVDcTFGYlRnSVFSTjViTjlXenF2a3pORS9FL0NiMXN1SFJ0STRuNE9tWXNS?=
 =?utf-8?B?VEN2WEk5ZG5zZ0Q2bVJpdEs4cndkVWcwaS9nY3hwZXdZcmg3MHlCaFV3TzVH?=
 =?utf-8?B?RzhkcDBIbVd4cG9kNVpBTjV2OTZTMWZWcDFaMGlaYnowdlgxazFHRGZOTFkz?=
 =?utf-8?B?M01ST2kyRnd5MXN5OTgrTGR2c2xMamlaQ0RBZ1lPZG1RSVlRODhLbGFJTzdF?=
 =?utf-8?B?RW9aakNIZzVZWVRmUXo1Q2VSbXhhMGJUQ280ZDBaY3pleHZxNjlXSGZrYUlo?=
 =?utf-8?B?OEZJZWlQK09WVmFhbGluOXgvYVlvdTBSVm1HamtjQmV4U0MyOHA1S1RiRlBB?=
 =?utf-8?B?RHY0T2NCSGlqRG5wUWt3MlpNQXN1d0RlWXdWZkE0eGlBaXBGUXZXeWN3dHpF?=
 =?utf-8?B?VFA2dG1MQlFEMWFoaDVSSVBqNTY4eVZzVjZ6SW5LUFFXeTUwR2VuWUFzMEdj?=
 =?utf-8?B?V2k5YUdGWUdrZnkyTkhsWWkrdUc2SHI5Skk4UkxZTEpKUHJtRkVmd1VhdWNq?=
 =?utf-8?B?dXhHcFE2WnB2aTFtMjlNMWk5WE9POVZpbCtYTnhYYUhJM01HMHRVMGNKRmQw?=
 =?utf-8?B?cDNjdzVwa3RrUHRCMmQvYkxtWFJhSS91MVBjLzBlakdtclQxb3ZQNnQwcllk?=
 =?utf-8?B?Z002N2N2dU1uMEpQNUdqTXFhL0ZhdEMxaGtqajRXSnAydW9Td3Bra2ZaN25J?=
 =?utf-8?B?TFY3NlM1OEhDR3B0R0NnWEFQa1hURkJXMWpXNFZSc2t1WExBUHpjd3RoQ3Rw?=
 =?utf-8?B?TjJpSFJtVFNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZndYV0FRdWR4Zmp2Z3kwQldXN3Z1TzlJWEVTa2hDMlBVQWJvYXRiNmlaWWNK?=
 =?utf-8?B?SmdhOUdJSFJVUlRSNVYwTDU4Ynk3Slh2OWlaZllrLzYvMFgzc1Axb3pXSFo2?=
 =?utf-8?B?RmppaWtTdk9QK0FJUUs4RDhUVFJDZG9lMUJPV2dtMEZLcmxuT041MVVvTnI3?=
 =?utf-8?B?YmZQZTdpT0FRZERoRlVCSFJEWFBDMjYzUHROUDdjWEFra3J1UWlQRENXdSt3?=
 =?utf-8?B?bkpwYmNleFlEVFFiSXFyZ3p4a0lQRm0yT2xrYUo5NStCSjl3OU5BcUhxYzFC?=
 =?utf-8?B?bXlwLzFKTzlPdWJlMEdNYXhLenp0NkpJSGZPSm9oMnQrRU0xcC9xNVV1MTRG?=
 =?utf-8?B?V25mcEhGUFZvZlArWkkwYjVRdDRnRkdIN0J3NzM4K2VoR3RWRVRocVIxVndq?=
 =?utf-8?B?M3FScTYrL2JEeDhBb1FZNi8ybTllMEhVUlFHK0NiR0tBcDBXZ3lhekhhOGJK?=
 =?utf-8?B?Z1o0Q25QYjFmVnlDN053dkZkM2huZTJRQ0xnVEJKYUx3L05nK0l5YXdpSC9L?=
 =?utf-8?B?WkhnR0dYakpRRUJjL29HMmkwcVVRQmpIZlhpZnZ4ck9rSGRjVmhpTmdTdDN3?=
 =?utf-8?B?dk5nN2lWS2hsVjJFNVVyY0V5T0h4QWF3cDBXVmJDWUtjQUoyaXBuWTFEOXAw?=
 =?utf-8?B?Z0VrSXdYMXduMHBwdmpxcmtsamJZVytZR1Z1d3pxUEx1QnZ6dWJWdU9CKzJS?=
 =?utf-8?B?QUM4Sml6bUJudG9YcjN5RTMzQ1M1RzYzMWZLdjJkVm9ZeFR5RmVOWVRCVkl1?=
 =?utf-8?B?VjFETzZzR2pIdmdWVmt6cnZ2S2dEVkFFeGhyYkwwZ0pZK1Axb2tIUjNVTXM2?=
 =?utf-8?B?S2NEdjM3YW5aaUZQUmdHblFaaGw5MVdhcnU5d2V0L0UzbU9OQi9OMzV0OHF2?=
 =?utf-8?B?eVZtRmFZeWFvTlJlK1pmMUhvMU55Uk55QXJKR2tiUHpGVWRGOUtXU21RNHVW?=
 =?utf-8?B?cmtpWlBqdXROOXEzOVhSUUtlQjUzQ2kwY1h1SEN2WnpiSUJIRTB0U0xoOHhn?=
 =?utf-8?B?T1h6VXVFNnJKU0JBaXdDNmNHUFhtRlVpYitMMEdKSVZjaWwzQkYvaGtDRzk3?=
 =?utf-8?B?MzRSRm41MnkyZW1nck9VYTlFV1cvVThSSVM0bk9jRzJ4UXBoUGtmVnFCNDAr?=
 =?utf-8?B?TkRVck1XY3d4bW9ZM2FHNVVnWmdRaUpiOTQyc3Rrdkl1ZHI4VjdhMG84aFVP?=
 =?utf-8?B?MGRaMHpzdndYbE1jSUt2V3Bkbysyelpwb05zSTAxUERWM2VWaEhVdms5U1pu?=
 =?utf-8?B?RVVkRkFqZG1wQ3pNZjdub2RBVmk0VzJsdFA2WlBreFZEU1N2Z3lVMHpWaGF0?=
 =?utf-8?B?WFMzZHV1T2psSGYzblEzYXNFUFI4SGJMUFQ2MUhoZG5ubzJiS2Q3U3diSW9l?=
 =?utf-8?B?TGtGVHk0amdjc2VFRVZOU3RCSlNpdTBoRnBPUkVrWGFiWCs3NUUwWlNRQUh1?=
 =?utf-8?B?M2Joc1BZVXE1RVNjR2hkakd6dnFjUnBHQ0NyTWh4SktCaUp4OTd3c0c0dytE?=
 =?utf-8?B?VVRaa1pEdE9sT3dsUDRJZi9jZ1cwR2ZjcURRaEhtNnlqNjFucG9QZ3p1RThr?=
 =?utf-8?B?Z05nbkpqSk5NK0FKMUFYOThtVlltcUx4dTYyQ1REeXRhN3BJWmFZdUpJUnBD?=
 =?utf-8?B?YUdjMDhpcUdzY09XTU1Ja0x2SGdZMDZtcDc1bk1xbHNGbFVCRENOZlJsZWI3?=
 =?utf-8?B?Wmhwa3RYNGtObDNuZlB1OUwrN3pRQW42dUVTeUw2cnd3SWl0RlhwbHU4bUtT?=
 =?utf-8?B?SG1IWTZrUzgxMHZoSUZ2RkowSDVTWjRxRUdIaS9GZEZHMjRsZjk2bUszUWor?=
 =?utf-8?B?WXFDanFNM1VUc3c3a2hMdDJkUytQRVNOLzlHdWVETm5XaXd4dHZ1ZWdJVDBG?=
 =?utf-8?B?bWtPL3IzK0lRSGRmTHdRRk1YNzNQSEVUMUo1am5zSldIOVhqL2JFTHBFdGR2?=
 =?utf-8?B?K2M5L09mSmIzUEZSZ1V6QVA4b3M4NzI0aktRMEVGMlpTV1BxQTNjZVA5Q3Rs?=
 =?utf-8?B?SjViMWpQR0lkT1NBRk96VjE3TVdDL3o3dWF6VnZUaXNscXdYdXFPWGVER3RN?=
 =?utf-8?B?emJuQlFuV1JpZU5ZbHEwalFzMWlwWk1wRkx0YkZDeUZwWTkwVGt3QmtMYnRm?=
 =?utf-8?Q?xufI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c49406-6b5c-493d-067d-08dd8d729b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 14:22:33.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WbXm9FiNcMeO7kHWRCrZNZZM7ahOnQmvCWMtEmmRNt359PhQSQQoWS4xrLsI/OUEqrPrRAreb7M+9um55Y33Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6365

SGkgU2xhdmEsDQoNCj4gICAgK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdlZCBmb3IgZmls
ZTEgYWZ0ZXIgcmVtb3VudA0KPiAgICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFuZ2VkIGFm
dGVyIG1vZGlmeWluZyBmaWxlMQ0KPiAgICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFuZ2Vk
IGZvciBmaWxlIGluIHJlYWQtb25seSBmaWxlc3lzdGVtDQoNCj5JdCBsb29rcyBsaWtlIHRoYXQg
aXQgaXMgbm90IHRoZSB3aG9sZSBmaXggb2YgdGhlIGlzc3VlIGZvciBIRlMgY2FzZS4NCg0KVGhl
IHRlc3QgY2FzZXMgdGhhdCBmYWlsZWQgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCBhcmUgYWxs
IHJlbGF0ZWQgdG8gdGhlIGF0aW1lIG5vdCBiZWluZyB1cGRhdGVkLA0KYnV0IGhmcyBhY3R1YWxs
eSBkb2VzIG5vdCBoYXZlIGF0aW1lLiANCg0KU28gdGhlIGN1cnJlbnQgZml4IGlzIOKAi+KAi3N1
ZmZpY2llbnQsIHNob3VsZCB3ZSBtb2RpZnkgdGhlIDAwMyB0ZXN0IGNhc2U/DQoNCiAgIGRpckNy
RGF0OiAgICAgIExvbmdJbnQ7ICAgIHtkYXRlIGFuZCB0aW1lIG9mIGNyZWF0aW9ufQ0KICAgZGly
TWREYXQ6ICAgICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2YgbGFzdCBtb2RpZmljYXRp
b259DQogICBkaXJCa0RhdDogICAgICBMb25nSW50OyAgICB7ZGF0ZSBhbmQgdGltZSBvZiBsYXN0
IGJhY2t1cH0NCg0KICAgZmlsQ3JEYXQ6ICAgICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUg
b2YgY3JlYXRpb259DQogICBmaWxNZERhdDogICAgICBMb25nSW50OyAgICB7ZGF0ZSBhbmQgdGlt
ZSBvZiBsYXN0IG1vZGlmaWNhdGlvbn0NCiAgIGZpbEJrRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtk
YXRlIGFuZCB0aW1lIG9mIGxhc3QgYmFja3VwfQ0KDQpUaGFua3MsDQpZYW5ndGFvDQo=

