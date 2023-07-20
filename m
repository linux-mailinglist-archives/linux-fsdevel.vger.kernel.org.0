Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6775BACA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGTWyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTWyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:54:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F631999
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 15:54:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99357737980so213337166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689893645; x=1690498445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=icC7qqcxEnMW3yXk8+JIZ8lmrrJx4xPvVXeXAz/l3rg=;
        b=VWbwxYUaWG0QQr7r2VRF96W1fa7vHG/WmDIzg/IRrV8ryRk8OdKS5x0ikq9FfBsS4l
         mGK7fQFfM0aYDxEijzZU6Ef1XqqOKdRwGyVZSl6luC7y0/T/SXN13pi2z2pSVQ3/lqWW
         8XsqZo8giN5R3gbUPGKV8Bv66wS/n7D0x89cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689893645; x=1690498445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icC7qqcxEnMW3yXk8+JIZ8lmrrJx4xPvVXeXAz/l3rg=;
        b=DhIuIEierc0VyD+DolF1EnqVuniSDhdBYdIiSrQbpbW15Aap4cheOu/oOKRQtQwMbe
         9ra02wh/sP0/mUPXsYAAvlDV2jcHNuuAsuZvYnLORnEQcZV603MHVAu8MWqrkuMwbFbq
         Cnk2Fgk8yx/9CbSOT4MjRyRVugO0sxPikcPrE9ZffysR519NnF4gjhmu1k+T35Ptdig2
         zEfQ/iGKkDZXCnoxibGnC1HSD7RdQ5h5SNdTiVCXKYivQebMCMjHUweG24fGaBUSceQd
         /S8cXfsWg5VlPSgJa25EC86eyuzXmO2DIWF5kB2eR4X7qIc/koduLl6clpV3JJiv+okf
         qQ4A==
X-Gm-Message-State: ABy/qLbiWJ8X4In6H6MiRY8h5AHQSbGH0PNiWMI04unSs1/bsP0u/lkf
        JMcuqL60Vc71z6JFSFqiLvlBhUtuuwkduzQqnTDyp9I9
X-Google-Smtp-Source: APBJJlH4UtIFJXaH8U/fTs3ltMXeSYLug3o3WvRZlFiizBdfxiuX2SalmMKfKvqQBKIf6XxQATSL6w==
X-Received: by 2002:a17:906:519d:b0:98d:5333:79c with SMTP id y29-20020a170906519d00b0098d5333079cmr127847ejk.5.1689893645018;
        Thu, 20 Jul 2023 15:54:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id jj28-20020a170907985c00b0098d93142ce1sm1297386ejc.109.2023.07.20.15.54.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 15:54:03 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-992af8b3b1bso215524266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 15:54:03 -0700 (PDT)
X-Received: by 2002:a17:906:778f:b0:978:acec:36b1 with SMTP id
 s15-20020a170906778f00b00978acec36b1mr193104ejm.17.1689893643313; Thu, 20 Jul
 2023 15:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com> <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org> <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org> <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org> <CAH8yC8=BwacXyFQret5pKVCzXXO0jLM_u9eW3bTdyPi4y8CSfw@mail.gmail.com>
 <ZLm3LLrsSPYkLYr4@casper.infradead.org>
In-Reply-To: <ZLm3LLrsSPYkLYr4@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jul 2023 15:53:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com>
Message-ID: <CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Jul 2023 at 15:37, Matthew Wilcox <willy@infradead.org> wrote:
>
> I think you're missing the context.  There are bugs in how this filesystem
> handles intentionally-corrupted filesystems.  That's being reported as
> a critical bug because apparently some distributions automount HFS/HFS+
> filesystems presented to them on a USB key.  Nobody is being paid to fix
> these bugs.  Nobody is volunteering to fix these bugs out of the kindness
> of their heart.  What choice do we have but to remove the filesystem,
> regardless of how many happy users it has?

You're being silly.

We have tons of sane options. The obvious one is "just don't mount
untrusted media".

Now, the kernel doesn't know which media is trusted or not, since the
kernel doesn't actually see things like /etc/mtab and friends. So we
in the kernel can't do that, but distros should have a very easy time
just fixing their crazy models.

Saying that the kernel should remove a completely fine filesystem just
because some crazy use-cases that nobody cares about are broken, now
*that* just crazy.

Now, would it be good to have a maintainer for hgs? Obviously. But no,
we don't remove filesystems just because they don't have maintainers.

And no, we have not suddenly started saying "users don't matter".

          Linus
