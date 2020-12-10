Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146F12D6A09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 22:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbgLJVh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405007AbgLJVhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:37:17 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B8C0613D6;
        Thu, 10 Dec 2020 13:36:36 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knTbs-000PdG-F8; Thu, 10 Dec 2020 21:36:24 +0000
Date:   Thu, 10 Dec 2020 21:36:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Subject: Re: [PATCH] files: rcu free files_struct
Message-ID: <20201210213624.GT3579531@ZenIV.linux.org.uk>
References: <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
 <20201209195033.GP3579531@ZenIV.linux.org.uk>
 <87sg8er7gp.fsf@x220.int.ebiederm.org>
 <20201210061304.GS3579531@ZenIV.linux.org.uk>
 <87h7oto3ya.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7oto3ya.fsf@x220.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:29:01PM -0600, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:

> > What are the users of that thing and is there any chance to replace it
> > with something saner?  IOW, what *is* realistically called for each
> > struct file by the users of that iterator?
> 
> The bpf guys are no longer Cc'd and they can probably answer better than
> I.
> 
> In a previous conversation it was mentioned that task_iter was supposed
> to be a high performance interface for getting proc like data out of the
> kernel using bpf.
> 
> If so I think that handles the lifetime issues as bpf programs are
> supposed to be short-lived and can not pass references anywhere.
> 
> On the flip side it raises the question did the BPF guys just make the
> current layout of task_struct and struct file part of the linux kernel
> user space ABI?

An interesting question, that...  For the record: anybody coming to
complain about a removed/renamed/replaced with something else field
in struct file will be refered to Figure 1.

None of the VFS data structures has any layout stability warranties.
If BPF folks want access to something in that, they are welcome to come
and discuss the set of accessors; so far nothing of that sort has happened.

Direct access to any fields of any of those structures is subject to
being broken at zero notice.

IMO we need some notation for a structure being off-limits for BPF, tracing,
etc., along the lines of "don't access any field directly".
