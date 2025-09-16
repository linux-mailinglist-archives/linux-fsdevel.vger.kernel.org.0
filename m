Return-Path: <linux-fsdevel+bounces-61729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07152B597CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF6163A74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156C313E16;
	Tue, 16 Sep 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0TBepx7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C93191A3;
	Tue, 16 Sep 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029765; cv=none; b=UtkqKrTVB5cdOZL9lmgBncCqn1hcUqtKDC+34qCtACkux/rq9Eip8DTSTJ5tXzEzKFY08Qkmt9uSiIfurfBXMC8sqAc/y8qXeZWtUpmkbyzbbBu+WkMLqDkwwSHFfXaBv6S/1S14XdBKGAzrxuCDQ6f8FaeTx+9qqUKHBN7jX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029765; c=relaxed/simple;
	bh=nxPr6BROuKeid2asUHqylc5kE6izLAV55LFjfxk7V7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLobXFdHh/hTtSbaEU5dJBaIFVYoKekuHqSjAV7u3ozFW9hAeq9KfvYPAKJsQJSi7oSQOLwMIJmNcY7YTW08dbgU7t54BIX5/9qDzxO9bd5Fpud7a9bIaCRgG7XJuTGp/+22oLd9baOX20amJ40VWJ34+uXr+eAiQrbt816kvMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0TBepx7n; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7261F14C2D3;
	Tue, 16 Sep 2025 15:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758029756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJQV/xL2hmIUKXDSuzeF/Nwm/bBht4Qf4SUZQZ6+msY=;
	b=0TBepx7n/S/c5Sq8+oJsksGNWfhB4aNwu00NfyFWcGS9i1/LhKGUjmpKAQU8wGSvaJA6HS
	enIe247FPthCU76U4kscIarSZ3ro0VTGDprPkp1RfS7o5FhpHQypDM+/T/MD9doS/0neub
	WGz1WOuMDF1LQaU6FQiOf6TVRSTlbhjKw9K9YKvoM4qHr0+GmTyGweaKDDPIGKkzmLSd0e
	44xV372CW2+9Tjdy0kZyjes+MtT/aCOSKtEW/VWdj+2dxEkearky9U2F2W7LGOx4F94J5Z
	PGiWQ8IzbM0ZWluN+RKH7dGoYBphNIEVUGgsL6M/TFyWL1PU+xAXGUC33MebPg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b149dc1f;
	Tue, 16 Sep 2025 13:35:50 +0000 (UTC)
Date: Tue, 16 Sep 2025 22:35:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <aMlnpz7TrbXuL0mc@codewreck.org>
References: <aMih5XYYrpP559de@codewreck.org>
 <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>

Tingmao Wang wrote on Tue, Sep 16, 2025 at 01:44:27PM +0100:
> > iirc even in cacheless mode 9p should keep inode arounds if there's an
> > open fd somewhere
> 
> Yes, because there is a dentry that has a reference to it.  Similarly if
> there is a Landlock rule referencing it, the inode will also be kept
> around (but not the dentry, Landlock only references the inode).  The
> problem is that when another application (that is being Landlocked)
> accesses the file, 9pfs will create a new inode in uncached mode,
> regardless of whether an existing inode exists.
> [...]
> Based on my understanding, I think this isn't really to do with whether
> the dentry is around or not.  In cached mode, 9pfs will use iget5_locked
> to look up an existing inode based on the qid, if one exists, and use
> that, even if no cached dentry points to it.  However, in uncached mode,
> currently if vfs asks 9pfs to find an inode (e.g. because the dentry is no
> longer in cache), it always get a new one:
> [...]
> v9fs_qid_iget_dotl:
> 	...
> 	if (new)
> 		test = v9fs_test_new_inode_dotl;
> 	else
> 		test = v9fs_test_inode_dotl;

Right, if we get all the way to iget uncached mode will get a new inode,
but if the file is opened (I tried `cat > foo` and `tail -f foo`) then
re-opening cat will not issue a lookup at all -- v9fs_vfs_lookup() is
not called in the first place.
Likewise, in cached mode, just having the file in cache makes new open
not call v9fs_vfs_lookup for that file (even if it's not currently
open), so that `if (new)` is not actually what matters here afaiu.

What's the condition to make it happen? Can we make that happen with
landlock?

In practice that'd make landlock partially negate cacheless mode, as
we'd "pin" landlocked paths, but as long as readdirs aren't cached and
other metadata is refreshed on e.g. stat() calls I think that's fine
if we can make it happen.

(That's a big if)

> > So in cacheless mode, if you have a tree like this:
> > a
> > └── b
> >     ├── c
> >     └── d
> > with c 'open' (or a reference held by landlock), then dentries for a/b/c
> > would be kept, but d could be droppable?
> 
> I think, based on my understanding, a child dentry does always have a
> reference to its parent, and so parent won't be dropped before child, if
> child dentry is alive.

I'd be tempted to agree here

> However holding a proper dentry reference in an
> inode might be tricky as dentry holds the reference to its inode.

Hmm, yeah, that's problematic.
Could it be held in landlock and not by the inode?
Just thinking out loud.

> > My understanding is that in cacheless mode we're dropping dentries
> > aggressively so that things like readdir() are refreshed, but I'm
> > thinking this should work even if we keep some dentries alive when their
> > inode is held up.
> 
> If we have some way of keeping the dentry alive (without introducing
> circular reference problems) then I guess that would work and we don't
> have to track paths ourselves.

Yes, that's the idea - the dentry basically already contain the path, so
we wouldn't be reinventing the wheel...

> >  - if that doesn't work (or is too complicated), I'm thinking tracking
> > path is probably better than qid-based filtering based on what we
> > discussed as it only affects uncached mode.. I'll need to spend some
> > time testing but I think we can move forward with the current patchset
> > rather than try something new.
> 
> Note that in discussion with Mickaël (maintainer of Landlock) he indicated
> that he would be comfortable for Landlock to track a qid, instead of
> holding a inode, specifically for 9pfs.

Yes, I saw that, but what you pointed out about qid reuse make me
somewhat uncomfortable with that direction -- you could allow a
directory, delete it, create a new one somewhere else and if the
underlying fs reuse the same inode number the rule would allow an
intended directory instead so I'd rather not rely on qid for this
either.
But if you think that's not a problem in practice (because e.g. landlock
would somehow detect the dir got deleted or another good reason it's not
a problem) then I agree it's probably the simplest way forward
implementation-wise.

-- 
Dominique Martinet | Asmadeus

