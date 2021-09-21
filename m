Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B106413E0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 01:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhIUXfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 19:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhIUXfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:35:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635CCC061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 16:34:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 203so999296pfy.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 16:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CLwXFb9bh237p3NLMPDDN3QcXe2KmKQWVOAqgszlTS8=;
        b=ZvuPio6qyfipioiP/dvGdAsdJVc+VUAkgK2fA/9fKTi893FzD+/qJT1K/0XuvIF7X8
         5Ci6Nj/XWd3iJCThByjK2fo0cqpDqERIE3PCv/LgArpAkqmf80Mlae+qWWJo6x5JyHKa
         VQnECUX7tTC9EY+jo/uOG8Itd3jZixAT3pNOLdICTqpK4H+TmjmL1sV3bpHizrFX5+RK
         mlptqnXrh0TxAMAiWCrjP9OgYeGd6wV+RifJ+nxvtJETCsvHzxtEvI/Bsc9De0BwyBtQ
         bIifOxXSXdx9nQ35PERkINo2ExXvJIC+K9wYXVs8vb1bpSf44QabIrApjQsBuuK+cYc6
         4fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CLwXFb9bh237p3NLMPDDN3QcXe2KmKQWVOAqgszlTS8=;
        b=8EeXglRHr71MNq/EkFWKMv2xqaF9eyrLLSqVDtKHgEaXtx3bQe4nK+timJGV/bx9YS
         aB5ME75vR8+zeF9iGzkI8wUBk68fjnG2KG1GmJeKIrPk/YlCpGT61EHAwUwmWK1qhHra
         FnrjCuy2AeJ5t3Dt7DgKVXET1STIc9lRgnsySUmNLbeItZ0xj5QOYyRWz1101w2w/Ket
         DOFuWwVe+VFYv7LvRO658cewuFRfP2BGG2SSYytrMCidwHPTp5djo5NoT52LtKzwoPKh
         JIiFAQOoVcop8TbDJJMh/peS3rqDPzjPKzDfg1Lx3oUzx34rDj+2or3l/CO94ODqqT2t
         gpdg==
X-Gm-Message-State: AOAM530qacB4ba5nFK2/dLNbB7yE88B2RjfkcF+u/bjss9fQGf6BVCFx
        N6hr/mmLyGkdAozaSQ+clVb8sQ==
X-Google-Smtp-Source: ABdhPJyeyei+KC0c9FO+SEEq5fFZ0WoTeeAjimEYskFd5/X3mugtX1W01HtIQmxapsWcTaEdUsmHZA==
X-Received: by 2002:aa7:9282:0:b0:3e2:800a:b423 with SMTP id j2-20020aa79282000000b003e2800ab423mr32998153pfa.21.1632267253615;
        Tue, 21 Sep 2021 16:34:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g3sm161923pjm.22.2021.09.21.16.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:34:12 -0700 (PDT)
Date:   Tue, 21 Sep 2021 23:34:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in
 kvm_fastop_exception
Message-ID: <YUpr8Vu8xqCDwkE8@google.com>
References: <000000000000d6b66705cb2fffd4@google.com>
 <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
 <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021, Dmitry Vyukov wrote:
> On Fri, 17 Sept 2021 at 13:04, Marco Elver <elver@google.com> wrote:
> > > So it looks like in both cases the top fault frame is just wrong. But
> > > I would assume it's extracted by arch-dependent code, so it's
> > > suspicious that it affects both x86 and arm64...
> > >
> > > Any ideas what's happening?
> >
> > My suspicion for the x86 case is that kvm_fastop_exception is related
> > to instruction emulation and the fault occurs in an emulated
> > instruction?
> 
> Why would the kernel emulate a plain MOV?
> 2a:   4c 8b 21                mov    (%rcx),%r12
> 
> And it would also mean a broken unwind because the emulated
> instruction is in __d_lookup, so it should be in the stack trace.

kvm_fastop_exception is a red herring.  It's indeed related to emulation, and
while MOV emulation is common in KVM, that emulation is for KVM guests not for
the host kernel where this splat occurs (ignoring the fact that the "host" is
itself a guest).

kvm_fastop_exception is out-of-line fixup, and certainly shouldn't be reachable
via d_lookup.  It's also two instruction, XOR+RET, neither of which are in the
code stream.

IIRC, the unwinder gets confused when given an IP that's in out-of-line code,
e.g. exception fixup like this.  If you really want to find out what code blew
up, you might be able to objdump -D the kernel and search for unique, matching
disassembly, e.g. find "jmpq   0xf86d288c" and go from there.
