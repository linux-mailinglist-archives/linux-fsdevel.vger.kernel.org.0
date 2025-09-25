Return-Path: <linux-fsdevel+bounces-62682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF47B9CE49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D44064E24AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795927FB2E;
	Thu, 25 Sep 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u3z94Cvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896091397;
	Thu, 25 Sep 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760146; cv=none; b=AT1x/gOQNNpXt1h46bS5n9s1AnoYg9p+Pm0Y9wjtrtKsG67L5zr3qZGeTi3dI7UOjzDH9De47KLSeotcq+opYO86axt2Kpbkn9gMXIkOd2Mx2X38toH6xiVKA4hk8sCqCctjhv20cJNcLFKcZf+YO1CeTCphO9SIhk41sXnCt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760146; c=relaxed/simple;
	bh=JOLyTci2jhlHylpFHS2SQ1hkHixd4y+lzKe14XXJPj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6/xCoRTmfb1d/cC1/gUE/9FFIMrb9LVeAtuXyYYt7JjIBDfAA6VItrbBmruteORlOrvw0rWZ8ewcFtepp7Xe2r6lS2PkYfyEdHsdBm/IeX1Qyp2I9+eNYe8YRTwA+ex9+yCWwRj3AEBP4avZjHO8e3r7tw1OGX9r1E5ShlNLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u3z94Cvw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=atDadg8qyigr65Lj2KbkDT+91ol7m21qXi4RXygURPc=; b=u3z94Cvw5RNXzZnC6AvEYnSOxY
	31liqITirMLQ6zeyTYgT0ZD7sqEDTnUKn7kOuFp6pMzvdq4KLduGk0nFHicbxRuIYz74l7cRBur1E
	jTlUEKuVwoFCK2NPK4mgdDjv69FVbpu5k7l/G/oipX8f2RJV3qyIiCZ5G1CwrmMqEnNwXdmrZnYC1
	OpOe9Iv39LXdsWRIjEkO1ROeDMuzCj9SiIv9Y/yK2gJ2aF0wgBeQiTVGLjdWO8vMjIgoZnT46X1yF
	87srfzt4j7SOJgxHOiiwnC45qoi5eL1v0Q94NXRUR/EXScywrCN/z1F0qNWI/B0HBwFrwvFjDcNe0
	dG8nOlGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Zr3-0000000EAsF-1EiS;
	Thu, 25 Sep 2025 00:29:01 +0000
Date: Thu, 25 Sep 2025 01:29:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	kpsingh@kernel.org, john.fastabend@gmail.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Message-ID: <20250925002901.GX39973@ZenIV>
References: <20250924232434.74761-1-dwindsor@gmail.com>
 <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV>
 <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 08:08:03PM -0400, David Windsor wrote:
> On Wed, Sep 24, 2025 at 7:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > > Add six new BPF kfuncs that enable BPF LSM programs to safely interact
> > > with dentry objects:
> > >
> > > - bpf_dget(): Acquire reference on dentry
> > > - bpf_dput(): Release reference on dentry
> > > - bpf_dget_parent(): Get referenced parent dentry
> > > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > > - bpf_file_dentry(): Get dentry from file
> > > - bpf_file_vfsmount(): Get vfsmount from file
> > >
> > > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
> >
> > You have an interesting definition of safety.
> >
> > We are *NOT* letting random out-of-tree code play around with the
> > lifetime rules for core objects.
> >
> 
> File references are already exposed to bpf (bpf_get_task_exe_file,
> bpf_put_file) with the same KF_ACQUIRE|KF_RELEASE semantics. These
> follow the same pattern and are also LSM-only.

You can safely clone and retain file references.  You can't do that
to dentries unless you are guaranteed an active reference to superblock
to stay around for as long as you are retaining those.  Note that
LSM hooks might be called with ->s_umount held by caller, so the locking
environment for superblocks depends upon the hook in question.

