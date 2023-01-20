Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA6675F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 21:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjATUn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 15:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATUn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:43:28 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32E966FD
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 12:43:27 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id g11-20020a056e021a2b00b0030da3e7916fso4518484ile.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 12:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsJ1Nljpon9SLJurOmoC1BIAWmEt4UdFJ9FMAmnjneo=;
        b=oYzykbN0d5bggglItxNns8nfL37BpoWEyy4eStUKt+VpvvDMPAb5uddUcs3dkN3Z7B
         2InAg03QGM1bNoZF7kSE/LEPi5y07rmT9L9pjrJwK22MzOMcaWSsdacjmD7TxiEr0DhP
         G4Z0Vp0ZUIghorkZD+7LhJSiL7CBN+IEAz7ubtiTJdRD7m2OSO8YeKCNYHHvl1fXPwe6
         WlLe1ePgMFbl+gOj9v9788g+/YwoAhLSodYjyBus0cqgMXjr8muskpypPn8MVM0A8hUY
         KFVNH0GzN/9pvRSdHR/SFlKvJ4lAChkzLKlJgDJC/bTjOcGAVDvchBfI2kQEzaxme1ct
         I5BA==
X-Gm-Message-State: AFqh2kq362Iao5aCuGpJ2NDOUkWSwTS3GC5CfUK5qzRWM7Uvi9sOyYdf
        wmxjAK8UZxAjUzErTuCYpAnQxeniZWWLSFXUcTh6R2k7MUVQ
X-Google-Smtp-Source: AMrXdXugkmh4J5oclZpzPC4l3wq8MtWaI/4oNpFKdaoU/Q/TQ1+7KkWo6QQNdvY0vIjcfwY2XI3t/sIuf/zDdHaUGdeTDCuRUek7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:515:b0:3a4:a464:27f1 with SMTP id
 i21-20020a056638051500b003a4a46427f1mr1390769jar.253.1674247406806; Fri, 20
 Jan 2023 12:43:26 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:43:26 -0800
In-Reply-To: <000000000000fd3bbe05efb0d1fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2f0bc05f2b819c6@google.com>
Subject: Re: [syzbot] [vfs?] [ntfs3?] [tmpfs?] WARNING in walk_component
From:   syzbot <syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156b1c56480000
start commit:   1f5abbd77e2c Merge tag 'thermal-6.2-rc3' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176b1c56480000
console output: https://syzkaller.appspot.com/x/log.txt?x=136b1c56480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=eba014ac93ef29f83dc8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f5d83a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1727f4b4480000

Reported-by: syzbot+eba014ac93ef29f83dc8@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
