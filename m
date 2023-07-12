Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A57510D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGLS65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGLS64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76473EA;
        Wed, 12 Jul 2023 11:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EB0618D1;
        Wed, 12 Jul 2023 18:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A767BC433C8;
        Wed, 12 Jul 2023 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689188333;
        bh=Iz6Kxkk+xodyyf6OxnMPlXHwfZZTI5Hin3kHX0V+sF4=;
        h=From:Date:Subject:To:Cc:From;
        b=JVdPYvWjM8/GQ4bHb/Qd1Myz0xZsfY4QhvyEkdibIuSrPEX5YRzGD51+SVQ/NOZPy
         P7GIiAysMC+ZEEJuWloOsvlEDAqqFAHYGjoVlr/nVMr/CorJ8ukLmitQauyKjtKUZF
         F0aDQ4t71gAMPAz8bxaS5rI4g47lLsa6h4qCbNbbiYnVFIY6/Yqci65mmajtPB7caV
         3DIeZ+GhsPp5MO5uQcGJqe7XAqfl4b3z1PyodEjEILBaCtZQoFnOO/BYRPYC8c8fVF
         BNoRh5RaoNbNY2SuRwdWMtyP2CJDkJlL32Qw9zMYbY956S73ovM/pgJwQPwVKiIDtB
         RgR4q7JwAn/Ug==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 12 Jul 2023 20:58:49 +0200
Subject: [PATCH v2] attr: block mode changes of symlinks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOj3rmQC/32NQQqDMBBFryJZd4oToZKueo/iIpqJCWpSMhIq4
 t0bPUCXD95/fxdMyROLZ7WLRNmzj6GAvFVicDqMBN4UFrKWTd2ihGwZBrdEA7wtsw8Tg260QSU
 brZQUZfhJZP33ir67wr1mgj7pMLgztWheKZ2i87zGtF3nGU/9709GQJCtkmjso0a0r4lSoPke0
 yi64zh+7ejXaM4AAAA=
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5068; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Iz6Kxkk+xodyyf6OxnMPlXHwfZZTI5Hin3kHX0V+sF4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSs+/7awb7iJrPnpOh5VraXMkQkJyRJGk7Oawvf1as3MX+T
 jMLTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4rmdk6Co4M09L7VS8s/XlpS0/ly
 fmMxZ4WaqUfd1wNOLoJrbkYIZ/luar+i9eXtPGb9y0wSBUz2SCbeJhhvJ+y3kJHUURvanMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changing the mode of symlinks is meaningless as the vfs doesn't take the
mode of a symlink into account during path lookup permission checking.

However, the vfs doesn't block mode changes on symlinks. This however,
has lead to an untenable mess roughly classifiable into the following
two categories:

(1) Filesystems that don't implement a i_op->setattr() for symlinks.

    Such filesystems may or may not know that without i_op->setattr()
    defined, notify_change() falls back to simple_setattr() causing the
    inode's mode in the inode cache to be changed.

    That's a generic issue as this will affect all non-size changing
    inode attributes including ownership changes.

    Example: afs

(2) Filesystems that fail with EOPNOTSUPP but change the mode of the
    symlink nonetheless.

    Some filesystems will happily update the mode of a symlink but still
    return EOPNOTSUPP. This is the biggest source of confusion for
    userspace.

    The EOPNOTSUPP in this case comes from POSIX ACLs. Specifically it
    comes from filesystems that call posix_acl_chmod(), e.g., btrfs via

        if (!err && attr->ia_valid & ATTR_MODE)
                err = posix_acl_chmod(idmap, dentry, inode->i_mode);

    Filesystems including btrfs don't implement i_op->set_acl() so
    posix_acl_chmod() will report EOPNOTSUPP.

    When posix_acl_chmod() is called, most filesystems will have
    finished updating the inode.

    Perversely, this has the consequences that this behavior may depend
    on two kconfig options and mount options:

    * CONFIG_POSIX_ACL={y,n}
    * CONFIG_${FSTYPE}_POSIX_ACL={y,n}
    * Opt_acl, Opt_noacl

    Example: btrfs, ext4, xfs

The only way to change the mode on a symlink currently involves abusing
an O_PATH file descriptor in the following manner:

        fd = openat(-1, "/path/to/link", O_CLOEXEC | O_PATH | O_NOFOLLOW);

        char path[PATH_MAX];
        snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
        chmod(path, 0000);

But for most major filesystems with POSIX ACL support such as btrfs,
ext4, ceph, tmpfs, xfs and others this will fail with EOPNOTSUPP with
the mode still updated due to the aforementioned posix_acl_chmod()
nonsense.

So, given that for all major filesystems this would fail with EOPNOTSUPP
and that both glibc (cf. [1]) and musl (cf. [2]) outright block mode
changes on symlinks we should just try and block mode changes on
symlinks directly in the vfs and have a clean break with this nonsense.

If this causes any regressions, we do the next best thing and fix up all
filesystems that do return EOPNOTSUPP with the mode updated to not call
posix_acl_chmod() on symlinks.

But as usual, let's try the clean cut solution first. It's a simple
patch that can be easily reverted. Not marking this for backport as I'll
do that manually if we're reasonably sure that this works and there are
no strong objections.

We could block this in chmod_common() but it's more appropriate to do it
notify_change() as it will also mean that we catch filesystems that
change symlink permissions explicitly or accidently.

Similar proposals were floated in the past as in [3] and [4] and again
recently in [5]. There's also a couple of bugs about this inconsistency
as in [6] and [7].

Link: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=99527a3727e44cb8661ee1f743068f108ec93979;hb=HEAD [1]
Link: https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c [2]
Link: https://lore.kernel.org/all/20200911065733.GA31579@infradead.org [3]
Link: https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00518.html [4]
Link: https://lore.kernel.org/lkml/87lefmbppo.fsf@oldenburg.str.redhat.com [5]
Link: https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00467.html [6]
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=14578#c17 [7]
Cc: stable@vger.kernel.org # please backport to all LTSes but not before v6.6-rc2 is tagged
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Florian Weimer <fweimer@redhat.com>
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- declarations first...
- Link to v1: https://lore.kernel.org/r/20230712-vfs-chmod-symlinks-v1-1-27921df6011f@kernel.org
---

---
 fs/attr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index d60dc1edb526..775bf77ce16f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -394,9 +394,11 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		return error;
 
 	if ((ia_valid & ATTR_MODE)) {
-		umode_t amode = attr->ia_mode;
+		if (S_ISLNK(inode->i_mode))
+			return -EOPNOTSUPP;
+
 		/* Flag setting protected by i_mutex */
-		if (is_sxid(amode))
+		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
 

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230712-vfs-chmod-symlinks-a3ad1923a992

