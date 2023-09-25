Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C07ACFD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 08:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIYGEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjIYGEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:04:42 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD1DA
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:04:35 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a9e0f4e17fso13430982b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 23:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695621875; x=1696226675;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khHBmXA2nIs3RhLksCBbFyOHEO223Qv5mG+a8oCpCJQ=;
        b=V9wWyDST/l/wGr8f2Rs8OS5/IiNbAbR0/2YYH58R9jZaYjF+ATMi6Pk4e+lTFIotax
         7dOiIBYCCUv7x7H2o2+zr3RInyXEOw2yvfCzxZUDGkFZDKRu4kwuPU/XigeiQvSN8O6i
         VbiCX1W4q8Db7s/tLtCSU6hYAxBfSti4HxDNdbBDHdH5+huAA+fujC2YYaBrjbEWr1c6
         mMBunB3oUbbE+P1NRoXSkc0rimnQ48rXUemv5TYv2x3o3sy9fqmAyYVqajXHFmoCCvl8
         7QzIckCqwD7ioxH0A6sVbV3XGkZ3s+6uL0MaLattnZ+8NrJmBtu5wJM4SHU6I5bi4bBF
         Y1lg==
X-Gm-Message-State: AOJu0YzdjZ4wvasZA0qM7pv0hTfmCEINJ3w4t7UpwGbygoQZPmO3jI2r
        9HoOl7aDnGp+5PWly3pvc+NCYuKgbNhVk2FRfGwEZtKmsk+Y
X-Google-Smtp-Source: AGHT+IE485Egvd8Rw1szIweDcKYzID3+yJ1Zs3+MB+PybtfzFp8nFtfcYXSU3GYVqtn8I5orYLBFoL1j+GIQC7zKRp855KirTrKA
MIME-Version: 1.0
X-Received: by 2002:a05:6808:209d:b0:3ae:17ed:fdc9 with SMTP id
 s29-20020a056808209d00b003ae17edfdc9mr3280617oiw.9.1695621875117; Sun, 24 Sep
 2023 23:04:35 -0700 (PDT)
Date:   Sun, 24 Sep 2023 23:04:35 -0700
In-Reply-To: <000000000000964cb905f5e876ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a3693060628bb0b@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in delete_one_xattr (2)
From:   syzbot <syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 9df085f3c9a2d4658a9fe323d70c200aa00ede93
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Mon Sep 3 06:12:09 2018 +0000

    ovl: relax requirement for non null uuid of lower fs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1711e75a680000
start commit:   ac9a78681b92 Linux 6.4-rc1
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1491e75a680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1091e75a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=7a278bf8bfa794494110
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1295e4b8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140af20a280000

Reported-by: syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com
Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid of lower fs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
