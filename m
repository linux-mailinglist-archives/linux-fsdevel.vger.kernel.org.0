Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB53D203EAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgFVSDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 14:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgFVSDN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:03:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDD420767;
        Mon, 22 Jun 2020 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592848991;
        bh=sf8/mplLthAqskgiEZsXPw6w7CftioBvRj5sv4uz1Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWBZxmwZH0PGEvRXwtI9h6hxKphuB4OxNr5DHyY6mvYtVzEWN+m2EW9ecottvZm07
         DG3Y+aHiIN5WUo3lsDwoYv/M61/WjYJ9LazZ93TdwnrnoTqe8KUPQoFKGRPdCA0YbV
         gR7PNOJKxzZ5kJWSbH6E7klwSkR6bPk3A3diChsU=
Date:   Mon, 22 Jun 2020 20:03:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>, Ian Kent <raven@themaw.net>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200622180306.GA1917323@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
 <20200622174845.GB13061@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622174845.GB13061@mtj.duckdns.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:48:45PM -0400, Tejun Heo wrote:
> Hello, Ian.
> 
> On Sun, Jun 21, 2020 at 12:55:33PM +0800, Ian Kent wrote:
> > > > They are used for hotplugging and partitioning memory. The size of
> > > > the
> > > > segments (and thus the number of them) is dictated by the
> > > > underlying
> > > > hardware.
> > > 
> > > This sounds so bad. There gotta be a better interface for that,
> > > right?
> > 
> > I'm still struggling a bit to grasp what your getting at but ...
> 
> I was more trying to say that the sysfs device interface with per-object
> directory isn't the right interface for this sort of usage at all. Are these
> even real hardware pieces which can be plugged in and out? While being a
> discrete piece of hardware isn't a requirement to be a device model device,
> the whole thing is designed with such use cases on mind. It definitely isn't
> the right design for representing six digit number of logical entities.
> 
> It should be obvious that representing each consecutive memory range with a
> separate directory entry is far from an optimal way of representing
> something like this. It's outright silly.

I agree.  And again, Ian, you are just "kicking the problem down the
road" if we accept these patches.  Please fix this up properly so that
this interface is correctly fixed to not do looney things like this.

thanks,

greg k-h
