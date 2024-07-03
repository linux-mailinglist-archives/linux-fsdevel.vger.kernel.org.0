Return-Path: <linux-fsdevel+bounces-23015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31E925861
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E594728216C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D615B54E;
	Wed,  3 Jul 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mmhtI/gk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBKJmcYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738E14430D;
	Wed,  3 Jul 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002228; cv=fail; b=ruvn6kkVcqT7KwEOCgWqRU9KR07rlG3ft+b8D64k0hU5/Qo6olJJ9Ll5e+oFRd0CrDHlbGkrixx61zlzKJvdiTPxV6Qcx0bhCxKEWcYnBdVHMB+W4JdLALcW6VL80hzfQjBJI4yLaIX4/HD+ftuEgyT+Cn+lP8XlTFYI6CiDnhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002228; c=relaxed/simple;
	bh=mSb4JMBWVdRCCaEZmhNrs5qq0vpjCTDHOxn2TPocRrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOW6xxAAa3QNzAlDjsNqTD+c8cLPcysWoekryv6KFnpjX4VLsLOYJVJ3aYJzvj7eX4TAmF/Le11dOrWjIIXEz5nuLoIeH5m4CN+IFxNhUrpyuDZKYyb0vaQdkGLhcM9/lf0ydUnudYgfqHHpbYRVGz79itYau6gps903XMK02WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mmhtI/gk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBKJmcYo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OAJN015967;
	Wed, 3 Jul 2024 10:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Z/yY8bAX+VIPiCg
	KlCLgL/y9DaS1iF+YLE7ICgNpIuM=; b=mmhtI/gkHxcUjMA07mTB5g28nlCV01T
	pPWCTvjOC64rzvGD9+x5Lb/le5vyUrEJdHAYrbGvH6zGuRStXI031LAK+Rd2ygS7
	apQ99PgITj8vB1DIRyZhvTbuQsMnAunP2yXiPuuFzqblDmoLl4jG0qqUYU3sn/Tc
	SSGw6d3/FHFbZC+s5tw17S+axtYQwIiS2b4vgW9rnxIP9GrkpSzSfXjv9IrilnzX
	2hTqdLGE2OEyrprGA835LuxoWwTU8yrAcvbpqNartUpHTPxpTxtdR6dKIXjDzMsg
	VXXl+lH+iUK65tOZ2UTByxQG9/1thOxBcg3KlH1Rq1LVmAmwG5Ow8IQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a597naw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4638dbvC021541;
	Wed, 3 Jul 2024 10:23:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qf2nem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjp5wGm28t5j4amju4dLFAMuLUCM8KcSKyPRTAognCL4yiWcnn9vhkqB99I/gi/11m/x0QP2pLIdB0MFm8W1bzhe61zaaelDeP5v0mHDz5SBNNGbPOZzzj67nAdepKiHrfo9YPc2YoHPPwCmFd2+82P4OToMH0L1bOpbrjB1LTpekDIe3Wbgx4eparVPOvVRdNP8dVEbvdlX4uh+4BT+STP+5bSbPUYyhka2uz7OcLzT2Z/JVbfoSUb6L3pg+f01pI3SNAPRy//CphO+2E6Tv3ISWoHDBt0M3slqJMA7zP+hyi62bR3x8v51vamdxc1xGjPBuC3KqiFiayV94xSuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/yY8bAX+VIPiCgKlCLgL/y9DaS1iF+YLE7ICgNpIuM=;
 b=U8ipvQxQhDfiZ6tNGrSbeywKSr+gyaSK/Oo56yNWsChJy/BfybUi5SZt6kiIpsMhahERUt7yBbw0ooAXHzpLn3XhNHQXEby6wrEN+l4my60Xzi2/aHxfByibsE8db3GBHqupWOLC6Ff1tcm1QNu0xrWVthLvzeX7lLbamNLFq6rdr7eqTFgjrkrDQI22yGc7fLHu8FFWbKJHlSc9yJMLOqM9ngJyUfJ6zQq28CPbGDTV0QAkDGGV1Scuj5Bs+PDjNWgds4St0RzxYmbjcqbfOvI6wnVrQopVfTYE2Jj2iCtWOtZSC/y4GVfWns4hgjZygIakVHq3DFeq95llWUM27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/yY8bAX+VIPiCgKlCLgL/y9DaS1iF+YLE7ICgNpIuM=;
 b=qBKJmcYoiLpluzBQZi/28NkrMDlzY3iErzxdpZArWO4pstpEqCLrkTa6eI/31DEdc6mwuJebS5w+FY5n3NTqIZL/2JBwf5LAmXL1v1ovIsNTpYAXdB8yaPuC2busA5Tim91W5O+DbYOU0IPeb8KQkMKjdBAjZLLc4ewMK/gxva4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 10:23:08 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 10:23:08 +0000
Date: Wed, 3 Jul 2024 11:23:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 5/7] MAINTAINERS: Add entry for new VMA files
Message-ID: <7f21ee1d-6c23-4a30-9918-f4e5df608e8c@lucifer.local>
References: <0319419d965adc03bf22fee66e39244fc3d65528.1719584707.git.lstoakes@gmail.com>
 <20240702231933.78857-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702231933.78857-1-sj@kernel.org>
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8394541c-f7ea-4e54-ff14-08dc9b4a21ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v4uZviz9cAaQUJJQa9aTpDMl+3hgurTXqiOj5i0lVWMEiWu9+LxpXDMf7xxr?=
 =?us-ascii?Q?sbscDz7qcEK1AnxUvAKv16EyrQkBJfHVKBHyUXMaUTdxOgblHxV2Gl08yMy5?=
 =?us-ascii?Q?uzTlkBYUd+QiJuADT4NmYjSdQbLYJOd0Ykr8WjGJvZXDCb/nkPGlSUqCAXXM?=
 =?us-ascii?Q?gOH5Pv5Aj2k6w+Ztk/bUd/3IDTVfILlikxSF1xT3EqvAeJejd748p0oxTxwl?=
 =?us-ascii?Q?ilRQBu0Bwlb3z1sflC/IFaFKyTS6lCbhdTpJeZH0uigklLmkH+B8TBnY+OGF?=
 =?us-ascii?Q?BpxmHEjGzO6ps9QmbZ1Z5JiDso/49ftlZ58oynn6oBqL4R3ek8CCeawaB6RW?=
 =?us-ascii?Q?YnKhIUUFnBmYAn4KhzxX5LdQRdXYeyqd8iM+wwR0JxFQHI2v9rZG24Fif99b?=
 =?us-ascii?Q?ERmK9WL6ol7R+NILratMs4lzFDObC2HkicWpZZEuqrDmfwOZpxuEd+h/ZijS?=
 =?us-ascii?Q?gFOIkHIjBKkdv9i0qk7MjRygUW+ocay7Bt1yFhYo4rWJyH/UTCksXiSInrc3?=
 =?us-ascii?Q?eFfkFzC3EOYp6V/MMmUn6ZJBg87QNKEwjwcLEUNhIqd7xL2f2AbcXPK3MefT?=
 =?us-ascii?Q?w2sFymOa3mzSWK7y03jRCyE4gkw7HiWo4YXH3236cj2Jvb5rYG0WiXA+U7Dk?=
 =?us-ascii?Q?MWHqKcpGXK5kXWur9Ls8L4zx8xxClmf+mjj4Yg98CwMhjB8OWMr4Pz7q6KkC?=
 =?us-ascii?Q?czdWaud1wVWlPB6HLbhpunuH/dLgAwSykn8sPZdanVUcCx2pEAw8xi4Ko80H?=
 =?us-ascii?Q?l1/74np4nzALP83U5M+SQ92dYx5dqNNLNGp7b0D5WVFCQeY+5x6vfH2KAZRE?=
 =?us-ascii?Q?k1f7aAsoMD8Ouopn0AZpYKQXBUr1BztBwnXam7mXPDgU3P5CmRkQpDHhsGNX?=
 =?us-ascii?Q?yLiFA/9Fjx8eeLU73t4LKmvPUBbYeECSpZYzd67ipebAtjdOXcvZlIIa03Nl?=
 =?us-ascii?Q?avwdSWniqaFcSMZ6a8sGn5CF/uC1MnhfDNjRNgtOXY7byVzd1yUfYTAeUQDH?=
 =?us-ascii?Q?wNNENc3Fy1K/g5aY8Egn6rdl7YjA75TOxniMm50C9CRw+CPePMpPMuE57QPv?=
 =?us-ascii?Q?OBnBG59bPIyB2yiF1R2thMKmwhEKJcy+2snaWAIcqxh9l4zVXdjDdML18nHl?=
 =?us-ascii?Q?wa2QzPKcPOLbyFkmome9epzJVL91aoGg5SYGBsky80FZtaltQ1CB1B2hetjN?=
 =?us-ascii?Q?JZJPMGDaQnR5KzIkXj6h35JJMb0P57ORwjDszXNwIqrXnb+/MudA4OjO+Xta?=
 =?us-ascii?Q?858Ql4CJeG/BkBXRYucXGHeePxXAS2A08B7l2xpM9x9clUj71JVt0GyEHN97?=
 =?us-ascii?Q?+/Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JojMYk5KajHYUptPAhmuTMPkBStcqXVsN2E5VrknWMBGbLilQkD8Tet8GMYL?=
 =?us-ascii?Q?FRQAYp8gVdRQxjcwSKkZcnD4c8L5QWD3Th2sDegzDocsMV4fnngGRtBCIJk3?=
 =?us-ascii?Q?Eq23mg/fl16lOk9z2nppHqd9ndsF5++bmF/RxEky3dmNk0Jxvero3kIEUYZ8?=
 =?us-ascii?Q?8OnPvKMg638JIKzcij95Kie0iwWXraHgdv0XRFEO5gQ7/kJ0hvcfRmq0VIP4?=
 =?us-ascii?Q?vvzcrw8JtcDsywx4T05oMX7qNyGg5kEEePXkdbay8bkZ+Z26hxrQxQHFSuTq?=
 =?us-ascii?Q?MCs1ef+HienOgKFri/El7h4C9QyWXHSo7GL9BNc5fmQ2qcBFUMTGsVbzeLIl?=
 =?us-ascii?Q?1fASC80M1vSdLGVvNCjoIOEYrBiLVHe/e8muZpg3BeOIf/dPXGj2oh80B1MD?=
 =?us-ascii?Q?KMNuCU8OF2yx/x25CHiayJgwPaXuF6W/CaF8D0iobdc7S2b2Ns1FWqgpKNSN?=
 =?us-ascii?Q?OOHk02UHbMEfU4ZoIglUiWbVTdZZzuKqWwaJQLG4tiveXh0SZ32JPFzOD+ze?=
 =?us-ascii?Q?d3GCUH3BaLJSI55NG8QRHb1iGWOfgHEtmPWw3dGtf2etbukC0MNy5U7U+/oH?=
 =?us-ascii?Q?xK78Xv7/jXhjMSVeR7NcZuVPWvDrCmbqcZFdWdRiuapE/4pxSAGDG5S3x2vA?=
 =?us-ascii?Q?sgOeFXFWDdbhAqdHzBTSJ28bpIz4HDasocm0QtzAj1/XuzA9MvVxyJRlnwcE?=
 =?us-ascii?Q?Ql+e9QhfltErb4gSEIsbS4ti1O8uvv1yLoPH0w63ObGaFqhNL+dkEhgLjdNQ?=
 =?us-ascii?Q?rQ2GE+HVfnBCcvw+u3DIFoL9XUW+i+tPCN+63UQHZKPZzYlSbnnlmDZK+Za3?=
 =?us-ascii?Q?S6Del8GWP0PRg53uKBaT9/AaV+fMJBYsVjGLh3Y08gkFpvFyEKSso6gw7KW1?=
 =?us-ascii?Q?gboawlZlW1PY33DxR9C531MdDGZI7jIhFGSG65uukF5iXZ/1JCMoD9FDZOm3?=
 =?us-ascii?Q?+lZMc88SuPurkyvPg4/fxGnh3632LT7ppK/70KvcD5iay8vhOy2CdldKBWW3?=
 =?us-ascii?Q?thCErzUJh9AJb1CTYh8R/YlLoDEwNQjHGgrmkHVdIJWGcRP+V5IqKKmSgEId?=
 =?us-ascii?Q?1ESica7IT0agJowthgxBxnfX2dY2Ev3ynw7gGqLFhCSER1rFnIWIx20G7Rew?=
 =?us-ascii?Q?Yi+HD+IAQIKU+PNgmtL3n9WwYk8zxVWcoQCvtl0pITKenBlPKeVR23sfzqPn?=
 =?us-ascii?Q?SrJs4CxyH8ih8oGBAMy9XdtFPh8mUJWRl6ebwVvFw6ZEG7Lq+A9J79ujQZX4?=
 =?us-ascii?Q?KwlK2hXZMKmaTjT8li3APO06vybuaWIBhVBUeGUqs73mvlaX1kh+PjdAitJb?=
 =?us-ascii?Q?c9g3z/D3Y/olAz6xZSolY0P/GauzpeUNNlfpDTrbkOKCStDSqnNkMJiM7Zy/?=
 =?us-ascii?Q?Pgg4gYy/YAha4Nn3ky6qmSI3cxQPgn/LqtQBWZCOwjBMbpfuEJR7bVl5O19s?=
 =?us-ascii?Q?8x7Ds8En3i/N+saewgqqOXsNGKnyYVOV53gz8nhR9MPPbvpM1lONaix8I0rg?=
 =?us-ascii?Q?oZ/dDqlEfzBsset9SLEiA5lk54rcIZTO048voMvZ0YJRjgOAi4Rt9v7gB2Xb?=
 =?us-ascii?Q?JmlXp7YdL9uT5tjJJxpnLCrUDNbiFTIro0Zu4u1rLK83XjiAHVO/jinMREUl?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	53ol7pMNEuTt3ilaDHdq/dtOaIALkpDqdFoWJ9w59XmBnXBWJzpOIeEBAXNn57gXjoq3rm45dt2qbJeObGL7WWMSfxBDb8tpzmXo+eV7mk2yDdovce5v8s9SFhqL/OrxA0ylL154d+c3diNSHTYAxrLXwrICTVkKdp1OwIu66YVNmwS+w02POWQbKKB+ehHK4qetwIoB/aE+2KE7C+ZBEiTNDBt+++RND2J1tDjFNTRr/4eZGoSNQqo9yR3a1gnmtBCfEHiTpwBlEmQ46a/7uYYNo6BQA+Epi+a1XcJtY2nJEKlEYCfKNXHagbVvfCx8fh8nMCDT9ZKHiY1kI4IF6h3DnSEvZolmv/TJ6uSYY6r0cIswczTMQ/0HDfnvKIPfio/KRNKOaPdOCTzH9E8k3EvcTc1kq1kTdK8DdS7VnZDefuSSDRATpKIJFdSslKbrMpbIA9xwBMu9idVp7JwmHfHXXzByLQSDntz2DUI37fH3eUu71x993bVGiSnG1suDUPUbhDf1hjpC6SvnXcatVrD3xJ0oFISZldLrs63lU3BeheFVmKBp5651fEcKgT4NZNxBLEjMsjkke9gg+yvvYBChK0L5lny85Cen6h2auNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8394541c-f7ea-4e54-ff14-08dc9b4a21ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:23:08.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PcLOgZVXbA7I7R0WGRm3sWWRoxtipQJ4deHTZlB7TqaLlJ7814eKICyCzuNi1qJhE0A6zmY9qxcGhM5M6fvE5g0lgzutKH41ipTwPjbGZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030077
X-Proofpoint-GUID: DaxU2nIIRoC-dTcfxyzLQzR48SX26avC
X-Proofpoint-ORIG-GUID: DaxU2nIIRoC-dTcfxyzLQzR48SX26avC

On Tue, Jul 02, 2024 at 04:19:32PM GMT, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Fri, 28 Jun 2024 15:35:26 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > The vma files contain logic split from mmap.c for the most part and are all
> > relevant to VMA logic, so maintain the same reviewers for both.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 098d214f78d9..0847cb5903ab 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
> >  F:	net/vmw_vsock/
> >  F:	tools/testing/vsock/
> >
> > +VMA
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > +R:	Vlastimil Babka <vbabka@suse.cz>
> > +R:	Lorenzo Stoakes <lstoakes@gmail.com>
> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +W:	http://www.linux-mm.org
>
> I know this is just copy-pasted. But, what about using https instead of http?

Sure will update.

>
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	mm/vma.c
> > +F:	mm/vma.h
> > +F:	mm/vma_internal.h
> > +
> >  VMALLOC
> >  M:	Andrew Morton <akpm@linux-foundation.org>
> >  R:	Uladzislau Rezki <urezki@gmail.com>
> > --
> > 2.45.1
> >
> >
>
>
> Thanks,
> SJ

