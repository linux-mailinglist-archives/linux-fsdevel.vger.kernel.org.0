Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B343822366E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGQICM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 04:02:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726793AbgGQICH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594972925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rcr/B0+uYonvATiDQC4F/S5E0Ijrw2tibP+/iOy0GA=;
        b=XZ2XpCaN7n1hJb59UM/TPg6z8Ji6CeIEDNG0g542TSAnwsw6gmc9G1EWOhRNC+e1iPGrmV
        Mysv9/SgK0Ln4fEe9rpKGZ7p8jWtW0eigthAeQbelUrutqlpxfMGyc+pNcOJLVNqaQgAbE
        xSgYinJyGfaE3t8ChtTyyLULzsK4e9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-vWMnDARBN6iJOlJ7hrHkhQ-1; Fri, 17 Jul 2020 04:02:03 -0400
X-MC-Unique: vWMnDARBN6iJOlJ7hrHkhQ-1
Received: by mail-wr1-f69.google.com with SMTP id o25so8244000wro.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 01:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rcr/B0+uYonvATiDQC4F/S5E0Ijrw2tibP+/iOy0GA=;
        b=VogiVbTvoU3qRNdSk/7FWYzAYLCPIydLEQmDJOrO5NQjT9tjwlK0lC6QEPFppfuRhX
         LIsYYblL89Y9W3Ccht+XNrhMxhzuO0LHT8WlAGEv0iclgIqf+UB9uE2lS9jXK6gwc6w/
         6NvY+YuPWjoTYIJDzN+XWcFouaYA6BTQzvV5x6TAh06jIlSpigvvKja6Ssc6Fm2iRac1
         te+Arjri7CoTSgd34pNmvcMo2qhV0Vx6+RZq0uccny9cRNjBu+vzuPoX+F7oNTIzsZ0I
         kXe1PIkiZnUrlJ0lKCVCUSFFiwLKMtaHFvGzYreZUyxFWc9t40JnSISL3kCQL7gjizw3
         ZPoA==
X-Gm-Message-State: AOAM5308PbrZdczuGJPejqz4VJ5gzPzP9VGKV/mHJacFMaPZxgW2wSbx
        ILkZSpN1MG7ryX8JpZAgQ1hXtbTS8cpOaRldmECZYeWoSwmDACssN93ce5Yrnc+Ou3NMEY/Jcif
        JLI2ZlyuIcwOnhuBFCrDOZh8jqg==
X-Received: by 2002:a05:600c:2483:: with SMTP id 3mr7936041wms.120.1594972922232;
        Fri, 17 Jul 2020 01:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5lUscsVqkDpbm7EZ6xTIOuN95u1Ppt2CEYvOEPZ/iTjER1w+8Y5Lg8za60AnhINO8FcW2lg==
X-Received: by 2002:a05:600c:2483:: with SMTP id 3mr7936008wms.120.1594972921869;
        Fri, 17 Jul 2020 01:02:01 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id a123sm12380160wmd.28.2020.07.17.01.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:02:01 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:01:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <20200717080157.ezxapv7pscbqykhl@steredhat.lan>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131404.bnzsaarooumrp3kx@steredhat>
 <202007160751.ED56C55@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007160751.ED56C55@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 08:12:35AM -0700, Kees Cook wrote:
> On Thu, Jul 16, 2020 at 03:14:04PM +0200, Stefano Garzarella wrote:
> > On Wed, Jul 15, 2020 at 04:07:00PM -0700, Kees Cook wrote:
> > [...]
> > 
> > > Speaking to Stefano's proposal[1]:
> > > 
> > > - There appear to be three classes of desired restrictions:
> > >   - opcodes for io_uring_register() (which can be enforced entirely with
> > >     seccomp right now).
> > >   - opcodes from SQEs (this _could_ be intercepted by seccomp, but is
> > >     not currently written)
> > >   - opcodes of the types of restrictions to restrict... for making sure
> > >     things can't be changed after being set? seccomp already enforces
> > >     that kind of "can only be made stricter"
> > 
> > In addition we want to limit the SQEs to use only the registered fd and buffers.
> 
> Hmm, good point. Yeah, since it's an "extra" mapping (ioring file number
> vs fd number) this doesn't really map well to seccomp. (And frankly,
> there's some difficulty here mapping many of the ioring-syscalls to
> seccomp because it's happening "deeper" than the syscall layer (i.e.
> some of the arguments have already been resolved into kernel object
> pointers, etc).
> 
> > Do you think it's better to have everything in seccomp instead of adding
> > the restrictions in io_uring (the patch isn't very big)?
> 
> I'm still trying to understand how io_uring will be used, and it seems
> odd to me that it's effectively a seccomp bypass. (Though from what I
> can tell it is not an LSM bypass, which is good -- though I'm worried
> there might be some embedded assumptions in LSMs about creds vs current
> and LSMs may try to reason (or report) on actions with the kthread in
> mind, but afaict everything important is checked against creds.
> 
> > With seccomp, would it be possible to have different restrictions for two
> > instances of io_uring in the same process?
> 
> For me, this is the most compelling reason to have the restrictions NOT
> implemented via seccomp. Trying to make "which instance" choice in
> seccomp would be extremely clumsy.
> 
> So at this point, I think it makes sense for the restriction series to
> carry on -- it is io_uring-specific and solves some problems that
> seccomp is not in good position to reason about.

Thanks for the feedback, then I'll continue in this direction!

> 
> All this said, I'd still like a way to apply seccomp to io_uring
> because it's a rather giant syscall filter bypass mechanism, and gaining

Agree.

> access (IIUC) is possible without actually calling any of the io_uring
> syscalls. Is that correct? A process would receive an fd (via SCM_RIGHTS,
> pidfd_getfd, or soon seccomp addfd), and then call mmap() on it to gain
> access to the SQ and CQ, and off it goes? (The only glitch I see is
> waking up the worker thread?)

It is true only if the io_uring istance is created with SQPOLL flag (not the
default behaviour and it requires CAP_SYS_ADMIN). In this case the
kthread is created and you can also set an higher idle time for it, so
also the waking up syscall can be avoided.

> 
> What appears to be the worst bit about adding seccomp to io_uring is the
> almost complete disassociation of process hierarchy from syscall action.
> Only a cred is used for io_uring, and seccomp filters are associated with
> task structs. I'm not sure if there is a way to solve this disconnect
> without a major internal refactoring of seccomp to attach to creds and
> then make every filter attachment create a new cred... *head explody*
> 

Sorry but I don't know seccomp that well :-(
I'm learning a lot about it these days. I'll keep your concern in mind.

Thanks,
Stefano

