Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405F6BF762
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 03:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCRC1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCRC1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:27:22 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724D7C97D
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 19:27:20 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f15-20020a05660215cf00b00752dd002fd1so3284491iow.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 19:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679106440;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0u9iCqtoAmqFPlWvcnYREgJziHl4srI427ufeguhoqM=;
        b=Tf7ajoeJpM6JOWm2vgLsoOeUvGjyUi3gQ02nM9JcQ/4A2P+lV0Neb4xP9Riui9uegd
         4eoIDi99tKWUup+KvrMJflqEASSRpTo66zS26tptU7ilZghrbPJdHhRy78KPwG+Ce/Wo
         1RjR5rZMlzIVyGY6zPfIBekDv0SQn6dQjnZY0RFi26JqcAJhFPHRXmtpQCnyPqUeD4tq
         6LVscTFgHlYMUS9BemRFNFMvG2fFEimgw65CtQWaNqPWkgmIl9TuW0KMbRjni14h5tDG
         zrezGYft3zXwmOOnNvIvlatIIOCEUbXxfwL4wVpEgE+D/1iuJS4rejLaxwvAUGswpdCY
         u6eA==
X-Gm-Message-State: AO0yUKVIQaXQefqNWyQU8AKsNIvSJ5w7rsWyIbnCacRIuzaY9yocftAI
        BWydjikirO91pZdTnq8S2ySWd2ZXIL++mACJgfOxufStUeJl
X-Google-Smtp-Source: AK7set8wss4kUHb8bvkmj46rggkVv7EYWpiCNxgTNjAiaYvE3l2uDADG4+AdbZbUYfVh0de7isnTkVF1g0r5VUiiYVo8PDDYYWkv
MIME-Version: 1.0
X-Received: by 2002:a02:b181:0:b0:3b7:9d19:fec7 with SMTP id
 t1-20020a02b181000000b003b79d19fec7mr266557jah.0.1679106439975; Fri, 17 Mar
 2023 19:27:19 -0700 (PDT)
Date:   Fri, 17 Mar 2023 19:27:19 -0700
In-Reply-To: <000000000000aa58fb05ed5beed6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e51b9905f7236ef3@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbMount
From:   syzbot <syzbot+0835e526215d5dcefaa9@syzkaller.appspotmail.com>
To:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, mudongliangabcd@gmail.com,
        paskripkin@gmail.com, r33s3n6@gmail.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, wuhoipok@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fad376fce0af58deebc5075b8539dc05bf639af3
Author: Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>
Date:   Thu Nov 3 03:01:59 2022 +0000

    fs/jfs: fix shift exponent db_agl2size negative

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f3046ec80000
start commit:   513c1a3d3f19 Merge tag 'trace-v6.2-rc6' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=0835e526215d5dcefaa9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d599df480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bb69a7480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/jfs: fix shift exponent db_agl2size negative

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
