Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D931CCD4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgEJTny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729139AbgEJTny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 15:43:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DDC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2020 12:43:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so7183188ljl.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2020 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=MvdUhg89yXtJF0t/lWJcuLrr+bpGqVPlxoPK/Zhq2QqXYyp7vcGmiSrZl+n0GURWqw
         V64Z4RvbsMsrTzRFhphZJ44YD55cIcu0w/FHaiF/arWpo9zjG6+ztNZG5zl1l+5WIhmf
         vjboKU8xNCyk7pZgwioS1lDPWOU6mzJy+CNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=LqfKd+2I1iOxW5PfdhXUKZsQQCvFRCsUXKyotAyjepXnq1xT3fbiR3q5E2Lt8O0/jn
         wBubGB8lGuQLJkGc9WkwcTI8aToNMB3wj4OcdczlJNISkiNCOukKgLuHu2I+QZbbrz90
         I8gX4L2jQWJPHnTPGwpw9anIh9Ewq90Gm6Hrq4fN1IFr3c+7RlVZe+B+f32LeIyrhFk+
         RHBWH7FoWsTxg5Gxpovx47UuTjih7BzrAiX6zkL+CyJPoJ8USrRJWK/MC3mukwzySjxJ
         HWMGBlwCXXrE/J0DDZmGJjwij7RVKn1FJTsXbQk01E9Z1Xd3/GiS8gd2RVOUXH0CnNHA
         xSVA==
X-Gm-Message-State: AOAM531SYMcgFqAvuM/BtOzQDH4zkHnV3sOaMh0AFsh+9W5c34fbrxct
        kxxoYAmjQaa+ZuMT/itL/xRe0K1WEow=
X-Google-Smtp-Source: ABdhPJwlvheuhqZuXQsmF9gW+ZDPJggQ1TleGBvgczXhIB0cFsfAergWhqRd+OYB00LOkIHN5HxphA==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr7718532ljj.56.1589139831448;
        Sun, 10 May 2020 12:43:51 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f10sm8101662lfl.82.2020.05.10.12.43.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 12:43:51 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so7210512ljd.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2020 12:43:51 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr7886930ljj.241.1589139516386;
 Sun, 10 May 2020 12:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
In-Reply-To: <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 12:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Wouldn't this change cause
>
>         if (fd_binary > 0)
>                 ksys_close(fd_binary);
>         bprm->interp_flags = 0;
>         bprm->interp_data = 0;
>
> not to be called when "Search for the interpreter" failed?

Good catch. We seem to have some subtle magic wrt the fd_binary file
descriptor, which depends on the recursive behavior.

I'm not seeing how to fix it cleanly with the "turn it into a loop".
Basically, that binfmt_misc use-case isn't really a tail-call.

Eric, ideas?

                 Linus
