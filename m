Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378712D4ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgLIXaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbgLIXaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:30:12 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B8C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 15:29:32 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id m12so5526064lfo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK1dNqT3jQGAmChAlinVWTgrR1JdnxmqJloiOP6lwEU=;
        b=A8HsndfHAvTYs2HvwgUgXhOqFZxJ9ELeVJwC5xp21VpL9arouT4PjAEwMM5v5BDs13
         dUKoMdDWwu1LmotRCyc9uS/ins946pYI/cSQ1EmHGVerAqe1aqU+v/sBGBjsfJzgosja
         xYNEBw+or30zs0YyXLTkNY+hgxij7vKLn6L2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK1dNqT3jQGAmChAlinVWTgrR1JdnxmqJloiOP6lwEU=;
        b=XSboz74MVVu1EY1XTqoyvo254Tk15wwt4Djn4QESRFBFDefY36O1wWqx0DQtdGXXjI
         PEO521MZeolH+m+QhAGh+ClxxioLV5owwLw/15o55Uc0MzgTmpp+c6jTqVWsIMG+CVyB
         gLSa5XTbRLje22BbWr8ZbvRv/PkcFkcwTPdIyBE/wgWIOwhws1KQYN9AgwPB6CiTTcOb
         S10CXGZPSh1rwYY0e4QGepQzKIDG7DCSTS+excuu/WEX/MKZtbMXnNydEz/JHK4lBfK7
         /3c44X2yk/gVZc7irqq7X5++3Yjl8OCoa+GeyHapucmJoFn0PfURKHs5cu0DsVbA0bLg
         iW+w==
X-Gm-Message-State: AOAM532EKHNwb7+3wYoQCoDuly7rfRoqPickKiQZv5ZzsNr1iNSuYOmr
        uWiyZ4ZoKY0D9SyHa9SvFFL9sWQkC7LYMA==
X-Google-Smtp-Source: ABdhPJx8BKN/dWQ6XwZgJMlVKLG3c2q05/VWP/3WJhFVn50KnIBWIhMYzzC5g0X6NKueuJs/gARp7A==
X-Received: by 2002:ac2:514e:: with SMTP id q14mr1784819lfd.130.1607556568975;
        Wed, 09 Dec 2020 15:29:28 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l7sm396861lja.15.2020.12.09.15.29.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 15:29:28 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id y22so4503459ljn.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:29:27 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr2081690ljj.220.1607556567421;
 Wed, 09 Dec 2020 15:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk> <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk> <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk> <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org> <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com> <20201209230755.GV7338@casper.infradead.org>
In-Reply-To: <20201209230755.GV7338@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 15:29:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
Message-ID: <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>  #. It is not necessary to use rcu_assign_pointer() when creating
>     linked structures that are to be published via a single external
> -   pointer. The RCU_INIT_POINTER() macro is provided for this task
> -   and also for assigning ``NULL`` pointers at runtime.
> +   pointer. The RCU_INIT_POINTER() macro is provided for this task.
> +   It used to be more efficient to use RCU_INIT_POINTER() to store a
> +   ``NULL`` pointer, but rcu_assign_pointer() now optimises for a constant
> +   ``NULL`` pointer itself.

I would just remove the historical note about "It used to be more
efficient ..". It's not really helpful.

If somebody wants to dig into the history, it's there in git.

Maybe the note could be part of the commit message for the comment
update, explaining that it used to be more efficient but no longer is.
Because commit messages are about the explanation for the change.

But I don't feel it makes any sense in the source code.

             Linus
