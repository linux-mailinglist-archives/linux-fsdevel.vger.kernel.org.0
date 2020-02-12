Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1048915A901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBLMVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 07:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbgBLMVW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:21:22 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C8D20658;
        Wed, 12 Feb 2020 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581510081;
        bh=YI35C/Ak/vnuDjJOcCV6/Sg8caVFwiL8FAlrYNnIQw8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ErJKLS2A4b1zqB7WCkf6D9bNQXT0PlhXDn7Zgtc8ejNb0mDiQOF7y42vQyZ9FVnKx
         di9lXJLpCxSR5nv3M4B3Rxfz0afJusoqVZAjrgz3RuE1Dqoi3UY2TQsGcRJuaxuhqq
         VirAaBYOzVaqj8Sc1KeMRhaKcEWIB3wKQYDKmcTE=
Message-ID: <13f20458cd8b72026cec364b6b8b8e4d636ebe94.camel@kernel.org>
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Date:   Wed, 12 Feb 2020 07:21:19 -0500
In-Reply-To: <20200207170423.377931-1-jlayton@kernel.org>
References: <20200207170423.377931-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-07 at 12:04 -0500, Jeff Layton wrote:
> You're probably wondering -- Where are v1 and v2 sets?
> 
> I did the first couple of versions of this set back in 2018, and then
> got dragged off to work on other things. I'd like to resurrect this set
> though, as I think it's valuable overall, and I have need of it for some
> other work I'm doing.
> 
> Currently, syncfs does not return errors when one of the inodes fails to
> be written back. It will return errors based on the legacy AS_EIO and
> AS_ENOSPC flags when syncing out the block device fails, but that's not
> particularly helpful for filesystems that aren't backed by a blockdev.
> It's also possible for a stray sync to lose those errors.
> 
> The basic idea is to track writeback errors at the superblock level,
> so that we can quickly and easily check whether something bad happened
> without having to fsync each file individually. syncfs is then changed
> to reliably report writeback errors, and a new ioctl is added to allow
> userland to get at the current errseq_t value w/o having to sync out
> anything.
> 
> I do have a xfstest for this. I do not yet have manpage patches, but
> I'm happy to roll some once there is consensus on the interface.
> 
> Caveats:
> 
> - Having different behavior for an O_PATH descriptor in syncfs is
>   a bit odd, but it means that we don't have to grow struct file. Is
>   that acceptable from an API standpoint?
> 

There are a couple of other options besides requiring an O_PATH fd here:

1) we could just add a new errseq_t field to struct file for this. On my
machine (x86_64) there is 4 bytes of padding at the end of struct file.
An errseq_t would slot in there without changing the slab object size.
YMMV on other arches of course.

2) we could add a new fcntl command value (F_SYNCFS or something?), that
would flip the fd to being suitable for syncfs. If you tried to use the
fd to do a fsync at that point, we could return an error.

Anyone else have other thoughts on how best to do this?

> - This adds a new generic fs ioctl to allow userland to scrape the
>   current superblock's errseq_t value. It may be best to present this
>   to userland via fsinfo() instead (once that's merged). I'm fine with
>   dropping the last patch for now and reworking it for fsinfo if so.
> 

To be clear, as I stated in earlier replies, I think we can drop the
ioctl. If we did want something like this, I think we'd want to expose
it via fsinfo() instead, and that could be done after the syncfs changes
went in.

> Jeff Layton (3):
>   vfs: track per-sb writeback errors and report them to syncfs
>   buffer: record blockdev write errors in super_block that it backs
>   vfs: add a new ioctl for fetching the superblock's errseq_t
> 
>  fs/buffer.c             |  2 ++
>  fs/ioctl.c              |  4 ++++
>  fs/open.c               |  6 +++---
>  fs/sync.c               |  9 ++++++++-
>  include/linux/errseq.h  |  1 +
>  include/linux/fs.h      |  3 +++
>  include/linux/pagemap.h |  5 ++++-
>  include/uapi/linux/fs.h |  1 +
>  lib/errseq.c            | 33 +++++++++++++++++++++++++++++++--
>  9 files changed, 57 insertions(+), 7 deletions(-)
> 

-- 
Jeff Layton <jlayton@kernel.org>

