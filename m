Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE3214B16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGEIOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 04:14:42 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:48028 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgGEIOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 04:14:42 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jul 2020 04:14:42 EDT
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 1E45E1A401F9; Sun,  5 Jul 2020 01:07:15 -0700 (PDT)
Date:   Sun, 5 Jul 2020 01:07:14 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705080714.76m64pwwpvlzji2v@shells.gnugeneration.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705032732.GT25523@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 04:27:32AM +0100, Matthew Wilcox wrote:
> On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > You should probably take a look at io_uring.  That has the level of
> > > complexity of this proposal and supports open/read/close along with many
> > > other opcodes.
> > 
> > Then glibc can implement readfile using io_uring and there is no need
> > for a new single-file readfile syscall.
> 
> It could, sure.  But there's also a value in having a simple interface
> to accomplish a simple task.  Your proposed API added a very complex
> interface to satisfy needs that clearly aren't part of the problem space
> that Greg is looking to address.

I disagree re: "aren't part of the problem space".

Reading small files from procfs was specifically called out in the
rationale for the syscall.

In my experience you're rarely monitoring a single proc file in any
situation where you care about the syscall overhead.  You're
monitoring many of them, and any serious effort to do this efficiently
in a repeatedly sampled situation has cached the open fds and already
uses pread() to simply restart from 0 on every sample and not
repeatedly pay for the name lookup.

Basically anything optimally using the existing interfaces for
sampling proc files needs a way to read multiple open file descriptors
in a single syscall to move the needle.

This syscall doesn't provide that.  It doesn't really give any
advantage over what we can achieve already.  It seems basically
pointless to me, from a monitoring proc files perspective.

Regards,
Vito Caputo
