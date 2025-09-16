Return-Path: <linux-fsdevel+bounces-61802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC0B59F6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C8B7B009F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023F313D4A;
	Tue, 16 Sep 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyzjclG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441132727E5;
	Tue, 16 Sep 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044174; cv=fail; b=SmRfXojwC4VDaRRKPQcWri2Q9MBVuV3IMYrmQp1DzP1D7ffLMzCY6VvlJbUMvj7grHTWDMJFWgXKHkZYe2oXpA4l6edD8udcsz1+VEZI1ECLI6pKG4OvuaEKQT0gCLFrL+mvHbvPeEJoJnb/aszcEQGHR1QzHdyXlI0d0HIbc5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044174; c=relaxed/simple;
	bh=91HSeih36GrCbOmI35VE8HJH43VnOCEtiMmgsphB15I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Lkd37bp8TtBNu/yQ3xr1V0y79X4c4r4/hin3FYv1BgbWpMr+cNMFUlrMLWPZ+VWf3504QLrBn9UOGYNrpwC7gvyopQjcQQ0RJELfDQPGW9QKQGmWR2BIgIthdC0Z65v5xdTRBV6fevdmKR4dgOR38/E7CgkTSBeo6QIgJDtnjxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyzjclG+; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDftsr018682;
	Tue, 16 Sep 2025 17:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=91HSeih36GrCbOmI35VE8HJH43VnOCEtiMmgsphB15I=; b=LyzjclG+
	X6C9/MPp1eI3VkLGbX5j3LuMWlpKDXL3c0t1785FGF5NNaiCecfNt7hAhVxuFFM3
	w0eQfZzqUaQ4CsCEm+GNbvemXsAz16ghqmJMbfSHXfJ+LAQbbqO926rFuKEHSYdy
	zVBX3EBqDkxXMeMFizYldXN6Jjt45e3kJ+cTniW6ppjOTyq9fp2fsNR9OCECfW4t
	JBZ+PA1sJTpNwnDsuF7T59el/58zCKQIKMFHFhsTMz5d7GjuLBnQi+Il6RMm3Gah
	X3TGjjhZVKcAKlRCmrGQO4kAtXYJ3De0rVDWJEXYzcoa0M6nhgD2Si4rFB9mIbAI
	lkDPeH8XnVzsYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g538rdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 17:36:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GHa33p025108;
	Tue, 16 Sep 2025 17:36:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g538rdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 17:36:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIAK+K+tVrYRk/D6jjGlgsOQ5lZLp1abNcFy9Uf+aPp6fkwO7kcCO8nhjEAuIOG7zWkC0K14kxpYfyUQc7aczhbo56T1psYBiWZEH6PVCkQmJpgzZYCLw4ouHpJDEganparpMhoVwykjXhuqZp0awp/wiwgYecHplSm5QS6s3Jq3QNkYa1BaeQLGUXjccwQUwJ3J6MzN7irjRtYu9w1Qdhhs4jP68IfYHHmEIX4dj5W6UAv3YtPf4lBJA/kLtC4IA9o/bjUzp4xcEMflSX+H36Gqi8a37mIqxjgaB5yzzEDTq2tQEaThlxr+fCPVPUY0vXcUKCJvI1YYTU5oDnJqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91HSeih36GrCbOmI35VE8HJH43VnOCEtiMmgsphB15I=;
 b=W41UhOYpnJBEZ3Srfz4+JxcC2y9TgaxusIYQTZhdkfWOCAeN78gzXlnAoQ4FqmocVL4BKHnnSxPW+LKr9rGtOTLCOJ6JR+PNl9ApZU8vRz+4odRFXHIf0tWAFyZOSzPttwt1OddavqVntrFLBCx4x+WpUbdxJ6a/dxtnxOYKvj3FtDRXcNOve8N5l4asJg7Hjh+udUTzIUMKgas8rwDybysydgRyz9pyED/NQ8h42eSmIickMurogUC8fivZtuFxXonKQpU6CG+WnEAnkFncLWAsah1r157oDNYp13yFiN/tAFpiJBoqcy1WX1gGiW75/jVQjPMAzvPh1oSfX4YfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF7270A6035.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 17:36:01 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9094.021; Tue, 16 Sep 2025
 17:36:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "mjguzik@gmail.com"
	<mjguzik@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v4 10/12] ceph: use the new ->i_state
 accessors
Thread-Index: AQHcJxNpvTvhhl9+e06fM1Qrf/i8/7SWEpQA
Date: Tue, 16 Sep 2025 17:36:00 +0000
Message-ID: <81eada571cb7892a5df26e50884ed0cbeed6220e.camel@ibm.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
	 <20250916135900.2170346-11-mjguzik@gmail.com>
In-Reply-To: <20250916135900.2170346-11-mjguzik@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF7270A6035:EE_
x-ms-office365-filtering-correlation-id: 0b1d6048-1268-4871-8564-08ddf54780cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFlaSjhIazNocytGZU90NFdDQUlWUzJhL2NsaS9SWWJpVTFLbFJMK3Y1S1Az?=
 =?utf-8?B?TldCVWROOWFOc1JQbXI0MVRvSktRamw4Z0F1cEQ5WkhoR1djb0pZRHF6WHJK?=
 =?utf-8?B?MVRRY2MrdkNkR3RMTU8zQzlJRW5PbzRIK1NMU000dFc2b1VOa3h3K3VVbHVJ?=
 =?utf-8?B?VzVQNFBOTjBDWFc4VmtvajZlcVRtMlJHU0krVXFHVEcyQ2RhdkRIRzZxdjg4?=
 =?utf-8?B?dzlqS2o2aTEwSDh3MjhjU3hKSDAzeUV2Ym1DOGdNemIyUjBKa2grdEFrWUtv?=
 =?utf-8?B?SnhNbzBRa0h5b1VjKzRMdlUwK2hRQm9uUEIwZ21oUlFQU3MzMytLVWwwOTZ2?=
 =?utf-8?B?RHlhY2o4azNuT1FTMjlmeG1ad3UybUIyYTQ2RWR1Qk5oVituajBjdko2VCtM?=
 =?utf-8?B?M2lqaUl5L2VobUdGR0piMFVUK0pydU1MNmFKS0VFUUlVSDE1NU84RnViQWoy?=
 =?utf-8?B?MUg2aVoyOXU2YVlGd0NuMDE3a1U1STNTbmgrZ2x4M2tweWIwMjhuczVTc0Qr?=
 =?utf-8?B?Ukl3N2V5dmxBdm16Z3UxQmdUU1JPMUl3dERhVzVOcWU3MisxekN0NytiMVls?=
 =?utf-8?B?aVR1Tk1ETWdBL3JRU1B6ajZqZGw2WE5ZekYzYkV5ejY2aUJXMlo5L21SNjVX?=
 =?utf-8?B?NTB1VU51YThYSy9jWEg5ZTNHYUoxQnJYTnNnYlI0a2dYMldvSmgyYTduVlg1?=
 =?utf-8?B?NEJnV0JjSmxiakh2eDB2dVkzK3pnR2Fnd084SFhUMUJWcU05ZFlORHlrS0ph?=
 =?utf-8?B?bEVhWG9hSitSVEFWcittem9kbkZKdytNVHByYWlzVlFJSnBBamE2TzVCRzFo?=
 =?utf-8?B?SHlVQVByUW5Td05hM01INjVCZ0l4d3E0NGRsU21uODFPaHFYZEpMWUpONjdj?=
 =?utf-8?B?M3pBaG9pSDRLTXoyTWhQbFNvNVlKLzhnblBBVEo4WW5lcmtjeDJ3UUZVWTQw?=
 =?utf-8?B?a3krZGV6YnZqT3F3endPWUloSCt3NVNTVlhad1VhOElnSERxWTFmekxqZytX?=
 =?utf-8?B?RHV6U1BVQTMyNXd0NDg4V29FWkdSL2tpcC85K050TXlxY0l2RjloNlBsd3pa?=
 =?utf-8?B?TEorelgrQ2szV3doS3lGZVRHWTZoTG1ocUsxY3FDUU9HdU01WUhuZnZMNm10?=
 =?utf-8?B?NWxkNjZQVnB4SmN4VTdUVG1xVWJzZk1CYXpwbGNSYzlFQmlrZGdEZzNhOHN4?=
 =?utf-8?B?dTNOc2hJeWc1RDY5RUNyUEJhdXpZanJ2L25sSEhBYzlxNm5yZ1BoWWxYYnlo?=
 =?utf-8?B?bVl6M3RZaDA3OTExWU11bkNFMWJrVFNuZC9tUWUxK0JhVDd2dGVUK2ZtYXBL?=
 =?utf-8?B?TVFybUkvWTJCM0piekN6dEEzbE5WaGJHakVsY290WE9KSFlCTHFVd1Z2K3Jy?=
 =?utf-8?B?OGhtNnZyM1RLY2FuV09ka2pYTWloQ1QvZG83TEF0RnRoWVQ1TWxvWU43ZzNp?=
 =?utf-8?B?aG5qakVGYm9seUFlOVovNVdOT0dGbE9DbkhOYkFoNldtYXY4ZUJBMVlHbHpM?=
 =?utf-8?B?RW81WERMYTZPVUwxRnI0SkZiNGxCbktqd1FkV285c3UwdHpCYWhzdndSZitR?=
 =?utf-8?B?Q2FYYXdvdEoyVHo1VmswUFVmSmJtTWdERWE3aFNEcTN3N0plandsaFI3RUho?=
 =?utf-8?B?clNCOHMxWE1KRXhneUc1M1owM2RZaWErTVNOTE1HUE53ZndDYTRoZUo4UkNU?=
 =?utf-8?B?QjU4UnJub2U1K1I3UndqOVZzbFM4QSthK3dyK0MrV2NvZGdLWU1qWXVJMFJy?=
 =?utf-8?B?eTJNSEozc2tkSHYvSjRwNVg0K3M1S2NGVDBtc0dGMm1Da0xTMGg3alBhamJ2?=
 =?utf-8?B?akxpZGVGa1RoWDMyQm9sREhzRXJTTFpqdWNsQUJQZmkvcnJJRnBXOVEvY3Rr?=
 =?utf-8?B?ckVTdVVvQzdQTjZhK3ZCZkhwYVRMSVFHWmtwL05wS29ML1NxY0RHaFBpeEpS?=
 =?utf-8?B?OE5penM0UmlESjJzN3JjNmZjeURyV1BYVHErQVYzNVhyT0ZmVzBqVlJoc2RV?=
 =?utf-8?B?bHMrYTd0cmdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anJSbjJvMFloM09RZWdYazVTOE5lTkV1dTlNeFZZbG4vRzRnOVpqc3I2RnJ6?=
 =?utf-8?B?MHhST1RvMm1ObGlIeFVvK1BiZStsRi80RUZyMWx5OFh2YkUyUE9HeElpTGNV?=
 =?utf-8?B?aEVpMXIvUitHZnJYR09TeDMrKzJnTGp3cXRoQ1V4cWI0TlBTTm9jWGUrZy81?=
 =?utf-8?B?RmlDbGJkYWFFdWo1MVF3WGFSb2o1V1hvejROL0thUU5pSmgzMUlLM0ExNng3?=
 =?utf-8?B?Tm5mQlhnYXVmcFlGZFRUaEd5RlZDUWdOZWVTWWNqMkU0amlXRFhodnArYWFw?=
 =?utf-8?B?ZzRTOUdBNDdsbDV0S3JCWHQ2ak01VUwwdWtYd1ZtS0huTktiRzZwTThSV1JL?=
 =?utf-8?B?TGdNemJlN0dYQ01FM0NCd3FmM0YwazA5SG5iMzl5SEpPMndNeDRheFczckpz?=
 =?utf-8?B?eWQzb0lpN3NYaXBJcThLblB0UmV6Vmt1bUhMelBCRVh1dm80VXBqeXBGSTNy?=
 =?utf-8?B?N1Vic2RVU1k5U3pBNXArVVk3VzRyQ1RrZTU5S21yeFIvRi9NdTJuYy92SHNo?=
 =?utf-8?B?Vm1nNnVoWFBqMU40V0RxODBYbEc4cWJLQndrbGRGVEkvR3VoRCtIc2wrMksy?=
 =?utf-8?B?c01xOVNjY083anE4NFZUM2F5eSsrZ1Z6OEpWOWJFNmx6QVNqZExnbHdtWmRo?=
 =?utf-8?B?UldTMklDSjk4YkdRLzNvWDB2emFqSms0bGE1d2FTQTVHNkhLUGUvWCsycjJC?=
 =?utf-8?B?SWhWOWhpSU9UalIyMGc5ZkM5d3BEWGo2Z1BDdzVnWkNYcktoRmYxM09jM1BB?=
 =?utf-8?B?aFJSbXEvbnhnczBLTHVnUEp3aXNjdDdMSlZ4TXU1WU15cVpvUEU0cHkvcGZn?=
 =?utf-8?B?YnBha3Bab1NwNDNmRVJwQXVnYm53ZFQwMzBZUmNEdkVLUWNYQ1haSGpaalVW?=
 =?utf-8?B?c04yb1JJMnBpc1hIQUtoejEvMlZ0aHdHb1Q1SlpKTzJqNk9zN1JPb1NpYkxR?=
 =?utf-8?B?d3BON2hXQ0dMNXR6eTY4azMvbFdjNVJUSGUwejQyU0wrYWtIZTIwZndkZmR0?=
 =?utf-8?B?NWJMMkVkc3NHU2diUDdTeVFkK2Fld1hYdGxhUklYeGszUUN3SkFWMGNSdHN5?=
 =?utf-8?B?TDJ1eG9pQWtyKzZnY2xHbUFiMlY0NE96QlgxUlllVi9XbUZoK2EycGRkcGRq?=
 =?utf-8?B?by9zMUdrSER1MEw1Q0lab1pRK2VuUlVaOU53eWZ3MDFqa0ZhSk13SHhZOG1j?=
 =?utf-8?B?bXdvTEo0UHEwSzFhdWJSZmpVMHdmTFU1ZkJyRlI4TWZ4aHpRZ3owODhtRytB?=
 =?utf-8?B?S1JlOFg1YUVzcnVDZWM1UVNkcVRDd2hmZTROK3F2dUJWaXZLYjdVZnVOVWY4?=
 =?utf-8?B?Z0U0dHlMNFVOY1JVY0hGQ2lRV2lwVTFqZ1FNMm5uTHlLL3JhM0JFamJXMm1k?=
 =?utf-8?B?QzM5elFDcURQTE1JOVhVMmpVM29CZjN4SHF4YVhFTnFJVjlZQldkKzhqNEZx?=
 =?utf-8?B?T2l4cThTckg1M2Q3VzAwRXVHNGtMQjN4TzRCQnAxUzBsN3pTT1kvckhUdGxR?=
 =?utf-8?B?SG1JeHMxVDNSN3NVd3lzT3hyYktGODdtYkhrU1A4ejE3SUcxamlOMVF2UXc0?=
 =?utf-8?B?YWZhTXpxRFRKQU5tNUFEb1VxOG9qeE1KOFF5VlM3UTdHeHJDUnZkdlNNSi9a?=
 =?utf-8?B?V2lleDJGYmRveEF3bnhtd2dVY0VaTkxOSFdHaXl4UTZQLzMxaStTcUc1UDBi?=
 =?utf-8?B?ZjBJZHFHN0V5THk1MnZNcjFzV0kwUUpJNFYrR0lBUnVUY3FuSkVCdGNUL2ZZ?=
 =?utf-8?B?MHRscER4Unl0S3R5RThReWZIOS9wRnMzamR2a0U4Q25vc1d0cW9jaisyRUVx?=
 =?utf-8?B?OUd0M2dmK3BaTklNT1JSVlpmT0JrUHNrTjhRSHkrd0pocEJNZTBsOVpHNk5h?=
 =?utf-8?B?RFZGelRnRFQwdlVoY1M0NWt2T1FpREg0UEl0Yzh3WGNHM2FaQjQxM2laWWdw?=
 =?utf-8?B?WHZndXZLcVVkZDNsMXY4YXNFdmc2OGtzeUVIeUtiSmUrUEpZa05RSVFLL1dE?=
 =?utf-8?B?ZG92bnlHbHN2Vys1alFtbFF0ejJtZG5hOXRGOGEwelJlelh1MWdZamZxQkdG?=
 =?utf-8?B?UEpoZWpCTjd3SkZPY2o1dVZucC9SQ3ZiazNBaXY0T2x0OTBtcFhqSG9BWVpW?=
 =?utf-8?B?bllidXFOTUY5cTc1VlVMOUhRbFJEZWlIUUhsU1YyY2VrWXQ5bDRzUXlXTXRU?=
 =?utf-8?Q?hVtRRS07RNfeDZfwOTiPqo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <180A6A7E175BEA4C86BF553BE3C5211F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d6048-1268-4871-8564-08ddf54780cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 17:36:00.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNDrNPQvk6qy+zntAQAU1W8++W26cXZTegafArAcQweTUDw4cKj5uL2L6+pq1NSsYFLF5uL/iSgYqIFXB2hZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF7270A6035
X-Proofpoint-GUID: 1BIG1N1RfnxsLH44wCtnNSJmp9-pjO6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX7WQe9aOhDROd
 OD6bsmT6QuzV9C+1Pbc7S7kVIIDXSUxdr0KjzwNufsIKpP2TO6BEzkOioiKCOr05kBTzgNQHE3u
 640WNYlmlg1Vbsx5LtYfLUv883ou4ZDEWLnmHR0OifIQ3GAWk3rjs9AmfKS/zMy4cEm4/pO/gEB
 BEc77/3ZDSxR1euhbQyHmg6mAAD3qekuKPozdyAn4RSZ1rDIngLp3pIPql9TNtaYMWbVMo//lVC
 PuSRfW19AT02nUSOz+Y68YCZKj+G2PzRm0w3LuIZJ8vHpW0comWK5udpQhB/hGnejQ/EKl3tCUu
 SXgqNNyzYBYHCAiEeF0zkov1j7Au/+1tA4N6uXtuyGOwAEAf9LWv+3JpKFVTgjDo/AQeubDY8ZK
 NsCpjq13
X-Proofpoint-ORIG-GUID: xyHWoD-cNs65w-vTRK6de2zbOfq74LEa
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c9a004 cx=c_pps
 a=r7BTcVhh5lrtolT442nWtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=heQgEUe2F3uB5VL7DJ0A:9
 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH v4 10/12] ceph: use the new ->i_state accessors
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

T24gVHVlLCAyMDI1LTA5LTE2IGF0IDE1OjU4ICswMjAwLCBNYXRldXN6IEd1emlrIHdyb3RlOg0K
PiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZSBhbmQgZml4ZWQgdXAgYnkgaGFuZCBh
cyBhcHByb3ByaWF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdGV1c3ogR3V6aWsgPG1qZ3V6
aWtAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvY2FjaGUuYyAgfCAgMiArLQ0KPiAgZnMv
Y2VwaC9jcnlwdG8uYyB8ICA0ICsrLS0NCj4gIGZzL2NlcGgvZmlsZS5jICAgfCAgNCArKy0tDQo+
ICBmcy9jZXBoL2lub2RlLmMgIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAg
NCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQoN
Ckxvb2tzIGdvb2QuIEkgc2ltcGx5IHN0YXJ0ZWQgdG8gZ3Vlc3MuIERvIHdlIG5lZWQgYSBtZXRo
b2Qgc29tZXRoaW5nIGxpa2UgdGhpcz8NCg0KYm9vbCBpbm9kZV9pc19uZXcoc3RydWN0IGlub2Rl
ICppbm9kZSkNCnsNCiAgICByZXR1cm4gaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGlub2RlKSAmIElf
TkVXOw0KfQ0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtv
QGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0KDQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2Nh
Y2hlLmMgYi9mcy9jZXBoL2NhY2hlLmMNCj4gaW5kZXggOTMwZmJkNTRkMmM4Li5mNjc4YmFiMTg5
ZDggMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvY2FjaGUuYw0KPiArKysgYi9mcy9jZXBoL2NhY2hl
LmMNCj4gQEAgLTI2LDcgKzI2LDcgQEAgdm9pZCBjZXBoX2ZzY2FjaGVfcmVnaXN0ZXJfaW5vZGVf
Y29va2llKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAgCS8qIE9u
bHkgbmV3IGlub2RlcyEgKi8NCj4gLQlpZiAoIShpbm9kZS0+aV9zdGF0ZSAmIElfTkVXKSkNCj4g
KwlpZiAoIShpbm9kZV9zdGF0ZV9yZWFkX29uY2UoaW5vZGUpICYgSV9ORVcpKQ0KPiAgCQlyZXR1
cm47DQo+ICANCj4gIAlXQVJOX09OX09OQ0UoY2ktPm5ldGZzLmNhY2hlKTsNCj4gZGlmZiAtLWdp
dCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+IGluZGV4IDcwMjZlNzk0
ODEzYy4uOTI4NzQ2YjkyNTEyIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsr
KyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gQEAgLTMyOSw3ICszMjksNyBAQCBpbnQgY2VwaF9lbmNv
ZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50LCBjaGFyICpidWYsIGludCBl
bGVuKQ0KPiAgb3V0Og0KPiAgCWtmcmVlKGNyeXB0YnVmKTsNCj4gIAlpZiAoZGlyICE9IHBhcmVu
dCkgew0KPiAtCQlpZiAoKGRpci0+aV9zdGF0ZSAmIElfTkVXKSkNCj4gKwkJaWYgKChpbm9kZV9z
dGF0ZV9yZWFkX29uY2UoZGlyKSAmIElfTkVXKSkNCj4gIAkJCWRpc2NhcmRfbmV3X2lub2RlKGRp
cik7DQo+ICAJCWVsc2UNCj4gIAkJCWlwdXQoZGlyKTsNCj4gQEAgLTQzOCw3ICs0MzgsNyBAQCBp
bnQgY2VwaF9mbmFtZV90b191c3IoY29uc3Qgc3RydWN0IGNlcGhfZm5hbWUgKmZuYW1lLCBzdHJ1
Y3QgZnNjcnlwdF9zdHIgKnRuYW1lLA0KPiAgCWZzY3J5cHRfZm5hbWVfZnJlZV9idWZmZXIoJl90
bmFtZSk7DQo+ICBvdXRfaW5vZGU6DQo+ICAJaWYgKGRpciAhPSBmbmFtZS0+ZGlyKSB7DQo+IC0J
CWlmICgoZGlyLT5pX3N0YXRlICYgSV9ORVcpKQ0KPiArCQlpZiAoKGlub2RlX3N0YXRlX3JlYWRf
b25jZShkaXIpICYgSV9ORVcpKQ0KPiAgCQkJZGlzY2FyZF9uZXdfaW5vZGUoZGlyKTsNCj4gIAkJ
ZWxzZQ0KPiAgCQkJaXB1dChkaXIpOw0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9maWxlLmMgYi9m
cy9jZXBoL2ZpbGUuYw0KPiBpbmRleCBjMDJmMTAwZjg1NTIuLjU5ZjJiZTQxYzlhYSAxMDA2NDQN
Cj4gLS0tIGEvZnMvY2VwaC9maWxlLmMNCj4gKysrIGIvZnMvY2VwaC9maWxlLmMNCj4gQEAgLTc0
NCw3ICs3NDQsNyBAQCBzdGF0aWMgaW50IGNlcGhfZmluaXNoX2FzeW5jX2NyZWF0ZShzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGlub2RlICppbm9kZSwNCj4gIAkJICAgICAgdmluby5pbm8sIGNl
cGhfaW5vKGRpciksIGRlbnRyeS0+ZF9uYW1lLm5hbWUpOw0KPiAgCQljZXBoX2Rpcl9jbGVhcl9v
cmRlcmVkKGRpcik7DQo+ICAJCWNlcGhfaW5pdF9pbm9kZV9hY2xzKGlub2RlLCBhc19jdHgpOw0K
PiAtCQlpZiAoaW5vZGUtPmlfc3RhdGUgJiBJX05FVykgew0KPiArCQlpZiAoaW5vZGVfc3RhdGVf
cmVhZF9vbmNlKGlub2RlKSAmIElfTkVXKSB7DQo+ICAJCQkvKg0KPiAgCQkJICogSWYgaXQncyBu
b3QgSV9ORVcsIHRoZW4gc29tZW9uZSBjcmVhdGVkIHRoaXMgYmVmb3JlDQo+ICAJCQkgKiB3ZSBn
b3QgaGVyZS4gQXNzdW1lIHRoZSBzZXJ2ZXIgaXMgYXdhcmUgb2YgaXQgYXQNCj4gQEAgLTkwNyw3
ICs5MDcsNyBAQCBpbnQgY2VwaF9hdG9taWNfb3BlbihzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0
IGRlbnRyeSAqZGVudHJ5LA0KPiAgCQkJCW5ld19pbm9kZSA9IE5VTEw7DQo+ICAJCQkJZ290byBv
dXRfcmVxOw0KPiAgCQkJfQ0KPiAtCQkJV0FSTl9PTl9PTkNFKCEobmV3X2lub2RlLT5pX3N0YXRl
ICYgSV9ORVcpKTsNCj4gKwkJCVdBUk5fT05fT05DRSghKGlub2RlX3N0YXRlX3JlYWRfb25jZShu
ZXdfaW5vZGUpICYgSV9ORVcpKTsNCj4gIA0KPiAgCQkJc3Bpbl9sb2NrKCZkZW50cnktPmRfbG9j
ayk7DQo+ICAJCQlkaS0+ZmxhZ3MgfD0gQ0VQSF9ERU5UUllfQVNZTkNfQ1JFQVRFOw0KPiBkaWZm
IC0tZ2l0IGEvZnMvY2VwaC9pbm9kZS5jIGIvZnMvY2VwaC9pbm9kZS5jDQo+IGluZGV4IDQ4MGNi
M2ExZDYzOS4uNjc4NmVjOTU1YTg3IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2lub2RlLmMNCj4g
KysrIGIvZnMvY2VwaC9pbm9kZS5jDQo+IEBAIC04Niw3ICs4Niw3IEBAIHN0cnVjdCBpbm9kZSAq
Y2VwaF9uZXdfaW5vZGUoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwN
Cj4gIAkJCWdvdG8gb3V0X2VycjsNCj4gIAl9DQo+ICANCj4gLQlpbm9kZS0+aV9zdGF0ZSA9IDA7
DQo+ICsJaW5vZGVfc3RhdGVfc2V0X3Jhdyhpbm9kZSwgMCk7DQo+ICAJaW5vZGUtPmlfbW9kZSA9
ICptb2RlOw0KPiAgDQo+ICAJZXJyID0gY2VwaF9zZWN1cml0eV9pbml0X3NlY2N0eChkZW50cnks
ICptb2RlLCBhc19jdHgpOw0KPiBAQCAtMTU1LDcgKzE1NSw3IEBAIHN0cnVjdCBpbm9kZSAqY2Vw
aF9nZXRfaW5vZGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGNlcGhfdmlubyB2aW5v
LA0KPiAgDQo+ICAJZG91dGMoY2wsICJvbiAlbGx4PSVsbHguJWxseCBnb3QgJXAgbmV3ICVkXG4i
LA0KPiAgCSAgICAgIGNlcGhfcHJlc2VudF9pbm9kZShpbm9kZSksIGNlcGhfdmlub3AoaW5vZGUp
LCBpbm9kZSwNCj4gLQkgICAgICAhIShpbm9kZS0+aV9zdGF0ZSAmIElfTkVXKSk7DQo+ICsJICAg
ICAgISEoaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGlub2RlKSAmIElfTkVXKSk7DQo+ICAJcmV0dXJu
IGlub2RlOw0KPiAgfQ0KPiAgDQo+IEBAIC0xODIsNyArMTgyLDcgQEAgc3RydWN0IGlub2RlICpj
ZXBoX2dldF9zbmFwZGlyKHN0cnVjdCBpbm9kZSAqcGFyZW50KQ0KPiAgCQlnb3RvIGVycjsNCj4g
IAl9DQo+ICANCj4gLQlpZiAoIShpbm9kZS0+aV9zdGF0ZSAmIElfTkVXKSAmJiAhU19JU0RJUihp
bm9kZS0+aV9tb2RlKSkgew0KPiArCWlmICghKGlub2RlX3N0YXRlX3JlYWRfb25jZShpbm9kZSkg
JiBJX05FVykgJiYgIVNfSVNESVIoaW5vZGUtPmlfbW9kZSkpIHsNCj4gIAkJcHJfd2Fybl9vbmNl
X2NsaWVudChjbCwgImJhZCBzbmFwZGlyIGlub2RlIHR5cGUgKG1vZGU9MCVvKVxuIiwNCj4gIAkJ
CQkgICAgaW5vZGUtPmlfbW9kZSk7DQo+ICAJCWdvdG8gZXJyOw0KPiBAQCAtMjE1LDcgKzIxNSw3
IEBAIHN0cnVjdCBpbm9kZSAqY2VwaF9nZXRfc25hcGRpcihzdHJ1Y3QgaW5vZGUgKnBhcmVudCkN
Cj4gIAkJfQ0KPiAgCX0NCj4gICNlbmRpZg0KPiAtCWlmIChpbm9kZS0+aV9zdGF0ZSAmIElfTkVX
KSB7DQo+ICsJaWYgKGlub2RlX3N0YXRlX3JlYWRfb25jZShpbm9kZSkgJiBJX05FVykgew0KPiAg
CQlpbm9kZS0+aV9vcCA9ICZjZXBoX3NuYXBkaXJfaW9wczsNCj4gIAkJaW5vZGUtPmlfZm9wID0g
JmNlcGhfc25hcGRpcl9mb3BzOw0KPiAgCQljaS0+aV9zbmFwX2NhcHMgPSBDRVBIX0NBUF9QSU47
IC8qIHNvIHdlIGNhbiBvcGVuICovDQo+IEBAIC0yMjQsNyArMjI0LDcgQEAgc3RydWN0IGlub2Rl
ICpjZXBoX2dldF9zbmFwZGlyKHN0cnVjdCBpbm9kZSAqcGFyZW50KQ0KPiAgDQo+ICAJcmV0dXJu
IGlub2RlOw0KPiAgZXJyOg0KPiAtCWlmICgoaW5vZGUtPmlfc3RhdGUgJiBJX05FVykpDQo+ICsJ
aWYgKChpbm9kZV9zdGF0ZV9yZWFkX29uY2UoaW5vZGUpICYgSV9ORVcpKQ0KPiAgCQlkaXNjYXJk
X25ld19pbm9kZShpbm9kZSk7DQo+ICAJZWxzZQ0KPiAgCQlpcHV0KGlub2RlKTsNCj4gQEAgLTY5
OCw3ICs2OTgsNyBAQCB2b2lkIGNlcGhfZXZpY3RfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkN
Cj4gIA0KPiAgCW5ldGZzX3dhaXRfZm9yX291dHN0YW5kaW5nX2lvKGlub2RlKTsNCj4gIAl0cnVu
Y2F0ZV9pbm9kZV9wYWdlc19maW5hbCgmaW5vZGUtPmlfZGF0YSk7DQo+IC0JaWYgKGlub2RlLT5p
X3N0YXRlICYgSV9QSU5OSU5HX05FVEZTX1dCKQ0KPiArCWlmIChpbm9kZV9zdGF0ZV9yZWFkX29u
Y2UoaW5vZGUpICYgSV9QSU5OSU5HX05FVEZTX1dCKQ0KPiAgCQljZXBoX2ZzY2FjaGVfdW51c2Vf
Y29va2llKGlub2RlLCB0cnVlKTsNCj4gIAljbGVhcl9pbm9kZShpbm9kZSk7DQo+ICANCj4gQEAg
LTk2Nyw3ICs5NjcsNyBAQCBpbnQgY2VwaF9maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBwYWdlICpsb2NrZWRfcGFnZSwNCj4gIAkgICAgICBsZTY0X3RvX2NwdShpbmZvLT52
ZXJzaW9uKSwgY2ktPmlfdmVyc2lvbik7DQo+ICANCj4gIAkvKiBPbmNlIElfTkVXIGlzIGNsZWFy
ZWQsIHdlIGNhbid0IGNoYW5nZSB0eXBlIG9yIGRldiBudW1iZXJzICovDQo+IC0JaWYgKGlub2Rl
LT5pX3N0YXRlICYgSV9ORVcpIHsNCj4gKwlpZiAoaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGlub2Rl
KSAmIElfTkVXKSB7DQo+ICAJCWlub2RlLT5pX21vZGUgPSBtb2RlOw0KPiAgCX0gZWxzZSB7DQo+
ICAJCWlmIChpbm9kZV93cm9uZ190eXBlKGlub2RlLCBtb2RlKSkgew0KPiBAQCAtMTA0NCw3ICsx
MDQ0LDcgQEAgaW50IGNlcGhfZmlsbF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
cGFnZSAqbG9ja2VkX3BhZ2UsDQo+ICANCj4gICNpZmRlZiBDT05GSUdfRlNfRU5DUllQVElPTg0K
PiAgCWlmIChpaW5mby0+ZnNjcnlwdF9hdXRoX2xlbiAmJg0KPiAtCSAgICAoKGlub2RlLT5pX3N0
YXRlICYgSV9ORVcpIHx8IChjaS0+ZnNjcnlwdF9hdXRoX2xlbiA9PSAwKSkpIHsNCj4gKwkgICAg
KChpbm9kZV9zdGF0ZV9yZWFkX29uY2UoaW5vZGUpICYgSV9ORVcpIHx8IChjaS0+ZnNjcnlwdF9h
dXRoX2xlbiA9PSAwKSkpIHsNCj4gIAkJa2ZyZWUoY2ktPmZzY3J5cHRfYXV0aCk7DQo+ICAJCWNp
LT5mc2NyeXB0X2F1dGhfbGVuID0gaWluZm8tPmZzY3J5cHRfYXV0aF9sZW47DQo+ICAJCWNpLT5m
c2NyeXB0X2F1dGggPSBpaW5mby0+ZnNjcnlwdF9hdXRoOw0KPiBAQCAtMTYzOCwxMyArMTYzOCwx
MyBAQCBpbnQgY2VwaF9maWxsX3RyYWNlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBj
ZXBoX21kc19yZXF1ZXN0ICpyZXEpDQo+ICAJCQlwcl9lcnJfY2xpZW50KGNsLCAiYmFkbmVzcyAl
cCAlbGx4LiVsbHhcbiIsIGluLA0KPiAgCQkJCSAgICAgIGNlcGhfdmlub3AoaW4pKTsNCj4gIAkJ
CXJlcS0+cl90YXJnZXRfaW5vZGUgPSBOVUxMOw0KPiAtCQkJaWYgKGluLT5pX3N0YXRlICYgSV9O
RVcpDQo+ICsJCQlpZiAoaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGluKSAmIElfTkVXKQ0KPiAgCQkJ
CWRpc2NhcmRfbmV3X2lub2RlKGluKTsNCj4gIAkJCWVsc2UNCj4gIAkJCQlpcHV0KGluKTsNCj4g
IAkJCWdvdG8gZG9uZTsNCj4gIAkJfQ0KPiAtCQlpZiAoaW4tPmlfc3RhdGUgJiBJX05FVykNCj4g
KwkJaWYgKGlub2RlX3N0YXRlX3JlYWRfb25jZShpbikgJiBJX05FVykNCj4gIAkJCXVubG9ja19u
ZXdfaW5vZGUoaW4pOw0KPiAgCX0NCj4gIA0KPiBAQCAtMTgzMCwxMSArMTgzMCwxMSBAQCBzdGF0
aWMgaW50IHJlYWRkaXJfcHJlcG9wdWxhdGVfaW5vZGVzX29ubHkoc3RydWN0IGNlcGhfbWRzX3Jl
cXVlc3QgKnJlcSwNCj4gIAkJCXByX2Vycl9jbGllbnQoY2wsICJpbm9kZSBiYWRuZXNzIG9uICVw
IGdvdCAlZFxuIiwgaW4sDQo+ICAJCQkJICAgICAgcmMpOw0KPiAgCQkJZXJyID0gcmM7DQo+IC0J
CQlpZiAoaW4tPmlfc3RhdGUgJiBJX05FVykgew0KPiArCQkJaWYgKGlub2RlX3N0YXRlX3JlYWRf
b25jZShpbikgJiBJX05FVykgew0KPiAgCQkJCWlob2xkKGluKTsNCj4gIAkJCQlkaXNjYXJkX25l
d19pbm9kZShpbik7DQo+ICAJCQl9DQo+IC0JCX0gZWxzZSBpZiAoaW4tPmlfc3RhdGUgJiBJX05F
Vykgew0KPiArCQl9IGVsc2UgaWYgKGlub2RlX3N0YXRlX3JlYWRfb25jZShpbikgJiBJX05FVykg
ew0KPiAgCQkJdW5sb2NrX25ld19pbm9kZShpbik7DQo+ICAJCX0NCj4gIA0KPiBAQCAtMjA0Niw3
ICsyMDQ2LDcgQEAgaW50IGNlcGhfcmVhZGRpcl9wcmVwb3B1bGF0ZShzdHJ1Y3QgY2VwaF9tZHNf
cmVxdWVzdCAqcmVxLA0KPiAgCQkJcHJfZXJyX2NsaWVudChjbCwgImJhZG5lc3Mgb24gJXAgJWxs
eC4lbGx4XG4iLCBpbiwNCj4gIAkJCQkgICAgICBjZXBoX3Zpbm9wKGluKSk7DQo+ICAJCQlpZiAo
ZF9yZWFsbHlfaXNfbmVnYXRpdmUoZG4pKSB7DQo+IC0JCQkJaWYgKGluLT5pX3N0YXRlICYgSV9O
RVcpIHsNCj4gKwkJCQlpZiAoaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGluKSAmIElfTkVXKSB7DQo+
ICAJCQkJCWlob2xkKGluKTsNCj4gIAkJCQkJZGlzY2FyZF9uZXdfaW5vZGUoaW4pOw0KPiAgCQkJ
CX0NCj4gQEAgLTIwNTYsNyArMjA1Niw3IEBAIGludCBjZXBoX3JlYWRkaXJfcHJlcG9wdWxhdGUo
c3RydWN0IGNlcGhfbWRzX3JlcXVlc3QgKnJlcSwNCj4gIAkJCWVyciA9IHJldDsNCj4gIAkJCWdv
dG8gbmV4dF9pdGVtOw0KPiAgCQl9DQo+IC0JCWlmIChpbi0+aV9zdGF0ZSAmIElfTkVXKQ0KPiAr
CQlpZiAoaW5vZGVfc3RhdGVfcmVhZF9vbmNlKGluKSAmIElfTkVXKQ0KPiAgCQkJdW5sb2NrX25l
d19pbm9kZShpbik7DQo+ICANCj4gIAkJaWYgKGRfcmVhbGx5X2lzX25lZ2F0aXZlKGRuKSkgew0K

