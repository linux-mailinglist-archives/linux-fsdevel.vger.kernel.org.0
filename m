Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E143AD30C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFRToz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRToy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:44:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B8C061574;
        Fri, 18 Jun 2021 12:42:44 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luKO1-009jgu-QW; Fri, 18 Jun 2021 19:42:41 +0000
Date:   Fri, 18 Jun 2021 19:42:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 11:50:25AM -0700, Linus Torvalds wrote:

> I think that you may need it to be based on Al's series for that to
> work, which might be inconvenient, though.
> 
> One other non-code issue: particularly since you only handle a subset
> of the iov_iter cases, it would be nice to have an explanation for
> _why_ those particular cases.
> 
> IOW, have some trivial explanation for each of the cases. "iovec" is
> for regular read/write, what triggers the kvec and bvec cases?
> 
> But also, the other way around. Why doesn't the pipe case trigger? No
> splice support?

Pipe ones are strictly destinations - they can't be sources.  So if you
see it called for one of those, you've a bug.

Xarray ones are *not* - they can be sources, and that's missing here.

Much more unpleasant, though, is that this thing has hard dependency on
nr_seg == 1 *AND* openly suggests the use of iov_iter_single_seg_count(),
which is completely wrong.  That sucker has some weird users left (as
of #work.iov_iter), but all of them are actually due to API deficiencies
and I very much hope to kill that thing off.

Why not simply add iov_iter_check_zeroes(), that would be called after
copy_from_iter() and verified that all that's left in the iterator
consists of zeroes?  Then this copy_struct_from_...() would be
trivial to express through those two.  And check_zeroes would also
be trivial, especially on top of #work.iov_iter.  With no calls of
iov_iter_advance() at all, while we are at it...

IDGI... Omar, what semantics do you really want from that primitive?
