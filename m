Return-Path: <linux-fsdevel+bounces-7725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FF829E60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64572831DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6B4CB3D;
	Wed, 10 Jan 2024 16:18:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C284CB38;
	Wed, 10 Jan 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9659068CFE; Wed, 10 Jan 2024 17:18:29 +0100 (CET)
Date: Wed, 10 Jan 2024 17:18:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
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
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: disable large folios for shmem file used by xfs xfile
Message-ID: <20240110161829.GA1105@lst.de>
References: <20240110092109.1950011-1-hch@lst.de> <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ6Pfk8tLXbvs4dE@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 10, 2024 at 12:37:18PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 10, 2024 at 10:21:07AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > Darrick reported that the fairly new XFS xfile code blows up when force
> > enabling large folio for shmem.  This series fixes this quickly by disabling
> > large folios for this particular shmem file for now until it can be fixed
> > properly, which will be a lot more invasive.
> > 
> > I've added most of you to the CC list as I suspect most other users of
> > shmem_file_setup and friends will have similar issues.
> 
> The graphics users _want_ to use large folios.  I'm pretty sure they've
> been tested with this.  It's just XFS that didn't know about this
> feature of shmem.

At least sgx has all kinds of PAGE_SIZE assumptions.  I haven't audited
(and am probably not qualified to) audit that code, so I wanted to send
a headsup to everyone.

