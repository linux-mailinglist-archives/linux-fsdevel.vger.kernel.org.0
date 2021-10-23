Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E7438342
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhJWK5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 06:57:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:44689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhJWK5H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634986475;
        bh=COO6dpoiujzVMnoUVgte956/CCfp4GDzWhe8zXEti5Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=URRFlir+kXtgwyTlzC/iYsQ+oqYmX1/VZlxKsAdPWkAySHEyrunSrXiEcPfILunuI
         N/DnLsMXLievdlcKiq/N22mtBrAkyF9NpzbrmFGqnxK7v8LRnu5aiBE9S1S/XZo47C
         //Z/ziVGe36iBlunaberdxUVwvk8e0sBQocdJHeY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MIwz4-1mOD9V00YE-00KRl8; Sat, 23 Oct 2021 12:54:35 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory allocator functions
Date:   Sat, 23 Oct 2021 12:54:14 +0200
Message-Id: <20211023105414.7316-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F+DT2aLDpJrmlZpG2V+TQYlDzxnApio7nZw40lIN2aby5QiyLZU
 6WBvxuH6OaOsIK8sityQpXvAl5wFpb7fV8qu402o19i92zEKl0L5Iijmbrd0B59Xln4ylys
 BzSWuf9WS2GLFAu3GQzihGDzWQxl0opzXLPyYPf1GFWQTG7ecoDgt7V0BNPno4cctLGW9QC
 TgPJ2S+y6d3de0qLNwWjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wnbhp08dKoY=:sjETeixsBVJ0AQ1ykKUq3t
 7F727P0Rf6IRsKMGqqD1qZIV1rS3XDDJl1u8VkDc/HU30lon3kO75mAv+xIRHM43Un5/je05k
 OZt+4dBBb7xXvFkq/qahYfT2tKmCE0N5xwVkS7g9iY55H3Wg9c3rKBy407Uc8ube7I4667IwY
 jMS8nnfLp/nstIs9tpYPjulSbvXaJJF5VvQNMjEsnGpDXVZdqnozc1cjetQ3gitvrnMEmZFQc
 tqzgm8FmLTC/qON2cZLt6ytJ3R9+rmshOcND5grxAvEM0v1+OmiIt6pivWQkVU9P8BDDGIRcs
 pgFzv9vVD7HhKN5nY27MRKhuPIHMa7F0f2DGN34nVa8aBTs/KSVuggyxkKUTEYAeCbxtzIjDE
 x8y/1EhbjeUKq3nYerEb55IGnWVIfHyt3T4U3ATjL3zU/pg+iYh9VdWiOhCOw+H4YxuBQcbRd
 AoY3rZVQThQVASXkuNMeP6CVIw8QRMpNqo+ZoQ5khjgab8nj1FVaq/JgsQlQma1RVsk8SqkKr
 YwyoBJB/N2fGOGfkP87TWPhE0HVA8S8SgQI7bEGxytFzO5nTfgTib5LzK30d4ZUoFh6d4dIFV
 apdkdTYVTbVGpJTWAZELmvaoDt5PoLw4dL2izXCE/bmCPTyzh9YJVOt+cDpBStq76JTk8xelO
 3LOetXm4/j7aFVrv3Rqp5LWNncv4ZiI00pQTaUvIY1PGD7t3Adf70YdRU7HmqKXdC7/owx6Nv
 oDtrZE5m7jWvNQubKoUvToqKEcghYMeskCa6EyhXLtyHj9txFIDt45GGM8zDamwm72KhQtwJE
 484vUVzzkcaC/TbM90SWz2Erc0oTsXqo5sQivnqkV+OCtbdJJqFgZFpnBV9yLUpTnfVOnN95O
 6oiEtHfAQglGAcHMfDZhpK9xSrFUCwZMHkzfuuh4B9RZ9+yOLKfRb8pHR4WZbIb4IeWG+RZpo
 Mx6dEV4jwdAswhNejBAsAkp7MkpPTQ+2W1nKb0l3TZ3gsqxgDNicZP4eJRHA4Tdtkm1ZX9WNL
 l4hQhdLwk/eyrnT4EajKCwV+corNXeD3FZraqPD3B0Kw6AWccJaNCKWzGFI4TY0qP8ZG6vhOL
 K6Ws8EAnE6F9Wg=
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
Changelog v1 -> v2
- Remove the new_dir_size function and its use (Matthew Wilcox).

The previous version can be found here [1]

[1] https://lore.kernel.org/linux-hardening/20211016152829.9836-1-len.bake=
r@gmx.com/

 fs/proc/proc_sysctl.c | 84 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5d66faecd4ef..0b3b3f11ca11 100644
=2D-- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1146,6 +1146,26 @@ static int sysctl_check_table(const char *path, str=
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
@@ -1162,11 +1182,15 @@ static struct ctl_table_header *new_links(struct c=
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
@@ -1258,6 +1282,18 @@ static int insert_links(struct ctl_table_header *he=
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
@@ -1315,8 +1351,13 @@ struct ctl_table_header *__register_sysctl_table(
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

@@ -1437,8 +1478,11 @@ static int register_leaf_sysctl_tables(const char *=
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

@@ -1490,6 +1534,19 @@ static int register_leaf_sysctl_tables(const char *=
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
@@ -1532,8 +1589,13 @@ struct ctl_table_header *__register_sysctl_paths(
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

