Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4439E734
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfH0L6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 07:58:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0L6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:58:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2a6y-0007MM-Uq; Tue, 27 Aug 2019 11:58:09 +0000
Date:   Tue, 27 Aug 2019 12:58:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190827115808.GQ1131@ZenIV.linux.org.uk>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <20190826182017.GE15933@bombadil.infradead.org>
 <20190826192819.GO1131@ZenIV.linux.org.uk>
 <20190827085144.GA31244@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827085144.GA31244@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:51:44AM +0200, Miklos Szeredi wrote:
 
> How about something like this:
> 
> #if BITS_PER_LONG == 32
> #define F_COUNT_SHORTTERM ((1UL << 24) + 1)
> #else
> #define F_COUNT_SHORTTERM ((1UL << 48) + 1)
> #endif
> 
> static inline void get_file_shortterm(struct file *f)
> {
> 	atomic_long_add(F_COUNT_SHORTTERM, &f->f_count);
> }
> 
> static inline void put_file_shortterm(struct file *f)
> {
> 	fput_many(f, F_COUNT_SHORTTERM);
> }
> 
> static inline bool file_is_last_longterm(struct file *f)
> {
> 	return atomic_long_read(&f->f_count) % F_COUNT_SHORTTERM == 1;
> }

So 256 threads boinking on the same fdinfo at the same time
and struct file can be freed right under them?  Or a bit over
million of dup(), then forking 15 more children, for that matter...

Seriously, it might be OK on 64bit (with something like "no more
than one reference held by a thread", otherwise you'll run
into overflows even there - 65536 of your shortterm references
aren't that much).  On 32bit it's a non-starter - too easy to
overflow.
