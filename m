Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E361207B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405726AbgFXSOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:14:40 -0400
Received: from verein.lst.de ([213.95.11.211]:45497 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405119AbgFXSOk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:14:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6C1668B02; Wed, 24 Jun 2020 20:14:37 +0200 (CEST)
Date:   Wed, 24 Jun 2020 20:14:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624181437.GA26277@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:11:50AM -0700, Linus Torvalds wrote:
> What I mean was *not* something like uptr_t.
> 
> Just keep the existing "set_fs()". It's not harmful if it's only used
> occasionally. We should rename it once it's rare enough, though.
> 
> Then, make the following changes:
> 
>  - all the normal user access functions stop caring. They use
> TASK_SIZE_MAX and are done with it. They basically stop reacting to
> set_fs().
> 
>  - then, we can have a few *very* specific cases (like setsockopt,
> maybe some random read/write) that we teach to use the new set_fs()
> thing.
> 
> So in *those* cases, we'd basically just do "oh, ok, we are supposed
> to use a kernel pointer" based on the setfs value.
> 
> IOW, I mean tto do something much more gradual. No new interfaces, no
> new types, just a couple of (very clearly marked!) cases of the legacy
> set_fs() behavior.

So we'd need new user copy functions for just those cases, and make
sure everything below the potential get_fs-NG uses them.  But without
any kind of tape safety to easily validate all users below actually
use them?  I just don't see how that makes sense.

FYI, I think the only users where we really need it are setsockopt
and a s390-specific driver from my audits so far.  Everything else
shouldn't need anything like that.
