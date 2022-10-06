Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812C5F614F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJFHBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 03:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJFHBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:01:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56614895F6
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 00:01:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c24so927596plo.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+lbQl0rCWp6tUyMuSCFzB+6AqJEUrQkOLadwCqKXhk8=;
        b=P95tTnDc1Zlo/FcKgRsnGgHRjJuXF/BFr+q4DuBF33xCmhNVRs6A28XD98ty9ydWhR
         I0fNfA9HigrTrxzxM8SRehh5Ge3szOsR8uqcuHDzpkuDwL28EF8Nx7W6Jtxnf4ewqv7c
         vZdNf5PJ4XLSjhccFK2aEjcik36/tWfKRJXjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+lbQl0rCWp6tUyMuSCFzB+6AqJEUrQkOLadwCqKXhk8=;
        b=kRpUkhJKowIkG/WNbY8vmfk0H0PgHsANHzmVS+DQDejAk/XInKSUs5k3WBJFquHS37
         Zu4rz8TpgXTRvZuVBIBy+bZ4NR/u+M3GY+ZC1Mn0Q6p1Rsssb/3Gduv7/EkX9nCNwjgx
         EQj4mk7QBaPv9gGVAwe/I58n4LcXcMawLVzHXnHW+oZKl8q2Rz4HaeJAKCZjuGcgW/Bp
         jl3sBluakNheE0wdnNpkMBSIu4nvbb1tMa0qlEf0CwzFlKBT9iNsAojwbo5c/01wm3pD
         RTvXdLyR9JWL3dQC8LzrQffKyXtflr31jqw/ugo44QUwW1uMyWj78CLJ+zFhYQD9RgZw
         mFJg==
X-Gm-Message-State: ACrzQf3G9hM/XZlSrK7DyRj0xe6JGzIcOek7ha5OMWt1/pyj4VFRqyp4
        dvjBhf94eqGXQ+tQqUICo+18Sg==
X-Google-Smtp-Source: AMsMyM6P4p2fzjX7EoySe3pBKUHcQlET2UNqLJholUcyZnckHtT8XafYbihl5e+uuD/gwL/5Z3GhKA==
X-Received: by 2002:a17:902:ed97:b0:17f:7ad0:16cb with SMTP id e23-20020a170902ed9700b0017f7ad016cbmr3342781plj.97.1665039692613;
        Thu, 06 Oct 2022 00:01:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090a62cc00b002008d0df002sm2173296pjs.50.2022.10.06.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:01:31 -0700 (PDT)
Date:   Thu, 6 Oct 2022 00:01:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <202210052326.5CF2AF342@keescook>
References: <20220910211215.140270-1-jorge.merlino@canonical.com>
 <202209131456.76A13BC5E4@keescook>
 <c9ca551b-070b-dcee-b4b4-b7fbfc33ab5d@canonical.com>
 <202210051950.CAF8CDBF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210051950.CAF8CDBF@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:06:15PM -0700, Kees Cook wrote:
> Dave, this tracks back to commit a6f76f23d297 ("CRED: Make execve() take
> advantage of copy-on-write credentials") ... any ideas what's happening
> here?

Er, rather, it originates before git history, but moved under lock in
commit 0bf2f3aec547 ("CRED: Fix SUID exec regression").

Eric, Al, Hugh, does this ring a bell?

It originates from 1da177e4c3f4 ("Linux-2.6.12-rc2") in git...

static inline int unsafe_exec(struct task_struct *p)
{
       int unsafe = 0;
...
       if (atomic_read(&p->fs->count) > 1 ||
           atomic_read(&p->files->count) > 1 ||
           atomic_read(&p->sighand->count) > 1)
               unsafe |= LSM_UNSAFE_SHARE;

       return unsafe;
}

Current code is:

static void check_unsafe_exec(struct linux_binprm *bprm)
{
        struct task_struct *p = current, *t;
        unsigned n_fs;
...
        t = p;
        n_fs = 1;
        spin_lock(&p->fs->lock);
        rcu_read_lock();
        while_each_thread(p, t) {
                if (t->fs == p->fs)
                        n_fs++;
        }
        rcu_read_unlock();

        if (p->fs->users > n_fs)
                bprm->unsafe |= LSM_UNSAFE_SHARE;
        else
                p->fs->in_exec = 1;
        spin_unlock(&p->fs->lock);
}


Which seemed to take its form from:

0bf2f3aec547 ("CRED: Fix SUID exec regression")

Quoting the rationale for the checks:
    ...
    moved the place in which the 'safeness' of a SUID/SGID exec was performed to
    before de_thread() was called.  This means that LSM_UNSAFE_SHARE is now
    calculated incorrectly.  This flag is set if any of the usage counts for
    fs_struct, files_struct and sighand_struct are greater than 1 at the time the
    determination is made.  All of which are true for threads created by the
    pthread library.

    So, instead, we count up the number of threads (CLONE_THREAD) that are sharing
    our fs_struct (CLONE_FS), files_struct (CLONE_FILES) and sighand_structs
    (CLONE_SIGHAND/CLONE_THREAD) with us.  These will be killed by de_thread() and
    so can be discounted by check_unsafe_exec().

So, I think this is verifying that when attempting a suid exec, there is
no process out there with our fs_struct, file_struct, or sighand_struct
that would survive the de_thread() and be able to muck with the suid's
shared environment:

       if (atomic_read(&p->fs->count) > n_fs ||
           atomic_read(&p->files->count) > n_files ||
           atomic_read(&p->sighand->count) > n_sighand)

Current code has eliminated the n_files and n_sighand tests:

n_sighand was removed by commit
f1191b50ec11 ("check_unsafe_exec() doesn't care about signal handlers sharing")

n_files was removed by commit
e426b64c412a ("fix setuid sometimes doesn't")

The latter reads very much like the current bug report. :) So likely the n_fs
test is buggy too...

After de_thread(), I see the calls to unshare_sighand() and
unshare_files(), so those check out.

What's needed to make p->fs safe? Doing an unshare of it seems possible,
since it exists half as a helper, unshare_fs(), and half open-coded in
ksys_unshare (see "new_fw").

Should we wire this up after de_thread() like the other two?

-Kees

-- 
Kees Cook
