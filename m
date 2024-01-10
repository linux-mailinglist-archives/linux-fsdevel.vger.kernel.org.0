Return-Path: <linux-fsdevel+bounces-7702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC80829A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB362870D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD847A61;
	Wed, 10 Jan 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjdQmEOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D339A9;
	Wed, 10 Jan 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mD6sHMBYmecsugPR+rqNjdttLVO7dQDyLXBJHfA3g1Q=; b=OjdQmEOL6PU8ZoQsQV89vQU3uy
	xumb/fUI9PdT0ruLFWenL+EFY/R95394WPxc2QNSa6b9+lhiCqIZBbDzz//DCiBhiXjxszhvGAjZK
	lubqlfezkUxprHvhWFewYjO8MlMwV/8XU0qiMYiHWdWD93q+pm7cSJGaTmC7UhcepH6pQkziFJBwT
	9zlq4Vm18d/8ENBIIzB64LPPMc7hWRT75a4nD8cKTMDPldLhwu7kCijfcbGe6gCKSr4DmF4rMUVR+
	Z9wPq2/O0uuD9eCs7CXUPNcsIOiJH5ON+eRuVhc1opSoEH66EZS2OkOq4FbVIvqfaCEG4y3+dTzRO
	HZY7dWJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNXpe-00BQ5T-V6; Wed, 10 Jan 2024 12:37:18 +0000
Date: Wed, 10 Jan 2024 12:37:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hugh Dickins <hughd@google.com>,
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
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: disable large folios for shmem file used by xfs xfile
Message-ID: <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
References: <20240110092109.1950011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110092109.1950011-1-hch@lst.de>

On Wed, Jan 10, 2024 at 10:21:07AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> Darrick reported that the fairly new XFS xfile code blows up when force
> enabling large folio for shmem.  This series fixes this quickly by disabling
> large folios for this particular shmem file for now until it can be fixed
> properly, which will be a lot more invasive.
> 
> I've added most of you to the CC list as I suspect most other users of
> shmem_file_setup and friends will have similar issues.

The graphics users _want_ to use large folios.  I'm pretty sure they've
been tested with this.  It's just XFS that didn't know about this
feature of shmem.

