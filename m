Return-Path: <linux-fsdevel+bounces-26153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE89551DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B8DB20E97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5461C579D;
	Fri, 16 Aug 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BSaAijJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5231C27;
	Fri, 16 Aug 2024 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840130; cv=fail; b=X2QWUvlfCPGREd8kpocv2NL31WeaLeMbQ/K6pfOHT4F0Q8lr5nSvufyyxeUc4N0UwywhtNfhRFvOw/9DgKIlzypvEkmgV2QiOOUXMwBgp369b6uAJUkikShuSQDxfbynJMck4OlDNiNL/KvfQ1hojzD7C2J/O0zKh6IX1KnDFLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840130; c=relaxed/simple;
	bh=is/OEV6lSd1R2DyBx7fSQXKkeflWPjgA5Es4ARv55ms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXwxi46eioPlDtLwX4qNuuz2ilE59MSnEZEXOiAo6ddSRXOzN0AtrbRYsRE27Kl2JbaOpu5D/7Lh5SPVXL2zm36O8J5tf+4h0qNP5/pCuf3UDVOY1UZUhI1WLQlmwz8Qn9LIvFhkyD5V9rwL+APLHRercAkeWy87h1/7SXh3BGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BSaAijJN; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GJLBnb022157;
	Fri, 16 Aug 2024 20:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mT11hHlOMFmYUjmcvT/oA2J9+yYNu/mfj9erMEw/K7M=; b=BSaAijJNmjDAE1Qc
	zwnZ5WgB+QdSW2NEr7w9nqqW//kZLF+6TAh4I+PdnSnX1sJozSLIapmQQvKD9xLQ
	DGWy1C7P2VoSkgvn0SmiX74nohHluy75Yr9eVyxJhDD4e5DW/H93w5nR5/XozwR/
	iH1CyijcaH407+Ah9W7ASiH6pDXAZmk8ZXM6iIlIHehKP1olfO5e9al6jtxf3yo8
	rnulknquhqAUOYGc71VAWvWsLO94afrftUXy2820lDHAGi2lMjG/QXOAylGkGYCc
	5UROQrEIbsEllEvXru45eBZGkODu1Veb2ozWUZUG1gpBO3/Qh+V7E6Qzz9n4EClx
	KoMC5A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412bqe8cc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 20:27:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFGR10JUVBp5TSFnTORurwW/9tZpbxlPJIm0P+aiD3dhsi6BnUxFCqkRjO1mvdoknVJ2sAVQx1wKx6k9/Ef/IpuTwOpQMrE0I213pGE/U6qClUvy6WlXFU21A0/Bw+lhwwcmkmg8HDMGqoDPy4x9EAfcU8b5nFSez3UmHMvE0RoapyCW2cZ/Q461wenNkgErAsQDC0aGWPrPTdoTw5ppciduXTggtf7cn1Z81VMZMq3sAkIvsOsbWdZvcZDgDBhaZFxmU3XMDMo6B0A6uFgi73JWh3Hyg6Q4LwlMGT6eSLB3o8HWvC0FLXwaMtmI9FGGAiT5mUesJogsjH2sBxqzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT11hHlOMFmYUjmcvT/oA2J9+yYNu/mfj9erMEw/K7M=;
 b=jPf4XIuXzBEETesko569xmdtoCEQeDw6MAwqcmosa9H8lbUsDhhNEE4VNQRcOPKsjYSUOQNQm+bDm0dTU2mZDqhXRZ4mBJ3xhRer42wG/ZsmGfZZzQ452bwXoxKiFlJxsn7PeLZmTx3EO+v00i/IBKVQxJ/HCXC+UG2qK7btdXHPQHccZoPfpy3gKUFAMQVsS03ea3YcAw+fNxJEPXuvJJX28+Klxa1yrqCq5a5HCVjR26ssl5yIHg6sG+jdS3/u9xCmby1Is8f8UVahAm+MLKGA9wxuS549rJHtk0D+rkLKeBjiXYvBXZBAwsSgNHQ8B0nxq/IbQ4EKSp1E7jUisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CH3PR02MB10153.namprd02.prod.outlook.com
 (2603:10b6:610:195::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 20:27:30 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 20:27:30 +0000
From: Brian Cain <bcain@quicinc.com>
To: Arnd Bergmann <arnd@kernel.org>,
        "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Michael Ellerman
	<mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Guo Ren
	<guoren@kernel.org>,
        "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Rich Felker
	<dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "H. Peter Anvin"
	<hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "libc-alpha@sourceware.org"
	<libc-alpha@sourceware.org>,
        "musl@lists.openwall.com"
	<musl@lists.openwall.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 09/13] csky, hexagon: fix broken sys_sync_file_range
Thread-Topic: [PATCH v2 09/13] csky, hexagon: fix broken sys_sync_file_range
Thread-Index: AQHaxlTwF2LstnDJtUq+N6pFZE3dlrIqqHnw
Date: Fri, 16 Aug 2024 20:27:30 +0000
Message-ID:
 <CH3PR02MB10247E03891A370B0721648E1B8812@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240624163707.299494-1-arnd@kernel.org>
 <20240624163707.299494-10-arnd@kernel.org>
In-Reply-To: <20240624163707.299494-10-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CH3PR02MB10153:EE_
x-ms-office365-filtering-correlation-id: ebc3cff4-c0cb-4ffa-1a48-08dcbe31da42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?txMvJcGetuSqgQmVNTHazoVVwncOukb7AGgRk3B/xQdxFZ89TzFFXnDIA75e?=
 =?us-ascii?Q?jVuaz32qNyTTfE+SzSKkV5xt3T+Ne0cbLsSY8KWQA7j0pfLukl3A+FvOmPaP?=
 =?us-ascii?Q?jXYvmKLnEMAI4oS/wlJ3dmR80J70BeeKksXHi7JCIeBT3lVS4Rt20aJIuMFq?=
 =?us-ascii?Q?4SxCfxr6loaUx8vTQ2bb3oXlPwiW+bn/qB0tXl1u9PZnrJJU0aSg0Wit0Axo?=
 =?us-ascii?Q?awgjCr9N/q2pHhaQYv1IwZd1l/7t52OhtU4YgDCu6jTZa0R7aP0eDICN+IDl?=
 =?us-ascii?Q?dez5ADenkDyMdF8JDxmD2RLAP7sWF/Z8xq4eyrfMEDWjzIwGOYosmNhKRyX7?=
 =?us-ascii?Q?xkxXBp/i+wex4OUHwk0y7CjouA8V2a/HNG8a1P5YaaZk+vnNXZFdRD5CtaSL?=
 =?us-ascii?Q?phLbF/S0zCLTSxdEJlHsHDGync68JTvll5xhP2OdGW0bUZa0aekU77NsunGZ?=
 =?us-ascii?Q?T1vSgm5CwAYLNVw4I3DRfEmAUigMIBGiI3eQcAyA3ggFFGUFWm4ci9lEOdl9?=
 =?us-ascii?Q?EZmIFDbAyvCKLkzCVw3Jy8E9rWysOaDWb+6+gTTsY4NnfIF5LgM55r+DQIbe?=
 =?us-ascii?Q?I8xiGBMAZUvHiEeHIitsaOaXHeT4v+y1bplIrmNr6v9p8+EPyYjTH00sTcYN?=
 =?us-ascii?Q?c/NwWCNgp1bXjxrBezw/YYtGmLmulMmgFIs0A5LDAPOrtweygSpHkXzOr60p?=
 =?us-ascii?Q?u1xH5o2nCE9rk/1XPtqcDcBFlqfSVA1KG5o9b2xZAUFYnyuerUDMaCD3Qm/S?=
 =?us-ascii?Q?r/U2oKKT4PMHXozC5DBevjvW/hy8XW6kzcga3kKu76kXIoAu9FKmaMUhO1FY?=
 =?us-ascii?Q?mAKb7eMk35bBJJVOK0x1Y8WBl3pS871DSmSx73eKI9JnxjbVU9ttWV3zX1ZY?=
 =?us-ascii?Q?0Zs7G2xJPqPsyALGVKqiYY3mpLqdjfU+t0mj6XwFp/T5XqaSsG5wSmJ00Vaa?=
 =?us-ascii?Q?ocxVI1Fw+EKryTsm1Msv9aTdjV7OIaxl0HVeWdGgzLGx+0BZ1NBsN8i8Hd60?=
 =?us-ascii?Q?WPU0jRCZQxcpLDXy/sy0B6vdZrMHVrsBYXIfCz3SX0osDG5vnm7JwxjqB7BA?=
 =?us-ascii?Q?k6GOOFE4CASNsggISAHsGeQiC4zPjlJU1xx306qYhxepjT8n8iVAlJ3Fszvl?=
 =?us-ascii?Q?v+69UxMdbO1ni1n0zQ5WIrGhaku6LPQk63DpWP2Y41KHgSw6CyR8klKnHRWD?=
 =?us-ascii?Q?0uv9TVyODD3gt9kzOJunAGtZqIufQPD9G3JH93ZlJw2XT8obpb2ZtSH30oJm?=
 =?us-ascii?Q?/BiDJfgfofQrH5bqGlVVWxopF2jr4V1C56y+rMtqgME+4rXtqN7OGtoK9nI2?=
 =?us-ascii?Q?Sza65Q+do9zXFAMm4PDv0bq1+JF/oyepB98NF2D0NxnsY/0hyVkmqDKxzAO6?=
 =?us-ascii?Q?++U957gBK+B7jQGj8uF1JxvYAuEsCZk5+/hB7oftJa5D1rXLRA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UA57RS6B/4UavXOoDN95VWIUFHKdCfSepCAdzAnOxQyDOj5WTWl4MJ5wyeEH?=
 =?us-ascii?Q?rM3TQCgv5usO4uGcN4kxImd261auLrlMjh8JpAtcs5nKIpsQJMsDgXEUvQ5h?=
 =?us-ascii?Q?SpLBNkjs4XHHKhLKUUdN/1/4+usWNWh4twGUuLrGxEhHW6xd3QiBU4HVtv0G?=
 =?us-ascii?Q?je9L9IXaB5RtEa9T7p2PfNmBgWX9s3apX01FNg0/QlLRUkvBjo1LSpQbqite?=
 =?us-ascii?Q?EczeF7taykdZdCPlAUP3/0gI98Q51NZDIn2j0Ax4VnYRHL5/pwXU+Dp2JLHN?=
 =?us-ascii?Q?yItX1mD/Xlfvu68Ksl+ThltLj7Z0KX+f8DuetVElATc9tYHHI9wqSH1aGN3J?=
 =?us-ascii?Q?1aIKLIT+21m6iuMvachCui6u6gUEOxphCE6f3XzH7R7z3oJ1oc7ELBFfFmLn?=
 =?us-ascii?Q?YDPCJdGcn705IQiCi61JGD5pVLAv1u4zADj4OnKFFV1mp4So0lg2UU/YIPiU?=
 =?us-ascii?Q?S3uqaMpTwa/G3WSot7626U6iiupDv6TO04z4U5oJReb9upA6UBT/pgA3ksk2?=
 =?us-ascii?Q?yg7RMER1LhL6KYkJXhJtRFlL1jWLFqGWI+HYWpH2VUcrYPnpUQsZIwCaCqoS?=
 =?us-ascii?Q?IyKpC7dJ/Kk7B4jKzTg7iDNJ1eI06uW4udaxwZCXpahHySMUfkxbkuk5d3LT?=
 =?us-ascii?Q?D6B4Z0wH+wayNpw3w2g7BYQnql6uCc3iigtDn+2a/RwVuHJ9cniff0ZAWKWJ?=
 =?us-ascii?Q?zg4JlsuxnTkPD5UeUcg5zm5njppx+8xHQIVzbbe0v8xifwwYzoyLLpAZwTn9?=
 =?us-ascii?Q?Ckyf1SJX/ZNyiOHtqDEDvv8e28RbSqOhsZETig59uA4wGrtE18uXumVIArFG?=
 =?us-ascii?Q?aAeO6F5sjFSBhEXKDgGKKKm031Em6aTof5LI7+elfz7gZrJKzLqLk7okHXbC?=
 =?us-ascii?Q?SdMBSNm5VhnLNPu7qE7Cb7Q1ycVWtygNcGe8vGUGdvgIQJpAcd7aPe/wzu33?=
 =?us-ascii?Q?5GjuZRGwAK+c9LsXWcTS5YJfnqyMysp+8Ws1gaFHF+glXgGoppgLZ+OXzx+H?=
 =?us-ascii?Q?IFZ/b/SLckffAPlLfpvxdDfPt17ZejXI7hlLHExkxfEmCz0avlZy91GK4qGU?=
 =?us-ascii?Q?8XdifBeAIUciZOUvFK7GxRTSHIPV/Qqf2o68PVNB6A9ulWG0WXFElWA07iPq?=
 =?us-ascii?Q?4FU30stW5FPJ0psnHp0mng10b/ka6ZrMxeo4czxcbJSlwKIusRuTqguu5lK9?=
 =?us-ascii?Q?1YBVPNhLgcylwHbqhCxzm56cn9e4HgkhFmlpkrXL1g7AdnTI36HAUMWjy0CO?=
 =?us-ascii?Q?6zd1Rf24DQCufYJ+5fUlHM4q0n7YCdta93vZJI5SO4Zn6C6xtIYUjZE34bks?=
 =?us-ascii?Q?P0UCFFYRH82W9Q8EeDEKEKD63hgG9YdwfUi9j5XwFVaoKZ8ZrE1hdJlZgpKf?=
 =?us-ascii?Q?ByKhy9s+JDYuKrA/fV4zkHovMKduhrHUp1I9JjYUeG7lOGYezfLVY60dXsiM?=
 =?us-ascii?Q?iJKejojkzsvt09Oi7j+qEK+Fz2KvvNeZ14Uz/PgaYIC3/lP8V1nNwO/JD69k?=
 =?us-ascii?Q?5yapsQeOqXTTc381KrKcyiiAAUSFgj8ktabSCYx+oF6ZD1kymsTlXdRrwGeV?=
 =?us-ascii?Q?Tpin3dDAaBURIU841esRo+Bnk2I8MC+wKHtqMgLz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/56sKNiGJbhe3oPIg+IDGQMCO9Hb4dl7lO6Z2Cko6d94QKR5CvBtB3CS7M2QmsbEtDLDw60+w1YWUevHvYViqNkq8Md4NbzeEAyMaIUoBCtib6UjBhSUwZLoinj+7UTehW+chx/Ak9Sod3hOvxV+shMj9B7RpX8UPzI06U6GoVhpjCiPGZ+qpLMaq4t/CX3FKfD+KE99XXzuA50PlLbMSJ9RyHwovqFPHmLDxXARdz2qY/SeC29AF5v4u08AjzzFvJLDv3MHH+mZr853JvAXZD5GDVfdDkA/d/UnMsTr4275lLaNh1EVf6vCLlxY0nC3hrpNu7AhHJeo8DdrT6gyYmX5nphtrAIUwftp0fFjUEqQLbvcUTXXgxABixIs/z8qvdQdUtCbDueLaWCgHKORnPJVB5ZxqRNaUEX7spvvaOVkPTOT+2X4Ym4l5Aw5kW52qsEJ7nTNUyP8dkmzwa80UPOv/qepHAtbhuLUvqRBoFijeOcvOd1pgKKMPsyw9+CUWSn/Ujngj+HOnML6mK6IyFxiYqek66QoUC5jSacKs2a1HAlR1u1YHhLhAvuIevb59XS9qMcODn0sU1oivk5MCv3zXsP4kwSBI5Kuhzx+PuQpSdLk/Q5ifo4wK7NehUDg
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc3cff4-c0cb-4ffa-1a48-08dcbe31da42
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 20:27:30.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5vaSYR4vwlIGkH1Q6Bq2zi4gGIsz79xkBiHLjb9Pm+snU3+kAacwgvL3BpE9kDBOqXpczIvB9H8dvZXj1sWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10153
X-Proofpoint-GUID: K6Vq6vPhdeeh0pPvkJT723zGvuMuGaQC
X-Proofpoint-ORIG-GUID: K6Vq6vPhdeeh0pPvkJT723zGvuMuGaQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=956 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160145



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, June 24, 2024 11:37 AM
> To: linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>; Thomas Bogendoerfer
> <tsbogend@alpha.franken.de>; linux-mips@vger.kernel.org; Helge Deller
> <deller@gmx.de>; linux-parisc@vger.kernel.org; David S. Miller
> <davem@davemloft.net>; Andreas Larsson <andreas@gaisler.com>;
> sparclinux@vger.kernel.org; Michael Ellerman <mpe@ellerman.id.au>; Nichol=
as
> Piggin <npiggin@gmail.com>; Christophe Leroy
> <christophe.leroy@csgroup.eu>; Naveen N . Rao
> <naveen.n.rao@linux.ibm.com>; linuxppc-dev@lists.ozlabs.org; Brian Cain
> <bcain@quicinc.com>; linux-hexagon@vger.kernel.org; Guo Ren
> <guoren@kernel.org>; linux-csky@vger.kernel.org; Heiko Carstens
> <hca@linux.ibm.com>; linux-s390@vger.kernel.org; Rich Felker
> <dalias@libc.org>; John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.d=
e>;
> linux-sh@vger.kernel.org; H. Peter Anvin <hpa@zytor.com>; Alexander Viro
> <viro@zeniv.linux.org.uk>; Christian Brauner <brauner@kernel.org>; linux-
> fsdevel@vger.kernel.org; libc-alpha@sourceware.org;
> musl@lists.openwall.com; stable@vger.kernel.org
> Subject: [PATCH v2 09/13] csky, hexagon: fix broken sys_sync_file_range
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Both of these architectures require u64 function arguments to be
> passed in even/odd pairs of registers or stack slots, which in case of
> sync_file_range would result in a seven-argument system call that is
> not currently possible. The system call is therefore incompatible with
> all existing binaries.
>=20
> While it would be possible to implement support for seven arguments
> like on mips, it seems better to use a six-argument version, either
> with the normal argument order but misaligned as on most architectures
> or with the reordered sync_file_range2() calling conventions as on
> arm and powerpc.
>=20
> Cc: stable@vger.kernel.org
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/uapi/asm/unistd.h    | 1 +
>  arch/hexagon/include/uapi/asm/unistd.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/csky/include/uapi/asm/unistd.h
> b/arch/csky/include/uapi/asm/unistd.h
> index 7ff6a2466af1..e0594b6370a6 100644
> --- a/arch/csky/include/uapi/asm/unistd.h
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -6,6 +6,7 @@
>  #define __ARCH_WANT_SYS_CLONE3
>  #define __ARCH_WANT_SET_GET_RLIMIT
>  #define __ARCH_WANT_TIME32_SYSCALLS
> +#define __ARCH_WANT_SYNC_FILE_RANGE2
>  #include <asm-generic/unistd.h>
>=20
>  #define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> diff --git a/arch/hexagon/include/uapi/asm/unistd.h
> b/arch/hexagon/include/uapi/asm/unistd.h
> index 432c4db1b623..21ae22306b5d 100644
> --- a/arch/hexagon/include/uapi/asm/unistd.h
> +++ b/arch/hexagon/include/uapi/asm/unistd.h
> @@ -36,5 +36,6 @@
>  #define __ARCH_WANT_SYS_VFORK
>  #define __ARCH_WANT_SYS_FORK
>  #define __ARCH_WANT_TIME32_SYSCALLS
> +#define __ARCH_WANT_SYNC_FILE_RANGE2

Acked-by: Brian Cain <bcain@quicinc.com>

>=20
>  #include <asm-generic/unistd.h>
> --
> 2.39.2


