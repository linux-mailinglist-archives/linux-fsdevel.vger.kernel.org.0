Return-Path: <linux-fsdevel+bounces-17297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE08AB1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F04B21989
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB5130A61;
	Fri, 19 Apr 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPz+27OB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B812F5A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540616; cv=none; b=ILY1sT/11u+jUlkftEeMVBZYpZSbGtig5dzI8aKbyLgczgzGv205QqVbVWosTRZQR4zSWPYldPs6c1Z37EppwioBKytDwz1J7zy5cX1HgHsqHDKjtNDvAGUYRqRIE8oZSzbwx6Hg9Jaq7VuqG35C8X/d8Yc4VskGLH7XhZLLGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540616; c=relaxed/simple;
	bh=1afdnI6NyNf5xM7ma8Jr1IT8oH2e7iZKTqkLi1+jCmA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eMq+OC/1o0FKJK6XSyZWTS/3lFVK6J2wlLb8oukoo2ZGEkSP0q50nQTO5Mx0YG/eHG3GfLPXbAUJP1d3ilxV4+0csnNfGKUbv8rHd/SmoUB4VnU8i04sLYoHNkOa0x7kwwTq9rxlDusKClqdYAOwsTmtK86V+9OWzlJENwWRIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uPz+27OB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5naoPJHPx1l92bHP1PzZb5osu1Un8swjtejIY0HKoPo=; b=uPz+27OB5j46IHZaU31MRl++1I
	OOKnAcoq+GjB7d/RfyNiPKsvSv7buVRO1EHR9NfzU/6v7LsF6CW49JaCRrmucGmkvIMs/QTj5vqts
	7iQuphSmc6r7rkvjL0QEDUlVXzL9Hbx2BU4izhQw853gMc9VBMta8cK0VzeZ4F6DsqdOtYOHo+OYX
	BKuAhlV08xtGFNgu5xtLUL4iRDNSuptrkyziVmywRflvWfeVxqvmgagk52UsrCB/6SoLSpqSAIg5r
	S0/bAu2CD/ZESvy9QsfL+xgL/c8f99A7vO0yAdR+Ohw+d4C4h2lUq4QWBlrU7yA5lIVIvZxurBjSi
	yN5gytQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxqBm-00000007wN9-1MHc
	for linux-fsdevel@vger.kernel.org;
	Fri, 19 Apr 2024 15:30:10 +0000
Date: Fri, 19 Apr 2024 16:30:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: Returning more precise errors from read()
Message-ID: <ZiKOAj5TV44pKTeJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Today we throw away the actual error returned by the block device /
network protocol and transform it into an EIO return from read() [1].
There's no way today to send the error from the I/O completion routine
up to the VFS [2].  Is it worth doing?

For block devices, there's a fairly limited set of additional errors
that would apply to reads [3].

The important question in my mind is whether returning any of these
errors to userspace would confuse applications.  I suspect they would,
and returning anything other than EIO to userspace is just a bad idea.
But I'd like opinions before I pass up the opportunity to make this
improvement.

I'm not going to make this change without a reason because it would
impose some small costs on a few filesystems (notably any using iomap).

[1] For the curious, this happens in filemap_read_folio():

        error = filler(file, folio);
        if (error)
                return error;
        error = folio_wait_locked_killable(folio);
        if (error)
                return error;
        if (folio_test_uptodate(folio))
                return 0;
        return -EIO;

This looks like it can return a lot of different errors, but all real
filesystems will only return synchronous errors like -ENOMEM ("couldn't
allocate memory to submit request").  Any error from the block
device simply leaves the folio being left as !uptodate and we
return -EIO.

[2] I prototyped one once, but never got round to submitting it.  I'm in
the middle of converting a lot of filesystems, and it occurred to me
that a fairly small change to folio_end_read() would make this easier
to do in the future.

[3]
        [BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
        [BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
        [BLK_STS_TARGET]        = { -EREMOTEIO, "critical target" },
        [BLK_STS_MEDIUM]        = { -ENODATA,   "critical medium" },
        [BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
        [BLK_STS_RESOURCE]      = { -ENOMEM,    "kernel resource" },
        [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
        [BLK_STS_AGAIN]         = { -EAGAIN,    "nonblocking retry" },
        [BLK_STS_OFFLINE]       = { -ENODEV,    "device offline" },
        [BLK_STS_DURATION_LIMIT]        = { -ETIME, "duration limit exceeded" },


