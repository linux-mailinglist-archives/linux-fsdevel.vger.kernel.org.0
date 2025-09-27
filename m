Return-Path: <linux-fsdevel+bounces-62936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF30BA632D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4162F17A2AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E0233149;
	Sat, 27 Sep 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJFCe1Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44717C91;
	Sat, 27 Sep 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759004654; cv=none; b=a2LC5crY7WywOl/7RW1WfJSTAa6FdRWsh7jw6D2fPxf/qDujoJvWMqrYxEBjWLpXVNzZBovB8xmHZd9wWvTfqlP6DFfJi1bJZutVezV1ZYbXSaEHvnAARvTjtmrBIinaJfDVK58QfStsjQh7TDNfZlVG54cZiKrAjRyG1NJvffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759004654; c=relaxed/simple;
	bh=gHaLE/e9MgcbY9j9cPwK8UADfiY00me2043vymJmvMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QVtip1gQtFPbUIfpPcrVWRz3kzJR6orTbo67KPRkMY0Q7lAxcaaJEcyod2yJqjRGyVVK2mKKx9/IcYBmHIY8tqM66fQnnlc5/oizfS+KkXwphWhs+yzzPJlJ4pXrL5PJ7JSKca5u+rwzH2AgjWHW2npzLhSclXAacKtgrU2cXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJFCe1Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD65AC4CEE7;
	Sat, 27 Sep 2025 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759004653;
	bh=gHaLE/e9MgcbY9j9cPwK8UADfiY00me2043vymJmvMI=;
	h=Date:From:To:Cc:Subject:From;
	b=JJFCe1Pc4PRc4ppUgaj4ahj2nj2RqdDfJ8tk3R2/H1Anz9/5GmxhUnTbB338hh/Jp
	 r+xEzolXCry5D/1TxYGHuI7eHzBQKU9m/bcF5Ujef6f4JOn6knCTBkfkUGQ1ZzcNVG
	 Vdfaacb15gqJW1Mdn13oFlUOmOcA4fZELM7zakN1yWJlBjw0YDcKI0Ja8cvTY+zug6
	 QBAe7yTQiTk5/s6DQY9zy4UuAarNpMxgoa9JqPz7n9GACssy2Lffg/J3926AAbFyFx
	 Zeik7z9H9Wdebb6cMlIfar+sZx9IGQ8f3BfKlqPV8RsENrw1f4F7xYy19MS9Ki+q3V
	 sus0T+xfADxKQ==
Date: Sat, 27 Sep 2025 13:24:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [GIT PULL] Interleaved SHA-256 hashing support for 6.18
Message-ID: <20250927202410.GC9798@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Note: this depends on the pull request
"[GIT PULL 03/12 for v6.18] inode" from Christian Brauner.

The following changes since commit f0883b9c395ecdf7e66a58b6027fd35056cf152c:

  Merge patch series "Move fscrypt and fsverity info out of struct inode" (2025-08-21 13:58:13 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to a1f692fd69ccdbe1e492d366788b63227d429753:

  fsverity: Use 2-way interleaved SHA-256 hashing when supported (2025-09-17 13:10:04 -0500)

----------------------------------------------------------------

Add support for 2-way interleaved SHA-256 hashing to lib/crypto/, and
make fsverity use it for faster file data verification. This improves
fsverity performance on many x86_64 and arm64 processors.

Later, I plan to make dm-verity use this too.

----------------------------------------------------------------
Eric Biggers (6):
      lib/crypto: sha256: Add support for 2-way interleaved hashing
      lib/crypto: arm64/sha256: Add support for 2-way interleaved hashing
      lib/crypto: x86/sha256: Add support for 2-way interleaved hashing
      lib/crypto: tests: Add tests and benchmark for sha256_finup_2x()
      fsverity: Remove inode parameter from fsverity_hash_block()
      fsverity: Use 2-way interleaved SHA-256 hashing when supported

 fs/verity/enable.c              |  12 +-
 fs/verity/fsverity_private.h    |   2 +-
 fs/verity/hash_algs.c           |   3 +-
 fs/verity/verify.c              | 175 +++++++++++++++----
 include/crypto/sha2.h           |  28 +++
 lib/crypto/arm64/sha256-ce.S    | 284 ++++++++++++++++++++++++++++++-
 lib/crypto/arm64/sha256.h       |  37 ++++
 lib/crypto/sha256.c             |  71 +++++++-
 lib/crypto/tests/sha256_kunit.c | 184 ++++++++++++++++++++
 lib/crypto/x86/sha256-ni-asm.S  | 368 ++++++++++++++++++++++++++++++++++++++++
 lib/crypto/x86/sha256.h         |  39 +++++
 11 files changed, 1147 insertions(+), 56 deletions(-)

