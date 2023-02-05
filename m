Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B368068B164
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBETqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 14:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBETqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:46:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3941A4BC
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Feb 2023 11:46:18 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so6753285ilu.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Feb 2023 11:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyVpInRmcNvlIB5ckskfYghTIH0/4E9ydL9t6KxI9Oo=;
        b=kg+MuPTsFR/tZf1zLem9mGdGgqKYhno0m+fZyRXnaxnLUsLBwUs3suMymot+6N6JHG
         4zbjkQ0Xzvwz8rXotnE6nWwIz/H5u0k675HaKkt4AKpA0tLBpQx5tn4Mxso9Gv7iX+zK
         LI5o5fcu715nKY3YYmQLZqAVfid7AkITWCPco6lmZp/YgYbxLL54KBePHQl2Bx6ZBcW7
         k3Wc6HJUyMXi4YO+aoFtBZAEcQt16SDC9eDS0xOn98HnVbHD/J2QUVFvW5H8guGbzNTp
         QgAV4NF/+2/Ezp5w2oq4AOrMuAzw4twcz5twp+AuIzgNfWbFNQo/c3n7I5S5BlcOV+UK
         oA3g==
X-Gm-Message-State: AO0yUKV+ONE+QOG/i8S/b7J7wKDxr+dmsZnBi4Mf506Ov9Vir1f1aYOY
        gYeFqEk5D7+PXmUiBqH0mX29PCiXpVRnLUAHfIV4SmACLXUl
X-Google-Smtp-Source: AK7set+m/GB/TobA2eHc5fdm4Edu22FyaWsREpkFyjGb4IASdMtFte+baW25gpzfLu10/N6BmHOAVZ19d2JWqbP+FAzuqt7cMSK6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:597:b0:39d:234a:8f18 with SMTP id
 a23-20020a056638059700b0039d234a8f18mr4461620jar.123.1675626377990; Sun, 05
 Feb 2023 11:46:17 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:46:17 -0800
In-Reply-To: <0000000000009a318805e6ff48a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009570005f3f92b86@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in ni_find_attr
From:   syzbot <syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

commit 2681631c29739509eec59cc0b34e977bb04c6cf1
Author: Edward Lo <edward.lo@ambergroup.io>
Date:   Sat Aug 6 17:05:18 2022 +0000

    fs/ntfs3: Add null pointer check to attr_load_runs_vcn

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110ad78d480000
start commit:   b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=69d15cab6309bffae739
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b3fb9b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101313bb880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add null pointer check to attr_load_runs_vcn

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
