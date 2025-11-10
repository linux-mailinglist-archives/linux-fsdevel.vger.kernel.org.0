Return-Path: <linux-fsdevel+bounces-67745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE025C491C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5741F4EE644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B8337692;
	Mon, 10 Nov 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q1oneSPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F4314D12;
	Mon, 10 Nov 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803710; cv=fail; b=Vgde+fLPdiHJhU2PCkDrfWw955PZzisQT0Tjjz8bjh2QviPnUwxbLZJl/NE1f2KrxhR5m0iDBmZ+qCyprQ0XeU/AIqXxakq4e+txBqlL1N89Edpa0DT4tEMAivU3lHDpnoQNhtYVnGyyKBw4LorekZ0agYn2/mrv+IvWcG+c9kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803710; c=relaxed/simple;
	bh=ugrINTUFn5lm2Gm6INU661LMTJflr7aEeKL/XeLkLiY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lB5OCY0fR1vhTWcAnutirEH4caz9feszi//kEzcBheDuIkS8XcTS8MZKe2NyGjW4EiiMCmyP4kgqr+xobVSED85bYXOvOqD1faWg0jn8T321bKVrn1JZT5Aa//+t/N4u3YB65BAk1p5JOEit3l+jT7Ap8GQM2b14Mv0Hz7xpgfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q1oneSPu; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEZdEq011360;
	Mon, 10 Nov 2025 19:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ugrINTUFn5lm2Gm6INU661LMTJflr7aEeKL/XeLkLiY=; b=Q1oneSPu
	zvjQDWj72wpFdM51eTzuipMBwV/kcf6wFlEU09xrLtas5B4TXSSjEWBXngJO6eqG
	T19LoQEVivS8LH4xSGu100okAOb9uWfn9osWq1tGWvf3P0eZTbPl/AYw06cJl/Gv
	eXnz2TP7Vfi/kIe0I7K+lfcxjZNHEk1PtsDWPyS/eOyxZGF6w+vX5FOS8c9OnM+7
	/Q51uJeAiDaXizrjihgeNMFWkT5CLQCNWIRfhRVa5HaS+7sBY4TctKw7UWyMESzU
	+Ee4dwbYhqk+b59oVv6FAw3dfvI93epnZFdtNg6AnV0q18JIuumEPr9s1SE7JNSU
	U+FHiocoqweICA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8049t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 19:41:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfGcH49ldKwEphBUVe6kP1tmyvdjlNSjhKBGT3TNB7quCjwFOPqwG+l6Xj/qfQpma+xRigzUhSWWfeyx+C8La6A/9MabSBXbo5SQJm8E43ragLIB3qUdG5y1A4p8breIubgEfP7pwiTm7lKkwaxxRD0DCSmjByOkyZVAOjXkSsKiYGO9VLM+kKvHPYAoVpE1By3gtkB+ZAdKM90UQ5bgLDJfb2JZYn2MiWjr/bje8f8vWUn5mt6StP00Zv7fsKRp3f64e6fWehH8xlaF09EQEMSc+N4LM8c1JNytUCMfASThJnUShmRYl9dL8+/DtMjxEU3xLxbQ23Sj6WYQB7n3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugrINTUFn5lm2Gm6INU661LMTJflr7aEeKL/XeLkLiY=;
 b=tz+Jfb4JzyOm2jhK7ibXXR5VxbyBjE5P8nCi0D/hHRXtmUM/dzMvUgcUbrxX8S/cZewgLEVlDMksOeOaqD18eQzSSvMXdlc/bVb3tsGQglgmaw7u9PSPDVjNxlkDRcp63ri0+LGwSzkB+tqIuF2omlqdqzyWjPmesM7qgKNlskM3vUXV1Z/xR2NZ8KYqWkQ7tx2Z1P1eNKGideZRUouKQHwCJlkDdopZMd4Hmdy3e9XqchNZA6NQygCcP7EOxG0rERCuxX7WgS8e/wFNZVlNtewAGhisTnTb+GECfIxdiT3QF/5/YXKHGsTRVwDPKmnbk3GXplR1fRKnA5ZhHskxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4551.namprd15.prod.outlook.com (2603:10b6:a03:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:41:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:41:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "wqu@suse.com"
	<wqu@suse.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Why generic/073 is generic but not btrfs
 specific?
Thread-Index:
 AQHcT12Yh6lLNevRjkO1oS1HPlyWxLTmIW2AgAADsICAAAXVgIAAEAgAgAKWlwCAA4PEgA==
Date: Mon, 10 Nov 2025 19:41:40 +0000
Message-ID: <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
	 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
	 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
	 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
	 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
	 <20251108140116.GB2988753@mit.edu>
In-Reply-To: <20251108140116.GB2988753@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4551:EE_
x-ms-office365-filtering-correlation-id: 67d2198c-f36d-4399-3891-08de20912b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlNQZmlKOU5XUjIrT1RUVEd1SmZpb3YwbGptejJQNWFuaGRHS1M3S3FhMzAz?=
 =?utf-8?B?WHJ5c2VEMHE1ZlZremNHdkt3V245akdSQy9tUkp4elFXekJ4U0ZOaXM4Yy9J?=
 =?utf-8?B?cm1xNWlNNWEvV216b0VsMkZOWlBIRkNpU3pPVXdLa1p1MHZCd0RPcnVBYnVs?=
 =?utf-8?B?S2swdHo0bXF3bnlHSGFJSnJsbVhiWXp5QmFPVXlhTjc5VmlGTDlSZXNOeHRJ?=
 =?utf-8?B?NGFFSHlrcmdDdnpFeWZvVFhGLy9xUHcvMkpCVjRNTnJoenNOcmR2VDdYZTdX?=
 =?utf-8?B?eGpubXZQcndrTURGTW1ZWnN4STIxV3dDSjg4VWMrOUJrMmFKMGVvWnhsaFBN?=
 =?utf-8?B?a1lTdlRQNWpIV0VKRFlGWnE0VFJEMXdjZUVJaXZPTXlET3IxL2lWc0Q3Z04v?=
 =?utf-8?B?OTV3dGYyRXhOOTk4aFJ2Y0tGRzU3SXl3N1ZLM3lWZXQzYks1bGZja0U5ZGJ2?=
 =?utf-8?B?VmNqWlNoS3pQZmZGbUZlU2JQNXF3WS9lSTZRVnlZMnprV2RwbHpYUmI2VzdW?=
 =?utf-8?B?SG4xTTJnSXE0R0ZFbHFJdUg1djhjNHZGUW1vazFZNmErV0ZTaGQyN0ZXdTl0?=
 =?utf-8?B?L3h0cFNQRjBUbHdQdFZLMlRORXVwM0lQWDVoV0FCSjNJTDljd1YxeCtlNFN0?=
 =?utf-8?B?VHZzd25oT1Z1ZnhKYUpFWEhnWko1NTZLejlPRC9qczBsOUoxbENuUmxzeXVw?=
 =?utf-8?B?SVY0RXZtV1VtNTZZUEpCcjBabTNvaTdQNkhSS3ZSalVjOWJkKy8xV2F3SmZH?=
 =?utf-8?B?MlFWckNVU0VyZDlnYVNkUWJoNHcrRTliVUdKb0xtaE1BOWNIQVJhbHVPb2xX?=
 =?utf-8?B?ZHZvSzBZdlZNT0tFNUhnZitTOHdsd2hrTnVBc2dGRWdrN2RmWCs3ZHoyMlBu?=
 =?utf-8?B?U2gxL2tIRDVuaHU2ZVRGU0FpQUZ6R1JxNWpCN2Uxd0tiaXVpcXllUCsrZWJj?=
 =?utf-8?B?cmIvdGxuNk1MZDNiWFdJM0J4VGF6UW1zRENSQVZvUFl5c2Z4Tk15dDZXNVlH?=
 =?utf-8?B?KzFhQXkzYklsMkw4MFpIZDk3d1M4VC9XUXFnaHhKRHNWaUpFcCtVbHVVb1Vv?=
 =?utf-8?B?RDd1ck8vVzhzVHVJZENCdUJOQWNuNWVUdkVOaDZQZlhVOE8rdTRrSGJkMHQ4?=
 =?utf-8?B?MjdGSWxqUFVKNHFFcG42VDJHTG1OUml5R3VkMUVwMzFrdXNsK1M4MUJyekp1?=
 =?utf-8?B?ZnhTQWQ4YkRsUWs1NlhMQVRwT2tDWUQrdktCYldkYXN3ZkVnNHVrMDFhNisw?=
 =?utf-8?B?VnNGQ1RNQ0crbmJES2JQVEtaaTJ5Mm5tTFJINEZZWXpVT1ppNFFHcTRwVWU4?=
 =?utf-8?B?cksrUGlXM2FhWTJkR05yYjhMcnZoc0xMRENaQnJrSGdHSGdjellBS2FITWNl?=
 =?utf-8?B?MWZBQXh0TFJoRTFxQWVMcGFhNE9oOHduTUVNZGxyOFErTk1majVqQVZsS00z?=
 =?utf-8?B?SmNYV2JCY2ZaNFdhM2RxUlFRRHFpYmJkc3VvYlJTT2NNVVdYWHJXbXpNamJX?=
 =?utf-8?B?SHJPOEFLZWN2bHg5T1pxRmVtOGIvT2FIOHFRelhEdS93cWhRSVFzU2VvaXJq?=
 =?utf-8?B?blFPVkFLK0dFcnAwbGlZcVlFTEJQcWgzZGY3N05KWW5RbDl0RkgzQjVLOWZJ?=
 =?utf-8?B?Vm9BcHQ3Q0tEMkNjM0lTamFZUjRubm8xMjVqZU1zeTcxUWNlT0MrMXJnbGtm?=
 =?utf-8?B?bUVQVkJ2LzhYUkVJTGVBcDV6Y294RFY2dGlxQkdqaU5xYWtPYVM5T01RMm5a?=
 =?utf-8?B?R3Uzc0xpVWhUV3UzK2htbHM0ZVVXRFNnNlNwSnBtdnJsbTlvOUVtQXM5eVEy?=
 =?utf-8?B?UzBONkVya2xyMHpzSXRINFVJbW9GSTNCdmp3YkRpUVFDT3NFMW9qRVdxRXNY?=
 =?utf-8?B?NHJjL1FGTTVsTTFEZ1hmS2tERUhLY2Y2MGpwUjJ2a2xWeE5WT0NJcjdsVkJa?=
 =?utf-8?B?Y0kySXZPeXV4Wk05dXd3bVVuVTN6cDRuVE1ET2tZMURiN3VocUoza1ljWEdM?=
 =?utf-8?B?U3UxT3BPa1YwbURlejFoc0ZtQ3NoQm9oeEI5aVBpWmFYekF4Yk9JWnlyYkVq?=
 =?utf-8?Q?k3vgYY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T283Zmk1SVlXWWhWbnJXNnhBeWVHcUMwSUREajkwaVVwb2Z2eXJ5d2E3aGZK?=
 =?utf-8?B?anB5aVE0bGZEMzY0Q3RYOEVzVDFWMC9YaWpNL0l6RU5wT05vYlVTSlNOc3M2?=
 =?utf-8?B?WkJLYlNwRGVnWGh1b0NoYWlvUVhwdjc4OXd3NG01a0UxOUxFdkJwZjQycXlZ?=
 =?utf-8?B?czhrV2NjditMRnluNFp0WFZCaWswQkpOQ1lJWkpUWWtBczl2WTZmSDhOR2hM?=
 =?utf-8?B?T3IxU3FJdnROMGs2Y1RBTytrZzVlUGFLTlc5K3NZZmt4N04wTXk4ME01OFp4?=
 =?utf-8?B?YVlPbHV1dlRvVENveURhT1FHRmhkSWJjZEdZUFpNbWVXREpKempDVEJ6d1FI?=
 =?utf-8?B?dnRYNXA4RlZpK2NibDdYNTlxbExLSG9xV2RDRWpTSjBaWG9zYnB4RUpwYmtT?=
 =?utf-8?B?d1I4SW15Vi9tb1lBdW56UVVYTjJERTlueGU1MHZNRm02S2Zoc3k2cjJCR2FR?=
 =?utf-8?B?eHhaYU5LdkNZMlNFYzN1dVZZK1dZUldPa0xrWW95VWY2dXR3WHFvcXJTY1M0?=
 =?utf-8?B?WnJodlk3L1dmNjNKK21ZR3JFZGF6ZGVEMDJ0NDBjNTlkRFlRS2V1RmxHODNx?=
 =?utf-8?B?V1pFTWFvU3JGUUtHMy93T3dzK2lwNklkcU5PdUdsdDhERlRuZE1YZFdTQUtp?=
 =?utf-8?B?Z0ZGNkhGTEk0K1JUb0xEZFpGeW5GQ3JIQkRXSXZBOXB1UkxmU2FGWEhXRmww?=
 =?utf-8?B?Tk50eTNuaFNUdEZpRFBqeXFqQk5GNXovYjM1VzVZUmZ6T09aREMvL0ZqT3pI?=
 =?utf-8?B?QWN4eVFtVXVzZ0pJVjFHUS9BWnVTK1NwQ2RWTW1NU1hpSW4rREhndnlsZG1m?=
 =?utf-8?B?ZVhVNTNUVk5XNlVHYTJUU1hmelUzVkdIMUtqdElsMjRtVE9tT29TSXRSakRj?=
 =?utf-8?B?T1VJQkc2aEptVmpyWkU1Mkx2T3pQZDkxMXQrUmJ2T3VqRmVmZ3hYcGs5NkEx?=
 =?utf-8?B?RVN2WklxWlRPdlBZQ0ttamVnMTBmakNJSGNzSnNKUlJkazdDbHRaUGd1SzR3?=
 =?utf-8?B?OVNmcnRnNnZ6dnBxVHpoS05IdE1vZkxBYzJ1TkZWZlFYV0lZZCtrTUVJc0Fk?=
 =?utf-8?B?NnhHMDZnQkd2N3NxQUFTbVRBSnA5cll3VkVVRWFFWUlpRVRxdmEyYytRZHhC?=
 =?utf-8?B?WkRDdHkwQmNXQmJ1QXhxTkFTRFFlaEdRWlZ3K2sxbHYvekNSQWE4VUhtdE1S?=
 =?utf-8?B?UiswS2JXbFJhK1RlQzQvRTFpc21aVi9UMUdydWdUdjlhdnppcm5pbFNsOGFZ?=
 =?utf-8?B?NjU5d3JITzFkRmZxN3lSSWZKd3FtcHpDWDZ3M3JVbS8yWUtrajlpR0Yvcmp3?=
 =?utf-8?B?dFJPamlkK2RmazNJRE9tbThaUWx6VWVYTWVMZmt6WDlwb0swODdpb29BWlRo?=
 =?utf-8?B?TUQveXpNUjIxZ3k5VFVZakNWaW9vWEdGQ2RhcWxRZUxpdUJURTVhVzIyYlVs?=
 =?utf-8?B?OFNNS3NqZ0xDUmlSc01FSWU1cndrN2xGdUVnZG5JRkZzZnYxTitUTXkzSThz?=
 =?utf-8?B?M1FwcjRsQ3dEUTNZMTBUSFJiYnZvd2tNOWJoY2JidzFDRnBldUwvYTdQakRy?=
 =?utf-8?B?SDJOM1kvNHpXRGh0V2lsejRrMU05ZVNKdXJtbzFXUStVYkdOa3kvcXRTOVA4?=
 =?utf-8?B?YjZrZnJGaGhLWEZCQURRVFpUYW50RGR1UzZXT1JpRTRFa2k4MDJUZ2pJVmdC?=
 =?utf-8?B?ejc5eDVDU0FxRnRMVTVnenF1QVZXcmkrU3hzbE4rUThuYUlXdzJ1d2NsTTNx?=
 =?utf-8?B?V0VLRFo2cm9OZ2lSL2I2WWJ3WHU1cGVIdDJPcnJ0Rk0yVjgraWZCeEgrSHly?=
 =?utf-8?B?R202WXJiTmQ4ZW1vbThSNXpMWG5qSnJ3Wit0dVZoL0NYUUJURHZNSi9iTG5S?=
 =?utf-8?B?Nm12cHhtSnQydjAreGI5bnFXU3R5aEduM2dqclRtZ2E4RmtHdVZMcVIwVGtn?=
 =?utf-8?B?YjI4alk4L0QyOFRWZzlOc3Nka1N4ZFg0S0hQYVRoaWF2enlIUHZFUVVQM2VC?=
 =?utf-8?B?bittRDNhL01VOU9YeTNFa2FtR1JKc3JPcVQ2d0NwL0lUWk9ZTmV2Y01tWVpr?=
 =?utf-8?B?WG5ZeTdNZ1FvN2hjaHdGa1JtYmVhUEV2MkxUbUZNK1NJRC9VMXlaQ2daUy9G?=
 =?utf-8?B?TW1RbVVESzFCYzVzUzR4eVBxRE1PUXZkTER6WHJSTGlBS0NvL05YMkR2M3Ra?=
 =?utf-8?Q?Qz7HWFF/RPIkHy8EBpTqtys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB14F641716EA459192D876B5C0B682@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2198c-f36d-4399-3891-08de20912b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 19:41:40.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEXbPf7a41VBjl0SSqreuLBlFyC83V8Sf848bwtqD69sUFVDQyAvBkgrbovr1obSoLQNUy3FQWLw0kGPno31XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4551
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69123ff6 cx=c_pps
 a=/2P0sUepIMZl1V3lWabuzw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6SHA1jDFwmVL2ONUCfMA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: n2XuyrgLNr7bRW0W3KsSRZ88BvjugYJH
X-Proofpoint-ORIG-GUID: n2XuyrgLNr7bRW0W3KsSRZ88BvjugYJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX9EpDdepiyPhG
 pZiHcDeB84gbAgPdIV2b+ZOQAA44uYxXH6wg/q5vp/A3cIL8kvw6NJ0HdIQUz+FjoQImeOWe1GU
 ZrttsX4HJ3pyccAbIU32FuQnr2zqgK+3hbwKZfofH3MjC4pPEUFIJYEAEBrInOIYhQnlfXfYagd
 6PjA2teepF0r4tbJOBVH/E95HI1UHSVauwIzWP1zvtgybOcTlyzT1923AfVCodhYe8k6T/T8XLe
 lrm9K2Ib2G2zTWzOPHkBj9MqHADmZr44m57eqcOSxWPrMN23Q5ahAWyKmP7nm4bAE+uocZfDq9a
 ndbXoVoWdb8qGxj1ZtFz7cqf8/rrKrP7AfRMKXmW4WgmmxtulCJRcP9Tg5AbCV035sgryAI1b8/
 17kJXwTHjwbS0p/Esw6jmCunwcjPJg==
Subject: RE: [RFC] Why generic/073 is generic but not btrfs specific?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

T24gU2F0LCAyMDI1LTExLTA4IGF0IDA5OjAxIC0wNTAwLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0K
PiBPbiBUaHUsIE5vdiAwNiwgMjAyNSBhdCAxMDoyOTo0NlBNICswMDAwLCBWaWFjaGVzbGF2IER1
YmV5a28gd3JvdGU6DQo+ID4gPiA+IFRlY2huaWNhbGx5IHNwZWFraW5nLCBIRlMrIGlzIGpvdXJu
YWxpbmcgZmlsZSBzeXN0ZW0gaW4gQXBwbGUgaW1wbGVtZW50YXRpb24uDQo+ID4gPiA+IEJ1dCB3
ZSBkb24ndCBoYXZlIHRoaXMgZnVuY3Rpb25hbGl0eSBpbXBsZW1lbnRlZCBhbmQgZnVsbHkgc3Vw
cG9ydGVkIG9uIExpbnV4DQo+ID4gPiA+IGtlcm5lbCBzaWRlLiBQb3RlbnRpYWxseSwgaXQgY2Fu
IGJlIGRvbmUgYnV0IGN1cnJlbnRseSB3ZSBoYXZlbid0IHN1Y2gNCj4gPiA+ID4gZnVuY3Rpb25h
bGl0eSB5ZXQuIFNvLCBIRlMvSEZTKyBkb2Vzbid0IHVzZSBqb3VybmFsaW5nIG9uIExpbnV4IGtl
cm5lbCBzaWRlICBhbmQNCj4gPiA+ID4gbm8gam91cm5hbCByZXBsYXkgY291bGQgaGFwcGVuLiA6
KQ0KPiANCj4gSWYgdGhlIGltcGxlbWVudGF0aW9uIG9mIEhKRkpTKyBpbiBMaW51eCBkb2Vzbid0
IHN1cHBvcnQgbWV0YWRhdGENCj4gY29uc2lzdGVuY3kgYWZ0ZXIgYSBjcmFzaCwgSSdkIHN1Z2dl
c3QgYWRkaW5nIEhGUysgdG8NCj4gX2hhc19tZXRhZGF0X2pvdXJuYWxsaW5nKCkuICBUaGlzIHdp
bGwgc3VwcHJlc3MgYSBudW1iZXIgb2YgdGVzdA0KPiBmYWlsdXJlcyBzbyB5b3UgY2FuIGZvY3Vz
IG9uIG90aGVyIGlzc3VlcyB3aGljaCBhcmd1YWJseSBpcyBwcm9iYWJseQ0KPiBoaWdoZXIgcHJp
b3JpdHkgZm9yIHlvdSB0byBmaXguDQo+IA0KPiBBZnRlciB5b3UgZ2V0IEhGUysgdG8gcnVuIGNs
ZWFuIHdpdGggdGhlIGpvdXJuYWxsaW5nIHRlc2V0cyBza2lwcGVkLA0KPiB0aGVuIHlvdSBjYW4g
Zm9jdXMgb24gYWRkaW5nIHRoYXQgZ3VhcmFudGVlIGF0IHRoYXQgcG9pbnQsIHBlcmhhcHM/DQo+
IA0KPiANCg0KWWVzLCBpdCBtYWtlcyBzZW5zZS4gSXQncyByZWFsbHkgZ29vZCBzdHJhdGVneS4g
QnV0IEkndmUgZGVjaWRlZCB0byBzcGVuZCBjb3VwbGUNCm9mIGRheXMgb24gdGhlIGZpeCBvZiB0
aGlzIGlzc3VlLiBJZiBJIGFtIG5vdCBsdWNreSB0byBmaW5kIHRoZSBxdWljayBmaXgsIHRoZW4N
CkknbGwgZm9sbG93IHRoaXMgc3RyYXRlZ3kuIDopDQoNClRoYW5rcywNClNsYXZhLg0K

