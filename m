Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221172320D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgG2OnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 10:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2Om7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:42:59 -0400
Received: from hubcapsc.lan (adsl-074-187-101-087.sip.mia.bellsouth.net [74.187.101.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7C2207E8;
        Wed, 29 Jul 2020 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596033778;
        bh=OwrbhncfCKO6z/ltZs+KPkLCy6nqvm6yJF0AbIBe4x8=;
        h=From:To:Cc:Subject:Date:From;
        b=zENp/GQ+d3SSisYPIT32mljpVTHyBJrBB7JogpMDx3qFnuINuxN7M6qOHwgfHrK5w
         kCVx0jemCPxxKWUK8Fu3WJ4h613s7oVhkEFo8vL3NVZmJ7dEycoYAZhpirwaEeNeYz
         Fu+4dQJ71J1mw1wAFVKVGE5JnMO5QVMAYH32/0js=
From:   hubcap@kernel.org
To:     torvalds@linux-foundation.org
Cc:     Mike Marshall <hubcap@omnibond.com>, linux-fsdevel@vger.kernel.org
Subject: [RFC] orangefs: posix acl fix...
Date:   Wed, 29 Jul 2020 10:42:48 -0400
Message-Id: <20200729144248.1381026-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>

Al Viro pointed out that I broke some acl functionality...

 * ACLs could not be fully removed
 * posix_acl_chmod would be called while the old ACL was still cached
 * new mode propagated to orangefs server before ACL.

... when I tried to make sure that modes that got changed as a
result of ACL-sets would be sent back to the orangefs server.

Not wanting to try and change the code without having some cases to
test it with, I began to hunt for setfacl examples that were expressible
in pure mode. Along the way I found examples like the following
which confused me:

  user A had a file (/home/A/asdf) with mode 740
  user B was in user A's group
  user C was not in user A's group

  setfacl -m u:C:rwx /home/A/asdf

  The above setfacl caused ls -l /home/A/asdf to show a mode of 770,
  making it appear that all users in user A's group now had full access
  to /home/A/asdf, however, user B still only had read acces. Madness.

Anywho, I finally found that the above (whacky as it is) appears to
be "posixly on purpose" and explained in acl(5):

  If the ACL has an ACL_MASK entry, the group permissions correspond
  to the permissions of the ACL_MASK entry.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/acl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index eced272a3c57..a25e6c890975 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -122,6 +122,8 @@ int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	struct iattr iattr;
 	int rc;
 
+	memset(&iattr, 0, sizeof iattr);
+
 	if (type == ACL_TYPE_ACCESS && acl) {
 		/*
 		 * posix_acl_update_mode checks to see if the permissions
@@ -138,18 +140,17 @@ int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			return error;
 		}
 
-		if (acl) {
-			rc = __orangefs_set_acl(inode, acl, type);
-		} else {
+		if (inode->i_mode != iattr.ia_mode)
 			iattr.ia_valid = ATTR_MODE;
-			rc = __orangefs_setattr(inode, &iattr);
-		}
 
-		return rc;
-
-	} else {
-		return -EINVAL;
 	}
+
+	rc = __orangefs_set_acl(inode, acl, type);
+
+	if (!rc && (iattr.ia_valid == ATTR_MODE))
+		rc = __orangefs_setattr(inode, &iattr);
+
+	return rc;
 }
 
 int orangefs_init_acl(struct inode *inode, struct inode *dir)
-- 
2.25.4

