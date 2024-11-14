Return-Path: <linux-fsdevel+bounces-34773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE059C88EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60461F23706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93601F8F0B;
	Thu, 14 Nov 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgPUROV8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205E192D9D;
	Thu, 14 Nov 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583800; cv=none; b=R4AGmqASvR7O1QeNUWX5HgqCMq7fM9BMtYcPKUcxrbxLDjHQC2KTByyYpU+7Gu1inietl1zwgStg5yQuvJK6MzOHmdwi6aF3RGWCCRWYIhHE84GQpWvceZ6zw7y2BBLnNIjpfOpS3LFc7GNPaGUASTVeKfSJhegqkmpKpF0/l14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583800; c=relaxed/simple;
	bh=U/N0EuUWbT7pPql+U1/0JgFFTZ8SFYvbZ5fG9zsUaSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4lNebGF6XalZBh7takLyw1mbkcehStyoc6Ew0DcoR6ptYlLJj5xFF3/LOQ9RrwN6x/QNjvb5ZUzgs5d/C1x0dmuRNbLPAYiH6ZRK7LzmUs/4ZFrLFivA/X+fe5iua1XTlsRnzR33265xL/TnGsAQe8/Je8H4oKm7kSnftLSsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgPUROV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677AC4CECD;
	Thu, 14 Nov 2024 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583799;
	bh=U/N0EuUWbT7pPql+U1/0JgFFTZ8SFYvbZ5fG9zsUaSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgPUROV8SBbR4BmTAOvxVDKKawNc/iXURwmgI4jRRxgqIOmt3ou/RCPaBFvte8RTw
	 KdVWINQATghuNp5qQL/ekFmKugN6FG5NAfkUpzrq0RR2uq40XWdlMzeOzN7IPrUqSI
	 7Z47od/ioF1BEzijTLGScAQgKH9sXviOUj1ZJpo5d+1xqBK0kK5Oi7n5ULOsxw2qpv
	 JN71i8E9a0tMD2sA5PpD2wLkAuhOu1j6DEPpn0Zlyp1BFtJIc0gpTAWCbfbGij22mg
	 14z60sVhWvX/gkVndAu8QQ4l9yCnI84um5N7NF6gEbkNAMlhyXs1SiJ6tBX6NxL9oV
	 VsiKQu7cA58Eg==
Date: Thu, 14 Nov 2024 12:29:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Karel Zak <kzak@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241114-umzog-garage-b1c1bb8b80f2@brauner>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>

On Wed, Nov 13, 2024 at 08:45:06AM -0500, Jeff Layton wrote:
> On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > > On Mon, 11 Nov 2024 10:09:54 -0500, Jeff Layton wrote:
> > > > Meta has some internal logging that scrapes /proc/self/mountinfo today.
> > > > I'd like to convert it to use listmount()/statmount(), so we can do a
> > > > better job of monitoring with containers. We're missing some fields
> > > > though. This patchset adds them.
> > > > 
> > > > 
> > > 
> > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Jeff, thank you for this!
> > 
> > I have already implemented support for statmount() and listmount() in
> > libmount (PR: https://github.com/util-linux/util-linux/pull/3092). The
> > only remaining issue was the mount source and incomplete file system
> > type.
> > 
> 
> Unfortunately, I think we might be missing something else:
> 
> The mountinfo (and "mounts") file generator calls show_sb_opts() which
> generates some strings from the sb->s_flags field and then calls
> security_sb_show_options(). statmount() will give you the s_flags field
> (or an equivalent), but it doesn't give you the security options
> string. So, those aren't currently visible from statmount().
> 
> How should we expose those? Should we create a new statmount string
> field and populate it, or is it better to just tack them onto the end
> of the statmount.mnt_opts string?

I'm leaning towards using a separate field because mnt_opts/opts_array
is about filesystem specific mount options whereas the security mount
options are somewhat generic. So it's easy to tell them apart.

