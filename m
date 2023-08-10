Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAC777394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 11:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHJJAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjHJJAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:00:48 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45306213C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 02:00:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-585ff234cd1so8306397b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1691658046; x=1692262846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uprfWW9yr+wnN2eyxiYTv38U7K2acMfkjPdpqDoT12k=;
        b=fE0dpIYvkEenMIb6uRtbgKjgGvCGOkI3vMlpwfbkTJ4vIpECZg5qOz9Xwh5SfW3eiW
         r69KfO7GWvH8eiGzfi4C+vlV6osId2WldQx2PWY0mWsUJ5mYgyfyuW4WUNPDUh1hhN8J
         XsLiX+tWkeqrYwpNjFrl/ljvsZYmPly4B/RQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658046; x=1692262846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uprfWW9yr+wnN2eyxiYTv38U7K2acMfkjPdpqDoT12k=;
        b=iKKjlzBLnyA5fF3SSruxscw7GRs+z78piudHlsZx8HyGBuGOU9g7aL9morCHFhwUqb
         Uw4SUvlZsawuMOMAZBZXV3Y2l/JU/7a7+efUSdV1pohc1uyYof6TXWQIR2RUlEd9dXrw
         e/lLJU8hvISNQAJYDP8pHz+OpBgocSvJcqDeKnM/ozOlWiB95hJOJzbjv1J6TNCQo62L
         VHRqaLyCZepCXwqKTZYyO/6DzRd4BJVwY3BVQ9Codx0BkSlmnkcWQ8iMBXpc1g2W4MIr
         Zu0k/+jhGlQNcy8kVkaMgshNhl24FgDCmbZ+jVbN2YSbNwsfqSpOFEZULJUefm3NtoMo
         WwmA==
X-Gm-Message-State: AOJu0Yz3RAfC3aJ5eNIdR385j7WneW7CBIllmZSj/EQnr5Tfkzt+uuuK
        wD/KAOwq/MZto1eNb+xjZhIoRx5MqJea5lz2lNs=
X-Google-Smtp-Source: AGHT+IHhsl86AAx2fqDg6F8hPo/VQ3sLcZkxujbkCaTmCsPzmQwekDOxgS9IpgrzV/9xj3FM/CIG3w==
X-Received: by 2002:a0d:de02:0:b0:569:e7cb:cd4e with SMTP id h2-20020a0dde02000000b00569e7cbcd4emr2407249ywe.48.1691658046018;
        Thu, 10 Aug 2023 02:00:46 -0700 (PDT)
Received: from localhost (fwdproxy-frc-010.fbsv.net. [2a03:2880:21ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id x1-20020a818701000000b005707d7686ddsm232495ywf.76.2023.08.10.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:00:45 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/3] selftests/mount_setattr: Add a test to test locking mount attrs
Date:   Thu, 10 Aug 2023 02:00:42 -0700
Message-Id: <20230810090044.1252084-1-sargun@sargun.me>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Certain mount attributes are meant to be locked when sharing mounts with
another mount namespace. This validates that behaviour holds as expected.

 - Locked attributes are not changeable
 - Non-locked attributes can be changed, and changed back

Test output:
  sudo ./mount_setattr_test  -t mount_attr_lock
  make: Nothing to be done for 'all'.
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           mount_setattr.mount_attr_lock ...
  #            OK  mount_setattr.mount_attr_lock
  ok 1 mount_setattr.mount_attr_lock
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 .../mount_setattr/mount_setattr_test.c        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..2aaa4aae41f5 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -400,6 +400,11 @@ FIXTURE_SETUP(mount_setattr)
 	ASSERT_EQ(mount("testing", "/tmp/B/BB", "tmpfs", MS_NOATIME | MS_NODEV,
 			"size=100000,mode=700"), 0);
 
+	ASSERT_EQ(mkdir("/tmp/C", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/C", "tmpfs", MS_NOATIME,
+			"size=100000,mode=700"), 0);
+
 	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
 			"size=100000,mode=700"), 0);
 
@@ -1497,4 +1502,53 @@ TEST_F(mount_setattr, mount_attr_nosymfollow)
 	ASSERT_EQ(close(fd), 0);
 }
 
+TEST_F(mount_setattr, mount_attr_lock)
+{
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_RDONLY|MOUNT_ATTR_NOSUID|MOUNT_ATTR_NODEV,
+	};
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(prepare_unpriv_mountns(), 0);
+
+	attr.attr_set = 0;
+	attr.attr_clr = MOUNT_ATTR_RDONLY;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	attr.attr_clr = MOUNT_ATTR_NOSUID;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	attr.attr_clr = MOUNT_ATTR_NODEV;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	/* Do not allow changing any atime flags after locking */
+	attr.attr_set = MOUNT_ATTR_RELATIME;
+	attr.attr_clr = MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	attr.attr_set = MOUNT_ATTR_STRICTATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	attr.attr_set = MOUNT_ATTR_NODIRATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	/*
+	 * "re-setting" the atime setting to the same value should work.
+	 * Also, to make sure this isn't a no-op, try making things less permissive
+	 */
+	attr.attr_set = MOUNT_ATTR_NOATIME | MOUNT_ATTR_NOEXEC;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+
+	/* We should still be allowed to clear the attribute we set */
+	attr.attr_set = 0;
+	attr.attr_clr = MOUNT_ATTR_NOEXEC;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.39.3

