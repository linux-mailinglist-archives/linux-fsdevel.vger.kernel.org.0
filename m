Return-Path: <linux-fsdevel+bounces-55040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099DAB06950
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC073B1CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D42D0281;
	Tue, 15 Jul 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cfZZYE9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BD341AA;
	Tue, 15 Jul 2025 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618705; cv=fail; b=b582vvTta3JY18p6xNcpMn5wtz2vtyQyfHlJscX5EMASDy7Gkj2C7GP96LCMB87nNId8RoB1JnerTe0lymNtvr7ZBGnd5ObJ1ipIDHTkxnnzRfwqW7vSVRuDhvOrRn3uCjwzSBm4BXI7NzVXP+bSeXpOqySvF1fdeQBfHKZmHuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618705; c=relaxed/simple;
	bh=c0LwPXvNGg2FALq44Y1CHEJSOLCUBb94+DdAdeIBrh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQQXrusd3Dxtzd70CBNB1hzcqp6BnAgnsMVcqxRyoIReEF7BufC9+TX7FK4kAuz17yImf/0zDSyiaBuwqpshycxgJ9haNrFwl7WW0T9eBmNBJ5hhcNoEfMKIiJX7db/425LxI1qJdX3lLAMxEQjI7vAADCMr57sQbkFzDSu2Z+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cfZZYE9X; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKgl7L012096;
	Tue, 15 Jul 2025 15:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=c0LwPXvNGg2FALq44Y1CHEJSOLCUBb94+DdAdeIBrh0=; b=
	cfZZYE9XiPq+UBkb2gHJ2EN+Aw7AwGqCAGuJdsy+J35c3iNgD0ueCc88e1oapC3o
	JCx+ymIUydmtWA4XXnz8cNlqa7px6GgdLEkwFy3RDfxsiDWfdptOhAJrZTjqXGmB
	kfdLogeXX7PbVR8p1JyrWSftV/tPhMjC5dgPsWmWcNMBt9Uqx2WO5PBBLBot2kTG
	OgREyBrQr8HSXIJCjsJT5K3M5e7YMx4LPfsNetD1Oz35RefxTl/cxLu+dFo2vBoK
	i9uWojTmmApSNIlmMzOO76+Gb7FxE0sR6f5LMpR18Qw8XBMC4au57FedGLcRqu88
	8l8UeatLLJewTectcz3qWA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47wv909tfg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 15:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uciHWkt1PSHvuCllksvyxKEmTAvasTkAlA04tGbFHPUdOaOfPHsOcBBo5C1mB7oYQwPGGXQhjm+3yKyoD1YUe26m19NbhVTsfFZ8f3jM97YcQvkJV0qcTDOPUutmcAbM7q6GM2s/uAdDwaUVDMPagAvyt2pAeWgDQwlHbTxHStJsSRvsFBAHb46ZyBu3GtzAzkGzP1sp5wBT+wkwM6uzheBcAmfaJgdQ1SUd/6ij++6Qj8pBVHAd/EuumTEIHCX/ivaTtA3uYWtOwwKo2vCFw96Tnrn12/bMkQLDwRU5jjlRRFn8DalOGYnp8T+ZQNpuLvkc3Ie1Qhl5QxKONqf1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0LwPXvNGg2FALq44Y1CHEJSOLCUBb94+DdAdeIBrh0=;
 b=xOmVMrSlsyE8kSCJS8DnuzUW5hNX5TXN1rYzNkNvgFHn5/0aM5xkWVbCNQW2FJUFpEszSSnlpuooagb/y9ZS0NhgoEmwy6z3yUwQoHLL1xmuGX7Kt4pOUM5ZsLCtoHMN/gD5IU2LJAMzy+HQDYN2r1u0baAeYR1WmYpgpTatTeg2rKK89sUoS7YhwT6f5Osdpa1MvDroyBycI5w22Xi6vrpuePGxBeArKLfncDHP4pFnwBp2Mu+p4xOu5wyE6EbnxqpWZL01yEpZwNz40bePNBwEloGPPs2qdxckPzILxKQsnB1/RcsUiyMqRTA680twLbTAbDmYNbGlTMzVjZhuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB5964.namprd15.prod.outlook.com (2603:10b6:8:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 22:31:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 22:31:39 +0000
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
 AQHb8FzEhXwik4wHVUiG4oVmXX3W0LQpln0AgABShACAAB3hAIABOQAAgABXkYCAARZZAIAAcYcAgAQ3OACAAGuvgIABQIcAgADM74A=
Date: Tue, 15 Jul 2025 22:31:39 +0000
Message-ID: <B2872298-BC9C-4BFD-8C88-CED88E0B7E3A@meta.com>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
 <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
 <20250714-ansonsten-shrimps-b4df1566f016@brauner>
 <3ACFCAB1-9FEC-4D4E-BFB0-9F37A21AA204@meta.com>
 <20250715-knattern-hochklassig-ddc27ddd4557@brauner>
In-Reply-To: <20250715-knattern-hochklassig-ddc27ddd4557@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB5964:EE_
x-ms-office365-filtering-correlation-id: 0e07509a-a545-4e51-7660-08ddc3ef5de8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXNxYXd5TThFWkRDRkg3bXhOWVNabVF1blpkOStld0NmcHpnM0c2YWIwcHhQ?=
 =?utf-8?B?bWh4M2xBbkMwWmR5MTNzdEhCUDhuN3kxWktMVmE1VzQ1VmhvNmN6VURicWZl?=
 =?utf-8?B?YmV0VmdXM0x6cjdVUnFrQS9XQVl2R01DRm1DVHVNVS9GNzcxMHFOS0MwdVR5?=
 =?utf-8?B?SUgzZUg0azloZFpLS1o4ZDE3TS9wY1J6Y2pGVisrM0xJZ1FSbVpyczl0ZkdV?=
 =?utf-8?B?dGJRcnVXWUZwTFN4cG1xenR1a3UvRC9QbmcrT3ltemhOc0poT2JjSHhrRUIv?=
 =?utf-8?B?YWtRaHBYaHRpdlBPdmh5QW1TTE5zamZCOEJEM0lINng5SU0yMEJlcEE1eVFu?=
 =?utf-8?B?cktiTzZTeEppRm1xYUYvb1BHQUE0dTg4bHlDUExWTVNZekNQMUpSU3dPelh5?=
 =?utf-8?B?WGlQZW9WU0FBdEJOekg0ekhlTXVXZXVPc3JoS291QnRHcFpqelNMNXh0MW43?=
 =?utf-8?B?eWJWM2liV3I1QUpqYTFMN0JTdU5nTXJZSEhsQXY4cWN4dWEvaDUzVDdsZmF3?=
 =?utf-8?B?T0NOODA3TnpaQ3NaRWFyeERGSG5GcG13bzNmWXM5bzA3ckpSK2xVQXV1Vlg2?=
 =?utf-8?B?ejdxNlZUNy9YRFJFVEJLb2w5eUJoaHl2ZURCSTdNamIwd1V2dis0dkx5TGlv?=
 =?utf-8?B?RzFRWW1DTnVqR0dRNkovU3FXSEgrM0dPNlFUdDRXSG9zdXYvaEJzbFlhMkV2?=
 =?utf-8?B?TzRYK2dBSnVlbTZxUm83U2t3aE1FU1N6ZlROUnYyZUZIeklyR2NjK3NyQmNG?=
 =?utf-8?B?WDg4eHhzbVVnaHR3S2xhbzdFOFM0c04vd2l3eDhoQmtlaGVKYTd2Y1VHN1dF?=
 =?utf-8?B?Qm5UaGh3dTFsNHd1QVlXOHFxZ1dPcXhMNElFcUdIcDYwU1ZaaEVpQzBQVUhU?=
 =?utf-8?B?NVllZkEwTmFrYUFOempoY0szekxkVWRMU3NsNkF4YkRiaVFPTE1uQTZISnA2?=
 =?utf-8?B?N1puTmJwMmZ6bkpjMlNJZHZHTyttc05jR1BHdXh4UVgydlJDejFyN3dGVDVa?=
 =?utf-8?B?Q2Z5WmxpbksybklRTU9aak5TUzZncHltS25PampJNy9BR3Zudy85b0ZxOHVP?=
 =?utf-8?B?NXJMR1NMY0M5b0ZIbjdYS2lCWHNhc3Mzd0FoLzFTbzVwMml6WW5NZW5qY3E3?=
 =?utf-8?B?R0xzRXdQRS9KV2tCMncwblRlVEM0UmRJN2I3QXVQREsrdmFLcUh0bmRKL3NG?=
 =?utf-8?B?blE2UUZ6dVJZOEhabVJUanUzeEtlTFNqT25KbTNpTHNQUU83UXpJa2F4d3d3?=
 =?utf-8?B?ZGh1dnl3S1VER1ZKeXUxWGVta3FRanF3VmpsOVpGZkFTWjNGaW1QRDFXd3dZ?=
 =?utf-8?B?T0RjOFlnSS9NV2hDREF2VzJrcVBQb1dtbXEwQVBZNWY2aTNKMjIwMkRXb2l6?=
 =?utf-8?B?aVJjeHR0c09VTkRpcGFBZFUwaWhyMWloajhTUnZLcit4eDlCZDYyUnBSOVFu?=
 =?utf-8?B?K3hxa1Z2NjA0bDlobG1pZTRTbWVmcDJ0S1VwWEp5dlF3SlRydWhZU0xGTGY0?=
 =?utf-8?B?VWJwaXJJV2tTbms3WHR2aTI1S0gwTVIyUXg2SUgwSFBKME9jNzRubWtNNVll?=
 =?utf-8?B?RVllQ0p1bGVZY2pIYU5OejRpdlNGc05qeHNmUSs4MTU1NkErVVZjbFl5WGEr?=
 =?utf-8?B?aWlkdlZ3YkJJQzhWMEpBWThMTnMxeUlFT0dhZjlxcmFDV2lwM1UxNitHcjVx?=
 =?utf-8?B?bkx1MVZWOFdoallTVENPN0FybjdtNkx5OXh4MGRSWXo2TXVMdVBHY0E3ZEty?=
 =?utf-8?B?MVpESCtrL2RlQTVva2MzdW1Wb3RZUG5Hb092U3dLRlQvZi9rM1MrWHFpaHhZ?=
 =?utf-8?B?N04zWTd3MFVlNG9TM0NqNzhCYWZNdlFWdi9oakNhcVpIaiswMUZ0S2lJK2Mw?=
 =?utf-8?B?ZnlsTjNjR2loL0tsMll2QmFrZWVob1hSQmpiVVlDR3BpcmZ5ZFQ5NEpOOHox?=
 =?utf-8?B?NWxwTk5uN1hqSEJNajBVYTllZDR4bzdUeWM3SlVpeERpQ3J5UWVFc2tKeHQ2?=
 =?utf-8?B?TVAvZlQwK0t3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGpVdU0ySjVENUY2UkNJNlNEMDMrUXFKYkFubVVGWmFJWEFQMmgzOG9BTVFj?=
 =?utf-8?B?UURYNWdmZC8xakJSdzZCVkd5MFB6WGhkUjhoNE1LTEpGSTZ4NFhqbFQ0Rml5?=
 =?utf-8?B?YVFiZU5OUFh0MGhEYjFNRXYrbVFaVGN0bnkza0k5QWNIMVNGV3ViTnNEdWNs?=
 =?utf-8?B?QS9BWlgrVkVoaWEreWFJY1FtUVNycGtCSGd1eVFTbXhqNFFqZXlMUXlMNzV2?=
 =?utf-8?B?aUpyZTB0YmlHNTM5U2RveldteXdUWVRsaUIxR0o4cGhiUnZqMXQ5ckhjVVFn?=
 =?utf-8?B?N2J0dndaSlF1OXhnL1U4MkNnTy9hVkY1emVBN0lHUVNtbkFPQk5tQjExKzI0?=
 =?utf-8?B?ajdqd1U3RDY0WmRLVC85RUdjS0RMb2NKZ2l2YmRxeW5CLzJZQk5PeVBRaDBx?=
 =?utf-8?B?UGVReWdFM1hqTmo0NW4wcTNwa0ZYWGE0dWw4MXlVMCtWWTJiak9qTzR0cFJu?=
 =?utf-8?B?RU94L01sdThzNkU0bHl5ZlpBd2wwZ3pLaTRiMmdlbnhiVzJRdHdhNXJ6eW11?=
 =?utf-8?B?SkNDYkU1WDJOY1ZFc01uQndrUHRNa1cwZGJ3bDI2eHpTdGhWMFp5VlZLM3Nt?=
 =?utf-8?B?ZWhiOTlrcE9iZnZSdjlBNTFRMkxOa3RXSDhOTDJWQWh3YXQ2YUcxK3M5aEE3?=
 =?utf-8?B?TEpwYkdHblJ0VU16MjdBYUVKZkpFVzc0L25CN09aelBUeHUyb1VwL2YzR0hU?=
 =?utf-8?B?dHVTR3ExUzdTblJmZUEzNSs4aU1Ud0ZVeHBrTEFHOEtUYWlaZHhwVHM1d0cr?=
 =?utf-8?B?WHhrKy9SUEZVZml2V0x5TUdWNkJHVFR5SGhUN1RqU3lUd0lEZk5mOS9PUUdk?=
 =?utf-8?B?QWpDU0NXWlZuVkRDS0ZkRW5EUkNaK2xCMnEzZEw4ejRva1ZWYVlNSHYzVjZl?=
 =?utf-8?B?MWZzWWlUWXlaNDVrei8vbFdtSlNhbzFSUGxaUWJDTC9vb0JBckZqYWNDTzVl?=
 =?utf-8?B?NmZuS0c5V1N2ZHBtVWNBMEtDeUJxV3lXbk9WYTlHejdDV0R2SXJsc0RTN00z?=
 =?utf-8?B?TVVwQ0xuMk5Ya3ZaV2E0L0xYOHhCZFhNZFdVRVRNcHVMUUJUK29SNFI2YXBQ?=
 =?utf-8?B?eHdIcDloZEhSV2VyV3RIZURrRUliNHNqRklPUHppNC9JNjdwRldJVC9nanBv?=
 =?utf-8?B?NXZkdThpMnFwZEFsR0dqYzViUmI1NFAxS0ZMNVlUY0ptdWFkTm9pa1lsOFov?=
 =?utf-8?B?Z1pVRnlHTU44QUN0emR1Z1N6SVBnei9tRzBRNTRxaTAyZWpFaDVOWXRsb1ZC?=
 =?utf-8?B?ZjdjbllNOVc1TXlDT2xJbjB3ZGxyS0FQWng0Mklqd0xXZWcxTW9nbXBvaDFs?=
 =?utf-8?B?aFNLOEo0U1FhL1ZrSE1LaWNmenlIZjFwdXQwRFlqdUZWRENzZmZYRUx0cFdY?=
 =?utf-8?B?TVBKeDE2c0I4MWUxSWQrZnBnSldzYXJuSmJXcEEvaHNoeEIzZ1R6Q1ZxYmF0?=
 =?utf-8?B?MTRJbmhzUmxuNE4wRlNXaEs0UmdTdUtjN1k5aGRhWjdKbnpvWjlUNzNrRU5R?=
 =?utf-8?B?UFlKa0hOUmhrbnhIckVWajc1RjF0ejFGdDJMNXBpNkZIa2JZeWxQN0tsbFpv?=
 =?utf-8?B?eFlnczRMeFV0Q1lPRkxWTy9VeTVnV20rbHE2MEdsbVNhcHlVVVBzMXBsVXFR?=
 =?utf-8?B?NTVoa3IvZTdlRmdCSXpLYlBBaW53K2tRa0tnKzlZcXVCcHQ1bXZTZ1kyYkpV?=
 =?utf-8?B?dmFoYzNLWVF2YzdRcWhZc25neUJFWWVDS3VMRE55SHB4NnpGNnJyNVU0UjhS?=
 =?utf-8?B?K2JRTWxQRWdGRVMrL2tQRk01K1hYdGg0OUZQQzBqMG9Mdjh5REd1YzV2UFV0?=
 =?utf-8?B?bVN0RkRIWTdsN0NHV2FEdGdJTmVUQUdsL0I0UmRmc290ZlBYbkM0K3hJOUgy?=
 =?utf-8?B?MGhBb0FCQTNBOExBSFNlVGc5a0VTVFNoL3lUc0FSUjExeGRjdGplRk0rOGYy?=
 =?utf-8?B?M2NzYm9xaWtqVjluMDRCRGlkSUUxS004RWFDaGd3cDQ0L1owWFhnMkptOU92?=
 =?utf-8?B?b0I1dVZhMGVMU1h0WEs4MU02QXM0VUMrQnZGRFNYdERBUGhGU3VrQythbFIz?=
 =?utf-8?B?V3RxR3ZseStvaDhZQXpaNStTZ3BnRjNZMDQyc1pqeHJOUTlHMk1MZDFuRmJi?=
 =?utf-8?B?c3BKS1QxZnNZOVd4akhQMWo0NlZzc1gvMUY5WEU3SU9WWmkxdHFGM0Z0MFdr?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38CA03FAE03E6C49A3FA8CDDADA9D705@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e07509a-a545-4e51-7660-08ddc3ef5de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 22:31:39.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hSvAy006Kf2lNlZ+9JqE2nCogmVNTcYlmiPeLDPTWxEYuO0rN2b7PJjajtaSDQpQX+Qv9feztdCuRW9kDkmdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5964
X-Proofpoint-GUID: 3IcBqfbW4J5Y-TT5iZqWjrTZJDeTrsI7
X-Proofpoint-ORIG-GUID: 3IcBqfbW4J5Y-TT5iZqWjrTZJDeTrsI7
X-Authority-Analysis: v=2.4 cv=ZIDXmW7b c=1 sm=1 tr=0 ts=6876d6cf cx=c_pps a=beKarbE+Mk3HYUGHxDyRTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=kMQrYEgg3kkKZl1wcW4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIwOSBTYWx0ZWRfX0twJXHwlEBUz VsxBP5h1pfAHY2ZsVe40FQN1mthgfqjYMyE2wSDSqXmhIKkvRCNVyaQ6YJq84oAP/dvGLaoWdBw XYwdnIsFLVGIj9RGnhqP9Ey//Cmhc0lGc9K4oYHXzY3YOcNp30+3CHtiE6RFEz8jVpRfvN4XIaJ
 9HYYnGpMSjOWIftsUW3+fS1rEg2q+VMOL9Eoc/yf56AhBhrNCzzaexROlGWNm7t02OoDqyFX6ny pv9CPEy2Z/M2+Y8aGn2VZknlzcX4jcBeGwfYzRbrcpGNi5rTpx3HkArLFPSshSoIuTbGmimb9Ze AJoi0WhtRLu2vPXGDu31Je1p3Y6SmWlLejGhXf8AEYbUtWZtan/VS1YRWOKgEkoY+RwO+Bn92nU
 vWoGiPgwg/E7EF3CGnd2NjmEjxdUgNbSLO8lvW2DoRrUlIbujELzD4PB2TFuihhp4mRj8ONp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01

DQo+IE9uIEp1bCAxNSwgMjAyNSwgYXQgMzoxOOKAr0FNLCBDaHJpc3RpYW4gQnJhdW5lciA8YnJh
dW5lckBrZXJuZWwub3JnPiB3cm90ZToNCj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDM6MTA6
NTdQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQoNCg0KWy4uLl0NCg0KPj4+IElmIHlvdSBwbGFj
ZSBhIG5ldyBzZWN1cml0eSBob29rIGludG8gX19kb19sb29wYmFjaygpIHRoZSBvbmx5IHRoaW5n
DQo+Pj4gdGhhdCBJJ20gbm90IGV4Y2l0ZWQgYWJvdXQgaXMgdGhhdCB3ZSdyZSBob2xkaW5nIHRo
ZSBnbG9iYWwgbmFtZXNwYWNlDQo+Pj4gc2VtYXBob3JlIGF0IHRoYXQgcG9pbnQuIEFuZCBJIHdh
bnQgdG8gaGF2ZSBhcyBsaXR0bGUgTFNNIGhvb2sgY2FsbHMNCj4+PiB1bmRlciB0aGUgbmFtZXNw
YWNlIHNlbWFwaG9yZSBhcyBwb3NzaWJsZS4NCj4+IA0KPj4gZG9fbG9vcGJhY2soKSBjaGFuZ2Vk
IGEgYml0IHNpbmNlIFsxXS4gQnV0IGlmIHdlIHB1dCB0aGUgbmV3IGhvb2sgDQo+PiBpbiBkb19s
b29wYmFjaygpIGJlZm9yZSBsb2NrX21vdW50KCksIHdlIGRvbuKAmXQgaGF2ZSB0aGUgcHJvYmxl
bSB3aXRoDQo+PiB0aGUgbmFtZXNwYWNlIHNlbWFwaG9yZSwgcmlnaHQ/IEFsc28sIHRoaXMgUkZD
IGRvZXNu4oCZdCBzZWVtIHRvIGhhdmUgDQo+PiB0aGlzIGlzc3VlIGVpdGhlci4NCj4gDQo+IFdo
aWxlIHRoZSBtb3VudCBpc24ndCBsb2NrZWQgYW5vdGhlciBtb3VudCBjYW4gc3RpbGwgYmUgbW91
bnRlZCBvbiB0b3ANCj4gb2YgaXQuIGxvY2tfbW91bnQoKSB3aWxsIGRldGVjdCB0aGlzIGFuZCBs
b29rdXAgdGhlIHRvcG1vc3QgbW91bnQgYW5kDQo+IHVzZSB0aGF0LiBJT1csIHRoZSB2YWx1ZSBv
ZiBvbGRfcGF0aC0+bW50IG1heSBoYXZlIGNoYW5nZWQgYWZ0ZXINCj4gbG9ja19tb3VudCgpLg0K
DQpJIGFtIHByb2JhYmx5IGNvbmZ1c2VkLiBEbyB5b3UgbWVhbiBwYXRoLT5tbnQgKGluc3RlYWQg
b2Ygb2xkX3BhdGgtPm1udCkgDQptYXkgaGF2ZSBjaGFuZ2VkIGFmdGVyIGxvY2tfbW91bnQoKT8g
DQoNCj4gSWYgeW91IGhhdmUgMTAwMCBjb250YWluZXJzIGVhY2ggY2FsbGluZyBpbnRvDQo+Pj4g
c2VjdXJpdHlfc29tZXRoaW5nX3NvbWV0aGluZ19iaW5kX21vdW50KCkgYW5kIHRoZW4geW91IGRv
IHlvdXIgIndhbGsNCj4+PiB1cHdhcmRzIHRvd2FyZHMgdGhlIHJvb3Qgc3R1ZmYiIGFuZCB0aGF0
IHJvb3QgaXMgMTAwMDAwIGRpcmVjdG9yaWVzIGF3YXkNCj4+PiB5b3UndmUgaW50cm9kdWNlZCBh
IHByb3BlciBET1Mgb3IgYXQgbGVhc3QgYSBzZXZlcmUgbmV3IGJvdHRsZW5lY2sgaW50bw0KPj4+
IHRoZSBzeXN0ZW0uIEFuZCBiZWNhdXNlIG9mIG1vdW50IG5hbWVzcGFjZSBwcm9wYWdhdGlvbiB0
aGF0IG5lZWRzIHRvIGJlDQo+Pj4gc2VyaWFsaXplZCBhY3Jvc3MgYWxsIG1vdW50IG5hbWVzcGFj
ZXMgdGhlIG5hbWVzcGFjZSBzZW1hcGhvcmUgaXNuJ3QNCj4+PiBzb21ldGhpbmcgd2UgY2FuIGp1
c3QgbWFzc2FnZSBhd2F5Lg0KPj4gDQo+PiBBRkFJQ1QsIGEgcG9vcmx5IGRlc2lnbmVkIExTTSBj
YW4gZWFzaWx5IERvUyBhIHN5c3RlbS4gVGhlcmVmb3JlLCBJIA0KPj4gZG9u4oCZdCB0aGluayB3
ZSBuZWVkIHRvIG92ZXJ0aGluayBhYm91dCBhIExTTSBoZWxwZXIgY2F1c2luZyBEb1MgaW4gDQo+
PiBzb21lIHNwZWNpYWwgc2NlbmFyaW9zLiBUaGUgb3duZXIgb2YgdGhlIExTTSwgZWl0aGVyIGJ1
aWx0LWluIExTTSBvciANCj4+IEJQRiBMU00sIG5lZWQgdG8gYmUgYXdhcmUgb2Ygc3VjaCByaXNr
cyBhbmQgZGVzaWduIHRoZSBMU00gcnVsZXMgDQo+PiBwcm9wZXJseSB0byBhdm9pZCBEb1Mgcmlz
a3MuIEZvciBleGFtcGxlLCBpZiB0aGUgcGF0aCB0cmVlIGlzIHJlYWxseSANCj4+IGRlZXAsIHRo
ZSBMU00gbWF5IGRlY2lkZSB0byBibG9jayB0aGUgbW91bnQgYWZ0ZXIgd2Fsa2luZyBhIHByZXNl
dCANCj4+IG51bWJlciBvZiBzdGVwcy4NCj4gDQo+IFRoZSBzY29wZSBvZiB0aGUgbG9jayBtYXR0
ZXJzIF9hIGxvdF8uIElmIGEgcG9vcmx5IGRlc2lnbmVkIExTTSBoYXBwZW5zDQo+IHRvIHRha2Ug
ZXhvcmJpdGFudCBhbW91bnQgb2YgdGltZSB1bmRlciB0aGUgaW5vZGVfbG9jaygpIGl0J3MgYW5u
b3lpbmc6DQo+IHRvIGFueW9uZSBlbHNlIHdhbnRpbmcgdG8gZ3JhYiB0aGUgaW5vZGVfbG9jaygp
IF9mb3IgdGhhdCBzaW5nbGUgaW5vZGVfLg0KPiANCj4gSWYgYSBwb29ybHkgZGVzaWduZWQgTFNN
IGRvZXMgYnJva2VuIHN0dWZmIHVuZGVyIHRoZSBuYW1lc3BhY2Ugc2VtYXBob3JlDQo+IGFueSBt
b3VudCBldmVudCBvbiB0aGUgd2hvbGUgc3lzdGVtIHdpbGwgYmxvY2ssIGVmZmVjdGl2ZWx5IGRl
YWRsb2NraW5nDQo+IHRoZSBzeXN0ZW0gaW4gYW4gaW5zdGFudC4gRm9yIGV4YW1wbGUsIGlmIGFu
eXRoaW5nIGV2ZW4gZ2xhbmNlcyBhdA0KPiAvcHJvYy88cGlkPi9tb3VudGluZm8gaXQncyBnYW1l
IG92ZXIuIEl0J3MgYWxyZWFkeSBpZmZ5IHRoYXQgd2UgYWxsb3cNCj4gc2VjdXJpdHlfc2Jfc3Rh
dGZzKCkgdW5kZXIgdGhlcmUgYnV0IHRoYXQncyBhdCBsZWFzdCBndWFyYW50ZWVkIHRvIGJlDQo+
IGZhc3QuDQo+IA0KPiBJZiB5b3UgY2FuIG1ha2UgaXQgd29yayBzbyB0aGF0IHdlIGRvbid0IGhh
dmUgdG8gcGxhY2Ugc2VjdXJpdHlfKigpDQo+IHVuZGVyIHRoZSBuYW1lc3BhY2Ugc2VtYXBob3Jl
IGFuZCB5b3UgY2FuIGZpZ3VyZSBvdXQgaG93IHRvIGRlYWwgd2l0aCBhDQo+IHBvdGVudGlhbCBv
dmVybW91bnQgcmFjaW5nIHlvdSB0aGVuIHRoaXMgd291bGQgYmUgaWRlYWwgZm9yIGV2ZXJ5b25l
Lg0KDQpJIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIGFsbCB0aGUgY2hhbGxlbmdlcyBoZXJlLiAN
Cg0KSXQgYXBwZWFycyB0byBtZSB0aGF0IGRvX2xvb3BiYWNrKCkgaGFzIHRoZSB0cmlja3kgaXNz
dWU6DQoNCnN0YXRpYyBpbnQgZG9fbG9vcGJhY2soc3RydWN0IHBhdGggKnBhdGgsIC4uLikNCnsN
CgkuLi4NCgkvKiANCgkgKiBwYXRoIG1heSBzdGlsbCBjaGFuZ2UsIHNvIG5vdCBhIGdvb2QgcG9p
bnQgdG8gYWRkDQoJICogc2VjdXJpdHkgaG9vayANCgkgKi8NCgltcCA9IGxvY2tfbW91bnQocGF0
aCk7DQoJaWYgKElTX0VSUihtcCkpIHsNCgkJLyogLi4uICovDQoJfQ0KCS8qIA0KCSAqIG5hbWVz
cGFjZV9zZW0gaXMgbG9ja2VkLCBzbyBub3QgYSBnb29kIHBvaW50IHRvIGFkZA0KCSAqIHNlY3Vy
aXR5IGhvb2sNCgkgKi8NCgkuLi4NCn0NCg0KQmFzaWNhbGx5LCB3aXRob3V0IG1ham9yIHdvcmsg
d2l0aCBsb2NraW5nLCB0aGVyZSBpcyBubyBnb29kIA0Kc3BvdCB0byBpbnNlcnQgYSBzZWN1cml0
eSBob29rIGludG8gZG9fbG9vcGJhY2soKS4gT3IsIG1heWJlIA0Kd2UgY2FuIGFkZCBhIGhvb2sg
c29tZXdoZXJlIGluIGxvY2tfbW91bnQoKT8gDQoNCkRpZCBJIGdldCB0aGUgY2hhbGxlbmdlIGNv
cnJlY3Q/DQoNClRoYW5rcywNClNvbmcNCg0K

