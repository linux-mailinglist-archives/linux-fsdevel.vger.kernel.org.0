Return-Path: <linux-fsdevel+bounces-32478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A029A68B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCD8285958
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0701F4FB2;
	Mon, 21 Oct 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNkaLQRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603B1F1314
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514402; cv=none; b=YbebMd4+48IZ1gdXBha0nOwXSVzPzIurq4DwjabMt3GjXJe9/6SQ4oQwDEK1XbHWrlM3yxACPcccuFGYOKIM0QwwQV5dxouXpSalVj8Aib13BYDFgl+ZcNirXx73/Ogu02YMyTxYr7EeqNWklt0G6EuAmAJz1lBqSJhMa47ow38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514402; c=relaxed/simple;
	bh=BXpAP5T4cjm+LqNJvI89Bqa2rY2lIdcQQbMd7fDHnVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0tSpuR7w4m7WlTHoFVnY5+qjEgVeReEuZdwXoRGP3RcGxMcAeDhIIzvKfqhakt0p/vsVCoH7q1TucjAMrhxAijxHqCoKRrBuOtGQYMIx/8+oNtXI58bRWOIRXPWhZDmJjl4P3LTaXaSjU2NZU4CFWCME5dF3kx7uqOyRjOKdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNkaLQRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D038C4CEC3;
	Mon, 21 Oct 2024 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514402;
	bh=BXpAP5T4cjm+LqNJvI89Bqa2rY2lIdcQQbMd7fDHnVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNkaLQRlSD830I0yJe7OUCoI8qpvHZRmVLXdDaqw9EUT1O25pnIFf5V/A3P87xWQP
	 6HJY47P8j1WjiyjscIpwKdPWbkMGIoCp2Nrurcf86Mie6/SBTfYiafojgl8JkstspJ
	 WaU3M+fBvu2zVip1CRpLQsA3/jcEeOrUIHtdt21dfch3ySvDpY3agQe/Hv0EJBRF+z
	 E+NqUj2nqC0M1jS1mvW21ail/93mfVJRc1Jxku96qme/Ap8sTuTGG1faNzYhL/tlbr
	 5KRs4I6nqBF7MMi5O6AH+0RXIgpBz+5SZdysXghGVvVJiZDPsptRdPbVheDBN3+4Du
	 PepDg4WpRiKIA==
Date: Mon, 21 Oct 2024 14:39:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
References: <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241019050322.GD1172273@ZenIV>

On Sat, Oct 19, 2024 at 06:03:22AM +0100, Al Viro wrote:
> On Fri, Oct 18, 2024 at 08:38:22PM +0100, Al Viro wrote:
> > On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:
> > 
> > > Extra cycles where?  If anything, I'd expect a too-small-to-measure
> > > speedup due to dereference shifted from path_init() to __set_nameidata().
> > > Below is literally all it takes to make filename_lookup() treat NULL
> > > as empty-string name.
> > > 
> > > NOTE: I'm not talking about forcing the pure by-descriptor case through
> > > the dfd+pathname codepath; not without serious profiling.  But treating
> > > AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> > > filename_lookup()?  Where do you expect to have the lost cycles on that?
> > 
> > [snip]
> > 
> > BTW, could you give me a reference to the mail with those objections?
> > I don't see anything in my mailbox, but...
> > 
> > Or was that in one of those AT_EMPTY_PATH_NOCHECK (IIRC?) threads?
> > 
> > Anyway, what I'm suggesting is
> > 
> > 1) teach filename_lookup() to handle NULL struct filename * argument, treating
> > it as "".  Trivial and does not impose any overhead on the normal cases.
> > 
> > 2) have statx try to recognize AT_EMPTY_PATH, "" and AT_EMPTY_PATH, NULL.
> > If we have that and dfd is *NOT* AT_FDCWD, we have a nice descriptor-based
> > case and can deal with it.
> > If the name is not empty, we have to go for dfd+filename path.  Also obvious.
> > Where we get trouble is AT_FDCWD, NULL case.  But with (1) we can simply
> > route that to the same dfd+filename path, just passing it NULL for filename.
> > 
> > That handles the currently broken case, with very little disruption to
> > anything else.
> 
> See #getname.fixup; on top of #base.getname and IMO worth folding into it.

Yes, please fold so I can rebase my series on top of it.

> I don't believe that it's going to give any measurable slowdown compared to
> mainline.  Again, if the concerns about wasted cycles had been about routing
> the dfd,"" and dfd,NULL cases through the filename_lookup(), this does *NOT*
> happen with that patch.  Christian, Linus?

This looks good!
Reviewed-by: Christian Brauner <brauner@kernel.org>

