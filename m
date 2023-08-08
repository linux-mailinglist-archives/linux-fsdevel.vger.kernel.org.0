Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776707745FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjHHSuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjHHSuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:50:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9284196F2;
        Tue,  8 Aug 2023 10:00:27 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59184)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qTFiT-004Jdu-Ht; Mon, 07 Aug 2023 23:57:13 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42066 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qTFiQ-0061ch-S9; Mon, 07 Aug 2023 23:57:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
Date:   Tue, 08 Aug 2023 00:56:43 -0500
In-Reply-To: <20230806230627.1394689-1-mjguzik@gmail.com> (Mateusz Guzik's
        message of "Mon, 7 Aug 2023 01:06:27 +0200")
Message-ID: <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qTFiQ-0061ch-S9;;;mid=<87o7jidqlg.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19BtUzvTAIQ16mcMMytlZyHNe8JezgS7c0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Mateusz Guzik <mjguzik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2008 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 15 (0.7%), b_tie_ro: 12 (0.6%), parse: 1.48
        (0.1%), extract_message_metadata: 6 (0.3%), get_uri_detail_list: 2.9
        (0.1%), tests_pri_-2000: 3.6 (0.2%), tests_pri_-1000: 2.5 (0.1%),
        tests_pri_-950: 1.43 (0.1%), tests_pri_-900: 1.23 (0.1%),
        tests_pri_-200: 1.00 (0.0%), tests_pri_-100: 4.8 (0.2%),
        tests_pri_-90: 147 (7.3%), check_bayes: 143 (7.1%), b_tokenize: 9
        (0.4%), b_tok_get_all: 31 (1.6%), b_comp_prob: 4.1 (0.2%),
        b_tok_touch_all: 92 (4.6%), b_finish: 1.63 (0.1%), tests_pri_0: 312
        (15.5%), check_dkim_signature: 0.58 (0.0%), check_dkim_adsp: 3.0
        (0.2%), poll_dns_idle: 1484 (73.9%), tests_pri_10: 3.7 (0.2%),
        tests_pri_500: 1498 (74.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Adding a couple more people.

Mateusz Guzik <mjguzik@gmail.com> writes:

> Making close(2) delegate fput finalization with task_work_add() runs
> into a slowdown (atomics needed to do it) which is artificially worsened
> in presence of rseq, which glibc blindly uses if present (and it is
> normally present) -- they added a user memory-touching handler into
> resume_user_mode_work(), where the thread leaving the kernel lands after
> issuing task_work_add() from fput(). Said touching requires a SMAP
> round-trip which is quite expensive and it always executes when landing
> in the resume routine.
>
> I'm going to write a separate e-mail about the rseq problem later, but
> even if it gets sorted out there is still perf to gain (or rather,
> overhead to avoid).
>
> Numbers are below in the proposed patch, but tl;dr without CONFIG_RSEQ
> making things worse for the stock kernel I see about 7% increase in
> ops/s with open+close.
>
> Searching mailing lists for discussions explaining why close(2) was not
> already doing this I found a patch with the easiest way out (call
> __fput_sync() in filp_close()):
> https://lore.kernel.org/all/20150831120525.GA31015@redhat.com/

What you need to search for is probably the opposite why is
task_work_add used in close.

Taking a quick look at the history it appears that fput was always
synchronous until a decade ago when commit 4a9d4b024a31 ("switch fput to
task_work_add") was merged.

The next two commits 3ffa3c0e3f6e ("aio: now fput() is OK from interrupt
context; get rid of manual delayed __fput()") and commit 6120d3dbb122
("get rid of ->scm_work_list") seem to demonstrate why fput was made
asynchronous.  They rely on the new fput behavior to break recursive
calls and to allow fput from any context.  That plus as Al talks about
having any lock held over fput can potentially cause a deadlock.

All 3 issues taken together says that a synchronous fput is a
loaded foot gun that must be used very carefully.   That said
close(2) does seem to be a reliably safe place to be synchronous.

The big question is can your loop calling open then close going 7%
faster into any real world improvements?  How much can it generalize?

Taking a look at close_fd, it is used in autofs, cachefiles, bpf, amoung
others.  I think there is a very good argument that we can not say that
filep_close is always a safe place to call __fput_close.  There is just
too much going on in some of those place.  A particular possibly
dangerous example is cachefiles_ondemand_daemon_read which calls
complete after close_fd.  If as Oleg suggested filp_close started always
calling __fput_sync that call to complete looks like a deadlock waiting
to happen.

I took a look exit_files() to see if it would be a reasonable candidate
for this optimization.  I see: make_task_dead() -> do_exit() ->
exit_files.  The function make_task_dead is designed to be called from
all kinds of awkward places so I don't see the sync variant being
safe for exit_files().

Which is a long way of saying that this only looks safe for close(2).


Are there any real world gains if close(2) is the only place this
optimization can be applied?  Is the added maintenance burden worth the
speed up?


I would not export any of your new _sync variants to modules.  They are
all loaded foot-guns.

>
> There was no response to it though.
>
> From poking around there is tons of filp_close() users (including from
> close_fd()) and it is unclear to me if they are going to be fine with
> such a change.
>
> With the assumption this is not going to work, I wrote my own patch
> which adds close_fd_sync() and filp_close_sync().  They are shipped as
> dedicated func entry points, but perhaps inlines which internally add a
> flag to to the underlying routine would be preferred? Also adding __ in
> front would be in line with __fput_sync, but having __filp_close_sync
> call  __filp_close looks weird to me.
>
> All that said, if the simpler patch by Oleg Nestero works, then I'm
> happy to drop this one. I just would like to see this sorted out,
> whichever way.
>
> Thoughts?

Unless you can find some real world performance gains this looks like
a bad idea.

Eric
