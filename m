Return-Path: <linux-fsdevel+bounces-7726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221A829E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111B82837B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF784CB3E;
	Wed, 10 Jan 2024 16:19:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A14C626;
	Wed, 10 Jan 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A18A568D07; Wed, 10 Jan 2024 17:19:07 +0100 (CET)
Date: Wed, 10 Jan 2024 17:19:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
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
Message-ID: <20240110161907.GA1388@lst.de>
References: <20240110092109.1950011-1-hch@lst.de> <20240110073843.d663fa6610785a8611b2cebe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110073843.d663fa6610785a8611b2cebe@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 10, 2024 at 07:38:43AM -0800, Andrew Morton wrote:
> I assume that kernels which contain 137db333b29186 ("xfs: teach xfile
> to pass back direct-map pages to caller") want this, so a Fixes: that
> and a cc:stable are appropriate?

I think it needs to back all the way back to 3934e8ebb7c
("xfs: create a big array data structure") as that only clears the page
sized chunk of a new allocation and could lead to corruption / or
information leaks.

