Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34E01F1FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgFHTSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHTSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:18:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EDC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 12:18:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so10900887lff.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+aTf2gj2lOJ6qgTzBTSu7Nj1KO1oLISUQJXCwIgKPw=;
        b=XycGSfymrTt81KEthuu69tnYBVTU4/J3hiH1z1OY7eG4VVaSI6wY1sNsf3vhH1zEOS
         dZXPuBt2VedjgwEjaYyqKGA7dFvG4VByaiDcz9wEBUo5Wdk675sUio3QpzXNo5zQfjkB
         Fdj//4grkPz8ALLWOhe7NYdYjv8ulkjsZ2EH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+aTf2gj2lOJ6qgTzBTSu7Nj1KO1oLISUQJXCwIgKPw=;
        b=bOcfcHvw7oMdrupK18ML2mgvEvwaIdNp4kLNsyu3LLuE/dhNK/OB1qEzMjZQj3Q3H2
         oBSn3YgHpP066XOKulW9Q4GEEBWgcnrFZknOXnr/Hs/J9NqPW+WUvBjRvVPYiEMbXFrJ
         mj4335CrAaDjvaWNwBR0/yMbSK0WgTufmmZ1os07Ph+ovPTHeikyKWTd5P4y1aWNleuA
         l6+Xt9GePeMQeFy6UqiUKjbwjNJZLfcdEdU7IzYoClfI1ZIMMgUDpVlZ6iERz5pa3irB
         US2p2H0gkngo8MhHJ66BAdN/Gcctjh2h+Jped+//ckI0DjQrKhTiv4B2Bj5UCXSgOCSG
         VltQ==
X-Gm-Message-State: AOAM53316qiA9IqC+KiQQphBd8KpN0KzlECj47+f9rE9LnuNxh7VsutO
        oAfc7ktUdF+RKq/dsxBfLUFMQyPKlUc=
X-Google-Smtp-Source: ABdhPJxUJwk5FIqW+Kvj5M8Wo1370ip6+pG3zQ3gIHERowuwTOJPgQKDBI4NLd1ePvgwHVE8yBo6Bg==
X-Received: by 2002:a19:b8d:: with SMTP id 135mr13377278lfl.145.1591643915526;
        Mon, 08 Jun 2020 12:18:35 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m11sm5134012lfj.9.2020.06.08.12.18.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a9so18395712ljn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr11451625ljj.102.1591643914040;
 Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
 <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk> <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
 <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com> <20200608020522.GN23230@ZenIV.linux.org.uk>
In-Reply-To: <20200608020522.GN23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:18:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBT80kcCTh8fpuYBr6D7O_THew4-KTr2jeMhYfoCd9hg@mail.gmail.com>
Message-ID: <CAHk-=wjBT80kcCTh8fpuYBr6D7O_THew4-KTr2jeMhYfoCd9hg@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 7, 2020 at 7:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         return mask & deny ? -EACCES : 0;

I agree that 'deny' would be simpler to read here, but in other places
it would look odd. ie the IS_POSIXACL() thing that checks for "are
group bits set" still wants the mode.

And I'd hate to have us use code that then mixes 'deny' and 'mode'
when they are directly related to each other.

Anyway, I merged the patch as-is, I guess we can make future changes
to this if you feel strongly about it.

              Linus
