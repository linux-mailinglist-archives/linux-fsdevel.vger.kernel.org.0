Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2591CAA76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEHMXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:19 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34534 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgEHMXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:18 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E6E0A2E153D;
        Fri,  8 May 2020 15:23:15 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id noNF78ywCD-NEWOIxfj;
        Fri, 08 May 2020 15:23:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940595; bh=cr1cI1dstvPRsp7XjzJcaiOlA2cPzInYUH9vTttVd4k=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=kA2ADiyGv3YlEq7Je3o/FUKJKD4JCDDIB8HN+FNhiNMp9ZG180MbJuT2p+YaspCMr
         vW3pdAs7bqW7Ua+RgFnelbu2NyZwd+NA269zuPSff8Gb9opYnM7x+KREHlRSy3UYHC
         BnLGZL9ulqOIuhhVIVq+1eO8wctpWFLECfUW9Q6M=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id sKsCfMvhoh-NEWqunQK;
        Fri, 08 May 2020 15:23:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 1/8] dcache: show count of hash buckets in sysctl
 fs.dentry-state
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:14 +0300
Message-ID: <158894059427.200862.341530589978120554.stgit@buzz>
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

Count of buckets is required for estimating average length of hash chains.
Size of hash table depends on memory size and printed once at boot.

Let's expose nr_buckets as sixth number in sysctl fs.dentry-state

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/sysctl/fs.rst |   12 ++++++------
 fs/dcache.c                             |   12 ++++++++++--
 include/linux/dcache.h                  |    2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..b74df4714ddd 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -66,12 +66,12 @@ dentry-state
 From linux/include/linux/dcache.h::
 
   struct dentry_stat_t dentry_stat {
-        int nr_dentry;
-        int nr_unused;
-        int age_limit;         /* age in seconds */
-        int want_pages;        /* pages requested by system */
-        int nr_negative;       /* # of unused negative dentries */
-        int dummy;             /* Reserved for future use */
+        long nr_dentry;
+        long nr_unused;
+        long age_limit;         /* age in seconds */
+        long want_pages;        /* pages requested by system */
+        long nr_negative;       /* # of unused negative dentries */
+        long nr_buckets;        /* count of dcache hash buckets */
   };
 
 Dentries are dynamically allocated and deallocated.
diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..386f97eaf2ff 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3139,6 +3139,14 @@ static int __init set_dhash_entries(char *str)
 }
 __setup("dhash_entries=", set_dhash_entries);
 
+static void __init dcache_init_hash(void)
+{
+	dentry_stat.nr_buckets = 1l << d_hash_shift;
+
+	/* shift to use higher bits of 32 bit hash value */
+	d_hash_shift = 32 - d_hash_shift;
+}
+
 static void __init dcache_init_early(void)
 {
 	/* If hashes are distributed across NUMA nodes, defer
@@ -3157,7 +3165,7 @@ static void __init dcache_init_early(void)
 					NULL,
 					0,
 					0);
-	d_hash_shift = 32 - d_hash_shift;
+	dcache_init_hash();
 }
 
 static void __init dcache_init(void)
@@ -3185,7 +3193,7 @@ static void __init dcache_init(void)
 					NULL,
 					0,
 					0);
-	d_hash_shift = 32 - d_hash_shift;
+	dcache_init_hash();
 }
 
 /* SLAB cache for __getname() consumers */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..082b55068e4d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -65,7 +65,7 @@ struct dentry_stat_t {
 	long age_limit;		/* age in seconds */
 	long want_pages;	/* pages requested by system */
 	long nr_negative;	/* # of unused negative dentries */
-	long dummy;		/* Reserved for future use */
+	long nr_buckets;	/* count of dcache hash buckets */
 };
 extern struct dentry_stat_t dentry_stat;
 

