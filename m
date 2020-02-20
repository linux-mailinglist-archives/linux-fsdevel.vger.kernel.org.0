Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81891667F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgBTUGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:06:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48059 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729043AbgBTUGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582229201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiv+hFypyOtyHQ75Ev+LMGFV0c8VrCNpawf4WxNY7Yw=;
        b=It5xKGkQrjbTsrJYd71P6meT3eWGBXwZFaKadHPpnFE02QtYrZriWIu9QaUgF//313eqgN
        F6jPevt9WGIquqsr1KGwkPgKBgj3UxJtqWLaKlGMsFSIA76iWqf6ZhgpD1VxOApTs3u0LG
        REQxukUoDm/16XWMX6eroNXmrwkTEEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-X4oQB5BTOPe3qAk79UdDpw-1; Thu, 20 Feb 2020 15:06:36 -0500
X-MC-Unique: X4oQB5BTOPe3qAk79UdDpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE4E18010E5;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A8EE388;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
        id 99542203CFC0; Thu, 20 Feb 2020 15:06:34 -0500 (EST)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V2 2/3] t_mmap_collision: fix hard-coded page size
Date:   Thu, 20 Feb 2020 15:06:31 -0500
Message-Id: <20200220200632.14075-3-jmoyer@redhat.com>
In-Reply-To: <20200220200632.14075-1-jmoyer@redhat.com>
References: <20200220200632.14075-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the test to run on non-4k page size systems.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 src/t_mmap_collision.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/src/t_mmap_collision.c b/src/t_mmap_collision.c
index d547bc05..c872f4e2 100644
--- a/src/t_mmap_collision.c
+++ b/src/t_mmap_collision.c
@@ -25,13 +25,12 @@
 #include <sys/types.h>
 #include <unistd.h>
=20
-#define PAGE(a) ((a)*0x1000)
-#define FILE_SIZE PAGE(4)
-
 void *dax_data;
 int nodax_fd;
 int dax_fd;
 bool done;
+static int pagesize;
+static int file_size;
=20
 #define err_exit(op)                                                    =
      \
 {                                                                       =
      \
@@ -49,18 +48,18 @@ void punch_hole_fn(void *ptr)
 		read =3D 0;
=20
 		do {
-			rc =3D pread(nodax_fd, dax_data + read, FILE_SIZE - read,
+			rc =3D pread(nodax_fd, dax_data + read, file_size - read,
 					read);
 			if (rc > 0)
 				read +=3D rc;
 		} while (rc > 0);
=20
-		if (read !=3D FILE_SIZE || rc !=3D 0)
+		if (read !=3D file_size || rc !=3D 0)
 			err_exit("pread");
=20
 		rc =3D fallocate(dax_fd,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, FILE_SIZE);
+				0, file_size);
 		if (rc < 0)
 			err_exit("fallocate");
=20
@@ -81,18 +80,18 @@ void zero_range_fn(void *ptr)
 		read =3D 0;
=20
 		do {
-			rc =3D pread(nodax_fd, dax_data + read, FILE_SIZE - read,
+			rc =3D pread(nodax_fd, dax_data + read, file_size - read,
 					read);
 			if (rc > 0)
 				read +=3D rc;
 		} while (rc > 0);
=20
-		if (read !=3D FILE_SIZE || rc !=3D 0)
+		if (read !=3D file_size || rc !=3D 0)
 			err_exit("pread");
=20
 		rc =3D fallocate(dax_fd,
 				FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
-				0, FILE_SIZE);
+				0, file_size);
 		if (rc < 0)
 			err_exit("fallocate");
=20
@@ -113,11 +112,11 @@ void truncate_down_fn(void *ptr)
=20
 		if (ftruncate(dax_fd, 0) < 0)
 			err_exit("ftruncate");
-		if (fallocate(dax_fd, 0, 0, FILE_SIZE) < 0)
+		if (fallocate(dax_fd, 0, 0, file_size) < 0)
 			err_exit("fallocate");
=20
 		do {
-			rc =3D pread(nodax_fd, dax_data + read, FILE_SIZE - read,
+			rc =3D pread(nodax_fd, dax_data + read, file_size - read,
 					read);
 			if (rc > 0)
 				read +=3D rc;
@@ -142,15 +141,15 @@ void collapse_range_fn(void *ptr)
 	while (!done) {
 		read =3D 0;
=20
-		if (fallocate(dax_fd, 0, 0, FILE_SIZE) < 0)
+		if (fallocate(dax_fd, 0, 0, file_size) < 0)
 			err_exit("fallocate 1");
-		if (fallocate(dax_fd, FALLOC_FL_COLLAPSE_RANGE, 0, PAGE(1)) < 0)
+		if (fallocate(dax_fd, FALLOC_FL_COLLAPSE_RANGE, 0, pagesize) < 0)
 			err_exit("fallocate 2");
-		if (fallocate(dax_fd, 0, 0, FILE_SIZE) < 0)
+		if (fallocate(dax_fd, 0, 0, file_size) < 0)
 			err_exit("fallocate 3");
=20
 		do {
-			rc =3D pread(nodax_fd, dax_data + read, FILE_SIZE - read,
+			rc =3D pread(nodax_fd, dax_data + read, file_size - read,
 					read);
 			if (rc > 0)
 				read +=3D rc;
@@ -192,6 +191,9 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
=20
+	pagesize =3D getpagesize();
+	file_size =3D 4 * pagesize;
+
 	dax_fd =3D open(argv[1], O_RDWR|O_CREAT, S_IRUSR|S_IWUSR);
 	if (dax_fd < 0)
 		err_exit("dax_fd open");
@@ -202,15 +204,15 @@ int main(int argc, char *argv[])
=20
 	if (ftruncate(dax_fd, 0) < 0)
 		err_exit("dax_fd ftruncate");
-	if (fallocate(dax_fd, 0, 0, FILE_SIZE) < 0)
+	if (fallocate(dax_fd, 0, 0, file_size) < 0)
 		err_exit("dax_fd fallocate");
=20
 	if (ftruncate(nodax_fd, 0) < 0)
 		err_exit("nodax_fd ftruncate");
-	if (fallocate(nodax_fd, 0, 0, FILE_SIZE) < 0)
+	if (fallocate(nodax_fd, 0, 0, file_size) < 0)
 		err_exit("nodax_fd fallocate");
=20
-	dax_data =3D mmap(NULL, FILE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED,
+	dax_data =3D mmap(NULL, file_size, PROT_READ|PROT_WRITE, MAP_SHARED,
 			dax_fd, 0);
 	if (dax_data =3D=3D MAP_FAILED)
 		err_exit("mmap");
@@ -220,7 +222,7 @@ int main(int argc, char *argv[])
 	run_test(&truncate_down_fn);
 	run_test(&collapse_range_fn);
=20
-	if (munmap(dax_data, FILE_SIZE) !=3D 0)
+	if (munmap(dax_data, file_size) !=3D 0)
 		err_exit("munmap");
=20
 	err =3D close(dax_fd);
--=20
2.19.1

