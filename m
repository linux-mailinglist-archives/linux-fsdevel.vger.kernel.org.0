Return-Path: <linux-fsdevel+bounces-65982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B8C17936
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403541C67A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927262D0600;
	Wed, 29 Oct 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyR835hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF05260587;
	Wed, 29 Oct 2025 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698386; cv=none; b=fMAqdjjparikcMtIXQXC879/HjX5KIa40HerOlxvQefcSJGfd9K5aqP7vnIgDGiBPVwIRrZdCHgPuUINEBibwYbDwyYN+QlZ5oFTOLgG8jXTnn+NZcKi3i1Kqt8GiUhVop1BO4B3AQsd9hscc4ZhSfisujWy+TcUGWrt5MNpatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698386; c=relaxed/simple;
	bh=cV85r8TI58ghQWVOM9oRzPnpN9ZwFUBp8GADB45qry4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpI7xrwyEAcCMlrPW8sgpiAkoaY5LqyZ9yXwQfJ7IiDIGxqtWFNDdK/hCx3euGk1Xmbh3iCQm4+jDwkS0BKyzKej19Q1Brzykdu6eVVD+5SmECBg+iOGZWhQPUJLg66KOmZS8vPANgOr6vppSi9XhklhdrWnbM53G5YQqfyXDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyR835hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEEBC4CEFD;
	Wed, 29 Oct 2025 00:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698385;
	bh=cV85r8TI58ghQWVOM9oRzPnpN9ZwFUBp8GADB45qry4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uyR835hfInbhT3ApRWmQbsV5YK4i63NovI0hOjD2Aw4QnaaXML8/icBX1Quh7gm2V
	 OGWRJ0/7/1a4sQS3FaaNenlm0GeF1jqlpS/TN5leDkzZhmK+82Y38YoJJiOnvkAp54
	 +vg3tBfwcHIVX6V/LQyu9/Mzt71pJmhqIqOUJG7CN5pOJ4Q7pTu+GdOZ4xCuRna/Pi
	 Tz1kHj/+E0x0Hg1RPynkRy/HAN1uydoLzAy93oRdfpjuQw070Vk97/x0KhPDBmEo3m
	 r7ozNT6PevtKxl9ibx9RrcP88pt/z6hkW+cDUiV/pH3uMQw8cPumfia5lDNpelS08r
	 F5EbcVrqb8m1A==
Date: Tue, 28 Oct 2025 17:39:45 -0700
Subject: [PATCHSET v6 8/8] fuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812502.1427080.11949246505492038165.stgit@frogsfrogsfrogs>
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

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.  As part of the delegation, add a new ioctl allowing any process
with an open fusedev fd to ask for permission for anyone with that
fusedev fd to use iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * fuse: allow privileged mount helpers to pre-approve iomap usage
 * fuse: set iomap backing device block size
---
 fs/fuse/fuse_dev_i.h      |   32 +++++++++++++++++++--
 fs/fuse/fuse_i.h          |   12 ++++++++
 include/uapi/linux/fuse.h |    8 +++++
 fs/fuse/dev.c             |   13 +++++----
 fs/fuse/file_iomap.c      |   67 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   18 ++++++++----
 6 files changed, 134 insertions(+), 16 deletions(-)


