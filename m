Return-Path: <linux-fsdevel+bounces-37701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF99F5EBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 07:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8029E168559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F8156F30;
	Wed, 18 Dec 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XgT29CJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1481531E2;
	Wed, 18 Dec 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504122; cv=fail; b=RQLUiAFRaj5xMzWDXQT1P8N2r+MgiohcXqEcUuuJ4T4j86qWkjcejnrH9kHo4yBeKIBAUBj6bC49vfLpReHSMPBsgIODLKcurgQX1smsEemUZtusebmNMRZ2mR0so+DRGd4aLkDoxtfLgU41eGrudC+mgtmSiSWK0hIhmOvHkuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504122; c=relaxed/simple;
	bh=cz5OwlIQmXGAflgkgRPp0gnNHg1mezidnxMSiq2wczw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h75tCrbDyUKwbiDtYkNkMUCjs8RuGSamZjVyiBgBrjl+MWTD/S9yeFZcmglk/jj6GoPNhUCw79XRcCsPU6CQQglumLjXtThPz9uV1T7fgSBSw2GqMViu41WxzyshVPqTFGV8dIRT4th+ZdTjbpXlirwMHQo8UcUyz1XJ6cyh704=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XgT29CJT; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3mHw6008281;
	Tue, 17 Dec 2024 22:41:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=cz5OwlIQmXGAflgkgRPp0gnNHg1mezidnxMSiq2wczw=; b=
	XgT29CJT4KVJxT7Bu/GiAYWLyVRGZYOrxACbsQtyeRxmJ9fAjUw4EpD35mVBhKpz
	BzEWmMoCmRW00zPuCsGY2tEDJFfSRM/zaQ+l447ODP117KiOrbSQAn0jQ8U5K6iw
	fHMJjFPFjgxwoBKpu0+0PxMbPvKSaBcyvgKMeadoCvRAt3HW0Wd2t4tAX8DIbtrG
	dLujKPnNkx4IBcIWYeSYQJdNOysJKIE2kn2T8dNXVctsQUZ1XJLR9EQ9yR2WfZWW
	pWHVql3KR3aivehskJuvvuK8bPBn/7JPPedsjEuqQvHsSQoWPwIREolGYlTOnbhG
	Eu/WHtLxvxLuGa39A+Jqcg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kp0yrsvd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 22:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBGA5mKiy6fLouXKoLywKVVwNlYHyfiUAnJtic1RVOzWukEEAYEr4FfZQmNYKBny5UQg72keUYugE7ubTLK2aKU84lUwVTiLCzoaztsYn8/MfjpYuIIU918ZqGmu3CIB7NDAnBmo9cEZA4wEgNmdHGzoe+HDzKX+ALuEBc5WiVq4S1sSXtMPmC13iVNeRwfTqYjbdfwgGScNSS5SOAB0ynBj4MuFMQSndHf6pKeuCaAL/94hE8APs3XVEbRm900LLLwXFZdjSyvzZzl3QT/2k9yYP5toFvuFtSnXqISfzw7QCFw7Z4N4ySeFoVKaGNJI8MXOgJsAn0bH2GlT0qxxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz5OwlIQmXGAflgkgRPp0gnNHg1mezidnxMSiq2wczw=;
 b=lNaYGj96vWRvfrkInJQzITfJetuhgn9DeIKQFYFMT2/TmLWnlpcMXiqErCFosK0ZqD4bA8uvmVY+gdr2RphoVSsktOE6gIqG9B3OcbdB2J6hN7NvH9oKokqUGd8yD2naif/0y+gaUDoSDWD3i3ZI7fs7ztb75rcOxg9xjsIeZfG4TjUqy8Mf9luGL60nA0B8/yfxgT9bHvlDBHtrK6EseepWFCsYrNHfHGRuisR/SpyyhwbKgh+ql0orE4a1jFYIgbSFCjkPD3//DQEvifJPjcKcYKl4418dWUDO92fHAXSGjyT+bS2SawHGop0fWXiMYdgytesJS1dXiodeBNYEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB4826.namprd15.prod.outlook.com (2603:10b6:303:fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 06:41:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 06:41:54 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>
CC: Paul Moore <paul@paul-moore.com>,
        Casey Schaufler
	<casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index:
 AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAIjYCAAAEqgIAADAaAgAAIRACAAASoAIAAd70A
Date: Wed, 18 Dec 2024 06:41:54 +0000
Message-ID: <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
 <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
 <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
In-Reply-To: <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO1PR15MB4826:EE_
x-ms-office365-filtering-correlation-id: 723992ca-2d82-49ea-97d8-08dd1f2f0fc0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elA3dmphUHk0N2wyalJwVFNvbCs4b1RGcWxqMFFuU3hPNEl6VUlGL1JsQWxX?=
 =?utf-8?B?SnlHMWluQkN2WEFFc216Umk4bU8vTXBBYnVMWW5lRWpTaTJpMnd3TTN0Q1BN?=
 =?utf-8?B?YWtEK28wWTlKSjFQSDNNTHFBcDlHc3VJMlBtejkzU0ZaNmZYK1QzOFNoZVhs?=
 =?utf-8?B?V1RJcmlPNzA3YmRsVmxzTFZocGRPMGJXNW4yVWNBLzdsdFAvcmE0aVBjdWdo?=
 =?utf-8?B?UW8zL2FNV3lYMzdtaHBzMWFVY1RvTHFQTjBSRXI0N2NSMWR6R3daeVhySzhY?=
 =?utf-8?B?aHl0d2ZXYVBLQlBTeHQzQ1Z3bkt4VmpkQXFDM3RSSUs5VHFvZW9IdkJZdEdG?=
 =?utf-8?B?VERYaTFBVml0TXJLTmh3QXVIRk5DSVZNMWRvR0gyZVFNTlRNRGJWdFFHbVhR?=
 =?utf-8?B?cCthcVBCblV6KzZBdU5wN3lqQjZ6ZTRGK01QZHAyMXV2WkowUHFqUUVRVW1K?=
 =?utf-8?B?Z1EyaWJVcERhZWoxUEl2NkVZa3c3TVM5WmQ2bkp5ZU4ySCtOSUFiVUtoNUFt?=
 =?utf-8?B?RDFmVkVQSCtVVVBnTDdmR0txMlhJcE9LRXpnSDlMRjJnaXpFdEw4azJlUzl5?=
 =?utf-8?B?UmNVOHVCK25zQ0lpOVZUcmJYbWRGblkrNjBPb01Ed0JuUFlqejJMVzFXbUdD?=
 =?utf-8?B?SXptdklUSHpSdFNROWJpOStnQW9abm1kVENjbE1jWFg5MDZ3cXVCblY3SzFS?=
 =?utf-8?B?RTc2alFTWG9UZDdUTks3d0tGVUJoZ25ZSWpqUjI4SHFZTFZySmJOY0wvNjNP?=
 =?utf-8?B?eURveXh1UmhUclhHRitCYUNsNHJ3dm5LM3M4bnU1L0pSQjR4RVAwb3hUbkJX?=
 =?utf-8?B?cldoVVYyODlkR2piUlBNam4rdFVNN1NtWHV2ZlV6a3dLSjN4R0FkRVVoSUw1?=
 =?utf-8?B?dnNyd0Jsby8rNlNRZm5ybkNpMEl2YzJhaDVPUWl1T3hIaUxQRWc2K0FoVm1v?=
 =?utf-8?B?SndpbDgvbFhUcG9PNTFIVEdIS0lRUlJnWjgzSU92VXRBVk9Jc1ZRS21ERlph?=
 =?utf-8?B?OWEyRFRPbjFBM3RkcE9QM3ZjK05yeVlQWGhBaERhY0lHRTEwanpaemhTUEdJ?=
 =?utf-8?B?OEN6cVlMdEZCc3l5dmI5Y0RBT1d1elBtbVBmaHVUdXAyTDdYYkNiNjJySzRt?=
 =?utf-8?B?RXNYZ1R4aUdBNVNTRENwSmltb29XMXcvSWI1UDE5MFUzTzk3WFd6Y3dxY1R3?=
 =?utf-8?B?eFNkaFdlWEdvSDJkYUVVVTdlUWw3KzJFU1Y2NGdHbllTd2R2WlBZVUFlSFYy?=
 =?utf-8?B?QjBYcklxTkIxeEpNcFJwcGdsdFNqRko4T2RLanVLSWx4V1ZaNldvVWhVNG16?=
 =?utf-8?B?YmVQUzVxWjhOQXZaajI3WjB1QkoyUmFYVHp5L0dKcmxuaStPYkFDVWRDWE1X?=
 =?utf-8?B?R2NYMVJ3c2k0K2pFZGpzRjgwNXM3Y216NzdJVjV6ZVIwM1BFSFRRWW5aMXF2?=
 =?utf-8?B?bEx5L05WTk5aS1dVNDM3eldjZDNNeThqbkh2OTV6dzByNXJ2eTVIbU50SmN4?=
 =?utf-8?B?NGdWVmhWOWxWV3NyQXNpcXpVWXlGT3hUblYxb1VoMjFXdm5zUEpvUlEwUm42?=
 =?utf-8?B?dFZvZXErNEpYVGc5UXMrL0FHRU5yMWQvMERkSFMvcUJOKzhsZFJHdUk1czhk?=
 =?utf-8?B?UTVNM2tzVitBTU1aRzl5MWtXV0dXeEVmT3BocHNzZmwzVzF2NUdvODJWNlZM?=
 =?utf-8?B?aVg4aG9tSDZtMzBNQmNhS0dmaW1zVU4xc0J6SWZhUC80SE5BUXNyVzF5dGZk?=
 =?utf-8?B?KzVSdUlia0w1ejlmb1JaZUViakVCNWk4WGdCWjcrU2ZOQXlZb3BNbTVhTnlL?=
 =?utf-8?B?dzUxS0cwNG5aMXoyd0VsRCt2YWZYRk8rMlhKS2IrbnVBVnpWZEczeVBGaVNL?=
 =?utf-8?B?bTZVZW1ycUdZWDhrSFQ3eFhIZU5ZNUxHVTFuNi9ndVdPRjZRUmsveG9HYWFo?=
 =?utf-8?Q?72u5AL6nTwckW/c76I4Imal0QPDK5HGQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWZZRmFMVHdnaloySWgrZEdkM0FtbjFxYlpMZGpQUTlrbFFhVEN3eVJXbDNs?=
 =?utf-8?B?d214bEVSK3ZweW9jNDU0UUJ4OEl3U2dvUjd6bFVYM2lZVkE0NVRXSVNKMTNt?=
 =?utf-8?B?NWVUODBnckQ4UGpuUTZsWDh4YS9sbEk2MDZxcXdyMFgrSWhiWTh2SE5MMG1H?=
 =?utf-8?B?VWV4NlI3WUdOdmNrZE5HeW5ISkRpNnZ4NFhkUS9GUWl4QlIxM2ZkOXhmMmhk?=
 =?utf-8?B?bmJUSCs5R0xkeDZpbC9RMEVZT0NjUE5kNnRZR2hXYkc1U3lUN05SVzJKdnJl?=
 =?utf-8?B?OTA2UjlWRFF5aDRzSzlnQUJlRUd5bkJDSjYzczBYR1Z0NnZpRS9FMmd1ZmQx?=
 =?utf-8?B?Tmh2Y1EzY3JDQWk4V2pXMzl5ZXpjRFdCZy9kYm85V0dtc3NkQkl4Y0tJb1Na?=
 =?utf-8?B?SE5yR3JYTFhLb051S2ZHdTJKN1pRUndIaFpUR0M2VFM0anZYNHFoWXVwaHJt?=
 =?utf-8?B?eTZGajk2RjYrZEdaUUdSUldnT1BRYjhmQm9MUGVXekpDcWhPNzJoRURSODB5?=
 =?utf-8?B?dXZKUU1rMUkwSnQxOVhrMExOWTIzWEZ2QllIUitudGFHa2Zad1lMU2NHazU0?=
 =?utf-8?B?WEM0ZDNJLytXdGlrRlZndWhnbjVud0VuQ3RHYU1leWlZaHc1MVBIRGs3OFlt?=
 =?utf-8?B?NXVYZGdEMlJVY2h1Wk5taktMeGhyVG8vSWNhS2txMUJDZDNmazlwK2ZKdWxp?=
 =?utf-8?B?bU01U2QzdjI4NHZ3YW4zZEhIWEp4dmwwdUVkWDRwYkhpcTMwL0FIcWd2YUxJ?=
 =?utf-8?B?cUtoYS9nRTMwZXc1TnNZTDhYaWtkMmZkYnpJU3A0RnN1Z2RSR3BOZHVWQXo5?=
 =?utf-8?B?TkZpRnFGOFBpTW1JOU1MMlFPeTBZY1k0SXBuS2IyVFNpYitEQVFNZU41NFl5?=
 =?utf-8?B?TzI1Y3M0d2VYNDIvczBoYzFRbjY3aWNkc3R6bUhyRWRkQU5rc0cyZXF4VGYw?=
 =?utf-8?B?SmdhT2tlakVOTnB1ZFNYQ2o5d04vV2pVQXgzaXgwK0ZUTk1VY2M3OVY1U1Y3?=
 =?utf-8?B?YlQ4L2poa2pTbTRiNTFpN2JwN2tuUzBIODA4a2ZEL2dESmIrTUplK1htU2NP?=
 =?utf-8?B?eDJOaEdnQzZiTmMyR2k0TThHczk4MFhKQysvRkM1c05URmkwejFFZmhLZ3JD?=
 =?utf-8?B?QnhPTzRTa0ROR2YybFQ2L0tpcjZlc2UrRGFMWlp2MDF1dFM1RjhaR09Bb09q?=
 =?utf-8?B?V1BMRlg5OVFPcHpYUWwzdDI1QjkvdTdEdWwrR1A2ZUl5QU8rMWtYa0czQUVE?=
 =?utf-8?B?dURwTGo4VlRPNGtwRkd1RXQ0R1ZYM01QQTd1dlBYQS9YaS82cFdObVRNUDlq?=
 =?utf-8?B?ZmJsS2ZKOGtPUng1WEl2NDY1SW12VzVTRjhTaVQrM2RLU0FzNHNHeFdTaGMr?=
 =?utf-8?B?T1FpeDdKdlB4UDZqSHRzcHZWQUVWRHdZSTNId1BSTDVRZnJZcUpmeUYyakpC?=
 =?utf-8?B?dFZlYlF0SUtBdHYzbzF5a3RRcHJrcFVhRzZlTzdkbFFwMnZmRk9GTGRHZzhK?=
 =?utf-8?B?Mi9aRzJxbi9DVlcxRGVTb1FsVTFRSGtBY1FyV3JPL3hCdkRsbWZSdlIrOHRY?=
 =?utf-8?B?NDdZYXpJYnVtdXpxeUZTUEJjbkVaYlZIRnNlVFdaOFJwNGdCYm5wMXBrR0hR?=
 =?utf-8?B?Znc1dmhBK3FMR1Y4cEl2czFscFpVMUhNVU56dERqVkVRZnA3d2dlUTZZYndB?=
 =?utf-8?B?TDVmOTNjVFNXU1A2NFdEN0dEMm9DaXFZTGFEbzB0Ums5QzhuWnF3Y2syY2dV?=
 =?utf-8?B?QXhTeHZYcEVBK0o3L3FCWkRPa00wWnRRbGxyZWNmdEUrWWcrTWFEODR3WVNh?=
 =?utf-8?B?V2tNRURrR0ZzQzJPenFZRjdUVEtLT2hqNGc5NFNKQ2hYbExpSEo3MHhGSXdo?=
 =?utf-8?B?RzdyNTB6WFk5S1hnODkvbmVNSzJkd1NpY0R3MDIxK2ZpYm9aK3BnS2ZoaTBL?=
 =?utf-8?B?SG42Ly8yVTlvdm0rVmY2R1hSRjE3RUkySjlDYTRESWlzTDB2djNZYjNNSnRx?=
 =?utf-8?B?Ni93YzlJTlVkRlU0UzR2TVBNcmZ1TTVZUGdpL29jM1gvYjlBWHFwRkNzOFZ0?=
 =?utf-8?B?OUpzMTdnVmMvRlBzMkhBUi9PazVFRDlxNEpvTmFZb3RiMEl2M0s5YU13S1Jp?=
 =?utf-8?B?OTloZk1Jald1RTByQWg3S0U5RUltWkZiaXBKZEh2Z1JIZGdJdVhoN0ZSckxC?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1688781BE935174D9EAC57FB475A4924@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723992ca-2d82-49ea-97d8-08dd1f2f0fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 06:41:54.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+yz06s1YHtxZLQHtaM06gPVBgZzeDd5VT3VsucE/oM+IRa24JlVbAucneM1CvlUUNOdXGyqsuelcVLrLFfVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4826
X-Proofpoint-GUID: qONs07QpWCaKlLZwmQmHL8_HWZ24VWVh
X-Proofpoint-ORIG-GUID: qONs07QpWCaKlLZwmQmHL8_HWZ24VWVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQo+IE9uIERlYyAxNywgMjAyNCwgYXQgMzozM+KAr1BNLCBTb25nIExpdSA8c29uZ2xpdWJyYXZp
bmdAbWV0YS5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+IA0KPj4+ICsNCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmb3VuZCA9IHRydWU7DQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgIH0NCj4+PiAgICAgICAgICAgICAgIH0NCj4+PiBAQCAtMzg2LDcgKzM4OSw3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBvcmRlcmVkX2xzbV9wYXJzZShjb25zdCBjaGFyICpvcmRlciwgY29uc3Qg
Y2hhciAqb3JpZ2luKQ0KPj4+IA0KPj4+ICAgICAgIC8qIExTTV9PUkRFUl9MQVNUIGlzIGFsd2F5
cyBsYXN0LiAqLw0KPj4+ICAgICAgIGZvciAobHNtID0gX19zdGFydF9sc21faW5mbzsgbHNtIDwg
X19lbmRfbHNtX2luZm87IGxzbSsrKSB7DQo+Pj4gLSAgICAgICAgICAgICAgIGlmIChsc20tPm9y
ZGVyID09IExTTV9PUkRFUl9MQVNUKQ0KPj4+ICsgICAgICAgICAgICAgICBpZiAobHNtLT5vcmRl
ciA9PSBMU01fT1JERVJfTEFTVCAmJiBpc19lbmFibGVkKGxzbSkpDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgIGFwcGVuZF9vcmRlcmVkX2xzbShsc20sICIgICBsYXN0Iik7DQo+IA0KPiBCZWZv
cmUgdGhpcyBjaGFuZ2UsIGxzbSB3aXRoIG9yZGVyPT1MU01fT1JERVJfTEFTVCBpcyBhbHdheXMg
Y29uc2lkZXJlZA0KPiBlbmFibGVkLCB3aGljaCBpcyBhIGJ1ZyAoaWYgSSB1bmRlcnN0YW5kIHlv
dSBhbmQgQ2FzZXkgY29ycmVjdGx5KS4NCg0KQWNjb3JkaW5nIHRvIGNvbW1pdCA0Mjk5NGVlM2Nk
NzI5OGIyNzY5OGRhYTY4NDhlZDcxNjhlNzJkMDU2LCBMU01zIHdpdGggDQpvcmRlciBMU01fT1JE
RVJfTEFTVCBpcyBleHBlY3RlZCB0byBiZSBhbHdheXMgZW5hYmxlZDoNCg0KIlNpbWlsYXJseSB0
byBMU01fT1JERVJfRklSU1QsIExTTXMgd2l0aCBMU01fT1JERVJfTEFTVCBhcmUgYWx3YXlzIGVu
YWJsZWQNCmFuZCBwdXQgYXQgdGhlIGVuZCBvZiB0aGUgTFNNIGxpc3QsIGlmIHNlbGVjdGVkIGlu
IHRoZSBrZXJuZWwNCmNvbmZpZ3VyYXRpb24uICINCg0KUm9iZXJ0bywgaXQgZmVlbHMgd2VpcmQg
dG8gaGF2ZSB0d28gImxhc3QgYW5kIGFsd2F5cyBvbiIgTFNNcyAoaW1hIGFuZCBldm0pDQpJIGd1
ZXNzIHRoaXMgaXMgbm90IHRoZSBleHBlY3RlZCBiZWhhdmlvcj8gQXQgbGVhc3QsIGl0IGFwcGVh
cnMgdG8gYmUgYQ0Kc3VycHJpc2UgZm9yIFBhdWwgYW5kIENhc2V5LiANCg0KSSB3aWxsIHNlbmQg
cGF0Y2ggdGhhdCBhbGxvdyBlbmFibGUvZGlzYWJsZSBpbWEgYW5kIGV2bSB3aXRoIGxzbT0gY21k
bGluZS4NCldlIGNhbiBmdXJ0aGVyIGRpc2N1c3MgdGhlIHRvcGljIHdpdGggdGhlIHBhdGNoLiAN
Cg0KVGhhbmtzLA0KU29uZw0KDQoNCg==

