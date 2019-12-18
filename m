Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814B6124712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLRMky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 07:40:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLRMky (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:40:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84F4FAE24;
        Wed, 18 Dec 2019 12:40:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 227081E0B2D; Wed, 18 Dec 2019 13:40:52 +0100 (CET)
Date:   Wed, 18 Dec 2019 13:40:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Bcachefs update
Message-ID: <20191218124052.GB19387@quack2.suse.cz>
References: <20191216193852.GA8664@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216193852.GA8664@kmo-pixel>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 16-12-19 14:38:52, Kent Overstreet wrote:
> Pagecache consistency:
> 
> I recently got rid of my pagecache add lock; that added locking to core paths in
> filemap.c and some found my locking scheme to be distastefull (and I never liked
> it enough to argue). I've recently switched to something closer to XFS's locking
> scheme (top of the IO paths); however, I do still need one patch to the
> get_user_pages() path to avoid deadlock via recursive page fault - patch is
> below:
> 
> (This would probably be better done as a new argument to get_user_pages(); I
> didn't do it that way initially because the patch would have been _much_
> bigger.)
> 
> Yee haw.
> 
> commit 20ebb1f34cc9a532a675a43b5bd48d1705477816
> Author: Kent Overstreet <kent.overstreet@gmail.com>
> Date:   Wed Oct 16 15:03:50 2019 -0400
> 
>     mm: Add a mechanism to disable faults for a specific mapping
>     
>     This will be used to prevent a nasty cache coherency issue for O_DIRECT
>     writes; O_DIRECT writes need to shoot down the range of the page cache
>     corresponding to the part of the file being written to - but, if the
>     file is mapped in, userspace can pass in an address in that mapping to
>     pwrite(), causing those pages to be faulted back into the page cache
>     in get_user_pages().
>     
>     Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

I'm not really sure about the exact nature of the deadlock since the
changelog doesn't explain it but if you need to take some lockA in your
page fault path and you already hold lockA in your DIO code, then this
patch isn't going to cut it. Just think of a malicious scheme with two
tasks one doing DIO from fileA (protected by lockA) to buffers mapped from
fileB and the other process the other way around...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
