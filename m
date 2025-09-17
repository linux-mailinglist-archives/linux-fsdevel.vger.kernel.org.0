Return-Path: <linux-fsdevel+bounces-62002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF62B81955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB01E3A94C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0B285043;
	Wed, 17 Sep 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q0HM9CAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E082D5938;
	Wed, 17 Sep 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136812; cv=fail; b=CXHlqCQPmizrURcJLY1wBhF5Koi33GYBbrwyFHAwXM1kTpjd/QPMa6Xt0yhQF3sJuZkwiQ2Du8sRMxl//ocJ3DDYVGe6kUnMupJQ/PNRBwEhr40+TV7vWtQoDzCH7upK+mYvSsTqo2zeG6rBhooa6iFF1Cl7wYSJ5ODecZ2nWeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136812; c=relaxed/simple;
	bh=6PdnXiU64gKKRqJk8Zv0bP6CiprMQWNy1whnaGNSOLs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=gXdc8Zhj3uPVmvinHOuQTOuxOa1Jpu2lb+oTuHnRMpy9xQLy2nF3Udshswp5mgoWd/737jz4Ql3DNw8RJ9RaI+iZkaDr4w6DcXciuO1UlZZA/PvFVYMVtlMHpJV1agbGENZufOo2z1M4QQynMHr+fLUUPR2c6SdPwyOq7sLofZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q0HM9CAR; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHgPQD020977;
	Wed, 17 Sep 2025 19:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6PdnXiU64gKKRqJk8Zv0bP6CiprMQWNy1whnaGNSOLs=; b=Q0HM9CAR
	BwQOospd5HE70PE+3VP4/WaOcmMAAnx+pSx3rbzvE4hbhXdkIGI85YBGVFWAVf2l
	YDfKjpSkZxtvPRtkS4b22iZGhPChjdtmCjZn+WloYqz0SQwLkcTp+YSRWF1VJzr6
	Bf8QWAkgtwSzO/KUt9O/P6kxuUpQY1HzWF857NrIRHOdxG5ClkLNhp0qBH5+bBEG
	4zA9XVUurx3iGmy5UzrrtzLG5WEasDS8cu0j6zRp+oeE1f4nf7WCnEd8oDlBtbNC
	g14SEFCwwB1Hl8SoVyglxiVifmHUfXU+8XUmxp4X8tmcZms4D1tAEHCfjGfEphrZ
	AEVVEAOZnOCgCw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4m5hr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 19:20:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HIuMQ0008586;
	Wed, 17 Sep 2025 19:20:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4m5hr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 19:20:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAw1b2PecN4mgG4c9RLlcd6VrGo4p/QsOB4x7QCXyDkYXID6OwJCwzeUGyyyO1vKYsqgN1JWu8Swfh1v1Q7m8J6TiqSa58Ik9aRJu5xBQgSbKtFyWgRKWX3+obh3b7k4zh41pqdWvBedQcBtluzKMvaO/57yC7dG5TBy9IbsHGMoeuxyJEE0h1kxQ67oHtdMjHNc/PKVDKRnXo2chbs6aeJCKnqui+J+CLwHf66TYaZaswLR6+bLGlb+LxTl4XCl8Ul+dz+bUuysJ63m4S+q5Zk1EKgwHdeaJDSi+1lQkRN8y6zEhiV5mMJ8SofMGoNEqhHyr8hCNoopYLeBQW+iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PdnXiU64gKKRqJk8Zv0bP6CiprMQWNy1whnaGNSOLs=;
 b=Fnk9rVCXDsRrIrD8ck7WstVYhe4XvPSbYZf2StQWOyJgX/Ft62Jcq4dOP9IiYctzt8O/7Tq9aK/7s9+OQ+K6a0xzYGROzgRxt5EbBZvh1TC0aQGbJPEEQMTu3yAajEqMnhDmmDwzoY05/gRPL68f3iURgLrwkcRjUpJkrqzsQfcTdt+hS3ACbZgyeEDLbcBScKsJBjU/mvlOchBRBuYo3N4JfZKGkDDyyhUSXyswckM7m0vP8uWnb+mpYXyTcwCyb4mUYEq6uXqGmU99D9l89ar8yNXb1GMXV564iB4vHA81XyylDy8ZEEQBQzlQU7xhqFWMSW80pXGOGBIrdef80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5301.namprd15.prod.outlook.com (2603:10b6:303:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 19:20:01 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 19:20:01 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netfs@lists.linux.dev"
	<netfs@lists.linux.dev>,
        Alex Markuze <amarkuze@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix deadlock bugs by making
 iput() calls asynchronous
Thread-Index: AQHcKAY0W320v/BEJ0iP4JgktOT1tLSXwBIA
Date: Wed, 17 Sep 2025 19:20:01 +0000
Message-ID: <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
		 <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
	 <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
In-Reply-To:
 <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5301:EE_
x-ms-office365-filtering-correlation-id: 0b75f110-27ec-4206-24a9-08ddf61f32b0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnVraDZBY2djOWRXQzlidzJ0Ym9zZG91aTBIOTZKMVVSR3BiUVJybVRtUnBU?=
 =?utf-8?B?Mm5uS3htTXN2aGRwaXhYRkpyalBqbGVpSituWHZhcGsvSFNiTlEzcFFodlZq?=
 =?utf-8?B?aW9XMTk2aWhmalk2TTFCUER1UGJ2NGlDNWpvTlE2eFhvR25RUkozRWxudzli?=
 =?utf-8?B?dkV4bHJERU5xTEIzdHYrK0JyTUdLWFRDWTdJaXhPSGdmY3dkY0hOQW5JVHZD?=
 =?utf-8?B?dzNYbXJaSElDODdIeFJQa2dFeTN2OWdOcnhvOFAyWTEzd0tEWnFDZW84VVFP?=
 =?utf-8?B?Wkxwb21lQ21CVHcweFRFTisxdVFWbnRjSVRKT1lIS3dMelM1S2M3MW9EMDlN?=
 =?utf-8?B?M3FvSy9ERGhVclV6NkR5R0UxZVBFS09qMEFOV0ZrL3duUWZ1aEJUQnRGZFB2?=
 =?utf-8?B?OUEwQ05nL3N3Ui9IMnNjNlNRdW1Yd0lLbFU5ZzFSSHBaMENIREpybktBRUNW?=
 =?utf-8?B?bkg3Rk5hakU3Wks1YXNLZjVIUFB3bW5XK01kRTVsMW1qSFE3SHQyY2IvZVZ6?=
 =?utf-8?B?Yk4vanpwRVl0aGZlNmY0U0t4eWhLaGpKdmtWYjN1c2I4R0FZQWszeDRrNlVF?=
 =?utf-8?B?Z0RMR2JzTW5FQ3kyMWNLdXVoZWVhU05oSUtRRlNPSzFVKzc0SUNtc0RuOGxH?=
 =?utf-8?B?T3pLa1F0WVM0WkJqaGhLNEpaNm41alFoaWJHYUxMcTdidTMyZmp1Vkd2SVdU?=
 =?utf-8?B?UnJTRlZEMnpkU2U2RlEvaDdqUFNzWmZXdWcrSlZlRnVnVnErSVBiVm5UUWU5?=
 =?utf-8?B?dTdOSG1hVjd3RnN4bi8vVEYvNCtCVEJWVVZFWFNZbWh2azdSVXdsUGVXM3pW?=
 =?utf-8?B?TU5TL3lIbUw0Sm9zaTgvN3BTRWg3bTRRaXpYL1FjSzJvUzdMb3grT1cwUkt1?=
 =?utf-8?B?cW95SFJjTyt1WUxTRXNDd1NzeURsVVJEY2Zid2NRTWtRZWE0cFI1d1R5QlBX?=
 =?utf-8?B?WkV1bjBxSmpVb2ZORWFuUkJ3U2MzNFRLV09NTHBjYnMrQm1NbGpPeHE5bW5w?=
 =?utf-8?B?eFJKZFFSKzk0bCtFdW9SMVp6YUhOd2NQWWRQTVdSbDZmSDdMa1hDSGVPNE1Y?=
 =?utf-8?B?RnY3WUhrQWwxclh4YlBjUkpBZXFXZkpWTldQNjI4ZytCM1VxdG16anh2VWRh?=
 =?utf-8?B?cG5YMWVrTk5Ec1lYQ1ZUckRiSGY0dys1a1laeGtLc2VIVXFWODd3OWtvQ21o?=
 =?utf-8?B?TXgrb21TV3Zlcm9XN0dGY281Q0VBU2FCWUJud0tHRlN6TWZobUdvN1IvWSt6?=
 =?utf-8?B?SXpKMGMxQlBGTi9IeFFqRm9CR081RWxqTWZPSkRQMEcva2R2WGF2cndXcldr?=
 =?utf-8?B?eGpzWGUxbTd4UFlLS1Q3QnZxNjNrdm9zWThTbVhXNWh2UmRMYytVd3UrUUpY?=
 =?utf-8?B?RzJHY3NqRWpqSHFKakJ0cEFNdFlkK0pDcUZ0OTNiNWtJTkdZZGJIN1RIdzdO?=
 =?utf-8?B?MklULzZvN1pocjlEQXowc21FUUUzajNBZjFlb0YyZWZ5QlpwMkxHUWlxamp0?=
 =?utf-8?B?MzJxTjE2VFJ5TVZnS0EyZlI4VGVXWjI2WG5iSjNTa2NVVFVEVm9FdlgvbjRr?=
 =?utf-8?B?Ynh6R2V4cGNrbk84WUVxRzFVMWxJRXZ1Y0FTVjN2VWd1T3Z1aE1vdDJQT24w?=
 =?utf-8?B?MTVmWHUzakdEM3ViSXZHN05HbENwYnVrei9wV0tQamRXdmpvYzNVVkxKd0VP?=
 =?utf-8?B?TnV4SFJveXBnS25pWkR4VlFrTSs3Zzh0NFlVMThyVGF0NFliSmwrL2lQcjQ4?=
 =?utf-8?B?RlBRa1M5eGVKOUFzRW9CTVpmSVlRQlRvVDBER1Azd1BNUExIb2pkYzhRdm1Z?=
 =?utf-8?B?NXZTekxVQ3lpbE5hVkU2S0xJeitwQnJINWhrTmxZS3gzUDJMOUFFU0hBUi9u?=
 =?utf-8?B?NXZLT3BNNTRZMkVOWmFrY1BoMEl1UXByc0d2OTF4elJtbEhlQi9MODRyckhF?=
 =?utf-8?B?TUVrQ1VNZm5vNm9uQzR4OW1xR3lSWjlMOVhUeVdWQUZDKzlRZi9pdVdFWkxm?=
 =?utf-8?B?WW9jZEpuV1F3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDFwR1d5TFlTbmhNYnJBMGdwaUJBbmUycDhra2UxczRQSVQ3NENTYUUyT1o2?=
 =?utf-8?B?cXBCK0xaTmRrR2ZHNmJodTRkYmR0eXgvSkgza0hFbnozQisyZ0VqKzV6OTFO?=
 =?utf-8?B?anYwVkZsSjlWSVZqdFRxVm5oQWxhTnpLMm02WS9COHV5Yk9nTTNjanQ0cDRr?=
 =?utf-8?B?Yk82SUY5bkd5dGFRR0tZOHYxRFpsRWZNeUc0OUoxREcwNjdYN1ErNzFXZFlL?=
 =?utf-8?B?OExYYzVMRlJ0Mk1ESUt4R1E4REZFOERPd1ZXS29JZEVyZFNiZTQzY2E1cE5w?=
 =?utf-8?B?NHRyVW01emFGclloQlBwNVJXZ2VXOW1TSFJPaTFWZE9CTCtKZDVxVnhQQVNI?=
 =?utf-8?B?VEZRanMrMXBBT0Uwa3pJVW8va3pFQUNXT1FLbmF1c2xOZXBidDNsSlB0d3Q2?=
 =?utf-8?B?dVIzWkwwRkVJbjNvdnEzNGhKSEF3QVo4VEp3TXZlOW1VS01XYUIrSUMraXBn?=
 =?utf-8?B?TDZiT3hWU0RMVU5qUlYzZkV4ZU9BL2JNMUc0YmJocklkVmpyV2VSanoyQzZI?=
 =?utf-8?B?UXlkYjM1SnBoK3ZOVVpZL1MxSEtLRnYxWU15RXRkdmxkSDIycVBBajF5TmV1?=
 =?utf-8?B?VitHckl6VFhkUk5PSld1REFrdDhVUzU2UldSM3dnNllSNmZCcDBQbzB4dnRD?=
 =?utf-8?B?bHZ6YWF0VUJ5dXZ2L256OG95ZGI4QVU2NlJDUlZlZUk3NTcvbE94cG9sL09o?=
 =?utf-8?B?OHg3c3hlbVdFQWM1OEl6ZTMvT1oyenBNYUkyL0lQdGZJY09HbTQzTkVNbHBw?=
 =?utf-8?B?OTVJVm9Md09iNG92S3FlY0xuREdLUC95NEpKcEhSUGdXVVBXM3EvYllUVGFZ?=
 =?utf-8?B?OFFjdnUxeUR3dW1DdEgvVnZTa0ROKzdXRTMrK2plYkNJWTVGWlBBaW5ZeVM4?=
 =?utf-8?B?eFR4SXJBUHArSnM4OHBkbGZ0QzZSWVE1djQzMjY2V1B5YmluZGpoenhtLzFI?=
 =?utf-8?B?RXZtYXJOT0Uvbno1ZlJ3K2xKdnJoa1Axblltb0JEdFB1WXpGcmFvNzZVV1BT?=
 =?utf-8?B?QzF6NE9nd2hoQTcxUnFLOCtKcEFMT1dYbTFGV3Y1NGRQanpNbC9ISDlFWlg2?=
 =?utf-8?B?M1d2TnlvVUw4RlJDWjA0VFdHdzYyL3lxTW9DNmJQMjN4Zi8wYlE1WEd4R01w?=
 =?utf-8?B?ek1haEpJWlM2a1FOdzF1Y3JlTWlqajRhakM2WkVOcURaUEI3RVhmd0NDemRX?=
 =?utf-8?B?S2p2c05Qcmtzd0dHN3ZxOGJ1RUVDZlBhdXBxTExLOW93eGJlYm5qYkNaS2hm?=
 =?utf-8?B?eXBUMFFmTnljQzRuY1JlWjRnTTB3OTJlaEhXejVuSjJmSlE5TjliWjErbmNM?=
 =?utf-8?B?ODEzZXFHRzc4eWRmdU5SUVc3emI2WWgwellEOXZDUVZVdHVXMkdTdXhua1dN?=
 =?utf-8?B?OWFOeDhPRVhYZGZqOUc5eHVWM1pOMTE0b283Skh0bnlzWld3S2xDMjh0Q1NQ?=
 =?utf-8?B?Q1JwODR0b21jN2k1TEZwS0dIbkpORFdJemhMc2tlNENRSklTSU9aSEJJUlp4?=
 =?utf-8?B?d1gxdzhKMCtoTzR1L0dyVGIyR29Db05KSHNMNDFaWVBnOExEcHp5a0VQTmtO?=
 =?utf-8?B?UkppNFZrbU81RzJDWThkaUZwZ2dlbnpaRWNoUERKeGs2VzZoTExxVmE5WVQz?=
 =?utf-8?B?Y25vT2tWV2xMTEdQRkQ3aHVXNytYMjJoL2Juc0c2bG9oQ0VyZHVLdS83Z281?=
 =?utf-8?B?SDNiREdNYkVXbU5nbWRMWEZvTlpLdmw3aGtnZ3l0UTc0TEVhSTlkMTFldGM5?=
 =?utf-8?B?VmFvT3BsWGk3bTBCVmNVM0kwZHJJb2JsN0pqRlRVUyt2ZmlPYWNZaWpIcmho?=
 =?utf-8?B?QjM5Zk9uR2R6WTFOQ3pmalNjSk9UY092Q1QwTW5lNC9QUzhQdHBzSldrRDFh?=
 =?utf-8?B?UExkbDhVMHh1NGNvYS9zb2dmQUJpUlRXeGFoaDlkMStZb3EwVFJFWWdsUWR0?=
 =?utf-8?B?TWZZaUZRU2t1Q2xWaVI4Ym51QStpNDdoMVhTd3I3Y1F3Wi9yR091eFJHcE5h?=
 =?utf-8?B?MGg0Wkh4dEJES01yWG9NRkxrbm9kSzRIUVphdk0vSGZXelRJcjVpNXpSUVdo?=
 =?utf-8?B?UHF0RW9FTEhDclNaOG9vS09sV0VTYlJ5dVVqMlowYkQ3MzhWZldMOTJlWlgx?=
 =?utf-8?B?MURuVGljZTBiWm5heVFDeHJLQW9Hb1FDNUQrcG1Lc0dadzBwd1NqZmV6UlJj?=
 =?utf-8?Q?RloeicxIYaCEsrp5ziKmSmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9C8F53A7B8764482DE998A0FC24841@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b75f110-27ec-4206-24a9-08ddf61f32b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 19:20:01.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB6jIXiOAhWR9fJ8J+MAy5ijVYv/xHIhpIzbRF3+nr8DpR9fKPAUGwllUXnsiCYEn/sDULtd+o2E4tN3myjnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5301
X-Proofpoint-GUID: PeLFxKBGuYHFcww_mDdTPeycwpoAQYup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXznR6wRFBRHTV
 05tNl4jua9vSvCrWUWjI0xCH6OxjHs7io+OGBUdID/UuQemT+inBdUuUer9XIG2+32/DHJs7h/e
 U0heZB5Zz0MYkSL9Lfc+uVjjKxLlk0uiWvqD7RWhotLiIXve4wmjyyO/bPdhzmCQi0m6E0GkjgW
 uf8I96LDTLpUVnkRLtgfPeZzhmGuhEBLWnA5bAoD539zKniP5nTbsQ7FqOJx5Zm4p2oeWbDHvx1
 vx0M/UW6BoMi8OVPG3NMrH4rkkW97x/aK4Bpq8Lzww0oSqtSY5dtjsSFyUQ8ABeRQ9FOfQq0q3H
 E1TPhunH7GnS3KSob+DdUIJc371U8S69F4pEAB5S1czk/wUI4MfLvy4aBrN2yExEPNNIJBNa8RA
 cXIeTBMq
X-Proofpoint-ORIG-GUID: 2XZKIwQOe-ODWKmvF6mxR3MZ4v4vUf51
X-Authority-Analysis: v=2.4 cv=QrNe3Uyd c=1 sm=1 tr=0 ts=68cb09e4 cx=c_pps
 a=qaGWf3H7ZUycNCJ7m3WmPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=mqJXHTL29bPCojfdwpkA:9 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v2] ceph: fix deadlock bugs by making iput() calls
 asynchronous
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

T24gV2VkLCAyMDI1LTA5LTE3IGF0IDIxOjA2ICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gT24gV2VkLCBTZXAgMTcsIDIwMjUgYXQgNzo1NeKAr1BNIFZpYWNoZXNsYXYgRHViZXlrbw0K
PiA8U2xhdmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiA+ICsgICAgIGRvdXRjKGNlcGhf
aW5vZGVfdG9fZnNfY2xpZW50KGlub2RlKS0+Y2xpZW50LCAiJXAgJWxseC4lbGx4XG4iLCBpbm9k
ZSwgY2VwaF92aW5vcChpbm9kZSkpOw0KPiA+IA0KPiA+IFdoYXQncyBhYm91dCB0aGlzPw0KPiA+
IA0KPiA+IHN0cnVjdCBjZXBoX2ZzX2NsaWVudCAqZnNjID0gY2VwaF9pbm9kZV90b19mc19jbGll
bnQoaW5vZGUpOw0KPiA+IA0KPiA+IGRvdXRjKGZzYywgIiVwICVsbHguJWxseFxuIiwgaW5vZGUs
IGNlcGhfdmlub3AoaW5vZGUpKTsNCj4gDQo+IFRoYXQgbWVhbnMgSSBoYXZlIHRvIGRlY2xhcmUg
dGhpcyB2YXJpYWJsZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KPiBmdW5jdGlvbiBiZWNhdXNl
IHRoZSBrZXJuZWwgdW5mb3J0dW5hdGVseSBzdGlsbCBkb2Vzbid0IGFsbG93IEM5OQ0KPiBydWxl
cyAoZGVjbGFyZSB2YXJpYWJsZXMgd2hlcmUgdGhleSBhcmUgdXNlZCkuIEFuZCB0aGF0IG1lYW5z
IHBheWluZw0KPiB0aGUgb3ZlcmhlYWQgZm9yIGNoYXNpbmcgMyBsYXllcnMgb2YgcG9pbnRlcnMg
Zm9yIGFsbCBjYWxsZXJzLCBldmVuDQo+IHRob3NlIDk5Ljk5JSB3aG8gcmV0dXJuIGVhcmx5LiBP
ciBkZWNsYXJlIHRoZSB2YXJpYWJsZSBidXQgaW5pdGlhbGl6ZQ0KPiBpdCBsYXRlciBpbiBhbiBl
eHRyYSBsaW5lLiBJcyB0aGF0IHRoZSBwcmVmZXJyZWQgY29kaW5nIHN0eWxlPw0KDQpNeSB3b3Jy
aWVzIGhlcmUgdGhhdCBpdCBpcyB0b28gbG9uZyBzdGF0ZW1lbnQuIE1heWJlLCB3ZSBjYW4gbWFr
ZSBpdCBhcyB0d28NCmxpbmVzIHN0YXRlbWVudCB0aGVuPyBGb3IgZXhhbXBsZToNCg0KZG91dGMo
Y2VwaF9pbm9kZV90b19mc19jbGllbnQoaW5vZGUpLT5jbGllbnQsICIlcCAlbGx4LiVsbHhcbiIs
DQogICAgICBpbm9kZSwgY2VwaF92aW5vcChpbm9kZSkpOw0KDQo+IA0KPiA+ID4gKyAgICAgV0FS
Tl9PTl9PTkNFKCFxdWV1ZV93b3JrKGNlcGhfaW5vZGVfdG9fZnNfY2xpZW50KGlub2RlKS0+aW5v
ZGVfd3EsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNlcGhfaW5vZGUo
aW5vZGUpLT5pX3dvcmspKTsNCj4gPiANCj4gPiBUaGlzIGZ1bmN0aW9uIGxvb2tzIGxpa2UgY2Vw
aF9xdWV1ZV9pbm9kZV93b3JrKCkgWzFdLiBDYW4gd2UgdXNlDQo+ID4gY2VwaF9xdWV1ZV9pbm9k
ZV93b3JrKCk/DQo+IA0KPiBObywgd2UgY2FuIG5vdCwgYmVjYXVzZSB0aGF0IGZ1bmN0aW9uIGFk
ZHMgYW4gaW5vZGUgcmVmZXJlbmNlIChpbnN0ZWFkDQo+IG9mIGRvbmF0aW5nIHRoZSBleGlzdGlu
ZyByZWZlcmVuY2UpIGFuZCB0aGVyZSdzIG5vIHdheSB3ZSBjYW4gc2FmZWx5DQo+IGdldCByaWQg
b2YgaXQgKGV2ZW4gaWYgd2Ugd291bGQgYWNjZXB0IHBheWluZyB0aGUgb3ZlcmhlYWQgb2YgdHdv
DQo+IGV4dHJhIGF0b21pYyBvcGVyYXRpb25zKS4NCg0KVGhpcyBmdW5jdGlvbiBjYW4gY2FsbCBp
cHV0KCkgdG9vLiBTaG91bGQgd2UgcmV3b3JrIGl0LCB0aGVuPyBBbHNvLCBhcyBhIHJlc3VsdCwN
CndlIHdpbGwgaGF2ZSB0d28gc2ltaWxhciBmdW5jdGlvbnMuIEFuZCBpdCBjb3VsZCBiZSBjb25m
dXNpbmcuDQoNClRoYW5rcywNClNsYXZhLg0KDQo=

