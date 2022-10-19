Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F646044CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiJSMOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiJSMOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE21B94F2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666180196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tliq0jGQlQ6WUkypc+pPeMdK0ENXv8yHCBdRCPsUe7o=;
        b=UmoV46MRR4qIHODgQ3goutOcWUuDgBYUOuDuUhWofUNNHPL9Y2o51itJZHJuwiP7P2d/ao
        6f/eOL7A0jqA/EN5qCVBiSflUl2GRWwcufFU3c7HnZkDnZjmfCeKS/AIlvSGNAre6NYG4j
        dL5FQURft//Nvgffk9fjU8SQD0IjVB0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-xLj4OpRFOdW6mtHOjzLH5w-1; Wed, 19 Oct 2022 07:49:55 -0400
X-MC-Unique: xLj4OpRFOdW6mtHOjzLH5w-1
Received: by mail-qt1-f197.google.com with SMTP id ga23-20020a05622a591700b0039ceee61202so5224520qtb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 04:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tliq0jGQlQ6WUkypc+pPeMdK0ENXv8yHCBdRCPsUe7o=;
        b=XIiRCV4aoZhN2LnrP4KE2A5kV2ZfBoU7tLpAt9Adt4sqdMWaFcz3g3ARcIVpvav5vg
         HGzEHITgnUpf7YvtwBkjVW13aTytswT34lOMhtFW0x4HLbwg/AiR/QxomqqVPwJQwrPB
         sIPfPNGqKrQmoqdIVbCdx1LoIOcq3W6VG0qkGbUvTfBpW88j5nlxfRqBcU0lDgUi8YYD
         VakGwN3har94vZkxhsrCWJea+2BSPYOOr0zafrlZEHnve1oJAsihocEPt2Se6nwuC1Ex
         Vb3k2XZKLcsIdUXOiMJBg2MCRMVF1RW2YwaN3f1Z6ypBb8crqWgvtZW9mgbU4H2Dc+/6
         Tr/A==
X-Gm-Message-State: ACrzQf1fN+iimOrFbhV9ManXvcr71VNU1qrnkQPJ9NHvR8PxfaRtqdpj
        huUVRHR5pmOFY6ELaUeX7eF9Q4A2TR0PokY2BV+JPr/RhCed76U5Z7TvwzzU6p5Lm1+5sDtTkrE
        id8LxWbiHGOCpR7qQMSAILbQmDA==
X-Received: by 2002:a05:6214:5185:b0:472:f9b0:cbc6 with SMTP id kl5-20020a056214518500b00472f9b0cbc6mr5924607qvb.92.1666180194192;
        Wed, 19 Oct 2022 04:49:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67Vxg6Aq6b0c0Q7sb8e01/USP6g3yAGI8BuFe9P250JYUbRQC8W9CSSfaZ2F+ZdOZfoDyIzg==
X-Received: by 2002:a05:6214:5185:b0:472:f9b0:cbc6 with SMTP id kl5-20020a056214518500b00472f9b0cbc6mr5924586qvb.92.1666180193943;
        Wed, 19 Oct 2022 04:49:53 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a10-20020ac85b8a000000b00397b1c60780sm3980873qta.61.2022.10.19.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:49:53 -0700 (PDT)
Date:   Wed, 19 Oct 2022 07:49:57 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y0/kZbIvMgkNhWpM@bfoster>
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
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

I somewhat recently tracked down a hugepage/swap problem that could
manifest as a softlockup in the folio lookup path (due to indefinite
folio_try_get_rcu() failure):

https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/

It could easily be something different leading to the same side effect,
particularly since I believe the issue I saw was introduced in v5.19,
but might be worth a test if you have a reliable reproducer.

Brian

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
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

