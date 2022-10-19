Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C00603943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 07:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJSFdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 01:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJSFdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:33:49 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6514733E1;
        Tue, 18 Oct 2022 22:33:47 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id p89so6580276uap.12;
        Tue, 18 Oct 2022 22:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LO38QpyOE6fdNXOKDxL+oOJ2Yxv54v5opD2oHL55TzY=;
        b=ohmCVjEdsj0DYP70o8JJWsUgcFVLyNODYe6dv86llYcdAosGLxEC2SDrB0xgpghRea
         mzbugV8DYnf7Exmd65YMLTbNWrGs4qOSKUfUxzuS7YYzl2KzkmLFTmywjUEf5QRXzFvU
         5Mrcw/aaWh6PIotIgfJK6QfgWQ0SMHgAPJuXRB59m280/t9csQbHZNIK0YvTDup3tUsH
         JV29LkYhHpLZ6PknW53dgx23gbGcbiCd137TZGiJrRBEK0QGcEU9YsFbefB0J/8TBRV7
         1GvaV78FG5Nt03Y3x7BaD/0/v8657H6eit2sKQBcqkAIQgu6cSu1yurNqvzbJDAoT8Iy
         SDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO38QpyOE6fdNXOKDxL+oOJ2Yxv54v5opD2oHL55TzY=;
        b=EstM+uQEzx5Ju19Qh2kirrJfCklrtieaqmQHdWSlTVLsLN2GOSjsI5OzcfL3s044uZ
         IAxc4Ujjd9eC9cSDRAcenFx7lnNz499ZvbAgpUN5hg14IvuFv4rsJm6SFUJqs3rSj5NP
         Z5jFuulgeBpPJWGaPQ6neUvQJQ8eLvL5uQh48UrYwya/flgG3YozYcgaEEBdI2ggRWxR
         TumloIvgEmNkisvzyDT4d0EUMRsVB7X9ly0sjYOeuqBQ10F+9Dc5uPt5p6IAcziDAgwz
         KlX0kMD+uMkqBzpIlafsIIinMiIKeA2tHmHnSwUoi5nyZwS4RY8FcAhbpK5Tgvyn83Dd
         zp2A==
X-Gm-Message-State: ACrzQf1EuGRRpFwIDs6m6bW/JFYCj1Odh5BXWZNsipFxW2zsCMMVcR8P
        icxxAQM47/Tvm1C/RysSZNbPf5ogD3OGaMgUqyJ9HI0uYrs=
X-Google-Smtp-Source: AMsMyM6mW/VUZnjWZ7HLR1vlCTwrRf2FN0svKzajtL8b/sExmap7P23vaIgdZfylqN9LbyTTozudoYSJlluNIw0X0rM=
X-Received: by 2002:ab0:7509:0:b0:3d6:9dcb:b3db with SMTP id
 m9-20020ab07509000000b003d69dcbb3dbmr3189918uap.9.1666157626962; Tue, 18 Oct
 2022 22:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com> <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
 <87edv44rll.fsf@oracle.com>
In-Reply-To: <87edv44rll.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Oct 2022 08:33:34 +0300
Message-ID: <CAOQ4uxhwFGddgJP5xPYDysoa4GFPYu6Bj7rgHVXTEuZk+QKYQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 2:52 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
> > On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Hi Jan, Amir, Al,
> >>
> >> Here's my first shot at implementing what we discussed. I tested it using the
> >> negative dentry creation tool I mentioned in my previous message, with a similar
> >> workflow. Rather than having a bunch of threads accessing the directory to
> >> create that "thundering herd" of CPUs in __fsnotify_update_child_dentry_flags, I
> >> just started a lot of inotifywait tasks:
> >>
> >> 1. Create 100 million negative dentries in a dir
> >> 2. Use trace-cmd to watch __fsnotify_update_child_dentry_flags:
> >>    trace-cmd start -p function_graph -l __fsnotify_update_child_dentry_flags
> >>    sudo cat /sys/kernel/debug/tracing/trace_pipe
> >> 3. Run a lot of inotifywait tasks: for i in {1..10} inotifywait $dir & done
> >>
> >> With step #3, I see only one execution of __fsnotify_update_child_dentry_flags.
> >> Once that completes, all the inotifywait tasks say "Watches established".
> >> Similarly, once an access occurs in the directory, a single
> >> __fsnotify_update_child_dentry_flags execution occurs, and all the tasks exit.
> >> In short: it works great!
> >>
> >> However, while testing this, I've observed a dentry still in use warning during
> >> unmount of rpc_pipefs on the "nfs" dentry during shutdown. NFS is of course in
> >> use, and I assume that fsnotify must have been used to trigger this. The error
> >> is not there on mainline without my patch so it's definitely caused by this
> >> code. I'll continue debugging it but I wanted to share my first take on this so
> >> you could take a look.
> >>
> >> [ 1595.197339] BUG: Dentry 000000005f5e7197{i=67,n=nfs}  still in use (2) [unmount of rpc_pipefs rpc_pipefs]
> >>
> >
> > Hmm, the assumption we made about partial stability of d_subdirs
> > under dir inode lock looks incorrect for rpc_pipefs.
> > None of the functions that update the rpc_pipefs dcache take the parent
> > inode lock.
>
> That may be, but I'm confused how that would trigger this issue. If I'm
> understanding correctly, this warning indicates a reference counting
> bug.

Yes.
On generic_shutdown_super() there should be no more
references to dentries.

>
> If __fsnotify_update_child_dentry_flags() had gone to sleep and the list
> were edited, then it seems like there could be only two possibilities
> that could cause bugs:
>
> 1. The dentry we slept holding a reference to was removed from the list,
> and maybe moved to a different one, or just removed. If that were the
> case, we're quite unlucky, because we'll start looping indefinitely as
> we'll never get back to the beginning of the list, or worse.
>
> 2. A dentry adjacent to the one we held a reference to was removed. In
> that case, our dentry's d_child pointers should get rearranged, and when
> we wake, we should see those updates and continue.
>
> In neither of those cases do I understand where we could have done a
> dget() unpaired with a dput(), which is what seemingly would trigger
> this issue.
>

I got the same impression.

> I'm probably wrong, but without understanding the mechanism behind the
> error, I'm not sure how to approach it.
>
> > The assumption looks incorrect for other pseudo fs as well.
> >
> > The other side of the coin is that we do not really need to worry
> > about walking a huge list of pseudo fs children.
> >
> > The question is how to classify those pseudo fs and whether there
> > are other cases like this that we missed.
> >
> > Perhaps having simple_dentry_operationsis a good enough
> > clue, but perhaps it is not enough. I am not sure.
> >
> > It covers all the cases of pseudo fs that I know about, so you
> > can certainly use this clue to avoid going to sleep in the
> > update loop as a first approximation.
>
> I would worry that it would become an exercise of whack-a-mole.
> Allow/deny-listing certain filesystems for certain behavior seems scary.
>

Totally agree.

> > I can try to figure this out, but I prefer that Al will chime in to
> > provide reliable answers to those questions.
>
> I have a core dump from the warning (with panic_on_warn=1) and will see
> if I can trace or otherwise identify the exact mechanism myself.
>

Most likely the refcount was already leaked earlier, but
worth trying.

>
> Thanks for your detailed review of both the patches. I didn't get much
> time today to update the patches and test them. Your feedback looks very
> helpful though, and I'll hope to send out an updated revision tomorrow.
>
> In the absolute worst case (and I don't want to concede defeat just
> yet), keeping patch 1 without patch 2 (sleepable iteration) would still
> be a major win, since it resolves the thundering herd problem which is
> what compounds problem of the long lists.
>

Makes sense.
Patch 1 logic is solid.

Hope my suggestions won't complicate you too much,
if they do, I am sure Jan will find a way to simplify ;)

Thanks,
Amir.
