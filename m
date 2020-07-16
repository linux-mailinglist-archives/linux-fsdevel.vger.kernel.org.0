Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A762223A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgGPNOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:14:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726898AbgGPNOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594905271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+p4nJ/UDFCGkNjtg3O2DtQP+uTraJWRONDYnyAlq7To=;
        b=WbNxfoDILOb1CPMpMOxvr29RjQd7Xw8yLEYoKy5jbSvlUClBnWo8uWiP37x4zHIrBYHKKd
        EYOmf3Zxtxty8eHe69y/eaKUeuEf8hy0/mgTwFb6lk3DNoKQ0XuBCInNdj7yK61X5tsF+d
        Oa8jkS4f3oWQ9HFO4cn8GGHXqc9hP9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-EVLSB4OwPj62yOTgrxrEWw-1; Thu, 16 Jul 2020 09:14:29 -0400
X-MC-Unique: EVLSB4OwPj62yOTgrxrEWw-1
Received: by mail-wr1-f70.google.com with SMTP id i12so5480542wrx.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+p4nJ/UDFCGkNjtg3O2DtQP+uTraJWRONDYnyAlq7To=;
        b=A9/FwCCKzPvwf8DgLmwpk0q7+pVklp7y+GHhN1WRnH9kdCyga9xImmEWC/OcOBIdoQ
         XZC4NF3cFRRqpVw2bva7lreYhLYfm5kdPAhsc839M3EKkZ/MvzYqBxURY1QfNKdzv5xG
         hnfLff3NO0w7oOjTxxau0FcN30mfkmPwAUafOAMGUDQbKaRUc1I2qEQQmqeu5WIZdfKP
         hgHqLoPBu1PbjeKZM7RjfAl1ukZ96eWIyg78rMeLuDue7QwTWf3i9RE3/PLzLBY/g5C8
         0m7wfk+FPbnDS7eXQZ+qr5Ebo3EoMxc4khNNMmDijLS57yE7ANr4NfWWsrt1yGjcf4uK
         mpIA==
X-Gm-Message-State: AOAM533OPP7WJvQUBUpNOZyRNxfpkL5NhpxO9PrV2JAHNDnbIZSRCNW7
        bB1Dkjf2FDNJL4JmVOqSvk2KIRXEuRP/3FN476Cobtgk0U4wXU6uJev8ss43Iawod/UA5Ped6jJ
        R9DGcbGkQ3ExQQUU2BhrhBv5VQA==
X-Received: by 2002:adf:8562:: with SMTP id 89mr5445813wrh.57.1594905268199;
        Thu, 16 Jul 2020 06:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxk2ONqZM/giU7LUtt3SF0j6z6LniRw568qvqnwwiUwNa233ZtIKKANHf1ClCRkMfrdbNFHQ==
X-Received: by 2002:adf:8562:: with SMTP id 89mr5445781wrh.57.1594905267874;
        Thu, 16 Jul 2020 06:14:27 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id n3sm8500478wrm.87.2020.07.16.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:14:27 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:14:04 +0200
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
Message-ID: <20200716131404.bnzsaarooumrp3kx@steredhat>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202007151511.2AA7718@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Cc Stefan Hajnoczi

On Wed, Jul 15, 2020 at 04:07:00PM -0700, Kees Cook wrote:
> Earlier Andy Lutomirski wrote:
> > Let’s add some seccomp folks. We probably also want to be able to run
> > seccomp-like filters on io_uring requests. So maybe io_uring should call into
> > seccomp-and-tracing code for each action.
> 
> Okay, I'm finally able to spend time looking at this. And thank you to
> the many people that CCed me into this and earlier discussions (at least
> Jann, Christian, and Andy).
> 

[...]

> 
> Speaking to Stefano's proposal[1]:
> 
> - There appear to be three classes of desired restrictions:
>   - opcodes for io_uring_register() (which can be enforced entirely with
>     seccomp right now).
>   - opcodes from SQEs (this _could_ be intercepted by seccomp, but is
>     not currently written)
>   - opcodes of the types of restrictions to restrict... for making sure
>     things can't be changed after being set? seccomp already enforces
>     that kind of "can only be made stricter"

In addition we want to limit the SQEs to use only the registered fd and buffers.

> 
> - Credentials vs no_new_privs needs examination (more on this later)
> 
> So, I think, at least for restrictions, seccomp should absolutely be
> the place to get this work done. It already covers 2 of the 3 points in
> the proposal.

Thanks for your feedback, I just sent v2 before I read this e-mail.

Do you think it's better to have everything in seccomp instead of adding
the restrictions in io_uring (the patch isn't very big)?

With seccomp, would it be possible to have different restrictions for two
instances of io_uring in the same process?
I suppose it should be possible using BPF filters.

Thanks,
Stefano

> 
> Solving the mapping of seccomp interception types into CQEs (or anything
> more severe) will likely inform what it would mean to map ptrace events
> to CQEs. So, I think they're related, and we should get seccomp hooked
> up right away, and that might help us see how (if) ptrace should be
> attached.
> 
> Specifically for seccomp, I see at least the following design questions:
> 
> - How does no_new_privs play a role in the existing io_uring credential
>   management? Using _any_ kind of syscall-effective filtering, whether
>   it's seccomp or Stefano's existing proposal, needs to address the
>   potential inheritable restrictions across privilege boundaries (which is
>   what no_new_privs tries to eliminate). In regular syscall land, this is
>   an issue when a filter follows a process through setuid via execve()
>   and it gains privileges that now the filter-creator can trick into
>   doing weird stuff -- io_uring has a concept of alternative credentials
>   so I have to ask about it. (I don't *think* there would be a path to
>   install a filter before gaining privilege, but I likely just
>   need to do my homework on the io_uring internals. Regardless,
>   use of seccomp by io_uring would need to have this issue "solved"
>   in the sense that it must be "safe" to filter io_uring OPs, from a
>   privilege-boundary-crossing perspective.
> 
> - From which task perspective should filters be applied? It seems like it
>   needs to follow the io_uring personalities, as that contains the
>   credentials. (This email is a brain-dump so far -- I haven't gone to
>   look to see if that means io_uring is literally getting a reference to
>   struct cred; I assume so.) Seccomp filters are attached to task_struct.
>   However, for v5.9, seccomp will gain a more generalized get/put system
>   for having filters attached to the SECCOMP_RET_USER_NOTIF fd. Adding
>   more get/put-ers for some part of the io_uring context shouldn't
>   be hard.
> 
> - How should seccomp return values be applied? Three seem okay:
> 	SECCOMP_RET_ALLOW: do SQE action normally
> 	SECCOMP_RET_LOG: do SQE action, log via seccomp
> 	SECCOMP_RET_ERRNO: skip actions in SQE and pass errno to CQE
>   The rest not so much:
> 	SECCOMP_RET_TRAP: can't send SIGSYS anywhere sane?
> 	SECCOMP_RET_TRACE: no tracer, can't send SIGSYS?
> 	SECCOMP_RET_USER_NOTIF: can't do user_notif rewrites?
> 	SECCOMP_RET_KILL_THREAD: kill which thread?
> 	SECCOMP_RET_KILL_PROCESS: kill which thread group?
>   If TRAP, TRACE, and USER_NOTIF need to be "upgraded" to KILL_THREAD,
>   what does KILL_THREAD mean? Does it really mean "shut down the entire
>   SQ?" Does it mean kill the worker thread? Does KILL_PROCESS mean kill
>   all the tasks with an open mapping for the SQ?
> 
> Anyway, I'd love to hear what folks think, but given the very direct
> mapping from SQE OPs to syscalls, I really think seccomp needs to be
> inserted in here somewhere to maintain any kind of sensible reasoning
> about syscall filtering.
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20200710141945.129329-3-sgarzare@redhat.com/
> 
> -- 
> Kees Cook
> 

