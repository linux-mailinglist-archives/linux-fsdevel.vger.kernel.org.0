Return-Path: <linux-fsdevel+bounces-23163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F50927DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4081C21DE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DC1422CC;
	Thu,  4 Jul 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAM1V70R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="keDSr4Vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4713BAC2;
	Thu,  4 Jul 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121338; cv=fail; b=dF5PHtVE2T8l45WxRYS+a2Q5hnqnPAMh8uhf1T0tG60uN9jGNsBcKQ9RCZNlD+ujxZNXmSCPQuinRs3pDvce7AbkBtOB6Z/k52y7gb8fBrp198h7R77Y1tAe2Z91hMwpOB7ysrqwaWQ0ruR/sQWDjrXLW5OgEZRoXD3DbveBTjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121338; c=relaxed/simple;
	bh=xYLt7RWsghBHKGbTb+wBTxWeAqJUwgnPfefUwD1bQOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBcG8XVMQIEuQG9ZpR7Uf7B4SLmXsnNP2MxmZK6lzkXrpLNmz09qyljGPhuvAqgSB1AtTkBJyOFYNRPMe6ptfvERmi8+cS3YfSwmMtVyM823kJhtc7YNTRZsE2xIp/je+GLTbqFDjTnjkEn5aqgXwSeFJQ6oKbNSHxJ8LgZU59c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAM1V70R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=keDSr4Vb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DPnHv031070;
	Thu, 4 Jul 2024 19:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=; b=
	WAM1V70R1XOIQONecxINMwl6yx3B32D2hmF5Coux/uHXJuYKjFkqd8zWSn6hZxDH
	jRsSoJzcmUPCN0rJBC9h++1VchLd3el/wvqvwjVYAVboxxW0Tu9Q9F9o0u1vSSej
	gGbzJf9Z6Zj0jh5RhZjGEotmEj+DLzQPFAD4/gbquMtYnQ6dGZ4ZUR69TO9UBL2B
	sN+NWYP22hhGZ7p0au5GVx/m2Nzn++boK00lpvsifZhHWZwD5nIs0ZaB5ILbvUUK
	UNYaw+voW96sV4ameRbUS9czheECSLKOFkyceBnluEMTbs6/G6c6bTSWBVoiJGr6
	vZy9aqSrQJgyDwtbhPMhLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacjufa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464G1rmX010898;
	Thu, 4 Jul 2024 19:28:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qaq0b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7MmbEgYHjQB36ZoNJiJ7bLbuBYot8FpmRvy5sMgbwaSMRA3LcpO3KckoJwQkwVRMmlTgZCRyuerAtX7yhxRTU//aYN0o03WsXT54U6cgZiwMmSPEXixP2HiunUmXpm02odmy2rJItXtAT33CU+DDtZVuAEgVJr2WVE4avXr78X9y8ibm1HLjGPT5gUJatkUSZgShvEzogiYInpgGiXknM2eo2FPaSqBkvKVzqNVQXVq3R9P2ElNSFiV1lHsJ6yJ4nZPp6aHfvrgIMHOJZSs/kmmRv3FLtlaIe5l2aQbGqpSY5wJalrHkKoEm/vpSjqMnx5kkrLRcYSHQs3m7TyPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=;
 b=l0ypVg55fXHF08GhTAH466Hg/PNcnQTex2J5zis0jEU6gprLCcURtvjukNIjbLw6ffn9rt4kn28r1uZq3vbl1IFkfeG46iqL2mD0ursprEm3c4f3+xn0tRTc7RMS3chXYmRZxgcLW69HCTfGx1lrtnjjY2CfxkfjqLQnZ3BDm1D+c92JIkpv/O5qYffoQ4vnIbchekUjlo5TOU2gMD09yX34PkuUVJYk5ZGgEsePQlUL0dH5b0PMzJYRqlQVV4jXzil3ZgvOoYE4UXL/bS4qXOkLytqMhm+aOLK9mfLK1gSNkwujlEFwhvxfkSMWWphdRZ/DkDe2VscGLSN/AjMIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET3SP3AEXqIpLZ6r+0sie53rv47sp8uVeOTnEHk69wE=;
 b=keDSr4Vb+I3uvG8ohczSDZGTmyuIUaXh639+mnBlE+RMxtLSmXE+BjylnTl7RjOVTrpoEIeonS9S2nw+OoSsyClMSyKw1+zd+LNKXq1XmXCPQXzO3889gUotF9oaCIX9OLOuHz7B2SyL2OT6hKpKK6q1koO8JFpwYpB1qsQblZ4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:34 +0000
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
Subject: [PATCH v2 6/7] tools: separate out shared radix-tree components
Date: Thu,  4 Jul 2024 20:28:01 +0100
Message-ID: <98f5264d2cec9ab7d066603981e8c0ad0a8752b4.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eeb181-a8b8-44a6-912d-08dc9c5f7f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UrgolHKa4AGZM3A/AXkqYQPn71Kh9TfL+SsN1Pcv6TRc7OZfUXhGuNrD92Yp?=
 =?us-ascii?Q?hjfbxtRH4uo4oIH2ld9esZgDIKTAGVLIrXitOTc17VD2Er34awqOmRlM39iR?=
 =?us-ascii?Q?aYxIdlaOz/LM4pUHSwWU+C/+CvI7UmWayXS3Y+QHYICaTUMjwebD7A+K6xB3?=
 =?us-ascii?Q?7ubs1uysaTezPCjJu+l8dpSSrUwF45MP9P3VN3JsKd8YTynhtLiiRwIIhnfQ?=
 =?us-ascii?Q?WhmRV4UcFV5KbVYNhAGd5Wc72Khc+SuNmyOLCY89lfz8OYJA3ssuMoldHUKX?=
 =?us-ascii?Q?/jBH5OGYXmf4rhWN3nU9AZyTpP1CgTACUdbqJe6eA79lIwuDXCKy1c2YSg5y?=
 =?us-ascii?Q?fXCyW2SrNZaH+nq4XXmTO9Is9/ANWAz6aMm3N+GeMZAt32ei6AkDb8zBJ38D?=
 =?us-ascii?Q?2RwyuiM0fvvnCFzz0LbacE3187QVQAmC+PrV3FEVc+o8nSShGM3eaURsWE6n?=
 =?us-ascii?Q?WG48+Cqo7iZjif+6whHPBtb4Srl5wgDeCQl2jGrRlOIRQQ7FoMXmMXEZrwZM?=
 =?us-ascii?Q?/VhYvbGYv6EBvMX2vf0NJGQ9ZaY52cPgoO71gr+EOigTiTUTHznuaYAvWVjl?=
 =?us-ascii?Q?w5lO192RGSsffnLW5Qfgj3sFBTV4EH7XYF18nupiiLLFry0Jnu7NMhyDcWQK?=
 =?us-ascii?Q?pf3qNrOPD/KWAAIocpWoTkSOQVwCGZ+0oCh05e961r6CCDim5eNdb7z/lC4M?=
 =?us-ascii?Q?Fg33B0cXT1ptJV0uyz+hRelt6jIOmuljsSEya6PYfdPBIf3EF9zAX9lL+IPJ?=
 =?us-ascii?Q?C8GHVwvhWkWMK2J9TaFrMkRsol9/QOl9v56ccRtZTcF3yh/uoNg71kykWWz1?=
 =?us-ascii?Q?q7Zied795R54j5GAx0WrMmn9QjnIO2JVh2/dWtQAEtpiWpqH6I3G5XAzg5dk?=
 =?us-ascii?Q?TGZvrpUiqMZljqoPsS1KFktW9NuKv3pSvbruQnvWXBIvMCRnslIJW8X+eBjb?=
 =?us-ascii?Q?FfvKfEs/gxFqERkW5O74aBSE5tpOI7C9YZSTRMl5/+/YSZR07TsQDd+eKkin?=
 =?us-ascii?Q?jaXlJvVg1l25Ll/NjSrk9yYe36cYQZdo7CI+BHp63y/85wyeTX026P9JtruW?=
 =?us-ascii?Q?DTCZh1Hahk5SL3jY7/XseyrynfP+Wurp0Rsc/jwY1BKaFzDbO4qDKYvxTdvr?=
 =?us-ascii?Q?0uMToK1teLGQ36b/wR2PAqOS622NyIL5NDJzydcsO1gVHFIHYOCUAbqrNEgh?=
 =?us-ascii?Q?GX+ooG/NviLjv4wC/+5kBAZxU9Nr6NPLAdELMS8roYoTL0n0iNsOYm0dVbPW?=
 =?us-ascii?Q?mZvbnCJDwkiRu5TRBpNitK0c8P3VbUYv4hgR7d7znWfvXUysSrLby+DLbbyc?=
 =?us-ascii?Q?QPiSq0rE5p+d2M6godPOuGSVy08BewuHpFSb1RIoexKo2w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GJ/nbTRaOrMjSHq6nwyqYqJOd8a03FK127Qef2vwgJkE4KR4P40ctvfskHVH?=
 =?us-ascii?Q?sO6I+WglljeeL7ZHLy+lNia2Uh/sgDQfSHhbgdhxgtdRxTL6IQ1HKOrM+9Mo?=
 =?us-ascii?Q?z9UEiIZhL9uDWAF16WTqPBoX+AsTzQ9yRbN8F789VRpMCLfOQWpJaaLKuS/v?=
 =?us-ascii?Q?BDLauj341GD7lFYQy9+alDidjjd4xfcpAIY0msL/6y4kwcuz6p9qIoNVM2Pi?=
 =?us-ascii?Q?9++oexBX2yBg9yDQsyBRnXZ7FGLpFEHYFQ+KK2v9xIPwIavueDivhumM27Tv?=
 =?us-ascii?Q?VOX9XH2+uFLjF8+TO8sxUV4xMFGxqoJNmLl07XuVBTcqJKKpwxCnhUaBPwp1?=
 =?us-ascii?Q?VmMGdAVHdXdQ3r+HTR/uRAfaq8+Yyvu5hsrUFARxSYXwV+3fUEN0FKlcQ2EW?=
 =?us-ascii?Q?NfekAIoMeWWM2apmcq7fHZDC1ODxW9sKcjiNc9PsZawy3aGnqGShGZKe6uxz?=
 =?us-ascii?Q?+PZ6bott7JGMB1CweLBeNdTV6cMOKIixhM1DoK97ydwmPbKly2+5obf2Mq6y?=
 =?us-ascii?Q?2/SHPuyiW6GUzwgUvNKtCyIlNi+/l5DYXGmwZATOotiMC5/urmJl4RTlAlpc?=
 =?us-ascii?Q?HJZWgjNUfecu3Azjf1JzqdU6ugQ34ACBUCXgaDr6SBUt9a6g0vfTbKp0zwQl?=
 =?us-ascii?Q?22mbyrLqu418d86cWgmLcAy2stukfor8m43pYCsInuhhsEQOeOJT2Pgs+QuV?=
 =?us-ascii?Q?rHAUs5CogFpzrXvF6dkg68xJ+Df5rNZnRxXbZv7BvaLUsxmsrZKBR1C4lL4S?=
 =?us-ascii?Q?/KbeqgtO1Xj3YwnkvCsHcmMZutEiLzvL1M54lYMJAD9qN1cMst2tAy0LWYhc?=
 =?us-ascii?Q?F55E87g0VsLz3p8zrfH+OHRMh2OdKtCRBDfVdVRb05eWw00cVgsnHmCASOj1?=
 =?us-ascii?Q?WN/5f/8nMzn3bIOIKH0Fjw+CXM96qbZAxf4vPkaEm3XX8Ihf0w4kSKOFhDhm?=
 =?us-ascii?Q?fPg3QwIJooD9bOuMXWaNwf11UbCc57HbSMSgGFE88bS+v7KrRMWOdnpeI42r?=
 =?us-ascii?Q?KbBqnYN2B1zihQB3JjJGoxl2kn0BLXarry8qsJWN/8dJyz5usGMHIlceGQxh?=
 =?us-ascii?Q?xECOlPyPQiywhdgcU1unUChl2OeghOIwm93/KwudbPkVj9pPw4FscNOYKGW4?=
 =?us-ascii?Q?BOD0ZGHF5Q6F5sshdWlKxMKdpoQDZ2Gl9rHt5OwaS6rWW6C7+6Uok+62bjDx?=
 =?us-ascii?Q?CsprQzvG7fov1IbLCcZzqZGiuRGn7+MyMycMz4m9BYedTUA82G8AlQMkaZNl?=
 =?us-ascii?Q?VGF8RzkwSr0LysCuFl0B+mvhWfj5LhFry2uu0vW/zrcYgxCVzqxCgDZ8CI8X?=
 =?us-ascii?Q?w/tDKOYDzGh/mYaL+rqrnSKSdY1ks4YbAot1L3IWhTWqEhN9X9W/YQItWz8V?=
 =?us-ascii?Q?MnOHWmS5bU5lfpDQfEDHsjerMiZnwvNVwDmLet8fivfg4Ujc7daMvt1MZ3PQ?=
 =?us-ascii?Q?DQCgjKxTRVcH5OIgO1K6lEjx3q3rIyv1ZBzCAMeT0ABYc7FtL4qSoS2fys8k?=
 =?us-ascii?Q?+pPkhfzNZO+1aozeDrgCjtA8yf84SumtgC2STlnWCMuN/pTiL4cRFk1+5kEX?=
 =?us-ascii?Q?2o7ilr30zgp/pFS3fOtQ5HIQhQEXaMN8/rV9dGYD3YWkBZCmyay3A8c+zaKf?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iAHU3qmxNZeU+Tg4wY0YPu69xWwMYBeSgXK6yYrKrn/DEujAjIKKJzJVEU/5bRqQDgixxoGjouWy3k1yyeybzD1pmi7LsuoKAu+reJG/h/n8kZeFbRxlPPPDwHZtJZTs+lV3381u+YgdeIpGa4/4eH38cCaULIroLpWlLDpGg5JHTcAJ+Ph5FPqyWFFr2YYvBMIyPnI+twXnnFztm6g/GaCA8aBioUbEDXt8H+m916kSJPqUAbM6h/fo7MycfOnFK71yHVgr7T/FvgN4VaG55AAmC550as610ynd4jxWPiNsgqY5OZopGQjQBn/pPrkrfLHBAYWvGqKGaDlCJVNxCduFArcviUiUHAQkTVwX9kZDnvNWU4M3b4Fo5T3Y/gvZ3w4QIkEWE5osqF5mvPf5cq0/buLOsBODNYN9NfUMaMJnz30DNXuSNqDRwJdt5nbZP/FVOX9CGFTu/8GBAb4pBZpePlI3h6ap7Ja0EHGhgkqntfC6sMBuMaPEVG7NIaxO1PakNfSiJIGr5Wk/W1kA1LJ1PqJ6Cok3GQsrG9O+DE8UG0mLvt7liY0ANy01ZHtRmlJxaCAhJt1brh4WGO8CNzCv/uq041HhiDEvFF5ctnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eeb181-a8b8-44a6-912d-08dc9c5f7f15
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:34.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDHSBhJzSCoqpRc6i/tYGThjKpRVVsh/Dj/peEtokt/SzAe3V1tyK2ehiFS1EvGdaKRYPxtOxGRZOP4IOky1xHXcBtRd3w0td8KIZxjyCs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040140
X-Proofpoint-GUID: sjdhU7BOT6qbQFdncMavoIixSV30f5G3
X-Proofpoint-ORIG-GUID: sjdhU7BOT6qbQFdncMavoIixSV30f5G3

The core components contained within the radix-tree tests which provide
shims for kernel headers and access to the maple tree are useful for
testing other things, so separate them out and make the radix tree tests
dependent on the shared components.

This lays the groundwork for us to add VMA tests of the newly introduced
vma.c file.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/radix-tree/Makefile             | 68 +++----------------
 tools/testing/radix-tree/maple.c              | 14 +---
 tools/testing/radix-tree/xarray.c             |  9 +--
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
 28 files changed, 147 insertions(+), 78 deletions(-)
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
index f1caf4bcf937..5b53ecf22fc4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,20 +8,8 @@
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
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"
 
diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index f20e12cbbfd4..253208a8541b 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -4,16 +4,9 @@
  * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
  */
 
-#define XA_DEBUG
+#include "xarray-shared.h"
 #include "test.h"
 
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
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


