Return-Path: <linux-fsdevel+bounces-68563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A613C605E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 14:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9B1334BE6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9552BE642;
	Sat, 15 Nov 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AuInizII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23129ACDB;
	Sat, 15 Nov 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763212898; cv=none; b=Bz4HKE7BFs1FJ/GFAMOcKNGxbDn23wRQCXuQqOCOsh8eTY8sd3O99w7Pem9r2a9yeJXqKQnzLmDOD2BZrgqxe4SM/6yHCT7chL1wKS86+ZnvGfcvN3+YzqtSFw1C1XldAzjR5mBdM7ZClBi06xeRKGStDJTLWDR1UNUPNq1wvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763212898; c=relaxed/simple;
	bh=Pl9jmC5EL7AGwr+SmsgthHF9drWTTfIqBaIssfzsdWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA/6l7KHt9pWcHq0Oqs/BdMWur3vC9xj/k09Z9IhTh3rpKFcCHron3BEg1uhIqm+mmZaMqnNNvOA+/Sk9+76uNFUG221vH3xZefxizDjxBZXqEdNiCBSGxJcHv7UicDCoZBquymHtqrJeSSIYrlrY6PtbhNMqAxmEQ2YJipnCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AuInizII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C00C16AAE;
	Sat, 15 Nov 2025 13:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763212898;
	bh=Pl9jmC5EL7AGwr+SmsgthHF9drWTTfIqBaIssfzsdWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuInizIINMwBXTMJu1dR3seLB3VmALsUQ3+5Ndj4MXto6uH9ENTPXUU90Dt/8DjPq
	 gmWQkfEhamMufZT+G9MKX9xDtzSNmpoxmmi+AH6rv/rpdY47vOYkLaC2Ol/C4V7Kfc
	 vAlEaytoOD6Xr7/mBkMwSJH6iZ7zuxrbmPJUjTZw=
Date: Sat, 15 Nov 2025 08:21:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <2025111555-spoon-backslid-8d1f@gregkh>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114074614.GY2441659@ZenIV>

On Fri, Nov 14, 2025 at 07:46:14AM +0000, Al Viro wrote:
> On Thu, Nov 13, 2025 at 04:20:08PM -0500, Greg Kroah-Hartman wrote:
> 
> > Sorry for the delay.  Yes, we should be grabing the mutex in there, good
> > catch.  There's been more issues pointed out with the gadget code in the
> > past year or so as more people are starting to actually use it and
> > stress it more.  So if you have a patch for this, I'll gladly take it :)
> 
> How about the following?
> 
> commit 330837c8101578438f64cfaec3fb85521d668e56
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Fri Nov 14 02:18:22 2025 -0500
> 
>     functionfs: fix the open/removal races
>     
>     ffs_epfile_open() can race with removal, ending up with file->private_data
>     pointing to freed object.
>     
>     There is a total count of opened files on functionfs (both ep0 and
>     dynamic ones) and when it hits zero, dynamic files get removed.
>     Unfortunately, that removal can happen while another thread is
>     in ffs_epfile_open(), but has not incremented the count yet.
>     In that case open will succeed, leaving us with UAF on any subsequent
>     read() or write().
>     
>     The root cause is that ffs->opened is misused; atomic_dec_and_test() vs.
>     atomic_add_return() is not a good idea, when object remains visible all
>     along.
>     
>     To untangle that
>             * serialize openers on ffs->mutex (both for ep0 and for dynamic files)
>             * have dynamic ones use atomic_inc_not_zero() and fail if we had
>     zero ->opened; in that case the file we are opening is doomed.
>             * have the inodes of dynamic files marked on removal (from the
>     callback of simple_recursive_removal()) - clear ->i_private there.
>             * have open of dynamic ones verify they hadn't been already removed,
>     along with checking that state is FFS_ACTIVE.
>     
>     Fix another abuse of ->opened, while we are at it - it starts equal to 0,
>     is incremented on opens and decremented on ->release()... *and* decremented
>     (always from 0 to -1) in ->kill_sb().  Handling that case has no business
>     in ffs_data_closed() (or to ->opened); just have ffs_kill_sb() do what
>     ffs_data_closed() would in case of decrement to negative rather than
>     calling ffs_data_closed() there.
>     
>     And don't bother with bumping ffs->ref when opening a file - superblock
>     already holds the reference and it won't go away while there are any opened
>     files on the filesystem.
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Ugh, messy.  But yes, this does look better, thanks for that.  Want me
to take it through the USB tree, or will you take it through one of
yours? (I don't remember what started this thread...)

thanks,

greg k-h

