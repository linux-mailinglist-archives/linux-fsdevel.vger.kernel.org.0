Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4407AD3EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjIYI6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjIYI6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:58:30 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED5810C
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 01:58:23 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ab7fb11711so15878007b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 01:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695632303; x=1696237103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EurnUkomrOybXfcgrXZuQitSP0zinzawJwrJpWfbiPA=;
        b=GmA505vATjkWJSFmR4qWJAJyYqHBsiNakFsZdxwRlKRtd+9ienolrkUb9aFzgwOPAt
         1+IsaEleZ6t9785avMlAmiSkfWbB1e2dceATiejGdMudJjYMcSYNakqw+vh3PFVtlB4i
         IfdU1za+iC9R4LTFjV86jcoyzHTqOtuT0pYDxORabdWpYh07xdG88/167W7ALa5L8UTn
         Uv0m297HnKFU++OE0dvaqbYNpT/0tdj4UGAeDD00H3Mq+oFMbnEHFvSnV+qUhFad41A6
         EPgny0ZBGEOffUzuuv4VeqW+e5LxyYCCcz+F5XaeWu8Ymq4AU+6mUhx/gBXcTwMvbr1h
         DTrw==
X-Gm-Message-State: AOJu0YxHrsW2Zk+StMnDBej8JOm9svGHqmbIfZVhQhVPMwK1nIsD7yVr
        TQV/oLvH60dmPF89Z5D+bmohlThQBsrwfYjSuv45dner9TnI
X-Google-Smtp-Source: AGHT+IF3v5GRFV5mmAfWXw6rV+f8k2QYVWCdAFdC5hzNpU1JfWvb6u1WrQ/KqONLjzxllMrwh858YJvldWtAWl1Gi75391tr4cJK
MIME-Version: 1.0
X-Received: by 2002:a05:6808:20a0:b0:3a7:3b45:74ed with SMTP id
 s32-20020a05680820a000b003a73b4574edmr3859910oiw.0.1695632303202; Mon, 25 Sep
 2023 01:58:23 -0700 (PDT)
Date:   Mon, 25 Sep 2023 01:58:23 -0700
In-Reply-To: <ZRFKBxoRjVQclPS0@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a28c006062b292e@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com,
        djwong@kernel.org, hare@suse.de, hch@infradead.org, hch@lst.de,
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/buffer.c:2068:40: error: 'return' with a value, in function returning void [-Werror=return-type]


Tested on:

commit:         b8908de1 iomap: add a workaround for racy i_size updat..
git tree:       git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=999148c170811772
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
