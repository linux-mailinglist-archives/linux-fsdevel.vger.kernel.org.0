Return-Path: <linux-fsdevel+bounces-40422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B593FA23390
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20148164A16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A01F0E23;
	Thu, 30 Jan 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DItxLIQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11B3B19A;
	Thu, 30 Jan 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260500; cv=fail; b=I4PNts9XCPwToqukVfDu6Wgwj+wLW0QAZuUXBlo9xQuDYwibUehrc0aJBSvEXI3TUS6lmkUlSheNKO1tC8AmsFbkdjQbA292K5Gdes18KWStUtAGK6+pGAouZwudGh9NUpAEEXzP1POxk8wb6zfpuh2xndE8gt2//KUYqOSJ3L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260500; c=relaxed/simple;
	bh=ODXZsSLK0XiwM0GVfBo+54gBJjhT6I2fHOqDXvexy48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bnMDtTMEiLPRvZiDttwo6Y+JojBdaGOptW5osoRPJde0LnYXkhvlbI9yIL2cqNmbJ9q+ZIcMHiXPT2qesS8LOwhEazYH/VLaChq1NzqyD27G9DJdLuctQDOrKyLzEPrbF63kB3j6/Az6KgsSMdXZRbMK8fymMVV+hvInVAfqTwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DItxLIQv; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UHbR7P014712;
	Thu, 30 Jan 2025 10:08:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ODXZsSLK0XiwM0GVfBo+54gBJjhT6I2fHOqDXvexy48=; b=
	DItxLIQvzB3pd+mIcHgUEyT8mfmZTVrgGWfyYgiW4h4L+r3aNUPsFikzIRKjWt26
	7daDHQpY8MDVfP3hrf19QvnCqq3jGNGz16Qn2TPmuzx3mNY2Et5pJkeOgbkZWDc6
	M5lEH5T30wqTtGFUV9IP3G2tlHLsQgndwLuOF+zckunKejj+1jBwTktYhutXEAiT
	6sYbVJ+BsFnv+G9GJsUCnsJbfj4MQUEJWuUhLCzzEBRQL3DwphGOX1+ep/ATWyqe
	1aNpo1wCLgDuy4NtjOXHuvAemnk9HIMVEbXTTYHCZWE6JMgvqSOoWNKW5Hqr8Kln
	H9uF8fpYWNaSlEnKPI/W5w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44gdghrg77-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:08:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq2Cgx1rq6WzoXk/96hULiLeQAzZXdDFd5Wxcwosw0Ab3XzePYgTRlislG1UzWx+SX0D6/yEe8ecUQykJzIsO5uJVZE0l49bwB1nejnPPde5TOQ9LfsyEE2suFnIZ6zkFoZjR5WCgkbYfmEYIaVaXwzrusgu1hZixDvrsZlHlybdk6JrlN92UcxPn5qxS2Ksvxc/9pdSFqcUzZxTjEI0+XKkW4g/atpvtdCo+hwTKz47Rqewx+sxHJ0lpn+oWToDEwJvxyqZwVncQz47KwOBJuyTqys48wO6upSvtBej//m95eDbAKcnsbo6qI3pFR8caTDZPqef0/FetndvJZWMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODXZsSLK0XiwM0GVfBo+54gBJjhT6I2fHOqDXvexy48=;
 b=SNuTePBRQaV7h7fOrn1OktYVRVKOBeHeXmSQxQGw40jH4JT4fkYcRrcoj93WfzzSQZqNih8LZFWINMJQEjBppXrnaGZO4R+PW7c+jDgQU5/7Qi3r7JcRROIpdEsyR5lABl9OAawQ/8vaZJvJzlTtd3qn3WuxgItpPCgx0NrtUb80QmJjNEpCpi8gTBzs1xll8oTHTWaUyY0RQzb3EwPxg9yHH0A9Ns0VIVccZn7f8lD7WlrWLvh1QGh+P/UFrP5RIEkj2fbosJz77qo3oj6J7W3UNv3q9RKpNtfSnICaB4j9oirMFi+OVe/plkCPkBCU8JhDrqZ1YmBjvmmMmI/mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4008.namprd15.prod.outlook.com (2603:10b6:5:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 18:08:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 18:08:14 +0000
From: Song Liu <songliubraving@meta.com>
To: Matt Bobrowski <mattbobrowski@google.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        Liam Wisehart
	<liamwisehart@meta.com>,
        Shankaran Gnanashanmugam <shankaran@meta.com>
Subject: Re: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Thread-Topic: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf.
 xattr name prefix
Thread-Index: AQHbcpDSdFdOhb20hkeR7DZegKEq0rMvJmeAgAB4RoA=
Date: Thu, 30 Jan 2025 18:08:14 +0000
Message-ID: <7F32DAA4-1B0D-4702-AAE3-AA742092F192@fb.com>
References: <20250129205957.2457655-1-song@kernel.org>
 <20250129205957.2457655-2-song@kernel.org> <Z5tbH13qK6rLJVUI@google.com>
In-Reply-To: <Z5tbH13qK6rLJVUI@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.300.87.4.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB4008:EE_
x-ms-office365-filtering-correlation-id: 61a7dd0d-1890-498a-b9ce-08dd415910bc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWFPOFVCVzFnbGhXZUljMXpoaVZRT0RNdVRyNFlESGxIN2xlcmowMU50Z2NY?=
 =?utf-8?B?L0JTdXBRU0s5MHgrMFJ1V1E3Tys1dXBwbTFzek83NCtkdFR5RlluY2dVRDlF?=
 =?utf-8?B?b3pyVG91MThJTDZXUDg5NXpnNDB1REhjb29LWFdsdHNZdzF5a2UxUFZQSE5s?=
 =?utf-8?B?cHV4ZDZaeEhKN2FzNU4xVmJPWk5mN2dqcXo1emswbk41ZWNDa284L2hBdmFr?=
 =?utf-8?B?ekNaK1ZSdko5R0dXSVFMNW5wQ3NLdEZtV2dFRTlVVUZVQk95UGtoSDhyaVVV?=
 =?utf-8?B?Tkw5dC96Znh5SkNHVWdOMTR4YjVjWnpQbFVraFllVm5EVWtPa2NKTmxMY1FJ?=
 =?utf-8?B?M0hSa0lxVlhFUGFJdEhmc2xjQzc4OWJTV2dCZXprUyttcnd4Yi9icDZYalpO?=
 =?utf-8?B?MFR1ZDVWMjdHY0NoVHJ3dXhXR1NyY0VzQldRaWNMR0U5QzNwVVV5KzZPclJD?=
 =?utf-8?B?cmtwRXI0YzVrblpLK05XUGFCSHNTR2hMTWx0R3JIMVFnVHh3UGh4bDJMUTZq?=
 =?utf-8?B?bTA2L2xsblpjdDRIY09zMFhJVlJhUHpFb0xPeFZITjhrc2tnUWxmV3VCS0JJ?=
 =?utf-8?B?WUlHcW1PVFNxL1dwdllGQjJXTnlyd3BFZkp4VEFLTXhTaEpndTlpNGUraUt2?=
 =?utf-8?B?YWRTSFRnMWwra1VidDkvdlZxcGNLL0hTZmZQM0J4aU1oTlU4RWVMZTVtZzc2?=
 =?utf-8?B?aWNtNWVSalVtc2NmQnVxYTBBbDNyQU00TzVuN0tGdDZIdGJBNmxTalhsQnJu?=
 =?utf-8?B?WStJRVkxZURzWS91MVNHOWQ2NlV1bVNwM1k3dDhVZGFnNDNNYnVoK29BUzlE?=
 =?utf-8?B?YlF5SlhNNk8zczhYMzR0L3J5bjB3V2RVWHllQVdUTU1ZUEdSczU3T2NybXZP?=
 =?utf-8?B?T1pUMGp1M2lFOGFTK2YwTExSR1ROVk1DQVdPS0d4UzU4ZzRhVTRUZkZUNSsz?=
 =?utf-8?B?UC9MUGwzR1ZLUWNWVDBVMHhaQm5uTk9GZ2tOYjVVT3ROWUI3VDZLOXUzbFFB?=
 =?utf-8?B?bnVQMWlFWlRHWnluVFBabUlPWnZPM0czU1gyOFBHN0xRNXhoQTNaTms3MTY1?=
 =?utf-8?B?RXcyTmhGMkNhbnExMFdXcmJRSnJZeGxRY04zcEFIS2hYRjBKT0dialJNYytV?=
 =?utf-8?B?N2IzU1Y5QWpKY0FGcERuMnREb05sTk5mcys4dEplVUY1RU01Wk5FWHAzbVBH?=
 =?utf-8?B?OTVPeVRLSFc2cVZ1RVdFVWk3NlJReWo0N0ZtZC90aE9QQlJIRWErTTZNbGJs?=
 =?utf-8?B?MmxKRFRVUlpVcjZvdzRUclNoVmdSamxVUDlmTXdvam5YVDFvVmdOYkVmb21Y?=
 =?utf-8?B?Y2xmWk1DMXNIWk42bHlVL2ZMQ0pkRmM2SUEvVmRqbnZzSjR6Y080NzUyQlk3?=
 =?utf-8?B?akl2NHdWVFBQOHduam5xcHFmTldOeit0M3hTTE02TkRxUmROS0U5aC9GaWZl?=
 =?utf-8?B?T3FrbmVJc25lRU80a2d3cG5OdDAyT3JDOXI2bE1HRld5YlRaWDFub0Q4SGpl?=
 =?utf-8?B?Vlk1TkhISkRDWUpiMWNLYlI2RTlURE4xTUdPUllWZDRGTVI5SS9uLzhJMnRn?=
 =?utf-8?B?NnVjVXVhT3MyMzFjZWN5Q3VJYXduczZBY3QzaDBDUUNkd3VIai9vTXdqa0dk?=
 =?utf-8?B?aFBTY3U0VkVYTHA1S0s2VTZXeVdva2RRSmk3MmdXOERQcmoya3EzMWt5TVRV?=
 =?utf-8?B?Ynh5UU4rQkhqNDZDMTg5Rnk0MkVhcjBENmFONllLUTY5VkRJUWZYQ2Jyak5v?=
 =?utf-8?B?cUErb2RuL2tjOE4rWGNhcVhKcnp1aHB6YTZENkNUbWM1VWNBTXhsUDQ5RnJT?=
 =?utf-8?B?alhiZDBCZWIwY2haWm1waitXRDd3UU9BUUpmQ1JQNlJ2bWFHMTBaMHpWRjN4?=
 =?utf-8?B?blI5a3k0emtsTkU1ejFkKy9LTko2YXAzVnZ3QldqTXgrOThET0s4NG8zOUo0?=
 =?utf-8?Q?qd0IgtFyVeYQT6ZldHE/nO4+i2EeqKyu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkZicWVQUUR2ZXkxR0Z1SmdYMFNJWDJzUS81QTc3Y1RKbVltYzJiQU9wNHMz?=
 =?utf-8?B?U0dFSG91ZE92MWw3Wlgwc2YvRldrQXZFU3FHTXVSM2Q5cytZVWlXN2lXRUQ1?=
 =?utf-8?B?YXVmdWhrdlJRMEo5d2hHYm4ySWV0VXpqeGE0VFJ2UlVOMUhSbFc0TzZheHJs?=
 =?utf-8?B?K21FR0ZOZHgzVnF5Tzg2cmVDL1FldGhJdnRwdjV0OVd1ajN6RUUxY2lHMTFq?=
 =?utf-8?B?eHhvb3FFM1FEdG1maUNpOElOOFE2TEExQ0xnSnBuNDFYMlBKRHRhZEZnTFAz?=
 =?utf-8?B?Y2RkZFRNMGRBSlVCZkg1TnQvT0pOSUhuS0dyNTMySGpzcGs1RkhlcjJlMmdD?=
 =?utf-8?B?ZDRES0FVTFVqbEoyb2ovc21aWEg4Ti9WazBjL08xZ012am5FMitXRThJSll2?=
 =?utf-8?B?NmIwNDM5ellrQ3R6NTk0OU5Oc2tQVStXYnpMTEwrUExKeVQ3MHlMRmVoSUs3?=
 =?utf-8?B?TGlKQTg4RTZ4b05haTNBMnBsYUNOZENxRm9lSlY5TldmSXNMNnRsd3BBbTJB?=
 =?utf-8?B?L0hsSjkyNCtCWHZPZmhTOU5RRTd1QTdEdFhPVmlRSXU1ZUxweGRsOEtRbGEr?=
 =?utf-8?B?UGhzMk04K0ErdWg4VTJoOVlyYmNKSzJtRUZrcGpPcEl3ZzN0VkwyZFkxdHA5?=
 =?utf-8?B?VU5MdnV0N0h5Y1ZjVGRXeldSQk16U1dlSDV0eHVZRFpCRGJMbk9kaGhuZlFE?=
 =?utf-8?B?dk1aaHlDZElmcTFFOTZ2SmJhbzlnMmJxTU5CRStHQWFRdGRvWjVieW5ERUk3?=
 =?utf-8?B?Nys1dU1BZy9YY29rbnBXVjQyRU95T2lhejY2MGltRnpKV09xTlM2UWFMajJP?=
 =?utf-8?B?TXNDSllkdTRwVCtlc3NaSUpuM1gzOGxGYWRvaUxtRVE2enRmblBTem82RzBI?=
 =?utf-8?B?SmJ6b1dHRk9TSHdCU0hpZ0dMWjBINXR4QS9OMTBxQzZQc3RHa294V25vQ0hu?=
 =?utf-8?B?VG9XUGNhM0ZQNUVIREVnWnN1WTJXbnliZk91bHpNVktPZWRrdGVYR0xjY3Zr?=
 =?utf-8?B?SHRoYmZNRTdXWTlUdloxbkhVMHFFU082WEszYnFUS2FRQ294dDl5eXhtT2RV?=
 =?utf-8?B?QUlZZVArTVNnVWhtTHJ3bmtBWGptOFBQSjl3S1J1NWp5cmQxTTJTUG5wcHhu?=
 =?utf-8?B?c2dIRXlMa1JhZ2N6S1ZzK3NrbW5nTjhLakZiSU9DZ3FvcWZWQXZsOFRRcDB0?=
 =?utf-8?B?dEhyUXVKWVdBKzFqck1zV21DaXlFampCNXRvb0NnYnZTSWIxMlFNYkoycHlt?=
 =?utf-8?B?NnU2L1J1bXp1cUdIMnJMVHA3enp2SzYwaFd2U1BWdzJLekM4U25PdUtaN3pv?=
 =?utf-8?B?c0lCN21TWlhPK1BTb3hRVktBZlo1R3NiK3B2ejdNcWJXdmFNNkt4aktMZTdO?=
 =?utf-8?B?cm1sOHhFNWhGVWh1aGR4QWY5cDdLKys4U0hmakVmU1dpSW1HRGgzVi9ubEZk?=
 =?utf-8?B?bUtldDZHM1RIUGxySUZSdjRxdHF3WXg2dC9xQjBYTEluQy9YZEhudmhGTUZZ?=
 =?utf-8?B?emFaQXVFTmRuRWlLZ3N5eUl6WXhqNUhNdFR2NEVIU0JKLzNUbkR4U1U3Njdr?=
 =?utf-8?B?REoyNFZhcWRZOU5LbzdDWktkcjJ6OUY1Wmh5bk9ieFBLYVdkNEphNURsOW9M?=
 =?utf-8?B?N1Y5K0g1a1E1UEhFeTFTc1dLeG1zSkZoKzhGWERMZjZyYkVWNjJmMFhwNTZP?=
 =?utf-8?B?b3BXYWp1N1lyaTVaOXhoS1dCc0ZpbkhBNkdZWEVtY2p5WDEzS1kyMjlvdkNF?=
 =?utf-8?B?QXEwRUVEeE5Uam16MWowTCsyMkdqUVZoMlVHUklPaU1qQjcrbTV1N2ZweG8y?=
 =?utf-8?B?dXJycVhnTk16UUpoT2F3bi80S0I1K2VoT3VoQ0NYbE1hWm1hNXZTaStnYTV0?=
 =?utf-8?B?Mm9kdWZZQ3RWZFY1NWxCZDVxUWx2Z0VDNis4TWxuc0FldmxWS0k2eUIyZU4x?=
 =?utf-8?B?UHpZNW00ZXBLdnpZdyt0V1dVK2FNOFV1Y1J4MXplWkx4aGQ1azc2L1hUK0dI?=
 =?utf-8?B?bGtXeEJBWnRSZXJBaEpPTUtac2IzMmhXUWcrUmUvNXN1aFZhaWo1ZExYUzVa?=
 =?utf-8?B?OTF3RlM4S2IyKzVJN0ZVQlp4b1JQT01WbDdGNDlzbzA2dW1nT2QzS2JYYnNB?=
 =?utf-8?B?aTZJVU5kblZHYWhscEtUZ3YrM2wzU0pBQ3pXTjdNNVorUVRtbmJJS0xNSlBR?=
 =?utf-8?Q?aIdjUZbajckOtxXNTw+7UOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5129AE4B4381B242808CD3F44DD125E4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a7dd0d-1890-498a-b9ce-08dd415910bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 18:08:14.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCVMDFtdxXWlgp27ncSi1kz0Ez6TaxfJScUFwt0BNe7CPNYUt82wleVJzojIn4SZaCTWD8JqwcZa9Kyu9oJK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4008
X-Proofpoint-GUID: Cth7LMe67zO_CM-IRKfEiLMVEr8ULkyk
X-Proofpoint-ORIG-GUID: Cth7LMe67zO_CM-IRKfEiLMVEr8ULkyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01

SGkgTWF0dCwNCg0KPiBPbiBKYW4gMzAsIDIwMjUsIGF0IDI6NTfigK9BTSwgTWF0dCBCb2Jyb3dz
a2kgPG1hdHRib2Jyb3dza2lAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEphbiAy
OSwgMjAyNSBhdCAxMjo1OTo1MVBNIC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4+IEludHJvZHVj
dCBuZXcgeGF0dHIgbmFtZSBwcmVmaXggc2VjdXJpdHkuYnBmLiwgYW5kIGVuYWJsZSByZWFkaW5n
IHRoZXNlDQo+PiB4YXR0cnMgZnJvbSBicGYga2Z1bmNzIGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94
YXR0cigpLg0KPj4gDQo+PiBBcyB3ZSBhcmUgb24gaXQsIGNvcnJlY3QgdGhlIGNvbW1lbnRzIGZv
ciByZXR1cm4gdmFsdWUgb2YNCj4+IGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94YXR0cigpLCBpLmUu
IHJldHVybiBsZW5ndGggdGhlIHhhdHRyIHZhbHVlIG9uDQo+PiBzdWNjZXNzLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IE1hdHQgQm9icm93c2tpIDxtYXR0Ym9icm93c2tpQGdvb2dsZS5jb20+DQoNClRo
YW5rcyBmb3IgdGhlIHJldmlldyENCg0KWy4uLl0NCj4gDQo+PiAtICogUmV0dXJuOiAwIG9uIHN1
Y2Nlc3MsIGEgbmVnYXRpdmUgdmFsdWUgb24gZXJyb3IuDQo+PiArICogUmV0dXJuOiBsZW5ndGgg
b2YgdGhlIHhhdHRyIHZhbHVlIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgdmFsdWUgb24gZXJyb3Iu
DQo+PiAgKi8NCj4+IF9fYnBmX2tmdW5jIGludCBicGZfZ2V0X2RlbnRyeV94YXR0cihzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWVfX3N0ciwNCj4+ICAgICBzdHJ1Y3QgYnBm
X2R5bnB0ciAqdmFsdWVfcCkNCj4+IEBAIC0xMTcsNyArMTIzLDkgQEAgX19icGZfa2Z1bmMgaW50
IGJwZl9nZXRfZGVudHJ5X3hhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY29uc3QgY2hhciAq
bmFtZV9fc3QNCj4+IGlmIChXQVJOX09OKCFpbm9kZSkpDQo+PiByZXR1cm4gLUVJTlZBTDsNCj4+
IA0KPj4gLSBpZiAoc3RybmNtcChuYW1lX19zdHIsIFhBVFRSX1VTRVJfUFJFRklYLCBYQVRUUl9V
U0VSX1BSRUZJWF9MRU4pKQ0KPj4gKyAvKiBBbGxvdyByZWFkaW5nIHhhdHRyIHdpdGggdXNlci4g
YW5kIHNlY3VyaXR5LmJwZi4gcHJlZml4ICovDQo+PiArIGlmIChzdHJuY21wKG5hbWVfX3N0ciwg
WEFUVFJfVVNFUl9QUkVGSVgsIFhBVFRSX1VTRVJfUFJFRklYX0xFTikgJiYNCj4+ICsgICAgIW1h
dGNoX3NlY3VyaXR5X2JwZl9wcmVmaXgobmFtZV9fc3RyKSkNCj4gDQo+IEkgdGhpbmsgaXQgd291
bGQgYmUgY2xlYW5lciB0byBoYXZlIHNpbmdsZSBmdW5jdGlvbg0KPiBpLmUuIGlzX2FsbG93ZWRf
eGF0dHJfcHJlZml4KGNvbnN0IGNoYXIgKm5hbWVfX3N0cikgd2hpY2ggc2ltcGx5DQo+IGNoZWNr
cyBhbGwgdGhlIGFsbG93ZWQgeGF0dHIgcHJlZml4ZXMgdGhhdCBjYW4gYmUgcmVhZCBieSB0aGlz
IEJQRg0KPiBrZnVuYy4NCg0KU3VyZSwgd2UgY2FuIGFkZCBicGZfeGF0dHJfcmVhZF9wZXJtaXNz
aW9uKCkgd2hpY2ggcGFpcnMgd2l0aCANCmJwZl94YXR0cl93cml0ZV9wZXJtaXNzaW9uKCkuIA0K
DQpUaGFua3MsDQpTb25nDQoNCj4gDQo+PiByZXR1cm4gLUVQRVJNOw0KPj4gDQo+PiB2YWx1ZV9s
ZW4gPSBfX2JwZl9keW5wdHJfc2l6ZSh2YWx1ZV9wdHIpOw0KPj4gQEAgLTEzOSw5ICsxNDcsMTAg
QEAgX19icGZfa2Z1bmMgaW50IGJwZl9nZXRfZGVudHJ5X3hhdHRyKHN0cnVjdCBkZW50cnkgKmRl
bnRyeSwgY29uc3QgY2hhciAqbmFtZV9fc3QNCj4+ICAqDQo+PiAgKiBHZXQgeGF0dHIgKm5hbWVf
X3N0ciogb2YgKmZpbGUqIGFuZCBzdG9yZSB0aGUgb3V0cHV0IGluICp2YWx1ZV9wdHIqLg0KPj4g
ICoNCj4+IC0gKiBGb3Igc2VjdXJpdHkgcmVhc29ucywgb25seSAqbmFtZV9fc3RyKiB3aXRoIHBy
ZWZpeCAidXNlci4iIGlzIGFsbG93ZWQuDQo+PiArICogRm9yIHNlY3VyaXR5IHJlYXNvbnMsIG9u
bHkgKm5hbWVfX3N0ciogd2l0aCBwcmVmaXggInVzZXIuIiBvcg0KPiAgICAgICAgICAgICAgICAg
ICAgICBeIHByZWZpeGVzDQo+IA0KPj4gKyAqICJzZWN1cml0eS5icGYuIiBpcyBhbGxvd2VkLg0K
PiAgICAgICAgICAgIF4gYXJlDQo+IA0KPj4gLSAqIFJldHVybjogMCBvbiBzdWNjZXNzLCBhIG5l
Z2F0aXZlIHZhbHVlIG9uIGVycm9yLg0KPj4gKyAqIFJldHVybjogbGVuZ3RoIG9mIHRoZSB4YXR0
ciB2YWx1ZSBvbiBzdWNjZXNzLCBhIG5lZ2F0aXZlIHZhbHVlIG9uIGVycm9yLg0KPj4gICovDQo+
PiBfX2JwZl9rZnVuYyBpbnQgYnBmX2dldF9maWxlX3hhdHRyKHN0cnVjdCBmaWxlICpmaWxlLCBj
b25zdCBjaGFyICpuYW1lX19zdHIsDQo+PiAgIHN0cnVjdCBicGZfZHlucHRyICp2YWx1ZV9wKQ0K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC94YXR0ci5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3hhdHRyLmgNCj4+IGluZGV4IDk4NTRmOWNmZjNjNi4uYzdjODViYjUwNGJhIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3hhdHRyLmgNCj4+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC94YXR0ci5oDQo+PiBAQCAtODMsNiArODMsMTAgQEAgc3RydWN0IHhhdHRyX2Fy
Z3Mgew0KPj4gI2RlZmluZSBYQVRUUl9DQVBTX1NVRkZJWCAiY2FwYWJpbGl0eSINCj4+ICNkZWZp
bmUgWEFUVFJfTkFNRV9DQVBTIFhBVFRSX1NFQ1VSSVRZX1BSRUZJWCBYQVRUUl9DQVBTX1NVRkZJ
WA0KPj4gDQo+PiArI2RlZmluZSBYQVRUUl9CUEZfTFNNX1NVRkZJWCAiYnBmLiINCj4+ICsjZGVm
aW5lIFhBVFRSX05BTUVfQlBGX0xTTSAoWEFUVFJfU0VDVVJJVFlfUFJFRklYIFhBVFRSX0JQRl9M
U01fU1VGRklYKQ0KPj4gKyNkZWZpbmUgWEFUVFJfTkFNRV9CUEZfTFNNX0xFTiAoc2l6ZW9mKFhB
VFRSX05BTUVfQlBGX0xTTSkgLSAxKQ0KPj4gKw0KPj4gI2RlZmluZSBYQVRUUl9QT1NJWF9BQ0xf
QUNDRVNTICAicG9zaXhfYWNsX2FjY2VzcyINCj4+ICNkZWZpbmUgWEFUVFJfTkFNRV9QT1NJWF9B
Q0xfQUNDRVNTIFhBVFRSX1NZU1RFTV9QUkVGSVggWEFUVFJfUE9TSVhfQUNMX0FDQ0VTUw0KPj4g
I2RlZmluZSBYQVRUUl9QT1NJWF9BQ0xfREVGQVVMVCAgInBvc2l4X2FjbF9kZWZhdWx0Ig0KPj4g
LS0gDQo+PiAyLjQzLjUNCj4+IA0KDQo=

