Return-Path: <linux-fsdevel+bounces-75602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LDfGHfHeGmltAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:11:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6595639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7FB33019176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291034EF18;
	Tue, 27 Jan 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="siR7TT4G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U1w80wXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FD28C869;
	Tue, 27 Jan 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523051; cv=fail; b=teQS22HnbaUQu4oIpuOr6FM0cHRaMta+Vx56bhYzYnYT6JW9RJxrSAGKxBvS/0534orX2ocFImjJXETbZx1KekzK5O0JzyW4gOGzPgA1MpKcJVNZI3jK8i4kFoioDg86b/8JlQZ7jReAQVoZiswuYW6744Nx5OqvY7cAK0gySXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523051; c=relaxed/simple;
	bh=wnbixhnYJJGEU89xfjY+2nJZHvR0BgN6/sJf/b9ArE0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=qAJFxNr78pLlnVrQqD/V6tr7eFM610Ayo9yRmfiNT+kBK3GEpIX0YhJeTCLYwhjjrSq4UqEB98R0++SvPuRnEdlOdsdhfb6OEAhmljoRslawwcmcmYU9vwAAzFZcuKSL3IHRcwOH5CWHA8xI8W2EUOn+rBUp4KEsr8MnHst19mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=siR7TT4G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U1w80wXH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBF1Uc3715353;
	Tue, 27 Jan 2026 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CF/qGyIURILHtJLROq
	zeS3C3q+gGXJrYa8Q75aLp9uo=; b=siR7TT4Gqt4xY9WVAIBohFs3V2bxZqruTg
	zF4GqKWP1Dh3VsNVcJYL3zbCdJPk79NrbsZwaT+8xwcEgmNJoOA2p7FRGGq+mc9y
	QaQ4gfx8D2LHbUwxUbtg47URxkUAzUCGGm900YtOJal353lDuArR6I6ZxJHqEwLd
	HCqujxGZkmrIcrfpaFd0caLCKBTbT3CxV1p1utA+uDR8WYglbN9pRak46unr2nRE
	Ng7BDdDO+ThxYlRMyckQF7b2D1sKMvRw+Fpo62ZUhYfAIMLN5soJ9S4Jp5Fc5U43
	23yHSsOBhVoTMRMrbw4tjgcUIU8lYnpuCwqlvHAFzkJGdoABy5/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvny6v1gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:10:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCwk2k036353;
	Tue, 27 Jan 2026 14:10:38 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhnqta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPj9xDN1DiIIzFVUjsNBazxTa/wIC2cjA/40f7P470TyEqiX1b56jaPuuYMnDPcnwj0mM+pl38QXnSmG+Ir3N2ErxJ0+WRIiUuz6/RE4rb0GWns0ymX65c8EubHwCCMm14nZLhlemZI7iS3RJznAN2Itk1VhOQeQeL+klnQ5PlRQGtdGGHiHcqu+jS1v3jONt7BKlsZo/HH80tRYWd+c/yeiq3QjV9YHZbiNodvrJ1u9wMxF3G9mpNZ9s0UwUGvioR5GDN7xMIQzWz1icwqeEI92qRKkqQmyMhFXYJILqYJ0X3hiaTgZHMSw8pRIkjRgwDCGhOAKeF0IXDjfRlCwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF/qGyIURILHtJLROqzeS3C3q+gGXJrYa8Q75aLp9uo=;
 b=VZ/wLNp/LpOT/2qzJPC2NgEBCJTuH/2C3wI7Gw+OV4uVP2o3Ga3AE/5iXi7VNiVRYD7EgkEx13obtPZOEv0hCq+jnm6X7pP0qFug6J3BduP4OwXD4iLQURJ3KcsAF3KiZ0XKfyScC9yfyYqySHZYPJJo9fZskA0yJyZKSJoTjsSbcGAVL8t/4p1L+m5XPAQ4Hnh77e04aKpqAOlo/MBKKxFEnbTUbQ01NChrWkcpCExO9zNMmaWg0A8BCZ7IxuCQwL5aft/uvYUShSIOH9wttLR9yL6WyARESIt7e/sHCz9ZaAQi6R/W9fwrf/lDxT6fsP0xClHMGIXBsr7Bi+RYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF/qGyIURILHtJLROqzeS3C3q+gGXJrYa8Q75aLp9uo=;
 b=U1w80wXHXx63LOOhZQK8e1wdFXz5FFFswX00Gs6vy6VNIBJm1T98EpJnyGT4hjvnf/IRODqFlD0mM2PWZNVgjav5czQT4e94RxIoQyfKpINAI//wl/OLhukFN80twrEm+lX8beDtdUxYSNLfzqcZZ0Ecz3ziqTr6I/b2AQGuZ4o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 14:10:35 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:10:35 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 05/15] block: make max_integrity_io_size public
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-6-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:13 +0100")
Organization: Oracle Corporation
Message-ID: <yq15x8nw3hp.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-6-hch@lst.de>
Date: Tue, 27 Jan 2026 09:10:33 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1c8a3-5a72-4fec-1a63-08de5dadd726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?piQEwRrpSJfS3+zyQZqrgnMyFSQGCBSnUb6f/yQSjnWIEPVzP1rnvVamF1k9?=
 =?us-ascii?Q?W1ip9WyEB2AGXpk1cRsMFN8OWO2mWj78/bzFEc30rtRqfcbqKFOKrYsySNcn?=
 =?us-ascii?Q?SbY8ISxs2ThZL8jnuVK2hWC2hIZlxsAMCQw6V6tAK6e0CxMjm4ZDxeP3AMD9?=
 =?us-ascii?Q?u7BqANuGXDuIYr2yN6bB/5X4nfhXGnTzhc0SSNJ9Ko7yMm4wUrgc3da6sb5V?=
 =?us-ascii?Q?JA8DXezIJ18gfoAYWhfe/Zeyw2llmhelGSOueF/QudRfJQmGVVQK/70C/70u?=
 =?us-ascii?Q?dcr6SdVjcA7Jkfmh/oHq2tVN3rgl31TokBHmILeGSYqz4rtwPcSOTEzDM7pl?=
 =?us-ascii?Q?UIWDAcf/K+MvGgpjsoTh4ZfArESdWu6ZjEs/anleXxMLtGU4N2h3wnhZyg29?=
 =?us-ascii?Q?SmEBeWrU3CYjpaetiTKHOZ8DcYZHKAp4O100F2/BF5QkkuypW9a8/9g2eZ27?=
 =?us-ascii?Q?DFBE4TysFrKi2Kq7dupRB/gmDh3UM4kcJTCVO7BvRNNvOun+IWQkloxr8NJh?=
 =?us-ascii?Q?vdZyWtQME2G610jDTNBZ9zLE8dR+QoUQSbTKZyOvf6OQ5QoujaFMqbojLWbB?=
 =?us-ascii?Q?/hcm20weSHyVQyi3SfruREGNzHB3MOpiWBx/Q9j+zgAu6Bu8MkSUoVa2fgv4?=
 =?us-ascii?Q?z0V/pTF6kMTXYQ5+mwGnO2sjIsDh1KVjmRdMsXIfeuk3kqR6iMaRoUUaCmCw?=
 =?us-ascii?Q?dRteYTc3uaX238aLol8XcjfBo6SdJvVvZD8Ve3sZcFfg/go8xFGKt1i15fcf?=
 =?us-ascii?Q?EW7sjnVwzug+yta3VgKqpfze22zvlCvBckI1zT8kjTXCzwqUHSPF0sUkon8M?=
 =?us-ascii?Q?cMPVCrgXK1ojKpVD5/Bb1+36VmhsfYv1yV3/z5ihB66tcuRMTMADvrE1C7DW?=
 =?us-ascii?Q?ehpKEkVCSyaat64BVKcFweG8trfHn/tgpE5J+drtKBOvRXDSe3g1xbldgwJ+?=
 =?us-ascii?Q?m5OywLNmwNvXsaR1k4Kl6XqAE39edA7Q0jlPOoA5fpGW+asRp7ftlml448O3?=
 =?us-ascii?Q?h081teuxRW/vV2b6k6bGmSF9+7uzUYgWwHGSbBjmd+2x9SK//QoZgX16hG+R?=
 =?us-ascii?Q?2wcH/UeAUHOjZY+DUEVfp8/3WbziEfMdNjvtsVHXDF+U7/iVoi/ouY3G9VHB?=
 =?us-ascii?Q?swkqGP9QLaxKpztDzuoovnYL3QOev1BroJM+fC020U4W9azhWEIrTYZss+8E?=
 =?us-ascii?Q?+q1D8U+LKNGfqMP3rgVs89L1P8snLXUe1KjFp+fSDPYzJedS9Y3UDa0VRglP?=
 =?us-ascii?Q?44kPU7RaoKTONHoWAnz0rM+yd5vFH0phR+tXMAW5IWXf5fmtBPhLfTGrm8rQ?=
 =?us-ascii?Q?mLCcj7Hx08ZEsNFtBMyhVAsVaHzQDbvWpZBHPu9Nt7kIUvP9jmjm8wFxCFfF?=
 =?us-ascii?Q?Br9NgGk19HPUh+IcGuKwu1o3JLMFlEesq4/7ghaomfgZFLFXl5BxVrZk48Yq?=
 =?us-ascii?Q?pHERqM6fJr59mHh9/ySFi0xvumq1Rrjy0QdtAcbsLev1yH+VX0ueqxFyxHc1?=
 =?us-ascii?Q?VeFElV13U3QkH8h7KyUiqnf5IkhrbI8gXLHZbM4veIfuxTahYPXBKjQeYP94?=
 =?us-ascii?Q?Ej8MYjZVgao8ytpArQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecBEouFQS11f5dGgxGEPNgVLHNtiy3bZGo/Il35ayEeFl4OHybZnVWLJCYw0?=
 =?us-ascii?Q?1zHtVpNOkUGKZXSmuYwZg3zkuCsVjW5fcU0G5Y85TofywnlGBuaK6OmKVWBg?=
 =?us-ascii?Q?qvqbbRlV97Wq5BBTKglZro9gemrARQq+z8D8X8ODhNuMBYUbZZNjBbzvdlAv?=
 =?us-ascii?Q?oRtJo4xspUT+mbiOoNswSRdwwvFLZmXNfqR0RUPZKtpudgyJ6Dl6ZYLEAXjc?=
 =?us-ascii?Q?VluclFraRQlwE3AqK9V36gOUz5nYqCiPkZHyaVJMpYr69wKQxeYYdjuqgPEi?=
 =?us-ascii?Q?CZOPQ+droe4jpciOjcbvQAF5hduFkewVS3wxHkgMR8upRkBWs2EQvnHHrUiZ?=
 =?us-ascii?Q?MzsD9xGVq9clMxsoiOJlIsFD+Q6ltYFcbz9s80kDlBwGcuII8Dhm+ZRtxF/Y?=
 =?us-ascii?Q?ughAEAQzm/HUjuxZ+YgZxYrCcGGZfH7SH5M6SG8/rZeH4Xh/V0EDggS57DcF?=
 =?us-ascii?Q?iuD3JCLHKw9JY6RouYQtnA+Gdmb9zUNvR01BUFVSfgctiY52plh0ROZQpfWu?=
 =?us-ascii?Q?f4ALL0tOuicdnOLM9vQ6P7seYQPh/V7VsK0etX2sh5LxPQMuQhuoTSf364DW?=
 =?us-ascii?Q?1eNa2H90eTPrVf4kn5bLrXJ1Edc6Wo/v30Wgy9KPh3aUzv+xxSB6mmhxYVsL?=
 =?us-ascii?Q?aCnvmt15sC7bJ3xBFas4vaAWr4a1HUPmGYb1+B9Il5k6gzSZnrI2vJxGs625?=
 =?us-ascii?Q?HwjW3z4owuoX5tKQA8LoTL5+9lVkr2gtreLKiumKF152vfH1tIJTkT0D3Ft3?=
 =?us-ascii?Q?ihc4XXStw4WnhicdZSylX0hmwF5VcEuS2SnR1RVaflE72j1Guigjn9dD5ycu?=
 =?us-ascii?Q?UAi16dzE1gRbkGByK5kkND91o+j1nO043KSXnfFzR3VoExnIDNmkk7QJZnVy?=
 =?us-ascii?Q?A8S8iFwt112LKPboFLZ6i7QoNLqFFRMwULUtyH1LhJ4A2+XofsF6vZn6KS9Q?=
 =?us-ascii?Q?ehIKNbjyp2+GRd8qNckuVSFLUpcucdCkfqSTruLlvOl2JTT6QYau8GKC204N?=
 =?us-ascii?Q?ICHUwqKKllNOZ3Dypk7buQ6F6ZTKIpbYBhRC2Sq+8JjEuRcHvFoia9v7eHFQ?=
 =?us-ascii?Q?OUITCfhQfnaOrncCZPNbslj6eFgELdtfl7pYYmAjjhsO+PPfADeY5CEoI2/l?=
 =?us-ascii?Q?ok35y/fQspkPR4Z03Y4YZSAddY3DcfY8US9YFU9++CH8l3/adSZHv+rhJGof?=
 =?us-ascii?Q?Pu6o5pCom1M6GjA4ykYACBXyQtgJ0Joe+czHAOz1i3Ic7Pf1j6rbep/0wv7M?=
 =?us-ascii?Q?zQor+1q7larzysaIwslmACUiUnTuWryQ+N8Q/iL79nV9GG2fhvc1+GNilBq2?=
 =?us-ascii?Q?s/SbzMhDc6JfNdLXbs6hpacHIem3BoIJxTzTqXGMmSWy6RyYV7JKYne6LS0K?=
 =?us-ascii?Q?CS0FadXORF5sfcU9tYVf7cHl9KU+I2u77AvyKXVXV5+Iyr9bnuBhG+zHl+fl?=
 =?us-ascii?Q?2uZ9fwz83Cw7AMrJ1rJl1aY8HmWke7AetsoOJBCW9OS1erPi8vbgiazfTT0e?=
 =?us-ascii?Q?HGta6YsD22zAIbz3S8sixYjFFQs7cTQLSGMwca7OZ4dZid2yec8OFZCsV1rF?=
 =?us-ascii?Q?4MZBy8mCtn+NHOq7RwXLfAL0WVLeeyzq3nFJunq8wOybCYmlpEvwmxq+6AsZ?=
 =?us-ascii?Q?cdFMPldSaDQ3QSjCJN/V8tPpoX3XySgPyMh0sXag5ewJ7mi8IXxl8cjNAllF?=
 =?us-ascii?Q?lMWrnVs4oVZYFWd+TsyQ0pNriZRXnuuAfNGSZmIXYEWJNztLrBslRTav1t2W?=
 =?us-ascii?Q?54/7NQj0XRiDewWivxQbby/G/DOI1Jo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18Ol+4vWUzydFjRhChtXlKt12w0HkQ0kFWFb6KPqVAYkT9i3q8frci/EBesExT1oYw3GtDmFBnhohZnHXc8pe/gQxF0Nf2A5KMKRnqXJxjvAagrRf/FelqXfBO4Uoyk7AUmk3LlYOBtXHbe9DFaDWatjMElovOFDkFsOC+scE5TXLZ4Ei5E4BzIGum1hGLU2oXdD1guTSE6dDHLXU8c4rfIDHymJdhbAxk1xcWdWCYo8FeUp+Wq83YJpGkB1GYsceSXzVHhv/DGPtG4uyNboXvpFghTQj57xE7VHj13yaUMY1z6Px4cyVDUuvFmoBJ+zwexFpaMx/iZI6gSQVTTIUH1w7HjxoX6wxeLRWAre8XJ8F1qJmQiebVwXklYxHrMAqqGTpdC6iRchGkEzfLKYLHF8iP1ONGRzhDrXL75ysFNQTe0F8ztLfIHptvwNwHsgMn3tIkPnXVTQ3Ycr9DQeNiOQRnHD2liWQFsd+Bfc4LKdothw0Lbb1HmAwGMMj33t1nYlVaiBA1uPaz3BqnZ4fXTfyJSRumrVU0bXwXedrNagJ+sFGrsPXmBHzlqSIqE1lVrggTyBAb2m4CgTloR1FZObOCBTtQPSQEd+0jWeHO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1c8a3-5a72-4fec-1a63-08de5dadd726
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:10:35.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrdtaislo60tiFcxntZx+7Ty/aJy4Q/x0grDayqvPo+NjVv8jtkWGmIz1nGaLDd4YeWb7u/gqTJ28lyDZLCJ/idlXm1/9PdyPuR97FWwEQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=977 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNiBTYWx0ZWRfX4ON//g7xB//S
 Nztr2A2n83saDA0YbSoTdYdXR4jSeBvX6H7yhtUbHEGHU4+6FQtfd8+1/JO1b0juiWfSYsvjQQA
 H03tf/dD29w1NZNU4E6wVjR2/2xDHn03GZ+k4iMXOzBKY/NZresWLwlzIPW6qLhkX62qqRLc7UU
 3Cbn1utSe+kTF8cy59DBNamgZAgnVw3ZaiApcRR/uA4el8SNT1eFnSTpIKSgIm4ek44wDBc60dF
 GJOo2swzHfeVCEqn/E83GmW8MY60aMIdAbwogZPvJyr61uqITb1gOQT3hSMAMkzrFIRLjnN9Vmn
 VMpEvo3BFvWHSQS88EyNycMBJTndF6Qe4XVTK64MIHBat3aqPQsCrcwULTDhkjVGdiIqkJhrJ9h
 h6jd1NaD1itEWwUh3JOcl2vlLYY+KE4aLL+Kkc+PSW4gdC32CQY63vmPbirjgHvIpE869MrP4zz
 iLPIqV+6Q2EMQ6cM/sfu91imVcboxV8a4ZTPVGlc=
X-Authority-Analysis: v=2.4 cv=C+XkCAP+ c=1 sm=1 tr=0 ts=6978c75f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9ZNUjZ0h-AqvFYr9gpgA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12104
X-Proofpoint-GUID: 7c-A_7bJAilXPie5dylKxusekbjke8Uo
X-Proofpoint-ORIG-GUID: 7c-A_7bJAilXPie5dylKxusekbjke8Uo
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
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75602-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,ca-mkp.ca.oracle.com:mid,oracle.com:email,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 12D6595639
X-Rspamd-Action: no action


Christoph,

> File systems that generate integrity will need this, so move it out
> of the block private or blk-mq specific headers.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

