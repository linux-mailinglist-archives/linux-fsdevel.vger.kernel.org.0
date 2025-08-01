Return-Path: <linux-fsdevel+bounces-56506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E21B1803F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B572C17B1E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15F233714;
	Fri,  1 Aug 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AI9+WFYO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2k7oRAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7B1F5827;
	Fri,  1 Aug 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044409; cv=fail; b=rXi0dVX0jPvvP+z8vLDYan586zyavul5upvNpX4fZWk7vfoTzxjQ0oUGw3epTT76a+LLELEjGJVz5onxiCzu+dME/34QvtYC64WwvJn0DzbEgErM15OLZIXigJLs/Xz4Ifp4O++y2PFktgTknP3i0gVz3PbHKhTE/2muDWNrjqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044409; c=relaxed/simple;
	bh=+TVAm30cJr6sTflSEaTtiOlV8c6MpqEkDeSuhB1GIVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2u5bYuKYU4O95ewAtzTNKQL9UjuXVGXBGbHadtwQNyqb1AsCWt10A2DyF5Yypu5BUriCkpNPpBD/a8ThP418ru63xjHZiUDZRttOXsP+JO05o1kCNmWKWbppclfQyJh/4gtz3RnEy/b3tKF5qDwy+U3ZGXY4GmOMvgqZ8e0HJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AI9+WFYO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2k7oRAC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717C39j026469;
	Fri, 1 Aug 2025 10:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HlOa6gtQfcL62jiW7S
	RLWT4n7pdw3IqrDIoUYvhihUI=; b=AI9+WFYOk400DQf8gD42zf5EnP30bL1jxp
	otIT409mF+zNu4gDXvHG5q1wjmh1j0hQ9EGFvuMH4zCResshZ6wEb2zYV94L3Mq6
	db5Ejx42ajBEctQJa3gDTyQ+FtoAnLeHY6iAftTo6a+kTAcm+DmiYF6ow6ZYv9SH
	nZ5O/GlUwUMg3wmEvYlSmkGEtgYtNqMeLP/SwiSy9bloufWABQSH1JckvXhuYAkX
	IMbSKtusfpp+iwlrJ76Dt2mCd3vb6vvsvQ31/UayEPrqIIiTQgEH4Jec8EXlx8lg
	5Lkml8hCQPX8ePpKQNM8KXp5tpkYrEMnJ+/hHZfY6iDL5wbVwPgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwx34q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:32:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571A5g75002454;
	Fri, 1 Aug 2025 10:32:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdn1dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaVz5mt32J0BZQSI8cfD56bVXDDz6T6u3Xq/r20JCkc+3ICw5/nXG70SQl7bRM0nOg5iTfk1tUvVTsYj3LdXnatpv7sWvadhcFawI8cjyvApltqDOqZ4p3wJymmL0Bo3fqTyA0qACzyeIXfQ6CtKs2YVzVeYXKXvSIUg1CydGK4cyikiIFxFVrohqSR8ihWlBGUBdC2pMBAurlDf92FgdsUk0o11ktxfyjudoOZcXUji6dlCdpXFKt2hwOs+DyauB+qGpObm6yV9trjKXeKJ4NzfQcmzvET8oo+H9f1k5LLDzHVShRvEgFpR/RP+C9SpW/0R38E8al3XvHDC841HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlOa6gtQfcL62jiW7SRLWT4n7pdw3IqrDIoUYvhihUI=;
 b=pnoPwnkogmvKt7OXin7GR1RZ5AxXoNpYCNspVaMp338J2rwWPSJ8dV/FioK+AA+WdZkp2PfDMTxv4JpqqWHkLxgh8n9UgwfiIUb3oOF7QLJrhweeABUDfj/H4XXypz6oElen8XrKPg7yHVWCMcLtiS5CYvtia0EiATJNTt0gSvADckfwiN8dfZ60J10KZ45IaBVhNa5rNvBhGn9I8UJWyyxLKMhlsX4BGJJbFmeJ+kcbzz0YG6fLE/bpY4RIQZ4aji1IeTnNImCnT2Jv2fOY+68k2+0pnlvw8dhUZ3rriclc6CcadeUrW0LAukA4ddlA6+sjsASY3WQMgvf5pGPbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlOa6gtQfcL62jiW7SRLWT4n7pdw3IqrDIoUYvhihUI=;
 b=b2k7oRACTeo4/MxVchCS8NkdpoNexa28/O6kUsaybUqPxCbazpYEQWeajpGkTgDHsCT3ruhgGdRT7+8eZCfJ7/baiSs/Y8KPbz3IX6yEjBU4JNR8m6aaD1Sq6qocMui+2CWcZrNmwXw9boVbN8krjMPCcLWTUfDyZVgQWoOunRk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 10:32:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 10:32:33 +0000
Date: Fri, 1 Aug 2025 11:32:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
        ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v2 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise
 with PR_THP_DISABLE_EXCEPT_ADVISED
Message-ID: <a6c3a877-443a-45d5-ade4-bf0af0fb7de9@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-4-usamaarif642@gmail.com>
 <aca74036-f37f-4247-b3b8-112059f53659@lucifer.local>
 <747509a6-8493-46c3-99d4-38b53a8a7504@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747509a6-8493-46c3-99d4-38b53a8a7504@redhat.com>
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: b380a748-ce5d-4da8-00f7-08ddd0e6b9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1u6wWaCuLHYZo0X3AMP2NMzYGVSVVVZFaEwgzE1nAFBosLQM/OyIHUKPrri?=
 =?us-ascii?Q?G3Xe8MVb7+NcVuxFYF+tw65Zz87v/nr+SMtP7mVIrhI40YBhPjz+TA76v3ow?=
 =?us-ascii?Q?JjlcK+lDUE4vIvIzqANIeJRmk7n851sAXuVDH/lQ4n37D6W8z8sdlTV6eCHz?=
 =?us-ascii?Q?2A6gH5Hv0mEbFQlCqVf6uUqpWkNIGLgT7O8pOo2Urfrd3LUUSnauP6DBQ52S?=
 =?us-ascii?Q?TzuU6wd6K/ttxIQHyjGSEyBh2PSWahPCXlBPSrD5rg6aJ8YmSS+oXEk2zk98?=
 =?us-ascii?Q?xH6Q584+3818gN4eoXivJkiSTLVLFwKVHVdWfImN/Www/UPQgnTUEI0r3p5h?=
 =?us-ascii?Q?LJf6+hphdy1EJjzd0IRMFfsdAULcWCEMJ6Frj6Eoq3qSrjpTWdVRf9Z46amp?=
 =?us-ascii?Q?BJ7XBBeQLbKTje8yH/ux1rn2IR9341R4DpkHc+TixE/RuCj+nyY/UQClFiYa?=
 =?us-ascii?Q?Y0rkBlfYPt8I5hh+eP3WZhkwUdaMJQLwr3ubS2DcgKhAyYraqyJpcOmrtsfW?=
 =?us-ascii?Q?N3pHxss9IK3N+2avAuea3G4qj3UFzfn1/xe3BswcuTKFwAIrQMBSFC/xxxWh?=
 =?us-ascii?Q?pJd6e2siCdgMfokOQFVm+hu5LYa9kb34Lw/ttO7juPhL215siPtY2+m1Rf/R?=
 =?us-ascii?Q?EI8Wl/owjOKiqHOnh0uyQN0whExR3xb0NOpOc87ZmFv4WNUaaZ1mAGTTNYfj?=
 =?us-ascii?Q?s8NBGLh6dw6P6eDldmzT7hGs1ZdfGvlsR6x3/XdC1169glkHIRBBaIU/BDKc?=
 =?us-ascii?Q?IXjBTJrM/ZJZF0i377RMm0dkxld++Yj9uxa5Pz2bNkAMO9TZupHtue0Q/pZY?=
 =?us-ascii?Q?ZONJhMCHlosxQ/NlGhAqP3zoSlsdmO740ADONQTfLU93xYz/TpAZ2662RJuL?=
 =?us-ascii?Q?yOW25mlzfvQC1hwbQWRV908ezE9Q7TZNUuGufmgluCbhcNp7wVI4PABr8Fut?=
 =?us-ascii?Q?sPQSLX7hKqNw54PXGSLHHdHX1PcUzr7fDUn7fASWAsw9qoQvyH13Yi58a+pY?=
 =?us-ascii?Q?lBuaEJDQOG4UaMaYA4EOSHHFUHmQ6qYbJ+gKmI6bQjD8xCsex7cVjiieiY/h?=
 =?us-ascii?Q?QX2r9FLKWA76E9URBnrH94oE5bFxqTrH+krF44Lzs6R9vjy3QCtTtTyyNl1t?=
 =?us-ascii?Q?vCn8ee98DbV8csQ9j0h5bPNzt/c3G7VAAGjQu6s3wm11zBsImeevMk5KfS7r?=
 =?us-ascii?Q?2J8T63ZU1oJFql/ln+76MTeMw95T8iWNZCoUo+7cUhJd6lD+zkl+WImwUyh1?=
 =?us-ascii?Q?8of/TMVs3D4eC6WtdkddjaC1rDUTdqd9dF384p/LY9HLQO262WnbhcLZDjGZ?=
 =?us-ascii?Q?2GoIrt4IVqIz0lgdxfOimHVkq0wvgTtNBdUzaBGyEDLe1g46IgV6UGGRJXrG?=
 =?us-ascii?Q?ZCUqFRBC484OnV3M/8cNtasXXuK4pnbSwfax3lSp53EIkyiD1NmFU6rMMgWu?=
 =?us-ascii?Q?bn+Z3Pif4/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gPhhhaoe8de0Wp31vk9URAuOZ194TAYkybsdeUJKhgFvBu9tyy/u2fhYWac?=
 =?us-ascii?Q?5UrPFm/YMTUOVa9FK7GTxmY7H3BKRx8FIEJVD4h69gyxT+5KpU43bRbhaYXs?=
 =?us-ascii?Q?rfpZQUHQm9rsZLsQ3ZuayM0gJdKmrFT/XOzFybO0BbDTUxhxLRGST3jsYb2V?=
 =?us-ascii?Q?jTbsEsnz6TmJwSRLlU0aqnoZ0atH83Oo4IH/NlLHL+3LcUZqu5Cv7QntxpiO?=
 =?us-ascii?Q?b/xc788I4OTiSxFsrVp2PPyvo7tp/Wn5fRu5Xc7wDf6lx/K0ZYe0mp5PiTWx?=
 =?us-ascii?Q?RvcxSitOtpmKHQ/lQGeGwfBhRifcl6oy+FA000sP46I4F+tcnP94Xj64RFY1?=
 =?us-ascii?Q?fIldmtySSlZBmPKRTbp1ReZRyRzoq4UcerG2wrLbN4ZPxTLs4VTNuPwSsKjR?=
 =?us-ascii?Q?hzc60Ca4rIrhGUASc2OoDBkibEhSiqeOKZnZ6EIoz1cgJr3/rHv21xsfoDyx?=
 =?us-ascii?Q?QhR4ynSPrP4I36FtaX2bqCUUvwDi+RjnvENsNEUhUajB/bNb6O/9mbADEwVu?=
 =?us-ascii?Q?lgs5v6Oq4EXJgCooWVel5KJhgRUXF4xRIHri1kaPNZSEk+d/ZJwSEhQm8KTR?=
 =?us-ascii?Q?oLvGaR7x+PKZJSTYnAf2oqJmwID/Q+upJu0LQ2OflL4ltSwlk6pyuu00vGD7?=
 =?us-ascii?Q?mHr9sBOycbvqCzWuvYtC43oOropT40Ax6ysqeCvnA11cqFVujJ2j4z1p/0Uz?=
 =?us-ascii?Q?V8A65Asa2fp7+K6Xpw1m2HZcQ1EvbfHiNW0SjsqjqHw/DdUkceQHF657ReBB?=
 =?us-ascii?Q?rrUzpcuzxEfrkd5kjc21Qj3qWrX6mFgXQ9biJwLNOfo5k7agqXpUd0xhctIw?=
 =?us-ascii?Q?XETugfzHPD6me1WPefvjXIIozh9AoEZmBcm7Y9Byjdwd3jFSVUgkyP9WcBqS?=
 =?us-ascii?Q?8J6+G0vm99L5hSTZE7bWdErQBkVd6em2zCoGpC6xaSc15LAjBTxCnU5y2cli?=
 =?us-ascii?Q?DPpcCK73h44/u6z6muqxSgBpBh6vTPHz+YYWBojLi5OMl1KJK6Xdi0BIL3rD?=
 =?us-ascii?Q?2aoqq61ejhbU2KZFXmAXDOh5/wxz+VkHspRsbIWQJPXitEWdlNcYXJDdPAo1?=
 =?us-ascii?Q?7eeLOzsLJTz/jt/6Xq6ZYX2vqKH8Q/dM3IBMo+81HcWJgyzU6u8st4TB9Qqp?=
 =?us-ascii?Q?0Ik9y0qQZgtb0fTASY6VxCITGUaNg974qinL93X9M4H5zhj21I+X4OFDxdzq?=
 =?us-ascii?Q?kPEOWULsSvlC/o73NcOKslv0EBcDjkKpDzB8QZUH6e+xprRx3a5iGDThutkC?=
 =?us-ascii?Q?z4R9kLYYQY9ACfSxxaenEqU+uxRx1MAr7g2Excp/7O/RvywZNnPLqulZ10Sp?=
 =?us-ascii?Q?R95yMJ9x1a+TW7u3NMqR8zBZQTNfXWJ4ztYmADmiTs4MSyPy1OIS4b96uBb6?=
 =?us-ascii?Q?7RLuSV5Sli9Wv8dNtDy7dDRXhY0K8rBkuDDDVt3SzwQK5AugU8LitBoVKdPO?=
 =?us-ascii?Q?jveea/qw3r5Nhhcxt0jQ8l3BT4imms+gVD6XrEinYwF9HnO4KbTLO9Bo8+gO?=
 =?us-ascii?Q?4tTvkchmUUkZx0yjGFLCR/DBN1adr1rrhOxzFv59SPH7VkLmcgoEkjN2D6/X?=
 =?us-ascii?Q?FRVFbJYuVAQD92S81jKB/jLTYc96cD93qyT3PS+gZwn5gdh2V3cUsD/J1RHC?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gXZAGtNdntTSHus/xa7h+t6Ly53t1bR25dZUklfge/35yDNp/I0AbF/yS+z3WV+BydD04dBsB8YNc3Ekgj/qSztYrhQvferDcb+W0hBf0NigBZVpHH1h+IihH/MdYOJPyUu6DF/FR1sGNeBRYkbO9ET0A2+fMBmR/ZCw/5O/z6WoWteq4h5gUO3TLcGyGlJOMJV+fanvA9yXHL9sUpT9+HDc+P85ZSiaVG2BZyD04zyjuL06QQHSuqK0mgluEuEQF/wdBVza7KR0vsYzfSSBDXfryc+XHA3qPkAnoNKEv6kUUx9o9Wld3RNV8Qen0Ru6H7Ixz5hR8k9URKYpMTA5JUZEJ9omMLlo4toRFhNaTQLQsXAOg114/b67r5IHG2sUofl+ERdCdBmWLiHWk470wsrOSqg9qr3i6g9ltiw7MKSKolEFSiw0MJcFGg0h5eIXRMBbu3a0vNDQuVGHEX9lEoBFZrCrJ6HSGHdFJRjv2iNuxHzfXQRpsZeHWiVsnt+cJ1vOcIzvq7LzbZ+nJFrWfUV17Uf3A4lKnksYKvZ7KZ2rpxIS0cmipRXL7RB7STB55LEXQ3GcL/nxAYMlgP777zq3HQhzOiHUSMFyCnNcp8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b380a748-ce5d-4da8-00f7-08ddd0e6b9d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:32:33.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/s1ZRPQNDfavNP74lTKTkEUzVviI7cyUgwHn5MVK8oLCgif3f915czb7ZoZAR49Y66MeNK4k2wCjImCw0a64vh0tFiDmLMh/ky7gSjHsL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=669
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010078
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=688c97c5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=tflOLCwf5w8BBiNf9W0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: F3FcKERhzw2mm4SztROgm7VWLNuOj_hY
X-Proofpoint-ORIG-GUID: F3FcKERhzw2mm4SztROgm7VWLNuOj_hY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OCBTYWx0ZWRfXxm+f9Q1I3eiv
 EZMI6MDw9+UgpO/vNE04BwCvhjDQCQ1S1oNvNFvagXB5Dy0H9ZX8zpiAMOoOpDuSPdyLtTVMiAa
 aAdkCPBnqEvU9uVNpGcLVx91klo8sdcnSzBwwU+MIEMzADqVHhMWNpo8lDxA+oeS9thUDhiH+lO
 joaUogAni7oqrxeTDS3LscLLsK/IZ07nV1u+P+kcBgrP9n5rE14Pf6iteNqAc9Qn3njwF3HbccG
 rePR2oAwtK1eBDeSlR+mYIHSj1My2+/vy3sDWxEi9eBQK78f+DAuizxyHgUWUN3DPoV5iAUAA8m
 D8Owd7yXstVs1nOqlz8F1qOv53Yoedz1/9Q22yrWwaZkFIV0oMQzRk2z9K/rYyjamKtyE2FpeBm
 3kC1N/6dqNifZDW2O3zai+Ita9bWlp/T/TTl26uYXwI77C+k+Kxb+Qg9VMDJlmVm9nZNv4Wl

On Thu, Jul 31, 2025 at 04:54:38PM +0200, David Hildenbrand wrote:
> On 31.07.25 16:38, Lorenzo Stoakes wrote:
> > Nits on subject:
> >
> > - It's >75 chars
>
> No big deal. If we cna come up with something shorter, good.
>
> > - advise is the verb, advice is the noun.
>
> Yeah.
>
> >
> > On Thu, Jul 31, 2025 at 01:27:20PM +0100, Usama Arif wrote:
> > > From: David Hildenbrand <david@redhat.com>
> > >
> > > Let's allow for making MADV_COLLAPSE succeed on areas that neither have
> > > VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
> > > unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
> >
> > Hmm, I'm not sure about this.
> >
> > So far this prctl() has been the only way to override MADV_COLLAPSE
> > behaviour, but now we're allowing for this one case to not.
>
> This is not an override really. prctl() disallowed MADV_COLLAPSE, but in the
> new mode we don't want that anymore.

Yeah see below, I sort of convinced myself this is OK.

>
> > > I suppose the precedent is that MADV_COLLAPSE overrides 'madvise' sysfs
> > behaviour.
> > > I suppose what saves us here is 'advised' can be read to mean either
> > MADV_HUGEPAGE or MADV_COLLAPSE.
> > > And yes, MADV_COLLAPSE is clearly the user requesting this behaviour.
>
> Exactly.

And really I guess it's logical right? If you MADV_COLLAPSE you are saying
'I want THPs', if you MADV_HUGEPAGE you are saying 'I want THPs', the
difference being on timing.

>
> >
> > I think the vagueness here is one that already existed, because one could
> > perfectly one have expected MADV_COLLAPSE to obey sysfs and require
> > MADV_HUGEPAGE to have been applied, but of course this is not the case.
>
> Yes.
>
> >
> > OK so fine.
> >
> > BUT.
> >
> > I think the MADV_COLLAPSE man page will need to be updated to mention this.
> >
>
> Yes.
>
> > And I REALLY think we should update the THP doc too to mention all these
> > prctl() modes.
> >
> > I'm not sure we cover that right now _at all_ and obviously we should
> > describe the new flags.
> >
> > Usama - can you add a patch to this series to do that?
>
> Good point, let's document the interaction with prctl().

Thanks, I think we haven't even spoken that much about MADV_COLLAPSE in the
docs, somebody had a patch but then it fizzled out.

But that's a separate task, will add to my TODOs in case nobody else picks
up.

>
> >
> > >
> > > MADV_COLLAPSE is a clear advise that we want to collapse.
> >
> > advise -> advice.
> >
> > >
> > > Note that we still respect the VM_NOHUGEPAGE flag, just like
> > > MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
> > > refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED.
> >
> > You also need to mention the shmem change you've made I think.
>
> Yes.
>
> > >>
> > > Co-developed-by: Usama Arif <usamaarif642@gmail.com>
> > > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   include/linux/huge_mm.h    | 8 +++++++-
> > >   include/uapi/linux/prctl.h | 2 +-
> > >   mm/huge_memory.c           | 5 +++--
> > >   mm/memory.c                | 6 ++++--
> > >   mm/shmem.c                 | 2 +-
> > >   5 files changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index b0ff54eee81c..aeaf93f8ac2e 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -329,7 +329,7 @@ struct thpsize {
> > >    * through madvise or prctl.
> > >    */
> > >   static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> > > -		vm_flags_t vm_flags)
> > > +		vm_flags_t vm_flags, bool forced_collapse)
> > >   {
> > >   	/* Are THPs disabled for this VMA? */
> > >   	if (vm_flags & VM_NOHUGEPAGE)
> > > @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> > >   	 */
> > >   	if (vm_flags & VM_HUGEPAGE)
> > >   		return false;
> > > +	/*
> > > +	 * Forcing a collapse (e.g., madv_collapse), is a clear advise to
> >
> > advise -> advice.
> >
> > > +	 * use THPs.
> > > +	 */
> > > +	if (forced_collapse)
> > > +		return false;
> > >   	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
> > >   }
> > >
> > > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > > index 9c1d6e49b8a9..ee4165738779 100644
> > > --- a/include/uapi/linux/prctl.h
> > > +++ b/include/uapi/linux/prctl.h
> > > @@ -185,7 +185,7 @@ struct prctl_mm_map {
> > >   #define PR_SET_THP_DISABLE	41
> > >   /*
> > >    * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> > > - * VM_HUGEPAGE).
> > > + * VM_HUGEPAGE / MADV_COLLAPSE).
> >
> > This is confusing you're mixing VMA flags with MADV ones... maybe just
> > stick to madvise ones, or add extra context around VM_HUGEPAGE bit?
>
> I don't see anything confusing here, really.
>
> But if it helps you, we can do
> 	(e.g., MADV_HUGEPAGE / VM_HUGEPAGE, MADV_COLLAPSE).
>
> (reason VM_HUGEPAGE is spelled out is that there might be code where we set
> VM_HUGEPAGE implicitly in the kernel)

Yeah to be clear this is a pretty minor point, and I see why we'd want to
mention VM_HUGEPAGE explicitly, as it is in fact this that overrides THP
being disabled for the process.

>
> >
> > Would need to be fixed up in a prior commit obviously.
> >
> > >    */
> > >   # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
> > >   #define PR_GET_THP_DISABLE	42
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 85252b468f80..ef5ccb0ec5d5 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> > >   {
> > >   	const bool smaps = type == TVA_SMAPS;
> > >   	const bool in_pf = type == TVA_PAGEFAULT;
> > > -	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
> > > +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
> > > +	const bool enforce_sysfs = !forced_collapse;
> >
> > Can we just get rid of this enforce_sysfs altogether in patch 2/5 and use
> > forced_collapse?
>
> Let's do that as a separate cleanup on top. I want least churn in that
> patch.
>
> (had the same idea while writing that patch, but I have other things to
> focus on than cleaning up all this mess)

Ack, I'm fine with that.

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

