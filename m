Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45F111B8DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 17:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfLKQcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 11:32:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730618AbfLKQcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576081937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nItcTzNLcVS9l9nbV5eLnvl+iOeDyCeQ4Ep0E6Im280=;
        b=Vr4R+tO7Fhf4h/mg3H+h/s/NiJsD2PwVfP6s4LEodWWHzOQkQxYTyprRPLjFVJzDEI1WSN
        NbHXgSFGnf2gdp+JQzfd9O5xMBNY97kJ7zCHl45RyErDXChAaz05N/ag/Ge2Ej+9tJs8e3
        RR6o1IZxtutJCsIBbiimInnOEtPLzzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ixmYRMiSMtC4rz-23nOpHw-1; Wed, 11 Dec 2019 11:32:14 -0500
X-MC-Unique: ixmYRMiSMtC4rz-23nOpHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51EF28CC677;
        Wed, 11 Dec 2019 16:32:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77348605FF;
        Wed, 11 Dec 2019 16:32:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/3] fs/proc/page.c: allow inspection of last section and fix end detection
Date:   Wed, 11 Dec 2019 17:32:00 +0100
Message-Id: <20191211163201.17179-3-david@redhat.com>
In-Reply-To: <20191211163201.17179-1-david@redhat.com>
References: <20191211163201.17179-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If max_pfn does not fall onto a section boundary, it is possible to inspe=
ct
PFNs up to max_pfn, and PFNs above max_pfn, however, max_pfn itself can't
be inspected. We can have a valid (and online) memmap at and above max_pf=
n
if max_pfn is not aligned to a section boundary. The whole early section
has a memmap and is marked online. Being able to inspect the state of the=
se
PFNs is valuable for debugging, especially because max_pfn can change on
memory hotplug and expose these memmaps.

Also, querying page flags via "./page-types -r -a 0x144001,"
(tools/vm/page-types.c) inside a x86-64 guest with 4160MB under QEMU
results in an (almost) endless loop in user space, because the end is
not detected properly when starting after max_pfn.

Instead, let's allow to inspect all pages in the highest section and
return 0 directly if we try to access pages above that section.

While at it, check the count before adjusting it, to avoid masking user
errors.

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/page.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index e40dbfe1168e..2984df28ccea 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -21,6 +21,21 @@
 #define KPMMASK (KPMSIZE - 1)
 #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
=20
+static inline unsigned long get_max_dump_pfn(void)
+{
+#ifdef CONFIG_SPARSEMEM
+	/*
+	 * The memmap of early sections is completely populated and marked
+	 * online even if max_pfn does not fall on a section boundary -
+	 * pfn_to_online_page() will succeed on all pages. Allow inspecting
+	 * these memmaps.
+	 */
+	return round_up(max_pfn, PAGES_PER_SECTION);
+#else
+	return max_pfn;
+#endif
+}
+
 /* /proc/kpagecount - an array exposing page counts
  *
  * Each entry is a u64 representing the corresponding
@@ -29,6 +44,7 @@
 static ssize_t kpagecount_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
+	const unsigned long max_dump_pfn =3D get_max_dump_pfn();
 	u64 __user *out =3D (u64 __user *)buf;
 	struct page *ppage;
 	unsigned long src =3D *ppos;
@@ -37,9 +53,11 @@ static ssize_t kpagecount_read(struct file *file, char=
 __user *buf,
 	u64 pcount;
=20
 	pfn =3D src / KPMSIZE;
-	count =3D min_t(size_t, count, (max_pfn * KPMSIZE) - src);
 	if (src & KPMMASK || count & KPMMASK)
 		return -EINVAL;
+	if (src >=3D max_dump_pfn * KPMSIZE)
+		return 0;
+	count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 	while (count > 0) {
 		/*
@@ -208,6 +226,7 @@ u64 stable_page_flags(struct page *page)
 static ssize_t kpageflags_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
+	const unsigned long max_dump_pfn =3D get_max_dump_pfn();
 	u64 __user *out =3D (u64 __user *)buf;
 	struct page *ppage;
 	unsigned long src =3D *ppos;
@@ -215,9 +234,11 @@ static ssize_t kpageflags_read(struct file *file, ch=
ar __user *buf,
 	ssize_t ret =3D 0;
=20
 	pfn =3D src / KPMSIZE;
-	count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
 	if (src & KPMMASK || count & KPMMASK)
 		return -EINVAL;
+	if (src >=3D max_dump_pfn * KPMSIZE)
+		return 0;
+	count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 	while (count > 0) {
 		/*
@@ -253,6 +274,7 @@ static const struct file_operations proc_kpageflags_o=
perations =3D {
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	const unsigned long max_dump_pfn =3D get_max_dump_pfn();
 	u64 __user *out =3D (u64 __user *)buf;
 	struct page *ppage;
 	unsigned long src =3D *ppos;
@@ -261,9 +283,11 @@ static ssize_t kpagecgroup_read(struct file *file, c=
har __user *buf,
 	u64 ino;
=20
 	pfn =3D src / KPMSIZE;
-	count =3D min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
 	if (src & KPMMASK || count & KPMMASK)
 		return -EINVAL;
+	if (src >=3D max_dump_pfn * KPMSIZE)
+		return 0;
+	count =3D min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
=20
 	while (count > 0) {
 		/*
--=20
2.23.0

