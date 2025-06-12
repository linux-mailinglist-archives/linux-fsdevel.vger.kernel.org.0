Return-Path: <linux-fsdevel+bounces-51528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41AAD7E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14D87AA794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C82367A2;
	Thu, 12 Jun 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dfy8YJEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9F153BD9;
	Thu, 12 Jun 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768625; cv=fail; b=gDyJLv2DDdBUHuGi7x6nlHzWHMUiW+CuqYCOecMemDGKu62ba2bXeMgErPB5wQsMMOqmraG/UZUBJOvOA/H9KdrcwwKfUFOwmRe+Mq7SrX46/P8pDyZszHGmhILZLmfG7i3o4dAzAvVEIrjx+K2RCP1RfiPaSj2bCZN5T9fJSxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768625; c=relaxed/simple;
	bh=xFo0TU0kzZcPjRitA0pllV89e3EdyOuL3ay4vSQYgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxs+zDmrlSc/m3rAErlejZ143dor148Z+EWw/JkzhrLrkGSkLa942/QV/fxIiHN41CDwasbVquFG7v2qVtBmtREiJ9H72YSfEs2f7nUYAG/V1/qcG8U9/BlZBoWqelHrq9zXthH1t7A26+v9Rlw5MzfqE2tnq1d+sI1u2nvfdNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dfy8YJEz; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9WtQqMeYgsDK4LXBtPI8DJUYjSW8IsK+o0jdImkm4iFIWC7RxzHR392Uwj0+7JPKw1slYF94HGzOZbH3yYXhJBE1PtrrAE1ncA+fqes3vIIOP5jz+jcG0DcJu3xXYB+OmHcQYQAFxnP0gELxsfRRPALYPIJPAEcIY79Qs+BrDjWSByx5Mj/M6SB3TQnZKlkhndk4fZil2ARr6J4bOywQCcLPQHvon3d+W/arEOgN8cU9n2f/G+wErFBjU4pEnAiFsWrYTHSXd02cMEOjS/U77g+p8UNk04JNO9Be1tzYFmpTbXio/1vqkY2JiusHYFlZOyXBjHO/LLMgYzn21st8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoZL4nQnsuPbbzobiwxxLfLDempiqsD7YWenTsnQ5u0=;
 b=Vop0HI6zQH0oxxJNykd7snjXPvI4IF8f9wbj9rtTk0E1BaaPuU01Fp/a4E14i3NKeFYvFVgBuR01CSzLV1gnF9inBKLfY20e/1uo854M56w1x/FDBzmUZmmFWPd0gdb0fOP4bWtrNeH/zg4lgUAHKdKqt7yvZPYhboFbXAHH4kMdAM3Dj5lY8pS/Of0kR/CYP6uDJwZ0SnowcG2zavIdGb+E4a5c6bthsnu2Cj0WJshBzAN1S06abtYY/dh+SLRkxepUyUeJh4T8pOGkorZaQEL5sMuehMKj9/2e30Hp5WF+R1QbYAAGn3vdLjc4lhUj+CoLlAOJ0hxGjPm9HQW+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoZL4nQnsuPbbzobiwxxLfLDempiqsD7YWenTsnQ5u0=;
 b=Dfy8YJEzOexRWYLoog+n4L1hAGuVETR935zrjAXp0MFimi07TGwkjDngRmyaghJxabOq9UQ0U/Ox6sciTHrhFEXRsngAhv+KVXN8w95mCQtpy9jwolbnURzuz5Bllu5cCydU1GO7eK6Ddji0y4IbZGDLbBWNLq4so4j7eULdzXF/vUERIodo1QoW4qQOLY44AnaTiS2DJ/TpiguvSBZqsNiNqoczICjaGBSLqc074I77cPzguucTpfmhxU1nAqOhLqWJEHLbIo0wUWlJHbBJuP35XV5IpQqvoxzJFkk0vyfvoQS8XxpsRWE6Puqm8Dg0ytUx9m9iP1vFhp78ArH2iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 22:50:20 +0000
Received: from DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67]) by DS0PR12MB7728.namprd12.prod.outlook.com
 ([fe80::f790:9057:1f2:6e67%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 22:50:20 +0000
Date: Fri, 13 Jun 2025 08:50:15 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com, 
	dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org, david@redhat.com, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, 
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org, balbirs@nvidia.com, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	John@groves.net
Subject: Re: [PATCH 03/12] mm/pagewalk: Skip dax pages in pagewalk
Message-ID: <q6wgtlud6gyz47fxpxnaxh7vv647kz3h4qyrnsjelxq2nocfai@pvllo4c3spfx>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <1799c6772825e1401e7ccad81a10646118201953.1748500293.git-series.apopple@nvidia.com>
 <fda482ca-ed0a-4c1e-a94d-38e3cfce0258@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda482ca-ed0a-4c1e-a94d-38e3cfce0258@lucifer.local>
X-ClientProxiedBy: SY4P282CA0013.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::23) To DS0PR12MB7728.namprd12.prod.outlook.com
 (2603:10b6:8:13a::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7728:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cdde14-4bd0-4708-e1d5-08ddaa038203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/I/gpqyKPCXbZtOvGagQ7C3fdiL0ajL6Sc+ET0we2xvEimifd4hauH2a2Lnf?=
 =?us-ascii?Q?0hYUPKpgbMliarz65l5uYEMGCKgtkYJzP2D42Ficbir5/5YSAvGX19WLCsCR?=
 =?us-ascii?Q?SwBxSmZ+0zIeJE47Vl8+rUdUyZribyupZm6Yx2nUcugrSn3yeRc0y/samFzd?=
 =?us-ascii?Q?mrTTAaN0uiVmZHZ9h3JgFcHb/WBPWAcQt7/V10mIbotsgPuDiPFov9u17/d7?=
 =?us-ascii?Q?CYnhvojmvXP8mNlFB4C9eoJEyN57OVC3ijNQKsdBW1pef8jvu85rmpDTKN3L?=
 =?us-ascii?Q?maUxIQw04+iY+2iqY92Nr4RhVDglcdKAbEPA/fUqxh56Sn9M7aE/KtvUCcgw?=
 =?us-ascii?Q?Nc50jGpCE9vkV1DpNJgUHj1OEsyXBwd2nSbW1AJdSwVZUN6mAHd1nn7Cz29a?=
 =?us-ascii?Q?yjwYh4lN/nv0784X3vyDxkhmoKVK68yjK3Ag6cCLKdf4o3F4JQ9h3kgYJbC/?=
 =?us-ascii?Q?h0XtuwCRNvdGW1TB7PGjjHfdls+C0KtYQaRre59LaAik8KGNUEKoatZXmD7v?=
 =?us-ascii?Q?/stOh1Ex0ASLcvm5UIVx5UeOMhC3hgEemA+D9EX/UzRb5+u30sLixYEjG4o4?=
 =?us-ascii?Q?WyTjhCjjDGOE+MuEC88Se0MK6/1twzIn1w/Vy3I/TKHY3D3i9PKbo5phUx+z?=
 =?us-ascii?Q?umNoEmu7T+mIwgcYXLC2e8mvIVXuIsiTigoKETJqOCrVgDgKnRbBpF913q+Y?=
 =?us-ascii?Q?/y0GWhKNMmsYMoIOaJRAfw0wympvSXWHQOxtEXNqmoK9b6tzaOD4pNHOi/1X?=
 =?us-ascii?Q?9YZo+YvnEWlMrZO7X5Sr5oFbfV6FkkHwLwa839HGpBYiFznfS4yNfgifDdh1?=
 =?us-ascii?Q?VS/sMz2djbLoHlBHm671b0jNDzxaf43VDmFqhxZIOLpATA1g2ZswwPNeOpE2?=
 =?us-ascii?Q?KLZB7OO4/MttboAVP2ljpqqKYeWN6ZWK9CWAclPxXDme/dKtfZEHrC7LMus3?=
 =?us-ascii?Q?cMM5i5SKeZkUs2a4L2YfSX44sPgHCg9RgYYxge2oTG8We+AbHY8vShAF20hv?=
 =?us-ascii?Q?EKECrM3dgY3ifbl0ElF8fHm7KF1MpjtjxBjqswQwPg+wuTnzwkHoQ+8VvVbq?=
 =?us-ascii?Q?5vM+aDc+K6Yx8RVmJkmaN+acYutCPZrKR4n4JCQPYF/3sr0rH5USDtYPmom3?=
 =?us-ascii?Q?Eu7jG3lvK6tPx3eyWx6DFBLcLFqfTyAnafUdh2J9GKDmqfVLfzlA6jbNNDF1?=
 =?us-ascii?Q?YXY2FCQNeXnLRSReEKS70fXNe1igjoCVmKarE1XoVysxRm7J7ZVweRatzwZo?=
 =?us-ascii?Q?BPe9HwlFmahTDz4/3FD8nLChLHoH0OkKhv7j6Vwh5HwMPGyLfVubGgpNXhpN?=
 =?us-ascii?Q?+4TKdUaePhgzQq6wzAU/RlftE2pqGDOHyGo1C8DOeLDWihHQrJLKPqpLuCIA?=
 =?us-ascii?Q?yf8owpId/sNxJsxSBhVvCWBGeo1aozdU8AsoPXqgc6vNZ4ajYPq6Ng63mgmf?=
 =?us-ascii?Q?m4ywDXp+WlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nH+VVf3zCUBGiXeNYBib0WbsJt47SPfZLDDzEnfxRGfLhMATJi5IysCbD3ON?=
 =?us-ascii?Q?TCi2bYGN9Bmy7jUciTYm9QRy1bl6ai9gn2KAWTGKeT1hALcEQ4iVcWVpkxeg?=
 =?us-ascii?Q?eV1MF8s28mgUwknLiOF20APMPgs+pEew8UW/OR1427AhxjgnBHpLDtnQS5Ng?=
 =?us-ascii?Q?oBWZSNM+b7DeDWDzfju/taWCmeICFDCEtL5XxaM+weExgOYgjSOmiiWw+opt?=
 =?us-ascii?Q?+MRiSekn60x4RywrHpU5onZ08okj/K/SBEnTPFUqGFIGmgm4Cz/2s1LSn+u9?=
 =?us-ascii?Q?2WfPpHZ4y3M1hIw3IiaKCsD5Dv64/nKNPNP+/VQfA4ukd7ALRzuIOUnTQnR4?=
 =?us-ascii?Q?M6tN+W4KvJW891VFKxNFTOAw5jCdMjoKBlWXAo5ku0BEAbxIjdeTP3mWidSk?=
 =?us-ascii?Q?HmeTp+cjllYFuZCLEAotmnH3oySGc5By0ECx2Wf+5r59aDLmH5LhBXrQqALY?=
 =?us-ascii?Q?ZyHc0DA08jB78/kdyTaQiKBTJmm4nZesIX8rSYAEobxHZWgcJuPal445gnv6?=
 =?us-ascii?Q?Y+jjjCRqYmsUhurC8NNwxH5b+Eau//dpoThxOLrhzjgDeUyNtey68bNujzCn?=
 =?us-ascii?Q?RK1jU8qDkwN3vBefOZ2QCJP5wWFULetlwwf8riUf1OGZpP8CY9ZRZZjg3hh8?=
 =?us-ascii?Q?+EjFAQolzmMrROunGFo5HIdRRWEUCUKb3YupN+QUGJa98hoL2ZNeCdZcqrra?=
 =?us-ascii?Q?qjqbcH20i3kAefAI9OaCOkJ1iR70szOYtW8I1N/GSriBkXX6rAcNdOp6pwJb?=
 =?us-ascii?Q?9Gl2/UWAd7o2PqkJzk+T1+TDGnAzIIrFAmtqV21LMW45JezsWM9EdD8P3hNG?=
 =?us-ascii?Q?l9QUGYgrnD+cDZ+A6DYyAMtVIbcALOLRTba8an14jze57uN8x5LMDqdhi13i?=
 =?us-ascii?Q?K3svhgQXV+CTllOKG5CQqw2yLe0uyIO2o57HTZrwX4bG0KVIhzgZtu6Prcvt?=
 =?us-ascii?Q?+GzsuGMbGPJ1JfEUcXznP7z8nNd7c075Qap5Q6w40SAxnjxkjvDGHtv1yS9g?=
 =?us-ascii?Q?MwRPJNdNpXrM7tsKBbVuraUfD5GwZStnUoFhU7/m4x7Vrmxfevg6f2/Q9KO4?=
 =?us-ascii?Q?24iUSWBzScjL6VEK3SfMvW+rG6DWjyqJbWbuc3mnRtwsjJie26UyvK2zdBLe?=
 =?us-ascii?Q?+EsnFcY4o7y1EFHxl0ekAUq5ogmGoOxBGIS1JOOOPCLn3SObaZGcALu4+MNN?=
 =?us-ascii?Q?pe6ultKxzEps2dz9nJTG8Gqeakx9JO6u7cAQMSEpn3deNeZoi5FAwHA5cf1J?=
 =?us-ascii?Q?aaCKhad6oEolXWhnRY1y5MznZB7GjvwEdlYgDnuSTjMwOZdeuZjnzlK3iogg?=
 =?us-ascii?Q?xLWMEC5leIvx10tzuB4lMKXt5Dm7JNaKghZ80iGKyKIbxSGQ0qt7+uvRNy50?=
 =?us-ascii?Q?bfoXX+DkrMoTC1mj31nUMANU37p065Bcd96psb0Y2ekIWtK9M0aaww3fpo/p?=
 =?us-ascii?Q?fPzo97uFqHEEpqMq/eD+zyagfP+3pOIkK5xaf73yhlTsoygB2JzrivfSGUZ5?=
 =?us-ascii?Q?iP1hrF67l9bSGR1VO0OymiKqEPRnG+y4czY1IBTESf1naQGhbEZsQLocojf9?=
 =?us-ascii?Q?uowGiS4syEzrVWYAu3hhm4L6gTuE282yDSmvCQzV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cdde14-4bd0-4708-e1d5-08ddaa038203
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 22:50:20.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtDGNWNNX+HY+Par/I5yX6UMlbA+iRMLtO/gMt47T9psWU/Zdmt21bxa5Tgmq5JKtZYoU2/OParbmhQV9YfpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138

On Thu, Jun 12, 2025 at 03:15:31PM +0100, Lorenzo Stoakes wrote:
> On Thu, May 29, 2025 at 04:32:04PM +1000, Alistair Popple wrote:
> > Previously dax pages were skipped by the pagewalk code as pud_special() or
> > vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> > refcounted normally that is no longer the case, so add explicit checks to
> > skip them.
> >
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  include/linux/memremap.h | 11 +++++++++++
> >  mm/pagewalk.c            | 12 ++++++++++--
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index 4aa1519..54e8b57 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -198,6 +198,17 @@ static inline bool folio_is_fsdax(const struct folio *folio)
> >  	return is_fsdax_page(&folio->page);
> >  }
> >
> > +static inline bool is_devdax_page(const struct page *page)
> > +{
> > +	return is_zone_device_page(page) &&
> > +		page_pgmap(page)->type == MEMORY_DEVICE_GENERIC;
> > +}
> > +
> > +static inline bool folio_is_devdax(const struct folio *folio)
> > +{
> > +	return is_devdax_page(&folio->page);
> > +}
> > +
> >  #ifdef CONFIG_ZONE_DEVICE
> >  void zone_device_page_init(struct page *page);
> >  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index e478777..0dfb9c2 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -884,6 +884,12 @@ struct folio *folio_walk_start(struct folio_walk *fw,
> >  		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
> >  		 */
> >  		page = pud_page(pud);
> > +
> > +		if (is_devdax_page(page)) {
> 
> Is it only devdax that can exist at PUD leaf level, not fsdax?

Correct.

> > +			spin_unlock(ptl);
> > +			goto not_found;
> > +		}
> > +
> >  		goto found;
> >  	}
> >
> > @@ -911,7 +917,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
> >  			goto pte_table;
> >  		} else if (pmd_present(pmd)) {
> >  			page = vm_normal_page_pmd(vma, addr, pmd);
> > -			if (page) {
> > +			if (page && !is_devdax_page(page) &&
> > +			    !is_fsdax_page(page)) {
> >  				goto found;
> >  			} else if ((flags & FW_ZEROPAGE) &&
> >  				    is_huge_zero_pmd(pmd)) {
> > @@ -945,7 +952,8 @@ struct folio *folio_walk_start(struct folio_walk *fw,
> >
> >  	if (pte_present(pte)) {
> >  		page = vm_normal_page(vma, addr, pte);
> > -		if (page)
> > +		if (page && !is_devdax_page(page) &&
> > +		    !is_fsdax_page(page))
> >  			goto found;
> >  		if ((flags & FW_ZEROPAGE) &&
> >  		    is_zero_pfn(pte_pfn(pte))) {
> 
> I'm probably echoing others here (and I definitely particularly like Dan's
> suggestion of a helper function here, and Jason's suggestion of explanatory
> comments), but would also be nice to not have to do this separately at each page
> table level and instead have something that you can say 'get me normal non-dax
> page at page table level <parameter>'.

I did the filtering here because I was trying to avoid unintended behavioural
changes and was being lazy by not auditing the callers. Turns out naming is
harder than doing this properly so I'm going to go with Jason and David's
suggestion and drop the filtering entirely. It will then be up to callers to
define what is "normal" for them by filtering out folio types they don't care
about. Most already do filter out zone device folios or DAX VMA's anyway, and I
will add some commentary to this effect in the respin.

> > --
> > git-series 0.9.1
> 

