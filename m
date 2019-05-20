Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6522B56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfETFmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:42:46 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38613 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729724AbfETFlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:41:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84B5C4220;
        Mon, 20 May 2019 01:41:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rfKadsTflryLW7911DaQh925XQ0k2Bp3gi/G7eAxyJQ=; b=rV/ImNkG
        ycR32d1zRF48xl4Dc39cUienWu0iKlmdVUToUwm52yebhEK1C11Ucvr7tt0z8qJm
        iAtm3aaFFTJywcEtPiGVKcMGQTjMGvJt/vJ2Ne4ejracT8MrL3WjCjadCF0r6EJN
        OVbo6k05gTSJkCgDCXtHKFKBRXrc8TZUX1ey8kVL4oeZx8GAHUC4hBe5kt6Ry44T
        wu3V/xWcFF2jMiS2AJ/MOwHmI81KsxXnHOyh12Ce+QJ6SCDx9R+7NM1MTD6e88WT
        uI7d2gzOXVe535PQKo5vvdm4fu/7prpiTDuCaEEKWodgyNsRUnQKHsbggHfxA0do
        zI51yaCTbT1iPg==
X-ME-Sender: <xms:Gj7iXP7qBcPaJDO_tVlzfAtrGuXzKQiPkdIijGevuR6Xy6CCEdvmrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepge
X-ME-Proxy: <xmx:Gj7iXNtPh7_ndKFdgL6upR2PGIWMotaoLYzqjyrv8tTelHt-yJm32A>
    <xmx:Gj7iXHxzEUSuHYmodLkxUZhidrLlzYpo5yBF8F1n7A-HwWuAGQgHHA>
    <xmx:Gj7iXFaYrkIschBz-zYkxsO682yyzYZmSpwwONPgmuiDvjzwTaSBfg>
    <xmx:Gj7iXN5O0KeG_8AZ-7o0G0Fexm94-QmCiQY8o__wm5A8smUdzSkoww>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F46A8005B;
        Mon, 20 May 2019 01:41:39 -0400 (EDT)
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
Subject: [RFC PATCH v5 05/16] tools/vm/slabinfo: Add remote node defrag ratio output
Date:   Mon, 20 May 2019 15:40:06 +1000
Message-Id: <20190520054017.32299-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add output line for NUMA remote node defrag ratio.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index cbfc56c44c2f..d2c22f9ee2d8 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -34,6 +34,7 @@ struct slabinfo {
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
 	int movable, ctor;
+	int remote_node_defrag_ratio;
 	unsigned long partial, objects, slabs, objects_partial, objects_total;
 	unsigned long alloc_fastpath, alloc_slowpath;
 	unsigned long free_fastpath, free_slowpath;
@@ -377,6 +378,10 @@ static void slab_numa(struct slabinfo *s, int mode)
 	if (skip_zero && !s->slabs)
 		return;
 
+	if (mode) {
+		printf("\nNUMA remote node defrag ratio: %3d\n",
+		       s->remote_node_defrag_ratio);
+	}
 	if (!line) {
 		printf("\n%-21s:", mode ? "NUMA nodes" : "Slab");
 		for(node = 0; node <= highest_node; node++)
@@ -1272,6 +1277,8 @@ static void read_slab_dir(void)
 			slab->cpu_partial_free = get_obj("cpu_partial_free");
 			slab->alloc_node_mismatch = get_obj("alloc_node_mismatch");
 			slab->deactivate_bypass = get_obj("deactivate_bypass");
+			slab->remote_node_defrag_ratio =
+					get_obj("remote_node_defrag_ratio");
 			chdir("..");
 			if (read_slab_obj(slab, "ops")) {
 				if (strstr(buffer, "ctor :"))
-- 
2.21.0

