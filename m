Return-Path: <linux-fsdevel+bounces-32476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6649A68A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525AB1C21FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D011EF956;
	Mon, 21 Oct 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+15g/h8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539D1D1F6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514212; cv=none; b=VLGzVmZ0KwrCt1QTDRRj6D2A3tslFomjHXOhQ6hRubB+tdYaeOQhAcDXURaEXLISWMJMLDq78JfolScAKR11BDwuMdii/Iq+e/Bor7SRz4O5fIBB7oUtKn/FbLylGvb//VWdOmnSRJis3WiW5Yus7wXnEsNMlloUGCt6/WLH4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514212; c=relaxed/simple;
	bh=3uSdymSc4BXAMV9MxECIOYJA8ARKEd4QAuFH+q1VC24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkICfU523MIuUHG3E3Al84t2hyoMCsW4AnCTXjSGzObchkM98ej7qgktTLLDUpCHClBlNkS4tgwSabsl+rF77tvOt13PXL53AuZ4PFbrd67/jZthxbzmi4zMW1FMu4tDHuaG3rYniMnQCB9M8HSOK9p2OYD2Y+umhqMkHNV6nVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+15g/h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C5FC4CEC3;
	Mon, 21 Oct 2024 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514212;
	bh=3uSdymSc4BXAMV9MxECIOYJA8ARKEd4QAuFH+q1VC24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+15g/h8EhxFEftwsIZlKe7VM19GHjOZY4PJwkkm1ejQk522mjNxAn91pmzOdbSFu
	 TWu4mRNedf0Fek20kPnPlN3dKLqjfOMI/BcpnpWCyPEH+QMYAOT2kgEmZiD+1D6xXT
	 rMI5AXvkwbgyCVp86+e65VzKIJ831AzeVfJySri13HtywmvmcEcKKgfxDYoFW+eQs0
	 qP4TWWMpAxefMgYEqe4R97CtHOAHWxcStuszaa1nIr9ZN20hPZpdG+sPJaUuccBP5V
	 J3M8lHWEbzbNcgJmgH3aCGJZG8RfdAnSUKDmAaMC+EXjGtWLoAS5Q++Yzg6pY+4CBI
	 SwIYtTvx5B5OQ==
Date: Mon, 21 Oct 2024 14:36:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021-gurken-gesessen-a328d4031d65@brauner>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018165158.GA1172273@ZenIV>

On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:
> On Fri, Oct 18, 2024 at 01:06:12PM +0200, Christian Brauner wrote:
> > > Look: all it takes is the following trick
> > > 	* add const char *pathname to struct nameidata
> > > 	* in __set_nameidata() add
> > >         p->pathname = likely(name) ? name->name : "";
> > > 	* in path_init() replace
> > > 	const char *s = nd->name->name;
> > > with
> > > 	const char *s = nd->pathname;
> > > and we are done.  Oh, and teach putname() to treat NULL as no-op.
> > 
> > I know, that's what I suggested to Linus initially but he NAKed it
> > because he didn't want the extra cycles.
> 
> Extra cycles where?  If anything, I'd expect a too-small-to-measure
> speedup due to dereference shifted from path_init() to __set_nameidata().
> Below is literally all it takes to make filename_lookup() treat NULL
> as empty-string name.
> 
> NOTE: I'm not talking about forcing the pure by-descriptor case through
> the dfd+pathname codepath; not without serious profiling.  But treating

Ah ok, that makes sense. I thought you were talking about that...

> AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> filename_lookup()?

Yes, that's good!

