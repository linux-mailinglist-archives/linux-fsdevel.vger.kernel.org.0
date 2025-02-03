Return-Path: <linux-fsdevel+bounces-40656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64912A263FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E488B7A300D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DC20A5CF;
	Mon,  3 Feb 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGIGwRL0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xkMBBJG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F51D47AD;
	Mon,  3 Feb 2025 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612064; cv=fail; b=PbGcg6EhIN57lM1Ofcwvr3nky5Wu+4iEcSpELw+ciVf2MxO12rm2R6XWNJZltEXRBxbv2wDvbenlcCPB7/MXZYCjSoX7CZgayZQY+D4Yj2XfE141vqj8CCqLj1EjsDCJkRvmBARNKM4qJIR9aXKXbENEjMU4y8c54H0vE56pdfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612064; c=relaxed/simple;
	bh=+76K2GKR6WroSXSPpd/MesB3Hfr9GBXj8aRexlKEP1I=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bobzP07PILm/QcRmixUS2akPjevhu85QS3GTY8mMSIv2LfTrM/f53D85zt1H/CusgU8vWRZSNywha5MKvt+j46RczyxZvq/VRyI+kCPKYvk6lVVBVGynC6bb6IwtSp6Z0JuIWFCHDVm0zqMHnOZOgbIwkeU6Jqh8W49B8USVocA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iGIGwRL0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xkMBBJG0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMwsh008595;
	Mon, 3 Feb 2025 19:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kfE/cXn+blAyYE14FN
	a1qwXml3Zodx/vn3/onxfRZuc=; b=iGIGwRL0WUiS/dvKMeK42uBLsA1ipoArLN
	Qh/r0+P6QrYrY2/cVSFoTjNOMBDx62nNOFwIvp27EuSOVv0c/MRe4o+87WcZeMD8
	0CpNz+95Y4AkLiNcC+NlHIiXCXdFbLcwMf4GelWzshBVsMkZaVeiF8GizuGWGSTP
	LZeV5/4FVNzJ3+WnwSZtvuEv2JeWLY7S0LbKXXxnKgSjlN3JlXVKXNtilk6aL24u
	SlHiuC5LTQ/U7oDm8MQsu/fia8DnCx7x084GQAQRN+e5AKyzvced1dy7h8T+8baf
	s5jiGWvtnO+25kZsACiLWjcEA9j9dYv9dlDrzy2KTCv406KIoqUg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hj7v3b6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:47:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513JFAp8038882;
	Mon, 3 Feb 2025 19:47:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e6tm9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 19:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olFIfri2a3/hGDStOA0tQi6jCLj1DlqJ8aquJbDHUtlCHM3w5gJa6niLQul044NvwQYpIFG6HStd2KVSyJ0XMWihnFtxl0Vb7+J9WZ0knZOFYmY9YAKql57off7w8ZI6xqjmieqLfcGigQepxdKQEngAlewiCOerfUGUmlsVYSRlgkDTWhCVXlBE+tj5McF28kIE4CSAKysYJiZ0DKoMkH1cxPQcyCkNZgwj0z6W7ssTNLb+I3syiXy9z0qvalPk4GSrdPLWI+xEgHp6RKQU/4magam6/HYDmnnmgsNYkZfZkVyyIrDCi2haBARjvNjHx3jFrqKXspCgD05OtCaORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfE/cXn+blAyYE14FNa1qwXml3Zodx/vn3/onxfRZuc=;
 b=ipNqPW1KomuMUyQr3d2JP7/bek6fyhi22ExEHkPTZ+BhfXxiIv2KjZheoXUXYSMoCi0UU1mS49NAH+r2XBNbNXHMHU9PGX1MmT6z0fQLX0rRSbRCf5uCrW06zDfTjuZ0/hHr/35SC8x+ZUSdUfbjAgBg5OlEbf2gKvsO8clLvzuB1NTIdPIEAxmRDzCLOVOhCqC5RJWz/cVqvW2sattMgHVrBRXiU0CfscvCnDusLH3EmeOwQIryVPsuX/cN8KrO4DS2TosT6f6gT2CEfWSGdICnwanELnrb4mOj/dukpwL6EYzVqDDhbj3xMMpFd6TOCALK51hJ60lTq8HAbvFOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfE/cXn+blAyYE14FNa1qwXml3Zodx/vn3/onxfRZuc=;
 b=xkMBBJG0e9KFFfV/bcRaKoNDWScq37mvRFncoU1H4MMhZ6V4IELsD12kHJViPNDGIyOZOsnFKaERgkF9CwF0aHxf+TkuCWdZJAYZybag/xthnuphuvR3c+z7SryZeC3krJLP7K1JvnrSdQVQxu4ofXCWHi5Hngp0IG4DXXnr7XM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 19:47:31 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 19:47:31 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Goldwyn
 Rodrigues <rgoldwyn@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: support integrity generation and
 verification from file systems
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250203094322.1809766-2-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 3 Feb 2025 10:43:05 +0100")
Organization: Oracle Corporation
Message-ID: <yq1jza6izet.fsf@ca-mkp.ca.oracle.com>
References: <20250203094322.1809766-1-hch@lst.de>
	<20250203094322.1809766-2-hch@lst.de>
Date: Mon, 03 Feb 2025 14:47:28 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: dba4d26d-8fb1-42aa-afe9-08dd448b98cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OPuDm4pD5EyA9ajoHEwsTf2+I7OazyNCULnbl5g2aQDK/jm5KY+DjirF7sc8?=
 =?us-ascii?Q?YQwD3mos2/IBlPaKp1ZNHVFBE8Hy0xVBxunLB0YjgSa1M75kw/5hxAq41ZCf?=
 =?us-ascii?Q?nKmZzt6yjS9ieaESGb/77gJVDo1SWaO9S7IlcBHjT8NjyPX1vJdijMtEi+b5?=
 =?us-ascii?Q?MvhDad5zmkFzzU+pb/Ctsu520f6onM5VriayVv68rNRpIJVupvYRoEyIl6PB?=
 =?us-ascii?Q?mBlyy/mVtmYmr5j1+WKtcVw1VQeZZZJcdXDkabKhZ17x/bO97eL+i4frnR3d?=
 =?us-ascii?Q?yiAYjQ8Yw+DRwTaA8nEB1DrJ6U6h72WP4T1wMMZk5/GAeoz/hr/Omjwevisa?=
 =?us-ascii?Q?zG/4hoBp3Ii4kgW1dTk3Goa2nn8u9awW1dpZ5QNcLMY2LIijlSLTq3Ix8DG0?=
 =?us-ascii?Q?ukxdvc0TNmdqEWq+xzmdbDP7PuiiY78Vp9rhHQ1siVT/lo/oto3JLr7W0vGA?=
 =?us-ascii?Q?c1bUD6uFdoW0zvkbgHLVEq2PsVyhIJz11H4IOfEJ2ZyOEuOY6a8wxZKKbyps?=
 =?us-ascii?Q?NpYguQPAfE5ILLyThJtkA/FsG0Uv2zFvHmXSMirLqeeLzdxdB5V1VXKyeFHu?=
 =?us-ascii?Q?LD/+WyqxoYVPoVpYPGnZtPxjPFqh8hEwm/3Y2kDgDMvRzjsro+ChYgQov9DT?=
 =?us-ascii?Q?UtXbb8j5EUBKnQwiRpr1dUU/dCVKxMkpZ2Jhdcz2BNl1AhgzqgKLhtybk+iF?=
 =?us-ascii?Q?vyPVrB06KyFAkKxoUzi6CEiorJNDi8ppiN5H9NzpWtJgr1eylSf6vxpv8nIO?=
 =?us-ascii?Q?MYOm2thwGvGSv4PNjK2GvpggqjoYiV61Vqm1uZFj8GIq4pNXTSCYgY0KwI2o?=
 =?us-ascii?Q?iViXF+rseDdTDFe7mVcjyVunNt+p/2+/adU+iyKyRkd97ZkzXvNE8hTBhBFA?=
 =?us-ascii?Q?Mc75kwG9YFIPIM46585vTYeobGwZyTZzc5qPd3PjefO8YiDgtYTnaJm+Bc6K?=
 =?us-ascii?Q?1+ZPNLl5lhaRCrnQSndMl5jE4KFEplSBjKGOJnG9eCtfrL4J1u4F6UMKaX5P?=
 =?us-ascii?Q?1MtnU9MvSTinZTme+SUHXO33jaUJITvWp5A9JJE9lkOoj68+wXcwpEog2Zf3?=
 =?us-ascii?Q?jDy/w0yHV+yASo5nAavlUjy53+IpZ9S8+QxOiTVcxO8ApWnc/pMUOjkVyF9N?=
 =?us-ascii?Q?B5OG5C0Dt2NkPJQPoqKP9YUFKxS3n8HOyQh6gdEaTj+Lo+TNvQqufbGDZjnL?=
 =?us-ascii?Q?zC1vb0PsrJuljqTxV/+SHizW8mp8/DEJRZ6KQhv0XcA8clVqdGi2C0B/3zI/?=
 =?us-ascii?Q?EREcsBF343g19GXaIzht0QGGM1p3eaaYInFePXTUbWsAF5un+6LYtiL4Fjny?=
 =?us-ascii?Q?Ejb+M5wwnGaQGyYxzsfdGdcdBrI6c8iJ7vGVg3T9DrGRwO8og2dxjOnl5PKD?=
 =?us-ascii?Q?cGFJ1/tx0eYy6dTKaACtgj9ELrOK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MVRpb1BCVQRaixTdATcAd6+1VQvZ0x0ubvwkCMlijylIUjGgcc/OvCfVT+dQ?=
 =?us-ascii?Q?tYUyWcQ7MpvzIirBJNXp32dhu1vSRYT1Z9Xziye6CcfjvcJyJ5l5xB9XDSJR?=
 =?us-ascii?Q?zNmbDuocHuLWjmYxe1CAm1oCFb48Ri4wf5KRE5DA0325Im7cAb8qkoJxUEmH?=
 =?us-ascii?Q?sS1Nab3mObIQPXIjR74AiKkASZ3NGSE4xcOG+XOBjgvV1pPL7Qcmi5AsGXTy?=
 =?us-ascii?Q?fIFnjXtQRFRBHx/DGblgKwpL+pXPt3hgAeqJadwi0OspgGoC26naNC5P1hc2?=
 =?us-ascii?Q?km+iw7LMjgtpMfhABI0KPxrh2ta2mhJI+MJyocjtUZyq7XnkcO69rzKSmk65?=
 =?us-ascii?Q?tMWY47cDS4sKBa4x2UlVEHO9IDGOt+o1O52MS0uzZ1l5Lj7COm1ZOlD6ABoG?=
 =?us-ascii?Q?TkZQnUGKQHOxHgbZnB+f+7PLU08u3B4ZCuPYuWgqYHigLF/yrv1uD90qfur+?=
 =?us-ascii?Q?4VXrK7I7PIIGuFbSSS2BAWcEMbrk9JplfAJjsJwHLKl3xNnREiabPR1Pnd8w?=
 =?us-ascii?Q?FssSaARdrx4U3KoOrgcG3hgk4m5dz4HYNtuLbOJdut/9xC1GyEbqnzrYa5kq?=
 =?us-ascii?Q?MeeI5YQhytET562CgyUohIN8S1rfkEbUGIav8cSfSX2wfhAtVXdwk98NjLBh?=
 =?us-ascii?Q?WtvBDwDsEh01MTrLQw6rnyFpfj5Pwcr9zFIyanCzWsu6IWiShoxipAxXTp8R?=
 =?us-ascii?Q?9lGp4QjW10TwJ1AWMwiXrHiW7+ToWBFSVvidC9gTWevgcsqCGFobo3HfIyd4?=
 =?us-ascii?Q?vsS3eI7opJaKxrrI4NDpOt2bt+nYoxFZoCdhzHCQMzQLJTcDQKuHiekKKZxz?=
 =?us-ascii?Q?wV/KyroxpjLE1Acnu2IHl9wSr1RD8dKoLwT3cld2yBeggvl0HhQnkE6S8AjY?=
 =?us-ascii?Q?n4mLZeh10LN7qRrA+IK6yw7ou3NUplbF8HO3M6gPutoViurrDDyWktGGWYfW?=
 =?us-ascii?Q?LT8QdonL+SKhp9wwq5kZM65oK3cn0gjO2iCDYBIsDyoClQNKcJ7UPdCypOIC?=
 =?us-ascii?Q?oWA8/7iGA1+T4HVvt0IBuZXGcIEbpUm6RrIjOSHtiqGJmMZvgtQDBz83nglq?=
 =?us-ascii?Q?SZWtrtqyigF/zEaHzo5Yt2PG48g2NRZuGcusSJ3WsEBTFNzA537/E8lHA1as?=
 =?us-ascii?Q?xhnpbIlkQCLzuQeAhcRGScFzs7Br1YgRb7Qjj9Ez5/CE0kTIpvls3IqIHrg5?=
 =?us-ascii?Q?pKbMQY65p6huGFytiRzSIb0gMM0Elkj8COZHQKLn4rEWNE8BDEW9E2tEyun2?=
 =?us-ascii?Q?wNDqEErzuZacUHoMu0IKe0++ohPgEvWxesF4vhfO+xXFRRZ20GixCmIN1EP7?=
 =?us-ascii?Q?66fHMvSaYlqOJQRSqihRmiSRgFGwy45dHgWjgYuXdhMYG+GPtoZt/BZVbzu3?=
 =?us-ascii?Q?kP8I1/SzU1tMUw9NZWikWB2v2hUbAsQvL2A3Mvj3RvApAJQ1CWmE+kH9xpn1?=
 =?us-ascii?Q?yFoTTC+/TTCXkBXj60n5DsQGripX/MajDsTcqJpINhGyZ/2iAmWPtSxetR2M?=
 =?us-ascii?Q?DeI8FjWVt4n158hRC9BbydZxjz78zJ23OdWYuPJgDPUZ6C90G43Ai69Sz2wl?=
 =?us-ascii?Q?/T8rP34hkci1q+wVKEwqGQ9dLiVzFTgtfp5kIjeydkWJwk/fFUHDzl5SvzkR?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VbiXb3D14QSETqAGF6UWmGY85VdBzeaHFvO/sB8CK3Ft9qNJ+LcQzVi50VMXTONtSjAMIrUtprLwtvHLifw+LF8kjB1gRxAp0DMkDodFxG8Q93OB/cUA9xqIFD6AiK35Z+R6bKTXOm6D/C2i5MMLqccuNkL636Ra7ZogCS5XzhMWFuT6nLum0z4r86xm3YNGrOif3G3dU3OZb8vIpQsc4ZhA90kOgT+hTGepQYUnIm4hIMHo9yuh45goRsYtzon1uswJ39fsadwNMAiIbYR3iuyO7b2s8bcejSIGvx/dnuoZ9BBnosTw5M5xwcDXCd8FktAxXlRSdIaPNZVnH2/mkLc+fI8SX7VENfk4Yn8rW7ulMeFyZQyo8gf4od3rZJzzXymYz/s9noTn5CPPMptZNIra8jgrgeRS+jlopdfGuJ3Y73q8J9hX/HJRS2l79PlKeg+35yaHxFB6/90Ml4fBbQTVHYVHWWZKjoo1eKkCAAMVE8tOIcV2rscaH73Rc1g6VwhWoDoYK5XKRKfvD6+/3crnulVPlJ1M7Tz+xn5T9VzO+QwPkFDD9e07UaXHds7gaV0djmj1XTs0JzPwLLrGzZ+x1qkAc1WZw3sZQN6+PjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba4d26d-8fb1-42aa-afe9-08dd448b98cd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 19:47:31.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iz2sVyizohUJxHPZtnL3IKnX2FevWtAq1Y4JunrmJGG+XjSQpvF0TtZOJg3XuqyhyKzHUiYLsh1Y/nOVSvVOTZCR6KWwCyYpM5QHJHusjXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=876
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502030143
X-Proofpoint-ORIG-GUID: IsRpxFz0aNt7SkSABgK0Cpl7SLLbhgZe
X-Proofpoint-GUID: IsRpxFz0aNt7SkSABgK0Cpl7SLLbhgZe


Christoph,

> Add a new blk_integrity_verify_all helper that uses the _all iterator
> to verify the entire bio as built by the file system and doesn't
> require the extra bvec_iter used by blk_integrity_verify_iter and
> export blk_integrity_generate which can be used as-is.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

