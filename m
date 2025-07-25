Return-Path: <linux-fsdevel+bounces-56052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C617AB12333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A414A1CE57D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA12EFDA9;
	Fri, 25 Jul 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASqIyCF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50924291C;
	Fri, 25 Jul 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465691; cv=fail; b=s7CYwMbwPorbVO0z6V5tBEdy+VEklTCcCYTuQec5A65j50+0F/V5xZAwXfaIdx8Sh6YeN4sLLGxbuO1s8Zr8FwV9JfvN9RMFoCvKYGZ8CJT4EKFSnmQUro3hidVhIKsqNf3klA84e9s3czn/boQugiCMnUEWUByXfozM2HZM4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465691; c=relaxed/simple;
	bh=pRhBojZrepAoiJ7Mgq4ScgwrSQekIP/yNo4hyy7kO6Q=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BHhTsWl/mlblhgzUy0VMQzXqLi0Qc3JEkmgLuPzeJtabZ7Hlk3i01Oc8euKxjxpvgCH6Jea/MOpSyHoAYyF8vmeq1YZ2i6T18iQyaUOAigxf/fDl+aCsGfcm5q8bAOXkzyfFAknArxGDUbttjh2CpgPVxZftz/hWyzA/FDUJ61U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASqIyCF0; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9ZxM7008096;
	Fri, 25 Jul 2025 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=pRhBojZrepAoiJ7Mgq4ScgwrSQekIP/yNo4hyy7kO6Q=; b=ASqIyCF0
	XYpXHMsaIMfHBn7aiiqUZLA7f15A3e/dMbSncC58hqvv0h5XorvzNr1Iexh4WI6w
	awVqLFgA1BtugpG4NHNuS31NyGC+tEs2wCupVWKWAztnKmhcKicxtQSqHWGNPX2H
	vF+gLONSA74NMyI2W1S4W09Nty6Tv2UcS1C7D+Z06zCRPn3c36Dy2cbblBU4OSTC
	0IZAnaSp0KRTKRWF9YlvY5DExQmSxj0Ba9JM4ubh735XHJ8Neu2El5fB7Flvu1Fr
	pUUqS2V/XoIs3ExjGrY/4D4y4AwK6l7fdiBAn/pypP/NQyrozVoxJ8ae+ohHmBpI
	m4/rzs9FFHBC7Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wckvds1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:48:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1hxMc4VHOz1eyYcToru0hwgX/gSPihV4a1jHkFz+AaJhEoQwVSI1OSdOvKIRax2dyu9YOElPfztbmIzAlBwDOlBcCwU/hCvVkUlGEyAvY83OR6HODFbUvuZxj9CFC7xSVjQ5pHvpU4sInlhvblz6rXwdItp4pk0W9Uke4EiYKjsSN5ywztXfUxpr29p3fzuCZ6a7TvaxNzSnWFYqEuJvQd0AXWx0RKLpuDqrCos2qVFwZJ4tbV46CacRF7OyowIKN5Sun6M0zstVMxrwmwl/LeYHDJqDF0b15n5WtEPrPcKk2a7cPRY2jQ0FBHVC0Xz4a5Jn96EZ5vLBt43CjWe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRhBojZrepAoiJ7Mgq4ScgwrSQekIP/yNo4hyy7kO6Q=;
 b=TsIzE3fbgkcmi5yjt5scK1vAASQuxNbsgOXUkTFw3R7BOVtA1WyfMWTK4GbelpJbktgwkhyzG08zMZDJ20sK0lLdu29NuaoVYe09pbbS7wA+NPG3a3UeSuH6v9lMunpB7cJ0QQmK6vqiPhir4SV60G8wjRomOH6GMd/6pGo2eF+YS/xJePIK2d2zz72k573QNMDy+bl/J38EIV0DA3QrWaANnkQ69Y0eOHituDssBBq56nTqrwUDZ4oas1bMNMxe45J9dKTsMFAbNUXvtPZEVgUnvvtneRLrTwciL+zSwsfMhuy6YbbCz+eeVvqoUnu6SeomWBdgqMZ83fD84tXU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6262.namprd15.prod.outlook.com (2603:10b6:610:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 17:47:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 25 Jul 2025
 17:47:58 +0000
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
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAIAAzLAAgADYSYCAACXrAIAAFPAAgABSngCAAOLPgA==
Date: Fri, 25 Jul 2025 17:47:57 +0000
Message-ID: <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
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
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
In-Reply-To: <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6262:EE_
x-ms-office365-filtering-correlation-id: 8c61259a-e41a-48bf-d251-08ddcba36455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFJCMmNQOVpJU1pMdlBSU3VzMVRsOHpXcnRGN1NLcXFiNm1NTmY4N3pWdkZX?=
 =?utf-8?B?K1VBYWZpMXA3bHJuUTdKQmFjSU95OUg2Mm1MWVJJdUlVYnFCVmRqYlpvemFy?=
 =?utf-8?B?c3RSdkk4RDE0OG5raTdtajRmckEzMXkzRmNGYnJXdVJ3SitQSkoycFBhcWpV?=
 =?utf-8?B?RWJzUTdFNlNaNzM2RWtkMHpyaHlhNy93bmg5SnVpYjZrU3hXNm1ReWJpS2pr?=
 =?utf-8?B?RkZ5U2tCeUdMTFhxYU1NUHV3dnpBTWNkTUpaSXJ0UGQrWVVCenJ5NjgrZXNt?=
 =?utf-8?B?dGNUL3BWb0Nya3hiQmV5OGQ2QVF2elY1Y3hIU2hiSHNuR3BibENBRHVZaXdG?=
 =?utf-8?B?K09obXc4YUhCTHpkQXM2RnBEY01wdnEzY0t2bXNpaHNaVjlZWVFqT2swZVBi?=
 =?utf-8?B?a1hpVlh3dlpocEo1SDBRQS9jMDNvamJiakQxWGdtVWpvak92bFhRcGQ2cjZS?=
 =?utf-8?B?elkzTkFWS2VLYmlQM1BnV0poSDJFakk4UGJSbUYwNkhxWW0wbHQraC9NSXlR?=
 =?utf-8?B?MjVNcVRUdVVocjVBUlVVTGlnYTZLeitDS0ZmWnJTSHhJbjJCaTFKbHBFamh5?=
 =?utf-8?B?N0VHalcrbDhyWHJjeGlnSHZlTVl4UDhKMVJIMXBtaVVUcUtGN0Q1SWN4VEp0?=
 =?utf-8?B?Ni8rb0YwRG5yYm9KTzRyUWVFTDBGRGlwQUJFODhsc0x3L2lZNnMzQXQvQklW?=
 =?utf-8?B?ek9WaWtVdjE3QisxMSs5T0lTU08rZ2wvK1ZpWXEyT2R3bHBnaXRxNVdZY3FZ?=
 =?utf-8?B?QjdWUWUwN0F1RDJvK29DYUFhWm04SW9HODhlMmdENjg2Mm4wWU9qbUFvZ1No?=
 =?utf-8?B?VUJ2VEZZRC9ndGxlTmVKL2Z0SDdza0E2REJPZng1OGhlUHVlTmhvbzdSZ3dw?=
 =?utf-8?B?LzRvMlBwenB6dGtWMUpLMFNJR0ZRN1VUTXFOaXEraWg1RGFWV1l0OWlQVGM3?=
 =?utf-8?B?M2xWKysrclU4Y1cxVHEzNDZZTGNCYTQzb3hUYVkzS2JPN3RkN0wxMDczRmdG?=
 =?utf-8?B?enQ3TkF3dzQwczJPZDZ4dzhPWWxic3MzVXBZL3BncTJvL2MxeEcxYnFyYWpt?=
 =?utf-8?B?bGhzVWxVWCtNRkd1bTd3WTBpeFBOMmlsNVpsZmZGNmNidHZ5RWVjRE0zcTlG?=
 =?utf-8?B?N1pCN1hWcWxJendCRFBXRnZOWlhKRnk4RjB1NEpYZ2VGQXhSeHhwNFhCUWo5?=
 =?utf-8?B?eEVrcDQ0VnV6QStWMVZja0hlamFVK1BHZVE1OE9uYlIvYVBKQkVLOXJranRt?=
 =?utf-8?B?TG93dU15STBWSjU2cjBtQlpSOFpadkM2RDlIaXdIbFh3QW5ZV080Ni9YRTZ5?=
 =?utf-8?B?dGNWMFZpMkVUN0JVdHdTYzRwTG1acUh2c1NvemZQM2RyVHgrV2RmQjFybW5U?=
 =?utf-8?B?eUpWcUNMeUJMdlc4UndxT1dqTzVyRjFhUXdBQlg5Mmhlc1FQY3V4UXRJS3Bp?=
 =?utf-8?B?RkoxMU9YOTBySnNOUDBWVVo0eXRheEJDYkpMQ0EycSs3MkhHRG80YzkybVZj?=
 =?utf-8?B?Q3hYNlpHQXFxcHFwUjlaWFU3Sm9FUVhZOXZ4aDNxalNFOWZzNlp1SVYya2ps?=
 =?utf-8?B?endpRFluelZpYlZSbXdxQ3J0dHl1bVdwcjNHNlNwcHZ1U3NiRGg0RW9CcWk2?=
 =?utf-8?B?TnY2UEI1K2JHK2EweGdDSGpMQmpKR1VlRWM4dTEzVnJSWDluUGNqUm5aUDRP?=
 =?utf-8?B?ZTIxaCt2bkNsVU1WdHZiOUt3dTFHMFFEYjVQR1dVUnZ0cXp6SkFudWRuaThM?=
 =?utf-8?B?d3Q5MTRDMzVSNkFsTVlYeXVONXhWUXZQc3NNMXZ4L1A2elJEZHg0UW81YzVh?=
 =?utf-8?B?SWJyZlB1Wkc4YTc2QTAwRkdPRzlvTVVuRFlxS1hPZnRzTTBjL3crTjdJeVNX?=
 =?utf-8?B?ZjFGelJrbTlYNUFiOUEvZE9tNjdaSDZTV2dVWlRJOVplRjQ1Sjh4TzA2QmlO?=
 =?utf-8?B?SEhBOXJJdnNmM1lOMTR0eDVqZS9ZNW5ielNOUXljMTFFQ2J3TGJIZjZ1OW1l?=
 =?utf-8?B?SDU4ZVhkenNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2xiYkVHVmQreVNJNWYzMk9YN1U1U2h6ZTQ1WERidkJacWtOZHdqd1Y0eXBP?=
 =?utf-8?B?SzFzZXhja1FkSndQSTB5S1RiRytqUWJMLzNnU2dTNkZLNWxhbHpVTkZzbExC?=
 =?utf-8?B?ZStVQ3BOejZ4YU5lN01XOVZoc21YSHhIMWFPbjlnTkJNU1J3Y3NvanRKZGdG?=
 =?utf-8?B?THJsMTlEazBUWkl1Qi9QNUI5OTBZQUZRWXIwZVhydEZRRTd5WW9lL1hMNSto?=
 =?utf-8?B?SGhBd1J5S1VGUzE2b3MvYU5qd2pJMW00YnVydndQUEhDZGRpV25DaTF3eGZE?=
 =?utf-8?B?Rk44V24rNVVyblFudkV5SGN3V2VoYUR0RWhsVGRaaW9URHAyTW9ZNUJoQ2xW?=
 =?utf-8?B?TndYZ1dFYm1XWXltbmI1NjJ2VFU5N3BHUGZBVTNDU0w2bCsrczhHeGg4elov?=
 =?utf-8?B?Y3c4L3Q0V1hDUFg0K2VianE1RnNtendLS2FIRVN0TUxVUi8xVHdpRTRHNFVT?=
 =?utf-8?B?WXlaYlZQSWR1dFlQdlVFeklLZEtpMUdFTlFnZWRnbHVCZXJxdWY0MzZKaEdG?=
 =?utf-8?B?VStVK0R0VzBwU0QyYXJuSTF2WHdyTWZiMVVadGppOURVV3F2MnpMaHhBOHVk?=
 =?utf-8?B?czY1NTl6aFFuYS8vblBSMW9rYSsrb0puM0F6Q1AvNUJpTjlOdHUzUW9qZERD?=
 =?utf-8?B?bmdYb081QkVuMGw2WXFLT3FxTjFLRjJDMGlMK1VlU3d4S1VQQ2M4MEZMK0hn?=
 =?utf-8?B?MTA3S2ZXZEJhZzVwbEI5SHY2SFFjNkJSdTdIaTBxVVZHdnZKcTAvQTR6ak1D?=
 =?utf-8?B?eGsxM0lySVhZKzlGUEI4eHZNSlowb2dDUE9YSnZHTVgva0UxSytjTXFmRVNJ?=
 =?utf-8?B?N3AwKytVN0dCaUVEcDdWM2RuM3d0aWVQZVlOZ1RDMWtFd1RYcW9FRUdxNFpo?=
 =?utf-8?B?eGIxYys5QThyUllic2NFdFBoQkF0ZlE4RlZNOTIxNThFb2RnV2pZREFLaXRv?=
 =?utf-8?B?WDU0R2diMFVjZVp4bG5pdEl2THJuR0pTbi85YUtWY292ejlJcWZ6MGYySkpQ?=
 =?utf-8?B?dGtndTU0Mk9XclVsL2tua2JuSW9PT3RWZThxUTBtUmtvMkdaV0V3NzF6T24w?=
 =?utf-8?B?amFsaDFMWVNiMTNkNEIrbHZRR0NINm9Gc2hlQUxnQVI4a2l5cDBRMEFOZVNa?=
 =?utf-8?B?M3JhMWZScUxBN3BaOW1OcEJCSW5zdFVUeEFSclhlN25JVFFiZ3VBV3lEeUZB?=
 =?utf-8?B?OVc4S2duVExYSnplTlZmYWdNRGI2OEMzZUFUU25PR3huQjdRRDR2WXZtWXU3?=
 =?utf-8?B?S0tJeDFOMmw2SUN3QmxGak5aTU9CRVI2SzlrbUdQTlhERkoxSW9udjRuRTBn?=
 =?utf-8?B?YXRLS0kvUGpsU0IxODRsVVRYbW9seEFHK1JDbkdjenFUZ3J5ZlJOOVJ5cE4w?=
 =?utf-8?B?VW5oR1BJc1NIS2FaWkl4VnUyNUlTNmRoZDladk5JNWJNWGdlVEk4dVpZNEJO?=
 =?utf-8?B?eXlpZ2RjVUlPeXNxZ09VS3Zmb3ZoeStRRGI0YklUY21HTHpJNDZjekRoSDhp?=
 =?utf-8?B?VlZmb0lmTFR3azBlVGw1RWxRSWFna3RUcTlwaW1jS01VWDdoTUJTMHlQU2di?=
 =?utf-8?B?VFpuRy9rVlJVQzFHVXVUYVp6SkNvRXkvTWh4Wm9tdWtNbU5pU1hWSkR6YXNJ?=
 =?utf-8?B?S3B5Ym1DQ00rZEdOakVvTjFCVnZNYUxNVzg1emhXNmd3b25QUWpzN3I1eDJv?=
 =?utf-8?B?N0xOTXAzZzFxWE9RRUJGL0U2QkduZDBrTGRBR2paSkVBWW55YlIxWngwRmJZ?=
 =?utf-8?B?eVI4UkMzcy9zSUVuVjRKWHJRT205ZU1xSkw3bXpxTGZtL3N3cEJ6Y2hzZXdj?=
 =?utf-8?B?OGpMelZmSm44MCsrK01Tb05FYVJGT1FOQ1VHc3pEU0lvSXdTVUNuaWVwNmFn?=
 =?utf-8?B?UVJnRGJvTHViMXl5Tyt2bXRsVkROenFEMklSN1FJazBaNlpQdFoyTUtLSUFa?=
 =?utf-8?B?NWhwZTdXcUk1Z2tSSitKNDQwRy9VNGo2TEplWkd3Um8xa0pDNGtEWUtKZDQ1?=
 =?utf-8?B?Nk5VN1lqcjdsc2dLbjVaRW9Sc2NTREdwUHdqS2svZUlsVHpRaFdXQ1NXeUE0?=
 =?utf-8?B?MVR5clVuVnFXUmE5Q0V3TWRxNHZMQXlCaWZ2TE10R3hpVW5iNHNwdk9rbXAv?=
 =?utf-8?B?Z1MzdnNVR3A4bmpndXFzcHpWNjJPd2RLRDE0TzNsNk0ySUgyYmV6MXQ1RHlN?=
 =?utf-8?Q?oeSOislk402qZ7TnA3DlUaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67044E26121CA74BBB729A64C5EF1135@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61259a-e41a-48bf-d251-08ddcba36455
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 17:47:57.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbsv0b+q1Ty12GaJ9tK5hv5cSlB+QydcBHevY/Wb4VAYvVJq9mBGBgoC/rgrs8JtSRnqjuziwVxvxy7Ycv1ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6262
X-Proofpoint-GUID: HBIGphB0ck6RRL-Vq_XYAgzQyxM_VFCQ
X-Proofpoint-ORIG-GUID: HBIGphB0ck6RRL-Vq_XYAgzQyxM_VFCQ
X-Authority-Analysis: v=2.4 cv=JM47s9Kb c=1 sm=1 tr=0 ts=6883c350 cx=c_pps
 a=Yzk63BLrwl8U5sAeLGHB6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=7c76U_LuNv5U3tL4cy0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MiBTYWx0ZWRfX6lDMGD+6T7zD
 OqggvPjqLjWjRa9ANugWfh8yKK/xG6b5lzYSQbY+UzlK6S4LGRGVOrQkIMptxH8P4DwtUaScEwE
 C8FvVOKsyGcOYMKSfoXVK/rKpFgT7bqWvuojVqgkaTO7xp36rc+WUYQ62JIHaSzLplH46Lk24Yu
 V2G1MvtMu04EHD0WDkRT7N7bJXzzmRj/rnbpwP0C0Sci8C7tbpaRVSMRDPXPz1MwBjVZqZCBdSE
 zi02jPfZ5PuM46Mcb3pRKf20NqwL6P22m4Q54bXe5LKAz8S6FoNuRd0CkVlIexEB+VYAK7P2SCc
 JwyQOAU/IrRlk6zyU5ieDbp4x5YXKkoNnQrF6Ld17FiOxVepdd8cQQLAuS/13reFqJ1n6TWLd3/
 LZe4czJUCRLIqVDLjm4TtRN4Q3nBS4JqqTPu9gYF5up0zd9RJCyUQJlNT8dGT2Z7y+Noy3sI
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250152

T24gRnJpLCAyMDI1LTA3LTI1IGF0IDEzOjE2ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMDcvMjUgODoyMCwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+IE9uIDIwMjUvMDcv
MjUgNzowNSwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+ID4gPiA+IEJ1dCBJIGNhbid0IGJlIGNv
bnZpbmNlZCB0aGF0IGFib3ZlIGNoYW5nZSBpcyBzdWZmaWNpZW50LCBmb3IgaWYgSSBkbw0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ICsJICAgICAgICAgICAgc3RhdGljIHU4IHNlcmlhbDsNCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgaWYgKGlub2RlLT5pX2lubyA8IEhGU19GSVJTVFVTRVJfQ05J
RCAmJiAoKDFVIDw8IGlub2RlLT5pX2lubykgJiBiYWRfY25pZF9saXN0KSkNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBpbm9kZS0+aV9pbm8gPSAoc2VyaWFsKyspICUgMTY7DQo+
ID4gPiA+IA0KPiA+ID4gPiBJIGRvbid0IHNlZSB0aGUgcG9pbnQgaW4gZmxhZ3MgaW50cm9kdWN0
aW9uLiBJdCBtYWtlcyBsb2dpYyB2ZXJ5IGNvbXBsaWNhdGVkLg0KPiA+ID4gDQo+ID4gPiBUaGUg
cG9pbnQgb2YgdGhpcyBjaGFuZ2UgaXMgdG8gZXhjZWNpc2UgaW5vZGUtPmlfaW5vIGZvciBhbGwg
dmFsdWVzIGJldHdlZW4gMCBhbmQgMTUuDQo+ID4gPiBTb21lIG9mIHZhbHVlcyBiZXR3ZWVuIDAg
YW5kIDE1IG11c3QgYmUgdmFsaWQgYXMgaW5vZGUtPmlfaW5vICwgZG9lc24ndCB0aGVzZT8gVGhl
biwNCj4gPiANCj4gPiBCYWNrZ3JvdW5kOiBJIGFzc3VtZSB0aGF0IHRoZSB2YWx1ZSBvZiByZWMt
PmRpci5EaXJJRCBjb21lcyBmcm9tIHRoZSBoZnMgZmlsZXN5c3RlbSBpbWFnZSBpbiB0aGUNCj4g
PiByZXByb2R1Y2VyIChpLmUuIG1lbWZkIGZpbGUgYXNzb2NpYXRlZCB3aXRoIC9kZXYvbG9vcDAg
KS4gQnV0IHNpbmNlIEkgZG9uJ3Qga25vdyB0aGUgb2Zmc2V0IHRvIG1vZGlmeQ0KPiA+IHRoZSB2
YWx1ZSBpZiBJIHdhbnQgdGhlIHJlcHJvZHVjZXIgdG8gcGFzcyByZWMtPmRpci5EaXJJRCA9PSAx
Li4uMTUgaW5zdGVhZCBvZiByZWMtPmRpci5EaXJJRCA9PSAwLA0KPiA+IEkgYW0gbW9kaWZ5aW5n
IGlub2RlLT5pX2lubyBoZXJlIHdoZW4gcmVjLT5kaXIuRGlySUQgPT0gMC4NCj4gPiANCj4gDQo+
IEkgbWFuYWdlZCB0byBmaW5kIHRoZSBvZmZzZXQgb2YgcmVjLT5kaXIuRGlySUQgaW4gdGhlIGZp
bGVzeXN0ZW0gaW1hZ2UgdXNlZCBieQ0KPiB0aGUgcmVwcm9kdWNlciwgYW5kIGNvbmZpcm1lZCB0
aGF0IGFueSAwLi4uMTUgdmFsdWVzIGV4Y2VwdCAyLi40IHNoYWxsIGhpdCBCVUcoKQ0KPiBpbiBo
ZnNfd3JpdGVfaW5vZGUoKS4NCj4gDQo+IEFsc28sIGEgbGVnaXRpbWF0ZSBmaWxlc3lzdGVtIGlt
YWdlIHNlZW1zIHRvIGhhdmUgcmVjLT5kaXIuRGlySUQgPT0gMi4NCj4gDQo+IFRoYXQgaXMsIHRo
ZSBvbmx5IGFwcHJvYWNoIHRoYXQgY2FuIGF2b2lkIGhpdHRpbmcgQlVHKCkgd2l0aG91dCByZW1v
dmluZyBCVUcoKQ0KPiB3b3VsZCBiZSB0byB2ZXJpZnkgdGhhdCByZWMudHlwZSBpcyBIRlNfQ0RS
X0RJUiBhbmQgcmVjLmRpci5EaXJJRCBpcyBIRlNfUk9PVF9DTklELg0KPiANCj4gLS0tIGEvZnMv
aGZzL3N1cGVyLmMNCj4gKysrIGIvZnMvaGZzL3N1cGVyLmMNCj4gQEAgLTM1NCw3ICszNTQsNyBA
QCBzdGF0aWMgaW50IGhmc19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVj
dCBmc19jb250ZXh0ICpmYykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBiYWlsX2hm
c19maW5kOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgaGZzX2Jub2Rl
X3JlYWQoZmQuYm5vZGUsICZyZWMsIGZkLmVudHJ5b2Zmc2V0LCBmZC5lbnRyeWxlbmd0aCk7DQo+
IC0gICAgICAgICAgICAgICBpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9ESVIpDQo+ICsgICAgICAg
ICAgICAgICBpZiAocmVjLnR5cGUgIT0gSEZTX0NEUl9ESVIgfHwgcmVjLmRpci5EaXJJRCAhPSBj
cHVfdG9fYmUzMihIRlNfUk9PVF9DTklEKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmVz
ID0gLUVJTzsNCj4gICAgICAgICB9DQo+ICAgICAgICAgaWYgKHJlcykNCj4gDQo+IElzIHRoaXMg
Y29uZGl0aW9uIGNvcnJlY3Q/DQo+IA0KPiBEaXNjdXNzaW9uIG9uIHdoYXQgdmFsdWVzIHNob3Vs
ZCBiZSBmaWx0ZXJlZCBieSBoZnNfcmVhZF9pbm9kZSgpIGlzDQo+IG91dCBvZiBzY29wZSBmb3Ig
dGhpcyBzeXpib3QgcmVwb3J0Lg0KDQpJIGFscmVhZHkgc2hhcmVkIGluIHByZXZpb3VzIGVtYWls
cyB3aGljaCBwYXJ0aWN1bGFyIGlub2RlIElEcyBhcmUgdmFsaWQgb3Igbm90DQpmb3IgWzAtMTZd
IGdyb3VwIG9mIHZhbHVlcyBpbiB0aGUgZW52aXJvbm1lbnQgb2YgaGZzX3JlYWRfaW5vZGUoKS4N
Cg0KVGhhbmtzLA0KU2xhdmEuDQo=

