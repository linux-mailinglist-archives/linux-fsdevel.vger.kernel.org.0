Return-Path: <linux-fsdevel+bounces-41655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE6A34123
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3242189011E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE0274260;
	Thu, 13 Feb 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKOfS/jm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qax1h8Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491727129E;
	Thu, 13 Feb 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455052; cv=fail; b=ZQ0hTaEeedlLxTnSJYKOoMikmWmAcJ5cPxeMTleLizg7F/y7TS81zjbWfxDI52xm9yyrHv5sFrxpkOQVf7COtSCedvzPZiQhhu3Um1Mii2MMXSQ46qGzbNMBbKkgdVGChoG6RB4+Jca1HZP1fZHCp75aWiQewRgttGize5plnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455052; c=relaxed/simple;
	bh=b62au7gM/3UaNnpgBcSicz4+ph+erw0KtdH2QBYU0Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQCgQPhh0f6REGN1DvB7ax2BvG9JDUOtkXrhZCv6S3IRqDfnfryNKfOIJtO5ZPTSZtLJvgC75GLwobj52aJDlEweSpN6sRHdQQ4WlMMkuPG7boGFfQb6mlRmKYsVW/d35OuSIDKoRXGwB3m4Go6aWYNfs1GSAr64PwE1C0UV0W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKOfS/jm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qax1h8Uy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fgkm021994;
	Thu, 13 Feb 2025 13:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cbsfhwIoN6UOoNYU4jj0NZhQTrfD3MciMudVxKNxmUY=; b=
	TKOfS/jmxlbeUkCtHxwvAPwMqdQCZ2J0TuWQwGDrmQTphc6w2wyD2a+FmYx1bGuI
	cdEdjR6Hi5XiVTaRzhKHynLewLVbcu5UnUIrLkxCcIdbs0hFPam7UriNzu7PkqaC
	R8/ojTRa12/MhlGiIUDQgBpv/VpCMsZKJL0EEqTStQZ6Miocgkpq2V3jrMVXMQvX
	XJfM5MbQXCPR8Pt5nKMvlP0zlFM4HU6W5SPw5TzhFgi4v1IX6dQACtke/vZvjDl8
	/r0PT+TRQ8tuf7DZzWkGNreIPcQEaYMp3JF/9GKw/zXZ57pJupYxbxHmJ364a7K5
	ZgQbehSJ3/UxBdKyOOsvpA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t49jhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDWqmt009852;
	Thu, 13 Feb 2025 13:57:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj1u15-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7MyrRT9rvN6m84AmovLEj8E9ldQtQ5Nk/673+8C5zr/yy+8/qQgvx5z6HT27k4JL5O/QnbhxHUZJQ6SrAfQp/GzOiJvzUd3zISToYVyQBUTznITw1Sqj7lZvIeefxGL5iHw/o1Heuim57yCw47lowYmutFlpNAvYELctnOZ2ONdQhX41VoBrM6+Bn2sQiSFKo7n5J50zARUUqxxyu1OJgnfsm+y92k/dx634DvnxWSmyVkesvaoieb1F9zGHtbuTcz9+plGWKZ1ZypLX+Wwpeneg7SO1RnXlNjTqMu+3HyQEVJjfQh2HDvkj13h8oOAjOj/VhbfV91x8n2y7AzLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbsfhwIoN6UOoNYU4jj0NZhQTrfD3MciMudVxKNxmUY=;
 b=qyF/+Rwmn9UZ+p2NfnnvS2p68blIpcYq4Gt0RgplMGPbq7RuZxUq6s1frgdVvswA3V7vFD6ebvgdXeTDVKhPEDQjYVJE23nAb5Cp0eAM+wZ6Qgzkpz+rMuLQ9czoSpj2rG7YX8Bf5tRRTm/Mx4FB+AYAKbFqVXnWDsvylTrFhZJexVHMDxVRLewfmBAQALhPp4w81ZhtzYVfDPmsnU8Oh1eq7ks7UyFJfk0+OENPHdvgZZAcy0itWocoIdp9fMVjgecAPxueRTmPbdcxgkmqkGQboP31Roj9nET2MWNgNSQuUKMaKVkmbUdjgqIt+HUeGmtUL/QvBH4GsLV83XXrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbsfhwIoN6UOoNYU4jj0NZhQTrfD3MciMudVxKNxmUY=;
 b=qax1h8UyiwSPKYQxLjupOSahQCqeOFQE/bAeJApngFS/VwaePHH1mQ5ANM7JOLe3ZQrplEACANBwJ2cLPBtS0lfV5/g8dYO61wdLpJ3K52JlIpMoGjEQczX4rooILjC/bPB3Tff6I2KI4DPU73Sh2+JVvRrLNEZL1TKgU3sUeL4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 11/11] xfs: Allow block allocator to take an alignment hint
Date: Thu, 13 Feb 2025 13:56:19 +0000
Message-Id: <20250213135619.1148432-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3c28fa-16b8-479a-04ba-08dd4c3652c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkWQdFbtxcWY8ykNiMXkuIJY2jsjBj8YRglCLp1K6suan9V717aKsGZMtSYk?=
 =?us-ascii?Q?vVBuusgvTlUdlBUugwkFA+cjdcevyiE7EHrfM3jAFeteRIZT6OCeU37f9Mo7?=
 =?us-ascii?Q?tbh7qrqErQ8gehqB194oHvC63dXGN4D/M+60QbFKab6oc6tehgZ0pwY+5/7+?=
 =?us-ascii?Q?8wrsrFQL+73tVDqUeq5qYTZw5R7/ffKH6IZZQHDjuZ5sqZVcitUoNj6I3MZW?=
 =?us-ascii?Q?RlI294xouFw/IFIWi31R3r+gdkjNC4SvRpYeimEWmd7l6QFTHaLNovoq2iJI?=
 =?us-ascii?Q?vrtf+Yx7YIplkf3QcGf1rg0Wf8+wY/53aoPIVh6U1mu6GJjOIX8AT9raQbYK?=
 =?us-ascii?Q?3Kg9HMREXwfQN914sGFPc6J5bgGrrKpzEU0kVCUpMIzcamnZVxvjqVj7973s?=
 =?us-ascii?Q?zmkPcJKAfHT1Plj1kbjdEnP0ea4QMF5DtSjR1eHPElOjxnvQ8lwXZ8r+TjV9?=
 =?us-ascii?Q?AcqF+Piyb+0o9i87TOcZJKo8lwUj0MXr9TbT1mZ9gXW8YW3L2znJPajfPvHJ?=
 =?us-ascii?Q?TTfEBo330sPwn6tDSw/6o1V8KO0BOttRO1RUj/phBWFeFmc6iUT0WLf+7PQa?=
 =?us-ascii?Q?aaEXl56q+DDPTrU7Wi47M7fzUZ5GXFQeTH7vBSnW/PnZv9pUh07RRYao2NoP?=
 =?us-ascii?Q?px7u2ATcYLrP5nUVyoToORr1/VPhNDH+M8FiJ98vsm0lyar1HFKaaANxs0v3?=
 =?us-ascii?Q?zEG6e0BCdFZi0tLgLbarmJ8NOivG0ZhVIgL7Huc7ocTmCwn+vfkOfogji+wW?=
 =?us-ascii?Q?O0eEBnhTE25W2YQCa7HTSXzBI03KVdYa2QFOgWBq8XeqHeZcf3APvse/aeSP?=
 =?us-ascii?Q?ONCrztwMEOJdTRE+zd36qN4yw6a3aGslDgSC4pd2kBiL/KmhmNRrKlXjD7xO?=
 =?us-ascii?Q?1C7A6yul7yAU9XRJk5Nva047Q5hDV4x/Opv4Wdkh4nfx0ZFjEmCLKGVWciAi?=
 =?us-ascii?Q?vztCQwtuf8tNIhLEIJWwsCTo6qiPkI3mROIdKW42cq3ePGyVSTdFOawzSpG3?=
 =?us-ascii?Q?gXO9llCBb9UrPq6GYYCHabMHmQbFpy0/M5dr+fHjRAAj838LN5U4IiSjo9Y5?=
 =?us-ascii?Q?26SV6NF3vGVj++gIZYlfTRRJhIYMb2vEdMmjTHHVN/ebo5uaY01vJr9PExre?=
 =?us-ascii?Q?/mH4Ve5Qa/uqB9H5/slajjHU+CEfChXg3xbh2HA6vOXKsNtUVMQOQ3jCxe6x?=
 =?us-ascii?Q?boeVN4vJM4cegpwvcQcKU7QuFPF+JeW+nFYz+sUqZHLxxnY1Vv0BUhM7cPe9?=
 =?us-ascii?Q?Ppjz0XBHSclh+YHQuDcNnmkWxN4A2KlQMb1sS6hL6aEXcvWs1FsvacsUWGAq?=
 =?us-ascii?Q?8DQvqBxZN3/JRR283/DpDREtwRQyPa03iAamtQtTQFagjfjZ+csullpCEipx?=
 =?us-ascii?Q?3T7lCBe+cMZnQxzWKQGgXiC9dpvR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dyd9yWJMyIEN8/OJ/VY9u0OybM1Ie44XwKjH8/bIphdzsFlJbO8v9D1g9PDZ?=
 =?us-ascii?Q?nDuMTIuZS17UnLsy/3l/qAp7hNUrJOBnhD/UOsBd8XVzQ50IKHaSBtd+bubE?=
 =?us-ascii?Q?KYU04+GXwOjdJ7Pr4eYHf4NbrSZP0E2B/2MjtIzSQEyaar0w4eaRrGwq+QiW?=
 =?us-ascii?Q?zmkEWuBh+cMkPLmfWsjazMl9YDT4RRdU/X83eMMg/GL0neHApVno1IieCvEf?=
 =?us-ascii?Q?L/+JF8Aqhdf8M5ZzZ1XRt3mG+Tz89bLUzUhXlfATqIGJJAaHVr2brLdyMQkg?=
 =?us-ascii?Q?KX86pyURILBSUoY2KbbkaKSMab/d+bdQHd7QWCyUIajIg+Tl8+lbBjOYQMxr?=
 =?us-ascii?Q?glFr1HzzKXLmchzKVA40fk9CaEA+iddSluEm0cfh+HYxTItDkp5jjrWD/QuW?=
 =?us-ascii?Q?JJ1grU4EGrj+Zstj3c5a7Z3GHCQ9fVK6FZZRGOxZR4WQKECzI6I+rz0dXiWA?=
 =?us-ascii?Q?DdbayXt7BcNiARzQhnsahKHz7NnDa0ispOhnpTeyNkTiF2xfVcgQOYnjhyNc?=
 =?us-ascii?Q?DiNmu7aEZE2JfR2msCfJ53Nh6UCIjpb1/DceTDXwsAt5V7/KAVIiv3YwI1Xw?=
 =?us-ascii?Q?CDHziCVLSDkdJBxAUxN/iKguLuXu+CWXZ8IZ8zxq6H2IJxfV+kHRAXqdygKT?=
 =?us-ascii?Q?Y3oOfvZj7044bbxOSpxrNZydKAvDZzgSyBcsrk2IFV3bUY+QR8JrgLfUEoYX?=
 =?us-ascii?Q?ebNtqfc02PyDFiJglqgY0Mu7n5Z9vcoAgpsh2NODPZOSd/B8ZNaLIKYS8VfK?=
 =?us-ascii?Q?pheIhcCsALg0IUCkiclH1tj+YtpmxFg5tmF9Tu2simA7J+u5ga5kmSx5IpD0?=
 =?us-ascii?Q?5cuPgcqXEP98GED88ojv+tF8rJctcAonc/LkeVhKs5gxnTkHLXzSMDrzHTTe?=
 =?us-ascii?Q?aypO8jDpG9/c9wMn9FNFt/Mau63ewfA1aCrfOyGOEhuIuud6KR/VWCUSPcKM?=
 =?us-ascii?Q?n2EqMbikxlZFemwXOc7xc89vnRQBxph6yZyrcn1ljRswMJxX3MhBQ+7PBJSN?=
 =?us-ascii?Q?zauieMOExsSWIGaetmuZqX0FAsjuZCfEX4uuBM7npVUDrhhmae/+1UCuI5xy?=
 =?us-ascii?Q?rkMYMobI/oRtxctJzQe4eXMKXL6tO7oS990zwKXmyTgu2InUBchLd0txzu2x?=
 =?us-ascii?Q?66aBnl/AGcO4QdFhDrlv/U8IhBbABd3faW3EwxcXVV91k00hgFlzwaXFqfpt?=
 =?us-ascii?Q?C3ZL5VA4AJF1UpedeFuTTosEMbvSiWN66pdi+XLGNYOATYjFCl1YM4HsSFuf?=
 =?us-ascii?Q?RLphPxkCWQ36n73hp2/jXU/luKNz3GqlRrgLqaTElELZtZTNlZyDK7lsU1KI?=
 =?us-ascii?Q?iBHVOPJa1ZrM7RBw3sxhnjbBJrcuCirP4QeJCQshYaDwm6Nx3SMMorvbNAKm?=
 =?us-ascii?Q?c0t1/K9EJ83tndIVqQF7pR2ILvaiUQTzi6JnkIXtTo3qVoYwvaUmZZJNInYt?=
 =?us-ascii?Q?2Kv2jqM90Kt/yxPWmFhFaG1dUlfR3Bier6qCW7/5tOjF9r/8gQa/E6er4eYn?=
 =?us-ascii?Q?Q9OZxMacFu2FhjkzC9MvXNJsrV3xJqEk0bsX0YbMBM0jVzuhBwdHKIX5mDor?=
 =?us-ascii?Q?n4OKv/NamWUIVJc06LKJCo/F29J4zb2bLNSRfW2QN0QraZshKN9cyC1DJrjl?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AIJCZ0lVLbSi+yvmuMCn5dgxEHvXUIPYkAkG+ag7E7rk98c9rZf/6zotQQJHAV9n0yuqYlvjEOs6AopWQsP0ChgzoGMi1aOVh2INyvTODFW+s5R6ZKUqtaJMTM+HY2xdTsa1Ni/QxbggR7FjOq8dYjqIhg6UDPfL4DP3rCyMDEXoJtPl8nblxiejXHgEKh5+eXGQdxq9pr9DvDqePYDAxMCROwyAexTYDyRZSfD7L67vpnUN8J8JkIr+whkT5Ds/iouxl1utH+WwyecUDXI0GrledxUrELgLGqr4MhGFSxuzU8DXakGCIS+shwTEDyPCPaKHKnVzb/6YSk24fxSkjm/17sf73OncMieqd0nOUPSk55P3v6x5xpBQAsNAzo9A6JPBNnrhNcKlGZkmlOXhANzL8MEIl8DFpzidkFSsz8KsJwKWUzJlgi/CPCjtAdHnGH2sK//z+cf/B75KGPcUXsKim4wZTnilVN5kpbW76neKvx0rPnzi/HCfqcs7AEu3dtYO2RK/h58tqR8C6ghQqZ5Ytkcn6uA57Pp09jVj29LfQbbK/R3AGzFt1m5EFYvslE5LuHVNniAF4QIomaNR8aqlfVOIbgz9aRAxIt36sIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3c28fa-16b8-479a-04ba-08dd4c3652c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:15.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4MnshxYdKTOOG49jpyJtADNXGOonXhwn0ou2vjeDaBrsbdrW31ffPlb8Qj7DPH1x8NuvSOXqhiFEBHQ9GGa9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-ORIG-GUID: WAKu-5YCBrqDA02RuL9WuRue2RVy9PwU
X-Proofpoint-GUID: WAKu-5YCBrqDA02RuL9WuRue2RVy9PwU

When issuing an atomic write by the CoW method, give the block allocator a
hint to naturally align the data blocks.

This means that we have a better chance to issuing the atomic write via
HW offload next time.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 fs/xfs/xfs_reflink.c     | 8 ++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0ef19f1469ec..9bfdfb7cdcae 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
+		args->alignment = align;
+	else
+		args->alignment = 1;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 4b721d935994..7a31697331dc 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to naturally align allocations to extsz hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index d097d33dc000..033dff86ecf0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					      XFS_BMAPI_PREALLOC;
+
+	if (atomic)
+		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
-- 
2.31.1


