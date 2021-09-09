Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7D40466D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbhIIHlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352712AbhIIHlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:41:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797EC061575;
        Thu,  9 Sep 2021 00:40:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e23so1900389lfj.9;
        Thu, 09 Sep 2021 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N5HUducwPfP2mVYyobADtNaS3Agf61PgT8Wrbr3+ku0=;
        b=hulVTHZkuoqplQWlGElph19Q1JzG/elLbc8jBBwJ5zUdj7JuncjtgXZbhqytDKBuXV
         vh8uCo+abboqQqNg5deAvy1+bsXSRdDbHEws2/MhYDscgyJAGG9OJbh9eryJTaWBbr7g
         +yZcjz7V2uhUvS7yQBVKXoHReSVPWmoF07waSsIjmBnlaQjokNj/Y0CZ6EHPV4cZ1iiK
         wszUp1cOBmO5fKXxwlBCqvXG7N8aESEgsWJ5sr0FJmro+obik1Eu+RNi3drD0oOrwgYl
         ndnFiIyntfxuvErDW02MD2uwg2Kb08PuUPiF+F0Bl3arp1jxHIqYCpQVDlK+MZRtBc1c
         NUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=N5HUducwPfP2mVYyobADtNaS3Agf61PgT8Wrbr3+ku0=;
        b=N61iGiMY4eIyTHfGPAnmzxE7Hh9s0DLJobKZpgy3Lj9CQaed+vpgewiWwRIsRaULz7
         rVHBhu95KiUJaYwQUSKmfF+uBDDvB1jxaT4Lvwv98l1bT2hT6LMy7MaWyNrOdttFrJYU
         WfNgD+MMlk8AbIZcddxTph8vRwjH0HPoMXomO/MJTY0CHkY4dmjyuL2+0JBQz3UJWl7i
         R+XBHd+6HBIjV+58W7vM0p+x3IK4HnKL+G4zbhs/2FT8AhG0ATHjzcagKsscTiv1vKTY
         faNeOu31GpoRkc/KoARbTD8f8cNDjNPVjQxlsJ4O35DqITNVTe07z7IGoNhfIwOgPR5C
         QIuQ==
X-Gm-Message-State: AOAM5338/kjqoanZznKTO/cnoQOLr+giA08rcGWBOo5IIgbqg34n4AhZ
        zstyhihub5+0Li8EQns8ye0J98HASDx/mQ==
X-Google-Smtp-Source: ABdhPJwu+S3dYYU/kD62ZIEBvdF6NUyPaL3z0/tE2+3qoT9bC00i4dooPWE1voEZDGxKyPUbGY8GrQ==
X-Received: by 2002:a05:6512:33ca:: with SMTP id d10mr1321176lfg.282.1631173204828;
        Thu, 09 Sep 2021 00:40:04 -0700 (PDT)
Received: from t470.station.com ([2001:999:81:ae2f:f92d:3925:ba7c:cab2])
        by smtp.gmail.com with ESMTPSA id x6sm110642lfd.208.2021.09.09.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:40:04 -0700 (PDT)
Message-ID: <45c8affcfc62182ad6e0f816914d8834d6e9c625.camel@gmail.com>
Subject: Re: [PATCH 0/6] afs: Fixes for 3rd party-induced data corruption
From:   markus.suvanto@gmail.com
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Sep 2021 10:40:02 +0300
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ke, 2021-09-08 kello 16:57 +0100, David Howells kirjoitti:
> Here are some fixes for AFS that can cause data corruption due to
> interaction with another client modifying data cached locally[1].
> 
>  (1) When d_revalidating a dentry, don't look at the inode to which it
>      points.  Only check the directory to which the dentry belongs.  This
>      was confusing things and causing the silly-rename cleanup code to
>      remove the file now at the dentry of a file that got deleted.
> 
>  (2) Fix mmap data coherency.  When a callback break is received that
>      relates to a file that we have cached, the data content may have been
>      changed (there are other reasons, such as the user's rights having
>      been changed).  However, we're checking it lazily, only on entry to
>      the kernel, which doesn't happen if we have a writeable shared mapped
>      page on that file.
> 
>      We make the kernel keep track of mmapped files and clear all PTEs
>      mapping to that file as soon as the callback comes in by calling
>      unmap_mapping_pages() (we don't necessarily want to zap the
>      pagecache).  This causes the kernel to be reentered when userspace
>      tries to access the mmapped address range again - and at that point we
>      can query the server and, if we need to, zap the page cache.
> 
>      Ideally, I would check each file at the point of notification, but
>      that involves poking the server[*] - which is holding up final closure
>      of the change it is making, waiting for all the clients it notified to
>      reply.  This could then deadlock against the server.  Further,
>      invalidating the pagecache might call ->launder_page(), which would
>      try to write to the file, which would definitely deadlock.  (AFS
>      doesn't lease file access).
> 
>      [*] Checking to see if the file content has changed is a matter of
>      	 comparing the current data version number, but we have to ask the
>      	 server for that.  We also need to get a new callback promise and
>      	 we need to poke the server for that too.
> 
>  (3) Add some more points at which the inode is validated, since we're
>      doing it lazily, notably in ->read_iter() and ->page_mkwrite(), but
>      also when performing some directory operations.
> 
>      Ideally, checking in ->read_iter() would be done in some derivation of
>      filemap_read().  If we're going to call the server to read the file,
>      then we get the file status fetch as part of that.
> 
>  (4) The above is now causing us to make a lot more calls to afs_validate()
>      to check the inode - and afs_validate() takes the RCU read lock each
>      time to make a quick check (ie. afs_check_validity()).  This is
>      entirely for the purpose of checking cb_s_break to see if the server
>      we're using reinitialised its list of callbacks - however this isn't a
>      very common operation, so most of the time we're taking this
>      needlessly.
> 
>      Add a new cell-wide counter to count the number of reinitialisations
>      done by any server and check that - and only if that changes, take the
>      RCU read lock and check the server list (the server list may change,
>      but the cell a file is part of won't).
> 
>  (5) Don't update vnode->cb_s_break and ->cb_v_break inside the validity
>      checking loop.  The cb_lock is done with read_seqretry, so we might go
>      round the loop a second time after resetting those values - and that
>      could cause someone else checking validity to miss something (I
>      think).
> 
> Also included are patches for fixes for some bugs encountered whilst
> debugging this.
> 
>  (6) Fix a leak of afs_read objects and fix a leak of keys hidden by that.
> 
>  (7) Fix a leak of pages that couldn't be added to extend a writeback.
> 
> 
> The patches can be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes
> 
> David
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214217 [1]
> 
> ---
> David Howells (6):
>       afs: Fix missing put on afs_read objects and missing get on the key therein
>       afs: Fix page leak
>       afs: Add missing vnode validation checks
>       afs: Fix incorrect triggering of sillyrename on 3rd-party invalidation
>       afs: Fix mmap coherency vs 3rd-party changes
>       afs: Try to avoid taking RCU read lock when checking vnode validity
> 
> 
>  fs/afs/callback.c          | 44 ++++++++++++++++++-
>  fs/afs/cell.c              |  2 +
>  fs/afs/dir.c               | 57 ++++++++----------------
>  fs/afs/file.c              | 83 ++++++++++++++++++++++++++++++++++-
>  fs/afs/inode.c             | 88 +++++++++++++++++++-------------------
>  fs/afs/internal.h          | 10 +++++
>  fs/afs/rotate.c            |  1 +
>  fs/afs/server.c            |  2 +
>  fs/afs/super.c             |  1 +
>  fs/afs/write.c             | 27 ++++++++++--
>  include/trace/events/afs.h |  8 +++-
>  mm/memory.c                |  1 +
>  12 files changed, 230 insertions(+), 94 deletions(-)
> 
> 



Tested-By: Markus Suvanto <markus.suvanto@gmail.com>



