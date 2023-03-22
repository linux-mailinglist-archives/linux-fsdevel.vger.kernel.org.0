Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E76C4007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVBul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 21:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCVBu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:50:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047AC58C04
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 18:50:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x15so6877178pjk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 18:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679449825;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=40EY1j9nbT6fWckgQyFljtsmlE70jmSAuRvlIm/FuKM=;
        b=FpcCJZb0YF90y/st4iD3AaRFLyHyRRDcF+rOqrpNDDBeqqyh+qSOhhI/r92/hXP4L5
         pkWRIJ6Pa6FnjlbiydiHyouM/qmnadKFGcf7SaBC1U41GQKOuA8aabnydLih7NJJ8UB3
         mU6ZoWOunGzaAeUnEnN+zpGNsReGDTZy2mfIOMDU2SQFCbBcWE/hN/dQQH2hytgbd0Y7
         BfW5oPJWx09uevzNkcf5SaO1pQV7tLvWDH/DPLfJ/QtgoIx40Az8BV2KyoenN3KcrJH7
         iHhWvplz7F6FWwbGLZP5DO0I2hBBSr3oaOHpHWiAyQJw3H7GrPwwS5HK2h3x7jzX6n2d
         AiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679449825;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40EY1j9nbT6fWckgQyFljtsmlE70jmSAuRvlIm/FuKM=;
        b=7YvWH4XXOSPWkBCBXrV90A6QnxCpTH8HXmcycYl6JBKrnCfcB1AT9UR0vLAk4TiE3A
         5a1F+XzvXZ7y8Y6latlXMaJzS2S+tlG5J11lxLrSK310edIfYhR5dhle18zcJDxgptyT
         MYAhaMrb/iJWa4MeD5NIz2MEpRTRcaZQjDzGQx2zPc4JzvT+lE+BpaibXQjEehqr76G7
         oN8MRXnlYaLB4I9HcyiGiaMqlribcvFcUtOf7Mm27h0CQtksR4zfLLx7vnGE+4+ljEVH
         CkspdUpdySSHTlrINfW941oP+H+1LedIToA9JbW1N7MFT5tW2iHb3IjnRyX9IaaYt3qW
         9dnA==
X-Gm-Message-State: AO0yUKVG0sZtJbr48EjVQXthCn8ROPLRO8avjaXuOhPyEU+2+HGt23x5
        GwakUEarSnOrsUmZzUXQImX6QVEPC6MGp3r4ZrsgGCsc2+8=
X-Google-Smtp-Source: AK7set9Aj72PaXSQYbX8TsbkXONqrKO75LWnj//JaSDbQA5D//9ZZPpx5jqaxjgD7hIG2M6HbVn/hjxtRdlILEBv/Js=
X-Received: by 2002:a17:902:b58e:b0:19f:28f4:1db with SMTP id
 a14-20020a170902b58e00b0019f28f401dbmr446379pls.8.1679449825235; Tue, 21 Mar
 2023 18:50:25 -0700 (PDT)
MIME-Version: 1.0
From:   Amol Dixit <amoldd@gmail.com>
Date:   Tue, 21 Mar 2023 18:50:14 -0700
Message-ID: <CADNhMOuFyDv5addXDX3feKGS9edJ3nwBTBh7AB1UY+CYzrreFw@mail.gmail.com>
Subject: inotify on mmap writes
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,
Apologies if this has been discussed or clarified in the past.

The lack of file modification notification events (inotify, fanotify)
for mmap() regions is a big hole to anybody watching file changes from
userspace. I can imagine atleast 2 reasons why that support may be
lacking, perhaps there are more:

1. mmap() writeback is async (unless msync/fsync triggered) driven by
file IO and page cache writeback mechanims, unlike write system calls
that get funneled via the vfs layer, whih is a convenient common place
to issue notifications. Now mm code would have to find a common ground
with filesystem/vfs, which is messy.

2. writepages, being an address-space op is treated by each file
system independently. If mm did not want to get involved, onus would
be on each filesystem to make their .writepages handlers notification
aware. This is probably also considered not worth the trouble.

So my question is, notwithstanding minor hurdles (like lost events,
hardlinks etc.), would the community like to extend inotify support
for mmap'ed writes to files? Under configs options, would a fix on a
per filesystem basis be an acceptable solution (I can start with say
ext4 writepages linking back to inode/dentry and firing a
notification)?

Eventually we will have larger support across the board and
inotify/fanotify can be a reliable tracking mechanism for
modifications to files.

Thank you,
Amol
