Return-Path: <linux-fsdevel+bounces-22098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D5912196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A792823AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527D173328;
	Fri, 21 Jun 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mo7hpwXk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1W4b5ZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FA171088;
	Fri, 21 Jun 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964388; cv=fail; b=Wy2WN6AwnJgLQGc7Dgaonooa412doEoQkVRbADzDvX65OUCOR1QvvM42vpoK3WHbAYkAjJiJesewqQ6aBR0zyG+GNx/kMpoq7/SFwvyhKHN71toa/b8V8ltV7VR9OYnoVLivXRdKxpeEa91qv/y4MBHw0VhegTnIAWWK/NcCWDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964388; c=relaxed/simple;
	bh=82sCfoAC9WuDwuln9hyQwoNqg9KDv1En2/tPws82uyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzZUO6JkHoozFtW3lSL3QfmM3kAzC77Chbxqkk5GLoRo7XIrEmS7GauRyMjmk1UIFiw5iEZillovW3hd8Xj6Uk9yU4t3UTv5QJQdojxjfdxiL4VWSI6SOiL3iBmEQ3rdjiABeuu5cFmHfm7LPbNJJTYfWbVd2KdkhoV6I77lAso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mo7hpwXk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1W4b5ZY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fUIP032220;
	Fri, 21 Jun 2024 10:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=mvli9j185b4V2Z0WWHE92YaBw0w/4HtqhHzK1B/PIDI=; b=
	mo7hpwXkrhnrGeAJUExOnIHFg4+T+wJ/O8Pby2JoKDLbukDK8la3q72gSvknQbWN
	RRG7j9rUwQL5W5r/ETOo0XbPMPbqa04gVc2+cYde3WpQQYS86qbe9WokSwpM0Cp7
	kr1cPbHLTm8K7+OSX0qCEGeQqGvv5/PjAc8jfe/L+jOiggJoUBtWgDgLoaWpU+0G
	em5IgnYjhg/B/b6+5jDm+u132iPVmbvIbDU4UqQCDu1x1ZOlAP/1+f01TDCzUwyi
	sLpdgFazHwNG26K6l2CHaF2Ak2gvUWLN6PmbcCZFtKEa1HEUBXFjAGaWITPifMTk
	v/p2Qqn1s9DMi8DoFAAXXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkj1fcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L95UNX019490;
	Fri, 21 Jun 2024 10:06:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn3mxyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6yoniaeoPcQzhExG6fFGVAA8AurBie0mtFsaCB5XiDnhBIDDN2IbkwTUZ2Aar91Rlyq9i6ndW31ktg53eYtRd+DWdWbMejgJujDipHIkPG6aq/fryPTcN1f4OJAf+t2RAQL5ohNZxopGU1guBbKqYErWPbt4nrZboRBSFkLncg6X/HqCXNLFYBhu99W2hUZhPI4/i6fPRHvKsm/abRCmfZx6XhJg/rZTCJsudBpCPeU+bmrv/IbtAkuh6NqlN8l1C2p+0PzOj3iJeDw8uG70gqN82/CsCAlaHduugvGFml2btvaqN0qOfVIxE6jUJHONsdFxzVTcSanx0L9XJehCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvli9j185b4V2Z0WWHE92YaBw0w/4HtqhHzK1B/PIDI=;
 b=Tte7NQ+R1BRTD+FazYmAioJVcf4Oc/APsZP+C2eUwjzPloaz/Mz6JU5leDb3rJetrMgGbnmLRREYTdXOkF8JomGVsUz3xmtGoDJfGespSAD/diu7OaXk6kWtMvfDijPoILs9fdDlA298d9ONVBVbhmVQj8/zhiy5khzwSALbhayWEyEVJNy13Hl//c9EcHqOmyfdpROktg4Ps3Gj2HpGoA7l/ZOYqcOnWGXZBEhNDGWh5ZQlTfmAIBsTzNp55U6XFPzL0OZa7tgwCeq/qhWgw1+r9mSgZyTXNBPiUX/gotepvd+0ZCqFKRaaBSDPiWGVhS1HE72uxUFhKJaDLmB1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvli9j185b4V2Z0WWHE92YaBw0w/4HtqhHzK1B/PIDI=;
 b=Q1W4b5ZY0Eu9vfXmVgqgx+rXx9+UHeZPyNzyfTqexF2Ras5TvXamQJpv44fwuN2Z2ocQf6j0/h6uRYRdtfioH04D8SkFhNbueBtGvKqkAYDGD8ZPe2w6eZcMXjPiNvRRU0sYU/B+wY5XCtMlYfFzdILmvYY3NS10e+NpTmWAnAc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 09/13] xfs: Update xfs_inode_alloc_unitsize_fsb() for forcealign
Date: Fri, 21 Jun 2024 10:05:36 +0000
Message-Id: <20240621100540.2976618-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0003.prod.exchangelabs.com (2603:10b6:208:71::16)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc3ce65-a362-404d-36b5-08dc91d9c93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s7zs3pdK8qMzb0GBfcZH5qxh5QHWft6IT5jnlM6ONPHm6Zu4M176ccqXuunW?=
 =?us-ascii?Q?igdUd2li5llC30ieICIrcyYnEdnifTsXtMxPt2UekRmIf0XHRz0hKcol/vfn?=
 =?us-ascii?Q?tRhgXe8CHHOUpa5JOdlG/KvlQOhgOYLe4BgH7LUkxlrDK4vDV8eyALJwiCDP?=
 =?us-ascii?Q?m6J5EXWpYn1LyGZWl6nWoKKi+pRHbzFKk2n8LHM+VJWiOuJUYTY33TdfJLhC?=
 =?us-ascii?Q?Bg0GFPU9x2HlF6vUGiX/I2W4Ktq4+R8u9Q352aGEJMxv15x0zfZVHJTAlO27?=
 =?us-ascii?Q?LDuvyEq7S8YypYnf+p/iEfNir3Kf2MmGAONG1o1SvsHfK3hRzwudW4+IlHBL?=
 =?us-ascii?Q?1pdMoMC41V/uUVmZ015zxA8c3mqFOHSy8HhgUpGZt0Gxhmrs2OmIMn/zTFVd?=
 =?us-ascii?Q?b4osdlJ1zYC5GMVu/96Z2yQpW9OpWrfgExHzePj8egcMPF+u2eO1J8rQjB86?=
 =?us-ascii?Q?3zXMl1acvfIR+9RDWvSxK6rPLN0OctHVcngkIuHEUtE4w3WsR1M+PBErMJnV?=
 =?us-ascii?Q?65ts/mryKVcD8EFyLzG3sMal3knhbL12or/OL40w/aW1hUYvZqydyL71Uay3?=
 =?us-ascii?Q?IhtMp3sJ0mpkOorV/PbHTf/8bDdzmPTwogeBOQQNWKHTdAC3LIWATbBT229r?=
 =?us-ascii?Q?W86cBY0TpL+BuXld8NIm+/UHCDeaxju9enageWtrIVZmYuRf7/iZ2X8mjJtB?=
 =?us-ascii?Q?vpcKakiiGh58rje5nAsMkI3oV1//LvEf3FsyJCBriJJ6flP7IoFacvPDfVX9?=
 =?us-ascii?Q?v0Bg0RO6gPmELMdajxI/TgSGP1PpUyzB0qFNlwXNEfPOQVYEZm+i/Fqz4H5k?=
 =?us-ascii?Q?7XYS/nWjRcx0wu3yavXHoIpq/IXcfxrRRmIcK6ESny8G4WRXtEakUtI2JUiu?=
 =?us-ascii?Q?GOOSioLvvvl2RFnB2JLIGTRQjtu/FpkqIev7ekjrVCWPl6RO6r1l7IxPoXB8?=
 =?us-ascii?Q?a3dIz0EyWCUYRCqypH4OcEyKhpcBii33sPJTtVq00XbGqdYoBLEyJqcEW+lI?=
 =?us-ascii?Q?mmQnIP72R3wTuoRhfzfgKRKDl2O61c0IwFSsZXgUriNvz+1qXjgtNmGJAWcQ?=
 =?us-ascii?Q?PdBSoTOdXwSW+gkuSWihG5DSlEOkSw8Gv20foygSorbOHWbWE61Nnux9CRcY?=
 =?us-ascii?Q?IB84Jh3mNb4XEj6KaY4ViVVUtJN20UPsA4GGgektrYlj62R8FPgzMIbqLkfm?=
 =?us-ascii?Q?lr4f3oX/tEa2q5E+P6/6S2PIFEupv+QJSfyQaYAy86hcYUsfF+Lx4PolUaso?=
 =?us-ascii?Q?9NgfXAvuarZylv6yJuXkPHYUzg1bvuGE/bpamkWFgc1sGUSx+DSFOqzu6pCp?=
 =?us-ascii?Q?Ah0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H8eCnmhiJL8VvGvvprKhSA2m1z0htZid1lUuwFK6VmbiWPKNI7YiHWtsuAHH?=
 =?us-ascii?Q?Cwarvws04V5Tg+UWxrcuNdEg30s3ujLGZ3dDgOkPz39VuX8iXvCVyxXR1aDu?=
 =?us-ascii?Q?4TFWpTvt94aA21W6TDefKbs39ZDhMQDzpxj0kEE+kSWeV8SBDSM0tJN7Y25/?=
 =?us-ascii?Q?X0d6oiPUWZnHzQPIrzS8XnyBNHOCY187Z/rDqq06QgTnyemZnhPjRVOj/KZO?=
 =?us-ascii?Q?3G3QABqaXVPkSvuAe8qqkjZSxkLALk86WV1kQkwq9gqxTXqQW/taF8OMRJxC?=
 =?us-ascii?Q?6j5nwim3s3DAYpB4ki772MUfshUx6Aw8t7qxzXI+xjoRTJB117AlGQDMS4HF?=
 =?us-ascii?Q?u87eJKZRgL+wWlguU+UlainyBJTOI/V0aQrWacJV9Jx7jDJRJOPKBBgSRmkD?=
 =?us-ascii?Q?Yy0+4agAj9JWs7gK7ykAaPK9mrVuDjR4IzN6A91FdZF0rbe2q7oIWOp6X+q1?=
 =?us-ascii?Q?ffIt0RRMGiZCSLiTePEcEtLGutqW3LwCMVFTRfPXsKckycSmqhbi67Ax8U0E?=
 =?us-ascii?Q?b6igPzxmw614Wvg1A81lqS5rEuPQYdHn/VWowKO5spuzCdD4idIiMpf6Ug13?=
 =?us-ascii?Q?wMONvaVGVQhlt5OrqTAhfORHjp/oC24S03BlsrTFCtLZlr9TtuI7Ttn7uUo0?=
 =?us-ascii?Q?jU9v/aNn2/Vf5tQq2lGi0LKLz275S4V+A+ixW4R+UYmQO/HgWS0u4Ppm3o1K?=
 =?us-ascii?Q?1GGNLA22QnkqlzeoE804V/gGa2ExMzgPfPfKQnBTPDpeS8jd8uLKNN0thC48?=
 =?us-ascii?Q?LPKXaDDWuqb50RJL3iF98qEl7YEwMEao4q7FQZDvVzeL4pwaOhpQRKsjeI05?=
 =?us-ascii?Q?pQlZ6E/Yr4XjsugmIHM0mdyZVhXJ6JkWIKYQZR2HjlZPN4bN1r0juTW6OvQc?=
 =?us-ascii?Q?Zmgel/eGWb7ygl4cabvgTjEKX4rdMgVAi2RtNGHBaWkB1vzeVyat3LshfwRZ?=
 =?us-ascii?Q?KN9NvYluvpR86a7Jwigv9VGXB8r/D00KZPZpVVIlRPCZUv7n1QrC4sxGvP0U?=
 =?us-ascii?Q?hwyEI02SdQiCLHfZb6y641l6Psds/yCf6JNQoCDvcrN9q0IoQmTxviUE5Q8Z?=
 =?us-ascii?Q?XF0xa1bBNthPLayqRSHsJlV6ML2j/O/ryDf5Q+63/SGhjLFM52toOb1I1RSb?=
 =?us-ascii?Q?nn3upDyDaJoTxSjzqApjDibD1p868WH+HKBhW9h1mXbj48ksppbUNgkE0zrK?=
 =?us-ascii?Q?xK/sCGEBfPS9YAIZXabIrGTpmtPYs3BvAXEFgx0iuW8NT+SMPcey5LE0S99S?=
 =?us-ascii?Q?/IKcDRun1zElNGuUgH9tWQqQptstHq18nqN13ngERpHow11fHUoDoSqyn6XZ?=
 =?us-ascii?Q?Pi8rBRfUfe7PqMV8r90Hz577GkyV0m+rWt/vdTwJz8SOPYjnsXQEnDmPt+QS?=
 =?us-ascii?Q?6jQ8VoZoMoxIC1EuEiJUItT5lSZZU2SOgvcr4rO7iaMw2gff94o0seBRTt7m?=
 =?us-ascii?Q?BbKIcAkk3JdPs7FyfDjb9EKuD4Uob9XGT5ayaML9m5u5P+B+ILs+htiRC0T1?=
 =?us-ascii?Q?jn1xCPk6hfdHcQVwweO6p6LFW5vuJR4IzRthLdywuZzKVFER137dZnpxdecA?=
 =?us-ascii?Q?gN1S2LdYdT5L5JqBb2kdYEPoStE/N20L5exDabbxu8lEQ/Dj9oa2Igfa5w/z?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FV7XPeyB1/bQqDtbA1aqT9Jbm1Jnpu0GZWIiUXyvCWQsoaFemg50isnTf8XWNxK3XMtyHS9TLxao9mm59Dt6trAsmlDdrqQ07qo65M3V/wZ3BAuljItPMlS+2G/ophxefkZ/xXr25qSEI0Bvv7pq+2F6hPazi2Dg/u0rMR+x//wxhp4jVuszewmT0UllzIVWu+S3Pm3KEZq5XmZ68q2E3jjSbtZAlzYQRhsXEjhV4e0GhcuEnoIJk1Md83KJYoMb16dwGDxmwAMKQ08uLCJN3ZvmUOACLKAsEx1vOY4ZdQqlFSIrTmzz4YNcIbxefsPXjgjZ8mX2V3Ian2NgiZ5kvPc+37ESIpIXGIdKK6V70WAXZINMYRFbOlxtxNayKuey1my8sw1ELXcBUDFzw6S4RDU0lKdyav1Bw23OsL6VwK+hYhInEahE/2YjF+stBiJhDGCrN82fc8UMS9YMKnMCAXhyeSSrKwIYcyTDh0ts37Eb5Okymvy6xzU0I75N0N28FH0YNff5CvQ3SayBPFbTpdKI87dIsx97x3OaYWj5/i16iq4DAEsL3OUFlZmQuQZU4z8kS24IL550yBgWd+ueC/+E1WdwKzfazw2HrHISgyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc3ce65-a362-404d-36b5-08dc91d9c93a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:15.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1boG/sxX3z8s/xQdjRZc5sx+TyIZJfY7hPQhgW7zhRKHF6HIfXVKP8FoMx802c4MZx63iL4CHdz0TTPKoXCoKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210074
X-Proofpoint-GUID: k-mQ7PZ70UegpL4vuufCqLL30thwkl1n
X-Proofpoint-ORIG-GUID: k-mQ7PZ70UegpL4vuufCqLL30thwkl1n

For forcealign enabled, the allocation unit size is in ip->i_extsize, and
this must never be zero.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 994fb7e184d9..cd07b15478ac 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -4299,6 +4299,8 @@ xfs_inode_alloc_unitsize(
 {
 	unsigned int		blocks = 1;
 
+	if (xfs_inode_has_forcealign(ip))
+		return ip->i_extsize;
 	if (XFS_IS_REALTIME_INODE(ip))
 		blocks = ip->i_mount->m_sb.sb_rextsize;
 
-- 
2.31.1


