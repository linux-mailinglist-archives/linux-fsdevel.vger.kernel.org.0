Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07701F1D2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgFHQXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbgFHQXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:23:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFDEC08C5C2;
        Mon,  8 Jun 2020 09:23:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so8768536pfb.1;
        Mon, 08 Jun 2020 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCsFdLXt1BB0w6XfcsAkMgbKHxPxitxcHb46WOOiYJc=;
        b=iCufn9ObFP1NoHEHNKUPWOHwsZALGl978RUaiNI/uMeN13bMmyXe7yBWfNSaaXvSKw
         q/bfIV6UkQKETZY/qBxSm2G/41xLFUJJZ5I4ZsbdFM2NndYIxUOolSCHKm79ILN38EKc
         PLQtMoYyz2e1A9YFSYlNIQpgWhcqQIbpDoMmTsUcIagtWRnQB8pWBIGjSHQf9RbDJsTC
         E+nliBt1Xp8E5tJd5Z5I9wYH040vrXejL9pVa4CBnP9ACkvugClDL11/tXvaQVRqCCdK
         bFCBiOneoThvKyo06efrMRBCZyNFNNscx0r91/pgarSEpVbp5D7WENUdonGTJs+UUeP7
         e20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCsFdLXt1BB0w6XfcsAkMgbKHxPxitxcHb46WOOiYJc=;
        b=FpApw2Zki1VN+oSpLSMVQP+Ys8/fSyxTF7ezRKERam8nBM+GmZdSPzbrYgqevy6d13
         djsc61QXF2fXFQKj1rAMc5MsPo9L16QPax7LaVvvsq9ElzXH0sco0p1a0xhjnsrFjU3F
         Odk3sjp6MIb+iQfiIkReRffffUCRo78goXYYySxRxSXTKOm35fPhYUA9wZOcYyFPLC+N
         AdZ64sl9V/PudEuaEtCkSR4vRdsUkc/Rt6R23w9kH1qjtiUZHBoI0pSBfK/udTxM3rNG
         oidvrDJSVJ8Uctr2jy6GUpoiAogFxu2IBACqssJHNCDkkh1yZJHgjRr2b/Dgns1gJwHx
         RuOA==
X-Gm-Message-State: AOAM531D3zNqkOij0mTt+xTBCoEfV1iqtINqdcVzG5WSc1PtrSiMdbx/
        UGa+lE4ylxS7vUiMKXAn29I=
X-Google-Smtp-Source: ABdhPJwVZgaECLHZMmFmnI1si0sQDYB37I6OzN54js5c5zngO9s6l6TT/HHMeba3mH1uB4Nfx2ZgGg==
X-Received: by 2002:a63:1460:: with SMTP id 32mr21326590pgu.334.1591633390092;
        Mon, 08 Jun 2020 09:23:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id w12sm6745247pfn.68.2020.06.08.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:23:09 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:23:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 11:31:05AM +0900, Tetsuo Handa wrote:
> On 2020/06/07 10:49, Alexei Starovoitov wrote:
> > So you're right that for most folks user space is the
> > answer. But there are cases where kernel has to have these things before
> > systemd starts.
> 
> Why such cases can't use init= kernel command line argument?
> The program specified via init= kernel command line argument can do anything
> before systemd (a.k.a. global init process) starts.
> 
> By the way, from the LSM perspective, doing a lot of things before global init
> process starts is not desirable, for access decision can be made only after policy
> is loaded (which is generally when /sbin/init on a device specified via root=
> kernel command line argument becomes ready). Since
> fork_usermode_blob((void *) "#!/bin/true\n", 12, info) is possible, I worry that
> the ability to start userspace code is abused for bypassing dentry/inode-based
> permission checks.

bpf_lsm is that thing that needs to load and start acting early.
It's somewhat chicken and egg. fork_usermode_blob() will start a process
that will load and apply security policy to all further forks and execs.
