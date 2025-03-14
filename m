Return-Path: <linux-fsdevel+bounces-44029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28090A61597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 17:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5213917F36E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D57200BBE;
	Fri, 14 Mar 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qn+0QgCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A3F510
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968052; cv=none; b=LhCoM8wfn7GXuPzQJ9CdhmCh9XJO887A87le6wijZHGLzez9G5+AcPVMsvhJLIB5hkGWBBOc2n0iORZ8tB8UjwvwxeIdcWZgnIg3+mWrVobwO2gPh/+d4+3i5q4VSjsUGYIX+DOjU6pU+8rY3YfLgHq/S2hsX0SvkhPmrFnwq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968052; c=relaxed/simple;
	bh=SAaslc3jmMWJHSveMAddLjA9cKCxSzkSIl21kc5XixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+0XLPmloSODnVXPSeIwaCeb+LGcA9Mk4RZpspJQsUDR/6Mwhc1L1d/3PsIjcqKeWorRnaO37wqXcbeCcckprbXtcwYZuO2s+4/65o5LhU3qLTNlr++I//1nJtqP8N44po6gRpQhaODmTSz7bTOkaDKHiz6AjoSj258b5WhRQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qn+0QgCA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C0yYClMn1+x43vPQYH6dJTU2IcS5SituW9z569SSHiw=; b=qn+0QgCAIUlOoSppaJolf+Pkup
	usBjsQ3GvMp19wz8LDTYZikllk+A4C1L7UMmAfXH0YdHKlFd35aU93LrtVQbVT2SowH4UoOCKllUp
	xq8UpFKffgvcVmEVGe+tx8iuYEIjD0A/SQYcgi20Dd1UGj/XlrTLD1chu48VYLJFKRZ6OMbBhPsCe
	Qxtu6q2Tgl4lxLmLIFKRmMORGX5j2vWg2mV/QCIXSJaSsPMKvN4y13KHJYEx0UPZ6R/0bvx9Oom3g
	1KLLLd4AUxZr7tN4ZKbt3zX7FclJPY5WMmkesGlHpkcHtYnBfZDp8SotwD4fnOkBTOzAMPNC4TEDE
	VeYQHyKg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt7PO-00000002jck-2MIq;
	Fri, 14 Mar 2025 15:58:55 +0000
Date: Fri, 14 Mar 2025 15:57:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z9RR2ubkS9CafUdE@casper.infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
 <Z9Dh4UL7uTm3cQM3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Dh4UL7uTm3cQM3@google.com>

On Wed, Mar 12, 2025 at 01:22:41AM +0000, Jaegeuk Kim wrote:
> On 03/12, Matthew Wilcox wrote:
> > On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > > Hello:
> > > 
> > > This series was applied to jaegeuk/f2fs.git (dev)
> > > by Jaegeuk Kim <jaegeuk@kernel.org>:
> > 
> > Thanks!
> > 
> > FWIW, I have a tree with 75 patches in it on top of this that do more
> > folio conversion work.  It's not done yet; maybe another 200 patches to
> > go?  I don't think it's worth posting at this point in the cycle, so
> > I'll wait until -rc1 to post, by which point it'll probably be much
> > larger.
> 
> Ok, thanks for the work! Will keep an eye on.

Unfortunately, I thnk I have to abandon this effort.  It's only going
to make supporting large folios harder (ie there would then need to be
an equivalently disruptive series adding support for large folios).

The fundamental problem is that f2fs has no concept of block size !=
PAGE_SIZE.  So if you create a filesystem on a 4kB PAGE_SIZE kernel,
you can't mount it on a 16kB PAGE_SIZE kernel.  An example:

int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
{
        struct f2fs_inode *ri;
        ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
        ri = F2FS_INODE(page);

so an inode number is an index into the filesystem in PAGE_SIZE units,
not in filesystem block size units.  Fixing this is a major effort, and
I lack the confidence in my abilities to do it without breaking anything.

As an outline of what needs to happen, I think that rather than passing
around so many struct page pointers, we should be passing around either
folio + offset, or we should be passing around struct f2fs_inode pointers.
My preference is for the latter.  We can always convert back to the
folio containing the inode if we need to (eg to mark it dirty) and it
adds some typesafety by ensuring that we're passing around pointers that
we believe belong to an inode and not, say, a struct page which happens
to contain a directory entry.

This is a monster task, I think.  I'm going to have to disable f2fs
from testing with split page/folio.  This is going to be a big problem
for Android.


