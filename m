Return-Path: <linux-fsdevel+bounces-7819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75D682B6E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DC71C241F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2758216;
	Thu, 11 Jan 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qIvPiOKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8284B5AD;
	Thu, 11 Jan 2024 22:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95314C433C7;
	Thu, 11 Jan 2024 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705010454;
	bh=vlcXcSpUY2+iSpuukyjIiihCIi15p9GWtN159qEPSmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIvPiOKiywb3qKHwOw4AhxARGX3rVExMAkYo9hv3BHT3igPRSW4BaNs/lMgeuCScm
	 OMsg/kzkPq/hxRZ/bZeoPwvh42KWA/I7luc0doLezbSsgxia0Ctm69ZJlaEzbOp9kf
	 lV/bWz9fIPnphKtgLncv+J9AiA29wA4qUYIWfEOk=
Date: Thu, 11 Jan 2024 14:00:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Chandan Babu R <chandan.babu@oracle.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 x86@kernel.org, linux-sgx@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: disable large folio support in xfile_create
Message-Id: <20240111140053.51948fb3ed10e06d8e389d2e@linux-foundation.org>
In-Reply-To: <20240110200451.GB722950@frogsfrogsfrogs>
References: <20240110092109.1950011-1-hch@lst.de>
	<20240110092109.1950011-3-hch@lst.de>
	<20240110175515.GA722950@frogsfrogsfrogs>
	<20240110200451.GB722950@frogsfrogsfrogs>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 12:04:51 -0800 "Darrick J. Wong" <djwong@kernel.org> wrote:

> > > Fixing this will require a bit of an API change, and prefeably sorting out
> > > the hwpoison story for pages vs folio and where it is placed in the shmem
> > > API.  For now use this one liner to disable large folios.
> > > 
> > > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Can someone who knows more about shmem.c than I do please review
> > https://lore.kernel.org/linux-xfs/20240103084126.513354-4-hch@lst.de/
> > so that I can feel slightly more confident as hch and I sort through the
> > xfile.c issues?
> > 
> > For this patch,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> ...except that I'm still getting 2M THPs even with this enabled, so I
> guess either we get to fix it now, or create our own private tmpfs mount
> so that we can pass in huge=never, similar to what i915 does. :(

What is "this"?  Are you saying that $Subject doesn't work, or that the
above-linked please-review patch doesn't work?

