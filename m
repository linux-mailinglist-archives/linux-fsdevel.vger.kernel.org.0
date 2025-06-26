Return-Path: <linux-fsdevel+bounces-53098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCAAEA1AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7694B3B0522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94B2F3C0A;
	Thu, 26 Jun 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eGZnQhBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762628934F;
	Thu, 26 Jun 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949370; cv=fail; b=m8mXiuPjSKQf09ok6ZqqVPHPBbca3KCe6qi5uhmXRbmi3bbE/WrTg9SUN+sKWfdC568v0OZgzw01Yv4d7aBpMszkaPa5wWYyc/dmAz/XETdWfSvmQgJ7BlF9yUZ0QPHC8IY1p0XCkNZ+1oVV6vhAmQ3cCKnvDvqJ++MCMhCGUq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949370; c=relaxed/simple;
	bh=BiDTZvFzRyGNqn5YYQvS2BvItHilHggVKHcy8HS0D4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evNvr/YBg72mSLHPLZhl11Vm781wauPQmG7yK7bW/37akrCmebFiY3LahRbGUxpw3Bcuz2wJysdi96DDrpdnApfVKGzQ71us8Hg19d/DhbLC5PZj1HSych2Qj5ge2/g447grvVg8XMGISV+Lv8Ae3CzyO0G/UUu1veI1plvWFFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eGZnQhBR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCVvxL023727;
	Thu, 26 Jun 2025 07:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=BiDTZvFzRyGNqn5YYQvS2BvItHilHggVKHcy8HS0D4k=; b=
	eGZnQhBRaIgNfuOHKA6BJyTC7UHijzqumUXHXaABPUOZEK3v3bqG7UijSicmBiEl
	H/3VG6xrulT8S+HazT8961mKEhVEchag60AL8C76fu091HqKT8x+oxAIijKyGBgC
	s4HaS3HHnzqxvGRQcCAFjPGnS92Qf3k4xsBOVq3oiVkiUeokG+1YwlmmaYEA/6wA
	8CjpgVZvhFQRHPCGzbLD5HDdtghCNGTHWzXoAcN7H8GOWch0+TrKwk8t+wFEOIBz
	YO0nCtvTBGUTQsbdzFal8l/De4l5g6ZWSWwNCvE8aVfljvE2ESloi1M/RYcWVoSf
	IbcYZ4JQxoom6wZ3sEBuvA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47h17kap08-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 07:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNuYHc1G87daMNPG9COYrjXTCnJ5lgvvj3mmS032CU4XEuHYV34KaZnRg3QzEiZ+5TN/5SnxEXOPOtNtgoJZJAzsOJkb7IDDubY3VasXrT0vf+s54goDrHLKhKK6V2fm+Ya6rQU+11AMsBtj3pEDlesGjHD5gUh8IUBnmS6mZAkJ8oPPAov5t4zN53gwg+vZR1qfCNEvTSD5tnKaMT9dG3mNMJQ7f/4wK7Ajwb4V27XfH6Ry8nhT1lO/+Ga4CyYCRN+4y7yiVsPLHqEeuo/+tTOUx7uAfONDbesYJ1LgeM9VO60rILZAfm7I0KOQNurBHsHEaDKn6+FrRCndfL7GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiDTZvFzRyGNqn5YYQvS2BvItHilHggVKHcy8HS0D4k=;
 b=JS7pdK07ywEKjbWE4FTxRrJEomlzP6/w0j6bwcUd/Y6jOKaGHOUopd5IVcssi+lkuIWkxt+FtTLGDUms7uHtO7cSoJB5NvFJ2ty5nViBbSVuzHSQ4mrAKzqzUgJtqzfcPjTREU1t/4/E8qfx5eFup4+MMv6qSlp3zQdSsl58jP2icOXQ/QmhKr9vT9GrbZcEQbU+7ichx8/yR7V4F9RvMa5o2y9RS3CqL1mV/gTyVLSilMCl2+7rmrdNahkHM0pmXryShsGQsGuAPbgW4fYQfdJbZ1bHaPBkskQfBaMRF7PBxZSo2aWKgfx+8QI+P3JS+TlFDculqKdtWUg8cuV4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA0PR15MB3822.namprd15.prod.outlook.com (2603:10b6:806:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 14:49:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 14:49:22 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: NeilBrown <neil@brown.name>, Tingmao Wang <m@maowtm.org>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAECLgIAAVVMA
Date: Thu, 26 Jun 2025 14:49:22 +0000
Message-ID: <9F86B62C-0B79-4907-8A20-AE72E7EA2AEC@meta.com>
References: <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
 <175089992300.2280845.10831299451925894203@noble.neil.brown.name>
 <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
 <20250626.eifo4iChohWo@digikod.net>
In-Reply-To: <20250626.eifo4iChohWo@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA0PR15MB3822:EE_
x-ms-office365-filtering-correlation-id: 8ecbbb60-fada-4d4e-a71b-08ddb4c0a3ac
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enZKWTE1dVhnek0rQWhPeVFXTzlZQ0pYTUdSMmxYNVRWbzMzY0orTit1eTFF?=
 =?utf-8?B?R01Bb05MTjhZSWVLTnlBeXhtUGlTQVhVaFBxaHZLUnpaSjFEbUFIRmxHS0tH?=
 =?utf-8?B?amRNQlIybFVacmxOOTBaZW5GYm8vcHp5dExCRkJqYkk3MnFEc09SMWZoK2N5?=
 =?utf-8?B?MmtFb0VYSlRBUHpGRWlWaGUxVXFCVnpZdmthVUtZK2pqZmtMdHErdWdhSnlE?=
 =?utf-8?B?YjVGdDVKMlJaV1ptd1c1d29nL1dQb2ZTZDRLYnFZOHI1clhSTkQzd0ZwVlFI?=
 =?utf-8?B?N3JpRmdjekdnTHV4d1ZKTjJMZGdaMVdiY3dZc1lDNW5Ob0M0c1JWV2JpTE9s?=
 =?utf-8?B?c1NlWlNlV2UxN1hZVSszdWJYWXlMRE8vNExiRERDZ01TdndYdUtLMC9mL3J1?=
 =?utf-8?B?MGN2VVIwWUkwV3EzejVURFRnaEpKT2xzQlRobURMWjQzRzBHeVF0SGpPRDFK?=
 =?utf-8?B?TWpsVlEvWFJRTlcreTVwa21KdUhYZHZFWFoyWU5OeENoS1lvY3dlTFdzZzc2?=
 =?utf-8?B?eHlqOWsvSG1DUmVPU09VOVFZUVBpTVJiMTRHVHBRTkVhUk9LY295UVhTZFJq?=
 =?utf-8?B?OTlEdWkzcjhNSVo4RUpVNzdqY2tVNWtpcGF1ZnNwT1NVdjNKczBOU1E0ZWRY?=
 =?utf-8?B?V0hyY0xVRFVuWGN0SWNQWHRZNktoV0VRQ1F2YjVraU9ZRHArYkdhbUVmdGhW?=
 =?utf-8?B?eFQ5YmxnZTV1MVUrTlJXWUpVZ0dsVkwzWm5BS2ZaQVJSaTRneSs4QnJDaENa?=
 =?utf-8?B?MXpmTTlzanlrQ21xa3hNcDFNWTl1aTlTdFo5ZE9JcVZMY1N3TlVwLzVMTGcv?=
 =?utf-8?B?dmdtL2RQUjh6cS8xN0cyMDYvVDR2UTRZOHJYZkZkV21IZVJpVzd6VER4cnB1?=
 =?utf-8?B?bHpMb0NNQzZQcjVWN1JoZzJYZ0RpQUFVTWVjWFFCQkRFclZ6RGd6UzVlWG5X?=
 =?utf-8?B?RzJRM3V1ak1RRFlVbEtMN1o4UTBNaGw2YXlObTB4VkJxMVZYcWh6N2NYVlRM?=
 =?utf-8?B?UFdxeE52clEycVNzMGswTk16RnJQQkljUWVxYlg3WmhjVW82OGZYMDJBMFRH?=
 =?utf-8?B?QTFob0x6c3J1T3B0c0NaL0F2Q1p4V1huUm41bXBYL05YSlR2UzZnOUhmZmdy?=
 =?utf-8?B?ZCtNanF6YUtHYU9ZYlhRdTJuTC9ZWnV4bGhvWWtTZERRMk9OOWlJT09xK3BY?=
 =?utf-8?B?ZmdVOXRPU2VsYW9BV2k1Ui85RjRUL2szR081Rk1nQUtOalNNV092UWZqRW5a?=
 =?utf-8?B?RjZ1azBDVDA4dVh3Vk5sRlZDaDZHMWVGTUE4d1EyZ3lPZ3ZiSXQ1QlBoQWdy?=
 =?utf-8?B?WERtNFVKYnZLd0ZLUkRkVmx3dG9nVUFlVERwUDQrWWRMTWtHNWpieXdKdG1K?=
 =?utf-8?B?NG9zNmpVbTQ5Q0NRdTlJSTM2T09hVTNvdVFzR29KOVNIMDAzK0VkYmNtWlZU?=
 =?utf-8?B?Wm1pNm5SZk1pUUlQckMxMXk5VEp3NnFITkdMTWtWWW9UTEdXVXpFaFE1ajh5?=
 =?utf-8?B?UGJUOVVGWFQ0UjE4UzVMSUxybS9HYVhlQ1F3WWVTcERmUitOVUZ4NXFTODVm?=
 =?utf-8?B?WXppL29Xa3Y4MTFpZzJNejFqU3JMcHU3OUlZcmRDcEtxOGhVOEhkSnI1MExE?=
 =?utf-8?B?YS9PMTNWM0dBcEllcUFZNmVNcU1NeEk0SWZDR3BYOVhxUXZVUG1ZN3Z4c2Fn?=
 =?utf-8?B?d2xEOWdOZy9VRnlMZnlaSGtXZTRHVDlrRnphUFgzemE0NmMrS1E3bXd2Z1hN?=
 =?utf-8?B?NUN2TlVWazBNQ0JHakJRTnlQcDNTNnhsR1V0K1cxUmVteUNyemtwM3BBWW5s?=
 =?utf-8?B?cWI5MmFldDdseVlXbmVnV0tiSUd6VkErbGdBVXhYSExMOEp6ZllTTkdXekR6?=
 =?utf-8?B?N1ZHaWlJMCtEcGg4ZTZCaG1jRk5vNFkydzVlWTRTTFNzeUlvb29iVURqU01W?=
 =?utf-8?B?Q0hxbkVtanBuaEJlN0V4MDFWS1hrR05rZlpTendyS1dEQUlJeVBPUW1ObDNr?=
 =?utf-8?B?NnNsZGhEVWNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tm9RRkI0MUhoWUJHMW9IdDY5T1g3N013N2lvNUxTRFQ2VmgvUzBRaUFDVTlR?=
 =?utf-8?B?QmNPTVhQS0FwdSt6QUhPNzI0SXFWRXlVeEczeExqM1FhSUFpenBMZVZVV2hz?=
 =?utf-8?B?UllDbUtPL2pnT3VqNDhLZlBkOGQ1STIzblovaC9vWU9BZXZ6eTNFQVR3Wkd6?=
 =?utf-8?B?azcvVDRMajlOd0d0NldwNWlKZ2kvTitXS0hTMXJPcWlYRmM4ajhqeXVyVVFx?=
 =?utf-8?B?QlFWWm5oc2hIM2JMazJxeFZXZHhoSUlMQ0R3RnpRdWR0Z1JyS0w1emg0RzJU?=
 =?utf-8?B?ZUZmUCtsdmFEcmV1bHdidWJsZ1lOZUNYQUV4cnBrakoyT1lUbmc0blZWSGJ4?=
 =?utf-8?B?KzlHMG9mY2JoTXRwZU1rYk9STEtKdFpPVUUrbVFCd21hQ0tHWlVONnVyMitt?=
 =?utf-8?B?V1ZMVm9jNFhLN3BZMG9CQ3ExYjFYWmhKYlhaN3FXMFZHdlBHYSt3MHQ5dnRY?=
 =?utf-8?B?M0gzckY4QjBuV04zK0c1TmNKaTNjM2FLVFNmVFE5amE3cHJoS1QwbzhzYTJt?=
 =?utf-8?B?NVMrUExrem44MTc1aTFoMmhKWGhUa0NnQVo3WmlSZ3BzWk1MRjZvTERWc3I5?=
 =?utf-8?B?UU9VMVlQWitjdCs0NkpKdlRtMTJFYSszNFNhUlFHVU03Und3Z2h2d0EvVWNG?=
 =?utf-8?B?eURGazZyd0Nkb3VkWnRUOVR5c3ZocTFMek9BWEFaL2oyZ3daUnNIMzZ6Tlk4?=
 =?utf-8?B?bWNNMTVNdlN2UVIzcWswSkRrVXk4ckl5VVRuT1lhUmx2eDNHYkxXQ1NFTnE3?=
 =?utf-8?B?SHg0L2xJUlBva1U0ekJkMEt0cEoweWxEV3NqN0lNSXliNEk3N3VRSWcwY1Zv?=
 =?utf-8?B?TUtRNnY5bEp2SzZtMndtVUYvekxoNnlySU5qMytZTUR6SHV3eVlsM1JuWWpD?=
 =?utf-8?B?UGM0eDFMc2JPcFlBZklmSjJ1SGZMTG9GK3VQTTJ0aUdhUkQreU0xaFRVNFlo?=
 =?utf-8?B?RUN1VzhwSmZJWktGNG1Yb0lVWlJvQ3ErdmVIVjdPYm1qUWw4aEtUQ3dzcTF4?=
 =?utf-8?B?YkZ4ZndQeUFaQ1Z5SFVhcmx3WFoyQ0hjeUxHVTd1QStCclg4c2pTMk8vemR2?=
 =?utf-8?B?eTNHcGtadkpWOGVVOHF1T0U2UzdZWnlGdTR4SlVGWnVWeklBejlkdkRRcCtH?=
 =?utf-8?B?V1BaUlJVRVhZT1hwOTdYczVEbS83ZTNRSkprZjlqa1VZQkx0cWdCTEk3SDVN?=
 =?utf-8?B?cVJua3MxU2U1bWNDNFlKaG83RTdxQXQwZ2lFeCtXMndiQWQzVUJJb3pvZ1NU?=
 =?utf-8?B?SjdSRThmZGVONFNxbVdBTEk5Mmlhc3NnYjZFWWQ4RW01Z2xwRFJuYnF1V0sv?=
 =?utf-8?B?a0NmOTM4cjNLa3R6Z3BzeFVhY09kSDF4ZWVCdVZrTWtuYmJrbG8rdURwbEkx?=
 =?utf-8?B?TnpaUTVmWHd4NzVka3N5YTZZQzZuRnpST2hYSDh4SFk2V215bW1KT1JmSCth?=
 =?utf-8?B?MUpReVNMaUI3Q3hpcVJqZEI5QzArYU5KRE9hd0JteWxEMXkyeUVua3Y3enhS?=
 =?utf-8?B?VkhwTGcvVTV3c2piRUFON2daYnUxSFk0MG5PTTRlZUpvdlN1R0F0eWJqMzgr?=
 =?utf-8?B?eGpla3o4M2dyeGZzV1BxSFE2TFk4a1hIdXZHUzZ2TzlLdFhZS3VNWVlKcFpD?=
 =?utf-8?B?VlFOWHVWbFVQRHRCVFdCbjFLcURiZlJ5cjJLbmx3TWlJTjdlajRIRHJLMHJ3?=
 =?utf-8?B?T0FUMWNLT1h3ZlR5NS9ZTzRNby9YQlNWbDVYYzI4T25VZ0V0bWkxRjMxTVRN?=
 =?utf-8?B?cmw5QzY2QXZYbVNCbStwTjlQVytuQ1dvZkc3RXZRVHZNNFp6aHlldGNscS9k?=
 =?utf-8?B?SjdDSC8wVmFTbXEzZU5MMXBZVGZOQkF1bFlGRkhuY0YxQVFjMmc2TkYrUnRa?=
 =?utf-8?B?YWx3R1RiT2FGZ0JJVndIWWEyU0I4dS9aUDQrTWJ0OWFic0daQnhUZ1psTlQ2?=
 =?utf-8?B?SzJLZER5SmN3WnE5OGpLeGZYQjdsNjlFREdkYUwxNnF4dlFEZ0lteFJqWXNa?=
 =?utf-8?B?aFR0cjJFWGs0VFYwVUxVLzl4VDJQd09zWFBVczhiUlhxZUpUMmc5QnZPMm10?=
 =?utf-8?B?WXFBVUJVNi9SaXVPSWQ4QTVhYW8vWUNyTEFFVUIzR0JRcEFOWUZ4b1NpS1Ix?=
 =?utf-8?B?cGFIdHcvOUQ4L29qVnFjL1BFTUIyOVdkSXRRRzBEajNCeUt0TXRnNmFpek41?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06DBB69DD80F314AA9691014818DE88E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecbbb60-fada-4d4e-a71b-08ddb4c0a3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 14:49:22.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onkmcoBI3n5OE+kn+loVXCm5CpZmjW2a+ZEpZh73RggpakXRiMlWsOSp07xopvHN5e1qN9HsrviRSV76vJEMPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3822
X-Proofpoint-GUID: 88cQjBiLSgr2HyLpwErNoJxG8JCO_i6f
X-Proofpoint-ORIG-GUID: 88cQjBiLSgr2HyLpwErNoJxG8JCO_i6f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyNSBTYWx0ZWRfX9np7lBANZ67x Pl4vCSoITiRZfiRIQmAqbzoqI56qpezf5resRJTVv/WUP0UNjsBSITnqC5RmgoMWMyKrIPX8mUy kHvIlc41QLqxLNgnilJ4wQPp9sFck/UFAQB7pbSQjtTxYf/l3hZB6sIFTbpwOBhxjq71aHZhijO
 W+3vKue3iDyySMK4Ab33r3SF32TCVx71Vb4sTwXIP1wV0lEB1CjDaOjTH7VHq+jyRXViAOrNU2S KB0LlFykYjacyYpI5+LKXfTabe4d081OfGR9Ts9liEADDwNUMPsDwPACuCWyQ7jPLF3OH4dirb4 T8BCFlh+XA4bs15+3yhVRQN1l5RkdxHOgfdeOJid3I8sbzHrSOh/XlVAgrlnq/uW0ufwq6Oj5Vx
 +YOK7OyzQy0mNffvYlBcg3Qh9dvbQCx3j6tIupF5VV1U2DNfR83ZzmqrC6X5IYP5nEHtljVW
X-Authority-Analysis: v=2.4 cv=ZPbXmW7b c=1 sm=1 tr=0 ts=685d5df7 cx=c_pps a=IJCR/EF/EmeNJoyCY0s/cQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=edGIuiaXAAAA:8 a=9JFPn0wZ9dLBMa5FsWMA:9 a=QEXdDO2ut3YA:10 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01

DQoNCj4gT24gSnVuIDI2LCAyMDI1LCBhdCAyOjQz4oCvQU0sIE1pY2thw6tsIFNhbGHDvG4gPG1p
Y0BkaWdpa29kLm5ldD4gd3JvdGU6DQoNClsuLi5dDQoNCj4gR2l2ZW4gdGhlIGNvbnN0cmFpbnRz
IHRoaXMgbG9va3MgZ29vZCB0byBtZS4gIEhlcmUgaXMgYW4gdXBkYXRlZCBBUEkNCj4gd2l0aCB0
d28gZXh0cmEgY29uc3RzLCBhbiB1cGRhdGVkIHdhbGtfY2IoKSBzaWduYXR1cmUsIGFuZCBhIG5l
dw0KPiAiZmxhZ3MiIGFuZCB3aXRob3V0IEByb290Og0KPiANCj4gaW50IHZmc193YWxrX2FuY2Vz
dG9ycyhzdHJ1Y3QgcGF0aCAqcGF0aCwNCj4gICAgICAgICAgICAgICAgICAgICAgIGJvb2wgKCp3
YWxrX2NiKShjb25zdCBzdHJ1Y3QgcGF0aCAqYW5jZXN0b3IsIHZvaWQgKmRhdGEpLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgaW50IGZsYWdzKQ0KPiANCj4gVGhlIHdhbGsg
Y29udGludWUgd2hpbGUgd2Fsa19jYigpIHJldHVybnMgdHJ1ZS4gIHdhbGtfY2IoKSBjYW4gdGhl
bg0KPiBjaGVjayBpZiBAYW5jZXN0b3IgaXMgZXF1YWwgdG8gYSBAcm9vdCwgb3Igb3RoZXIgcHJv
cGVydGllcy4gIFRoZQ0KPiB3YWxrX2NiKCkgcmV0dXJuIHZhbHVlIChpZiBub3QgYm9vbCkgc2hv
dWxkIG5vdCBiZSByZXR1cm5lZCBieQ0KPiB2ZnNfd2Fsa19hbmNlc3RvcnMoKSBiZWNhdXNlIGEg
d2FsayBzdG9wIGRvZXNuJ3QgbWVhbiBhbiBlcnJvci4NCj4gDQo+IEBwYXRoIHdvdWxkIGJlIHVw
ZGF0ZWQgd2l0aCBsYXRlc3QgYW5jZXN0b3IgcGF0aCAoZS5nLiBAcm9vdCkuDQo+IEBmbGFncyBj
b3VsZCBjb250YWluIExPT0tVUF9SQ1Ugb3Igbm90LCB3aGljaCBlbmFibGVzIHVzIHRvIGhhdmUN
Cj4gd2Fsa19jYigpIG5vdC1SQ1UgY29tcGF0aWJsZS4NCj4gDQo+IFdoZW4gcGFzc2luZyBMT09L
VVBfUkNVLCBpZiB0aGUgZmlyc3QgY2FsbCB0byB2ZnNfd2Fsa19hbmNlc3RvcnMoKQ0KPiBmYWls
ZWQgd2l0aCAtRUNISUxELCB0aGUgY2FsbGVyIGNhbiByZXN0YXJ0IHRoZSB3YWxrIGJ5IGNhbGxp
bmcNCj4gdmZzX3dhbGtfYW5jZXN0b3JzKCkgYWdhaW4gYnV0IHdpdGhvdXQgTE9PS1VQX1JDVS4N
Cg0KSUlVQywgTmVpbCBpcyBhZ2FpbnN0IHVzaW5nIExPT0tVUF9SQ1UgYXMgaW5wdXQsIGFuZCBW
RlMgZm9sa3MNCm1heSBzaGFyZSBzYW1lIHRoZSBjb25jZXJucy4gDQoNCj4+IA0KPj4gSSBndWVz
cyBJIG1pc3VuZGVyc3Rvb2QgdGhlIHByb3Bvc2FsIG9mIHZmc193YWxrX2FuY2VzdG9ycygpIA0K
Pj4gaW5pdGlhbGx5LCBzbyBzb21lIGNsYXJpZmljYXRpb246DQo+PiANCj4+IEkgdGhpbmsgdmZz
X3dhbGtfYW5jZXN0b3JzKCkgaXMgZ29vZCBmb3IgdGhlIHJjdS13YWxrLCBhbmQgc29tZSANCj4+
IHJjdS10aGVuLXJlZi13YWxrLiBIb3dldmVyLCBJIGRvbuKAmXQgdGhpbmsgaXQgZml0cyBhbGwg
dXNlIGNhc2VzLiANCj4+IEEgcmVsaWFibGUgc3RlcC1ieS1zdGVwIHJlZi13YWxrLCBsaWtlIHRo
aXMgc2V0LCB3b3JrcyB3ZWxsIHdpdGggDQo+PiBCUEYsIGFuZCB3ZSB3YW50IHRvIGtlZXAgaXQu
DQo+IA0KPiBUaGUgYWJvdmUgdXBkYXRlZCBBUEkgc2hvdWxkIHdvcmsgZm9yIGJvdGggdXNlIGNh
c2VzOiBpZiB0aGUgY2FsbGVyIHdhbnRzDQo+IHRvIHdhbGsgb25seSBvbmUgbGV2ZWwsIHdhbGtf
Y2IoKSBjYW4ganVzdCBhbHdheXMgcmV0dXJuIGZhbHNlIChhbmQNCj4gcG90ZW50aWFsbHkgc2F2
ZSB0aGF0IGl0IHdhcyBjYWxsZWQpIGFuZCB0aGVuIHN0b3AgdGhlIHdhbGsgdGhlIGZpcnN0DQo+
IHRpbWUgaXQgaXMgY2FsbGVkLiAgVGhpcyBtYWtlcyBpdCBwb3NzaWJsZSB0byB3cml0ZSBhbiBl
QlBGIGhlbHBlciB3aXRoDQo+IHRoZSBzYW1lIEFQSSBhcyBwYXRoX3dhbGtfcGFyZW50KCksIHdo
aWxlIG1ha2luZyB0aGUga2VybmVsIEFQSSBtb3JlDQo+IGZsZXhpYmxlLg0KDQpJIGRvbuKAmXQg
dGhpbmsgdGhpcyB3aWxsIGJlIHRoZSBzYW1lLiBDdXJyZW50IHBhdGhfd2Fsa19wYXJlbnQoKSAN
CmhvbGRzIGEgcmVmZXJlbmNlIG9uIHBhcmVudCBwYXRoLCBhbmQgcmV0dXJucyBjb250cm9sIHRv
IHRoZSBjYWxsZXIuIA0KSG93ZXZlciwgd2hlbiB2ZnNfd2Fsa19hbmNlc3RvcnMoKSByZXR1cm5z
LCBpdCBzaG91bGQgbm90IGhvbGQgYW55DQpleHRyYSByZWZlcmVuY2UsIHJpZ2h0PyBJT1csIHZm
c193YWxrX2FuY2VzdG9ycyBtYXkgaG9sZCBzb21lIA0KcmVmZXJlbmNlIGJldHdlZW4gY2FsbGJh
Y2tzLCBidXQgaXMgZXhwZWN0ZWQgdG8gcmVsZWFzZSB0aGVzZSANCnJlZmVyZW5jZXMgYmVmb3Jl
IGZpbmFsbHkgcmV0dXJuaW5nIHRvIHRoZSBjYWxsZXIuDQoNCj4gQ2FuIHdlIHNoaXAgdGhpcyBz
ZXQgYXMtaXMgKG9yIGFmdGVyIGZpeGluZyB0aGUgY29tbWVudCByZXBvcnRlZA0KPj4gYnkga2Vy
bmVsIHRlc3Qgcm9ib3QpPyBJIHJlYWxseSBkb27igJl0IHRoaW5rIHdlIG5lZWQgZmlndXJlIG91
dCANCj4+IGFsbCBkZXRhaWxzIGFib3V0IHRoZSByY3Utd2FsayBoZXJlLiANCj4+IA0KPj4gT25j
ZSB0aGlzIGlzIGxhbmRlZCwgd2UgY2FuIHRyeSBpbXBsZW1lbnRpbmcgdGhlIHJjdS13YWxrDQo+
PiAodmZzX3dhbGtfYW5jZXN0b3JzIG9yIHNvbWUgdmFyaWF0aW9uKS4gSWYgbm8gb25lIHZvbHVu
dGVlcnMsIEkNCj4+IGNhbiBnaXZlIGl0IGEgdHJ5Lg0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0IENocmlzdGlhbiBvbmx5IHdhbnRzIG9uZSBoZWxwZXIgKHRoYXQgc2hvdWxkDQo+IGhh
bmRsZSBib3RoIHVzZSBjYXNlcykuICBJIHRoaW5rIHRoaXMgdXBkYXRlZCBBUEkgc2hvdWxkIGJl
IGdvb2QgZW5vdWdoDQo+IGZvciBldmVyeW9uZS4gIE1vc3Qgb2YgeW91ciBjb2RlIHNob3VsZCBz
dGF5IHRoZSBzYW1lLiAgV2hhdCBkbyB5b3UNCj4gdGhpbms/DQoNCkNocmlzdGlhbiwgY291bGQg
eW91IHBsZWFzZSBjbGFyaWZ5IHRoaXMgcmVxdWlyZW1lbnQ/DQoNCkdpdmVuIGRpZmZlcmVudCBl
eHBlY3RhdGlvbnMgaW4gaG93IHRoZSByZWZlcmVuY2VzIGFyZSBoYW5kbGVkIChzZWUgDQphYm92
ZSksIEkgZG9u4oCZdCB0aGluayB3ZSBjYW4gZml0IGFsbCB1c2UgY2FzZXMgaW4gb25lIEFQSS4g
SG93ZXZlciwgDQppZiB3ZSBmaW5kIHN1Y2ggYW4gQVBJIGluIHRoZSBmdXR1cmUsIHdoaWNoIHdv
cmtzIGZvciBhbGwgY2FzZXMsIHdlIA0KY2FuIHJlZmFjdG9yIEJQRiBzaWRlIGNvZGUgdG8gdXNl
IHRoYXQgaW5zdGVhZC4gVGhlcmVmb3JlLCBldmVuIHdlIA0KaGF2ZSBhIOKAnG9uZSBBUEkgb25s
eeKAnSByZXF1aXJlbWVudCwgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBkZWxheSB0aGlzDQpzZXQg
Zm9yIGEgUkNVLXdhbGsgQVBJLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

