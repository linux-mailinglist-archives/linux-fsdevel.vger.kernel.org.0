Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF91AFDC4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDSTrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:47:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:37240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDSTrk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3171AC40;
        Sun, 19 Apr 2020 19:47:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83B1DDA727; Sun, 19 Apr 2020 21:46:56 +0200 (CEST)
Date:   Sun, 19 Apr 2020 21:46:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: call __clear_page_buffers to simplify code
Message-ID: <20200419194656.GA18421@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200418225123.31850-3-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418225123.31850-3-guoqing.jiang@cloud.ionos.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:51:20AM +0200, Guoqing Jiang wrote:
> Some places can be replaced with __clear_page_buffers after the function
> is exported.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  fs/btrfs/disk-io.c   |  5 ++---
>  fs/btrfs/extent_io.c |  6 ++----
>  fs/btrfs/inode.c     | 14 ++++----------
>  3 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a6cb5cbbdb9f..0f1e5690e8a4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/crc32c.h>
>  #include <linux/sched/mm.h>
> +#include <linux/buffer_head.h>

I'm not really thrilled to see buffer_head.h being added back, we're on
the track to remove buffer_head usage completely and adding it just for
one helper does not seem great to me.
