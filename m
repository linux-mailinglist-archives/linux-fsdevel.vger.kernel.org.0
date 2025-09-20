Return-Path: <linux-fsdevel+bounces-62319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFFBB8CE8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 20:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141D87C8444
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342830F7FE;
	Sat, 20 Sep 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NM79fJk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A62F5B;
	Sat, 20 Sep 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758391768; cv=none; b=T/l/P1LHmtzu5GNPWs3Ay2dZ3XX7PHHpYJ0IdgiGRh/63qppV4MjSq7Zzm2ei5MsMy+EwR0uoqkmD3UmDWXTJLfdMJdkmLJ0WFue6aHPhn6NSSVxbiCSkgPJ9Bds5Qh12L91perIX46Ekqz1TIuV8WA7L8MytiiM2oUG3LOZfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758391768; c=relaxed/simple;
	bh=LMPdgJ5xJP991yqk9NU4wcmgCyL9QUZYstLpRktYbYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkl7Sc9htOCMIlaUGkMhxW5RhKfElnbo4TMMP9pmrO2CXSdROO4Zsqi978WQ3Q8O83BtIXIF1/SKzr3PMxIg7yH7xFC0b/E0XtZjQ4yi1R7ZDyhgVNS9CBfd5ZB3QhLeV1MZy2IPK/9A2gqLvz6LXSktbZ2L3gJYnSq/7OUMa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NM79fJk4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6NL30/0+UZmJ+Ndqi2NTqpdBOV8RvNTpTtq6rtRPK9E=; b=NM79fJk4vVddI7amyfuuFalCjV
	KCwjdAr3TBi8ShghGh7DNgYuVH9L+WE3QjtxSRg3IZBe1atmcEKyONCQj9I3wo/0CEGQOZou4azRK
	2+7qBlOTxdA1xp127r7u5bM6TjwF9mONn+nwL5XucvYd3CZuGSX3BA5ysms187Yyj/wF6/86/CmTL
	WC2z/0mRVx9nm5VEhTaqI7AesxCZh6k1F+Lpz9Pus6qr4SxsrrMPq2R9tjnbIPN4krYN0ZoLm1Cek
	ZI6tJ4FtKRcLJdSKn5AdIr/wOwwbdc4jFYT2UcYCQC/FIOU5oSOQeuYce7ptP2b4JNzeCtNGNm6Zd
	bQgwQelw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v021O-000000039W5-3GQv;
	Sat, 20 Sep 2025 18:09:18 +0000
Date: Sat, 20 Sep 2025 19:09:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCHES][RFC] the meat of tree-in-dcache series
Message-ID: <20250920180918.GL39973@ZenIV>
References: <20250920074156.GK39973@ZenIV>
 <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 20, 2025 at 09:26:27AM -0700, Linus Torvalds wrote:

> Anyway, apart from that I only had one reaction: I think
> d_make_discardable() should have a
> 
>         WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT))
> 
> because without that I think it can mistakenly be used as some kind of
> "dput that always takes the dentry lock", which seems bad.
> 
> Or was that intentional for some reason?

In the end - sure, we want that.  But in the meanwhile that would require
separate variants of simple_unlink()/simple_recursive_removal()/etc.
for those filesystems that are already marking persistent ones, with
the only difference being that warning.

A lot more noise that way.

So I'd prefer to put a warning in the source for the time being.  In principle,
by the end of series as posted we are down to very few filesystems that use
simple_unlink() and friends without having marked them persistent in the
first place, so it would be possible to put a "make d_make_discardable() warn
if it's not marked persistent, add variants of simple_unlink()/simple_rmdir()/
simple_recursive_removal()/locked_recursive_removal() that would *NOT* warn
and switch the handful of unconverted users to calling those", but...

By the end of series as posted that's down to nfsctl, rpc_pipe, securityfs,
configfs and apparmorfs.  The first 3 - because they used to have subseries
of their own in separate branches, with corresponding conversion commits
sitting on top of merges (#work.nfsctl is the last of those branches).
No real obstacle to moving them into the queue, I just wanted to post it
for review before we get to -rc7.

The remaining two (configfs and apparmor) are special enough to warrant private
copies of simple_{unlink,rmdir}().  So I'd rather have that in patch adding
the warning - simple_recursive_remove() wouldn't need a separate copy that
way at all.

configfs has a separate series untangling it, but that's a separate story -
that work goes back to 2018; I want to resurrect it, but I'm not mixing it
into this pile.

appramor is... special.  They've got locking of their own, completely broken and
interspersed with regular directory locks.  John Johansen, if I understood him
correctly, has some plans re fixing that, and I'm happy not to have analysis
of their locking on my plate.  _Maybe_ it will end up close enough to the usual
tree-in-dcache to switch to that stuff, but at the moment I'd rather open-code
simple_{unlink,rmdir} in aafs_remove() and leave it at that.

