Return-Path: <linux-fsdevel+bounces-49828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBEEAC36E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F911893946
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672D1A23A9;
	Sun, 25 May 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ng/K8Epa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E091A275
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748207092; cv=none; b=qQGSfxypprWeINaqPc5eyv+jYRqMZ4/uoXkdE5g3igJ90OQMcyL786HDxNBbt8l3qYPtOA/P1J1bLj8B2gg0awERRkcAT/f7sBy1KMmKn9+Twl2B6fBtv+5SC8gHq2oJvLhro0nJgKAqlZVh9DKltxuRwzqtyQReqH0nrMOGxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748207092; c=relaxed/simple;
	bh=zmQ3WCjpTsWrsPxh4xNRvQUrAO34Wx+6nQsD5BF4z58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx7qT6tkwFHu3HoRSTV21cEKkDhLyyUdiZY+pPRrWImeiEbZT0fLnJ4i1QEj3Ep189V+SBYFkzLLcv98EV5DAPufCH1umVJxZW0PQ1+eZ7MaXqYeffQurr2/pf8inX2bCMPRmSGcaeN2ZsPHhddxh7VhRhPiH2FNP6QsmGpnIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ng/K8Epa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P1fuEwoxkkM7SCcIlBX1c+jTmdrHnGY4pQmlLxU0N2c=; b=Ng/K8EpaU4CnT9lXUNszS9qI3V
	IP+JV9MVE+VM1E9dpcqSvHn1/cfKlnMUXN0sdnbi4QPxcvpe9eBXanvrSd87LlVpQSn1w2JWg5VBv
	ARFGEislZyf0mV5kjThcPt7VESffJYeBGScHiImuwp0wrkAs1rGYuL9pSf9HB8mrdGr6xXDsSB/3K
	aniePNrWv3zbKrdSW+abmMnHTrAXHl67UnKem4UiHnWdl/O1xhaKxHAWKHkXE7ijsproHswRPx/Ue
	uwwFDP/BekOBY9FvxR/yGk87L/Az3LZbabFClG2E5fIlYhOONXCSF4foRi8j0TgNt8XRXzA+Xx4Z7
	g76r1dbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJIGz-0000000AclD-11v2;
	Sun, 25 May 2025 20:48:45 +0000
Date: Sun, 25 May 2025 21:48:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <aDOCLQTaYqYIvtxb@casper.infradead.org>
References: <20250525083209.GS2023217@ZenIV>
 <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>

On Sun, May 25, 2025 at 01:32:33PM -0700, Linus Torvalds wrote:
> But yeah, maybe the drop-behind case never triggers in practice, and I
> should just revert commit 974c5e6139db ("xfs: flag as supporting
> FOP_DONTCACHE") for now.
> 
> That's kind of sad too, but at least that's new to 6.15 and we
> wouldn't have a kernel release that triggers this issue.
> 
> I realize that Vlastimil had a suggested possible fix, but doing
> _that_ kind of surgery at this point in the release isn't an option,
> I'm afraid. And delaying 6.15 for this also seems a bit excessive - if
> it turns out to be easy to fix, we can always just backport the fix
> and undo the revert.
> 
> Sounds like a plan?
> 
> I'm somewhat surprised that this was only noticed now if it triggers
> so easily for Al with xfstests on xfs. But better late than never, I
> guess..

I wonder if we shouldn't do ...

+++ b/include/linux/fs.h
@@ -3725,6 +3725,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
                        return -EOPNOTSUPP;
        }
        if (flags & RWF_DONTCACHE) {
+               /* Houston, we have a problem */
+               return -EOPNOTSUPP;
                /* file system must support it */
                if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
                        return -EOPNOTSUPP;

in case some other filesystem adds support for it?  I don't see anything
in -next right now, but I see Darrick playing with it here for FUSE:
https://lore.kernel.org/all/174787195629.1483178.7917092102987513364.stgit@frogsfrogsfrogs/
Jeff playing with it for nfsd here:
https://lore.kernel.org/all/370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org/
Trond implementing it for NFS client here:
https://lore.kernel.org/all/cover.1745381692.git.trond.myklebust@hammerspace.com/

I thought I saw someone implement it for ext4, but perhaps I'm confused
with something else.  Anyway, some kind of not-xfs-specific patch is
appropriate here, I think?

Oh, and we're only just seeing it, I think, because you need to recompile
xfstests to test this functionality ... and I certainly don't re-pull
and re-compile xfstests on a regular basis; I just use the one I pulled
and compiled, um, months ago.

