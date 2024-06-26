Return-Path: <linux-fsdevel+bounces-22504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FF918168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6751F220BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBE181CE5;
	Wed, 26 Jun 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3OGYvs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EE17E45B
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406212; cv=none; b=DGREfsgK0agVKNFGf2NpsVXVBceD4QJneIxLwzOHmSCUPn093ksK7W5ccNN7UdS2Xd46NOaCNFaZ6Dd6KLL4s2ocDQaR8/s3P9WFBWm1sa0ypFdm4wmUafxyaIiyMyyjkUCl+lrdpKyGEzNzs4wVd/Ca0gCZd+ZNKLElCD2N7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406212; c=relaxed/simple;
	bh=jbTXnw7qIaAfmmtUnIZqFzuKHXG/BarIXJwEcufp29o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAW4VsJ9JdimdqUANuyVZLyBJJbgInaytf3F+vqsRkFpB8QPIl8xGABRV8oRbz/EpfLoAJl50VKOORg+ZoNE6gixtQj5Q/KXEp3Hz2GQMaswOGpEUpAllDtd+MpWQeWhyBK7HiH0w+RlCbHh0MJ4klnxu9YQM/5H3+m2KcREt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3OGYvs5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719406209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weKxNpftDTdPudwJr8Js5RQeWZqeU3ZfmHi8oupmaRY=;
	b=K3OGYvs5RwUwGPKddRrZq6E1sBibeBUI6PuGaGH3VSPZ8nPZoZ5UxHUeNgpkbK+8vRvGrH
	iaJBT1mXhWS+iw9qxeQXabZJpxj26OcQPQnb4hgWd/IWgBclPaVLrnqik1rAsTuwsHvTEz
	QS664hlItQHti9MXpYsXjb8Z8MaQM8M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-kXKBROm5ONqYwr_gt73o7Q-1; Wed,
 26 Jun 2024 08:50:05 -0400
X-MC-Unique: kXKBROm5ONqYwr_gt73o7Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C20B919560BA;
	Wed, 26 Jun 2024 12:50:03 +0000 (UTC)
Received: from fedora (unknown [10.22.34.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10E981955E82;
	Wed, 26 Jun 2024 12:50:00 +0000 (UTC)
Date: Wed, 26 Jun 2024 08:49:58 -0400
From: Audra Mitchell <audra@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, aarcange@redhat.com,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnwOdqRcsiNeWNKT@fedora>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
 <Znl6dfM_qbH3hIvH@fedora>
 <ZnmFuAR7yNG_6zp6@x1n>
 <20240625160558.e1650f874ab039e4d6c2b650@linux-foundation.org>
 <ZntY4jIojSrjoW1M@x1n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZntY4jIojSrjoW1M@x1n>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jun 25, 2024 at 07:55:14PM -0400, Peter Xu wrote:
> On Tue, Jun 25, 2024 at 04:05:58PM -0700, Andrew Morton wrote:
> > On Mon, 24 Jun 2024 10:42:00 -0400 Peter Xu <peterx@redhat.com> wrote:
> > 
> > > >         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
> > > >         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> > > >         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> > > > #endif
> > > > 
> > > > If you run the userfaultfd selftests with the run_vmtests script we get
> > > > several failures stemming from trying to call uffdio_regsiter with the flag 
> > > > UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> > > > that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> > > > which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> > > > anonymous vmas.
> > > > 
> > > > In parse_test_type_arg() I added the features check against 
> > > > UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> > > > more than happy to take any suggestions and adapt them if you have any! 
> > > 
> > > There're documents for these features in the headers:
> > > 
> > > 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
> > > 	 * write-protection mode is supported on both shmem and hugetlbfs.
> > > 	 *
> > > 	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
> > > 	 * write-protection mode will always apply to unpopulated pages
> > > 	 * (i.e. empty ptes).  This will be the default behavior for shmem
> > > 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
> > > 	 * when userfault write-protection mode is registered.
> > > 
> > > While in this context ("test_type != TEST_ANON") IIUC the accurate feature
> > > to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.
> > > 
> > > In most kernels they should behave the same indeed, but note that since
> > > UNPOPULATED was introduced later than shmem/hugetlb support, it means on
> > > some kernel the result of checking these two features will be different.
> > 
> > I'm unsure what to do with this series.  Peter, your review comments
> > are unclear - do you request updates?
> 
> Yes, or some clarification from Audra would also work.
> 
> What I was trying to say is here I think the code should check against
> UFFD_FEATURE_WP_HUGETLBFS_SHMEM instead.

I was meaning to reply back and ask if Andrew wanted me to push a v3 and
change the check from UFFD_FEATURE_WP_UNPOPULATED to 
UFFD_FEATURE_WP_HUGETLBFS_SHMEM or if he just wanted to do it, but I'll go
ahead and submit v3 with the change shortly. 

Also as an aside I ran scripts/get_maintainer.pl to get the email list. I
probably should have thought a little bit about why the linux-mm list was
missing....

Sorry about the delay and confusion!

 
> Thanks,
> 
> -- 
> Peter Xu
> 


