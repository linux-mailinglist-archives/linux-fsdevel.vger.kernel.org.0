Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522F7A44F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjIRIkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbjIRIjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:39:42 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1EDC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 01:39:36 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c22d8a0cecso5972438a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 01:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026375; x=1695631175;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45KiI20BMzkbiSraX+XzVv0AVcWyW8x18IOZnldh45c=;
        b=rh5PeovG9GMPzjaJsbK+tqS9bLG6F55x3UV6LIZl7Ho+6Q3ZO4zXYPBKKXpCLsrCQ6
         asyn9TcKJFVMcTKktwV6N2vFDAGaUT5zmB6iyuPFgIkpdKLcTGN18YWC6suxc676nvNV
         wW/tnIsPtiEIdIcxv2axmNKD+G1MZ3H8nLOKhKhT+6U3OyfzuAD2UMjoONuHqcLEpW+p
         GAAunSvYQ38jz9ezWjGGnNMX+EUFWHYnbG1+EPTvpK0yKZOJb6ZrMZMVfBcQytOL3sCV
         sLwcyYUS2JtPCwSQCXe3vQ++Dqg6FXyljAZbUE7mfN7Y0pODhA0rHQuPY1Mc/QPz8NtM
         hBEA==
X-Gm-Message-State: AOJu0Yx3ozsWIfrLADhQGLtP5gbh5AEgGBuP3dEtZxVehfDIPxLWo4o5
        Igvzq6r3ry4jkIEOhkcuXCzF8/VusLA7Lfj1xCdbnksuc22S
X-Google-Smtp-Source: AGHT+IHaw4qvgyW8P05njsrzZAVkQ398quj849dW1jRa7JJ/jRsXyO7iZr2gFbrajDFa9tDv+JBzQkZ5g1fDTUwzzq5aAw65zZbp
MIME-Version: 1.0
X-Received: by 2002:a9d:77c9:0:b0:6b9:182b:cebc with SMTP id
 w9-20020a9d77c9000000b006b9182bcebcmr2559764otl.7.1695026375542; Mon, 18 Sep
 2023 01:39:35 -0700 (PDT)
Date:   Mon, 18 Sep 2023 01:39:35 -0700
In-Reply-To: <0000000000003a29fe05feb87e4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffccbc06059e1493@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_run_delayed_refs (2)
From:   syzbot <syzbot+810ea5febd3b79bdd384@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

commit f8f210dc84709804c9f952297f2bfafa6ea6b4bd
Author: Filipe Manana <fdmanana@suse.com>
Date:   Tue Mar 21 11:13:59 2023 +0000

    btrfs: calculate the right space for delayed refs when updating global reserve

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fb487fa80000
start commit:   dad9774deaf1 Merge tag 'timers-urgent-2023-06-21' of git:/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11fb487fa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16fb487fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=810ea5febd3b79bdd384
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ceaa3f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1502f600a80000

Reported-by: syzbot+810ea5febd3b79bdd384@syzkaller.appspotmail.com
Fixes: f8f210dc8470 ("btrfs: calculate the right space for delayed refs when updating global reserve")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
