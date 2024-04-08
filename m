Return-Path: <linux-fsdevel+bounces-16336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE589B5E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 04:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F96A1F2132A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 02:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE911C20;
	Mon,  8 Apr 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y00T+7oJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DE15C3;
	Mon,  8 Apr 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542744; cv=fail; b=u9g+jBrvmZwlTJM3giBXBRwHNwx/FVL2o7R1B7sSkbA578FjbuiIxnXUKiNGyYZfYX9g4H6tapRNZFxyLAPLUCbXsX0CwADNrLNTBIib7ON4cEgOz3hV0OaLNeR2279DLkhRXugkWeB5XX/6Fnq2HSqwKXddx0n39ZhlSLFEbW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542744; c=relaxed/simple;
	bh=V003kRjKvlKjhTB152sZrV0XHkU2X+R/OfC6NLinRgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPb954jKVcZ5/E6DnTQ8ISeYmKWC+gsbUJ+oNSTOZin4g6fJbdhhKrIs0lzUDLbS9F0nxKde1EVzGie4RZfyM5K1VJIAcj51LI8g6WK3vvwuzItt7IBufJEa9pj6PxIrWsDvowyR81XHAHWn8DMG69PDwPZzrwSOoJpWRZQcpfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y00T+7oJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4380qNhQ025815;
	Sun, 7 Apr 2024 19:17:35 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xb5wgbe4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 19:17:34 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 4382HUBL014050;
	Sun, 7 Apr 2024 19:17:33 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xb5wgbe4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 19:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtSosLwrjMGITTn6JB33dMvaawigF9UFsu4H/biTXOxfLWksYMQa45WqNEFikRPrdo8PtlYBlRWLCycygFVJtocs8eXjr/k1oTHY8LTpS9fd0Bx+5yRY6gVgScKPaG1F9kbFMohVCOi7HLUFnyVlVtL3IyGnP2HFV4HHDvxbyiKBqr8MhNP1OjSWhYNUcva60MFLWBderXoQhIRej8ZHMHtJloMJVIGKt7LHGqxBCz+DlU0dZpzc8/9HT6Vb1OlnuzzToGEJOZKxdKTiJ7PtD/ys+ohrGlBFs4MNMJp/zhfFfBHIoh/0yBDBN38FtFlDUipU4n3x7K7VlhC5EKt2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V003kRjKvlKjhTB152sZrV0XHkU2X+R/OfC6NLinRgI=;
 b=WUbKAwm0Qbik6bkKTasxRb8+WJ85PEPZhepe1jXBV8KiazC7Um8fBEsg9LE8wLZT7MC+NvvWpTPnR2kPGekmom+FEeLhLPLdK+9ef6CVpMoFSn11K8H42Z1xFQnzinCPI9ia6PgIf/RntZmInlc0Sg7Vc4ZCV2CUa0VqCqcv0fhmYJlcyhRsVoZwB0PFgfy4ZgK+uaKeuiEed5iu8VIEANJqf9Z0koRZHXokyC1Qp5qBbICG4RJ8jhoq/25EkVqiQPThEdFbqfYcFBNfsKXZZY3/ytgv4XEbnZrhZCRR4NaJpR+MiET8qk1h6BR5dCeMmqNUWXJe8uAzN/ras31f7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V003kRjKvlKjhTB152sZrV0XHkU2X+R/OfC6NLinRgI=;
 b=Y00T+7oJ31PPds9ENxk96FIfMYrW888wmsb5wJStWylQ9dVGBc9MSlbQ6VmfuAN92/9QqmMrhzKLWfS24TuxJcZFtzgfyYqrhe1uaDBdNSgYmFBd8tIeOveMpItHSS5SrpO4nCAMHnS3UD8Okx/mX1LHffSqRGDJ8SuQAUnjZ50=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by MW5PR18MB5809.namprd18.prod.outlook.com (2603:10b6:303:1a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 02:17:31 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 02:17:30 +0000
From: Linu Cherian <lcherian@marvell.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "alyssa@rosenzweig.io"
	<alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "marcan@marcan.st"
	<marcan@marcan.st>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "paulmck@kernel.org"
	<paulmck@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "samuel@sholland.org"
	<samuel@sholland.org>,
        "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tj@kernel.org"
	<tj@kernel.org>,
        "tomas.mudrunka@gmail.com" <tomas.mudrunka@gmail.com>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "wens@csie.org" <wens@csie.org>, "will@kernel.org" <will@kernel.org>,
        "yu-cheng.yu@intel.com"
	<yu-cheng.yu@intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "mkoutny@suse.com"
	<mkoutny@suse.com>
Subject: Re: [PATCH v5 01/11] iommu/vt-d: add wrapper functions for page
 allocations
Thread-Topic: [PATCH v5 01/11] iommu/vt-d: add wrapper functions for page
 allocations
Thread-Index: AQHaiVroGe5AZYcZGkCwqMPJQFaIbA==
Date: Mon, 8 Apr 2024 02:17:30 +0000
Message-ID: 
 <PH0PR18MB500222E0231D648123200AD9CE002@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <20240222173942.1481394-2-pasha.tatashin@soleen.com>
 <20240404121625.GB102637@hyd1403.caveonetworks.com>
 <CA+CK2bDmya+768tOvF0N-BYq8E+RwBw4xS8vC+MmbU9eoOv_3g@mail.gmail.com>
In-Reply-To: 
 <CA+CK2bDmya+768tOvF0N-BYq8E+RwBw4xS8vC+MmbU9eoOv_3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|MW5PR18MB5809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 a7LudwNacFIMnFykgcHw/0SqZfy6iXIbqP6hembj7ydS066DeurpvQF/qFZRT2UzK0V/MonKur2jbmGedgdTGrfbeGgkO5R7sS3pPqZQ6+RPlTxr/gA0eo+moOTvsdHLtTgqMyfQCYMWYInjyzf91KKDPu4clMxjaerbx0IzjvUE+9y9OShjm/UBIn9aElvhQNamlMvWpAYjwXnTrX/yMb5CYLPrZpeYv3mxYo1o9d7D0M4inV2CkibAaP4j7f78Iy1WD7fRrigh3P/UI52Zk6iYvweFTBbIOMljzseCDhyenskdUc+g9slZm8AtPQyYLc1SuMdFN7Fc3S5gTxuWToaWGAacxCwYagxbeaUHfwyp/qyeYfeRK5yhDN4SCKdyR62pCQrniUjCTBr1jQ/BJcRNAdtgLT6bnZxSpPggqf9w+TtQv3EjX9qosTmvjST0hkOD6CZzu1sSOXRGOQg+FRirm74NYoj2JHEv+KUzbBvfdsFg/ZSy+eRsiDX24YOzA7FcmQC71r9RHw3ASbeJn36TmWn+V4e42i/zehtH4lDLnTQX3awiWYTs2YxXgWOiibQQWYEOWquXIlQSzfy7vunIqcyRhUB47//jOpvbC4zwxQTaCxfu4YZHUz2DRf4OjTJ2GuxGslDyKnipKRsU8t4bBwc5ISNr9XgukliVgMk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VU8rQ2p5bkZqQThRY1JHYjMyMFRCcEp5eTdNWHNzUzRwZXhvSG02Y2lYend1?=
 =?utf-8?B?b0E5ZjQ2U2tEbkYxMDZBckorMU1pVWxDSGdHRGNnenJ3U1FhVWdnNS91ZTZO?=
 =?utf-8?B?TElxKzNTbnBoTFNOMzlDSnRMbnJlcVZXMmZMT1l6UVBrdTUrL0QyNVBpRnpK?=
 =?utf-8?B?ckxISm1aZTNrdmMwd0VGTlllVjFtY0dVVnAwd0YvanY4WUlBd0ZJYms5TmZM?=
 =?utf-8?B?TlNieE1DT0Q3Z21CTGJrbjVFZlA5eUs3S1llakxHVnhOcWxBSWtWS2M2MUpn?=
 =?utf-8?B?MEt1aDhaZm9XWTl1UHlhbHFNelZlakRoZ3d1QjJyS01UcmdwY3kra1ZPUXI2?=
 =?utf-8?B?WGdwaGkwYzYvTWEwQXk5ejlEdllNam1Hc00zTHBKRnNnMXYxVUt4TnRTUzdx?=
 =?utf-8?B?OFZvcjJxZjNaYjdJM3FrMHpIeHFSelNsZXZKUTJQeHhQUVN6K2VNS2pibW5J?=
 =?utf-8?B?RHZHZjhBWGsxendQRWJtQkhhNzM4dGNQR0RBNVFYMmFWREpocnRVRFFvVWND?=
 =?utf-8?B?OUxqQmc4K0lXNm9QS0VHUGpiSmV5cllIeERmeHptcHZ6VTJGNCtpbjdkUjRi?=
 =?utf-8?B?RC81VHoxUzh5aXVZRGhScU5WWEc3NXZYeUVEaFpYdXZDVWxnYm9OWVlnaVlM?=
 =?utf-8?B?dk9FdGFjc0tvYS8xVVJBK09WemJmNy9HQVh2OTFFOG5VbTBmU3Ywd2NaaG9z?=
 =?utf-8?B?ZmtRL0NrY3dPTUl1L0dhYUxjYW85QzhxODZyaDZGcFhtZldtNXF3QlpvelFD?=
 =?utf-8?B?WS9HVjEwRUt2NXNUamVoekdPL2dpWWNIWVhYSW1WNDErT1RUbzkydW5ES1Zm?=
 =?utf-8?B?S0U5c3ZkeHNUMFVuWWoxbmtCQVVKUG14U25uOWVpa3dRaE40czZGYUZyT1dp?=
 =?utf-8?B?R0FadVVQVmZ3OFE0VHQ3a2JsRGdNN3F1TytsU0EvNzVOL1NpV2M3cUQ3dkdi?=
 =?utf-8?B?ejd5NHRjVjBpaGNIdmczbEpIR1RaNU42Q2gvVUh2TmJnK1U1WkkvejhFK0FT?=
 =?utf-8?B?K1ZlL01vMWJYa0laL2hDYjFCT09IeWpSM2NUMnJiTHJVM002R2ZEdTBpVEEz?=
 =?utf-8?B?SDVwRmVkOVhhcHZWdHVyL0hqK1g2QWtEWGVmbCswelhHMmRra3pucE5NR0RI?=
 =?utf-8?B?WWFiRzd4bUdJMGVxUU9OcVhGQnBrMGJ1c3pMSWtmQ1Brb1dlQ1dya21VYzVn?=
 =?utf-8?B?UmlRTTRxWVA5ZS84dmM1Wk5SbFp3WjR4a2dYSUxzcGZzTE1HRlFUYVFOd3RZ?=
 =?utf-8?B?dUdhNDVxY3JoQkZZQTM2Q1lmTDdvSW5jdkQxdXB6ZlBhSmh0ZFpFZVZnOEVn?=
 =?utf-8?B?a1A3eCtxVy9lMHdYS21mQm9ZV1BFSXNWYXZWTFU2RmEzM3RCK1lqYjBUUE1v?=
 =?utf-8?B?VXNCRVFWeThFNjNLckx3Zkg1MmxOcU4yWmZIc2VaNk5vY3VpSVpOZW1zZXRn?=
 =?utf-8?B?NHZkejF3S0IzM01nUkFUUmplUHRoWCtiUUpKMGJMNEtkREYxUzRjbUtMdnVn?=
 =?utf-8?B?aU1ER2VOREdUT25RNHZhb2Q0LzA3N09kc2xuOGNKbTE3MVpSNWZkb0U1ZGFn?=
 =?utf-8?B?aW5wUkl0Q3VPT0hKWEh5SXRna2JxYm1NNTRvYjBuS3E4T1Z4aHJJemRjR1Jj?=
 =?utf-8?B?aHZKdnoxZGkycXRZZFpsb0xvbzVQVHlTdGt2dm5IM1N4SUZwWFBJRUpIQzRp?=
 =?utf-8?B?cW8rellhaS9IOS9QbTNFdEJqYnpZdGlDeWJxZ0JUSkxqMENtMzlTZjQzNW5K?=
 =?utf-8?B?SGR2NklIK29jNHk5N2tVallvN1RVemFLMUdUS2g4ck9qQU9yb0RycFB5RWp4?=
 =?utf-8?B?TWZZUndyNnZ5Z1Q3WVdGOFFJWHRzcEhnLzhvRmIySmJiLzV3cVcxU1ZlZzk1?=
 =?utf-8?B?TGVLcHJ4cTdTZFhTb3EwRjNNL3R4Y3VISHdINGN5ZStVejY5VXN0V1dydnN2?=
 =?utf-8?B?VnkwWjA2cjAzRFJYbFhCd0Vvc2V4R1ozVVlBOExIMnlFU0MyUzF0MmpFaFRI?=
 =?utf-8?B?K0s4WTV1d2NRN2pjbXhBcVJ1cjhHdis4anJJeFZ1bUFQMGdsRy9GVzg5QjJ2?=
 =?utf-8?B?dnZrenlxc0I1N1lNSjZsVGdsZm1jRTdPay9OcDRyMnk2Und3TVBQVlZSMU8w?=
 =?utf-8?Q?VBFzLzwudupxpybOZ5N6oJztM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897432dc-8b6f-4957-6c25-08dc57720b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:17:30.6669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /B/551ZSbXpf/Uk3MbI2nGX/vWR3e3glypYjL1QA34x81LBfSIS6NMmsTm70xF5faDLfn9XTQn1mRroev5pMPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5809
X-Proofpoint-ORIG-GUID: CIc7-dxqNEkeMU5MHVckXAb8bCOb436Y
X-Proofpoint-GUID: _fqGv58pxyt6WRAvJtJUBmPJzUw5j76K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_01,2024-04-05_02,2023-05-22_02

SGkgUGFzaGEsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFzaGEg
VGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNvbGVlbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBB
cHJpbCA0LCAyMDI0IDc6MjYgUE0NCj4gVG86IExpbnUgQ2hlcmlhbiA8bGNoZXJpYW5AbWFydmVs
bC5jb20+DQo+IENjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBhbGltLmFraHRhckBzYW1z
dW5nLmNvbTsNCj4gYWx5c3NhQHJvc2VuendlaWcuaW87IGFzYWhpQGxpc3RzLmxpbnV4LmRldjsg
YmFvbHUubHVAbGludXguaW50ZWwuY29tOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBjZ3JvdXBz
QHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7DQo+IGRhdmlkQHJlZGhhdC5jb207IGR3
bXcyQGluZnJhZGVhZC5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsNCj4gaGVpa29Ac250ZWNoLmRl
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGplcm5lai5za3JhYmVjQGdtYWlsLmNvbTsNCj4gam9u
YXRoYW5oQG52aWRpYS5jb207IGpvcm9AOGJ5dGVzLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraUBs
aW5hcm8ub3JnOw0KPiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1mc2RldmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1t
QGt2YWNrLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LXNhbXN1bmctc29jQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHN1bnhpQGxpc3RzLmxpbnV4
LmRldjsgbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOw0KPiBsaXplZmFuLnhAYnl0ZWRhbmNl
LmNvbTsgbWFyY2FuQG1hcmNhbi5zdDsgbWhpcmFtYXRAa2VybmVsLm9yZzsNCj4gbS5zenlwcm93
c2tpQHNhbXN1bmcuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IHJkdW5sYXBAaW5mcmFkZWFkLm9y
ZzsNCj4gcm9iaW4ubXVycGh5QGFybS5jb207IHNhbXVlbEBzaG9sbGFuZC5vcmc7DQo+IHN1cmF2
ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tOyBzdmVuQHN2ZW5wZXRlci5kZXY7DQo+IHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbTsgdGpAa2VybmVsLm9yZzsgdG9tYXMubXVkcnVua2FAZ21haWwuY29t
Ow0KPiB2ZHVtcGFAbnZpZGlhLmNvbTsgd2Vuc0Bjc2llLm9yZzsgd2lsbEBrZXJuZWwub3JnOyB5
dS0NCj4gY2hlbmcueXVAaW50ZWwuY29tOyByaWVudGplc0Bnb29nbGUuY29tOyBiYWdhc2RvdG1l
QGdtYWlsLmNvbTsNCj4gbWtvdXRueUBzdXNlLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJl
OiBbUEFUQ0ggdjUgMDEvMTFdIGlvbW11L3Z0LWQ6IGFkZCB3cmFwcGVyDQo+IGZ1bmN0aW9ucyBm
b3IgcGFnZSBhbGxvY2F0aW9ucw0KPiANCj4gPiBGZXcgbWlub3Igbml0cy4NCj4gDQo+IEhpIExp
bnUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRha2luZyBhIGxvb2sgYXQgdGhpcyBwYXRjaCwgbXkg
cmVwbGllcyBiZWxvdy4NCj4gDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBBbGwgcGFnZSBhbGxvY2F0
aW9ucyB0aGF0IHNob3VsZCBiZSByZXBvcnRlZCB0byBhcw0KPiA+ID4gKyJpb21tdS1wYWdldGFi
bGVzIiB0bw0KPiA+ID4gKyAqIHVzZXJzcGFjZSBtdXN0IHVzZSBvbiBvZiB0aGUgZnVuY3Rpb25z
IGJlbG93LiAgVGhpcyBpbmNsdWRlcw0KPiA+ID4gK2FsbG9jYXRpb25zIG9mDQo+ID4gPiArICog
cGFnZS10YWJsZXMgYW5kIG90aGVyIHBlci1pb21tdV9kb21haW4gY29uZmlndXJhdGlvbiBzdHJ1
Y3R1cmVzLg0KPiA+DQo+ID4gL3MvdXNlIG9uL3VzZSBvbmUvPw0KPiANCj4gSSB3aWxsIGNvcnJl
Y3QgaW4gdGhlIG5leHQgdmVyc2lvbiAoaWYgdGhlcmUgaXMgZ29pbmcgdG8gYmUgb25lKS4NCj4g
DQo+ID4gPiArICoNCj4gPiA+ICsgKiBUaGlzIGlzIG5lY2Vzc2FyeSBmb3IgdGhlIHByb3BlciBh
Y2NvdW50aW5nIGFzIElPTU1VIHN0YXRlIGNhbg0KPiA+ID4gKyBiZSByYXRoZXINCj4gPiA+ICsg
KiBsYXJnZSwgaS5lLiBtdWx0aXBsZSBnaWdhYnl0ZXMgaW4gc2l6ZS4NCj4gPiA+ICsgKi8NCj4g
PiA+ICsNCj4gPiA+ICsvKioNCj4gPiA+ICsgKiBfX2lvbW11X2FsbG9jX3BhZ2VzIC0gYWxsb2Nh
dGUgYSB6ZXJvZWQgcGFnZSBvZiBhIGdpdmVuIG9yZGVyLg0KPiA+ID4gKyAqIEBnZnA6IGJ1ZGR5
IGFsbG9jYXRvciBmbGFncw0KPiA+DQo+ID4gU2hhbGwgd2Uga2VlcCB0aGUgY29tbWVudHMgZ2Vu
ZXJpYyBoZXJlKGF2b2lkIHJlZmVyZW5jZSB0byBhbGxvY2F0b3INCj4gPiBhbGdvKSAgPw0KPiAN
Cj4gVGhlcmUgYXJlIG5vIHJlZmVyZW5jZXMgdG8gYWxsb2NhdG9yIGFsZ29yaXRobS4gSSBzcGVj
aWZ5IHRoZSB6ZXJvIHBhZ2UNCj4gYmVjYXVzZSB0aGlzIGZ1bmN0aW9uIGFkZHMgX19HRlBfWkVS
Ty4gVGhlIG9yZGVyIGFuZCBnZnAgYXJndW1lbnRzIGFyZQ0KPiBwcm92aWRlZCBieSB0aGUgY2Fs
bGVyLCB0aGVyZWZvcmUsIHNob3VsZCBiZSBtZW50aW9uZWQuDQoNCkp1c3QgbWVhbnQgdG8gcmVt
b3ZlIHRoZSBtZW50aW9uIG9mICJidWRkeSBhbGxvY2F0b3IiIGluIHRoZSBhYm92ZSBjb21tZW50
cyBpZiBJIHdhcyBub3QgY2xlYXIuDQpJZS4gIiogQGdmcDogIGFsbG9jYXRvciBmbGFncyIgIGlu
c3RlYWQgb2YgIiogQGdmcDogYnVkZHkgYWxsb2NhdG9yIGZsYWdzIiBzaW5jZSB0aGF0IGlzIGFs
bG9jYXRvciBzcGVjaWZpYy4NCg0KVGhhbmtzDQpMaW51IENoZXJpYW4uDQo=

