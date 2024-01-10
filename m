Return-Path: <linux-fsdevel+bounces-7719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DDE829DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572972861D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063C4C3C0;
	Wed, 10 Jan 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="12YLOq2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B804BAB3;
	Wed, 10 Jan 2024 15:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B660C433C7;
	Wed, 10 Jan 2024 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704901125;
	bh=64lqTH5iAcNgqPcOUhTjX1MTBLqxaK2xsqzvXQVWa98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=12YLOq2msOrGh5ihkM0KYcAfSzQGt2JWuTC0DDJBK8ZQmLPKjhtXQ0oDaGj2TuisX
	 oTdQV7wRT0kWu+/eQ/4aYSPU+na3UorE7axwiTiigCT/2G/sdmtTYry8mEY7bNk1BP
	 ZvIMG1YRpOTjNG5aKANS7xGXt7wNQmbk9Ojb9B54=
Date: Wed, 10 Jan 2024 07:38:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J . Wong"
 <djwong@kernel.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: disable large folios for shmem file used by xfs xfile
Message-Id: <20240110073843.d663fa6610785a8611b2cebe@linux-foundation.org>
In-Reply-To: <20240110092109.1950011-1-hch@lst.de>
References: <20240110092109.1950011-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 10:21:07 +0100 Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> Darrick reported that the fairly new XFS xfile code blows up when force
> enabling large folio for shmem.  This series fixes this quickly by disabling
> large folios for this particular shmem file for now until it can be fixed
> properly, which will be a lot more invasive.
> 

Patches seems reasonable as a short-term only-affects-xfs thing.

I assume that kernels which contain 137db333b29186 ("xfs: teach xfile
to pass back direct-map pages to caller") want this, so a Fixes: that
and a cc:stable are appropriate?


