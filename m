Return-Path: <linux-fsdevel+bounces-46472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B1A89D81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A2A17F6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A622918DF;
	Tue, 15 Apr 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YO0FcbCa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="boGFqFEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866B29B76D;
	Tue, 15 Apr 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719308; cv=fail; b=VcBubyqWdiAGbKlLg03Kg52qqd2GiOz8s4KxRJp87ygwzXZCxfrkuie4rocuvyXk0PPNTkZw+mP680I7GfIqdqm6hSPYiLlWwjZQ/Aao6htdzC5vJKnMeTlsYOdvSjIetDw0fd8+Z7pYzGY71onHW27oOV3ThTsIAbxR8kwvD8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719308; c=relaxed/simple;
	bh=ZV/j3R1d4BHfD9BhkfVmzGXRF7EHcc+uLbR9PAi+240=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvJeMrz1+U+x8WDu+1qIaCoguxgnWYq+uyIYIMuD5+uNzwxdSOUcxi4dyr8c+5wbQA1mrYe2lG5kpcoQ55AzuRRgtTf5ZftqqQYRRgDFIQ96oYJUeioN8rELzUkUUeO9tttKRdbOc7NBEYSfV9SiQryKLVBsstZ00U1jhPN4/i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YO0FcbCa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=boGFqFEF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fplD021585;
	Tue, 15 Apr 2025 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=r+wLD7Nb0mVa+1yO+BQsTbXIxRs143At6oP00Kda+D0=; b=
	YO0FcbCacbWl7W/KWJcp22YbV7HKKH89HZdZX2k+ojiHTpg+ii3W/5aD1+h3q0Sv
	O3sUCXZojB9OgOA0TqH2+yDWnTK6mLugioOVuP14Gl3rMdYBcrMPYu82VAMgEppf
	QiQWCwHS3Nw7eP9LEwRa1QOmh0W7lbLKe1B614t6HD8zEPQLS4LXv1D6x/jqbRAh
	Nr25QF0TP/wybkUKnT1w8sg7/m10V1+6hc9azRW1K6ug6LmgSyeO1tnPDoJzqSdC
	OWoFk1RMgq//7rGzopg6eu/eg/YPqnmMuJTC+KRV9dnVblzBL8fNxr5yM2hXcGZh
	vQZm8JZuAOEhnXev1mKDxg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd1dsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAu9hg038859;
	Tue, 15 Apr 2025 12:14:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4r76wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcCGkPifDmCA4KdOEET1r37Y7W7rp9atNhQ4G7kdob5jQmOne52291Pmp8Aa3d1tE04f2IpV2A1Wczk7KTD7ZWU43Gk6gxeAgvCf2k4E7lrK02mvmdsu5hU6Z8XuSs30KJsMOJHHfIqPLmS1tFJnqw6+5Ezp/78lAErQuS3aJ5zNzxkM24eJ6BdS21uf7RIodmSgzaiqFe9Igkk7imibs9lw6cRp2LIalJq3PyFCUuIMyk8u66leuyvbpur/a4hK1QdsQSODLmggZVqoRfi/p/fQItuMr4bMDYXnfPWl7L27Ilk2BKARbwWteMmGAb8loYEd4NjlI7gLYF9vYi/Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+wLD7Nb0mVa+1yO+BQsTbXIxRs143At6oP00Kda+D0=;
 b=BuoPf6v0FIMu197ThtNScgogwRJFhiFKYDht+bNbkJpPfH1WEk4+hPIivI2/Jp4BKA6rHqaDnVwHVC7GTUnzRJiGR44Wfab84rYZMo2vnMq5Bg84T7Sg57cAnCVGEEgnJDkpdK+YCL9pCFa9+Dc6H8vO2bNvKxrOL0byUvyfOcp5eDgEUgvB0fvdUWSxxcuWOJGIgYX4lgncvcRQKLCXDtIAxm0RmbsqeekkBAsfi7Rg27oF1iw9KhdFr9QWWfFoHhvgmQdSLRf83gZ8pr+FBwgm9yCqZYiNeMA3klrxcUS/+vO4dOOIfz/QEqTIBgGWIhFnxUHHWIgax2kExFZANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+wLD7Nb0mVa+1yO+BQsTbXIxRs143At6oP00Kda+D0=;
 b=boGFqFEFeKPTdVILfAO1ihogdZ5poJs0AfaUhnj7hSsNnhXNPlnCj0SsZwD0jq4GG/zYmwIktSHLu7TyWROy33z8TpbuwnLyKoYMTkLFDbmrfCmauu5cAgmbIF8whgRawCMq9J8B5+k26jr81ym1IErn2DbW57pcGJW0xd0L9FA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 12:14:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 07/14] xfs: refine atomic write size check in xfs_file_write_iter()
Date: Tue, 15 Apr 2025 12:14:18 +0000
Message-Id: <20250415121425.4146847-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: aec1db15-d493-432f-7085-08dd7c171e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AorzA52uDRj+Vq1tDjgwa5fh/2PkYO7+2MM9G2tEWIUBxXVcxiL/SpsBrKL?=
 =?us-ascii?Q?2iKz1FsIAIgQQewY6jq/g8LZt8k3X7m7luvytBFQsqeMJtUbY0gZr9fDrYYM?=
 =?us-ascii?Q?lzDuCo3R5vI2BQJ37bSyfbJPOphzk8bNfTiTCM9HTy3WqQbuONjcTSZmrIUS?=
 =?us-ascii?Q?63Jr+CJchlRYPKSfy6SyZbK8UhWYLcSdDPHiAqok/Nkr5oYIqaTMFn/hMK9f?=
 =?us-ascii?Q?zT/IcLRu+AhL44rFLnle4jhjzv+qxyrAQwuNB+bJY9FoYE3wKGDxiwrU0Wd/?=
 =?us-ascii?Q?vZDywBy/M7YM/U0emAulEwxdhBfnBRHElYqTXzon59KepWaajsOv7IoZfZ+9?=
 =?us-ascii?Q?yZ85G34RlmOv/VbykMlzEngy7Nu+UfUt2ADV45n+GgEJjfINbB/XqDcy7ROu?=
 =?us-ascii?Q?sJWaDG/sKdNUeV72HTmGj0Nrdc40boyOOpQHQGfxQjsMSq9pU4XLuSaIpY9J?=
 =?us-ascii?Q?/38NkpnHcLMp9FkMThDqLRl0GGLlfvZVfto4rHCuIA+31D98yRq9METqrbsb?=
 =?us-ascii?Q?MG1AV3H7PqGL8uNZsIJeebfdv6rcqKf9pQzh/JX2eRm0CTGMz1E2Upn3ZLbr?=
 =?us-ascii?Q?PcvLavZT6t50byvCdzi2DVF5Jc9wxB8KJrZtckMFp0zSMyOS6rPY4Ht3R7ln?=
 =?us-ascii?Q?tcFuEfx5SJHnSzMzranJ42M/bGpZJWtAfzTh7OtubkICqGjceKlcaUVitmwb?=
 =?us-ascii?Q?kGC1+xGzBvYDcA+qFjQhk3xtLpwHOXPTl/UKnsy1uwapUs0CifrDw7KVB8f7?=
 =?us-ascii?Q?AmaWsOCb+4Hp211rd5YZRUQfqs2FRxEpV9z4+pGaL6rJyFbpysPkUC1TpcXz?=
 =?us-ascii?Q?Gln/y8xG0mtwg1YRJIo44TdL/uqFWM1hApeBdH3HCw9SyvGr4EXPiFQRxXIb?=
 =?us-ascii?Q?/9n5BvyCAw6bVGqtnZSzIGBMYnd9KTH054pVwIhXyLaMJQpMFuMnDpD/Ea19?=
 =?us-ascii?Q?2kKArZT5glBEArJJx2UlkMU+kNoplO+Ae2hrH9wWuneCjSsjTN76bwAay2Tp?=
 =?us-ascii?Q?DQLPKNKYcNUrh6voitO1vZwiEyHjXut5fzqYKS7708iHFMlygaLBloC037LZ?=
 =?us-ascii?Q?AiVRB9ZtF9JVW3wRLrLV7m/8YKgJm04Ig97KEQolVxFqGm5TpSefoP+/tOxA?=
 =?us-ascii?Q?RoQFUyZrYp7Hns9rpfQejbc+SfF66hWNtWjepY+oHuX0OoTV28wlnzccAxS2?=
 =?us-ascii?Q?rlFMpMdwkBiD/OGA2aUayaPu9F54lbo1Ly1A3bpglBMlLHC+4y4kPzkNG3cx?=
 =?us-ascii?Q?pf40YdrVL86Xb9aeQHUHFh03ImWTm7hALQHOUgxyRqoQjhZ5ftkyx0BpOZ5Z?=
 =?us-ascii?Q?fsjUWZvB0BNwsQu0cd2CmPpUFkuptYM8WFbB3WAOBFJZTEAEwZ3tg3Q1uEQH?=
 =?us-ascii?Q?76o7UrMiW2Wdbm6xXHT4OzSahkXqTkkApLomkUjJ9gdryBa3khUWuDjHZLFc?=
 =?us-ascii?Q?oRqLHjA+TTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhZFUF0ea2itIs54R/uJzd4iplIZrAiNXAHOD+lB0CcHfTUCTS74Ll1wRsLX?=
 =?us-ascii?Q?38XgxOmeglXo5OZ9Z1qvFJDPTBBy3jnA/tde/lAr6YXK6+NBHpYB4mYNf6zI?=
 =?us-ascii?Q?Yv3XSlgySCTeTaFwuMmXev2XU4rTt659spz9QTU5Q4wcGukzSVkw1JTAhGL4?=
 =?us-ascii?Q?iGgEM7fEg8EOkL+VJAMv0bfGBroZfuPQ1b98wXCAgDxdlQUS/rvJfkaTk8ie?=
 =?us-ascii?Q?LaNn/dzB1ncsguY9xfTjs3Qi7Mcs3ygD/ThCJaT1LRrmkEEhE1CXFnGWwvWn?=
 =?us-ascii?Q?CMfGiba7JgBWTimPWjtJR3mjbPY58X8Iz8I7RJu9sv6nnRDpW8+sAb/08mvu?=
 =?us-ascii?Q?2uHbv8we1L+1LkVJhIz6O+aNTVEy0FqCaM+/ZVoX0s2toGQ9oXTEwDBXbekN?=
 =?us-ascii?Q?HslEjnNTIcpaw7qv6aA/zx2LswKC9NfzoPCZkzLz5D3puaqvHDi35uAL+e5T?=
 =?us-ascii?Q?OtAmJRpRFEvLyiHQ/+zXgmMLh68DDwImjBmVeNojo5Eea9rMTjjlNJLxN2A0?=
 =?us-ascii?Q?XdMSoz2RHt4VhLpTCqDtPF8ucQ+IldUWUQaRyglu9lHytHxCOUwZJY8mkH70?=
 =?us-ascii?Q?p6JRYZjE7VBEOuudIBH/tz9bar3hSvaQW4NnNNjxN6lxXO6RAK88KYvLHlKm?=
 =?us-ascii?Q?DhMNaMIaYNoY0vFYeNxv1ibWh5zcY3y0RB/aeVvvAAxy4TKzRxO9butyuTSz?=
 =?us-ascii?Q?3P3r9QRmKRh4mKLOCkkFGQ2zj7nZTkH9Y1wQb0VouqilAmMjAx9IHwuZ8foL?=
 =?us-ascii?Q?tKzWHWL0VFpk8N+L3PBG489qAxy42AQeny/piTHeoZ6pPc1Z+FAaTuec6sBV?=
 =?us-ascii?Q?58IaFh0XhQTmotmLK2Z76uHagJlgmUNg10RFXhnM2gYCZY7qi3uCWOsJgAgA?=
 =?us-ascii?Q?AQ1xxSpPNPBrP41tAwboGd+Q53A27+FPHE9EUvyqChlZzOSl/jrSEpXuSwrg?=
 =?us-ascii?Q?IJyA06H2E+AhqpkjWIrHBSemSAzYSSkLsNq3G0fsVbEVcTbSmTW/GEbKjWpX?=
 =?us-ascii?Q?ridHnJhe6l4lEKeJoYf7xUU/gu+YDTZPlqhEzlvrJjZmCHQzvwSOXxk57M2f?=
 =?us-ascii?Q?DtJJ3lohtxPYpQ0O+v7ac4/VH/bjvQLzJ9AA8Ks6EIrrs+LWb2Hu161PzfHE?=
 =?us-ascii?Q?bP2zCxw2UaotMUgt8IkffuG2SipoPUgjNjZHTKG2Ljf/bf0+XN/HO2crkViO?=
 =?us-ascii?Q?akZSx4ApvWmlI26QgwKL85W7Ur6jabsLd1lE0+G4GHQ7Ro/R9xJNoLwzXUVW?=
 =?us-ascii?Q?H2Sz0DrG4twteHhLZ3TzX65LQ+HWBUG1ZMCe/cZsJ1oBT4R7LbkETfV05siL?=
 =?us-ascii?Q?b5aqi86CvIVfZCtYvBfimHA25G1kbAdhx/D2WdS14Afrtzs+BiRbT2wtH2XP?=
 =?us-ascii?Q?y5zljrMgJAQOB4YT+jHrQL3l1/HOUsUKOZAXfo1GmfdzgCFH+mLOt0KUHd3d?=
 =?us-ascii?Q?bcBm6K8a/2SRly3t+YF3Ts3ZTUAFLlnKv9XQjU1WRN3SzHs2CZG/09QW0wE4?=
 =?us-ascii?Q?uIj4f9vDbJ0yHTaNscCVM6aIs1UF4sAvVA0aazWOtjAEFA5NnqbGJ+6OVAvo?=
 =?us-ascii?Q?dpl2oOPRcEwrXhIuA47omejEEobkYRtVm375IvO0W54U2uz1cB9qLe9faAix?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ljCTlfIT21OmFGj7EwXa7N6eVND+kJzdDUIK/QgdxE9MUUz4YNdSUfRGLQ21tfjaCjoplgQj5emkISgCMiVPg5jtS6VmuJhe6hcE0+GjhZ3cWKcfRRKPYWOExfB+N6YpHEz1ZZOOvVcfVmtMrfMCoQQ0y0Rh8I8kevWodp+M+8UQxatOR1Ow0riJ6wvMtuBH4hhT0n4f8XHMEJJqAb/ID0z7ZYh97B+qB7EcLJrZ0yKAwAdykrJSGc1V+lgziqzneuv5jNOhFZsyM1y0uq3GGrf+mdYsSKTQ9VCLDg89iAlELnYkD1BykjLJk5+nZ6OvOtoWb1EYyI2FKMzOnK5HqPdfO8Gb5lnqQwMMSOG248kKdHDf0pbqBlhhAIFlNLyAqJYkIfUYxmksTkqy7N6cb/31PibzTeKysi/kx6uCaanOb0h2HqDNCWgZFQPDsE1aJJrA3CRxBqnM3HzIS6OclGTXabDWey7Z1tENox+eDojsLKbFRsc7pqzuupa8Z4RW1mx/E4/rc5pY28ofoERuMs8hOLoS1eq7KySyazpK6PJQBc1mPC/EaptWcphvmJHSyssCinf6WuGk/O6G5sGksOag+0DKclxEzyeBM3RaSgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec1db15-d493-432f-7085-08dd7c171e51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:49.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTsuiycBJYZkE5RAoqVRa2/pxW1aW91TKZRcnBXg/y055v/AwIaacHkGAJj0Y+ZFv6YTE0yVSGXZwnDMkB4AYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: KVZ9CFEAwgbjOFolq65vKcF-q08dHjsk
X-Proofpoint-GUID: KVZ9CFEAwgbjOFolq65vKcF-q08dHjsk

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, partly refactor
xfs_report_atomic_write() to into helpers -
xfs_get_atomic_write_{min, max}() - and use those helpers to find the
per-inode atomic write limits and check according to that.

Also add xfs_get_atomic_write_max_opt() to return the optimal limit, and
just return 0 since large atomics aren't supported yet.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_iops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 653e42ccc0c3..1302783a7157 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
+
+		if (ocount > xfs_get_atomic_write_max(ip))
+			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d324044a2225..3b5aa39dbfe9 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,16 +601,42 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+unsigned int
+xfs_get_atomic_write_min(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max(
+	struct xfs_inode	*ip)
+{
+	if (!xfs_inode_can_hw_atomicwrite(ip))
+		return 0;
+
+	return ip->i_mount->m_sb.sb_blocksize;
+}
+
+unsigned int
+xfs_get_atomic_write_max_opt(
+	struct xfs_inode	*ip)
+{
+	return 0;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
-
-	if (xfs_inode_can_hw_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
+	generic_fill_statx_atomic_writes(stat,
+			xfs_get_atomic_write_min(ip),
+			xfs_get_atomic_write_max(ip),
+			xfs_get_atomic_write_max_opt(ip));
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..0896f6b8b3b8 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,8 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+unsigned int xfs_get_atomic_write_min(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max(struct xfs_inode *ip);
+unsigned int xfs_get_atomic_write_max_opt(struct xfs_inode *ip);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


