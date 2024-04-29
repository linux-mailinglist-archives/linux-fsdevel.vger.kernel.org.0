Return-Path: <linux-fsdevel+bounces-18153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDF8B60B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51CF1F24590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9D12E1CA;
	Mon, 29 Apr 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CnNIz5T+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DmC5K2mQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBB12D77D;
	Mon, 29 Apr 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413032; cv=fail; b=sebeFUSnCesq7xsrjfhBDxntYVkl7c3A/Y6MtdDtondvOlwdz3jNcDR73hMTkaTE2/DunwgqaqXjH7rEf9qUxNDhIUwu4sqkl6S5q5LlKBAhdv+w24QZSdzSp1rEc4tQSNpNTf6g5TGKiZSE+cgaK3lnky6c+ETjyGxtMvemmWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413032; c=relaxed/simple;
	bh=EeTN2G9wBb3XanDdpqivJLOdNI7yk+KkK/HbT2rooh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvtwwuJWc2aaIIfahC1nlkwl28mreKIsV5ZMV58sMoxCZAHPy93HrO7dyKmVNPMiBGbVrMmXhZWHRLKecHNGJ9Jhf3RA09tQqPgPwuXQpfTV/Sj9Ucnu1UFHsmn9zaFcU6r7CUoY8SrKBOGbdoaXhClM5I2a2zJ1YGbfC5SsN8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CnNIz5T+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DmC5K2mQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwuJ8030172;
	Mon, 29 Apr 2024 17:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=d5I8ocHWHz6H2pM2fMYDqS7WJ4JA1u36cowT/km52RE=;
 b=CnNIz5T+wkcQqZ38QOb7YPZAJEJygtwwh6nTbPVPOvfoJ6c/ARN1EUfP0FMmoEVZhrFJ
 2hMvqWxaK9eFMYJIBb4qiYxAmDFxdhz2agtReOuONp9Qo27fhTY569iz0b1jFcg3onTZ
 eQFA9+WFKMNuaT7NcxCy1RHZGiotx/SiPqwRMX0T0hCDoU5ecH/o2WyYKtLoCYSVHsRK
 6fE0DBPn9oG2xs98bWfgw6NBerdzQZAk5yVZGXiCuLnMCJixxPQksLxgbY08RYRpDG96
 +UUcRQdYuA2UFPPukE09nHN/JeEa5aERAQngrHDV3ywc0321K9hVLQl0a0oT+8AVYrPf tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryv3673-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGqC8Z016783;
	Mon, 29 Apr 2024 17:48:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpy8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlLsfWdyFuPTiVEAG7pAr0tKZg+d0iHoZQ0D+Ma3pqrnaANcXnHAatVTcUbMAHFmaoORcmgGQgyJdW4CxHDHuSZOY97g/pXD2cUl/rRWS99PO6iyjusabUaA+gruS07SaePpABMQ5g3BOH1JbhH8RBnsAnHhwMhp2KBPXhaEqfXJts31EClW8bRNyiZOTjV0tnU0yQ6RD4gkgVtyK7qrgy1OHKQSRNv4Xk0L0nBfwcVah206SM7ZsWUrhDLHIb+EDp07hdrkYZdX7rO/awL1kvGW5SMOulc4L4yCbxsUeo0hzCNOKwcPWpr2tJx/Ny5BY8VgElOh84yc/Y+fwEPo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5I8ocHWHz6H2pM2fMYDqS7WJ4JA1u36cowT/km52RE=;
 b=JDNTbuEHqWD1DgCRUcVUkMKROyQjIjsCyIurTeieXPspNzOLoLGva8ss8HZvXJcJLWMEpXT5M5M6lDWSsdgnIUozvwvFSIiWOi89TecPmdZuqOSY1o5OW4j2NOZX51qRlBNhIEVdPkKLFwf4HzPxndD81L5HWc0HRR5CS7srGBxEJ0H/RzV41WFYqPybLkzzWott/j4X/KCM46hjFg2//Zav3fESmyqD6QnlJomt0Wiznzb3SMROsy2DZjsUtJeW1FYUbqUnxgxZUPyhURPbmgW2K8ix55p2hEbO/KhPEqpiRFZ+WjwifhjQRePrg058bEWUe+f1x5FszLUofWN5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5I8ocHWHz6H2pM2fMYDqS7WJ4JA1u36cowT/km52RE=;
 b=DmC5K2mQ1Pr2LdmsFryv/O9ot0GzLi/7bQk7qa28bV3Cb4pGxJ0P9Dr1VCsanjcWy3MxPOYVMS7On9RGKZ9G2ZUuVw0nsTY880xc0MbCAQJiN1VE1cvfoy17FZrbjpA6J5lR7erPQkvVQ/F+Mq2vSLKwbYaJmEITtLmOi13kXU0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 16/21] fs: Add FS_XFLAG_ATOMICWRITES flag
Date: Mon, 29 Apr 2024 17:47:41 +0000
Message-Id: <20240429174746.2132161-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7369a2-599c-4aaa-9829-08dc68749b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nV5rRUV3bngPVXRzxeasucEovRC3Ga0HfACic+nP+DSv3Fbljh38tyMR16zA?=
 =?us-ascii?Q?hGxLMqCt1rwCdLOequ4jCeB58gQi4k9Tn9gnIqnnVywFDbcE20FjTOJ8JF0h?=
 =?us-ascii?Q?FPwUKBzaKrijonKj3ASEWTTmVRoSTBp2/Ucsz/D/ualQTzlnqDjAPlrHv6gx?=
 =?us-ascii?Q?rC5OZJyaco/ijk9Nq0ZaSU0KcbPpG//qVFgEjCcr8zxNpCO2Kfu3IVcE7jGG?=
 =?us-ascii?Q?XgGBEaAd+LUIEX8F/AT1hmm8LBFrNMpzXEJ+UCBvTlloaS2hfaj6JwJcZlQC?=
 =?us-ascii?Q?fSM+7sETus8b0lbbQJxGkPNndgDamCN/TuBpt2hOeWtxD+qFjCDPwvxIwM1r?=
 =?us-ascii?Q?AW4bb/9WXzNfI3BzlRIMniiAVKekkLMhd8d3J6k/Zom7Pbm/08UXUNJio1qo?=
 =?us-ascii?Q?hoB/y0wVKyLDZGwZsgns60GdJ6vViEUzjb4zn03IqCJtapy7rvnGRXpvAIMt?=
 =?us-ascii?Q?eIAAZLAclvKFZZ9OTyr5EpGzosb3pI7KEI/PoFQXBypJdApMqoEBGFgOHdyE?=
 =?us-ascii?Q?+kinb9P2heaI7JhR+hkczbyPmFFEBuUx+7aPFAzEkyCMXsclED8z198mMNRU?=
 =?us-ascii?Q?1+/XBb/xbQ3QVpwJ/sb5iQBqGulJL3nE1fREYKO5a+cgvAbaBx52YbYVcnuN?=
 =?us-ascii?Q?A5xJoo9+WJ7Ve69+xKsVkK0uccmWFlldinRiOqSvR5D9q8i809KvdV3IWVBD?=
 =?us-ascii?Q?5NGlalqya84Z4aEKmQu0jx5AE7y/4k66qLltt3og3TVkMIsqRNaeKqfAQuN8?=
 =?us-ascii?Q?Jk4gyUMMXPKQkI38//qN63JBoYHMVrLrQvTcNo1/avUqPluRKWE75/huASDF?=
 =?us-ascii?Q?EC9QU3J3Xj/kTp3++jveJDGQgozoLuJw5outV8xynwsBuM1ON0IvtV4+R6aw?=
 =?us-ascii?Q?Uf5krAQqBEpwit8twO5SMCKUvhhR8BSR1aF+OoJNzWnLQT0uJNZnolPjd88R?=
 =?us-ascii?Q?zfwxwOqoQCGMVByjFjUC/mz8DmWoJWsMWNNCaDXy9+we5n/tls3IP1sM3HQa?=
 =?us-ascii?Q?2wHyNkouPhxmHY+iXWjcCOm8lKQC+wVpEJokaEDpCsO+wzTBU1V9k8gz5RoR?=
 =?us-ascii?Q?6jtqlGLgmcIw62FOqomFmIkAT46LtwpZn4+FDltPCiA7dOISh4FUOAQ8yncC?=
 =?us-ascii?Q?quEswvhvyyHKAuRlDzh1fd95Jrdtz25C7lFOaS06n2qBLWU6vFGtjL/oNMn3?=
 =?us-ascii?Q?OV6cCuSZr0Nj4pdgZa5wM315Q2QdyuxQGy+EoV2TBjgmzhW9VEognA9PMhvm?=
 =?us-ascii?Q?EeGMCAGuOrrZ8jCbZl7A2DVtpQkEBtpNDLeWTvSnYw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KLWCfpJufffSsh6J/NqAo6mysQUnW4KoNWsfAK0Ivc/dlZG+Et2v9hBG/4Lb?=
 =?us-ascii?Q?PJlVW9pZJuAiHJ4C3IX6CZqk1qDX8ha8IsqSqO7Hj9Q3/HO+qieJPXbUeU5/?=
 =?us-ascii?Q?So5JnXz7DqAv6lhSR77MjVzWH3Ks4LJUtBz6cBAN75RvbpXBL9kqhL6PN7+w?=
 =?us-ascii?Q?QZsuz26SglNgDBh4CO8Z2aHIby2qDse1oqwAGZRLLK+sy6E8xFgkg0MdJi6P?=
 =?us-ascii?Q?+bGCEI6AqHB2Sf0Uoc9vCOTEE1bFHGe6YkKq8zkMsp32YvjNXMKrGKKnSRxK?=
 =?us-ascii?Q?mDBalg7kWhOIWuA3Gb/BH/vD/E8xESv4ZHYS4+BUAdXL0LQGQTgrXSTFYUIj?=
 =?us-ascii?Q?SUtlkdJJ3h91BPL/9QAByIEuiSR6BaEdU1llSxPmJLQWvEMt0ES5Vp0Pl1Dx?=
 =?us-ascii?Q?XzMS+AJiMMmvA/da87UiecOnXA58L3K2lwvYjCN/ENih8u5zKSBN5XDvsrYv?=
 =?us-ascii?Q?yX6Pni/xF1AiLMLweQuWjDGHX2rsWsBcuTgsOajfaugeTed9lBtmisiuFcyf?=
 =?us-ascii?Q?3mp5fKu6MaKWH1AmxDyir3ORCDkM2YsPa9or7y0UL5tbdky+j93jtOa4yEse?=
 =?us-ascii?Q?0VaigdM7QP1/am8VFvOH7OASx+sg16yQiB5oA89JO5Boc6eh1kxMw8UlZ5cP?=
 =?us-ascii?Q?vFl4CgNl5YzC1we1miFcM+O67sw6UL4wpZS4A7s441NgfMzaE+RSXH1PZV7+?=
 =?us-ascii?Q?K5QFV9IE2ZlY323LtOZnDyjUCyES0432P6u9tkvEHnLQZVQ98IkkTpUbIPof?=
 =?us-ascii?Q?BVsLh868ig9YIZTwo+hidcFYTvA9XwpCx7YlRu7s5MgZsGca51N0DvAzmna5?=
 =?us-ascii?Q?P14w7fdCPCZsbp2EMZ6i77unPSZl4I4/bQBhDA25Zn0yoqgAEaGIbZr0XXVU?=
 =?us-ascii?Q?mTJMFNSEYK3PG/NjyxG6owaqrl6Mx82kPtQJL+EsoioPREIkbsu+e247oAwZ?=
 =?us-ascii?Q?NrNpYfcgh2rs0dTEi12piAZyfgxKBYGwHJeqGeK0X9jlR+VsjubDt6OE+by4?=
 =?us-ascii?Q?VRKSgHmoOg/+7sbbrPi0SJ7L8E5scroDiLr8V1cJleN2Tq2afhtiPuhs0oNK?=
 =?us-ascii?Q?a5mehaDZoP/DRhkfH4pwAQjstuT2wur8B8ui/NYscv0uILhKmUNUwHdSDt5D?=
 =?us-ascii?Q?k74H9Iv32VPL9pPNd3HmwUtaA8Y4B+zVg832Vk0tO5W+rAVX1E582eNykruj?=
 =?us-ascii?Q?As6xI0aY/G+W65MczbkjbViMB4IIfgkP65Lit2fa6T6FWIgwGoETboarWixp?=
 =?us-ascii?Q?9KIAid0acx8iW00ES1BmMKJFc2UOaPr70ErGLFWhzd/6Bl/b1sQ5Fmss0WXx?=
 =?us-ascii?Q?bKF6T0+BWvlZv8gOaJtzZqvM8EQVj5MqX16B1/rQNROyLw89N3eOCwlXUG8c?=
 =?us-ascii?Q?KpazjQ3STMraEDbTRzp64euxbQw8rnYjKxcdZ4ExHfYNs4TGuPWy7seHpcZF?=
 =?us-ascii?Q?9M6IqTl4QTW4xFo0GcCxl5cyHdt2SjCNk5W68+wF25GoLUVf7dR6XeBkwA9I?=
 =?us-ascii?Q?4geidfU9xLlAD10XqDJAFoVaZvuZAFD3Tnac32df6Ie0Et0zp1rE9u+lh6v+?=
 =?us-ascii?Q?T06lsC+nkxHxXQtfP8Nya4psnxEvTNtjpxjx52Y9hzYHHcenVC0CUVpO+dwj?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GIcK9cLA8nhzwGL0t/W5yzLDcg8/o+aYn2sR221+QFyhsfLt/W53wBnSC9DAI84doIzhuQhtdXPQqMZPA30ZJbWtRAbdbXae8hFFjQTbrj+090CXE+pren0ZxoXT1Fs8EuNWEHNHvyUSMxgSvISgAD2TX++JHH+/DnQGLAa7hGwgp0FBf6WqmFnr5ha3FATMHYcYD8oWEh5Xw6INhrkwlKDGpYMGMIvWPRhclpWmwOzHzJlDevAw+jUmAfK1eZAFtz12NKvEW2bEz1jJqhvGQnF6ggNMxT4FLGiq0OU7+RR3btEvhknCW/rTiUOwuiYgm6HGDK8iWIlFJ2zY8T4mYpJQwzO/QTomKb6fbYy6VOT9xnrKIOPV58uxfPiuq7jYXDTpCNcCVWDCzYKvsbCoripDgcqemcgONTU3Qsxzkt6l5xCbquWkZXwOf8+l7mjivJ5aCtFNacePZ9l87J9caEEsGOS1OH4RiJRa6QNt96whr1F6Z6xFO4AJwLUP/9su53nw9QJl0iLl5PSs+VNSUso+Ab1AY01MnULnedsnbI3gB8CzsXFVl0zQpv8yL1IN9Zpw3JSqQ4CnYK0QwZAzcYgmMJS2GLfOfdmCJ1CIkzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7369a2-599c-4aaa-9829-08dc68749b44
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:41.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1XC+mRlLDQ/RBpCkhjeJwwjthLB4XVcnLfyP2cD9RqjXFGqaj3FsVMXh3HT2zAEAOQuWCcVm4navye8ihFzKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: rIXZWGI222KSaPu5ctNp5PhORGxg4Smf
X-Proofpoint-ORIG-GUID: rIXZWGI222KSaPu5ctNp5PhORGxg4Smf

Add a flag indicating that a regular file is enabled for atomic writes.

This is a file attribute that mirrors an ondisk inode flag.  Actual support
for untorn file writes (for now) depends on both the iflag and the
underlying storage devices, which we can only really check at statx and
pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
the fs that we should try to enable the fsdax IO path on the file (instead
of the regular page cache), but applications have to query STAT_ATTR_DAX
to find out if they really got that IO path.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 6a6bcb53594a..0eae5383a0b4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -160,6 +160,7 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 /* data extent mappings for regular files must be aligned to extent size hint */
 #define FS_XFLAG_FORCEALIGN	0x00020000
+#define FS_XFLAG_ATOMICWRITES	0x00040000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


