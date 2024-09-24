Return-Path: <linux-fsdevel+bounces-29974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73418984551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957A51C21A03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EC1A4F31;
	Tue, 24 Sep 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M3yDaWks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020101.outbound.protection.outlook.com [52.101.128.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A741A3AB7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179199; cv=fail; b=UkjH8G+CH1iMOkCBxReL90EpeBgt2+EeBiUtBmuv2NU3jyQlcM+j8kKKO8xSalBPRKQw0z7OyurmdKOFCrSNQC413igPGw/Ek7rvYtpw1X3W3bFT6zz9EI11Ct3wvBKJ4cFIlEndRyzweWeHTJcO0YoIKHzWJj1Yn3wWw2nX4no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179199; c=relaxed/simple;
	bh=NGLruVwlNADIT6GfHorzU43XCMSm4agMG2WUL89/514=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BUFDo9TEA9eGYAaYfIVoQG1js0d21JCzLVMSDT6etmd225My0iPf4uHKTTgNH1spqIu6Xzq7xpZ6GkRJ+VslKyjk7FOTNoKd2x7eaRwMSSLNjItEdYuTa1ddaVM5BZij8UY5p6hlt4lpRwICKdev6ascgY5pq7+vTK5mp/vrYI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=M3yDaWks; arc=fail smtp.client-ip=52.101.128.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX1ikZhUT4xJMcyfMNPTdNtCBABiuyb+Qww1hDUxs5mUSswruC+IqTlR5eAVZ2knlc8xF1HKCjB+orxhUMiHMPoDn7C8J3Kbz8TzcLBUTnJs58t7zutegiAC280gHI/WOirQmHa4lnKF08TKd56/8+zcI3uWZQlEjDR8FWILzxOR1RzlPy8+g+F6oqdtWVfHIkZLzHR61a1yi/p9ANXEJg0EIC1rD6Jyx/d0j7+NkcEMFc0Rp+78jyaT25pdWwtbu09FpkoIGiCc4FLIMLRi7OUeGt1lyQ0u501CRb2G8xR0T6AShmgwCaT1yB4F2zCuTGzQJTaF0j9Bzaz8bqPVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7lHAXlOnOb4FwybZoTX3lRC0zfGghR8Kpz9eRo00Ak=;
 b=F03rGG3NUDb+VHvg5GKXn448LjyfGcw6loPo2bC1jrG8qJLUX9S8rqq1wyvvIJLa4obbrKtupHQgakuqg8M6mTSXh/0yg1wcAWsxNZ1BCsSVkNmaZ+oO0zAzUmPqVs0jXLM7PVLiXxaT2hNciPHtdUHSrdqOlpFiN2AmQQNnUXvg26S4hbPkEGtoy4VQ3psmSQt+oRcUh3qHy3AQviUQmAdrQt2X800zuFSR2tSd0J4ZIXpK4W1oD4RKWcAsTZfpVSUTItW14xidRcBLWd4L0wiK6sKiD6XU4NHiD56b+FeFwbTWBREv5WU/QfPCgOWcQCRrf/CULS9fPmHFVjqhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7lHAXlOnOb4FwybZoTX3lRC0zfGghR8Kpz9eRo00Ak=;
 b=M3yDaWksipXWWRAtj+Ra44euS05slbCIuSPoQ6q7S3rNuj7V/9CFWfOUF4WSJET9uFeEqxIfBU5Slb/zKueDU/xzsUIQJjrQy/85Mj8xhRAGh7vg07qe5Wxs/vXogzwBP1NV2nlZhPskRvvUfMNHo0YE4LqdSfGr4aAo0Y8BANg=
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::8) by
 SEYP153MB0989.APCP153.PROD.OUTLOOK.COM (2603:1096:101:1d9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.3; Tue, 24 Sep 2024 11:59:53 +0000
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35]) by SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35%6]) with mapi id 15.20.8026.000; Tue, 24 Sep 2024
 11:59:53 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jack@suse.cz" <jack@suse.cz>
Subject: RE: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Topic: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Index: AdsMF7H2pA+A3TMFT7qIn4M6deqPigBk8OQAACP7Z1AACRNwgAABPHQw
Date: Tue, 24 Sep 2024 11:59:52 +0000
Message-ID:
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
References:
 <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=aa0c8b90-cd33-414d-9979-70bfe5f4b136;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-24T09:32:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0718:EE_|SEYP153MB0989:EE_
x-ms-office365-filtering-correlation-id: 4921530e-90d8-4dae-f3d3-08dcdc90663f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXd3b2dUaUh6MmZJV1JxMEZnVTgvcS9jVG9VMlFQbjljc01XUlc0ZXRGMEtj?=
 =?utf-8?B?b3BEcjEzaFdCNFM1bC9reHJGYVp6OEZrclo4R2h3ZkI2R2lDSFpxRml0MzFw?=
 =?utf-8?B?djFMM3doUWQ4dUZld095Q1IrcjhZZUlzNmdVaXpwWjZsY1VVV1B1c0lPT1JK?=
 =?utf-8?B?bmV4bjVrRi9MeUlmMm1aMm1mV1FvV25ueHpwemx2VEVma29aLzM2Yk16UTQz?=
 =?utf-8?B?eXJxUFhQeG9mN1prL3NsdEdmWmpoSFY2OWxFS2oydWdjMG9ZV2hnd1hQK1hB?=
 =?utf-8?B?VExjY3BFSVQ4bndZU2JIVHRYRHlPTkpLN25FdTQwQVYzZlAyS0Rkc2d2Z3Fi?=
 =?utf-8?B?NFNqZ0lhR0F5dGNNamRKb2ZZZ0RzRTgvOVp2RVA1NG9oams0cGo5OEwzdzlZ?=
 =?utf-8?B?ZmVBc0NFUkkxM2pabDVZSktFUjZYMWdENTlNNEkxV3JQZzZLL2UxbVNXWVIy?=
 =?utf-8?B?b1dnT2NLcGw4d3hpVmVrVkExdW1tbmNBWnVqN0pYSW1Jb0RhN083dWxEa3d0?=
 =?utf-8?B?dnY1ck1BbHYzSUtVRDZjd1l1ZWM3VjRUUDBaU3A1MDM0L1BaUk9TY09DUk53?=
 =?utf-8?B?TUlMamVmSXRYWmluZTVjNy9NeUswdGFtYVh0Y0x4UlFDMnhKMy9meTNDUzlB?=
 =?utf-8?B?SGx0ZktBVjV0M3dGQmtjQklyeFhFT2NBaU9mcVZtTVU0Wi82T2cvMXRIc1Av?=
 =?utf-8?B?NlR3UlpXcGY5Nld0SGtLQ1gvN1VCY1ZDRWsreHN0dUlZSTRNdTVYNURUMjh4?=
 =?utf-8?B?YTVzd1ZzbDZjMy8wa0cwQkN4Rnc3QXpRMytGU2NMN3A2N25YZERnbENsK3dX?=
 =?utf-8?B?eGUwUkxMdCtRRGxFRjR4b09SeUhqVlY5SU5FUVhsRERZOERIWSs5UU1pYlNu?=
 =?utf-8?B?d2R6YUtqSDVRNGlaMFJMVjVSaTJvVS80Nk45Vll6MXVjeGllTzlvam1xVEhS?=
 =?utf-8?B?eDNFcWFRd3EzemlBU1FRNkwwOC9uWFlydEdoRlE0VEEvQ2M0MDBQUlU1bEdY?=
 =?utf-8?B?UzRwTlZLRmwzSURPcHd3VVpUcXlNK05YbkpTelZXYU82Y0tCWVhQYWhRM2kr?=
 =?utf-8?B?eVFaTTliWVRObURJKzBubzY2d1VVZGk3MVlEN1NVRUFmNllLblptcGlZYmZo?=
 =?utf-8?B?ZXg5MkZlSmFjT0xWYU45R01GQS9JR0tJcEhhdSs2aVJCeUw2OUlpM09kZ0xI?=
 =?utf-8?B?ZjVNY2lJS0x2VU9STkZwQTI2NXI1M3pCQ2UrejZPN1VsWXhOcHVUSzJLNElu?=
 =?utf-8?B?K3creWViLzZFMzVNZkRRUTd6d1ZZaHdnTkZwZjVJSC9mNzRsOWxVNm4wcG1i?=
 =?utf-8?B?emZiSk9KRVBtTFRtcTRXQnZyajZCU1EwK2Q1TXZRVkZsZXhzdWpWYmxUbks2?=
 =?utf-8?B?SXBmb2tCdEFLbzNJOVMzRmcwRGxCVWRrUDBrUmJuVk4xNzB5ZVd0dG9jbHJF?=
 =?utf-8?B?YmRpY0gyaWlVOVJGSDBXL1VJRk1aSGpOZzBqekFkTTBKRklkRVBvMTJ4NWV5?=
 =?utf-8?B?VlF4dVFYaFdJV0xvMk9HMXJQdFBpMGF5eE1WUjN0TnFvc1lMUWxuVUlOVmhk?=
 =?utf-8?B?dWRsU0dQQzZMajM3d1ViZTlwN0FFQzNFZjJaaFZ6Uy9CR1Z0S01ZS0ZJNnk2?=
 =?utf-8?B?alBmL2E3UHlCQ1RMRFFaUkxOQjBJNCtCQVdYYUZhUGFkZWdKSUpDdHVJdHVo?=
 =?utf-8?B?NUVNRVBwV1A4YkVqamtTdWlxekQyY25PT25VK2E0Y1BZM2s3dERyVm5CYVl4?=
 =?utf-8?B?Ky9Fbnl5YVBGNUtTaEs5Q0ZnVnVHYlczWjBib0JTZmJjeGtsSzd2VnlQbUFm?=
 =?utf-8?B?RUd6OU84Q0dFOHQyNEFQQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0718.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0txZng3bFZobXdKL2RwVEV5ak5UTTR5ZzUyQW0yYmZWc3JTLy8zZkhUdGRY?=
 =?utf-8?B?cXpqakd5VDl0MHdTRXEydURBTU52a29hTWhUVU5XNmpFU2RlSXRVdW5tZVIx?=
 =?utf-8?B?VXJhc0h4dUlyVE1vVFh6R01SSzRNaFA5WHRwejNKYjl3UXY2cVBJeENCMzZs?=
 =?utf-8?B?N1V4MXBzcjNFUmxtNkYrVnBrU2pBRHNTNWJvOElORnd6UUtBWnVXaDUwYnI2?=
 =?utf-8?B?bmxyL0dCU056Ry9GcWxCcGlzREhBdDQ1VEorU0d3eXdPOGZaYWxhZVpwRm15?=
 =?utf-8?B?N25meFhibmNWWk14eUR5NXFtdEFVWWNhdTRyRW1la2ZmM3A0ZUlWaWorckY4?=
 =?utf-8?B?RmVUMTEwSVNtRXV4enpyNXRXaXpSZUdGeVNlMU1QQnRnRm9WKzFKVDhsaDl6?=
 =?utf-8?B?MTlDakFtODRmWWZQelp4VlZRZ3cwZE5CTUJPbGVEMEdQK3VHTVRVQkFIUm1Y?=
 =?utf-8?B?MXNCanRQT2hyZVhQTHhPcDFPcDVyTXlQNmtOdThoQXlMV0hUVDRZeHJnTXVo?=
 =?utf-8?B?QlVhUURDdVdxaGJycXJvc09mTDY5dldGLzNvRm5QWEhzRjFsRFFCZnNYYnlZ?=
 =?utf-8?B?K1BYSmZFZEFlQS9uM1FvOUNPcGtjdzY3MnZxUytoclpCYUtuTjgybXpqNmxn?=
 =?utf-8?B?UUtXVEtyMUtZdlBlMUFkanhZL0dOb2MwVVJCcEFTdHZwajVEQzZHZXhBbzhQ?=
 =?utf-8?B?VWtkbjFiSXN2QkNIMU02UmY3bzAxckFKWDF2SGY4Q2FtOU84V1d3SzRWay82?=
 =?utf-8?B?K1JDQUxycXB1NXo2eUd4ZEZTbmNEQXYvWkxrRW9TWTNjc3lONE1ybEk1cFUr?=
 =?utf-8?B?bi9qcFNSeXA0elZDcTBwVyt2SGI5SEU1eGQ5QTh5MUFhSUJraklWbGo3YkJN?=
 =?utf-8?B?ZnJXSWFVNEdjVXdES1NIVCtJL0RBOU5mcmo1aGNlZTkyMlJaVjFzdDRhVCtG?=
 =?utf-8?B?UU9vOE05OStZM1VwdS9SenQ1TVlFNzJjT1QvUXZmZmpuUW9sUkhZUkwwZFYv?=
 =?utf-8?B?M1ZHRkVhUmF5UnJOS2x6YWdyelNkb0Npd3E1SFRpNFNCUWQ3Vm83MVJwS1BK?=
 =?utf-8?B?SWs4OGlWeXhLcklON3Y2dlN6ZkE2aElsN28xYnVkWi9VZG1rUFYyZWZBMEdr?=
 =?utf-8?B?N2JxM25nOGdOdk1TSXZkRWVFN2I5YndIM2VHR2pYVFc5L0puZTNCblM3YVdt?=
 =?utf-8?B?WTlGNmF6RzUvVWhJbXcvUDhrMHRvTTI3K3hYZ2hQUzFXY3EvdlBFUzRiZmt5?=
 =?utf-8?B?enFxQzhoSnJyTFVXa0czcGtwMDd5VW5BMVlrdWtQMldzQU1rVzE2Z1pOTGlF?=
 =?utf-8?B?SVdLZ3F5Z0YzYTdNR1VmT0hSMzRPOFE4OWJVdXp6MEtrWEN0aHZMaHJHUWlN?=
 =?utf-8?B?d0pXWWtKR1EvWDdSVmxuVTQ4akFzK1UyKzllYVFYUHJlOW9NQXdSWkVOR0ly?=
 =?utf-8?B?bm13aGhBdkZaYVpaVjdtbE9wME5xUFZjOU82SnJUbWZDcjBxUExMYTVSUkph?=
 =?utf-8?B?c1Q0OFJsa0JBTGFWeVdtYUJad1RvR3dJZTNJVi9DZHMzeFd1ZXNaY2pqZjh6?=
 =?utf-8?B?eks5NUdxZkNuTnowWlhvdXgxQ3hUQWw5dllDdzlRb01uTnZDekluSGUvNHJx?=
 =?utf-8?B?dllSczZwSGkrRDdYOUw4aHR2VG4vYVN3Q211N1Zwd1BObHdXNnRxc2k1ajdL?=
 =?utf-8?B?azFNNlJNVVYvOGp0dGRESmk4b0JNUG1ucExCOEtmaFRFcHBkWnVQVTF0UE9r?=
 =?utf-8?B?bWlVbEhNUUV1cjhvd3BnN1VSWlM4NkhVa1RtdUl0Mmw4bm5Qbk5IdXhwRjlu?=
 =?utf-8?B?ZmNMMWdYNDFlVFpNdS9xeGlqdHRzSTE5M0lIajRUSEZ3cFhrQTVsUDNxUUMv?=
 =?utf-8?B?dTh1eU5FKzA2UytxY0x1Q0hTUFpUa1grT3FhdWJuQTAwVDlWRURtcXlCTG1Z?=
 =?utf-8?B?UUpVRVAyNjFrWW5wY05DRzBnU1I3U1lLTTg4aEQxYXdMMlZVaUhzcVpYM3VL?=
 =?utf-8?Q?pQGSUy4VaOW177PZKMtOQT/UgxHIyc=3D?=
Content-Type: multipart/mixed;
	boundary="_002_SI2P153MB0718D1D7D2F39F48E6D870C1D4682SI2P153MB0718APCP_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4921530e-90d8-4dae-f3d3-08dcdc90663f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 11:59:52.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv9PbPL2qHXG3hDZ4Ef2fqfwgX5T3bdSCyE1cLsDEYqq6r5za40K4FiAYjaVx6JIGrslMPG8xTdncFtLIw/T7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYP153MB0989

--_002_SI2P153MB0718D1D7D2F39F48E6D870C1D4682SI2P153MB0718APCP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

WWVzLCB3ZSBhcmUgdGVzdGluZyBpbiBXU0wgZW52aXJvbm1lbnQuIE9uIHJlbW92aW5nIHRoZSBt
b3VudCBtYXJrLCBnaXQgY2xvbmUgc3VjY2VlZHMuDQpXZSBhcmUgdXNpbmcgdGhlIHJlbGVhc2Vz
IGZyb206IGh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvV1NMMi1MaW51eC1LZXJuZWwvcmVs
ZWFzZXMNCg0KRGlkIHUgZ2V0IHRvIHRyeSBnaXQgY2xvbmUgb3BlcmF0aW9uIG9uIDlwIG1vdW50
IG9uIHlvdXIgc2V0dXAgPyBNYXkgSSBrbm93IHRoZSBrZXJuZWwgdmVyc2lvbiA/DQoNCkNhbiB5
b3Ugc2hhcmUgdGhlIGNvbW1hbmRzIG9mIGhvdyB5b3UgY3JlYXRlZCBhIDlwIG1vdW50IG9uIHlv
dXIgdGVzdCBib3ggPw0KDQpQbGVhc2UgZmluZCB0aGUgY29kZSBmb3IgcmVuYW1lKGF0dGFjaGVk
KSwgZXhlY3V0ZSBhbmQgc2hhcmUgdGhlIHJlc3VsdCBpbiA5cCBtb3VudCBvZiB1ciBzZXR1cC4N
Cg0KSSBoYXZlIHRlc3RlZCB0aGUgZmFub3RpZnkgZXhhbXBsZS4gSXQgaXMgd29ya2luZyBpbiBX
U0wgZW52aXJvbm1lbnQuIEluZmFjdCBldmVuLCBpbiB0aGUgZXhhbXBsZSBjb2RlLCBJIGhhdmUg
bWFya2VkIG9ubHkgd2l0aCBGQU5fQ0xPU0VfV1JJVEUgbWFzay4gVGhpcyBldmVudCBoYW5kbGVy
IGlzIHJlY29nbml6aW5nIHRoZSBldmVudCBhbmQgcHJpbnRpbmcgaXQuDQoNCg0KVGhhbmsgeW91
LA0KS3Jpc2huYSBWaXZlaw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW1p
ciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJl
ciAyNCwgMjAyNCAyOjI3IFBNDQpUbzogS3Jpc2huYSBWaXZlayBWaXR0YSA8a3ZpdHRhQG1pY3Jv
c29mdC5jb20+DQpDYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGphY2tAc3VzZS5j
eg0KU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IEdpdCBjbG9uZSBmYWlscyBpbiBwOSBmaWxl
IHN5c3RlbSBtYXJrZWQgd2l0aCBGQU5PVElGWQ0KDQpPbiBUdWUsIFNlcCAyNCwgMjAyNCBhdCA3
OjI14oCvQU0gS3Jpc2huYSBWaXZlayBWaXR0YSA8a3ZpdHRhQG1pY3Jvc29mdC5jb20+IHdyb3Rl
Og0KPg0KPiBIaSBBbWlyDQo+DQo+IFRoYW5rcyBmb3IgdGhlIHJlcGx5Lg0KPg0KPiBXZSBoYXZl
IGFub3RoZXIgaW1hZ2Ugd2l0aCBrZXJuZWwgdmVyc2lvbjogNi42LjM2LjMuIGdpdCBjbG9uZSBv
cGVyYXRpb24gZmFpbHMgdGhlcmUgYXMgd2VsbC4gRG8gd2UgbmVlZCB0byBzdGlsbCB0cnkgd2l0
aCA1LjE1LjE1NCBrZXJuZWwgdmVyc2lvbiA/DQoNCk5vIG5lZWQuDQoNCj4NCj4gQ3VycmVudGx5
LCB3ZSBhcmUgbWFya2luZyB0aGUgbW91bnQgcG9pbnRzIHdpdGggbWFzayhGQU5fQ0xPU0VfV1JJ
VEUpIHRvIGhhbmRsZSBvbmx5IGNsb3NlX3dyaXRlIGV2ZW50cy4gRG8gd2UgbmVlZCB0byBhZGQg
YW55IG90aGVyIGZsYWcgaW4gbWFzayBhbmQgY2hlY2sgPw0KDQpObyBuZWVkLg0KDQo+DQo+IEZv
bGxvd2luZyBpcyB0aGUgbW91bnQgZW50cnkgaW4gL3Byb2MvbW91bnRzIGZpbGU6DQo+IEM6XDEz
NCAvbW50L2MgOXANCj4gcncsbm9hdGltZSxhbmFtZT1kcnZmcztwYXRoPUM6XDt1aWQ9MDtnaWQ9
MDtzeW1saW5rcm9vdD0vbW50LyxjYWNoZT01LA0KPiBhY2Nlc3M9Y2xpZW50LG1zaXplPTY1NTM2
LHRyYW5zPWZkLHJmZD00LHdmZD00IDAgMA0KDQpJIGRvbid0IGtub3cgdGhpcyBzeW1saW5rcm9v
dCBmZWF0dXJlLg0KSXQgbG9va3MgbGlrZSBhIFdTTDIgZmVhdHVyZSAoPykgYW5kIG15IGd1ZXNz
IGlzIHRoYXQgdGhlIGZhaWx1cmUgbWlnaHQgYmUgcmVsYXRlZC4NCk5vdCBzdXJlIGhvdyBmYW5v
dGlmeSBtb3VudCBtYXJrIGFmZmVjdHMgdGhpcywgbWF5YmUgYmVjYXVzZSB0aGUgY2xvc2Vfd3Jp
dGUgZXZlbnRzIG9wZW4gdGhlIGZpbGUgZm9yIHJlcG9ydGluZyB0aGUgZXZlbnQsIGJ1dCBtYXli
ZSB5b3Ugc2hvdWxkIHRyeSB0byBhc2sgeW91ciBxdWVzdGlvbiBhbHNvIHRoZSBXU0wyIGtlcm5l
bCBtYWludGFpbmVycy4NCg0KSSBoYXZlIHRyaWVkIHRvIHJlcHJvZHVjZSB5b3VyIHRlc3QgY2Fz
ZSBvbiB0aGUgOXAgbW91bnQgb24gbXkgdGVzdCBib3g6DQp2X3RtcCBvbiAvdnRtcCB0eXBlIDlw
IChydyxyZWxhdGltZSxhY2Nlc3M9Y2xpZW50LG1zaXplPTI2MjE0NCx0cmFucz12aXJ0aW8pDQoN
CndpdGggZmFub3RpZnkgZXhhbXBsZXMgcHJvZ3JhbToNCmh0dHBzOi8vbWFucGFnZXMuZGViaWFu
Lm9yZy91bnN0YWJsZS9tYW5wYWdlcy9mYW5vdGlmeS43LmVuLmh0bWwjRXhhbXBsZV9wcm9ncmFt
Ol9mYW5vdGlmeV9leGFtcGxlLmMNCg0KYW5kIGNvdWxkIG5vdCByZXByb2R1Y2UgdGhlIGlzc3Vl
IHdpdGggcGxhaW46DQplY2hvIDEyMyA+IHggJiYgbXYgeCB5ICYmIGNhdCB5DQoNCj4NCj4gQXR0
YWNoZWQgaXMgdGhlIHN0cmFjZSBmb3IgZmFpbGVkIGdpdCBjbG9uZSBvcGVyYXRpb24obGluZTog
NDE5LCA0MjApLg0KDQpBbGwgdGhlIGZhaWx1cmVzIGFyZSBFTk9FTlQsIHdoaWNoIGlzIHdoeSBJ
IHN1c3BlY3QgbWF5YmUgcmVsYXRlZCB0byB0aGUgc3ltbGlua3Jvb3QgdGhpbmcuDQoNCj4gRXZl
biBJIHdyb3RlIGEgc21hbGwgcHJvZ3JhbSB0byBpbnZva2UgcmVuYW1lLCBmb2xsb3dlZCB3aXRo
IG9wZW4uDQo+IFRoZSBvcGVuIGZhaWxzIGltbWVkaWF0ZWx5IGFuZCBzdWNjZWVkcyBhZnRlciAz
LTQgaXRlcmF0aW9ucy4NCj4gVGhpcyBleGVyY2lzZSB3YXMgcGVyZm9ybWVkIG9uIHA5IGZpbGUg
c3lzdGVtIG1hcmtlZCB3aXRoIGZhbm90aWZ5Lg0KDQpQbGVhc2Ugc2hhcmUgeW91ciByZXByb2R1
Y2VyIHByb2dyYW0uDQpUaGUgZGlmZmVyZW5jZSBjb3VsZCBiZSBpbiB0aGUgZGV0YWlscy4NCkNh
biB5b3UgdGVzdCBpbiBhIDlwIG1vdW50IHdpdGhvdXQgdGhvc2UgV1NMIG9wdGlvbnM/DQpDYW4g
eW91IHRlc3Qgb24gdXBzdHJlYW0gb3IgTFRTIGtlcm5lbD8NCkNhbiB5b3UgdGVzdCB3aXRoIHRo
ZSBmYW5vdGlmeSBleGFtcGxlPw0KDQo+DQo+IEFtIG5vdCByZXBvcnRpbmcgdGhpcyBhcyByZWdy
ZXNzaW9uLiBXZSBoYXZlbnQgY2hlY2tlZCB0aGlzIGJlaGF2aW9yIGJlZm9yZS4NCj4NCg0KT2su
IHBhdGllbmNlLCB3ZSB3aWxsIHRyeSB0byBnZXQgdG8gdGhlIGJvdHRvbSBvZiB0aGlzLg0KDQpU
aGFua3MsDQpBbWlyLg0K

--_002_SI2P153MB0718D1D7D2F39F48E6D870C1D4682SI2P153MB0718APCP_
Content-Type: text/plain; name="rename_try.c"
Content-Description: rename_try.c
Content-Disposition: attachment; filename="rename_try.c"; size=1912;
	creation-date="Tue, 24 Sep 2024 11:05:24 GMT";
	modification-date="Tue, 24 Sep 2024 11:59:52 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8dW5pc3Rk
Lmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxl
cnJuby5oPg0KDQppbnQgbWFpbigpIHsNCiAgICBjb25zdCBjaGFyICpmaWxlbmFtZSA9ICJjb25m
aWcubG9jayI7DQogICAgY29uc3QgY2hhciAqbmV3X2ZpbGVuYW1lID0gImNvbmZpZyI7DQogICAg
Y29uc3QgY2hhciAqY29udGVudCA9ICJIZWxsbywgdGhpcyBpcyBhIHRlc3Qgd2l0aCBmaWxlIHJl
bmFtZSBvcGVyYXRpb24uXG4iOw0KICAgIGNoYXIgYnVmZmVyWzEwMF07DQogICAgaW50IGZkOw0K
ICAgIHNzaXplX3QgYnl0ZXNfcmVhZDsNCiAgICBpbnQgY291bnRlcj0wOw0KDQogICAgLy8gRGVs
ZXRlIHRoZSBmaWxlIGlmIGl0IGFscmVhZHkgZXhpc3RzDQogICAgaWYgKGFjY2VzcyhuZXdfZmls
ZW5hbWUsIEZfT0spICE9IC0xKSB7DQogICAgICAgIGlmIChyZW1vdmUobmV3X2ZpbGVuYW1lKSAh
PSAwKSB7DQogICAgICAgICAgICBwZXJyb3IoIkZhaWxlZCB0byBkZWxldGUgZXhpc3RpbmcgZmls
ZSIpOw0KICAgICAgICAgICAgLy9yZXR1cm4gRVhJVF9GQUlMVVJFOw0KICAgICAgICB9DQogICAg
fQ0KDQogICAgLy8gQ3JlYXRlIGEgbmV3IGZpbGUgYW5kIHdyaXRlIHRvIGl0DQogICAgZmQgPSBv
cGVuKGZpbGVuYW1lLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNjQ0KTsNCiAgICBp
ZiAoZmQgPT0gLTEpIHsNCiAgICAgICAgcGVycm9yKCJGYWlsZWQgdG8gY3JlYXRlIGZpbGUiKTsN
CiAgICAgICAgcmV0dXJuIEVYSVRfRkFJTFVSRTsNCiAgICB9DQogICAgaWYgKHdyaXRlKGZkLCBj
b250ZW50LCBzdHJsZW4oY29udGVudCkpID09IC0xKSB7DQogICAgICAgIHBlcnJvcigiRmFpbGVk
IHRvIHdyaXRlIHRvIGZpbGUiKTsNCiAgICAgICAgY2xvc2UoZmQpOw0KICAgICAgICByZXR1cm4g
RVhJVF9GQUlMVVJFOw0KICAgIH0NCiAgICBjbG9zZShmZCk7DQoNCiAgICAvLyBSZW5hbWUgdGhl
IGZpbGUNCiAgICBpZiAocmVuYW1lKGZpbGVuYW1lLCBuZXdfZmlsZW5hbWUpICE9IDApIHsNCiAg
ICAgICAgcGVycm9yKCJGYWlsZWQgdG8gcmVuYW1lIGZpbGUiKTsNCiAgICAgICAgcmV0dXJuIEVY
SVRfRkFJTFVSRTsNCiAgICB9DQoNCiAgICAvLyBPcGVuIHRoZSByZW5hbWVkIGZpbGUgYW5kIHJl
YWQgdGhlIGNvbnRlbnQNCiAgICBmZD0tMTsNCgkvKg0KICAgIHdoaWxlKGZkPT0tMSkgew0KICAg
ICAgICBmZCA9IG9wZW4obmV3X2ZpbGVuYW1lLCBPX1JET05MWSk7DQogICAgICAgIGNvdW50ZXIr
KzsNCiAgICB9DQogICAgcHJpbnRmKCJGaWxlIGFwcGVhcmVkIGluICVkIGl0ZXJhdGlvbnNcbiIs
IGNvdW50ZXIpOw0KCSovDQoJDQoJZmQgPSBvcGVuKG5ld19maWxlbmFtZSwgT19SRE9OTFkpOw0K
DQogICAgaWYgKGZkID09IC0xKSB7DQogICAgICAgIHBlcnJvcigiRmFpbGVkIHRvIG9wZW4gcmVu
YW1lZCBmaWxlIik7DQogICAgICAgIHJldHVybiBFWElUX0ZBSUxVUkU7DQogICAgfQ0KICAgIGJ5
dGVzX3JlYWQgPSByZWFkKGZkLCBidWZmZXIsIHNpemVvZihidWZmZXIpIC0gMSk7DQogICAgaWYg
KGJ5dGVzX3JlYWQgPT0gLTEpIHsNCiAgICAgICAgcGVycm9yKCJGYWlsZWQgdG8gcmVhZCBmcm9t
IGZpbGUiKTsNCiAgICAgICAgY2xvc2UoZmQpOw0KICAgICAgICByZXR1cm4gRVhJVF9GQUlMVVJF
Ow0KICAgIH0NCiAgICBidWZmZXJbYnl0ZXNfcmVhZF0gPSAnXDAnOyAgLy8gTnVsbC10ZXJtaW5h
dGUgdGhlIGJ1ZmZlcg0KICAgIGNsb3NlKGZkKTsNCg0KICAgIC8vIFByaW50IHRoZSBjb250ZW50
DQogICAgcHJpbnRmKCJDb250ZW50IG9mICVzOlxuJXMiLCBuZXdfZmlsZW5hbWUsIGJ1ZmZlcik7
DQoNCiAgICByZXR1cm4gRVhJVF9TVUNDRVNTOw0KfQ==

--_002_SI2P153MB0718D1D7D2F39F48E6D870C1D4682SI2P153MB0718APCP_--

