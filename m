Return-Path: <linux-fsdevel+bounces-63464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B26BBDB27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E2C334A558
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3B23C503;
	Mon,  6 Oct 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="c/0OPesY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF323BD13
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746710; cv=fail; b=UYhwBSqjNnRnTr8avyF5kKtttIAXBB2LX8ewqMKKe83/3cvWK1ocrJd3VYdD/yzCXQr6yI8+WqPO+QUnZdKqIBT5pUeLMY/nQNKfwbCuHQu8vXb6nRu2adzORy8NhNcspr5mSHWl8qJ5cmRwGJ4Bkf9aZRbakz+CxIG0KQgKsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746710; c=relaxed/simple;
	bh=/uJvZU95VHg9RYRdj23gcTnI4cB7uGhLvkhVWjytYe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bIJoQDJlqXxS0XRRkb7RUWhVb5IY20woifjgEy1QHVfM7YlTLQqeEHUDFn8/5W9OhilQT83uyIfxWXMAk9gOPrhxyE9tISvBLR9X5GhpTB7ewRJn08wKnvvUMb7y3KQqOhh/GzAqabyg8nM1tRha7QbAHXrz+zb0Azu/H8Mo/fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=c/0OPesY; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020078.outbound.protection.outlook.com [52.101.85.78]) by mx-outbound17-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 06 Oct 2025 10:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvt/YQnGSLzy3MRrHtZahHAbbMtVb+8z63JG7BDdBAYG3M8SXxO9AdWv2qxJIMwgQ1gUmYhTKVbriNBgpidNT6He3+xkQtsNQj3ziguWfUGGHjdUoy08CiluxStv70fc9isFRjbrsLSirO4GbdUyTSw1lhoj63lJzMpMJ19J+17kX4/J5Z30RXwPPAo6roFQCDKbqX2KFCOcb5B48VYcfaPBjNhPzsjsanitpRB+NX3RDMqD2o9PaEElflOvh9yRSKU8CSM/RY/c4HXMzSXe5W6qadmlReal0UW2qmylk0JCXnRS5O71w23R7h/OWcnT6BJeyRD4QSTEk77qtLl23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uJvZU95VHg9RYRdj23gcTnI4cB7uGhLvkhVWjytYe4=;
 b=D4L2jIYQk9vJlHxIjDkhr8MPvcW/j8kHiw/HhIUVk1h2EYyFJnyYEM4KGeGEjlFUpb19NtSbllbsKHar+PfeIfTnmSIqEVPv0AtZiyDRl981NQs/vbrWSRz9GcNkVtzcR4ex0anxSe7WBaAkQAWbf8awsS+uje+dXR13+fKEg/GoTNJcM2W8h6HTTiTg5D03h7hFtPkVQPwd3D7Pm7oJ3KU/qTKNIAN/hnsiT9E74bv6miPHcDkLs3x0W25QdnoANmnglyQeJ6h73TNEnEWh6oyUNu38AoZQolT7NR3uHxMueRR9qC2A5Lv1VWTH6y283foH8dcfsH/dU84K1waFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uJvZU95VHg9RYRdj23gcTnI4cB7uGhLvkhVWjytYe4=;
 b=c/0OPesYQRAS9JGwrnB4fkmIIFRQF50JK9h+3mcbSdwvDpzBrgffOrWvcDHkX51h/pmMcuScP8WuvAnGMcpwTxO2Vi5+/23V70jzg27cEcR/KiAMvIM/aXUr92PcVeDq1StBTL0AusrrER/REVAUq/HGNuAxaJCyzd+sbkJXGpE=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW5PR19MB5652.namprd19.prod.outlook.com (2603:10b6:303:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 10:31:14 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:31:13 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] fuse: {io-uring} Queue background requests on a
 different core
Thread-Topic: [PATCH v2 6/7] fuse: {io-uring} Queue background requests on a
 different core
Thread-Index: AQHcNE1w+3EinRaZxk2vzFOolKCMebS05bhugAAKWQA=
Date: Mon, 6 Oct 2025 10:31:13 +0000
Message-ID: <e4e9eddd-64db-47c3-a612-57dbc12c0c6b@ddn.com>
References: <20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com>
 <20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8fc58@ddn.com>
 <87frbwe4p5.fsf@wotan.olymp>
In-Reply-To: <87frbwe4p5.fsf@wotan.olymp>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MW5PR19MB5652:EE_
x-ms-office365-filtering-correlation-id: 8cf61fad-bdc4-4795-da84-08de04c3797b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NklqWWUwOEExdFNaUDQ0WGo5eHJ6a29sdXVLQUtrZ2c4SHk1V0ljKyttL0JM?=
 =?utf-8?B?U00wNUpuWFdURjhwdFE4T3V0Y1FtbW45VnFtOGhsVWJOakZqaWNaTlVJREQ5?=
 =?utf-8?B?T1ByZ3F2aXBtOG5OQnZEV2pYWlVlSkdGNVU0NzRwdUw4Y1lzRVllQWppY2Jq?=
 =?utf-8?B?Q1JUb3J4M2ZXLzIwdHlPdWgrMmpJVjdHc01tRnNleFZJNGsrdGsyQUNHTzJa?=
 =?utf-8?B?NE4wSFRFMVJwY2hyeVZXQzg4RlFNVy9ZWUY3c1kwMTVraFpiZXZSNGVtSjla?=
 =?utf-8?B?ZHhUQ1gwMTBSWVdlQmFLM3VLMEo1TGkrN3ZhdFIxbklpKzdhRDFqYXNSUkZE?=
 =?utf-8?B?V2F3Q3c5YVVNMk81NmUzZnUyTDFHb2Vhbm1pbWtpOXp3RHhLODZLUWpWNGND?=
 =?utf-8?B?YTBJYzNuTHVLbFVTTDRaNmUvOFUydkRFT3RKNU55V2hjaEhFOHNvVWN4VEdB?=
 =?utf-8?B?MnV4WW5wbkV0OS9KVmJBKzF4TFAzcnVZZVFVMFRGMFlNOE9ieXRmNHBiaGI1?=
 =?utf-8?B?RGhUT1JWYTM3OTU0eXh5a3Zrd3JCUnpOSVYvMXZZNStiS2JFTXZaZE5iSFJ4?=
 =?utf-8?B?anAweGtmMk9mUFhTYlNXSnEzekcrd09SVE1ZSE9kOWJKT0ovZ0VxU2hpU0ww?=
 =?utf-8?B?NGd3U3Qyam9LZFBVemxGUFQ1VUwwMU94S2t1USt6WGFnQk4xRDhJV2hnNXMr?=
 =?utf-8?B?ZitQUzZ5bVBMbmRsTG5zb2dHak80V1A5eENUejdUOHpsdk5IazBoN0s2Z0JT?=
 =?utf-8?B?YmRvZVpWSW5xemFIeGxzbjZzTk9hdXREYnFPSVMxTk52ZFRHQXlNZERrK21G?=
 =?utf-8?B?OHY1UnZmYlhtd05yemdNU3crclFEYTJJMFhETlZ6R1hlS2lsTCtLR2xHbXhX?=
 =?utf-8?B?RE1IY3ZqNDRCVlVVeFlRd2JYVWE3R1RXNTlFQ25ldVk4YUtIa21Edmh6eVBP?=
 =?utf-8?B?U2RiQWNOVjBTaWErRjVOL3RyZWg0bi9raGxWbEJMQUNpTERGK2JpNTIxZGFG?=
 =?utf-8?B?TFovaG5QbGgwNXYxeEtRWUlpWnVrSkNIckVIdFBEaDJTYU02dEZ1OTZmczVJ?=
 =?utf-8?B?RlFiak5jTjdRdGFFWmV5TmhHUU9FYlVHNHJ1VHZrVFcyN3dnbGhNVWhRbUxt?=
 =?utf-8?B?MzBrMWpaeFdybFBrWnRXNVNtcmo1YWpCcno5WkdYdnNQRkdGTGFQWmtzaFUw?=
 =?utf-8?B?Y01ReTltZFA0TVhoV0NLQ2pldlBKOU13L0pSWXpRWFd3VmdxZ3VKeEc2V0VX?=
 =?utf-8?B?NEE1YWpLaGsrZmlMVk16bXJSMFcvRGNNdkNzUC96SEs1Ym8zeDdsTzlTS0xT?=
 =?utf-8?B?Z3pBSGFaVkRDcEE2ZzZVWHpxSFJ0NDZoU2ZKZHVITnpxdUhOdTRjMWVoemoy?=
 =?utf-8?B?dThTSXpuZ0l1YmNQSkJYdWtYblB2ZzdJaDNIZldqRGtjdm5BbGNRZFQyYlgx?=
 =?utf-8?B?eHE5OGRMMW81LzVvTmsxYUU1ZHgwUDFHYmJUOWNnRGpndzA5UHZoUi93YVlj?=
 =?utf-8?B?cll4QnEyNklhTlRQVTJ6dmVDN3NTb1RPTElMSVVFbVF1NEorYTd5ZmZ1TEc5?=
 =?utf-8?B?VmtveGJJQUpQcUJiZWllTzFGcGVqWklPS1hzdG9VeElZRXVkWHN0dXcrZlRm?=
 =?utf-8?B?eEpZWjkrUy9aWkN2Q1ZIdkRKdnloSytGTHpNN0dBeE83THRFcndaSWN1U2ds?=
 =?utf-8?B?QlkwbXFaV1NPMDdZeTdTTXhibkJUNnhIN0NBR3pkTkI1dEN4aEtBZm03eUtm?=
 =?utf-8?B?K2podVdVcS8vdklYSjYzQlNsOUJ5UllYT0dWWlRpUmdTODFBTlJiVTB0STNY?=
 =?utf-8?B?akh2Y2YrUVU5Wm9teEFmdVJDMURzY0NjZVJ3amR0dFFzdWZ4dCtrZ2RGbXRu?=
 =?utf-8?B?QXg0TkNuYm5QMm1pM0hDRXhpMmdkeWpMZ1pBN1NsOEo3bEIvbzhxbytWeVZB?=
 =?utf-8?B?WGZhUEJ0TlZMcmdISWVudVVsaVhiazN4TVlla0RETlJPVzdZbDF0SE1wN2FZ?=
 =?utf-8?B?bk9oQ3JHMHVpRi9nSUZQbUxvbGJ3a2FsOFBOMy9OaWlQWVZpSGVMYjJpWGRn?=
 =?utf-8?Q?RIsPBV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmNlMG9SM3F3OUV5ZGtyUkl5cFZUUWxPbFJwNFdYNGg5QWcwVGhhNENLcURx?=
 =?utf-8?B?T3J2bFNVZC81Rk9FS2xzaDFweTJwcjZmQkg5YVdvblhQSjA4OTlWY2wyNVFP?=
 =?utf-8?B?bGpZbDdWRmhaRFZSbjlPREN3U0dCZkNEREJWM0EwM2FTNnJ0N3FxZnhKeWxB?=
 =?utf-8?B?VVJqVjFldWE4MWJzc05zcjg3bThsUEtzSkFLNVZweDRNZk5Eb1VrUEN5eGxC?=
 =?utf-8?B?RHVQQkMxWXplMGdhMnBXWFBNM0tEL3dmYXBrRnhqQldIMHUrY01oUFI3V0Uw?=
 =?utf-8?B?REdCMlQ2RjRockkyMjNNeHo3ZTJoMWZTQTJnYWZxRDM1bnZLNVp3ais3T3dS?=
 =?utf-8?B?cmtGWFdjTlI1M0hjSy9VdzVRRDhQTnROc0ZFYkFEU2pUbTFjOGVaR3QxejZ4?=
 =?utf-8?B?VjQ2UHVwMm1PQjlUQ1hQRnpTcTB4ZFRsVFVrcFdqbldXb0N3T28vSzNEN3B5?=
 =?utf-8?B?VTNMUFBtanFBTVB3SWNieGhrODJpbFVsMDA5M1BnYlNXbllVKzBuaFMrbDhU?=
 =?utf-8?B?ZnpENmxHUHN6WTZMNVorQ0JDQUc5cDJGbHlqU2ZaazRuK3ZmUXpKNlNvbmhY?=
 =?utf-8?B?bTlrY3BTbGhoR01wcUdxbkw5REVvS2JzcTlHMmhvcmdkUmZnSVdKQUlxZE5H?=
 =?utf-8?B?UEtuQU1nWlUrZ0lvalI2R05hcGtsNVlhMjNmRVJkaUpYNnJDUXd4RXp2ckFm?=
 =?utf-8?B?aHRJczArSDA0MmVLWTFaeThjV0NTeDB2M1p5dUNFcmdORWpzdGF2NEMzQXZy?=
 =?utf-8?B?MitEMm5MdWFsYlBsc1VrTE5QSVg3c0hWcGIvWnNBQTYyNDBxNy9uTW1uRTZG?=
 =?utf-8?B?YURTdy9PRmJlZUVsWDI1R3JWUEtscG41eE4zTjFoRUZONzdlWFFWQ1BVSmk1?=
 =?utf-8?B?ZGVSOGZUbTJ4TXZYcUUrOGcvYVA2WHNHeXp3NDk3K2ZWV0RiZHJZTWp5NHh3?=
 =?utf-8?B?R0NGK05pL2p5eUtvNVNTa0xKUEhmR3N4cTFLb0ZlNkNVY2xWZjQvRkthMmlh?=
 =?utf-8?B?cXNSU20zQjdTb0pqQVZGcFV6ZWhCT1RGSVRuQUZBRWowQ2NJLzhlS3Nlanpv?=
 =?utf-8?B?K0ViaEhWZVFWbGtVWElKdTVLcC8wanlDZGJZZ2w1MDNwNlVJa3QwRHorWTNQ?=
 =?utf-8?B?aW4zVStkQnkveUdwRVdNVzZqanloWUUreE5LcEs1RDhwekNoSGNGSUZHOU4z?=
 =?utf-8?B?YXZ3WmVMMUFiaHFSRjVNWXV3QnZpQTlsUWlDUlg3cWlQa2d6SnUzNGpmREM4?=
 =?utf-8?B?VkhSTmV2MVlsSXMxVUUwc0lQSzFHZUNGZ0ljS2IwRWR1bHFEZ290WW9pZXZB?=
 =?utf-8?B?V0xIZkIvOTFMTGQ4ZFdiTlZ3d1NHbFJBTlI1V0ptUDIySG00SWNJcytvWEFC?=
 =?utf-8?B?NW1uNkZYakEraG13TTZvOTR0L1FOMnRGSFE3cG16QjQxWTZ4cWw2YWV0YklS?=
 =?utf-8?B?Zi83VU11VXdsbElUVkw2ZXQ3S0VTcGRieGIyOXp3b0N0NmMyZE9zUXZMYkNh?=
 =?utf-8?B?dDFIY3BXM3FpYmd3cmMwaGI4aHVHQUdoK0NlcG53RGdMcVU1d3VSM09BUnNG?=
 =?utf-8?B?S3JDT1dhNDNsV1g3Y0hSRTI3V1JObUVReko2aUVFL0JCRkc5WlBaNjlTMHRG?=
 =?utf-8?B?QnR0M3V2TURKYkZpbDFNTkdzd0t6ekxvNXhJL3FmeVlmMmNJa0JYQ0k5QVI2?=
 =?utf-8?B?Ylk4ZElLYUVuMnJ0Mk9BeGVyVXdXaU5BeHM0NDlZYVRXWjhmYTA4NkdpMWk0?=
 =?utf-8?B?ZVBtS2E4akhhN012blJvRVBIWmQyK3hZdkVLSEFmajJVMEdSOGpaRkJ2WXpL?=
 =?utf-8?B?cGl2MkVUUWUrOXpQUDMzRlFVK3hidFJMRERGTzlPaDhjbVIrdVR4eCt1cTlB?=
 =?utf-8?B?b0g1MnNZN3d4Q3UrMEQzMDMxNTZmNm5FeTZGZnRTTU5NbzNpanNHWThJL0pP?=
 =?utf-8?B?WHNNWi9mSkRoN0YwQkQvSW5Yc2JoZXVLdVpZN2ttUy9YVCt6YnZQL2l0UWNL?=
 =?utf-8?B?RHRPNTBCRzNWdXgzYlNVWmxKSkdjNFpBSmEyeTB0MTdWUVRNUWtTYTlUYlZO?=
 =?utf-8?B?WlVFNVJ3OHYxbWt3UGJnbWVPbldqR0NJa2MwRmhOeXpFZFFhSG0rS1JKanFa?=
 =?utf-8?B?a2ZhRGVHWjgzb1pEZHFhd2NYdTZjdUZTMVpINWpkR1hzdzFMdnBqRkI5T0s0?=
 =?utf-8?Q?IGbqNCW6YcsVTV1xth0zu+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A24AA3938149C40B77283AADB91684F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jveZhs/kUFE7jwluCx2NrjewcZDAg/a7gvekQ2fd2bFFQFjUgBIxgbHAiqtk8pouT/sMPR3x6pru5YXFWQHGgd4KccpZiw0doJHwWpe76ENrKBN4SCd5OA8yvSyjaBtQe7coccoz0NZkCl3MVxZ/k+tsk84pKzyIZyhGdXVQCCQxU3UKny35Wxr1F0aIi35+S5F97yjV5dVFIKu4kMDQ7bIK1mo4ZtfmvWyYdWcqjQJE2F7otOXP0Cjz0yqyepP5daVU5F0Hcp8dPkEnv3L2NogWxSuwlZNpK+i1uaFsGhyJhMn4j4XFCYY/o7gYX/Ay7oosW8P3U6kWyS95MDuzwnW+VhgZCY4zdLQa6YLEJ8W878cCTk5+Xdie/vmvU/KriVkjE3my/6eIPLAP94yXbJI8mG5vs7zm67d0qOvdaecNv0tQmlWPloPKhBnxA75flGIs569hGOYxjvoKwqsEPae1WTP7uylUwLi4mnsMeF7DB78l/wPEEplqwa2o2k0zziPa9DN8+a7IW6V1aRWiPA9SIrH2BiOW7ScLDgTMw0s8qFzGzlpjB/9XT5FKsBkh63+gY/HXSbi/GoHssAf7HKraNejRjVoDUbLBKnldybk8VVbQ0/kJdU39ex+yrWwT3k1hpgQMwwRpdfX4/z8zQw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf61fad-bdc4-4795-da84-08de04c3797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 10:31:13.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFpaQFZUHz/vx4ZxIK1IlfcnsvVfXNqToqMggFqbgw8DfSL9d3N1+oe9f4NZ6PzfQoP6O1MEtR63YZThUNdEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5652
X-BESS-ID: 1759746680-104531-7726-83798-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.85.78
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZmZhZAVgZQ0NQsLc041czE0M
	wwNcnMKMU00SzVPMnQMDnFJMnEwtxEqTYWAAlQ0WRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268007 [from 
	cloudscan11-165.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvNi8yNSAxMTo1MywgTHVpcyBIZW5yaXF1ZXMgd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDAz
IDIwMjUsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiANCj4+IFJ1bm5pbmcgYmFja2dyb3VuZCBJ
TyBvbiBhIGRpZmZlcmVudCBjb3JlIG1ha2VzIHF1aXRlIGEgZGlmZmVyZW5jZS4NCj4+DQo+PiBm
aW8gLS1kaXJlY3Rvcnk9L3RtcC9kZXN0IC0tbmFtZT1pb3BzLlwkam9ibnVtIC0tcnc9cmFuZHJl
YWQgXA0KPj4gLS1icz00ayAtLXNpemU9MUcgLS1udW1qb2JzPTEgLS1pb2RlcHRoPTQgLS10aW1l
X2Jhc2VkXA0KPj4gLS1ydW50aW1lPTMwcyAtLWdyb3VwX3JlcG9ydGluZyAtLWlvZW5naW5lPWlv
X3VyaW5nXA0KPj4gIC0tZGlyZWN0PTENCj4+DQo+PiB1bnBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3
PTI3Mk1pQi9zICgyODVNQi9zKSwgMjcyTWlCL3MtMjcyTWlCL3MgLi4uDQo+PiBwYXRjaGVkDQo+
PiAgICBSRUFEOiBidz03NjBNaUIvcyAoNzk3TUIvcyksIDc2ME1pQi9zLTc2ME1pQi9zIC4uLg0K
Pj4NCj4+IFdpdGggLS1pb2RlcHRoPTgNCj4+DQo+PiB1bnBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3
PTQ2Nk1pQi9zICg0ODlNQi9zKSwgNDY2TWlCL3MtNDY2TWlCL3MgLi4uDQo+PiBwYXRjaGVkDQo+
PiAgICBSRUFEOiBidz05NjZNaUIvcyAoMTAxM01CL3MpLCA5NjZNaUIvcy05NjZNaUIvcyAuLi4N
Cj4+IDJuZCBydW46DQo+PiAgICBSRUFEOiBidz0xMDE0TWlCL3MgKDEwNjRNQi9zKSwgMTAxNE1p
Qi9zLTEwMTRNaUIvcyAuLi4NCj4+DQo+PiBXaXRob3V0IGlvLXVyaW5nICgtLWlvZGVwdGg9OCkN
Cj4+ICAgIFJFQUQ6IGJ3PTcyOU1pQi9zICg3NjRNQi9zKSwgNzI5TWlCL3MtNzI5TWlCL3MgLi4u
DQo+Pg0KPj4gV2l0aG91dCBmdXNlICgtLWlvZGVwdGg9OCkNCj4+ICAgIFJFQUQ6IGJ3PTIxOTlN
aUIvcyAoMjMwNk1CL3MpLCAyMTk5TWlCL3MtMjE5OU1pQi9zIC4uLg0KPj4NCj4+IChUZXN0IHdl
cmUgZG9uZSB3aXRoDQo+PiA8bGliZnVzZT4vZXhhbXBsZS9wYXNzdGhyb3VnaF9ocCAtbyBhbGxv
d19vdGhlciAtLW5vcGFzc3Rocm91Z2ggIFwNCj4+IFstbyBpb191cmluZ10gL3RtcC9zb3VyY2Ug
L3RtcC9kZXN0DQo+PiApDQo+Pg0KPj4gQWRkaXRpb25hbCBub3RlczoNCj4+DQo+PiBXaXRoIEZV
UklOR19ORVhUX1FVRVVFX1JFVFJJRVM9MCAoLS1pb2RlcHRoPTgpDQo+PiAgICBSRUFEOiBidz05
MDNNaUIvcyAoOTQ2TUIvcyksIDkwM01pQi9zLTkwM01pQi9zIC4uLg0KPj4NCj4+IFdpdGgganVz
dCBhIHJhbmRvbSBxaWQgKC0taW9kZXB0aD04KQ0KPj4gICAgUkVBRDogYnc9NDI5TWlCL3MgKDQ1
ME1CL3MpLCA0MjlNaUIvcy00MjlNaUIvcyAuLi4NCj4+DQo+PiBXaXRoIC0taW9kZXB0aD0xDQo+
PiB1bnBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3PTE5NU1pQi9zICgyMDRNQi9zKSwgMTk1TWlCL3Mt
MTk1TWlCL3MgLi4uDQo+PiBwYXRjaGVkDQo+PiAgICBSRUFEOiBidz0yMzJNaUIvcyAoMjQzTUIv
cyksIDIzMk1pQi9zLTIzMk1pQi9zIC4uLg0KPj4NCj4+IFdpdGggLS1pb2RlcHRoPTEgLS1udW1q
b2JzPTINCj4+IHVucGF0Y2hlZA0KPj4gICAgUkVBRDogYnc9OTY2TWlCL3MgKDEwMTNNQi9zKSwg
OTY2TWlCL3MtOTY2TWlCL3MgLi4uDQo+PiBwYXRjaGVkDQo+PiAgICBSRUFEOiBidz0xODIxTWlC
L3MgKDE5MDlNQi9zKSwgMTgyMU1pQi9zLTE4MjFNaUIvcyAuLi4NCj4+DQo+PiBXaXRoIC0taW9k
ZXB0aD0xIC0tbnVtam9icz04DQo+PiB1bnBhdGNoZWQNCj4+ICAgIFJFQUQ6IGJ3PTExMzhNaUIv
cyAoMTE5M01CL3MpLCAxMTM4TWlCL3MtMTEzOE1pQi9zIC4uLg0KPj4gcGF0Y2hlZA0KPj4gICAg
UkVBRDogYnc9MTY1ME1pQi9zICgxNzMwTUIvcyksIDE2NTBNaUIvcy0xNjUwTWlCL3MgLi4uDQo+
PiBmdXNlIHdpdGhvdXQgaW8tdXJpbmcNCj4+ICAgIFJFQUQ6IGJ3PTEzMTRNaUIvcyAoMTM3OE1C
L3MpLCAxMzE0TWlCL3MtMTMxNE1pQi9zIC4uLg0KPj4gbm8tZnVzZQ0KPj4gICAgUkVBRDogYnc9
MjU2Nk1pQi9zICgyNjkwTUIvcyksIDI1NjZNaUIvcy0yNTY2TWlCL3MgLi4uDQo+Pg0KPj4gSW4g
c3VtbWFyeSwgZm9yIGFzeW5jIHJlcXVlc3RzIHRoZSBjb3JlIGRvaW5nIGFwcGxpY2F0aW9uIElP
IGlzIGJ1c3kNCj4+IHNlbmRpbmcgcmVxdWVzdHMgYW5kIHByb2Nlc3NpbmcgSU9zIHNob3VsZCBi
ZSBkb25lIG9uIGEgZGlmZmVyZW50IGNvcmUuDQo+PiBTcHJlYWRpbmcgdGhlIGxvYWQgb24gcmFu
ZG9tIGNvcmVzIGlzIGFsc28gbm90IGRlc2lyYWJsZSwgYXMgdGhlIGNvcmUNCj4+IG1pZ2h0IGJl
IGZyZXF1ZW5jeSBzY2FsZWQgZG93biBhbmQvb3IgaW4gQzEgc2xlZXAgc3RhdGVzLiBOb3Qgc2hv
d24gaGVyZSwNCj4+IGJ1dCBkaWZmZXJuY2VzIGFyZSBtdWNoIHNtYWxsZXIgd2hlbiB0aGUgc3lz
dGVtIHVzZXMgcGVyZm9ybWFuY2UgZ292ZW5vcg0KPj4gaW5zdGVhZCBvZiBzY2hlZHV0aWwgKHVi
dW50dSBkZWZhdWx0KS4gT2J2aW91c2x5IGF0IHRoZSBjb3N0IG9mIGhpZ2hlcg0KPj4gc3lzdGVt
IHBvd2VyIGNvbnN1bXB0aW9uIGZvciBwZXJmb3JtYW5jZSBnb3Zlbm9yIC0gbm90IGRlc2lyYWJs
ZSBlaXRoZXIuDQo+Pg0KPj4gUmVzdWx0cyB3aXRob3V0IGlvLXVyaW5nICh3aGljaCB1c2VzIGZp
eGVkIGxpYmZ1c2UgdGhyZWFkcyBwZXIgcXVldWUpDQo+PiBoZWF2aWx5IGRlcGVuZCBvbiB0aGUg
Y3VycmVudCBudW1iZXIgb2YgYWN0aXZlIHRocmVhZHMuIExpYmZ1c2UgdXNlcw0KPj4gZGVmYXVs
dCBvZiBtYXggMTAgdGhyZWFkcywgYnV0IGFjdHVhbCBuciBtYXggdGhyZWFkcyBpcyBhIHBhcmFt
ZXRlci4NCj4+IEFsc28sIG5vLWZ1c2UtaW8tdXJpbmcgcmVzdWx0cyBoZWF2aWx5IGRlcGVuZCBv
biwgaWYgdGhlcmUgd2FzIGFscmVhZHkNCj4+IHJ1bm5pbmcgYW5vdGhlciB3b3JrbG9hZCBiZWZv
cmUsIGFzIGxpYmZ1c2Ugc3RhcnRzIHRoZXNlIHRocmVhZHMNCj4+IGR5bmFtaWNhbGx5IC0gaS5l
LiB0aGUgbW9yZSB0aHJlYWRzIGFyZSBhY3RpdmUsIHRoZSB3b3JzZSB0aGUNCj4+IHBlcmZvcm1h
bmNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRu
LmNvbT4NCj4+IC0tLQ0KPj4gIGZzL2Z1c2UvZGV2X3VyaW5nLmMgfCA2MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCA1MCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZnMvZnVzZS9kZXZfdXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCj4+IGluZGV4IGY1
OTQ2YmIxYmJlYTkzMDUyMjkyMWQ0OWMwNGUwNDdjNzBkMjFlZTIuLjI5NjU5MmZlMzY1MTkyNmFi
NDk4MmI4ZDgwNjk0YjNkYWM4YmJmZmEgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mdXNlL2Rldl91cmlu
Zy5jDQo+PiArKysgYi9mcy9mdXNlL2Rldl91cmluZy5jDQo+PiBAQCAtMjIsNiArMjIsNyBAQCBN
T0RVTEVfUEFSTV9ERVNDKGVuYWJsZV91cmluZywNCj4+ICAjZGVmaW5lIEZVUklOR19RX0xPQ0FM
X1RIUkVTSE9MRCAyDQo+PiAgI2RlZmluZSBGVVJJTkdfUV9OVU1BX1RIUkVTSE9MRCAoRlVSSU5H
X1FfTE9DQUxfVEhSRVNIT0xEICsgMSkNCj4+ICAjZGVmaW5lIEZVUklOR19RX0dMT0JBTF9USFJF
U0hPTEQgKEZVUklOR19RX0xPQ0FMX1RIUkVTSE9MRCAqIDIpDQo+PiArI2RlZmluZSBGVVJJTkdf
TkVYVF9RVUVVRV9SRVRSSUVTIDINCj4+ICANCj4+ICBib29sIGZ1c2VfdXJpbmdfZW5hYmxlZCh2
b2lkKQ0KPj4gIHsNCj4+IEBAIC0xMjYyLDcgKzEyNjMsOCBAQCBzdGF0aWMgdm9pZCBmdXNlX3Vy
aW5nX3NlbmRfaW5fdGFzayhzdHJ1Y3QgaW9fdXJpbmdfY21kICpjbWQsDQo+PiAgICogIChNaWNo
YWVsIERhdmlkIE1pdHplbm1hY2hlciwgMTk5MSkNCj4+ICAgKi8NCj4+ICBzdGF0aWMgc3RydWN0
IGZ1c2VfcmluZ19xdWV1ZSAqZnVzZV91cmluZ19iZXN0X3F1ZXVlKGNvbnN0IHN0cnVjdCBjcHVt
YXNrICptYXNrLA0KPj4gLQkJCQkJCSAgICAgc3RydWN0IGZ1c2VfcmluZyAqcmluZykNCj4+ICsJ
CQkJCQkgICAgIHN0cnVjdCBmdXNlX3JpbmcgKnJpbmcsDQo+PiArCQkJCQkJICAgICBib29sIGJh
Y2tncm91bmQpDQo+PiAgew0KPj4gIAl1bnNpZ25lZCBpbnQgcWlkMSwgcWlkMjsNCj4+ICAJc3Ry
dWN0IGZ1c2VfcmluZ19xdWV1ZSAqcXVldWUxLCAqcXVldWUyOw0KPj4gQEAgLTEyNzcsOSArMTI3
OSwxNCBAQCBzdGF0aWMgc3RydWN0IGZ1c2VfcmluZ19xdWV1ZSAqZnVzZV91cmluZ19iZXN0X3F1
ZXVlKGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrLA0KPj4gIAl9DQo+PiAgDQo+PiAgCS8qIEdl
dCB0d28gZGlmZmVyZW50IHF1ZXVlcyB1c2luZyBvcHRpbWl6ZWQgYm91bmRlZCByYW5kb20gKi8N
Cj4+IC0JcWlkMSA9IGNwdW1hc2tfbnRoKGdldF9yYW5kb21fdTMyX2JlbG93KHdlaWdodCksIG1h
c2spOw0KPj4gKw0KPj4gKwlkbyB7DQo+PiArCQlxaWQxID0gY3B1bWFza19udGgoZ2V0X3JhbmRv
bV91MzJfYmVsb3cod2VpZ2h0KSwgbWFzayk7DQo+PiArCX0gd2hpbGUgKGJhY2tncm91bmQgJiYg
cWlkMSA9PSB0YXNrX2NwdShjdXJyZW50KSk7DQo+PiAgCXF1ZXVlMSA9IFJFQURfT05DRShyaW5n
LT5xdWV1ZXNbcWlkMV0pOw0KPj4gIA0KPj4gKwlyZXR1cm4gcXVldWUxOw0KPiANCj4gSG1tbT8g
IEkgZ3Vlc3MgdGhpcyB3YXMgbGVmdCBmcm9tIHNvbWUgbG9jYWwgdGVzdGluZywgcmlnaHQ/DQoN
Ck9oIHllYWgsIHNvcnJ5LCB0aGFua3MgZm9yIHNwb3R0aW5nIHRoYXQuDQoNClRoYW5rcywNCkJl
cm5kDQoNCg0K

