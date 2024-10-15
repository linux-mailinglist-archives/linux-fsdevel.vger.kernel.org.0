Return-Path: <linux-fsdevel+bounces-31936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B711099DD70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 07:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384091F24066
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAB175D54;
	Tue, 15 Oct 2024 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YsdqUaKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F8158D9C;
	Tue, 15 Oct 2024 05:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969717; cv=fail; b=aHDjgSST3kTnIwWcTu5vCYXNFnRfYZs0YVCCGBkA9pGkPm3FsjSNx7bH2S/j6FLDdznrNmRPSBtmgiIx570xgVHwpXVfhiQjmFWjPymrxdPFEcemttHBTWYTXjim1agoPJNm4rnG9jUcHerj8EFLBgpzgQbCob+NLLmeCRLzCFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969717; c=relaxed/simple;
	bh=3K6d7wW1+TcH+lOWP3C4r8AYi7QrXV0M1rYpwiX3ILU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRPMwBpJvyu+F/P9kDp2yMglCFv9gna0shAh5RcYynkb4Ts0j/zZvejbW/E/kMxIgXDAejcFIvVoQYbnvi3gzM84NkHS86s6RJeTPsB5KEIuDLxDcWlfsTooSkCEN3/f6i9iwQS84VbhvCsZZfbuV/ep8NnxNtZpQyqQzez+ouc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YsdqUaKj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F4rpYn029547;
	Mon, 14 Oct 2024 22:21:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=3K6d7wW1+TcH+lOWP3C4r8AYi7QrXV0M1rYpwiX3ILU=; b=
	YsdqUaKj3YAzz8uMD70dNB91PB6spdOwSZbP/lZtRIOu/zkN8Cne5CE16B8JxmRh
	7JXCGWBzhYAJFUGNIHJKh+iHkn10j0R9qHLTnfPSukVRWWeOEKnlNXmTRTCuDm2B
	FF13ivhprP7pLdQK/4yQF3BLjrzYu0yCCC8s2BVJ4dkHoZbt6touAxcn93qrld9E
	3eCqNIphgAyZbhBYlk/HqdNTBgwdSlBBdlaA4kCqn1UQz0HkmDAbgicJmF0AUysM
	sB97k7NVsRSbjYlQ0l+JTZLAF9fsMWOCygwz/c3qaT3rJsUnoXJFJ1myXPKVlmuJ
	muRQQ8Cb5+oLyiMlHIXiUA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291s3p930-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 22:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVDhFitDpyzpwmSgMlTFwltr5QzrulVdmSYyXChy07eViIJ3jaOiaTZBiqYzAu3lkrPdPrIaK7phzV39ygUZIPeFFejqHsTzMXHiGz40C/x/0IyorNGC2FfrwEvXaaSj05jSnnb+aoDjker1xMT/q51wyBJKO6VV2nQ+Nd4aFMLy1jS9VM49j/rtqtNi9nJY7tfbqjxqzuz0vNJcQb8rSjURYnkHoJ+7/Ch/pXTNXm6pg26obWIyeraTt8Bv3G5/F7iFOQ6ZkiRV6PGbzid2prQfLhjVgOBFq/PM+ojRavGKAr+9PYSncMkUKF9MSSZ3qmKoDWSHPdV63uLNW+k9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K6d7wW1+TcH+lOWP3C4r8AYi7QrXV0M1rYpwiX3ILU=;
 b=c6x3t85SmOd4rzs2D583cP6eK+A0QEImWw1cTcK95x+NDie1i7nZaPm0FSlTLI1Flf+s0refmyHwccoEH15cT1EedzPBZfq9KQ55QEZ5M+FH0TwmDzL5Xmm5/9p0wGrloxXaWV4q/EAMIKgEAS0yuDIuDnmVfwPNvHKhPZFeVL5xQcFRlxIa8Kusm9pkO31nZR/cDWj7sDGIIaxiaHpqTw4ByFvwSNSSogRavQ97DBpwth26w3HZY4EqNgJUUlXrWBP79mFm8u89KipIF0D7otS9hfDPW+69Ymm9HPIE8ltK/okvEJUtesvgpLcPeP8CUXz4NLEM8wDKqW/aYSYk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by LV3PR15MB6744.namprd15.prod.outlook.com (2603:10b6:408:274::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 05:21:50 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::90bf:29eb:b07e:94d9%6]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 05:21:48 +0000
From: Song Liu <songliubraving@meta.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index: AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFAA=
Date: Tue, 15 Oct 2024 05:21:48 +0000
Message-ID: <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org> <Zw34dAaqA5tR6mHN@infradead.org>
In-Reply-To: <Zw34dAaqA5tR6mHN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|LV3PR15MB6744:EE_
x-ms-office365-filtering-correlation-id: c44b6513-17c3-45c3-71cc-08dcecd944b5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzhEakYrQWhmQXUvQS84YTBPL0dpemFHUEl4My92cFBpTmJvVnhoVGpIYUlF?=
 =?utf-8?B?THNvUkVybGdyYU5ubWlEdzlIRHBZQkVlSHJnQWsyQWtIWXFiY01FVGVUaS81?=
 =?utf-8?B?UkhGUitzeU56ODhwdWxNMFFKaHo2RmNLdXRHT2FhVU5ncThybGdRREpoUzNE?=
 =?utf-8?B?RVhoTmcvQUVSbDhWS0FJUlh2aWVYd2NiTDFsbVZHVjVFT2o4M3hReFk0RGhK?=
 =?utf-8?B?TTkrTWZUQ1NJd2VpcDJ0alF4bmV5N0J5ZWttNWtSdjJxTHk5ZlQ2VzJHRDVL?=
 =?utf-8?B?Q21FSFBDNDV6MDRQQkY1UGc5TVNQZWxMK29vdjM5ek90SWt2OUpWQUk0dm00?=
 =?utf-8?B?OTBSTVdRZmZBcFVmUDBOdkREMlFrNXc4Q2owVWdJN1FrU1MrYWF6ZHZ6K0M2?=
 =?utf-8?B?OE9XYzdjZmxhb3ZXdnBRbEVLckl2MUhJRU1tQStNVXJkakkraGU5U0pSeHNy?=
 =?utf-8?B?bFBDZ1NtQXpSaVl1UGw0cDg5aEhGdzhmV3lqZmphQmpJMVZ0OHVwSXVYZkxD?=
 =?utf-8?B?QWlyNUFkVzhCenFVenZZY3ZPUXRSZTUrcVFlYnF5eWtrZW83R3h0aVh3UWJl?=
 =?utf-8?B?N0U5TFlwaHJvV0E5UEdTdy9CT2RXTG8vRmpWbmRUR1Vkc3dxcTRwMzdjdnk3?=
 =?utf-8?B?NDhYeWV0TnVyK3ZtbmFzZDdSOCs5MTc1U1FYRllvWWNlOFNnVFVUbzF6dm5U?=
 =?utf-8?B?SGFISDBNbmNVQThJbWZtY1oxdWNLc1RXUnNPK09xTyszQ1BESkE2MSttUHFs?=
 =?utf-8?B?dXBFY201MjVhdGFPcDk2REFxZitlNURoV3RNd1hyUUxhTVhzb1ZQR3hhUjhJ?=
 =?utf-8?B?a1NSRUd3N3M5Y1MweWhkMk9KenpiOXhBVTZvbVdtZmtLVk1QUm1aL1V3eXFu?=
 =?utf-8?B?bTMzOXJRczM0dEx6cmphR3Fva0pMVUhBV2Z3S3lUUzFrejZ1RE9aQkFDa1pM?=
 =?utf-8?B?cmszY0cveVhCZ1cxbzhrRkxYemdMR0pMV2duNXF2VU1wc3o3OE5aL2dBMFdL?=
 =?utf-8?B?UjEyYnFNSyt0T1RQRnAxYzFjdStLSVdEcDVQMDBnK3RMK1dXQUtkUTdDenBV?=
 =?utf-8?B?WlpBZ1JLeVpkYkczc0ZIbTJSMFVCY2JkNEVVdFlYbEE5ZEZiNi9NRjNoTENo?=
 =?utf-8?B?MWRqNERhQjVINVJHRzhIT2dqZnczMmJvSXozWlJJQUgvalI4UXlOWUlEc2tK?=
 =?utf-8?B?NzBGZHBHVWk0ZGRwZ01zNTRNYkFFK3FEYkNDQ0N1V0ptTG10K0thVHdlQlFw?=
 =?utf-8?B?d3lLbjlETHhReHhtVUN3d0tINWNEQkh5d2ZOanRQTmRjZlZrckgwQndSZXFC?=
 =?utf-8?B?WUxhTjI2dmptUHlkV1didU1Dd01yc2QrdzBkSnFwWnViZU1vNS9IaGp1SFRi?=
 =?utf-8?B?U2VDek1KNkpISzlEbVFZU3Jscm5wWUdJNUJsNE1uWHZWQ2hFdk5tL240dEZp?=
 =?utf-8?B?Qnp2Y0RXaDlEemNITDlxZ2pxTWFoNEUvYXcrcVE1ZmFXVThYT01iY1h3K2NM?=
 =?utf-8?B?VDlMWEdmMUVUcFhMYWJSekVkZHZCRldCbStkalhKdmNpMEtiYUNqVVhWWGtQ?=
 =?utf-8?B?eWhZanc3RXFBRnREc1BkK0F3aHdlbi9DNDNsQzNuWmEzZmFzNytLQjhUeEFL?=
 =?utf-8?B?bHh3OFM1Vyt3T1JybGc1VUEwaE5ZTHd5ejJCQkpqNDVvWXV5NWxra0h5czFk?=
 =?utf-8?B?bXpvUmNCbzlBcXN2QVp3Z3dublpyQTZHOUNFVFp0SitzdjJmNmV6U1pFWG5M?=
 =?utf-8?B?NGt1Vlo5WUlvaTFmOVJlZjBlSVpYaEx0c0tRSU1KNForRUY0RThZMVQrWkhw?=
 =?utf-8?B?Rm50NW1zQmFpOUhicWtZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFdDU21nYnRkMUtaZFB6Z0lpcW5QMm42VllKa2pPdW1mSHluWGszaXZkTTRO?=
 =?utf-8?B?QmVad01oN1ZDMUZGbXpLMWxaRVhWMlBYQy9zS20rUVpxWjNCZkQyTWRCeWFx?=
 =?utf-8?B?c1o5ZXZxYSt4c0l3aWZjN3gvNTUxNFlqM1JEQ3NHL2dsanAzZkJZNE40S3cx?=
 =?utf-8?B?ckJIWnM1bmZEK2xWVm0zV2o2RWJTcjY4Q0lrazNhNEtMSzlCcGRSWVdMVVdo?=
 =?utf-8?B?VHZGYmdoT1oySWdlMTlQbWtLS2pHK0ZVMTBEd1VqR1AvdVdkNjFCeHIraS9s?=
 =?utf-8?B?a1Fnd0RZRHExZnZtOVBiWTRrSUpIUzlYckRFYk5kMTBkWHhqUVZSMDZuWXhK?=
 =?utf-8?B?eVdjU0dBL1NrOHdpOVQ0Sm90S1pDTEpEQkxyaE0xdGNBVUNsQmFsY0gxNS9T?=
 =?utf-8?B?bjZ2ejh5MlltbDlRYjVPRjhWU1VGN0x1ZVpwTHlERXR3RUl0Y0NnakR4UkdC?=
 =?utf-8?B?OVFDdGZra1FaV0wwQmIrK0F1Nm1ZOURXakFITWcyaGtzRjQvUjlKa3VmVmpQ?=
 =?utf-8?B?elE5dS9qSGVTSjl5eHdsNlp1SXdid2JqcTEybWdlQnZQTjlyRnhPT2tMRTlR?=
 =?utf-8?B?VGRXVGhMUzI3MitBVE0vOG1mNWt2V1dRNFhCNEVHOEdtejNpcks3NUNNKy9L?=
 =?utf-8?B?c3FJelJCNHR1VDlSelNlcklTS25ZWjFHU2VJTCtCTVNhNklaTWdBSThnWE0r?=
 =?utf-8?B?ZGZKNVFsd25POHhzVS8rVWwwZmdFUUdueHlIb1JSMkFHM0xYSXRLdThtdndS?=
 =?utf-8?B?V05GMW9HMGlRY0dacHR5UndqemNhVTJvL1I5VXdybFpTbVJpbXJVNzBVWnhK?=
 =?utf-8?B?eEhYUTBtMkFNSVFKVS9JSjIvVG5WL2R0czdHYWNycHlLaEJxU1lXdUMyNUY3?=
 =?utf-8?B?bTJ2ZW1WbnhxZnNYajVGZEVvNHUvbVNFcFE4OUxIZVZGWnlvS3hVVG9WNEs3?=
 =?utf-8?B?dit1bExSY2F0NzVjVmdVRVEyVXhucFN6MTkvR3hHTDN4azFITm5mamdWbjBl?=
 =?utf-8?B?M0h6RVBNeDFoVDFtRDVtQjFROHI1SkVHQ3E5a3RZelpQNzFnYXRoNW9SczBH?=
 =?utf-8?B?Ym8yZHJMY0x3M0EyRWx2Wk0zZE1vRXJCcXdKRE1wdThoZzRLa1FldnQ1WFg5?=
 =?utf-8?B?cXBOZ0VLR0YxeG1ieHZzcm5hdG1JdytpWiswaEhBYnRGbnM3UjF2dVl1RDhV?=
 =?utf-8?B?MFc1N3JRYzRnQVNLMGFrM1NjblJWSUxBcFhrVXp6S2VnSXlGU040Q0tTaTlO?=
 =?utf-8?B?Z1FiL1RlcHdMTmpTUSszZWNBLzZjTC9XMEsyZ2hzZWJwekNIZXErbWpBc080?=
 =?utf-8?B?NE4wbU9Pb0hsYTErTkpyWUxZUENiOTJXSmI3T1FQVHlNUlM5UjMyQ2xzS1kv?=
 =?utf-8?B?QWhSUHlpTHFDS2l1ODlSeTdkOXRvU0ZOVTlpaTVjbVVsc3ROVXJ2Lzd0VGta?=
 =?utf-8?B?YkF5dmpuYnhCUjAvQUpFdEJBc3ZtczFmeUZtdVhMQnY2a0NXSHRDK29aZFFJ?=
 =?utf-8?B?anU5Mjd3M3g2YWtKK0k3ODdlak9qYWRaSHZTZ3BaVGg4NHh5c3FlOUlMbFZj?=
 =?utf-8?B?NjlkMHBHMHZiRTB1eTZ0dWY1cFZxZTJ2K0s2MW5sRk43TXljK2FNdkUzUitz?=
 =?utf-8?B?MHc1dVhxT3E3YUNXTnFPUG51c0h1SHVGa1B1aE0yYjk1OWdEeDRVbnBHeU9R?=
 =?utf-8?B?Y0YxQTVGUlVZZUd5bXdkcjRwYWVHMmVtWTQ2Ykw1WlBtQ0VHK3c4dzZHTGhq?=
 =?utf-8?B?RWlNSGFWWnQ3anVFTUNjTjcvMVF2Yk9qYU5wcnhFVzhqRjFjUGFpRGJGbzlq?=
 =?utf-8?B?Tk9hbU1zcjN3VE5pS3loVVhmYVhia2J0RWVUR2duR05lZXlQU0I4TEJQYXlN?=
 =?utf-8?B?NE9kUzRva3YzVk4wVWVxYzZVMW1ES1d5S3htdG9mQTNUT2hwc3R0SVVwZGho?=
 =?utf-8?B?UHJNUU8zY1VWekRvRjkzL3dXTFBQTlpTTU5aUWRCQzBkaG00R09VeHBJbnQ0?=
 =?utf-8?B?Z2RGRXRsVTJoSURzNEVDYXFUUm5QYWU2OUJEU3lFelRETDhCV083VlhlL1N0?=
 =?utf-8?B?eGZZU0ViM2dGc0QzdElGcFJoYnRlRnJqQ2E2ZDBkSHBSNnpGanVyK09kN2Zm?=
 =?utf-8?B?cUdkLzkvY2c4dlV6QUg3WkEwaUM1VENvMHVyQlpQaWN1OEJlWWJ4SlorUkp6?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48BCA484DEBDC14985077873204736B8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44b6513-17c3-45c3-71cc-08dcecd944b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 05:21:48.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/jgKtX0p3d4Quf6ouKv6BxWZc/BrH5B2pBDAbxAA9I/35EHuoLaed7aEeFh1kkcuNMyTxLjvD8YsdJbrHmu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6744
X-Proofpoint-ORIG-GUID: ST8OPep4GNM2MlD-4IA78lPJ6HAJuXTD
X-Proofpoint-GUID: ST8OPep4GNM2MlD-4IA78lPJ6HAJuXTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0b3BoLCAgDQoNCj4gT24gT2N0IDE0LCAyMDI0LCBhdCAxMDowN+KAr1BNLCBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBP
Y3QgMDIsIDIwMjQgYXQgMDI6NDY6MzdQTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBFeHRl
bmQgdGVzdF9wcm9ncyBmc19rZnVuY3MgdG8gY292ZXIgZGlmZmVyZW50IHhhdHRyIG5hbWVzLiBT
cGVjaWZpY2FsbHk6DQo+PiB4YXR0ciBuYW1lICJ1c2VyLmtmdW5jcyIsICJzZWN1cml0eS5icGYi
LCBhbmQgInNlY3VyaXR5LmJwZi54eHgiIGNhbiBiZQ0KPj4gcmVhZCBmcm9tIEJQRiBwcm9ncmFt
IHdpdGgga2Z1bmNzIGJwZl9nZXRfW2ZpbGV8ZGVudHJ5XV94YXR0cigpOyB3aGlsZQ0KPj4gInNl
Y3VyaXR5LmJwZnh4eCIgYW5kICJzZWN1cml0eS5zZWxpbnV4IiBjYW5ub3QgYmUgcmVhZC4NCj4g
DQo+IFNvIHlvdSByZWFkIGNvZGUgZnJvbSB1bnRydXN0ZWQgdXNlci4qIHhhdHRycz8gIEhvdyBj
YW4geW91IGNhcnZlIG91dA0KPiB0aGF0IHNwYWNlIGFuZCBub3Qga25vd24gYW55IHByZS1leGlz
dGluZyB1c2Vyc3BhY2UgY29kIHVzZXMga2Z1bmNzDQo+IGZvciBpdCdzIG93biBwdXJwb3NlPw0K
DQpJIGRvbid0IHF1aXRlIGZvbGxvdyB0aGUgY29tbWVudCBoZXJlLiANCg0KRG8geW91IG1lYW4g
dXNlci4qIHhhdHRycyBhcmUgdW50cnVzdGVkIChhbnkgdXNlciBjYW4gc2V0IGl0KSwgc28gd2Ug
DQpzaG91bGQgbm90IGFsbG93IEJQRiBwcm9ncmFtcyB0byByZWFkIHRoZW0/IE9yIGRvIHlvdSBt
ZWFuIHhhdHRyIA0KbmFtZSAidXNlci5rZnVuY3MiIG1pZ2h0IGJlIHRha2VuIGJ5IHNvbWUgdXNl
IHNwYWNlPw0KDQpUaGFua3MsDQpTb25nDQoNCg==

