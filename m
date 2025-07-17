Return-Path: <linux-fsdevel+bounces-55313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639F8B097CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52430561D63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58C258CE5;
	Thu, 17 Jul 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuC9TAsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB8252906;
	Thu, 17 Jul 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794780; cv=none; b=qSgASztv+NwQBIJBEbw8Rjz7kN2SqyU/ZdUuN1ZSr8W33V+ROj9x8QwqtBIZlAKjjJP3mHwTMYokOhq+6OJ8VsSPXJ3BIuG8M0roQCWEOOBWbki6XyJcacSQUr68GKBxqL4qZTC2v+HiJ/9ySFcI/w9KZbsvknIq2UA9VJSkGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794780; c=relaxed/simple;
	bh=FVXg1hTwsTjaOuUevup9qGBuOObqfH3EAhAaBRCShWQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdw17MBSRNQ24W/q6u/KysYxWBfWdLoSJI4epe/lfHM6115l95Ii87VkE99TQi97JjcdaC0gTybLPC3PjApmAzQQk/nv22ln38kD0s6Qo7hfyH9tgcEzfakeR2Lhx8S3eO+ls4kTSCIP9OfJz+cpn+JZT9BqPxslSVaQBqqe5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuC9TAsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673E2C4CEE3;
	Thu, 17 Jul 2025 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794780;
	bh=FVXg1hTwsTjaOuUevup9qGBuOObqfH3EAhAaBRCShWQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XuC9TAsyu5vULG7L96J5LBUQtHqIZlSw5IgjaiOJdL4E3Anqp+dNRt8XEcsw76hrd
	 9rFrhZdpJajBmoUMQ1oAVCOpLLMxRzCSaOWyvfGlLPlT32k6FfjUtCGj/M1JrqYnvw
	 b0kaepmExzxVkXAA2oxVpRcjR404FKGgbLFu5pZ5hN4PnbtY+vy3bV5QqCg5TkcyAl
	 ZMjjAWBfd+cLvTyyyiSzNLJwdzXwQ5SQrPEcf16yb8Xbzb6vjdmQmbfzV74U8C6ewR
	 q4zjNqkR2xyC1WREmZvAl9m8KXY+0vqdnr9SQDVjFcGBWkbwhfsrdhgRRxfewyyoBy
	 lhzCBARdhog/Q==
Date: Thu, 17 Jul 2025 16:26:19 -0700
Subject: [PATCHSET RFC v3 3/3] fuse2fs: handle timestamps and ACLs correctly
 when iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
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

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-attrs
---
Commits in this patchset:
 * fuse2fs: allow O_APPEND and O_TRUNC opens
 * fuse2fs: skip permission checking on utimens when iomap is enabled
 * fuse2fs: let the kernel tell us about acl/mode updates
 * fuse2fs: better debugging for file mode updates
 * fuse2fs: debug timestamp updates
 * fuse2fs: use coarse timestamps for iomap mode
 * fuse2fs: add tracing for retrieving timestamps
 * fuse2fs: enable syncfs
 * fuse2fs: skip the gdt write in op_destroy if syncfs is working
 * fuse2fs: implement statx
---
 misc/fuse2fs.c |  348 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 276 insertions(+), 72 deletions(-)


