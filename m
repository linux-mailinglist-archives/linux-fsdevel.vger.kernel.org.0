Return-Path: <linux-fsdevel+bounces-59309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA6B372C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3683AEC1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AB37289F;
	Tue, 26 Aug 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdGye+dO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDB371EAB;
	Tue, 26 Aug 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234748; cv=fail; b=Ojzw7yMk0YLXmgKaReKZx8MyaR27D0XG5cH+A2PsvAClINf3ursbIj0eqVi+FIO9YgRPhGCkY/M0JP9LMu7C9ihW0JSmGhARy8na/zjEu3VG0d1qbSLb5y16uJKEZCkGLpZvg2N2gETiqSlF7yBcQZdAfayi8EVR5T+9u2mIzBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234748; c=relaxed/simple;
	bh=fLj/ij5391GIAR4tPWkHlMHI4lVOvya5sFI3tXbUbCg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=J/L5FFd6SNZzXrQAkTYZWzqCBPL/NrzlmEg8bnt9YbdV92u0W0HxtrMrqKE+0dtZasHHdVSWiw8XiP+drwi98xEkELW/W4rYoXMJ7AqkdTECRP7/7zfLWnhbFAyOuaVOdBWtTeYwHQzyPEgldVlm4xarcDOrzLg/FcCZy4AdzYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdGye+dO; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHefH2027571;
	Tue, 26 Aug 2025 18:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=fLj/ij5391GIAR4tPWkHlMHI4lVOvya5sFI3tXbUbCg=; b=fdGye+dO
	QsCIJQO3xyz94woNvLn7ZGDmIenj/vXn2OwsWk8YKw77vd3RGzosgSOb9YfUy1lW
	mVTxC+E0Hx4z1JMcGFYCzgagSbgVLCrlUMbD1OMbxiQV73X+GmQmub7UpL4AhNt0
	SqeHvyTzNzyLj2D7xFVrqVB+lJMO3swJvdpXzI7mSTLLBEaKj6F7Aux6rsUAwfpM
	oV/0SumDfcmd9D9AqK9Cm/e3+5VwPI34fNSCpx5qR5lzLfO9Mz+j/wyGAYdT01Wj
	mUE9/hteaqXg7JyJcMHMZQaoue0Tc3DzhkEM06QkGgVJLwnaENJUf3QT910X1Aim
	lFGR1PDt4kboQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5580gge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 18:59:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QIrKSj023357;
	Tue, 26 Aug 2025 18:59:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5580gg9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 18:59:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok8K8I040zSCf2fbz5lfQgMqIMA96qyjP89kWa9jRVHk3PsLQvQ/Jz0oZM87pBonXfwPHc3W/VME2eImek7Do+5FRHfWTB6GwARFRdkrVHJ92EihndCsWsRyAenprueEFFx71eIhdEXTlUVHFQ/7uVyNVSRGvcrs160KJPN6JEanlciFZ8LNfocProGF8waK814Org142A2d44zFTjPCrb+gCYO7/omRsUoxxPQbn8r0X9UJZJwNC0iqeaNvvcncxnU3STzEKhfcenQVZOd0i9w/k5yuaKRBIMCZbnrNzzMRchI2/cUWuB7f2dKg6HYD7gq9wNaY0QbdStObzqRJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLj/ij5391GIAR4tPWkHlMHI4lVOvya5sFI3tXbUbCg=;
 b=eVvpJMqOCuoQ1chKXGYQ2aySsa/IYjyH3hrb8AlFS5L7vWr2pWf26iD7sGiZhXwa16oMnB8S3BEHrUjnzAdAHlz9tI2ueZZtgy2W0O1+XW7saQCP5Q45dUynR69KUri6Kk/ivrAQivbO8CwvJc+aGMBx4WCIjsBlVme1yL/ywunGP+shbb1VD9O8ocSzGc0GwBJtfoA14pa9kG4+MvZk5AP8GsR0lk0tOraHdRww1mK/WJpXALZgO1MpRjMFs8cjwjR7sEnusRxkHDr/qqcZwjy3Nl9iMIo7qJ9+j14HR1jr0ufXb3m6FLiXASi5bdFVnQgxgAYYw55MqRK99jGMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY3PR15MB4948.namprd15.prod.outlook.com (2603:10b6:a03:3c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 18:58:59 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 18:58:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>, Greg Farnum
	<gfarnum@ibm.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Thread-Topic: [EXTERNAL] Re: [RFC] ceph: strange mount/unmount behavior
Thread-Index: AQHcFgq8up/kVXqx70yqH8FeecslxLR0ppeAgACkRoA=
Date: Tue, 26 Aug 2025 18:58:58 +0000
Message-ID: <bbc42643a3ac0e8abd8f703b44787c773c2f9b1c.camel@ibm.com>
References: <b803da9f0591b4f894f60906d7804a4181fd7455.camel@ibm.com>
	 <20250826-bekommen-zugezogen-fed6b0e69be2@brauner>
In-Reply-To: <20250826-bekommen-zugezogen-fed6b0e69be2@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY3PR15MB4948:EE_
x-ms-office365-filtering-correlation-id: 60765786-3538-42f3-7176-08dde4d29d04
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1hsNTJRR0N4OUtJQlk1bzJYcC9NODN4Zmt1bmkyUC9HT0Z4eFlPazlNNWov?=
 =?utf-8?B?WTN1cG15akRJTUdXWWNuVm12aUc1aW1oZ28vV2NsemlVNWRyYTNERU9rZytX?=
 =?utf-8?B?VkFPeExqT2NubTR6WFNZakZyTG85UndCQlA2NVlBaVJXcEt4d1MyMVBaQTM5?=
 =?utf-8?B?RnNvRU9FclZoVm1Jbll6WEJnSTh4TTBOeVZocmRnTWp1V0FOWHRtYjJQeFBR?=
 =?utf-8?B?ME13dmM3QXdZS2ZlTWs1TnpqS000a3RUckhyeExxWDBPT3F1Ri91ZHVkbmR6?=
 =?utf-8?B?dHlEMjg3RlRWdUE5YmM5MzBvRkplRWZyODlyL2lxSnpFc0lTSjkzanFKYzZm?=
 =?utf-8?B?NXJISEp4eUwxRmxGcDl6MHRTcjZoSmUwMjlTV2VMN2NrM3A3cENaSjkxeHlv?=
 =?utf-8?B?akxlNkQrNVg5ZXBScVhYcjVMTnJnNUd5Z2xhZTh3WFZHYWQrNTBIVDhHWVZn?=
 =?utf-8?B?Z2tyakJubVBMTjJtUW8rckpKWDBhQWpLdjdGUDFHa2ZOQmo1UEVqSlFZTlh6?=
 =?utf-8?B?dUhxUUVNUmZYdHhQeW9UdS9JQmc0bTJXVFhUWU5xZWhyTFZwdFU1TUd1QzRh?=
 =?utf-8?B?Y2xqRld0Zytiako3dTdKblVnbUtzdGI3UnUzUk9SaUNqQlFkOE50bmMvTFJu?=
 =?utf-8?B?SFVJbWl5c1NwVWR6bzR3QXAvVzVyaFJZU3MydWcwemFSdVRRM1hkSEkvMUw1?=
 =?utf-8?B?eWljRkFnOUN4NDQ5RjZLZHpIVEVVd3MzMmlaL2d1VTc5YWpBb3d2RUVxVTlL?=
 =?utf-8?B?Z1p2SHEwMGxEUFJUMW9QV0lPaWNXNDV1amhSZlF5MEI3aG1PcnFUK2tiU1dl?=
 =?utf-8?B?VDBsRmppTTdWbHJwRUpqWUlLOFNMTHAvQ3hCM1FmRTJDQVdiNVlLYk9ZWlNq?=
 =?utf-8?B?TWtHQXppZDhvV3hCS1hWSGttVDV5c0dLRnJpZ3pMZGFBNExHZTI2UHFZckxn?=
 =?utf-8?B?MjB0YkdjWVY4RkNVZlZOR3RCSlNTY0l0TmUvQlI3cFFCTEtnbndIaVRURWJp?=
 =?utf-8?B?ZlN2T05ENUMrOHFSK2w2STBuVmdKYlAxcTVQYS9PaG9JRkxBb1hMSWcweHMv?=
 =?utf-8?B?RmZJdFdEQUJFZ0lnd3IzdVNRY1F4UFlBVGU1VFRzZ0ZnOFBjNnFIOVdxWmhL?=
 =?utf-8?B?NE4ya2xuMndRUVEyVkRxS0VBN0Z5TXQvMkVNaS9lU2VTL2dMZjErYmc4ZG9R?=
 =?utf-8?B?b21jZlA3RzR6a3grT1kxYThLNGVabHlnTkxicUNaenowdTlWZmNuV0R4Qk90?=
 =?utf-8?B?c01tbWROOW1VUUJVNE8xR1ovcUpTemRMQ2swdTVOdnFDdDk1Zk1JbG1WZUJM?=
 =?utf-8?B?ZkpRbVpCdGxSc253R3ZIOUdSZEdUcC9MaFFjTVNwQTV5ekt5VWIrTXFyNllz?=
 =?utf-8?B?NkZFbEhlcnpjSk1zdDFtakF1dWZ5WmxxRHNETUNwVlJrU0xuMEwySHR2eWRt?=
 =?utf-8?B?REtNUnMvamtQS3d5MlpNNnFuNklHYlZwOUU4QWlwOWtkcHdBM2ZBT0ZmV0V5?=
 =?utf-8?B?UEw0UHR6NGk5blBXTy9DeDF6M0cxUjdTVGJlbHhOeDUwL1l6ZmlrZ21NRmpY?=
 =?utf-8?B?ZXhKd2ZYRXMxK3dOQW1rV2hKTE12YUI5OWxjMklycENWNDQvQ2RvZmI1Qng5?=
 =?utf-8?B?eWR5OFZSaFlVUWxIdVV4b1RIYmd0VFgycGhoeERwT3dYOUNwR21aM1pnbW5n?=
 =?utf-8?B?MWdiOSs0bERMVFQ4dVQyZEYrazJ4S20xc2VxREt3QzNqTzlqU0VJUzVSZkVp?=
 =?utf-8?B?aHIzRmdUR1haL3BsNkFUK0QxWjYrTnlRS2t0SjZtV08xbnJYb1ZMeDlCTTRY?=
 =?utf-8?B?LzlVWXJYL0hobEVOZjZNRUNNRjg5YXBWM1c3T0wrZE5nd0pKRGhVSjQ1NzFK?=
 =?utf-8?B?WEgxNnM3dytjN2ovTE1ER1duVW9zc2V3QlN3TEkyMXIxTHByWXlVdHBCV1RD?=
 =?utf-8?B?bUZvdXRHV1NWWlEwTGdDNkFlSjBpWTI1ZEU4YzcvOVpuMmtGNEZrNCtpWE0v?=
 =?utf-8?B?UU9oQjgrdHNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFpUTUhUblQ5S1k3UHlydlQzZm41S3Z3OEExR1VVTUVkcld6L2oxMjJHMW80?=
 =?utf-8?B?dmhRTTVDZVl6c0tEV0lIRU1lcCsvZ0RZY3c4ZkpCc1Vrc29mMWRXSDB1OXEv?=
 =?utf-8?B?bWhTMUJ2ZlZURE5sc2NUdGlOak1MOGlWVDBvTUxJQXk1Z1dYU2dFWXg1UFVC?=
 =?utf-8?B?QkFWQ1hVTDJZWFJTaml6T0pVYnBpMGwwbFg1bkV2SFBQVUxxVTcwd0krRkpn?=
 =?utf-8?B?cDFiTmQ4UjhuVEhueWw1NWZYakMwMjhXeGFBSWRXSkFtZnhKOWcvUnMyS1Jy?=
 =?utf-8?B?WmlJVmZnaExIaVlZRGdkUEY4WGpGN3E5MnlFMm1Kd2p4OHJQbTVuZE5JYVhS?=
 =?utf-8?B?amZ4UXdMZjRwMFBHNjVPanJ4V0JGQ1krT3cwL1JQaUdnMjBpdkNXaFlEYUMr?=
 =?utf-8?B?bkNTVmRiRWplbXRDam1DUS9xWFI4Nm1udDN2NGhaL2h4SDN0QUVwb3dXSTAr?=
 =?utf-8?B?WjdrSnd1V1Vxd0hsMFIyS0NrMDVLekVHenY2NnhvMVY3NzhGa3Y3SFBtZWph?=
 =?utf-8?B?NkNLUlYxTlg2R05JQ1YwOTh3UEZpcFhQY1Z6a2ZIZVRSQ0hMaEdqd3ZwVTRD?=
 =?utf-8?B?czA1bUFmbmhyamtNNHU3UHBhd29DS0ZPbE9ZYlZXbUYrNnRuUnQvcFRCemFN?=
 =?utf-8?B?dEpCNk5rVHQ4TmZuWVk3Qzg0UWE1WWVpQURQTzBKRnV5aGQ1UWFIam53bHhP?=
 =?utf-8?B?a2wrNStlcnlzNE9SSm1ZTEU1NGxmMDJhNGpjYzZ3YVAraGxZNGpSb3AwdFIy?=
 =?utf-8?B?V0Ywd1E1QjBoT1RiaHU2VjdiU0NOa1ZjOVdMaEZkaU03eERnS1lNSmlRZGZU?=
 =?utf-8?B?NVgxNzNNelpyUDZEczNvRk4rakNUQUVjd203YU92TVRBc2pkamdhUlNVbjl1?=
 =?utf-8?B?U2RmMGdvUG1vL1lpajQzM3pjUjBjcGNxM2hIY3ZtRFhnRWpKVnpjTWllWnNY?=
 =?utf-8?B?V1UvMlRia0VWMlp3NDRxYmo0cng4azAxSHpOaG5QR2N5ekZDNHVzNE83WnlJ?=
 =?utf-8?B?dUtUcHk0WW5URzJvZHNNQnE0ckZ6S1J4T1JDVHhnMXJ6QWRzN2RiT3Q3dGpT?=
 =?utf-8?B?SWVsR3U3aG43NlpOSy9xdFd1WGpYclhYME9DUE5KQ2hSZVRiM3VpYWFGbklV?=
 =?utf-8?B?SXJMTXhKL1hFR1AwRVFZdW9uK1drVTIyRDRQclF5cWZweGkvZVZUWjNzbit0?=
 =?utf-8?B?K2t1aURsdEVIR2RRZ3JpWWtldDNVbm8wV3FKNHUvS1hPVVpmdmY1WjJPOCto?=
 =?utf-8?B?bDJwQ0ZhZjRyY0VYRFpvbFBpY0gwT25hblZ4YzJ1Z2ZuaXBhUHB4dkYvL1Rz?=
 =?utf-8?B?QzZYWHFlZXVFUmJBa2tTa3pCNnV1SXl6NmJOdE40WUdWN2t4QW9IK1Z3MERk?=
 =?utf-8?B?THRJWC9KRldoaU1sY1BUdExIMTBmUDN6NnFkejZCUHd3RVF2UG1MTS9Udnow?=
 =?utf-8?B?cHhBai9wSnFqemoycmZFOHdUTWN5aFJROHpLUDBENFlOSDhheEdjTzhCc0lv?=
 =?utf-8?B?eVFKZ3FVelNYdW9TUU1DbWZxdVNsNG9tNm9VWjBKSjhHSXBwSEtnMWV4WnBk?=
 =?utf-8?B?ZVQ3VjFiNWhRWStsNUowMllaRkVacm5tV05RZFlRWXZ3a0VvRkljMjIxV2hN?=
 =?utf-8?B?Z3dQT2lJQ042eC90VkdRWXBrOHkxc0NiSTczTUtqS3FCVFFiNkV0a2hvN01G?=
 =?utf-8?B?YWs3VytzLzl2M2ptNTEvS2x5cmlCTmRObmRJd3JmcGtQTUpsUS9tZGIvTWdw?=
 =?utf-8?B?bGtNeDV2QXN6Y2ZxRVJzWTFHOE1OSEtZaWNoTGcxT0ZudFJhN1prQkNMV1ZC?=
 =?utf-8?B?enFDS2FURVJYOEN4bmk5S1RQcFlocWw0a1MzQVdHd2oxakE3QlZvdVRCUVNX?=
 =?utf-8?B?MmR3MVRkc0NxL2xGaHJFbStDS1RySStyeWtkMXdLNWRtVU95MEd1ZHlYNjRN?=
 =?utf-8?B?eUlyUTZWU0N0REd6SXc0SXd3Mm52TVIzNVl0UzVMRDdEd3QzdXFvejJOZStx?=
 =?utf-8?B?bkxPZ294cWdra0JnQTBWZjhJaTVrYTBQWjVWclkzZ21xS21YekN2cnZZdHpi?=
 =?utf-8?B?SWdpUWdsRXpsK2tNRjJQT2E0dG9UK1hGNUZ0ZktVMks5REU2bWpvV3Q4YkJi?=
 =?utf-8?B?Smh0Y0J1bFYzR2JOYi9jakNXbVBxaHF4ajlkbklxZkJDd0cveThxYWp3UFFl?=
 =?utf-8?Q?cc/8Sppn2vU0yxelqZ537cY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <156460E8A89FDA49B8A839134A8B4F61@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60765786-3538-42f3-7176-08dde4d29d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 18:58:58.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2VVIzc8Sa9ZdQ9CK1Su0NH/7K5LMo2MNhtJWwjbQ/QsUHMuyvFdIJ+apBB79Vp5LuqtlnxL9PbKinutYr+nTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4948
X-Proofpoint-GUID: k9h1LnLOTSTRVfaTnmrLtvzES8zpCmZj
X-Proofpoint-ORIG-GUID: TSz3UpkMGDYahHVgCr1UyqPI5dIrqjhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX4rKQgFVt8G9I
 hWICFWqGdnMafpifIhEi7ojqTt6dqHZRa5OSeMkB8ssSQn8730s/17au91XqpvnSWdmtqCbXnYw
 xYn2axWj675s7yVwgiPgx5OyWcugJOGMD1FtrNCe2SnMZbJ5NYoAqjh736VuNujtO9ryHr3Ry/m
 SFwjmCES6sZ0CwOHEJHuhtpI8Vbr73GpGu9Z/4MF1Sx71UJysTd2FdM7sWcuzsDbfumkMJ8DrRc
 MfQ8WteGkzN6brSF/TTSks2wI+AoYmlTPGINrfxav13pAOjEBE2Fhp3KCNyuCNUa/uRnl0UKShx
 zTrq8JMTpQCqs8QJo6EGHVZ8aupSjdRCg0hJmHSe93u9TnSRCOjWmFrARhqCFAOErzPeWatRUBD
 dzeGVGiC
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68ae03f6 cx=c_pps
 a=MPfW0GtrrVyaQwIB9FVG4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=zb5H4TPhKeK2p3916F8A:9 a=QEXdDO2ut3YA:10
Subject: RE: [RFC] ceph: strange mount/unmount behavior
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

T24gVHVlLCAyMDI1LTA4LTI2IGF0IDExOjEwICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMjUsIDIwMjUgYXQgMDk6NTM6NDhQTSArMDAwMCwgVmlhY2hlc2xh
diBEdWJleWtvIHdyb3RlOg0KPiA+IEhlbGxvLA0KPiA+IA0KPiA+IEkgYW0gaW52ZXN0aWdhdGlu
ZyBhbiBpc3N1ZSB3aXRoIGdlbmVyaWMvNjA0Og0KPiA+IA0KPiA+IHN1ZG8gLi9jaGVjayBnZW5l
cmljLzYwNA0KPiA+IEZTVFlQICAgICAgICAgLS0gY2VwaA0KPiA+IFBMQVRGT1JNICAgICAgLS0g
TGludXgveDg2XzY0IGNlcGgtMDAwNSA2LjE3LjAtcmMxKyAjMjkgU01QIFBSRUVNUFRfRFlOQU1J
QyBNb24NCj4gPiBBdWcgMjUgMTM6MDY6MTAgUERUIDIwMjUNCj4gPiBNS0ZTX09QVElPTlMgIC0t
IDE5Mi4xNjguMS4yMTM6Njc4OTovc2NyYXRjaA0KPiA+IE1PVU5UX09QVElPTlMgLS0gLW8gbmFt
ZT1hZG1pbiAxOTIuMTY4LjEuMjEzOjY3ODk6L3NjcmF0Y2ggL21udC9jZXBoZnMvc2NyYXRjaA0K
PiA+IA0KPiA+IGdlbmVyaWMvNjA0IDEwcyAuLi4gLSBvdXRwdXQgbWlzbWF0Y2ggKHNlZQ0KPiA+
IFhGU1RFU1RTL3hmc3Rlc3RzZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNjA0Lm91dC5iYWQpDQo+ID4g
ICAgIC0tLSB0ZXN0cy9nZW5lcmljLzYwNC5vdXQJMjAyNS0wMi0yNSAxMzowNTozMi41MTU2Njg1
NDggLTA4MDANCj4gPiAgICAgKysrIFhGU1RFU1RTL3hmc3Rlc3RzLWRldi9yZXN1bHRzLy9nZW5l
cmljLzYwNC5vdXQuYmFkCTIwMjUtMDgtMjUNCj4gPiAxNDoyNTo0OS4yNTY3ODAzOTcgLTA3MDAN
Cj4gPiAgICAgQEAgLTEsMiArMSwzIEBADQo+ID4gICAgICBRQSBvdXRwdXQgY3JlYXRlZCBieSA2
MDQNCj4gPiAgICAgK3Vtb3VudDogL21udC9jZXBoZnMvc2NyYXRjaDogdGFyZ2V0IGlzIGJ1c3ku
DQo+ID4gICAgICBTaWxlbmNlIGlzIGdvbGRlbg0KPiA+ICAgICAuLi4NCj4gPiAgICAgKFJ1biAn
ZGlmZiAtdSBYRlNURVNUUy94ZnN0ZXN0cy1kZXYvdGVzdHMvZ2VuZXJpYy82MDQub3V0IFhGU1RF
U1RTL3hmc3Rlc3RzLQ0KPiA+IGRldi9yZXN1bHRzLy9nZW5lcmljLzYwNC5vdXQuYmFkJyAgdG8g
c2VlIHRoZSBlbnRpcmUgZGlmZikNCj4gPiBSYW46IGdlbmVyaWMvNjA0DQo+ID4gRmFpbHVyZXM6
IGdlbmVyaWMvNjA0DQo+ID4gRmFpbGVkIDEgb2YgMSB0ZXN0cw0KPiA+IA0KPiA+IEFzIGZhciBh
cyBJIGNhbiBzZWUsIHRoZSBnZW5lcmljLzYwNCBpbnRlbnRpb25hbGx5IGRlbGF5cyB0aGUgdW5t
b3VudCBhbmQgbW91bnQNCj4gPiBvcGVyYXRpb24gc3RhcnRzIGJlZm9yZSB1bm1vdW50IGZpbmlz
aDoNCj4gPiANCj4gPiAjIEZvciBvdmVybGF5ZnMsIGF2b2lkIHVubW91bnRpbmcgdGhlIGJhc2Ug
ZnMgYWZ0ZXIgX3NjcmF0Y2hfbW91bnQgdHJpZXMgdG8NCj4gPiAjIG1vdW50IHRoZSBiYXNlIGZz
LiAgRGVsYXkgdGhlIG1vdW50IGF0dGVtcHQgYnkgYSBzbWFsbCBhbW91bnQgaW4gdGhlIGhvcGUN
Cj4gPiAjIHRoYXQgdGhlIG1vdW50KCkgY2FsbCB3aWxsIHRyeSB0byBsb2NrIHNfdW1vdW50IC9h
ZnRlci8gdW1vdW50IGhhcyBhbHJlYWR5DQo+ID4gIyB0YWtlbiBpdC4NCj4gPiAkVU1PVU5UX1BS
T0cgJFNDUkFUQ0hfTU5UICYNCj4gPiBzbGVlcCAwLjAxcyA7IF9zY3JhdGNoX21vdW50DQo+ID4g
d2FpdA0KPiA+IA0KPiA+IEFzIGEgcmVzdWx0LCB3ZSBoYXZlIHRoaXMgaXNzdWUgYmVjYXVzZSBh
IG1udF9jb3VudCBpcyBiaWdnZXIgdGhhbiBleHBlY3RlZCBvbmUNCj4gPiBpbiBwcm9wYWdhdGVf
bW91bnRfYnVzeSgpIFsxXToNCj4gPiANCj4gPiAJfSBlbHNlIHsNCj4gPiAJCXNtcF9tYigpOyAv
LyBwYWlyZWQgd2l0aCBfX2xlZ2l0aW1pemVfbW50KCkNCj4gPiAJCXNocmlua19zdWJtb3VudHMo
bW50KTsNCj4gPiAJCXJldHZhbCA9IC1FQlVTWTsNCj4gPiAJCWlmICghcHJvcGFnYXRlX21vdW50
X2J1c3kobW50LCAyKSkgew0KPiA+IAkJCXVtb3VudF90cmVlKG1udCwgVU1PVU5UX1BST1BBR0FU
RXxVTU9VTlRfU1lOQyk7DQo+ID4gCQkJcmV0dmFsID0gMDsNCj4gPiAJCX0NCj4gPiAJfQ0KPiA+
IA0KPiA+IA0KPiA+IFsgICA3MS4zNDczNzJdIHBpZCAzNzYyIGRvX3Vtb3VudCgpOjIwMjIgZmlu
aXNoZWQ6ICBtbnRfZ2V0X2NvdW50KG1udCkgMw0KPiA+IA0KPiA+IEJ1dCBpZiBJIGFtIHRyeWlu
ZyB0byB1bmRlcnN0YW5kIHdoYXQgaXMgZ29pbmcgb24gZHVyaW5nIG1vdW50LCB0aGVuIEkgY2Fu
IHNlZQ0KPiA+IHRoYXQgSSBjYW4gbW91bnQgdGhlIHNhbWUgZmlsZSBzeXN0ZW0gaW5zdGFuY2Ug
bXVsdGlwbGUgdGltZXMgZXZlbiBmb3IgdGhlIHNhbWUNCj4gPiBtb3VudCBwb2ludDoNCj4gDQo+
IFRoZSBuZXcgbW91bnQgYXBpIGhhcyBhbHdheXMgYWxsb3dlZCBmb3IgdGhpcyB3aGVyZWFzIHRo
ZSBvbGQgbW91bnQoMikNCj4gYXBpIGRvZXNuJ3QuIFRoZXJlJ3Mgbm8gcmVhc29uIHRvIG5vdCBh
bGxvdyB0aGlzLg0KDQpPSy4gSSBzZWUuDQoNClNvLCBmaW5hbGx5LCB0aGUgbWFpbiBwcm9ibGVt
IG9mIGN1cnJlbnQgZ2VuZXJpYy82MDQgaXNzdWUgaXMgbm90IGNvcnJlY3QNCmludGVyYWN0aW9u
IG9mIG1vdW50IGFuZCB1bm1vdW50IGxvZ2ljIG9mIENlcGhGUyBjb2RlLiBTb21laG93LCB0aGUg
bW91bnQgbG9naWMNCm1ha2VzIHRoZSBtbnRfY291bnQgaXMgYmlnZ2VyIHRoYW4gZXhwZWN0ZWQg
b25lIGZvciB1bm1vdW50IHBhdGguIFdoYXQgY291bGQgYmUNCmEgY2xlYW4vY29ycmVjdCBzb2x1
dGlvbiBvZiB0aGlzIGlzc3VlIGZyb20gdGhlIFZGUyBwb2ludCBvZiB2aWV3Pw0KDQpUaGFua3Ms
DQpTbGF2YS4NCg==

