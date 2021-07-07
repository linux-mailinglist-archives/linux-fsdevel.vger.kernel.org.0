Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F843BE0E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGGCjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 22:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 22:39:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F78C061574;
        Tue,  6 Jul 2021 19:36:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p9so645147pjl.3;
        Tue, 06 Jul 2021 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCxCbJlJiqNeiIjObMW1i82bs2z6LZMv7wXyXYhR9UY=;
        b=sKCXnleWWkjorBPJdQcv0RhDEn8XoGWzLD7XBRZ4y+PfdPegQ5aF0qGHwm8gP0hRPN
         wt1vKhublUX1mPP4zyjlltWW9rxInI0ztJsSMtIJ/AfQ18bu6kV1qow29SZCPxSU4y57
         BKyt0JwxRpZ5uYhELLv5Dfzb3tOQLg6b6rDsxUk0bSDSpR+8ksVZQyFRcDJEbc2gTRmt
         +UhiKP9EzL/jvBBAchlv/i8EekT/OZ0+zf5qL0CECX/fOh1CXZJxKg2tJFyiT/Wnma8Z
         Br/Ak3G8K6oKWXJDAbHt1YO3mQ/5vhcR2Xwgch8g0KGDHHOsyyB7SWgE8dnMP8nItVSz
         caTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xCxCbJlJiqNeiIjObMW1i82bs2z6LZMv7wXyXYhR9UY=;
        b=jtzibEmnzC+jNtWyfzqjUe0okNUcikcZhM/oQvbk7dezhHYSJ0r4VlOLmCzJEokIOi
         YLiD6TkDxj/ka4eB5Yo9Ewm2hkFKL3EPs+W8QfN0zGDIGNTRVgek89Fc5F8PjVOCwZ14
         aHsfywipOSBZ+0jjWZKu5uYTdtOPV7Wiz1gHW8Nyk2Jlp9uXTIQ86VuTM/q+i2SY+97V
         zZRk9SQyVrMkPDqzD+9yd/vc1mQJVvVNgMEAXTjNJf0u/FueDJlp2LUhqCQtWPiCJSuh
         L5f43FuDK/jldouAaOw3wOfNWwSWqZrbK3IXFDfVHnuwTSlzwgMzA3B4PIH5h+y+lRSZ
         MH8w==
X-Gm-Message-State: AOAM530/baI8V7KHUDH9M7T40W+EwsfyQ9FmJTSFG13t1lf9ZXZz2vGq
        +nhBVgD9OotOTchyE8OM3lg=
X-Google-Smtp-Source: ABdhPJzhZho7v0iBKzVWkaCF+D5/fnmu0nCJ1sZyZl+vvZighIoY9emIsRGfaHg7xD4w97d7jSMMDA==
X-Received: by 2002:a17:902:ff13:b029:129:9a0b:c2dc with SMTP id f19-20020a170902ff13b02901299a0bc2dcmr8341242plj.45.1625625385504;
        Tue, 06 Jul 2021 19:36:25 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id r14sm20589446pgm.28.2021.07.06.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:36:25 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/2] fcntl: fix potential deadlocks
Date:   Wed,  7 Jul 2021 10:35:46 +0800
Message-Id: <20210707023548.15872-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry for the delay between v1 and v2, there was an unrelated issue with Syzbot testing.

Syzbot reports a possible irq lock inversion dependency:
https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b

While investigating this error, I discovered that multiple similar lock inversion scenarios can occur. Hence, this series addresses potential deadlocks for two classes of locks, one in each patch:

1. Fix potential deadlocks for &fown_struct.lock

2. Fix potential deadlock for &fasync_struct.fa_lock

v1 -> v2:
- Added WARN_ON_ONCE(irqs_disabled()) before calls to read_lock_irq, with elaboration in the commit message, as suggested by Jeff Layton.

Best wishes,
Desmond

Desmond Cheong Zhi Xi (2):
  fcntl: fix potential deadlocks for &fown_struct.lock
  fcntl: fix potential deadlock for &fasync_struct.fa_lock

 fs/fcntl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.25.1

