Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561793AD402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhFRVAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhFRVAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:00:18 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19127C061574;
        Fri, 18 Jun 2021 13:58:09 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luLYz-009kX3-Jo; Fri, 18 Jun 2021 20:58:05 +0000
Date:   Fri, 18 Jun 2021 20:58:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM0C2mZfTE0uz3dq@relinquished.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 01:32:26PM -0700, Omar Sandoval wrote:

> RWF_ENCODED is intended to be used like this:
> 
> 	struct encoded_iov encoded_iov = {
> 		/* compression metadata */ ...
> 	};
> 	char compressed_data[] = ...;
> 	struct iovec iov[] = {
> 		{ &encoded_iov, sizeof(encoded_iov) },
> 		{ compressed_data, sizeof(compressed_data) },
> 	};
> 	pwritev2(fd, iov, 2, -1, RWF_ENCODED);
> 
> Basically, we squirrel away the compression metadata in the first
> element of the iovec array, and we use iov[0].iov_len so that we can
> support future extensions of struct encoded_iov in the style of
> copy_struct_from_user().

Yecchhh...

> So this doesn't require nr_seg == 1. On the contrary, it's expected that
> the rest of the iovec has the compressed payload. And to support the
> copy_struct_from_user()-style versioning, we need to know the size of
> the struct encoded_iov that userspace gave us, which is the reason for
> the iov_iter_single_seg_count().
> 
> I know this interface isn't the prettiest. It started as a
> Btrfs-specific ioctl, but this approach was suggested as a way to avoid
> having a whole new I/O path:
> https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
> The copy_struct_from_iter() thing was proposed as a way to allow future
> extensions here:
> https://lore.kernel.org/linux-btrfs/20191022020215.csdwgi3ky27rfidf@yavin.dot.cyphar.com/
> 
> Please let me know if you have any suggestions for how to improve this.

Just put the size of the encoded part first and be done with that.
Magical effect of the iovec sizes is a bloody bad idea.

And on top of #work.iov_iter something like

bool iov_iter_check_zeroes(struct iov_iter *i, size_t bytes)
{
	bool failed = false;
        iterate_and_advance(i, bytes, base, len, off,
			failed = (check_zeroed_user(base, len) != 1),
			failed = (memchr_inv(base, 0, len) != NULL),
			)
	if (unlikely(failed))
		iov_iter_revert(i, bytes);
	return !failed;
}

would do "is that chunk all-zeroes?" just fine.  It's that simple...
