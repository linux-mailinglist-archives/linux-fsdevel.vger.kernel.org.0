Return-Path: <linux-fsdevel+bounces-24934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0A1946C16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 05:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5401C20CB8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E07494;
	Sun,  4 Aug 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pc606dv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C5184F
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722743264; cv=none; b=W6PEu77cZ8IlCY/Yl5i9nOzOmQULVwP/Wr9HxIpZ8NImPN+sje6dUxGpm4BJrzJmk7TT4uYkEIzff8QVYK7aErf5Kzsq856xWC721daD9/4BQ+MJ1edInqv04hoQNC7DEhfL8CjDnm9j4wFDfQafaJeouPIDvzVf2SbMCXvfQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722743264; c=relaxed/simple;
	bh=S57QKmK+jBBLUhIvFG2kKZLDg6FDBo44nRiwx5TC1JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcOC3KwlSlV5M+9kW1uU9hm+4HbT0ErVlbgy5QrN4FAQIAYJh9jPajhVzPsIAv/e3e7FYuvVlMjYawnIDZyRy9kGHJYX02vGyfOv1HaUS3ONsEhH1oY4LBeTA+MMb7YCjpmH++HBwm7cfQ4HtfNs5wtOvxcNlg30fVp55B22nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pc606dv/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nSfK/DUNvEbHTo4qb1ASy6dIrYfzMzLuT/K0YNjtGas=; b=pc606dv/4YqLuIFjl79RXQtKo3
	6O7LEWZNUunSV3rqJzv12sTrd6HIqLKv6Gk2veLiitEM8RkNiFP18t7wFmllb/rTkDrZIBeqVwRLp
	aGOIrmFZ0SF4vdwh6SFwBul8v43LMsukH2tknbhOpy6VhjonJixk6NI+fBcqfdZh5kFAnan0LTtAC
	0Dx8z/B7VqGAtbS8dzhyK2JYkcuVRp9OdaRMg07R31cROfpqd/h1cHykdEtkNIhZy/7LEOzRZz0wf
	jCoPBs/nMa/8bHpLn4ZNzoxVsVvctHT+SoBxgSRiSyhHVa2ElUq3bxSClGLQ/lshTefv+GnUQKdDR
	vy46JyXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saSDb-00000001SbZ-3Blk;
	Sun, 04 Aug 2024 03:47:39 +0000
Date: Sun, 4 Aug 2024 04:47:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240804034739.GB5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804003405.GA5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 04, 2024 at 01:34:05AM +0100, Al Viro wrote:

> static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
>                             unsigned int count, unsigned int size)
> {
> 	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
> 				count, size);
> 	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
> 				count, size);
> 	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
> 				count / BITS_PER_LONG, size / BITS_PER_LONG);
> }

One variant would be

#define fdt_words(fdt)	((fdt)->max_fds / BITS_PER_LONG) /* longs in fdt->open_fds[] */

static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
                            unsigned int copy_words)
{
	unsigned int nwords = fdt_words(nfdt);

	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
			copy_words, nwords);
}
with callers being
        copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
and
        copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);

resp.  That would compile into pure memcpy()+memset() for the main bitmaps
and at least as good as bitmap_copy()+bitmap_clear() for full_fds_bits...

