Return-Path: <linux-fsdevel+bounces-49985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87906AC6DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40F54E3AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93828D85A;
	Wed, 28 May 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQSXnRU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6328C033;
	Wed, 28 May 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449028; cv=fail; b=reQVmlWJuH7c0UCABJyi/m9A8Ay3+0Y/R3ni4poTy3oKkN3Qq5Ch36BWriJ8641IroS/SBY9MtWSXImi+Lg/FMeQvkZgU4k1buCTk3M6BIX+xiW5rb0aIVpB9geHJjV+mGvOB6YUq1VVYjhul6ltdahadF3ig1mtDIwavRqxKTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449028; c=relaxed/simple;
	bh=hSdqENLWtwfHQ9SYFl3JuKMY7/9z36GkkfpTJNNUwJo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cloZU+eOCHiJx78vrvh4T37LerR5xnhp+EybYaE/xoD+Eso6BtDiKsNxlTDPXxK52GouVm1PLjU9+3m4CSRFrtpGQL4cIZ03Zl+AkcFZiNBvxo4DyobcasDXha9JSei6lQ6a1ZjI0tzW8oePX0kxmtqpcXC6Nn60c/aK7cUaI9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQSXnRU2; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9ZDX017827;
	Wed, 28 May 2025 16:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hSdqENLWtwfHQ9SYFl3JuKMY7/9z36GkkfpTJNNUwJo=; b=rQSXnRU2
	eJWemkHtZHEP1TTjP9xsP/ftcBB7EnI2/7JApOsE/7176KWu51Tml5K2uOdfY20s
	FOWWGUOx1QA+CA+oIz6u8wCy/88+ftOtgZOqqC1jWWwGuD8OzjoDLqVQgNw+JbkD
	NjYUnCTU4KPvK4V+mOAWPP2k5jn5wrEpGZKJ8VYyJSieHEaY7OK1ZzZkYCXo5xPC
	YBVvobeG1jDkQNuqsUgoSJl9Ea5zQ87Tx/n2HCH1EUZP1sZY+EfgUKNLGAgFaqjH
	Dc0lmTTKrpTmLuDJ+wwLShjzdGLXkbNm0iN23hY96dnZLQzvmHkR7iuVyvN/2/UV
	tmTGorx3tK4D3A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40hgq0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 16:17:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB22E4z6jbdX0VQvQPEo2d/Pbi/84KmwmO3r8DoxsQxvhchwi/B+o34gIE2q38k3HdtCpyy/opJ1vR0aJRiCHlF2QFG+5fysHk75EweOmwLAAAo4Onjs/+BnCIfOOhutxv2aap21P1hRC8fUVyFOMYn1KNEy5YYkogENUXBH17b/2HHK5jxPxc+8TJUgt5Vb52MIUmyYJZYQrAozSST7LgA4oC6v0OYU+VIx6fwBYcVYxe0N8RxYj9eODfLu3vGG1zGbsHxdIutkV6xGL90cz0NF8lKOt702mByBvC6DVawGL+6Du0EtQerIg+7J9NQvrtt8/Fdv5SrburLrT+Xi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSdqENLWtwfHQ9SYFl3JuKMY7/9z36GkkfpTJNNUwJo=;
 b=y3y6WrYQj87Klj+mY8LXYK9PPq1iPAJGarYR4ds0amPjthWaCnyPpePaCNvhqhJoqqKRyEC62YOAB0vki8wZcCWIGX75Kn+zjINe0Sxzeah0mWYzWhWDSq3y2WSkjuk96g4FNGjsuUaCRP4sDEhikYRxy1eKSlj39dbjZjeuE8j6SD9adfV1exuVmIrgTjbQqFWNAivaGhe46dgg1oq5R1TcerrNtc5wf6DcFf/xWGduGYnEOkblrkNP5rBaLBsGElykqfwTKfgysRG5oNqQeVCu2tNvaszh9lPWZXoAsp0nb1FM4W6YmZcq44h9NExvjsVlN0+UjTuH0GyZEqKHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB6420.namprd15.prod.outlook.com (2603:10b6:806:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 16:16:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:16:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index: AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoA=
Date: Wed, 28 May 2025 16:16:58 +0000
Message-ID: <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
In-Reply-To: <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB6420:EE_
x-ms-office365-filtering-correlation-id: 3a0ffb08-c03b-4aae-7bb3-08dd9e031238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTVUOHI0bHN6VXcvTmNmaS9JL1BUUDhYU2FLQkFmcytwaDFxWFJPZWUyNWwx?=
 =?utf-8?B?bDhKK29OcWc4RGtnT3ZhMXNCdEp3K2s0TGZTRnBiWWV5c0drZEc3eGNadCtB?=
 =?utf-8?B?K1pjb1lNejZXWDJmdHlnTEltbWJoUUVVaHJaVWptZ0NzSldrVHVzandraWV6?=
 =?utf-8?B?QjZUY1MvYjF3STh5RjhGZWhmdHFNWW5Fb2s5VXhhR1VDQ25HLys1eXNEaW00?=
 =?utf-8?B?a2czcEJkTzNJZ1FtTHk5eStBWURiM1Q4SkJsSHJmVUJIdmpDcXpFL3lsS3Jy?=
 =?utf-8?B?L0pqRWtJQllMSyszRUg4MWFua0VhUXZRdXZOSk5iSGIrekRlMHdmYldjNHl5?=
 =?utf-8?B?VmdFUkllSEgvcnpFeXpKOWp3aFUzUDFYSU04clpBaDdWdVZ1REY5QTRMYWRh?=
 =?utf-8?B?VEZPQmRCRy9PME02TEhWTFFDZzVtbnRIRGh4dUtadXlldzV1YkdodEkxdWFC?=
 =?utf-8?B?QWptYzMxMHZWWjIzYmUrVXFVaUJ2M2FyeVJPcUIraUYzS2p6V3c1bEZuT2k2?=
 =?utf-8?B?MDZHNWZ3ZjNsSEFWV2d6cm1Pa1A5aEhab0NjcXNFTmYwUFRrc1cxRGREcTk1?=
 =?utf-8?B?djNZU3JvNDRTVHlIQUhodTByb3p2b3lheXd2VTByNXdJbElHMURybGRMekRX?=
 =?utf-8?B?MS9JRmRObUU4cDhNSGpzcGFReUVkeE5jVXdnOFYyVWh1Vk4rNHJIaENIT2ZQ?=
 =?utf-8?B?Wm1yU3pNbE9UUzJ6SERMUEtiOTEvVFZVTTZpSGxJa3BaNTlWUGxtN04zSVFs?=
 =?utf-8?B?QzRONjBJSi9Vd0tBVmgzdmpSbjhSMDZDNmM0em5YUmpJZFNoK1l3aFdOK1gx?=
 =?utf-8?B?UFNHMkpzZ0JxUjZONlRTSHVtR0N0dlJyQk1yMjFiaG1GSjFpVnBaY0l0RTZC?=
 =?utf-8?B?aUlEaDd3b1ZjWmJhMkMxWmlpbS9LYWJkMmU4WWdjdXlrc1BjZGNWVWJJVTl5?=
 =?utf-8?B?dnJmU3NDdi9xNFowVUNzc05lKzJxWjQwTEtFTUNQMFBqU2R1VWhleWpZaGtE?=
 =?utf-8?B?WSs2eTlSbXlGS3NSUjNsZ1VHWVZ3QjluTCtmclluWHVYakxJM05heHpORklZ?=
 =?utf-8?B?dUM1V0tkNWY1SlAvLytDbDBZcGdFN0IwN3FxUGxzeVpmRHJWS1ZuL3ZOdXc2?=
 =?utf-8?B?T0NnTXFEU0pHMitrdDg3MWlSK0lSM1JjZzRFdml6WUR6c1plZ2FZaFViZnJJ?=
 =?utf-8?B?ZTNYS3RSMDFwOUs1S1lvc1V2NUJwWjJQbWFLK0J0dkJ3OHJmL1M0T0Q5Z3BK?=
 =?utf-8?B?RFdRSTJydGF5UElqMTRabUVnckhwaWltS01HcHNyQkdSTllEVi9pY25GWkw2?=
 =?utf-8?B?aTJFUEVWaXlSS2xFeU45UUhiNzl0WkdOc1g1b2FtNys1dmw2bXcxRXhoMU9Z?=
 =?utf-8?B?WlZGUWh1RlYyLzhyeGxvbEhjcnpQSWdRcnNIN2JXQ21pZVlKUVFqRXJTcTNr?=
 =?utf-8?B?S0N5LzM0NFVqMnVhMnlBZThwMExXYjdtVkNpQUM5UjZnS2FrR0lCTHZvK2wy?=
 =?utf-8?B?MVgyTngzMDFFSWlyMHEyWi9sN24wVDNoZDVFbTB2NHlWNFQrdTBjYUJaaEw4?=
 =?utf-8?B?TTV4Ti8yOWdaWDBJT3FLTUdkU3lhZGtaYjErY3F1SWgza2hHcWwxejNhZWJa?=
 =?utf-8?B?cmpWZWZmWlBqSjJFZFpjRnVsSjRRVXVJSC9ZOHVaQVN4bjExL1Exb0F0ZDg0?=
 =?utf-8?B?K2VmWWVjT2YwcjFCY1prOFVJWGtJTWNTWnFIS2xyeFlDSHJPMHNFTG80ZHQr?=
 =?utf-8?B?Rjlad2MvN0NMV2lOM2Y3bUtYbFhPYkorZHEzcE53SUkzWXlTOC9jUy93T1JW?=
 =?utf-8?B?Z25OdEhVdTJsb3NSWWZ2eG1YcVYrWkVndHV0dnhFZk1WZ1BZQ0pmalI2eTUx?=
 =?utf-8?B?N2pJUEVSaGFzRm9lSjZlaE45TUdqcXoxbm5qWGJPR2FBa2tzRHdYMk9sTUhk?=
 =?utf-8?B?UUVKSGJDaFMyRG1wZVdVZXNsRHcxOWZKcE1oV0tmOUlMS1hmS2RtZHBVOFI3?=
 =?utf-8?Q?h3WZtYwwKBkwD+oUHg/9oTJ7D7H038=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVFSY0gyckN6SlJHUlRlakUrdmxPUHlOOVd6Y3Y5MVEzMzU0eFo2azJxaTRz?=
 =?utf-8?B?OXFYdzlvYTRUQmVCb21wMXphSGtWaE8wNmlLMEsvTGU1QXF5WGgvSU5iTS9R?=
 =?utf-8?B?YzNvbnJFcEJQamswUG5oZlJoRndZb3FJaDk5bjluS1JYKzluVXpiUVY2TW15?=
 =?utf-8?B?Z3BXWDN4d2dWRnRaaG16WlovZnZmd0RTYWVXakZTU3c5M1BTalhFWVNxUTU0?=
 =?utf-8?B?VndPb2xwTkQrdnBYei95b1hwUEg0WEErMmFBVE1FYyt5ckI0K1pMMVMyUk1J?=
 =?utf-8?B?NEh2VytBclNyayt1cDZORHJRd2pqMmV6M2p2OEJiYzNkWVBOb1V5ZWQyditH?=
 =?utf-8?B?NmJrdHJzVzZwK2UwcTJyLy9FZmpRb3p3ZUhVaTNTUHhqQk1Yam92NkhDK3Rx?=
 =?utf-8?B?cTRGVHlNc3NhdjJXVlJJSXcrdW9kZExMWEV2MXkwOVN2Mkxic2x4ZHJpWjVC?=
 =?utf-8?B?R1ZHQThGZll0SUh6ZjlCNDhZc2FBeEtva0kvV0x0UC9ZSVBNWEJqaUJPaklH?=
 =?utf-8?B?V2hTWVRWemRKV2xJS0J2QVlWZ0NvRDRzNmJETTMwbWpYMnZ1c2ZZYTdzUStX?=
 =?utf-8?B?b3dqbzV2UjFaMkhDelhFZDVQZGpLeUdjTk5oTmFIQ0NuTGxRUW5jb05vN3k1?=
 =?utf-8?B?TW9mV2xpWjdjdDFuTVU3N3pEM0t4SS9TanVnRTdmakhyRmlmQ28vbDFKK2FX?=
 =?utf-8?B?bVRwWjViN1Fqak9xaEZJK0dDZVZlRUwzV2VBNE5SNG1vQkFXcU5iQ1FrdzFU?=
 =?utf-8?B?MEhMb2dkZ3NIUmNjQTBHQ2JIVVA5Znh1dlFkWnIwendES01hNzdTaW9sclRP?=
 =?utf-8?B?VmkvZ2FlMmV6NmRUeWhZb3ZZc1ZSL3RwWmxkbFg0bGttNmRnZ3lxblY1R2JW?=
 =?utf-8?B?dXRBVENGMDh4bXJxNS9NOVNNcjcxcEdTK00zNHhoMVJseDA5ODFNUVczMElX?=
 =?utf-8?B?a21vRERqaTdFRVZ6M054MTdxcGxwOThNcjhKM0NUcDh5ZWF1NEdkdTdrNzNZ?=
 =?utf-8?B?dEpFM2JTM0FCNWM2bzJsZHJ4dUZXQ2phMnZzTm9YZkF5a0lwNXZQV3hUZ040?=
 =?utf-8?B?cHc1TGw3bHEzREVKZm5aU1hTdTlrU3VpQXlKNVJuZmx6UGJCUmw3N2UvbU1S?=
 =?utf-8?B?YTA3QVp0RzFlUVFHUVRIMlNVSkFYMW81UmtxNGFHSU94Mmo3WkV2aHlWck5m?=
 =?utf-8?B?LzZYUXgwaGF6dVV0UDZOS2JlVnpUc3lhU1VVdWoxK3IvejZaQkMxM2EvZzRD?=
 =?utf-8?B?OXlnQ1pFNC9Fd2tOWDhVOHNNV2xCejRQTXFzNVkzR0ZRaXhwNHN2QTJHSHRz?=
 =?utf-8?B?V3paMU5pYk1UaVgwclNRUkljdXhCaEpaYnR0MlBoQzVjVEVRVXY3dng2aUY4?=
 =?utf-8?B?Mk9ZRDhhYUR4aHQvUEwvL0Z6dzBJb0YrTmxWNitFM3B3c1lCNEFWNXYwaWsy?=
 =?utf-8?B?VTJZb3NCOEc4RGozeHJXQTF3dzFzS05jeVdrRHFzd0szNGM2dEYzS0lWT0tH?=
 =?utf-8?B?OUx5VlMyeTZRQWg5OW5DU3dVNjdvcFlpWmRHVnU2UVpHejNzY0RvK21BcWxi?=
 =?utf-8?B?UWFwRzcxdFN3d0haUW4wRTlrY1VCaUd2TnI5cjJVNWhBcmZHSHRSemJ3K05O?=
 =?utf-8?B?elQya2dqaDlaSXZ0Y1ROT3NwRXdPQ1U5QXo0WTZFTGpCK3dHUEcyUjQ2YXhn?=
 =?utf-8?B?SDhPdExWa0lLaXFLQkxUUXBFazZvTy9BQlliN3FnSVFWNndFYnh5UUx2VkRv?=
 =?utf-8?B?L2NkVmNnQUoyNjZlSWNBQllsVm9KQWU1UlIwNlRpRVBXbERwMFRLYXQzaWRX?=
 =?utf-8?B?c0VHR2s2VlBPVGhuTUkxVldDNDUyN3E2VktsRjU0R1dkSDltL0IrMXc3OXJu?=
 =?utf-8?B?VXlIS0k2RENCVFRmSEkwYlJ5MHFLQWMzTEJXNkRHak5acTlyZ2pmQnZSa3M2?=
 =?utf-8?B?bWpuUkwxc1hhMEQyTzZjYUhvd3FiMHVKNnJjczRLL29FT1YxZlExd3RlNk1H?=
 =?utf-8?B?UnFZZW8zaDJUK21RU0NMMHVvcjMvdjdHK1BuM2ZVQVJKdXpxRnRUcUplY1V2?=
 =?utf-8?B?a2FXcXBHa1dhek4rYVB3WStSVkNJb0hUbzYzckduRXVsRDYzVGI5a2p4dHU0?=
 =?utf-8?B?cU5xekJxVjJpT1AwS0dCeTVhNXk1SVVJVzdQNDBEdSsvMHpCY3htNUFqeVky?=
 =?utf-8?Q?LHwFJRSXPBwY0ndLrYK23tU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCFB263D79AAA458A66130BA91D2F93@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ffb08-c03b-4aae-7bb3-08dd9e031238
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:16:58.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxiiqc7A1KN8Di7M+Y3On+acUCqT0E8TXIhT4XS9CRHr7dSAO73fJjTunc2Yyza+RD611beIvzahuynhO4hVeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6420
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzNCBTYWx0ZWRfXyJo3WI9LQyTJ 3ITZUwaIPqMu1VAt1/8ebLtZdBAecht+T//o0fun8IfFu9v/d0oj2doyz8vDU/cD1Vm4CedqXi1 owXIti0ZNIJFqx/PPqmbvHeV/TtZoEfGL7MovWkCl8Lb8xztIZKPUpVYr1GwoM8LI7+XBq5Q8iE
 zpXX2M2GMZW6Eiohty2nFfehtrY5nKe73LwrwQhMHhB61GkGX9o2D/cqFUI31bLczHy0S3sEPzl i8fNXunolMKg+FDhTJm9YCYE/Vpsx/T06y9Wk6ap2IqnQBawFCxpPSasl+5YltB+NFshrwfpzU8 KvCVGPXIJKm0l0OxskTtr2NpYuBr/G4ma/i2qvI1pOKtgvTFsuDkF/9GR/NzBZHgmgomXHvPpea
 yUxq/glryXFji5fh+7AviZ/DG700YCVFwNx8VodTg//BdBJCTHhRh1G0Ydpt3PRLlpL2n/nH
X-Proofpoint-GUID: LVvRfopoq8ARDiBciq7b2DByghcfURoI
X-Authority-Analysis: v=2.4 cv=WOd/XmsR c=1 sm=1 tr=0 ts=683736fd cx=c_pps a=vC/6UP5iuPPS++qy353ujQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=skRRHGpWbuctFKM3xeYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LVvRfopoq8ARDiBciq7b2DByghcfURoI
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=726
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280134

T24gV2VkLCAyMDI1LTA1LTI4IGF0IDIwOjQwICswODAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiAr
Y2MgcnVzdC1mb3ItbGludXgNCj4gDQo+IOWcqCAyMDI1LzUvMjggMDc6MzksIFZpYWNoZXNsYXYg
RHViZXlrbyDlhpnpgZM6DQo+ID4gSGkgQWRyaWFuLCBZYW5ndGFvLA0KPiA+IA0KPiA+IE9uZSBp
ZGVhIGNyb3NzZWQgbXkgbWluZCByZWNlbnRseS4gQW5kIHRoaXMgaXMgYWJvdXQgcmUtd3JpdGlu
ZyBIRlMvSEZTKyBpbg0KPiA+IFJ1c3QuIEl0IGNvdWxkIGJlIGludGVyZXN0aW5nIGRpcmVjdGlv
biBidXQgSSBhbSBub3Qgc3VyZSBob3cgcmVhc29uYWJsZSBpdA0KPiA+IGNvdWxkIGJlLiBGcm9t
IG9uZSBwb2ludCBvZiB2aWV3LCBIRlMvSEZTKyBhcmUgbm90IGNyaXRpY2FsIHN1YnN5c3RlbXMg
YW5kIHdlDQo+ID4gY2FuIGFmZm9yZCBzb21lIGV4cGVyaW1lbnRzLiBGcm9tIGFub3RoZXIgcG9p
bnQgb2Ygdmlldywgd2UgaGF2ZSBlbm91Z2ggaXNzdWVzDQo+ID4gaW4gdGhlIEhGUy9IRlMrIGNv
ZGUgYW5kLCBtYXliZSwgcmUtd29ya2luZyBIRlMvSEZTKyBjYW4gbWFrZSB0aGUgY29kZSBtb3Jl
DQo+ID4gc3RhYmxlLg0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhhdCBpdCdzIGEgZ29vZCBp
ZGVhIHRvIGltcGxlbWVudCB0aGUgY29tcGxldGUgcmUtd3JpdGluZyBvZiB0aGUNCj4gPiB3aG9s
ZSBkcml2ZXIgYXQgb25jZS4gSG93ZXZlciwgd2UgbmVlZCBhIHNvbWUgdW5pZmljYXRpb24gYW5k
IGdlbmVyYWxpemF0aW9uIG9mDQo+ID4gSEZTL0hGUysgY29kZSBwYXR0ZXJucyBpbiB0aGUgZm9y
bSBvZiByZS11c2FibGUgY29kZSBieSBib3RoIGRyaXZlcnMuIFRoaXMgcmUtDQo+ID4gdXNhYmxl
IGNvZGUgY2FuIGJlIHJlcHJlc2VudGVkIGFzIGJ5IEMgY29kZSBhcyBieSBSdXN0IGNvZGUuIEFu
ZCB3ZSBjYW4NCj4gPiBpbnRyb2R1Y2UgdGhpcyBnZW5lcmFsaXplZCBjb2RlIGluIHRoZSBmb3Jt
IG9mIEMgYW5kIFJ1c3QgYXQgdGhlIHNhbWUgdGltZS4gU28sDQo+ID4gd2UgY2FuIHJlLXdyaXRl
IEhGUy9IRlMrIGNvZGUgZ3JhZHVhbGx5IHN0ZXAgYnkgc3RlcC4gTXkgcG9pbnQgaGVyZSB0aGF0
IHdlDQo+ID4gY291bGQgaGF2ZSBDIGNvZGUgYW5kIFJ1c3QgY29kZSBmb3IgZ2VuZXJhbGl6ZWQg
ZnVuY3Rpb25hbGl0eSBvZiBIRlMvSEZTKyBhbmQNCj4gPiBLY29uZmlnIHdvdWxkIGRlZmluZSB3
aGljaCBjb2RlIHdpbGwgYmUgY29tcGlsZWQgYW5kIHVzZWQsIGZpbmFsbHkuDQo+ID4gDQo+ID4g
SG93IGRvIHlvdSBmZWVsIGFib3V0IHRoaXM/IEFuZCBjYW4gd2UgYWZmb3JkIHN1Y2ggaW1wbGVt
ZW50YXRpb24gZWZmb3J0cz8NCj4gDQo+IEl0IG11c3QgYmUgYSBjcmF6eSBpZGVhISBIb25lc3Rs
eSwgSSdtIGEgZmFuIG9mIG5ldyB0aGluZ3MuDQo+IElmIHRoZXJlIGlzIGEgY2xlYXIgcGF0aCwg
SSBkb24ndCBtaW5kIG1vdmluZyBpbiB0aGF0IGRpcmVjdGlvbi4NCj4gDQoNCldoeSBkb24ndCB0
cnkgZXZlbiBzb21lIGNyYXp5IHdheS4gOikNCg0KPiBJdCBzZWVtcyB0aGF0IGRvd25zdHJlYW0g
YWxyZWFkeSBoYXMgcnVzdCBpbXBsZW1lbnRhdGlvbnMgb2YgcHV6emxlIGFuZCANCj4gZXh0MiBm
aWxlIHN5c3RlbXMuIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZXJlIGlzIGN1cnJlbnRs
eSBhIGxhY2sgDQo+IG9mIHN1cHBvcnQgZm9yIHZmcyBhbmQgdmFyaW91cyBpbmZyYXN0cnVjdHVy
ZS4NCj4gDQoNClllcywgUnVzdCBpbXBsZW1lbnRhdGlvbiBpbiBrZXJuZWwgaXMgc2xpZ2h0bHkg
Y29tcGxpY2F0ZWQgdG9waWMuIEFuZCBJIGRvbid0DQpzdWdnZXN0IHRvIGltcGxlbWVudCB0aGUg
d2hvbGUgSEZTL0hGUysgZHJpdmVyIGF0IG9uY2UuIE15IGlkZWEgaXMgdG8gc3RhcnQgZnJvbQ0K
aW50cm9kdWN0aW9uIG9mIHNtYWxsIFJ1c3QgbW9kdWxlIHRoYXQgY2FuIGltcGxlbWVudCBzb21l
IHN1YnNldCBvZiBIRlMvSEZTKw0KZnVuY3Rpb25hbGl0eSB0aGF0IGNhbiBiZSBjYWxsZWQgYnkg
QyBjb2RlLiBJdCBjb3VsZCBsb29rIGxpa2UgYSBsaWJyYXJ5IHRoYXQNCkhGUy9IRlMrIGRyaXZl
cnMgY2FuIHJlLXVzZS4gQW5kIHdlIGNhbiBoYXZlIEMgYW5kIFJ1c3QgImxpYnJhcnkiIGFuZCBw
ZW9wbGUgY2FuDQpzZWxlY3Qgd2hhdCB0aGV5IHdvdWxkIGxpa2UgdG8gY29tcGlsZSAoQyBvciBS
dXN0IGltcGxlbWVudGF0aW9uKS4NCg0KPiBJJ20gbm90IGFuIGV4cGVydCBvbiBSdXN0LCBzbyBp
dCB3b3VsZCBiZSBncmVhdCBpZiBzb21lIFJ1c3QgcGVvcGxlIA0KPiBjb3VsZCBzaGFyZSB0aGVp
ciBvcGluaW9ucy4NCj4gDQo+IA0KDQpJIGhvcGUgdGhhdCBSdXN0IHBlb3BsZSB3b3VsZCBsaWtl
IHRoZSBpZGVhLiA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg==

