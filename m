Return-Path: <linux-fsdevel+bounces-55615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1864B0CAF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4CF17AFC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFB22F177;
	Mon, 21 Jul 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="EXhyZBR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44B223DED
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125957; cv=fail; b=punIR58h2BKCUek6YzDtnNmWOUCkt0BI/+9n0yznxumWv5Yi8LkqsLC1IvoDdFefgVQGhyUHsmMQyBrHbIbX19oZRxsfDrA4OgryfoeVcq5S+gjI3HX1ZJBWe5XSwNPfdYXcdpq7IIq1I6kGk4NCdxRsYAdOZjGFXtFEAis6Ly0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125957; c=relaxed/simple;
	bh=LRXAeXEcrg6g1/QT2iEHO2FNSs9ztu6bZNA6dUxa060=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhdrAcQ93CNQIG+FBE6nvPp4r+bNjIfOBJM8dBiJmvRMXaYwKUjeErTb1TcrkpUmejM5QxTCigqvMm77GmPkoJn0Vq5P40pzqDZoUnYXQ9Eyv4kaRm6ZZGU5exsqyyWr98y3DFZ0PautToO5NSURUrzcpunAPZlgIn4fV4GgQsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=EXhyZBR0; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2139.outbound.protection.outlook.com [40.107.101.139]) by mx-outbound44-17.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 21 Jul 2025 19:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmxM6o85WM6mSh3zi4VU0jwgdBN0hJEcNBfPfz40DL5aDd1XKrf8Szcac9gawYw2U/QGxIiQUlRXmWwUJ3dIjiKO0A1Bzujl4vNg2WV8fA4FauooLHFn1odVDxJ5PQ+zqELcdoKuif71vIyHQbNLGUl+LnZOKA3ZRn4pYvvfpMhWskEo+yWKZYhlFIJybJOHjhmaZuFiu7AhbJkyjgkzxFUAjMwMfuqLo0XAgCRKXHs9S5Rw6/lardXh8uLB2hgLIilHAOklnLsE1rfpTCDW5rKlxvk0RJhDxE0KUoxuxy+LSmHG8LPQbhmXiiRL/cB6GXsZgIXcD6FCMtvLZbCCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRXAeXEcrg6g1/QT2iEHO2FNSs9ztu6bZNA6dUxa060=;
 b=ETEzuHUTenUJLISUywLHr+MW+HULQXHpZ5/aGCqypq7XIGcIeoycGWAhlJOlpKuGv4Q6qoHFNiikgMX9e/E88xZqIdMkX6yKEX+ZHbdb1tS3iL4t9OXnnuvSvt+3YXn8UL7vD6+6rCX2RZ1V+kUy/BEF9KAVsm72ynHv8vEwOdX8/Vkozu55mHgfOkMxuG0xEoqZMBSZHkmNH73VqAEraI67duQb/hylmEcX3Hpctncdk4j7gvH5ps/TuWNamPR/KT8X8v3TEAzYFoNOBI8GedHDgu6wEFMviKmMdAx+JV9CHsENg0Z1qM6CNRVGnvmd54Ifask4qdc4iiT6t4p0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRXAeXEcrg6g1/QT2iEHO2FNSs9ztu6bZNA6dUxa060=;
 b=EXhyZBR0iCmBKpsnJxaU9pUxPR8VxT8PgJSJ/+s3NQT2EKgYFmmXfLNEUR8mSVL307kmoHyL3fUeJVyWXeNczG7Ax6UBh31dSjdwoEw8ofpJ77pCg5/YEDUaNvo5oWqdmsD3EpufwdOvnf4Yy5Psz2WwjPzpcsgMWkWIHeTEfbY=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BL3PR19MB5275.namprd19.prod.outlook.com (2603:10b6:208:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.20; Mon, 21 Jul
 2025 18:51:00 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8922.017; Mon, 21 Jul 2025
 18:51:00 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
CC: "John@groves.net" <John@groves.net>, "joannelkoong@gmail.com"
	<joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Thread-Topic: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Thread-Index: AQHb93OkxcEwD4Ili0Sk9GZbNM3brrQ38WAAgAAYawCABOgZgA==
Date: Mon, 21 Jul 2025 18:51:00 +0000
Message-ID: <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs>
In-Reply-To: <20250718155514.GS2672029@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BL3PR19MB5275:EE_
x-ms-office365-filtering-correlation-id: 5f58d3d8-f1bc-4f9a-30ca-08ddc8878902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUxOWWFnL3NJRnpmQUorYWU5K1RmT2hiNEFQa1NMZnhHOWxRZFBLaFN5NkRH?=
 =?utf-8?B?cE9EZkxoT0M2dERieit1YkFIQTNLeTZtR0xkZHF2akRyTzMzYm16WDh6YlBl?=
 =?utf-8?B?WlUySlNGb29ZSUhHWmN3MjVoSHVmMkRXUHFia2JJSnB6dWhyek5NQlQzMGxq?=
 =?utf-8?B?M0JQM05ubUNndnh2amVaKy9WS0gycjFzUWlMbktxUXJ6dUNpZ0NxKzA5SVZ4?=
 =?utf-8?B?Q3djQW1MZWg0cW9Vc05haUpOSlg3d0lWalUwbi9PZENET1N1dXVHSTBhcjJT?=
 =?utf-8?B?Q3FTRm54SE90Z3Rmb0x1SENFejczdWF2dHhXTm9RUkRFMWxTNHFaaDk4dTNL?=
 =?utf-8?B?RE03dWwzZ3VDTTJiUFIzQWhmN2tidnNMTWVUbFh2cG9oMm0zS3pnUXovcDNB?=
 =?utf-8?B?UkR6eGRsOEc5UlNCTFlXNis2aEdXdm5jR2tkQ1R3eWtyYVl2ck1yaExXWngr?=
 =?utf-8?B?dU9qU0JNT092Yll3bGUyMThYRzJiNEJOK0RIN1Nrd1F1MFoySnlxb3ZpUDRa?=
 =?utf-8?B?Q0dqclltN2h2T2dFbFlXRE5aVFBEb0dhU05FbGd5cWlRYmswUkwvUkJ2ZlZu?=
 =?utf-8?B?eWcySFFFNGc1ZHRlck1zMXlNOCtRVXg1WGlpaHFJNHgyRGxzNGV4Y2ZNTTE2?=
 =?utf-8?B?L0JaNTFUY3o3S3R6TEs5WHZyeVMvcjRVQUZhVVdPUG8rcEVUTUtRbk9LL01s?=
 =?utf-8?B?eTVOczUzWC9FTkpYUWE3WUc5U3EwUDFlZzNFZ3U2c0svV0JXM1JvY3VOZVBG?=
 =?utf-8?B?aFJRMGZoN0dpVWJIekxaOTRnSzZYNnhlQm5iVWowczdQZUVYZ1NXdWNqai9O?=
 =?utf-8?B?d0cvdFgzbFVjdlAvck4yOERzM3Q2M2Q0aWoyK2JralRGSUlRWnd2MlhCSDFO?=
 =?utf-8?B?Mm9tVERMSjdEUVR0SG5CQVhKcDZZRWI4bVFzK2dwTFJXZFlHdjlJeG9ZZUc5?=
 =?utf-8?B?Y1NLTlZLVUhRNlZGRERFMnVvTGVoWWc0a2R4b0pGY01INWJtRHVueGx3SW56?=
 =?utf-8?B?SmhZS1R4R1RvMnFqOVFMZVhNTWtPTHBlU3RMK3ZySFJLV3BCdTdyRm9CV0NM?=
 =?utf-8?B?K01JRml3MlZVdWJxY2Y3UkM0U1VuVUdxaTJxUm9zamR3MGw5WWttdHFNZXFu?=
 =?utf-8?B?UDRCYjlyTVNMZXNpMHc2OVE2cXhnVXZLQkdGYjNDQlZOeFo2RTJKK282eXdx?=
 =?utf-8?B?cXVhQ09rMU1FYWhwRUtFc0ZLQjgyRUhsSklwMnRNNGdGZUkrdG5IMGxxVG1S?=
 =?utf-8?B?YXpFbjU5czNiMWdTNmEyYjluY01jQzNLa3prYjdMcXRzZERiYTdMZG8yTzZI?=
 =?utf-8?B?L2ZpVy83MndBR3BzRkd0V2ZFVHRQRWlOdGUyZDJvUFpwWXZzODgvTExVdDJD?=
 =?utf-8?B?bitzZzhNMm11dHEvRURjKzJ0ZzZPSzVTVEIwV0FkS3dIZmhQS09sdStWYnFR?=
 =?utf-8?B?Q0FZRTN0dDdrMTl2MmhpM1BBaGVRNjl4ZDdmb0h6ZzM4YVc3Y3p6d0RXTmNH?=
 =?utf-8?B?VXN4MTRvVk85YUxRNmE1Ynp2WlpVSWN3QytEVjVOUnNDNm1lY1VmTVc3MmZj?=
 =?utf-8?B?NGpsdndzWGZpL1RkbGRyUHpBQ3JpWVNTdmtzcG81YzdnVUxKb242Ylg4ekY4?=
 =?utf-8?B?QXFmcXgwTVZpRjlwQy9qUC9FQXVIanZsMDV6US9kYzVjYVdEb3cyNlBSMit3?=
 =?utf-8?B?Ti9reDBLNGRzRGFQTVdXSURNRndhUGl2TGw1czBMUEpmU0RwNzNMeXBLQ3hZ?=
 =?utf-8?B?cnB1NFVKczdtMEtTUUdDMGVQcHBONkQ0eUx1ZDJCNEEraURtUWFkUDNmWFln?=
 =?utf-8?B?UmFMdWgrekFIeURGenEraFFZYktPUDhpSkMrVi9RaXFwTVpvNUFNUENLVTRP?=
 =?utf-8?B?WHZ6b05KSExabWJJa2hUNGVTb1dsWjJ5TmhGV0kvUGNmVkFUa3VSOVd5eUZR?=
 =?utf-8?B?eC9NZUNWR1ZaMXo2RTlONUplVmJyRVc5NXRJM1Z4K2tzdDNlTUY2aFRiVmhO?=
 =?utf-8?B?SzV0TE1uNWVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(19092799006)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTVZMnpaU3JJS0drdGtDbzh3TnJ2SU9uUHVZZWVyY1dJSnBjVEc0SU5XaGwy?=
 =?utf-8?B?RTJrN01sNC93T1NBZXFqM2xsRzV2dUdRY2o0NzkxYzJNSkU2MlBpdS9EVjAx?=
 =?utf-8?B?ejA1OXl0bDBCYWxyY2djVUpZMHgzNFhsYkxuMWp3UVZ0M3RWcFNiSzFGcytQ?=
 =?utf-8?B?TlFTR1REL0VIcXlXNHE2K2ZIbGNwZFR0bDdjbTd2Q2xBN0pNTWNFVStmSUVZ?=
 =?utf-8?B?Q2lpVEE2Tm5JZHR0Mm5qc3lRNWhGbm1qWlhYQ2d2NTJ3eEJyQk9teHg1WVJT?=
 =?utf-8?B?Z3FCS2V2MjhoZWFqVlNzOURlb3B6OWRUamhrMDlVeHZYQjBQTFVTL3h1eGs0?=
 =?utf-8?B?OGd2eGRqV0VJb3BLNm1wUWhLVndFbUhXaERIUldwb0V5T3Q1b2MwVEY1dGtl?=
 =?utf-8?B?ZmZnbHg2ZHdWZUJWNytCOExnZFMxQUdCY2ZEUlkrK21UMWtGbHM2d0xUdUpB?=
 =?utf-8?B?QVVyaldpcStZV3d6ZkJ4U2Y0SFFuTnZBVnVGOUlpSE4xTlFUOHpuMHIyRXVL?=
 =?utf-8?B?M0ovTGt3RGcra1dUeHhTaU5wWWlUMXlQaWIyRVNDSW9DNEszc0lPMWc0bDJP?=
 =?utf-8?B?NG93eDlVTDlPdk5lb01RQWVmUGVXWGlNaHJ2d3M0a1h4aXdHbStGbTdEbG1J?=
 =?utf-8?B?UUxIdllZNUhoY3ZOWEhNL1VkUnJJWDFsNjNQT3g0RU9KbStxaXlUUWRvazVl?=
 =?utf-8?B?VmpDSG1KU09aMXN0ZWw1ZW9oMVpaUUwyOG93dHNBM0NJZjJCWVI4ellLZ0ZS?=
 =?utf-8?B?Z1FkTkpzd3dxMm1BbzZGNDBrQ3FJeWhSOWZsVUZWMUpJT3JkL0JydHpIQUpy?=
 =?utf-8?B?UFpmVTdzTHk1UTl5OS80Ykh4ZlhGZGJTNkJYOWJMVkdrNU9paTBrcmprU1V0?=
 =?utf-8?B?UTBjOXNmZnRMUHRaUmJkNzFMRjgyZEpOOUVZNlliMjc4d2pzTTVvOTRXVllj?=
 =?utf-8?B?K29Hdms5b000RElkZVh0UGgyS0hzbWZvbVNGRkFCUzRjSm5PdVpoZGR1UFBv?=
 =?utf-8?B?SDJyYVNrUTk2VnZsRkNNUWxHbUtqSU5qVnlqdTRQNmdxTUhzU2xLd0xZSW00?=
 =?utf-8?B?MGd2NVhxcXJnVG1TLzduVS9lbmgwbDc1cmlZdjRBVGxUQzU2UCtHWEtTVWpY?=
 =?utf-8?B?WXFkeUZvUlpHMVVCSDBkYUVUemU3R2FDZ2JJa1lWR0ROUCtWV0ZYRkJPUDRP?=
 =?utf-8?B?cVdLMHhLSGNSbllBaVE0Y0dBSTAweWUycFp2TUlSQmRPRXd0V0NtWWMxVFF3?=
 =?utf-8?B?Zm11QVdUREFzdVJNb3dGRUIwWXRob2FtcDJFUDRQRmpkcGI5L0tja3YvcXEz?=
 =?utf-8?B?a0pwZ0ZCeDNRQ3RRd0NuQTE2THNNSkwxTFhEZ1lIN29sU2REek9hUDMzSjE3?=
 =?utf-8?B?UUpQQlc2Qy9SMnhNc1VyZWRVWFNKdG9ZYzBDUVZyYVBzNlF1RTUvckl3cEU0?=
 =?utf-8?B?RC90VWJPQm1TQUVGQkNzbGhNS3dzSm5Va2lQR1NUdUUwcTFxQklqcTBtcFFa?=
 =?utf-8?B?OWdHTGZQSHVBNjRqdWd1TXNXcFozaURLTDBzck9SbWpUNGdraXk0TWF1aHVO?=
 =?utf-8?B?K1FONnM0SkVJc1JqeGtwTjFlTVlUbHJ4SjhoR0lFMmlBWTNmVTBkQ2NPS2lq?=
 =?utf-8?B?eGNlUmtIWHRqUXdRc0pYSElFaVk0a3JwSzBLR3ZLTGhseDE5R3ZqclV0NVhn?=
 =?utf-8?B?NE5lTTVMYjdlWnVieE16WUhscVN2ZmFYdVRKc0JDN0NnNzU4Ykl1ZU9RT1dX?=
 =?utf-8?B?Unc0c3NqK0oyYU14NmwxK2lNdWJLSnRvMEE3VHBKRVdqN2tRaXBhMnN6VjR1?=
 =?utf-8?B?djlJZWtIZWFxN0JvZXlOemg1M1BOSzhucEtONlpPSFFzZWRNWVNRTitha2RM?=
 =?utf-8?B?VTUvSW52TE0zZWpoL1MwN3FBY1ZDWnpET25FZmJWSzNZODVUdnlUYUVuNGdK?=
 =?utf-8?B?ekg2a1k3VzJOMllqbWZueUpGVVBFS2RVSmFWL3E2TzNHMnN0MWJ3SE5vd2tN?=
 =?utf-8?B?S29qYmNjcytJWWRxMEJxUW9LaTk3Q3VkVlVYaWEzREViQWExK3p3bFF6ZlU4?=
 =?utf-8?B?V1hFWVBiQnpSWmRuS252ZGdhb1hXWUFFT1R6M29pVW5lS3BtMFJVWHRMb0Zy?=
 =?utf-8?B?d3FrbG9NV0ZvbG5UeGRDZEU4a3dHeWNBSldiK3NnOXVLL2dUcFk2aFBYOEg5?=
 =?utf-8?Q?FE820207ZaBqWb6bJH51lhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B28137B981715B4BBC4C6347E6062979@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 jMetR9DtooFb3npd3VndL2hxjQmCtAePfYdUoYryDPWEFGOo9E1QaOI8FJeEZw2ngki42qE4pvdnuriedUfwgDh9bmw6fBfSuPjAdhvcGiJ3AG4mc0sUmCZVvfAHi/Vm1Hxu6YHnTE/PH7s2OEgZialhAC/2t/vhhBRdv7atHp9ZHKfjUDkzYBwMjmkPwms8KOJ/45VoO6p5hHb21WkDftgXh48FQjLSX18/+qq7ZDGDBk94bHBGwiVeo9sxfeB0fH30nvbjEqSubElfRaSxIyvplw56TbE71AdADD3Emk+eJUf/cpOOaQFapT3kXfnahGjFNppc1m/CvJcY7N4Pl/arGWzFmHAEM5ppBWxSeFjU/seosBdEfkWxg/g442lQmJAKp3oneqjLW6xsMQncDmwUQ19+9MvqHW+aIApM3SAkQbaFzGxPVhRhMZ8AmXmuolI9W4y94LPbLll1gzL4CYhSa/006ASaXgoYzvIruC6/KbJOQoka3eVTffQK7WOW2e5O4UOvFwiAhmJgjHlOsnfnwRFBWm82+yGHvDt30JeG8vaSQ0rC42geXKShgOAtTbSnt7cMfkTYJnvXqQmr7pLv5tWzpZNrBx7JkzS1kzSqvU3ZnJmVThMGqruYzcVNdUOAP41egObLLKYb11QIwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f58d3d8-f1bc-4f9a-30ca-08ddc8878902
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 18:51:00.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFGxl8V1d7NERs7WUUrvY6Fj83dnsHrJL0H68GHPscgOSgDRWyHABdjaZeurL/U1Sr/RzXTOG1EQrb+0ncIBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR19MB5275
X-OriginatorOrg: ddn.com
X-BESS-ID: 1753125940-111281-7795-7553-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.101.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZGBmZAVgZQMNk8Jc0s1cw02c
	ww1Sg5zdg41SzRMtXcxCTN3NTAJNlIqTYWAGiL+udBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266210 [from 
	cloudscan14-95.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNy8xOC8yNSAxNzo1NSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAx
OCwgMjAyNSBhdCAwNDoyNzo1MFBNICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToNCj4+IE9u
IEZyaSwgSnVsIDE4LCAyMDI1IGF0IDE6MzbigK9BTSBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4+Pg0KPj4+IEZyb206IERhcnJpY2sgSi4gV29uZyA8ZGp3b25n
QGtlcm5lbC5vcmc+DQo+Pj4NCj4+PiBDcmVhdGUgYSBuZXcgLT5nZXRhdHRyX2lmbGFncyBmdW5j
dGlvbiBzbyB0aGF0IGlvbWFwIGZpbGVzeXN0ZW1zIGNhbiBzZXQNCj4+PiB0aGUgYXBwcm9wcmlh
dGUgaW4ta2VybmVsIGlub2RlIGZsYWdzIG9uIGluc3RhbnRpYXRpb24uDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiAiRGFycmljayBKLiBXb25nIiA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+IA0KPiA8
c25pcCBmb3IgYnJldml0eT4NCj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2xpYi9mdXNlLmMgYi9saWIv
ZnVzZS5jDQo+Pj4gaW5kZXggOGRiZjg4ODc3ZGQzN2MuLjY4NWQwMTgxZTU2OWQwIDEwMDY0NA0K
Pj4+IC0tLSBhL2xpYi9mdXNlLmMNCj4+PiArKysgYi9saWIvZnVzZS5jDQo+Pj4gQEAgLTM3MTAs
MTQgKzM4MzIsMTkgQEAgc3RhdGljIGludCByZWFkZGlyX2ZpbGxfZnJvbV9saXN0KGZ1c2VfcmVx
X3QgcmVxLCBzdHJ1Y3QgZnVzZV9kaCAqZGgsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGRlLT5mbGFncyAmIEZVU0VfRklMTF9ESVJfUExVUyAmJg0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAhaXNfZG90X29yX2RvdGRvdChkZS0+bmFtZSkpIHsNCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlcyA9IGRvX2xvb2t1cChkaC0+ZnVzZSwgZGgtPm5v
ZGVpZCwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkZS0+bmFtZSwgJmUpOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRlLT5uYW1lLCAmZSwgJmlmbGFncyk7DQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAocmVzKSB7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRoLT5lcnJvciA9IHJlczsNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB9DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4+DQo+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgdGhpc2xlbiA9IGZ1c2VfYWRkX2RpcmVudHJ5X3BsdXMocmVx
LCBwLCByZW0sDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGYtPndhbnRfaWZsYWdz
KQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpc2xlbiA9IGZ1c2VfYWRk
X2RpcmVudHJ5X3BsdXNfaWZsYWdzKHJlcSwgcCwNCj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW0sIGRlLT5uYW1lLCBpZmxhZ3Ms
DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmUsIHBvcyk7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhpc2xlbiA9IGZ1c2VfYWRkX2RpcmVudHJ5
X3BsdXMocmVxLCBwLCByZW0sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGUtPm5hbWUsICZlLCBwb3MpOw0KPj4NCj4+DQo+PiBB
bGwgdGhvc2UgY29uZGl0aW9uYWwgc3RhdGVtZW50cyBsb29rIHByZXR0eSBtb290Lg0KPj4gQ2Fu
J3Qgd2UganVzdCBmb3JjZSBpZmxhZ3MgdG8gMCBpZiAoIWYtPndhbnRfaWZsYWdzKQ0KPj4gYW5k
IGFsd2F5cyBjYWxsIHRoZSAqX2lmbGFncyBmdW5jdGlvbnM/DQo+IA0KPiBIZWgsIGl0IGFscmVh
ZHkgaXMgemVybywgc28geWVzLCB0aGlzIGNvdWxkIGJlIGEgc3RyYWlnaHQgY2FsbCB0bw0KPiBm
dXNlX2FkZF9kaXJlbnRyeV9wbHVzX2lmbGFncyB3aXRob3V0IHRoZSB3YW50X2lmbGFncyBjaGVj
ay4gIFdpbGwgZml4DQo+IHVwIHRoaXMgYW5kIHRoZSBvdGhlciB0aGluZyB5b3UgbWVudGlvbmVk
IGluIHRoZSBwcmV2aW91cyBwYXRjaC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGNvZGUgcmV2aWV3
IQ0KPiANCj4gSGF2aW5nIHNhaWQgdGhhdCwgdGhlIHNpZ25pZmljYW50IGRpZmZpY3VsdGllcyB3
aXRoIGlvbWFwIGFuZCB0aGUNCj4gdXBwZXIgbGV2ZWwgZnVzZSBsaWJyYXJ5IHN0aWxsIGV4aXN0
LiAgVG8gc3VtbWFyaXplIC0tIHVwcGVyIGxpYmZ1c2UgaGFzDQo+IGl0cyBvd24gbm9kZWlkcyB3
aGljaCBkb24ndCBuZWNzc2FyaWx5IGNvcnJlc3BvbmQgdG8gdGhlIGZpbGVzeXN0ZW0ncywNCj4g
YW5kIHN0cnVjdCBub2RlL25vZGVpZCBhcmUgZHVwbGljYXRlZCBmb3IgaGFyZGxpbmtlZCBmaWxl
cy4gIEFzIGENCj4gcmVzdWx0LCB0aGUga2VybmVsIGhhcyBtdWx0aXBsZSBzdHJ1Y3QgaW5vZGVz
IGZvciBhbiBvbmRpc2sgZXh0NCBpbm9kZSwNCj4gd2hpY2ggY29tcGxldGVseSBicmVha3MgdGhl
IGxvY2tpbmcgZm9yIHRoZSBpb21hcCBmaWxlIElPIG1vZGVsLg0KPiANCj4gVGhhdCBmb3JjZXMg
bWUgdG8gcG9ydCBmdXNlMmZzIHRvIHRoZSBsb3dsZXZlbCBsaWJyYXJ5LCBzbyBJIG1pZ2h0DQo+
IHJlbW92ZSB0aGUgbGliL2Z1c2UuYyBwYXRjaGVzIGVudGlyZWx5LiAgQXJlIHRoZXJlIHBsYW5z
IHRvIG1ha2UgdGhlDQo+IHVwcGVyIGxpYmZ1c2UgaGFuZGxlIGhhcmRsaW5rcyBiZXR0ZXI/DQoN
CkkgZG9uJ3QgaGF2ZSBwbGFucyBmb3IgaGlnaCBsZXZlbCBpbXByb3ZlbWVudHMuIFRvIGJlIGhv
bmVzdCwgSSBkaWRuJ3QNCmtub3cgYWJvdXQgdGhlIGhhcmQgbGluayBpc3N1ZSBhdCBhbGwuIA0K
QWxzbyBhIGJpdCBzdXJwcmlzaW5nIHRvIHNlZSBhbGwgeW91ciBsb3dsZXZlbCB3b3JrIGFuZCB0
aGVuIGZ1c2UgaGlnaA0KbGV2ZWwgY29taW5nIDspDQoNCkJ0dywgSSB3aWxsIGdvIG9uIHZhY2F0
aW9uIG9uIFdlZG5lc2RheSBhbmQgc3RpbGwgb3RoZXIgdGhpbmdzIHF1ZXVlZCwNCmdvaW5nIHRv
IHRyeSB0byByZXZpZXcgaW4gdGhlIGV2ZW5pbmdzIChidXQgbm90IGJlZm9yZSBuZXh0IFNhdHVy
ZGF5KS4NCg0KDQoNCkNoZWVycywNCkJlcm5kDQo=

