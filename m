Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C28211D02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGBHag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 03:30:36 -0400
Received: from verein.lst.de ([213.95.11.211]:42963 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGBHaf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:30:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BC9868B02; Thu,  2 Jul 2020 09:30:31 +0200 (CEST)
Date:   Thu, 2 Jul 2020 09:30:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/23] proc: add a read_iter method to proc proc_ops
Message-ID: <20200702073031.GA855@lst.de>
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-18-hch@lst.de> <20200701212751.GL2786714@ZenIV.linux.org.uk> <20200702051811.GB30361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702051811.GB30361@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:18:11AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 01, 2020 at 10:27:51PM +0100, Al Viro wrote:
> > On Wed, Jul 01, 2020 at 10:09:45PM +0200, Christoph Hellwig wrote:
> > > This will allow proc files to implement iter read semantics.
> > 
> > *UGH*
> > 
> > You are introducing file_operations with both ->read() and ->read_iter();
> > worse, in some cases they are not equivalent.  Sure, ->read() takes
> > precedence right now, but...  why not a separate file_operations for
> > ->read_iter-capable files?
> 
> I looked at that initially.  We'd need to more instances as there
> already are two due to compat stuff.  If that is preferably I can
> switch to that version.
> 
> > I really hate the fallbacks of that sort - they tend to be brittle
> > as hell.  And while we are at it, I'm not sure that your iter_read() 
> > has good cause to be non-static.
> 
> The other user of it is seq_file, which as-is should go away, but
> will probably keep the occasional version of it in the caller.  I just
> got really tired of reimplementing it a few times.

I've force puhed a new version to the existing location:

   git://git.infradead.org/users/hch/misc.git set_fs-rw

That gets uses separate ops in proc after a few preparational cleanups
and rid of the iter_read() patch entirely.  Let me know what you think,
I don't really want to send the whole patch bomb again already.

Gitweb is also avaiable here:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-rw
