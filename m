Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE17077C14A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjHNUHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 16:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHNUHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:07:35 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E2410E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 13:07:34 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-564f73e2c59so5020266a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 13:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043654; x=1692648454;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESKM9ZhqAvF1tyO2W2reMjI8w6E0LleNDUBpM/RmnhE=;
        b=UAhAorukuFdqyiM7/PUTV08FrN+Rr+jG9SXwymbuJMY9pRnUMsFE4g4Gx7KW1pOk5S
         y9MQGRH6Nw+TbzUsYwKosfeYk0jU1/z1ZSWgs0ZXKNDiXyFdi5tcfw9urPfWTtLCt5Ij
         LWApep2OBoPmFYxojbxhE0RzjxSy/NG/9ADX66dXS0FaG/moBfgkYOsMCqA80gyfMWg4
         5nZ7aiJe+2Yq9UOzcHSJ6Y5g8hedeCOKF/VipUqjuU9fth7d6muIJm4rn6LCKyji3crA
         mQ6mimmKUa5IRDxswNrsyuvvIxr5At8WQw4dNip3vyewXX+iakiZ9cI7UQH60kl+Ias2
         VokA==
X-Gm-Message-State: AOJu0YyC8FJ2A6g8nlDokECV0sMcndLtGChs2bA4YH31fFevRV+9nCjl
        WTzvF5a2kAMmxwjoy1mctnWes7g8xg+fe8WnK9+FF65hpLXs
X-Google-Smtp-Source: AGHT+IGJcaYn7JgRZ5RWZ0KV6TFJca5wDYAvPboBneb2qZY/w8uSMizCAPOACt3KIN2USvkejBe0nBlwXzs9Fhs/bo31xoHLNaxE
MIME-Version: 1.0
X-Received: by 2002:a17:903:2301:b0:1b8:95fc:d0f with SMTP id
 d1-20020a170903230100b001b895fc0d0fmr4379586plh.7.1692043654450; Mon, 14 Aug
 2023 13:07:34 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:07:34 -0700
In-Reply-To: <00000000000024d7f70602b705e9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7d5180602e79cec@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From:   syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        steve.magnani@digidescorp.com, steve@digidescorp.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit e8b4274735e416621cfb28c2802b4ad52da35d0f
Author: Steve Magnani <steve.magnani@digidescorp.com>
Date:   Fri Feb 8 17:34:55 2019 +0000

    udf: finalize integrity descriptor before writeback

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e3d76fa80000
start commit:   f8de32cc060b Merge tag 'tpmdd-v6.5-rc7' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e3d76fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3d76fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10df55d7a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e4d78ba80000

Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
Fixes: e8b4274735e4 ("udf: finalize integrity descriptor before writeback")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
