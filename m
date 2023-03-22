Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499B66C50B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCVQ3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCVQ3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:29:53 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B845943C
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:35 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y69-20020a6bc848000000b00758ac1b67f8so1390987iof.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502560;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myMUdX4Td4phlYiYoVFlcuB6n75wqpmUtnUNsWB1v2A=;
        b=pbV217e+F0aSs8BuGGPPolNuqoD9+jjGFV5uzqdlSspUs9tQhnJXaNmKDGXFCmFDH6
         rwpBVlaf/+3MefHm1HL2oJp7yDyxY3BFacNDcVzafkHvS0hE6mL0CVuTW7MlUcqZjvU2
         dTwJNMSV9HEMTa8IxDDjAuo2GooAU9R3Y5N5BOPZHq2CC6jg1llXGPNEpY3TCoMUdHXf
         pV3A9HHKWnToicBuz7hSiaTUAbFAxlzUZQ6avP0jo3rQ8o5MrrG+AQBzR+/g5T97WEId
         A4GOmdJnFAxtWHGtCQ5ihswZ1CWawZyLfFK0eIsHdCPk04eAw/nKMt4Etuvshln6m+Lo
         KP6g==
X-Gm-Message-State: AO0yUKWZKjslB+zzRL2SRQl1aFxhAbbrZ+HO0e8b22brVtsqW0SqlXb3
        sNnQ/tnvXZbyOoISyJvWq+mA0amx4pD7fQdUMNAubjuSD382
X-Google-Smtp-Source: AK7set8UtppURXyjZYz4V6LU8LYms2UD7afjr6Tk9mQTvSHTS04gvIpwMP8pz46U8NsrTOvMsx+hLnb5TJXgArCXYrztGZpxunVg
MIME-Version: 1.0
X-Received: by 2002:a02:9485:0:b0:3be:81d3:5af3 with SMTP id
 x5-20020a029485000000b003be81d35af3mr3321113jah.3.1679502559866; Wed, 22 Mar
 2023 09:29:19 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:29:19 -0700
In-Reply-To: <0000000000000ece5005eaa8f1d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007af84a05f77fa920@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocBits
From:   syzbot <syzbot+b9ba793adebb63e56dba@syzkaller.appspotmail.com>
To:     dave.kleikamp@oracle.com, jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d90bf6c80000
start commit:   a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=b9ba793adebb63e56dba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1322ae34880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10403c94880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/jfs: fix shift exponent db_agl2size negative

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
