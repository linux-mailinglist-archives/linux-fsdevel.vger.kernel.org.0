Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726B51C1ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgEAQvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 12:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgEAQvr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 12:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEA32173E;
        Fri,  1 May 2020 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588351907;
        bh=++sDVtfRPslmaRC40X9+zsZ1c0TFAxBbEziiGGuGPdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WngqC7Pp4qUBPz23YQI6VXXQbL775RJYV1qHAbUnahMAU7i97p+hdeoTrHVZJmTc6
         7eInjZEqMYXE9+rjz9GElVbALjjynHJg27bEE+WfpjG2pCDIB0KUOK498PLlFL+ilo
         ZykZT9G0ACcVZ5kT76jLEejG1Jky7AZu9EVDwWGI=
Date:   Fri, 1 May 2020 18:51:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200501165145.GA2085362@kroah.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-6-mcgrof@kernel.org>
 <20200429094937.GB2081185@kroah.com>
 <20200501150626.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501150626.GM11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 03:06:26PM +0000, Luis Chamberlain wrote:
> On Wed, Apr 29, 2020 at 11:49:37AM +0200, Greg KH wrote:
> > On Wed, Apr 29, 2020 at 07:46:26AM +0000, Luis Chamberlain wrote:
> > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > index 5c52976bd762..383045f67cb8 100644
> > > --- a/kernel/trace/blktrace.c
> > > +++ b/kernel/trace/blktrace.c
> > > @@ -516,6 +518,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> > >  	 */
> > >  	strreplace(buts->name, '/', '_');
> > >  
> > > +	if (q->blk_trace) {
> > > +		pr_warn("Concurrent blktraces are not allowed\n");
> > > +		return -EBUSY;
> > 
> > You have access to a block device here, please use dev_warn() instead
> > here for that, that makes it obvious as to what device a "concurrent
> > blktrace" was attempted for.
> 
> The block device may be empty, one example is for scsi-generic, but I'll
> use buts->name.

That's fine, give us a chance to know what went wrong, your line as is
does not do that :(

thanks,

greg k-h
