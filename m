Return-Path: <linux-fsdevel+bounces-18138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8068B607A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813981C21B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945741292C7;
	Mon, 29 Apr 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odAvedA5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xtFCDX+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403E128396;
	Mon, 29 Apr 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412937; cv=fail; b=rXEkBpUhd1P4E/rFMMFH2EXE6Xone+Ed1yNPYYhFuSAuA0NYfdPOWVN6lVYl/3Rsj+0teaT+gOwr7QLH/fZ6TWRXaqwFps8xeDCTwAuaCTDnOISyNbQPwHooQZH64YQWt2Bje2+ozZSlHTNgBJeRpJxLut4hyqf73h4IBL/YTW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412937; c=relaxed/simple;
	bh=0U1Gj3Q/lM/59A6wrRnadAI4iVWAMLN9fTcJUu51G+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NH/ppkDs+CPfOkIb0dMALNpccwrP+otwE7ilhXV9uI5fgJdiG/JUq9AsRX6+6TjrPGjI+1St3jsaIP8KU3CstKHKrSn4vCFUuJpgNT/fOlu0tqVJ8MfrJLkIelazz+kFrg2wkpEd81CGs3m2xtbdHYj4tNKKw3zEnEpjVjk48go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=odAvedA5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xtFCDX+p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwm5a024638;
	Mon, 29 Apr 2024 17:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=cujYjwAgxSeJQc8BnVyHN3WNsZ7r74mVihvnZTZtYZw=;
 b=odAvedA5vg80o6ipJKhOLM8WC8/6J5WyHW838i1M6QD3q2NPf7zIJRJ/4o6ChxQHMvYX
 HnSQI1vHQDGzBvwZqwSw2OKiwWFDnDvZb8uai9EGQpCFz6mAcvhbOEDOJfGJn4/p+xxG
 YHcR2UxkLjMw85OZKmYFaW+xzHz6T7Ge3iOrOHgdUgQWSiAdc6pLkKotrlEnxiTcnYWf
 uERVmplLF8UdTVbkf0eN+bkGM9D5sS1FQjIuSMlljPdeMewn2c8SD6twkHV7rubHiNoI
 uUgCPahjWkmHikaObRh65+CnxAVNwVA2WmePCWXUmUzAqi0ZHJPu8ArSnVX6NEiRh71f lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54b7hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUX004324;
	Mon, 29 Apr 2024 17:48:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmOmqdYBYh4N+3saXl5MDs2tw73srxmLpv/cNF1XoGmM0XovkqeiF5Jiy9LEk9zQirZO+MUOH0NgD+18i2CJtL3WEvL5FB5+CnWGOw/TYfe80uNodSGo/Um/zD4vO1oOxCJ+E061Kh3EN2SBiBejP4uViJuukUC/LO+fpLdwDyDN16jKsF7ZGcvtPlPiPGfOFDdvoZvsCgF9tYXOnK1QUliyVjO9Nvf/NkYop8y4KSJ9dXMJJszZr3JiHrR9ZzfVU1yqoEk89QRV8ZW+U1Z1smAHG5UCl/VuDVaBZ3vnR3eG/2GKE6Prl2QBQfo4Ahg/kK+a7xXcp/YGWQA4V6Oc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cujYjwAgxSeJQc8BnVyHN3WNsZ7r74mVihvnZTZtYZw=;
 b=cXXke1SpBV1qddHlNJ12ZMpT9aYB0PPCZSeQQOIofVSu309WK7mlPI3eAehyphVItMcVsaj1ERn7B+XngV0bkYzfLXtX9Ls5YDnGpQUKtFek4QmbAwhrk3cjPifSoH9hg5Mv7Ae4KAcEY6oYM2cBGdEM8cCDy/Z3si5L1sxXocRXDRAPZRu6+wKWLtUl0EcDfyOlnm3f5NbFdhqAtmmSHq3bJH3ZQH0nf0I8Y6dXrcvcIlX93L53xg3PYe2HDcy2Vi3EKyiwis66G5+dgp8ALLw/zfkpC6T4C+XrGb7Eo1iH8PbYH5aISiNzp+ZJ7W958XZMC+/ZFuA6KXkEhpFRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cujYjwAgxSeJQc8BnVyHN3WNsZ7r74mVihvnZTZtYZw=;
 b=xtFCDX+pRjcIDu0N6WWBomEh3XKV8Sapjp5r/bVE3hgapIamVm4sIXnmEHJ/UeGWg40XYWj5zOt6QZppb90O+oV1f02s6uD8FvwhPy8Tfgle1O6o5jJFn6qm8p3dT5lKMBswU0OQ/V0FBrfv+M/KnakdlwEswRoXGJrkTGFxI6w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/21] xfs: Do not free EOF blocks for forcealign
Date: Mon, 29 Apr 2024 17:47:34 +0000
Message-Id: <20240429174746.2132161-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa4084d-edef-45b4-fd07-08dc6874914c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0tyMJd/U9Wl/T2e0XahRzcdEBgKEImYag6SFrfpCsZS8cyt6ts6dBK3V2gRh?=
 =?us-ascii?Q?j4IzzzXY6ibsh8iOAQTYwiqrWjY1v53Ja3kU81hK1OOjMJPoqSgbQhZcKtLw?=
 =?us-ascii?Q?Yw58HOwxkay0dQ0WvJ6GAM6lFPznA/VcypX6ekSlXNM0HIxdDyT3SJTF1XRe?=
 =?us-ascii?Q?DjjqczMG9T9uuNRXYVv6qNYpkQv87/9murZuj8bvvSCMAtDXnAp0ChyHt+nS?=
 =?us-ascii?Q?nGzKP97pkDf6vHbJ5u3TMhVUgK6JhUFPbAOId6tNj6+9dxMAyCVMZK8FJ/Vx?=
 =?us-ascii?Q?B17P/hL9yXyfkz0f7Wf9sGa0xdZOogAp3dLebNpt35tlsERucooveC//axUP?=
 =?us-ascii?Q?9JowrJ/ccPl3Bjqj5jXLClxQklQlTgM5g1Ue0uoVBA9sSlHKUul+xgpw/Df8?=
 =?us-ascii?Q?1+TZ89hNcJPKkVOzGt/9lg2IKBbungDz0NVI7oJoH5pRfi1masyKcTivDCBv?=
 =?us-ascii?Q?ksFPVdRKMje/6QrzNnteAapBHWqqVIibHW1vR5KtTDQYt6E21bXQmlZmu6qw?=
 =?us-ascii?Q?NZstk3vDgb1XkPo+IC2hZtUXGBY4etUNaA2voyhwL01G2evAyt4czq6ZUigL?=
 =?us-ascii?Q?xWEJhv2pWE1L1OWyrPxNMJNRqy9EmawGKfJ82wLGZzaiC7XsjrEc6Y8D2kNm?=
 =?us-ascii?Q?lza2ZMeZkyAjEi2e2T8VJxzyZFqUMWxygY6GmPyvxMSC3iaSea+uQWrR+GXS?=
 =?us-ascii?Q?aspSgTDsT0w0pAQjIlErKf3tRyUlMPiaKn7tJO68jBC2z0hB3ZkyBnkMRHnG?=
 =?us-ascii?Q?1Yucp80lXZ4U/Y5oFKlYJ8rdfhO2qWbAES463gxwL34xWPdqESdZ8enLtrhZ?=
 =?us-ascii?Q?4KzQ5j4ACxzmF8ZaqAXL+srCquAfgVw11ugR5PMF6+Vl1bVKrKOadRYo7o5I?=
 =?us-ascii?Q?emlA/54pEPbk5ojl+gNpLqzeKBHTv7QfTEt2cks/Vt4mJm3g1rQNz81fUB2S?=
 =?us-ascii?Q?C6S1YncJBIB/iybkHSmBCruNAo2ZnZbDgK+MhgYTumzAAX/jSSPxJ8mX2N+D?=
 =?us-ascii?Q?x77R6V6uywmZPoeqh8ULiKXsUO7iIVVfQCk3S8OA5xTgV4NGci53+k0lcGUv?=
 =?us-ascii?Q?ZQVto7cD9EE4/KYGjAK8WgODxbmLBk1VOxCuUUTrZBIctwKEM+GudX3j+GOO?=
 =?us-ascii?Q?SWKEuZvtB+VgiVILlX159JVjv/eJNfq/mdLle3+Ec+4zGZMA1pGOO/VdVyRT?=
 =?us-ascii?Q?9/MKfTD/48wGj/+N1dMs/G0MT7TIZMKG0w96dk8iUeL8yUa9YpxsKyYFlLdP?=
 =?us-ascii?Q?VBo8//ksfswjF+53B+BJnAW2dX2e56ojHi59exAHGA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?91RRcrwHMTcG4yFAmWn2hgCtaT3Hype/MYohzyihXHmH760iTOSEvLV9D839?=
 =?us-ascii?Q?RKy19vxDqGXbnI7eiiI2wCA2e89ChUwFllI3+lzQjZNFewbJ8ZjFZXFCeEAM?=
 =?us-ascii?Q?LlHboqE6pO2zOcc3+GeryuLJsaFuvzl17gNK6HBMikE9V3iLMYBxJAxEsf0+?=
 =?us-ascii?Q?g6mLHvynNQxHNkf48En3IZU9U0EE6b6Zl+fJeryfYoCH8CcFV8HRA44JGA9f?=
 =?us-ascii?Q?OM+RHf0nFJHt4y9eivAHV5DaMYNeevTed+kztaF0EhWFT/QJdmkZ5LnPaA0b?=
 =?us-ascii?Q?Lsm2iGn0ihbGCM0K32w7YrBE+7AxuVJCYK3QPt/6BTHlNjbwix5sfDP4SxMf?=
 =?us-ascii?Q?m7y0jFtDDVcgQSiJdtwY5jSJofUNckBFtqr4aKnSry9Cz/kPOM/DXjk9WNPS?=
 =?us-ascii?Q?OW+KQoAHgE4IcWeAj2OxAMNF22sUr75pUnZ49dnsb7z4WOkv10rsN1evd8Wp?=
 =?us-ascii?Q?FNFf2GuC72+8Y+XhubEKw3LDIRd+HIrTLZ+iCB7PZxLXPYEGuelfMyVOtl/B?=
 =?us-ascii?Q?qflkpGzopQ1uGqk7+vMwn2p8Pyl/HEEUf31ptcXW5wpaL5lW5wDXvvx2AaBN?=
 =?us-ascii?Q?l3WChZIf891oiutrJZRTTwTmi5Ro0wK57/wBuLXR6aBOUNLXt0m6OLoYZCwu?=
 =?us-ascii?Q?VjyeQ7GUAYbaYHNpQeCJ8eIIKWFWrWyFDu6lGL9Bwiw8mCOLAgcGlS3opcPP?=
 =?us-ascii?Q?0OVZlKZ+/vJOPJ8moYF2PlFGH71Aenkxf7fPHKOH2yCClr/wVLyUXwskba5W?=
 =?us-ascii?Q?xhpunMIeErr/E7DIVqjWJ3vdZgjVQnbDiXAjvNShIgy9zToOxTVMnWSDDNTQ?=
 =?us-ascii?Q?ylvNqOs7LdYkvWY8lPSeCv49Mj5ExAH1YlJlLu4PkV5zy3mBibMkx1ypszaU?=
 =?us-ascii?Q?5ZI6tTrxZUbHoNE/qI4ihlERbKYbanxpjx4hRnTj84rMM/QP9N2eGUNK2/qn?=
 =?us-ascii?Q?n1hxZipIwxchWSIDPbTev8u62+rEFakrKnqqH/5Wf7/OhanFskip3DI5Cyfc?=
 =?us-ascii?Q?3+yFqakax0e1KSJJ8XVExUHBknuAGjcxzJmtNNIXxh2MSwVV6Q+GSp5rBn9I?=
 =?us-ascii?Q?faNE4Y8ccw3I2ZioQfrI1m0UVRGf35uUOWnWliAY5FLZiarqKF0qyxRDpMgZ?=
 =?us-ascii?Q?Bzzybk67q8M0kVpWxTDvOut1Vcs6weQjriNmX3D9gOJBtwZ8eysfaCGe7vPY?=
 =?us-ascii?Q?Mkz/oPdti1cYm5NP4fw+KvCP4WTQN4Lh/QGI/8b/KRgn1oOhwaGrqwzI/rHE?=
 =?us-ascii?Q?ouUOOUdDst2xwAojzsMpciI4y+dnz3ClmKc60QULFMGqWLz6mb0hbW2XkdEX?=
 =?us-ascii?Q?I5SYbRglTKtpjXdQAu7wNR5R1P2rQPlk4YkNAzjxZoRr0upjOmt2vjpK3Ibu?=
 =?us-ascii?Q?oyuDHpoS9Utf5IL1q8LJUf/rphleDgXUILkn5IlC46F8Is9tM2izK4qISNMA?=
 =?us-ascii?Q?bn3U6He3YwBy8VvUV5lDHbtVYEfpngU3GcEKBBsGDKmqUkzC9oVM0nGj0W7H?=
 =?us-ascii?Q?yAfO4FkapRpOvBvtyshaWw/CLgz2qGs/lJyuna4pIwGna+p4JICIY0qJlHIL?=
 =?us-ascii?Q?3Gxb1WCfuotA7TNt33vG8Yr8MW8EGEYTYft+G1EXUnVGFXNkbW6HUW3IW7xu?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7fBpFEZwTi6op2cq05BSsJlP9g7Exs73RoJ+aN7GZhLfS5jvCdYCI4aDDwXU5nIo61EmxF2/kZQIdX6/3BNywt+K2uba3U55dBBuBG/4EnGMps1r1aAXt4Z/U5IZHNCmI8XD2DhRP+1CA/nQb1FWYZY1PBBYN76RvJkBuKOmE2GPkzKkApy7yxUqpGhXi4h4HgqemOZRRCm3lm2Ytr0UnZmjmRA2mfQZ/1ZkBT5ZNUoADTfvwlgg3PiveLSwS8WZalCfZxYXW93wOwEYkJCGARuo7CihOQpTdD3ph1mhsGNPPLARO/eVcEO9rHffu2t6s4tbDWAOf7oEjUy8kw8X97NumwAVviZaFnJScr2I6TXFnDUJDsI4Y1rhmGWxZxxgyGBXTG0kP/JJA7jnsNC+XuH20RTHpZEH0y6Gg6nsMGCV7zUyz5mE3fXOMRe9DQCkbIR7r88zCPg1QetstBEnhD6NBESdGFvJLYn5+c/aYuslK/8G2vokjJhV8F5GkfdNYWuTc4bIPHFoel9OX5nPVBZ9l6CJvI4ulVf3fKgA3imMTDBZupU+pYDEN77I8/ZDGK90veyn6JpbMT+iCIxpce3InBvtnTkj4hL75UYQdHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa4084d-edef-45b4-fd07-08dc6874914c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:24.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLqshfIfGTb9YFzntd48Mg5mEFvpBxSMjwCefwuUx7KvFKWC+HNfMyShKtHWROk30hFxj08JSOaLtcTw0C5erA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: WHnWc_zOo-e1g1kgH9DOjTUfoS0NBJI6
X-Proofpoint-GUID: WHnWc_zOo-e1g1kgH9DOjTUfoS0NBJI6

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 19e11d1da660..f26d1570b9bd 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
+
+	/* Do not free blocks when forcing extent sizes */
+	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
+		end_fsb = roundup_64(end_fsb, ip->i_extsize);
+	else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
-- 
2.31.1


