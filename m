Return-Path: <linux-fsdevel+bounces-35675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC919D72B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2168164FB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4C204081;
	Sun, 24 Nov 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkGpW6LN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E6203714;
	Sun, 24 Nov 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455856; cv=none; b=o5EjI+MmnXX3ze0O6vEHFEKqIrjjBMU01/aApFOtTFuQzJh4GfYmo81R9tpmRNqiYMNJ5ElKGypRG/QKU8MQevixNd7vfBRTKmKN5whvjJZwnDo6hojMZ8mCwihYyZ1HKwutQlrKCABGZCaAbV9uZ/K2IAeLuAL9XBf/kSz+AYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455856; c=relaxed/simple;
	bh=la7Wc/MGxbqIFRuxgyInEQAbaTw2/NE/TTj2rekSr28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4JbOYcCnHNAxoBRFekcVT3yQtnDWMTfv7vuuUrVn6+/dixGl8uNeFxu37iUD+j4r5GboK/Eg2RjJa4rSQSLR9/u8+L+j9IqPsMjNHqIMjkwIrd8DpjAXX79ocQkJNh+9182Bxp1nWeMx6qBRc+QQaMLwkX+w8C88zMPn4aRC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkGpW6LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DA8C4CED3;
	Sun, 24 Nov 2024 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455856;
	bh=la7Wc/MGxbqIFRuxgyInEQAbaTw2/NE/TTj2rekSr28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkGpW6LNCSORYqeIdVdI/r7zyL/i/jLU4ruSwPr5Gs8vS+z60HFxXHJ0l9Ef7++bE
	 KnZMEwQmXZ3GWpr3ldVL79XbBbZ2mw3zujqffF6bPt/33q6/wVi5PxeRsvlXCD6tLl
	 QEYhedS2MJt/JCOKjSPgQrjur9SxDm/rdt7Eexz/Hqkq6dptYLBzWf3XpJek6A82ej
	 Ml9ef/EY81l5YfroOW4Z2/yQ6BtCNg/q3P+xaIb/X/YTSvqNJ2sfJ4pxRg1m2tx5Ef
	 5NeEWZsINGOXZPscyh7VqsQHKsprwaxv21Ow+S/JEOvn3doOL74qEOb6AkNJsEzY9L
	 bsw5+lUxXSKIw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/26] cred: rework {override,revert}_creds()
Date: Sun, 24 Nov 2024 14:43:46 +0100
Message-ID: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241124-work-cred-349b65450082
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=brauner@kernel.org; h=from:subject:message-id; bh=la7Wc/MGxbqIFRuxgyInEQAbaTw2/NE/TTj2rekSr28=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7605vPbS1iufAqZtiql1TLRdr2PZMehbLzXLp4qelJ Zem5b3k7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI0UWMDG2zU9fM/v+AJ+6W pPukNXum7ZV0WKKn02Z2YfvR0r8341QZ/lms3vEhbgezfoyI83m5B69yEgM8+eyS3wS9b7C+9/l hPxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

For the v6.13 cycle we switched overlayfs to a variant of
override_creds() that doesn't take an extra reference. To this end I
suggested introducing {override,revert}_creds_light() which overlayfs
could use.

This seems to work rather well. As Linus correctly points out that we
should look into unifying both and simply make {override,revert}_creds()
do what {override,revert}_creds_light() currently does. Caller's that
really need the extra reference count can take it manually.

This series does all that. Afaict, most callers can be directly
converted over and can avoid the extra reference count completely.

Lightly tested.

---
Christian Brauner (26):
      tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
      cred: return old creds from revert_creds_light()
      tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
      cred: remove old {override,revert}_creds() helpers
      tree-wide: s/override_creds_light()/override_creds()/g
      tree-wide: s/revert_creds_light()/revert_creds()/g
      firmware: avoid pointless reference count bump
      sev-dev: avoid pointless cred reference count bump
      target_core_configfs: avoid pointless cred reference count bump
      aio: avoid pointless cred reference count bump
      binfmt_misc: avoid pointless cred reference count bump
      coredump: avoid pointless cred reference count bump
      nfs/localio: avoid pointless cred reference count bumps
      nfs/nfs4idmap: avoid pointless reference count bump
      nfs/nfs4recover: avoid pointless cred reference count bump
      nfsfh: avoid pointless cred reference count bump
      open: avoid pointless cred reference count bump
      ovl: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      smb: avoid pointless cred reference count bump
      io_uring: avoid pointless cred reference count bump
      acct: avoid pointless reference count bump
      cgroup: avoid pointless cred reference count bump
      trace: avoid pointless cred reference count bump
      dns_resolver: avoid pointless cred reference count bump

 drivers/base/firmware_loader/main.c   |  3 +--
 drivers/crypto/ccp/sev-dev.c          |  2 +-
 drivers/target/target_core_configfs.c |  3 +--
 fs/aio.c                              |  3 +--
 fs/backing-file.c                     | 20 +++++++-------
 fs/cachefiles/internal.h              |  4 +--
 fs/nfsd/auth.c                        |  4 +--
 fs/nfsd/filecache.c                   |  2 +-
 fs/nfsd/nfs4recover.c                 |  3 +--
 fs/nfsd/nfsfh.c                       |  1 -
 fs/open.c                             | 10 ++-----
 fs/overlayfs/copy_up.c                |  6 ++---
 fs/overlayfs/dir.c                    |  4 +--
 fs/overlayfs/util.c                   |  4 +--
 fs/smb/server/smb_common.c            |  4 +--
 include/linux/cred.h                  | 14 ++++------
 kernel/cred.c                         | 50 -----------------------------------
 kernel/trace/trace_events_user.c      |  3 +--
 18 files changed, 35 insertions(+), 105 deletions(-)
---
base-commit: 228a1157fb9fec47eb135b51c0202b574e079ebf
change-id: 20241124-work-cred-349b65450082


