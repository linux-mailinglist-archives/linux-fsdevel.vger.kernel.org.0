Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66297207AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405864AbgFXRyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405750AbgFXRyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:54:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92009C061573;
        Wed, 24 Jun 2020 10:54:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so1446099pje.4;
        Wed, 24 Jun 2020 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkIGmRvWdpvpHWZiXHmBkZ272P9SkiCAZcuaQC1DR14=;
        b=EP2vP1xji6pfUVDlXaugEghw2F92U4Nkz06IgV2PEZGPI7N9buIZ5/e6VeSeDGwNs9
         qvaOn2JuNtYGl/lO9wde2fwNqSF25+mLosYSQrpovtkD2OpgITU6sMjuzIb7TPuBMpl+
         hYAUlPbUE+UCvJ21x8Ymg4oMl/ejjDGPihy6PXoC733JRbqAvXi3ASgShVzST2HJlkX/
         bSes6nXdsi6s8sllYMUoxBmf42T32IqZCC7gGdtEN3H2JtRXCHrDe/PG9fov8W8Dlfyr
         9guNeDjDA9qFv8zQzadgHr0pbyBkJ/PLW+7t57GRJNWFSptJzJDJcWnn+9aJQ8Hy4rFy
         68VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkIGmRvWdpvpHWZiXHmBkZ272P9SkiCAZcuaQC1DR14=;
        b=UiL7mCDLWUya98H0TOEcF2J4xJkwMqyMRYMKapzRgg5KuZ61h41w5MzQDJCKLOo2eO
         fJBM3jthYQEnAv+ziHIbAl8Tg3+4WB9NYAt4E2rvwhSONqmYvqhGtgCKActqA3X9SNx7
         K3kZ15uFizoZg8D7Vdh5fTrL5E8rmgA8giG0YmJIZ5h019jGm4dpU7S41GgM8Me2+D9m
         J3HPhbETGC2cQf7lrQjVoGG9bVEYxanXrwPoYzW2URiWH2cUqVVWpdnpkLbtVBm9C3ze
         9hZGUw8bcaiymwCv17uvAuk/y6ZNe5iouLwhPDZ8Qcairq8Rcm2Iu2PQlItnx2eYV3dq
         viWw==
X-Gm-Message-State: AOAM5330I+5bY1p7PmXTta5pymI56OjiudWo2RbiVQjvyRlUqDdwTsat
        h9Y6GgSPtAIKeZLMDVHhj9nw6DBR
X-Google-Smtp-Source: ABdhPJxrBCQujbDJG/wG2RTZOr8JlWcKTxN8MVE5jK8kMoXC8OVOMg9sN8RbTWAjb7YmBTk+Al/tlA==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr26942728plk.275.1593021252980;
        Wed, 24 Jun 2020 10:54:12 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:d17e])
        by smtp.gmail.com with ESMTPSA id f207sm5491841pfa.107.2020.06.24.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:54:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:54:08 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200624175408.kwc562ofnfhmy674@ast-mbp.dhcp.thefacebook.com>
References: <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
 <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
 <20200624063940.ctzhf4nnh3cjyxqi@ast-mbp.dhcp.thefacebook.com>
 <321b85b4-95f0-2f9b-756a-8405adc97230@i-love.sakura.ne.jp>
 <748ef005-7f64-ab9b-c767-c617ec995df4@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748ef005-7f64-ab9b-c767-c617ec995df4@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:41:37AM -0700, Casey Schaufler wrote:
> On 6/24/2020 12:05 AM, Tetsuo Handa wrote:
> > Forwarding to LSM-ML again. Any comments?
> 
> Hey, BPF folks - you *really* need to do better about keeping the LSM
> community in the loop when you're discussing LSM issues. 
> 
> >
> > On 2020/06/24 15:39, Alexei Starovoitov wrote:
> >> On Wed, Jun 24, 2020 at 01:58:33PM +0900, Tetsuo Handa wrote:
> >>> On 2020/06/24 13:00, Alexei Starovoitov wrote:
> >>>>> However, regarding usermode_blob, although the byte array (which contains code / data)
> >>>>> might be initially loaded from the kernel space (which is protected), that byte array
> >>>>> is no longer protected (e.g. SIGKILL, strace()) when executed because they are placed
> >>>>> in the user address space. Thus, LSM modules (including pathname based security) want
> >>>>> to control how that byte array can behave.
> >>>> It's privileged memory regardless. root can poke into kernel or any process memory.
> >>> LSM is there to restrict processes running as "root".
> >> hmm. do you really mean that it's possible for an LSM to restrict CAP_SYS_ADMIN effectively?
> 
> I think that SELinux works hard to do just that. SELinux implements it's own
> privilege model that is tangential to the capabilities model.

of course. no argument here.

> More directly, it is simple to create a security module to provide finer privilege
> granularity than capabilities. I have one lurking in a source tree, and I would
> be surprised if it's the only one waiting for the next round of LSM stacking.

no one is arguing with that either.

> 
> >> LSM can certainly provide extra level of foolproof-ness against accidental
> >> mistakes, but it's not a security boundary.
> 
> Gasp! Them's fight'n words. How do you justify such an outrageous claim?

.. for root user processes.
What's outrageous about that?
Did you capture the context or just replying to few sentences out of the context?
