Return-Path: <linux-fsdevel+bounces-7717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61957829D8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148581F24597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96094C3A8;
	Wed, 10 Jan 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvV2RTu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6F4BA93;
	Wed, 10 Jan 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900512; x=1736436512;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:from:to:cc:subject:message-id:date;
  bh=fV7NAoQ0qHc6gn38m7vJBQuKu07R0duL29KMcubUULk=;
  b=NvV2RTu4jdIWCVbIwtGrftgtK/UHzbiDr+H56zN6lH/QU9aXIwABHMav
   bIw7XVEOZuTUbdlJtNyBG0Ta/NnOEPn4c6RhYqQpMkv68Hrcbqv3BHmt5
   gkTU4n1gJ9v/U1nhfGl2y0xZbdLw9ql7YtJtGOeD9FUkcFYnhxKgzgZoP
   DIfXE6c/wFV+HRsktNjJJKhQJEWf2lu1GNBh4mi4uvPOksDWjWNp9BXWY
   I8scW+ui+GXx0pMvU9pPOQYZFiKYKoM3cc/J30r7HhYLAwaWln+YV1EZJ
   WY/h3gFvWNMDe4ksNgcsxALM9HpCDzEjxAHD3KvQEgWFqXjLax6zpTlgQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="395704772"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="395704772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="30639512"
Received: from nselinsk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.34.242])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:28:26 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <170490002493.164187.5401160425746227111@jlahtine-mobl.ger.corp.intel.com>
References: <20240110092109.1950011-1-hch@lst.de> <ZZ6Pfk8tLXbvs4dE@casper.infradead.org> <170490002493.164187.5401160425746227111@jlahtine-mobl.ger.corp.intel.com>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J . Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: disable large folios for shmem file used by xfs xfile
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <170490050245.164862.16261803493864298341@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date: Wed, 10 Jan 2024 17:28:22 +0200

Quoting Joonas Lahtinen (2024-01-10 17:20:24)
> Quoting Matthew Wilcox (2024-01-10 14:37:18)
> > On Wed, Jan 10, 2024 at 10:21:07AM +0100, Christoph Hellwig wrote:
> > > Hi all,
> > >=20
> > > Darrick reported that the fairly new XFS xfile code blows up when for=
ce
> > > enabling large folio for shmem.  This series fixes this quickly by di=
sabling
> > > large folios for this particular shmem file for now until it can be f=
ixed
> > > properly, which will be a lot more invasive.
> > >=20
> > > I've added most of you to the CC list as I suspect most other users of
> > > shmem_file_setup and friends will have similar issues.
> >=20
> > The graphics users _want_ to use large folios.  I'm pretty sure they've
> > been tested with this.
>=20
> Correct. We've done quite a bit of optimization in userspace and
> enabling in kernel to take advantage of page sizes of 2M and beyond.
>=20
> However we specifically pass "huge=3Dwithin_size" to vfs_kern_mount when
> creating a private mount of tmpfs for the purpose of i915 created
> allocations.
>=20
> Older hardware also had some address hashing bugs where 2M aligned
> memory caused a lot of collisions in TLB so we don't enable it always.
>=20
> You can see drivers/gpu/drm/i915/gem/i915_gemfs.c function
> i915_gemfs_init for details and references.
>=20
> So in short, functionality wise we should be fine either default
> for using 2M pages or not. If they become the default, we'd probably
> want an option that would still be able to prevent them for performance
> regression reasons on older hardware.

To maybe write out my concern better:

Is there plan to enable huge pages by default in shmem?

If not I guess we should be pretty good with the way current code is, force
enabling them just might bring out some performance, so we might want to add
a warning for that.

If there is, then we'll probably want to in sync with those default changes
apply a similar call to block them on older HW.

Regards, Joonas

>=20
> Regards, Joonas
>=20
> > It's just XFS that didn't know about this
> > feature of shmem.

