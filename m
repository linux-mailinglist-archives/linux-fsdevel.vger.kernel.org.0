Return-Path: <linux-fsdevel+bounces-69163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F17AC7162A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 23:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2421B32237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1A329C6B;
	Wed, 19 Nov 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m2Quh2Ra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08E2DF71B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592667; cv=fail; b=b6cOfuH25yc/6Gaf2XggvMy9hbW/PpwDHP92qmQG8hPyiNaricBSkwqzlHpJzy52tZdYIK0IB5kGt1fAqKbLPLr3Fb48hDJFHq2Fcz1U98npVNDn8Mqm4GvRtuY5U76KAgK2VKZZONbs9uIloaoSVz0QWhMTY0Qbln1bmXQV3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592667; c=relaxed/simple;
	bh=jpTfz8/EUrEUtR2km4eiA/87vgUfmQ22gOswwV58MuQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nWc/OIryxqYoQQfXcObTTRKh/3oSJei3KdXa795NvOXreibqKhi/oSdwMHHhycTHD0VcNFYVGBxf41efEuscMXewrm7mARPuf4BrSnDpjitcGqDQJgK6Rc7dHYoiwIPafQFHAPSFp4HJsCPIKHI3uNZnKQvugsAZ7m90buo+TJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m2Quh2Ra; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLlEAn003780
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OZNUZbzdgCCaHm/Y0BwVt7qAqWJhCXvH8qzkyNnWPiA=; b=m2Quh2Ra
	f/EQgID1WJ8tP/nytn2/f2NHFCQ+/I6BXJk2wE+eNWPL02M6lCDfDcXRf5ggD6/k
	TbfpE8aWrzNS320sN4VSJRN5lDgYP6s4BSxdQ+Z+ucTOKzQryFMBzfiAnKF8XMGk
	supgR/yCmJy8QWLyRFYI9zJktSX8j5uweXbcTEpzE7qIG8xxqm4VH2FiGDqf3bFT
	Db47yTThyVOIeEmKN2euXu9s5+zl0fSw7WF6V0x8krLRKDodbOj/Twsurq5s9vb3
	6oVgcd4UQAcLE8NRpy0ykevHLU3EXBoLsi2Jzbp5YB1hL734wlzVXqbFWZJcJXoh
	5knA2RUNeametg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju25yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:51:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJMZTSc028852
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:50:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju25yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 22:50:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJMnfnt022803;
	Wed, 19 Nov 2025 22:50:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju25yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 22:50:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRq/W1U+MQ9ICTch4BrzPUtkGRDeCh47GOJRUcn4LqZhTXTeJ1R3b768NHD/w4UOjs7GhF+ILiVeODXOGmA09Z4qU8Dik6tYtyqpR9rc1/SF+UmXt2ux4S1/PWsuCk1wYlcJCriCuQQMMnvhG8OPNHhxsvk6OCXloQIxtXb7eSGhZVS6qYG7+3T5beN9wudevmQnb9rEFFIJMRaqAZZqnoKH6593J1bwTM1HYcHI7ziLDFNJTC2edEUqgfq+7AGO4vQ3Ng/DEVJC7KfRIskxxGG6dOCp43MBFZ9X1ui2j6Ayrt+0wimvznhmS0DWVtVIlkYqK64LC3V+roVRtrOHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBGvo10BV6+kHm5qyyk6a7JQOo6lEpLXku6r5ya7egU=;
 b=eb2mJmdt/9DLBIVrQuU+52SFNtdcgEgCk7NtNm139eQqYB0b3BsV1MEh2Y0jJlO+IOHzrfUHmXBNJbadRgsvCWDTFMaRWAmG7EHr+L84IeWq/YJYPwuhV2AvbqN+3dVE4b+8B3aM18TnjuC8bgN7EG3ePvR5aEharY9U+yji3crqzEJJeC/cQU/REypzvIwsQnKqniOAayuSW3vHzIwfw8FMBnVTQF8hSkNBhOBwEGozzcybV/rCKJP/OlTblXU5IpHMS68FcRhqNtkFTRfvVTEc7yHKSoWHNOvPkfyyctiA+N6V3eLXvtuIP5GH5CbQ9+5dkrs1TYYKdLBcKRnvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPFDBE1F2C16.namprd15.prod.outlook.com (2603:10b6:f:fc00::9c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 22:50:56 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 22:50:56 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        Viacheslav Dubeyko
	<vdubeyko@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>,
        Alex
 Markuze <amarkuze@redhat.com>,
        Kotresh Hiremath Ravishankar
	<khiremat@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcWaV/RIaAnir5XkifXtXvNFHQibT6mqKA
Date: Wed, 19 Nov 2025 22:50:55 +0000
Message-ID: <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com>
References: <20251119193745.595930-2-slava@dubeyko.com>
	 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
In-Reply-To:
 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPFDBE1F2C16:EE_
x-ms-office365-filtering-correlation-id: 38673ab7-6032-40d4-3d87-08de27be1998
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SDRJa3BCem1IS0cvcGxVUkFackpQaEdFY0VGQlB3bEtydnMwanFIMi92TWtC?=
 =?utf-8?B?Z1NPM2poYUtLL01COE83Q3ZGenZxd0lKcVFhcGpQOUZseXZabWRMWTJMTTU3?=
 =?utf-8?B?OFNUakNveWpBWFVnUjZsbUJjcmVpRXk1aDBldFg0d3Z1RmlCd2VqNWFqeUxz?=
 =?utf-8?B?K2xsckhnL2JtT2RkblFaTXJaWjF1bjNCeUhTNWFpTGZxcEZENEErZzY4NjVW?=
 =?utf-8?B?dEJqTzNaOWsvMjBDZGZJQ09EMUt2ZEQxTEdWUXpSbFQxamJPUXU1U1J5cGR1?=
 =?utf-8?B?YVZjTFNPRDR5STVzQVhGWnh2VU5TOWtCSU43Uzd4Sy9DTDVpbFBtbXVBMUpO?=
 =?utf-8?B?SUJTNm9YYmxiWXRtQVdRc3YwNnhHdzJjOUxEc1dBaGk5N3RzajZEOGdhbzVa?=
 =?utf-8?B?NkNqdmMzVEJKa1E2R0V6QlhzdGRGZ2wxVjUrdzBvVDdGbTMzTUtxa0tXb3NQ?=
 =?utf-8?B?amwwM3BYejNTczY4SXNVbHBpMzBSQmk3dGttNlBXelVQWWp2ZnFVYjB2UTRE?=
 =?utf-8?B?YjgvNlU2U1NLNFE3SCs2dEU4SmY2S0U0YWVtK0FJeHl0VFhBTGc0SlRJTnht?=
 =?utf-8?B?ak1Yak1URElZcUNvWkZyZTNLSmdSdG9zNy9rRVpXL2E4YkJ0YjR3bW9ZNGRl?=
 =?utf-8?B?R2EzNUtYWjRQU2I2WVgvUDBJbXFOWDlwK1B3UXBZbFZWRGhRQlB3NThNcWdh?=
 =?utf-8?B?azNYOTdhdUVTT1EzU1J2WjhKSWlFbnNLbWR5TnFaWmRTMGlvTVFIeGc1QW5l?=
 =?utf-8?B?UXAyWEUxZ0hLNlZhM2RNM0tPenNHdVBPYUJyMXJtcHYrNUVhSGNrRkwxSkFK?=
 =?utf-8?B?aGVxZ0ZnditYb0c2OTJISnBHRC9lekR6RVNIRmRiOC9Zdjg3Rjk2OUg4c0R6?=
 =?utf-8?B?alo5SG41cG9qNG1rcHFBN0dtSkJXTjQ4RjBCdGN3VWo3ZitsdlVRTUZjclZo?=
 =?utf-8?B?VXlkT1ZRWDRUYTA5MGdRa2VkSmpDZTBYZUlIL0tJcDIxanFoK1h1T09vKytj?=
 =?utf-8?B?WnJnVTRETzZRVng0VGxiU0pNQ0c4WnF1cHRVUmtiUmFxd3U1SkZ6NHNIOWN6?=
 =?utf-8?B?Yyt0K3V6elA4a09xd0J5OUIvQWpYbnI0TnZVdU1SOS9pbnpJMUJBdUo2REtY?=
 =?utf-8?B?d01lNEY4Ti9tS2dUblBuSCtLaGNTTUl5U2gwaU1jYTI0MFhVMXdmTUhydE9I?=
 =?utf-8?B?d3d5NFlXU29Cd3NKTlhQNSs1S0dkR3Y3eldLZ0JRTy9UVVpoOHhPcEhsWVA0?=
 =?utf-8?B?L0NSMll6cCtzZWZTZ0cyenhSN09OTHV4aC9VaDVZcmIraVJRYW1sbjE4cm00?=
 =?utf-8?B?N2tPTjBKYll4MUJSaXFUbTY4SGNZM0hkcDhPZVJlU0NkbStXbDdveTBPR240?=
 =?utf-8?B?Mi9QSmozbWZPR1djSE40UkRVWXpOOVZQU2U4NUFobmgyNTNTOVdSRTBob0Zp?=
 =?utf-8?B?SXlHR0tGZnI5dXIrYUZFZXVHbWc2eThMaEt6Yy9BTVkrM1hlMWV1U0w4VGI3?=
 =?utf-8?B?SXphNCtGbmwrSDM0UnlpejlJN2hiQ1JjM1dlVzU5ZEhhZmEyTDBHTkNjaFVq?=
 =?utf-8?B?MzkzS1A0SWdRa081MEJ5QnRGNXZDTW0rbnJrR3IxSWM2Tk1nL3IwM0ErdEVx?=
 =?utf-8?B?QlUvS2NIeXlpUjdkMDN5aFlocUR3eVRUVmUxREt2TFZBUUFaQmh2WjQxbXZP?=
 =?utf-8?B?QXpvUEw1UHI2K0FnM01iNWRhWno1VTZZN0RyQ01XQUhGSG00Y3ZvZ1NLNlRr?=
 =?utf-8?B?STRLVDFzd3liNjFuNy9hRk5iV25WVVl4ZHFjclQ0VlRLeGwxQlVJNE9CQWZC?=
 =?utf-8?B?WGdVZnF5MW1SS043S2hIZTFCeFRHWTRCeTVzSUJDSkF1MWI2UU56eE1heFpa?=
 =?utf-8?B?d3ZxbzRPbWI4WmVLelp6bUY4SXlMNE94dEdCdEtLbU1hdFFKQTNUTTg3K0xj?=
 =?utf-8?B?UFZjLzNaOWp4bWhadWhxMTlzUXJCNHQ0dUlnMHZEQ3lpenA2VHBWUFhPRkxp?=
 =?utf-8?B?VE9XR3ErTnBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGd6eUJmekN2WDNvZTBWeDA5NEZGRyt4enRjelUwc1c0aXRvU1lmcnBaY3px?=
 =?utf-8?B?ZUllSmNnSDZjMEFlcVB5UFI1VkVTUEZaVURqY2xybGNjaGFUdUUrc1V2UDhw?=
 =?utf-8?B?eFZ5QmVpOWxieHAwU2x5eGhKUnE0SjRHNm9QaE1HT2RVS09QWjVISFN2N1Fv?=
 =?utf-8?B?VUdHN2pIWStVQXJaQWRQNGphY2hLQVNQSm1vdmJ1SXlvZ0wxcFJYYnJOKzRX?=
 =?utf-8?B?M3NQT0RreVVqUC9KQUVxUEhxZGpCbjlEOTNVRnE3RVNhV29vMlJJQTRPUGJ6?=
 =?utf-8?B?elE5YkxEWXdGL0QyNFZMUW9ja1FwWVlqa2JUQVIyYkpVTG54MzFTdU9wTmRH?=
 =?utf-8?B?WFhuaGNDVExDaDg0RTgrbDBtdTl6YklJRFdPbFRXcDZXZTBSM0x4eGhmK2h1?=
 =?utf-8?B?ZndCRGlCOUVpZUdqeklGSUhvcXZKVTlZSGpuVnduMlhmd0dHaTRNY05SSy9L?=
 =?utf-8?B?U2tYRVZsTzhRb0FVK1NRWFczRU54S2g3NmJ2VGl2QlhJNStGRExCSnFvNDNy?=
 =?utf-8?B?akFxZlh4TUxmdmRseC8wbXdMN2FPczZ5cFdNSHd3ankzeFRtaytLNjlkZjFr?=
 =?utf-8?B?aUQ5OUp4WmxLVkRJbmpiQlRLcWlmR0wxQThJVUVybWJBTmxva2loZlFFZkZ4?=
 =?utf-8?B?OWVIRm1rdDJVMlpsQThieU1Ob1ZNUlpIM0pKS0dJdWhYWnl2Y2w5NE9yVnBM?=
 =?utf-8?B?SkJjMHFsZUsrNVhGb0NjRTVQUWEwUlkvSmNGK2JwU3lGM0l5bTZyTDlSbmVn?=
 =?utf-8?B?M3phQnZMTEl2TE9HeSt4ZkljdWxDcUZkVUk4Q0dWMzk0UENsWWN5L1BDTXQ5?=
 =?utf-8?B?eksyanNBY3ZBanFMbE13R1JGTmxZcmtmdWhxQUZ6akorZGovMnd5SzBDVWZQ?=
 =?utf-8?B?QWFmcENPZmpMU2RQRlYwNS94T0gxdThiR3M4Q0k2U1pzdkpUdjRGVkVNVTRj?=
 =?utf-8?B?cUJXL29hU1NnZVVaVjhWSTlSRWhBVkFHRGRFK3JrZThGQ05QczVYRjBXNzJj?=
 =?utf-8?B?N2RsZEM2RGkrRFJieHZ0aWNZTlNFN1hOVlFVYzhTV28rOTJaWnh3VnlodjhO?=
 =?utf-8?B?QUovdXUvUkhLODY5K0VyYVl1UE8wakZXMzRSQjNsenRNSnpSeDlUOXF5elUr?=
 =?utf-8?B?aGt6UUZFTGR5YmtLSHpvUXlTdDBKWG0yK2dHTlZKUnBZRlVQd2pHeW43TEo3?=
 =?utf-8?B?SllYaWNEK0xTK3NSV1NkS0Yzb1d4WjZ6bEZGakN5ZjV1UFRlbk96SGZ2OENo?=
 =?utf-8?B?NTRKZ2tlR1NxU1BCMHZCd3pMaWJYY2xIdWNiUWxHQzJGUStmeXU5Wk5TRkd1?=
 =?utf-8?B?WVMyaGVIa3UwT2N5VnU3cmcvRHhBZ3F3N2xJbkRKcEIxTEg5K2NuK20zMENO?=
 =?utf-8?B?Sjg2SjBHYUVqS2ovWndZSm82ckJIY1d3TlFlWWZqajVKVXBjOS9pZ0crYzVx?=
 =?utf-8?B?YmhHZlJlSnBSWjBaS3NwcHNJR0J2dVk5YjFnYmZ6aVMycnMvTXZHNHFFWmV1?=
 =?utf-8?B?S2krRFM2VS9HeWcveEVuM1hjRWZ2cUhiMFJpYjNYbWNnQmNlQUVBcTBJWG1H?=
 =?utf-8?B?a2RtSEZTOHB5K2t4WlorcGllNmVWY1ZuOWR6OUhpSXp1NzM4cjlId1pYWkIw?=
 =?utf-8?B?b28rTmtFQnFXNmszcmVoZERXZCtsWTlLajg3eHduTTIwSldUMWtoQlRBbGFK?=
 =?utf-8?B?cTlkTGp2aTloV1FuMnczcWNCcFgzVXNvUTdLSVBDSWp0UWd2d01FWndURUtN?=
 =?utf-8?B?d0FlNGYyUXRkUVRVMGR3WmlLc0hrSmFVS3VWclc5VGZkS1QxdWJZTHpMRFkw?=
 =?utf-8?B?aC9SaXdFUWpUK21ZSzF3ZVpuTzM3bXBXeVR2cVpMNnVRanExaWxVQlJuVjVv?=
 =?utf-8?B?TmhtM1FCNjdYaC9CZUZ1T0NtV3FCeEhUNmUvd09JTTljTUFCenBBdCtXdHp3?=
 =?utf-8?B?WWpNY254MmRDdWYwdTE1VmRTWTZYcU8xOGtDOExoamNVbWp5dDQzbGd3Mmp3?=
 =?utf-8?B?RnVrblpvT0MyZ0wzZzRpczliZFJweUsxcWdrUnJOVEtkUkNPdDA2ZENzRTBQ?=
 =?utf-8?B?NmpWckJGREpOL0M0SzNxTXpHNnZpU21WSXpVaVcybDFZSHFUVXhkWUF6eUdR?=
 =?utf-8?B?YTRuTEhJMzA1MVFCdkxmcVJOaWR6UTlOa1BYWTVWS1Zqbzl3MzllTzQ5R2J4?=
 =?utf-8?Q?MNS7/hrtAcOJgGBQd+nAnVY=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38673ab7-6032-40d4-3d87-08de27be1998
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 22:50:55.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66cVDCUVE+Jzep9iMEgZimTBta1OH2vP/KzU040syO768kULLLni0sYexf1igTUhDbMVhOyCUI8xdLvEiHYdIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDBE1F2C16
X-Proofpoint-GUID: staaDjXx2DUWGxq1Ts5o4wQf6G0CpcAS
X-Proofpoint-ORIG-GUID: tViQzrQjqdZngug0B1rVnWgcbQMjZR4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXxX/QHAS+1u3+
 8OoBHGfOeHExDpcCvZi891QN+1vN7M35dROZT3wjvtA6/AvrZLIiOMED5GybGiC/zhgQeZMBT0d
 iSY+vr1btIkGRo7diD74W4tZ2Hgu9NtG9io2o9mpt8c9nbHs2Mg6kyQqyiJqGesMhVy//5Q52BR
 4Xsdgot9NqgElkTlts2WvXWh2F1ZyezPnK+XX6xdQVwH2LLz50ys4+LHTygtlSqofArj0b76ZhR
 M9ddIzdR4ws88M7yYGITpySMWCYES/PGYC+DpBh/9JF3FynWOETSLu+rM8uJjRKAXNm68OVBX78
 /A4CVyROVos/2rFAfsvvEWsWY/lDxt9G4nEnYcdvsIXkfcZbMheWDEA+DHsBFdLGKwfFf8/zgcN
 KkRtMxilpzRqYk+CpJO7dn8yBRifiw==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691e49d3 cx=c_pps
 a=erT4cWMnywdrD7/NC3b1Og==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=tx9iAuz42_gCB5JD6owA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=6z96SAwNL0f8klobD5od:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A498B6E5D05DA449E0F913B3A1E41B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_07,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511150032

On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >=20
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >=20
> > Killed
> >=20
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >=20
> > We have issue here [1] if fs_name =3D=3D NULL:
> >=20
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >=20
> > The patch fixes the issue by introducing is_fsname_mismatch() method
> > that checks auth->match.fs_name and fs_name pointers validity, and
> > compares the file system names.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666 =20
> >=20
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 1740047aef0f..19c75e206300 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_mds_session *s)
> >         mutex_unlock(&s->s_mutex);
> >  }
> >=20
> > +static inline
> > +bool is_fsname_mismatch(struct ceph_client *cl,
> > +                       const char *fs_name1, const char *fs_name2)
> > +{
> > +       if (!fs_name1 || !fs_name2)
> > +               return false;
>=20
> Hi Slava,
>=20
> It looks like this would declare a match (return false for "mismatch")
> in case ceph_mds_cap_auth is defined to require a particular fs_name but
> no mds_namespace was passed on mount.  Is that the desired behavior?
>=20

Hi Ilya,

Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"), we had no su=
ch
check in the logic of ceph_mds_auth_match(). So, if auth->match.fs_name or
fs_name is NULL, then we cannot say that they match or not. It means that we
need to continue logic, this is why is_fsname_mismatch() returns false.
Otherwise, if we stop logic by returning true, then we have bunch of xfstes=
ts
failures.

Thanks,
Slava.

> > +
> > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D%s\n",
> > +             fs_name1, fs_name2);
> > +
> > +       if (strcmp(fs_name1, fs_name2))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
> >                                struct ceph_mds_cap_auth *auth,
> >                                const struct cred *cred,
> > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 gid, tlen, len;
> >         int i, j;
> >=20
> > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> > -             fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +       if (is_fsname_mismatch(cl, auth->match.fs_name, fs_name)) {
> >                 /* fsname mismatch, try next one */
> >                 return 0;
> >         }
> > --
> > 2.51.1
> >=20

