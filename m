Return-Path: <linux-fsdevel+bounces-40423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ADCA233C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E45B7A2F4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6601EEA42;
	Thu, 30 Jan 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dw3OCb2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6F7DA82;
	Thu, 30 Jan 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738261921; cv=fail; b=NabsN7WzNhjLEFC8zGIgIexNDrdkiTKpegIz1wl+Wq0n+CrYltNC++6L9DXKIG9yRNvcJz/OI4x124hfb6NelRPoMH7VsWtt6ADHGM36gXZzL5OwtIxNejbNZW7nCiyLqnue90Zd/N7ccjUY2+/oVLXSD+A7OVBjn6q2k5vcbzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738261921; c=relaxed/simple;
	bh=W1FBLCxFUpN/pox1pqGBhXSEHfjlL2XywsGvMaIAHSw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=uaaiWUPwRC9Un4/oaZO8y6RzzgmckoKEYgD8SqkzWBWQ9h4JnfwXQyc1hexT+gF9LK+1vQECkF4lKFI/HrG1pJkO1u5s6l4m2WxazYxWFLmJ3PHPy67l5Rz0b97jdaqV34fZ2OB2uMOz1g60Y9rf9kgNHh67Tdx72cXJL3rYT/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dw3OCb2k; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UF1Zfr031420;
	Thu, 30 Jan 2025 18:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=W1FBLCxFUpN/pox1pqGBhXSEHfjlL2XywsGvMaIAHSw=; b=dw3OCb2k
	nV4feyoHNWa+rSLR47Ag3DNq3O5QwgGeK1AhJFm5mUz1n6cLiVNAE6lbBgOkM6px
	DVGv3jrV2qm2aMy4OQkWNn9/Bfv6fhr0WXRO6UYfO7KxkFVYkDHLuCyy6qC5hvph
	ObSeYu4VcmJR15PtUtiA484ymQjReVWgvrsuAGf8r0COd0YKKroQszBstRM5V9w4
	jEOS2rAtlNhgMB4hM4AulgvGcjhYvzFUm8epjEfa8oGOA/sEkZhRkCChOhqLRT9M
	osv7TQV/xJWhXa+rwENyTW/9jBtFJF6DvLDfmFKLlY7hYiqRs6nZDhVcoq50hkOU
	LcIAbPDahwlaZA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gbpyh2p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 18:31:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9KHTvTSs1YtSckd4UkfTZAwCjod6Oh2i+jDgewuVNiYweZx4ofsm6zg1jTsB/8PN7+VFBX+WCefeC/YK5atmhNEtZcu3EvAcUdu/7HcAtAhDfzt7HkqsGxtDiUZ4Ep1rfd57a27s2Eca2NFe9bssv5E+EkEPcaINM+tuK3YGRYCyVlsS/BZ2h38Ly39HdaHkGZdVon5L3sXrnn7NAn9rXl/i4WvxoDLh4hwhAiTItZKAXzoPcEgLzng0scPSiRDuKblnFJ5dNgedxymwYSIvnHSanj1/11GVdZfR0Z1wlXVlNLd7tO0QhUDpAZ3OZ5OBFYbiPXXc8DriDTpnwzn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1FBLCxFUpN/pox1pqGBhXSEHfjlL2XywsGvMaIAHSw=;
 b=I5zf38RMcJZx1SvEMYJQPKHYG9JVPbT5JCQmT9XvTymqxkE3egaG08RBBwobM1PVayy89Rb7fyGDMkpEgqb+zYk/fPl2uoMtj7JJArzKwnq5MISM0/Rc1LKzi0NZsBkKTudA0/KOBP0pMZdgSyXEZ/QSsdmst5sxyXOsGc0PSXaEy+zQspgV+Qhj00ozN/8djYexuFTJV9nO30OFaryrEBDGpcjDwHXKwZnemGmtqFgFyTix3Q794+bwxIbF35DxnUBBZ2EvCQ2zOcq2GZSaPGsXxOJcuzDTNZuAL+vOmNJGlT1XNaDva5IdAZ5KAXNE929d0idAdPtKBerCb5sz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5087.namprd15.prod.outlook.com (2603:10b6:510:ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Thu, 30 Jan
 2025 18:31:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 18:31:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hans@owltronix.com" <hans@owltronix.com>
CC: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] Introduce generalized data
 temperature estimation framework
Thread-Index:
 AQHbbjjHEmAPuPJvLUyENDU0Npkf+rMmalWAgARGDQCAAG+0AIAAxXAAgADmn4CAAMb0AIACGuQA
Date: Thu, 30 Jan 2025 18:31:47 +0000
Message-ID: <4907d1ff5cd5a846188b2c9d77d110d926a37ac7.camel@ibm.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
	 <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
	 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
	 <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
	 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
	 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
	 <a09665a84d11c3d184346b1f55515ac912b061c3.camel@ibm.com>
	 <CANr-nt0nRZp=g2kbUqd5PoNbH-m9MWd_4x+LmR6x-gTT92MoVQ@mail.gmail.com>
In-Reply-To:
 <CANr-nt0nRZp=g2kbUqd5PoNbH-m9MWd_4x+LmR6x-gTT92MoVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5087:EE_
x-ms-office365-filtering-correlation-id: 0760ba97-00ba-4874-2ce4-08dd415c5aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlNVSXBacVN0bGFOZlQ0dWU3U3hxUFhhQU1KZVVQdm9OZnNCQzdkbS9GbVdp?=
 =?utf-8?B?TGtVd1IzRFlCZzZ2b0EvR2pxSWpNckRFbDNjck5qYkFTdXNRYVMzOXJ0b1g3?=
 =?utf-8?B?Y2dEd3dTRFllYytsMGl0RjVkL1p5dkxaenVxWVNpK2xhVFdPWk04U0ZXSTh2?=
 =?utf-8?B?d3pDem1uRXFwZzFtSDVic1VET0tsUmxqYWExNktMODZwYVhEckp2S3UvV2Zv?=
 =?utf-8?B?bkdkTkJUN3lIQWRRVVlEM2xjRlJyKzRJZS9ESzdKcUdDT0hFWkd5bk52NDJP?=
 =?utf-8?B?eXc1SmhHZGl2VkpyYXVzdkZTeDgxTzdVRFZLRkMvR2xvcW0vVzFTamtpOTA5?=
 =?utf-8?B?eWxnZWUyUng5T0tKQ0o0Si95RWpQRDdEZVhlVnJ5blNkQ283M0Urd1orT2pt?=
 =?utf-8?B?aktKWU94UVdvUFYvSXFEaWk3T09PQXNMSm9LQXBvZC9hV21tUTNDaGszR1hz?=
 =?utf-8?B?U0kwOEJWaHZFb1MyYXZ6Sm9BZzRlTVZMVWdHTWVoVmFuY2V2ZC9TMnRnQXFG?=
 =?utf-8?B?OG5OMHRhSHFtRmQ1Sk5iN25iVlI5VSsrOW9WVTQvQi9pNTVSSG8xUVFsS093?=
 =?utf-8?B?OTdaaXQzS0ZPbUFCVmxsNmtSdlJQczE2eFI0QWhpcXpOVnZOOHFEWHNCUEt6?=
 =?utf-8?B?bVJJS1VERERBQUJidGc4WlBKLzV5QnVnWGZ0REdMcGJVVlR1N3QyYUxHLzk1?=
 =?utf-8?B?NE5aZm00YTRmQlZWN0RsenZFS1NlRU1aN05oc1NUejJ6YkVOaGkrNzg0NHY5?=
 =?utf-8?B?cmh4WEp3QWgzMTVEWmR1T0xoNFJoTTM5NW9RZTZMM1BVRWhrbFkyTUtnb1FV?=
 =?utf-8?B?QWpnQ2grNlI1YTlPQi9FNlRhNzl5T01wL3lHZ0xXeEZ6OHhvem9kQ0VqNnpq?=
 =?utf-8?B?NWFsODRmcm0wdWFmd1ArWllqN2Ywc1BmaHFiQkR3dWlnQ1U2TGhlelFXbmI2?=
 =?utf-8?B?WlBUZStFWHQyQ1NEOW0ya0JDRlRZNmVGNUtWcjNVVlMyRlJjVDBrSzJKN2h0?=
 =?utf-8?B?QVBYUG1BQVJCQTVkN0FiT1ZXNGVmSnJnaC9jdnRKMy9wNVliNHByTWRkcEli?=
 =?utf-8?B?SmJEYWZ1eDBzZDRKSVZlcnpyd3NVaGxVTFRsQzJFWGduUHFLYVdLUG1KTVJn?=
 =?utf-8?B?dWpucFU1azROV1JWcE41anArZ01iU0Z3RDVmaFY3YXJTS0VHZW9QdUp5Sysx?=
 =?utf-8?B?WmVibGdTY1h2SGcxQnJ3WlNKTG9UNDVnOVJJNm1lWk83UCtlRGtiK2ZoaGt2?=
 =?utf-8?B?T0MrdnZQS1lJN3ZiNEFXUjZBdDNlSURxcDVqeFlOeGswU1ErbUw4TEdBWFZJ?=
 =?utf-8?B?SG83RTdpVWZQcmc3VWhyZDBhdzM1Y3hHM1pMY3hnek5KQzVxaGJGNm90M2xM?=
 =?utf-8?B?SDM5UnFIS21naVkzWXoxeCtuVW1YbGxMQ3JaTDRLNGt3TWNWMi9RYW16ZkJL?=
 =?utf-8?B?Mk80UmxGUGZOVUx6Q0hRSnFVKzJ3a01kNkk0U001REs4dXRZUkMxSHJGdWlH?=
 =?utf-8?B?UFlYK1UrSXdlamdydzRHQllRMEhJamR2bHlrdWc0VXlZOHJUL2dQVjdXY2sv?=
 =?utf-8?B?YkpNZTJFNkVlTDlMWHFKOGFTa3hwNWJIT2piVXVNUUVmRndrbVM0dWFGbW5k?=
 =?utf-8?B?WXdYQktPLzVKZlgzVkNqT2U0ekVHeU4rUERLVERCaGNQRlMyYlhhQkJBRnVv?=
 =?utf-8?B?SzVRMXA0Q1hrclpzaEM5eUYyVkt0RkYxakFUVGtmci9BdXBNOEpJRm84QnBI?=
 =?utf-8?B?YTFYTXptenZxZERZbXFUQnZEeGk2RUMyanIvd2loVUoxOVN3WXVrVjFxRmp1?=
 =?utf-8?B?MGFiZ3E2dXVPaVZ0bmk3aXlPS3VlTUxGeEY3THZvaGxHQVpmVlI3bHpEak1v?=
 =?utf-8?B?WFZxcWdscEJDak00Y2MwaEZselk1eWtadmgveTd5cm1RVzdXenR1N0xlTWtR?=
 =?utf-8?Q?tpnyKYE628Is5eYlTAh/QWuRclB6YbEh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cG0yVkhDWjdzWWtXY2FHMW1uRzRIRnlXeWo1cGthdWRvbXU2dFRRNnJRNW9W?=
 =?utf-8?B?L0l5a3lSM1FiT2IwQnNlSk5QdVkrYTdKV1loUFlHeXJTMCticnNtVEVnanlZ?=
 =?utf-8?B?cW4yMmEvazdycmRuZkxNZGpYcWFESFFJMTJpY2RHcGFpSS80ckV3NVVJaDMx?=
 =?utf-8?B?ZUdPSEZUUXU3UTNsMnA2Vms0K01IeWsyamJOMFhYS2RaWXBBM3h2N0dnWGZF?=
 =?utf-8?B?R3liYldWdVRDOVM2eWNXaW1YWHpGNWg2c2c4b0NHdHA1YUEreTJia2RQaHFT?=
 =?utf-8?B?clRxVVJNMnF3N0k2c2FvRGJtOVk1cVdMS2hTZStxcVVCdW5Vais4ckswY3pX?=
 =?utf-8?B?OFl0amNPSzdvdFl3a1dZWER3MDF4UGc1dmk2WThRekU4dGsxUCtTMEdWSHI5?=
 =?utf-8?B?REhTN21RUE03VlFaNm9xQkNuc3RaMlpRaEpQejRydmZKQXpLa1Z2RW9aLzhZ?=
 =?utf-8?B?S21HQ0VvdVdPb0FqbnhGT0EzYml5SndMOHZ2RmhUNlpwTkUwekZvRzMrMXV2?=
 =?utf-8?B?YlpzWjdCL3dtbWZYVFlldUNaMmRoalBFSThKM3ZFa3VrMUIvVUpCQ3hoTzFT?=
 =?utf-8?B?aTc2UnRzNlRhSXpvVkxYR2pjWEU5dEdtd1l6M1QzM090OTQzMXJlbmJvaTE3?=
 =?utf-8?B?R29ncmpGMDgyOXpaTjd3bDdyT3pGZlpIT29kTGsyeUUrTSt3T0hjUlFYZmI1?=
 =?utf-8?B?eUQzVldQUVlWV21INEVRd3dzVzQrTlpOYTZWdVBOZjJWbkt1RVFvM2kxbjNE?=
 =?utf-8?B?b3dzWnkrMnZaS3NVNlk2QzlTa3R0UjNDekhPSmJqMy9NVVl4YTdieDE0eHhs?=
 =?utf-8?B?Nk0vTG5XeE1yK1BQTGI2WFcxaEtJVmVwMkxmQnd5N0xQcTdCcWwvMzE3WktW?=
 =?utf-8?B?QjRzRkNZZmdxVW5mdWZwNDZMYzgwQ01KTG1SeWRYZWNOQkRJL3Zzd1BXS21M?=
 =?utf-8?B?NlB5cEw1VmtkUVVCTGdVYVB0WGEweC9TNkIvalo2eHp6eUNtaEY2SFUyUTBS?=
 =?utf-8?B?emFsc3Y5K3NodXkyZnZzazhPclVteFB5VElqLzVxQjVzc3R0RzZ0ays3OXZR?=
 =?utf-8?B?UjdjYkF2b21TOThVdG9UM0ZYSklEaklyam1Xd3dacGpTdUVkUUwxdjQwakw5?=
 =?utf-8?B?V0ZDa1FaWmVVQk1vK3dsbXYycDR0K1JlQ2tFaXlIUXZtYmkreVpCNktYT2pH?=
 =?utf-8?B?Z0J1Q2tJdS9DSnlZS0FyeEp1d1A1dnFzdkswbGJiQnVJaVIzZEFiaWY5VlF6?=
 =?utf-8?B?dEdSVHJJNXV2R3g1WmlTNi8wNjJoNzU4YTdtWUZVbVhaQWkwT3dhSjMwZlpX?=
 =?utf-8?B?dE5nUVlaY3Rnci9VMjdET1N6T2dHMU5MSTdDQjFXMTVaZ1lxUDdkMjBSc3RX?=
 =?utf-8?B?dkwyMERrbGVPd04vKy9yaUo3L2hteTdUamVKeWttWGQ2Uk9yMm1sMkZDUG50?=
 =?utf-8?B?M1VPclU4L1A5MjcvREorKzNVbUVEcnpIUHFzOERkYkFSTk0xUEVIcENaMTcv?=
 =?utf-8?B?dnR5TFRDRHhKMlE0NnBtVUgvUGNZY1MvWTA1VUpIMVJaUmUyaS9oSzducmUv?=
 =?utf-8?B?WGNTeVA1T2FWVVVWSjByYWpjWDVZQlM3alJWNFkrVzJxbHlYZ3JMd3hXNWI2?=
 =?utf-8?B?M1dpQXM1UEY3UWhpMjVHWk1xd3FSVmdBdVFtTGtvR3E0K0xheXV3Z0JLdHA0?=
 =?utf-8?B?K1JVOHpuUkY3ZVhUVWMvNWRralFaY0FJOWJpTEIyREFaTHhEL0t6MU1IQThk?=
 =?utf-8?B?Y2xONktrank4RWo1ZG1sQURobktuRFBianVKVDMzbkhVYUE2TWlkOHFIWnBo?=
 =?utf-8?B?YXBDTjFZNWNzbllHdXFaOERucldRRlpQMTBkWmcvT1U4OFdDd2JJYlBEQmpM?=
 =?utf-8?B?ZWYxMmduTHF6NnVhSXFORDZlTU8wSlBLVkRCSUNpUXFNb0xsZ1RCdGNwbXoz?=
 =?utf-8?B?ZC9OVVhDYUtXbEsrSWZqc2N1Q2V5eGNFOTcwR0RVU1pFNHZYbVo1Ky9jQTZv?=
 =?utf-8?B?QW1HWXN3KzFMOTVkOXg5K2NaVWNYb3c5ZEkyd1QxVXVpYkMzQXBoaTVPdUI2?=
 =?utf-8?B?MUZ5Z3hFMVNlYUxEQ1RncVBqNHRjMWpLMlBuaFAyUm13RWxBNUlNTWV5Umsw?=
 =?utf-8?B?aTg0OXptV1B1Vjk3a1EzSGJBSjlycDdZYWdKRDk1YmpCM1JHaVNzaGlVaWNZ?=
 =?utf-8?Q?OuCPGlsbwtl0mcoihc+uNCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C83D1E407418A468446A99DB0D974FA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0760ba97-00ba-4874-2ce4-08dd415c5aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 18:31:47.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEeD92e6MIKyZOCIBpHNTmMB7gP8tgaxsSQvu1U4/3Y3raTNh+9Fn5kddBn1sK2KtXg0J26eLCQyWGj/TqCUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5087
X-Proofpoint-GUID: AxeMi2SuWpDHyOL8TCoZEYRIv60cL0NB
X-Proofpoint-ORIG-GUID: AxeMi2SuWpDHyOL8TCoZEYRIv60cL0NB
Subject: RE: [RFC PATCH] Introduce generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300136

T24gV2VkLCAyMDI1LTAxLTI5IGF0IDExOjIzICswMTAwLCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0K
PiBPbiBUdWUsIEphbiAyOCwgMjAyNSBhdCAxMTozMeKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbw0K
PiA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiANCj4gPiANCg0KPHNraXBwZWQ+
DQoNCj4gPiA+IA0KPiA+IA0KPiA+IEFub3RoZXIgdHJvdWJsZSBoZXJlLiBXaGF0IGlzIHRoZSB3
YXkgdG8gbWVhc3VyZSB3cml0ZSBhbXBsaWZpY2F0aW9uLCBmcm9tIHlvdXINCj4gPiBwb2ludCBv
ZiB2aWV3PyBXaGljaCBiZW5jaG1hcmtpbmcgdG9vbCBvciBmcmFtZXdvcmsgZG8geW91IHN1Z2dl
c3QgZm9yIHdyaXRlDQo+ID4gYW1wbGlmaWNhdGlvbiBlc3RpbWF0aW9uPw0KPiANCj4gRkRQIGRy
aXZlcyBleHBvc2UgdGhpcyBpbmZvcm1hdGlvbi4gWW91IGNhbiByZXRyaWV2ZSB0aGUgc3RhdHMg
dXNpbmcNCj4gdGhlIG52bWUgY2xpLg0KDQpEbyB5b3UgbWVhbiB0aGF0IEZEUCBkcml2ZXMgaGFz
IHNvbWUgYWRkaXRpb25hbCBpbmZvIGluIFMuTS5BLlIuVCBzdWJzeXN0ZW0/DQpEb2VzIGl0IHNv
bWUgc3BlY2lhbCBzdWJzeXN0ZW0gaW4gRkRQIGRyaXZlcz8gSXMgaXQgcmVndWxhciBzdGF0aXN0
aWNzIG9yIHNvbWUNCmRlYnVnIGZlYXR1cmUgb2YgdGhlIGRldmljZT8NCg0KPiBJZiB5b3UgYXJl
IHVzaW5nIHpvbmVkIHN0b3JhZ2UsIHlvdSBjYW4gYWRkIHdyaXRlIGFtcCBtZXRyaWNzIGluc2lk
ZQ0KPiB0aGUgZmlsZSBzeXN0ZW0NCj4gb3IganVzdCBtZWFzdXJlIHRoZSBhbW91bnQgb2YgYmxv
Y2tzIHdyaXR0ZW4gdG8gdGhlIGRldmljZSB1c2luZyBpb3N0YXQuDQo+IA0KDQpJIHNlZSB0aGUg
cG9pbnQgd2l0aCBpb3N0YXQgb3IgYmxrdHJhY2UsIGZvciBleGFtcGxlLiBCdXQgd2hhdCBkbyB5
b3UgaW1wbHkgYnkNCmFkZGluZyB3cml0ZSBhbXAgbWV0cmljIGluc2lkZSB0aGUgZmlsZSBzeXN0
ZW0/IEVzcGVjaWFsbHksIGlmIHlvdSBhcmUNCm1lbnRpb25pbmcgem9uZWQgc3RvcmFnZS4gV2hh
dCBpcyB0aGUgZGlmZmVyZW5jZSBoZXJlIGJldHdlZW4gY29udmVudGlvbmFsIGFuZA0Kem9uZWQg
c3RvcmFnZSBkZXZpY2VzPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

