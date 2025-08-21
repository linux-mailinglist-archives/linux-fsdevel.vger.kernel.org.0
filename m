Return-Path: <linux-fsdevel+bounces-58424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EAB2E9AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABACC7BA2F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE21E493C;
	Thu, 21 Aug 2025 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVGe+AUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20381DDA15
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737282; cv=none; b=rvzNN+nx3jqtaoPoiXPKDk7lx+6Nwzlyk459/ONC7+USnnMEKvyME8zks0eyar8NReKHvXoXH+5NquwHrr47Qmmj+ez6kTfbYbklICJd3ny4iUD5tL9r9aAlfa0tN8fvymuWutDQjXn7C6hHo+nfX/pM6a+Bcf2JZOSnEnC8TAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737282; c=relaxed/simple;
	bh=0da6TpeIV8SNJacoczQNiyhG+o/yEh0X79lvFy0SLqw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBZMvsCxSTbl0c56sv5XQrb5aWq9/hrczrZ/rjUzDXKjS50s/EuMSUaU9RNN3LP+ZaHVgQTo85kN7lEUtoUBIsDv6L3JOLXDrFv2K8XMStHjX0hwr3KKbQZ8SsVPrzWwM3RCknDUbFIkK1KZ16z1pBgc5QZY4yoBB16aMNCMZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVGe+AUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AC1C4CEE7;
	Thu, 21 Aug 2025 00:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737282;
	bh=0da6TpeIV8SNJacoczQNiyhG+o/yEh0X79lvFy0SLqw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XVGe+AUALAhS+FSAvKgsLFdHA0uA89SZTVIEjSMNSwcaJnPeH7GIMGRL80L5ylG+6
	 dLiEL8Ddq8hr31vx5S2UD+mpqxHURBTdNN4hMY7YdOpDUvrrZWaUlCa0QskMj19FTl
	 4+56FwCklki/VOh+NgNLPYnQT0VyHRg8Fu23bjSoe5gtSAYVUU1KGcC4nyOk5AYq2/
	 ggPVgy0hvpu12v83KuGjP3LWNHz1yE+FrR5J9Vnw1LYuKCcDSnGoSsqZRgFQEOkKQ1
	 WglzpLg69SnWmMzsxaX6CK6CPoZA2SLF0gjTrKJzpL/VjGpHpRg5rDTkP7McQ5DGt7
	 2u0aCrnDVsbDQ==
Date: Wed, 20 Aug 2025 17:48:01 -0700
Subject: [PATCHSET RFC v4 4/4] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
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
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
 * fuse: always cache ACLs when using iomap
---
 fs/fuse/fuse_i.h     |    1 
 fs/fuse/fuse_trace.h |   81 ++++++++++++++++++++++++++++++++++++++++
 fs/fuse/acl.c        |   24 ++++++++++--
 fs/fuse/dir.c        |   32 +++++++++++++---
 fs/fuse/inode.c      |   20 ++++++++--
 fs/fuse/ioctl.c      |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c    |    3 +
 7 files changed, 249 insertions(+), 13 deletions(-)


