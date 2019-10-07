Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08D4CDAD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 06:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfJGEEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 00:04:31 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43530 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJGEEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 00:04:31 -0400
Received: by mail-yw1-f65.google.com with SMTP id q7so4616367ywe.10;
        Sun, 06 Oct 2019 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlxhoNvqY8uYv1eDJ8P+t3V60zJV8aas70uwWrFV0O0=;
        b=qpqTr6xeA6AEdANGqytS88FZ1HHsbjknW2mo1o3ifRLBWW297E3uLI3AYSucZB1m7H
         9wpCbAuzjEkkxe4z8RBAYE14C7XjynRA5YXlNHoDc7QEM2SN59IEigeNlLmTcK64wdwB
         mwqzxmW/HDlkTAE0uHqLG2SiZZmN8XxcuR6N8tjSaaFHCCcMfLA9biJW379cVou2r1TX
         kk3m13LrI7nwoDyUQRInW4XdIlRoCKXnY5iuhl7MDGaxjo3rPNsHDlKZOz5SUZidP9A2
         LGtfvKiGiYVduMh9Flkpl3RZB6MZGa4XgC59P00jZXZupbZZAry8NHJqzqiypg/Oq112
         lKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlxhoNvqY8uYv1eDJ8P+t3V60zJV8aas70uwWrFV0O0=;
        b=lARsxr5abYd0yLfLifRQhHMnWPKL9OZUb/T3IE6c8kEw0P2W2IfBY2WvijzU4iZkL1
         dJUFslh0wLq1RkP6MMPPQtQ+SZUnjL+1lRev+XlC6cahY5MB6D8peuvmHrrb5YGM5t3p
         9fETtWiWqFugxa0Is2kv0cBZyG7ArGP2W+fBFz3rTUOk481OrtHIX1xO29IIDRYPYa40
         xA9byMNS1JvLw3JeKvUVPDWKLcj+r8AgynLjbVRUDiUTeq+sG/xEDwFr7XdWPSDCKmGT
         mqqUWfnYPdJuKENkACIFdYm+ZVA3xJTEucuFlSBklvXYmRxv01SJ6CikigUwNhned9tE
         NSXQ==
X-Gm-Message-State: APjAAAU/vGsaYRCNARyRPNpa+rtWBgEd955p/1q+Lv7hKnADpocjd6kl
        J1C4H1wcDGTLrctq0yUnLaRX5IYEqg/mYHsQx64=
X-Google-Smtp-Source: APXvYqy58B7w5bFS51G68+llxeNVQgr+FppBu3pwnAjLlaYiMIzX5+xcTCXfdfy+dKNO+AMZklG5TXi/+tPDD/bKFvc=
X-Received: by 2002:a0d:dfcc:: with SMTP id i195mr18080993ywe.107.1570421070275;
 Sun, 06 Oct 2019 21:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net>
In-Reply-To: <20191006222046.GA18027@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 6 Oct 2019 21:04:19 -0700
Message-ID: <CAMo8BfJHcLQ_TuacCwdhQYB-nhpdBrCq5EuB=E7SafP15=kd3A@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 6, 2019 at 3:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> this patch causes all my sparc64 emulations to stall during boot. It causes
> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> disk, and one of the xtensa emulations to crash with [2].

[...]

> [2]
>
> Unable to handle kernel paging request at virtual address 0000000000000004
> reboot(50): Oops -1
> pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Tainted: G      D
> pc is at 0x4
> ra is at filldir64+0x64/0x320
> v0 = 0000000000000000  t0 = 0000000067736d6b  t1 = 000000012011445b
> t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000007ef8
> t5 = 0000000120114448  t6 = 0000000000000000  t7 = fffffc0007eec000
> s0 = fffffc000792b5c3  s1 = 0000000000000004  s2 = 0000000000000018
> s3 = fffffc0007eefec8  s4 = 0000000000000008  s5 = 00000000f00000a3
> s6 = 000000000000000b
> a0 = fffffc000792b5c3  a1 = 2f2f2f2f2f2f2f2f  a2 = 0000000000000004
> a3 = 000000000000000b  a4 = 00000000f00000a3  a5 = 0000000000000008
> t8 = 0000000000000018  t9 = 0000000000000000  t10= 0000000022e1d02a
> t11= 000000011fd6f3b8  pv = fffffc0000b9a810  at = 0000000022e1ccf8
> gp = fffffc0000f03930  sp = (____ptrval____)
> Trace:
> [<fffffc00004ccba0>] proc_readdir_de+0x170/0x300
> [<fffffc0000451280>] filldir64+0x0/0x320
> [<fffffc00004c565c>] proc_root_readdir+0x3c/0x80
> [<fffffc0000450c68>] iterate_dir+0x198/0x240
> [<fffffc00004518b8>] ksys_getdents64+0xa8/0x160
> [<fffffc0000451990>] sys_getdents64+0x20/0x40
> [<fffffc0000451280>] filldir64+0x0/0x320
> [<fffffc0000311634>] entSys+0xa4/0xc0

This doesn't look like a dump from xtensa core.
v5.4-rc2 kernel doesn't crash for me on xtensa, but the userspace
doesn't work well, because all directories appear to be empty.

__put_user/__get_user don't do unaligned access on xtensa,
they check address alignment and return -EFAULT if it's bad.

-- 
Thanks.
-- Max
