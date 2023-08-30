Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15F78DB09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjH3SiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjH3H7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:59:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFACDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 00:59:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4013454fa93so46544495e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693382376; x=1693987176; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMMQyokSBoYi+7NtlQGYb+yVajJvpYPKJBULBUddiXM=;
        b=3uiKl5PfYWRpzSYKHy3QPtVLLKXSmsWonpdImDI3XL1mQRj2Q2Fh7ujqIAojBCT8Vw
         Tx62FY1x8dkztef++CPwmDFCN9ByDs7sP9igs+5zuYGzQ0HqlK3dC3G/iDtl95h0jMyW
         p2nB3BUlEt5g1c9sMYae0Q0p05J8SZbJf8rAqYEJM1uhCp1TToSbTSPMqZfZR2oSG2ls
         XtAGUvaBTm5NIQUm54Q/HMY7W7yjnLfVPZC1lf8ggSLCmK37XMVUnBnRlomp1S8o08M3
         IYxVgda0Fm7yB+BCFzTU/KFiX4NFf6vvk7pBgdXXFdj3Tll9rK46YaFyg5WK7wmYxK6h
         FkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693382376; x=1693987176;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMMQyokSBoYi+7NtlQGYb+yVajJvpYPKJBULBUddiXM=;
        b=C09GR8aoE5A1i/2yBAAO/Foa2T9BZc+Q0qLu6cwG/f5NjpMT+HGgv5wR1yLlrCPkK3
         8G4u8Z8wd4bSFtvUQJZNFIXZd0eFAfrkhkz+7u7T54fgWtP3xNFioeoUGvexr1Qn8ZQt
         S41IUnlELh/99TKF0HRV+c+JFQKBlcZcmh5x/2SCqvs3txsp2MskrCcp/rExdZDntU/B
         Mylb9AgZnOqcwoaN0ZoIds5CeA8Lpj6RIyWtzdr7LaGAbL5oE6e2DjOzTGYytoZbUdXd
         CLK9vb0IEh08jK9uCf8wD6TublKYNCfJU2iSdfHQU/o+fYVBYYtF84PPSIiycDzUsBrm
         QcAw==
X-Gm-Message-State: AOJu0YypwBcnGdbGdWmeZkeOc7TCJg51wNvR4fYJ7Oyvi0QNMdkrthm0
        hLi5B/g2v+JpcP3Je90yciVgkQ==
X-Google-Smtp-Source: AGHT+IEjcIizQH3HgpknpZ6G1AFB4laTKJh2Uyrdj3Zs0MAtHyfmRBdqpsjNPzBAd35S2HBtWY8ifA==
X-Received: by 2002:a05:600c:2256:b0:400:6bee:f4fe with SMTP id a22-20020a05600c225600b004006beef4femr1225816wmm.21.1693382375870;
        Wed, 30 Aug 2023 00:59:35 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b003143c6e09ccsm15889160wrq.16.2023.08.30.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 00:59:35 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:59:30 +0200
From:   Marco Elver <elver@google.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, ericvh@kernel.org,
        kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
Message-ID: <ZO724hKaHLCrSOa/@elver.google.com>
References: <000000000000d26ff606040c9719@google.com>
 <ZO3PFO_OpNfBW7bd@codewreck.org>
 <ZO38mqkS0TYUlpFp@elver.google.com>
 <ZO55o4lE2rKO5AlI@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO55o4lE2rKO5AlI@codewreck.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:05AM +0900, Dominique Martinet wrote:
> Marco Elver wrote on Tue, Aug 29, 2023 at 04:11:38PM +0200:
> > On Tue, Aug 29, 2023 at 07:57PM +0900, Dominique Martinet wrote:
> > [...]
> > > Yes well that doesn't seem too hard to hit, both threads are just
> > > setting O_NONBLOCK to the same fd in parallel (0x800 is 04000,
> > > O_NONBLOCK)
> > > 
> > > I'm not quite sure why that'd be a problem; and I'm also pretty sure
> > > that wouldn't work anyway (9p has no muxing or anything that'd allow
> > > sharing the same fd between multiple mounts)
> > > 
> > > Can this be flagged "don't care" ?
> > 
> > If it's an intentional data race, it could be marked data_race() [1].
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks!
> 
> > However, staring at this code for a bit, I wonder why the f_flags are
> > set on open, and not on initialization somewhere...
> 
> This open is during the mount initialization (mount/p9_client_create,
> full path in the stack); there's no more initialization-ish code we
> have.
> The problem here is that we allow to pass any old arbitrary fd, so the
> user can open their fd how they want and abuse mount to use it on
> multiple mounts, even if that has no way of working (as I mentionned,
> there's no control flow at all -- you'll create two completely separate
> client state machines that'll both try to read and/or write (separate
> fds) on the same fd, and it'll all get jumbled up.
> > 
> > Anyway, a patch like the below would document that the data race is
> > intended and we assume that there is no way (famous last words) the
> > compiler or the CPU can mess it up (and KCSAN won't report it again).
> 
> That's good enough for me as my position really is just "don't do
> that"... Would that also protect from syzcaller sending the fd to mount
> on one side, and calling fcntl(F_SETFL) on the side?

No, data_race() is only for marking intentional data races. In a
production kernel, it's a no-op (generated code is identical). In a
KCSAN kernel, it will make the tool not report such data races.

syzkaller doesn't care, and can still produce such programs (so that
other bug detectors can still see an issue if there is one somewhere).

> At this rate we might as well just take the file's f_lock as setfl does,
> but perhaps there's a way to steal the fd from userspace somehow?
> 
> It's not just "don't use this fd for another mount", it really is "don't
> use this fd anymore while it is used by a mount".
> 
> This is made complicated that we only want to steal half of the fd, you
> could imagine a weird setup like this:
> 
>  ┌────────────────────────────────────┐         ┌─────────────────┐
>  │                                    │         │                 │
>  │                                    │         │  kernel client  │
>  │   fd3 tcp to server                │         │                 │
>  │       write end  ◄─────────────────┼─────────┤                 │
>  │                                    │         │                 │
>  │       read end   ──┐               │         │                 │
>  │                    │               │         │                 │
>  │   fd4 pipeA        │ MITMing...    │         │                 │
>  │                    │               │         │                 │
>  │       write end  ◄─┘               │         │                 │
>  │                                    │         │                 │
>  │   fd5 pipeB                        │         │                 │
>  │                                    │         │                 │
>  │       read end  ───────────────────┼────────►│                 │
>  │                                    │         │                 │
>  │                                    │         │                 │
>  └────────────────────────────────────┘         └─────────────────┘
> 
> I'm not sure we actually want to support something like that, but it's
> currently possible and making mount act like close() on the fd would
> break this... :|
> 
> So, yeah, well; this is one of these "please don't do this" that
> syzcaller has no way of knowing about; it's good to test (please don't
> do this has no security guarantee so the kernel shouldn't blow up!),
> but if the only fallout is breakage then yeah data_race() is fine.

Right, if the only breakage is some corruption of the particular file in
user space, and the kernel is still in a good state, then I think this
is fine. However, if the kernel can potentially crash or corrupt
completely unrelated data, it may be a problem.

> Compilers and/or CPU might be able to blow this out of proportion, but
> hopefully they won't go around modifying another unrelated value in
> memory somewhere, and we do fdget so it shouldn't turn into a UAF, so I
> guess it's fine?...

No, the kernel strongly assumes "locally undefined behaviour" for data
races in the worst case, i.e. some garbage value being written into
f_flags. To guard against that we'd have to use READ_ONCE/WRITE_ONCE.

But given the best-effort nature of this based on "don't do this" i.e.
not really supported, data_race() is probably more than enough. You may
want to amend the patch I sent to clarify that (I wasn't aware of it).

> Just taking f_lock here won't solve anything and
> might give the impression we support concurrent uses.
> 
> 
> Sorry for rambling, and thanks for the patch; I'm not sure if Eric has
> anything planned for next cycle but either of us can take it and call it
> a day.

Thanks for the explanation!
