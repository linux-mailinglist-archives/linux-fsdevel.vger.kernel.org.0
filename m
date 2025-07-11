Return-Path: <linux-fsdevel+bounces-54628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF1B01AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FC83B4BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C702D3A66;
	Fri, 11 Jul 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ad/Y8a4I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c5VUUAaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890602D0C8F;
	Fri, 11 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234009; cv=fail; b=PhkCvfw8vrXU9yVsX5M+DJoxM9Nj9sR4nCOQR4aJsniv185tQGNJ/JCOSgjVivvT8333O9R+s2nZUJXK+lgKrU1cRaJvMwRMLMPOdGQZxXB9sx78xr7arY+TaRm0e4O86924A9gzTrmg6QVi3H9wPqkAOVWeo7UafR4Cn+i+bNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234009; c=relaxed/simple;
	bh=sFZT4EblRpt0eH25CEUzgR8m/nCDRghOM1XxqQRF9II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/PFCQzbM3WTlZNAsE34l5SdbLFuYl1mlQsWvxihfiYoANkNLoaiV7Jv9Gef1O/bRicEJz6IdVc9BPTUqi7LLDKdVZ/Or31YYzEPX8Wr15b/6bwmt4nmyIC8AbnATDqKFUuaGTcDwv/wiFvb9AG6WSgnLhTN31VWkI1NOXaDjqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ad/Y8a4I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c5VUUAaV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAvEB1005892;
	Fri, 11 Jul 2025 11:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=llKJ3LCOeO9Brv+R38YbDXfXDFNtAQPy+2QvxK/YSjA=; b=
	Ad/Y8a4IB0ZbkI/blUS5qAnbUxeaTj91R84hRKPGtRY5Tp9iVprE1emU+lmkXMhF
	drMGDE486gLiCuWdjSscLya0YgyYscwMVHoWkhog/NPCUIEeygCxMDd6ctTzQQYT
	pbJwNfAlX46CXBSZ9mz4FTT3PDLSIBsetAovdTdZBmrFway2eH0ZXkde+htUvQxo
	X2a8UyLAMR+5/dv9Kxzx6EmIoNBVDjWOdbdQpZ99MulCpw3aob2QrokMAI4RbmVD
	wGTP92ioJ7b/WFFq3zIndFHJJbQiGxPx8To60dDkt+5pZ86my5wyHqBi3p22f0b3
	GAq/bSk+/a9eBQCmmm3JcA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1abg1q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAXZaw013560;
	Fri, 11 Jul 2025 11:38:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge84d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAwey/Pk6d8/OfBWj6CEAbXya+vr7XsBu5WdQFK/dxV2KcN2Oblc/cSN9zxunKdKx8rkpRPysH7Cht/kCqphNmNa2E03hHTX4Z0LMFwZix/f2RdPKaZWrBrzF9uHVEuIAOeMSucX1Y2EOXIZNRZhsDJWm+emAyaTACQ0OHstIGgz/uk2IL2YHybRzDq7baG98sWgeyz/W+90cTwpcU/8k8vS07wN+KetWhuwhhGVdC2xhnbDQ4+BqzYKuHl+jHVaLaECyxk7pb8rGDoACRGGJ5/JM/LFFL5oFFt/UPP/e1btG+x7xwzs5YXN6rDLZ6IcvHKZ6n/f9LzdqFUQeKWPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llKJ3LCOeO9Brv+R38YbDXfXDFNtAQPy+2QvxK/YSjA=;
 b=iEtl0JhrueVRBCSPMMIZUx8+VKQfaSAL5b6a2jSsbFVpcA5JaMep9mCzuzRUh5tpXf33W3nC4BP61KyvqQhmbvFep3OgmKAzsY014D71VUwfaMJcSy+F9/HEyuh//7Pxq8ogtxdlP24Bd1xNyLIRF//pI0am/6IX4gWNqEDuVn0T6A8geCIMgkSdzF4NukZ30tMreU8xQkYnat81zYVUbyD9e35MdSS4nB/7hOkHAvyjRuaPkYE2egonp1pDjAsmHHRKmZrsddEwlRobygmOoY4QX1JMgc0atgGGyGCxrmlUgZ6+SRpfxVWVyL8cQe41cQezvWo5EtIqU/N3WgCQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llKJ3LCOeO9Brv+R38YbDXfXDFNtAQPy+2QvxK/YSjA=;
 b=c5VUUAaVIB9BkvrjkVhGbqwXkCCiIJqsLZxvXKHkh3Ikaxz9AkcGsVEcJwwRXqmEGGijwwJVCS9iENRP5WNCHFVEUyTdypbdyYOaGOXYs4q6GgRp4bDQvPDX/hNEVH3A69aVAIli/sHJjNNz8RO4VFspgff+7XxfO2y9hDnNV5s=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:48 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Fri, 11 Jul 2025 12:38:23 +0100
Message-ID: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e18bcb-93f7-4e7d-2418-08ddc06f8009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IV3KHlii5WobaydzlXxLTKFYNG0GzA4//WIlVN4WEIH3ekY0t6EaUkVpSz9R?=
 =?us-ascii?Q?BI4vJa3pAWejNx3oZj7MmLE04QDvsyq5ALEemrjKKTlxADxoT7Mio6WRPq2e?=
 =?us-ascii?Q?KGQqr9sd2phCoXP2JHslHFSVA1agFTy0u8EtTBoPmPH49wOVJQn/ZYxxZWb6?=
 =?us-ascii?Q?r/ehZNEhgd8RwLklbD//7eGefOpTMnuUA1Z+jBPqC2b5P1z5qlaGX4JLlrAd?=
 =?us-ascii?Q?n3JM1NVLmfDd0JOTEG8jwgFO24wxOEEWX69+jDCBPhiy3G1T70Xr306I1LRz?=
 =?us-ascii?Q?mb3nTYIIgiT251d+ePcHvqBCu4yaVpkrV/aKfI6NhnftFGe6l1fg/doEfF66?=
 =?us-ascii?Q?owmNgolbgze4OAFTRSC4cB2ZDswgBuL+DejvbYL0WrtZFoy2ckpjIHzPWpgc?=
 =?us-ascii?Q?JyTFhGetaUErovlGvZrOiLoADpxXDsiZPK+H9XvMIC6pjA9c+/sLScL5SBui?=
 =?us-ascii?Q?9/VSBWYfrdRC9Nk/gbRhJiCsdMTGa8C8jGHG4P6c1lbwADsEuJZKMMLb+If4?=
 =?us-ascii?Q?mUTffaSh1dhXfx4ZQU+qP5ez6VK/jqOaegm4+qUz3DP0QPHi4REqUaNYxy39?=
 =?us-ascii?Q?E8qufgJWz79hO3+GO3x4W+cS9thkt9+hVrXvojrOenuEQtxl87rh8d3cUztT?=
 =?us-ascii?Q?+C467ayC1R+3phnd98l22SPAR3DqPM6qXOjToLRpzribYsTuaE8ok6Fpv2tE?=
 =?us-ascii?Q?OKw6o2hzvvn9BgNM+LojOiHV18IRZ3oTQlalbwvoQuWIqbmFPQtViWmo9vXP?=
 =?us-ascii?Q?wRYV4xApqObc49Z9e33bDgy1t6qQLRaSWX2jqQsQwejDkm7GTfOmwqR7aBjq?=
 =?us-ascii?Q?ysqE7uQa3CS9GugD5QtuxnOv5X2KQw1s7M0yXNf2aNy7cMu+t7irrLKlp8m+?=
 =?us-ascii?Q?VzXmi2BD3Z7vEkj4PawOVsk+nB45M2vknl8zHOJcNiFfD2imvJL6JjIlpC2R?=
 =?us-ascii?Q?WemJ3mPTC5tVK9i2JaJks72epAxM5soPIMut84ty4GqHFtAchklSQ+GKOZKC?=
 =?us-ascii?Q?Fckx5T5GO9Pu4wveNB02Beg3PNALKnJNss1BcGQOJTc7i0+Y/BXwXNmHtjYy?=
 =?us-ascii?Q?Qcx+1OLqtt3tJsPD9gQogrzdtMKn/Lz61uOFHaNQa1HliDgPJSndQIhV5ysq?=
 =?us-ascii?Q?HQtf1gqLjZwC1MlE2cDEe7IkVKaWAudDGksJm/UJ18Qpa7DQ+be0+tKIvKxE?=
 =?us-ascii?Q?Grjj4VNCLebQCP6TtGbRGCflXKc/dgOnuQZKPl6gYWbmJfTP1feBqmKbflfd?=
 =?us-ascii?Q?SS4vf5Izi9lx6qU1cObqCZrGN3tUtw7PVJ6pYxSz3bJqJOI+IpG0x0uxpQ86?=
 =?us-ascii?Q?XWNF6lId7vgv2XSB5lyTFlfRznzqfChf8lOBJpg0sf61Tn8yvWeD/UIlcDnY?=
 =?us-ascii?Q?rm9JSE+XxUPfKzq7MVY6hVsWgDC/LEMVUW/TydAaGvKe7ZOXFjSG6MTHO8mJ?=
 =?us-ascii?Q?01YolXDm0/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGsq7o4duj2IL13QQefmFO4zumPbeSBfuWkKW37OLExOZUSUTcZskltswj6r?=
 =?us-ascii?Q?AWOUogAspMa4yqhbZfKSAbsSddq285pMghsKO5UKQDX/75OzgkN1VL9RikZN?=
 =?us-ascii?Q?SQiPsbK5sFOMCn5AcXgyPBXOoqHzkhsQAZPlvyJ+DAKKWyK6erbrMtmn9YFK?=
 =?us-ascii?Q?I20iAKpCHWZmPczfYm2++lguwyNuplas2SqeF9zfOigEXBbwditCaitpbuNj?=
 =?us-ascii?Q?JP1BpJQ42YPV+4oOcIBm7Vf2FrH+jSntQ0kZBg8Sd7wfqgVx8E1JM9uiwY1H?=
 =?us-ascii?Q?5TCU+1OIyXeKFT2R9IffPe+MBVaJOR83EZoET+GL5FOvqMELYqMDGu0x6LB+?=
 =?us-ascii?Q?T5RM2uzRwjymnW6pqzRO8i/nSXatAmWkWSf2la7ZzDlKUJukg+udbzDZphDQ?=
 =?us-ascii?Q?jc1LFqj+qzE+glrZqHucpfPBJhcIPMr2QwwIp7gks1gJaMPHDGChZXgOT9kV?=
 =?us-ascii?Q?byQVSZx15KkbIE/zJXC42YwcYIBfn6LTLOagJQMfvEY0/oo+JTmoR8Cl06z8?=
 =?us-ascii?Q?RhmbNtm1r4wP1r/i9xywAzQHNO0e8p9EMQEd0+6BdZ5ySyfBe7euv8HGsFr9?=
 =?us-ascii?Q?ERitA2RofviY93LWZTATnJx0ABze2+nFN9eeKKvs2gKak3cBkHjowA1LikDg?=
 =?us-ascii?Q?aACES6EOwoxgfwW4M/Edu54DPWM8kFnhSy8vxRRspSE2+Gm4VGGv0nrknJ7U?=
 =?us-ascii?Q?d3QrSQ57/9B1/6ySgApc/qwvmw6P01Zk4IP0B0DEIWsyg+lXEGuQ86dTWhaG?=
 =?us-ascii?Q?k65Gqo4xgNw76MKfQdqlv/HsRv9gfPrcx+8kCgAQCZ6fCJAudFtvJmyNMThJ?=
 =?us-ascii?Q?sdnOrtLKjJT4W8PPLvNrYAdAPvuGIbB6MalqygiaY7wqO9O2D/jzSSygsUNk?=
 =?us-ascii?Q?rRmQobIXogJQZvSITm615HIcBgB6rZvAddgizQVEEQQrhRiTUvCwzZ3m+dfs?=
 =?us-ascii?Q?T1hDKYYsNUAzJ0mF5bd/Xmly2Svo5W52EAKxOsoj4jIzZ8uMQgjoIrl+uQUL?=
 =?us-ascii?Q?aqOFB3rNQo7C9UGmuy1BTpXqEfxBZPn4calqvTutNb6Z4S74ykwLtavsN797?=
 =?us-ascii?Q?gwLYFOGfkIn2RkGy0Cl3WoXa04epyMNu2ErlEoxGD2F4qXTIF1KjSk5+imZ1?=
 =?us-ascii?Q?lsloBjJwmIFoR7W8jtpN34UMx8pMlbhRiSMEqCFNvE2NnrSFdAWlv/M62BLk?=
 =?us-ascii?Q?MEBYroB5rFaymWpuglMGoNbdjw/GGEo0JQnNHPlBCo/Dai3DAg+cH7A/OKm8?=
 =?us-ascii?Q?AWzdgtuGX5NbgtbVr9C7luAhZTf5VMjIo3ZdQxd0LvZzDTpg1zWDasH4MciC?=
 =?us-ascii?Q?7PuRGfEdO/1S3i3NMvqdXJ6rYG41yFByL6PQvZPFT3+sJlmHlmC4dapJihzT?=
 =?us-ascii?Q?mU9ACvwVb3+49mSwrpNRnISiJIksK3+SAT3xzyN9wM9XYstxQX7cvoO9luWc?=
 =?us-ascii?Q?keq2+MRrGhYoPfN+syBVTy3VOKr9Tk5C59UEoqSKoaPc7c7k2Sucdq6oj9ld?=
 =?us-ascii?Q?lJVeOXTNxjWq6VctbQVgtyvmj/cCZtKzZGcHUEOxmnwf4avtNW+HxV1ytSYM?=
 =?us-ascii?Q?abjVXdREG5mC93Q8MA6sjnG1cFOirt6hIuVMWYqecGisaTlwHj847wLD6rEH?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SHzHwtHAm9w5V5ZjH7Pdt8getKP8PolKKAZ0YwNUJDztKo2sN/0EDAVLKuzMGaF+ROPCvOsUP+UIVZMMwejxVmKkbW8wDAf7tcm27uJcjwTglD8VH3h9aB7MlJv0FI2Sex5s+b0wfKd5bxqUBlaIMRDofJv0Jkq2Kt09AfayxQZ+/GKLvW3/SBKTt+npvucRE3RQaGFUYmjD47RG9azciaXvyJkkHnwk1IQC9z2BR/WzncptLj4nxOruWpCK/I99pqlqCqHG01Nvsz6xVTqravX1oHWFoK0tcQUXtvhKWvaq7Ls6aYmgO3aE5l1WZ811wSPriimfiwWiAQKEGy8iM1L3h6h8sOSZhUd2B/+k208mDeHly7RKGmpReD8StR7bHeIeO7gVJID1J1lI31Aa9A/nuxQ6WB9rq66ib66vfDF6Fvev5ICfwGAorna6ulhzCuKl1m2386C3F/SrCy1W9XJnGd0hjw7VKU7spSsdOE6fEsTj6iOzsp7yno8nGCy8DbiedLzErs4llsGm8WIHM43jO7B4JhUYc92XA3X7W2SYqH4zxW0bd+TJg2Tct5KoGI5CNB9Zm2S8phgJKWViWRQ5Ke5W7RTThRgnmjWJ1Lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e18bcb-93f7-4e7d-2418-08ddc06f8009
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:47.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqID7cl3vM+kJ+O5xR1CIkHghTTutxOemIMsjho3wlvtOztsU+mMHntyKA+33T21ALpjd1+nFV9bZJMaglWXSS8mtHeAGU/89G9Fj+5mK7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: eCwRDXvVmtS_uS1OoufwRMtUHRup2iBB
X-Authority-Analysis: v=2.4 cv=JoHxrN4C c=1 sm=1 tr=0 ts=6870f7cb b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QPPSmYMVllzkqR6fLOwA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfXwS5/rhHnQZBj lRFyUE+hLLQti7KNqSHzVCxb7isdUSDlVshLUCBbfbYvjEkXBD+Tz2cpDQd8ly7cz6CPTR7DG7Q /2198tyUP9gEvzKx5x7WqRvLXruGNjvyHGTEKTCPflqaXFcQdbGKLI5tP6QcikL1xWYrBaXe2SN
 vo3jhwNP5R5z1L5tVrT178N2hfI/ANqOR9up8xpNNOtagvab8u3/74LDj0/k2Hv8xKTP14uD9v0 EIc7BTf5FPrm/oRm9MjcBa09eEaN/tQnAYEjTLKEOdooPZsSChfPp9Tn8efGn/QxsMfcfC2r4yw QM+w9FH7vg5G0ywxHul+u6W73z8TbAfMTRcq+kf6Ig61t6zJ7wMPdRp3rYnTu4KftFA+qsePsi/
 dDKFfRSWKWF94zwsJ5TPFxgdyZo4sv7TE+FqovfWgNW+ZJpE2DQtuQ2oOgUs3JMheVXPIv+3
X-Proofpoint-ORIG-GUID: eCwRDXvVmtS_uS1OoufwRMtUHRup2iBB

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

We only permit this for mremap() operations that do NOT change the size of
the VMA and DO specify MREMAP_MAYMOVE | MREMAP_FIXED.

Should no VMA exist in the range, -EFAULT is returned as usual.

If a VMA move spans a single VMA - then there is no functional change.

Otherwise, we place additional requirements upon VMAs:

* They must not have a userfaultfd context associated with them - this
  requires dropping the lock to notify users, and we want to perform the
  operation with the mmap write lock held throughout.

* If file-backed, they cannot have a custom get_unmapped_area handler -
  this might result in MREMAP_FIXED not being honoured, which could result
  in unexpected positioning of VMAs in the moved region.

There may be gaps in the range of VMAs that are moved:

                   X        Y                       X        Y
                 <--->     <->                    <--->     <->
         |-------|   |-----| |-----|      |-------|   |-----| |-----|
         |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
         |-------|   |-----| |-----|      |-------|   |-----| |-----|
        addr                           new_addr

The move will preserve the gaps between each VMA.

Note that any failures encountered will result in a partial move. Since an
mremap() can fail at any time, this might result in only some of the VMAs
being moved.

Note that failures are very rare and typically require an out of a memory
condition or a mapping limit condition to be hit, assuming the VMAs being
moved are valid.

We don't try to assess ahead of time whether VMAs are valid according to
the multi VMA rules, as it would be rather unusual for a user to mix
uffd-enabled VMAs and/or VMAs which map unusual driver mappings that
specify custom get_unmapped_area() handlers in an aggregate operation.

So we optimise for the far, far more likely case of the operation being
entirely permissible.

In the case of the move of a single VMA, the above conditions are
permitted. This makes the behaviour identical for a single VMA as before.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 8cb08ccea6ad..59f49de0f84e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -69,6 +69,8 @@ struct vma_remap_struct {
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
+	bool seen_vma;			/* Is >1 VMA being moved? */
+	bool vmi_needs_reset;		/* Was the VMA iterator invalidated? */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -1188,6 +1190,9 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	if (vma != vrm->vma)
+		vrm->vmi_needs_reset = true;
+
 	vrm->vma = vma;
 	pmc.old = vma;
 	pmc.new = new_vma;
@@ -1583,6 +1588,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+/* Does this remap ONLY move mappings? */
+static bool vrm_move_only(struct vma_remap_struct *vrm)
+{
+	if (!(vrm->flags & MREMAP_FIXED))
+		return false;
+
+	if (vrm->old_len != vrm->new_len)
+		return false;
+
+	return true;
+}
+
 static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
@@ -1597,6 +1614,32 @@ static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
+static bool vma_multi_allowed(struct vm_area_struct *vma)
+{
+	struct file *file;
+
+	/*
+	 * We can't support moving multiple uffd VMAs as notify requires
+	 * mmap lock to be dropped.
+	 */
+	if (userfaultfd_armed(vma))
+		return false;
+
+	/*
+	 * Custom get unmapped area might result in MREMAP_FIXED not
+	 * being obeyed.
+	 */
+	file = vma->vm_file;
+	if (file && !vma_is_shmem(vma) && !is_vm_hugetlb_page(vma)) {
+		const struct file_operations *fop = file->f_op;
+
+		if (fop->get_unmapped_area)
+			return false;
+	}
+
+	return true;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1646,7 +1689,19 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
-	/* We can't remap across vm area boundaries */
+	/*
+	 * We can't remap across the end of VMAs, as another VMA may be
+	 * adjacent:
+	 *
+	 *       addr   vma->vm_end
+	 *  |-----.----------|
+	 *  |     .          |
+	 *  |-----.----------|
+	 *        .<--------->xxx>
+	 *            old_len
+	 *
+	 * We also require that vma->vm_start <= addr < vma->vm_end.
+	 */
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
@@ -1746,6 +1801,90 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static unsigned long remap_move(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma;
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long new_addr = vrm->new_addr;
+	unsigned long target_addr = new_addr;
+	unsigned long res = -EFAULT;
+	unsigned long last_end;
+	bool allowed = true;
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	/*
+	 * When moving VMAs we allow for batched moves across multiple VMAs,
+	 * with all VMAs in the input range [addr, addr + old_len) being moved
+	 * (and split as necessary).
+	 */
+	for_each_vma_range(vmi, vma, end) {
+		/* Account for start, end not aligned with VMA start, end. */
+		unsigned long addr = max(vma->vm_start, start);
+		unsigned long len = min(end, vma->vm_end) - addr;
+		unsigned long offset, res_vma;
+
+		if (!allowed)
+			return -EFAULT;
+
+		/* No gap permitted at the start of the range. */
+		if (!vrm->seen_vma && start < vma->vm_start)
+			return -EFAULT;
+
+		/*
+		 * To sensibly move multiple VMAs, accounting for the fact that
+		 * get_unmapped_area() may align even MAP_FIXED moves, we simply
+		 * attempt to move such that the gaps between source VMAs remain
+		 * consistent in destination VMAs, e.g.:
+		 *
+		 *           X        Y                       X        Y
+		 *         <--->     <->                    <--->     <->
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 * |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 *                               new_addr
+		 *
+		 * So we map B' at A'->vm_end + X, and C' at B'->vm_end + Y.
+		 */
+		offset = vrm->seen_vma ? vma->vm_start - last_end : 0;
+		last_end = vma->vm_end;
+
+		vrm->vma = vma;
+		vrm->addr = addr;
+		vrm->new_addr = target_addr + offset;
+		vrm->old_len = vrm->new_len = len;
+
+		allowed = vma_multi_allowed(vma);
+		if (vrm->seen_vma && !allowed)
+			return -EFAULT;
+
+		res_vma = check_prep_vma(vrm);
+		if (!res_vma)
+			res_vma = mremap_to(vrm);
+		if (IS_ERR_VALUE(res_vma))
+			return res_vma;
+
+		if (!vrm->seen_vma) {
+			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
+			res = res_vma;
+		}
+
+		/* mmap lock is only dropped on shrink. */
+		VM_WARN_ON_ONCE(!vrm->mmap_locked);
+		/* This is a move, no expand should occur. */
+		VM_WARN_ON_ONCE(vrm->populate_expand);
+
+		if (vrm->vmi_needs_reset) {
+			vma_iter_reset(&vmi);
+			vrm->vmi_needs_reset = false;
+		}
+		vrm->seen_vma = true;
+		target_addr = res_vma + vrm->new_len;
+	}
+
+	return res;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1763,13 +1902,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vrm->vma = vma_lookup(current->mm, vrm->addr);
-	res = check_prep_vma(vrm);
-	if (res)
-		goto out;
+	if (vrm_move_only(vrm)) {
+		res = remap_move(vrm);
+	} else {
+		vrm->vma = vma_lookup(current->mm, vrm->addr);
+		res = check_prep_vma(vrm);
+		if (res)
+			goto out;
 
-	/* Actually execute mremap. */
-	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+		/* Actually execute mremap. */
+		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	}
 
 out:
 	failed = IS_ERR_VALUE(res);
-- 
2.50.0


