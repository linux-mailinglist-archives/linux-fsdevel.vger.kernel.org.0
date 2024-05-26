Return-Path: <linux-fsdevel+bounces-20182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACE8CF4BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8C1F2125E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6817996;
	Sun, 26 May 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FRJ9qJpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57969441
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716737539; cv=none; b=PTjXrAmFadqzYCcGdJ2+5iqzdQXvq7kZP/7gcjvrPmayFrKdVYxgy6PfB5/FGz0GSKs6GLN/tXyYm45XEIIK9WpFYWZv878WtmwYcE4ObC0grdm9oMpuKv2z+xhStABD8wFkmV15/n8j3TglwPLilwan8Lo5BD1bosoLwMhMr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716737539; c=relaxed/simple;
	bh=lQvNSUvSiCfD+RrvE33rDEsdVevKi4vDK/SH0u/rYZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcD0xwSnOvS3qfHCuM3EmfGgJCRX70J8zwlXRPKJISOcGotvSup8/26xsM0YcigQAs/hgo1D7xW5PkneEoPtYOz1iLYo4ID1xfd+8DBQbbLJe7D9t85opDmTaznn7pUu5i2YoDVZwE9jZWFhArpyfbNgu88KDzuxIIKJsWPdMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=FRJ9qJpH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-77.bstnma.fios.verizon.net [173.48.102.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44QFVbf9008400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 May 2024 11:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716737501; bh=2JFYfvBaOODS9yL2D+LtfH9ZP9+hFyaJPRzYMjyfLDA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=FRJ9qJpHApsfGhTO3lvx+a5j3cyc55jMAmzhN3ZjnnH9cuCwqce0Ig24EqXEfs9Vx
	 McVEI24Rw8PDTgFhgtJT9zYIj32LdW7xAoSMvtXHRfJqp36ljsgRdynIo1zoQ/pahl
	 weU7tiRkKJWCegr5pTV7AUjxVsNzwtWmuV/BWVM4LIu+McjG4p47QfFGEq+KTA2Xx3
	 6MxGXqyxBg/I+8z6dVpp7SXaRUNHjIAUGW6KoGE5YEaXxauyWsbD/t25QQQa0a/BG8
	 9K4MN7KfPJxbzfPee6cOTnWOzJUnmoz+vrmoWwt0X8zNrbspuFXYdZdV6pDLd2CDgA
	 4/R08q1a7JYow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 31D5D15C0225; Sun, 26 May 2024 11:31:37 -0400 (EDT)
Date: Sun, 26 May 2024 11:31:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fs: turn inode->i_ctime into a ktime_t
Message-ID: <20240526153137.GI65648@mit.edu>
References: <20240526-ctime-ktime-v1-1-016ca6c1e19a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526-ctime-ktime-v1-1-016ca6c1e19a@kernel.org>

On Sun, May 26, 2024 at 08:20:16AM -0400, Jeff Layton wrote:
> 
> Switch the __i_ctime fields to a single ktime_t. Move the i_generation
> down above i_fsnotify_mask and then move the i_version into the
> resulting 8 byte hole. This shrinks struct inode by 8 bytes total, and
> should improve the cache footprint as the i_version and __i_ctime are
> usually updated together.

So first of all, this patch is a bit confusing because the patch
doens't change __i_ctime, but rather i_ctime_sec and i_ctime_nsec, and
Linus's tree doesn't have those fields.  That's because the base
commit in the patch, a6f48ee9b741, isn't in Linus's tree, and
apparently this patch is dependent on "fs: switch timespec64 fields in
inode to discrete integers"[1].

[1] https://lore.kernel.org/all/20240517-amtime-v1-1-7b804ca4be8f@kernel.org/

> The one downside I can see to switching to a ktime_t is that if someone
> has a filesystem with files on it that has ctimes outside the ktime_t
> range (before ~1678 AD or after ~2262 AD), we won't be able to display
> them properly in stat() without some special treatment. I'm operating
> under the assumption that this is not a practical problem.

There are two additional possible problems with this.  The first is
that if there is a maliciously fuzzed file system with timestamp
outside of ctimes outside of the ktime_t range, this will almost
certainly trigger UBSAN warnings, which will result in Syzkaller
security bugs reported to file system developers.  This can be fixed
by explicitly and clamping ranges whenever converting to ktime_t in
include/linux/fs.h, but that leads to another problem.

The second problem is if the file system converts their on-disk inode
to the in-memory struct inode, and then converts it from the in-memory
to the on-disk inode format, and the timestamp is outside of the
ktime_t range, this could result the on-disk inode having its ctime
field getting corrupted.  Now, *most* of the time, whenver the inode
needs to be written back to disk, the ctime field will be changed
anyway.  However, if there are changes that don't result
userspace-visible changes, but involves internal file system changes
(for example, in case of an online repair or defrag, or a COW snap),
where the file system doesn't set ctime --- and in it's possible that
this might result in the ctime field messed.

We could argue that ctime fields outside of the ktime_t range should
never, ever happen (except for malicious fuzz testing by systems like
syzkaller), and so it could be argued that we don't care(tm), but it's
worth at least a mention in the comments and commit description.  Of
course, a file system which *did* care could work around the problem
by having their own copy of ctime in the file-specific inode, but this
would come at the cost of space saving benefits of this commit.

I'd suspect what I'd do is to add a manual check for an out of range
ctime on-disk, log a warning, and then clamp the ctime to the maximum
ktime_t value, which is what would be returned by stat(2), and then
write that clamped value back to disk if the ctime field doesn't get
set to the current time before it needs to be written back to disk.

Cheers,

					- Ted

