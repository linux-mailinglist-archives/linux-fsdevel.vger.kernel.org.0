Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACDF8111
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfKKUWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:01 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:38207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfKKUWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMXcP-1iDyJd3NSx-00Jc5Q; Mon, 11 Nov 2019 21:16:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/19] nfs: use time64_t internally
Date:   Mon, 11 Nov 2019 21:16:22 +0100
Message-Id: <20191111201639.2240623-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fAf2gAwX1eREIgqWnD/xnaA+lKEXHqO4cu9OJVKvRvoYHhZaQru
 CItU67QBzAi+i1+WixBdOxy2Ka0D7v+R0HRRUnJ+muD/WddljAq64Q1kKfp+a4Y0NzEl3Yg
 bCljuD7YpUhwXmX+7VjnKaPAfzBhWrzJiyPtdhzo9EntEcQdLQMpfNEMS4q2wUE2t6/nS6G
 7WhVGcfTJGiE1r3b4kUfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g35q0nZQPNM=:mAGIyZFY5uDS36gskSacpR
 dczgXgs3Joq2m8/9oheWXDzbxvITp8ajekY9Ty3zeNgKiItKjQDpzGPG6I87LBH7aPm6QmpNG
 iZ+LDEwDDhap0bwUoJLhMpRQQiSTUmv6Nyrulv/yJMGTYe1dXE2ggBl3ZxrxjJFNvSEsnDXJc
 y+KHreNqgCkFVs+qNAYuJa1+flqhDLV8mgp6kIEKv4bvbgMhRrVVfTKAQ6OHlOdfyUmvrUrSn
 5vMMTrPd18ESzCpJH2OZoKFyNqV4cu85XSIzJgEikToynOInxrbvxMc8iHPywlYLpgU0finFt
 GI5OBgxJtFcwBZ8doTHNL4Bc2OYVhHvq1zF4SUyOqXGrGKNhZMuiZBpTyJNPb+r47YcbIbA7N
 oLc+3u4ppCAdi87e7ZvkdyYD1nX/8CaeqJqjKDLWWsp1okmTJC4m6r3ipcxTJDIEvp2NihlSu
 21BOWmdPqADY9uYFku2NWul185SfIuxmaaRstnN/nPlp7FAp/+0+e6czvr6n6qKRHtTBwBMC8
 VVPBNKhD/qdymTiortmVptSTwuHUemFO0lz9x4Fn2lGDgMA5y+WI97YVDvFjhJ01Xyx1kAA5N
 b2nVUnfb+nZ/aDmatvEjtYSvzZ6OsVNPol/nCxhrLuuUM6aerDbG18GNLT26gSUEviWkLeDv0
 hgkwekllb2wJOhjyjBnWlBIKl7WeUa4npUAqemtUssZ1UrJo3ZSIBuG9bxFdoAw13+WfBIeOk
 vSeMI2Kbv3q6uoOc+l3P7hXsI1EnqqoMMpgWj6R2QuE7m0yimMpwOrA8s6lNQCytrvHMnHMlV
 KX64kuKEoPQ6EuHdJ3+XYWqUekxn5ryQBjRHZTcKpCUIZztkNSqRDVGbasm/vFXoF7T6vYAZl
 ezuA3nk5e96ckLpY2ZoQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The timestamps for the cache are all in boottime seconds, so they
don't overflow 32-bit values, but the use of time_t is deprecated
because it generally does overflow when used with wall-clock time.

There are multiple possible ways of avoiding it:

- leave time_t, which is safe here, but forces others to
  look into this code to determine that it is over and over.

- use a more generic type, like 'int' or 'long', which is known
  to be sufficient here but loses the documentation of referring
  to timestamps

- use ktime_t everywhere, and convert into seconds in the few
  places where we want realtime-seconds. The conversion is
  sometimes expensive, but not more so than the conversion we
  do today.

- use time64_t to clarify that this code is safe. Nothing would
  change for 64-bit architectures, but it is slightly less
  efficient on 32-bit architectures.

Without a clear winner of the three approaches above, this picks
the last one, favouring readability over a small performance
loss on 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/sunrpc/cache.h      | 42 +++++++++++++++++--------------
 net/sunrpc/auth_gss/svcauth_gss.c |  2 +-
 net/sunrpc/cache.c                | 18 ++++++-------
 net/sunrpc/svcauth_unix.c         | 10 ++++----
 4 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index f8603724fbee..fa46de3a8f2b 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -45,8 +45,8 @@
  */
 struct cache_head {
 	struct hlist_node	cache_list;
-	time_t		expiry_time;	/* After time time, don't use the data */
-	time_t		last_refresh;   /* If CACHE_PENDING, this is when upcall was
+	time64_t	expiry_time;	/* After time time, don't use the data */
+	time64_t	last_refresh;   /* If CACHE_PENDING, this is when upcall was
 					 * sent, else this is when update was
 					 * received, though it is alway set to
 					 * be *after* ->flush_time.
@@ -95,22 +95,22 @@ struct cache_detail {
 	/* fields below this comment are for internal use
 	 * and should not be touched by cache owners
 	 */
-	time_t			flush_time;		/* flush all cache items with
+	time64_t		flush_time;		/* flush all cache items with
 							 * last_refresh at or earlier
 							 * than this.  last_refresh
 							 * is never set at or earlier
 							 * than this.
 							 */
 	struct list_head	others;
-	time_t			nextcheck;
+	time64_t		nextcheck;
 	int			entries;
 
 	/* fields for communication over channel */
 	struct list_head	queue;
 
 	atomic_t		writers;		/* how many time is /channel open */
-	time_t			last_close;		/* if no writers, when did last close */
-	time_t			last_warn;		/* when we last warned about no writers */
+	time64_t		last_close;		/* if no writers, when did last close */
+	time64_t		last_warn;		/* when we last warned about no writers */
 
 	union {
 		struct proc_dir_entry	*procfs;
@@ -147,18 +147,22 @@ struct cache_deferred_req {
  * timestamps kept in the cache are expressed in seconds
  * since boot.  This is the best for measuring differences in
  * real time.
+ * This reimplemnts ktime_get_boottime_seconds() in a slightly
+ * faster but less accurate way. When we end up converting
+ * back to wallclock (CLOCK_REALTIME), that error often
+ * cancels out during the reverse operation.
  */
-static inline time_t seconds_since_boot(void)
+static inline time64_t seconds_since_boot(void)
 {
-	struct timespec boot;
-	getboottime(&boot);
-	return get_seconds() - boot.tv_sec;
+	struct timespec64 boot;
+	getboottime64(&boot);
+	return ktime_get_seconds() - boot.tv_sec;
 }
 
-static inline time_t convert_to_wallclock(time_t sinceboot)
+static inline time64_t convert_to_wallclock(time64_t sinceboot)
 {
-	struct timespec boot;
-	getboottime(&boot);
+	struct timespec64 boot;
+	getboottime64(&boot);
 	return boot.tv_sec + sinceboot;
 }
 
@@ -273,7 +277,7 @@ static inline int get_uint(char **bpp, unsigned int *anint)
 	return 0;
 }
 
-static inline int get_time(char **bpp, time_t *time)
+static inline int get_time(char **bpp, time64_t *time)
 {
 	char buf[50];
 	long long ll;
@@ -287,20 +291,20 @@ static inline int get_time(char **bpp, time_t *time)
 	if (kstrtoll(buf, 0, &ll))
 		return -EINVAL;
 
-	*time = (time_t)ll;
+	*time = ll;
 	return 0;
 }
 
-static inline time_t get_expiry(char **bpp)
+static inline time64_t get_expiry(char **bpp)
 {
-	time_t rv;
-	struct timespec boot;
+	time64_t rv;
+	struct timespec64 boot;
 
 	if (get_time(bpp, &rv))
 		return 0;
 	if (rv < 0)
 		return 0;
-	getboottime(&boot);
+	getboottime64(&boot);
 	return rv - boot.tv_sec;
 }
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 30ed5585a42a..6268a2c7229d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -200,7 +200,7 @@ static int rsi_parse(struct cache_detail *cd,
 	char *ep;
 	int len;
 	struct rsi rsii, *rsip = NULL;
-	time_t expiry;
+	time64_t expiry;
 	int status = -EINVAL;
 
 	memset(&rsii, 0, sizeof(rsii));
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index a349094f6fb7..18d73d1f6734 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -42,7 +42,7 @@ static bool cache_listeners_exist(struct cache_detail *detail);
 
 static void cache_init(struct cache_head *h, struct cache_detail *detail)
 {
-	time_t now = seconds_since_boot();
+	time64_t now = seconds_since_boot();
 	INIT_HLIST_NODE(&h->cache_list);
 	h->flags = 0;
 	kref_init(&h->ref);
@@ -54,7 +54,7 @@ static void cache_init(struct cache_head *h, struct cache_detail *detail)
 }
 
 static inline int cache_is_valid(struct cache_head *h);
-static void cache_fresh_locked(struct cache_head *head, time_t expiry,
+static void cache_fresh_locked(struct cache_head *head, time64_t expiry,
 				struct cache_detail *detail);
 static void cache_fresh_unlocked(struct cache_head *head,
 				struct cache_detail *detail);
@@ -145,10 +145,10 @@ EXPORT_SYMBOL_GPL(sunrpc_cache_lookup_rcu);
 
 static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch);
 
-static void cache_fresh_locked(struct cache_head *head, time_t expiry,
+static void cache_fresh_locked(struct cache_head *head, time64_t expiry,
 			       struct cache_detail *detail)
 {
-	time_t now = seconds_since_boot();
+	time64_t now = seconds_since_boot();
 	if (now <= detail->flush_time)
 		/* ensure it isn't immediately treated as expired */
 		now = detail->flush_time + 1;
@@ -280,7 +280,7 @@ int cache_check(struct cache_detail *detail,
 		    struct cache_head *h, struct cache_req *rqstp)
 {
 	int rv;
-	long refresh_age, age;
+	time64_t refresh_age, age;
 
 	/* First decide return status as best we can */
 	rv = cache_is_valid(h);
@@ -294,7 +294,7 @@ int cache_check(struct cache_detail *detail,
 			rv = -ENOENT;
 	} else if (rv == -EAGAIN ||
 		   (h->expiry_time != 0 && age > refresh_age/2)) {
-		dprintk("RPC:       Want update, refage=%ld, age=%ld\n",
+		dprintk("RPC:       Want update, refage=%lld, age=%lld\n",
 				refresh_age, age);
 		if (!test_and_set_bit(CACHE_PENDING, &h->flags)) {
 			switch (cache_make_upcall(detail, h)) {
@@ -1410,7 +1410,7 @@ static int c_show(struct seq_file *m, void *p)
 		return cd->cache_show(m, cd, NULL);
 
 	ifdebug(CACHE)
-		seq_printf(m, "# expiry=%ld refcnt=%d flags=%lx\n",
+		seq_printf(m, "# expiry=%lld refcnt=%d flags=%lx\n",
 			   convert_to_wallclock(cp->expiry_time),
 			   kref_read(&cp->ref), cp->flags);
 	cache_get(cp);
@@ -1483,7 +1483,7 @@ static ssize_t read_flush(struct file *file, char __user *buf,
 	char tbuf[22];
 	size_t len;
 
-	len = snprintf(tbuf, sizeof(tbuf), "%lu\n",
+	len = snprintf(tbuf, sizeof(tbuf), "%llu\n",
 			convert_to_wallclock(cd->flush_time));
 	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
 }
@@ -1494,7 +1494,7 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 {
 	char tbuf[20];
 	char *ep;
-	time_t now;
+	time64_t now;
 
 	if (*ppos || count > sizeof(tbuf)-1)
 		return -EINVAL;
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 5c04ba7d456b..04aa80a2d752 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -166,7 +166,7 @@ static void ip_map_request(struct cache_detail *cd,
 }
 
 static struct ip_map *__ip_map_lookup(struct cache_detail *cd, char *class, struct in6_addr *addr);
-static int __ip_map_update(struct cache_detail *cd, struct ip_map *ipm, struct unix_domain *udom, time_t expiry);
+static int __ip_map_update(struct cache_detail *cd, struct ip_map *ipm, struct unix_domain *udom, time64_t expiry);
 
 static int ip_map_parse(struct cache_detail *cd,
 			  char *mesg, int mlen)
@@ -187,7 +187,7 @@ static int ip_map_parse(struct cache_detail *cd,
 
 	struct ip_map *ipmp;
 	struct auth_domain *dom;
-	time_t expiry;
+	time64_t expiry;
 
 	if (mesg[mlen-1] != '\n')
 		return -EINVAL;
@@ -308,7 +308,7 @@ static inline struct ip_map *ip_map_lookup(struct net *net, char *class,
 }
 
 static int __ip_map_update(struct cache_detail *cd, struct ip_map *ipm,
-		struct unix_domain *udom, time_t expiry)
+		struct unix_domain *udom, time64_t expiry)
 {
 	struct ip_map ip;
 	struct cache_head *ch;
@@ -328,7 +328,7 @@ static int __ip_map_update(struct cache_detail *cd, struct ip_map *ipm,
 }
 
 static inline int ip_map_update(struct net *net, struct ip_map *ipm,
-		struct unix_domain *udom, time_t expiry)
+		struct unix_domain *udom, time64_t expiry)
 {
 	struct sunrpc_net *sn;
 
@@ -491,7 +491,7 @@ static int unix_gid_parse(struct cache_detail *cd,
 	int rv;
 	int i;
 	int err;
-	time_t expiry;
+	time64_t expiry;
 	struct unix_gid ug, *ugp;
 
 	if (mesg[mlen - 1] != '\n')
-- 
2.20.0

