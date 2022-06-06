Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C553EDE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiFFS2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiFFS2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:28:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823AB58E4E
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 11:28:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fu3so29099745ejc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=e5deP955cqquSyg6oIIx3CAf8kgiTaqIY9bcnFfEj7ZLflDPPAW86Emcn95M8HZaCC
         42qc7J70nZug2SNdJKjJgyCMPhAPg0LD/D4YMTCvWKzcs83etYmdBaLlq/Isztw3LXqz
         giP1rEm6h5Y0md23q+Lg6Uqv0VYv58smLzap0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXYqp07Gt1ZtS5TmqPmPcYjNyQa7EHn+PPqLupxduxE=;
        b=4+lhrlpGyka6Kbf0MaT/vMK+1oR4+mINFKnhMwGKKf/rMSKTl8jvfYtk7XdTmwRlQC
         PEnkhy+HPf5BWqwKO6xsBaFhAY87zPzapvmzIrZJWAKR58ajOwrIY/Tv3KQaVxxizQgE
         l2nq248yulMGZZ77//JW2KX2nMl5PW/3NzUMWjFZgmKzgYBrC71MK1BLcaA3kxSDv0DP
         Kr/pLUZQmIa90GI2Zg794Rlgl/8C5TqMOZy1NIZ5+qFLQYSwKrmuE3x21r3sb0JJoA3Z
         m7iPVqA6z9uAwY7Ni4AI+ZeRLIn4NwneVVDToCGN4e/i48tZ1D0IXb1ZsXFIWI/vm4nQ
         JsPQ==
X-Gm-Message-State: AOAM5304/iYZ0iFrJB5/+5aZdfqhgRAIJuPuJoN8nTqIuNvp2YZ6LzGv
        /vGWw/+0XBtGcdIL6m4hrlhU61vfObVx7SBN0qQ=
X-Google-Smtp-Source: ABdhPJxrQ1/FwXJ5cOYDlTePtChGB6jZs7iTPXzJuSZ1JcTUfza07vnHQfsblmRsnEOILDCPVT3Lxg==
X-Received: by 2002:a17:907:7256:b0:711:d5ac:b9e6 with SMTP id ds22-20020a170907725600b00711d5acb9e6mr3661344ejc.680.1654540121793;
        Mon, 06 Jun 2022 11:28:41 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b006fec63e564bsm6694311ejj.30.2022.06.06.11.28.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:28:40 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id k19so20946394wrd.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 11:28:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr22896573wrz.281.1654540120455; Mon, 06
 Jun 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r1414y5v.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 11:28:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Message-ID: <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 6, 2022 at 8:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Has anyone looked into this lock ordering issues?

The deadlock is

> >> [78140.503821]        CPU0                    CPU1
> >> [78140.503823]        ----                    ----
> >> [78140.503824]   lock(&newf->file_lock);
> >> [78140.503826]                                lock(&p->alloc_lock);
> >> [78140.503828]                                lock(&newf->file_lock);
> >> [78140.503830]   lock(&ctx->lock);

and the alloc_lock -> file_lock on CPU1 is trivial - it's seq_show()
in fs/proc/fd.c:

        task_lock(task);
        files = task->files;
        if (files) {
                unsigned int fd = proc_fd(m->private);

                spin_lock(&files->file_lock);

and that looks all normal.

But the other chains look painful.

I do see the IPC code doing ugly things, in particular I detest this code:

        task_lock(current);
        list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
        task_unlock(current);

where it is using the task lock to protect the shm_clist list. Nasty.

And it's doing that inside the shm_ids.rwsem lock _and_ inside the
shp->shm_perm.lock.

So the IPC code has newseg() doing

   shmget ->
    ipcget():
     down_write(ids->rwsem) ->
       newseg():
         ipc_addid gets perm->lock
         task_lock(current)

so you have

  ids->rwsem -> perm->lock -> alloc_lock

there.

So now we have that

   ids->rwsem -> ipcperm->lock -> alloc_lock -> file_lock

when you put those sequences together.

But I didn't figure out what the security subsystem angle is and how
that then apparently mixes things up with execve.

Yes, newseg() is doing that

        error = security_shm_alloc(&shp->shm_perm);

while holding rwsem, but I can't see how that matters. From the
lockdep output, rwsem doesn't actually seem to be part of the whole
sequence.

It *looks* like we have

   apparmour ctx->lock -->
      radix_tree_preloads.lock -->
         ipcperm->lock

and apparently that's called under the file_lock somewhere, completing
the circle.

I guess the execve component is that

  begin_new_exec ->
    security_bprm_committing_creds ->
      apparmor_bprm_committing_creds ->
        aa_inherit_files ->
          iterate_fd ->   *takes file_lock*
            match_file ->
              aa_file_perm ->
                update_file_ctx *takes ctx->lock*

so that's how you get file_lock -> ctx->lock.

So you have:

 SHMGET:
    ipcperm->lock -> alloc_lock
 /proc:
    alloc_lock -> file_lock
 apparmor_bprm_committing_creds:
    file_lock -> ctx->lock

and then all you need is ctx->lock -> ipcperm->lock but I didn't find that part.

I suspect that part is that both Apparmor and IPC use the idr local lock.

               Linus
