Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A87B34E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjI2O3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjI2O3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:29:21 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542841A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bdcdde1df9so28375775a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997758; x=1696602558;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLNYUvgMbabObe54YV0karBMGjsfh+7I5wYZ60IM97s=;
        b=LUIWZuylhj69A+5OZQsRqnmMSV7zNUHiu6gpdU+tTH+aq0mgqGbo6QncDT3RXKpvjq
         CFmtoHydny6BJ9QN9BKZLa+n9POmzmpi1rr78zlFpxtBeU6NFjNyNYNun/Ig5XWUY768
         7yBzDW9MZxk/0iIgYiS+eSY/FBY4FBjk+5R1QrEvFpzgK2O7V0YS7MHVSVkT/luH/Fed
         LOUUdVmiM9I/DkFILPWewSWuXngRw7QGVfdSOOzlKEKTpvs+YozDiwYv+npxAvA8OGvM
         nfStyn4QuyOdp3vrIyZuHhlxuDSuihyy5/Ix04lyWzW0ldKmhRcn4N25IZio3dCRPBYu
         Yxmg==
X-Gm-Message-State: AOJu0YxBymqsgb6gSWx0cbSYAvfMPyZ7wGXxtBzGuZny73ySulocn/Hc
        bbGG7+zgnTWFP/NevWyCTLv4h+SUhrsh4DucafswdV4ZLpk8
X-Google-Smtp-Source: AGHT+IG9OxQod939WyJcDOMakaPerThj04UyypSfq5sPAWlD5D37uESD2tGQLWQZKBYvHdw4rTZ+6ZUDvxSn+5Ah0pz7GJKY3YKo
MIME-Version: 1.0
X-Received: by 2002:a9d:6a50:0:b0:6c0:a3e0:f9e9 with SMTP id
 h16-20020a9d6a50000000b006c0a3e0f9e9mr1165244otn.4.1695997758619; Fri, 29 Sep
 2023 07:29:18 -0700 (PDT)
Date:   Fri, 29 Sep 2023 07:29:18 -0700
In-Reply-To: <0000000000005697bd05fe4aea49@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f147d80606803f1d@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
From:   syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bfoster@redhat.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

commit 310ee0902b8d9d0a13a5a13e94688a5863fa29c2
Author: Brian Foster <bfoster@redhat.com>
Date:   Tue Mar 14 13:07:59 2023 +0000

    ext4: allow concurrent unaligned dio overwrites

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a8442a680000
start commit:   9ed22ae6be81 Merge tag 'spi-fix-v6.6-rc3' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a8442a680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8442a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=307da6ca5cb0d01d581a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb672e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16219bc6680000

Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
