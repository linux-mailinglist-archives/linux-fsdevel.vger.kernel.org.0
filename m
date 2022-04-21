Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFA50A482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390251AbiDUPoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389687AbiDUPom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:44:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506132EDE
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:41:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A3EC21112;
        Thu, 21 Apr 2022 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650555697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCq7mstxOUBiY8j5omGzDJp5fS9vDNJxU1OLjxmiTVg=;
        b=lckuOIyTRbW8UphKvXGl7Sgsr6qNS1G8ev4nQRX/5ygR6IIiwrKEgQYYClGjPkzgR65MHH
        6rcQu9J9ww6OhVZe662PDDV/xBXnXLpe/gqfGS/oZt2uSf9vs6ErOBs8x8bsLilFS/iHLK
        LMweLBL6eojGUf9MXE6VsawEmNOUmtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650555697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCq7mstxOUBiY8j5omGzDJp5fS9vDNJxU1OLjxmiTVg=;
        b=v+zw6KTLIpPjJG3PSMbEjnbhOJnVFwCI8+bvLF1PhtX67yJJdntn8jS7GOR07onmtyAqTj
        wt0vRJfrsJithgAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1AC832C14E;
        Thu, 21 Apr 2022 15:41:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CA31AA0620; Thu, 21 Apr 2022 17:41:36 +0200 (CEST)
Date:   Thu, 21 Apr 2022 17:41:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Evictable fanotify marks
Message-ID: <20220421154136.ywmdfbclytdxbve4@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 13-04-22 12:09:19, Amir Goldstein wrote:
> Following v3 patch set addresses your review comments on v2 [2].
> 
> Please see LTP test [3] and man page draft [4] for evictable marks.

Thanks for the patches! I've found just a few smaller issues so once those
are fixed, I'll queue the patches to my tree for the next merge window.

								Honza

> 
> Thanks,
> Amir.
> 
> Changes since v2 [2]:
> - Simplify group lock helpers (Jan)
> - Move FSNOTIFY_GROUP_NOFS flag to group object (Jan)
> - Split patch of fanotify_mark_user_flags() (Jan)
> - Fix bug in case of EEXIST
> - Drop ioctl for debugging
> - Rebased and tested on v5.18-rc1
> 
> Changes since v1 [1]:
> - Fixes for direct reclaim deadlock
> - Add ioctl for direct reclaim test
> - Rebrand as FAN_MARK_EVICTABLE
> - Remove FAN_MARK_CREATE and allow clearing FAN_MARK_EVICTABLE
> - Replace connector proxy_iref with HAS_IREF flag
> - Take iref in fsnotify_reclac_mark() rather than on add mark to list
> - Remove fsnotify_add_mark() allow_dups/flags argument
> - Remove pr_debug() prints
> 
> [1] https://lore.kernel.org/r/20220307155741.1352405-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/r/20220329074904.2980320-1-amir73il@gmail.com/
> [3] https://github.com/amir73il/ltp/commits/fan_evictable
> [4] https://github.com/amir73il/man-pages/commits/fan_evictable
> 
> Amir Goldstein (16):
>   inotify: show inotify mask flags in proc fdinfo
>   inotify: move control flags from mask to mark flags
>   fsnotify: fix wrong lockdep annotations
>   fsnotify: pass flags argument to fsnotify_add_mark() via mark
>   fsnotify: pass flags argument to fsnotify_alloc_group()
>   fsnotify: create helpers for group mark_mutex lock
>   inotify: use fsnotify group lock helpers
>   audit: use fsnotify group lock helpers
>   nfsd: use fsnotify group lock helpers
>   dnotify: use fsnotify group lock helpers
>   fsnotify: allow adding an inode mark without pinning inode
>   fanotify: create helper fanotify_mark_user_flags()
>   fanotify: factor out helper fanotify_mark_update_flags()
>   fanotify: implement "evictable" inode marks
>   fanotify: use fsnotify group lock helpers
>   fanotify: enable "evictable" inode marks
> 
>  fs/nfsd/filecache.c                  |  14 ++--
>  fs/notify/dnotify/dnotify.c          |  13 +--
>  fs/notify/fanotify/fanotify.h        |  12 +++
>  fs/notify/fanotify/fanotify_user.c   |  95 +++++++++++++++-------
>  fs/notify/fdinfo.c                   |  21 ++---
>  fs/notify/fsnotify.c                 |   4 +-
>  fs/notify/group.c                    |  32 +++++---
>  fs/notify/inotify/inotify.h          |  19 +++++
>  fs/notify/inotify/inotify_fsnotify.c |   2 +-
>  fs/notify/inotify/inotify_user.c     |  49 ++++++-----
>  fs/notify/mark.c                     | 117 ++++++++++++++++++---------
>  include/linux/fanotify.h             |   1 +
>  include/linux/fsnotify_backend.h     |  75 ++++++++++++-----
>  include/uapi/linux/fanotify.h        |   1 +
>  kernel/audit_fsnotify.c              |   6 +-
>  kernel/audit_tree.c                  |  34 ++++----
>  kernel/audit_watch.c                 |   2 +-
>  17 files changed, 330 insertions(+), 167 deletions(-)
> 
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
