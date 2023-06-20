Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E0736B40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFTLnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFTLnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C891713;
        Tue, 20 Jun 2023 04:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E80611F0;
        Tue, 20 Jun 2023 11:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8123C433C8;
        Tue, 20 Jun 2023 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687261362;
        bh=hCldbNsO0TOwUgfRbSGNvJYMsoqIvF/JUDNRqS4H3r4=;
        h=From:Date:Subject:To:Cc:From;
        b=LddhIzmAOCzTU5FvNDZ4unhevkwERqZTOQsCobwr/4xdvNG0JeFEAmMZPOWnf4QLW
         ecOjy+UUYTTLmjOvvUpM26K6asvI0gj2Cjl/R4wTd5rOKuhCp94A/cbmy3r6tAyqeC
         ZCcSVksd/ghjWhwx1QDgYn7PsSwprV0b64O8rvLhIpkYZl3cxG3MLVRF+UEoqksA9i
         g1kqdnF8+X0IHEUvE+sthhsef4uikB0JG20KnQs00+PIMDPFdhT2unnVIDD+OFdDoU
         6oS5qYfl2BfZIdbzRJjLJGpLJ6UtLCx9qSmhMFlH15TxVmV0iq0CFfC3XW6gqoCRJy
         3q9NmbumbMzPA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 20 Jun 2023 13:42:38 +0200
Subject: [PATCH] ovl: reserve ability to reconfigure mount options with new
 mount api
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-fs-overlayfs-mount-api-remount-v1-1-6dfcb89088e3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK2QkWQC/0WOwQqDQAxEf0VybmBdQdr+Sukhu8YaaLOSVbGI/
 961PfQ2D2Yes0FmE85wrTYwXiRL0gL1qYI4kD4YpSsM3vnGtd5hnzEtbE96l/RKs05Io6DxL1+
 a4GvHbYzdGYokUGYMRhqHQ/OfKq/TURiNe1m/D273ff8Ab9n2GJEAAAA=
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=2784; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hCldbNsO0TOwUgfRbSGNvJYMsoqIvF/JUDNRqS4H3r4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRMnLDxiOX6nTOeTEyLnmsXeHvCQrHXD2N0Y1anisy8ffZR
 mj4ja0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE5uQz/E/z3Zs9mZ0nmHHHI+6vFz
 c6JZjrmRc3PGvyWybpqNW8oYnhf5n5fO0M5zufZTxfa207vV/jc/qVtO5lYX7u+0wEl5neYAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using the old mount api to remount an overlayfs superblock via
mount(MS_REMOUNT) all mount options will be silently ignored. For
example, if you create an overlayfs mount:

        mount -t overlay overlay -o lowerdir=/mnt/a:/mnt/b,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged

and then issue a remount via:

        # force mount(8) to use mount(2)
        export LIBMOUNT_FORCE_MOUNT2=always
        mount -t overlay overlay -o remount,WOOTWOOT,lowerdir=/DOESNT-EXIST /mnt/merged

with completely nonsensical mount options whatsoever it will succeed
nonetheless. This prevents us from every changing any mount options we
might introduce in the future that could reasonably be changed during a
remount.

We don't need to carry this issue into the new mount api port. Similar
to FUSE we can use the fs_context::oldapi member to figure out that this
is a request coming through the legacy mount api. If we detect it we
continue silently ignoring all mount options.

But for the new mount api we simply report that mount options cannot
currently be changed. This will allow us to potentially alter mount
properties for new or even old properties. It any case, silently
ignoring everything is not something new apis should do.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---

---
 fs/overlayfs/super.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ed4b35c9d647..c14c52560fd6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -499,13 +499,24 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct ovl_fs_context *ctx = fc->fs_private;
 	int opt;
 
-	/*
-	 * On remount overlayfs has always ignored all mount options no
-	 * matter if malformed or not so for backwards compatibility we
-	 * do the same here.
-	 */
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
-		return 0;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		/*
+		 * On remount overlayfs has always ignored all mount
+		 * options no matter if malformed or not so for
+		 * backwards compatibility we do the same here.
+		 */
+		if (fc->oldapi)
+			return 0;
+
+		/*
+		 * Give us the freedom to allow changing mount options
+		 * with the new mount api in the future. So instead of
+		 * silently ignoring everything we report a proper
+		 * error. This is only visible for users of the new
+		 * mount api.
+		 */
+		return invalfc(fc, "No changes allowed in reconfigure");
+	}
 
 	opt = fs_parse(fc, ovl_parameter_spec, param, &result);
 	if (opt < 0)

---
base-commit: cc7e4d7ce5ea183b9ca735f7466b4491a1ee440e
change-id: 20230620-fs-overlayfs-mount-api-remount-93b210e6ccd8

