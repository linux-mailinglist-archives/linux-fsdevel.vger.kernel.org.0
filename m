Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB86B237B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCIL5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCIL5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:57:19 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F0DBB42
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 03:57:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m7-20020a924b07000000b003170cef3f12so774687ilg.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 03:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363037;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yX6TF+vn9/IHLiO2rdpruGDt6O5lqRy5gxKQUxEGJDo=;
        b=QkWWPFthKNyJ/IxNjCKstyg8QuapBnhWECFXIS956DdM9+Y3WkKwyC6jGzAyFn5Jdd
         owx4GSKjJVvWmBY8vvb2WvDydH1KmWtBK9jCszfu/hihV8xQuAUVbILtX0hIJBWuOU7+
         I9FJAKnxRPxmR1xO270AtHx5/DPjX3mcIOnkCaph1gVZ9t/1EzxQGU6bRI4ofEp2FkhX
         fcsCIpDH4Y9OLA31orDcH90HO7z7rNuyL5oTq5kELV6VVrk/KKX10AYjudM7tmDXcDbL
         1m3QVeNlNPcM+fx8uJEJVRlO2hKv7PV1+0LTXiz6F58SdCONGAYHpX/ft0ItNafdRKfw
         QWXg==
X-Gm-Message-State: AO0yUKXnnw0RyjYtZurzQDernGmzZbGw1XLPuYUFJf0jyk1dSYZLooV4
        1hnJYg0VIlONFjfndkkZIjkJWy7qh5BVR6v7DTLzcUBzsgdh
X-Google-Smtp-Source: AK7set+l8Q/wcIAHiiaNGzoKIqYWGV1eypA0ZwqCwtYTqttblmrfVY7wkNJf3lfXJvgGGVFWxEPLrQ5Yl2IIoz5/eOqsmab5UWT0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cd0:b0:3e5:4c9d:6e14 with SMTP id
 e16-20020a0566380cd000b003e54c9d6e14mr10876861jak.4.1678363037341; Thu, 09
 Mar 2023 03:57:17 -0800 (PST)
Date:   Thu, 09 Mar 2023 03:57:17 -0800
In-Reply-To: <0000000000004c06c405eb318db4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5202905f6765872@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs
From:   syzbot <syzbot+ebdb2403435c4136db2b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1541ad14c80000
start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb2403435c4136db2b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4d8ea880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13172832880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
