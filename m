Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624836D0F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjC3Tpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjC3TpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:45:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFFF76B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 12:45:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so12557301ioi.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 12:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680205522; x=1682797522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v1vNtKpcx2RQzSR6kq5eMD7prx8eXvuLXDx4S7CMpk=;
        b=RyPJocbexd5Kd3nPfdEffFzC7UI02oD9RbUo1ymNxp0VqarA2leZ8JYGci0QtIi5dL
         qI/D00VuWDx6WfVJQUdRL5D5KzD3DcrT3QDmTtrBZChIr4P1TRUNnLnx0ZV7ChCqq+tD
         NWC0G/W/vCv3IE6kvNVxD1MF1EZBqVc4dMGA7NfHtedp+Z7gqsNNYCrLhRPmNRimIe/P
         ZiacmM0bmia6hHuLvxZ0gubff7vU6zk/O9Qid1Ed7e9Zo3pv0gke0mqj997nRrU24ltE
         tUVbUzC+dR2yaoHLfwAX3L5+pez2/lGm1TGZ6H1ZrZqVRhw0AaKL0OmpZwsJq5W1wm5q
         iPqg==
X-Gm-Message-State: AAQBX9cH7wHwdkoWLKpwoN3rhDnPbN7OcZnZ8OvetrruOHR5lulG6tan
        C/JLmM9qdlA9WuD7H9fdV/qXxpab2l/f4RyPGWefbaUcbv+L
X-Google-Smtp-Source: AKy350b4D4mKslDZ9T3BlZq3TqXJNY6nmfkJGCdtKDX3dN13u8lKrd4zJzVeTy5Ayvw6jeWZ1qHOBpMkGek6RPM9Xj0bRsM/O2cI
MIME-Version: 1.0
X-Received: by 2002:a92:7603:0:b0:323:cab8:3c0c with SMTP id
 r3-20020a927603000000b00323cab83c0cmr12585397ilc.5.1680205522304; Thu, 30 Mar
 2023 12:45:22 -0700 (PDT)
Date:   Thu, 30 Mar 2023 12:45:22 -0700
In-Reply-To: <00000000000093079705ea9aada2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ee9b405f82355d8@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindCtl
From:   syzbot <syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com>
To:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146d74a5c80000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=7edb85bc97be9f350d90
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5817a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d68cde880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/jfs: fix shift exponent db_agl2size negative

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
