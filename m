Return-Path: <linux-fsdevel+bounces-47816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3DEAA5D2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AAB3BF85E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E621B9C2;
	Thu,  1 May 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q86CUkuf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hBg6G6CB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFD1C5D7B;
	Thu,  1 May 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095036; cv=fail; b=ho6VijBvASd0yAbtSTfukGhBrRAu7BHj/U4TkOZLTEtRcuK4t6YbRKLBNFscuVXsD4lfx4k98ILZTRnUi23PJryUYKdj6sG0Ai8qrahEiQYowRfaU3hmripE/KCaPZikDXqSpjNDLP5stB8ypi3czu2J0k7nwG7M24F67zSyZbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095036; c=relaxed/simple;
	bh=BsrJGBy9NaQDUb35BRl93QV1fwt0QBPeOcOohOmrAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXbg2StgLkLQPS4f2bTrq3V17JSCo6fYgsaEDFJ74312+cdCMJX9VDeaz4iiOiu5+8q5rkA+NpXalL5C20V9iJAWhzbbGBbUO2TE9E9krNN1S11eCuypV00/hYjhUQqlBOa9Ud1HYOpeFWKijBza6a7V5gamRCElMaESarAZOEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q86CUkuf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hBg6G6CB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418g0Dl001888;
	Thu, 1 May 2025 10:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BsrJGBy9NaQDUb35BR
	l93QV1fwt0QBPeOcOohOmrAOg=; b=q86CUkuf1KptqwfVkO/leEOJrzfc87yPo0
	tWe0mmQ8zg5JC8TN7kTblDWtK7xY18wvesTcEBLi5DAhIYVBPvPUG5W0S4Jd2FN8
	pAdcSBEqBCuEYKJBknaS+zssQWwKBH6buna+AzG4SQLVdTd4bKdpUfJtKXcDKSGq
	vwgzk2A9pIOTLTE58etcZeSbOrO6gor1n/FjrPU3FhEuIA0BCsWN2FBTWYBUJRP8
	2YLsM+T664MJoNDO+RuoPn5YxQYdAytTKqu9JUVhGLGWzhD4dZ1i9ve9J5enfN/5
	D1Iikj9nQuKI8jo1iAHxE6NXbKaWr0soeSzL6RmXQT5HtvOmW4wQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utaty0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:23:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5418sx9r023735;
	Thu, 1 May 2025 10:23:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxjn6mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN+b2rqUAwdf1sCmkbrzSnGqH5Yaxh51pR2FICwtt3oW+Q386cGja6uUDYzJUDWScVrTTGHaJziw5xyMdSYNtL6HExM4RT92ydpROXi7wyywTGSX++zqpqYkid2ZqZVNFEr01Rb06BRcaZ0I6nWK2A6Tn3vtcbP+zH1MAiFmBCxJjoQXmRnrl55wTHZd8q0P1bLoJb+mcyOMxpYPPPJLgnTG3HR4a6T/HyDOdbI2moaonyV1fuKyZybQcaTO14P9yBAk5kUB1c9uA9I8B/Gg6MtG/K5FWzKTBNxA9rH0ttW2dSLu9eljP88hCs+Cfa3jR02MCwNG1Wyz6xUb2kFFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsrJGBy9NaQDUb35BRl93QV1fwt0QBPeOcOohOmrAOg=;
 b=y2xjFP5ePw4EwmhQKgn8CAP5BxL6P1CnddlWIuviA9nhMu57NWeOgtB6v37gVQ+tERSBYw4BNZvB7reZ0eLfS+6Hx14LRXjNE6d0O8dB/nMn8YMj3fjK2zjVLWMLDE8H3m2Jb2eDmKnEuEMR9rBcoC1VnZzIi/Lv6ih1P0n6Dy/UsYRJn2ZBlODlCbXOue18FzIEK6WUEOmPqzsjrpNHAGdJ7GyKJw/FTBfy5ArjX/pmcAGUJFCFIHWeE2fbPKmLQTWrOj85UTwss9fI6tr/g/sd75Ppp0HXLQ9QnkGnAz1MpSvkl9MveIc5ZLKq77bGRMqUcYZWWDhyLI1X6vnNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsrJGBy9NaQDUb35BRl93QV1fwt0QBPeOcOohOmrAOg=;
 b=hBg6G6CBPNYQsMBZDHYtZpkopFZHk1PU5S48qyBDI7PlRNou9L9GUAwjs5C1//RYzw4PMif+V36vIq8xtuxVDULLjwx4ndBpCesiv5n5oV9ahabppsCXMIQ2fY0aRdFeDXFVNEiv3r6UojuqDURvOgUWCjA8W3lzXtqANWXacXM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 10:23:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 10:23:35 +0000
Date: Thu, 1 May 2025 11:23:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <982acf21-6551-472d-8f4d-4b273b4c2485@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
X-ClientProxiedBy: LO2P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: d3feffb7-9619-4e46-a7d2-08dd889a3ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hxNKHuzKkQVg4W7qnyjb/z1Tu6noak0DPJ/sKTMtpvVJHGRcjA7Q4O5ZFB2?=
 =?us-ascii?Q?9J9BGa7U6Gtd5F7FkzYFlUMh9HUAtBq4a99gXUp48apO91+zCceBVI/dmjOT?=
 =?us-ascii?Q?nfy7XrWfFHdFuyWKVOdK6HXEW07GlAkZmDpYp5vSPezZAyf1FneuI+/tMupm?=
 =?us-ascii?Q?81oCqOpMi1lC7cvtD8oAkNHMEFP9n1RFAT+3jHP4vb7CxzNF65YMT1mL/Bw1?=
 =?us-ascii?Q?lGkU0pvETpPiIhUm38uoMx5RH+/waSR0nj8XEhz9xb2NQ2MX+kUOwtpkqwdE?=
 =?us-ascii?Q?NlNVaznJ7jFynP0qsYCR22bRq8ftxpCe86RxP10+wHCsBpWFpKvlXbr5e3EO?=
 =?us-ascii?Q?I8bkI3Qz1ajSS/iEDhTHfNuPJmfkMBCUpt4PlH+8nhKMfoCJtvk/NM9dOZuw?=
 =?us-ascii?Q?uOgRB7+ktdGws7DQQEOzIQM6EZQSL83vgVIB5U37/jrTjQ3STsM3MKbQm0dZ?=
 =?us-ascii?Q?Zyv7awOYfufr2yQhwRDhk2joD0e+Svaf0AW2eu14PQKxRSMa5BaWB5XilxA5?=
 =?us-ascii?Q?+Z9RA+eQCCnd4i2bX/PQJUhXR9Km7DI9ZUyJ3v+aOxuKTkFzKmFuUz9ifMNB?=
 =?us-ascii?Q?lvKi7z+qW5pvmCaUpPr4ENq/op0StD86BrZnozfq3XJ4DWS2RnAB5a3eTARV?=
 =?us-ascii?Q?pPec56JA5yF7pNpcIw2mdh/Ml4Qd99ZBp22vamqLchbbJ2qcnmD/FmEm2V9f?=
 =?us-ascii?Q?x18VhfUsp8AR2RdAtmpqXnlqUl68pii5GvszmGldXObDZ0uDpgXaencosmHy?=
 =?us-ascii?Q?ab5LqK5hH5CCSBah398BJJfVjfOFYJmkUAJcb74e6qSCn1gFd2yeCfjnhHK5?=
 =?us-ascii?Q?8WAgOxHdQA2Rn0jc8eDo80IyDn+2ovObj0xTTAcKzBQy95kW/fbc80g2LlLQ?=
 =?us-ascii?Q?5n4j1BipalgE2OLU2/1ZjkfV/qQS37ojYfz5Lgq1kRJKKiLZMfQHv1siwrbL?=
 =?us-ascii?Q?SLRaVG5WR1h7IOB9DabIJGrnJ5Ar97zqs0wBG4jWUQ05Z/3uPn3M+igAW6ST?=
 =?us-ascii?Q?quWohPz/vDvYJjdSL+FlFmuuGpoHSU3ygFvJ3lf0lk6NPpcsXGKDf4vxBoCf?=
 =?us-ascii?Q?JWnWtyHZpZvTpJ5A9PkKK6r6w5M2E6xuQqBnnvh0+BA7iVMaCVCGCZrj4BFC?=
 =?us-ascii?Q?vmmWwFMIFnfQiyhTPy8zIH8B3A9z9xnCAyOG8/JeZaA8EGIXXZcjF1uILdSq?=
 =?us-ascii?Q?lAOD3hiblbCU6a1XjDzT6Btn8j8J8UjXvDk9qqdEvCnl6nSWotTxkaB0ym9x?=
 =?us-ascii?Q?yZwK8p3KuWFL0zoOICiob3s4bWMIifvrCro3wXMg4CXvDMtSLyVyxAwS6CXS?=
 =?us-ascii?Q?zowyjbP1FBvxqQWforfWAX4PLDRfBAUls54+qKeJ06tT8uLC6j8g2qdGlUlf?=
 =?us-ascii?Q?jKrKBZiKCOMmExaRCCfHV+yian1BXLhRNkUloN95+Lgrc7BA4myeQHtyFkV2?=
 =?us-ascii?Q?yrTqHEZDeLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gtj3iFnOUX0Mal7lnhgjpKN9tdUmLMQquCWu1iBZz759upORsnFnlm5ZAl3q?=
 =?us-ascii?Q?JOAYNB6ILxJwVARHxxfg6tHu6N6azJWPdwlG2JPey/bKxWHfl1r81JHnlDu0?=
 =?us-ascii?Q?TE14Zs1AoXEa6nroQFGljbnYMgmUhvwyfamU6WUNDVUpTy7sRhQx7pAb2Iy0?=
 =?us-ascii?Q?tyLUkDDGiGn+899HGUojfNiDtdZhNmG30zGeuB8zv2wO3itzRMv6b8FbC0Oy?=
 =?us-ascii?Q?kTz8JT/jSKBY9VOqaRN2Te4xdiCNki04k0S21hXjTnLhXx6QctUZ/ydh/bie?=
 =?us-ascii?Q?C+TrySQ6ZcRmj7LGIfX9KNPXcwOvJNtQRap20NaHXmrSkW9cBRs+DUd+VeEn?=
 =?us-ascii?Q?MCh9dft0Iq4YfKO/B5zh2MbK4O5lNABOGfhm8HwmfhsP0ugyNpznQako+vWa?=
 =?us-ascii?Q?jF6EQzhCeSdq2PftNQAS/i027Bgdhh+8pIjQ4iVH2GU+6Tg0X4qhRAOAjSpF?=
 =?us-ascii?Q?IiDjjbFh4cm92WPh8bfbVhY/6+u7+j8ioJusko6VmnA50UfKZ4ObHlmbK9o2?=
 =?us-ascii?Q?ozysjPy4wQmasbDJIWLhavdAqzNe6Uf6bx/+R11pgmx5rG070HVtN/PGA/MJ?=
 =?us-ascii?Q?cUoC0fu0vSMu1g/kyYunFNQ3QQch1wbg9JcttRZdakZv05My4DCgXdl8zKhP?=
 =?us-ascii?Q?s8lUvmP4wlVKr5PPYd6YFnMgliKDOzASwip3k4uYr+ePqHYA7/XmJTNX3egQ?=
 =?us-ascii?Q?oaseSohfdgSm+dB1gwjAFcTsWa0XIZoDH8N7K0aP0f4OmHoaFQKQ89KHa8tS?=
 =?us-ascii?Q?6dr3y7EAAf3naHSZqHRvsQuuMyJxk1MfKt8hv+v0InK34Swl4CFR2itK7ocX?=
 =?us-ascii?Q?6KF6ofF4CgLkYtLAsx319FZ3YD8syNyZZwIYJNAb7QAwrANP1nCufq6Wn7LP?=
 =?us-ascii?Q?1j8PpKO2rEb91mONdM1k4AvD+PEwF3kxUTcYREh82bszv7cRNn9QiHHMYdwO?=
 =?us-ascii?Q?Rh0JHH0qWkENGeQQV+BWfbtCeGgZVGPxdfu6jxrD/aaqbTgvjHhavJO1qI6/?=
 =?us-ascii?Q?+PVhmNgLQ115CVJkRRRDOre7G10vP9Rb7bDBBJYgD7uTz35Ph12rV83E9id8?=
 =?us-ascii?Q?xzf+9vq0QlMfWYG1JbceOk1ttcws1CKhHjoc3PgjQfsFx/EZQfQjAtbC9e84?=
 =?us-ascii?Q?35Ib7Njjj2FwYaFUQA/XV23jOMbFfzdGXqD1UqH+bdnF/fCmdDMmXdn4jCQo?=
 =?us-ascii?Q?F9y6h4QUVy/EaZTynTIJPQ/qzTrqYjmWrjEQhKMt5AmEI6/SyNm2ahZf+aRI?=
 =?us-ascii?Q?ykHouI0q929al5F7uZC8DzM054EqB3nHdiiNwptbhPP/m1llzusbh4GQU+XW?=
 =?us-ascii?Q?l2vJM82+yyfmLL8angFUUdfrWusrHLiTWRQn1IjwZOb+NP5NA+mddV8WuRTE?=
 =?us-ascii?Q?o7WWjAaioC7p0+XkPIlFEVEcubDMWIQizkAet5dJ30fFIl7vfWW3LaJyypux?=
 =?us-ascii?Q?EtCULIJVGbi6FlKBC8hTEPZQizKWix2m4cG4AcaVCWCdXKXEhJp9sH2dJpLH?=
 =?us-ascii?Q?m79t01upbTC5jD0aO0BnMgu9KCXrdwCNIpmgZ1W43NJtdEbWA7gZ6KGVpeDk?=
 =?us-ascii?Q?Kdkoq8FZNCR6IFrfVPhwubwgOwujynV6iKZ5QZ9xoHdag5YNRdTUgqnqg7rG?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g1Kdgz/WqGhn6rOYidA0xdwDaMbN26SJzqTGtx/+ewTqTLDioCwVQaP/9AaxSOigS7bdgqgToigOeY4TPDd5ucBV98RNCAE0MPljkdkFJlhUgxjcGzYQwwro7ySAVYvWAhO3J0Tu18mYx2V0aWZpD3XdqKv7Omy2gIgAKRFoz6RXOoqu0UO6dQ64DnCYpTvaSnrgEaWdaEp+rYmSR8W9mT37Y1eDYmjalR6vNVvXBjOaladhdJuoRHs+SJAmK1iCeNDOfKtcSldIbfC3xsIZb8ZcNEEl2iu52FBDsl3rgLONzKsn9mFJJG2A/uj+OhGQoIHFiMg76t8EF+j4SDbGkA59M0KRr+bvHAWMZEI2PmNNF5TBlmtWg/u23zh+mfbXWAxEBcihEiwuUod3VPPoqQrD0gxDuLwInnXdZVAUybPIS6+TaAJ0zBPSSULnI7LnFEKQjYLWI79tgNty5wVUBXm7MpY5g15Rp03sp4FVCJHTozDBFfdgDa5J70QSy7BrvBn7fmN4w2CuC1u837jDjlh49qMw8H/2WUpSw1dI5tGJQU1xk3aUEBJVS5HLgNwouZ6u/vlU3McM0K42hGFoMD1mMzlXRKxOgYCZ/WNO0WA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3feffb7-9619-4e46-a7d2-08dd889a3ae3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:23:35.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzrERoSTcW0jJmnhQvZnjU9pP2ClwEuKSrHVorqJSDKVEv3wtlks0zwN/4uwA25G1Jxapp9MNBqKMZSlLgZoecgkmnk2v/o7TNdxclOlCf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010079
X-Proofpoint-GUID: jXpSbO13x4jkrY3lH1rDL1fIb2hdBSIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3OSBTYWx0ZWRfX+Pge8FpzXXd1 QaBa9G6M/yeDBvCNKwxpS2RxiNLlVEIs9BSjyMaug+aNhd+qH7XgVRa3l6QoBiEV/t9liKJJ3z4 qhM8HtIQG+1EKcwb0MKiSIskTwZKzQcfYK4kYgGCKqdPirTiyayo3cshCUMMHKRLuP+goqXfMOa
 5krI5csMa9+AnIsNqyyqUv2Y5KYJAEn/UcMIiRAadQXiIq+JwiWFlj2mPJ5DPy9uBpkSTdeh7bT JplBmCyjxaBvvflB1uaU2j140BIBGkSz/uGSvM5MjY3yEEu35aBFInKRY0Z8mHQkftfUWKZGtya bLbxt1vSTSdpi7X+d0WJvcKEkHJ3AAELTLtd1lBBsPFUzkfipij02ORyPSY1zL+McwZLXuj4lqa
 uIjYpb3AaQbSlZJPPHH5wZxExoXY5yDDt8VzX424GjgmN14CqaOzPkN3GE0vC02ov/7rQUN7
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68134bab b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iap-qV7jxApwZ7o55zkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: jXpSbO13x4jkrY3lH1rDL1fIb2hdBSIn

On Wed, Apr 30, 2025 at 11:58:14PM +0200, David Hildenbrand wrote:
> On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> >
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> >
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> >
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> >
> > The .mmap_proto() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> >
> > Update vma userland test stubs to account for changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>
> I really don't like the "proto" terminology. :)
>
> [yes, David and his naming :P ]
>
> No, the problem is that it is fairly unintuitive what is happening here.
>
> Coming from a different direction, the callback is trigger after
> __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> that? (mmap_setup, whatever)
>
> Maybe mmap_setup and vma_setup_param? Just a thought ...

Haha that's fine, I'm not sure I love 'proto' either to be honest, naming is
hard...

I would rather not refer to VMA's at all to be honest, if I had my way, no
driver would ever have access to a VMA at all...

But mmap_setup() or mmap_prepare() sound good!

>
>
> In general (although it's late in Germany), it does sound like an
> interesting approach.

Thanks! Appreciate it :) I really want to attack this, as I _hate_ how we
effectively allow drivers to do _anything_ with VMAs like this.

Yes, hate-driven development...

Locking this down is just a generally good idea I think!

Was late in UK too when I sent :P hence why I managed to not send it properly
the first time... (sorry again...)

>
> How feasiable is it to remove ->mmap in the long run, and would we maybe
> need other callbacks to make that possible?

I do think it is, because we can do this super-incrementally, and I'm willing to
put in the legwork to gradually move drivers over.

I think it might be folio-like in taking some time, but we'll get there
(obviously _nowhere near_ the impact of that work, a mere humble effort, but
comparable somewhat in this regard).

I actually took the time to look through ~350 or so .mmap() callbacks so it's
not so crazy to delve in either.

Re: other callbacks, yes I suspect we will need. But I think we are fine to
start with this and add as needed.

I suspect esp. given Jann's comments we might want to make .mmap_prepare() and
.mmap() mutualy exclusive actually. Idea of allowing them both wass flexibility
but I think is more downside than up.

We can then add additional callbacks as needed. Also good for the transition
away from .mmap() which I really want to absolutely deprecate.

>
>
> --
> Cheers,
>
> David / dhildenb
>

