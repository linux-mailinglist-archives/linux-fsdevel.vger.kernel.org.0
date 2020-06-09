Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A931F3C37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgFINWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFINV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:21:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464AC05BD1E;
        Tue,  9 Jun 2020 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V3d421xQlXEJCML3wEa7LbtDgAd0pPCbPZf0itcOVZ8=; b=VuQsL7ABDfE4mueZRE489uDo1M
        eM4Y9jTz9gyCzJYdzmiTdSNVyu5pjPS5CXs09Wknm2mH5UOFrqyk0xrX5l9H/cklBqVT9ykRBV7C3
        IWhoIkgrYD2Z19w9mu1XA81RLZNh9R5A+ECNnKPjJWWE+fQRDKjuGbRrTxpYH+4fXq/APDQPul2fj
        K1xei6kJzZlH8DNagtemxgNhvyzuKJnGcBjbP4gos3FLszISbop9vUZMawb8rdI6f8W5+bWJT+8xT
        ss0Xmb5GpKQ8vqysTU1ndMnkyw5LHcveHtKtKWo9pu6wtW3oiqIr3oyHD91t8ghef9wbBg0O+qxaY
        GeHEHHEg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jieCN-0007n5-3Y; Tue, 09 Jun 2020 13:21:51 +0000
Date:   Tue, 9 Jun 2020 06:21:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 1/8] fs: introduce kernel_pread_file* support
Message-ID: <20200609132151.GC19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-2-scott.branden@broadcom.com>
 <20200606155216.GP19604@bombadil.infradead.org>
 <ea16c19e-bd60-82ec-4825-05e233667f9f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea16c19e-bd60-82ec-4825-05e233667f9f@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:29:22PM -0700, Scott Branden wrote:
> Hi Matthew,
> 
> I am requesting the experts in the filesystem subsystem to come to a
> consensus here.
> This is not my area of expertise at all but every time I have addressed all
> of the
> outstanding concerns someone else comes along and raises another one.

I appreciate it's frustrating for you, but this is the nature of
patch review.  I haven't even read the first five or so submissions.
I can see them in my inbox and they look like long threads.  I'm not
particularly inclined to read them.  I happened to read v6, and reacted
to the API being ugly.

> Please see me comments below.
> 
> On 2020-06-06 8:52 a.m., Matthew Wilcox wrote:
> > On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
> > > -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > -		     loff_t max_size, enum kernel_read_file_id id)
> > > -{
> > > -	loff_t i_size, pos;
> Please note that how checkpatch generated the diff here.  The code
> modifications
> below are for a new function kernel_pread_file, they do not modify the
> existing API
> kernel_read_file.  kernel_read_file requests the ENTIRE file is read.  So we
> need to be
> able to differentiate whether it is ok to read just a portion of the file or
> not.

You've gone about this in entirely the wrong way though.  This enum to
read the entire file or a partial is just bad design.

> > > +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> > > +		      loff_t pos, loff_t max_size,
> > > +		      enum kernel_pread_opt opt,
> > > +		      enum kernel_read_file_id id)
> So, to share common code a new kernel_pread_opt needed to be added in order
> to specify whether
> it was ok to read a partial file or not, and provide an offset into the file
> where to begin reading.
> The meaning of parameters doesn't change in the bonkers API. max_size still
> means max size, etc.
> These options are needed so common code can be shared with kernel_read_file
> api.

Does pread() in userspace take seven parameters?  No.  It takes four.
What you're doing is taking all the complexity of all of the interfaces
and stuffing it all down into the bottom function instead of handling
some of the complexity in the wrapper functions.  For example, you
could support the functionality of 'max_size' in kernel_read_file()
and leave it out of the kernel_pread_file() interface.

> > I think what we actually want is:
> > 
> > ssize_t vmap_file_range(struct file *, loff_t start, loff_t end, void **bufp);
> > void vunmap_file_range(struct file *, void *buf);
> > 
> > If end > i_size, limit the allocation to i_size.  Returns the number
> > of bytes allocated, or a negative errno.  Writes the pointer allocated
> > to *bufp.  Internally, it should use the page cache to read in the pages
> > (taking appropriate reference counts).  Then it maps them using vmap()
> > instead of copying them to a private vmalloc() array.
> > kernel_read_file() can be converted to use this API.  The users will
> > need to be changed to call kernel_read_end(struct file *file, void *buf)
> > instead of vfree() so it can call allow_write_access() for them.
> > 
> > vmap_file_range() has a lot of potential uses.  I'm surprised we don't
> > have it already, to be honest.
> Such a change sounds like it could be done in a later patch series.
> It's an incomplete solution.  It would work for some of the needed
> operations but not others.
> For kernel_read_file, I don't see how in your new API it indicates if the
> end of the file was reached or not.

That's the point.  It doesn't.  If a caller needs that, then they can
figure that out themselves.

> Also, please note that buffers may be preallocated  and shouldn't be freed
> by the kernel in some cases and
> allocated and freed by the kernel in others.

You're trying to build the swiss army knife of functions.  Swiss army
knives are useful, but they're no good for carving a steak.

> I would like the experts here to decide on what needs to be done so we can
> move forward
> and get kernel_pread_file support added soon.

You know, you haven't even said _why_ you want this.  The cover letter
just says "I want this", and doesn't say why it's needed.
