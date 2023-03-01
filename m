Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708126A6477
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCAAyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAAyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:54:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE393645E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:06 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p20so11113709plw.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677632046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11WiiE5LECn10SNRXda1xNOScTgJeML/5FN9jEN5+98=;
        b=EoHsEGgCN4rP2xMrtYYBHm6TBpkidrU11vAdumbiy1GJ+Ua03wyo2sOJsGg22fAoR0
         9tum57ZLNlB6lIfRyo1qIyL0fhxWKpjdbFt+yrFIOLY57WRAHCLbednx5fQfgaJNB4eN
         9q4Mb0129eS63EnVJR16IHZczZ9EmZrk0PnMWcljkJ4L6bfI3zSa/OB8C7W/J4E0GyR2
         qCo91dnYbMTcTHVGZaDlH+tEZhULnWGYEP6YcYTUxMBCXwj+n1Af3FHP1aCPpJVHup1l
         fpTAQFtYDSGNEH8tYesweFv16GyLTOUslsQ6wEGCKjOd9Z9KE320n3/DqP0ppK01deHA
         6NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677632046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11WiiE5LECn10SNRXda1xNOScTgJeML/5FN9jEN5+98=;
        b=5VUOmnn5Bo+KohUfoXOftU+5iWYnhITGrNHrzWuYsX6gBw4kR9xI58AF7t8PObc8K1
         +bHaNAdllZY8ju8CpkU6ZrJ6KEr809W19xheuA4EOSWL8epZiAbR1UHlHy5UNky0f2e3
         t+iUnNg64mnIwSV2yUkQJUSdFPGegVLF1KV86yHo7EQQODez+QWcgFIO2quakEMLU4eh
         KsqgoQ0+vi99dnEmnpa5KWyOcMMQIrx680uQlsgG4pYfRV10YfKuyOe7mFS30cJfKa+4
         VBmdkPeBwfrNw6pc73yUnNDJiSO9jSxTg8cN+NtCeGVL9Fv5BAW0weu3aMBwzFv/3LLg
         R2Og==
X-Gm-Message-State: AO0yUKWtLf9Lu7AxFXhhQ9NBksMKZmxKFuM4kv7sPx6O3e9FRmYuPFy+
        IhxWG+yB0Fu7dZT/6DsNI6Ujxw==
X-Google-Smtp-Source: AK7set8Cr7fUcJTR42GCxrxVeRMKWCQgMMJC8yqN+l8CWjpTlVLSJYWzo+A3LqiH9xdIWlUeQ0Yxxg==
X-Received: by 2002:a17:90b:164e:b0:23a:baf:ffec with SMTP id il14-20020a17090b164e00b0023a0bafffecmr932669pjb.22.1677632045785;
        Tue, 28 Feb 2023 16:54:05 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id c5-20020a6566c5000000b00503000f0492sm18606pgw.14.2023.02.28.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:54:04 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Glenn Washburn <development@efficientek.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] GDB VFS utils
Date:   Tue, 28 Feb 2023 18:53:33 -0600
Message-Id: <cover.1677631565.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I've created a couple GDB convenience functions that I found useful when
debugging some VFS issues and figure others might find them useful. For
instance, they are useful in setting conditional breakpoints on VFS
functions where you only care if the dentry path is a certain value. I
took the opportunity to create a new "vfs" python module to give VFS
related utilities a home.

Glenn

Glenn Washburn (2):
  scripts/gdb: Create linux/vfs.py for VFS related GDB helpers
  scripts/gdb: Add GDB convenience functions $lx_dentry_name() and
    $lx_i_dentry()

 scripts/gdb/linux/proc.py  | 15 +++++-----
 scripts/gdb/linux/utils.py |  8 ------
 scripts/gdb/linux/vfs.py   | 59 ++++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |  1 +
 4 files changed, 68 insertions(+), 15 deletions(-)
 create mode 100644 scripts/gdb/linux/vfs.py

-- 
2.30.2

