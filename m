Return-Path: <linux-fsdevel+bounces-54387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AAAAFF0EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6DB3A685F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36521239E84;
	Wed,  9 Jul 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dN6biPgY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5521B8FE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086041; cv=fail; b=HA7tTLTVOMB0Lgb7B5+So76bYE4m5dNNqPDE/MOGeAjWKpBx/QP8vtfQeYZgUuliN/YLvdrS4ZG9rWGvJ3ZD2fk8JYuLdow1EgWxssXGr2IqDQL7X7KzmJM8ZvuU25YPZyQngknYe407CAY4jus1ISAvO+rNJkYsdkOyXKIMHB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086041; c=relaxed/simple;
	bh=zmQ+MNZnewfkV5GXV9go4xv5BOGoWk1sAAfp9gTyo2I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=M578O7iSxpOxecr3LrmWL/EOhUnynXSMpY0plqWHstp+aojwVg299f98K7l9sZsgZvEsOgC51UxlMkJrRDUHo1CfUjHaHkjPWcyG3rYgAH1zLsshm/c9XTm6qbsQus0Gdbqi1jbpWYQDTbe7J6SHythz492M3rJeOrWdBBXOHq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dN6biPgY; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569IEMUL020492
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 18:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xFqNnf3ZKdDlRg9t8vm0Q9/qfLmM2dmttb+YRaf45r8=; b=dN6biPgY
	HvnxFUUB+UEMW+bM9XCNthAABzUia9BBeA+5gRZhF8AcgEQ1Kwvk31mB3q7ovrXC
	QvRdmTE57BgCdTiTjQm1i5fULeX0pKH1TEKuR2dqkjhnzJ0ADLe+p4Ub9SklvoSH
	8lN1E9NuKh44ILvkTSM+trK7YHJECMx86ZWo1EbHi8aybAoCluBfZTenWRjMCV54
	K/h8JmOQnqjAbpXyyK8K7OLZdbd6lmuAn8mbav+T17WHsO8Kn5SVhPPoYQ7xYCZd
	00SejQPpKUu1qj3aCkZx2ND8rTv4kzblsTbULv1NyfE5RS/3vo6zzXuSWV+5xtYW
	HHev7CAOYwCMOw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss85ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 18:33:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 569IS0Pp016122
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 18:33:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss85ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 18:33:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj6t2E/R/jFL/71ORiq01IBpnZZczX0Y6UISubbar95P+u6H3AW+ymLj6Az7E0OmoXSziulDqjMCuY2cz78ec0HU2oafRPPmLH4EVwVdhbnfw0BNzYakv4VeT0knDuzKSwj4TLRTBwq4blJ4zOh7wAs4cAJmitsQ3/Tiz93mifgrN8cpNKX0UpwNI0OKb6lptvBralea3NFDKCRhCXq2I3S2CWAYwJ0kDWN0AtdzWNsgkqwM7gWtCD0aoRTn/vxzYFhDplJ5bqX+iHCYc3HuUNn8hpg46wYl7kXwCCdtOba8Q+AX7Tc/acyxMdmA+sUsRJxH7OohbBbQ+IdlVgAU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhPChYT8/f75cp4rO9Z2aK22JPLEjHmq1ea3/P/gNOA=;
 b=QgobYsZzrUJeqQzuIHtwOLNfFX5hdB9oZd+x9CPIkWUUL2Fz5Ny+cBVePVe5VMvA07gpCBtkmiK1yGyTK7Qpwm9w0UKZ836S+vNuRbJDoAMsNE1rek+pqYW4WQh7NFCqCwo/0FbQtDlkSBaMeIik/nneWvVzDXRWKApE2QTiCs8A23a0KOuA+cnI0RHTVsRz1p73KQWXYwW9zlE6wPCqfSwD/RQN0CB0nFqj7YMj57uyR/06skA78GXoj1WIZ76IPT5BeX5Jrh80QeSwHvH0tKkGg+YMVeEKwCRgwi3V0h1M+oelaY7ixZpFWZKnYmPdTUyzSADZ3G53SAEmMdzJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB5225.namprd15.prod.outlook.com (2603:10b6:a03:428::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 18:33:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 9 Jul 2025
 18:33:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
Thread-Index: AQHb70qjLuneU93t80+qPqT+jd4L9rQmvPcAgABIC4CAAtCIAIAAS+wA
Date: Wed, 9 Jul 2025 18:33:56 +0000
Message-ID: <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
	 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
	 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
	 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
	 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
	 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
In-Reply-To: <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB5225:EE_
x-ms-office365-filtering-correlation-id: 8bb24d9b-3d9f-4ddf-8791-08ddbf1729b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZE1kMUQyZ29UZXBCSHB5MVd1b0RZM0UrZzJvTzJsKzV2cVFwSUtVOTBJKzV4?=
 =?utf-8?B?VDhtSXVyVUJEaE5XVjV5TG5Wc2FtVmx3K01OSHlONXJ3b25RZndDVE1IcGV2?=
 =?utf-8?B?WXBGR09DdDJ3QnZkY1BPRG56cGpVMHRSdlZZa3RMZWVTNzc2ZTkrZkZONm5H?=
 =?utf-8?B?R1ZBNnNOaThmaEI2VTVxSk9aUEVGWU15ZHYwU1V0K0FqaFJPdHV6YmFjV3Zj?=
 =?utf-8?B?NU1DVk9TTVFiUzFRdERVU2JuNXdUeVRKcDFaYTZodUNWRVJKWTNuZFduSXgv?=
 =?utf-8?B?YXlJa3ByS3h6T2FiQ1YyKzBHVTJWelRnTnhaKzVSeDdMemVDbEp1cnI3MG9h?=
 =?utf-8?B?d29Pd3pBbjhpOUFkRDh1UjNEeWRWM3A5ZEc5V2UwNzJ5M3J5aUpZVzBJRWlI?=
 =?utf-8?B?eDhsbmk1c1EvY0drcUxNMUgyNkF3K2ducis4RU9NY3NJVUNlQVN3Z0U2TkR0?=
 =?utf-8?B?TUNZZWlYc3hFOEp4KzdyUDhRRHhxSXhFYWV2TzVOaG10SVVBYXBsQzNrZGRB?=
 =?utf-8?B?Wlkwb2lqVUNSVXNYcTkyQkR0K29MSHhtMGdkZytOL2xVbWw3TGUrcHlJa1Iz?=
 =?utf-8?B?TUx5d1hDQTY4WUNjVFh6S1NmVTk3VnFDNkZnN0VIK1JodSsrRG9nS1phSVhW?=
 =?utf-8?B?VWdyOE1za3NEWVRmSWZ2Y2FLUGdMM2RKMGFqWDMxVlNLaUY0T1ZNajJnb0ZE?=
 =?utf-8?B?clFSL0ZUWEUyTzR3M1IvamtxQmdSNXBSY3lOSUVORkJuRXBNTDdoRDloclFj?=
 =?utf-8?B?dmF5MjlsMWVsUWkxSjZtNzMwY0R4OXJiOEYzT014L0txSDhhREVtSXhhOStp?=
 =?utf-8?B?KzlxRWRoM2Q5WHIyazNEVmt4NFE1WTJSZ0N4SVdlT2xnZE10T3pKTkJNeTJL?=
 =?utf-8?B?YzFucWpmdkhjc3NBKzRQQTQvclZVL0FSWDI5TWtqdWh3THNVa1VOY3hYYnQw?=
 =?utf-8?B?ZUhhVDB1M3dBcFJLZWZuVHpXOVA0dlRHUmZhbkpCSzJiMlpVeHMxZVR4blhs?=
 =?utf-8?B?V0hFWCtnNHh5REIvMThEZkR3SWtickN1Njl3MzY3YVZybGQ0aFA1UStnbUQ2?=
 =?utf-8?B?K3hOb0s5VDh6dFFzSHcxSW1JUmVQV2I5ei9GSHBsbHlHSVBrempHQ2UweTlM?=
 =?utf-8?B?T1hIUGhJcGxaZ2p0aFlTK1VxNkd3cnBkeGtodGNNVC93ckY2YXV2czBnUzFi?=
 =?utf-8?B?dmkzZ05CeEZrWE9vNHRzck1wVXZGQ3FxVE83dkR0SWVaanFYZU9rOU9NTkhU?=
 =?utf-8?B?L0xFR1ZWMThKK3lVTHVrL3FKSE9qanl6TjRXY0s0YVRlcS9seHhGUktnakxh?=
 =?utf-8?B?YXZDSkxCNG5hMld4VkJQTFZCdDRsK3FXS2lJOU9qbjJUSnVxTDgyK0NhS250?=
 =?utf-8?B?NWVuQUUrQ3ptVlZjWE95M09ONTdnaVpjK2hXMGd0OGtKeFNlVlkweWNaM3FK?=
 =?utf-8?B?N05wU0JnYTBnMFl4WEpvNXcybDVSZFRJbnlqR3R1blJBZW9YN0xMSElqdkxn?=
 =?utf-8?B?VUYvNnlBcCtwaStaUW9adElQeTJWdW5LTE9oQ2dqcHNkZldoNVhMOGtMMFdW?=
 =?utf-8?B?QXNUOTdPTmVrZ1N3ZmMyL3BzZ2U1MWFtQW5UcE5tejZsMDNoMHBNQ29Mc2Rt?=
 =?utf-8?B?cFk3UVFUNm00L3YvZy9PMzhyT2tFZHhLcmtsT3FEeGhyWEY1amVPT1pOSzBX?=
 =?utf-8?B?a1cxS3UzV0tvZ2VpZ1hxa1B2empkRWx6UVlobHFTbkdLcExZRnppNE1saGF5?=
 =?utf-8?B?dXd1TVU0S292aHEwbi9IZTdCd0xyMWhUejZKQktqZHNlNnVGKzJDdmFWMkJV?=
 =?utf-8?B?bUxlZWRyYmJFWFM3UGhBd3Jna3JkbnFEZTlXK3lURWxpZFVIeVFoWGRzL2pt?=
 =?utf-8?B?eEgxT28xN3JGd1kydzBGdmNTNDY1M1B3dHBJOGZwRDBrNUVRV1VyZ0ZMMnkx?=
 =?utf-8?Q?fnamFm37i40=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTJWcFcxVXN4S21JWC9OUWZyT1piVTZ6MDBUMUVaVFBGSHFDMDBKK2NOVzJq?=
 =?utf-8?B?UWs2M01ZdzhtRDVyM1FzcjNDYlhmV0owNUtJZDVKNk42d3BaRVZsbmYwbTJo?=
 =?utf-8?B?NEh0SEJ6UmZUamIyQmsrT0tsa2ozSlVSYWc0bWZHT1dIa2hQZzA2OGNScHR2?=
 =?utf-8?B?VFVwZXlKMW1qRkJjeHlJb2RtL3pSMFZHeGhFR0FtL2xmeXRUcjhmQVVCS2Mx?=
 =?utf-8?B?ME1CV0RiRTFiWXA5aU1BazhkdzRlMk12Q3B4Yjk3MzQ2dzBLb1BYdVEvMVpq?=
 =?utf-8?B?WEl1Vk8xY3htY2VnMXozcEJIZ0UvUFNTeW9kWUh1QTJ1ZUJSanEwbUxoNU90?=
 =?utf-8?B?cGZzUW51VWF0aGIwNEZrVnl4NjBJeUd1OTRkaGgrOFZKb25aR2dsampPWGth?=
 =?utf-8?B?MEhpbVk3bzh5aFdvbkFkNVk2Ylcyd3ZCRlJzNUxZbkw2dWI1MFRhdEgwaDhL?=
 =?utf-8?B?TWVxelF1Lzhydmp0NUMyUnBnRDY3RTF5bUJHS2JCOU1QN1VQdjROeDB5STBr?=
 =?utf-8?B?WG1sQ0Z2enpYc1BCZ3d5U3AreUUxSmt0L0ZlenhCd3RseERGbkQ3UjYxSkIr?=
 =?utf-8?B?NW1Jbkx1YXBNdC9sN1hteXQ2WXhCajk3eVJFTTJZSE83eUxibnYydTROOUp4?=
 =?utf-8?B?akw2S0xIeHp6am5mU09JVVUrSWttR2pneXNTTy9tVWdpb0doWHFmTW4xQTkx?=
 =?utf-8?B?Vk8xYWRwSS9EMHh3YmJTaUV4bHhuRzd0MDZCT1prZktuNGhLODE0NUdwL0ZJ?=
 =?utf-8?B?VTZFN242NFk3ZjF2cUhkWFF5M2g5KzJtbk5HSnVIcXh6ZHdneEcvTTVRNnda?=
 =?utf-8?B?UlB3cUpTNVorNGdsSURIZXg0SGxWTEpuQnNqZXB0Q25oM3dhL1BWMFZob0JN?=
 =?utf-8?B?SlQ4Tnc4VUpkUUZPWm93OFVoMnVmRC81aDZLTDZJY0R2MmRDNVF1K1BLZWNi?=
 =?utf-8?B?cmxxOEY1Q29SdDdDayt6NU14R3dvZ0RvblZDNHdNUTRaTUdRTlpWdmhydU9i?=
 =?utf-8?B?SG5PeFpETWszM1o2bmhHNVNJM1hqbWE4VFp0ZCt1bitVSTBMOHBaNzVNV1ZS?=
 =?utf-8?B?NVk3MWNJQ1BBVU8ybVF4OXlUaWx5SDVodDErMi83b05MdnRQanZzN2U2UWRv?=
 =?utf-8?B?aDh1OGd0MFhITG5OOFE2dGYrWkQ0RkJ3Ry9IVnNuZTE3VTUrZWJmeGE1RmdO?=
 =?utf-8?B?UVFmOHQwbm9PQlgxRXhIQ1diTWtMcmtUZ1UweERTMHYyQ1RHNTNrMytJaGtu?=
 =?utf-8?B?d3N5dW5Sb1k5REsxc3NQS3NVSzM4eC9WYnE4ZWlzTi9zZCswQ1h3MExEaWZq?=
 =?utf-8?B?R0VBK205dVhOSEorRTV3WlZySkw4VExWYnQ5UzF2cnZFSms2SWQwWTZSdXJ1?=
 =?utf-8?B?Q2tJSDBUYzBNUUZGdzlVV0V1SUlHVm44TE16eXZEeDNsQ2hqUlVueW9iUmRq?=
 =?utf-8?B?eTB4dk5PTUJpalg1R1QvVG1QSXhWT0FMSHNVclFCNnI4M0QvQUJWSzJHd24r?=
 =?utf-8?B?a1EzMU9zTlVGdzV6dXNyZnd0S1lBaEVURHBmbDlHd2NFLzhmeGhKSUNZZ2h2?=
 =?utf-8?B?aU1rS3FWTG9PZUI0M0VIU29UTHZDV3A2ZExKTnYvWWZWdTE2eVBUcW1TMlEv?=
 =?utf-8?B?KzRXRWpvRDhybko1RUVKaWRkeXhYWDRZTjMzZ2dnL0YrVVBBRkNKZmo5ZGtN?=
 =?utf-8?B?em9GWW4yRWUyUGlubDBxNnNmQ0xXNnRlK0U0NUl2ZEhGWU4zVFkwSHN0RTE4?=
 =?utf-8?B?c1hGSHlMT01QOW5CQnhZdVZhd0J5U05wNWd6MzV0anlEUGVIcU5CZGRqcTdL?=
 =?utf-8?B?eW9YNFowTHpicjNkQS8vTHBhVE1tVEVkU3NDSU83NjRWSXQrSFlCdksyTW9h?=
 =?utf-8?B?dDIva3haUE9RV0h6cko0bzdDZiswdittTGUwRzhrdkRYd0c3UXBpU3pqSUxS?=
 =?utf-8?B?MnhJYVVjSXdPMzVxbWwxU0RsMHlyS2Y0QVdVK3RUWU9xazBienNZUnFmeDA3?=
 =?utf-8?B?Nmo1Z0k4VlpIenRhK0dDYVJrVW5GaDNZSGNUdVZyN05tTlhQSU8yTzBDUXBa?=
 =?utf-8?B?ZFRwUHNYNmdlalhqdzBWdVVFMUFPelNyRGRzU2xvSXV3YkJnemFQbkpvTlk3?=
 =?utf-8?B?MTIvUU5pWU5FbmNzWUU0bFpFbzI4aEg5eFlEcGJyL2NEZC9HdUI0RUsrbXVl?=
 =?utf-8?Q?kEdoh6y9/mwL7P7qtAk6l7M=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb24d9b-3d9f-4ddf-8791-08ddbf1729b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 18:33:56.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZR4WP4KRl94kpwsrZzsT9iQBFi6W5izvyhYzsPR5uYqCGpnvdSUbGVNO/Qb7tihSMqjBVNmo/9H+T2aEdoCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5225
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686eb616 cx=c_pps a=WhUEUVamR7lPV9LkVsdNog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=4hXI_X3aZvRekRiYkGsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 3qWvpcKrS8bem39D0HLNCXS-Pf8FHZr8
X-Proofpoint-ORIG-GUID: 3qWvpcKrS8bem39D0HLNCXS-Pf8FHZr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2NSBTYWx0ZWRfXzq+UJkjXTa6M ih8OZznVJfSFNB7rdRSlpW9O7lGBR9Wz96dCjVF2J94zWmermZsp9/yTwZHHnE3ak0qQc+o7zLD sHtdj80V9sWnA+po9gHpJJJQYMwQHSaShU9kYlQGJKvG+rhDTTWt3oyc6exdC2abCD+tD7nqjLT
 J+p+hGI5oHtqnwHmfiocczE9o1Bcuw05CKwZNz4CZJi2/0BcfLjAKTwB6gWuX+QdZmYMJZtV4Ku OKTbmIoIinuo75j1UnVrQzwE+/Gr0Gbh7zLmEnm/y+CFDlPyj0Rd3T8k3PHvSJrIHxHTmtegX0i iataxWjS6wIqV+d9Ei3liidYmn6lLQf/7CzgqnBAh/QVQPFPNYHBvr6ifgogHbNWhXkN5XVL1Z3
 UCtfV6W2FMcEKre8EHU09KlXlzfWX6ocI7wQVKKOK/F3E4B4wQ6CXihb6tjK5bRXAnDDcNbQ
Content-Type: text/plain; charset="utf-8"
Content-ID: <54AE6FAE7215594196660D9FE12F8658@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507090165

On Wed, 2025-07-09 at 23:02 +0900, Tetsuo Handa wrote:
> On 2025/07/08 4:03, Viacheslav Dubeyko wrote:
> > > > @@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(stru=
ct
> > super_block *sb)
> > > >   		return PTR_ERR(attr_file);
> > > >   	}
> > > > =20
> > > > -	BUG_ON(i_size_read(attr_file) !=3D 0);
> >=20
> > But I still worry about i_size_read(attr_file). How this size could be =
not zero
> > during hfsplus_create_attributes_file() call?
>=20
> Because the filesystem image is intentionally crafted.
>=20
> syzkaller mounts this image which already contains inode for xattr file
> but vhdr->attr_file.total_blocks at
> https://elixir.bootlin.com/linux/v6.16-rc5/source/fs/hfsplus/super.c#L485=
 =20
> is 0. This inconsistency is not detected during mount operation, and
> sbi->attr_tree_state remains HFSPLUS_EMPTY_ATTR_TREE, and
> this inconsistency is detected when setxattr operation is called.
>=20
> The correct fix might be to implement stricter consistency check during
> mount operation, but even userspace fsck.hfsplus is not doing such check.

As far as I can see, we try to create Attributes File in __hfsplus_setxattr=
()
because the mount logic doesn't create this file (because it could not exis=
ts or
not necessary):

int __hfsplus_setxattr(struct inode *inode, const char *name,
			const void *value, size_t size, int flags)
{
<skipped>

	if (!HFSPLUS_SB(inode->i_sb)->attr_tree) {
		err =3D hfsplus_create_attributes_file(inode->i_sb);
		if (unlikely(err))
			goto end_setxattr;
	}

<skipped>
}
My worry that we could have a race condition here. Let's imagine that two
threads are trying to call __hfsplus_setxattr() and both will try to create=
 the
Attributes File. Potentially, we could end in situation when inode could ha=
ve
not zero size during hfsplus_create_attributes_file() in one thread because
another thread in the middle of Attributes File creation. Could we double c=
heck
that we don't have the race condition here? Otherwise, we need to make much
cleaner fix of this issue.

Thanks,
Slava.

