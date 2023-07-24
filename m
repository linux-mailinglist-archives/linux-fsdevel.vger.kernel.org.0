Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184DC75F9F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGXOew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGXOev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A76F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690209253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sw5JYA3+zGjsKL/Hf3UxVttJt75aXV0WOzCX0uDZMJk=;
        b=FLU0saOmVza3DYUYf0SHJUyBHv6joOTRq4mJlEUlB6c1DbYvgiwzNpn14wwynN+5GGOMWF
        mTyhwJtWKewNNuE38vnZNRNVuUgii4NpDzoDUi8XDYQS/FQbVgPJeHMgQXBvvYxisgVJfA
        MVQoE26Ln5YQ166wEY8r/A2GW/096gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-2242VwcsMp6SRYZI29FIGA-1; Mon, 24 Jul 2023 10:34:07 -0400
X-MC-Unique: 2242VwcsMp6SRYZI29FIGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B5C8F77CC;
        Mon, 24 Jul 2023 14:34:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 305672166B25;
        Mon, 24 Jul 2023 14:33:46 +0000 (UTC)
Date:   Mon, 24 Jul 2023 22:33:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZL6Lx6QbLubsj3cg@MiWiFi-R3L-srv>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <ZL4xif/LX6ZhRqtf@MiWiFi-R3L-srv>
 <ZL4z6LVzrbMvXwyl@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL4z6LVzrbMvXwyl@krava>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/24/23 at 10:18am, Jiri Olsa wrote:
> On Mon, Jul 24, 2023 at 04:08:41PM +0800, Baoquan He wrote:
> > On 07/24/23 at 08:23am, David Hildenbrand wrote:
> > > Hi,
> > > 
> > > > 
> > > > I met this too when I executed below command to trigger a kcore reading.
> > > > I wanted to do a simple testing during system running and got this.
> > > > 
> > > >    makedumpfile --mem-usage /proc/kcore
> > > > 
> > > > Later I tried your above objdump testing, it corrupted system too.
> > > > 
> > > 
> > > What do you mean with "corrupted system too" --  did it not only fail to
> > > dump the system, but also actually harmed the system?
> > 
> > From my testing, reading kcore will cause system panic, then reboot. Not
> > sure if Jiri saw the same phenomenon.
> 
> it did not crash for me, just the read error
> could you get console output from that?

I got a new arm64 machine, then executing "makedumpfile --mem-usage
/proc/kcore" won't trigger panic, your objdump command can trigger
panic. The call trace is pasted at below. It's the same as the panic and
call trace I met on my last arm64 machine.

[13270.314323] Mem abort info:
[13270.317162]   ESR = 0x0000000096000007
[13270.320901]   EC = 0x25: DABT (current EL), IL = 32 bits
[13270.326217]   SET = 0, FnV = 0
[13270.329261]   EA = 0, S1PTW = 0
[13270.332390]   FSC = 0x07: level 3 translation fault
[13270.337270] Data abort info:
[13270.340139]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[13270.345626]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[13270.350666]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[13270.355981] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000400651d64000
[13270.362672] [ffffdc9cf3ea0000] pgd=1000401ffffff003, p4d=1000401ffffff003, pud=1000401fffffe003, pmd=1000401fffffd003, pte=0000000000000000
[13270.375367] Internal error: Oops: 0000000096000007 [#4] SMP
[13270.380934] Modules linked in: mlx5_ib ib_uverbs ib_core rfkill vfat fat joydev cdc_ether usbnet mii mlx5_core acpi_ipmi mlxfw ipmi_ssif psample tls ipmi_devintf pci_hyperv_intf arm_spe_pmu ipmi_msghandler arm_cmn arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq acpi_tad fuse zram xfs crct10dif_ce polyval_ce polyval_generic ghash_ce uas sbsa_gwdt nvme nvme_core ast usb_storage nvme_common i2c_algo_bit xgene_hwmon
[13270.416751] CPU: 15 PID: 8803 Comm: objdump Tainted: G      D            6.5.0-rc3 #1
[13270.424570] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.0007/Mt.Jade Motherboard, BIOS 2.10.20220531 (SCP: 2.10.20220531) 2022/05/31
[13270.437337] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[13270.444289] pc : __arch_copy_to_user+0x180/0x240
[13270.448910] lr : _copy_to_iter+0x11c/0x5d0
[13270.453002] sp : ffff8000b15a37c0
[13270.456306] x29: ffff8000b15a37c0 x28: ffffdc9cf3ea0000 x27: ffffdc9cf6938158
[13270.463431] x26: ffff8000b15a3ba8 x25: 0000000000000690 x24: ffff8000b15a3b80
[13270.470556] x23: 00000000000038ac x22: ffffdc9cf3ea0000 x21: ffff8000b15a3b80
[13270.477682] x20: ffffdc9cf64fdf00 x19: 0000000000000400 x18: 0000000000000000
[13270.484806] x17: 0000000000000000 x16: 0000000000000000 x15: ffffdc9cf3ea0000
[13270.491931] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[13270.499056] x11: 0001000000000000 x10: ffffdc9cf64fdf00 x9 : 0000000000000690
[13270.506182] x8 : 000000007c000000 x7 : 0000fd007e000000 x6 : 000000000eee0b60
[13270.513306] x5 : 000000000eee0f60 x4 : 0000000000000000 x3 : 0000000000000400
[13270.520431] x2 : 0000000000000380 x1 : ffffdc9cf3ea0000 x0 : 000000000eee0b60
[13270.527556] Call trace:
[13270.529992]  __arch_copy_to_user+0x180/0x240
[13270.534250]  read_kcore_iter+0x718/0x878
[13270.538167]  proc_reg_read_iter+0x8c/0xe8
[13270.542168]  vfs_read+0x214/0x2c0
[13270.545478]  ksys_read+0x78/0x118
[13270.548782]  __arm64_sys_read+0x24/0x38
[13270.552608]  invoke_syscall+0x78/0x108
[13270.556351]  el0_svc_common.constprop.0+0x4c/0xf8
[13270.561044]  do_el0_svc+0x34/0x50
[13270.564347]  el0_svc+0x34/0x108
[13270.567482]  el0t_64_sync_handler+0x100/0x130
[13270.571829]  el0t_64_sync+0x194/0x198
[13270.575483] Code: d503201f d503201f d503201f d503201f (a8c12027) 
[13270.581567] ---[ end trace 0000000000000000 ]---

