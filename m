Return-Path: <linux-fsdevel+bounces-4140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0E7FCF2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8447128203F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18410959
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Eg5UlXeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114F10E7;
	Tue, 28 Nov 2023 20:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z1R38ZIL6PItsE4VJCnvik8TjfbvUEepVID/j4l7P7g=; b=Eg5UlXehHPMIfT8SBrouZgfkcU
	hCQIdUNoFzbwFQLMCBZNPjHuzaffVNLXDorIyx6omYtWmmXatluzh+wSH5P0HqMYNAJrNMeT79U6b
	ZnBcFG9ZoiAYf6neENYLGYKSHh4nMX5R4A7c1+IQ91AV/xUaHrujUlsty8zRmzTIIHaXgLtyg3AHF
	fPn8q6AeptVAFGsWZkTIiC1tZ4CVR/8QmK+qjYsZyOsa/vtQSEtF2U/tnzYTHebCij9wwW2dBaJhh
	y/ceevCidqg+Of7MdqEqOqDjwVPNCDCj77kiw5/MQ7nT79NZBERzCbsPGXW3GltRRtHLlXqF2Q0IK
	XEE6Dfsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r8CZV-004l87-08;
	Wed, 29 Nov 2023 04:53:13 +0000
Date: Wed, 29 Nov 2023 04:53:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231129045313.GA1130947@ZenIV>
References: <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063842.GG38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 27, 2023 at 06:38:43AM +0000, Al Viro wrote:

> > FWIW, I suspect that the right answer would be along the lines of
> > 	* if d_splice_alias() does move an exsiting (attached) alias in
> > place, it ought to dissolve all mountpoints in subtree being moved.
> > There might be subtleties,

Are there ever...  Starting with the "our test for loop creation
(alias is a direct ancestor, need to fail with -ELOOP) is dependent
upon rename_lock being held all along".

Folks, what semantics do we want for dissolving mounts on splice?
The situation when it happens is when we have a subtree on e.g. NFS
and have some mounts (on client) inside that.  Then somebody on
server moves the root of that subtree somewhere else and we try
to do a lookup in new place.  Options:

1) our dentry for directory that got moved on server is moved into
new place, along with the entire subtree *and* everything mounted
on it.  Very dubious semantics, especially since if we look the
old location up before looking for new one, the mounts will be
dissolved; no way around that.

2) lookup fails.  It's already possible; e.g. if server has
/srv/nfs/1/2/3 moved to /srv/nfs/x, then /srv/nfs/1/2 moved
to /srv/nfs/x/y and client has a process with cwd in /mnt/nfs/1/2/3
doing a lookup for "y", there's no way in hell to handle that -
the lookup will return the fhandle of /srv/nfs/x, which is the
same thing the client has for /mnt/nfs/1/2; we *can't* move that
dentry to /mnt/nfs/1/2/3/y - not without creating a detached loop.
We can also run into -ESTALE if one of the trylocks in
__d_unalias() fails.  Having the same happen if there are mounts
in the subtree we are trying to splice would be unpleasant, but
not fatal.  The trouble is, that won't be a transient failure -
not until somebody tries to look the old location up.

3) dissolve the mounts.  Doable, but it's not easy; especially
since we end up having to redo the loop-prevention check after
the mounts had been dissolved.  And that check may be failing
by that time, with no way to undo that dissolving...

