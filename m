Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBED41897A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 10:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCRJNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 05:13:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCRJNX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:13:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CCA8DAD6F;
        Wed, 18 Mar 2020 09:13:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E5E61E1159; Wed, 18 Mar 2020 10:13:18 +0100 (CET)
Date:   Wed, 18 Mar 2020 10:13:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Unregister sysfs path before destroying jbd2
 journal
Message-ID: <20200318091318.GJ22684@quack2.suse.cz>
References: <20200318061301.4320-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318061301.4320-1-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-03-20 11:43:01, Ritesh Harjani wrote:
> Call ext4_unregister_sysfs(), before destroying jbd2 journal,
> since below might cause, NULL pointer dereference issue.
> This got reported with LTP tests.
> 
> ext4_put_super() 		cat /sys/fs/ext4/loop2/journal_task
> 	| 				ext4_attr_show();
> ext4_jbd2_journal_destroy();  			|
>     	|				 journal_task_show()
> 	| 					|
> 	| 				task_pid_vnr(NULL);
> sbi->s_journal = NULL;
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Yeah, makes sence. Thanks for the patch! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5dc65b7583cb..27ab130a40d1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1024,6 +1024,13 @@ static void ext4_put_super(struct super_block *sb)
>  
>  	destroy_workqueue(sbi->rsv_conversion_wq);
>  
> +	/*
> +	 * Unregister sysfs before destroying jbd2 journal.
> +	 * Since we could still access attr_journal_task attribute via sysfs
> +	 * path which could have sbi->s_journal->j_task as NULL
> +	 */
> +	ext4_unregister_sysfs(sb);
> +
>  	if (sbi->s_journal) {
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
> @@ -1034,7 +1041,6 @@ static void ext4_put_super(struct super_block *sb)
>  		}
>  	}
>  
> -	ext4_unregister_sysfs(sb);
>  	ext4_es_unregister_shrinker(sbi);
>  	del_timer_sync(&sbi->s_err_report);
>  	ext4_release_system_zone(sb);
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
