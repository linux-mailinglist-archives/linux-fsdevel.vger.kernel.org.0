Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1F5EEC60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiI2DT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 23:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2DTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:19:25 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E51127C90
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 20:19:23 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so8899576ioh.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 20:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=k8pU7Bh5RwKCMgP211NYW62QI4BarLz13ohY+19epW0=;
        b=Arab6WmzmHASJF/I2/WGLkZA+ug2bAMM0Kxsk9hhgdDJdH7CCk+RMQMJvOAgAkJebA
         6qiSHmOowkXtWFCXnrR942Atq5TnWhkW8eTobGFXRNJszvBdo9ThPPCzMY3fuPQ0DyVW
         7sND7w2duERP1xhyqiaLqssbZUJEIWMS2xkkB9SmySDMvoXAKV6xhNulSwGD7/Np1AFQ
         l6/FaELXeMiZRLl4ZS+p2fGu9kgeirmHcCN48pzmqoqofXb0tIBZO4WBCY6d6rokecko
         GHI/eRoPndxdIfe61gsS8eqI/t1//JFRLF6WjY6gVFoH0J3lcRhSYGAMNYTzoMbMXj0Q
         0q5w==
X-Gm-Message-State: ACrzQf0YfJaImkNMKQB2BQeQVEPdthr9Fx67eHjkYgsgVRjNkS0u3AiY
        0GRodKJEm2lI/VOVbP0t/RH6AgTeLsHgbTyWD9fs/gufI1xv
X-Google-Smtp-Source: AMsMyM73L6FgJylk0iC+1Mc2BfeKqe7z1SflMa2sORht4O2Tt4LB2kJresyTVU7i/apJI9cN304jMPltHzNz6DJOOZrL3jEh4Xuc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:2f1:dc7a:c50c with SMTP id
 q11-20020a056e0220eb00b002f1dc7ac50cmr530227ilv.269.1664421563277; Wed, 28
 Sep 2022 20:19:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 20:19:23 -0700
In-Reply-To: <000000000000fea8c705e9a732af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000092f3105e9c85857@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in hdr_find_e
From:   syzbot <syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162d662f080000
start commit:   3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152d662f080000
console output: https://syzkaller.appspot.com/x/log.txt?x=112d662f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=c986d2a447ac6fb27b02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ffc374880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102db9ff080000

Reported-by: syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
