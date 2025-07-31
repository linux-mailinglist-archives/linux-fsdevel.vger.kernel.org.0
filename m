Return-Path: <linux-fsdevel+bounces-56409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CCB1716E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7F11AA0537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAA2C08CF;
	Thu, 31 Jul 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g0OCrZ9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ejIe1wts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267B22FE08;
	Thu, 31 Jul 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965715; cv=fail; b=od+3XqdwZUx0JyPH+xkMDGgzuiAsAXOsGE+GDd+9of09PNMpdJtGfqtk60HRAaFXn/EZQdZ8TLDh9NacAhO1IDuIl+LgEbEnIIvCF4njqJ0lUIGDeUMxGavG+yaWDhx89ZJRRVRMzqSbATvAE7GtvWIMSo9x2bVLjiLKFzVY/Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965715; c=relaxed/simple;
	bh=hxv2a4Ha/gdCS2kJbuFGa7Y0RLuDUuyiIzag2f0TEz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LIe5atKPRTJMQJyR1mfM1fVILOV3S2MdAEy747Lj2AEupKt6utsx3JpJqzeMrzZHx6s1t0IW6COomvoO+90hz2kr+yH+CNS0iq3T5Sxf8umbLkQwYhDLX+b4xHxZp3tXoSltFK4GMnRp5ut/ljAyt3RW+fCwUVnhGIqnCBKn3Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g0OCrZ9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ejIe1wts; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAsn51021814;
	Thu, 31 Jul 2025 12:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=COfV8UtpbXjGLz1VoQ
	2IVOIGeRq/93aXTVw1gDFkoJ8=; b=g0OCrZ9EEgPlXt5IOwy3L4pWy8IAaVQmWE
	qiLnyJtQlx8Jq+DJrAQ8M4AcKZ1k+1yH/nAvthWydY7Jt2oyt71TURBX/ZRJgJt6
	X6yZyKe2BELA/QoFbclgXtFsFAOxz0RyQwpYMtO0Xbvok/ibBM/Chm4XY4anouHB
	xJZ0FKojk6OYXOo9c+eDaDJA2jQCYW6JwYLxrpCrgyPyxbl0QUkRw/EYC2Utfffq
	43+6DqFMGSdgTbu5auSPVlPb7h3dZnGBt7LFEF8r80N1Wj+UHnfbwGJ8QeMAr2Jl
	SYCSESjEeH38o99iOUnjWIrInHxEepjufFYEFkfZnCywYQtIPTGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p0vf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:40:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VCGBMW038558;
	Thu, 31 Jul 2025 12:40:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc698b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLYQ/0OJax/YuHjP+mhdotvIlef+V+ab5EDHsXgIpG/73cMI7eyy9AaT0/wTIwzt338q0/IWx8lrIzlpEB0mSlaFLCgH4A3sqROifmNtYxIu5PbhBEkUiNFWBIrzxANxll/wVBHavhcYhJChVFfnG+4Q6uweKHfO5fVe4cj5DqWPndvp8EHufRhLUGWgOJY8tOiRZ8TcoBjWESXUzJLU9IntuTlaZl7JRnFDL6VxD7TmPsdo0h2w/1ixFHMONCcetnVqGdx+X4otqcYiBPQFDB+yrAfqCA1sMEFnLPY1pNHeOsJ9PtKGzNoxcmcwdZ1yVz+i946yNF+LXhMlHrMwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COfV8UtpbXjGLz1VoQ2IVOIGeRq/93aXTVw1gDFkoJ8=;
 b=SLo0QhbXpYQcfCkEycLEXQ9uUppIU726euAq6OmglEUG0f7K6JYLhWcz1k6km5w/ZhpnmkPN0E0Rak3x4P3KegpGPXYwAbchsU9cgL+dlagOM/onvA2IBGkuAxjkEPRg5kJ+ppCxjDRoZG1sRbotTAKMEejg62viIHXX8kk73E3ELgelwgAw+oweVdTYSOwRGuUzgc0O4ZPi9FgLv6zfpXYrwW9sMQ/PynnOaWP8+Au7MuECJ3j5aUcV7g/718JkPev67m2xv6dpGmMIyN3reoLP4dJrq6rFaKQ92qm3vJWwWSznHNyu5JKnIknFLKPXmgKtk2JsPHyheJ1LwJmt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COfV8UtpbXjGLz1VoQ2IVOIGeRq/93aXTVw1gDFkoJ8=;
 b=ejIe1wtsAPg1wCUyqaCcOAOst0woA7B6c0Io+XET7GX1dcBi1YLZOEsZBLP5mQN1eBCMo4Jbyix7xVQlvJNGNttlRMudU8rE39E1qnQZXKbpynNebTM78XPsvr9rLVSogoit6J5zg3pcvPs8OiXvK5dBpPnqb6uAR9PwOUvABN0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 12:40:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 12:40:48 +0000
Date: Thu, 31 Jul 2025 13:40:43 +0100
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
        kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <dda2e42f-7c20-4530-93f9-d3a73bb1368b@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731122825.2102184-2-usamaarif642@gmail.com>
X-ClientProxiedBy: AS4P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ecd00-4666-449a-df50-08ddd02f7a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfw6rd9oise7zbLXfuXXgGEQxordlXLK7YBnRrY3N25Dm6nknR5USI+NhhQf?=
 =?us-ascii?Q?YNgVB+3gJikswQaWq6iq5bnCltFPifDXnmJ6H/u7r6y3I+ePhrZLoXuz1Drr?=
 =?us-ascii?Q?acZqoh64iYjfgKkqBLmSeHI/ZjWhefXz2NagVFcC/zXHtgKTuKXjCtaFMDcm?=
 =?us-ascii?Q?wEvnkf5h/omkjmH7P6Tft9+DMwPVhDJ2K1wtMXTiivvcjQ1p2YcIKzsf4WRE?=
 =?us-ascii?Q?dn774cd8PoqZZumgTtMWfJmHvWar4QdmuR2olgrnhsJDIF+x3QnpMrK6xXxR?=
 =?us-ascii?Q?AWIUaVujp81vYFQReikWvb1pHWS6Vp5HsvEOVlC8cR6yXz+gh68qc8s/HxhB?=
 =?us-ascii?Q?M9+GLX9zRbV8/OXT4DPBfoQjcO6jyobMyR+msBOR1L+0V7Fm9Q8fo5LFnI/O?=
 =?us-ascii?Q?4x9QS9QdKXfaNGDf/VLf53lwhbbkPr0w0hrUfemy4SCWjBTNTkLVtYxHmTKo?=
 =?us-ascii?Q?ozGPuXYQAIZXfmHnkniHvHT4dqYtH8GtKTOhCa5I4asvSP5pqUYKViw8WrW/?=
 =?us-ascii?Q?iIDo982wbAAUOsSdbBzukg6l2U/NCwxdftdZdE10v0EzdoatfCJStZdIj/8a?=
 =?us-ascii?Q?EP4Rx0MMMzYYI+GjLRwZ9+YxUhkFJcmGyFe/SZnuuVuIj6J1fuzeVzP0TIoI?=
 =?us-ascii?Q?IgTW9TmrcC8F/MEheRMtrYe9PrnbVqtMWhsRj8xTsLNLZN2XAB9MkCZ2+kRB?=
 =?us-ascii?Q?MhGxFmVeU3sf6R8K+CAPj9cDo9LxdIdy8QWzjphlTD+D5TfNSiTGADws/SXH?=
 =?us-ascii?Q?nhe4U5tu/1sZGHu5imNUm1CskBrqBPkdHzY05Q3iduZoy5ZLtWoLYV/i8HN2?=
 =?us-ascii?Q?3Ssci8Zsz1FC8rDgFOBxmgsG7JAG98LB6MF0n3ysPnGa9FbatMU570+mjEjj?=
 =?us-ascii?Q?6kV8oxHNJZbx7DRk0Pvkeb0WmR6m7wBzIFSN+qTD5MjYbTu13/98BYTPW0ey?=
 =?us-ascii?Q?cBXnYLyThWt2T3fhUZ2ywtYaJgktABBwFK648YQf7L7H3RVD2zvScIReC7Jg?=
 =?us-ascii?Q?GklsrqN/LH7Zw4FsEpa0nZdCMEpJj5+zP9fA8Ee7UOuTJxCxP0ooKY0RRCZL?=
 =?us-ascii?Q?5ma/klfLc98NNHXFG2wd4MRXem7On9rGxmCxMz2mkaDld3SsM/Ux5HqqTsRc?=
 =?us-ascii?Q?XF8ymE5DgQvWno57Wf/GdyD2qm77y4gNDs6kKdd5gz3RTOCIvXSDmWVEbEKT?=
 =?us-ascii?Q?4HyTlF8EJF0YhkVadwj+N4HPuULZp9CI4gY5nNzEt1t1O3JB5d7Jk3vrwMYF?=
 =?us-ascii?Q?bLQnCVbl0QkWFDScRGFLH+sy9QWEK8YPR3GyDAjxL6ANYA71/tJtGQHKWvYK?=
 =?us-ascii?Q?x3s89/sZSu82P35guPYfh9MBjc3NsbCzmL4Xe0zuFnU0E90e/sIPl/QGrcKD?=
 =?us-ascii?Q?to+CoW+JNpTLrWPE9ZXL8wqRRrPf3AgekiAIjxjdLAc6LpcRsNpK/SZkCH6L?=
 =?us-ascii?Q?wCAtHeFX62I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpgHRrSP6H0XhQzn0d4gliAb8Ssl1CiqFtelVbZfuqTKekjZ+WWqYtsh4zzb?=
 =?us-ascii?Q?sAFnrwwXfarOGKff/u76RXPfDR1SetYpNL4NetgNWcAUu1Q3zgkf5bIfSBWr?=
 =?us-ascii?Q?aC+f1dB11lEUN01h7phOHg9S8saVSzZHUY6Dr0YR03RrNWtxGeHE+1A8WRaj?=
 =?us-ascii?Q?nqxHH0EgKTgXF7RWggRhLTcDVdUHPQIxvC2hwQo7OhLizHYQyOLfzm8P4jtT?=
 =?us-ascii?Q?0rHUhMpE1cdFuHd8p8+CKUiI/a+7xLV7fjoi3R5ra6lkHs1ct7330Ctdpt4x?=
 =?us-ascii?Q?R7AcLwbuTWi7HMA2Tvg13RHPzYW0X4okV1nUpRSHJPhCxL6l0I+IyCbID8DF?=
 =?us-ascii?Q?fSt9aO6E77So/Xxi4PJUMHMC5cWTOuJswoNF9SW1U3MznBjV6kjlU9kmiCq+?=
 =?us-ascii?Q?SfLAjYqeR1fcRiO8IdJ3IzjVVzYKJIsHbv+tnnxTCpNrVEMNepVJEms4hp25?=
 =?us-ascii?Q?8O4LEe2/Tuei5IBGqOQ8DSqaGd1HUFTFHgMwTHv/9jmOfw7KVaUq7CJHwtmj?=
 =?us-ascii?Q?uEfEjkgE8ftHyFrT/nZd6p7OyiLuhkzQGchumKLRpFhablsAdn3u/BspTadM?=
 =?us-ascii?Q?+cnMpEGnGRfib/uNhJvYqAujQcsCHsveNXYP410pr3Ybov5F2u0kbllg6iiG?=
 =?us-ascii?Q?WzCZ+Wk51eO0cACBQ3ju+JftB/ZDmeW2MQ3wt+3+kUyXBVDpEX7IZojsFjTU?=
 =?us-ascii?Q?flcFrHV93/zFd7eHddSd8xKHmobEHfpzWVrhWfQ7++f2/w2mAjawZL3yGgbq?=
 =?us-ascii?Q?9wxFQYK3dA+yfZi0rukz0DfXZUQ8vIn6DD0cW3j5hXPDdLs83VdamrsqiWX5?=
 =?us-ascii?Q?JRlzt6ZUPLqOJhsruLORmxb87fAoiS0H7WyVZVSptrdSzcLUKdhJ5KzAI892?=
 =?us-ascii?Q?iXSIrfC10CP9zkEd+bvAiUadpHi3uYb9pvsc+8cQLHp4QbvQjIXab/feNg1k?=
 =?us-ascii?Q?U5wCatvQUP+MuZ5aLoZY06VuFQPww8v23YZGjB0Tymj2FtIRR1sMO8XG7/H7?=
 =?us-ascii?Q?dVLYKDJhaCcYSAoIr7Q1cLn4TGueNB+w2+LwFDahMGE9NxDU90xYCWeLK1xg?=
 =?us-ascii?Q?7FN0h6YLXKwC993Sts9UVlL2tCKm53jkntj0MFwbkLcsI9xuydYibOeDdEBQ?=
 =?us-ascii?Q?Ab8LfdWcsyatynTa9+HmwDP1gXJL3x60yizwNw1c/rjcnHlNCX4R+lnUqSOh?=
 =?us-ascii?Q?xuuHj/rr7PMHUsINRETE68G5zyyOCGaMKuXjmmqJlujJRYdm6rIpHZtUa6in?=
 =?us-ascii?Q?hBnCCHdDcJOk+Vu7qPzJ6cM98RrzqchXIQsvcOwuLfp+sugnq6JGDZMCBi1p?=
 =?us-ascii?Q?02vEAtA4AS9guvv0T4xI7Q6uyfMBvfydom7KzAChHBHIW4PFHRwLQo3La6yL?=
 =?us-ascii?Q?R2cawIuz7AU5uYLbKewLml4mkEtea82s2biWNrshfqMFf+uPLGf1aRIz3oad?=
 =?us-ascii?Q?QUGBeZX2TTGhBC8aM2GtkZeV2HkwtgLcQ5e1SKwKlF9TzFN7lpMycKGvdFlA?=
 =?us-ascii?Q?26n4joRPQSKx8seFx8C5M4WRoUaH5ITKOzpU/yFh3ozj/0L3ten8HsCzAlNd?=
 =?us-ascii?Q?w9LeIlA5mTrd0kXdaywp2FEt0uNsv2bwIAyTXyNthMh93m4VKQHnUIijgseK?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qdZdo8r5ah1MMoLMfumm0wHjgJ1N2xcNbkDHt9TZwzPdq4gFYJkru17X0OpytFQtXBxOn6PMMkWEG9KSHm4RnNT2BR8vBaOrif6zGHm4yCZpEHjOTc4m/LE+Fs7QzP3XqaGzXeaV8rAKFWpRz/8NsWuLUr1MFt3FI5DPjpQn1KJTlS2m8NJyvJyF0lS6DAgvpknVhDcDHbsej40e6qVpqdASWljPdcqLMXeo6yN2YFKRJBTvIF+8qhWidGBDGSlsjwjQdymgIjEPMiZKCbfrOxjc/pKwVTc++iMU84sDpIiRh370t+YD6nLqWVj/D0KFppdDhKQwUwyC0AP6+FJcuRSNnFoB4BwslQWJYIGnW4TxcQMcRVt2X6z6V28bXZf7JnrI/tvahphUMjA2Rk8h1cpdkQrtjHkAbR/F2Mn3tn4/LdWxzHmexZKIqCNshsL7BIJkaaxHnLUmlbG1GCM9G2Wn9IdbUNgIkT37dDsF74P3zdZkwNKCdTAgv9z4+Kpv0HRAK/BAWdIQN4fdTPG9Af23zKXjI1jVzDVE/ryllFmSrQJXFFWAwv7/YMtG96HtHgPTkM2THiHEhymJsLqQbpImBlPSp5zCzRlE3cjbg+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ecd00-4666-449a-df50-08ddd02f7a28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:40:48.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQCSZ3PeX2U57o+uvnfJEnXCEkUJLLd2cEzrO85GlJ4+UiC4C6YvQ0JwzlErKt55hlMXtzU0o6+zQDYCN54bDiqLJyOzkR1yAYW2tbkj9Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=971 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310087
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b6456 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8
 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=G1pjSCRYLdsTqlcvycAA:9 a=CjuIK1q_8ugA:10
 a=e2CUPOnPG4QKp8I52DXD:22 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 8p42KWze7S4djxh6Z2syfwmDziF72FSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4NyBTYWx0ZWRfX3daZQ74uE+V9
 fVUMDVh957nJB6qFYyVRrqD3SvF8M+ujWoAQHYUZh38pz08lzUmA8fcqMMzUqeHBbfgaWCxny39
 YqKKhKFxP9IA3k0UULaCFuZ12bHbrxdAUXAtBZU7GD1N0VDwAL8mIPMwRjqBDM79TRCM4eCl3w2
 1r89MQh43gFC3smT9rJxZY5YNevVBsOMxs3Lo4ar0see0z9f0hWhWrynjJoskRE+bDxUSz1dFWy
 +GJZs6AXpwkeM0cTfYIvDm86J//LF7IG4RuB0r3N3Ry3TZiN+94kGHBJOXt43JK0PPT0Mwd2EUJ
 HL/pcZl1KSmT58grjxKIFdmWBrgyZw1U0FmobHOeVTcRxYQWIzEBRXFAHl17bmapxmBeHHDKrEW
 8dk/ePpst7jpcNohnqroR2a+1TwEa0SnZEc259P06Vs9j+t9UoYLqgHpqDnUX0sYv3d9Ewwr
X-Proofpoint-GUID: 8p42KWze7S4djxh6Z2syfwmDziF72FSc

On Thu, Jul 31, 2025 at 01:27:18PM +0100, Usama Arif wrote:
[snip]
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>

You don't need to include these Cc's, Andrew will add them for you.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Shouldn't this also be signed off by you? 2/5 and 3/5 has S-o-b for both
David and yourself?

This is inconsistent at the very least.

>
> ---
>

Nothing below the --- will be included in the patch, so we can drop the
below, it's just noise that people can find easily if needed.

> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
> think there might be real use cases where we want to disable any THPs --
> in particular also around debugging THP-related problems, and
> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
> helpful for debugging purposes. Of course, I thought of having a
> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
> I just don't like the semantics.

[snip]

>
> Signed-off-by: David Hildenbrand <david@redhat.com>

This S-o-b is weird, it's in a comment essentially. Let's drop that too
please.

> ---
>  Documentation/filesystems/proc.rst |  5 ++-
>  fs/proc/array.c                    |  2 +-
>  include/linux/huge_mm.h            | 20 +++++++---
>  include/linux/mm_types.h           | 13 +++----
>  include/uapi/linux/prctl.h         | 10 +++++
>  kernel/sys.c                       | 59 ++++++++++++++++++++++++------
>  mm/khugepaged.c                    |  2 +-
>  7 files changed, 82 insertions(+), 29 deletions(-)
>

[snip]

> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg2 || arg3 || arg4 || arg5)
> +		return -EINVAL;
> +
> +	/* If disabled, we return "1 | flags", otherwise 0. */

Thanks! LGTM.

> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
> +		return 1;
> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
> +	return 0;
> +}
> +

[snip]

