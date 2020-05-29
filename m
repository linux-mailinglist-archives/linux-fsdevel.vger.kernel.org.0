Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3701E75B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE2F5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 01:57:40 -0400
Received: from verein.lst.de ([213.95.11.211]:59724 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgE2F5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 01:57:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EAA7E68AFE; Fri, 29 May 2020 07:57:36 +0200 (CEST)
Date:   Fri, 29 May 2020 07:57:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 09/14] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200529055736.GB6788@lst.de>
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-10-hch@lst.de> <20200528190052.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528190052.GM23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 08:00:52PM +0100, Al Viro wrote:
> On Thu, May 28, 2020 at 07:40:38AM +0200, Christoph Hellwig wrote:
> > If we write to a file that implements ->write_iter there is no need
> > to change the address limit if we send a kvec down.  Implement that
> > case, and prefer it over using plain ->write with a changed address
> > limit if available.
> 
> Umm...  It needs a comment along the lines of "weird shits like
> /dev/sg that currently check for uaccess_kernel() will just
> have to make sure they never switch to ->write_iter()"

sg and hid has the uaccess_kernel because it accesses userspace memory not
in the range passed to it.  Something using write_iter/read_iter should
never access any memory outside the iter passed to.  rdma has it because
it uses write as a bidirectional interface, which obviously can't work at
all with an iter.  So I'm not sure what we should comment on, but if
you have a desire and a proposal for a comment I'll happily add it.
