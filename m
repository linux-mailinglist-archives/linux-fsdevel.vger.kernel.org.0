Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E24D6698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbiCKQnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCKQns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:43:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFF1FA4E;
        Fri, 11 Mar 2022 08:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18F33CE295C;
        Fri, 11 Mar 2022 16:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B39DC340EE;
        Fri, 11 Mar 2022 16:42:39 +0000 (UTC)
Date:   Fri, 11 Mar 2022 11:42:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311114237.51a2ed29@gandalf.local.home>
In-Reply-To: <20220311150357.x6wpvzthsimb26m6@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
        <20220310110553.431cc997@gandalf.local.home>
        <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
        <20220310193936.38ae7754@gandalf.local.home>
        <20220311021931.d4oozgtefbalrcch@riteshh-domain>
        <20220310213356.3948cfb7@gandalf.local.home>
        <20220311031431.3sfbibwuthn4xkym@riteshh-domain>
        <20220310233234.4418186a@gandalf.local.home>
        <20220311051249.ltgqbjjothbrkbno@riteshh-domain>
        <20220311094524.1fa2d98f@gandalf.local.home>
        <20220311150357.x6wpvzthsimb26m6@riteshh-domain>
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

On Fri, 11 Mar 2022 20:33:57 +0530
Ritesh Harjani <riteshh@linux.ibm.com> wrote:

> On 22/03/11 09:45AM, Steven Rostedt wrote:
> > On Fri, 11 Mar 2022 10:42:49 +0530
> > Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >  
> > > You may add below, if you like:-
> > >
> > > Reported-and-tested-by: Ritesh Harjani <riteshh@linux.ibm.com>  
> >
> > Will do. Thanks for testing.
> >
> > I'll be adding this for the next merge window. I don't think this is
> > something that needs to be added to this rc release nor stable. Do you
> > agree?  
> 
> If using an enum in TP_STRUCT__entry's __array field doesn't cause any side
> effect other than it just can't be decoded by userspace perf record / trace-cmd,
> then I guess it should be ok.

Right. It only causes trace-cmd and perf to not be able to parse the field.
But that's not really a regression, as it never was able to parse an enum
defining an array size.

> 
> But for this PATCH 2/10 "ext4: Fix ext4_fc_stats trace point", will be
> needed to be Cc'd to stable tree as discussed before, as it tries to
> dereference some sbi pointer from the tracing ring buffer. Then hopefully the
> only problem with previous kernel version would be that ext4_fc_stats(), won't
> show proper values for array entries in older kernel version where this patch
> of trace_events is not found.
> But cat /sys/kernel/debug/tracing/trace_pipe should be able to show the right values.
> 
> 
> >From my side, I will send a v3 of this patch series with just EXT4_FC_REASON_MAX  
> defined using TRACE_DEFINE_ENUM.

OK, I'll just add this for the next merge window. If people complain about
the parser not being able to parse this from user space, then we can either
backport it, or add a plugin that parses it manually in libtraceevent.

> 
> Thanks again for your help :)
> 

No problem. Thanks for the report.

-- Steve
