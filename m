Return-Path: <linux-fsdevel+bounces-28605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7696C571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0921F2548B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8577E1E0B71;
	Wed,  4 Sep 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1rnCzqe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W6EFEiCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393510A12;
	Wed,  4 Sep 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470949; cv=fail; b=Lw4bGQNJ9swnp6v/g1UzSQgbj+bkyGN1GlHJ8tLv7fh0y3iXO3h3CaEcD+vyAjWglqgjozfmfTSgFcrTAyx2AXmbS9QH4myjrauUlJdpcE0BiKE3MPovQjIsk+yQEA1OQQSj63382R0bDi1bCyZknAJ6eSgBAH/7FWCEBfYNqEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470949; c=relaxed/simple;
	bh=pc2eo530R1b+csNvaW/ufcQYLaL63vju1PDzWSbNEvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eian+oJ9Zvn7XhXt5IXJjTRQSRY4EcJOdDq9QdJ+e/7zOm58EABvoph/7pyQNb5Yx/DaW01f43F1S7vMxBpj95xws9mepWoOZiaNqRWbd6ltHl17Lv08Fv4sYEeHCu6V2Xk9gnPqXPhoTxRoXRcp6PHOQT2I1+GCckw9lORo4b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N1rnCzqe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W6EFEiCb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GtUUC020432;
	Wed, 4 Sep 2024 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=pc2eo530R1b+csNvaW/ufcQYLaL63vju1PDzWSbNE
	vk=; b=N1rnCzqePL0NKKdx8D71bQlv2VJPIL/tJTvpxnAPfORxlNHSO54n2r7lD
	DXhs07zVDq9gYQ5wG+H18/UhhNE4k+hQgzf092XIEYdO8T6kyyn53nDmBoWRch+u
	jDOTiR0lGUW/1BHRZYGRmjF4DRcQbh4bh3eRPomvpPuO/+0TPk8Z4+knEPM0VaY/
	MzlK6eNef4Vs1EkqZjpOl6CvoAhXX1dRHu3YjcKtX0gu6i5CmwNdY9Vl2qBjI36r
	PNUzuChWR6NJnKrqJld++sx5M9Z//WM3fFulR3TTidP4gXs8tCGFg9YD+EjTF4Fw
	IkVHNCoNM8EgmOqJyawh1oGFh05tQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84mu4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:28:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484HBnWx018331;
	Wed, 4 Sep 2024 17:28:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmge7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urzMF6mQaxXNi2EsIdBVFezEOh3QRyi4ov58NxA+R5z5pYL/xVcHPyxVHnL9Gzqhbbq5Y2+tKMsKuf5k/A06otBjjYNh2Pj8kTiD5C0xrtW7e5gsZnrIva/JUO7eRrYW0vonlVYEh/4XdofykfKbi7K8YCGJgMNTldQPrBLFop6CLa2XQK5NYFdapbZvH+sp7pgRIK89RsQQO3A7CazU2FuUoP9ecp1YGy8p8UHydlGPhvvphhLcgFLysSQBJA5LNq0kpCuyePuUoH7ip6rbt+j/8TgWtTceiJcTLpf4OfaL+vlIcgBNJeTB+netSEasqMv0FdokaO5TEOzqYv47/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc2eo530R1b+csNvaW/ufcQYLaL63vju1PDzWSbNEvk=;
 b=qcK2xIhGfzsPY5IgraA+dRETyOQuQPYU4ANSgv8/ptGwoqb/EQuqz6qrDcrHn5bfcypGXaju9bpEmPvHH07BeZnp9L2iGGr+ak7SlMJhh4kiGH7vwxOnkTt1Kss6MSzldXJuxd7/ve70/Et9ojng6m8rnhzPyuOqI/HhLfZIFoIFIe/FkXq8p5lEu/SiHAGm6G3N/fu8kh9GG72vpUPj+9ilx4yNVluLp6WF1uetrebzAl3JSTCWZw+THX7GCaBjFe/i/j1Nk1r3Kpolqr0iQutB7BkJwyHWxvgnBATzXvcUaIvu+IqZiH5U76Gjr+PeEPOGF+UEjo3EcYMt3AHSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc2eo530R1b+csNvaW/ufcQYLaL63vju1PDzWSbNEvk=;
 b=W6EFEiCb4xLvxGq9Z33CeUATr4YaGDkKokxwdS0ojgvun3mgA+EFTgQz87gmPnaw1SExAd5Rq+52GsoBCTZK2xXeRy8LjON7sC5GBqBbu+YoMJOtp0NofaHkhDDG/MVJwoWeirElU1lQJwrp7fLLCMz1azWnhL7NB1VSGYoPO/o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6422.namprd10.prod.outlook.com (2603:10b6:a03:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Wed, 4 Sep
 2024 17:28:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 17:28:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust
	<trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia
	<okorniev@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet
	<corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Thread-Topic: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Thread-Index: AQHa+hcisJ+uiYoVSkuSYBhTQHnQ87JHx6IAgAAbjwCAAAhggA==
Date: Wed, 4 Sep 2024 17:28:48 +0000
Message-ID: <52C563DF-88D1-4AAC-B441-9B821A7B32FF@oracle.com>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-3-271c60806c5d@kernel.org>
 <Zth6oPq1GV2iiypL@tissot.1015granger.net>
 <82b17019fb334973a74adf88e3eb255df4091f12.camel@kernel.org>
In-Reply-To: <82b17019fb334973a74adf88e3eb255df4091f12.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6422:EE_
x-ms-office365-filtering-correlation-id: 81cfde3a-bd97-4306-9df8-08dccd070946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUhucjlUM0NmVXB4TDJPVkx4VkovMitxSzlhVHpkYXYvKzFodzczMnlOS1pL?=
 =?utf-8?B?QTJZcW44ak5USUkwMG0zVUhubXRxdlIwdi8yUWptVzZFdDgwY21pQTk0dkFv?=
 =?utf-8?B?S1VXZnZnVlc3Tm95cFNEMFFRQ01pTm5XSmQzWUtJbFNNUmk5TlozOWh4bGlQ?=
 =?utf-8?B?aitEMkl5TjJvOG1hWU1VbUhUcCtQWFFDb01iSFZJWDJ6QmRXVElSekVZbER6?=
 =?utf-8?B?SGg4cDQxK0ZhSENIOVd1ZmpsU3lMM0p5c04vTE90TjhyaFNlbG1ITk5ZMTBx?=
 =?utf-8?B?dm9vMDJ3T2J3T0czWGtkYzZBdWV3U1R5Q21NRlZpSE43WENCdTEwaEJXUm9J?=
 =?utf-8?B?WTBqekpMM2pEdFBseEdyYnZHcGtRc21UOFc5THU4RVB0MUxCQlBsVkVoOGRh?=
 =?utf-8?B?TmYybkFkODRCWDNTK1BudUl4dUFrSW9tNEM0SE5oWVZNMzhHb2Q5eHV3aWlt?=
 =?utf-8?B?Q3R5RTIrSXRFN1l0WWdObTNpdk9GR2pxZDc1eVlrV3VITjJ5RlZqZVFrdkk5?=
 =?utf-8?B?NXRwcWhndHBGU3BhZnVVcUg3dnF6Vmp6bmJBQXZHekU3YVdTYmdXQVZhc09y?=
 =?utf-8?B?dDVLeWNhUFdSMDFFNTB2dkFMOUg1VEFlZk9LL3U2KytUd2RBT0pCOWtNNFdv?=
 =?utf-8?B?aWRkdksxVVdvU3A2dEFJcFNSRUJRZTNYbEliSHl1Y1ZabXBESDlId0tOeC9h?=
 =?utf-8?B?cGpCT1hDdmhCcnU4eGZtZ2FaZzlZenJhTXdUTUlldWw3T0dMMnBURWpaeUp3?=
 =?utf-8?B?d3ZnZWpBYXcyVjRVMGlXWHRySkJnRzdUdWhaYjVKbTNLbjkydTRqb2lmUWRp?=
 =?utf-8?B?TTNXWDcyRndOQTNPV0w2MmtpSDVRNXRUZks2Zlh2K0Q0WEV1ZTZjbnJ6WjY1?=
 =?utf-8?B?aTFuR3JXQzFOMHU1QUNxNU1rVk50eFprT3B5Y1NKVVpHSGxsN0huVnhmb0xq?=
 =?utf-8?B?c25JOVpwcmEvakpGZFZSNHA2Tk1BM1pzWHZNVGZoei80TVVGcE82TytjbWpO?=
 =?utf-8?B?Tk5QY0tkeHM5OUlKR3NrWFJJZ0VMMVdxejkrZTdvMzNQMVhjMmVQL3JUMEVZ?=
 =?utf-8?B?TE1sb2g5TUtFNmdxYmJYcEpqcTByZE9WVEs1dVR4OENrTXJWejl6TUhtU1lJ?=
 =?utf-8?B?azc1eG5sb1FwTlpBNk1abUxnL215YlU2dTFxVTlSK2JaYXNUMHloRzc3QlZp?=
 =?utf-8?B?VFpKbjFLdmxjcHpoNGhwVHBYSDBtMkI1UHYwbEpLajNLMU0ybkx2VXFFOW9T?=
 =?utf-8?B?VmZDZncveWZKSEZ5WjZreVk0NFZObWJ4Z1ZwV1RMQjRnb3FwVU5BenpVSDA5?=
 =?utf-8?B?elE0cTJkUXhCVEFpa2NqY3QvZGd5QmFwNStZZWVtc2U5TjVVZ21LZkxQRWhD?=
 =?utf-8?B?ZE9GdUJ4RUJyRGljUXk5Q3lxZTdqWGRSQWZGMnNHZCtHM3NRNnlab2QvQm4v?=
 =?utf-8?B?WnppOFN2TFVxSU5NMTVDMmpybC9Cc2IySUMrVU9OOHl5MVdvWlUzRGh2UFJu?=
 =?utf-8?B?WmRhcS9ZcENKeUp6R3pZbHBJRmVpaVRuU0ZLc3QvZ1dCMzlEdHBpR005bnJ4?=
 =?utf-8?B?VkJpQzNSK1RNK1FUMCtCdGF0UU1URXRwSTl3U0RLT1FsU3pGK1BXTDBvYldB?=
 =?utf-8?B?MnZiZ0pLc2EwVmNKRWhPV2pUUXFjR2FsY1Q2MThmWkZYYm5SUzlBRUxpT3lj?=
 =?utf-8?B?NTdNT0ZMdnFBQks0SWdwSnk1YnRxbXlTdUt4M1FSNTA3NzFRUjhxNzE5WVJO?=
 =?utf-8?B?dDhJUVBQTHlXZEkrdllhajIxeENlS0w5NzRNenhMN3p5bWVXRk1oclpOL3l5?=
 =?utf-8?B?cHk2d0VKQjlVdFV4dFlVSUF3Ry9OSlY2bk12SGhqWDMyNjBta29VZEVhRmk5?=
 =?utf-8?B?YUZYKzNLN3JBSVhVS1JCZjRCMlJscTZFV2RJQm5iTHNtNEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUkzZFlnVXV6M2JuRzc2bHptMWpIY2M2UWUrQ2oyUm5ScW1BK3lRaHE5Rk1P?=
 =?utf-8?B?RC93V0JMaTcrQjQ5YXBHcDRRRzcxZWw3ZDlzK0pUOXNvcEZwdXJTMXB4NFJv?=
 =?utf-8?B?WUE1d0ZVQVFJSzR3QlNjVmNEUG1ERDBtdjBtSWNOQTkraVprM3E2SWVpYUJy?=
 =?utf-8?B?MVFUOVQwK08vMUJrdXczNS96bG1QZ1NwRXliZkF4bEJaY1hZY1RXWm5RR1dZ?=
 =?utf-8?B?aVRNM2d1dUtYc2liOUc3RnJyU1NYcG1oN2VxNWovK0JPeTFyNEMxMkV4T1N5?=
 =?utf-8?B?OUo0TDRURERSa2VCRk1XcWUvUnJ6Z1cycTVpR0NxSm9SazNoQms0MWRkbEtT?=
 =?utf-8?B?MUtHbEYxNFJhRURraHRqaWdUNCsxdkhCY005ZStpY0RMek1PRXZwYlFaSmk3?=
 =?utf-8?B?bDRuY1hidUJVK2lPMmtJVUxGTlpSYlRHYXFrSFJLU3JVRWVvWmt3b2I3cXNm?=
 =?utf-8?B?QzlUS0xvVFYxUHpsU3Y5VlhXOVpGQXJ5THNjZlhmMkMrb1FTbjZibGpFQi9C?=
 =?utf-8?B?Sy92UTNpUUgrcE93eFlGVGZ6U0pQWmIwL2FlK1JBdzZrZjAzSWtBTjRVRW5B?=
 =?utf-8?B?Y1IzOGM5NkpQVTIybGZoSEI4Rm1RY1JaVXU4N2dSUEc0TFhJSzFUZ0dUR3lT?=
 =?utf-8?B?Y1MzZjhuUS9lSVBQdzRTckVLeWphTkc0dFNMVGlEZFJkd1pNcllxanlNU1Vn?=
 =?utf-8?B?aThldnROUklpaWV2V2Rub014YXdPWmNCSGdWdUtIYzl5NkltOGVkTWdDamg1?=
 =?utf-8?B?eXd2YnNFa29nU1BYdS92bmFrNzJ0NU9Gc3AybG9PNTliVSt2TExtRm9BZXBm?=
 =?utf-8?B?WloxWCtUWUkyR1lkUThvV3V4NEtZOWxiTW81Tkt3bWFOMjBTc1Qwd0tWTWtI?=
 =?utf-8?B?cDRtS0xReUxweXVvUEZiYzNrYldnazZrSUZwRTVTZ1h6RGtoZEZ6NktWN2k5?=
 =?utf-8?B?NW5KWlNvRzhDaEZxNFBKTldXMUM1a1dlWU0rUWRrWjVFU3RKUi8xMDAvanlE?=
 =?utf-8?B?OVpHYkI5bnU2NkM0bGV2UGNBM1JvQWgzT2VOVHpiemh2RGpDRHRPRXNFRk5R?=
 =?utf-8?B?WnlTbE5JMmpIVzhvNVY1WHBCY2dwWWNESVBCSkl4NUl0YmxrMzdRS1gxUk1M?=
 =?utf-8?B?T0NkYmc5aDRnMDcwWEJQZU4xbUJZaFpncVI0Wlo1WThYa0gwOXlkK3pOZmt0?=
 =?utf-8?B?WXhmVXhiaW14VzRaKzFWU1E5MnBaYitoZ1RnY1FlclI1L3FYTytEQkNoRWQr?=
 =?utf-8?B?Q0U5bVhXRFk3SGZKaXdMQnBZREpzVG5WZnoyU01UNitoZWo5Q1BLaWNZZjY1?=
 =?utf-8?B?K1MyQ1M4NkJ3U0dOUXNiN3hMaitteFZ6dVhSNTBNaDZXNXJPQjRnZFFVZkhp?=
 =?utf-8?B?b1BzUzc5UStnbkJFR1AzYy9HQ3RzeThwMnVTV1pKV0NTMTFva2thUzJIdXdL?=
 =?utf-8?B?Y3duQkh5VjVVV2d3blhlQUdENEp6Smo5aWtqZzR1ckE4MGZYVzEyUnZYQ1Ux?=
 =?utf-8?B?VzFVb1RkWUVsbWtSb1pQVVhzQ3oreTFWUEd5aVY5NEo0VzEwZDVPRHVvYTR0?=
 =?utf-8?B?YUxrTU14TmJXRCtNL3pRN2g5TWZBUStkUUNNc3ROU3dRNWRQeWhpL1ZMTm8x?=
 =?utf-8?B?OERPRHlwNEV1OGtjRElheTUrZmsyKytkV0tyWldCcWFabXRyVDh6V09KTzlS?=
 =?utf-8?B?d3hKN2VHVkRoeTE0TjZKSHVyRVRBd2ZLY3dkeTBVUE9LQ1dQUnhpNXVIaG9R?=
 =?utf-8?B?K2NIdEFXdnV4WWY1dFkrZ2ZjeTNkTHVaTDVZRytBVUhmZVBtc2h3MUY0ekpY?=
 =?utf-8?B?cXZ5WGtNSDB6OG0zSk1CbWU1enRnN0V3QTlxR0NjR2xWNlFxdHNqTitzTFRM?=
 =?utf-8?B?cW0rUkRydyt3bTVWeVhBaTFNUndtUFQ0YTEyakpwR3Z0SUQ1WFN0WUMza1NN?=
 =?utf-8?B?TVczRGlwamdTWEh0T0lzWnVwLzdDaFhDdzBZOHlLS3RqVHh3cUh5OTdmbElG?=
 =?utf-8?B?K3J3THZ3ZUswMlo4d2NESW92ZDZ5TEpzNGV5bjl3YjNKaUtjY2JXWTVHdDFE?=
 =?utf-8?B?eGgwUFdtaUdMSDlQeWpjcHpqZzlsall0RFl5WElWTkJGTlNydHBsR1NzbjYv?=
 =?utf-8?B?NnR0WXgvSCtkUkUyRWx2RmNKYldWZmplNEFrRkdnRlY3MGNmbHNWTVU5emxW?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABB7A67977EFD40A9567C2CB1402780@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BSVXmyLaueTzesWa8cjYba7UW+1PNvFrh+HZsQURCATsMA2gzPa3BASTp6lJ3UsWNKRoj6vf3LieM9hG4ZkZgqkW9BwDUJplwTOW4vnEfUMeT+feZldTK/C6SasYlaOfBNOWK7AVbYplghIJG1drTdssXx+k305zaVdKQ4Qa/HqFr7qBlTE2ecXvA0mmzFbdIRU4W6XpsiZ4PhKjRgdMWxUMJIXilT4wydxEvZcvQhIZ6wXycmFYFTW439wcQQVoROz0RRMvW/2xFqpLwfjA4yA6V+W84X8Bu/ovSTVxZ0P0+8xtC9X++yzrFuOBDMin0DDbwbel+0BxaxNUMr8Y1/h5FRH4nwaUbLE+SB/+ekMrtyYwPznTzadZJuNmXst3738OGNbaIwTc6iuaYzpmNfGwh8ckGdGQoNiQjfadzmQvVGFlvtXlT/v05TienXD6FEznNftKMHY/8NULt+DXnV+ZvGo6uLxmQ1E+FUR7zMl+Mo+VnpFqnFdtvELACzDTWQhb/uTkPYRFIyxG+xt9Lof0z5SgnUah1JJVqp2BdUjZiEr8MUxHwbITm7WqI2yUNHmWTDQP79KvNavUbXZWD1qkaRkqtHaMEOubz2VDnWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cfde3a-bd97-4306-9df8-08dccd070946
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:28:48.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8rDBA4WzKUZStu2usJv8ZmYPTnQWihwsq5Q3x8HpVwa0AAm9/+xIhAnTxKKB/aLQMZTNEuiU0CMjB03W/aYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040133
X-Proofpoint-GUID: xK0Y4CAE_VV3sMdhz7sYh1ljT95bxRJB
X-Proofpoint-ORIG-GUID: xK0Y4CAE_VV3sMdhz7sYh1ljT95bxRJB

DQoNCj4gT24gU2VwIDQsIDIwMjQsIGF0IDEyOjU44oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDI0LTA5LTA0IGF0IDExOjIwIC0w
NDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDA5OjI2
OjQxQU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+IFRoaXMgaXMgYWx3YXlzIHRoZSBz
YW1lIHZhbHVlLCBhbmQgaW4gYSBsYXRlciBwYXRjaCB3ZSdyZSBnb2luZyB0byBuZWVkDQo+Pj4g
dG8gc2V0IGJpdHMgaW4gV09SRDIuIFdlIGNhbiBzaW1wbGlmeSB0aGlzIGNvZGUgYW5kIHNhdmUg
YSBsaXR0bGUgc3BhY2UNCj4+PiBpbiB0aGUgZGVsZWdhdGlvbiB0b28uIEp1c3QgaGFyZGNvZGUg
dGhlIGJpdG1hcCBpbiB0aGUgY2FsbGJhY2sgZW5jb2RlDQo+Pj4gZnVuY3Rpb24uDQo+Pj4gDQo+
Pj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+IA0K
Pj4gT0ssIGx1cmNoaW5nIGZvcndhcmQgb24gdGhpcyA7LSkNCj4+IA0KPj4gLSBUaGUgZmlyc3Qg
cGF0Y2ggaW4gdjMgd2FzIGFwcGxpZWQgdG8gdjYuMTEtcmMuDQo+PiAtIFRoZSBzZWNvbmQgcGF0
Y2ggaXMgbm93IGluIG5mc2QtbmV4dC4NCj4+IC0gSSd2ZSBzcXVhc2hlZCB0aGUgc2l4dGggYW5k
IGVpZ2h0aCBwYXRjaGVzIGludG8gbmZzZC1uZXh0Lg0KPj4gDQo+PiBJJ20gcmVwbHlpbmcgdG8g
dGhpcyBwYXRjaCBiZWNhdXNlIHRoaXMgb25lIHNlZW1zIGxpa2UgYSBzdGVwDQo+PiBiYWNrd2Fy
ZHMgdG8gbWU6IHRoZSBiaXRtYXAgdmFsdWVzIGFyZSBpbXBsZW1lbnRhdGlvbi1kZXBlbmRlbnQs
DQo+PiBhbmQgdGhpcyBjb2RlIHdpbGwgZXZlbnR1YWxseSBiZSBhdXRvbWF0aWNhbGx5IGdlbmVy
YXRlZCBiYXNlZCBvbmx5DQo+PiBvbiB0aGUgcHJvdG9jb2wsIG5vdCB0aGUgbG9jYWwgaW1wbGVt
ZW50YXRpb24uIElNTywgYXJjaGl0ZWN0dXJhbGx5LA0KPj4gYml0bWFwIHZhbHVlcyBzaG91bGQg
YmUgc2V0IGF0IHRoZSBwcm9jIGxheWVyLCBub3QgaW4gdGhlIGVuY29kZXJzLg0KPj4gDQo+PiBJ
J3ZlIGdvbmUgYmFjayBhbmQgZm9ydGggb24gd2hldGhlciB0byBqdXN0IGdvIHdpdGggaXQgZm9y
IG5vdywgYnV0DQo+PiBJIHRob3VnaHQgSSdkIG1lbnRpb24gaXQgaGVyZSB0byBzZWUgaWYgdGhp
cyBjaGFuZ2UgaXMgdHJ1bHkNCj4+IG5lY2Vzc2FyeSBmb3Igd2hhdCBmb2xsb3dzLiBJZiBpdCBj
YW4ndCBiZSByZXBsYWNlZCwgSSB3aWxsIHN1Y2sgaXQNCj4+IHVwIGFuZCBmaXggaXQgdXAgbGF0
ZXIgd2hlbiB0aGlzIGVuY29kZXIgaXMgY29udmVydGVkIHRvIGFuIHhkcmdlbi0NCj4+IG1hbnVm
YWN0dXJlZCBvbmUuDQo+IA0KPiBJdCdzIG5vdCB0cnVseSBuZWNlc3NhcnksIGJ1dCBJIGRvbid0
IHNlZSB3aHkgaXQncyBpbXBvcnRhbnQgdGhhdCB3ZQ0KPiBrZWVwIGEgcmVjb3JkIG9mIHRoZSBm
dWxsLWJsb3duIGJpdG1hcCBoZXJlLiBUaGUgbmNmX2NiX2JtYXAgZmllbGQgaXMgYQ0KPiBmaWVs
ZCBpbiB0aGUgZGVsZWdhdGlvbiByZWNvcmQsIGFuZCBpdCBoYXMgdG8gYmUgY2FycmllZCBhcm91
bmQgaW4NCj4gcGVycGV0dWl0eS4gVGhpcyB2YWx1ZSBpcyBhbHdheXMgc2V0IGJ5IHRoZSBzZXJ2
ZXIgYW5kIHRoZXJlIGFyZSBvbmx5IGENCj4gZmV3IGxlZ2l0IGJpdCBjb21iaW5hdGlvbnMgdGhh
dCBjYW4gYmUgc2V0IGluIGl0Lg0KPiANCj4gV2UgY2VydGFpbmx5IGNhbiBrZWVwIHRoaXMgYml0
bWFwIGFyb3VuZCwgYnV0IGFzIEkgc2FpZCBpbiB0aGUNCj4gZGVzY3JpcHRpb24sIHRoZSBkZWxz
dGlkIGRyYWZ0IGdyb3dzIHRoaXMgYml0bWFwIHRvIDMgd29yZHMsIGFuZCBpZiB3ZQ0KPiB3YW50
IHRvIGJlIGEgcHVyaXN0cyBhYm91dCBzdG9yaW5nIGEgYml0bWFwLA0KDQpGd2l3LCBpdCBpc24n
dCBwdXJpc20gYWJvdXQgc3RvcmluZyB0aGUgYml0bWFwLCBpdCdzDQpwdXJpc20gYWJvdXQgYWRv
cHRpbmcgbWFjaGluZS1nZW5lcmF0ZWQgWERSIG1hcnNoYWxpbmcvDQp1bm1hcnNoYWxpbmcgY29k
ZS4gVGhlIHBhdGNoIGFkZHMgbm9uLW1hcnNoYWxpbmcgbG9naWMNCmluIHRoZSBlbmNvZGVyLiBF
aXRoZXIgd2UnbGwgaGF2ZSB0byBhZGQgYSB3YXkgdG8gaGFuZGxlDQp0aGF0IGluIHhkcmdlbiBl
dmVudHVhbGx5LCBvciB3ZSdsbCBoYXZlIHRvIGV4Y2x1ZGUgdGhpcw0KZW5jb2RlciBmcm9tIG1h
Y2hpbmUgZ2VuZXJhdGlvbi4gKFRoaXMgaXMgYSB3YXlzIGRvd24gdGhlDQpyb2FkLCBvZiBjb3Vy
c2UpDQoNCg0KPiB0aGVuIHRoYXQgd2lsbCBhbHNvDQo+IHJlcXVpcmUgdXMgdG8ga2VlcCB0aGUg
Yml0bWFwIHNpemUgKGluIGFub3RoZXIgMzItYml0IHdvcmQpLCBzaW5jZSB3ZQ0KPiBkb24ndCBh
bHdheXMgd2FudCB0byBzZXQgYW55dGhpbmcgaW4gdGhlIHRoaXJkIHdvcmQuIFRoYXQncyBhbHJl
YWR5IDI0DQo+IGV4dHJhIGJpdHMgcGVyIGRlbGVnYXRpb24sIGFuZCB3ZSdsbCBiZSBhZGRpbmcg
bmV3IGZpZWxkcyBmb3IgdGhlDQo+IHRpbWVzdGFtcHMgaW4gYSBsYXRlciBwYXRjaC4NCj4gDQo+
IEkgZG9uJ3Qgc2VlIHRoZSBiZW5lZml0IGhlcmUuDQoNClVuZGVyc3Rvb2QsIHRoZXJlJ3MgYSBt
ZW1vcnkgc2NhbGFiaWxpdHkgaXNzdWUuDQoNClRoZXJlIGFyZSBvdGhlciB3YXlzIHRvIGdvIGFi
b3V0IHRoaXMgdGhhdCBkbyBub3QgZ3Jvdw0KdGhlIHNpemUgb2YgdGhlIGRlbGVnYXRpb24gZGF0
YSBzdHJ1Y3R1cmUsIEkgdGhpbmsuIEZvcg0KaW5zdGFuY2UsIHlvdSBjb3VsZCBzdG9yZSB0aGUg
aGFuZGZ1bCBvZiBhY3R1YWwgdmFsaWQNCmJpdG1hcCB2YWx1ZXMgaW4gcmVhZC1vbmx5IG1lbW9y
eSwgYW5kIGhhdmUgdGhlIHByb2MNCmZ1bmN0aW9uIHNlbGVjdCBhbmQgcmVmZXJlbmNlIG9uZSBv
ZiB0aGVtLiBJSVJDIHRoZQ0KY2xpZW50IGFscmVhZHkgZG9lcyB0aGlzIGZvciBjZXJ0YWluIEdF
VEFUVFIgb3BlcmF0aW9ucy4NCg0KU28sIGxlYXZlIHRoaXMgcGF0Y2ggYXMgaXMsIGFuZCBJIHdp
bGwgZGVhbCB3aXRoIGl0DQpsYXRlciB3aGVuIHdlIGNvbnZlcnQgdGhlIGNhbGxiYWNrIFhEUiBm
dW5jdGlvbnMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

