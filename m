Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305B6096B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJWWAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWWAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:00:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459D4F1B1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 15:00:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 192so377250pfx.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hvIFbRsnY/vDy+taGpGboiBar50BevLz1lBfrbHmmSw=;
        b=2K6CdRtZ5HzBar49k2LtiaW4FLoVKcjs3PX7dq9FckhdarNhspBzGdosOgBSuz/dFl
         hqkurPNmdOALjzGHlf/R/AjdU4bgOD3OuS/7fwlCriJzk7e3+d0Mwrgg1jiDZBERrjA3
         tPjsSEMV/bQFMwFk0aZRvlr80IT4EEcbjO/xZNKwZNZCfx+8s2raBuVEoZgGRF8qUzCo
         e3VdHSUx68cvi2Dtq5rhCK0elIHYZ57ABlCP9JY3q0fC1wbee10T+p5t803KP0EOcmds
         PKzKeyTQKjS424ssn94Dwhwx++97dTHY7MW4pTsHLa0hq6ZxUAMk5obAniRJJSKbNQM1
         wpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvIFbRsnY/vDy+taGpGboiBar50BevLz1lBfrbHmmSw=;
        b=KRtr2Ews0C40/NNtBCwKUwhU++WLgdbzvjlI6P53vPNRdz9Q3ZkEBHpJxPIdGLHtfG
         5BUOOF4ug8rwhdg89MO6gzQYrecgzyesnRB6FXKkxBphN9WcKb0NoU9rMLZcF7JVBu2B
         q7g9odeyNGuoYUGUGa3IpLZMReAvXu5oVPsiUp76ePiOdMzhm1AGwAA85czfwDt91YFW
         I5Fox3FaXvSh3V0MwmYm5Ajffq7ibentcJ/MgkVVxwRAqf+iVV0jXOrRQLRgYfT9J/GH
         fTtckS/F7NsnroKr6FsLBfVpxB9cqHdqiGp5lPOkOj80O6uLlRUo8+vGMsbAutbo3mQc
         OUNA==
X-Gm-Message-State: ACrzQf3+WCqD7CRbcso+02fInGeAUlWwhvQqxfw8yXdpu2p7mOiHxJdT
        KdCjslmhQhB0Y30p27jQzTxo9g==
X-Google-Smtp-Source: AMsMyM5VwZrmUlSzb+1EZVG+tpjTbe3LySen3wNOfYDBTBo98hzEeyHHH/8b9UZAgnJ5FzV86+CCWw==
X-Received: by 2002:aa7:8011:0:b0:567:70cc:5b78 with SMTP id j17-20020aa78011000000b0056770cc5b78mr26373798pfi.29.1666562422001;
        Sun, 23 Oct 2022 15:00:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78e83000000b0056beae3dee2sm14606pfr.145.2022.10.23.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 15:00:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1omj10-005abc-AD; Mon, 24 Oct 2022 09:00:18 +1100
Date:   Mon, 24 Oct 2022 09:00:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        =?utf-8?B?R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmloc=?= 
        <y-goto@fujitsu.com>, Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?utf-8?B?UnVhbiwgU2hpeWFuZy/pmK4g5LiW6Ziz?= 
        <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        zwisler@kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        dm-devel@redhat.com, toshi.kani@hpe.com
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <20221023220018.GX3600936@dread.disaster.area>
References: <YyIBMJzmbZsUBHpy@magnolia>
 <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1NRNtToQTjs0Dbd@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 07:11:02PM -0700, Darrick J. Wong wrote:
> On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> > In addition, I don't like your idea about the test change because it will
> > make generic/470 become the special test for XFS. Do you know if we can fix
> > the issue by changing the test in another way? blkdiscard -z can fix the
> > issue because it does zero-fill rather than discard on the block device.
> > However, blkdiscard -z will take a lot of time when the block device is
> > large.
> 
> Well we /could/ just do that too, but that will suck if you have 2TB of
> pmem. ;)
> 
> Maybe as an alternative path we could just create a very small
> filesystem on the pmem and then blkdiscard -z it?
> 
> That said -- does persistent memory actually have a future?  Intel
> scuttled the entire Optane product, cxl.mem sounds like expansion
> chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
> asserts everywhere) and 6.1 (every time I run fstests now I see massive
> data corruption).

Yup, I see the same thing. fsdax was a train wreck in 6.0 - broken
on both ext4 and XFS. Now that I run a quick check on 6.1-rc1, I
don't think that has changed at all - I still see lots of kernel
warnings, data corruption and "XFS_IOC_CLONE_RANGE: Invalid
argument" errors.

If I turn off reflink, then instead of data corruption I get kernel
warnings like this from fsx and fsstress workloads:

[415478.558426] ------------[ cut here ]------------
[415478.560548] WARNING: CPU: 12 PID: 1515260 at fs/dax.c:380 dax_insert_entry+0x2a5/0x320
[415478.564028] Modules linked in:
[415478.565488] CPU: 12 PID: 1515260 Comm: fsx Tainted: G        W 6.1.0-rc1-dgc+ #1615
[415478.569221] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[415478.572876] RIP: 0010:dax_insert_entry+0x2a5/0x320
[415478.574980] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 da ee a7 00 eb a4 48 81 e6
[415478.582740] RSP: 0000:ffffc90002867b70 EFLAGS: 00010002
[415478.584730] RAX: ffffea000f0d0800 RBX: 0000000000000001 RCX: 0000000000000001
[415478.587487] RDX: ffffea0000000000 RSI: 000000000000003a RDI: ffffea000f0d0840
[415478.590122] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
[415478.592380] R10: ffff888800dc9c18 R11: 0000000000000001 R12: ffffc90002867c58
[415478.594865] R13: ffff888800dc9c18 R14: ffffc90002867e18 R15: 0000000000000000
[415478.596983] FS:  00007fd719fa2b80(0000) GS:ffff88883ec00000(0000) knlGS:0000000000000000
[415478.599364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[415478.600905] CR2: 00007fd71a1ad640 CR3: 00000005cf241006 CR4: 0000000000060ee0
[415478.602883] Call Trace:
[415478.603598]  <TASK>
[415478.604229]  dax_fault_iter+0x240/0x600
[415478.605410]  dax_iomap_pte_fault+0x19c/0x3d0
[415478.606706]  __xfs_filemap_fault+0x1dd/0x2b0
[415478.607744]  __do_fault+0x2e/0x1d0
[415478.608587]  __handle_mm_fault+0xcec/0x17b0
[415478.609593]  handle_mm_fault+0xd0/0x2a0
[415478.610517]  exc_page_fault+0x1d9/0x810
[415478.611398]  asm_exc_page_fault+0x22/0x30
[415478.612311] RIP: 0033:0x7fd71a04b9ba
[415478.613168] Code: 4d 29 c1 4c 29 c2 48 3b 15 db 95 11 00 0f 87 af 00 00 00 0f 10 01 0f 10 49 f0 0f 10 51 e0 0f 10 59 d0 48 83 e9 40 48 83 ea 40 <41> 0f 29 01 41 0f 29 49 f0 41 0f 29 51 e0 41 0f 29 59 d0 49 83 e9
[415478.617083] RSP: 002b:00007ffcf277be18 EFLAGS: 00010206
[415478.618213] RAX: 00007fd71a1a3fc5 RBX: 0000000000000fc5 RCX: 00007fd719f5a610
[415478.619854] RDX: 000000000000964b RSI: 00007fd719f50fd5 RDI: 00007fd71a1a3fc5
[415478.621286] RBP: 0000000000030fc5 R08: 000000000000000e R09: 00007fd71a1ad640
[415478.622730] R10: 0000000000000001 R11: 00007fd71a1ad64e R12: 0000000000009699
[415478.624164] R13: 000000000000a65e R14: 00007fd71a1a3000 R15: 0000000000000001
[415478.625600]  </TASK>
[415478.626087] ---[ end trace 0000000000000000 ]---

Even generic/247 is generating a warning like this from xfs_io,
which is a mmap vs DIO racer. Given that DIO doesn't exist for
fsdax, this test turns into just a normal write() vs mmap() racer.

Given these are the same fsdax infrastructure failures that I
reported for 6.0, it is also likely that ext4 is still throwing
them. IOWs, whatever got broke in the 6.0 cycle wasn't fixed in the
6.1 cycle.

> Frankly at this point I'm tempted just to turn of fsdax support for XFS
> for the 6.1 LTS because I don't have time to fix it.

/me shrugs

Backporting fixes (whenever they come along) is a problem for the
LTS kernel maintainer to deal with, not the upstream maintainer.

IMO, the issue right now is that the DAX maintainers seem to have
little interest in ensuring that the FSDAX infrastructure actually
works correctly. If anything, they seem to want to make things
harder for block based filesystems to use pmem devices and hence
FSDAX. e.g. the direction of the DAX core away from block interfaces
that filesystems need for their userspace tools to manage the
storage.

At what point do we simply say "the experiment failed, FSDAX is
dead" and remove it from XFS altogether?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
