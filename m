Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127E52EB52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348813AbiETL51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348825AbiETL5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 07:57:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EB3EAB4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:57:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so13908640lfa.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31BsSTdUB7VRoWWevj88Idfwqud3f0xcsnYlp2F0POA=;
        b=IEUzEy81DmvwztAKySzN0TeFujdDabxUQb0Sup0EIME0lukzWRxLg5Cg55wX++2qn/
         jZ9lJcPP1fJ1v67Ijz4hTSWhHefJrLB79g3yEgelYI+OUICUblD3n9G1YfP/Xar/BGKR
         PPE9TjGesdvRzzaih8zb4CBv3SEDMopwGqjUjy39amk3D41Ly36BnYtEaEXBdm+O05gC
         FfyBJbHNIigVZC2/agqCimGy9q14AySDhVg9aFbm40C37EjXJh2XDWCC5C6v2ZtbjvUw
         Qp1uz5LS8Cm6JVJCDxVrfyvyWHZveiMuzTTognwERDfGnu2/ReycCkSXxQ+DGySYnuVh
         uErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31BsSTdUB7VRoWWevj88Idfwqud3f0xcsnYlp2F0POA=;
        b=d2ex+eihv4MswpniI7cjlS+ONdzPqVh9JnReC39uii1PbFoRw18i4MzSP/gbImbl3m
         dMQiqLCKfZleGQ9PVCNIZZ1Sf8b/1NpAhZ4E5G03E5OFXXvrQ307wNeMi5grC1HU0VNF
         JmJ46XT6Oy3WmHkiIBwh2Mk7JtqZ9XFEQ6CJRxyQbdCn47vYHwBiXEPU12Alg9pJiacE
         1FttwTgVMgASI6ccInE0zbHHqHCXts667/wLqZXH7I4L/Edi1BgaP0dE8phKCOJ1DsDq
         ABfvlGtXzP5USG55FwbLlNo3+iLdpT7WCZ49b6AnYMVHanB9r5i0qpZGOugdYfl5yhBi
         1eVg==
X-Gm-Message-State: AOAM530jibfojZaVACdfWvOF9G+0fwWX6f0bistU7tA1GKBc6iRCUXe8
        e9yfMGKw5Hs2wC7GLVvyp33lKIPfj0yE36T7R8b0Cg==
X-Google-Smtp-Source: ABdhPJz4ssjtV4+XduIfH5WVAUmfRwqzN8a1Ew6Et1JsfTSyJDTRTDhNrSG6SO6VxOusbSuX3Ayo3Tto8pBJ44lOH70=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr6861641lfa.598.1653047839426; Fri, 20
 May 2022 04:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032992d05d370f75f@google.com> <20211219023540.1638-1-hdanton@sina.com>
 <Yb6zKVoxuD3lQMA/@casper.infradead.org> <20211221090804.1810-1-hdanton@sina.com>
 <20211222022527.1880-1-hdanton@sina.com> <YcKrHc11B/2tcfRS@mit.edu>
In-Reply-To: <YcKrHc11B/2tcfRS@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 May 2022 13:57:07 +0200
Message-ID: <CACT4Y+YHxkL5aAgd4wXPe-J+RG6_VBcPs=e8QpRM8=3KJe+GCg@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
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

On Wed, 22 Dec 2021 at 05:35, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Dec 22, 2021 at 10:25:27AM +0800, Hillf Danton wrote:
> > > I'm not sure what you hope to learn by doing something like that.
> > > That will certainly perturb the system, but every 150 seconds, the
> > > task is going to let other tasks/threads run --- but it will be
> > > whatever is the next highest priority thread.
> >
> > Without reproducer, I am trying to reproduce the issue using a FIFO CPU hog
> > which is supposed to beat the watchdog to show me the victims like various
> > kthreads, workqueue workers and user apps, despite I know zero about how the
> > watchdog is configured except the report was down to watchdog bite.
>
> It's really trivial to reproduce an issue that has the same symptom as
> what has been reported to you.  Mount the file system using a
> non-real-time (SCHED_OTHER) thread, such that the jbd2 and ext4 worker
> threads are running SCHED_OTHER.  Then run some file system workload
> (fsstress or fsmark) as SCHED_FIFO.  Then on an N CPU system, run N
> processes as SCHED_FIFO at any priority (doesn't matter whether it's
> MAX_PRI-1 or MIN_PRI; SCHED_FIFO will have priority over SCHED_OTHER
> processes, so this will effectively starve the ext4 and jbd2 worker
> threads from ever getting to run.  Once the ext4 journal fills up, any
> SCHED_FIFO process which tries to write to the file system will hang.
>
> The problem is that's *one* potential stupid configuration of the
> real-time system.  It's not necessarily the *only* potentially stupid
> way that you can get yourself into a system hang.  It appears the
> syzkaller "repro" is another such "stupid way".  And the number of
> ways you can screw up with a real-time system is practically
> unbounded...
>
> So getting back to syzkaller, Willy had the right approach, which is a
> Syzcaller "repro" happens to use SCHED_FIFO or SCHED_RR, and the
> symptom is a system hang, it's probably worth ignoring the report,
> since it's going to be a waste of time to debug userspace bug.  If you
> have anything that uses kernel threads, and SCHED_FIFO or SCHED_RR is
> in play, it's probably a userspace bug.
>
> Cheers,

Hi Ted,

Reviving this old thread re syzkaller using SCHED_FIFO.

It's a bit hard to restrict what the fuzzer can do if we give it
sched_setattr() and friends syscalls. We could remove them from the
fuzzer entirely, but it's probably suboptimal as well.

I see that setting up SCHED_FIFO is guarded by CAP_SYS_NICE:
https://elixir.bootlin.com/linux/v5.18-rc7/source/kernel/sched/core.c#L7264

And I see we drop CAP_SYS_NICE from the fuzzer process since 2019
(after a similar discussion):
https://github.com/google/syzkaller/commit/f3ad68446455a

The latest C reproducer contains:

static void drop_caps(void)
{
  struct __user_cap_header_struct cap_hdr = {};
  struct __user_cap_data_struct cap_data[2] = {};
  cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
  cap_hdr.pid = getpid();
  if (syscall(SYS_capget, &cap_hdr, &cap_data))
    exit(1);
  const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
  cap_data[0].effective &= ~drop;
  cap_data[0].permitted &= ~drop;
  cap_data[0].inheritable &= ~drop;
  if (syscall(SYS_capset, &cap_hdr, &cap_data))
    exit(1);
}

Are we holding it wrong? How can the process manage to set any bad
scheduling policies if it dropped CAP_SYS_NICE?...
The process still has CAP_SYS_ADMIN, but I assume it should not allow
it using something that requires dropped CAP_SYS_NICE.
