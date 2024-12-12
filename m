Return-Path: <linux-fsdevel+bounces-37127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBECE9EDEFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB64283CEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B317C7C4;
	Thu, 12 Dec 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bSIRTOBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F81714A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981879; cv=none; b=XIRESQdoaDfBgBrvRUcduXgqPJu56iYqPuJ5kERTaAQWi3Si9NobaqcdPAlZ5H5JAQD2FkK8p14XdqZUA5+QFJ2XcxwKspgiSpMYyeFAo99IZwYG/kuURhGGT/WYlCp4rnS/qfNJRD0SBRpR9/rm+e1U671q24ofYGbJkZF2A6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981879; c=relaxed/simple;
	bh=Q39Mrur689JYVEMGO5/GiBx/SpdZLP027ya2Y5McG1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPyyEMrM4AbJfzmvXUIqHGSEk560warx/KG/wklI5SVnJG0Wx+9MdolEF+oyvIpDQA/I+3M71UfFdMCsqq71LPXQ3is4mMNUsq6OSzk/BaIrbd6B9SJ9lzdsW5vV5qcL93H7ixDZ7WC37RZw/J3pkjXiHDlzGzaTQYJ/qXT7gS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bSIRTOBG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-3.bstnma.fios.verizon.net [173.48.102.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BC5bd1k029739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733981863; bh=6yul3k8VrHuDp5kOnM04awhRjfFN4A+g/yc8izL3+5A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bSIRTOBG+dGzDRt4rgkhDIs9gcgaTa5B4sFE/1Ml6Q+4SSlaCsX3vvpNQT33AeZgo
	 gvh44ZHhzA6bflcychg80d68KXRwvIR3ST2ZWxAgHjf4povnGVvKO/W87bXHTcSkdF
	 j7agBtILOKvXEkW9y2VX/JnN6fMgnxbllta0dhQbhfAGcfxgjv+wxkZa2BQUtUnelv
	 Cnrf3muz1rDY/x5GZ9Fq+GQ4ybynCq7VkjXIEzKi6sBe9pfiKoCYX7LmhuuWnKAAPn
	 B/X8sF81veHI9LkNwxHBuUfLYUZ0QiY69Fh9LvWPM+eX916N3bQ/h6/z6xBYY8eFLw
	 Dj2Rif0wfCgFQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 25FB915C028A; Thu, 12 Dec 2024 00:37:39 -0500 (EST)
Date: Thu, 12 Dec 2024 00:37:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        caiqingfu <baicaiaichibaicai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212053739.GC1265540@mit.edu>
References: <20241212035826.GH2091455@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212035826.GH2091455@google.com>

On Thu, Dec 12, 2024 at 12:58:26PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> We've got two reports [1] [2] (could be the same person) which
> suggest that ext4 may change page content while the page is under
> write().  The particular problem here the case when ext4 is on
> the zram device.  zram compresses every page written to it, so if
> the page content can be modified concurrently with zram's compression
> then we can't really use zram with ext4.
> 
> Can you take a look please?
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219548
> [2] https://lore.kernel.org/linux-kernel/20241129115735.136033-1-baicaiaichibaicai@gmail.com

The link in [2] is a bit busted, since the message in question wasn't
cc'ed to LKML, but rather to mm-commits.  But dropping "/linux-kernel"
allows the link to work, and what's interesting is this message from
that thread:

https://lore.kernel.org/all/20241202060632.139067-1-baicaiaichibaicai@gmail.com/

The blocks which are getting modified while a write is in flight are
ext4 metadata blocks, which are in the buffer cache.  Ext4 is
modifying those blocks via bh->b_data, and ext4 isn't issuing the
write; those are happenig via the buffer cache's writeback functions.

Hmmm.... was the user using an ext4 file system with the journal
disabled, by any chance?  If ext4 is using the journal (which is the
common case), metadata blocks only get modified via jbd2 journal
functions, and a blocks only get modified when they are part of a jbd2
transaction --- and while the transaction is active, the buffer cache
writeback is disabled.  It's only after the transaction is committed
that are dirty blocks associated with that transaction are allowed to
be written back.  So I *think* the only way we could run into problems
is ext4's jbd2 journalling is disabled.

More generally, any file system which uses the buffer cache, and
doesn't use jbd2 to control when writeback happens, I think is going
to be at risk with a block device which requires stable writes.  The
only way to fix this, really, is to have the buffer cache code copy
the data to a bounce buffer, and then issue the write from the bounce
buffer.

						- Ted



