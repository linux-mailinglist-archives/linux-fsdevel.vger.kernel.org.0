Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D43D0E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhGULP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 07:15:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbhGUKvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:51:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C0C23224C6;
        Wed, 21 Jul 2021 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626867134;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXIGlG4Bf+RC6Mu0Mbl8I+h7zUqqLKJW8X4G0r/blT8=;
        b=B/FdKPmRip1bieNu7+mRsk9fj+eHRixk9MbAJSnRj8uxBa3AG5aAyGS8gJRhQ49/7j9SNT
        AdqRX64d6yZ7h9/Q10yMxc0+4En5/1CxWGTVtqzs39Xfo3epke66ZDFg/hqjYgl0+b21OT
        aei5jsuP/vOqKxarmzUSeqUJMLrbsfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626867134;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXIGlG4Bf+RC6Mu0Mbl8I+h7zUqqLKJW8X4G0r/blT8=;
        b=zEdtWbSlAjVfCFNPF7z2UxfYWpR0Mx+8R5BTbrpvla/737/6F9o12dQ6oBMfWunnSBKm9d
        HEKasjVXJ+8zy2BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B8A28A3B84;
        Wed, 21 Jul 2021 11:32:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ACA11DA704; Wed, 21 Jul 2021 13:29:33 +0200 (CEST)
Date:   Wed, 21 Jul 2021 13:29:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] ENOSPC delalloc flushing fixes
Message-ID: <20210721112933.GD19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 02:47:16PM -0400, Josef Bacik wrote:
> Josef Bacik (9):
>   btrfs: wake up async_delalloc_pages waiters after submit
>   btrfs: include delalloc related info in dump space info tracepoint
>   btrfs: enable a tracepoint when we fail tickets
>   btrfs: handle shrink_delalloc pages calculation differently
>   btrfs: wait on async extents when flushing delalloc
>   fs: add a filemap_fdatawrite_wbc helper
>   btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
>   9p: migrate from sync_inode to filemap_fdatawrite_wbc
>   fs: kill sync_inode
> 
>  fs/9p/vfs_file.c             |  7 +--
>  fs/btrfs/ctree.h             |  9 ++--
>  fs/btrfs/inode.c             | 16 +++----
>  fs/btrfs/space-info.c        | 82 ++++++++++++++++++++++++++++++------
>  fs/fs-writeback.c            | 19 +--------
>  include/linux/fs.h           |  3 +-
>  include/trace/events/btrfs.h | 21 +++++++--
>  mm/filemap.c                 | 35 +++++++++++----
>  8 files changed, 128 insertions(+), 64 deletions(-)

I'll put it to my tree and it will appear in linux-next soon. The last
two patches are not related to btrfs so I can send them separately or
leave it in the series if nobody objects.
