Return-Path: <linux-fsdevel+bounces-35391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C89D48CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FB6282C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAD1CB9E9;
	Thu, 21 Nov 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NKQ4G60C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB91CB303;
	Thu, 21 Nov 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177695; cv=fail; b=CxrA75CZlvsKKNbRxXpYHWR6z7RwuiDbR0IrvZy7n5qTAtMfC4DmeIZu7Otc+Biqetl/UzN146vOurjof0Sitb8F9TWNnhFJAjZ0Hpww6nqc9RNw7Xz6+hWGdtnzWFuv+RZvXPdoPBvK/Est+yihGQYU0iZlamJJrhjsLhAfd2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177695; c=relaxed/simple;
	bh=73sgeAMDIIjYgWLBrXk3Gk0f76I06/m8GOYdZSA5Zis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DaoFvHnIhW19/omMGAlTBGHpJ4BFsI1LcuscAH02s4Xn8nMiHn7jCtVZvJuGgvI8lYHF26uNr8v2TOrHF/iEkqJpnU68XC8NAhgKzardaOwcVrfA3v9BpxASskzo8Q0yMrydLPJ9Zxu1SFxvg9HHCyyM5Km/HFawHwDUHWqu7Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NKQ4G60C; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL43buN030017;
	Thu, 21 Nov 2024 00:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=73sgeAMDIIjYgWLBrXk3Gk0f76I06/m8GOYdZSA5Zis=; b=
	NKQ4G60CDk4tE+NBpLop4u3t5yPLp6B4+twSg/zG8l2Vg+NNRCXDU1dwqH9I/M5F
	NZFofztlSR2+3OvzHiMHWf6nuSov87nEFlruOvrp7gvjLQxnS5fUdyFYMGdmn1BP
	cyfp9QVif7vYLwwawcCH+VjSNLE7zEx1myGfuP1rmFKoB49q3ztbQWLDZGBP01dN
	lDB2g05/vqpkFTqS0IxkWVWlpedeMlWyH08Qp278JN5blnx6iYeyqFnie6yMtlkN
	zHeyb52Gr6fmk51uyKYD5FhR2ZdXYGTl4te7VZxiFbyLAFanJlmwppfwkS/IpKSB
	tgORWRNg8pJYwadbFTmC4Q==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431vwnh4cu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 00:28:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXdjwZTg3PAFG82K59mYZhTtK7waRY9BtyzjUsT9zZvXn3RcKTcqGXRB6N5hJbMLBXpl1XNk3qg4+QaIhFxw7BU0YusFQc3dFJ3RG2cu6MJEpbycFP28e6/KcOELzWJBOLn+HI0Zj0mOoVVzjJzvBgLeQ8yP0PgJnS6pyzMVDYa1I48UJPzW3Ly8OmrdQ5evGCxaE0out8yoYCJt6gY7VKHFzExXuqeWKkFtnMWGH2jzZ00hI4WpBY8ljAisQAZ9obigkR66dtwVrBPh1rQ0eceDXrQ8stbrliej0XraIxoZ81pDMsVJ8z/Bk6BIjserCw/cY4mtUQyo0bMKlE2o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73sgeAMDIIjYgWLBrXk3Gk0f76I06/m8GOYdZSA5Zis=;
 b=SLD95sKpaGlRlYtS2gMwU7JsByNiepNni/FlZ7lcQ9WAuIQSwvqhlMZyTVswYeIvT2YhBYGXd/c//aTrV5CsGQIvpAn8g0Vb76ndLicMpXQZRI2cpx8K3SEBfivtb0bERcFrTDOclkX1wxVSdBsOMSjCT6zO9tdwpLTFLJ7aszK+eq4dnIrDuADiEXyRXGQHl2LhNN5gwmfI426RPZYCZdoz1r8Vz70zxumLGz5+a2+VpQJpcNpYegK3L5oOBYAP6UuYbmmkdlnyf5IOlGySfWD8e2frxtYYIA3KUZlEm1lvzsipQuJp0oZjjzg5N0EQC+f0BXknaEWKa7fWP2yirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by SJ2PR15MB5803.namprd15.prod.outlook.com (2603:10b6:a03:4af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 08:28:06 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 08:28:06 +0000
From: Song Liu <songliubraving@meta.com>
To: "Dr. Greg" <greg@enjellic.com>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        Song Liu
	<songliubraving@meta.com>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
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
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Thread-Topic: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
Thread-Index:
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgIAAPekAgATKdQCAAnQTAIAAYQ+AgAF79oCAAQTRgA==
Date: Thu, 21 Nov 2024 08:28:05 +0000
Message-ID: <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
References: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
In-Reply-To: <20241120165425.GA1723@wind.enjellic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|SJ2PR15MB5803:EE_
x-ms-office365-filtering-correlation-id: 06c010b2-fee9-485f-3ccf-08dd0a066c5b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkFnTm9GZS9YbmRpVjBOOWtKcEZTSnJQRkNTTlNrdiswaUpSOG5ORnpyV214?=
 =?utf-8?B?Vk94UjJyaE5xVi9EQ3dYYlZiRUV3cFNLdmNyUmg3U2RTMjJQR0QvdlEzVjZs?=
 =?utf-8?B?OHRxR0tQZlJ2K3JLYkFhb0FyazAxTVFLbXpBMWRDVnZ4Q2pZNTJpbjU0aHpL?=
 =?utf-8?B?eWdWZmFqaUFteWNld0ppN0dQbG1iNE0vVWRmOXAvcGI1QnlZVnRyYytSbjRG?=
 =?utf-8?B?ZW10WEduOHJEWGZRL2VBbTlSVHcrRUdNODFKa3Z5QmhMMmVIUmtFU2hLSytK?=
 =?utf-8?B?a25sQ1Y3bUxkMXl5SWc0ZTE2OTNGeFVOMFpMVHdmWUtQR2tFUkdEYm90Q0cy?=
 =?utf-8?B?WkxZQWRUNzFiLzNoNjFNZGxQWmQrQ0R5UmtnbDZSU0Mrb1Y1a0srQ0h4T2JS?=
 =?utf-8?B?L1dOOEtZSmtpRVFuUUovd3JQN0FHV3I2WmFyUnkzR2VjODl0dzBpNmVRWGpp?=
 =?utf-8?B?amVwWFIzMWRzUlNaQlRPQUtrckVtMk0waHEzaFQwNnRRdXZ5dXRWNlZrNS93?=
 =?utf-8?B?VXJTWlZIR0NlQTBXMEZWdjh5ZE5BcXhhNTBkV05OTTNxWG9XQzh3eWtRaWtX?=
 =?utf-8?B?Z0VHTE9oTUdZQ3kyS0xlcGQ2YmoxTFVyUzFMMFhXYjk3RnA3RndvSk5CdERy?=
 =?utf-8?B?N1pyMnlxZE9HSXRUTHpMaExoV3B3MEF0ZTJXM0hnTHhHYlBoOFpyK3JmaXhO?=
 =?utf-8?B?V0hWZTgzUGdlN1NKbWRCQ3JOdTdXak54a0FBMWRBTXBNK0NvSitGZmVDME9k?=
 =?utf-8?B?OWRWakZodWVHQUV1d1VQWkhPMm1CTmlyMEFUd05DOWs4WGVLOGtMK1VxNFFo?=
 =?utf-8?B?Tk14TWZ5SkF1OG4wUUtDWXhEalk5azAwbHNXSHJDaGxhVXJwekZzVVdvRklM?=
 =?utf-8?B?MVpXdUJwa3g1b2MyQUxOczA0K2orRERlU1UzK2NYNG9idzZOT1FNWnF5czN3?=
 =?utf-8?B?ZzBYQVlqSXBZTVpXb0xyU2UxdmVQS1VzVkF4Z3hNL2lWb2RvM2FyTll0MGV5?=
 =?utf-8?B?cENpNnQ4WUR5SEx6ZVNVN2d0UCtpd1hKQlBtbTFYS3FuTndySmdPVEtoMXpE?=
 =?utf-8?B?V1VWMVF4US94ZCtibmFRY2xDcDkrQUw3cDdlWDVDWGgxem1lUkQ0ZmMzNWpy?=
 =?utf-8?B?bDVIUUJCRG1MZXRYY2RkWDVHVXprZHFUV3BVQlZiTzlXN1dSYmFEMFhiL3Nr?=
 =?utf-8?B?VjFvcTNwSEVSZFlsQ2NSRVZXZlNiaVpUMjB4aGNXMUNDYk92ZGpvdWE1ZEcw?=
 =?utf-8?B?d0liZVdYSUZDRXJhTEJERGtDZHppb05za1RicDI5TmVDQTkwa0lmVzQxYVhC?=
 =?utf-8?B?Q1BVSlJsdzUyN2J4TlN5TGx4MkR2OGxYZzBINkEwSnQyekE1RGx6RFlhVzNF?=
 =?utf-8?B?azFyaEdsOHcrTEl0Yld0azdxOWhzNVRhNlZabTIveTIzWmZYSlNCV3pvRVlB?=
 =?utf-8?B?MDVEdzVGdndkaTQwUW9LOGxhRDRLangwWGc2TE1BWjI1bXJ6QkR1RHZiYU9V?=
 =?utf-8?B?SlJRT2ZzUCtMRmpVRmtUUDV4SVFPU2cydXQrdHBZbWpDL2plK1IraFB6Undo?=
 =?utf-8?B?eGxHeHp5L21sZm1CUHk5NzZaU2ptUUxVWU53YUFvNVVmS3ZXamVab01lVEM0?=
 =?utf-8?B?N0dzejhLUWpHNHdldzY3U3J4WUNqQ2FvZVdoclZ2U25jV2E0Y2NIYjIvZDlD?=
 =?utf-8?B?aXlHR0kwWUptak83T2JVQ0Juemt5aXlVZmJpNis4SG9qVW00SUdkKzNPNUlM?=
 =?utf-8?Q?Fxr3zzXh6dQHrXdcGlWgF1ug1lgFKxTySkvmkDa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmNDTGNpTE9YVnNwR0FXTGxWeFllVHdJd1YwVEpmTXNGNEl4NElCNW05UVdZ?=
 =?utf-8?B?N3N2NmJBR2k0UElCd3l6WWdIWHJlWmFvaFRENjNNanFrU0FSQ0w0VzlRbldo?=
 =?utf-8?B?OW90N2FLWFZyTDZ4THRBWHdPMHFHMm91N2d3Q0JPT1dHdjI3aVAydUM5UmtW?=
 =?utf-8?B?UlgzMVkzZ0hTNnFiVFhkdDIyMTBFemZKeW9sSU5oUlB2WXJCNDNZMy80RDVa?=
 =?utf-8?B?WUU4MjRlM0l2ZWtJZ1lRTXdpOGpuMS9tQUZMaHRjdGZGaHZhUTNlekordnFN?=
 =?utf-8?B?YTB2S0NqZXFHYW81QmMvczlQWGEwRzAyVnV2b0lZZkwvRUdqQ2ptcWxLSHhy?=
 =?utf-8?B?L2Viai9QbG9PMzBHZU1SNmZOcHhRQ0RqRk05K2toY3hGa3BQMmo1VytDMy9q?=
 =?utf-8?B?cnQ3RzRpeWd0aDhHM1Bidkl1QU44MmtnTHBsYjhOQ0dxMHVYV2dKSWlnQUZF?=
 =?utf-8?B?ZnBHSW9XT0tpWUJ2OUtwV1d1TGp2Z2QwWmFXamo0TVF6WWlUUGxxbk1GL2Yr?=
 =?utf-8?B?OU1qQy9VODhMSVRDNjhSeGVWREMwVzBNQncwL2ZUTDlCVWtrVForUFVIc3FX?=
 =?utf-8?B?bXpmN0IwNlVNNndmOWRlNzVwanJ1ZDV1NmJ6YkZRQ1ZWOGczanhQVmlGWDIx?=
 =?utf-8?B?UkpRS3p0V3ZFKy9SdHp1eHQ0Q1pZelJybjFmTTZ2OEx3Zm9hUlRWUG42YUc1?=
 =?utf-8?B?VHAzWGZJUk9ZT2pOallqR3FianNqNVQ1SXUvT2RSTGtwYjJTTThkNnZPUUVv?=
 =?utf-8?B?T0UxL0FIMlFzaE4wK01VT1kzWlZxWVpzcWV2bDAvU3pzUFcvcTkxVThpcFAr?=
 =?utf-8?B?dGw0ejh2dzc0TVV4eUZEUXVvR0JZM2lsdC9xREtmeHh5bUsrck04NWZ5ckVF?=
 =?utf-8?B?ZHBOajVFYUU1em9IQTVhMnJ0VFI2TnJhbVhuTmpwcDRMdFBwZXpQSUtKaUF2?=
 =?utf-8?B?elZ0WUtSUmdwcE5ubFQzeGlHZ2xHcmxGaDIwdi9mUDhCZGdBck54NVJ4Y3Mw?=
 =?utf-8?B?WDk0ZnU0Z015VEVONkRNNnVuRitaK2IyZy8vWlB3bHhoMDVVaFRHYXI0RWh2?=
 =?utf-8?B?SHM3SXZjSkJWYjFsS0tUNzhnLzN3VzQ5WWRsVnVxWjhReFFNNzI3VDBhRG1F?=
 =?utf-8?B?VzVqcHpyL1ZwM3Q0K2pHaXlmenhLeEFCVUlDRlBzMEdjUXp4ZFNJUGlFMHJC?=
 =?utf-8?B?QzVrQWc2MmM2dkdoL1JSQ2dQRWNZblhpb3hvOC9FNnlOUTJ2ZnVzVjhLdXFI?=
 =?utf-8?B?UDh3VjgvVjRkRExwK1JoWHArWFFPV2djci9TNDh3dlhlTWJiU0xkN3ZaWGJB?=
 =?utf-8?B?b3psTlRBdk9pRE54UlBZclBxeVRhcm5PWGZmWlNVY09OQURnUm55M25CM0xm?=
 =?utf-8?B?MlRjbkxhaEJIbWVGaVJ1aXN1MEU5RDRxQlNLUnA0MU1mNUVmQ0hEZjFlTW01?=
 =?utf-8?B?M29XZFJyNDJLMkh6em9obU56dFNNQzBETll0NG5qSWx5WlRMR2lKYkZTcnlZ?=
 =?utf-8?B?U3JPaDdlTTdhYVA3WFAzTkRQM2N6MFBlUUxSTmNhZk9ZaDB2UnJRK3B5ZkNx?=
 =?utf-8?B?VGdVdzYrdFlVQmNFaUxYTkFRT1luS1hrZVlKRkhDN0pFZjBoN1VrR2JSNkV5?=
 =?utf-8?B?T3RtVWJjV0hmNExrV1VvUkt5MndyaWlIQXpGZFBYL3VHUTNDbXJyK1JRTE9C?=
 =?utf-8?B?ckpkTk9JZC82bTh0RUtDU1RqWU5hR0tBcGl2Zkd1M1RYRTZSenZsalFGMVJa?=
 =?utf-8?B?SFFra080S2RUcUZGUzIxRlRwd0NJWnBrNEtDWmxWYWJub2dMeVNIN2prWmp3?=
 =?utf-8?B?M2lKdWxhTnp1TXNKeW12bW40Ym4wSGk4dkNFbDZDeHZLOE16ZkdmY2htdjk5?=
 =?utf-8?B?bEc2TGhNdFBrOE1TaTNXZkxtOWFmQVMwMG5HcVdaajFGMHJWWjg1NkFPMmVr?=
 =?utf-8?B?b29pcVNqcFVCZXF5a1loWksrc0diTjFyeUZKbTNJQVMzR2pVM3M4cm0rczVT?=
 =?utf-8?B?NW0rRmlqVUdMdE5GcC8zY1h3WlVxVWM3MEQ1a2tBakhmSVM4WVk2UVlpTjh3?=
 =?utf-8?B?UDlLMVRRMnljZTdsQm9uTVR5N0dhUDZ5V2dPbVNCQnR5MVhFYXRCNGNxcGpV?=
 =?utf-8?B?UGo3bFRpVUFjd2h2clFhdDRQajI0RlJhQ21xQjlCbEVrU2IvaDd6SXJPTXlY?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BE8483F9CAEF141B0BBDB4A2B6F31C6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c010b2-fee9-485f-3ccf-08dd0a066c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 08:28:06.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eYHYIw1c6DdXJjNFP7Wqt/J3r4+9VU3mYhIm0ng3a0MvhKq/IOQDj6ojfUJNPC381B4ej1mNYg5ZWe8zX2Qrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5803
X-Proofpoint-ORIG-GUID: YHATjLyhzZyhfRj1DnbJaUNYVnMISHmp
X-Proofpoint-GUID: YHATjLyhzZyhfRj1DnbJaUNYVnMISHmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgRHIuIEdyZWcsDQoNClRoYW5rcyBmb3IgeW91ciBpbnB1dCENCg0KPiBPbiBOb3YgMjAsIDIw
MjQsIGF0IDg6NTTigK9BTSwgRHIuIEdyZWcgPGdyZWdAZW5qZWxsaWMuY29tPiB3cm90ZToNCj4g
DQo+IE9uIFR1ZSwgTm92IDE5LCAyMDI0IGF0IDEwOjE0OjI5QU0gLTA4MDAsIENhc2V5IFNjaGF1
ZmxlciB3cm90ZToNCg0KWy4uLl0NCg0KPiANCj4+PiAyLikgSW1wbGVtZW50IGtleS92YWx1ZSBt
YXBwaW5nIGZvciBpbm9kZSBzcGVjaWZpYyBzdG9yYWdlLg0KPj4+IA0KPj4+IFRoZSBrZXkgd291
bGQgYmUgYSBzdWItc3lzdGVtIHNwZWNpZmljIG51bWVyaWMgdmFsdWUgdGhhdCByZXR1cm5zIGEN
Cj4+PiBwb2ludGVyIHRoZSBzdWItc3lzdGVtIHVzZXMgdG8gbWFuYWdlIGl0cyBpbm9kZSBzcGVj
aWZpYyBtZW1vcnkgZm9yIGENCj4+PiBwYXJ0aWN1bGFyIGlub2RlLg0KPj4+IA0KPj4+IEEgcGFy
dGljaXBhdGluZyBzdWItc3lzdGVtIGluIHR1cm4gdXNlcyBpdHMgaWRlbnRpZmllciB0byByZWdp
c3RlciBhbg0KPj4+IGlub2RlIHNwZWNpZmljIHBvaW50ZXIgZm9yIGl0cyBzdWItc3lzdGVtLg0K
Pj4+IA0KPj4+IFRoaXMgc3RyYXRlZ3kgbG9zZXMgTygxKSBsb29rdXAgY29tcGxleGl0eSBidXQg
cmVkdWNlcyB0b3RhbCBtZW1vcnkNCj4+PiBjb25zdW1wdGlvbiBhbmQgb25seSBpbXBvc2VzIG1l
bW9yeSBjb3N0cyBmb3IgaW5vZGVzIHdoZW4gYSBzdWItc3lzdGVtDQo+Pj4gZGVzaXJlcyB0byB1
c2UgaW5vZGUgc3BlY2lmaWMgc3RvcmFnZS4NCj4gDQo+PiBTRUxpbnV4IGFuZCBTbWFjayB1c2Ug
YW4gaW5vZGUgYmxvYiBmb3IgZXZlcnkgaW5vZGUuIFRoZSBwZXJmb3JtYW5jZQ0KPj4gcmVncmVz
c2lvbiBib2dnbGVzIHRoZSBtaW5kLiBOb3QgdG8gbWVudGlvbiB0aGUgYWRkaXRpb25hbA0KPj4g
Y29tcGxleGl0eSBvZiBtYW5hZ2luZyB0aGUgbWVtb3J5Lg0KPiANCj4gSSBndWVzcyB3ZSB3b3Vs
ZCBoYXZlIHRvIG1lYXN1cmUgdGhlIHBlcmZvcm1hbmNlIGltcGFjdHMgdG8gdW5kZXJzdGFuZA0K
PiB0aGVpciBsZXZlbCBvZiBtaW5kIGJvZ2dsaW5lc3MuDQo+IA0KPiBNeSBmaXJzdCB0aG91Z2h0
IGlzIHRoYXQgd2UgaGVhciBhIGh1Z2UgYW1vdW50IG9mIGZhbmZhcmUgYWJvdXQgQlBGDQo+IGJl
aW5nIGEgZ2FtZSBjaGFuZ2VyIGZvciB0cmFjaW5nIGFuZCBuZXR3b3JrIG1vbml0b3JpbmcuICBH
aXZlbg0KPiBjdXJyZW50IG5ldHdvcmtpbmcgc3BlZWRzLCBpZiBpdHMgYWJpbGl0eSB0byBtYW5h
Z2Ugc3RvcmFnZSBuZWVkZWQgZm9yDQo+IGl0IHB1cnBvc2VzIGFyZSB0cnVlbHkgYWJ5c21hbCB0
aGUgaW5kdXN0cnkgd291bGRuJ3QgYmUgZmluZGluZyB0aGUNCj4gdGVjaG5vbG9neSB1c2VmdWwu
DQo+IA0KPiBCZXlvbmQgdGhhdC4NCj4gDQo+IEFzIEkgbm90ZWQgYWJvdmUsIHRoZSBMU00gY291
bGQgYmUgYW4gaW5kZXBlbmRlbnQgc3Vic2NyaWJlci4gIFRoZQ0KPiBwb2ludGVyIHRvIHJlZ2lz
dGVyIHdvdWxkIGNvbWUgZnJvbSB0aGUgdGhlIGttZW1fY2FjaGUgYWxsb2NhdG9yIGFzIGl0DQo+
IGRvZXMgbm93LCBzbyB0aGF0IGNvc3QgaXMgaWRlbXBvdGVudCB3aXRoIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uLg0KPiBUaGUgcG9pbnRlciByZWdpc3RyYXRpb24gd291bGQgYWxzbyBiZSBh
IHNpbmdsZSBpbnN0YW5jZSBjb3N0Lg0KPiANCj4gU28gdGhlIHByaW1hcnkgY29zdCBkaWZmZXJl
bnRpYWwgb3ZlciB0aGUgY29tbW9uIGFyZW5hIG1vZGVsIHdpbGwgYmUNCj4gdGhlIGNvbXBsZXhp
dHkgY29zdHMgYXNzb2NpYXRlZCB3aXRoIGxvb2t1cHMgaW4gYSByZWQvYmxhY2sgdHJlZSwgaWYN
Cj4gd2UgdXNlZCB0aGUgb2xkIElNQSBpbnRlZ3JpdHkgY2FjaGUgYXMgYW4gZXhhbXBsZSBpbXBs
ZW1lbnRhdGlvbi4NCj4gDQo+IEFzIEkgbm90ZWQgYWJvdmUsIHRoZXNlIHBlciBpbm9kZSBsb2Nh
bCBzdG9yYWdlIHN0cnVjdHVyZXMgYXJlIGNvbXBsZXgNCj4gaW4gb2YgdGhlbXNlbHZlcywgaW5j
bHVkaW5nIGxpc3RzIGFuZCBsb2Nrcy4gIElmIHRvdWNoaW5nIGFuIGlub2RlDQo+IGludm9sdmVz
IGxvY2tpbmcgYW5kIHdhbGtpbmcgbGlzdHMgYW5kIHRoZSBsaWtlIGl0IHdvdWxkIHNlZW0gdGhh
dA0KPiB0aG9zZSBwZXJmb3JtYW5jZSBpbXBhY3RzIHdvdWxkIHF1aWNrbHkgc3dhbXAgYW4gci9i
IGxvb2t1cCBjb3N0Lg0KDQpicGYgbG9jYWwgc3RvcmFnZSBpcyBkZXNpZ25lZCB0byBiZSBhbiBh
cmVuYSBsaWtlIHNvbHV0aW9uIHRoYXQgd29ya3MNCmZvciBtdWx0aXBsZSBicGYgbWFwcyAoYW5k
IHdlIGRvbid0IGtub3cgaG93IG1hbnkgb2YgbWFwcyB3ZSBuZWVkIA0KYWhlYWQgb2YgdGltZSku
IFRoZXJlZm9yZSwgd2UgbWF5IGVuZCB1cCBkb2luZyB3aGF0IHlvdSBzdWdnZXN0ZWQgDQplYXJs
aWVyOiBldmVyeSBMU00gc2hvdWxkIHVzZSBicGYgaW5vZGUgc3RvcmFnZS4gOykgSSBhbSBvbmx5
IDkwJQ0Ka2lkZGluZy4gDQoNCj4gDQo+Pj4gQXBwcm9hY2ggMiByZXF1aXJlcyB0aGUgaW50cm9k
dWN0aW9uIG9mIGdlbmVyaWMgaW5mcmFzdHJ1Y3R1cmUgdGhhdA0KPj4+IGFsbG93cyBhbiBpbm9k
ZSdzIGtleS92YWx1ZSBtYXBwaW5ncyB0byBiZSBsb2NhdGVkLCBwcmVzdW1hYmx5IGJhc2VkDQo+
Pj4gb24gdGhlIGlub2RlJ3MgcG9pbnRlciB2YWx1ZS4gIFdlIGNvdWxkIHByb2JhYmx5IGp1c3Qg
cmVzdXJyZWN0IHRoZQ0KPj4+IG9sZCBJTUEgaWludCBjb2RlIGZvciB0aGlzIHB1cnBvc2UuDQo+
Pj4gDQo+Pj4gSW4gdGhlIGVuZCBpdCBjb21lcyBkb3duIHRvIGEgcmF0aGVyIHN0YW5kYXJkIHRy
YWRlLW9mZiBpbiB0aGlzDQo+Pj4gYnVzaW5lc3MsIG1lbW9yeSB2cy4gZXhlY3V0aW9uIGNvc3Qu
DQo+Pj4gDQo+Pj4gV2Ugd291bGQgcG9zaXQgdGhhdCBvcHRpb24gMiBpcyB0aGUgb25seSB2aWFi
bGUgc2NoZW1lIGlmIHRoZSBkZXNpZ24NCj4+PiBtZXRyaWMgaXMgb3ZlcmFsbCBnb29kIGZvciB0
aGUgTGludXgga2VybmVsIGVjby1zeXN0ZW0uDQo+IA0KPj4gTm8uIFJlYWxseSwgbm8uIFlvdSBu
ZWVkIGxvb2sgbm8gZnVydGhlciB0aGFuIHNlY21hcmtzIHRvIHVuZGVyc3RhbmQNCj4+IGhvdyBh
IGtleSBiYXNlZCBibG9iIGFsbG9jYXRpb24gc2NoZW1lIGxlYWRzIHRvIHRlYXJzLiBLZXlzIGFy
ZSBmaW5lDQo+PiBpbiB0aGUgY2FzZSB3aGVyZSB1c2Ugb2YgZGF0YSBpcyBzcGFyc2UuIFRoZXkg
aGF2ZSBubyBwbGFjZSB3aGVuIGRhdGENCj4+IHVzZSBpcyB0aGUgbm9ybS4NCj4gDQo+IFRoZW4g
aXQgd291bGQgc2VlbSB0aGF0IHdlIG5lZWQgdG8gZ2V0IGV2ZXJ5b25lIHRvIGFncmVlIHRoYXQg
d2UgY2FuDQo+IGdldCBieSB3aXRoIHVzaW5nIHR3byBwb2ludGVycyBpbiBzdHJ1Y3QgaW5vZGUu
ICBPbmUgZm9yIHVzZXMgYmVzdA0KPiBzZXJ2ZWQgYnkgY29tbW9uIGFyZW5hIGFsbG9jYXRpb24g
YW5kIG9uZSBmb3IgYSBrZXkvcG9pbnRlciBtYXBwaW5nLA0KPiBhbmQgdGhlbiBjb252ZXJ0IHRo
ZSBzdWItc3lzdGVtcyBhY2NvcmRpbmdseS4NCj4gDQo+IE9yIGFsdGVybmF0ZWx5LCBnZXR0aW5n
IGV2ZXJ5b25lIHRvIGFncmVlIHRoYXQgYWxsb2NhdGluZyBhIG1pbmludW0gb2YNCj4gZWlnaHQg
YWRkaXRpb25hbCBieXRlcyBmb3IgZXZlcnkgc3Vic2NyaWJlciB0byBwcml2YXRlIGlub2RlIGRh
dGENCj4gaXNuJ3QgdGhlIGVuZCBvZiB0aGUgd29ybGQsIGV2ZW4gaWYgdXNlIG9mIHRoZSByZXNv
dXJjZSBpcyBzcGFyc2UuDQoNCkNocmlzdGlhbiBzdWdnZXN0ZWQgd2UgY2FuIHVzZSBhbiBpbm9k
ZV9hZGRvbiBzdHJ1Y3R1cmUsIHdoaWNoIGlzIA0Kc2ltaWxhciB0byB0aGlzIGlkZWEuIEl0IHdv
bid0IHdvcmsgd2VsbCBpbiBhbGwgY29udGV4dHMsIHRob3VnaC4gDQpTbyBpdCBpcyBub3QgYXMg
Z29vZCBhcyBvdGhlciBicGYgbG9jYWwgc3RvcmFnZSAodGFzaywgc29jaywgY2dyb3VwKS4gDQoN
ClRoYW5rcywNClNvbmcNCg0KPiANCj4gT2YgY291cnNlLCBleHBlcmllbmNlIHdvdWxkIHN1Z2dl
c3QsIHRoYXQgZ2V0dGluZyBldmVyeW9uZSBpbiB0aGlzDQo+IGNvbW11bml0eSB0byBhZ3JlZSBv
biBzb21ldGhpbmcgaXMgcm91Z2hseSBha2luIHRvIHRocm93aW5nIGEgaGFuZA0KPiBncmVuYWRl
IGludG8gYSBjaGlja2VuIGNvb3Agd2l0aCBhbiBleHBlY3RhdGlvbiB0aGF0IGFsbCBvZiB0aGUN
Cj4gY2hpY2tlbnMgd2lsbCBmbHkgb3V0IGluIGEgdW5pZm9ybSBmbG9jayBmb3JtYXRpb24uDQo+
IA0KPiBBcyBhbHdheXMsDQo+IERyLiBHcmVnDQo+IA0KPiBUaGUgUXVpeG90ZSBQcm9qZWN0IC0g
RmxhaWxpbmcgYXQgdGhlIFRyYXZhaWxzIG9mIEN5YmVyc2VjdXJpdHkNCj4gICAgICAgICAgICAg
IGh0dHBzOi8vZ2l0aHViLmNvbS9RdWl4b3RlLVByb2plY3QNCg0K

