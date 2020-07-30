Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3059233536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgG3PUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:20:49 -0400
Received: from verein.lst.de ([213.95.11.211]:56324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3PUt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:20:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A347568BEB; Thu, 30 Jul 2020 17:20:46 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:20:46 +0200
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
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for
 files having ->read_iter
Message-ID: <20200730152046.GA21192@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-23-hch@lst.de> <20200730000544.GC1236929@ZenIV.linux.org.uk> <20200730070329.GB18653@lst.de> <20200730150826.GA1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730150826.GA1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:08:26PM +0100, Al Viro wrote:
> > I think we need to fix that in the instances, as we really expect
> > ->splice_read to just work instead of the caller knowing what could
> > work and what might not.
> 
> Er...  generic_file_splice_read() is a library helper; the decision to use
> is up to the filesystem/driver/protocol in question, and so's making sure
> it's not used with ->read_iter() that isn't fit for it.

Yes, but..  The problem is that while right now generic_file_splice_read
is the only user of ITER_PIPE there is absolutely not guarantee that
it remains the only user.  Having ->read_iter instances lingering that
can't deal with it is at best a mine field waiting for victims.

Fortunately I think the fix is pretty easy - remove the special pipe
zero copy optimization from copy_page_to_iter, and just have the
callers actually want it because they have pagecache or similar
refcountable pages use it explicitly for the ITER_PIPE case.  That gives
us a safe default with an opt-in into the optimized variant.  I'm
currently auditing all the users of for how it is used and that looks
pretty promising.

> Note that we *do* have instances where we have different ->splice_read()
> (sometimes using generic_file_splice_read(), sometimes not) even though
> ->read_iter() is there.
> 
> Your patch ignores those (thankfully), but commit message is rather
> misleading - it strongly implies that generic_file_splice_read() is
> *always* the right thing when ->read_iter() is there, not just that
> in such cases it makes a better fallback than default_file_splice_read().

I don't think it always is right.  Not without a major audit and more
work at least.
