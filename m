Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE2264A89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIJRDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:03:38 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:52494 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgIJRC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:58 -0400
Date:   Thu, 10 Sep 2020 13:02:56 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910170256.GK3265@brightrain.aerifal.cx>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910162059.GA18228@infradead.org>
 <20200910163949.GJ3265@brightrain.aerifal.cx>
 <20200910164234.GA25140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910164234.GA25140@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 05:42:34PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 12:39:50PM -0400, Rich Felker wrote:
> > On Thu, Sep 10, 2020 at 05:20:59PM +0100, Christoph Hellwig wrote:
> > > On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> > > > userspace emulation done in libc implementations. No change is made to
> > > > the underlying chmod_common(), so it's still possible to attempt
> > > > changes via procfs, if desired.
> > > 
> > > And that is the goddamn problem.  We need to fix that _first_.
> > 
> > Can you clarify exactly what that is? Do you mean fixing the
> > underlying fs backends, or just ensuring that the chmod for symlinks
> > doesn't reach them by putting the check in chmod_common? I'm ok with
> > any of these.
> 
> Either - we need to make sure the user can't change the permission
> bits.
> 
> > > After that we can add sugarcoating using new syscalls if needed.
> > 
> > The new syscall is _not_ about this problem. It's about the missing
> > flags argument and inability to implement fchmodat() without access to
> > procfs. The above problem is just something you encounter and have to
> > make a decision about in order to fix the missing flags problem and
> > make a working AT_SYMLINK_NOFOLLOW.
> 
> And I'm generally supportive of that.  But we need to fix the damn
> bug first an then do nice to haves.

Would you be happy with a pair of patches where the first blocks chmod
of symlinks in chmod_common and the second adds the syscall with
flags? I think this is a clearly understandable fix, but it does
eliminate the ability to *fix* link access modes that have been set to
ridiculous values (note: I don't think it really matters since the
modes don't do anything anyway) in the past.

That's why I preferred to *start* with the forced-EOPNOTSUPP just in
the new interface, so that links won't inadvertently get bogus modes
set on them when libc starts using it. As long as some filesystems are
representing access modes in links (and returning them via stat), it
seems like there should be a way to "fix" any that were set in the
past. The patch as I've submitted it now is the least invasive change
in this sense; it does not take away any capability that already
existed.

Rich
