Return-Path: <linux-fsdevel+bounces-69930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3AEC8C381
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32B2B4E2B6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB202F0C46;
	Wed, 26 Nov 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9fQZDjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCC219A81
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196237; cv=fail; b=FsmbJW5/4vgG3rbFK+WHL12ZBdSm0DtJHIgzc5Qkmj87YAdLp2YwEjEgPRgNzKpHE0C1rWwbC7dw8Vhe9Tzu8022BhJllESb+pLfxKNTTdBVxoriEPA0VgCGTy46XuK1OINJYZmdMTVPb2j0XhbQHCHq1QUuBEL5rsZwl8uZpNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196237; c=relaxed/simple;
	bh=qCqjan9TE/b6AjyK4ODck6aStG2JQ+hzXphJeBssJkw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UJB74/2/+2gLdNZ7QruS3Ks3LVFpxIKfwIfTX099TWt8oazenD0iGGpTt1BZ2gmvJLFG29NAjiiSnNKhkVq/nvFuUcUwrdH6A6nSZXKQD1Eyvf0uZ4hfuQSZ9UiN2JHXtgZEaXHgvsDxZxXChnpx/sBsQwujt6Z1scCJO6fXPx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9fQZDjG; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQMFgZc006252
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 22:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lg86+uCPwLK4BglEShVSE0ixU9xisd2Dptjao++u8rw=; b=C9fQZDjG
	RpaR7u8V/c3vUXXaCXqOyZj2VSQsW7jloxuo0YMCdv5Vnm6Yr+hyrJ1yjAjHB8r0
	wrVCKkpQ99lgi2X9hwI4/wagX4MSHiz4FqLskRWmyLnFxr0vPLkVi+yvWx5K5igf
	NrfKwX6iSgjulAe/l7FUhxqFFtANsS8Afpilg0mngEW6myj+fF3y/UYwO1p8tOiO
	Xc5TIeEUCon+EHKBVdqn3BDaU9lUi93FArZ+WAhE3e89o92fVK1F9rL8EqgtmNaB
	6R1k1DEMbCNr+BIQElvM/EmTFNioFkX4aS87rwGJ4+yZgJeKFfB2ajXoW6iSvoIJ
	v+F1Eg8DDcX/1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvenp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 22:30:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQMUXx1031126
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 22:30:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvennp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 22:30:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQMUWun031107;
	Wed, 26 Nov 2025 22:30:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uvennk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 22:30:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO3ngnDhYplNuOHHrdb+yABBe4JjQuIU1MlJ4nHU1eJ71bt3QpNen/X2LQg6H2eM+ZC2jw/hYhsm9NuzMJPUGDS0NSvfqYmp/o98u+HXUw7tdDZJl2MZvQj6rTWzQtLpdLCO1ay0PU+93qxJRS/y4PGvqgGxcHboq/e4URxL/bnzfavGkBuUHGTWeeudeePrUP2RFduxk2PWvW0aSwFs7MDOZ8X2ekDEpBNVVjQuElevXMa9iJgs2kLpJQosMyuNDhQhe64YtAJL6RRwkuRg22LWfOiteoh48DTOC92kOfwblHyZNEKWyX7jpKNiKRIi0rs+BY/xON9V08UP+3xQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfgiQwC172PdrsE86ejFvMeF1nKW9JZhW/FkPRKr+Fk=;
 b=gcP2RFFr+4zcl7CLQFRjdKsN7YIwTwp50zEqSx6FABWyg+WMtHo4Wz4nGBn+j++Q7Vawp2UyhnKVRamqQ8cCouYBJUVJHB095Cj3ZfHKcsg4+QjwynpEUz7QchEaz3cwBGiHFLEBY7QlIaxKQkkYuomiHQADocSaJMnjwlz7vWHqRN5/SIib1wuhpRgEigo563AULXLeo/+In86m3wIteoSXyohJtALxyP3Vd4LHbELsQezzoXua5F7bDxzzJB0q1XQD+QyTYHvD0D3KlLb4oINunehBerU6tgZiGA3rSQBSA6PQs7Yu0cEm6/7xgd7lv8NyhCTzsZ3aB1QFSrEygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5924.namprd15.prod.outlook.com (2603:10b6:8:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.12; Wed, 26 Nov 2025 22:30:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 22:30:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "mehdi.benhadjkhelifa@gmail.com" <mehdi.benhadjkhelifa@gmail.com>
CC: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
	<syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] fs/hfs: fix s_fs_info leak on
 setup_bdev_super() failure
Thread-Index: AQHcXtteFGhLPrTb/UieBFUI+djHs7UFH4+AgABrQ4A=
Date: Wed, 26 Nov 2025 22:30:30 +0000
Message-ID: <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
	 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
	 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
	 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
In-Reply-To: <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5924:EE_
x-ms-office365-filtering-correlation-id: 11d16ec9-a84d-4bb7-2e71-08de2d3b67d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDlad2xwRTZxbEthai9ScWg4dERXbFVGM2l6dHh6a1pCY3cxN25sR0V6czBC?=
 =?utf-8?B?YllhZUpudk1kaWRsMWlsaW1KbnJBbEtJa1AvMithdGtESWR2SzRDaEQwT2VO?=
 =?utf-8?B?VEtGdUtHVUVkeHk3djNDY25YUVlqZisvU2ZENitzY2J2OTY1RlBzK1RXVXpW?=
 =?utf-8?B?RXJ4WEEwWnM4RFQwdXVQb0czYWVyS0tBWGExOFhZLy9aYVp3NytLR3lsNWlP?=
 =?utf-8?B?OWF0Zm1MQTRYUXJDaXFXQzR2dld6UXlyVFEwNEttNERCdVo3bHBmSlh2dTNh?=
 =?utf-8?B?R3Z6NGNaNkRJOFZxNFRNbjI0MmhUcHhsOHc1cFpkSEp5S29xTXZXYUE2bXVB?=
 =?utf-8?B?d2NpclF1MG5WVzJYNzUrS1NyRkk2UEZnTzVpQmFHem1XQmkvRHBCU1lIOVBT?=
 =?utf-8?B?dFlTblBtcFl5eEVwY29nM2E1b3Z5VGliMi9xYlZJdG9uZm1XOWJ3UTRDc1dP?=
 =?utf-8?B?Q0gxMXRHRGRJSFhscVpHb0EwN210ZnFBRU9mTU50WmRBZ0lzVU1oRUVIa1dn?=
 =?utf-8?B?OGxVb3lKc3g4bVVNZVE1Z05tZFNUTVVEMlYyM2lOYXRrckEzTHp4b1ZkaWw2?=
 =?utf-8?B?THliQmlEd0RuRlEwcHl1dkVWR2E0ZTNCL3p5aGNKc0RtNGJpOHprWEJTSFQ1?=
 =?utf-8?B?QzJYWGh4MnJpbWtJTDh5djArUmFzdnZ1V0wyUm9mSGM2Qkg3c1BMc0dObGxu?=
 =?utf-8?B?UUsvQ1JTQ2hFa29JWTBCZXZLbXl3d0prS2ZCcnBhajNjRjhWY2RkRmZhcVRt?=
 =?utf-8?B?UHh3enQ5c1FJSmV5Q0FJbk5nUXMwZGxlVDkyTzRFOXBoT0xsMXNmTUpvc0ov?=
 =?utf-8?B?OVFBaFc5OWp0ZGc4Z2ltNDBzL1d2MjlvNXJjQWREUkg2MFlkakpLVkptNGVh?=
 =?utf-8?B?YUZ1RHZhNDltU3BsazkzMlJoSFJZOEpWVE9vZVJZdlFuUDVQSllTbXh5RmJj?=
 =?utf-8?B?a0N2YTVvcDU5b1FyRHRrZVRLRmxnNGRhTjhQVng3VXVNZk94aVZoc0lnMzBm?=
 =?utf-8?B?WWZJMGw0V0dpR3pvZm1SMkRxTTBiWFFrL2FoTVR5S0hpR3luOXYyS2xIdVgz?=
 =?utf-8?B?dzdDMmN0L3A2YXVjRHRMMlRMdytGKzRVYzhHL2d2M3NFZUFNZndEYzkvcVZK?=
 =?utf-8?B?eVpsdUpKcWw4aVhiWUN5NGhLcmdNYW5sNVRKN1FCREpzZ1hIazl1aEphRGhl?=
 =?utf-8?B?VzM5UGZnckVHZTJJYzYwYkpBMU1JNlZJc1RzYXpOSUFvVENuVEljOEozNnhj?=
 =?utf-8?B?QUlrQm14VFl5U0U0SHJsenJBSXBudWxYWGsvM1BDL3ZaNVM5TGpMS1FwWXRK?=
 =?utf-8?B?RDloQzN6Mk85YXFQY1RSN2dKbDhQYUxReU15YXB4YW1lSG5KbjBjbENOY0JD?=
 =?utf-8?B?eUZNZzlBK2FUeXpka1YrcTQxOVJIYkJXNkI1MnJXaDRDZm10QXhwRHAySzM3?=
 =?utf-8?B?MkMwd1pVOHFQdUZLZVQxWU9sUnp2RnBLSVNQdFlETnh5dmQrT0ZsOEhSNlhM?=
 =?utf-8?B?YjFlWkwyaTI5Sm5tdHFkeWtlbTI3UlBoaVoxNittUkN3d1VBRDF5bmRSWGpX?=
 =?utf-8?B?YmxVVld0U2VWdERIUFdoSjlRbHdHOUpNOFNrclFIalpuVy9ueG1xbkhGNy9K?=
 =?utf-8?B?WXNLMm4wUDFMWUlSd0dnbHNrTkJDeFlHLzBSZEhPbzZBSHZhaVRqN3Z1Z2t6?=
 =?utf-8?B?VnZYL2tCeUxBN1pxQnU5c3pvQ2pCTjVEcUZadHZBb0R5ZS83eW5kVkxodENZ?=
 =?utf-8?B?KzZ6QUY3UzA2czR5SW9VN0JKeGwrMklGVmIrRk1ldkprRHFIeHRZalcwTlF5?=
 =?utf-8?B?c3ZVWms4anZoT0NkVVJJU3FId1EzcmhZc3FDUWNpOU9xeU90VGFSM0dtZlB4?=
 =?utf-8?B?ODUxZkNWcm9MTytscXY3U0hkWjdDdm9GZkZnaW1JN3EyVmNzZWlNV3gxQnp1?=
 =?utf-8?B?a0lEYjhJaGNRS054YXBiYURNYjQzODA4OE94SEZKUElUQnF0WkRMV3NYMDht?=
 =?utf-8?B?M3BxdTBMMVh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHBERVkrQlBjeHVacHZtNkZ0TG9HdTlLWnF5QjdCRXQ3RzlBK3VZZXNJMWRF?=
 =?utf-8?B?b0FYMks0dG1Ob1JSeTI1eEV5SFYxV0poYVk0NjNKMUxjNDhpSFVNSGhqVXEy?=
 =?utf-8?B?UDVkS2dNZ2JJWGd0QnltUjN1aEd1eWFRU21BWUptS1NML3VodjNsWitHZW85?=
 =?utf-8?B?S3pzMm1HV1VwRE1DYWNFSkcralRjUTdjb1B5UExjNUwvZ1NEZEpqRjR3aHg0?=
 =?utf-8?B?ZzFFcHBjVWUwMGxDY0I5VWlqQTNzbVlmOW1GZjIvbmJ0S1ROQVRiOCsrTmFa?=
 =?utf-8?B?SDg4cHl1WDV2aURBTU9UclRtU2NwNVhwUmRYNXpxak00c1U2Vm51cXQwWmRJ?=
 =?utf-8?B?M2ZLc0tFNXF2dU0xZ1lqaGxvU3NaUFlua0o2UlE1K2lrNVIwTVZtTk8yVmMz?=
 =?utf-8?B?bEtEUVZnQzBONzRxTUx2WFJLbkZ3TnNYcHJ2TDlLOFBSUWQxNTliYXZIQ1ZM?=
 =?utf-8?B?MTlWMVVkMFNXUXcxYXJqTk5zWDM2TzdWY2JXRHg5blppWGZqdXd1T0EvYytQ?=
 =?utf-8?B?RmhMdHNVditONFAzOTVrZWRBQmdNNHVSR3QvRWdCRVBqSjVMZGZXOXdqQ0ox?=
 =?utf-8?B?YThCd1lIS2pJSUlOMXY0N3pSWGZPdTFFYjQzby93QWRkYi9rRXJOejlnMER5?=
 =?utf-8?B?bDRFRS9kaVl0b01aekZUMTJMSCszZFBVQVZmQU40bVd3WmtwRTRSWHVkMDNB?=
 =?utf-8?B?QzYyQmdxRFVPUE8yakllQkg2K2xKZ3d1Vy9VYVFPd1NLUGpFYVA0WGZuZlIw?=
 =?utf-8?B?Q3BuRmdJQlZ4RWlYTEM4VjZoUytCYzhGaWZPRUVLOURIS1Y4alU4b3JQQWhN?=
 =?utf-8?B?djN5NU9hSmwyZ0hRUUNtNmIvNkhMeEVwMDFTYmo5M1VqM2FPWmdYUUpzbVNB?=
 =?utf-8?B?aVJONzllVTRXZVlmY2JkcFRhaWVSU2hPMTQ1VVN5VEpob0dJZURuSElvSlhx?=
 =?utf-8?B?RUwrNWdaU1FsdDZZTU02NExDWVpKdWQrYzRDM1MrSGZGZlRqSEc0bWIvdSs1?=
 =?utf-8?B?NEFHdVJrVWUwb0EvTGpTS0M3WndBL3lHOVpIcTUrZGJZbnhaQUE4WkxMa002?=
 =?utf-8?B?MzAxaDdoSzBjakZ3UFVRejI4ODAxcDNjc29sZklYdU1KeFdzZTdINEFzWmts?=
 =?utf-8?B?SnZFU2dBZTEydjMvRlF3TE93YmdIcFJrTVYyRzFaZkxpQ2hkY0xuTkFJbkxP?=
 =?utf-8?B?cEs5cm8wRGFuVUZMVHJVaVZNUno5cUhSRE5IUVFtNEl5dkNqR3c1andhWHJK?=
 =?utf-8?B?a0lhODFabGNjYlp4Uy9LQ2laZ1NEbUVyV2RlLzZ3eGVSWnVGbC8zTkdyeGRt?=
 =?utf-8?B?bHhUNHJLTzFUMFRmdWVnbFFBbTlkSW03V3JDSDhjZU1zSEFIVDlDTXBod0pR?=
 =?utf-8?B?ME1qMUplY0tWeDB3bVlIMCs0ZnIzT2s0OU9ZcXBIZHdpRFBaeEFFSmNVYjgv?=
 =?utf-8?B?TnJhdFRnb0gzV0Rac2VJUFFlSlU0MVU0S3VadEdnM3hUNktQaEd2V094U1M3?=
 =?utf-8?B?K1dIQWZpdWxZTEx5ZXJhL0dDRS9majdJVHdhYllJOHBuaEtuTkhzYS9Mdll1?=
 =?utf-8?B?S2VTbEhkZU9EdFN2T1pGbVhJK2htYnV1QXZBSU5jOHVlc0tMYVNqazZwaSsw?=
 =?utf-8?B?SEJtSWdFRDBNVHNydDYwTGhHVzFzTG91YjA3OEgzb0c0SHZjM1R1VGdHMStY?=
 =?utf-8?B?ZGRVVnl6L0JYeGNkaGsvQ1BYNWczS3dOTTdUUjZ3Q0J5bUR1TFVGZ00zYjEy?=
 =?utf-8?B?RkVVdmRsTGNRZlB4RmEybUVlR1A2RlhSSEJLSEk2Y3NFR0N3QmUvWGNWRSs0?=
 =?utf-8?B?Z2dmOStZTjVhaDVOdEE0eDBUQno1Q25pd0puTi9KMzlwOFVUT1pWNHgyUnhH?=
 =?utf-8?B?YjhIZmVtbXBoUEZxdm9jR1RadUxFMXA1WFU1QzlrZkFxei83NjcyaWkwQ0FH?=
 =?utf-8?B?NzhDdWI1dHhhVGtzUW1DQVFFYStRMEptV08vbVdwY3JMUldMUENmV284K09o?=
 =?utf-8?B?K3g5ekVzTzJGa2pxV3JoWm9wSTBseVU4dktzUUhOZmo2aTF0T3NIMFR4dmZS?=
 =?utf-8?B?RTJFNEZ1U0tvR010Q0d1OElEVGZCSHdXcWt4Z0p4alBrWXVzN2FFaFFMZ0lY?=
 =?utf-8?B?N2pOZWlTQ1gwZjRtRGxxOGpMbW9GajVXRG83RFJreDNGSlVmREhXM0hhVUxj?=
 =?utf-8?Q?xFnmXpY8fUbQQoiCIGuB8O0=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d16ec9-a84d-4bb7-2e71-08de2d3b67d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 22:30:30.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1FDdyC0xvutaaDmOtrYkQF26VlWDhRl6SPfkZv65UwF543xLeoy2KO+y7AsPQ38kghEFm4j1QacKuXjLPnfmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5924
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=69277f89 cx=c_pps
 a=gDBu5PZszbgJPyH+JdeeiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=drOt6m5kAAAA:8 a=9KaIn4Nrh0W4s1UZne4A:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX/niueee/s20D
 zBt3n886oxVHV1Hx6qjNI3NUHYraXxru/zAl23ViJVblr/zkskO/aHn6MtEMpFQmwqgoyd+ibJP
 4Y9VrPjozEu8Alc6ASziMNjafy+8/nZElNd3AE+tcDkrTuPBsvJpkcZARuUZyY4IMpQBj/BKGuz
 jokX3yjU5w9t4Iw4Dn7lI9bqubeomTV2pLp/GGwqcV/mIVLJQwcPV923KhcIsRSO4zdG/sTFx7q
 +YLuxKbQmvKf2L6AaYZwmzexlgFTMjYcUyYsXgzUGhO+DlhzIidSUdfoYvYMkaP8LprT+k7JGGI
 thE+VX0GoGgbVyvOhXd7gK1b3/LRw8SDdeJeI/XVehB7pg/Qtxud+bsdkIKjapnRz5ecfxANNBm
 CRjNIK3Z8sbA4AR1umLWD1tP9qoLrA==
X-Proofpoint-ORIG-GUID: RcIutEcWPdVwLn5eH0oO_4wI9RceeHWK
X-Proofpoint-GUID: jp8XP0zMVLsufu0RDy_XBURi_WUZS-5-
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C5607354B1DFC4C99E40C6A3B88163B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511220021

On Wed, 2025-11-26 at 17:06 +0100, Mehdi Ben Hadj Khelifa wrote:
> On 11/26/25 2:48 PM, Christian Brauner wrote:
> > On Wed, Nov 19, 2025 at 07:58:21PM +0000, Viacheslav Dubeyko wrote:
> > > On Wed, 2025-11-19 at 08:38 +0100, Mehdi Ben Hadj Khelifa wrote:
> > > > The regression introduced by commit aca740cecbe5 ("fs: open block d=
evice
> > > > after superblock creation") allows setup_bdev_super() to fail after=
 a new
> > > > superblock has been allocated by sget_fc(), but before hfs_fill_sup=
er()
> > > > takes ownership of the filesystem-specific s_fs_info data.
> > > >=20
> > > > In that case, hfs_put_super() and the failure paths of hfs_fill_sup=
er()
> > > > are never reached, leaving the HFS mdb structures attached to s->s_=
fs_info
> > > > unreleased.The default kill_block_super() teardown also does not fr=
ee
> > > > HFS-specific resources, resulting in a memory leak on early mount f=
ailure.
> > > >=20
> > > > Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
> > > > hfs_put_super() and the hfs_fill_super() failure path into a dedica=
ted
> > > > hfs_kill_sb() implementation. This ensures that both normal unmount=
 and
> > > > early teardown paths (including setup_bdev_super() failure) correct=
ly
> > > > release HFS metadata.
> > > >=20
> > > > This also preserves the intended layering: generic_shutdown_super()
> > > > handles VFS-side cleanup, while HFS filesystem state is fully destr=
oyed
> > > > afterwards.
> > > >=20
> > > > Fixes: aca740cecbe5 ("fs: open block device after superblock creati=
on")
> > > > Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad45f827c88778ff7=
df6 =20
> > > > Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.c=
om>
> > > > ---
> > > > ChangeLog:
> > > >=20
> > > > Changes from v1:
> > > >=20
> > > > -Changed the patch direction to focus on hfs changes specifically as
> > > > suggested by al viro
> > > >=20
> > > > Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benh=
adjkhelifa@gmail.com/ =20
> > > >=20
> > > > Note:This patch might need some more testing as I only did run self=
tests
> > > > with no regression, check dmesg output for no regression, run repro=
ducer
> > > > with no bug and test it with syzbot as well.
> > >=20
> > > Have you run xfstests for the patch? Unfortunately, we have multiple =
xfstests
> > > failures for HFS now. And you can check the list of known issues here=
 [1]. The
> > > main point of such run of xfstests is to check that maybe some issue(=
s) could be
> > > fixed by the patch. And, more important that you don't introduce new =
issues. ;)
> > >=20
> > > >=20
> > > >   fs/hfs/super.c | 16 ++++++++++++----
> > > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > > index 47f50fa555a4..06e1c25e47dc 100644
> > > > --- a/fs/hfs/super.c
> > > > +++ b/fs/hfs/super.c
> > > > @@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
> > > >   {
> > > >   	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
> > > >   	hfs_mdb_close(sb);
> > > > -	/* release the MDB's resources */
> > > > -	hfs_mdb_put(sb);
> > > >   }
> > > >  =20
> > > >   static void flush_mdb(struct work_struct *work)
> > > > @@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *s=
b, struct fs_context *fc)
> > > >   bail_no_root:
> > > >   	pr_err("get root inode failed\n");
> > > >   bail:
> > > > -	hfs_mdb_put(sb);
> > > >   	return res;
> > > >   }
> > > >  =20
> > > > @@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_cont=
ext *fc)
> > > >   	return 0;
> > > >   }
> > > >  =20
> > > > +static void hfs_kill_sb(struct super_block *sb)
> > > > +{
> > > > +	generic_shutdown_super(sb);
> > > > +	hfs_mdb_put(sb);
> > > > +	if (sb->s_bdev) {
> > > > +		sync_blockdev(sb->s_bdev);
> > > > +		bdev_fput(sb->s_bdev_file);
> > > > +	}
> > > > +
> > > > +}
> > > > +
> > > >   static struct file_system_type hfs_fs_type =3D {
> > > >   	.owner		=3D THIS_MODULE,
> > > >   	.name		=3D "hfs",
> > > > -	.kill_sb	=3D kill_block_super,
> > >=20
> > > It looks like we have the same issue for the case of HFS+ [2]. Could =
you please
> > > double check that HFS+ should be fixed too?
> >=20
> > There's no need to open-code this unless I'm missing something. All you
> > need is the following two patches - untested. Both issues were
> > introduced by the conversion to the new mount api.
> Yes, I don't think open-code is needed here IIUC, also as I mentionned=20
> before I went by the suggestion of Al Viro in previous replies that's my=
=20
> main reason for doing it that way in the first place.
>=20
> Also me and Slava are working on testing the mentionned patches, Should=20
> I sent them from my part to the maintainers and mailing lists once=20
> testing has been done?
>=20
>=20

I have run the xfstests on the latest kernel. Everything works as expected:

sudo ./check -g auto=20
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc7 #97 SMP
PREEMPT_DYNAMIC Tue Nov 25 15:12:42 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 22s ...  53s
generic/002 17s ...  43s

<skipped>

Failures: generic/003 generic/013 generic/020 generic/034 generic/037
generic/039 generic/040 generic/041 generic/056 generic/057 generic/062
generic/065 generic/066 generic/069 generic/070 generic/073 generic/074
generic/079 generic/091 generic/097 generic/101 generic/104 generic/106
generic/107 generic/113 generic/127 generic/241 generic/258 generic/263
generic/285 generic/321 generic/322 generic/335 generic/336 generic/337
generic/339 generic/341 generic/342 generic/343 generic/348 generic/363
generic/376 generic/377 generic/405 generic/412 generic/418 generic/464
generic/471 generic/475 generic/479 generic/480 generic/481 generic/489
generic/490 generic/498 generic/502 generic/510 generic/523 generic/525
generic/526 generic/527 generic/533 generic/534 generic/535 generic/547
generic/551 generic/552 generic/557 generic/563 generic/564 generic/617
generic/631 generic/637 generic/640 generic/642 generic/647 generic/650
generic/690 generic/728 generic/729 generic/760 generic/764 generic/771
generic/776
Failed 84 of 767 tests

Currently, failures are expected. But I don't see any serious crash, especi=
ally,
on every single test.

So, I can apply two patches that Christian shared and test it on my side.

I had impression that Christian has taken the patch for HFS already in his =
tree.
Am I wrong here? I can take both patches in HFS/HFS+ tree. Let me run xfste=
sts
with applied patches at first.

Thanks,
Slava.

