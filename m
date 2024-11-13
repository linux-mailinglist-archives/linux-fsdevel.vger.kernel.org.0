Return-Path: <linux-fsdevel+bounces-34576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EC9C6628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA6AB299CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E044B665;
	Wed, 13 Nov 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMSpZlf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F02594;
	Wed, 13 Nov 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458412; cv=none; b=bu/G87uLuCYSm0Qwk0Hl52IH0iN7AgNOM6j3lF4CLsbw0igY1WtjO+VySIn/R7CHG1cg/08O552psSShjlzBs5pVprMlrzITSOaMuAjFSCrAJoQYl7VoZOgPy2DxMYnGy0RYMz/cOKX+cl4vlvGkPmbgu3Jts91wVOQSZKzKvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458412; c=relaxed/simple;
	bh=1HpdaHws7Dvsc5CJpVpfvuv7uAODMFdVxG82OJNxjUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wyf19VnvhV3kCNRkKYRqblVonyhU6zaWfETVrseZSJA0AMuMf9T/d35S68RWx1wcE/axPP57y/IcOySgrpfP7LlZIcjwDv4/l+AAo7m+hU0JxIxYKQdz1GLd8e7fLCpDaqPFA8cHFwZbTIeZNx/anPb+QahJfRsadCM34rvSyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMSpZlf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2364AC4CECD;
	Wed, 13 Nov 2024 00:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731458412;
	bh=1HpdaHws7Dvsc5CJpVpfvuv7uAODMFdVxG82OJNxjUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMSpZlf16u+YRlsKM9DvsQ/m53BLIB9aDEibiUboTCqKnTQkg6ybdo2XmXMePg09/
	 K8PrbUpkBJptPuezsRn1yq2RikhAaUngrjhSLuxEnNLU9NPXXpshlfsvKDwlePR62P
	 DkkBujLvDZR8wsYEjvNVLZ1uS5Yu2qqUue5l0q9MKBWwrBfWdKsWMo+zF0zwIh2smr
	 +nWqGkSCDg9yb8QSf9zM4A+MjwhR/j+oWkmzBkro8WHc4r4SB3Sl2aWaklsNifffLZ
	 zGlJuGXHjFeV2bDQaJHzPBLWrk1+M0NCLz8qhbJZ+ii4HuT+p8UNTdjjyHGiDgo3W7
	 wDy/0ejn8kL2A==
Date: Tue, 12 Nov 2024 16:40:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, christian@brauner.io,
	paul@paul-moore.com, bluca@debian.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Message-ID: <20241113004011.GG9421@frogsfrogsfrogs>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>

On Wed, Nov 13, 2024 at 12:03:08AM +0100, Erin Shepherd wrote:
> 
> On 12/11/2024 14:10, Christian Brauner wrote:
> > Sorry for the delayed reply (I'm recovering from a lengthy illness.).
> No worries on my part, and I hope you're feeling better!
> > I like the idea in general. I think this is really useful. A few of my
> > thoughts but I need input from Amir and Jeff:
> >
> > * In the last patch of the series you already implement decoding of
> >   pidfd file handles by adding a .fh_to_dentry export_operations method.
> >
> >   There are a few things to consider because of how open_by_handle_at()
> >   works.
> >
> >   - open_by_handle_at() needs to be restricted so it only creates pidfds
> >     from pidfs file handles that resolve to a struct pid that is
> >     reachable in the caller's pid namespace. In other words, it should
> >     mirror pidfd_open().
> >
> >     Put another way, open_by_handle_at() must not be usable to open
> >     arbitrary pids to prevent a container from constructing a pidfd file
> >     handle for a process that lives outside it's pid namespace
> >     hierarchy.
> >
> >     With this restriction in place open_by_handle_at() can be available
> >     to let unprivileged processes open pidfd file handles.
> >
> >     Related to that, I don't think we need to make open_by_handle_at()
> >     open arbitrary pidfd file handles via CAP_DAC_READ_SEARCH. Simply
> >     because any process in the initial pid namespace can open any other
> >     process via pidfd_open() anyway because pid namespaces are
> >     hierarchical.
> >
> >     IOW, CAP_DAC_READ_SEARCH must not override the restriction that the
> >     provided pidfs file handle must be reachable from the caller's pid
> >     namespace.
> 
> The pid_vnr(pid) == 0 check catches this case -- we return an error to the
> caller if there isn't a pid mapping in the caller's namespace
> 
> Perhaps I should have called this out explicitly.
> 
> >   - open_by_handle_at() uses may_decode_fh() to determine whether it's
> >     possible to decode a file handle as an unprivileged user. The
> >     current checks don't make sense for pidfs. Conceptually, I think
> >     there don't need to place any restrictions based on global
> >     CAP_DAC_READ_SEARCH, owning user namespace of the superblock or
> >     mount on pidfs file handles.
> >
> >     The only restriction that matters is that the requested pidfs file
> >     handle is reachable from the caller's pid namespace.
> 
> I wonder if this could be handled through an addition to export_operations'
> flags member?
> 
> >   - A pidfd always has exactly a single inode and a single dentry.
> >     There's no aliases.
> >
> >   - Generally, in my naive opinion, I think that decoding pidfs file
> >     handles should be a lot simpler than decoding regular path based
> >     file handles. Because there should be no need to verify any
> >     ancestors, or reconnect paths. Pidfs also doesn't have directory
> >     inodes, only regular inodes. In other words, any dentry is
> >     acceptable.
> >
> >     Essentially, the only thing we need is for exportfs_decode_fh_raw()
> >     to verify that the provided pidfs file handle is resolvable in the
> >     caller's pid namespace. If so we're done. The challenge is how to
> >     nicely plumb this into the code without it sticking out like a sore
> >     thumb.
> 
> Theoretically you should be able to use PIDFD_SELF as well (assuming that
> makes its way into mainline this release :-)) but I am a bit concerned about
> potentially polluting the open_by_handle_at logic with pidfd specificities.
> 
> >   - Pidfs should not be exportable via NFS. It doesn't make sense.
> 
> Hmm, I guess I might have made that possible, though I'm certainly not
> familiar enough with the internals of nfsd to be able to test if I've done
> so.

AFAIK check_export() in fs/nfsd/export.c spells this it out:

	/* There are two requirements on a filesystem to be exportable.
	 * 1:  We must be able to identify the filesystem from a number.
	 *       either a device number (so FS_REQUIRES_DEV needed)
	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
	 * 2:  We must be able to find an inode from a filehandle.
	 *       This means that s_export_op must be set.
	 * 3: We must not currently be on an idmapped mount.
	 */

Granted I've been wrong on account of stale docs before. :$

Though it would be kinda funny if you *could* mess with another
machine's processes over NFS.

--D

> I guess probably this case calls for another export_ops flag? Not like we're
> short on them
> 
> Thanks,
>     - Erin
> 
> 

