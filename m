Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224547207E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbfGWUHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 16:07:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44527 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730704AbfGWUHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:07:37 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6NK7DvE006164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 16:07:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 52A1F4202F5; Tue, 23 Jul 2019 16:07:13 -0400 (EDT)
Date:   Tue, 23 Jul 2019 16:07:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
Message-ID: <20190723200713.GA4565@mit.edu>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
 <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:20:05AM -0600, Jens Axboe wrote:
> 
> I actually think it's XFS that's broken here, it's not passing down
> the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
> important request bit, and we just block instead of triggering the
> not_supported case.
> 
> Outside of that, that case needs similar treatment to what I did for
> the EAGAIN case here:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7
> 
> It was a big mistake to pass back these values in an async fashion,
> and it also means that some accounting in other drivers are broken
> as we can get completions without the bio actually being submitted.

Hmmm, I had been trying to track down a similar case with virtio-scsi
on top of LVM, using a Google Compute Engine VM.  In that case,
xfstests generic/471 was failing with EIO, when it would pass just
*fine* when I was using KVM with a virtio-scsi device w/o LVM.

So it sounds like that what's going on is if the device driver (or
LVM, or anything else in the storage stack) needs to do a blocking
memory allocation, and NOWAIT is requested, we'll end up returning EIO
because an asynchronous error is getting reported, where as if we
could return it synchronously, the file system could properly return
EOPNOTSUP.  Am I understanding you correctly?

I guess there's a separate question hiding here, which is whether
there's a way to allow dm-linear or dm-crypt to handle NOWAIT requests
without needing to block.

					- Ted
