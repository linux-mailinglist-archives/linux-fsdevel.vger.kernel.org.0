Return-Path: <linux-fsdevel+bounces-33218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B79B59C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 03:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B747B22AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60B192D82;
	Wed, 30 Oct 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="msH76Hdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD3D531;
	Wed, 30 Oct 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254028; cv=fail; b=h/vXYu9UOoTp1SImqNVVWJ/FAtQBd70a8Ofe3mbWac9o9mHfIS6dog2AhFxa6tm9QBTbTSRqTZyrftQcC1BVsGQ9QTBGBTdg3eBE3YwJV1ckRaX9Y6fIvfKPNhUniYOQDhXBCmSZNqiHMBJgsQ5P8K5j3NVqCYJVihPUx59hEhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254028; c=relaxed/simple;
	bh=i5OX2RsYlOKPG81QpZfZQIwDrlDfVnLiRRqGrX3BMtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHdO4baQQnFv9/E6ZlhWqtTA3SkQhUAtf6x0k0852x7gLd1XP/1S2K7TS4E4PHQ5lVSzn/ZkkAG7zCm3Nmw/q/xpvBLEGwf6B+Ur8iQftamnnl0qmnWt2CWOiTJkwnMC4C016NM2t+0oWmr1wmIBLR1IaAXD7L4KwWqXL2lURdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=msH76Hdg; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1HcJf010361;
	Tue, 29 Oct 2024 19:07:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=i5OX2RsYlOKPG81QpZfZQIwDrlDfVnLiRRqGrX3BMtA=; b=
	msH76Hdg5gzuoQ+BOK+wZuasstYulB1rKkQ55/FUs6RCQr9W5zqxJ1jQpMOIZ7KL
	wH46zQlzgBpvQNDwo/ygmB7iWxFJMRPBqHA8cJrhL/erJ5WSzZEUA6pgpRLF7MqP
	xzJikOF1O+6alB3j3kTpMr9M38/m3lelB86rLCBNOpYR3PC6oIzthTkyJiWoxASx
	4/cgklBbKiGSJLg8sQpQ4I0Ro3WQp+TFJSyOFxLCVsgfPXMwx030fofipsO3sKkm
	Ujtr7dsaMCS/SNkAVht2PTOQhILy9ZJ4wgY/t457LjrRkMwwokUwdCyHcmcoU2Au
	wmJN9iJFM9XStM1t6cXhfQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ka8fges4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 19:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPSoTX9njeAas9WszcjzlrMpc0jmQFP5lXlEtB5jwFlZxay/NCnAeGjFKH3Dn886REf8vQCp9zVhnt8dINCfVP/scxUu4TtcPvJo5OxDDkE8OYTaL22gXQ4En6S3tGaPsNlAtmvXon97y9B/9Z5WVRNweDE6MAXjRzrpVThWM9yy+ocLHqX/drmQ941mXRao3fYmv7eZFYDbGkVst0KlbyPib3hQXyTLo7Sep31tqk1vtvcXno4t2G19IME/NTeR/ncKAJhxyW+i+w2UNHcoMpBXzKiF3h6iLjSZFalZrHvs9jgOGix5yWxniZrazUC6XmOt1A282jd4hngPWyv4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5OX2RsYlOKPG81QpZfZQIwDrlDfVnLiRRqGrX3BMtA=;
 b=t8A+GLGZqjuILsZQ1qvSjboSfiGSiZck91RL9wptCg5yd/16qQ5senmPlveYZRjGcD5nlUZBqmChPPIU/thjCmeUvOuodavu+HO+8bILJOwmcD3azJ+Sj+FEmJ66Wr/TK5zXepqA3M4JjtHPu4K1DcgN2E53pDDS7Vze7wA6sjr7S/qOceA+0/sOA0qMswSKgkb66GcWQj6u5oweALup51dvBDc3bHeQqKvTf30bhoDU3bh4GJN21St0s0UnIfs/wBP11aZWRFYwcGpUq8fE9Lq3ajVQBoGXgwWbScIe6ztPNGFz1Fz/VwxbmLJFJUXlFJ4fR/+sKEXrXcC6kF22sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH8PR15MB6092.namprd15.prod.outlook.com (2603:10b6:510:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 02:07:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 02:07:01 +0000
From: Song Liu <songliubraving@meta.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Amir
 Goldstein <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Topic: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Thread-Index: AQHbKlgjXcuBZV3LVEOnRP7zXkEQ0rKea/eAgAAgGwA=
Date: Wed, 30 Oct 2024 02:07:01 +0000
Message-ID: <0D8D4346-722D-4430-B15D-FA1E40073CFE@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org> <20241030001155.GF1350452@ZenIV>
In-Reply-To: <20241030001155.GF1350452@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH8PR15MB6092:EE_
x-ms-office365-filtering-correlation-id: 38a55337-a67b-4fe6-55a0-08dcf8878af8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0FqT3pETGFIeWt3eHJyOCtteXNDeFZXaUt5QUJISVhZY1o5L3Qvb3c4TWtE?=
 =?utf-8?B?bVhGbGJ5YlBYMTFrR2FLcGVzM0plOFlmS3hIckNSaklrWU5weE1BVVpDRmVl?=
 =?utf-8?B?Q0piMWhlU213c2dnVExSSHIyOXEzR0NKT0JMbWpoTkgxK3lZV3Z2R1EyMkRR?=
 =?utf-8?B?dFRYMXVYSTBWQ0xPVXNZYkQxcnRyWVAzSFRqUnlQOHpraDFIQVNSUnFEdi92?=
 =?utf-8?B?cW1jTWRQQlBpZHBJUWVMK0Z6TlN6cjJOSXNiNDBKUkNCOWliR1JpQ2hxRVJy?=
 =?utf-8?B?NERxYzZuUlo3ZmErL2M1aUplRWRuNUEvSzdHc3hyWGhhNXk4N0VCSXVNaHda?=
 =?utf-8?B?aGNCVTZlZC84Vk9zLzNGbnpKNkROdEpZZW51TGxid21DTWFKbzBpNUoyU2Vk?=
 =?utf-8?B?L2JRcHJJSkNTWWhoeUpIV1dHSDNnTW5kQlp2OWZ2bXlTeXRNeCtlU2J1V3dO?=
 =?utf-8?B?K1FaMFNyZmtLVS9mbnVjSEdOdDhPYWNpMjE1ejhlTTlIcVY1a0dKRTZIVEJm?=
 =?utf-8?B?NjQ1bVVPMWVBNUIxTmphWnVvYXZ5OXp3TU1NRlBJU2tGRzNEaWVQSTdKMmhW?=
 =?utf-8?B?d3l5T0R6bmJReGVCRW4zNVJpR2ZNc2J0R0hDYnZmK1JIaVJPZDFaQmJCcWM4?=
 =?utf-8?B?T09JRzRvVHlkOXZ2eEZRTmxMellRTFZ3VC9kUjl6Wkh0Si9BWjE4ZGZhUWFq?=
 =?utf-8?B?WVRWSFVCWklPUjl2VlBHR25zc3dCZHZDajdPTnZBWGhicjNrUjJyeUpUSG1X?=
 =?utf-8?B?V1pqZjJjWTNESnhlek9JbUZoVzZ0aW1ZUXpFVlVOZ2FocnROOGlLenptcWVm?=
 =?utf-8?B?bG5jRzcydkxHMkU0WTBwTGdiUE5pSWUrMXViK3FDakhxMVRhd3dyMXBrVm1F?=
 =?utf-8?B?TmtBbERobkp0MTlUdkJiUHpaczM1a3kwNHltTE41RVppNXdlbzFHN2ZJbVVj?=
 =?utf-8?B?bXZQYlk3Z1RnVFNHSEl4dkFEU043SmxkdkxDQTlBTG5XVW5BNEZJdFFMaXBZ?=
 =?utf-8?B?cXN3YTQ5b2pOSVRVNUhGRktlRm1YbjF3UUN0OSt1TXNYbTRReG52czlpcm4r?=
 =?utf-8?B?M0x6R0VpblJNMUlGNkY5VTZwMnE1b2JMNnkwdTh1UVZXVGlKVEk1Zk9kWkk2?=
 =?utf-8?B?Mm51Q3puWWJzVTcvK05SdVZtZ2EzbXZLYy9rYUk4eEtNS0hndVdWYkhBUm92?=
 =?utf-8?B?STdLNCtLb2llaGQ2VnFSRldnbXVBamhMTjZmTWptOHlTdDlpR1doMUhMdllN?=
 =?utf-8?B?MW9PUGc3UzVaQ3BNVnFSTzRucTlqVGVUUTJNT2xxMHdwdUErajlNT1c1a0Y3?=
 =?utf-8?B?VEU4NWJqclZOOHNaME9YTlBvUE1wS0NkaFduVXkyV0w4c1FpUFBadGNoRTBi?=
 =?utf-8?B?K1VXWE9kekdrWHpGYkdad255bFEzcEhHeDYxSjdEVEJwSXJoWUZpcENxZS8z?=
 =?utf-8?B?RjhPM3V6ZVFxTVU2VFlteGdUVmFYL3NWL0tJd0VHRS8rOS9PMzQxQ3BST2Fo?=
 =?utf-8?B?VDgrU2t6T3R6SGhZZXF4V2hnRjdONk9HSXNXZ09STXROQTFkVXNqSFZuK1VB?=
 =?utf-8?B?Z0piZGN0bCtTbzd4Y3VvQUFtV0huZGZXVTBHeHhUMG5lVGNCeGNaSFFZMlpu?=
 =?utf-8?B?K2Q1djNyU0EwWlBzOFVaYVdZNUJnd1RnLzRhUk9iZUlaT2FxRTZwMDZvdmhr?=
 =?utf-8?B?c1NjVFg2MGF4NlZGelNiSWdHSDJlUUozdVZTTmtwOEFjdUxRYXE0aS9xaGFl?=
 =?utf-8?B?Y3IvNjdHamR1TW1jODZOc0RUbEtSS09XandadG9lc0NYV1Jtc29Mc2NUb2do?=
 =?utf-8?Q?KMBXcVNCTmudDEeyeL+2pPditPtmBmhIjSATg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWdmemIzS2l4WjNxcjRmYW5qRU9Oei9hY0xKcldBaVE3akRvRzRaNjQ3STNS?=
 =?utf-8?B?d2hSbjMzdmtVZWtoaGE2Q295eUNrMHdSeEtjTzJkbmFLK0luZFg4RFVnNWxZ?=
 =?utf-8?B?UDJUeldsS1JoQUI2OHdhREE4Q0xDc25LV1UybXlwUXFFN1V5ckZUaVpZWFhr?=
 =?utf-8?B?cy8vbXhQaUFpc0Fiak9OQ3d6RlB2b3B5M2F5c0NjMkdyQlk1U1NleTVlZzND?=
 =?utf-8?B?bmsrYTJsSllueWIrK2MyWnh2RWFSV01PbmkxalNWRGE3bmxRZWl6aVAyRlVn?=
 =?utf-8?B?bWZ4WU4rL2RGa1poWTY4eWgwVkVxMDVmbkc4bWNXRDlpajYrZmR3ME5HbE9H?=
 =?utf-8?B?eFlTWmFPNm51V3BIbXJWZFJrQ3B4MWx4MXNNQ1MxYi9iZksvUXhndVFhS09O?=
 =?utf-8?B?M3RxRzhETlVXdmFJd0NVUTRIUHNMVE81MnBGRVlSZTdvVU8yN3RFRXJvamVG?=
 =?utf-8?B?ZWJ4blhZcFY5ZEd0eWRISW1vcTg0VisvalAvNnNDNCt4dzl0R0JHejYyOWty?=
 =?utf-8?B?NStjbHVBMk9xOVduTGxwNVlGeHFlaHhKMS9jNGh4N0ZTY0paRXgxWTdEOEZk?=
 =?utf-8?B?cElLc2lXdWg1MlVYdlowZzRMcGliV0VjWkFUQ1NXVzBnb0lrTU4rd1JxQ2Fm?=
 =?utf-8?B?UnZhN21uV1lBaDdrMi84MDJZS28wUG5qbndTZ0V5c3NzS0J0NVljYm8zODJ6?=
 =?utf-8?B?Y1JWRzByazBpU240VUt0SmhmZklhRmEwL2s0dDAzWmRJM0pjNEgzbWtqRGYv?=
 =?utf-8?B?MVpVOGVpMStmL2RxTWlGSXd4YlFES2hyQVVlMFlmTFRnQzZZUWVwczZyUml0?=
 =?utf-8?B?ckVvNHl3aVlieFVYLzk1WDVOalJaM0VpMHJ6L2JGU2VNZWU5Q21yZ1NGNWtC?=
 =?utf-8?B?WStkY2NRc2k1TzJUZDl1L1drR2NGRXZzSzgvUWJQeXZuNWFXaTh1UE4rWGFU?=
 =?utf-8?B?Z2tkRWM0SkMvWUxEeVU1M1c3SlpWdk1EeVh1QjFCSDBpQVRmY1RmZThJR1Jw?=
 =?utf-8?B?ZXUyeDlZT3ZLY01sQnhWNUM2TE5EbVNMeEJLZDMrZWVRUm1ZRVJSZW5OZE1F?=
 =?utf-8?B?Z2U5amNaUlhJZExiZDFHeGx4Skx6enNtYlg3eDl5UkNvT3hJSXJESllVc0Nm?=
 =?utf-8?B?VVNKVDhEeUE5aEJmOTlWK1ErYjgwSldqeXZDYmdVTkp0YTlVN1JWSFlucDQr?=
 =?utf-8?B?TUtnRUoyaFRwajJNRDdSYzRFVWJTbVY4NkUyUTFjdGlRRmF5UTlPRFFuT3VU?=
 =?utf-8?B?OVR5VlhMT1R2ZmhFTmNqak9jZFlIa1pKbWlVelY0OEJ0TXUxRklSSm92M3VW?=
 =?utf-8?B?VWRlWkRHeXJpRkhjU2xDbEpydmEwQnBHbHF3alpNb05aeWhwNEFkeFFCeGQx?=
 =?utf-8?B?UklmS1k5VVgreW1PcTJOdlFDaVN0ZDljVXFnRnI5UHJ2YnlUUWhROVJmRDNY?=
 =?utf-8?B?K2xYWFZKdVNjTFduNHlVWjMwSEJ0R0tMSW5ScDh0aVlYc01QTitmOTFkM285?=
 =?utf-8?B?ZXN0NjJ2dFRMODVtTkxrWDczVTIxSlFVOGJFM0FXR0RPU3dnMThDSzNDRU1B?=
 =?utf-8?B?N0EzMWdubG1iZURBbUw4ZFBDeTU0M0NSZWh1U0k5STdLWFN0TjQ1RDdFTHJQ?=
 =?utf-8?B?cUF3T24zUHdtRnNWWm83Y3g5WHVLcEx1UXFYd01Lai9LNmhvWlZYVCtuUVZn?=
 =?utf-8?B?N1kxMXBWZjRlUVVQNnVnUnQwaU9sakt5dklKUTFkdmFKYjlicXV2WG1ZVlYw?=
 =?utf-8?B?ZXBMazRJbnFRQkpxQkRSeFFQVEpNa3UzVHkwemVMUGozWFlSelV6UVhBVWd5?=
 =?utf-8?B?enR4ZVZWdzhSMGszcnBCNlhpOUd5aFNRbWJ1VjU5WGZtQ0swMzN0eDJKYWsv?=
 =?utf-8?B?d1VoWEM2R0w1b2pUV0NOcTBXTlU0SlFUejBXdCtvM2x3VVl2b1Y1ZzJ0T3FM?=
 =?utf-8?B?Q1E3YlJKMzJiU2JqeEdvUzlDUEp6RzhMVGVKK1dZQ2w1SU5GUk1mQ0V5SGd0?=
 =?utf-8?B?NE4ydW5xRmtwVHlpdk9QQXhIemwvMGhReVNMUlhDdHlnZE1DZnBmY3U0ZUZO?=
 =?utf-8?B?MWhjZ0g2bnR1YXArWGFZR2EzMUZWc1o2MUd6S1ZDZWczaytaTW1weHZzR3Jl?=
 =?utf-8?B?VjFpeFR6c0F5VXpJMnJBVEZZMmVFK0pEdkZOYUhSdHVBaDgzZ1kvNzhFYnAy?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E926E34EC54C40AFBC0C5EC642397C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a55337-a67b-4fe6-55a0-08dcf8878af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 02:07:01.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4c0Oc8vJ7WjlztqMJLyBj0qM4ivc3ojjd0bOKtTRPIPqMjVMTGi4qVYlIyAiLcRJsUjW6V+1osiqql7ZHpS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR15MB6092
X-Proofpoint-GUID: f-ySbsvHo6xGXto49kURwsz0VgvQEwVj
X-Proofpoint-ORIG-GUID: f-ySbsvHo6xGXto49kURwsz0VgvQEwVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDI5LCAyMDI0LCBhdCA1OjEx4oCvUE0sIEFsIFZpcm8gPHZpcm9AemVuaXYu
bGludXgub3JnLnVrPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0IDI5LCAyMDI0IGF0IDA0OjEy
OjQxUE0gLTA3MDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4gKyBpZiAoc3Ryc3RyKGZpbGVfbmFtZS0+
bmFtZSwgaXRlbS0+cHJlZml4KSA9PSAoY2hhciAqKWZpbGVfbmFtZS0+bmFtZSkNCj4gDQo+IEh1
aD8gICJGaW5kIHRoZSBmaXJzdCBzdWJzdHJpbmcgKGlmIGFueSkgZXF1YWwgdG8gaXRlbS0+cHJl
Zml4IGFuZA0KPiB0aGVuIGNoZWNrIGlmIHRoYXQgaGFwcGVucyB0byBiZSBpbiB0aGUgdmVyeSBi
ZWdpbm5pbmciPz8/DQoNClJlcGxhY2VkIGl0IHdpdGggc3RyY21wIGxvY2FsbHksIGFzc3VtaW5n
IHN0cm5jbXAgaXMgbm90IG5lY2Vzc2FyeS4NCg0KPiANCj4gQW5kIHlvdSBhcmUgcGxhY2luZyB0
aGF0IGludG8gdGhlIHBsYWNlIHdoZXJlIGl0J3MgbW9zdCBsaWtlbHkgdG8gY2F1c2UNCj4gdGhl
IG1heGltYWwgYnJhaW5kYW1hZ2UgYW5kIHNwcmVhZCBhbGwgb3ZlciB0aGUgdHJlZS4gIFdvbmRl
cmZ1bCA7LS8NCj4gDQo+IFdoZXJlIGRvZXMgdGhhdCAiaWRpb20iIGNvbWUgZnJvbSwgYW55d2F5
PyAgSmF2YT8gIE5vdCB0aGUgZmlyc3QgdGltZQ0KPiBJIHNlZSB0aGF0IGtpbmQgb2YgZ2FyYmFn
ZTsgdHlwZWNhc3QgaXMgYW4gdW51c3VhbCB0d2lzdCwgdGhvdWdoLi4uDQoNClRoZSBzdHJzdHIo
KSB3YXMgcHJvYmFibHkgZnJvbSBsYWNrIG9mIGNvZmZlZS4gVGhlIGNhc3QgaXMgbW9zdCBsaWtl
bHkgDQpmcm9tIHRoZSBjb21waWxlciB5ZWxsaW5nIGF0IHNsZWVweSBtZS4gDQoNCkJUVzogV2h5
IGRvIHdlIG5lZWQgImNvbnN0IHVuc2lnbmVkIGNoYXIgKiIgaW4gcXN0ciBpbnN0ZWFkIG9mIA0K
ImNvbnN0IGNoYXIgKiI/IEkgZG8gbm90aWNlIGdpdCBkb2Vzbid0IHNob3cgdGhlIHJlYWwgaGlz
dG9yeSBvZiBpdC4uDQoNClRoYW5rcywNClNvbmcNCg0K

