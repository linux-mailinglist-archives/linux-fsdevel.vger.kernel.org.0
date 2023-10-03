Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C51E7B725A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbjJCULh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbjJCULg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:11:36 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24D9E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 13:11:32 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c6370774e8so1558174a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 13:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363892; x=1696968692;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ajmCqeB2BnMNxS0zpiFZGL2PM4lR7Y0JKiiYH6sw94=;
        b=RQCDBAxL/Nyd9VHLxno7dGD3N7+CemLHk+y4+YdhIQCHXk30Q8e7O4FnyRBiGxyx1O
         Pq3z3u5ti9s4DYr8oxBfUGnvbehu5TVKpmy6W2QB/NHHhipYOmKEMncvimiwh5Rkf2O8
         pic3Sjb3m8pFVGaqqfyPNm16CDO0KTYmgryy0PBUEUNNHLn8A138f72Kq8rzYqouoaL4
         qeiaFTw1C98rUbZCeVIkcC8wyuxh3vl3t2PSjUVlHnt6lBytheMwZj/eOa1NR2tzd1tz
         7mfSRMlBP9W+9IoswiV8ukHVdV+goR/BINzuH9D8MUmEg9sl8EOVsi8g5SYAnsjDj6pi
         Vr2g==
X-Gm-Message-State: AOJu0YxTXNUS3k3Xr12V2whf3b3PFOolYFLGmcdRT3IS4FChJWlGmcE2
        GCBAGLw9AdeiO9AGjdOowWfCw+f2tkZMuFKpOl7n+7clAVaz
X-Google-Smtp-Source: AGHT+IEfWZ0ebEBLw/JhSV7+cQIKaqZwWpmJ3XvCYvUTR2PbG7CW66InXrWydWpHiDXh5vLOGZu5MLBsND8rab2i9TSxKLyepv9J
MIME-Version: 1.0
X-Received: by 2002:a9d:6656:0:b0:6bc:e2b0:7446 with SMTP id
 q22-20020a9d6656000000b006bce2b07446mr66820otm.1.1696363892265; Tue, 03 Oct
 2023 13:11:32 -0700 (PDT)
Date:   Tue, 03 Oct 2023 13:11:32 -0700
In-Reply-To: <0000000000002709ae05e5b6474c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035587d0606d57fec@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in __filemap_get_folio
From:   syzbot <syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, leon@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, sagi@grimberg.me,
        saravanan.vajravel@broadcom.com, selvin.xavier@broadcom.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 699826f4e30ab76a62c238c86fbef7e826639c8d
Author: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Date:   Tue Jun 6 10:25:31 2023 +0000

    IB/isert: Fix incorrect release of isert connection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144a99be680000
start commit:   105a36f3694e Merge tag 'kbuild-fixes-v6.0-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10174404880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169f552f080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: IB/isert: Fix incorrect release of isert connection

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
