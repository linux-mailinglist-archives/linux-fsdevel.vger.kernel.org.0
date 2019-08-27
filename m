Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456109F191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfH0R1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 13:27:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfH0R1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:27:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2fFm-0007Sw-Vk; Tue, 27 Aug 2019 17:27:35 +0000
Date:   Tue, 27 Aug 2019 18:27:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Kai =?iso-8859-1?Q?M=E4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190827172734.GS1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 06:01:27PM +0300, Boaz Harrosh wrote:
> On 26/08/2019 22:32, Al Viro wrote:
> <>
> > D'oh...  OK, that settles it; exclusion with st_write() would've been
> > painful, but playing with the next st_write() on the same struct file
> > rewinding the damn thing to overwrite what st_flush() had spewed is
> > an obvious no-go.
> > 
> 
> So what are the kind of errors current ->release implementation is trying to return?
> Is it actual access the HW errors or its more of a resource allocations errors?
> If the later then maybe the allocations can be done before hand, say at ->flush but
> are not redone on redundant flushes?

Most of them are actually pure bollocks - "it can never happen, but if it does,
let's return -EWHATEVER to feel better".  Some are crap like -EINTR, which is
also bollocks - for one thing, process might've been closing files precisely
because it's been hit by SIGKILL.  For another, it's a destructor.  It won't
be retried by the caller - there's nothing called for that object afterwards.
What you don't do in it won't be done at all.

And some are "commit on final close" kind of thing, both with the hardware
errors and parsing errors.

> If the former then yes looks like troubles. That said I believe the 
> ->last_close_with_error() is a very common needed pattern which few use exactly
> because it does not work. But which I wanted/needed many times before.
> 
> So I would break some eggs which ever is the most elegant way, and perhaps add a
> new parameter to ->flush(bool last) or some other easy API.
> [Which is BTW the worst name ever, while at it lets rename it to ->close() which
>  is what it is. "flush" is used elsewhere to mean sync.
> ]

It *is* flush.  And nothing else, really - it makes sure that dirty data is
pushed to destination, with any errors reported.

> So yes please lets fix VFS API with drivers so to have an easy and safe way
> to execute very last close, all the while still being able to report errors to
> close(2).

What the hell is "very last close()"?  Note, BTW, that you can have one thread
call close() in the middle of write() by another thread.  And that will succeed,
with actual ->release() happening no earlier than write() is done; however,
descriptor will be gone when close(2) is done.

You are assuming the model that doesn't match the basic userland ABI for
descriptors.  And no, close(2) is not going to wait for write(2) to finish.
Neither it is going to interrupt said write(2).

Note, BTW, that an error returned by close(2) does *NOT* leave the descriptor
in place - success or failure, it's gone.

If you want to express something like "data packet formed; now you can commit
it and tell me if there'd been any errors", use something explicit.  close()
simply isn't suitable for that.  writev() for datagram-like semantics might
be; fsync() or fdatasync() could serve for "commit now".
