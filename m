Return-Path: <linux-fsdevel+bounces-55307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E14B09736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49297B480D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1B247291;
	Thu, 17 Jul 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+nYNybA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8732AEF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794686; cv=none; b=iLf1+7uXF4+mBjoEdhgvAUwUzu8Z9m25/3kdUaahVlsC9v375WcoffWMuCdYKvluLun7PJOVT97SdnNf8Keb/nH36MREDzc1/cxZ/OC/Fk1YGPK4nC5Wxm1FnNmwx0atTt6cAxL3djYntmXmYrYAVRVJstgBcLBGoGontPRRwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794686; c=relaxed/simple;
	bh=aAW1efw2m7OfKpi37pUj44ui/eDMkfoWgDJ/rI0qnYQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe/+C7Vz8XvoA6ExHeFO4qbEngTWe6Ke1fLN3osjbp2WkjUt/HRT+mVsA9ogazuDoxAU/T04t80MT1bN6EmT6aLsxAbIa8Z7HYzgImAkkYvL699ERUaQ81y8s+mD1eaLbNtjFVB912148brtO1N9bDfC906+0NS0yHg20kaNIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+nYNybA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B62C4CEE3;
	Thu, 17 Jul 2025 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794686;
	bh=aAW1efw2m7OfKpi37pUj44ui/eDMkfoWgDJ/rI0qnYQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=P+nYNybAWsX5Irb9Ce6OsVCM5HAwPLGcAbO7xAQ0Z5nPinNzE1+Ei+lxblaoRucKA
	 t0MDudOmLwnAWpuuNsnPG0xTE+SBDdpORTONqBBNIZauEX37v3KDnWs+QlPgihq/es
	 Sw9VUksOhSdP/K1wTt0QTr0JavJsHTEjhM9rdqP6w7paH0BXY8L+XOjcpDTYdntQ1L
	 JKmeCCrid3g3s6tTcDddlKoW7aGgyN+nvqSMImmNQ/xk9/qXBksbePLqtf4wdXv26M
	 NX0XF8aWLv0No29dfoYu6ZTdfj5Yv1hZiorKSYcW0ryO+TdXwnB5EJiFuoLIxQmASH
	 IawDzEE/MuvgQ==
Date: Thu, 17 Jul 2025 16:24:45 -0700
Subject: [PATCHSET RFC v3 4/4] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
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
 * fuse: force a ctime update after a fileattr_set call when in iomap mode
 * fuse: synchronize inode->i_flags after fileattr_[gs]et
 * fuse: cache atime when in iomap mode
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
---
 fs/fuse/fuse_i.h     |    5 ++
 fs/fuse/fuse_trace.h |  103 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/acl.c        |  104 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |  113 ++++++++++++++++++++++++++++++++++++++------------
 fs/fuse/inode.c      |   20 ++++++++-
 fs/fuse/ioctl.c      |  100 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 415 insertions(+), 30 deletions(-)


