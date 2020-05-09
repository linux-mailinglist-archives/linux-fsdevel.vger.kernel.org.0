Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC141CC480
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 22:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgEIURO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIURN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 16:17:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C602C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 13:17:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so4167794lfh.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=Z96Q63QMe9Gpsp6AeXzJLinw3niN6+LUAC3oCMCbateqa07K/sPjLmTGDwByhw59b9
         UXCxV70CR0zudA48gJhwUKM8r72YcyACiVcdEj6M/nBu7IVXDtigWGZYpPDlWvyhkTlw
         m40LV53bx4dKUuBDMcU/qCxfUEgtlul3KpXxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq3EROYQxDfNBT0wVZ0AqkaD6tlVAw2P3CKf/Rs8tQg=;
        b=sGJGSb5/varTilfHMABN71apYPUbWwvmf3M1KEt5/BwGQYWDljO8q8A/HmvlG3ROoU
         9MXdJhYr8XtC7GOMIrXYTiPDd48lrKRRKxGAsmZD2wKYbOiKqnH6OL7Kim7ABmdNY6mV
         TXc2dasAuUIHExYIFZ71o4+9KvJHZ28KvpU3gzZFIXpKf65CC7zteWMHpFxV8zWhGN7s
         l95QYQmblxK8Fd8PWpDIfwp38ksv4v3r/XQLu77nCavVsc55vdHvnboWzquvdOBl6l/0
         KBZD14hFOqZmoyGOTmFCYunyyfKeWmi7IBaWdA9RFDKwU3Jq4LK9i1UyAO4G5p9O0NCd
         0yxw==
X-Gm-Message-State: AOAM5316d32ND6Thb/9Nw2YSxHSrro7IDA0RIuPleu2mWDmER0lpb786
        6DLqVYeT4QoTtI7jnLycNMW3eiymqio=
X-Google-Smtp-Source: ABdhPJw2NYolrDdG1u9acF9BwTAIwQloEfWn9dJUyzqeQ4IuQakXnjs3O0pJ9MOXt/7CjeLOOhAKOQ==
X-Received: by 2002:a19:5502:: with SMTP id n2mr5784226lfe.168.1589055431033;
        Sat, 09 May 2020 13:17:11 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h22sm4701604ljb.65.2020.05.09.13.17.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:17:10 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id l19so5295250lje.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:17:09 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5604536lji.201.1589055429344;
 Sat, 09 May 2020 13:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:16:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Message-ID: <CAHk-=wg=0nAA9qGAogiFjpf0oCDcjkQE-u6umWCW-PkhrC8jrQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sat, May 9, 2020 at 12:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead of recursing in search_binary_handler have the methods that
> would recurse return a positive value, and simply loop in exec_binprm.
>
> This is a trivial change as all of the methods that would recurse do
> so as effectively the last thing they do.   Making this a trivial code
> change.

Looks good.

I'd suggest doing that loop slightly differently:

> -       ret = search_binary_handler(bprm);
> +       do {
> +               depth++;
> +               ret = search_binary_handler(bprm);
> +               /* This allows 4 levels of binfmt rewrites before failing hard. */
> +               if ((ret > 0) && (depth > 5))
> +                       ret = -ELOOP;
> +       } while (ret > 0);
>          if (ret >= 0) {

That's really an odd way to write this.

So honestly, if "ret < 0", then we can just return directly.

So I think would make much more sense to do this loop something like

        for (depth = 0; depth < 5; depth++) {
                int ret;

                ret = search_binary_handler(bprm);
                if (ret < 0)
                        return ret;

                /* Continue searching for the next binary handler? */
                if (ret > 0)
                        continue;

                /* Success! */
                audit_bprm(bprm);
                trace_sched_process_exec(current, old_pid, bprm);
                ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
                proc_exec_connector(current);
                return 0;
        }
        return -ELOOP;

(if I read the logic of exec_binprm() right - I might have missed something).

                Linus
