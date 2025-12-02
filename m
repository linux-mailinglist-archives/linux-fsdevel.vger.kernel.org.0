Return-Path: <linux-fsdevel+bounces-70444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCDC9AFB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808DF3A2DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44D30FF23;
	Tue,  2 Dec 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5X5VTUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2730FC29;
	Tue,  2 Dec 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668992; cv=none; b=g3fyFQwzcuYcYK9zLyqyAer4wev6XgrXOsz1q0Li6FoVq0bqRcsPHIIHzwf9MeTQWch3qLy1lNgwxlpCSgNT9CGpwnimIOsu3v3Stxgh08Exw4/IB2s73mdnFwI0QTdPUr3DojK5AAazi94DuvKOpQARmQZyQhIGkELyQRbUU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668992; c=relaxed/simple;
	bh=O1ThrH7LO1wD651DyTogDRIlJAFs8R6NOaj4fpjkIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCf3jq6lhkzM6S1uCnVpUmstqLUcBBFy5V3EsKLCPwz2CvGToJFiTGPLVOQTbjvN/NEB6RufHP7sWyEQJfnHCgaEBIqk5ONUh6JT0dWvDP0V0I/cPaAt1Wx0KNil4vnnZKMpzdIT0+kHZ5bpWgcV7pA9Avy0el0/mR/J1D5nxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5X5VTUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9906C116D0;
	Tue,  2 Dec 2025 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764668991;
	bh=O1ThrH7LO1wD651DyTogDRIlJAFs8R6NOaj4fpjkIcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5X5VTUdnQCp6mG+7WmFTKdWP/OxLbPd+xta15uED36flzBrCvbqAWNeZr3HiTkV9
	 bW9aW//QYH6mZfeMwq1kAfgqwlVMELFApoRZgMAnRuP4ummIMVNEY+oTzdjuz4kk98
	 g1pqWsy14ZjOcH+Nkv1o1R/54LpkjYG5Wh4zlXJ5beAE/p+a/aHQi18PysTjoRYosR
	 kUMqnMTKDIbLz8ScpWgoMbT0+VDId6bU69FpLzzegmmm5XRleMHabuSFhXvdcHu6hO
	 uwSJO92BnBeFMvaKyXE83mX5FLOyQdFVVHykSidEBXtnZBG/sCpUh1Fy5f/8LCJG9z
	 wMfegmQNgV9IQ==
Date: Tue, 2 Dec 2025 10:49:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
Message-ID: <20251202-sektflaschen-biologen-12303d3f052b@brauner>
References: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
 <cenhvze4xmjyddtovfr36c767ttt2dgbprtr4zef6n7wrkgrze@mnzax7kfeegk>
 <20251201140707.GF3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201140707.GF3538@ZenIV>

On Mon, Dec 01, 2025 at 02:07:07PM +0000, Al Viro wrote:
> On Mon, Dec 01, 2025 at 01:57:11PM +0100, Mateusz Guzik wrote:
> 
> > I suspect this is botched error handling in the recent conversion to
> > FD_PREPARE machinery.
> 
> Quite.  FWIW, at that point I believe that FD_ADD/FD_PREPARE branch
> is simply not ready - too little time in -next, if nothing else.
> 
> Christian, drop that pull request, please.

Fwiw, this conversion isn't in mainline. This is -next being out of
sync. Sorry I was too eager to push this. I just got excited about it.
I'm happy to send a revert in case Linus wants that.

