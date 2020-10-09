Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23D8288A04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbgJINtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732613AbgJINtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:49:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C97C0613D2;
        Fri,  9 Oct 2020 06:49:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r10so4327442ilm.11;
        Fri, 09 Oct 2020 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=QCeC1es6afbYJ4i5U1JtProHaQCikiBQHR4gTE9dMk0=;
        b=vKH4AN8Sfg0NCDcgtVbTMPXhBCQKZaxK3c2TQVykomBdsT+X/ArrjZ7axoXsL8uzZK
         1cguAD7aVaAnB6UM2oUqmlaggMqwbsT8kWSRMTyr3fEpU8tKtT8050zkeNJs0BO/9iCl
         WTWffpZ0DBvOUYNIhFrvZHT99+6PwO5bNkHoy4k8yOzl0Ija4WzMgcNsuEhaK4P5ejST
         pp5JCP7icFMOdgh1JcXJqB/WbNcEmqTn9eqR50sagx4y0POKqCCs54WC7Uvi15Jou/mg
         dGD1FWyjh7NOnBGabTkgaas7AmFbVSu/stYheqQYIH2rf89mm2YspHqzGxNt/YK+fXrf
         kt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QCeC1es6afbYJ4i5U1JtProHaQCikiBQHR4gTE9dMk0=;
        b=nX2iNvFuCfl9YfPtmO3fLmV4IIJKXg0vtSDEdG661fkPlLqu90x5FC54AcdzdOvFnh
         7kcRlYX3fy139Zik+d81knf5xRBOipgqfmXihYxCWrL7YdGIytLXVFR3XEWmOQR/XlEb
         ktKFW8eVy+Tacr1BRDtMD+TVvDwvP1+mrJgv4VkQbob96xe5uF59ZPcXQ+/Xvds1zfOU
         3q329FNq/HKTBNCs257N8L4uuY2cxMdQKUi/kp8IJIo0HwCbBZ0fmTBv23LDbXfp96BV
         SvnVC2aDoMXBuUSCJljrH19/URCbGZYTHaHYxMYlneDSheHGqjYFvEOqwljcgJsHsC4P
         8fTA==
X-Gm-Message-State: AOAM530Q/g1rkwGasp8AB2aLeafgGcE+0YmwSudcDpc508RHuQ2h2WcM
        f17InsZyFIV8Ahr3ZUK+PO2ZQR09uqYM3dgODqtGC49r6/XGGQ==
X-Google-Smtp-Source: ABdhPJy9GGEorgymcU+yPhDILhjxfUxZCcTBbBk15U98LjboSaoqLFQQ4Hft/ApK5hO2/FMXQOKTrqxZXsCwCDoQq5E=
X-Received: by 2002:a92:6a0a:: with SMTP id f10mr10421507ilc.186.1602251361881;
 Fri, 09 Oct 2020 06:49:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 15:49:11 +0200
Message-ID: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
Subject: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

with <ext4.git#dev> up to commit
ab7b179af3f98772f2433ddc4ace6b7924a4e862 ("Merge branch
'hs/fast-commit-v9' into dev") I see some warnings (were reported via
kernel-test-bot)...

fs/jbd2/recovery.c:241:15: warning: unused variable 'seq' [-Wunused-variable]
fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
uninitialized whenever '||' condition is true
[-Wsometimes-uninitialized]

...and more severe a build breakage with CONFIG_JBD2=and CONFIG_EXT4_FS=m

ERROR: modpost: "jbd2_fc_release_bufs" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "jbd2_fc_init" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "jbd2_fc_stop_do_commit" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "jbd2_fc_stop" [fs/ext4/ext4.ko] undefined!
ERROR: modpost: "jbd2_fc_start" [fs/ext4/ext4.ko] undefined!

Looks like missing exports.

Regards,
- Sedat -
