Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509D708CE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 02:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjESA1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 20:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjESA1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 20:27:50 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B510DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 17:27:34 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c6469c2b5so213416039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 17:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456054; x=1687048054;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wS4yRst5lIZOEFwOGopGmG/PFz9tJWrMaN/Ir/080P8=;
        b=ZQ9Z7yE6vZpuCD8NGfgGwrXKMvNaKO4Xjy17k1TZBe5/EIIeorJI0XJ5ZVUnApmzUa
         Eb/azoIBjW37hbapv7Uqlfy/dP/SBUM8HlA6HbPsbq+yhjStN+pbG+UR6h1UbOQF3B6E
         wGRCwR3zkpKb3tESAqbQf/JjWOrfuiOwJ26/PSAMcmD9dUCxuF8AyF+oo/Q/ZUOl7nD0
         e44WZGNtSgQXUQopfs8KLi6ONOWb0LtmvvPjzTE1C4MnhP9Ah+VCb+W9gQUMPNen6qIo
         1tsr/0oxAt6Zb9SWzN7Wa709oHliOC3cDVyEMAAO3qQR6JQ2Ggd4euQKIG2kAfyUNLOM
         2apw==
X-Gm-Message-State: AC+VfDyFIkeBMnLX566rJ3mGe/2PaNhtiNpK3lcFRktSkcRki0omV+nK
        qy4Wn+GsiV17zX1dRW4ZO/PnJGoosoH/dN8D54nakMLhnXQV
X-Google-Smtp-Source: ACHHUZ4uvwIW/3D56BvXGaHQPr33ch9NlqQpk3LuznfAGWdZ3iL/anO0zW2bQ/xBVbTceVtGs4NO9Yf0CRaEkLPozBhj17OS6ICr
MIME-Version: 1.0
X-Received: by 2002:a5e:9409:0:b0:761:22af:1e36 with SMTP id
 q9-20020a5e9409000000b0076122af1e36mr64161ioj.1.1684456054078; Thu, 18 May
 2023 17:27:34 -0700 (PDT)
Date:   Thu, 18 May 2023 17:27:34 -0700
In-Reply-To: <000000000000dd4a6405f5336cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be442905fc00fc78@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Write in ktime_get_coarse_real_ts64
From:   syzbot <syzbot+91eeffac5287c260f2d0@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, ivan.orlov0322@gmail.com,
        jstultz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

syzbot suspects this issue was fixed by commit:

commit 267a36ba30a7425ad59d20e7e7e33bbdcc9cfb0a
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Jan 16 08:52:10 2023 +0000

    fs/ntfs3: Remove noacsrules

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13793a5a280000
start commit:   3ac88fa4605e Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bfeb3e8d4df76ca
dashboard link: https://syzkaller.appspot.com/bug?extid=91eeffac5287c260f2d0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a7a4ab480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151aeaf0c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Remove noacsrules

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
