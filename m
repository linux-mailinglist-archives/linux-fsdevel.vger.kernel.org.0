Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F036651BD5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbiEEKqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiEEKqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 06:46:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64EE53713
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 03:42:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 888201F8C4;
        Thu,  5 May 2022 10:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651747344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iV4PZtG3ouW5D/6SUG1mBUIKk6x5g2GJQJSIYGuyn9I=;
        b=FgMv7FHyf7nj9nBEOXxSFhdXgwbINoGjlQwPTuKHz9yCnzDMsdHLntUS5szEdqAepO6wMQ
        Ax0upXhOYZ8VSfMYJYhkk8pl3GitaipKLiVNzNwN8F1C1QYWDJ1PiNV/3tStnZHNQRPizU
        5pIjdz86JAKCz1aoATUyM29hZW/COgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651747344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iV4PZtG3ouW5D/6SUG1mBUIKk6x5g2GJQJSIYGuyn9I=;
        b=bgZcONGnpCyBs2MSILT1diGoVFeulFrYJhZ4cGwo/tFbulH7rUHmFOy2zQYnnewACe4NrB
        Jb69z4cAPDdxDlAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FFD32C142;
        Thu,  5 May 2022 10:42:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A576A0627; Thu,  5 May 2022 12:42:24 +0200 (CEST)
Date:   Thu, 5 May 2022 12:42:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Volatile fanotify marks
Message-ID: <20220505104224.g7nsgwnst2didbgc@quack3.lan>
References: <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
 <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
 <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
 <20220303092459.mglgfvq653ge4k42@quack3.lan>
 <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
 <CAOQ4uxgXfL6_fi9rSf8_cUW0Lgbw8Rj_VcBOPiA5ec3PqBqo_Q@mail.gmail.com>
 <7887399b-a0a0-2e09-a9fb-68b758dfa2ff@mail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7887399b-a0a0-2e09-a9fb-68b758dfa2ff@mail.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-05-22 12:01:49, Tycho Kirchner wrote:
> Am 04.05.22 um 08:13 schrieb Amir Goldstein:
> > On Mon, May 2, 2022 at 12:13 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
> > > 
> > > All right, I thought a bit more about that and returned to your
> > > original BPF idea you mentioned on 2020-08-28:
> > > 
> > > > I was thinking that we could add a BPF hook to fanotify_handle_event()
> > > > (similar to what's happening in packet filtering code) and you could attach
> > > > BPF programs to this hook to do filtering of events. That way we don't have
> > > > to introduce new group flags for various filtering options. The question is
> > > > whether eBPF is strong enough so that filters useful for fanotify users
> > > > could be implemented with it but this particular check seems implementable.
> > > > 
> > > >                                                                Honza
> > > 
> > > Instead of changing fanotify's filesystem notification functionality,
> > > I suggest to rather **add a tracing mode (fantrace)**.
> > > 
> > > The synchronous handling of syscalls via ptrace is of course required
> > > for debugging purposes, however that introduces a major slowdown (even
> > > with seccomp-bpf filters). There are a number of cases, including
> > > [1-3], where async processing of file events of specific tasks would be
> > > fine but is not readily available in Linux. Fanotify already ships
> > > important infrastructure in this regard: it provides very fast
> > > event-buffering and, by using file descriptors instead of resolved
> > > paths, a clean and race-free API to process the events later. However,
> > > as already stated, fanotify does not provide a clean way, to monitor
> > > only a subset of tasks. Therefore please consider the following
> > > proposed architecture of fantrace:
> > > 
> > > Each taks gets its own struct fsnotify_group. Within
> > > fsnotify.c:fsnotify() it is checked if the given task has a
> > > fsnotify_group attached where events of interest are buffered as usual.
> > > Note that this is an additional hook - sysadmins being subscribed to
> > > filesystem events rather than task-filesystem-events are notified as
> > > usual - in that case two hooks possibly run. The fsnotify_group is
> > > extended by a field optionally pointing to a BPF program which allows
> > > for custom filters to be run.
> > > 
> > > Some implementation details:
> > > - To let the tracee return quickly, run BPF filter program within tracer
> > >     context during read(fan_fd) but before events are copied to userspace
> > > - only one fantracer per task, which overrides existing ones if any
> > > - task->fsnotify_group refcount increment on fork, decrement on exit (run
> > >     after exit_files(tsk) to not miss final close events). When last task
> > >     exited, send EOF to listener.
> > > - on exec of seuid-programs the fsnotify_group is cleared (like in ptrace)
> > > - lazy check when event occurs, if listener is still alive (refcount > 1)
> > > - for the beginning, to keep things simple and to "solve" the cleanup of
> > >     filesystem marks, I suggest to disable i_fsnotify_marks for fantrace
> > >     (only allow FAN_MARK_FILESYSTEM), as that functionality can be
> > >     implemented within the user-provided BPF-program.
> > > 
> > 
> > Maybe I am slow, but I did not understand the need for this task fsnotify_group.
> > 
> > What's wrong with Jan's suggestion? (add a BPF hook to fanotify_handle_event())
> > that hook is supposed to filter by pid so why all this extra complexity?
> > 
> > We may consider the option to have another BFP hook when reading
> > events if there is
> > good justification, but subtree filters will have to be in handle_event().
> > 
> > Thanks,
> > Amir.
> 
> To be a reasonable async replacement for ptrace (see e.g. mentioned
> reprozip) file-events from all paths have to be reported, which is
> difficult using i_fsnotify_marks, because
> - marking whole mountpoints requires privileges
> - marking the whole filesystem using directory marks is unfeasible

I agree with both points here but I guess the point is that fanotify simply
is not meant to be "async replacement for ptrace". It is a filesystem
change monitoring API. Things like Linux tracing (e.g. perf-trace(1)) could
be considered as such, but they require priviledges as well.

> However, we need a quick way to find out, if a file event is of
> interest (find its beloning fsnotify_group). For the purpose of tracing
> it appears reasonable to consider all file events of a traced task as
> "interesting" in the first place. So, in this way, we allow a user to
> trace file events of his own tasks without slowing down other,
> non-traced tasks.

So I agree that the idea of storing some "owner" information (be it user or
particular pid) in fsnotify_group and notify group about events only from
"owner" has some appeal because it nicely solves the question "is user
priviledged enough to see this event?" But it does not quite fit in the
philosophy of a filesystem monitor because fanotify filesystem changes from
other "owners" will not generate notification although you can see them
when looking at the filesystem. I have not completely made up my mind how
much that matters ;)

> After all, it's all about the order of running filters - first inode,
> then pid or reverse. With my proposed architecture for the purpose of
> tracing I would hand the inode-filter to the user in form of an
> optional BPF hook. Performance-wise that's also the "fair" solution.
> Let's assume we allow marking the whole filesystem (via mountpoints).
> Now, the BPF-pid-filter code has to run for every single file event (of
> all users!), if multiple users trace the filesystem even multiple hooks
> have to run, slowing down the whole system.

I understand what you'd like to achieve but things don't work as you
imagine it. Fsnotify has hooks in paths modifying filesystem. When the hook
gets called with the modified object (file, dir, ..) we need to quickly
tell whether the event may be of interest or not - for that we consult the
inode, parent directory, mountpoint, superblock. At this point we don't
know we should limit anything to a particular task because we do not know
yet which notification groups are interested in the event. Only if we find
someone is interested, we walk lists of notification groups, identify which
notification group is exactly interested and at that point we could know
this is your special group limited to a particular task and filter by task.

What you are suggesting could be also implemented by adding another object
type to watch - a task. But honestly it does not seem like a good idea to
expand fanotify in such direction because fanotify is all about filesystem
objects so adding so vastly different objects such as originating task does
not fit well with the API.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
