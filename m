Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517A649420
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 23:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfFQVfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 17:35:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfFQVWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so922068wml.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmAxRc5Ao15ufDfIpyVOarM24v8sriD2DFt+v+/KWs8=;
        b=AP9eqINZr39hvjsQ/TSc9kqzZmxEst/Cs40Zx8C1pWL3K/ploASez5lUjyTP2D5cQm
         ClADWsLajpphjVRYvYYbO3WaDBVywsDCN5Zr11KbOwq02iXK2HMMPjJochM82fCPPhv3
         LzXfVYTbhmk6fhZFPVPI06zZwu3FRa07d+bVxj9Zj4XT58ggZVHk8fhpe8BY2jXHLw2f
         WNbg+BRrVwOdcB3PMq8YbZjo04ByENHA/O+XgppEQgpxkRrse66OUGvSg/O6f5UmGQu+
         TR5HiPEXDOM+7M+UqIhb/fcxmsepBUfzG+z8awdGoFJGt4JrnkeQ/eSkmnMCnJNLe7IH
         Ckig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmAxRc5Ao15ufDfIpyVOarM24v8sriD2DFt+v+/KWs8=;
        b=PlbacxLhWvrKG9r62M/5rtTbC5Y/6ThskWgJXr/fsvIB79w3HeM0NP0SWyk4fXYxdV
         D2EO2H/Dn65Qxkxhnt88zqlypCJfROtNc406CNqmJvsow91QRvll5C/OJwwMyd+UzqL4
         uf4FdmTNmIjSpqysA7QdTCKKtBGrzRFJo3IPSxTz5d9E6JIVVq8lIXpJ20F9UnNf/Z2o
         r/d9K3dLPWhVAH1z7JEvp8djEwtIXBONYAgU1373YPif98NsEva0zSmmPt4ZMBBU1gzG
         noukRqG9UD3ZQxblDunW8zJHZGO0t1aTnKk3RFX/OnX85uE88980JEeB8QzDep2IHoah
         OV0g==
X-Gm-Message-State: APjAAAXhp0jw6H7QQTKtbAtcqHa4IzlTzhs34x9MpaG2YhxcSXwhmBzM
        eLAbVHoW+rbtmIhpuknjcWVXyg==
X-Google-Smtp-Source: APXvYqyg5EXyQIx5w7TwviJmLrfY1HyRUq/DFZ8ZsH7v6gi7rLdCxns1w21cpdGxRPv7bM1CRLWNOw==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr392815wme.117.1560806543320;
        Mon, 17 Jun 2019 14:22:23 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id r131sm396216wmf.4.2019.06.17.14.22.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 14:22:22 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        stable@vger.kernel.org
Subject: [PATCH v1] fs/namespace: fix unprivileged mount propagation
Date:   Mon, 17 Jun 2019 23:22:14 +0200
Message-Id: <20190617212214.29868-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When propagating mounts across mount namespaces owned by different user
namespaces it is not possible anymore to move or umount the mount in the
less privileged mount namespace.

Here is a reproducer:

  sudo mount -t tmpfs tmpfs /mnt
  sudo --make-rshared /mnt

  # create unprivileged user + mount namespace and preserve propagation
  unshare -U -m --map-root --propagation=unchanged

  # now change back to the original mount namespace in another terminal:
  sudo mkdir /mnt/aaa
  sudo mount -t tmpfs tmpfs /mnt/aaa

  # now in the unprivileged user + mount namespace
  mount --move /mnt/aaa /opt

Unfortunately, this is a pretty big deal for userspace since this is
e.g. used to inject mounts into running unprivileged containers.
So this regression really needs to go away rather quickly.

The problem is that a recent change falsely locked the root of the newly
added mounts by setting MNT_LOCKED. Fix this by only locking the mounts
on copy_mnt_ns() and not when adding a new mount.

Fixes: 3bd045cc9c4b ("separate copying and locking mount tree on cross-userns copies")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Tested-by: Christian Brauner <christian@brauner.io>
Acked-by: Christian Brauner <christian@brauner.io>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1:
- Christian Brauner <christian@brauner.io>:
  - fix accidental whitespace change
---
 fs/namespace.c | 1 +
 fs/pnode.c     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..44b540e6feb9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2105,6 +2105,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
+		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
diff --git a/fs/pnode.c b/fs/pnode.c
index 595857a1883e..49f6d7ff2139 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -261,7 +261,6 @@ static int propagate_one(struct mount *m)
 	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
 	if (IS_ERR(child))
 		return PTR_ERR(child);
-	child->mnt.mnt_flags &= ~MNT_LOCKED;
 	mnt_set_mountpoint(m, mp, child);
 	last_dest = m;
 	last_source = child;
-- 
2.21.0

