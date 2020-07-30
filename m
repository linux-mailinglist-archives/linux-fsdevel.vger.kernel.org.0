Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B14A232C32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgG3HCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 03:02:22 -0400
Received: from verein.lst.de ([213.95.11.211]:54761 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgG3HCV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:02:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 334FE68AFE; Thu, 30 Jul 2020 09:02:18 +0200 (CEST)
Date:   Thu, 30 Jul 2020 09:02:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/23] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200730070218.GA18653@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-9-hch@lst.de> <20200729205036.GA1236929@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729205036.GA1236929@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 29, 2020 at 09:50:36PM +0100, Al Viro wrote:
> On Tue, Jul 07, 2020 at 07:47:46PM +0200, Christoph Hellwig wrote:
> > If we write to a file that implements ->write_iter there is no need
> > to change the address limit if we send a kvec down.  Implement that
> > case, and prefer it over using plain ->write with a changed address
> > limit if available.
> 
> 	You are flipping the priorities of ->write and ->write_iter
> for kernel_write().

Note by the end of the series (and what's been in linux-next for a while
now) there is no order, as kernel_write only uses ->write_iter, so a
few patches later this kinda becomes moot point.

> Now, there are 4 instances of file_operations
> where we have both.  null_fops and zero_fops are fine either way -
> ->write() and ->write_iter() do the same thing there (and arguably
> removing ->write might be the right thing; the only reason I hesistate
> is that writing to /dev/null *is* critical for many things, including
> the proper mail delivery ;-)
> 
> However, the other two (infinibarf and pcm) are different; there we
> really have different semantics.  I don't believe anything writes into
> either under KERNEL_DS, but having kernel_write() and vfs_write() with
> subtly different semantics is asking for trouble down the road.
> 
> How about we remove ->write in null_fops/zero_fops and fail loudly if
> *both* ->write() and ->write_iter() are present (in kernel_write(),
> that is)?

I'm fine with removing plain ->write for /dev/null and /dev/zero, as
that seems the right thing to do.

Failing the kernel ops if both are present sounds fine, I'm not sure
about the loud part as it could be user triggered through splice.  I'd
go for the same kind of noticable not loud warning that we have for
the lack of iter ops in kernel_read/write.

> There's a similar situation on the read side - there we have /dev/null
> with both ->read() and ->read_iter() (and there "remove ->read" is
> obviously the right thing to do) *and* we have pcm crap, with different
> semantics for ->read() and ->read_iter().
