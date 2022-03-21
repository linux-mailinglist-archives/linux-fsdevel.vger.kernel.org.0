Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AF4E2DBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbiCUQUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351012AbiCUQUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:20:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D863FBE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 09:18:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 25so20561928ljv.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAwJj3uBpRqWwRFnZtOEH00g+2pzmN/+iR2r7Fyi43w=;
        b=npnsPZknEPPCA45ZcQMieO3nPxTHnfJ+SZKn+zyF9w/G5oeqPhWo3zvNoHMyhUV1x1
         S3y313aNJRqBf04W6W1iddLKIgELoERWv2Uct6pkx1MaSUoQCW1xYUqqIjQEV4U+J/Ql
         3EIShK/igFDv4XwN7OSpYFN8v5m9LLxqgaCLLkVWGmHL7FO0oknD0DZ0C599I8BCgfqF
         6K5EqVyNnlzS+dnCm9HuiZ5uSKXOz6YE5KjmutX7dL9sIICHywyuy1od0hvU/Pvh5NeI
         XIxocn+fc49b5/NZQqGHjWilvg1sly6yqTezlWvF+EyKNqeWvdv390jYdc/bl9JJ35T8
         pA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAwJj3uBpRqWwRFnZtOEH00g+2pzmN/+iR2r7Fyi43w=;
        b=C0qfETkF0hXneTtW9ZUxEHPYXPT4W3ERk9sh3x1PACZRRk1LabS7R9BI0mWQdAAiLO
         2h8UxIqbA3wv+E6DsMiKqtHGNdSWq/GOXrczMfFVKDFX4IhIPrJh8Q6vIcHuDXYAIK0Z
         BMbfs0K1knrNuKJkRgmihCBw8tehD8nNROGh90lk0y4pHlfDYxS0y9PAODbfcrUrLpK3
         nMsGPnox/HrhPo7oYwDvkUX2Fkqx2DWEO/S9l0/6XCuFDmfBSpHxh/GZWZnwPTq4YTFS
         RVWXpJSBI1sNNQaSN656roEvC41CAAoFSCZbbKZtWxhmdGkxjvWPVYIh59KvyJBq3Z+D
         I7Yg==
X-Gm-Message-State: AOAM5325TkmISfbBduc1owEteLqeFRrE9cIZkdTSXhBJC+8P3WtjeWeU
        WvYk2tNS2tmFrKcn4k/La0fuS1kUtAz3nAhJiEgjfg==
X-Google-Smtp-Source: ABdhPJz32TMlmcMhfajg2T1GA0z3yKM6fI90HrpBJrUF/SHXliOt5nUvaygw15LX5TpcWe4/TQ9sUIqdchIWndd3zoc=
X-Received: by 2002:a2e:b942:0:b0:249:8cd0:2848 with SMTP id
 2-20020a2eb942000000b002498cd02848mr1184656ljs.188.1647879511392; Mon, 21 Mar
 2022 09:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000778f1005dab1558e@google.com> <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com>
 <1037989.1647878628@warthog.procyon.org.uk>
In-Reply-To: <1037989.1647878628@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Mar 2022 17:17:54 +0100
Message-ID: <CAG48ez1+4dbZ9Vi8N4NKCtGwuXErkUs6bC=8Pf+6jiZbxrwR7g@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in pipe_write
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 5:03 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > The syz reproducer is:
> >
> > #{"threaded":true,"procs":1,"slowdown":1,"sandbox":"","close_fds":false}
> > pipe(&(0x7f0000000240)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
> > pipe2(&(0x7f00000001c0)={0xffffffffffffffff, <r2=>0xffffffffffffffff}, 0x80)
> > splice(r0, 0x0, r2, 0x0, 0x1ff, 0x0)
> > vmsplice(r1, &(0x7f00000006c0)=[{&(0x7f0000000080)="b5", 0x1}], 0x1, 0x0)
> >
> > That 0x80 is O_NOTIFICATION_PIPE (==O_EXCL).
> >
> > It looks like the bug is that when you try to splice between a normal
> > pipe and a notification pipe, get_pipe_info(..., true) fails, so
> > splice() falls back to treating the notification pipe like a normal
> > pipe - so we end up in iter_file_splice_write(), which first locks the
> > input pipe, then calls vfs_iter_write(), which locks the output pipe.
> >
> > I think this probably (?) can't actually lead to deadlocks, since
> > you'd need another way to nest locking a normal pipe into locking a
> > watch_queue pipe, but the lockdep annotations don't make that clear.
>
> Is this then a bug/feature in iter_file_splice_write() rather than in the
> watch queue code, per se?

I think at least when you call splice() on two normal pipes from
userspace, it'll never go through this codepath for real pipes,
because pipe-to-pipe splicing is special-cased? And sendfile() bails
out in that case because pipes don't have a .splice_read() handler.

And with notification pipes, we don't take that special path in
splice(), and so we hit the lockdep warning. But I don't know whether
that makes it the fault of notification pipes...

Maybe it would be enough to just move the "if (pipe->watch_queue)"
check in pipe_write() up above the __pipe_lock(pipe)?
