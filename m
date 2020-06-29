Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1651920D44C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgF2TG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:06:59 -0400
Received: from verein.lst.de ([213.95.11.211]:59051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbgF2TGf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1ED6168C65; Mon, 29 Jun 2020 17:29:13 +0200 (CEST)
Date:   Mon, 29 Jun 2020 17:29:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200629152912.GA26172@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:33:03AM -0700, Linus Torvalds wrote:
> I thought there was just one very specific case of "oh, in certain
> cases of setsockopt we don't know what size this address is and optlen
> is ignored", so we have to just pass the pointer down to the protocol,
> which is the point that knows how much of an address it wants..

The setsock issue is a little more complicated.  Let me try to summarize
it:

 - setsock takes a (user) pointer and len
 - unfortunately while the designed of the BSD socket API designed the
   len to be correct some protocol implementations have been sloppy
   and just use a hardcoded len for the value plus some other funnies
 - unfortunately there is some BPF magic that can attach to a socket
   and be run, and that (and only that in the latest kernel) can cause
   a setsockopt to take a kernel buffer.  One that was copied from
   userspace earlier and had the BPF program run on it.
 - unfortunately we have about 90 ->setsockopt instances, and the BPF
   hook is not specific to one particular of them.  In fact the
   BPF program can run for options that don't even exist, and based on
   my previous dicussion Facebook has setups that rely on that.

> Was that a misunderstanding on my part?
> 
> Because if there are tons and tons of places that want this "either
> kernel or user" then we could still have a helper function for it, but
> it means that the whole "limit the cases" advantage to some degree
> goes away.

But except for setsockopt we don't really have anything like that left.
There is some alpha arch code that would need to be duplicated for
user vs kernel pointers, but I suspect it will get cleaner by that,
and the messy s390 crypto driver whіch will be a bit of work, but all
internal to that driver.

So based on that I'd rather get away without our flag and tag the
kernel pointer case in setsockopt explicitly.
