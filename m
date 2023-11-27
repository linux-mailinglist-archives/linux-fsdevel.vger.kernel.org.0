Return-Path: <linux-fsdevel+bounces-3972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056AF7FA92D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C61B211BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2B34544;
	Mon, 27 Nov 2023 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VK3TcR0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E271A1;
	Mon, 27 Nov 2023 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tCivESMnwjC6Qdqm7yOK4or8gMne49Hy6vnOquUb2y0=; b=VK3TcR0XPvsokf+sip3MIrqtLy
	Z9PojGcz4u7KKhINZ4ZBo/PPmzi8I5yx2w6ajNCQrqS88RZyUWdqdeXDLluB0+ksYZEdBvzjSfJse
	M1NbZZLGLDFbcznZtzzDuPoErwI5csvP9RLxXfKKxWKFxXV7ZXSi5fe36HSArJLgfLEIKm5H0uO1D
	6xkhZfrvDDlOGRLdlHa+E290C45Y8qOo6dtxfHj6rbUk2PdCym42D+HKGXiwCnW/q4xIAHDsvBwIG
	9PAHTgHlskrUsj0Sl5Ynjh9QERJgZAZ6Rdom+A/+4TCsuw3aft/nM+nAS55rtfn//eF/3GIPuLP02
	aLAVeWwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gaK-00465D-0Y;
	Mon, 27 Nov 2023 18:43:56 +0000
Date: Mon, 27 Nov 2023 18:43:56 +0000
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
Message-ID: <20231127184356.GK38156@ZenIV>
References: <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
 <20231127160318.GI38156@ZenIV>
 <20231127161426.GA964333@ZenIV>
 <87v89nkqjm.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v89nkqjm.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 12:19:09PM -0600, Eric W. Biederman wrote:

> Either we should decide it is useless and remove it and all of it's
> children.
> 
> Or we should decide it was renamed and just handle it that way.

How?  An extra roundtrip to server trying to do getattr on the fhandle
we've got?

Cost of that aside, we *still* need to dissolve submounts in such case;
there is no warranty that we'll ever guess the new name and no way
to ask the server for one, so we can't let them sit around.  Not that
having mounts (local by definition) suddenly show up in the unexpected
place because of rename on server looks like a good thing, especially
since had that rename on server been done as cp -rl + rm -rf the same
mounts would be gone...
 
> If we can record such a decision on the dentry or possibly on the inode
> then we can resolve the race by having it be a proper race of which
> comes first.
> 
> It isn't a proper delete of the inode so anything messing with the inode
> and marking it S_DEAD is probably wrong.

s/probably/certainly/, but where would d_invalidate() do such a thing?
It's none of its business...

> The code could do something like mark the dentry dont_mount which should
> be enough to for d_splice_alias to say oops, something is not proper
> here.  Let the d_invalidate do it's thing.
> 
> Or the code could remove the dentry from inode->i_dentry and keep
> d_splice alias from finding it, and it's children completely.
> That is different from unhashing it.

We might be just in the middle of getdents(2) on the directory in question.
It can be opened; we can't do anything that destructive there.

Again, it's about the d_invalidate() on ->d_revalidate() reporting 0;
uses like proc_invalidate_siblings_dcache() are separate story, simply
because there d_splice_alias() is not going to move anything anywhere.

