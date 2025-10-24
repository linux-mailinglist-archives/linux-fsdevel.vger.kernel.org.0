Return-Path: <linux-fsdevel+bounces-65578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716AC08025
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5552F1AA35DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA72E7641;
	Fri, 24 Oct 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOSYeK1O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rJR58lxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FD72628;
	Fri, 24 Oct 2025 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336910; cv=fail; b=YXI0h1iOe4/8faWTlsQVbJQcbfkQDz9DonoU5gQBUapUJr8QJ8CcFM8RIrZAxYu6wSTsEisxaGKUvyP/EEy45dZqBUuzKsCqNdgRnMPH8+r+zWlonm1bATS+YeHSdFo0Su9DuUQ0sNlUeJfOeeJ7eGLk/p/NgEqMrPNffeEKnYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336910; c=relaxed/simple;
	bh=0mZCUWUkPEGNnxgQB+/ptEluZ1kGZseWNGLqCbsVsO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTtpvDSugUKBxvkw3nGWJa/JECCZD+l+cYgpk4rv7xcuhFGZMNqvQMHYUUOskpzta0/UyZFfsox/2Klg7bRW9d/QWug4d55KWX2tUhuPXO4siegjXusYGvRFud6th6BPwcJocbX5yjFeyWVOVixE0ILpxxHPhH1kgi4ml2gz+C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WOSYeK1O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rJR58lxL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINLtW012004;
	Fri, 24 Oct 2025 20:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0mZCUWUkPEGNnxgQB+
	/ptEluZ1kGZseWNGLqCbsVsO4=; b=WOSYeK1ObUsqAVml3A0SG8GI7No4BvvjPK
	PM9nui3mo+b6GMJ/7GCyrfHLJi+kWSwXfSHfIIHMqcS6CpQn9cOtqUuDNQmhH+5s
	4J2xrxU57GyyzL+oFV0pSaNlHNqGiBOD8G1Y8fVOM2pd/G3wy03552BptIAWASqO
	jUzwNqRWXXLjhsgzd44T6pU1ggfrb29Jg+HPa7VzcP1Ff6SsD2P7AChJI3Za5qA6
	H0t5l3YQHMewOJq40DXJkawWFgt/Ui/XJ5K2PQcY9Oslf6gDwGjE42qYmEkcQ/Ua
	+qAhE2h0NFdAemLPipWjvHYoUDNoDZQt/djdsbIdHUMJv72HOb2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0wj5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:14:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OJgXRF030465;
	Fri, 24 Oct 2025 20:14:16 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bhdwm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA/wEnr9SRKREQjB+DypZ/f9iKxWfLZ27dQ/79Z75iOy2RsOxixBxVFxpcrAEAnMvUoP3SOifoc7vXmVDBRWO1H32awLLvCmXhzUndg//IIem0U1AlmpCAT3aBOegVVX/sRickZbw8cbHXjdtD/gysdMApI6n8gsOv4wf4uzm1yJ/JUE77e9BGnpSfcBpm9EggmPy8FBAVyJ+dRhv/l2C+PCMYK69PIK2Hf5XRwtNF6r70/noxncXbA1z9KjhJ3jCYG7v6BeTeMLneiAEYRxyosPAw0fj0DuV+CeUM5EZxlDIw96myI5hqkOcFKE4ZKBOF0QeUydjznDyzkmyiGuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mZCUWUkPEGNnxgQB+/ptEluZ1kGZseWNGLqCbsVsO4=;
 b=mfWXU60jncc1sYrWm80zmr8JrJ2pVtGaO+pliBMcxs0y9Ecx0jPa4jpQZ+DKSNS7OKVdy5l+CZuIURvZdDkvQUCGxGJdWQwypHEMff8dNNVxxj5dBtCMK0VKEAjROCzLQc+smCdrkF95OvgD/QrXoo4SK323fG7X4W2SVF6hcvLrhg5BBnUILhfPKnJEVYnkdUt39DRODKt+3DTzJbffRbZS8ch3S7eI+hEFuJVjmIrB2SD4f/0zVpdR7ODvrNB7OS9a4j8l3m3gsRcrV2NL6iqioglZjME7o7/ZDSeQ2h5lbpZPYYOr6S/2HVQ2ZB2AsCZFNEVvsnlwy+s9Mszn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mZCUWUkPEGNnxgQB+/ptEluZ1kGZseWNGLqCbsVsO4=;
 b=rJR58lxLV2GKg5dbkBXxBykpg70i6e6zm0eRh4wxVFSsXo62JLyXcZdkzeCVwpo7cgAnjNIehu7cAV9qLrcmM8qyqlad1T1N9rFX147C0SPgfM9XPRJ8fVAA0NVpffc4URGgPTc40NxqUJ1DkX5ltlsF8JVUJUVCwJ8Jo5FEtDo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7102.namprd10.prod.outlook.com (2603:10b6:806:348::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 20:14:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:14:12 +0000
Date: Fri, 24 Oct 2025 21:14:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <10862498-3348-4cf8-a00d-355d12100443@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <7tjpibvbt2nwkkrzcbrsw3t3ehxckjrro6vxqukh4ld4memodx@cxfpmwbr3fo6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7tjpibvbt2nwkkrzcbrsw3t3ehxckjrro6vxqukh4ld4memodx@cxfpmwbr3fo6>
X-ClientProxiedBy: LO2P265CA0445.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: dca52c39-bb85-4fe0-4401-08de1339e5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OUFijJnfQpVUF/STPHX4vMlMCJA8UP3/jwo1YfFtBuqovJDuEDyuvPXUATR0?=
 =?us-ascii?Q?xniTTC9NWoNhHDUSDURWDAtqGAMxluCG4pJkyg2FGE/y0MLFdXfUEz8B9PD1?=
 =?us-ascii?Q?SikM4L/Go+Jt3UUC3CW8dG0itGc+DgsjI4dXNRD4R5ZbEIZ5C0NK0Oj3uHel?=
 =?us-ascii?Q?A0YkWui1C1bSD2oOFHlo0vUFpe44U5PGE7HR8qfAu8RsKIm54JDTwXZwMlhq?=
 =?us-ascii?Q?z4OiVkMCtcnxb04SgF2a1x/r6x2Hz2v4aCA5w9KKWUJbecLd2nWYxGxd8QI+?=
 =?us-ascii?Q?R6FOmfmMxVrhCYuCw54uxJ0XesAZRrjNnJFbHuusmR/hoG5nwLq9ZVaux3qy?=
 =?us-ascii?Q?ZjMeKrZJ6jk4UBrBRSvu1qaUkenEJO1AdZ4jY/7B78LjBrzqmaHY3A6rhxdN?=
 =?us-ascii?Q?07JtxGs7JQDrGE0/bRS3fFr2Ft2mGuTI3KbNZ/i8/24xFg0SYs+RfbcVBo/b?=
 =?us-ascii?Q?yx8Yr21TE8WY/TXoAB//mzDMb1IUnktxKKXfUFCFgSJ0X79jXZfosyUJrELU?=
 =?us-ascii?Q?oH1OI6cjKjc+4XDq8WA+aXFnS3m8P0MBnrpmpfut+Q6LfHWH3Ma/F8jZO9p/?=
 =?us-ascii?Q?L9gtYS1pEInGXAXmt6L27q2VW5/bdsneD3Ky3C+uvVPO8j92Z6jI7CwgH5zr?=
 =?us-ascii?Q?qQqNzRCWZPJa3FnJF1QvfMiXMWvN8GwCyANUlyecsYdojXOITwVkm3A6mQBM?=
 =?us-ascii?Q?riG7IHXTgdOPtGuBlFs3jLmpPbMZFr4amPExEUXbfIw9HRsy5tqcBoLfFo2N?=
 =?us-ascii?Q?9to3VSn8ngIKdZctGoPVlgJPcfmdJ8g/WRg9Pg4eSITRUJTu8yfO12Re96+b?=
 =?us-ascii?Q?8Uks17NSB1Wo9FNgyeTraBQ4/hioDiBicyxkY0R6qnMenebx/FY/a2VUe+QP?=
 =?us-ascii?Q?4WHYiF9IRC4xD1u0Y9FQqXMtJUnXZJ4qWCs5qEX+uPvojXmsMf7A3t/xGRDH?=
 =?us-ascii?Q?N9u2o2aHxZUG44db+bxs4XQQHrIE9sG9vvsNsh24wHZtVluGDrj7V57dANF+?=
 =?us-ascii?Q?RnUM8zWS1juTxg56/2BjWcjKZgT+d4rIc/nj/o+Vdb/EBO5v2QE157qeRlsk?=
 =?us-ascii?Q?fVo26k8RK9A/sOkue2vJlPfhMYsG1hUH120BB1u4M0O56kOvNC99QSX/7RLp?=
 =?us-ascii?Q?MXn26WL8gKALNInxLQmXKyrNCRGYTry2tVzICo0144LaTe3/IVptxN+E2kz1?=
 =?us-ascii?Q?ArVa8qI/qPWCYchOVXSCOaRMFB6HDHpFvIk4DVHYMNMrCGcVxqvKszFyd8ua?=
 =?us-ascii?Q?N7yT9mkKCOg8SItg3yii77U8yZ4Q2KDQ48cxYrIO5HKg1dMvQFHtnPOjuS0N?=
 =?us-ascii?Q?3FfSFbzCv7D50YGfK951qeSEiSSiuZTJ/e09pGuwYINKmQmuaP8LeOR1xuyD?=
 =?us-ascii?Q?jNPUmC9Jthj10w8jY/kHL9EEAfXe2KCiIQMkexqDURVb+X6EDBseueJQMqdC?=
 =?us-ascii?Q?pYTB19snJwMNHvet9RYchdhYtpHZt1Xr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13lFWSprIMEUrnKfysQuddqHkfv8/8OqpWPcC9PyAhlpnuolmMBvMl8wi+zm?=
 =?us-ascii?Q?NTkqAKWz+QSRmAbWdGbYcmpZ2vH2soepUF4vkXG3wW1m8Rt8mRhKaSLE/Z/d?=
 =?us-ascii?Q?iHzsQc2IHevkVtYQOTfrqiH4a+sFpiM0vrrXhW6qK0bIlURl3qcnfIZeVn8z?=
 =?us-ascii?Q?WmipsEZe0CWnqQ9Z8nargQL1q6rVgH767LJBwGBUqq/cNda1N63/Ju4snTn7?=
 =?us-ascii?Q?ajwvFfFIoSuGSssgJORN/4BgBiZkjz0v8rDfPpjJ/UlHeBJgQ8lwIBE0VBKu?=
 =?us-ascii?Q?6lkaTMQe2yOjKqBH1Aht27jyXtwEQ1kdNKqz9DcAYrWuq5N+4IAR9whVRNCa?=
 =?us-ascii?Q?iAXR63Qtr/vQTn8SpvJbHXIDI4KEd6e0Hg6PIBmj9t0AaqB7uQsDxsrQJYqS?=
 =?us-ascii?Q?DHNu6FSEy/1nFn81bWyWNpSHSDBpdoiuiPPK74p4itGxTbQihKjlKoccW5q/?=
 =?us-ascii?Q?sjhQDQ39p/JCpRmkTP9VdKkp9k0aQaw3gRh3Xmz19uM1ynjaoHj5TpHtD3Vj?=
 =?us-ascii?Q?1v/pH+fUvccSUm2z5VbjHK/3xmRC14c1IvzLCUXUHzrxBKNYHPwW8Zpr+3Fh?=
 =?us-ascii?Q?2W5dPATK/f5vdLz3gfwbUkIeM8t+EMAwN99XH/tM1PVORGgJwkscPLCRUxED?=
 =?us-ascii?Q?ciF0CKlNYbDtnPbD/iWITDiLJXLLej/Sk9hkIcLTyIofB6dXeB6QYQA1F4q2?=
 =?us-ascii?Q?F7P9DJ0Up+qm9N3pdO+J6/UdYr4U8K0cedZRp3aqoqiEA74/sarD8nuS3Qcx?=
 =?us-ascii?Q?Jkn1VN9YXu/9jgnPnz9gtfgylE/GmGJNiQCFUTrTFNzXbmAfsmFUpZEq5z0r?=
 =?us-ascii?Q?xNflhKlM5tn3atR3BDbxwmWh1iRzzz6kCHIBaDSW43ypJaYhZW2gCkO4mn/b?=
 =?us-ascii?Q?gOsUqixBs5ZolGBPBApbU8N6U9a9ejJ5dGhV19hKXxn8jYhgRXZwMlijrQXg?=
 =?us-ascii?Q?fxhXZMRxqX3Hv/LbU7s//PgG/qVbGP5MMTOQNO2v+qMS1izDa4I7/8C/CXF6?=
 =?us-ascii?Q?3yGiqNRjesSh3uv4Ciqom8BY5N9K2DscBkuRn6EuxEYrUFCDm9n5Zx7+z1xk?=
 =?us-ascii?Q?lFN98MfcOs2H3gQnKtn9o/czr61pD5ZNoXoNxsTwYfUHaUY2jFkhuV+c5SR4?=
 =?us-ascii?Q?6/tm8bskyAzy+Fcv+RO3KsqPuM4z5P4NMf+nNxkgBwICH+GjKRh+iecamFNe?=
 =?us-ascii?Q?XUeK4ewqqIDEvDA0fv/qoY7LYln8N0yXsncWHXR5OBn3InynSRbxQ5iXRELq?=
 =?us-ascii?Q?kgs6X7qmnD0sia7pj6iFFIBhRzZ1ePzAtVGGXM6AFvePlxV2SY8mL/7aJgAy?=
 =?us-ascii?Q?3c/eSiClVhIUSi3DCZvQBwdGgqG5jH5xsJAKLCU4kYenk/SSVp/F+k3VdVPC?=
 =?us-ascii?Q?w50SFsTZ8y14X4UTfqIa1+qJXmeCqYuIy6RxLdXNRB5LCDwB4rNVpypmE4yz?=
 =?us-ascii?Q?oKSa7RuE1FNyR1Twjrr1dX3HVfd52X4tYpAHW2SmZZU0LaahpA3EtkTkSO1g?=
 =?us-ascii?Q?X/CMcwvSgM+latPh4JzhhSSIzfQQsp+7vcCwiacTU326uJIpSgF4hFRxFkvU?=
 =?us-ascii?Q?ZisTjWu3oWGX/IJAl0ri2gQa9f9zx8yjHFimCFpj3ycUczDeIzVl33ioNbXw?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fb/0vmFIhyY3JnpONG2hgaR732/1eJngf2eF5QRIsUSDw/JsmQbdCLPprqS+XBsk5gzMxbE/8eOypuvO/nhVw9KMGjPUkO+cp8c3Waqf+qYamXsCFGoOGLhH9KVkDVA6TkxW0HIkLzq4cfkaWU1whsqYTtkdenxpU+4+5UvpZ+E31d9jLlLBere7bLme5GoCEs9Ombv51qKxZwNAtYTh43HIUYsR9g0p8+s7LJV02hRDWru5nBeJX3vMC06syqegj/5X4H353kLA/AuVmzA0t59kTwFq44tmYdfGzWalzFmmWIkLVSpC/9fDg/6nB7oVCbA0cZfJqfAiNwRAZ9KRVx6GAAzf0eyxEZExqvvKOqMKfPD1Q3jqir3pNjhN2RLop+WykgAeJ3ZojLxCfDgJIbznVXQ3FZVoNry5Pin7HF8r7SrnBSAKEvl0zhfGJQaNT1otuDEFn1PIDvVhJa0UrgdXH0HsB8FDK5euLHilCgHv+1snwUDN5dbkcq4EbJM7Y7qh6X9S2et0GJRqsESaDG9upvEY4M20ZyxetfSab2pvIpgruAviRBa74q7a65IyBh7ul3c2xquAqE1EpJ0V9YFPUeOsD/xzdWfu790QUU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca52c39-bb85-4fe0-4401-08de1339e5c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:14:12.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e40kbXkmlYPR6z1Sg/ook/fJnnLaOXA/fLQ8E/AhgtKIjeoPn4dsaRSoq07s2Ya4ZkfpkOnh6ZeBe4kyWhbWutuk1H8HBuxmlQwLHXZPKME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240183
X-Proofpoint-ORIG-GUID: z-R4osy-haIUZT7Z7hrM-QNXTUmjL2YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfXwrgqtW3pKSwf
 zLpA1M8pW2V1YLhU8WxCe4/LK5c1Mra8b3z3pRw616XM29Q5WLubFN1ipyQJ3urLmHiVBQodRnw
 pFpcSu4YKHNUyWFguGXf4XmRpm2v/hB4yxWc291N91gnym2wyFhwBdOLMsEDh2QsRhEYXF8qzNs
 l+Q+gxpeBGpHeK4jKJ22q6CWNr++OYISuGtoTnWiyx/6CvS1u5GC91D9uk7qMqFbLTE+oryxdA6
 MukGrkmFZ6LuetjQzKL89mnA0Sq9fLUotZ+JP2Q3K10j4GQw7N/oyovh7xZlp9ZMCJafduigAjb
 t77Xb2NEfNYkyDH2fgjEadQK7rhFhaUZ3pucAl3AskHit2qvyyou5MIXUusS5oF5PDyz7SUnMhL
 dAextFYRjtsg6nI3VD5OcpKzSPMfQCBUq4kV540EEvKbV8xRrBA=
X-Proofpoint-GUID: z-R4osy-haIUZT7Z7hrM-QNXTUmjL2YG
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fbde19 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L2rSnejp1Q9WeG8jOc4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13624

On Fri, Oct 24, 2025 at 08:05:33PM +0000, Yosry Ahmed wrote:
> On Fri, Oct 24, 2025 at 08:41:16AM +0100, Lorenzo Stoakes wrote:
> > There's an established convention in the kernel that we treat leaf page
> > tables (so far at the PTE, PMD level) as containing 'swap entries' should
> > they be neither empty (i.e. p**_none() evaluating true) nor present
> > (i.e. p**_present() evaluating true).
> >
> > However, at the same time we also have helper predicates - is_swap_pte(),
> > is_swap_pmd() - which are inconsistently used.
> >
> > This is problematic, as it is logical to assume that should somebody wish
> > to operate upon a page table swap entry they should first check to see if
> > it is in fact one.
> >
> > It also implies that perhaps, in future, we might introduce a non-present,
> > none page table entry that is not a swap entry.
> >
> > This series resolves this issue by systematically eliminating all use of
> > the is_swap_pte() and is swap_pmd() predicates so we retain only the
> > convention that should a leaf page table entry be neither none nor present
> > it is a swap entry.
> >
> > We also have the further issue that 'swap entry' is unfortunately a really
> > rather overloaded term and in fact refers to both entries for swap and for
> > other information such as migration entries, page table markers, and device
> > private entries.
> >
> > We therefore have the rather 'unique' concept of a 'non-swap' swap entry.
> >
> > This is deeply confusing, so this series goes further and eliminates the
> > non_swap_entry() predicate, replacing it with is_non_present_entry() - with
> > an eye to a new convention of referring to these non-swap 'swap entries' as
> > non-present.
>
> I just wanted to say THANK YOU for doing this. It is indeed a very
> annoying and confusing convention, and I wanted to do something about it
> in the past but never got around to it..

:) that's very kind of you to say thanks! I was motivated by pure irritation at
this situation after David and I discussed it extensively.

I was initially thinking we should consistently _use_ the predicate and was
arguing for it on review, but David pointed out the convention is quite the
opposite and it became apparent to me th the predicates were the issue.

Of course I have encountered this non-swap swap entry madness as all of us
in mm have, but fixing that ends up being a natural extension to resolving
the is_swap_xxx() stuff and a big relief to deal with also.

There's more work to be done but this addresses some of the more proximate
issues! :)

Cheers, Lorenzo

