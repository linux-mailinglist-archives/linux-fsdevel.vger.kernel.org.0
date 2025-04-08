Return-Path: <linux-fsdevel+bounces-46002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC169A811C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559467B9C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB721859D;
	Tue,  8 Apr 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Cx4O4fCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FA22A7E5
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128904; cv=fail; b=Z0wgSKCce9sj2h4q5H3tPRgBOESu6UlZgrA1s8LdS3uoRDSrcxGldALqXFmUNKg+psHtbLjQHK8JPnQ1iUc3NCI4Fy1JlbQU2Fw4OP/KKJQA1ZbABM/7FbTuWfzqJaxpmZcPHyOxHcrTpxsMpGU2/W7blJRJHC2qhKT6096YUlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128904; c=relaxed/simple;
	bh=QCu7mPYcZnqvcNyALsgjDg+QIJZHYkQyiut4Bw4GOXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ca4s7c7uh1NYXNkYpRzywMsQ1s/3iTnTyK9ELSBua9HNwgPlTKs4QqIC4kIPzBklPH7EFvQTSSLpKeFiwA2vhoHQAkCjUQw3qQmOsRCkc1uQZxayCqdjw965UmuWsQKDNZ/0iswqzj04UFRZmLQ+VHnUuWBsmzhslvue6JwkS+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Cx4O4fCe; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538EnOdN008464
	for <linux-fsdevel@vger.kernel.org>; Tue, 8 Apr 2025 09:15:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=QCu7mPYcZnqvcNyALsgjDg+QIJZHYkQyiut4Bw4GOXg=; b=
	Cx4O4fCesXkImtcgjwpWKBOwzURSBCniFmIJQ78cwEDd/Hez1b5DX1/rySxrzhnG
	FZLsC1CMPk3trZs0s94t3vWe+ruCChQ33tcY2XNeP5Q+AfRJdT7Qj3iwRWJDAnu1
	zA6J5nCY1QU+4hcVT+k/cUo3DBR4xq7gS02yq1y/lcBrxHlcA5dePh8QZo8q/4/a
	5EFT0h0HHTlDe5emQD/cPYQcxpOaSOXwHJPCJcZZxZzaEKIo9TcA4UKfH7wS19Ws
	8uMi9mA+V/fNLQyQODWCPaOerevmuLYaoeWcGCID6wSB2XBVO4dzdZo9wra/jJbp
	tnXkRaUyndoKR/0QNjCjzQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45w5w58u0t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 09:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8aBXpBDOzaMVylS73LgrtAlKFmERbtaFvY6Iub8J8kX8Qfv/NuRmHLk2KQMCZ8MWUmB2F6FyZvO+EcIyIWJEjAwQj/fVQLkNQQJRjm6kaEkwBDKaFKntrRqvG7vnVGkBy/ypvkmFt738h3JtBOe1p2kv5nBEYODHP3QkA8eOz+b5R3ArZdVubFAdqkeMqVYHZ32b3S1nO6ubgxhHpuuosKPbJIpjkes+upOmjlSlztqbYPyqK/Ne9UyZAFuTjaoLOBW+wki8Fc1PRAEX/FqGty/KvJknQwGTQ8BpTKRe6lJXktkOgubMzihr2uVaNhHkIb/6pR4dnomAml2hnHtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCu7mPYcZnqvcNyALsgjDg+QIJZHYkQyiut4Bw4GOXg=;
 b=Dmc0ikHvivpJzktIwlwlalx65TpavYH4kxFl9KSyOh8AdNtdiGO9AHXzThKXFbEjF3PNJnL+9mOraNu6c1XRuEpwXNPfFOiY77GTke6t0kAMuzuVHTUvs2yoJLPsKP4dfsaIenDrDnOJElCA1dyn9E+AWWr/EzePALHGElfg3nUGnOEkaQsiaJtC7i/xW8gWvqkkGFZX07skmPf5IfwUcyZtOKftQbUkm7tw6gkn68U6MRDHrYNpYnP8sba8dyfE+/PB6Qi55NLY8GUiMqL8cIVeKpK/AcMx8J3YI4t8uK0S1LafIwuvEoX/1cIgf4wE4pzqeZaq8tNKfr+douUkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV3PR15MB6720.namprd15.prod.outlook.com (2603:10b6:408:274::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:14:57 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 16:14:57 +0000
From: Song Liu <songliubraving@meta.com>
To: Paulo Alcantara <pc@manguebit.com>
CC: David Howells <dhowells@redhat.com>, Song Liu <song@kernel.org>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
Thread-Topic: [PATCH] netfs: Let netfs depends on PROC_FS
Thread-Index: AQHbp+2OrmtHjsIXLkudu6C3y3JyBbOY8Qa6gABvtACAAH7bAIAAE0GA
Date: Tue, 8 Apr 2025 16:14:57 +0000
Message-ID: <1BEAB585-4A65-475C-85CC-332C98859546@fb.com>
References: <b395436343d8df2efdebb737580fe976@manguebit.com>
 <20250407184730.3568147-1-song@kernel.org>
 <1478622.1744097510@warthog.procyon.org.uk>
 <05f5b9f694ca9b1573ea8e1801098b65@manguebit.com>
In-Reply-To: <05f5b9f694ca9b1573ea8e1801098b65@manguebit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV3PR15MB6720:EE_
x-ms-office365-filtering-correlation-id: 304aa6e5-5ea9-414e-a0c8-08dd76b881aa
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzNFbzVsMjBPNWJSVUd0aUVhTjJwWTBZcmxoOXpMdlAwSCsxNGtxT1NUSk1R?=
 =?utf-8?B?cWliVjY1eml1Qllha0NLVmNzTkNCMGxHTHIzSzZSN2E4NU1RUVhaSDhJZlVG?=
 =?utf-8?B?U3V0OXkxcDRta3M3bkZvVUF2SjJPT3dYZzZJdGlCTzVRaHpocVlUNmxIb2hw?=
 =?utf-8?B?MnpyQ1V5UnF2ZmZBdzhTdG5WQitUQThlV3c0aEtYVnBEbU5aSGpNNkdaM2Z6?=
 =?utf-8?B?Y0N6RGNwZlYxYlAzTjVuT2swQVd5eE9vZi9udXlzYmp3R1BOUEl1WmJSUDZM?=
 =?utf-8?B?bk5zTnFKQ0E4WjF2TnNubFl6YjZtQWZNeS8yS2tDSGUxVnQ4MDlxS2ZRS1FJ?=
 =?utf-8?B?akRRNStBdUIzOFBvMzYzOFI1bWxHQy9ndDU3bEFqTSt1TGE5UnVVVnlxQWls?=
 =?utf-8?B?Z3JvcmVhRVFaVnpJZkE5MjR2clFTT2d3RVRGcmRoU0N3cmE4c2J3cG5lNjJn?=
 =?utf-8?B?MzU3a0NhN1dva05EM2o4ZXpjaFd2ZEQ0czg2bGE2Z29nd0RGazdwaWhXbEdC?=
 =?utf-8?B?SUNhK3daNllWd04yY1JMa095QWhvTVJFa0ZIVk5TdTNobFRVWTJGTGNldGlQ?=
 =?utf-8?B?QlFidFg0L1JZMGFOWUhkMkp3UnNuVVA2amRhbUVCRXRtcjhoL21YM3h4czh5?=
 =?utf-8?B?b2JlTC9hT0V3V1VXMEhqaW5HVkFXYmZONEFlS2VLYzZPdkRhd0draE56R1p0?=
 =?utf-8?B?OHpMNFhmVVF4S05SOXU5aVhPZFRURHBDOWltZEJjbHRpdndXTC9qeTlFUzQ1?=
 =?utf-8?B?bGdpV3k5c1Y4ZVlVZ3UrL1J2bE5WN2FlOEU1NU0zbkRGVVVZZUpsbERYWDBP?=
 =?utf-8?B?Vzk0RW1EMVlMRTZuaS9CV01ZQ1JLdkVtYjNrUzlRbjJaS2ZXS0xkV25GR0wv?=
 =?utf-8?B?Y3RYTjB1VCtITzg5NXBTSjRjd1BQMTB5YVRBdmtyeDg4bDRveG1iRVB3V0FM?=
 =?utf-8?B?L3lPdU9yS0hQcVZkc0dmaXdpZzE3N1BFMDlaOWhXYkR2QWF1RjhkcEdHc0xo?=
 =?utf-8?B?QXp1WnNkZHZwN3JaVnU4T3BVL2hQT21xT2UwVnF1d2plRkpCZTNMRkJ2bzFi?=
 =?utf-8?B?QVRsdkd3aW91ZzR2OEVCMTdTMVMrakJVZTgxTVNVYjgrOHVaS2VwRlpWRmZv?=
 =?utf-8?B?UTQydlNaTlh3Z0d0RVJRVGdvOS9oNlZnc0VNVnhIeXRUUDU2ZzZXWno4T3JK?=
 =?utf-8?B?VThXanZNRE1QYXJMK3lLeklLQi9Yc1kvbVlXeUh4VitsYkh3akUxUnZwTkJP?=
 =?utf-8?B?QllEa1Z2bVo1WXpLZ3ZvaG1JaGJzWVNwUlFHenk0Nk9FQmpvTkxxbjIyaXFl?=
 =?utf-8?B?QzRoaWR2YnlKR0dEbmNTVEdsNm9XUHE0OExxaWpiWFc3aFRtS3lVWXF1RmRC?=
 =?utf-8?B?Q3BMb0Q3aVhWbVJ6OXVGYzlScjl1NmRMOTdLdlpOQUVFaEdrVmlBVkNSTVIw?=
 =?utf-8?B?WDdUa2IxQy9seUVUaGR3UzN2eGpWejBhSHErUmt2amtYU25peXFieDJMWHpY?=
 =?utf-8?B?Qkd5aWE1am5uWHhBOWJLSFpGYWh0MGF5OXZDU25yTHZZeUphY0NtZWllZ3Y1?=
 =?utf-8?B?L0dLTGc1ZUNKenZZVi8yWS9PT1QxS2FmZkNoeDRIY3Z2ZWk2WXpGY0FvUnhF?=
 =?utf-8?B?QlhxSFZTOUFwakIrSkxyN29MSmIxZFY5andSMk9JenpSd0piQzk0ZFNMdTdt?=
 =?utf-8?B?U3IzczJxdnMyV21obU1OcWRpQXdIWTBLTGJTYVRQbkx2TitmcEtiV3dXRDFT?=
 =?utf-8?B?d040Qzhsa3dMcGxBTUxqWW9RRHhTY0hHbk9aREtkc2hpN2hSd1pxV25mQU9M?=
 =?utf-8?B?aGJ0WmNoTEdWRnE5T0xnN1p2Rkl6OXBLaW5aUzdSZ09QOVNjY2wxQ2t4cFVW?=
 =?utf-8?B?bUl6SG9RQ0NONzhoT3ZNOEV3SjlTaFg4QmdKcFEwTVJVRWg4bys1WFFoa2p3?=
 =?utf-8?Q?yEUnBhJApwIDPTreNrgqnZda08L3eZ5n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0lVZXpwQ0ZkSWt6aXVhZURlb1lYaDdhV0QzK1FsK3RYeEt0V2NpY3ZBMFNM?=
 =?utf-8?B?SDEzckFBeVJ6YjAvV1FQcU5ZR1FlaUtRZ0hZMmdWVlFxa3BGU1pHOFFTb0lD?=
 =?utf-8?B?M2FMRUtQaU1INTFYWnFaTkdyS1lRN1kwR1pvOURsQW9kdDVMQXdxSHRwUHI1?=
 =?utf-8?B?bE9ud0E2a2pWaFp4M055ektrNXIxakJldk1FZitLOE1jb2NJNjkwZUNiRk5K?=
 =?utf-8?B?VDVYOEhvUzhOVWNrUUlDV08vNFFraWdBaTRNQng1VWk1T2FqcXVBLzR0RVJh?=
 =?utf-8?B?M1d4ZVdYRXpPUnB3dXBhMzEwQjUwankrK1FETnEyZy82Mnd2eFNsTmlvRXUw?=
 =?utf-8?B?WXdOTzU1SERzWTF4ZldUbmhnVnhqUkN3Qm8zazRUdTVWT3FrYVBITldrZDh5?=
 =?utf-8?B?d3JLUDZtZDdXV0hKRlJ1QjI5dzFZbzBsWlJPK2ZGS3U0Q0R6VG5aMzgwTi9n?=
 =?utf-8?B?bElXRTdWMFdXaHpHdnJkeXJQNHFISFV5Q2ZWME5MS09hUlk4anVsQkFhUTVu?=
 =?utf-8?B?RDlINmFTTVNCVy9hTEhqYUo4cC9rLzJBeC95U1dkeEdSY3JvRXFiOEo2NHZH?=
 =?utf-8?B?MUdUYzNob0Y0ZmREZGR2cEd2NVJWRXMzaG1HSmJPMnpqYVI4ZkRuNjBWT0ZO?=
 =?utf-8?B?VGU2bnpBRXh1cEJmYk16Y3ptRUhRaUN1cHljd2hvM0tYZkN3ZGVvS1JkcmJm?=
 =?utf-8?B?a05nM2tnamtwbmVOR2FZS0lVSVV6SWp6RFlkaUNkekdIMWtyOWJPaGk3TEJW?=
 =?utf-8?B?ZXBQZ252NWU1a3d6LzQ1MVJDY2o3dXhwNzE2MStIeG9lQ3NSbUo2ejlLQTB1?=
 =?utf-8?B?ZGtGOGlzVk5KSTBQc255SHpMQnpIU2VYNDI2OGNKRS9vQk95L3hEd3lEUFNa?=
 =?utf-8?B?Y3RCQ3c3RS9UWmVLUEQxdTV5VWJqYVBGTWRyVmxLbGozOFN4enE1NVhGNlMy?=
 =?utf-8?B?UDVyc201SzgzOWY4aTZHNUNRZEZQakw5ZDZUOEV3WWR5eDMreVkrbmxlcDdG?=
 =?utf-8?B?NzNmRjRmWXRGL1lrZ1k3MERCVGJqQTRSL01rSU55eFpiVStxMkwrdnJ0R3lM?=
 =?utf-8?B?dXpCWnZ2YUtpU0JvWmxJOFdGVEIrSnZmWUdmanZ6RTd2NWF2Z2NrY0xRcVcz?=
 =?utf-8?B?VFRUb0JHTGdpUlZtU2lCUlhRYS8vZ2orMjQza2l1aVl0aGJtWkVPcERQQnpG?=
 =?utf-8?B?UzZ4VjdwL2hiN0FLM2xVRHFKMkRQV1M3R2tCdnE3cHZuSm9iVzk3QzBwekly?=
 =?utf-8?B?UWRqWWlOdkF6M3ZaeERGVWVLQ0duVFIzV1Ezdjc0SERkNVJiN1gwblVGWWFY?=
 =?utf-8?B?QjdRNzlRMkV3Qk9VR2g3anhiRnEzVHBZTHdSSzNnbk1GbURYMUpxYXE4dndV?=
 =?utf-8?B?UElXQkhxcTYyWFJXeTdTUHBVZnRJNHBlMUFkYllLYjhOU1NkbmhFbytDR3M4?=
 =?utf-8?B?TEFuZjFoNmhrNkVNRTBWcnBWNTRBK3M0Y1M3U1Q4K29XVDMyOXRMN2ozdkFI?=
 =?utf-8?B?UTkvem9JbjBnSXQ0WjRxcFozaWJzaFlBcjZIa1RsaGpNUkc1SzhIc2hzRXQx?=
 =?utf-8?B?emJlK0Y2TTVXZm04anVsSkhhM3NjcHl2cDdLbTFCZ2U4a09mZ040dnVLQXhl?=
 =?utf-8?B?cWZFZGxrYzZlNHNYTzFJT2VCVUtLY2Q0TUZlbXVIVEUzaHdBcDIyVkJxNENa?=
 =?utf-8?B?dGdqSU45Rm0vcHNIVUdQWmNiRTl6TUljRExYdkw5ZEx6TWxra2plRTFIRXJr?=
 =?utf-8?B?VnlyU2NaTGt4UUt6ODU5d3ZIaCtuWlFyMWswajBIOUpDbjVxc0ZPUHpSSWla?=
 =?utf-8?B?MDV1eUJtaHYxaCtqTHdVa25BeVhuaXNHNko0b3RRM1hmdG04WVh3ejBBUmZ2?=
 =?utf-8?B?OU50K0ZjclRpREMvbXc4NEZaUXp4R3lvT2U3bnVKWnhWVWozdVMvV3hFZ2F3?=
 =?utf-8?B?L2JYZUdHUjQ0M0crb2R3S3NFVTRNcFNXZlJRbUUvNG15a2tjS05VbjBVb2Zs?=
 =?utf-8?B?WW4xWWdnWXY4THp4ZTdwUkRoYm0wNWlWK0FScXZZODJsVUhNaGFGWU5KckVi?=
 =?utf-8?B?bnVXcGx2Q3B5Szhwd1kxV3UrZ3dOQ0dZcExYd21WR1V3SDArUGtISFZabTNr?=
 =?utf-8?B?NDI5VUNvRUFLZE9SOHRmKzV6U0pYaXZUSGg4T3MzR2RnVjJvS3ZjVGo5QTR2?=
 =?utf-8?Q?jr2Lkg+FpQtzEuT3N8UnMSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44C3E639FB44D0419197F1FC3F98393F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 304aa6e5-5ea9-414e-a0c8-08dd76b881aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 16:14:57.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0sO9avf7/Sq1oOnX0ZdZcGYZwxwJI68ZoHZQhiIRJ18QkDLNHb/xae178VlixdPQjL5TSrQxy60KIlOnAVPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6720
X-Proofpoint-ORIG-GUID: fb3H2LULroicXypQBHva3ATDlaeggb7H
X-Proofpoint-GUID: fb3H2LULroicXypQBHva3ATDlaeggb7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01

SGkgUGF1bG8gYW5kIERhdmlkLCANCg0KPiBPbiBBcHIgOCwgMjAyNSwgYXQgODowNeKAr0FNLCBQ
YXVsbyBBbGNhbnRhcmEgPHBjQG1hbmd1ZWJpdC5jb20+IHdyb3RlOg0KPiANCj4gRGF2aWQgSG93
ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPiANCj4+IFBhdWxvIEFsY2FudGFy
YSA8cGNAbWFuZ3VlYml0LmNvbT4gd3JvdGU6DQo+PiANCj4+PiAoMikgVGhlcmUncyBhIHdyb25n
IGFzc3VtcHRpb24gaW4gdGhlIEFQSSB0aGF0IEBuZXRmc19yZXF1ZXN0X3Bvb2wgYW5kDQo+Pj4g
QG5ldGZzX3N1YnJlcXVlc3RfcG9vbCB3aWxsIGFsd2F5cyBiZSBpbml0aWFsaXplZC4gIEZvciBl
eGFtcGxlLCB3ZQ0KPj4+IHNob3VsZCByZXR1cm4gYW4gZXJyb3IgZnJvbSBuZXRmc19hbGxvY19b
c3ViXXJxdWVzdCgpIGZ1bmN0aW9ucyBpbiBjYXNlDQo+Pj4gQG1lbXBvb2wgPT0gTlVMTC4NCj4+
IA0KPj4gTm8uICBUaGUgYXNzdW1wdGlvbiBpcyBjb3JyZWN0LiAgVGhlIHByb2JsZW0gaXMgdGhh
dCBpZiB0aGUgbW9kdWxlIGlzIGJ1aWx0IGluDQo+PiAoaWUuIENPTkZJR19ORVRGU19TVVBQT1JU
PXkpLCB0aGVuIHRoZXJlIGlzIG5vIGNvbnNlcXVlbmNlIG9mIG5ldGZzX2luaXQoKQ0KPj4gZmFp
bGluZyAtIGFuZCBmYWlsIGl0IGRvZXMgaWYgQ09ORklHX1BST0NfRlM9biAtIGFuZCA5cCwgYWZz
IGFuZCBjaWZzIHdpbGwNCj4+IGNhbGwgaW50byBpdCBhbnl3YXksIGRlc3BpdGUgdGhlIGZhY3Qg
aXQgZGVpbml0aWFsaXNlZCBpdHNlbGYuDQo+PiANCj4+IEl0IHNob3VsZCBtYXJrZWQgYmUgbW9k
dWxlX2luaXQoKSwgbm90IGZzX2luaXRjYWxsKCkuDQo+IA0KPiBNYWtlcyBzZW5zZSwgdGhhbmtz
LiAgSSB0cmllZCB0byByZXByb2R1Y2UgaXQgd2l0aCBjaWZzLmtvIGFuZCBpdCBkaWRuJ3QNCj4g
b29wcyBhcyBuZXRmc2xpYiBlbmRlZCB1cCBub3QgdXNpbmcgdGhlIGRlZmF1bHQgbWVtb3J5IHBv
b2xzIGFzIGNpZnMua28NCj4gYWxyZWFkeSBwcm92aWRlIGl0cyBvd24gbWVtb3J5IHBvb2xzIHZp
YSBuZXRmc19yZXF1ZXN0X29wcy4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIGd1ZXNzIHdl
IHdpbGwgbmVlZCB0aGUgZm9sbG93aW5nIGNoYW5nZXMsIA0KcHJvYmFibHkgaW4gdHdvIHNlcGFy
YXRlIHBhdGNoZXM/DQoNClRoYW5rcywNClNvbmcNCg0KDQpkaWZmIC0tZ2l0IGMvZnMvbmV0ZnMv
bWFpbi5jIHcvZnMvbmV0ZnMvbWFpbi5jDQppbmRleCA0ZTNlNjIwNDA4MzEuLmUxMmY3NTc1ZTY1
NyAxMDA2NDQNCi0tLSBjL2ZzL25ldGZzL21haW4uYw0KKysrIHcvZnMvbmV0ZnMvbWFpbi5jDQpA
QCAtMTI3LDExICsxMjcsMTMgQEAgc3RhdGljIGludCBfX2luaXQgbmV0ZnNfaW5pdCh2b2lkKQ0K
ICAgICAgICBpZiAobWVtcG9vbF9pbml0X3NsYWJfcG9vbCgmbmV0ZnNfc3VicmVxdWVzdF9wb29s
LCAxMDAsIG5ldGZzX3N1YnJlcXVlc3Rfc2xhYikgPCAwKQ0KICAgICAgICAgICAgICAgIGdvdG8g
ZXJyb3Jfc3VicmVxcG9vbDsNCg0KKyNpZmRlZiBDT05GSUdfUFJPQ19GUw0KICAgICAgICBpZiAo
IXByb2NfbWtkaXIoImZzL25ldGZzIiwgTlVMTCkpDQogICAgICAgICAgICAgICAgZ290byBlcnJv
cl9wcm9jOw0KICAgICAgICBpZiAoIXByb2NfY3JlYXRlX3NlcSgiZnMvbmV0ZnMvcmVxdWVzdHMi
LCBTX0lGUkVHIHwgMDQ0NCwgTlVMTCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm5l
dGZzX3JlcXVlc3RzX3NlcV9vcHMpKQ0KICAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfcHJvY2Zp
bGU7DQorI2VuZGlmDQogI2lmZGVmIENPTkZJR19GU0NBQ0hFX1NUQVRTDQogICAgICAgIGlmICgh
cHJvY19jcmVhdGVfc2luZ2xlKCJmcy9uZXRmcy9zdGF0cyIsIFNfSUZSRUcgfCAwNDQ0LCBOVUxM
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXRmc19zdGF0c19zaG93KSkNCkBA
IC0xNTcsNyArMTU5LDcgQEAgc3RhdGljIGludCBfX2luaXQgbmV0ZnNfaW5pdCh2b2lkKQ0KIGVy
cm9yX3JlcToNCiAgICAgICAgcmV0dXJuIHJldDsNCiB9DQotZnNfaW5pdGNhbGwobmV0ZnNfaW5p
dCk7DQorbW9kdWxlX2luaXQobmV0ZnNfaW5pdCk7DQoNCiBzdGF0aWMgdm9pZCBfX2V4aXQgbmV0
ZnNfZXhpdCh2b2lkKQ0KIHs=

