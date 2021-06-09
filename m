Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114223A0AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 05:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhFIDez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 23:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhFIDez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623209581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umLfKhpHP+RuI0WJ/3k+B1+HOsxB0tKVXkMkbJg5ENY=;
        b=EgkCaflislYmV2wtljTTAuRVJl5/xGuU2FXFZuMN6wjsX6d9+3m2opv6CrvMDAztqaDO1Z
        GIC0ewhmhFR+5YN1//dev5C/H0BTOR4mn3EvIR0QzBwgWE65Nsq4ehwHFYnjCAqm2qemi0
        BTgd/Sgvd2wkO0bbb1FMvQJAclkwFfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ygZ5VinmNvipqjSqZSKDzQ-1; Tue, 08 Jun 2021 23:33:00 -0400
X-MC-Unique: ygZ5VinmNvipqjSqZSKDzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943FA107ACCA;
        Wed,  9 Jun 2021 03:32:58 +0000 (UTC)
Received: from T590 (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C77F5C1BB;
        Wed,  9 Jun 2021 03:32:48 +0000 (UTC)
Date:   Wed, 9 Jun 2021 11:32:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v9 3/8] writeback, cgroup: increment isw_nr_in_flight
 before grabbing an inode
Message-ID: <YMA2XEnJrHyVLWrD@T590>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608230225.2078447-4-guro@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 04:02:20PM -0700, Roman Gushchin wrote:
> isw_nr_in_flight is used do determine whether the inode switch queue
> should be flushed from the umount path. Currently it's increased
> after grabbing an inode and even scheduling the switch work. It means
> the umount path can be walked past cleanup_offline_cgwb() with active
> inode references, which can result in a "Busy inodes after unmount."
> message and use-after-free issues (with inode->i_sb which gets freed).
> 
> Fix it by incrementing isw_nr_in_flight before doing anything with
> the inode and decrementing in the case when switching wasn't scheduled.
> 
> The problem hasn't yet been seen in the real life and was discovered
> by Jan Kara by looking into the code.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/fs-writeback.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index b6fc13a4962d..4413e005c28c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -505,6 +505,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	if (!isw)
>  		return;
>  
> +	atomic_inc(&isw_nr_in_flight);

smp_mb() may be required for ordering the WRITE in 'atomic_inc(&isw_nr_in_flight)'
and the following READ on 'inode->i_sb->s_flags & SB_ACTIVE'. Otherwise,
cgroup_writeback_umount() may observe zero of 'isw_nr_in_flight' because of
re-order of the two OPs, then miss the flush_workqueue().

Also this barrier should serve as pair of the one added in cgroup_writeback_umount(),
so maybe this patch should be merged with 2/8.


Thanks, 
Ming

