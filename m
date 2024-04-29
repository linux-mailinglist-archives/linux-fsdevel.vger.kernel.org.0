Return-Path: <linux-fsdevel+bounces-18147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6688B609A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B720F1F230F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53A12C547;
	Mon, 29 Apr 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E1cNoswg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZOVQmiHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4412C488;
	Mon, 29 Apr 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412990; cv=fail; b=t+9jYSy+qJxFEsWkJ9SCg9FVvqmMLm16BeNp+AKNfanf9db+rfJsF5c4Un79QObFet9LIFlg0WdzVQVABFOBz5vMNQdG2r5ncYhJFi5d0b2zlkA6J161vZS67UTTzHhRQh30Y5mDN3Ou2e8or7jn8zQpvo0ZCGFfZVF/1gLSPL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412990; c=relaxed/simple;
	bh=QAePCZqI/JHyujnyJUtKNaAC9BykVi6XEIoUzeCmO7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tgsBIyJ24pyT4EUBhJ1Q9p7YPhcINmVteIIzUl/B9DLW7vhDCHpwrhpt/SbSHeSC9qe9kGGjVn7/iqW6Km+GsBbqDe0mj94UB82Mw+2Nw01XyZdRh/sLa+TLo7bt7MXVdEzJnbAQ8CpINq/8q9L/U2eg2MkahzX0Yg+XtNqXzdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E1cNoswg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZOVQmiHv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxZ3h008529;
	Mon, 29 Apr 2024 17:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=q4lIYrcJX3xMjOHaoyH9FHJcI9CB0jlHDNsszHxbmiM=;
 b=E1cNoswgoowhNQUxu9BvwA+Ffs3KIfCptfZACH5JBI6HW7YsAOLLsLB3xVsJdE7usgZU
 R6Wn93eW6qfSN1IWF2Yiv15Rs8TJZLyxjmMRU9QgHkrbt8yReDxUDegw+L4OC2mODKfR
 Vyz4/58lBZLTRjuyJdzNx32tOjPZ0Ruqq0BM4IW0fl2i8K5ifpYooLMx9GItVuCD4AdK
 /OcLbSeIgPdDef9NYL5K3DcqYZ0rZJGPi61mXE6r2oRWFt5J0ikdKgpWtaZ0zRuopm5C
 smn5r19rG0mhYRJkQzpRwcqrDgN6pmILZVHgXcHlvaZQGsTU0loPImQNGvpQ0+Zg/+Q1 lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ck8xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUV004324;
	Mon, 29 Apr 2024 17:48:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy6surB3VWGVF/qEjqOEUJDkIHpmp40jP+k3gvPxUtVtajRgLbmaz1JJVMHRPUheIyeRX7gF9wwq4E7bdfQ8CbgwydwNZQ3oxSmzVk7nj9lm/8qvCzTgTIWjI3iyYyNGgJKhkq847oflzhKsZ7uF9Bna7w4EZtqb/kcO9DmAbn7I7Pt+Iog1Fesn96ruMIBWB0EVIa61XcmPVPD71M9ddmFwvjK6pUkDoV6TN4zmIEp2fHAzSeH6TIybm4fHSRurcA1znFVkMJv2IcBlfMsLPx1Ui7m28ou2tIDqKJ2zelb5pkWW+LGt9qmj5h6iS7z/9hIgiF4nAapdwlFYyWAMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4lIYrcJX3xMjOHaoyH9FHJcI9CB0jlHDNsszHxbmiM=;
 b=M2K5KJEnMmAFggLVWM9lVxYzcHB+uxn6ID0hxOQsIS36ER8Jy/fiE8dS+kEIQOoSGqmj0JEQL0vWJNPUqjWR34mqomulYRkKP9UaiB+FeOhFy2KktFjH4bg4bhgt+CUeSgakjkqV4qAOC1RnYjPsbu78MpONphifKcQg5kF++riK83DEcKS+k4DCVOjniSxvUdXvW5RULpD9ptKzr91Tskcw/xVbfDPGAS14qduvIkaErrFadzwLcVp2ElH7AN/1qiuvTdlRkrMFcgYuVYpCbUHTDNbHCwJBZuQ1Tt5TL1Lahp0RgWb+tLXFvH9qdVL2T/XanRWBJ/KMcOiTducEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4lIYrcJX3xMjOHaoyH9FHJcI9CB0jlHDNsszHxbmiM=;
 b=ZOVQmiHvRmKyXvzJoZz06x+IpLzkGVwkWjfTyS0JbFg5JAJYfWMLiphDOFjSH9zVEWfmxuHwrMH8ePRvjs7MyB9hb3o8A9D1UlvN0fEMa1dTySjO1HED69+KF2sglqqfenK9AAmlXtrNtqPTYBYn+yEu+bfeARATddOls4ckXkg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/21] fs: xfs: align args->minlen for forced allocation alignment
Date: Mon, 29 Apr 2024 17:47:32 +0000
Message-Id: <20240429174746.2132161-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf9de87-da57-4292-4a13-08dc68748e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m5j1j8bwhPzk5c1j3hgrsEzfyzYtWXqK4JCyFTBXUisdU6WGK1V/dsdx/kxa?=
 =?us-ascii?Q?V6pF8qn2914vXaVDi/ZNArzFbOw4tbT/lWcdDf6insYjusI32qKpZlZp445f?=
 =?us-ascii?Q?NImZNUzkSaZB9Fl07rZhlHHTZkNG3p36N0EIAkNYAcTHXhO/Y6hGZ9wqK6jN?=
 =?us-ascii?Q?fhm+In+QLZpp5E660J/6y+a1PPICXKMdHAuhKw5MM0KxglEE94MLY/jntG59?=
 =?us-ascii?Q?lfzGcgyfXulzjF6qqh3WXF8qwsjPsBSYWmYhIifoF/K76WGazkeSa6SM8PgO?=
 =?us-ascii?Q?sqTTQKChEFzXmU0t/cW8ewtjuWnc4CeaVkBNy3GLIYS5DEkpJXF8i6FA7wCA?=
 =?us-ascii?Q?/0opE+fwRN2YaeUKMDOHt3obuhmYRz5/wsFVBqdDviHTOT0tEPSZb77myr4i?=
 =?us-ascii?Q?14UhEVweBlZAUQJK0NGU4rOpCBT3uPCOJeyecsb+78NLvYmQC273x70MqiAp?=
 =?us-ascii?Q?wuqdbUvt6LE6gMb2IwJgrP5HUylD58i36XjIRBD8fYGF/y+lai3s2ZZdpa+e?=
 =?us-ascii?Q?WTuWQXgQ4+zGyn6fXfVolxEK7cUegiMJdCzXQjfBZpcVwKX5y8tThUK/RGG8?=
 =?us-ascii?Q?aFgtkVP4un6tP0cSQyOS1yh4DxGGnPSmh4T74rQEK2nAEpYN8mNCWTSFq3Gv?=
 =?us-ascii?Q?SUviogp19SyiyDsqJ9SLN5gUxNUszg6SR8KW4bXJt7Lt/NPnR5F2QDwD0pg7?=
 =?us-ascii?Q?GYmDcWKmD2jXnfu0n+BfrLBbKXNv/HOSmNqhA1qW3FsbIAlSB7LmeavD47eQ?=
 =?us-ascii?Q?IB99L4AOOtYPlP61/S6FttIE1pHZTqGi65VFSSS01PfosPJvZiEOQeSep2yT?=
 =?us-ascii?Q?0a2j7j9l8D2ym3cokgA67T+afMDxg3PMe4GCcp0uDvO9CHOQQEfmsScqXdpa?=
 =?us-ascii?Q?1MMXhO+W7JbFRwprG3fuK25jnL9qXoBkeCYG4o72/uhwmBFR+8d7P9JjhZdx?=
 =?us-ascii?Q?mFm+2ZhsQyQ2U3EhfrUiL3nTnHfcrguEBkQb1/JcKuPL/A4kymVCqyKwgAOr?=
 =?us-ascii?Q?Z1vi0KNAMMCCDi+/bF7VsKhtuNftBHiLi4XVhfsGILGc/Vxu5u2jt8WzfW9e?=
 =?us-ascii?Q?JKb9i4G3SDyBTIxDtlkntV30La1lSTlwiUBnwaFTMl19XO1XDeS8naQTFGOf?=
 =?us-ascii?Q?3gmwTa4a2GURXlPfl7+HWLwSs7F93U+0ZoGIPPIuuZ2ogQm3F/T/i8CuXdht?=
 =?us-ascii?Q?rJ8qWPOa9Oy+wcN039+SoKvKYqht21JGCsdhlIXxiTc7Sd2wekzzscKLW/wq?=
 =?us-ascii?Q?GnTz4LBjRt8rWdG4NFpQc5m+pfe2qDtSizFa4MnpuQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xpvBzAsBMysZ9hGw3MUB1wZAS/0WfCybnt39PgqMRgmEBLBGPilektonXDCp?=
 =?us-ascii?Q?mp0BS4hnZ1JGM7Ksrzt8Bdd5KWZy9wAdEegkbs/kftwGr54/dazg8HPD6Cwx?=
 =?us-ascii?Q?ob6JOUKAR36hl9Puy7/lQbK8N/aWqwiPtLP+i6hXAnFRnZBs+ah50iuhBrdV?=
 =?us-ascii?Q?2ZWaya2LX4nAExTKLHLm4Irjt9t2ylxymlxNMi03ftVNLOiMCS1b68+VPM2D?=
 =?us-ascii?Q?omJ4QXn66kOkVTRGpmNs25NaMTrG8G2XjIFABswS0vtS/KUVMenGOj2MgYuS?=
 =?us-ascii?Q?pM0fyMRIHWX7on+nWsc/BTx1V9hYgzgsLiTRin7/jL9W3FjlgjuQK/nr1+5D?=
 =?us-ascii?Q?LGLPBnvHoC78QojKl1f79/M4DxLpBG69/u0Zv+FL7OT4rYJSmKb/sNKt3S4c?=
 =?us-ascii?Q?QOHdDVvpM058J9bondRjv7xRhGcFngj7Pfa72fRLl3mMptZF6agYRtbZO5tt?=
 =?us-ascii?Q?ke9rrKj1JSp65NtWWHZbg9Ny3FmVvMqfYmNyQDGh0Mf1SCEYzmuvyzYETIWc?=
 =?us-ascii?Q?WIrBiMG4iVxggBkv96t0fGDzbyugkAETFHTUzMLqrsxSzhFOiCVExrcdPAXf?=
 =?us-ascii?Q?N5QUXhwWt5Ztr7gZOI26YXvlcYCN9oHJTK5o1UxrjXLvpTDLUok70PycLxk5?=
 =?us-ascii?Q?ZzZr0Ohrf75km+T8QP3CFkOeNs3R1VotbFgcJf3WsZsubOEHzfWOVTmqeoYF?=
 =?us-ascii?Q?AeBgCsUdw8y4Z2yYMOwHWsCQ/EiODl/fWYD6mYGd3qOusb3qUPmucgiEgQto?=
 =?us-ascii?Q?vwbbHxz3qzn2QMWIqA1MTACIOR5D/jwVGXSaLO4+nBULvK28jzs8+VFcbFiX?=
 =?us-ascii?Q?+W7+nh/l+Mmd3BsxFTxqED724qaLE3M8Bvv7S8/F7N1it+q1dgNugDWqUEas?=
 =?us-ascii?Q?bC7oxUbpk+ofF8C7s9sTu7o+0tsKyCi10Sq6ytr/o4ldOH+Jv9HbVssiDDro?=
 =?us-ascii?Q?uGGfsjJDzN2bCyrG5h25HKUMG6D9L0WRH/JGbzDW2H/ZJS1SeQVwKvMoPmfw?=
 =?us-ascii?Q?YGPk5jQ1jW8IXcxQgoDqBX+yAKXiwz95Ju+v2cYGEDTih9OWAqUXD7RELkkN?=
 =?us-ascii?Q?Jv2vydf018CpIBnOw3ZPjiB5ZVTjClAxtfnRDuXq3R3HLwdmJqsddOTWi3vf?=
 =?us-ascii?Q?9C9gxAO4XIMvojLuxyWGuFngoyDZ78fZjytxCGPf8XSaTLgQqdIPGZlf+m98?=
 =?us-ascii?Q?01s2jwUQxALP9gA6YyxWKXF/pKXlvELIO2nE+1jTr571yHg0WTF3qAtsrm9L?=
 =?us-ascii?Q?/P+m1+r6teywDetnNrfamz9Ax0LHFA63JWR/7+fhA9+ruGSPEEldCXNRlpWd?=
 =?us-ascii?Q?S+rvhGGRGKw61KnM+KYAInQgyiunOrVcIE5QdYZxDSITSXPEENIsnCQ9z/YZ?=
 =?us-ascii?Q?AO/TaS4kbJIIp6ji0mk1iizfe474Ik3FWZ1CWdCl6XA5sPjLt2KJM2v6UGPa?=
 =?us-ascii?Q?D1PcqFEqWsSpTXHrVmrL7HWBn9YPS2fRB5BMcgIfxJ5d8Hu2/C4IfCfjwjeZ?=
 =?us-ascii?Q?nbEj9jIYie+tWGDcYYiXfXGLhd3K5riUcuDDitGSExRMG8ErkxoSPJVql19n?=
 =?us-ascii?Q?R3uVweKfuuu+gqBiC7BcpQBacPshy94YwLKvX4xSpdXKT0x5UbOBAgT0U5Ho?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h80BBX1JA59y475haG+QjYIo8g9CyMAMgHWMKtvaeMimwPLdYbNGCO/e60lApBF9x7hSbHwqVEaIMG5rbvJigu5F+EyE2OzItlkhxdqd2nLJwM5zwzSGkFV+zegz/1Cu9KNVXQgHGy3kBJVAadZ8rosgO/Da5MNAmLILfpU4ovfGP0MV2Q0kgkgD9hBYkAA3I2Hx9wcv/tBbs5+YDG7f9Vld1tCGE3Coo20YydFH4gpq9iZz8Dujfptudlmu+LSkIeLLAOVY2G+dbP63s0JFiNyecbHG29UrAheDqt/OfPxA6mCDGP72gS9U5Z0HDc+0oaWhQ7xEymG94q8vbrdKMoAA3wd7fILvt5FlOpcC5zDoZiz4e7mXnaf+d+/q8BF+OC3BmjCoCVvFAVYQeSA3rxLcFMlP85FQypqAt2HH6Ui2ScXOKc11t2WoZXXJGVSexcRsEK/9sj4p9sVs9nT5/ot0kahvy1fAF5RhDdwWUMHNalc5dR8Fy1UXSKXEOvz7Z97Qf3hE1GpID+9sNASdeIEdaP46CyHeqN/6ML/be/dngc5QiJ6YfPBTUa5VDEhqjv/eYi3+/4XJR+wOiu3gSSadCOeU9fHewP0ym6JY5G4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf9de87-da57-4292-4a13-08dc68748e9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:19.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUCTNjwceTj9JKt9Pi1DDhWExQfzN6Un1LcGgwX0TV04rsmUiUJAf+IA3/Aa2+HaTChHiE1sO5FzgMmc3sDfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: LiRcRaZnlLnuWjnpsNyfzO4hfB0S1M_4
X-Proofpoint-ORIG-GUID: LiRcRaZnlLnuWjnpsNyfzO4hfB0S1M_4

From: Dave Chinner <dchinner@redhat.com>

If args->minlen is not aligned to the constraints of forced
alignment, we may do minlen allocations that are not aligned when we
approach ENOSPC. Avoid this by always aligning args->minlen
appropriately. If alignment of minlen results in a value smaller
than the alignment constraint, fail the allocation immediately.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 45 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7a0ef0900097..4f39a43d78a7 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3288,33 +3288,48 @@ xfs_bmap_longest_free_extent(
 	return 0;
 }
 
-static xfs_extlen_t
+static int
 xfs_bmap_select_minlen(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen)
 {
-
 	/* Adjust best length for extent start alignment. */
 	if (blen > args->alignment)
 		blen -= args->alignment;
 
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
-	 * possible that there is enough contiguous free space for this request.
+	 * possible that there is enough contiguous free space for this request
+	 * even if best length is less that the minimum length we need.
+	 *
+	 * If the best length won't satisfy the maximum length we requested,
+	 * then use it as the minimum length so we get as large an allocation
+	 * as possible.
 	 */
 	if (blen < ap->minlen)
-		return ap->minlen;
+		blen = ap->minlen;
+	else if (blen > args->maxlen)
+		blen = args->maxlen;
 
 	/*
-	 * If the best seen length is less than the request length,
-	 * use the best as the minimum, otherwise we've got the maxlen we
-	 * were asked for.
+	 * If we have alignment constraints, round the minlen down to match the
+	 * constraint so that alignment will be attempted. This may reduce the
+	 * allocation to smaller than was requested, so clamp the minimum to
+	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
+	 * to align the allocation, return ENOSPC at this point because we don't
+	 * have enough contiguous free space to guarantee aligned allocation.
 	 */
-	if (blen < args->maxlen)
-		return blen;
-	return args->maxlen;
-
+	if (args->alignment > 1) {
+		blen = rounddown(blen, args->alignment);
+		if (blen < ap->minlen) {
+			if (args->datatype & XFS_ALLOC_FORCEALIGN)
+				return -ENOSPC;
+			blen = ap->minlen;
+		}
+	}
+	args->minlen = blen;
+	return 0;
 }
 
 static int
@@ -3350,8 +3365,7 @@ xfs_bmap_btalloc_select_lengths(
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	return error;
+	return xfs_bmap_select_minlen(ap, args, blen);
 }
 
 /* Update all inode and quota accounting for the allocation we just did. */
@@ -3671,7 +3685,10 @@ xfs_bmap_btalloc_filestreams(
 		goto out_low_space;
 	}
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
+	error = xfs_bmap_select_minlen(ap, args, blen);
+	if (error)
+		goto out_low_space;
+
 	if (ap->aeof && ap->offset)
 		error = xfs_bmap_btalloc_at_eof(ap, args);
 
-- 
2.31.1


