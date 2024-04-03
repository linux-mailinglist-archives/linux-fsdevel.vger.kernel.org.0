Return-Path: <linux-fsdevel+bounces-15978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B889666F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C667B1C22AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA195C901;
	Wed,  3 Apr 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="RMMhudxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843EB55C29;
	Wed,  3 Apr 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129586; cv=none; b=ohEPCj9LHhuDanS9G+EhOjYcVnwreUL+v539Zz+BtPonw04QhjpQi2Uq3C9UqwEvrksEga6I7MjcpVKeK7b1NhwBry8DWcB+gysTd9Mk/DoO51hAUtvrpx5EdExpO9K9ItAltAWhcQzTKsC127hC6GBaMXijqiMKiHY3wVEWWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129586; c=relaxed/simple;
	bh=B8T21JVbOLWLZIWqX9Kk4W8YEBxzK1vo2nUprAs1Et0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YnT6QxSRgbiqiRKQfkis86dC+IJOzeXrihvd/oiWkyF3ZBofhW2c6FuKVERmSR98exLdXRZ8ELgB1LrNI+2mnqE2mSU5DHaHu+ilHsoKkI1xzqaHhTZuaMkOuCKhinM+ROfh9rbxe/j4zWegmqYhaKw+DrjvptYWUk3bzKccXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=RMMhudxb; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 83D2B807A2;
	Wed,  3 Apr 2024 03:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129583; bh=B8T21JVbOLWLZIWqX9Kk4W8YEBxzK1vo2nUprAs1Et0=;
	h=From:To:Subject:Date:From;
	b=RMMhudxb7EIzCkqtHOmFwCDPbzgbWgn5vp8COLdnfwf+qsRdUrHavuwlRc5bMVEiY
	 kgw67uVuJhjs63x2OaL8IC0tPgouh2AcqwdGCEWhTb0V7eUhPxFrhru47kQh7HeJWE
	 t2+MhGmN22+WGDmkykhpSjR9PhQJTk/Ep//iqUjzwTzOsSU6sq4vsvZfyhow8doZ7o
	 YhR7ehQgYH/ByQMLhSyFGRFnpzJKYoUFAaoDiZASvkHxaV54iofPU6PSNKQFMJWjB0
	 8EOfG2D66AkPESDO8GJmrHFQfKL9137B2ksLw3d3FgnT9Fd+KFJNw/QioT2Nr/hMha
	 orctZOIBXFCvQ==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 00/13] fiemap extension for more physical information
Date: Wed,  3 Apr 2024 03:22:41 -0400
Message-ID: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For many years, various btrfs users have written programs to discover
the actual disk space used by files, using root-only interfaces.
However, this information is a great fit for fiemap: it is inherently
tied to extent information, all filesystems can use it, and the
capabilities required for FIEMAP make sense for this additional
information also.

Hence, this patchset adds various additional information to fiemap,
and extends filesystems (but not iomap) to return it.  This uses some of
the reserved padding in the fiemap extent structure, so programs unaware
of the changes will be unaffected.

This is based on next-20240403. I've tested the btrfs part of this with
the standard btrfs testing matrix locally and manually, and done minimal
testing of the non-btrfs parts.

I'm unsure whether btrfs should be returning the entire physical extent
referenced by a particular logical range, or just the part of the
physical extent referenced by that range. The v2 thread has a discussion
of this.

Changelog:

v3: 
 - Adapted all the direct users of fiemap, except iomap, to emit
   the new fiemap information, as far as I understand the other
   filesystems.

v2:
 - Adopted PHYS_LEN flag and COMPRESSED flag from the previous version,
   as per Andreas Dilger' comment.
   https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
 - https://lore.kernel.org/linux-fsdevel/cover.1711588701.git.sweettea-kernel@dorminy.me/T/#t

v1: https://lore.kernel.org/linux-fsdevel/20240315030334.GQ6184@frogsfrogsfrogs/T/#t

Sweet Tea Dorminy (13):
  fs: fiemap: add physical_length field to extents
  fs: fiemap: update fiemap_fill_next_extent() signature
  fs: fiemap: add new COMPRESSED extent state
  btrfs: fiemap: emit new COMPRESSED state.
  btrfs: fiemap: return extent physical size
  nilfs2: fiemap: return correct extent physical length
  ext4: fiemap: return correct extent physical length
  f2fs: fiemap: add physical length to trace_f2fs_fiemap
  f2fs: fiemap: return correct extent physical length
  ocfs2: fiemap: return correct extent physical length
  bcachefs: fiemap: return correct extent physical length
  f2fs: fiemap: emit new COMPRESSED state
  bcachefs: fiemap: emit new COMPRESSED state

 Documentation/filesystems/fiemap.rst | 35 ++++++++++----
 fs/bcachefs/fs.c                     | 17 +++++--
 fs/btrfs/extent_io.c                 | 72 ++++++++++++++++++----------
 fs/ext4/extents.c                    |  3 +-
 fs/f2fs/data.c                       | 36 +++++++++-----
 fs/f2fs/inline.c                     |  7 +--
 fs/ioctl.c                           | 11 +++--
 fs/iomap/fiemap.c                    |  2 +-
 fs/nilfs2/inode.c                    | 18 ++++---
 fs/ntfs3/frecord.c                   |  7 +--
 fs/ocfs2/extent_map.c                | 10 ++--
 fs/smb/client/smb2ops.c              |  1 +
 include/linux/fiemap.h               |  2 +-
 include/trace/events/f2fs.h          | 10 ++--
 include/uapi/linux/fiemap.h          | 34 ++++++++++---
 15 files changed, 178 insertions(+), 87 deletions(-)


base-commit: 75e31f66adc4c8d049e8aac1f079c1639294cd65
-- 
2.43.0


