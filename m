Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635894C0F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiBWJzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 04:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBWJzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:55:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293235004B;
        Wed, 23 Feb 2022 01:54:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8747212BD;
        Wed, 23 Feb 2022 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645610095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2/idSB9fXW+xmw1hg7OGuisyq7dxhKOhhTInLEtK2s=;
        b=wZPKSmiSCZcskzrP3tVzE45X9E3kgf6W3OO+e+hR/cqh6E6vt2xL3uvJySuboktXVtFdNy
        lKPbTUQWEvyJYNOTh4us+OA05SL2FQW2JpqVVJJ7+BR1deQGKXtq6Qve+mncrYj7Ya1knt
        rVuiELESq1zm6l/nF7ZV7wRhLaL6m1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645610095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2/idSB9fXW+xmw1hg7OGuisyq7dxhKOhhTInLEtK2s=;
        b=jfouwePjGbWiHoVN7+wBr0W02UT0inBsUVHW11iSSePTu7PhnRCM99rGV0pE2hUFCTPXOL
        yr0ngDk3w3v0mBAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A98CBA3B81;
        Wed, 23 Feb 2022 09:54:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 612A8A0605; Wed, 23 Feb 2022 10:54:55 +0100 (CET)
Date:   Wed, 23 Feb 2022 10:54:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 2/9] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220223095455.3nlxqkem5y7dsniq@quack3.lan>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-02-22 02:04:10, Ritesh Harjani wrote:
> ftrace's __print_symbolic() requires that any enum values used in the
> symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
> so that the enum value can be encoded in the ftrace ring buffer.
> 
> This patch also fixes few other problems found in this trace point.
> e.g. dereferencing structures in TP_printk which should not be done
> at any cost.
> 
> Also to avoid checkpatch warnings, this patch removes those
> whitespaces/tab stops issues.
> 
> Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good (modulo Steven's nit). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/trace/events/ext4.h | 76 +++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 19e957b7f941..17fb9c506e8a 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -95,6 +95,16 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
>  	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
>  	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
>  
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_NOMEM);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_SWAP_BOOT);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RESIZE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
> +
>  #define show_fc_reason(reason)						\
>  	__print_symbolic(reason,					\
>  		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
> @@ -2723,41 +2733,49 @@ TRACE_EVENT(ext4_fc_commit_stop,
>  
>  #define FC_REASON_NAME_STAT(reason)					\
>  	show_fc_reason(reason),						\
> -	__entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
> +	__entry->fc_ineligible_rc[reason]
>  
>  TRACE_EVENT(ext4_fc_stats,
> -	    TP_PROTO(struct super_block *sb),
> -
> -	    TP_ARGS(sb),
> +	TP_PROTO(struct super_block *sb),
>  
> -	    TP_STRUCT__entry(
> -		    __field(dev_t, dev)
> -		    __field(struct ext4_sb_info *, sbi)
> -		    __field(int, count)
> -		    ),
> +	TP_ARGS(sb),
>  
> -	    TP_fast_assign(
> -		    __entry->dev = sb->s_dev;
> -		    __entry->sbi = EXT4_SB(sb);
> -		    ),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)
> +		__field(unsigned long, fc_commits)
> +		__field(unsigned long, fc_ineligible_commits)
> +		__field(unsigned long, fc_numblks)
> +	),
>  
> -	    TP_printk("dev %d:%d fc ineligible reasons:\n"
> -		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
> -		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
> -		      MAJOR(__entry->dev), MINOR(__entry->dev),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> -		      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
> -		      __entry->sbi->s_fc_stats.fc_num_commits,
> -		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
> -		      __entry->sbi->s_fc_stats.fc_numblks)
> +	TP_fast_assign(
> +		int i;
>  
> +		__entry->dev = sb->s_dev;
> +		for (i = 0; i < EXT4_FC_REASON_MAX; i++)
> +			__entry->fc_ineligible_rc[i] =
> +			EXT4_SB(sb)->s_fc_stats.fc_ineligible_reason_count[i];
> +		__entry->fc_commits = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
> +		__entry->fc_ineligible_commits =
> +			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
> +		__entry->fc_numblks = EXT4_SB(sb)->s_fc_stats.fc_numblks;
> +	),
> +
> +	TP_printk("dev %d,%d fc ineligible reasons:\n"
> +		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u "
> +		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
> +		  __entry->fc_commits, __entry->fc_ineligible_commits,
> +		  __entry->fc_numblks)
>  );
>  
>  #define DEFINE_TRACE_DENTRY_EVENT(__type)				\
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
