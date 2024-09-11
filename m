Return-Path: <linux-fsdevel+bounces-29074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1297485C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 04:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1DBB24AEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DEA29CF6;
	Wed, 11 Sep 2024 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="iJtzGTmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD22D057
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023227; cv=fail; b=KGm/kvbZNN6mvWOSwXfFUBmwWF277tysn2tx1pUF8ebrZh8yEsBYD/bRN1yP+MTI6ruKZG/fKxFjm0r2b5wBMlCo6EQ7zElx+fFF3t/JtSu5gszbvRhfRCaUmL6oVOCG+MahBXSjvHZ/uJfV8fF4l0Y6PRyhKwhF/D1JDk1YtuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023227; c=relaxed/simple;
	bh=o7WfngM8mlCkIPUcPIJVSKriWt4AEmVBE8cJnGI+vj8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H7cKKPA6W9mxtmnhcNoWRPixp+qDNTnLe9J3MPjYe2yZPd9hube3yJTCrXGLJdBIYC1KEeKhB13zDCuTW+BSnMLffFqLKBXBcoyoFiImRf8q8PegYpwG44F8PzGpEv5FQr7KEPWZkAGlo0dDrC7PARnOQgZPPfhJoKAyjVgpopE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=iJtzGTmx; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AMAPGl021919;
	Wed, 11 Sep 2024 01:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=KJyIijQTa5YIc9DKBzbKHv5VGAox7
	2ubjlt1mBEhzME=; b=iJtzGTmxLshW5wHgB29qASjNuUcmUIO+e2+HaW8fvKmNP
	r3/CYe6dq0CpHkH6ZxkSNk2s3wFe0oE2wpOm7ng+xIxjb0t3UUxflyhWaE5/JlbS
	SHpN9DgKLYf2p+jlRv+9bb/+QYEcyv+pYApJ44xts1sk/Mhgpnd97IAM2/qSbTk8
	HNQ8xEr/kbmAXmbKTYMqtjFpsrFDHpT3Uhit2Zd4D8t4752Crya2puuFSGB5P0ZB
	6V61ziD05HprnY1rTZC6XSmmaPKAQ8rHS+GmIlvpKXEEK4o7/UUcgtTbT0ZRt0ll
	zJluE/2z3bF1668uRQt9RzA6fQLwWj3HeynmsmEyA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41gex54040-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 01:46:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD400u1qrv7M2pIUmE809ceF0WLgRcdj0kgdHGsRXqD+ZeTTyXjYBMq2m5YX5f8UL28z7B5i3UX1HQklXm+AZd4K+27zAXzEAQmwY+sd8+8vciLYGvcQii0pl8q+Iv4WzcBUnQ2j76IwdFhYpNMZSilxtScY/lBXiqCmv7lu28ybQkOdU6n0MfEJ0SVOw2MefhNc8ZJPkDNExl+uL4qKqw4xsg95Hagk3RQKnfurhIBHcZgTxRMgV3FSHoNFEqovEkwdcW5UxXTS6BEQRFDLn/8tNCxfekoUfkB8S2BrCVZTkBjpPleDUAHG8cZggcGNitoXOwY2SraxHsVNIxhHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJyIijQTa5YIc9DKBzbKHv5VGAox72ubjlt1mBEhzME=;
 b=Bmmk0wbLN1gT3OgjkqSgRV4fOXSX+kQ6kgLr5yf50E/9WpKn6BPsiWeirFK0QURxQ7lkf4vvOCD+JPpDak9EYBxps9nYe3sqbDeKUZ0OEzo3/WmJ2ghmML/lBaUIE9VqICeN9aT3sTQlpjoNmMcCb3e6np0LKSEe0NVavqKTRYKfM6TZe56DB7alS+I5D9pKi6+mKuEJ883tyEIa18TxFMsFf1yefv8tcxs6H7JLwi4kadcPLBw3lluHFPvQXJ2DZ2iGBwN+JE6K7Rcy8tdk6M/3L5QLo5PNkmprh686VMUzESoVgNDgpXPrTDDkzQcU0VRyDbnbjnqPNTb/zbmonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYSPR04MB7159.apcprd04.prod.outlook.com (2603:1096:400:477::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 01:45:51 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%6]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 01:45:51 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: fix memory leak in exfat_load_bitmap()
Thread-Topic: [PATCH v1] exfat: fix memory leak in exfat_load_bitmap()
Thread-Index: AQHbA+vRPBWOliyyW0eeO90/Ksp31A==
Date: Wed, 11 Sep 2024 01:45:51 +0000
Message-ID:
 <PUZPR04MB6316152C6E22EF7D5D5973C3819B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYSPR04MB7159:EE_
x-ms-office365-filtering-correlation-id: acb6eaa6-aff0-4505-1bfc-08dcd203777f
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SpmnEVR0qqTfm5L3BH9DswlzdjtvrD2NA4IXlJwBwi04QfeTxTq1glvBU2?=
 =?iso-8859-1?Q?Zai55BwCzpMzUrKcrwlGfFI1ixzGePQYeUdvaoirTOfINutl/hnpEY088V?=
 =?iso-8859-1?Q?9zIOOymC2VuWA+EYH3+udwyzky7IsXu7FZqwWLyCkgRe2m/70ZvWejvY97?=
 =?iso-8859-1?Q?FJFCycEoQowDOxd/KD2owrtfM0XmtaBHeFB2wNyvRm0+crcl/CpOO3AskA?=
 =?iso-8859-1?Q?KqkpvSs3buS2Icjo61bMQ/ci/ECB1PsDjqOURwTRAxzg4lu8HncrwC9nGI?=
 =?iso-8859-1?Q?wMQEHtez770CzOCaQLqjyZ6IZTObfOZLlsQHGY3rEcwci7x2pEYRpTsb0C?=
 =?iso-8859-1?Q?V7UAFURTabPqTLYMOSBaIms8rvg0uPtfyFC+PTz4/cpiccV6aJ8llIT1pV?=
 =?iso-8859-1?Q?e/v7If2/qh4MG18vyE+oSIQjBkMyN5vONADJ/BLi9nRRm2wYqFCtyXcZXq?=
 =?iso-8859-1?Q?S6kQ7ts6dqdxurqqsWPLUOK7m4ByOBpdOLku7GkkoeK3q23vDMIJGw0VPz?=
 =?iso-8859-1?Q?les0dfCXrBrSAMOtkAjQWQSUud3nZ7dlRv/A6uw/byvsEc8oeIEVgwgTpU?=
 =?iso-8859-1?Q?8It0AupEpKTN5L6yKQZPdGeD8kvT8wQre0dW4mmgp8kDJa5WZ6FJG5s6Qh?=
 =?iso-8859-1?Q?RtsGXicoigFk640N+r3yLvQqrGLoggscrB1Q7IZu4nEoi4xVl7Dq6240bM?=
 =?iso-8859-1?Q?oevw6AxcOyYqzsm9rygr41lFjJ03yUhNsIBMV9xDl0CAPP4V3lUKC7ArKP?=
 =?iso-8859-1?Q?3onvG0e4LJcOBsyQ08TqFUi7s2rpisFrPb7DSNyl7j7f1H1E69HB3jMbtR?=
 =?iso-8859-1?Q?9pb0dOJodROCyVIxDn2witnxVyjKh3co5VQR9esyeL/AtUUk/sRCcDOeK3?=
 =?iso-8859-1?Q?5VniBLFrAY1OpJIxMd+wyl+RnJ9GHDDio5Lnf6JgFbudRtki+X/jqf/mcO?=
 =?iso-8859-1?Q?F2bGXSf4xXzu0VbbsaMnhheFQkXOZVTgd/z7AgwENFfj8oRMVqPbgWJzRU?=
 =?iso-8859-1?Q?re40denOqDJ2P6MybJwrUMT4IfhmJYXi/KXB2Bz3df0xxSOge+iWqmBeJB?=
 =?iso-8859-1?Q?GvB9eN/3lNDNXxPgy8uvq1QWglfGw5oj5LB6nHvprTamuhD8ALJjBlSYEG?=
 =?iso-8859-1?Q?EvH5M19qb8Ai4LLycLvZhzhHlyaDKXwXQiDAnYTnR0EwylzsmpAsYWIDZA?=
 =?iso-8859-1?Q?HuoEJQ1/LUYShNmcflB2wQE9x7ry0Dcv0vzpcVAoD43OTQ08cRb6LaCYXe?=
 =?iso-8859-1?Q?5IkpHGGJi8Bs2tidyfjYVXVghsHHD+hZbOveFL1V7d1mTiJGv6N7rEyuZD?=
 =?iso-8859-1?Q?TMEQfzqo29xmKf7gvklgmUzusn0nh4tpiWCFnd9ZNVMSu1D/10NikqsNmr?=
 =?iso-8859-1?Q?IZ4bJa05CN0B120zX1oPuWfZlM0bI8joP+Dej7LSK3vFMg/quX3Xm7RlEo?=
 =?iso-8859-1?Q?VlKznmTFicSyZQwPlOnXns3DBhfkwMnLS8EIdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yDOmq0012oVl/ZKZxnoc7cj+IC+465o+PA0i6W66eyZBq3laS+Q8OPfwIb?=
 =?iso-8859-1?Q?B7qYz7JmdoLOlIjJJxg+fVNhtlJ10FAl7NQszoF4qSc9Zp/E47tWmZet5B?=
 =?iso-8859-1?Q?kS9lRJkrEekgvEmVLCsVdhkVMbU/B2hETPkv2l5CUXQjV6JINpF1t4d1fx?=
 =?iso-8859-1?Q?0wxKvB+z5uN9DwHp3ABpeEIKXGZH6SExoHEMM9IGB7NXaAQS7azG3mZSDd?=
 =?iso-8859-1?Q?LPDH5OMicu7QU/boNYXwQGDJ2NNdzMy37ZqCcP/EjF+XeDgRo1NxpFka/k?=
 =?iso-8859-1?Q?5Q175N9DhNkMLbRU43Nhv82C5drfwtmSqPmYKGhPou0p9QD5ZQtXDIiza5?=
 =?iso-8859-1?Q?yVF/6ToJ6WGZADmd0cwu1yW5r3LBMb5YpHUzgE82B4Fp+BJe+/Jfe5rF1+?=
 =?iso-8859-1?Q?MUl74N4zvu4joHMiXCoSHQthAcIExZ68pNuJkYNNMvSLSePPEzWAdBFss7?=
 =?iso-8859-1?Q?QA11Oot2ERlGZnoplYBSvBnMtR4A/ioPKA2IGGwmiwVQZKIqtLP22T34fX?=
 =?iso-8859-1?Q?tle4JoHsryVwD/RONOCKOw2KiFtWF+WI/rvoPRUr8bW527IX6ppaMXxIAb?=
 =?iso-8859-1?Q?RZQvmcGyy+cTX5ZWpgunKt8rOlnIM2A83rQljxcTsZbTD6jj8sQLVVy1yg?=
 =?iso-8859-1?Q?Yt39DqSgdCURn+SAt78LILjwirUhdNlWg3jeJ+GvtXJCwwdxDKkbhllTEI?=
 =?iso-8859-1?Q?1eUvZdbmS2mi+4VXVXQghBOSimOiOppYJ3E5kWEOjPNFuQGSqPY9MCzw6D?=
 =?iso-8859-1?Q?FZocysU7JxKjNaguGsR/sa/PD+TcSSB822I+ePWrjIMGxvRWHIB2oeeyay?=
 =?iso-8859-1?Q?gddDjp9NXNj5XtWGTNdp4Ucfd7M4yLUZyj6xEuesJPSF1STgtQIjfmwl3V?=
 =?iso-8859-1?Q?LTK+qLDgcKwcDqQwb7/PlYlUKzlqH2Xp0epezKbZu+gGs8DZEHdFwiRpFT?=
 =?iso-8859-1?Q?hkgMXZY3zI8fWkHIqMGhmInwvOsyQpeUjNK2lhVxOQMn7fJQw5ESSakUwb?=
 =?iso-8859-1?Q?sGOyIb+gju4jelBzzPLT5PkvxZXhNAzXVxQQ6oi+yzBmzhUyWTa2TdRLns?=
 =?iso-8859-1?Q?GodUs2y9U9Pj+Wax5gqtQ7+bQWQe4HWR7rntH4QhYT5UHPmR8E5S74qrOa?=
 =?iso-8859-1?Q?me4Foxjlbyo/Nsszwc8tmjvYnmc0kMHTb3VGeJ2GSgDKNCtFENJLXL0c7u?=
 =?iso-8859-1?Q?R08H2Zoy79onJ1icuYbXOlpSCZwS9uHNRr5SWmlCUdCPiUl+NjX16CGI/y?=
 =?iso-8859-1?Q?qoogQ4d82xuCM2wvpHu0R4RMeu84NObMziMkBHnanNUeQK+OgBiRdbruAf?=
 =?iso-8859-1?Q?uOWFMU0R863b+YK40pIrlIQT2EiANtIij8HIx7JjLhroBpUCa4fxSAAhro?=
 =?iso-8859-1?Q?h+x7xILsB5iRoZwj8xCD0HFTaF7fdto+k8nMW8CLfsNLfF3l70QVFj09J2?=
 =?iso-8859-1?Q?fnFeEFWVKufq7RzqsQofmTWGHH+xhzJvc2MZp7jmlt9+Za1xvBc/ljDOnB?=
 =?iso-8859-1?Q?4vePhpl7fQ/ZYoATUYwg0yRfUq8EyTUSMT4teCKveJBDS1xiT3cih/jXmU?=
 =?iso-8859-1?Q?KvyZQlH6QxYDSEmiETjf59wJsNiXi7G2WG35Okhmhj7eOOT8U71aQXa/f/?=
 =?iso-8859-1?Q?+AaazZJJWg23Bfy0JqLjDydQujiR6Iwv7e6jewPOQn5I27aJ7Xaj3HQV23?=
 =?iso-8859-1?Q?ikkDTUn+7K2HBbEOPo8=3D?=
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
	95/hm7jJyz3WKZJzIFDR3OGRHKsUxN+JLE5mFzryF0vnP4NlNEqDx28SlB3+fnDaIE8zHtsLmGqK5khZiGOUH+GeDH8huoXcgoCmDEUC0GPomtyGB2fiS+DpUmLwUFtEQ/abC7fXZDQ0Sz4lbEWtPjnbCyfClkJjIKQDW0eypMLgVnftgPOERAxuOVsm0SPTLbv9cv6BCWNi1BhRCpKpcDzhfy13L14eE+mbF0n1XEmdcfpDI5PtqMkY75YeNMeA0mESkX5egCUB51UfCCy/mic8J/504WfR4oGlIhCMxEMgTXZAXiEiO1HSDoXbsDMdL5sy3go7Hv3mdewzlvvbQqy9Nl6Eu9YZ6WBHxjxyUaBtaCLBSt/RKHjqMyye3V1+NeVja+CvyFQSOfPQMdRbkifqS4GaMEbcT+rRNProTy+QbWOqEECR4XcArsPCEdxrzJo2EyTmEJhbyptvk8oYF1aAicYFz6Jm5ZYnXCizdKagdnNkUnfP8nqZQCpZh+4JZj1zz/WUufhiHY7/iVvQMFD3AQOuGWXJaiGHuENXSKiiA3Un7u9OKGwjFbG2LVtUgSwrd0LYcik5wGaffS3WQ2bEwb5mfrMmXngIs3xMhE35rrm40+fvt7Z0tDuf439n
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb6eaa6-aff0-4505-1bfc-08dcd203777f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 01:45:51.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcDDPROiqtr9AYONYETic/5ANM/qPVtAxYc7WA6bfv6FeQoXGnFiKpk60ch6sl05H9on8DEvWi9uWffa5b28Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7159
X-Proofpoint-GUID: aClfNFtAfjq4IgyRXpN0Xy_qx5DmjcJW
X-Proofpoint-ORIG-GUID: aClfNFtAfjq4IgyRXpN0Xy_qx5DmjcJW
X-Sony-Outbound-GUID: aClfNFtAfjq4IgyRXpN0Xy_qx5DmjcJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

If the first directory entry in the root directory is not a bitmap=0A=
directory entry, 'bh' will not be released and reassigned, which=0A=
will cause a memory leak.=0A=
=0A=
Fixes: 1e49a94cf707 ("exfat: add bitmap operations")=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>=0A=
---=0A=
 fs/exfat/balloc.c | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c=0A=
index 0356c88252bd..ce9be95c9172 100644=0A=
--- a/fs/exfat/balloc.c=0A=
+++ b/fs/exfat/balloc.c=0A=
@@ -91,11 +91,8 @@ int exfat_load_bitmap(struct super_block *sb)=0A=
 				return -EIO;=0A=
 =0A=
 			type =3D exfat_get_entry_type(ep);=0A=
-			if (type =3D=3D TYPE_UNUSED)=0A=
-				break;=0A=
-			if (type !=3D TYPE_BITMAP)=0A=
-				continue;=0A=
-			if (ep->dentry.bitmap.flags =3D=3D 0x0) {=0A=
+			if (type =3D=3D TYPE_BITMAP &&=0A=
+			    ep->dentry.bitmap.flags =3D=3D 0x0) {=0A=
 				int err;=0A=
 =0A=
 				err =3D exfat_allocate_bitmap(sb, ep);=0A=
@@ -103,6 +100,9 @@ int exfat_load_bitmap(struct super_block *sb)=0A=
 				return err;=0A=
 			}=0A=
 			brelse(bh);=0A=
+=0A=
+			if (type =3D=3D TYPE_UNUSED)=0A=
+				return -EINVAL;=0A=
 		}=0A=
 =0A=
 		if (exfat_get_next_cluster(sb, &clu.dir))=0A=
-- =0A=
2.34.1=0A=

