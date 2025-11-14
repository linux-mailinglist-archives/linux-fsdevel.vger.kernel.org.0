Return-Path: <linux-fsdevel+bounces-68546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3AC5F4EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BE03AFC0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC228C860;
	Fri, 14 Nov 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8BLZJE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C642C1583
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154057; cv=fail; b=Imq6qMG/BzJ9qqS8NZKkRK42axmtY65tqTeJGVampPO9kIOaahahNvugkFc8UNKLCHFljfN0yCCCjtaC6vbbg/TT8w5D/HK4YFbpAtqr+Ies/Qgsemo76ioPfyiLfK9FxEkjKHLnKrddtgiVWFh1ChdcY5gdu7x4BGQ5rx5+0wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154057; c=relaxed/simple;
	bh=rRz6oPwc7kEC4i0iV+/nmtFiVbWCfWRbnp8fSyt+08s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=R1Bo/VeFX9/cwu1A7VZ77vpAfXTyaiDXHTZjP1Q5GFqxtv/k78jdJPy/vI3HXMMqlLowpCqqwZYdwUfHq4m4LDAZyOIGixAJr2J9PbXZgg4dlwC7CNBNTg1tTFGem4QqAOTGbf4qwQu02CA2dQoIU/sfVrPnE/CCvOJKIwEKUi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8BLZJE8; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECiN3w029217
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 21:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+FAA41yTuOtZfbAfNM6Wu9Pi/pA+UQ/1IQ2jOHFhO+4=; b=P8BLZJE8
	6WVhcMK+Lho6SdySOS7xFCa0XWOrgFCFDXkXHusvhOQFsx1vq9gmwpDPgX48ZT0Q
	jKGrHnL08nCv8f6T3Gdpm1AarQezAnmpLnxcbpSrAbAwlSZTEa0wlj2o83eCMKPb
	78Iu3NLFce8pVWpIC79KbpJ3W+DNydGzyGL0slWCod9BUP35xo8dB+SdGO865s5l
	ij+JD1B556B1xhVHBiiuHlgbII7AvQSFz0W1dsA5ttb+Rdrl7cq/D3MrEdCFBOTv
	rqoi1ruMHK+Uy+IMVs4Vylsqsd6HQnOjvKYuvosM4mv1/84Cqdt6zBJQjwAkMVHw
	i5v1UOVHJZldgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrevmkk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 21:00:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AEKg772010322
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 21:00:49 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrevmkjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 21:00:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TibCnnFpl7R3NouV17VoJxKTwERGV98ZoFrk2zjsaJ81cOBIXGn5E+282bFvbqhpVSaaZsvkiYq+Q2d/uzqWDHaMiAQiuqTVGbgM4dG5o+MYwd9by77hsHBLC4041gliYm130CEa89eoGh3B9ls3FYbF016RUFSwcDoKK7q2WJryaS5dCfYr07IVNbt1kwatza9YU2m2dUfxpIvO4XYyPPJ2byYkL9rKYgZP39NaLwOoUqY7Av6PGGlZDOKoKE1k3oVu42nNAGujtjlN7qOUrULgPR/xdj0Q/TehabJIhB95J9zaELwl8S6NUpGnTr3UcO2X/YFDmmBWQGdUM6NCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPtTHsu6bdUAdSDp6tuMt5kWITa3I8RHWThdeUlfCvE=;
 b=WRqxPi/Z6kTjIbAqOVrlFREpZridhiCLC5UnNdQm+48v2leMg3XbzGzpUAcDpzG+TeoaRQQA68G2vSlWNI6KOIRyYuYMneCiC80Tiozrnxux+nPKXrtXZGNs2s31Gh7hpg+nHRf+JTu9tSOdGWrHKySYsBxROP3a40RdlOXZbXLkLKAOl/04u3YHxgnV57St8f6tH2TydVbLiCjr2Exvj3wrGIJ0SupPlc/jN7dbGU0jteVEuGyxNavSHFBZ4Dr7S3iBZC1BFeoi0DsKbv6lf3+5664SNzUNpUSpwbrH34K/DxKKRu8DC817juhkT9pw/gVLApR5f3pN04gmW6NdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPF62EA23344.namprd15.prod.outlook.com (2603:10b6:518:1::4a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 21:00:42 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 21:00:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] hfs: Update sanity check of the
 root record
Thread-Index:
 AQHcUpZLAPwxcKLosUu6MBLxDDnp+7Tsj/2AgAANkACAAOuCgIAAjrOAgAQmCgCAAHB/gA==
Date: Fri, 14 Nov 2025 21:00:41 +0000
Message-ID: <1bdcb4caa7cd51b56cdbfa418324196f41fd38f3.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-4-contact@gvernon.com>
	 <ef0bd6a340e0e4332e809c322186e73d9e3fdec3.camel@ibm.com>
	 <aRJvXWcwkUeal7DO@Bertha>
	 <74eae0401c7a518d1593cce875a402c0a9ded360.camel@ibm.com>
	 <aRKB8C2f1Auy0ccA@Bertha>
	 <515b148d-fe1f-4c64-afcf-1693d95e4dd0@I-love.SAKURA.ne.jp>
	 <f8648814071805c63a5924e1fb812f1a26e5d32f.camel@ibm.com>
	 <d8cc277f-c14c-4aee-ac0b-cce2938232d8@I-love.SAKURA.ne.jp>
In-Reply-To: <d8cc277f-c14c-4aee-ac0b-cce2938232d8@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPF62EA23344:EE_
x-ms-office365-filtering-correlation-id: 32c472b8-4ead-4846-9d86-08de23c0df41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWNnT21mSGRVSVcrMnpWanhGTXZlaGY3N09BSFN4aCtWbDgzOEFkdGdlVm43?=
 =?utf-8?B?RzhSSExjRTJOakErc1BwclozTW4zaUpDOTIzNHEzcmNzSU1DejVUc1AwMUo0?=
 =?utf-8?B?VUFiQmRFYzVBY25LbytjMEtuaDZQcXV5emlxYTE2eGxxWTJnRFVlbzlrWS9M?=
 =?utf-8?B?TExPWWQ0SkFWM255dWFUWDN5ZVZQc1Niakk2OWo5L3pvRWNnTzNPUFRwMGpt?=
 =?utf-8?B?ZVUzSzhLTmZzVlFBNmhQL0xCQ1FFckJ3NjZkd3puTFBNbHFBYTRhUHRmOHFB?=
 =?utf-8?B?QXpkQmdMcno1WExHdmtvYmFHVTZiN2ozWVB1QUJURHZab2lxSFlUSmd6eUs0?=
 =?utf-8?B?dGllRDNvVjRwZ3M4TTlJbk01dkRmTG5QejBIdmtab2NkdVhyQ0E3My9jMFVG?=
 =?utf-8?B?Z1p4N1NucGZ5MUloWHAzMHFvTVVOY3R0cGl0eHhob3BVNHJxZExieDdOQUdT?=
 =?utf-8?B?NE0ycm4vd2c4S3FpNm9TeEl3clpFM1Z2ZFNLUVNRaWR1T1hmc3ZQaGJzcGx0?=
 =?utf-8?B?YVd2TExCVFpWbnFiUUY2THpyRW1rZDdZVGFlN2xNSjZjelJHZ3NsYm1iY2o1?=
 =?utf-8?B?QVpQOU5HTWdDcVk1MGRpWitIM09XZjA0bUo0emw2YzVzRXoyYTVZRWNUSVdj?=
 =?utf-8?B?Z1JnTlExZlQ0akkybTFUMitzSS8zL3dTbTkzckw0ZTJ0cXF3c2NmRWZoaEFh?=
 =?utf-8?B?QTlHQklOT3hQN0d2MCtlTTJZSmFPNXNCUVluZFE5RmRyWHZ4d29ldmlqQUlS?=
 =?utf-8?B?akg2RkpNRGxpaldzL3pPbnFQK2JtdVBjRHM4dHByQ2VrWUhsRG00MWErbHpQ?=
 =?utf-8?B?Y2QrSVFERGFnQ2FFMU1yV3daN1Z3RmFKc1YvU2htVGZwYXFkVzhueDkxK1V5?=
 =?utf-8?B?SlRISTB6RmRKa1VTYUxwb2dlcDB2UjhvKzQ4K3FnTXVWbTU4ZW5qSXNMVXpM?=
 =?utf-8?B?NkwxTW05REtncUUyRHdQRTU2dFRwWjY1dXJBUmMrcjYxTFdHY2Mra1l4WkNE?=
 =?utf-8?B?WWNibzFzV3kzSTNrejQrd1VNcVEvbXpMeWZ2THFBaVp4VlVVK2pVTTBydnI1?=
 =?utf-8?B?ei9uZTFmQzhkMEpuU2wwbjBvb1BJSGRsZTV3SlhBWEpra2xUUVpXNk5nRndj?=
 =?utf-8?B?cTFKdk9CbXRjYTVRVEtiUTVGeHFwSTVBRVVON2FDVHZQdUFYZUdtZE9lYVRQ?=
 =?utf-8?B?cG5JSmF2WTBaS0lOaHlab3c3eSt0V3E2ZGFJaGtGTmliT09SK1MxYmZoa3cx?=
 =?utf-8?B?b2VwRmhrUmJoQUpaRXd2SjY3L3R1Rzc4c2l1VVlmNXdYc0hhOHFnUFI5d1lq?=
 =?utf-8?B?TVBucGdRcXA0QjRMTW9ZOERYWnBDbDgyWkJ4TlpTWE1TT1JTZXl1QkV0SGw4?=
 =?utf-8?B?Q1NGVFN5cXlJMkZGL0pRdFdYV1lUeThrNzdqVS8wQlRJWVd6aDVLcm5kSTlx?=
 =?utf-8?B?cVR4T1lBcW1IYzZDZVhINjJyZXNGdXRSUVFONjkxU2UyVGRvZlprUUNpSitp?=
 =?utf-8?B?aHJmOE5QSkZXdlJkM2NDMzltYXJKM0t4R0ZLcU0wejMrQXUweGhqMzEvcnoz?=
 =?utf-8?B?c0d4L3ZaR2ZQaXJUSGd3OUFPRVRsOU0rd0JIQ3ErT2xNS3Q4TEJMY3lVOUp5?=
 =?utf-8?B?Q2ZIVmJ4YkpCNjVOVHI0Mm80RmI1OUxKS0dkd1NSMHVnaWNKMmpINzN1R2w1?=
 =?utf-8?B?c2tGWFBaWkVDeVFRZXBXdnBWWEJ6dUs3NXdkMXhFNEFRRXVLaVBRU1I3cURh?=
 =?utf-8?B?MVNyU2twNWkzbVJEdFgwVm1ySTNpSlRMbTY0eVhnL1VyZ1I3d0lGNExGNDVI?=
 =?utf-8?B?c1dhMFh1dlg2cjR1LzcxNmZ5aXlQVWNENkVIY0ZzK3paNDdLRDNYVzlIOEYz?=
 =?utf-8?B?QjFseEIzaGh6VS9FZkdYMkQxKzlLR1RQQVFJYy85bTU3SFdEekYxNVg0WHgz?=
 =?utf-8?B?THlTVDJNc2JqeDFUYU9EbU1Ka1JvZkFuSjhxSS9IQVhaeGh6eG9wZ3dFVnhE?=
 =?utf-8?B?MkI2Z3ZYUGdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3BzeG8wZFlnK2lFdWIwM25IbGlQeC9oc0tGd0MwQjhCejlnc0NnU2I1NEdh?=
 =?utf-8?B?ZXlKaG45UWVZTytmVXl3S0t5eUM0RDNmSXh4b3l4aUE4RU9aY1djQkIzUmNp?=
 =?utf-8?B?SitnTjZYWnFRLzNPelVhaVJCSVBGTWpDODRGalFRWHZhRExUVzFHekhHa3Iy?=
 =?utf-8?B?RzltVUc4SVcvUllHdkZuaEt3Y0syVnRJZFNyZlFuOGNBZjEvVTNJa0Q2dHg1?=
 =?utf-8?B?UVZYR2lDREluNnNiZjg2S0RMYTlCVTFPdXJGQVF5QTdNelZxQjV1VElFNmpV?=
 =?utf-8?B?N2FmY2RSeFpxdEdoZVJWSDJUSXJVSGwxS2JDVGpXLzdoTEROQThRazU4M0Nj?=
 =?utf-8?B?Q1RwbmQyMUo4WlFHU1NwQnIvajhaWGFaZ0M2bjkrNWdUS3I5bTQ1UUY1SXd6?=
 =?utf-8?B?MjJrOUF0cFJzQU90WjJDZEpFVkJqalVIbkNBOXJEWE14SG41N0p5aE9iZ2pJ?=
 =?utf-8?B?aS9zNkFqOHJmSXdBVXN2bkxVOXlIS2QrZGQ1YXBWRnJzVmlZbmtpY3BSaXNK?=
 =?utf-8?B?SWNxbEh5eTkxL3BsRExLNjlsdDg3eUZSRmdWcU13UEdQWXhTS3huNTFQTGhX?=
 =?utf-8?B?NFBFQ1oyaEE4QS9qYmVyNEdJZDMyK2JEbWl4dWRsT3FCeW9sQ2xNM0l1YkFu?=
 =?utf-8?B?bkFWSGJlcFduSElmYTFteVhOSlZWbEkzbWNubEJWaXdDZ2QxV3pCaHpMaTM4?=
 =?utf-8?B?Ry96d2xQMUNYZ3JoQUIyalYvdXRFcjZhQnNESGVCUC9yQlVudUNBV2hTb0ln?=
 =?utf-8?B?WFNlR3JaTWVvSWYrZGlEQmhDMXhrRFlLaGNpQjQ1LzdqMEprSWovaUVSa2xX?=
 =?utf-8?B?eE9zY2RJckZDM3NuVTA2OExkaXI3UE5GOWtRallYbzVFcC8zdkQvR09MVG5n?=
 =?utf-8?B?ZmtHVm1Ua2pJQ1YyZUdleWh5TXhETmtDUTFzdGVrNGFvR0ZrV3l3T2hBbk1i?=
 =?utf-8?B?c1ltMStzQTNubFkva3FsUk1HQTQ1aW5xcTlEaWpOc21uM2hnVUF5UFIzbXpD?=
 =?utf-8?B?cUMxVFlUM1A0VDJvWUtlUmFxSXdVTlpuVTBoNGtDQVhMR09QUnZRRVJCdHZq?=
 =?utf-8?B?bU9BaE1WR0t6ckVtajVjRWk1eFQweCs3c3JSUndWb3JQc25WZjJKNUp1VUcr?=
 =?utf-8?B?V2JkblgvVm5RSW10ci8zTUVlZ1hPZ0dZL0NBT2htQ3JheUJ5L0NFVlRSSkx5?=
 =?utf-8?B?NFJKY0hCQTRwZEhUNUdwR0FPYkM2c2c0bDhiK2g0UDYrWUVTUXkrbjZEWE5q?=
 =?utf-8?B?UFFKQnE3RmlTUGkzbkRHNzV3bEVsUVpjQThXV3dIMEcxQlBkSEFDQUVpMk9q?=
 =?utf-8?B?end6ZHQ2bUxHb0pyY1VxNU1MSlppY0hJcVJwZDA2VjNPdmJEQkFGSXZXMXVy?=
 =?utf-8?B?Vm9GcE5HQlplcC96eGpySnVnSU0yOTVzZysrN21LK1BzZitDcXlnbXZyWlZ0?=
 =?utf-8?B?U1lQbjBvMkh2ZHZnd1BDVnpPSGRCZFU1NTdNYXJkckduajVmclBnbE9BaEtv?=
 =?utf-8?B?OHRxTFJBd2hlRmlzejA1WDYwOU9lZDM3WTlOQVBjZkJORS8zZDZDdmVpRFlL?=
 =?utf-8?B?STViblhzaDVxN2Y2LytPS2tHTEp6aHkyUU1oSUlGVEFQb3UrNy9yM01BYnVj?=
 =?utf-8?B?WktXRGxiMjZpaEVNUTV6MGpoNElvZFpHWnBYT1FBSis4KzNNUDFGc2V0RUZX?=
 =?utf-8?B?Z3FWTVlqcU9xL0t5RWwyYTRiZEUvY3pJR0JOdm54S200VlNnczZ4bEV4Qy8y?=
 =?utf-8?B?N2lBMWljTytwaDZHdUR6dlFPWkRpakNXMGs1MVZXL1dKS3huU1g0dzlYQ1Rm?=
 =?utf-8?B?UCtSY0RmbndNdk9Zdm5sMVdPanNPM2ZFblVTdXhWZEhTYldnODkrM1FIak4r?=
 =?utf-8?B?dFltbjZqT1VVNjkvVVZUQWY2dGp6K1dHelppeTUzVnQ0ZW1YQXhxdk55UjlF?=
 =?utf-8?B?cEVnMEdhSGdZczE1VTE5SFoyd1J3WFNwUE9oMy8wZHdJZFVFOXI2cHVtSWZr?=
 =?utf-8?B?U3lIRzZBNk9FSHBRdTJwcVJtdEw1K1NRNVduK3ZUWmlyb2tiUXhyOGJOdVN2?=
 =?utf-8?B?THJnSjk3azZoVVJNbks5TXV5dmIvaTJKaFJ4YnpINDNPVzB6Z240NVRZUGlu?=
 =?utf-8?B?SkFSb3RFcGl2bWhDQk1qUFI3Z0hTWHdCdzBpejNHQlZnMC9oS3dWSmh6SUxT?=
 =?utf-8?Q?sJcSsKdyw31ZQiDFPr5DYRQ=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c472b8-4ead-4846-9d86-08de23c0df41
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 21:00:41.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0IzRhVyGimA2N8epOiBeBdjQjr5ZZV66V6Ok7db98YVLeQiH6v6hhy8beqBYHqhvLFUt4b4C0ZsqKRSGHGXGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF62EA23344
X-Proofpoint-ORIG-GUID: 7yUFUMKAZTdsRWGMM1tGedZZNd5Zo8VI
X-Authority-Analysis: v=2.4 cv=E9nAZKdl c=1 sm=1 tr=0 ts=69179880 cx=c_pps
 a=PV4nF49JPTCcgS+SffkoNA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8
 a=e1ohb3Eh0mMljjhsmxsA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfXxGnMdQTU6wdz
 tjc9Ark1oEvqDb/szAuBcVXtuxmkiazsPiLrXiuQboGimyhWRt7JN112AcFIrarWeMtiEky6gPh
 V9Y5I+cSDA+RIL+mIJqiR8usD0ssqgY+HDZw4R+NsutWu/ioOyzYwLr8qAFWrrMLPYUs0+O73pR
 Aa26U6l4vSlp2/naekMVUGMZUkx3Q04PAZMIgjpaWHGuzFWnrMgtv1HiEqybhZy/eNibkW6UZVy
 S0tYowiZVndyE2jzbmGrGX1HN5YA5Xe6GU1hERUIHWa9nNk8ixU30+v14WrDmdJEy2kNXUnpwJ8
 sVK/QbxXsjYMuWZ8slg6tP/ULc26RomrnbVV7wogTzHcxVHLYnCRXmUCSPQenfJXzPKSOLs2/pc
 U96b85wUU7g7a1Uup0aISJ/Ndj9IOQ==
X-Proofpoint-GUID: 7yUFUMKAZTdsRWGMM1tGedZZNd5Zo8VI
Content-Type: text/plain; charset="utf-8"
Content-ID: <A168E4715CE013478D53C5BED994CD79@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 2/2] hfs: Update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511130179

On Fri, 2025-11-14 at 23:18 +0900, Tetsuo Handa wrote:
> On 2025/11/12 7:56, Viacheslav Dubeyko wrote:
> > The file system is mounted only if hfs_fill_super() created root node a=
nd return
> > 0 [1]. However, if hfs_iget() return bad inode [2] and we will call
> > is_bad_inode() here [3]:
> >=20
> > 	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> > 	hfs_find_exit(&fd);
> > 	if (!root_inode || is_bad_inode(root_inode)) <-- call will be here
> > 		goto bail_no_root;
> >=20
> > then, mount will fail. So, no successful mount will happen because
> > is_valid_cnid() will manage the check in hfs_read_inode().
>=20
> Do you admit that mounting (and optionally fuzzing on) a bad inode (an in=
ode
> which was subjected to make_bad_inode()) is useless?
>=20

Mount will fail in the case of bad root inode. I don't see any issue here.

> Adding is_bad_inode() check without corresponding iput() in error path ca=
uses
> an inode leak bug. Also, error code will differ (my patch returns -EIO wh=
ile
> your approach will return -EINVAL).
>=20

I don't see any problem to add iput(root_inode) as part of failure manageme=
nt in
hfs_fill_super(). And we can return any proper error code for the case of b=
ad
root inode.

> Honestly speaking, I don't like use of make_bad_inode(). make_bad_inode()=
 might
> change file type.
>=20

If Catalog File's entry is corrupted, then we cannot assume which particular
file type is correct one. And nobody will operate by bad inode. So, it does=
n't
matter which type bad inode has.

>  Also, I worry that make_bad_inode() causes a subtle race bug
> like https://syzkaller.appspot.com/bug?extid=3Db7c3ba8cdc2f6cf83c21   whi=
ch has not
> come to a conclusion.
>=20

Frankly speaking, I don't see how this issue is related to the HFS mount
operation.

> Why can't we remove make_bad_inode() usage from hfs_read_inode() and retu=
rn non-0 value
> (so that inode_insert5() will return NULL and iget5_locked() will call de=
stroy_inode()
> and return NULL) when hfs_read_inode() encountered an invalid entry?

Bunch of other file systems use the make_bad_inode() and in fill_super() ca=
ll
too. I don't see what is wrong with calling make_bad_inode().

Thanks,
Slava.

