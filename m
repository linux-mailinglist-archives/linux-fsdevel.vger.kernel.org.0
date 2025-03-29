Return-Path: <linux-fsdevel+bounces-45252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A86A75516
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B18A3A5E8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25A19259F;
	Sat, 29 Mar 2025 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jHNLFt2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94939ACC;
	Sat, 29 Mar 2025 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743235647; cv=fail; b=bbmg7JztileHEkCaxTs9nxWsCS461zt3dYbZCMnHzyPIDyv1qpbsuIVnKKfcKcGYfJ6O6fOA5ac8ujk4fsBITFBVpCBNnqIq5JxD/PJ2A4uhERQ70HRrReVoHMlbgOw5LtH0vU1/36TOHoisAZWOXMwBG69FwP7/vxAmLlUsvJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743235647; c=relaxed/simple;
	bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fD9cqvo8qnpaXF7gqZd7all4IOGpt+ucFwo3G49Lr7l1sH7IPLK0ouV5GIeOtmqCG7od7TGAftLRYruaM4dNvH7Bsp7YaEB0hTVS/fS2QxXnF7iflrxgGZ1sKQU/QigBwnnptZV65IeYdHSwv4uQJ2FdsATaZJYVwLeXUWAu09E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jHNLFt2p; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T80IfG008856;
	Sat, 29 Mar 2025 08:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=5H2q1Jw
	GhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=; b=jHNLFt2pBElbuHKRgTioMy5
	shVYHHYDbwZS7X073V/zkPftOSFvUs0lJQ+NprmR8IlX3vM0c6r9lj3xQyiTd9Pf
	panOwKJUGq6Qzqiq0nE4EpfnLCCCi14JGQNscf5qLZgsf6gOKGnD5SbjX4ztg5Sk
	HQDMEge4fmgIf8WDAMA5vSKUnATIJec1wrhY5i1BsndnhJYG1O/WZQJxMZ3C+nxg
	SkHuQh8X+2VkNIiu5JZZwl7R4WY+raVSJsCLk0HC3R8ecbpcjUon0Fqf9EVeu0ib
	qFPOVTb8Y553GSddaTanS8LPtj1nX2m10xwNGczU+MSLejLbhtlc5ihs4CxvhnQ=
	=
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45p691g5s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 08:06:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dE1GV5f5H8GXdCF1vK7mbxUE+YdI9bksgdUucAly6aE+kAY85Q5OqNdmbnG+9LJPv0Fwis12YCQSP34tBqilNQhsksQ0u0ra32rcPjbzOX+i7Fn9ufQE2PcUgGu/Ke/l69wwyD+V4dAYLuB1HwRrA8hI6AtmjadFFMfKCCW+IYsE2PAGG1ybai3fyarOPYVMS0VOQPPPYQ05g77LUnDFojEapeH+Q9TpPVrjdtyRLVws1MluKyLVS1Uuc2VlrcbJmNZ7RDIZb4feCEDR8E3hhCL5zEnFxVJ/Q9wXRv3ylCE6xgnzi0ZKOSLi7bSkg10KtSGUf9uGYl0mkL4W7N7atA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
 b=modmV+dIi4TBlNhJgfZxC3vCrouOJht1PusDXv/9jO83onLIYB/lvVdA9b+csKgwouy6g4TtNDWQPz0PlPWshhFpfl0oSCLDbhyYeCRewCqwiFyUDmp3uGVyXFCuuO71epoeifhsNGUjqnB7yi62xdkvdDhGkPVKtr2yq0C69y1atc4ZFLaFhTyvij3YFkm5CqJ86LyDskFUEglLRiha3YuJ+N5OWgQlQ8Gqg0O/rIhv14TP02BMEyviNWpuZCBJgP6eoYI+m8CM3F0AtrHRxPDQBEKnMxfAbIySn12YdH5BwscRlr+SnA5zkvw9E08YFB8v2SZmkBN95PpUYzVxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6875.apcprd04.prod.outlook.com (2603:1096:101:ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.34; Sat, 29 Mar
 2025 08:06:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8583.027; Sat, 29 Mar 2025
 08:06:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "sjdev.seo@gmail.com" <sjdev.seo@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] exfat: fix potential wrong error return from get_block
Thread-Topic: [PATCH] exfat: fix potential wrong error return from get_block
Thread-Index: AQHbnl5KN9f0vcSRd0K9sudQtjxHQrOJxhRQ
Date: Sat, 29 Mar 2025 08:06:47 +0000
Message-ID:
 <PUZPR04MB6316125235B1659F3D86F44581A32@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784@epcas1p1.samsung.com>
 <20250326144848.3219740-1-sj1557.seo@samsung.com>
In-Reply-To: <20250326144848.3219740-1-sj1557.seo@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6875:EE_
x-ms-office365-filtering-correlation-id: e9a0e56a-51d8-48f2-8a53-08dd6e98a6f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzFzRXYxK0JlUG94cVliRVpQcVhKaHV4Y0dOSHlXTTBZS1NyWDlzbUVGQTBY?=
 =?utf-8?B?dnY4QWc0RTJCbmlPaTdLMVpPaEdqb3FMOEEwYm1OaHJMU3k2WGZ5NEJYWHBj?=
 =?utf-8?B?Y1czL2kybEVvcXJ0UTFDZnhBcjJjTU5rSmk2WTEzQWZWMklpY2U4eFJqQlgz?=
 =?utf-8?B?MTNad0JUNWpwZUZLeUM0eVZiLzl6Q1gyMnFYNGFFR0lCaHZ2YXlzcW9qZVVx?=
 =?utf-8?B?MFh4QTQ3dDZFb1pYM3luT3BEbDRaeEFlMmhjMUFHWTc4NTFzYWpDTDFoS3Yw?=
 =?utf-8?B?MmE3SWxiVTFKWE5qdW9wN3VjeGRTTk5iNjJSKzNKZFZGOXd3THYzTit1T2hk?=
 =?utf-8?B?QXF5cERQdUJXT3FZTExTUzI0bStST1VZZGhSM1FsTTdCekZFWDlEVzJCV1cz?=
 =?utf-8?B?c0lKRmVzZDIyVW9QTit6aDBYcUtTOUhuTGxCZ0syYXZpMVl5Zjh4cUVDd2x6?=
 =?utf-8?B?Rk9SamYzR1BubS9xZWNucjY0S1pha2tIQ2lIbU1TeUFkeTVMVUx6TlFKWnMz?=
 =?utf-8?B?clhYSmhGRitrNFh0UW5sSmt0R0h2emRPU243NjRGSjRFcnZUL1ZaSmdNQjYw?=
 =?utf-8?B?ZlY2K1dJYjNKYTBDcUJPZlR1VHFCZlFaaWt4SEpZdFl0Q2FWVC9OODUwUmNB?=
 =?utf-8?B?ckNldHhsMGVoUm51dHZWaVl1YUJrRFJlUWZ3R2gzeVIwblkrem9yOFJLKzJM?=
 =?utf-8?B?UlFuSEJCUEpVR280QlJGK3VIZm4zdTZIOXhQa2RNUTZmaEhVemJJZXZvTHdW?=
 =?utf-8?B?TG9sOHRxY1BrRnQrTk9RUGp3OHNxalBBMGVuUG5KOHN2V3o0eEZLY0l1ckxU?=
 =?utf-8?B?bE9DMzF1dVUwUVp5ZitBelVjb2g0MEtCdWNuNU9sd2lqeVJuN2ZCLzRPcVBN?=
 =?utf-8?B?Y0VSbnB2NUtrVEJRM1UvVzlPUnBFVGs1a1VvajRUL0pmMXN4RHoxUmV3R0pa?=
 =?utf-8?B?Y1g3U1FBMVp0THZuQmZodURBMWNvTSsvWndNOEN3UlpZakg1bGthUmhDSFdq?=
 =?utf-8?B?UzFPcE5RWW1GMnltTXhkbWRYK1BtMnkzSTJQb0FLdndVTkR3YjRzV3Y1cDhY?=
 =?utf-8?B?RnV4eFVKbUtWcjQrV01sandkbDVtcTV1dUh0Y0FUOEIrZEJFQ1VaU3ZQNURI?=
 =?utf-8?B?MVFxNE5IM2w5SmlzVjVLdjdLZVlLNGFKMXl1bE95dWh1OWZCVWpwczlNVnFs?=
 =?utf-8?B?dXhTUENMOTQ5V1gzbDdZdy9HakJSMEtBL0ZSSDJ4dnFsMGpjcjJIbWROTWpR?=
 =?utf-8?B?QmJCUE9sQXRibTBBdkJkYzdBZllmamNadWhZVDlXdlYwaE1aZ2NIQ0JvWTA3?=
 =?utf-8?B?a1JEWHloUG0yS2FQWmxZanhxWGVOaExqclhBbHRsQ0dDRXNCaTViOEl5SldX?=
 =?utf-8?B?KzJpQlZxcUpZSnlJeWhvV2haQUptbEtkMTFoR1VrWHc3c0FRQkNQazdHMXRJ?=
 =?utf-8?B?WFZjVU1QZTJWQk9QWktXNHZTUkZscTRnSHFNS3lRNTMxMjg2RTlnVlpLRHJz?=
 =?utf-8?B?TWswdVN1VW9wdW9VZ1hJbTJGWlpDckJoTDdod01Cay9MeE9EejRadVpNTmpK?=
 =?utf-8?B?NExwM1ZRWENzZlhCM3NQaVB2TDJMRVJwMEt3OGhpeExLS2pJbUZJcnZUcDgw?=
 =?utf-8?B?eDF1ZHVUMnFVR1dHU2tvbnNFeXFKenlkTEk0aW9qdWFsUHFLaE9QT1dFcTJK?=
 =?utf-8?B?UE9BY05sclJzOVJQOHJodjBQZ0J1VGQ1WnV5VC9zVlo0RnhtTE1lbzhZNHNJ?=
 =?utf-8?B?U1dyNlJ0TjB3U2lkTldpKzhIajR6UWc0K00yYWZaemRORTk5T0NJN0JSRDVw?=
 =?utf-8?B?Y09JU2cwWFFRL1VoeWhrTU9VaGtrU3cxeVFNVU42WmloOEVxV0VTWC8vYjJr?=
 =?utf-8?B?dEVFYnFaWjg3alk4MzNFNDhRbVJrNzNiRE4ydjNGeGEyYlFsTE96K3pLbldQ?=
 =?utf-8?Q?jOr2OEmJv8d3Vsm98gT88UBXg0xcOBTa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUdTeGg4OVdvUkxuQnI3dDV3dHg5ZU9YOCs1Y0VpNjhrM3VxOEw2MzNqREI3?=
 =?utf-8?B?eTllYnFUZHdIT0MwaE5rMmJvOWRQUHNyek1qeWxIdktNaXBGZ2FmNHkzTkdx?=
 =?utf-8?B?TmVjYStBSmtwNm1qWXMrN0hYRnNFWWovemxkUFRRTTU2c1ZsVzg2SEI2dUFG?=
 =?utf-8?B?SWtRNnRWdko4eUtjNlV0dUd4Z0x6eDUzcUFtNWd6b3RLVzNCK3E2WWlHV1p6?=
 =?utf-8?B?VzhVNk9TWThxbDZSNVJWUTNOWHQyRzBFbTBqS04rK2xWd1dFc0NZaHhwUkp2?=
 =?utf-8?B?Yy9iSmhKcmZUNFRmeGlLa29POTVlT1Q4MkZrb3RpMlZBQUtOMnF5N0ttK3dh?=
 =?utf-8?B?WGF5RnN4ZFBLM2lQRENFbXZZSzB2MmlpcmhmS3Q4ZGluMEdJK2ExQ3A4SlZI?=
 =?utf-8?B?Q2I0TDc1c09aRmcrUDJnVFlWaWwvRmFNRFg4WlBzNk5JV1VNU21JM0kxZ1J3?=
 =?utf-8?B?UTBjbmN4d0ZNNXE5RHpTRmZNOEJwaGg5ODlDeG81cVhkdDRZK0pJMlZOUGY2?=
 =?utf-8?B?L2pBVlRNdGlHV2wvL1ZTRy8zNGdHL0pteHZsYm1lUjVuem5MclI3RlAwY0VP?=
 =?utf-8?B?eXdtOUJHYmpwTFd5cUlpSklTT0tvV2FLSS84QU4xOThUbXQxdGhISkdjNzRo?=
 =?utf-8?B?em82d0g5SmJJTWgvaHByaWdWa3c3alNpOVJEVUxOR01wUDVGT21HL0U2QzB5?=
 =?utf-8?B?VHVEcUtzQkFxUWtOa0MvZEg1bnVxd09kc050S21jb0hkRHpMS09PVHRvZVR4?=
 =?utf-8?B?Q1pLUVU5MzIzTklmbWNGQ2E1K25HbWJaYm9lWXRnbjVTemw1NnRBaGlEVDhO?=
 =?utf-8?B?TXNzNmlwSjN4QXNLR1VSc2prMHkzQWcyYkJRR0tLQXRaWkJWcmQrc1JadHFm?=
 =?utf-8?B?Qm9kOCtQMVhGUkxrUTZEL25kcFh4bzZVblFxUTkzUnFTTk8ybkE5VUZHbWdC?=
 =?utf-8?B?dGJ2bUVLNnVJZFROck9MUzVjWG4waW5BQXk3MzZZb3JJSjZzdHRSa0U1dkU2?=
 =?utf-8?B?eUtVbkJNSjNnQWorOTVFUmxKbk1DcW0xUk5hclFTTE5lcC9yeVI1Q1FWdkNV?=
 =?utf-8?B?dGhMd0h2Q0hkZ2s0S2c4NS8wNHdnUjQwTXhVQUR5MzNhQWtKVlo5aENKOTdk?=
 =?utf-8?B?Ui9uQnlOdmlXUUpvME80TXFucEF0d0dNTy9wa2JtUXVlZWJJc3pBR2M5WmF0?=
 =?utf-8?B?MzdXMW9BeXFxcG1CMFZ6M2FLUlIzMUNCOWZkYUNodjhSaVFKWlh4cnFPQ1U2?=
 =?utf-8?B?c1dsRXp6N1VQd1lJYVI5SUFpemFTRHZlNkFCd0pzd09PNDN1MTBTM2NoSlhG?=
 =?utf-8?B?R3ZSU215K2JTSzh6YzZiS2p4TE1scnhBM0xDdU5ST0R1NGFTaUI1VTc1K1Zi?=
 =?utf-8?B?Qi91cWtQSU5WaVIxRVJ5SVIxSkp1OHozZFBRbGtkSGtoeEdHZVZNeHdTSU40?=
 =?utf-8?B?N09pVTMrbVdDdy96U2lNd3BqSzZuSTVQN2FzaEQ2T0Ztc1BiSnJQYTZ1QStE?=
 =?utf-8?B?cUd1K2ErVWp6ZU42TUNTbG5ZcldlaWVReG1SNllhY0lWUlBaVVZwUzBnZmZk?=
 =?utf-8?B?M1RnbnRuK1REbFQ5T2xwdk56Qm91NXBqT0tMeWVHMnRKN0FmenovTFAvTnQ3?=
 =?utf-8?B?bnkyZ2RzaXFEMkZjQ0ovb1dyOTgxZDZnRkdRK1FFVDYzV2M4UFNwdEtxRnRr?=
 =?utf-8?B?QXRZeTFJbC9YbHZLZHppT1pqVXREN1BKZ3c2NXUyMjRxTVh3NEwyTWRnOGRJ?=
 =?utf-8?B?bml3N3puck1idzdBODVXN1BFZCt3dFlQVXZSSW1HbEIwR21vb05xNzQySGZx?=
 =?utf-8?B?VFRCSTY3dEEveTBuYTllSkgreWFJVFZxa3NhQWsyVEhlbFR3eHZiYlFFNzJT?=
 =?utf-8?B?ZDk4SDBNUkFaWEV5Ny85ZUorZ1ZNSUkxdDF2L1Y0QjJ4dGZxL2xYR0kwQmRa?=
 =?utf-8?B?Q0Fha3dLUnY2NEZ4ckhod2JKdnJDSnliWlRPTEx1S2NTVlJNTWFZTmFuZCtC?=
 =?utf-8?B?QXZIczBSZkExYXpjUnh6VFZuUVZIRkxTOW51eS9wRlI4MXg3eGc2UDFsOXFz?=
 =?utf-8?B?NW1aQXM2ZkJXekI0Yy8wK2RzWFY0N3YwdWk1a0hkMmF4VDdVbFA2Q0N0NjRl?=
 =?utf-8?Q?YKg4n2q2nWjEegPhKbhg+PzT0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZBLkDz98wk7WXpuY7DGp+jXl5oGJg9UBDasJBW4SeUPGFr6glj6gKcBM5c3enoi0lzBifAKDSy1YiSr8zMko433d3AJvafIW68JHTJj74rOr8pgj6Bwfe2gBUHBxq6QkKJEGmWsJxZVsHCOx3FKS7jBvzi83LI7npT07dtLRsn46R6hPPhwSmwbKf/dXyCwsrwlmQNkfoRhm4o29q2pxAWwjemP1TfU3gBD3dTI5GKrZwUgisYsjvGtUy29HrqoVhhfyZpYwMTgV7GaqAyn35UYyGN3dnayzn8uTWrMd4i9ZCLn9BK6yfVs9yThluqy1b1vfwbXkywnKztctcEbNxBzdFwyULtE+i5s85UMRJDDg/FIPRWL2tPwWfIya8SUgJeH4HccBHyZOfccg4nK+ajQ/3fD/dgDbCgCJsJDJGvOPvVBr+vy363GjeW23fw2PrM0fICaXf6LgPu6TEcZ3bcXVy9+5AHL77kV7vkIzQNfFdXuUmcndl6HbaRn0x+tCLS2KtiiJRGkS6KxV8RSjv7vjW6YlxwT5yQ6PORQEJv8PLqSsSTN1cj3lFTzblNyeMY3DPrATU3pycc2kMHNcesCmvhp0qH4awKEtOSUaG16ZbdQyVL1Zxfzc3CH3Bs30
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a0e56a-51d8-48f2-8a53-08dd6e98a6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2025 08:06:47.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMLXMUlYxI0OGgRm3Ygbk+EzhmFy2Dm/LOWzUY2NFBn3X3MJStMWn1mdYR16jNT4lwpSkFSfnUywBoWnbuwV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6875
X-Proofpoint-ORIG-GUID: O_YmYnw9sOb2Qi06uCBGXOXloRhmr8ei
X-Proofpoint-GUID: O_YmYnw9sOb2Qi06uCBGXOXloRhmr8ei
X-Sony-Outbound-GUID: O_YmYnw9sOb2Qi06uCBGXOXloRhmr8ei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01

UmV2aWV3ZWQtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCg==

