Return-Path: <linux-fsdevel+bounces-59450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5152B38F71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E10686211
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59C2DAFDF;
	Thu, 28 Aug 2025 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LTk6dtxF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C46301025;
	Thu, 28 Aug 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339207; cv=none; b=fDpJK/mqg7mzJ0hgkoYVpN54zUmLcXkiuVuRx76jcqYM34AtCRhNaRwwb3PRec4AE+N4KxpC6e4RW9bf+Mz7dEs6SRhTL597mjxvYaDSW6NiyVdzengS/jh6asYHbhiFrrVNifEHqpaVSHbTjqx+t1ARHy+LGerS7iwNy8Y3SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339207; c=relaxed/simple;
	bh=Q4v/KtQIEGMF5TA8ykaROJdz7tLsh6ytToynrfh4DSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U4Dfy2bbMgncFWMwz2nfNTwNg9yopcDOKeyyFDmVk+Z+PDRxPjwMM7fATNgzknUXfvPTjCnL5JCIdb9HSfWNcSkkSMO/PHTpXWkIkYjEHm285GHGJ4Pcr+1ZRmfCyywmsofuRSzBQR1lI97GVFe6ecpwMOakGdZ1HqsEIq5VaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LTk6dtxF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=d9ADrzQZZuxxe2zg+lhdBpfQA35RntwTSUVJdIjjTvo=; b=LTk6dtxFt73XO6hNcYkUbZJ77l
	iTqkI6njMzScU9YZeOBgyb4TgCO+C/S6M6TBW8KqlSZkhdFmbnb4tkpo+3bHFT/yW4CeAPWRr3o3U
	/bOB72/9va9g7xytO9Bjw0WbT1Xf6wyzuEFhchxaIBQ25YNmFKrOLrkDegEQW8Ck7JwMyRCI7O7sz
	DELSqBUTm94GVfNd2QURmNKXyOxxD1n8xoZoYxrS0VSC+i5E+3T9zrBEpDIxaBj2l9yMw8ZcuXIQT
	PM8qZHnzQUOjwDXBgKw0XroyNZkkzjIHSl4ZFh5xbSpf4yz+LIhgXAELbROyxz0g678UZ5vtkjgsc
	VAx51ZmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urQ3d-0000000CdL7-0epU;
	Thu, 28 Aug 2025 00:00:01 +0000
Date: Thu, 28 Aug 2025 01:00:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCHES] fs_context stuff
Message-ID: <20250828000001.GY39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	That stuff had been discussed last cycle, didn't make it into
-next back then.  If nobody objects, I'm throwing that branch into
#for-next.

	vfs_parse_fs_string() calling conventions are inconvenient;
it takes string and length, and just about every caller (with only two
exceptions) passes string, strlen(string).

	Proposal: introduce vfs_parse_fs_qstr() for those that want
the generic form (and pass &QSTR_LEN(string, length) as its argument)
and lose the length argument of vfs_parse_fs_string().

	Callers are happier that way.  The first commit in the series does
the calling convention change and converts existing users; the second one
converts a couple of open-coded vfs_parse_fs_string() in do_nfs4_mount()
to that primitive.  A lot more readable that way, IMO...

	Branch (-rc1-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fs_context
Individual patches in followups.

	Please, review.  If there's no objections, into -next it goes...

Shortlog:
Al Viro (2):
      change the calling conventions for vfs_parse_fs_string()
      do_nfs4_mount(): switch to vfs_parse_fs_string()

Diffstat:
 Documentation/filesystems/mount_api.rst | 10 +++++++-
 Documentation/filesystems/porting.rst   | 10 ++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c   |  9 ++-----
 drivers/gpu/drm/v3d/v3d_gemfs.c         |  9 ++-----
 fs/afs/mntpt.c                          |  3 ++-
 fs/fs_context.c                         | 17 ++++++-------
 fs/namespace.c                          |  8 +++---
 fs/nfs/fs_context.c                     |  3 +--
 fs/nfs/namespace.c                      |  3 ++-
 fs/nfs/nfs4super.c                      | 44 +++++++++------------------------
 fs/smb/client/fs_context.c              |  4 +--
 include/linux/fs_context.h              |  9 +++++--
 kernel/trace/trace.c                    |  3 +--
 13 files changed, 58 insertions(+), 74 deletions(-)

