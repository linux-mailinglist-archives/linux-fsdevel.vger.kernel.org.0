Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE30522B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfETFl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:41:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37517 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfETFlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:41:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AA07F3242;
        Mon, 20 May 2019 01:41:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bxV5jBaXvA/LKL0qOR0ZLSK5IIfdrfWAd0nyjsopfiM=; b=brPSfUHt
        HQXU8KIV4VyCcC+GuC0fXcMB0eb698X1lziIGBJKJQV+YM0rADkU+JlSFxcWmKFi
        2MvgcDOFDrFrtRghaKvg2pyJOqsgBJZkrVokqUkVPf5EcMEOvXsYusP+ohcAt44n
        k5ewq8PKHTVPqBh4ak1ePk9Ap48aMDgQ3M6OLTvltT685wf9sOeeVNGqt62rDrY3
        JgSAMVJ7+ySQVET1J/Emzh4sONr3oIrcb8wwids6WJcwYnZBmFkgLX+ABVPfktH0
        Vd1Q9emQYKND0WC/SM4z1wFr00TiHpnRP0lI1FZOXPr6SDDl92Io1SDXwnriXIe5
        ftkCG63PUufXHQ==
X-ME-Sender: <xms:BD7iXNJimFgRYs7Og9mFRGZhtHdrKnr7dNOnkdWLZU8PEb45ic4qqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:BD7iXCPVtPzig-Ku5j87ezbwnxrMSGdGVTbChAFx-guKv7boqMe8NQ>
    <xmx:BD7iXIpIYdniJPgdoIeePeirLQ6cXWbxv5J_4naNACI1LJ_vvOUK-A>
    <xmx:BD7iXLfufePuY97N4Dvo3xPZpbkZTzAYiV8Jrof_hIYjEB3Fld1kYw>
    <xmx:BD7iXOf8M6W4D2rfudj4uFUmyFwOIwvPEi8TlT1cbmZxvkp4COCAPQ>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 81E548005B;
        Mon, 20 May 2019 01:41:17 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 02/16] tools/vm/slabinfo: Add support for -C and -M options
Date:   Mon, 20 May 2019 15:40:03 +1000
Message-Id: <20190520054017.32299-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-C lists caches that use a ctor.

-M lists caches that support object migration.

Add command line options to show caches with a constructor and caches
that are movable (i.e. have migrate function).

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 73818f1b2ef8..cbfc56c44c2f 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -33,6 +33,7 @@ struct slabinfo {
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
+	int movable, ctor;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
@@ -67,6 +68,8 @@ int show_report;
 int show_alias;
 int show_slab;
 int skip_zero = 1;
+int show_movable;
+int show_ctor;
 int show_numa;
 int show_track;
 int show_first_alias;
@@ -109,11 +112,13 @@ static void fatal(const char *x, ...)
 
 static void usage(void)
 {
-	printf("slabinfo 4/15/2011. (c) 2007 sgi/(c) 2011 Linux Foundation.\n\n"
-		"slabinfo [-aADefhilnosrStTvz1LXBU] [N=K] [-dafzput] [slab-regexp]\n"
+	printf("slabinfo 4/15/2017. (c) 2007 sgi/(c) 2011 Linux Foundation/(c) 2017 Jump Trading LLC.\n\n"
+	       "slabinfo [-aACDefhilMnosrStTvz1LXBU] [N=K] [-dafzput] [slab-regexp]\n"
+
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-B|--Bytes             Show size in bytes\n"
+		"-C|--ctor              Show slabs with ctors\n"
 		"-D|--display-active    Switch line format to activity\n"
 		"-e|--empty             Show empty slabs\n"
 		"-f|--first-alias       Show first alias\n"
@@ -121,6 +126,7 @@ static void usage(void)
 		"-i|--inverted          Inverted list\n"
 		"-l|--slabs             Show slabs\n"
 		"-L|--Loss              Sort by loss\n"
+		"-M|--movable           Show caches that support movable objects\n"
 		"-n|--numa              Show NUMA information\n"
 		"-N|--lines=K           Show the first K slabs\n"
 		"-o|--ops               Show kmem_cache_ops\n"
@@ -588,6 +594,12 @@ static void slabcache(struct slabinfo *s)
 	if (show_empty && s->slabs)
 		return;
 
+	if (show_ctor && !s->ctor)
+		return;
+
+	if (show_movable && !s->movable)
+		return;
+
 	if (sort_loss == 0)
 		store_size(size_str, slab_size(s));
 	else
@@ -602,6 +614,10 @@ static void slabcache(struct slabinfo *s)
 		*p++ = '*';
 	if (s->cache_dma)
 		*p++ = 'd';
+	if (s->ctor)
+		*p++ = 'C';
+	if (s->movable)
+		*p++ = 'M';
 	if (s->hwcache_align)
 		*p++ = 'A';
 	if (s->poison)
@@ -636,7 +652,8 @@ static void slabcache(struct slabinfo *s)
 		printf("%-21s %8ld %7d %15s %14s %4d %1d %3ld %3ld %s\n",
 			s->name, s->objects, s->object_size, size_str, dist_str,
 			s->objs_per_slab, s->order,
-			s->slabs ? (s->partial * 100) / s->slabs : 100,
+			s->slabs ? (s->partial * 100) /
+					(s->slabs * s->objs_per_slab) : 100,
 			s->slabs ? (s->objects * s->object_size * 100) /
 				(s->slabs * (page_size << s->order)) : 100,
 			flags);
@@ -1256,6 +1273,13 @@ static void read_slab_dir(void)
 			slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
 			chdir("..");
+			if (read_slab_obj(slab, "ops")) {
+				if (strstr(buffer, "ctor :"))
+					slab->ctor = 1;
+				if (strstr(buffer, "migrate :"))
+					slab->movable = 1;
+			}
+
 			if (slab->name[0] == ':')
 				alias_targets++;
 			slab++;
@@ -1332,6 +1356,8 @@ static void xtotals(void)
 }
 
 struct option opts[] = {
+	{ "ctor", no_argument, NULL, 'C' },
+	{ "movable", no_argument, NULL, 'M' },
 	{ "aliases", no_argument, NULL, 'a' },
 	{ "activity", no_argument, NULL, 'A' },
 	{ "debug", optional_argument, NULL, 'd' },
@@ -1367,7 +1393,7 @@ int main(int argc, char *argv[])
 
 	page_size = getpagesize();
 
-	while ((c = getopt_long(argc, argv, "aAd::Defhil1noprstvzTSN:LXBU",
+	while ((c = getopt_long(argc, argv, "aACd::Defhil1MnoprstvzTSN:LXBU",
 						opts, NULL)) != -1)
 		switch (c) {
 		case '1':
@@ -1376,6 +1402,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			show_alias = 1;
 			break;
+		case 'C':
+			show_ctor = 1;
+			break;
 		case 'A':
 			sort_active = 1;
 			break;
@@ -1399,6 +1428,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			show_inverted = 1;
 			break;
+		case 'M':
+			show_movable = 1;
+			break;
 		case 'n':
 			show_numa = 1;
 			break;
-- 
2.21.0

