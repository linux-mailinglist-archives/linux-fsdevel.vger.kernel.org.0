Return-Path: <linux-fsdevel+bounces-43943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E17A603A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 22:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AD97A7DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ECD1F5428;
	Thu, 13 Mar 2025 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jQgYLuX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C93A8D2;
	Thu, 13 Mar 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902424; cv=fail; b=UA9EN5rRzeU6Cgb4jkuEJAjWpJ1/zlfPlmh+fi4D6V3LjgOPguTWcUburmkLJ5ph0lvMLALEpAaiuP9nlLlx1UyepmbryLp4arJet07rq5VvquFTBaA68u11y+kJUttpd/KYVLx8XHj5jPqR32ethxk24ixMrvEmHJWhD6BYmpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902424; c=relaxed/simple;
	bh=vNL4FUOy4WoI98UxXXMwQ0GTu4WQaRL7cctXq41E03M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=OLS5H5btFRPr7Fiyc/tP1iyauAvGpQpYY/srUPd6JbnZprXjrPnXS3KFakfsJ5IqvY2rfu9o3pEJJ89MmBZqdh9hNjapS5yrc8K5aKuEEQxDtGAiByjSseV45krjVFgAihwAKE5+zBNXxNURWCSPCOhTprZWw/6OYSWZJgDGFdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jQgYLuX1; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKaDgI012251;
	Thu, 13 Mar 2025 21:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=vNL4FUOy4WoI98UxXXMwQ0GTu4WQaRL7cctXq41E03M=; b=jQgYLuX1
	ucesLee36AIJ5lIIVQaG2A8XDIhR2zSl5j+F7W+emBnn/+3zMd9NYgoOWjYeJ43/
	y+Nlb7Hdw1j0jCkW9EB3t4Wa4rd3K4yEBjMU9slKpAT+VFV20ozdcUOPj2m71gY8
	hP8qAZ+pAMpj1QNbXotVHdBASqAZF6P1taLj/+x0YimA59zgUtTcjICwrT/FVQEq
	5qTtd1DqvaRQ0mwpsYPA6fokNHFVka6BBbsKdhmv6VQq570NteG7BTbgI+fgIRzl
	aauXGErMzS0+qcYw07gPhGahpscdA9wnLKO5Fqbqy3dKmMy+KZR9YwI/+pE4gk0l
	oaFsoTsf+6xO2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpr948-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 21:46:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52DLhJm7022350;
	Thu, 13 Mar 2025 21:46:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpr946-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 21:46:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcWs4588VTowK8VKenBZdvOp8zCZSjMdjFkYpk8Vi0hxW8Rx73fTxvatwTBsvxW6El/pImaUJZg1qzCBhmVAQEwkFlcIO9lqq1irml7+gYVAFdBwMit2QTMJOc1rNVZyl4Kykpd2bMi3OrwK2p71jS118cxfvZbJhgmjAGYnAz8ho12ifK+UAB0ySMufFdZ16JwE8B+TNwS8eHa3m7mqhAmRJ2od8wY+O8l9q1+k+pGtSKrLwYoYstkaQQVaSqnNkbJnvthfeZrRO2UlplvZESdiXYz4/rDWc/MWU42j4b2k7/iu/0O+bwnx6f9dqKmztQ+w/oUy6+gThCe57QozWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNL4FUOy4WoI98UxXXMwQ0GTu4WQaRL7cctXq41E03M=;
 b=hOOW7sfO+chhoNokPdY5N7XBJ3KpaOB1b5co/W1+ZVldyvP1iQ1W3cRCaUuJCWXFigWRN2ZE6krv1s7hykRGlKyzt/yf/tL5psQpeCHe5Z+9eX9aQT5/9E5kTobsdWEGMKrb4OngDNy9Gs2r4taKXFR0UHLJ7RH49bxTsY5uv57ThzsQF4zLLX0q8XjMxXCLNvu/XI6PlD2ibgPCe9CRzYxVIem9x+YhjJFJPXiE6QJZN5MQS7WbqRcX6aWT93soC4uQjaEwBiq929l/FTqNMQ01JlBmqxNih6Bf79WTO1HTeQA1dXzsf789eeqeDsU9QB1OECXRDDQZRAHYqaCyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6591.namprd15.prod.outlook.com (2603:10b6:8:1e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 21:46:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 21:46:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        David Howells
	<dhowells@redhat.com>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Thread-Topic: [EXTERNAL] Re: Does ceph_fill_inode() mishandle I_NEW?
Thread-Index: AQHblEw4qb5QIWadgUOmUR4oYTqik7NxicKAgAAQhAA=
Date: Thu, 13 Mar 2025 21:46:54 +0000
Message-ID: <afeb9082273098f47b26371a7e252381d1268c8e.camel@ibm.com>
References: <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com>
		 <1385372.1741861062@warthog.procyon.org.uk>
	 <1468676.1741898867@warthog.procyon.org.uk>
In-Reply-To: <1468676.1741898867@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6591:EE_
x-ms-office365-filtering-correlation-id: d2ee3b7f-6b0f-48ad-19fc-08dd62789251
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejBLMmhLWm9RcjNIODArcWFVSmxaeCs0eitHTWJEOUFSWjNJZFVGTXFkcUhj?=
 =?utf-8?B?Z1ExMEhOd2hNYWh1cmxJTjBKV0JQSEdNSmluQlEvMFhjRWo2QlRHaDZEWVBG?=
 =?utf-8?B?OE5vaU1MWGlMemZzd1M5QTN1UG12c29WRHhDR2xZdXJ5a0x2MUhSNjVsekIv?=
 =?utf-8?B?aGVML1J1VTZvYUgrUjhieXc1em5PK2xwSmNWRS9SRUx5bFZIMUZKWUxIdmov?=
 =?utf-8?B?OGpOZVJJL1VLS0wvUUs0b0RLV3JmRkNjUXYvMWFmSG5LUjBDdXVBaHZ0Yk02?=
 =?utf-8?B?bTBvOWFjYmVBTUlVRWVCL1F0aGdqdU8ydmdGaVBvNEJyU0ExZFZDUVJSVHdU?=
 =?utf-8?B?Tmh6Z2J0bkFlUHFUMnVPSVA1OWVTMWhmZlhyWHJkU05pc3dGNmFkYzBYQVpo?=
 =?utf-8?B?Yll5VHNkMVRXL3pVSlNkN3QxeTJWVEFtY3RGcC9nb2dwbGsyYzlMbkJEZ2g4?=
 =?utf-8?B?eC9PNjh1OGZRTEx2KzJlcGJWK2VvTGM0N0tzbHdIazJUTThJMXBEaUlPQXFz?=
 =?utf-8?B?NEFVQ25wYVYzY2tNSzB1dS9pR3dnTmtzTWVIUnhqZy9WZ0JSMnEzc25lMXYz?=
 =?utf-8?B?ekxpNDkzc01ET3VnVWdPMUpMMmxXRExUOFUwSnN2WVpZUmNuUWFMWWU5RWhy?=
 =?utf-8?B?WnNVeFF0K2h1WWlVSWg3TGJCWWxHVTZkOVdQMEdkZUNRakR4MDdmSzYwcWNa?=
 =?utf-8?B?L1F6TU00RDRIbVZvN2taMUFWOVk4ZzFtNXdYZmVrbUUxVkJIOGFlY00vWDFN?=
 =?utf-8?B?K25QQ3lVaU5zcHJEdmt6akNOZkVaT3FrM21NeVVHTVNEdEtiU3IxM3F5ZE84?=
 =?utf-8?B?YWRXZ0VIVUVlWEJWRjY1cUpkdHR0VkhxYlpwa0hqMHNlTG1UaktvT3RGZGxw?=
 =?utf-8?B?cExYaDJ6U0lYVmR6TjV3ZlVaOUoyNGR6QXB2OHRTZkxtRTNpQzFKYisranpG?=
 =?utf-8?B?QVZzRzNHejV4eTFXN3NnSE5oS0IyODEvVTBIUmNjYjlVR3k3S0x1TEhUMjJX?=
 =?utf-8?B?SGM5VEd0RmFNR01HN0dJam9PVVEwYXFaNjZ6WEJ3Z1NIdWFHTi84N0YyZGZM?=
 =?utf-8?B?S01LcDM5NFpvN3lPQWI2YlFjMXVPcEFuNC9pcGFBcDlxUnlCNnVRWWxVWmlC?=
 =?utf-8?B?MURkSTdueW5HbHdxWW5tVXVOTFBnVXI4aVlVNlg5amJ1MTBsdG8xYytwbm9x?=
 =?utf-8?B?K0VvRk5mQlVBSzJpbUh6Y1FwUEx5KzlJdTJMNUMrd2ZWTll6d0JBSGdaU28v?=
 =?utf-8?B?ZGcyRzcraDhoY2Urd2ZsU0ZhTm5seVdzOXp2bGVzUyszSHNoUnB3NEt1TlMr?=
 =?utf-8?B?TzBlOUkzZXZVb1RtUWhQM0VLcUJlT1g4aGFGbEJFaUQ4bE11eFR0L2lFZkg0?=
 =?utf-8?B?VDN0emhHU3h3M3g4Ynk4Q3FaTWp6S0pkMDhkZGV2UjNiNHRhOFNHUElSeW1t?=
 =?utf-8?B?WWRVbHdSMmI3eGlXVzlEdlpCZFpGOVUyMlV0dmRKS0ZRQTBya2JJYVFSMjkx?=
 =?utf-8?B?QnZJMy9xZ2haV2psVHZhR1kvVXVYcHFUQkE1QkhZYnBJSXZlSmZmRGlPNEJ4?=
 =?utf-8?B?bU5GeHpxSUhqbmJsUExNRUhFSS8zNzg1enRJNG1YcVoyenJucnVEc3VGT1FI?=
 =?utf-8?B?N1c2Yys2V0lvZGIrVGtsRmFiM2xJTXdqSTBQbVIyM3RCNkswWTRLc1JiRUJO?=
 =?utf-8?B?K3prV2sxbTByckxKRDB4Z0lHcVRhRmdkZ0NxcWFJbWl0Sk16U1RFUmhXa201?=
 =?utf-8?B?aWtzNWhjNnpPZVR2MHFpQWxUeERFWmdlMnlLUnV2TDNWNkZnNjQvZFlPNm8x?=
 =?utf-8?B?SUgra0J5eEZlQ1AvZVZrME9rd0Q4R2tHVms1bmVKOW0vY3J1eVFFSW14Q2FW?=
 =?utf-8?B?WnlmZzM0S3JaNGdBQUVEc0lwV1hZR1hQSFhTdzIvMER4a0RPMXFmeUltWVdq?=
 =?utf-8?Q?SGbbt1IE98GWJdYQI5VMuWTQbPUbH17U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0I4c25UZktDcStpem1ScEU2YlVsSmhROFRFVk5DNmVOOWM5bnllMW1XKzBF?=
 =?utf-8?B?UnpSY0hBWFIzMUF0R25NL1EzMnR4QlhxZW9FblowLzJHZXBCZ1BCS3pMREJI?=
 =?utf-8?B?UUlzWGFXVHg3Z09SSUtqTzFXYlNCZTVqbjhjMWxDeWlwU081eDZqTlZBRGFi?=
 =?utf-8?B?OHg2ZmExa0NhM1d5ZGtrT3ArRVhpM3cydTc0RFJWSkZOdDFBMEE0UnFXbVU4?=
 =?utf-8?B?Vm1ZOEpiYkVSR3NyY0FTZVBTS0w3MVBPanFzWHlSaUU0MS9kM0lJV3FYYy9Y?=
 =?utf-8?B?dUd0aG1rYlhPc1lhdFBLY3dJRTRpK2pIbktaVWNEYzZ1TEZ6Y3lqOTNkcGxl?=
 =?utf-8?B?bUJEZGNla3U2VTN1a3NRSW5VcHptWm5tVEVCTS9WNURrZDIxRm5tRnpTeXFi?=
 =?utf-8?B?N1VDNmRnbzJ2UXZuR2d5Y1RsbnBwbUdlMURiUnY1RGo1R2p4N0pSSmtsM2NN?=
 =?utf-8?B?bW8zL2M5QVB4UWV4TFluR01CQjNiamlVU2tNNHdRTi96eWQ3UTFiWlJtS2F5?=
 =?utf-8?B?UVJHb3JZVHc1OEVsaXF5dVZtSklNMEdLMFJ6RnBRc0ZnRzR3MTR4OU1uYlNO?=
 =?utf-8?B?bDJoWTdMbCs5K3h0OFBRUGN6Mzd3a2VuU1BSRlRVZWdVWTVwRENydHBXRTAw?=
 =?utf-8?B?SDcwTTFOQ3MzbW5OWDZHc3NNcXdFQjByUlFqam1GK08yWDRUY05NSlVCb1RQ?=
 =?utf-8?B?UkExc3N6K1YzdElqaS85c2YyeHdIVzdJRGVvYXowcGlqKzBIRW55Tmhoa3JF?=
 =?utf-8?B?QUhCRS9yODBON09kc3F3RzdrZnlRWUFBU3pVMlJ1Njd1OEpwNThUcEZ3amtl?=
 =?utf-8?B?c012bHh0U0cyYkJudFVubkRGNm9iQjc1eGI2Qi9QLzRjcVo1YUhEVDNMTGpx?=
 =?utf-8?B?VVF2ckFlS3VTbG15T0Q4czRHaFlJcmg4TVhvWGE5Nm41a0xkMXJoVlIwaE5n?=
 =?utf-8?B?M2NXVmNIN3oyK0xraFdQYnVOSVNxKzFUcEUzWjhGL3g0Vy9CcUFIUkxzNWJs?=
 =?utf-8?B?Zm9VY0dUNW1ScFB3L3h1RStwWTE2bE1idWV3RnczT2plWXVyaDlwNDlwaXJC?=
 =?utf-8?B?OEdCSzVCTUFab2tLU3BBbEU1c3Zza1cyQWJ0WitEaWRJS3FGN3ppYWxqUWh5?=
 =?utf-8?B?clFXNlFTZXUwTkMvcTNJbDdjSkVtWDVoUzNRMi9ncmFYMjBGSHcyRW1qVU1p?=
 =?utf-8?B?aDgxZHc3bEphVzFUWWd1YUJsQ1V6aWhINXVqcm0wWFZ0aDhSR2Q2UnBLb1lr?=
 =?utf-8?B?cXRlbkhBenNrTVU2TFJXRjFrbDNNWC9reVZoU3plVlkybnZJMWpSZFE1cDJj?=
 =?utf-8?B?aFNqOU9waE1CclRhVHhOVjlSTWM3cjJyL3dneEQyUTAwc2VYMDk2RFk2Q3Ji?=
 =?utf-8?B?UEZlSTFWRkFjZXcxcW5PTzJKZmZYV3I5cy9DbytoYzd2WExHSndLdGdoeUpV?=
 =?utf-8?B?SFBRT09KdDN2WnhQZTM2bk9PU0x3d05ndndac05ocW1Ec0lUcmx2bmlYZEcr?=
 =?utf-8?B?TmNIbTQvQ2NVczh1S2tXR0RJTFFCdUNoSU9oUmZuM0FjMHB3TFJjTG5oK2ZY?=
 =?utf-8?B?a3pNYTV0bFk3em9CT0JUVUhPWnZ6aDZSTHQyZzV4TGNZbHQ3Q04wYU9mbDhz?=
 =?utf-8?B?dktNTmd1QkNUd1Z4K1Zhci84RXBhTlYxK2EwWHdibWZGM0xQMEV3dzhUQUE3?=
 =?utf-8?B?KzlxRStBOUliNk4wL3h1Z2VOamdueWVFeGt1S0hFNFVmS3BBUjFsbmoraW1U?=
 =?utf-8?B?Wk9na1RBeDVLZGZXdlFDK2EvMTRQTDlCV2xBYnpTLzhFZkcrdGIwYlUyLzhM?=
 =?utf-8?B?QUxtQktSRFZ5VmZkdVBYRytKeGM5bXUvYTBzNERIUFJsTDUrbWxKb2ZWdUpp?=
 =?utf-8?B?THBPSHhZeDNtUGhXSU1rbTBON3VySk9TVVNiVUVmU1FnQ281MUNNRGxZbWFV?=
 =?utf-8?B?YWlmSTV5WTBKeXYxK0NYS1dKbnYzcUExOWU4N05OUWxwbmJwTTQ0M0p3bFhp?=
 =?utf-8?B?K1VaaCtLRFpaRys2QVFaVkNhb1pOM0R3NHQvdUlyUXpidE9vRDI3bDFJZjFk?=
 =?utf-8?B?K0NKSVdxbnd5SEdGOFAxblFxNHBrSmN3VENMYXl0Mkora1REYlBKQXdKejJC?=
 =?utf-8?B?bnl1a1czUTJmTFR0b2c5MkY2czVzem1jQS9naXBIR3pVanVOLzRUUDBnOEov?=
 =?utf-8?Q?E04w/t0vh9ZFBD9DoxEzwl0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD1A5E4F38D5E41AC34D9EF8C4CED60@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ee3b7f-6b0f-48ad-19fc-08dd62789251
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 21:46:54.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjNI3oS56giTxmE4yd3306hG+frRkrtAufkD8oQVHf9DEVEWb5Y4yBrnlXT1CmzzBC7X2TwK8hdHKBxsi+y/Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6591
X-Proofpoint-GUID: UMsZr5XwWeTZVUMasyX3_Cln10mP4a3V
X-Proofpoint-ORIG-GUID: OfFamyII9trhJ8fL8pVR_U5B2AGVH-LA
Subject: RE: Does ceph_fill_inode() mishandle I_NEW?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130166

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIwOjQ3ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBzbGF2YUBkdWJleWtvLmNvbSB3cm90ZToNCj4gDQo+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSBt
aXNoYW5kbGluZz8gRG8geW91IGltcGx5IHRoYXQgQ2VwaCBoYXMgdG8gc2V0IHVwDQo+ID4gdGhl
IElfTkVXIHNvbWVob3c/IElzIGl0IG5vdCBWRlMgcmVzcG9uc2liaWxpdHk/DQo+IA0KPiBObyAt
IEkgbWVhbiB0aGF0IGlmIElfTkVXICppc24ndCogc2V0IHdoZW4gdGhlIGZ1bmN0aW9uIGlzIGNh
bGxlZCwNCj4gY2VwaF9maWxsX2lub2RlKCkgd2lsbCBnbyBhbmQgcGFydGlhbGx5IHJlaW5pdGlh
bGlzZSB0aGUgaW5vZGUuICBOb3csIGhhdmluZw0KPiByZXZpZXdlZCB0aGUgY29kZSBpbiBtb3Jl
IGRlcHRoIGFuZCB0YWxrZWQgdG8gSmVmZiBMYXl0b24gYWJvdXQgaXQsIEkgdGhpbmsNCj4gdGhh
dCB0aGUgbm9uLUlfTkVXIHBhc3Mgd2lsbCBvbmx5IGNoYW5nZSBwb2ludGVycyB3aXRoIHNvbWUg
c29ydCBvZiBsb2NraW5nDQo+IGFuZCB3aWxsIHJlbGVhc2UgdGhlIG9sZCB0YXJnZXQgLSB0aG91
Z2ggaXQgbWF5IG92ZXJ3cml0ZSBzb21lIHBvaW50ZXJzIHdpdGgNCj4gdGhlIHNhbWUgdmFsdWUg
d2l0aG91dCBwcm90ZWN0aW9uIChpX2ZvcHMgZm9yIGV4YW1wbGUpLg0KPiANCj4gVGhhdCBzYWlk
LCBpZiBpdCdzIHBvc3NpYmxlIGZvciAqdHdvKiBwcm9jZXNzZXMgdG8gYmUgZ29pbmcgdGhyb3Vn
aCB0aGF0DQo+IGZ1bmN0aW9uIHdpdGhvdXQgSV9ORVcgc2V0LCB5b3UgY2FuIGdldCBwbGFjZXMg
d2hlcmUgYm90aCBvZiB0aGVtIHdpbGwgdHJ5DQo+IGZyZWVpbmcgdGhlIG9sZCBkYXRhIGFuZCBy
ZXBsYWNpbmcgaXQgd2l0aCBuZXcgd2l0aG91dCBhbnkgbG9ja2luZyAtIGJ1dCBJDQo+IGRvbid0
IGtub3cgaWYgdGhhdCBjYW4gaGFwcGVuLg0KPiANCg0KSSBzZWUgeW91ciBwb2ludCBub3cuDQoN
CkFzIGZhciBhcyBJIGNhbiBzZWUsIGNlcGhfZmlsbF9pbm9kZSgpIGhhcyBjb21tZW50OiAiUG9w
dWxhdGUgYW4gaW5vZGUgYmFzZWQgb24NCmluZm8gZnJvbSBtZHMuIE1heSBiZSBjYWxsZWQgb24g
bmV3IG9yIGV4aXN0aW5nIGlub2RlcyIuIEl0IHNvdW5kcyB0byBtZSB0aGF0DQpwYXJ0aWN1bGFy
IENlcGhGUyBrZXJuZWwgY2xpZW50IGNvdWxkIGhhdmUgb2Jzb2xldGUgc3RhdGUgb2YgaW5vZGUg
Y29tcGFyZWQgd2l0aA0KTURTJ3Mgc3RhdGUuIEFuZCB3ZSBuZWVkIHRvICJyZS1uZXciIHRoZSBl
eGlzdGluZyBpbm9kZSB3aXRoIHRoZSBhY3R1YWwgc3RhdGUNCnRoYXQgd2UgcmVjZWl2ZWQgZnJv
bSBNRFMgc2lkZS4gTXkgdmlzaW9uIGlzIHRoYXQgd2UgbmVlZCB0byB0YWtlIGludG8gYWNjb3Vu
dA0KdGhlIGRpc3RyaWJ1dGVkIG5hdHVyZSBvZiBDZXBoIGFuZCBpbm9kZSBtZXRhZGF0YSBjYW4g
YmUgdXBkYXRlZCBmcm9tIG11bHRpcGxlDQpDZXBoRlMga2VybmVsIGNsaWVudCBpbnN0YW5jZXMu
IEFtIEkgcmlnaHQgaGVyZT8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

