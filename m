Return-Path: <linux-fsdevel+bounces-30358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28998A3BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9452810C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486A192593;
	Mon, 30 Sep 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="li+/646z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="maEb7oa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946971917EE;
	Mon, 30 Sep 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700929; cv=fail; b=l0r3uwoE6i4b6uXjOqBnB5kqyCL7MniW7TAJEsPZo4vXV6BOP4uQQCzI1t+juNzpTKMsQjBFNoT0u7+gcbb1lvm84ljO6vchFxEgTBRhNTn0IM836/i4USkERQIYPfg02ePSnXI/e+YF7buJElilG4S1KBoDVKeidgp4dRL1fM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700929; c=relaxed/simple;
	bh=Banfh4EgYWGl1Q/xZydJxDKnJNbver2X28Eugz49QeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0zgGAWZ8PIZABIcydNPpmMMjIK58CtVpC8BZRSNMkgRNm+/ZuxfxE4gtgOMtKCw7ZTkhrvdrsi2NUrGGjnM8K03it26Na9rwkj+nMtnmyP9cvKaGOuD+b3G8ANVRVbVoL7611D6xW3N58a60GFY8JM3cNhxkArdzk/kStoirEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=li+/646z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=maEb7oa4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCK2x8009387;
	Mon, 30 Sep 2024 12:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+NExMxz9Jq8oZh7DDJhn4H03KalWyNIgLxo8sC8oFhk=; b=
	li+/646zwPSs9Y25dsWEvvT0P9w0odW+IKooQC7CvMgnPG184X6kFAyRh759OlLq
	JT863/bidmS1fz/w/s7lcQ6I4cg+NBd6MAseuGsMHP4AeZO5F1nAb+jSREQ19MPD
	3H1XNoPTCD0gfGZ49tZGpc4PsmmkUQU5m0arxDYGoVAAxO4t5R67jO4ABV45tIO+
	quUpUPpNQuhvEL+arFIzDrI8kuzt8/0UD0fb423L4Zcf2NGtMbvK3NSolaYD6IpS
	LpLDvq6L4JA9iSqgaazd52h1B5HZQ49L5u9Hy0KQztkiN0OCafbAbdCEEPEOe78V
	2kU3BdKXWK5feFMC+XxZ1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3383x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBheqi012511;
	Mon, 30 Sep 2024 12:55:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885r6x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvd8Cp0XAZ2IwqMChRCqQ1Ikx1nxcUKWRIwEcd0vVx8fmvVVNVnRAnSneQ0L1loXhxQllKV5sVpworgzL/t0B+6n8oCDJSSME4h6k1mF+IQeOgq/eLSU7lRzNm/kGp0PI3sY5MrpDkJxNyllcYHzVy+iE7qAKmDBYiSDR+TAQ7cQ+u1P9XgirC3u0ME2PDF4M/8I2g8O1NiwEaUnVW3HnWkL5O+mt8Nqj8L8eztxfAF/P/48JZuI9zO49Mah25NaCEHgpux544wKXbblH3eF0oTANl7ugRJrXBBDW1puim0kKVwy2ITq0P5WFx4AhctGPBcw4+NgI3uhIBsSTfRKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NExMxz9Jq8oZh7DDJhn4H03KalWyNIgLxo8sC8oFhk=;
 b=uZU/P6tLIUQazOthclF6YdWEhebZze718v8sGF+fUp5cEogVDeaQKPhqP9lcJ9eFKmhCBQuRJ9wEwmFGcBcfPUhx8N+mMlb+vxbhS0eojSYMD6n1xg4iuq0oXmNxToQMrXR07jxtKNNNjb+Q+iNh+8M1M33+9JpxTsMG/cpGS6MaYQMW83vkvVDC93ss9E7IQaRF1UkSyVVHThll0qSI3dqxIJCwvmJmA4a5IHIr8Hldp5fgmp/bqFtFIiMwGTQIMG1icQAAIB4LbUQwuf0M++ReRq48s4wOgT1yokeNevNMZdSVK/XOe4fCoy/3hgW8eqPxqaT0QDrLIy1af7tq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NExMxz9Jq8oZh7DDJhn4H03KalWyNIgLxo8sC8oFhk=;
 b=maEb7oa4CEelMO+JerUaILMsjjrW4g3gzBH6HGbNU4p04K+kV7FfJT7RlkDXxbcKDacGYi97njNDDresz41nVGNcvSfiIK0F1Z4owOFFXdl9TRxqd+b6gVYmKfwOYjPPGRxSqQSdVQ1mZ9nhzkd6m3Y2dDWmtLws1IGiNiS6Lko=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:54:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:54:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
Date: Mon, 30 Sep 2024 12:54:35 +0000
Message-Id: <20240930125438.2501050-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:a03:60::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e070d4f-0ffa-4ef4-fc8a-08dce14f175e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TxJslDv7PhP6k6h5Y94YN/rsSzDL8QXE/KVUqRAVEGzD2pHndu4PQoJdd9sd?=
 =?us-ascii?Q?slxL1GCr+AQEYOP8EYbZv1W9sY+P8wvZF2LslCOaWUqb+xn03KSVfDSxmkZz?=
 =?us-ascii?Q?K92kNDM0USRvxROypXifRz5x1PET6w3Lks5Gd+JYF4Vc/dAvGo/MdZPbBV1i?=
 =?us-ascii?Q?+G+wpqShRsnSql5F8yZ6YH0S3dJmFvcID5bGn/dGLuYPhQDQMKRlZmZ3a/QZ?=
 =?us-ascii?Q?fZK3YCDMF3pJ0Uya3K3FvtREvgRl8CjKeCWF77WPnaISKG6LU/qLtI85sBc6?=
 =?us-ascii?Q?DtoPtt3yXY5fvZsLL2L934bMLlzMjLLqNGgmk941Ml2QL0adyKzuki2U1qDE?=
 =?us-ascii?Q?3ENMQi6Bt7DuyORBVzcHpcFgffXH+U3yUgKZS3D3gjgH6AMWIY0+5FTjqXdo?=
 =?us-ascii?Q?D2ZdsMyqBgkGkttSJaxK5HdO/UyW2EFyZp0ycG5hxYm8/tW94rTVQy848cNE?=
 =?us-ascii?Q?HYzbeDu9MCQIYmLpr3CuQapsEjCOOuGXjt61CiDmMu0G+NgYdpMh4X6+owWT?=
 =?us-ascii?Q?R4EpmPQH5l9QGFIa6rPQh/iH4ahftiLuZ+KKnWp5wusABm261BB19wb8EgB9?=
 =?us-ascii?Q?2BF+XBiIGHI1vfB87w/r2PnM2L3Nm0oDWbLsinAub22C2nvbSj9aBVCt8aoh?=
 =?us-ascii?Q?nHajXWWb4gUxfNIsGjePQT5zZbpMirXlnBTsxbZ4dbtEKcmrQ0f1PeibTET6?=
 =?us-ascii?Q?wQKd6ts5AJHojevlCUf1EOr0q3dUHSFwW4wqP4FthUXV2Vec8+qioqL4volE?=
 =?us-ascii?Q?t7098onfneFomCckb5+Sg23G3vDLGo7T4/9uzHVtkc4SZSl7vy8qcoHM8JYi?=
 =?us-ascii?Q?qrNK/ivNTkWh9Mr5dflkixnzI2vQeYURXvGaRI22vTkAEYmruwSGTaijly9n?=
 =?us-ascii?Q?nPhLCGJJZPp+zz9GbTDS2jL43iKRjfDlD8CWG6KeH1pjT6ClVGn/mFHefmeH?=
 =?us-ascii?Q?qkq+/WMgvBzvrVZ7lQPdWaTrp9atI3rTBk7hqzufTMvx6QqVqqZZTRC5CGVy?=
 =?us-ascii?Q?Q2wmWiIiWOeHSl8/blRlbGdnL/ws+yxKfVZiZHoA8Zr7Ps7RSchhRb36ybdV?=
 =?us-ascii?Q?hl7unmLsC+GOHCKQBb7RM7L5USAsUbGczyJgQ0u8H32T2g7xBTF/Ou8RzpAu?=
 =?us-ascii?Q?TI5ZHymBsiVfKW1Af+/jzgIqgyLO6h8oAeIg7+J0jdkQ0VXP9hSsejuZao7G?=
 =?us-ascii?Q?Bjc0V2d0IVfsbBghROepDXGxOVWqtddi1w/UD0Km0aLLGcLIb3HayIy0zbie?=
 =?us-ascii?Q?OkFbLDR5ite0KlEb/vutAuj8Z6OqTPFW091yOigD5z7l6hnSOgqpOJg2z6Y6?=
 =?us-ascii?Q?djNdUp+yjwecmp4LoHXQHuGImuf2e+BSBaascRPKyfHEkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGVFDIAV+xPil0JWKed4GFVtuFHyyDUZ0y7WW+H7tc2VriST8uLnFuj65UF3?=
 =?us-ascii?Q?/HrYEkB/dlZR03eWO2ItiGBVRiCGv9kEWF3/0lYzA5lSKkyt0fwfzE2WyAoh?=
 =?us-ascii?Q?JXUBFpje084ZtzssZjftNaEV7gnqmrCzG7UVpwEwPNx2d9s93VeNEhDIe8+v?=
 =?us-ascii?Q?oxCUCqyU0xTkEtaemOSk5k2h3SHsjxnoQZ7n2BcetiFthAH1qkT3eVU/ELw3?=
 =?us-ascii?Q?A3tB0Gv5YOe6XG4OEukI4GDJmPI1rdVBi8f/zc9x9jaI8t9MvdKCTG4atP8g?=
 =?us-ascii?Q?qneVCqgEnfaHL7HMCIIHKJoXcYKPd8+rD8FCWt1BLlTAH9rj1VYzxxkmkfLK?=
 =?us-ascii?Q?MJuNXvklH1xQ5f+7jJWF7deeCi+APsyUnyjcyNlExuRfF3roczeRvhqNQkl0?=
 =?us-ascii?Q?jCLavH5cH7RY1yHxmSnH4oNXenAAq4zOoEG56INC3RLtI7JIWhpaGgGSMRJb?=
 =?us-ascii?Q?4jvL256wbxwMBRLiibTJc+qLMPYAI2P6bFE5BJ0eibS5NejNn/rUxgD1sZVw?=
 =?us-ascii?Q?IRlmaJyL4cP+07Fl/VuNzqweQTqbWk3DbOXTUS9KcpoWRVKA0j/QTDPvlFTC?=
 =?us-ascii?Q?R9KXsOnA/NqRszbdsAZl531pNWxBziv9Vu8yeD3JTRGakfNeAnD0gKKpQKOF?=
 =?us-ascii?Q?CcCzZ7PQR/HbTU2NiuN0Odfy4mGJWMB8LspuWhfnywOoS7Y+D+9X8ZOPFdLP?=
 =?us-ascii?Q?KlH1amg7Q2xYbwNQ+/DT0uKC4eSYxCNZ0LDBoKs2jUR+uc6WbhRWFrpcdJLD?=
 =?us-ascii?Q?B9gfsMbE5GgfnvgYgpiYXL6Y1XVHuXBT99qT6slv7ChlCjezEy57lp3TVEb4?=
 =?us-ascii?Q?nus16wQpyocMPDoIlGmqXLYx4U6FCjG5tZBBcOP5cgLL5hYmVrJdt4a38qpg?=
 =?us-ascii?Q?tmSaL+wg/J417WxbeOroSzM3cclD/DIulQs7UarLwf0+v7kaIkTKa+veXVEv?=
 =?us-ascii?Q?huNEKZfqzUvCU1IjKSvyMZComdJtmcPx7WPf/JT9ZIvg7u4Ye2Q+C1UHWZCN?=
 =?us-ascii?Q?Dk806aN7ZXCfMwDzpjzsvPvF8ZTuqQEQg702jf0sAjbbplVAJpxYqPIvlNvz?=
 =?us-ascii?Q?do+JDODALJv1zh+T3Wg2/dMmfyArYLSrQVeiEPtkUowIKs6D1dby+VO/czaA?=
 =?us-ascii?Q?XKeyBV3G7HESdGiQlZRSRG5d6Pgc77A0oNniEH1OuUFZqKH46G7bN3UZCbQF?=
 =?us-ascii?Q?jTEptl0ar5feWtKlqq4IILOFmIaGF2ctgINq5k+2mVeX9VKSTlf4ZmzR2Sky?=
 =?us-ascii?Q?YfZIM2Bi6ZW4FWhdBe8G5qzh0z/LGT6xQrKwzqHixRg1KbnSXhOVYfNN6vz4?=
 =?us-ascii?Q?2rIJGpLBwVWGMZE02bSIRq2zkz/skoZCr3gXKtpA5rGtvElQZ9u7TxGj7Zte?=
 =?us-ascii?Q?sn2+MYlRr7xz1+RKUvnlkAVPZPwXNpFOudBvfHIgaJ4F+hjRNFkls+RTmAQ9?=
 =?us-ascii?Q?zpMUmXi8CFfhaGKP5/mhCBEwhFYiT3vcGeV63LxZ93bnIRHLE/CFlj+C9r8f?=
 =?us-ascii?Q?0I0WIP+XvkgOroixwgdI4VDxgICXe0tQTZWbFKMMnxfA138fKt9NbE6yvx3M?=
 =?us-ascii?Q?f11ZvC7TufemsM3pFy66OzxU8Qm8KTPgy120qUPzHfIgQ9ANi9P+XLUIF9N7?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gd7V1UO/qjI1QbzlE6WNQqYf8X7qNM8fSDyt6ZSUWUSw2Pw3/sf1Vd0jSookVJ1OcAmcoBZIPA/R4py3rtRMHNVJmHqftJBiQWyiYXIJAGCM27JPOg5X9Y30RCMHwmNCzgiUpTQzWQioAqUIDcQOFcUDjB9rpEhUmrCuKzDgb+ah67mEhlteGR6wWGDDCXCaCauFt6LIQMUJBU/Ps4WgCF85J2MSwGdyzyCRU68pbrNZTZmfBc4kbvA/S9WAY4g+qUj66Ux7IafdG2ZUd1m+OHw+K4j2q6XqBh5FQiRwtju9bP4Hx76JyUfQtKdJ7BJ86pT61kPJFc+6JFp8RrBPlJMYLkmCJGC/xTAAYaFhsIB8K554n+qxkGvxRvKugjedGDhHsSdXfQ36/S22t4dwFYxFKSTDeDPLVpCMv5FpRnml40RNgmgqeGBGGUU1Rzq03PKTX4LJ9aH1SkVSzv6MP6GzskC1SjVcJsCtxvgW3bHUMCNVE3Vz6AIwp5JunCyCfUIqlbSCdYcuXnvEnw6Gygq6+seW1mYOp2bFyYzq6LXOF1nWTPYkdLUv5Z9NIZCTIOmFLbFgIsX3iA7Xq2SouHapJiamOg/TtX3gNaWcHzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e070d4f-0ffa-4ef4-fc8a-08dce14f175e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:59.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeiVn1rtq+QqBVhQsy91GS3VQ6flHBvw9SvNA7gJ1WT3406sv6RVqG7LfyOI9XClOUE+I7qRN3OQq/4PI7Mdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300093
X-Proofpoint-GUID: fAMcGqNEQOOHSwwgiKaRU_jmEhVmwGeG
X-Proofpoint-ORIG-GUID: fAMcGqNEQOOHSwwgiKaRU_jmEhVmwGeG

Add initial support for new flag FS_XFLAG_ATOMICWRITES.

This flag is a file attribute that mirrors an ondisk inode flag.  Actual
support for untorn file writes (for now) depends on both the iflag and the
underlying storage devices, which we can only really check at statx and
pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
the fs that we should try to enable the fsdax IO path on the file (instead
of the regular page cache), but applications have to query STAT_ATTR_DAX to
find out if they really got that IO path.

Current kernel support for atomic writes is based on HW support (for atomic
writes). Since for regular files XFS has no way to specify extent alignment
or granularity, atomic write size is limited to the FS block size.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h     | 11 ++++++++--
 fs/xfs/libxfs/xfs_inode_buf.c  | 38 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.c |  6 ++++++
 fs/xfs/libxfs/xfs_sb.c         |  2 ++
 fs/xfs/xfs_buf.c               | 15 +++++++++++++-
 fs/xfs/xfs_buf.h               |  5 ++++-
 fs/xfs/xfs_buf_mem.c           |  2 +-
 fs/xfs/xfs_inode.h             |  5 +++++
 fs/xfs/xfs_ioctl.c             | 37 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  2 ++
 fs/xfs/xfs_reflink.c           |  4 ++++
 fs/xfs/xfs_super.c             |  4 ++++
 include/uapi/linux/fs.h        |  1 +
 13 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index e1bfee0c3b1a..ed5e5442f0d4 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1093,16 +1097,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 5	/* atomic writes permitted */
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 79babeac9d75..1e852cdd1d6f 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -483,6 +483,36 @@ xfs_dinode_verify_nrext64(
 	return NULL;
 }
 
+static xfs_failaddr_t
+xfs_inode_validate_atomicwrites(
+	struct xfs_mount	*mp,
+	uint32_t		cowextsize,
+	uint16_t		mode,
+	int64_t			flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_atomicwrites(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISREG(mode) && !(S_ISDIR(mode)))
+		return __this_address;
+
+	/* COW extsize disallowed */
+	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
+		return __this_address;
+
+	/* cowextsize must be zero */
+	if (cowextsize)
+		return __this_address;
+
+	/* reflink is disallowed */
+	if (flags2 & XFS_DIFLAG2_REFLINK)
+		return __this_address;
+
+	return NULL;
+}
+
 xfs_failaddr_t
 xfs_dinode_verify(
 	struct xfs_mount	*mp,
@@ -663,6 +693,14 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		fa = xfs_inode_validate_atomicwrites(mp,
+				be32_to_cpu(dip->di_cowextsize),
+				mode, flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index cc38e1c3c3e1..e59e98783bf7 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -80,6 +80,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -126,6 +128,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+		ip->i_diflags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d95409f3cba6..dd819561d0a5 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..44bee3e2b2bb 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2060,6 +2060,8 @@ int
 xfs_init_buftarg(
 	struct xfs_buftarg		*btp,
 	size_t				logical_sectorsize,
+	unsigned int			awu_min,
+	unsigned int			awu_max,
 	const char			*descr)
 {
 	/* Set up device logical sector size mask */
@@ -2086,6 +2088,9 @@ xfs_init_buftarg(
 	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker->private_data = btp;
 	shrinker_register(btp->bt_shrinker);
+
+	btp->bt_bdev_awu_min = awu_min;
+	btp->bt_bdev_awu_max = awu_max;
 	return 0;
 
 out_destroy_io_count:
@@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
 {
 	struct xfs_buftarg	*btp;
 	const struct dax_holder_operations *ops = NULL;
+	unsigned int awu_min = 0, awu_max = 0;
 
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
@@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		awu_min = queue_atomic_write_unit_min_bytes(q);
+		awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
@@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
 	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
 		goto error_free;
 	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+			awu_min, awu_max, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..b813cb60a8f3 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,9 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	/* Atomic write unit values */
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
@@ -393,7 +396,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
-		const char *descr);
+		unsigned int awu_min, unsigned int awu_max, const char *descr);
 void xfs_destroy_buftarg(struct xfs_buftarg *btp);
 
 #endif	/* __XFS_BUF_H__ */
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index 07bebbfb16ee..722d75f89767 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -93,7 +93,7 @@ xmbuf_alloc(
 	btp->bt_meta_sectorsize = XMBUF_BLOCKSIZE;
 	btp->bt_meta_sectormask = XMBUF_BLOCKSIZE - 1;
 
-	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, descr);
+	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, 0, 0, descr);
 	if (error)
 		goto out_bcache;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912306fd..1c62ee294a5a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -327,6 +327,11 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
+static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a20d426ef021..81872c32dcb2 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -469,6 +469,36 @@ xfs_fileattr_get(
 	return 0;
 }
 
+static int
+xfs_ioctl_setattr_atomicwrites(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_has_atomicwrites(mp))
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_max < sbp->sb_blocksize)
+		return -EINVAL;
+
+	if (xfs_is_reflink_inode(ip))
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+		return -EINVAL;
+
+	if (fa->fsx_cowextsize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -478,6 +508,7 @@ xfs_ioctl_setattr_xflags(
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
 	uint64_t		i_flags2;
+	int			error;
 
 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
 		/* Can't change realtime flag if any extents are allocated. */
@@ -512,6 +543,12 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES) {
+		error = xfs_ioctl_setattr_atomicwrites(ip, fa);
+		if (error)
+			return error;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 96496f39f551..6ac6518a2ef3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -298,6 +298,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -384,6 +385,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 6fde6ec8092f..6679b12a56c9 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1471,6 +1471,10 @@ xfs_reflink_remap_prep(
 	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
 		goto out_unlock;
 
+	/* Don't reflink atomic write inodes */
+	if (xfs_inode_has_atomicwrites(src) || xfs_inode_has_atomicwrites(dest))
+		goto out_unlock;
+
 	/* Don't share DAX file data with non-DAX file. */
 	if (IS_DAX(inode_in) != IS_DAX(inode_out))
 		goto out_unlock;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fbb3a1594c0d..97c1d9493cdb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1733,6 +1733,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+	"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..e813217e0fe4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


