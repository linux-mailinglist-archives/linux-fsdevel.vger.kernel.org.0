Return-Path: <linux-fsdevel+bounces-21213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C333900702
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152F11C22FAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F719AA5B;
	Fri,  7 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aZcPgocz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yclAiBxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A6197A68;
	Fri,  7 Jun 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771242; cv=fail; b=YObDONVvJnrFe/+B1te/WO7SMZX+rvzY4RGPsd7OP3D1xu50mgxQxoGnXfqLPnwp5ClJNnuSX8hhz43Jul7R4MRzmVfBS3pAFbfcm39YntERT2DHL0/ri+QjjMRgbezGW+1E8O7ciHi65bgq4J28RA9Z3EhnxojojIn/jmaehCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771242; c=relaxed/simple;
	bh=hDhiB5xz2c3uDJ2sK/k4fQsAu2/Ltt4YKiV38Iy6VQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzSgE18mflZzjhGDneEKHG8ojGVo/WmNtnXKgLK1Jg7j1s+OhzJ3fVUCE+Toz9VxdnbSwJj2htakF96e/9Ez27THjBMqRYuq7PDW9/gLRfupUt20wyjt97XCn7Czf3aryQxxULM09QMVVHB1RjjQixKdOplStQPT/aEDnypQYrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aZcPgocz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yclAiBxR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cubv3015425;
	Fri, 7 Jun 2024 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=qKsGyyTk/SZJzjvt6YI3pwTZEFEmybxRZpNdxY3DtzM=;
 b=aZcPgocz150UbgzrmLnrXhYR29CM+d+8yK4RSU77+ynz7b5qhQKeRjvercfnqu9Z+59f
 6ZPGESkKdKubazNJ7+FB3aOzbmL7inTvP5Yx2wFohSOtlIp2AsMBCbxmzBDMmpdkOBbx
 TKMduzfQfXLyWE25wvJHA24Wv9F1f5mIVfG+ZDBLr4NG0K7ToWyKSKGNWq3ZrPrppWyN
 ygbAFocqThpaq3P7ngY5LDmLUmUTUVzY7J7XiA4TcLy9JmJt4AW0qfhm+QiSNZZrCIlY
 7ah70IwdhzH6bieQStYnmEa6olrPcJ2aAUigpgZsad+JX1ZbwXjvwe/aaGBdA5NqqhgH /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd3tej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DL9r5025127;
	Fri, 7 Jun 2024 14:40:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd2yuq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYmexKgeVJsCiadazVTlR+cf0xBb00Hrmiy42j/DuBmg7L5wdy9nNKuSJjeluVol2zbGfgSBn9K2oSuQdtWUiHQozGSmL5UCS24llGmBm3cu9C/4E9choPMjBeXCgYOD6Qg8p4g1XdBQMiGi2k5UuH+7epnFio7cqiXYay2pFjo18hKlWq2gYedxM4FVb/SPhHMj788s39kwWqYaa/N8PSSPrD8E6zfe3aiXv5kSTK1Ky66FIQ9EB3S75wnCZssJaGDWh1Ix4DjbtXj8JJMgrlOtOxkGzkZ3J8S2DYl726fLb08ipxEX+dUmZsKdeMKtyW8s3nYCKoyNkguMCxdMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKsGyyTk/SZJzjvt6YI3pwTZEFEmybxRZpNdxY3DtzM=;
 b=L/3OzT+25pH8pGM4RNOXS/xfOCbE0lIswHsxvI9ud2uchE1qO7B7XPugTH+hvMD2nI7G7VGwla9y2R3QvQhCMhtj3l/bEUh2qQaohEcu4M8JKP6PODb23NmE7QGERgLg6OcuaHBFHt3qZpX4oKUgQuU5sMuLz6pf4BTSkJTO7S09tNeB/KKi2VpIxo7Ykm6MyrNwj7r9hGRNWpVUghyng3gOHpVDH4P8wsbt3ahcbt/+jFCNlIybhR+rN9HrM9e1y34WjGzakE5Z1jp7Xzkw46r6T6hpvDp+y1C4jurUyWCGEQN63KAYr+j61HiOd0OVgT5T+DLup2t81+998EBA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKsGyyTk/SZJzjvt6YI3pwTZEFEmybxRZpNdxY3DtzM=;
 b=yclAiBxRa5k/lRP8vdvz4WMpSsta1iwJJIET3lph8pTmUuw6UBMAyi0X+L5Y2PmQc5GUoJbC0FcW5S4xSe+st6vnvf6+67NGGw6uVzcw1FhBhW5ZIpT66PPyS2kF24ZAinlHZMviS/XmDhz7J90UAjLFxV5ZKLSeaN3/odDKhlo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:40:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 03/22] xfs: Use extent size granularity for iomap->io_block_size
Date: Fri,  7 Jun 2024 14:39:00 +0000
Message-Id: <20240607143919.2622319-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fda183-07c7-4a27-f480-08dc86ffb6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XNEGf8M/5RsU2wUFQp+Kv8qFTVB0bgzTAURz4ms/oGmrw7rbPjusMP9vtomS?=
 =?us-ascii?Q?rdiDUpKD7QbHvNiv/bHxcKaiRkVnywCIyU+HRcO7OFB0DQmcv3AO6PVi5def?=
 =?us-ascii?Q?5M3UR4O7eQ65hp50gBDFQjuJKDw1t7S7iMdJo5Np7kNaiHVfCbbojemYXgHB?=
 =?us-ascii?Q?yp8TS0pZFqo8X9r2KQuGSVdoo8Eug0Ch5iH4eqfoBe6IkkUXQpBWS59EMMHc?=
 =?us-ascii?Q?qWgMqyejFR67dDfY2dVJBDglZ+w5zK+dJqa/5ihpngtjmusZ2/zyXZi/xE6e?=
 =?us-ascii?Q?xHJCpeR3LxIjTDOyYVzK8fHJAI6U3I9/WManOVph7n8qSx6n8oBWuZNG+HAF?=
 =?us-ascii?Q?xIr/llUkPlQb/rJyJacgCXZI1JRKQ5e+pTtRhjQvI+RKkPzzvYoF6xXBgZ7C?=
 =?us-ascii?Q?8zJ/n+1NeRWkzPeuudka/z+0pdUo6ebRbc327heKTI1GnMFpAnGLUaHo9OSH?=
 =?us-ascii?Q?q6hDRVYpSdjtMFa9eO36fj/KOfABsyErAI02nhgoacQ6/NattMhwBfVbPTDz?=
 =?us-ascii?Q?BJD4EBWb/vtDyCTeHYjWMh4J8ojmHV5wJcazqnyVCPZGr8eOAQjWZXvOWuW1?=
 =?us-ascii?Q?0pgygjIYReTpxOM+acAvtvPehPVAjjw2wbQjsxboAhxuaq/BCarZpcJNkVdn?=
 =?us-ascii?Q?jydeFj1vnyPVODI7HHiHmpNttdmtN59cbkN/qS4XSOzjmknwG8PQFW+rqDOp?=
 =?us-ascii?Q?P7FF52pAIxV6BOAP5S7IJmkvS1DmuQZ5K2jsGYWcnM7ETE5KO0w5Wf+aYi64?=
 =?us-ascii?Q?DVStcOPvkuAscgmjRCoj/sTsqvz5WWOIDX7/35XdKRy6VuBTFsZozIK1KjBw?=
 =?us-ascii?Q?Mus+B0icot1XkLcl4yxyZuhs5wnHNzu0dx9RKI+OioYSYq1vYmDk9kAp1xOv?=
 =?us-ascii?Q?do+c+e3zFo8bdQ35FP6I/hZLbSFZASpHA2Jv7RpPbhIg+zUrhv/BN1L/BfsW?=
 =?us-ascii?Q?Nwdxxgfl76cYfIS2ZdKrifLCava4W/Hp4Kyzecc0MLpJzy9UzUnJctwyri2B?=
 =?us-ascii?Q?ykPyGONVpc26E7tUafUNomF5MtoRy5g6yX6LFHxF2cwvniyAlv8LroV210rr?=
 =?us-ascii?Q?wQARGnxVPj3o5ipxxOUJkJ+6vJywkwrLTagyaHvwBnTFzuXOL6dVHcgwNC/8?=
 =?us-ascii?Q?yTMvsMH5wL4yD+V1FIgKdDJB533eZHk9esxVTuf2MZan9vHX97EkhA6cLFZn?=
 =?us-ascii?Q?qfIKUGAuzl/R6eDlScdPiNTHi+LWaxj6QtV0eDeFTyEKWQGZ7q6bJrsjxYUu?=
 =?us-ascii?Q?1wni/h12BbeeE/ga39EkUrCmfk7FqhET58FR6/K+AbiwcNhkr4YxTogmZhWO?=
 =?us-ascii?Q?G8Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O+zfS5hqDCEEAm6Aw+AR/56bpQ3T7dUtfKKOOubyZIUXDYq90rPNu5iT/Sj+?=
 =?us-ascii?Q?BuvYxqlBGKouoy52nJbPpd59eJiOMjdAMG0GdP0p4rVTy12O5FhdIp3LDFIs?=
 =?us-ascii?Q?Ag2w8PP3GD6qyAMkjy4OOTZxqVg1T3grePvFSpY+cvaIiLLkQa+1/fdcCW8+?=
 =?us-ascii?Q?pZeYKGcla7NdLVxQCYLxQnGWGcFsxKRre1yNe3PoxglINeu9I8vV8X1bTFyr?=
 =?us-ascii?Q?6xrPcC+22B0nXY+kr4Pjc4lXZLvfG/rUJ/kwCXIiHWOZVObImLYIElgObEmz?=
 =?us-ascii?Q?EIPDN5LF6Jhc2edl0GWV4O15MLjGrmHCM5lXsCIKlHyt1/XaC2AUUejidAsh?=
 =?us-ascii?Q?ZEOqmBB1MKQ5I5G8uE4O8KW6rBPpdeSRzFSzh6Md60yTim0efe90+qeYAfC7?=
 =?us-ascii?Q?KG46x0dJKUy8PbmfHkXElu1Oa2nBy6oXMwr2lpVTdfiMKxhSl6RVYkm9vLpx?=
 =?us-ascii?Q?AMd4uIprgzm8dQub4dATyerN9sUj+3BPLLxLdHp7oSxfeIq4t84JEiteov5l?=
 =?us-ascii?Q?BUKQwR7l29ax+zBmANmcmAVjIkO4YpMdLCFw5kida5eRLfja9y80+BFzSHc5?=
 =?us-ascii?Q?v0x0+h21SDFnFhqXgasCrOD9KX1sTUHAkrTXwyjwiIHPQrmd7PNgYR9CZCGO?=
 =?us-ascii?Q?2WpGT4Urjc/TFCad+EcpXBJAWj7dpswB9bvhoz0iw9OitjGTZkyICJ41ujkJ?=
 =?us-ascii?Q?LsLXZjd3vJAT8S3oqvySRTZsE2Tz7j1pk1l/lJ9RDnGwtBpkQQU+dTs5cw/e?=
 =?us-ascii?Q?5YmZcoxQJIn9OxlwYzHotx9Iy6el/Zko61smgA2nTam4YGDlOfQyWmblekbo?=
 =?us-ascii?Q?J3sLSdIJKwh1jgZmKew1Rc00hBBPCKLLyZrxetS49jnEW1szj5yNPLhcR0mg?=
 =?us-ascii?Q?pmbMFcQPJI0WVYZzzIMDDvRjsWsEdK+wISUZ58GSo+laV0ONYMMnmzNapTQj?=
 =?us-ascii?Q?Os5JlkbVbTPbLxE/I2dXHjVdTmOyr/8lJHxtzKKCeiTRBAqnLbuoa/PxBB+K?=
 =?us-ascii?Q?Q+yBBDdWHSFlgEd8tTid72vCcs8pMIKpxyfqHgPSamQlIZ00wultBcO/kiyt?=
 =?us-ascii?Q?E50mfo30yB2ztUhORYy1MdiekIc8aLw5ULpkT9+U8jd60M/hb1MONq/+yJYz?=
 =?us-ascii?Q?Z64kcGGd6T7bRJrhap/aBsK2O2XcVS5GRfzJ9jB/gCruPsNBclZegyM8WAop?=
 =?us-ascii?Q?wtaUCS5N0R8zmxLzB0mqSVLMfpzEW33iictGuKBAuSoF7iVJxf3F1h6CIibL?=
 =?us-ascii?Q?JZuPYHL+9N3wpoyGk4OKa/amIcW0ho42Zpx6nI14lIAFek7xSN+JYxAtc3Hz?=
 =?us-ascii?Q?nJSFEDwFC7LlpeD70Dfhyv9QuKah3zQC7JYJ41Hbvtgbo23sF+SifVXHgWMf?=
 =?us-ascii?Q?Y+AscFz7Ck/T9pq6OvraMVRGdZI7ejPFgPqYgnIqlc6oiCU5E2HwuCrYJnDJ?=
 =?us-ascii?Q?gGqILjryQV2ll3dhfrRIYBnDnrijfh7t4W3cZo9xOOGXJo3L0iGwbxBjyGH3?=
 =?us-ascii?Q?GOjEm75lDY4DZgNK7xhyNTmX1LtfoscbD9U5yDAVC/CldIltd7LypkUp9BD+?=
 =?us-ascii?Q?Jbuo1BrKNpzl3N5tm0yoP9Yb2y8NalIO5lHDOYne29OkD+lp94cyiY0/aHrd?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dhVLSMEfHY3O+gxBtqzHOaT2782B/2z62UQE2vWxy9FUa0K7H4No/wIEIKBF/9+hZGPx1ZKjRuKgGzXTMzYaMRB8J5AZ3/En1Vkec9k+dTUgP5zRqMyT6rncS1VTmxHbGH6W0CpsWyTkf6tq3iqiusQbZf58GA5Nf1dezuSvzOtp2nR4rI782Oxc+p/IavfFyAnVVQJd4FfuPTbvnlKU6p165eP025GuVODTyKJ5yNi7bbEOep0NEWh6pwCgFOsJyxwwg5BhL53k/WGbbKsk84au301cPzpfPLCvFv0CqemlV14VtddH8OytVSsvBoPeJ0uVxtJKSGHxRcR9ottgVtcjN8qy4emWsH03jESFl5yMlzuT2nowGbbQPJHnAtUUUXGf9xGdOoRZB9WpvCtxISlXYyqU351Er9vGk+N1kFRhTV6pz/jTOmVVEM5uim4QRp0bON9+gzSQ8KZjJaKYXPnFwKR6CNB5fyU8bi8U8/gWtW51noDbckPHZXcumszyFahZyEJC4JKLAMKbMxAhc7VFz6jetDwQBlvGtLdSDsCzUp1jZNOeUDEQvtgFnEvOFDZcMKYNtLUekK5EulULmBSrnPv7QTrEpuHF/3vdx+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fda183-07c7-4a27-f480-08dc86ffb6d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:02.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKGV5RfupUBU1PW9lzeQUT3HbplVsQI3V1LUa2Ct1m+AXQHzM5jlPFunNyESmhSLuTLyGZFcKndMiHRQBoaIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: 4yotDHs-vXG7rR6b0hnMjTwRcEkGj2Y6
X-Proofpoint-GUID: 4yotDHs-vXG7rR6b0hnMjTwRcEkGj2Y6

Currently iomap->io_block_size is set to the i_blocksize() value for the
inode.

Expand the sub-fs block size zeroing to now cover RT extents, by calling
setting iomap->io_block_size as xfs_inode_alloc_unitsize().

In xfs_iomap_write_unwritten(), update the unwritten range fsb to cover
this extent granularity.

In xfs_file_dio_write(), handle a write which is not aligned to extent
size granularity as unaligned. Since the extent size granularity need not
be a power-of-2, handle this also.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 24 +++++++++++++++++++-----
 fs/xfs/xfs_inode.c | 17 +++++++++++------
 fs/xfs/xfs_inode.h |  1 +
 fs/xfs/xfs_iomap.c |  8 +++++++-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b240ea5241dc..24fe3c2e03da 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -601,7 +601,7 @@ xfs_file_dio_write_aligned(
 }
 
 /*
- * Handle block unaligned direct I/O writes
+ * Handle unaligned direct IO writes.
  *
  * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
  * them to be done in parallel with reads and other direct I/O writes.  However,
@@ -630,9 +630,9 @@ xfs_file_dio_write_unaligned(
 	ssize_t			ret;
 
 	/*
-	 * Extending writes need exclusivity because of the sub-block zeroing
-	 * that the DIO code always does for partial tail blocks beyond EOF, so
-	 * don't even bother trying the fast path in this case.
+	 * Extending writes need exclusivity because of the sub-block/extent
+	 * zeroing that the DIO code always does for partial tail blocks
+	 * beyond EOF, so don't even bother trying the fast path in this case.
 	 */
 	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -698,11 +698,25 @@ xfs_file_dio_write(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
+	bool			unaligned;
+	u64			unitsize;
 
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
+
+	unitsize = xfs_inode_alloc_unitsize(ip);
+	if (!is_power_of_2(unitsize)) {
+		if (isaligned_64(iocb->ki_pos, unitsize) &&
+		    isaligned_64(count, unitsize))
+			unaligned = false;
+		else
+			unaligned = true;
+	} else {
+		unaligned = (iocb->ki_pos | count) & (unitsize - 1);
+	}
+
+	if (unaligned)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 58fb7a5062e1..93ad442f399b 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4264,15 +4264,20 @@ xfs_break_layouts(
 	return error;
 }
 
-/* Returns the size of fundamental allocation unit for a file, in bytes. */
 unsigned int
-xfs_inode_alloc_unitsize(
+xfs_inode_alloc_unitsize_fsb(
 	struct xfs_inode	*ip)
 {
-	unsigned int		blocks = 1;
-
 	if (XFS_IS_REALTIME_INODE(ip))
-		blocks = ip->i_mount->m_sb.sb_rextsize;
+		return ip->i_mount->m_sb.sb_rextsize;
+
+	return 1;
+}
 
-	return XFS_FSB_TO_B(ip->i_mount, blocks);
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_unitsize_fsb(ip));
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 292b90b5f2ac..90d2fa837117 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -643,6 +643,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
 bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
+unsigned int xfs_inode_alloc_unitsize_fsb(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 struct xfs_dir_update_params {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ecb4cae88248..fbe69f747e30 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -127,7 +127,7 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	iomap->io_block_size = i_blocksize(VFS_I(ip));
+	iomap->io_block_size = xfs_inode_alloc_unitsize(ip);
 	if (mapping_flags & IOMAP_DAX)
 		iomap->dax_dev = target->bt_daxdev;
 	else
@@ -577,11 +577,17 @@ xfs_iomap_write_unwritten(
 	xfs_fsize_t	i_size;
 	uint		resblks;
 	int		error;
+	unsigned int	rounding;
 
 	trace_xfs_unwritten_convert(ip, offset, count);
 
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
+	rounding = xfs_inode_alloc_unitsize_fsb(ip);
+	if (rounding > 1) {
+		offset_fsb = rounddown_64(offset_fsb, rounding);
+		count_fsb = roundup_64(count_fsb, rounding);
+	}
 	count_fsb = (xfs_filblks_t)(count_fsb - offset_fsb);
 
 	/*
-- 
2.31.1


