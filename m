Return-Path: <linux-fsdevel+bounces-46948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E1A96DCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC264405E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C4281537;
	Tue, 22 Apr 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns8AXJSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65828135E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330563; cv=none; b=fOCA8eTp3U4o7Zo3lCUHBEFcNA5Se4wCVUKNtW/W+r8ZpbfUWubrh0beQ+7gHcxnrXirD99rOR379JHqc9upWiekr1mX7id8fgDbAVaUj2UTCEpWrAcg4Bl14tNS7RH0/h2jV1suNoaKCe1eFwXBoQ1t4l4Nhk5hudKOAlI31JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330563; c=relaxed/simple;
	bh=hLpdSw/EYgXBoB7UV2j+kQUWRtXkN0Lq8MEmCkTwXxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kRWy/HKpiQrrl1ZPsvhdDptWEf7sdFVavcityJ0h8AOpW4NS0fyPP+JDIzFmx+xrWy38rjF7b2TrrNcV1RUzY2DPn2x7BGm9FMkirbB5jmxReWCMln40cKS/+P5pD/SsniIfD3Uq0+L/RNXFOJSfawfjf3dk33L4lv8sswKr7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns8AXJSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DA1C4CEE9;
	Tue, 22 Apr 2025 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330563;
	bh=hLpdSw/EYgXBoB7UV2j+kQUWRtXkN0Lq8MEmCkTwXxk=;
	h=From:Subject:Date:To:Cc:From;
	b=ns8AXJSweJy16iwG/JRoM/z7Eooh9ots7jTyvdmnZfnYH8AeBGwhpIN2sUEViu8cb
	 si1WDhJ1FbBayF3owg/FsumBZ0GIwfI9oWA+Tf4IMqMSfHf7mNUcwbfELi6GVhvNPd
	 y4X6xavenHjWsI4zuX8QCD0fBSWTeJ6IVu4MThW2/DSjmm3OSutjwAyAU7Mym2E+g/
	 Xb8SBW25cpDQA09kS8Gk5pe79vuOjBim86hGq0y3I9NDHCJyizhQEdpMh1tP6If0AC
	 RVQjyLc7LBfQxa/o3jGUjBRMBR5W+cUwGP6Q1Mhl2hzmL8tOTsHIaz1XDKwKyOizxN
	 D3QH7QapH8A6w==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] mnt_idmapping: improve fastpaths
Date: Tue, 22 Apr 2025 16:02:31 +0200
Message-Id: <20250422-work-mnt_idmap-s_user_ns-v2-0-34ce4a82f931@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHehB2gC/42OQQ6CMBBFr2K6dggtUowr72EIacsADdKSKVYN4
 e4WTuDyLd77f2UByWJgt9PKCKMN1rsE4nxiZlCuR7BtYiZyUeYXLuHtaYTJLY1tJzVDaF6p0Lg
 AqMsK8VogbyVL+kzY2c+RftSJtQoImpQzwx6cVFiQsigzXgIZviuDDYun73Em8l38YzdyyEFUh
 cauUJKjuY9IDp+Zp57V27b9AA+Ev2XkAAAA
X-Change-ID: 20250416-work-mnt_idmap-s_user_ns-eb57ee83e1d6
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hLpdSw/EYgXBoB7UV2j+kQUWRtXkN0Lq8MEmCkTwXxk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwL2zQmhf2yzXp4nJtlvZqDeMPR+U3Nn41rs1RnMwmn
 DbxzmnhjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMnc7IcD3/W+1i7gPy0h+c
 b2rt8+IRCXxYevYyT6XcLZ9bS05nszL8M5ZcEyvPrbS68cYj52229azhX/UVF1dq7Hx9tivvSa8
 aGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We currently always chase a pointer inode->i_sb->s_user_ns whenever we
need to map a uid/gid. Linus reported in [1] that this is noticable
during path lookup.

In the majority of cases we don't need to bother with that pointer chase
because the inode won't be located on a filesystem that's mounted in a
user namespace. The user namespace of the superblock cannot ever change
once it's mounted. So introduce and raise IOP_USERNS on all inodes and
check for that flag in relevant helpers.

[1]: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Don't fully inline low-level helpers.
- Link to v1: https://lore.kernel.org/20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org

---
Christian Brauner (2):
      mnt_idmapping: don't bother with initial_idmapping() in {from,make}_vfs{g,u}id()
      inode: add fastpath for filesystem user namespace retrieval

 fs/inode.c                    |  8 ++++++++
 fs/mnt_idmapping.c            | 46 ++-----------------------------------------
 include/linux/fs.h            | 23 +++++++++++++++++++---
 include/linux/mnt_idmapping.h |  5 +++++
 4 files changed, 35 insertions(+), 47 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250416-work-mnt_idmap-s_user_ns-eb57ee83e1d6


