Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301636A4A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjB0Smb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 13:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB0Sm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:42:29 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0932725B98
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 10:42:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id k10-20020a92b70a000000b00316fed8644fso4326459ili.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 10:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/MmIATLIodGQjvWvqb3jf2lxxR5/7ZbnhVN/hVzQ7Y=;
        b=vgkhInaiLH/uriKp2MTKJ8ySUKRrYjt3macsgzv/5vIk6ZidMDW17QbyTfZ94TnVU+
         pFO1c5E0/pfveTiJpQq2/wstUU5SisCD7XGTg5FoKVzyg/HN7tWDQVX189vzvNFdS66A
         gRNF0GaM74CL9TzsCkZxLxMTJLLumKLf8DoRplN028FCEAOAqZs7bek4Heh3nJEi3PuM
         mg5RNJUEmo/8jNid1qu29go2pWSm49f6JBjaf7szmhnFmYQ9aaYjHhANY8Kfyb4jkQew
         UPQlm6PPg2udCcsl3fYjwA3XEAjF8Z5oUJK0sTQM2ZhJOH3upVuAdyFMLaen95dsPBH2
         Zhew==
X-Gm-Message-State: AO0yUKW+Lsg2ZZ7/cyhqRi4vmuCG6bXsXVeMT6wgMBn1PpKZrCtLKJXT
        +Cm+Ez2j5wlYWzBc1joyBwCnL9l+lbI9VigHLl/IapK7mmMf
X-Google-Smtp-Source: AK7set+0iO1ZG2YenZnCZqoZxcK2NT7Py3/3nhgWXf7rV57rE7AbHq5smoZp6w8CNYZCLPUgxIF4i1VObc/Z/09DdlAXdRMBG+n4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154a:b0:315:5d89:fb2c with SMTP id
 j10-20020a056e02154a00b003155d89fb2cmr6439429ilu.2.1677523348326; Mon, 27 Feb
 2023 10:42:28 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:42:28 -0800
In-Reply-To: <000000000000dca7e505e9978943@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000478fb705f5b2d79c@google.com>
Subject: Re: [syzbot] [udf?] KASAN: null-ptr-deref Write in udf_write_fi
From:   syzbot <syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com>
To:     jack@suse.com, jack@suse.cz, khoroshilov@ispras.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, pchelkin@ispras.ru,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e9109a92d2a95889498bed3719cd2318892171a2
Author: Jan Kara <jack@suse.cz>
Date:   Thu Oct 6 14:41:23 2022 +0000

    udf: Convert udf_rename() to new directory iteration code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1191f00f480000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=8a5a459f324d510ea15a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100a46c2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116a4e72880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: udf: Convert udf_rename() to new directory iteration code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
