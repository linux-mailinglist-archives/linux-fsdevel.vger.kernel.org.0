Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4868F23350F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgG3PIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:08:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A694C061574;
        Thu, 30 Jul 2020 08:08:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1AAU-005j5Y-G1; Thu, 30 Jul 2020 15:08:26 +0000
Date:   Thu, 30 Jul 2020 16:08:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for files
 having ->read_iter
Message-ID: <20200730150826.GA1236603@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-23-hch@lst.de>
 <20200730000544.GC1236929@ZenIV.linux.org.uk>
 <20200730070329.GB18653@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730070329.GB18653@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:03:29AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 30, 2020 at 01:05:44AM +0100, Al Viro wrote:
> > On Tue, Jul 07, 2020 at 07:48:00PM +0200, Christoph Hellwig wrote:
> > > If a file implements the ->read_iter method, the iter based splice read
> > > works and is always preferred over the ->read based one.  Use it by
> > > default in do_splice_to and remove all the direct assignment of
> > > generic_file_splice_read to file_operations.
> > 
> > The worst problem here is the assumption that all ->read_iter() instances
> > will take pipe-backed destination; that's _not_ automatically true.
> > In particular, it's almost certainly false for tap_read_iter() (as
> > well as tun_chr_read_iter() in IFF_VNET_HDR case).
> > 
> > Other potentially interesting cases: cuse and hugetlbfs.
> > 
> > But in any case, that blind assertion ("iter based splice read works")
> > really needs to be backed by something.
> 
> I think we need to fix that in the instances, as we really expect
> ->splice_read to just work instead of the caller knowing what could
> work and what might not.

Er...  generic_file_splice_read() is a library helper; the decision to use
is up to the filesystem/driver/protocol in question, and so's making sure
it's not used with ->read_iter() that isn't fit for it.

Note that we *do* have instances where we have different ->splice_read()
(sometimes using generic_file_splice_read(), sometimes not) even though
->read_iter() is there.

Your patch ignores those (thankfully), but commit message is rather
misleading - it strongly implies that generic_file_splice_read() is
*always* the right thing when ->read_iter() is there, not just that
in such cases it makes a better fallback than default_file_splice_read().

And even the latter assumption is not obvious - AFAICS, we do have
counterexamples.

I'm not saying that e.g. tun/tap don't need fixing for other reasons and
it's quite possible that they will become suitable for generic_file_splice_read()
after that's done.  But I'm really unhappy about the implied change of
generic_file_splice_read() role; if nothing else, commit message should
be very clear that if you have ->read_iter() and generic_file_splice_read()
won't do the right thing, you MUST provide ->splice_read() of your own.
Probably worth Documentation/filesystem/porting entry as well.

Alternatively, if you really want to change the role of that thing,
we need to go through all instances that are *not* generic_file_splice_read()
and see what's going on in those.  Starting with the sockets.

The list right now is:
fs/fuse/dev.c:2263:     .splice_read    = fuse_dev_splice_read,
fs/overlayfs/file.c:786:        .splice_read    = ovl_splice_read,
net/socket.c:164:       .splice_read =  sock_splice_read,
kernel/relay.c:1331:    .splice_read    = relay_file_splice_read,
kernel/trace/trace.c:7081:      .splice_read    = tracing_splice_read_pipe,
kernel/trace/trace.c:7149:      .splice_read    = tracing_buffers_splice_read,
kernel/trace/trace.c:7712:      .splice_read    = tracing_buffers_splice_read,

The first 3 have ->read_iter(); the rest (kernel/* stuff) doesn't.
Socket case uses generic_file_splice_read() unless the protocol provides
an override; SMC, TCP, TCPv6, AF_UNIX STREAM and KCM SEQPACKET do that.

I hadn't looked into the socket side of things for 5 years or so, so I'd
have to dig the notes out first.  It wasn't pleasant...
