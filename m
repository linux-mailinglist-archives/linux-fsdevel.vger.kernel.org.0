Return-Path: <linux-fsdevel+bounces-56099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593CB1313D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E494177282
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59503224AFA;
	Sun, 27 Jul 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq8RgquJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF62E36E6;
	Sun, 27 Jul 2025 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641384; cv=none; b=e4cOHl3JbHVdhKOOsze+h/UEEnTinerQkUi/FhY99n/Jgc09zdoATAAjglRqx1P+IBcbSxTIhISF0w1IFAQvQIeth0hqPxMOGmz82APhl7V5Y0pAorBga4BbOLbjC6nlvtmE2xbH63hIdKeKW/dmOXmCJ8mKHqoDOYvVZ6Jpr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641384; c=relaxed/simple;
	bh=WuGgJeU+Prm+ZC3/MNeq9ugNEFgkJMfPiPWsKJAQOMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DJAJmshxIWCz0y042sSuO3mPzLD4K9ZKbIwouESr8VEeF0hr1ybyyyZrv71C8j/oE1RiAdQIjZ465jRT8XT8vqV3CXM/9vtr5s3l6ksC7oXHc5JIZoL6NaWl4WKGVnLIjm8AfiXzp8dyyfurD4tLjCUovtP6a9rz/RiCddQGR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq8RgquJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B9DC4CEEB;
	Sun, 27 Jul 2025 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753641384;
	bh=WuGgJeU+Prm+ZC3/MNeq9ugNEFgkJMfPiPWsKJAQOMs=;
	h=From:Subject:Date:To:Cc:From;
	b=Wq8RgquJMjspQzQfdZcoc3HCtsCq/d93WCkCjnOF4zlXrifncb+dwT4q3Rr4tDPk+
	 +sOPWLph5bKp6NcyzPUSkJBBl60JV/7oCU43GSIvRVZr5BPQCTBg1FxDwIDRn5/fnT
	 RMQhlNB9pI7LtPW7YpDqXtjyPb/+H/XbhR1YDzMEB1WIcFsRmJW1diZR1WwCtKgd5t
	 UCv2syrmk74/B4Gj/iNe/2ai8mLLdSaUr0d2RXS+OwjhPruJf2yyZB8s5tR56R2ZQ4
	 k7l1POU5IEj66cpsLSSGErqIungkmqPnNfez3XvfXY/CYCbHqPIPknLJdCGmKRs6kz
	 f148yH6/6IpLw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/8] nfsd/vfs: fix handling of delegated timestamp
 updates
Date: Sun, 27 Jul 2025 14:36:10 -0400
Message-Id: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpxhmgC/3XMQQ6CMBCF4auQrq1ppwLiynsYF1BmYKJpTUsaD
 eHuFlZq4vK95PtnETEwRnEqZhEwcWTv8jC7QtixdQNK7vMWoKBUNYB0FHs5YZzYDbLEY6VbY8m
 0SmTyCEj83HKXa94jx8mH11ZPen3/hJKWShptQNuabFPT+YbB4X3vwyDWUoJPXf1oyJoOZQOm7
 4C67ksvy/IGYe37QecAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WuGgJeU+Prm+ZC3/MNeq9ugNEFgkJMfPiPWsKJAQOMs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohnGhpUWRYry3ddZksYTq/rwet7Iuo/jOMYXCB
 pLJBCMfsz2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIZxoQAKCRAADmhBGVaC
 FbcqD/93n3K3cHZj9ahOiyE/ao6v8Y+FWTWLhERquoOcX+4cdZ/k/69lH9ymXBXvQNbn4ftukut
 C2rP+XwNmm5WMRDNn64/6k1VQQHUrSxdimfa+qOC3tdkCGFE0UnqzpDAgFdB2rcvgjFcOGvm88L
 6YlBi3FOxtXxhLYM/fad1ht2S8ihnIluBtqJIfxgPljNsQ3RdKQysrnnioTgCB1FU1B9jm9ya01
 FhUqgDzhHHWyjgl/hvR1WnTvYapPU/mssYzEWOhcLyITl6uCFtcfZGPC5EJVwHIDfGEHCKN5xVS
 HqpUpdMvXAWADSxJVoitsqH5c55NE4gZh1dnsARhEws6Y+/I/hhTOZ8+ExVh1HEFc2n6Ck4ChmZ
 8aG2bDKJxcdlq8MJ/iJvY5HJ5Ud6/9hFIA1cYujZOz9BMZ4APOX7HJPyl0iDFpRZuGWiNNifBSg
 BNNGUc73yBiyY+kD3VKDNOReISNnfySJaQ/GZkhKkt9upfYFnH/24pdz/AUFOCp7a2f0y4ol6A0
 xM6r1XC7TGktWK7cAxOQi33mTAYGzIczeQbxTNtFNZZTajBrcQqpiFWvi6fYPpcWDAlt4t7ZCFx
 grxsqmQkyTv45kRNgsNrlmWjHbPcAdNPrr4cXn50+BMdzkXlMgbMXlliY++R4kvkK4t/T/tQPzt
 NVjvJXVYcV9wF6A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset fixes the handling of delegated timestamps in nfsd.

This posting is basically identical to the last, aside from
splitting out one fix into a separate patch, and the addition of some
Fixes: tags.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
      vfs: remove inode_set_ctime_deleg()

 fs/attr.c           | 34 ++++++++++---------------
 fs/inode.c          | 73 -----------------------------------------------------
 fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++-
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  5 ++--
 fs/nfsd/state.h     |  8 ++++++
 fs/nfsd/vfs.c       |  2 +-
 include/linux/fs.h  |  3 +--
 8 files changed, 79 insertions(+), 121 deletions(-)
---
base-commit: b05f077b59098b4760e3f675b00a4e6a1ad4b0ad
change-id: 20250722-nfsd-testing-5e861a3cf3a0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


