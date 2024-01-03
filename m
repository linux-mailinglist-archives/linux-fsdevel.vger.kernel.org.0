Return-Path: <linux-fsdevel+bounces-7256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DD8235EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BC1287516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9901D528;
	Wed,  3 Jan 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUpU0ytY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DB1CF91;
	Wed,  3 Jan 2024 19:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C276C433C7;
	Wed,  3 Jan 2024 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704311578;
	bh=AGxGXJZa41oa0ZBFIkl3/sSNflvf5FcKlcCCl5qT46A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUpU0ytYwAjqQ9Kmu6iuW4yOWPjAEv6QR2Bm0uQMeNdd/7EGUhaAe9asYTlUN7ub+
	 o4cx/VBQ8P0kzZGCZ2AhPKrnIueuZPzE3UOQE7RqPsK/y3QQeIomvTSS4W7mdktl1T
	 KsOaldTfqSsZVbHpi+jSNgHE3ufTJgjHzAXZ8WNWD6AVoVPJtsdDn769V7KEwS3/Fb
	 8Em38nhwWOoz/WQ4LRIPYfErPlkuSsSJHvFYN+LNEN4cafX0e23octvhGxUkRVMlxs
	 M8kAkhKgKb/1ICpZk+vpfF7yWUYvKwun430g3axWj6wKZxYgv6IFkEkx9XNe9jzQg0
	 +6Ko/cnkkgb/Q==
Date: Wed, 3 Jan 2024 13:52:53 -0600
From: Eric Van Hensbergen <ericvh@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <ZZW7Fesoy4H2zic7@FV7GG9FTHL>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <ZZULNQAZ0n0WQv7p@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZULNQAZ0n0WQv7p@codewreck.org>

On Wed, Jan 03, 2024 at 04:22:29PM +0900, Dominique Martinet wrote:
> David Howells wrote on Thu, Dec 21, 2023 at 01:23:35PM +0000:
> 
> I've noticed we don't cache xattrs are all, so with the default mount
> options on a kernel built with 9P_FS_SECURITY we'll get a gazillion
> lookups for security.capabilities... But that's another problem, and
> this is still an improvement so no reason to hold back.
>

This is a big problem and already on my backlog list since some things
default to this even if the remote file system doesn't support
xattrs.  The quick fix is to disable on a mount when we detect the
host side isn't supporting them (of course this could be weird for
exports that cross file system boundries) -- at the very least we
could keep this info on an inode basis and not request as long as the
inode info is cached.  Caching the actual properties is also a step,
but given this is a security feature, I imagine we don't want to trust
our cache and will always have to ask server unless we can come up with
something clever to indicate xattr changes (haven't looked into that
much yet).
 
> 
> (I'd still be extremly thanksful if Christian and/or Eric would have
> time to check as well, but I won't push back to merging it this merge
> window next week if they don't have time... I'll also keep trying to run
> some more tests as time allows)
>

I'll try to run through my regression tests as well, but sure we
can fix things up after the merge window if we miss things.

    -eric


