Return-Path: <linux-fsdevel+bounces-43921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772DA5FD3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4D0189E13D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662426A1CC;
	Thu, 13 Mar 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0e4+K9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ttQhBHuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860D26A0BF;
	Thu, 13 Mar 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886024; cv=fail; b=me6QXUtdXysHC2E+zxKHS3TrNR4qH4SIiXqOP5KKbLa5FvfTt6klbIfd1LPQOUCTEZdoQ4nZPaDO0o58bbGXOdqaiUQ0L/WJnDIaBMrUUtWhWiU1ANEE4mBGhevt1w7gpHLSY4A6nSdCz3gklCRXlpRLw15XkkFh7ej8TrKXxSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886024; c=relaxed/simple;
	bh=n1AfahaoZTcAu2gCznC/2LtcnNiHpaWV5DPvjO2Tlro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lk3f/HD0NH73LIsE4xhB1tMBn/+shzUp4oX2C9TO/dY/YbuIwJ38H3QKlopOGt5131ynEZl5WdiQvRQVb3qm5g3GB8iX9uSMIWuskLGb0GLxmYqikVyn5PaajExmJLK2JAu75gNKgffciPN+Zzzwgrlql0ie229zgAEFr8gE5+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j0e4+K9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ttQhBHuY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtr6O007035;
	Thu, 13 Mar 2025 17:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CqQZl7iIlfTH+uWs9VjezTYQ9vIX/S7YbyM9AJhXhys=; b=
	j0e4+K9ET6RMkYaMy5G8st3RKVJBZRgdgTfY1FYQOg2D3frpIMiUSCbJmsxUquFQ
	Um3lclwMCe7HEJl4/uWuYNRZjNnxJSguE5TpeJBOrZAT/eXQQieDeM7ngRjLvniX
	dexh66DNCYlWNWiMIUyHBD7VSfk6I1vtqqVAzQmObTwMdgdbw1ay/6I00alKdPt3
	AfVMCQfG4d9M0tu5PlVuT6h66TZUARpkZkiFC6Kkawc/dA3vUdokD35yDHgnH2Qn
	hvPk2zcHL0WIOeEc1csIQczv7+olzdczvfsW7bylloSuvD3IzZk0ZGuBG+xTcZje
	HcLrEwozcCLsk4mGEpbgxA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dmrsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGTRUk019319;
	Thu, 13 Mar 2025 17:13:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1hMuUM3P6qgaeX4/DVBswvoh8opRV9u7jdEeBA3W7FCOiip77EW7CqbyrfOq94p3n2GwiLUYV6qiATS+FfkqkchkolUaHMhGKD3Eso/x/UywiewT5B5k6EsWAK+WwZohMqkPkM1VxpSnQotgp1yFnDSVkKnmldEAG7ukf/y2KJQCSV1rQ7l9A5yE30hWq9b0Kj5GaS2qdnMUIiSFr9/B31T9R2oHBwOcanS8hLfI2jMGtxSAoZG89uRueoWxDIl5P1yk/vhkmVTUFKUWqVvt9kXTLXc6H0vVpzNHbF2iuwqH8zwR6J8tYCnzXFuR5e6Bx5eKvTWjMVAGrQZpD+e+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqQZl7iIlfTH+uWs9VjezTYQ9vIX/S7YbyM9AJhXhys=;
 b=q64KH5rj5P5J746LKYo70ecjVghVeyEDGiNw5ZHmI6fBgi24svT8BOp33M+1DKUlc+XewFyAgyMZXSBYlQVEe9M+Z64SNvIAYKO+NkZJszJx8ffhcm43YIghc2u68y/g2EDT0GILaP0/Koipwc/uC69CZMPaH78+DJLJsAH42tIILGHdxU9LCyxKbIIQYo2cBbsFP/DbJSbI9ynzXQjkZ1AUVVhVGQhFK/EZFG2h6gvnrEtSS8sh+rbMrkqvzBcW8VYP/lw4QKXrFl6KxsJ+bGGF3/T0AyraDUUKQkMXXJ7YhJxjRGawu5KkabnB1oowkNuNfS9akknxFZhhFOSRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqQZl7iIlfTH+uWs9VjezTYQ9vIX/S7YbyM9AJhXhys=;
 b=ttQhBHuY64AJpSjQmiOs8Ucen3p7Za29NJa2W1ljfg2xleaQXqzM8famWZj5+5wD0BegVOBhfmYPsZF5PoBT/dgatwNvGGDolew+jnPc+BdRe0dwiIULNqfrHRPvW9RwQSrFAUI7veHAUMOZaPmjxO4wRzI6qFoYJoNegh6Z58M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 17:13:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 01/13] iomap: inline iomap_dio_bio_opflags()
Date: Thu, 13 Mar 2025 17:12:58 +0000
Message-Id: <20250313171310.1886394-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: b420c126-918d-40ed-a40e-08dd62525d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YQUkEey6Ir20q8hlddZo2u+fo1ztqY6TI43R7IIppp3BPlrvUfLoLmW8n9D?=
 =?us-ascii?Q?LmE3mImE+ixbjk2xDoXLkY0pHs6kdIB//IdP4rtvpRhbgdgnuWpvEVcA1U90?=
 =?us-ascii?Q?PhMH8/c25Ii0NHaEgGAGEq1MoYrG5YniFwu7DieXNkxa/3moqXQNB5QsWiI/?=
 =?us-ascii?Q?KQw75I3VEcOD6O145+gijB6o+nUSA/dd1ksBlubWEwJoJJXd/IDBjHYVjlWn?=
 =?us-ascii?Q?Cw7RgNDrjNsILB6sz5I7ShsBVatnBADZST6Zh9Tb5sSKh+B9AZpx6g2UKUDz?=
 =?us-ascii?Q?TjRYk3AOvvteyroLmtGPDTvP0nRGQVw77V+qgKnlT5WGr8GWRDKg8kRIJWSb?=
 =?us-ascii?Q?VZ+b31HBtGHxAN7p5UFfg4P9jOffNaxeEIi1fR3p20RqBGpYKXcc4uqfyhx6?=
 =?us-ascii?Q?sxrZmZzNAspvrV/Q/xnxTNGCyTEfjXVG3g93+CkRudmzX3Sj2San4SM0kJKd?=
 =?us-ascii?Q?/GZ5Z2VM0vjSKCCXdEoDe0RdV5RWwL1o7zBjj1JhOaXAU6xAMFJ6ev+smIgb?=
 =?us-ascii?Q?K2gc9Zc8W8DWi4gG3kiSe3n3ezqvuWiud77zp0a4i/Snb/GiXHFfZzJJd1CM?=
 =?us-ascii?Q?C9HAEwiRKHz1K5u8kJqLYJ/UqRDwpctpot248SmlOCHeOp9qxTkyeC23gt/W?=
 =?us-ascii?Q?SNqgeSjDbKqWdTG9ibZFoQNsjcvic2+F1mRronxfbwSOkCVA04p4dMyMJpYh?=
 =?us-ascii?Q?FM0JOYnUrzf8a21/WWo2MnQZOBEFoea66vDLr7Zyh/4du4ZtySTb4bszo+Sv?=
 =?us-ascii?Q?hEiSI5uyGhg2ETAxzc/Rl8prfWLQbTZBvMJH6Pwy9C+Wp00176EXqDvVTcx/?=
 =?us-ascii?Q?uM+tSMJW/TIjkWrfwhErF2L8DYfNK30EDW1seDdBGR7aDe1SSuatm0ihYRgs?=
 =?us-ascii?Q?bi4rTL+ZiQCafswz6D6e8pyWElNTRP4kaf4Xugo9TuDLsidzGl77lgqBrs2r?=
 =?us-ascii?Q?LwgwaGxV6by8BNpVbDLKW6IWxt5fg6UNCUTkxZ+k92wuwVlnS3kTaJdG5sim?=
 =?us-ascii?Q?279wts1z70M39viWz5PT4+rp+U8Z33ljJCZsukKRddoD1FIzmhA1VTRf9KT3?=
 =?us-ascii?Q?iU0Vr4UkQGkOw1ciH1qRfLhbHBywLdFVEbWGNBxc3rGsp/mvTHaXdVzkyWZl?=
 =?us-ascii?Q?4+tg3sasd64+HHY3OdPrhBQtGW2PpPkADY97v70tzjaY1bXKWhHkDij5Fxkn?=
 =?us-ascii?Q?NYyalliquotPH3h2+ZGSrsEoH6Pfkgp7ADG65Vs1wJmqlA4Zxtj0lJWlcNlm?=
 =?us-ascii?Q?R1EBK3Gxbv0O9RFUglLA5EyeICjovjy5uu5uhyVkE9EXxm7eSoH8Y2rDmu8q?=
 =?us-ascii?Q?BtK/nBOpZZMHrY1o6XViR3eI9elsQSIX3wFQNjWU9Lb9OVQUncylrvGh/FaG?=
 =?us-ascii?Q?BuFB7WOWBhimeUYI/w1hdQxaYrZ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bp/UMcOkAlOqqHUTrcacpKeVDqtUJwOuidP25A0t2a4Nj9GRlPraXn4XmGC2?=
 =?us-ascii?Q?5WHFknp1u4tF9A9MTJwaviKN+smu97Msv7Yfzezc5JMC9y4baxUfoI+ZaRWN?=
 =?us-ascii?Q?xovyxO9RgBF8uo2VfsUiNFB3AlNZLZi+ZfBWTPgjc9RHhFu7CacCI6yBGO4O?=
 =?us-ascii?Q?3L3mK3MeByI83YEdqmN+u86Ne8HWkLUkraQJOf0wt3vDUrVw9iVyjtZfvZam?=
 =?us-ascii?Q?5IPDWXvXycjsjHl6x1ty+ygyi4MJ9j8K1U0oLqx7w+X0sPFYpIwVjKTdasn0?=
 =?us-ascii?Q?Y+wQujuLReOS+QgW+FGvaZZFgHxe2oGl34O/tAecrPSJ/39LUnRnPlrI8/OD?=
 =?us-ascii?Q?0q0uBG/oBlivBrMvKCteKj4cwlF0d8obNzVzPYVrhWAyIp4qn4qhSQIQrUdL?=
 =?us-ascii?Q?7qg6wZcPFFelFoa1oPP01Z52sOp3IKuydKQ0TvzY7+TJYvNG7qJrpE5VwkSJ?=
 =?us-ascii?Q?GzEwS4E9HZs4bO65Faxo7jxtXMpXwYtgJ2zye89JzpwGFvFUEGlc+UMw5Ttl?=
 =?us-ascii?Q?RRqFUmlfri8AtTZuslPbOhl4WaTWPNwRKcIhyrdiF/lv7TBEWHh57Zffiz6q?=
 =?us-ascii?Q?V43PO+ZGY2pefORTRrrytliFwK3ZVxfRe/c8ofrQPYE5ROr1gWAIvK3GEoAT?=
 =?us-ascii?Q?aYoPrUF8nReHqMA9xZFmeJPFcabkXp75GjDFfY7l+uzk7o0QMpCepSrW9IaB?=
 =?us-ascii?Q?4fx9gBtcpYuxagjkwGix3aDkcMDoEmhAVtXY0YTiWZ4RPxeJfZuaPQQOedhs?=
 =?us-ascii?Q?aV5Ulse5Mu/7t0paDIP8tIFHj35wse9+vzDnTvxtxpfhn0zgJxmSjdlc6tE/?=
 =?us-ascii?Q?aVaKz0lKyFRS4otuU/f0oqHWOl4+H2Z+RL8y/cc8BwRWORszS8IuFkzeKIh6?=
 =?us-ascii?Q?ubLiHo+Je0Q6HI5QhKyDw5lxm/NdgbYzn8ikjMP2oY8VOuM+XnxRT6OYceBQ?=
 =?us-ascii?Q?wGagUDj7X39MFqEmPkWcdiZcMi8Ps1e54xJCA8V9rEHdCYrTY0/6cQm8vqDR?=
 =?us-ascii?Q?GP3E5bCxxB0AVNuUhUJm+kqqKHcVejVpJf+35HHF/rUzKpvbzcSyiF8eLVV0?=
 =?us-ascii?Q?RmsvU0lywvXAlSU0IT1YM/XPxut6nZw0x/FPZUL1+n6PPCpTbVGYwcj7o3g3?=
 =?us-ascii?Q?9V3XyndFuErE7/Amwmrk6ZSmSfKyHAWF1SbmlUQ3UzA5s9oSkRYHXaeiH3X9?=
 =?us-ascii?Q?v1x/FDawtqtnX7N1Sz8hrctqiN5mrCFNHq6qpx/uopu+8YKy+jPVKf2JsyyY?=
 =?us-ascii?Q?ynYWlCpR49r/uwbgotH+rHJiXIYBRw2XpsEnoCBYPg4aX33hhEDJO4OUGoqD?=
 =?us-ascii?Q?om4QzgXIgDjxCcVER+xHVxQGfnGKRe6RdqKDZO9wr627ilNKHCycQwp25VDK?=
 =?us-ascii?Q?D6+5JO7OquXFtBGqFKOMXuVfWXsjibheFKY/X5/l3q+zLx6MBwSXqBEYs/gv?=
 =?us-ascii?Q?wtHUulcodHaY1SbxWDp4C/n8vRRDQsHWgelujx2VNhLK9OQO7vbj8t9XvzhV?=
 =?us-ascii?Q?1TQrf4SfIba5+/uRO9m8FzxCh4lLGZhj/0QH+1YTvMhERhNdWilFPUy+Yx2z?=
 =?us-ascii?Q?H5IjIDJs6B7bFYprfkfTR80zcXwejVKzObCtZTTVmmpSyZGg1LJdS73WSWpf?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U98LzASKD38V+xjEkdAVOJ5F1p+uZr2GB6tjuXtx7QWzyn9VjDzt/43R3Q3TZNIAOSYutFTdf0P3rgifXuDFmF+STqQfEAi3Nm0VhNAnbIhrh2fjqJsMuRBMdVEgnnbxy2HhHIRtOVqlIdFYtJAEQmIzyfX3dpbUxUu8QGnX3iwxHJZ/63fb5Yy5k3Tm2xDxYIz5IwtGn5oGv2jzsomxEoJMYlPJCm8tEYCROCGmj6p6NoOc8iFXzwbW5ora5XnbKJg+w8I0w5NcOIlgRu4Gfw8glKpTd7nQGx1JNFikcjxB2S7cJ9cTvhsd06HPKPYbKdjHOpnm6sCL6h8BWOOhEVEw1NItMZkbe3vbt2DtGN7+XaRxecXZoNbxM1YUESr42iOVNN2Qiy87s2QXtE1px5eSgVHntFnAUk1vwTolK6dNVChjVJPXbUt04usvac/n9WPaVCvN8f9y0GPaQGGVcLpeKRVGFVxBn6KNwdwz+EL/m2Ujwnne29hdeWJg3NQ8Boyaqf99HKzRFfAMal0ODsgzXAJc0au6uSSM4FU1y6Y4X4XXDO9oHa4sA/YVAHYqrcKYaILG3faKdCty5v/GmIAMBZUX7rsFgqhcmguvHrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b420c126-918d-40ed-a40e-08dd62525d86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:25.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFIMAsHamNml31akdlyl1fc+ceXIfuMfoMpXWPGc4qAhoyLiymzzVq5M31s9JNvYLsmRDnUiwO9JE54+zPWs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: iCP-Gr_QIxVH4OalZmtaKdi74BLg85HP
X-Proofpoint-ORIG-GUID: iCP-Gr_QIxVH4OalZmtaKdi74BLg85HP

It is neater to build blk_opf_t fully in one place, so inline
iomap_dio_bio_opflags() in iomap_dio_bio_iter().

Also tidy up the logic in dealing with IOMAP_DIO_CALLER_COMP, in generally
separate the logic in dealing with flags associated with reads and writes.

Originally-from: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Should I change author?
 fs/iomap/direct-io.c | 112 +++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 63 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5299f70428ef..8c1bec473586 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -312,27 +312,20 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 }
 
 /*
- * Figure out the bio's operation flags from the dio request, the
- * mapping, and whether or not we want FUA.  Note that we can end up
- * clearing the WRITE_THROUGH flag in the dio request.
+ * Use a FUA write if we need datasync semantics and this is a pure data I/O
+ * that doesn't require any metadata updates (including after I/O completion
+ * such as unwritten extent conversion) and the underlying device either
+ * doesn't have a volatile write cache or supports FUA.
+ * This allows us to avoid cache flushes on I/O completion.
  */
-static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic_hw)
+static inline bool iomap_dio_can_use_fua(const struct iomap *iomap,
+		struct iomap_dio *dio)
 {
-	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
-
-	if (!(dio->flags & IOMAP_DIO_WRITE))
-		return REQ_OP_READ;
-
-	opflags |= REQ_OP_WRITE;
-	if (use_fua)
-		opflags |= REQ_FUA;
-	else
-		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic_hw)
-		opflags |= REQ_ATOMIC;
-
-	return opflags;
+	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_DIRTY))
+		return false;
+	if (!(dio->flags & IOMAP_DIO_WRITE_THROUGH))
+		return false;
+	return !bdev_write_cache(iomap->bdev) || bdev_fua(iomap->bdev);
 }
 
 static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
@@ -340,52 +333,59 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
-	blk_opf_t bio_opf;
+	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 	bool need_zeroout = false;
-	bool use_fua = false;
 	int nr_pages, ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != iter->len)
-		return -EINVAL;
-
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
-	if (iomap->type == IOMAP_UNWRITTEN) {
-		dio->flags |= IOMAP_DIO_UNWRITTEN;
-		need_zeroout = true;
-	}
+	if (dio->flags & IOMAP_DIO_WRITE) {
+		bio_opf |= REQ_OP_WRITE;
+
+		if (iter->flags & IOMAP_ATOMIC_HW) {
+			if (length != iter->len)
+				return -EINVAL;
+			bio_opf |= REQ_ATOMIC;
+		}
+
+		if (iomap->type == IOMAP_UNWRITTEN) {
+			dio->flags |= IOMAP_DIO_UNWRITTEN;
+			need_zeroout = true;
+		}
 
-	if (iomap->flags & IOMAP_F_SHARED)
-		dio->flags |= IOMAP_DIO_COW;
+		if (iomap->flags & IOMAP_F_SHARED)
+			dio->flags |= IOMAP_DIO_COW;
+
+		if (iomap->flags & IOMAP_F_NEW) {
+			need_zeroout = true;
+		} else if (iomap->type == IOMAP_MAPPED) {
+			if (iomap_dio_can_use_fua(iomap, dio))
+				bio_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+		}
 
-	if (iomap->flags & IOMAP_F_NEW) {
-		need_zeroout = true;
-	} else if (iomap->type == IOMAP_MAPPED) {
 		/*
-		 * Use a FUA write if we need datasync semantics, this is a pure
-		 * data IO that doesn't require any metadata updates (including
-		 * after IO completion such as unwritten extent conversion) and
-		 * the underlying device either supports FUA or doesn't have
-		 * a volatile write cache. This allows us to avoid cache flushes
-		 * on IO completion. If we can't use writethrough and need to
-		 * sync, disable in-task completions as dio completion will
-		 * need to call generic_write_sync() which will do a blocking
-		 * fsync / cache flush call.
+		 * We can only do deferred completion for pure overwrites that
+		 * don't require additional I/O at completion time.
+		 *
+		 * This rules out writes that need zeroing or extent conversion,
+		 * extend the file size, or issue metadata I/O or cache flushes
+		 * during completion processing.
 		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
-			use_fua = true;
-		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		if (need_zeroout || (pos >= i_size_read(inode)) ||
+		    ((dio->flags & IOMAP_DIO_NEED_SYNC) &&
+		     !(bio_opf & REQ_FUA)))
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+	} else {
+		bio_opf |= REQ_OP_READ;
 	}
 
 	/*
@@ -399,18 +399,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
-	/*
-	 * We can only do deferred completion for pure overwrites that
-	 * don't require additional IO at completion. This rules out
-	 * writes that need zeroing or extent conversion, extend
-	 * the file size, or issue journal IO or cache flushes
-	 * during completion processing.
-	 */
-	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
-	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
-		dio->flags &= ~IOMAP_DIO_CALLER_COMP;
-
 	/*
 	 * The rules for polled IO completions follow the guidelines as the
 	 * ones we set for inline and deferred completions. If none of those
@@ -428,8 +416,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
-
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
@@ -461,7 +447,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic_hw && n != length)) {
+		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
-- 
2.31.1


