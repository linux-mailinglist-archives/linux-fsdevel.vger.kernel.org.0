Return-Path: <linux-fsdevel+bounces-76650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLo+DvZphmnwMwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:23:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95520103BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7AC303D2FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA402FE044;
	Fri,  6 Feb 2026 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aFNJoYjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8732EAB6F;
	Fri,  6 Feb 2026 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416561; cv=fail; b=tn8zdZksOed1YUa2Zl86H8R8/Fbl5EHTuf7ZPghF1IVMkfDOkomcXCBujRsNlV8HCmarDR4nCKjZ0734eZglf6GmJFysJAjfkDxb7gOb1ZImNwU2MjhzmISp2dNyhvqSdYOsv37uMauhVnrWRpUjfoutspJouYFca7MpWqa/QhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416561; c=relaxed/simple;
	bh=AfoYGX85nj3WHjzIPDZTvWUe4kxAu0pHemObN9304e0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LbNwsmhwSWMXQCe+L3mHAZofj4UVURm/CSJlp9KyUo0OTnqvukB3v42zByLuI+k0eY57VOllTlBwcVj9FZdc4CRBp9G4L5L8KcODEKAqQsY7xBbxGE+16E9dMWmQwQEMumw6xsDvef2OvBWq0YQrTkFPbpXJv3YDr2a7SMaqxRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aFNJoYjh; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616IdWv6013387;
	Fri, 6 Feb 2026 22:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=AfoYGX85nj3WHjzIPDZTvWUe4kxAu0pHemObN9304e0=; b=aFNJoYjh
	5WAe9rqwwLc6tC9QcN6b/QkKfoLav7MgMveN8C2NaYVbG06A6+wGz43kj5E6XZNg
	Dk8Tu6G5brkL8I7WITuLGOkkXx8oxyrspqhYvxAGrbVI0obIO5J4FeyamyMSq21q
	xQpCjHFWTCpMyE2ic29Gce4xn65YIPb5bCOQF0osSg9LH4diCK0FxaDUwCvmaX5m
	Tn1SBp6LjaUzxqRLlR4ufjK44soObWpi0V6uIyjRwrFx+DYMs2YzKJ9iwWgrcqYo
	rMpASvKbjFmkt5qp7pFNf8oJZgoblDLCA44MecZl7dbAFV0dwmqlqGjbB1/Sfa3O
	rwQkYAVJefCALA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986wnm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 22:22:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 616MMNXs021175;
	Fri, 6 Feb 2026 22:22:23 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986wnm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 22:22:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNVfb++SHFgKcAKHu2zKYk5L8GdNrQi9Z0Syz3QH8R7qUBj/teXZ58WpGyfIYeoPeTjw7A24gTNH4otyYCGGm8rxdDRfPixt9CyFM/YPCGYPTwl3XOmzHoczyLm0fh3Tpgc8V19CrtAkUY5aQyGwSOp80ENxBAc5/1gjdBWKkpD+IjenEcfRMS15oq2r4pP2RzdWlw3b43ProZ42LhXh7yT/9ael8xXOjJaXXDyzpehLRjQFi/AFD71cACieKyBAzOi0xYmvk6NNzdZMzhDkbYOOqXP2OwErF6xgbVKf1T5bSzeJvfqSar9P2NgVtRcuRV5kigXg8QI6QHbLgWq69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfoYGX85nj3WHjzIPDZTvWUe4kxAu0pHemObN9304e0=;
 b=OH5eySAjQJjYQl/eJrDiIyEWoFmyNTLRMI8EpxIXKm1Nd1Gk2hJx09euTp+chHO+j4pGk/IaeRrMnqX6AgZ2SCCFosfe+YOzSp53iB2vLrUhKhvr3kJBkL9Ovwin9eLHpl2ED5BtRYxibqMeZQuoWl/48fTmfhMGIgc1JAULYVuyy26Wfz3Dj2zFHvhvlhomzL+oRgTJfeCyRjuEP0OV/Yp9E3AzadBIMVSVHDuXGyhkVVGIkRSay4VRT+9ykT1+W/hoCEpOLZsRxpC1PAGX8s1T+U1XJEW+KkF1WmEvStvBvO97jyeGHb6P+JR+xU3R6UEzXvufPxuSliWuqpthvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6289.namprd15.prod.outlook.com (2603:10b6:208:444::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 22:22:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 22:22:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "jack@suse.cz" <jack@suse.cz>, "frank.li@vivo.com" <frank.li@vivo.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	<syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount
 setup failure
Thread-Index:
 AQHclMaiKtTJZ48RZUCMz1LaYapWfLVxofOAgAEsaYCAAALggIAAA2eAgAAJOICAA2a0gA==
Date: Fri, 6 Feb 2026 22:22:20 +0000
Message-ID: <95e3ab710185fc18d820a64e6cb98e652de9694b.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
	 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
	 <20260203043806.GF3183987@ZenIV>
	 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
	 <20260204173029.GL3183987@ZenIV> <20260204174047.GM3183987@ZenIV>
	 <20260204175257.GN3183987@ZenIV> <20260204182557.GO3183987@ZenIV>
In-Reply-To: <20260204182557.GO3183987@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6289:EE_
x-ms-office365-filtering-correlation-id: 30b810b6-0c83-4ed0-9976-08de65ce31c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFNnZ25LTFlNc3RaNTNXZVMyd2RxSXJzZXpEMkx4OElCRFMzZmNXM3M5M2Q5?=
 =?utf-8?B?NXllcWVaVytzQ05malhFWk9iWnV1Qk95Vm1YeGdQOVRDTmxFMS9iTVRFUmh6?=
 =?utf-8?B?c1ZzUkN3bEVUVnNtRlJZNXF0MG1HclVxdHNObUhLK0d2NFZSb2dGUTNHSGo2?=
 =?utf-8?B?Y0daTk1iYXJVQi9sakVMQ3ZiZFlRZHpJUVduNFVlR2dQdmU3NEEzUVV3SU54?=
 =?utf-8?B?QTIxUFRIUFVaR0haU0xieWVTeUxQWW5FSThCdzZlcEd2NHJIdmw3a2ZxL05j?=
 =?utf-8?B?NFRLVU9pVGJmRUZiZXIrVyticXMyek1yU0JNUXpxM2xYVjFrQkhUVkkwNE5P?=
 =?utf-8?B?VG9Yai85NXA4ZUM0dTZoeVVONllxeGFETURLc3Z5NzJGbmxXOE51V2ROVE1o?=
 =?utf-8?B?Njk5UU5yQXZxY0ZkUHFaTzlRaHc2bzh0UjEyYzg3QVYra2djK3NydUw1OWhD?=
 =?utf-8?B?T0FKKzNxa2pVaGpqWEFCNkdBc3lEWTJnY3c2S2dCcHBJblFDd2lER25yTXZH?=
 =?utf-8?B?SGVNY0FTMHBTaEVZVEhXUjNPenhZb2sxb25FYjNWeDU1RWFUeVNhQ2V1MTY0?=
 =?utf-8?B?MHJCTWFveHRrbThJNVNtaENTT05IckV4RDFyS0U2QnZ1RUN5dnp4eU00WFpv?=
 =?utf-8?B?MXBMVVMraUJVNmhXYjE2V2ZhREZXS0FQWGxnRlhmRXdnYjBvV0laMWhkcXdj?=
 =?utf-8?B?SWRQcnNRLzBOaThTaWFKY3RNVXpUY3FPdDhBd3VsMCtYc1hENGFSTzZnWjJI?=
 =?utf-8?B?c0cxejZnZzBnZTFidXR5Rk1nMkdTT0FhaTNLS0Nac29mK2VMaFNKR3ZBejE2?=
 =?utf-8?B?N3pNaW42SXdyUDhabTFER3ZRYjRxbDJqcnVBL3kvNUtMMWMrUDkrTlNCY2tu?=
 =?utf-8?B?WnFiV2djaVdUWHFQRHd4YW8rZmduT0E5QkhEbjViVzF5M2J5Q2NkeVdpTnpv?=
 =?utf-8?B?QUpFWW8vekVuSUpUVUFvRzg4S2NyQ1ZwUUFQRC9tT25RZjA3NXZqWUZMbU1U?=
 =?utf-8?B?dm9zc3NRWEMvcVpuSHhSR1U5RjFqZzR6QXA0VVpPamhQUXFoQlB1OC9QZEJv?=
 =?utf-8?B?Y0VBRW9kZFR2ZFBrL0tOc0pkR2ZWT0E3Yi9EYnEra0ZOb1B3dVJGR25nQTFm?=
 =?utf-8?B?bG83aEdtc1cxRytDWUsrR0J5Y29zNFVVU0wzR1NJVEJQSDRiZGRlUHYwdjBj?=
 =?utf-8?B?Rzl0Uy9xN2dOTEZpcUNBTkN1cWxaY013b05ONWdVR1A3VmNXSmxXTWJTRmpN?=
 =?utf-8?B?dTJIZkowMm41MjdpZ3MwWGF0Ry82eUJYSTlrcEUrV1VkSXJlWTg5bjdQZk0v?=
 =?utf-8?B?d3ZzRktFekEyZ05qeFozaFlpOEdrb2tacU5VU1BlTUpTaWU1d2N6RkxKbzRU?=
 =?utf-8?B?eGwybUZPZ01YeWVkYlVKQktJdzV6U3Zia1d3eU0rb0JzSlh6UmgvSHNOR05J?=
 =?utf-8?B?U1dGRzlmVzFET3FpQ2YwNERTalFVaVZoVTZ4VjkzaTJ5blluUm85VWhlVkc3?=
 =?utf-8?B?dDBUS2szNThWZ2prVHR2cThSZXoxQmRTL0hvcGxSczlKUm5qZFRZSnRFVklB?=
 =?utf-8?B?WjRQTDF3YTJYdThOZm1BdnNyc0t6YlVuaXMzVG9EbUFZWXMvbUN2MithaEF1?=
 =?utf-8?B?a0NBeHlsQ1VQZjZjUG55RlhVeUNsSFowUHZDUEMzTG85ZXd4K3pEWVQ3Vlo4?=
 =?utf-8?B?VWJUaW1TK1JJbWdKU2lBNzE2elFmQnp3K2I5cGMyOWpmQ0xBanZGejlaeUEz?=
 =?utf-8?B?UGhUUDkyQ0ZpTGkzS01PeXNYY3hielFZVSs1TzFKVyt1d2grVWRCYVg3ZlM2?=
 =?utf-8?B?OWh6ZWN6Ums0MkNLZUY2QXBlWDJicUs3aHZzd0VSeTVmZS93LzhqbXlXWnll?=
 =?utf-8?B?UjNMNUxULzRvOCtHSjJnanhuSmgzZnpYRGVEQTNoeWpiYVM3VkNOZzNJWEQr?=
 =?utf-8?B?eFFjV0ZYcWZwSTEwTERUSEU4bmd1RmtvTEtZSTdUREd6MjhpM3E1ZHh2aVF2?=
 =?utf-8?B?WnIwSlRSbUtMQW8zRzBoajE3emgxRGh5LzcvdHlEUlZFQ0thMzE4SUJWRUxh?=
 =?utf-8?B?K3dwMzd0SkIrVlZtWnJNMUcyaWRFM055TGVoYzNkMWVVRjFFam9lZmxESllF?=
 =?utf-8?B?c0ZIaG9IM0pTbSt4Q1hISGJEdC82eml3d2EzOWtMQ1ZkRXFTK2QxZDFDU3l4?=
 =?utf-8?Q?fXGKS2MokuX/Ih6erUpeFF4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFNCeEE1ZEdpYitaMzJTV3NvNHpMcUxad1NBSFBBZ0Nka1c2TEcvc2dGdVdO?=
 =?utf-8?B?WTZOK3JCNzBEcDVIbkRTRVhoSFNpZytLZEJTYzhBbXQ5UlAyUStmNVAwMk9W?=
 =?utf-8?B?V08zazVpR09rR2MwS29Kb21ndkU2VkZPclBWLzlyMGtGZE1tbnFiZUpnZ25R?=
 =?utf-8?B?bGZTZXp6TExHWmF2c1R2TUlYNGx4N1dHd2VnU0c3cVNYRWljM1N4dnQ5T0R4?=
 =?utf-8?B?T3VQZ1lGREFvMUZzSEJHSkpocGJCc2NCVzBtUWduckZwTGhRNHZsam0wb1g4?=
 =?utf-8?B?SGtXalBtWTNhL1ZFTmg3b212b1Q5eHF1bnQ1YnVxS1RhRUt6ZHpCUnZicnQ5?=
 =?utf-8?B?SHg5TUFzR2c5Uk9CV242UXB0ZjFkM3VENk9SMjVmTDV0MVpSR1ArWXZVNXBK?=
 =?utf-8?B?VHRvdGVyU2E1L3pCa2o0VnBGWTFqa0tTNGg4a2o1Q1hLZU9sU0lVV21EbWRD?=
 =?utf-8?B?aythTUQ1WWNYSGsvaFJUWjFQK2lJNGZIeDhqUTk3RE5idzloY0JkQnVmckJj?=
 =?utf-8?B?MlVCQmE0RlFUeEsyMUdrOHVxYWVlSkRTR2txeE5SUWN1Yi9PSTZGSCtxWWpF?=
 =?utf-8?B?SUFzZjNoT01qTG5HWmxpZGRTMjRWSi9KMDBYemFtandSYlloL0duY0xicmJ0?=
 =?utf-8?B?c3o2MyswL1VRa1BOZTR2Wi9yYXJLYTVBeS83OVAwdDMyS3RrVEsxckxadHBh?=
 =?utf-8?B?Tm1UQkkyTEE5dDI0eXAwRkR4L20wcHFtbWQra3l6Vnp3T3VVM1JEUS9Jb3Zi?=
 =?utf-8?B?cGNXKzNKUkNQTFgyYTZZcjZFR0JHY1IxT09wS0ZPYVlHSFQ0cTJmcmUrUHlp?=
 =?utf-8?B?dEpBNWVTMFNLTXpPL3JaRm92TEdJVHVQMjBrRGovT0w5ekVPOHZ2NVg5T1dm?=
 =?utf-8?B?d3hJQW5RVFhteFFPRmVrdDJ6Lzk0UUl1ZG1nSlpqajJTS1lXcW84V2VGL2Ja?=
 =?utf-8?B?NldJM1doZjF0ZndoY3VKZ3pucktxTTNOZFZtTDNvYTlFRnZaTVdyYXhobndp?=
 =?utf-8?B?ajErZ1BhTXYzQkJwOTNtVzNSRTU5eUFLMHVLNXJDWlBFUFpIYlVUSHMxNG1r?=
 =?utf-8?B?ajIyM1RoNUJiTFU3Mkg0dzRuNEo4TEpVcHhndUwwVXhrUkZiRVRCb0QxUXhp?=
 =?utf-8?B?SkhWTDB3WnpCSEpkc2QrS3I5U292cWszdnVpWm5qWjNIai9BT3B0bFA3ck1Y?=
 =?utf-8?B?ak81SzNiaXFsVzkyZjdQdmpSWXAzQ1B0M1NTMEVUbXQ4QXB4UlRNbGUwY0cw?=
 =?utf-8?B?bTk4dkxnbzAycmJKWS9yK1MrUlNJMEJqL0NLczRGMnpZWXVmbjZKWTJ0bVl2?=
 =?utf-8?B?dkM5YXdhbHJTRHFTR3Z2akJHajBLWkFhUnNHRThuU2RYT3V1ckkvS29aZDI3?=
 =?utf-8?B?dDJKTmpUZVdPMzE5c2hUOUJBM1lmZjlNZHE2MStsYTRFd25mejRMREVhSFlN?=
 =?utf-8?B?bVdzcFlmRkRwdFo2Tldid2srODl0NHlTU09xenE3S3Y3TkJwNDhjU1NVWVZS?=
 =?utf-8?B?SWRyWG5ua1ZmUWhXVy9DWXNFSzdSSTI4TkRaL0dVM3JmcjY5azkvY0U1LzNY?=
 =?utf-8?B?TWRhZWdrbnRBUnFqN2tOY2FNM0RrVENmdUFBZFByc0o2cDFHcS9OZkE1ZUNK?=
 =?utf-8?B?S2VneFYrUWxId3luS29VdjRpeUdtSXpwZE1LeWhPRFRMZUNmc2hXQ05WRGJx?=
 =?utf-8?B?Tlo2dVJpMXJKVTJyME45OVZFQ1ZUd2xhUlh1aW54VEJEelFzUFRacjQ0eVd2?=
 =?utf-8?B?ZlY0RzhWcWtrOWlzUFFwRnpWSW9GOW9wV281MWdqeEJ5U2tYM2xGanlwWjYv?=
 =?utf-8?B?LzVGc1lpWUowaFAyZU83di9SZDJMS3FscjUzYkxiaHFLRytDRE5wM1hRUGJU?=
 =?utf-8?B?ZStOckdCd01wK1R2S1dObjYyZlFpTy9iR1V2ODU4eTMxN2lWNzRPZFhFbktq?=
 =?utf-8?B?SUk2bWZ1MGdpblR6K0xBb3lad2c2SXY0aG02YWRBUzJ5V2FLR0haSWg0VHFs?=
 =?utf-8?B?ZW9MYzZxZ2xWeFYxNFZjYkxaSWE4cU9jdEo4Q1BrTXcyNHpDTmRBc0xsRHl3?=
 =?utf-8?B?OEZLeGtIdFJBaW4wZkRBdnZNaTFaYXBvald2dmgwemVJMXd2bWZlYU9FRzd0?=
 =?utf-8?B?V1JTcE9VcEg3bFVkaUU2S3J5b0lLUjhCTGE4cG96OHB0ZVdHbERHRHVhSnNk?=
 =?utf-8?B?UHlzSEZvOTZLaHZ5RkVoYnJwSXpYaE1RNzBqVmoyZHpZVnJXMit0WWppUTl5?=
 =?utf-8?B?N0JYTHZRdHdEMTFKR3JpRGs4R0VTblI5NVJ6MzU3TGFSeEJHeTFIbFM2SWdm?=
 =?utf-8?B?ZUhWT3pldllBTXRnaElCMlNrRnZzT3dUWjZzRGxxK0N1ZDdTY2JnZDZ2bXBI?=
 =?utf-8?Q?ViXqBhok8Iequr3AzL1HWJb2IIooRDdmtdpyc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <130F046FB8C97B44B79844357FBD2FD5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b810b6-0c83-4ed0-9976-08de65ce31c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 22:22:20.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vpPUD7yigNE9Kl+VmZXaUfHSAiqpwI9sPlZbi777v2IlVT078ESl9YRx39vCbr+wa2y1V9YYmgb5ALrUA5xuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE2MSBTYWx0ZWRfX3jXR2xHBh4qD
 2IV/36jq1zKW9oPll3IckdpXcfuHobPQPWxYXSUaxA+WycboQPxjveAMQEZrJ7hjhOAimVzb6/O
 sdk2+I4v+kFcLmwqH6zy084oxDkJLgm8wSl8URU6D5I09hB9TOcdDPKnO0Caq7F+MvLXEiWuxVc
 1MpZyQ6MsU9bNvawtbtw33qsA94TYoo6qo65NE6dCiCp5OfYz0X56FhBOcnn0HkOYhWl9lssfee
 apkV/7cPePsGixt4MJYl9m6gN5JX7WteIBfSgTNX4npDS2MsgL+5dZs+PF1Uy6sTEE8lfFIXChr
 /oIu0U5UvL3XuexFUYaT/8IyphsbPzZM0d+758/ljO7dEmuBV+fPs9Kj3IqrP07INLNjkQN1glQ
 nOsYRnzQMccR9D4pYwwidKbL3KwaFmdEq2H+wgWWRGbQJEHaZKLXoeEfGJfsiYuwq69kEN3rlQh
 24PtRqX3qXXvBMBFkWQ==
X-Proofpoint-GUID: OSy4QcEHUUJztBxUao202aPvV34vPbZz
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=698669a0 cx=c_pps
 a=hdF+edV3qND9tYm1xB2jJw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=37YqlSKPoytKTb9v9aAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NgNymT3eYn5N82axRcjhNgZ0mXP3ib5d
Subject: RE: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,gmail.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-76650-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 95520103BF8
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDE4OjI1ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBX
ZWQsIEZlYiAwNCwgMjAyNiBhdCAwNTo1Mjo1N1BNICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiA+
IE9uIFdlZCwgRmViIDA0LCAyMDI2IGF0IDA1OjQwOjQ3UE0gKzAwMDAsIEFsIFZpcm8gd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEZlYiAwNCwgMjAyNiBhdCAwNTozMDoyOVBNICswMDAwLCBBbCBWaXJv
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IFdoaWxlIHdlIGFyZSBhdCBpdCwgdGhpcw0KPiA+ID4g
PiAgICAgICAgIGtmcmVlKHNiaS0+c192aGRyX2J1Zik7DQo+ID4gPiA+IAlrZnJlZShzYmktPnNf
YmFja3VwX3ZoZHJfYnVmKTsNCj4gPiA+ID4gbWlnaHQgYXMgd2VsbCBnbyBpbnRvIC0+a2lsbF9z
YigpLiAgVGhhdCB3b3VsZCByZXN1bHQgaW4gdGhlICh1bnRlc3RlZCkNCj4gPiA+ID4gZGVsdGEg
YmVsb3cgYW5kIElNTyBpdCdzIGVhc2llciB0byBmb2xsb3cgdGhhdCB3YXkuLi4NCj4gPiA+IA0K
PiA+ID4gQUZBSUNTIG9uY2UgeW91J3ZlIGdvdCAtPnNfcm9vdCBzZXQsIHlvdSBjYW4ganVzdCBy
ZXR1cm4gYW4gZXJyb3IgYW5kDQo+ID4gPiBiZSBkb25lIHdpdGggdGhhdCAtIHJlZ3VsYXIgY2xl
YW51cCBzaG91bGQgdGFrZSBjYXJlIG9mIHRob3NlIHBhcnRzDQo+ID4gPiAobm90ZSB0aGF0IGlw
dXQoTlVMTCkgaXMgZXhwbGljaXRseSBhIG5vLW9wIGFuZCB0aGUgc2FtZSBnb2VzIGZvcg0KPiA+
ID4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgb24gc29tZXRoaW5nIHRoYXQgaGFzIG5ldmVy
IGJlZW4gdGhyb3VnaA0KPiA+ID4gcXVldWVfZGVsYXllZF93b3JrKCkpLg0KPiA+IA0KPiA+IFNj
cmF0Y2ggdGhlIGxhc3Qgb25lIC0geW91J2QgZ2V0IG5scyBsZWFrIHRoYXQgd2F5LCB0aGFua3Mg
dG8gdGhlDQo+ID4gdHJpY2tlcnkgaW4gdGhlcmUuLi4gIERlcGVuZGluZyBvbiBob3cgbXVjaCBk
byB5b3UgZGlzbGlrZSBjbGVhbnVwLmgNCj4gPiBzdHVmZiwgdGhlcmUgbWlnaHQgYmUgYSB3YXkg
dG8gZGVhbCB3aXRoIHRoYXQsIHRob3VnaC4uLg0KPiANCj4gU2VlIHZpcm8vdmZzLmdpdCAjdW50
ZXN0ZWQuaGZzcGx1cyAoSSd2ZSBhcHBsaWVkIGxlYWsgZml4IHRvIHlvdXINCj4gI2Zvci1uZXh0
LCBjb21taXRzIGluIHF1ZXN0aW9uIGFyZSBkb25lIG9uIHRvcCBvZiB0aGF0KS4NCj4gDQo+IEl0
IGJ1aWxkcywgYnV0IEkndmUgZG9uZSBubyBvdGhlciB0ZXN0aW5nIG9uIGl0LiAgQW5kIG5scy5o
IGJpdA0KPiBuZWVkcyB0byBiZSBkaXNjdXNzZWQgb24gZnNkZXZlbCwgb2J2aW91c2x5Lg0KDQpJ
IGRpZCBydW4gdGhlIHhmc3Rlc3RzIGZvciBIRlMrIHdpdGggdmlyby92ZnMuZ2l0ICN1bnRlc3Rl
ZC5oZnNwbHVzLiBFdmVyeXRoaW5nDQpsb29rcyBnb29kLCBJIGRvbid0IHNlZSBhbnkgbmV3IGlz
c3Vlcy4gQ3VycmVudGx5LCBhcm91bmQgMjkgdGVzdC1jYXNlcyBmYWlsIGZvcg0KSEZTKy4gSSBz
ZWUgdGhlIHNhbWUgbnVtYmVyIG9mIGZhaWx1cmVzIHdpdGggYXBwbGllZCBwYXRjaHNldC4NCg0K
VGhlIGNvZGUgbG9va3MgZ29vZC4gQW5kIEkgYW0gcmVhZHkgdG8gdGFrZSB0aGUgcGF0Y2hzZXQg
aW50byBIRlMvSEZTKyB0cmVlLg0KV291bGQgeW91IGxpa2UgdG8gc2VuZCB0aGUgcGF0aHNldCBm
b3IgbmxzLmggbW9kaWZpY2F0aW9uIGRpc2N1c3Npb24/DQoNClRoYW5rcywNClNsYXZhLg0K

