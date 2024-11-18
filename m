Return-Path: <linux-fsdevel+bounces-35077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB9B9D0EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DBDB27506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAAE1974F4;
	Mon, 18 Nov 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YxAeXDt9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMrOSMyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD24192D80;
	Mon, 18 Nov 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926012; cv=fail; b=sFLzsbE60UB6IMkBdgYXhleVlBXCxSAU4gh8AJdGKT60Fjxl0VY8UJbu9hvgbaUF/BdeuYwT82KHMlJ+wki5OFC4L/0mdU4NfYqhpf8Mmy0KjxonTewGRSR0ngvpk0K//iPFc5BomqKnXnjJ+hJVdl1S+EBe2xqhV2rIX4tggZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926012; c=relaxed/simple;
	bh=yXaq0flYPIYsBPJUazOQ6xjKlmwcc+cy1b5zeyrPmnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lia8V46MyLaoCrD9AR/7vKNly0x8egg9jBVx4FH7LmbyBraDtLfLlSX9OF9CbCekBdycH1il8MqdxkMG6HlbYmPk+XWQUUZ3c3q7f2D/P18yB8eLa4oDA29zXw1dyPdxNjRQmh0i+QOTqkjWIS97HJES/gIQkQTmtUN0aTro+8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YxAeXDt9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMrOSMyu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QZqU029752;
	Mon, 18 Nov 2024 10:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7CSgcbuW902E35Wkni
	N0Z6bkvZC++83k6UVVoQNRb0E=; b=YxAeXDt9Nfl6TkSNX9TJUvneKdEXHGMHHO
	YqBpEiIN59GIyEnm/o0kOBONWy0wrTiufrRIWVlgyui7fJiLjAoja7dVG9Veo577
	rNUePnACMR+hpE6HDTD36j0VKqUWOVaMj9VJPKhELMm5S2nSWeo2wMnt8ct8WdVf
	W8L/2LgNlplt2PBwihYm9FSeZXv4Z6fD2bxIj5ca5T20vzUw5tadZ8Q5K4WNupqz
	P5+zEziRdQZMn/XPnfvmONGkqxfGOZMDHCNK951MQAwmscF0gr68TdydUOgkETmj
	rEQdkghbFMFJLhUcr0yNYFyYfh561gqZlqM5ZClsHooCvL9JfWNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkxst9em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:32:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8tnNj008462;
	Mon, 18 Nov 2024 10:32:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6wfxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 10:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roS1JxYPELJWjap+a53R7KDc7I34WvuKDndPbqhF5uZLMIXccLCREn0DCYa0fSVf3poX6oqNtO4/6dv2ZmrUuzqI2qZViRkcHYUyFXXdLTkAv7ggBHeNqjJMbfkOOiJVLTCtvExNBsC1X9Nm9lceA6JAVjZZYKEW8IQ/p2c6BxfT0HfyohDpL93dkvnmBiGFd/p56VBsZQIllKAm03q+ybI6UCur4bXbEgwNrY9KWbTDgVTcYoPGByl3hDHYYGl14oOHyQjl4No5S0K5ao8rZwoe6hj5tlk3C/hGqJ/YAdss9AVm5UKpu0gNY/OL6CvS8eN1cOxKIuQ0tE9Xkfs4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CSgcbuW902E35WkniN0Z6bkvZC++83k6UVVoQNRb0E=;
 b=aPB3VbCL0kbaAH68f4X1d+RWfzL8AfcO72TuXVU0vo10FKkHGcMBQxD82FO/0nR47yd7Y6FwP30YdtlteUdIdEn0tbZ30v7B34lTIyZ3qn0LlVNWVuBGGVuYk3v1VduAeXa3yv9pcGKQJikZVUDVfx/7qlcBO4GE3DE+tuS4pgQa9OOKnR6KcoHbAygQRyLbytNBKM5P3v7oU2veuqv3DCosL3ldo8od70OB9XtVAsZcpd+nVgQf/QN9/BrZAVaqYME7s5c7/g7b9/YqCpwZfFjDPIMRFLZgUauEb2ypg3CHmTLnAFY4VH+9noN7el88iQrcWv6WdU/FtF73a8s4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CSgcbuW902E35WkniN0Z6bkvZC++83k6UVVoQNRb0E=;
 b=TMrOSMyuZfFfSo6eJvyBrZUXzPff3/Ct6LTP1sVlp6GCRvSOPvK0Bmcr4ceecGLvzCtJwLAZW4RLRuSlylXjFGHLfUh2Zp4H7k7d4YDlh3ehf3j5RNK53bq3GC8xTvcanD7mXL9idMKLMaI+fEJVQmijbFhRAVHDrQlkW1kh8oM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6723.namprd10.prod.outlook.com (2603:10b6:208:43f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 10:32:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 10:32:41 +0000
Date: Mon, 18 Nov 2024 10:32:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, derek.kiernan@amd.com, dragan.cvetic@amd.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
        vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
        willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
        andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
        oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
        gthelen@google.com
Subject: Re: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page
 table
Message-ID: <0deb55a5-8ed9-466d-8dca-1f4229ba9334@lucifer.local>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-3-pasha.tatashin@soleen.com>
 <ZzrjYtoC3G0Yl8pM@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzrjYtoC3G0Yl8pM@infradead.org>
X-ClientProxiedBy: LO2P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f8da93-999b-4ef4-0150-08dd07bc54ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ASTBJMTBiqQVWieOHFczkwiTxm2maH8QtDV1Tkv2drBL8Xxb5bXor7bTknn?=
 =?us-ascii?Q?RAF3PyIQw1bDU8TK3UWBq66QLNLqT7o4zJLdD0AXFm1RKlwMd91ALasGAksC?=
 =?us-ascii?Q?1OrvOUuUgh6jEvKmFNE9PLKhir+oSWt6axTK86S0Tw0gmm9pC9GG/L7qwwVD?=
 =?us-ascii?Q?VfDFCgLOLyVwg/BoQ6LyQ0UK1LlqaFFPDK+vzTUK7F0ElT+Qvgi+sUJBwifn?=
 =?us-ascii?Q?J1whyoyQ0u+ABQNdQHXMjtclO18yvHvDneMnVVp2rJIqDUYMs3HIMHBYlCnW?=
 =?us-ascii?Q?3vbgr7MOC06+HslopSO+LT4xSvVg9HcA939Fe5z3Yw8xCi4EhHcmfewo31TA?=
 =?us-ascii?Q?9A0XB41E+CY1anTTMt2A8qlVo99D1oxZLY2Tz0Gy57L1/pyW7tAchvrrvRHn?=
 =?us-ascii?Q?cL3+gIB1oi0TLfKqynC0GAkngMvUxdsTrVyi3MIP55nZ9zM8ySqKDj0368xZ?=
 =?us-ascii?Q?/Jy/xWXE+uE6vP2uASVp4rqDvBy42rXio9DPgTNVNzkJzq8cvgoFymZUV0y3?=
 =?us-ascii?Q?5A+u9YQj7/xZjTkLMdPp50K8yMFMgfr8tTFjbRwyVpwVAsmyWFvKPDCQPlFC?=
 =?us-ascii?Q?bPe4dc9/ZJUYc44qgMy3haROksVM8BZTzoH/wNGyC3tTr8TIISBop0JrIR9Y?=
 =?us-ascii?Q?HLvqhfRIzLf9Q+1STADbAPeufzFZKeriHodCAoz59hcNIG34+p6T1DreDKGh?=
 =?us-ascii?Q?+1PASuAMLyDBnHzifZ+0g7t4QcCNNSP930eQpA0mzWeaDQOgBf66+DxDzLKm?=
 =?us-ascii?Q?qQyWjzXsN2Sql9RNhpX/F3W7cenH2QqQ9asi85SjUv4WvgqSMaSxf4xwBCnm?=
 =?us-ascii?Q?/TnyEaS4LCKJAvfBmqKvQOE63tT3AkwYerV1lVjQXXodvRZG25LhISwWN2mN?=
 =?us-ascii?Q?7QxgXKF0honzrYibaAjsqpuqqCz78fihAuffdujgu6D+3aTAimS0yyXj8cGp?=
 =?us-ascii?Q?1KofP/8BVmmwKdZTGesZRZ/rfP4HieSx1ByWwsagNZWNtJ77NStjbWif304O?=
 =?us-ascii?Q?XkNAsZLxPyHcbGUOUz1HOk8mcsFxZ/siTOjAdnntYrWWf7KTbyo3/0VIg68M?=
 =?us-ascii?Q?wWkC0G2ISCw85u5Blur07TQSw/IxnCz9GRoi2lRhXrgC1d7w7TkpL6Wl6F9d?=
 =?us-ascii?Q?/dBMKwegqn7MfJJZW8GPqnZsJJ2jMM1cEh081DbjAKJccyxS4f1zp8nnC6na?=
 =?us-ascii?Q?JrCuwO7K4C16cOTJZINDSRkpsmPZsCpmqdXJ553euCve4iJ/ZjKiqu/Akcxl?=
 =?us-ascii?Q?gnSOZQMzwcIfxwhZIfKEdxhdw7h+I5z47dc4AANDqHbT8P6oifdKeP44wxjp?=
 =?us-ascii?Q?lGrHZqF2hOR/vKOOS4nUrJjM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGGYzhFHFq3gW3reVxMQJwQlnfWfmEcM6t1LXZaq98iXiGLAXQuqHLsG8fdB?=
 =?us-ascii?Q?4E+XeulydIycQRorHe5M08rLFs8AIpxJMFwX7dWoTwex1QxtPY9IbUTs6Ybo?=
 =?us-ascii?Q?pEwac33ORhlajj9sddyAZGOV7OFhDeX8OVHFOSc84fVdRFMwCKNZf8m3a53Y?=
 =?us-ascii?Q?UQ9rrDmlm+DTwrbU/hJRes46UKkZk97/jjLCWD+uXENXRRnMAD0yOV32AfwA?=
 =?us-ascii?Q?2jxsOiXKrwAfHJ7lNpQao41NQ/m1+h/b65IUDhOWphze36jgSuLKs9HayfkM?=
 =?us-ascii?Q?w0Npl4yf6JJX63aM20y2tDbZrimcCVC/w9k5CO6OUIwnpBXnmepCNJVrWfPT?=
 =?us-ascii?Q?yK30VWndChey/qPvBFpsObth0p+wgHvJbWs8l1ugytyFN7WM8QW7qeoHptfY?=
 =?us-ascii?Q?JkZ7l/BdrdccQxy1abKBswtlfmQTrE3K2nOjv5x1GxZneF8JDiizXMEF1HVk?=
 =?us-ascii?Q?k9kWaWuQsHI0GRHdmMMsQAzuSCEB7Fbg1QRKLnv38QqZ7lj4xK0000CDlJTI?=
 =?us-ascii?Q?Vo9E7vEcy1pSjbZji4WCv8omIyd7a84+VWTbVQ8pwc8V1mzr6RHioxAAfkXx?=
 =?us-ascii?Q?JYqJ8LaIJsqj1ePwE+INAuPwPOo1ov6fMkrzmUOH9VJa6b+Ea4R508zyL/4Q?=
 =?us-ascii?Q?+RzUMWj08E/DzY1LzKZXFhpY7c8+qIq4owoW3CXfKXp5UWxskwIBKa1Z/YcR?=
 =?us-ascii?Q?Nsv8/xjzCOqlbXp9ExWR4VF2Y+ZlexSpyR3oIjckaEOviw4i76V1N8Sxf52T?=
 =?us-ascii?Q?FfbK8UdDuajp21TlTH1I+Ndcu9Wk4eU0bY0QSveXG8MZjNag+ddILIKfyPJj?=
 =?us-ascii?Q?P0DvBQgQZGFAYcICgJlW1D1eTsBCJl88ML6ewoNgbnfKu1C4BFMqyXtnXc5y?=
 =?us-ascii?Q?E+H+fTwZiMWagyT+jlzZmqIi+FxXpLi94Su9BO5kGrcnaOd1ohR+CWZRuipq?=
 =?us-ascii?Q?P6nkabXpYAAdhiZB0uHbTiilUK9gGPnytGvA0u6PWY67ZRhWoOdpWjvz0Y3H?=
 =?us-ascii?Q?iD41R8XM77ULBxdPYBXuHJKElb6ySOW51FvUu84WfnkeUSKaci9t9jgjwCBu?=
 =?us-ascii?Q?3Xc+8LR9aDCRf3+KP6oPjKvvjTH79LyS6q0XoCbUCJdq/lfLMhrBv1jW4y3s?=
 =?us-ascii?Q?ja9XxzCXYVOFGyzr72lnfm1pYuMnLZ3fwNtqRkfi7qono0AYZ9poEkI7LUgh?=
 =?us-ascii?Q?CHEuUB4XLXtv0WCO9I2sTEUoWHYNQ7raCooNvzfY+jpWO9JZ+PI6UCNWk56R?=
 =?us-ascii?Q?R6HepBHcQ/XmFH3mJMLqDObN8N2aJfEagYBlAsHtwDxXeRXBVrUYGGDm46pR?=
 =?us-ascii?Q?WoEa5stbteq8OzmMQ1hUDSJzq1Ylx0by+dKVOD66tsaAvtPImsc9hv+U7gRE?=
 =?us-ascii?Q?CUha5z75rD6f7Tz9/gLDLf3sb0b6SttOo0++AgkgZSmtwJ5UzMlJiJoQ6B+l?=
 =?us-ascii?Q?xL0gUGBhOrMCuowETleVK/OXTNDRKOH7M42yz2SJTydvSrPND03hrVOd9K6p?=
 =?us-ascii?Q?P14C/jKPVl6xTPraYgO3Ako6QC/i3vnMbdLOMyf8VbQtZeEEOh6/ZOm7Geuk?=
 =?us-ascii?Q?abExadP5MUEVj89fvzK0e38BR80WPmSGXmO0ogXFMd9B6DwvDBX8LhtPCPBe?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OnIECU+bH9oLdE5nflb1KvRnMfPmIlacL7ZbYiY0c9sLcFSveM3rrxFkEPA0NOTU/xNpxZMr2Q8RC9Vvi0vSZulKuodAGlJBTwS4BffrLvfCDT67lZNLY0jpDjVP6X7nVQ8H+LHn+OqVKLtynj76tV1cLDcau865dXkT33z31+kFtA+o23OhBarq0SEAlgT29JpJp5d24HrbC6WnvP8unMNALokOxhPfr5QMunEuM6p37UCaUXJgpgSD94BFKhniywiK9Y8bvIwort0lPyJBl9D+xIHMIDFlfXpQ3teHrel5XEYqu5AeVG1CgxtIhgmOopzM9/Ok2vLlq40kA5iXI7sTbFRW4V74PmZk2RQ2KfcOObkU10iU/qFH9cb6s2fhDFK641wq6yxeRkuIpi+Ku9JmAwezXjrM2sshbSo/O/mWZnHwMpcpEDSMBiktLDop+toGB+F7kPrg6HFS7prbl76+7ZdMZrk+noLrHZhVO5IU251IVFp/+sBbJElb8MAXSL7jEoinvuUwNWluNzAZh51zUWtovlDMS+end62YH96VgZuHN4CiuZgUuvn3LkAY85YpnpvzX4mDvJHw36ugDZmorsTNVLSBZPjTZB+BVVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f8da93-999b-4ef4-0150-08dd07bc54ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:32:41.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpNILQCMs076Wvs3t3AK2jrom/YmgBwsRvaOjpAcowmUHYsdgNNpYeaccSZBvjrrLmW+t6uCIhWZXNuaagQX6SQxUIVfEOY2I9hK0CB+C1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=948 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180087
X-Proofpoint-GUID: 9xucUbX-euAPS08R8MaKgtMRpBh3yKes
X-Proofpoint-ORIG-GUID: 9xucUbX-euAPS08R8MaKgtMRpBh3yKes

On Sun, Nov 17, 2024 at 10:49:06PM -0800, Christoph Hellwig wrote:
> On Sat, Nov 16, 2024 at 05:59:18PM +0000, Pasha Tatashin wrote:
> >  	} while (start = next, start < end);
> >  	return err;
> >  }
> > +EXPORT_SYMBOL_GPL(walk_page_range);
>
> Umm, no.  We really should not expose all these page table detail
> to modules.
>
> > +EXPORT_SYMBOL_GPL(walk_page_range_kernel);
>
> Even more so here.
>

Very much agree. You basically then have the ability for any (GPL) driver to
come in and modify page tables at will which is VERY MUCH not a good idea.

The rules around page table manipulation are very subtle and constantly
changing, this is not something for anything outside of mm to be fiddling with.

Again, I find it bizarre we're exporting mm internal implementation details to a
driver to do stuff with rather than adding functionality to mm.

