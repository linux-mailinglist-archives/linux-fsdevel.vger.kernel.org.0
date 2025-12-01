Return-Path: <linux-fsdevel+bounces-70370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F737C98F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B813A45A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2CF248F6A;
	Mon,  1 Dec 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VIoTs+Pl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE51F5851;
	Mon,  1 Dec 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619486; cv=fail; b=XXNQm6elOe/d5KXb4dExNk4Vg/kGXMlhDYEzYFZARA6DL4L4h2P9JizUQKMVjOkJ5dIUsaraQsN92EUJzsibH9soCqjtNs7DbX8UxCfbdxC8rrC0Gm9BvaN8cOGImINp/ddVlT4HhYgglsnfDzjtvt7W+9MCGpXm2JudbdM2hdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619486; c=relaxed/simple;
	bh=sXjcUTubwAmvSjBfKL6SkoqEycelAZ7jk88zF/JxsbI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=i4IVyCXLYLoVF5sfgndnS8Gkrh346dQ7xiYfVc9TZV/haoG97zbra6XaCRGC5YRaQSVQVBTaC8T10a9hQQvP/5tStODaAvjHIBxY0Z/ztWFaw/z/cMuR9xI5MaSWZTex4JIJDNTND/xw5sEBSJEyjBPdFDZFmwyrQPjqrBnvFuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VIoTs+Pl; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1IK1PS018923;
	Mon, 1 Dec 2025 20:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sXjcUTubwAmvSjBfKL6SkoqEycelAZ7jk88zF/JxsbI=; b=VIoTs+Pl
	uJgJyayCI/fHewpJY8HreJ+f6cjVzK53MTd8HCY1UFofvT5cNUkpOj1tI1VHaUzY
	pw3oH8uFr+siC2z/Kx691uFzEVFmRyM99qedoscyGJIrehbzFMdreYRWfg+5UIi6
	ulPeJuqfz//+djgQa4L6/CnrMSzJ6nWyRqorISbsEDYzk/L4+jwHIjuluKgEfr9E
	ZPdMzxlCwMygSGdIIgYLPoV70QG+d0Idi3lFJWOEfhb1b4kinIgc7WjbjVUjicSF
	sDWqEVIRD6uudbGPnFlzAJ6WIDZtmYc1MKy2xhmUa7sazdA6dfBNLopCbSAy22cF
	xZet8Aoq8I606g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9h7xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:04:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1JwGZ8002910;
	Mon, 1 Dec 2025 20:04:37 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9h7xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 20:04:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj9JKzwSTyL5PgWQc6w7UEzx2GNtGeagzT9ThU1gIDkP8IN7GQq1WXZq6qqXjPC2ngrBIUzTc8pMsayHu8eGhntNv/xMrcqG6JxTQvDcEmWESvhqA1hoW3gTCionXUeqrmWmfvrzNMFKrR78lGP6hB4RcI5B1CS0r4/Twy9SLBKDj3KXIWgZwYFZARJAwTffejSh263VvC3qk+fDn0BK0qlWiiwMUX/invECQYVHCEJIepNvqOS/1V0XWrXLsMT5R3nYo5VVZi5pIFcx3MRjR84ddB1MY+lZz45x5AJFeeZHZL3OPU7mO53c4StIAABVO64Y21UxMa8b22+jPFkI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXjcUTubwAmvSjBfKL6SkoqEycelAZ7jk88zF/JxsbI=;
 b=yKyNDYJkQpetmrEwmq6Gn+uJM3ADXG8Hu17HZjBElqbwZFuj9MEejNvzjFzOPK/hIQVQCq9eD0zuzsRDN0TQB8H9AoGOPep+Ctp7MKFR7aErvzI4wg8TnhKRWV9TaFPFOi7ZeCKWu2DO9XLXcH79rTdJgqfK4b/14LU3JfZ4of4cUfbsE/jwhkVlyipquSJbX+ltpVu5t/9DCXyzQcHK1rfFbRVHvwrGeO7kMWIq09v1l1V8v4D8acpqn47BFkEgLpJalQo2MJKnKNUy7+2vtYZLPtNxwzLHce6KlTtCYMMeTh6VuG+vya4wRa4Zd6Prks3U1UUBc9Ye50UN+26Xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5650.namprd15.prod.outlook.com (2603:10b6:8:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:04:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:04:31 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Gregory
 Farnum <gfarnum@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix kernel crash in ceph_open()
Thread-Index:
 AQHcWaV/RIaAnir5XkifXtXvNFHQibT6mqKAgAADQICAAAQCAIAA/JgAgABjqoCABjjgAIAAH60AgAPSMYCABxs4AA==
Date: Mon, 1 Dec 2025 20:04:31 +0000
Message-ID: <6b405f0ea9e8cb38238d98f57eba9047ffb069c7.camel@ibm.com>
References: <20251119193745.595930-2-slava@dubeyko.com>
	 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
	 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com>
	 <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
	 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
	 <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
	 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
	 <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
	 <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com>
	 <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
In-Reply-To:
 <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5650:EE_
x-ms-office365-filtering-correlation-id: c89c2f28-c2a9-48ee-acfd-08de3114d76d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2FielE0ZHFyUWY4YkdCVzB3ckRibjJXYTNCaUQ5RDRETENJVnlUY1Vha0V1?=
 =?utf-8?B?dFR0UzBySW00Y0RhdmJOVXI2MTRnK1IzS3YwV1F3Tkd1SkVYNWZudnRSclNm?=
 =?utf-8?B?ZWxrUmNYbTNYTENGV25rVmNFUGNrbHdRTnd1TGtpVTRPMkRTVFdZNHZRdURp?=
 =?utf-8?B?VGpOWEZZYytVMVpkdVdCUGVMUUNSUHFtaUhYRWdDZ2ZrejVJQ1NzTTl6UDdS?=
 =?utf-8?B?Uk1jZjVSMHdRYU5nbVdVWVNFN0dVZ2lKMTZmaVc1eFJJYUNQVHZLeENwdHR4?=
 =?utf-8?B?VHRuZFRjeHpOQ2Y4OEdjNDJIYzR2bG1oS25vcG5OcWRrWXpNVzZTOTU3em80?=
 =?utf-8?B?N25FV3c4TDVSRTJMNTJpQTVQUWtlUCsxMnd0R1haL1owVmd4bXU2bW9RaVlF?=
 =?utf-8?B?SXRMOVVqRXJkaWlLQy9ld1ZDK0h6V05MWGo5akhaa0wzTUZNTkU5QzY4UGdP?=
 =?utf-8?B?M1lVWmNaaU00dkJqYVBGUWRTK3NYUEgyNVBxSFhFUFF4clRQVmVuV0pkUWtU?=
 =?utf-8?B?YXZkaUc4cHFmMytRNnluWGcya0RIbzZkbFZ1ai9VU3JUY3FUL0pKTXRWTTNI?=
 =?utf-8?B?REhoUUVxMjBjdWE3Z1NhZmM2di9DazZGVCsxY3pNcmpET3Q3VEFLR3h1c0pE?=
 =?utf-8?B?bkVMcjRTMVYrQnk3bDA2Y1ZzT2xPcStNNWlOTG9hSXhLZTNIa0JXQ0E5Qlg2?=
 =?utf-8?B?U3YzMkJrdWd2Sk90Z3ZBUFFabi9HaXJQUjJXelZybS9NM3RMQ053bXhnL0ZN?=
 =?utf-8?B?Sno3endyS05wTHFYU1huVlgwaWVkS2Nad3VkOE9xUnl5S2FxUUhIRjRLVzhq?=
 =?utf-8?B?YTlWK0dwRGtKbmdLWjViSUZLZTZVVUFkeTkvdUJsazI1M3loanlUeU1BVEEz?=
 =?utf-8?B?eW8ranViOHFjczBzTmFObCtkckNuL3pYZWQzYXA2ejAxTjlGM2NSUzQvSHlu?=
 =?utf-8?B?R3FjaFdlTWQxUnNQejhmdEczdG1JL0VpTTM1WTVDTTNVYzkrTDR6RCtPaDNY?=
 =?utf-8?B?aDRGWThEN2VFRTBmNk9Mb1BIR0duemlGS0hHWXh6RmRHSUdIdHZ4YTlocU56?=
 =?utf-8?B?Nm04TDk4Mnp1SmhYVTgwMElrMlBmcFVkMlMyeEl2UUFxWDVJYWVSSWhaQTVF?=
 =?utf-8?B?VWRWM3NtWDVFU1lxMGxJWHc2L0NoL0VucFN2emVXTmxUNUVkMlFxSVpTb1Rt?=
 =?utf-8?B?RHNxYVppejlmRWVhOGN0T3c2Z3ZlUmsrZ1kyN25tRlpHZWgrNXdFVVB5N3Vs?=
 =?utf-8?B?bzBzeEZGdzVoMkMycXFlSWxQWCtDQ0RkVndVTTZ0YkJkZXhDdW5IRXA2Vi9V?=
 =?utf-8?B?dVBPbGZoZCtoS0xMcGptQUlnaVpqNks3WVJxNXBRYjNOSmxuYngvRjh4UE1y?=
 =?utf-8?B?enZQSXZiRGthRXlheVEvUE1OeXhESmV6OWk4TnVYVDFiMENBSU5DcWVVd05T?=
 =?utf-8?B?NkQ0d1F5ZENoeDNzMDJCOXpjOE9oWVpnc1Rsemtwbjh4OTJGVjk3MmpyNWg3?=
 =?utf-8?B?THJBOFFUaEtUOWdERlk5UnVhdExSVnd6WmtuVTI4VmpMQlR2TGMxY3NITDQr?=
 =?utf-8?B?eEw5V1dldkhnNWJ6RVFnbUY3aDMvVFQrUE9jNzByUVFZZm50OXBjMjFEOGxL?=
 =?utf-8?B?TmRJaCt0Vng0VjI3RVF2SVVnbWFneTBuMGdlRmhaNHNrRGVBaUlkUEJZT1Ja?=
 =?utf-8?B?R004eVZXN2FEQUhSSHJuUnhJZUFYNW1jMi8vYm1uMHBGTXZiU0VhckxhWG4w?=
 =?utf-8?B?c3RSNDBPc2lQanVGdUk5c3orR3B6eW9ZSmtpYVJPREdPQXQ3cUVMSnlwT2pV?=
 =?utf-8?B?WU1na3hZSE5hMGZSYjUxS2NNQzVNZjUwQi9TREhhSnNWQklXcE9YWVRWR1hs?=
 =?utf-8?B?ZG5LZmk1TEhmd1I3dmR1ZmhoQUJvSzQ5ajlock5Tajhzd3Zjb0U0NHRPbHZq?=
 =?utf-8?B?Vmc4cHhMNXlzQlcwQTVDS3dpdW9ld2l3SFdCaDM0K0RsRVFPVUpRNmhZMnVN?=
 =?utf-8?B?dEVwVElUeEFGME8rWW90YXBiUmdQTFczL1cyRjk0UUc3RDlSSjdpYWtEY1RX?=
 =?utf-8?Q?y+hymg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVRRbTVQeHVGVHlKYWlybzJDMlpvekxIRkRmZ1JhdUl3WlYyVFlMaW4zSnJp?=
 =?utf-8?B?K3JtZk44cFI2QU43S0gybFFERS9Mcys4SlJ5QVJXWVNLeHhpNElGeDFEa29v?=
 =?utf-8?B?S3NOanFFTUtSUkErYVA5WWZiK0pUaEc3R081dUlobGF5YWgvWi9oR2dzSWhk?=
 =?utf-8?B?TXpsYjF5RDZsZnNKb04rUlpybzV4QllmQzhaQ2JuRWJVVC9VN3poWUEyeDdq?=
 =?utf-8?B?Uit5cUlYRXU0UkxaZy94Tjk1T09sMXZ3MDMwelpINnN2RXAzeEsrUVJWMlFS?=
 =?utf-8?B?Y1o3Y0QrQXU2WXFvV25OUTdRRzg4T1dOekRiQm9ycE1na1Z1NmZ6QkJMRTY4?=
 =?utf-8?B?Y3Rud3dwc2tsOWV2ZDV0TFVnRmh3U2lobFI3L0lOVzFOMXFUQ1IwY0x6a1U4?=
 =?utf-8?B?dmhOdGhTYXB4ZlUyeHNPZmdSdENwYkdrVVhNTmJZRUZlU1JsYkd2U1dENFpW?=
 =?utf-8?B?WkFaRXJPTk92OFFTbDJ0aWIxYVgzUlZ2a2dRUnRMbEdHeFU2c3QwNW9FK1BS?=
 =?utf-8?B?SmFBZy91QzB2b1VEWUNpeGowb1VLM05mY1Q2YnZSWUM1RGlGdEpiVmlPczhK?=
 =?utf-8?B?bXFaZWdoZ1kzakMzZFJERWw2WHVaWk9oVkdhQmZoN1dXMW45RlFBZ3hTbXFB?=
 =?utf-8?B?UDFucnhQY0RpZmJ1OXplMzc0WGY2azd6N1VkODc1NTRWTkpURWJ5Q1FLQnJX?=
 =?utf-8?B?eDl1MHJjaENSa0tlK3BXckRkU1VYdGcySmFiN0EwSHM5VmozL0REUHhzN01w?=
 =?utf-8?B?SENJTFRUanR0MkJzRGh0QnFxM3dHdlZDYnB4b2xxUml4Z01mN3RxcjJ3V0NE?=
 =?utf-8?B?OHNTRi9Sb0dSbzlKSjIvNTNUbXY1RC9aWisxMnJndmxNd0VmSFBzVFhxM1Q1?=
 =?utf-8?B?Yy9PajU5c0pybkRncHJ3clIvd1JOSDMxWUpMNUFSd2RMdTVaUHNYY0RLSkk4?=
 =?utf-8?B?dFVGT1psK3FMM0FwMTFiL2JIeDJZd0ZkTlp1NDUwZWdyTm1HK1A4aWZ1U3J3?=
 =?utf-8?B?OGdoWGZJVm5FWFZoTmpUUUdDUkZoRVNZcWhneEdWMUVSQmg2US9uZUFwT2FU?=
 =?utf-8?B?MXUxbU5sbzFIWG4yQUFZeFZqZm1WRFU5bHRLY2VsVFpyVnZnM3ZneUNhSHhF?=
 =?utf-8?B?K2VqdU5SRFZvbHlWU0I1N3RGY1lrREJYMmkwM2pMYlNtYm5hYW8xVnF4QzFX?=
 =?utf-8?B?ZGRLU1gzdlR0UjBSWWg1aUtvQlZPN0p6WVVTM1I1VlR2MnJUaitzTlFzd3B1?=
 =?utf-8?B?RnVBL282UG4yZW1rd21DSHRWRkF4Y1dQY3BKN0dJTnVaNUN6OGFlVUZHWm5L?=
 =?utf-8?B?YUNYTGFkMTViZ3hsV0dIMVNrSVJBb1RvUmg4MzFWSjFVSS9iaGk2b1NkdXov?=
 =?utf-8?B?NFQ2TGZrVC9wZDRoZ3RQOVBjOVNxTnFQVUxORDhreGZ1OE1tdENVOHZFd0hs?=
 =?utf-8?B?WXRuK1BtL1NrKzMrUkQrdXc5R2JPYjZaRHA1anY5Q1Vkb0wxVnNNWm5aa0lO?=
 =?utf-8?B?VWRobEZHWDdvR29RS2ZvU2piNDhCazZiNnQ3d3FBZnpxRWZnanBNTFhJNjkz?=
 =?utf-8?B?bFpUVjR4ekt1ekNwcEJpM3B0L01iSUZDazFTb0dTMTFHMnBOL3VjNHcyZlVw?=
 =?utf-8?B?b3ZFVElqUzJDVDgrTCtNbHRNTzk1V2podkI1blRmMGtPSmNNaWc2UExDckJV?=
 =?utf-8?B?TkVJTXRtM3YvQWF3V1kxbFdRRGd5R1Y0OWhtaW5VM0RKc2FqNGZOQUlWTnZw?=
 =?utf-8?B?TjlXMzFNUTljZmRpajRBOE9maUk3QkJObnNaTUFGSXhaRXE2NVZLeXorNUo3?=
 =?utf-8?B?SEJra24ybkpVV0hPT2FNejdpeks0MjNzWXY3K3pPdGIyMnhtYmV0VE1VMExM?=
 =?utf-8?B?UTVCbUo1K3dUcUs4ZWdDa2dSSGZNZmRnbWRHdHUrRlJNZkJ6b1RwTEdXV3Zj?=
 =?utf-8?B?YjM2ZzBhbXNWSnFVeUdYYXlTSGpoRzJwcW9odUlWeFg4U2hDYXJLeUZ2NStO?=
 =?utf-8?B?TjZaTWpJMkIyL0ZaWi82Q3RzWmZHZlpUQVBGVzVkcWM5R0JwejVYMjBoTXJx?=
 =?utf-8?B?Y1hIOUR0WWhrRnFsWVFrN1B5VDAvQUJYK2RQd1A2TnJONG51SkdDQUg1enQr?=
 =?utf-8?B?bEdkZkx2dlNCODMzVnhoTXRqOUpnQVRUUjN6clZXd2xKei9jUmJRaitJN2hI?=
 =?utf-8?Q?FF8PCPPGrUEDk9znoS6LvJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02D862F5511F0A45A9E316AAEE0ACB38@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c89c2f28-c2a9-48ee-acfd-08de3114d76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 20:04:31.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvQ0s+/CwXGtMjDbjS/qRMoyrjUQjCuN+XusANEInIS8NIRaddGreIFl/3yCKgMonzmG8pYANKHQhtbGVgH2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5650
X-Proofpoint-GUID: IQZUuaV8-ZRBNvTvyrggPR9DpExqHvGA
X-Proofpoint-ORIG-GUID: 5h8OLAFIVDiOq_owrXom8lk2YxfZUpF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX6YcclYtN55EA
 fF5M4UgN8U8tyRTyoEMe91XzPB+UJ6DS8NGC870p2qCNjIaYhgCEcdXBlWezEQnqtOJ6iuYt+BY
 Q3onGLKXh3ncrXQ7b9vzGNr2oJHpyYYQRRNq23aP56GSelwps/BrNkR9QyivBNy5XKNB0M2CqnV
 8GLdNQ8x1h2E/FEBZoWSnGdQbdzwQDiKhWyl+4uSLQkMP/RS6tktfmUHUKntDpQyVz9++ym1cV1
 x2N2e6JS5ymQEA780I+mDKpONrh+9tap+kRksYd1hgeIxrPuyfQBBEswq7GmdeRABRt36BQ06GQ
 b+hNeYZnx47riRxaiRR3Y9AO1REpNBSx4S6gchYYQ97u1IvA6aD8QRf4ssEdUxLHb0aZKRiXm6r
 0s0yNUni9cXi2nOfikdu77q0cRhW8g==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692df4d6 cx=c_pps
 a=9AjoWhdl+q7f6/Aw5qa/DQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Th5TeqaSyEGE1_fI2-AA:9 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gVGh1LCAyMDI1LTExLTI3IGF0IDEzOjAzICswNTMwLCBLb3RyZXNoIEhpcmVtYXRoIFJhdmlz
aGFua2FyIHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAyNSwgMjAyNSBhdCAyOjQy4oCvQU0gVmlhY2hl
c2xhdiBEdWJleWtvDQo+IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IE9uIFR1ZSwgMjAyNS0xMS0yNSBhdCAwMDo0OCArMDUzMCwgS290cmVzaCBIaXJlbWF0aCBSYXZp
c2hhbmthciB3cm90ZToNCj4gPiA+IE9uIEZyaSwgTm92IDIxLCAyMDI1IGF0IDE6NDfigK9BTSBW
aWFjaGVzbGF2IER1YmV5a28NCj4gPiA+IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0K
PiA+ID4gPiANCj4gPiA+ID4gT24gVGh1LCAyMDI1LTExLTIwIGF0IDE5OjUwICswNTMwLCBLb3Ry
ZXNoIEhpcmVtYXRoIFJhdmlzaGFua2FyIHdyb3RlOg0KPiA+ID4gPiA+IEhpIEFsbCwNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBJIHRoaW5rIHRoZSBwYXRjaCBpcyBuZWNlc3NhcnkgYW5kIGZpeGVz
IHRoZSBjcmFzaC4gVGhlcmUgaXMgbm8gaGFybQ0KPiA+ID4gPiA+IGluIHRha2luZyB0aGlzIHBh
dGNoIGFzIGl0IGJlaGF2ZXMgbGlrZSBhbiBvbGQga2VybmVsIHdpdGggdGhpcw0KPiA+ID4gPiA+
IHBhcnRpY3VsYXIgc2NlbmFyaW8uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hlbiBkb2VzIHRo
ZSBpc3N1ZSBoYXBwZW46DQo+ID4gPiA+ID4gICAgLSBUaGUgaXNzdWUgaGFwcGVucyBvbmx5IHdo
ZW4gdGhlIG9sZCBtb3VudCBzeW50YXggaXMgdXNlZCB3aGVyZQ0KPiA+ID4gPiA+IHBhc3Npbmcg
dGhlIGZpbGUgc3lzdGVtIG5hbWUgaXMgb3B0aW9uYWwgaW4gd2hpY2ggY2FzZSwgaXQgY2hvb3Nl
cyB0aGUNCj4gPiA+ID4gPiBkZWZhdWx0IG1kcyBuYW1lc3BhY2UgYnV0IGRvZXNuJ3QgZ2V0IGZp
bGxlZCBpbiB0aGUNCj4gPiA+ID4gPiBtZHNjLT5mc2MtPm1vdW50X29wdGlvbnMtPm1kc19uYW1l
c3BhY2UuDQo+ID4gPiA+ID4gICAgLSBBbG9uZyB3aXRoIHRoZSBhYm92ZSwgdGhlIG1vdW50IHVz
ZXIgc2hvdWxkIGJlIG5vbiBhZG1pbi4NCj4gPiA+ID4gPiBEb2VzIGl0IGJyZWFrIHRoZSBlYXJs
aWVyIGZpeCA/DQo+ID4gPiA+ID4gICAgLSBOb3QgZnVsbHkhISEgVGhvdWdoIHRoZSBvcGVuIGRv
ZXMgc3VjY2VlZCwgdGhlIHN1YnNlcXVlbnQNCj4gPiA+ID4gPiBvcGVyYXRpb24gbGlrZSB3cml0
ZSB3b3VsZCBnZXQgRVBFUk0uIEkgYW0gbm90IGV4YWN0bHkgYWJsZSB0bw0KPiA+ID4gPiA+IHJl
Y29sbGVjdCBidXQgdGhpcyB3YXMgZGlzY3Vzc2VkIGJlZm9yZSB3cml0aW5nIHRoZSBmaXggMjJj
NzNkNTJhNmQwDQo+ID4gPiA+ID4gKCJjZXBoOiBmaXggbXVsdGlmcyBtZHMgYXV0aCBjYXBzIGlz
c3VlIiksIGl0J3MgZ3VhcmRlZCBieSBhbm90aGVyDQo+ID4gPiA+ID4gY2hlY2sgYmVmb3JlIGFj
dHVhbCBvcGVyYXRpb24gbGlrZSB3cml0ZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHRoaW5r
IHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBvcHRpb25zIHRvIGZpeCB0aGlzIGNsZWFubHkuDQo+ID4g
PiA+ID4gIDEuIFVzZSB0aGUgZGVmYXVsdCBmc25hbWUgd2hlbg0KPiA+ID4gPiA+IG1kc2MtPmZz
Yy0+bW91bnRfb3B0aW9ucy0+bWRzX25hbWVzcGFjZSBpcyBOVUxMIGR1cmluZyBjb21wYXJpc29u
Lg0KPiA+ID4gPiA+ICAyLiBNYW5kYXRlIHBhc3NpbmcgdGhlIGZzbmFtZSB3aXRoIG9sZCBzeW50
YXggPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQW55d2F5LCB3ZSBzaG91bGQgYmUg
cmVhZHkgb3BlcmF0ZSBjb3JyZWN0bHkgaWYgZnNuYW1lIG9yL2FuZCBhdXRoLQ0KPiA+ID4gPiA+
IG1hdGNoLmZzX25hbWUgYXJlIE5VTEwuIEFuZCBpZiB3ZSBuZWVkIHRvIG1ha2UgdGhlIGZpeCBt
b3JlIGNsZWFubHksIHRoZW4gd2UNCj4gPiA+ID4gY2FuIGludHJvZHVjZSBhbm90aGVyIHBhdGNo
IHdpdGggbmljZXIgZml4Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSBhbSBub3QgY29tcGxldGVseSBz
dXJlIGhvdyBkZWZhdWx0IGZzbmFtZSBjYW4gYmUgYXBwbGljYWJsZSBoZXJlLiBJZiBJDQo+ID4g
PiA+IHVuZGVyc3Rvb2QgdGhlIENlcGhGUyBtb3VudCBsb2dpYyBjb3JyZWN0bHksIHRoZW4gZnNu
YW1lIGNhbiBiZSBOVUxMIGR1cmluZyBzb21lDQo+ID4gPiA+IGluaXRpYWwgc3RlcHMuIEJ1dCwg
ZmluYWxseSwgd2Ugd2lsbCBoYXZlIHRoZSByZWFsIGZzbmFtZSBmb3IgY29tcGFyaXNvbi4gQnV0
IEkNCj4gPiA+ID4gZG9uJ3Qga25vdyBpZiBpdCdzIHJpZ2h0IG9mIGFzc3VtaW5nIHRoYXQgZnNu
YW1lID09IE5VTEwgaXMgZXF1YWwgdG8gZnNuYW1lID09DQo+ID4gPiA+IGRlZmF1bHRfbmFtZS4N
Cj4gPiA+IA0KPiA+ID4gV2UgYXJlIHByZXR0eSBzdXJlIGZzbmFtZSBpcyBOVUxMIG9ubHkgaWYg
dGhlIG9sZCBtb3VudCBzeW50YXggaXMgdXNlZA0KPiA+ID4gd2l0aG91dCBwcm92aWRpbmcgdGhl
DQo+ID4gPiBmc25hbWUgaW4gdGhlIG9wdGlvbmFsIGFyZy4gSSBiZWxpZXZlIGtjbGllbnQga25v
d3MgdGhlIGZzbmFtZSB0aGF0J3MNCj4gPiA+IG1vdW50ZWQgc29tZXdoZXJlIGluIHRoaXMgY2Fz
ZSA/DQo+ID4gPiBJIGFtIG5vdCBzdXJlIHRob3VnaC4gSWYgc28sIGl0IGNhbiBiZSB1c2VkLiBJ
ZiBub3QsIHRoZW4gY2FuIHdlIHJlbHkNCj4gPiA+IG9uIHdoYXQgbWRzIHNlbmRzIGFzIHBhcnQN
Cj4gPiA+IG9mIHRoZSBtZHNtYXA/DQo+ID4gPiANCj4gPiA+IA0KDQo8c2tpcHBlZD4NCg0KPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIEkgYW0gbm90IHN1cmUgdGhhdCB3ZSBjYW4gbWFuZGF0
ZSBhbnlvbmUgdG8gdXNlIHRoZSBvbGQgc3ludGF4LiBJZiB0aGVyZSBpcw0KPiA+ID4gPiBzb21l
IG90aGVyIG9wcG9ydHVuaXR5LCB0aGVuIHNvbWVvbmUgY291bGQgdXNlIGl0LiBCdXQsIG1heWJl
LCBJIGFtIG1pc3NpbmcgdGhlDQo+ID4gPiA+IHBvaW50LiA6KSBXaGF0IGRvIHlvdSBtZWFuIGJ5
ICJNYW5kYXRlIHBhc3NpbmcgdGhlIGZzbmFtZSB3aXRoIG9sZCBzeW50YXgiPw0KPiA+ID4gDQo+
ID4gPiBJbiB0aGUgb2xkIG1vdW50IHN5bnRheCwgdGhlIGZzbmFtZSBpcyBwYXNzZWQgYXMgb24g
b3B0aW9uYWwgYXJndW1lbnQNCj4gPiA+IHVzaW5nICdtZHNfbmFtZXNwYWNlJy4NCj4gPiA+IEkg
d2FzIHN1Z2dlc3RpbmcgdG8gbWFuZGF0ZSBpdCBpZiBwb3NzaWJsZS4gQnV0IEkgZ3Vlc3MgaXQg
YnJlYWtzDQo+ID4gPiBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiANCj4gPiANCj4gPiBXZSBoYWQgYSBwcml2YXRlIGRpc2N1c3Npb24gd2l0aCBJbHlh
LiBZZXMsIGhlIGFsc28gbWVudGlvbmVkIHRoZSBicmVha2luZyBvZg0KPiA+IGJhY2t3YXJkIGNv
bXBhdGliaWxpdHkgZm9yIHRoZSBjYXNlIG9mIG1hbmRhdGluZyBwYXNzaW5nIHRoZSBmc25hbWUg
d2l0aCBvbGQNCj4gPiBzeW50YXguIEhlIGJlbGlldmVzIHRoYXQ6ICJVc2UgdGhlIGRlZmF1bHQg
ZnNuYW1lIHdoZW4gbWRzYy0+ZnNjLT5tb3VudF9vcHRpb25zLQ0KPiA+ID4gbWRzX25hbWVzcGFj
ZSBpcyBOVUxMIGR1cmluZyBjb21wYXJpc29uIHNlZW1zIGxpa2UgYSBzZW5zaWJsZSBhcHByb2Fj
aCB0byBtZSIuDQo+ID4gDQo+ID4gDQoNCk9LLiBTbywgd2hhdCBmaW5hbGx5IHNob3VsZCB3ZSBj
b25zaWRlciBsaWtlIGEgcmlnaHQgc29sdXRpb24vZml4IGhlcmU/DQoNClRoYW5rcywNClNsYXZh
Lg0K

