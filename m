Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA811CC721
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgEJGVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgEJGVB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:21:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0752082E;
        Sun, 10 May 2020 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589091660;
        bh=ykU5Chtjjs/h2pWxDILMKNjujFPoh+jfp41AJ916jkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsYRtFkS2rH27mGlJmEDwOKT52jC3bQqxZ7jLtVD/igAnz/9nBCUIGfYKHcNcqGnc
         vmlxkJecvTGwv+zEXIfwYXHaalOEQTI+OhJXsE2eDnxNMF7/Mou/bkudpHECUyMO0m
         TLqVb8Mynio93dyMpUzgkue+u6aCFLbHxKWIVD9I=
Date:   Sun, 10 May 2020 08:20:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200510062058.GA3394360@kroah.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509031058.8239-2-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 03:10:54AM +0000, Luis Chamberlain wrote:
> Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
> v4.12 moved the work behind blk_release_queue() into a workqueue after a
> splat floated around which indicated some work on blk_release_queue()
> could sleep in blk_exit_rl(). This splat would be possible when a driver
> called blk_put_queue() or blk_cleanup_queue() (which calls blk_put_queue()
> as its final call) from an atomic context.
> 
> blk_put_queue() decrements the refcount for the request_queue kobject,
> and upon reaching 0 blk_release_queue() is called. Although blk_exit_rl()
> is now removed through commit db6d9952356 ("block: remove request_list code")
> on v5.0, we reserve the right to be able to sleep within blk_release_queue()
> context.
> 
> The last reference for the request_queue must not be called from atomic
> context. *When* the last reference to the request_queue reaches 0 varies,
> and so let's take the opportunity to document when that is expected to
> happen and also document the context of the related calls as best as possible
> so we can avoid future issues, and with the hopes that the synchronous
> request_queue removal sticks.
> 
> We revert back to synchronous request_queue removal because asynchronous
> removal creates a regression with expected userspace interaction with
> several drivers. An example is when removing the loopback driver, one
> uses ioctls from userspace to do so, but upon return and if successful,
> one expects the device to be removed. Likewise if one races to add another
> device the new one may not be added as it is still being removed. This was
> expected behavior before and it now fails as the device is still present
> and busy still. Moving to asynchronous request_queue removal could have
> broken many scripts which relied on the removal to have been completed if
> there was no error. Document this expectation as well so that this
> doesn't regress userspace again.
> 
> Using asynchronous request_queue removal however has helped us find
> other bugs. In the future we can test what could break with this
> arrangement by enabling CONFIG_DEBUG_KOBJECT_RELEASE.

You are adding documenation and might_sleep() calls all over the place
in here, making the "real" change in the patch hard to pick out.

How about you split this up into 3 patches, one for documentation, one
for might_sleep() and one for the real change?  Or maybe just 2 patches,
but what you have here seems excessive.

thanks,

greg k-h
