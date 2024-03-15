Return-Path: <linux-fsdevel+bounces-14457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252C87CE62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C99283046
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435336B04;
	Fri, 15 Mar 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqzhkH+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028D1BF28;
	Fri, 15 Mar 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510751; cv=none; b=tyK6kWTR47P7OgCXIoVttOsR01TODiI4PMzcjQEGrtSmNJ2JpA7UnPg6d+RnZ6TMDVVyq26BMWDveuUrc3wd6Y+VmBb9+MycYL3euGtha0eHBCKLDCmHlMGO14B/6rIaXkOIQ0ckZBBvNZN9TjT3xFBNSSlwR6p9NThL7GqJMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510751; c=relaxed/simple;
	bh=AwIVao3rL1Q0k95nqbmA9y6yqrp6LGbk8gB2bmRe7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taeTNxw00RvkGCdDWgHYwcqBVGsdzARCzw0oCSyNtTH/T0wY42HvbhKhmBE094zugFdz8huq37O8rhfasfNTHFPbUf1P4PpUJWgbZrMvc+J8qK2KED6/hyRw8h5vY14n16ph1MfwcVgr1vOCT5tCxtW2SXifB6SfeCnIl/ttje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqzhkH+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09DAC433F1;
	Fri, 15 Mar 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710510750;
	bh=AwIVao3rL1Q0k95nqbmA9y6yqrp6LGbk8gB2bmRe7uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqzhkH+oA5Y2fdTLJi8P7w3/r/btamKmCo690KIn0ZIru45tU+mFtEtMiGSX5ypl3
	 eag+OprokOmKCLgl2aoLS2XP8c22mUJCeYuhzqPDQKZKotfiaHFSMbXoHafhzQ0lUF
	 b0ir/DnTenexQYigIBvpmNaNILaV6Ms5+c50uObeXes8h8ocxmea6QGAv9wWj1fKus
	 iJ2l+PrwBcmk9hOfcK2YZhzxZsRpnlzO7bVQpYkBGQiqv2S9F6m15Cfcf8rnMFUoOh
	 1fpt0GgXfkjKW4maiZuN4RnGAx7JVqk09IsKrg3GpmBhIfJ+InRsJWFbse65QceJTs
	 JaRfYJRY7AatQ==
Date: Fri, 15 Mar 2024 14:52:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Michael Forney <mforney@mforney.org>, Jan Kara <jack@suse.cz>, 
	Theodore Ts'o <tytso@mit.edu>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Yang Xu <xuyang2018.jy@fujitsu.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20240315-hasst-anmachen-4c9e89a56840@brauner>
References: <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu>
 <20231011172606.mztqyvclq6hq2qa2@quack3>
 <20231012142918.GB255452@mit.edu>
 <20231012144246.h3mklfe52gwacrr6@quack3>
 <28DSITL9912E1.2LSZUVTGTO52Q@mforney.org>
 <CAKPOu+910gjDp9Lk3sW=CmTM8j_FHEYyfH-kQKz-piRJHkQiDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+910gjDp9Lk3sW=CmTM8j_FHEYyfH-kQKz-piRJHkQiDw@mail.gmail.com>

On Thu, Mar 14, 2024 at 02:08:04PM +0100, Max Kellermann wrote:
> On Wed, Mar 13, 2024 at 9:39 PM Michael Forney <mforney@mforney.org> wrote:
> > Turns out that symlinks are inheriting umask on my system (which
> > has CONFIG_EXT4_FS_POSIX_ACL=n):
> >
> > $ umask 022
> > $ ln -s target symlink
> > $ ls -l symlink
> > lrwxr-xr-x    1 michael  michael           6 Mar 13 13:28 symlink -> target
> > $
> >
> > Looking at the referenced functions, posix_acl_create() returns
> > early before applying umask for symlinks, but ext4_init_acl() now
> > applies the umask unconditionally.
> 
> Indeed, I forgot to exclude symlinks from this - sorry for the breakage.
> 
> > After reverting this commit, it works correctly. I am also unable
> > to reproduce the mentioned issue with O_TMPFILE after reverting the
> > commit. It seems that the bug was fixed properly in ac6800e279a2
> > ('fs: Add missing umask strip in vfs_tmpfile'), and all branches
> > that have this ext4_init_acl patch already had ac6800e279a2 backported.
> 
> I can post a patch that adds the missing check or a revert - what do
> the FS maintainers prefer?

If it works correctly with a revert we should remove the code rather
than adding more code to handle a special case.

> 
> (There was a bug with O_TMPFILE ignoring umasks years ago - I first
> posted the patch in 2018 or so - but by the time my patch actually got
> merged, the bug had already been fixed somewhere else IIRC.)

Yeah, we fixed it a while ago and then I added generic VFS level umask
handling but POSIX ACL are hurting us because they're a massive layering
violation on that front.


