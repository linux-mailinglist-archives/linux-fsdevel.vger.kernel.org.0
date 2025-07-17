Return-Path: <linux-fsdevel+bounces-55283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66252B093E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9985A7A90E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922ED2FE391;
	Thu, 17 Jul 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V6nEZXT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A51DA10B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776726; cv=fail; b=JkZPGelQhSDLxjxDTbdi5EQTZh117K/zar0lT23X5MpRaNPJOF+bb0Rjw5todhQwl5PdJuft7cuapbJdRO4dq2DTHPxuGRi5l1wplSD0vo9AXFsVOco4nurMI2xPcWsQ5fDG7kNqX1WnVHeMIwDx83zpOuzva0Nmhuzi8JVMyCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776726; c=relaxed/simple;
	bh=dTgkQdxhkCfdN4b/SLuvSS27r2E9PDDGCKUQm3wGkP4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SxMGDyqE+PsOZxvBMzn1l8B4DGFVXtXWAfZJbtH7cdp0d5VtsRUgs4SU9lJtUhT2mv5pIqX9wZrPlxrt/wdqvw00XIkXxsE2jWfgJUyvQJcVJ/4RyG4le4WTvNc+mZU9B2TACW/tkXETx1siOJZcDQ41vaCk9rFw5ENPjB3XvUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V6nEZXT+; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCv6DY030557
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 18:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rNq2qNhdnSSb7DVMGSAswUolNyKniC9omg8ySN71yrw=; b=V6nEZXT+
	E3UZJHo3R2S5ZNUAJq6iGf5EcTI7JgIsA3B9cZiTb2He74NRXqN+kx+LQyJZ0GdS
	PCzmOTbtB9OukSpl5DRaog7npCwBtF5lLzozdSIEfv1mDG8DsqOLHdtl222frmvA
	RJe80iluYmaP9eeu77Vy71PzUZjtK1V/EZSsT0ewU1IxINspEyiUuhWzPrqWdeLt
	CH+d7YXTPbvXK92ivSpo3XGUAW5NYHVqu6DbBdBqGAmtjQEAZxUW1tVyW7aoNlKl
	KHmO21gURyx45RHggJXeqYRuxQWFeWGdnVh/UaRVxS6KyKl2hxp7ApXbWdfQ6lmm
	yECyLIn2YqAk5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dcx9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 18:25:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56HILMn9028010
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 18:25:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dcx9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 18:25:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8Tntjqv681zEJtAd/eW2WzQXR8mAfpLirGoTEH8drEO9eAYCYcDAWOKd45MGF5s10KF+nkN5CYMZWpGPVNhGS7fJVaJBMMEklyqS+sA3HRnVbmqPFmsRqFgZEDTrOg8f5Eq9/Den+46KAG1DxvP9DccAs/tv12uLUM177U/NRsD0uN6hyMj1b+c4+Ypw8PwLPe7T6APZya+Kls0V1+0KQAJeNpuaYk7nInjDldfUhkPVTImtOvjhMt3LaYOnroDyNX4iMcSKbzDE2F9tDBuUHtz+VW4qLt9EpyRRXL5UXLU/IdBQrfKGN00Dr2JXGROCtqCeU9p5ybHxW4yv9FtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am0tcq2f5uqdyByeNEHn/9/6mqvSKXXTADfsoHnPTxc=;
 b=bxfmN1yhrf3PTme6FZYUhEigDrII1zzkQC3Mb//oGyH3MYGTsIJjy20qdhgzdblfGZ04hv9alsWP89E/6tCqU6G6U+ktB1mY2rVLsX+8+AYx0D5LPaTMaTjaY8Yipc77mucjKih7qIjAaiwmRma56wnRmSf314950URLMV7SYp4W7RjPmzDrQH8bQaI/g4Hjp+EyqXhk5oDLEzWG6b/EcZcPJoucVI+QDIOjW748hnTt1YxYKymImStNo7FkOZqUcgBIbHbiMGqqVEFkcsgCtSmPVbzA7ZjUX+7Qqm6sZQWjDERWyI1IYF2tsUF0RZv90AmyWguLzptCJ2bbpJ3Apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6402.namprd15.prod.outlook.com (2603:10b6:a03:573::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:25:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Thu, 17 Jul 2025
 18:25:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "willy@infradead.org" <willy@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index: AQHb9zAatrmfN6NVjEaOSpYqS5NL2bQ2oeyA
Date: Thu, 17 Jul 2025 18:25:20 +0000
Message-ID: <103786663f24908996bee17921c3b133dafbfe42.camel@ibm.com>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
	 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
	 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
	 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
	 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
	 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
	 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
In-Reply-To: <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6402:EE_
x-ms-office365-filtering-correlation-id: 502a722d-d80c-4230-c1e6-08ddc55f498f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Unlha1oxNWorSjIzTXB5dWt3aGFLRWp3emlYU2dockpmeG9mSEc3bDk3cG02?=
 =?utf-8?B?NnFFWnQ2Y1ZSMGRtUlRIVUN4Y2lubzBjNnZWYW8xWjh4RkhJOEpMY2FCdU95?=
 =?utf-8?B?L2M4TWVSbVoveG50UllBeTVTb1pIclArMUFHUmR6aEJmK21yN0t0YnZoKytR?=
 =?utf-8?B?aXM5UjhDV0lPU1B4cWY5QlZFeUZleExzUlZIcW5hMDE4eFgya0RuSThxNngv?=
 =?utf-8?B?YjBpdG9BbFlHc1RtSEUxdCtkZUFaTnFrVUFLdVFCVmlQRWFHOSs1b1hxUWpM?=
 =?utf-8?B?Q0FZYURrVGdCeUEzcGd0UjJFVkJtVjRvWHZ5bU1kdDBiOEdnRnpCWnRnWUFX?=
 =?utf-8?B?NHFDMjR2TnQ1RmkzRGVyNndQT3RWOUxJYy9oejVwa3FCdmR5b1h5SUF5UXo0?=
 =?utf-8?B?bStKZFNLYTB3NTk0cDJrd0V0TFB5ZWs2U0N2U2VHUWZYMkhETTY4S1NrNkxa?=
 =?utf-8?B?eDdEUWhRa0t0TVRnY2NSbTNZNjRCMjcvcWJoUk5GTWxXR0RLQVVqLzBMRmdz?=
 =?utf-8?B?Q1VKdkpmQTVxZHZYaTJEL1N4ZERLMWZlVlJ2bVZhMWkvK2FHbGhzVTB3VThv?=
 =?utf-8?B?ejJ3Q2RhVkRFSFVUQ2tRTWljRUhPZFR4aXF4NzJxUDAzd1R6U01pQVN4TmFI?=
 =?utf-8?B?RmN2QnZHRjlxKzNaZ3NwaDY0R3BNUXlIUlFqV2g5b1pQZm84RlB2Y0NHWEdE?=
 =?utf-8?B?ejAvUWdta1FYbE1tRDlZOFJOem1YVUJpWW1LMjlYNnpaT0pZT2tleWVYMVJ2?=
 =?utf-8?B?eER2QS9uYWU1SDhQdGpyWHZzM2craHpyTGI5OHRNVW9BbXV2NXMzejI4SjZx?=
 =?utf-8?B?VmhqcE1JRHlnQUJaMnNGa2szUWQrZ3RiendZU2FKMmNwZlRUempVSDVYMHFl?=
 =?utf-8?B?YWdOVy9YNStFTWJkdHdVODd6S1lmVE03a1JBUTlKUTFvMlkrUHVXWWxmM1Ax?=
 =?utf-8?B?ak1yNGEvREdxQ25SSFlnNVltaEdNN0pSS3BBdHZNUVYyRldCZzM3MkxFMDZH?=
 =?utf-8?B?anU3NEJNWXdQMVppMDliVk1jWm5mbzFmR3c0NW8vUW9IUjhVMDNtYmNJYmR3?=
 =?utf-8?B?ZGJqb3JZVW5UZXJ0eVFseTNHbUtjWng5VVg3QU1OMVNTSElxYXFKQlV0RTFK?=
 =?utf-8?B?dHAvZldDS2oranpWdVA5WVRqWDVsdTd1NDVxT0ZkRkY1UGI5djdnN3N3aWZk?=
 =?utf-8?B?VG9OMnNXRW1INzlHNTFpdWJvNDZ5NEc0alh0VmZmaC9ISnZScXZNS2xYOWho?=
 =?utf-8?B?NURYYitXbXBoM2pna3B3c3RaZENSWGlyVUNLZEpSbVcwWmM5alJCdjB3d2Jm?=
 =?utf-8?B?RWpaa3Q1TS94dTdXaXdaYitKMXlhUm1CVWhLcEVkWG1zdkZYaUlYQmJCejJm?=
 =?utf-8?B?Q25hRnE5anJ1V1l5S1VGRDJLQ1R2OWJrYmNlRlI1bDNTTjN4Vjg3YU9Lcng5?=
 =?utf-8?B?M29xd3R2SlRaSUoxeGl6VlJGYkFlVCtpT1RrUk1BWGl1QjRTaUdhaGtxbG1Z?=
 =?utf-8?B?NXRPS3BmdmJnYjlLY2N4M2J3aEtHR05KOHo4bmlmKzNaSEppT3FLNUtkdEcw?=
 =?utf-8?B?L3plVFIveklIb2NSaG4vM0o4elQzckd3WVBob2ZKWFFZdjR6SmtJaWlXRUFq?=
 =?utf-8?B?Ni9oN3pLTEtwVWxNdFA3cStrZDhpbXlmVG1BT2p4NnJrbkYrQzBmVFZsaFpP?=
 =?utf-8?B?cENJdVlTN2ZmNXh0a3JKWnVTeXFXTzFNQVVQQ2JmVkZudmJ4cUlSUGlQSjBs?=
 =?utf-8?B?dHVhYm9kZFR0NTF5ZXJrRVhHcmRLaXI5VDVNSnE2MnZUZ2xtYkJHR0dZNWNT?=
 =?utf-8?B?RTlKbU1NMXRpT2hKN2Y2SVpYKytHbmR1Q1FNdm9sMi9CZUdsSmpScC9NRnBv?=
 =?utf-8?B?M0I0ME9ONVdEMTYyWEZGbytWWFJHbVZPMkZma1NDSzRrVWMyeENtMkQraGla?=
 =?utf-8?Q?bgD+oXbPChQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2NlOUU3MkdNbE1iVC80UjBsU21oYVRBc25QSTNDZDNnYTVVcUhZMmtjdTQ1?=
 =?utf-8?B?bmx0SlBDUVFkRTNaRVp3K2poT0F1SnlOcVQ4c0tWVTFGZ0NSZFJiMHExeWVS?=
 =?utf-8?B?K2t1T052RTBSODdOVU1uMWhMT1ZQbUVDVHNCNjJyT3E1UzU1T3JnRDJjK0V2?=
 =?utf-8?B?UEJXWjIvTmhDZ0pIZmlEdmpRQnlyRFQ1enZUNHVkeUFRVjVXS3kzOXJuZ2dU?=
 =?utf-8?B?cU90b3RnZkxNOTE3czNvWktISVV0UTZ0QW9aUU8vekRwN1VSanh5cUF5WTY3?=
 =?utf-8?B?Zjcyc1UyczVzQTBQUE9BRFpQUzNNZ3BLUnArVy8vZVZueXVoWWRHNTdWR2Zs?=
 =?utf-8?B?NlZHU2lkUURoMjQzdWhVVGVubmY3d241dENmWW5kSlk0a1dJZjlXU0txeStZ?=
 =?utf-8?B?Qk96dDlBZnhPWEtyaFRiRm9yQU9mRzFIWk9TbmxlT3NPYlNuWkt0Qlh6WmNB?=
 =?utf-8?B?TkNyOUNLMW9SVytKUEJRenhZcGpDQ2ZhbmJQM3JaT29BenVNVTdDTjVSSGdz?=
 =?utf-8?B?bGQ4OWwxWnBqaGU1MlNibWJpUkZzR0lPQmpVcU40cFNLYnN5TWJtYllqa3VF?=
 =?utf-8?B?MkRiS3p0VnFKTXJzeTgxM25vNXlERlJvQ3pxRXNlTythc3h0K2VIdTdZZ29L?=
 =?utf-8?B?a0hnQ2NQd1gwbFZ6WjlxRzJLN3VmSzJQK3JRSitjRit0b3A0RUFSOHRQYmYz?=
 =?utf-8?B?dGpDbnNLNmVwK0ZBMGNNc0RtbktlVWdEWDJ0azVneE1PSUpWVzZaeFg4OE4r?=
 =?utf-8?B?c216S053Q2w5ZFgzeVlTbmpSdGJXZDZ1YUVPcVZVbm02bERhNlJ3OWxFY2t6?=
 =?utf-8?B?b05qQ0ZRSVRhR29RZ2dyamJXN2hiSUgwVzV0citZWUM3RlZjTUlJVWxxdGZK?=
 =?utf-8?B?MkRwd2h3ZUwvMms2UEh5dkR5eitvUHJKT1JjL1NCMHZORGNrYnYxSHBQVWpF?=
 =?utf-8?B?eHBMTFgvVjI0ZTFnRExNaEQ2L1JNNnkvNTgzK2lFcjRQQ21zM3JOcmRHWWR0?=
 =?utf-8?B?NnFUOFJDWjV4YStzcUQzMHZneEV2WlpERkZadUg2dUhuU0dkalEwb1QvZU1l?=
 =?utf-8?B?NlNHZUFVM2x1MjBQQkVyYjVQREFSVTBrOXpTckF6andJblhPN0k1RnJpalNi?=
 =?utf-8?B?M01ES1RmaE95eUZiSUhacWhyRS9xMXEvOG9LRjM3TWp4d29BZUFBUHJ2UFU4?=
 =?utf-8?B?dnVBcGxsOEV5TTBsM1E5d051WTdscTZvK3d4ZjNWdEhKWDUvRWZWZ2pjWXJO?=
 =?utf-8?B?UWNOb01USjMxSmRQWkFjSHBuNHVHV3A3bEFXMnJML01wV1RMNkRrYVdPdUdO?=
 =?utf-8?B?cUJ3RjRGSDY4QzJYc00rZnpia3hpdnZOeFMzQW1keFRScGR0TkVEOFZyN2Na?=
 =?utf-8?B?K3hwUExHQ3E0T0ZDY3czOGtRTndTNmRxVjBzaWxPV0NRQi82ckNERVNaeHBK?=
 =?utf-8?B?emRMdDUvTk5yNEQ5Z2podTUvV1JRZG5HSTQrODRjb05Nd3lhelBaTjVMNlVH?=
 =?utf-8?B?VW82Sk1SN1N1cDdwd2tmK242RzBYcWl5YlFsWmdrWmdZblVCUUh1aG40K1BQ?=
 =?utf-8?B?dFJJNUozdlMyRFhZZk5ncjJWUk43RnZ4VVFLQkJGTlZ3b3Z6VjJ0VVk1VWJp?=
 =?utf-8?B?OXpEeWxUNmROQThYWFA1STNLbjhYMDlOeFhxYjlFK3lVZWpjUmtmMTJnNHlQ?=
 =?utf-8?B?MnM0NFRGQ0ZaTmpXVnUyeEMvczM5dmdsWGF1RXhiTWtUaDRXUjR4NGtITXNw?=
 =?utf-8?B?bzA4a0tWOXpTZHpqWHI5bWt4Y3dKS0F6Tms1VEJaU28zd3RSQVpaejZYbit3?=
 =?utf-8?B?TzN6VTdWdHRDc0N3UGpPOSthMkNJZXljcSs4dmZScXp6WG1VMzZhN1c5U3Av?=
 =?utf-8?B?Q2tUYi85aW5OUnB5bW5EMzE2N0NHQzBXZERGNkZad1NDaVQycVVPQ2tJWVpa?=
 =?utf-8?B?eW95eXZWWWp2bVZiS0FON0w4VEczdlpINVdVTmpiamgrNmpDVSs1R1UzSlBS?=
 =?utf-8?B?TFdaOVExSHhrSU5sMkNvd2p0clFyWUxsa2dWQlo2NGV2eXdlYjIzRWpyQWlz?=
 =?utf-8?B?ZjgxbitNKzJSUUZzNTJtbVIxS2hOWVpqT3phYVFLVUswVW1HVFhYemczUDBo?=
 =?utf-8?B?dE96TjdIYVRIT2FLa0NQeFJlTHRoU2FGVXlzUm1mWEorUHJtTHJNNSs5eC9j?=
 =?utf-8?Q?pT8sj6mrN5EI76MaB/ZCeB4=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502a722d-d80c-4230-c1e6-08ddc55f498f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 18:25:20.3132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oowDaBoVMUp7S0pxYGZVS2jZH9bqmHqQZ8dPmoXf94O9pgZgPltIMUtVQSg4VVegoGdmfXqvVuJoNDpL8xUXqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6402
X-Proofpoint-ORIG-GUID: 2slKK_L5cpndPV3AadsYOxKWwM44nczp
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68794013 cx=c_pps p=wCmvBT1CAAAA:8 a=muCzuJRA6IS5PBT2mfi56Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=-bRg722BXVkD9m8LJCoA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: 2slKK_L5cpndPV3AadsYOxKWwM44nczp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2MiBTYWx0ZWRfX53kDnddhNG9Z IK8na1G+5yJFTzyQ4T/qSpaj6gEErxUmcbIAL7uqesrZugjvscAUsBhHnNR/WtneDzOxcdoYswV BVuwcZ9LZMQVMti3GW7ACN4bjTjctK6wTg++AYUMu/WHEGA89rmoRG2+PduzEl/JmlD8VYGKMjG
 OxPNnO4xlT9hkf+zzXcc6HnVOkYMpOXksVok6KmwzFGzQEj8dsJsgLc0BDRAzdPsauaCNsgMsMQ 4+MMh8YXsQu11ZgSv74AGP4tdveTEze9KSWwhHOLJ5q11zGqyz3Zlzjez32y63EW7A4eaa5qUzm lRVW4y1OHshAPRBNztLZMhNh5soHEoy+Zu8Yv4zNi4xhjyjL/aQItBWxDn5lTMfw3buJmy9Iyi5
 kx9qNY801SOBuKy1oUL3p/LoXB/KFG3XSmerC+vyaqT8OjieqgcSBTawnTrc57Td4iCkFcWm
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA93839C1CA8D4CAB4305F891EE1484@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507170162

On Fri, 2025-07-18 at 00:32 +0900, Tetsuo Handa wrote:
> Since syzkaller can mount crafted filesystem images with inode->i_ino =3D=
=3D 0
> (which is not listed as "Some special File ID numbers" in fs/hfs/hfs.h ),
> replace BUG() with pr_err().
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfs/inode.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..9bbf2883bb8f 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,8 @@ static bool hfs_release_folio(struct folio *folio, gfp_=
t mask)
>  		tree =3D HFS_SB(sb)->cat_tree;
>  		break;
>  	default:
> -		BUG();
> +		pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n=
",
> +		       inode->i_ino);
>  		return false;
>  	}
> =20
> @@ -305,7 +306,7 @@ static int hfs_test_inode(struct inode *inode, void *=
data)
>  	case HFS_CDR_FIL:
>  		return inode->i_ino =3D=3D be32_to_cpu(rec->file.FlNum);
>  	default:
> -		BUG();
> +		pr_err("detected unknown type %u, running fsck.hfs is recommended.\n",=
 rec->type);
>  		return 1;
>  	}
>  }
> @@ -441,7 +442,8 @@ int hfs_write_inode(struct inode *inode, struct write=
back_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
> +			pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\=
n",
> +			       inode->i_ino);
>  			return -EIO;
>  		}
>  	}

Looks good!

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

