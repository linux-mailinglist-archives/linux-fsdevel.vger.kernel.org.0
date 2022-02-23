Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE84A4C0F70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiBWJou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiBWJot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:44:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A9710EC;
        Wed, 23 Feb 2022 01:44:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0378821119;
        Wed, 23 Feb 2022 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5LdVxHbdlA+uf9CLQhCcMqaY3XOkOjb0UEvQIcN930=;
        b=N0bwP6fspFLj+Xvt4UIU11GZMT4APSzUmtZpOpEGyjxGAf0Oxk0J+7II+FpWsIFfadMz/V
        K1lcmM0B3wN24G+kEmZGh88fj5Z5ltgfokEuX6X4oCgbCtXKoj0n4hQ4OO9oIhIYDjWyxa
        +Jw4h+qB51yMi/xheubAULBB+VuRhOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609461;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5LdVxHbdlA+uf9CLQhCcMqaY3XOkOjb0UEvQIcN930=;
        b=FC/O5i0eUWi0KDFKaDQz5r5HpA6ysn1yML6ouavxiNGl2W3TFKeQfl+tJb7O423nbq51bP
        pz13cHXSbu5W/dBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8175A3B85;
        Wed, 23 Feb 2022 09:44:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 97930A0605; Wed, 23 Feb 2022 10:44:20 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:44:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 6/9] ext4: Add commit tid info in ext4_fc_commit_start/stop
 trace events
Message-ID: <20220223094420.de6yx7dvgbux327o@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <dbc43257b4039b4bdba5613cd31fe65528721f3a.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc43257b4039b4bdba5613cd31fe65528721f3a.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:14, Ritesh Harjani wrote:
> This adds commit_tid info in ext4_fc_commit_start/stop which is helpful
> in debugging fast_commit issues.
> 
> For e.g. issues where due to jbd2 journal full commit, FC miss to commit
> updates to a file.
> 
> Also improves TP_prink format string i.e. all ext4 and jbd2 trace events
> starts with "dev MAjOR,MINOR". Let's follow the same convention while we
> are still at it.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c       |  4 ++--
>  include/trace/events/ext4.h | 21 +++++++++++++--------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index ee32aac0cbbf..8803ba087b07 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1150,7 +1150,7 @@ static void ext4_fc_update_stats(struct super_block *sb, int status,
>  	} else {
>  		stats->fc_skipped_commits++;
>  	}
> -	trace_ext4_fc_commit_stop(sb, nblks, status);
> +	trace_ext4_fc_commit_stop(sb, nblks, status, commit_tid);
>  }
>  
>  /*
> @@ -1171,7 +1171,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
>  		return jbd2_complete_transaction(journal, commit_tid);
>  
> -	trace_ext4_fc_commit_start(sb);
> +	trace_ext4_fc_commit_start(sb, commit_tid);
>  
>  	start_time = ktime_get();
>  
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cd09dccea502..6e66cb7ce624 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2685,26 +2685,29 @@ TRACE_EVENT(ext4_fc_replay,
>  );
>  
>  TRACE_EVENT(ext4_fc_commit_start,
> -	TP_PROTO(struct super_block *sb),
> +	TP_PROTO(struct super_block *sb, tid_t commit_tid),
>  
> -	TP_ARGS(sb),
> +	TP_ARGS(sb, commit_tid),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
> +		__field(tid_t, tid)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev = sb->s_dev;
> +		__entry->tid = commit_tid;
>  	),
>  
> -	TP_printk("fast_commit started on dev %d,%d",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev))
> +	TP_printk("dev %d,%d tid %u", MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->tid)
>  );
>  
>  TRACE_EVENT(ext4_fc_commit_stop,
> -	    TP_PROTO(struct super_block *sb, int nblks, int reason),
> +	    TP_PROTO(struct super_block *sb, int nblks, int reason,
> +		     tid_t commit_tid),
>  
> -	TP_ARGS(sb, nblks, reason),
> +	TP_ARGS(sb, nblks, reason, commit_tid),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
> @@ -2713,6 +2716,7 @@ TRACE_EVENT(ext4_fc_commit_stop,
>  		__field(int, num_fc)
>  		__field(int, num_fc_ineligible)
>  		__field(int, nblks_agg)
> +		__field(tid_t, tid)
>  	),
>  
>  	TP_fast_assign(
> @@ -2723,12 +2727,13 @@ TRACE_EVENT(ext4_fc_commit_stop,
>  		__entry->num_fc_ineligible =
>  			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
>  		__entry->nblks_agg = EXT4_SB(sb)->s_fc_stats.fc_numblks;
> +		__entry->tid = commit_tid;
>  	),
>  
> -	TP_printk("fc on [%d,%d] nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d",
> +	TP_printk("dev %d,%d nblks %d, reason %d, fc = %d, ineligible = %d, agg_nblks %d, tid %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->nblks, __entry->reason, __entry->num_fc,
> -		  __entry->num_fc_ineligible, __entry->nblks_agg)
> +		  __entry->num_fc_ineligible, __entry->nblks_agg, __entry->tid)
>  );
>  
>  #define FC_REASON_NAME_STAT(reason)					\
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
