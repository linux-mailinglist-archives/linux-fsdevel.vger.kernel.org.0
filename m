Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF07AB6F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjIVRPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjIVRPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:15:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345F1A4;
        Fri, 22 Sep 2023 10:14:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A00C433CA;
        Fri, 22 Sep 2023 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695402895;
        bh=v6UdIy3iF2gwyGe6YE1xuhC9UXQ7IzgYePWcUL4vSGA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nobLkZ57CkeLUrk9Gn+1rf8m7nE+tgakmBWN28qsQYbPxKtomzJEXpnLPmWeiWBHd
         wYTswOnh2rBSClEgAN8YJ7iddAPu/ln8TdSlY98dSmDWgT8mSyHHGNPrxrqrggf8g2
         TyvO3JswgOAnMLrprnEmCnW2JpN0OrcRZQR08buWuiphHcIvV/jKELnN2V9cWhnxDO
         wcpPcNMESNGHDbERV/J3m2WiUZduLG4GMdPJ88PvbJhK+I0XYaJCd0d7MCJLgLMHrN
         Gp3Wqyuv86lHct+I7JFQvvRUx3x352t720UkdCF/9YzCbE/5kBf5d3N60S6q5WEsdq
         cWxgL7jwI7d0A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 22 Sep 2023 13:14:43 -0400
Subject: [PATCH v8 4/5] fs: add timestamp_truncate_to_gran helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-ctime-v8-4-45f0c236ede1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=v6UdIy3iF2gwyGe6YE1xuhC9UXQ7IzgYePWcUL4vSGA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlDcuGcqJPwl78fHiagrBrxmzVPer9aG3oaERZI
 pqSNpvoC8aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQ3LhgAKCRAADmhBGVaC
 FakdD/9KgrOQOhGZ14ptFQspbpO6fxuNVSJ/rqEaSG7uELQqBbcBcguVCQO1J3wIoEBUiEp4inf
 gHZLXxlDNDD/4PQh9lxCHPs6stqfiR/OIeZwe36cujXOjv5XrNdGCAznIcOjEM40Px/btRNrYC/
 XJrmlw9gEU4IeAtZ9AIokdyalPTIGX7ECHLceGsMjNHU4B1zSi380XFB0r3xJsegyqiOXoY5Cta
 E7r6m8zgxedClqgOOBKcYq5FUjoh+7UfDXTciJ66u5BrlrpT/JjEisrReLys3w8xK8JyKTwHab6
 +xgn3pkVoT4O1FrXmzbstaOO1YixyuzvOazHEs9WmY/kYehP8yOB5a0wCGcXM3SrLuWNNPIEDQy
 rxfHvOoPYKWWffYf1LDuaFSMasfjUa0OPm+XY8sulTaBaMw4afqlyyRr8r4skmNpGYnAvntL39O
 /urlIhaynyYw9Mr2rF+QJ66bl8x+qgmM7l/YtOvFxQ20hCsdol8XU2DfAzgKZBtE0zlTHTVvO1J
 Q1WAUaPKZTBJMQzhgVElGkua+KRcD9EvagHXdXWiq+iV4P7ZxMF1bEjKrBZAKgzj7Rg+W2Ec1A2
 yBTVWzmA323AGRYnPvTn4+37r3SNAHo6Fs1q8y+LCauOb8Fga99iYMaleYsMUe95bWIY1u9AGYQ
 qpHGgQNLqWzi2Cw==
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

In a future patch, we're going to need to truncate fine-grained
timestamps down to jiffies granularity. Add a new helper that allows
truncating down to an arbitrary granularity.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 38 +++++++++++++++++++++++++++-----------
 include/linux/fs.h |  1 +
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 293f9ba623d1..ae6baa5b17c5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2521,6 +2521,29 @@ void inode_nohighmem(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_nohighmem);
 
+/**
+ * timestamp_truncate_to_gran - Truncate timespec to a granularity
+ * @t: Timespec
+ * @gran: the specified granularity (in ns)
+ *
+ * Truncate a timespec to the specified granularity. Always rounds down.
+ * gran must not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
+ */
+struct timespec64 timestamp_truncate_to_gran(struct timespec64 t, unsigned int gran)
+{
+	/* Avoid division in the common cases 1 ns and 1 s. */
+	if (gran == 1)
+		; /* nothing */
+	else if (gran == NSEC_PER_SEC)
+		t.tv_nsec = 0;
+	else if (gran > 1 && gran < NSEC_PER_SEC)
+		t.tv_nsec -= t.tv_nsec % gran;
+	else
+		WARN(1, "invalid file time granularity: %u", gran);
+	return t;
+}
+EXPORT_SYMBOL(timestamp_truncate_to_gran);
+
 /**
  * timestamp_truncate - Truncate timespec to a granularity
  * @t: Timespec
@@ -2536,19 +2559,12 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 	unsigned int gran = sb->s_time_gran;
 
 	t.tv_sec = clamp(t.tv_sec, sb->s_time_min, sb->s_time_max);
-	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
+	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min)) {
 		t.tv_nsec = 0;
+		return t;
+	}
 
-	/* Avoid division in the common cases 1 ns and 1 s. */
-	if (gran == 1)
-		; /* nothing */
-	else if (gran == NSEC_PER_SEC)
-		t.tv_nsec = 0;
-	else if (gran > 1 && gran < NSEC_PER_SEC)
-		t.tv_nsec -= t.tv_nsec % gran;
-	else
-		WARN(1, "invalid file time granularity: %u", gran);
-	return t;
+	return timestamp_truncate_to_gran(t, gran);
 }
 EXPORT_SYMBOL(timestamp_truncate);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 91239a4c1a65..fa696322dae3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -748,6 +748,7 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+struct timespec64 timestamp_truncate_to_gran(struct timespec64 t, unsigned int gran);
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
 
 static inline unsigned int i_blocksize(const struct inode *node)

-- 
2.41.0

