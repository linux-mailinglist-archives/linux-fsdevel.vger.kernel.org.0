Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D67AB701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjIVRPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjIVRO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:14:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4B194;
        Fri, 22 Sep 2023 10:14:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89086C433C8;
        Fri, 22 Sep 2023 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402892;
        bh=NFFb0wVC4vDGCm6mY4DnCN3YW9JLtiM6/cGSNjSGNLw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ee3OQFc5mhZe1schuj2Ih0PMVeXCVOQ3jJbk6mkpkHqUvFyCYgmLbaFUfPz8T0xVr
         8XWz8aNjM5x+uJZqbFmG2DFYpUjSiAg3XGbpz9gQhX5Jn+HLjfBfDsSZjtekZtQG48
         H58DlqfyBf1pyFSWFW5e2H46HPsyysJ7FQuD68Vr07jSfC0nxQxHcNL7d/BxZWpMYz
         LPGZ8GqY8mTUZwyxCoN8Gs8WeGS/QOHv9X8cQnf0s+lj347LzVxbhty0WZVaNQ1FFG
         Xlas3vwdlUaQahQYXYT9TYUXACjQLNEkvGath6bu3qIE4pZjNrOzN4l0IHdPNlqQUk
         +zM1D52EdmIIw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 22 Sep 2023 13:14:41 -0400
Subject: [PATCH v8 2/5] fs: optimize away some fine-grained timestamp
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-ctime-v8-2-45f0c236ede1@kernel.org>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NFFb0wVC4vDGCm6mY4DnCN3YW9JLtiM6/cGSNjSGNLw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGy850TGCImFzlW6PaszASwhbcFpoXM/ofY
 mgISIxoW3mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 Fbm7D/9b6VZ7YR1N2txLfMMfe4SCyQf5HfHYV7PpyTnWpiDh8onAt/YB/WbCt/TFe+4FhArKbZq
 gN8yNNikbV/qcZkMZuQKOqGAUbVN4+1ofFU8eng0N2edA1OZ+0wjhFA8HGeixTDp2mX9DtteXz5
 8tP9IA7sN6UjqteyWHs47DoVjwDaGA5Tnt1G96cPa4N0jRcyBzj7SrR/SH7nbYsdAT1UcWYBbbM
 82CLjSC+lxhh4iWt4yumKI6OIMQZM+h7dbfL5Pcd8fJyf4L5rqrOhlPyam+4LbSDiX7JxKkGL+w
 5+8lpQBYQcHWhbRM5CL+WZzY1Iz170Rsl5qHA78yxnwE/s56NUTDsWczHQ++XSa+racTYnjlqiF
 VJrZWTVX/ABjhoQ+JLNmHJd/jj3aXzbHAz41voa/acsWryBYQHXIQ1V41+QJxpkinDkB6qUUr/w
 txr0/PHEb3l5lgVrPBzRMZqAFbKKhWwCpOz+Ib0kD1CbcZFd3xrd8tzwB+G34QUASXY42wj8HRv
 cB2hrWaueCN+xHOqWyherjGOJMalNfwRYcAEZuE1JVhIZEv00Bq7Q0lXvXLVmECOh986lTt5Pvn
 0fU63wLR4lslFnItiJ/YVdyENPY3iZ12IRNN04z42uSy4DAu2SyPdKwVC5QuRh0rR37pGL1bZiR
 LRvQ2MzaluEzK/g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When updating the ctime and the QUERIED bit is set, we can still use the
coarse-grained clock if the next coarse time tick has already happened.
Only use the fine grained clock if the coarse grained one is equal to or
earlier than the old ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f3d68e4b8df7..293f9ba623d1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2587,26 +2587,35 @@ EXPORT_SYMBOL(current_time);
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
-	struct timespec64 now;
+	struct timespec64 now = current_time(inode);
 	struct timespec64 ctime;
+	bool queried;
+	int tscomp;
 
+	/* Just copy it into place if it's not multigrain */
+	if (!is_mgtime(inode)) {
+		inode_set_ctime_to_ts(inode, now);
+		return now;
+	}
+
+	ctime.tv_sec = inode->__i_ctime.tv_sec;
 	ctime.tv_nsec = READ_ONCE(inode->__i_ctime.tv_nsec);
-	if (!(ctime.tv_nsec & I_CTIME_QUERIED)) {
-		now = current_time(inode);
+	queried = ctime.tv_nsec & I_CTIME_QUERIED;
+	ctime.tv_nsec &= ~I_CTIME_QUERIED;
 
-		/* Just copy it into place if it's not multigrain */
-		if (!is_mgtime(inode)) {
-			inode_set_ctime_to_ts(inode, now);
-			return now;
-		}
+	tscomp = timespec64_compare(&ctime, &now);
 
+	/*
+	 * We can use a coarse-grained timestamp if no one has queried for it,
+	 * or coarse time is already later than the existing ctime.
+	 */
+	if (!queried || tscomp < 0) {
 		/*
 		 * If we've recently updated with a fine-grained timestamp,
 		 * then the coarse-grained one may still be earlier than the
 		 * existing ctime. Just keep the existing value if so.
 		 */
-		ctime.tv_sec = inode->__i_ctime.tv_sec;
-		if (timespec64_compare(&ctime, &now) > 0) {
+		if (tscomp > 0) {
 			struct timespec64	limit = now;
 
 			/*
@@ -2620,6 +2629,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 				return ctime;
 		}
 
+		/* Put back the queried bit if we stripped it before */
+		if (queried)
+			ctime.tv_nsec |= I_CTIME_QUERIED;
+
 		/*
 		 * Ctime updates are usually protected by the inode_lock, but
 		 * we can still race with someone setting the QUERIED flag.

-- 
2.41.0

