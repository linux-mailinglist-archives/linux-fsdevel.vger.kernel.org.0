Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A41796B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDR3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDR3K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:29:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2A7217F4;
        Wed,  4 Mar 2020 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342949;
        bh=zqpcFyI4u9DNTEIPSy0xcyZbDS5aizxoROBvTBI1qxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CI4sg67S04Fupz8SqDMlgxYcOSe1JbwSTxmVwvVjuFq6IiZaXLz01URo8aYvAPaaj
         i2lHD+HpgN2vegGSpMS6vf+9d4HPegVeLMfaKEQctWFIeEcsZ3IyXcoHJPVfmah25U
         EuE9UOe6dmDN/+LS2eDPk4la43PpnHpKY5P6uMGY=
Date:   Wed, 4 Mar 2020 18:29:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 0/7] bdi: fix use-after-free for bdi device
Message-ID: <20200304172907.GA1864710@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:18:44PM +0800, Yufen Yu wrote:
> Hi, all 
> 
> We have reported a use-after-free crash for bdi device in
> __blkg_prfill_rwstat() (see Patch #3). The bug is caused by printing
> device kobj->name while the device and kobj->name has been freed by
> bdi_unregister().

How does that happen?  Who has access to a kobject without also having
the reference count incremented at the same time?  Is this through sysfs
or somewhere within the kernel itself?

> In fact, commit 68f23b8906 "memcg: fix a crash in wb_workfn when
> a device disappears" has tried to address the issue, but the code
> is till somewhat racy after that commit.

That commit is really odd, and I think is just papering over the real
issue, which is shown in the changelog for that commit.

A kobject can be unregistered, like bdi_unregister() does, even if there
are active references for it.  But someone needs to also go around and
decrement those references in order for things to be properly freed.

It feels like the use of struct device (and by virtue of that, struct
kobject and really a kref) here is not being done correctly at all.

The rule should be, "whenever you pass a pointer to a device off, the
reference count is incremented".  Somehow that is not happening here and
RCU is not going to solve the issue really, it's only going to delay the
problem from showing up until much later.

> In this patchset, we try to protect device lifetime with RCU, avoiding
> the device been freed when others used.

The struct device refcount should be all that is needed, don't use RCU
just to "delay freeing this object until some later time because someone
else might have a pointer to id".  That's ripe for disaster.

> A way which maybe fix the problem is copy device name into special
> memory (as discussed in [0]), but that is also need lock protect.

Hah, all that is needed is the name here?  That's sad.

thanks,

greg k-h
