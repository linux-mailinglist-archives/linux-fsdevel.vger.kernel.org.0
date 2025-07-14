Return-Path: <linux-fsdevel+bounces-54865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93160B04314
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D91A641D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067625F7A9;
	Mon, 14 Jul 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UrhvrP1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C125A2C0;
	Mon, 14 Jul 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505896; cv=fail; b=I96LoJEqIq00qqyCO0slqTyu1TFU+Q45DV+0EevXEQhstvnzbVVNtkRE4eKAHTOlllwW+1ER0v9ASLV6HfogaImZW1gJazZAhplKaC7beQypWPEHkQlH1ZGa7qCbxl+uc3b05Jd9ajk1VfrkT4gR9OeeNLEDOdkqgRCPdZtRmZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505896; c=relaxed/simple;
	bh=/y5p4bdHovhPFm1EnM13MIqkQRJo8qYlx7bWCIknmP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ogjqm1sbG0Xf6H4tdG0SA12ON2ghoinqOetwGYuE0P1p6aBfCQjqZ8vh2QsvUJ60U27HDC7lv5VShIUw2kEvVV5NLVaD9BK3UfwZctRFE1BQEdajS/AHcS/Jg8IxhBfMt2jQKbKYlDogmtGX/bo56DBk63JdU+UHk2GjbhjkgKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UrhvrP1d; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E7Tj5B026251;
	Mon, 14 Jul 2025 08:11:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=/y5p4bdHovhPFm1EnM13MIqkQRJo8qYlx7bWCIknmP0=; b=
	UrhvrP1dn+4V4Bk/m3iOfhr2E7PZwPuzeviRlAoFvgweFmd4NzhOAnzUcLoAfOyQ
	/6azYWJWxIwDix22+zojubxwl+NipNFTkGY7JSnvETr7mr/WG/xpVWfPY0YkpEmn
	8KQpkeOG15U503Mvk/aO2qdPATXtPTI4I6iybsGXgMA4oS14eg4bdZq5kjYnFcYg
	sjU/0OiISHNaYzfEq7tMY3KDoishX9SDAZdfCLmrv2Xq7q/DD82TrwAN3JsC2bZu
	gh9eZgc03GTfYelKwSMGvPldaH9qgBQcFK0eLnzAuGbtypfJjbpCHj8KtN3U6nu7
	sX60FIEevkfjhnqGHE0wTA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47vwj2tj66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g55/3ECnMcqNg8ktMPuAdsNGbGKYAfFXEF3/kfBjd7RWJKu+0FyCQI8ZTGiswyRvF3zNKx/R42sNKvd8PzvFpKvGTTNSIKzelTk8XTyfRWBV5n7WRKr22QTJIc3SmVDvp/7DksorYhBWPg5wVa8FKwHvvoxZo9fjpDzBAZ8Nk0O3VS4g7aRl6wWaFVBhc4KkPErAgonUvpfGqiBzrBI6mK8G5XYuZhxC3MxTPvdyBEZP/AkiI/cZnVsnp83LMcoQSWOSonk5FnITKasw46QhgM3EnW4Bx/1lz/XlCMdOQxOM02luqLdlbKfc6SQw7yvezJL7Phuksf/SC9WC4x6Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y5p4bdHovhPFm1EnM13MIqkQRJo8qYlx7bWCIknmP0=;
 b=MikQQvib4g0NM0BdDB9/GyvpkXB7Yy56/WmydJv9+mKUtc9Af2jo4Dy+qVY9X3sKapwAkRooSoecRtPiWjcTlWpL69LT0SQvs/aNHA1OwiPwXL5dHQ/VFzWYPA5ba2rhr435HVB/WkqTaKydi/Dscpk77Q1vjrKV8g3UZmTvmorIMj1DhA36joVD9em9jD1NosCDadUMc/uiyGjwahpAoAN/Vo3/NKf+//D5fH8SWYfZTmAgkpLPXEsvAr2/ux4zEY5TucwLvDy9for5MFGAj0ky1eL0lmOtTwfSGAyhJ/rN79KFUuJf3n97PXJLPbKS+s+x3S+kdSB0XWs0sUf3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4558.namprd15.prod.outlook.com (2603:10b6:510:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:10:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:10:57 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Paul Moore <paul@paul-moore.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Song
 Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>,
        "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>,
        "tomoyo-users_en@lists.sourceforge.net"
	<tomoyo-users_en@lists.sourceforge.net>,
        "tomoyo-users_ja@lists.sourceforge.net"
	<tomoyo-users_ja@lists.sourceforge.net>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org"
	<kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com"
	<repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "m@maowtm.org"
	<m@maowtm.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "john@apparmor.net" <john@apparmor.net>,
        "stephen.smalley.work@gmail.com"
	<stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com"
	<omosnace@redhat.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
        "enlightened@chromium.org" <enlightened@chromium.org>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Thread-Topic: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Thread-Index:
 AQHb8FzEhXwik4wHVUiG4oVmXX3W0LQpln0AgABShACAAB3hAIABOQAAgABXkYCAARZZAIAAcYcAgAQ3OACAAGuvgA==
Date: Mon, 14 Jul 2025 15:10:57 +0000
Message-ID: <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
 <20250714-ansonsten-shrimps-b4df1566f016@brauner>
In-Reply-To: <20250714-ansonsten-shrimps-b4df1566f016@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4558:EE_
x-ms-office365-filtering-correlation-id: 7740013f-3580-4f1a-bc56-08ddc2e8a2f9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alhRY2U2K2xrNVVRSU5IdENNWWlrSXVXSUlDME9OWjhqOVpRUW1PRzJCMDVt?=
 =?utf-8?B?aGtBTlk0RndmZzhuZWw4bXAraFE5cTFNUlhzUlZlYnMyL0tnYmFnalJEa3hN?=
 =?utf-8?B?Wm1CMnRid2puZWxHeFNWVElGNGd6UkRReFo1SmxTTW9aUmh4dGd6bnBnWDJ3?=
 =?utf-8?B?dWVpYTFBRmNmclg1YU94eEhZNm9EU2F6UFJvQnNhYUJDb0RuQVBQSXRmY0NO?=
 =?utf-8?B?eEsyWDB2ZkVybVZxTDZTM3FLaGpTR3FSVWpUaDREQnc1WEFScjlCajNQdFdq?=
 =?utf-8?B?eTQ4WlpRVU5qakJRUU1OajBKeW82QWQ4bEk0dEppZVVyQVlNZU9qK0FSdGNC?=
 =?utf-8?B?RlgrcnFBdWdkZnU2TWkxSnZmZHRJcmFBUlJjUlZZbHhDRDdwci92VFZiaU16?=
 =?utf-8?B?OEl1dEVBRnU1OHpiT2Qya2V3Y3N3TmI3THFyVmNKcTF0cy8wQXk4OEVvbHVH?=
 =?utf-8?B?TFB1MlhzdzJYZVMxMVRuSERRL1hubXJxTGxCRkQ2bkFMNzFqekxOMjlhWlZj?=
 =?utf-8?B?NzAzaUd0dDVCUEhCQ2o2bm5qT0FUK2tJdlFVdTIwWFBHUjFsZlhtMkQ3QkNs?=
 =?utf-8?B?U1Rka3JrRkEyWnFqRFBCV3g4MHpXUmpuWjBrL2xrN0JnNG8ray9vMTIxWG1D?=
 =?utf-8?B?SUN1cDhZY2tUY0dCOEVqUTByOU13bTBiamU0bDlrRWNNcDc3TWo0Z3JLWVQ1?=
 =?utf-8?B?WHF4N0NWQ0NDbVBoM05YVndvR2hTQk04U0EvUWhXR3V3ME5YQmR4YmpVNGQ2?=
 =?utf-8?B?d3NWTkhheFdLMkdXNDVSSHAvaHRNU1o1SGJuQVRBWWlNYkhjaWJINXFTdXdy?=
 =?utf-8?B?bk4wZDIxSUU0L0Z5eDdKMUg0cGsvNERHRjJDR2EwSGdKN0NqblhqMlNhdHpN?=
 =?utf-8?B?Q3Mra0FvSzRETFRXaXFxeUFSUXg5Zk1KRmFrMWtPeHlSWWlyR3NPTFE4bzJC?=
 =?utf-8?B?c1BNTmU4SXBSaDNEajcxQTR2V3piTThtWm1oYU1aeUIxdmROZkk2Vk13YlVV?=
 =?utf-8?B?eUkzMlJiN2pQbHJJVHBUTHM0ZklDSzRxLzB5bStKaDdoVXlZNzBGYmhmODZH?=
 =?utf-8?B?dytOdkhxdXhLSUQ3WUZBMWwwQzlGODUxVXM3Ly9kc2xPUlpKbGRTSitET2pn?=
 =?utf-8?B?TmJVc0dGU2w4YzFrdGk5cjdENHdpcHZZNzVqWndXMTZWVitZUTh4YUV4Zloy?=
 =?utf-8?B?d0F1cnR1YmplL0xqY0JwQTJxR2xHTWoxTVQ3K1JCRU4yQ2JxeVJ6YkNBZ3Bj?=
 =?utf-8?B?L2NCME9OcW9hc2I2S0c5a3ovU3lRY05WNnlMWml0Mk8rN1MzcDBHVEFvYWl0?=
 =?utf-8?B?OHZuSFovZnNsaU1QU2NDOE1XSFhkZUNFTUd1TzF3N3ROT1ZQNFJWWm55RytD?=
 =?utf-8?B?a0E4OGc2TDBmYjJNc2IrQmh3Zy9wM2tLU1JHQTNwQWdNcVVRTTVzb2Jjbk0v?=
 =?utf-8?B?bytzdzBHZkV6VThVd040MkIrdExjU2ZKaDNSNC81d0pWR1AwQm9MaTE3V1hS?=
 =?utf-8?B?cHg0VHNGN0hnd1dYeVNaU0dzRmw0MWlpZlFHQS9OR3pxcUNHRjhmZVRRMVBM?=
 =?utf-8?B?QXlDUE9CWThwQzBiWE50cVBTVm1IZ1UvbG9KZHpEVkVzSlFnRVkvYlZnTEgx?=
 =?utf-8?B?bXFKM3cvTlZnSjZBT2N0S01wZjN0cE1NazFxK3FBcy9jeXFwTVZLM0hnZk9y?=
 =?utf-8?B?aWFBOFRiWG1qMEhpTFR6MDBSU2FrajF6WXROSUs4WFYyWlF2QXl6RklOZUVv?=
 =?utf-8?B?UlduUkF5dlFaZzZOUDQ0aUx6YWg1WVJWa2pHOXVMaEtuSnQzWUtqUFhDL2o5?=
 =?utf-8?B?YUlnMCt0T1BFdlNyTk9rakkvODhad3VvYW50ZlVUWTlYUnRtaEJaZ1FIYkR5?=
 =?utf-8?B?bXBVbW41MlVJbHlER0UxU01HM3QyUnlDVWpGTEN6UWFXN3ExdFZoV20rRWkv?=
 =?utf-8?B?NFQwcXJxNzRrZi93K3NaN3JpVloyQ0NRcWoxTTk1YnE0V3o0dkFKS2JTbjdh?=
 =?utf-8?Q?nUbkwKIQZmaBAxDGGp7uQUhsKvE7fc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mml3d25pYStTenI0UnBwNXVONVNnWkVEZ1JYQTA5dkdvSVB1ZXlVeDhNbStr?=
 =?utf-8?B?TDhQTmkvSVFlKzVxRzlNMkp1bGozMmV1ZU9sdmpTWU93V0pOcmY1QlBVeUVt?=
 =?utf-8?B?ejVCdFBnTkpkRGdwQVBVL2pldUZhV3lYbXRWMmFtdFArSnZBcW1OV1YyWmFK?=
 =?utf-8?B?b1VaRk9OdFRaZklILzB1VzVVRFZ5REd0MlJMUDVvdVo2eXF6NWhYM082Y2ti?=
 =?utf-8?B?RGVxSGZBdzdsQVljcWxaN3kyTUxJSkVHbDFpS0dhL0pTNzVrL00vVDRhRFVl?=
 =?utf-8?B?V1h0djlocGtoVHgvQkYyMFBFUEtVYW1WVXYzYmdabWc1eUJ1elV4WGtvclVk?=
 =?utf-8?B?Z3VxeGFSc05RUGJkbHVWK0ljRWpXMXlEdklMYTlaTWtubDhnSkhMVE8wYUpS?=
 =?utf-8?B?OFBsUE1ESnBLSW1hSFpmV2t6ZE05Z1dSOGxhd28rU3Z1ZEhoM1JNejl6YjUy?=
 =?utf-8?B?YUJublpqa1FkTGJoa1VQeTdNdkg2QWZpQ1pHbjN0U1JRdTJ1cG5lZ3E0ZTM1?=
 =?utf-8?B?eVpYaHNsZkFDeW9sa2sxNWFLTE9CSCtRY1dhNFhNQVFlTWFKTURiQW85TENi?=
 =?utf-8?B?R1lQa0tNMkFRNlRWaVlLN3QzbFFCSldZWEcyZXZvVlo1QjNRaHk4RXBwVXlK?=
 =?utf-8?B?R2NqSFdpNHV4WXJCOU53TkVPMXVnNTRud0FLT1hQMG1WNEJldmtTWVZMd2p4?=
 =?utf-8?B?V1lIbU1KVXNVSmpRazY3WHZOdEVsZXM5OTZvYjFYWC9vWTcrLzh0c3AzdTIx?=
 =?utf-8?B?ZEc2MVhicTFDa3JLQ3h6S0o4L1RLWlJBR0JScGt5ZFVWdmU0THJ1UTNLRzZX?=
 =?utf-8?B?UEJ2WXhCbnNjbWtWT1pkNzZNUUZFMXlYNHVkMHdhdnNlWDA3R2MyUzdLUkY1?=
 =?utf-8?B?N2QyWStFU285d1F3Q3k2YkJNVDcrTXFCUWdJZ1JCU2xMR0dUbHVUR0UyZ0Iz?=
 =?utf-8?B?VFpVYmFRcVZqb1dFTGxpWEE2MlNEZFRPTGorNFg1L1RqaHAvZ2VFNEt4cG8v?=
 =?utf-8?B?VEV4UnpoeFdlYW5vMUlTS1JDdGxHc0JGbHhod3FmekdxQnBEanRvcHpNdXlM?=
 =?utf-8?B?Ukk0bC80TGhmY0M5dFFla2RTQ2xjL3VCNVAyblY3NDBqQkxIZzRuVjhIbXlN?=
 =?utf-8?B?UGcrbDRzQTVQVVZmaEJJbzJtWEdxSkhWaXFUN0t4TlhEM0FhRE9SVGZlUnN0?=
 =?utf-8?B?Z3FUb3hkZGdWbzcxUFVidG1jZUY4dWhRNG9xaHhuUExmdHlVUFdCVlhWelkx?=
 =?utf-8?B?NXF2VGlUVzE4M1EwdmpQSnE2NEhVMVNINmZNWStyNzFaQ3VTQnVyUGZ6U3Ft?=
 =?utf-8?B?VnYwNUU0NWRjRklBbzV2WnBLb3lUMkJySUdvbmVqZ0ZVS2ovZFBqVzNCTmRi?=
 =?utf-8?B?U1U3ZWNZcmV3QXNNTEY1Z2R2MEJVT0k1Ymc2SktOdGhiS0hqMEpwWU52eVZW?=
 =?utf-8?B?OWVCZmJqcXQ5MzJLeGR3c0lwRHRkT2h1ZW5MUG1GUnJ2UStjK3pOT1BxVDRo?=
 =?utf-8?B?b0Zpclc5ZGRxWWlEQzFkQytia2hhMnZNaUgzOFl4SzVoWWgwZUNPQmJCRXF3?=
 =?utf-8?B?UnRvT25kamRUZmpBcllQMFRMQXFSUjlPa0JjYmxHaS9oOUVwUkkyWVN5NkhB?=
 =?utf-8?B?VU1yaUJHb3BlM25UR1F4SGdMQ3BWYndyVHIwWWhmaVNZVUIvQTd1b0NRd1lZ?=
 =?utf-8?B?amtnYlY0KzlmSEU2eFB4SVg5R1JFYmlHUUpuaU5IZWRwaXJZUkkxc2FFUVZl?=
 =?utf-8?B?WjVaR2F0N0hRaFR3aExEQktzRzY2ZFVSRzFteXN4UXJQYjRaWGh1ZGR1V3l3?=
 =?utf-8?B?eUEvcXRmbkM2NFBiQ0d3QVN0dXhhUU01NlUvdFdSY1NxZGJSWGNNZWkyM0FR?=
 =?utf-8?B?ajJXSTI1Wm9oNGMvQ0F1dU5IUEthQU5uK1QrSXZhZnFyQWFQSmJEaU1Demlx?=
 =?utf-8?B?VkZmZS9uMXVCRngvQWRvTjJ5bzFkSEFqbFhzNUp2cjNxeGY2RmQ4cXRzRUJa?=
 =?utf-8?B?RGRiTW1iUlZOMDRsN3ZEK1dkUTB6Rms1SU10b3JjRTVqWkNIUnpzK01DSjI0?=
 =?utf-8?B?OFVVNi9MKzl6YWlvWGlDa1FWelRacW5lYXF2VURUTWxBc3VZRzMzcXNKMysw?=
 =?utf-8?B?MzVvT09BZThYUkJ6TE1PUkNvNDZ2eElkRVhKQWwvdHd0WlZabTVHcDZmL3Yy?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06784F18114050448290F8FB691FDB46@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7740013f-3580-4f1a-bc56-08ddc2e8a2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 15:10:57.8569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUcjdK41kyK7b5HkZ029uadJuSJ2fLNOyRJZiM/TnBKWXg2WWHQV8WfOhn43iZdcspgodArsjp4nn00YmqCYfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4558
X-Proofpoint-GUID: Sk-v55WluYWEw6KiidnwssRDb_h2ZF7G
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=68751e25 cx=c_pps a=NB3Td43k1Dtgf8/5lZavww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=3S8dGYBNvwii6xxlU4EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MCBTYWx0ZWRfX/pbxaEK/ce8o fYKM/PyNz4MH5SLfLARLdHuzgow7/d3/T8sW4zBuvg1FH+cqeqcryr14sExK3v43p+mAbJC/yhl 5WXplrnRoTLnbHNZ5I1vW8Yg3kRQhkrHeovbQrG4qhZPUlU928jz5+gtzAGmiM+KWlYAE/kCC0V
 cYu75RORLlKnpP6cnRrU55HxjAeRmaD9x0MgLoFN/nVs6J7yS708tbLnFkoU+83/2gzE3ykeDrX lqBCa6pRNIgR/aC6O7mZo9LunIKVJ5Zm4JVMSKaISLO1h2Gw4UG3MsoCNtoCIZ5+uCmzigq8i+z 17f4PMtt+bh2AcIWRM14cNDS8d9f+kECT8AkZ99zlZe/TTXVpnFd6nvVM3lY9EQxOPq80oGKMRx
 BSPfPs2S8y1uyEd7FsJx+8UHQ/fq/pNd1ypCi55Aog5Ro1UKQvKn2f+at7IMbLjZ4Dzy9X7q
X-Proofpoint-ORIG-GUID: Sk-v55WluYWEw6KiidnwssRDb_h2ZF7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01

DQoNCj4gT24gSnVsIDE0LCAyMDI1LCBhdCAxOjQ14oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdWwgMTEsIDIwMjUgYXQg
MDQ6MjI6NTJQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEp1bCAx
MSwgMjAyNSwgYXQgMjozNuKAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwu
b3JnPiB3cm90ZToNCj4+IA0KPj4gWy4uLl0NCj4+IA0KPj4+Pj4gDQo+Pj4+IFRvIG1ha2Ugc3Vy
ZSBJIHVuZGVyc3RhbmQgdGhlIGNvbW1lbnQuIEJ5IOKAnG5ldyBtb3VudCBhcGnigJ0sIGRvIHlv
dSBtZWFuIA0KPj4+PiB0aGUgY29kZSBwYXRoIHVuZGVyIGRvX25ld19tb3VudCgpPw0KPj4+IA0K
Pj4+IGZzb3BlbigpDQo+Pj4gZnNjb25maWcoKQ0KPj4+IGZzbW91bnQoKQ0KPj4+IG9wZW5fdHJl
ZSgpDQo+Pj4gb3Blbl90cmVlX2F0dHIoKQ0KPj4+IG1vdmVfbW91bnQoKQ0KPj4+IHN0YXRtb3Vu
dCgpDQo+Pj4gbGlzdG1vdW50KCkNCj4+PiANCj4+PiBJIHRoaW5rIHRoYXQncyBhbGwuDQo+PiAN
Cj4+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24gYW5kIHBvaW50ZXIhDQo+PiANCj4+PiAN
Cj4+Pj4gDQo+Pj4+PiBNeSByZWNvbW1lbmRhdGlvbiBpcyBtYWtlIGEgbGlzdCBvZiBhbGwgdGhl
IGN1cnJlbnRseSBzdXBwb3J0ZWQNCj4+Pj4+IHNlY3VyaXR5XyooKSBob29rcyBpbiB0aGUgbW91
bnQgY29kZSAoSSBjZXJ0YWlubHkgZG9uJ3QgaGF2ZSB0aGVtIGluIG15DQo+Pj4+PiBoZWFkKS4g
RmlndXJlIG91dCB3aGF0IGVhY2ggb2YgdGhlbSBhbGxvdyB0byBtZWRpYXRlIGVmZmVjdGl2ZWx5
IGFuZCBob3cNCj4+Pj4+IHRoZSBjYWxsY2hhaW5zIGFyZSByZWxhdGVkLg0KPj4+Pj4gDQo+Pj4+
PiBUaGVuIG1ha2UgYSBwcm9wb3NhbCBob3cgdG8gcmVwbGFjZSB0aGVtIHdpdGggc29tZXRoaW5n
IHRoYXQgYSkgZG9lc24ndA0KPj4+Pj4gY2F1c2UgcmVncmVzc2lvbnMgd2hpY2ggaXMgcHJvYmFi
bHkgc29tZXRoaW5nIHRoYXQgdGhlIExTTXMgY2FyZSBhYm91dA0KPj4+Pj4gYW5kIGIpIHRoYXQg
Y292ZXJzIHRoZSBuZXcgbW91bnQgQVBJIHN1ZmZpY2llbnRseSB0byBiZSBwcm9wZXJseQ0KPj4+
Pj4gbWVkaWF0ZWQuDQo+Pj4+PiANCj4+Pj4+IEknbGwgaGFwcGlseSByZXZpZXcgcHJvcG9zYWxz
LiBGd2l3LCBJJ20gcHJldHR5IHN1cmUgdGhhdCB0aGlzIGlzDQo+Pj4+PiBzb21ldGhpbmcgdGhh
dCBNaWNrYWVsIGlzIGludGVyZXN0ZWQgaW4gYXMgd2VsbC4NCj4+Pj4gDQo+Pj4+IFNvIHdlIHdp
bGwgY29uc2lkZXIgYSBwcm9wZXIgcmVkZXNpZ24gb2YgTFNNIGhvb2tzIGZvciBtb3VudCBzeXNj
YWxscywgDQo+Pj4+IGJ1dCB3ZSBkbyBub3Qgd2FudCBpbmNyZW1lbnRhbCBpbXByb3ZlbWVudHMg
bGlrZSB0aGlzIG9uZS4gRG8gSSBnZXQgDQo+Pj4+IHRoZSBkaXJlY3Rpb24gcmlnaHQ/DQo+Pj4g
DQo+Pj4gSWYgaW5jcmVtZW50YWwgaXMgd29ya2FibGUgdGhlbiBJIHRoaW5rIHNvIHllcy4gQnV0
IGl0IHdvdWxkIGJlIGdyZWF0IHRvDQo+Pj4gZ2V0IGEgY29uc2lzdGVudCBwaWN0dXJlIG9mIHdo
YXQgcGVvcGxlIHdhbnQvbmVlZC4NCj4+IA0KPj4gSW4gc2hvcnQgdGVybSwgd2Ugd291bGQgbGlr
ZSBhIHdheSB0byBnZXQgc3RydWN0IHBhdGggb2YgZGV2X25hbWUgZm9yICANCj4gDQo+IFlvdSBz
Y2FyZWQgbWUgZm9yIGEgc2Vjb25kLiBCeSAiZGV2X25hbWUiIHlvdSBtZWFuIHRoZSBzb3VyY2Ug
cGF0aC4NCg0KUmlnaHQsIHdlIG5lZWQgdG8gZ2V0IHN0cnVjdCBwYXRoIGZvciB0aGUgc291cmNl
IHBhdGggc3BlY2lmaWVkIGJ5IA0Kc3RyaW5nIOKAnGRldl9uYW1l4oCdLg0KDQo+IA0KPj4gYmlu
ZCBtb3VudC4gQUZBSUNULCB0aGVyZSBhcmUgYSBmZXcgb3B0aW9uczoNCj4+IA0KPj4gMS4gSW50
cm9kdWNlIGJwZl9rZXJuX3BhdGgga2Z1bmMuDQo+PiAyLiBBZGQgbmV3IGhvb2socyksIHN1Y2gg
YXMgWzFdLg0KPj4gMy4gU29tZXRoaW5nIGxpa2UgdGhpcyBwYXRjaC4NCj4+IA0KPj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNlY3VyaXR5LW1vZHVsZS8yMDI1MDExMDAyMTAw
OC4yNzA0MjQ2LTEtZW5saWdodGVuZWRAY2hyb21pdW0ub3JnLyANCj4+IA0KPj4gRG8geW91IHRo
aW5rIHdlIGNhbiBzaGlwIG9uZSBvZiB0aGVtPw0KPiANCj4gSWYgeW91IHBsYWNlIGEgbmV3IHNl
Y3VyaXR5IGhvb2sgaW50byBfX2RvX2xvb3BiYWNrKCkgdGhlIG9ubHkgdGhpbmcNCj4gdGhhdCBJ
J20gbm90IGV4Y2l0ZWQgYWJvdXQgaXMgdGhhdCB3ZSdyZSBob2xkaW5nIHRoZSBnbG9iYWwgbmFt
ZXNwYWNlDQo+IHNlbWFwaG9yZSBhdCB0aGF0IHBvaW50LiBBbmQgSSB3YW50IHRvIGhhdmUgYXMg
bGl0dGxlIExTTSBob29rIGNhbGxzDQo+IHVuZGVyIHRoZSBuYW1lc3BhY2Ugc2VtYXBob3JlIGFz
IHBvc3NpYmxlLg0KDQpkb19sb29wYmFjaygpIGNoYW5nZWQgYSBiaXQgc2luY2UgWzFdLiBCdXQg
aWYgd2UgcHV0IHRoZSBuZXcgaG9vayANCmluIGRvX2xvb3BiYWNrKCkgYmVmb3JlIGxvY2tfbW91
bnQoKSwgd2UgZG9u4oCZdCBoYXZlIHRoZSBwcm9ibGVtIHdpdGgNCnRoZSBuYW1lc3BhY2Ugc2Vt
YXBob3JlLCByaWdodD8gQWxzbywgdGhpcyBSRkMgZG9lc27igJl0IHNlZW0gdG8gaGF2ZSANCnRo
aXMgaXNzdWUgZWl0aGVyLiANCg0KDQo+IElmIHlvdSBoYXZlIDEwMDAgY29udGFpbmVycyBlYWNo
IGNhbGxpbmcgaW50bw0KPiBzZWN1cml0eV9zb21ldGhpbmdfc29tZXRoaW5nX2JpbmRfbW91bnQo
KSBhbmQgdGhlbiB5b3UgZG8geW91ciAid2Fsaw0KPiB1cHdhcmRzIHRvd2FyZHMgdGhlIHJvb3Qg
c3R1ZmYiIGFuZCB0aGF0IHJvb3QgaXMgMTAwMDAwIGRpcmVjdG9yaWVzIGF3YXkNCj4geW91J3Zl
IGludHJvZHVjZWQgYSBwcm9wZXIgRE9TIG9yIGF0IGxlYXN0IGEgc2V2ZXJlIG5ldyBib3R0bGVu
ZWNrIGludG8NCj4gdGhlIHN5c3RlbS4gQW5kIGJlY2F1c2Ugb2YgbW91bnQgbmFtZXNwYWNlIHBy
b3BhZ2F0aW9uIHRoYXQgbmVlZHMgdG8gYmUNCj4gc2VyaWFsaXplZCBhY3Jvc3MgYWxsIG1vdW50
IG5hbWVzcGFjZXMgdGhlIG5hbWVzcGFjZSBzZW1hcGhvcmUgaXNuJ3QNCj4gc29tZXRoaW5nIHdl
IGNhbiBqdXN0IG1hc3NhZ2UgYXdheS4NCg0KQUZBSUNULCBhIHBvb3JseSBkZXNpZ25lZCBMU00g
Y2FuIGVhc2lseSBEb1MgYSBzeXN0ZW0uIFRoZXJlZm9yZSwgSSANCmRvbuKAmXQgdGhpbmsgd2Ug
bmVlZCB0byBvdmVydGhpbmsgYWJvdXQgYSBMU00gaGVscGVyIGNhdXNpbmcgRG9TIGluIA0Kc29t
ZSBzcGVjaWFsIHNjZW5hcmlvcy4gVGhlIG93bmVyIG9mIHRoZSBMU00sIGVpdGhlciBidWlsdC1p
biBMU00gb3IgDQpCUEYgTFNNLCBuZWVkIHRvIGJlIGF3YXJlIG9mIHN1Y2ggcmlza3MgYW5kIGRl
c2lnbiB0aGUgTFNNIHJ1bGVzIA0KcHJvcGVybHkgdG8gYXZvaWQgRG9TIHJpc2tzLiBGb3IgZXhh
bXBsZSwgaWYgdGhlIHBhdGggdHJlZSBpcyByZWFsbHkgDQpkZWVwLCB0aGUgTFNNIG1heSBkZWNp
ZGUgdG8gYmxvY2sgdGhlIG1vdW50IGFmdGVyIHdhbGtpbmcgYSBwcmVzZXQgDQpudW1iZXIgb2Yg
c3RlcHMuIA0KDQpUaGFua3MsDQpTb25nDQoNCg0K

