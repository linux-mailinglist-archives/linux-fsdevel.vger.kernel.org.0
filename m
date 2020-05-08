Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA41CAA81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHMXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:39 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:57296 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgEHMXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:34 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 389F62E1574;
        Fri,  8 May 2020 15:23:29 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id ar427vyawi-NSX4ptWY;
        Fri, 08 May 2020 15:23:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940609; bh=liJknFRYDA0nUUv0ro+iQXHRLau6qws9t8QCP/DSyVg=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=OOLeXBCfwoE6ZufUWCYkDj83HXktllePJsnMsIx9vr5wx0QX2UAsr1HG8rSOu8Omg
         hCskXJGWC8zlMJECTFy+TE+rgXbOXgjyzOM2bJUMmsZLj+koG8MwVHwzsFZVqOPa1c
         kb/l7qjGID09yskyKryJGtYdxXnUU4e2bJEkShxc=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id uFJknMXhLs-NSWiskNQ;
        Fri, 08 May 2020 15:23:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 6/8] dcache: stop walking siblings if remaining dentries
 all negative
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:28 +0300
Message-ID: <158894060799.200862.477468763047350875.stgit@buzz>
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most walkers are interested only in positive dentries.

Changes in simple_* libfs helpers are mostly cosmetic: it shouldn't cache
negative dentries unless uses d_delete other than always_delete_dentry().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/dcache.c |   10 ++++++++++
 fs/libfs.c  |   10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 44c6832d21d6..0fd2e02e507b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1442,6 +1442,9 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 	struct check_mount *info = data;
 	struct path path = { .mnt = info->mnt, .dentry = dentry };
 
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
+
 	if (likely(!d_mountpoint(dentry)))
 		return D_WALK_CONTINUE;
 	if (__path_is_mountpoint(&path)) {
@@ -1688,6 +1691,10 @@ void shrink_dcache_for_umount(struct super_block *sb)
 static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
+
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
+
 	if (d_mountpoint(dentry)) {
 		__dget_dlock(dentry);
 		*victim = dentry;
@@ -3159,6 +3166,9 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 {
 	struct dentry *root = data;
 	if (dentry != root) {
+		if (d_is_tail_negative(dentry))
+			return D_WALK_SKIP_SIBLINGS;
+
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 3759fbacf522..de944c241cf0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -106,6 +106,10 @@ static struct dentry *scan_positives(struct dentry *cursor,
 	spin_lock(&dentry->d_lock);
 	while ((p = p->next) != &dentry->d_subdirs) {
 		struct dentry *d = list_entry(p, struct dentry, d_child);
+
+		if (d_is_tail_negative(d))
+			break;
+
 		// we must at least skip cursors, to avoid livelocks
 		if (d->d_flags & DCACHE_DENTRY_CURSOR)
 			continue;
@@ -255,7 +259,8 @@ static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev
 			spin_unlock(&d->d_lock);
 			if (likely(child))
 				break;
-		}
+		} else if (d_is_tail_negative(d))
+			break;
 	}
 	spin_unlock(&parent->d_lock);
 	dput(prev);
@@ -408,6 +413,9 @@ int simple_empty(struct dentry *dentry)
 
 	spin_lock(&dentry->d_lock);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
+		if (d_is_tail_negative(child))
+			break;
+
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);

