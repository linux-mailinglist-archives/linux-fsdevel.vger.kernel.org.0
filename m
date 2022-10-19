Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2739460376D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 03:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJSBQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 21:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJSBQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:16:52 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF0DFB56
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 18:16:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 63so16429022vse.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M++Ivb11u0st7Bn1wCddmgCz9h2EQ4tgIX5+e878ohI=;
        b=g+3WED34ktkLOM+MRmUh+g/MSWglySA1V1WXHzi9R3lfT7hotb0sPuVbS52iIjHR1M
         Fqy+KFnSaa9jHZtU0Cky+2lYVk5jsBKotShID/5PjYjE1/uEAYmDEbApVx3Jx2X0snnt
         paJCmHYy7sGmGz6c3eJOTbTeBXn/5HeJxsu0Mt42DaGsqVg13H4k57CsMWcn3Dd1rHk0
         m92/HIoQDK13Pd8+l9UHC1WXEdfG6Y0nXtUbTB29ApJOkJHR8eb3PbJ/BEykpo3DscJ+
         1YLeUeGy3PZrYspKj5EQ2SwnuM3KXoxrTN1aweYoPuCtnKp/Jj7TWoBHyPcWe41FdxQt
         s2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M++Ivb11u0st7Bn1wCddmgCz9h2EQ4tgIX5+e878ohI=;
        b=ZgrBs2TK5sOv0v4Es2AIZ7lP0jQsfDYmAfGtxTxpLfxCtVyHsPiHj5RKUFFWr10QpO
         tFEaYioVQkxvAPTWftrhsKTAHsLNw+X+2QRB9tXXnzI2oNjQ6w3/S0wDJpdUNki8V6ld
         vT05794oq06rJJa5aFhhJr+PLMiogrNY5cWPg/sYy6Cald4oFM4mkKCOozOA3cTbmi6W
         gla9lLwRVN5p29YfjFoMj15bItNS2yeyu/vN2cWbD0EAc2UVnlMJ8ZqntRxQZvxOBWzO
         wx942Tw5lvWm7cqBbJfRQdAw2awlB+1abwze576+YfrzzVLWxUDlnPskJtIjAkKItuZE
         asJg==
X-Gm-Message-State: ACrzQf2youVEBfISrZH/d75xRKiM3cNTzbcq14XdXc4v+VYPW7SDBX8F
        isno13Dov3fEFmGvTma9cCGtR53vlfAym8Y/
X-Google-Smtp-Source: AMsMyM7ErKcQDb1XVV6IwNSsaGy14Aw7/3cvVP0dy4+YVMedCXsYPtQByHXhidP7yjkS7OnlcX2oTg==
X-Received: by 2002:a17:902:ef51:b0:180:7922:ce40 with SMTP id e17-20020a170902ef5100b001807922ce40mr5676548plx.8.1666142199708;
        Tue, 18 Oct 2022 18:16:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id p2-20020a634202000000b0043ae1797e2bsm8590841pga.63.2022.10.18.18.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:16:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1okxhE-003fe5-13; Wed, 19 Oct 2022 12:16:36 +1100
Date:   Wed, 19 Oct 2022 12:16:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <20221019011636.GM2703033@dread.disaster.area>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018223042.GJ2703033@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> On Tue, Oct 18, 2022 at 04:09:17AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 18, 2022 at 10:52:19AM +0800, Zhaoyang Huang wrote:
> > > On Mon, Oct 17, 2022 at 11:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Oct 17, 2022 at 01:34:13PM +0800, Zhaoyang Huang wrote:
> > > > > On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > >
> > > > > > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > > > > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > > > > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > > > > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > > > > > suggest skip this page to break the live lock as a workaround.
> > > > > >
> > > > > > No, the underlying bug should be fixed.
> > > >
> > > >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Understand. IMHO, find_get_entry actruely works as an open API dealing
> > > with different kinds of address_spaces page cache, which requires high
> > > robustness to deal with any corner cases. Take the current problem as
> > > example, the inode with fault page(refcount=0) could remain on the
> > > sb's list without live lock problem.
> > 
> > But it's a corner case that shouldn't happen!  What else is going on
> > at the time?  Can you reproduce this problem easily?  If so, how?
> 
> I've been seeing this livelock, too. The reproducer is,
> unfortunately, something I can't share - it's a massive program that
> triggers a data corruption I'm working on solving.
> 
> Now that I've
> mostly fixed the data corruption, long duration test runs end up
> livelocking in page cache lookup after several hours.
> 
> The test is effectively writing a 100MB file with multiple threads
> doing reverse adjacent racing 1MB unaligned writes. Once the file is
> written, it is then mmap()d and read back from the filesystem for
> verification.
> 
> THis is then run with tens of processes concurrently, and then under
> a massively confined memcg (e.g. 32 processes/files are run in a
> memcg with only 200MB of memory allowed). This causes writeback,
> readahead and memory reclaim to race with incoming mmap read faults
> and writes.  The livelock occurs on file verification and it appears
> to be an interaction with readahead thrashing.
> 
> On my test rig, the physical read to write ratio is at least 20:1 -
> with 32 processes running, the 5s IO rates are:
> 
> Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s    MB_read    MB_wrtn    MB_dscd
> dm-0          52187.20      3677.42      1345.92         0.00      18387       6729          0
> dm-0          62865.60      5947.29         0.08         0.00      29736          0          0
> dm-0          62972.80      5911.20         0.00         0.00      29556          0          0
> dm-0          59803.00      5516.72       133.47         0.00      27583        667          0
> dm-0          63068.20      5292.34       511.52         0.00      26461       2557          0
> dm-0          56775.60      4184.52      1248.38         0.00      20922       6241          0
> dm-0          63087.40      5901.26        43.77         0.00      29506        218          0
> dm-0          62769.00      5833.97        60.54         0.00      29169        302          0
> dm-0          64810.20      5636.13       305.63         0.00      28180       1528          0
> dm-0          65222.60      5598.99       349.48         0.00      27994       1747          0
> dm-0          62444.00      4887.05       926.67         0.00      24435       4633          0
> dm-0          63812.00      5622.68       294.66         0.00      28113       1473          0
> dm-0          63482.00      5728.43       195.74         0.00      28642        978          0
> 
> This is reading and writing the same amount of file data at the
> application level, but once the data has been written and kicked out
> of the page cache it seems to require an awful lot more read IO to
> get it back to the application. i.e. this looks like mmap() is
> readahead thrashing severely, and eventually it livelocks with this
> sort of report:
> 
> [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> [175901.995614] Call Trace:
> [175901.996090]  <TASK>
> [175901.996594]  ? __schedule+0x301/0xa30
> [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [175902.000714]  ? xas_start+0x53/0xc0
> [175902.001484]  ? xas_load+0x24/0xa0
> [175902.002208]  ? xas_load+0x5/0xa0
> [175902.002878]  ? __filemap_get_folio+0x87/0x340
> [175902.003823]  ? filemap_fault+0x139/0x8d0
> [175902.004693]  ? __do_fault+0x31/0x1d0
> [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> [175902.006998]  ? exc_page_fault+0x1d9/0x810
> [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> [175902.008613]  </TASK>
> 
> Given that filemap_fault on XFS is probably trying to map large
> folios, I do wonder if this is a result of some kind of race with
> teardown of a large folio...
> 
> There is a very simple corruption reproducer script that has been
> written, but I haven't been using it. I don't know if long term
> running of the script here:
> 
> https://lore.kernel.org/linux-xfs/d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com/
> 
> will trigger the livelock as the verification step is
> significantly different, but it will give you insight into the
> setup of the environment that leads to the livelock. Maybe you could
> replace the md5sum verification with a mmap read with xfs_io to
> simulate the fault load that seems to lead to this issue...

FWIW, just tested this on a current Linus kernel. While there is
massive read-ahead thrashing on v6.0, the thrashing is largely gone
in v6.1-rc1+ and the iteration rate of the test is much, much
better. The livelock remains, however.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
