Return-Path: <linux-fsdevel+bounces-31689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B099A257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DF287058
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE43216434;
	Fri, 11 Oct 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXv4qsVF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCKfbcZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC72141CC;
	Fri, 11 Oct 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644781; cv=fail; b=ssfhdRPDSHIhaiIzI6jYRIxA5VMpIkElU+ekh+EkNa75jFZ4/MIu8HzJEJ7k744tv6OuvHW/ev/gUPuN1qSn/+WrYTzRYMU6J8/KIQn+b5TJDAZS4k6pMbvw7VOmABX0TPMyeDkpIe8RfnB7tVGPPuTX9nbSUiwMMJGebyC9M00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644781; c=relaxed/simple;
	bh=NNU+AwdMeiPwGrUfdNmufqfA8by3JsOh/k5Bm4J9m98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSG+pXRb5+Y0zfwukY9BhB4LeQwKT4qRSSHDwHsGUcEOt0v82LX3noSZnFvNhGKwtXd3vQwjhrkcRyYVAWS9vB4Zh/ze7R+8AHDOsKT3qjPmDXTLjj1HMDWPI6OjewF9koyrSTuKbbekAStpX6K1+xkiafuwdNV0EPXpc2cqTXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXv4qsVF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCKfbcZ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8BfAl006316;
	Fri, 11 Oct 2024 11:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=; b=
	TXv4qsVF+ujZ0t1Av1RWl44phnlq8CevmeGNsfaP/ZfryV/pQu1t7iFxNtkn7Zzm
	WDM3CVpbj7x1q/zwkDcuFcWqtYBSPyMPyvLXwACjOonf+NinWvGroYbz0fg2UZgd
	qqAIga0BLuW5KDeyDOqK2vEx5vdLwXL3wDJ8GfuZlbAt/RMXI7LoPWsFZ9EvZXjw
	6g90JJgrteuz7x2VfTYh9C59TBMGgIZisJu9lgNS6+S8sQtDE0MAlx9/BpjVwJqH
	7lWU0u0/lR9bLNEDrdMplNmSXRxvulR4G7eXtCHm3JSMsWF1Zutkl3GnNIbSH4S2
	mG+ul+e+wHF3xjYdG4DXTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pmep1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8so8T033321;
	Fri, 11 Oct 2024 11:06:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb648y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODKo7apHZo7LKizVKpjZMLJLoO8/sA+aw6QN2JcDQ7Jk133L/yZ+7cg1oWGfoMHKLXZHaJlZAEcyb7oRpkWA8FY/JXZVsDV+oPmzcFCdd5i65aEWmc5mwt6TZJPw1dQrIwrwAahpD0sn/odO4bK4hhaexdNeZeP2Il2+HoO4Ffr9WWMV10i3cpu4Jf7Ukg1wuRdJYL4s+1PEukgkbxbF1G5Pnn4JjnJReam31QoFgTV6DlISSvn76hQTZfOvy/GKw5JHMOQ8ZVIgw52ysTalqx+sz4lkL2efqytchAaztwGg1uxyUyBZQ6lAuxeA5gbMN3/8u4x0gKBme/WvjI27KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=;
 b=lJ6cNE6d69xligD+8Y+W5bXJTfwa+JVUo7K3+LhvCLoKN7aaAC0zqoDzimhPlORt5J5ALsvnFjmWQJC5OpUSzVzOEhjnv577XnReXSy+fGrEG5n/dIzE+q5OdhGKwwj0dUUrcSJUXaF9RuP2bt3FqRSIoOTX8JgAU1Z8/jjFC2H4s6yXwWL2JGFtDaduKff7hOmZgLeuMXcT+q2fvy0odiCgdLOLoAslhYM3wnAB9aH2bm+cyf/QKGdUDqM42f8XGjg7XJGjJZcmCOWtlaRZLbuDGWd+o19UqFcJ90+CuLCODYVd+q0uyM7ZjhL4DILRtSR+4fvaQo02tOd8NQ4kuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQXBsOR2E19Q2CMf9E95TjmQXv+9t0EfWPaUCkT1KJk=;
 b=lCKfbcZ4soWqX+WzV3VzrbRZizFWlZcH2e/fvMhi7u0qtehUwxL69p2ojwGJ1P2x8okrITX+2O3CECmfFO2td7rwLpl7KqhFBiV0nw5vWMtsAyJKKBahawndT/YpEf33w+MbcaaTCm1on8+5rv+eQoMi6y8Fu20/m/psdKs1mHg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:06:06 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:06:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
Date: Fri, 11 Oct 2024 12:05:55 +0100
Message-ID: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: d734e814-a680-4f02-cbcc-08dce9e4b43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEVSgP7asg9ZNzMhRdvV5G88ic9NuixlcS6+dvoivRybZsXvJeRF4xBS82p5?=
 =?us-ascii?Q?lll/kR3a1s0TpGGkOqia5OFBCHXtWGwMZ8Icdm9sIPwQpA88Ffind0MTrLUY?=
 =?us-ascii?Q?p9IimsNSziG3CTDItXJgW8Q/9ryk9PPJasBP2KC/8f5UY9aE3XUzUsQFFlkZ?=
 =?us-ascii?Q?kMSJ/lrkqIt3EbzAJuBVs9dhqceMkcuyMJuYx/UDeQ75+YPNBW7H4zwvi+mt?=
 =?us-ascii?Q?heF2LJZD1+mt7cayvpwE1H2slRZv5kwDms88pCrSvWEBo6MZG8tPoGWyaleg?=
 =?us-ascii?Q?KbZhIeZkX4qI1Qk0IrguTSeN4rzzTEw++9m0mtxRZ3mZqdBYnBfFW/jig3Dg?=
 =?us-ascii?Q?Wg20HSJepu4bV/n9OWywvQhurXgeTjrn7FwmkEKPewHDzQpbkHL26SgVvzJT?=
 =?us-ascii?Q?eVe+RrfkjUafmLPHk4+H+FHk/s6Ngdz0QjiSTyTNvYNDAV2K0YDCMQCo3NMG?=
 =?us-ascii?Q?ehVkmRkKz2MTAu7vS86Gwu///OwtlKMMssFeEEdUmsFOdB1JCdKrZ4vXWgx6?=
 =?us-ascii?Q?oG/Ei7Ng7tMvLASrr+ptFZDS6Qf6Oj0yXB5qVenEBFa0qpPfKixImaB8fpqe?=
 =?us-ascii?Q?3uNhIp5ZQzf5tl3qcFSUVF63V2rFfceupRhEH1V2gdY57pRG44ThahkURyAf?=
 =?us-ascii?Q?sY883Z24abOX/ZzOcGCOdCfr+UnFC2fLS5EZ3+2MN0cvtneBbdXQ+TnyiADC?=
 =?us-ascii?Q?X5t2gEA4Ou3XDCe9lNDx98zM/BM/8Gu8DF8GXIhmJIGhiYo78cFRRQlHt/cZ?=
 =?us-ascii?Q?MI3GszLGBOM7KQJu0+JFO25cTehqZhR9J3w6rjjXJ6siqx9FSxG40dJptc1V?=
 =?us-ascii?Q?trBMMWl7i9ViKDbBi0A5K4SvrKvVPKH3q1ViJWEsMyEUt8qX4qzduw0lCAwU?=
 =?us-ascii?Q?Lt3XMJhT0Vq9fUNR+++bvasqfXZyvs7az55CTuoThnTKlHz8koP/uO7/a/7n?=
 =?us-ascii?Q?NTii7LaR9OZLWODY0h9kJeg5KWLnPT6hFQHhFzzaZE022biRALmeJoiLlhqv?=
 =?us-ascii?Q?d9QgL33b4MrCFkQLK7ykWvrV57SRE68NjouwERLO4CncfeaX267xC8i4Bv6S?=
 =?us-ascii?Q?PIl2OIo4iRQEiAZ8RrYsp+uA0Pug5Fb94UIPXL9jz3Og95zQ8gDUXUnL64CA?=
 =?us-ascii?Q?EZvAI6DHEvLAUVQIryVZUl9lAqihkpr/kkMlze5UDQFVbxPR+4hthbbTEu3b?=
 =?us-ascii?Q?3+R/SFkHpI70Zp+Gbc6GX+oZN3O+p316USwyhf8CQ7lFeviiMTmhokKiZpKa?=
 =?us-ascii?Q?5AlOpFw1apMONo6awvZ7roL4bW2p4CmwMhBHMWIV8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+sM9QLQAQK7c3DhDQn3ncZ/AnCqknka2Z2B1uvcW9mL36McNVJhrKdByXv5?=
 =?us-ascii?Q?YOwNb80G5QOUi+k71nBxhCFYF5bnH6Y6qYeK5PVpYKkLze2Gc8AxXmI5W7ND?=
 =?us-ascii?Q?qzAVeYXz46lDDN6D4bL2CgIKLJkAgv9sjYwfTYJmzFXA9mAbD+Es1OxjP6R2?=
 =?us-ascii?Q?OFNhs9hJW0gec6Avjt1p7ZTFd+suLRenFhDi3DsSuqvA9rxtIA2wJ4FaAmhn?=
 =?us-ascii?Q?A608V/h9PsTRCpyJ7mRChr1xMgNvzxBwxp2p5AidHBFIz4/L1kCJSr6/8Z8c?=
 =?us-ascii?Q?WBh8BC5VhYwXWGWMjb5ZgOyUJTW4MdkAdC/UM861vNIlmQJCOrfZZ/bIdLrz?=
 =?us-ascii?Q?b4f2TiqeXJ+ugzE0ircKmsdkPtD2q4t/y+ZSVQg2dsWP6AEg/fXzPVn5yeKM?=
 =?us-ascii?Q?YGO/GN8wTlm2FOPxREK1Ff1JKvXcf353+D4XKvpG6Qt0d4nZ1YeFH3x2hLDj?=
 =?us-ascii?Q?JjHr5DrZm8beFjyf2L8VuTyc0gRITNnBsAlUIyNks0jb4RotRXrz1yFcegD8?=
 =?us-ascii?Q?ppNtbLJflG4WtbsDGcIB7iR5AJ9+XcsQIVyV4wceuRfqFkDbJ4I/T2mzEBGf?=
 =?us-ascii?Q?OfyMVCz/Mh4eS/y1uj9H8iaTtfnIJ80FIglUZc9qatiVneg9uouZ7bLFIC7X?=
 =?us-ascii?Q?Z08ExbloCI6KNrCx7uLuwyb2O/OSlWdsTrrMB8tXJxiAOB/o67AhyckDuyAG?=
 =?us-ascii?Q?fkTCZ1NPBM5+aZfwhjAEPnhHurKKT1GGc9wA88RGc2rf8ZfkRWwucYOfdECZ?=
 =?us-ascii?Q?AjiLqIYt2cjf/15fLzEz7VosSOy5PQ9jSz+fHorGEOJ0A7xYwglTAWJ/mHrB?=
 =?us-ascii?Q?W+J5TrL3f/bS+7oUcABnozwbMwdXhMSMpliBpcGzpRnfdOFo3mXT+C44jGl0?=
 =?us-ascii?Q?4YseIt0IsYxU94qW+lHclpEIRSUH/Hv/7g7ltk9VYj+n1eVC2uzBmsA+xvMz?=
 =?us-ascii?Q?u1VgkVkuvVfPMx+Q9BzaBHZ8YvxcKOjPPYcFChCvoqsN5DXIHRK601hq2TzS?=
 =?us-ascii?Q?DgQMEqOHlm8pApbtII0ZhAMNMHEEfZR6GtKxB3zWpG7SalwuhYYFSB/BcqZ9?=
 =?us-ascii?Q?PWIIKkaHoNSpwXqCQ/4nAi8J70+B3T+wnefsvufQnTtvgN8vERkflGzevUz7?=
 =?us-ascii?Q?T/zk14VN2AYNkzwthaew9ycwJXNExfmF1GY4vogdAJUnLmShhsTeOgJlCdhd?=
 =?us-ascii?Q?zEEBWLSwFcqX7oxxjnAMjAQPfsZ9x3R5atH38hfsVEQUUOPSzH/PQuOsKkkx?=
 =?us-ascii?Q?VQdtbXYO4gQlNmTw3kFfr/4bmXtixRjvBepSr4oNjqtqgetr6qWpS0WWbL+D?=
 =?us-ascii?Q?eJZwkOYmYGsA+0G6xrH0i/8G2y7lgxDzb+i4Dk1ab0xtutufHgkjNNzIbKAg?=
 =?us-ascii?Q?rs73s3jOkiwBsq/ZNrIubZlSSdWrBazDvZbIJ/f1BEpfSHRcyh+7JN+Z6LV9?=
 =?us-ascii?Q?HKxayEVL6NWaf7ntiie/W6/Gqk3HJiizuUz7QAzTnr4UYbWgIrUPg5FPujKR?=
 =?us-ascii?Q?dp4/sSA0YoNevo/CLZvBq9soef/E+56Z7MUpd6xGU8A+Folp0fLya78m5LBk?=
 =?us-ascii?Q?DOU9e7IkYM3hEJ42+Kv13ajG4h8JAS5tmx6yTHvbJpRZJdq9AXEEoB7IdsJs?=
 =?us-ascii?Q?TK9Q6EWzyde8/QWlp/MpiQY1GxWKI6amgj5hOPtLBmsuOv7YQIdRQGMtwLWf?=
 =?us-ascii?Q?/nJBCw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zztqj/R3iwT8JwSeGfJ+To2W6SJ2jLKHmqhLRrToqetfYRhubQLb9knBBP7OAqsvZEl8h/vj2kU+s2z/QvHITX3k6939HvoBW8Jv170XamgReAqt+bOqDWNtfD7llTQ8dje6OvEanEjUc/2UncveNOQSxIciURKW/JCbfnDIZw2u3nZSRhhUGmsWCHr6qVMRYevifsYIZ5Bu0ra3efEQwpL3IeeYmyNv6MruuCTU7yknmNssdLPdzTFKOA+s6ohDlk5DnWfQK9k2ta1Cbvw1MEYcJt+k/OGA77UuimbV3vsjoPky4/dFchI0v55M46R52t6KDBGTw/nkkntnuFseJ8wrF+VnsN4AzEF0Flzvc7yZB8ILt0kNljH5ISjYrVYZW7Lc0eFcMgty8Qtx+5daoYXbadhtAek6SJa1stn3tBtWuOSU6J34hudShG6T8zeqv3ZjYJweeCNy0oJp0por16NAGKhytqeoBpRunu8e60OMDybNIVa4Z2jtGaOuWFn0gjgTo9ke7WA2k8GRg37010oK/6g9HX4frvryGRwqdekZieZE68nIqPAqzEOejoQ2GsRaFiLQSgB2KCXzLVUMwy4nlj20CxvOII2TjH6ycWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d734e814-a680-4f02-cbcc-08dce9e4b43b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:06:06.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d40LdCJIg/NyZlC04FQ124w4qTOElfB5xJp1hZC5ozlF4JFZ4xAz1r+KEZFr9AfbR1UwSxqp5Q/nvVJOxT5MlDJuSEvmICfIJRHpXTY6tvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110076
X-Proofpoint-ORIG-GUID: 50b_V9ipNSchOEy4dqNWDoO1LtCrWp2H
X-Proofpoint-GUID: 50b_V9ipNSchOEy4dqNWDoO1LtCrWp2H

The means by which a pid is determined from a pidfd is duplicated, with
some callers holding a reference to the (pid)fd, and others explicitly
pinning the pid.

Introduce __pidfd_get_pid() which abstracts both approaches and provide
optional output parameters for file->f_flags and the fd (the latter of
which, if provided, prevents the function from decrementing the fd's
refernce count).

Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
directory, utilised by the pidfd_send_signal() system call, providing a
pidfd_get_pid_proc() helper function to do so.

Doing this allows us to eliminate open-coded pidfd pid lookup and to
consistently handle this in one place.

This lays the groundwork for a subsequent patch which adds a new sentinel
pidfd to explicitly reference the current process (i.e. thread group
leader) without the need for a pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
 kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
 kernel/signal.c     | 22 ++++-------------
 3 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..68b02eab7509 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/file.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
 
 struct file;
 
+
+/**
+ * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
+ *
+ * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set.
+ * @pin_pid:    If set, then the reference counter of the returned pid is
+ *              incremented. If not set, then @fd should be provided to pin the
+ *              pidfd.
+ * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
+ *              of a pidfd, and this will be used to determine the pid.
+ * @flags:      Output variable, if non-NULL, then the file->f_flags of the
+ *              pidfd will be set here.
+ * @fd:         Output variable, if non-NULL, then the pidfd reference will
+ *              remain elevated and the caller will need to decrement it
+ *              themselves.
+ *
+ * Returns: If successful, the pid associated with the pidfd, otherwise an
+ *          error.
+ */
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd);
+
+static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
+			       /* allow_proc = */ false,
+			       flags, /* fd = */ NULL);
+}
+
+static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
+					    unsigned int *flags,
+					    struct fd *fd)
+{
+	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
+			       /* allow_proc = */ true,
+			       flags, fd);
+}
+
 struct pid *pidfd_pid(const struct file *file);
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 void do_notify_pidfd(struct task_struct *task);
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..25cc1c36a1b1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -36,6 +36,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/init_task.h>
 #include <linux/syscalls.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
 #include <linux/anon_inodes.h>
@@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
-struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
+struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
+			    bool allow_proc, unsigned int *flags,
+			    struct fd *fd)
 {
-	struct fd f;
+	struct file *file;
 	struct pid *pid;
+	struct fd f = fdget(pidfd);
 
-	f = fdget(fd);
-	if (!fd_file(f))
+	file = fd_file(f);
+	if (!file)
 		return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(fd_file(f));
-	if (!IS_ERR(pid)) {
-		get_pid(pid);
-		*flags = fd_file(f)->f_flags;
+	pid = pidfd_pid(file);
+	/* If we allow opening a pidfd via /proc/<pid>, do so. */
+	if (IS_ERR(pid) && allow_proc)
+		pid = tgid_pidfd_to_pid(file);
+
+	if (IS_ERR(pid)) {
+		fdput(f);
+		return pid;
 	}
 
-	fdput(f);
+	if (pin_pid)
+		get_pid(pid);
+	else
+		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
+
+	if (flags)
+		*flags = file->f_flags;
+
+	/*
+	 * If the user provides an fd output then it will handle decrementing
+	 * its reference counter.
+	 */
+	if (fd)
+		*fd = f;
+	else
+		/* Otherwise we release it. */
+		fdput(f);
+
 	return pid;
 }
 
@@ -747,23 +772,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
 		unsigned int, flags)
 {
 	struct pid *pid;
-	struct fd f;
 	int ret;
 
 	/* flags is currently unused - make sure it's unset */
 	if (flags)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
-	pid = pidfd_pid(fd_file(f));
+	pid = pidfd_get_pid(pidfd, NULL);
 	if (IS_ERR(pid))
-		ret = PTR_ERR(pid);
-	else
-		ret = pidfd_getfd(pid, fd);
+		return PTR_ERR(pid);
 
-	fdput(f);
+	ret = pidfd_getfd(pid, fd);
+
+	put_pid(pid);
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 4344860ffcac..868bfa674c62 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 	return copy_siginfo_from_user(kinfo, info);
 }
 
-static struct pid *pidfd_to_pid(const struct file *file)
-{
-	struct pid *pid;
-
-	pid = pidfd_pid(file);
-	if (!IS_ERR(pid))
-		return pid;
-
-	return tgid_pidfd_to_pid(file);
-}
-
 #define PIDFD_SEND_SIGNAL_FLAGS                            \
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
@@ -3908,10 +3897,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		siginfo_t __user *, info, unsigned int, flags)
 {
 	int ret;
-	struct fd f;
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
+	unsigned int f_flags;
+	struct fd f;
 
 	/* Enforce flags be set to 0 until we add an extension. */
 	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
@@ -3921,12 +3911,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
 		return -EINVAL;
 
-	f = fdget(pidfd);
-	if (!fd_file(f))
-		return -EBADF;
-
 	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
+	pid = pidfd_to_pid_proc(pidfd, &f_flags, &f);
 	if (IS_ERR(pid)) {
 		ret = PTR_ERR(pid);
 		goto err;
@@ -3939,7 +3925,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	switch (flags) {
 	case 0:
 		/* Infer scope from the type of pidfd. */
-		if (fd_file(f)->f_flags & PIDFD_THREAD)
+		if (f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
-- 
2.46.2


