Return-Path: <linux-fsdevel+bounces-40735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE3A270CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92613163575
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10F20E32F;
	Tue,  4 Feb 2025 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YbyiXrD5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e5x5VSFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753E20D50A;
	Tue,  4 Feb 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670534; cv=fail; b=QZZ8pr504z+i/F+tvHZB473d2I4fM1OCnPOyYfJ6csOdXJ0P+5tFOBgh3mFHga4Lrc7XKfC+7KYu93rw9FNf9WQkQfPElA8nwHSKfyXed/wGr1T1ilFXXWOyJSd+euDGJZw0iZ3GxMRRAUM72+aIJDYfvz6nbGq2snuK58CZnNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670534; c=relaxed/simple;
	bh=MU2xEhHV9A3cFB1yt2MDDEL6ZPjAJH7JSnkvfFdCf1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTTViWlHeNBP7DzykP/S2g+ZyfWB1T30MwYB5+tzcA3vchiYkE1tWZCXm1g7DEzkjpW3X/S9cktPkwcz+dPhVUH6cwh3VpEaFJ9mqHK1fo/LkGPWaN3s3nEsBL+sQUkcoQDPmS4VEQhyXBkuH+D9btqWZpPMiHnXSI0S/EcwvRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YbyiXrD5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e5x5VSFD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfSqx025925;
	Tue, 4 Feb 2025 12:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XPlYHT7J2YZfOffa3m+njCURYb+S1SVKkBp0tJ7n0EI=; b=
	YbyiXrD5oQWFZyJbtDVzaGQZK3L4jiK5zZ0gE/k7XLQwb7mDIWoJsa4QJhP9Sliz
	FqHZsyZR0f7j37WEzgUSj7Fhw30y4E3EcLmHHW/uLl4isQoj+HOnMh2DaKCFJjjn
	m6wwb3ByxekGVYIAJk09B3/bvHgoLRZzsSNN2Ec5qbSQzk+5fiUo00lGeEVZbkTE
	dpBpJRmvqy2Qqs7Jyn1DeZBqBBVjcjd/hxavzSvZsq/30uYy1sHKzrcx4ateCNJJ
	ucY8Z1pOnJwKhV8BVrrf0gA8jJmnVzPmsg6HqTZk9sfnHAnHw58e2T/Q0wwyvcEC
	CeoPnOuxaTRE5Mz4DCahHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtvkvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514BA7w9036476;
	Tue, 4 Feb 2025 12:01:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fm3ygr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mS7b55yL/qpPgDauFYAJDGFP5MNemwrLM2kWMJRpnjdfdYC9ZCGYFu6LClWLldz0b5WcndwfMOBKPgFTV30oBCPHMqX682/AF1lHBnr/bAkV17+KN0GfDAaZjkkdfx1c3JM3CIoAlpFpZVpKgEwHo+SUkTufSuLtlys4ogFO6SeZiUtjf5ZrjVU4A6VbDQP12/vCAQpVLZy2Ae6VHxp1223wjWecczk/iHAjJ6Sk42KMNXr1PrqJjt0LZfy28uq23usd4+I2NeFdq6VRF24/+xuluTRNHqwwWV3c2guSRJEpZeIPuVVq4G8DoFiHfaT+5y0qfPxxlkaLqwPTPRejcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPlYHT7J2YZfOffa3m+njCURYb+S1SVKkBp0tJ7n0EI=;
 b=uZF5B2vTXCSIYmNMcqKTqVizmlUVlkGTXY71U+kke2nRtlebLRvlWb55Q3YZIUvpm6QfpB75RiGb7IqgxVU/sIC42mJnr5aV6cKDIIlykAGHC/rPv/4LQWblIYU+mPn9BDxOda/AXkTdZia8bDsZqvLNTlArT9bDCd7ZhzJp7rSGkXi0RMdUMvEthNDuXGBS38hANkCuIzb9q9rncEVqXozydjKZ96lT3LHoxDMZwXwRpAfI8xJhzxaMdYXHz/OUCIMBFG75YGvFsz32mtrhzkdD+jnK4ed8CTCBjvwPxttJC55gTAgBtF5168J1dKcHhHDVeXmAlgWOpY5Ow12jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPlYHT7J2YZfOffa3m+njCURYb+S1SVKkBp0tJ7n0EI=;
 b=e5x5VSFDb5w+srTMnyCl5f8rfhnNR124ai+26AP12jFZul5vBTRpaedYNvaeuq4W4z2ynHMJo4L/6OsLvphsQbOFgGQvnCVLUKHBzPxTlpSOKX8jEF3I08giM+p/77+Ee1cLdZhn4WuO28PLm13Tbu0BaIceCD08OtySw+J48VM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 04/10] xfs: Make xfs_find_trim_cow_extent() public
Date: Tue,  4 Feb 2025 12:01:21 +0000
Message-Id: <20250204120127.2396727-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c862af9-fb0c-43fd-67e7-08dd4513b384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8gZjqDhT7I4Fq+7Jy55fVnWnkSB2/3+GvWEXZizHWuZXZsJme9q6KjJF1Psw?=
 =?us-ascii?Q?k0xzOmvLsFguC8MtiX3r4xqeTLqe7ItNeT+VeOMid+Qc2U9qfsFw090mcBfP?=
 =?us-ascii?Q?yHg3c/32Peyb1HDbnJwFyJSMSpb9LdhUynnXW+tgkEmRFW5rgjTdWlgAR1Do?=
 =?us-ascii?Q?+68BPLFkowcxSQwHHd+o3A0MVlwJX7uC7ToICxPNltDFNsW5cDm2CaIgQyJ2?=
 =?us-ascii?Q?g3t6xIT1fWUurqyOXVIIhsBHv5WF0Xj/zY0jwU6Bq53O6JK5gKxBd8y7TWpv?=
 =?us-ascii?Q?dzwBZRj/Yzwa3bnwckczwnwkUmGB9kuanUSpCgMTGFaw3wS/UgjptXAqKwDB?=
 =?us-ascii?Q?VnxFInP3nfhBGoIvyVgFuPauSqi+Kk9czu+3ThyTGc98H9e9gK1Us8zv8hEW?=
 =?us-ascii?Q?88C3ecyIRay6kiiRlmbZv4KpyzLrEqJty9eYTotRQtzjhb15VZiUe1EipsbW?=
 =?us-ascii?Q?vVOYJ8luR/qO73B+WQujKM7h1QllZsXT65y/EGkDMF/7ZBJUksu5iSUX7+Cy?=
 =?us-ascii?Q?paX+G/cghmFWL/AZ4b/St7y+wn4XmsgpDXNeg8z4kcmhKIsEaaqbH+tsNn67?=
 =?us-ascii?Q?l7F7s2/7UodntfcBMn0y8KsWWonV2UnPKx9D/eRxLLXQK6HJZgkv1fpZrfru?=
 =?us-ascii?Q?cr9B3uiiErV/ZHIBNl7UqMeNvUzqYeIWSz7nHnTx5n+8vyXrOpvFwZCX9Et3?=
 =?us-ascii?Q?aHQ2NnQp9Si0+lh+MzJ+R4kfPvsFJossPks9xoI02pjuh1KsmTFfR7gvh0gx?=
 =?us-ascii?Q?48EGl7ROGMhuln67/PhmA949A7mNBYTlyeG+lgDRWqzAIJvNFQCtkCLnNihC?=
 =?us-ascii?Q?gWjaPIVOZe18KJL9Q6ty5LIivPUouyFMcEQWCSIRP209Rn1dYVC5HLmk9AHA?=
 =?us-ascii?Q?2zHzy39fA0fGLMVx+YGAfrPwv3RnAQI2t3RorPRYSLDyy0Fbvt6D9QwRH0fN?=
 =?us-ascii?Q?jPxVloWHIRY4JZmphkeuDVnCofAEPB30FG2dYY2yLfZEPP77JU6OV6DnUDU9?=
 =?us-ascii?Q?cDbWH2wW3GdA2kbHwwkjZgzSyAwuUL5xiguQCCuLY1KpCO6LsAIG8NbGte9w?=
 =?us-ascii?Q?swfQDCGEm2sgWSBTZgh5wXP1dXRDCChWs6B720IhTnGI5MIJ1DSHc7ZDod9x?=
 =?us-ascii?Q?OnvCWxrLxcS6h3QvUs1cUL8N5COJIIb6asPt9vc7oHyFPn1k2tu+X/roMNvW?=
 =?us-ascii?Q?hRU6SHl9lhb9GASUaOKEE5CHyyCoTGt5zDrwmX9L/MYDkS9tS91h3CkRtb/j?=
 =?us-ascii?Q?R32UFpWqhEE/EuIwvfyapAx4ykG8i5qO+oweAGllI8k6rXT2MfdmmbEt16mu?=
 =?us-ascii?Q?IroIq1W+ttzQfyESPpYk+P1/9lOgUW7nq5btTEf0kUbYRjy7tXxDe2Y0f3BM?=
 =?us-ascii?Q?KHIMqAw5z3pXBYfRfqO2D7oatShu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2ZfWH01O+93uQu/p04g0zuPt9CG599B0yeCuinV8FqmPYWFA79GvzywDMHK?=
 =?us-ascii?Q?nI0gVsnd7sthggdhNNr511ptM3mp73ANCpA9G3tJUjH3oU8yzlnaAM/DHCIQ?=
 =?us-ascii?Q?tZLHX7rRJGdN/Us79Dhgjlr8kEDYJolEAKBPHAAuBfKWmpfV+Mkib2/M6w8X?=
 =?us-ascii?Q?6OA/vB42nwFlS6X25+xJd6eBQoL3Gwqj69reILxMjaULwtT3sQoSLFj3oxBe?=
 =?us-ascii?Q?zVGIAYpp95Qkqu7x93h7Wlwbzhxcl3LRAlNB2Rm3htSlL/O3lcbpHbyo9hB7?=
 =?us-ascii?Q?9cuv77huAFzDBukNr4JoUgCfTnz//6PyTO3jb/IpWUh7aJlzP7EVModLuWid?=
 =?us-ascii?Q?R15r7fYZfE4cMmvi6qJZFQICr58ZBuDBmj2ECjh0499EmwtvK9rSZQgG4xiM?=
 =?us-ascii?Q?bnOHMPIVfy+bnGvSP4+Tpy4x/8Iwcwi6G0SoOR8dUYLGXTumEBMZaRkkm8/8?=
 =?us-ascii?Q?EKYtAMRp0tOFWoNmehJ+hMLT2AUnEMHLfyGrsBfKrg3cTHPa6YvDjjXslqeS?=
 =?us-ascii?Q?SOyokmmdcpfY/ct/3lr/FJjf8zU4p3a5ccFtktMG17oOKhjmb++J+CapXvSd?=
 =?us-ascii?Q?KDjfiPMH1Z03KGYTFqKq5edus3aPOBPFNyDES4DpKGWANuBxAuHz/U+niMoz?=
 =?us-ascii?Q?0keAH/ALehOn+ethwaVWWzeM1xjN8r0j2qPRJXxIJgBFxyC34nXnc2ItLkOP?=
 =?us-ascii?Q?xP43LDQVyLP01yI8q0vP89ba5lxo+r+kgKySM2X68UbFjU057giMk+VTRdBe?=
 =?us-ascii?Q?v5SCJMTXkjQOh0Uh0CTS/5qDeqW/hUw7E8V+emky2c/lBaSfmkQ+kooQkSs0?=
 =?us-ascii?Q?7A5GQuO8NdHsp1HYDlIAtOt3/Fa6B5t+aEEMFlWEFjgtKFKWZ4lM3sXvQY40?=
 =?us-ascii?Q?pKJyM4hymtkQk3DYH6Ys1PtFxDfO9Us8LKk/N/pu2MHBKikLidX6t7lggiUQ?=
 =?us-ascii?Q?BuWcDkjhBNgnOiUQAK7795h/0slarDmaZ+PxNOhMhD6ZfZE/iZB++Rm76951?=
 =?us-ascii?Q?Ruid1ovCMIE5A67mwRDq2qCH8hbjijssg1tqixfjqezZnzbZJec5c3BmJbEa?=
 =?us-ascii?Q?hBavZu7pn/ieI0D0LkQqLCz6XKnJob8jrSbq13MLx6pflA39zmqEO07oepbH?=
 =?us-ascii?Q?xS5OukoZm/ZlvKxfYjNZItiLlbqn/Q7cn6K1/Ut1e7vhjK0Qt9Am8M/RMt22?=
 =?us-ascii?Q?UIgSMo1EzFf/pC1xMqnmizx3kcicyWhpiPPS+WxMqA3rMpYWgmi9naMZADK0?=
 =?us-ascii?Q?jtAclrUywFOB6FYk7U/O0KQmhIdVHSgsx4a7o1T72voOpF+xWyuFJ6EG9ah6?=
 =?us-ascii?Q?WkN0GJGiykUhi4IeKLMZxOpokAoZNwXCy/uQFi06cbhLSBqSvRne04HCEMhP?=
 =?us-ascii?Q?R7/pHz6WQ+vE4FA3ZFlMRMVAsoF+XlrL1HXn2KHdYfDp0z+/PKEiMvE0nxkA?=
 =?us-ascii?Q?XYOffjiYSV/kuGJB36Et76kgkPu7pCqAYW+TWU/WwOqnDaGadp3aCfAi/mka?=
 =?us-ascii?Q?Txv7vBvPcGa7V7AUlvj6J6cl6vn5qMz51VXZkB10/LovomvjIso8+Z5FZ+CP?=
 =?us-ascii?Q?fJWTOl8Y99rpuW1nGlIsmGNcM9j3ZDDhUItcWqdhBvHQrUm2fpoRGREesyBQ?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wRDao7dz1iKkH6h0+2FjBqLYZWdiDABTSmI6MJzKrUVShq3nrnb8y1bbNm305e60nfmWaj4KhPbB3tlGp7ZE89VaspXyy8VXv0VJs8fm2JRlNp2uNnYrvk4rI7sztiEbgXlOl8Jsj7raZkdBLZdT3MxXjSuHkxpWOjJjN8U8xB8I69wS15hySSjxEMiqHVND75Ivp948TYIRjfoWKK2uNXxOrfJiP6AoFDds31Qf6be4Eg9EZM8SCuJ4wh72RHxhd2a96sAItlp3kGmrAuQacckuqs4RJszPibJ7KupQJpN9BB5V+71oowYhVQjhIzq/hhANMPBWGm2/fD2h/vyGhu8Pe8/c7lMfQU4Alghz67LqCYj3ZhD00XWahjQWAuNq9OY6ILW3M/rmQwOsXc1pLLH14QLb173WVmw/z6N7nizgt8+h5+BclGHUv0t1T1bP0PJyaI4yeW9GUiHFoROLYtlKYiF4gtnEzcU0R8mSqXo6nVD6FD4Tm019/vqFuOXjyVwuC87CyzgueCQ+PT13zTwPNj7AbrJgrkLiY0bvHngT5ozMR5X0Bj6tXQQAXwdIxEXdiecTsv+MvGTNT7ECjAUJUr6dg1Cg/qmgTf3Ikrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c862af9-fb0c-43fd-67e7-08dd4513b384
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:47.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1X2q1KmhVv92RtUZrjs+8C1vQtfgKq3wWDec1kyi+Q9nJRwAzQciuhqI29kx8N+nKND5/rOJkTHoZhNhGjcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: bIapKt4stQvtbz8A9RRzmIvPxIYA7tsO
X-Proofpoint-ORIG-GUID: bIapKt4stQvtbz8A9RRzmIvPxIYA7tsO

This will be required for the iomap code to detect whether a range is
covered by a CoW extent.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 2 +-
 fs/xfs/xfs_reflink.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 580469668334..b28fb632b9e6 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -357,7 +357,7 @@ xfs_reflink_convert_cow(
  * is not shared we might have a preallocation for it in the COW fork. If so we
  * use it that rather than trigger a new allocation.
  */
-static int
+int
 xfs_find_trim_cow_extent(
 	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..a328b25e68da 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_find_trim_cow_extent(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
+	struct xfs_bmbt_irec *cmap, bool *shared, bool *found);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
-- 
2.31.1


