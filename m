Return-Path: <linux-fsdevel+bounces-34729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CC9C824F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9674283A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 05:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D11E883C;
	Thu, 14 Nov 2024 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m9i9Axb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B791632FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731561020; cv=fail; b=KBtScShXSjwyABAyGExKGNS5Fo+F2JMCYDu3B4p3DZa9q3xJXMl1iajE4Ykpr0CyGbeEqrxpc5qhKXqPBoxxcSKttOiDwIzE2oh1xmOrgHkz2EnJ8XqS2XJSVjzZayYIEIxoH5n5+Ex2LJaQmtg2wFlKchk2g5d1mzZ869mY8fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731561020; c=relaxed/simple;
	bh=WTLJY2ADsiypZQQRkQ5rgXV1Tl2Wmc3txRqFBUXA8BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EVFt+wU6F7PD1gYYtuaidVNCyGtnNfv1rgt8+mTMVEiEbkr8oxexmZ3crsslnHfIHlgR6wQT6v/0hFx6o3EIH2ZVY2ghGjdXJnr471Qu81cID+1v8GyrxFHhJroLodbxm/jnPGDHxX9rveMReWjnQf87mTG+AZk0+RG9NIwPkCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m9i9Axb+; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE2tZnD004578;
	Thu, 14 Nov 2024 05:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=sEpwBJJ
	j4T8WaVerK3C7mLKY55npxkx6jHc7e553HeM=; b=m9i9Axb+DPCKCYWhs/gWdif
	SMnUWhEmvu+qblvwEhoxHF/hdRLoCY8xFAOstP7/Hr5bmNydyk4RNPi5V/EZF9aN
	desMO2BlMCyXUkVGJnFQKU8T7i073DO5B85FmEtdIqs+/LWUJ0/siMjIOIfwsXmv
	+px8OrlWeaITsB0sewpAn8ZRHQp1AtLSXYvwciybyURvV9+UXcUABkh+ThmomhgG
	/jFM/xQznXEaC5eNErzRthNc6QLbTd8gwcwCOt66soBXcrIEmOfu8DkMLYB9kC9x
	lf1itho3dfmAxwS21CeOIbGi3XwpKI288oMB3BQbwFFxMKm6IzA55bMJRzauHbA=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazlp17013077.outbound.protection.outlook.com [40.93.138.77])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42t0wg4kte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 05:09:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lohyBKyuakdmdmtMF2tGwKR/ZLTRimGFy4kAqbPitMAH5j+q3GQnIa8uXWTQHCBbT0cYbFQGvMVWm4kYqMTCowdo9sJ3p0/zdq6NgKM871IwqicECeAnOQ7sk7gmb1GWleudrieW9W0Q0Pp+iK51WXVDk4M7UcHQJxi2PrISSIP3u82yc1tOq9aYaG6tV54VlxdULXsEJ2JAZCoeQXu8M4VOWcUoJUCtQIyXIcghtsAzNTvdvpYXqO6Q/dfAacdmCFjdaRg2t0Yu89rLnBv2GpbSggpstYig96nD8ZHri5EEZwIzt4pNLCoEtLe/r7Q6cPNoqi+AvLnqCwNnioEy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEpwBJJj4T8WaVerK3C7mLKY55npxkx6jHc7e553HeM=;
 b=VjLgrnhxBRUlVCzsMMKejcIdS25ZSFaHzD2uxB5dllq8s2+lMiRWkl1bv0d5jRjiQ9oZ9ksEo2sJz/NemF0Tyq3qe7EktGWUpK7KcOMIum7Y1cvTYCwHvFFUAIQEk9qTFEzg4plCEc8Hvull2FjxEYYUNEntUJQfRWaOmBDPNSQ2nhkesvl3SvKc55BKx8F6Jbx4sK+r/ToUw0CQg/70qQGFuCRr7byRDaiXpGjplKT85Z13M6JyNJt3qtW+Hbb4quRG2wcMxoktHI6TCrXoYSkMWhac7A3DQZycn6b8CPHX6iF2vCWdLydSWuEJVqjq2OxIRmqfw0aRaMXDK4g/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB7605.apcprd04.prod.outlook.com (2603:1096:101:1f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 05:09:46 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:09:46 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH v1 2/6] exfat: add exfat_get_dentry_set_by_inode() helper
Thread-Topic: [PATCH v1 2/6] exfat: add exfat_get_dentry_set_by_inode() helper
Thread-Index: AdsFm7o6eNsq4XfySF6Y9o6kIKDa5gk9ZzagAr+YEIAALNpKNw==
Date: Thu, 14 Nov 2024 05:09:45 +0000
Message-ID:
 <PUZPR04MB63161C0548E1EB16AC038DDB815B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB631668A9BA5D0478A0CAA28081542@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9y=bsuvKMO_bya0gO2Tc_4Ac58SRE=E4v3fB5z1-onrg@mail.gmail.com>
In-Reply-To:
 <CAKYAXd9y=bsuvKMO_bya0gO2Tc_4Ac58SRE=E4v3fB5z1-onrg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB7605:EE_
x-ms-office365-filtering-correlation-id: d4a3eb32-9152-4dc6-6ef8-08dd046a8e79
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+k3OJTPha8D7RTmlwx77oJLQdnZad236JPH9Y+TYv+hEgyLBS/GY9KLzQf?=
 =?iso-8859-1?Q?U6UWvfMuAiWTBdgpqFH36pLXSu2Ud2ZFNxHaIslbpcQovJmkItrYuIQb4z?=
 =?iso-8859-1?Q?mQhdkuVEtut7ifMeFvrJOwASxlsrq+xPY1bOz9F4irSkPD3J+2sjM9cWES?=
 =?iso-8859-1?Q?SidI2ochXLa46SPYGKYQO3OMK1mNkpNxCXyfkG21jWS26E6qf1eZ4PkUYS?=
 =?iso-8859-1?Q?txb6cL8zhw74x9z9+EnB6tLZ/7pXHQbCu026RJwtUGOSJsAuBL4gsjhEaK?=
 =?iso-8859-1?Q?Qm1on7gKiaUhTKDQtuWtG8ON83Xtik4CjB2x0m4a1RKNuIeRNTpey6ZLP2?=
 =?iso-8859-1?Q?/hiHqW0Pvb1ym95VNnNWjmFsoQADiYPcGSoggDEVLTLnz1urBtkpUHsPGy?=
 =?iso-8859-1?Q?13OPc8/9AHz427fdbwRJQ2cdzLezv8eQY8/Pm6jwauiYnp1Q1wO75PtrGA?=
 =?iso-8859-1?Q?cLwIWMk9Reb45qUBsht3pu14wHPCoUV7gsachh506ZHPyhOJaFErjPlAxZ?=
 =?iso-8859-1?Q?yA8ydEsH8LcSzD5n7qkVQSlBEJYLID+snHX+FRgqLnFtsyQNaPofEdh2Q0?=
 =?iso-8859-1?Q?+9hIaWiFb78okc2u6SH5F9letB26fob+u8F7nFd5SiHtDdKWsmVbhYujfK?=
 =?iso-8859-1?Q?9pVd+3sVW2mFp6eLObyzqeMPcihNdBsKgtve4/HKC67BnvBzD7mT2UZbBo?=
 =?iso-8859-1?Q?F7dB+4Bcbq3upxHBGNCtpg3aqVZWO3S0EPp6HVqHii442aZNxjYC9cm1AC?=
 =?iso-8859-1?Q?grqxM3XrYUpcJOezRMYRJWjnRL8gY0NEqwJcVK9L+HBdijRzmBmJPdpUTF?=
 =?iso-8859-1?Q?7mBL/WeQYuljL7IsSxVgMVISBwr1mDshFS9mD/S5uJ0qoC+F8ysB7fsSoc?=
 =?iso-8859-1?Q?rFhHyzs7aL4SnofAFagQfQObUPm0ILu2Hz3vxCm5jxw6SUH7QausGcVPYr?=
 =?iso-8859-1?Q?4rlsyEVHnk7kaqAp/5YRFBLG/Q00uMg4BIzFrm3RILn0Lr5dLFKLTbmK6A?=
 =?iso-8859-1?Q?B7wqTepi38nT83w2sykH+dxjrNgu83GLLR6zqYal+5lVMH5fR7wMb2IlT9?=
 =?iso-8859-1?Q?HIHzQaRQ4kOt5J8n4WngQr45XF8LlA8ffQ/LNQ36EnFgstRjIBEzvMLA83?=
 =?iso-8859-1?Q?6vo00Grj/uti/wk35jsnvvWbyOt9j6CNtvtmevoPojiW5sI6xgSEeEyX/O?=
 =?iso-8859-1?Q?hOIk5u2PWKhPA7CKr00gxut7JhL3NPKNDeEWT3+5jerej6EkeJtYg5z5uw?=
 =?iso-8859-1?Q?axIzJpVPeKbFBjYgn+FTAeAJEeEO33cjIoMBqt2GefEFeU2SphtPXt8cg2?=
 =?iso-8859-1?Q?TYQhJZ4u4iaNFD9lf6L/N42DBCPvhrjIpCnPSBMaYm5rwEiK3x71vV1p+7?=
 =?iso-8859-1?Q?8XSdRjEMqqCJ12w54YBHboRAJGKM1MWYsA1ENFDFkETIhswN1SG68=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tks/JGMKa6t4/mn/Gy3Wpwr0Froicqslm0KD14o4FYGux3ig5oGO+7Z4rF?=
 =?iso-8859-1?Q?9RI/57DJGgB4wQkBNUCzqL3MzXInonhTV3wfuS5PcrvXl/Kgnwov+xwvX9?=
 =?iso-8859-1?Q?QtGd5/vdi7+n/pj1fjXxrphKdx8Y7fmRe+KVVN2sc5pT2uAdvNa7r/KORK?=
 =?iso-8859-1?Q?jIutiMWteol52sETm5Ix0qN8Pn838cF5Susnr2loJF+Cgh/8CTSpREOgHW?=
 =?iso-8859-1?Q?UAAjU2tD+BWmDs42vWLGdECgdZBytPW7RgYZaNZJ4fgz2XLqjvK1vhenLc?=
 =?iso-8859-1?Q?rYCuTik6mu403S9adbArNHJv+mWf0yeiek310f3+e/Pl2EbL/zSw5e6JPD?=
 =?iso-8859-1?Q?DG8cJfxS2XpaaGocvZg3R3nC+r0E0FXAbdQQ+IoljCo0d5m3zG0Z7WNNkw?=
 =?iso-8859-1?Q?abdIZalnTELqqduWQGel298yVcFKrc9Cha8IT88NceSgRAgnt2boM18ec+?=
 =?iso-8859-1?Q?TeeRDJSXCyv8w7ti6O05VB+TP0h4xzYVw8NpIGee/wMSeG2ZHw7jDFNQRi?=
 =?iso-8859-1?Q?2/UuqwALC5CnuQ4dkU4St9mTyhB0IdkJGp5aiO1OU9Fr97pgIL5YA+W2b9?=
 =?iso-8859-1?Q?P7Lon4Kgm899kq1Yk6G2HASiCIqjlxp1zffZdZOTSdVDtmi9cxYShviao7?=
 =?iso-8859-1?Q?lsNwP1biAFvqZKRrs/CqBvlvrxw4ZtIxQ5BVjasGVB9qctNrMUw+5C+Mwl?=
 =?iso-8859-1?Q?y+FPFDoC1D+vkUgudFohBb3kdQ9S3cUMK6G1KyeDvAYRH2XrNZOK3VQLWV?=
 =?iso-8859-1?Q?vxiYu53czopJNErFRZjnkk7CUSZTKYgACJKfKwO4LD5TMy23P3um71tqFY?=
 =?iso-8859-1?Q?yIgjNk5AnJp+FPH0eLcYrDMPT0RhWo9SuAq/g4xwvQ/kPK7LoFF0QPEtI+?=
 =?iso-8859-1?Q?CYLi3ilFBS784Qvfea3p4YazPwMRcBBt0vTFV/OspHIShOtWEVF/J0mbg7?=
 =?iso-8859-1?Q?f/w7COBoLBx8Os1jpklZUCp0D5OE0oPQI+xVJ8TeYXgTtQKpt1B1O+m5aH?=
 =?iso-8859-1?Q?SdWVPEsfN2MtvS3dQwfKUSjQoaoRLfmaI8gQyEcYcJrL5xV46zzYU+wK4I?=
 =?iso-8859-1?Q?YPgCD2tKh/k6QD+8T2mOaPnoAwvw19Wuvl91LxPq+Q1aX+TS+gvjLnKH4j?=
 =?iso-8859-1?Q?DvSTRhPpzSHA09XUmideLx8AI79blCwapLzntaXPyi15l3gBS95i9Fbxus?=
 =?iso-8859-1?Q?3Ck6YOt8F+OnDuwVc08RH+tL3hi0I952s2NzQZed6wx+9uKYd5XhRV5PA8?=
 =?iso-8859-1?Q?v6DSzrxHpUYlG/FWYR+7vM6Q4gTg72ov9Qz6U3CBAy5TlQsBEoVDKJpclE?=
 =?iso-8859-1?Q?PizFAeG9yj1eiGFAXIdkoyfc8lYlcv+XIHp6nsboka7FQK5zOoRtGsy4b2?=
 =?iso-8859-1?Q?W8Bs/bQDol0pGfjJsNGM8t9DejHTY3EeeJPhUp9a0OMo/ui4+5mQoi3ccR?=
 =?iso-8859-1?Q?oaIhLndM2eAvAUHg2rEo5g+S9+OpB6EXVn6vGl49pSRjs0/6iV6AYjAzyx?=
 =?iso-8859-1?Q?1gvhLJQZY1Hh0HhXb050zvcnNBSjI4PKAp8/Z1qJAM+sHFf9GKew5t5/lv?=
 =?iso-8859-1?Q?BikSmHCsonseHdNzMHz3FWRsHOTk7nI0FoexEAK2J1NFvI8HF91nck/6oO?=
 =?iso-8859-1?Q?WDGmHT9To/2k8hQs9L3TlQXZAsRGFvvT/TIx1siifzjanroyVnfifFXiqF?=
 =?iso-8859-1?Q?0FUsn7WDj4BALoCjcHs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hIhJeV1UX3TLBA02aUa7ITPS5TGgML8y1/a4ILMCMj3uFhzP+Exx6vXUpEQ28luadpTNtZmNl7QPnHEpZkDkrbQEEHT0hqJXAdeS9ESeBWutqJgB9Skh+nEK1ev6g4MbzwXiuZhhcbJJe2OSfwbA3mWEkRefQRfhy0Z6k0DsGhKu35Fs0sTMyHgMTMnJv3fVQWK2woNgTPeXHtNxq+C+JV1LCgm4HrlIIyO8DOCCYDsxdNzI0y8p4UtIBI9VkxbPmsFczgkQxoK1zrdLTZCCdCv3ARrwJMzOhTkazG84Q8OkEorANp3QYUo7ScDPwZZxLHVSgLakVu4xhfS7asJHS4MjY5kmxR/PWGHVmSSfzAX+sY/G0kK+cu/oObC9ZYvob7VMh3sn7OKV5bUUw3j6ma2VP9GsZHgsG8p0dbhnfve2IvWzeZwd8M4gHj4z5kgTtvQfvAdNNkMZ9+jhd8W+xiTI4nRSVCF2EdYatFJG87qWzzGGVnD4xdPMlvl3G9WPHZehQ294DVbmuMYoPN0ojnhFkIcLSH35oH7ph8Qw5USgQZhQBkt4YGMwfqfPhuBHQmbgO6+I9L0fIrWO+Fg8zQf/fTo8KLUQG8MjF8UTyYCtMkkkJJcBwPUVybuQd2yl
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a3eb32-9152-4dc6-6ef8-08dd046a8e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 05:09:45.9398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCcPzzHQwXKtN+bLOgUWMAlcbQbNZ8hclHG+y0V5ZGmhwWFGLHbaEqW9aDOHqZnMGUZAi7Wohd8VzoT2N/qplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7605
X-Proofpoint-ORIG-GUID: 7nf09IiH1-wJyWJzEu-FT82qv5v0BU-j
X-Proofpoint-GUID: 7nf09IiH1-wJyWJzEu-FT82qv5v0BU-j
X-Sony-Outbound-GUID: 7nf09IiH1-wJyWJzEu-FT82qv5v0BU-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_01,2024-11-13_01,2024-09-30_01

>> @@ -999,7 +992,7 @@ static int exfat_rename_file(struct inode *inode, st=
ruct exfat_chain *p_dir,=0A=
>>         if (num_new_entries < 0)=0A=
>>                 return num_new_entries;=0A=
>>=0A=
>> -       ret =3D exfat_get_dentry_set(&old_es, sb, p_dir, oldentry, ES_AL=
L_ENTRIES);=0A=
>> +       ret =3D exfat_get_dentry_set_by_inode(&old_es, &ei->vfs_inode);=
=0A=
> It is better to just use exfat_get_dentry_set rather than=0A=
> exfat_get_dentry_set_by_inode here.=0A=
>=0A=
>>         if (ret) {=0A=
>>                 ret =3D -EIO;=0A=
>>                 return ret;=0A=
>> @@ -1053,21 +1046,18 @@ static int exfat_rename_file(struct inode *inode=
, struct exfat_chain *p_dir,=0A=
>>         return ret;=0A=
>>  }=0A=
>>=0A=
>> -static int exfat_move_file(struct inode *inode, struct exfat_chain *p_o=
lddir,=0A=
>> -               int oldentry, struct exfat_chain *p_newdir,=0A=
>> +static int exfat_move_file(struct inode *inode, struct exfat_chain *p_n=
ewdir,=0A=
>>                 struct exfat_uni_name *p_uniname, struct exfat_inode_inf=
o *ei)=0A=
>>  {=0A=
>>         int ret, newentry, num_new_entries;=0A=
>>         struct exfat_dentry *epmov, *epnew;=0A=
>> -       struct super_block *sb =3D inode->i_sb;=0A=
>>         struct exfat_entry_set_cache mov_es, new_es;=0A=
>>=0A=
>>         num_new_entries =3D exfat_calc_num_entries(p_uniname);=0A=
>>         if (num_new_entries < 0)=0A=
>>                 return num_new_entries;=0A=
>>=0A=
>> -       ret =3D exfat_get_dentry_set(&mov_es, sb, p_olddir, oldentry,=0A=
>> -                       ES_ALL_ENTRIES);=0A=
>> +       ret =3D exfat_get_dentry_set_by_inode(&mov_es, &ei->vfs_inode);=
=0A=
> It's the same here. It is better to just use If using exfat_get_dentry_se=
t() like this().=0A=
> Thanks.=0A=
=0A=
Thanks for your comment.=0A=
These two changes are necessary, do you mean to move these 2 changes to pat=
ch [6/6]?=0A=
=0A=
Before applying patch [6/6], if using exfat_get_dentry_set() like this, it =
can correctly=0A=
get dentry set.=0A=
=0A=
struct exfat_inode_info *parent_ei =3D EXFAT_I(parent_dir);=0A=
struct exfat_inode_info *child_ei =3D  EXFAT_I(child_inode);=0A=
exfat_chain_set(&cdir, parent_ei->start_clu, EXFAT_B_TO_CLU(i_size_read(par=
ent_dir), sbi), parent_ei->flags);=0A=
exfat_get_dentry_set(&es, sb, &cdir, child_ei->entry, ES_ALL_ENTRIES);=0A=
=0A=
After applying patch [6/6], child_ei->entry may not start from EXFAT_I(pare=
nt_dir)->start_clu,=0A=
but from child_ei->dir.dir. If using exfat_get_dentry_set() like this, it m=
ay not correctly get=0A=
dentry set.=

