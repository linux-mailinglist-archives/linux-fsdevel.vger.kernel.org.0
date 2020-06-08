Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29201F19BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFHNQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgFHNQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:16:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCEC08C5C2;
        Mon,  8 Jun 2020 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7czmUlKXK2qDYbKTF+zj0HZydFzO+Z3y6gQHAGlxwDg=; b=nZj6j2cprHRqFfRFAHMs+zOdH+
        LiSzUwyutAB5/H1tnPDdLuRcRUbfitVDkc2nCq88K6gaUaM1zcFk40vavg2dgAe0Sw+mmThN0pUtu
        zFkfpM5Hwt35dx4xrwbZE5EWiE6vG2Jume0vNt1Ox0ZzXeiFBWQtvIBiQvHbZjtZ9tahTs7x84Pts
        78j0U04/u2uVCoUWfwimsycH+MTgNNF3YjFFSSQ0njBkz66Yzk03GYYlW4cZeCpyzOxUPAk5Ud21d
        ZeNnlcIO+jJZHriKxhujhqR443iKIjxeD1ozW3XDTgkyTau7CnNINcqDKqT+BWWn4PlRnf/CqoxhG
        sfE03h5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiHde-0006c5-HT; Mon, 08 Jun 2020 13:16:30 +0000
Date:   Mon, 8 Jun 2020 06:16:30 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20200608131630.GV19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-2-scott.branden@broadcom.com>
 <20200606155216.GP19604@bombadil.infradead.org>
 <1591621401.4638.59.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591621401.4638.59.camel@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:03:21AM -0400, Mimi Zohar wrote:
> On Sat, 2020-06-06 at 08:52 -0700, Matthew Wilcox wrote:
> > On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
> > > -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > -		     loff_t max_size, enum kernel_read_file_id id)
> > > -{
> > > -	loff_t i_size, pos;
> > > +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> > > +		      loff_t pos, loff_t max_size,
> > > +		      enum kernel_pread_opt opt,
> > > +		      enum kernel_read_file_id id)
> > > +{
> > > +	loff_t alloc_size;
> > > +	loff_t buf_pos;
> > > +	loff_t read_end;
> > > +	loff_t i_size;
> > >  	ssize_t bytes = 0;
> > >  	int ret;
> > >  
> > 
> > Look, it's not your fault, but this is a great example of how we end
> > up with atrocious interfaces.  Someone comes along and implements a
> > simple DWIM interface that solves their problem.  Then somebody else
> > adds a slight variant that solves their problem, and so on and so on,
> > and we end up with this bonkers API where the arguments literally change
> > meaning depending on other arguments.
> > 
> > > @@ -950,21 +955,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > >  		ret = -EINVAL;
> > >  		goto out;
> > >  	}
> > > -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> > > +
> > > +	/* Default read to end of file */
> > > +	read_end = i_size;
> > > +
> > > +	/* Allow reading partial portion of file */
> > > +	if ((opt == KERNEL_PREAD_PART) &&
> > > +	    (i_size > (pos + max_size)))
> > > +		read_end = pos + max_size;
> > > +
> > > +	alloc_size = read_end - pos;
> > > +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
> > >  		ret = -EFBIG;
> > >  		goto out;
> > 
> > ... like that.
> > 
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
> > 
> > kernel_read_file() can be converted to use this API.  The users will
> > need to be changed to call kernel_read_end(struct file *file, void *buf)
> > instead of vfree() so it can call allow_write_access() for them.
> > 
> > vmap_file_range() has a lot of potential uses.  I'm surprised we don't
> > have it already, to be honest.
> 
> Prior to kernel_read_file() the same or verify similar code existed in
> multiple places in the kernel.  The kernel_read_file() API
> consolidated the existing code adding the pre and post security hooks.
> 
> With this new design of not using a private vmalloc, will the file
> data be accessible prior to the post security hooks?  From an IMA
> perspective, the hooks are used for measuring and/or verifying the
> integrity of the file.

File data is already accessible prior to the post security hooks.
Look how kernel_read_file works:

        ret = deny_write_access(file);
        ret = security_kernel_read_file(file, id);
                *buf = vmalloc(i_size);
                bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
        ret = security_kernel_post_read_file(file, *buf, i_size, id);

kernel_read() will read the data into the page cache and then copy it
into the vmalloc'd buffer.  There's nothing here to prevent read accesses
to the file.

