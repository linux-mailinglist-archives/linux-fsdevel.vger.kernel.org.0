Return-Path: <linux-fsdevel+bounces-36802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6289E97BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74515188736E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A91B0437;
	Mon,  9 Dec 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg8eXtA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419E1B0429
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752028; cv=none; b=Hy/qCPF+h2ToXkqvcHzCdEmwr4KJ/rcpwQ42z4LOSxtJmQWCDx7bbMj1PZVhAauGHq067GMcz/9Ebg+0RlA/UkoSSzn77d+RsJSEB3l5GPA5JyAcb3IUF4+Bfy0T6uvBttvWsD7wfY/EkGp/HDSNIBQG9MRvoVQ+fvfBQFrb75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752028; c=relaxed/simple;
	bh=PvLS6LmxlvyfDwzLueQmA4xs3kzwfsMeZR5YoqJ067U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NHHujIPsPwoGHyHMBQeMl59BnMi2c9zFFcH6x0GuwXKPFsVnK8lUJn9PAkeqVBGMG8ViCd5LsSxZ1yUH45lWlPKwJ1AbwbmX76ZAvAcCAmHcTDE29L+hUOlAJXD7feNtKwqwVEskGnhIm1WYvUFGJ5PR04sLoAZ2sTyyebVeNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg8eXtA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7E9C4CEDE;
	Mon,  9 Dec 2024 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733752026;
	bh=PvLS6LmxlvyfDwzLueQmA4xs3kzwfsMeZR5YoqJ067U=;
	h=From:Subject:Date:To:Cc:From;
	b=Mg8eXtA2oVeXWMfcIafWyrXqoTZbbsAW42L81CMVnKpqY+UvlwBjhlj6elumTlNl4
	 ZloDjKEllU8PzXZqQtUjODRDUj0lhcXOcq08RdwEXCllERlYUojqwU2s6DJsVkUOP4
	 Zh4obNZaM5OcKJpIkvzZ5PqbPw2DokiH30fTG1Et5f9qtUBTh8aUAAfA3iLSeVnYvj
	 Me5k/7CnflFO/kfQSLpWjAX7NyTEBs2tjeCOE3mGfXz4fh47fP2gqJzKPX/V+gMWNl
	 SgeVijL5fZJW/molLAr2iLv9yvWEyXZcEFn5JEhrJDHBra/8T9oGrxGTpHhSEB2hFe
	 nvtJR5B8YUFjw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/2] pidfs: use maple tree
Date: Mon, 09 Dec 2024 14:46:56 +0100
Message-Id: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAND0VmcC/4WOQQqDMBBFr1Jm3YiJNmJXhUIP0G2RkuhEgzbKR
 NIW8e6NXqDM6g/z3vwFPJJFD+fDAoTBeju6GMTxAHWnXIvMNjGDSEXORSrZe6SeTbYxnr3UNOB
 zJkSmMyGMOWVlqQuI7ERo7Gf3PuB+u0IVl1r5eEnK1d2mDFEhE54nu22jOuvnkb57mcB39s/fw
 FmculayyLiWhbn0SA6HZKQWqnVdf3/7RMnhAAAA
X-Change-ID: 20241206-work-pidfs-maple_tree-b322ff5399b7
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PvLS6LmxlvyfDwzLueQmA4xs3kzwfsMeZR5YoqJ067U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSHfbnxp+7o1v7XOdq1n5OdGYK+q5bHZR4N6k7293vEc
 GTZ2q3lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ9pnhf+0PDafq+bxbGRQf
 PCle+kpzx83kRV/kHm6reByzMVSg7BXDH+5/+g5h3DOYZht5qrz9fnUOS9MszdrArzExL5dVuv4
 x5QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Ok, I wanted to give this another try as I'd really like to rely on the
maple tree supporting ULONG_MAX when BITS_PER_LONG is 64 as it makes
things a lot simpler overall.

As Willy didn't want additional users relying on an external lock I made
it so that we don't have to and can just use the mtree lock.

However, I need an irq safe variant which is why I added support for
this into the maple tree.

This is pullable from
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git work.pidfs.maple_tree

Thanks!
Christian

---
Christian Brauner (2):
      maple_tree: make MT_FLAGS_LOCK_IRQ do something
      pidfs: use maple tree

 fs/pidfs.c                 | 52 +++++++++++++++++++++++++++-------------------
 include/linux/maple_tree.h | 16 ++++++++++++--
 kernel/pid.c               | 34 +++++++++++++++---------------
 3 files changed, 62 insertions(+), 40 deletions(-)
---
base-commit: 963c8e506c6d4769d04fcb64d4bf783e4ef6093e
change-id: 20241206-work-pidfs-maple_tree-b322ff5399b7


