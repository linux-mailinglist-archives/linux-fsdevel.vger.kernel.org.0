Return-Path: <linux-fsdevel+bounces-56669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEBB1A818
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CC4E1BB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31B3AC1C;
	Mon,  4 Aug 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PT/u51zY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rb+dVjLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62003286438;
	Mon,  4 Aug 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326061; cv=fail; b=hX7z7I7uT8Lwl9h/msu8HQ2erYZJTvsrirHaJLZnDleEGM5VWd7MiCzQQMTo6JCJvgEmqrAdWNkMKXtsuBmqrFGK+KLZFQuqR3+S0tEiI8He0woVHX20baDRCuGYSsq+p3Ha9sC2xtWGkTAwSxBwvkGM45Zo4mZLfH5IA64wM50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326061; c=relaxed/simple;
	bh=ta5efbdjXdT3yQ3DpTiOdHbfaw2nT6ZLucLkFY8Xaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bCsP8Jcv+7UsbMEItzPVpnx0/thKQaUFtnYMmQgRzS0JllR/UKvcl/nxz7KKf1+mcv0x9RezYliu78qpJlvoMjVpPX4JjHVxubJy2CgFxLh7hKZBDHHhWERhdOoruco6pbLI8SwUt8ua/H+QJrKKsW5yg++DQRl/TQLtQ1Qr9IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PT/u51zY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rb+dVjLM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D7Qi2015840;
	Mon, 4 Aug 2025 16:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PPmYCywvIDnEW3s1W4
	FTZtnyebgPPNRhhVvagH1diXw=; b=PT/u51zY/z5w2kXhxBGyqolDa/B0KwdZ0V
	D2peBOSLcdvs2xt5IoFu23TjP29nx5lF4plK2hdRuM/AIuGXnIHsVZsTXGhPrbTZ
	V5zR5TDRDSI7WdPpR9CdouAl3bUi1B2zD+3tTE72wFEsJ9NwRv0izuBMJonasDGd
	7fI7c6Dqgb1zded2x8QqsjwaT6AJVmq86a0Bt+U7gLQx0gTP1t+KhXOG1EGVd8Mm
	ocVesxSlZG0EV6UQVg03g2br+uJkHAJec4ee5Cl3P5Uzn3a44HBUCn5xT9nzzsYl
	qHVKsn7DhnH4JnPOGlISOIX1T6d7j8cE2everYWnt62e2hqu2bEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994k2y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:46:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574FY258025382;
	Mon, 4 Aug 2025 16:46:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jsnc7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 16:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQySTisnEUd+PgwVcBYc7fgjxFxsKfeBRaQeIdfLs7Bi6IV1gvTeZiRNhBG/mtwppQTr7dxBJaTmDLdxOIdabyQ0HcHrkhYLZbXbtb9+tddpgWFmJ3RxZx/h6a5Todw52QZB+xPF+Fp+6dicW8P6cjdOgdnGeHxsY0OZnDcdbnXdHR8Wy7hOF2NdYj07Qj1UeSGtH9PBFdAhJjZCAN7mf6GQKU1fIHIjBAeoL8TEtpr9niFuTxH8YYneSD3tyFqumJLVGKwbhVWblwDZHzaVWFrPqfksVpY++G38KhSIS91oZ6UzBpTDV/5/I26cM1Iju7+cxAJvm//g+bvLnJIdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPmYCywvIDnEW3s1W4FTZtnyebgPPNRhhVvagH1diXw=;
 b=uviC4Ea1d8fizTo9PPHna2dKeqAOP+mAkVPzzuFnCWzwbFqC3tDLEXEs+SEoytJZL0o3NX/23CBBWaA9ZGQKOlgo70F727GdffREXAPtQfLT5m2D+7z85QnBJRRsxhGxoqz1tSH6PL+sYhoPSDHWWAYFue7fJlzgqU7Korzocsq9Sza7cBOKQpx+hKvXEsJcqY2lbVyCRWYo/bmCxzUKcoYdVSZJblwj/HQU+4ucnsB9fpZzAkRt689Ius2bqC7Tla99tShiNeNGXop3tR5G11hi5QqcfRmojFtx439oQDc2r5hQx+1DLKnYTEofAHIhvjiRuS37Zz7Qq/C253ETGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPmYCywvIDnEW3s1W4FTZtnyebgPPNRhhVvagH1diXw=;
 b=rb+dVjLMI2WGNZgj4/JOLdEB/qUmvoTodaKOnhn6Yk97dgkn213q4S7Dd+cuJx74DOE/IPlkT6Zg6QHtTZSfuO/LwF+7GsM746B3RPHJh0xmYuy5fslbIjAwbzFQ1noxjSY0lsHlXpx/OE/kpY7L5AH1XmLR+rdWsjTThXQ8Zk0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7673.namprd10.prod.outlook.com (2603:10b6:930:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 16:46:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:46:26 +0000
Date: Mon, 4 Aug 2025 17:46:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
        linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
Message-ID: <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804121356.572917-4-kernel@pankajraghav.com>
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: b99af156-af8c-47ef-fd06-08ddd37673ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6p9NX/7yyPZCOo8xEd8xP9v9EzaSn4KLv5ir0asiZwJjysKsjd8hhiPZBxXp?=
 =?us-ascii?Q?+uPke/VOCER+mNDaVWJ9i7fo2yNL9YHhA5qaic7dvyyQo2pEuI2oMQ/FWLA/?=
 =?us-ascii?Q?vEOPNvZWVIUmGpDbsdTBHee1VHeZHnSRmX6Yuc/1yrk3MVoVOUjulMxJweos?=
 =?us-ascii?Q?2pB4mHgDRPeR7c+aidQAG/2tWD0uT/alYwqgksKCGFH41Lkv7+i2kXutUa0O?=
 =?us-ascii?Q?+WaxADSK3fV8CkK/02pI/MTalEx11Ner7p6dW9q6wwliddQ+6P+O4yK2J8uS?=
 =?us-ascii?Q?EC9yMUFf2hLQcTtkjy3dMjoc9N6OsXRgM8IjNzXCnqYsO0+6pqpPrnUVPNi6?=
 =?us-ascii?Q?qdUT6ZPdCMBRS5FLyN8w3+UTC0xOuP6s1PuTOZI+BQ5ZRHVO/AqTmCMsziy+?=
 =?us-ascii?Q?YD0vRv7JJe0kflTm7ocnAKzXrlZC+Qh9gAYwtaSGvX/QRMWSMuWqktePQNO/?=
 =?us-ascii?Q?5k+UlmihOLwmNoaexAouK+zh+dj7IyNKoZFflvbEzs/kZlqPABK6lp6ITmyq?=
 =?us-ascii?Q?gWHi2dqqlHjDekCy9JU864XPM2xsAJTkfholKMTRlqd6QmQCkPIxex137XrC?=
 =?us-ascii?Q?Pc6hJHM3jVMmXNPQ0P3nyCwatV+fFKb+MLptkdINHN96l12LMKj6XjgFce3J?=
 =?us-ascii?Q?5fXYjvz0+VQRtKz1j36JWlWPP0ZZ7axsNNKUE5Eq6KQd1q6bMYHCbTV4kaHF?=
 =?us-ascii?Q?1zrXBQ5Bxd/CjyCtv/nM/4RcgXcnQxog2ZTxSw6ibhu7cHmhXx5JA41vtB6C?=
 =?us-ascii?Q?HIoaTvr0TqeXNpM0ljHmHPNzGyD1kLZf5/hbtIHHZKlcLu+tTMfn7Mly9Hp4?=
 =?us-ascii?Q?B/8+r1fq4PdLVah9vQOeL38F487cOllDDHa8v2qANViO5jFQPfn2F3Jqw11N?=
 =?us-ascii?Q?ReqnvrKI5sp4wq/VcGULRfiZO5lUc1tSsIX6ti3mBMm858aNJEYm40wlDF3H?=
 =?us-ascii?Q?p6pqDLw/1WuS+X3zP9OKSQ2SCRhMYJ26SHvGJF3+hhqOL//5w2Z7cmGnwgxb?=
 =?us-ascii?Q?IXTvhrKXCSZEDEzgAMhfCoQoes4ueEJGJ5QUXRXxkWaFh4JbB6oebL2nwdXn?=
 =?us-ascii?Q?M4S8lwATAa7W4owvfQIWx4JspqELF+GsqZBUUmlVDPcmmd3qIRBTxFrwIVpb?=
 =?us-ascii?Q?/PIp4FKYaN7nY/tP+/2XYKstRKf8XuK1b2vBriyjweQ/hKd9ZfXGQrCVvfID?=
 =?us-ascii?Q?ePkSMWT/c59RGUzvDfmh9OrGvFj+1/fDKS9Xu28EvbfuMA7UnJ3bxRrQ/iaa?=
 =?us-ascii?Q?89uLVa6XgbWUzfg14kyV3hMRL+XP1wPonRrRFT1+NjyvtCspyD+YHuplLUTO?=
 =?us-ascii?Q?4QsF6lPKAqABHyhRWqQsAa5zpldh0PRew82lCsKw4hvz0ZHhxDcjV3Sxn1H/?=
 =?us-ascii?Q?XfC7mkpBXNnVOwZxQZyhqJUSI8XSPQp+unQzIE4A8YRFqneMZB3P57GJMKKa?=
 =?us-ascii?Q?oP0a19tYzDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2dyCoL80drwFi4ktEon9nwMnLI5YVtx/37M90FtE0HpixnYxnrG8NhXOUNv?=
 =?us-ascii?Q?vWzW5bAnFJwzehY8xpuKpxtXWzU1UR/GSmAvijEWJ4qJ4MZJiMmXWM/rjB4X?=
 =?us-ascii?Q?4I9m6VW3NhXuycC0TVMgIptSIStqcU+1HrzyWqsUJt0t5zN+EnkM4oAyBmmP?=
 =?us-ascii?Q?yJ2Ta3j14Jy/1VFdkF6UzTfs+bicdtyo8lCg1iG8JEu/Sz4NuL3KZVFK9PKk?=
 =?us-ascii?Q?M74XxPgUemAOHMJMa5JOABQ7TqJJ6p4iAXZQbyzOk/Bc87pqp/tqxq4uaVZJ?=
 =?us-ascii?Q?RHSXL6SEf0//FprVBSkcvdr9YvEtDFcusw5/bO1MJhiGLcU3JNuDehHkkXbz?=
 =?us-ascii?Q?X5FtoEZAzPDgoRybJqNCGCpKKv5PsRHA72X5f7yEaqHG/4ga357oXbkjSnXx?=
 =?us-ascii?Q?AIZkg4Fj7mDkzuP+MvWL/18TsHr0B6T4sEL+qImwfl7kaxQ5wI63fBBW18ZJ?=
 =?us-ascii?Q?GIsKNtBKZXtpT0k1aOjNwhZMwK4tvnZXIl3TF9X9ZN4xgIGpuz49KsN4sRFW?=
 =?us-ascii?Q?dzRxYPiNsgMttCfWRtpOJiSEe9NvitohNJrKnc1pqCkTkt6vGD85e+7KG3Vp?=
 =?us-ascii?Q?Yg70iMTdMCvtE7/McjshxNuwWjvt/+67h+ImfCHI7i18ZQQeACUbL9YUeKxn?=
 =?us-ascii?Q?7oymy2DT4hZlVn6ZpRiwQmRhyxzoMG1XLiPa40lv8F8XvKx+Rv/+TdtWOudI?=
 =?us-ascii?Q?umCUTD2P7fL6jPeBXe5xEduoExzDrngRGKMOL52Opt1bhHNduSzpf4/mA5mJ?=
 =?us-ascii?Q?ubmAUShpnNCPysuZA6i4k97jUbZlen5JHEtNgi/+fJJxzKIqejHZoAa+Es0U?=
 =?us-ascii?Q?Dx9Yx2jaW9qnLcEsKGCQJgiBOegXuLVOP3mUYDFmEiOEw3bXoVbjGutLhXjw?=
 =?us-ascii?Q?HJqWhO+OkF8m7nWnmrCCRuklCzQEKxvl5M0pKGiZB1dJn6PLgSddutMkY7eM?=
 =?us-ascii?Q?wPokiOy17QTZgzv2MdSsvd91PwiykvtxWQPUjoAyS7QhFwL6szxL59dDeTDP?=
 =?us-ascii?Q?DqHJBeK0vtTF2E2iE9mEDOlhYE/SZKaEOoI2vfVn/MaEeaZq50kG0VmRMGcy?=
 =?us-ascii?Q?O/246a5C7j6ufS3uKf2EkH35MgBh+tKkpPEN6672szht3BuVKukB694P9w7h?=
 =?us-ascii?Q?zpB1nRhP0WnOA09zs3hjX1bqzE02JdFFDZxY9BX6SuIpwPCe1d8i3T5Ejs4R?=
 =?us-ascii?Q?XqtqfxVR468kDjH6SoFtH5OUZhDtTVQbZBMn92/VTZ7rPWNp5LgIXIwrfFnR?=
 =?us-ascii?Q?GlBE2mR3gkSpecNEtJ97AfzdC2vGQ8IPR2PcEVF9Hs/btPysxr/ZQLRWZ8ah?=
 =?us-ascii?Q?wt3NgqeKugZrmODmDq8CceE1VXlikjhCNFj7RQAxo1Ym3X7/TDd4QVb1f5do?=
 =?us-ascii?Q?Cjug7oTlprqH0WnFBOw+KkvbCG/O6dvgClbAPaW47FNdW8Mhe6kHr2tJWiP5?=
 =?us-ascii?Q?WwY21TEOeWDw2yGJaygODCUkQjSceAc45IXrbHmSNY+tfegLUNMLTrwNDHK2?=
 =?us-ascii?Q?nMT93G9HOcDTa62Gm9HZf52xNb1byT0GWGMN8JIZeojbwhQTAHglH8JzbDH6?=
 =?us-ascii?Q?QbiJW79o1yoM06Vj0axyP/AgNjONDjwKBRTsk/6Q8D2oLuE+EKmHpHi+v1wO?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	espB1OBoVsgjUh5Xk35aysaG/JQ1Vx/DhLU/LMHNsEChNJLAo1cn5gHwT/7Qb5qxlqzTGmY75VDqO2RiErYCiyuQzdMMM0imoNJ/rJld5uCrpqLczdutH9+BMswYV2zQnJNzekh1QCLMd0t1D2QxyMoXi1hOP1CgRjk5UTcnfZDlGJCZ+wOvEM/d5fP/ZSo3Fa+OCLWRhtquHi2UIGRmokJKwp+4shyusziuaM8UhjqzzhPNpTjoq0s5mLRDYdO7ESF72Du/T4F+lYxwbd2l19AoXWycS+3HLv0Ychthit42rSzUQ2Sl8ePiEkX2P87jDoZnsUpqI65xTKJ/2USGKn4NRygP3WA4OD/sFxCz59FRcIMBz1MOToDrk9A/rfIgdhjSRpr8EqkbzwPhVWSxPBdk7A26BRS8XnnxwQmKclwvzqzCTjVp+kEK3pZeneO1LaKvn9yBXvi+VTZvc9oFpgZJGlNswpgkqE6hrC12C7a8OjZgktHUheoM3kJVEvi6AqHZajoX2YbZhxP+PLO2dJhuW81eCgWOiUgak47aSC22Nba10LGrke+An/XQqwZg7tZT/JEP7QZtkhL0leBOYpiTw8oeBIynoyonoMEs/ig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99af156-af8c-47ef-fd06-08ddd37673ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:46:26.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WnQ75LXWl4z+xzDJWJnJ1MNOkzu2IWwmraVc375L03wsYjg2ee72x/JKyewG8NWibhl/7hu6x9bNQfwowLOS0/TYQhZOu2bkitafo9+zuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040093
X-Proofpoint-ORIG-GUID: Dk703cVP5Inc8Ufku8UeJHPdTMJa8Cra
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=6890e3e9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=j6MPqDGJ52AK_ATnTbkA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NCBTYWx0ZWRfXxr6IivuYVAUv
 MVqmt4RRSHuxcZNMDRx8rkEIQduZdRelmASQc9B5c/18BwQ2NCNnL/QioE2Mj1Nn8AOEiKdHlu1
 PdsawwLSmwO19uZZLbsX6iv4jGe9hzMKTDdvzlhhCgjadKc+H6WOT75iXdvVD4piqpLJKlAgdEG
 rabXP4vdRyaLwFG3CCEC8OebMfLCgnxOKECRpCeMgOJt06sWX6vrn629jlSqf91Ega+j87WKZS4
 nWTZXL9Ydr+eJNP7pcPBt+v737ERN2v5J/CXUga71lumtH93HjlnIFGyCL+2HrZSQJzh0oIOSa+
 M28l4d+4VMVrDwqpZX451C/c/RPh7rqpIolGvXc7kk0M3T01PJ4iE2DODI1Q1pcbtet9haH+DNB
 RLR9QHdGokd7bba0uReWwNs0P8ef1pxeHr1JWvgfSUtA+xWPJbtzLrXFGcLzrqyMlU3fpPW5
X-Proofpoint-GUID: Dk703cVP5Inc8Ufku8UeJHPdTMJa8Cra

On Mon, Aug 04, 2025 at 02:13:54PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
>
> This concern was raised during the review of adding LBS support to
> XFS[1][2].
>
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main point that came during discussion
> is to have something bigger than zero page as a drop-in replacement.
>
> Add a config option STATIC_HUGE_ZERO_FOLIO that will result in allocating
> the huge zero folio on first request, if not already allocated, and turn
> it static such that it can never get freed. This makes using the
> huge_zero_folio without having to pass any mm struct and does not tie the
> lifetime of the zero folio to anything, making it a drop-in replacement
> for ZERO_PAGE.
>
> If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
> mm_get_huge_zero_folio() will simply return this page instead of
> dynamically allocating a new PMD page.
>
> This option can waste memory in small systems or systems with 64k base
> page size. So make it an opt-in and also add an option from individual
> architecture so that we don't enable this feature for larger base page
> size systems. Only x86 is enabled as a part of this series. Other
> architectures shall be enabled as a follow-up to this series.
>
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  arch/x86/Kconfig        |  1 +
>  include/linux/huge_mm.h | 18 ++++++++++++++++
>  mm/Kconfig              | 21 +++++++++++++++++++
>  mm/huge_memory.c        | 46 ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0ce86e14ab5e..8e2aa1887309 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -153,6 +153,7 @@ config X86
>  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>  	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
>  	select ARCH_HAS_PARANOID_L1D_FLUSH
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select BUILDTIME_TABLE_SORT
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..78ebceb61d0e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>
>  extern struct folio *huge_zero_folio;
>  extern unsigned long huge_zero_pfn;
> +extern atomic_t huge_zero_folio_is_static;

Really don't love having globals like this, please can we have a helper
function that tells you this and not extern it?

Also we're not checking CONFIG_STATIC_HUGE_ZERO_FOLIO but still exposing
this value which a helper function would avoid also.

>
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
> @@ -494,6 +495,18 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>  void mm_put_huge_zero_folio(struct mm_struct *mm);
> +struct folio *__get_static_huge_zero_folio(void);

Why are we declaring a static inline function prototype that we then
implement immediately below?

> +
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +		return NULL;
> +
> +	if (likely(atomic_read(&huge_zero_folio_is_static)))
> +		return huge_zero_folio;
> +
> +	return __get_static_huge_zero_folio();
> +}
>
>  static inline bool thp_migration_supported(void)
>  {
> @@ -685,6 +698,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>  {
>  	return 0;
>  }
> +
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf..366a6d2d771e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARCH_WANTS_THP_SWAP
>  	def_bool n
>
> +config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
> +	def_bool n
> +
> +config STATIC_HUGE_ZERO_FOLIO
> +	bool "Allocate a PMD sized folio for zeroing"
> +	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
> +	help
> +	  Without this config enabled, the huge zero folio is allocated on
> +	  demand and freed under memory pressure once no longer in use.
> +	  To detect remaining users reliably, references to the huge zero folio
> +	  must be tracked precisely, so it is commonly only available for mapping
> +	  it into user page tables.
> +
> +	  With this config enabled, the huge zero folio can also be used
> +	  for other purposes that do not implement precise reference counting:
> +	  it is still allocated on demand, but never freed, allowing for more
> +	  wide-spread use, for example, when performing I/O similar to the
> +	  traditional shared zeropage.
> +
> +	  Not suitable for memory constrained systems.
> +
>  config MM_ID
>  	def_bool n
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff06dee213eb..e117b280b38d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -75,6 +75,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  static bool split_underused_thp = true;
>
>  static atomic_t huge_zero_refcount;
> +atomic_t huge_zero_folio_is_static __read_mostly;
>  struct folio *huge_zero_folio __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>  unsigned long huge_anon_orders_always __read_mostly;
> @@ -266,6 +267,45 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>  		put_huge_zero_folio();
>  }
>
> +#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
> +

Extremely tiny silly nit - there's a blank line below this, but not under the
#endif, let's remove this line.

> +struct folio *__get_static_huge_zero_folio(void)
> +{
> +	static unsigned long fail_count_clear_timer;
> +	static atomic_t huge_zero_static_fail_count __read_mostly;
> +
> +	if (unlikely(!slab_is_available()))
> +		return NULL;
> +
> +	/*
> +	 * If we failed to allocate a huge zero folio, just refrain from
> +	 * trying for one minute before retrying to get a reference again.
> +	 */
> +	if (atomic_read(&huge_zero_static_fail_count) > 1) {
> +		if (time_before(jiffies, fail_count_clear_timer))
> +			return NULL;
> +		atomic_set(&huge_zero_static_fail_count, 0);
> +	}

Yeah I really don't like this. This seems overly complicated and too
fiddly. Also if I want a static PMD, do I want to wait a minute for next
attempt?

Also doing things this way we might end up:

0. Enabling CONFIG_STATIC_HUGE_ZERO_FOLIO
1. Not doing anything that needs a static PMD for a while + get fragmentation.
2. Do something that needs it - oops can't get order-9 page, and waiting 60
   seconds between attempts
3. This is silent so you think you have it switched on but are actually getting
   bad performance.

I appreciate wanting to reuse this code, but we need to find a way to do this
really really early, and get rid of this arbitrary time out. It's very aribtrary
and we have no easy way of tracing how this might behave under workload.

Also we end up pinning an order-9 page either way, so no harm in getting it
first thing?

> +	/*
> +	 * Our raised reference will prevent the shrinker from ever having
> +	 * success.
> +	 */
> +	if (!get_huge_zero_folio()) {
> +		int count = atomic_inc_return(&huge_zero_static_fail_count);
> +
> +		if (count > 1)
> +			fail_count_clear_timer = get_jiffies_64() + 60 * HZ;
> +
> +		return NULL;
> +	}
> +
> +	if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
> +		put_huge_zero_folio();
> +
> +	return huge_zero_folio;
> +}
> +#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
> +
>  static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
>  						  struct shrink_control *sc)
>  {
> @@ -277,7 +317,11 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
>  						 struct shrink_control *sc)
>  {
>  	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
> -		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
> +		struct folio *zero_folio;
> +
> +		if (WARN_ON_ONCE(atomic_read(&huge_zero_folio_is_static)))
> +			return 0;

I don't hugely love these various sets of static variables, I wonder if we could
put them into a helper struct or something, and put these checks into helper
functions?

static bool have_static_huge_zero_folio(void)
{
	return ...;
}

etc.

?

> +		zero_folio = xchg(&huge_zero_folio, NULL);
>  		BUG_ON(zero_folio == NULL);
>  		WRITE_ONCE(huge_zero_pfn, ~0UL);
>  		folio_put(zero_folio);
> --
> 2.49.0
>

Cheers, Lorenzo

