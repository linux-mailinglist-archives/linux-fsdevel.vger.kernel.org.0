Return-Path: <linux-fsdevel+bounces-22066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F7911A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 07:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A54A284577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 05:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2523F137775;
	Fri, 21 Jun 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="ySnvF3Lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86563A;
	Fri, 21 Jun 2024 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947596; cv=fail; b=oGm2hPwnVnUCIMUYt3Cw6Bii65xdg2WeUukFp1rSqOhAHu6E9JYI6d7yna8PuOTCm6h2hgFw3gLtxADXe8Vdz8qHGK27kj3p7kKHZzt8lEUA3tAyg6ACwKlC06Su1UcLMO04YYFhC0Kr1DJ+8znjTJquIDKhFknK6HCW45muvh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947596; c=relaxed/simple;
	bh=9oQU431dfmxv9qzlnVMVhxfmSR95xqGEsSTiXzmunTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvZ8xxUE3bkLhLp6343lD/pjKF2BZG30O4PFCtA1A+CrHeZZP705omKrQB6t7MYcw389UGe3/xznzyIAK0nRYIzfTi07NzNXQmht8VbvuCOMzGJ+3Y/eGm6I3Qct8VSK6L631H7Hqklz5xKJ+Nm+HXcZPHESO73+GXaqxJR7Crs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=ySnvF3Lj; arc=fail smtp.client-ip=40.107.13.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY6O3gCe12h/j0zunjAIkW2CwY4Ugc/U0Ck0zJ7V53wxgnYazQ3SJIgt2C/DZGR1QPaQchvFT2UvDkNNAKnz0sZ666atuykxQZg7RrVvy+aJTSQAQSTUKzgwdphcuSpm9aSJOpdPJFIoYJxfx5fDk/7V8LVnPbz4QkFX1D6r1nWYv3c4fvYQUCMYA0RuSccEkSkCMWrgCUiI6TLXoI1kBpvL2a0pHHQ2SiX4u3N5ZjsRdkSbyZYsAydXR1cjqVG8yfv68Os0SL0LjstKcj4X16ys1nkahX501+fd46qkscqLpJm/PlbcJWbNm3XwYvNB/ebpcDrReT+eT7ckuNvgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oQU431dfmxv9qzlnVMVhxfmSR95xqGEsSTiXzmunTs=;
 b=AeDUjj25NxxBj0SciIha68l30yAn4VculTf+qKtHnj+a9uaTBlcGyuViqfqQ7MPlfZo8I5w1r9dKDtrXamrUioMNsvsQoET7XX+fyNri8gGG6LTWs3dt7+I0b4GojCSIFerO+VXavOEZkpbeuDtxWlA8g+R05uK2yoSQeEVTyveCDiofMLK8qdZtutITZEi6qF/kB20fircEhy3+USPMveX0ye7tRjOOkeKcXe/Bx/8rK9TeDTRcuD/WSMIEtg38WrN9+QVCd0nXsJ8+3EEehbcptrbFOJzTGf5p7/zdu40Tkym2j9pj5aG9nhEPYQ8W+PWgnyrIGc4YnM38o5zhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oQU431dfmxv9qzlnVMVhxfmSR95xqGEsSTiXzmunTs=;
 b=ySnvF3LjOxkTkotI5S8u79eZZjyOpMExs6zvZ6QP3P4ZaQMRpahAcsgZ6XEPsE0XcRxcCRnEwYUq84cx95zmwwTAPNnzQD4bNvwToV0nYOYQ3P/IRvrJmsvtbLn2bjVjKCdoUCAEmjcdTj9U0i1rM4BKsB5NWNILCMM1r/vxmy895cZMvinG27kxH6PKj0g6Cen5qsqYLjtxFfXFNbGYpC4CCVAueOhl1NbaQhoTy89Ls9ymKni4bEF3cJu1hJislqmhlTLVPaZdnQgnRBNltZuP4LLkqL33CsDU7gme93MwhdNE99maX4J3OAdCFWJ6O4yw+ii8Hj+Eqn9MUzPkAQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by VI1PR07MB9684.eurprd07.prod.outlook.com (2603:10a6:800:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:26:28 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 05:26:27 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Brian Cain
	<bcain@quicinc.com>, "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Rich Felker <dalias@libc.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>, "ltp@lists.linux.it"
	<ltp@lists.linux.it>, Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
Thread-Topic: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
Thread-Index: AQHawy5UVbb5fpmVkUWsYek9jvRaCrHRKWcAgACHWwA=
Date: Fri, 21 Jun 2024 05:26:27 +0000
Message-ID: <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
In-Reply-To: <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|VI1PR07MB9684:EE_
x-ms-office365-filtering-correlation-id: d6c3821f-a048-4bab-973c-08dc91b2b354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEFtWDJZNk9KTjJUbVUvbitFYnNwUjBNaHl4UGxMVkpiMVhib013YXBTRFJj?=
 =?utf-8?B?ZjNxUnE5dGltSHBlWUJFZ0VDUFNaVXUycUJDTWVzeFdBSGlvNmUzMFJUUmw2?=
 =?utf-8?B?dWZXSlArS0hLTEpLenZOcXlHTjZ4MTYrbURNMzVrQnFhckJXeXlRSjd1ODJq?=
 =?utf-8?B?T0JKTGZhK1FVRTIwc1FzQ1E2OVZyWVlsTTF4QXhCbTVEbDh1dGVqcWlQVVFY?=
 =?utf-8?B?QkxUdFRsZXpuUjN6Y0Q5VmkrVHVOV2lIMXYxVHlvcWVMMmF5Z3IvUjBIMkFO?=
 =?utf-8?B?MnZjaXlPYUdGcm5Vd041eGZKVmU3MFBVa09BaUFQOVhubXA2SE5kMlkxRm1W?=
 =?utf-8?B?SnVDQzhRTzVHaGtpQkF4MmtxN0NZaDVyWVdhNi9CUitHNzJjK09aRksxd2Fu?=
 =?utf-8?B?V09TNTUzWU52OTVZVmRyYmtxaG9lSXNGNkJVQnYwZm1KUm1VSUIyRzd3NUFV?=
 =?utf-8?B?NG1FSEN0a3BEeGd4elFRc2Npc2xaRnVwbEIweW5FaitIQkhxYkxJYWJ2Zjdo?=
 =?utf-8?B?S0FPdGpQaURBSG00NGdPWFMvT09JZTJ2OVEySTYyTExZdXhleVBnWUlsTGFl?=
 =?utf-8?B?Y1FmUVFscjQ1R2pkbzhPMzYzaFVlaGlNOWszQjJqQWJzL2JCZHkwVnBMRlZJ?=
 =?utf-8?B?SFhwa1hoTUx0K3EwTjU0TTd1bjhXNWZxQkZCMzVTRlpDR1ArTi9HZVoxdkl0?=
 =?utf-8?B?WFk0RWM1UDNGU1BMK1VoVTBkWnEzTlNGOUJDQ3o2VXB4TDFGVy92OWJGMnJ2?=
 =?utf-8?B?bytwcEZpMmE0NE5YMGhlbncySzdWZkxTaXVjekxtK2Qva2FnTlRydGsvTGQ5?=
 =?utf-8?B?NUdpZGQ5RDdhZW5xZGRKZkVaY2QxSUVCNTlEYTJ3YVZVdnVpdnJaL2RzTGV0?=
 =?utf-8?B?OEw3OWNOYWhhUVpsb0NNRC81N2pLL3dXdkdXUDAvV3kwNVRzYmRtYldjeCtq?=
 =?utf-8?B?UGthUUt6dno5czZDOVlQTzNNeXJjVXpoRmdINGRTcEgyL1lzWXlNSGtkM1NZ?=
 =?utf-8?B?bWo2UHhHM1ZZWDhlSHd5S2lsa1lXa3VXUlpObVBvKzhGWW15a1E2WFVsa3N4?=
 =?utf-8?B?ZDlpWGNFRThoV3FNR2FYcXNaUllqcjhnTmZ6cmlEWVdpcGRvcXJnRUoxdThq?=
 =?utf-8?B?VUp6ck95bGI2N0k4dGlQczBDZHNtbzlnb2pTdkFHMG9TZ0pJRWMra3BWM0hX?=
 =?utf-8?B?NXh0alBNUjVHdldtZ29iWXlZcGsyMUxnMy9nYWIzd0QvYksyWkdid1MxbEpL?=
 =?utf-8?B?K08rS3V6czNMSzZiMnFyVjRrU0hBYnk2ZnBGVmdLMzFrbDlPcHFTS0U3Y3VC?=
 =?utf-8?B?elUrcGM4M1Y4Mkh0WjVNK290MTV4NzU1OW5Bc2VhMWhVcVMwdVFBWldNbDlD?=
 =?utf-8?B?Y3hsMlhZdmMrdUd4dStyYUJWa04reFhpL2ZQUDRadWsyZ2NiRmF3L2JidGxO?=
 =?utf-8?B?Vk1hMml3NjJxMG5kSkFpMldJMGl0NTFrUHEwcS9yVzZCQjEzRmE1bGJsM3lW?=
 =?utf-8?B?dnZJbjJYeTEwMjI1SVdQS2Jjek1iY3ZCNUZjRkMxWHc3aHpNU3UycTZDREVr?=
 =?utf-8?B?aDRMcmIxOTduWnlTNTZwVEV0YlFlOFB5ZmNUbU5ZY3oxbWRzTU5VUlZ1UUdi?=
 =?utf-8?B?aGlDZUJ6ZERkYTQ3VHFvQW0yaEtCQlF6T3U0MmhLMFFObjFVVlZqMUk0c0RO?=
 =?utf-8?B?RTAzL2srYVdRR2EvMGJ6bCtSL0RGRGVyaXFGUEsxcm12MVAzNHhqUk1vSEFD?=
 =?utf-8?Q?vzlmmpP02T0dTEATZcXgw9030acnSGvgrRhncvN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEM1OURhMnE3dHpNMVFGNUNhRmM2allUU2lQMkxNWGY2RnZZVkI1NGZyMERw?=
 =?utf-8?B?SnZMWmd6ck9YaWduMFdjQXRVMFN2K0h2OGtwSlJSK0NvdEpOaTd6NmIxKy8x?=
 =?utf-8?B?RkJXQVc4dEtCM1d5Y2hJcDdPWHdyMGJONnRMR1BkTSs0RS94QStHdjJFWDVu?=
 =?utf-8?B?Rm8vbEFZa2YxWlZGakpJM0RkSkd2TUZLRXhPZ0llNTRYUmFjK3E4bzF0c1Fo?=
 =?utf-8?B?MEJFWGs4ZkdYZmVMQU1qWmEvNUtrV25XV1dpcHJwZVlPa28rdnBveUcwQk03?=
 =?utf-8?B?SHZTZmRQcGdQR0tPclZiZjJuWXFyS1FwaEJXTWtUN0dtR3d5OXpWcVRyNlpT?=
 =?utf-8?B?anNaY1F5dGp4VURsU2xDK1E5c0RzUWtiMzFSV0hocUdaWWNDcWhiWUFQNXZD?=
 =?utf-8?B?cTYwTmRJR0JWRlQ0bi9zNmt5NCtwdXhESmQ0WWRVa3ZlSE5KTUc1K2pFS3Fo?=
 =?utf-8?B?L3FTMUxCYktjaUNIcDVMN2hTUkVTY0hUZmZzUHhDdm1qT0pRajRlck5WbVRX?=
 =?utf-8?B?QXI0dTBTaXcvMGk0UTZKeVRxMU9FRk1YYTRvMkRCS0taMHFHdEV6Y2JyLzU2?=
 =?utf-8?B?eE1aajRCbDlNdUQ2L1I3RkFHOWd6UHJUNGVDS2ppU29yNFc1NThVcWVsOTRu?=
 =?utf-8?B?cS9Kd3dIK3lmcE9VR0l1MTVBOHhzdHRIckN5dlNwT3FxdHhMSEpNQzUwTDUz?=
 =?utf-8?B?S3pxMzZNNkZnRDYzY05EK1Q4ZFNXZlo3MHRPSjVtdjAzbXpQa0tlT0RtdGtP?=
 =?utf-8?B?S01RWmFwdVNIa0RaekJESGcyTjBmSWp6UW9TWUZIb3ArYnpXTWNRaTNQOEM1?=
 =?utf-8?B?Y2FYdDFPYWFSL1ZMK0UyWnUyYnN0QmJKR0lHb3VKQUxQZ1JzWEtzU2d4cDNK?=
 =?utf-8?B?T3dCSDBoWERhYUN6REhTZ1VmL01aQi9weThPT1FweXpBdGVxdkR5ek1UMXlL?=
 =?utf-8?B?MGZiMFdOdVdVblRUdGwzSE9pY0FhMVJwNGNQaGtGN3Z4ekF0cVlVczB6YytL?=
 =?utf-8?B?WktNQ1N6UVVIYWUwMHE2S0NiSUlhYWNxd3pkdTViT3k2WFFPT2dpdHJrUmRk?=
 =?utf-8?B?bjJYejlISFM3VWplN3pCQ1psRHR2UTMvNS8xRVFWNTRadkdwYzFjdnVxb2dG?=
 =?utf-8?B?TlRvZXhXTTgvM0tkTjRhbSt5Q3lxTEJVSk9seXp0Wis1R1U4NlU4TU96QnVn?=
 =?utf-8?B?YS94SXQ0TWNYeVU4Vzc5VUUxSm1OVGYzOE00OGRtbGUrcDdUcTU0cUhWM3Jp?=
 =?utf-8?B?S0VRdWZwd0N2QzJSRnFTbFhWbGkvV1RRczEwOUxOUjZReFVKMENKZDVlY0xl?=
 =?utf-8?B?aGVyZlI0bmptdU41TDVlQS9QK1FMOERTODB0cS8rTzRPT29YWnpXelZubUh5?=
 =?utf-8?B?WVJLeUMrRmtEMU5iOFhEaW5rZEdac1RjYjBmVnBpQkdTRmtyZ0NTd1lnY1hw?=
 =?utf-8?B?RmJVRDVxNnJmVkZDbEtCbTJ1TWZCRTFPWVBSRFFjOFY3RmovazlIYkVoQ1B5?=
 =?utf-8?B?Wnk5eDdib0k4cE5oMjRFSjRMR3pRbWltU0kzUkZOOFVGNm9EdjBCUnBVNTky?=
 =?utf-8?B?Ui9xaUE3cHhiVzk2RWZpVFhYa2dBMkV6VDVRQlBQNUlCOFl3ZkdnMi94RGNt?=
 =?utf-8?B?VUlCOWpOUDg5Ym5iZkdwWVRuSVZpR1M1Q0lyOWNaNU55dkZIcnRCVk92N0p1?=
 =?utf-8?B?QVJlQWNnc1Y1dktxS29qMUNZZ00weVV4WGV0eDJhWlRhMlROVm5HNGlteHdl?=
 =?utf-8?B?Q3kvUzFOczcwS2dIVmRnUFFsMm56T1NLWVpXWXpEYnVUZndJU2lmWVMyU1Uy?=
 =?utf-8?B?N0JubTRTUVBzWThKVjliZTMwU1hNbERWa0V3aTZTcnMvY1dNUW1Ebm1wS3Mw?=
 =?utf-8?B?b1FKZE1WTDNVVE5oeGpnN0xqTnBPZm41NjFVZ0Z1LzFoT01LQ0JLdXJaekx2?=
 =?utf-8?B?Vzk0WXlhWVpLUE5iVnRaaGpxaXpoMzU4Zm9lYmRTMm8vQjgveHR2Z0Vmam5G?=
 =?utf-8?B?c0N3Q0VEc1c5dzFVUU1JM0tTUTFUYWNMTU5Da3NReVNmK3oxVXg2SFV0QmZz?=
 =?utf-8?B?Mk9YWXNZU2dJWlF0NlBYQ05hR0pDYzNDZDJjajNnYkgzVjFNbUg2alBDUzJQ?=
 =?utf-8?B?bHluZ2pzUFZqU0laVVBmd1NzOS9MeGRac0FhZE1ZNEZieTdhc3ZRdGlKMDNC?=
 =?utf-8?Q?OK8wQWvgn/5jp0Y9ji90qC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D6DF92AFC9FA64D8DC6166320DD32AE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c3821f-a048-4bab-973c-08dc91b2b354
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:26:27.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28fl2WNnoTUZIUoGQM7RuMkSp0Yb2JEmFQ5ojx7tkjIT59KoPcJQM7VisJmuBowruOaWBnLICVKPGbTgbR6ekf0blNI9uRrlDUr6FwcAaKBl8WU9lMfZQY0AL8MW74sK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9684
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 84.198.128.222
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: VI1PR07MB9684.eurprd07.prod.outlook.com

DQoNCkxlIDIwLzA2LzIwMjQgw6AgMjM6MjEsIEhlbGdlIERlbGxlciBhIMOpY3JpdCA6DQo+IFtW
b3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIGRlbGxlckBnbXguZGUu
IETDqWNvdXZyZXoNCj4gcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgDQo+IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IE9uIDYvMjAvMjQg
MTg6MjMsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPj4NCj4+IFRoZSBzeXNfZmFub3RpZnlfbWFyaygpIHN5c2NhbGwgb24gcGFy
aXNjIHVzZXMgdGhlIHJldmVyc2Ugd29yZCBvcmRlcg0KPj4gZm9yIHRoZSB0d28gaGFsdmVzIG9m
IHRoZSA2NC1iaXQgYXJndW1lbnQgY29tcGFyZWQgdG8gYWxsIHN5c2NhbGxzIG9uDQo+PiBhbGwg
MzItYml0IGFyY2hpdGVjdHVyZXMuIEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgcHJvYmxlbSBp
cyB0aGF0DQo+PiB0aGUgZnVuY3Rpb24gYXJndW1lbnRzIG9uIHBhcmlzYyBhcmUgc29ydGVkIGJh
Y2t3YXJkcyAoMjYsIDI1LCAyNCwgMjMsDQo+PiAuLi4pIGNvbXBhcmVkIHRvIGV2ZXJ5b25lIGVs
c2UsDQo+DQo+IHIyNiBpcyBhcmcwLCByMjUgaXMgYXJnMSwgYW5kIHNvIG9uLg0KPiBJJ20gbm90
IHN1cmUgSSB3b3VsZCBjYWxsIHRoaXMgInNvcnRlZCBiYWNrd2FyZHMiLg0KPiBJIHRoaW5rIHRo
ZSByZWFzb24gaXMgc2ltcGx5IHRoYXQgaHBwYSBpcyB0aGUgb25seSAzMi1iaXQgYmlnLWVuZGlh
bg0KPiBhcmNoIGxlZnQuLi4NCg0KcG93ZXJwYy8zMiBpcyBiaWctZW5kaWFuOiByMyBpcyBhcmcw
LCByNCBpcyBhcmcxLCAuLi4gcjEwIGlzIGFyZzcuDQoNCkluIGNhc2Ugb2YgYSA2NGJpdHMgYXJn
LCByMyBpcyB0aGUgaGlnaCBwYXJ0IGFuZCByNCBpcyB0aGUgbG93IHBhcnQuDQoNCkNocmlzdG9w
aGUNCg0KPg0KPj4gc28gdGhlIGNhbGxpbmcgY29udmVudGlvbnMgb2YgdXNpbmcgYW4NCj4+IGV2
ZW4vb2RkIHJlZ2lzdGVyIHBhaXIgaW4gbmF0aXZlIHdvcmQgb3JkZXIgcmVzdWx0IGluIHRoZSBs
b3dlciB3b3JkDQo+PiBjb21pbmcgZmlyc3QgaW4gZnVuY3Rpb24gYXJndW1lbnRzLCBtYXRjaGlu
ZyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3INCj4+IG9uIGxpdHRsZS1lbmRpYW4gYXJjaGl0ZWN0dXJl
cy4gVGhlIHN5c3RlbSBjYWxsIGNvbnZlbnRpb25zIGhvd2V2ZXINCj4+IGVuZGVkIHVwIG1hdGNo
aW5nIHdoYXQgdGhlIG90aGVyIDMyLWJpdCBhcmNoaXRlY3R1cmVzIGRvLg0KPj4NCj4+IEEgZ2xp
YmMgY2xlYW51cCBpbiAyMDIwIGNoYW5nZWQgdGhlIHVzZXJzcGFjZSBiZWhhdmlvciBpbiBhIHdh
eSB0aGF0DQo+PiBoYW5kbGVzIGFsbCBhcmNoaXRlY3R1cmVzIGNvbnNpc3RlbnRseSwgYnV0IHRo
aXMgaW5hZHZlcnRlbnRseSBicm9rZQ0KPj4gcGFyaXNjMzIgYnkgY2hhbmdpbmcgdG8gdGhlIHNh
bWUgbWV0aG9kIGFzIGV2ZXJ5b25lIGVsc2UuDQo+DQo+IEkgYXBwcmVjaWF0ZSBzdWNoIGNsZWFu
dXBzIHRvIG1ha2UgYXJjaGVzIGNvbnNpc3RlbnQuDQo+IEJ1dCBpdCdzIGJhZCBpZiBicmVha2Fn
ZXMgYXJlbid0IG5vdGljZWQgb3IgcmVwb3J0ZWQgdGhlbi4uLg0KPg0KPj4gVGhlIGNoYW5nZSBt
YWRlIGl0IGludG8gZ2xpYmMtMi4zNSBhbmQgc3Vic2VxdWVudGx5IGludG8gZGViaWFuIDEyDQo+
PiAoYm9va3dvcm0pLCB3aGljaCBpcyB0aGUgbGF0ZXN0IHN0YWJsZSByZWxlYXNlLiBUaGlzIG1l
YW5zIHdlDQo+PiBuZWVkIHRvIGNob29zZSBiZXR3ZWVuIHJldmVydGluZyB0aGUgZ2xpYmMgY2hh
bmdlIG9yIGNoYW5naW5nIHRoZQ0KPj4ga2VybmVsIHRvIG1hdGNoIGl0IGFnYWluLCBidXQgZWl0
aGVyIGhhbmdlIHdpbGwgbGVhdmUgc29tZSBzeXN0ZW1zDQo+PiBicm9rZW4uDQo+Pg0KPj4gUGlj
ayB0aGUgb3B0aW9uIHRoYXQgaXMgbW9yZSBsaWtlbHkgdG8gaGVscCBjdXJyZW50IGFuZCBmdXR1
cmUNCj4+IHVzZXJzIGFuZCBjaGFuZ2UgdGhlIGtlcm5lbCB0byBtYXRjaCBjdXJyZW50IGdsaWJj
Lg0KPg0KPiBBZ3JlZWQgKGFzc3VtaW5nIHdlIGhhdmUgcmVhbGx5IGEgcHJvYmxlbSBvbiBwYXJp
c2MpLg0KPg0KPj4gVGhpcyBhbHNvDQo+PiBtZWFucyB0aGUgYmVoYXZpb3IgaXMgbm93IGNvbnNp
c3RlbnQgYWNyb3NzIGFyY2hpdGVjdHVyZXMsIGJ1dA0KPj4gaXQgYnJlYWtzIHJ1bm5pbmcgbmV3
IGtlcm5lbHMgd2l0aCBvbGQgZ2xpYmMgYnVpbGRzIGJlZm9yZSAyLjM1Lg0KPj4NCj4+IExpbms6
DQo+PiBodHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC8/cD1nbGliYy5naXQ7YT1jb21taXRkaWZm
O2g9ZDE1MDE4MWQ3M2Q5DQo+PiBMaW5rOg0KPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvaGlzdG9yeS9oaXN0b3J5LmdpdC9jb21taXQvYXJjaC9wYXJp
c2Mva2VybmVsL3N5c19wYXJpc2MuYz9oPTU3YjFkZmJkNWI0YTM5ZA0KPj4gQ2M6IEFkaGVtZXJ2
YWwgWmFuZWxsYSA8YWRoZW1lcnZhbC56YW5lbGxhQGxpbmFyby5vcmc+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPj4gLS0tDQo+PiBJIGZvdW5kIHRo
aXMgdGhyb3VnaCBjb2RlIGluc3BlY3Rpb24sIHBsZWFzZSBkb3VibGUtY2hlY2sgdG8gbWFrZQ0K
Pj4gc3VyZSBJIGdvdCB0aGUgYnVnIGFuZCB0aGUgZml4IHJpZ2h0Lg0KPg0KPiBUaGUgcGF0Y2gg
bG9va3MgZ29vZCBhdCBmaXJzdCBzaWdodC4NCj4gSSdsbCBwaWNrIGl0IHVwIGluIG15IHBhcmlz
YyBnaXQgdHJlZSBhbmQgd2lsbCBkbyBzb21lIHRlc3RpbmcgdGhlDQo+IG5leHQgZmV3IGRheXMg
YW5kIHRoZW4gcHVzaCBmb3J3YXJkIGZvciA2LjExIHdoZW4gaXQgb3BlbnMuLi4uDQo+DQo+IFRo
YW5rIHlvdSEhDQo+DQo+IEhlbGdlDQo+DQo+PiBUaGUgYWx0ZXJuYXRpdmUgaXMgdG8gZml4IHRo
aXMgYnkgcmV2ZXJ0aW5nIGdsaWJjIGJhY2sgdG8gdGhlDQo+PiB1bnVzdWFsIGJlaGF2aW9yLg0K
Pj4gLS0tDQo+PiAgIGFyY2gvcGFyaXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8IDEg
Kw0KPj4gICBhcmNoL3BhcmlzYy9rZXJuZWwvc3lzX3BhcmlzYzMyLmMgICAgICAgfCA5IC0tLS0t
LS0tLQ0KPj4gICBhcmNoL3BhcmlzYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwgfCAyICst
DQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wYXJpc2MvS2NvbmZpZyBiL2FyY2gvcGFyaXNjL0tj
b25maWcNCj4+IGluZGV4IGRhYWZlYjIwZjk5My4uZGM5YjkwMmRlOGVhIDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC9wYXJpc2MvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9wYXJpc2MvS2NvbmZpZw0KPj4g
QEAgLTE2LDYgKzE2LDcgQEAgY29uZmlnIFBBUklTQw0KPj4gICAgICAgc2VsZWN0IEFSQ0hfSEFT
X1VCU0FODQo+PiAgICAgICBzZWxlY3QgQVJDSF9IQVNfUFRFX1NQRUNJQUwNCj4+ICAgICAgIHNl
bGVjdCBBUkNIX05PX1NHX0NIQUlODQo+PiArICAgICBzZWxlY3QgQVJDSF9TUExJVF9BUkc2NCBp
ZiAhNjRCSVQNCj4+ICAgICAgIHNlbGVjdCBBUkNIX1NVUFBPUlRTX0hVR0VUTEJGUyBpZiBQQTIw
DQo+PiAgICAgICBzZWxlY3QgQVJDSF9TVVBQT1JUU19NRU1PUllfRkFJTFVSRQ0KPj4gICAgICAg
c2VsZWN0IEFSQ0hfU1RBQ0tXQUxLDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wYXJpc2Mva2VybmVs
L3N5c19wYXJpc2MzMi5jDQo+PiBiL2FyY2gvcGFyaXNjL2tlcm5lbC9zeXNfcGFyaXNjMzIuYw0K
Pj4gaW5kZXggMmExMmE1NDdiNDQ3Li44MjZjOGU1MWI1ODUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3BhcmlzYy9rZXJuZWwvc3lzX3BhcmlzYzMyLmMNCj4+ICsrKyBiL2FyY2gvcGFyaXNjL2tlcm5l
bC9zeXNfcGFyaXNjMzIuYw0KPj4gQEAgLTIzLDEyICsyMywzIEBAIGFzbWxpbmthZ2UgbG9uZyBz
eXMzMl91bmltcGxlbWVudGVkKGludCByMjYsIGludA0KPj4gcjI1LCBpbnQgcjI0LCBpbnQgcjIz
LA0KPj4gICAgICAgICAgICAgICBjdXJyZW50LT5jb21tLCBjdXJyZW50LT5waWQsIHIyMCk7DQo+
PiAgICAgICByZXR1cm4gLUVOT1NZUzsNCj4+ICAgfQ0KPj4gLQ0KPj4gLWFzbWxpbmthZ2UgbG9u
ZyBzeXMzMl9mYW5vdGlmeV9tYXJrKGNvbXBhdF9pbnRfdCBmYW5vdGlmeV9mZCwNCj4+IGNvbXBh
dF91aW50X3QgZmxhZ3MsDQo+PiAtICAgICBjb21wYXRfdWludF90IG1hc2swLCBjb21wYXRfdWlu
dF90IG1hc2sxLCBjb21wYXRfaW50X3QgZGZkLA0KPj4gLSAgICAgY29uc3QgY2hhciAgX191c2Vy
ICogcGF0aG5hbWUpDQo+PiAtew0KPj4gLSAgICAgcmV0dXJuIHN5c19mYW5vdGlmeV9tYXJrKGZh
bm90aWZ5X2ZkLCBmbGFncywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAoKF9fdTY0KW1hc2sx
IDw8IDMyKSB8IG1hc2swLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICBkZmQsIHBhdGhuYW1l
KTsNCj4+IC19DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wYXJpc2Mva2VybmVsL3N5c2NhbGxzL3N5
c2NhbGwudGJsDQo+PiBiL2FyY2gvcGFyaXNjL2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsLnRibA0K
Pj4gaW5kZXggMzllNjdmYWI3NTE1Li42NmRjNDA2YjEyZTQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3BhcmlzYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbC50YmwNCj4+ICsrKyBiL2FyY2gvcGFyaXNj
L2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsLnRibA0KPj4gQEAgLTM2NCw3ICszNjQsNyBAQA0KPj4g
ICAzMjAgY29tbW9uICBhY2NlcHQ0ICAgICAgICAgICAgICAgICBzeXNfYWNjZXB0NA0KPj4gICAz
MjEgY29tbW9uICBwcmxpbWl0NjQgICAgICAgICAgICAgICBzeXNfcHJsaW1pdDY0DQo+PiAgIDMy
MiBjb21tb24gIGZhbm90aWZ5X2luaXQgICAgICAgICAgIHN5c19mYW5vdGlmeV9pbml0DQo+PiAt
MzIzICBjb21tb24gIGZhbm90aWZ5X21hcmsgICAgICAgICAgIHN5c19mYW5vdGlmeV9tYXJrDQo+
PiBzeXMzMl9mYW5vdGlmeV9tYXJrDQo+PiArMzIzICBjb21tb24gIGZhbm90aWZ5X21hcmsgICAg
ICAgICAgIHN5c19mYW5vdGlmeV9tYXJrDQo+PiBjb21wYXRfc3lzX2Zhbm90aWZ5X21hcmsNCj4+
ICAgMzI0IDMyICAgICAgY2xvY2tfYWRqdGltZSAgICAgICAgICAgc3lzX2Nsb2NrX2FkanRpbWUz
Mg0KPj4gICAzMjQgNjQgICAgICBjbG9ja19hZGp0aW1lICAgICAgICAgICBzeXNfY2xvY2tfYWRq
dGltZQ0KPj4gICAzMjUgY29tbW9uICBuYW1lX3RvX2hhbmRsZV9hdCAgICAgICBzeXNfbmFtZV90
b19oYW5kbGVfYXQNCj4NCg==

