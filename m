Return-Path: <linux-fsdevel+bounces-65990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D818AC17969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82848355D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1EA2D1932;
	Wed, 29 Oct 2025 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fagjR+9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D332D0C64;
	Wed, 29 Oct 2025 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698510; cv=none; b=NYRG0g5LsF41Tg6StlODV6SshmEKI0CT7XsK+l2BzsC07uu/QVXs63RyZVB+RSR4szx5qWfJVl88JC8HOTbBsMTUhUzUmGATVjO+Z4O9NoGlXUJUJAFoampGSLuZs6gYcDsANCqkDTnaBnhbsWTWnniQzgZlckRuQwOsOo2ft2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698510; c=relaxed/simple;
	bh=ZF/1CanIlRiBbsd+5dwew3xdRoWz8KwbtRvdFC3x664=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxVFUSSemDYwlgbJ1ek9oDp37VO5ffatQELWdEoX8rVUyhve9xe6Q0j6WQmTSq7kdWUaTZ2/FuKyw45Xbfg+OjYs+hO6f7aN5D+BbWumSVRbOzxuiqLQoLALXNTADScRtf3T3Y1DuxcgJRP8EH7+euKELZpZdp6LbqsN3YWa/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fagjR+9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75242C4CEE7;
	Wed, 29 Oct 2025 00:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698510;
	bh=ZF/1CanIlRiBbsd+5dwew3xdRoWz8KwbtRvdFC3x664=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fagjR+9ZourzaFkuFcIdjMIfHTPGllnveFDN+iAmuWX+BxlpVZfKaQfXARFyrJ+Ly
	 NWbz4skcEcVOmviO04VwllOjO2Fq1RC29QqHgLE13WX3oQsJbG+K6P6LyEh4U6BIpP
	 X4eXcjBGjGbMdHU8WPUFafsSAadagNGGBh6JRlxfZU3NPtcqyGiy9jyrwXzEqEZWaN
	 1xtVQ6Ou/osCsxF+7mnBVeIePeqRJqObYnpGQhPgjrboMdUsw7VyRGubpuJtMsIx7l
	 /ims1i5jlyx2llts695N57MzsAPuWEBCgGmYzRlj8rAmDsLy2eLC8xlcB0GuNohkTy
	 y1TiLljX1xjeg==
Date: Tue, 28 Oct 2025 17:41:50 -0700
Subject: [PATCHSET v6 3/6] fuse2fs: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
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

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-attrs
---
Commits in this patchset:
 * fuse2fs: add strictatime/lazytime mount options
 * fuse2fs: skip permission checking on utimens when iomap is enabled
 * fuse2fs: let the kernel tell us about acl/mode updates
 * fuse2fs: better debugging for file mode updates
 * fuse2fs: debug timestamp updates
 * fuse2fs: use coarse timestamps for iomap mode
 * fuse2fs: add tracing for retrieving timestamps
 * fuse2fs: enable syncfs
 * fuse2fs: skip the gdt write in op_destroy if syncfs is working
 * fuse2fs: set sync, immutable, and append at file load time
 * fuse4fs: increase attribute timeout in iomap mode
---
 fuse4fs/fuse4fs.1.in |    6 +
 fuse4fs/fuse4fs.c    |  245 ++++++++++++++++++++++++++++++-----------
 misc/fuse2fs.1.in    |    6 +
 misc/fuse2fs.c       |  301 ++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 421 insertions(+), 137 deletions(-)


