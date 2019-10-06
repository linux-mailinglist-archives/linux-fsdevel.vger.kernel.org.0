Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2863ACD972
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfJFWUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 18:20:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36169 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJFWUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:20:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so7406293pfr.3;
        Sun, 06 Oct 2019 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jcRRPxaW1qQLSX9slpTLl4HUR4af87iVZFvEhxXf1Vo=;
        b=W7OWzX/mR4CG1Xf/SkUUhb2WPp2GbWrd667rXAwND0HSvtafV/o6/vWD2XiMnE6h1e
         anCsWo30ASov5nLol/awtncrwcgdOrJgcZlKryEpHXpndSCXTC2/nmuxTStmuwPObLBq
         3RI1kSLiM5udSLIwzwxSn1Wq+7eziUMNPAHUgmHMGNPYRGNPenxfMOI3Q71gAEug2n4b
         Jn/YattDcFHUBKSsYIc6pRT6w9XdVy1XGVjqDW0wsPzcshKs18uyTHK0fyavVbCCB7ps
         gxTSzfO7QkK+NmEho+IAIIJwk3LRINifD/PXosXmn7WzgwEvsJRZJK68LOxlObqtQnF5
         COHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=jcRRPxaW1qQLSX9slpTLl4HUR4af87iVZFvEhxXf1Vo=;
        b=BeEM2o36Sw6PjP+ELbPiqY+ls3LI2laZEjqZPVajXgLD4Cy+gwPVekb1PHVH4fcH88
         lUKtU0FuJekFGIcyodd9rtjKvrYcybo+sEyYyljlCdAJISvJ7THfDD1zFuHYfeVFL7bS
         R9NMLytIZFRcbP0t4OQeuj+0Qwpz28kTKIEkLRZgXaNj9gQQ948rAD4qwgWpzhEEHRnd
         ZwjmlSdds7/I2urIRSJBqcswiWhhdAs49u7ETxIe2OAFRabP1lSsO3CD+CNXugaP1gue
         tett3Uv1O70TpYaJTZFtCOkeLLgdBwCtAK2112ruEKCvIitb1wa8mitqHL85phz8P9Dh
         YmZQ==
X-Gm-Message-State: APjAAAXnGHMsEZ74Z8CZnvQJVxvN1xLEc6/k+itUiLLf04dRq1ks/v3I
        7BrG7OpTI3fBeHv+ifExuCI=
X-Google-Smtp-Source: APXvYqyDkQZsa8wKaO5oRGIWg8PFdgwvz7fgKuf3wGn33bwDEmwwdSeXoYnZshN0IqxGuW1dFDbV1Q==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr30134328pjk.107.1570400449271;
        Sun, 06 Oct 2019 15:20:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12sm16150172pff.66.2019.10.06.15.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 15:20:48 -0700 (PDT)
Date:   Sun, 6 Oct 2019 15:20:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191006222046.GA18027@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2016 at 09:59:07PM -0700, Linus Torvalds wrote:
> We really should avoid the "__{get,put}_user()" functions entirely,
> because they can easily be mis-used and the original intent of being
> used for simple direct user accesses no longer holds in a post-SMAP/PAN
> world.
> 
> Manually optimizing away the user access range check makes no sense any
> more, when the range check is generally much cheaper than the "enable
> user accesses" code that the __{get,put}_user() functions still need.
> 
> So instead of __put_user(), use the unsafe_put_user() interface with
> user_access_{begin,end}() that really does generate better code these
> days, and which is generally a nicer interface.  Under some loads, the
> multiple user writes that filldir() does are actually quite noticeable.
> 
> This also makes the dirent name copy use unsafe_put_user() with a couple
> of macros.  We do not want to make function calls with SMAP/PAN
> disabled, and the code this generates is quite good when the
> architecture uses "asm goto" for unsafe_put_user() like x86 does.
> 
> Note that this doesn't bother with the legacy cases.  Nobody should use
> them anyway, so performance doesn't really matter there.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Linus,

this patch causes all my sparc64 emulations to stall during boot. It causes
all alpha emulations to crash with [1a] and [1b] when booting from a virtual
disk, and one of the xtensa emulations to crash with [2].

Reverting this patch fixes the problem.

Guenter

---
[1a]

Unable to handle kernel paging request at virtual address 0000000000000004
rcS(47): Oops -1
pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Not tainted
pc is at 0x4
ra is at filldir64+0x64/0x320
v0 = 0000000000000000  t0 = 0000000000000000  t1 = 0000000120117e8b
t2 = 646e617275303253  t3 = 646e617275300000  t4 = 0000000000007fe8
t5 = 0000000120117e78  t6 = 0000000000000000  t7 = fffffc0007ec8000
s0 = fffffc0007dbca56  s1 = 000000000000000a  s2 = 0000000000000020
s3 = fffffc0007ecbec8  s4 = 0000000000000008  s5 = 0000000000000021
s6 = 1cd2631fe897bf5a
a0 = fffffc0007dbca56  a1 = 2f2f2f2f2f2f2f2f  a2 = 000000000000000a
a3 = 1cd2631fe897bf5a  a4 = 0000000000000021  a5 = 0000000000000008
t8 = 0000000000000020  t9 = 0000000000000000  t10= fffffc0007dbca60
t11= 0000000000000001  pv = fffffc0000b9a810  at = 0000000000000001
gp = fffffc0000f03930  sp = (____ptrval____)
Disabling lock debugging due to kernel taint
Trace:
[<fffffc00004e7a08>] call_filldir+0xe8/0x1b0
[<fffffc00004e8684>] ext4_readdir+0x924/0xa70
[<fffffc0000ba3088>] _raw_spin_unlock+0x18/0x30
[<fffffc00003f751c>] __handle_mm_fault+0x9fc/0xc30
[<fffffc0000450c68>] iterate_dir+0x198/0x240
[<fffffc0000450b2c>] iterate_dir+0x5c/0x240
[<fffffc00004518b8>] ksys_getdents64+0xa8/0x160
[<fffffc0000451990>] sys_getdents64+0x20/0x40
[<fffffc0000451280>] filldir64+0x0/0x320
[<fffffc0000311634>] entSys+0xa4/0xc0

---
[1b]

Unable to handle kernel paging request at virtual address 0000000000000004
reboot(50): Oops -1
pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Tainted: G      D
pc is at 0x4
ra is at filldir64+0x64/0x320
v0 = 0000000000000000  t0 = 0000000067736d6b  t1 = 000000012011445b
t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000007ef8
t5 = 0000000120114448  t6 = 0000000000000000  t7 = fffffc0007eec000
s0 = fffffc000792b5c3  s1 = 0000000000000004  s2 = 0000000000000018
s3 = fffffc0007eefec8  s4 = 0000000000000008  s5 = 00000000f00000a3
s6 = 000000000000000b
a0 = fffffc000792b5c3  a1 = 2f2f2f2f2f2f2f2f  a2 = 0000000000000004
a3 = 000000000000000b  a4 = 00000000f00000a3  a5 = 0000000000000008
t8 = 0000000000000018  t9 = 0000000000000000  t10= 0000000022e1d02a
t11= 000000011f8fd3b8  pv = fffffc0000b9a810  at = 0000000022e1ccf8
gp = fffffc0000f03930  sp = (____ptrval____)
Trace:
[<fffffc00004ccba0>] proc_readdir_de+0x170/0x300
[<fffffc0000451280>] filldir64+0x0/0x320
[<fffffc00004c565c>] proc_root_readdir+0x3c/0x80
[<fffffc0000450c68>] iterate_dir+0x198/0x240
[<fffffc00004518b8>] ksys_getdents64+0xa8/0x160
[<fffffc0000451990>] sys_getdents64+0x20/0x40
[<fffffc0000451280>] filldir64+0x0/0x320
[<fffffc0000311634>] entSys+0xa4/0xc0

---
[2]

Unable to handle kernel paging request at virtual address 0000000000000004
reboot(50): Oops -1
pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Tainted: G      D
pc is at 0x4
ra is at filldir64+0x64/0x320
v0 = 0000000000000000  t0 = 0000000067736d6b  t1 = 000000012011445b
t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000007ef8
t5 = 0000000120114448  t6 = 0000000000000000  t7 = fffffc0007eec000
s0 = fffffc000792b5c3  s1 = 0000000000000004  s2 = 0000000000000018
s3 = fffffc0007eefec8  s4 = 0000000000000008  s5 = 00000000f00000a3
s6 = 000000000000000b
a0 = fffffc000792b5c3  a1 = 2f2f2f2f2f2f2f2f  a2 = 0000000000000004
a3 = 000000000000000b  a4 = 00000000f00000a3  a5 = 0000000000000008
t8 = 0000000000000018  t9 = 0000000000000000  t10= 0000000022e1d02a
t11= 000000011fd6f3b8  pv = fffffc0000b9a810  at = 0000000022e1ccf8
gp = fffffc0000f03930  sp = (____ptrval____)
Trace:
[<fffffc00004ccba0>] proc_readdir_de+0x170/0x300
[<fffffc0000451280>] filldir64+0x0/0x320
[<fffffc00004c565c>] proc_root_readdir+0x3c/0x80
[<fffffc0000450c68>] iterate_dir+0x198/0x240
[<fffffc00004518b8>] ksys_getdents64+0xa8/0x160
[<fffffc0000451990>] sys_getdents64+0x20/0x40
[<fffffc0000451280>] filldir64+0x0/0x320
[<fffffc0000311634>] entSys+0xa4/0xc0

Code:
 00000000
 00063301
 000007a3
 00001111
 00003f64

Segmentation fault

