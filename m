Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45933EE8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 11:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCQKpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 06:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCQKof (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B8F64F21;
        Wed, 17 Mar 2021 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615977874;
        bh=ULh+I95lTl58eRFoikqOwheMexlwTAUFAS3ah2duRCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaju3pJvbW1Yp5JJrfVdlqY/+2HojAOyx7dBjT730LNyaWYjoRiYoOwvcRLuOsumb
         2OjMwM5e6Np6YPOnkM5wHXOnaU0MpDZRv6Y4whWQnJaqzvnb30zWn8EZcbLN5+hfNV
         HJDC3B7MZAq3EA3f1E+g4QN3R/YPwq1oHFXJ3QjQ=
Date:   Wed, 17 Mar 2021 11:44:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFHdj+/65XO78J06@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
 <YFBdQmT64c+2uBRI@kroah.com>
 <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
 <202103161208.22FC78C8C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103161208.22FC78C8C@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:18:33PM -0700, Kees Cook wrote:
> On Tue, Mar 16, 2021 at 12:43:12PM +0000, Al Viro wrote:
> > On Tue, Mar 16, 2021 at 08:24:50AM +0100, Greg Kroah-Hartman wrote:
> > 
> > > > Completely agreed. seq_get_buf() should be totally ripped out.
> > > > Unfortunately, this is going to be a long road because of sysfs's ATTR
> > > > stuff, there are something like 5000 callers, and the entire API was
> > > > designed to avoid refactoring all those callers from
> > > > sysfs_kf_seq_show().
> > > 
> > > What is wrong with the sysfs ATTR stuff?  That should make it so that we
> > > do not have to change any caller for any specific change like this, why
> > > can't sysfs or kernfs handle it automatically?
> > 
> > Hard to tell, since that would require _finding_ the sodding ->show()
> > instances first.  Good luck with that, seeing that most of those appear
> > to come from templates-done-with-cpp...
> 
> I *think* I can get coccinelle to find them all, but my brute-force
> approach was to just do a debug build changing the ATTR macro to be
> typed, and changing the name of "show" and "store" in kobj_attribute
> (to make the compiler find them all).
> 
> > AFAICS, Kees wants to protect against ->show() instances stomping beyond
> > the page size.  What I don't get is what do you get from using seq_file
> > if you insist on doing raw access to the buffer rather than using
> > seq_printf() and friends.  What's the point?
> 
> To me, it looks like the kernfs/sysfs API happened around the time
> "container_of" was gaining ground. It's trying to do the same thing
> the "modern" callbacks do with finding a pointer from another, but it
> did so by making sure everything had a 0 offset and an identical
> beginning structure layout _but changed prototypes_.
> 
> It's the changed prototypes that freaks out CFI.
> 
> My current plan consists of these steps:
> 
> - add two new callbacks to the kobj_attribute struct (and its clones):
>   "seq_show" and "seq_store", which will pass in the seq_file.

Ick, why?  Why should the callback care about seq_file?  Shouldn't any
wrapper logic in the kobject code be able to handle this automatically?

> - convert all callbacks to kobject/kboj_attribute and use container_of()
>   to find their respective pointers.

Which callbacks are you talking about here?

> - remove "show" and "store"

Hah!

> - remove external use of seq_get_buf().

So is this the main goal?  I still don't understand the sequence file
problem here, what am I missing (becides the CFI stuff that is)?

> The first two steps require thousands of lines of code changed, so
> I'm going to try to minimize it by trying to do as many conversions as
> possible to the appropriate helpers first. e.g. DEVICE_ATTR_INT exists,
> but there are only 2 users, yet there appears to be something like 500
> DEVICE_ATTR callers that have an open-coded '%d':
> 
> $ git grep -B10 '\bDEVICE_ATTR' | grep '%d' | wc -l
> 530

That's going to be hard, and a pain, and I really doubt all that useful
as I still can't figure out why this is needed...

thanks,

greg k-h
