Return-Path: <linux-fsdevel+bounces-1684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C847DDAE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 03:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB341F21B53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896EED7;
	Wed,  1 Nov 2023 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dc4P3nBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE8EA6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 02:22:38 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E651BD;
	Tue, 31 Oct 2023 19:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JRqdH2fizDsBYPvMPFQiM0vq8GiCsccwLoqoTrgrqA0=; b=dc4P3nBQgWr/FHMoug+nwATvGb
	90bIq8+kJSnouDjEZwieMIJd+znyV5vW/jdzM8FxEfqMXeymkxosSmPAM9dsBySOIjciGREifI/8O
	BtDzDXUtHFd4N2M+s81ji5PN4DUbtg3ciPEXwL407h/TGxVfwr9CBJaXvwjPNyFHN2HSNJ/6E/jQH
	/SuudGB28uUuKka/acPuHAKS0f4DuGsXXESsPU2i577Cc2elKoEqnUMH5Q1QumMY1cs55xvJ4eLP/
	Mt6KnvdeRtGIqv8NOBYG0kZtu8jqXQ8WEevUNb5JG1eqGQDbhh84VigSVmrfG6Cf6jXMbq/uE/5BR
	ypwD5zaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy0sF-008knz-1k;
	Wed, 01 Nov 2023 02:22:27 +0000
Date: Wed, 1 Nov 2023 02:22:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231101022227.GD1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031001848.GX800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[NFS folks Cc'd]

On Tue, Oct 31, 2023 at 12:18:48AM +0000, Al Viro wrote:
> On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
> > On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > After fixing a couple of brainos, it seems to work.
> > 
> > This all makes me unnaturally nervous, probably because it;s overly
> > subtle, and I have lost the context for some of the rules.
> 
> A bit of context: I started to look at the possibility of refcount overflows.
> Writing the current rules for dentry refcounting and lifetime down was the
> obvious first step, and that immediately turned into an awful mess.
> 
> It is overly subtle.  Even more so when you throw the shrink lists into
> the mix - shrink_lock_dentry() got too smart for its own good, and that
> leads to really awful correctness proofs.

... and for another example of subtle shit, consider DCACHE_NORCU.  Recall
c0eb027e5aef "vfs: don't do RCU lookup of empty pathnames" and note that
it relies upon never getting results of alloc_file_pseudo() with directory
inode anywhere near descriptor tables.

Back then I basically went "fine, nobody would ever use alloc_file_pseudo()
for that anyway", but... there's a call in __nfs42_ssc_open() that doesn't
have any obvious protection against ending up with directory inode.
That does not end up anywhere near descriptor tables, as far as I can tell,
fortunately.

Unfortunately, it is quite capable of fucking the things up in different
ways, even if it's promptly closed.  d_instantiate() on directory inode
is a really bad thing; a plenty of places expect to have only one alias
for those, and would be very unhappy with that kind of crap without any
RCU considerations.

I'm pretty sure that this NFS code really does not want to use that for
directories; the simplest solution would be to refuse alloc_file_pseudo()
for directory inodes.  NFS folks - do you have a problem with the
following patch?

======
Make sure we never feed a directory to alloc_file_pseudo()

That would be broken in a lot of ways, from UAF in pathwalk if
that thing ever gets into descriptor tables, to royally screwing
every place that relies upon the lack of aliases for directory
inodes (i.e. quite a bit of VFS).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file_table.c b/fs/file_table.c
index ee21b3da9d08..5331a696896e 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -326,6 +326,9 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 	struct path path;
 	struct file *file;
 
+	if (WARN_ON_ONCE(S_ISDIR(inode->i_mode)))
+		return ERR_PTR(-EISDIR);
+
 	path.dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
 	if (!path.dentry)
 		return ERR_PTR(-ENOMEM);

