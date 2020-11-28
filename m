Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F652C6EEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 06:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgK1FOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 00:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgK1FN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 00:13:26 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15771C0613D1;
        Fri, 27 Nov 2020 21:12:48 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kisX4-00F0ax-Iz; Sat, 28 Nov 2020 05:12:26 +0000
Date:   Sat, 28 Nov 2020 05:12:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 00/24] exec: Move unshare_files and guarantee
 files_struct.count is correct
Message-ID: <20201128051226.GA3577182@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wge0oJ3fbmNfVek101CO7hg1UfUHnBgxLB3Jmq6-hWLug@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:05:47PM -0800, Linus Torvalds wrote:
> On Fri, Nov 20, 2020 at 3:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > This set of changes cleanups of the code in exec so hopefully this code
> > will not regress again.  Then it adds helpers and fixes the users of
> > files_struct so the reference count is only incremented if COPY_FILES is
> > passed to clone (or if io_uring takes a reference).  Then it removes
> > helpers (get_files_struct, __install_fd, __alloc_fd, __close_fd) that
> > are no longer needed and if used would encourage code that increments
> > the count of files_struct somewhere besides in clone when COPY_FILES is
> > passed.
> 
> I'm not seeing anything that triggered me going "that looks dodgy". It
> all looks like nice cleanups.
> 
> But that's just from reading the patches (and in some cases going and
> looking at the context), so I didn't actually _test_ any of it. It all
> looks sane to me, though, and the fact that it removes a fair number
> of lines of code is always a good sign.
> 
> It would be good for people to review and test (Al? Oleg? others?),
> but my gut feel is "this is good".

Will check (sorry, the last couple of weeks had been bloody awful -
off-net and very short on sleep); I'm digging through the piles of
email right now.
