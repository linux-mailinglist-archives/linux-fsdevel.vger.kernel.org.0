Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAEF32D11C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhCDKtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhCDKtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u14so27101956wri.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIN4nv0rU5QC5nHqjpRiW8LK2uZ3eh4ZlvsaWV1ax/Y=;
        b=WJ4eZxhVXy6RPRpDNIY+AlW/6r6wJLquYSt30nEqBudPttocAU/YjspcKpeWfQY/Ik
         8RFJkcF4QA2ZYgJvGk0ziu5pPlhV4mx+9hcBZX2xXPefIUELmrknmkgiy5g7MMm1ZY+S
         1gevVYeaBfBavFUuMhT5ZlHPB9M2xXOW82K3jlPYWy8UUqdnGFTr7x04sIKTlZDj53wU
         6xwPjmVH5ZWdPvnrmPuIaFFch/HNUom6j1mUXqpveMbkWhxISQ7n1HiycRO3xrYtJpMw
         6y6eC9WIGPxuKSeDzQrWxZwTQfXo6R79DLSlGhU2z/9pmpGb5WLap2XOlaynH9bUZ05A
         jKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIN4nv0rU5QC5nHqjpRiW8LK2uZ3eh4ZlvsaWV1ax/Y=;
        b=PrO9IUP4f5zXnIhE+E2KVcnUH/wHVwPvSxZrAlIOxNFzXlzvPRwiyoCi01qteIvhrb
         V32pl02l90kmmiWEUVGiEbcOrV7jr6R2g22jCFjvu4WcKJo4tLyBg8mpqMMe6Pw459v8
         3yZ5X6Ck8FsZ13XyiMY+B/bgkR6azoCOnOop48AWJrcfWwKoKubnL/Xa/i0nracIXM9S
         P3sKa/yHljqfHBa0/Ho5FoSgnufX7897N7cL4J022BCFfavL2w1S/RRWBihPpTHSh3Ht
         XpsmGIIRH247tdadn1bKYn3CV9PHzLlIPP1JickU8O/Jd6YuvL2sNXN3TPJJvXsAHvGl
         cEww==
X-Gm-Message-State: AOAM530APlJncfjAqSqQMoS9KoA2SWPgLG+0xAVM+Dha83gv5QRiwKLw
        bE9GTqdJYXseX7njeQCm7CE=
X-Google-Smtp-Source: ABdhPJyCb7oqarHThUQHmPgzbyj2+26wiZhEWe0oXo/RuCVtOFOpURmhYPpQqMelTNVWc+fB8IHYZw==
X-Received: by 2002:adf:b60e:: with SMTP id f14mr3331171wre.99.1614854908903;
        Thu, 04 Mar 2021 02:48:28 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:28 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/5] Performance improvement for fanotify merge
Date:   Thu,  4 Mar 2021 12:48:21 +0200
Message-Id: <20210304104826.3993892-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following is v2 for the fanotify_merge() performance improvements.

For more details on functional and performance tests please refer to
v1 cover letter [1].

This version is much simpler than v1 using standard hlist.
It was rebased and tested against 5.12-rc1 using LTP tests [2].

Thanks,
Amir.

Chanes since v1:
- Use hlist instead of multi notification lists
- Handling all hashing within fanotify backend
- Cram event key member together with event type
- Remove ifdefs and use constant queue hash bits
- Address other review comments on v1

[1] https://lore.kernel.org/linux-fsdevel/20210202162010.305971-1-amir73il@gmail.com/
[2] https://github.com/amir73il/ltp/commits/fanotify_merge

Amir Goldstein (5):
  fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
  fanotify: reduce event objectid to 29-bit hash
  fanotify: mix event info and pid into merge key hash
  fsnotify: use hash table for faster events merge
  fanotify: limit number of event merge attempts

 fs/notify/fanotify/fanotify.c        | 150 +++++++++++++++++++--------
 fs/notify/fanotify/fanotify.h        |  46 +++++++-
 fs/notify/fanotify/fanotify_user.c   |  65 ++++++++++--
 fs/notify/inotify/inotify_fsnotify.c |   9 +-
 fs/notify/inotify/inotify_user.c     |   7 +-
 fs/notify/notification.c             |  64 ++++++------
 include/linux/fsnotify_backend.h     |  23 ++--
 7 files changed, 263 insertions(+), 101 deletions(-)

-- 
2.30.0

