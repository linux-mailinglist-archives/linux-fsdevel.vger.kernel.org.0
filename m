Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906A3B9DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhGBJV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhGBJV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:21:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B31C061762;
        Fri,  2 Jul 2021 02:18:53 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v7so8981691pgl.2;
        Fri, 02 Jul 2021 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJEaMh5QMIWKQSiW3NhFAWboQVAmMWKJTMsm2BnrKWA=;
        b=b3Agk3pau1jzghfawlkN8c7Mdga3Nzlj5mQz3xpbz85WeyXNj6Gs54d14giwqX75H5
         2/iO0XgdoLFJBLkqOlQhhvM/a+j/UNWycRXpCosZ3mKhrSwvnnlt9cjIDIIEiAXXFj1A
         i3MRRi1eV9LT+3SxSydMIET2w22HX1dFDfxfLK73wbc8ITyzucHWxXKLGt2rBLrgUXr3
         Hi5p4TEE1FwGiD8tth8dAB3fbitiFQ/0iez44c5sf/YhBszhhorsAE1aSpgp57Wwm6hD
         zR+SNI6cCUS+7F+0oiMJQEBhLDG07QhSEynK0a4gOpcwTDbfV1UpYirNtbrS5fUZ4t+o
         30XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJEaMh5QMIWKQSiW3NhFAWboQVAmMWKJTMsm2BnrKWA=;
        b=aok8BwvV4c5LMcJS4l5hYXjYzd2MEuUfDYF7h7EFPr9a/uJI/vR28RZUUOId7afwNL
         7/bz0vhMz2hev6nBRWWmrAKkwy8p1bKpHjO08c4kfz87G5c5WnYQ7GWPfxZdz6Be1aEx
         oWGRPSsE1YEXjd5xxbU7TTJyBnVlxPIwYfUg5XVw88fRwUO2S+Acwbbgz0xkpm512AEP
         Hmv7bhQr+0/us4aU0cbEeOuYHm2LSA+AtrtgaCLqGJqbaPXja6vIGUQV/adswQ4quwse
         EHp75OQdtWvhZDtnWnxVgfoED7+W95Q4wYFEhxDZjnYsa2CtfzKAJUELPRID4MofMuC0
         CZ3Q==
X-Gm-Message-State: AOAM533Aa8TsZIw9WH1JECQHuV5FHXnaO7ESHboVPgH+uMHQlTLnZM/7
        42EOERPaqlVzl8zBAZ+86fU=
X-Google-Smtp-Source: ABdhPJxJOwoAcoKmZkfGso6jjy9hW28TXA4lMFBKPHpGF+EHRsgL/W14RrCs8aNA22yZAy3MllzMeQ==
X-Received: by 2002:a63:4f11:: with SMTP id d17mr1260315pgb.20.1625217533419;
        Fri, 02 Jul 2021 02:18:53 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id y3sm3023918pga.72.2021.07.02.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:18:53 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] fcntl: fix potential deadlocks
Date:   Fri,  2 Jul 2021 17:18:29 +0800
Message-Id: <20210702091831.615042-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Syzbot reports a possible irq lock inversion dependency:
https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b

While investigating this error, I discovered that multiple similar lock inversion scenarios can occur. Hence, this series addresses potential deadlocks for two classes of locks, one in each patch:

1. Fix potential deadlocks for &fown_struct.lock

2. Fix potential deadlock for &fasync_struct.fa_lock

Best wishes,
Desmond

Desmond Cheong Zhi Xi (2):
  fcntl: fix potential deadlocks for &fown_struct.lock
  fcntl: fix potential deadlock for &fasync_struct.fa_lock

 fs/fcntl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

