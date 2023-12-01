Return-Path: <linux-fsdevel+bounces-4575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0CF800D48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00771C2095E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6CA3E478
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0m9sutm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9443913E;
	Fri,  1 Dec 2023 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BXafAH8BWhpG1fug+rYpt7+DF2WwHDSy3uyXtRATKBk=; b=r0m9sutmr5xmt6az4XdA/s9puy
	39xESoVJx9QhEJZHFTVdpltFC2CUtssZRepC6G0/fP0pUgM/lnsMsM4v2xhTQYVSLRPsAeNiXHqfi
	vmq0ipcVerKP7IssioLADTR1Lsh9pAzdQ+cBtUS1XSK/9wqqNJ6nUh66OL1V407hB9mHGN1IuNJ3P
	Pm0d1kXhp9sg4rrgz9S4ORZdFZCSCTFHcoU0gJSoBLU+/D+hjHv7d8oiiplH6Srz8ACkFI7h7/5pa
	dq7uNxx9yF08s3gl+3kpO3+Xbc1Xw5m3OBMeW0hIroetRwD7oTdX5wc1PxAOnXaqqkIrnL0qjK+w2
	feN+UV6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r93YV-00FY5Z-Kf; Fri, 01 Dec 2023 13:27:43 +0000
Date: Fri, 1 Dec 2023 13:27:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Message-ID: <ZWnfT1+afsZ9JaZP@casper.infradead.org>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>

On Fri, Dec 01, 2023 at 10:42:57AM +0000, John Garry wrote:
> Sure, and I think that we need a better story for supporting buffered IO for
> atomic writes.
> 
> Currently we have:
> - man pages tell us RWF_ATOMIC is only supported for direct IO
> - statx gives atomic write unit min/max, not explicitly telling us it's for
> direct IO
> - RWF_ATOMIC is ignored for !O_DIRECT
> 
> So I am thinking of expanding statx support to enable querying of atomic
> write capabilities for buffered IO and direct IO separately.

Or ... we could support RWF_ATOMIC in the page cache?

I haven't particularly been following the atomic writes patchset, but
for filesystems which support large folios, we now create large folios
in the write path.  I see four problems to solve:

1. We might already have a smaller folio in the page cache from an
   earlier access,  We'd have to kick it out before creating a new folio
   that is the appropriate size.

2. We currently believe it's always OK to fall back to allocating smaller
   folios if memory allocation fails.  We'd need to change that policy
   (which we need to modify anyway for the bs>PS support).

3. We need to somewhere keep the information that writeback of this
   folio has to use the atomic commands.  Maybe it becomes a per-inode
   flag so that all writeback from this inode now uses the atomic
   commands?

4. If somebody does a weird thing like truncate/holepunch into the
   middle of the folio, we need to define what we do.  It's conceptually
   a bizarre thing to do, so I can't see any user actually wanting to
   do that ... but we need to define the semantics.

Maybe there are things I haven't thought of.  And of course, some
filesystems don't support large folios yet.

