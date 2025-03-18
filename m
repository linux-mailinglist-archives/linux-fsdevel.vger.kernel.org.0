Return-Path: <linux-fsdevel+bounces-44323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D0A675AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E08217D434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3D20DD6D;
	Tue, 18 Mar 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTFKbk6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B276026;
	Tue, 18 Mar 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306259; cv=none; b=aWNvTHfIh9nlRcSmaNSm7cw8XT1nzLio7+A6TprYrBHkEXakLHdrtah43wrAOITE5AJR+yyN12mOpW9FS1bwwKnzQcdJnYOOQnhpbjkx74QEfAeb4f5vbQHSXJK3z2+JJrr33ZHEM3vAuOHL/xXHUt1M0m9nE8E+VoMU3qx04Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306259; c=relaxed/simple;
	bh=640pjyCCFM0HPbzddzhSVRq68zzvtQCSwus+WHQec5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPBObyI3J4VIC66T2iHS+WwJwX0LTVia1r6eyAS9ySy2Tdw2FjtyPYTlpxuxEnrrmZQnGdo2DtDlH+xdG0niBBshg9BIDIJ6sH2BZ8p0WwHkfz2qdZX0z9UO8V0gebHFiGcvjgLZJSi6eHBvB4TD+Y1zzn9rnY7CVJmchOVbkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTFKbk6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54485C4CEDD;
	Tue, 18 Mar 2025 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306258;
	bh=640pjyCCFM0HPbzddzhSVRq68zzvtQCSwus+WHQec5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTFKbk6Ff6esbCcGPcwNLuOb+hbF+/KQNSgZC+9lnSqVL7spOORQk7xaJaV/SgWwV
	 lUe4G2daxs42y8oQxvysaq9cfz3ff7YgkSladGBXFlT+XBZFk0jQPSPbDWrYHMjy1y
	 nbEjnYoujX5Dht5dscgF1pVnL2QPjNLLQ4XSr9e5DSWj+gkrV/gkaa/1u5hxwK/Znm
	 yVwsBmCokRmjNNS0u8vAFvwbomII5r9aHDqIvILjsVp+pdgIMvDr7KzbkALSoGln9z
	 O2IaHMy7phH288PwjsADw4X2ll8luVCpTAHbyuxiVymjP4osSEwcBr0iiIowVeArn2
	 eEHpBaa11B8XA==
Date: Tue, 18 Mar 2025 14:57:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/8 RFC] tidy up various VFS lookup functions
Message-ID: <20250318-audienz-radeln-17745f4c6b8e@brauner>
References: <20250314045655.603377-1-neil@brown.name>
 <20250314-geprobt-akademie-cae577d90899@brauner>
 <174217721714.9342.9504907056839144338@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174217721714.9342.9504907056839144338@noble.neil.brown.name>

On Mon, Mar 17, 2025 at 01:06:57PM +1100, NeilBrown wrote:
> On Fri, 14 Mar 2025, Christian Brauner wrote:
> > On Fri, Mar 14, 2025 at 11:34:06AM +1100, NeilBrown wrote:
> > > VFS has some functions with names containing "lookup_one_len" and others
> > > without the "_len".  This difference has nothing to do with "len".
> > > 
> > > The functions without "_len" take a "mnt_idmap" pointer.  This is found
> > 
> > When we added idmapped mounts there were all these *_len() helpers and I
> > orignally had just ported them to pass mnt_idmap. But we decided to not
> > do this. The argument might have been that most callers don't need to be
> > switched (I'm not actually sure if that's still true now that we have
> > quite a few filesystems that do support idmapped mounts.).
> > 
> > So then we added new helper and then we decided to use better naming
> > then that *_len() stuff. That's about it.
> > 
> > > in the "vfsmount" and that is an important question when choosing which
> > > to use: do you have a vfsmount, or are you "inside" the filesystem.  A
> > > related question is "is permission checking relevant here?".
> > > 
> > > nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
> > > functions.  They pass nop_mnt_idmap which is not correct if the vfsmount
> > > is actually idmaped.  For cachefiles it probably (?) doesn't matter as
> > > the accesses to the backing filesystem are always does with elevated privileged (?).
> > 
> > Cachefiles explicitly refuse being mounted on top of an idmapped mount
> > and they require that the mount is attached (check_mnt()) and an
> > attached mount can never be idmapped as it has already been exposed in
> > the filesystem hierarchy.
> > 
> > > 
> > > For nfsd it would matter if anyone exported an idmapped filesystem.  I
> > > wonder if anyone has tried...
> > 
> > nfsd doesn't support exporting idmapped mounts. See check_export() where
> > that's explicitly checked.
> > 
> > If there are ways to circumvent this I'd be good to know.
> 
> I should have checked that they rejected idmapped mounts
> (is_idmapped_mnt()).  But I think that just changes my justification for
> the change, not my desire to make the change.
> 
> There are two contexts in which lookup is done.  One is the common
> context when there is a vfsmount present and permission checking is
> expected.  nfsd and cachefiles both fit this context.
> 
> The other is when there is no vfsmount and/or permission checking is not
> relevant.  This happens after lookup_parentat when the permission check
> has already been performed, and in various virtual filesystems when the
> filesystem itself is adding/removing files or in normal filesystems
> where dedicated names like "lost+found" and "quota" are being accessed.
> 
> I would like to make a clear distinction between these, and for that to
> be done nfsd and cachefiles need to be changed to clearly fit the first
> context.  Whether they should allow idmapped mounts or not is to some
> extent a separate question.  They do want to do permission checking
> (certainly nfsd does) so they should use the same API as other
> permission-checking code.
> 
> > 
> > > 
> > > These patches change the "lookup_one" functions to take a vfsmount
> > > instead of a mnt_idmap because I think that makes the intention clearer.
> > 
> > Please don't!
> > 
> > These internal lookup helpers intentionally do not take a vfsmount.
> > First, because they can be called in places where access to a vfsmount
> > isn't possible and we don't want to pass vfsmounts down to filesystems
> > ever!
> 
> There are two sorts of internal lookup helpers.
> Those that currently don't even take a mnt_idmap and are called, as you
> say, in places where a vfsmount isn't available.
> And those that are currently called with a mnt_idmap and called (after a
> few cleanup) in places where a vfsmount is readily available.

That's not the point. The vfsmount is the wrong data structure to pass
to lookup_one(). The mount is completely immaterial to what it does. The
only thing that matters is the idmap. Passing the vfsmount is actively
misleading.

> 
> 
> > 
> > Second, the mnt_idmap pointer is - with few safe exceptions - is
> > retrieved once in the VFS and then passed down so that e.g., permission
> > checking and file creation are guaranteed to use the same mnt_idmap
> > pointer.
> 
> In every case that I changed a call to pass a vfsmount instead of a
> mnt_idmap, the mnt_idmap had recently been fetched from the vfsmount,
> often by mnt_idmap() in the first argument to lookup_one().  Sometimes
> by file_mnt_idmap() or similar.  So the patch never changed the safety
> of the idmap.

Taking btrfs:

        dentry = lookup_one(parent->mnt, QSTR_LEN(name, namelen), parent->dentry);
        error = PTR_ERR(dentry);
        if (IS_ERR(dentry))
                goto out_unlock;

        error = btrfs_may_create(idmap, dir, dentry);
        if (error)
                goto out_dput;

You fetch the idmap pointer twice here. The only reason that this is
safe is because I made it so that while an active writer is on a mount
the idmap cannot be changed. But that's subtle knowledge. By passing the
idmap pointer directly it is visually trivial to figure out that it is
guaranteed to be the same idmap without having to know how
mnt_want_write_file() interacts with mount_setattr().

The changes here also make following the logic complex. The idmap
pointer is fetched once and passed down everywhere it is needed. But
suddenly that's not true anymore for lookup_one() where its the
vfsmount. First question this raises is whether the mount topology
somehow matters for the lookup when really it doesn't.

Your cleanup series is really good with or without stuffing vfsmount
into all of these helpers. So please just either resend it and continue
passing struct mnt_idmap or I'll change it when I apply.

