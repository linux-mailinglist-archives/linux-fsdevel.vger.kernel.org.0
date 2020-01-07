Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9203133777
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 00:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgAGXdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 18:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAGXdt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:33:49 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0392077B;
        Tue,  7 Jan 2020 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578440028;
        bh=u8iR85rry1MpeqLP5gJ4zjdABts0KXbUZgOU7bTsE10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ilvREyiFi6LrKVMvjxwsFq198CcA7szEsG9h9AqNeNkfsLHxl5HrqHF/kILi4rX9D
         rgeEdUC2W2xnsCRGTFoMASIyLzYv7cTP3hmeWExe3MN9gR9wSTkCl8QmI8Rl7UBPyJ
         MGKFkg4QR43221u7OqxW/0VKzhSior3vgXAoSquY=
Date:   Tue, 7 Jan 2020 15:33:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH -v2] memcg: fix a crash in wb_workfn when a device
 disappears
Message-Id: <20200107153348.388a20e85e045d209c459e52@linux-foundation.org>
In-Reply-To: <20191228005211.163952-1-tytso@mit.edu>
References: <20191227194829.150110-1-tytso@mit.edu>
        <20191228005211.163952-1-tytso@mit.edu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 27 Dec 2019 19:52:11 -0500 "Theodore Ts'o" <tytso@mit.edu> wrote:

> Without memcg, there is a one-to-one mapping between the bdi and
> bdi_writeback structures.  In this world, things are fairly
> straightforward; the first thing bdi_unregister() does is to shutdown
> the bdi_writeback structure (or wb), and part of that writeback
> ensures that no other work queued against the wb, and that the wb is
> fully drained.
> 
> With memcg, however, there is a one-to-many relationship between the
> bdi and bdi_writeback structures; that is, there are multiple wb
> objects which can all point to a single bdi.  There is a refcount
> which prevents the bdi object from being released (and hence,
> unregistered).  So in theory, the bdi_unregister() *should* only get
> called once its refcount goes to zero (bdi_put will drop the refcount,
> and when it is zero, release_bdi gets called, which calls
> bdi_unregister).
> 
> Unfortunately, del_gendisk() in block/gen_hd.c never got the memo
> about the Brave New memcg World, and calls bdi_unregister directly.
> It does this without informing the file system, or the memcg code, or
> anything else.  This causes the root wb associated with the bdi to be
> unregistered, but none of the memcg-specific wb's are shutdown.  So when
> one of these wb's are woken up to do delayed work, they try to
> dereference their wb->bdi->dev to fetch the device name, but
> unfortunately bdi->dev is now NULL, thanks to the bdi_unregister()
> called by del_gendisk().   As a result, *boom*.
> 
> Fortunately, it looks like the rest of the writeback path is perfectly
> happy with bdi->dev and bdi->owner being NULL, so the simplest fix is
> to create a bdi_dev_name() function which can handle bdi->dev being
> NULL.  This also allows us to bulletproof the writeback tracepoints to
> prevent them from dereferencing a NULL pointer and crashing the kernel
> if one is tracing with memcg's enabled, and an iSCSI device dies or a
> USB storage stick is pulled.
> 

Is hotremoval of a device while tracing writeback the only known way of
triggering this?

Is it worth a cc:stable?
