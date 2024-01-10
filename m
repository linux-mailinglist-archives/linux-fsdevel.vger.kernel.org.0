Return-Path: <linux-fsdevel+bounces-7716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D6829D67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9512870AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B614C608;
	Wed, 10 Jan 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjSEzug+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FF4C62A;
	Wed, 10 Jan 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900037; x=1736436037;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:to:cc:from:message-id:date;
  bh=E0Bmp/5XWFLDuolIr/rqLJ0YwdpFYqvUjJulwkaWkOU=;
  b=QjSEzug+9KjtPQjwBL60X1mZyrkHmc0QIQa+7Wa3YedTK2f1RL6dWh/m
   gTnsXcHBG8ghgPJc8mubGT6tsWd1wS0S1wRAmqzY3R/zuf0pFeHzRjngd
   +LpRGawRX9v4irtQrzBIHDffoVa97aWYj/v25Cup9VepoPa65TEFJcig8
   PpUvlSodvqV+3UjV9X0aMnSURiCq30TZyFIeLUVWgGrqH/OQg7IIuoEUz
   xpZsYGtkUXX6yigNmoST/gL6bEpIO+riAyFykTWqEAn0YGko8c1oYCs3l
   UvEu97qpJweA6sGJjbd+7otWXRy8QMvXQdSpGUIC66eFh3S+a2X4c4hng
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="429731669"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="429731669"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:20:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="905573417"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905573417"
Received: from nselinsk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.34.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:20:28 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
References: <20240110092109.1950011-1-hch@lst.de> <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
Subject: Re: disable large folios for shmem file used by xfs xfile
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J . Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <170490002493.164187.5401160425746227111@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date: Wed, 10 Jan 2024 17:20:24 +0200

Quoting Matthew Wilcox (2024-01-10 14:37:18)
> On Wed, Jan 10, 2024 at 10:21:07AM +0100, Christoph Hellwig wrote:
> > Hi all,
> >=20
> > Darrick reported that the fairly new XFS xfile code blows up when force
> > enabling large folio for shmem.  This series fixes this quickly by disa=
bling
> > large folios for this particular shmem file for now until it can be fix=
ed
> > properly, which will be a lot more invasive.
> >=20
> > I've added most of you to the CC list as I suspect most other users of
> > shmem_file_setup and friends will have similar issues.
>=20
> The graphics users _want_ to use large folios.  I'm pretty sure they've
> been tested with this.

Correct. We've done quite a bit of optimization in userspace and
enabling in kernel to take advantage of page sizes of 2M and beyond.

However we specifically pass "huge=3Dwithin_size" to vfs_kern_mount when
creating a private mount of tmpfs for the purpose of i915 created
allocations.

Older hardware also had some address hashing bugs where 2M aligned
memory caused a lot of collisions in TLB so we don't enable it always.

You can see drivers/gpu/drm/i915/gem/i915_gemfs.c function
i915_gemfs_init for details and references.

So in short, functionality wise we should be fine either default
for using 2M pages or not. If they become the default, we'd probably
want an option that would still be able to prevent them for performance
regression reasons on older hardware.

Regards, Joonas

> It's just XFS that didn't know about this
> feature of shmem.

