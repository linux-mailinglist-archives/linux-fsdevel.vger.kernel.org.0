Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69CE3AD321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFRTwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFRTwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:52:14 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3254C061574;
        Fri, 18 Jun 2021 12:50:04 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luKUz-009jmj-GB; Fri, 18 Jun 2021 19:49:53 +0000
Date:   Fri, 18 Jun 2021 19:49:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YMz44XVVIlQw2Z6J@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:42:41PM +0000, Al Viro wrote:

> Pipe ones are strictly destinations - they can't be sources.  So if you
> see it called for one of those, you've a bug.
> 
> Xarray ones are *not* - they can be sources, and that's missing here.
> 
> Much more unpleasant, though, is that this thing has hard dependency on
> nr_seg == 1 *AND* openly suggests the use of iov_iter_single_seg_count(),
> which is completely wrong.  That sucker has some weird users left (as
> of #work.iov_iter), but all of them are actually due to API deficiencies
> and I very much hope to kill that thing off.
> 
> Why not simply add iov_iter_check_zeroes(), that would be called after
> copy_from_iter() and verified that all that's left in the iterator
> consists of zeroes?  Then this copy_struct_from_...() would be
> trivial to express through those two.  And check_zeroes would also
> be trivial, especially on top of #work.iov_iter.  With no calls of
> iov_iter_advance() at all, while we are at it...
> 
> IDGI... Omar, what semantics do you really want from that primitive?

And for pity sake, let's not do that EXPORT_SYMBOL_GPL() posturing there.
If it's a sane general-purpose API, it doesn't matter who uses it;
if it's not, it shouldn't be exported in the first place.

It can be implemented via the already exported primitives, so it's
not as if we prevented anyone from doing an equivalent...
