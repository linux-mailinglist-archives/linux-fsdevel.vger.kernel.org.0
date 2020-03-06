Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82F717C2D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFQZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgCFQZv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:25:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B155B20658;
        Fri,  6 Mar 2020 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583511950;
        bh=YD7E31Aexg+OqXAcWfWJ0ofDgqY5kLfUVMXH5WOWi+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ5JFSNr+dsXHT0VBEHl6D29tc2aPCx7S1va4mKn+5SQxWG/BErwPdFTUIwyBxsmN
         QQ9jDomqSQMEkGxN1ZhAcWzXfyrprONWO1JPCrHxGuxvIV4PvvJhgreE3qAi1UrJ/6
         oE37rlumGF15D9T01A5lvNhSjEGWE40uzwknhunk=
Date:   Fri, 6 Mar 2020 17:25:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200306162547.GB3838587@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
 <20200304200559.GA1906005@kroah.com>
 <20200305012211.GA33199@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305012211.GA33199@mtj.duckdns.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 08:22:11PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 04, 2020 at 09:05:59PM +0100, Greg Kroah-Hartman wrote:
> > > Lifetime rules in block layer are kinda nebulous. Some of it comes
> > > from the fact that some objects are reused. Instead of the usual,
> > > create-use-release, they get repurposed to be associated with
> > > something else. When looking at such an object from some paths, we
> > > don't necessarily have ownership of all of the members.
> > 
> > That's horrid, it's not like block devices are on some "fast path" for
> > tear-down, we should do it correctly.
> 
> Yeah, it got retrofitted umpteenth times from the really early days. I
> don't think much of it is intentionally designed to be this way.
> 
> > > > backing_device_info?  Are these being destroyed/used so often that rcu
> > > > really is the best solution and the existing reference counting doesn't
> > > > work properly?
> > > 
> > > It's more that there are entry points which can only ensure that just
> > > the top level object is valid and the member objects might be going or
> > > coming as we're looking at it.
> > 
> > That's not ok, a "member object" can only be valid if you have a
> > reference to it.  If you remove the object, you then drop the reference,
> > shouldn't that be the correct thing to do?
> 
> I mean, it depends. There are two layers of objects and the top level
> object has two stacked lifetime rules. The "active" usage pins
> everything as usual. The "shallower" usage only has full access to the
> top level and when it reaches down into members it needs a different
> mechanism to ensure its validity. Given a clean slate, I don't think
> we'd go for this design for these objects but the usage isn't
> fundamentally broken.
> 
> Idk, for the problem at hand, the choice is between patching it up by
> copying the name and RCU protecting ->dev access at least for now.
> Both are nasty in their own ways but copying does have a smaller blast
> radius. So, copy for now?

Yes, copy for now, don't mess with RCU and the struct device lifetime,
that is not going to solve anything.

I'll put the "fix the lifetime rules in the block layer" on my todo
list, at the bottom :(

thanks,

greg k-h
