Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4188519A0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgCaVX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728428AbgCaVX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdKjTVX18IqyNBqRWdSsTRvI99+3muYbESJ573ASbEo=;
        b=HjvczhvZj1WO+F97DeoSEymelypxd8Q5FF1gDq9o/iBBYWWmThsaIa+RHKvq6fXbM9alOj
        a7PMIseVIhC76YNCOnxQdP7V+kyYGSf/79T7gjvvnK8y/yIGBCbtACtMlxQGdqj9PKdVD8
        IwY4HPGd2VMqodqkovs9Vyooh/X4Q5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-kR0F5A6YO_qT3-8n2pJcLQ-1; Tue, 31 Mar 2020 17:23:55 -0400
X-MC-Unique: kR0F5A6YO_qT3-8n2pJcLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5191107ACCA;
        Tue, 31 Mar 2020 21:23:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C53FF5C1BB;
        Tue, 31 Mar 2020 21:23:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2415050.1585689255@warthog.procyon.org.uk>
References: <2415050.1585689255@warthog.procyon.org.uk> <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <2294742.1585675875@warthog.procyon.org.uk>
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
Content-ID: <2415895.1585689830.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 31 Mar 2020 22:23:50 +0100
Message-ID: <2415896.1585689830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > So even the p2 method will give at least 80k queries/s, which is quite
> > good, considering that the need to rescan the complete mount tree
> > should be exceedingly rare (and in case it mattered, could be
> > optimized by priming from /proc/self/mountinfo).
> =

> One thing to note is that the test is actually a little biased in favour=
 of
> the "p" test, where the mnt_id is looked up by path from /proc/fdinfo.  =
That's
> not all that useful, except as an index into mountfs.  I'm not sure how =
much
> use it as a check on whether the mount is the same mount or not since mo=
unt
> IDs can get reused.

However, to deal with an overrun, you're going to have to read multiple
attributes.  So I've added an attribute file to expose the topology change
counter and it now reads that as well.

For 10000 mounts, f=3D22899us f2=3D18240us p=3D101054us p2=3D117273us <-- =
prev email
For 10000 mounts, f=3D24853us f2=3D20453us p=3D235581us p2=3D 59798us <-- =
parent_id
For 10000 mounts, f=3D24621us f2=3D20528us p=3D320164us p2=3D111416us <-- =
counter

Probably unsurprisingly, this doesn't affect fsinfo() significantly since =
I've
tried to expose the change counters in relevant places.  It does, however,
significantly affect mountfs because you seem to want every value to be
exposed through its own file.

Now this can be worked around by having files that bundle up several value=
s
that are of interest to a particular operation (e.g. rescanning after a
notification queue overrun).

See the attached additional patch.  Note that the

	sum_check_2 +=3D r.mnt_topology_changes;

bits in the fsinfo() tests accidentally got left in the preceding patch an=
d so
aren't in this one.

David
---
commit 6c62787aec41f67c1d5a55a0d59578854bcef6f8
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 31 21:53:11 2020 +0100

    Add a mountfs file to export the topology counter

diff --git a/fs/mountfs/super.c b/fs/mountfs/super.c
index 82c01eb6154d..58c05feb4fdd 100644
--- a/fs/mountfs/super.c
+++ b/fs/mountfs/super.c
@@ -22,7 +22,7 @@ struct mountfs_entry {
 =

 static const char *mountfs_attrs[] =3D {
 	"root", "mountpoint", "id", "parent", "options", "children",
-	"group", "master", "propagate_from"
+	"group", "master", "propagate_from", "counter"
 };
 =

 #define MOUNTFS_INO(id) (((unsigned long) id + 1) * \
@@ -128,6 +128,8 @@ static int mountfs_attr_show(struct seq_file *sf, void=
 *v)
 			if (tmp)
 				seq_printf(sf, "%i\n", tmp);
 		}
+	} else if (strcmp(name, "counter") =3D=3D 0) {
+		seq_printf(sf, "%u\n", atomic_read(&mnt->mnt_topology_changes));
 	} else {
 		WARN_ON(1);
 		err =3D -EIO;
diff --git a/samples/vfs/test-fsinfo-perf.c b/samples/vfs/test-fsinfo-perf=
.c
index 2bcde06ee78b..2b7606a53c2d 100644
--- a/samples/vfs/test-fsinfo-perf.c
+++ b/samples/vfs/test-fsinfo-perf.c
@@ -149,6 +149,26 @@ static void get_id_by_proc(int ix, const char *path)
 	}
 =

 	sum_check +=3D x;
+
+	/* And now the topology change counter */
+	sprintf(procfile, "/mnt/%u/counter", mnt_id);
+	fd =3D open(procfile, O_RDONLY);
+	ERR(fd, procfile);
+	len =3D read(fd, buffer, sizeof(buffer) - 1);
+	ERR(len, "read/counter");
+	close(fd);
+	if (len > 0 && buffer[len - 1] =3D=3D '\n')
+		len--;
+	buffer[len] =3D 0;
+
+	x =3D strtoul(buffer, &q, 10);
+
+	if (*q) {
+		fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+		exit(3);
+	}
+
+	sum_check_2 +=3D x;
 	//printf("[%u] %u\n", ix, x);
 }
 =

@@ -204,7 +224,7 @@ static void get_id_by_mountfs(void)
 	unsigned int base_mnt_id, mnt_id, x;
 	ssize_t len, s_children;
 	char procfile[100], buffer[100], *children, *p, *q, *nl, *comma;
-	int fd, fd2, mntfd, i;
+	int fd, fd2, mntfd;
 =

 	/* Start off by reading the mount ID from the base path */
 	fd =3D open(base_path, O_PATH);
@@ -269,7 +289,6 @@ static void get_id_by_mountfs(void)
 	p =3D children;
 	if (!*p)
 		return;
-	i =3D 0;
 	do {
 		mnt_id =3D strtoul(p, &comma, 10);
 		if (*comma) {
@@ -297,8 +316,26 @@ static void get_id_by_mountfs(void)
 			exit(3);
 		}
 =

-		if (0) printf("[%u] %u\n", i++, x);
 		sum_check +=3D x;
+
+		sprintf(procfile, "%u/counter", mnt_id);
+		fd =3D openat(mntfd, procfile, O_RDONLY);
+		ERR(fd, procfile);
+		len =3D read(fd, buffer, sizeof(buffer) - 1);
+		ERR(len, "read/counter");
+		close(fd);
+		if (len > 0 && buffer[len - 1] =3D=3D '\n')
+			len--;
+		buffer[len] =3D 0;
+
+		x =3D strtoul(buffer, &q, 10);
+
+		if (*q) {
+			fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+			exit(3);
+		}
+
+		sum_check_2 +=3D x;
 	} while (p =3D comma, *comma);
 }
 =


