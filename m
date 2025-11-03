Return-Path: <linux-fsdevel+bounces-66733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F7C2B5D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFBC4F5029
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792F303A24;
	Mon,  3 Nov 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOCc3t6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846ED30275E;
	Mon,  3 Nov 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169227; cv=none; b=rsenBL9rqPAo6chPGQhlXke3s+tP0ksAn1nbgdh8sntQtEWCNknNDoP3EuD7Oj2R7WFUCikPRAsK4Qr8/MnlRYfRK7lSTcPOPE8cx+4xE5iBCcknXj9/6dSs/VhCl0Yvs+2rBAEr0jcID5Lkmoy3783DQrHDZgNITBCXUT+g1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169227; c=relaxed/simple;
	bh=lhzfkd31EG7n+Ixv/igI3+Gf703FGmQM7qRQJFJp0Qw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RCm3y6NodkyJrB300V+vJ5pKKL2wdNrYC/5Y8EmTleZTswkgZtr4KaWg1Xp6/X+BLZI4bFpURck0WzJECHQlyYW1zJ8BHZqIA8jTlHwg1TZ1/ecsqyjNBHIpKLWuCuy/q5IopCdZA6GGbGLK0f1HdIZeSohzx2JLoU2p4zVRXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOCc3t6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC19C4CEE7;
	Mon,  3 Nov 2025 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169227;
	bh=lhzfkd31EG7n+Ixv/igI3+Gf703FGmQM7qRQJFJp0Qw=;
	h=From:Subject:Date:To:Cc:From;
	b=tOCc3t6STGGHOu4PLoLSVcx2ZERkZuOWSvzibGMT41ZGBRpIxlVE2zM1wLM+azWtH
	 CXXQGIJgbXlc4pcoRZtrzPJBiRn2hNf2/PbT/iNXFU2YIyvK0O7lN6n7fqiQQYTO2r
	 S56nbKvJ4HDD/uhFYpS26gFpe/IhaVKOKNlTiWp0aqWh4hwlqba2gsW6PZDF6KkHdI
	 E+oJviYEkXUIXAHGonrWTVUJv1hwTKl6B8YFLz0kRGg15k9tggVBLQa7N3uhapM5Nc
	 viKpN5F642JfzfFux44DBO5hMf/JMg3KDrCcXbNBHWJEt2O66oU42LbKV3hFGWzv9A
	 wqaRHQ0v5Nj0Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/16] credentials guards: the easy cases
Date: Mon, 03 Nov 2025 12:26:48 +0100
Message-Id: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiRCGkC/x3MywqDMBCF4VeRWXdsklLBvkrpIiZjHEyjzNALi
 O/e2NXhW5x/AyVhUrg1Gwi9WXkpFfbUQJh8SYQcq8EZd7XWXPCzyIxBKCqml5c6ys81E3a2p9E
 5Y6JzUO+r0Mjff/r+qB68Eg7iS5iO4CKcuKDP+TyTFMrYtbZvjzLs+w9xb521mAAAAA==
X-Change-ID: 20251103-work-creds-guards-simple-619ef2200d22
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lhzfkd31EG7n+Ixv/igI3+Gf703FGmQM7qRQJFJp0Qw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGznOJ82MaJ8XWnoh3/NO3lLb6h8yImtPLv/+h1jC
 e5mxnVzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby8TrDP6sCI8VCs9D/G65P
 bPwsuGZ70B29nREygeYBau+6rjhq8jL8r3xlPHfHIidL93WWJ/7kuJ6X7QrbtfGkzHO7T3IHEh6
 85QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This converts all users of override_creds() to rely on credentials
guards. Leave all those that do the prepare_creds() + modify creds +
override_creds() dance alone for now. Some of them qualify for their own
variant.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (16):
      cred: add {scoped_}with_creds() guards
      aio: use credential guards
      backing-file: use credential guards for reads
      backing-file: use credential guards for writes
      backing-file: use credential guards for splice read
      backing-file: use credential guards for splice write
      backing-file: use credential guards for mmap
      binfmt_misc: use credential guards
      erofs: use credential guards
      nfs: use credential guards in nfs_local_call_read()
      nfs: use credential guards in nfs_local_call_write()
      nfs: use credential guards in nfs_idmap_get_key()
      smb: use credential guards in cifs_get_spnego_key()
      act: use credential guards in acct_write_process()
      cgroup: use credential guards in cgroup_attach_permissions()
      net/dns_resolver: use credential guards in dns_query()

 fs/aio.c                     |   6 +-
 fs/backing-file.c            | 147 ++++++++++++++++++++++---------------------
 fs/binfmt_misc.c             |   7 +--
 fs/erofs/fileio.c            |   6 +-
 fs/nfs/localio.c             |  59 +++++++++--------
 fs/nfs/nfs4idmap.c           |   7 +--
 fs/smb/client/cifs_spnego.c  |   6 +-
 include/linux/cred.h         |  12 ++--
 kernel/acct.c                |   6 +-
 kernel/cgroup/cgroup.c       |  10 ++-
 net/dns_resolver/dns_query.c |   6 +-
 11 files changed, 133 insertions(+), 139 deletions(-)
---
base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
change-id: 20251103-work-creds-guards-simple-619ef2200d22


