Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2890202FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgFVGm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 02:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgFVGm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:42:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ECFC061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 23:42:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so3271039qtq.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UhciZLVdGKEJk7KHTw+RU8JWs5dQKAECyz5UjSzBrP0=;
        b=EyF5FuUsWQitHjx7BN4lfK2XcWY7vlK1Elm2C5+czbIrJnmhqFTAkpW5dNchOjMYQa
         m2TLVe5resLpBBx6d16MAKG8YbkEM7gSyEr0VRWn6GoH7+uEoEW090OfViix7wAoT/6E
         vP8jz4YaO+TAiSfGRcxcZLnf94KukhpdZugyRYd9Cr/xOsWN93pQOg4ZrSpwwQPypW3y
         Xc/FL4aARuZ3E6Aoh8B/DXUBsDQxJ6n0Ey9MzbMssaMalGxbbiW+y4MMWDiQ8/y80Mhj
         SOLke1Gc4AIHcB/xAxa07KjuW2Gin3VRjJaRkMucEqOZeq60mtVn2HfRwq97kVDrfsgb
         jZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UhciZLVdGKEJk7KHTw+RU8JWs5dQKAECyz5UjSzBrP0=;
        b=LO7wibA8ErGjYl3nC6UY//wEBvL3VDbx6oUHU/CVfVocd3lIYJ6+GnnX/s7roo7ZFg
         LDnjylMXB7nWjGjXt4mcW/sgLFJBTneYWHBm2WUqnq6cSIvmXxQjpaX3f+hIftoYvG4J
         hw6RaJinMMmddbhZlGuUOY05fNirw/AUoQ5yNmGK3dBE2S+/IKxit3v/Yse4TVqGYHpQ
         p+WefpJmbYYiyrW6dTtYgrtlsmIe8iYePp+I8SUXzYBCBOSjsvCUDSKCknnvuPeKM6+A
         fyShpWuPeq9uU1EsrI1RQo9RwWEp3FgnnjsdXJc7v2Jbw+cR/I6+RPvgf6lUtE1gI9UY
         mA5A==
X-Gm-Message-State: AOAM531+s8NU+K5DkS3mgIYJo3jt8qA+EE3QLwSPG/y5iAv849U/ngZI
        G7CmatTtCnOpxpX4RAK839A2l92Un4t/lRj+Ct7vCQ==
X-Google-Smtp-Source: ABdhPJxrXaR2MRdiPAJU6NZZSqPOj09boIx0YXa64M3CfHeEi2VvHVT8MYtt4nmImQOknEhCv3I16YGiBoKqk30+teY=
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr15006149qtc.257.1592808144668;
 Sun, 21 Jun 2020 23:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000617f9d05a8a5a2c4@google.com> <4A35E92B-9DEF-4833-81DD-0C6FA50EB174@lca.pw>
In-Reply-To: <4A35E92B-9DEF-4833-81DD-0C6FA50EB174@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 22 Jun 2020 08:42:13 +0200
Message-ID: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
To:     Qian Cai <cai@lca.pw>
Cc:     syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 8:29 AM Qian Cai <cai@lca.pw> wrote:
> > On Jun 22, 2020, at 1:37 AM, syzbot <syzbot+95bccd805a4aa06a4b0d@syzkal=
ler.appspotmail.com> wrote:
> >
> > WARNING: CPU: 0 PID: 0 at mm/slab.h:232 kmem_cache_free+0x0/0x200 mm/sl=
ab.c:2262
>
> Is there any particular reason to use CONFIG_SLAB rather than CONFIG_SLUB=
?

There is a reason, it's still important for us.
But also it's not our strategy to deal with bugs by not testing
configurations and closing eyes on bugs, right? If it's an official
config in the kernel, it needs to be tested. If SLAB is in the state
that we don't care about any bugs in it, then we need to drop it. It
will automatically remove it from all testing systems out there. Or at
least make it "depends on BROKEN" to slowly phase it out during
several releases.


> You are really asking for trouble to test something that almost nobody is=
 exercising that code path very well nowadays.
>
> Anyway, there is a patchset in -mm that might well introduce this regress=
ion that we could go to confirm it, but I kind of don=E2=80=99t want to spe=
nd too much time on SLAB that suppose to be obsolete eventually.
