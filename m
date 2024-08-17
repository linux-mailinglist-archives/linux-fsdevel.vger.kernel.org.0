Return-Path: <linux-fsdevel+bounces-26189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A09556F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759341C211F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C21153BF7;
	Sat, 17 Aug 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TM8yJKMM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iKxfI+5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10914EC4E;
	Sat, 17 Aug 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888125; cv=fail; b=fKlaWqusd13OdPiEOeVgiN0IQ8nJuw1ZyQE/3h/RG3WwBw13YuYJaBUq+Fwv3hgcVQ6WY8BUhJQqu87DHpg8h9lXqsbriYktEX7UdzSPC10O2EMmXHMzM3Vu2QmE5kfg00EvfgGlSk1C3EdEu+rxwLhCgJz2wLrrAdCyPk8RsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888125; c=relaxed/simple;
	bh=D4aXnk8UeMaPh0XQlyOSWm/OMrNuFw7/bGsduXlbJAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6PwQCpOLtZIVaGGG64b7aEEIlB9ndj5nDl4mYkOUc0J+Ca4TUqYNJXsXgFUsxl9K+3wsg3/IrXFysFc+oBehlJHwSNvbpHuhXpN8sBqs9nqwZbSWED76r11GtqUYmykbBH41mi+O9RGz0DvOKGhVj+Xjk3Jdjm77EeoU8/7RCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TM8yJKMM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iKxfI+5M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H8G7I3018252;
	Sat, 17 Aug 2024 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XBgSR9D8hHZU1SortIL7gHTZlCU2PByJAQHBZrYkVrc=; b=
	TM8yJKMMgLEOsff8MzXODQRzxwZ3fkOwAltf8PvvgN1BlottbQLIx0muBAb8PlOJ
	G1PRHvZ3I9dzImQx0NHoHo6jdX6lC8Xa5SAMuQYJBGnPLQe0juoNnYsvS/m5mL86
	EX3vVZSXAlm6MuLFSqJXveAgXbfXwg76Aw/GAzs5Ga0G4knHVQYjzBp8aeKcOgXz
	uKTGEroB8AIvaRKhLp71TrGBV7/5TtCC9C/iUVaWXojzHQ1gIl5hl1nRlfIWr9vm
	GpTr/FxUjMkeXjmAjJeCXxDFGLlJhLgMStUor4GtTVM3yuX5cy7O2IDIEpVjVmPA
	ILP3/8XEbAREeNiqTmqvCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4587mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47H811UK031437;
	Sat, 17 Aug 2024 09:48:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 412ja5y121-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Aug 2024 09:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va8xUixT3hipfP2wiVvG5l4fEhZZMbWBABKrQpjDLko2O9sdmM2myICLj4IqvV4S/+BRGTo/9Gi2qD897LFJbHpt99RmeUaaVESNWPQJAUNtIQ79UbFdjMbGTCV4742LGZ7L+5RhNcY1/Uu8u+mcVMnFkbcCxYhgSGPHD6yNWaNEMfiHf4W4dcfrL0WAueaSrLqzpOOYsODXFUa68+FfndYJd10fs8tpGJ1Re1TbQsKpsls6NVnopHo4W4hvGAaCU5TU/Lu8LBZwPy0a9qNyd1aeJD3lXuatFN5wcBsy92FTUakRB2h6FskQaFapEnVDjzSRz9GT2Loe8SWfQUVwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBgSR9D8hHZU1SortIL7gHTZlCU2PByJAQHBZrYkVrc=;
 b=WKJsv6+Usl5c2Cg0yavbWSn/dpmQM+7bGPD/v2GSRLC3RC4rjCaxjS4ndvcURjZWDNcpu1bmvMyhfM4EF7hpgdt5Va5APYzPq7KIPpMzC89VtGW1t8B2s+vE+/NiyiTzvCudUXr8AG8N+EuUB/TN7uKbvDhkvEuouPuZUoGmHQ7nnwFkagtQv9tnB2EjvDRbjjaXnUkQrs5zBzN52/99sYobpR+EbCyg5vz8JErh5y9mgtS03aj78yl9qBhy1MQ6bufdvS8ZJPP09tZugmFWIe2WN+7WLo48HMEeM5g9lsfr0NXZQgq64SYc7pyzX2pVtBp+hSz2VllmZ7WCMZO/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBgSR9D8hHZU1SortIL7gHTZlCU2PByJAQHBZrYkVrc=;
 b=iKxfI+5MD737PayY477xKQJ1pL4UgA2m/5p0poJGNCu+tVlFp6tt1Itl8ELCG6iuMih2OQQ4VO2TnPGVhB2rqj+P6UuTWs8yNVH7fdLPHZOqfcT9p4krd8YFPiJcYEQIccRc9rqz1kw6VpIKbP+ERp0axwcDiWZtLEb9b/ExEGI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 09:48:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 09:48:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com,
        dchinner@redhat.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 6/7] xfs: Validate atomic writes
Date: Sat, 17 Aug 2024 09:47:59 +0000
Message-Id: <20240817094800.776408-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240817094800.776408-1-john.g.garry@oracle.com>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:fc::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: fe48bc44-c381-43e3-2c93-08dcbea1bd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?01ZlNN/hcKDhReRJZLH4c1cglA/Ghh6rfYaxSc1yocK4471vpF+M7nG7CaVZ?=
 =?us-ascii?Q?wWMeotq9K2D/kb000eU4yE/PH2dTQAVYcPlE6EftsMHqnAh/oRac75IB4Cp6?=
 =?us-ascii?Q?MOOoq5WgUcxnM7jVFqyR6EjtoabJxtbeVhvNkP6J8qHWTkq7rN/S32CaFXKf?=
 =?us-ascii?Q?iePJYpLdsqMD3BQBfVXLzGu51GOJJrCix3WEXQDfom68WRpw2swcO34g6shL?=
 =?us-ascii?Q?V6kHADQBl0CAkp7X8JSPuRARPOKISrXkG4nt0DusQo7Gy82d/3blWG2mMR0O?=
 =?us-ascii?Q?TLalDqIScmJFebtKGXlXz3JuLJgk4hC32aAl483DZuxC50GNB15uIt7RNrYv?=
 =?us-ascii?Q?j/zqxC6IF2BmURCwpL4eAHWy4b+1e9+H2aoyrmEfcYumvl4vrHdWz+qLbfQK?=
 =?us-ascii?Q?1aIXKO9vfa/Dh1yYwshaBy9h0QFzKKmpjx75vChTQ+qUZX1BNXgduvlyKAvz?=
 =?us-ascii?Q?w7KQ8K2f71WVdM9Pi0tp3e5ubvFJNuphtmt+4N9aNQ3bfWFlwz3Vs/An3C3H?=
 =?us-ascii?Q?MvDjVxSmlyN5hCO4BKm/sGlERBAZiqWh/o0qaWGG/T/fSBFhfS7nK6PAffT+?=
 =?us-ascii?Q?igbv3+B0Eq+K/Ss0nAstPCgtg1+hUa5Zt1TaM+9of9Bx01sbt6tVTc/CmZ03?=
 =?us-ascii?Q?ksq1tckHdoykYMWXVADLEbsCS4/b6TN2Ma5uhN4SX7u0uQqovXut+b3wLQqq?=
 =?us-ascii?Q?SDBE/dySLZO4ZOlylBsfdOQwfX2PIC17quni11C2BoKMGKZ+nrnr05RTgG+q?=
 =?us-ascii?Q?2G1swR1bcMGDq1w+ix68rWl3OfNfXhFzLOGRM6eeePPowCROPsxKwkbKOhyj?=
 =?us-ascii?Q?KJL5gW0TKzHILZ+EqasnfyhfdnqCM1iNU8HFNofIOM6tE2Q/G5Qe/4O703x5?=
 =?us-ascii?Q?fRBTFfB4SVfG77sadp2wYddJ5/ODdEstubrbZZSgtbuaL/6BqrRbv1RP5xdO?=
 =?us-ascii?Q?CSbgD34ud4uwtpwj5lQJA+CDYBHhGViI6HgRCDBJgSukoDDE+mbzubUOyvs3?=
 =?us-ascii?Q?8rKrJepSsWSuyF7cIy3gQTEYIh9ges02JauNCr+3pBAmu2Od9ww2GsZ00OPW?=
 =?us-ascii?Q?Vr/SeaMl3Vp0VM9o2jc2GeS6XavbUCsvetWPcIHZHKFWlIh9XaRisJHB4QiT?=
 =?us-ascii?Q?CroDb6HFJk+UlXVX2FZMQWpZseo7syjldJjsOxnhzzgT2hggdxUW0y31WUfZ?=
 =?us-ascii?Q?JoPPXQ2Yy9kjx2sF90hMbeo9gLnPuhi9lq8kX+GdswS9ELbpFuI78c3u1ToA?=
 =?us-ascii?Q?sfURJb8m/z2gnHKYiZdFNh8cfeCk7TvnktOX92wfONQNGVkRE+6ieyY5Oyul?=
 =?us-ascii?Q?gsbD1FMyDhvptxDmUtdbplxfL3/bnbucV7V6GXsmxQM6NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fvuy0Dv/arA7NOFTR3iXcANs9D94oQsSl5EN9btDfhYYgLlMM0FvwkcJSniJ?=
 =?us-ascii?Q?ksZArTWPrM74KZwFL4Ku1yP+jVJRgrWCatgWWGU6u1fxxvkwNLAkbLj8LJKF?=
 =?us-ascii?Q?hd6PkjMiW9MgfNJwjcw2+khYULFBpZOtPDtnZUG8kIk3i9iDv1iPaUTyzl8p?=
 =?us-ascii?Q?+O2JMYTsgMv6Egs/OXq/mA2YDvHj1wfe489QeOkEIYyDMTlxh56VtC6BxFaj?=
 =?us-ascii?Q?2pSce0NLCBXJCZud7A7f4XYTjpq3tjeHSZLT3MJQRLhx+voNfh5T4tP27P+h?=
 =?us-ascii?Q?ETqXLIWdAJ0hnCMfHVdVvxYgzXGJREaswuKayfRzslJvKdxxMFtG6q+zK4uY?=
 =?us-ascii?Q?7Zxn5eBUsnkoxG8cOaVo72QMUScqNMEc6oEp6QfuTH0yn6OwqzAMjD9UgdGT?=
 =?us-ascii?Q?ST0Ep4pCcrgjeRH7fhlfrT/RxtSSucqfcnSjX65E8MVVplsAaIhxC3vcYU/d?=
 =?us-ascii?Q?F03xF7TupBkUtVzeGR2UZQrP2zsubRul20q4/4rRw2e+PMAuec+0J5lXGXK7?=
 =?us-ascii?Q?/FPe6QJ8xFp6T1Z9e+N6s/97cHLhVC0vkRzKvdi49pLlUGKVQzo7TpCbGp7y?=
 =?us-ascii?Q?+aUR2nPPAzifXcFebSLmbjj1Kth941QcSh3y97b/U/nO/a84SPhSgi5ZN6ju?=
 =?us-ascii?Q?AWaMsguid0XbX2ve+rxTLGzqAy3vY7DWwysyE9ZH7x1Aa+/QMzDAOuxHvJpV?=
 =?us-ascii?Q?ZEJb1z8ztsYQghG1gn1UJUjhdLmJJtSjZcb4TmKVVX1G7ArsCO3co0XhytO2?=
 =?us-ascii?Q?BN8poTjsC7HcVtJ1dkuv8m1Ez8GyIp3Gns9MRQfJu7hJbbBx5aLoSqtwjlT6?=
 =?us-ascii?Q?JeERScLe0t4tfm5UjOmULo85kaE88Znm9Qo7Gdu19usa0aasnFDIJD1S30vk?=
 =?us-ascii?Q?gVcRpjGPCPHBgAIrbu+52iDqG1TdmpgLUV6YpbfCOwf76l/cKOJIFgVN4H5P?=
 =?us-ascii?Q?Nkmqlo77dQ8CJNwQLmc9ldl6onoJoQxs2UwXT+Z7adg4AwJftMx0ApQGxpdt?=
 =?us-ascii?Q?aSXN4FhgHh6M5CkkuT2T8CK9+cIId8QHZwNZfz1tbsXvRTsz0TC08EVarq3f?=
 =?us-ascii?Q?zf26g7K7XKUSF3bpLNf4v2TPRMKdp8pBjYYz98soI05V0Y8oUJfsFTQqNFOL?=
 =?us-ascii?Q?CcRakOFCQuCCMSeMFbfjjEX1fWgJgMSTIIMZ7Ev6gijxiQky66JA+yZHe1Q1?=
 =?us-ascii?Q?dQN4nKpTK4XlwpfPGNbP7F/YOQKdl/KvKzEoX9r3aSyaULw/rnR9GU3cZbON?=
 =?us-ascii?Q?QpKdxfuSkSMwVXcT2jbb9olrKh5R8CFqMeZZlC6i4lr6YSZ6d4xUCknWGhpZ?=
 =?us-ascii?Q?bk1aEDVREi0p7PurbBqi+kZ1HMQYX9oMMYoVqjrA4DhYAQVIeD7eYn7tvDwK?=
 =?us-ascii?Q?XnJMFk7b/GA5tQEOMR0CRhNfFSLiAkHeml++AT0q+VSh9kf7OhyvCjgR4vVa?=
 =?us-ascii?Q?1riMITXYM0VZVZEexAL6UqVoaoyS71UN88lHf0zXW3MK6ctootssucMtnONH?=
 =?us-ascii?Q?sdXSigsoR8AP8uKUPnNAFkPu6dqYBKAEpoHqeKBK7G28uvoyCA6uj7iCfmFE?=
 =?us-ascii?Q?TFAKUwZpTR0F0uUphlJkkeyCNEBjVakk6w3Hpree9Nh6wx/DhPDJDBRS8USf?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uAthMtHjvOu7hiqKU08bcDK9FPDb+mn8Tyo0GxjXnuahoxmK2cG1hfW55WiUcjtP1HOxFk8IsrSk2Vcgog2ARbIxm6an/kLqZs6pJ/EERNaB6zt3k2O8bu/0Sgxjpfj9A375fsD041/oXyn8RIEMMV5ZZiDw11umfNwVzvsEa/cVoHyNrEqF2z1hzCSQBUqKqKe+EgxtaT5yBTENz56i1PSt2V9eSmPtlbHrTJMOGdWlruUMePsG8ecj9DTS0zyaKhKdctHBuxHG4g3lHw8+BjQ0S4XSQLc2B9948QmH7XRpOZw/qS2TeyiSNVMBH7lwUb5Y5QhsG7SmTZXM5Kv49rZFZTVjZegilk0kwuIfoJ1pEFWZlEj7QyQMBzHhSbS8lSF52SC8F0z8qQ5ehiET1goTB8Z5u+kKPDcmO+1uJ7lznXyTZqA5tTBOtJun9JM/9gvXtmm4wd4lxMV335Mo+tkgNqgNXf7NC/jqnV4yw/97R0rG8AENj1H+kH96tJRuqk3TFitDvB6VUy8kmOj0g671L+wI2KzY1YL0X20VgeJr6jrFGDJiMhZTQtQdPPLdpNhFRVrYNkLD/ZyIkRXzJE1mXjMEfxfYZz3edXR0Iy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe48bc44-c381-43e3-2c93-08dcbea1bd2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 09:48:25.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbpKJ6GzoIOt/JmMCXJXnNS/fJOogQwfl5ghXtppY5GNpM5E9IhTfECC644xvpOm06bsWNto0ai6QiHvyW2i/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_04,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408170068
X-Proofpoint-ORIG-GUID: EP27VvkOVrsQN0No2GLXOroEKIZuq4Uq
X-Proofpoint-GUID: EP27VvkOVrsQN0No2GLXOroEKIZuq4Uq

Validate that an atomic write adheres to length/offset rules. Since we
require extent alignment for atomic writes, this effectively also enforces
that the BIO which iomap produces is aligned.

For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_dio_write(),
FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
FORCEALIGN and also ATOMICWRITES flags would also need to be set for the
inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..9b6530a4eb4a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -684,9 +684,20 @@ xfs_file_dio_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (count < i_blocksize(inode))
+			return -EINVAL;
+		if (count > XFS_FSB_TO_B(mp, ip->i_extsize))
+			return -EINVAL;
+		if (!generic_atomic_write_valid(iocb, from))
+			return -EINVAL;
+	}
 
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
-- 
2.31.1


