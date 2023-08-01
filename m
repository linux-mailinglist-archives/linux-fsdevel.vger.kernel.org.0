Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98E76AD62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjHAJ2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHAJ2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:28:30 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CAB1FD2
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 02:27:23 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9ef9b1920so8054623a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 02:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882042; x=1691486842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C27ET6loiS4a597fDoDvp82lhEfceWexZEaZmg7rns4=;
        b=fJI8R9ASr86hh70y+09yGBIyYkdMLAp9RmLuxGnMm8y6OBdYLGox5vxnnqACNqjXAW
         35iWS0003wBHHynr91ChLUC40DVowhabaOEuM8dyskU/trSY/grmxlbyz7K9bA+uyQLC
         Mj7mDp8DV4jTr3edB4IAh7M+Cduh5KJn+WXdi2xph5XHfC6Jqbtlsdb9lh3unTst9yK+
         Y2lwzmEur1KhgNboAJLFekp1bVBXAwhkppEKks/lhlprGEMfPdq5YnNw074xckp+K5S1
         vDFMqKwMJmq/C724nX7SYeg+nkkUoiRe8IQIYOyCCB4eWarI2MJN8upGrOgCb1RG05bc
         ahxw==
X-Gm-Message-State: ABy/qLZ5gt5W6khnFNKiR0RLrcQb9/UMdRiTlttkwHqtPG5cycIiidIf
        v7wip13MlPWBvGl2WpOCNfgmSOvRcu4c/Y450En5PKwB1ux5
X-Google-Smtp-Source: APBJJlF+q8vTSApLRQ0DsriyRIAi3yXyfIxfMoDXTZLqGmWRh5yGZx5GzEG93qqQR4NAAm6evBr0m5ieLt5iW0rGmHW5H8t1P6Mn
MIME-Version: 1.0
X-Received: by 2002:a9d:6c8d:0:b0:6b7:1e75:18e with SMTP id
 c13-20020a9d6c8d000000b006b71e75018emr14153717otr.2.1690882042749; Tue, 01
 Aug 2023 02:27:22 -0700 (PDT)
Date:   Tue, 01 Aug 2023 02:27:22 -0700
In-Reply-To: <000000000000fac82605ee97fb72@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083e9d60601d927a0@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_free_reserved_data_space_noquota
From:   syzbot <syzbot+adec8406ad17413d4c06@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, christophe.leroy@csgroup.eu, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 487c20b016dc48230367a7be017f40313e53e3bd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 30 21:53:51 2023 +0000

    iov: improve copy_iovec_from_user() code generation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cfdf19a80000
start commit:   4bdec23f971b Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=adec8406ad17413d4c06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bf8bcec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153d4f75c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: iov: improve copy_iovec_from_user() code generation

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
