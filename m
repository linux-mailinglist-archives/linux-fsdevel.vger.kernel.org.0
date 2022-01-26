Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8E49C442
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 08:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiAZHYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 02:24:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48678 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAZHYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:24:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B050D618EC;
        Wed, 26 Jan 2022 07:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC69C340E3;
        Wed, 26 Jan 2022 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643181889;
        bh=Vf6yvt5tfs9pOCWrqF30qR+zwo8sK361Ab/pKrnWcIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrFcV7OhfKHj/5wtwMBw+AJY/lib6EKHC7GkUOf/tcuMaXqMVpznxiA0y9vfbD131
         Kc2vg4dXukbWlbFTWNEUra0K7m1MFo4OzCba9rVAi+O9IyT1atRYSykYjtTzMWKKou
         x9fByzOKEJvnloBZw2S1HdcYrYvZAD3mcc1TAnd7fHx43Ab5ZwapLexFFl1kboILbY
         CAIty4T5uKqMccrxwN6I3o5pCS6L7+s/ct4QY/PqEI5+oT9uZ6k6iiXupttUnFCVC6
         xGtkjmtm5cHCgsava+eHnDFfeyeFbRCrPfXGOXk8GP7QwK7zdvbJGYtWdza+BLXO7t
         wVzs4ANmPh0dQ==
Date:   Wed, 26 Jan 2022 08:24:42 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
Message-ID: <20220126072442.he4fjegfqnh72kzp@wittgenstein>
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com>
 <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
 <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 05:18:02PM -0500, Paul Moore wrote:
> On Tue, Oct 12, 2021 at 10:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 10/12/2021 3:32 AM, Christian Brauner wrote:
> > > On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
> > >> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> > >> a security module may return an error code indicating that it does not
> > >> recognize an input.  In this particular case Smack sees a mount option
> > >> that it recognizes, and returns 0. A call to a BPF hook follows, which
> > >> returns -ENOPARAM, which confuses the caller because Smack has processed
> > >> its data.
> > >>
> > >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > >> ---
> > > Thanks!
> > > Note, I think that we still have the SELinux issue we discussed in the
> > > other thread:
> > >
> > >       rc = selinux_add_opt(opt, param->string, &fc->security);
> > >       if (!rc) {
> > >               param->string = NULL;
> > >               rc = 1;
> > >       }
> > >
> > > SELinux returns 1 not the expected 0. Not sure if that got fixed or is
> > > queued-up for -next. In any case, this here seems correct independent of
> > > that:
> >
> > The aforementioned SELinux change depends on this patch. As the SELinux
> > code is today it blocks the problem seen with Smack, but introduces a
> > different issue. It prevents the BPF hook from being called.
> >
> > So the question becomes whether the SELinux change should be included
> > here, or done separately. Without the security_fs_context_parse_param()
> > change the selinux_fs_context_parse_param() change results in messy
> > failures for SELinux mounts.
> 
> FWIW, this patch looks good to me, so:
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> 
> ... and with respect to the SELinux hook implementation returning 1 on
> success, I don't have a good answer and looking through my inbox I see
> David Howells hasn't responded either.  I see nothing in the original
> commit explaining why, so I'm going to say let's just change it to
> zero and be done with it; the good news is that if we do it now we've


It was originally supposed to return 1 but then this got changed but - a
classic - the documentation wasn't.

> got almost a full cycle in linux-next to see what falls apart.  As far

Sweet!
