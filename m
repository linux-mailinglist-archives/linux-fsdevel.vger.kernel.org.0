Return-Path: <linux-fsdevel+bounces-31035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22B991094
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D3A283006
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548F231CB7;
	Fri,  4 Oct 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQjqsV9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D105231C80;
	Fri,  4 Oct 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073764; cv=none; b=DUi59ghAShfYR132HD5L9ytqn0FgW7B0I9Dy6dTjLp7ifq7MgPEz6QTZlnJt+e9sz82d8aD0e0AeNlpeSkaaZSqFozbxoXeulOzRTFzZ6gPJO7rHtzWh56Nzn/LP+2IVp4O2/E/C1i2Op/aIyNBmBt/oGpAiqEYNZQlwsKuEKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073764; c=relaxed/simple;
	bh=XHZLQD1ErzRyqIdudTG5gz6C2Niq7KA9cBpxBxsq1PM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AO20BcKMMNjp9le1ZOaHKOsWpSWGTPt9VRw2yBIULJu0cSOn1xFBgV5jO4dv8hBZH2NOFwfbWMBV5nmfKEFPd0s6OBxAy/P4z9D/R1e/Qq2wDRT4FEo+/7+gmLBjSuipfvGmYFizT2rNXU3InA9yfrfN7I2U7n+f7mAJUHpumP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQjqsV9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD1CC4CEC6;
	Fri,  4 Oct 2024 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728073763;
	bh=XHZLQD1ErzRyqIdudTG5gz6C2Niq7KA9cBpxBxsq1PM=;
	h=From:Subject:Date:To:Cc:From;
	b=DQjqsV9ZyLP+OLobIy07JccH8vO2TK7+oKw1U5fWy4wesiHf7Cz3oyTHXkMgdyFrK
	 gZ10jSl56ehxhOVGaMA4VLHZtY+gT21RzncgbNTejypeNz3Y0Xzo03Mqfiv9KDdxKc
	 5GtozZwzwU4cnf58v8P775bAHqj5DhMFwrSRBX37DAY667GNf+wY9Gg7XVskUIc3Z0
	 j1X6HO8sINK4YDw8ODqVI3ViVvm5rmMwRuveHYSJAtICdq+qFDOJ8JCtv9haQs/ycM
	 r/lWe+caGEg2i1x2QG0rZA0HeUBs93FKrY3wiUJL9b2f7JerxYGsn9MVL5HXmaFHxR
	 59TZT9/QlFMdQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC v2 0/2] arm64: Add infrastructure for use of AT_HWCAP3
Date: Fri, 04 Oct 2024 21:26:28 +0100
Message-Id: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRPAGcC/2WNzQqDMBCEX0X23C3RGH96KhT6AL0WD0FXDVUjm
 5K2SN69QXrr8ZthvtnAERtycEo2YPLGGbtEyA4JtKNeBkLTRYZMZLmohULNc5EjTT2Or1avEst
 S1K1StexkDnG2MvXmvSvvcLteoInhaNzT8me/8ele/YzFv9GnKLDq+lQrKqQS1flBvNB0tDxAE
 0L4AvB+mga2AAAA
X-Change-ID: 20240905-arm64-elf-hwcap3-7709c5593d34
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XHZLQD1ErzRyqIdudTG5gz6C2Niq7KA9cBpxBxsq1PM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnAFAe7saB3zi5hDCkIVqUtEaorraDTp3QVFiYEQoL
 if1JERqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwBQHgAKCRAk1otyXVSH0FHHB/
 9+tUh1y+t4MdvijrHJlvp3/g3m9azLRNbbXAVxebaU4mpT/rTRb5MktPyAJf7u8R6k9h2PRkWhTGfR
 TYQOfK/iUJxoMO19RYWweJ7n6J0/GIrdDcYhLTKaAGwBmZ8FKJJt79Wa+D6KmITPFeW2sdDjaAjAWa
 E7eLXoSG7TQW0c3IJu2xm+Uza2+WBRsZpV2wgIkkOenzkdj3mPE8UtxWYGEdzT5vE52QLRoipF2o9B
 bEAoKhzLoq5bhFR+BDDX+BnE04GtT+mUzds9Aq9NDvw66htgkkgKlEonir8/EotyE/WWCB5Fs9Rw+K
 vQs1YdMhSTFQeWGm6wDjNv2V/4q7a1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since arm64 has now used all of AT_HWCAP2 it needs to either start using
AT_HWCAP3 (which was recently added for PowerPC) or start allocating
bits 32..61 of AT_HWCAP first.  Those are documented in elf_hwcaps.rst
as unused and in uapi/asm/hwcap.h as unallocated for potential use by
libc, glibc does currently use bits 62 and 63.  This series has the code
for enabling AT_HWCAP3 as a reference.

While we've decided to go with using the high bits of AT_HWCAP for now
we will exhaust those at some point so it seems helpful to have this
code available in order to make life easier when we do need to start
using AT_HWCAP3.  This seems like it might come up relatively quickly,
for the past few years the dpISA has used ~15 hwcaps due to the fine
grained feature definitions and the fact that SVE and SME need
independent definitions of everything. When we do start using HWCAP3
we'll potentially have multiple serieses that need to share the addition
so it seems like it might be helpful to have the scaffolding in place
at least the release before it's actuallly required in order to make
things more managable. That's not an issue *now* but could come up
surprisingly quickly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.12-rc1.
- Fix cut'n'paste 3/4 issues.
- Link to v1: https://lore.kernel.org/r/20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org

---
Mark Brown (2):
      binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
      arm64: Support AT_HWCAP3

 Documentation/arch/arm64/elf_hwcaps.rst |  6 +++---
 arch/arm64/include/asm/cpufeature.h     |  3 ++-
 arch/arm64/include/asm/hwcap.h          |  6 +++++-
 arch/arm64/include/uapi/asm/hwcap.h     |  4 ++++
 arch/arm64/kernel/cpufeature.c          |  6 ++++++
 fs/binfmt_elf.c                         |  6 ++++++
 fs/binfmt_elf_fdpic.c                   |  6 ++++++
 fs/compat_binfmt_elf.c                  | 10 ++++++++++
 8 files changed, 42 insertions(+), 5 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240905-arm64-elf-hwcap3-7709c5593d34

Best regards,
-- 
Mark Brown <broonie@kernel.org>


