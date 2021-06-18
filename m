Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832743AD4E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhFRWQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 18:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhFRWQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:16:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67FC061574;
        Fri, 18 Jun 2021 15:14:42 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luMl5-009lcA-2j; Fri, 18 Jun 2021 22:14:39 +0000
Date:   Fri, 18 Jun 2021 22:14:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0az9vZJVX5Z24m@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:40:51PM -0700, Linus Torvalds wrote:
> On Fri, Jun 18, 2021 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Huh?  All corner cases are already taken care of by copy_from_iter{,_full}().
> > What I'm proposing is to have the size as a field in 'encoded' and
> > do this
> 
> Hmm. Making it part of the structure does make it easier (also for the
> sending userspace side, that doesn't now have to create yet another
> iov or copy the structure or whatever).
> 
> Except your code doesn't actually handle the "smaller than expected"
> case correctly, since by the time it even checks for that, it will
> possibly already have failed. So you actually had a bug there - you
> can't use the "xyz_full()" version and get it right.

Right you are - should be something along the lines of

#define MIN_ENCODED_SIZE minimal size, e.g. offsetof of the next field after .size

	size = copy_from_iter(&encoded, sizeof(encoded), &i);
	if (unlikely(size < sizeof(encoded))) {
		// the total length is less than expected
		// must be at least encoded.size, though, and it would better
		// cover the .size field itself.
	    	if (size < MIN_ENCODED_SIZE || size < encoded.size)
			sod off
	}
	if (sizeof(encoded) < encoded.size) {
		// newer than expected
		same as in previous variant
	} else if (size > encoded.size) {
		// older than expected
		iov_iter_revert(size - encoded.size);
		memset(....) as in previous variant
	}
