Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89567938E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 09:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjAXI5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 03:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjAXI5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:57:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BFE3D096
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 00:57:17 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so9919202ild.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlqNjgd3eRIYDTKHlZ6hEp0r6nIEjM/F53EV9FU/n5g=;
        b=lKoO+fuvUTS4FqtsYRXal268VZwhI0CF/eVEKrcooh84MRCSvHwOF5QmuMu1KXG42U
         Ska7B1v0mgcAlfB/FUXyMhqxW/aiVvEoLkqUrRfOYfeG11WFdGYY2MZoet7qJWT5hi2j
         aZrO21vbDpZvUk3wVYjWNjNxkVzsbDaEhKyNEiCTghyntl4pX6Bv/d8VqsFxrEipgGhU
         fJv0yGX+ZQqYeaLzcJKjH8PtEUDo1AfTllq/yokfMGEb4b0oQXeGq47Q1PVPzlcVwaNB
         WzNu+yM0CvLrjVByPFV2CD4r7YhT5dGM7h1MQSOhlbhU5/ukz1GdKywCFrZLko+HYC9P
         WF8Q==
X-Gm-Message-State: AFqh2krjGBEHR9w6VFC1e4VoMk6tCviwbApPhE7djx/M8vbXfSr1W4OC
        06fogBTBSktoKekLUo2tyU+9XQ+6WqQPFhQ/O0zjjOAfw9mQ
X-Google-Smtp-Source: AMrXdXsUCkXvgb7fvzNjYB6vnqz4sxeezDwrNKweS81JCSIk15mqbkNS22G0WGDO5DzSrUWEHro13o0p3tgMObQkCGbbSKHQrrHp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:30f:11bc:cc6e with SMTP id
 h25-20020a056e021d9900b0030f11bccc6emr2638812ila.87.1674550636901; Tue, 24
 Jan 2023 00:57:16 -0800 (PST)
Date:   Tue, 24 Jan 2023 00:57:16 -0800
In-Reply-To: <000000000000e4630c05e974c1eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000defd4b05f2feb35c@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in evict
From:   syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
To:     feldsherov@google.com, hirofumi@mail.parknet.co.jp, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4e3c51f4e805291b057d12f5dda5aeb50a538dc4
Author: Svyatoslav Feldsherov <feldsherov@google.com>
Date:   Tue Nov 15 20:20:01 2022 +0000

    fs: do not update freeing inode i_io_list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111208cd480000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1353a3e2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16163dce880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: do not update freeing inode i_io_list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
