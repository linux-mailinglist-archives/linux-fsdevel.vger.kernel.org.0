Return-Path: <linux-fsdevel+bounces-56400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F0B17129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374ED4E346D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F542C158B;
	Thu, 31 Jul 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFvrD86W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QO71dSME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6F2222D8;
	Thu, 31 Jul 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964740; cv=fail; b=ZySHVJ/Ke4Lc1PBnhal22QUuZ4sS3nR1jdrC/CU8BmheJImqWZWRVNMV55pwYAXQc3/0SW8uyUGHKXFpUmb2h+ml1KwGToGgzgO+crnWn2/cXQNDba6pB4W9F+sijlCL9lTkmfjSv0dMVKIS7Bo9Aun18cfMkY4STeA5oUeW8n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964740; c=relaxed/simple;
	bh=1+LJhXK0aQOZRitBvZtQ6TPFQ0n6buVcj48viNpLJYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GeRIayWD1l93ovirgWShs7r1332lq6kbnYmNNmbuuhDAwt0Wn62mnwFpW9jZgIMx53+8AKF3/GI3AgI+c7SFLAA/9IPv3aHEfzrLw3aAvTxG2Hxw2EQcBal/AyjK+FGl37wFZYvqoFKuwo/zWCuKiRQnXhnzH4jEN70UTgjumqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFvrD86W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QO71dSME; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAsTEi011104;
	Thu, 31 Jul 2025 12:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h0SWhqtfrcaK1ogIxI
	pRfQx6NRr1E5X6uaOv8CGePLI=; b=SFvrD86W3RExJFcXuG72c0swKkh2pZ0miJ
	YsV/f6fOzqErIZixg/ybxs4cl4g2SpvnCr0JyakzicLmT36SExC14t24LLk4iRr9
	m4HVq8itigE5G6yin90RwNns9igozmzRUPQuknaPmOh//13eF0/eRDtApApCIYlP
	AMeAPdY3+QeYopBZXKh6bKbzwl3CPWBZ+SVeE1edB6HY5dNB3gKlp3jbdgLUviSB
	lHbkaAi3VBp83+KUo9BmAB4Hlw63xLCZ0TzN8pzikR7o2AB0Y3WaHgYqq0TwUuKw
	KFzha9VkSHuKvV3ak9gO2+YfoFB/mthY2TEsB135NJbi5f8nvPFA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwv1ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:24:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VB5dTB016760;
	Thu, 31 Jul 2025 12:24:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjre75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3jNbolwB6l8SuKospfv+TqxyvD6P0Qr/CxnjT31xiv4manoI4Yyp3nIpDmjOLp6DM6P15/jmbgMcVxVRCIO9x8XwXNNrY8FUVdnKYPFSSbzmpD/JyOLxUiAEwZz4o13SntLiDgSXaPEt0GV6AtxyA4zBXeuG8/nVXJhRksyT4aNt9EvQm/3etKddncqmAc7wjI2ClpVT1mNxSqGrmjA7UwUZUHGXuMg5vXFSncgSI+m6KCWbCcZJAzQIBsKWnsd69ctnCupNvkUaKeXXehiROjj8Glg4uUNJirLemEadkGhB8s9pPQDYIhiTAd4Is1tO12Ev0CsRcxRGoJgAFyXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0SWhqtfrcaK1ogIxIpRfQx6NRr1E5X6uaOv8CGePLI=;
 b=e6VzfOEogHvfa3Xvwy1oVhEAe2ftQgFMDC3EhjWc8L1LbTLrv6N9HAP8X2vAFDrV3X0Ch9HGHBfFFU3oRVPL7HQttFpwk8jHPHFpN2dcAkJMU0D7NtlQbFaWkAaMeY7IFFPIzrskFZbdkCNDjI980BHrFG9IwHryIp8o3BLgwU+f2JSe8jXjMLFXuN1ZKZNOrihRUCrYApj3JNO5PYsIkYl/YfR4XyaKwQ5JOj6VSntrJhte1wc0aswVu/3Ftxjx8vsubqmLvj28tGw7wRNNWlXP9wTjT06UuVK+XFwQMymqpfdAvtGl6ICHsf4Y0cP3IiqoL+sv2iKuwLLzF/G0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0SWhqtfrcaK1ogIxIpRfQx6NRr1E5X6uaOv8CGePLI=;
 b=QO71dSMEUnK/tbqwZ5q0sQGBJn5QqtqM2Y2VNmjBW0jM0iIO+mOWg+ffYQ2lXk4+JqjT/EPmKqd6dR4bz592m/0ylqzoKyTpx+pKfRN1iV7zxM6N0aHqFTj1wEjPOUyjbLTp8uVVo1fC4hkJjmCevJa4LcV+KpfIAqWQ14VVe7c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5710.namprd10.prod.outlook.com (2603:10b6:806:231::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 12:24:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 12:24:26 +0000
Date: Thu, 31 Jul 2025 13:24:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 0/5] prctl: extend PR_SET_THP_DISABLE to only provide
 THPs when advised
Message-ID: <399a8c3a-3966-4430-bb74-f2d2ece99ea9@lucifer.local>
References: <20250731122150.2039342-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731122150.2039342-1-usamaarif642@gmail.com>
X-ClientProxiedBy: AS4P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 49eed22a-4b7b-4b31-fd55-08ddd02d30ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iXwFegQ4rkkMAIqrZyqi/5KjI8OE3+akmikYrcPtMmkoe/QYoYzBWTHlHX5?=
 =?us-ascii?Q?BkWUFS/aVQn3QY27AHb4h1dF39uCpA02zbH7aIdT2+YyLAa4i3DXP4YI7XUQ?=
 =?us-ascii?Q?/BGde8g1GdIqH+uJuSmyZFt7SrxbKBob4sa8Nrk4IoZ8EEp5MfnypqAl85nW?=
 =?us-ascii?Q?oX3duupYvyqcNakiK639DkkVhgBRlxF+poT/VOnRD7VdYC+tQous3TMGLB23?=
 =?us-ascii?Q?5jP1zAhrD2hN6yjWR9CnHq+/73Px885bI+xc+gMDXwVTvjRSnyxvFiGVYD8+?=
 =?us-ascii?Q?s+bZ6Kqvc0XytipBqa46sygmq34gj1beq6joPSGnxe9hpDoDtZX/E+If1Vro?=
 =?us-ascii?Q?OHOlWrJCVUqif8Sdtl81Co6pLBXkhf2UuvCvnpZIUUcH6Eo62/nt0kpB3GiA?=
 =?us-ascii?Q?y05RoAGbYexIuexpCvDbC+UU1SquGjNodNvkv9hI35L+LX8XGqv36soHCeQI?=
 =?us-ascii?Q?7jfU3wvyaiT7Vc7Z1vWz7KIBvtYv4q74bdYJOUWTJkpoCFyBuOJiLovUty9q?=
 =?us-ascii?Q?Ph/aDynwG7dveBqSZgJrXsTW6+Vs3Q9UveQi5n1HYDRDjO42kn++Z8t8QRHW?=
 =?us-ascii?Q?sinJ92SWGWCKHLcz80Fhf6PFdRP3Uw9KP6NnkC2/UA+88r3odBH5XRKLTaOc?=
 =?us-ascii?Q?R3si5ZtA6oSxBIQTtmvYeCiFbZR5bwawjFaW74MfYvKAB2chqHLIDPRveDrb?=
 =?us-ascii?Q?z6SEVOjQziDRwtZ1z6vepbuWoHE4oE+qMRn/FVprQJGQwDvsfyHnxWaypcmq?=
 =?us-ascii?Q?tjxnPWZV32tTAuOtHdke641NdqgfSCBE1iJWWDoFs7ncWUA948FXrjMgYdEr?=
 =?us-ascii?Q?CuGVjxsGSL06Y+IfqW4P1Teu/gkOrx/l0UG4DBvOExkj2TLxawiZCyExoOX3?=
 =?us-ascii?Q?/ELRcZT8QZCCtbcIIeAb+RzMUbtrf3KPg2F9sETiUhaUzZF22eIo2NGg+sFp?=
 =?us-ascii?Q?MgPIPJpBiSftpKy/zEruDmkCp8IcU/WVbR8iPaKLGQGxvsAMU7RrlZq84LMh?=
 =?us-ascii?Q?B9yDzrcQYdZIx3YiC1viFXskGSKsvfFK6+X6wJ98RgpoOQtCJN3Bo0Sup/VM?=
 =?us-ascii?Q?9+W1VJRIt94d5MNpgxRHMMkBMPyeOJM8a4KQCinqBUIDJ6oaQN/6OWz3WlYV?=
 =?us-ascii?Q?I337cJk8sPtA8tYgcmLhpjrncnT3vnmf9XNZ+YOF4WYx6DhG0C1063RU77QE?=
 =?us-ascii?Q?ozr7hwDd+Zswcp8rBgvLww8eaUTUeu/LAjgFRnQINi0w6ytF4XHwjyE7HUvH?=
 =?us-ascii?Q?NDawLkpAw7t7N0RAEw41cjZKyx1WV1DVWR+8nTAxsgR7exzzLGkhH2d/K2AP?=
 =?us-ascii?Q?wcxjBZHhizfNio2S+T2Fp4ZIIGqRbfiS1oClz1+8MYRwfcWLcnr+YMpUP1HS?=
 =?us-ascii?Q?FA+XPwEBidFiziahf5cIpicFFOit6VUkpmyz8y5io6wxJlbvwrHiRDj86Cd+?=
 =?us-ascii?Q?5VeZ9Vws2VI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/PciQm9E+/Y6faDK9gMPMs6wSEOAk+KoUcYnU2Z8jh0TKBI0/qb6QzawBdp?=
 =?us-ascii?Q?HIq6rDWViUa52tv3VCVJ4gF0JCNwKDpuOCQmS07aaQpySPPGbE2/TftYcqIt?=
 =?us-ascii?Q?HrIQxOZVBi3HWYw89aoCZlBZxcyPBk/33Rw3MimyLFNrtUAMnyoA9dBz5cQ3?=
 =?us-ascii?Q?WY6rByKgcW/jiUpOjjO6YydaKtvfnatb/CK2hbjdOBq80Ktz/bewubpd/CeA?=
 =?us-ascii?Q?YRPT4wWYHQ/j1QTKOfZkgMsaecEeabimyvUlDz4cDG/eHG9swtamg0A1tyiE?=
 =?us-ascii?Q?OlUAB1/yKwUt7zNoe3AzlV7FZyFzME8SprRjquSz3FT+HAocs384Xzr2HWWA?=
 =?us-ascii?Q?C6xfU5/pJPqKhwLkg3Ny1YctV3LOTkcduFXrT/Nh5NqQqFnum4Ii17TDp4Mb?=
 =?us-ascii?Q?AGB2444l85PTCZuocfWb59P5rltHaNhb1loTEFNx/uvU3lLoqLPBwacx5+K/?=
 =?us-ascii?Q?jfoU0jle0jMZfoQsP1NvdqIMjjjK9oMo7d8veeE0GXc7vE/e1b2w7PNdpAY2?=
 =?us-ascii?Q?wHRWYqxGnbp1+y9e2Td23cdYg9RIqNzzxpq/i44Q0iOhLXjjNnLriJOhcKHf?=
 =?us-ascii?Q?wRZHZizbU5WHMsvwl2k73pzDSMcrrb8tWwvKOnggNkZLGAR3RhWLteDG6ubw?=
 =?us-ascii?Q?ytshiRwgAClFbUI0/RhW9dZh9nVQQOcH6+Iji/All2MYQBXZL2Rsc52BKI0z?=
 =?us-ascii?Q?PsfrUlqYlisweYRlSEhdSxFMEpytqhknYeQtQE4y1HMr38eVfV3MgJUsfd1H?=
 =?us-ascii?Q?fQQcF2+kd8jAs6nREuCkkJxV6hOBVSlm9jFvCKtSXQ8mmmfEZU1oMvlzbats?=
 =?us-ascii?Q?UsKTO4YkPnQcf99wrvQfQqyxWcE7mhVjHTMY7JteoPL/mjZ+CM1xWbdNLGgB?=
 =?us-ascii?Q?mwQAotGC6ztwSTjV9GYWT0cOwrr2orf6c4d9MCkjG6FbYwXB0oyNEu1UDK23?=
 =?us-ascii?Q?SWzT0n73CNjpdmM8qPeUgpIHJ/15gx0EnvZ94NqvNup5t36iQdz0s0NI63ht?=
 =?us-ascii?Q?5gZgBhXCqr4LmmToYPB9+8XcVq2m3vR8yC/f5IdxLiz+U79Dr3lvX9V2b+20?=
 =?us-ascii?Q?4k0kRDl2KrqXc3zcjtjvItzkkwBCztev6XeNyVsKOzcV2NusKwDrd3L3DzbH?=
 =?us-ascii?Q?9uCITL+BXcGuiqaCv78ekbjssY3l5HhLne1H6n/0K82Jn0XF0W3fpRRi2llj?=
 =?us-ascii?Q?ML/d99ctMpUnXgvP2sFs3WoprMRcHRR9N2wEUEv1PIVB1QA73GUXkEdQ1lSF?=
 =?us-ascii?Q?8crJX5CVdy/4Qy+0EsqjHWjiY5RzsDLjvcDQY0mEzNkACBBKXR9bktiH3zH7?=
 =?us-ascii?Q?Y0KhBSRpfxUGNngbwb007bpm/aUIhW2GjZe03xUWDVVwrBqVnHjW1Y1AOtxm?=
 =?us-ascii?Q?+lkBIbPSkr82XX12OpiY640WBw0xQFQTqoF57clvnTehCnk4/XYFiwO25/s5?=
 =?us-ascii?Q?O2JwarPE2nWCyKotKP5hRJtFw6qzFOwpZ5yclSmEF6QTRBgQ8b2NtEML3Ku0?=
 =?us-ascii?Q?8cJwj0SOiGdS8smDvHZyt5GMm1vlydbj2P/iRNBvnu5L7M++htrY6SgLzFfy?=
 =?us-ascii?Q?p+nMN2/6K2Xg0+YUYnZHy9e2YyZRYhVQ6osEnBynJP2oHJXwu3Iwyac4c+wp?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z9sQy1lpU7S0ULkF7XuFJtTu43IoMsPT57paJo78guv0pVEpqCUgJ7cxiS67U96dvL0F284myb63I2xUotboFm/GeX134VfYz4dXyNDrrsW/20TpNPvG1fA53cy26XQ7Zk3Tl+LhTAGRamUxOp4POoohY8QJdWE0cp1WeDV/ab1QsMRM9+7p+61Dg9cnAuAZ3/ACcApNt1DyrGz9Et8RNtLIwnkuIWMfmqa5SUODT2jCDQEomlUWoPlWhyPLSDNqTMRvqqXXJldCHiRNIphKzuC8nWCRrWyw1bapQPGuuLqc4ueDgFoE3dYTfSOl5ToHSlwaIOXZhwQe84zrlt2+CcK0Z9xKO9ar5IrDl2gF93cCephaUHWFnZPH01KD36Py9ESefghey/a+hDggF/dOurii8MxTgu5QinW8Kn/HsPSxbGYk78I2mITwr8AqaOGRf1t1rXxNZtoAfWTNIU9UEp8U7dTQ6DWrn6vReBoq/nHl4sHV+AScBWqPTmIdGB1R9XMzPqhJJf0xdOmVUyXZ+mG58c9snyWFLq/BAMi7CNDFn/APDQzWHnK4f5JzgI0OCHCAD3BgLeFb5kuRv/brj6hAJVwzXU51mi9LHPhepsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49eed22a-4b7b-4b31-fd55-08ddd02d30ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:24:26.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0pi9dMGNuKfOcDqxY76AwMlpGlwxGJhkp2S0bl63nM5ctyhqqrpRSJcA6Neo/Z5WI+B8xcNDabazxsS7yOC4zpsuy/bGWpVcmQSGCYCM4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=769 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310085
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=688b607f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=TvOrpMxk-KanLZrpPNwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: Er_4tXlkDmZUt9bqlva-rjEOAczp-ttF
X-Proofpoint-ORIG-GUID: Er_4tXlkDmZUt9bqlva-rjEOAczp-ttF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4NSBTYWx0ZWRfX5uQ/TJwo+CoJ
 dwBWbUbxnTw5TcMXfrFzvVSOg7n/PBIkvH6kjx8AVU188ND/8BJPmVdEt9fz60gy27Ouwa8JALi
 OmiOINMLVok8bKinUgJT/eUCs1p5ilIaGMqXguFvR2y6/SbG+xrgtl/4GNGNJNyqRXj3wOKg2uF
 Cg540FSMUULLfaF3EPIwHbyrX4Bsi3z3OfI3ljsNUuODH606WjKA7TBvYXbBGR5qyxAhVFkmrsM
 y34+BrZ8odt1uZxlWJgbSrK3fj4d6ztrArzHcoIVCY494hOTtNN5e8IE3tNslhv1HCs4sR6eNqc
 0joLm3caaB9HY150neUxs1CieCw6Z6OM9FjpDaI/WTzgHxuCUPaotAFVFA1SZCzS5BnC8xdivNg
 oOYAWSwyaUNENgBdGctqzOsnRZq4GxznWQ6ZFu+NdOJYr+8nT06ca8O6kJWV0VOfBUhMvY4r

You forgot the v2, please can you resend this with it, or this will get
mighty confusing.

Thanks!

On Thu, Jul 31, 2025 at 01:18:11PM +0100, Usama Arif wrote:
> This will allow individual processes to opt-out of THP = "always"
> into THP = "madvise", without affecting other workloads on the system.
> This has been extensively discussed on the mailing list and has been
> summarized very well by David in the first patch which also includes
> the links to alternatives, please refer to the first patch commit message
> for the motivation for this series.
>
> Patch 1 adds the PR_THP_DISABLE_EXCEPT_ADVISED flag to implement this, along
> with the MMF changes.
> Patch 2 is a cleanup patch for tva_flags that will allow the forced collapse
> case to be transmitted to vma_thp_disabled (which is done in patch 3).
> Patches 4-5 implement the selftests for PR_SET_THP_DISABLE for completely
> disabling THPs (old behaviour) and only enabling it at advise
> (PR_THP_DISABLE_EXCEPT_ADVISED).
>
> The patches are tested on top of 4ad831303eca6ae518c3b3d86838a2a04b90ec41
> from mm-new.
>
> v1 -> v2: https://lore.kernel.org/all/20250725162258.1043176-1-usamaarif642@gmail.com/
> - Change thp_push_settings to thp_write_settings (David)
> - Add tests for all the system policies for the prctl call (David)
> - Small fixes and cleanups
>
> David Hildenbrand (3):
>   prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
>   mm/huge_memory: convert "tva_flags" to "enum tva_type" for
>     thp_vma_allowable_order*()
>   mm/huge_memory: treat MADV_COLLAPSE as an advise with
>     PR_THP_DISABLE_EXCEPT_ADVISED
>
> Usama Arif (2):
>   selftests: prctl: introduce tests for disabling THPs completely
>   selftests: prctl: introduce tests for disabling THPs except for
>     madvise
>
>  Documentation/filesystems/proc.rst            |   5 +-
>  fs/proc/array.c                               |   2 +-
>  fs/proc/task_mmu.c                            |   4 +-
>  include/linux/huge_mm.h                       |  60 ++-
>  include/linux/mm_types.h                      |  13 +-
>  include/uapi/linux/prctl.h                    |  10 +
>  kernel/sys.c                                  |  59 ++-
>  mm/huge_memory.c                              |  11 +-
>  mm/khugepaged.c                               |  20 +-
>  mm/memory.c                                   |  20 +-
>  mm/shmem.c                                    |   2 +-
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../testing/selftests/mm/prctl_thp_disable.c  | 358 ++++++++++++++++++
>  tools/testing/selftests/mm/thp_settings.c     |   9 +-
>  tools/testing/selftests/mm/thp_settings.h     |   1 +
>  16 files changed, 505 insertions(+), 71 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c
>
> --
> 2.47.3
>

