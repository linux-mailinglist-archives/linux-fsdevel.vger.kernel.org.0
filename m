Return-Path: <linux-fsdevel+bounces-10369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67F84A8EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A15292DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF05FBBF;
	Mon,  5 Feb 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZCx6byt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v6YZPlQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B85FBB8;
	Mon,  5 Feb 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170459; cv=fail; b=k9XO+92nNiDUu3lHPh3g3bR6vSXOv1IpO5dKHqYkPXcRGlNOk+wfrTLLWbWihB/G1tZ74qDRp2tp00c9B7cz8rxQ9vC0RzG7SzOr7Hlflhx6Fm8gIGg2ZTMHMKOGKfswQfiyq5W6Ol8xDmkrtk2BiwS5mW8VIUcGCJ/TBWNvifk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170459; c=relaxed/simple;
	bh=5eLbMmB6xQY4Pc75qtO7phwWIIUED5tYJaKO1Nrm9FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E00jesRUsqI+rAmkf1pyaIxFRLej8iPaBIBe+NYIY8C5aNhnlYuChMlejidI6FzPtmWh/okr0Nouy8kjal6mPxhTPJOXMNJ+V3P7Yd+eM9GN48o8R1wMTNT+U4KhCHoA3IxnevTABjyYLGSjFonLlsJOJRsbD8bTeuCGQq0Tfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cZCx6byt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v6YZPlQz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415LFk1s024993;
	Mon, 5 Feb 2024 22:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=OaqiXpnE3hJQ8Uhe+f11uybriOk1/Ut/hFx0SzYTaJ0=;
 b=cZCx6bytMRHgjxabtkIu2mi3slCZNA1UJsIq/3P2mwSAtzu8VSzJQ5cEccDpR6cn9Aro
 C8+WGeRyzt0pzHxXTwiV9DfkaXYGKfXkcJL8Yv2mwC1jU6RMui3QpX9DAxUt3mxcKZF7
 /TOcnTOAzyuLGvWEKD6H0ylt+2n7VOOSuykDpGLCnGokDqrRiWu9sosOPoWPn/4SFUtc
 4fSE7IN+42zzvgmGbEtMUDRP1WlEz5o38Qqd6APNtL/cetQfz8kInIAtSvYe9GFb11Fj
 VyQ3M/FsF3xAdcACPAVmrh0U11MLExKatWSD72vIh71ChUtJE8EqeXYCRMGpEK41B8jt 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32n8ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 22:00:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415LNAWM007103;
	Mon, 5 Feb 2024 22:00:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6jcqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 22:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5SMoGeXvsLkKwkKmXKNpNk+QNaP/2/1hx4vEirKdM2a+jmjZe95qJYubnEHpEf6pSXfepuA2aOtWnmH0vRSuxjPDtdLyoIMt8KQ/0dsZgfqSgctWT4r3/O25kL1v796pZiw4AvzSlh5CcdRJMuPDruuuGo38pO/j9PA2QpHjA6faWkg0a22PJ0ojEfUzeds2WJk974hRbPuznJ2imeqcNDIK/uiygoZV/NVAfz4aQYsacjQPA4Etzym4QugetE9a2JILVqN0W01c+i//KDOXwv7Y22Evvc6UfKMZ9NCCxLc+BcLClq8dBRZxxz1/Yxa50M8ipajZlny65MzBc3yTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaqiXpnE3hJQ8Uhe+f11uybriOk1/Ut/hFx0SzYTaJ0=;
 b=kG55E1wbxbgLv652zxOEWwwtcIjdbGwmV6kHKMdMuN4kkRAN2ItlpttV4bjEJtVQgqhSoZwi8EKpCcZTJuOXODkWstz0CMQ49JtGDqao2v8XZsCD3ikMQP9E9A0ZvHSgZOdfXc9shZCeLwGzaJIl3b2jh/lv7qO+rMXongujUnmCPEcMcmhFZQLuZRW7gAi1mXwg4AIpn5F9b6zC+gWONfTvR5DtSysrCDXTG1OfbJ1El9iqfH+UOhxJWYZqJZPcr+e5+Un1+MVDZ5T4HGRFD+szkc8yPEFfPGOgqJ1MLakTByzqeYSH8ic34mCHxtmqoXEKvOwT27q+5EEAyuXmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaqiXpnE3hJQ8Uhe+f11uybriOk1/Ut/hFx0SzYTaJ0=;
 b=v6YZPlQzYYdTTx9cb2q72fwkKZNq/l6IRfBv3mtJzy9NbPX8Y5gHkp5QAvoE/kcveqG7BCUtq8u/vG2F7oUSg8ABHEKSCSDL/f1fxtX2ke0CR9Xhqvk76q7Uj8/9uX27mYok9X8JMX5SBnJEy08r02vL3+LWyG27hGbjlQHTYyU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 22:00:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 22:00:24 +0000
Date: Mon, 5 Feb 2024 17:00:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240205220022.a4qy7xlv6jpcsnh7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com>
 <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver>
 <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver>
 <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f7aa36-8781-4f1d-e583-08dc2695db07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+q9/PXc8ICGjPswqFeyCAQZ7h37sf6ZRwmFO5LUImq9UVJQy4GmV7fIe4a8nvQdGkUCdK63CmW3PrafsQIqjzthYx9a+HCZT2440G1P2nulOYRk8aM82XtKZttHE36ZIg/FQlNDci3+M9/NTyN95vPBL8KZpwqOw8xTATo+NBiarrB/AVsjpq6m/keibhiMlJwMaYJJ4gBJKZd2l86cTopHaQVk6YakAN8gYS0vKsebgMe0B1bIZVcG3ynHM3ND4YF1b7oW3K764O1k8M+HAXC2EmwxJN0HChOMvez5GL0uy7UwnetR7kN5KIHbUPb+ApAF4sjrESamxNjOaJ//5ZtnuR8Uynwn+M8co7kYHPkCz0Zd5w0uB+7iEGHKvYMziGmJYvaxl8ndPlriqu2ZwLPWEz6qd2VdKi4RsTMZ+381fTxGsBVLhch2e9XgvzUlrq9lN2h/wqnB7YzWoDey2A3KGUMFuUXfkoRh7Q5/GKTq/JDQtEiN77U0BiE9FbXkEL/Hmpxwu8TvZSergpppUameh9fCXEvuVSHSEot8tLXHYDUYFbHHLlQGEpXVRz4FT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(5660300002)(8936002)(4326008)(8676002)(2906002)(316002)(66946007)(66556008)(6916009)(66476007)(6486002)(6512007)(478600001)(9686003)(6506007)(1076003)(33716001)(38100700002)(86362001)(83380400001)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OZOctOBkKXbNNStD+aQHaOvbH4CKxn0bTYwFT2zDgqk3O43v8lL8jHLrysRD?=
 =?us-ascii?Q?Rq6WR3pmxWzhVusCZK8G4Vk8GaHEMzwaP5uNY6u238oJZ8UDsjgx9AgSLsjK?=
 =?us-ascii?Q?hZtfS2fGVmdXE/uqb4ANBN68lsDplFzzorh2FvSW3Yrwd5+8PfH+wLll+UIJ?=
 =?us-ascii?Q?l0sYKXJwaRqSrXfgls+qHby7baMwsWiTv2nPZF6ljO1RCfIiykj4lpTnrCuw?=
 =?us-ascii?Q?Rhavthc5Njgao73SNTzTQJyiOZVoop3GPGIO2p7Ly98dcROFdYOU1ii6aEMZ?=
 =?us-ascii?Q?brlAOH3SeuYz2lJEGN0QOhVA1fCkylV6jD7fZJAHE4WU1+see3BK1PoaBwM6?=
 =?us-ascii?Q?+D7IaJt8ODj6jn3w+spjn5+9d6ozinJug35gP2k1oM6HuHJaaG8cWMjzVYf6?=
 =?us-ascii?Q?JqEuBsZ7MszwXB6YhLZwK+oMpQIP/c0ymzbO8Xk6BfihGfaIFLPE2Z+rHoOT?=
 =?us-ascii?Q?EVCu3FIGNFlpytlIIX61mTAoDXVHLZ4KY/0oDkB8pSeW07hWBKOKQigkUp33?=
 =?us-ascii?Q?+S/WrE+QmYl3zSK1dxazgaGMkS7cZzGA5oHvayKKXEtx9uNA60LWL1iNPMkK?=
 =?us-ascii?Q?DBc8cVAi5/UQMCA0KIWuLHn34rHQpaT/Jy95byvLA6hEixJX0wsevN5VQl5q?=
 =?us-ascii?Q?xSdPu3UwU9/m1kaR/ZkvZV1sRHDGhgn5ceOgcF6TJrPcICVzATPFXvXUnMJx?=
 =?us-ascii?Q?gZNt0H6Uwsqjf1p6p+H6hZEBvFzNaslqu5jhs3BiOJlApvq0N5U41PsUIH5j?=
 =?us-ascii?Q?ws16qib8H6nmHJYjiAhZ1iVmf7RyyPYvhicRtkFZuyZA9WAuHQeoG0VgJMMb?=
 =?us-ascii?Q?FkbNRaUV83FI4Jqve3RSWIUrRQI7BTCId97Q9+kRs61iHJJaCN1qv5BSA7lH?=
 =?us-ascii?Q?aJi/hGDkDilqdJML491uuj9/8EOvwmVesCXtsosChEeKw2zRJw3j1tKCjOR8?=
 =?us-ascii?Q?s1PLhDoHppLInnw7g8u+CyV6Q0RnRNEkilg8xvj9XkrfeEu7Z96/DmBt4COP?=
 =?us-ascii?Q?NQaapgAInL4xZOTZGh1hox3/5x6HuQMttsaNPnAo3worv+2RdhdI1fzMeFkW?=
 =?us-ascii?Q?vMbQlZSEvOTFWLNRlm1O6HkUxDQtKrNLVGV99HLjk+6/LFwMY49cJsaUinZS?=
 =?us-ascii?Q?ySktf0SV47WEHjDW7omy21lNSuIlQNHN5JFLdcbPrRSmpCBBOKhSlsnvFQAB?=
 =?us-ascii?Q?XEetBr5uYYKZhfZgTfNPSyEDpWo81jB+lMWM6ZwpACnGeTBNrhkhwTl5+eBh?=
 =?us-ascii?Q?L2+7JCGYR7N5PZyB1FRTxQZRqCI3g2/Ch1s2ibmk2tdsjkODYl540JePn1oa?=
 =?us-ascii?Q?SpA4I/4+uX7l6+4UWl4SLJTZ17E8+n08sjbx9QQwaaZBU9tQKcq8CCtyMs9E?=
 =?us-ascii?Q?ZK2pg/0Q0KQr5gIEzygxwzz5HsHxAjVf1zDlicqU+jbzl3SKINxonfabyrVQ?=
 =?us-ascii?Q?eb+qfgz11Ec22/AyXE0ZiRG6XbGX3QFsG0lK0Rb10uWdvHfmgJ4ktwieR0AB?=
 =?us-ascii?Q?G4y2VWNmpVyNLd80w7rr4iaBqLb7tAP0trxoP2K3xn+WQm9kiMnYNmNUG/Tg?=
 =?us-ascii?Q?b4TpbivDS9sKfAVcn0lhL9GiivwfHBM+5ondQC3J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qSYL4HDBdMmh+Hv2YP5wwK9BeTRteOLCp1d46BQSDBvSJlFxsMAFnamE88vUObxFY5lQe4TMI4ofa7SFhEdaffN/GMdx+kqmPP/SYYEUGmg03AxT4ESmIvGxJ0YRkS1btZg3y92yEKqoihVD1HQMGKCei+dMs04Qyv/CUa14TAi910Nb8kReJ2Bm/bw4DsJ9j+rDbh4k33pMf3A1PQGmUQ9NuKr+HkIdS3hT9d3o8EK4pzVqIbqyOxJRIu1edvu3HIzcQilxrBGGw8mu4d5WacU4rOSlddps29D6XWgeqYO4NSIB3u1TMI+ot7BlfteRW4E23LuF8s0uauUTzCawJkUGLMg6nTHQ5Q7dMZyy+Ss0fK2L9fSOa/YkZqLLt1SSr+VpJSFLoQppuso/r0RY7AEyRSYyIWwq1D0TEKtfm9tU7ywZYdkJ4xS4nEUK7QW8q+DLo3IygCkkT+f6xtPynodEp/IoQKrhQ/HjQe+t3Amlhax+JUd1H32Jeimhkl0rR/MsCaGQELjhYivJARGv+Ah+nJ0OtdOeTKifrZB10PFW3Fe6MrnjKIZRvqfmrWLaSu/u7uwjoSuC3lfSaAHlqtJpea23u1HQuCgFaqmyTVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f7aa36-8781-4f1d-e583-08dc2695db07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:00:24.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saE6E1REaNwbFJ+toGeu29MwRZ7uZy9NuIuyMUGxE+DSrP4XTImwWHuwWyYIJXXnW3GqNzEQ3F3HifB9/ooqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=742 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050165
X-Proofpoint-GUID: bOn994PU1eDCEWRZctnEuzcaOVDU3BYF
X-Proofpoint-ORIG-GUID: bOn994PU1eDCEWRZctnEuzcaOVDU3BYF

* Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
...

> > > > We can take care of anon_vma as well here right? I can take a bool
> > > > parameter ('prepare_anon' or something) and then:
> > > >
> > > >            if (vma) {
> > > >                     if (prepare_anon && vma_is_anonymous(vma)) &&
> > > > !anon_vma_prepare(vma)) {
> > > >                                       vma = ERR_PTR(-ENOMEM);
> > > >                                       goto out_unlock;
> > > >                    }
> > > > >                 vma_aquire_read_lock(vma);
> > > >            }
> > > > out_unlock:
> > > > >         mmap_read_unlock(mm);
> > > > >         return vma;
> > > > > }
> > >
> > > Do you need this?  I didn't think this was happening in the code as
> > > written?  If you need it I would suggest making it happen always and
> > > ditch the flag until a user needs this variant, but document what's
> > > going on in here or even have a better name.
> >
> > I think yes, you do need this. I can see calls to anon_vma_prepare()
> > under mmap_read_lock() protection in both mfill_atomic_hugetlb() and
> > in mfill_atomic(). This means, just like in the pagefault path, we
> > modify vma->anon_vma under mmap_read_lock protection which guarantees
> > that adjacent VMAs won't change. This is important because
> > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
> > neighboring VMAs to be stable. Per-VMA lock guarantees stability of
> > the VMA we locked but not of its neighbors, therefore holding per-VMA
> > lock while calling anon_vma_prepare() is not enough. The solution
> > Lokesh suggests would call anon_vma_prepare() under mmap_read_lock and
> > therefore would avoid the issue.
> >

...

> anon_vma_prepare() is also called in validate_move_areas() via move_pages().

Probably worth doing it unconditionally and have a comment as to why it
is necessary.

Does this avoid your locking workaround?

Thanks,
Liam

