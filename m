Return-Path: <linux-fsdevel+bounces-44654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1198CA6B02A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AAA16E43B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D022A1EF;
	Thu, 20 Mar 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmkAfInM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B01B6D06;
	Thu, 20 Mar 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507308; cv=fail; b=f0C9735gkNtwutdHAdYOoi2Qz2FKlDA2NH7Fp5Afg+h5bs+gGjymdWxWdLTlUdr5dLYMxhYOYUbDcUKnEJXlLzo/GEkgl/Q+UcQzRjI8eo1cplIe7k90vJplSlvh2fLTTn1T/Ieiwa7GVtJZoSI22A1DlAuNDH7kb1Jj+EypZBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507308; c=relaxed/simple;
	bh=ZUhXprwYTqTkJlUx0pehaBAMG+hm6jLMscotjr4/ot0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SdY4hdg3AuXApw27yB+2hDcekjm4YW8LhwCd2JW+4353hw2hi8hSVUAW3ULnhxe3wR8TX+yJS/gyfE5n/EpWpgEuBE41efumunhLKmknLAVkggl6eAPRvIUGlZzpOhvZYD7T4hOSoRSVVQDjO/5XNtW6DKOFaGDdqXaa8CjQK7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmkAfInM; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KHBatF023453;
	Thu, 20 Mar 2025 21:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ZUhXprwYTqTkJlUx0pehaBAMG+hm6jLMscotjr4/ot0=; b=bmkAfInM
	g+pLOiOsRXKTvkKYzYBNs+ijiinyodhctJ+vFFDb53359kSqVkZmL0zicY6yc8tS
	oSM+YS1LB5guNCtJa4/e7ODxRmWEe7EuTxqqC77qAKZ2/85IflUvlojJoog0S8Nk
	IgLYN4ynzBqQcL2xrGlHg4MKKMZkmjUB80ViUOoQ1IAj9RZ5n//IBT+YcYMI2sWl
	dqO200qxfdlgXQS1AMFb84y0pdwwPpJGSETxU5NVs4SnVSdohv3OspC08AKfQRW4
	+k4L+akspaNUeI4O4PbToWGw9DeiCOHKvJNbMTmGL8Mxmwje4c0SzfRpu5lsEIh7
	uzE2JxgCj7ZPHw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gq6w19gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 21:48:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52KLiDZn002168;
	Thu, 20 Mar 2025 21:48:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gq6w19gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 21:48:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc/SlLOJ0UsYEEfz/bJS3WLo51Bqy5dIkOpmkwFiMIu570BTUnSKsnZ5nmS//qy5JWgMJUMbi2I9SbokD3sekDN7HdMX0HbZMPYk2G4gnqCrUqX4yaxIcpj+G8HyD0sycc2l8GXO3bloJmDWjt0ljnot+DQO44JuXlbJsELL8vkGBpUCwVVZbYQE7Bog9twq865gOUtKjqZsWigQnf34ncL1EvFmTWNZN759TXekYXRK6qk3iTQIEkS7FuhBNjeaLb8i4UIYTgm3KfW2DoH1EJwruSSmCkfBllm/v2sT1/I5jlKuETqikCkNC4OP2+nY7DQu3b2gkKuMRW5Hm+qSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUhXprwYTqTkJlUx0pehaBAMG+hm6jLMscotjr4/ot0=;
 b=KPOUOsxSB+N3/sUBGf6AMDnLSO6TWGC80iWs+dzXG7Vjsfb7WCYv/UEQybi/TfLSBxmrTJXRwA/MN+1BeItrX9g0cpv8vBrZ+icCmOf+mZSUFcVZ1jfDt48fR0tjL7KTdw1NkuNZ0TtsfLF0rSCBji0Nw4xuc3kQi+/h+Laq/dnjbi4xuwR8P7v3o+22PyLHD/fZHjrHUD/cfuv3++7F/X/FXi33u7/9/JkI6OC/msgy3tNfYZVA8OYAX9mpdMlUSIL607FK8cinBWFkRgMFFC73Fb2Dh//JI2/HJ4Udu7LQwflYp/sGSOT9QkgkWhN/k86Q9h/NjVSutztm2N/IyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5304.namprd15.prod.outlook.com (2603:10b6:303:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 21:48:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 21:48:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        David Howells
	<dhowells@redhat.com>
CC: "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Thread-Topic: [EXTERNAL] Why use plain numbers and totals rather than predef'd
 constants for RPC sizes?
Thread-Index: AQHbmajBegOr1HhNAUqF+X1TOwSF87N8kDQA
Date: Thu, 20 Mar 2025 21:48:06 +0000
Message-ID: <c61e6b608f5d5537bb23892be27a52c92e1bd85d.camel@ibm.com>
References: <749dc130afd32accfd156b06f297585a56af47f3.camel@ibm.com>
		 <20250313233341.1675324-1-dhowells@redhat.com>
		 <20250313233341.1675324-24-dhowells@redhat.com>
	 <3172946.1742482785@warthog.procyon.org.uk>
In-Reply-To: <3172946.1742482785@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5304:EE_
x-ms-office365-filtering-correlation-id: 1a9f8d59-cb5c-4e02-6450-08dd67f8e637
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUJRZUZnSjJYRVdVbjh2SCtlTk1hL2t5TVMrbkRCL3BXUWtyVHNtdkJiYnBN?=
 =?utf-8?B?R0hHcm8xVlo4bmk5S2tudm5zYVlFQ0F4Rk1xRW1oNkNlK0lBd3pwMGhubVJY?=
 =?utf-8?B?SFN2ajNhSC9GS09oOUljZGpVOFBzbnR2UWZCL2x0andJRmdRL3lqbTI0N290?=
 =?utf-8?B?b0JCYk9FWm95QnhFQm11aitLN3NIdW9FZ2FMTVhzdzhGejQzNHlrd3NIcXNj?=
 =?utf-8?B?cmN0ekJ2d1lFRHdPRWJEWEp4Y1dDV1ZjZVo0bWVhRGZLS2FLVGhWdDFwN3Nr?=
 =?utf-8?B?clJ1UjlYSTBPQnNxRnliUW1jMkJOUGhNQ1BMS1gwZjIyRGNteWhIaGdUWEdp?=
 =?utf-8?B?b1lmQUEwSHNYcHlnYWJIdVlGc2R1NFJmL3FTWHVVendNbGdRZTA5V3Z1YmdV?=
 =?utf-8?B?dURwUjUzVVIwb2lwa1ZQeS9mWnoxNkpMam5jYXBDbTg2WnRuZTdtZnBNanNI?=
 =?utf-8?B?YUhFZlBQTnY2NGQwZFJhNXNnT3hwakg1clJvN3pNM09ZSzJBVkIvYUZZL1h0?=
 =?utf-8?B?ZFd6cUtpZ0tNeHU4VG1DUUJQY2ZhVko5THVxM01QdlAvZXluVnBSUjFhemd0?=
 =?utf-8?B?VXhlald0ZVlsRkN4aXRaa1Jyc0JSbjhpSzlmSFVZZDJNRlR4bEdaN3ZuL0l3?=
 =?utf-8?B?a3krSk9VeHhIQUZscUE1ZnlpK2JnLzM2Smg4dlhCM1pvRTl4b04vQXFaMG9X?=
 =?utf-8?B?MENRbzBDOW5zckhrU3UybHdLeVdpdytzUk5NcUVsMDE1aWVvc0ZEeUErNDBB?=
 =?utf-8?B?enJLeWFtWm1CWTBvVktReUJjYTYzQ0RsOVNzeWFRT3RoK0UrV0FzYjZCZHM5?=
 =?utf-8?B?VlIwcCtncUNETm1YaC93RDlMaUFFRERlMXMzNUhtbUg1TXF0by9LSjAyajBa?=
 =?utf-8?B?S2g1UlFkVjczdmwrSGwzejAxWXBxU1htRC82WTRveTJaTHZ0LzEwUXo3SXdT?=
 =?utf-8?B?QXJ0Z05QVXpIWUZGdXRYNjVZTm9pV3REY3c4b252ckxuSTY2QTFuRGpxS0Zr?=
 =?utf-8?B?Mm5DOTh5MkEzcmJyT0V1V3BvWmp0b0JVUmdrTzNLdGpwaFpRZmJGREZYSE9B?=
 =?utf-8?B?Y0kxMnVta0lSeHhERFhBaGhrNGpoaVJCbkhZNjU3QmVnNG55NDhDVG5ucXZG?=
 =?utf-8?B?SDRwMitNUTlRR3dUUUZOa0tGcnM2dFREaXNITWhDWHBqWUN2UHRvd2xBdGJI?=
 =?utf-8?B?MHhkMGFtNzNNalFEZ3h3VEk2VjNlZ2F2eS9ydmdHNllyd3ZySlMxZ0J3OHVU?=
 =?utf-8?B?R0tCTjE4SmdxTlB2ekRoYkZTZTFUa3ZzY3BRSGhYazRaTGp6VGpUZkNvRWor?=
 =?utf-8?B?V1AvZ1h2T2xYTS9SaW5ndFVVOXBEZEFiOFJzUnBrRnlyZjQwWlY0d0gyUkl4?=
 =?utf-8?B?cmpGZDhwMFRkVmVabU5kajZpYkZWeDRxcHM1ZE94QkxDQWM0SUNranNZbEVT?=
 =?utf-8?B?bUE5dkJsOWZIK1RjSGU4bjBERVZPa3NHQ3dnc3UzVndqZFovV1ZhS0kxUU9G?=
 =?utf-8?B?cjdlaGtBczExN3lxTnJvQmEzMHcrQWRwYjJPTmJVbkRydm94UVp2UkI2MFR0?=
 =?utf-8?B?K2QyMlJXSjZLbGtnL2k4WWUrclJ1anp6UVZDdVRGMzkrSFliOUxSRkhkQjBT?=
 =?utf-8?B?akdER0w5OHFKWkNWUkdDbTdZbE9ZSWVTa1MxUHlqZ3YzRXJIZGYxQVB0bVJy?=
 =?utf-8?B?NDlwK3NJU0lIak1TUUdnUWdWeHBJOHRMd015OGJPblM1aStNcFc4Vnh0YXlo?=
 =?utf-8?B?YzMya05DVkY5SFpLRGpXMDEzMWV2VXplSm5sMGMwa0JWaGM4ODQ5R05FZmR3?=
 =?utf-8?B?eGxQQ3dwRkxvblJvTldGb0tja3krRWRuZndQb0NLMWNmZUpseGFSc2dkcEJX?=
 =?utf-8?B?TTgwWVV0ZzBxbHdnNWIzUnZFak5PRnZ1aGNSY0ExMlYxVUUzNUFocWJoaGhI?=
 =?utf-8?Q?MJHEXTBuYFOqpkDCNyCR178vI7S2t/nU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmZmcnc1R1htNW9XLzNUWXB5a3VVVEtabjFraGZVbXNYVHZLdmZuQWk3Ly9o?=
 =?utf-8?B?ZndVYys2WTdLdlZWVlJFVjFBMUt6QjVMaXpzK1NvSmJhNmJ2dTBad3BsR3V3?=
 =?utf-8?B?NFN1UzFQazc3cldxY282d2N3amR2QmtBMFg5N3RqTHV4QVpBUXowVjk1ZmNr?=
 =?utf-8?B?bGEvUTM0aHhQY0NXbzdUa1dDWGg0azYzVVJVdFlHMFppVk53TWREQ3BUTUtn?=
 =?utf-8?B?WHVDV282eUtSSm5STGlVTlB6RWI1SnNXUzhDL2VaOTBVazNYdkRQYWd5M24v?=
 =?utf-8?B?OUFaYnVXWjlDS1hXWTVUTXZaU2tnWkRMR25RS2FiYkdYK3Z4K2xMMXdZUVlV?=
 =?utf-8?B?OCs1RVF2YVdYekFCazdVS1FsOEJOQWIwRjAxRm4xUXJCa2orcHBxTE4yWXRo?=
 =?utf-8?B?NFRzSHpLbG9YQitCRUh3eEJuK3UwelczZm4zR2pGYWtObmdSNFJDWkJFd2FZ?=
 =?utf-8?B?Um5xZ0cza1VmSjhUekZMemRyQzhiS2hsNzFuYmhZckQwN2pBbzk2REhVdDY2?=
 =?utf-8?B?NDhGclhWNGZ3anNkR1lacVRGQ094cG9lYUlNYkZTMi96T3MvSkcrWE5YTVBv?=
 =?utf-8?B?NWVwUUdXTi9hV2JLV0tXQ3Q5MEJqM3JUVmc1REUrYzdpLzU2MWVRUitWdnVN?=
 =?utf-8?B?Zm5pWnZUcWRHMmJXYzNXQkJERHZWcFhUU2Z2Mlh0ZVhKSU5qbEg0ZjhHUkZ4?=
 =?utf-8?B?U1RUb3EvRUVaSVgvc0JkWmU3amZSMmNRajNxVUJmYzNBSWlyQjVJTDRyS2dr?=
 =?utf-8?B?Z3JRMUJCeVBJZEUrZVJGVy9jaE1XeHg3T2c1aXp2QnRLbGl2aGJoelRGV3Bo?=
 =?utf-8?B?azhqdDRBL29VUXpybk52NVkxRUZQWkZmdjgrSEhMSzZoa1JnNEJZU3I4amZF?=
 =?utf-8?B?QUNOUzhqNEJETExDUGIyUnp4VHdueUt1Q0NOZUl4dkFCck9oekJiNE9CVFdC?=
 =?utf-8?B?ZlZHUVdPK2Uyb0dmVEJxOW1PL29VY0Z6dGFuOGUra3lnUkVtdlJ1Vlo3WWFt?=
 =?utf-8?B?dHNmczlDUThvY0FuRlNPbHh5T1NmSExDdFBsbnFzOHYzRXNJdGs0ZVpZdWNY?=
 =?utf-8?B?aTZTT3hIalBvRlBIeGpnek94QVh4cGNkUTZjTnJnc2RuMUZRcUZCR0hXSVI2?=
 =?utf-8?B?N1h2d2FYYitxM3E4QTJscWpoUFhZVUlwMjIvQmpDNWRkVG1Rc2JWclBDS05K?=
 =?utf-8?B?cENTT0hMVjAxUlNtcllGV0pYSVhNQWlqNG1QcExNc0J0RnNIYWU3akVmd0x6?=
 =?utf-8?B?QkF4VDVqYU1QWHJhNytYZHltbnRlcER0bXlOVEVuOWtpcEptblJWZytYYTFp?=
 =?utf-8?B?TlEwSFJEQmlGc2dFcVgrblJHdlN4M2YwY3hMVXNMS0hvdkU2a0JvRDRJalVu?=
 =?utf-8?B?UkZYVlRhMHRwQm82dHFNTnFzZVE5OU5xVmsrZXBBU3ZkbkEwU1Z0UmVNK3Bh?=
 =?utf-8?B?eUQxSVdsUEl0eVlXTTNsanpZUlNXNXI1a3lRT3EwdlJVQVA2OFZKcmV0dU9s?=
 =?utf-8?B?RWdnbEYxSmRxTHoyNHJ6eVYwa01VZVM0NDhWNE5Td3RZZXA0TGUvT2hjT3ph?=
 =?utf-8?B?M0ZJUCsyZi9qTHFOYmpzRGd3Q3I5aWpsUDg2TE9XUTk2OFptU0JNRlZpeDB1?=
 =?utf-8?B?ZFFkeEQ3aFpWbThPcG55OS9LbEFObGRUWVhpR2F0dTlSdGtXSVIvbUJXazIw?=
 =?utf-8?B?UkRKRzUwN2U4cXR1UmlHQzJMaVpZdkY2U0JJQW01OU9wUG15QXBOM0tKS2Qx?=
 =?utf-8?B?UDZ3TzI0b25ET29ZZGF5cHhqQlEvRnJ1Q3RFOEFleWRsV0RKckFML3FSTDE0?=
 =?utf-8?B?ZUIyNGR4T2QxdkdzM2liSTVJZlZuU2JJVlNsMTV5aGY0cXVYb3hkb1A5UlpD?=
 =?utf-8?B?elhqaGxiMTYyMUE4cE5PWmc3OGE3cGVkd1U2ejNUd1NJRVNPZ1hQcXFVQjdF?=
 =?utf-8?B?dy9wWW0vWFNuck9jdVBlSUs1NDlMK1AzMmFzNENsQ2t2WGVjTmNrdzBORVNN?=
 =?utf-8?B?Yk5EWFVpQ3FFcTdNSmdvU1VUd1lxbW5OV1BEODQ3THVLNzA0ZFNSZXloMVVT?=
 =?utf-8?B?eWZtTVJVNWNxVytWeTNxeWFhOThmV21Bc0tEWlFDR3VGMkNtMk96dHN1RU9F?=
 =?utf-8?B?R25WQWMrdlpHOUIxcU5BcEdackdRcjVRVVVIellpM1k0Uk9zMExrL0hIcHZx?=
 =?utf-8?Q?mor/squTASD9IoPshj9xg/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D0AD18F5B65240840309144814EB40@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9f8d59-cb5c-4e02-6450-08dd67f8e637
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 21:48:06.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+dS3e5B1FeQTyrra+03qlkRxXRqtaVM9SfFJi7Yge1b1Fa+X2w2Xx1tIMrjABgnqhax03ya3fiqL5U3CyS8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5304
X-Proofpoint-GUID: 0-FCTtW2FUBvuPcNqQd3gNvSLTOlpYqr
X-Proofpoint-ORIG-GUID: hwVAUEl50aBM8GyNu-CbjUfklUtjSQ4w
Subject: Re:  Why use plain numbers and totals rather than predef'd constants for
 RPC sizes?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=960
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200139

T24gVGh1LCAyMDI1LTAzLTIwIGF0IDE0OjU5ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+IA0K
PiA+ID4gLQlkYnVmID0gY2VwaF9kYXRhYnVmX3JlcGx5X2FsbG9jKDEsIDggKyBzaXplb2Yoc3Ry
dWN0IGNlcGhfdGltZXNwZWMpLCBHRlBfTk9JTyk7DQo+ID4gPiAtCWlmICghZGJ1ZikNCj4gPiA+
ICsJcmVxdWVzdCA9IGNlcGhfZGF0YWJ1Zl9yZXBseV9hbGxvYygxLCA4ICsgc2l6ZW9mKHN0cnVj
dCBjZXBoX3RpbWVzcGVjKSwgR0ZQX05PSU8pOw0KPiA+IA0KPiA+IERpdHRvLiBXaHkgZG8gd2Ug
aGF2ZSA4ICsgc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVzcGVjKSBoZXJlPw0KPiANCj4gQmVjYXVz
ZSB0aGF0J3MgdGhlIHNpemUgb2YgdGhlIGNvbXBvc2l0ZSBwcm90b2NvbCBlbGVtZW50Lg0KPiAN
Cj4gQXMgdG8gd2h5IGl0J3MgdXNpbmcgYSB0b3RhbCBvZiBwbGFpbiBpbnRlZ2VycyBhbmQgc2l6
ZW9mcyByYXRoZXIgdGhhbg0KPiBjb25zdGFudCBtYWNyb3MsIElseWEgaXMgdGhlIHBlcnNvbiB0
byBhc2sgYWNjb3JkaW5nIHRvIGdpdCBibGFtZTstKS4NCj4gDQo+IEkgd291bGQgcHJvYmFibHkg
cHJlZmVyIHNpemVvZihfX2xlNjQpIGhlcmUgb3ZlciA4LCBidXQgSSBkaWRuJ3Qgd2FudCB0bw0K
PiBjaGFuZ2UgaXQgdG9vIGZhciBmcm9tIHRoZSBleGlzdGluZyBjb2RlLg0KPiANCj4gSWYgeW91
IHdhbnQgbWFjcm8gY29uc3RhbnRzIGZvciB0aGVzZSBzb3J0cyBvZiB0aGluZ3MsIHNvbWVvbmUg
ZWxzZSB3aG8ga25vd3MNCj4gdGhlIHByb3RvY29sIGJldHRlciBuZWVkcyB0byBkbyB0aGF0LiAg
WW91IGNvdWxkIHByb2JhYmx5IHdyaXRlIHNvbWV0aGluZyB0bw0KPiBnZW5lcmF0ZSB0aGVtIChh
a2luIHRvIHJwY2dlbikuDQo+IA0KDQpZZXMsIG1ha2Ugc2Vuc2UuIEkgdG90YWxseSBhZ3JlZSB3
aXRoIHlvdS4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

