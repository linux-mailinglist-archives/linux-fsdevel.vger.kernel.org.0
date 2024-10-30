Return-Path: <linux-fsdevel+bounces-33240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBB59B5D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 08:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C769284203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E41D1309;
	Wed, 30 Oct 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="JB6ehi4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4533E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274438; cv=fail; b=In3BygCXz0umuoT6fg+GIeIJVRU8ONs3+Xo4FnIUHZd93ACVJTLJ7bV2XIeyE4bWfB/H2j3S6eYV+FKzfBAZnWR0dmjdFqR0NfJfu8lwdTCR4u8B/s5t+2245N56giVRYJdyF69B1UbVu4/HBPPWZJTAH4jv2+RJi1pber6S1VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274438; c=relaxed/simple;
	bh=K43IqakH7DZq6EnrC7WWdCpnB67atr9CrOfVPja0YfM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lsGSmg3WkdwiSzoDdp4GjjbPQNGX4Bc51iSOmMw6H8K35wY3yQ16hwZwHyy1VDI8q+8P/cK9EcLI/m7jmGZ3/hHti1e4UvvBPpGf+srupIfGZje2Py6UmshOei/F6heXfKngRDGaLxHgWhs9C7JiMIhx3WWUyOi677Cecy0mR/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=JB6ehi4S; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6cDJW027047;
	Wed, 30 Oct 2024 07:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=K43IqakH7DZq6EnrC7WWdCpnB67at
	r9CrOfVPja0YfM=; b=JB6ehi4SLn2ag3ix2cUbcxJq7o3bFj5BZbbMH0pszEzIM
	MnEREGIYjbfZDjZZrLq5nWcMhk8svrHUgNJvzXY4ZLm5ebFTsLUtq1mv/rlmAQyL
	ZpbU/ImvEqee/egkNzGDyUIgmMYL4GcX8o/2kf4JxRzyhbS9E3qaHe+hB2BiD7Oz
	cAlNmojy9oxsTu58lX2pA5QQeXSyUYQ4ybnp0yvN825iuZLBdhKXT9CucrEw8BhJ
	f3ZcDt7Hi4n3DUBwgD70jM0JLQ/4l6TnHgMOZE13wu9yK+wzTODPlOXUVteF2F2g
	7GilkoHL40mI+/APffwn1lUaGTyaq6NFE2kfGzDpw==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2111.outbound.protection.outlook.com [104.47.26.111])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42k2ypgnpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:47:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7UGVT6wu+ayu3SYo1bZL2dDLwzVm041fpv1NeE/lyT5eVatxbaJXTYcerTQTQjVeT9hov+IuQBvCf7YLWml+HLAUDhWf8kH0EBZ1K0EYVpHVlbgUJl+SUkKwmOgnyi8c/Ds56RlO5Gy4eDnri8ug6NVm9CHyAr7yPbANC29Gr1NQM+PVa0WnZ3JrCqV1AhzEeKFqb6O3mMcbSFx8KnJz0jyjTQSOl9hHEr7waOB1dEmnLdDQ0h5XS9vywr45wy9M/mNbWdzDmRQq/kqSp5wcZAXwNPKSy+44vriG0DSDaL2iOLL7lLfOIepBaqDsShvFkKUylVFgAUAyWZiooftvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43IqakH7DZq6EnrC7WWdCpnB67atr9CrOfVPja0YfM=;
 b=YT2c1wgoMR4wj2BZJES0bB2JV9/SC0Zo0VzlqZJC5LZby/GBl3wV0WGPfbuICJPVOdCg5Ovdu5dA3qEml0aSVfktDTFU8T7iM54THQtWkYK5B2Ylm2f784bcj2GTeeJGhIDPQZmOzZclZnsakOstphsyDWlNt9/Yj6PToFa7luiGYT6W4hxGTrQQ9bLfOPOvAMCTHW82DYXVTXgwebIx8OUkYrjLoq5oufr7wh1JpitSX8R6oWzRo+CMwDaiJFC5QEaMcbggatv2y2yxeYDc9dcF6+NNLiLJ1xfE/ftRPLfi4CJSvBXeWa6CJIRPHkfgC9gk8r5X+kC6uxUTomFByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB5689.apcprd04.prod.outlook.com (2603:1096:101:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 07:46:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 07:46:56 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1 0/2] exfat: fixes for invalid start_clu
Thread-Topic: [PATCH v1 0/2] exfat: fixes for invalid start_clu
Thread-Index: AdsqmUaTfY4djlkmTFuOJlZKtxP+AAABbTJw
Date: Wed, 30 Oct 2024 07:46:56 +0000
Message-ID:
 <PUZPR04MB6316005B9D2632DDB7E0E2EB81542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB5689:EE_
x-ms-office365-filtering-correlation-id: e50278a7-968d-41d9-9735-08dcf8b7077a
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnNSaVhXWERWY1ozRlJuMk5CL3VCNGxxdHp4MDFIcHRKdUpmaDVnRDVlNDJo?=
 =?utf-8?B?SXBtVCs1Mm1COVdPN0hyaXdZQTZBbGZxRDRSK1ZqYkFPT1lHL2VlSnpzclUr?=
 =?utf-8?B?ajhaM2lpK2NWcEp4OUZaSGJwQTM4d29xWm5aUkxJNWxIWjErL2ZLRXpMTXJR?=
 =?utf-8?B?MkVQaWJqL2lMdWc2cytPWEQ3cUhkeWtlWVd4WXBBOFVMQ0dsQlpPc0VZNDNH?=
 =?utf-8?B?SzZsWmF3ejlFL0pyUThIdHhDYkpZaTUwSXI2ZUpUZGRQc3RXY2laWUZRQmpF?=
 =?utf-8?B?a0tsQ1QvNmhvQzh2Z041eUlBNHJJY0ZWTWtXQ3U5QlFXWjMwempOL2dXSFN0?=
 =?utf-8?B?QjdFOHRqSWgwaFgwOGd6SUJmK25yT3BNSys0d2duaW8yTGw2S1M2anRQOVp6?=
 =?utf-8?B?c0NQZFMweERGMURISG9BK2g5MlVWMndkZUtJWGZscVpJaWRUOU9CVFVkY1dt?=
 =?utf-8?B?cWtEK1Vqa0h3S3V1TldVRnNHUzN1QW56bTJ6WmlwWUpsVzc3cEJyMmxENjcv?=
 =?utf-8?B?MTE0ejg0Ri9iajhNdWl5dTBjY3d5ZVpuUkt1UDFlTjQvbFJwUnNZSVpqSmpn?=
 =?utf-8?B?OXU2RVlyb2dUNHZCOGVNUTF6QnlERkM1R0NKRTRlVmQ1OUFrRWI0RnY1VDIy?=
 =?utf-8?B?VWZDMjJCZk1OVzZ3UWRKSUk5eGJjZVNTa2p1bW0rL2xRaDh4WW0xYzdaMnFE?=
 =?utf-8?B?ZlI3OU5CRVBFcnhBbUNIakJpd1c0WSswdURsdzJ5cWFOQzFoK05kY29PYi83?=
 =?utf-8?B?Zjg0MjlMT0N2WXZQVEtGT1BFYkFacFpyOU9OcXNlNm9qMWJTQWd3WUZ2YlhK?=
 =?utf-8?B?cHVOdTRPUS9BL2FQSHVPMml1M0tyL1VNNVl4UjNDa2gxV1hvakR2ak9LWU15?=
 =?utf-8?B?S1hlcWUzVi9NSTFkWkJ1M0lkczhNQ29LZjFuNHBKRE1uOUVDczhYNnl3L2tH?=
 =?utf-8?B?ZCtzZnZJTkMvZU9DRktwSERPQzNnbGVZUXVaVkh2bHZzTm9IbEVYOFNkOEp4?=
 =?utf-8?B?T1RDbGtzSEVHSGFzUi9RTHpXVmk2QzJDRXNFZkhtdVZ2MTcvbUNSYkpsSGls?=
 =?utf-8?B?L3BzcDRrb2x0Z0NHNXFJSHcrOGtnWWVOM1hSb3RDSy9Qc1p3ajhsRE85WmQz?=
 =?utf-8?B?ekgxczllQ3pPSndpVVhXRHlHM3hyajVkWk9VQytsRVN1dUpNUDVOWng4ZXFY?=
 =?utf-8?B?U0xVM2srSUREVUJYVTZTTkdaSU9ndlRMbDVjVy9hdEJMSUhxOERQUlV0RTlV?=
 =?utf-8?B?RTNPZGQ3M1lhWXFMYWpnaHVJbktCNS8venlqQWJZQllxcjh1ank0cUplbWpY?=
 =?utf-8?B?NzhxTXlaRW5yTjZnaFV5KzZBd1ZiWWlqZGNEckVQdGpQdzBucVJTdG5ETDMx?=
 =?utf-8?B?US9UbDI4V25PTDJReHRrY2tEb0NMNlB1K1dLOGIzN0RKbWVJTDFoS1BubjVZ?=
 =?utf-8?B?c0puL2ZWLzFoUWZ1bFZ1eldIVXRIOGNVOEtUYjdSVUtiRHg2bWk0akhxN3NU?=
 =?utf-8?B?Z09aRE5xbWdzd0ZkL3YwMmw5N0RqN0ViWlNhZ3NvN0Q3ZkJiVlJ0T24zaTUr?=
 =?utf-8?B?cFpzUmR5ekkyTHFqU0thbmE5OHArdkZnd3BmTWFuVVFxU1hsbmNPNXplYk5E?=
 =?utf-8?B?ZXJEeXZYdVhFR1hpL3VpNFZzKzdXc0g2K3VWczdaNWpMRFN1Z1dhSUNZT21a?=
 =?utf-8?B?YzVOZFBoQ3hQaFRLSXFibUxJK3c4WGtmUm1rcHRYQ2tjbUMrODdzbWhPQ3Bx?=
 =?utf-8?B?Z0U0dzNvNW43TTZpVkFGMHNuZmw5VUhiYnVoNU9QbUVac3o1Mkw1dnpkSHZa?=
 =?utf-8?Q?1C7zhU4xeuSFylpaA28ZRVzC9rUQJWD+x/OhQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z01TUWFRNGkyejgzdTZHbGZ4R085SklZRUZaMGhwOWFQMVZSdkFaV3RtRmVW?=
 =?utf-8?B?NFJFRWVlVFlxbVR0aXZrRzYwMkt5T2lIeDdtMjBOeEE4QXVSZUFPSlVWMGZn?=
 =?utf-8?B?cUZnVUViMGZZcnMvcDNOTEF3bDgwWGVySnVsczg3azNDRjBpMzlJdXk0bmpR?=
 =?utf-8?B?MlY0VzNvN3dJVUxLVkcwTWZXWWNqT3VmckhHYXBjYVVjU0hkaStsUUFXYzY0?=
 =?utf-8?B?VktOb05FZjFKSnJBYVBCYU1BRHAvNThRbExESE55MU9VV2t4NkRWQm1MUDFK?=
 =?utf-8?B?d01acitjZzNMd3gzMmJTUS9GQmhmL3NZc3NOWUh5SWVxKzZEZTdjdUhOcEhG?=
 =?utf-8?B?NXJxVFFzYytUd0svVUp6Mk82WTVYQzhrU0Y3L3UrL2IwTXg3SjlkODJsWnFY?=
 =?utf-8?B?WmZ0aXlEajJHWWloUUNIbm56U0N1a09jTVlKUnlQQjVQMS9FbHlkUFNDNFpP?=
 =?utf-8?B?cTBUYkI3bzBYVFJseDNaL1lnRjF5Mm8xTkJDUGRpai9HK2tJZE1tRkhNOE1x?=
 =?utf-8?B?NTdTZWR3NFR0Q0dUNjNadC8wWGdvS1ppL1FKbkJua1N3am5RMUZyanBUR2FZ?=
 =?utf-8?B?dVlyc0FTTEZMMUhiZ3lpb2ZwL20zVXgyWjdCU2tNaWZ1NG4zcGpZQlRUaERh?=
 =?utf-8?B?WVg3Y0JJSWpMUXVQOC9NTEpGbmR4TmMxdXk5MFQ3Wk1kNE03VUJlRTFudDlh?=
 =?utf-8?B?MURqUDNqdmdIR3U0NUJyR0FNcHNKWm00UmNETnIzQ3lCWk1oaGNmSDM2R3dH?=
 =?utf-8?B?T3IyTU1lMEhTVGJna1JIUlppMWNxNFphbGtDZlcwVWhpSkwvK0d0VTlOenpx?=
 =?utf-8?B?ek5jREpFQ01adCszRUxWTnhGT2xZQm9jMW9SWFNOQXBQTWkxKzBDK20yM2Z0?=
 =?utf-8?B?WmMvV1NydFdYN2x6OUQ4VEg1ZmxyakU2ZUQrWGtMMXJPZkxvZWViemFLQzYv?=
 =?utf-8?B?a3NvcmEySmlZbFdOcERpSVVXZzVYRWFLQ0pKZTZ0MEFEOGFncUlUTlo0bHp1?=
 =?utf-8?B?N05NRFMvTmttS2JFT09pWnVGWno5a0QxOUZiSVBPdStXQmpIU1Yrd2JhSDFZ?=
 =?utf-8?B?ckNFLzRkQWhacTB2UCtuWmliNnduUHRNZGdLcS90dUdvUjB6UnBYT21yV2Zs?=
 =?utf-8?B?Z2Q1TjN3KzMwM2J2YXM2aXp4dTJhY1g3aVA4YnlmWHZNT0hjQTg5SDJnK25P?=
 =?utf-8?B?NytQTndBUzZJZndsTDI1b3lEUG44dC9GVFpVM2QxNkJhSUtmakFiL09mUGNv?=
 =?utf-8?B?aS9rTk0xWks2OHVxUkV2b0FwaXQ1aUE5bERqamlvOVkzL1ByZDEvcDk2ZEdn?=
 =?utf-8?B?aFRRTksrb042NUNWUE9zbnYwM2ZLT01wbDE4N0cvU1VpZmxFcjZnQXQyYlA4?=
 =?utf-8?B?TENSR3IxOFlUQjdJWWk4bUtiWmU2M2Z4RVVwNDk2VEJNMnc0ejRYZmdqSTlF?=
 =?utf-8?B?eHMyT2luQkxKK2NOTURYNjdqWHZTRkl0MG93Ky9JVFFmMzU4b2RWK0FzMnpy?=
 =?utf-8?B?VDkvaktLb3Z3THNNWHFLYVFjRjVna3ZpRmJpcjRmSzU2RVU0Qk1Xa0tEMG1O?=
 =?utf-8?B?SFF3L25ibDBjL05OS2g1V05FdWlZbGQyRTJWY21LVDUwbnlOaitMLzcxcklo?=
 =?utf-8?B?N0pEa2R2eWw1endoOW1KTnJpN05vam4wb3NHYU5yajVYbWZkNkNNUGpoV3hy?=
 =?utf-8?B?SVE2Y3ZOeE1DM0FFck9LWDFrUXFZYlEzZkVMZ3ovUVp5UFFBOG1tc2pyQVRr?=
 =?utf-8?B?MlJQa05kc0VXZS9FSmV1VHptVnB4cVhQaXZMRmY4ZFRUUHBYN25YVG1RUk1W?=
 =?utf-8?B?aStFL3lGRUQvVU0wQ205NCtncjlja1ZITkttaXQ1WVFCaGc4VWFtT2VYZGFY?=
 =?utf-8?B?ZUEyNmQvbUdEZXpzbGF6NVVZRFdaeW12aDdjbStMd3lPZGNxSE9UMG1nVTNo?=
 =?utf-8?B?WnFsSzk0T285MXdSNDFaL0prVTBzamQ5MHRrd2piTVdzaFQwa3g2dWZXeXo4?=
 =?utf-8?B?YllkNm5JRHQ1OWpXUTdqQ1VmWjhhNUdnNlhWa2UxRnhxR3hvSzBQTkc4ZUpx?=
 =?utf-8?B?cDB0ejNnTVNoUnR1emZHcGpzY25heHhDNndjaEprYXJDMVpGMW1GR0ltK0o0?=
 =?utf-8?Q?mAj7MaUQZOkv8nsJxxtKzXnqr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O4r82T7AES/cHsW4IGkJ2H64GVSca/Lqy4Uip6Ex9BJtaU/bYElM4gGP7sAu40EzvFsN5Nr1H2OJYFNoM9Od/b4Cwg0A2SuIn0WxZB4z7qHtReMGw30aA6TC5TK+a4yiMzTky1cZnI201g1G0Xvy6IgrUivjOvFf9gN36s7LA6LbHjxfjniY/bNsuVW/8unn8CXADeEdYsTL72N6c2MD4BqYte8yYbQVPII60ighj3UouOMZ+z5/0bv+K3i253uWeVD5Z9kNRfRsyYjCvsnF7rKZ2X6G4Bo/Xo4tTiimWNOcr2vCI/NKFPcKVXc9eb+MkvZZeD4D0X9mnamvCjpz3O7LrAywt+98AdE23qDm70eiUHGv7Pf0B2qkqK2WwUmzGEqitX0ROeOxtYxsV8/pRDwVGrRtPYEgL1vqawVXskYYPts3Nz345TsXDQZHZmwV4OzqppTWbeHv6bm/MRKskNOp8GADXvQx4veV9rdZL1mqSnumgWi2ekflnN92bKYx/77iX5CbwEp9hcBSq/l4jGOwGphD1cPtaAs9VMZJ/roHqqPB12DjQppHUybquWg/5AZlyPNdKZTEAzRaGHrNvy/X0Drtbx/JSsRIcQre6fXgU3BGswVL3gy0Mq+vGQXs
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50278a7-968d-41d9-9735-08dcf8b7077a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:46:56.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3Cl2zKOQHUBWJSIBjJ8DipXK+rL3iaUhUl9mJ8DqJJxuXFrOnJncP0hD5vSm9gzOZU54h9eRcl0w+uOps0wYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5689
X-Proofpoint-GUID: MMhs7HfagaOc-Mg5JzPcwfWGI95_83p3
X-Proofpoint-ORIG-GUID: MMhs7HfagaOc-Mg5JzPcwfWGI95_83p3
X-Sony-Outbound-GUID: MMhs7HfagaOc-Mg5JzPcwfWGI95_83p3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_06,2024-10-30_01,2024-09-30_01

TmFtamFlIEplb24gKDEpOg0KICBleGZhdDogZml4IHVuaW5pdC12YWx1ZSBpbiBfX2V4ZmF0X2dl
dF9kZW50cnlfc2V0DQoNCll1ZXpoYW5nIE1vICgxKToNCiAgZXhmYXQ6IGZpeCBvdXQtb2YtYm91
bmRzIGFjY2VzcyBvZiBkaXJlY3RvcnkgZW50cmllcw0KDQogZnMvZXhmYXQvbmFtZWkuYyB8IDIx
ICsrKysrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNDMuMA0KDQo=

