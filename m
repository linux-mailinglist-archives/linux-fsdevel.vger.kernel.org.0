Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5820204930
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 07:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgFWFVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 01:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbgFWFVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:21:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C63D20716;
        Tue, 23 Jun 2020 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592889694;
        bh=qcj1oy+YsTeJkEmfabJGHIuEEm8lk09hF25nMTjyERE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fyh2tiwsePA0O2LLe0TAZc+hz15iln34sieHfLaAeUJuVmnxM5OJ5Ux62qJQVhgi7
         VLlObODIYUGEZzx2goMBOCcqTUEQIcTnrBvCw/5PWvijhG2/f8dC43vODx5FzKVxhv
         gK13FqhYguejHu8T5BiIQ4l1Da6EVs6xTtnmNrcc=
Date:   Tue, 23 Jun 2020 07:21:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Ian Kent <raven@themaw.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200623052128.GB2252466@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
 <20200622174845.GB13061@mtj.duckdns.org>
 <20200622180306.GA1917323@kroah.com>
 <f9106e08-069d-1e58-96b1-6c63d2c62c16@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9106e08-069d-1e58-96b1-6c63d2c62c16@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:27:38PM -0700, Rick Lindsley wrote:
> 
> On Mon, Jun 22, 2020 at 01:48:45PM -0400, Tejun Heo wrote:
> 
> > It should be obvious that representing each consecutive memory range with a
> > separate directory entry is far from an optimal way of representing
> > something like this. It's outright silly.
> 
> On 6/22/20 11:03 AM, Greg Kroah-Hartman wrote:
> 
> > I agree.  And again, Ian, you are just "kicking the problem down the
> > road" if we accept these patches.  Please fix this up properly so that
> > this interface is correctly fixed to not do looney things like this.
> 
> Given that we cannot change the underlying machine representation of
> this hardware, what do you (all, not just you Greg) consider to be
> "properly"?

Change the userspace representation of the hardware then.  Why does
userspace care about so many individual blocks, what happens if you
provide them a larger granularity?  I can't imagine userspace really
wants to see 20k devices and manage them individually, where is the code
that does that?

What happens if you delay adding the devices until after booting?
Userspace should be event driven and only handle things after it sees
the devices being present, so try delaying and seeing what happens to
prevent this from keeping boot from progressing.

thanks,

greg k-h
