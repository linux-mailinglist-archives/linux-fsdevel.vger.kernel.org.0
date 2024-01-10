Return-Path: <linux-fsdevel+bounces-7718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73335829D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E3B1C22774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC74C3AA;
	Wed, 10 Jan 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fe04VqEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E21D683;
	Wed, 10 Jan 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39NamAoxPWMrCZaJEOF8WH1zyLewDTeBBeunTxnTycY=; b=Fe04VqEjetu6tDXLZhxHNA4HKy
	VJycpIBjiVmVELkZ97TvGjWx3WlWJkM9LjthNGeXZu1eQB00JzR+Mr8DPWSLutF2Ja7yvCikoXpwP
	znm58+XJoLj7R0uD7Hx45tuQ7OTT9LAfkSJZ5K7Io5Y70+/NrgDwKIb7T/qHWATzIF61w7jVsdCHD
	wbc1oFr9DT07rRTNm6qmIaLNIbc0eCkZbU0NTxz4X2Di+W6u9RQ9iHT3ftKO6E0Ny3QEy4eFnbtni
	x/rjcAclsaEEZ796tcOTmiG3Izzzqvou+CMphB5MlYfmbrJPLBISQVnCl/A9NSim5B8e/iwIuDV2F
	aXTMD4bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNaay-00BfcE-JQ; Wed, 10 Jan 2024 15:34:20 +0000
Date: Wed, 10 Jan 2024 15:34:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: disable large folios for shmem file used by xfs xfile
Message-ID: <ZZ64/F/yeSymOCcI@casper.infradead.org>
References: <20240110092109.1950011-1-hch@lst.de>
 <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
 <170490002493.164187.5401160425746227111@jlahtine-mobl.ger.corp.intel.com>
 <170490050245.164862.16261803493864298341@jlahtine-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170490050245.164862.16261803493864298341@jlahtine-mobl.ger.corp.intel.com>

On Wed, Jan 10, 2024 at 05:28:22PM +0200, Joonas Lahtinen wrote:
> Quoting Joonas Lahtinen (2024-01-10 17:20:24)
> > However we specifically pass "huge=within_size" to vfs_kern_mount when
> > creating a private mount of tmpfs for the purpose of i915 created
> > allocations.
> > 
> > Older hardware also had some address hashing bugs where 2M aligned
> > memory caused a lot of collisions in TLB so we don't enable it always.
> > 
> > You can see drivers/gpu/drm/i915/gem/i915_gemfs.c function
> > i915_gemfs_init for details and references.
> > 
> > So in short, functionality wise we should be fine either default
> > for using 2M pages or not. If they become the default, we'd probably
> > want an option that would still be able to prevent them for performance
> > regression reasons on older hardware.
> 
> To maybe write out my concern better:
> 
> Is there plan to enable huge pages by default in shmem?

Not in the next kernel release, but eventually the plan is to allow
arbitrary order folios to be used in shmem.  So you could ask it to create
a 256kB folio for you, if that's the right size to manage memory in.

How shmem and its various users go about choosing the right size is not
quite clear to me yet.  Perhaps somebody else will do it before I get
to it; I have a lot of different sub-projects to work on at the moment,
and shmem isn't blocking any of them.  And I have a sneaking suspicion
that more work is needed in the swap code to deal with arbitrary order
folios, so that's another reason for me to delay looking at this ;-)

