Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61354DCCAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiCQRpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiCQRpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1985ABF73;
        Thu, 17 Mar 2022 10:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A283615B5;
        Thu, 17 Mar 2022 17:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B384C340E9;
        Thu, 17 Mar 2022 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647539031;
        bh=z8Hyj2T1/hH5P475SCzLF1KeVKuoHUYntggCqpCnmNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGYoPFptuQC82BGVF0qrXJJArBJZM+T5qtJbO9MT9WQcYlu8hdMVT2hNSdlOdeIxU
         Xm3zUC4JXELpxExrVThcKXPe0NpnIrsYialPWuwhsKJhjL/1Ux6jViN3xTIylDT0d8
         Q1cmIDX+iYsqP6EBetXF3M8TRSiH0xnrRVbiMVpz2wZfa2RWgxaD9w/+BsHk0o5nrs
         dGJgPzxicp5XHm2/gbtyF9gIdWEA05DmqDN5wZcchTgh1j/mEnG1/WS3vUozmyUIb5
         4m65paVeHGs7zm3kD4WeR3iVWZfCEVh1Njg5Lpa8tvlNlfIQ7NwtrGqrLcrlYKfF5J
         R7Um6nNSSjChA==
Date:   Thu, 17 Mar 2022 10:43:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hca@linux.ibm.com
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <YjNzUImisNklfvae@thelio-3990X>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
 <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
 <yt9dr1706b4i.fsf@linux.ibm.com>
 <20220317145008.73nm7hqtccyjy353@riteshh-domain>
 <yt9d1qz05zk1.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d1qz05zk1.fsf@linux.ibm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 05:11:42PM +0100, Sven Schnelle wrote:
> Hi,
> 
> Ritesh Harjani <riteshh@linux.ibm.com> writes:
> 
> > On 22/03/17 01:01PM, Sven Schnelle wrote:
> >> Ritesh Harjani <riteshh@linux.ibm.com> writes:
> >>
> >> [    0.958403] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> >> [    0.958407] Workqueue: eval_map_wq eval_map_work_func
> >>
> >> [    0.958446] Krnl PSW : 0704e00180000000 000000000090a9d6 (number+0x25e/0x3c0)
> >> [    0.958456]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> >> [    0.958461] Krnl GPRS: 0000000000000058 00000000010de0ac 0000000000000001 00000000fffffffc
> >> [    0.958467]            0000038000047b80 0affffff010de0ab 0000000000000000 0000000000000000
> >> [    0.958481]            0000000000000020 0000038000000000 00000000010de0ad 00000000010de0ab
> >> [    0.958484]            0000000080312100 0000000000e68910 0000038000047b50 0000038000047ab8
> >> [    0.958494] Krnl Code: 000000000090a9c6: f0c84112b001        srp     274(13,%r4),1(%r11),8
> >> [    0.958494]            000000000090a9cc: 41202001            la      %r2,1(%r2)
> >> [    0.958494]           #000000000090a9d0: ecab0006c065        clgrj   %r10,%r11,12,000000000090a9dc
> >> [    0.958494]           >000000000090a9d6: d200b0004000        mvc     0(1,%r11),0(%r4)
> >> [    0.958494]            000000000090a9dc: 41b0b001            la      %r11,1(%r11)
> >> [    0.958494]            000000000090a9e0: a74bffff
> >>             aghi    %r4,-1
> >> [    0.958494]            000000000090a9e4: a727fff6            brctg   %r2,000000000090a9d0
> >> [    0.958494]            000000000090a9e8: a73affff            ahi     %r3,-1
> >> [    0.958575] Call Trace:
> >> [    0.958580]  [<000000000090a9d6>] number+0x25e/0x3c0
> >> [    0.958594] ([<0000000000289516>] update_event_printk+0xde/0x200)
> >> [    0.958602]  [<0000000000910020>] vsnprintf+0x4b0/0x7c8
> >> [    0.958606]  [<00000000009103e8>] snprintf+0x40/0x50
> >> [    0.958610]  [<00000000002893d2>] eval_replace+0x62/0xc8
> >> [    0.958614]  [<000000000028e2fe>] trace_event_eval_update+0x206/0x248
> >
> > This looks like you must have this patch from Steven as well [2].
> > Although I did test the patch and didn't see such a crash on my qemu box [3].

Indeed, commit b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect
trace event types as well") from the ftrace tree is required to
reproduce this. The ftrace and ext4 changes alone are fine (my initial
bisect landed on a merge and I did two more bisects to confirm that).

> > [2]: https://lore.kernel.org/linux-ext4/20220310233234.4418186a@gandalf.local.home/
> > [3]: https://lore.kernel.org/linux-ext4/20220311051249.ltgqbjjothbrkbno@riteshh-domain/
> >
> > @Steven,
> > Sorry to bother. But does this crash strike anything obvious to you?
> 
> Looking at the oops output again made me realizes that the snprintf
> tries to write into pages that are mapped RO. Talking to Heiko he
> mentioned that s390 maps rodata/text RO when setting up the initial
> mapping while x86 has a RW mapping in the beginning and changes that
> later to RO. I haven't verified that, but that might be a reason why it
> works on x86.

For what it's worth, this is reproducible on all of my x86 boxes during
the initial boot on next-20220316 and newer. I am happy to test any
patches or provide further information as necessary.

Cheers,
Nathan
