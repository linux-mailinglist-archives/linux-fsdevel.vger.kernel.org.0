Return-Path: <linux-fsdevel+bounces-26318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CE9575A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A89B20E80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1735158DC6;
	Mon, 19 Aug 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="feqvO9cG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC849627;
	Mon, 19 Aug 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099145; cv=fail; b=btYZ1PkuSLfCHrim8N9xfXRukEy5HuHH6mumD0uI28/czbWxcCjJTFlBhxlOAPI0U2CPaf7NpfMrQFLjlkHk+24qeT4Qcb2XEjKlg5HjsMqcQt+QrHWbp1PuoT2dU2WLO9aqZaZ01YSDsNI8zCrCPt1pPAUjqqx6/eyqCcvfDYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099145; c=relaxed/simple;
	bh=8+MLKpdB8e/CWPbEYg1+GDLAUVgRI6Ej/oFLDVAqLRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYLTE0bPQRSz9T14GmH6QisivSP+Z/JyyAVK9mih4fp4cyWxD8bTTtl1bOwdKhDwcFv1Dc10uL839Di1Jsza5ll88bgNO/EhI44zMa4jSBOV2RuO1bMw1DgevvKwhb4iGt9oekWvltVQMgxYpdoJLeq4GXM5vO9nHtUzheYBluc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=feqvO9cG; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JFBIa9018866;
	Mon, 19 Aug 2024 13:25:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=8+MLKpdB8e/CWPbEYg1+GDLAUVgRI6Ej/oFLDVAqLRU
	=; b=feqvO9cGNB3GbamxAbCmEEiHZ+qs+UvoyJv6jTzLqydQVEEB6aXOHrH0pUu
	jEJ4mgtYU8l10xbe+NNN3Teg+PiGDaFx1vAOvSOXYiaItQFGAOte6MNczWKDKN1I
	ttXzau3fKaEEbaqBZj4PXu5qdR0hSTumdkK95SMbnf1J/EsgedOIcSMHv+CO3nee
	eR9DnHvpAV32ju3Z0yMFpr6y/VTIoY0q0qMQBCd1R25UJ6liSU8fW4cRCIx1NJgE
	0ysqlA5qmEPKnz+TNBeYphBEo8mZIkOViBHjITWlaeedjA1G1g5xVf7HcFJYP85O
	glRydHo6jRyDNLGh+d10jBTzVgg==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4148fct4w2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 13:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmsjmBdguV3uDPde2ZmUCVcQcjbmnaXXBuJ8x52fRU3I+axTGH/LRQ2J/hlN8w7d4PfJEbG5a1xgslJDZGcc9Umm90SXdIr6rAf/hF5fPPz9mWF7GdXc318pMGP13khHUGRajzGUkyKROHFNa4aXnnbtLPdbF7/omPOCPcEkRBWczWGqqYsOJ6xMuRI78vGCw0KKXzXWQlZA/LAcuW0TCHyZafnR2Yxlft5xKVrHdqGCe0T+lFm8OZgyx/m/Y61wZYfcVUadU+iwOnTUZqvzHBhEJWg0oyJDbRsGi26LiIE2ot4Vn5lX1swQPMgXUoJrZD1upnhHTRHw1uv4jTh4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+MLKpdB8e/CWPbEYg1+GDLAUVgRI6Ej/oFLDVAqLRU=;
 b=NW7Dzsngd/R2etlGF9cAqRS1RHb8n3eq1wiiPgSWUwoNpE/yc7jnHTPO1/Naij8NgwuvyhIRyvYsghaVWQwac11ITSoqzSZL3ORKi8hIj2HL5Rwvi2cHyf8YdvXr4d/e8nk1sG2kCW5AU3tLW6otRCJt3+4VS7pf9VYz587KRUNixnYOG0qHL0mOeUU0sqpN7TfG64i+cATAb5dowkEUFDEGJHv/udT9Fbu9xJ8nm5x9yVz2NEilE4jidJdsHpfLt3BFmcQap2oY+skp4kJypuF3PDYpR7mym89gNpjHene4I1YoU0ohOUgkFZ7EBbYyaY9KO2RVEJKqD7gfZRsHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4747.namprd15.prod.outlook.com (2603:10b6:303:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 20:25:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 20:25:38 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Song Liu <songliubraving@meta.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart
	<liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgACZf4A=
Date: Mon, 19 Aug 2024 20:25:38 +0000
Message-ID: <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
In-Reply-To: <20240819-keilen-urlaub-2875ef909760@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4747:EE_
x-ms-office365-filtering-correlation-id: 6a124e21-f346-4d9f-6f70-08dcc08d16b8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnphNjRIbXNWR1crVWhsMUM5Zy8xMWZhZmU3SytzNVFneGdjRis2cEdYdEZK?=
 =?utf-8?B?eTlqMkZVeVc5L3J6MTcyeGxLLzVZemJzOURtWXJmcHkwMU5rZmkrR2F2TEkr?=
 =?utf-8?B?V0l4ZDFnYUlVOXpqOGViOVVsOVFtd2xvWitGQjRXRTFmSlVDNkJCN05TTkhq?=
 =?utf-8?B?czFqTEZUSXBQQU9BZTRLczZnRHhTMlZyRGdIL3daSld0U2k0Qk1FdkxNejNZ?=
 =?utf-8?B?Sm9ERHhNQXZZRjF5RWFaYTNGUDVDTnZyTDhtSkxvRVJqV2oxODRjemloVlUx?=
 =?utf-8?B?WTBkZ2tnbE9mRUM2V2lSWlkzdUkwa25aYnlNM0ZlM2NLdHd5VTVRV2Q0MWRt?=
 =?utf-8?B?dWlCTkJMVDUrekRNYllvS2QwN1orbGo2dkh6K1Q5WE1kaFFPVndGNkNtdTNr?=
 =?utf-8?B?bUxDZnNIOXNwbjlPVFM3ODlJbnc5R0czclZveXdLcERkZnYzVWhjTHViNVhF?=
 =?utf-8?B?QlVINzdKWXV6OXdWZXNEcmdNK2Y0Ty8rUTFQOSs5NVBtSlkyYlVoeU9RNEp1?=
 =?utf-8?B?cHZYSTk5Q2g5N1RJRjdkSktRUUFpZDFCTlBUcFpwUGNYbk5zbEcranhSTHFU?=
 =?utf-8?B?KzN6MXV3WTR5N29hZ1FPWW45QzhVeEpmbkFib1RGZzR6aWtvYm1wc1dKSjla?=
 =?utf-8?B?dStBcjRaOEtkeno0MjFNTHFia1pCVUNVWElSWHdEcjdSc0FMdDMrTnR2Rm9F?=
 =?utf-8?B?ZGNnN1RUUGFvZGxVY2FjTXFqQzJFYnJ3Y0R3NGNuNExobUZuL1FiMUx6M0p2?=
 =?utf-8?B?aWZUQVZZQ21SSVdxQ3h5MEQ3Ni92aDlnNC9zeXpIRURkRVpUa1BSNGdEdDFP?=
 =?utf-8?B?bEJzMzVpeTBraDZTYjZDUlZtbmVDMW10MEh1emZYMVluRHlxTjZ3a3dQcGZI?=
 =?utf-8?B?NG0vcGc3SHFDR3JFMGtXOUdSNnZVbW42ZzN3YTdKbUJHQ0pvK2VBWTNPQW5m?=
 =?utf-8?B?TGkzVytkcnZEdGpudGxYM1ZoQVdQaWYxNVN0ME56Nm9LMGtlaS9LUk1uRjVw?=
 =?utf-8?B?QTcxZ0NoREFabWZsT2IwWUdSREd2djgyUi9yaDZRRmgzSlY1Vkdka0kwM0U5?=
 =?utf-8?B?Z2JQSXgrNTg3aVRJbiswWDlINHBnRnV0enpKTlU2TGZzeGdSL1Jxbk51OWRH?=
 =?utf-8?B?c2Rsd2FlY1VYZ1VhZHdCZWhJcjEyS2s2MGNjMk56OWNlMHdyY3FrMXY4cmRy?=
 =?utf-8?B?eXhuYStGc3psaXBldEdhZHFrZTdhcGJKaThjMUpHY2Uzbk14bzk3ZXg2eUNY?=
 =?utf-8?B?R3dhdWJjWjgyaXVienl1Y1VHQXF3dnR6di9sc01XQWZiTFNHdXRjR1J6dHJF?=
 =?utf-8?B?T1FKSS8rMWgrUGgrQjR5RmhRVVVHZklRQzN2RUE0L1ZIMHREZXZsWktnOUlo?=
 =?utf-8?B?dDcwc3YrYjBpWVhnVVQvaXFTTTJxTjd4NFRpakg0d3JPb3pWZW0rOG9qSjkr?=
 =?utf-8?B?RG1xa2FPL0VpVTlYTUw3WkZWUE5EVFFtR1cvOTVmMVpSRzJJdi9IWTVpbWZU?=
 =?utf-8?B?Y0xIMHVjSDdFUGdEUEJKeE1nNDk3YUxIaVRHMEtCSUJEaEN3N21mQnRJaVN0?=
 =?utf-8?B?UEJXWmg3SG4vMXVHLy9IdzRGd29tMHluT2kvNGNrN0VocW5jbWN0UEZVK05r?=
 =?utf-8?B?UHpGdENQNlhoZDVWRno0bGVFckFEMGdFaHFnZ3FRc3JPMVhWdzQzN1NTTFVt?=
 =?utf-8?B?REw2YnRDSjVvSGxvZHZEWmdjTHJBc2ZiODZBZGtVZ3Znd05vdDBUcjRVbkRH?=
 =?utf-8?B?UmFSM0FuMVowakMxQk1xdXdPRWFPT2pkUmlocEN3Wi9vQTV3eUlhLzFKSkVI?=
 =?utf-8?B?WThLelJtckgyeWRnK2cxaCtpMjQ0OTY3VFdlNjVJaEsyTVUzb3FZRWxER2JO?=
 =?utf-8?B?R1BmbVdFdDF0WnN3UHlBY1NYZFNFcSs5UXhIZmMwditFeXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjE5NjZ3VXVtYmhnR3JrZ2tHOUFTMEtiaU5BaitqazAyZWRTbWhLaWU5dWdV?=
 =?utf-8?B?enNBTW50cEhVV1RvenBKR0l1ZzN6V2o4TzJCUEpaVnYwZi9qNnZtclpMbU5m?=
 =?utf-8?B?Q0kxbHYweHdvWlZZTTA3cE82TXZzUnpXdm5IWVkybEkvanJPR2ZpU09GZ3V6?=
 =?utf-8?B?NnZDUFFKekJ4ZjhhMVhONTJ1WGF2QUpFWDJaQ0lhMWZQUHZjcDlNODNMZTNy?=
 =?utf-8?B?VngrSUF6Uld3ejJLc0ZWWklwRUJXZUhqRi92STBhUXR2ZEtnblJURVk5SW0r?=
 =?utf-8?B?UlJLU1Y0VERBOHNlcVFzOGRETmJwMHJsTXhjUUtrRHdHNmMwOVBOZlVXQTVE?=
 =?utf-8?B?TytwZ2x6d2pPalZZYXJvUi9NdzRqNnNjbFlBRXJSMVNnQXU4YzB6QUtOZVMw?=
 =?utf-8?B?VEQ5ck9NNjFDalFrWHRjTnlueTM1UjczVHIrTjFCMkR0ZEdFYWtGQlBjNnNa?=
 =?utf-8?B?RzBIOXRvVHc1WFV0eUNJMU1Pd0JVTWNvRUUzNi9YcGhYL2oxd1UxaHFwVDRs?=
 =?utf-8?B?TytDZjdRS2tNR2pqeUxOYm8rUTQ1MjcrTFBwZjlESitKTGZaMEdZZ3MrUytl?=
 =?utf-8?B?M0RmZVdhTTFtUGdqdVhPSnJNbDJvT3lkOXpzcFlYcGgrVjRyNElnN29uRmtH?=
 =?utf-8?B?eDQ3YmVBMkRYRDRpM0JJb096NEpNTG9jcXBZWUk2RktTMGJJSlA5QWRjcDh0?=
 =?utf-8?B?eVpwd2pGY2w3N2REQ1p3b1BWVXFucEl3MS9yVVNtMXUwZEdIeFFoVk1Ubmlj?=
 =?utf-8?B?Wjkrc3Y0RUVVQjZmT1F5Z3pvZjhjbmhOLzJIbWxDaE5VaXVTRkRYYUdYL0dh?=
 =?utf-8?B?VzRaaGVkYlNibjU2aytNZXhDcHFwTVd5Umg2T0pLcXhNdVhSbDhrTXR2dEtF?=
 =?utf-8?B?dUx0aktTZHJKRmNBaXkxdWJrVGNzcUYxWmpmYlhLaytONmNxQjlKTksya01C?=
 =?utf-8?B?TWlXdTJsSXFQTXlQbWttVnlrbWZNODY1eXRBQkU2MTRXQnhuTUhzYjJwRHpa?=
 =?utf-8?B?K1NEOEJEUUdXYTEyb05laHN6QXcwbCtWVHlPSFVjeWJNREUra0h1aXkveERa?=
 =?utf-8?B?TzNDTWZHd2JacFVrY29QNW1qdjVvdXhITko0c2IrbUhaNCt1Y0ZtaTErUjJT?=
 =?utf-8?B?RjdQVjIwYlJocWdaVUFDK2l2b3I1SUpHWlE5QlZJMlE1Q2FqWG02N3VpUTUx?=
 =?utf-8?B?WmNUNi9VNWczaHpwNDZCLzZPUkQ1S3ZITGp3KzZENmhRTXdHNkNYNkJ3M0RX?=
 =?utf-8?B?TUxuUy9UbTB3UEYyTUgvajB0WS9ZRXRyV29GMThUcW5oMlFvQlN1TmRMb1Nx?=
 =?utf-8?B?WEhOZnFXVllXTXpmelZicWtKWGtHKytjLzZmbVhISUtDY1Vqc2FzVjhMd25R?=
 =?utf-8?B?K2JsQjQzUS84bXpML1ozbTdFNnRuNmNqNXhRVjVaak5sOXZ2NGRrNnYraXlS?=
 =?utf-8?B?N3MrVHB6OXM5cThhUkJOR0N3MWYzTnlKZFIvS3pBU1NabjBwQTJnc2dKblZQ?=
 =?utf-8?B?QUtBRlQwMWRZdkRPbDZaSWthQ3JCYXZadGloNk8weFdzeWQ4VUhpM09JTlk2?=
 =?utf-8?B?WWp5T2dEMkVKNEFBZkFsRG0vRi9KY3oydFpsK2x5dS80L3ViaVZqYXdFc0Fz?=
 =?utf-8?B?YWdPOGpMaTE1OTczbld2bW91SFc0VnBWYUN5Y09Mc2VvOHlIa0o5OGs2b0dI?=
 =?utf-8?B?M0NFTGhRZVFCWmlvTE5Va2FqaUhNdnVwL1BqU0FOZkRPaWtnQTltSXIveGZY?=
 =?utf-8?B?ZTJjeW5ucWFaUE5RQm5lcnB3eXJQWFFkMVNSOG9JRnZnVXN0SG5jcEZ2dUFz?=
 =?utf-8?B?QVVKMFVablZ6S0NjRmtWYU9mYVJ1VHlBdzZhaGs0eDNhL056Tm5GMXQvbHFS?=
 =?utf-8?B?TlVRTm5pSjlOcFNWa1FVZFdUeUM1R1QzSml6V2VWZ3g5Ky9NdXRSNWx6bzdK?=
 =?utf-8?B?MU1XZVk0OU9pYUg4WHNrMm0zYTRkamxWZzlyU2JidjlHTUQ2aGIvSWpUUVl1?=
 =?utf-8?B?Vi96TzY1OTVpQjdRSWgraVhXR0JKQVhKZ0xuL25HUCthUWNvN1hwRVF2azhh?=
 =?utf-8?B?R1VaN2lDT2g0eXE5TzlYZGRqclNUbnkzNm9rMEJ4c2FMdkpkRVp4SmMwZnlM?=
 =?utf-8?B?VEZEU3N5NW0wRlZZZHByckNCbVllMDFhT1czTC8rTmNYSlRwUEVKTTUzbjFY?=
 =?utf-8?Q?CH1VYjQGpUUGO0WaO2zxACI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF304F1DB17F049B411A59807670E49@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a124e21-f346-4d9f-6f70-08dcc08d16b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 20:25:38.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm4NVNs6RYPEvBxR0Vt8dSEwmmPOcWRIPjO+0o1rVHlbZTIrq1IwXRVasxL12KWRyLA+Ppnjj9zwC05/ntSqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4747
X-Proofpoint-GUID: l75majH4oIZSfBxPPckLzQP_rnv1glAU
X-Proofpoint-ORIG-GUID: l75majH4oIZSfBxPPckLzQP_rnv1glAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01

SGkgQ2hyaXN0aWFuLCANCg0KPiBPbiBBdWcgMTksIDIwMjQsIGF0IDQ6MTbigK9BTSwgQ2hyaXN0
aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6DQoNClsuLi5dDQoNCj4+IERp
ZCBJIGdldCB0aGlzIHJpZ2h0PyANCj4+IA0KPj4gSUlVQywgdGhlcmUgYXJlIGEgZmV3IGlzc3Vl
cyB3aXRoIHRoaXMgYXBwcm9hY2guIA0KPj4gDQo+PiAxLiBzZWN1cml0eV9pbm9kZV9wZXJtaXNz
aW9uIHRha2VzIGlub2RlIGFzIHBhcmFtZXRlci4gSG93ZXZlciwgd2UgbmVlZCANCj4+ICAgZGVu
dHJ5IHRvIGdldCB0aGUgeGF0dHIuIFNoYWxsIHdlIGNoYW5nZSBzZWN1cml0eV9pbm9kZV9wZXJt
aXNzaW9uDQo+PiAgIHRvIHRha2UgZGVudHJ5IGluc3RlYWQ/IA0KPj4gICBQUzogTWF5YmUgd2Ug
c2hvdWxkIGNoYW5nZSBtb3N0L2FsbCBpbm9kZSBob29rcyB0byB0YWtlIGRlbnRyeSBpbnN0ZWFk
Pw0KPiANCj4gc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbigpIGlzIGNhbGxlZCBpbiBnZW5lcmlj
X3Blcm1pc3Npb24oKSB3aGljaCBpbg0KPiB0dXJuIGlzIGNhbGxlZCBmcm9tIGlub2RlX3Blcm1p
c3Npb24oKSB3aGljaCBpbiB0dXJuIGlzIGNhbGxlZCBmcm9tDQo+IGlub2RlLT5pX29wLT5wZXJt
aXNzaW9uKCkgZm9yIHZhcmlvdXMgZmlsZXN5c3RlbXMuIFNvIHRvIG1ha2UNCj4gc2VjdXJpdHlf
aW5vZGVfcGVybWlzc2lvbigpIHRha2UgYSBkZW50cnkgYXJndW1lbnQgb25lIHdvdWxkIG5lZWQg
dG8NCj4gY2hhbmdlIGFsbCBpbm9kZS0+aV9vcC0+cGVybWlzc2lvbigpIHRvIHRha2UgYSBkZW50
cnkgYXJndW1lbnQgZm9yIGFsbA0KPiBmaWxlc3lzdGVtcy4gTkFLIG9uIHRoYXQuDQo+IA0KPiBU
aGF0J3MgaWdub3JpbmcgdGhhdCBpdCdzIGp1c3QgcGxhaW4gd3JvbmcgdG8gcGFzcyBhIGRlbnRy
eSB0bw0KPiAqKmlub2RlKipfcGVybWlzc2lvbigpIG9yIHNlY3VyaXR5XyoqaW5vZGUqKl9wZXJt
aXNzaW9uKCkuIEl0J3MNCj4gcGVybWlzc2lvbnMgb24gdGhlIGlub2RlLCBub3QgdGhlIGRlbnRy
eS4NCg0KQWdyZWVkLiANCg0KWy4uLl0NCg0KPj4+IA0KPj4+IFdoaWNoIG1lYW5zIHRoaXMgY29k
ZSBlbmRzIHVwIGNoYXJnaW5nIHJlbGF0aXZlIGxvb2t1cHMgdHdpY2UuIEV2ZW4gaWYgb25lDQo+
Pj4gaXJvbnMgdGhhdCBvdXQgaW4gdGhlIHByb2dyYW0gdGhpcyBlbmNvdXJhZ2VzIHJlYWxseSBi
YWQgcGF0dGVybnMuDQo+Pj4gUGF0aCBsb29rdXAgaXMgaXRlcmF0aXZlIHRvcCBkb3duLiBPbmUg
Y2FuJ3QganVzdCByYW5kb21seSB3YWxrIGJhY2sgdXAgYW5kDQo+Pj4gYXNzdW1lIHRoYXQncyBl
cXVpdmFsZW50Lg0KPj4gDQo+PiBJIHVuZGVyc3RhbmQgdGhhdCB3YWxrLXVwIGlzIG5vdCBlcXVp
dmFsZW50IHRvIHdhbGsgZG93bi4gQnV0IGl0IGlzIHByb2JhYmx5DQo+PiBhY2N1cmF0ZSBlbm91
Z2ggZm9yIHNvbWUgc2VjdXJpdHkgcG9saWNpZXMuIEZvciBleGFtcGxlLCBMU00gTGFuZExvY2sg
dXNlcw0KPj4gc2ltaWxhciBsb2dpYyBpbiB0aGUgZmlsZV9vcGVuIGhvb2sgKGZpbGUgc2VjdXJp
dHkvbGFuZGxvY2svZnMuYywgZnVuY3Rpb24gDQo+PiBpc19hY2Nlc3NfdG9fcGF0aHNfYWxsb3dl
ZCkuDQo+IA0KPiBJJ20gbm90IHdlbGwtdmVyc2VkIGluIGxhbmRsb2NrIHNvIEknbGwgbGV0IE1p
Y2thw6tsIGNvbW1lbnQgb24gdGhpcyB3aXRoDQo+IG1vcmUgZGV0YWlscyBidXQgdGhlcmUncyB2
ZXJ5IGltcG9ydGFudCByZXN0cmljdGlvbnMgYW5kIGRpZmZlcmVuY2VzDQo+IGhlcmUuDQo+IA0K
PiBMYW5kbG9jayBleHByZXNzZXMgc2VjdXJpdHkgcG9saWNpZXMgd2l0aCBmaWxlIGhpZXJhcmNo
aWVzIGFuZA0KPiBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uKCkgZG9lc24ndCBhbmQgY2Fubm90
IGhhdmUgYWNjZXNzIHRvIHRoYXQuDQo+IA0KPiBMYW5kbG9jayBpcyBzdWJqZWN0IHRvIHRoZSBz
YW1lIHByb2JsZW0gdGhhdCB0aGUgQlBGIGlzIGhlcmUuIE5hbWVseQ0KPiB0aGF0IHRoZSBWRlMg
cGVybWlzc2lvbiBjaGVja2luZyBjb3VsZCBoYXZlIGJlZW4gZG9uZSBvbiBhIHBhdGggd2Fsaw0K
PiBjb21wbGV0ZWx5IGRpZmZlcmVudCBmcm9tIHRoZSBwYXRoIHdhbGsgdGhhdCBpcyBjaGVja2Vk
IHdoZW4gd2Fsa2luZw0KPiBiYWNrIHVwIGZyb20gc2VjdXJpdHlfZmlsZV9vcGVuKCkuDQo+IA0K
PiBCdXQgYmVjYXVzZSBsYW5kbG9jayB3b3JrcyB3aXRoIGEgZGVueS1ieS1kZWZhdWx0IHNlY3Vy
aXR5IHBvbGljeSB0aGlzDQo+IGlzIG9rIGFuZCBpdCB0YWtlcyBvdmVybW91bnRzIGludG8gYWNj
b3VudCBldGMuDQo+IA0KPj4gDQo+PiBUbyBzdW1tYXJ5IG15IHRob3VnaHRzIGhlcmUuIEkgdGhp
bmsgd2UgbmVlZDoNCj4+IA0KPj4gMS4gQ2hhbmdlIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24g
dG8gdGFrZSBkZW50cnkgaW5zdGVhZCBvZiBpbm9kZS4NCj4gDQo+IFNvcnJ5LCBuby4NCj4gDQo+
PiAyLiBTdGlsbCBhZGQgYnBmX2RnZXRfcGFyZW50LiBXZSB3aWxsIHVzZSBpdCB3aXRoIHNlY3Vy
aXR5X2lub2RlX3Blcm1pc3Npb24NCj4+ICAgc28gdGhhdCB3ZSBjYW4gcHJvcGFnYXRlIGZsYWdz
IGZyb20gcGFyZW50cyB0byBjaGlsZHJlbi4gV2Ugd2lsbCBuZWVkDQo+PiAgIGEgYnBmX2RwdXQg
YXMgd2VsbC4gDQo+PiAzLiBUaGVyZSBhcmUgcHJvcyBhbmQgY29ucyB3aXRoIGRpZmZlcmVudCBh
cHByb2FjaGVzIHRvIGltcGxlbWVudCB0aGlzDQo+PiAgIHBvbGljeSAodGFncyBvbiBkaXJlY3Rv
cnkgd29yayBmb3IgYWxsIGZpbGVzIGluIGl0KS4gV2UgcHJvYmFibHkgbmVlZCANCj4+ICAgdGhl
IHBvbGljeSB3cml0ZXIgdG8gZGVjaWRlIHdpdGggb25lIHRvIHVzZS4gRnJvbSBCUEYncyBQT1Ys
IGRnZXRfcGFyZW50DQo+PiAgIGlzICJzYWZlIiwgYmVjYXVzZSBpdCB3b24ndCBjcmFzaCB0aGUg
c3lzdGVtLiBJdCBtYXkgZW5jb3VyYWdlIHNvbWUgYmFkDQo+PiAgIHBhdHRlcm5zLCBidXQgaXQg
YXBwZWFycyB0byBiZSByZXF1aXJlZCBpbiBzb21lIHVzZSBjYXNlcy4NCj4gDQo+IFlvdSBjYW5u
b3QganVzdCB3YWxrIGEgcGF0aCB1cHdhcmRzIGFuZCBjaGVjayBwZXJtaXNzaW9ucyBhbmQgYXNz
dW1lDQo+IHRoYXQgdGhpcyBpcyBzYWZlIHVubGVzcyB5b3UgaGF2ZSBhIGNsZWFyIGlkZWEgd2hh
dCBtYWtlcyBpdCBzYWZlIGluDQo+IHRoaXMgc2NlbmFyaW8uIExhbmRsb2NrIGhhcyBhZmFpY3Qu
IEJ1dCBzbyBmYXIgeW91IG9ubHkgaGF2ZSBhIHZhZ3VlDQo+IHNrZXRjaCBvZiBjaGVja2luZyBw
ZXJtaXNzaW9ucyB3YWxraW5nIHVwd2FyZHMgYW5kIHJldHJpZXZpbmcgeGF0dHJzDQo+IHdpdGhv
dXQgYW55IG5vdGlvbiBvZiB0aGUgcHJvYmxlbXMgaW52b2x2ZWQuDQoNCkkgYW0gc29ycnkgZm9y
IGJlaW5nIHZhZ3VlIHdpdGggdGhlIHVzZSBjYXNlIGhlcmUuIFdlIGFyZSB0cnlpbmcgdG8gDQpj
b3ZlciBhIGZldyBkaWZmZXJlbnQgdXNlIGNhc2VzLCBzdWNoIGFzIHNhbmRib3hpbmcsIGFsbG93
bGlzdGluZyANCmNlcnRhaW4gb3BlcmF0aW9ucyB0byBzZWxlY3RlZCBiaW5hcmllcywgcHJldmVu
dCBvcGVyYXRpb24gZXJyb3JzLCBldGMuIA0KRm9yIHRoaXMgd29yaywgd2UgYXJlIGxvb2tpbmcg
Zm9yIHRoZSByaWdodCBidWlsZGluZyBibG9ja3MgdG8gZW5hYmxlDQp0aGVzZSB1c2UgY2FzZXMu
IA0KDQo+IElmIHlvdSBwcm92aWRlIGEgYnBmX2dldF9wYXJlbnQoKSBhcGkgZm9yIHVzZXJzcGFj
ZSB0byBjb25zdW1lIHlvdSdsbA0KPiBlbmQgdXAgcHJvdmlkaW5nIHRoZW0gd2l0aCBhbiBhcGkg
dGhhdCBpcyBleHRyZW1seSBlYXN5IHRvIG1pc3VzZS4NCg0KRG9lcyB0aGlzIG1ha2Ugc2Vuc2Ug
dG8gaGF2ZSBoaWdoZXIgbGV2ZWwgQVBJIHRoYXQgd2Fsa3MgdXAgdGhlIHBhdGgsIA0Kc28gdGhh
dCBpdCB0YWtlcyBtb3VudHMgaW50byBhY2NvdW50LiBJdCBjYW4gcHJvYmFibHkgYmUgc29tZXRo
aW5nIGxpa2U6DQoNCmludCBicGZfZ2V0X3BhcmVudF9wYXRoKHN0cnVjdCBwYXRoICpwKSB7DQph
Z2FpbjoNCiAgICBpZiAocC0+ZGVudHJ5ID09IHAtPm1udC5tbnRfcm9vdCkgew0KICAgICAgICBm
b2xsb3dfdXAocCk7DQogICAgICAgIGdvdG8gYWdhaW47DQogICAgfQ0KICAgIGlmICh1bmxpa2Vs
eShJU19ST09UKHAtPmRlbnRyeSkpKSB7DQogICAgICAgIHJldHVybiBQQVJFTlRfV0FMS19ET05F
OyAgDQogICAgfQ0KICAgIHBhcmVudF9kZW50cnkgPSBkZ2V0X3BhcmVudChwLT5kZW50cnkpOw0K
ICAgIGRwdXQocC0+ZGVudHJ5KTsNCiAgICBwLT5kZW50cnkgPSBwYXJlbnRfZGVudHJ5Ow0KICAg
IHJldHVybiBQQVJFTlRfV0FMS19ORVhUOyANCn0NCg0KVGhpcyB3aWxsIGhhbmRsZSB0aGUgbW91
bnQuIEhvd2V2ZXIsIHdlIGNhbm5vdCBndWFyYW50ZWUgZGVueS1ieS1kZWZhdWx0DQpwb2xpY2ll
cyBsaWtlIExhbmRMb2NrIGRvZXMsIGJlY2F1c2UgdGhpcyBpcyBqdXN0IGEgYnVpbGRpbmcgYmxv
Y2sgb2YgDQpzb21lIHNlY3VyaXR5IHBvbGljaWVzLiANCg0KSXMgdGhpcyBzb21ldGhpbmcgd2Ug
Y2FuIGdpdmUgYSB0cnkgd2l0aD8NCg0KVGhhbmtzLA0KU29uZw0KDQo=

