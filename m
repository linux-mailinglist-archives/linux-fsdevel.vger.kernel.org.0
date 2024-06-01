Return-Path: <linux-fsdevel+bounces-20704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EC8D6F2A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7AF1C210C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2396914E2F2;
	Sat,  1 Jun 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dxwOQmNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C07E766
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jun 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234454; cv=none; b=R2K7YJu6QXV5voJc5BKm952v7HUKKVapRDyJoLrYQK2aZ+uYZxC54K9hZpyhCo1bJUyqgrcCanzosSxKJtYk2s0VJ6L13I9tpG2nBWyY3DWedAudHWqiAUjiaA1uPLVy8hnDn0FARqHpo/nXNttQN+/qk0AFhtJej83tTJPi1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234454; c=relaxed/simple;
	bh=PDIhnFKslvYdvVWIZtqzQUmt09I6mMJxyq/3liyAGkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPS6mM4DtrKtpN+Yd7pUMIqtiv1LeukCLUjf7rroMZSKTUf6RsxNBCeR3zh6qTh1ZQHCTwLmIoy1lOjlL0Pbm23h9grCHh31ySQo6UqYva9KtOI8DM5UcEKGI5pH3e3wjz+y7fA3Vbzp4+Mw730YgfMOPQSOSjReDiX5WCLSlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dxwOQmNH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-149-40-50-25.datapacket.com [149.40.50.25] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4519XSrK015047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 05:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1717234413; bh=GZ0408TmIABRPqW2q8FHPsPmzLEavYEG/LOb2+cRwi4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dxwOQmNHGPD6R3ZrzWqaLbnYu5Bbbju7WhHtcVu/4qC5cef3PAcsJcrZhDHtHuNSo
	 /BXQLgZwEGVWtOIkKNmwQEZRgME27WWPqTnlbNee2X5ucRMtEeA6ghuvsjrXupgQ9G
	 46l5V5Tpa5ASaqfz40rmMEiCR8VMpUs+RxyeCSv6PEAsyu6mCjXSOurp9GKRLdgHA1
	 Ezf5/WcPUMX7m6/MJLAajKA75JlXTDMCqxKx2IfgBQ2yqcnn+Zy4SPPdcUQWJd47Us
	 g7q3sXLnOVWHY6WOBs/eDkygQshB0E4AuTK0hB37bTiksFYnZhmeRPZ4pWCtw8tVKA
	 1ptBxtc1XtnRA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D21FA340FB3; Sat, 01 Jun 2024 11:33:25 +0200 (CEST)
Date: Sat, 1 Jun 2024 11:33:25 +0200
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        catherine.hoang@oracle.com
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <20240601093325.GC247052@mit.edu>
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk5qKUJUOjGXEWus@bombadil.infradead.org>
 <bf638db9-c4d3-44bd-a92c-d36e3d95adb6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf638db9-c4d3-44bd-a92c-d36e3d95adb6@oracle.com>

On Thu, May 23, 2024 at 12:59:57PM +0100, John Garry wrote:
> 
> That's my point really. There were some positive discussion. I put across
> the idea of implementing buffered atomic writes, and now I want to ensure
> that everyone is satisfied with that going forward. I think that a LWN
> report is now being written.

I checked in with some PostgreSQL developers after LSF/MM, and
unfortunately, the idea of immediately sending atomic buffered I/O
directly to the storage device is going to be problematic for them.
The problem is that they depend on the database to coalesce writes for
them.  So if they are doing a large database commit that involves
touching hundreds or thousands of 16k database pages, they today issue
a separate buffered write request for each database page.  So if we
turn each one into an immediate SCSI/NVMe write request, that would be
disastrous for performance.  Yes, when they migrate to using Direct
I/O, the database is going to have to figure out how to coalesce write
requests; but this is why it's going to take at least 3 years to make
this migration (and some will call this hopelessly optimistic), and
then users will probably wait another 3 to 5 years before they trust
that the database rewrite to use Direct I/O will get it right and
trust their enterprise workloads to it....

So I think this goes back to either (a) trying to track which writes
we've promised atomic write semantics, or (b) using a completely
different API that only promises "untorn writes with a specified
granulatity" approach for the untorn buffered writes I/O interface,
instead in addition to, or instead of, the current "atomic write"
interface which we are currently trying to promulate for Direct I/O.

Personally, I'd advocate for two separate interfaces; one for "atomic"
I/O's, and a different one for "untorn writes with a specified
guaranteed granularity".  And if XFS folks want to turn the atomic I/O
interface into something where you can do a multi-megabyte atomic
write into something that requires allocating new blocks and
atomically mutating the file system metadata to do this kind of
atomicity --- even though the Database folks Don't Care --- God bless.

But let's have something which *just* promises the guarantee requested
by the primary requesteres of this interface, at least for the
buffered I/O case.

Cheers,

						- Ted

