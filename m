Return-Path: <linux-fsdevel+bounces-16676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EB8A14B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F193EB24F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F111426E;
	Thu, 11 Apr 2024 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0sBbF8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3323AD;
	Thu, 11 Apr 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838733; cv=fail; b=jXgrqQUW57+ilZ3bfWOxTnfNiccUVcbprPJQo8lBOZ9fl2XOwQbwsN7BULAZ7rFYYm9UNczZZlvF8SUXGA3jythU9dN5VFOhLZanZXRytyVkBaB7Kj9iIeFZyWtamPlejfL6Ql7MpmP7usTMB4FRzarIpF0ICuZwkqPfIbLDDIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838733; c=relaxed/simple;
	bh=BxnLeiJLUD+lUd1tvgkc1SqxBpx2jhLXE7bepxM+BPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pgfHQbhwJ5tGvPfokuFG3uvLIIWOz7T07y8LD8FET8EqE3UbV8L43XQYhu7WkwGlQO+ppoEkc3u25qKS82gZQFTMQcrcfU9mAH+OTDocQNg6v8NllGttavNdRCt/4Q7oqybqKD/FPxES5DTwMTSJppgmMqSxCciezepZXBRWo34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0sBbF8r; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/vb3qt+fMfKWarBJtG1OUN7OrMjt2kr/P2m3oiFAQJhpC1+C4csvVJbt58ev0CJQumP3hDNAmTqZS9NaFX6O8sG5sv5iK4ikOJX9n8qjOt21e2ioYNY0MwvLubGdCgfLGC2cHhVrl1BsDrQmygd9ZKG3l9kpSjQvvSWFeVOkZxALrotvQosoWP3ZlIa6uyK0MuSbuWa5Q8KJ3blTGPwH21N8IPrWtPCoWfnLou4c7brP/uAM6bqBNBFVA7afic95SWKxqZqb9V447evx1V18AC+n/vji7zQbbmeo2oKOv06J4jYuim4PtUYinDOYitcP0GFSYSI/PafXsjCAzX/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/X+4uFcmj74B4moYCAmT+Ns0AktN/mS9uc2D5biaBc=;
 b=ReVqYqzCIwjkI+yETrX4XqAvYAfE1F8NbSud/A+NxmIIdsIe3sxrrSCWQp+/zkICuO8HCvmV0Hv+uuTOJnkDWxqs+w/JA6Xcomnu2sLtZ8t8mNFO9Tw6QC53IoP/ID/4w6wX7HqVa3Xssgp67rfwt4xphHT2Kp3reQxFwfvLyYnhFWddN1b1FIX2IUGew7ePZ5MzmlPmdUo+QJmYfb1qBeqWz0V12iamzG+JCaB811GPl4eGGDkrJaLmL944QwnGw3NSXZjM0Ql2cbrUJQ3QI/UMuAb5ploH/cus91n/pVroWAHHtCd5ZRHtSJipWULDKbX97xRhoJnN2DUMfloNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/X+4uFcmj74B4moYCAmT+Ns0AktN/mS9uc2D5biaBc=;
 b=U0sBbF8rsqSGz9ZVg8CwkYDSKl8e6BcSvMJbPOM/qpbS3z4A7CF4EEgGdoUuop5t1PS0El92PUHoFsZ80Jk9D2ro0rKFd7t3pm0hMb38Jv3h7x/tOJe6UPmGIzMNCMGcGRa1H+E5AxcWXFG1HC9/rFn82XrL8XDHauKHLzhsCUqtkr2q+7svOmGCt/m1Q+wAl7qHpkO4BXk4Lcbsr1DmWy5zo7QQfiVLo8+taJFfk19U2ocvTYYRi1YVkT1Z/wV8uCQlaNm2XYsXJ23EGwTIljNApUriylf3Ohg+oLbbyD62NFtVbF2gz1hE+9fCorMkq1/ku+0rL1UU5dz+ubYd2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:32:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:32:05 +0000
Date: Thu, 11 Apr 2024 09:32:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 07/10] mm: Allow compound zone device pages
Message-ID: <20240411123204.GS5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f1d80b-5c3e-4e40-33e8-08dc5a2365c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	biuA0jmGNpkuXdoAJU7iWL+z68RI7PV+r651mgjZOkOagwc/nesTjw4dnn6vqmMbIb//Ehy579O4fJ8Mop66lJzD58rGA6NTN3E+zYO4hZu1quxa75+NIKo0Qj4BnBHb1Dsn8yjh8PeVFUxVXy7oPE3G/6JBxfQ12HGRxVC0vL76KQdJtyMNMhBzAgAD+WhJOLck67v/bnR9EOsWblcR41L4YoKkI5R5it8juCXP4LYkj3YE/e+MAiTJ/yY3xC5xtS53Pzx4VwN+G0MvnI5c9X6zIsXta/cOaBYbhop4FOe6T2N0knBTUp/ItRKa2glNT0jtfCuaHAogEpT5anokItkRWsEJojSCfCJSdM0fbi5pv8Va4Tqraq7yaB/de3jbmGAaAi+Xptw5n7CgZuGhbtbpcaYrwmGKffzYiIaA6X4RRthJWaeCZmOMpGlwFVg3YVMzUvEWcbnL9Vt4KVzEV+HG7Rd2VfwR+0o0UkQct9BTLtdu7icxUyS7/AF3QzGDhEwR8XiXFF6091ogOfgZnLaNzjj+TljvcOrQxJ5nJUVy3o91vD2CN+OVRoxPqH/D5hd3P8T9cldlO5clJfprl8iTtZ0Zpj3UikF1GRZrS5vy6PXXUyLwQpZknj3n+mp2Z+WYU1h9gY078MMJqUU8YYGz/ReG/xsJI160l++H9/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dm+R2j1QUS4tnvpXRm+4lGFYZ0dZNIEHqONa2YQp6rmJWD/7MCgKmvSUE+BJ?=
 =?us-ascii?Q?ciSqWI269QvqRffxwCPLz5xoc30g0pw8e037Uyd5agcPffyl68VCqEecAjc2?=
 =?us-ascii?Q?OEFwzVtzjukXkKpuXmoW5Ps53vmfh8h8B2KrsPvLLPIkA0enQ5s1D9nSJfbq?=
 =?us-ascii?Q?hOB16GWtnD3k2z/VP6RNR5BuRphkhBeWNOcjBjUq7xE6bPB9gQcqWAQA3Cw0?=
 =?us-ascii?Q?quZ6Bmt98mMD2mCZgSvyHl2BO886dNPC00pbVn+iqOtLEljdp+IJmnJdtyd2?=
 =?us-ascii?Q?HugZVP7LKGCtO+B+HhDDoVIrncQQcyUx+7k5R0DJ9RpqjqRrv8MFJuL7oKl9?=
 =?us-ascii?Q?40+vjWZe6astkAixDmlQo3kXGKbQ5uJKdvg7RnT9qTVoGYKXplhMnkFSmY+p?=
 =?us-ascii?Q?hcHzHWFMmxh8bL4/buxM56r3WgBQPp7yPF9srXVA0P8owBVr0lw/EIyyxRKA?=
 =?us-ascii?Q?W8Z/5KESd+Zr95DUUuxdzIDBP8qlgC/ZUur9YImxWJPdN6ory89+OMoB29es?=
 =?us-ascii?Q?6HKjjtuQrW7vLTF8s0SH+hwiRK9dDEmhGRBZ/jjanAsJMZd7RZz0/9w03Z0q?=
 =?us-ascii?Q?P3/1IsXDN+wG7eYzihL5VssrUCoaosBmZvII/+oygsvFoOPKgqgPj5HSsAou?=
 =?us-ascii?Q?3yo1DGCe5pEvIuAva5JA3bP46ploGsIFuazCl4lce5mSpGyq2+HkXOlnjkKe?=
 =?us-ascii?Q?o2tAeOEVH3GFbYLss+Ch7oOo0gKkncNFvO1YRzx2n/hgZZXMeLlY2qUfSQ4j?=
 =?us-ascii?Q?M5gU4Om5j5u09lYrYSpeL6cDwUsB7oxgeVQUMVByeKOznIo8587TyzB72S8z?=
 =?us-ascii?Q?xa4IpwHHNwKZQkICRIs/+IZqLwU6BguVkYfzuBj8xHiHqpQBhVDo6RJPlFK2?=
 =?us-ascii?Q?gjO/soa1jvc2LKY34bdeD2CbEHYXKuvcOSlwEASCU2/zdoKdbe5k/QT831ND?=
 =?us-ascii?Q?61ditamRZDAKT/BRw+AEPIHEte2SnY2wiXmrWzgE9ZaJQiZK0tGipKwtrx4R?=
 =?us-ascii?Q?to+l7lsC9AmeK0qAlCP/9aYW8Dhp9Mm+C06YcHv35dSGxvtwUxwdI/6NKG8M?=
 =?us-ascii?Q?x7sbJxXVGwegWcXmZaciQTTNlCS4rnmCskkjBmdiyBXWTj9ugvdluZQepENy?=
 =?us-ascii?Q?6nQsaLqigTRCQJMXoXUhhLiXfOQaTNGp8PCyydiVHnR9+yNgbq9kV/jJz++f?=
 =?us-ascii?Q?vkBV8zwxE0b7pbjymQiprBWiTQbSa2SB4X42FEQJtwPXqi+vq5RQ1fdhmmwJ?=
 =?us-ascii?Q?6t5uYMEWqN4NkOz/381Qj6aKC85bBMHvFDltZgtJpUS+fWEDu/b0U/goaxrs?=
 =?us-ascii?Q?q1ZwxPiM0IaYIJWLFgCN0ISMLD1ovcqgkAx0X2kqdn9NyCLDmXNr7j8sCsyc?=
 =?us-ascii?Q?lat5RleGTMfHyGTKGYuTvVmE54lZH9hVwI3/PWAmWqSRZq4xAngFNJtzVhQf?=
 =?us-ascii?Q?tg1OGOLYhz5rLOtJkrYPeyc3mzNkEDX0GHt2yIIlJjNX1/Djs89MxZ7/pPI2?=
 =?us-ascii?Q?gQ6vAHijNWi3A4RFM7+GnTzYMnh98TfhuueAz2MhDZZ8H93AGUeOnGf64Nmt?=
 =?us-ascii?Q?iJNkeprt4a3lNMYC6eMpElvt1sFlkEADYQo9m+i2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f1d80b-5c3e-4e40-33e8-08dc5a2365c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:32:05.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGXdyIfZ0Kf9WT3ktjOc0mJn80C8WSgAu/Cb0LY3lo4S9MuFJcVdm9izxdqA29J7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458

On Thu, Apr 11, 2024 at 10:57:28AM +1000, Alistair Popple wrote:
> Zone device pages are used to represent various type of device memory
> managed by device drivers. Currently compound zone device pages are
> not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
> user of higher order zone device pages and have their own page
> reference counting.
> 
> A future change will unify FS DAX reference counting with normal page
> reference counting rules and remove the special FS DAX reference
> counting. Supporting that requires compound zone device pages.
> 
> Supporting compound zone device pages requires compound_head() to
> distinguish between head and tail pages whilst still preserving the
> special struct page fields that are specific to zone device pages.
> 
> A tail page is distinguished by having bit zero being set in
> page->compound_head, with the remaining bits pointing to the head
> page. For zone device pages page->compound_head is shared with
> page->pgmap.
> 
> The page->pgmap field is common to all pages within a memory section.
> Therefore pgmap is the same for both head and tail pages and we can
> use the same scheme to distinguish tail pages. To obtain the pgmap for
> a tail page a new accessor is introduced to fetch it from
> compound_head.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>  drivers/pci/p2pdma.c                   |  2 +-
>  include/linux/memremap.h               | 12 +++++++++---
>  include/linux/migrate.h                |  2 +-
>  lib/test_hmm.c                         |  2 +-
>  mm/hmm.c                               |  2 +-
>  mm/memory.c                            |  2 +-
>  mm/memremap.c                          |  6 +++---
>  mm/migrate_device.c                    |  4 ++--
>  9 files changed, 20 insertions(+), 14 deletions(-)

Makes sense to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

