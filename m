Return-Path: <linux-fsdevel+bounces-22455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC8917471
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288551C2308E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568DB17F4EF;
	Tue, 25 Jun 2024 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IavJxZQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A5149C53;
	Tue, 25 Jun 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356760; cv=none; b=j1e097+q2WA0vMONZhpzI5YRHPE3+wMRJoy8XPa92URJpKJVFtinGbC66ghdOH+KHzUYPDqA4s0qWyPxXXIFnBCQtK+EHY6TmgnkmkjzR3i9BiVWcoX1XNo9jNfgqo2uq4q4XbYclktmDQlyE6iwZYnxhpt2gYYh1UhHTJzt2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356760; c=relaxed/simple;
	bh=uxeySYLRDffPc/EywyRRw/8U5tDd11mMRbyqbqAVGpI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GW5hBv6muVaEw09XwDkrURnNGHJX1/VR1HhD6Pjpd68yiC+XH6PIUymOVa7T6p3Wh16Vbgo9R1mE2r0jK+dfdIK4Ko/O076KxQf04MldeCtgDa4cP22xwkPt8ofsa1XcXnBdbBZeD8Qg80Uo0t2qKV7OrmXo2FWncgF2gnLe2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IavJxZQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70BC32781;
	Tue, 25 Jun 2024 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719356759;
	bh=uxeySYLRDffPc/EywyRRw/8U5tDd11mMRbyqbqAVGpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IavJxZQm8Wju17rZ7wwFagCnuImOAf/nsTOkUFCmFIf3b9yjxnT1t9eSmW2ccOuNF
	 XLRqGMLKENp7Xe0Avs8CXc8sEs6aUgKADDOSPUp3B0LszQsjoO3Ct52V433OXuZ+5i
	 x8+Zz6xN9vIrcxpecRBb6CEpCIx4fzFvJVTifCHk=
Date: Tue, 25 Jun 2024 16:05:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, aarcange@redhat.com,
 rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-Id: <20240625160558.e1650f874ab039e4d6c2b650@linux-foundation.org>
In-Reply-To: <ZnmFuAR7yNG_6zp6@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
	<20240621181224.3881179-3-audra@redhat.com>
	<ZnXwT_vkyVbIJefN@x1n>
	<Znl6dfM_qbH3hIvH@fedora>
	<ZnmFuAR7yNG_6zp6@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 10:42:00 -0400 Peter Xu <peterx@redhat.com> wrote:

> >         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
> >         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> >         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> > #endif
> > 
> > If you run the userfaultfd selftests with the run_vmtests script we get
> > several failures stemming from trying to call uffdio_regsiter with the flag 
> > UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> > that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> > which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> > anonymous vmas.
> > 
> > In parse_test_type_arg() I added the features check against 
> > UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> > more than happy to take any suggestions and adapt them if you have any! 
> 
> There're documents for these features in the headers:
> 
> 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
> 	 * write-protection mode is supported on both shmem and hugetlbfs.
> 	 *
> 	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
> 	 * write-protection mode will always apply to unpopulated pages
> 	 * (i.e. empty ptes).  This will be the default behavior for shmem
> 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
> 	 * when userfault write-protection mode is registered.
> 
> While in this context ("test_type != TEST_ANON") IIUC the accurate feature
> to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.
> 
> In most kernels they should behave the same indeed, but note that since
> UNPOPULATED was introduced later than shmem/hugetlb support, it means on
> some kernel the result of checking these two features will be different.

I'm unsure what to do with this series.  Peter, your review comments
are unclear - do you request updates?

Also, the patches weren't cc:linux-mm which limits the audience.  I'll
drop this version.  Audra, please continue to move this forward.


