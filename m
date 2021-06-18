Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1752E3AD542
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhFRWfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhFRWfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:35:07 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358ABC061574;
        Fri, 18 Jun 2021 15:32:58 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luN2k-009lrM-FL; Fri, 18 Jun 2021 22:32:54 +0000
Date:   Fri, 18 Jun 2021 22:32:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM0Zu3XopJTGMIO5@relinquished.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:10:03PM -0700, Omar Sandoval wrote:

> Or do the same reverting thing that Al did, but with copy_from_iter()
> instead of copy_from_iter_full() and being careful with the copied count
> (which I'm not 100% sure I got correct here):
> 
> 	size_t copied = copy_from_iter(&encoded, sizeof(encoded), &i);
> 	if (copied < offsetofend(struct encoded_iov, size))
> 		return -EFAULT;
> 	if (encoded.size > PAGE_SIZE)
> 		return -E2BIG;
> 	if (encoded.size < ENCODED_IOV_SIZE_VER0)
> 		return -EINVAL;
> 	if (encoded.size > sizeof(encoded)) {
> 		if (copied < sizeof(encoded)
> 			return -EFAULT;
> 		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
> 			return -EINVAL;
> 	} else if (encoded.size < sizeof(encoded)) {
> 		// older than what we expect
> 		if (copied < encoded.size)
> 			return -EFAULT;
> 		iov_iter_revert(&i, copied - encoded.size);
> 		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
> 	}    

simpler than that, actually -

	copied = copy_from_iter(&encoded, sizeof(encoded), &i);
	if (unlikely(copied < sizeof(encoded))) {
		if (copied < offsetofend(struct encoded_iov, size) ||
		    copied < encoded.size)
			return iov_iter_count(i) ? -EFAULT : -EINVAL;
	}
	if (encoded.size > sizeof(encoded)) {
		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
			return -EINVAL;
	} else if (encoded.size < sizeof(encoded)) {
		// copied can't be less than encoded.size here - otherwise
		// we'd have copied < sizeof(encoded) and the check above
		// would've buggered off
		iov_iter_revert(&i, copied - encoded.size);
		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
	}

should do it.
