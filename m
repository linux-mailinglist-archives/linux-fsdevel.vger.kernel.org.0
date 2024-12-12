Return-Path: <linux-fsdevel+bounces-37217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB979EFA41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923B316C24E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6552236FC;
	Thu, 12 Dec 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ILEmgFrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B40208992;
	Thu, 12 Dec 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026511; cv=fail; b=mBJowkkWpJcPwz4D4NfKNp2jntyMGYublCms7721YP50zEVf93wZvFmsWR6BiTad+IJHljedAUqeZ0HXWtJVS9GegLnoS6ywQRBsTcmlvVsKN+v85F6Uo2VmbZ3f/R3syARxaGFdi/fZZtg2eARVKWtaOEvGWoMuSj4V4tdKEDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026511; c=relaxed/simple;
	bh=n8TUxcvpf1gfSKfxEuXI7dTLNYNMlbiJHO4CIbneTHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=G7bdl33mzi3Fe32UEkJzQGpociHcOo6dWdvMFbFsmvnZ4AhkvR3oY4mLwKwDDSmro4VLY9Q6jPlapeBIfYXKjbolPbezmXDRkDfA/gCc2IrpmXsk5lK7PEtHPVvdFRqIKUx369x+8PHbYpKev+qhyoDahnzgIg+NkJd6GvF7Qqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ILEmgFrs; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDKZKX004641;
	Thu, 12 Dec 2024 10:01:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=YJtUUit8zqmoDGLk2uZctSYweqOGB02tON+sxcLIoqk=; b=
	ILEmgFrsSKVlQFt3CfSmYBJU69aSbkmndpqJLqlltyx/Vhno4Fop+HZvzyum7/bm
	86TH8KI8VywYy5Jf9YMkICKcsV1gN9VQou/fs3gvU/Luqvys02K5iKP00MATGs+H
	Y6RXBXnPh+5lJuaLlwt+uLdelckSJx7xxMejyXdNlI1R7CbO1/uvSKaUSneTu2yQ
	ByUnjZzkOUr1Cdvxr4IwuFFnCn7d1/cktJYwxWsvR3FHBx9jKKjP6oWYZW/sETRw
	gZBjATgYjOR9TZO6lpFYfaEr1y9CDUZ1B70yK5l4m380InKQNXdIJqESNibxUh6X
	gBOYMNAVuKRuMZYkQbIGJw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43g0j0a792-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nADQRK5cNtO3sYbQgDXkIbnS+SdZe41zQnuCIPMX9ahlSR7DsmkmB4cD26k0v6PEzSiNmMp4vccZhGox+f7cDrzGI7fHyhow/Z3YZAORF470BqZ2YRIa6bXxUrvX/JLNVqE7kgOg/eDmIZwQenBk54EaS8lW6dUh0XHpzalYzgd1kV5o53GOriAsNm9M6voj2/Fy3YUXB45z/FWO98yzGYOxjSPuxiUdCeWylUdlc2LuJA2GXFP1b0KS6zcLIOC4aWKpY8KHmsGFydIRTBf78jSJQA/E5fVzKgEqD6DFcN43Yvd67NCGRhH0EtzxxkdOmOxIZY8wTRKyYrDsgW4YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjWS7AmLulfV1um8wBuiilvm+BuiQ1aoO401SDh28CI=;
 b=OGeaJ08QQyjWRZWJJxXruhfZhD6kYy0OY+uOIrdgIWxg7CsolrKrkTUlZAk9+RAEDHTerCSNsykogcgrMu2MgV5ZeKqRl5/TgcH2q2K9SNULQKlkVofVAmbtnQzLGFDPAUDpTi2T6IBSJWIaYsEpgwyimYtzXSk5IgtzScpP3+OSapfFoWite8XPE/DZw2PvZsFf6otuE4tVRUvyqH1/mA9zK3hbQUk6nxQXuwPaWqOoDGknFsXmd2cjLEoIujtt40wIxH6m8d2oytY4hbyJFjMAOHR5qKte6vGRwzHb6htxGeObTlIMoDvNIYnMq3HRzrs6uxQn5rMLuSb7ojwUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB5994.namprd15.prod.outlook.com (2603:10b6:8:18c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 18:01:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 18:01:43 +0000
From: Song Liu <songliubraving@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "kpsingh@kernel.org"
	<kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart <liamwisehart@meta.com>,
        Shankaran Gnanashanmugam
	<shankaran@meta.com>
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v3 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbS0/nWK/c8SbToUKzvecS3uPKVbLiaX6AgAB/ogA=
Date: Thu, 12 Dec 2024 18:01:43 +0000
Message-ID: <13A24FFA-F761-41E3-B810-D3F7BA8E2985@fb.com>
References: <20241210220627.2800362-1-song@kernel.org>
 <20241210220627.2800362-5-song@kernel.org>
 <20241212102443.umqdrvthsi6r4ioy@quack3>
In-Reply-To: <20241212102443.umqdrvthsi6r4ioy@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB5994:EE_
x-ms-office365-filtering-correlation-id: 85588fad-106b-4586-cc89-08dd1ad70977
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enFYZ1k1VW11bDBQb1B1eEI0UytGYWhlTU5zSjlUWlZId0pFVUhqZjJYblBm?=
 =?utf-8?B?V01lNGcxQWhFenhPNE9aQWJCRGpKMFU4V1ZlaFZlTmVxU09NeXErRjVYMnRI?=
 =?utf-8?B?MUJqcVRCelMwZmlQQjd3UzB6T0VhQzg0MjVpWnlzYW04QnI2K2N3RHVQcGZ2?=
 =?utf-8?B?a1liMDVMOFJLdXhvNk5aN1pnVFk5NGF2QVNqbVVqSUVScTVldzdjR2lvck9I?=
 =?utf-8?B?ZVB5dEJtR2Uyd010eGEzcVZ4WUp1cHV2dGlKYmMvaXJyQ1FmZForQUhmaUxa?=
 =?utf-8?B?bE9sVVFrU2F5ZjlteWpzQXcxQnJwcFFNTHNGRmpST24wTG5CNTRSbmgzRk9L?=
 =?utf-8?B?QnZjaHpZeWNEU0FQYVY4eFpXOXl0bXpaOWJXWUdVTzRoeDNzYWVwbSt2Vi9B?=
 =?utf-8?B?WEZXWW51NFJJVlR6dVRrcWNqdGpFcmdxMGZsZFZFZDlwS3lickFFd0p5S1F4?=
 =?utf-8?B?cEpTYTF4VFZyaXNYRmlRR0EvZS9vaHF4ZFR1QlZDa2VCYzR3eldYaURsRWJJ?=
 =?utf-8?B?Y0xuYjN6VlhOWnlBcDhOdHZ5OW02cWhHQ0t3a1dKbTJhcnBRdGNSS2p6R2ZH?=
 =?utf-8?B?N3RRcm85VVZUYU1ETTRoMHNHREJKcFVXM0hIQkRiWEVnVHIwdU03Rk43bmlz?=
 =?utf-8?B?NUtBcVRQYVN4a3hIZmVVVlBqZ3dtK3JmSCs0S0x3Rm40MXJ3czZEK0R1dXBH?=
 =?utf-8?B?TWFaYWNGYyt3MGQwUUkvV0R3cDFGQlVlMWZOUFJkK2ZNMlE4WUVLdk4rSDIz?=
 =?utf-8?B?UjdWM0VqMDVYTzNvOHl0dHIreEFiUzI1NWtyWDdSb1Q0UHdmTkJKS09Qd0FQ?=
 =?utf-8?B?TUtMeXVwYk9TdmFZWlo2MDJ2ZHU2RGdCL2lHOU9PSHVDZFVRcW5DK0c4WTFT?=
 =?utf-8?B?Ukk4OVJ5NFo3dEJqam5nVXhRcTFIcWsxVzdaNk1lTHZMd05TUjh5V0dIZVhX?=
 =?utf-8?B?c1labGt3dmFrU2o5a1QydFM3QVJCOU00M1BnNkJQN01NeXUwcW9qUUJmQ1F4?=
 =?utf-8?B?a0luTjFOQU44bENCdk9PWTM0YVVMYm9PRTBKd2wzc2MrdHZ2N1BVOWVNbjFF?=
 =?utf-8?B?dlgzNmFnM2NLOGZ0T3MvK0M5RUdVNUpzd1BTQStmQlM3dCtvdkc2TThjdC9I?=
 =?utf-8?B?WGZNZm5qOVNIUWszTTV0TVVhR3J4SXVBLzNjaDJiVkJEeUtTbnVWa2pLS0Uv?=
 =?utf-8?B?N2p3WFJjdUxyWHJyb1NNL244VTU5RSt2YTRpUzdKZUxZbDVCMzNJcy9tblBm?=
 =?utf-8?B?VEwrQlJmd2EyZ2Q4S3loTkJqQWxZSXc4Q0FHaDZyeVl4WjFOa3JsUDlXcVJz?=
 =?utf-8?B?OEhkaGZwRVI2QlRJR0RvL0RJSnRNQ1AzRlROZFEyVGN1WlRqTTQvSUpYR01s?=
 =?utf-8?B?MkRZN0JZUnlrQ093dWJPNVBwbUlVamVwTXowcXQ1dVRSc05FVG02eUo5Nko2?=
 =?utf-8?B?Mkw4aGhHeExzKzZOWmgvSTZXcm4ySmFvbGx2QVZOYloweTBPN3ZYc3dLZGVX?=
 =?utf-8?B?b3R2OXlVbDZobGRtM3liek13dXBtdDUrbkxXQnBEWGZkSFJBYzN6Qmk3cFZw?=
 =?utf-8?B?d2t1VkI4ZWR4cTdySkJvQ25JdENFUS9kY0cvSVR3ZE1ubFhNV2dtdFBnK3JU?=
 =?utf-8?B?WndBc0F3SEVMZ2FGSGFDMEdDckk5Q2RYOHFoNk9qck5jdVh0a29iRGNnQXUy?=
 =?utf-8?B?cFh1bnV4Qkt5OFRucVhwdjE5d1VHNW04ZVZTZ2tWVHBUUVpRSjRIaEFsZ3lN?=
 =?utf-8?B?c1NhaFBVWERlb3lkdWR2ZkU1S3lpdXBkNzkvYWVxTkw4K1pzT1ltbTJGQWwr?=
 =?utf-8?B?ZWQzYnl5aFh2NHArUmtRbFBjYzFEZzEwR0NLOG9tdDJ2blcwdHpaYmxRMjY5?=
 =?utf-8?B?NTdmNDU2L3lyaUowc2dUSFREclZYZWJMdTZYdFBGUEVqdkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0V4NCtuempMWmw4bE8reGJodUdrdWdZbk5Lbit5RkRxZ2UwY3puamh5WUNY?=
 =?utf-8?B?SngvcGdmZUFyM04wMzcvNFk1UWtLSTc3V0plQUh3VjFMUi9PWVBId0lmZWxl?=
 =?utf-8?B?b0pwZHdLS3BEMXowcit5RkkvdG5oczgvV25YR25XY1lFeENZUGZhK3BOVlNP?=
 =?utf-8?B?V0FNRkE5eGpmb3pCbVpZZU1JYmpZVzIzWi9Tc2h1UVlTbG5BVmRVM1ZrQ0V3?=
 =?utf-8?B?TVRJaG1XZFg4U1dueVhQcitvNG5vSEM4TTBXamUya1JhTjZwZlg3RzhEb2Y5?=
 =?utf-8?B?Ny9TTFg3bDJsL2RUbkY4RWc4dVFVNHVMT2JqZU5QVWU5NjBBbFpqMER3cktQ?=
 =?utf-8?B?RnFZTENLa3NFQmNkQzFvWWROeno3c3JvNEFBdGNuUktGdkNaNi9qTDRBSVJN?=
 =?utf-8?B?YjQwZkx5ejBLMUFKRjhwNHE3aEsyMndhRlBLUHQ5N1Nac1dGYnBhZ04yeWtp?=
 =?utf-8?B?NHpFdFJrNlBUSnE0Qkx3NzJGb09GUW5HVW5EYU1PajA2eFoydUVmdnpoM1dl?=
 =?utf-8?B?QWpUZEhIRkNqSm9HZ0RsWXRzUzFiY1pnb3pmNmZDRlYxVmdJZjlwTVlvVnhG?=
 =?utf-8?B?NkZMR2gyUENFb3p5SmNYNWdmR2J0L2tRQUNUaUpKbWpIUE54Y3o1SVlYSnQ0?=
 =?utf-8?B?ZUx6MEhxUGIwV0RNcVhRcCtFaDBmcDNsS0QrOWhZbDBYYzQ4aG54Ukd0c2U2?=
 =?utf-8?B?Q3lJMzhpNjlzY2dJU1FFUmZQeldNOXowK1d4OS9Zbmc3MG1OVnB2a1hNbnlp?=
 =?utf-8?B?eEFFR1lUWjdtM1FzbUFEWkN6UmVUTXJFNjBuOEkza3NQcytUVThwdGR1RjE1?=
 =?utf-8?B?N1o0VStuZXJialAwUTN3TUVhSW9qVXkzSjM5cnNWaTFNUW5QWHpFQnhBRHg0?=
 =?utf-8?B?Q2FIc3B4N3FPd3ZLMHFDYUovRXBlUXo3TTFndkNKTzdyZ0oxT1k4dHFQOEFW?=
 =?utf-8?B?cmhDMUt4VGU1eW9ZSE1JRnA3NFJKZldNL01iNnFyay93bDdQcGFsSnI5dk9x?=
 =?utf-8?B?WVloMk1PTEppZTV6QVNTU1BLZmxFNXJ6UTRQY1RHQnRhYkEwUzlibkRQUDFk?=
 =?utf-8?B?b3ZVZ0d6YWNyY1JxZGN4VFUwMThVRzFBWTdlVU9Xb3RydHk0cVFKQkhQZTJi?=
 =?utf-8?B?QXkrdXo3blhQZldJcVdaUkdlZlM5ZzM4b3VXRFlZMFJRVDRpQ0grMXgvdC91?=
 =?utf-8?B?QUtVNmFHNHN0T0Q2VHNxeEZBdTlhRzFHQ3ZmVjNhVllsNk5mYUs0cGJBZHUy?=
 =?utf-8?B?ZHgrY1ZNZjBVVnU5aVcyVUpKVkxab1ExZFNjTGNBMTB5Rmsya0EvNkFaUmdw?=
 =?utf-8?B?ZUtSYzdvSzJjYlRMa05FN1BOZ3gxZ0U3MFIzOU5VUnNUMncrdGkvb1JSZnlD?=
 =?utf-8?B?eGtkbjNOQThBRUJjS1cwNUp0eHo1c0h6Z1pNYVRKOTFlMXp5Z1dRMzl5QUUz?=
 =?utf-8?B?bklEZnZVdG5XcWJjUDZBRW0yenU3ZVk2MUUySjdwYmZwdGlVci9ISWtEQ29B?=
 =?utf-8?B?bDBjazdtMDIvcDhNY01pcFE4VjJLWFFqRG50cVBsb2pDTEVNUTNmRmxQVTlF?=
 =?utf-8?B?U0pBWkI5bWFLaDNrYTVibVRuKzJVM09EclcrT1Zya0RreENjVXpjS1lHVzJM?=
 =?utf-8?B?YWpaSFBSOTA3T1BGSXVqWksyZk00S3Z6dDR5eTRtQzE2ellhQkJvb21XQVZH?=
 =?utf-8?B?ZVloSFVYMENGN2ZVb2l6TXcweU1kcnJtR2tnQy9Za3FsWDUxZmdNQkVzQzlC?=
 =?utf-8?B?USt0R3crSFZjWS9yZ2dJL3IrTjFCenJiazVCeDB1YTZnM094bGZNcnRTVmlK?=
 =?utf-8?B?alArbm5lUDZQN0ZSSUs4UU9kbnJKVHV5SnFzWFFVUmJhaUhmbjhYUy8vbDRU?=
 =?utf-8?B?NzNYMjc2ekx2Vnpsa1NCdk9QRFFic2g4dHAycW94TVpEOE5QZlpOWitwOWF6?=
 =?utf-8?B?SUxBREt4QUQ5NGtianRhR0Z3ZEZhd0NnZDliVEVJYlh6bEJCQlJBMVl6TU9Y?=
 =?utf-8?B?Q0RObTRjc0g0S0dhTXhPK3hIaDY4Y2hySGt4a2tnNEJldnh0am04T3NKT0hJ?=
 =?utf-8?B?NEtqS1V4a0ZJYjN3bDF2TEVIdE9GN1gvelV5Z3BGaCtYS0dIQ3ZsTWtVQWU5?=
 =?utf-8?B?OTNEMXo3eXVTaFJIQnE5OHNiRU1EVG1ZcGdaZjVmdXU2eGtKTVdrS1h5Uktt?=
 =?utf-8?Q?4weCE/AIUZieixZKDD0zjjA=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85588fad-106b-4586-cc89-08dd1ad70977
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 18:01:43.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYlynQ9ZAeLH3IxGJvSubFsxbmW9HueA+PWvqsLEZcwuenv8tvSUIpyY97ZV+P9PbVSKoJ9op1UQSduoXHCZsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5994
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <A92C57CAC34EE04E8D18B3A4D8EAAC21@namprd15.prod.outlook.com>
X-Proofpoint-GUID: TcdufyGd1V6ZQG0Ga1m3pYrcWjOr_jyw
X-Proofpoint-ORIG-GUID: TcdufyGd1V6ZQG0Ga1m3pYrcWjOr_jyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Hi Jan,

Thanks for your review!

> On Dec 12, 2024, at 2:24=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
>=20
> >=20
> On Tue 10-12-24 14:06:25, Song Liu wrote:
>> Add the following kfuncs to set and remove xattrs from BPF programs:

[...]

>> + return -EPERM;
>> +
>> + return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
>> +}
>> +
>> +static int __bpf_set_dentry_xattr(struct dentry *dentry, const char *na=
me,
>> +  const struct bpf_dynptr *value_p, int flags, bool lock_inode)
>> +{
>> + struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)value_=
p;
>> + struct inode *inode =3D d_inode(dentry);
>> + const void *value;
>> + u32 value_len;
>> + int ret;
>> +
>> + ret =3D bpf_xattr_write_permission(name, inode);
>> + if (ret)
>> + return ret;
>=20
> The permission checking should already happen under inode lock. Otherwise
> you'll have TTCTTU races.

Great catch! I will fix this in the next version.=20

>=20
>> +
>> + value_len =3D __bpf_dynptr_size(value_ptr);
>> + value =3D __bpf_dynptr_data(value_ptr, value_len);
>> + if (!value)
>> + return -EINVAL;
>> +
>> + if (lock_inode)
>> + inode_lock(inode);
>> + ret =3D __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name,
>> +     value, value_len, flags);
>> + if (!ret) {
>> + fsnotify_xattr(dentry);
>=20
> Do we really want to generate fsnotify event for this? I expect
> security.bpf is an internal bookkeeping of a BPF security module and
> generating fsnotify event for it seems a bit like generating it for
> filesystem metadata modifications. On the other hand as I'm checking IMA
> generates fsnotify events when modifying its xattrs as well. So probably
> this fine. OK.

Both SELinux and smack generate fsnotify events when setting xattrs:
[selinux|smack]_inode_setsecctx() -> __vfs_setxattr_locked(). So I
add the same logic here.=20

>=20
> ...
>=20
>> +static int __bpf_remove_dentry_xattr(struct dentry *dentry, const char =
*name__str,
>> +     bool lock_inode)
>> +{
>> + struct inode *inode =3D d_inode(dentry);
>> + int ret;
>> +
>> + ret =3D bpf_xattr_write_permission(name__str, inode);
>> + if (ret)
>> + return ret;
>> +
>> + if (lock_inode)
> + inode_lock(inode);
>=20
> The same comment WRT inode lock as above.
>=20
>> + ret =3D __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
>> + if (!ret) {
>> + fsnotify_xattr(dentry);
>> +

Thanks again,=20
Song


