Return-Path: <linux-fsdevel+bounces-46557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07487A90438
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736E23A5291
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095D619F133;
	Wed, 16 Apr 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOEFht8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2981367
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809463; cv=none; b=eTaPBJNe22yA0e+AHH7xQT/MhaAXo57mQsjwoxbopfLRdnpwJFcZEIubZVf491qpPvGFap07cMg4hG7NezYcyYphHe3Wd+8rJRSs9u1AHP3FTRp3ibvff9qL4Ib5xVMMaCoaFSJs8u1d1fxiiKiRHHQO+dBGhDRipOj5OGFWR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809463; c=relaxed/simple;
	bh=Riwkh1cB/rIOJOovse5zSzt3LxBskzYWS6hGfWx41Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fz82A7obuKOYb8dAVZUyQkeQ0qucDy9zoqExhoRbKq87RM/uuwbIHehrgiEwvFhh6cpvwW28hfMjG8NH5q4DLfCfhWeIuOAcXV8ZbbpTO7fNY6yvGvycJYdQB1TM0xahqQAO2saWK+ad1m/+HcxEJVU7W00IWwM4DOLibAlyQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOEFht8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F4C4CEE2;
	Wed, 16 Apr 2025 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744809460;
	bh=Riwkh1cB/rIOJOovse5zSzt3LxBskzYWS6hGfWx41Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOEFht8bIvQ3yvB0+oLvdFruEFLIypkU1tLQmoM7OEhfy5MPG4TpiGLZUIDDoYJkE
	 YYKmnS8IVqlnYw7XACI0pjQaL6DbMX+3WTruvTU4BtgizlpQv7XLY7b3Q/8BkmJJk9
	 4NCmUysxNQgOinir5pvvpNLDVgxKpXkNBnMWMoV9++vaRgPT1t1rGQpQ8/6t2Ybjnm
	 LSqCdEIRkVk5mBXl0UJQi7X7iihByHZiT54AlFZFdRcEhw4cdLNQYCA0P8lwZh/okA
	 z0THbCCICD17r5RhmwnlzDEvYQPnHngUDhmW2GwI/qiCjkQt3sESSRCJ7oW90WbAZW
	 MyRXLMIslsJ4g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 0/3] mnt_idmapping: avoid pointer chase & inline low-level helpers
Date: Wed, 16 Apr 2025 15:17:21 +0200
Message-ID: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414-anomalie-abpfiff-9f293dce366b@brauner>
References: <20250414-anomalie-abpfiff-9f293dce366b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250416-work-mnt_idmap-s_user_ns-eb57ee83e1d6
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=brauner@kernel.org; h=from:subject:message-id; bh=Riwkh1cB/rIOJOovse5zSzt3LxBskzYWS6hGfWx41Ww=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/X/v4+nI/gazLi2pMY2/e37olM6ZwwSOLqceWXtoVn ygSJLzrf0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEwrQY/tecvfE+ad6Jz6nz T62c2eIevk63Tv7s4sxTF/SkJu1MEU1gZHjEwTuJ8fvm8DXte77Hc79j+hB4eGPJS6OKKbdcAso VNzICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

We currently always chase a pointer inode->i_sb->s_user_ns whenever we
need to map a uid/gid. Linus reported in [1] that this is noticable
during path lookup.

In the majority of cases we don't need to bother with that pointer chase
because the inode won't be located on a filesystem that's mounted in a
user namespace. The user namespace of the superblock cannot ever change
once it's mounted. So introduce and raise IOP_USERNS on all inodes and
check for that flag in i_user_ns() when we retrieve the user namespace.

Additionally, we now inline all low-level idmapping helpers.

[1]: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      inode: add fastpath for filesystem user namespace retrieval
      mnt_idmapping: add struct mnt_idmap to header
      mnt_idmapping: inline all low-level helpers

 fs/inode.c                     |   6 ++
 fs/mnt_idmapping.c             | 165 ----------------------------------------
 include/linux/fs.h             |   5 +-
 include/linux/mnt_idmapping.h  | 168 +++++++++++++++++++++++++++++++++++++++--
 include/linux/uidgid.h         |  23 +++++-
 include/linux/user_namespace.h |  23 +-----
 kernel/user_namespace.c        |   2 +
 7 files changed, 195 insertions(+), 197 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250416-work-mnt_idmap-s_user_ns-eb57ee83e1d6


