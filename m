Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945DB240A67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgHJPl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgHJPlW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:41:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E123420774;
        Mon, 10 Aug 2020 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597074081;
        bh=/DZI2CFBXPZXY6W2D41iKfNlsWTLOnIsj8qhKNBhXyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnzRu9GImI9oEyDWHQAcntUlob1mf068CGlKWLj/oKXM7dkyIU9SLC12tkja3BnsT
         n2FUkDjXa/QIF0ivhbsZFXgkn6CmJyJaK/GQhtEx1N6TZ8wpLHSU1No/9ZcbQWCnnD
         vQwOK+h0ldJSALe1FJ9TNCb9dImTC6q9cE1JKX+I=
Date:   Mon, 10 Aug 2020 17:41:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugene Lubarsky <elubarsky.linux@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200810154132.GA4171851@kroah.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
 <20200810150453.GB3962761@kroah.com>
 <20200811012700.2c349082@eug-lubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811012700.2c349082@eug-lubuntu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:27:00AM +1000, Eugene Lubarsky wrote:
> On Mon, 10 Aug 2020 17:04:53 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > How many syscalls does this save on?
> > 
> > Perhaps you want my proposed readfile(2) syscall:
> > 	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
> > to help out with things like this?  :)
> 
> The proposed readfile sounds great and would help, but if there are
> 1000 processes wouldn't that require 1000 readfile calls to read their
> proc files?

Yes, but that should be better than 1000 open, 1000 read, and then 1000
close calls, right?  :)

> With something like this the stats for 1000 processes could be
> retrieved with an open, a few reads and a close.

And have you benchmarked any of this?  Try working with the common tools
that want this information and see if it actually is noticeable (hint, I
have been doing that with the readfile work and it's surprising what the
results are in places...)

> 
> > 
> > > The proposed files in this proof-of-concept patch set are:
> > > 
> > > * /proc/all/stat
> > 
> > I think the problem will be defining "all" in the case of the specific
> > namespace you are dealing with, right?  How will this handle all of
> > those issues properly for all of these different statisics?
> > 
> 
> Currently I'm trying to re-use the existing code in fs/proc that
> controls which PIDs are visible, but may well be missing something..

Try it out and see if it works correctly.  And pid namespaces are not
the only thing these days from what I call :)

thanks,

greg k-h
