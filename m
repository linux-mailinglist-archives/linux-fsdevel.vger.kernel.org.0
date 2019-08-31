Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E810A434F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfHaIcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 04:32:46 -0400
Received: from verein.lst.de ([213.95.11.211]:33982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfHaIcq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:32:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 194F268AFE; Sat, 31 Aug 2019 10:32:42 +0200 (CEST)
Date:   Sat, 31 Aug 2019 10:32:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190831083241.GC28527@lst.de>
References: <20190826024838.GN1131@ZenIV.linux.org.uk> <20190826162949.GA9980@ZenIV.linux.org.uk> <20190826182017.GE15933@bombadil.infradead.org> <20190826192819.GO1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826192819.GO1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:28:19PM +0100, Al Viro wrote:
> For configfs bin_attr it won't work, simply because it wants the entire
> thing to be present - callback parses the data.  For SCSI tape...  Maybe,
> but you'll need to take care of the overlaps with ->write().  Right now
> it can't happen (the last reference, about to be dropped right after
> st_flush() returns); if we do that on each ->flush(), we will have to
> cope with that fun and we'll need to keep an error (if any) for the
> next call of st_flush() to pick and return.  I'm not saying it can't
> be done, but that's really a question for SCSI folks.

So for the one real life example of the configfs attribute life
actually is simpler.  acpi_table_aml_write verifies early on that
the size matches what it expects.  So if we document that any future
instance needs to be able to do that as well we should be able to
get away with just writing it from ->flush.
