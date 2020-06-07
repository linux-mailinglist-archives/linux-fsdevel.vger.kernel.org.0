Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E311F0948
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFGBtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 21:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgFGBtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 21:49:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4DC08C5C2;
        Sat,  6 Jun 2020 18:49:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so4470579pjv.2;
        Sat, 06 Jun 2020 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4/heD8LnbTWt3HUa9iQBgHDzoyI4QTJn/1Uohykb/k=;
        b=DYliSASnqSYuxcH4Cjkj5Bwb9ju1IQfW9SbUyYrbDVqG006uHLDChGyjtWOW2vmPlj
         zXTSJdcuwJ8E5gJgi2cIqbyYVmDazpZbdMiQX6wFlg7ztByxd6S6vYaRPwGpuI249gwL
         85ELsp0DTsqPgxDb/jfvxuTnn6njw7pelNxe/6pRsSuSlc5yYe0vNSHdjJur3Yx9iwvT
         WXYXnDbjQw0tmJoZJy2dVHlpe+cbNqrO/cylaxjJB9qpNvKG9i7cRXD0J/XvCL3oBxKt
         JfMGaAM5HyfPJ/xwM5rl3Ku59eX5nStAnliH344z9FTAREiUKiMMIqZy9nJ4xvqWuTP+
         kdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4/heD8LnbTWt3HUa9iQBgHDzoyI4QTJn/1Uohykb/k=;
        b=LAihqqoDRYPTYwpFRdRTTfHii0zC/D4v39o+eu9dC8+D5JCc04tH7fb7fO1AG9NvtF
         0fhJUDefsy01Wu4AvoCCk5Q0kUz2iW6Da8h9y0rhykySPgELS63TR5Oc90OGnSBgqzGZ
         j07DROaYOHOK/qzmDAQJdn6PCCdEvoN1BEIGi25P+dfPEg7FdPAFezZPOD3M2DOgiVTi
         THvh0G2Zo2JcD1M4ZRCeitT6VhGemHvKAAg4ad6Bep77vOzzEH7VlEtXlMWME1P87Eou
         4BRsePTmliuhQEMwpUdSXCVQteE/X0l8sxEIIWXaGGy1kOe1cY3C6aTIDidA9AbK6j60
         WQZQ==
X-Gm-Message-State: AOAM5323YyrPTGzoKPAxfq/wAOD+AKKToRrOrZV1l0+tGghiOGMSPGOc
        hujlTNObIOedZfYlZmQGc9A=
X-Google-Smtp-Source: ABdhPJzxbuGgVulSsnqAoa9UqAvBR+JICxPe6Dew6aXoeqt5XCLENSBYFnpeDD9tcpwgpNvP7O5ISw==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr10320845pjd.33.1591494580168;
        Sat, 06 Jun 2020 18:49:40 -0700 (PDT)
Received: from ast-mbp ([199.231.241.138])
        by smtp.gmail.com with ESMTPSA id q65sm3403860pfc.155.2020.06.06.18.49.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2020 18:49:39 -0700 (PDT)
Date:   Sat, 6 Jun 2020 18:49:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200607014935.vhd3scr4qmawq7no@ast-mbp>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 03:33:14PM -0700, Linus Torvalds wrote:
> On Sat, Jun 6, 2020 at 1:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Please mention specific bugs and let's fix them.
> 
> Well, Eric did mention one explicit bug, and several "looks dodgy" bugs.
> 
> And the fact is, this isn't used.
> 
> It's clever, and I like the concept, but it was probably a mistake to
> do this as a user-mode-helper thing.
> 
> If people really convert netfilter rules to bpf, they'll likely do so
> in user space. This bpfilter thing hasn't gone anywhere, and it _has_
> caused problems.
> 
> So Alexei, I think the burden of proof is not on Eric, but on you.
> 
> Eric's claim is that
> 
>  (a) it has bugs (and yes, he pointed to at lelast one)

the patch from March 12 ?
I thought it landed long ago. Is there an issue with it?
'handling is questionable' is not very constructive.

>  (b) it's not doing anything useful

true.

>  (b) it's a maintenance issue for execve, which is what Eric maintains.

I'm not aware of execve issues. I don't remember being cc-ed on them.
To me this 'lets remove everything' patch comes out of nowhere with
a link to three month old patch as a justification.

> So you can't just dismiss this, ignore the reported bug, and say
> "we'll fix them".
> 
> That only answers (a) (well, it _would_ have answered (a)., except you
> actually didn't even read Eric's report of existing bugs).
> 
> What is your answer to (b)-(c)?

So far we had two attempts at converting netfilter rules to bpf. Both ended up
with user space implementation and short cuts. bpf side didn't have loops and
couldn't support 10k+ rules. That is what stalled the effort. imo it's a
pointless corner case, but to be a true replacement people kept bringing it up
as something valid. Now we have bpf iterator concept and soon bpf will be able
to handle millions of rules. Also folks are also realizing that this effort has
to be project managed appropriately. Will it materialize in patches tomorrow?
Unlikely. Probably another 6 month at least. Also outside of netfilter
conversion we've started /proc extension effort that will use the same umh
facility. It won't be ready tomorrow as well, but both need umh. initrd is not
an option due to operational constraints. We need a way to ship kernel tarball
where bpf things are ready at boot. I suspect /proc extensions patches will
land sooner. Couple month ago people used umh to do ovs->xdp translatation. It
didn't land. People argued that the same thing can be achieved in user space
and they were correct. So you're right that for most folks user space is the
answer. But there are cases where kernel has to have these things before
systemd starts.
