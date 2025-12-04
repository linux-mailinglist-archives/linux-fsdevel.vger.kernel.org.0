Return-Path: <linux-fsdevel+bounces-70701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40244CA50DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1475F30B2454
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9D348895;
	Thu,  4 Dec 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWdcUOAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AD347BDD;
	Thu,  4 Dec 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874397; cv=fail; b=kZa3uDGWfodwc6Df4GoRU+maaXP1ua7wFh2tkOQKmb0xLnU0iLyTxKl9dOF5asLIAR9izkhllMJt8n5AFGGmXVOkSD1CoYnSGvozuQvtr9s+XLe8X+E9LzoDxcUR2hRx6kixiNh4Cl8UPb3gISvL+2TpUCAqfd+Zd1hK8hbmoS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874397; c=relaxed/simple;
	bh=hHciEGQhTFAu6ZdXLlfGP8W2INKS/hau3+cta2sRTgo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IEPF1NoOjZKXPqOaWtR9Av23jau+L0NzpgHvU7VQk5ZUDc07CL1XCfZfi7cFa0D3D/6Rcd6KPQare/FYek8Re3jZ1dfxUC7tG1qkMXaUbWfAxezaabe6zh86SyY/JAvkNrz5JDxELKZsxBkg2aASsmTKFmIhc9KvEFwtLGT5Ttg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWdcUOAl; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4C54nq010934;
	Thu, 4 Dec 2025 18:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hHciEGQhTFAu6ZdXLlfGP8W2INKS/hau3+cta2sRTgo=; b=fWdcUOAl
	8FPLbbH5UgcuZs5pZhLj4anHm9jh3ZvHaKbL1AunZGKpn1fahzsm56AiaV6oSDfx
	1AK/12lWb6YHZHPshZAFcSdDJ5xNbW1MK6nBJ7wA7G+K5CBPhQgx135UPqrNkRgV
	YyHmJO5taCVchOpvuA7hYVBzNXSJutETC/VCR04QlDOXWn9kIeKu6g/7rF8MCNG+
	DGV0gtnOssk/Lv4ptaRF9V78Q7XxBKsMRh1eJWuu6H8fPWuFJ4U4bm8FtF5O1oMZ
	0QVF/0/KVVRmmSB7jnqjWEOteoy1pnB8qtAOJdiqEe4Ups5aUDc7tZFbgit2JGBF
	LwYWbb6FiGE1Fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja21xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 18:53:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B4IlNci016998;
	Thu, 4 Dec 2025 18:53:12 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrja21xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 18:53:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOhsTmOXc9x5p/2yMhZeYKGE+s/9YHwRr2/oyRLX/7RrHoro1Kw8n1X/k2TpL/hllXQcPBVd4rPbAEH4WZ8A1WbDU3xGuBhuNOYngiQUdFaT3nggUD9jATd7M+gWi7jBOS0NEVaqFygE7gs7TXdqi9yjzN4ZlFJp4CWHqYotmc72GoN1qXMcm5Fkj+eUCnSd9nmDpk98Et4E4/nGdFYRirTz7Y9nE3XhMpP+nm4LQPyehXR5VoaMvESWQvdc9fnMnk99JNLn2Hn1qkTgLm35oH9x7fbPqnM2COZ37KaPoiDe9+9jeMx+fV19pWKgAx149daYyLU+nJjMjQoP/OSn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHciEGQhTFAu6ZdXLlfGP8W2INKS/hau3+cta2sRTgo=;
 b=cfJ3c6vRNG5zbmvE3Gh68NMfQ5/6Exso3H7urcmn8Nvl191mMC0Tpf0AkF//U97u8IiodzKLMHvcWXmlM2B0g5pg36HaUi+nO6OTMyXF/ZGpkxcKH/89cD+OODTnyIopp+HDf5Ehi6Xr8wO2ZnDF6YW3xcO5JV9+NNeld8+Fgtp0EcwbmDMzHHKNP9g6gAotGdDs9QzVZ6wWxdEbW4UL3FjblJRPF9aRIjOYzL45gQB9wLAOGMfgtU5gFDs0drqPo0GoNDIVONhzMs8QXxsmET64hqt33/rNYGqlzBoALX2yuc2MgdshUM+C9+wBxKJf5149deYr8OtPDT9Sll6zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5421.namprd15.prod.outlook.com (2603:10b6:8:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 18:53:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 18:53:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/4] ceph: adding
 CEPH_SUBVOLUME_ID_NONE
Thread-Index: AQHcZJsMNCX0POS6GUieDyf6NSM/g7UQhnIAgACdagCAALFkgA==
Date: Thu, 4 Dec 2025 18:53:10 +0000
Message-ID: <a343801b052287308fc9ba2fa5b525c90969536e.camel@ibm.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
	 <20251203154625.2779153-5-amarkuze@redhat.com>
	 <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com>
	 <CAO8a2SjQDC2qaVV6_jsQbzOtUUdxStx2jEMYkG3VVkSCPbiH_Q@mail.gmail.com>
	 <7720f7ee8f8e8289c8e5346c2b129de2592e2d64.camel@ibm.com>
	 <CAO8a2SjN0BQqHJme-8WwMP2PKeR_QvKHYrNr96H4ymLTDC8EZw@mail.gmail.com>
In-Reply-To:
 <CAO8a2SjN0BQqHJme-8WwMP2PKeR_QvKHYrNr96H4ymLTDC8EZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5421:EE_
x-ms-office365-filtering-correlation-id: cebe77af-cca3-4b57-d1c6-08de33665eaa
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2plYmoweUFvVzRRQWRvRkVmN1hEY0dITVZtWnlyUzE2MzBTSFhYTHk5UURi?=
 =?utf-8?B?b2JubWRKSm5zclB2bkhRWnB0M0kraXcvcTdKVFpEczJJbStET2srOTkvOWty?=
 =?utf-8?B?a0paSzRVNGVTbDVRODlCMVFSSjNYVjl4dFRSUFBiNUUwaGRPSDZnUUJtWjh0?=
 =?utf-8?B?bGY2SWhjU1MxSFpPTzhqQzJhQmNOYi9yeXFCTCtNRnpkK3ZBYkNJUHU1K1do?=
 =?utf-8?B?ekhLRFNIdFVQMEx1STJqMGhuS1BnbHFDdGo0MUh6dWNuUUNaWUE4NFZWYWFy?=
 =?utf-8?B?WHQrS2duODlpQW1BYVNkRUQ2SkQ4WEpTdWNwWmQ3YjQyTVRxRG1ZWXVFK0hv?=
 =?utf-8?B?UGxCNGV2cDZ4NDVYTTJoRklUVVlUNVpqY2NqaUdZamZteVVUN1VpakJZTDZS?=
 =?utf-8?B?QUJPV0Q3UGlDVWxhRDJocllGaTNjdHhCYW5ZNWN5MUpCTFBPTjluNEU2NEk2?=
 =?utf-8?B?a2t2RUJDYVFWQkxHdmtTcExkak1CcUdSMC9TWWhWcmt1RGJwYlR1bGNmN3l5?=
 =?utf-8?B?anltN05UQnIzUzM1YUtvYXV4dzFCOFQ3TkZMd0wxaXpwL3hraSt1eDFBbm5U?=
 =?utf-8?B?eWhLOE5PUWJIR0F4U1prRldYaWtmUWdRVXd1dFd6M2hnYnlRVllEbkVrOURR?=
 =?utf-8?B?VlJlR2ZvYXI1eVoySERVNDhrNkF2Nnd4dzdLeDdWby9RV0g5bTJYd1BIMFFm?=
 =?utf-8?B?aDlFMDBTVWo0dTl5REJRZGFrbmo5WDZXZE1DYTJBV2d6WUJXSzhIckduMERm?=
 =?utf-8?B?MUpvZW1FYm9XVkF1b281M0x1cWU4Z0FCRFJaeEJVZ2M0YXlTbEpOamRvNnpO?=
 =?utf-8?B?SmdTMHlKckZrcFlvT2F6NE11NFR6OUhUMENybjFUMmRqeDI1SERpa2RKQWpJ?=
 =?utf-8?B?bnJKWDJZNjluekhHT1JaZjU2bGtWbkpMUW1zVjVlMGdTbXpBb01Yc3lha0FE?=
 =?utf-8?B?enlNQUpvN0o1Z1hvZnhlaFdCZ0p3cVROVjlITHgzdUVHRW04ZkZnRHhKZW82?=
 =?utf-8?B?SGlMS0lPZ1p2QWtnUVJickYrQ3BYUjZFMmNPalU3Zkk1QUNxUnJjNFJ5M2Nv?=
 =?utf-8?B?K3g5KzhQYXJjWFVVSzg2TGxlcWZZYkpWSWw0K3pTbk9vUzdDRkFka09xcVZU?=
 =?utf-8?B?aVRWSGtaeG0yOU5yQ0xWb3ZXdXhOL29TRlhHMUhVcno2OC9kUENGMGVRTlFY?=
 =?utf-8?B?clEzSmtCcnVZeXpTVk94VEVla2RtSEJjRVY1bDZBd3pCOHpHWCtDWU9MQ0d5?=
 =?utf-8?B?Nno4bzNwWUtscmhpWlFXcU9Jb1doNW1aQWJRQXZtRzRIdUhObmFUZFVJdXRh?=
 =?utf-8?B?MWVzdWtHMjYzV0cvNHZMbWN3dkE4RTc2UUdFSjZDSGxxc0RsOGk0NVQyWmhU?=
 =?utf-8?B?N1l3cG1hQ08wY3d1R2pGRCtEOHNHRm1QV0ljakN3NGJGeWtTd2lDQ0psd3Z4?=
 =?utf-8?B?VDZ4cVJCWThUeVM3VmNPeG1kYlhlK0hYZ2l2SCsrdjhPSWZmUXBkUmVBaHhU?=
 =?utf-8?B?WElVQzhTV2lZSjVtQ3QvSHNta2FBZmk4cFI4TGRhUXVRK2ppZGs4b2c1S1VL?=
 =?utf-8?B?OW96N0dxZ3RhR1gzeVZYbTNKeGtZY29rTE1vWUFIMGZQMk1aRVdUcHlabVZL?=
 =?utf-8?B?VG5xVnVheXRBM0EzM214RFp3YXI1dDI2QVV6Sm1xRVNUakNtNEdKcjMxd1NF?=
 =?utf-8?B?Nk1Bc0pNTUdkR0ZmSWtQTTlsZFNWWitrN1lsRGFSSFluS1dTalpTeU1iUTV0?=
 =?utf-8?B?TXZCWFlqUVJrRExWdSswckJFQTMxK2pDYlhYT0FFajZwYjhOelAxSDIySGUy?=
 =?utf-8?B?Rm05V0lFUWNtT0Q4c2dpVWlIWjgvSGRYdFhqeDVKYXVoekMyTjgxY3AvQ3pN?=
 =?utf-8?B?eDlOZ0FlL0JhRVVUNWpNZjFCemJSSTArSWEyQVU0L2orNEJGdi9uY3ZMa00x?=
 =?utf-8?B?UnYxUzZJSFdVQlZIcjNVbzlaM28yRjk5ZktHUjJOUWtUMkNKQWE5S1VPQjlO?=
 =?utf-8?B?M09hVEo4N09PbTJHaW9wS1FBMzFzWndsTFgxdERqK2xMY2VoWGVjek9rdUp1?=
 =?utf-8?Q?lGoXc8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czRyTEdqRXNQUDJjMnB1eUxZRmRlelhwU1Q4STBpeW4zYUx5VTdwc1BLUTFy?=
 =?utf-8?B?M2FUc0hheTlsaGd0N0FJOGg2bFYwUWszNk8zc0ZiUFRaMGFpZXVYWWc5Wk1S?=
 =?utf-8?B?TEJIZEN3dndmRFROSmNzQ3U0blZtZkwwREJCSmdDc0VOZ1VyQXEyZlBjMkNO?=
 =?utf-8?B?Q2JWaSs5V0VER2VlUkZaRkxVVjQvSTRCcWlHT01qWEVPbTl5YWxWUkVNeUk1?=
 =?utf-8?B?c0t0a1lhNThnT3hCWWJhaUE0M0RpMkcxUFNQTnpLc2JBV2l4RDFJcWJkVUxQ?=
 =?utf-8?B?bjNxbUdQaWNSdzN3NzlOeWxNdXlYWHBvV01tM0tYVU1vVE9nYmZaOG84RC9s?=
 =?utf-8?B?ekZYTjFxRjNIUjRiSTJSdGhyKzZHQzB6M2h2SVNGYm1EY0QweU10blJUU2JI?=
 =?utf-8?B?eG5USEVnam5nOCtMTE9tVU1LYmh3dUgwQ2lDUGNudTl3blcxNTh3cWtqckRl?=
 =?utf-8?B?d0ppUmFwTk8zVGpIT3ZaaWl1b3JGSHBzVWRXc2JDZmREdHhvZzFSd2FlSEFH?=
 =?utf-8?B?ZnkzcnB2dDkwNG9WV050aTQ4TGxzTndRdDgzYjRRODVzN3ZJdHRoaW9leENy?=
 =?utf-8?B?QzZMTlhra2MvN2ZrUEs4cm12Z2ZhWHUrVjJIUUlkdlNESjlUYWh5cU14eEZy?=
 =?utf-8?B?SEQ1YU10S1Y4dTVSblM4QThqOGZNbDk1emFSVk53bHdjZTJ2M0NNZUxqNis5?=
 =?utf-8?B?WjZORU5hRWdSS2NCcnVuZDBPcjA0WDQ2dDhUcVUxMFdrUWc2SFBLdWh4RW1B?=
 =?utf-8?B?V3M5ZmpFYmx6N1RQRG5KR2FiZWxURUJ5T0paZkh3UlBwWnJ3ZVlJaXk2NFAz?=
 =?utf-8?B?aDBqMng4aUVhY3ZYSnlRdFRiNDdCQUFQOEY2SEpLTHFnTDAyTzBiZ1lnOUF2?=
 =?utf-8?B?dU1Sbmw2aEIyc3l6YXNJVjZ4OTdUQU5mYU9JSGtuenVVVnRjbFBXZlg4cWM2?=
 =?utf-8?B?elRZL01YcTZMWXo2dHd0NzFMQjkzQk9OUTNBc2lJYlhmWTk2THVGUVdPR0ZT?=
 =?utf-8?B?R0kwM2NmZDVSeGVtOVZWY3BLd3JVUTU2eDFCQzFEZzdMV1RDVUNxWWRJSDVx?=
 =?utf-8?B?NzJ3TS8xY3ZJUS9ieUxySVpGMG4wcXVMYXBMT2tCL1ZkSHF1YUg2dFZlK0JT?=
 =?utf-8?B?dDFNcytoSytLM3BhRURKNHJkYSsrZHNKQWNwU2FGNHVDazl5bEJuNnJtOE9S?=
 =?utf-8?B?YVU2Vnh3d3V0TWVVbEtTY0h0eDIrTmtrdnd4UGNudXZyNkxxWjZQdnhlV3Nn?=
 =?utf-8?B?YXpaekFLeG9vZmFkdFA4Nyt6RXBCTHBJeGozVjVuMzFNV2lnTVBLeUNRM093?=
 =?utf-8?B?amtzbkNtVWZTZjJVVnlteFdBRHZYRnhRcDM3K1h6MkdQU1duQ1pMa3JxZ2Zi?=
 =?utf-8?B?UjRzelUrNzlJZXBNZitLdFM3aFl2NXJUUG90dFlVcmdsaGQwcHcxVnMxem5u?=
 =?utf-8?B?TmNxc0RZNk02WHpDYlJkL1RmcHIvZ0hMeDl0YlFoQzVub0J1a1ErZExIV1hD?=
 =?utf-8?B?YjdaWCsvWHVCZ2EwVHBGUENLeFRLc2NiMHloL1REd1B5Z0o4a2x2WWo1M2JU?=
 =?utf-8?B?Z2w5MkhtU1N3czN2OG5JbW5iblpXV1VoTmphbEtNelk5eE8rTGVNTy9yajhs?=
 =?utf-8?B?UUpsTUJiOU9qY3VlakpYUDFOeHB4TC95dTZ4TG1jclFFcWszT1hJRnhOOS82?=
 =?utf-8?B?eXgxTWwwTUVFd3RFbTYyQkN3WDAzenNCVzIyUzBuZEQ1cGRYWEgrRlNZMTNl?=
 =?utf-8?B?M1RGY3Z3WnR1cGYzV0Y2dXZnWXVXcUZxa1QzeGY4N0JEbHJQQmNIVDQ4T1k4?=
 =?utf-8?B?ZWJ2dXNMdEdjN0ZpcTdxOHE4MzhmM2JsZGxvbkd6cFRCeUkzYzN1TTFRaUNv?=
 =?utf-8?B?WlBkMDhTRFJkTSs1TVdyZGNwMFVhdXU1WTEyZW9DcE85b01MOUlhbHQ3Qllt?=
 =?utf-8?B?dFpPN2FsVVdYNzBWOTgxN3FRczcxdFJjNS9YQzM1RFNQYlZ5RlN4K2FOZ3ZC?=
 =?utf-8?B?dXRGSSttVE9tYm1Xd3pUeTJCUkh0TFlIYlAyczZWTkVZNmM3R2szckM2V29H?=
 =?utf-8?B?VDRDS01GczZRb1VEREdjZjhwanJQZWxlVzdjczdsTC9mWGN1ckJGZ0FhWEFB?=
 =?utf-8?B?U2J4WEtMVzU3amtrSTZoeFFmT2dYT2doNjYyQnFRaXEra2ZuU1lULzVUb3JL?=
 =?utf-8?Q?z3ZPj3/5teNUzMtVgmdaRNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1DB74B9C505843B610D2C766A1285A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe77af-cca3-4b57-d1c6-08de33665eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 18:53:10.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lw+KkI59WRCVsUJb3in+nOVn8Xb4NnIdpJtAi9pgViY4pGIuVN7am5VxSgriA6WyjJc7yFKi+oO6E16Xhc4g6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5421
X-Proofpoint-GUID: zmtfCjx80nSNLY3wbDAvpPmJ0anwslSS
X-Proofpoint-ORIG-GUID: Qhypgw1IRoy4lm8MqrP3KKtsjnUYKlgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXxRr2iW/8RuG5
 wl5KKyUt5+Jbpd+VblysdU4IKFrp0lJW7tOzRLX+uJXH25yAyGW9CTvWqJlgEYmORChz+7FffKC
 B+LqgIff5N1IggZPrpwZz00WIs8G1W5OKomljBO30Nqs0dBsaRq0w6vj8VUaSOPN3K9mKEfMk9A
 H7GerJIw7W45aojfLy5h+Y8goA4BcoXVkjxZKhSIYvIYnox383OfHEZgHt3+y66EJnV+yjo//9D
 SC/bcRJ4Ns58HEwxPASm3vzRq2eqJ1ExLfY1w9UaHEdyw03tNet1ia/d07e0R04ezYFaErvIxeM
 Z8rVziprquooo6jfUCvvdP9XneuRHpt08wFkMJShCLfO0fILph92jJH7/onKcfNBv//jC/xipwR
 gLCU5vMEO+XkS0myEOOrJmwALJP/Fw==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=6931d898 cx=c_pps
 a=OGRNNHJcR/XwrOfql3gobQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6cBntT0kh8TS_98DHSAA:9 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

T24gVGh1LCAyMDI1LTEyLTA0IGF0IDEwOjE4ICswMjAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+
IFRoZXJlIGlzIG5vIHNlcGFyYXRlIHRlc3QgbmVlZGVkLiBUaGUgY2xpZW50IG9ubHkgZGlmZmVy
cyBpbiB0aGF0IHRoZQ0KPiBtb3VudCBwYXRoIGlzIGZvciBhIHN1YnZvbHVtZS4NCj4gUmVnYXJk
bGVzcyBpdHMgb3V0c2lkZSB0aGUgc2NvcGUgb2YgdGhpcyBwYXRjaHNldA0KPiANCg0KSWYgd2Ug
aW1wbGVtZW50IGFueSBuZXcgZnVuY3Rpb25hbGl0eSwgdGhlbiB1bml0LXRlc3Qgb3Igc3BlY2lh
bCB0ZXN0IGluDQp4ZnN0ZXN0cyBtdXN0IGJlIGludHJvZHVjZWQgZm9yIGFueSBuZXcgZnVuY3Rp
b25hbGl0eS4gU28sIEkgdGhpbmsgaXQncyB2ZXJ5DQpyZWxldmFudCB0byB0aGUgcGF0Y2hzZXQu
DQoNCkFsc28sIEkgYmVsaWV2ZSB0aGF0IGZvdXJ0aCBwYXRjaCBzaG91bGQgYmUgbWVyZ2VkIGlu
dG8gc2Vjb25kIGFuZCB0aGlyZCBvbmVzLiBJDQpkb24ndCBzZWUgdGhlIHBvaW50IG9mIGludHJv
ZHVjaW5nIG5vdCBjb21wbGV0ZWx5IGNvcnJlY3QgY29kZSBhbmQgdGhlbiBmaXggaXQNCmJ5IHN1
YnNlcXVlbnQgcGF0Y2guIEl0IGxvb2tzIHJlYWxseSB3cm9uZyB0byBtZS4NCg0KVGhhbmtzLA0K
U2xhdmEuIA0KDQo+IE9uIFRodSwgRGVjIDQsIDIwMjUgYXQgMTI6NTXigK9BTSBWaWFjaGVzbGF2
IER1YmV5a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24g
V2VkLCAyMDI1LTEyLTAzIGF0IDIzOjIyICswMjAwLCBBbGV4IE1hcmt1emUgd3JvdGU6DQo+ID4g
PiBUaGUgbGF0ZXN0IGNlcGggY29kZSBzdXBwb3J0cyBzdWJ2b2x1bWUgbWV0cmljcy4NCj4gPiA+
IFRoZSB0ZXN0IGlzIHNpbXBsZToNCj4gPiA+IDEuIERlcGxveSBhIGNlcGggY2x1c3Rlcg0KPiA+
ID4gMi4gQ3JlYXRlIGFuZCBtb3VudCBhIHN1YnZvbHVtZQ0KPiA+ID4gMy4gcnVuIHNvbWUgSS9P
DQo+ID4gPiA0LiBJIHVzZWQgZGVidWdmcyB0byBzZWUgdGhhdCBzdWJ2b2x1bWUgbWV0cmljcyB3
ZXJlIGNvbGxlY3RlZCBvbiB0aGUNCj4gPiA+IGNsaWVudCBzaWRlIGFuZCBjaGVja2VkIGZvciBz
dWJ2b2x1bWUgbWV0cmljcyBiZWluZyByZXBvcnRlZCBvbiB0aGUNCj4gPiA+IG1kcy4NCj4gPiA+
IA0KPiA+ID4gTm90aGluZyBtb3JlIHRvIGl0Lg0KPiA+ID4gDQo+ID4gDQo+ID4gU28sIGlmIGl0
IGlzIHNpbXBsZSwgdGhlbiB3aGF0J3MgYWJvdXQgb2YgYWRkaW5nIGFub3RoZXIgQ2VwaCdzIHRl
c3QgaW50bw0KPiA+IHhmc3Rlc3RzIHN1aXRlPyBNYXliZSwgeW91IGNhbiBjb25zaWRlciB1bml0
LXRlc3QgdG9vLiBJJ3ZlIGFscmVhZHkgaW50cm9kdWNlZA0KPiA+IGluaXRpYWwgcGF0Y2ggd2l0
aCBLdW5pdC1iYXNlZCB1bml0LXRlc3QuIFdlIHNob3VsZCBoYXZlIHNvbWUgdGVzdC1jYXNlIHRo
YXQNCj4gPiBhbnlvbmUgY2FuIHJ1biBhbmQgdGVzdCB0aGlzIGNvZGUuDQo+ID4gDQo+ID4gVGhh
bmtzLA0KPiA+IFNsYXZhLg0KPiA+IA0K

