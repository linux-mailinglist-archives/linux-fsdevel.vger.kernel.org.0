Return-Path: <linux-fsdevel+bounces-20635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8A8D6442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F08C2880E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B421B815;
	Fri, 31 May 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Ymhg4CfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459217C6D;
	Fri, 31 May 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165011; cv=fail; b=P9/Os4FFeDzdabTCHonPjbPnSkxYilgvkg3eB7/rI5Cm39oyiI+Es1vamW9SZSDy5i0+dQiYvnR8NQXlQbs5cjuKjePW3Lvo+ZluBYxl368cJuGW2KKD+FHxKBDQPY/kM0nFFRR4hQXuj9BHtH4NQnQRJ6uYvCaKXucsY8vN6O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165011; c=relaxed/simple;
	bh=R4nlkTgsstnYK9KNlTh+4bSeNYjMz2NT6LwR848U6M8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ble/Mf97T1J+HLkiHYt8BqLtWLKNuW4kEJi0bRaVVAAtCHNyqNKxgtvHP0FKgShL2TciyIOa2glbab28+6dSEwdmHuP53NAztwWDwRwtiZKFhkhz0/zric6bRrI/2ViJHNReCb5UM4WDSZFD5ht/+Pm2jeXtyIFuzOevHOZIbwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Ymhg4CfO; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VDmAgs010947;
	Fri, 31 May 2024 14:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=4
	JfxeYUib4r80+LRn4uz1T1evCuxs6AjhCmaUNJdSec=; b=Ymhg4CfO9ZUEyvNGi
	dHJFFKAdXDDsayWFIKLG/U49gmKu3LOUWcTwYo9y0j491ErWG9i3slVcoajJEptX
	VwbpdHnqhdgRGng+HmPrE0KEbgzrCWCc+jkqxRJlGfzMzwYNpowqirtxXuuYrQJM
	N1m2DtyJxTO2QDZNCjNMu9hCg/bIEPZit7Kud4Iq4NyTKI/bAeVh19LgaGwm5+sk
	andD8unQY3GhmMNUpZTF6aoYFGKmNmFx7AxH7/tX36mu+hEgkJHGa1G6aE8P5VdQ
	ne5OJqn1uDSArYyY5yP8Hx/cMOBdxH78erUyGdzP17aH5sKUJKNgUpXGr2iRP3mI
	bC/AA==
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2107.outbound.protection.outlook.com [104.47.23.107])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb8cp60r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 14:15:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIokBFNNY9xj0oQDUBEcF1aJRHxEhopZeQFxpb+MmU5ELpYMWoJ3/ZStSWdieeQljj/UW7wT8ibpvZCOotXleMk+1Nv85jKp2mIgmeBWSWBReHBmOwQf2k27vJw2BYJGeNJrQkOuICD70fguKFOHe/lPVYZqp34ybmxFKxT4nZPCwXvKP+bSaMIYT/PzbiJPsfVfAeBvE20+P+7u+MGjbPFSMjJK2saT9lvlyufQX3DL/Amk6/riCtBFpN7neJQBSnkcNHQ9r9X6KA4TcWtW/nuUC8p/TXqV/kmsfga4GwS1Q1Y8VCFQxewGuM9YtmQBwUa9ZUJT3EALC4+GktyGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JfxeYUib4r80+LRn4uz1T1evCuxs6AjhCmaUNJdSec=;
 b=SyG9z+C0OVJ6gzX5zNVA1rdwwbVrlFbf/zS4xwPEyjISNe0EWuTjrsmykcZp6lN4QPJJcD/sBlGmKwpvRDEyFrEjtBoodmyhGbJOATjEMzyUJ6CAVIavPWd1+THltjITlnGlaUeErWsnh+A21Xct3VGwUXddXg+t7n5BwqRZe/s5E5UlVLh8R2353ke7Un38257UBZhjp2G4K7TXl2BcQyjp61qCKIMh8venY7zUzo/6CrAZWuh/QAMuhzS/5jFbFPYLHdJuWTY9zvSKULOe3ENKEPM9KBcCxojXpfL0gcfYB/XvuGTGwgOqXwSgEfh0+r4fLA90y2EtiIymDG69rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by OSAPR01MB7255.jpnprd01.prod.outlook.com (2603:1096:604:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 14:15:44 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 14:15:44 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
	<djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Topic: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Index: 
 AQHarBuqqIQ7Mttzp0e7Oah3njC7eLGlO2CAgAW3O9CAAATqAIAABjfQgAAVSQCABlmkcA==
Date: Fri, 31 May 2024 14:15:43 +0000
Message-ID: 
 <TYAPR01MB4048E8F253CBFE44EBF9836CF6FC2@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <Zk+c532nfSCcjx+u@duo.ucw.cz>
 <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
 <ZlRseMV1HgI4zXNJ@infradead.org>
 <TYAPR01MB40481A5A5DC3FA97917404E2F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
 <ZlSDinoWgqLt21QD@infradead.org>
In-Reply-To: <ZlSDinoWgqLt21QD@infradead.org>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|OSAPR01MB7255:EE_
x-ms-office365-filtering-correlation-id: f0efda80-2d3a-4eb9-dfe8-08dc817c2884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?trcLOkBjn37b/rMCNDsLz8OowTXsQxhKAgr+EtLq2A7VORexjH7nuFT3d//1?=
 =?us-ascii?Q?cfWJs4xcTEc0svtITkSVczSno09Iyv4fpBFI/M5RMFKqw00eQxrLxd/OGVdY?=
 =?us-ascii?Q?5B6t/CIvPV0jeUhM2OysTIGFKwKPB/v9S7/8VYvn6CNZmz4Zv1wPPAE8/YBs?=
 =?us-ascii?Q?hYu19nXnTwbhZTbJHFqvQXrgefEkFOltXYdU7WtnFGDghuU79kqKTm0ZcltI?=
 =?us-ascii?Q?UWePJ3TVLEswmkdzdogHP7RFUi+A9O1jKkxAYOwibFEE4n/DNfDsBQVoXlEB?=
 =?us-ascii?Q?vVk1xcwlZ7AqD/MuHtr6VQAZXZmF5qddbCNfC7lw1b0zuc/2CZzZr5QtDhKt?=
 =?us-ascii?Q?UgGmSSFed5P/9XK09JORzIqcAAQBZP+lB6wYRNlH7MTuGvOiyhDgj8Y0rChr?=
 =?us-ascii?Q?RxoFoq83iARNSqe2gjI2C5rHyIp67XDlduJE3LlPiMcodyY+FyRE2+4sw5dd?=
 =?us-ascii?Q?4fE3/oQAhEOP9Ba4F7lVrcumaWvb2lNFSQ+kvd87M1NofNV1QSRYro6kcbhW?=
 =?us-ascii?Q?2z/FPIHjV3VowRPllIWEWw0fYV6jYNrrht60ZF1HvKKuxMaPoGozbyD6dMb0?=
 =?us-ascii?Q?uhOUoerZDF/BAgj5yCUhSLAscxBGrvBIxX5XmbP5H4w9FjaXUlsDU1svZaoT?=
 =?us-ascii?Q?thH9cxjB+M4lipIqL8qE7INjA7MNobOZL3f2bx9ppbSW74CrWFvwn6ndW/Hq?=
 =?us-ascii?Q?KdWlnSNlgSPGIA4M8Rc4q8//eZoEV6ag0P2zPVCvBPx6T7HuJlJiECqm5jnV?=
 =?us-ascii?Q?NSR0cMKnOQAw+WgLVDnBkfeDr+M7v0CSWpq7AcEc0SE20Ib6RllQAQC9wPTY?=
 =?us-ascii?Q?OEdmwjTSjk119sQj1TKhrMuJf7xqPAO2n8q5vRqooasFX+/g8EcuLTxG3rnR?=
 =?us-ascii?Q?anXaxS/VpyHsSVxdWOKUAhlSBgB7vO+uXA0tcB3FDP8gMD1AApZKRPY/ad1D?=
 =?us-ascii?Q?5T9dAS9uXaF/fTMyr7c+Qpfla5fLT7tY5XvWHhi6oj1DWbZ9JVh69uFd1+iA?=
 =?us-ascii?Q?IbmqRrJL6dRfzSxSv24ttZU90415JWxNVMNEriUGChYPFrj/tpz8gCPS8MM0?=
 =?us-ascii?Q?B/3Uqofjw7wZffZCW/kuAGqfhMyOvT2KRkIu375YvGsuzK+70qDM3mo113tK?=
 =?us-ascii?Q?Ru8UVMjBMgdxGKSJyGZ4yhRUj3XWiou+Y5EbVr4HfOM4jY20Kor2+hIlFdqx?=
 =?us-ascii?Q?aSK/9JplOqTJyO622ZBtCcpTa7B0u/PBSG8G3f77setWNs/H7vLUatiugpPz?=
 =?us-ascii?Q?Ag6N0bgOTSRMkEQgcgnnB310p/2AgE+ZUXYJxgZ9we3Lc2qe0KnL6AXh4C1+?=
 =?us-ascii?Q?aoAG4yA257nijZ32FaHcuQabGfo2XIZ0yT+UEsdDsJLc7A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Ss6XjYY/p9NA0XtUICifgUNKLGnTq1KXcRoxTDr1fI5nP/hg05p9PBYPoYyi?=
 =?us-ascii?Q?PSxNN4zTncatqd+nG+bIlcEi9ZfSqT7TWayNWkpWHfgCs33jTyEiZ8hqwUsz?=
 =?us-ascii?Q?iv2OBjbaWR2VMoo84lg2B/XhJnoX3FLnoPJ8XESxNVmT7Tu3suWrqGVLBSu8?=
 =?us-ascii?Q?X8eN6d6vxaLdSThAE/Jq+/RLcR9TGVOmCmG2iV3cGNCiuE553R1Z+gY4cxs4?=
 =?us-ascii?Q?TrVp8UwVz+F/mDbf6skrqqmWUKGFliGFifo/UaWFUri5g5K8tfdYVjlX/L27?=
 =?us-ascii?Q?thhKUPBHfERs7uU2DSX7IrBmcKkSjbcB4+MThTL954FMkvya5mckVOUaSnr+?=
 =?us-ascii?Q?/SliI5j6niu5xiBXpo3oKC3zfgnIVcRsCCsrPDEkF2G5LUl1QRqHKORg30y7?=
 =?us-ascii?Q?s5ER4dqQqvLp4Zc8enKbJoe5a4TBVDk2EayEuDn9i8WuRvAI+hfNbeKgFd2E?=
 =?us-ascii?Q?oxrJU3V1WW+Tye8OXl7VKOwpKOMOp7GtwK6nbNHvg+M6HgdssvPK3RBNNOBT?=
 =?us-ascii?Q?5CyN3nkMrESdOC9/jTnYkC4ZDrkI2AGTGLrKT8JUA4pJaHqx71NKZLfG8/kG?=
 =?us-ascii?Q?L4/b2K1NP1PppQ/vfAGhEtsLJqRxtsnmjsU5F6vnDppR2wy/ctUiVXeU8f/V?=
 =?us-ascii?Q?sTSZNNe4g1VU+0fCWECpAcoQk2nVS+hvPZC/KhyEaZbN6cXdtwrZyELMYOS2?=
 =?us-ascii?Q?hoJeGIEmF3K6OOU4bkBwp3HBPoG1JT1wlsu8Ocbn/REfWMGz5Q7dQfYx0AIq?=
 =?us-ascii?Q?/V1dPuylpnKHRuNNQG73pifi1M3nxhFC2z0IjmUgOgFFxvoWqCgNcB7VrW4Q?=
 =?us-ascii?Q?qOeuJfKW57DHZzO/XGvF/r4V9nYXRz1qHhjyw7pmuu/Xq+2iXKNa5qrnGPgy?=
 =?us-ascii?Q?BXd3TLfX614oSujyJUl8g2yUjnPFAwIhT01F6qQSZ4HJq2PZC56NLivR4ZJU?=
 =?us-ascii?Q?PI+B+51zP1hJqrND6VOlpCkeke6kL3z8UA5AAxggxrf7j7cdXbnbYq8DVaxj?=
 =?us-ascii?Q?UAzsiggrucNZw7ZfWnJc8QZEgK/XTrnietdpFMzAzdgKBuhD0sk/OjBCHaQz?=
 =?us-ascii?Q?sROd5gppVt56kF6V+sK/+h+Q5G+2i55DdaOy8LwN2XrzGg1SjV2qDqMTzKjD?=
 =?us-ascii?Q?MVBzCzfE1MNFAqEP65s/PQYIcn8VlXO3dz6i3zsSG43j6TujUDQWKOmp9Ftd?=
 =?us-ascii?Q?O/lirkoeMrcfg+gr5S/PhTjWiTBTvxJLodKIpn0sD+Fw5J9A2w3gcXc005RP?=
 =?us-ascii?Q?iAx86CRK48M4/cuoCd9WSnWgK69qfe50sZBUQ1hPuFQGL6jsSgODrEGBvEe0?=
 =?us-ascii?Q?ZoXoX703Kd461EBSosvxLxv+uNeoSwoQD9+2HG5SBwLFOPDkAqyVaijzU3U/?=
 =?us-ascii?Q?YRGbDEf4uXZWHgXeu0mzv2WJGgiqBtkzcjGvKCENibRp2NJ0CLF1+qvaazCR?=
 =?us-ascii?Q?U0mNGTEqXnexd4KdFYVT3jHkiR6Tfv827nB0PceCf9mDvwzjw2ykvj2gMdFV?=
 =?us-ascii?Q?2oUcp2aMaPHLhTjbNiXBHAewNcBz5TJENJPDlGKLBq7T3/Hm5rVGMp6GNBIf?=
 =?us-ascii?Q?cFjC2N3jm/VOamOoO9cmJO2QJ4OPwUf0YAAcy9lo?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V6tuBXVDJ6SUmedlhJI/X8uk6guc/LPfzL0dohzakzmnMKC1WUiVJdsWyKAvL+k7o6qaICqX2vxZUNLFoIqEnDgfoSIWNRd6w5VgLHoZ9zrOVUxr6uJpVVGaBQkcjr8rs9usaUIYTYULBt/coRLTahgiOSFFfkfcHz1Ezi7zqbCIpOXiyTemyADhkG8ttd6rcKhzuMN8PiKp22VJED0Mj2LL1f5O08qMkvsqrhdVUS2Avg6pIgwDBN2gow8m4pyKBrMPxK1Xrus4tStffGei1KJq3ElEjVGnjOQmxyAVrUvtyjUwNexTxQwbd9FvnpEta4ChPLkV52T6w6BQpXD21J6Heb2fLfg2NH9zOSV1FzYEkV9PByHvuM2RV77jBPgk8mVkAsa4OlAs621uIelNI+WqsNYNrtF5foWxJSmUY6PYdx7gLLSIJJ9cDunIXDK4SzutMXch5quXUoZVXVJY8BtoKpO9dAhRw/Vda6whE+xwOAUd8iBvYO0ooK00cNMjYoks7Cz50Cgkv2VL6dSDWMJB+7T3Aaue+/IKtQonEA0m1aFvu6Jzi2L9JonS/APBZM4fVquH9dajenSSjfujNRSJFzdlAvbDNAzjMnqltuUAyucHPw4ZlJDEyE+7+Cv6
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0efda80-2d3a-4eb9-dfe8-08dc817c2884
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 14:15:43.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EZcmHSV1n1qpPL3kkAN/8403/d5cG36v9cXFP3li6SiMjzHSDPn7iKOugXvK9C+4FtBAAZjuzIaG6bpTq9MYKKRDpjiej3ZqC7WhwzENBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7255
X-Proofpoint-ORIG-GUID: fv4UwVxttMOYqwiwpLRvG-HE3bEr2uwB
X-Proofpoint-GUID: fv4UwVxttMOYqwiwpLRvG-HE3bEr2uwB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: fv4UwVxttMOYqwiwpLRvG-HE3bEr2uwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_10,2024-05-30_01,2024-05-17_01

On 2024-05-27 21:58, Christoph Hellwig wrote:
> On Mon, May 27, 2024 at 12:51:07PM +0000, Sukrit.Bhatnagar@sony.com wrote=
:
>> In my understanding, the resume offset in hibernate is used as follows.
>>=20
>> Suspend
>> - Hibernate looks up the swap/swapfile using the details we pass in the
>>   sysfs entries, in the function swsusp_swap_check():
>>   * /sys/power/resume - path/uuid/major:minor of the swap partition (or
>>                         non-swap partition for swapfile)
>>   * /sys/power/resume_offset - physical offset of the swapfile in that
>>                                partition
>>   * If no resume device is specified, it just uses the first available
>>   swap! - It then proceeds to write the image to the specified swap.
>>   (The allocation of swap pages is done by the swapfile code
>>   internally.)
>=20
> Where "it" is userspace code?  If so, that already seems unsafe for
> a swap device, but definitely is a no-go for a swapfile.

By "it", I meant the hibernate code running in kernel space.
Once userspace triggers hibernation by `echo disk > /sys/power/state`
or a systemd wrapper program etc., and userspace tasks are frozen,
everything happens within kernel context.

>> - Hibernate gets the partition and offset values from kernel command-lin=
e
>>   parameters "resume" and "resume_offset" (which must be set from
>>   userspace, not ideal).
>=20
> Or is it just for these parameters?  In which case we "only" need to
> specify the swap file, which would then need code in the file system
> driver to resolve the logical to physical mapping as swap files don't
> need to be contiguous.

Yes, it is just for setting these parameters in sysfs entries and in kernel
commandline.
I think specifying the swapfile path *may* not work because when we resume
from hibernation, the filesystems are not yet mounted (except for the case
when someone is resuming from initramfs stage).
Using the block device + physical offset, this procedure becomes Independen=
t
of the filesystem and the mounted status.
And since the system swap information is lost on reboot/shutdown, the kerne=
l
which loads the hibernation image will not know what swaps were enabled
when the image was created.

--
Sukrit

