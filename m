Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF16319942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBLEpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhBLEpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:45:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51224C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z6so5101394pfq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=meg9sC7YyyK/ccxHauwvbjLk6iFrdpEJaLlXNYNQrRw=;
        b=j71D5TPJlB5a96J93TSXkpENx3ekgcrGWmn1JZtNQhnqd2Mge7An6OhBb5P8TnUMZQ
         4OUadpA2+MJX9QKhG3n8gr0GKnHyeVCl4h2ODUFy+jbH8WgKbmv8HqUeXBekYqVqcTHV
         xS2DhrwxhEz9TIoS7Zn9TTVKi4LDipZ1HBq4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=meg9sC7YyyK/ccxHauwvbjLk6iFrdpEJaLlXNYNQrRw=;
        b=VtSNWynWrO80lMKmplqFtj3HFdnsSyiiMJm7ThR8vo1o8g8aRwcWeqhUSoYssyHoXN
         NBudC5vwSOQUyxrr5jm4Tqenogs383Jvr8PJEuA2oDsWoEgws/yqF1xyKz1FFYySVpIh
         Z+xUKuAEAU6dB4ndUc6a+nMq1rcfJ77LWdMDCznoDjO9ciJUodmb8QVkA9wJZEHT519a
         wr6HkmPrMVvQR7fzuGZYBl2OW09gis4ERG/zeyX7sZKKqBRO1URwt3UZ+LXo2/MjMaft
         IW12Dl7K0Kmwh+8iJaK0R2HWrIUyItf/XVGoIfJcTCf556IQFIHl6nRahPncko2A8A1M
         d8Kg==
X-Gm-Message-State: AOAM531OnhdBFnxc2CVsmfXOO9fnFsfjwVUGm9LDApf8q9t5DmRN9NaR
        6hcAlljZFfNt1cp1pJIN5SN1Wg==
X-Google-Smtp-Source: ABdhPJzJ8v8dSTSVOML2sIt78PbLqD2VT6NK9LoWSGUmE8HEfFqP2J/kMV8nnkcPsdyrqXTVW649yQ==
X-Received: by 2002:a63:1845:: with SMTP id 5mr1499499pgy.244.1613105082790;
        Thu, 11 Feb 2021 20:44:42 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:42 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add generated flag to filesystem struct to block copy_file_range
Date:   Fri, 12 Feb 2021 12:43:59 +0800
Message-Id: <20210212044405.4120619-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We hit an issue when upgrading Go compiler from 1.13 to 1.15 [1],
as we use Go's `io.Copy` to copy the content of
`/sys/kernel/debug/tracing/trace` to a temporary file.

Under the hood, Go 1.15 uses `copy_file_range` syscall to
optimize the copy operation. However, that fails to copy any
content when the input file is from tracefs, with an apparent
size of 0 (but there is still content when you `cat` it, of
course).

From discussions in [2][3], it is clear that copy_file_range
cannot be properly implemented on filesystems where the content
is generated at runtime: the file size is incorrect (because it
is unknown before the content is generated), and seeking in such
files (as required by partial writes) is unlikely to work
correctly.

With this patch, Go's `io.Copy` gracefully falls back to a normal
read/write file copy.

I'm not 100% sure which stable tree this should go in, I'd say
at least >=5.3 since this is what introduced support for
cross-filesystem copy_file_range (and where most users are
somewhat likely to hit this issue). But let's discuss the patch
series first.

[1] http://issuetracker.google.com/issues/178332739
[2] https://lkml.org/lkml/2021/1/25/64
[3] https://lkml.org/lkml/2021/1/26/1736


Nicolas Boichat (6):
  fs: Add flag to file_system_type to indicate content is generated
  proc: Add FS_GENERATED_CONTENT to filesystem flags
  sysfs: Add FS_GENERATED_CONTENT to filesystem flags
  debugfs: Add FS_GENERATED_CONTENT to filesystem flags
  tracefs: Add FS_GENERATED_CONTENT to filesystem flags
  vfs: Disallow copy_file_range on generated file systems

 fs/debugfs/inode.c | 1 +
 fs/proc/root.c     | 2 +-
 fs/read_write.c    | 3 +++
 fs/sysfs/mount.c   | 2 +-
 fs/tracefs/inode.c | 1 +
 include/linux/fs.h | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

