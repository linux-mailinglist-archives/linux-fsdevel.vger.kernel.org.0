Return-Path: <linux-fsdevel+bounces-17399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46A8ACFBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77D51F20FA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BA153800;
	Mon, 22 Apr 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dx7yCvD9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZEC6eVfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069A1534EF;
	Mon, 22 Apr 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796863; cv=fail; b=EKpdhEJIFhzf43rW8V9UuJgr+8Xq/ylCFYDfPGs/LnAGQ/pb/rImb/yeiNY++EJ5PugrJyerBLR/YVLsJ/TWDP6JEAeSzfOjB0bV/5YgkBo0OsyOCgdB9U3lUwkaUEdjw3fhKnp39Aksr7DnsCuRy5naG1MVwkouP1CskUYoM6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796863; c=relaxed/simple;
	bh=gLm+aCnWKYQqK3OVtfmDOXLbWTdsl2Opx6fu1BGPPD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCh1cMBm0mw7DDREFPiGE8qlpnFMnSINwlDiqIWDDjy5URSAwL+SvcaBLLytMrALB9UZD7MiHHsVmMCEBJOJmmBatee+boNVW1MC5sQkmHMo+1jEt4eIn+g1DeZkLmEaLADT/IEx8APmEElno8wgAaWilUm7ocs7cTDJUvQYaLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dx7yCvD9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZEC6eVfA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDYqq7018272;
	Mon, 22 Apr 2024 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=w9bvgYzAPBe7SVrTS1knS/niWNGXh5GFN5/xdO05/qA=;
 b=dx7yCvD90+9rfIRboIFEJGyqMgmrd2nJVqw3d9Vi4FLE8vpqH9+S6pzHzFXtPq2eKiSM
 ilPvdPJnV0pbUlZcR5uy75XLbPMxh4j5yG/r+xQUn4bPKTgkcfIv1cuV9ekGmHwSo3bS
 2oGcNAn/Cfvwnr6IZjeTnL9nLq2Boekey7cRQ9ctbjwzk04oyA0ima04xlcrRlNcRHfP
 eyZN9yR/71nrm7+Dq+mlZpxnpQdWCohm8dGCrYBmfvwv8acDDxKjHr4FjxqsSBrFYIfn
 FrXuaqfedFQ0xHTGQfogReLQiXGWWDtFckWCp3jvTI1vV5Ki8ObVEulZNgwSy5+TBVoG lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vassm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtjG2006759;
	Mon, 22 Apr 2024 14:40:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455qkvn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPGEOwSpxcWt593Yx4vJxrGFlAp4aJr3Zk6YGRWXjDTzrnoxfDF3FEfeX1EmE3tsZItMjm+P4xmFfmRD7D9rB0F0eOh4H0XEzzuA0fukNH5hQH2ICm/gZcjhMTuY81X8nes6wtveFw4BLSTYqY1hkHLWLvlKyEHbOVLbaheSOeFl04fZW50OiYno/yP1lkRnehcei4tb36UWH1bRU25Hh690l5VHHN3KQTarMofRy/Sn3HM2+EHAGTwrcHzBqU5RXT1qOFgKRbknoVBSPF6cWsKE+FoDumHyQgJMTbCviyw3PqkZEmd+b+2srhobFw9QEQWCYgpQXvrkL3X9CSH9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9bvgYzAPBe7SVrTS1knS/niWNGXh5GFN5/xdO05/qA=;
 b=YwRHGjKbKVOdeU5HgLAxu4lSfwNHo1tAEKT6xIsSw29C/kgAQfz6eLqIQwuHbOFz78Shb+BKVmZtf9XsgkVdaBsdrDp25Pl5oFs73Xb8LBPMiXMGtkSLLnu1NWqfsO4jLgWIrYPC/VaMmnbI2w5lHJgJKs4yxEdqWzJK4y28+UZMvtrEo7MYz6MbmEK7G7hDSwPDQ7+J0Sr1ZZ/0uagB3ZVCo+26VaDmVV93YzFTewMkCL2+1ZjFYYeWTAfY0KQj3BbSU6xTPNDirCBvCBuPDNqlHziF1Pdj+nf8FS9YWdQ+N4auIHMU9wRntcWHNwtBnqnaciD5hVPJKk6hXWMSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9bvgYzAPBe7SVrTS1knS/niWNGXh5GFN5/xdO05/qA=;
 b=ZEC6eVfAHmQVqpU7lud1E8n2mZtVmkCxzPuVWZgQ1wC1x7XTtLJpPPEQazS0rdqW1/N76OBRhhgg+kAwat26UpLA+MCovGXHANyC53uZmL6CAJVjCDbI8bpEsQ8tzzHB+M5wi9950gCrSaEQ20oek2Qt/RgRAcj4Xy9M7IaxH1s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 2/7] filemap: Change mapping_set_folio_min_order() -> mapping_set_folio_orders()
Date: Mon, 22 Apr 2024 14:39:18 +0000
Message-Id: <20240422143923.3927601-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e76b849-5a74-4017-07f1-08dc62da2121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JMF0w3QTBlSM8PWYRst+2rcu/ChTfygJO/t/LRxs8/sP8rgfF3DfULv1zKAR?=
 =?us-ascii?Q?51gJ7ufqyws7pnSBkcutwKMQbym2Ac4Qav6KmfTQtsd4VhxF6KTKFuCKBj7j?=
 =?us-ascii?Q?5tKHvJJM36xn+0QGdFWUwejDidBIL/Oz1e6Q5xx0ALZmAA00sDJe4irU9bgw?=
 =?us-ascii?Q?PGanjMC/ESq5oCqSg3/1i9CTnqleDIzO/1qKp9GERnhBX9DSd6F/aRNJft98?=
 =?us-ascii?Q?es56ZcNTzTIhJylsD3BKFtrk/aW3qg3tTUeIhvX5BI0FtR8Rf434Lm67kOey?=
 =?us-ascii?Q?WHX6JiCcDnd4dhTQ8ysg7cXOjDk+i2MbQ/H1NCj4ITiHbjpbb+z5k5K2/S6b?=
 =?us-ascii?Q?gbSFG0/j1AfVDpEITKE226zBoifoTDiq/0u28IyV74YOYrMgihDPmTARj60c?=
 =?us-ascii?Q?Y61zw8LbZgZ08FZhHlhauRyH9RzP9mJqvU7sHzfbrWAd0YCJELuv9xFI883W?=
 =?us-ascii?Q?OmtyjfveEN8Y0wpopggT3cRiyOWwxdN9KMJDyHZHtvzhQE8ES3/2Qti22AxX?=
 =?us-ascii?Q?8RuERVppjrqAxxmf388SiJhRPIhBnKpi6vT8+xGwuqTweRf7/hQWg4nET2Jz?=
 =?us-ascii?Q?yGzwzHk1tKkK6+W6Ar/XFmFj43l2fBGfrDStq7aUbPLlbPJlXBFc7C+5fFBF?=
 =?us-ascii?Q?TsqHDk/xrnQDieU8+kN/h9X1XYVSPxfuJTXCyhUqErms7m5fZyhaD24AINVb?=
 =?us-ascii?Q?io6CNt85u0VBqJXw6QJZoVt/MfksCREKCTef2V1Q/TjTuwDrW5WsRAbiHsFc?=
 =?us-ascii?Q?jurzUlfzQ+bR0O+5Afyr/8Fs76yrdhj0ofhBKh4GQ/r59edz1U0tA4BRojkw?=
 =?us-ascii?Q?cXD21oxrPn3uVrGqWvC0RZwufDEEYZWjJm3RAfXNp9/gM3Xh+gMgheF/vMyw?=
 =?us-ascii?Q?kaVYQTOYGt8AiD1uwyo7uvPfpGWTFMwRgqJeWy/NoCtLpaqCKBdHEJrOWi3c?=
 =?us-ascii?Q?FQjVdBFNWvASq3bz9LhmUO4pyZsDlQaJQSXxhhK4hROa/QBE25+T2wTeKQp9?=
 =?us-ascii?Q?8vjfksil3HS4LLkkZ7qrQj42xxPkgGIbcoAEKDo1d48BW1983dbNp+A7HAFR?=
 =?us-ascii?Q?nUBy7bU9LjmuB/08CxNjxvKezf8kJ2OMeuaRH+6dtXAkecJQ8aqL0SrzGW6j?=
 =?us-ascii?Q?CBcK0YzUa2KRxm2K4//q8XMv1aqTxFDZj/SyxjU7M6X8Shmevy1BUy4333rv?=
 =?us-ascii?Q?bvUFE3L57ebOZXP6bEbWc83ma8/qfliZNSXoB062FB8twhjc3Q781iDTHvX1?=
 =?us-ascii?Q?4lc0veu5qWQOmvEAC/M5rnqHk+LYXeaKqH+u7qMhiJ7BgMBQ83dZ9YVVuOeV?=
 =?us-ascii?Q?dInY9ZO3CCZWsgYqlk1TDGXD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PyLHnOJ6D8Fq+4GiQZRAmZTEc8KeLLYMnevYl9z13ck2eidLMQKW2dqW4Og1?=
 =?us-ascii?Q?AqkO7Wkl59vNG4u7k3c35Yjs0YTihb3skka5IIwUKjCb3qtOEo4uEDly1dBA?=
 =?us-ascii?Q?vZF4PuXN7xlWIcQiHBM+Y6rWzN/wW2kcnss7CriEm0QVwX1QR56etD/KYx5W?=
 =?us-ascii?Q?v0HYZU8q5gLYvL3gqg88mIUQ+pZkm+3mG21SgEZn/1mxFpAiG5DSwRUr1bd/?=
 =?us-ascii?Q?Xy3AEZxreEWGSEtVspS46vKmLSyxTW8rxj1Ozo86KJoawZ9EXeXD60GTnWiA?=
 =?us-ascii?Q?4OS/6lg7A3/A3jYSLQGXgOzctn45KK8AoNpmKjQav4qiyzmT1HnkR+59VVCv?=
 =?us-ascii?Q?IpfLycNhS+snavIOAsUxoH7O7/5tY8F/bygd4q1IO9nxrw5fSfKH+gtYPD/s?=
 =?us-ascii?Q?ovMYcAkSxdmULzJYS9gy5Lbj3rO6hNmVzR7MNaSi6UzL+Fk+CC3zx6bxk6Pr?=
 =?us-ascii?Q?nkqfBz8Uoay8Hb0+MOTs4UxEceii6XswSrdeq7vzdhAMirXU/RyiF0LLqTtT?=
 =?us-ascii?Q?zg1u6KWdUsVPOJKFC6PKye/5ZluAVIORgMu2e/3GxpTsLBlRzq6qfnDiP4MV?=
 =?us-ascii?Q?1xAeUWP1FI1liRLPId+aNP4E9WULSLa1jRDofmiBuCNNO2eGQ9pqzbsbYOrh?=
 =?us-ascii?Q?RadSaa93TGe5oIwkJTUnvvE01BnhWFB/yukn//IOcqt6YNsQZFOrVK3B4TwW?=
 =?us-ascii?Q?1DNp08vgjH1ZMhirV7GGmAzDctzFa/ozENxWwHNtF2BRI3FLB5uJm37cMTOc?=
 =?us-ascii?Q?/Qwy4oabvJjx8ydzKN90UakznEo4fdy6DSSKj2Ue/Zgo4ICqykIRcoLWivQY?=
 =?us-ascii?Q?1sxZTn6u9naqLWaMu11FIfq8rGoZ2ukt9Cj0+Sdwp6vBy3GpnJ2MHFnsbzUX?=
 =?us-ascii?Q?huLWwRFSWw21/Hx73zPgxtVPEWY+B2RPN3+P5/WacqyBjQBrKHPGdT2hXSos?=
 =?us-ascii?Q?3K/IKnuAyWmWi0GH2MfooHAz/cjSrm6KXZauRl/BACyAONObt7K9RnNBkNio?=
 =?us-ascii?Q?/UXCtBbPEQF6QOUlCftlQ5ui5ILx0C9w+F5zlu02Shq5oEv0BRUBx91IJqtJ?=
 =?us-ascii?Q?YHH3dX6d+oOCxZ0qq6Eqe5FBIcHjHHl2PvzAxFdXEB25Dc5I6rY7T9lwyJii?=
 =?us-ascii?Q?COKzg/Pg69Dx3nJBNGLFpG0kSBoEKvEmH6FV9YjJGnDhbbDOkKCGvu9o4R0u?=
 =?us-ascii?Q?o/U2YEOYM5JZENccSt+EnAzPu732ypieYur0yXGxSJgDXnxImsJKDzdQqGFf?=
 =?us-ascii?Q?S6gKIF14sYjDMAP3fpa6QhNqEi6tY48ogm4sEHM69xeTvnjFYezTiCluH4Yj?=
 =?us-ascii?Q?oCPLtAMuvUsyhS/H65ZRy0y01+0ggnB8ySWxjSuM82rtUn7q7Bsbbzs5BaQY?=
 =?us-ascii?Q?5Ju7R3gCtmIT2mLLVxIeo73saR6OO550X5iGOFuhfp1B3QfQ1hBTIMXfANFb?=
 =?us-ascii?Q?mHM4r0Dn5xAxjt2NJFVHUe3E1w5ie5t8IzH/L5xa1AIcCP2MqVQBD2mehSOX?=
 =?us-ascii?Q?XIchly5toekjM/0rFs2bL5tebhyLHq441Almw9U04kKxeZbwGDCy9Dzh7HFi?=
 =?us-ascii?Q?10nyPs+Ke6njL6BmSSQx84L08zjWwEQDaUzdOMwir39c6IponjFKN8GSSP36?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pXJby91Cr/XZ1zSVpDgbxDPU7hOig02/ZEAI6CZ1wTthpbZK6EvsqXygsFIN5LSOnJaV32UzFPcY83EUzRLU9YN18GXPVx3/BPMi5OXH39y0it9nm6gIEal6z+5xEkJzEosGTJx3wThT6Ji9bk38vOMh8ellnj7ECuGy4eJlCTCLhCEsltNTAr+fhgH1mNVwlalZwOtBloCGvxNSuRmMVhhjHh1XC/wO2kOOVL7W5T4b9W/rqa8ilTnwdZ36OUSaFvUJ83GAL6cmdwLvNPyphHf1scH5ibUHiXPuO7E1tzpEr/87QpjkviT66dOfTTfGZkxA9dRByKN8JQaRXyIhJdbB0UfAbFE9EL/jF4OxZkyR8QMAaqI1pkPX2ujRqx/ok/VL/ZwZ+zzgYh/iR80WX8S1ln5ZGhzMBx8v8N6s8t6yCjeYDMgbO6MV8xIe298Goa6ehgIZSqAPCerzXubqFCZ8oVf2m/yNur6CgM2kT0hPGaU0Dtblm8iznRHw0bSuiK7HBYv1AKq3QjU3RDylsdhxBuq+2Z8UBACovVZozghORQA3XpZUwwGSwblPYK8MlJqpGU7pLZXoen5MI7HdV2SNxQl3dAxe/4G/02WEOeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e76b849-5a74-4017-07f1-08dc62da2121
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:17.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML4EbKXfKp4HiekFkBo2oJzs1royAEBnQSPMJqDeHqaOLeinDfgfOgy2qhyyOLiH/45jXX+K0+q9/vUdO5muYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-GUID: kzUEw02_L7fTn2fN7F-S2VY4mSS_MU6l
X-Proofpoint-ORIG-GUID: kzUEw02_L7fTn2fN7F-S2VY4mSS_MU6l

Borrowed from:

https://lore.kernel.org/linux-fsdevel/20240213093713.1753368-2-kernel@pankajraghav.com/
(credit given in due course)

We will need to be able to only use a single folio order for buffered
atomic writes, so allow the mapping folio order min and max be set.

We still have the restriction of not being able to support order-1
folios - it will be required to lift this limit at some stage.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_icache.c     | 10 ++++++----
 include/linux/pagemap.h | 20 +++++++++++++-------
 mm/filemap.c            |  8 +++++++-
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8fb5cf0f5a09..6186887bd6ff 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -89,8 +89,9 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
-				    M_IGEO(mp)->min_folio_order);
+	mapping_set_folio_orders(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order,
+				    MAX_PAGECACHE_ORDER);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -325,8 +326,9 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_folio_min_order(inode->i_mapping,
-				    M_IGEO(mp)->min_folio_order);
+	mapping_set_folio_orders(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order,
+				    MAX_PAGECACHE_ORDER);
 	return error;
 }
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fc8eb9c94e9c..c22455fa28a1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -363,9 +363,10 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #endif
 
 /*
- * mapping_set_folio_min_order() - Set the minimum folio order
+ * mapping_set_folio_orders() - Set the minimum and max folio order
  * @mapping: The address_space.
  * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
+ * @max: Maximum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
  *
  * The filesystem should call this function in its inode constructor to
  * indicate which base size of folio the VFS can use to cache the contents
@@ -376,15 +377,20 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * Context: This should not be called while the inode is active as it
  * is non-atomic.
  */
-static inline void mapping_set_folio_min_order(struct address_space *mapping,
-					       unsigned int min)
+
+static inline void mapping_set_folio_orders(struct address_space *mapping,
+					    unsigned int min, unsigned int max)
 {
-	if (min > MAX_PAGECACHE_ORDER)
-		min = MAX_PAGECACHE_ORDER;
+	if (min == 1)
+		min = 2;
+	if (max < min)
+		max = min;
+	if (max > MAX_PAGECACHE_ORDER)
+		max = MAX_PAGECACHE_ORDER;
 
 	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
 			 (min << AS_FOLIO_ORDER_MIN) |
-			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
+			 (max << AS_FOLIO_ORDER_MAX);
 }
 
 /**
@@ -400,7 +406,7 @@ static inline void mapping_set_folio_min_order(struct address_space *mapping,
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	mapping_set_folio_min_order(mapping, 0);
+	mapping_set_folio_orders(mapping, 0, MAX_PAGECACHE_ORDER);
 }
 
 static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index d81530b0aac0..d5effe50ddcb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1898,9 +1898,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
 		unsigned int min_order = mapping_min_folio_order(mapping);
-		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
+		unsigned int max_order = mapping_max_folio_order(mapping);
+		unsigned int order = FGF_GET_ORDER(fgp_flags);
 		int err;
 
+		if (order > max_order)
+			order = max_order;
+		else if (order < min_order)
+			order = max_order;
+
 		index = mapping_align_start_index(mapping, index);
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
-- 
2.31.1


