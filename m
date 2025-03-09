Return-Path: <linux-fsdevel+bounces-43542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C325A583E1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 13:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DBF16BBA9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB91CD208;
	Sun,  9 Mar 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMN3iFTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7992B9A4;
	Sun,  9 Mar 2025 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741521820; cv=none; b=bRJLPMyRNJH4gQsRPkNSttKdVHXLgWPoPVMwFiWaK0Cj265HRTNdVlMdkuN/Hmsyx4SaDmDtLPD2+B+zo4gviREExT4wIzy1W2DYSDMQ+ucRT8iTj5NVyqsLzaRcrhDr977YVK3GA8nljJsSYMYhG8kKiOfTmCngueqHWcW/Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741521820; c=relaxed/simple;
	bh=x8LiHcCv8DTXMAg2ZcZKR2faXOH9UvWMVP3REFZJBHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHcBvJ55IeVY307lBCvRxeOIAnn5y9ZBA9yW6BuPGRGBQ5AoF85YXJrjjX8A3tT1GlAjUrOBefMtwI/yj6PzWkgfGeybU/4BM3VH67OJABHLlg/qrE4gF4Z3k8vXRHcj79mhaLMNktrnAzZQDq9drTtiElr9vwt3gQK2IPYnBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMN3iFTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0CFC4CEE5;
	Sun,  9 Mar 2025 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741521819;
	bh=x8LiHcCv8DTXMAg2ZcZKR2faXOH9UvWMVP3REFZJBHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMN3iFTtKavUVNDKnRfSBedIJcy4ZJzQvZLr7uIufEVSHRR1ZoxrNAVbq+N4I0AJS
	 MXWAqypAHyLu860XVaJ9HolV8bZebhOJR3DbWWOm2oPMsyLPvLuQzsHyq77WGGuG0K
	 1TPUvSi00ykZ8CVUwsHaOKsMdvAo4cJCuwdMm3RKY/mD93O6zHbbuwexP7zSEcMgfQ
	 T/WNkljDQHub56fTSTgfgdeTuVBWsJTtpIMXYaSNUEXorrN4EoW7rddkjRCQiiOvW2
	 5XnXS/MkyFfmAZRpFp7smfbHx2AhYYnYVyfQkZc3iSsuM9rqumwc+7edu1yVDhSyXv
	 ruUNUCYoPgzhQ==
Date: Sun, 9 Mar 2025 13:03:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Eric Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Alexander Graf <graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	David Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mafs0ikokidqz.fsf@amazon.de>

On Sat, Mar 08, 2025 at 12:10:12AM +0000, Pratyush Yadav wrote:
> Hi Christian,
> 
> Thanks for the review!

No worries, I'm not trying to be polemic. It's just that this whole
proposed concept is pretty lightweight in terms of thinking about
possible implications.

> > This use-case is covered with systemd's fdstore and it's available to
> > unprivileged userspace. Stashing arbitrary file descriptors in the
> > kernel in this way isn't a good idea.
> 
> For one, it can't be arbitrary FDs, but only explicitly enabled ones.
> Beyond that, while not intended, there is no way to stop userspace from
> using it as a stash. Stashing FDs is a needed operation for this to
> work, and there is no way to guarantee in advance that userspace will
> actually use it for KHO, and not just stash it to grab back later.

As written it can't ever function as a generic file descriptor store.

It only allows fully privileged processes to stash file descriptors.
Which makes it useless for generic userspace. A generic fdstore should
have a model that makes it usable unprivileged it probably should also
be multi-instance and work easily with namespaces. This doesn't and
hitching it on devtmpfs and character devices is guaranteed to not work
well with such use-cases.

It also has big time security issues and implications. Any file you
stash in there will have the credentials of the opener attached to it.
So if someone stashes anything in there you need permission mechanisms
that ensures that Joe Random can't via FDBOX_GET_FD pull out a file for
e.g., someone else's cgroup and happily migrate processses under the
openers credentials or mess around some random executing binary.

So you need a model of who is allowed to pull out what file descriptors
from a file descriptor stash. What are the semantics for that? What's
the security model for that? What are possible corner cases?

For systemd's userspace fstore that's covered by policy it can implement
quite easily what fds it accepts. For the kernel it's a lot more
complicated.

If someone puts in file descriptors for a bunch of files in there opened
in different mount namespaces then this will pin said mount namespaces.
If the last process in the mount namespace exists the mount namespace
would be cleaned up but not anymore. The mount namespace would stay
pinned. Not wrong, but needs to be spelled out what the implications of
this are.

What if someone puts a file descriptor from devtmpfs or for /dev/fdbox
into an fdbox? Even if that's blocked, what happens if someone creates a
detached bind-mount of a /dev/fdbox mount and mounts it into a different
mount namespace and then puts a file descriptor for that mount namespace
into the fdbox? Tons of other scenarios come to mind. Ignoring when
networking is brought into the mix as well.

It's not done by just letting the kernel stash some files and getting
them out later somehow and then see whether it's somehow useful in the
future for other stuff. A generic globally usable fdstore is not
happening without a clear and detailed analysis what the semantics are
going to be.

So either that work is done right from the start or that stashing files
goes out the window and instead that KHO part is implemented in a way
where during a KHO dump relevant userspace is notified that they must
now serialize their state into the serialization stash. And no files are
actually kept in there at all.

