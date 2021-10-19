Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A661433F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhJSTsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:48:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E596C06161C;
        Tue, 19 Oct 2021 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jCo7U915eFRqWzpvn4v1HPXwjv12FjYjhZ4kBCli1BA=; b=XQzRM95CX9ofAeF03oyBgo9tdr
        tca/b6ddAmgUpGHrIOgKOl7J+MmMtICCtW9iI9X/pIp9MDdL8jhpdq1WUpyF+AqNyJJXM+xcXea+Y
        A+/eXwEiUOwerfpiB9WrGkP+ywwG+ealnZuYQt1ByR+KUnhNAXDvKMFwufKpwEgRWHNiYPNEhnjoi
        bTJNL3eWVoeD+EBPCVAiiRgFpwqUUIkHuRc7HNZ6R8Ax6kfd/8src6qtI8PSnjLsvdemXY2lQiN4s
        fVHcuQayWAEmJ2qh+RFvpTD5WkbnMFHUROEQZMwM1v8B3T9/7bol/7RXJacyarkYcDITzTWqga2Vd
        eQK52yWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcv49-002XTn-Ah; Tue, 19 Oct 2021 19:46:29 +0000
Date:   Tue, 19 Oct 2021 12:46:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YW8glVdremhn1eF2@bombadil.infradead.org>
References: <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7pQKi8AlV+ZemU@bombadil.infradead.org>
 <YW7xbnrqfzifa9OC@kroah.com>
 <YW7yjQVC4NRfrWxD@bombadil.infradead.org>
 <YW8AQ4fMNV8MT1vX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8AQ4fMNV8MT1vX@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 07:28:35PM +0200, Greg KH wrote:
> On Tue, Oct 19, 2021 at 09:30:05AM -0700, Luis Chamberlain wrote:
> > On Tue, Oct 19, 2021 at 06:25:18PM +0200, Greg KH wrote:
> > > On Tue, Oct 19, 2021 at 08:50:24AM -0700, Luis Chamberlain wrote:
> > > > So do you want to take the position:
> > > > 
> > > > Hey driver authors: you cannot use any shared lock on module removal and
> > > > on sysfs ops?
> > > 
> > > Yes, I would not recommend using such a lock at all.  sysfs operations
> > > happen on a per-device basis, so you can lock the device structure.
> > 
> > All devices are going to be removed on module removal and so cannot be locked.
> 
> devices are not normally created by a driver, that is up to the bus
> controller logic.  A module will just disconnect itself from the device,
> the device does not go away.
> 
> But yes, there are exceptions, and if you are doing something odd like
> that, then you need to be aware of crazy things like this, so be
> careful.  But for all normal drivers, they do not have to worry about
> this.

"Recommend" is a weak position to take given a possible deadlock with sysfs.

Do we want to at the very least document this is not a supported scheme?

If so I can also add a simple 1 level indirrection coccinelle patch to
detect these schemes and complain about them as wel, if we are going to
take this position.

But to simply disregard this as "not an issue", or we won't do anything
seems pretty counter productive given we *do* had drivers with this
issue before *and* still have them upstream, and can end up with more
drivers like this later.

  Luis
