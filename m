Return-Path: <linux-fsdevel+bounces-40041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C86A1B6C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A463AEB82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395335966;
	Fri, 24 Jan 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="A8NogCEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B6C8DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724996; cv=fail; b=QsULIJO9sJ/LR6o4Nw8S73aAPzBcnErs39AIbMIn/vyq7arcBEShraR1uBrZIdVVr6Uq6k1137xB25KwEBiOZdUdO9ag7kI7M6ZwU5l4doqsyC3+rZbVHsvFVIpC9F28RoblczMFqiLBNA0yqkjjprXGIhGfvrCgFZKn92afqbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724996; c=relaxed/simple;
	bh=ZI52x7W0jzwSUEYxr/K7At/Y3DIXnQ2HitIW28OKWvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cEypn9LvYxgA7guwUM5yew8Kh9fCw5c/ktG61RjF+799tqt8sqU1q7vERIH4mr4QIKJxX0BdUbgzRXPc3ii126EQXpVzN6beZact0tNTsQCdxwgnEpsBNOuPw8Li1MQ9mj3wuecGQXyFOBPbovLypbgSJGi4h0uOkoI4Xm/lJPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=A8NogCEJ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173]) by mx-outbound41-200.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 13:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqEWPvjUVYODTvo2muLfsst8Jhsq1YskOH+uYR6xNCt3aOe7pUheWGY3NBADptrOm3XjAxLIx2oW1XMzQnynlaJEiIH81ibFU78Cd98i36dFd4fDecs/CFtCxI3oxaLxsCmelha4ziblSwMM5NklVVFu2ZW/bs8BXFv1OjEwKBgneLM4He5O8fKVDXUhZlGiAcQGi5hXvRKHhY+6GUGjhqoadCVA2KpLGQR7x0zmPxHxE6xszsNV8fhhNKj1VFtU0EBqIgdjWdGVB2pQr9N4pw1YOcsShxBWe22S/Pc42YlGr77sjaIeYjIzF9Nk/+Ft/URJ9l73LmGuR38AlutujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI52x7W0jzwSUEYxr/K7At/Y3DIXnQ2HitIW28OKWvg=;
 b=Ug2lTM+DDOwbNaYdUd74Uu4spHIdq6l1yIuu5L8zPUtnkSwawbN98d/woRPCbyiWawYCcPVHIeRrLCt5e8HSIkwhTO08AORi3+UhpPTbK4VdNlyv//3T4LHoVN70UThmycsICQbMeZmOb2bgJcwLY81jsgARGWNe0iisAZ3xAyT0DZX3p1h1iB0+0anJ1A/39yo6L+B1rs1Ff3ITDVOy0gwcxVOzlhnfx1fDw8psbK8zs2V3txyo1vv0Yh1eyf/2C/HtgirFfqqTFghrIZvybNkun2hm20VPrrM2stWtPzsYGSqZkJRpHcDVs/GY3S4CV2DrqpF6nZ3lrpaNImQOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI52x7W0jzwSUEYxr/K7At/Y3DIXnQ2HitIW28OKWvg=;
 b=A8NogCEJTp0JLjBDrhDh6eZ6LxszpKVww1VQPDjtVR81jzlfqLpLZsYg7kL9+hbnxRsdvITJVkeTCIEBLI+K1Fiwu/T37RgkBPNnqaNrP6zgsaW3i4thdgi/gbHezOUYkY8wM10OjsOQItZav3EeL6r1zc7BOSvT5XcmJEetGQs=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA3PR19MB7476.namprd19.prod.outlook.com (2603:10b6:806:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Fri, 24 Jan
 2025 13:23:00 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 13:23:00 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Joanne Koong
	<joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/5] fuse: over-io-uring fixes
Thread-Topic: [PATCH 0/5] fuse: over-io-uring fixes
Thread-Index: AQHbbbeei824hnq52ESCNTTOOnQ+erMloYoXgAAXkACAADGjgA==
Date: Fri, 24 Jan 2025 13:22:59 +0000
Message-ID: <1ad37cf0-4536-4024-8d13-b1b00dc5d1e3@ddn.com>
References:
 <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
 <8734h8poxi.fsf@igalia.com>
 <CAJfpegsBFBQoiLreevP_Xmbmjgnii7KS_6_i+pKfMixSw65wiQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegsBFBQoiLreevP_Xmbmjgnii7KS_6_i+pKfMixSw65wiQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SA3PR19MB7476:EE_
x-ms-office365-filtering-correlation-id: 7c1afc1d-074f-4221-d0a6-08dd3c7a393a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnZkSnQ5UllWamlLNVRnRWFjNVhhcEZrY0tweWRJTDd4VXZDMlc0NXZJUThK?=
 =?utf-8?B?UDdiUUZMcFFvd1JUNGF2UXYrb1dMWGo2ekU2ZTRyQThsQmdYYU5sT2tJd3NL?=
 =?utf-8?B?RkhtcXVsQlZBTEtxOTlJN0tESnBRMWRCeWdhdmpPOWEwSHBDMDR6cG5abFJh?=
 =?utf-8?B?Rys1S2U5bjhZMU54Q0tJcWV1STRtejRTTWIzcXV1R1VYYjlxVWI4Tm80Nzk3?=
 =?utf-8?B?Z2s1OHJVYUoxWnBtTDVuc3ZkVXNIeHN0L25TVVRTdlBVU1h5N05RV2xmd3J6?=
 =?utf-8?B?RWNEODNwQ3lVRkk0Q0h4WVMxV1g5N2lxMnNxa3FuRUpJVDVPbXJsK011R2dH?=
 =?utf-8?B?Umc2MmkrWjYvQmhwN2VPTW9DQjBIWEl6TGUvSzUweDlXYVdibE1sNGVtK1Rh?=
 =?utf-8?B?ZGtPcHZpbTVZVUdLcFlvOFBVRVBaMnJvUnRYOGFDZlJNTzFZVWtuNThrbENZ?=
 =?utf-8?B?elR3d3lTcm9Td1VXdjh0VjNEVWRWZjI5OGpDMml0dmtUQ0lSTnA2Z1RhZTEy?=
 =?utf-8?B?cHNkaC9FaDZJQnVMLzFVYjNGTW51bWVsWmRvYWpnOW0vR0s4NUtvMFIvNzhu?=
 =?utf-8?B?K1B3VVdVcFFyOGwyR2F1VFdiS1lHVXhQNVloeHRSWElRNGVDbGZhV3l1LzVR?=
 =?utf-8?B?K29yRnZhMHlDOW9BaEJwMlg2dXIyNDdWajBKb09ZaUlwVTlLNldERFE0TmE2?=
 =?utf-8?B?eFkyYVJYaUd6QUdWeGwzZll1UkR5MlI4T2E3SlExS3dxK3JqQWpqRjFwODcx?=
 =?utf-8?B?QnFjbFBwZkYwNVMxVDdxaFhvejdFdENWNWtpR0xjUzZOYXU4czRQZ05TN3Iv?=
 =?utf-8?B?RXhweGpoOWhJd2tMaTNIVGJoMlpNcUhFRHE1MVVBdTlWam0rbVFqMXJ3ZEg4?=
 =?utf-8?B?L0txLzF1dGNDVCtWUFdaWlJZSTFrNzdvMFloTUJtMDZUckREYVdWank4VzJB?=
 =?utf-8?B?R29QTGR6NHhFMDEwbDdtVlFjK21qeXVPSi9aVEExNlBrbmUyRXdkaUh4VUhI?=
 =?utf-8?B?VENITy9TWmNoV2YveFZMTjZIYUt3SXhIL29uWk9JSk9oSVdqRkVOR1dRQzZ0?=
 =?utf-8?B?NzJTczA3NlN1WWdDUEdrd3dINkpwY2EwRU5MdmRxVkJqTVB1TEJGVWNjUUYr?=
 =?utf-8?B?SE8vaEVVaFIxTWZWUm1tdWVmQnJOS2VVMEVMOHR5am9OeTBwVldYcmZoeFdk?=
 =?utf-8?B?QUpHdlhicld2a2V0WmRQRzFVQjA3a0Q3MGFPa0Q1YnBDYTF3L3pRY0UxSlZB?=
 =?utf-8?B?Uk14WWNnc3NDZGYveEg1RHVDNjgwTkRhU0xxVWkxTld0Z2RsNUk2cVlmZStl?=
 =?utf-8?B?WDhiRXFLRlRqMGYwZElwRGFGNDFDRUQ3VHdRancrN3ZuMkdyeGtJZXJJbldF?=
 =?utf-8?B?eVp3Z3dpNzBFRC9ZMExUMmVHazkvRHZRMnhSL2l6WjVsRTBud1FEWEx0K3hI?=
 =?utf-8?B?U0lFdUtwbDRTRUVWZXFpczRybG5mMVJxUzNjcXdlZnFlUHFPaXJvUFpaL2U0?=
 =?utf-8?B?M2ROS3FPVTdTK2tEeVVSWXowcUdaUjBvZXdoUUpBWUF0VmlJNnprRUJReG1v?=
 =?utf-8?B?L01aWFUwRmk4MW1iMlNvM0tiZ0F1Y0lZQ1k2aHhHVXdZQ0pHa1NtcjVaejFO?=
 =?utf-8?B?YTNQS0tocDhxejdjWnFoQXE4N3o4b2t1dHFsejQ4M1JDVzJkcy91ejhmcmJH?=
 =?utf-8?B?K3IyTkliUWlESzlaa2JBU0FNMUVKTmppM05qUjZZR1BNc01EdktnejFNRUU2?=
 =?utf-8?B?MDFObDJqU1ZUeTB3WThVY1pBekhqOVhxc0ExY2hyWFNvUlZXWmtzWXZSKzZa?=
 =?utf-8?B?S0d1V1ludDRzZ1VuemdsQzRCRml1Wk5RcmxjVFR0NXhURHZmSGJ5ZTFlcHZ5?=
 =?utf-8?B?djhIRHBVQUZjY1R3UWFSNHhFVGNQdWx0UXJyUzkyQWhIZnpkTjNPL1BNV0pQ?=
 =?utf-8?Q?+87Tk3MGt9Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXhHck5URklCdnpFdCt6ck1sMDh4V3lQRTlYL2xZRkFBcUlBNzFjZVFJT1kw?=
 =?utf-8?B?ZTJ4QTJTNEtPQ3RxcnlYQWdGZE1wMU5wdXVkUWowTER4SGkyZEI0aWxRbkxv?=
 =?utf-8?B?dTFQdGFiQWV4ZFZjaWJWZjl6Z1Z1OXBjLzgyNDVBMjFqRmFFWTI4V3FNaXdx?=
 =?utf-8?B?dzAwZUhKZVA4QTRvU1EvRll0SllOdHR1WndjdmZZenU0RFpoRTZaWU1oRGhL?=
 =?utf-8?B?N3NLbDh2cUFNTmFQQ3pYVUh1YlB6czVXang4aWR2T3RMNHNsdXNJS0Y1ZjV2?=
 =?utf-8?B?RmltQ3ltWTZhYzRPRE1FVXJnMCt1aStpdS8rNXBmZ2YrdldTUFdpWithN05Q?=
 =?utf-8?B?RGE3OXBUMWQzNm5OR1ZaR2x0MFNCQjByeDVDczV3NS9Mc1g2UWpydEdWSGZL?=
 =?utf-8?B?TDJaOC9SUTh0ajMzcUNOcnFpOGRnc0pwbHgxWjdwRkQ1TkdKMzdiQ2lRSWty?=
 =?utf-8?B?eHJQcGMrQ2pjWjM4UzNJZXkzSXZHUGVnY1VIRWs2NHFqbnZKaXp3cjYrdUNr?=
 =?utf-8?B?TkdldjNZSEpxYVhOTVlyUWdlam51YnRwbU5YR01LQ1lELzBnNmNxTDdUbkd6?=
 =?utf-8?B?UzVXQlNibHJveU5FVnI3Q0Z0ZnJsZFlNZ202NzltRVRYTDM5ZThYcHBtc0po?=
 =?utf-8?B?NlZsb3ZnUktRK1hiTzZNS0Y3VzhicFBSNHpMUzlGSDlkaVBZT1ZsNmczMnAw?=
 =?utf-8?B?NENCZGZhZTdZVHh0NHdsTGdFT3hYVFc2YldWMXM1SGdTNzhQZ0dHTTJJZGVa?=
 =?utf-8?B?RTdsSTUwNTBScjl4Qm5idzNPY0FoU0NzVkNQZUJzbk10WTM4K1o2akQ0K055?=
 =?utf-8?B?TVZNTGJNWmpTZHZ4bkFKWm9tbFE1RzJGdHdmS0xEa200MzFpRTI0NGhpcmps?=
 =?utf-8?B?ckFsSDNMaEFlbFdpMGY5NVBaWjRmdHcxeUdsMW85ZHg0VklTV3hFeXZBMHpU?=
 =?utf-8?B?WUIwb3NKeXN3OUZzcFMwSkNHWC9lYjk2YnhYWjRHR2dXRW9Oa1c1bjB0NDRu?=
 =?utf-8?B?NWUwMVNINFJDU2QwZzhOR0ZtRDJVU0JWRUVsZzdLMVJoUjN4ZlhIaE5oSFhS?=
 =?utf-8?B?MndmNVhQNXlCMHUxTjFBVG9kTTFXSkZESFVTMjEvaHU5ZzQrTVpoUlJzU05L?=
 =?utf-8?B?MG1uSU9ENjBjMDlPUnoxR1pjYmVuc1c3L0lTa1dOMlRTV0Zlci9nRWRvaktV?=
 =?utf-8?B?bU5sbzh4Q091UmpOMGN2SHRMMy90RUE1Z29LOGZvS3FEL3I3QUg1bElpa213?=
 =?utf-8?B?M1RQQmsxblc4R3IzRHUrdWIrRjZxZmZjU1VXL2pJYjVBWVJqakUwUnJOeVpw?=
 =?utf-8?B?clFzSGxZMWNKVFpTY1A0V0J2aXQxQmtYMGdyS1hiL0NCK3N1Qk5CT2JWTkpN?=
 =?utf-8?B?ZTRsTzJuMjRNb1AwLzVEcXhLUFFvdFVwaU1SZlVUK0dVR0JXaHd5a3hzdkhU?=
 =?utf-8?B?ckpFamRpNWdJUlFhMXNLOXh1RFI1TW52SVh6SUpvbmJZNG00d1hhVTF1TzNr?=
 =?utf-8?B?QTN5ZU5ubjdaQUoyaTRkNUpxZ2JURGhwZWQ4K1RmMjE0Zk8ramVVNW56Kzlj?=
 =?utf-8?B?ZWhwM29BNC8xN2RGU3dxSzYyWnBUWG5aeEQyUjdNNkxxbGJod0MxU2JkQlV5?=
 =?utf-8?B?SEt1SzYvRnRNdnpxeU4xblZ3NWZmUnAyeDBrVm9scFlFcmFJL1NzdGZJQ2k0?=
 =?utf-8?B?SVl4ZjQyWHd0TVhNWitPeDV5RHpDVW5abnkzWEEwb1JqQWN3TEFmR3VjZGNP?=
 =?utf-8?B?bzNmbkFYSWNDUUFzK0pheXN4bEdSZURtZnhBV2NwK21Xa2hHU2lVcFBiRkdX?=
 =?utf-8?B?dFlkYW9aeUpJV0RqSkpxUTlLdHZSdW1Hc0J4Vi9PajVOZmsrSUpGUzIxVVpS?=
 =?utf-8?B?cmNwa0UxUEoyajF3bWl6QVlqRUpDNG1md3c3SS95a0o2bFp4N1o2VnExaGNL?=
 =?utf-8?B?YlhScUJmTFpJUFpEY3NlWWtrTnRDV0FNcEt4RkIzTXhJNEYxNW5NRm5nQ0dU?=
 =?utf-8?B?TDh3MkhsZCs1L25KOU1GYUZtTVlqSHNhMHN0QmFSRk9Jc21wMG9LbTFXTFVo?=
 =?utf-8?B?YkplcnhxbDd1Y0ZZQmtKYXlSb1h6VW1sRmlaRUN4aTM5RUxBRC83SEhlNE5Q?=
 =?utf-8?B?VGpla1hueDQyZVZCZEZOTGt5MDlWOTlXdDVFTlNtTms4Wi92ZnFWbEZLWWtv?=
 =?utf-8?Q?YljetPgiO1alRmyuxdKFhkw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <033DBA0C9C636B4FA97CB1E1104B008A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rjS9KFF0c64eCxDd6PN4AGDO0N2GgybSuifzrYApbuPIxAF3rFVcnvU0VnVHKpYlIB4cJKS/4QK71mrbl8lyHLiSpEhi8jxrnp69R3AG2lFCqkT7pyZnKkLdrxmnK+U2XjCyh4pKkxinLSmvfE8I7d7Zv4ZRLcXzUQWvv87tt9vGJCKQEOs5WgTlJecEOL6HZkoB0B/rKZ7OA6CZrtuislSR7zUzG2YjLn+wT86iCeFRXuZcc5ILYH5XMIKf/2tdlxrTSxRdPyPd0cv5WWAsIHDKH4JrYs5cK3SgeuGcEjGfQjf1G00eumQ52C3tyRNl8VGLzPiDrwXVBfo1EIGi+mhMb7y6GN5qe92KHOhlKnfC2wBHeow3z3JlpFy3BNaF/SCijgNDs8TV5+8x3I2fB9hLvd/FPYuNVFUgyXcDSQaTYueJk/sUAHi8TzTxWi67ZYSJfk9DGmeBFd54KtijJPfYO/9OdqdelfthYytjPb1nLciUJnOKPwRIEuTaFHFpB+LFTzcwvbMXm5qz9eDH4G1y0Vz5x23mii07/dwNYryI+olzi2OWQ87LjApnBi9ULyhuvt4g2UiMf/c/29O5HdxPs4IiEKJxPQr86+C6TsGjEG0gLAeaNJBtIU/K5ZzXoKHQkjySbIwZYNYkngzeoA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1afc1d-074f-4221-d0a6-08dd3c7a393a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 13:22:59.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LR9l3Sc+cDiaViNklnWekUpgONUdOIHOvlcxRY2c5R9bXO7xPkzFPbchQwQP/KxJeW84b8XFCwRKczvZFwkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7476
X-BESS-ID: 1737724982-110696-13396-4413-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaGxkBGBlDMzCgl1dDELC3FzM
	Qi2dDAMjU50cDMJNnMPC3VMDU5OVmpNhYAmYrQ/EAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262025 [from 
	cloudscan11-69.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMS8yNC8yNSAxMToyNSwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+IE9uIEZyaSwgMjQgSmFu
IDIwMjUgYXQgMTA6MDAsIEx1aXMgSGVucmlxdWVzIDxsdWlzQGlnYWxpYS5jb20+IHdyb3RlOg0K
PiANCj4+IEFueXdheSwgdGhleSBhbGwgbG9vayBnb29kLCBhbmQgcHJvYmFibHkgdGhleSBzaG91
bGQgc2ltcGx5IGJlIHNxdWFzaGVkDQo+PiBpbnRvIHRoZSByZXNwZWN0aXZlIHBhdGNoZXMgdGhl
eSBhcmUgZml4aW5nLiAgSWYgdGhleSBhcmUga2VwdCBzZXBhcmF0ZWx5LA0KPj4gZmVlbCBmcmVl
IHRvIGFkZCBteQ0KPiANCj4gSSBmb2xkZWQgdGhlc2UgZml4ZXMsIGV4Y2VwdCB0aGUgZW5hYmxl
X3VyaW5nIGZpeCwgd2hpY2ggaGFzIG5vIG9idmlvdXMgdGFyZ2V0Lg0KPiANCj4+IFJldmlld2Vk
LWJ5OiBMdWlzIEhlbnJpcXVlcyA8bHVpc0BpZ2FsaWEuY29tPg0KPiANCj4gTHVpcywgeW91IHNl
ZW0gdG8gaGF2ZSBkb25lIGEgdGhvdWdoIHJldmlldyBvZiB0aGUgcGF0Y2hlcyAodGhhbmsNCj4g
eW91ISkgIE1heSBJIGFkZCB5b3VyIFJWQiB0byB0aGUgY29tcGxldGUgcGF0Y2hzZXQ/DQoNCkRl
ZmluaXRlbHkgYmlnICJUaGFua3MiIEx1aXMhIEFuZCBzb3JyeSBmb3IgYWxsIHRoZSBleHRyYSB3
b3JrIE1pa2xvcyAoYW5kIGFsc28NCnlvdXIgcmV2aWV3cykuIE1heWJlIHlvdSBjb3VsZCBhZGQg
dG8gdGhlICJlbmFibGVfdXJpbmciIGZpeCBhIA0KIlJlcG9ydGVkLWJ5OiBMdWlzIEhlbnJpcXVl
cyA8bHVpc0BpZ2FsaWEuY29tPiIgKHNvcnJ5LCBzaG91bGQgaGF2ZSBkb25lIHRoYXQNCmluIHRo
ZSBmaXJzdCBwbGFjZSkuDQoNCg0KVGhhbmtzLA0KQmVybmQNCg==

