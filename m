Return-Path: <linux-fsdevel+bounces-79136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG4aMnSzpmk7TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:09:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687D1EC6B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 936333069AFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79323391831;
	Tue,  3 Mar 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1417fXr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pwwmv6c9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550638F64C;
	Tue,  3 Mar 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532423; cv=fail; b=q0C5jNNFMaJtNbsxevC7XqPNWOlWHqgKqYXW1MTSx5a6fkG7Y/bV9WrKKL3CpGrYzuuol0njOmGhvFCiwmSTAhhhPGZd5E/3e0sxw+fl9TbT7v2rH1NssSTlKdoGqlGHr4NNsv3xqD/vKNTBfRfBh+ZwlEAP5PMBdikdyKFZG+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532423; c=relaxed/simple;
	bh=u28Saqfg4eSxEkAagWdb1il0SYrMMsgKdxT8NlJHNRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivgDOT+s+DIwRDworTXUbKa+Hg/7SeALy5gwQj6CMFb/pAAIJqiEE6Y7wvU8QXM9JvkAu2JprQ007IR4UyxL35AnOfm9TyM+JSgE+rCTDkNm/M8NPjBkXwnTw4wLRubZM758/rwd7lgGSUv4HavX72lCuCO83jJhKgMfJAo7bxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z1417fXr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pwwmv6c9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62392H3s046360;
	Tue, 3 Mar 2026 10:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=clv3fMrEQxZ8VHMFDs
	hW+Wc8SGzSnvhm4aZGphgDbtA=; b=Z1417fXrJWNz3Q0bnBHj+cLaglfj2yfmPD
	rUefwygKwUOLKeyhKVyBHgH/EWtYDUAoLXD/cAikMbjTnWzScqix53jhHiTiEbkO
	50ZzaHmgCcZCJH6XTsfttmP7mGkd5TA8J/Iqk/kU9zVq7PtoAjN7tjeM9846Xu9b
	cbShpMMFMg4rgi0wJSvYZEXdHJ6OWvIwsFLgZHcz6yRn9KOghLwcv4hhjT01jwvv
	QAofDPoPK0a5mMn5eqcOE+UQRiI8HF9JUEeexv9EXnzHuFVBbzHmOD48KEa2FXH5
	VVJnTZD3ujtDYfhys4jK1HXBPegTz2NOdFp8gmp07HXaRZuWmWow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnvnn832m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:01:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6238IiuI026740;
	Tue, 3 Mar 2026 10:01:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt9uy3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5wM81ZkwoQdQoMhHlQ/AyLBKSRR8gG/9G3PspTOSf2g+vuYkiCHytgnklpNW5qoBsUGItoJHk43LoJzK+PrmtwOpDhhvO66VlBoRCOdB+88x5J7Z2Fb2IMPYxwsJr3uYFeMxdesh2KLEyBNGtcdNjCXI659aXC4o8umFFreFKALvARSQSl/gSvnR1wc2kU0w4q1CDA6PeE2gcThIzsMKCZ33rpmmKJPwx5AxuzTWaXdk/hAVrk+p4P1xliSEB5SWPKKLiw+I7tCaHa14GehLKa4Mkjwj6RtwmKxez/sZ5ZMI4KUik0TI1jCMVa+rptUholly1QnnJhQOHlAmqRSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clv3fMrEQxZ8VHMFDshW+Wc8SGzSnvhm4aZGphgDbtA=;
 b=n1v320yexNoFfNJtf7TV9eJPnTU3fwZgnWrbBjRchF6/+uiY3BpCSBWRrOP645NJ0paza3MfImNijsMYqJF7ZVI2d5Tn5rXfKXQxcN1q7Rec0kE2fP4Vt2ePTRZWMFGDuRRrTINWQ2eRxBzyxpgJ4vOn4TiPmEx8UpLKD+99+d208/HTCdQfBPllqhVJNGLG6B7LMI15w+q5Abt7pqOxvsTNwScm+9Kn7ABxLlsAnK+39zZfO5b2SWKvE+tNIU5v1zr9VfMGqGDsAjY/kVIC7RmXc5S2cDutagzVOqdJt1fL1m0SZp0HuUmg7brr5jFu4ay8IGiiXVsbiKPsGBVt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clv3fMrEQxZ8VHMFDshW+Wc8SGzSnvhm4aZGphgDbtA=;
 b=Pwwmv6c9MBZy4/FGrZktxyb2QLSPE3X6iZZx6opu0YQtgXnZoziDr6n3dCKJ0U2yco6FVpRuS6C7xdINYIFGqbUeEnWDzEcSda/Oz2KV+aPcKNPH8U06DVUhfkr2VbxlaX9eaV0ohlIbta7kj/J9rywE/LGp/lpIzJ8VT/g9FWA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:01:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 10:01:33 +0000
Date: Tue, 3 Mar 2026 10:01:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
        Eero Kelly <eero.kelly@dfinity.org>,
        Andrew Battat <andrew.battat@dfinity.org>,
        Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: fix a folio_split() race condition
 with folio_try_get()
Message-ID: <d79d74f0-a61f-4763-9970-15422af486a5@lucifer.local>
References: <20260302203159.3208341-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302203159.3208341-1-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b191d43-8698-4c3f-b063-08de790bd97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	llJ1cOR7Bv7GKHdRfgnWUoaJHorymfxVLywgN+BGfzgNcj+buS0mwmTTtQWD+v5YlxLsLLyZgETGjKFIc9PPw2AP9WH5RpzfL7Yn07rNagjAbfsupa2M5avSmboTJGVyVsyAYTFMePS7oUpQjW7hQAlsVslw0DcTYYJvv+80tFUW4K6ZAvX65K0vHpJ3VwpwRa07oaMZaiIGtauvLfTJHCyqPBSX0biHddxwKY13ZtmleaSIKc0BX8+Zfu+e+9Ju9F6OO/3YQPzSHn8PGJfRekZ6kszUsv/6OBNrKttXbsDZD40v10etcvKL8na74/9EpKoV0X4xFmZhUNmdnnKZVVjBPAD9X5c1GWYwJNbvbTfk0MzN+7TM+p9+rP7oQ9z6GYyYTF1GIpzSJNjmuiZ/XpH0YCGO5wg8LtLK/MNmRZY0ev2QWUdHknGHfE3V2i06NZBV2QJ6Qfft+dHOe1GAhuNXkYDwD4QfB3hdPs7wrNM0d0r/ENsMIYWUL8fwOI5lnsBZydAwRF1pwY7BWeU+JV5jDB09/2jBiWjVVD9x+qcumQBGp+mu/aIoHsHIBFtGmEyq5u8msx4e0eCiUHS0fSJVQVQtKBmr4kQQzD0YUsT7uGyIJ/Qt28ft+dEk1se73jsu76jOdWWIZv+Oy6JilPuaVMjVkClrW7Vs8jpAOfUSnkqythMoJ7b1ltHUBjTiKGRXZjcFO1nieWaDEgpKJaK7hge7YgsKywzlx+hHIZF7+QtAlrCjxcgxDS04jG4Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ro7SvduHTWC0EOZkxDa+E6u+C0rNMqggI7SitLZOUnLdW75x1PjrFAnETobL?=
 =?us-ascii?Q?mEeWYjnogvYyDmTGx6yi9w+P7iF48j2nw53PATHMAcl94f76yHnjJ2l5gRt5?=
 =?us-ascii?Q?FnlFUAB5DmhMwUfYeqFDc/SS675VbP2c9bfRiawDC0BNWbKDAEAPOeTn7w0I?=
 =?us-ascii?Q?9Njz3NdeR+Eogxz/+Dyt1ebhmqi7T16CDcNMBDqcXd0kfvFeUtRUciCuKIAf?=
 =?us-ascii?Q?BqJhcpPuOnIxcd8YnHeSYwa6oA1x5V2LtbuGKPxJB8TGq1tyeDOppGsP5npo?=
 =?us-ascii?Q?xsUYaMO2ysUfyzrCnXHfq4uudZMC4gDuobHHPKZddyo8toIaFpsmfEkJv6wb?=
 =?us-ascii?Q?thx0MC0F4jZJMRgTKSPe9EbJdfOCNWXWRjvTjBlkkRjX6fG8srPD6yx0cAfx?=
 =?us-ascii?Q?xmF3ads+hRsgVgAI1QGJKnZw2C3Df89W4yPTtShuSAYXt64cEaNHDOQKzNxH?=
 =?us-ascii?Q?YcwbKMEGI0kXuI+w5clN0G9FbVmukdm7c4cyWXUflqVDd5/mZOxyPZtMnqUn?=
 =?us-ascii?Q?tlnrlw8fVDsEBix+rvXYfrLZL49MjMFcU7gKJVQ5lVj+ybHrjdQFJcZPKaJJ?=
 =?us-ascii?Q?jsY8lJlDL2vp/HrtSRrtztvo39stDTSEVKZtSbfdSu0BCEb9KfB3aA/fDZH4?=
 =?us-ascii?Q?yxOdHRl4wfF88FexQQs8TkViOMdQkjddhGB4vudvBoZrpXD0OPpVXLMJHlPQ?=
 =?us-ascii?Q?TyhZUnLf9+Rdk1gB736fJiYJ7pzGpBqcNxWiSUNIrv+MQKjInsu5jHXCv/UM?=
 =?us-ascii?Q?b3/Q3eSbBhInmBBAcUyvQZPXWDBhCIgD4tckRv5QcuHcXs1b/k7Kvbg9EVB0?=
 =?us-ascii?Q?SsTPHk/v59swsWUEfo4IDPMKrn8Zvnf06WkDr/vb+AAg+Au9ac7q6h3gI1K7?=
 =?us-ascii?Q?YeAvK1ktPzWEqLJLLssExQZ9JF2xlULuhsFNdkkKdv9Q99uIkX6kcq6YgdhH?=
 =?us-ascii?Q?MP7NXf4RdJXY8xwoIhQpjTJM1HiWY6tkfQ6OwgdtaoFISRXE9Ows34c0HMOq?=
 =?us-ascii?Q?5XolyiPGjn1Hi2GIO3+peCPkM6fu1rY//UyR1VtCrRCxxzMTs/M++34SrnZf?=
 =?us-ascii?Q?IL5JwlZx+TZeVMjb8eO8EnvtKOAQDgmAIzNth9z1okNFSY2Q6LV27WBXeIlU?=
 =?us-ascii?Q?o2hYinXi+QZesjPOXFiQQS168P+ks8tEMI8FHA9eZiXA0APUHz9ccM5iTLYA?=
 =?us-ascii?Q?QN0ZnoPuN11JIUpksrp1vAZHEgeucG4XLIeJOzOcrbA1rgZquKLRUzdAfusx?=
 =?us-ascii?Q?17//PAvZuOOQBWCIhXKgzI9iPteaVNAcfGkg8wKt8HkOvI9X2M+8i5cYDnJC?=
 =?us-ascii?Q?CRJocvImvuJpQlC5drQoUNTxtMVHGP5LDYVln60bDPPcx/R+xeTkQEFRgzWS?=
 =?us-ascii?Q?L6mMdkr3jNQ4Fqs/k2duFQ2zlEblKBw/pkHmQFZJEAvWQH4xf1DMMkljt6JW?=
 =?us-ascii?Q?F6HkCUrHmWj6dDLCUsvWlgO1qFP9JI62Apa6t5R3MPE0ZpYZoY/tGmV6nwvj?=
 =?us-ascii?Q?ImXUOa7NYX4aUPNe5yXKLNJaPm3A9m3IJ/o7ZH3istHTbweEoU1G9tZEDvvH?=
 =?us-ascii?Q?aZD8IfeaoDFT4wy1B0gHADuvB7Fq/uzcJmm6SpS+Wv51cdGGBk8nPmS5bYbk?=
 =?us-ascii?Q?trEdOYG0ruUdVRr7RunZG2LSWdGXeImnWBstekrZrV03fKxSt2G8HGHrFd2O?=
 =?us-ascii?Q?6EQnTGxI9Fu3Yi/A5aplSjde4GWjPITbc0YxeB4WDe/MmMcDeNzS9qFhb+Ob?=
 =?us-ascii?Q?4cEYbCxX8GP+sF5kzhNKUAImZbc/5Pw=3D?=
X-Exchange-RoutingPolicyChecked:
	ZeOx/jvY+gOr/61XHblxL22gGA0eERogSPOh/H6kjRIDjjWPQ6WeKE75+Nwoy9qjZsUGYLmBolfhEnO5dEwDtia6FqYgGYFTnkPSwH7V6Ygn2j5fqIgM6EsNRmZPmN9DV39mLGFx769aaZ+UvosBTHNQDLCMXUIdhlXkidKRA0FUb5NB9Y0ZRgNQM5zFX2J7pJoHtLOSwPczi9Gdrzp17dBfvtFnArLDb/9ELJie8Wa9jlC+olHDzU4LMIxMmkumhbU5MVEXftrtVwOKDgl1ylsAmMjW/hHOisZyp6Y+nag2k1QxG0gaR9YtXuCkDdVTmrnO8CqwI/iWtIWQVMDSTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PsgQiZKzfQaoitNaRLx1VNYayh9/QiyoDbzqpn/6aoy512OIT81Gnbn5IELnjVXN+RJ9hvUyn1+n7OGgMQtdySenHTafrg/+Gf4BNxMtl+cfdjEwMwMqXsu1Z6op9eY1jh5RHp21ppKuVdxC5AvHNE1Dpy3TbM+5eeayoVAyvzArekB9dWInR4S4/DmTA9MhG7uj3hxNyov2ayuUhMWVM2PIY7qJjybYDyvQoSC/SBb9BJyyxIB5AUUDPugKMG/2ARpQReyZ5uNQqliRtFMoLckp/nY4rh2f0PwvK6Yb//Ux4+mJlGaB0mDUUS0EQkG7sKmkriEYPqxqj/sqRbLn3Ls12QWPhobyQ9WpkmqCsRLK0QPDXlxLwf7kQ2VtvqjCKGc5jbh8a6uwsdWK36FV6R8nOyyQckgLAhrTTFrqzD0iN6sJEWi1AK5i2JFtFqlLJjTBrR/w+xHiO1Sa31ghQyG/tVRZLYQRmVTV59FtTrVjLQH/SThBc63ahXVJBAgsb9aeSuVmC2k9H79muROBb4S8hRCG+XWH0cijAJlo18MalP1t9y2R6RPJ7A8ezCzis5KvCQg+C8MAy4d08zg8wUOyAvfKHq1SwwPizyszP4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b191d43-8698-4c3f-b063-08de790bd97e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:01:33.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLPF9dcOrjvdNkOTtTbSNIae0yEgBd+aZ8odkWRF/RauFCD9xQtz89GECyWaQt09I0xOnh7KENfAPrz07jr4fQdnR4/kBpCh67ouhsaPQGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NiBTYWx0ZWRfX6xS7p/i5N8zp
 DZOLHZOEMK7nV8gdA87SCkZQU23a1m5Jdnn1xOeT1J3wnN58CRwb8sBJieyBRoqNGvjoZusZY+O
 x4wXAyULbD1LvI9wyRFaYUyKib/zkug14FlMQXq34BpKgBMfQ1YNaUX1B9htzTTUFLv0UmXnEAV
 EiuFaf0sg9R1/XWjkhPwBHxppBk6fG7SaUM3awlEt4BRAlX/LnPIsz5zuBmuL3HoSSWX/yopJjZ
 8bxxeFjHqg6/72buVsjX3E7/Yfpmp4mmy02xrokx4S5u5+NbSaJAacMy4NnBc4JIajcxKwAD5ox
 9SrywcoUfbbMv3BD8uvySc7dGSKS8Yu+2AEjcfviu+c+zYCoO9rdJtTiFvkDRy31OkgxUDWVwdJ
 ivHYkfccWbhIDMDDKa2OIeBcWiGL6PzXIVS7KwQLLRdn2KvBuELZPj4A8dkm/0cXtbk6+tX87m+
 vyDpTPP7O8+2smJFbGA==
X-Authority-Analysis: v=2.4 cv=P+k3RyAu c=1 sm=1 tr=0 ts=69a6b182 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=m6ntEmJwAAAA:8
 a=yPCof4ZbAAAA:8 a=uyy6HusMYkPfAz23_cgA:9 a=CjuIK1q_8ugA:10
 a=-07UcHROD-JCDqjaZ46G:22
X-Proofpoint-GUID: DuYD_V-JIA3P4gfkk7-9Ona6Wo63Vmvz
X-Proofpoint-ORIG-GUID: DuYD_V-JIA3P4gfkk7-9Ona6Wo63Vmvz
X-Rspamd-Queue-Id: 2687D1EC6B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79136-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,linux.dev:email,nvidia.com:email,lucifer.local:mid,oracle.com:dkim,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:31:59PM -0500, Zi Yan wrote:
> During a pagecache folio split, the values in the related xarray should not
> be changed from the original folio at xarray split time until all
> after-split folios are well formed and stored in the xarray. Current use
> of xas_try_split() in __split_unmapped_folio() lets some after-split folios
> show up at wrong indices in the xarray. When these misplaced after-split
> folios are unfrozen, before correct folios are stored via __xa_store(), and
> grabbed by folio_try_get(), they are returned to userspace at wrong file
> indices, causing data corruption. More detailed explanation is at the
> bottom.
>
> The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
> It
> 1. creates a memfd,
> 2. forks,
> 3. in the child process, maps the file with large folios (via shmem code
>    path) and reads the mapped file continuously with 16 threads,
> 4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
>    large folio.
>
> Data corruption can be observed without the fix. Basically, data from a
> wrong page->index is returned.
>
> Fix it by using the original folio in xas_try_split() calls, so that
> folio_try_get() can get the right after-split folios after the original
> folio is unfrozen.
>
> Uniform split, split_huge_page*(), is not affected, since it uses
> xas_split_alloc() and xas_split() only once and stores the original folio
> in the xarray. Change xas_split() used in uniform split branch to use
> the original folio to avoid confusion.
>
> Fixes below points to the commit introduces the code, but folio_split() is
> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
> truncate operation").
>
> More details:
>
> For example, a folio f is split non-uniformly into f, f2, f3, f4 like
> below:
> +----------------+---------+----+----+
> |       f        |    f2   | f3 | f4 |
> +----------------+---------+----+----+
> but the xarray would look like below after __split_unmapped_folio() is
> done:
> +----------------+---------+----+----+
> |       f        |    f2   | f3 | f3 |
> +----------------+---------+----+----+
>
> After __split_unmapped_folio(), the code changes the xarray and unfreezes
> after-split folios:
>
> 1. unfreezes f2, __xa_store(f2)
> 2. unfreezes f3, __xa_store(f3)
> 3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
> 4. unfreezes f.
>
> Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
> xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
> f3 is wrongly returned to user.
>
> After the fix, the xarray looks like below after __split_unmapped_folio():
> +----------------+---------+----+----+
> |       f        |    f    | f  | f  |
> +----------------+---------+----+----+
> so that the race window no longer exists.

Nice, love that you added this to the commit message :)

It is my mission in life to encourage ever more ASCII diagrams everywhere... ;)

>
> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reported-by: Bas van Dijk <bas@dfinity.org>
> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 56db54fa48181..f0bdac3f270b5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	const bool is_anon = folio_test_anon(folio);
>  	int old_order = folio_order(folio);
>  	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
> +	struct folio *old_folio = folio;
>  	int split_order;
>
>  	/*
> @@ -3668,11 +3669,17 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  			 * irq is disabled to allocate enough memory, whereas
>  			 * non-uniform split can handle ENOMEM.
>  			 */
> -			if (split_type == SPLIT_TYPE_UNIFORM)
> -				xas_split(xas, folio, old_order);
> -			else {
> +			if (split_type == SPLIT_TYPE_UNIFORM) {
> +				xas_split(xas, old_folio, old_order);
> +			} else {
>  				xas_set_order(xas, folio->index, split_order);
> -				xas_try_split(xas, folio, old_order);
> +				/*
> +				 * use the to-be-split folio, so that a parallel
> +				 * folio_try_get() waits on it until xarray is
> +				 * updated with after-split folios and
> +				 * the original one is unfrozen.
> +				 */
> +				xas_try_split(xas, old_folio, old_order);

Nice, looks good! :) thanks for fixing all this!

>  				if (xas_error(xas))
>  					return xas_error(xas);
>  			}
> --
> 2.51.0
>

Cheers, Lorenzo

