Return-Path: <linux-fsdevel+bounces-40330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4EDA2247C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 20:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2793A37B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14BF1DEFD2;
	Wed, 29 Jan 2025 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A2tXlguR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335B2C9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178225; cv=fail; b=iIDjHUy3SEkJCaxZkXmksqtcYc42EawDT51GrraykzdoZkq5hS7Mjw2oUB1462zOmhuFfqf+HmMqAOJKqD4KoVl81Ph6A6ONoZrnlHk0uQWIsskJFtacTKtoLGBtCOlHg+laeALpr5PoJ5EOC5rl4Mh/N2g38CVfPYz7OoeDGSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178225; c=relaxed/simple;
	bh=jPNAaMUHeosugGnXF+CxRJBn7CTP+ijOgY5D9NFkL4E=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mVlraoQvpDuteNXC85H8/H0WkT1ceQ7nqGqd3oX6meNHkCQ8ZPaIR7kYSlW1YFJavR9qempqk5o84B3UZHBu89QdjTyH5gCBnuZSn6TLPct42W8/9T4hje/0NiO9dspjm2WI0UkhrX82lVTE0z6KhO2AEITlBKTDpQ0JHnPfCsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A2tXlguR; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TF1nQQ024373
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 19:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=AAqBOrwR0KdGoSmEr6SVLMNV0DUpz/LIzZhe6WGy/Gc=; b=A2tXlguR
	WVcv6h3h/rvM/t76Uq3gkUX+4k2Y5HHsA47SNaecPQnTSttOEbKTzJzfh1vzZxrh
	Tt4qCg/TyUjtNCQVwd5WTJhyVKBEeVPYuZD9qwqOOMIJ/gchoGXHTpgsmBCGRZGe
	vEFUYp9KglieakliFoTlD5rAtMe0ffIvLl0FF96tzlxAIppNkmJhIHcDLl/qTnCV
	Yf5A3eee2H50wOPrwEcOkXpiN/oGvSOckshtDlk7jle2ltApMjwfhoCiUfMiJQhp
	6H1QAj3iUo9laYhKuQZP46b8pJ0L1C+UpH2PR8sGZZaZnJ8hSV7aQN1F5FPu93gk
	jR9A47lZbn0l0g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fpm1haa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 19:17:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50TJH1B5023680;
	Wed, 29 Jan 2025 19:17:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fpm1ha9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 19:17:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cchOB52aPTDASJ7wqWfX2wpY5+/Ok4PLNtAtt8zmOoX5kLLsnca1IGvdrHb/0PMk5o/JZTaKccT/u/9E5kJVwlvPg+RSy7cq36R+gIlEhGC9B+x1U6eZUFtkPa3nizHjuwZOshUFwRu8rb3oTPqbKa2G2jUXpLtzvH19YQhiPs8J/YsnfcbSOUkanDeJxE2jnCfNOIAZu/cfAyA/Zrdgtu6buruKlyQBjFcZVBqk4DDIsRI0orBnzfo9VDmpcds7K3w7GRihxO9+O28SKiI/8ktJQRYVXgKz/644eDo3p/ydJD2yh3Etxy+MUNMyrn6hBw5WNiKeMDks9/9OhKw4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy1YNHJdWt6wCPFkfRE48cy+enKhnHEZYBRhG0G3f2g=;
 b=Vii41CW8jvKu8hZ4UflHIej51+eOjvXEngTJCEAftWcIy18HYy0hY0gvcgzJ+21n2IFP0w0mUX/Dq3Y9eJfeseUDrK8AwND1OfKGNHFu1F6mRBMs4hWzSFDGK4OJjokI+Sphc9eg6yGwx9MladVynQi7YbqxFbuLrn0XfSTcJPQIFqNlloK04UIywbviWVXMORmJcrZ+GbxLXSmcd9rLSJWuPW/Ru3jlp/YLOZcftx018PZZvK0ZlLeiZlP8EwkHLWJtQXuNN/1l8Qaed6fo6UR/OcmuGafff00cepUrDx5uUltHccaUzGL0ssLWdjpWGoUXN+bKkyLPfYB5uE81rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB5957.namprd15.prod.outlook.com (2603:10b6:a03:52b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 19:16:59 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 19:16:59 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index:
 AQHbax51YyLDQhgFm02bhTgbrhqIz7MfakoAgAuVUoCAAWlQgIAADEyAgAAzSYCAAAQ3AIAAJo8AgAAA/ACAAPxfAIAAXdwA
Date: Wed, 29 Jan 2025 19:16:59 +0000
Message-ID: <67fa0e9f45d0ca52a2f6a21c1fea1fd14e589847.camel@ibm.com>
References: <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com>
		 <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
		 <3469649.1738083455@warthog.procyon.org.uk>
		 <3406497.1738080815@warthog.procyon.org.uk>
		 <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com>
		 <20250117035044.23309-1-slava@dubeyko.com>
		 <988267.1737365634@warthog.procyon.org.uk>
		 <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
		 <3532744.1738094469@warthog.procyon.org.uk>
		 <3541166.1738103654@warthog.procyon.org.uk>
	 <3669136.1738158062@warthog.procyon.org.uk>
In-Reply-To: <3669136.1738158062@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB5957:EE_
x-ms-office365-filtering-correlation-id: 501bee9f-6c93-4f54-2b3f-08dd409980dc
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXZQUG9xaHlTNVB5L3VUK3hURis4aFc4Y2wwZlFiUytoMG5YUmtUVjBWMjVK?=
 =?utf-8?B?aTMyK1lLUHgxUE9Tc3I4QXpQeEZVRHp3YkJXaktseXlqUW9WUm4vaWNJOUFw?=
 =?utf-8?B?QnN1TnNzbmlvVVlYeW9wemJBcEJJV3VFN3J6cGNlcGJuRUFYT2s0Zi90b3FB?=
 =?utf-8?B?WXU1dmVlYlJzOGZCTzdVT2N0NDk0c3V1NnhNb2lMWkVtQUZJd1lvaG4wV3dI?=
 =?utf-8?B?TElleS9qM3N2OFRaa0g5YzNXWFREd0p2MmRwSldtcExZTWtiNHJTVDIzOUJR?=
 =?utf-8?B?b3IyenFuUWVOY1RjNjk5MHpmMEZZMlhUN0tPQ253QW5zVnlrRXFabjFFUWt5?=
 =?utf-8?B?UnNEclVwdHFnYTl2VDk0VHdENHpXTmlUNHNHWXFwMU52TGNaQ3JUdFB3UWsx?=
 =?utf-8?B?bGtWQU1xNVNXMTM4S3FXZWFONVp2emQwZ1hIbjZKbTJhQWxhMk9SM1cyOTl6?=
 =?utf-8?B?MC9Kcnk4bHhKbHRFN3FHSStxNzc5Tys5Y0szdDJNT1Z6NEFDWTlxYmd1elhl?=
 =?utf-8?B?MTROaVZ0MzczZVh3Ujk2VXZZM25veVF0V3NlSmkzWEFaQmVCUUVSQlJBMkY1?=
 =?utf-8?B?UWRsTmtxUDI4YmI3QS80TGQvUDl3aktadTh1SXFoNVlrWW9Hd3lJQThER1d4?=
 =?utf-8?B?YTgzdnBiWVJiWC9id3JSU2NFNW1xN0hKejEreE9wM0piS2lLTjFXcUFjUUJj?=
 =?utf-8?B?N3N4UDMwQ2UrQTBvTDkwbDl1M1l1bHd3dWNIaGV4dGNDMGxVWmh3S0hOcGJl?=
 =?utf-8?B?NUNDRXYwOG13UWJRTlllczd2WWxPeGxUM0g0cjcrQ2tQY0dUdVB3b1lhS2xN?=
 =?utf-8?B?RFowOXhqbzBzSG9nYk5QdE1MbXhzUkV5TlBCTndMYTZ3eHR1MGl3clloekI5?=
 =?utf-8?B?blNSNlprejlPMEZOSE8xWjNWNXozMnJPYy8zaDM3NzF1Q0FNOVNSazZOb2Ny?=
 =?utf-8?B?Mk4yWXpEZWdsSHl1TmlQNUxJMkV1UVdVS3FrMmxCakhpb0xKb1RlNldPR0lX?=
 =?utf-8?B?and4eFV3ODAzeG9zSlUvVGo4WE9CMTRTUmxuTUwxbk82M1lrREJLdGp1MVp6?=
 =?utf-8?B?RHFRcEVYdE1VS2ZWcnNqbm94WWRnUkUzSjhEYlhMdHlQajM3T0k4bUJLNUlt?=
 =?utf-8?B?YU0wVk8wY3pOaGhEQ2VwQzNzdTVGZm1aRENici80QmJhVWxCTTlVR3p1UDR0?=
 =?utf-8?B?L3JSY1VuQUxwd01mUVRxK1RwVlIvY243eS9MemNyb2dVL2t4YXBNTlFLM1V0?=
 =?utf-8?B?NUpqdW5QYnFuMlByc3hlVEhibVlXRzRlTDZUcHZqT2Q1SVpRc01vSHhFTWxy?=
 =?utf-8?B?OFNWSDZpV0RwK1haUUJDRG9rS3E0NGJwVUFncU1MdC9mNGlGSXRDZ0VMSHZJ?=
 =?utf-8?B?VnlWNG95Mjc1bDM4dC94TmhqaHZwblJPRzFGNi95RGR5N3dMYWNtWGlkMlVx?=
 =?utf-8?B?VkNLbTA1OGpMOXNNZlV6WkEyRVI0T3IxM1d5Mi9pVFZDNlZXODBLKzN0aVgv?=
 =?utf-8?B?cWYrM0FxNUswWVppZG5ZOVlMa3NDcnRMdXVZeWVHMkE5ZnBySmxORk5JL1I3?=
 =?utf-8?B?aVYrbjlqWCtLNTlORlpaVlZOVUFOY0Uyb1pvMyt5NU5SVTRCZndkN2FyNi9Z?=
 =?utf-8?B?L3l6MzU2cEZLMmhXYjBtaW5wWVhIUmltYjBUYXZZNUMvQ0REMTk0czlKc0xY?=
 =?utf-8?B?STV6SWl4S1NsZWNFbHBmZzVCRlFLNGRSWXJWUGVWYmF6cWp5U2VFWEplQi9j?=
 =?utf-8?B?TnV3WXJrUzhzMmJpWmhTd2h1R2F0RUVWYVFKZ2pCcHpva1luOUl5cjdSaC9R?=
 =?utf-8?B?ZkF2aE9EMXR2d1E3azVZTG56UmdKbUxMRDRha3FBamRzaCtDR2g2WmQ1RkZ1?=
 =?utf-8?B?Q0ljRDNKV0xuc3Y1TnRPYjhFTWc0dkVlbXFJNFN1MnBCS2MrQTNReDNsQ1ps?=
 =?utf-8?Q?cOJLTYZhShTkFHsE/y6Mch+xVY3ZYCpS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEhhZm8vNUk0Vzg0Vmg3eXpBRUtTb3IrUTlESnYrYnJORlpBTVo2SFRSWW9t?=
 =?utf-8?B?U2ZXN2hjaU0zVkcvQ1BkRk5sMS81WUJIRncvQVpUOTJjdlMxa1F3czBQTTJz?=
 =?utf-8?B?UkFqRDdPUHFmMnNUSFFWbXJIUzhhUWxRZURvL0swWTNzQ09xMnVZWFRjWXlq?=
 =?utf-8?B?U253b1FvcmNvYWlYeEc4UjNHS092TS9INXFDZUczeXJpWTlHcW5DdlZRVU5u?=
 =?utf-8?B?VzFVRXRDK29ibFYvT3pmeXlOQ2tsQ01nK21jbE9YOWp0dUcxS0pVaU1LMEx1?=
 =?utf-8?B?OWZuNXd2RjBRSGVMNnlJaFZ1TFJ6OU1ZWXBPWnR6VUMvTFNOUGxOREhXaFVT?=
 =?utf-8?B?UURpejk4K3lhVDAzZFltWjVGM242cXVBb1FqaldxNDluVWREaFlNdWRjZDdX?=
 =?utf-8?B?anFzbEhJL05SUnZYcWc4ZDNxcHlRQmthbnB6NU5VVC9uVVFQS1IyZ3ZBU0t5?=
 =?utf-8?B?am1BVVpid1JuYkVtN2c4YS9UUVR6SHdBMkk5dENiR0lkcDAzQkZVQmVZbUhQ?=
 =?utf-8?B?UDkwc0J3OWJJUXpaUWhSZjVjOW1iemtuUHVaUjRaRm5rUmhBYUNaL2JCaXFE?=
 =?utf-8?B?S2Z0UVdacEFuWDl3RXBBN2FFekY5Q2F5S3daUG1XMDZRSk5nRDJVS3VMbXlv?=
 =?utf-8?B?b1JVQnFZeEhaNFdwNG01cFVTL1UvMVU5VmVTZDh1dFFMSEZNSEFMWGlSSTZU?=
 =?utf-8?B?NE9GbUNza2JhL2ZHYmpvK241eUxzUlI5aXprRDNnbTJ6TE52RjBnOUdZMlVx?=
 =?utf-8?B?MmtDSkc0NnovUUJFU0Fqem9vaUM2c1pJU2w2MnVoM3BpUWU2anVkWWl6UWRN?=
 =?utf-8?B?eEdZOTNkU2xjMVdZZk9TeU93QWM1TElzRlNZUUF3NmtUbHlzczVDZ3M3V1Ix?=
 =?utf-8?B?VEgydmlHT0VQRGplU2FxcWpyVXB0MWJmeDMzbkZjUVRLVDFZMXZNdDd5SHhp?=
 =?utf-8?B?NkJtaldJcU5qTkdwRkVTZUdmZXRmOEo4cHJXZVkwLzMrdmp1SGNnZ1R4dGxY?=
 =?utf-8?B?bE1rOWRTVlgxYTY2R0MxKzZ2aGNlbVFnRHpRNkpGWE5XRFhTWnVCRWRFR3JL?=
 =?utf-8?B?NTVWRnl5akxwbFBQckx1K2w5aVZtNHJKOEFTMk9CMGRVQ1FLanZxYXhEY3N5?=
 =?utf-8?B?c3M2Um1DOHVrNU02Tnp2YzVVZUVuUUppdVJyTTBCVVRORXRrREtIb1BmTXhR?=
 =?utf-8?B?dGIvejcwSHRDQlZDTEZjU0ZUa3NSN1JCVUgxbERqVzluamFKb2MydU84dE5l?=
 =?utf-8?B?UXFJNmhlY2x6K1p3L0JKWWxKZnZyc3pSVndvcUdNRjNUL0Fqb1lkTG5paWFa?=
 =?utf-8?B?amNDOFZ4RWtQaWVjWlp3N2NCZnJ1ckdMMUZGUGJ5NTIvdlZOeGVneDZvdjVF?=
 =?utf-8?B?SHBwa1ROdUxUUE41TUVEV1QyV2J6eWdNc05JTlhUVm0yaXllL0RhN0lMNG85?=
 =?utf-8?B?M0Z2amVmTFp3TmNmZ0drK3VoRUNweTRLTVJpUmc5aTU1TXBJaE1HUkpWbEZP?=
 =?utf-8?B?UDlGL21VL29xK3ZDajNxQnk4c1FDNjdoTmNrbnhRUTJPb2tzWStJZWlmbndl?=
 =?utf-8?B?a1ZHcjRBMUhJTjVLOHhHc0w2TEwzc3VyczlYUzl1TkR6Q1pES2xvR3M1WUJo?=
 =?utf-8?B?ZTRNZVJVRHppcHJCNW02T0hlRnJ6Y0ZsNXFPdWRUOFpsR0taQU80dmdEK0kv?=
 =?utf-8?B?TUF3emRXQ3NLQmprbDRUanh1T3dDNGlLM0ZBVFdNd3ArUS9mekcrTWlJVmRD?=
 =?utf-8?B?SUMzRzRXM2E1RHkxQm40L0p6MWlvYUNCZWNsYkJlTEJpQm1NY1lIK0l1Q3VL?=
 =?utf-8?B?dHZxRmNGUkhrUTBNamVqM2dpZjZKRit1L2gwQ2xpTmEybTBzQ2dLeDRlS1lM?=
 =?utf-8?B?cWZBMU9rWXFyTEpYZm4vTmtLZC9QQXRlT2cvZlNFUElqZWNIMHZVWkVUWXpV?=
 =?utf-8?B?eWFvd1JKVHI2ZU1XRy9xL016OHJVN3FGbXdERW1BaCtFZm9iMWF0andRRXhB?=
 =?utf-8?B?TzZHZUlsdDJRQkwyS09DcHpVYko1ZTBGWi9lejIvajJIQ0w1Vlo1ZEtmNTZ6?=
 =?utf-8?B?dkR0WGcvVzVvVFhRMlI0MkpScTdkUFVTdXFSYks4M2hEV0g2L3IxQ1pZeFNp?=
 =?utf-8?B?bWhvTnJ2UnZ4Y1p5VHQvT1liU3VDR0NlN0VaWDBPWEpCT3VvKzU0VFlZSnFL?=
 =?utf-8?Q?3kRQyM8Ehi0o9nzANsGue3E=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501bee9f-6c93-4f54-2b3f-08dd409980dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 19:16:59.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osTvuWT8mKyc/gAW0jnVRixO74/irVwlssbVresNHBongx1XZ5wv+t4CuSDmVP+wyGEfrAJ6umbzEbr4tuwclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB5957
X-Proofpoint-ORIG-GUID: wE1vGyD_QEI7UojEaXeLPkdmyCUp3sGw
X-Proofpoint-GUID: lZIa7k4P-fxkp-HUzz8fw1F6a-hqOyak
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9305E83DD865B4F882733B595D781DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290148

On Wed, 2025-01-29 at 13:41 +0000, David Howells wrote:
> Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
>=20
> > > Do you want me to push a branch with my tracepoints that I'm using so=
mewhere
> > > that you can grab it?
> >=20
> > Sounds good! Maybe it can help me. :)
>=20
> Take a look at:
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/=
 =20
>=20
> The "ceph-folio" branch has Willy's folio conversion patches plus a traci=
ng
> patch plus a patch that's an unsuccessful attempt by me to fix the hang I=
 was
> seeing.
>=20
> The tracepoint I'm using (netfs_folio) takes a folio pointer, so it was e=
asier
> to do it on top of Willy's patches.
>=20
> The "netfs-crypto" branch are my patches to implement content crypto in
> netfslib.  I've tested them to some extent with AFS, but the test code I =
have
> in AFS only supports crypto of files where the file is an exact multiple =
of
> page size as AFS doesn't support any sort of xattr and so I can't store t=
he
> real EOF pointer so simply.
>=20
> The "ceph-iter" branch are my patches on top of a merge of those two
> (excluding the debugging patches) to try and convert ceph to fully using
> netfslib and to pass an iterator all the way down to the socket, aiming to
> reduce the number of data types to basically two.
>=20

Great! Thanks a lot.

I believe I have been found all current issues in ceph_writepages_start().
So, I need to clean up the current messy state of the fix and the method it=
self.
Let me make this clean up, test the fix (probably, I could have some issues=
 with
the fix yet), and share the patch finally.

As far as I can see, there are several issues in ceph_writepages_start():
(1) We have double lock issue (reason of the hang);
(2) We have issue with not correct place for folio_wait_writeback();
(3) The ceph_inc_osd_stopping_blocker() could not provide guarantee of wait=
ing
finishing all dirty memory pages flush. It's racy now, as far as I can see.=
 But
I need to check it more accurately by testing.
(4) The folio_batch with found dirty pages by filemap_get_folios_tag() is n=
ot
processed properly. And this is why some number of dirty pages simply never
processed and we still have dirty pages after unmount.
(5) The whole method of ceph_writepages_start() is huge and messy for my ta=
ste
and this is the reason of all of these issues (it's hard to follow the logi=
c of
the method in this unreasonable complexity).

Thanks,
Slava.


