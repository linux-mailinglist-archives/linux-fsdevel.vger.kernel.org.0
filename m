Return-Path: <linux-fsdevel+bounces-57821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7CB2593A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8389A2493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618DC215F48;
	Thu, 14 Aug 2025 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hIGFYU4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A1207669;
	Thu, 14 Aug 2025 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135667; cv=none; b=XKlI7mQuG6n134HrYCaNVm5kIrgs92e8ztlWkR+zNEb6660sV0jkHW+146ZVyU+UQsBTlNBqyqq3vl6Zb8dKW9yQBbPirX+fA/xV3Ou3HXKkZcIXlMvECFEJXTASd+uILMMi/GdmP/6Yl6sMmYuothDGV6Ypz+pOkFOLowmp+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135667; c=relaxed/simple;
	bh=qWhVPp8UkMseXAwGoxo/AtQDC8wAu/4GsbTX6yQkXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvs7DXm51462xfsJfU1cJfrDLL/yZbPDIruqgiu0y6Hyf0Ry8BeRk526qEtxa/prb+8DVuR4/Q6bV02wYeMyyf0QlDHpInUuM5chgNejl6BawXTytR5EhJxJ89NUBHwAQSwgwbq4JksjXM8EegwzGirS9qQEE8f6aZtPOoKYKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hIGFYU4V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IQGF8DRgPVwAOQowZ25KwckiYB1Wy4XRBJu7WhzZ8EM=; b=hIGFYU4Vt+WCaZlWzgIl5A5CU0
	De4amhi2m7jG04nG/1NaPJ3AbWQoRkxTG93NyvhlWysu/cZLcnCOcSPRfD1hYYD2ECCQWEXbCypJE
	GZLpnWK2oa2yS2wTOOkCqGEE3FF282LK2IU9gp/GXaQhYsBLB+DMsIZV1c8b7fOH/iThG/hr2l6b/
	mUsQGhR+GwqCB+WuomF8STNbrl2krzf7kaurEkJo8XTzKdGW4DbjxCXqipSd+Ill8PMu8SyZ5+e+Y
	B1WaauvEqWph/ur0ux8bCaPZBT+OZQCASMY+FNQGLzf9fxeeDjmbzKeoP5W42VcZwGtsD8GW2y34N
	oYVC2XiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMxW-0000000FNlW-1mZZ;
	Thu, 14 Aug 2025 01:40:50 +0000
Date: Thu, 14 Aug 2025 02:40:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: add rename_lookup()
Message-ID: <20250814014050.GL222315@ZenIV>
References: <>
 <20250813043531.GB222315@ZenIV>
 <175507227245.2234665.4311084523419609794@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175507227245.2234665.4311084523419609794@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 13, 2025 at 06:04:32PM +1000, NeilBrown wrote:

> There is a git tree you could pull.....
> 
> My API effectively supports both lock_rename() users and
> lock_rename_child() users.  Maybe you want to preserve the two different
> APIs.  I'd rather avoid the code duplication.

What code duplication?  Seriously, how much of the logics is really shared?
Error checking?  So put that into a common helper...
 
> > This is too fucking ugly to live, IMO.  Too many things are mixed into it.
> > I will NAK that until I get a chance to see the users of all that stuff.
> > Sorry.
> > 
> 
> Can you say more about what you think it ugly?
> 
> Are you OK with combining the lookup and the locking in the one
> function?
> Are you OK with passing a 'struct rename_data' rather than a list of
> assorted args?
> Are you OK with deducing the target flags in this function, or do you
> want them explicitly passed in?
> Is it just that the function can use with lock_rename or
> lock_rename_child depending on context?

Put it that way: you are collapsing two (if not more) constructors
for the same object into one.  That makes describing (and proving,
and verifying the callers, etc.) considerably more painful, with very
little gain to be had.

You are not so much modifying rename_data as creating an object - "state
ready for rename".  The fact that you use the same chunk of memory
to encode the arguments of constructor is an implementation detail;
constraints on the contents of that chunk of memory are different both
from each other and from the resulting object.

In effect, you have a weird union of several types here and the fact
that C type system is pretty weak does not help.  Having separate
constructors at least documents which rules apply; conflating them is
asking for trouble.

It's the same problem as with flags arguments, really.  It makes proofs
harder.  "I'm here" is a lot easier to deal with than "such and such
correlations hold between the values of such and such variables".

If we have several constructors (and they can easily share common helpers
- no problem with that), we can always come back and decide to fold them
into one; splitting is a lot harder, exactly because such flags, etc.,
do not stay local.  I've done both kinds of transformations and in the
"split" direction it ended up with bloody painful tree-wide analysis -
more often than not with buggy corner cases caught in process.

Let's not go there; if, in the end of process, we look at the result and
see that unifying some of them makes sense - good, it won't be hard to do.
But making it as "flexible" as possible as the first step pretty much
locks you into a lot of decisions that are better done when the final
state is seen - and possibly had been massaged for a while.

