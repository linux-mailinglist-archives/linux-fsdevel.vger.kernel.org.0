Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8273E1EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFZOTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZOTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D662977;
        Mon, 26 Jun 2023 07:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6889460EA5;
        Mon, 26 Jun 2023 14:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D0C433CB;
        Mon, 26 Jun 2023 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687789032;
        bh=3iOllktOx2ArKFRO/7jbpoYrOUrV2Y7iRVVV7NXtwKg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZBR553rlFgEjJzJQaHht87wVTaEKGkScS+DUZj72TJdJp3eMnxAaWzCB4oX7kOP9K
         9piJWLW+QuZ4OF5yeUugxnxqjX+vjexur2cUW8+11AT8FvvwyuOQ9+jaT+YYNnT+ZL
         6kcm308Dhu0IK7ejptMnCBE0NIkt+XO+mG2Kc6URGgNc0W65tUCKYd+2iM5XyH8D4F
         TLSmqs2lM7eJUWxPlHUFWXLoIELyFK9ZfrSukruZWrGe7zbj6/AoQtws9Zj00xPeXo
         wdM2q+SzQv+fltK4PidnbqnzXQzpI5ZMMZNS8+s5HuwrVre/jJOaUOfw4kqBAg3lh0
         fyBoQSZA3DU9w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 26 Jun 2023 16:16:50 +0200
Subject: [PATCH 1/2] fs: indicate request originates from old mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-fs-btrfs-mount-api-v1-1-045e9735a00b@kernel.org>
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
In-Reply-To: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3iOllktOx2ArKFRO/7jbpoYrOUrV2Y7iRVVV7NXtwKg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMnPvkdP81xXcFAf+nf+SzP27Cudwj97Cj/4rNnbcWH81+
 vG6JbEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETGUZGb4xSVn971t9ak7IsVcyxf
 cOyDmpNk8Qj//aGmqsEuuhfpjhv0/JQttPr5aejru69muxwETnConTsvO1XCu5BKNn5bRrsgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already communicate to filesystems when a remount request comes from
the old mount api as some filesystems choose to implement different
behavior in the new mount api than the old mount api to e.g., take the
chance to fix significant api bugs. Allow the same for regular mount
requests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..7a74f8f703ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2692,7 +2692,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the remount request is coming
+	 * from the legacy mount system call.
+	 */
 	fc->oldapi = true;
+
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
@@ -3026,6 +3031,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the mount request is coming
+	 * from the legacy mount system call.
+	 */
+	fc->oldapi = true;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));

-- 
2.34.1

