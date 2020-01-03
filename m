Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12F12FB74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgACRPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:15:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51404 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727952AbgACRPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:15:25 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 003HFHUx023035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 12:15:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7E9C84200AF; Fri,  3 Jan 2020 12:15:17 -0500 (EST)
Date:   Fri, 3 Jan 2020 12:15:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v2] memcg: fix a crash in wb_workfn when a device
 disappears
Message-ID: <20200103171517.GA4253@mit.edu>
References: <20191227194829.150110-1-tytso@mit.edu>
 <20191228005211.163952-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228005211.163952-1-tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 07:52:11PM -0500, Theodore Ts'o wrote:
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
> Previous-Version-Link: https://lore.kernel.org/r/20191227194829.150110-1-tytso@mit.edu
> Google-Bug-Id: 145475544
> Tested: fs smoke test
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> Notes:
>     v2: add #include for linux/device.h
> 
>  fs/fs-writeback.c                |  2 +-
>  include/linux/backing-dev.h      | 10 +++++++++
>  include/trace/events/writeback.h | 37 +++++++++++++++-----------------
>  mm/backing-dev.c                 |  1 +
>  4 files changed, 29 insertions(+), 21 deletions(-)

Ping?

Any comments?  Any objections if I carry this patch[1] in the ext4
tree?  Or would it be better for Andrew to carry it in the linux-mm
tree?

[1] https://lore.kernel.org/k/20191227203117.152399-1-tytso@mit.edu

						- Ted
