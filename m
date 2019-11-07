Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C9F38ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKGTrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 14:47:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725385AbfKGTrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573156036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0aQ04adiL2kkX8XgzDKzeQmw5/4A/kKf5joY6F9lzO0=;
        b=a0Rm3VWu45HTCpd3W05uNj8+ZAxsCaDdv6lV7r2wqz7DttAAqoGTWvMotSjuKalMDukbhK
        NidaTfz8hrDybFNRPlaxDiDQp2g6L1cwh62c3S6aaXMbqQUvwmiHu3Bd2x609KIH1RzJLk
        biK+Xqd48jURCPO2cU0cV3djM9CsbnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-c6vEJrMTOsyqIjxokbx96Q-1; Thu, 07 Nov 2019 14:47:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9438017DD;
        Thu,  7 Nov 2019 19:47:12 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C11E360FC2;
        Thu,  7 Nov 2019 19:47:11 +0000 (UTC)
Subject: [PATCH 1/2] fs: avoid softlockups in s_inodes iterators
From:   Eric Sandeen <sandeen@redhat.com>
To:     fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>
References: <cb77c8d5-e894-4e9d-bf6f-fc1be14c5423@redhat.com>
Autocrypt: addr=sandeen@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <29aceb8b-5307-c04f-a20b-366be05eb365@redhat.com>
Date:   Thu, 7 Nov 2019 13:47:11 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <cb77c8d5-e894-4e9d-bf6f-fc1be14c5423@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: c6vEJrMTOsyqIjxokbx96Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anything that walks all inodes on sb->s_inodes list without rescheduling
risks softlockups.

Previous efforts were made in 2 functions, see:

c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
ac05fbb inode: don't softlockup when evicting inodes

but there hasn't been an audit of all walkers, so do that now.  This
also consistently moves the cond_resched() calls to the bottom of each
loop in cases where it already exists.

One loop remains: remove_dquot_ref(), because I'm not quite sure how
to deal with that one w/o taking the i_lock.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

V2: Drop unrelated iput cleanups in fsnotify

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..dc1a1d5d825b 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -35,11 +35,11 @@ static void drop_pagecache_sb(struct super_block *sb, v=
oid *unused)
         spin_unlock(&inode->i_lock);
         spin_unlock(&sb->s_inode_list_lock);
=20
-        cond_resched();
         invalidate_mapping_pages(inode->i_mapping, 0, -1);
         iput(toput_inode);
         toput_inode =3D inode;
=20
+        cond_resched();
         spin_lock(&sb->s_inode_list_lock);
     }
     spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..b0c789bb3dba 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,6 +676,7 @@ int invalidate_inodes(struct super_block *sb, bool kill=
_dirty)
     struct inode *inode, *next;
     LIST_HEAD(dispose);
=20
+again:
     spin_lock(&sb->s_inode_list_lock);
     list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
         spin_lock(&inode->i_lock);
@@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kil=
l_dirty)
         inode_lru_list_del(inode);
         spin_unlock(&inode->i_lock);
         list_add(&inode->i_lru, &dispose);
+
+        if (need_resched()) {
+            spin_unlock(&sb->s_inode_list_lock);
+            cond_resched();
+            dispose_list(&dispose);
+            goto again;
+        }
     }
     spin_unlock(&sb->s_inode_list_lock);
=20
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ecef6155fc0..ac9eb273e28c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -77,6 +77,7 @@ static void fsnotify_unmount_inodes(struct super_block *s=
b)
=20
         iput_inode =3D inode;
=20
+        cond_resched();
         spin_lock(&sb->s_inode_list_lock);
     }
     spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..4a085b3c7cac 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -985,6 +985,7 @@ static int add_dquot_ref(struct super_block *sb, int ty=
pe)
          * later.
          */
         old_inode =3D inode;
+        cond_resched();
         spin_lock(&sb->s_inode_list_lock);
     }
     spin_unlock(&sb->s_inode_list_lock);


