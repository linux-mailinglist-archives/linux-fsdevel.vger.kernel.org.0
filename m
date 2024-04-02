Return-Path: <linux-fsdevel+bounces-15863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5A89509F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A87DB20EF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF85EE82;
	Tue,  2 Apr 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="K8/MNMhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2140876;
	Tue,  2 Apr 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054779; cv=fail; b=OkuAcHoWRFWJfJu/gO/lHVKe08YhvsxLbSOImYU8ws02kTYw/qgherKOnk8lCP/9rORcfGCvMZaeQGL3SOcgDGB3DDqh9G5Of9miCTJd7qK1xf1jpxvfAm7TruSexRSwyu0YZ3PhX8hhfUuPdLUqqcOhkKMH4VlVX42iMt8Cd4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054779; c=relaxed/simple;
	bh=5I4YS/kbY5OQNCASZv6s+oMzYHvYdNB+zk+vISpjbxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ss721ycLCGPlcacsZ/5NNUSnM+cMX8IQy8CoGmyevgtGceEF/jDD/Nxk3I53Z468H5Pi9fUiV91ftv4B2U+OpcE5xDcCzTybw/pu7BeQHwhoRw0Dyn4Ot1uk+t+UavVHaCP5bm7CYQqS423RlStDYqVGQfSHJCKphhGuVtZUy0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=K8/MNMhx; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169]) by mx-outbound44-159.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 02 Apr 2024 10:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJAJdQMDhxtJNDT4GYjL0QZEotmecc9a9N02CXJ04CnfC+GJh7VieCiCaPjsITsyUunaWvrke6gXDXcYJAHGVCENQ/g4EEjvg2dXE7RjebroTHfJL3ys40FwCofNdxlL/IpVmmwJLDdN422UElu3BXPa4Jcne2iWe5ZPcOiwhHouZQJhRvDbUmvDUnzZI6GlkBjOYInLLvFmfILI2neMvhep4Kz20vhLAIfN3O9r0ZxFAW9nqU4YA8tMNJxiW7xt1qDO6GQICBE0hRe3TH2hvJqFhS+34wgcxDbOfixQQ/r52m5YX1/zf/uakqbhceyjRIDTWV+opQN6NZqbJuwjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I4YS/kbY5OQNCASZv6s+oMzYHvYdNB+zk+vISpjbxw=;
 b=mDH10eRCTCNFaPwsoZ/3/eyZNuQ79S6SLx6KIlIbgDZ3WnUzlAX7dc9g6Je2CzRrVGvOZw/Pl0yNJCnjIBlw5WrWu+26JheX1Be4UmluJftJUtTWmYm6O7X6pyCSXW0I+EnfgTiTnob2wfrZZO2YBbfHShTRUIC6qPjEyqp7gLXkHd0jqksnQDYc7+i9YCrpEwFFkd34rZI6Udqnlv1cSfwPYkvxRAlD4h7pLFju8iMnzsm5siG3wFxi7+XSEpD06FKwdW2lFSJ3FwDDr4Na7YN/wz5cijg+QIL9DOOlWQnl5JCE3QGxo5CBkgS3JrPLmIBVt3Bn+8I6sWP3LGNLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I4YS/kbY5OQNCASZv6s+oMzYHvYdNB+zk+vISpjbxw=;
 b=K8/MNMhxBs+ugjkmvZnFwW/1mbM9tM21zul8qynFUFQ4OwbgDrI5DvJpN0eHrED3hsx3xaSQxx2E/cRIOOon2QpR9InitshqUxwGna59oF3ADwhe7GjAVFu76fj6ZNo8DVdo0S8dMHklYRf+KnCoZ2b/UUBb1DCcCoXAGCP6oJI=
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 BY5PR19MB4097.namprd19.prod.outlook.com (2603:10b6:a03:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:45:57 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::8a58:247b:a09d:ede2%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:45:57 +0000
From: Dongyang Li <dongyangli@ddn.com>
To: "joshi.k@samsung.com" <joshi.k@samsung.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Topic: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Thread-Index: AQHaaQmqs4xTfFwV8Umi6fEJWz7IwbFVA82A
Date: Tue, 2 Apr 2024 10:45:57 +0000
Message-ID: <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com>
References:
 <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	 <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5711:EE_|BY5PR19MB4097:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tEOQ/SUG6wAy8YFMmdwNo0v1h0x+aL7FfdRYcGcf7G861SL+4VdCjXMc262o7C3q6skdkuWDSWAT9UHUVOiqXmxgHFO+gAfPKDlSp782/R6pRrnd0i8bzM3tqNkyjaBYMNsNLNAXBY/S1SFz1DzW5euJrfNrjTtNhHY81KjkLDvPSWgyFVNz/TOANXvnEnBz3pMzSFGx/YhB3PMZExZfY9DBrI8Ql/hdJnVxF0pZy/lbeNPVX+E3BkDRSZtkNZiIEMCAff0xZXOSX8oQGDWnwLsEM5OpwrhPOJWe2EV/qI/NI7thALA+SUipLr9lx01ky/u69dnfqavsO82/jA4IzNxWutuvckKKliLWKOcVsLqmA06m5fKshMNiv2LvEpKNXpFIKsQnEaPlUfQsWfG5QH8f7bOCf8jGgNcifoIXeVuWX/Mf18bLRKHCkCfK59F9xb5VcKifNBEdNVMgQQgnsdOtec3dQ8bkE4p0fHrjkUV54PdrjanpvNDvZtoHBomzydBOBOqM8bowaWAO2AoXVMr/hspB5Xnsb4XjCF2N+73pmiJ0dqM94pOBewYW9H+7QFQ9p9bNMl8z4eD5+6e1msOqDlX9TOPgZcC1u/kmWwf2eymYXNsFrc5HyAFNIRPEI8oHNfrgTEh62G6d/jlF3S7y/1llp00vaS7oIMefXng=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnFFckVJN0FPNlNSSWZxKzQ0SXN2bWNhMzI5bkhKeldqS2NielU2eFFZSU5z?=
 =?utf-8?B?Z0pjVzBFOUZEQURTdTNWcnp1NWZQQTdmQTcrOGVpamx3MCtqbW9wdmRnSE4v?=
 =?utf-8?B?b095Q3hpa1U4UzV6R0JDUXBoNW5BZWN1Y250WllFSkprZGVEb0lWNVJlcWxa?=
 =?utf-8?B?UXB3RHhFK3REMUhxcWlLdWY3aTlwMjNGY2RnSTNDUnpvVGs4L21LNU93VTZL?=
 =?utf-8?B?VEFFMUlWU0dpRVRVS3MzNlUzcjlMS283bUNva1NRN29Eek1hTlVUZ0c1Njdl?=
 =?utf-8?B?b2UxRk9XNS8xYnZ5dnpDU05KV3RMcUFKU1AvOHhrNlF0NzMvVngycmxvSHM2?=
 =?utf-8?B?ajBERUcyc3hoWENZME9YZko2YmRCaW9IMGtQajJYQjlZWnpVc09TS0xIS2kx?=
 =?utf-8?B?c21KWU9IZldmYzdJMXNRSXRORDJwNSszYnJJVnRvb0hEUGVGVjRFQXo2Y2w5?=
 =?utf-8?B?T2cyai9pa2h0dktFUGdnc0llbElJakcyWlhiWW9qcTZ1TWFpM0RmaTR3OHZ1?=
 =?utf-8?B?dzJjb2VRVERibjZXTFNKbkZobUY5R0IwclpiRGNDekl4STFLYVg0aUxnM2lm?=
 =?utf-8?B?emUyTDNCN25vQUsrZms1Z3ppdDlmWjBDUDFraGFsQ1p1S2c1VnR3OFpLSDZT?=
 =?utf-8?B?L0R3QTdMbUV4QlRCSUJSYkRZYmNRNmd5V0tvdS9lbkZlQ1pIMHQ5MzRGZ1JC?=
 =?utf-8?B?K2FKSWhpZTF5bUtjVFRQV0VVTnNPY29xbWpTdGRONWJqNFJhdjNGRFlIZCsy?=
 =?utf-8?B?MXc0MUZQV3BKZ1RsZHVaejVmM1JZRjNrbVUvVVBBL3pTa28xZkpFaW9tN1ZR?=
 =?utf-8?B?eXFaMk5PVHdpRTZiZnZoSGF3ek51cmVOTnRPdjhTemd5UTNjc0NUb1JHeDJp?=
 =?utf-8?B?Q0U1enBNMndvaThJV0dnQ0UxdkV5WU1KQnlrL1lJN3hLRmt4SzlzMm5xOS9H?=
 =?utf-8?B?cTBmb0lRN1hibWM3MTNhU1NnL2pXWUhZZjF6Vm1QZzUwSUEyaUtneSsrbGNR?=
 =?utf-8?B?cW5ZcHNRRktEUmZNYW5CZWZxUXcvVEpjZkJwYThhYXJSd0JQVXdpYSt5SWRF?=
 =?utf-8?B?blVQbUFpRmpLc2dXNXVVZmJrYk5LeE5sbG1NV1NqQnBqRy9ZSFd4eWF3Qk9H?=
 =?utf-8?B?eUxZalIvYzRUTW8vc3loVzBSdFVsdzh3YUZoUjdESzN6aUxOVjRMUGZROEdu?=
 =?utf-8?B?R3RSQXVZL3drTnF4VHBpczU2MWcvQlNPRU1MRFNROUd3d2lxcmhIWWt5aEcx?=
 =?utf-8?B?RDIvREdOcUczaFY2VzdpV09mcS9TdWpHUEMxaHpzNUJubmYramRSUTBMelRI?=
 =?utf-8?B?YzZ4Ym5pL1RmZHRUc0tXYmIyR2gzanE4RFZZd3BUVk02QXdXSXJHRm1MUUF3?=
 =?utf-8?B?OTZlb0F1bElzRzZYcG41SDh3YkdnbzhBdUlwVmxhUjIvbDB2dnNNN1lGRS81?=
 =?utf-8?B?bVYzMEw3ZVFzSmFIR0pIbnZmSVNCbGF4R2ROQUJDNmxVK0VyempMZkx2Zlgw?=
 =?utf-8?B?REJ5d2RSTkpHODBiNHIrdVo1dXQxVkpJa0E1Qml4VTZZTG0xdURKSTQ1SlR4?=
 =?utf-8?B?VjJIbjlaNGlJUm9idXlBREVtckwzNWNkSUFzb3JQZzBMY3htYTJPRUIveUxl?=
 =?utf-8?B?MXVGam5NVHpYa3U5ZU54YkMxaUp4eWEvc2krYnBWazBab2RkdHJtWnVFejht?=
 =?utf-8?B?WlpaYVZGWjExYS9xbm8yWFU1b0dsbC8xTjIwZ1FiYTZjN09ORys0MHh0MmFo?=
 =?utf-8?B?bkFpS1JLMVdtYTU4bmxNNzFkOGIxUjNZU1p6QmxweEtvclloenlxZjNGOWE5?=
 =?utf-8?B?YklsckNNQ3lkZzZXWjZQVW5rV1JyNGIwcURDaTJ5eXlCdFdCUVJGZGZZWnNB?=
 =?utf-8?B?Qjg3S2gxMnR2dEhiUDJDd1E5N0VkcjBZUndsU3lDQ0RYa1hsNEdVRk1MNlcy?=
 =?utf-8?B?VEozZ1pUdDBTVWJEb2VQdTVDTy9IYVZqNlgva3JDQVVzSksremxPZTlLRUdl?=
 =?utf-8?B?N2dabkV4ZWNXeXBzQXFDamI0SjM3R3U1akovdElnWnFELzFoaVJxZFNreG5H?=
 =?utf-8?B?QVpCanZsSktHUTlrSWFrbTdySlZaYzhDRTBlaW9EM3VKWTNKQk11U3ZDdG9Z?=
 =?utf-8?Q?cAtPBlW+HPqso+Zcrr69zT44s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <701356231C160645897FD1C819F30470@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NN5nXhkAGe8rrHST9NcQCdcEHDYt7TL0F14/GbMB5D33c+FiAkf14uX+eFLmuMrJElk3WKHuIrB41FT08dI/2oNc5/s9jp8S49Du4iLZEMAgl8pI8fgEqnvvys+WhbFe9lylWqkcBaL5fokuBEAeKjLXxf9z+tRHyMNM06Y+P554hTNf+z5tkDEdbfEUUKxhYMqiUY02UcjDXC2+p7xRYqLFNHDuK1bqf1gUb5m9NsYyJP9BuBTcGx67UJNkWo0JtiKMmwGU1gM+O/2z2zAeANmkurN6aTFrj4LpvEJqwBZBIH7CyPqJSg0cuGkDwNELbpulxBv4rIGjADo+mkKB9TU7orUli+/zJR9frYBBr1dSRCZDzrLEeq0hCOa+XNuLQhi7wr5BsO7Cp+AawsfSOYSvv1+M1ZZX+TAlb8wacDI1D1JBroukTQnnPYxIw97Z9smPPYCJcgNkDLqUANx240eRWkxsKiXtNQy8wPqhXcgBPuk6Q9zJ++/vVUghWCw8i8TxK3SwSHIw3zWqiwwz8mhNzsmnFT1xNv7Kzmc+Om4PWGtoDU+3V1ZYvhK9XtnpRCoD2ngoUcLeZkQGgIErzcMOFq6/VtSpkFpwsFEGxEYCxCU0rVjBmFjA3/fJPas9S1s23PsTgowbN0YYWpokgg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71fe7b8-23e9-438f-50f9-08dc53021422
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 10:45:57.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1b61W7GiaEiYViFqo8MYZ2i4R9nVFlIHxqxX71ANNEyLZt5VeQqm1rKDGdRiM4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4097
X-BESS-ID: 1712054762-111423-11403-57458-1
X-BESS-VER: 2019.1_20240329.1832
X-BESS-Apparent-Source-IP: 104.47.55.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYmRkZAVgZQMCk1JdU82dDAwt
	QsySzNIjXFzNzUKM3c2Mw4KS3RxNhYqTYWADJsf25BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255287 [from 
	cloudscan16-124.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

TWFydGluLCBLYW5jaGFuLA0KPiANCj4gS2FuY2hhbiwNCj4gDQo+ID4gLSBHZW5lcmljIHVzZXIg
aW50ZXJmYWNlIHRoYXQgdXNlci1zcGFjZSBjYW4gdXNlIHRvIGV4Y2hhbmdlIG1ldGEuDQo+ID4g
QQ0KPiA+IG5ldyBpb191cmluZyBvcGNvZGUgSU9SSU5HX09QX1JFQUQvV1JJVEVfTUVUQSAtIHNl
ZW1zIGZlYXNpYmxlIGZvcg0KPiA+IGRpcmVjdCBJTy4NCj4gDQo+IFllcC4gSSdtIGludGVyZXN0
ZWQgaW4gdGhpcyB0b28uIFJldml2aW5nIHRoaXMgZWZmb3J0IGlzIG5lYXIgdGhlIHRvcA0KPiBv
Zg0KPiBteSB0b2RvIGxpc3Qgc28gSSdtIGhhcHB5IHRvIGNvbGxhYm9yYXRlLg0KSWYgd2UgYXJl
IGdvaW5nIHRvIGhhdmUgYSBpbnRlcmZhY2UgdG8gZXhjaGFuZ2UgbWV0YS9pbnRlZ3JpdHkgdG8g
dXNlci0NCnNwYWNlLCB3ZSBjb3VsZCBhbHNvIGhhdmUgYSBpbnRlcmZhY2UgaW4ga2VybmVsIHRv
IGRvIHRoZSBzYW1lPw0KDQpJdCB3b3VsZCBiZSB1c2VmdWwgZm9yIHNvbWUgbmV0d29yayBmaWxl
c3lzdGVtL2Jsb2NrIGRldmljZSBkcml2ZXJzDQpsaWtlIG5iZC9kcmJkL05WTWUtb0YgdG8gdXNl
IGJsay1pbnRlZ3JpdHkgYXMgbmV0d29yayBjaGVja3N1bSwgYW5kIHRoZQ0Kc2FtZSBjaGVja3N1
bSBjb3ZlcnMgdGhlIEkvTyBvbiB0aGUgc2VydmVyIGFzIHdlbGwuDQoNClRoZSBpbnRlZ3JpdHkg
Y2FuIGJlIGdlbmVyYXRlZCBvbiB0aGUgY2xpZW50IGFuZCBzZW5kIG92ZXIgbmV0d29yaywNCm9u
IHNlcnZlciBibGstaW50ZWdyaXR5IGNhbiBqdXN0IG9mZmxvYWQgdG8gc3RvcmFnZS4NClZlcmlm
eSBmb2xsb3dzIHRoZSBzYW1lIHByaW5jaXBsZTogb24gc2VydmVyIGJsay1pbnRlZ3JpdHkgZ2V0
cw0KdGhlIFBJIGZyb20gc3RvcmFnZSB1c2luZyB0aGUgaW50ZXJmYWNlLCBhbmQgc2VuZCBvdmVy
IG5ldHdvcmssDQpvbiBjbGllbnQgd2UgY2FuIGRvIHRoZSB1c3VhbCB2ZXJpZnkuDQoNCkluIHRo
ZSBwYXN0IHdlIHRyaWVkIHRvIGFjaGlldmUgdGhpcywgdGhlcmUncyBwYXRjaCB0byBhZGQgb3B0
aW9uYWwNCmdlbmVyYXRlL3ZlcmlmeSBmdW5jdGlvbnMgYW5kIHRoZXkgdGFrZSBwcmlvcml0eSBv
dmVyIHRoZSBvbmVzIGZyb20gdGhlDQppbnRlZ3JpdHkgcHJvZmlsZSwgYW5kIHRoZSBvcHRpb25h
bCBnZW5lcmF0ZS92ZXJpZnkgZnVuY3Rpb25zIGRvZXMgdGhlDQptZXRhL1BJIGV4Y2hhbmdlLCBi
dXQgdGhhdCBkaWRuJ3QgZ2V0IHRyYWN0aW9uLiBJdCB3b3VsZCBiZSBtdWNoIGJldHRlcg0KaWYg
d2UgY2FuIGhhdmUgYW4gYmlvIGludGVyZmFjZSBmb3IgdGhpcy4NCg0KQ2hlZXJzDQpEb25neWFu
Zw0KPiANCj4gPiBOVk1lIFNTRCBjYW4gZG8gdGhlIG9mZmxvYWQgd2hlbiB0aGUgaG9zdCBzZW5k
cyB0aGUgUFJBQ1QgYml0LiBCdXQNCj4gPiBpbg0KPiA+IHRoZSBkcml2ZXIsIHRoaXMgaXMgdGll
ZCB0byBnbG9iYWwgaW50ZWdyaXR5IGRpc2FibGVtZW50IHVzaW5nDQo+ID4gQ09ORklHX0JMS19E
RVZfSU5URUdSSVRZLg0KPiANCj4gPiBTbywgdGhlIGlkZWEgaXMgdG8gaW50cm9kdWNlIGEgYmlv
IGZsYWcgUkVRX0lOVEVHUklUWV9PRkZMT0FEDQo+ID4gdGhhdCB0aGUgZmlsZXN5c3RlbSBjYW4g
c2VuZC4gVGhlIGJsb2NrLWludGVncml0eSBhbmQgTlZNZSBkcml2ZXINCj4gPiBkbw0KPiA+IHRo
ZSByZXN0IHRvIG1ha2UgdGhlIG9mZmxvYWQgd29yay4NCj4gDQo+IFdoZXRoZXIgdG8gaGF2ZSBh
IGJsb2NrIGRldmljZSBkbyB0aGlzIGlzIGN1cnJlbnRseSBjb250cm9sbGVkIGJ5IHRoZQ0KPiAv
c3lzL2Jsb2NrL2Zvby9pbnRlZ3JpdHkve3JlYWRfdmVyaWZ5LHdyaXRlX2dlbmVyYXRlfSBrbm9i
cy4gQXQgbGVhc3QNCj4gZm9yIFNDU0ksIHByb3RlY3RlZCB0cmFuc2ZlcnMgYXJlIGFsd2F5cyBl
bmFibGVkIGJldHdlZW4gSEJBIGFuZA0KPiB0YXJnZXQNCj4gaWYgYm90aCBzdXBwb3J0IGl0LiBJ
ZiBubyBpbnRlZ3JpdHkgaGFzIGJlZW4gYXR0YWNoZWQgdG8gYW4gSS9PIGJ5DQo+IHRoZQ0KPiBh
cHBsaWNhdGlvbi9maWxlc3lzdGVtLCB0aGUgYmxvY2sgbGF5ZXIgd2lsbCBkbyBzbyBjb250cm9s
bGVkIGJ5IHRoZQ0KPiBzeXNmcyBrbm9icyBhYm92ZS4gSU9XLCBpZiB0aGUgaGFyZHdhcmUgaXMg
Y2FwYWJsZSwgcHJvdGVjdGVkDQo+IHRyYW5zZmVycw0KPiBzaG91bGQgYWx3YXlzIGJlIGVuYWJs
ZWQsIGF0IGxlYXN0IGZyb20gdGhlIGJsb2NrIGxheWVyIGRvd24uDQo+IA0KPiBJdCdzIHBvc3Np
YmxlIHRoYXQgdGhpbmdzIGRvbid0IHdvcmsgcXVpdGUgdGhhdCB3YXkgd2l0aCBOVk1lIHNpbmNl
LA0KPiBhdA0KPiBsZWFzdCBmb3IgUENJZSwgdGhlIGRyaXZlIGlzIGJvdGggaW5pdGlhdG9yIGFu
ZCB0YXJnZXQuIEFuZCBOVk1lIGFsc28NCj4gbWlzc2VkIHF1aXRlIGEgZmV3IERJWCBkZXRhaWxz
IGluIGl0cyBQSSBpbXBsZW1lbnRhdGlvbi4gSXQncyBiZWVuIGENCj4gd2hpbGUgc2luY2UgSSBt
ZXNzZWQgd2l0aCBQSSBvbiBOVk1lLCBJJ2xsIGhhdmUgYSBsb29rLg0KPiANCj4gQnV0IGluIGFu
eSBjYXNlIHRoZSBpbnRlbnQgZm9yIHRoZSBMaW51eCBjb2RlIHdhcyBmb3IgcHJvdGVjdGVkDQo+
IHRyYW5zZmVycyB0byBiZSBlbmFibGVkIGF1dG9tYXRpY2FsbHkgd2hlbiBwb3NzaWJsZS4gSWYg
dGhlIGJsb2NrDQo+IGxheWVyDQo+IHByb3RlY3Rpb24gaXMgZXhwbGljaXRseSBkaXNhYmxlZCwg
YSBmaWxlc3lzdGVtIGNhbiBzdGlsbCB0cmlnZ2VyDQo+IHByb3RlY3RlZCB0cmFuc2ZlcnMgdmlh
IHRoZSBiaXAgZmxhZ3MuIFNvIHRoYXQgY2FwYWJpbGl0eSBzaG91bGQNCj4gZGVmaW5pdGVseSBi
ZSBleHBvc2VkIHZpYSBpb191cmluZy4NCj4gDQo+ID4gIldvcmsgaXMgaW4gcHJvZ3Jlc3MgdG8g
aW1wbGVtZW50IHN1cHBvcnQgZm9yIHRoZSBkYXRhIGludGVncml0eQ0KPiA+IGV4dGVuc2lvbnMg
aW4gYnRyZnMsIGVuYWJsaW5nIHRoZSBmaWxlc3lzdGVtIHRvIHVzZSB0aGUgYXBwbGljYXRpb24N
Cj4gPiB0YWcuIg0KPiANCj4gVGhpcyBkaWRuJ3QgZ28gYW55d2hlcmUgZm9yIGEgY291cGxlIG9m
IHJlYXNvbnM6DQo+IA0KPiDCoC0gSW5kaXZpZHVhbCBkaXNrIGRyaXZlcyBzdXBwb3J0ZWQgQVRP
IGJ1dCBldmVyeSBzdG9yYWdlIGFycmF5IHdlDQo+IMKgwqAgd29ya2VkIHdpdGggdXNlZCB0aGUg
YXBwIHRhZyBzcGFjZSBpbnRlcm5hbGx5LiBBbmQgdGh1cyB0aGVyZSB3ZXJlDQo+IMKgwqAgdmVy
eSBmZXcgcmVhbC1saWZlIHNpdHVhdGlvbnMgd2hlcmUgaXQgd291bGQgYmUgcG9zc2libGUgdG8g
c3RvcmUNCj4gwqDCoCBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGluIGVhY2ggYmxvY2suDQo+IA0K
PiDCoMKgIEJhY2sgaW4gdGhlIG1pZC0yMDAwcywgcHV0dGluZyBlbnRlcnByaXNlIGRhdGEgb24g
aW5kaXZpZHVhbCBkaXNrDQo+IMKgwqAgZHJpdmVzIHdhcyBub3QgY29uc2lkZXJlZCBhY2NlcHRh
YmxlLiBTbyBpbXBsZW1lbnRpbmcgZmlsZXN5c3RlbQ0KPiDCoMKgIHN1cHBvcnQgdGhhdCB3b3Vs
ZCBvbmx5IGJlIHVzYWJsZSBvbiBpbmRpdmlkdWFsIGRpc2sgZHJpdmVzIGRpZG4ndA0KPiDCoMKg
IHNlZW0gd29ydGggdGhlIGludmVzdG1lbnQuIEVzcGVjaWFsbHkgd2hlbiB0aGUgUEktZm9yLUFU
QSBlZmZvcnRzDQo+IMKgwqAgd2VyZSBhYmFuZG9uZWQuDQo+IA0KPiDCoMKgIFdydC4gdGhlIGFw
cCB0YWcgb3duZXJzaGlwIHNpdHVhdGlvbiBpbiBTQ1NJLCB0aGUgc3RvcmFnZSB0YWcgaW4NCj4g
TlZNZQ0KPiDCoMKgIHNwZWMgaXMgYSByZW1lZHkgZm9yIHRoaXMsIGFsbG93aW5nIHRoZSBhcHBs
aWNhdGlvbiB0byBvd24gcGFydCBvZg0KPiDCoMKgIHRoZSBleHRyYSB0YWcgc3BhY2UgYW5kIHRo
ZSBzdG9yYWdlIGRldmljZSBpdHNlbGYgYW5vdGhlci4NCj4gDQo+IMKgLSBPdXIgcHJvcG9zZWQg
dXNlIGNhc2UgZm9yIHRoZSBhcHAgdGFnIHdhcyB0byBwcm92aWRlIGZpbGVzeXN0ZW1zDQo+IHdp
dGgNCj4gwqDCoCBiYWNrIHBvaW50ZXJzIHdpdGhvdXQgaGF2aW5nIHRvIGNoYW5nZSB0aGUgb24t
ZGlzayBmb3JtYXQuDQo+IA0KPiDCoMKgIFRoZSB1c2Ugb2YgMHhGRkZGIGFzIGVzY2FwZSBjaGVj
ayBpbiBQSSBtZWFudCB0aGF0IHRoZSBjYWxsZXIgaGFkDQo+IHRvDQo+IMKgwqAgYmUgdmVyeSBj
YXJlZnVsIGFib3V0IHdoYXQgdG8gc3RvcmUgaW4gdGhlIGFwcCB0YWcuIE91ciBwcm90b3R5cGUN
Cj4gwqDCoCBhdHRhY2hlZCBzdHJ1Y3RzIG9mIG1ldGFkYXRhIHRvIGVhY2ggZmlsZXN5c3RlbSBi
bG9jayAoOCA1MTItYnl0ZQ0KPiDCoMKgIHNlY3RvcnMgKiAyIGJ5dGVzIG9mIFBJLCBzbyAxNiBi
eXRlcyBvZiBtZXRhZGF0YSBwZXIgZmlsZXN5c3RlbQ0KPiDCoMKgIGJsb2NrKS4gQnV0IG5vbmUg
b2YgdGhvc2UgMi1ieXRlIGJsb2JzIGNvdWxkIGNvbnRhaW4gdGhlIHZhbHVlDQo+IMKgwqAgMHhG
RkZGLiBXYXNuJ3QgcmVhbGx5IGEgZ3JlYXQgaW50ZXJmYWNlIGZvciBmaWxlc3lzdGVtcyB0aGF0
DQo+IHdhbnRlZA0KPiDCoMKgIHRvIGJlIGFibGUgdG8gYXR0YWNoIHdoYXRldmVyIGRhdGEgc3Ry
dWN0dXJlIHdhcyBpbXBvcnRhbnQgdG8NCj4gdGhlbS4NCj4gDQo+IFNvIGJldHdlZW4gYSB2ZXJ5
IGxpbWl0ZWQgc2VsZWN0aW9uIG9mIGhhcmR3YXJlIGFjdHVhbGx5IHByb3ZpZGluZw0KPiB0aGUN
Cj4gYXBwIHRhZyBzcGFjZSBhbmQgYSBjbHVua3kgaW50ZXJmYWNlIGZvciBmaWxlc3lzdGVtcywg
dGhlIGFwcCB0YWcNCj4ganVzdA0KPiBuZXZlciByZWFsbHkgdG9vayBvZmYuIFdlIGVuZGVkIHVw
IG1vZGlmeWluZyBpdCB0byBiZSBhbiBhY2Nlc3MNCj4gY29udHJvbA0KPiBpbnN0ZWFkLCBzZWUg
dGhlIGFwcCB0YWcgY29udHJvbCBtb2RlIHBhZ2UgaW4gU0NTSS4NCj4gDQo+IERhdGFiYXNlcyBh
bmQgbWFueSBmaWxlc3lzdGVtcyBoYXZlIG1lYW5zIHRvIHByb3RlY3QgYmxvY2tzIG9yDQo+IGV4
dGVudHMuDQo+IEFuZCB0aGVzZSBtZWFucyBhcmUgb2Z0ZW4gYmV0dGVyIGF0IGlkZW50aWZ5aW5n
IHRoZSBuYXR1cmUgb2YgcmVhZC0NCj4gdGltZQ0KPiBwcm9ibGVtcyB0aGFuIGEgQ1JDIG92ZXIg
ZWFjaCA1MTItYnl0ZSBMQkEgd291bGQgYmUuIFNvIHdoYXQgbWFkZSBQSQ0KPiBpbnRlcmVzdGlu
ZyB3YXMgdGhlIGFiaWxpdHkgdG8gY2F0Y2ggcHJvYmxlbXMgYXQgd3JpdGUgdGltZSBpbiBjYXNl
DQo+IG9mIGENCj4gYmFkIHBhcnRpdGlvbiByZW1hcCwgd3JvbmcgYnVmZmVyIHBvaW50ZXIsIG1p
c29yZGVyZWQgYmxvY2tzLCBldGMuDQo+IE9uY2UNCj4gdGhlIGRhdGEgaXMgb24gbWVkaWEsIHRo
ZSBkcml2ZSBFQ0MgaXMgc3VwZXJpb3IuIEFuZCBhZ2FpbiwgYXQgcmVhZA0KPiB0aW1lDQo+IHRo
ZSBkYXRhYmFzZSBvciBhcHBsaWNhdGlvbiBpcyBvZnRlbiBiZXR0ZXIgZXF1aXBwZWQgdG8gaWRl
bnRpZnkNCj4gY29ycnVwdGlvbiB0aGFuIFBJLg0KPiANCj4gQW5kIGNvbnNlcXVlbnRseSBvdXIg
aW50ZXJlc3QgZm9jdXNlZCBvbiB0cmVhdGluZyBQSSBzb21ldGhpbmcgbW9yZQ0KPiBha2luDQo+
IHRvIGEgbmV0d29yayBjaGVja3N1bSB0aGFuIGEgZmFjaWxpdHkgdG8gcHJvdGVjdCBkYXRhIGF0
IHJlc3Qgb24NCj4gbWVkaWEuDQo+IA0KDQo=

