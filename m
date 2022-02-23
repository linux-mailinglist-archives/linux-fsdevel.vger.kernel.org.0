Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D704C1B13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiBWSnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiBWSnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:43:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBA4DF62
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 10:42:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w7so25619230ioj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jG8sZlYxngHtNBZ75RsZxyPK1eULwK2f1OlrVMJXaLU=;
        b=A2FTLspMmLYRzjdPaUfuvH5ApNRb/zkm3zjNattb70Yyn431q+KFU2Igg3zWspt9NI
         Hc+txAVnl3wZuFZ1pwo3lV7F8LE3Tkb2H5alj4mkF+DZq2mVISNlhkHzTVZq84aYIXi6
         Q00gdgn0eJCoABk9z39ndHq68RqhjO+bWHYa1yFePbo293o3SRh8fHCpAef3NCrWRVci
         mS/edKVHpBunzvef1nND/eOD32BJrdOmyPVkdQ6lUbOEzu5WY0pitKp/DvOCFs/FckOJ
         p1RQEXlTJaiDXbegTekBHNZ7kHLfHYku/ORRm8Fjb6m29zDoqGMPK58b7FfwM6FsE6d1
         wW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jG8sZlYxngHtNBZ75RsZxyPK1eULwK2f1OlrVMJXaLU=;
        b=Xk8zRtP28gJUAWvY7cVx3N5gT7Hl5h4tdMrYhAe3pi+YD1MAmobwEWvjwSLVxJYC6A
         CY0DCH2sIMriEhoDczUYidjd9CCYDtb+Gq4Q2UB0Dp9VS97QkWy4aVfuLjO5ZBBbW2xM
         Lv9hx3PkJJ9UF2qMD++umncuu9liVu1FeW/8zsjqhKFKEM9ddABhyjtWw61Ex/mp2LoI
         m5bbeUyOkeQxGMkVuAWSchQv7cIEYoyabVyglkrJfxh2tvH1Gbqn7wUBW/KVaStdOFPm
         wWFQEUoVK7mBwYZUrR7SWOo1zSOg8AfaW0TWizW8s347kGViYtTjS7UnrUyeG5Te1+J5
         QN4g==
X-Gm-Message-State: AOAM531BE7gJEdhn0RXZlr5v3YRczzq5jOJAFbA/Bq2eYYGyZNioPEg0
        4GxsJTQn0RaNlmam0LOIgHQ5lolOWqfN9FENWEu2JA804P4=
X-Google-Smtp-Source: ABdhPJxTkcUKwaWzOiiMQLWpivxnFlEbfnOU5xdR5DpvMve3QPwzxVhxx+4NU4MDuCIk6k/6RiPhlC4ibXf64FY4tfI=
X-Received: by 2002:a6b:e901:0:b0:640:7bf8:f61d with SMTP id
 u1-20020a6be901000000b006407bf8f61dmr565177iof.112.1645641768009; Wed, 23 Feb
 2022 10:42:48 -0800 (PST)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Feb 2022 20:42:37 +0200
Message-ID: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
Subject: [RFC] Volatile fanotify marks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

I wanted to get your feedback on an idea I have been playing with.
It started as a poor man's alternative to the old subtree watch problem.
For my employer's use case, we are watching the entire filesystem using
a filesystem mark, but would like to exclude events on a subtree
(i.e. all files underneath .private/).

At the moment, those events are filtered in userspace.
I had considered adding directory marks with an ignored mask on every
event that is received for a directory path under .private/, but that has the
undesired side effect of pinning those directory inodes to cache.

I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
kernel internal fsnotify backend. I wonder what are your thoughts on
exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify-volatile
