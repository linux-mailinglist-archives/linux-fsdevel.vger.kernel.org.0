Return-Path: <linux-fsdevel+bounces-25227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92212949FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9201F24076
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536D1B29C6;
	Wed,  7 Aug 2024 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bjVY+ITP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2331B1505;
	Wed,  7 Aug 2024 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011785; cv=none; b=AMW6DiDrmwRyFiKbud5u1l7/ewaRnbHgeZxgMQkeAd7LanfsKSYLXUr1jo3Q4HlmcELfB/ZaAChix59pcFVcVAVBtLr8Ft3N5baNdz7Pbudxwge2BgemNxz6f6qgNL7mmfAtRWagum3Q1iwPlnW3SSQ738yI2kDOIatInmIFuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011785; c=relaxed/simple;
	bh=sCwlYlsMpOPty/AUi4QEkXv9bKvP/u2iwAeeREquDLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3qvhQQqL7lt47CdpFDsXICITssDBK6BuphtiLdQL/qKMRgogrTRRSGIwIA32bsvT+HGdei/mWzX3L2h8vPsGTgr4KOaIJWVJ2g1LLGlzHQThFdGpWVxvOowexgmaDUWWSm4c5Ro0eIJIVVOFlVWXqwrHWwjNAuVdnW+pFg/Eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bjVY+ITP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eEJ1QVBmKoMOR67QMIn1s749OhI2005auZEU2MKp1YQ=; b=bjVY+ITPhj2X4nKOwdzWLKT7PN
	CWCoE9pzc1/DVYCetiD26qQ/wkTN64VMzMThhdNb4gQf6Fyh0cvmbCFM08a29w2BPTvHlX2XLtbVN
	ZuCHOeRzzRZnyM9uP2QZ+G1GXfSMqhR4Rt3aweY1di0KGKhZxLwJrNRKdCeEHfPyX1eJZkmnfP4WT
	Z3AEYPj09TPmYm47PvX5d6z6cWKEasqgg695ISp6hn0W9fH1j+fQCmJ/jURFTGCwJ4adLJmh2f8At
	wnIK6hTtXKOTEOZuiOGc61JGNUq/t6GFpZvZumZvlVWobgZMHJASixZbSDtteJlIHaVMtdzomuoeW
	ofX2zZZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sba4a-00000002FPC-2iFg;
	Wed, 07 Aug 2024 06:23:00 +0000
Date: Wed, 7 Aug 2024 07:23:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807062300.GU5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV>
 <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

	After having looked at the problem, how about the following
series:

1/5) lift path_get() *AND* path_put() out of do_dentry_open()
into the callers.  The latter - conditional upon "do_dentry_open()
has not set FMODE_OPENED".  Equivalent transformation.

2/5) move path_get() we'd lifted into the callers past the
call of do_dentry_open(), conditionally collapse it with path_put().
You'd get e.g.
int vfs_open(const struct path *path, struct file *file)
{
        int ret;

        file->f_path = *path;
        ret = do_dentry_open(file, NULL);
        if (!ret) {
                /*
                 * Once we return a file with FMODE_OPENED, __fput() will call
                 * fsnotify_close(), so we need fsnotify_open() here for
                 * symmetry.
                 */
                fsnotify_open(file);
        }
	if (file->f_mode & FMODE_OPENED)
		path_get(path);
        return ret;
}

Equivalent transformation, provided that nobody is playing silly
buggers with reassigning ->f_path in their ->open() instances.
They *really* should not - if anyone does, we'd better catch them
and fix them^Wtheir code.  Incidentally, if we find any such,
we have a damn good reason to add asserts in the callers.  As
in, "if do_dentry_open() has set FMODE_OPENED, it would bloody
better *not* modify ->f_path".  <greps> Nope, nobody is that
insane.

3/5) split vfs_open_consume() out of vfs_open() (possibly
named vfs_open_borrow()), replace the call in do_open() with
calling the new function.

Trivially equivalent transformation.

4/5) Remove conditional path_get() from vfs_open_consume()
and finish_open().  Add
		if (file->f_mode & FMODE_OPENED)
			path_get(&nd->path);
before terminate_walk(nd); in path_openat().

Equivalent transformation - see
        if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
                dput(nd->path.dentry);
                nd->path.dentry = dentry;
                return NULL;
        }
in lookup_open() (which is where nd->path gets in sync with what
had been given to do_dentry_open() in finish_open()); in case
of vfs_open_consume() in do_open() it's in sync from the very
beginning.  And we never modify nd->path after those points.
So we can move grabbing it downstream, keeping it under the
same condition (which also happens to be true only if we'd
called do_dentry_open(), so for all other paths through the
whole thing it's a no-op.

5/5) replace
		if (file->f_mode & FMODE_OPENED)
			path_get(&nd->path);
		terminate_walk(nd);
with
		if (file->f_mode & FMODE_OPENED) {
			nd->path.mnt = NULL;
			nd->path.dentry = NULL;
		}
		terminate_walk(nd);
Again, an obvious equivalent transformation.

