Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997DE9D6C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfHZT2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 15:28:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45794 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbfHZT2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:28:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Kf5-0000U6-Aq; Mon, 26 Aug 2019 19:28:19 +0000
Date:   Mon, 26 Aug 2019 20:28:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190826192819.GO1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826182017.GE15933@bombadil.infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:20:17AM -0700, Matthew Wilcox wrote:
> On Mon, Aug 26, 2019 at 05:29:49PM +0100, Al Viro wrote:
> > On Mon, Aug 26, 2019 at 03:48:38AM +0100, Al Viro wrote:
> > 
> > > 	We might be able to paper over that mess by doing what /dev/st does -
> > > checking that file_count(file) == 1 in ->flush() instance and doing commit
> > > there in such case.  It's not entirely reliable, though, and it's definitely
> > > not something I'd like to see spreading.
> > 
> > 	This "not entirely reliable" turns out to be an understatement.
> > If you have /proc/*/fdinfo/* being read from at the time of final close(2),
> > you'll get file_count(file) > 1 the last time ->flush() is called.  In other
> > words, we'd get the data not committed at all.
> 
> How about always doing the write in ->flush instead of ->release?
> Yes, that means that calling close(dup(fd)) is going to flush the
> write, but you shouldn't be doing that.  I think there'll also be
> extra flushes done if you fork() during one of these writes ... but,
> again, don't do that.  It's not like these are common things.

For configfs bin_attr it won't work, simply because it wants the entire
thing to be present - callback parses the data.  For SCSI tape...  Maybe,
but you'll need to take care of the overlaps with ->write().  Right now
it can't happen (the last reference, about to be dropped right after
st_flush() returns); if we do that on each ->flush(), we will have to
cope with that fun and we'll need to keep an error (if any) for the
next call of st_flush() to pick and return.  I'm not saying it can't
be done, but that's really a question for SCSI folks.

> Why does the prototype of file_operations::release suggest that it can
> return an int?  __fput doesn't pay any attention to the return value.
> Changing that to return void might help some future programmers avoid
> this mistake.

Hysterical raisins.  It's doable, the main question is how much do we
aim for and whether it's worth the amount of churn.

It has been discussed (last time about 6 years ago), didn't go anywhere.
Boggled down in discussing how much churn which cleanups are worth;
I wanted to make them
	void (*some_sane_name)(struct file *)
(except that the name I'd used hadn't been sane).  Linus wanted
	void (*release)(struct file *, struct inode *)
and suggested to do a big change replacing int with void, basically,
then followups fixing the resulting warnings.  
