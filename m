Return-Path: <linux-fsdevel+bounces-3020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183457EF55C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495111C20A9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958C3716A;
	Fri, 17 Nov 2023 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLzzsdqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E4FD57;
	Fri, 17 Nov 2023 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=boK1g/wlcRfqnhBSwMlsoqMRBha4bmvpNAIlXluQeOs=; b=XLzzsdqVXe9eQlGxKKQl9nLRPb
	m+r3lAsRuV8S35WJhL8pwyw68l2QAOmenbZSC7KyjjNME4oEY5ha2PLlfxzcc0HJw7H4FaQspJns5
	u5sO61DRjxVFbuL3DFOcvGxOzQi3vXg0A1VmFudM/NJDZ2TblYTyH39jK7kKzNva7LRkQ19GGg5RY
	/je1NotVTVi/2ubKBEJFaLCQg5VBSL1TFFCQFi76vb9oT3Br6sw55Xg9eF5e4+778ACdwdyTdPhJt
	8NRThge5VGJ1thA4z3Kh74ZLTzCW4K/qxmJa9pIAHX0cuGUIksmRxeCC7v8Pw+vQsSEoF3JfQ5SzI
	hFbsSCEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r40uR-00AC3i-04; Fri, 17 Nov 2023 15:37:31 +0000
Date: Fri, 17 Nov 2023 15:37:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/15] Many folio conversions for ceph
Message-ID: <ZVeIuiixrBypiXjp@casper.infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>

On Fri, Aug 25, 2023 at 09:12:10PM +0100, Matthew Wilcox (Oracle) wrote:
> I know David is working to make ceph large-folio-aware from the bottom up.
> Here's my attempt at making the top (ie the part of ceph that interacts
> with the page cache) folio-aware.  Mostly this is just phasing out use
> of struct page in favour of struct folio and using the new APIs.
> 
> The fscrypt interaction still needs a bit of work, but it should be a
> little easier now.  There's still some weirdness in how ceph interacts
> with the page cache; for example it holds folios locked while doing
> writeback instead of dropping the folio lock after setting the writeback
> flag.  I'm not sure why it does that, but I don't want to try fixing that
> as part of this series.
> 
> I don't have a ceph setup, so these patches are only compile tested.
> I really want to be rid of some compat code, and cecph is sometimes the
> last user (or really close to being the last user).

Any progress on merging these?  It's making other patches I'm working on
more difficult to have these patches outstanding.

