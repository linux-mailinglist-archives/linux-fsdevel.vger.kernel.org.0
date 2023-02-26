Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF726A32CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBZQ04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZQ0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:26:54 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F11B2C4;
        Sun, 26 Feb 2023 08:26:53 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 8E101831BF;
        Sun, 26 Feb 2023 16:26:49 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677428813;
        bh=9m8PE6sXBOFOOOY6NkqZStqOnmlRwk8q43mx8hniEY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JT9v5qKVM1voQrmRYpgWpLLalX8AeNQ2wWeaC2DNNLGWvaUNKhhMMFVQ674uPkpdb
         QLxrSwjGffkMgo5c36Exrfh/Z830WWlowPdJuf9+Yng2BuKCCCFf9bBWYd6w7EA0YS
         hA2Je+hJ+pW9BK8lQF2EZ1q5OPsWksOk3q/RAPE+R8nLETUfIH6yMEV+dDK3uESyl5
         UZHMquwNIddXIzprSg+SAXzufhx0uC2QoSoQnM0Q2bDYm12o9vcwMxLN0FewZh8vg8
         5DddegOIKAhARFBYd4pTuuSv/JwelVf4IUb4iGsYrKLfdl/fMXB/viK8PEEPGnmOAs
         lACT6/6osOMQQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 1/2] Documentation: btrfs: Document wq_cpu_set mount option
Date:   Sun, 26 Feb 2023 23:26:38 +0700
Message-Id: <20230226162639.20559-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document a new Btrfs mount option, wq_cpu_set.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 Documentation/ch-mount-options.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index f0f205dc20fa15ff..48fe63ee5e95c297 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -451,6 +451,35 @@ user_subvol_rm_allowed
                 ordinary directory. Whether this is possible can be detected at runtime, see
                 *rmdir_subvol* feature in *FILESYSTEM FEATURES*.
 
+wq_cpu_set=<cpu_set>
+        (since: 6.5, default: all online CPUs)
+
+        Btrfs workqueues can slow sensitive user tasks down because they can use any
+        online CPU to perform heavy workloads on an SMP system. This option is used to
+        isolate the Btrfs workqueues to a set of CPUs. It is helpful to avoid
+        sensitive user tasks being preempted by Btrfs heavy workqueues.
+
+        The *cpu_set* is a dot-separated list of decimal numbers and ranges. The
+        numbers are CPU numbers, the ranges are inclusive. For example:
+
+                - *wq_cpu_set=0.3-7* will use CPUs 0, 3, 4, 5, 6 and 7.
+
+                - *wq_cpu_set=0.4.1.5* will use CPUs 0, 1, 4 and 5.
+
+        This option is similar to the taskset bitmask except that the comma separator
+        is replaced with a dot. The reason for this is that the mount option parser
+        uses commas to separate mount options.
+
+        If *wq_cpu_set* option is specificed and the *thread_pool* option is not, the
+        number of default max thread pool size will be set to the number of online
+        CPUs in the specified CPU set plus 2, if and only if the resulting number is
+        less than 8.
+
+        If *wq_cpu_set* option is specificed and the *thread_pool* option is also
+        specified, the thread pool size will be set to the value of *thread_pool*
+        option.
+
+
 DEPRECATED MOUNT OPTIONS
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
Ammar Faizi

