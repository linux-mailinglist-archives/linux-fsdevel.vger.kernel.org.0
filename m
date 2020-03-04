Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1710317997E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 21:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgCDUH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 15:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDUH2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:07:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99D021739;
        Wed,  4 Mar 2020 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583352448;
        bh=OhH4Qz3RV4GUmNk48J4XpX4M/dWRlT017BqsJpHwBqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXp/r9RkraLOUsK1ISfVxq0qvjHM1+3SbAA0gZCNKVdc4UqNZvwSNiZblz+/zWRiF
         WdzcUp82k78OYhR6PgcSGi5WHfTAUDs+wNaqpl49ljyVZFuS7oBSKTwludRuZyz8MO
         +2rOGMfoSBg9tzSCv0HsXa8XBm02LUf4p08WkJjQ=
Date:   Wed, 4 Mar 2020 21:07:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 0/7] bdi: fix use-after-free for bdi device
Message-ID: <20200304200725.GB1906005@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200304172907.GA1864710@kroah.com>
 <20200304185739.GN189690@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304185739.GN189690@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:57:39PM -0500, Tejun Heo wrote:
> Hey, Greg.
> 
> On Wed, Mar 04, 2020 at 06:29:07PM +0100, Greg KH wrote:
> > How does that happen?  Who has access to a kobject without also having
> > the reference count incremented at the same time?  Is this through sysfs
> > or somewhere within the kernel itself?
> 
> Hopefully, this part was addressed in the other reply.

Yes, thanks.

> > The struct device refcount should be all that is needed, don't use RCU
> > just to "delay freeing this object until some later time because someone
> > else might have a pointer to id".  That's ripe for disaster.
> 
> I think it's an idiomatic use of rcu given the circumstances. Whether
> the circumstances are reasonable is totally debatable.

They are not reasonable :)

