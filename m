Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832D3399D40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFCI5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 04:57:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCI5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:57:18 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 64612219C5;
        Thu,  3 Jun 2021 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622710533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIOxNU1duYBfgVuU9mt4p24VirH3+QjG2w2OYJ8d90c=;
        b=2hpWCslxLLtGCCWtysJ7jRTKBINYmROH9dzl/5wNgZtwi8BbH0WG+bkGYlrMx8Y4KgFjKp
        gxBonS11D/IuUj77yERwAA1qWIpRnAhGP0RC8EZW1/YKgXWRXDwECCNFeM/ufkBW3rWZvk
        EiuU4Uv2PbWXIBbsRaNZDlDEk0lrVrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622710533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIOxNU1duYBfgVuU9mt4p24VirH3+QjG2w2OYJ8d90c=;
        b=MXL5tu1JjXvjC9fHdV5Hcah8cj4YgrDkZjMPSRC8nifOFwOkzmg8JLjJtZ05spNTbQvMUo
        3Z4xh6HQPPzX0SDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 560A4A3B87;
        Thu,  3 Jun 2021 08:55:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33C101F2C98; Thu,  3 Jun 2021 10:55:33 +0200 (CEST)
Date:   Thu, 3 Jun 2021 10:55:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 2/5] writeback, cgroup: keep list of inodes attached
 to bdi_writeback
Message-ID: <20210603085533.GE23647@quack2.suse.cz>
References: <20210603005517.1403689-1-guro@fb.com>
 <20210603005517.1403689-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603005517.1403689-3-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-06-21 17:55:14, Roman Gushchin wrote:
> Currently there is no way to iterate over inodes attached to a
> specific cgwb structure. It limits the ability to efficiently
> reclaim the writeback structure itself and associated memory and
> block cgroup structures without scanning all inodes belonging to a sb,
> which can be prohibitively expensive.
> 
> While dirty/in-active-writeback an inode belongs to one of the
> bdi_writeback's io lists: b_dirty, b_io, b_more_io and b_dirty_time.
> Once cleaned up, it's removed from all io lists. So the
> inode->i_io_list can be reused to maintain the list of inodes,
> attached to a bdi_writeback structure.
> 
> This patch introduces a new wb->b_attached list, which contains all
> inodes which were dirty at least once and are attached to the given
> cgwb. Inodes attached to the root bdi_writeback structures are never
> placed on such list. The following patch will use this list to try to
> release cgwbs structures more efficiently.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good, just one small comment below, with that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

...
> @@ -1014,6 +1024,12 @@ fs_initcall(cgroup_writeback_init);
>  static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
>  static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
>  
> +static void inode_cgwb_move_to_attached(struct inode *inode,
> +					struct bdi_writeback *wb)
> +{
> +	list_del_init(&inode->i_io_list);
> +}
> +

I think you miss clearing of I_SYNC_QUEUED here. Also you could add here
the lock assertions that are in the other version of
inode_cgwb_move_to_attached().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
