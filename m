Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A214D56D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 01:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiCKAkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 19:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiCKAkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:40:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639869496;
        Thu, 10 Mar 2022 16:39:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908AE61DE1;
        Fri, 11 Mar 2022 00:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D990C340E8;
        Fri, 11 Mar 2022 00:39:38 +0000 (UTC)
Date:   Thu, 10 Mar 2022 19:39:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220310193936.38ae7754@gandalf.local.home>
In-Reply-To: <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
        <20220310110553.431cc997@gandalf.local.home>
        <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
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

On Thu, 10 Mar 2022 22:37:31 +0530
Ritesh Harjani <riteshh@linux.ibm.com> wrote:

> On 22/03/10 11:05AM, Steven Rostedt wrote:
> > On Thu, 10 Mar 2022 21:28:54 +0530
> > Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >  
> > > Note:- I still couldn't figure out how to expose EXT4_FC_REASON_MAX in patch-2
> > > which (I think) might be (only) needed by trace-cmd or perf record for trace_ext4_fc_stats.
> > > But it seems "cat /sys/kernel/debug/tracing/trace_pipe" gives the right output
> > > for ext4_fc_stats trace event (as shown below).
> > >
> > > So with above reasoning, do you think we should take these patches in?
> > > And we can later see how to provide EXT4_FC_REASON_MAX definition available to
> > > libtraceevent?  
> >
> > I don't see EXT4_FC_REASON_MAX being used in the TP_printk(). If it isn't
> > used there, it doesn't need to be exposed. Or did I miss something?  
> 
> I was mentioning about EXT4_FC_REASON_MAX used in TP_STRUCT__entry.
> When I hard code EXT4_FC_REASON_MAX to 9 in TP_STRUCT__entry, I could
> see proper values using trace-cmd. Otherwise I see all 0 (when using trace-cmd
> or perf record).
> 
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__array(unsigned int, fc_ineligible_rc, EXT4_FC_REASON_MAX)

Ah, I bet it's showing up in the format portion and not the print fmt part
of the format file.

Just to confirm, can you do the following:

# cat /sys/kernel/tracing/events/ext4/ext4_fc_commit_stop/format

and show me what it outputs.

Thanks,

-- Steve


> 
> Should we anyway hard code this to 9. Since we are anyway printing all the
> 9 elements of array values individually.
> 
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
> 
> 
> Thanks
> -ritesh

