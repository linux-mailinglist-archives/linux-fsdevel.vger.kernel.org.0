Return-Path: <linux-fsdevel+bounces-40271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB46A215F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 02:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256BA188790F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284B185B5F;
	Wed, 29 Jan 2025 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eSotQ9op"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320246426;
	Wed, 29 Jan 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113144; cv=none; b=QnzO7uRZt3eq5o7LjJ9aoTDHlgf0U3ZBOlnpQqOuzpy8Z87e3GOWl4s+jMbuRU6DKJWmMdCexMusBBI7wzZD3lX3efbeS/xHozETH1GnSNaSKppTWo1PETfMn/cmv8Qlw/Oz0OmvNHnyzHvK4RBvQqvVKx+ueDt4l+pE/j6ZghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113144; c=relaxed/simple;
	bh=ETaHs9gkHYBIFXP5D7M7NuRqfXZYO/NgZL8c0Qt667c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO3QVkCx1wzhQ4lFaraQ8GC2KjGWW1lCzV5R6LqrqTeI+zW7b+Nh7ibMz0xoNBk5MchfIn4tht3yN8JB6t5WDiStQrt1/CH3DnHZ+leIT3CbcpDUcwPigunQONPxk6SilTloUK5GSwMcSrQgFv/CZQ2gZLgmlifa4jT36KV73JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eSotQ9op; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7J8KDgNaiMyUNTv7R5gtte21eGPm0wGlgWoF1cUpOS4=; b=eSotQ9op8aPplmzjFCV8CG4JhX
	EdmG6U0D2opAdBqOmWQju0pC1iWAxzYocN/8vC7rDLW7hTsAQJXmXNlhLyVWEKiz8eD0OMTuUXqT2
	4oaq+LnNHFZRO2A5sre/129CmhObnueTIY+Ad4v7FiGOVGJl0Dja8vpCtOm02K/yzw8PKxLGgeFsz
	zWJcTdfZWx3i1ctjqMVI7JM0rpyu5Hx3dxs7JdkIxAzseR6aiNYJlKl1mZFs2DfGlXmtAdSedmj7s
	/Ejf8oAc2OQKGQaCVeQTs+hXoBpLO0Qm8kljGLW44LKkKVryFkA2LMAMyNDISpqPKyocsnze6JmNW
	+W2RJuzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcwct-0000000Erro-01BC;
	Wed, 29 Jan 2025 01:12:19 +0000
Date: Wed, 29 Jan 2025 01:12:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Message-ID: <20250129011218.GP1977892@ZenIV>
References: <20250128011023.55012-1-slava@dubeyko.com>
 <20250128030728.GN1977892@ZenIV>
 <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfafe82535b7931e99790a956d5009a960dc9e0d.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 28, 2025 at 11:27:05PM +0000, Viacheslav Dubeyko wrote:

> I assume that you imply this code:
> 
> 	/* can we conclude ENOENT locally? */
> 	if (d_really_is_negative(dentry)) {
> 		struct ceph_inode_info *ci = ceph_inode(dir);
> 		struct ceph_dentry_info *di = ceph_dentry(dentry);
> 
> 		spin_lock(&ci->i_ceph_lock);
> 		doutc(cl, " dir %llx.%llx flags are 0x%lx\n",
> 		      ceph_vinop(dir), ci->i_ceph_flags);
> 		if (strncmp(dentry->d_name.name,
> 			    fsc->mount_options->snapdir_name,
> 			    dentry->d_name.len) &&
> 		    !is_root_ceph_dentry(dir, dentry) &&
> 		    ceph_test_mount_opt(fsc, DCACHE) &&
> 		    __ceph_dir_is_complete(ci) &&
> 		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED,
> 1)) {
> 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
> 			spin_unlock(&ci->i_ceph_lock);
> 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
> 			      ceph_vinop(dir));
> 			d_add(dentry, NULL);
> 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
> 			return NULL;
> 		}
> 		spin_unlock(&ci->i_ceph_lock);
> 	}
> 
> Am I correct? So, how can we rework this code if it's wrong? What is your
> vision? Do you mean that it's dead code? How can we check it?

I mean that ->lookup() is called *ONLY* for a negative unhashed dentries.
In other words, on a call from VFS that condition will always be true.
That part is easily provable; what is harder to reason about is the
direct call of ceph_lookup() from ceph_handle_notrace_create().

The callers of that thing (ceph_mknod(), ceph_symlink() and ceph_mkdir())
are all guaranteed that dentry will be negative when they are called.
The hard-to-reason-about part is the call of ceph_mdsc_do_request()
directly preceding the calls of ceph_handle_notrace_create().

Can ceph_mdsc_do_request() return 0, with req->r_reply_info.head->is_dentry
being false *AND* a call of splice_dentry() made by ceph_fill_trace() called
by ceph_mdsc_do_request()?

AFAICS, there are 3 calls of splice_dentry(); two of them happen under
explicit check for ->is_dentry and thus are not interesting for our
purposes.  The third one, though, could be hit with ->is_dentry being
false and ->r_op being CEPH_MDS_OP_MKSNAP.  That is not impossible
from ceph_mkdir(), as far as I can tell, and I don't understand the
details well enough to tell whether it can actually happen.

Is it actually possible to hit ceph_handle_notrace_create() with
a positive dentry?

