Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEAA44A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfHaNfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 09:35:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38636 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaNfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:35:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i43XV-0002yI-8d; Sat, 31 Aug 2019 13:35:37 +0000
Date:   Sat, 31 Aug 2019 14:35:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190831133537.GX1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org>
 <20190826192819.GO1131@ZenIV.linux.org.uk>
 <20190831083241.GC28527@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831083241.GC28527@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 10:32:41AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 26, 2019 at 08:28:19PM +0100, Al Viro wrote:
> > For configfs bin_attr it won't work, simply because it wants the entire
> > thing to be present - callback parses the data.  For SCSI tape...  Maybe,
> > but you'll need to take care of the overlaps with ->write().  Right now
> > it can't happen (the last reference, about to be dropped right after
> > st_flush() returns); if we do that on each ->flush(), we will have to
> > cope with that fun and we'll need to keep an error (if any) for the
> > next call of st_flush() to pick and return.  I'm not saying it can't
> > be done, but that's really a question for SCSI folks.
> 
> So for the one real life example of the configfs attribute life
> actually is simpler.  acpi_table_aml_write verifies early on that
> the size matches what it expects.  So if we document that any future
> instance needs to be able to do that as well we should be able to
> get away with just writing it from ->flush.

I'm not sure I understand what you mean...  Do you want them to recognize
incomplete data and quietly bugger off when called on too early ->flush()?
