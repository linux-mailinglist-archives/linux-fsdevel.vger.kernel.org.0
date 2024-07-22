Return-Path: <linux-fsdevel+bounces-24055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C817938CE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0D1C24CCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457016C69D;
	Mon, 22 Jul 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W33XLd2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ew/fQw9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE3149DF4;
	Mon, 22 Jul 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642271; cv=fail; b=jkiI7ACXksAWMVrILUgOQsUk9O2AIZPwjn8BzL+vJ0HxgLWQxP9WAiwt8KEJyQ8vWpo7dBEJW9qG40OkvFRjhfkltT8W1rvPGPte+f4I3lRunBOZKOfSM8O2vm5TNBFc7FpCAkHYj2VWMicP5rbxdO7fjVwpnvLPTqEBWaKRyuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642271; c=relaxed/simple;
	bh=nH2Ecq2REDr0iyhM0cCeH8NB56OG+lgd2avHX4KZGiM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n+9C+dbQxvIVA4rPcTwheMq7RIY9DL5Gr6MCXQDwCEmo9qGiotfT7CU/HYWlH5EaM+RxpmQJc+JjZ2iJQDcOyGoUf+i21EnsefYjoBbcwse9DmnJ0Zh3Gad94Afyoz/kXwnXCgMRMrxOxnSuQJD93dBIDs9FvB8FBq4D8wOa1fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W33XLd2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ew/fQw9r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cu2w031930;
	Mon, 22 Jul 2024 09:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=M4a9Jq4UEc5vJg
	dquleHp93pVCgZ1oc7qiJe9yF15Dc=; b=W33XLd2hYqZT2+r4vvl3+sW3/sXCMw
	D97FZnTIXofyFQ5dlAX5IFWjakshjtEggJu8h7MI/PpqDWMty+8m8Qu951cMIyBZ
	mn0CQFqq+Lr5K5Wm7eLrepVCjCq0WAi8ImmfWuRsKD8PEZAw7GGr81AaQjjM+CBZ
	0Lw+nwxC8TcvjcxjKuWIhIPlHQshrdHg4H1EfMoEXEKutSue47YTystnicVsIkKW
	FIFOouGaN5m7z1rxtiMFs4c9O6hqOTIRgSO2dGOr0uIKQOBFfJD9FKeSDtVk5WAt
	CaKw1hSatUmr4eEJwZGyYGoWALWP5E92ag7n4Gzzs63UPRlZEDYLgp/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxp961k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46M91jJ0037858;
	Mon, 22 Jul 2024 09:57:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29pfh3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMUKMIVDxseB5T7Yp58uqMkDvceyUtX7Zc/DTiszCE5/2HSWIrP4PJSmi75s/ZOCCNasoZdbu6Jt3JWkuo6BpoB/kzuGEAr2bobmbl3IfGupv6Z//AK7CCpetmx5T883EAX0NCaWrQmb4sMTNzIdefNXSfu4J4fdE7aEcTazEnqaAGI0xZhIm8nT4UQbAmoBQRuT9DcJ3PcwVBGd7c65ui2qaGlT/HiqH0ZabIk/m0ASwyfs4DWhcCvQqIdq3gMjecb6Wp+SzvkIt5yUXEads3RMgsj1u9M/o35u01Hb1LMd+R+qgb2RVGcrKw5Gc3o9gDvp06F2OsJ49pyoEwiCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4a9Jq4UEc5vJgdquleHp93pVCgZ1oc7qiJe9yF15Dc=;
 b=iwWZXS+wyZ+eeLQEF31+cvj3KI6efG+0IeBuzdx95L9clx5P0Op3COth+A9fYQvC4diQ2QJ13KXclMOa/HiIAHxR6DNBgVQa75+17swG4FlJn/JWprNhzfr/+/vl0n9EVj53csrSmYKf85suxhPLlLmnUpzg7IdwL9ir4vHLQCfQG720oBZKV9PyWWNnByTdUCFIsp1YHh4LPUIO5U5g2zNtmxZGQA6mtvcHrufxdgMhTz5fQmCHJzCzi6IxFw5Iao9N81C/wTZh5knbIA6As3dT7zFp6va9VKd9KJj6Zki9pHqBrxHnVhXSojjCtwNtSg+QoaN2OMASXLKX+wnEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4a9Jq4UEc5vJgdquleHp93pVCgZ1oc7qiJe9yF15Dc=;
 b=Ew/fQw9rHlzMPlNgqh3RUpNdQliDJz5Stnte1Mqik7vJVwnnu/C+KcQ259fNiMsYIxqWSzLIv8eIjVRVRXbN3tQn0C0pEPNr7S9Z4sUorPwR2HLIAVJwCGQY72PBtfTBCbiIjk9qSEgVBZ3e+WIviVWaip7ea6eVEXwUOaOeF7I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 09:57:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 09:57:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 0/3] man2: Document RWF_ATOMIC
Date: Mon, 22 Jul 2024 09:57:20 +0000
Message-Id: <20240722095723.597846-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: d51fe432-9703-4482-a485-08dcaa34b43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y22mDWwvpAkCwbwAAMqtfyiqykqRb5yZR5cXeE/fOIqaKq2+uqi4kIXkjLMu?=
 =?us-ascii?Q?YxhS339zGWg+POjyc7KYh5ZSzW5n8SV55PwBK3++f7aBa9X3Vhkw39/lxcPt?=
 =?us-ascii?Q?B/6I0ZwntJbX5h7hEEF6xfGBc26W0q38FUqhNltDYU/7T/bIM08tbcZPbAPn?=
 =?us-ascii?Q?xjm77dh0vKjN4TlmxLwEEtWW5d4KzjAyLGjEjo3lZ7TCSxa43zmbkQXT1wmd?=
 =?us-ascii?Q?eSxgrCgUuVOfyTcdNqg+V+rfK2+IPp6s5eLgXbT1BESdQQfcOWxVEdGkXZCM?=
 =?us-ascii?Q?DUtnPKTD/k8Z4yB117SJM5lJNFaiMD5oaRYnb1raz/IWw4wZPxFzJsdYhecA?=
 =?us-ascii?Q?K72+8995rpL3EYKdxeR0MLSut3vf52CBoCyx3fJ/+bsTdmHbc2d/XbMMANFz?=
 =?us-ascii?Q?lg2KV/3q7X/r9+WaUtt21yGiz+pZ5AK/oE8Yr4y0/GBlUs+bqrDxKDJOne7Q?=
 =?us-ascii?Q?IENby+QgUPl+8dJ0BRFZ3Gs7JS1skdc78ePqs8qodLaE8TOVSzPBhRwRQf8n?=
 =?us-ascii?Q?Zp+s1BznFn0jQCqrCs9kb39uTNJApwS1SLEu2w7+r2hcdpg3VtYWtYQpCYLD?=
 =?us-ascii?Q?8jCmQrapWKh5BVidpioh0srHyS7/xpidFMP8Isi3DwnYtkyUukKIJ2ZdSu12?=
 =?us-ascii?Q?dTNVCB2vlRExI9++Q1UdIvEXJi3zU5v1HB4JjbpKuAAIP0mhu+epFOQztKPH?=
 =?us-ascii?Q?4gQ8sabeit3NEudErz1Q6KHCkCG5TS79I2Dxp7bviTdpdQV4cXT+f/67soJO?=
 =?us-ascii?Q?t+FTkb7xGrxylEejdkSaPN1gEoC4j016It8jgKpqV9DIv96MdynKaMpRYZg0?=
 =?us-ascii?Q?dL4bzwCT0+aiMi4gEpp+VzX4QqRYcFNx1E+7+GS09vQv91Dw6CLMVTSr9Bmq?=
 =?us-ascii?Q?Fk47E7YTFONIug3RhVCA4iaR26HGmlVlFuK4fUHU0YwzMbJ93Kzqb6TOBzkM?=
 =?us-ascii?Q?O9t/wcNbOu/4znRvOIWLxKZHbynfiTyMO0lCjE61+DRmHCbAvGrLl1JOQjR1?=
 =?us-ascii?Q?fKZW4gEshIo1R3gy1VDVIwnbZpTZbAp1648tjph+4Y2tZ3Fn2zs+pknxTyVt?=
 =?us-ascii?Q?GqTLn7FrFUBcQgiUoID/LeBATwglzJerxw8uSeWemE/2WouMl3yZxnAocc9n?=
 =?us-ascii?Q?epQd31NEVQlbMkBnoq4aorRwl8mQcPgrFNm8+H9GGQ5pZR5EXohtAIhD5V0i?=
 =?us-ascii?Q?0hcLRVFK9lVx4BUzS4lqikPFnBLNbxe4aDQm6uI2NlJw6Pnk3xRn37ySeF1J?=
 =?us-ascii?Q?AXeRtONbArIlvBoayPhn58PFbPexnd2xA2Kmjx8Cfsg5Z1Cn8ef6f6e1IXed?=
 =?us-ascii?Q?+AjN+GbVb1+DHVRWXjfHKACWQBcoPk7Yrd4WB4ZKoRobpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1YnAe1AFR5ZSIiY3qwFRaOFSsaU37u5OkpI791zbLDM+rmGXdI922SQNbOF?=
 =?us-ascii?Q?VhXtB1L00eGaniXv4O83NuUDaP/1RXCCugRe78SpiRxUW1L6rumFv8hnwTcj?=
 =?us-ascii?Q?Yz2Zq+vKPYDiCstOwgWib8mRgB5lisuBO4gmdb0xzgOQQHO9gJ797lqDz1WQ?=
 =?us-ascii?Q?XtHV76nySy1mRZGfoWZ8idRNUnP+dU0+w/EtVBE0uRsmrngQOprjj7Yjyl0C?=
 =?us-ascii?Q?dPpVQgAMDYpNm6kQ9IDCWBw7tCNaxIk2MSA6+ypjbTJ8/JexmHb4EdJu0+OO?=
 =?us-ascii?Q?dEMMxDIdvD1a3Bh4/XRe312klrEoORxV1zxSqVeTVdRXwzjNMe4ZjEqDJyQo?=
 =?us-ascii?Q?jiH4L9O7NiyP5sSGZdY/KW5qhWqPQjFkYm0D8p+Uk1pdDXtMaaavwqcQTFYC?=
 =?us-ascii?Q?+cgoUJiDiKlsFDZNBgIdVfjQYGykpV0p5PsBRByIpOgSWg+TAzXmEeJJMg/n?=
 =?us-ascii?Q?Ixm22CRwcBnI/+SGqvqyMOcTVFxbydeKYkOrQwsMDeDMAP0fFxlE4B6dG8EL?=
 =?us-ascii?Q?xqXyIXmNY7pyyKmVbelut0aRzVrMEl43vxHZ366+uGy04wcWsrdNh+J8cqeJ?=
 =?us-ascii?Q?L62bNmpg990cwtmkRujxZpW1oFTTZeNAIcOU1zQmriU926V3yJndErZGVQX+?=
 =?us-ascii?Q?lsmc4CW4DI4V+9rfJgpMQkB3aFhB+rrUbyQuEQxm3lOl3bC+HTEgLOgjyWIS?=
 =?us-ascii?Q?Hz0xnqAlq1wOOoZ7jSgcYp2MLfpas125PFLEN8Aijs2EqWW2P5RYWKpju2PT?=
 =?us-ascii?Q?SJpENPYn0Tr3yw6y6XDmxfGO84oU8aJdwvPsaHZRyzmlxRQ/s4GxSJJSutin?=
 =?us-ascii?Q?ZEpkVWJKGXkafYsSU4RGl4VDtS2F3R6tdfs9M3oKw2FeIOpYn1x/q2BIwnHQ?=
 =?us-ascii?Q?doOVJWI0SoGlIYbjK6RM77Gv/T+vkIHr9lq9e9/WLP07rXYhZhY9oGKKfOGi?=
 =?us-ascii?Q?afRYUZSAbECA7DBkiDi8BXR++b3M4VeEhPSLVj7jExlx+BUpqUYllTbN+wGH?=
 =?us-ascii?Q?JvJIVDrnzdDgo0xNeeCyCsyydGaOYJtogD1MsI2Dxs7PhSLl8b9yt6f/ZQ3k?=
 =?us-ascii?Q?LTQaI7Lz0GgWITKN+oRKi9t+7gLdj79A0vfiyac2Q8E//hpgLjF67tTOkplC?=
 =?us-ascii?Q?PtM+WZpAtMMrsowoBYxw8JBcxfhAdDLsMm8/zFciitA56OlLHHHCp8ah/Ipe?=
 =?us-ascii?Q?nryJsyOYmA2KhaF6MlomwYvZfkxmQlKS2TkIMtWEyGqqtdpPq/qp58O2uu5u?=
 =?us-ascii?Q?3CkOOL6Sd6dU8OpyT3SbSHoEu60YBBy2aTShCW5kLBm3L8lSGg0bIb7QLfoJ?=
 =?us-ascii?Q?rIp5XepwBIw/QbXF31sWrMAeN2tDr4kLgKXQZSziD/M7oJ0rr5O/vzm9xrDe?=
 =?us-ascii?Q?9/I0S0AY2an6L6Wuuon6ChdZoXaphZ9KJcejZke0AmiZb4K/zROKcXz9seRV?=
 =?us-ascii?Q?na2+6gNtJ/mjK/V4AvqIL8QtEbxgttw9W7H9LwlJWevOFB/ola408JAHAm26?=
 =?us-ascii?Q?4+mXHVSHG0eBlyNHJerJC13NWgfjmTTsw+6iumC6UVWzoGljYGKMmDEoCDM9?=
 =?us-ascii?Q?7C+qnD/1uOhrc2PNzGBTiblXaSb8CH4ZQDjcXK9SwJsySd9rgAY3FHRYVesx?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qVSBXyeK220nzeq9YhqyhBm8dFUAUweIqSzxrKFYyvxgZKN8jO5xYCDvWzHf8tQ/EfkTbXs0Bi+y4dWYxWZykcsoKSupk93atBdRdTAx7JfQPi0E5UP+Tq5dAjWu1EgFymXR7EerD3a8UQp62WmkBZDqG6hfHcEgspY7dzvv08CjAScI1S6tnXkXE3fBAguboW0vKwf+9v/h2SjmR3cflm+wt49zPeUDk5yUtyecKVS3Hw9fZN8faFCqYynJxP6/pQcAUkPXA8wdg+YkzIfWiPq5Hc9sHGp5EIEZ1PpP5PdGcvBH/M1bv92oeoUWcGZ5wVFBTDH0S54b+6wHHYFylAKHkLij/laIhwy4mc2piPAmPwtaiuKbt5IQirJMWqkucHZQjwB1lt8kVKdFphgFbLXtFeW14H7pbzCAdZB14yy/SqMUUZIT+9BwX8n4jxI+bc7c/0IFUUPl+/RIaAqAD/Gn59AScjPh4MU6L4ApycuWJenFPjG3VsbNna/7B99YgSSqom5eM4RaUMPOghXYZYBS7eFZJ8g8wbrUSuFSJAssdGMOj/O2TImzs3J3xz9NVutBCccJfSIMZJLUv7QUG2Man4wBRHDXAKnxq/GdscA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51fe432-9703-4482-a485-08dcaa34b43a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:57:32.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNFMxh3gvZE5Vpr7W+wby9l5rTuj3WSZK277oEBYubtji/3LnSeA/8IrewsXXMI7D8DDZN4cr7OCx8KvezIcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220076
X-Proofpoint-GUID: t_-z2LytkjnBhmdOXljCgs95WND1OXfU
X-Proofpoint-ORIG-GUID: t_-z2LytkjnBhmdOXljCgs95WND1OXfU

Document RWF_ATOMIC flag for pwritev2().

RWF_ATOMIC is used for enabling torn-write protection.

We use RWF_ATOMIC as this is legacy name for similar feature proposed in
the past.

Kernel support has now been merged into Linus' tree, to be released in
v6.11

Differences to v4:
- Add RB tags from Darrick (thanks)
- Revise description for readv.2 (Darrick)
- Re-order RWF_ATOMIC in readv.2

Differences to v3:
- Formatting changes (Alex)
 - semantic newlines
 - Add missing .TP in statx
 - Combine description of atomic write unit min and max
 - misc others

Himanshu Madhani (2):
  statx.2: Document STATX_WRITE_ATOMIC
  readv.2: Document RWF_ATOMIC flag

John Garry (1):
  io_submit.2: Document RWF_ATOMIC

 man/man2/io_submit.2 | 19 ++++++++++++++
 man/man2/readv.2     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 man/man2/statx.2     | 27 ++++++++++++++++++++
 3 files changed, 107 insertions(+)

-- 
2.31.1


