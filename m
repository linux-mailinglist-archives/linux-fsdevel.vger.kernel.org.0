Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C382F23C447
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 06:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHEEIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 00:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHEEII (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:08:08 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE14A206D4;
        Wed,  5 Aug 2020 04:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596600488;
        bh=HdyhYkZHVvgGyG2MkTHbCiM9dx3gDrnSt8EcCs7wWzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMs7/1KTc51gPYGvshIFIQ1e08bUQ/uTtfI5Efo4Zqd5Ym/JpUmkYg4gosDSP/3MI
         lJkZf6rANjr1BiP4QPnWW6wpwHVR1FH5alIDO61CaO/GhkjWC0BUXHeEToTo+MbIxl
         8W64+GYAMuwigKKztiO0dyMxENwMLxuHNEDHk2uI=
Date:   Tue, 4 Aug 2020 21:08:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>, viro@zeniv.linux.org.uk,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        jmorris@namei.org, kaleshsingh@google.com, dancol@dancol.org,
        surenb@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nnk@google.com, jeffv@google.com,
        calin@google.com, kernel-team@android.com, yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
Message-ID: <20200805040806.GB1136@sol.localdomain>
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200805034758.lrobunwdcqtknsvz@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805034758.lrobunwdcqtknsvz@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 01:47:58PM +1000, Aleksa Sarai wrote:
> On 2020-08-04, Lokesh Gidra <lokeshgidra@google.com> wrote:
> > when get_unused_fd_flags returns error, ctx will be freed by
> > userfaultfd's release function, which is indirectly called by fput().
> > Also, if anon_inode_getfile_secure() returns an error, then
> > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > 
> > Also, the O_CLOEXEC was inadvertently added to the call to
> > get_unused_fd_flags() [1].
> 
> I disagree that it is "wrong" to do O_CLOEXEC-by-default (after all,
> it's trivial to disable O_CLOEXEC, but it's non-trivial to enable it on
> an existing file descriptor because it's possible for another thread to
> exec() before you set the flag). Several new syscalls and fd-returning
> facilities are O_CLOEXEC-by-default now (the most obvious being pidfds
> and seccomp notifier fds).

Sure, O_CLOEXEC *should* be the default, but this is an existing syscall so it
has to keep the existing behavior.

> At the very least there should be a new flag added that sets O_CLOEXEC.

There already is one (but these patches broke it).

- Eric
