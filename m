Return-Path: <linux-fsdevel+bounces-75609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNQKAVTLeGnBtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:27:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2F959F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E8D8301CC6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3135B62C;
	Tue, 27 Jan 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BdZ0zk6H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OvHOBMuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25E34F47D;
	Tue, 27 Jan 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524035; cv=fail; b=VS3BUDiWsNH1CRZ+5344/sglX8y2NRA6e5LnHQXvj27dNjjPjfYh4x3MGaB3cBqBo3ONypCgVdetgA8yn8sNvNa+Ql00zuV3EZiEvqZszOg61MY6f8X2eaFfyWm+xVFdkF3BFAwAu4CeDI4N7yRmhrTHqEx5S9WSM6sap4CxWGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524035; c=relaxed/simple;
	bh=2zHeo1uAzyWbsArHB/HSAzwEPJMVe4vD5/W/ZXxKVhU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=FwqBiJI0DY+aBXXJvxrSgFIycEj79vjb/DvAYRPjgtfC2muH7qBv8vMLjqFMrnOjEgDi+N6sy3EZq//v74fAQvi2jF70D3jlLr1XauRiXl4tiFPI2iKVSjRNoiFSKbPNDvqVnVc8wf+91UVg+L8sTz3OC7PnPqNoOpCgY8nY91c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BdZ0zk6H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OvHOBMuk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBI5mx3545330;
	Tue, 27 Jan 2026 14:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OqVr5On0aNOTjfXmWr
	hFH04uCd+sMpkodh5KYRKohyc=; b=BdZ0zk6H0VavN/thRHiwmIE8FVrwIw2zsU
	KTCpS/OETp3WoEq1bBcdCNQhOz+Tv9XuAl7Y80r4e0vLbjjycGKI9M4UwUyUjj0k
	8ot/WiMZ/4hIEBrEwbAxYE9cbnyMOyHU7OsWDrCoUpCI0yb+U3JHl1/z1uccsiB4
	LnmffaEEZG4P5VKESu1Bkcz6FuWmNwnKpX64ZGG8n0z0lmG3EnK/Iik/3UZSh/ao
	M47u0EXJgTmEtT6BDvFRz5ChhCx6zE3LbBDhplXSV+SUcNDFc4zZDwWPvZG/T8yj
	ta9ifD+7BOpNJuR+xinkzzW2okMwofNqF0g0jCU2aNvyN9Er7K9g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09m44y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:27:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDg9Bs009970;
	Tue, 27 Jan 2026 14:27:00 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9g5g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6CMZMAvm9GhfR7SjlNjru3zR6gm2rnbGJezJkQARNn4zKDLJhVDZ0UvQNm4AXJPf8Hya3Ms0NuqtS1NFX0Cyffb8Dr1UNEYJZwKABPzjdPLAAO1S5aRFFSpCBN5kpye2SiicVvIY6RNQfITSBNPzyzQOMNoPgXagpfe18IM4ttHBEQ7+iEj2pz4OABJPARF7upVio8WMCy0YdZqIH3v9beMgUntUQ/tNPSENtUagWTwC2hHElDBr1xVDdP7qvBtiJVHkVXgFNS1nfmD5uuzDwU7CEmboigCSI52Mxpt6FjNeHs0n5Zd3JetzvEGCzEnqMSO4KB41vg12iFXaoK2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqVr5On0aNOTjfXmWrhFH04uCd+sMpkodh5KYRKohyc=;
 b=c1wy+aD0g//2kTZ7SGpYhzM6FtUFLPNrRVkUjLKT+V7xEw4srmcWpNRA7bNgVdUNKOoyJRa0UpoUIYQu7KDFBD8T/6HjYiDoJYTGq+NTo7EWuKcquF8iMFqeLxfGjfMI0iJEo8SqtTLm5BpGL2bb7eLCibCdTot1Amj6FWHauMwcMizXJMc2DY87fs6uSHezqoAaQMJdvVLOBvaeEUMxJYqVMwoOdiRwQPuoxDxGaCx7q2NqvECnL8mnPcEsyetL07OXZRGTv7GXBboYSFSGsB41b4pTpkCNbCTk6vRYbN1ZDBzBrUD46YDv5s0jbvFlhffYugBp4Om8APS/Twv/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqVr5On0aNOTjfXmWrhFH04uCd+sMpkodh5KYRKohyc=;
 b=OvHOBMukUQB1bDhP+ttvvFDIl+4ERF/g49nIYaFdqBvmTMJV0phhMbhNcHvrqWDURVstoWErc9P7SqTfsSuaOQ6OnofW9h0JhhlITP3mEyH7zR76VPOBGPLU7VpXnUX/F5wogw0+HbHx+E79n2OoQU0SPcHsaLSs69yO6eJDYak=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:26:57 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:26:57 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/15] iov_iter: extract a iov_iter_extract_bvecs helper
 from bio code
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-5-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:35 +0100")
Organization: Oracle Corporation
Message-ID: <yq1sebrt9ll.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-5-hch@lst.de>
Date: Tue, 27 Jan 2026 09:26:55 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0044.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::8) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ced481-5fab-402b-a207-08de5db02091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVJ7gtCc8p4DLI2BmJD5sIC94AIXkTU5HPN7oFDAQdgx/igPNlSmT3wW1lFa?=
 =?us-ascii?Q?Lb7ZgNQle2hn7GRfvEKZ6zI+lX2gPRALbc/H8RqNXsbNRB8vpQ3IjOzvnZ+l?=
 =?us-ascii?Q?qk5x0ZCj2+nzRZ6wAegaOSbLMaBLgCPqjtcfdI9PcQcEtEpY/Otv7guanTl5?=
 =?us-ascii?Q?EJNvXTjIS+45tQnUCSrexI5EyhWjz8vZGI3rMVQk7iYv5K5HZMDoGIWNTNrn?=
 =?us-ascii?Q?entu9WpWubGVh4UwyiD0Ymaq4QF0EEDVuDrAs8IQlNgX/BceRxApPn96om+j?=
 =?us-ascii?Q?tVsEkVnhTk8SttMizls92qAlU4BoBF3ihA1ME6/mEeJmS+D9x9c+IZkt2VMK?=
 =?us-ascii?Q?ffhsh6CL4/CpjO8aHiD5srJbQdm9WYmAYq/bok7maReDw4f91IOGTsEzQVrs?=
 =?us-ascii?Q?BFz85bAf9Xeiu62Q9zchNX8IA2Auw2c2G2SbenOT7Ep30dIj6VN7WBOBql8U?=
 =?us-ascii?Q?ombCsI3VYaoiLUM/pbZ+v8vRQIPLVRvG+AkmYH2nJg66MvGJqpHjWwcJXkRB?=
 =?us-ascii?Q?WL5VDThA+w+tXTX+BszSsTkSKHbIbvXsOE17pPGtnkRQQoBc39ZJn7nA49wl?=
 =?us-ascii?Q?jQNu7vOdIijyMqS1iBfFlaGH94uvD/D/cvH9WzjT4IArhLyiwkQZitLjkful?=
 =?us-ascii?Q?DZwp6ddb46poYDhK1wyKHC088v5wj4+XKXNhOdF+zIP1Jv5FrQs+yHwiu5ID?=
 =?us-ascii?Q?afUZz9i3IKE44MTWUfdvccAK9SZrh7DTA3/jQdo7zw94nEYKr1oiW3alqshe?=
 =?us-ascii?Q?Wm6zeDt9kKiITwE0ZdMdyOwlBbBX+LbHwM5pb6XZIrRmdtI5LFnSDHwE/uCQ?=
 =?us-ascii?Q?jQZMPtjYJtrzNrPIlessaUS1SKI+UNwl3S/ntRhN/B7Amq8bKiyUYDUiXdQB?=
 =?us-ascii?Q?yiRfjKRl/dzwK+Rk9qRbaiObPr0wrMxnxjr3QCb74ZGQ+NPBRfHPtZjp6ze8?=
 =?us-ascii?Q?/6Nd3WVl9JJZp7IKGr/gCVZ0dfviZ0kaPG/Aj0EGQCS/A5xxzgqDgY9LRvPL?=
 =?us-ascii?Q?GADYZnbTmzDGQ9oNRFr5oELRymwwkclCkzG5BMAJfWCzWHtpvXhuiZeMkqwc?=
 =?us-ascii?Q?BwJ9tSVDOpCDm3YYmMWqWlZTU+wknUSTiQfo6EMDeq6zN76nM31t3VzprAeN?=
 =?us-ascii?Q?nzjVIZjhJpPRT8UxW3U5LmVZSSM0p81ySxoLgfsNUMBegofB6VldC4VdvsWe?=
 =?us-ascii?Q?aDUZAPR0wfF9GgWl0h2wRwOj+S7dS+moU259YjL9m4j5C1jwr7ADo4hSuXXT?=
 =?us-ascii?Q?EqY3aV3dmcyw8/zYl9FPoy46x62Ejh1fGqXHKw5Xf8fcDT4mtuAM8NeyVM9E?=
 =?us-ascii?Q?5x9S8OkFKHPXCUL6qjDKV9FdX0nbqqqw8g2w1JMbBT2kg29n8OcUYZvrrNFj?=
 =?us-ascii?Q?jjopBwd4SQb+1f7ZtRdSPC7sFVGkz1gWzlzWyZ0xK9OiR7f5zTEzrqS7duTF?=
 =?us-ascii?Q?o+KZxla/wVP4m7DA/QXLIs9GDpfHi5YXjqGY4fsx3gail/+KFLczs2DPnatw?=
 =?us-ascii?Q?Pv5RVD/7AqIsxJtjDDdQFhFXaN0QYM+DhLTPQ1+LeCUJL6h3f3m/ubSL7NpY?=
 =?us-ascii?Q?ncAvrs11SELTgtcC7UM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBPZXLCIFhgz24PWpTya5S7xYuQVpA5wn05dcB0hhBVHymRSwDiWOkDVW9Ql?=
 =?us-ascii?Q?v3jMNJHJldRFqGMj1Jfi0rXpI+GiakRS5iGFFel2O/IQXhx+sImTNHSdT0lp?=
 =?us-ascii?Q?rjoi479gcPGY/s5LbNqfIlfNiNnRPD67s0j4e+/W/pnhOGkIpZdYEwsmpfOF?=
 =?us-ascii?Q?Cp93gvUks79eQzS7Ku92QJZ1Rac5txXp51T6TCsoFCRzR2Eqp9owDx6OJH9P?=
 =?us-ascii?Q?sTJFG4TZipZywxxlZ1CNfKbdxIZxudvRxA8Vvwt2hIr/4frSJIoznWqwGIvL?=
 =?us-ascii?Q?cFcWuwAQGXUkszvLJXQroaq8OfdKxgA1gNtphJ+eaPLFHeszraP/m1mF8RlJ?=
 =?us-ascii?Q?zHWd5d2qVQYoQ7MtaAdoI5OkeE6PsCEnPy12GBQL46AzKDhCOqjkvdQ2hSkt?=
 =?us-ascii?Q?mfWy/fdBoSgm7VLTjJy8O9A1RoE9eOn29EMvxVW6vjPOKUPlpDxuU5zIawMV?=
 =?us-ascii?Q?bMtGobmICPZL8iFEA52Hj8BxOSdF1uK7kTf8a0dP4DG94t7Zu2sFL+A3Vwgr?=
 =?us-ascii?Q?ZVc3vXNnvPAEqTI7cRBGlcjK8rVTZ1FzUFUB6CZss0vIk7DFb0WArjPMWW1Z?=
 =?us-ascii?Q?oX8OMmDit42EZdpJGRIQ8V6XbRRN1EaSWAsn3fq02oOE+OvdnidqLuqTAt4p?=
 =?us-ascii?Q?874BB9CyPa7LRSXuk/Sws+V5JmyOUVp/H7nGADxNemUjfn7mDcf9ORW0GzRz?=
 =?us-ascii?Q?lsIfGUbCDsJP/fj6vbNTyVdzJfRsqUpRrjaOEBcj+wZoQnYePdtT+5mAGtji?=
 =?us-ascii?Q?59vbJfkgj1zNPc4C/tv43syoESj1Qh8b/EV2f7LFbPorRI/buFZYgM5UsD1G?=
 =?us-ascii?Q?N4BGfPE0+lHLmYY7FLJFnhKiOJyGW5H2YBWMUaQcMomCVEHwN6Ngfkue/6Su?=
 =?us-ascii?Q?2desykeo9ua/Ffn+gCNdfC2G1Ta2wH6KURxKXhdD4n85QasETE27Pu2IHORI?=
 =?us-ascii?Q?IDm1fgRfOd2Rd7W+ldqKkA7XeJrtqC1w/C6VS/cC637gu8ce4atow+3LwgAK?=
 =?us-ascii?Q?n4PiRLWxIOFcDZJnxOKG6R0QTJRY9stYb7Unb1vwSGCl2BSMgdtxIXysFCGm?=
 =?us-ascii?Q?ITHJidG6oiV81k89tTCg6FvBbxQa25ScM+Y1OMsnU+Q5GwQ1AChwmGsolVEa?=
 =?us-ascii?Q?OYeH1KCVMvw0nGJ9ctSEO1KMEKdB9Z6018U7qlK3AbfYvYTsFwypJd25F9rC?=
 =?us-ascii?Q?haBFBdEXQO7liggMwpdgX0KBauYLluXvC2jyItR+MwghuYI6+FipmGFCbPT7?=
 =?us-ascii?Q?75putVmFSFUnbbHQQ+gCk8gI5lkStcnAcjpUei8Nel8X0PY3+xh0CUCug1dd?=
 =?us-ascii?Q?OABNfjUgnZPrL/CICfbqXgV3EPxOsV6VDOXrAWFqrtnfIzrXATThdWAKt8Vm?=
 =?us-ascii?Q?h91YD1MAbakp7R/uPgouVj6A0PJTDX7REo2MkJFTwKKjigyVH2l1L4I7ZMpc?=
 =?us-ascii?Q?MiioCVdNkBK4EPv8u2PvHnBOJgT0tBIsEKXP0tBrD0bNK9KssUcmgdACzI4X?=
 =?us-ascii?Q?RjxUNS+sDnZzzMXpDhRr13pFXdlhv2W0Ij7ElycUiqvhQTdA/UJAw8R8vq7z?=
 =?us-ascii?Q?wGh1ZG1AASMjHWMTnI4kpwqUMyRlx+kjsySYAtSiSHVVMtbADURVlpJVsL94?=
 =?us-ascii?Q?fN0mLamWtjdIe9QBMIF5BaFsvnbTOpknXO5BkkErEnHuFdUJAurAGLQBKbbW?=
 =?us-ascii?Q?oK/wnTcLalNqJzf/sLeV3m4ZXqMVWtKT+eEvNMUJaLD/UKoUs+28OtQmRHCE?=
 =?us-ascii?Q?qFxA/VFd6zY+Qc6K+FK0/+i0RZWzeDw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gs4Kz3R0sIHmNqhifesZJ7GUv4Nl5YA2BPo+JbnQPw1a9m//Ob+M6w4yk2QSEYhZ++88buVD25pScma9SgFtTZWkECKMqn6viZrNRGP2dv3QA3bZBMJYsKsrYjCB8zrLQRB/Z7z2+Dat1tY8uK+ipAnx2fa56RH8jHZ1DcI3HjTaOtoi2UfbG9iIn0ksfpdNbep+CgdXTLGhKHZww5m4LHHZj77sqAPuGL+RPZVRqZ+/ccYy84yiwmq7a3ZJelJNUqRsqrQLUkq88rkFxfhI+Kgo6c58YDAKBt9xaIAZFGqBaH9bm6z4Q0aDCNAhNtVGPvPWR17r6W//MxYIwTGst6662xZ/A4pYOxWIboTTby9k3jHblGdKYYSwgwQFK41UpW8TBOOFFZch9Medaa3Te3YYmLI4shcui8+MlzlFtl+dwJF3+RKvf8EjAw8/CpcD3fYwaQwzD+qGGHYzyTrCdRTjNQW5CEh/bp2k/1d9VSjcF+x468TxhCuj9OQ6RpHflTL5C4Lr4ZCky+e76ooi/dBFOI7KvEc09sMI95zL/I7U/2SV/2KXu41rCsc3AP+D3hxEEv41iKnaBvY9Ly+ufNaypsxSVtxEIUDBNwU2kjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ced481-5fab-402b-a207-08de5db02091
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:26:57.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhP4nb7DEte7CC+QCb7oxcNI2Om7IHSaa9OdiF7+HXMZSHcELFWH0yw5+4sapXBWcPCZ43pf50dj0ikt2Vpjh1UrcqYjRpQb2v6zRVBBLyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfX/N3l/YvkPU00
 wlcSshSNai+VNr/Bve+TCSlFRtXizmSAobwYHUyNFjjrgGbnSFSbrehvSnH3D4RXX4L6fAU9C98
 5GLMKpjujo8zEhrkn1t+OkhEJcYvg0fKMGxsRaTBGJKymlkF1YMiBXkhjlVKdQYAdDoeqnNYQYa
 XVl5V6WiExc6+Vh9eQIU+V7z1ET9hpaxwn2bH7kVkbiwV3CRDpAYVUZgAq4Tsqs376y33V1j7Wt
 KSMd8DA3zzJakBBXV3gPmYqewT9MBPkglCL8W7X3lsZG7gG8x7MzuP0pvFBBxt1YAhJ8hnQZBfR
 xZPkVZEgCWLPTed6whojuXyQrs45Ud1G8/kQGkXea1HXD3IHDiB40qWKbWHmNZl4fHEoGVk5zP6
 c+ZX0d7t4fbs8F2e3l1OnAoMfst8UVuMWu4yDPd5mPyWGQDr3x6aLEnxHw00eVoVDwPhgRg9JH3
 lEWvKPX06hP0UfMvnbw==
X-Proofpoint-ORIG-GUID: Bkf-Jwq1O_0uidFVdVAnhVtW-FXz5RGN
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=6978cb35 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=6sCCgJNaOcbRvVQuND8A:9
X-Proofpoint-GUID: Bkf-Jwq1O_0uidFVdVAnhVtW-FXz5RGN
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75609-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,ca-mkp.ca.oracle.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6BE2F959F0
X-Rspamd-Action: no action


Christoph,

> Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
> move it to lib/iov_iter.c so that it can be used by block code for
> other things than filling a bio and by other subsystems like netfs.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

