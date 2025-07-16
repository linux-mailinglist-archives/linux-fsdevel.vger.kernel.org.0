Return-Path: <linux-fsdevel+bounces-55182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85ADB07BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009671AA52DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BA2F5C34;
	Wed, 16 Jul 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e8z0j0pE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F4236A73;
	Wed, 16 Jul 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685974; cv=fail; b=mp1c8jOnxOEnXuBLXeUkXhHMdpjSQBLXQ0KlLJC722ZixIw886Qcb+WXdwiPOoKhnGIhVX2yetV2ZGIkhYbucij0Nv4vlXEvohYaYQJJL0lTPT6+DE2iBzoo0UApyuWX9QodVhSgitL4JS3eqx197Xn+1LMi1RutzGChdBtPoFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685974; c=relaxed/simple;
	bh=1iciPr8tfoyxgS1+gHKH6vBA59WU4Owbigz2bWkzo9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MoaP3AUKdchx8Zck/Xq5DqXcZyml30sGpjbTkuWRgjsxHuIkslWKrFD1Luz6gOydx95CJhaBKQF7l6AT7ayp8FbaqbzxAXBXBWzVwJP2t68XenweW71q2MhG9cUYMIuv0eRuh9lY4xlhdgVG0wyRVguYgrPVk0gPHDMrw2Rh1dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e8z0j0pE; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE3MOA009641;
	Wed, 16 Jul 2025 10:12:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=1iciPr8tfoyxgS1+gHKH6vBA59WU4Owbigz2bWkzo9g=; b=
	e8z0j0pEBIFGDgDZOjHNri+ItYqK2ZIfsxddtx43BY39fRR3y19aZvJ1YnAHCmqg
	0dyZEegvvJo9v8a1DjOh3HPA1qt/me9nCBJtBSeZmBG8/DO6NqVzZv+pdp28gKyP
	VcCuben2DIO7ifdbzyNqRvP/V2QPFRwnu0MdrTa9M2ywKwR8/N/dZZRqVDtWjnHN
	OComPzJDDcG6yqohrFX0dk39yTUwkBLDbmCe9o5Mfu2iBQlMt7ZS1bDVTedoQKwc
	FfKJ0U99GR0zcvm4NDt8DpsMrthDBP2K5W+Zu0PTVogFct1Sy702ZMm9262fVCL5
	yE6hyIZuoFmfzuRwHvI+OA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47x71t3wbh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7MoIFqUVkUZ0HfMEGp1zvXCaW/U6+pwenSdo/sCrkIG7b5/zom86Yq9HsbnGFDN4+HJhj/26+7JNSCIuFvXqRPKpzCGZNNUVP2Lo3sG2FtsSjKXPo0LRB7wHble7OSwvVIYnhm90mNhDE/sdo47T1CU6fb1dMhN6C6AuYVgoyOKIfAbD7JiSBL7Oll1N2800AJzFDCiTRSOA5iCpvPPGE3XHRpRBKTqOBQRBGGrrEsLPgQXhzGzgkb14vcf8YhFlRMlbmsjSjfMM4+hpPBgCJL2ow4j30Pzh0e3GrG4njBYlpvD3bgXbOGR1daH0JN4rKf0832iTOYLBAKvwWqcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iciPr8tfoyxgS1+gHKH6vBA59WU4Owbigz2bWkzo9g=;
 b=AKmtccbNbkIjqVh0OJj1z5bAIMItWsL5LGu2ecnZP7k6nw+bkzqCn8EwH+hUmt5siRxvVFyE3C2O4IYT7/jt3nowmT0pV0pOMUhq4ks3rFcdbMliZXHj+FkKPh6aOSvGcuIEYlDD1aXbReumorGUM1fodGWTBgDqbpkX7yV3ADWYp/v0lgE/Us3/hAiLtaPlxbSl5PBGbda0XeO4MMr7cNiTziJAH0aznyI+tNjYdFGEQDLiomANaX0BBEtG+E17qx1MleF/W0RQ+S8tnDyA47akZTvOXGVdTY+oYU3FSfVyOAujIK9bKQOF00nZdeTDuYBe120rgG2PrN6K2WIwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB5917.namprd15.prod.outlook.com (2603:10b6:208:3fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 17:12:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 17:12:46 +0000
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
 AQHb8FzEhXwik4wHVUiG4oVmXX3W0LQpln0AgABShACAAB3hAIABOQAAgABXkYCAARZZAIAAcYcAgAQ3OACAAGuvgIABQIcAgADM74CAAKfAgIAAkXuA
Date: Wed, 16 Jul 2025 17:12:46 +0000
Message-ID: <16736E00-BE43-46D8-8837-BC9F8EF2A5AA@meta.com>
References:
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
 <20250714-ansonsten-shrimps-b4df1566f016@brauner>
 <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>
 <20250715-knattern-hochklassig-ddc27ddd4557@brauner>
 <B2872298-BC9C-4BFD-8C88-CED88E0B7E3A@meta.com>
 <20250716-unsolidarisch-sagst-e70630ddf6b7@brauner>
In-Reply-To: <20250716-unsolidarisch-sagst-e70630ddf6b7@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB5917:EE_
x-ms-office365-filtering-correlation-id: ef3005ab-948b-4ef0-553b-08ddc48bfc31
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDBpbWhFMFprWE9iY1J2L3gzdEdvUU51b2EwVlJPR2MzR1h0SG1kMmEweFZL?=
 =?utf-8?B?cjV3LzNiN0NnMXZsam1nak4vR0VXRkdSa2pXVndnNWk0b1lmMkNCaWxkYjlj?=
 =?utf-8?B?NUFCSDY1elRLVm5OSXlQYlNwNWxueXZ0cEdXNlJzajdkRlZjSkhyL25wTEZ3?=
 =?utf-8?B?MWRpWG1hYy9COENCRGhPZ29ydVRZZi9ERis4ZVNJaThDK3hHaWVxT3gwMkNG?=
 =?utf-8?B?U2dDajZHa200b0hDRVd1dzFqV3hMNVlJVFlBWFR0Z21xNEpxQ3dPNkR4OEZx?=
 =?utf-8?B?Zmx6aHVaL3pIQUgvSjdkdE9HZDAwcEJyQ1EvL2FXaGJIZGVaN1NVUmpyTEFz?=
 =?utf-8?B?cCtYM21TbmNsekdzWXAwOTY1TVZxeUhnY1NnRlBIcWY0Q3NHV1JWb1hCRTBt?=
 =?utf-8?B?ZVo5V3E4U0tsT0Zab1RrSTZzSndxdzNwNmZHNnl1cXpIWU5wK1AvaFlYMWF6?=
 =?utf-8?B?b1QzTzd4UVRhK1cvTXZUVmpZbGgxdVdnbnNSRXBmaTE4WWZxOXRZOHRjMDJV?=
 =?utf-8?B?YU1yR0N5Z3Vuc0hST2ZwRThmdElTK0gvWDN3RWV2S0pFQUhBMFJxc0xZVEYw?=
 =?utf-8?B?S3lJZHRHUzQ1ZEFMM3V2MTRQNkhwWTJtSktidk5wTnFONGwxVlFzWEJSaWFk?=
 =?utf-8?B?eXZVSEUrTGVZQk12UTVxK0ZQaWFCNkxpQmJoQVoxRS9YL2t3VEdHcHd6Tjdp?=
 =?utf-8?B?aVVTdGlGRzlxYk8zK01QSFRrUlc1QUhvUFpjeW9vbUxDbW42VkI2cmovVHlO?=
 =?utf-8?B?U2tXZG9FaGJubEJEY01OTzg4cEZRM2taWGFHZTVPZ3g1bVhIdFc1WnMwSjRk?=
 =?utf-8?B?NnpXWTBBQjVzT29sY0hOdTZxUFRzcXNrOVRkTkRDaHd2eWg1ZndRckdUci82?=
 =?utf-8?B?dThmYzI5aXgweE9aTExkOVpYbjlLZzF2YldHQmllNlAydWZKS3BndEFmNURL?=
 =?utf-8?B?SDNkWVpmbFpqRUlzYlJxdnJuMDFqRVZ4bUlNQm5CUUJQWXg1b3Jhd29EcmZH?=
 =?utf-8?B?YU42ZFQyc2h0ZUNQb2w1U1FtRFRkK09xTnJzVllqaU9GNy9NT05lTXlESEQx?=
 =?utf-8?B?WWE1djAzYXhNVm9Pc09SSnZwTmFkQTZuUWFnK05xd1BkZEkxZGRYVmR6NlZ4?=
 =?utf-8?B?cmtkUnkvRUl1SzFuUmE5cXNzakxIamtPR2pJTXkyU09VNFlMRGtVY0JrMjVU?=
 =?utf-8?B?c2FmNGFmMlFtZHViSHV5TC9JbnhmQXdtdW9hRUNOdjJXRmVZelFNN3ZId0Vy?=
 =?utf-8?B?OW81L08rUUtFL1BJLzBOY3lqRzl4UjU3YjBhV3FCdFovZlZ2ZnE3SnVhWFM3?=
 =?utf-8?B?RHZMY0N1dm1rdnk5SmRBcStUcmx2MXJwL2JqcG1QZFVPcEpOaXVoWWVsU1pp?=
 =?utf-8?B?T3R5ajFQS0xQUE9mK0hxY2JVU0kxeEp4a1dwNXdLWEhnNVdoQ3RwdGxYcHFF?=
 =?utf-8?B?ZFBxR2dsU2hxbWVpd1NyVm9BNVBZRzEyV2h6REttUFdRQWl6dnBrQ3RwNWc2?=
 =?utf-8?B?V3p1OGlWQWtyMTlnMHRaMlh2c091V0p6Umk3SEFNYUg3WWtlNDd4T2xHU3I1?=
 =?utf-8?B?YWhacS8wbnV5M2EzcXR0WGZRVHZNd0xUN2VxdlB3YkcyZEdyWlVmK0FITEhs?=
 =?utf-8?B?SzM3RVNjeG1ycXZ2RzZ2aXFIMXNuT21FV1dMZnJHdFJwYzAzVWkvSUJwRkpC?=
 =?utf-8?B?SXdPbjJwSkFnUVJTcDVXR1Jkc3p3eG41RWJ6OVE0ZjAyMnB1MTlnVUlmYllN?=
 =?utf-8?B?SmpFK09mTGQrUURpN3FoMWRDV2FsQnVjR2ZPbzRFUmMzdmwrWmxmNHNmbDFs?=
 =?utf-8?B?eDRrMHQ3Qkozd1UvTjMzejNFMDd1a1ozRVdVMVM0WmN0RlRaN0g3WnJDdVFL?=
 =?utf-8?B?SUl1L2ZnRWczaGk4RUg1RURhc1hIZ2paYTVVU21PNXczYzcrM1NTcWIweXZk?=
 =?utf-8?B?V1hDcEZBQXlyWk9UV2FzaFhxTk1FdWh2c21Tc2p1OHNwWlFRSzhPOE1DNW0v?=
 =?utf-8?Q?ZJ6faoXTRnq6JDt5p+WyWFdgiQaOIQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdJMFVOc21ZL08wMmNvWkxCYUhjZWc3cElLcnFoVkNEaVFaWittS2ZKUEE0?=
 =?utf-8?B?MlhyTzZaSXppeGFkbldJSnMzWVlZTTJsSXVvVlVnUXAwKzcvaVZmNUoveXBL?=
 =?utf-8?B?K0c2ZU9vYmpMN2NEQk92Tzc3ZmFPK2wxT3Nrc2FKTWF2SE1aSVhWSXBDYjF6?=
 =?utf-8?B?SUxCcTdhOHJLNnFQSzBJNGo3ZFhNRjcvN2lqdnhkTlN4WWZxRXpQYU5nek5U?=
 =?utf-8?B?M3FCemlFUkJ0bTJoREZzNzBDMFo4QzF2cGxhZExkcWZyQVdGd2MwNXpTZkRM?=
 =?utf-8?B?dlpmZmhaNHpNdTBTNUszVXdTc3FYeXRiMzN0ckhHa3hIMXBIR3pFZFBtT1I5?=
 =?utf-8?B?SG10cHYrMncvYmJhUjcycXFuTXBYdGxvTjVkajlBYW5zbEhQL1VjNHhvczY3?=
 =?utf-8?B?R0F6NlRrUlRXQ2o3UndEQi9RcUlMRGtiZnFiODdmMndyZjBOUmdIUDlkY0V2?=
 =?utf-8?B?eTFyNlRMYkp0RUVhbUt5RnlsZXdBY1dycjFkZXhVd21jaHdoZGJvd0pwNTY0?=
 =?utf-8?B?STFHWEVIdEwxZjhEYVlPaFhlcHNwbklQNEhqdXg4N21jc2pwS1lxYTk1VDZY?=
 =?utf-8?B?NEZPWFJ6L1V0ZmpuMk9kTUV0N0Vzc0xrdHFOQWVVd0lKaUg5Mlp2U0dhUVB0?=
 =?utf-8?B?c2JUZmloa1Baa0hsQmdpRnlDYkRDQ3BGMzJzRFM5eFZFSjdKQlJ1WVA4WC9O?=
 =?utf-8?B?b1I1ZnZxRW5heEk5MC9xWmwrbnFhUmYyK01vV1pLSE13aVBXajYxTDdsV2hr?=
 =?utf-8?B?SWEvcWdGUWZGR0ZkUmRXV3R0aTBFVGxMbnlsR0d0VHFIQThnRU5nK1QzS2xj?=
 =?utf-8?B?YmZNZ01QYzkwckpReU9pMnY1SFcrRzJFaUx0b3ViQ1lIVzFxZGpMeENmWGhi?=
 =?utf-8?B?NFhMOFhGWFlqSzFWS0dtczRtcUYyZGI2K0dZRDJObElpUUlxQ0w2MFlZTjQ1?=
 =?utf-8?B?QXpiNFV5OTFuUGROazlaZ3Q1MVlzWlpURVJrZmJVNks1eXZiNzlyR3QxOU5F?=
 =?utf-8?B?RVR5b09wdzR0cW5pRElSaGFwMHArdTUwTGJIYy9pK010S3ppY0UxbC9Mc0ln?=
 =?utf-8?B?akhYNzNPL1NDcysraXA4R01NSWIrZ3BGV2ZYSUxUSFVWd1VwOHRMam55MUJz?=
 =?utf-8?B?aDc3NnVDbDNIQWNlY0FsQmdJbjlYelRRUWlNV01hV001TWVMY05xQmdEYjlG?=
 =?utf-8?B?K05aS1hFZnhhOGVSMnliYjRlajJXcVpyYm54SGdjMmJQTGVIYVhNOUpGLzZN?=
 =?utf-8?B?SVN1M0w5RHpwVzNjdFpsSktEaFREcXphSFV3bzhjVUZTdWVrdGNOWVBiaUhr?=
 =?utf-8?B?RE91UDJ4cDI1V2lGVUNTR1p2cWZuVVRwNjlyeHhZUzhKa0hpWjl5SUFmc0dy?=
 =?utf-8?B?QlVEQkpYRnFFd1VmeFJPZTc5c0swS0dwUmttWHpiZzFaQlpkVFNxVnliTGlC?=
 =?utf-8?B?U3NIZi92MUtneEM4QjlrVWd3OUUxY1Byc2VONHRZNXRwM0Z1TkowWm1GSFRB?=
 =?utf-8?B?Y1JkQTlIOWZwSzcra1R4NlNnRWhqcXhQbFUzUXdDYnArdGN0YVRaUHV3QW1N?=
 =?utf-8?B?cUpxWXBOM2NaZ1FlUkM4SlhpbGo4ZVd6RzZadG9CQ25HTlRHaWt1RHljWVNv?=
 =?utf-8?B?dmdyMkdWYjJQdnRSdFdxMnlxRWhTZnNSdWVLMWlMckc1UUVrZW13Y2p5VG1k?=
 =?utf-8?B?QmJBVThyV3NldXpjSHQrYU5uSGFOMXNjS3A4N1ZIb04zVmY0YnNqOTl6eXhu?=
 =?utf-8?B?c052MUxxV3pRcE1RcGR3Z2oxRzJyOUhiVmE4MjVUQ3R5eFlxN0cyUzlWeDlG?=
 =?utf-8?B?SmxvK3lHS1N2cFRISElreFpoaXU4WW1IQXh3K3o4ZzRqdk1kTTlUbk16RE84?=
 =?utf-8?B?ZG0yemx4aitBL1RyNWZWVTh6cE85VlpGLzhqbDFVMzFsWEZPS2FKNTR0aVlh?=
 =?utf-8?B?SzRSYU83Mmd4QmpnQjRzd3l2anAyeTR2Q20zcnh0SzNYdmt2YjBXd2FGMVpO?=
 =?utf-8?B?Z2g5ZlpoUHh1VE9EbkRSano0SzhWKzUycTZMbkh3OWpTMElLRHRxRGx1NDlV?=
 =?utf-8?B?bEFUM0ZUWXFzQmhhNDJqSDFFNGNENFVHVTBMRXdyL1FOanFyT0lFN3VxRFJI?=
 =?utf-8?B?RVpqd1h5Smo0MWRySXNQTUdHZk9iRmYrLzNZSVRaUE40bHhMWitrQTd6YTM3?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F532AD1C007440468930678700CD2787@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3005ab-948b-4ef0-553b-08ddc48bfc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 17:12:46.6484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C++rWBuO8YFxFuNKova8tgqCpG4iHReo0lK2wPsO2ugUjkCIH4YAtpv+ZofDI+gd8GAd3x0idgq+B9b2Yz5pvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5917
X-Proofpoint-GUID: P7wRo0Dy-654kvWvDDXAGlFOh7OK4a0R
X-Authority-Analysis: v=2.4 cv=V+l90fni c=1 sm=1 tr=0 ts=6877dd93 cx=c_pps a=7NYwoM2WOJnlZ5JcLxGZDA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=hX8BG1DsS7qilViz-KIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NSBTYWx0ZWRfXzWkLA7Wzmfvc Ytm9d2QK71xTceBKM4emSIXcLhKqEs8cXuA5efii8Va+XF7eNxp7SLJbsJrg1WrRJ/l84Hx4p2j D1RCa6VUd4dASV8zSSnpSVRTh+rVP6s2bN6kZUmWyEuGe+pXLdyelPFFJ8wYVGJOL6tUmAKczGs
 GWT0CgtWlrZjPAXlGi3aKrmebOm9U6yilbo2rpHsUu6WopH0dW2PB9RsnG21WNbaK5xiHqwqlXQ 7Zike09jws47x3YLCZcBM9X31V8u0njcB+txEIJqs65hZzZG4B1ahZrraRMDV4UzeN3a2M6vbFm b2q1fUfMPIWGtQRj3ll04oybcKmxsbLRUX1ueSRT/hMa6aHP45CfNiG7u6Zd1Oj5QjpEy9mn86v
 G9swBaWzSIT2qJmjFexK/K5yNYaIoFMnEA9JExphW/X8IFfjC0NrEx34Mtt+Pa0L/kTbiWVA
X-Proofpoint-ORIG-GUID: P7wRo0Dy-654kvWvDDXAGlFOh7OK4a0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

DQoNCj4gT24gSnVsIDE2LCAyMDI1LCBhdCAxOjMx4oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdWwgMTUsIDIwMjUgYXQg
MTA6MzE6MzlQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiANCj4+PiBPbiBKdWwgMTUsIDIw
MjUsIGF0IDM6MTjigK9BTSwgQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDM6MTA6NTdQTSArMDAwMCwgU29u
ZyBMaXUgd3JvdGU6DQo+PiANCj4+IA0KPj4gWy4uLl0NCj4+IA0KPj4+Pj4gSWYgeW91IHBsYWNl
IGEgbmV3IHNlY3VyaXR5IGhvb2sgaW50byBfX2RvX2xvb3BiYWNrKCkgdGhlIG9ubHkgdGhpbmcN
Cj4+Pj4+IHRoYXQgSSdtIG5vdCBleGNpdGVkIGFib3V0IGlzIHRoYXQgd2UncmUgaG9sZGluZyB0
aGUgZ2xvYmFsIG5hbWVzcGFjZQ0KPj4+Pj4gc2VtYXBob3JlIGF0IHRoYXQgcG9pbnQuIEFuZCBJ
IHdhbnQgdG8gaGF2ZSBhcyBsaXR0bGUgTFNNIGhvb2sgY2FsbHMNCj4+Pj4+IHVuZGVyIHRoZSBu
YW1lc3BhY2Ugc2VtYXBob3JlIGFzIHBvc3NpYmxlLg0KPj4+PiANCj4+Pj4gZG9fbG9vcGJhY2so
KSBjaGFuZ2VkIGEgYml0IHNpbmNlIFsxXS4gQnV0IGlmIHdlIHB1dCB0aGUgbmV3IGhvb2sgDQo+
Pj4+IGluIGRvX2xvb3BiYWNrKCkgYmVmb3JlIGxvY2tfbW91bnQoKSwgd2UgZG9u4oCZdCBoYXZl
IHRoZSBwcm9ibGVtIHdpdGgNCj4+Pj4gdGhlIG5hbWVzcGFjZSBzZW1hcGhvcmUsIHJpZ2h0PyBB
bHNvLCB0aGlzIFJGQyBkb2VzbuKAmXQgc2VlbSB0byBoYXZlIA0KPj4+PiB0aGlzIGlzc3VlIGVp
dGhlci4NCj4+PiANCj4+PiBXaGlsZSB0aGUgbW91bnQgaXNuJ3QgbG9ja2VkIGFub3RoZXIgbW91
bnQgY2FuIHN0aWxsIGJlIG1vdW50ZWQgb24gdG9wDQo+Pj4gb2YgaXQuIGxvY2tfbW91bnQoKSB3
aWxsIGRldGVjdCB0aGlzIGFuZCBsb29rdXAgdGhlIHRvcG1vc3QgbW91bnQgYW5kDQo+Pj4gdXNl
IHRoYXQuIElPVywgdGhlIHZhbHVlIG9mIG9sZF9wYXRoLT5tbnQgbWF5IGhhdmUgY2hhbmdlZCBh
ZnRlcg0KPj4+IGxvY2tfbW91bnQoKS4NCj4+IA0KPj4gSSBhbSBwcm9iYWJseSBjb25mdXNlZC4g
RG8geW91IG1lYW4gcGF0aC0+bW50IChpbnN0ZWFkIG9mIG9sZF9wYXRoLT5tbnQpIA0KPj4gbWF5
IGhhdmUgY2hhbmdlZCBhZnRlciBsb2NrX21vdW50KCk/DQo+IA0KPiBJIG1lYW4gdGhlIHRhcmdl
dCBwYXRoLiBJIGZvcmdvdCB0aGF0IHRoZSBjb2RlIHVzZXMgQG9sZF9wYXRoIHRvIG1lYW4NCj4g
dGhlIHNvdXJjZSBwYXRoIG5vdCB0aGUgdGFyZ2V0IHBhdGguIEFuZCB5b3UncmUgaW50ZXJlc3Rl
ZCBpbiB0aGUgc291cmNlDQo+IHBhdGgsIG5vdCB0aGUgdGFyZ2V0IHBhdGguDQoNCkJvdGggc2Vj
dXJpdHlfc2JfbW91bnQgYW5kIHNlY3VyaXR5X21vdmVfbW91bnQgaGFzIHRoZSBvdmVybW91bnQg
aXNzdWUgDQpmb3IgdGFyZ2V0IHBhdGguIA0KDQpbLi4uXQ0KDQo+PiANCj4+IEl0IGFwcGVhcnMg
dG8gbWUgdGhhdCBkb19sb29wYmFjaygpIGhhcyB0aGUgdHJpY2t5IGlzc3VlOg0KPj4gDQo+PiBz
dGF0aWMgaW50IGRvX2xvb3BiYWNrKHN0cnVjdCBwYXRoICpwYXRoLCAuLi4pDQo+PiB7DQo+PiAu
Li4NCj4+IC8qIA0KPj4gKiBwYXRoIG1heSBzdGlsbCBjaGFuZ2UsIHNvIG5vdCBhIGdvb2QgcG9p
bnQgdG8gYWRkDQo+PiAqIHNlY3VyaXR5IGhvb2sgDQo+PiAqLw0KPj4gbXAgPSBsb2NrX21vdW50
KHBhdGgpOw0KPj4gaWYgKElTX0VSUihtcCkpIHsNCj4+IC8qIC4uLiAqLw0KPj4gfQ0KPj4gLyog
DQo+PiAqIG5hbWVzcGFjZV9zZW0gaXMgbG9ja2VkLCBzbyBub3QgYSBnb29kIHBvaW50IHRvIGFk
ZA0KPj4gKiBzZWN1cml0eSBob29rDQo+PiAqLw0KPj4gLi4uDQo+PiB9DQo+PiANCj4+IEJhc2lj
YWxseSwgd2l0aG91dCBtYWpvciB3b3JrIHdpdGggbG9ja2luZywgdGhlcmUgaXMgbm8gZ29vZCAN
Cj4+IHNwb3QgdG8gaW5zZXJ0IGEgc2VjdXJpdHkgaG9vayBpbnRvIGRvX2xvb3BiYWNrKCkuIE9y
LCBtYXliZSANCj4+IHdlIGNhbiBhZGQgYSBob29rIHNvbWV3aGVyZSBpbiBsb2NrX21vdW50KCk/
DQo+IA0KPiBZb3UgY2FuJ3QgcmVhbGx5IGJlY2F1c2UgdGhlIGxvb2t1cF9tbnQoKSBjYWxsIGlu
IGxvY2tfbW91bnQoKSBoYXBwZW5zDQo+IHVuZGVyIHRoZSBuYW1lc3BhY2Ugc2VtYXBob3JlIGFs
cmVhZHkgYW5kIGlmIGl0J3MgdGhlIHRvcG1vc3QgbW91bnQgaXQNCj4gd29uJ3QgYmUgZHJvcHBl
ZCBhZ2FpbiBhbmQgeW91IGNhbid0IGRyb3AgaXQgYWdhaW4gd2l0aG91dCByaXNraW5nDQo+IG92
ZXJtb3VudHMgYWdhaW4uDQoNCldlIHByb2JhYmx5IGhhdmUgdG8gYWNjZXB0IHRoZSBvdmVybW91
bnQgaXNzdWUgZm9yIHNlY3VyaXR5XyBob29rcyANCnRoYXQgY292ZXJzIHRoZSBuZXcgbW91bnQg
QVBJcy4gDQoNCj4gQnV0IGFnYWluLCBhcyBsb25nIGFzIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiB0
aGUgc291cmNlIG1vdW50IHlvdSBzaG91bGQNCj4gYmUgZmluZS4NCg0KRm9yIHRoZSBzb3VyY2Ug
cGF0aCwgd2UgYXJlIGJhY2sgdG8gdGhlIGlzc3VlIHdlIHdhbnQgdG8gYWRkcmVzcyANCmluIHRo
aXMgUkZDOiB0byBnZXQgc3RydWN0IHBhdGggb2YgZGV2X25hbWUgKHNvdXJjZSBwYXRoKSBmb3Ig
YmluZCANCm1vdW50LiBBbW9uZyB0aGVzZSBwcm9wb3NhbHM6DQoNCjEuIEludHJvZHVjZSBicGZf
a2Vybl9wYXRoIGtmdW5jLg0KV2Ugd2lsbCBwcm9iYWJseSBsaW1pdCB0aGlzIGtmdW5jIHRvIG9u
bHkgd29yayBvbiBzZWN1cml0eV9zYl9tb3VudC4NCg0KMi4gQWRkIG5ldyBob29rKHMpLCBzdWNo
IGFzIFsxXS4NClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1zZWN1cml0eS1tb2R1
bGUvMjAyNTAxMTAwMjEwMDguMjcwNDI0Ni0xLWVubGlnaHRlbmVkQGNocm9taXVtLm9yZy8NClRo
aXMgaXMgbm90IGEgY29tcGxldGUgc29sdXRpb24uIEhvd2V2ZXIsIGdpdmVuIHNlY3VyaXR5X3Ni
X21vdW50IA0KYXMtaXMgaGFuZGxlcyBzbyBtYW55IGRpZmZlcmVudCBjYXNlcywgd2Ugd2lsbCBs
aWtlbHkgc3BsaXQgaXQgaW4gDQp0aGUgZnV0dXJlLiBUaGVyZWZvcmUsIHRoaXMgbmV3IGhvb2sg
Y2FuIGJlIGEgcmVhc29uYWJsZSBpbmNyZW1lbnRhbCANCnN0ZXAuIA0KDQozLiBTb21ldGhpbmcg
bGlrZSB0aGlzIHBhdGNoLg0KDQpEb2VzIGFueSBwcm9wb3NhbCBsb29rIGFjY2VwdGFibGU/DQoN
ClRoYW5rcywNClNvbmcNCg0K

