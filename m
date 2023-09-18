Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65377A5236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjIRSmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRSmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:42:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05486FC;
        Mon, 18 Sep 2023 11:42:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2D7C433C9;
        Mon, 18 Sep 2023 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695062521;
        bh=ecOplp0N39eFmx3h8Tyj1e5FA83CwJjtLZ8S7+4v1Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVBJqfiJBIpr+eauKB80fDRk/oQSO0zP7KLthqdCGos6whA/y0ay6T1V1QTYKjC9c
         c3fgHTW+BJlMlFlc0AK5tU6VrUpGcuEgVvhIVCQH/fL3NefXuhXtA9D+xa4FKqDCwg
         d2kvHewr943K2fzqPUtAbywwR+tg4hOIaPbc8HlA6i6ZgocgNRoVGvNTbO6iqq1K2v
         h5yRG60xMrsiHD4DWCpYg9T8HMjerGiKbGQ0bG9n8/51yH5HLQZt5K1/fFYdoS4vRb
         QnUNA+gnDkLOt45zxIwGu4gNvf4zLFxS8j15swM5YD1gXBIwSd2gWGcMMyGG8eLRs/
         Lg9rin4Gh2N5w==
Date:   Mon, 18 Sep 2023 11:42:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        mark.rutland@arm.com, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        chengzhihao <chengzhihao1@huawei.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Message-ID: <20230918184200.GA347993@frogsfrogsfrogs>
References: <ZOWFtqA2om0w5Vmz@fedora>
 <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
 <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com>
 <20230917091031.GA1543@noisy.programming.kicks-ass.net>
 <20230917092616.GA8409@noisy.programming.kicks-ass.net>
 <a6b10684-39ee-960a-10ab-663746800f85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b10684-39ee-960a-10ab-663746800f85@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:52:28AM +0800, Baokun Li wrote:
> On 2023/9/17 17:26, Peter Zijlstra wrote:
> > On Sun, Sep 17, 2023 at 11:10:32AM +0200, Peter Zijlstra wrote:
> > > On Sat, Sep 16, 2023 at 02:55:47PM +0800, Baokun Li wrote:
> > > > On 2023/9/13 16:59, Yi Zhang wrote:
> > > > > The issue still can be reproduced on the latest linux tree[2].
> > > > > To reproduce I need to run about 1000 times blktests block/001, and
> > > > > bisect shows it was introduced with commit[1], as it was not 100%
> > > > > reproduced, not sure if it's the culprit?
> > > > > 
> > > > > 
> > > > > [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
> > > > Hello, everyone！
> > > > 
> > > > We have confirmed that the merge-in of this patch caused hlist_bl_lock
> > > > (aka, bit_spin_lock) to fail, which in turn triggered the issue above.
> > > > [root@localhost ~]# insmod mymod.ko
> > > > [   37.994787][  T621] >>> a = 725, b = 724
> > > > [   37.995313][  T621] ------------[ cut here ]------------
> > > > [   37.995951][  T621] kernel BUG at fs/mymod/mymod.c:42!
> > > > [r[  oo 3t7@.l996o4c61al]h[o s T6t21] ~ ]#Int ernal error: Oops - BUG:
> > > > 00000000f2000800 [#1] SMP
> > > > [   37.997420][  T621] Modules linked in: mymod(E)
> > > > [   37.997891][  T621] CPU: 9 PID: 621 Comm: bl_lock_thread2 Tainted:
> > > > G            E      6.4.0-rc2-00034-g9257959a6e5b-dirty #117
> > > > [   37.999038][  T621] Hardware name: linux,dummy-virt (DT)
> > > > [   37.999571][  T621] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > > > BTYPE=--)
> > > > [   38.000344][  T621] pc : increase_ab+0xcc/0xe70 [mymod]
> > > > [   38.000882][  T621] lr : increase_ab+0xcc/0xe70 [mymod]
> > > > [   38.001416][  T621] sp : ffff800008b4be40
> > > > [   38.001822][  T621] x29: ffff800008b4be40 x28: 0000000000000000 x27:
> > > > 0000000000000000
> > > > [   38.002605][  T621] x26: 0000000000000000 x25: 0000000000000000 x24:
> > > > 0000000000000000
> > > > [   38.003385][  T621] x23: ffffd9930c698190 x22: ffff800008a0ba38 x21:
> > > > 0000000000000001
> > > > [   38.004174][  T621] x20: ffffffffffffefff x19: ffffd9930c69a580 x18:
> > > > 0000000000000000
> > > > [   38.004955][  T621] x17: 0000000000000000 x16: ffffd9933011bd38 x15:
> > > > ffffffffffffffff
> > > > [   38.005754][  T621] x14: 0000000000000000 x13: 205d313236542020 x12:
> > > > ffffd99332175b80
> > > > [   38.006538][  T621] x11: 0000000000000003 x10: 0000000000000001 x9 :
> > > > ffffd9933022a9d8
> > > > [   38.007325][  T621] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
> > > > ffffd993320b5b40
> > > > [   38.008124][  T621] x5 : ffff0001f7d1c708 x4 : 0000000000000000 x3 :
> > > > 0000000000000000
> > > > [   38.008912][  T621] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > > > 0000000000000015
> > > > [   38.009709][  T621] Call trace:
> > > > [   38.010035][  T621]  increase_ab+0xcc/0xe70 [mymod]
> > > > [   38.010539][  T621]  kthread+0xdc/0xf0
> > > > [   38.010927][  T621]  ret_from_fork+0x10/0x20
> > > > [   38.011370][  T621] Code: 17ffffe0 90000020 91044000 9400000d (d4210000)
> > > > [   38.012067][  T621] ---[ end trace 0000000000000000 ]---
> > > Is this arm64 or something? You seem to have forgotten to mention what
> > > platform you're using.
> > Is that an LSE or LLSC arm64 ?
> 
> I'm not sure how to distinguish if it's LSE or LLSC, here's some info on the
> cpu:
> 
> $ cat /sys/devices/system/cpu/cpu0/regs/identification/midr_el1
> 0x00000000481fd010
> 
> $ lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              96
> On-line CPU(s) list: 0-95
> Thread(s) per core:  1
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        4
> Vendor ID:           HiSilicon
> BIOS Vendor ID:      HiSilicon
> Model:               0
> Model name:          Kunpeng-920
> BIOS Model name:     Kunpeng 920-4826
> Stepping:            0x1
> BogoMIPS:            200.00
> L1d cache:           64K
> L1i cache:           64K
> L2 cache:            512K
> L3 cache:            49152K
> NUMA node0 CPU(s):   0-23
> NUMA node1 CPU(s):   24-47
> NUMA node2 CPU(s):   48-71
> NUMA node3 CPU(s):   72-95
> Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm
> 
> > Anyway, it seems that ARM64 shouldn't be using the fallback as it does
> > everything itself.
> > 
> > Mark, can you have a look please? At first glance the
> > atomic64_fetch_or_acquire() that's being used by generic bitops/lock.h
> > seems in order..
> > 
> We also suspect some implicit mechanism change in
> raw_atomic64_fetch_or_acquire. You can reproduce the problem with the
> above mod that can reproduce the problem to make it easier to locate.
> I can help reproduce it and grab some information if you can't reproduce
> it on your end.

FWIW this looks a lot like the crash I reported last week:
https://lore.kernel.org/linux-fsdevel/ZQep0OR0uMmR%2Fwg3@dread.disaster.area/T/#t

Also arm64, but virtualized.  I /think/ the host is some Ampere box,
though I have no idea what kind since it's just some Oracle Cloud A1
instance.  The internet claims "Ampere Altra" processors[1].

# lscpu
Architecture:           aarch64
  CPU op-mode(s):       32-bit, 64-bit
  Byte Order:           Little Endian
CPU(s):                 2
  On-line CPU(s) list:  0,1
Vendor ID:              ARM
  Model name:           Neoverse-N1
    Model:              1
    Thread(s) per core: 1
    Core(s) per socket: 2
    Socket(s):          1
    Stepping:           r3p1
    BogoMIPS:           50.00
    Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32
atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp ssbs
NUMA:                   
  NUMA node(s):         1
  NUMA node0 CPU(s):    0,1
Vulnerabilities:        
  Gather data sampling: Not affected
  Itlb multihit:        Not affected
  L1tf:                 Not affected
  Mds:                  Not affected
  Meltdown:             Not affected
  Mmio stale data:      Not affected
  Retbleed:             Not affected
  Spec rstack overflow: Not affected
  Spec store bypass:    Vulnerable
  Spectre v1:           Mitigation; __user pointer sanitization
  Spectre v2:           Mitigation; CSV2, but not BHB
  Srbds:                Not affected
  Tsx async abort:      Not affected

[1] https://www.oracle.com/cloud/compute/arm/ 

--D

> -- 
> With Best Regards,
> Baokun Li
> .
