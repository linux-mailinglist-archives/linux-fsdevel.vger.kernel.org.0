Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41177D8FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbjHPDW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjHPDWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:22:34 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5226A4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 20:22:32 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-565aba2e397so4438733a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 20:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156151; x=1692760951;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooGNY7qKQQrjisOoBTNramsab3weG3fX3Z2Pk0O7aY8=;
        b=T9aG7TtHEh/8VkZQJb0jCn8hZKo1ZTz2dWjoeHGFo2hM50RrqIR0RneblLlB42fyVj
         XekPEkwf2ro0f6k8dNMteHOvvDr4UuJF4k65sqSBxfseD5s3TeMTUfCrj8mp/c10COOC
         JuEr+jeIaNtFRHpSSiUQmnDQZSw0zxc8djzwvguUnyCTxMaKLrbtGakYNbKjZl8BlhGB
         n6dbvHAgcsArX1kQpNXaQexCf2aiQq/ZjPw529gC9Cmqx8YVYNpsYTUr+f2a5cZdYYCy
         tYn00JKe5/0pPI/6decMmmddXCM3cku0iwoc2tCB+vwb52BZy6YfA20d1OR4X5PiZAJH
         Md8A==
X-Gm-Message-State: AOJu0YzbTkDLfT04Y8u2CQcYzx+VHC0nSk0/XJrKG1pY8LlZEdKE0N04
        9Vf6eN4sMvTiLFiCfoynrlZabknvpWl8Iv/vxVQ/ObJjypxD
X-Google-Smtp-Source: AGHT+IGzBr6H5KaPX1XvTBWzFlq1MEiZGuRTXVrXmq3Vs6XNPA0xc9PqfBi64qRdEdDn4KjRzrBadwS3aIRuRhpGwtD3IivJoeSd
MIME-Version: 1.0
X-Received: by 2002:a63:af50:0:b0:565:ea31:5c5c with SMTP id
 s16-20020a63af50000000b00565ea315c5cmr116967pgo.7.1692156151629; Tue, 15 Aug
 2023 20:22:31 -0700 (PDT)
Date:   Tue, 15 Aug 2023 20:22:31 -0700
In-Reply-To: <000000000000f1a9d205f909f327@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000528ff0060301ce79@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in quotactl_fd
From:   syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.com,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 949f95ff39bf188e594e7ecd8e29b82eb108f5bf
Author: Jan Kara <jack@suse.cz>
Date:   Tue Apr 11 12:10:19 2023 +0000

    ext4: fix lockdep warning when enabling MMP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a06a65a80000
start commit:   1dc3731daf1f Merge tag 'for-6.4-rc1-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc2a92280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dc5fa6280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ext4: fix lockdep warning when enabling MMP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
