Return-Path: <linux-fsdevel+bounces-62109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DEB8416B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9D179974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39A2BEFFE;
	Thu, 18 Sep 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvl9lCBJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ncw+g+pX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031E1DE4C4;
	Thu, 18 Sep 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191390; cv=fail; b=h0fjuIQ+1ozdGZJMnQMlllnVMQSwcSIa7nRAHe1UrnspuzyZJK6woenL0llsqGeEIMO44L1rkpdkMKdhE3nGvb/qjlexrkFgzI0fpKJTmheccM5N4FVWyJtVJ9eMm/kRc1DTQDFpNnCzxbQ4QuyOxW+t3ID9YMrVOphCplhLi1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191390; c=relaxed/simple;
	bh=U04bAa0rnf438gbCh/jEbqaZM0Z68moARNR8hePvy70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rQnstia34fCNxHhbzf8mqMqOP0J7WynXYVhQUWT+TqrACvdUfahK/e/K+MD0aSXpPaBVUatoBGxHZSLrbL66wUTtrE5oglB9UUymLIRA9BhLnV7/FoeF8f2yPlN51FfOxPBkmNZkdObn++L/yFBRSdB2B0Hc4Q/SbDRoifRWvDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvl9lCBJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ncw+g+pX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fx2i025248;
	Thu, 18 Sep 2025 10:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4mCrPKPZUgEgqSPl5f
	HY9ig/tzZ424rgRss6/eKmG4c=; b=hvl9lCBJ7hq+YjRwfv9UfQ+e0TaC6/efm2
	E2dX8v76WVMLLCUZtfE5v8H3vN/xlIWCQvRz4/g8WnVJUx0Q+gCDRnZ37uplDsvu
	Zg3jx9cWUBs/mGHm9Q2CFDb0on/gfASWjB2JygGkV/UbbfcIKHPOYQXNKQvp3y5u
	PeR4Uq3dsUcLl7Ud3IrLqFjHHyOn+q7PON9UxpN/H0UiqsFDdzlMi7KQU6GTuHR8
	Ka2d88Y423N0T3QWaB2ByjR2WZSTVQdU8F7Otq9lw6IXiB8mE2g+J/7gcGQ6CpmO
	iBMcJC+tcvRokypKJa3FnLp9z47h1Bwq39thzv7s7AL8kD4JMkUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb368r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:29:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8K8wF035235;
	Thu, 18 Sep 2025 10:29:18 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2n87x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhy0afjU91+HAtkviH4hjhibSDEeGKbb28YyDjnVcYAjlZg/ut/SsDJsrCuVTUe+OHdfD1qGa0dI8SGEMnGEhdzvfLpBZwf6cknZkJ50S+hqd2AWF/m7wmiCaKkyEEdZByvZZl0fasl+aEZok2ozu+VoV4cu6g3I5OfarnpEpZUW7RePNYmcKZnlXOSWTjUcI2ORgZwEKvkq4GhzPRjvf/lPe/tqcQQAJTOo/917gugv9nTpPHVdl1Kx1w3A0q3YZ66jvKZu0+2pNb2T1kkjxERjzgomiG6wqRzLRBWOXdzgaY7GULGDXctGUgMiMInOh3DALeVmYen5Jn4CVa0Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mCrPKPZUgEgqSPl5fHY9ig/tzZ424rgRss6/eKmG4c=;
 b=o2Dpgu94q80htn2Bjq5myfFpQX4+okbiG6igNuBcaPBbLxNZ49o5cQ16MUYiiFfNsbMbBmZeRiBTRPOgXNCGwlGcJczpj4lNqr3QbApqptmmdkk4NiSKt5pSK0R0tJbKK0fgJL0SPD/EHnbkSQtPD4slrwkBsX7ruROcFZlmvkGYoKYefU5AdTnGmkiafwy7uh5jI+TVxmBzveH1oE1hlOsiagv1PDi/uy+xtXOmGMNE1cnjuWGBJGBMZIhfYTkWhn++qZE/y8+3wlN/iwbdG9Wo+GiU5rAAj/Y2AEtGbi8MKCZD8rwzIUKSHa4EUucWcg6ZovfkfCD6INyDy2sTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mCrPKPZUgEgqSPl5fHY9ig/tzZ424rgRss6/eKmG4c=;
 b=Ncw+g+pX1PE0of3UWpKR8C+2dbMLljGV8EZSzVxmxvkXAW6XyScrBcF8D7h9NCgjZW8/gWKnUnBiw5EFfAB1z/zU1yMWj6OScHlfUWvDuzlocCKn9+9Ur1xepWpv7Rma1BLTV5/PQzw7i3w9EnjDaD72G/kgJ3jS2qsaVBbeUCc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8204.namprd10.prod.outlook.com (2603:10b6:408:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 10:29:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 10:29:15 +0000
Date: Thu, 18 Sep 2025 11:29:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
        david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org,
        pfalcato@suse.de, kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-ID: <cfabded7-442e-40d9-963a-597a42da581e@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
 <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
 <20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
 <e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
 <20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 299d0417-9aba-4385-c203-08ddf69e37a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUmmwpKE0SttMNDXkLEDmSt5aLi7zWksMv9YnCOf9xHHy5iC+ZOemOu7KS9E?=
 =?us-ascii?Q?LD1nM2qYDKIQxuDQR56bW482JnGAM93Ho7W9QblbCeaV2XIpUJ0umRt4FYx/?=
 =?us-ascii?Q?DrRWe2FGEhz8FkoyjOQAwrPY4h7hoz6LddPQPGTNnu2NS76BswBsH7iWWkyU?=
 =?us-ascii?Q?ABKX5kulI3Z0juYUWizUGW1MUlwmOoIHHWJJ6rmhkxswVexPOSXdsfwWt2pH?=
 =?us-ascii?Q?HoWYhLkbJy4VHfh2k6CCRgYO4qdxctmAzDA4h+moXjIWtzhF++0t9lXU0bpg?=
 =?us-ascii?Q?Kysos8GKki3LumWj/Zjm063Tz4vB3bgAqZJrLdV2uk0sUN+2s2NLotZZnd6O?=
 =?us-ascii?Q?K4ga13UqXs7AbOIJITC8v0WSXVzS+s+vX5NLW7YBWwy1cv5T1hbCV4gUAkCh?=
 =?us-ascii?Q?KLzAm6PnkqFfY7HXEXFIue2nHdbYKLZT0VvsZOMwmvALbpc3J2q5s2hI7nPh?=
 =?us-ascii?Q?ADtsVHLqdBGvyVSWrXuMeoc2tzooB59l5hSW3PX5HGP8wLHgR7JI+WDh19dd?=
 =?us-ascii?Q?9wlyNJbVySd7oaWBXlBhjjC8GengA/ak+SjR5arTgy5kSPHF0ccg4ad9GSmO?=
 =?us-ascii?Q?VCl3HxEPiCz+XnFSbKoHqbjOz4lWpdU2c5Ml7rts2qhkSWxb7DHKjX/wTPiJ?=
 =?us-ascii?Q?Yxyr+xg/5+EoNrTpVKKsaypOgmJfm7sw7vv4GNUqjNL9IzIT32bS6tAxFHEG?=
 =?us-ascii?Q?H60//hTDobbJx6tApO4JVbGc56HTk79/X8QawHI4VaTxHrQnq578SOdgBhlE?=
 =?us-ascii?Q?LFIS7StZRi6wlqjl0sfH+tcfTLs63vlXBFn/W2ardzzqdbw1LUcHQvhl3g66?=
 =?us-ascii?Q?uI7FkvhG8ae6XDs4tb2q+UqUQmSAdaUmCAPSWDR9xoaLnLGiqfOJBr7ci6YN?=
 =?us-ascii?Q?qvCVusaa8grsOM9BEMwzAgM6/2/ye3SBM5AIbegOhNMq3Jrv/5qFoo82ZIUk?=
 =?us-ascii?Q?JDOWLRNYj3NhsQ1wW/sCi7uga7eeIW1j+jl8Qcy33V8xAmJhlvogLkkW6Zuu?=
 =?us-ascii?Q?qR+etolA5f/cxuIqNOc3AH8MavOy5t/8wJ+YzSNhYsvORN46xFSlIQVoZfse?=
 =?us-ascii?Q?0WaNCAXu+J+xqJUc1JbAvhYPa86QWGh3PqnmfmW3J0WmljWntSgAMuUee8T0?=
 =?us-ascii?Q?2sWSsbLFhUMZWkbKN92f5OEfXuscj3n79BFLCUwhQ463X4owotfKoXB4tJ7z?=
 =?us-ascii?Q?bHRLpr0MxmqMzlBWukX2pjkt7LEDWOyQa6K7Ux+fh+xNU9SwsxHJD6twxrgC?=
 =?us-ascii?Q?+kCcjSVOqsd5s7puqh2789Vbs/4H2mNp4FguFG7CjvFpKXCywAixTimio+4X?=
 =?us-ascii?Q?8mnFUO2jth99E3DIEW52RjW0sxyyylsx4dAFjQSzKCL1OoTndlxHCapQpRbU?=
 =?us-ascii?Q?A+If6/wQ06xpjajdnllG4FCNpcH01Zg+oeNZ3MAGILGAo4lB1JQa1rXj2Uwa?=
 =?us-ascii?Q?Rwh8UIeoNVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CAl70E5ZzE9xBzMGFEi51VEsRjCiv9SiRsXQ0XTxvQ8QQYGrj4qKYzFCibGT?=
 =?us-ascii?Q?FztaF4OQwPcCJulGSbaGh4Q0s/34bfmSWAaq8Z8WX9H3LberknM0y333pQCS?=
 =?us-ascii?Q?85vfz99r364GnK0Np1tZxCuAdSmAPpvYEybHCQdTUTrZjbv9wJU6UhD2Ys6p?=
 =?us-ascii?Q?x2cF+gZTZuour2mFuln5lx3ivul0j2b0tKs0Kx/r5Bd2yutSu+5z9O+tFFiN?=
 =?us-ascii?Q?BpH1Ov64dscb8kOzsWsGmG8qraP6RWyQP90I0siPsIfcXMA+NK5OQSFjW/+2?=
 =?us-ascii?Q?zm/N0lPtqiJhEfg3wdmd4aQMVU8vsUdruRRhRfWx/GRfOa3rQYTAX6VW/wZ1?=
 =?us-ascii?Q?ozAXe/ZVi6rX6NgM5xRLds7pvVWF03V0dVeqMQLyAQEIUDSPTUTObCJJEOIx?=
 =?us-ascii?Q?Cr1aWamQ1Gm+YIhZoWDxVVN327FQrHmmjsvesDkKxd/uPNurH8C3M9ucOlMX?=
 =?us-ascii?Q?AAJ86G3TW2lt+85ubZNOCI6iYiQGTvDBAftAf3p5fk2NWhbbGWAkVRziH4o6?=
 =?us-ascii?Q?dzmA5JyYhFT/UNdJeLzj7fyCyjjNFvGYQAiO8sXTzrTON3c+OeDepJc8Js1D?=
 =?us-ascii?Q?DZviw2XTOM+Hosr3O0BOoMWhymysi/HUzhqkcA0rZB/A6mQV4UnQa2n8TSrm?=
 =?us-ascii?Q?By6k7G0EVGH+xrMSi7NMosZ62HZnHjJfNeJe+ApEzUPOMI7Yw0KBpsqjn+X6?=
 =?us-ascii?Q?2QqJDZOMlGsHtczOKIymGTXm2J3a4EvfFhyOMADq8qhrcB+p9bkjIElrQdlu?=
 =?us-ascii?Q?Tcy54yx1EMUHREeeDAnRDtlLVGhTo/NnOQaefNU/ZIJqwNkckdXuyreHhpBP?=
 =?us-ascii?Q?A3a3p6Pzi543FGkK8Z7Oj5cCpDyEGO/Jhvw3BZtiUmRmaSDTftMY7jsbGlCV?=
 =?us-ascii?Q?2ad1SCRkrRER/I9YDNcdTgLIkneCz46bQoV9YfZCUNgEEW3Rq9Te2g86yZbx?=
 =?us-ascii?Q?p1BWfE+8MWr+h+GLQH++QO5fY2+slaQ3Pf8oGQCCtAjwYiZnNF1gbIRzV2Cv?=
 =?us-ascii?Q?aCAT8msQfFi4nN8qUWxbvvuZtNtBweSXTakRG6UIO1hQ6AxgyeBjUTCroc5J?=
 =?us-ascii?Q?sj/Itaw+saY/dwOFKQ37fToPFgcdy/+Kq0Mz8gg55PXZl90ZtAE29wfnlQCL?=
 =?us-ascii?Q?iDiAOG5I9iA4x3J+4GfZpYAAw1JLKEiMKKo09o3OHf0AcHk13htsGvBW0H5u?=
 =?us-ascii?Q?TWCYGX4hU8hJkH+8vg4krE4L5WBg/BCWWRBgpDfwpesiYb8uBLryyVK8z6qv?=
 =?us-ascii?Q?Fs5XM8D2WgO/7ulZK5vcmQluxnl41EJrDNYGfzWxVL6XJzdigZz+Suy+CLQn?=
 =?us-ascii?Q?KWIDFPeq+EFICvU1FcvaMxAfoNlhVw/edB8VJDp1Sq0QNHB+nQ44/Uac7pBa?=
 =?us-ascii?Q?mfRftlvbmsS2TvnGBNczLMaXx7F7UmpXDz7CqpuGJPqpaFetJAcowP8/eQPB?=
 =?us-ascii?Q?zD5cSdlaRMpnhF6azBjMlwQHzkCeafYCTme5IPB5X0hriGxLgUww9fuxQVLL?=
 =?us-ascii?Q?eCViNPpFXZBpu19PpsUZs5HtQKY80N29ZSBwrmS8KJ+rP2T+KUGqsEmiN5R9?=
 =?us-ascii?Q?uiYUBB/m700WBPgif1zxV9NI2ws9h0CL/2oeuqYtnQenqVMdXvHQNmAOAiMW?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ez7BNdA7pCh9liOzZDL1E8hP1R9Y3I630CuYKthevGCalZ8hUDD8dAOwiGus8a5ErnLN7RN6yGP2ezFqKYxPsPehsXMct8lfaAxZxi3Yx6ljOnWgovewKy5YFgoKe6ytgbtOavvwihXey5QTNmkYWn0vcfbIvtsrEoI3gvoZNGdaLePpWF8/sxDaOuAYyITzrey/hvQYdf1Wzim1WPZ361XiYfjZrg5XzXdAKB0deCeyeSZqA1bFRrYizjQeWAmUIbGO6ssm5QA6CmdGrLhhSWzGPkhMXeTFt7w6+WvakIHedHb0/rAh9rGgoednHkfzc1AGl+gI9xPJ/PdHrFG+Kd0pHca/KyWcvFkJbdrZpUTMkADPh+K7pzyQssTkP33XnPpEU9F0ZRivVeiD1vohi6taJMPvqO47fx0VnWBUIJf+Ul10vQkfGD7l1AkinzWRPCsINpN95zkczC/3gKtsef+pNKaiXD8D5myrkTU+n/SMU/pUl5TYVmg6KMtWGEb5Qk7fjMS0rRHNMLJnf+Fy8PuhBS6H2Tq/0B6K77MX0S7w+j9o/G9lUAOFZjeu30r/lPPbz5H/9BZPwMFxf1skUea+K9vYGj01V1UuBwSktwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299d0417-9aba-4385-c203-08ddf69e37a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:29:15.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIghA0K1ToQKTxQw0l7zDGD3kXSY9QQJ7sIg2MrwchZt1Y2+ekCxuNLeTwSmpDQXLRH93L6sl7Eo0lOFTI/BoY+RgyLeqyHBMiSkNl+ojSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5SwfbZGXdi+W
 QUJleDh+HnXjzqQG50PVrMmFn+Xp1l6MKmPRErq4FWLJ1wRLBmsgGAbS1dPM4h+jMJIPmTknm7O
 oq8mi3vH2PLRZ29Q4hHWVlv498Nx+2+EHbqeFtjS8rlkweTwiOVgss71LqxevrU3E90aPltWZAk
 LvwA8cHjpZljKC6Me8MApzgL/5wVVD+AD8+tRWsUcL0pAk2T1RCadP1qpkqFXo6yMla5GUXT7PK
 yl3gggq+k99SKFhcgOVGZmgegew1EysT97Xxa6elj4emm2Z7fK+0QS0BqXuGmdvaJCkG+YVFP0/
 xgaaR9YbbspXjuBoas9TpdpjjnaewHBNjuwnrbfjrakLsxSTiH4QClwOk3lUAp7N1keUM0WisYy
 2RET9DIX85L7umJsLArcAHiQAjKEjw==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cbdeff b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=dQ6n4z0fQHBdc5d6NnkA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: mzeuVend8feIY0DZY4O3HaWtXYxqO95j
X-Proofpoint-ORIG-GUID: mzeuVend8feIY0DZY4O3HaWtXYxqO95j

On Wed, Sep 17, 2025 at 04:32:31PM -0700, Andrew Morton wrote:
> On Wed, 17 Sep 2025 06:36:34 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > >
> > > > Perhaps being less accepting of patches during merge window is one aspect,
> > > > as the merge window leading up to this cycle was almost the same review
> > > > load as when the cycle started.
> > >
> > > I'm having trouble understanding what you said here?
> >
> > Sorry, what I mean to say is that in mm we're pretty open to taking stuff in the
> > merge window, esp. now we have mm-new.
> >
> > And last merge window my review load felt similar to during a cycle, which
> > was kind of crazy.
> >
> > So I wonder if we should be less accommodating and simply say 'sorry it's
> > the merge window, no submissions accepted'?
>
> hm, I always have a lot of emails piled up by the time mm-stable gets
> merged upstream.  That ~1 week between "we merged" and "-rc1" is a nice
> time to go through that material and add it to mm-new.  I think it
> smooths things out.  I mean, this is peak time for people to be
> considering the new material?

I'm confused, why is the merge window a good time to consider new material?

People have the entirety of the cycle to submit new material, and they do
so.

And equally, people are sending new revisions of old code, engaging in
discussion from old series etc. during the merge window also.

What happens is you essentially have reviewers work 9 weeks instead of 7
for a cycle without much of a let up (+ so no break from it), based on
workload from the past cycle/merge window.

I mean I can only ask that perhaps we consider not doing this in mm (I
gather many other subsystems equally have a kinda 'freeze' during this
time).

>
> (ot, that backlog is always >400 emails and a lot of that gets tossed
> out anyway - either it's just too old so I request a refresh or there
> was a new version, or review was unpromising, etc).
>

Right, which actually makes everything a lot more uncertain from a
reviewer's point of view, as we don't definitely have a solid git base,
mm-new isn't synced with Linus's tree very much during this time etc.

Which makes the merge window actually even worse for this stuff.

From the point of view of avoiding burn out, it'd be good to manage
expectations a bit on this.

Personally I remember literally saying to David during the last merge
window 'well I hoped I could go off and work on my own stuff instead of
just review, guess not then' :)

THP is a particularly busy area at the moment which is part of all this.

