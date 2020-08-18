Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C4248389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRLGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 07:06:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgHRLGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:06:03 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7zRG-0005Sq-Q5; Tue, 18 Aug 2020 11:05:58 +0000
Date:   Tue, 18 Aug 2020 13:05:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
Message-ID: <20200818110556.q5i5quflrcljv4wa@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
 <875z9g7oln.fsf@x220.int.ebiederm.org>
 <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 06:17:35PM -0700, Linus Torvalds wrote:
> On Mon, Aug 17, 2020 at 6:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > I struggle with the fcheck name as I have not seen or at least not
> > registed on the the user that just checks to see if the result is NULL.
> > So the name fcheck never made a bit of sense to me.
> 
> Yeah, that name is not great. I just don't want to make things even worse.
> 
> > I will see if I can come up with some good descriptive comments around
> > these functions.  Along with describing what these things are doing I am
> > thinking maybe I should put "_rcu" in their names and have a debug check
> > that verifies "_rcu" is held.
> 
> Yeah, something along the lines of "rcu_lookup_fd_task(tsk,fd)" would
> be a *lot* more descriptive than fcheck_task().
> 
> And I think "fnext_task()" could be "rcu_lookup_next_fd_task(tsk,fd)".
> 
> Yes, those are much longer names, but it's not like you end up typing
> them all that often, and I think being descriptive would be worth it.
> 
> And "fcheck()" and "fcheck_files()" would be good to rename too along
> the same lines.
> 
> Something like "rcu_lookup_fd()" and "rcu_lookup_fd_files()" respectively?
> 
> I'm obviously trying to go for a "rcu_lookup_fd*()" kind of pattern,
> and I'm not married to _that_ particular pattern but I think it would
> be better than what we have now.

In fs/inode.c and a few other places we have the *_rcu suffix pattern
already so maybe:

fcheck() -> fd_file_rcu() or lookup_fd_rcu()
fcheck_files() -> fd_files_rcu() or lookup_fd_files_rcu()
fnext_task() -> fd_file_from_task_rcu() or lookup_next_fd_from_task_rcu()

rather than as prefix or sm.

Christian
