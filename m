Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD27A5EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjISKBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:01:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10D9E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:01:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD7D1FE09;
        Tue, 19 Sep 2023 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695117673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2tnHoXZXxAeWSKyLVgbS28kIlqrlzuIR07CApx/my4=;
        b=mV+WeknhwsRdB/2TpSYMNn9YqF7G6OKd9xNwSbiOPKcbCGBM8JkUk5ZdZjaLCXEtpof23e
        MNEtWv9phnROTXcLyEMomqMwjOYEoEMs03G73XZOTuzwQEI8IvAPwRDQtVnK0onxBC5gLe
        fIQUpc+ZWHFXWGtiORKnAGfrYLpPzuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695117673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2tnHoXZXxAeWSKyLVgbS28kIlqrlzuIR07CApx/my4=;
        b=AlyBeBSuUmDEXyFF8Pw+mSAFh/0ZCNnxv6t2VEZiNVW+Y1r7KTfYIX2ZtWydkELww5dG1t
        Ed2/ZOdeS0tCgNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0621013458;
        Tue, 19 Sep 2023 10:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RV54AWlxCWV8PAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 10:01:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8FCB1A0759; Tue, 19 Sep 2023 12:01:12 +0200 (CEST)
Date:   Tue, 19 Sep 2023 12:01:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Subject: Re: inotify maintenance status
Message-ID: <20230919100112.nlb2t4nm46wmugc2@quack3>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com>
 <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3>
 <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-09-23 11:08:21, Max Kellermann wrote:
> On Tue, Sep 19, 2023 at 9:17 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > As my summary above states, it is correct that fanotify does not
> > yet fully supersedes inotify, but there is a plan to go in this direction,
> > hence, inotify is "being phased out" it is not Obsolete nor Deprecated.
> 
> I agree that if inotify is to be phased out, we should concentrate on fanotify.
> 
> I'm however somewhat disappointed with the complexity of the fanotify
> API. I'm not entirely convinced that fanotify is a good successor for
> inotify, or that inotify should really be replaced. The additional
> features that fanotify has could have been added to inotify instead; I
> don't get why this needs an entirely new API. Of course, I'm late to
> complain, having just learned about (the unprivileged availability of)
> fanotify many years after it has been invented.
> 
> System calls needed for one inotify event:
> - read()
> 
> System calls needed for one fanotify event:
> - read()
> - (do some magic to look up the fsid -
> https://github.com/martinpitt/fatrace/blob/master/fatrace.c implements
> a lookup table, yet more complexity that doesn't exist with inotify)
> - open() to get a file descriptor for the fsid
> - open_by_handle_at(fsid_fd, fid.handle)
> - readlink("/proc/self/fd/%d") (which adds a dependency on /proc being mounted)
> - close(fd)
> - close(fsid_fd)
> 
> I should mention that this workflow still needs a privileged process -
> yes, I can use fanotify in an unprivileged process, but
> open_by_handle_at() is a privileged system call - it requires
> CAP_DAC_READ_SEARCH. Without it, I cannot obtain information on which
> file was modified, can I?
> There is FAN_REPORT_NAME, but it gives me only the name of the
> directory entry; but since I'm watching a lot of files and all of them
> are called "memory.events.local", that's of no use.
> 
> Or am I supposed to use name_to_handle_at() on all watched files to
> roll my own lookup? (The name_to_hamdle_at() manpage doesn't make me
> confident it's a reliable system call; it sounds like it needs
> explicit support from filesystems.)

So with inotify event, you get back 'wd' and 'name' to identify the object
where the event happened. How is this (for your usecase) different from
getting back 'fsid + handle' and 'name' back from fanotify? In inotify case
you had to somehow track wd -> path linkage, with fanotify you need to
track 'fsid + handle' -> path linkage.

> > FAN_REPORT_FID is designed in a way to be almost a drop in replacement
> > for inotify watch descriptors as an opaque identifier of the object, except that
> > fsid+fhanle provide much stronger functionality than wd did.
> 
> How is it stronger?

For your particular usecase I don't think there's any advantage of
fsid+fhandle over plain wd. But if you want to monitor multiple filesystems
or if you have priviledged process that can open by handle, or a standard
filesystem where handles are actually persistent, then there are benefits.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
