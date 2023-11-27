Return-Path: <linux-fsdevel+bounces-3955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C547D7FA5EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026151C20C4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BD364BE;
	Mon, 27 Nov 2023 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HQmorr4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A418BF;
	Mon, 27 Nov 2023 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f6t3S95m3XiCuv2fnCK3LYrmUiIo2p7MxZyJA3+p7Vk=; b=HQmorr4bydMgYYjt+87IfrdCnX
	wkoemiCdFgrYV+AgikhFuQfsaBscVGISJO9sIzM9L5j5Sf1tWzj5a1OTTd0CI6mr1f0CU1iCeyFNF
	U8jQAg6oXDXjuqa5M8plGosyofibiF7dLCRysFq3mA9AiGEZfQJY/NNCYi5ILyA2qC/BM4qym/YkV
	V7O5lUkYKtkyDX0RA2ywbV+uLIn16rVbmCspIYFwM2X8BhdgLYH6nN2hbhn2ZchAPDjtx1J58cwMP
	nLnW1m0Rnq93mc8agBKsoiTJuhLCYvxOboHF/V0XVMJ0nx/OY7F3s47E7HJ6wXGumDcr/eLt+3Myz
	/D/tjinw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eFe-00434D-22;
	Mon, 27 Nov 2023 16:14:26 +0000
Date: Mon, 27 Nov 2023 16:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231127161426.GA964333@ZenIV>
References: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
 <20231127160318.GI38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127160318.GI38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 04:03:18PM +0000, Al Viro wrote:
> On Mon, Nov 27, 2023 at 09:47:47AM -0600, Eric W. Biederman wrote:
> 
> > There is a lot going on there.  I remember one of the relevant
> > restrictions was marking dentries dont_mount, and inodes S_DEAD
> > in unlink and rmdir.
> > 
> > But even without out that marking if d_invalidate is called
> > from d_revalidate the inode and all of it's dentries must be
> > dead because the inode is stale and most go.  There should
> > be no resurrecting it at that point.
> > 
> > I suspect the most fruitful way to think of the d_invalidate vs
> > d_splice_alias races is an unlink vs rename race.
> > 
> > I don't think the mechanism matters, but deeply and fundamentally
> > if we detect a directory inode is dead we need to stick with
> > that decision and not attempt to resurrect it with d_splice_alias.
> 
> Wrong.  Deeply and fundamentally we detect a dentry that does not
> match the directory contents according to the server.
> 
> For example, due to rename done on server.  With object in question
> perfectly alive there - fhandle still works, etc.
> 
> However, it's no longer where it used to be.  And we would bloody better
> not have lookups for the old name result in access to that object.
> We also should never allow the access to *new* name lead to two live
> dentries for the same directory inode.
> 
> Again, this is not about rmdir() or unlink() - invalidation can happen
> for object that is still open, still accessed and still very much alive.
> Does that all the time for any filesystem with ->d_revalidate().

Put another way, there used to be very odd song and dance in ->d_revalidate()
instances along the lines of "we can't possibly tell the caller to invalidate
a mountpoint"; it was racy in the best case and during the rewrite of
d_invalidate() to teach it how to evict submounts those attempts had been
dropped - ->d_revalidate() returning 0 does end up with mounts dissolved
by d_invalidate() from caller.

It always had been racy, starting with the checks that used to be in
->d_revalidate() instances way before all those changes.  So the switch
of d_invalidate() to dissolving submounts had been a step in the right
direction, but it's not being careful enough.

Again, it's about d_invalidate() caused by pathwalk running into a dentry that
doesn't match the reality vs. d_splice_alias() finding that it matches the
inode we had looked up elsewhere.

