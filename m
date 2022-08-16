Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A3F595804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiHPKVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHPKU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:20:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562052097;
        Tue, 16 Aug 2022 02:36:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A308346EC;
        Tue, 16 Aug 2022 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660642463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEdYfa1M4GgGzZG+RuOCPAb/W8L0e/bqVBO0WbncbEE=;
        b=pBpO8XTXlRzfr9XHY2EY5XFEQIVO6s1UiN7LVjuYTNaMxZ1PC+GyuKrmKnORBcGFydH69W
        CnwM9Nb68o57IONPf+0uX7J958FobhMNbGv/VNAWtKCxykUsWfcMZPwYgZZKLSDI6+2qzn
        RfQVriyqAxiodJYgcae2V5FcNO57/cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660642463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEdYfa1M4GgGzZG+RuOCPAb/W8L0e/bqVBO0WbncbEE=;
        b=34FB+9QK0NXSIgtZkv3faxX4+8s2JgaMoRYkRu/il6P0qmVqGJ2OQE0yPWlt+IeVyDZPd1
        p2RTyT8AIQphYQDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 221792C143;
        Tue, 16 Aug 2022 09:34:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CC041A066C; Tue, 16 Aug 2022 11:34:21 +0200 (CEST)
Date:   Tue, 16 Aug 2022 11:34:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <20220816093421.ok26tcyvf6bm3ngy@quack3>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
 <64b7899f-d84d-93de-f9c5-49538bd080d0@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b7899f-d84d-93de-f9c5-49538bd080d0@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stefan!

On Sat 06-08-22 11:50:28, Stefan Wahren wrote:
> Am 28.07.22 um 12:00 schrieb Jan Kara:
> > Hello!
> > 
> > On Mon 18-07-22 15:29:47, Stefan Wahren wrote:
> > > i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
> > > unable to run "rpi-update" without massive performance regression on my
> > > Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux 5.17 this
> > > tool successfully downloads the latest firmware (> 100 MB) on my development
> > > micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem within ~ 1
> > > min. The same scenario on Linux 5.18 shows the following symptoms:
> > Thanks for report and the bisection!
> > > - download takes endlessly much time and leads to an abort by userspace in
> > > most cases because of the poor performance
> > > - massive system load during download even after download has been aborted
> > > (heartbeat LED goes wild)
> > OK, is it that the CPU is busy or are we waiting on the storage card?
> > Observing top(1) for a while should be enough to get the idea.  (sorry, I'm
> > not very familiar with RPi so I'm not sure what heartbeat LED shows).
> 
> My description wasn't precise. I mean the green ACT LED, which uses the LED
> heartbeat trigger:
> 
> "This allows LEDs to be controlled by a CPU load average. The flash
> frequency is a hyperbolic function of the 1-minute load average."
> 
> I'm not sure if it's CPU or IO driven load, here the top output in bad case:
> 
> top - 08:44:17 up 43 min,  2 users,  load average: 5,02, 5,45, 5,17
> Tasks: 142 total,   1 running, 141 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  0,4 us,  0,4 sy,  0,0 ni, 49,0 id, 50,2 wa,  0,0 hi, 0,0 si,  0,0
> st
> MiB Mem :   7941,7 total,   4563,1 free,    312,7 used,   3066,0 buff/cache
> MiB Swap:    100,0 total,    100,0 free,      0,0 used.   7359,6 avail Mem

OK, there's plenty of memory available, CPUs are mostly idle, the load is
likely created by tasks waiting for IO (which also contribute to load
despite not consuming CPU). Not much surprising here.

> > Can you run "iostat -x 1" while the download is running so that we can see
> > roughly how the IO pattern looks?
> > 
> Here the output during download:
> 
> Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  %rrqm 
> %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> mmcblk1          0,00    2,00      0,00     36,00     0,00 0,00   0,00  
> 0,00    0,00 23189,50  46,38     0,00    18,00 500,00 100,00
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0,25    0,00    0,00   49,62    0,00   50,13
> 
> Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  %rrqm 
> %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> mmcblk1          0,00    2,00      0,00     76,00     0,00 0,00   0,00  
> 0,00    0,00 46208,50  92,42     0,00    38,00 500,00 100,00
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0,25    0,00    0,00   49,62    0,00   50,13
> 
> Device            r/s     w/s     rkB/s     wkB/s   rrqm/s wrqm/s  %rrqm 
> %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> mmcblk1          0,00    3,00      0,00     76,00     0,00 0,00   0,00  
> 0,00    0,00 48521,67 145,56     0,00    25,33 333,33 100,00
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0,25    0,00    0,00   49,62    0,00   50,13

So this is interesting. We can see the card is 100% busy. The IO submitted
to the card is formed by small requests - 18-38 KB per request - and each
request takes 0.3-0.5s to complete. So the resulting throughput is horrible
- only tens of KB/s. Also we can see there are many IOs queued for the
device in parallel (aqu-sz columnt). This does not look like load I would
expect to be generated by download of a large file from the web.

You have mentioned in previous emails that with dd(1) you can do couple
MB/s writing to this card which is far more than these tens of KB/s. So the
file download must be doing something which really destroys the IO pattern
(and with mb_optimize_scan=0 ext4 happened to be better dealing with it and
generating better IO pattern). Can you perhaps strace the process doing the
download (or perhaps strace -f the whole rpi-update process) so that we can
see how does the load generated on the filesystem look like? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
