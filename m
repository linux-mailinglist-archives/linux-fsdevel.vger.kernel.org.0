Return-Path: <linux-fsdevel+bounces-42772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8190A48762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBA33B995A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2626D5A4;
	Thu, 27 Feb 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z465q06/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZskerN1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EE26B2D4;
	Thu, 27 Feb 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679731; cv=fail; b=rjXgMSJR6wfP1ATc5GfysZngdAlqpsXEeIXCrXq14Pr/fh7A63rHId+u6ONBNYvPZu2QqSbpJivvf/Aj58MK3YbhkZmkg3d8Oy5ShsgLZ57D7v5lDvVR/jsbwou8oTB6nBUrChg1rhBdP3TLPoWdahbjghcIqvZ/tr+4lOw0MFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679731; c=relaxed/simple;
	bh=7UZoNTdzs3+FVnTRVfgGUEpO6hG6usJMxL3E38RHP5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnBNzhrtYE5N6RdRcZ5ASVZx6K9Kqx6R4wx+c6pn9nj9WvH5yxJlUQO0RsHDy5BNmUHBF03snSJEqGZ6urzyVJL2ego5hZcBDL/N+ZbS9P7Vcdz0EBjKjFDv3RGOlicAl/3Nyb++q4urH1z7nfXgO7ZFjE3jnPgUTFoNZvMVszc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z465q06/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZskerN1i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfkvf005600;
	Thu, 27 Feb 2025 18:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=INlzsWks1g/n3Ln3SwNuRsPPhjDGU2NcTMWtvnYyXiQ=; b=
	Z465q06/2jOayHKtwjfCUfY7BGEVo9z97PhCzLHrm1jLlt0chekON9Nu+jVbzC22
	tfOGnkw/Fl+a4F8mk2C/T4IVVL6OSG9CHnqEy3R6gHAyr3tFWvxT00PMM6/bbM47
	TnMY0cCBc0JzXN3dBvmM6Ys7MkGQG1xZykD1m1d49p/O0t3VKjKnVW3hnApeZOqX
	4nVUg6liW0XgWE9VjIh9MF5UYp5HsaOR7nAxYe1veZ5PMdrzlscztD12oONPVjWt
	sNr7ook7PmV1Ygkn0mkbjJXQwv02OJTorvESCMSyAqABDgp3FvfZo1/UNCMSoD3q
	NRZ0TdLa9g2AnoQyFaO5Iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3xr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RI7xVx007414;
	Thu, 27 Feb 2025 18:08:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51jhqrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAG7paVgu17ZqzXPjYIL0vU3RKR1TZosD1+pmFerM4cejL0uTWhElHOu0FHfug2wqsi3yzthIv/TzfzavSGbzVdK209XXwwbMhwSJq80Znkjr50kg8vUcon0WyhsC8JQkHkigQUyh7oKCRRM8vgPBh+Wk5IpFWLQ1SRiKrVmqkM3vYT76jcwXML4N3yUbbNFXAUdgNz2POzrv/OuoF/xsrMTtZI35Sz8qPbQIB3rPY3mUgDqMlwaCJ81hPxfrB96MdydFlIVS/2zBHnaobzpveu3LwBsXK7fzFBKr2FMBC3JWrEY9T8bQ2gnD7cjfxpDIQs7Thvf5WyaVM5wAEXNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INlzsWks1g/n3Ln3SwNuRsPPhjDGU2NcTMWtvnYyXiQ=;
 b=VTwOU875pWh2lZUJ48QvZ2a7AdvRssvQJEeGphT3lTcBgDiNQK2+nHbwG/vlTBGLgy8C4y4UaTmOHg9WJZaLcxzBebniMsZmF2w71vRnjYNRQJNAqcbD7DHOYKVbBrrpU/ISl68UcBvaC3PgDaBvV7oUCMbcPIPgGqwC5TF4SND4wRsK051ek00KOnmTM7mzCZ492qir33kDFbnrrHbx8bxOrUS1AY/v4vR3Thi7oNs5hCvnkayWv99b9Dagxsx2Y1rREv0sn8cCCl1ekS7wYhWeqRA5ZbHJl8H4KcvVsfhZo05UtnS10Nji0raiboJz8wSsgXgOu60yktVUkhHItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INlzsWks1g/n3Ln3SwNuRsPPhjDGU2NcTMWtvnYyXiQ=;
 b=ZskerN1icrqScx0queiD7pwAslkaXPrloPHAuxBSQ3t7Mtt6sgaJUiA/EMvDL+dftU2HcEwAeAc5p9ktM2n05QK58j3yPzuSuHKyr3PHIzZIIQNGp/GSh3SOifcQQ4qUUcSssaHiFjnmiE/UCt2GIukpWVmzlAZ9QwA6sjHL6cI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 18:08:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/12] iomap: Support SW-based atomic writes
Date: Thu, 27 Feb 2025 18:08:06 +0000
Message-Id: <20250227180813.1553404-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:408:ec::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: d09def85-b975-411a-ab6c-08dd5759c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldLc1nfxKgOoEpwRqXL0eXT7P5GzYfQG26rCK5JCl5BRN5BmyWYwdu/DsTc+?=
 =?us-ascii?Q?Wu9LEEfLMJAudo10neV2x8ulkyadwKKGu1skejhWNY/VlojoO66WqqrsV9eh?=
 =?us-ascii?Q?10PaWP7f535q0KBjvs5tePPe7ek6l0GkWXWYCpe4ytWRWRi2pxl0cEZKtLmd?=
 =?us-ascii?Q?+6mvCJgKSY555Sx6Pe++tGyum1a4IyRNjATJye9q4UFPeNYr01Wvo7W7xTsj?=
 =?us-ascii?Q?86JLulMzkxr2852KJuWCn2LOh7rWlDtcUj7VVVQ0xKtlAhlqjBABwqaOhnT4?=
 =?us-ascii?Q?2olAPgvxjQlUisP/KfzNYuoltfcHIZk9yG5kVvP6UbBXdHCoQ+ui5zM0eVun?=
 =?us-ascii?Q?a16m6Rz1nfJ+E8rcq8d5oiWKI9NzK6I//uzJziovt3+HtSWzIhXwcx0sWvWg?=
 =?us-ascii?Q?e9NMPiCqyQjpV+ToHVZCOHg/wmYKyROtSbfg6uwfE+gz5NiThrvmA3FF4fGf?=
 =?us-ascii?Q?vWpkRWD4f+H+QUFQFWXmdynW7Wy4pa68GvR2bPwHD1nBmhBJN+tsW/7df36C?=
 =?us-ascii?Q?xEsQOohpIWa+v6ST9GEox2a4y9MF4v5jwEu8z8r68F0fj7azhEBZV0jpMUjK?=
 =?us-ascii?Q?W4sMISknhOXTjWCGGO5CdtdBeSGGX4KUQWZ7oS3ZCH/eaGty4YuJqlXagjBt?=
 =?us-ascii?Q?/CRtXUiEWMVmEuVChIOgHddZ76tudSEHSj1JSiXna4b+9hmh73egkdmlKpXn?=
 =?us-ascii?Q?WYyweg2a1Q0WhSolP3U0W7OsXoSQUK5beOf43789HdBWuauZ2P/NkwhfzVS9?=
 =?us-ascii?Q?grLlyVtArA73Oa2Vs6tlrfExHsMd3ZjWOiq4Kf7joSIEoHNGv9gCZ6Dfvx+7?=
 =?us-ascii?Q?Av8zKfeDKByB6qP4u1PaaoYKcoNsqX7JCH8FRl/ahGxLzmKXvBd1eQfy8zvX?=
 =?us-ascii?Q?MF0bJlhrS0T83b24SYxq9y7/eTgHkjXDqnFZX0oFvSgNHhuhlM2IjXcEctFc?=
 =?us-ascii?Q?rfe2gN2GcqP4s4KC1ci21wH3t1GeplDdAMZWyN/EXGwrU7zK+/helIBEPW8U?=
 =?us-ascii?Q?AhuKZGcbqXjwTlsavbWVth+4Nk2RCENr47jHZMRmiLpFsnlNtTnJp4EcvqQ0?=
 =?us-ascii?Q?Tw+MK31jENOXFJxVZ4Zk1myajJhfKdGmnyFUBASumRQJb077PwBrPyoQbS87?=
 =?us-ascii?Q?Xp8csrJ6C7ApxxCkFhZ4t5GFwKDzWZlztfhmh+kKJySeLSNM/MtF7yMqnaW/?=
 =?us-ascii?Q?MA9FbDEhNAWfAbk2VwoaY5BmuLT5wUHKwCWZmRq8HICbl9+LgFD0+g2xVW9j?=
 =?us-ascii?Q?LaAJPICj3coCYL+O75hwuXXLawenoV9kbs+JmR79xw9Aq4jDb713zXMLhb95?=
 =?us-ascii?Q?5GhzpL+oK3KysAsJ9xFTgixV8XC6Z+lmSTfBaAewfDV93h2n0mvmY4iMd8pA?=
 =?us-ascii?Q?WOFI8eYaVJY33dhna8dku4fQFGmv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?meVYUabdqyKKIg1+xmp+S+ZR+AjHMRmRiUTjgm2jVFp24hPByEzDLqOhimSl?=
 =?us-ascii?Q?uD+ninl+umJDxzEJ49Q92HXHeq+uPSsSHOFvx2JcUnGUEvXpBvn9tsBuSSGY?=
 =?us-ascii?Q?TrI1a1xX42lf9vFS6u+6WOPaju20HnIphiKdurjOdPA4fmSv8G+8mzpwteD5?=
 =?us-ascii?Q?YbufxaVLcAKpwFuTUXilscWAWZiU/N+n3BwE6NWZFqA2e6VydSsBxViJf9cZ?=
 =?us-ascii?Q?dCIf8LGhCzXI37m9WZzxcHMUfqEyl6URakdlxPidjA0PcTB8auSVPFn15/Zx?=
 =?us-ascii?Q?vyPjW9MiNBHwqg+WejCVvAKWHHCAiH5KGX3j2yo5guTelYseYP5M24B6bqXI?=
 =?us-ascii?Q?FWisUStjBjOwv1eJZKl8OzJs6A4JWrIBhZfKj6dPU6NOBEVRl0yHPUcCuNMS?=
 =?us-ascii?Q?p871EUEsqKcDXK0HcHfZlV8HhxTSe5BxWO2Ih8B0bAoa6KSwJTpMhS915YRN?=
 =?us-ascii?Q?Dxxq4XhlwuPwQ8xGUTSnM28DSZ7VMSNt24935koKK+F+aqC9ivM8Tl4tATN6?=
 =?us-ascii?Q?gk7lR5R6b+G6ZR4HjbcmyOeT5VNARwmC41Cc4aaEWBisevnMQEMLUpF36ZLT?=
 =?us-ascii?Q?E+O/rb/5XkDTdTQjzJgAbBCXIYqxQYrqmZo+Nt0iEBim5mn/eSvWcRbsUr98?=
 =?us-ascii?Q?OaHIlgO7O6kgxrjigjiX+xNrwyf4FxrxyUnehTeI7kAj7UYvDPnPxsimProN?=
 =?us-ascii?Q?Zsnovtz7rMoPLGezMXpoKGvB86ETxzrQ8keVmRBKSjrdM8OWviu67WkTF9UH?=
 =?us-ascii?Q?zSXhZDRlRAPpWnc473MHevIlYt13QvbqYHag3Hn0fRIxFQGoVipznd2qsFd5?=
 =?us-ascii?Q?kLdjh796P9jSPbHSs1GbUu5LOG4AiGWruNf8DzZZFv2PkwH/gRIHqJqz1S9P?=
 =?us-ascii?Q?lbKWNrOSUzpUl7YVuDWn2XcBJod6jdDhLEbbQl/oVeNVRlW7oFFNv9KWyXKN?=
 =?us-ascii?Q?P32UX+/LK8OYqaMl/hkgQUGgEvmyrQ/Ii9PwVe6NdwwRQM38pJuTv5pNpBKD?=
 =?us-ascii?Q?DLZwnpamjCR4d3Nc/9sHHLAUnYhTRok5SDuz+BoE3d8dV3Jc5eV4A+pFHmZi?=
 =?us-ascii?Q?QnmdhQ3PWannzJt46LdZm3fDhyOq97TBNXF7XBTiQlnkZIVGQoKMCeuhLNen?=
 =?us-ascii?Q?igLgrTzzmSK/hELYSh07XHwgguw7mjXy0F3x97fa1oqQ5P3AWEbmKDH8HhPT?=
 =?us-ascii?Q?xzyoLy/gsJtgKHG9W/LVEbvlomu9j0nxV7dk1b1SiBHf90H6+G88bb0W6ikg?=
 =?us-ascii?Q?m+uQ838BmAnZwKwrBNOZVzj0V9L6cAboFlHjy7w9uUcfJ3UHZZ+4spK+p+jL?=
 =?us-ascii?Q?+5xiTAdGen4ePSAlwaNp4wq6ADVk07uC2Kh0SiGgTWXr7fcFDPqhCQUzJwC1?=
 =?us-ascii?Q?CawMMavQmPvhmLyJGNNmOQoC4UCPsRDSH5qDrjhqlxOtdgRIPTLMNk4InBaU?=
 =?us-ascii?Q?6xA7jv1vqQUEtd2K5rN6pNZ+LIA5gxtpwtKAncLUObGYWv3hRxDVfAxM874y?=
 =?us-ascii?Q?X0H4QsARCxI5tTFCmBeYiQcfN5pQZBTPXePhhECEl2E1oRX1WG3xRTu0x59+?=
 =?us-ascii?Q?mTNZ8RhPni+9K5ZVP0Sc/WugTagQ/ToYwrbWsDNgivUA3Rm9hlm/dBSx8PUv?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rFRemCBgzG/3iy0yYz/S7TsW82d0fJmHHjeSj06eNXyKgE/xlveXhAWd6EfQfp2TkhifXRkQ27KOFzS7El0/5iWZx2ua8W6+38JLnxZvMdAWMnSXfLbIgN5nZD0yKreJBi/3tflGnPW/sOk48C+muq+V3zltXaR7ARuGYoBu9l+SY6pNdloLLc1lBgKZym39CqR3jfcw2U9PVS/iAab5zyFcqKO/99BHePOt4gNW2p/EdONnKonVYzDcsGt8edtb225iskIvIPNhyjC/9jKtMhpDqHRCavrLLG8Ug0Zmy6news9hoVo/iE2YB9+ZUSRG9vERZxWm9a56IE2eNz/lPo+X1BIdKHA5cJdnsMtgQ61CZwgGLQXpupa9XGNsg2289gbXiA0RijlPnWd/DEcEU2f1hpk3vSErsI8ANsRuUzdIMzxRR+4m7zxR0lJPgmYH97grn1CyTMc6D1dqwuKEIdQmzz0Y00x28DRCuvqXc4k50ayVzn59DjIMNDTiD+fts/oPkrz891wNEjKTmDaMZ2sxU3wQccRw0ZHUUFQQ6WeRhr9+vracaNC6lMv7l7+xP8AR4goWJyIwQkYYzeQPBPwE9UaoZb9KUJ8j+mQ3Dt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09def85-b975-411a-ab6c-08dd5759c0f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:36.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7LlCz9ZuZXvXc+EhAHTj56pX1kVvGaKxNXY68D/19R/xGIWWkuMscx85wqxri9M5CuvRK51Svx5juOptkdwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: Ay7IqmLSpl75WdMiQ3ErhE0NJhvbb0qI
X-Proofpoint-GUID: Ay7IqmLSpl75WdMiQ3ErhE0NJhvbb0qI

Currently atomic write support requires dedicated HW support. This imposes
a restriction on the filesystem that disk blocks need to be aligned and
contiguously mapped to FS blocks to issue atomic writes.

XFS has no method to guarantee FS block alignment for regular,
non-RT files. As such, atomic writes are currently limited to 1x FS block
there.

To deal with the scenario that we are issuing an atomic write over
misaligned or discontiguous data blocks - and raise the atomic write size
limit - support a SW-based software emulated atomic write mode. For XFS,
this SW-based atomic writes would use CoW support to issue emulated untorn
writes.

It is the responsibility of the FS to detect discontiguous atomic writes
and switch to IOMAP_DIO_ATOMIC_SW mode and retry the write. Indeed,
SW-based atomic writes could be used always when the mounted bdev does
not support HW offload, but this strategy is not initially expected to be
used.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst | 16 ++++++++++++++--
 fs/iomap/direct-io.c                           |  4 +++-
 include/linux/iomap.h                          |  6 ++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 82bfe0e8c08e..b9757fe46641 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -525,8 +525,20 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    conversion or copy on write), all updates for the entire file range
    must be committed atomically as well.
    Only one space mapping is allowed per untorn write.
-   Untorn writes must be aligned to, and must not be longer than, a
-   single file block.
+   Untorn writes may be longer than a single file block. In all cases,
+   the mapping start disk block must have at least the same alignment as
+   the write offset.
+
+ * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
+   protection via a software mechanism provided by the filesystem.
+   All the disk block alignment and single bio restrictions which apply
+   to IOMAP_ATOMIC_HW do not apply here.
+   SW-based untorn writes would typically be used as a fallback when
+   HW-based untorn writes may not be issued, e.g. the range of the write
+   covers multiple extents, meaning that it is not possible to issue
+   a single bio.
+   All filesystem metadata updates for the entire file range must be
+   committed atomically as well.
 
 Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
 calling this function.
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f87c4277e738..575bb69db00e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -644,7 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (iocb->ki_flags & IOCB_ATOMIC)
+		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
+			iomi.flags |= IOMAP_ATOMIC_SW;
+		else if (iocb->ki_flags & IOCB_ATOMIC)
 			iomi.flags |= IOMAP_ATOMIC_HW;
 
 		/* for data sync or sync, we need sync completion processing */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e7aa05503763..4fa716241c46 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -183,6 +183,7 @@ struct iomap_folio_ops {
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
 #define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
+#define IOMAP_ATOMIC_SW		(1 << 10)/* SW-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -434,6 +435,11 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Use software-based torn-write protection.
+ */
+#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


