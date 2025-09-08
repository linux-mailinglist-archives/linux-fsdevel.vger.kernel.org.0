Return-Path: <linux-fsdevel+bounces-60572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE48B494AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C8B161634
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87B30F949;
	Mon,  8 Sep 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHEY7zKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BD1F873B;
	Mon,  8 Sep 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347394; cv=fail; b=U3savvSzGKNK92V6c2icax/66w2IuywPp9HoeuU8md1q8lLwUlCM7GzI06RUBUmWkG3mJbpocNu56emseL3GyQ8UxPK6TEBRWg+mybM4KAH/i96uJc+h+R80JbdwW806ZNGCRclHZWgM9O9NCSMhxU39Hv5ovExd9PZQEdNFra0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347394; c=relaxed/simple;
	bh=h+yu1jBNEdXeLI9EVTY9ibujhrMrrGdIXnxwc196pxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OoZM/Mq2SaYAa9XPdw9ds+6MJesJ+j5Mdhvb6fzR/kx+NKrg1dgl8Ja66DvhoXSlakeuFoFZI9DqyBsRr9u7JaYAZtIfjnPZa4yNCZqyWW9uRfQP05wl+VeLwH+ds05DLY5NfSwqWEhf5y5T7m9Pn/YRZlH+z2zEFXWgbgJJZ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHEY7zKD; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q00R0vvdxZ0D8Fhbc+CvT0111kr+RW98NYlUbHYS5vQaGqLHoWzXvkL5yW1kVoZiUQG0U6qE73y8HTcR/gf60UDKPcnEk3UqtbkjYY73S14ErvHf3ceHk/3nsD8hi9fu5u9YjkzcPaTt/Lu8chssk0AvgE4COd/XgCcnnxyYlYQvAAnb7+Ccdd0wkjm/WP3RGn1b/QgoANCXhUE6UkpjFM74Kfw6PjREh6lqyGmuJ9YLrmPJtnbye/udkyyTP/PtFTZDCo7QSd9d58Df2gzHMJoD02uQOy15e2BsQW/QbbndOqlqyyq7RjXIqFPyC+eITb/obMPxfyabMzfHtFnP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt9aTliZZuhRAufB663nCCMSTejhkiKkCRfqIGP2850=;
 b=DuASmmh6gvaUqLkCWws861uUKneJ4YVNhvg/Afmn41h2x+Ntjzm1EYtrzI7458zieeoPqPkLryi6s8jM/kBxeCF9j/PTtI7EIyDFFvHOLHWgJMNxrY6liKwG74vrlDzw1btCMIh5LHmoF0fpY1/SkhsiU5wTGk+Z6oc6e3lhMwsnxLxsK7cx8ufJlZdzYcuniT/NhCPSwEm/s6niLTJi5tZyOrPt4qS7otolzB7ogjC7ysI7gmg7/r0gRI9GZRDFRiHKZb+A5Go6EDQ90gkAzHVuqkQdyEfFoc/eeXYuEQYYUuN1zf0+LeEiFetVphKm63lv1srmv9YsOwLQ4AVJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt9aTliZZuhRAufB663nCCMSTejhkiKkCRfqIGP2850=;
 b=pHEY7zKDffAM83ldzimYMI6uUcrKcXUFWBctVZl+0A+cBUiDpw8sRQZOVOIfDNXvEm5av1dpKBIBptzkGhhIz5bYGXwrSpsurkFZeTVEj7hXO+AKO2upTyBDW2dbhmoO400hw0bLdw0EHFRPpJo5lSAduXIwBB2z78r0FQmWiyssBIZx7UQMviJNMeiJwetevHeDLkixP57ZdajbPf0yVdIJR0ZecGr6FUV/kl2nOGYYo+iBVbr4KPKk9Nf1YaRzrFNMhYB/eL44HOkSkIswWZ1dK/kNLfU6lgB5CfQDDlkO3+Exj1Ci3ahyiC9g/qHUtqkEWU5lMWNf8HGz1E4kBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:03:07 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 16:03:07 +0000
Date: Mon, 8 Sep 2025 13:03:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	ntfs3@lists.linux.dev, kexec@lists.infradead.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 08/16] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <20250908160306.GF789684@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908130015.GZ616306@nvidia.com>
 <f819a3b8-7040-44fd-b1ae-f273d702eb5b@lucifer.local>
 <20250908133538.GF616306@nvidia.com>
 <34d93f7f-8bb8-4ffc-a6b9-05b68e876766@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d93f7f-8bb8-4ffc-a6b9-05b68e876766@lucifer.local>
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f0150-4e55-4e79-a8ad-08ddeef13323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKh8P+a9TrV9/bNZP3bmGQUYmu/tVxXfQkL3mUdrFuZxJ88zVPRZJmiC7CQ9?=
 =?us-ascii?Q?SI/J+ad6uBVjJtw6GaFTWv+DjDM1z0sgH6/9kW0y50w3ecvJyfruv2oZD8hS?=
 =?us-ascii?Q?FcHgKoL/DlmrmPxd4EB7XcOGOi0edlaJQxALx19rjQ2RPmEbuwaS3eROMaMQ?=
 =?us-ascii?Q?XcwxvfnH26cuK8dRGfF00N0LDORNQHVRz9/1LVbUN1L72N/S3l/q/dfrnYJ6?=
 =?us-ascii?Q?/iA5s5IQftPfBaRZIoGDXcXgUtowbr/fv9FgM+s8SZ/y/r/sib8BFPMKfML+?=
 =?us-ascii?Q?rn1Mq51Yo0T0HslDDDtyQDJuWIfb8azAQOM865XUXEFlYgb6GGrrx4ZJm6IE?=
 =?us-ascii?Q?WL+NHFgncmGZNK2IQn69Uw4JSa6T0lGTBBTRNyMiXk0pwNtGq5AU4Q3EaInG?=
 =?us-ascii?Q?URWwsyoOazZuFerSJikZnhn+DATT+asI2D5t86lqlgDzJuqYw085NKYaOzcu?=
 =?us-ascii?Q?HWdsaVycWVnk3PpAXyRPUlLg1eZKVI+c04nTfO0U9sJaE4XeW+AUUc4ysPoq?=
 =?us-ascii?Q?YS14+4La4oUJ9uSVLUAh1bsLN85E5rLkOlFU4IaBIRtg++gPFDiEncv5euFf?=
 =?us-ascii?Q?YqhsK0A7QvVK3SocGJcNg7gUCmRpL827WqoF4LwrZP2xFEo8p07PrmsFPaOI?=
 =?us-ascii?Q?efMse+MAMUxt/UqGsA2VduYGQSnhSXa86jK9mXTrXeG+cFaqy5v4dtUPUmzZ?=
 =?us-ascii?Q?rNeoYI5yLGOc16/pVKPVtEV4wTB7ers/62hMANj27/zPDMCgyyDxvlUkP97x?=
 =?us-ascii?Q?L3UE3CZX6CeTsj7dhNsSglFYMQMKxziVst6sSSzpL/vCH97b4OoHJ9Mi1jYn?=
 =?us-ascii?Q?C5JVTVeHi8Parf4rCLLw1HUVbIKBnXwJsiNJGjaxNp3FvUqenje1ZYeij/uj?=
 =?us-ascii?Q?KnRsXjzdpOjpIjt+wcevtIo3P4Dh4tzjk3+xp1i26QDepxbZKxV+2jK1JDuw?=
 =?us-ascii?Q?GeUIKyzskhpWIBHpWV1oRXp46hAiZMiCkFt9B0Dnwat1h5OVTPfRTqeCkEht?=
 =?us-ascii?Q?Nb1m+salO5yRmykN0s6QG5h/GSscd8ebpat4hafg/f+/QJg//Th2aHItXwDi?=
 =?us-ascii?Q?w+u7FLLbjMwZ9wGh5P24Q9G70nMseTerExnxc4vqeCqRRhbzT9P4FW8/p02M?=
 =?us-ascii?Q?WACdGbBWHkOheh/GFxFFBO6NksJ5zjSwNA8huuzhoG0TDzSuCVboT3l7SaxX?=
 =?us-ascii?Q?JcPRMz9yBaI53gAWLbSWbGLYWjEj9ChWfScveqPSyEpIxEhC/7xtheUTUfjE?=
 =?us-ascii?Q?fNXh5FIJ10epuMDgN4pnpbT+SjVAgOmqqiSHTd12UEaomQUbdBEWvZKrktjL?=
 =?us-ascii?Q?VcupuiGY22ukog4VdyIsUnuKsx8KXH+1kpq+7FyfjXqQfJDW7R1SLzcvehBb?=
 =?us-ascii?Q?hUI8LyUMgr2X8fdqzlZM4XFPyASZTJrg2ZSaYV849Wt+E8Fiz6sS+65ohs7V?=
 =?us-ascii?Q?4K/zF/azRFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5753.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Di7+HYoZhHLGiOzcljW44OE/k8IMzE5L8NHJubYEvzqECa0m0qTN+LvvCoPQ?=
 =?us-ascii?Q?DJGzrKTLiJAQNTFAaewrBdrushviRZyIIeUJgGuJvc1qlJGAfkJ1PFi8gEvQ?=
 =?us-ascii?Q?OwP2/fIFoHpg8dg1TqXQL8FoQ3iw45uPHX4NmfuArBkiiLojgNQ3s2IGNxCI?=
 =?us-ascii?Q?8cwzoqZiyQ46/UCx98uR8jht+oJVaQbjovpHtp0k/4Iut61meU1zRuDztHta?=
 =?us-ascii?Q?pGxxlQv/vxuqkmCIdXt8Evso6MiXxxTFURpzmrX5AfCpISGuYWihD/l7CuTI?=
 =?us-ascii?Q?kUn//E/McDsvF0EYlwxGrA/ExyWx4KAjhH65O6rqwvkvKfOjyjLfH28PDjyV?=
 =?us-ascii?Q?a2cKSsLPAXXDB3PDunAbZJ1gPz0uJ7vYbCHbhUBVn31W6teyIo+Q+z56VvAr?=
 =?us-ascii?Q?Wik+O92ECIfiusR312tm95/0qtkvV4zwd8272XCyVFB1mR1Hgt3Oj0BMb2yP?=
 =?us-ascii?Q?ZjculdsL6uvKG4VBLkonpeAPK7tgf3Fand49i3tVwwxJtZGAS8Hkw194RJHd?=
 =?us-ascii?Q?OkMsW2axpbSDc1ogGaG7I/9irWJ7SuultRqIyyXbWnxjaQzQLn6/C4JjJQ7p?=
 =?us-ascii?Q?Zt7RNmjMgRcePy2CW2N22+/A8wQazIx0pmCJDc0BbNRFiqW3dgk6/TOjSyvE?=
 =?us-ascii?Q?TGnjynoJNdO1yWWCN0XY1cwCrZSl2y5HXCgfDS/MMpZ9MWfABlv3IjkAv/77?=
 =?us-ascii?Q?MnaSo34ndYk1Y2o9iS/d3S3jqC0EvfSqj6LH2RMjmezMksLp7b7URmR16TD/?=
 =?us-ascii?Q?6JU7U4ecSpsZKeUeHroXjumhyhOOwDy7SFwpfShhZNItsa/VTsn/1WrC4JLn?=
 =?us-ascii?Q?kD91iuKCdBiZfsFRNAT9G1QUYfn6jMztlBUPFHiLKyvActrRMp5+T9W9X9L7?=
 =?us-ascii?Q?qP5maWnsbwZgf2jWu42C7EW1gAu+8qYkpAIU61wMdy37YDx3Jph+Tz7WEJXY?=
 =?us-ascii?Q?Wt0Wo4Xq7o+SFHH9sHzEhDwFrshv1zYM2S7Fre0eIi2HD7d7Xz+3yo8B0BrW?=
 =?us-ascii?Q?prd1SJ/3qxKkZOUqrxpQn6lMbzwlHnc9HRss9yzRq3AeBfOfD6CNtrjAcwbC?=
 =?us-ascii?Q?gNgJRFXteSgMQZdO3BM9DsLh7/l9yqCAXo7T68+WOJFqcelCas6HeCn6U9CX?=
 =?us-ascii?Q?j407Bb15QBzHNDd3Pvbm3v0fWjbxauaNxqXCxRDWeGHE0pdvmYegQY8x3cvu?=
 =?us-ascii?Q?XTaMFhpUUP9cmwuoTH/vul662VRuCszhow3DHgQZTU6W1yWHAGj3KcK9RMVf?=
 =?us-ascii?Q?FjHcXr4zFRs+1rRtisju7KL6/TgI9Pf/80fpSY3PIpx/eqZw3qtLWP1C81Eq?=
 =?us-ascii?Q?xIJ4mjMECxjMuLQNsLjvbUsRKizQ1VCrApu59PwJfnZn/tog76CtxaphBqR3?=
 =?us-ascii?Q?4db+cBpmROKQsoIQ/mF5qsGxbJ2cLZolnVauvwTKhHjlSD76evWpZwIjTKl9?=
 =?us-ascii?Q?U9IOQTBSa08vB/d6uhCBCGmP/dRRvK1UD2xhJeBZuPn+g90INMNGjs4Ez8Kf?=
 =?us-ascii?Q?s+xR+vxp2EK8fmfbwfLlDRIhMc4Ajz1hNgqysZVOA0tF9tcva8kvbxYtQipe?=
 =?us-ascii?Q?MCNOWtLBGUL1PhJxBhI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f0150-4e55-4e79-a8ad-08ddeef13323
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:03:07.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oskmkHeAse2jgaCJUs2Yfl8HL0NEQXj+7yIdF/4uJciqoXgC3qRiBgsqz9TIjNS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

On Mon, Sep 08, 2025 at 03:18:46PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 10:35:38AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 08, 2025 at 02:27:12PM +0100, Lorenzo Stoakes wrote:
> >
> > > It's not only remap that is a concern here, people do all kinds of weird
> > > and wonderful things in .mmap(), sometimes in combination with remap.
> >
> > So it should really not be split this way, complete is a badly name
> 
> I don't understand, you think we can avoid splitting this in two? If so, I
> disagree.

I'm saying to the greatest extent possible complete should only
populate PTEs.

We should refrain from trying to use it for other things, because it
shouldn't need to be there.

> > The only example in this series didn't actually need to hold the lock.
> 
> There's ~250 more mmap callbacks to work through. Do you provide a guarantee
> that:

I'd be happy if only a small few need something weird and everything
else was aligned.

Jason

