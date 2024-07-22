Return-Path: <linux-fsdevel+bounces-24066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15931938E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42FB28118D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833616D4CB;
	Mon, 22 Jul 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SL85/kKB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TTbstvjo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6516D4C2;
	Mon, 22 Jul 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649085; cv=fail; b=WCfpKb4klzHNJjbcKWMDpn7CXeswfnZ4Wz+r/TyHtdPiKOntW7gcpKd8gqa/qyHn9Dr2bXKRufq65keLmB9sRm+LI3VcML8COFzr4bNTO5J1uqh11B1/CpfBztWKeJREUy/B4pbMTP6rSbLFijFH6Sz6o1DkWQUyEJMcpuvXJjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649085; c=relaxed/simple;
	bh=UlFATJgb5MumwCewH9FPZ3BClSc2GTIwvwLkY1q+HAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3WZfo0imqfURZINuouVHPU8bN9WYFuZsjHBLQqX6mnm3fNgQjaTyxHxAJeIPgVJ/F0+713sNnr6TlvzQpZXAjGWh4/ilNozk5u6ipypjx+tBqfDLSwr6a0Si3vjzAznB3YJguITVUpm4m1KrSTqV0ptBYFjpTKIqzLRcrwWOKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SL85/kKB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TTbstvjo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7d0x3003790;
	Mon, 22 Jul 2024 11:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=tiXL2BSnJ2eFi9a+jvo7Pn5ZVS+nvgS6n2uQsiOqsHg=; b=
	SL85/kKBuaJ3f6RaE5ZyK2XWhFF/hdbvoReXA9GLUSk3GPKy4k3lwVI1/6wLXNBW
	tod8Y++RpjL4Sltuvwve83tKZcvlefydWzpuOhIsBFowrbDU4sI6KJKUFwXZSpr8
	Y0Rjx0JdAu+IrCu06njsFDg5AHqo7wOVotTQDfI9tsvnSSOywTlIY49/WPepb/OO
	Q7yxmdzZJq4iLyeE49p/lXb8PEwZJ7hKeq8Nd7ZG/hRksomIzW13G9OcLqCGyuxa
	TSftjyTQLP3ZKqL+wv4tOTZJVVDQ+XEwqpbaLoO4aJOsxW+o5cHz5gm2HItZi7lF
	RnV7HHsSojyVwfG+VpYRVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hghchc9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:51:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARUSN023765;
	Mon, 22 Jul 2024 11:51:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h267tw7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGHgWLXDAjaH82pfHxC9IFk4a5y8sdvWleg/6sPkbMEQd44g6X08IFwfPEYE+qTQg+CWz7egnmlvLlZPhEHZcMG53nSqbWGKNB4WOwtWmvNr6SZXR+SLta5lTJ7Xvl20NhYRafkxTTi019JfjHzco7ZmqieQNQhGB7DGDen5aY/3bgpZVqY5PJedvAPY18gBERkb96ZVXYf/odR02thLEalqaCt2yjCUoONUCrkBXNI/QHH9J1Ah/ky/OkRELoQYQp9ajM6IzyCN96ULwQhGtWx5oKw//RpCE/ZScC/3qydpZvPHBPrILuQHDpu8weMpRuTpHmv1WGnjQK5hgjzqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiXL2BSnJ2eFi9a+jvo7Pn5ZVS+nvgS6n2uQsiOqsHg=;
 b=puqrIehDA4ibx7rd/pUIFOBETMN806pFJwy3wWpY3+YlRWHZV4ICmuSxwFAyRl0TM2baGVxAr3D8ouMFh20hq/JOZT4TlSvUoI3k6fJXqGdWEnFVbIPZbuCcbAOvgvyXAX15bchb2TObM75Gqkb1569h8mylHSSnq3my5PZCb73kCb3Bqn2QvdC2vurdbr2QydY/62DymzQ7s0O6dOBooumhq1eCIfvlY6zAD9eMDeQ41bmO4jgewQoppaUSykjZJ2/nG68koZYTvcecnUsadw1OgXrgwt7OeHpWj1lPTErl8vgfpPorC7tzR2Py1P9JuakwcNd8K1PsDx4s3M3VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiXL2BSnJ2eFi9a+jvo7Pn5ZVS+nvgS6n2uQsiOqsHg=;
 b=TTbstvjosPxUbxYDmodtx3mHFChvOwphKrTmodYxXwuHyl80sBUqYQ7THm81zqdCc3TNxyCFvjBTjrAjsCtGXWVbWpOW+cH4JIlkRiiTdpbzCjALIp69gP63rpAZXV0a4y4iXXzA5hGhCVqmA+QBeJ7Jtvvwdib/BPcOEw9a8/Y=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v3 6/7] tools: separate out shared radix-tree components
Date: Mon, 22 Jul 2024 12:50:24 +0100
Message-ID: <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c949227-6c79-4f89-64f9-08dcaa448d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAF1vpU51xxV5wF7uxBZjNt2jmrge4q+idw+B4DAuDxXzzVI8YBCX4xTcD/m?=
 =?us-ascii?Q?s0POpzvm4kI3/x6Vsr9vlnmuljTtPZzCzNMVov6VEHLmVElGLAvkI19DKzb/?=
 =?us-ascii?Q?JlksW8TU8YUHh65dnLwU2WEnf1eq//2FyUq5j8qJwOSfg/vXCznwfLWbVfV2?=
 =?us-ascii?Q?HRv1VoU2oojKcmV5r/5D591PN4KXFmfVhQFelbPH2l7dpDLL8ftoHtzgjx/R?=
 =?us-ascii?Q?EblORzDIty2OzEkHcoOW1UiO9DkZFLwbDSX5f6gl+QC0HdkpvFGadHGWdLrt?=
 =?us-ascii?Q?hgIFRrzrLsOaE7MB8Ja98TycQt0mGyrS93dLwAjKymgVTMDCJTELO78rvXdm?=
 =?us-ascii?Q?4S2A4k1boNalMNvU5YzcIZbImYcZmI0DEFrAAetRaiSNutCcmvnxIM04l8H4?=
 =?us-ascii?Q?/qXtBKqnziKqc1k5y+wsd0y5qis54LE7JPEaMtBntEaI9uglFXCb2xNFjX2B?=
 =?us-ascii?Q?Kl+iKhBPgF5oSqWBmJWaiN9DEwaKBxFVlUciip+GzNy/X4XN73SfUX2Sq/as?=
 =?us-ascii?Q?u+X7Q1xAp8iIfBvpJHC2BKUDHwkx0Cg3Tc9UDMohLMQUfifC59hTDZnhKfej?=
 =?us-ascii?Q?hq9k26VONgKRuPll/NX3+gjxUvC/kKv97S2xxdd+8XPW5E2m0VW7tWdCD/ut?=
 =?us-ascii?Q?d7GaLF35q1OHf1KnTR/Wjb4D2NPFfgsxxAvOkKph81JzM20cnkqNomuc8OEa?=
 =?us-ascii?Q?YVTZ3rB17/zKJzgzEDsfJk9KO83kLc7c8yuLKOqwvtJUMI+IUgoUzQbHKfcT?=
 =?us-ascii?Q?bPGXimFsXovrMtfzINzdrnn4ouX88GeXxbaFc8IeANJilqGYyoGBUvMDGDsx?=
 =?us-ascii?Q?FSRen6u/1oaOFNds+/58sN//qzvIbOoX92J3p7hrVXXYRg9uEwIpqHyBj5So?=
 =?us-ascii?Q?3Jzx0nViRTb/HhD+3MgQnEotVapVlkDfw25AWpfyX3YcQplAMlA5ysV7ZqhQ?=
 =?us-ascii?Q?M1EzJkoV+JkeDRVoEnBFpkFW29Rn8j72aQHvJFS+kSTzMDk0x+Q7eXpLygIt?=
 =?us-ascii?Q?TYj72YyCDCFxCGD6Tl5KEtQgWsKMXezJGZkwWMJ91dm7WalRGaxsqHqdt/vw?=
 =?us-ascii?Q?bOYJoN0LB1AbiwGf7BC/xGjelXOdxb8xVQcnGdtnrlopbU5y3nozjqqXMrQR?=
 =?us-ascii?Q?tSz4uATqJR4fLPuhyj1c5in5QE1KMpoKwksGR7Ewthuvf4vXzrggrlKyRO/n?=
 =?us-ascii?Q?M9KX5gm7lh6/sDq5WAfQG6sz81BeCQhwZcq0/MCXg4lGOzrJf8+zlldq2SDN?=
 =?us-ascii?Q?BQAnyRJxQpS1SztI2il2Wg4mgIUJnKz+YyG0dAbMcJUeEyRmfoL/P1F+5yGx?=
 =?us-ascii?Q?OTE8MQ2bVNOhCQS/ZEK4mYln4Ok0X1OUROGz7OHJaDXQow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGrwphYpee3RALABCRlzUnIS9oYyZVpmxLJRryP/gUSFaQeISmMSrMc3cN6Z?=
 =?us-ascii?Q?bnA90lOCxd8kQ4njobJAMWTosNXVNe80onEvNuALQamAHGv/YgJjh1ixtzM4?=
 =?us-ascii?Q?hvMR80iALlois9sRg2mSB9NIX4FulpNb31sRAqwiUmS5gvXPl17t5v8rXyr4?=
 =?us-ascii?Q?uXFynVR7mSzHTcKXxicewoQylSBw1YDYi2tL/i6PZtG8OLpFfmsId1NZgfm8?=
 =?us-ascii?Q?nNYsdqOlJ07uR4zcxTZtJ9Gfl+5vVfUhDGX1CZfPpt45M6pVyLXvOZupNvbh?=
 =?us-ascii?Q?+pIO/wiI4rZYkSlGPdg3mZC6D6ptRQSwbcWCfDpvAVuEnp6n+4EHqaavdOes?=
 =?us-ascii?Q?lgVPR2ovp/VxkYRx/R18YCJUs6Umjrok3fjKyCazw/BXKa2bdmS8VXipdJx7?=
 =?us-ascii?Q?4ViOyOgvs1TyrumHrjgmobB8OkAr0rwDuQDibvVsgKViJLfo57x9C8sruW4b?=
 =?us-ascii?Q?5Ey0/3fj5/AbmdzBCYiNCFhmwlLClGKSDA5Y8i1oIsYO6gms3MclaOXSSH9S?=
 =?us-ascii?Q?oo76YBbu9a+72eqhQBgffcmEzMzZUaCjuvDZ3w8KSn6UX+L/UPpuHACKIj6A?=
 =?us-ascii?Q?6jwCDQMc8tNA31EgI+8qgbD76aIUh+DolVwJx2txbnHTwxa60cjhnVKoKQc6?=
 =?us-ascii?Q?kZNCqdbE2af+rMhVsjEWRAtU130K+FFm0R8LkaddCxr0O1fff5TWvZONcfIZ?=
 =?us-ascii?Q?TjELOWQX5s0Ti27fh7qCSEq6MF6+aDvj6If+JsiFKijId7hdgkT8Jpp97c9o?=
 =?us-ascii?Q?RhtYZOu/p7OduBsZkhcLqXfUjq6EOmrtvObzhVpw74Qyb2cn9u7jAvOzlN6h?=
 =?us-ascii?Q?47nykyUf5NSfrnGnOoVTDxqysOCfQgpqe+Y8QaXUmDBI4MM1oF0fFYkh/ZFc?=
 =?us-ascii?Q?4QcxZ17WYf3GKo9sLi51+J7+tl7y3wSUDBwJvYBJOn2sCi5RDlytsY89c1bj?=
 =?us-ascii?Q?xSjgJKBiR2Q+Sh+kkIyo+v0MNjP8YAc7Kbkw2detaQpZ8Go+AYctErbfv4ii?=
 =?us-ascii?Q?MZT+G07wImD/wns+VDny+dTB7GSHHZ9uOqSpAAD/+mRChtFPdt63i/vtabzo?=
 =?us-ascii?Q?NW3Zhp1J6+11YkAINKZ2dkMe1iAgK5KcjqD/pPv2Pcs/mUsIZenT+OU/46My?=
 =?us-ascii?Q?Zc94f227m3H4G2tMPO4xdDvVSUYldIPfqw/DTm26vxzf8ZEVou2noxt2nVO7?=
 =?us-ascii?Q?A5XC8y9tILrNDcZKgPVH8LMyJY0MbG8IM/4sqmupDXsuaFT2wiWX2+u5tN9n?=
 =?us-ascii?Q?BeF4BMmEAnpRqjW1kzqW3ZkT0zQlinz7vIeBYVhKEHfDG2Nl1E0RKP2PL3m9?=
 =?us-ascii?Q?vbli3WwUMCD50bXexSnK0XsNfrxGZK5yeV3KPauuaMYzm2Yi5AlyVcD2Oeh9?=
 =?us-ascii?Q?6jB7ToPcbbpaxdeQKFzz4gUFjMjcD70gaB1U/RRu5vjaCMbpkIMNnS1QP4Wh?=
 =?us-ascii?Q?iKkZNHHt99erfAaV40FXct7hUVJGCuGOMW34nyLGo/gSbSiaYlnPtnuoCmgD?=
 =?us-ascii?Q?d5e+5unHxxB25FYzKytJiG5bU/JK0ywTInVDat1D8UK+bKhV+Eubxk8Wy2+Z?=
 =?us-ascii?Q?h+73JoS6in7iQ+8uIrBKk8cYa1OvXbz4XfTo80JlR5yOiO+xQzn8ngkn/7gJ?=
 =?us-ascii?Q?qa6jwrNDM2N/lcAJS9V7BcU/aselsTEB0J0tXLf7pwofonMZbByy4Jsv4l8V?=
 =?us-ascii?Q?b5uF9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FHwCoD82IsztTs67Ajl3VnBBhaLimCHz25eRI9hI7HaK/j6QLEGrmMB44KmdXffHTPqgU+IOggf9JaoyY36vzVa8SNMz1KKcnXnnM9Y9+3jo7O0c9QZ0SwZxPkwWD7SXpJByNq7cNBw8aBuMJdCulYPSRKacGKcvzwHL5CACWtGmGnEuGu+9ijZlWkNVkuPQW3FLn0l79glEvFuTDjwdA/PuKyIP7AKtVCMWr3da82XcpI0bXqgo9OWnQECmtS9frz/F211JHa9AAwiW7wHvy8vlyJ79qVd+1iktdTAtIgbIwZLLV86GjRYnHkF1/0ALoR9O7wBcz/fMaorXw461zSlBB+kHLEXjwfgZXHuLK2jHbSzF9dx83ibhWmqfUOdFkE7u1Wu8WKXY2r+udXxmDYKnN9y0OvJlTFqxckFj5VS5XgIcBRFevbBIIi6441dxvB9lh+I9sXbtUP5MXqiswatL9OzlHdEipXaMqXT5S4sZPl/kZbIPPanVHVxVIAzrzLkfSMlNxclA1ZJIYg+6pKuaYBAaehxVgJguwB1U1UDcSHkYf9DzlzPbjw8VOpltfRtpmD00h0bxL3BI/UH/sLKq9YjVvYb3CRQfKdmmITQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c949227-6c79-4f89-64f9-08dcaa448d33
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:58.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWBee7KwoMmw2ybZ3Hj8lQsSwxg05zJY0b4X/oGnIKrlDhfeVQ3iN5/Q1q7S1iqpvefXCE7zGqcv2BUSYzIWog7iBjDNDW6SCv1UakXYOO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: Kq8Hdjyiqbkavvf3wN3YiLQNv3mB1u9v
X-Proofpoint-ORIG-GUID: Kq8Hdjyiqbkavvf3wN3YiLQNv3mB1u9v

The core components contained within the radix-tree tests which provide
shims for kernel headers and access to the maple tree are useful for
testing other things, so separate them out and make the radix tree tests
dependent on the shared components.

This lays the groundwork for us to add VMA tests of the newly introduced
vma.c file.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/radix-tree/Makefile             | 68 +++----------------
 tools/testing/radix-tree/maple.c              | 15 +---
 tools/testing/radix-tree/xarray.c             | 10 +--
 tools/testing/shared/autoconf.h               |  2 +
 tools/testing/{radix-tree => shared}/bitmap.c |  0
 tools/testing/{radix-tree => shared}/linux.c  |  0
 .../{radix-tree => shared}/linux/bug.h        |  0
 .../{radix-tree => shared}/linux/cpu.h        |  0
 .../{radix-tree => shared}/linux/idr.h        |  0
 .../{radix-tree => shared}/linux/init.h       |  0
 .../{radix-tree => shared}/linux/kconfig.h    |  0
 .../{radix-tree => shared}/linux/kernel.h     |  0
 .../{radix-tree => shared}/linux/kmemleak.h   |  0
 .../{radix-tree => shared}/linux/local_lock.h |  0
 .../{radix-tree => shared}/linux/lockdep.h    |  0
 .../{radix-tree => shared}/linux/maple_tree.h |  0
 .../{radix-tree => shared}/linux/percpu.h     |  0
 .../{radix-tree => shared}/linux/preempt.h    |  0
 .../{radix-tree => shared}/linux/radix-tree.h |  0
 .../{radix-tree => shared}/linux/rcupdate.h   |  0
 .../{radix-tree => shared}/linux/xarray.h     |  0
 tools/testing/shared/maple-shared.h           |  9 +++
 tools/testing/shared/maple-shim.c             |  7 ++
 tools/testing/shared/shared.h                 | 34 ++++++++++
 tools/testing/shared/shared.mk                | 68 +++++++++++++++++++
 .../testing/shared/trace/events/maple_tree.h  |  5 ++
 tools/testing/shared/xarray-shared.c          |  5 ++
 tools/testing/shared/xarray-shared.h          |  4 ++
 28 files changed, 147 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 7527f738b4a1..29d607063749 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,29 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
-	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
-LDFLAGS += -fsanitize=address -fsanitize=undefined
-LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
-			 slab.o maple.o
-OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
-	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
-	 iteration_check_2.o benchmark.o
+.PHONY: default
 
-ifndef SHIFT
-	SHIFT=3
-endif
+default: main
 
-ifeq ($(BUILD), 32)
-	CFLAGS += -m32
-	LDFLAGS += -m32
-LONG_BIT := 32
-endif
+include ../shared/shared.mk
 
-ifndef LONG_BIT
-LONG_BIT := $(shell getconf LONG_BIT)
-endif
+TARGETS = main idr-test multiorder xarray maple
+CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
+OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
+	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
+	iteration_check.o iteration_check_2.o benchmark.o
 
 targets: generated/map-shift.h generated/bit-length.h $(TARGETS)
 
@@ -32,46 +19,13 @@ main:	$(OFILES)
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-xarray: $(CORE_OFILES)
+xarray: $(CORE_OFILES) xarray.o
 
-maple: $(CORE_OFILES)
+maple: $(CORE_OFILES) maple.o
 
 multiorder: multiorder.o $(CORE_OFILES)
 
 clean:
 	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
 
-vpath %.c ../../lib
-
-$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
-	../../include/linux/*.h \
-	../../include/asm/*.h \
-	../../../include/linux/xarray.h \
-	../../../include/linux/maple_tree.h \
-	../../../include/linux/radix-tree.h \
-	../../../lib/radix-tree.h \
-	../../../include/linux/idr.h
-
-radix-tree.c: ../../../lib/radix-tree.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-idr.c: ../../../lib/idr.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
-
-maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
-
-generated/map-shift.h:
-	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
-		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
-				generated/map-shift.h;			\
-	fi
-
-generated/bit-length.h: FORCE
-	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
-		echo "Generating $@";                                        \
-		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
-	fi
-
-FORCE: ;
+$(OFILES): $(SHARED_DEPS) *.h */*.h
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index cd1cf05503b4..5b53ecf22fc4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,21 +8,8 @@
  * difficult to handle in kernel tests.
  */
 
-#define CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_MAPLE_SEARCH
-#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "maple-shared.h"
 #include "test.h"
-#include <stdlib.h>
-#include <time.h>
-#include "linux/init.h"
-
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_DESCRIPTION(X)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"
 
diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index d0e53bff1eb6..253208a8541b 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -4,17 +4,9 @@
  * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
  */
 
-#define XA_DEBUG
+#include "xarray-shared.h"
 #include "test.h"
 
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_DESCRIPTION(X)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
-#include "../../../lib/xarray.c"
 #undef XA_DEBUG
 #include "../../../lib/test_xarray.c"
 
diff --git a/tools/testing/shared/autoconf.h b/tools/testing/shared/autoconf.h
new file mode 100644
index 000000000000..92dc474c349b
--- /dev/null
+++ b/tools/testing/shared/autoconf.h
@@ -0,0 +1,2 @@
+#include "bit-length.h"
+#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/shared/bitmap.c
similarity index 100%
rename from tools/testing/radix-tree/bitmap.c
rename to tools/testing/shared/bitmap.c
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
similarity index 100%
rename from tools/testing/radix-tree/linux.c
rename to tools/testing/shared/linux.c
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
similarity index 100%
rename from tools/testing/radix-tree/linux/bug.h
rename to tools/testing/shared/linux/bug.h
diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/cpu.h
rename to tools/testing/shared/linux/cpu.h
diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
similarity index 100%
rename from tools/testing/radix-tree/linux/idr.h
rename to tools/testing/shared/linux/idr.h
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
similarity index 100%
rename from tools/testing/radix-tree/linux/init.h
rename to tools/testing/shared/linux/init.h
diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kconfig.h
rename to tools/testing/shared/linux/kconfig.h
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kernel.h
rename to tools/testing/shared/linux/kernel.h
diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kmemleak.h
rename to tools/testing/shared/linux/kmemleak.h
diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
similarity index 100%
rename from tools/testing/radix-tree/linux/local_lock.h
rename to tools/testing/shared/linux/local_lock.h
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
similarity index 100%
rename from tools/testing/radix-tree/linux/lockdep.h
rename to tools/testing/shared/linux/lockdep.h
diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/maple_tree.h
rename to tools/testing/shared/linux/maple_tree.h
diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/percpu.h
rename to tools/testing/shared/linux/percpu.h
diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
similarity index 100%
rename from tools/testing/radix-tree/linux/preempt.h
rename to tools/testing/shared/linux/preempt.h
diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/radix-tree.h
rename to tools/testing/shared/linux/radix-tree.h
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
similarity index 100%
rename from tools/testing/radix-tree/linux/rcupdate.h
rename to tools/testing/shared/linux/rcupdate.h
diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
similarity index 100%
rename from tools/testing/radix-tree/linux/xarray.h
rename to tools/testing/shared/linux/xarray.h
diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
new file mode 100644
index 000000000000..3d847edd149d
--- /dev/null
+++ b/tools/testing/shared/maple-shared.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define CONFIG_DEBUG_MAPLE_TREE
+#define CONFIG_MAPLE_SEARCH
+#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "shared.h"
+#include <stdlib.h>
+#include <time.h>
+#include "linux/init.h"
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
new file mode 100644
index 000000000000..640df76f483e
--- /dev/null
+++ b/tools/testing/shared/maple-shim.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Very simple shim around the maple tree. */
+
+#include "maple-shared.h"
+
+#include "../../../lib/maple_tree.c"
diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
new file mode 100644
index 000000000000..495602e60b65
--- /dev/null
+++ b/tools/testing/shared/shared.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+
+#ifndef module_init
+#define module_init(x)
+#endif
+
+#ifndef module_exit
+#define module_exit(x)
+#endif
+
+#ifndef MODULE_AUTHOR
+#define MODULE_AUTHOR(x)
+#endif
+
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
+#endif
+
+#ifndef MODULE_DESCRIPTION
+#define MODULE_DESCRIPTION(x)
+#endif
+
+#ifndef dump_stack
+#define dump_stack()	assert(0)
+#endif
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
new file mode 100644
index 000000000000..6b0226400ed0
--- /dev/null
+++ b/tools/testing/shared/shared.mk
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
+	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
+LDFLAGS += -fsanitize=address -fsanitize=undefined
+LDLIBS += -lpthread -lurcu
+SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o find_bit.o bitmap.o \
+	slab.o
+SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
+	generated/bit-length.h generated/autoconf.h \
+	../../include/linux/*.h \
+	../../include/asm/*.h \
+	../../../include/linux/xarray.h \
+	../../../include/linux/maple_tree.h \
+	../../../include/linux/radix-tree.h \
+	../../../lib/radix-tree.h \
+	../../../include/linux/idr.h
+
+ifndef SHIFT
+	SHIFT=3
+endif
+
+ifeq ($(BUILD), 32)
+	CFLAGS += -m32
+	LDFLAGS += -m32
+LONG_BIT := 32
+endif
+
+ifndef LONG_BIT
+LONG_BIT := $(shell getconf LONG_BIT)
+endif
+
+%.o: ../shared/%.c
+	$(CC) -c $(CFLAGS) $< -o $@
+
+vpath %.c ../../lib
+
+$(SHARED_OFILES): $(SHARED_DEPS)
+
+radix-tree.c: ../../../lib/radix-tree.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+idr.c: ../../../lib/idr.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
+	../../../lib/test_xarray.c
+
+maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
+	../../../lib/test_maple_tree.c
+
+generated/autoconf.h:
+	cp ../shared/autoconf.h generated/autoconf.h
+
+generated/map-shift.h:
+	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
+		echo "Generating $@";                                   \
+		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
+				generated/map-shift.h;                  \
+	fi
+
+generated/bit-length.h: FORCE
+	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
+		echo "Generating $@";                                        \
+		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
+	fi
+
+FORCE: ;
diff --git a/tools/testing/shared/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
new file mode 100644
index 000000000000..97d0e1ddcf08
--- /dev/null
+++ b/tools/testing/shared/trace/events/maple_tree.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define trace_ma_op(a, b) do {} while (0)
+#define trace_ma_read(a, b) do {} while (0)
+#define trace_ma_write(a, b, c, d) do {} while (0)
diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
new file mode 100644
index 000000000000..e90901958dcd
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "xarray-shared.h"
+
+#include "../../../lib/xarray.c"
diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
new file mode 100644
index 000000000000..ac2d16ff53ae
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define XA_DEBUG
+#include "shared.h"
-- 
2.45.2


