Return-Path: <linux-fsdevel+bounces-5625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6763380E508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF281F21A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD61772D;
	Tue, 12 Dec 2023 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2uTqN/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78EAB;
	Mon, 11 Dec 2023 23:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=J6zaba+ZbspiAFr2rLoUw0Ptxv3sCznX+1rQk4lFRlc=; b=Q2uTqN/MG8AV+qJ/pcL6OklThn
	w8Uyb/NKu9NzWDuS+QvzadqyZ3oENcv0mFAJDt27kI6CFb1Li2Irfbs/GGyLbUC6sg7HkfsG9OCbo
	eWNYx7ei6T9Bk4vAGAkAR8jG3ErhjKZ8o1o81LXnPWWsar2b+mZKqEPRjghnkNmlADH/f9Np3fIt5
	qOf/sIQgfpKohW0GSK7V7aMbNWebHxu/cm7SKgdFsgBmMwItMjb6S7Y6Y6ydPy4hQQIcEDJq6q53b
	xPn/4J58MXAH/A+/veg2daBAnDFRiPHJ/P1ggPlgmihi084se87qDkuv46oCIH307vxuq3V49C9hf
	20CIIhFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCxTV-00AxFB-1n;
	Tue, 12 Dec 2023 07:46:41 +0000
Date: Mon, 11 Dec 2023 23:46:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZXgP4bR3DUhg2i54@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <3130123.1687863182@warthog.procyon.org.uk>
 <ZJyKef22444mooNE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJyKef22444mooNE@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 28, 2023 at 08:31:05PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 11:53:02AM +0100, David Howells wrote:
> > Do you have this on a branch somewhere?
> 
> I just pushed it out to https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/writeback-iter
> 
> Running it through xfstests now.  This includes one of Christoph's
> suggestions, a build fix for Linus's tree, and a bugfix I noticed last
> night, so it's not quite the same as the emails that were sent out in
> this thread.  I doubt it'll be what I send out for v2 either.

So it turns out thіs version still applies fine and tests fine with
latest mainline.

I've put up a slight tweak here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/writeback-iter

this moves and documents the new fields in struct writeback_control
and drops the iomap patch for now as it has conflicts in the VFS tree
in this merge window.

Do you want me to send this version out, or do you want to take over or
is there a good reason not to progress with it?

