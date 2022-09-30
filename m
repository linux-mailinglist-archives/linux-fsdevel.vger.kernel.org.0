Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22B5F0A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiI3L07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiI3L02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE7A17586;
        Fri, 30 Sep 2022 04:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5875A62299;
        Fri, 30 Sep 2022 11:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B809DC4347C;
        Fri, 30 Sep 2022 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536728;
        bh=G3/t3BDJDz9EMHp0QOUkv/5jjrPwNlRd22Dc40GCbVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C25sKiNghUeIo8SwmYaYrlE+zqQ8SiqFO1YRyhXnVgyCIbnfvq9wmQYyiIqF4zFsv
         rSZh+fnIP5m63rqFcDKETiVW/X9XMxJme7LIGk8zgSkJCNKnKqPFNjX2YVRgqO0Xat
         pWCw1FipBPRWr9MCej2o/JrTvT7fANuSyH5vsOxqloZ99kutXIsgZTaKLP4MJneiPb
         90+iOUXbBP+d+xXmnjJF3BjfZ0AmRT95opCBPYg28qO6uaZrehTC9U1CH6OnxdBMkq
         xg7JPVll9IPj7BrNU4AUfgIJ9QGSRvH+Tw/ZwggNIU1uq90lmtvvXkR1AUTBLtyBgB
         fhIcj1YFTc/aA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Subject: [PATCH v6 2/9] iversion: clarify when the i_version counter must be updated
Date:   Fri, 30 Sep 2022 07:18:33 -0400
Message-Id: <20220930111840.10695-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930111840.10695-1-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The i_version field in the kernel has had different semantics over
the decades, but NFSv4 has certain expectations. Update the comments
in iversion.h to describe when the i_version must change.

Cc: Colin Walters <walters@verbum.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 6755d8b4f20b..9925cac1fa94 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,14 @@
  * ---------------------------
  * The change attribute (i_version) is mandated by NFSv4 and is mostly for
  * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
- * appear different to observers if there was a change to the inode's data or
- * metadata since it was last queried.
+ * appear larger to observers if there was an explicit change to the inode's
+ * data or metadata since it was last queried.
+ *
+ * An explicit change is one that would ordinarily result in a change to the
+ * inode status change time (aka ctime). i_version must appear to change, even
+ * if the ctime does not (since the whole point is to avoid missing updates due
+ * to timestamp granularity). If POSIX mandates that the ctime must change due
+ * to an operation, then the i_version counter must be incremented as well.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
-- 
2.37.3

