Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC437A578A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjISCwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjISCwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:52:45 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6B10E
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:52:39 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3aa1396ffa6so6646609b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695091959; x=1695696759;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1IjXmLLQ87nu+7+2vWII1so1UkZOVn9xt4tJ2B60iA=;
        b=xI+dZAvT5Z300VhyG0EHrGQ1Z4iSQTI5cIIS2OlyWndrXMtrvD4leOcyI4du76e52l
         cQUlOHFXIu9k3Jh49nirPW0uny2XJ3y5dlrE85Zz3kGe+h4BYQInd9tH8tXgeJAgMdxg
         8wJeE8j20ntzipKnqYYQRahwpco/8zgKofKKOGg6VTyZhiX6lKKday/UeMApOOn0uSFu
         CexFxIHUOeYIs3QSfzrXPwBxxn6DO8LsEGo1yCkUVUDSodbnutCeN0FPsLfT2R7JBig5
         TPQG4e2N8RJPalQu1m3ih7QTtwJyk2zRDunBRqKCOIYreasJQ8yM6/lBBjt/5C7q4bMA
         99iA==
X-Gm-Message-State: AOJu0Yy4Y5I5Fxnv4F32iLs9c3RmElCQkQ8C0RnlYXA2gI5XCCR3SzBX
        455yeRtW5RWQS3cEBjC7dDuGah1DhhXbxEhc611jcKjn6yd0
X-Google-Smtp-Source: AGHT+IGwx53gLAoDlfe5EQgVNwxeuxguK8KPzmoyLvOPdDG6yB0m7AVz3DPTOccsWpwx3pYf7y/rCxOLDGdPEvSWIiS7Pn5s9+g4
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2da:b0:3ad:da36:1dd6 with SMTP id
 a26-20020a05680802da00b003adda361dd6mr648710oid.1.1695091959036; Mon, 18 Sep
 2023 19:52:39 -0700 (PDT)
Date:   Mon, 18 Sep 2023 19:52:38 -0700
In-Reply-To: <000000000000e534bb0604959011@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001486250605ad5abc@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com,
        djwong@kernel.org, hare@suse.de, hch@lst.de,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, mcgrof@kernel.org, nogikh@google.com,
        p.raghav@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 487c607df790d366e67a7d6a30adf785cdd98e55
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Aug 1 17:22:00 2023 +0000

    block: use iomap for writes to block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1086cb74680000
start commit:   f0b0d403eabb Merge tag 'kbuild-fixes-v6.6' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1286cb74680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1486cb74680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=999148c170811772
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16148d74680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e10762680000

Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Fixes: 487c607df790 ("block: use iomap for writes to block devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
