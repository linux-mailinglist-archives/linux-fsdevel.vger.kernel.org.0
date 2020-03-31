Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E804A19A086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgCaVO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:14:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731177AbgCaVO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnd6JOKC9Rxj1l4kNr20jHc2/c0GfJbz4uCFmvz/S54=;
        b=GK0R9ampD6EWpza9z/LnEmgpOpcxM49PqO0XKdEn5YPYc2y1K1UJvmKk6fgd8hf95iBpMy
        zX/BapPwY6hhRKHNU/exfSe9REMiO+dQ3Lf98Pr3nWoNKDGh7+BnEjksFJapSIYW6JoBO8
        xMUnbnxWpziN/CZmO/Ic1eqercv+3eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-oN7tCOhCMqaKnNMhCISqjg-1; Tue, 31 Mar 2020 17:14:22 -0400
X-MC-Unique: oN7tCOhCMqaKnNMhCISqjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BCF108442D;
        Tue, 31 Mar 2020 21:14:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34DA61A269;
        Tue, 31 Mar 2020 21:14:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com>
References: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <2294742.1585675875@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2415049.1585689255.1@warthog.procyon.org.uk>
Date:   Tue, 31 Mar 2020 22:14:15 +0100
Message-ID: <2415050.1585689255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> So even the p2 method will give at least 80k queries/s, which is quite
> good, considering that the need to rescan the complete mount tree
> should be exceedingly rare (and in case it mattered, could be
> optimized by priming from /proc/self/mountinfo).

One thing to note is that the test is actually a little biased in favour of
the "p" test, where the mnt_id is looked up by path from /proc/fdinfo.  That's
not all that useful, except as an index into mountfs.  I'm not sure how much
use it as a check on whether the mount is the same mount or not since mount
IDs can get reused.

If I instead use the parent_id all round as the desired target value, I then
see:

For 10000 mounts, f=22899us f2=18240us p=101054us p2=117273us <-- prev email
For 10000 mounts, f=24853us f2=20453us p=235581us p2= 59798us <-- parent_id

Some observations:

 (1) fsinfo() gets a bit slower, reflecting the extra locking that must be
     done to access the topology information (it's using a different
     attribute).

 (2) Going via /proc/fdinfo now includes further a access into mountfs - and
     this makes the access ~2.3x slower than it was before.

 (3) Going via mount ID directly into mountfs (the "p2" test) appears faster
     than it did (when it shouldn't have changed), though it's still slower
     than fsinfo.  This I ascribe to the caching of the inode and dentry from
     the "p" test.

The attached patch adjusts the test program.

David
---
commit e9844e27f3061e4ef2d1511786b5ea60338dc610
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 31 21:14:58 2020 +0100

    Get parent ID instead

diff --git a/samples/vfs/test-fsinfo-perf.c b/samples/vfs/test-fsinfo-perf.c
index fba40737f768..2bcde06ee78b 100644
--- a/samples/vfs/test-fsinfo-perf.c
+++ b/samples/vfs/test-fsinfo-perf.c
@@ -69,27 +69,27 @@ static void do_umount(void)
 		perror("umount");
 }
 
-static unsigned long sum_mnt_id;
+static unsigned long sum_check, sum_check_2;
 
-static void get_mntid_by_fsinfo(int ix, const char *path)
+static void get_id_by_fsinfo(int ix, const char *path)
 {
-	struct fsinfo_mount_info r;
+	struct fsinfo_mount_topology r;
 	struct fsinfo_params params = {
 		.flags		= FSINFO_FLAGS_QUERY_PATH,
-		.request	= FSINFO_ATTR_MOUNT_INFO,
+		.request	= FSINFO_ATTR_MOUNT_TOPOLOGY,
 	};
 
 	ERR(fsinfo(AT_FDCWD, path, &params, sizeof(params), &r, sizeof(r)),
 	    "fsinfo");
-	//printf("[%u] %u\n", ix, r.mnt_id);
-	sum_mnt_id += r.mnt_id;
+	sum_check += r.parent_id;
+	sum_check_2 += r.mnt_topology_changes;
 }
 
-static void get_mntid_by_proc(int ix, const char *path)
+static void get_id_by_proc(int ix, const char *path)
 {
-	unsigned int mnt_id;
+	unsigned int mnt_id, x;
 	ssize_t len;
-	char procfile[100], buffer[4096], *p, *nl;
+	char procfile[100], buffer[4096], *p, *q, *nl;
 	int fd, fd2;
 
 	fd = open(path, O_PATH);
@@ -130,12 +130,31 @@ static void get_mntid_by_proc(int ix, const char *path)
 		exit(3);
 	}
 
-	sum_mnt_id += mnt_id;
-	//printf("[%u] %u\n", ix, mnt_id);
+	/* Now look the ID up on mountfs */
+	sprintf(procfile, "/mnt/%u/parent", mnt_id);
+	fd = open(procfile, O_RDONLY);
+	ERR(fd, procfile);
+	len = read(fd, buffer, sizeof(buffer) - 1);
+	ERR(len, "read/parent");
+	close(fd);
+	if (len > 0 && buffer[len - 1] == '\n')
+		len--;
+	buffer[len] = 0;
+
+	x = strtoul(buffer, &q, 10);
+
+	if (*q) {
+		fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+		exit(3);
+	}
+
+	sum_check += x;
+	//printf("[%u] %u\n", ix, x);
 }
 
-static void get_mntid_by_fsinfo_2(void)
+static void get_id_by_fsinfo_2(void)
 {
+	struct fsinfo_mount_topology t;
 	struct fsinfo_mount_child *children, *c, *end;
 	struct fsinfo_mount_info r;
 	struct fsinfo_params params = {
@@ -171,15 +190,16 @@ static void get_mntid_by_fsinfo_2(void)
 	for (i = 0; c < end; c++, i++) {
 		//printf("[%u] %u\n", i, c->mnt_id);
 		params.flags	= FSINFO_FLAGS_QUERY_MOUNT;
-		params.request	= FSINFO_ATTR_MOUNT_INFO;
+		params.request	= FSINFO_ATTR_MOUNT_TOPOLOGY;
 		sprintf(name, "%u", c->mnt_id);
-		ERR(fsinfo(AT_FDCWD, name, &params, sizeof(params), &r, sizeof(r)),
+		ERR(fsinfo(AT_FDCWD, name, &params, sizeof(params), &t, sizeof(t)),
 		    "fsinfo/child");
-		sum_mnt_id += r.mnt_id;
+		sum_check += t.parent_id;
+		sum_check_2 += t.mnt_topology_changes;
 	}
 }
 
-static void get_mntid_by_mountfs(void)
+static void get_id_by_mountfs(void)
 {
 	unsigned int base_mnt_id, mnt_id, x;
 	ssize_t len, s_children;
@@ -260,11 +280,11 @@ static void get_mntid_by_mountfs(void)
 			comma++;
 		}
 
-		sprintf(procfile, "%u/id", mnt_id);
+		sprintf(procfile, "%u/parent", mnt_id);
 		fd = openat(mntfd, procfile, O_RDONLY);
 		ERR(fd, procfile);
 		len = read(fd, buffer, sizeof(buffer) - 1);
-		ERR(len, "read/id");
+		ERR(len, "read/parent");
 		close(fd);
 		if (len > 0 && buffer[len - 1] == '\n')
 			len--;
@@ -278,7 +298,7 @@ static void get_mntid_by_mountfs(void)
 		}
 
 		if (0) printf("[%u] %u\n", i++, x);
-		sum_mnt_id += x;
+		sum_check += x;
 	} while (p = comma, *comma);
 }
 
@@ -318,32 +338,32 @@ int main(int argc, char **argv)
 	iterate(make_mount);
 
 	printf("--- test fsinfo by path ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&f_before, NULL), "gettimeofday");
-	iterate(get_mntid_by_fsinfo);
+	iterate(get_id_by_fsinfo);
 	ERR(gettimeofday(&f_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test fsinfo by mnt_id ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&f2_before, NULL), "gettimeofday");
-	get_mntid_by_fsinfo_2();
+	get_id_by_fsinfo_2();
 	ERR(gettimeofday(&f2_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test /proc/fdinfo ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&p_before, NULL), "gettimeofday");
-	iterate(get_mntid_by_proc);
+	iterate(get_id_by_proc);
 	ERR(gettimeofday(&p_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test mountfs ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&p2_before, NULL), "gettimeofday");
-	get_mntid_by_mountfs();
+	get_id_by_mountfs();
 	ERR(gettimeofday(&p2_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	f_dur  = duration(&f_before,  &f_after);
 	f2_dur = duration(&f2_before, &f2_after);

