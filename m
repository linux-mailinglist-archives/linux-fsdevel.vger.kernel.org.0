Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC45FEB0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJNItx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJNItt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7A14D0D;
        Fri, 14 Oct 2022 01:49:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so4907154wma.3;
        Fri, 14 Oct 2022 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=;
        b=oC6tSxasgYZK7HLegRBPiSvjZcFyUQ6VxaiXUsn9DOOqsgYUd3GwVU3xpX+MEuUcs6
         5Zyo5II4xi0HIqzm0H97V7F94fYQdDLt8AuD+JZzU47QQ/LuGMQdYOOGSKw2dxumvRKB
         h7m582fFWyx3oprKN1q8FSc+To8Y6JDmPTRnd4hkSq/AbbkLHlkBJXB8Q+TOCpRRhl2y
         d/+ZTjaaMTxKRAiVLHhe3QjKwq7Ra5hv6vxdw+Sr9ECBJR0PxYgvhE2OVPZwv9ed7dwQ
         BaLglkid8PnXT/nXhWq1sEkYBW8NVoxmsiJn/yjvdRctbBZZqCVrgn4QIC2aa5IUvmbp
         Ws2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=;
        b=XL74i7SrnEafyygwqndPmYzgZsyz5xv8aRX3nShDUB8UZzMW102kvWTgMzksiJ0QBj
         a9QTCq2slBog93m1ZY8taiHPlODB7uUphx0qWTqPlXqP528EcFi20QRVXxW/80uidg1D
         KcM0JTqHJulo/eO1XuF4+aUQmVczEBq892sKD30mWC3aYDGWmsQUMr+hQB+cFy20vqMW
         cCUhyZpECT2D3EwyzoQ3OV+IT414hcKurS/1sI0x3bzYAZSn9Al5cMNSIDSYBZDF2S+w
         Bc6eLy8VsZykfn4JOEIyb7iExzqUl6vagSCzFi3zIjU9h0a4iVsV6Hr9gO8e2wRYkvuW
         E6VQ==
X-Gm-Message-State: ACrzQf1OSgvpomURKArEPa1ZinvZdmslNjbAINvcHXGu/IFFF0EjbNLj
        4EraoY7iB02sUePlInCrM40=
X-Google-Smtp-Source: AMsMyM4UuuSQy7/mg7oAryPWOasHAjc2gENOIuSxoGVuTVFY95besHOPxbhAIYXtJwHmTWJN46oPAQ==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr2698975wmb.11.1665737385463;
        Fri, 14 Oct 2022 01:49:45 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:45 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 1/7] fs: create `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:31 +0000
Message-Id: <20221014084837.1787196-2-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hrutvik Kanabar <hrutvik@google.com>

When implemented and enabled, this should circumvent all redundant
checksum verification in filesystem code. However, setting of checksums
is not affected.

The aim is to aid fuzzing efforts which randomly mutate disk images and
so invalidate checksums.  Checksum verification often rejects these
mutated disk images, hindering fuzzer coverage of deep code paths. By
disabling checksum verification, all mutated images are considered valid
and so exploration of interesting code paths can continue.

This option requires the `DEBUG_KERNEL` option, and is not intended to
be used on production systems.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/Kconfig.debug  | 20 ++++++++++++++++++++
 lib/Kconfig.debug |  6 ++++++
 2 files changed, 26 insertions(+)
 create mode 100644 fs/Kconfig.debug

diff --git a/fs/Kconfig.debug b/fs/Kconfig.debug
new file mode 100644
index 000000000000..bc1018e3d580
--- /dev/null
+++ b/fs/Kconfig.debug
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DISABLE_FS_CSUM_VERIFICATION
+	bool "Disable redundant checksum verification for filesystems"
+	depends on DEBUG_KERNEL
+	help
+	  Disable filesystem checksum verification for checksums which can be
+	  trivially recomputed from the on-disk data (i.e. no encryption).
+	  Note that this does not affect setting of checksums.
+
+	  This option is useful for filesystem testing. For example, fuzzing
+	  with randomly mutated disk images can uncover bugs exploitable by
+	  specially-crafted disks. Redundant checksums are orthogonal to these
+	  exploits, as they can be recomputed for crafted disks. However, for
+	  testing it is more reliable to disable checksums within the kernel
+	  than to maintain image generators which faithfully reimplement
+	  per-filesystem checksum recomputation.
+
+	  Say N if you are unsure. Disable this for production systems!
+
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 73178b0e43a4..4689ae527993 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,12 @@ source "lib/Kconfig.kmsan"
 
 endmenu # "Memory Debugging"
 
+menu "Filesystem Debugging"
+
+source "fs/Kconfig.debug"
+
+endmenu # "Filesystem Debugging"
+
 config DEBUG_SHIRQ
 	bool "Debug shared IRQ handlers"
 	depends on DEBUG_KERNEL
-- 
2.38.0.413.g74048e4d9e-goog

