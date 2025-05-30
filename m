Return-Path: <linux-fsdevel+bounces-50163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77742AC8A8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47F33B42EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3B21CC52;
	Fri, 30 May 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSEvMt+v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QU7eRfGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4813AC1;
	Fri, 30 May 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596482; cv=fail; b=oWcSkIfTTfISZwuzY9hNxvRQ+h/Jlx1A2B6aMJyQZNn1rbnXBbjRdhmW1jbcnSVVxehyrTLdraeIBKt/0ieceTZOCNSXs1tGqMkGNvRfLC5sv60GJhFRIRP1L0LDNnQ+vn2pte8BMZWSZJyDhrtMvh3W7lRniaFnnugjP7hMmxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596482; c=relaxed/simple;
	bh=JSEXr0vsliahzdPEaX5mrxauoCpEc0/SCQEmcT9QG8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DgIlsQ2J4iUA4Wik7Pr/M+0CTMLQQx+ShVnva6djvG3xoI88ypxKnnIXpY8iziO94opr5xtbglTQi1GlTkT30jPPt2+oy4jg3nl0e3pba2FbPCO/IJrJT38t3T11pCdYcLRwyzAyCNeGKIc+B+ZlJ4jgnzuMaBXWXpuTeU/4cvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSEvMt+v; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QU7eRfGK reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U6trSA015432;
	Fri, 30 May 2025 09:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JSEXr0vsliahzdPEaX5mrxauoCpEc0/SCQEmcT9QG8U=; b=
	RSEvMt+vLjBOwmjyCanucDNLsGRAXh3TVEV3MFVgn804Qu4BJ3lr8/+jrKtivnVP
	jRuiZqEreDA4KddbGVc51fPd6+rZfF7NyYQRIkGxzKQRTB9KTtqcRbNoXi1iV1NC
	aGQeajaU02pCD0LifjVbBepxntU6XAE1B3KPe+Wl+keA4b0CHNy1I9+JW5Vz/AP7
	ZvfkKLWMo6kz4Q8z5XGmETuHPNqaO5y+UU8gkotiIOLAzq7w8eLUfBYD0DYR+rIn
	gjR398q+ikxdRRWRU6f0HFFaNcBSbKov7w5jNzah99oDl3txFsbcWdjFTqxNpaX2
	f9P97/Izyr+pMeDagCn/dA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2hye6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:14:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54U8cMZq020324;
	Fri, 30 May 2025 09:14:20 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011055.outbound.protection.outlook.com [40.93.199.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jct8ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 09:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUnh5hNlzxT/F5HTA/6vB4E90ytezACoqp2q1+QgHtw7/JZVqyYwMvUR4zRAOpTWK9OPIK6aKSHyyN66W8bgeUO5mBUC8UsbXNrXf7OZijH9DDSyAR8Fjk/VDtJbYVYp8LzzDm4UvwdYTuFQ5omATS1QYDitIX5Ra/fuRDWnlXWY/wM7kW3OjYqb+lNXy4mfP6woAZ5XuV9/0VcDcOs9k3vim+cVSnYB27tyTWmtJlFcOk12AO1U07O3oTOgPFiE1SFOpB07AWzH4e17ygygzSUwH4FJRfMzY4T4aCNfIGC8dNQU2VojP19+hWmOaXn1CRplQlbXB3SVVDPv/caThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64OPANDehAsJUx8uLpk44yoVSFPJ2AR+5QaL1uksHd4=;
 b=O9FU5KNdrlbVcvi2GBjr1l1GqTXB/9jfoIz0qxm5rv7irX3jYo7x+BMT+qjBVr4NCU8f8p8wdvyuhIDSALQ8vyiKimLREQVcd9a3gWGmlNQ5sD/OwEkBVD/lcCJmIW6fUQzcIS3mgRCqQR7krIvACR2TVT9T86uapbUsNQOsp3nNNu8fO91HQjFbEzHMTbgtoFiq5sEcQesMkjcpKOsFUG8rkXWmLohKIG7jNwhmLX3K2VKJSbcgGT13SusiSBqIfFNia6bteh1dIZziZDrNwdxtmGzhWui47GU4p7EjbJ0li+86uJkZLR/NMBm+yNgeHwSM7ThNIGQyuvkAbIxfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64OPANDehAsJUx8uLpk44yoVSFPJ2AR+5QaL1uksHd4=;
 b=QU7eRfGK4oFl7yB9cy9ud3dIs9EXWooN7UXMjZ2bHrcUurKFGv8l96OSHvik9qAH68TkTVUT2CY+pUookOh/G/Dy+0IfgjspaCwnfRzSQx0KtnXrNkA8BcPYeUFjkKX5JcOi/Zm7XTD1SDxtEddJrb/3M98ManqsbjgvHF3VII0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Fri, 30 May
 2025 09:14:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 09:14:18 +0000
Date: Fri, 30 May 2025 10:14:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
        hughd@google.com, Liam.Howlett@oracle.com, npache@redhat.com,
        dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
Message-ID: <94b1c1c9-bae5-4e40-ad5e-20dfba5b0ba1@lucifer.local>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
 <ade3bdb7-7103-4ecd-bce2-7768a0d729ef@lucifer.local>
 <9c920642-228b-4eb0-920a-269473ea824e@redhat.com>
 <00999fc3-3a4a-4ee5-8021-81c73253fe7f@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00999fc3-3a4a-4ee5-8021-81c73253fe7f@arm.com>
X-ClientProxiedBy: CT2P275CA0132.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:21::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b996ff5-12c1-4048-22ff-08dd9f5a5b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?DyYdF/XGieCWRoboMcgatTKDfbqK+3aFf6dF8M42ijLwoDrxZWXvbdCe7r?=
 =?iso-8859-1?Q?WhbV/PFBIkdCfr/dZXVWQg5U1NLTI+ZbtSBrljm23AwoAbZZZ8xwa8ttnJ?=
 =?iso-8859-1?Q?nrIiN0iFzOghzwI64JBfNcmMe6X+bM/0lgdmZy/jz1Az/MX3OXBvagZXMc?=
 =?iso-8859-1?Q?vk86/p00wLhPSlXMgI1/Wpo/vIJyx7L3o0N13ujVg/7RzPvxgACeIF08H1?=
 =?iso-8859-1?Q?xA1TYFnfwU6ppohnuIB8EbQey5znkU1YM/pTnI6c6PbY91CQyv3Ni9uL+7?=
 =?iso-8859-1?Q?hvo94tZ5kxdW3BMCk0lBbUqoyWx80qMQHvpGFAb2YD0kKNiqNS+ymtp7+C?=
 =?iso-8859-1?Q?x9s0HdR9r16yV6joE+gyHUvwB8yBiJWM2KXd8BrRvKDUirdsg2wDWZBycC?=
 =?iso-8859-1?Q?ycCG486b/n6KC8VtEKOMiMrw9yrG9kYSjAVN3Mb8ZOwfGmBfCs7W6pdRKH?=
 =?iso-8859-1?Q?sEXlxjbRIrcXnDEmf7Deq4oy5GqT0ZMbNiYr4ADVL8yzbUgcbvyqF95iE2?=
 =?iso-8859-1?Q?8ek5aoNFjcSfs/IYh+DupXxXZ+xGtY207k990K+zewcVuHkHIZytA1wy1E?=
 =?iso-8859-1?Q?ufayMLFhVbOYTRSYw8LiXr4ATZcJuWFBesgLN1RElB9HdGgIHQgCjI/Y4O?=
 =?iso-8859-1?Q?pFptj8S4+7iOdDNUpGlxbl0Z24iCWo4bURhSh23Q9U+mup8OkuG7CjhJvN?=
 =?iso-8859-1?Q?eP07PFDG08UDgsHWJrotzXrHvWbnX51t0Jyj64FZx8FP0M22m0L58stEJF?=
 =?iso-8859-1?Q?PMXiZkJso0h7JqCvIrXWn+Bvb1fuvvM0i++hIDLfmZSJHJb35Nz6z/zuii?=
 =?iso-8859-1?Q?zn38a+VFnDPvHW5eu0nInu2ZW3ym6gPbNGPuVnxR7DBnJQp0aMxdOoEUL0?=
 =?iso-8859-1?Q?6ZQgofAiFtqV99nvkMulbsJn9k0jtBG+ySTQafCS0gHU4xmIpvxdTa/wf5?=
 =?iso-8859-1?Q?dpRmwo4IXPas7FwPs87fcLhvmfcdtA5dKNVtGreV1XEt1hYyBlm4gX18WD?=
 =?iso-8859-1?Q?ajzNdbk0jo5ihj4Qphz19v/gLzCTiQmKzFT7ukuiDEYKWB/+iCUDSE6BX8?=
 =?iso-8859-1?Q?mRwTQjxvi4TwmqR9hXlaTxz+s5ZDb2yJ5s35aj2JsY1LfvbWsPDa5q0w2k?=
 =?iso-8859-1?Q?ts8IkHAKPWiRLtu9Vg0OimQtJD1vkw33hnO1M5a85oZniPUr5uCryPQMrP?=
 =?iso-8859-1?Q?TJ0rI3KEVzlVeNsS8m9GLnuOgXSQNRtzpGEHCurbFIcAkFPrIY0aQ058yO?=
 =?iso-8859-1?Q?in2lXEODrSuPdpt64cdQYVenAqz6K8qFae2UX5VmIW74LHrCw2a7v/GsBU?=
 =?iso-8859-1?Q?yTBiBchT62dj6pbl9PHfSpBMkMBUb48C3aJnR9/LaBlOFZi5+jg04ww7+M?=
 =?iso-8859-1?Q?OS7y/MjMZMryeuqJaIO7dmx/AuOcuZUYJ/miywopW1+mzq0TCTwf3gHkge?=
 =?iso-8859-1?Q?UpgZntfv1CbOZdRiQzumZnAfGTPnNONS4wgka5a6TZN1sPH2qcX17l0OR6?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4JIFs1hovPfRD/jog9WfbxdnqYaunlNeCTxLxklbD2fuyA59sMdWH5pnda?=
 =?iso-8859-1?Q?/WRHE5J3uTUE6AM7244uJFeh8tfC3lBRZOWB8VILRKtYGVErDKx7HrySKk?=
 =?iso-8859-1?Q?AAoNHmGv4TToJQlYNmjbPmH8cF/2SSYu20YaqZyGvOoE8v15tr6EZ3UzAa?=
 =?iso-8859-1?Q?4DlLILNtr5m/XbkM79LUVxTibFD5LCBgmurLuBLGQI3WGpi97mIf0d5S7Y?=
 =?iso-8859-1?Q?FSVR9tu1GHqZBXeNbqyxW4ApCj29D+6Xn0i8JDIARY6IVGO8JOvwk4rO3J?=
 =?iso-8859-1?Q?CwpHh1x0sohF8Fp9G+PC2ewUl8cwSmcKutRQxZrVmS66QaF8tJ5/RqgnGt?=
 =?iso-8859-1?Q?PVZBCYD7ytN1Wy153ZC9nLhw25Z7pTPy5YTEBSdq4iEHAWgbtkTwwYBBPl?=
 =?iso-8859-1?Q?pHciYHRqEHcE1FYEvHFkuGf9TLr4m9oWE9lGhdj5dT3GqQMBSogAyaimYS?=
 =?iso-8859-1?Q?Qh4drDJS1vDJ4jTn4NdpNHmsEpL0DchHicCLk6dJ6Cu8o1VxFs7bWtnupg?=
 =?iso-8859-1?Q?u94p6lc2xFMIetq31CGucG+FVIAdVJw7ao/TYmJ9QTLpUgWxu9QBe1qAfz?=
 =?iso-8859-1?Q?H6JBX+TKVR7cSv4ls0v7+epndrACF4Sw00N9MrDcCxgYP2W7E8IiBnhWYv?=
 =?iso-8859-1?Q?XQgRae0I6GQqrHRaVoLnqJ8Lo//isDgXF+o+Habirn7WfvUaFkRAaMsSQj?=
 =?iso-8859-1?Q?kd2b54oxSd5u2X+n86EWijn3ll0ssfg7Q6j3pRH6+vtl93GUUVxFFTPPUS?=
 =?iso-8859-1?Q?uIKqSch2012nr0OkpejIHqVWrkeiMQ23KWFW+rYilSawl7Zq3dZaQ77LLD?=
 =?iso-8859-1?Q?W/ES9R25dsZMElz2slbaW6eeIPXwM3nRL5tv9nA9Vmxjeje3AL6QDrMDFS?=
 =?iso-8859-1?Q?RDE9cw5VVN71qTejPHZoKBLZzB+q/Tl6NkXPBhyER9bPMpiCRhtOdYNa54?=
 =?iso-8859-1?Q?xVSErEWSsy0n7F76MLX0XsN/DrN8aRszObYp4/t4IqTc79Bd/ojMnRSLvI?=
 =?iso-8859-1?Q?H0/u71S9FHXr0FrUTui5uOIrl5mW1Txqx2zIMzEx6sysciFFh4th8G27Oy?=
 =?iso-8859-1?Q?gcpyY+LBY5lGhql6gz4NX5J655ujKoX/Hj7NoH6Owl9Z+9OwKklbbbR2Ug?=
 =?iso-8859-1?Q?KIeOAM+lz0dP1Q7moHUDetIyJjtSCFdsYunoVQo08mnB879wbv5ani97Rr?=
 =?iso-8859-1?Q?8aiK1tkAyxqn/gfWX/h5XAFzxJ5DuDSJeVf64zViPVWRNVuXDDLWX66Xag?=
 =?iso-8859-1?Q?hoZzvOfT9o7huuYnpw74qTNQwo6ShSwAdFJ5iOziV68M1udAMhjukjStE+?=
 =?iso-8859-1?Q?FK4p9EAXKWwm1PJbO0l6cI+oLOcQA8ZHQtf9fF1srhU0weEa68lHGWbAAm?=
 =?iso-8859-1?Q?U7m1AdG6/e6vzN48F5TAwpvKDIrtvT5U+BwyDDXG0JETeIKpapvPDhAQce?=
 =?iso-8859-1?Q?g9lJXT7YP5dTh4NR3AhWzjpwAnWg+w/8KKd+pA6cvnr76vozTLX/CJ12lk?=
 =?iso-8859-1?Q?luYUXDue5DXzDa+CMLSSePAs22AcmGwgX5z9qURMP4ydkbzpYQU6m7WYtq?=
 =?iso-8859-1?Q?ibuo0+lv5FgCSQ3zxVfQ7bLlBkki59O3ZwyIzeafUBT/5lABdptjdRaQl1?=
 =?iso-8859-1?Q?TU5cYWvckNWTmmOJzbw4jZsqBYlSo98GahEUzNBLTstu71vwTu80JFcQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q8s8nG20sGGu0cxWV9Q2baYDZlwXG1esPZxJ5+b6IbFXcfoZoqBXLodHjDfUV7Jok//ys1Ctm9oWcXWq/ICSVRW2Mslz9HRjl6+3XN2voewlMpeiueXo0CGxSqc6XUa1lQB+Ftq51vYPkidmxwhwqk7i9JAyNMG70nr2tEjtlCCFkAgELkECqXJisba67uxHSMZX3n0tu1nsVgOLiHKnm7v8ZYAZKw2qQA1MaSrnnQAiOG/GpYlWFQLTkqC7r68981LGIXIwRr4Kl042tCr5V1mU1lVkWrYdiBhPAnbIzjAeZOyS9S9YfwmknRjuA5Q/4QThflsQaH74wzRIP37IOWxG8XECaoxENSDudwD++4eBW1emrdeMjxABVGyc0qj0ofIA+Qh9wtJixutzwnXdUfZ7z/BbqUrv88LaRkhk2am9RG+/8evQSZpJMmEBVVq+VbF46S2KLPNC3wtOCL2RQLBsK9QmRgb0/iK60hZSQR9jDBAMIwWHrmX1UzVpMPjLt5JWf7BqlOVn4FOBVY+vhOeC2yKkmAjH/kzzpl1njbxih1jcq+O6C1xmWcXSLKwAWCHqunAbULeEcD2gfVpuUdSuyuU7zot418ISRw+vVUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b996ff5-12c1-4048-22ff-08dd9f5a5b41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:14:18.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8SM/x8sx2F6mcMCErbw1EF9PUwLF/5JcL5ngm1lVGXHcPt2Av2KkYJzF1yNYj4uMjQMsFVOkwcE5VgWzXL4pGusZnYS3TjszpMqmhur23g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA3OCBTYWx0ZWRfX8FPBCFBHq0mT /4muMjisSI5vcUimSsmy2OpqQni4dFzleB53GECLoYwGXNX2whvNmY9qpjkHJMOECe2QC9HUBtU 8pmgAXuSlgOqyuaLZ86CYWmWtjktgEpTxm2kSt1ONQhMmnpiHc+n4pY2O0hW8cPKZnkDLNwKEBk
 V9MlC5IQ8J7HLdo1Kz63mn0QRdtKM9yETlbbBAtPdmPSmmlR+8ANtKe5c0BSKg4pQWpka+c5Pl0 H7pYL20FAttcdBm1BNX5cLZYDIYOlJ9HeUwf+3o2jxxtsHfliWd9GAQWFWcYl7eL9GkXX+XJjSp wsWmzQ2uk5j7ub2R8m/UDfTcq0ZsRnB6QCd55mZNolETpKgAZPE5hIhEmeY7V8axo96JBbO3xFG
 dM230fxyMHJfQJYSEk4Ad1al0LW/y7JkLqVtbnFF0zpwQVCx97Jln6OKlqyVffukW47m64H+
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=683976ed cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=w1_QSfExazcfhmdj_ywA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: K7G1jC4NDpPsL09jwhDkfbID9-aMC4CX
X-Proofpoint-GUID: K7G1jC4NDpPsL09jwhDkfbID9-aMC4CX

On Fri, May 30, 2025 at 10:07:11AM +0100, Ryan Roberts wrote:
> On 30/05/2025 09:52, David Hildenbrand wrote:
> > On 30.05.25 10:47, Lorenzo Stoakes wrote:
> >> On Fri, May 30, 2025 at 10:44:36AM +0200, David Hildenbrand wrote:
> >>> On 30.05.25 10:04, Ryan Roberts wrote:
> >>>> On 29/05/2025 09:23, Baolin Wang wrote:
> >>>>> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
> >>>>> the system-wide anon/shmem THP sysfs settings, which means that even though
> >>>>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
> >>>>> attempt to collapse into a anon/shmem THP. This violates the rule we have
> >>>>> agreed upon: never means never. This patch set will address this issue.
> >>>>
> >>>> This is a drive-by comment from me without having the previous context, but...
> >>>>
> >>>> Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a deliberate
> >>>> user-initiated, synchonous request to use huge pages for a range of memory.
> >>>> There is nothing *transparent* about it, it just happens to be implemented
> >>>> using
> >>>> the same logic that THP uses.
> >>>>
> >>>> I always thought this was a deliberate design decision.
> >>>
> >>> If the admin said "never", then why should a user be able to overwrite that?
> >>>
> >>> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll ignore
> >>> that. Because that was set by the app itself (MADV_NOHUEPAGE).
> >>>
> >>
> >> I'm with David on this one.
> >>
> >> I think it's principal of least surprise - to me 'never' is pretty
> >> emphatic, and keep in mind the other choices are 'always' and...  'madvise'
> >> :) which explicitly is 'hey only do this if madvise tells you to'.
>
> I think it's a bit reductive to suggest that enabled=madvise means all madvise
> calls though. I don't think anyone would suggest MADV_DONTNEED should be ignored
> if enabled=never. MADV_COLLAPSE just happens to be implemented on top of the THP
> logic. But it's a different feature in my view.

No I absolutely take your point, and indeed this is very reductive, but I think
that's a product of this interface being... sub-optimal.

if you dig into the docs for instance it's explicit about that referring to
MADV_[NO]HUGEPAGE.

But, as a user/sys-admin, I'd definitely find that surprising.

I think the intent of 'never' people is 'THP bad I don't want it' for whatever
reason that might be the case.

>
> >>
> >> I'd be rather surprised if I hadn't set madvise and a user uses madvise to
> >> in some fashion override the never.
> >>
> >> I mean I think we all agree this interface is to use a technical term -
> >> crap - and we need something a lot more fine-grained and smart,
>
> Yes agreed there!
>
> >> but I think
> >> given the situation we're in we should make it at least as least surprising
> >> as possible.
>
> >
> > Yes. If you configure "never" you are supposed to suffer, consistently.
> >
>
> OK fair enough. Just giving my 2 cents.
>
>

Your input is very welcome! We have made a mess here so it's good to talk it
through.

