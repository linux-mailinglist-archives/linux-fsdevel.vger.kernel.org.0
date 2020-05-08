Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDD1CAA80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEHMXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34866 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727790AbgEHMXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:37 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id AB6952E0DD7;
        Fri,  8 May 2020 15:23:34 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id kkiK2Ut3yM-NXA0BVW6;
        Fri, 08 May 2020 15:23:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940614; bh=wIdyxNf74ULZ5uIf1iPET3/wYp7NaFja75AOK6nS8TA=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=cCeGDeU1SZs0abVyG+qpdEg6kcAoSWrXwGBjf6MoT93mpYKw3EvgqzwLrYsLA+43F
         Mn9NRbrdWZ6cFhq5J6zw7eZuubM+697YXX4BX1Mh7Q4Z+vL6gZm/wEaw6XMN3VaGJr
         4KgKiIpDgGUrk8h4pUnPFQWqWe6McSw090z9ny1A=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Y6BD9yFlOA-NXWipiUC;
        Fri, 08 May 2020 15:23:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 8/8] dcache: prevent flooding with negative dentries
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:33 +0300
Message-ID: <158894061332.200862.9812452563558764287.stgit@buzz>
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

Without memory pressure count of negative dentries isn't bounded.
They could consume all memory and drain all other inactive caches.

Typical scenario is an idle system where some process periodically creates
temporary files and removes them. After some time, memory will be filled
with negative dentries for these random file names. Reclaiming them took
some time because slab frees pages only when all related objects are gone.
Time of dentry lookup is usually unaffected because hash table grows along
with size of memory. Unless somebody especially crafts hash collisions.
Simple lookup of random names also generates negative dentries very fast.

This patch implements heuristic which detects such scenarios and prevents
unbounded growth of completely unneeded negative dentries. It keeps up to
three latest negative dentry in each bucket unless they were referenced.

At first dput of negative dentry when it swept to the tail of siblings
we'll also clear it's reference flag and look at next dentries in chain.
Then kill third in series of negative, unused and unreferenced denries.

This way each hash bucket will preserve three negative dentry to let them
get reference and survive. Adding positive or used dentry into hash chain
also protects few recent negative dentries. In result total size of dcache
asymptotically limited by count of buckets and positive or used dentries.

Before patch: tool 'dcache_stress' could fill entire memory with dentries.

nr_dentry = 104913261   104.9M
nr_buckets = 8388608    12.5 avg
nr_unused = 104898729   100.0%
nr_negative = 104883218 100.0%

After this patch count of dentries saturates at around 3 per bucket:

nr_dentry = 24619259    24.6M
nr_buckets = 8388608    2.9 avg
nr_unused = 24605226    99.9%
nr_negative = 24600351  99.9%

This heuristic isn't bulletproof and solves only most practical case.
It's easy to deceive: just touch same random name twice.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/dcache.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60158065891e..9f3d331b4978 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -632,6 +632,58 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return __lock_parent(dentry);
 }
 
+/*
+ * Called at first dput of each negative dentry.
+ * Prevents filling cache with never reused negative dentries.
+ *
+ * This clears reference and then looks at following dentries in hash chain.
+ * If they are negative, unused and unreferenced then keep two and kill third.
+ */
+static void trim_negative(struct dentry *dentry)
+	__releases(dentry->d_lock)
+{
+	struct dentry *victim, *parent;
+	struct hlist_bl_node *next;
+	int keep = 2;
+
+	rcu_read_lock();
+
+	dentry->d_flags &= ~DCACHE_REFERENCED;
+	spin_unlock(&dentry->d_lock);
+
+	next = rcu_dereference_raw(dentry->d_hash.next);
+	while (1) {
+		victim = hlist_bl_entry(next, struct dentry, d_hash);
+
+		if (!next || d_count(victim) || !d_is_negative(victim) ||
+		    (victim->d_flags & DCACHE_REFERENCED)) {
+			rcu_read_unlock();
+			return;
+		}
+
+		if (!keep--)
+			break;
+
+		next = rcu_dereference_raw(next->next);
+	}
+
+	spin_lock(&victim->d_lock);
+	parent = lock_parent(victim);
+
+	rcu_read_unlock();
+
+	if (d_count(victim) || !d_is_negative(victim) ||
+	    (victim->d_flags & DCACHE_REFERENCED)) {
+		if (parent)
+			spin_unlock(&parent->d_lock);
+		spin_unlock(&victim->d_lock);
+		return;
+	}
+
+	__dentry_kill(victim);
+	dput(parent);
+}
+
 /*
  * Move cached negative dentry to the tail of parent->d_subdirs.
  * This lets walkers skip them all together at first sight.
@@ -655,6 +707,8 @@ static void sweep_negative(struct dentry *dentry)
 		}
 
 		spin_unlock(&parent->d_lock);
+
+		return trim_negative(dentry);
 	}
 out:
 	spin_unlock(&dentry->d_lock);

