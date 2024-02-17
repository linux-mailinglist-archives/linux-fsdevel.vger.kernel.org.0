Return-Path: <linux-fsdevel+bounces-11927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEF4859333
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 23:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A01C212E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 22:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9677FBD2;
	Sat, 17 Feb 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EesV0WHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0838DF2
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708210466; cv=none; b=mJGn1NV/ipzDMwCR/Z1nvPRpvAAKGAtYcBmkXkFIgP2fkNXlvW7GEVBqLHopAqkYJv0vVUsra/U6Js6fhEZy34ZPpIJARKuAwnwUAf0VqQNbzL+R4Y8iti48/AXfZU00mrbdWdvd2Fz8r/yalIrM2sdvmMEh0VcUIABLms1ow4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708210466; c=relaxed/simple;
	bh=XDhHzhFUoSKCvf5U3d80vjaOp0eV3L/3tHjpvCtq624=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXgkw0F03yRwU+DuW9DkPFsjFZsVAXjerxCeOF8rUiw9a6MgFJpSXKtPe2nTd3s7xG73SPSLs1OPj67f0FREM/SWnUV0UNOMczxgXNQ8btlQunWR9GUeUK7U2yy+KdXuh9y9CBj9APgY2o11uFI6UdrFx6ofc3DVrRU1dJPZd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EesV0WHy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Feb 2024 17:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708210462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+S6PW8NMbxHlN/D+9fN8tZavb8MoLjIhahjYs7L4uw=;
	b=EesV0WHycikgvD8TxICWEfkLtoqeLrZqOy4/34fNhukFudlieIFFENmw971agb4Zbje4Xi
	4W8o9av7r7YyoAlwLgZZgnrQmDNYprREuX9yB2/bFP+cI6f3tL8gNGQCiE5qioPnwZnebn
	dvev4aPMUnSF4sBOIpI/xDiNwgI4FLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <7gcfxbtwrylgamcbcnft37atyo34vqvbkxr2fp3k26le7vblob@ncqr7dopb2qk>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <ZdEzwTrJV-aQ1CqV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdEzwTrJV-aQ1CqV@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 17, 2024 at 10:31:29PM +0000, Matthew Wilcox wrote:
> On Sat, Feb 17, 2024 at 03:56:40PM -0500, Kent Overstreet wrote:
> > AKA - integer identifiers considered harmful
> 
> Sure, but how far are you willing to take this?  You've recently been
> complaining about inode numbers:
> https://lore.kernel.org/linux-fsdevel/20231211233231.oiazgkqs7yahruuw@moria.home.lan/
> 
> > The solution (originally from plan9, of course) is - UIDs shouldn't be
> > numbers, they should be strings; and additionally, the strings should be
> > paths.
> > 
> > Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
> > subusers, created by alice without any privileged operations or mucking
> > with outside system state, and 'alice' would be superuser w.r.t.
> > 'alice.foo' and 'alice.bar'.
> 
> Waitwaitwait.  You start out saying "they are paths" and then you use
> '.' as the path separator.  I mean, I come from a tradition that *does*
> use '.' as the path separator (RISC OS, from Acorn DFS, which I believe
> was influenced by the Phoenix command interpreter), but Unix tends to
> use / as the separator.

To me, / indicates that it's a filesystem object, which these are not.
Languages tend to use : as the path separator for object namespacing -
heirarchical paths, but not filesystem paths.

> One of the critical things about plan9 that means you have to think
> hard before transposing its ideas to Linux is that it doesn't have suid
> programs.  So if I create willy/root, it's essential that a program
> which is suid only becomes suid with respect to other programs inside
> willy's domain.  And it doesn't just apply to filesystem things, but
> "can I send signals" and dozens of other things.  So there's a lot
> to be fleshed out here.

My proposal is that a user is superuser only over direct sub-users; so
in your example, willy.root would only be superuser over willy.root.*;
it's just your normal willy user that's superuser over all your
sub-users.

That means that our 'root' user doesn't fit with this scheme - the
superuser over the whole system would be the "" user.

Or perhaps we just map our existing users to be sub-users of root?

root
root.willy
root.kent?

User namespacing in this scheme just becomes "prepend this username when
leaving the namespace", so this might actually work; bit odd in that in
this scheme there's nothing implicitly special about the 'root'
username, so that becomes a (mild) wart... easily addressed with
capabilities, though.

