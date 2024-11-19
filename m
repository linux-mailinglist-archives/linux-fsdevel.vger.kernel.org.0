Return-Path: <linux-fsdevel+bounces-35247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0449D3092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 23:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F31F2389A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA01D5171;
	Tue, 19 Nov 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iNJz0axL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B351D47A3;
	Tue, 19 Nov 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055711; cv=fail; b=YkLTI6Wjxz1ZIRMA315dSRWS+sm/mbox4c4E46wLoELNMJ43ia7TFDumKe9a2///NIiUWUgVgerDWC7YejE5oh5Pa4+nIH6tWHwpmLsCJCukaVBvPNQgsCUH5v+FkVumwIJa8ljzOVpd7W9BQOsC+a1yZw/QOIt/w8CFVb3wP44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055711; c=relaxed/simple;
	bh=tgCzZcwRNsr75nTdT5Ee+O5MdNYtuxA2Pp75fP7a+vQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVjDxeGmntj2Zv8gaEx77eSxwDGqBmIuye12B7Hl2aWziC2ucR9cf8Quk6lKg2wjN9rvihvGGH8vJ+ozMLAIzn5GALut/xqS1dUglQhuVGsk2lnruzvpbTKpJyccr4QEsBTLmPOBttFrzAkLEZ6J/SrlrUEli1LdYWNZf4CWGc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iNJz0axL; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLwjSf018539;
	Tue, 19 Nov 2024 14:35:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=tgCzZcwRNsr75nTdT5Ee+O5MdNYtuxA2Pp75fP7a+vQ=; b=
	iNJz0axLioQHBlbJt+bSlKYl1Q5At2wUOwGlDfByGfSGEcmhGD4GoXnxPFezncJY
	ArAHkg27iT7x/EYRn/ajtC8iJO8yMuY/OKCTAEAG6/ndl/U2CDWGCEp85ONQeKzV
	9UiExG5gFdyItI47tNnJHPKsLedzMXAwWlETMG2KRBNycETV3I0QASQVxnv0RhzN
	VNg9lChMtqCF2vxmvrCvB00ZVo0o/UCZk08xLiXCg1agSwWWY+o6VQqAU8UPOb5g
	nj7HWbR5vuZcXgHhejs0IrR5uNLcvVXCR29sTo/taPnFTltuFO+lLSauEFOAWGJP
	2ZwRJwowfZL2ngP7VsIhdQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43132cg7pj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 14:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mChne8vrVTypfwteJloYC0uVUHWcWlqJWKOrqpIaRguY+nQ5Q9YANS6UU28O3FJnXsHTWPE0Xg2EJmA77HkgunblktaCimCnWnn1ircUCCgre/xy27PAcee7yQ4+C3ZT3BNMSYG3XSaxzlvz6/paHY/IFqqYvlcY/szYFd0RUri5HYUgBXsNsN1tGXaUu7OcvdUiyyzRpqTBu3L0ynwxBgSXLKeDBGGdpt3Q2u/dFcA5YM+kTA3Cf/oMpdABsaK1VYVPyUhr3oKuCRrD50FLFc0TRVygg8LYSAczRWxWkob5ilQo2Pd7NBxCb7n/sAL+G+weGms0mheb+FhtWq+DRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgCzZcwRNsr75nTdT5Ee+O5MdNYtuxA2Pp75fP7a+vQ=;
 b=JqLD/jz3tS+L7f+UnXQBkeYJm7fh9SQ3NxcW/sI5kWHKZfhm42cHgxa2P5VTcy3z+CI6XhnokzgoUFp2P25a+hUpi9fDtN9rJ/ihthqHB++/pkcdWRKG4UVHSF8ZqG7BiX0i/cYTVBcy9cW0rZfuHBolrqtZ0uq/p6nN+Q7hKMR2qr2Sc8zSuIYhiYi6YbqUbD7stEVMuXAfht9pfXLuMVEOTaJYhk5sMlyP+C96A2YaA703gUdB7pOdcMyZL7vSvjIyD3muSOkbMrw4nHBWDly+8BaT1tJq6UUxLCSgXU5kLUxMdEMeX06ChImiS1k/2F3qvs2Fo0+3qQtrQ5f+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS7PR15MB5375.namprd15.prod.outlook.com (2603:10b6:8:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 22:35:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 22:35:05 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: "Dr. Greg" <greg@enjellic.com>, Song Liu <songliubraving@meta.com>,
        James
 Bottomley <James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>, Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgIAAPekAgATKdQCAAnQTAIAAYQ+AgABIwgA=
Date: Tue, 19 Nov 2024 22:35:04 +0000
Message-ID: <277F219D-75B1-4D9D-A2FF-50FF90BAA0A2@fb.com>
References: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
In-Reply-To: <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS7PR15MB5375:EE_
x-ms-office365-filtering-correlation-id: 15c7bb7c-b864-4156-4139-08dd08ea69fc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3BONk5YY0hnZjkrNFg0VUtMWmtrZEdMa1Voc1lBM3hQVmpkaFIyU0RXU2Nj?=
 =?utf-8?B?eVIvQjNGbUxxdmUrOU9pUFd1WlVDbEpDV3k2blM1VW9oTkJOcHNJNFVjTVls?=
 =?utf-8?B?WXJ3SFJOR3o0dEFSWUJXT0Y1bkNkUERzVStacFJKRmxYV3VaSFhic1BkL0R1?=
 =?utf-8?B?VXNSZjhQQVFRQ2JYMGhVc1RxZzhsMG1hcHp5Q1RGTll5U1lYODhLSXkxVlp1?=
 =?utf-8?B?ZVA0azk0V01uSlZmcWNyaU8yWktpL0I3bWFJQ05zZFYvcDBOTFJOV2dPakxy?=
 =?utf-8?B?Wk8yMC9MaUQ0d1IxNWNYejhGc0pLOExWVlI5Y2gvU2lsTjBUaGpTR1JSQjBj?=
 =?utf-8?B?ZHBxM3p0LzgzNGhmbU1KRWVhT01MZFJuaW9CRCs0SHBicmppZkNvV0Ura0lW?=
 =?utf-8?B?QzRlN2NkLzdFM3VWd3NCek1VSk85WXBzb2dPSmp6b3p1eXU0dWVEWUp0ZzhJ?=
 =?utf-8?B?ZVAwanJQZ2xqbzJxZlpjem1teUNocHJLSWtPT0w4NlZSU0ZGaDNGc3N4Z1ZK?=
 =?utf-8?B?WGdJKzhsUXF0ZzFmbGpaeSt3ZU9kZjFDU0IvY3hPM29TdFNFM3B3TTZ2ajVx?=
 =?utf-8?B?aHlkNFZ2MURrVGhhbURHRnU3K1phbjRua0ZCbjNKZWtqdzZYakYxVTk4V0Ji?=
 =?utf-8?B?VkpWYm9BSDl6OHlYclF6djd6T25xK2lXRmRTME1uYzhQVTJ3SHliQjlPc3lJ?=
 =?utf-8?B?N2ErRERnTmh2R0QraVBTcUdDNzgyaFV6dXM3bnZFUENpbEhhYnNMMHBqRm51?=
 =?utf-8?B?OG8rd09uUUpvQk1BZlc5T3VTU3FEcHhKcTlkVHE2Zy9kMkVRemtwc2orYTdV?=
 =?utf-8?B?NmtieHpWcG1RVHdRcTlrRU12c3lkT2NHdWJRQUF4ODQyZnI0clp3QnpKQXda?=
 =?utf-8?B?OFU3Rk9LV0FtdUtjbTFncHRnaTNNa3ZwVjNJb3pYYzBpRVVHTjJrM2taN0FB?=
 =?utf-8?B?NXZLY25YTi81aXlVMW8weGdnZ2svYWRnUzhBRk9XNkxRVmR3ZXFxSXFNekd3?=
 =?utf-8?B?ajVhUnVHdW54eHNVWW1jd1cxUTBFbTdZUzZmOVkzRjYrUmpRVWR3R1VTN1Zu?=
 =?utf-8?B?M3IydHFsT2U2MEQ5N1pVWG5hZXRETnE5VDVycFJFcUlDYkhzTk55UytRZnF6?=
 =?utf-8?B?MXZFMzZ1NXdhRGg3c0g0YzdNdVdlNVBYbm9qK1I5dVhDbWJPRE05azZZa1Y4?=
 =?utf-8?B?YXZJYnRkandTTU5WN3pRNHpZcVYxNEpjcXF6K1pEZGZNb0hlZkZGTGh5d2Vs?=
 =?utf-8?B?SGdWSE9NM25XeGVpOVRJUVJEUVIrRDVDVlA0cThocW5IdzFmZXhYT2NOeTdV?=
 =?utf-8?B?WFZ4Z2kxWFJGbjFGdHQyeE95akRETzhpT1VaYUxuMzhzZ0lsL05tMEo1OHI5?=
 =?utf-8?B?R2NJSUIySXNaZkZRcXNIYmRtbXExeSsrb2lTYnRRT1Z0WXRyVzQzMGM1Mitk?=
 =?utf-8?B?VjQ0aTdycEY3bDBjb2NxZlhMZC9vVk5TRHpqTndMUjk1b081VmtmM2dmZGFh?=
 =?utf-8?B?d3FDUHlxK0NuTmFPcEJsYTA1TkFKeEJ5cEpBQ0FXdUQwaFVUL3p3Q2ZEUkM2?=
 =?utf-8?B?dElWclVhVVd0NytnY3Y0WUxtY3QyTWNlbXdBYVRGTEJKMUQxVFArSjltbmFy?=
 =?utf-8?B?TEdxY3pNcXFIK3U3RklQTnRJc3JxNmRISGxaTG9qdUdtSDhSZ05icFRwMnlv?=
 =?utf-8?B?VEFVMm5PMzlPQmVoQ3dhd2ZjVEdkY3lnMVI3cTdYWitsMm1BZ094aGRWRVNI?=
 =?utf-8?B?K3QrR1FzSm5rUlRtdkhRdUFPMWZqTGpxTmRMYWZDc0VJTWhHLzZ0YXEzQXNl?=
 =?utf-8?Q?p9S9zgbyJbeO8OX5Ofs5eRZI/7gywD3z6yWKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzlqK3Z0OTdLa0NWWENSL2N4TzdZZVVwNExtNDUwVUcxanVISG5kaFNQYkQ3?=
 =?utf-8?B?U01aaDdyejJZbzJuSVI0N3hTVFFUZHhleUpwV3R2Szk3OE9GSUdzc1lmc2o0?=
 =?utf-8?B?dCs2c1lkMFZ4N0RIWXJFT3hVK3VmQ1JpM1A2OU81MnlUaEFDa21CYUJwbFU2?=
 =?utf-8?B?NzducDZ1eE80VzlMaGFFcnNHNEUxaHBlREJjaHduZDY3aDVaUExkdStqZ3VB?=
 =?utf-8?B?K1BqV1ZEZjQvVkxncGR2UmhxeHE5Y1h3OElKSmtPc0gzemtDQW1QNnl6N2lm?=
 =?utf-8?B?L2Y4ajQ1Nzdwd0ZTNnBYb0tjaXRNbng0U1RvcWtPeThIVUJLMTVRQjg4RW0r?=
 =?utf-8?B?WXdmYlhYOXJxZ0dSbk9zZkF4WU41VXNVenBJYTBxL0RHYkgxU214VVQ1VHVr?=
 =?utf-8?B?dUdpY1FIMmc3Zm5xZk9zbzZBVndTZFJHK3pSQVNFSEljdlVGRTRSVUszVkRJ?=
 =?utf-8?B?azhGZGxjMjVMMGF4cTBsSktxSy9EM2RQRGJCWi9pQ2VweUJGUVczZWVLZ1kr?=
 =?utf-8?B?UEFJeFdiNnFFN0JuMktKa1BUSVF5cEtrMk5EM0I5eVJhSDJSanoxRkhqc3dq?=
 =?utf-8?B?VlhxTm1kZHNOTDZ4eTJURWc5YWlNeHZDK1k3dlRJeGZHTzVueXJSVzdGWStW?=
 =?utf-8?B?KzFSVC9peEl3THFrTDZONHhHQTJIWFBIVGpSSHlmWlZnNmpaL0JkM2hvcUtt?=
 =?utf-8?B?RGJSTHhRZkpZQitsZ25UQ2toUzNseVQ1V09NcXNwcGV2R0FUWFJBbWdwKy9h?=
 =?utf-8?B?bmdhUnEzejZYcUdYSXM5SktqSVIwMm9YZ0Mrdlc4YnNBem1rSS9JZGY3OGUw?=
 =?utf-8?B?b0l3VlBzelFxY3pXT1lBOHJvaXg1RzliYjhQM0dWTzMveGRyMzRrajlzL0FY?=
 =?utf-8?B?UEVMVTRlRFVQZkQ5TktOY2pOMHZOaU9lRjViQUZrZlczSzIraWx2cDd2RFFK?=
 =?utf-8?B?UE5RMWJhNzF4QkUzYXJLOFBMN3NmTEFScWVJSUl2QUFDZW01QWhueDZWclN0?=
 =?utf-8?B?NGRxOVczSGNtb0pTTnZCMXBwaDlOdmVTZzhIZVk1a2tQWkJITjF1bzB3Mmw3?=
 =?utf-8?B?dXRGcmdxRUFrYU1RbHNZYjdDZHgydGdBbldLWWRSM25ZVzlKaG9IbXFSYTBN?=
 =?utf-8?B?SXNId2lieUtaTDVtcldscjBYV0J2RndncCtQWGEvbWsyN2VOa3lTZm5kT0p6?=
 =?utf-8?B?UmZtc0QwbXR0OWM3OEExWFRkNWxmS2hGMW8zVkxUNU9OMHQrTTFxdUhHYUVT?=
 =?utf-8?B?MGlnUjMrS1ZtTkVjZzU1Nlk1OVJEbXVMUHhOWUNOMXlxTUFETll1ZlMxWC9i?=
 =?utf-8?B?M3pMb2xhNjJRQ25EcWFGTUUzekw2SHFVNDdXUWxNNUlzRlZGZFpTQW5xRThT?=
 =?utf-8?B?QjZuMTI1WEE5TnpseGFDM2RScjFUUXQrT0xMSnR4TzRWZVpKVGNnWXlLeS9l?=
 =?utf-8?B?Y0ZscWdQNVpXQ04vbERrbXIxbnIrdml2dDRqWk1zSUhzOEJRbyttNkU5dzJN?=
 =?utf-8?B?WWFuc2UyK1BFVkZJcG9qWFVteUlYWlRLcEt2clV3REdPZ3NzdkhvUXRIVWtL?=
 =?utf-8?B?N1BQV0lHT3dWZm5tSXgwZUMweG55Wis0TzRGV1BQRjM3YWg5NitCT2FlVFlo?=
 =?utf-8?B?QVUrN0lrSFdDNkRaNEJkdzZMYjkrTUdzb0ZyUENpU09NalBnMFFSTGRrZ2xn?=
 =?utf-8?B?aU0rOXU0cThSclNSN0NiUzlFbllpMEdRYUhyMVgrWmlHSzhQL0VDQ0hBNHpr?=
 =?utf-8?B?VXpSbGtnRFVmVVRtTWttUVVsZlB6Tk01U3ZhTUxsd1hzWGdiOWpnUjE1U3M2?=
 =?utf-8?B?cjdhRDBMRFdPOW41TXdXQlpHVldxUWdtUmJVelBRQ3JUajZxbWYrU1BBL2dQ?=
 =?utf-8?B?TlBVcTVUZDBRZGZYNlRDVm1DakF4NHFWOEt4a0dRZkd4Ni9ZVEttV3Z5eGZz?=
 =?utf-8?B?c0pCV0VQOUJtTzhMbnRtZXFjN3VjSjFvQTJ1TDVqTDFQeWx0ZnByQ1BOK01Q?=
 =?utf-8?B?ZmZoeGgrNGJ2MlU0dFhMc0xCTWc1bncvZGhOaS9iTzBFQ09aNm4yTlluMHVQ?=
 =?utf-8?B?Y0RsNHAySFdGWENkamNZS2U3ZmtrbEZZLzU5SHF4T0pYSldwa3pjbFM0ejJ2?=
 =?utf-8?B?SHpJRVFVS3BiS0RGVW9aOVdhaUJHMDFMek15eUZoNnhnWmJoOWNJY2dnUldi?=
 =?utf-8?Q?hG8s5rQJWvHQejci+q/4Gxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9524107618F3F74AAC976CBE4876F253@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c7bb7c-b864-4156-4139-08dd08ea69fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 22:35:04.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRHjwtVWfHmEEEP5bCjxMRW9maj0lDPL4jZu2XTX05tP1PCyw2WnqZTm0t8wyosBI0Ly/3ejxyOQqIOd9iVR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5375
X-Proofpoint-GUID: yhLgU8VpRpjP32hznqtiKGvfZx3wTq67
X-Proofpoint-ORIG-GUID: yhLgU8VpRpjP32hznqtiKGvfZx3wTq67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDE5LCAyMDI0LCBhdCAxMDoxNOKAr0FNLCBDYXNleSBTY2hhdWZsZXIgPGNh
c2V5QHNjaGF1Zmxlci1jYS5jb20+IHdyb3RlOg0KPiANCj4gT24gMTEvMTkvMjAyNCA0OjI3IEFN
LCBEci4gR3JlZyB3cm90ZToNCj4+IE9uIFN1biwgTm92IDE3LCAyMDI0IGF0IDEwOjU5OjE4UE0g
KzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4gDQo+Pj4gSGkgQ2hyaXN0aWFuLCBKYW1lcyBhbmQg
SmFuLA0KPj4gR29vZCBtb3JuaW5nLCBJIGhvcGUgdGhlIGRheSBpcyBzdGFydGluZyB3ZWxsIGZv
ciBldmVyeW9uZS4NCj4+IA0KPj4+PiBPbiBOb3YgMTQsIDIwMjQsIGF0IDE6NDk/Pz9QTSwgSmFt
ZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPiB3cm90
ZToNCj4+PiBbLi4uXQ0KPj4+IA0KPj4+Pj4gV2UgY2FuIGFkZHJlc3MgdGhpcyB3aXRoIHNvbWV0
aGluZyBsaWtlIGZvbGxvd2luZzoNCj4+Pj4+IA0KPj4+Pj4gI2lmZGVmIENPTkZJR19TRUNVUklU
WQ0KPj4+Pj4gICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICppX3NlY3VyaXR5Ow0KPj4+
Pj4gI2VsaWYgQ09ORklHX0JQRl9TWVNDQUxMDQo+Pj4+PiAgICAgICAgc3RydWN0IGJwZl9sb2Nh
bF9zdG9yYWdlIF9fcmN1ICppX2JwZl9zdG9yYWdlOw0KPj4+Pj4gI2VuZGlmDQo+Pj4+PiANCj4+
Pj4+IFRoaXMgd2lsbCBoZWxwIGNhdGNoIGFsbCBtaXN1c2Ugb2YgdGhlIGlfYnBmX3N0b3JhZ2Ug
YXQgY29tcGlsZQ0KPj4+Pj4gdGltZSwgYXMgaV9icGZfc3RvcmFnZSBkb2Vzbid0IGV4aXN0IHdp
dGggQ09ORklHX1NFQ1VSSVRZPXkuIA0KPj4+Pj4gDQo+Pj4+PiBEb2VzIHRoaXMgbWFrZSBzZW5z
ZT8NCj4+Pj4gR290IHRvIHNheSBJJ20gd2l0aCBDYXNleSBoZXJlLCB0aGlzIHdpbGwgZ2VuZXJh
dGUgaG9ycmlibGUgYW5kIGZhaWx1cmUNCj4+Pj4gcHJvbmUgY29kZS4NCj4+Pj4gDQo+Pj4+IFNp
bmNlIGVmZmVjdGl2ZWx5IHlvdSdyZSBtYWtpbmcgaV9zZWN1cml0eSBhbHdheXMgcHJlc2VudCBh
bnl3YXksDQo+Pj4+IHNpbXBseSBkbyB0aGF0IGFuZCBhbHNvIHB1bGwgdGhlIGFsbG9jYXRpb24g
Y29kZSBvdXQgb2Ygc2VjdXJpdHkuYyBpbiBhDQo+Pj4+IHdheSB0aGF0IGl0J3MgYWx3YXlzIGF2
YWlsYWJsZT8gIFRoYXQgd2F5IHlvdSBkb24ndCBoYXZlIHRvIHNwZWNpYWwNCj4+Pj4gY2FzZSB0
aGUgY29kZSBkZXBlbmRpbmcgb24gd2hldGhlciBDT05GSUdfU0VDVVJJVFkgaXMgZGVmaW5lZC4g
DQo+Pj4+IEVmZmVjdGl2ZWx5IHRoaXMgd291bGQgZ2l2ZSBldmVyeW9uZSBhIGdlbmVyaWMgd2F5
IHRvIGF0dGFjaCBzb21lDQo+Pj4+IG1lbW9yeSBhcmVhIHRvIGFuIGlub2RlLiAgSSBrbm93IGl0
J3MgbW9yZSBjb21wbGV4IHRoYW4gdGhpcyBiZWNhdXNlDQo+Pj4+IHRoZXJlIGFyZSBMU00gaG9v
a3MgdGhhdCBydW4gZnJvbSBzZWN1cml0eV9pbm9kZV9hbGxvYygpIGJ1dCBpZiB5b3UgY2FuDQo+
Pj4+IG1ha2UgaXQgd29yayBnZW5lcmljYWxseSwgSSdtIHN1cmUgZXZlcnlvbmUgd2lsbCBiZW5l
Zml0Lg0KPj4+IE9uIGEgc2Vjb25kIHRob3VnaHQsIEkgdGhpbmsgbWFraW5nIGlfc2VjdXJpdHkg
Z2VuZXJpYyBpcyBub3QgDQo+Pj4gdGhlIHJpZ2h0IHNvbHV0aW9uIGZvciAiQlBGIGlub2RlIHN0
b3JhZ2UgaW4gdHJhY2luZyB1c2UgY2FzZXMiLiANCj4+PiANCj4+PiBUaGlzIGlzIGJlY2F1c2Ug
aV9zZWN1cml0eSBzZXJ2ZXMgYSB2ZXJ5IHNwZWNpZmljIHVzZSBjYXNlOiBpdCANCj4+PiBwb2lu
dHMgdG8gYSBwaWVjZSBvZiBtZW1vcnkgd2hvc2Ugc2l6ZSBpcyBjYWxjdWxhdGVkIGF0IHN5c3Rl
bSANCj4+PiBib290IHRpbWUuIElmIHNvbWUgb2YgdGhlIHN1cHBvcnRlZCBMU01zIGlzIG5vdCBl
bmFibGVkIGJ5IHRoZSANCj4+PiBsc209IGtlcm5lbCBhcmcsIHRoZSBrZXJuZWwgd2lsbCBub3Qg
YWxsb2NhdGUgbWVtb3J5IGluIA0KPj4+IGlfc2VjdXJpdHkgZm9yIHRoZW0uIFRoZSBvbmx5IHdh
eSB0byBjaGFuZ2UgbHNtPSBpcyB0byByZWJvb3QgDQo+Pj4gdGhlIHN5c3RlbS4gQlBGIExTTSBw
cm9ncmFtcyBjYW4gYmUgZGlzYWJsZWQgYXQgdGhlIGJvb3QgdGltZSwgDQo+Pj4gd2hpY2ggZml0
cyB3ZWxsIGluIGlfc2VjdXJpdHkuIEhvd2V2ZXIsIEJQRiB0cmFjaW5nIHByb2dyYW1zIA0KPj4+
IGNhbm5vdCBiZSBkaXNhYmxlZCBhdCBib290IHRpbWUgKGV2ZW4gd2UgY2hhbmdlIHRoZSBjb2Rl
IHRvIA0KPj4+IG1ha2UgaXQgcG9zc2libGUsIHdlIGFyZSBub3QgbGlrZWx5IHRvIGRpc2FibGUg
QlBGIHRyYWNpbmcpLiANCj4+PiBJT1csIGFzIGxvbmcgYXMgQ09ORklHX0JQRl9TWVNDQUxMIGlz
IGVuYWJsZWQsIHdlIGV4cGVjdCBzb21lIA0KPj4+IEJQRiB0cmFjaW5nIHByb2dyYW1zIHRvIGxv
YWQgYXQgc29tZSBwb2ludCBvZiB0aW1lLCBhbmQgdGhlc2UgDQo+Pj4gcHJvZ3JhbXMgbWF5IHVz
ZSBCUEYgaW5vZGUgc3RvcmFnZS4gDQo+Pj4gDQo+Pj4gVGhlcmVmb3JlLCB3aXRoIENPTkZJR19C
UEZfU1lTQ0FMTCBlbmFibGVkLCBzb21lIGV4dHJhIG1lbW9yeSANCj4+PiBhbHdheXMgd2lsbCBi
ZSBhdHRhY2hlZCB0byBpX3NlY3VyaXR5IChtYXliZSB1bmRlciBhIGRpZmZlcmVudCANCj4+PiBu
YW1lLCBzYXksIGlfZ2VuZXJpYykgb2YgZXZlcnkgaW5vZGUuIEluIHRoaXMgY2FzZSwgd2Ugc2hv
dWxkIA0KPj4+IHJlYWxseSBhZGQgaV9icGZfc3RvcmFnZSBkaXJlY3RseSB0byB0aGUgaW5vZGUs
IGJlY2F1c2UgYW5vdGhlciANCj4+PiBwb2ludGVyIGp1bXAgdmlhIGlfZ2VuZXJpYyBnaXZlcyBu
b3RoaW5nIGJ1dCBvdmVyaGVhZC4gDQo+Pj4gDQo+Pj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/IE9y
IGRpZCBJIG1pc3VuZGVyc3RhbmQgdGhlIHN1Z2dlc3Rpb24/DQo+PiBUaGVyZSBpcyBhIGNvbGxv
cXVpYWxpc20gdGhhdCBzZWVtcyByZWxldmFudCBoZXJlOiAiUGljayB5b3VyIHBvaXNvbiIuDQo+
PiANCj4+IEluIHRoZSBncmVhdGVyIGludGVyZXN0cyBvZiB0aGUga2VybmVsLCBpdCBzZWVtcyB0
aGF0IGEgZ2VuZXJpYw0KPj4gbWVjaGFuaXNtIGZvciBhdHRhY2hpbmcgcGVyIGlub2RlIGluZm9y
bWF0aW9uIGlzIHRoZSBvbmx5IHJlYWxpc3RpYw0KPj4gcGF0aCBmb3J3YXJkLCB1bmxlc3MgQ2hy
aXN0aWFuIGNoYW5nZXMgaGlzIHBvc2l0aW9uIG9uIGV4cGFuZGluZw0KPj4gdGhlIHNpemUgb2Yg
c3RydWN0IGlub2RlLg0KPj4gDQo+PiBUaGVyZSBhcmUgdHdvIHBhdGh3YXlzIGZvcndhcmQuDQo+
PiANCj4+IDEuKSBBdHRhY2ggYSBjb25zdGFudCBzaXplICdibG9iJyBvZiBzdG9yYWdlIHRvIGVh
Y2ggaW5vZGUuDQo+PiANCj4+IFRoaXMgaXMgYSBzaW1pbGFyIGFwcHJvYWNoIHRvIHdoYXQgdGhl
IExTTSB1c2VzIHdoZXJlIGVhY2ggYmxvYiBpcw0KPj4gc2l6ZWQgYXMgZm9sbG93czoNCj4+IA0K
Pj4gUyA9IFUgKiBzaXplb2Yodm9pZCAqKQ0KPj4gDQo+PiBXaGVyZSBVIGlzIHRoZSBudW1iZXIg
b2Ygc3ViLXN5c3RlbXMgdGhhdCBoYXZlIGEgZGVzaXJlIHRvIHVzZSBpbm9kZQ0KPj4gc3BlY2lm
aWMgc3RvcmFnZS4NCj4gDQo+IEkgY2FuJ3QgdGVsbCBmb3Igc3VyZSwgYnV0IGl0IGxvb2tzIGxp
a2UgeW91IGRvbid0IHVuZGVyc3RhbmQgaG93DQo+IExTTSBpX3NlY3VyaXR5IGJsb2JzIGFyZSB1
c2VkLiBJdCBpcyAqbm90KiB0aGUgY2FzZSB0aGF0IGVhY2ggTFNNDQo+IGdldHMgYSBwb2ludGVy
IGluIHRoZSBpX3NlY3VyaXR5IGJsb2IuIEVhY2ggTFNNIHRoYXQgd2FudHMgc3RvcmFnZQ0KPiB0
ZWxscyB0aGUgaW5mcmFzdHJ1Y3R1cmUgYXQgaW5pdGlhbGl6YXRpb24gdGltZSBob3cgbXVjaCBz
cGFjZSBpdA0KPiB3YW50cyBpbiB0aGUgYmxvYi4gVGhhdCBjYW4gYmUgYSBwb2ludGVyLCBidXQg
dXN1YWxseSBpdCdzIGEgc3RydWN0DQo+IHdpdGggZmxhZ3MsIHBvaW50ZXJzIGFuZCBldmVuIGxp
c3RzLg0KPiANCj4+IEVhY2ggc3ViLXN5c3RlbSB1c2VzIGl0J3MgcG9pbnRlciBzbG90IHRvIG1h
bmFnZSBhbnkgYWRkaXRpb25hbA0KPj4gc3RvcmFnZSB0aGF0IGl0IGRlc2lyZXMgdG8gYXR0YWNo
IHRvIHRoZSBpbm9kZS4NCj4gDQo+IEFnYWluLCBhbiBMU00gbWF5IGNob29zZSB0byBkbyBpdCB0
aGF0IHdheSwgYnV0IG1vc3QgZG9uJ3QuDQo+IFNFTGludXggYW5kIFNtYWNrIG5lZWQgZGF0YSBv
biBldmVyeSBpbm9kZS4gSXQgbWFrZXMgbXVjaCBtb3JlIHNlbnNlDQo+IHRvIHB1dCBpdCBkaXJl
Y3RseSBpbiB0aGUgYmxvYiB0aGFuIHRvIGFsbG9jYXRlIGEgc2VwYXJhdGUgY2h1bmsNCj4gZm9y
IGV2ZXJ5IGlub2RlLg0KDQpBRkFJQ1QsIGlfc2VjdXJpdHkgaXMgc29tZWhvdyB1bmlxdWUgaW4g
dGhlIHdheSB0aGF0IGl0cyBzaXplDQppcyBjYWxjdWxhdGVkIGF0IGJvb3QgdGltZS4gSSBndWVz
cyB3ZSB3aWxsIGp1c3Qga2VlcCBtb3N0IExTTQ0KdXNlcnMgYmVoaW5kLiANCg0KPiANCj4+IFRo
aXMgaGFzIHRoZSBvYnZpb3VzIGFkdmFudGFnZSBvZiBPKDEpIGNvc3QgY29tcGxleGl0eSBmb3Ig
YW55DQo+PiBzdWItc3lzdGVtIHRoYXQgd2FudHMgdG8gYWNjZXNzIGl0cyBpbm9kZSBzcGVjaWZp
YyBzdG9yYWdlLg0KPj4gDQo+PiBUaGUgZGlzYWR2YW50YWdlLCBhcyB5b3Ugbm90ZSwgaXMgdGhh
dCBpdCB3YXN0ZXMgbWVtb3J5IGlmIGENCj4+IHN1Yi1zeXN0ZW0gZG9lcyBub3QgZWxlY3QgdG8g
YXR0YWNoIHBlciBpbm9kZSBpbmZvcm1hdGlvbiwgZm9yIGV4YW1wbGUNCj4+IHRoZSB0cmFjaW5n
IGluZnJhc3RydWN0dXJlLg0KPiANCj4gVG8gYmUgY2xlYXIsIHRoYXQgZGlzYWR2YW50YWdlIG9u
bHkgY29tZXMgdXAgaWYgdGhlIHN1Yi1zeXN0ZW0gdXNlcw0KPiBpbm9kZSBkYXRhIG9uIGFuIG9j
Y2FzaW9uYWwgYmFzaXMuIElmIGl0IG5ldmVyIHVzZXMgaW5vZGUgZGF0YSB0aGVyZQ0KPiBpcyBu
byBuZWVkIHRvIGhhdmUgYSBwb2ludGVyIHRvIGl0Lg0KPiANCj4+IFRoaXMgZGlzYWR2YW50YWdl
IGlzIHBhcnJpZWQgYnkgdGhlIGZhY3QgdGhhdCBpdCByZWR1Y2VzIHRoZSBzaXplIG9mDQo+PiB0
aGUgaW5vZGUgcHJvcGVyIGJ5IDI0IGJ5dGVzICg0IHBvaW50ZXJzIGRvd24gdG8gMSkgYW5kIGFs
bG93cyBmdXR1cmUNCj4+IGV4dGVuc2liaWxpdHkgd2l0aG91dCBjb2xsaWRpbmcgd2l0aCB0aGUg
aW50ZXJlc3RzIGFuZCBkZXNpcmVzIG9mIHRoZQ0KPj4gVkZTIG1haW50YWluZXJzLg0KPiANCj4g
WW91J3JlIGFkZGluZyBhIGxldmVsIG9mIGluZGlyZWN0aW9uLiBFdmVuIEkgd291bGQgb2JqZWN0
IGJhc2VkIG9uDQo+IHRoZSBwZXJmb3JtYW5jZSBpbXBhY3QuDQo+IA0KPj4gMi4pIEltcGxlbWVu
dCBrZXkvdmFsdWUgbWFwcGluZyBmb3IgaW5vZGUgc3BlY2lmaWMgc3RvcmFnZS4NCj4+IA0KPj4g
VGhlIGtleSB3b3VsZCBiZSBhIHN1Yi1zeXN0ZW0gc3BlY2lmaWMgbnVtZXJpYyB2YWx1ZSB0aGF0
IHJldHVybnMgYQ0KPj4gcG9pbnRlciB0aGUgc3ViLXN5c3RlbSB1c2VzIHRvIG1hbmFnZSBpdHMg
aW5vZGUgc3BlY2lmaWMgbWVtb3J5IGZvciBhDQo+PiBwYXJ0aWN1bGFyIGlub2RlLg0KPj4gDQo+
PiBBIHBhcnRpY2lwYXRpbmcgc3ViLXN5c3RlbSBpbiB0dXJuIHVzZXMgaXRzIGlkZW50aWZpZXIg
dG8gcmVnaXN0ZXIgYW4NCj4+IGlub2RlIHNwZWNpZmljIHBvaW50ZXIgZm9yIGl0cyBzdWItc3lz
dGVtLg0KPj4gDQo+PiBUaGlzIHN0cmF0ZWd5IGxvc2VzIE8oMSkgbG9va3VwIGNvbXBsZXhpdHkg
YnV0IHJlZHVjZXMgdG90YWwgbWVtb3J5DQo+PiBjb25zdW1wdGlvbiBhbmQgb25seSBpbXBvc2Vz
IG1lbW9yeSBjb3N0cyBmb3IgaW5vZGVzIHdoZW4gYSBzdWItc3lzdGVtDQo+PiBkZXNpcmVzIHRv
IHVzZSBpbm9kZSBzcGVjaWZpYyBzdG9yYWdlLg0KPiANCj4gU0VMaW51eCBhbmQgU21hY2sgdXNl
IGFuIGlub2RlIGJsb2IgZm9yIGV2ZXJ5IGlub2RlLiBUaGUgcGVyZm9ybWFuY2UNCj4gcmVncmVz
c2lvbiBib2dnbGVzIHRoZSBtaW5kLiBOb3QgdG8gbWVudGlvbiB0aGUgYWRkaXRpb25hbCBjb21w
bGV4aXR5DQo+IG9mIG1hbmFnaW5nIHRoZSBtZW1vcnkuDQo+IA0KPj4gQXBwcm9hY2ggMiByZXF1
aXJlcyB0aGUgaW50cm9kdWN0aW9uIG9mIGdlbmVyaWMgaW5mcmFzdHJ1Y3R1cmUgdGhhdA0KPj4g
YWxsb3dzIGFuIGlub2RlJ3Mga2V5L3ZhbHVlIG1hcHBpbmdzIHRvIGJlIGxvY2F0ZWQsIHByZXN1
bWFibHkgYmFzZWQNCj4+IG9uIHRoZSBpbm9kZSdzIHBvaW50ZXIgdmFsdWUuICBXZSBjb3VsZCBw
cm9iYWJseSBqdXN0IHJlc3VycmVjdCB0aGUNCj4+IG9sZCBJTUEgaWludCBjb2RlIGZvciB0aGlz
IHB1cnBvc2UuDQo+PiANCj4+IEluIHRoZSBlbmQgaXQgY29tZXMgZG93biB0byBhIHJhdGhlciBz
dGFuZGFyZCB0cmFkZS1vZmYgaW4gdGhpcw0KPj4gYnVzaW5lc3MsIG1lbW9yeSB2cy4gZXhlY3V0
aW9uIGNvc3QuDQo+PiANCj4+IFdlIHdvdWxkIHBvc2l0IHRoYXQgb3B0aW9uIDIgaXMgdGhlIG9u
bHkgdmlhYmxlIHNjaGVtZSBpZiB0aGUgZGVzaWduDQo+PiBtZXRyaWMgaXMgb3ZlcmFsbCBnb29k
IGZvciB0aGUgTGludXgga2VybmVsIGVjby1zeXN0ZW0uDQo+IA0KPiBOby4gUmVhbGx5LCBuby4g
WW91IG5lZWQgbG9vayBubyBmdXJ0aGVyIHRoYW4gc2VjbWFya3MgdG8gdW5kZXJzdGFuZA0KPiBo
b3cgYSBrZXkgYmFzZWQgYmxvYiBhbGxvY2F0aW9uIHNjaGVtZSBsZWFkcyB0byB0ZWFycy4gS2V5
cyBhcmUgZmluZQ0KPiBpbiB0aGUgY2FzZSB3aGVyZSB1c2Ugb2YgZGF0YSBpcyBzcGFyc2UuIFRo
ZXkgaGF2ZSBubyBwbGFjZSB3aGVuIGRhdGENCj4gdXNlIGlzIHRoZSBub3JtLg0KDQpPVE9ILCBJ
IHRoaW5rIHNvbWUgb24tZGVtYW5kIGtleS12YWx1ZSBzdG9yYWdlIG1ha2VzIHNlbnNlIGZvciBt
YW55IA0Kb3RoZXIgdXNlIGNhc2VzLCBzdWNoIGFzIEJQRiAoTFNNIGFuZCB0cmFjaW5nKSwgZmls
ZSBsb2NrLCBmYW5vdGlmeSwgDQpldGMuIA0KDQpPdmVyYWxsLCBJIHRoaW5rIHdlIGhhdmUgMyB0
eXBlcyBzdG9yYWdlcyBhdHRhY2hlZCB0byBpbm9kZTogDQoNCiAgMS4gRW1iZWRkZWQgaW4gc3Ry
dWN0IGlub2RlLCBnYXRlZCBieSBDT05GSUdfKi4gDQogIDIuIEJlaGluZCBpX3NlY3VyaXR5IChv
ciBtYXliZSBjYWxsIGl0IGEgZGlmZmVyZW50IG5hbWUgaWYgd2UNCiAgICAgY2FuIGZpbmQgb3Ro
ZXIgdXNlcyBmb3IgaXQpLiBUaGUgc2l6ZSBpcyBjYWxjdWxhdGVkIGF0IGJvb3QNCiAgICAgdGlt
ZS4gDQogIDMuIEJlaGluZCBhIGtleS12YWx1ZSBzdG9yYWdlLiANCg0KVG8gZXZhbHVhdGUgdGhl
c2UgY2F0ZWdvcmllcywgd2UgaGF2ZToNCg0KU3BlZWQ6IDEgPiAyID4gMw0KRmxleGliaWxpdHk6
IDMgPiAyID4gMQ0KDQpXZSBkb24ndCByZWFsbHkgaGF2ZSAzIHJpZ2h0IG5vdy4gSSB0aGluayB0
aGUgZGlyZWN0aW9uIGlzIHRvIA0KY3JlYXRlIGl0LiBCUEYgaW5vZGUgc3RvcmFnZSBpcyBhIGtl
eS12YWx1ZSBzdG9yZS4gSWYgd2UgY2FuIA0KZ2V0IGFub3RoZXIgdXNlciBmb3IgMywgaW4gYWRk
aXRpb24gdG8gQlBGIGlub2RlIHN0b3JhZ2UsIGl0DQpzaG91bGQgYmUgYSBuZXQgd2luLiANCg0K
RG9lcyB0aGlzIHNvdW5kIGxpa2UgYSB2aWFibGUgcGF0aCBmb3J3YXJkPw0KDQpUaGFua3MsDQpT
b25nDQoNCg==

