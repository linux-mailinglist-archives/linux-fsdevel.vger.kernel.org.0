Return-Path: <linux-fsdevel+bounces-40253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB5A212F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05761889A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 20:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D511DFE34;
	Tue, 28 Jan 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ATRA9cCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7E13632B;
	Tue, 28 Jan 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738095383; cv=fail; b=aYRho3HNGg20adayfarSMVVQSY7BLkOXeeQsirTITMEjWL4UsV5W8PVXqihvUDdj+63vyQuYZw1iEveE4h1HmUX74wBQin8PP5xhDfzSagqg/7dXlQPBHX0TtjSpQRn1uwa1Bac9YrP//TNTQChvq6P1gp5TGb0e8jfL5+52nNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738095383; c=relaxed/simple;
	bh=1y6kHkhhg9jSUe8qXB3CUOEKyfYlu1Mc1q6X8QqeU40=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cjjX+Ddlh7eW1Y17fUsigIT/KumIXwV9fE45gCuge9c8EC7fBMu/NV08hi54PjSophEiWVVwK38RAeqXxaEfYZvqvRtsnoUsn4ywTfXe46DT3dQkWkE65T1PKZbKSeDTqQ+tvgyTpXf9LexQuZ85cHvHJ3w30c85TTLm2zST3NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ATRA9cCj; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGdfbR023091;
	Tue, 28 Jan 2025 20:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=1y6kHkhhg9jSUe8qXB3CUOEKyfYlu1Mc1q6X8QqeU40=; b=ATRA9cCj
	6P86IaV5gecIOaqRRsTC85YCYUDDF7tlvXkmWHbv2mHTc20J8l1ihX/poLk41w4G
	LVXpPVinhLcTvUrDN5+fu09N+yW3Y6Z5L9gesx/CjS8RnDtyBfGr1e2UtqSMSIPP
	B37cUOtii6EhpwQQbK12uSHnuMlO7DjdAoFlT0pfL+uAureM7I7SJy4G0jfJqJvS
	XKQU0hxug0mBmCeX76OJJrdZhAewKIqbiV7ma/Sq3sj/PqBTMCqjeoWPqFXS53pt
	ky6QcoVjcHsSOyfJj4tklLK4LPNqcg9ryPzWq7pctWzFLFyokEiOG6+tPSH3JfzU
	M4X90H+/JABWgA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxruem3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 20:16:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50SKGHdx012922;
	Tue, 28 Jan 2025 20:16:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44etxruekx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 20:16:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1qJ1FjOUghYreVj7YsUHNLbwaNe5zOzCWl2qA5m6PA4IlXYusIER/Pnh2yfwvGB9b1HGhX+fsVN0MQClZ2d4Ns+97XjmWtUq3v5TQXLBCtpyz/QSDzqJUTd5A76mVeI/KTtNoATGFeFLLtFflTcAjUeO/6ipswnZb89C/gfv4X+aA1ZTwJigA7hrPUV8ZlDRGUajKzVUKl99qZRiosNvAQJHo4Avlj04FmqA6Io1wteuGSzuGTRXZjh4In4i6SSdSQwxKw895VtT/As0J4AaDq0eWf36as4puEbU51MB4u/IQPVOFxrjG36S5HsQXVLMSnID0fPsNW/o1vsWsz7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y6kHkhhg9jSUe8qXB3CUOEKyfYlu1Mc1q6X8QqeU40=;
 b=M6BTkibRtGqqXvKVeGBv9gapt+VDEb5hPcZQ8SI/iCD+nS7CZWkElNJr3ihjFF7uJbS7khg5Yw+SNTRGm4n8nvMYuX3j/HKUdWNojsJYSFGfyLI7gB9pgnMedS7NaMZkhRUVLRWNyn1ALNfH2F5SAmKw4FhEvjax2QdZekn1KpGCigUlZgQmaHbx4RL0qXdHs4hN1HGDozV2HzPHh9QxQgLFZS1f4ID41UkNi+kDd3TtzMNkhjPQmrQfZbXFJQZv27d0vlNs7ODq9mwvsXhcefygr0ei1kYiTts8IG/9hgbkA4T+uGewT6uVgTFGQMofosAHVv6DgFtuOppym3Ad8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL3PR15MB5458.namprd15.prod.outlook.com (2603:10b6:208:3b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 20:16:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 20:16:14 +0000
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
 AQHbax51YyLDQhgFm02bhTgbrhqIz7MfakoAgAuVUoCAAWlQgIAADEyAgAAzSYCAAAQ3AA==
Date: Tue, 28 Jan 2025 20:16:14 +0000
Message-ID: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
References: <3469649.1738083455@warthog.procyon.org.uk>
		 <3406497.1738080815@warthog.procyon.org.uk>
		 <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com>
		 <20250117035044.23309-1-slava@dubeyko.com>
		 <988267.1737365634@warthog.procyon.org.uk>
		 <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
	 <3532744.1738094469@warthog.procyon.org.uk>
In-Reply-To: <3532744.1738094469@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL3PR15MB5458:EE_
x-ms-office365-filtering-correlation-id: bd4ef9a7-1f01-43b7-e33e-08dd3fd89da4
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVFONUZ1QmlhdGZkRzlUZEpvTENhK3oyVm9QbHltbHlsa0tjV0V3TkpUTzJB?=
 =?utf-8?B?R1ZBMVZVcTc0U3lybDZjbHBETXkyYVlueUl2ZjVQRnYrVHNoU3NCWHNZRzJs?=
 =?utf-8?B?TmlGOFNLeWVVUCtXejFsNXFDOE5yODVFN3VKeWpHTVp0RHRXb1paZmZqZ3VG?=
 =?utf-8?B?RGhxUFc3aUYzcDkrS3gyL2x6c3F4TGY2cG1mSlVqTkhLVnRaT0lzTi9Td2l4?=
 =?utf-8?B?OTN4QWFTRk5FbjFmaXB4TjQ5bTRqK3VUa0xKdk9KakdTbmlwQXVQcEZFY0N4?=
 =?utf-8?B?SGpiSUY0cVhmdVRzS3A1L084WVVrNUVVckJjUnlibEVwdkdidzJQWXdqWmgx?=
 =?utf-8?B?dUtyRzJ6UVlTTG5SckVNN3FhenZtVUUwMWsvQktuU3FNcHBGa2ZzZklLdEs3?=
 =?utf-8?B?MGZleEZtNWhnN0p5YUI4bWRNV3dMdEV6UktqaXU5NTF0MjNBNlRxSjJPVTlB?=
 =?utf-8?B?VjVMSmZwTFhZajJmNFNnMHV5WFpUdTJPWHRsSU9TUGVXUXBFSHpPR1MzUEtk?=
 =?utf-8?B?b3RUY3JMSTdnQy84WGlWM1JoNXhPcThWeFY5dXVzSjFySEZJdEY4eVV1WUR4?=
 =?utf-8?B?aWdiMVBPWkd3MlQyLzJybDFRSUduekxyaGg2TitKY29DQUkvTEZJQWltTTdR?=
 =?utf-8?B?anZGc2s0RnB0cTNRNjVRMHQ0aDZNNjM5Mm5tZ2ZqYkE4ajBUTDlzU1RDZlp2?=
 =?utf-8?B?dW9lcjJkWGhqZEtUdXNxVjN5VXVhV0I3QVpKWFMwYnZ0RFZtOTI2WlFUTFQx?=
 =?utf-8?B?QVNVVDFzRU5tOEs5RVdMWTRnSkVRV0FOek9HWFc2VHdOcWY2ZGk2dHBUOTZM?=
 =?utf-8?B?dE1UWi9hL2J4KzRaUXFCbmpKMnlZSkVFcmV4YmVTTkNyblZwSVlRMmo5Um5H?=
 =?utf-8?B?aENQR1Z3Z0xCd1pVc2lZdC9LV3lTeWNiaTJjU0dpRngyMnAwZXVna0FjaDdj?=
 =?utf-8?B?eGlqU1FkV3VJTVRpZ3VmT2x1enFFUG9vK0VkVmhGdnhINVZZSVZHQU1ncU1t?=
 =?utf-8?B?MFA4ZG5VMklEdUVXWGhXSkJ2U0hZeXdCd3JETUg4UXhTN3k2c3E5bENIejdE?=
 =?utf-8?B?cU1mTmVpYldvTno4c3N6aWg1ZExWZTg0TllRSkVVQ2psTXlWQTBESThaby9z?=
 =?utf-8?B?MlFhK25pNEIrSDRiYnBsZURxWlQyUi9wVWhIdTJ4dGprcXQxMGE4VDJUVS83?=
 =?utf-8?B?bm1HMWxqazVsU2ZKdVFYa1ZlSDhnK1AvWU1UVmhhNHNtMmpSZUw2U2Zsdkk5?=
 =?utf-8?B?c3ByYjVQOUpCQXRzV0l4MG5TMlVkdXlqdzhkSzhzQ1BNMUZ1SUgvTTMvOHQ2?=
 =?utf-8?B?VUFZZlNXSGNpTnZyK1NYOTJYSVRxVFdnSGhhOHR3L1RyNy95MndzNThZejhM?=
 =?utf-8?B?d0tDR0NDRHFTL1FuRHB3alRxQTMwRmZEam1HZUcvbFdTdWJkQVg4VHhyNmNi?=
 =?utf-8?B?cXpkS2U3dG5VT0xZUXFKY0ptSS9UWCs3SDhLSUdURmdIRlFaVWtzWElabnhm?=
 =?utf-8?B?djl3T3RtMER2VllQNis2T1NOY2FndmlMaWhOdXoxTmZZNXZ3MTNqS1pIT1gz?=
 =?utf-8?B?R2hHWUl2OWRmZ1MwUFJPVXJPRXFZeUF5NmF4TnBJeGIwRkZ2TFBUWWQ1eUd2?=
 =?utf-8?B?VFpkWFV6NVlOZ2k5R0RoMkpTS2k4WlBldG80SmVkTVhoL3YyUnllZitJTWNt?=
 =?utf-8?B?ZkNPeXI5ZlJsSDdmZ05hc2Vkb21zVzF2M0FUT2V0NVBQNDFLdVN2bXZDOFZR?=
 =?utf-8?B?Kytna2U0Yk5HM25iV253a0twOGQxZm9yeFllSVpKckhENFhkZkpPVXRpYXhn?=
 =?utf-8?B?UUhwVjdrdUVWWmlIWXJIVmg4WlpIb2Vvd0ZwV3JhNkFUUVRrREIrNWE4TkdE?=
 =?utf-8?Q?ZQvLBlwx0Qcu2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elpSaitqOXFhdEd4MWxiRmJpZWhiQ29Ea2ExbFlvVTROMHZycjdtQzZJeU4y?=
 =?utf-8?B?QkhNdlpaSWh0eHVtamRuTkFSeWxCSXpWNGFlbjZFN29qaEJGM3ZMUDdVTTRH?=
 =?utf-8?B?em90WHBCdUlLeXFEcklUcHM0ck5UaHpUU2ttVTRlU3F3ZDhobEFBeTROTDJu?=
 =?utf-8?B?L2c3VStkY0RyRmFybW80dmx0MGRnMk9QM09aalhCVDBUSi9BamhZNnZWOVJa?=
 =?utf-8?B?cCt1OHFxclpEdThTMFZUUG5UWCtLa1pwYjJWWjdxUUtCQS93WkFIR1FoeEFZ?=
 =?utf-8?B?bkVRdUV4eko1L1lnQ2pJc0xnalJUSi9iSFRib25uRVVPWndiVkVyN3RtTVV0?=
 =?utf-8?B?M2diSTF1SmF5RUE0TkFXQjBUQU8zbythWVhEQlJRT24wd0ZPQ2JDQ2Q5VExt?=
 =?utf-8?B?NlRQNWpEQUhqWTNaWG91MlJLV0hPRit4dkovZkhPdGJCc2tJcVBxbklNS0k5?=
 =?utf-8?B?MFZQTDlRandoZ3JlUWRBeDdlV0IyWlU5V0g5VjlZRjRxTHZ1QmRUM28vem51?=
 =?utf-8?B?YkJVN09HM0orSDEvd0xwWk1pVjJ5TXFPOXVSbUNVWjFRYnJSdzEwVWRPL2dV?=
 =?utf-8?B?OGRsRzA5ZGZZOW9mQkt6RU5SSTh5UENtUmJsR0VsMVVJS2I1TXRHNHo0NkhO?=
 =?utf-8?B?OXJMQzhia1ZKOUhVMk1NbTNtbnkzV3pyNm9HQUFDdzdtR2FyWmxWQ3JhWEJ0?=
 =?utf-8?B?M3h6amxqWDJOY1RySnZzRmxHOFQ2TTFNcGhqd3gxZERjNTNseUl6U1lxT0pv?=
 =?utf-8?B?ZU91KzZnL2tIdlh2UURneWJScnZKMGFmUHNvVVczUVg0UFNDYnR5dm1leVB0?=
 =?utf-8?B?T2xyRU1mMkZ6OVlkNXJYakJaTHF3aEVvajVuOTNrTWREempXV3ppN3hCbWZ3?=
 =?utf-8?B?b3pjaEdpMnoxMkRqdXBIL05SK1RaeHhqWDE0QzBWVTErUFpBNDIrY3FPVTd0?=
 =?utf-8?B?SHFuZWkvaWI1SWJCb3BtMktNWDRBL21vWURWVzRKdURCbFdydUVHakQrcjFK?=
 =?utf-8?B?R2RwZ0FWS09wTUY1b3YyeW9BdS9XdGZVbHZ3anBJc1U3N2pxWHFXRFhhTWhD?=
 =?utf-8?B?WEhJU3gxaHhmc25JKzJKMG9tT2V1MDNXQlcrRjBmRVpjVHNxa3VPdXV5TTdt?=
 =?utf-8?B?VTl1S0JLM3BQYmp4RHNrZFBrOU5hRytCdlNGVFBRR2tFamVNa2IxdSsyZTBq?=
 =?utf-8?B?NXMvVGZ5Y1dlNkV4Mi91QU5ucnAvNlJWUW5hcyt2a2hjVVhtTmVtMUpvcFhG?=
 =?utf-8?B?MEFHRjdrK2wzNmVGWkg5U3BZb3o5ak5Jc1VlL003NXM5NENRVHhPdktIYzY5?=
 =?utf-8?B?dk1ualR5TWZEUmw5MFlNY3IrNlBlTWloMEd3bHdkZ0o1cUZXUFM3cFJHaHhL?=
 =?utf-8?B?NEtMTHRJNWp4T1JrR2JlczFWL090dEZ1UFZ0Wmw0MW9Ob1RFaXRzRmxGVTZE?=
 =?utf-8?B?d1p1YUVoamtXYWw3SjluYWtmV0FWTGxubE9HeGVZVmtXOTl1TVp5SjBSTGV5?=
 =?utf-8?B?NDVMMzNibis5KytXaGUrRWpiOVFtT1ZHVk5mQTRJYnpvYnlOQnJNM3FsRXls?=
 =?utf-8?B?ZEZ1aERzdVMyS2xhbVFST0Y3bUt1QUNnbTVBdElIU2VSSmJHUFBESDlzRk1n?=
 =?utf-8?B?ekQ2M3doS3dFbklWWWQxZ01sQnhkbzNvclpuMysxa0JGbUpabUZYN3I0c2Nu?=
 =?utf-8?B?aWJDbzdKN09SSGd0MkdGL2Q5bHNqVTVXZW9iMlBUMXdadWN0d0dqMjhZVXJ6?=
 =?utf-8?B?dXhKNjZzTFplTSt4Ry8zWjRzSUdzU1RSTEp3SWg1ckVzdnFsa2I0bjdmT3hr?=
 =?utf-8?B?d0VoZGNRN25qNkVNd0FwdlkrSGR4aG4vSExlMHgxdDIvTVRkbnNLNFJLVWxU?=
 =?utf-8?B?akIralRQSXR5R3prSkRxU2lkL0E3ZzFPSng5TVBGL3lyQ3lrRWsrY3ZRdUFP?=
 =?utf-8?B?Y1ordmxqczA1VzB0WEk2cFQrSEhxTnlzNWtvR0xHb09xOEltQ0tpVXFvUlZE?=
 =?utf-8?B?SEtEUVNPRzBMeWpYN0hRaXZiNXZmamRzYS9GK3BOWmtOOGZZMEFZcVErYlEw?=
 =?utf-8?B?d28xSmhKdForMnQvdWJUR0VGZkJwQ3BDUC83WG9pRjE3aUFXVGROeVkvSXBH?=
 =?utf-8?B?U2djeld1WXM5VXJhbWdYQVNSaU5BbTRwSVZvam52U0lJNGIrYU5FWTMvQllC?=
 =?utf-8?Q?QeuTJGNwPgX3eLT0+M2WHrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <066CB47AB8AB0742AEB40792DA0A9266@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ef9a7-1f01-43b7-e33e-08dd3fd89da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 20:16:14.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLniaVBwQRmlK7E+wpFAZFVn3b1npfDCZcvfcTUHfSSSvl9bEvKXdy4bgHaq5JhYWfiK1PDiiUbHD9nzYiKIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5458
X-Proofpoint-ORIG-GUID: ZY08wLL39mijGD_wjPTJHFEOFyLHQ4YP
X-Proofpoint-GUID: o0oNiw3_DSkbcRGBvJAludLpsiCtV2M-
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280147

T24gVHVlLCAyMDI1LTAxLTI4IGF0IDIwOjAxICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBJIGFkZGVkIHNvbWUgdHJhY2luZyB0byBmcy9jZXBoL2FkZHIuYyBhbmQgdGhpcyBoaWdobGln
aHRzIHRoZSBidWcgY2F1c2luZyB0aGUNCj4gaGFuZyB0aGF0IEknbSBzZWVpbmcuDQo+IA0KPiBT
byB3aGF0IEkgc2VlIGlzIGNlcGhfd3JpdGVwYWdlc19zdGFydCgpIGJlaW5nIGVudGVyZWQgYW5k
IGdldHRpbmcgYQ0KPiBjb2xsZWN0aW9uIG9mIGZvbGlvcyBmcm9tIGZpbGVtYXBfZ2V0X2ZvbGlv
c190YWcoKToNCj4gDQo+ICAgICBuZXRmc19jZXBoX3dyaXRlcGFnZXM6IGk9MTAwMDAwMDRmNTIg
aXg9MA0KPiAgICAgbmV0ZnNfY2VwaF93cF9nZXRfZm9saW9zOiBpPTEwMDAwMDA0ZjUyIG9peD0w
IGl4PTgwMDAwMDAwMDAwMDAgbnI9Ng0KPiANCj4gVGhlbiB3ZSBnZXQgb3V0IHRoZSBmaXJzdCBk
aXJ0eSBmb2xpbyBmcm9tIHRoZSBiYXRjaCBhbmQgYXR0ZW1wdCB0byBsb2NrIGl0Og0KPiANCj4g
ICAgIG5ldGZzX2ZvbGlvOiBpPTEwMDAwMDA0ZjUyIGl4PTAwMDAzLTAwMDAzIGNlcGgtd2ItbG9j
aw0KPiANCj4gd2hpY2ggc3VjY2VlZHMuICBXZSB0aGVuIHBhc3MgdGhyb3VnaCBhIG51bWJlciBv
ZiBsaW5lczoNCj4gDQo+ICAgICBuZXRmc19jZXBoX3dwX3RyYWNrOiBpPTEwMDAwMDA0ZjUyIGxp
bmU9MTIxOA0KPiANCj4gd2hpY2ggaXMgdGhlICIvKiBzaGlmdCB1bnVzZWQgcGFnZSB0byBiZWdp
bm5pbmcgb2YgZmJhdGNoICovIiBjb21tZW50LCB0aGVuOg0KPiANCj4gICAgIG5ldGZzX2NlcGhf
d3BfdHJhY2s6IGk9MTAwMDAwMDRmNTIgbGluZT0xMjM4DQo+IA0KPiB3aGljaCBpcyBmb2xsb3dl
ZCBieSAib2Zmc2V0ID0gY2VwaF9mc2NyeXB0X3BhZ2Vfb2Zmc2V0KHBhZ2VzWzBdKTsiLCB0aGVu
Og0KPiANCj4gICAgIG5ldGZzX2NlcGhfd3BfdHJhY2s6IGk9MTAwMDAwMDRmNTIgbGluZT0xMjY0
DQo+IA0KPiB3aGljaCBpcyB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCBvZjoNCj4gDQo+IAkJaWYg
KCFjZXBoX2luY19vc2Rfc3RvcHBpbmdfYmxvY2tlcihmc2MtPm1kc2MpKSB7DQo+IAkJCXJjID0g
LUVJTzsNCj4gCQkJZ290byByZWxlYXNlX2ZvbGlvczsNCj4gCQl9DQo+IA0KPiBhbmQgdGhlbjoN
Cj4gDQo+ICAgICBuZXRmc19jZXBoX3dwX3RyYWNrOiBpPTEwMDAwMDA0ZjUyIGxpbmU9MTM4OQ0K
PiANCj4gd2hpY2ggaXMgInJlbGVhc2VfZm9saW9zOiIuDQo+IA0KPiBXZSB0aGVuIHJlZW50ZXIg
Y2VwaF93cml0ZXBhZ2VzX3N0YXJ0KCksIGdldCB0aGUgc2FtZSBiYXRjaCBvZiBkaXJ0eSBmb2xp
b3MNCj4gYW5kIHRyeSB0byBsb2NrIHRoZW0gYWdhaW46DQo+IA0KPiAgICAgbmV0ZnNfY2VwaF93
cml0ZXBhZ2VzOiBpPTEwMDAwMDA0ZjUyIGl4PTANCj4gICAgIG5ldGZzX2NlcGhfd3BfZ2V0X2Zv
bGlvczogaT0xMDAwMDAwNGY1MiBvaXg9MCBpeD04MDAwMDAwMDAwMDAwIG5yPTYNCj4gICAgIG5l
dGZzX2ZvbGlvOiBpPTEwMDAwMDA0ZjUyIGl4PTAwMDAzLTAwMDAzIGNlcGgtd2ItbG9jaw0KPiAN
Cj4gYW5kIHRoYXQncyB3aGVyZSB3ZSBoYW5nLg0KPiANCj4gSSB0aGluayB0aGUgcHJvYmxlbSBp
cyB0aGF0IHRoZSBlcnJvciBoYW5kbGluZyBoZXJlOg0KPiANCj4gCQlpZiAoIWNlcGhfaW5jX29z
ZF9zdG9wcGluZ19ibG9ja2VyKGZzYy0+bWRzYykpIHsNCj4gCQkJcmMgPSAtRUlPOw0KPiAJCQln
b3RvIHJlbGVhc2VfZm9saW9zOw0KPiAJCX0NCj4gDQo+IGlzIGluc3VmZmljaWVudC4gIFRoZSBm
b2xpb3MgYXJlIGxvY2tlZCBhbmQgY2FuJ3QganVzdCBiZSByZWxlYXNlZC4NCj4gDQo+IFdoeSBj
ZXBoX2luY19vc2Rfc3RvcHBpbmdfYmxvY2tlcigpIGZhaWxzIGlzIGFsc28gc29tZXRoaW5nIHRo
YXQgbmVlZHMgbG9va2luZw0KPiBhdC4NCj4gDQoNClllYWgsIEkgYW0gdHJ5aW5nIHRvIHNvbHZl
IHRoaXMgaXNzdWUgbm93LiA6KSBJIGFtIHJlcHJvZHVjaW5nIHRoZSBpc3N1ZSBmb3INCmdlbmVy
aWMvNDIxLg0KDQpJdCdzIG9ubHkgdGhlIGZpcnN0IGlzc3VlLiBBbHNvIHRoaXMgY29kZSBbMV0g
ZG9lc24ndCB3b3JrIGJlY2F1c2UgcGFnZSBpcw0KYWxyZWFkeSBsb2NrZWQgYW5kIGl0IHdpbGwg
YmUgdW5sb2NrZWQgb25seSBpbiB3cml0ZXBhZ2VzX2ZpbmlzaCgpOg0KDQoJCQlpZiAoZm9saW9f
dGVzdF93cml0ZWJhY2soZm9saW8pIHx8DQoJCQkgICAgZm9saW9fdGVzdF9wcml2YXRlXzIoZm9s
aW8pIC8qIFtERVBSRUNBVEVEXSAqLykgew0KCQkJCWlmICh3YmMtPnN5bmNfbW9kZSA9PSBXQl9T
WU5DX05PTkUpIHsNCgkJCQkJZG91dGMoY2wsICIlcCB1bmRlciB3cml0ZWJhY2tcbiIsDQpmb2xp
byk7DQoJCQkJCWZvbGlvX3VubG9jayhmb2xpbyk7DQoJCQkJCWNvbnRpbnVlOw0KCQkJCX0NCgkJ
CQlkb3V0YyhjbCwgIndhaXRpbmcgb24gd3JpdGViYWNrICVwXG4iLCBmb2xpbyk7DQoJCQkJZm9s
aW9fd2FpdF93cml0ZWJhY2soZm9saW8pOw0KCQkJCWZvbGlvX3dhaXRfcHJpdmF0ZV8yKGZvbGlv
KTsgLyogW0RFUFJFQ0FURURdICovDQoJCQl9DQoNCkl0IGxvb2tzIGxpa2Ugd2UgbmVlZCB0byBj
aGVjayBpdCBiZWZvcmUgdGhlIGxvY2sgaGVyZSBbMl0uDQoNCkFuZCBldmVuIGFmdGVyIHNvbHZp
bmcgdGhlc2UgdHdvIGlzc3VlcywgSSBjYW4gc2VlIGRpcnR5IG1lbW9yeSBwYWdlcyBhZnRlcg0K
dW5tb3VudCBmaW5pc2guIFNvbWV0aGluZyB3cm9uZyB5ZXQgaW4gY2VwaF93cml0ZXBhZ2VzX3N0
YXJ0KCkgbG9naWMuIFNvLCBJIGFtDQp0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0IEkgYW0gbWlz
c2luZyBoZXJlIHlldC4NCg0KWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjEzLXJjMy9zb3VyY2UvZnMvY2VwaC9hZGRyLmMjTDExMDENClsyXSBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni4xMy1yYzMvc291cmNlL2ZzL2NlcGgvYWRkci5jI0wxMDU5DQoN
Cg==

