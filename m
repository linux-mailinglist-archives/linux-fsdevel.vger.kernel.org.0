Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB12D6B95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgLJXJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:09:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54045 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbgLJWbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:31:16 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1knUS9-0002PV-EF; Thu, 10 Dec 2020 22:30:25 +0000
Date:   Thu, 10 Dec 2020 23:30:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210223024.hi2zlluqqxcdaod4@wittgenstein>
References: <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
 <20201209195033.GP3579531@ZenIV.linux.org.uk>
 <87sg8er7gp.fsf@x220.int.ebiederm.org>
 <20201210061304.GS3579531@ZenIV.linux.org.uk>
 <87h7oto3ya.fsf@x220.int.ebiederm.org>
 <20201210213624.GT3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210213624.GT3579531@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:36:24PM +0000, Al Viro wrote:
> On Thu, Dec 10, 2020 at 01:29:01PM -0600, Eric W. Biederman wrote:
> > Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > > What are the users of that thing and is there any chance to replace it
> > > with something saner?  IOW, what *is* realistically called for each
> > > struct file by the users of that iterator?
> > 
> > The bpf guys are no longer Cc'd and they can probably answer better than
> > I.
> > 
> > In a previous conversation it was mentioned that task_iter was supposed
> > to be a high performance interface for getting proc like data out of the
> > kernel using bpf.
> > 
> > If so I think that handles the lifetime issues as bpf programs are
> > supposed to be short-lived and can not pass references anywhere.
> > 
> > On the flip side it raises the question did the BPF guys just make the
> > current layout of task_struct and struct file part of the linux kernel
> > user space ABI?
> 
> An interesting question, that...  For the record: anybody coming to

Imho, they did. An example from the BPF LSM: a few weeks ago someone
asked me whether it would be possible to use the BPF LSM to enforce you
can't open files when they are on a given filesystem. Sine this bpf lsm
allows to attach to lsm hooks, say security_file_open(), you can get at
the superblock and check the filesyste type in a bpf program
(requiring btf), i.e. security_file_open, then follow
file->f_inode->i_sb->s_type->s_magic. If we change the say struct
super_block I'd expect these bpf programs to break. I'm sure there's
something clever that they came up with but it is nonetheless
uncomfortably close to making internal kernel structures part of
userspace ABI indeed.

> complain about a removed/renamed/replaced with something else field
> in struct file will be refered to Figure 1.
> 
> None of the VFS data structures has any layout stability warranties.
> If BPF folks want access to something in that, they are welcome to come
> and discuss the set of accessors; so far nothing of that sort has happened.
> 
> Direct access to any fields of any of those structures is subject to
> being broken at zero notice.
> 
> IMO we need some notation for a structure being off-limits for BPF, tracing,
> etc., along the lines of "don't access any field directly".

Indeed. I would also like to see a list where changes need to be sent
that are technically specific to a subsystem but will necessarily have
kernel-wide impact prime example: a lot of bpf.

Christian
