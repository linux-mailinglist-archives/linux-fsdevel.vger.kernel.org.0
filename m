Return-Path: <linux-fsdevel+bounces-27436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECB961850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC39B2193E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D61CDFC3;
	Tue, 27 Aug 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Sv3f9+em";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="U9egyzXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2174823DF;
	Tue, 27 Aug 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788915; cv=fail; b=uHDTdtq9kFnOJwlTSyTIsmmyt0Ch1t+qTund3dh16DAOW+1aHjriN4OfMGbkwEW+4wSghX69aq+pUFD60jRqf7uFinekwjJeX2aG96zqD5wEemKZbNHEy1p+UMyGaqxaVEJVOpbOpCww4fNWW3xhiwT84bIQno1gzId8dY+Q2TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788915; c=relaxed/simple;
	bh=IqxokPnjOStRPeF3onoKpNFOra9tRGSYQYgiJN0PmAQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l3wj1mCiDxTj1SZYStgffFuGQXfnYtXCa9iibf4+rdhuOksenwFrqY2EWotXViJx5EyVP2KxDuII28l/JAq96fC22RUnhWQlrGBSJ/LpA7rMF/IdWCsLwAmtpGibmZSYsWz8U6OB8wbXT01YKXisptXe604Kpq6Zi1et5/dVcqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Sv3f9+em; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=U9egyzXB; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9WEJX015329;
	Tue, 27 Aug 2024 13:01:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=proofpoint20171006; bh=SS
	rSGmOkGOhzuGEuBF2WlZ4irIi7r+kSpNiCOzo6svc=; b=Sv3f9+em1CqSl2uuW+
	6dWDFTdwncJmw8DLyvTaGwlM6skWKuSpOI0Ey3cm2W2E/sddxU/4VRaWLTDOpZv8
	SGpkFaXxceETL0Aj5T/oxgZzPZgUn3AdPlJfYJEXiuPSqkIIfxsvU/duIfo0jUNi
	QR212raAPErzF2xhuPT3aevongeiuut/mLcuDl6ngfZtXrjWmvFynCw3HIdLgsiS
	F5/tMLC/nWZparULaJCmAQbZfWw2jS07MTJ6q+5G2nA3YoeVFMPnoVe0lBG+NZ2r
	aBE8u3e2m/gfYAMfXSaEA4NpDOIandYUW4oNF+qKddj8kB+ZSyWDIk2V+qp4nTYz
	N0OA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 417bea70qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 13:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6mRvxU1GLoo4nsxaT/DDIYj1nKcla2yvdNG9iAz/JE3ZREpz0AotN3eineOXmQGqTWVtSbSJYN4IK/K1g1/vyhKqLo9uGpJ9XOfrYNqlU0uFd7ZhtRKAHI2VByOmpqpljZuirqaLr1s8a2ROfvv3k7TIhrAepkKqT9A/EGsi9U/+qHRzhONoeoQckia9dRfwwHub6AvUwkgUol1QR2mAWktu1W1NNjMkP1/RrhuioEttLqGbncwKm4l9crWd2fQg5C/YiVBhbmDday/SgYjtPDPFeqeJ7dTPLULaWt0rzw2TcE1pBhDCKSXogZ73tRRs32otjkutQvNfL4cM8RtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSrSGmOkGOhzuGEuBF2WlZ4irIi7r+kSpNiCOzo6svc=;
 b=WEbjZLB2kVJg2CxJiZPrbt6MTBJdodbywv1qq9o6S2VlmSI0+aRCcob5o08XUlOv1/g1Uib0bVVp+YG/HDsvb+3KWyKiVXDic9/8dFr/DZ36CtuUJnTejfTB0LzyLHYM8VaXDm70auVWl3qye9MXbWQ3MEBf6P4kIaJWulvbFc41vqRkMSY4rvLxEq7S74zR04pNnO5Q3OypQZ/pilfTallBQkyBixeGfrqncHYMVrkxmiD0HBPJ9P33ZmS8kPsfzi1TCE8mSAEGuGYQDoy3YSeuFbGtid0VckZFQlF2i74QlwUSfBajeKiVs/x9laL4QYeEFkR7ay8HO9UiePgHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSrSGmOkGOhzuGEuBF2WlZ4irIi7r+kSpNiCOzo6svc=;
 b=U9egyzXBxYREOUgyVM4/n1XUVTA41t9pkmIm80DjDP0MbKw3cI9Iv5vDWKfbl5FGfgiMkBOad6rpQ8VijFA4w8c7z5GyJ8GVs4znhFG6RkHg3rxWUAg6LGWLWsclyFDFWMGWTmmHhO2OEhL9U2ORIALxzVCJWE4//q+NWqHLHlEix7GpRDycOM4zajNiqqE1Eg0jMsMrc23am82rGDToLR1EIsINUKzjhuFzRz1ruN66G0oX+fiGFr9q2jrGYlSSkwg5vbDdSIsOTyG56ZrnMzryrC9FpKwlacQHEjf7vufdgO5jeqcO45EYaR8PQvOR60mToHqAl3qa0qfoaVYKMQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by MWHPR02MB10521.namprd02.prod.outlook.com
 (2603:10b6:303:286::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 20:01:28 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:01:28 +0000
From: Jon Kohler <jon@nutanix.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>,
        "rcu@vger.kernel.org"
	<rcu@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>
CC: "jack@suse.cz" <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Thread-Topic: SRCU hung task on 5.10.y on
 synchronize_srcu(&fsnotify_mark_srcu)
Thread-Index: AQHa+LvniDyc76gRTkC5q73J0xrW2g==
Date: Tue, 27 Aug 2024 20:01:27 +0000
Message-ID: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|MWHPR02MB10521:EE_
x-ms-office365-filtering-correlation-id: a3a21514-6f50-4148-07e8-08dcc6d30985
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Li8w2Q72cNVVyMeiEkANQYFhI1dffBc8S9HWJOjcnfDhFMVbFRXtOe1J98Yr?=
 =?us-ascii?Q?zX0WdGcCKwg9ZQtMKoEDIYt236m72cBuDp/8D3yj8ApNFAYKy2kb+FqX3UUo?=
 =?us-ascii?Q?XhkTIj08JzGSIUT33eTGHC2PXaZWAE+lfouUAyA7qyB62GcTayFqsFfpmnxG?=
 =?us-ascii?Q?GgsZzRMcFSWv+FhiMG/q3YOQsEAxLXxiNwmFwt2fL3jNiDGSlznMApePazwi?=
 =?us-ascii?Q?OANJdNeqEomp4GXswPsj3QxR6ONT8YSOPhufCInqnJzD9J6bQxtdM5rH+/ok?=
 =?us-ascii?Q?knL8TmpBX94DN6TIcoTGz16hR9jCcVzjyGMdLGxaQyrjnuqd2ReJJIjL56D1?=
 =?us-ascii?Q?QH0+gA1zzgqcXuFe4ui/UBZPh7yT44sLHGvvF7TBomL01SmKK9JW6z7DDR+P?=
 =?us-ascii?Q?MXt3hvFWReI4vWbU7k3Bq6guPAG0DWjMo0BH/pAkxUXxoCnmEuaSHvAWbC1i?=
 =?us-ascii?Q?QKW7yErSi3Co13HriLNsor5TX6WDRkP3LfrT/ixOdeiB5cL4gPfOwrh243b7?=
 =?us-ascii?Q?C3vyrnIU+9/Cw0MTbkbs9c7ig4Dzxn+0M6aOboU0thXL1Psos1SobA1Duyhz?=
 =?us-ascii?Q?0371qnCX7XFZa+TjmZ7dzWcuIGO5kyuC0DcDBJyo4sHQsvVTO4S3BHWvaHPY?=
 =?us-ascii?Q?Cfe2JaQvkJdJE2Ln6YIVhwlcUMdGR4i4egtiiGL3HWnEOqgHOK9sdH27WH5M?=
 =?us-ascii?Q?/Ip6UkwcbmTVLVZL+0oABCm/kTrZGleeci0kY3aEHhfdTpIEW8VbJDFuadl4?=
 =?us-ascii?Q?5tGiHXOXcYgmD4cgoPaTNb8Q9rwzIqoo6K921FkAvSiE0nRqlRSP/KRlJv++?=
 =?us-ascii?Q?KihMvmnfVRy4XjCAPssJ5p8nRwLAdZ13D8rwWDjY9nli4f+ktIaDLRoqg+MD?=
 =?us-ascii?Q?aGrrPIdpGnazjTh/5jiNDbVfsc1xDGDeDJhtA5T0lYbnr45ReTt3/iv4T6AO?=
 =?us-ascii?Q?IT8Mhvqr9+GhQ14SslCbwOQIitlqxnU8C8oisuukQ1KD73vtA0U23Bxe5Kgc?=
 =?us-ascii?Q?jQc+5VC0SJy85tyvp55EQlKfeZ0EakTOupuxEAbjSZqW//sIEwy6jhwF0F6c?=
 =?us-ascii?Q?DI4uiJSSNAsVmYE1SHz1OkBdDciFs9iFHkMbC/o+28Dqf8KBEUlxxTCy5w7E?=
 =?us-ascii?Q?XJ+CE8izAENZ0nROm8BQy20phzaffFtkWcXsug4JnzbSfV3AgfD9WmlqqypX?=
 =?us-ascii?Q?/K9wMbXfMaOppJKuO9yA1UIGqUQ6NopT5XDBPchRZOQUSvMuWdtf2xQFWO8C?=
 =?us-ascii?Q?rkYW7j/7FzMpNOvP5tkDOYH8/+ts7bLlTDw4bdVRQVQPyoir0SKyxxofnk7C?=
 =?us-ascii?Q?8mRP8OCgDb/5407l0MC+VnImXHYp2uvnHO0eCCpt02dF50jKEx0JDY4OkY5h?=
 =?us-ascii?Q?/ys4d/Lve6XHr5gn2A6WHMZ7oso7icwg20mFqHIF6rrXSSK5cg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IccKXRng9jcnX305ikmtj4JuFm45yBMf/5jTJxtTtNj9uiVQsBJUrIzeaLDj?=
 =?us-ascii?Q?7DCyuDPb4cy06kqxjsE8tYkQlM/gj9tiKNxY8TmW+BWP4N2zreN1nhUZUJuv?=
 =?us-ascii?Q?hN7W/0bhc/Mltr67TSRm2vAPgupAWcLf/tMcOUq+gnrwmkSNKzVvwRVgDDap?=
 =?us-ascii?Q?586uGUv2d6YHwxMn9T/TerCUnHj7wpsxGWmM0VfpWIFdPmOD42Urh5nH+Q9T?=
 =?us-ascii?Q?wiwcNLjrGt2jdANCwbzb3lxmS4h0biQFnbwmEPNuPN7zLz1+on/isqz4KCCS?=
 =?us-ascii?Q?WOz2skNXwGZWaBVG/51jf2qaC8QM48KcqCtjKAiBc+UHFuShtxkE0qzoqdFc?=
 =?us-ascii?Q?3z+JN9u77b3KJcY8DpRyTDJc5vOcSNulX6aM+4LFqYGalfhrfIsH+/Uw/J4s?=
 =?us-ascii?Q?Sob96LvzHLxQGH7EAofjY34rHeIbDvMQZY0KQHwCxHXTbGMPlLshPlEYIXQe?=
 =?us-ascii?Q?YFNgBzKrRw5OKXyhF5QkAabRbbyf1mq4BUXk2cHOw40N+Y5EqjWeQzV41W6r?=
 =?us-ascii?Q?Id9U9xDOxreJ83hDntALC+l31R5s7rdM+98xS/nl9qWirXB4yB5RMDixUZLf?=
 =?us-ascii?Q?d7mWMExpzQo2KwgmWm4Q8HrILw/sl6S+lnM/3VLyA3HMIziKJuULE8mBryFU?=
 =?us-ascii?Q?tOQ7badGuXkxOGX4Ju4ooUVVbT8M8ConI07Z+qlCYZffwVikfW5dFJGCivOO?=
 =?us-ascii?Q?1iSjPpVTL0qjRubzgDweH0VXseAgSUxSAObqskqAy4ADH51KyMsbKsS+sXZU?=
 =?us-ascii?Q?2QDNyjASmQcRD92dm7/5DmIpECsc5E3DKGmfBQ6eLai80iJEUqP+RsCZda05?=
 =?us-ascii?Q?I5rLLXyFjHXDHEk9XBQniVUK925rjsdN4hVuuGampQRtrZXWzdNlDAfHJqRT?=
 =?us-ascii?Q?nEMomvmIiYgyQoqF5nuw5h8fjj5R9YVU+j+QsH/9DthnmabUlutJjMFB3hIU?=
 =?us-ascii?Q?V+mEtDb5r1Avpe9SKZ0ylkREgg5iBKjyHmfC3/qjWJVBZrfEBUuPnLzD3Nye?=
 =?us-ascii?Q?H/aMwgYVXaezw4fxX608iYpNxqPE2QqH039UUyjyZLyimKyUvaNhCmZIL2mf?=
 =?us-ascii?Q?0HZIQvk5QJEJi3endKaTgOivu8ydCUSt239sU+mdFPEgCMcvpwLnaKL0ND/N?=
 =?us-ascii?Q?adZwMK7DITVrKGtJ5wv5AOHdXvN39e8zLK6B6EzObDnSToTamjiUCZ9ZDYeA?=
 =?us-ascii?Q?sdFKv3Ggm3PP9TlOHajEWoiuDjiRlGrjs9Bixi9hKk10mz5DaRJWbCmUWopz?=
 =?us-ascii?Q?xjNNtGbXj2/8nuYULblMUAyviQLBvTbCYhLVGh3TicSwAHFPwROpZqMvdHWm?=
 =?us-ascii?Q?a6zMAj7y5xzm+BGphJDVuOIywTlCt1DgPVO5AkPp3lvPqzinL1BRn1sRrs6f?=
 =?us-ascii?Q?FF9kT3LkBMvyVR4bm89eum2F06W7p5/B5pZGrUZwfZP0pNfPL0dkOS+jeOjs?=
 =?us-ascii?Q?4R06UK0bz75Fra6K8P7VED47lrV0/KYXTbS/k8QhZLQ3FQGYBGV8I7g3oC4j?=
 =?us-ascii?Q?0N2GqgWeCU90qvCowiJQg0LMdi0/621bUbnLoZmb1N67PRa+vUb3TYILjNSV?=
 =?us-ascii?Q?CjpbIbijVLMXM+fKycLcq0EoDFkIgH/WLkDi27yyOvMot0oKVPW6R6XN2cUF?=
 =?us-ascii?Q?0PHSqCaFd/YmWwkqTPOtEHavpCKuKlLia2i/Pv+BnieI57kdML/I2iRfuvND?=
 =?us-ascii?Q?Qze4qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7262927F6F10FA4799FA4FCAF38130D2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a21514-6f50-4148-07e8-08dcc6d30985
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 20:01:27.9594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Glox9WaY7qIRkq0ARtAyCcxyyaS4MJibS2EsJch1n8ubCHdRNzFV/jjq5uGdl6BBPc1z79nH92UIsPxNsJioUxJUXSFYiWCNVIn3TRBPlTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10521
X-Proofpoint-GUID: -ZpKB3YNr-mthPzt96pbf8e4pis5Ygbx
X-Authority-Analysis: v=2.4 cv=d4ynygjE c=1 sm=1 tr=0 ts=66ce309b cx=c_pps a=zbudaZmfUx0dwwhLSrpPog==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10 a=qxZ9CumnMAFG1FkBo8EA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: -ZpKB3YNr-mthPzt96pbf8e4pis5Ygbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
Reaching out about a tricky hung task issue that I'm running into. I've
got a virtualized Linux guest on top of a KVM based platform, running
a 5.10.y based kernel. The issue we're running into is a hung task that
*only* happens on shutdown/reboot of this particular VM once every=20
20-50 times.

The signature of the hung task is always similar to the output below,
where we appear to hang on the call to=20
    synchronize_srcu(&fsnotify_mark_srcu)
in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
where two kernel threads are both calling synchronize_srcu, then
scheduling out in wait_for_completion, and completely going out to
lunch for over 4 minutes. This then triggers the hung task timeout and
things blow up.

We are running audit=3D1 for this system and are using an el8 based
userspace.

I've flipped through the fs/notify code base for both 5.10 as well as
upstream mainline to see if something jumped off the page, and I
haven't yet spotted any particular suspect code from the caller side.

This hang appears to come up at the very end of the shutdown/reboot
process, seemingly after the system starts to unwind through initrd.

What I'm working on now is adding some instrumentation to the dracut
shutdown initrd scripts to see if I can how far we get down that path
before the system fails to make forward progress, which may give some
hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
a plethora of DEBUG options [2], and didn't get anything interesting.
To be clear, we haven't seen lockdep spit out any complaints as of yet.

Reaching out to see if this sounds familar to anyone on the list, or if
there are any particular areas of the RCU code base that might be
suspect for this kind of issue. I'm happy to provide more information,
as frankly, I'm quite stumped at the moment.

Thanks all,
Jon

[1] panic trace
    Normal shutdown process, then hangs on the following:
    ...
    dracut Warning: Killing all remaining processes
    ...
    INFO: task kworker/u20:7:1200701 blocked for more than 241 seconds.
          Tainted: G           O      5.10.205-2.el8.x86_64 #1
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
    task:kworker/u20:7   state:D stack:    0 pid:1200701 ppid:     2 flags:=
0x00004080
    Workqueue: events_unbound fsnotify_connector_destroy_workfn
    Call Trace:
     __schedule+0x267/0x790
     schedule+0x3c/0xb0
     schedule_timeout+0x219/0x2b0
     wait_for_completion+0x9e/0x100
     __synchronize_srcu.part.24+0x83/0xb0
     ? __bpf_trace_rcu_utilization+0x10/0x10
     ? synchronize_srcu+0x5d/0xf0
     fsnotify_connector_destroy_workfn+0x46/0x80
     process_one_work+0x1fc/0x390
     worker_thread+0x2d/0x3e0
     ? process_one_work+0x390/0x390
     kthread+0x114/0x130
     ? kthread_park+0x80/0x80
     ret_from_fork+0x1f/0x30
    INFO: task kworker/u20:8:1287360 blocked for more than 241 seconds.
          Tainted: G           O      5.10.205-2.el8.x86_64 #1
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
    task:kworker/u20:8   state:D stack:    0 pid:1287360 ppid:     2 flags:=
0x00004080
    Workqueue: events_unbound fsnotify_mark_destroy_workfn
    Call Trace:
     __schedule+0x267/0x790
     schedule+0x3c/0xb0
     schedule_timeout+0x219/0x2b0
     ? add_timer+0x14a/0x200
     wait_for_completion+0x9e/0x100
     __synchronize_srcu.part.24+0x83/0xb0
     ? __bpf_trace_rcu_utilization+0x10/0x10
     fsnotify_mark_destroy_workfn+0x77/0xe0
     process_one_work+0x1fc/0x390
     ? process_one_work+0x390/0x390
     worker_thread+0x2d/0x3e0
     ? process_one_work+0x390/0x390
     kthread+0x114/0x130
     ? kthread_park+0x80/0x80
     ret_from_fork+0x1f/0x30
    Kernel panic - not syncing: hung_task: blocked tasks
    CPU: 1 PID: 64 Comm: khungtaskd Kdump: loaded Tainted: G           O   =
   5.10.205-2.el8.x86_64 #1
    Hardware name: Red Hat KVM, BIOS 20230302.1.2662.el8 04/01/2014
    Call Trace:
     dump_stack+0x6d/0x8c
     panic+0x114/0x2ea
     watchdog.cold.8+0xb5/0xb5
     ? hungtask_pm_notify+0x50/0x50
     kthread+0x114/0x130
     ? kthread_park+0x80/0x80
     ret_from_fork+0x1f/0x30

[2] additional debugging config knobs turned up.
    CONFIG_PROVE_LOCKING=3Dy
    CONFIG_LOCK_STAT=3Dy
    CONFIG_DEBUG_RT_MUTEXES=3Dy
    CONFIG_DEBUG_SPINLOCK=3Dy
    CONFIG_DEBUG_MUTEXES=3Dy
    CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
    CONFIG_DEBUG_RWSEMS=3Dy
    CONFIG_DEBUG_LOCK_ALLOC=3Dy
    CONFIG_LOCKDEP=3Dy
    CONFIG_LOCKDEP_BITS=3D15
    CONFIG_LOCKDEP_CHAINS_BITS=3D16
    CONFIG_LOCKDEP_STACK_TRACE_BITS=3D19
    CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14
    CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12
    CONFIG_DEBUG_SHIRQ=3Dy
    CONFIG_WQ_WATCHDOG=3Dy
    CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
    CONFIG_DEBUG_LIST=3Dy
    CONFIG_DEBUG_PLIST=3Dy
    CONFIG_DEBUG_SG=3Dy
    CONFIG_DEBUG_NOTIFIERS=3Dy
    CONFIG_BUG_ON_DATA_CORRUPTION=3Dy=

