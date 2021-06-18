Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E513AD46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 23:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhFRVek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhFRVei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:34:38 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F1C061574;
        Fri, 18 Jun 2021 14:32:28 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luM6B-009kzH-QZ; Fri, 18 Jun 2021 21:32:24 +0000
Date:   Fri, 18 Jun 2021 21:32:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:10:36PM -0700, Linus Torvalds wrote:

> > Just put the size of the encoded part first and be done with that.
> > Magical effect of the iovec sizes is a bloody bad idea.
> 
> That makes everything uglier and more complicated, honestly. Then
> you'd have to do it in _two_ operations ("get the size, then get the
> rest"), *AND* you'd have to worry about all the corner-cases (ie
> people putting the structure in pieces across multiple iov entries.

Huh?  All corner cases are already taken care of by copy_from_iter{,_full}().
What I'm proposing is to have the size as a field in 'encoded' and
do this
	if (!copy_from_iter_full(&encoded, sizeof(encoded), &i))
		return -EFAULT;
	if (encoded.size > sizeof(encoded)) {
		// newer than what we expect
		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
			return -EINVAL;
	} else if (encoded.size < sizeof(encoded)) {
		// older than what we expect
		iov_iter_revert(&i, sizeof(encoded) - encoded.size);
		memset((void *)&encoded + encoded.size, 0, sizoef(encoded) - encoded.size);
	}

I don't think it would be more complex, but that's a matter of taste;
I *really* doubt it would be any slower or have higher odds of bugs,
regardless of the corner cases.

And it certainly would be much smaller on the lib/iov_iter.c side -
implementation of iov_iter_check_zeroes() would be simply this:

bool iov_iter_check_zeroes(struct iov_iter *i, size_t size)
{
	bool failed = false;

	iterate_and_advance(i, bytes, base, len, off,
		failed = (check_zeroed_user(base, len) != 1),
		failed = (memchr_inv(base, 0, len) != NULL))
	if (unlikely(failed))
		iov_iter_revert(i, bytes);
	return !failed;
}

And that's it, no need to do anything special for xarray, etc.
This + EXPORT_SYMBOL + extern in uio.h + snippet above in the
user...

I could buy an argument that for userland the need to add
	encoded.size = sizeof(encoded);
or equivalent when initializing that thing would make life too complex,
but on the kernel side I'd say that Omar's variant is considerably more
complex than the above...

