Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E571C4E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgEEGeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 02:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEGeq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 02:34:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1000206CC;
        Tue,  5 May 2020 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588660484;
        bh=EI2muG+asOrX7U2AolxDsDkX4CxBCxnvK0ZMzAVDPkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdoHgdZF/l07H77l97vo9if8+kenXB2DfksMgw4UDb33B73x4x2EAIv8KgviOz1Bg
         4vQONFdBYgzx+WY+P/Tlxr5Qkpneac17nfvyIf0wG1N0s0ChfpxmIpb/h4Iy9zHkaY
         2dx7bO1DFTi4prxw6mDDvctE3BVqkhPgMykUwm2U=
Date:   Tue, 5 May 2020 08:34:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <20200505063441.GA3877399@kroah.com>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
 <202005041329.169799C65D@keescook>
 <20200504215903.GT11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504215903.GT11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 09:59:03PM +0000, Luis Chamberlain wrote:
> On Mon, May 04, 2020 at 01:32:07PM -0700, Kees Cook wrote:
> > On Mon, May 04, 2020 at 07:59:37PM +0000, Luis Chamberlain wrote:
> > > On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> > > > Just as a precaution, make sure that proc handlers don't accidentally
> > > > grow "count" beyond the allocated kbuf size.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > > This applies to hch's sysctl cleanup tree...
> > > > ---
> > > >  fs/proc/proc_sysctl.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > > index 15030784566c..535ab26473af 100644
> > > > --- a/fs/proc/proc_sysctl.c
> > > > +++ b/fs/proc/proc_sysctl.c
> > > > @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > >  	struct inode *inode = file_inode(filp);
> > > >  	struct ctl_table_header *head = grab_header(inode);
> > > >  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > > > +	size_t count_max = count;
> > > >  	void *kbuf;
> > > >  	ssize_t error;
> > > >  
> > > > @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > >  
> > > >  	if (!write) {
> > > >  		error = -EFAULT;
> > > > +		if (WARN_ON(count > count_max))
> > > > +			count = count_max;
> > > 
> > > That would crash a system with panic-on-warn. I don't think we want that?
> > 
> > Eh? None of the handlers should be making this mistake currently and
> > it's not a mistake that can be controlled from userspace. WARN() is
> > absolutely what's wanted here: report an impossible situation (and
> > handle it gracefully for the bulk of users that don't have
> > panic_on_warn set).
> 
> Alrighty, Greg are you OK with this type of WARN_ON()? You recently
> expressed concerns over its use due to panic-on-warn on another patch.

We should never call WARN() on any path that a user can trigger.

If it is just a "the developer called this api in a foolish way" then we
could use a WARN_ON() to have them realize their mistake, but in my
personal experience, foolish developers don't even notice that kind of
mistake :(

thanks,

greg k-h
