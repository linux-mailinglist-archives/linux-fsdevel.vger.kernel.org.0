Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D309D1AF8A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDSIN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 04:13:57 -0400
Received: from verein.lst.de ([213.95.11.211]:35756 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgDSIN5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:13:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A967968BEB; Sun, 19 Apr 2020 10:13:53 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:13:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200419081353.GF12222@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org> <87k12dakfx.fsf_-_@x220.int.ebiederm.org> <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr> <87v9lx3t4j.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9lx3t4j.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 06:55:56AM -0500, Eric W. Biederman wrote:
> > Is that really an issue to use that set_fs() in the coredump code ?
> 
> Using set_fs() is pretty bad and something that we would like to remove
> from the kernel entirely.  The fewer instances of set_fs() we have the
> better.
> 
> I forget all of the details but set_fs() is both a type violation and an
> attack point when people are attacking the kernel.  The existence of
> set_fs() requires somethings that should be constants to be variables.
> Something about that means that our current code is difficult to protect
> from spectre style vulnerabilities.

Yes, set_fs requires variable based address checking in the uaccess
routines for architectures with a shared address space, or even entirely
different code for architectures with separate kernel and user address
spaces.  My plan is to hopefully kill set_fs in its current form a few
merge windows down the road.  We'll probably still need some form of
it to e.g. mark a thread as kernel thread vs also being able to execute
user code, but it will be much ore limited than before, called from very
few places and actually be a no-op for many architectures.
