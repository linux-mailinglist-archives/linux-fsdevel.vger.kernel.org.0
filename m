Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0F2185BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGHLMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E624C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so48524732wrv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hZyrx3M5ZDXIIPFXTz1CL5MNCJNiQMk8YdSpmLrpHQI=;
        b=fGTVd7QNY6PdkO4y8KxqjdlXyLMwjuqmmBMA5c+ks432Q9vEkcyPISWsihuElbPA+O
         cP51s9sbVolnezE4bt2SJVQ84J32oLmreRK9tAtM0gJPULTWrUTb6h5zXzUgvWFq7ip8
         2KxRu9wNjH2RP1ebC2wIyO/9QJGnycVtouUfReUlRkuHr2VnoVD04pUocttpowuYqmFH
         9hz2NUHtYXNvz8+uPg1tdwNzGjpnvrKhn7kL//0kKEUeF4JNYU5SbRLU6s2xzjHJTwec
         POGo/9MA5iqvTbCa3z9SDOx+tnRg9pX7w3ess5lMR8qCA7k02AxiOaUULKXxIOguTZPB
         wDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hZyrx3M5ZDXIIPFXTz1CL5MNCJNiQMk8YdSpmLrpHQI=;
        b=bnvpi/+vi6Utm9XnT6CrAaKVcyJAa7x4iI1N3NBwptDpSmX1lbYsJ5YH3Wxfidkcw5
         ZDV3GTNe1UVSbunRCWejU6g9KW8k/wYDOdFPQsyqG/zIEe2BH5KJOyFFNI/W/heC/HGw
         f4IDvhRWPqbfz0WpCTo1j+lepCJGNbveLxlbTouHuabpzm38F/wh+eTZRc+y+iBgApi9
         2UIWvKNBo6mqIOeV9/PX1aJ3XCt0LiWijbHCMNxU8xLqgjOR9WX2jdShxy/qTOv3MnVi
         nLenWMdSJcuoGfe5yorXpv0BelJLKBhIIooMjyR6rfAFw+vJpEYzxq8VmgODgvB+n5Ae
         Y0TQ==
X-Gm-Message-State: AOAM530IfMHAl+RIplCTYY0cxykCJNXJPsnAYzr9UmrPCIZ7otTlTgrm
        8NkjLwHJ9uUL7wE6ZxpjuFu9xhTW
X-Google-Smtp-Source: ABdhPJyhJsCB09o9AoNE/opDpk4QW0rwffRccQDBT3KSHjqjQSphwawKnnfr+uQ8BoEfSgL9uGQgkg==
X-Received: by 2002:adf:8521:: with SMTP id 30mr55179186wrh.238.1594206746178;
        Wed, 08 Jul 2020 04:12:26 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:25 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/20] fanotify: mask out special event flags from ignored mask
Date:   Wed,  8 Jul 2020 14:11:49 +0300
Message-Id: <20200708111156.24659-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The special event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) never had
any meaning in ignored mask. Mask them out explicitly.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 92bb885b98b6..27bbd67270d8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1035,6 +1035,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool ignored = flags & FAN_MARK_IGNORED_MASK;
 	unsigned int obj_type, fid_mode;
 	int ret;
 
@@ -1082,6 +1083,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
+	/* Event flags (ONDIR, ON_CHILD) are meaningless in ignored mask */
+	if (ignored)
+		mask &= ~FANOTIFY_EVENT_FLAGS;
+
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
 		return -EBADF;
-- 
2.17.1

