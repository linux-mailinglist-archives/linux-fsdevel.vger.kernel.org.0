Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7351DE0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 00:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfJTWRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 18:17:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726583AbfJTWRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 18:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571609870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ToBhWAEeBjIvJkh62QqZLUlNNUmIw5rQlwF9iuvC60U=;
        b=LGFNscPv9IiXdrQR7Pi2U8qdCa9227JmNw+Rn/pN+bSbj7OK6aivA8XXjhBAU1VxNkCKfE
        dYIFPoBs6+DdDYJ6VhCi9o7q8pv+lgIXp39AfrpoUCWQ4OftSVojcwR9Fl1wH3pjC0WuMA
        1g5lZ7eWuUzrKfeyK7CPuUdRIuv69G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-OsNYrM9cMQuslhkGZX3JcA-1; Sun, 20 Oct 2019 18:17:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444FE80183E;
        Sun, 20 Oct 2019 22:17:47 +0000 (UTC)
Received: from jsavitz.bos.com (ovpn-121-29.rdu2.redhat.com [10.10.121.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 466E760A35;
        Sun, 20 Oct 2019 22:17:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Fabrizio D'Angelo <Fabrizio_Dangelo@student.uml.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, fedora-rpi@googlegroups.com
Subject: [PATCH] fs: proc: Clarify warnings for invalid proc dir names
Date:   Sun, 20 Oct 2019 18:17:42 -0400
Message-Id: <20191020221742.5728-1-jsavitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OsNYrM9cMQuslhkGZX3JcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When one attempts to create a directory in /proc with an invalid name,
such as one in a subdirectory that doesn't exist, one with a name beyond
256 characters, or a reserved name such as '.' or '..', the kernel
throws a warning message that looks like this:

=09[ 7913.252558] name 'invalid_name'

This warning message is nearly the same for all invalid cases, including
the removal of a nonexistent directory. This patch clarifies the warning
message and differentiates the invalid creation/removal cases so as to
allow the user to more quickly understand their mistake.

Signed-off-by: Fabrizio D'Angelo <Fabrizio_Dangelo@student.uml.edu>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 fs/proc/generic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 64e9ee1b129e..df04fd4f02af 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -173,7 +173,7 @@ static int __xlate_proc_name(const char *name, struct p=
roc_dir_entry **ret,
 =09=09len =3D next - cp;
 =09=09de =3D pde_subdir_find(de, cp, len);
 =09=09if (!de) {
-=09=09=09WARN(1, "name '%s'\n", name);
+=09=09=09WARN(1, "invalid proc dir name '%s'\n", name);
 =09=09=09return -ENOENT;
 =09=09}
 =09=09cp +=3D len + 1;
@@ -386,15 +386,15 @@ static struct proc_dir_entry *__proc_create(struct pr=
oc_dir_entry **parent,
 =09qstr.name =3D fn;
 =09qstr.len =3D strlen(fn);
 =09if (qstr.len =3D=3D 0 || qstr.len >=3D 256) {
-=09=09WARN(1, "name len %u\n", qstr.len);
+=09=09WARN(1, "invalid proc dir name len %u\n", qstr.len);
 =09=09return NULL;
 =09}
 =09if (qstr.len =3D=3D 1 && fn[0] =3D=3D '.') {
-=09=09WARN(1, "name '.'\n");
+=09=09WARN(1, "invalid proc dir name '.'\n");
 =09=09return NULL;
 =09}
 =09if (qstr.len =3D=3D 2 && fn[0] =3D=3D '.' && fn[1] =3D=3D '.') {
-=09=09WARN(1, "name '..'\n");
+=09=09WARN(1, "invalid proc dir name '..'\n");
 =09=09return NULL;
 =09}
 =09if (*parent =3D=3D &proc_root && name_to_int(&qstr) !=3D ~0U) {
@@ -402,7 +402,7 @@ static struct proc_dir_entry *__proc_create(struct proc=
_dir_entry **parent,
 =09=09return NULL;
 =09}
 =09if (is_empty_pde(*parent)) {
-=09=09WARN(1, "attempt to add to permanently empty directory");
+=09=09WARN(1, "attempt to add to permanently empty directory in proc");
 =09=09return NULL;
 =09}
=20
@@ -670,7 +670,7 @@ void remove_proc_entry(const char *name, struct proc_di=
r_entry *parent)
 =09=09rb_erase(&de->subdir_node, &parent->subdir);
 =09write_unlock(&proc_subdir_lock);
 =09if (!de) {
-=09=09WARN(1, "name '%s'\n", name);
+=09=09WARN(1, "unable to remove nonexistent proc dir '%s'\n", name);
 =09=09return;
 =09}
=20
--=20
2.23.0

