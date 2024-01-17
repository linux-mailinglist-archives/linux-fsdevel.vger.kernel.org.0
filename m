Return-Path: <linux-fsdevel+bounces-8139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E31830010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 07:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23F2287F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE008F5F;
	Wed, 17 Jan 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bezi/DVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD28C09
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472320; cv=none; b=sbw5LwJgGz7FGz+ufqv21wp0JYvOr9fLregou/XIC1tvatOkmWZSbljAw2reYZgPtId7jt28DF3PzWUbTvG+YGxl6PQmE50zmTsEMpeYYjfAydgMZ2bMdk39WfZIvySdliq+Jlu9IUk4PKfgKoKiRr/nMM0TSsfvONf09KpmR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472320; c=relaxed/simple;
	bh=wWBlwK0CZynAtmtGyN5rU69lkaqCaZm33b6Q4u8TbJY=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GXREq1xlczKm2asnoBB5oIovp5UNCaGteUbW9GtJOddpwor+PZ9gYi/iCCnrP4DXY0sXI9ql2xOKu+IlEYVOhIPp4uvoKVnMD6nwQn4hrbhTMB9wxobh3z/t7vgLXk4gPZi75vKnS9n8DVMtExWO7bSQho7tX0Hao6g1/9bQyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bezi/DVB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40H6HkWE025541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 01:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705472270; bh=wtJ6zGFmfFqYubGpggJKb+cEki0Jbdw4QovrPcQik+s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bezi/DVBmAx96tmLOtiemMvJ/aAlYItBBXdzYMsK17Se8wA+6n4CSiQWKHJNixTB/
	 Xjv1wsbeBBrLx3rYSWVeG9jjbVYaqGZ4IxW16ZdyQOByzM6DBn/bObSRPWvCNLIYiN
	 SBK+PxgkENa9spPGqYt2U0pT9mFIVP2dBnuUM+4qo8DXR9r7rq6Ctz7GEW3hNgmpTw
	 Fidvz8Gs2pvXce0V4YUgOCUu+ahaOsE1/eOg4Yt+DN+7nkBtSrfkdJdCdMhaBEcr0h
	 h89mWh9WWU8qS8zELcPAU9GxNQ8heI1iAgjrRbxNqqy3pD7U2j24C9+2OIqGHLGbft
	 fh4OBI1DjDy6w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3FD5F15C0278; Wed, 17 Jan 2024 01:17:42 -0500 (EST)
Date: Wed, 17 Jan 2024 01:17:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240117061742.GM911245@mit.edu>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabtYQqakvxJVYjM@dread.disaster.area>

On Wed, Jan 17, 2024 at 07:56:01AM +1100, Dave Chinner wrote:
> 
> The wiping of secrets is completely orthogonal to the freezing of
> the device and filesystem - the freeze does not need to occur to
> allow the encryption keys and decrypted data to be purged. They
> should not be conflated; purging needs to be a completely separate
> operation that can be run regardless of device/fs freeze status.
> 
> FWIW, focussing on purging the page cache omits the fact that
> having access to the directory structure is a problem - one can
> still retrieve other user information that is stored in metadata
> (e.g. xattrs) that isn't part of the page cache. Even the directory
> structure that is cached in dentries could reveal secrets someone
> wants to keep hidden (e.g code names for operations/products).

Yeah, I think we need to really revisit the implicit requirements
which were made upfront about wanting to protect against the page
cache being exposed.

What is the threat model that you are trying to protect against?  If
the attacker has access to the memory of the suspended processor, then
number of things you need to protect against becomes *vast*.  For one
thing, if you're going to blow away the LUKS encryption on suspend,
then during the resume process, *before* you allow general user
processes to start running again (when they might try to read from the
file system whose encryption key is no longer available, and thus will
be treated to EIO errors), you're going to have to request that user
to provide the encryption key, either directly or indirectly.

And if the attacker has access to the suspended memory, is it
read-only access, or can the attacker modify the memory image to
include a trojan that records the encryption once it is demanded of
the user, and then mails it off to Moscow or Beijing or Fort Meade?

To address the whole set of problems, it might be that the answer
might lie in something like confidential compute, where the all of the
memory encrypted.  Now you don't need to worry about wiping the page
cache, since it's all encrypted.  Of course, you still need to solve
the problem of how to restablish the confidential compute keys after
it has been wiped as part of the suspend, but you needed to solve that
with the LUKS key anyway.

This also addresses Dave's concern of it might not being practical to
drop all of the caches if their are millions of cached inodes and
cached pages that all need to be dropped at suspend time.


Anoter potential approach is a bit more targetted, which is to mark
certain files as containing keying information, so the system can
focus on making sure those pages are wiped at suspend time.  It still
has issues, such as how the desire to wipe them from the memory at
suspend time interacts with mlock(), which is often done by programs
to prevent them from getting written to swap.  And of course, we still
need to worry about what to do if the file is pinned because it's
being accessed by RDMA or by sendfile(2) --- but perhaps a keyfile has
no business of being accessed via RDMA or blasted out (unencrypted!)
at high speed to a network connection via sendfile(2) --- and so
perhaps those sorts of things should be disallowed if the file is
marked as "this file contains secret keys --- treat it specially".

	 		    	      	 - Ted

