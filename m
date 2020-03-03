Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A821776B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgCCNKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCNKW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:10:22 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B309820842;
        Tue,  3 Mar 2020 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583241021;
        bh=GUivKWtJ0hc5w+IWW+xdUUVwt4AOV4xypfGmVeG8obk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=2DHptrzLvXGqjt4aF8ToOLoi8KlVSviu7WYm+bc5etPR1UyLZfjEArvUVCjms2MSo
         JRtbUxKrFFjb6YgIKxmDMkhWTdAugW/zC/mQ4anP0LGlbUyjTr84Ek/VBshwgcBFRe
         tCQBp8L/sdiu6b2wCS6UEg+Vo54Oy5An8iQ7SPJ8=
Message-ID: <a4415d7d5d75e6af4cb275f753068186342ef7be.camel@kernel.org>
Subject: Re: [PATCH v4 0/2] vfs: have syncfs() return error when there are
 writeback errors
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        david@fromorbit.com, David Howells <dhowells@redhat.com>
Date:   Tue, 03 Mar 2020 08:10:19 -0500
In-Reply-To: <20200213210255.871579-1-jlayton@kernel.org>
References: <20200213210255.871579-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-13 at 16:02 -0500, Jeff Layton wrote:
> v4:
> - switch to dedicated errseq_t cursor in struct file for syncfs
> - drop ioctl for fetching the errseq_t without syncing
> 
> This is the fourth posting of this patchset. After thinking about it
> more, I think multiplexing file->f_wb_err based on O_PATH open is just
> too weird. I think it'd be better if syncfs() "just worked" as expected
> no matter what sort of fd you use, or how you multiplex it with fsync.
> 
> Also (at least on x86_64) there is currently a 4 byte pad at the end of
> the struct so this doesn't end up growing the memory utilization anyway.
> Does anyone object to doing this?
> 
> I've also dropped the ioctl patch. I have a draft patch to expose that
> via fsinfo, but that functionality is really separate from returning an
> error to syncfs. We can look at that after the syncfs piece is settled.
> 
> Jeff Layton (2):
>   vfs: track per-sb writeback errors and report them to syncfs
>   buffer: record blockdev write errors in super_block that it backs
> 
>  drivers/dax/device.c    |  1 +
>  fs/buffer.c             |  2 ++
>  fs/file_table.c         |  1 +
>  fs/open.c               |  3 +--
>  fs/sync.c               |  6 ++++--
>  include/linux/fs.h      | 16 ++++++++++++++++
>  include/linux/pagemap.h |  5 ++++-
>  7 files changed, 29 insertions(+), 5 deletions(-)
> 

Hi Al,

Wondering if you've had a chance to look at these yet? I think it makes
sense -- the only part I'm not sure about is adding a field to struct
file. That ends up inside the 4-byte pad at the end on x86_64, so my
hope is that that's not a problem.

If you're too busy at the moment, then maybe Andrew can help shepherd
this in instead?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

