Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE474C0362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 21:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiBVUxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 15:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiBVUxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:53:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115EA2F15;
        Tue, 22 Feb 2022 12:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF67DCE1894;
        Tue, 22 Feb 2022 20:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72825C340E8;
        Tue, 22 Feb 2022 20:52:40 +0000 (UTC)
Date:   Tue, 22 Feb 2022 15:52:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/9] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220222155238.669e598e@gandalf.local.home>
In-Reply-To: <9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
        <9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Feb 2022 02:04:10 +0530
Ritesh Harjani <riteshh@linux.ibm.com> wrote:

> ftrace's __print_symbolic() requires that any enum values used in the
> symbol to string translation table be wrapped in a TRACE_DEFINE_ENUM
> so that the enum value can be encoded in the ftrace ring buffer.

Actually, you mean "decoded from the ftrace ring buffer by user space
tooling".

> 
> This patch also fixes few other problems found in this trace point.
> e.g. dereferencing structures in TP_printk which should not be done
> at any cost.
> 
> Also to avoid checkpatch warnings, this patch removes those
> whitespaces/tab stops issues.
> 
> Fixes: commit aa75f4d3daae ("ext4: main fast-commit commit path")

Should add:

Cc: stable@kernel.org

as the commit landed in 5.10.

> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good with one small nit below.

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

As the above line is a continuation of the previous line, it should be
indented as such. And since you added a line break, it is recommend to have
any blocks use brackets. That is:

		for (i = 0; i < EXT4_FC_REASON_MAX; i++) {
			__entry->fc_ineligible_rc[i] =
				EXT4_SB(sb)->s_fc_stats.fc_ineligible_reason_count[i];
		}

Other than that:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


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

