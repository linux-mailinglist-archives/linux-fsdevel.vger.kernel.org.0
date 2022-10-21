Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C678607796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJUNGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJUNGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E44E854;
        Fri, 21 Oct 2022 06:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 991ACB82BFD;
        Fri, 21 Oct 2022 13:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECF9C433B5;
        Fri, 21 Oct 2022 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357570;
        bh=3UkiypkQG9xLfg+hS+eOV/U1/Tn/AJ7lMyTpKN5KYY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nb7Yh47R45XqPtLKFsPoNljbrgHogii3eyJeQw8kYHjoaipnHpNizFXrsizMdjF+r
         PHs6urb8gnEaX6lrsQW9gE0F2HD99LWIL8nSL1J4uJAXnFtycQJ/32stK0OrJpeRq0
         B3mEuntmnKKVKzBO7dC2b6RvaN2SHnSq4CGRVkcuMRHj0nL6p/NSeOTo35Lfog2xra
         DCIaG2PVYQsS177hQeS57Z/8fw+VgslZwMLCR+MrcbqfRFZ6QzoXM6WJk2x1ulJG1W
         0Xl/0GfnwBEsjS/fhLgjWLg4EtHypRr2ix40fu2N5gbUexGEr+A0LI0o/nF3U+UBgB
         nGToooWNgVthg==
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
Subject: [PATCH v8 2/8] fs: clarify when the i_version counter must be updated
Date:   Fri, 21 Oct 2022 09:05:56 -0400
Message-Id: <20221021130602.99099-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021130602.99099-1-jlayton@kernel.org>
References: <20221021130602.99099-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 6755d8b4f20b..94f4dc620d01 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,24 @@
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
+ *
+ * Making the i_version update completely atomic with the operation itself would
+ * be prohibitively expensive. Traditionally the kernel has updated the times on
+ * directories after an operation that changes its contents. For regular files,
+ * the ctime is usually updated before the data is copied into the cache for a
+ * write. This means that there is a window of time when an observer can
+ * associate a new timestamp with old file contents. Since the purpose of the
+ * i_version is to allow for better cache coherency, the i_version must always
+ * be updated after the results of the operation are visible. Updating it before
+ * and after a change is also permitted.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
-- 
2.37.3

