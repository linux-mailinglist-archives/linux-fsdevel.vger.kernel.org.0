Return-Path: <linux-fsdevel+bounces-26114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7F954842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDE82848A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BF19D089;
	Fri, 16 Aug 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RooDAEqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008815381F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808980; cv=none; b=QK+YB/CcMB2Ye8xlKBWUKmEmH3VsGkRmeewqBSQ3vtdhslmAAEDiE1JsoseTyc4ib4IYdePdTS6pAOk4DFSF6FRf+GOK4vvQ9f0duNdSBCV17ynGYwaFqRwTRwtxXjXUJDl+gLZhh4wllVqH4FoQjHnNIRvPBu/pS4Be0HhTOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808980; c=relaxed/simple;
	bh=iPPbgJpWiuj8nDIVF04igeDORVXH68bPEdFdNvZrhpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJQ/qOS5u7VNix9PfjByHKG64YlpgkgDJVYirT+/1C8NT14225Su/oeS8D8oRv1xzNJuR1mLURfZ5sNQtF9LZPgq+JQK2xLfw20qG8YBqSpkJUuBb+HIRvRWBWdQOX/m0aKbe0cEGb1BDAn/UINTGwralzIMfwjKdEV4+PQajZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RooDAEqv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uGu3LY+l+7sLVn8Uwe28QpSwiosH8qrjKjrwAAbj/78=; b=RooDAEqvAO3jgtAudEsf5n309V
	8AQfcRdp0FGLNcxAeTscVf3qUMOcf0G55FEhplOqMVAekrPOb2BNEmOSILERmkz7EstFuAICXMR0p
	Q2wwVGr9E3bDH2NpVq3BIsbWzRY7sK0eCR69NLJxh637cqsP0DiuszpWuSIk/vQ/TIn/oPyFYsQBL
	1RsRepRU5Hmtj+tpEhuh2NIkI3mX9QbL7+JEfDkx2cygRpm2RDarNTECsl32w2Rv4ZkXAH//BMmHY
	Mpqie/FeU3vtXPAnz8K3F628Cwivcs+TrpPZLEvV1/pUsMXxhpiXiN8h2zNNg9jRwTWKDZ1HEp3En
	zCmLTcEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sevSZ-00000002BKg-22rM;
	Fri, 16 Aug 2024 11:49:35 +0000
Date: Fri, 16 Aug 2024 12:49:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816114935.GA519295@ZenIV>
References: <20240816030341.GW13701@ZenIV>
 <20240816-hanfanbau-hausgemacht-b9d1c845dee4@brauner>
 <20240816111512.GA504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816111512.GA504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 12:15:12PM +0100, Al Viro wrote:
> On Fri, Aug 16, 2024 at 10:25:52AM +0200, Christian Brauner wrote:
> 
> > I don't think so. It is clear that the file descriptor table is unshared
> > and that fds are closed afterwards and that this can race with file
> > descriptors being inserted into the currently shared fdtable. Imho,
> > there's nothing to fix here.
> > 
> > I also question whether any userspace out there has any such ordering
> > expectations between the two dup2()s and the close_range() call and
> > specifically whether we should even bother giving any such guarantees.
> 
> Huh?
> 
> It's not those dup2() vs unsharing; it's relative order of those dup2().
> 
> Hell, make that
> 
> 	dup2(0, 1023);
> 	dup2(1023, 10);
> 
> Do you agree that asynchronous code observing 10 already open, but 1023
> still not open would be unexpected?

FWIW, for descriptor table unsharing we do (except for that odd case) have
the following:
	* the effect of operations not ordered wrt unshare (i.e. done
by another thread with no userland serialization) may or may not be
visible in the unshared copy; however, if two operations are ordered
wrt to each other, we won't see the effect of the later one without the
effect of the earlier.

Here neither of those dup2() is ordered wrt unsharing close_range();
we might see the effect of both or none or only the first one, but
seeing the effect of the second _without_ the effect of the first is
very odd, especially since the effect of the second does depend upon
just the state change we do *NOT* see.

Actual closing done by unsharing close_range() is not an issue - none
of the affected descriptors are getting closed.  It's the unshare
part that is deeply odd here.  And yes, unshare(2) (or clone(2) without
CLONE_FILES) would have the ordering warranties I'm talking about.

