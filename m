Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94446CCCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 06:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhLHFHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 00:07:43 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38863 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhLHFHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:07:43 -0500
Received: by mail-il1-f197.google.com with SMTP id b4-20020a92c564000000b002a252da46e2so1422909ilj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 21:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tnvEcnHI7deEWxbqkKI/fN2Wn+QIAlfc8X3oFKTEmqY=;
        b=G9zhWc7uJxGAvSweaZVcWMwPiu+uWd8rYlIFe1echZdPt9cF5SwxgBl6ej1tkxoHhG
         1mXRcGL0UZpv+gXpc7SML9UU49NlPCLG/TEaJYEeNVOziAePnTmFqZEjlYpf2tIkSeYd
         FJ/b4LGT+3T9OtUgjzbjOVMirnBUgnnIFLwHLnrPTJGq9USnn8jfWRDILbFqM0AAzxO7
         9HNrFIZeS28rFWN8og5gQnuqWnlqs+Lb/ShNr0adzC5KvZh35Ap/mcGW9QE21tjCRHv2
         Zph5Qp0zoY/6HU0A5ptB/NII8o+A4w93CJgkjQWfCsew2BiCbWN0cg4AIxQy6W0uFr5q
         Fwkw==
X-Gm-Message-State: AOAM533Kask+LEZ2a2NLj2BD8cCqDhfKGklx5yyB46vcs90ZGx7fRY+x
        ORUnJzW5ZG0VkNg0ctPJ+KvwtihJpvij5qvpOzqEMZkZtfuX
X-Google-Smtp-Source: ABdhPJwm0RWykDAPtEx8UlrJfAiQzKFk5qK0UkARc6aPbXgU5gciPJ8DsiwY9aXoIJsshTCDAJiywzLcKqgahKGSviNBMVtm5Mh8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr3885081ilk.89.1638939851818;
 Tue, 07 Dec 2021 21:04:11 -0800 (PST)
Date:   Tue, 07 Dec 2021 21:04:11 -0800
In-Reply-To: <0000000000007de81505cfea992f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0e4105d29b6b0f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in io_submit_one
From:   syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, bcrl@kvack.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 54a88eb838d37af930c9f19e1930a4fba6789cb5
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Oct 23 16:21:32 2021 +0000

    block: add single bio async direct IO helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1615e2b9b00000
start commit:   04fe99a8d936 Add linux-next specific files for 20211207
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1515e2b9b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1115e2b9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db884db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e9eabdb00000

Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com
Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
