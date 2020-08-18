Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD52247B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRAOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRAOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:14:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5AEC061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 17:13:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k13so9296575lfo.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=Cc93yVMbx3RvLnq5PLotBg+roGGu69+/Dx9uDZdnFaQvTrkIzdLU5lhrEDOPiq2+fN
         5E+MIu8qQiaA07jjpGceLS5/FUXItwiiQf3jrnqL+6nxCyP1OYWmoOUBc1tR+82IoQ3t
         pB1HfO6+D8i21tTtZuIWUIjxWkjP3RCPMcq/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PUubmKG0qCUbLC0lny1sEZMsh6oDctj94eQbjDTgwk=;
        b=shgzftFjfqfK62keDZ4vgeaR5QJdmsapy/3rYDJXiMDBtEzaonZfDRPDlSSr1fX+R/
         2xYOSiS4J5N4MMeV46wnM7subi0ZDXaZABzcnJGvD8xEglXMpMyDncglnL28XIaQO2JH
         rzRUXj4qoseZcT+WjUdFGCizF3URWlNiiMzSWFNcGt+NeZjaZMMQVWksM0EZ7Ldbsf5p
         LKDDUvVVCOwdKxevxXajLjnbrvKwAZtlkKGxkfpped10/c+qSUW3zm/gn/icqaydOe9f
         fkVMs554lqE05dVv644RNMrP9I6Mqum92n973rw3+p2X+Fc6vlEPmLhUIi+JroV0ekS8
         r5Xg==
X-Gm-Message-State: AOAM532OfwMLBSUj8uUl2B7zT7tZlAHMhSUCEBz384TCC0+53Avu/a7g
        YKkAdag5gwJGhBscTkFi4Y55wUB4kHMGSg==
X-Google-Smtp-Source: ABdhPJyA8hgfvKgYmT7HMgNyj8Nu410BfXOxgI+2L1rB3PFbzhlG0Ja995SNXDHqydBos1duzIP6cw==
X-Received: by 2002:ac2:5505:: with SMTP id j5mr7186631lfk.4.1597709636190;
        Mon, 17 Aug 2020 17:13:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z25sm5417518lji.33.2020.08.17.17.13.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 17:13:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 185so19405822ljj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 17:13:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr8518837lfp.10.1597709323252;
 Mon, 17 Aug 2020 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-12-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 17:08:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Message-ID: <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Instead hold task_lock for the duration that task->files needs to be
> stable in seq_show.  The task_lock was already taken in
> get_files_struct, and so skipping get_files_struct performs less work
> overall, and avoids the problems with the files_struct reference
> count.

Hmm. Do we even need that task_lock() at all? Couldn't we do this all
with just the RCU lock held for reading?

As far as I can tell, we don't really need the task lock. We don't
even need the get/pid_task_struct().

Can't we just do

        rcu_read_lock();
        task = pid_task(proc_pid(inode), PIDTYPE_PID);
        if (task) {
                unsigned int fd = proc_fd(m->private);
                struct file *file = fcheck_task(task, fd);
                if (file)
                        .. do the seq_printf ..

and do it all with no refcount games or task locking at all?

Anyway, I don't dislike your patch per se, I just get the feeling that
you could go a bit further in that cleanup..

And it's quite possible that I'm wrong, and you can't just use the RCU
lock, but as far as I can tell, both the task lookup and the file
lookup *already* really both depend on the RCU lock anyway, so the
other locking and reference counting games really do seem superfluous.

Please just send me a belittling email telling me what a nincompoop I
am if I have missed something.

             Linus
