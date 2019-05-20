Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9621922B47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfETFlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:41:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54429 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfETFlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:41:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CCF6846EF;
        Mon, 20 May 2019 01:41:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=eB8W4ZifzOOx7n477C9lsHSgteznueDWRYbTVC4RGG4=; b=GbbDnSgm
        0kVZe8RNuEifClhviafSdIf6NVtk0GruV6Fn/MjenuqiXRGGoet1W8RyBsiTx2eJ
        KR2P/iazreJakJr9AVkSEzJA0WPSgdvAmKi0o6iNQjaVP0OlKwwfmIovSTbN0Yro
        HzUflNj+0yAYXx+hM1zie5xJ4bIc/Sn2+b7Hdl3qbH21xyoLdoPTB5JnAUyINPjw
        l7Iw5+ueEUGVCwHQ5nIJarApG0QFmrgTDpzjo+8+cypGNr6l8XmroCDGtVYwVDGQ
        gQLh5ZclTVb8T/VRLhmSSPQRWUKHrambSidQjQoY5/7RG7+bOd3EQSUQdSuzeOXc
        lJN1JwWphP9kJw==
X-ME-Sender: <xms:IT7iXHvkZzZJ73Oh9-8Z9lr9XbloaLxSyeWNikULZTiEvr9cADKr3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgephe
X-ME-Proxy: <xmx:IT7iXIt_iJeH1nYZeRk0ixxheLrYAYbiuUgTEWgEtjttKETfUtXBZQ>
    <xmx:IT7iXDrjB8CwR9rQNT6_bjXJr3AHTq2oCm7HlQn31mPtntzTfxO9Bg>
    <xmx:IT7iXKHAZ9GnJXF5JWy4NEVuQPRXhv2OgNBHuAWwZXHLPcBpw9vfbw>
    <xmx:IT7iXGuT5BhNNhBLBCeK__Yc45ySr4EC0Zh8WoWJ8IAZyeW4HnxV6Q>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id AEB008005B;
        Mon, 20 May 2019 01:41:46 -0400 (EDT)
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
Subject: [RFC PATCH v5 06/16] tools/vm/slabinfo: Add defrag_used_ratio output
Date:   Mon, 20 May 2019 15:40:07 +1000
Message-Id: <20190520054017.32299-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add output for the newly added defrag_used_ratio sysfs knob.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index d2c22f9ee2d8..ef4ff93df4cc 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -34,6 +34,7 @@ struct slabinfo {
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	int movable, ctor;
+	int defrag_used_ratio;
 	int remote_node_defrag_ratio;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
@@ -549,6 +550,8 @@ static void report(struct slabinfo *s)
 		printf("** Slabs are destroyed via RCU\n");
 	if (s->reclaim_account)
 		printf("** Reclaim accounting active\n");
+	if (s->movable)
+		printf("** Defragmentation at %d%%\n", s->defrag_used_ratio);
 
 	printf("\nSizes (bytes)     Slabs              Debug                Memory\n");
 	printf("------------------------------------------------------------------------\n");
@@ -1279,6 +1282,7 @@ static void read_slab_dir(void)
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
 			slab->remote_node_defrag_ratio =
 					get_obj("remote_node_defrag_ratio");
+			slab->defrag_used_ratio = get_obj("defrag_used_ratio");
 			chdir("..");
 			if (read_slab_obj(slab, "ops")) {
 				if (strstr(buffer, "ctor :"))
-- 
2.21.0

