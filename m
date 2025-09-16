Return-Path: <linux-fsdevel+bounces-61476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03365B58909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BEF1B21A7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D019F43A;
	Tue, 16 Sep 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjNx0Nct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF219CC28;
	Tue, 16 Sep 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981977; cv=none; b=dizLcw6AHyjFxuQ/myZkQDxQ2BYeRFhnakwGhBZdfU5CENyU+mGDnyNmq2KgBu/+6ZVU885b9mdB+cl7BJG6FAC4S4iMheAtgjgrTN+qriLqSrTLi1QvTx174rCSFtIpDZbfeo/KL6F+D23nzicse6Bos2v7WZvDCuTxyBIjhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981977; c=relaxed/simple;
	bh=pqsLfXTWHwxvZA8BkWYgWOmeHOsE+HB7OBJnECj+MRc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYcey4nc8PbL2tdhG82bDoTzYdHe3OIw0EmcyxtQJ0zYutzF7vePb99K9+U72NiRvHk2FSKGkQ3gF2PjlbT9swT5HM0M7FJ0RX58KL1xs4FeHpRmBYydSSLp9DSkU8X+2+6TbyFP5CBgyYGcpAUpeBgH04fSapCforBrK5rJMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjNx0Nct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A2C4CEF1;
	Tue, 16 Sep 2025 00:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981976;
	bh=pqsLfXTWHwxvZA8BkWYgWOmeHOsE+HB7OBJnECj+MRc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IjNx0NctS2bNdO46cV8FCXjkQzkvOcQbYBTIhiTUaWnex/7plv3EduNV6xdjrbwly
	 Fw0LEc1ILyJut9xI1MNyldbuwH6UAE5404EIkbRr6KK6By108pr0cTOO8S/bM+H3ZK
	 usHgBRiKu4hLlg2XL4KFI01LxO0ZLXx282p69j+nFkCuF8Okfi0ox7318Vn6HFV8RA
	 TuSZOx18F4VIF46OhOB5cD3Gw1AhTYqyz+C7Rhdt3CK6MEspuCT61SqnG0CYxSFXUB
	 I+rTI+ShbQuHZbunZysnFatXnLDdFZ6vFe0z+PNRq2f67fKkbfvC5Hw3g8nOM9FsPn
	 CQnRadwPZ6gEg==
Date: Mon, 15 Sep 2025 17:19:36 -0700
Subject: [PATCHSET RFC v5 6/8] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * fuse: enable caching of timestamps
 * fuse: force a ctime update after a fileattr_set call when in iomap mode
 * fuse: allow local filesystems to set some VFS iflags
 * fuse_trace: allow local filesystems to set some VFS iflags
 * fuse: cache atime when in iomap mode
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
 * fuse: always cache ACLs when using iomap
---
 fs/fuse/fuse_i.h          |    1 +
 fs/fuse/fuse_trace.h      |   87 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |    8 ++++
 fs/fuse/acl.c             |   29 +++++++++++++--
 fs/fuse/dir.c             |   38 ++++++++++++++++----
 fs/fuse/file.c            |   18 ++++++---
 fs/fuse/file_iomap.c      |    6 +++
 fs/fuse/inode.c           |   27 +++++++++++---
 fs/fuse/ioctl.c           |   70 ++++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c         |    3 +-
 10 files changed, 263 insertions(+), 24 deletions(-)


