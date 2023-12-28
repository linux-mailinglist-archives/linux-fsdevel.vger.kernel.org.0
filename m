Return-Path: <linux-fsdevel+bounces-7007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8281FA24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E151C232DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99B10A1F;
	Thu, 28 Dec 2023 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWpAGoY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC210A09;
	Thu, 28 Dec 2023 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9499CC433C9;
	Thu, 28 Dec 2023 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703782714;
	bh=LtB9LsZRFoK2mRick0kUYbdhu9aPS6cGfKbd+Bt8FtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWpAGoY88Go6sFhC5oHMizbI6XpsDbe3P9/irSiWfwoLQGwfrrdzSswLuoybnRUFT
	 Y+XqOp9YWoQsYRrr6bvMkd8mxSERkT48kgdNRqDjCUUttR5Q3H3U0h6pPQweVEORBc
	 I8WSnOqHV1rhNFbW5BbgKKPNaTH+Ac5AbrB8xN5rrfXe+tCgqQs5Rp1ezx8NBaLOU2
	 N34MiXPPv82Oc2WqM4yvpi5XSNSYcpVl0ehK6ySaDLDFWybSeNgF8bZuALCNNz0wJQ
	 6D8Um8C0blfpXdkHQK5vaSPd/HhcXAfTjTliP0Y6lp9eN5VXRU/sim+RtVXRhf+tQ6
	 UVcz4gfMLuMIw==
Date: Thu, 28 Dec 2023 09:58:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 15/40] netfs: Add support for DIO buffering
Message-ID: <20231228165831.GA348702@dev-arch.thelio-3990X>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-16-dhowells@redhat.com>
 <20231226165442.GA1202197@dev-arch.thelio-3990X>
 <20231228-wohlbefinden-museen-c5efad4e0d84@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228-wohlbefinden-museen-c5efad4e0d84@brauner>

On Thu, Dec 28, 2023 at 11:47:45AM +0100, Christian Brauner wrote:
> > This will break the build with versions of clang that have support for
> > counted_by (as it has been reverted in main but reapplication to main is
> > being actively worked on) because while annotating pointers with this
> > attribute is a goal of the counted_by attribute, it is not ready yet.
> > Please consider removing this and adding a TODO to annotate it when
> > support is available.
> 
> It's really unpleasant that we keep getting new attributes that we
> seemingly are encouraged to use and get sent patches for it. And then we
> learn a little later that that stuff isn't ready yet. It's annoying. I

I will assume the "get sent patches for it" is referring to the patches
that Kees has been sending out to add this attribute to flexible array
members. In his defense, that part of the attribute is very nearly ready
(it is only the pointer annotations that are not ready, as in not worked
on at all as far as I am aware). In fact, it was merged in clang's main
branch for some time and the only reason that it was backed out was
because adoption in the kernel had pointed out bugs in the original
implementation that were harder to fix than initially thought; in other
words, only because we started adding this attribute to the kernel were
we able to realize that the initial implementation in clang needed to be
improved, otherwise this feature may have shipped completely broken in
clang 18.1.0 because it had not been stress tested yet. Now we can get
it right.

However, I do not necessarily disagree that it is annoying for
maintainers who are not following this saga but are just receiving
patches to add these annotatations because adds additional things to
check for. Perhaps there should be some guidance added to the
__counted_by definition or Documentation around how it is expected to be
used so that there is clear advice for both developers and maintainers?

> know it isn't your fault but it would be wise to be a little more
> careful. IOW, unless both clang and gcc do support that thing
> appropriately don't send patches to various subsystems for this.

I will assume this was not necessarily directed at me because I have not
sent any patches for __counted_by.

> In any case, this is now fixed. I pulled an updated version from David.

Thanks a lot.

Cheers,
Nathan

