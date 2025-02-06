Return-Path: <linux-fsdevel+bounces-41077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370AA2AA19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88BC162AD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C191EA7E6;
	Thu,  6 Feb 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv5AuJBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EA1EA7C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849076; cv=none; b=kmZ/F5FIRL3VpjPvtJGrPy7+u/MzL8Vf4fJtEkho1ZXjGug0uBPum/ZOc6J1pXoeZ/n9BKgN/F+A2oI+klr2A78KbrIRaHfAF+LqL9AHO7638RkPrmqvTEGQlJ00nNjhxOsGHva0piIO7Ax6VdmQFR2X9sEZ1Cu12q4usRvUTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849076; c=relaxed/simple;
	bh=9Ytmps4fuBO/htaxCKDp7kdUCmpWXLYbMLnjp7sR0E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/HEDQEA2+pcBmkKKo604ZZ20EZ46gyFRpN3JDUyU6BR22npGQU7+UF2KbQJIupX0LlIrA7cHXAqm3P+tx1J9TERr8w6Wo7OyEIDD0YRuc8PX2nSjbFmewjQuOc/m7QFXD/Vt5BvFMmci1qaQW8xLf9+Evk8Jtb4eQh+N40CWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv5AuJBV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738849073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5N+Al59YmEDtBoKSzwKPTh6WUXLbEAKXSUpJ7QukWWw=;
	b=dv5AuJBVq2vzNPk2BWqp0H0hPwA6KyS0YqU77gNaJp3QO5ql2aVRFKSbg2BmA9p47Lgodw
	wGLvm+yTL1hgmb6cg+o6IuXdISKttoHM/p0pCqBPFjVX52KYATb06JBczmCw5XbnTPugEJ
	D4gF07wt1CdLlj0Y86jQZ0/LOyNEcfY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-Z1CCXbCkNJ6JlHV_rykxEg-1; Thu,
 06 Feb 2025 08:37:51 -0500
X-MC-Unique: Z1CCXbCkNJ6JlHV_rykxEg-1
X-Mimecast-MFC-AGG-ID: Z1CCXbCkNJ6JlHV_rykxEg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A21C18DFE39;
	Thu,  6 Feb 2025 13:37:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.235])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FC6618004A7;
	Thu,  6 Feb 2025 13:37:09 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 9E1E56AA45D; Thu,  6 Feb 2025 08:37:07 -0500 (EST)
Date: Thu, 6 Feb 2025 08:37:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net,
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
	loongarch@lists.linux.dev, Hanna Czenczek <hreitz@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <Z6S7A-51SdPco_3Z@redhat.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
 <Z6NhkR8ZEso4F-Wx@redhat.com>
 <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 05, 2025 at 04:10:15PM -0800, Dan Williams wrote:
> Vivek Goyal wrote:
> > On Fri, Jan 10, 2025 at 05:00:29PM +1100, Alistair Popple wrote:
> > > FS DAX requires file systems to call into the DAX layout prior to unlinking
> > > inodes to ensure there is no ongoing DMA or other remote access to the
> > > direct mapped page. The fuse file system implements
> > > fuse_dax_break_layouts() to do this which includes a comment indicating
> > > that passing dmap_end == 0 leads to unmapping of the whole file.
> > > 
> > > However this is not true - passing dmap_end == 0 will not unmap anything
> > > before dmap_start, and further more dax_layout_busy_page_range() will not
> > > scan any of the range to see if there maybe ongoing DMA access to the
> > > range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
> > > which will invalidate the entire file range to
> > > dax_layout_busy_page_range().
> > 
> > Hi Alistair,
> > 
> > Thanks for fixing DAX related issues for virtiofs. I am wondering how are
> > you testing DAX with virtiofs. AFAIK, we don't have DAX support in Rust
> > virtiofsd. C version of virtiofsd used to have out of the tree patches
> > for DAX. But C version got deprecated long time ago.
> > 
> > Do you have another implementation of virtiofsd somewhere else which
> > supports DAX and allows for testing DAX related changes?
> 
> I have personally never seen a virtiofs-dax test. It sounds like you are
> saying we can deprecate that support if there are no longer any users.
> Or, do you expect that C-virtiofsd is alive in the ecosystem?

Ashai Lina responded that they need and test DAX using libkrun.

C version of virtiofsd is now gone. We are actively working and testing
Rust version of virtiofsd. We have not been able to add DAX support to
it yet for various reasons. 

Biggest unsolved problem with viritofsd DAX mode is guest process should
get a SIGBUS if it tries to access a file beyond the file. This can happen
if file has been truncated on the host (while it is still mapped inside
the guest). 

I had tried to summarize the problem in this presentation in the section
"KVM Page fault error handling".

https://kvm-forum.qemu.org/2020/KVMForum2020_APF.pdf

This is a tricky problem to handle. Once this gets handled, it becomes
safer to use DAX with virtiofs. Otherwise you can't share the filesystem
with other guests in DAX mode and use cases are limited.

And then there are challenges at QEMU level. virtiofsd needs additional
vhost-user commands to implement DAX and these never went upstream in
QEMU. I hope these challenges are sorted at some point of time.

I think virtiofs DAX is a very cool piece of technology. I would not like
to deprecate it. It has its own problems and challenges and once we
are able to solve these, it might see wider usage/adoption.

Thanks
Vivek


