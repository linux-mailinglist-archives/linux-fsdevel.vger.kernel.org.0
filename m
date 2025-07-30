Return-Path: <linux-fsdevel+bounces-56332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68546B16166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D8A1AA1D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63B299AAA;
	Wed, 30 Jul 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLmPv3Po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B6299A84;
	Wed, 30 Jul 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881898; cv=none; b=RbBcujORmYOXIsCUWoXZiuzFxQ1KWu0ldzu1LIWiiDF9OwB2jveLBvcAup4F/HBpR+0e118QNkjydU2mUjRBnmFgUMHE5n0+a/k9HDVQK8xfewSG3rN15w1Je+Eb/0hdwB4nRgPrtwr955ooYJM4tRhIfN41HfuexS3tlF2X2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881898; c=relaxed/simple;
	bh=pwzh++zHm4PBnw6/mF1yZymDUo3Db8nyIvIwSvR2yjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=faZCtfpa/M4kEa82eXByWE9aB7QisEvnilZddd2YOdOjPodzdwcfEtQrSKpbM3WVPximTu04iXXL+MzZ7a66Y/BDxq45pRn+RyBEAkz3pVZqVuG+oG7kiFP0h19qw0GiVARCpq6qpMBZgRBQsyTCHZ3zALwl9aSUcAq+D3E+dP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLmPv3Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8858C4CEE7;
	Wed, 30 Jul 2025 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881898;
	bh=pwzh++zHm4PBnw6/mF1yZymDUo3Db8nyIvIwSvR2yjM=;
	h=From:Subject:Date:To:Cc:From;
	b=aLmPv3PoP5MpqV3XzoV3iM9qyCvXFl/+PwWrQUNn3DtmblpzblnsHtaXPHNLHKvsQ
	 qwBDe15sRvTbZatDWC2axLw+LFM+aJ5d+nZ695i72UiSlw+0e/j/yaZj95RK+5hsg+
	 IC7o2dr3D8e/hth53e7fTc0KsODOxTVpq4r3VpmCl7ReEEOA1F5k6vbUMmM91mNAu9
	 5ID6JY3CJk06UsxlZcLXBAY0WiaHjMDBEE66wf/yRbw3tHxkrSDLKJLlYnJtP2qM3k
	 qqXIKihPT794nFTBk52DCNgbLBrAwLrd4Ot8mDyw3jjp636r6qFhQInZkapQg6Jvax
	 WPyizy0K7fN3w==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/8] nfsd/vfs: fix handling of delegated timestamp
 updates
Date: Wed, 30 Jul 2025 09:24:29 -0400
Message-Id: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA0dimgC/3XM0Q6CIBiG4VtxHEeTHwXrqPtoHSD8KKthA8dqz
 nsPPTJbh9+3Pe9EIgaHkZyLiQRMLrrB51EdCqJ75TukzuRNoIS6lADU22joiHF0vqM1NoIpri1
 XJcnkGdC615q73vLuXRyH8F7riS3vn1BitKSccWBaWn2S9nLH4PFxHEJHllKCrRY7DVnbqj4BN
 y3Ytv3RfKvlTvOsG6NBKdsyIcyXnuf5AyG4AqglAQAA
X-Change-ID: 20250722-nfsd-testing-5e861a3cf3a0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pwzh++zHm4PBnw6/mF1yZymDUo3Db8nyIvIwSvR2yjM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0bxAvobwuwik/ceoob714smm4CT5DeKE97J
 IzDBjB73RSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodGwAKCRAADmhBGVaC
 FYL6EADQWXWv3x8UIcmxSna8hYxrbZ0VrPBfZBlAyWMJ/z2NzvQVsL4OTbyc96QnmCgnU8Sjd9H
 ZMKcbhlTRTR6TcLE/acldMf5TYvvdYoT7APLYfbbGFkoPZ2tZvvAa4ZMceS+aVBC3scuPSUZJJe
 nWn/f4h0tWWvcrcqf+M6Pjtj45sYgtAaeIZD3rDgd9x4lNWzo8cYfLlSrzpsuepQobSNxQpeWhr
 uwLakkjv2M89TZG31RTgWnWo9nXtiRO5eawBOo8bxPrcbOP5YzWQodSmRWw7s8CDcacfWxDyhXu
 yQMTQkHp8CrSRhPvpnhv0a1X/aFqzKJHdEVhZoFUjecBqJX+kfffCrdqlVJKkGuBINvDpaJH/oo
 brc4x0kGaR+G2CRfCRkTSZWjpZ7fwEysqLAegOkjZfmtXQWaIfpHHJHAxIXVmMjhUwSSCwrO8Ht
 o8nCzzXRw1O7Bxl9Ku749leourAWHhfcZGINqVu5Mw5q3kyyMqoFHJ0cGcWLzIOJGxVOm+786xO
 fP0o1bDB5yWfCvajzfIGkOckVIrGbXOWH9pGlwhF0Cb84xau2rftvFM6pD112EwqYehlU1w1bpJ
 S0g5WKQCvP1UBHenWgB8Db7IkEbwdRWCJVWi+czC0zmRNcryh40hMig+oMiHsBeU9k5ewCHryRL
 ddC45dSpjAlA/Rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset fixes the handling of delegated timestamps in nfsd. This
one also adopts Neil's suggestopn to use FMODE_NOCMTIME to freeze
timestamp updates while there is a WRITE_ATTRS delegation outstanding.

Most of these patches are identical to the last set. I dropped the patch
that removes inode_set_ctime_deleg(), and reworked the logic in
setattr_copy() and friends to accomodate.

The last patch in the series is new. That one adds FMODE_NOCMTIME to the
file while a WRITE_ATTRS delegation is in force, and adds a mechanism to
ensure that the timestamps gets updated appropriately if the client
never sends a SETATTR with updated timestamps in it. That should ensure
that the ctime never rolls backward.

This patchset also leaves inode_set_ctime_deleg() in place. That's
probably overengineered if we don't need to worry about ctime updates
from the client racing with ctime updates due to writes anymore, but we
can simplify it later if so.

The series passes the gitr testsuite in the "stress" configuration.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Use FMODE_NOCMTIME to freeze timestamp updates on write
- drop patch that removes inode_set_ctime_deleg()
- rework logic in setattr_copy()
- Link to v3: https://lore.kernel.org/r/20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org

Changes in v3:
- split out decoder fix into separate patch
- add Fixes: tags
- Link to v2: https://lore.kernel.org/r/20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org

Changes in v2:
- add ATTR_CTIME_SET and remove inode_set_ctime_deleg()
- track original timestamps in struct nfs4_delegation
- fix delegated timestamp updates to respect saved timestamps
- Link to v1: https://lore.kernel.org/r/20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org

---
Jeff Layton (8):
      nfsd: fix assignment of ia_ctime.tv_nsec on delegated mtime update
      nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      vfs: add ATTR_CTIME_SET flag
      nfsd: use ATTR_CTIME_SET for delegated ctime updates
      nfsd: track original timestamps in nfs4_delegation
      nfsd: fix SETATTR updates for delegated timestamps
      nfsd: fix timestamp updates in CB_GETATTR
      nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation

 fs/attr.c           | 44 ++++++++++++---------------
 fs/nfsd/nfs4proc.c  | 55 ++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c | 86 ++++++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/nfs4xdr.c   |  5 ++--
 fs/nfsd/state.h     | 12 +++++++-
 fs/nfsd/vfs.c       |  2 +-
 include/linux/fs.h  |  1 +
 7 files changed, 153 insertions(+), 52 deletions(-)
---
base-commit: b05f077b59098b4760e3f675b00a4e6a1ad4b0ad
change-id: 20250722-nfsd-testing-5e861a3cf3a0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


