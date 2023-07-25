Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08432760B4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGYHQh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 03:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGYHQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:16:35 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF312D;
        Tue, 25 Jul 2023 00:16:32 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-583f036d50bso23921037b3.3;
        Tue, 25 Jul 2023 00:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269391; x=1690874191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJjDsseCku7rw4c3XWBJPjjfZ2OLqB4Q28CEWAPlCas=;
        b=hVQgl7DJn5GMlVxdjbl2+VQHv/xf18JajW1kmjJZJSajwKgmpvI4WnQFNuFrN6Kut4
         GT5Et9fFsFo12XxQqaujQ4J+n8o3+fD9UH64LXzwqYAjKJXXULdTqQ8B4kOMVZo3YVDI
         q5IT8zU1iLniV5tVgsao0GvWUOM58b+tcfTurz/v4/l+EJ6TZ7puiGmuvJ3eK3Kw8XLX
         yTtuhIpuWw6/E45ha48s1YccW9z0uuxUs95lQMKV98Y3OHCMiLVP32qsMngUQj5lmyl3
         nTThflP9pjqEwbHY3bKdonTWOW9i+KkfCdWzb3hRhj2Vnkzrj59bDYrBWumdJ4HmycNt
         zu2g==
X-Gm-Message-State: ABy/qLao/3eJ40JY7/2WDUcsy767G4pg3s4vipoIUxV0DGufrxZSA9sh
        sZuL08BUJbvdndkxbBFyyya1Ez6mYXzdcYuw
X-Google-Smtp-Source: APBJJlGGkYf3TOwXUHFzKgPD8ivkikovqfooPElc9ajMbqNe2UaqmvOSsqb2a9wDw8jy7t1AOf/MZg==
X-Received: by 2002:a0d:d646:0:b0:577:1909:ee16 with SMTP id y67-20020a0dd646000000b005771909ee16mr12409284ywd.30.1690269391390;
        Tue, 25 Jul 2023 00:16:31 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k67-20020a0dfa46000000b005619cfb1b88sm3383079ywf.52.2023.07.25.00.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:16:29 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so5822765276.3;
        Tue, 25 Jul 2023 00:16:29 -0700 (PDT)
X-Received: by 2002:a25:10c5:0:b0:c91:717e:7658 with SMTP id
 188-20020a2510c5000000b00c91717e7658mr10654915ybq.2.1690269388936; Tue, 25
 Jul 2023 00:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689074739.git.legion@kernel.org> <cover.1689092120.git.legion@kernel.org>
 <a677d521f048e4ca439e7080a5328f21eb8e960e.1689092120.git.legion@kernel.org>
In-Reply-To: <a677d521f048e4ca439e7080a5328f21eb8e960e.1689092120.git.legion@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:16:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzYxo83AXfWWVyp2fL3fcEUNgbG5aSZuA62FwO2i3jDg@mail.gmail.com>
Message-ID: <CAMuHMdXzYxo83AXfWWVyp2fL3fcEUNgbG5aSZuA62FwO2i3jDg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arch: Register fchmodat2, usually as syscall 452
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        glebfm@altlinux.org, gor@linux.ibm.com, hare@suse.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 6:25 PM Alexey Gladkov <legion@kernel.org> wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> This registers the new fchmodat2 syscall in most places as nuber 452,
> with alpha being the exception where it's 562.  I found all these sites
> by grepping for fspick, which I assume has found me everything.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
