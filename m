Return-Path: <linux-fsdevel+bounces-19289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B68C2C90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 00:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625D22833B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 22:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BE13D254;
	Fri, 10 May 2024 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MpHtf2dd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqcdKQPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938613B597;
	Fri, 10 May 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379779; cv=fail; b=bazyJkPMdw99igrXuFHzxR7y65nXUkjI7jEa93bnTYHJjKPDBPJ3JqyvGIoCMcpb4WyiEFMttukkPBH2ujfK3AzBj7tJqmOPPbixabcImH3UD7hZlNzjhOe4rbv5JkYASfDP61/9gUo1C1D5FcPpiJtJaeCjXn0wT2m3hE0qCm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379779; c=relaxed/simple;
	bh=2klBj3ps6gMlXFE2g2IeDgWNLra40dYNpe2RdnIoUdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4IANnWS2GdFupg/mO1XFOeJgzoeKpS3IoXfjcvTnco+AAE/S10WqMBqnWqH2tiHtTU3FvW6StmOE2QSsVLq4vfy6zJ7rV2Uy3gL/EynZg6H9eWQO2PZ2edZEFd1aAdXuigTHOZL7hc/WMGOjDvApUmqw7iZfXebwj1jZ2460TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MpHtf2dd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqcdKQPX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AMDkPo020096;
	Fri, 10 May 2024 22:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ZmeDUUZCNceW+Uxl5ojGjqrmdGH4I7NqC//E+RH66XA=;
 b=MpHtf2ddJYob41yQYsdD0gyORceyollZFqVhXdSWc/bu2yDS+5iGB62pifGBSbP/AoYg
 iwJCwOhEaWw4nyrkhqAh9U3STxY99J2Sp9nfE7T8Le255tI5Z6qazXcOTnTbIGrBpfdc
 XCWEBVHFY0esaX8DgKJYWmZFT+bE9tUYyvC+IoTQ+nQA4ucSiqCHpRRKcclPas4/EZqV
 Cy0Af0wnK9HGDr4Cdd+XgrZbAi11tfBJ0JJSqyH9FbwOFSpBabecL9n0OIVrAjRPkSYC
 SxoNMgMEDq7Z3Es5wIYwEU+gEzTQF8Cqeu0o9Z1iz/ZjObmx7Md5uLJkla0DGe5poOoy GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1v62r07r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 22:22:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AK6kKZ019342;
	Fri, 10 May 2024 22:19:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfrpgc1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 22:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Geo2T++tbUsj/zjj41U7Ds6Eja1ISsfqwR3s6rlul5w6+W8VdWaFbMot9f7ivEfjSNFf0FnLFouPeGBqBaLPBuACw9ChbQI/+Bbp/N+JHiA9OCniFdnVN4PiMsRjJQ3yysNEjZDZrNmnyHdIMi9NRfN+3VtltEdHG1HsNA6iqdB5GqRyoMM9gpMNGuhM8zlDSZP3HhFjF7LfjQV1NtkEy8Z0ZZqTjSUhTOiJW6CZY3QSwDldzGP7yCa8AuROpi6y1MDoKouFHy3wYNo9Q6PlnfMUhUwubC9GLxJsFXn2Pe3wVWt6txGe9GA3jV+l5+HFxhSeyJ88WqVqOu36GmG4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmeDUUZCNceW+Uxl5ojGjqrmdGH4I7NqC//E+RH66XA=;
 b=XmClALrhkQpxnSAJF2AlkbvkTFztkNe6PIDBl7W+Xeu3jumtEzMUj/7cngG1j7UK2IPyk1MjhZFShuXYirC0uFrP7743nSt5GBM7UIsphNR25vFXoUCdZHcjQGkT5MAnBk+suUgFWQTALodtNJ9TJpMkFpy0cxF+a9IujXIydkAh14hyw5yUZZv6AuvaCL9C63viyLjTKjDeLk8ljttcBaTGM3RF49U0CDGXPXK4tLiuQRHq0tInU9aNfRcDgbwf6fbYs+Uy/b+0xdQJrbT+tb8dfDscxMgAya7/PA3k7SPutAaVOha5sCb8jnvU23zOGRTt/vd87g3h93Z0ixt5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmeDUUZCNceW+Uxl5ojGjqrmdGH4I7NqC//E+RH66XA=;
 b=JqcdKQPX7TgWsX51fdVeHXzg6cwYJlo08RywaPtyU/g83+7rlU37zYx/cChp5gPb+I6knX4yHB2NvBG0m2PXzccNgZmT5kZtOiV/p0MXiCOqNn0iTMKuU1zOIPg33KtWezim609F+j17lq8UX7/ZjCClaYc7BRG7n5x3FhOiSB0=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 22:19:06 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 22:19:06 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 1/1] fsnotify: clear PARENT_WATCHED flags lazily
Date: Fri, 10 May 2024 15:19:00 -0700
Message-ID: <20240510221901.520546-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
References: <20240510221901.520546-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW5PR10MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 285781ec-f032-4d65-42ed-08dc713f3376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EAt6djWGU3MiTbD+4BGSvU646rRemVT7zXQdsAuSPZVsFsCl40SShCjhisjF?=
 =?us-ascii?Q?uljLXG8wNq1oyaeEqBMbrq2s7+AOc74vGBbvDiQ3GGoktYtcbVXC+Cp9m37/?=
 =?us-ascii?Q?J7VrBcSEIYmlJNj7rmaEKnk8lS+hJuKfwRU+iBzrgxjfbw0RBK5f6lhlPwNO?=
 =?us-ascii?Q?6UF43Hfvidy1gTETsAfz87TvBdiY2bOCXIqSA+BESNxFcihcZ0niKlybOkqj?=
 =?us-ascii?Q?ThcxOTz1AuJrBV4QHyUurG519Rl4N8pJ/qxa2cg3Fq52estTHUKHRfb9xCg0?=
 =?us-ascii?Q?A+cwuAWhOIUcs+wbvUfcSt9jg4HHXrGnY2tS1k8sYSjcXNHGWgmQhoQE4Xe4?=
 =?us-ascii?Q?mRym6nBwLnBUtwE3LtZj7Gh7cJ4nuIg0TUdR5zVwnnkUlPKHD8ueymp6h5EP?=
 =?us-ascii?Q?riq83OZLLUMu7jqNfvMH0Whfyj4miU19GNW9wAwm2ixlJDJoscKm470O4u1q?=
 =?us-ascii?Q?MVrO4SLUjZP8uwuea56106xGX+a882frqLMR1L6aaLJZEDOvvYpyvUUsu4dA?=
 =?us-ascii?Q?D3eV1/gf3TFxwrDGD7wEl9jCEEqTz3Sj458AslkBvHMzNjgg3zOCEm6c80Lv?=
 =?us-ascii?Q?v1JmC0kh+YfdKY+ZRSvRghA3YfRBpw65ZFyvHhHhdcuWcvT5bUtRP5UhzDAH?=
 =?us-ascii?Q?zw8FbpENr3mSbzWmJbhrrKIt8FERqSgRxpOsF+maHBSEWH+zKgVpIiC06Vv7?=
 =?us-ascii?Q?LxoDD9xA7QVGr7mZM7LzuMmPynUrI8Z7g7L+vrRb+PilxHSxG8dC3seZKJbJ?=
 =?us-ascii?Q?X7J0vN04usu5zPbbhduUXlofbdD4MxHE0XfG24p9Q6sltMEMW9jQvkD9B0Iz?=
 =?us-ascii?Q?lYMKP7oKSiTdWjrPzi8zU63zNJDqT7ZiggiHzGQl/0tuoitL7XOv7n9tHLQh?=
 =?us-ascii?Q?FqNXR0SCfGo4W10DCA1OF5crAl7jvHiP6EYONHnDsjYJrC33qsPF66kyBH/0?=
 =?us-ascii?Q?1ZcYjz9R0rWilAInGYIf9xOhq4QJdBLEcuApzCEmKdvAV1p7bTY5pzg/diwi?=
 =?us-ascii?Q?C9n44BqBvpkaobIexN6zi7OCxdTeaEQXudnvBg7THg5fA2kDUGZKyjsQiM/4?=
 =?us-ascii?Q?F20eyq4hAhPyikMlw3UwNh0B2Qa6+imOxIAMSSatOC2X6KqLHP6qvZd2r+Np?=
 =?us-ascii?Q?oPo/UerVsNeopI6XhwM/+CaHumz90jaA8DjyWkjTp/yUL2xBgbTXe9L0WI0U?=
 =?us-ascii?Q?gfEQQhl7kyofau3Bf7uQy7cNM/bRSi+vnH2PbEFkGLcIyv+lvFu2HfWZme37?=
 =?us-ascii?Q?uA2fAQLEJHbRDbkP8hu1/QcMeuNw4Fyn9q2XirzPSg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MrL7+3PJz0OwgvP8V3CuY1XBxbFjRJCbwgFCKjezaLhktDLbGp7Z2ASmpKoF?=
 =?us-ascii?Q?YsNmrT8/pHhKZBvauqGbTC51bGz4fii9gL+He5RnYFA7lprHJjz7hegyCYpR?=
 =?us-ascii?Q?rAoBfYruAxZPtQqZirDLU8npxPyhjQEYhjZUdP3Z4CEFlfY16Bv1hBO25/HT?=
 =?us-ascii?Q?AUCSp2JqTJxdWxYEWQq7LR/97dobkgPAoVknBvnoO/mfXwyaXt+8qG8UaP/0?=
 =?us-ascii?Q?puaW45FIytKL77r5lXaoQuVDmOKS1JelUIVZyyKbNp+4/vXC3zJJqW2BEHy7?=
 =?us-ascii?Q?Kvcb6XpP7S62WtPI/DZ2+ZBBT/dCFLdjRoJOq5TURuAALvCeeNSexpU4PJSf?=
 =?us-ascii?Q?U+cz7xwK3uEJA8Cz/AIqm+UNBAQpvyK47F3z3367spEcD72SK4KO47+tet8Z?=
 =?us-ascii?Q?oYy0bMFAsnnst0rt71LxOGUYsEM+BMs+wrUEj6XWKO/66ZTfi1BZtYCbEDR6?=
 =?us-ascii?Q?LeE9SUIXu+2Uj5LWsh6U+Mejb7YgVHHfWyw5yScFzJP5xCQ6+3ppfGv0lBDG?=
 =?us-ascii?Q?scbAdId5LC7qgFgaoyex1dlElMpTyr437ShcNN+7hipKKBulg/iYw8YmP0Q2?=
 =?us-ascii?Q?j5ke+h9M+r+7lKkekZWzh6MkeMxdI41MM4LMM7RJwDfyyEYfRwFXPCp48e7u?=
 =?us-ascii?Q?mtgN0SBpVM8Q74LfPuAeBe4p1d2B90rdkSQ5rDga9o4yxDN2NVOegq2i1RT6?=
 =?us-ascii?Q?2FdTMSzdJEslbS/qp3uu2eAQ6qqf2qAx99/jryh+lWYMSBHqFXJ4kTFNv/qT?=
 =?us-ascii?Q?P4AbbZeFhHvMCov6FbCQMJv992I4sofInCEyBWcTPyJ27NWi96L2qTK0RmTC?=
 =?us-ascii?Q?RugJ165GzuEjhUEVrRw5f8k37j8tDvrBLHP2HtbbgrwmZn3KAYkDRi1RuXMV?=
 =?us-ascii?Q?9Z3zQ3kXtrJLiajuRIyOBsYgEmxuekjeXjqTlcw2XJcR+sAOkjvdugrs/RDY?=
 =?us-ascii?Q?ieJMtjqMrDVfieZnaK2W4PzlKvFFGfKe0jOtmZUxMdOwsg0yyaRWeh/fEFF5?=
 =?us-ascii?Q?I12EGGW/9sfmPQ9k/fQzI6KM810t+uWTSf53MUq5tS1Dar/v9JIeAyZCL+55?=
 =?us-ascii?Q?3MkP+TksS8VuiBTNDawNDX6W8mvr/36RarbtwBL+SsogPHAs4Irv7WdzNSM2?=
 =?us-ascii?Q?f6g8KawVulcCqpPCBWZb1jd4uszJlkCu7RnrrwLhiSi4v82hEZtaShsIIk+P?=
 =?us-ascii?Q?msDY0PzBswwpQAkeByyzV5l5/BwB3iEtHYvnxi6KIiwf+UH0EDsD0Df5wCM9?=
 =?us-ascii?Q?Ua5wMQFrdZFRrp5HVdPHhMh5ohee5VmPsSCT42DW8sMQk88o1Pnnoe8NLrD6?=
 =?us-ascii?Q?Axa6n+H4xP1mHmqozXV+1F48wk3qKwqI3Dl6Zm3kO5+6SQtYrtM8tBHelxS8?=
 =?us-ascii?Q?Ttn342btO3HsqB7IfGSP/J3tLKFGXBpMPBr7NihTWtGAzMkW27MEnNEItG3M?=
 =?us-ascii?Q?iEBf77yZg6gS6BJ+ZHt9zAHPMqMFdaudYtn6zAQk2yQdzVfFTXxE9047ouxB?=
 =?us-ascii?Q?IEWzIdZTV7dpyz894X7vbjxND3lbVZbvcbwxXeOc8Sc9FJROpmTYG6SPNs99?=
 =?us-ascii?Q?1taUtAxekXyaG+wD45IAmiXiMy74JkHkbrzo5O2j5tVDxcQ5cdMZSeIxsU4x?=
 =?us-ascii?Q?RXm3Srqrm0NuejfbyLAetcE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DqJvyWqjliBtbxvphWemaGE+rPOjt5i6SFFCJ2gCjnpWyLiyF0JCdrS+ONLJNwpU6rCmWNFbN8d42sc7sbtfoHgU4dbrNm6/C9ZbgaaybAnN6m5hkMaHvGarnOyVHblic7FGnAWtomJdb3WN7H5bgz1RW0jqnchHDknK0bHuE6lIUG+rGtQ/h9JHYdkyiD5MTw2Ohn7Ak4ffFA9tpnKtHcJp6RbJDzM+v2tDA0tcuoGu+YqgXrEoUd1+SMHFcXzHNbFZKhWwYaJdJWkirvUlvySpEscLmb8oskxtyhdCx5tKNZ5f/375aCtBFpCGy4c17w7+2OShsn5qvazZLUOATJyGXEMEM9hbdQNYNR0OSKRX3xVvHQDb3OzcgdzCD1ZxOiY3TmUMq/zz9MRNOUsMYdn/Glcx6ya88BG/ZtkQsEiV+P8+yetyMOCpFk24q3ck0tcbQMrcK9rKvFiLUm91DuCUFEH1o6XXb0gE2UJLft/0ok5B6JOQHbUk7dEzev8fDGcJFcypj6dJZDavCYBX8ZJ6m8TWxYjIfPwaj/icmfGfyYAL1Pg5uYinSVq3h6TtgRnNSCEwmxxFVZdi4o/5qwDtoMeD3pWaiRZjOYtEwYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285781ec-f032-4d65-42ed-08dc713f3376
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 22:19:04.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVnf7t4XVU524dyztU/0fj8B2VGqPJLL3/L3z9wkLuCCN4MmyjBc4z1LB6J4mYld4Y4Pdf0SZfabpff7nCskcNgBhXg7SfAZLX6dHbxBIWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_16,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100161
X-Proofpoint-GUID: gKH3L2PVAvJ8HdxrtZOX8h3-I8u8L3Qr
X-Proofpoint-ORIG-GUID: gKH3L2PVAvJ8HdxrtZOX8h3-I8u8L3Qr

From: Amir Goldstein <amir73il@gmail.com>

Call fsnotify_update_children_dentry_flags() to set PARENT_WATCHED flags
only when parent starts watching children.

When parent stops watching children, clear false positive PARENT_WATCHED
flags lazily in __fsnotify_parent() for each accessed child.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
 fs/notify/fsnotify.h             |  3 ++-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2fc105a72a8f6..86d332baaba21 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,17 +103,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 {
 	struct dentry *alias;
-	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
-
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
@@ -140,6 +136,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/*
+ * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
+ * stopped watching children.
+ */
+static void fsnotify_update_child_dentry_flags(struct inode *inode,
+					       struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * d_lock is a sufficient barrier to prevent observing a non-watched
+	 * parent state from before the fsnotify_update_children_dentry_flags()
+	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
+	 */
+	if (!fsnotify_inode_watches_children(inode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
+}
+
 /* Are inode/sb/mount interested in parent and name info with this event? */
 static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 					__u32 mask)
@@ -214,7 +228,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_update_child_dentry_flags(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc9..bce9be36d06b5 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -74,7 +74,8 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_update_children_dentry_flags(struct inode *inode,
+						  bool watched);
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index d6944ff86ffab..07cd66dc42fd6 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -176,6 +176,24 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	return fsnotify_update_iref(conn, want_iref);
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
+static void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	fsnotify_update_children_dentry_flags(fsnotify_conn_inode(conn), true);
+}
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -184,15 +202,23 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	bool update_children;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
+	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
+	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	/*
+	 * Set children's PARENT_WATCHED flags only if parent started watching.
+	 * When parent stops watching, we clear false positive PARENT_WATCHED
+	 * flags lazily in __fsnotify_parent().
+	 */
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8f40c349b2283..59e6b8e98a4c1 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -563,12 +563,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(parent_mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
@@ -582,7 +584,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 	/*
 	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
 	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
+	 * d_lock, the following fsnotify_update_children_dentry_flags call will
 	 * find our entry, so it will spin until we complete here, and update
 	 * us with the new state.
 	 */
-- 
2.43.0


