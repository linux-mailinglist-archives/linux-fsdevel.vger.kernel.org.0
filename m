Return-Path: <linux-fsdevel+bounces-5801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA78108EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3291C20E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE147C2D4;
	Wed, 13 Dec 2023 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnuIwKpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69BBA3B;
	Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3940FC433C8;
	Wed, 13 Dec 2023 04:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702440074;
	bh=DRMYZj40lbcWfG2b2XHABri8yPBHqvMleMODO+067Q4=;
	h=From:To:Cc:Subject:Date:From;
	b=RnuIwKpvICnNkxkoQ4G5NyIrJVQ1JZ0A4IWhLvKjo8UYFU45J27Ouevh5RMtI8Fbt
	 pjQPq/ehfu6+DPF8HvtVg6/1pXt6ZoqgB1KNrHtvMCWf6JY0h+/g9rkW2Vutcqc/lk
	 c/+D70YAstXKvW7Nik6jQK67Gv3vmWKvux1UOseyiRPkofdWJq0m92649iuFo6E/uW
	 Q4iUT1xYWgP+LJu5AkcvtOqi4vNVr5PylkV9LgD//M9hnByfy1xXOKaKfnt1APJMxO
	 8HQFJpj5rMgvHVMdTYWkMRDbU4T/GbQDTWVKRSvn+pAoIFgvOO7MRMETmQb3g86HH+
	 2A7YlHNfcpmmA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] Move fscrypt keyring destruction to after ->put_super
Date: Tue, 12 Dec 2023 20:00:15 -0800
Message-ID: <20231213040018.73803-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the fscrypt keyring destruction to after ->put_super,
as this will be needed by the btrfs fscrypt support.  To make this
possible, it also changes btrfs and f2fs to release their block devices
after generic_shutdown_super() rather than before.

This supersedes "[PATCH] fscrypt: move the call to
fscrypt_destroy_keyring() into ->put_super()"
(https://lore.kernel.org/linux-fscrypt/20231206001325.13676-1-ebiggers@kernel.org/T/#u)

This applies to v6.7-rc5.

Christoph Hellwig (1):
  btrfs: call btrfs_close_devices from ->kill_sb

Eric Biggers (1):
  f2fs: move release of block devices to after kill_block_super()

Josef Bacik (1):
  fs: move fscrypt keyring destruction to after ->put_super

 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   |  7 ++-----
 fs/f2fs/super.c    | 12 +++++++-----
 fs/super.c         | 12 ++++++------
 4 files changed, 17 insertions(+), 18 deletions(-)


base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.43.0


