Return-Path: <linux-fsdevel+bounces-49990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684FAC6EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD94175622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD7288505;
	Wed, 28 May 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z2pCG3t6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B1CA6F;
	Wed, 28 May 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451701; cv=fail; b=VE5AU4NXh2UAzbW54kYrxbUp7bV26N/Q0roTFlZZov/MhylEPD4ae8MmTAcEEpU8WCqLOxHL3NQHbpC75r9Gsnc4F19UHB5BhJybN1RpXXAT7vUWqD5giP9ivlYLqmoCbF0LK5rwVkR6k+zmF/BFPQTgFwnLq7zC/IwTrTJR0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451701; c=relaxed/simple;
	bh=LbhBHHuJP8opxgNrttzSySVwFwAJTavokmClnoE8BIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Goc+eW3H2Z7ZKOvHQ/CXsXlab6SvWvdgGpM2gWd2whJnNcGY5ZGDUHhaplKjKEVAhF0sbi/WCCTFPH1ScZvtAF+oiISRPj2HuUsjfdl1LoSnr6smI5B4rWyQNeBjcfsybID/4/qSQVA3P2qisliS+hsbFSsnj0/dvDU237jdytE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z2pCG3t6; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUroB19ghrnjbHDYWwWcG3lmmtkl6IFrHmnMWN1wrB70hjS7Ppjxw4HMSco260EZRsjInMGMU68K9tUCzMfdBydE/LTz1/XzQ1Riqbh5ncziJKOGmNVpoZs88Nb5dn+dTVS+nMNiQlJEmMP6X/Vx3KOmJVw9RXznluE3SFXwFQfHL1JiqiDVOddLQT7yAYrq/M01g9paekvK4yuaepB4eViZLa30ZiARl+UJ6x3Gz7sgLTgGdpx0xUWg+sP8aDAhYHRCNKJP1qLC7cjKndu+tw52sQKU11AZpyX2kf7nLEb4WxiSKJoNGKb3GgwzCAgo8b/l49BMkXfriC4Q7EG+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbhBHHuJP8opxgNrttzSySVwFwAJTavokmClnoE8BIo=;
 b=L9urTrnnrXX7ANOHI98ivfnuTTJ52vpM0UP04UGc2j5C1vG5ZlqDBdNwucieBfd/N0CWqZDEOOnLxrMUFiO9hjWXhVAtoOpGsLitcElwDDtcW5FDZlaFy3YfJwh92Eo7ah5CjnHO0oBkgl4gzoMf3QPwJTjt3pCf14tBPOQlCAvJtRlEAKplBZUYeXjt9zPeeJaynGShWWqc7GGyvHNQkMAJNvRkZIeJzwf47tguiRbixvoKNNWZLR51kJZ9mOT3N9tLBEoN7iUvw9RBGYcECy+92bnjVw3zuarMlKqTyhu0hVLwJZSxttx4bIbWQicmTFWMzxVy8zWX4VfP1GiC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbhBHHuJP8opxgNrttzSySVwFwAJTavokmClnoE8BIo=;
 b=Z2pCG3t6ikbL10BFzf5pGHy3qM0iAfJzccQhGcjHjoWreJlD9mmHFm27lN1IGueswF4uRjohF0Ts9vyMb6Uwe2ribmGIbndJYhdA877X1RqgmRtZpBaopRWdLUHo4WjfohGNXbyo7emCyVe2eOWSHQNgiwBZxx0oGeGFCZGp3LYA1CsTEbDJMrP+NkVpopaydbofHrOn+jauvV62dy/oM4nxA4L4Bf5r9+cIEIDC0NCeyAlABqN4yI/dQgDCyEA14k30FAWnriOIMKrg/lceWdh5xuDAZExoADQmjHYqGzb6KbaA3sXdLc/zF6XGwange+7+j1lp6puVHZPlPT8MvQ==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PS1PPF8B633BB92.apcprd06.prod.outlook.com (2603:1096:308::25b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 17:01:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 17:01:32 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, Andrew Morton <akpm@linux-foundation.org>,
	=?utf-8?B?RXJuZXN0byBBLiBGZXJuw6FuZGV6?= <ernesto.mnd.fernandez@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
	<syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>,
	"Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gaGZzcGx1czogcmVtb3ZlIG11dGV4?=
 =?utf-8?B?X2xvY2sgY2hlY2sgaW4gaGZzcGx1c19mcmVlX2V4dGVudHM=?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGhmc3BsdXM6IHJlbW92ZSBtdXRleF9sb2NrIGNo?=
 =?utf-8?B?ZWNrIGluIGhmc3BsdXNfZnJlZV9leHRlbnRz?=
Thread-Index: AQHbwmJGj8mFL2nAek2mTA35cy2Tz7PS9cmAgBCJgeCAA55kAIABQSwQ
Date: Wed, 28 May 2025 17:01:32 +0000
Message-ID:
 <SEZPR06MB5269C1D405F40BD197989E89E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250511110856.543944-1-frank.li@vivo.com>
	 <58e07322349210ea1c7bf0a23278087724e95dfd.camel@dubeyko.com>
	 <SEZPR06MB5269FA31FE21CD9799DA17ABE89AA@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <13f85ee0265f7a41ef99f151c9a4185f9d9ab0a0.camel@dubeyko.com>
In-Reply-To: <13f85ee0265f7a41ef99f151c9a4185f9d9ab0a0.camel@dubeyko.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|PS1PPF8B633BB92:EE_
x-ms-office365-filtering-correlation-id: 00e0fd0a-172d-4942-6b27-08dd9e094c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXZ1UVQ2SW1JSzA1ek5sTENXc0IvTzN2OVBaR2ZiVDBKdnB0QlBzREdLc2dK?=
 =?utf-8?B?QVJIbkFNYVZqOEN3RkZnOWZwUUUyaGlxQ1hraFpTQklZQUJNMHpNQ003MTNG?=
 =?utf-8?B?cHJYUHVGaUVCaVBqd1hhZkY3T2FlM3dWa1pIMUVsdm5RNXVod0l5T000bm9y?=
 =?utf-8?B?NE9nYUM2TVN0WDJCd05Fdm4vQmlZMzNWNHJwWFVIWnZsVGE5ZU9meTl1VU1P?=
 =?utf-8?B?Mm96L3p5ejFwQ2Yvd1dROUtuaFdaY3MwZnk1UVlXaXlRcFR4L2RuR2ZvWENq?=
 =?utf-8?B?TXRENVRBOGRrWGFHQXhocnpyN2E3UUJGMWhIcUx6RHdMRlJIYXBJcGh2aTZM?=
 =?utf-8?B?Z2YxbTY5ZWxsa2d4S0JPa3U2WEJQVlhpVmdwNlE1N0ZEOE9xSFFidUNUc1d4?=
 =?utf-8?B?NjIrbko1RFhpa3ltNGhjZmk4U0ZDQVQzTnFOaWtSeXBVa1RhQ3VsblJMV2ZB?=
 =?utf-8?B?a0R6eHc5dXFJNzVHMVZrVUR5d010OFpIZFNudDNiTDhJWjdvV2tJa0JnM1Ro?=
 =?utf-8?B?blh5ZkkyZlVQTm1hbk5FSXNVV1gyS28zKzJndUhWbXRpL0ZPSCtKTWdYdEJB?=
 =?utf-8?B?N0d5M0JrcDQxbzVTaytXTE9pV1BzVk1Qa01OWFJxTVdGK2Y4WGhuQmdDTTRl?=
 =?utf-8?B?VEQ4V1VIM2V1aHoyOC9YTnFhcVF0MWFFdXhET2xKblhYTVhBODZtR3pBS3R3?=
 =?utf-8?B?bFRWajFZQ09GcjU3VklSRTUxQWx3d0NnaksvYjR2KzJRQ2s3TStCYnNDZ3lV?=
 =?utf-8?B?UWtvT3IyUXYxc3FXcmNLbnRNUU5ZVzFlYWRDUHFVc2NEdjVyR0VPVGR0MGpX?=
 =?utf-8?B?KzBlNStOd05EdWNBYmJ3emFCM3EvUWIxcU9lcEZxRmw1NG5zUGVjbVpGdmJX?=
 =?utf-8?B?WXZaR1p5Y2dWVy9pMjR2UmpjdXZ0N1BmazJFTWMzdXQ1ZStpdExMNnI3U3FM?=
 =?utf-8?B?a1lsdWRWOFhueUxoTzNneU5PMlMvRHdhR2NHOHNPUlJieU10ZzVuL1BIcTRK?=
 =?utf-8?B?RkJ1d2FrTDBjVUMzVEs5d1JCU1VZZWhKbVR5di8vR0V3a3BDK2pMZ2xvdkZt?=
 =?utf-8?B?RFlLOWllOUZvVngxVklyS3hqaDNJUVUrRzJrMWE5QlRvN2MzYWRHcGJGblhW?=
 =?utf-8?B?L3dIbHZSUnBiUXJtL0hzckVtWjRDVGwvS1dOTXZWK2FyM3kyaElaejRYc0Fx?=
 =?utf-8?B?TWtrcCsxR2VvWEdpM1BqUXJTcjlLc3QwWE53MnB0Ukh3V1EzdmJhL1pJYW5a?=
 =?utf-8?B?VkRnRnVhbGw1cUxaMWVyTnJCUTBIMjBIMDR1bUxRUUZSbEQ2RGFIWkwwaXJN?=
 =?utf-8?B?NVMwQVIzMzBEaXZka3NiVDBKWjBCeFV4SktObHlaVXk4NkNFQ0RCSk84U2RR?=
 =?utf-8?B?bzRCcGU5ZXUrTmowQnc5Q1ovU2hMZWJKZXV5WEFxNmpDZXNsUSs5V3Q1T1d3?=
 =?utf-8?B?QnFyWnJBUklRaEU4SlR5SnFvSGNUbmZDYW5QVUE1UTJ6NlE2T0Y4RjRxaXpQ?=
 =?utf-8?B?eFZTcDVnUC9BT3RQUzFNTkk1QXFOdXVUcVhyUzB4a2ZGSVhta0tadHZONzlm?=
 =?utf-8?B?ZDhReTJDc2lGSTNUcDVPeno4SVFZcEdidG00SjVhYk1pYkJYOXhHUEc1MTFI?=
 =?utf-8?B?VHR2bXVXYTBFTDF6eG44bU1pNHdFdm5NK20xY1ptYUJhZmZkSjI0MzYreVpr?=
 =?utf-8?B?SE5ZcUp3QWMxajZsVnRnK1JTN0FYVlF0eUZ5WTFmazNuU2FPT1l5N3daRDBr?=
 =?utf-8?B?cDlxU0FQZG9xZUkwT2FSRFhRQXYzVTZDdDVVcFVQMEQ4RSthVTJ6U3F5TEtR?=
 =?utf-8?B?R0xGVUVHZ25oaXpMNU94YUUvdG5oMVl2VTVTQjlSY3hJNE5HU244VFJocGta?=
 =?utf-8?B?RWt2Vk9UYVdsNW1KQzFDdVZoOGVncjU3RmR5WVJsNFhtaVlCbTNEb05ZU1h4?=
 =?utf-8?B?UGJOdzVpZTVJTy9VbHRYVHhuQkY5VFpKTkFSamgrY01mZ2psc0daWGdWci9a?=
 =?utf-8?Q?ak1DLQlTFf20raVuslrXdpupI6YzHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzU2aXdCWGhRdEozVjVQZkt4b3diNFVieDdTVWV3Zi9PcDE1KzJBQjVDSjls?=
 =?utf-8?B?QmJIMWZ1OHVXbW5SdXMrc3BEWUFhMDJpSUtuUmtiMTFla3VKTzFNUlNNRXBX?=
 =?utf-8?B?OEFTc3VHSHZJczVabDNzWG4vMC92YnNBdG1ZVjNoWHdKTXZGa0E0U0JXRktN?=
 =?utf-8?B?UXlsVzBqdnEvRDZWTkNlWjlZRmhESjBwdFVHalpma1pNeUNQVEZQN3dPcGt0?=
 =?utf-8?B?SGUyaEhmaURSbnpBb1RnVXJmZFZzNkxBY05rVFlMU3Rpc1o1elFrc1ZES21T?=
 =?utf-8?B?Mzdmd0Ztc0Z1aUVhN2JnVnVWc0RwK0FWYm1CeHJVeEEwODJCVjZId0ZML2F4?=
 =?utf-8?B?NlAyVFZwQ1MrT1h0czNVYVpMWk85OTYrbFdHNVBlWmx1OFNOK2dMaW8wSFcz?=
 =?utf-8?B?b3gzRDR3SURkNDVNQ2k4ZTNVdVZUbmFISTBQUGc5bStTamlhcEZ1cDZEYkww?=
 =?utf-8?B?ZTF2SmRrdW9lM21VMCtUMWpjRXhQRW93aWFzcFNWNXlHQUptMnZsSmNwZ0s3?=
 =?utf-8?B?cnIzWFVBeXVHYmd2RWFicGFBS1daWkhPR2E1L05tVitZSjA1RFd5dmRvYzh6?=
 =?utf-8?B?akF3QzQ5V3BETzZaM0tjQUV1Uy9UTUhlYzFYYU9ETFFoc1pteThOVGk1L3hy?=
 =?utf-8?B?V3UvazI2eDh1T0dmYzB4VmJuTjhJWEJhK1AyQjFJenhyamhHb0JiYzV6c2tJ?=
 =?utf-8?B?emJIVUpsQ3pXMUI5MityVnRBYTk0djJTa0IrbG9zRkM3cTFHcHpOYy9GbzJn?=
 =?utf-8?B?ZG9zNlRLZUJ3U21BakZ5aDJLbzVMY2ZZSm5zUXVxMnQ2RTN4ZkxFaGlFT2l1?=
 =?utf-8?B?WStoTEhvWDhhSHZYdDltbDhSVGUrR2M0SzdrdmQ4K3hQWklzWGRhdzI5enJy?=
 =?utf-8?B?cWNCMEN5alQ1OUE2ZXNIOHMyVzNTcndoWmJWYTBsRmZ5L1J0NDYxN2s3cHVq?=
 =?utf-8?B?dGJEcHZDWDFCRFFKZXp2S21yamw0NHArbEZUbnF4YlBFdEkyT2FUTW5UUVJx?=
 =?utf-8?B?REI3ekVIekZtQ3JwZy9BNnI3a05EVVFzR1YrUlViNHNrK1l2UjJSbFRNeUhr?=
 =?utf-8?B?QWl0Q3lmQUdFU1RVaFJIeCthUTBEQ1FTQmF5VzQ1U2xMN2RrbFdBUzhxSjN5?=
 =?utf-8?B?enI0RnlMVTBpU3ovZXlPZjhUU05hZVlwbmdqdmlnQnhhYkdvckR1M2xtZm9t?=
 =?utf-8?B?cXVOQU9lZ0VQc0N3akdTVFFBR292TnVDM1NqVHBTOFRxcTJWSXAyUEI0SU1r?=
 =?utf-8?B?aVFRaFk1KzBiSmtkb2JsZU1DNzlTMkpVWVlrYng4RVUyamdhM3Vwb0hva0Mx?=
 =?utf-8?B?MHJ4LzlLalBqRFh3Z3JRNUszMG85VWcvQlZibDl0T1owd3ArVldsMFNBZk91?=
 =?utf-8?B?VG91YnFpa3k2Nmp2YUo2Mjg1MHBXUzUxSUdUdHF1SVNLdStveGtmbDdzUEpI?=
 =?utf-8?B?dlExUGJBL2dRdncxbDlKSGxvSlJjamYzZDZPUU4xeUVRQWZoVlBVbSt4c2FH?=
 =?utf-8?B?VVRZc2lkQy9FNjI3bkRQK3orS0luOVI0SUpvWHM0S1pNSGc2OWh5MDlOSEFW?=
 =?utf-8?B?d0ZJd01RMWhzNjJQUlNCYkZScGpkTm1IOWhvb1RFczcvdVFhRjc0eFdiTmFP?=
 =?utf-8?B?S0Yrd1JtY0lkZGh0NWdTSkxpUWN5ZGxKUmxRTGlaNWVybXA0aEYybDdJSlFO?=
 =?utf-8?B?eFJyVG9hVW5jdEhmcE45dy8zTlVuNWN5WG00OEJ0ZFdFN2I0WENwVnI1K1NS?=
 =?utf-8?B?TmRPY0tBMmdLeHZqcmFoYngvQ1JkalhEK2tHdnNiQkVpVnVkRzJUQ1lJSjg0?=
 =?utf-8?B?bjkvVS9uSDh6bEpkc2pkaG1TVXF6aFdNY1k4QnJOUm5Jc0RWSjBwYUg3c0lH?=
 =?utf-8?B?MUIxN1B3N01GUXhrdDMvOGd3c1c4MldNdGsyN2ZERWlkNHNCN24veXdBb2Z0?=
 =?utf-8?B?c2x2NlpXU1JpQjUvaGtVY2R3NnJDYndveCtzS0x1dFUybHdPcnVReVh5ZVNa?=
 =?utf-8?B?UXBMTEQ0L0RmaExUTXNsNUNRZzdocjhrbjFYbEZuaExCeHppMGsrSS9UVXkv?=
 =?utf-8?B?RlFMSXJ2M1dWZnRYVVR6QUhmNmk3ZmlPVmRRTGlXeWJZOHh1VmtwVi95d2pj?=
 =?utf-8?Q?CBOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e0fd0a-172d-4942-6b27-08dd9e094c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 17:01:32.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuPrQcbInk1zqQTxgpylnrnMLcl4/pgZ2YGdtdkzb2L7ZpX2Mza31nnBdfSqUQewhXRUxjJJslrcqkbBaZ5mMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF8B633BB92

SGkgU2xhdmEsDQoNCj4gQ291bGQgeW91IHBsZWFzZSByZXdvcmsgdGhlIHBhdGNoIGNvbW1lbnQg
YnkgbWVhbnMgb2YgYWRkaW5nIHByZWNpc2UgZXhwbGFuYXRpb24gb2YgdGhpcz8gIA0KDQpJIGRv
bid0IHF1aXRlIGdldCB5b3VyIHBvaW50LiBXb3VsZCB5b3UgbWluZCBhZGRpbmcgYSBjb21tZW50
IG9yIGVkaXRpbmcgaXQgaGVyZT8gOiApIA0KDQpUaHgsDQpZYW5ndGFvDQo=

