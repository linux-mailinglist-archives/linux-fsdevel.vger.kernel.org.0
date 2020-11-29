Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A402C7787
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 05:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgK2EhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 23:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgK2EhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 23:37:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8AC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:41 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id a130so10567495oif.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=soI2FbgRVVf7YiM5QpqBIyP2vOa5RD0uTn26wDJDuAw=;
        b=YAQWSm+qxF11VKwdEUOLxeNDv6v6atlFDk23YKjHQhpWs0949eFjvzU190A0TajDiZ
         svT4m5KElnXDTAgmJVrjbxPaer4OQ9xR9EONeyBezWSMg5beLgHJ/LvsFDHXXaS4BAC2
         OtmW0Ho7RD/QKd58ZyZfmd+78whb3w/K5JhgnPEmf1ih1UB7HzkJGO7nEnKGRE7+2szd
         UIapCGEt2vvqeUGuuQ0RhsVWMiO7laiL7vcyLP+iHqCykgYFwr6YuDCWnn/92yQb8EV9
         YaqW4TZbo5imfUF5GK2QY96Fxiv6debIbvwRz5x7nqLsVNOWj/5xwxP5aBDEf/9Epa5+
         RBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=soI2FbgRVVf7YiM5QpqBIyP2vOa5RD0uTn26wDJDuAw=;
        b=Bsc6FDwSBwOK4dSkTFz+tQAtcfuJkIPOFd5gFUg5sx9RwXLdxJc/wuIGDoZgvSHnFd
         ypChRHXB76fsobKFgdDkY7qW+42kCJbiG9vMk0R3W3dkHSKk5Z10hCvGG+KYOAS7iVFp
         ALGd6NznNykYTqp5ep6x4bPRLNS35cJCjOSl7flVhrDw+LVjCz2B83SXXGqZUJXzMpOs
         hcybH2gRqNKKxs/fhH3YnO+hBaFOG6u8CnijuPJ3Sz87aQWJvHJLjxXxvUQO638/++Sn
         Jmrx++TJRmyk0mr2PNIaFutPIZWyy7VXV0xKYQjiTqscqVk8T09bceYekTuQPLG3Giir
         h+gQ==
X-Gm-Message-State: AOAM530rjil88wUm+f/WOdvHZU5zLVgNJf5aWKQ3rSHQHU4XPbwP9xMX
        NbnEOTKFdUkS0BiAXVTVxOhBeZiOW7auEISknvjChbk9EQ5k3w==
X-Google-Smtp-Source: ABdhPJw2yKAioiKvOgEBz0/H2meynlNoPvLmKiPbKFeqneELTGWI8hBJojPX9/NNBv7/UhR0rkhroB254agWXvxD1Qo=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr10661269oid.114.1606624600820;
 Sat, 28 Nov 2020 20:36:40 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sat, 28 Nov 2020 20:36:30 -0800
Message-ID: <CAE1WUT6GfMH9krfXE2oEGuX9KoLe83SUZZbxQYEFvNF8-wFNhg@mail.gmail.com>
Subject: [RFC PATCH 2/3] fs: dax.c: move down bit DAX_EMPTY
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As DAX_ZERO_PAGE has been removed, DAX_EMPTY can be shifted downwards.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index fa8ca1a71bbd..c2bdccef3140 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -77,7 +77,7 @@ fs_initcall(init_dax_wait_table);
 #define DAX_SHIFT    (4)
 #define DAX_LOCKED    (1UL << 0)
 #define DAX_PMD        (1UL << 1)
-#define DAX_EMPTY    (1UL << 3)
+#define DAX_EMPTY    (1UL << 2)

 /*
  * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
-- 
2.29.2
