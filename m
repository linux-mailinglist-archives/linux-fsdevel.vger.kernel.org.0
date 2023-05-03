Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50946F5492
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjECJXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECJXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:23:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF844A1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 02:23:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331027514f6so20546985ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 02:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683105799; x=1685697799;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGQwBgpI0bqdgO8pKEEKbKv8+LeoHbpWth2gSQz7m8c=;
        b=YHOq9rvxWfdPmJvaJC8PDFZsnwwOB2sxq4HeydFsqqSBQxmun73WG1IYLlJCXdNNeM
         5JJ/1w7z4GHirohZX+vYK7odNrU9QjDaHrtw5kTbMpDT9HJvnr7e+ID5IHBP2a8U3guZ
         jsmlFB22p0TCOXy44mWDjipzpO3iZQU9HUQ6KOc6HPot4IqvufR0Ui4DtTXOJnZj+xXh
         U5BVyKouFjVGbpasF19Yf7Yj2c9yx/9Hf46pdQfN4dzx6N52b+kKqtwySkvvA7w8oCjC
         o6NvUYgN9LBL0AYg9ARUvna/X4/7WS6izAghGP+XujsGo3MT1m00jVGtQ3529mAwaAG/
         UJtw==
X-Gm-Message-State: AC+VfDwN+EfRl8vjpbCQXHDnDUM25Rd0Wo6QymsjBgvi6hDykNrYsJNk
        R5wVXtVggrril4/Bu7nlB+QKs6VYZDYNmui3xcVrxRKcrxEx
X-Google-Smtp-Source: ACHHUZ5aG/XfDHqoKqO+ew2JWIPDDza1z+e6Rp2DamFuAlgepSexYCvFh5GJosvlwf7Pk/iL0j6gaCeA1MFSQp8enMVfNw4U3owM
MIME-Version: 1.0
X-Received: by 2002:a92:d98f:0:b0:331:2d3a:2cf5 with SMTP id
 r15-20020a92d98f000000b003312d3a2cf5mr3245587iln.2.1683105799342; Wed, 03 May
 2023 02:23:19 -0700 (PDT)
Date:   Wed, 03 May 2023 02:23:19 -0700
In-Reply-To: <00000000000090900c05fa656913@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a34a305fac69bcb@google.com>
Subject: Re: [syzbot] [mm?] [udf?] KASAN: null-ptr-deref Read in filemap_fault
From:   syzbot <syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hch@lst.de, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 66dabbb65d673aef40dd17bf62c042be8f6d4a4b
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Mar 7 14:34:10 2023 +0000

    mm: return an ERR_PTR from __filemap_get_folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15220608280000
start commit:   865fdb08197e Merge tag 'input-for-v6.4-rc0' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17220608280000
console output: https://syzkaller.appspot.com/x/log.txt?x=13220608280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1c8518c09009bad
dashboard link: https://syzkaller.appspot.com/bug?extid=48011b86c8ea329af1b9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137594c4280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cfd602280000

Reported-by: syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
