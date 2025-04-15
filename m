Return-Path: <linux-fsdevel+bounces-46514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420CA8A774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E51161106
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255423D296;
	Tue, 15 Apr 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jB0Rttd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4423C8AE;
	Tue, 15 Apr 2025 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744109; cv=none; b=tSwj7wDM/fDrGpKcw+UGw9L1FDL4uGkY22aom19uzLjBLX1vDGnlNHJr5vPc9/iSnR7MSB9Z4qYySxgf2VSsB5kbsgxB+OdbEJ6+CgpNrXCFOWhQqFVOQZUnXuSjHHG+p5yfwuw1rLDUnGm1fJMRItII9tv5uTwxbG/bSPbTEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744109; c=relaxed/simple;
	bh=uQg0J23GmUp0Ec4YiSpIXFRZPvwUmduTRyP5990SQVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7ZsZpRi1Fm7ZOnLnffGfzqdm6qBpZYKaCOQ0m+31Ythkyf8xGNZbXRduLhWZJhj8oLeWtlAeN0akdiYLZSYzKjWd/aVCOgTHYSCVP2k7djdqtjAqw8cIMBM4TB43X0xQCJX04x9fcSfC91UdOW6Sbtwu/rB25UBurut+TZGecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jB0Rttd4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FCCLR5AQbfuKec16T4Z93Z+tygMuvFkccFhZdHp8QIQ=; b=jB0Rttd4vsFJvqMQ4UO+lemXYR
	w+edNdq8Xza6S/skam4hFAl4CXl1COOhZOqPqv0JgNlQQp68xLjgILf3FVz9EU28luEVwGjO6Lwfv
	lS5qlCNHqn9WMTjTlhRpmUqLCg9izRXOTMSBJIH6jeDStUwYDY1hzdpEpsc+8gYCLMW/mzcQ56CwL
	TcNf20XGOxylrY+pvzPG9Bc3BlSfxrchxsWvX1zmdVywn6D6awLMcNRs/a3d1mrjj8FXJ+Zx84xzq
	Nr08JdmdMw3ZcXZ3lMWfqDbtQG22MMGq14roEIL8zhj9Ov4Wn2MhHprTBE37/VsbV9YHPPPlIhtt2
	OcC4p97g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1u4ldN-0046eE-U3; Tue, 15 Apr 2025 19:07:50 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id ABFF8BE2DE0; Tue, 15 Apr 2025 21:07:48 +0200 (CEST)
Date: Tue, 15 Apr 2025 21:07:48 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Hillf Danton <hdanton@sina.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	Bernd Rinn <bb@rinn.ch>,
	Karri =?iso-8859-1?Q?H=E4m=E4l=E4inen?= <kh.bugreport@outlook.com>,
	Milan Broz <gmazyland@gmail.com>,
	Cameron Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
Subject: Re: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
Message-ID: <Z_6uhLQjJ7SSzI13@eldamar.lan>
References: <Z_6sh7Byddqdk1Z-@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_6sh7Byddqdk1Z-@eldamar.lan>
X-Debian-User: carnil

[resent with correct stable@vger.kernel.org list]

On Tue, Apr 15, 2025 at 08:59:19PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> [Apologies if this has been reported already but I have not found an
> already filled corresponding report]
> 
> After updating from the 6.1.129 based version to 6.1.133, various
> users have reported that their VMs do not boot anymore up (both KVM
> and under Xen) if pci-passthrough is involved. The reports are at:
> 
> https://bugs.debian.org/1102889
> https://bugs.debian.org/1102914
> https://bugs.debian.org/1103153
> 
> Milan Broz bisected the issues and found that the commit introducing
> the problems can be tracked down to backport of c8070b787519 ("mm:
> Don't pin ZERO_PAGE in pin_user_pages()") from 6.5-rc1 which got
> backported as 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in
> pin_user_pages()") in 6.1.130. See https://bugs.debian.org/1102914#60
> 
> #regzbot introduced: 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> 
> 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774 is the first bad commit
> commit 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri May 26 22:41:40 2023 +0100
> 
>     mm: Don't pin ZERO_PAGE in pin_user_pages()
> 
>     [ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]
> 
>     Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
>     to it from the page tables and make unpin_user_page*() correspondingly
>     ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
>     zero page's refcount as we're only allowed ~2 million pins on it -
>     something that userspace can conceivably trigger.
> 
>     Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.
> 
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Christoph Hellwig <hch@infradead.org>
>     cc: David Hildenbrand <david@redhat.com>
>     cc: Lorenzo Stoakes <lstoakes@gmail.com>
>     cc: Andrew Morton <akpm@linux-foundation.org>
>     cc: Jens Axboe <axboe@kernel.dk>
>     cc: Al Viro <viro@zeniv.linux.org.uk>
>     cc: Matthew Wilcox <willy@infradead.org>
>     cc: Jan Kara <jack@suse.cz>
>     cc: Jeff Layton <jlayton@kernel.org>
>     cc: Jason Gunthorpe <jgg@nvidia.com>
>     cc: Logan Gunthorpe <logang@deltatee.com>
>     cc: Hillf Danton <hdanton@sina.com>
>     cc: Christian Brauner <brauner@kernel.org>
>     cc: Linus Torvalds <torvalds@linux-foundation.org>
>     cc: linux-fsdevel@vger.kernel.org
>     cc: linux-block@vger.kernel.org
>     cc: linux-kernel@vger.kernel.org
>     cc: linux-mm@kvack.org
>     Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Acked-by: David Hildenbrand <david@redhat.com>
>     Link: https://lore.kernel.org/r/20230526214142.958751-2-dhowells@redhat.com
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>     Stable-dep-of: bddf10d26e6e ("uprobes: Reject the shared zeropage in uprobe_write_opcode()")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
>  Documentation/core-api/pin_user_pages.rst |  6 ++++++
>  include/linux/mm.h                        | 26 ++++++++++++++++++++++++--
>  mm/gup.c                                  | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 60 insertions(+), 3 deletions(-)
> 
> Milan verified that the issue persists in 6.1.134 so far and the patch
> itself cannot be just reverted.
> 
> The failures all have a similar pattern, when pci-passthrough is used
> for a pci devide, for instance under qemu the bootup will fail with:
> 
> qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: VFIO_MAP_DMA failed: Cannot allocate memory
> qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: vfio 0000:03:00.0: failed to setup container
> 
> (in the case as reported by Milan).
> 
> Any ideas here?
> 
> Regards,
> Salvatore

