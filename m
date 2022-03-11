Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9D4D5829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 03:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbiCKCfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 21:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbiCKCfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:35:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523A9D077;
        Thu, 10 Mar 2022 18:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 985DAB827DB;
        Fri, 11 Mar 2022 02:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55457C340EB;
        Fri, 11 Mar 2022 02:33:58 +0000 (UTC)
Date:   Thu, 10 Mar 2022 21:33:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220310213356.3948cfb7@gandalf.local.home>
In-Reply-To: <20220311021931.d4oozgtefbalrcch@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
        <20220310110553.431cc997@gandalf.local.home>
        <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
        <20220310193936.38ae7754@gandalf.local.home>
        <20220311021931.d4oozgtefbalrcch@riteshh-domain>
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

On Fri, 11 Mar 2022 07:49:31 +0530
Ritesh Harjani <riteshh@linux.ibm.com> wrote:

> > # cat /sys/kernel/tracing/events/ext4/ext4_fc_commit_stop/format  
> 
> I think you meant ext4_fc_stats.

Sure.

> 
> >
> > and show me what it outputs.  
> 
> root@qemu:/home/qemu# cat /sys/kernel/tracing/events/ext4/ext4_fc_stats/format
> name: ext4_fc_stats
> ID: 986
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:dev_t dev;        offset:8;       size:4; signed:0;
>         field:unsigned int fc_ineligible_rc[EXT4_FC_REASON_MAX];        offset:12;      size:36;        signed:0;

Bah, the above tells us how many items, and the TRACE_DEFINE_ENUM() doesn't
modify this part of the file.

I could update it to do so though.

-- Steve


>         field:unsigned long fc_commits; offset:48;      size:8; signed:0;
>         field:unsigned long fc_ineligible_commits;      offset:56;      size:8; signed:0;
>         field:unsigned long fc_numblks; offset:64;      size:8; signed:0;

