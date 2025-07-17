Return-Path: <linux-fsdevel+bounces-55278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED50B0927A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC0718988C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44C30115B;
	Thu, 17 Jul 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RMnYSbUN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sp7BTcGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B72FF49F;
	Thu, 17 Jul 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771471; cv=fail; b=sZfufpq0D61h2oP8Mbf0Y0DEjyW1Kz907PWaVFVy1qk9A62qaoXkwI3tslxrQS4KHE3yRcAmLxIIJKkVgPuiGkpDk4vgrFT8XNE92LK5oRzwRg9lF+VtI/2RstOYgXDlLglIFv6PxPnMDLw/XV1iMpEtvLLvWQz9VBDWvLT3Zuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771471; c=relaxed/simple;
	bh=TZXlgKiJsP3LkRnPm2BlyPKv1wY+fEyAZ66TXv+XmXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGBqPZQc+FKOURnlfP3k2tZZxG2sP3lkKUgDU4/aOu8PLfWAuesZ3r+AVNQr+BNT6uke5Yi+fOMVp7+xZD7MeO/+BYf6PHLZmNV/kURCfs6BrF50M2iRFmLNsduNstXXa/ZmG2cVPNZ09aZNH0HcM0F6jeglbB97ILON7zdExIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RMnYSbUN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sp7BTcGL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGC7N4010969;
	Thu, 17 Jul 2025 16:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eL04BCl2BmcL2sKvZoFmvGU3nQVFHZ3aJpCe8behg3s=; b=
	RMnYSbUN4HVF6CioJ+l/M0NO3J1IXp93FDme3On8QldBCAgVRCsWRjX2JQDOfFOB
	42xxgLGz7shA0qzs73kLAR69s+gwLaFTFQBipRIkiEE5sFp5kplx9k4bqPkTBNf3
	lsD9CuhHvHfVgToHyQp3meM1/YCtMMT4UjonbX9vDnCVc7z+ZDHmfuNdNgVCfpJz
	0IZRusWOtyb9ahu192Ct380iGAozW0OrMU2yjqMCgy6VQzjr+TRxJqaErWErpApi
	6KoZSL4hHj1UkB5iMPD+GvJ6PbcJuL4QQ5t8LD3yAvg+iF9maZAd1Hl20bMaV87N
	7ZwE9Htve2hWHJ+gTG8m0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83snu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGkrNe012988;
	Thu, 17 Jul 2025 16:56:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cgs5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMvn2VUp/CJ/exF7NdxF3MIkGuAU7LupSJ6taIbAm2aWobzyyaXN/ibguSM/D6tvKSiTAkZ+t4x/hmGG3/feCJvhRlDY77mM3pNtTSECAPa4bUY0xKvUJemd3GMyCVL9Vmh/pCPAZKvau7amZB0MFyf1sW5ZelEPIrXvzPCfFzgIv7NCGcF1SfwUvxK4dKSOcta75Kn/XqEHadD97TMA1o/E2q13L3j7r51SmkfzzFmo6cZrxNWEUjYuALkmRLmaXtR4LCv/aIWluy5o2LLxFRqr7dLPSYCmSy2+8x58HI7tQOAoLVSA9Bmc4ZLhhuURR8xzxQjuOguzWJUzcunetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL04BCl2BmcL2sKvZoFmvGU3nQVFHZ3aJpCe8behg3s=;
 b=AU/qtDbDp3b4aoUydCY8OPhQvHDKf/PF9XWHIzXxy9V33LD2t0ECTo5tIfVhT7PzgGV7ZTnqB7mhTrQo1TlnekeinHQZ1SGRWkTyjUuaBTe7x4gaU08Wc7+52vrklKLkwiprcz/GLBNKnCsSfPei3vJfC09a5aScWa0lHD4cFlHukdXPpmu+VjZvvR/vSbmwMEDgCIxL6KiWCChz7Gmdk8LmC+hKWOroFTfO27hDJJfTCpbnpLhORjAiArdrqSjca+z/6Ctv2bgHlBC6bhWan9oLiXJA1f1qvYOAIeX5LQ7g5a9IkK3k1c7i5PydWe8IkN4aLnT6xqLEBajKJqMcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL04BCl2BmcL2sKvZoFmvGU3nQVFHZ3aJpCe8behg3s=;
 b=sp7BTcGLoWHUzRjarfG+fxgOrjaIpwnEPrnXMLMQakOxp1H1ypZuqL1zP+hoo6VwqgRGGiKpaLDzhpT7FaDKehgsWaj1nehT1nJwJPOWlsFjwOG3DD/VNp0g2MWRyC2NvP5zTOFAiu89l1WbNyS2jv8L88WzNblqDxRlPGWcQnE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 17 Jul
 2025 16:56:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 10/10] tools/testing/selftests: extend mremap_test to test multi-VMA mremap
Date: Thu, 17 Jul 2025 17:56:00 +0100
Message-ID: <139074a24a011ca4ed52498a7fa2080024b43917.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf8e321-fc3a-4c1f-bb3b-08ddc552e057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siQccWt4BKRbfJUmB4rBPWncbcmb7PP3AEgdMkGZch8NfSKHXCB8S8DYiNl0?=
 =?us-ascii?Q?J3N2Wryv4tDYCx1miG3zuh7Il500yyH1ALnIaywILSWDzWTxLYwPfsEAzfeg?=
 =?us-ascii?Q?B1TveSGvz0UH1jpPETD2YxlQGGYJF6khj+Bx0sRu0hyPiJ+kAIUeGBQ/NrDO?=
 =?us-ascii?Q?VOPLG4klJfrQGLj++e8g101I98+VkubBHGz5B/KsgEQA+iyBMgCeVT1b0E+N?=
 =?us-ascii?Q?kgZzjCPKFZVyW13omELwohjVEvRsTz6Q+VQHb+NWHmiXJ+Ionns58zGy0dzU?=
 =?us-ascii?Q?1Q3LqaedYibl8sqfCmnWniokclsFmOwmz7bOLjp5HbTfZeOY8jiGaOoYtvXg?=
 =?us-ascii?Q?68cG/ELlVfSmfqJ7ccBEVHoGzIlsgztLKFU6xYXqYwpJNfQKihvr12l4kp8W?=
 =?us-ascii?Q?t1i0buE/00C/P2KU1PxeM1Jxot0QC9mBhHfvb8AGG2npIclmA/PcedscktLq?=
 =?us-ascii?Q?f1WTTGK76TPxbl4XzHJ/l+YcDD+L5XjV4LZXQ9ZNVcMeeIV+gNUJV4vXFNGN?=
 =?us-ascii?Q?mb7P5UFroveduqv6+l9UaN3TGzl7KZlIOo2TN0ezPM1W5eADeEox+JMUML1R?=
 =?us-ascii?Q?d1KnITDHfN6NHKGMXZeVtYxtG40CV4tj6MI9mQDEQ31rnZJnM3wGHjkbTkpe?=
 =?us-ascii?Q?/Y1SRMPt5ERgBxAt+NJeFW6Sa9TeuSpS+4fR4R4d36tyqdl1z1ToVTVd1jX9?=
 =?us-ascii?Q?/h/6YaNiQrXxRswW5LSkB5yToTMlOI49t6k8lPSYsHX/ftaCnLvsDSU9Q1+l?=
 =?us-ascii?Q?GHI/OC4moDM3zSG20iN4cHU1KinFSnJFg25EsPjZCZI6CPtt3LVQ18/suLte?=
 =?us-ascii?Q?C7YLWmfknWEgo1XrAwKm+218HK4KgdXDz7PQsE+cJuJvpe2OHbYp8tgoWLVd?=
 =?us-ascii?Q?Pr8hVuKj4yi7pC6c71Ev5t4uMeeDWz/Tyuq/kQjQLQtbb2JAfm+VeyOQGQHK?=
 =?us-ascii?Q?jxKCV/9vH+CutAICaZqNNWtMitbF6WpyxuL9Y+Dxj7YA/E1H2bJ+0l1tUPjG?=
 =?us-ascii?Q?A8SOp/LfQhwD6LvZz2NdDQeIjF0ywrGl5u1AnRt/vJVpaAQYgsvITgdqrLjW?=
 =?us-ascii?Q?r6xlYwqiCtNQldzxsUJXDeGrH4oxq5AnQbusiaV64AdrqFn6JZU30udCCe+l?=
 =?us-ascii?Q?PQ5TLXte2iz1m2EcHCBRc8b7FgLsEMLJMvgGIy8aMt7h+VHXQjCLUR6QvMki?=
 =?us-ascii?Q?/gm8mAVL67NwgfwjVh1JhlNCoBZMy9Pdi7JVXMBY9JiPpeG1wmgP5yI3IA/O?=
 =?us-ascii?Q?VZTPmww4AWrEu7+OPanHru6QQBROLXpBDXpocAFbWgkGd3eq0bpEYbuBCmbM?=
 =?us-ascii?Q?uHMUM9EQlV1LSIWX5b1L7rur39nfxV6u7aQGp+e9/Iv3PE7/fw1MHTxB/rco?=
 =?us-ascii?Q?SKhpVXLMXvKns1ZrccjBj8nt6UkofJNu22UL/bvRG0JjKXCziw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/KX33B68NJbMl3o+k3BK8R1E4oGPm5ZHZrJepqiNOELLX7e3nJBRVls/Ol9?=
 =?us-ascii?Q?nQKyOcH7S83goZRs24feC39ejk/QN1uRT6q34GKaCrE/EvONj2eTnC6YNJAk?=
 =?us-ascii?Q?soM8sb1dBHft5MNOX1N89VnPqmaMHT2de7/cpf26OR3xxuqFrSaP0xC5vkNh?=
 =?us-ascii?Q?hVshklUZhuyQHkPfMwhyGay7MuQv9FOOLsxWKbmDoNvZRHzPEQM/RnAnp0+h?=
 =?us-ascii?Q?FRAdkrP4ru9KqJTSTY9KGVaaQ1tkUMg48P5WfGRBNCr/PySVsIflCxuxW/+L?=
 =?us-ascii?Q?By8kXV0MduP5qG59RZ/aXQxNakZNc/DiKUgdkJBJF0HMSHMCpyFfZQ1iWiQf?=
 =?us-ascii?Q?rel2jiFT6JJjhkg93N2rSKO2WUzdjrmq7DFy/sf1zkXccRW3B2PWE1BqRH7S?=
 =?us-ascii?Q?rRbu9IfrmgbRAeCpVcbVdnKIv5eGk93Hq3SD0aHLDqQrsYBTdo0ptl3SEvzE?=
 =?us-ascii?Q?OFEpNVQRbs07A3z/sL+ZuD/AaS3rBkTTGpa6XgPLuB/jyqLnuZETH079J4Ct?=
 =?us-ascii?Q?PKQmvzML3vaiDkckXHmsMTsLj4DstW6po+CHj72iIAElDMKwX/l8X3tP+/Yi?=
 =?us-ascii?Q?jZ9aqHhPL5LwDI8wZ74aPMJ8KMAWhxOCdhHNYAN1YXsOx11tCQGqzbcWUuEZ?=
 =?us-ascii?Q?0sOXqCPW5KQ6KPuCJPeG847Rhc4oBVxRqHsqyDegf4CmkEYPTmCH+pTfxAAb?=
 =?us-ascii?Q?3ODC3zw9/V/umLoQLLJRDVlmg4drhmpCP8PAf2ZTJChy72Q7S2+fugf2z6mn?=
 =?us-ascii?Q?P0ol4zX5tvglHZswXQrVIPcspzTHvT2ubZCTCj9a6MfUy/rId+sIC9w422S3?=
 =?us-ascii?Q?zBJ+ek+AuRfTyZMR518XrZo47V1f+vvQDXpfxoKVV11ev+IhnXNbnoB8rZOB?=
 =?us-ascii?Q?mioHaprQwc0zbd105/h21CKD0QjwOqkdMr9L26gAj6XZrGphdBeWm+UyIecr?=
 =?us-ascii?Q?6m3VK9iuiEASIZ2JcGwK/9VdVHb/WK7aBPSOKXjazbKQx6D6I2CyE1GPp8IH?=
 =?us-ascii?Q?BogucKm7y1m7vJUdAdgHJrX+2rR3CEJWHDRtSkFXaPBUBvZ977+Yih3VHHXW?=
 =?us-ascii?Q?dcg+cOw3HrSF5sLdJ6urdGOfH0Maf1U0wXC5b9XFeCBuTbFBaXj8gKGjr3r0?=
 =?us-ascii?Q?3uPVUbLLmBKETMrDVfqzpHWurq7mLbnzRBsHy/Wuw41KJBEmBMmbQYftIBbB?=
 =?us-ascii?Q?LRiIbwKhstDdTOUC2DkWCWfdAqmm734F2qtktmfHdA6s8TgPTf7GzSmsRLpA?=
 =?us-ascii?Q?35lFV8rglLIoYw4HblB2D8EJjoYsBgw3Op+a6GJNra9sIq2u4fBP9E+czq9U?=
 =?us-ascii?Q?T3aGCWL8DutNcG0oviu+Bj9MAunE+Hs4PGfCETwZcl0+3ALDFDkzlnNjQ17L?=
 =?us-ascii?Q?R8L5lkh3DWK0tB4NNntUk0FJGDLAdCW5yvK2yvkrPfm6wpLFKY1jw9Vk8VZx?=
 =?us-ascii?Q?bD7azIEZeTT5WcQfWNkDo01P6FflXHyY8B7TMFbMnugeIYpqO/c7H531CJxq?=
 =?us-ascii?Q?B0+TFYxwgvGSxG25ahsNtYb7YS1W99Dw8Z+TATHX1SkLP2Lm1UxPQZ9qn8iD?=
 =?us-ascii?Q?jnZQUWLNbFUoaEDZzr1MHsjsbsgksbOqhzE09YPNC5H00s5M6IhRxK/qYE2A?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jRI2ECsHtLchsobRjHXRSaT0FzdFMBowu6yvx0Yp5dabwiwNpBv1mrSUGtdypQ/qfK1FuEFo4PQv9xdesYup0Eucj2RQOQZ8jAPi8fSVD8wZ5zOmRSSYFN01VRBZ3Pc9YRhqscBuRLcoHpB2B8PtGaZauSG4XL+9ZDpgWOAC/vX0BmmpCmckkcenon+S2hDh0OYnUdNAFkIiceDvvav78IgDwWr58UWvQ5awFcdR6svHiS4oOU1K2pskJQQhaR3mR6u98IBQvgr6IluSQK5PdDK7VO4BvYVqxBe4Swt0WW1eZ9OpF6qp04jqeHvBepplIbEJFuacpxJckDegpfWHefc/pN48viWSA4VNYvK1r9cuN0qBMy1G4M9ogPUyAt5bQNX6JczagmlxNXgxuoqe2sMLjMMtmpAHQdhDrb8D8OO6+6g5fehw7l+rc9CMp1mPtdMnll70Yo0UuVvTGgoviARsE2j3ACZ/UrS1Fvf6QELglGCSXw8KmFWJrZSrD9fyaHQkapW/Wovxu7D99OUa8IH3VdWbFmWR83b+KSNiGEh2DuRVjXF38XvTvR1j0ciGHcUyX7g6l/tK1XVR+xZOAdwBYRkEsf4b0IHhR556xl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf8e321-fc3a-4c1f-bb3b-08ddc552e057
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:29.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZxNVl+iwASgsGOUOLnXDk9KLKmn2jwaPT++FwooQdav+8/ETisTHHBOccLev/wo/gYCn0BOiUsSqmTD3KGgGzjL478G9NiH0YinDRDx8gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68792b44 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GuY5gsdr9MwsYxRlPWUA:9 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 8ugXlKVSAd4BTJI_7uguYu-XkFd251bU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX6c37bkbxL6SW dasO+UglZjQVU/3tE69UgDYh01Ppd0m4lIylwFBl9L2wr3wzHt9bKGTnIocOBKt9wKOKDH6vY7b UDNurdEzHeZrNNm503w9TTILC6UFIC2LjVKOhCwrGziOyP5fcylga4jtTTdoSRjS8tyNd7uuxH5
 8jIatPjyRbjJ2QUDJVM7Mqhw3PGq85C6+4oJtOzq8B75mdxdRLsVab5xsL1bIjl1Dz4ZZO3LwQR Af5Rku/s9e9dWgSjh7zAVJ+E+FnwLBSVBLpV7q00PNhUfjwxqWgiKaGkmEdRrucwWEkYZwewztZ OG3vg4gWoqzmXsgJ3qb4leNOzWbBatBng9r/QsTG1+42u+tSikegzaVhsmIztQ69qUsYSTmL4U5
 MSgbWBPXMN0zoYJUiWSUPHdCkGJxSuBhiYe43IIBZfLwVunHyVi/wMcU5fvFaI7B++JLcqtJ
X-Proofpoint-GUID: 8ugXlKVSAd4BTJI_7uguYu-XkFd251bU

Now that we have added the ability to move multiple VMAs at once, assert
that this functions correctly, both overwriting VMAs and moving backwards
and forwards with merge and VMA invalidation.

Additionally assert that page tables are correctly propagated by setting
random data and reading it back.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 146 ++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bb84476a177f..0a49be11e614 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -380,6 +380,149 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+static bool is_multiple_vma_range_ok(unsigned int pattern_seed,
+				     char *ptr, unsigned long page_size)
+{
+	int i;
+
+	srand(pattern_seed);
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		char *buf = &ptr[i * page_size];
+		size_t size = i == 4 ? 2 * page_size : page_size;
+
+		for (j = 0; j < size; j++) {
+			char chr = rand();
+
+			if (chr != buf[j]) {
+				ksft_print_msg("page %d offset %d corrupted, expected %d got %d\n",
+					       i, j, chr, buf[j]);
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+static void mremap_move_multiple_vmas(unsigned int pattern_seed,
+				      unsigned long page_size)
+{
+	char *test_name = "mremap move multiple vmas";
+	const size_t size = 11 * page_size;
+	bool success = true;
+	char *ptr, *tgt_ptr;
+	int i;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	tgt_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (tgt_ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+	if (munmap(tgt_ptr, 2 * size)) {
+		perror("munmap");
+		success = false;
+		goto out_unmap;
+	}
+
+	/*
+	 * Unmap so we end up with:
+	 *
+	 *  0   2   4 5 6   8   10 offset in buffer
+	 * |*| |*| |*****| |*| |*|
+	 * |*| |*| |*****| |*| |*|
+	 *  0   1   2 3 4   5   6  pattern offset
+	 */
+	for (i = 1; i < 10; i += 2) {
+		if (i == 5)
+			continue;
+
+		if (munmap(&ptr[i * page_size], page_size)) {
+			perror("munmap");
+			success = false;
+			goto out_unmap;
+		}
+	}
+
+	srand(pattern_seed);
+
+	/* Set up random patterns. */
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		size_t size = i == 4 ? 2 * page_size : page_size;
+		char *buf = &ptr[i * page_size];
+
+		for (j = 0; j < size; j++)
+			buf[j] = rand();
+	}
+
+	/* First, just move the whole thing. */
+	if (mremap(ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		success = false;
+		goto out_unmap;
+	}
+	/* Check move was ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Move next to itself. */
+	if (mremap(tgt_ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, &tgt_ptr[size]) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, &tgt_ptr[size], page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Map a range to overwrite. */
+	if (mmap(tgt_ptr, size, PROT_NONE,
+		 MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0) == MAP_FAILED) {
+		perror("mmap tgt");
+		success = false;
+		goto out_unmap;
+	}
+	/* Move and overwrite. */
+	if (mremap(&tgt_ptr[size], size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+out_unmap:
+	if (munmap(tgt_ptr, 2 * size))
+		perror("munmap tgt");
+	if (munmap(ptr, size))
+		perror("munmap src");
+
+out:
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
@@ -721,7 +864,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 3;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -848,6 +991,7 @@ int main(int argc, char **argv)
 
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
+	mremap_move_multiple_vmas(pattern_seed, page_size);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.1


