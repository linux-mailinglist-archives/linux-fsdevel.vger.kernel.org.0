Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7143034E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhJPPbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 11:31:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:38831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233277AbhJPPbK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634398134;
        bh=J13Dx4uPotohs9D4Qpydrd+/Njhs/osNqDCeRZZnD8s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NAq7A3b9YYpSCKu09vvHItDs1FP9ZQ+9yCMK4b2aUz0bPHW5OCboAVrRtxiO6YMhu
         K9odA1aZO3QxZq0z+CLPF8kJmqRImONJjRmfWJBL0n7unAoPUn2eyDK80ravfiCj5P
         i1hiAcDUE0uwQhS8H+/ylSXEBRZRNs0Ek3BSaxEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MiaY9-1nG3qD1dSx-00fjNY; Sat, 16 Oct 2021 17:28:54 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Avoid open coded arithmetic in memory allocator functions
Date:   Sat, 16 Oct 2021 17:28:28 +0200
Message-Id: <20211016152829.9836-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qv513pmeFF7TO+Zf2DoDcRwIg/VXHjkNLP9KQJSgX5tvxsPG4+0
 K6GdBlrW3RO4lHeLlrOpWbDtVBWzWvEExMEMLFsa72X+fBvXjR5KV8A3/pksKxXZ9QN6siQ
 bin7U24evoLwTRP185dE8ZJa4x0wly3+BF9878wn63YH5Udo0Rh2M9IO+jd40POM7hQNK8l
 okDTv3gMG73gGoA8VRlwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SgUEBrrfJ4M=:vBFyDkL9981zzTlAHcZeAu
 s3Bmo31/WEC0Hp3cfTrJ58spd2g1OoaNa2RFkag5Pf63y+nw0U+k9DjOtQVGCixGumprl/7su
 whpkaDGaJzBoQWqENUlJsgC/OFxuBlDH43bVVs1HzFDam2Hokqy+q0MMD99LCdTv4B1+vRXA5
 krSWe1BCIw8Jw+Qe0aUJQ91JdosXp0XuO11fiF56iDzdJpaJCtf3cUW4pdRXpbSrm+GnwiRiO
 D7dhpv4JQtJDWSouap6Bb9rnYyYgiXUzrU+TfY1s6whujW8yncSIkhtMZIKuYBSCQITTCKR/d
 vcrVOjohVBJhg04SFDgrmkqNHelzNtNbd6pQbfQc2WjTcI+wYX2g0BmadxqNI6nSt43aoDIwU
 PRn6HJdgka6p2WcNuc79vk6pK5R1gV6d1HQyXmn4LJx9FUarFUFfwwyFsxR2GV1Rfxa1J2Ilz
 5KGnFyFkqIqVM+UZqP0Ui4WTbOKGZufiYxcHw6R8ZIHjkT8ySqXoLWSs+b01E1LgTyIpaboPK
 fkR9djsZoXn15agqnyrmUl0LBVSqwpHimGFwYSvIaotxpnVADMMKt9YlN7uk8r6YJLogb0BZb
 RPTVM32usnKDVw87WPTsCiU5X+d9TGyLJ/VktVRhx7kv8y3Q6vxj8GknbxnRNIlcXw6y0cdWc
 i4u+Ma19RJhnJb9sYSAWkzJV2g8/D+/o0mgi5ihiRTpdfgqjOdiR7NTKJyKlcCqpQ3XYpeGLj
 z6h984R6T7P9Vt3tWVoc4i78rqDh0vrO6/cc7qrOhjOX40asSzPQypjVNlXpHaS3VhKvFY4D1
 VNBCHcnZiceCdMN7zR5JxNe56Yj6rtN85c2osDwCBkMuL4XY1XOQjsFVTLUmyW8hNzEUhwaAu
 /pZOSY0PM4T349gb3wDMDCOiD6srKkJs7Bd3MBz995dIwSMOD+a4Bb3qEJ8zYcaticqdMPSLx
 /dAnTtdtxFQjDCETd2cAROQOwQUB1rINoKuPR1W+b7OEVrlXODMgeV+lrp/ImshxT8IFC/uQ4
 g7Ty95wGf097nrqCdBxA14minSDBdgyNGk/6nFqJNWamHwbTRdgz7UIPyCj8BYpZyLtdHsrLC
 +t0ITv2Q+w6CTQ=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, add some functions to calculate the size used in memory allocator
function arguments, saturating to SIZE_MAX on overflow. Here it is not
possible to use the struct_size() helper since the memory layouts used
when the memory is allocated are not simple ones.

However, for the kcalloc() case, don't define a new function and check
for overflow before its call.

This code was detected with the help of Coccinelle and audited and fixed
manually.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi,

this patch is built against the linux-next tree (tag next-20211015).

Regards,
Len

 fs/proc/proc_sysctl.c | 114 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 14 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5d66faecd4ef..35734bc5e67e 100644
=2D-- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -942,6 +942,24 @@ static struct ctl_dir *find_subdir(struct ctl_dir *di=
r,
 	return container_of(head, struct ctl_dir, header);
 }

+static size_t new_dir_size(size_t namelen)
+{
+	size_t bytes;
+
+	if (check_add_overflow(sizeof(struct ctl_dir), sizeof(struct ctl_node),
+			       &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, array_size(sizeof(struct ctl_table), 2),
+			       &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, namelen, &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, (size_t)1, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
 static struct ctl_dir *new_dir(struct ctl_table_set *set,
 			       const char *name, int namelen)
 {
@@ -950,9 +968,15 @@ static struct ctl_dir *new_dir(struct ctl_table_set *=
set,
 	struct ctl_node *node;
 	char *new_name;

-	new =3D kzalloc(sizeof(*new) + sizeof(struct ctl_node) +
-		      sizeof(struct ctl_table)*2 +  namelen + 1,
-		      GFP_KERNEL);
+	/*
+	 * Allocation layout in bytes:
+	 *
+	 * sizeof(struct ctl_dir) +
+	 * sizeof(struct ctl_node) +
+	 * sizeof(struct ctl_table) * 2 +
+	 * namelen + 1
+	 */
+	new =3D kzalloc(new_dir_size(namelen), GFP_KERNEL);
 	if (!new)
 		return NULL;

@@ -1146,6 +1170,26 @@ static int sysctl_check_table(const char *path, str=
uct ctl_table *table)
 	return err;
 }

+static size_t new_links_size(size_t nr_entries, size_t name_bytes)
+{
+	size_t bytes;
+
+	if (check_add_overflow(nr_entries, (size_t)1, &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(sizeof(struct ctl_table_header),
+			       array_size(sizeof(struct ctl_node), nr_entries),
+			       &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, array_size(sizeof(struct ctl_table),
+						 nr_entries + 1),
+			       &bytes))
+		return SIZE_MAX;
+	if (check_add_overflow(bytes, name_bytes, &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
 static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl=
_table *table,
 	struct ctl_table_root *link_root)
 {
@@ -1162,11 +1206,15 @@ static struct ctl_table_header *new_links(struct c=
tl_dir *dir, struct ctl_table
 		name_bytes +=3D strlen(entry->procname) + 1;
 	}

-	links =3D kzalloc(sizeof(struct ctl_table_header) +
-			sizeof(struct ctl_node)*nr_entries +
-			sizeof(struct ctl_table)*(nr_entries + 1) +
-			name_bytes,
-			GFP_KERNEL);
+	/*
+	 * Allocation layout in bytes:
+	 *
+	 * sizeof(struct ctl_table_header) +
+	 * sizeof(struct ctl_node) * nr_entries +
+	 * sizeof(struct ctl_table) * (nr_entries + 1) +
+	 * name_bytes
+	 */
+	links =3D kzalloc(new_links_size(nr_entries, name_bytes), GFP_KERNEL);

 	if (!links)
 		return NULL;
@@ -1258,6 +1306,18 @@ static int insert_links(struct ctl_table_header *he=
ad)
 	return err;
 }

+static inline size_t sysctl_table_size(int nr_entries)
+{
+	size_t bytes;
+
+	if (check_add_overflow(sizeof(struct ctl_table_header),
+			       array_size(sizeof(struct ctl_node), nr_entries),
+			       &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
 /**
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
@@ -1315,8 +1375,13 @@ struct ctl_table_header *__register_sysctl_table(
 	for (entry =3D table; entry->procname; entry++)
 		nr_entries++;

-	header =3D kzalloc(sizeof(struct ctl_table_header) +
-			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL);
+	/*
+	 * Allocation layout in bytes:
+	 *
+	 * sizeof(struct ctl_table_header) +
+	 * sizeof(struct ctl_node) * nr_entries
+	 */
+	header =3D kzalloc(sysctl_table_size(nr_entries), GFP_KERNEL);
 	if (!header)
 		return NULL;

@@ -1437,8 +1502,11 @@ static int register_leaf_sysctl_tables(const char *=
path, char *pos,
 	/* If there are mixed files and directories we need a new table */
 	if (nr_dirs && nr_files) {
 		struct ctl_table *new;
-		files =3D kcalloc(nr_files + 1, sizeof(struct ctl_table),
-				GFP_KERNEL);
+		int n;
+
+		if (unlikely(check_add_overflow(nr_files, 1, &n)))
+			goto out;
+		files =3D kcalloc(n, sizeof(struct ctl_table), GFP_KERNEL);
 		if (!files)
 			goto out;

@@ -1490,6 +1558,19 @@ static int register_leaf_sysctl_tables(const char *=
path, char *pos,
 	return err;
 }

+static inline size_t sysctl_paths_size(int nr_subheaders)
+{
+	size_t bytes;
+
+	if (check_add_overflow(sizeof(struct ctl_table_header),
+			       array_size(sizeof(struct ctl_table_header *),
+					  nr_subheaders),
+			       &bytes))
+		return SIZE_MAX;
+
+	return bytes;
+}
+
 /**
  * __register_sysctl_paths - register a sysctl table hierarchy
  * @set: Sysctl tree to register on
@@ -1532,8 +1613,13 @@ struct ctl_table_header *__register_sysctl_paths(
 		if (header)
 			header->ctl_table_arg =3D ctl_table_arg;
 	} else {
-		header =3D kzalloc(sizeof(*header) +
-				 sizeof(*subheaders)*nr_subheaders, GFP_KERNEL);
+		/*
+		 * Allocation layout in bytes:
+		 *
+		 * sizeof(struct ctl_table_header) +
+		 * sizeof(struct ctl_table_header *) * nr_subheaders
+		 */
+		header =3D kzalloc(sysctl_paths_size(nr_subheaders), GFP_KERNEL);
 		if (!header)
 			goto out;

=2D-
2.25.1

