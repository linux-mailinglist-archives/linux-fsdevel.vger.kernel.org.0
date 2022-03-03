Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6065A4CBA20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiCCJZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 04:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiCCJZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:25:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011233E3D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 01:25:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 909F21F381;
        Thu,  3 Mar 2022 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646299499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcQjMFDQoCGOYYxlsHyCKtTCxztIC8Ghgwn+UzSJBgA=;
        b=WJValSJqAcj+BRTdZPb7r3NbTFArEZQbJpq6GYxzYVu/9BZRjyS0PLiLbUlxL9t/x1sX6J
        c50W3Khh4Z9C2fINVA0gm9M4suKCaXDWrvziIx4+DGEeJmplzzg8NoovX1sERK6H0s0NkM
        pdzRuV8mRQiP27XKnmwcFsFMlzsoch0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646299499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcQjMFDQoCGOYYxlsHyCKtTCxztIC8Ghgwn+UzSJBgA=;
        b=f11UKflTK2u4mSYVwLgWA9dqBFnOoSrjgDdu73cWY+EsT6KzYUTfjIrGHNNpYEvZnbKcxE
        bAytT0UdhDQYO6Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 165BCA3B81;
        Thu,  3 Mar 2022 09:24:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2CE68A0604; Thu,  3 Mar 2022 10:24:59 +0100 (CET)
Date:   Thu, 3 Mar 2022 10:24:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Tycho Kirchner <tychokirchner@mail.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Volatile fanotify marks
Message-ID: <20220303092459.mglgfvq653ge4k42@quack3.lan>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de>
 <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de>
 <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-03-22 20:14:29, Amir Goldstein wrote:
> On Wed, Mar 2, 2022 at 12:04 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
> > >>
> > >> Regarding tracing I think fanotify would really benefit from a FAN_MARK_PID (with optional follow fork-mode). That way one of the first filter-steps would be whether events for the given task are of interest, so we have no performance problem for all other tasks. The possibility to mark specific processes would also have another substantial benefit: fanotify could be used without root privileges by only allowing the user to mark his/her own processes.
> > >> That way existing inotify-users could finally switch to the cleaner/more powerful fanotify.
> > >
> > > We already have partial support for unprivileged fanotify.
> > > Which features are you missing with unprivileged fanotify?
> > > and why do you think that filtering by process tree will allow those
> > > features to be enabled?
> >
> >
> > I am missing the ability to filter for (close-)events of large
> > directory trees in a race-free manner, so that no events are lost on
> > newly created dirs. Even without the race, monitoring my home-directory
> > is impossible (without privileges) as I have far more than 8192
> > directories (393941 as of writing (; ).  Monitoring mounts solves these
> > problems but introduces two others: First it requires privileges,
> > second a potentially large number of events *not of interest* have to
> > be copied to user-space (except unshared mount namespaces are used).
> > Allowing a user to only monitor his/her own processes would make
> > mark_mount privileges unnecessary (please correct me if I'm wrong).
> > While still events above the directory of interest are reported, at
> > least events from other users are filtered beforehand.
> 
> I don't know. Security model is hard.
> What do you mean by "his/her own processes"? processes owned by the same uid?
> With simple look it sounds right, but other security policy may be in
> play (e.g. sepolicy)
> which can grand different processes owned by same user different file access
> permissions and not any process may be allowed to ptrace other processes.
> userns has more clear semantics, so monitoring all processes/mounts inside
> an unprivileged userns may be easier to prove.

I see two problems with limiting events to those generated by a particular
process / user:

1) Fanotify is a filesystem notification system. As such it is primarily
aimed at (more or less efficient) answering of a question - did something
in the filesystem change, was some data from the filesystem used? If you
start to limit visible events to processes / users you are no longer able
to reliably answer this question. As such we would get complaints "but this
is not good enough for our usecase" sooner rather than later. In filesystem
change notification space we have a long history of partial solutions that
then forced us into full redesign and all the pain associated with that.

2) Limiting events to those generated by a particular user may somewhat
reduce the amount of generated events but for a lot of usecases that is not
really significant. So the push for some middle ground between - watching a
file / dir and watching whole fs will still stay. 

Regarding the security model for unpriviledged watches: IMO a sensible
security model for fs notification could be like: "If you can read the
file, you should be able to watch for changes. If you own the file, you
should be able to watch for accesses." But the trouble is that for
filesystem wide marks, it is not easy to verify these conditions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
