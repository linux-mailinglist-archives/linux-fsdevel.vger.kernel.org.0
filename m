Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA16433D79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhJSRav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhJSRau (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BE4F61355;
        Tue, 19 Oct 2021 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634664517;
        bh=59LlQsuP3ZW+Cqkg0bmKDDTdZJ6xYatNGwXXx+Ql12c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWZi9VFvsWHjYkDIPd8f49GxBVmj/S9NVGgH7d94tK3kKeCF+lF3syMiKzMmqfuyg
         JEHxrMIxVUmTbr2P3UxsxW/NFBzES4GLdSmR5jSm9QRoc0t7a8kiYYJnuP8TXiAFgt
         ifpV2BfQaooqVVlB4sG6JiSoyYkjtUSC8FI4Ss/k=
Date:   Tue, 19 Oct 2021 19:28:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW8AQ4fMNV8MT1vX@kroah.com>
References: <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
 <YW7xbnrqfzifa9OC@kroah.com>
 <YW7yjQVC4NRfrWxD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW7yjQVC4NRfrWxD@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:30:05AM -0700, Luis Chamberlain wrote:
> On Tue, Oct 19, 2021 at 06:25:18PM +0200, Greg KH wrote:
> > On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> > > So do you want to take the position:
> > > 
> > > Hey driver authors: you cannot use any shared lock on module removal and
> > > on sysfs ops?
> > 
> > Yes, I would not recommend using such a lock at all.  sysfs operations
> > happen on a per-device basis, so you can lock the device structure.
> 
> All devices are going to be removed on module removal and so cannot be locked.

devices are not normally created by a driver, that is up to the bus
controller logic.  A module will just disconnect itself from the device,
the device does not go away.

But yes, there are exceptions, and if you are doing something odd like
that, then you need to be aware of crazy things like this, so be
careful.  But for all normal drivers, they do not have to worry about
this.

thanks,

greg k-h
