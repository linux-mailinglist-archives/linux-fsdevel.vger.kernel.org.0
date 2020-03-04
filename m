Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72B17997A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 21:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgCDUGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 15:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDUGD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:06:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BED52084E;
        Wed,  4 Mar 2020 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583352362;
        bh=osoJB3Af195Y3PFS+hxKdBPcCaye1fL7HWQ2JbsfPX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeS4LkZ20W0zV6iKD2uJbMPshlUoSupeW0/AE8qeUqF0rhulKQpd+1ZammbpgbgYR
         R/+bZEP/6HR7iva5GTicIjsptvK/EhV19C3Ong8qytiaRNeZ/tNA1YZOLJBXc4kixu
         cgcJFeTwdTAo4TNMi7Jqyfk7mZ8NbOCRlbxOuUSc=
Date:   Wed, 4 Mar 2020 21:05:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304200559.GA1906005@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304185056.GM189690@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:50:56PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 04, 2020 at 06:22:21PM +0100, Greg Kroah-Hartman wrote:
> > Ugh, I was dreading the fact that this day might sometime come...
> > 
> > In theory, the reference counting for struct device shouldn't need to
> > use rcu at all, right?  what is driving the need to use rcu for
> 
> Lifetime rules in block layer are kinda nebulous. Some of it comes
> from the fact that some objects are reused. Instead of the usual,
> create-use-release, they get repurposed to be associated with
> something else. When looking at such an object from some paths, we
> don't necessarily have ownership of all of the members.

That's horrid, it's not like block devices are on some "fast path" for
tear-down, we should do it correctly.

> > backing_device_info?  Are these being destroyed/used so often that rcu
> > really is the best solution and the existing reference counting doesn't
> > work properly?
> 
> It's more that there are entry points which can only ensure that just
> the top level object is valid and the member objects might be going or
> coming as we're looking at it.

That's not ok, a "member object" can only be valid if you have a
reference to it.  If you remove the object, you then drop the reference,
shouldn't that be the correct thing to do?

thanks,

greg k-h
