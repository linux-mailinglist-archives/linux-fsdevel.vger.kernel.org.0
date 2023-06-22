Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7005D739A16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFVIkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFVIkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:40:08 -0400
Received: from out-20.mta1.migadu.com (out-20.mta1.migadu.com [IPv6:2001:41d0:203:375::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132D172C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:40:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687423205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w53NcBmn/IPVgjrXh3hKsvtsk7tDad26SsdH585QToY=;
        b=uZy8afIIaTcmGAVwL6Pco/ne9cw31HmEUrdetQu4BJTqJA7zlS9UK3eZ5SfX6giO4SjLQy
        PxnX2CgCeGRGVX7K17r1GkyPshe6W0lM18UnLTU7dFXZJdYjJyuXXudi6+jiw8yCyJhgh6
        L8fjpIGb1fLrLDxLVbx48z8ApZZu3BE=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 01/29] mm: shrinker: add shrinker::private_data field
Date:   Thu, 22 Jun 2023 08:39:04 +0000
Message-Id: <20230622083932.4090339-2-qi.zheng@linux.dev>
In-Reply-To: <20230622083932.4090339-1-qi.zheng@linux.dev>
References: <20230622083932.4090339-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

To prepare for the dynamic allocation of shrinker instances
embedded in other structures, add a private_data field to
struct shrinker, so that we can use shrinker::private_data
to record and get the original embedded structure.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..43e6fcabbf51 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -70,6 +70,8 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	void *private_data;
+
 	/* These are for internal use */
 	struct list_head list;
 #ifdef CONFIG_MEMCG
-- 
2.30.2

