Return-Path: <linux-fsdevel+bounces-45342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D8A76635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AB8165883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA3202984;
	Mon, 31 Mar 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOFlvBG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414C1E7660;
	Mon, 31 Mar 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424948; cv=none; b=JGAD0i8mm3mEnZjrTvqcR58yD2Lh2S5RU25pR1ga6XQQo+6msM7553m9A7rE39gkzI3oqA1Gqms96mDZCV4o2+zks40JAbMnupkk3lrX2PC9ltzjWzVjK106lfVgI0naRuRg3kgo+6qSoChrAEpVoGWOT+w+r0XfqRCWZV4VEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424948; c=relaxed/simple;
	bh=I2L4DEBSpJN7PlGX1uPQ1ofGYrUFUA7q47HvJktTr2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKtcR3zYq/t5p7b6rR/Wqz8+/HZEYpIIucLntJhNnCy/obKZi0ZLefTTFUQhh7BG6F9rw3YuxskPbH0XXtuKZ9I0jr1mHmeUD0RHoYsEzpHvBCLejGfcHYHCSP5twFGjn8sWAiTTxna//N8Yq/WKGwyWtPrzZKXAke7nUO/9JS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOFlvBG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4BC4CEE9;
	Mon, 31 Mar 2025 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424948;
	bh=I2L4DEBSpJN7PlGX1uPQ1ofGYrUFUA7q47HvJktTr2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOFlvBG+BcSa6Ua+h/Y2moGv2MPaWnbcEN3fQaWvTG2b67KBFfgbiMk5QGhlHna1E
	 H5iZzzd/NisQoCSZemGRJVuJ/n55tlSCCImqApVXsJLBL1DL7j373oCOY2sZjyH5AE
	 LOSaKSa1QDQbOPVyErNEWNRKxApCLoioqKU8/IR6NR4lfnKngUyMkz9QYmBNiwdLJX
	 7d6EoryZRD9/eZDah0cHj41WpeSVnUldB+FVUdcNzrVzJmAre7ljelULeJjlzVkWWc
	 6f8WAoPzHMaDPXt9yoy5p4tve8MYm10iET7rYSScSKeHkFkpgs+B9S/Fbx5CQAcGeH
	 /Yx8eoL6rfaAw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 0/2] efivarfs: support freeze/thaw
Date: Mon, 31 Mar 2025 14:42:10 +0200
Message-ID: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250331-work-freeze-ae6260c405b9
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=brauner@kernel.org; h=from:subject:message-id; bh=I2L4DEBSpJN7PlGX1uPQ1ofGYrUFUA7q47HvJktTr2s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/6l3677j6siUsGi7JMnWejeW2b+Z8PMWhoScw9TLD/ cPhDgv6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi3sPw3zFikbaD/v2cU402 0ZVxV4817Hz+2UTwg8tGEz/TxSr1/xj+e0y+pXfNL8SuW93Ny/NRxu+PV+0mn1ZZXNobvOnRzHW iLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Allow efivarfs to partake to resync variable state during system
hibernation and suspend. Add freeze/thaw support.

This is a pretty straightforward implementation. We simply add regular
freeze/thaw support for both userspace and the kernel. This works
without any big issues and congrats afaict efivars is the first
pseudofilesystem that adds support for filesystem freezing and thawing.

The simplicity comes from the fact that we simply always resync variable
state after efivarfs has been frozen. It doesn't matter whether that's
because of suspend, userspace initiated freeze or hibernation. Efivars
is simple enough that it doesn't matter that we walk all dentries. There
are no directories and there aren't insane amounts of entries and both
freeze/thaw are already heavy-handed operations. If userspace initiated
a freeze/thaw cycle they would need CAP_SYS_ADMIN in the initial user
namespace (as that's where efivarfs is mounted) so it can't be triggered
by random userspace. IOW, we really really don't care.

@Ard, if you're fine with this (and agree with the patch) I'd carry this
on a stable branch vfs-6.16.super that you can pull into efivarfs once
-rc1 is out.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      libfs: export find_next_child()
      efivarfs: support freeze/thaw

 fs/efivarfs/internal.h |   1 -
 fs/efivarfs/super.c    | 196 +++++++++++++------------------------------------
 fs/internal.h          |   1 +
 fs/libfs.c             |   3 +-
 4 files changed, 54 insertions(+), 147 deletions(-)
---
base-commit: 8876e79faf32838d05488996b896cb40247a4a8a
change-id: 20250331-work-freeze-ae6260c405b9


