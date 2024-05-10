Return-Path: <linux-fsdevel+bounces-19264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7F8C23CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7377282B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444116E894;
	Fri, 10 May 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4UmmJf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7D165FB6;
	Fri, 10 May 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341577; cv=none; b=Cgbvdn0znaeEYaL8q6pKGKtfCdn9xPON3LK09BIT07ITE38neVQuZ/huSnNUqNAHvCLlr5FKWJuQ+CvF+PM/tVDBMhX2lw4ztpapomhWgobTEkKkTbUv8lG0fvZMUPiuzuCbWlQWCBqTUEA5vjoA3OXWKuKsbke5uh0XwhkBMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341577; c=relaxed/simple;
	bh=xiNFywutRxJOIrL6dR0v3bJ9hRBnTqScacCpQJv4x2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+gshfhKTx4X0BBNYFVbpvNix6308Yzz7BxB3/Wb9COE7YlCXZxLXEeqbQs8KSlU0nkmITUowuiPPZR5f8hZ69ZwyiVWCDjFkCOX5K010WRv6LZRy7B358FEBoZQVdXRsHabISygwg7TeF94B5hkVSstDiEBrqDfKLUn7qUx+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4UmmJf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408BC113CC;
	Fri, 10 May 2024 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341576;
	bh=xiNFywutRxJOIrL6dR0v3bJ9hRBnTqScacCpQJv4x2s=;
	h=From:To:Cc:Subject:Date:From;
	b=C4UmmJf9kkfhbAeBMuC7fr8N2/cQDeIFlMQosK+ARyq7ELs+QC+iUSATa9P1uT3cE
	 72Zz4D3d0Y5DMuxfXq0Yf3Si8orcBv0RS3ZJpnCTyNZWZ6IEyxGOZPe+8XtTzRdFxv
	 n3gut3VUtrbufUY4z51ENySAJhkSLL8Btx7jo/LNRrPbEIupYEHJg5akY5DLgFIrWH
	 CV99veNI4zd44qOMqrFZolYJHMDSzDssaR3ToIRRi3ookaP0WYeVKpyAL4xrds4gKV
	 t26zQSO4EnIB4NRIuWe+ug8ITzigkqcFLyRKZwlByi9zG49BfKOhhMwjLi9sDuXhNI
	 d4xbshbTjIVWw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap
Date: Fri, 10 May 2024 13:45:49 +0200
Message-ID: <20240510-vfs-iomap-eec693bccb02@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=brauner@kernel.org; h=from:subject:message-id; bh=xiNFywutRxJOIrL6dR0v3bJ9hRBnTqScacCpQJv4x2s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTZcTLcObaoeOnZewEPXS7EvjrPosLs63U74NR7hUl39 Df4aG3e1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARg2CG/xXrfwvfvd4ysdLu d4Hyl88/i86UTU0uDH+bKXC6VuRtdTLD/4SP8vpCnn/2Rtx7NfFYR8aHFXL3zBZVrjdO6Y/TXPX Clw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few cleanups to the iomap code. Nothing particularly
stands out.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.9-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

No known conflicts.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.iomap

for you to fetch changes up to e1f453d4336d5d7fbbd1910532201b4a07a20a5c:

  iomap: do some small logical cleanup in buffered write (2024-04-25 14:23:54 +0200)

Please consider pulling these changes from the signed vfs-6.10.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10.iomap

----------------------------------------------------------------
Christoph Hellwig (1):
      iomap: convert iomap_writepages to writeack_iter

Zhang Yi (5):
      iomap: drop the write failure handles when unsharing and zeroing
      iomap: don't increase i_size if it's not a write operation
      iomap: use a new variable to handle the written bytes in iomap_write_iter()
      iomap: make iomap_write_end() return a boolean
      iomap: do some small logical cleanup in buffered write

 fs/iomap/buffered-io.c | 119 +++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

