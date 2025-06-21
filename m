Return-Path: <linux-fsdevel+bounces-52383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F338AAE2CDC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 00:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B457A835B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D142741AC;
	Sat, 21 Jun 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxUe26ZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1201DACB1;
	Sat, 21 Jun 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750545554; cv=fail; b=CUg7+g7UCr9BnHDn+a7x9zcrZa14ltT5ghrc1+9iV4odIZc3rVBk5Yj5QnLElWv/2qRU3lE9aR4+nc6x38bLxFFV7T/PqYdf7oOSdn9ew9bTuurUOJ5oV1GJaiTIxapmya29AO48729Zx5ddn79JAl7dizcGSLhQGcot8XzkwaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750545554; c=relaxed/simple;
	bh=4DzDtOdr3aOOfl9WO+YvqBZFujHBOBpgXmPTUs+Lf1s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hFCzvC2RtYItz80rEKzrDtk65jW7/jwSfvF6BcOC2h3obSdPREX7lYcxBKBBJxolq7i2Pl4BXC6WbxHGEOfv46fmQRL6552+q5vg0YYvvKP2i/T6XUCW/VX74QBcXnAofMjsALerOfUWOs0QEAq1NbSZ3XopdosTO49ZM+ESPs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OxUe26ZX; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LCPtj1005178;
	Sat, 21 Jun 2025 22:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4DzDtOdr3aOOfl9WO+YvqBZFujHBOBpgXmPTUs+Lf1s=; b=OxUe26ZX
	lbKpKiFl7Q/VRfCp7zBjtW6HSya3657NKkimg74ja8BLZTLzXbwRyH/CCm4iZisU
	66P8/UO4auLS15ht5UZ2bA4H2hUVu9r6CI0pD4t9QO9UxN2zm9f5pduKOISHD5Ov
	50e1rdMZ7xaIDV5nfBP95Z4GvurHmFNGLY/qUTw3MYX4EluHj3TEhAzXaXiZyGOs
	t0My9IDvgjJyYeJU8QxbceP4M+HzK439wGJRKnaZY2Poa1nb0h9qcgKHjNEDArpu
	KriN7cWt5jNw0FT0TuBqWYkVS47evVPbv269rCzQNXNb+SHoNjb1EKuYFm0TG1hF
	Ov1nEs0SQpLUGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8htvuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 22:38:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55LMZc9a016573;
	Sat, 21 Jun 2025 22:38:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8htvut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 22:38:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG5RJ9pibuohx6kO08JFeP4Eco5uqynpo/V2wDNGnIl9scvVpPvyme5Buh0JIl278Yk4pGhjKpTDxQZ1US26DzjI33vAi4JszAATqmvI+tp3rOmGz47Q0Bh/iCdbPQzzJuggzHNrRvJsTtjsx/EDzt4TO/l7jp8EqD/bv4rA8T5YLupaLEuov3HdK8oR1+8U0WCRxiPwnJReeGhnM5LV0tuHseWcBXfL8T0iFDfmO431jUFEgBIBunTV/x41rjJDduVqj3lmSqun5noRq6SWk9P9h83gFmlzQE3gKL6AbLVNSP9jpjymrwQRJC5lIT8F8MoIfDMPBk07x//lpuQxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DzDtOdr3aOOfl9WO+YvqBZFujHBOBpgXmPTUs+Lf1s=;
 b=lg5616p5hyhXGykyhQhmsZUs60Z7pTHekJF2xKKtVP3g3Aiznn0r1uHGwfzhqc3zyopVazSiu3ur5RDmuVpp8rNgHyVp+0oOg+hZU4ovsHQgPjuEZu+Bv5cR3TxLjLjMWtiOdOQHSpu1C6n+ZZiyIa4nWBdymDarzlq/IYFojyasAJC6XTVZ2XaY+DLzUIulJtG/VUoCd3ojy84PufNNIk2Quj52h4Hyo2afOUWV+6mgq7cPJ6sTZ5h1U/JqDFsKCcJmZR71wxOR7hFq1lT1HyPMEiiE0qwyVfs6W3EoYAdjjUqyUG1Gl6XIGcmwZIbYVq3aZj2GJ1t+OvuTSqXjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6628.namprd15.prod.outlook.com (2603:10b6:8:1f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 22:38:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Sat, 21 Jun 2025
 22:38:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>
CC: "ariel.miculas@gmail.com" <ariel.miculas@gmail.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>,
        "lossin@kernel.org" <lossin@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index:
 AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoCAIsotAIAAIzOAgAAMqYCAAUS4AIAABtMAgAHdGIA=
Date: Sat, 21 Jun 2025 22:38:56 +0000
Message-ID: <c3786491d6ed5fa10a27e307631253e97c644373.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
	 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
	 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
	 <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
	 <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org>
	 <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
	 <CANiq72mUpTMapFMRd4o=RSN0kU0JbLwccRKn9R+NPE7DvXDuwg@mail.gmail.com>
In-Reply-To:
 <CANiq72mUpTMapFMRd4o=RSN0kU0JbLwccRKn9R+NPE7DvXDuwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6628:EE_
x-ms-office365-filtering-correlation-id: 40f0a96a-37e3-444d-f77a-08ddb114683d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDdWNTMyZE5jaE41Vzgva1lDT1oydERwVS9ZNDhzMGptc2s0Um1IWEc1WlFm?=
 =?utf-8?B?RnduQ2dZYzcwU1BScy8xT2xJdzVXc0JGUE5JTkNMUFI3Qkd5MmRadHlhQmEx?=
 =?utf-8?B?SUs4UFlMYVNlMEdkaHVBcmF4VndzOTVyL0VMNVZWRXlVamtHNTVSdHoxekl6?=
 =?utf-8?B?Q293cktJYlRDZzFIUEVnSHZ2VHROeEgxRFltbDFVREtmS043Z0dVK0lFQnlV?=
 =?utf-8?B?VFI0bS9wNTcwRStmWStETnFFR25LT3IyQXhNNGdkaFgxWExVaVRDYkNRdWNX?=
 =?utf-8?B?OTU5U2RtRGtlYVgvVGdsMXk5aGg0dWpsTTk0Uy9PY2Frb0g3NjNXaGpmZW1p?=
 =?utf-8?B?UFZlUFp1U2ZZMXlQYTZGeXo4M3NNTitVQWJra3Q3c2hkcGRlWXAvZ3Bka1ZV?=
 =?utf-8?B?bHExQVpGMERJTmRiSXA2a3hielIwdHpvY2pidXBuWFVuMHZRVTVkTXlQVFVT?=
 =?utf-8?B?aUdqbXZLTkFZamZPZnYySkh5ZUJjME03TTNHNVdVbGZGcFlNRUZSVmY3Wm9E?=
 =?utf-8?B?MTh4N0I4RXpBTFV6eDZ0MWlSaVo5NGY0aW1sbzV1THpqd0M0TkVwNGNTcTFo?=
 =?utf-8?B?TUQyRHNPRFJMSGFqZFlpYkZBQ1hpMW1Od3JMS0RFZXNveGJjWTNqU25mampX?=
 =?utf-8?B?b0ZyaENvQWVJZGEvRGx5VVpxM2tSMHVvTEJ5MGFpd0p6bWpZeURaZEFCaCtY?=
 =?utf-8?B?cW5ObG8weXV4d3BhY0hDZVhORmhYaDMrY1RiUUxRSERvWEQvRk11R1Zza2dn?=
 =?utf-8?B?dWVUdGN5eVVFbE1VeHRWOGgzeENzLzM1M2Y5ZEh6MnhjUnllUjBaK1hSMkky?=
 =?utf-8?B?RzFvZFJUMlRYV1lHWm53ZWczNWJkZ3RRQmNqclE0dGR1ZE9aZStBNUZkMVh6?=
 =?utf-8?B?RGVsNkNVNXVQbXFGTDZCM3N1Vm1oZG9uWEtFQjlZMm5MeTdidlptNFFoR3NP?=
 =?utf-8?B?Nytyb00ydEkrZW8wVXNmZWVXa05TckpDd3RHM3JVVjdqT3hQOUxVU243Q0cy?=
 =?utf-8?B?WEd5NXVrZ3lydFh3OVZ0WDNLNm16enppeUZ1TGlBaVp1MmZENndsVElkNmFP?=
 =?utf-8?B?OFcyMGxEMkJlZzNrS3dQaVFLVkt4STZWQTAwQU1PbE1TYmtweHNDNGFaZU1Z?=
 =?utf-8?B?QXg1dktFSnV4d0QxRi9QTzVDVE9CdDZ4MFI2eU5ZeXBLNGJoMkJ3RDYyN1VT?=
 =?utf-8?B?Z3BlZWx6dHRubkZEdzBqRmo5dHZwSUM4TFowRnFjYncxSkZhNFUrd2FMNWVp?=
 =?utf-8?B?WW1EL296dHJEUHo3UUtLZUZ0MFVQREJMUjVEYXJUQ01Jai85QUtaU2UvTXRE?=
 =?utf-8?B?TGNGQlcrNTFNL2VlMVlMYW03eTZuNnR4dDFYbTI5VmRsT3pjbjBXLytpd1lK?=
 =?utf-8?B?TjJFajRxUnNtNHY4R2t5ZkI2eHdja1JTbzR0USs2OUwxZndaRnZDSUJhUXp0?=
 =?utf-8?B?ZzBqZmd2cDlDZkdPazQwOS8vNDVrZWtuekNOL0IwMHVpRWZHUEVxaktxaXZZ?=
 =?utf-8?B?NXpQcnJpTHYyd0h5cDQyZUViNFNOVEVWcVNSYThvMUVaQjVZVjhIcmtnWm85?=
 =?utf-8?B?ZExMK0d1czlKS2dSWC83UUNrMllLWkZxRC9UZnc3RlFjSXNMOUZNQkE3UGRD?=
 =?utf-8?B?MDYwWkdMeFRvdTZTQlU2NG1wVmNka1RjWEFLaWdFTlhRQ3h1MFpsQWtpdkZX?=
 =?utf-8?B?Q1VEelpZWGNIZDdmMWt0eC9ONzhjSjZQWUplb3VvVTdQSnVxYng3T3U5SndC?=
 =?utf-8?B?bWsxRzVKV2U1d3pqeEgvK0p3dnJWdGQzZzhkTklORHp4cWJtYlhxWGxoSTZ6?=
 =?utf-8?B?UnZncTdrU1ZWL3pLaWwzVlJBbDdwaVlTZW5SMjYrSW1xOWVlZXllNkJGdHB0?=
 =?utf-8?B?T0dyWExhbFVxWGZ2WXFwL3FSM2NuTTJ5WG95U3YzZktRUlZ1Sk5HTGFBRFI0?=
 =?utf-8?B?dDNqNE9aazRzZGZTRUVaYjI0QW5ETzhiNGcyUG05VndBL2ZZVUhiNlZlUlBZ?=
 =?utf-8?Q?0X3bn//YVhdWlWH85FM6ffTNTUtQNo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0dZa3JKRFo3ZmRubUxicHF2OU1KMEJwdHBLaDlVWFVndFFGMnhVTk5CMjlN?=
 =?utf-8?B?VUo5byt6K1RDM2IxdEFQZkZxOGl0RkV2TGxTMHJxRk04YTVLL3YzeHRmd29z?=
 =?utf-8?B?VzJnNm9TWUpMUUhqMXpwSEtudDdrNEoweXdYQXFJdS9zQnphcWU2SmZzVmU2?=
 =?utf-8?B?Y29aNzNJV25WbjdBMVorcHo4RGY4aTJMb3VuK1JyUVZrc1VzcXRxVWx0eStm?=
 =?utf-8?B?aVpYdy92SnJ4RDZFMFh6V25Na0VrSEZ0OVZiWnBINWRQUHZlNG5ENTVEdldE?=
 =?utf-8?B?aG5YcGQ3QlhaR1d1NVkxRG5XK0tjYzJ5bVRobVFHQXdRaE00WllWY0pPdGZs?=
 =?utf-8?B?Z00zeVFJNDlORzdyOHNiUlp6ZXJMcXkxMHFqZzE3WFhqbVhaaTN4RVIxUC9J?=
 =?utf-8?B?VkhhTFJHR0V0NnhPdDNXa1VJUWs1OVNOMW5QM1lkMDZranpHd3pNZVI3eUF2?=
 =?utf-8?B?cHoxc3pmZGltd2RkRUJabFhVMmJzc25SaUxUaWlINW9ZaXFtN1drS1FvQjYz?=
 =?utf-8?B?TzBEZXljaDZidHVsSGJ3cmpkYjdJYzBDYit0d3o5V0YxajZXUURVNnl4dmpV?=
 =?utf-8?B?WHdjOVhRRnpMeSs0ejR3QjFlcXBudnQzNm1YZjdxa3ZIRzBkVVJ1cXluQWhT?=
 =?utf-8?B?M1RlZWdGY0h0dDdvd2N6ZnFPR1JRaXJlenNWRWZkc2lYMXlhZHdURk9RRnFj?=
 =?utf-8?B?TWE0OTFXcVVQOXFPMndtZ2FKNXQxUU5NcUZFZHk3TDBvT1dTZ1p6cmpkbk0r?=
 =?utf-8?B?Qi9DOWRMRkFZL1RteGlnbzd6ZHd6cHQ0aTZlUFZxbTVqOUxRdVp2cDJmSkxC?=
 =?utf-8?B?YXR1SnJIZVRFWUs5ZEE2bFdENUE2MEhteXA1T0VOblBNL1VRRC9mT05wOWlC?=
 =?utf-8?B?TEh2dEhDSVZMaTVpa29tdk9FWVF1dTVGSmUxZTZOV0ZsbENNanZsVkR6T1N1?=
 =?utf-8?B?UFRTNGRRTDJuZmhnWHpFSVJRenJCOWNESTREY1dkT09iREgySUFERnNjdlRq?=
 =?utf-8?B?WGpmem1WS3ZjQmZ6RW5CVDUzZmVhRkwyQzFCbExZYjZ1SWI2bHlDc3BTQ0pI?=
 =?utf-8?B?RGY5Wk1CbTloWWFvZzFDQVQrTE5DbUtYSjdvSzVralplOFdQVm1mL3d3bnR6?=
 =?utf-8?B?anFWY3FOOTBFelRXaXplT2I5Q0h3VXNxQXZwNU5xYkJGQ2w2cldNalJKc1ow?=
 =?utf-8?B?VnovM2NJQ2dlcDl4OUVnQmhmb25lRDBiV0ZES2hpbUtmTXBMdHVqdWFwWlpm?=
 =?utf-8?B?clBxN1ZZMGpUR0RoaDNiOFZGSFRoNnQxZGpCOE1zeCtvWmlxdW5CNk5HOERv?=
 =?utf-8?B?VjRHeEMzTXdYVHZvaFZYNFBDaVFra1hwVWd5OWVRbnc4ZW1FUG05VmhtS0da?=
 =?utf-8?B?bEVOUVdyMFBwd3FsMytwbnJwVXRCSGNNekd0YnpkVkw3bktEdnpzYnY5VjJO?=
 =?utf-8?B?d01nUlliNkNiRms0WWJaZnFoQTlDOExRa0c5eXZ3Nk5LUGUzOWZZM1dIUVlG?=
 =?utf-8?B?bU1Id1FSeXF0TXlDMGovbXRlR0lqYVp0MVZGMmk4QkxubE8rd3p4TFhGZEln?=
 =?utf-8?B?NTkyejk1aHBseU9XVmlXQjdJVzNLd1RkTmMxTUJhazVxMjk3RTdaQU9YallS?=
 =?utf-8?B?czlrZEw5U2lsOXloRmZQSWZCaWdzQ1d2alVnQ0pQVTlLVEJ3U3pOUUR5UTlq?=
 =?utf-8?B?R2FGcG9UcS9yNEx5RGZRUGNXa1ZOZDV3dzMvdEZaZnRnaHR0RXJySmFuVjBz?=
 =?utf-8?B?d21rQ29uMFN6cVN0RXZPYkthWldpUnh5MWZmRkJtYW5rODZxNVc3b2hkZ2Uy?=
 =?utf-8?B?ZEFOU1I1T29RMEZaWU53VWdxcHVKOHBYdnpqNTJ0cUNyV0pqeGZYWEJUaDJs?=
 =?utf-8?B?dldVSHp2S1Q2OGFpN1FmbFdIdW9vS2R5a2wxMFVhL2xyaHRablUxOGwzaFVC?=
 =?utf-8?B?S3pYTUdDRFZud1ZBbUEzZFluMkwrM08xanVrQUtML3dZYUVrWFFRVXkvR3V4?=
 =?utf-8?B?bWNNb2p4ZDF2WVB3dTZiRlkwclZnOWFTd2RPelRMdWZlbjdDQytqUXFDYWZP?=
 =?utf-8?B?dlp6TUVSNWNoSFhSOHEzd241Vm5KbHFTODRjWUk1VlBGeU5pZ2FUdmhrUXdO?=
 =?utf-8?B?KzdpTHY2eWV2VTVtczFCeVk2a1ZGcXR3bVRBZ2htSjBMUkxyUWtUMGhDTVl3?=
 =?utf-8?Q?rgakQR68Y8juqwv5AIFl4Zo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B632094725A162489DDA8AD3E919E4A9@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f0a96a-37e3-444d-f77a-08ddb114683d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2025 22:38:56.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTF8V2W5b7vo1g7XRjNJIsR7rjNvY8vNNCs7yEoyzHX+O/JCMKbcd3v/s+Gs3O2g+kymIA1Dfi4UzewFPCbIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6628
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDE0MiBTYWx0ZWRfX+CxckCMfdYpV zVV9s15Evkfr+gzXT5eXJ6C7eJFEZa6kaIZF0+xfHrfr1K26HI7TIST8rLZoI5+Q2KJLoj+i3gT 9/8VHfCh4Z9M6y6zU9xeQbwUKF4dxbQaChqIzdDtPr4+URI2WzgO8VeikqnUG28C5ydJlvh9S5r
 iJoC8RhTegTPd7wnkbjP05jNM2DZM0VtHmslvwR/VkAvkTvcTAcmomZ7HpQYt9R11qY5rNs0pOE hIz2QqJG8075tdf2vMZtbRyPJdPxR0jQZe7yBBoeFnrSDuRAivNdxnlOpbH0ZbwCzTg7KfSo/oo mcLv2JRIFkzLZdjgiYluhpIeNdUcrOdSDOnP+3eBSRUxBWLOGtaTBXjGZM7hmDqKHwRL3lYabVy
 2nrhzZQjKJ4hvgP/B0yLjm+MXC+4qT6Np0Vo4yK36CmvDyEcGHiGE0yy2Ht7ggLQwu4CdPco
X-Proofpoint-GUID: t44o66KX63SaR4kOIvVLMhfTbVYFuBye
X-Proofpoint-ORIG-GUID: AJLNZzFLHOCJFotEgWlE_6pUfmIaRAiR
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68573484 cx=c_pps a=IEcerx9UknNPB1+OXv59Bg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=x3VpcgzdXuKiGxmnXV0A:9 a=QEXdDO2ut3YA:10
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=941 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210142

T24gRnJpLCAyMDI1LTA2LTIwIGF0IDIwOjExICswMjAwLCBNaWd1ZWwgT2plZGEgd3JvdGU6DQo+
IE9uIEZyaSwgSnVuIDIwLCAyMDI1IGF0IDc6NTDigK9QTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gTm93YWRheXMsIFZGUyBh
bmQgbWVtb3J5IHN1YnN5c3RlbXMgYXJlIEMgaW1wbGVtZW50ZWQgZnVuY3Rpb25hbGl0eS4gQW5k
IEkgZG9uJ3QNCj4gPiB0aGluayB0aGF0IGl0IHdpbGwgYmUgY2hhbmdlZCBhbnkgdGltZSBzb29u
LiBTbywgZXZlbiBmaWxlIHN5c3RlbSBkcml2ZXIgd2lsbCBiZQ0KPiA+IGNvbXBsZXRlbHkgcmUt
d3JpdHRlbiBpbiBSdXN0LCB0aGVuIGl0IHNob3VsZCBiZSByZWFkeSB0byBiZSBjYWxsZWQgZnJv
bSBDIGNvZGUuDQo+IA0KPiBUaGF0IGlzIGZpbmUgYW5kIGV4cGVjdGVkLg0KPiANCj4gPiBNb3Jl
b3ZlciwgZmlsZSBzeXN0ZW0gZHJpdmVyIG5lZWRzIHRvIGludGVyYWN0IHdpdGggYmxvY2sgbGF5
ZXIgdGhhdCBpcyB3cml0dGVuDQo+ID4gaW4gQyB0b28uIFNvLCBnbHVlIGNvZGUgaXMgaW5ldml0
YWJsZSByaWdodCBub3cuIEhvdyBiYWQgYW5kIGluZWZmaWNpZW50IGNvdWxkDQo+ID4gYmUgdXNp
bmcgdGhlIGdsdWUgY29kZT8gQ291bGQgeW91IHBsZWFzZSBzaGFyZSBzb21lIGV4YW1wbGU/DQo+
IA0KPiBQbGVhc2UgdGFrZSBhIGxvb2sgdGhlIHByb3Bvc2VkIFZGUyBhYnN0cmFjdGlvbnMsIHRo
ZSBmaWxlc3lzdGVtcyB0aGF0DQo+IHdlcmUgcHJvdG90eXBlZCBvbiB0b3Agb2YgdGhlbSwgYW5k
IGdlbmVyYWxseSBvdGhlciBSdXN0IGNvZGUgd2UgaGF2ZS4NCj4gDQo+IEFzIGZvciAiaG93IGJh
ZCIsIHRoZSBrZXkgaXMgdGhhdCBldmVyeSB0aW1lIHlvdSBnbyB0aHJvdWdoIGEgQw0KPiBzaWdu
YXR1cmUsIHlvdSBuZWVkIHRvIGNvbnN0cmFpbiB5b3Vyc2VsZiB0byB3aGF0IEMgY2FuIGVuY29k
ZSAod2hpY2gNCj4gaXMgbm90IG11Y2gpLCB1c2UgdW5zYWZlIGNvZGUgYW5kIG90aGVyIGludGVy
b3AgaXNzdWVzLiBUaHVzIHlvdSB3YW50DQo+IHRvIGF2b2lkIGhhdmluZyB0byBnbyBiYWNrIGFu
ZCBmb3J0aCBhbGwgdGhlIHRpbWUuDQo+IA0KPiBUaHVzLCB0aGUgaWRlYSBpcyB0byB3cml0ZSB0
aGUgZmlsZXN5c3RlbSBpbiBSdXN0IHVzaW5nIGFic3RyYWN0aW9ucw0KPiB0aGF0IHNoaWVsZCB5
b3UgZnJvbSB0aGF0Lg0KPiANCj4gQ2MnaW5nIG90aGVyIHBvdGVudGlhbGx5IGludGVyZXN0ZWQv
cmVsYXRlZCBwZW9wbGUuDQo+IA0KDQpJIGNvbXBsZXRlbHkgc2VlIHlvdXIgcG9pbnQuIEJ1dCBs
ZXQncyBjb25zaWRlciBhbGxlZ29yeSBvZiBob21lIGNvbnN0cnVjdGlvbi4NClVzdWFsbHksIHdl
IG5lZWQgdG8gc3RhcnQgZnJvbSBmb3VuZGF0aW9uLCB0aGVuIHdlIG5lZWQgdG8gcmFpc2UgdGhl
IHdhbGxzLCBhbmQNCnNvIG9uLiBUaGUgZmlsZSBzeXN0ZW0ncyBtZXRhZGF0YSBpcyB0aGUgZm91
bmRhdGlvbiBhbmQgaWYgSSB3b3VsZCBsaWtlIHRvIHJlLQ0Kd3JpdGUgdGhlIGZpbGUgc3lzdGVt
IGRyaXZlciwgdGhlbiBJIG5lZWQgdG8gc3RhcnQgZnJvbSBtZXRhZGF0YS4gSXQgbWVhbnMgdGhh
dA0KaXQgbWFrZXMgc2Vuc2UgdG8gcmUtd3JpdGUsIGZvciBleGFtcGxlLCBiaXRtYXAgb3IgYi10
cmVlIGZ1bmN0aW9uYWxpdHkgYW5kIHRvDQpjaGVjayB0aGF0IGl0IHdvcmtzIGNvbXBsZXRlbHkg
ZnVuY3Rpb25hbGx5IGNvcnJlY3QgaW4gdGhlIEMgaW1wbGVtZW50ZWQNCmVudmlyb25tZW50LiBU
aGVuLCBwb3RlbnRpYWxseSwgSSBjb3VsZCBzd2l0Y2ggb24gYml0bWFwIGltcGxlbWVudGF0aW9u
IGluIFJ1c3QuDQpUaGlzIGlzIHRoZSB2aXNpb24gb2Ygc3RlcC1ieS1zdGVwIGltcGxlbWVudGF0
aW9uLiBBbmQgSSBjb21wbGV0ZWx5IE9LIHdpdGggZ2x1ZQ0KY29kZSBhbmQgaW5lZmZpY2llbmN5
IG9uIHRoZSBmaXJzdCBzdGVwcyBiZWNhdXNlIEkgbmVlZCB0byBwcmVwYXJlIHRoZSBmaWxlDQpz
eXN0ZW0gImZvdW5kYXRpb24iIGFuZCAid2FsbHMiLiBBbHNvLCBJIHdvdWxkIGxpa2UgdG8gbWFu
YWdlIHRoZSBjb21wbGV4aXR5IG9mDQppbXBsZW1lbnRhdGlvbiBhbmQgYnVnIGZpeC4gSXQgbWVh
bnMgdGhhdCBJIHdvdWxkIGxpa2UgdG8gaXNvbGF0ZSB0aGUgYnVncyBpbg0KSEZTL0hGUysgbGF5
ZXIuIEkgY2FuIHRydXN0IHRvIEMgaW1wbGVtZW50YXRpb24gb2YgVkZTIGJ1dCBJIGNhbm5vdCB0
cnVzdCB0bw0KUnVzdCBpbXBsZW1lbnRhdGlvbiBvZiBWRlMuIFNvLCBJIHByZWZlciB0byByZS13
cml0ZSBIRlMvSEZTKyBmdW5jdGlvbmFsaXR5IGluDQpSdXN0IGJ5IHVzaW5nIHRoZSBDIGltcGxl
bWVudGVkIGVudmlyb25tZW50IGF0IGZpcnN0LiBCZWNhdXNlLCBmcm9tIG15IHBvaW50IG9mDQp2
aWV3LCBpdCBpcyB0aGUgd2F5IHRvIG1hbmFnZSBjb21wbGV4aXR5IGFuZCB0byBpc29sYXRlIGJ1
Z3MgYnkgSEZTL0hGUysgbGF5ZXINCm9ubHkuIEFuZCB3aGVuIGV2ZXJ5dGhpbmcgd2lsbCBiZSBp
biBSdXN0LCB0aGVuIGl0IHdpbGwgYmUgcG9zc2libGUgdG8gc3dpdGNoIG9uDQpjb21wbGV0ZSBS
dXN0IGVudmlyb25tZW50Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

