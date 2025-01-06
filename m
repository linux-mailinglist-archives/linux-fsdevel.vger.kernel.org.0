Return-Path: <linux-fsdevel+bounces-38407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C955A01F56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E487161E34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77D1D54F4;
	Mon,  6 Jan 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NLTDt9A7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D435952;
	Mon,  6 Jan 2025 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736145813; cv=fail; b=e5q1GOlWVFrPnD4KH/u0nI6h+N7e6wJfJJU8+hIgVVUDj3oiEYSM4XRm1qW/YUy4d/zNtuWbkT4cP1j7eD4jwhb79K/5LU9wBoV8HtxA3rYKYk+VwhNuZscAHgpMeOYemQ1OLqBzuSOYLNppmXncP+tEIgl/hfmo0Yh99WyaKsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736145813; c=relaxed/simple;
	bh=dd6SIoVaoH9HI+7pP53lBgydVpJQ8Ea6SYjhNrX45Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BvieNk5rH80rrAzaU+wehJrR+pzmNEK/AJtUTvNo12q+Nld/qdWXuNL/XDee65XUuOR7InM6FDV+m6vSVFBRpjX0CKZrbsNZ+E/MMX8M12eby2JDhOaWqnaGb2txhLx8+QNkIL1zgN/pD7dIY/NcYZ4p43R//QuhLH6NY5bqh18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NLTDt9A7; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrzWKZFRSxGhxXwG1DDuAG/txA/cDvsKMN7dEbX0mfa/908bpoDOg7C0bzHAsy/F2/VbKS2+ifiTEOExk0UJo1S+Igp6AKuRuo1g05tuULhBHvoSBzfNhPA/fzlf2N2fkppMUnXNK+SVNZO3sVSc30qW84shuw76VAWdtkH+Lp/MLELnXv9A4468/XhFAb1B71WViTePTbI62TOxtaKjWZlZMgMnQ6vRJRcSNsh7twu5/xSWkrwiry17rDFBvGzEDjtSZGhib9qrgOFx1nfVFg03puR0cCbKyCB+hu96fOGHQUZmu2CU6ddRbpiCrW6G31rUQ+SlhvT89URd36q5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCcXG3JIFkEbKyh+uur/Wu+q8UM9XaBlD9VZ5VT4/Zc=;
 b=POJvYVHwVbQbXTz/reX1MWqDW9QQYwIrguH3FkBXGUEj9xa61jX2BLZhiTzCDmxSDbmYJElGGinr7+EH6EJhv6Uf6nH5tdQHvoX7NgDDWehJr5PAnVCfaasWH1Jc2VCbzXLe8rj5hrT59nJvesgrM75UQx+p64DXOlWOZt65VgmzryjoLMDTZYJZx/LFlgWo5IsYfO5RCgIEkP9hAlMknESrESrzIIOayT0LwKyM90F+3WzuKE/7L5k/FiP4uddF/yf5R+Ey0LPhpNZntRNqp5vZvCFbz3wQ/5nfyJPYPtlYXYd/3MGGqrkHrjKrBRz7w+qYOr7pVCOSdfXWCMGPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCcXG3JIFkEbKyh+uur/Wu+q8UM9XaBlD9VZ5VT4/Zc=;
 b=NLTDt9A7kncEHwE+gzy1McQOOdj9PNst/BFBS1w0gmCY1ixviVpAODoSkzaKd9SS4BfQZxovcJ1RGl6bas3qTGtPJVefxSsbht8okskTuXWmX1Z+VZ8tloAGfoZ6fnfUOXNX8PzCJmLmYLln7faZfXA5OOWYNQglu8uqlFsEvqcgXbffU07hE1aKtgUIeZjUYmwVjvzfUOdnZ9p7sIeKVKVsQMd08gaQz7IIDPMPTZCZelWy7xg+PY1rBnP17h5+RRm0SbmCwF/zzbPCyAxM/WQiImOhu/PkvustDVe+hF8qq0+GD8W1RA6emdOLgQy/G0/5j4Oajb/tcY70b3JvPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 06:43:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 06:43:24 +0000
Date: Mon, 6 Jan 2025 17:43:20 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>, a@nvdebian.thelocal
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v4 19/25] proc/task_mmu: Ignore ZONE_DEVICE pages
Message-ID: <54hi667mw7agwueoo4ijmogdvrt4unmw35xekwyiycrxe7o2i7@novwkzibndz5>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <f3ebda542373feb70ed3e5d83b276a2e8347609f.1734407924.git-series.apopple@nvidia.com>
 <c7bd9b00-6920-4dc0-8e2e-36c16ef7ad5a@redhat.com>
 <37rxl2bjda3psdknhboexhbg3hahf5ifmublp5fw7ltdoyqllc@udbz76jklmnu>
 <36334f20-2b9e-4529-89c4-120678bc5985@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36334f20-2b9e-4529-89c4-120678bc5985@redhat.com>
X-ClientProxiedBy: SY5P300CA0055.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bed9a7-f6ff-494b-e593-08dd2e1d6b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ncdyri868tJYUgjU/AS/aewgUGj97phEP5wqelOR1xhFnpqXJHbkZJnkeAnW?=
 =?us-ascii?Q?ISJPy+svP4NLd02F4wwLFOOkZ3WWGeTjwbaeEbbDpHTdWz0Op0uDZXn6oe1F?=
 =?us-ascii?Q?4xhgl8z+bn9+7bzWNQt0fWdReXkYVg0ohryfrqvZQhh0IL/F2UCrTvc3Bmy8?=
 =?us-ascii?Q?Y/ot/7lLBcLw1AkNLkiTdiztcp8Rr/qwumAAhcUz74XJJn9/3h+Agkncz+bF?=
 =?us-ascii?Q?IRIMXjGG6YivoF9H1TZ+AxoUkYZnJ+a+AX/zAX50FlriG/ArpOpE+PVH2ah7?=
 =?us-ascii?Q?lcnAOwXqGD+8fjxPDd25Fq0BKDtdfkexoaNoVV4HxNWaZ/Emw+N/BgHg+YeA?=
 =?us-ascii?Q?3rwUH6I04f/keZAof0oL/mW/SsausMDyvGK7s6hnaxR5OHB48Sit22QpcAgd?=
 =?us-ascii?Q?5YzZ9jzD9QKH+FydF9VVsppkf9L6qFY2fKKZcyc7NqridAfrPWG7pO1Ws71W?=
 =?us-ascii?Q?JulKfx02G+aH7Tf9ic6JXXVaxSXDQfuP6CXPIP31bCZVNvosBop2IKALMoPf?=
 =?us-ascii?Q?9FWKUjbBYfHEKXa/FfepTELPqaZuRrt5IGb/H68a3kyi5we/iNfC2AZYHd7k?=
 =?us-ascii?Q?Pjo80bEJVeC/7T4a+qKLK1PArAb+8d73uRdVglrtA8kKa21ejOiFoMJ3jyN/?=
 =?us-ascii?Q?GcEIIWcjUndIicMNreMVPK4vVDECvwxeXwaRlzrfzRdplZ9lN6fmNyhoYwQg?=
 =?us-ascii?Q?DD2p2EA7IJs3h6I6w7vEm/NorLimZ6IdHR6lVk1wWQiCPQyyidie0U2Y6wb+?=
 =?us-ascii?Q?XaX8ul1t4PYPMyoDcEql0ObucZqVLrGIOh03UahM5UZi1IzNyd2INos1xuKN?=
 =?us-ascii?Q?hfxhIAfmrSYToYTl+BU4WorbNq1lM8y/dafqJn+n4TZJiJy1nhnmVK+t3ijH?=
 =?us-ascii?Q?jyOww0rmpHQR/WV0ZcAYnBUtj2G7/KVtVPhodUE5JtUODliKetTYT+bF9C9f?=
 =?us-ascii?Q?UQmqTMF2HlVWBPleXIT39nGpfj77VpqappmguakX3p8YZrTcLLjFStEw2OQ7?=
 =?us-ascii?Q?W+PoAzsaE1vOpfskfYcdOwxya6/YFsISzXLhIVL3E6ubqAxA2ksy4njX8E7I?=
 =?us-ascii?Q?FDQfu4P9pUH94N2hdcbthPjvjuASCXJCCitpkwd1Ef2ckVwImgPe3Lm6KPZf?=
 =?us-ascii?Q?hVoHiFTPKZ41hLdjbaKDB97zfE5MnE22vkvof9sBhMLAVDhKSzVLFX9yQS6t?=
 =?us-ascii?Q?zihPfOmTq8H2bwKugGCSCVDQ2/U0e1KbDoKbprxJXQRcRPEjrEjvt65je4fs?=
 =?us-ascii?Q?UDwJlpRvDLsBjEk0kncDKcKynFtHHcYiOXT5tsUVPFtMFUK+kK446V0Yy+cN?=
 =?us-ascii?Q?3GQXDggCewI4vXtXfHrKIICu7wAHbC3Nnfo+EGiKnS7KT+Go5kAdKV4gBxzn?=
 =?us-ascii?Q?0hHy6RvhIfy0ZUR1nKsj9+9I+Lww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LtCegbPKFp0togHtIa15iB24W0Rh3Sg36cMDf4i/nqCKVHu/gslMgPc1p0yb?=
 =?us-ascii?Q?eKGSTz4wukWvQ/hsAvK/hJHkN8OXbGOyNJeF6DIlOjxb77qIr7X6NDskSvg3?=
 =?us-ascii?Q?BAcYAPG0Gq99f3tusGaCnkIl3NrJ6E0cEbtePcSBYmJGshYhBHNwkAnKYkqR?=
 =?us-ascii?Q?HJ0Vlau0ESYvYdsv3D2rLdogJr937HR/xBxBxLLtVnv4RjchkDLe93zYxFTg?=
 =?us-ascii?Q?CJ8YvguSwxjMgNb7hQphOkRkBDXPxTQvl+iizLDOYqxbDiBstoaiapR8qilS?=
 =?us-ascii?Q?sBoL6aP5R7LHr1Y/o1s33lZwxtZq0zMj3DoSoBdX7sC6u97AwfXT1mQ5O3bB?=
 =?us-ascii?Q?k5+4EIUZbgm5sTtjnEsk3i8LLDEv2+bPTZJbkXMdeuxx7oer6mSXE8CHbgqA?=
 =?us-ascii?Q?iAoEmZcRD7IF+0SnGZYHickerllRT5zQS9aNeXMkg4lzHdrddBivrWQw2c9M?=
 =?us-ascii?Q?6Wm4dP1PuWnYb68oGDOGK/0Y1xrDeZ7hZSnw0zofJL2ki1e8BQetshPu1M+9?=
 =?us-ascii?Q?qwGq35zTQ94yGztSFAT0DGcWaHqbOayUmuWYKZ88HbuOVjHAZL2yTSYmL0Dz?=
 =?us-ascii?Q?ziWWCyDvE3YovIC0q5MBwfkLKsc7bBSeGmNIFkUyNDqJq/30HJMZarGsODp5?=
 =?us-ascii?Q?5yN90chjDklPM4O83KwSI110BLARXv3T1EqD8TsVJ1Br5brj9UGKOVsrpGhB?=
 =?us-ascii?Q?dK7sqqcC5uQh8o57Bcc3wwonblm5eiHuUtbzesdCoM7dXDzKjzmAobtFmAkk?=
 =?us-ascii?Q?fiIIZbqQ+Z7vZWYsXweRd80oUMMuw6lPCy3yZGbY/S/E1PQjUqW7MH/spk8N?=
 =?us-ascii?Q?nt0YVJRWvO2Q9i5S89ckh5PWwZ6l0unn5NrL0Y8C8OZm4gG7ZxaeaIyR+pLE?=
 =?us-ascii?Q?CJCAtqfmZM6dHIYUUCj+q2TaOD2Qv04YGP4uUUmWYycfAP6eZmNo6FECSw8n?=
 =?us-ascii?Q?M047Vt4hQbklbX1Yh8F6F0Lia3NO50rf6VS/BO9TNygL0slqqi8pd0/V14NO?=
 =?us-ascii?Q?GXJg7DOMRYxBrAWoz2VyJ1QJRaenW7YBgIHtjtXXq3BFeIDIYm98LMGz3LWJ?=
 =?us-ascii?Q?dNF9p3l8n1fm7Ks9HDYQhEgsBOcNx/hqxyHoptufNiIzrtUX2Z4uq2XlFBQF?=
 =?us-ascii?Q?g6ESmA88YofrxWxL6FH2sxNJi8uByvkqZIqHwkJQdkPMPK5nqUt3mXLbrsDN?=
 =?us-ascii?Q?6VR+T62AcwUdq2sjYH9AbowDjWMYHCrqIAB9VY7Wm3gNK+u/vIex6wPTr0ar?=
 =?us-ascii?Q?kYljzHAomvTLZp9LwMoD8MxlTFoDuZXM/batwEzYypmhCyQxOFrFhrtChr0I?=
 =?us-ascii?Q?q88td4nbwZSuTTeStt7CEu/1z6XA4ZgDqlNtcss/bX94ckXfh0G8sZ9RUoQD?=
 =?us-ascii?Q?wfP4lu4Bz2B58mlmTxfoUPbA6l9ZfsfriFWchX9DU32TGthDZINVw8nxBc2j?=
 =?us-ascii?Q?NOeGh2mFYoGBXHs+ea51AlLjMcVPpR6FB54LhVjjzB5Pl3WbcKvFmS40UIoV?=
 =?us-ascii?Q?2nPL/XnuEjXuIiAK+2NpxiDbwXsKeQ4F7tnDzUq6Ga/epf/lXZpP8UVfUopF?=
 =?us-ascii?Q?Fkh6zouS1teQecAUMmwxF3b5uf+Y2gkSaSG/B5O9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bed9a7-f6ff-494b-e593-08dd2e1d6b4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 06:43:24.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xew9SqsYOzwEXBZwBE9a5GoZbdqd1svaYPGY5YX/R1QDrRpr10vHFRBHi+vTfsETdLUDPPdLwsf4W2J+RL5v+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

On Fri, Dec 20, 2024 at 07:32:52PM +0100, David Hildenbrand wrote:
> On 19.12.24 00:11, Alistair Popple wrote:
> > On Tue, Dec 17, 2024 at 11:31:25PM +0100, David Hildenbrand wrote:
> > > On 17.12.24 06:13, Alistair Popple wrote:
> > > > The procfs mmu files such as smaps currently ignore device dax and fs
> > > > dax pages because these pages are considered special. To maintain
> > > > existing behaviour once these pages are treated as normal pages and
> > > > returned from vm_normal_page() add tests to explicitly skip them.
> > > > 
> > > > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > > > ---
> > > >    fs/proc/task_mmu.c | 18 ++++++++++++++----
> > > >    1 file changed, 14 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index 38a5a3e..c9b227a 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > > @@ -801,6 +801,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> > > >    	if (pte_present(ptent)) {
> > > >    		page = vm_normal_page(vma, addr, ptent);
> > > > +		if (page && (is_device_dax_page(page) || is_fsdax_page(page)))
> > > 
> > > This "is_device_dax_page(page) || is_fsdax_page(page)" is a common theme
> > > here, likely we should have a special helper?
> > 
> > Sounds good, will add is_dax_page() if there are enough callers left after any
> > review comments.
> 
> :)

In the end there was only a single caller so I will leave this open-coded.

> > > But, don't we actually want to include them in the smaps output now? I think
> > > we want.
> > 
> > I'm not an expert in what callers of vm_normal_page() think of as a "normal"
> > page.
> 
> Yeah, it's tricky. It means "this is abnormal, don't look at the struct
> page". We're moving away from that, such that these folios/pages will be ...
> mostly normal :)
> 
> > So my philosphy here was to ensure anything calling vm_normal_page()
> > didn't accidentally start seeing DAX pages, either by checking existing filters
> > (lots of callers already call vma_is_special_huge() or some equivalent) or
> > explicitly filtering them out in the hope someone smarter than me could tell me
> > it was unneccssary.
> > 
> > That stategy seems to have worked, and so I agree we likely do want them in
> > smaps. I just didn't want to silently do it without this kind of discussion
> > first.
> 
> Yes, absolutely.
> 
> > 
> > > The rmap code will indicate these pages in /proc/meminfo, per-node info, in
> > > the memcg ... as "Mapped:" etc.
> > > 
> > > So likely we just want to also indicate them here, or is there any downsides
> > > we know of?
> > 
> > I don't know of any, and I think it makes sense to also indicate them so will
> > drop this check in the respin.
> 
> It will be easy to hide them later, at least we talked about it. Thanks for
> doing all this!

Not a problem. The other main thing in this patch is also hiding them from
/proc/<PID>/pagemap. Based on this discussion I can't think of any good reason
why we would want to hide them there so will also remove the checks in the
pagemap walker.

> -- 
> Cheers,
> 
> David / dhildenb
> 

