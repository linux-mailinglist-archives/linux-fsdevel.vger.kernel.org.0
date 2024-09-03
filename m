Return-Path: <linux-fsdevel+bounces-28386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A6996A00D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C05D1C2433D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AF3D967;
	Tue,  3 Sep 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0kHuXvU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AqLRBP0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0B3BB24;
	Tue,  3 Sep 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372716; cv=fail; b=T3Xx35sgBFCW4XvtrXBM4DeoIvRnjN7d0zmCSYjndx0e0z9T7m/lQlF4UrzPf//6FPSC8Bd7AMfR/Z9hLlCdlnX0Uha+TgdMHxP1dr44/klfS5p73SLpjHjC7tVmoTt9LjbMI2Db2LIrmVdWVW/HwmEk1sE8nvUbdt+TR5rJy1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372716; c=relaxed/simple;
	bh=ZnshFd669ypOQNPI2G21WbqGit4x+aLL8CEY0xIAzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i6pQOuh//Ml8QGK2a9dReuK2YsGNAOWu3VaBR+mq4naJTgcPtKMzNR4869ThMS6Dq0RazVinLVrEpufEbPA4P6lv86MljK/3CEdZVCT981hFhyko4G3IlcyDTTdn3yfT5ztfHWvEtmS1rKO7HgWFiaRs1T2Re7V6HGgX3/nRBhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0kHuXvU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AqLRBP0+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fTUE007957;
	Tue, 3 Sep 2024 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1r7/EM0pKhR8GDp
	N4PL0Q5wDrKSceIe9Bo5gBo/Mb90=; b=T0kHuXvUByWfp1Aj+qpkmkuJdf3xRe8
	o6yw2Cl+/E9B7As/F/gIz1MEnnlfdeH9Jt4ep1JSORku2GQA16ccehdIlZlotA1S
	XSlY7pmDNlyc0CcL6YC4Q82OKS0jIULPFAbPI71Uk7SULQTX8rKWZ5R/LzYKVCZT
	DD0CTNpt3vEiwksf7gbEMyf2kRrOAV6SQgk0qFTxSzF8joXLtpl8z0/nTGPKuPc1
	xB/s43w9CXEokcFNuoMCiSCLusVp3C8a5fGbMmB3+l8ykT2lsadDeb+HPYLZBMwJ
	R9ac2A0n+IkIRaqyQl6z+8eeYdTwqLWetS3jiGzGBpelDvOCnV8I1bQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndgvnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 14:11:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483DfrUC001753;
	Tue, 3 Sep 2024 14:11:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmf10e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 14:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8S4PhJGfY3f3wNSrJ9QBaRtHFmB/e2siGO7VCcjHLRX/7yAW0Pvwr2/yIhLCaf4xMH61+cZD77tPBhuf54xMyzhBc+TZg7FjztmSHa5J9OCQCOdaoRHpUMFhFpTe+haAiBrNZl79vk4AbuYxPiV4gZmj1d/0FLrpdkhS04ckZoLr3qokJt3nbhlGL6a5kfVDPxlFKBPlQiW/zPfz90KeWLHN9BC1LzqMBs6wD1VXLsqSxJIPyiRJXLYMr+PW3HbFB08w81UdM0dwj7lQ0jyvosybiPu790kwj5/naWfXv09yG8Yx9tisimhaQh6SlxajOn2WMDmj2hV8eQucqA73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r7/EM0pKhR8GDpN4PL0Q5wDrKSceIe9Bo5gBo/Mb90=;
 b=N2T7PIHD1pjbkQN6ITcGeo6at45+gr2SwxVOX23Z3+bv+efR/Hk6bObG7TNodu9kRGKAALe4ftYOQ8fzfB1/SBlDpJG/z66Hk2WyEXghwjL+EsfACqWf9xAcRtm6R+Z71SJYHhgpp72GHARreGpKvKJdZPpBBsffFi2/wv/b2zPwBq41xmAn0B+B3FzLDTbpO1zCOYmhkq/C/hLDEeGztGKnYoqqv3m8S5MBhpZLXe1qwgrYR/leoRwOyv5SofquZ860S/TxyIqqOYRgTM9wpKO489gmSEKJujB5ipklqmLqKGBYC1VjVzdKz9/LwCmFPAqS6IDvCl4hp5zyY+JzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r7/EM0pKhR8GDpN4PL0Q5wDrKSceIe9Bo5gBo/Mb90=;
 b=AqLRBP0+T1RVHx9lIFCkOphA3uA2ESEqa17j3PTbBYpu5ZgFghwOaEUsfGpAbLpjRmQpUo2d5PwGOXr1PTb9b6w3cc4NinfRSKCA3TtKmiuj7A4GyrPvZ0SQhkPBZ5Ef73qJMlwfVnydJLrVmztCKiHEVq8UBOgN8YOm6ylo/8k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8145.namprd10.prod.outlook.com (2603:10b6:610:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 14:11:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 14:11:41 +0000
Date: Tue, 3 Sep 2024 10:11:38 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 17/26] nfsd: implement server support for
 NFS_LOCALIO_PROGRAM
Message-ID: <ZtcZGoMSnDOsn/+8@tissot.1015granger.net>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-18-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831223755.8569-18-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:610:55::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c6063c-0569-4c5b-148b-08dccc225568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhnBKet8ITcMgSRiG674aNRbksPqMzcS1z1vhZ4H+DcoZ0nIRB1IJH6S3hEq?=
 =?us-ascii?Q?Pv7O222G88nVD7ouuZJ9Z1gMeBHEhumPD/RQtEC3q+qPVVM20jl2R66CWvdF?=
 =?us-ascii?Q?Obw00cSN7WBLVnTIl1Bski+j9zD6SHFnUeRBtMLK4UjqecfRfN1yYIc2sofo?=
 =?us-ascii?Q?/bzkDhin57q3Y42nwONTdj6XpvHrYqQG/8C6c02yg+pnUdau0yN5Pf+1tQ1z?=
 =?us-ascii?Q?1Hl/HCatineCq/YGrjcJPDqpRWd5I4ucR5qGe/LTxNS6o40Oo0UjylO3kb7V?=
 =?us-ascii?Q?SCNeIm4XN0FfgT3/pNlFZshDKxZU/5g8GWW5Qf0EQjhhih//hgzHvRuTwHx9?=
 =?us-ascii?Q?FjFI5uuUFFfGon97CEuPfeLlAE4XKOfvkTL/24yBbOWattEpEx/F+ExtuZkD?=
 =?us-ascii?Q?NSQt4XdTvFsSxfyWMsm+0qh0/5V1pmyr6i/u3f6C7INtIrTuLWoAkZSKuCZX?=
 =?us-ascii?Q?Asb6XPG2FvgE5adzG61qbIT6UKiyWWjqCcN1rijDNkx8aF21DBJ8Q8YhNEYs?=
 =?us-ascii?Q?rPKzN1uTBJGRe5UVN5uYaj6pWfUzLIYxoF7P2vWDZkzRfzKwZW6LBo7pDDBZ?=
 =?us-ascii?Q?iy+jnYMZccyLiRycRzbLdZSvIKmO0nGGimUSuPAeTxo4UDZ3aIiKe74uDCLv?=
 =?us-ascii?Q?tFalAWfa8HwH92XJN7feY8Vu253BNUBzmcywkkuNI4OH+7EBplqWaQlqwKw0?=
 =?us-ascii?Q?z6muNAv5NrsWASfkw5VtvKh9JHGOTDVOkETIJeyQbI777WHOLcLR3O92DnWt?=
 =?us-ascii?Q?ZFYsPfWoJsWKTfmmvlh+gifYmYvUje/nLgjZ8/tcCHmp834veUgbua1akntQ?=
 =?us-ascii?Q?Jih9J3RKEKv3CUx33FqPOfZilbj72K5ywKZ6GpLzFuUXPEfFnuraOrMgnitT?=
 =?us-ascii?Q?DcvHvMy9iX2omUmwsdBSaMu6MteCjIE/25gU+QzKgrfwyemEHy78bRMYzZYp?=
 =?us-ascii?Q?mBLI8NzFFK5W5JXU0+3/mpGAVt1LfNGUCYUTcDN1sTZ+qunQJiWLjcTxUaMw?=
 =?us-ascii?Q?bk/iyG+BU3LBPNguRbeZR7LcLbp/iQOLTdmRjShWmkySukWlwmrIbWekvWhx?=
 =?us-ascii?Q?fq/8mLp3Dc+2piWcXVntToU+hu3g1KrkOjfzRLu42TcWEBEB58qjhIfRTBd7?=
 =?us-ascii?Q?/y/cncn63ztQYcX8H8kORefDP0CEEamMU4mUcBSlGtDboUtghPib3ogVSfK/?=
 =?us-ascii?Q?mw2SlVA6HmoAh6EU9FhL00FTKoMFeqp/JEfaX2jyQQd9BlRXpYcqzwVCBAAg?=
 =?us-ascii?Q?PL6/hYrYU7cOdwkqyFR9gZI33wOjfBSTpBZft758mCtArfDpsFrkj8q5Dz4+?=
 =?us-ascii?Q?+nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xO5CoJHF3L3/NThsMjHWKzUN4SH5jlDE8l8V0PMjZXYGVVjiW9R8mFtzKQA6?=
 =?us-ascii?Q?6iDfasqYlY8iAuJoZ7qdL6IOLC6RqV1Qo6VNRfjuMzAq5Kf/XiNzxq2BCr/c?=
 =?us-ascii?Q?DX3wBf5bLM/uEvIC+9u8ZuzUTVHqRE7Ox65x3kejWfIiLOjRWA/Q/JsbHFLU?=
 =?us-ascii?Q?ODvYpci5kpuGCjqpftzCJS7aH4X7n7udwibf4Y3tSUs/L6Uz5zlH5/MwuRn/?=
 =?us-ascii?Q?7UuuUfFC6ZWN0CoE2RVXQMNtO7bT2KuTemK6B8xSoOmjqQq5igXKZzJr8YN/?=
 =?us-ascii?Q?EaKeLUipGhcQSgWqdnNHxdOej78fMNUT4/qPVyDh17GmhrFRSUl/X8lz/3YP?=
 =?us-ascii?Q?yTEqFyJMcfhydntS8RyE0VRqrueLF2Mb7zJW9o/D7BB86i2pWNjTLxlGx2Ii?=
 =?us-ascii?Q?xQhwu1AbLfX9N4/DTc0pjFmSpHxO1tLUftPP9aWjDiZhfnAtBZ0ee08vr0Vu?=
 =?us-ascii?Q?u4Iz7YroNLc2kVcBDy/3slhLa2ZLi509DQ3FZI0o5j+Vwob4v9HT9hA8XpTp?=
 =?us-ascii?Q?2S7UD+qgK1jhZn/w82XocEm2sFfwveTFosII1+Ppjpdd7NcwT2ZGmwDH/rJi?=
 =?us-ascii?Q?OloKXd3vh/qLUyZbWzLkQennjfA3D0H4Ol3Tyh67b6IbBAReP5zSZ1N0EHKu?=
 =?us-ascii?Q?DCgQEoJ+aXm7Ye2UChEHPk/7rSw64eLH1tKEBSJ/fhfoH7QCpbeegc3Suy6Q?=
 =?us-ascii?Q?QnIxEmrntR2NQjF2gcQ+NZ3OvbcBG3C5Q46pHcAkk5Df5O25GqSpBZsYm9Vb?=
 =?us-ascii?Q?lZMDFln2QQZMCWbEX6r6euJ3QmU3s/2fwpdCfZm/4YKjj2yjk4YYSCIiKJ0m?=
 =?us-ascii?Q?+hqUeWsgQbXHfXLPHL2ClRELHpsRp4HxNLhkJKt6pdLI5FYNg0K14cgOYmRe?=
 =?us-ascii?Q?j5BhkI8z7g0TfSjOiI815mf2ObeMdhqUk9XYfW65cpfyEHKNf+afeB3zNaNc?=
 =?us-ascii?Q?GnV3MIxwRhOyr7IBh/o5e+NKS2RdFpLHINME957gSgSpvsGmTZsaild7EJzm?=
 =?us-ascii?Q?zqrYjPnN4RKugVFd/4ljMb3bdhgkxOov+/J0Qg0na19hkjhgUMbhunrUFbhZ?=
 =?us-ascii?Q?UjaCIdfQA0ohfGNQp4ZT5NEYeFqbRRupiGcXAooWYtSJPjCQ45utpdZSmNh7?=
 =?us-ascii?Q?MyuOAf7Hv877I0EZT/b4dyQrs9rY/4nhxoWEpwbj2Eyt/JdGTiRj4QB5feJS?=
 =?us-ascii?Q?nzKnaIUxyBHZlH6SSzLIbjLVZ2LuQsbYKJwK9y+Pyd8N8234Osj8UUyMRYwL?=
 =?us-ascii?Q?bRj9RBCGbKCZYW/kN0pvM82mMBLdI+Gqy8FlvZgupcMga7hcH/LCamtjCG7D?=
 =?us-ascii?Q?uj7g3F9NVZ0J1uf51/2bNJLXef7f0LtGd7hC+4Vd5udpembQ0WQSwdXo0qTY?=
 =?us-ascii?Q?oS5IDblBiNBLwOnfidJr8DJ0VwGxK9kwUpc+cWuXpOW6SNOgD2+kABhIuGo/?=
 =?us-ascii?Q?wI++lXcg1nqlJngEP3V5/lNnw04gNiSi/n26grKO7of22CpYzZWs3Lekcm37?=
 =?us-ascii?Q?qsF2VLAGDEAEk+lrT5qdULIa2Zqj4qvRMMX6qMzWiSLsU8VAYFnG0eeflSVy?=
 =?us-ascii?Q?4bEl46Vxhldw5Q72rKyfU41Dg5Vs+E8/7VK2cerKybw2NdSwoZn0aQ1biDwb?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FEOvNTMjilkDwnE02fiznAKkDUF/zaCK23YXugOzkwqir1kw83wtvoKDNLxuhT4byuT4s9J5VS/6id0p5sf7BBW63Wmob+Af7pAf4VMqwteKN2dRzUQ5e3ZYdkxybDG9kLfufrOLEs3E7Xjt1YxwRGR5FJqc3hHQ2QRFmQTeBvdBjo47Qbcxr3JY6u7gh9WatDIq+tXppEVW2yCzt/+bD6/xPyA+oT+skfd/rG8nPgroqWIuR6xXIW8+t99xwItQr4gE+AeMehEVL8V783TYd3N/OFswGvILpAApm+jv7YjJdAGGWvUF7f77UQ90scwsVc/AX2O4c92AhM4siHyxMZ3gezhEbsgQvtRd4eNqfS2mzB3csWnHWxz9eo1DYYDCquwjGnNO3xs/Mg01rQX7vQCfWlgOXyfefS2I8LiyewoEcbQtva67Y+XPot5MXAsh43H6rSbeJTaNJeYIJO0ueJ+F2rhjJ4GAzMs57vY+sPDJkGzKIMi7V3KSclTKGZij68Uh7v6jHxwp4AhVeecZC4y6gup7MAALHXOKoj7wuppYqorOyOZAjNdTFfAP2g2ObKnlJUcSLO0Bz6/2gIxQLfqXYV+JSOWiUBO9rEkFIMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c6063c-0569-4c5b-148b-08dccc225568
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 14:11:41.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1oCmUKep5EcPdXsN1JdGHj+A6+8EomNywarDuq4nRD74AaGjVx1T0Pd/qYIUuw4IwUHKaylivp+rWuyfVeYkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=591 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030115
X-Proofpoint-GUID: qT3047wzykAASEz3SAHh1g-8BSGUG8dU
X-Proofpoint-ORIG-GUID: qT3047wzykAASEz3SAHh1g-8BSGUG8dU

On Sat, Aug 31, 2024 at 06:37:37PM -0400, Mike Snitzer wrote:
> The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
> RPC method that allows the Linux NFS client to verify the local Linux
> NFS server can see the nonce (single-use UUID) the client generated and
> made available in nfs_common.  The server expects this protocol to use
> the same transport as NFS and NFSACL for its RPCs.  This protocol
> isn't part of an IETF standard, nor does it need to be considering it
> is Linux-to-Linux auxiliary RPC protocol that amounts to an
> implementation detail.
> 
> The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
> the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
> XDR methods are used instead of the less efficient variable sized
> methods.
> 
> The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
> by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
> Linux Kernel Organization       400122  nfslocalio
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>

v15 LGTM.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

