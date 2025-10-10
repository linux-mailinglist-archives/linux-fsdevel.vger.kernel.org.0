Return-Path: <linux-fsdevel+bounces-63776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C4BCD958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 145384FE941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCD2F5A3F;
	Fri, 10 Oct 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WxR2tsHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16232AD0D;
	Fri, 10 Oct 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107380; cv=fail; b=u9zuKnMlC3eds14mnCyWXxDisX7GO7SzVNlw17rSZtmbnINdFhwGUh0qrXLhZ9xz/WbKLxB9wJQvyql4957DmDxNNxiJa7ZKL4A6dT3mmCYE/dFyUHBpT0D3G15oQWhx+OJCADzoK/uDq2w5gthvCNLHT9C6zVOlrfWcRzC1UP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107380; c=relaxed/simple;
	bh=ZA7MHhCQQuy7FXiSxxEIJ7MZBgz+YxIqP2yAf+xOoDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VgqHBJ+XzQQofZhBFAXGv4yGiMSWnuzjJzyQUQ56ri/My09zCP11ofHlIIS9JqUxWILpPPFDz051PlQH5SHNPv4fJ5gl5asxNuiEYA7cQfuSN5MMSNIcaBFSbF9IecRVxLBRfi0oIj3horpgdlc8dDBYMrY7wyLQZrZoPrcZQbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WxR2tsHC; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5JJ3SFeDewaxHI/kzi9uQzNiAsXp0MgBo1AVjSs9f+NxTPF0seVjF4wPFo2e4ooeqSdcBOcDMQtyYIZIET0iFkXQDlgO1DDe9Aw/Wg/AzurSkcZvHQsocN7Lc9wYNk52FlNIGRZnF92LV5TmjDglwAyexO789zT09JHOInwSNeHpq2RwSWxOIgHik/N7yPKLuYuqXICJKD5+y21HGKF6yZKGJXc/9szm8bX10ZeBosFVgdEhihfAncMgGLitwQ6YUdcEf3uLQjdq7uusDudRWRHfUflh75r1xSpMAcIaCdYogO7CbqbgxjPBdR7iBGgAxbGBWFobG3OjmT1lvfbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asu8HEs+GkW+qG6imKeMwc6kGKkGgsya/aqaTtFN3NU=;
 b=w2QGE9SEk65BpEDHAkEqP75EiQ162MU4Ri3HETGsAoElneWG2y9LwFw2XzTjN8A22ExjZOal8jPb6MjKH95PuCFecOb7ZMsNbQLx+7EtukMy43fyXzpXlzvX5NXrgfjUua7z/0uSWodaxXwNQIBRY6qc8Uc+LwRlaeVUNvkNPuXnMunrYX9+TDuzOLSp+6PWCfgQ0k3Hq2NUoO7o55+R3P680MY+nGInsZszuJNtf/yaRs8h0f6z+kVM9Axlzh4vwTcF/fA/JXVSw0lrkB/UnFREZ9VYlURJPvMpgfYgSVvGrTKP19sitYgtQwmeOo0IcJ8SNwe1fCi3Ek08HvCYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asu8HEs+GkW+qG6imKeMwc6kGKkGgsya/aqaTtFN3NU=;
 b=WxR2tsHCVhEKZGjWzIEnJMPn5FrH2Dnzc/mDQoc+aSsDwKvvTCX3OaZfQtUt1mHlZNRfs0dLvHFVz0TtElccpTfGdWxDHRmZMp2avglyQtpGTCVQkTa7j4FuUnAwCErRNd+fH6BtbrRZwXGRPqx+s5/LI8MO59cWpPC71w0qezMog/Ni7Ikl4yUHFvkAKIDpygJB7sWukYgBtQYhuFAqJIYo2Q5XBRO9iu/2kWUqvV35bKWJFKWYLvDFBZ2RpGpCyFA7K/HAYwGaXRfE4hj+ve+dLcoiWv5SdtyWM1D1LTPa+qYaz91vYBHujHnfPsu0UFbqTXRDcpjqJOkFFVmCAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:42:56 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:42:56 +0000
Date: Fri, 10 Oct 2025 11:42:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
Message-ID: <20251010144248.GB3901471@nvidia.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
 <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0455.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 178d9310-2bd4-443a-1040-08de080b4901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0Ls71h2ndRJf6jculRep2mRDT0i4GygTi7VqvyOCTWmecF4QMgoK2T0Cx6H?=
 =?us-ascii?Q?irqopxZZau0gAh11Oz4o+ZL8ebIxUU+tRInh4sAIoUE5sWycnqHu7WTBnlHZ?=
 =?us-ascii?Q?Jk3pq6eUIEj3bpiyDuZ5gXQ4RAMa6yVYGpHBmiaY+f9cBzbKYq2cmoxH3gaA?=
 =?us-ascii?Q?KZSMUnS1kQBJ4qT01yJFOknKh9+jKspZrGwNOoWWDNl65V5jttn6d1/mD0t8?=
 =?us-ascii?Q?au1gjKpg7SeDHbqg4yolPAzJBOMpLSjjQCajE752+q6fXhtscMsCVb8WTUmp?=
 =?us-ascii?Q?XFY7BoiK40NoEDLoqIGXn0QaqbFLO0HHt/bD2nO2NOkBCh+GO4qoQUAkgw/J?=
 =?us-ascii?Q?aT+AOFcHD2sTaY4RHdBUY8geXr8p8FPLtqTmr3tk2QPcRuXKnGtSuegYZvfO?=
 =?us-ascii?Q?YW2Urqvh8EkAreqrfOA9sFuKbCZxL3wJikSB4GphKBJscsF2sawCq6zK8ylc?=
 =?us-ascii?Q?llGfyj70scNhxGj0CVzvXzPbJvvpetKre4r7uppWQBbdAO3J6zQOkIxpcX/H?=
 =?us-ascii?Q?QICDt3HV+CU97nVMHU/rEs6FTst3lhfRwpgBG04hWO3N5yPpPuuUSq4CvZJ3?=
 =?us-ascii?Q?9t70Ug1Ny0h4CcXlU3RKfBUkj7c94Iz1byIQzUpz78RVwqbI2iesRdTyinuy?=
 =?us-ascii?Q?Fb73z0EQ8ghRCJYbOwxhE3pwvQ5yuP4FZfoXM1u9E11nDXTMpvQ4ad9AbGTP?=
 =?us-ascii?Q?2nZ8fuSUnWteS7BFGTPpwAwAFq13tqNasS3ug88MtCSuFizoaxQbmGnmoxkC?=
 =?us-ascii?Q?dwS+STVLHIbKcO2VePJamyPW55ut9NgifnzUzDYgwk7cEP996AJ7m4A9ZZBC?=
 =?us-ascii?Q?NbenJ5DaUv60SySWqWgr73rKxz35RXOVjkb3xQUAKsw8XoTy7cX3Wc7dqdtp?=
 =?us-ascii?Q?hmisEtc5w5dF9uw70jxIkvV2GxAWna0aesUGoBmqlAsaIanmU+I0StbUhvNB?=
 =?us-ascii?Q?zIcSd20HEXkNbCZ8JRmm8bfjHIy6/hGwC87n0EV9fElv3tUG8vzlc5ndnWtY?=
 =?us-ascii?Q?2OmeVHEsUVpHWFCP0I9VvgpJGSO3qZPWOdAOFhGXeG/MWwGmCbqnEt4kAHUT?=
 =?us-ascii?Q?s507/UPQjPBwPf0kNDbBu5+YxvLfLowKJq1g2hMjrV0jrlQ7EfLDAOFoEvZY?=
 =?us-ascii?Q?WcfXeHxmHP41UNtI8ht5z3Af4bNXd9GdvNiCJfWNZJaEH/aNR1yBAh7NEO3Z?=
 =?us-ascii?Q?Vtffg5VlEr5o5yIQGajv7A8lDzjLnTgYroKxH8WR8RTFY75YV2khnMk5ydm3?=
 =?us-ascii?Q?vX31ERFaI3D7bHXNfttdCPF/WisVua6hv2cG8HZ3ugx6c+UZaEf128NLEdRg?=
 =?us-ascii?Q?0E8SGNAwLFSEAJGEtSR4YwsPp1er/g3bJnR01t9qQz6NGIAXGn/3Qsf49w01?=
 =?us-ascii?Q?iwxBj9v55fuSaAIZGbVLpSz/82YZbK1ud9x8Pz/QHQuAK50tzc9udfV8KXBG?=
 =?us-ascii?Q?kg32vtZkoMahJag8LOGGzv5Jf/PfrPzW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZM7JYReyHsnmX/mJzVb6DuGXtZguthRr6yRbjOKjxAGpOVGlPcgy5kLfIWYW?=
 =?us-ascii?Q?vtwR20nYkHWSxfGjioExzYShiAtfkm8itgHyqxELWBHc1ywxYkZhDJ50Vxur?=
 =?us-ascii?Q?dWgt3fjbijZXzKUZ6LazneAnb0vTbo0222GdjEfT8xD/CAjgDf0iI67v28Kj?=
 =?us-ascii?Q?JgR79kPmy/opBWLHjBvrgZulstvNSt99C1EobJgd2KzHGYdZ18fC/LG39OOj?=
 =?us-ascii?Q?c7uvddLLQGqLSwYfH1J4saEaK01S6Szs/T1mjniZzurTsJN2ZSjvpGtXlZNX?=
 =?us-ascii?Q?jllgwmB94R3jzZ44f+naLxDjQV0NFp+D55NJ+dQAhP5/o8/h6eoeS1W/Ct2E?=
 =?us-ascii?Q?AiT5u60z310HyEUh6KqdgInjI6Ui/FaQdUROG6jM2LlA7PECjmtgh8FSSaQt?=
 =?us-ascii?Q?Ffbls63Xry7Fyv/iuDef1/Xg5Dhdz1Z+EaoL4B5IVRAan3dNi5OhpmaGSNK2?=
 =?us-ascii?Q?pbj7JSJy9oXsax+GlDuR4ctKjHkMJAhJypMwLX3dhQIIf/SC3fIuBImpDuQ5?=
 =?us-ascii?Q?1yGFldAujtc8m0C2e7RFvQE0neosyKhN5Izx158kk6aLFYDdhc9s7ig1wK9w?=
 =?us-ascii?Q?jpzHMMGo9Avk2aLXQlRvfOHLw1OPvh4Rn/dau/5lmXUdu3yy6b/hgQK6MLkn?=
 =?us-ascii?Q?ueRSjPUTT5s+GV4EvM7SUgOQXTMnwuEmdfNWzHSHs9F2LEKujUcHJQD8Il85?=
 =?us-ascii?Q?RKxxXv3c+9ZFNtSMZtNJ727bNOrtoJQzUqqH9g03PleDlr/cIH67ey0Dv1YM?=
 =?us-ascii?Q?FKO6AMCO+Q+ggXdmn3H2vgOtSs5eBksZgzfnmcN6mEEA9DYLy1mk+7FQDwWY?=
 =?us-ascii?Q?N7t8ZlKBBX2vseu3B0nHgzzxEOCsn7gKBIuTgyITW03SatbPgmkpKcuhFV+0?=
 =?us-ascii?Q?TkCPNKUInJbrSJtk3XWR1ZLHVDpFh+mVK6k+BcfJhnbUPSZEBFGuKlY3DSqE?=
 =?us-ascii?Q?gmOwa8u3XQqZmQykrE1ZLGRHvZ+dhDYDCmPT54tSfDuZM5St9UpWskrdgERS?=
 =?us-ascii?Q?zIqDHEPt7Drn8bby28JukK6AB/82JDUf9n11HQOGxnwRDb1gmk1VyloXGbEQ?=
 =?us-ascii?Q?YrZPM1J2BGk1FRkVkENDrqxV/Go6Fx61z6w4xz+ysDpOViK5NPqphGefC5hq?=
 =?us-ascii?Q?jXP0e8YDXaJg/NCrNwhR9bir0evbu7O1l8TI8EbSmNAXLg0CV0LJOAxpFV+4?=
 =?us-ascii?Q?dV8/Opd6B0xDA4g/NvMexCLFkQT8N7RR+U8f33wDDh064sGkptfkAjZrFAyn?=
 =?us-ascii?Q?O1MRexOcx2rvoKwIZoZDsCUa6VCaEJiONPweipG1iaiF1P9A7SUeVvTRo+sh?=
 =?us-ascii?Q?lr06MU7YTcKzmu8YnoUjZxOHXSa9LFUybCvVzSNj+hOU0QyBhC8sbs6FJNTw?=
 =?us-ascii?Q?s7xbbxXpauz82aTvEbiWv7iFifvpLZS0DpEZiKnrRVYLLpg+XeXlkxWLD3bm?=
 =?us-ascii?Q?g4y8HBLU608fZ5DAlADofpiWF0f+zOHTTlQ12lF8bx6a9QbSMoWIVLwpuOvv?=
 =?us-ascii?Q?GH5FBx4P7of9wD/K5asWcNVK3v/bGTgY4lT7HifkGvEYoX1jdMj/kP4vU0Wl?=
 =?us-ascii?Q?kvuvMlBDwKwLoCBwKKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178d9310-2bd4-443a-1040-08de080b4901
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:42:49.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyhUcJfSDRLpC84zdu4M99FgkCKLDzsfeQKRkYmu592cIMX6elXY9/wLcwU8GXYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

On Thu, Oct 09, 2025 at 06:42:09PM -0400, Pasha Tatashin wrote:
> 
> It looks like the combination of an enforced ordering:
> Preservation: A->B->C->D
> Un-preservation: D->C->B->A
> Retrieval: A->B->C->D
> 
> and the FLB Global State (where data is automatically created and
> destroyed when a particular file type participates in a live update)
> solves the need for this query mechanism. For example, the IOMMU
> driver/core can add its data only when an iommufd is preserved and add
> more data as more iommufds are added. The preserved data is also
> automatically removed once the live update is finished or canceled.

IDK I think we should try to be flexible on the restoration order.

Eg, if we project ahead to when we might need to preserve kvm and
iommufd FDs as well, the order would likely be:

Preservation: memfd -> kvm -> iommufd -> vfio
Retrieval: iommud_domain (early boot) kvm -> iommufd -> vfio -> memfd

Just because of how the dependencies work, and the desire to push the
memfd as late as possible.

I don't see an issue with this, the kernel enforcing the ordering
should fall out naturally based on the sanity checks each step will
do.

ie I can't get back the KVM fd if luo says it is out of order.

Jason

