Return-Path: <linux-fsdevel+bounces-36479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7D9E3EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0202B34D52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F620C47B;
	Wed,  4 Dec 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmJgTe8D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lnac9kzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77E768FD;
	Wed,  4 Dec 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327170; cv=fail; b=CHnwRs8bixq+/LGSxn/kDudfz+wj6Aa2PMfRoy0V3cxysGiKygXQZagzb8KIILwitCP3DnOyds72V24zCG5tAZb5FswDhGFwkKU0xLDgUJakO0s4iHlEggQl5JLpo8rjWdUBXMgQKMGt4wq0jRFo+iN3LzN2jNNx2pg7gl9Bu8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327170; c=relaxed/simple;
	bh=IG8zEzvVJ58x3UlLBlQUl3+ZajjOO4FSK+0YxF1RCzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfxCsmb8aO/dZxWylQBZGosLXkSrGZchfvJBhoVxuLIAoVssDZtABUK3N5vSXTToJ4F3VsD9xYGjqhB/7XgxsYXua6NNo/6G08+NV9sZNxKj5wQdjBLhmPG9n74c/tFPJgeGf2/YR2PRKU8Re52l06LKBbWRCjyOPfBSEjupcto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmJgTe8D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lnac9kzp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0sqG019635;
	Wed, 4 Dec 2024 15:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DsvA5YiNAR4qoFiO4amqKKlothOgSUZZjakxIEcb2Uc=; b=
	YmJgTe8DHHZHrQf1aC8LzWRL3se/PDeYfYRCdFRuCX0jjvsXZ+sRE3KX41FGA5us
	qiUqdkNfNi7RuqqQOYtnn+AZVa0UELHzSqTzc7ud4LmsWVCHFx3fNiWKdDxQZAQx
	p3lML3kQDwq5nuHkaAablzzedoGyrQ7jTn1sHDZ9S4MptXF70ZhjP1nZBOcXC8wS
	ODwdUkSwSkMkkw1ISpFGSne1CF72miVJbv6ZMp2bZGXAGoVQjmE0unZICNllog8B
	x31FXfSGYGVZwFiM/WrDV2GxovHRnZq00dZspJZ/R8H/qVM+gVdBHIgxf06doroK
	ULODLWnr0IhT7/kX3Cddgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c8qvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4EgVhS036956;
	Wed, 4 Dec 2024 15:43:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5a3u48-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 15:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmXoPYFTSGjJieJWKSD84yEvv46AV2+EHpNHLOEb8TNKWzM2cihfNU7IkmjZH75A1Hwy7sQrvAkhB3NBobJpNgydbp3P7ITLf3033PPE05ESJNt5aEAJwdfq5xWj+fpOxDEeAEMzPOXMedR1TGD/9Dl3KH1PvKx0dY9frb7+cxCIuJAgwM0cJj+zWmdvQNQB7wDZCNzOi7xJ1ANv+HevOZ2r3ojD0vlcEHqoksW5joeSDC1nqocZ2w1cBKyF7iJWV7++4haEZEXLANXLiSvEnTq8eI6Yc8uNs5+iKUPdwYhg35tm5OFxCzAqvCUAtRTRlnhXrG2sLr1NS7qD6l1pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsvA5YiNAR4qoFiO4amqKKlothOgSUZZjakxIEcb2Uc=;
 b=J9KCtQghocwHwkpqQ2XQJOwivCp4YI6gvfga/5DmrLFG1M0CUZot0vG7N8LWbsaACC8BNECa2ccmPmCtDGb8ep6FPH1kxs+7N2lwrjhWV+jUMLXiLaQ9q2za/XB5omel2qU5plYW9jngAatVHyKkGMSSvMbeWbs2Kb7v8np3b0Ets5yNVWNcyywJJtwmBosB4BCLX81EIk1fJhoanMdgdK9yzVageUfHrZ7mPeQe8+LIHIL+ZapYabNIurjvx+0rzCtKTUePBlEZdLZ46XKQHCpfEJ9TdRJYJnbGVha4+1sSs/GNCU651s8TgNYbhYtqHMcaatZirrFU40hucGoM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsvA5YiNAR4qoFiO4amqKKlothOgSUZZjakxIEcb2Uc=;
 b=lnac9kzp0neNg0l40IxcdSmMHJvDna4kr7xwp72fYvOW8EJCKdoS9CLFhQbOELORo2RjIC1eZJfB2EGxEaYFGK5esXSlAiqkaNtHBMYRQaU2g7561jtPylYrb6LhI7awRKQwAlGReApR762Ib/2oU6dTTyevwgHdF8WZhHutXQc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:43:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:43:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/4] xfs: Add RT atomic write unit max to xfs_mount
Date: Wed,  4 Dec 2024 15:43:43 +0000
Message-Id: <20241204154344.3034362-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241204154344.3034362-1-john.g.garry@oracle.com>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb06169-65d1-486d-d4de-08dd147a7708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baQAOWy3fRrIfrMzQIyFJh/ZF+XpU/M2uJ76N3nIevPcomhd1SugwK0IOE+a?=
 =?us-ascii?Q?vcUyLSaAj9ioH+a6vog4PRf0TPptfy7SbPVqMAQ5qBtrbLVdpRKTaHTV1wmE?=
 =?us-ascii?Q?0ghMvMQJ90f5x3sUeVIQ3w29w2YuTPnMi9C4y5pyi3csJu/KHFncM9Z3QzBg?=
 =?us-ascii?Q?qPt+Pkek6j7teOjEqeLhx3fxwvl2o5UfqRcPOxwndW8Yxge0bLzOYTs1f7xf?=
 =?us-ascii?Q?WvL2NjAAe3k2jwkoBzwfev71+DPQeGQ2Z/q6pjCbUZe67oitpPeob0zxhIZA?=
 =?us-ascii?Q?55VoY54ylk82PBFoNb2NUG9BIy126pBw1anJHwJLKZJvMmYTnxz9B4X5hfh3?=
 =?us-ascii?Q?CBIM6iPo8omzEp1B/6MneUe6/3+Rn7it6sqPDou4ItJMi7xQMA0vO0rp/nY4?=
 =?us-ascii?Q?kA4T6G1yTuduyMg0O9zksmczOjdPEKfPbGI8EJMrg5BQaKs7XqwHomrhZiPO?=
 =?us-ascii?Q?V2oNpKLYArcOv8siuebZ+9haVAc6yBvy73k4A3yjvMUVaxPVHDw7kRoxJ8+1?=
 =?us-ascii?Q?Mb95aBjqrtv5KYjDLzp4aK7hLF5543S+P9c15AuyQNUjEn/sMk51cHvIDdO8?=
 =?us-ascii?Q?iJ/qNffBy+8UTaF9nS9lXoemRsIFENgHZ/WtP+T5AxxTJC5WjiEkaSrTm0rO?=
 =?us-ascii?Q?NVH+IFtAb/YtOfsqjeU7oRLm49vD3SbzPQsb1wgvrpm9bKcCFC8hdElziS7E?=
 =?us-ascii?Q?V3JQHBzxcOiLN6RqpuIxbzdEk/OkjuWIx5ybCzYY0HjCi1/Ug+0ixNoZeVjC?=
 =?us-ascii?Q?xkA6wIItyTjPINAE0J3O6yHMtNnbRCk8+R9i8NelWWs9rSW6jMySDxNTcGwM?=
 =?us-ascii?Q?UEOwjhjpBOU5XcyX5aHpglhIzvQ27aLvKOMqVpKicrBTMCnbYGf0Xp94+3uV?=
 =?us-ascii?Q?j+8aehYicRYYaf96xjO08t/J6dWXMu6Tq1dZpuYeJoRFdSjV7kO4qNzdTU5D?=
 =?us-ascii?Q?xj56sKAl9kdLV27wRuJuRReBJGGTIo0WOEpeccUX1YVu759mPmCurx1nF+yN?=
 =?us-ascii?Q?GiPhzr8OefQYYAoa6lvf6GCUCLXbsb6FOceWJUL9hJBHylmueMzTIG3KifAy?=
 =?us-ascii?Q?0Qg+C+VDcM1t/ABz6DbtWko9EF2H2Vgxk+NSYmHRvassUzaRYVUJ/+Vnd4/U?=
 =?us-ascii?Q?X4yhR77G+BoBm+BXiEamGcQ4JzLNZPcBw9cv8GrsfK22zCcZ/Dx2jkiYxS/y?=
 =?us-ascii?Q?+a7/EH4mOLl5GCXxQYJ1Zk1vyTCynS6il811tkQY6Ol0Uj1bk/95c8kPyDeN?=
 =?us-ascii?Q?weCuchPimNsZFiJ7N8FIQlwaIo6fJEBFMY6j1uSJP6qYgbG7htWaFvUPzYfx?=
 =?us-ascii?Q?jnHiV3QvCRvgUhoktF5ieoBPedsDfvIFl97rkkvKMbLcwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LgpF/QM4Rt3PGuxkK6I1IvX/XlaMuNNkgucAtQIg2P3Ay3Ccosm1LSDrjxiR?=
 =?us-ascii?Q?g0yBV97bVAc+wyAJhONCzG6Cwy+G+BvJJpz1/lfZyHGQxPlFYKt7q3IE1zqx?=
 =?us-ascii?Q?fDf/X+AsUubxWAHPoTBvzFBntapx+YUIRpNFj4NkJdfFXxmpBDy38BdzapT2?=
 =?us-ascii?Q?S6aSj178lUEW3PA0XkAfInuqr5Aci5c1M0RWZkmjnt2/TULdT9KpxNMhyfh2?=
 =?us-ascii?Q?8icHcl+oIfiT4JJmz/fDBbRkWFcm5d5uXQCC8mZmn0F3ogK1RgA/H+DLFcfQ?=
 =?us-ascii?Q?YWMUDURxQKTqulKfuqsZAlFK3c9NU5g7kTjDGczWoyQgfnEy/n4NuvtI7+67?=
 =?us-ascii?Q?0ImBW+yVctnprn4M+Kl929t6oTcV16gm88AAoC87dZVyvHLKpI8HNn340M/r?=
 =?us-ascii?Q?GQRBjQV28pRRmCbRSXh8PANM9J76kcnCTcoUf/KbHDf2qSXXoGqKg5BADe0I?=
 =?us-ascii?Q?eAm1ixLRpxJvfwJzB3oMhlvL2U6LwoiCO6jemA40upqH71Tl/ukQz7NWEK4+?=
 =?us-ascii?Q?z4vnkLZ09T4ugxVTApInw87xMFljuoB1WX63xYuVNYujo6xoGOoon+R67TUH?=
 =?us-ascii?Q?5aQGrtUY9E54agFQ6CaqG6xHcaH/qWkOCDg6lEr1hcwf3PBK+5uf4kllercS?=
 =?us-ascii?Q?e7SoW5VqYzeeXp2h/URXjRL0Zv9VhBWIwXVbUVOO0L/RnGFyA5MFkNHWuHWw?=
 =?us-ascii?Q?EsEmCHifsLgmw5fBm2oBto2Xo95bmK6TkvtZM6R8zA84RNQPaGap6DbreqR5?=
 =?us-ascii?Q?NxkQ5/+0ES3oemhKBvaEDCH91KBDJDeLCXlj+zJwVQ6dsUfOGRAVRX3zyjOX?=
 =?us-ascii?Q?0TUaUQt2A6vSS61tyGVbvU6Ipu6TxYZXqu9UC1lWvsretHX8RuYtT+GwsWo2?=
 =?us-ascii?Q?irLZMLCsaddHgivYGNXldgHkCdHa38SSa/Kj+t9UNHpXby4eXCpbAyGckMFt?=
 =?us-ascii?Q?woExMcxFl5aQKzStzwkTbqGCxCxchA6GycyuNcw1WSGh/KHQOvcOfnz9Bh0h?=
 =?us-ascii?Q?r1/EKXjImZGWoUBuz0euASiku3li/Cznd0U+A6VWDD6josykfWDRQ9aqkoHP?=
 =?us-ascii?Q?+ZVMB5kxyMXfpm/nsx7Uq637foFbK5COW1DPUv3y+bNLx6b54J5Wol7ouR/9?=
 =?us-ascii?Q?ZT4Dho+leWgRchL451rOQ1b9uZN84Xh4zO4umi4obNi/96FIYIK5MIX4MOMj?=
 =?us-ascii?Q?9B1V+gw5xpG7bI/+Ey63D+DzcN4QxrBZn6090d4MDxweayX2pcKN016Aj4e6?=
 =?us-ascii?Q?YkhIZR+rcfWehk2FAVGQuZZ3rfkTZN1ZzJWyGfrDXNnkDqWUT+/aLmAbTo+U?=
 =?us-ascii?Q?8bXl8xAYDp9dgi+VwBx8nPfxNmd29hFaG/LLo+q5Ms1z4D/abxxxUu+q9fbM?=
 =?us-ascii?Q?g703LgRGQW2tq149lXATkRDsIzzAmXW0TOZkDj9maHLyWmtEVIl4l/2KTXx4?=
 =?us-ascii?Q?vPH/7VfIuvTAMiYbUtCRNDcCH3LQY/S1qoovt/o/b0bQ5vEjCRWkSFnAwSUo?=
 =?us-ascii?Q?ZzoKrmXwLcmgjT2admrq7CpSe7iH1+HQ1TC4m/y0FrKFhtWFCGAZ0YQ4L7BV?=
 =?us-ascii?Q?md0OeWn/qP17ZT75v4Qyw2rC4BH3yFGXLny/yMr3KBDRQ/G5kv4PHjKgtV+W?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ERrXH/S6TyK2WOxOK+ubfSZPlkXHnofxY5xjBKyAAK5nS2aWoSbqRKizU5qT9kgOtus5ZwVKFvorTm4TzNJU8DRoX7+R402Gf4AFfy023zpHP9sqdQW+qh1u2Fp70Z5Tp3oZeCGWN20AIgGvO6NjHVgD10DPGhpwncO51yF9zTLZmikiKuQqyy/cQfbCQrqmma97cihle7RQLJZ2VE9WWNMzZpWc2+GJkJcAxJrWAFJefeQkmgortpy9r+fsBf9NBFkBLlGcgrswwfX4scrMyZsbgcbQikNipgCIjFoWyOYj5vodyTHboxZvgnGdVwJy/COWVIw6hs1qL62TfyxOULTurHr1UzAGu75/kf3FkOK2kYQxt1yHRhcAyqyd7eW/O8A63WNz99dg3jK/cXNkANv6ASSFnMZBa/lR4CcuznhKRivT3KudUZREtC+29y8xr4VRdfFIuGWcpla/U0gt89+sTwbpMPcPidzxNekJSZE6Ojt2pDvnR7UX6jM47q/mQz5nS/Pub8UyNMTspBnVkdy4qpBtE7r4N0sDI/zV2Gm9X7nWzIODY9ovPeAQP5OjyH17/hxI2VpNOiAV+5aiRa2oI993WsRzktfBakbqdsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb06169-65d1-486d-d4de-08dd147a7708
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:43:57.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHP19JWXas/ddc3aMDy6TeoUgjC7SEYD3CP+JSuJJYwQJfW9XuAAzwm1qE6h6k1PzgdUBBoEVMsn3YQG7NnvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_12,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040120
X-Proofpoint-ORIG-GUID: SbR_RapBIUXqtmqdnAqtZ_tZExnNm-4t
X-Proofpoint-GUID: SbR_RapBIUXqtmqdnAqtZ_tZExnNm-4t

rtvol guarantees alloc unit alignment through rt_extsize. As such, it is
possible to atomically write multiple FS blocks in a rtvol (up to
rt_extsize).

Add a member to xfs_mount to hold the pre-calculated atomic write unit max.

The value in rt_extsize does not need to be a power-of-2, so find the
largest power-of-2 evenly divisible into rt_extsize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_sb.c |  3 +++
 fs/xfs/xfs_mount.h     |  1 +
 fs/xfs/xfs_rtalloc.c   | 25 +++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h   |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e81b240b7158..ca9091bfc075 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtalloc.h"
 #include "xfs_rtbitmap.h"
 #include "xfs_exchrange.h"
 #include "xfs_rtgroup.h"
@@ -1155,6 +1156,8 @@ xfs_sb_mount_rextsize(
 		rgs->blklog = 0;
 		rgs->blkmask = (uint64_t)-1;
 	}
+
+	xfs_rt_awu_update(mp);
 }
 
 /* Update incore sb rt extent size, then recompute the cached rt geometry. */
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index db9dade7d22a..8cd161238893 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -191,6 +191,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	unsigned int            m_rt_awu_max;   /* rt atomic write unit max */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 0cb534d71119..3551f09fd2cb 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -735,6 +735,30 @@ xfs_rtginode_ensure(
 	return xfs_rtginode_create(rtg, type, true);
 }
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp)
+{
+	unsigned int		rsize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
+	unsigned int		awu_max;
+
+	if (is_power_of_2(rsize)) {
+		mp->m_rt_awu_max = rsize;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into sb_rextsize
+	 */
+	awu_max = mp->m_sb.sb_blocksize;
+	while (1) {
+		if (rsize % (awu_max * 2))
+			break;
+		awu_max *= 2;
+	}
+	mp->m_rt_awu_max = awu_max;
+}
+
 static struct xfs_mount *
 xfs_growfs_rt_alloc_fake_mount(
 	const struct xfs_mount	*mp,
@@ -969,6 +993,7 @@ xfs_growfs_rt_bmblock(
 	 */
 	mp->m_rsumlevels = nmp->m_rsumlevels;
 	mp->m_rsumblocks = nmp->m_rsumblocks;
+	mp->m_rt_awu_max = nmp->m_rt_awu_max;
 
 	/*
 	 * Recompute the growfsrt reservation from the new rsumsize.
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 8e2a07b8174b..fcb7bb3df470 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -42,6 +42,10 @@ xfs_growfs_rt(
 	struct xfs_mount	*mp,	/* file system mount structure */
 	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
 
+void
+xfs_rt_awu_update(
+	struct xfs_mount	*mp);
+
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_growfs_rt(mp,in)				(-ENOSYS)
-- 
2.31.1


