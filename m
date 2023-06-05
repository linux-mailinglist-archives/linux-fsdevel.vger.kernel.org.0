Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316AF722557
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjFEMPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFEMPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:15:30 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015BA1
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:15:29 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33bbffccf69so46314665ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 05:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967328; x=1688559328;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzcC4Hey3TlLF+JCJrqaNKZNKoPcd2adswJZJqNI+pU=;
        b=VO/w5gmhlaWXOyPIiaIo1iewh2T3Vo1mwFb0YpNsAud848QEFFo6LDSWOCqOxVfTjK
         BmnuCze+3PF6Op78zOJltjKDBvAA+J0Kcd8sdn8cB+hGVNXZAgmKR14g3kQct+hz7J7c
         XbDEnTw2Dj/GmEwFtH7WDltH/VfyGBjrNURtiwPySu7oGEAtrk8zHsgJ6HNprC/twour
         0e9EHEccdnkHO88+4TzdUNX6yHa/WkFJeoe0hbxUOrc9MPkjsklzbV5n42aEt3eeObVX
         IKnWEh68ZiTIG9ipWVLAnPjVaN/kPqVoo4SMiMU6zPaElxX1GH23Ixsvn5So6VGGaZ6r
         FkGw==
X-Gm-Message-State: AC+VfDzAQ4UGh89E65C8iVh+st7IYepgGHa26//jItk8utQaktO/WMTj
        SR+15nYdoHIusOfuRp8RSDzH2xqN55vTbRu5au9oT2iil8E8
X-Google-Smtp-Source: ACHHUZ5NyG760LvUIyh6Ghxb2pDPhqoTUCNhKpeEkwbtVO0go/50gBRFGI2dD9aDpFftz+yrb8n66ibdtn+dNeVhDMtDK08pOHt2
MIME-Version: 1.0
X-Received: by 2002:a92:d405:0:b0:338:b0de:5e5c with SMTP id
 q5-20020a92d405000000b00338b0de5e5cmr7036919ilm.4.1685967328467; Mon, 05 Jun
 2023 05:15:28 -0700 (PDT)
Date:   Mon, 05 Jun 2023 05:15:28 -0700
In-Reply-To: <000000000000d1149605fd5b0c0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b763f505fd60db7a@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_ioctl
From:   syzbot <syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit aff3bea95388299eec63440389b4545c8041b357
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed May 24 03:49:51 2023 +0000

    ext4: add lockdep annotations for i_data_sem for ea_inode's

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bdb895280000
start commit:   9561de3a55be Linux 6.4-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13bdb895280000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bdb895280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ff6e93280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11824101280000

Reported-by: syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com
Fixes: aff3bea95388 ("ext4: add lockdep annotations for i_data_sem for ea_inode's")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
