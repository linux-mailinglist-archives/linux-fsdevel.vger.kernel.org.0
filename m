Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922492D4435
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 15:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgLIOZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 09:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbgLIOZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:25:05 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2665C0613CF;
        Wed,  9 Dec 2020 06:24:24 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn0Nr-0004e7-Se; Wed, 09 Dec 2020 14:24:00 +0000
Date:   Wed, 9 Dec 2020 14:23:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
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
        KP Singh <kpsingh@chromium.org>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH v2 15/24] proc/fd: In proc_readfd_common use
 task_lookup_next_fd_rcu
Message-ID: <20201209142359.GN3579531@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk>
 <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dprtxly.fsf@x220.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:24:57PM -0600, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Tue, Dec 08, 2020 at 04:38:09PM -0600, Eric W. Biederman wrote:
> >
> >> Is there any reason we don't simply rcu free the files_struct?
> >> That would remove the need for the task_lock entirely.
> >
> > Umm...  Potentially interesting part here is the interaction with
> > close_files(); currently that can't overlap with any of those
> > 3rd-party accesses to descriptor table, but with your changes
> > here it's very much possible.
> 
> Good point.
> 
> I was worried there might have been a concern about the overhead
> introduced by always rcu freeing files table.
> 
> > OTOH, it's not like close_files() did much beyond the effects of already
> > possible close(2) done by one of the threads sharing that sucker.
> > It's _probably_ safe (at least for proc_readfd_common()), but I'll need
> > to look at the other places doing that kind of access.  Especially the
> > BPF foulness...

Still digging, unfortunately ;-/

> > Oh, and in any case, the trick with repurposing ->rcu of embedded
> > fdtable deserves a comment.  It's not hard to explain, so...
> 
> Agreed.  Something like fdtable.rcu isn't used so use it so by reusing
> it we keep from wasting memory in files_struct to have a dedicated
> rcu_head.

I'd probably go for something along the lines of "we can avoid adding
a separate rcu_head into files_struct, since rcu_head in struct fdtable
is only used for separately allocated instances, allowing us to repurpose
files_struct->fdtab.rcu for RCU-delayed freeing of files_struct"...
