Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43BA1CFEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 21:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgELTuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELTuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 15:50:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C35C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:50:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so8681445qtp.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=xgJD2hpD7vnQ87u1OXtovDwmBIQGx+H7T13YM90Cpj4=;
        b=oyaEp0TSlc6Z4xfLcVeab/Erl0PVFTIiLxrS1Ytzffwb7DYHWL+ubEmhBiXDRrUBIC
         H1QOtXiShfC8X6acnuo8Dn36jroIYhsqY4BZyvLYl6NKBU5hNoWL8MDPXcu7FV3d42Nq
         Se6GLOoFSycCu1T4alpZMe1IpKS2JGuA6HBci3HN+f9KggDX9OEIIboOcSZRM6b+U5JE
         zipMF4T5557mB9R8r1Ri+OEZ/1GoWP35n1s47+SvymHpt15L0Y85AC96FNwpMu8t1YoM
         /eN/e3DcVqKyfS7/C8xZ/I+zzjQjKNAWXTtSHsK5yxqI321X00hi5LiBmvSu3v9NjqV9
         e5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=xgJD2hpD7vnQ87u1OXtovDwmBIQGx+H7T13YM90Cpj4=;
        b=jWZZpE7T2Koklpy8gWG5kzHYR24kFHR8iTYXCDyRiomEsaqTZti1k47cxRRX4kiNaw
         z6T+Vexq92DL0/JJN0sE7xUJod2pRa+S+QP60ZiQysnSpa8a6JN8z6+rxPdUho3ssVEG
         cJFFOCE+jzCLNuubV3YLhWMlx2NF8CoS4mc2MPEmjYMBtBaxd7duCRyT8rNN32gEoQSF
         esXi44uGab5EuW1rdI9J+Iftog4LVLxZ30z7XCexIhNcQeCOCoBDI9szCHCiIz93scQ/
         fjrNDoFdj1WgY5KyV3A2DIQPnfKV+8CvfPLf+l4ZuU19+WKyIFVNF9llryB7MwsDmL2V
         acNA==
X-Gm-Message-State: AOAM531ZbZjknkPz1Ye++36O56vHD2IGMsukUVRYMfL4nC2ICsM+R8kr
        0bom/Jt3kQ9Ewof36ucFz4R1uQ==
X-Google-Smtp-Source: ABdhPJx5yoJNFKpaTlovyxOByL1Afc0w9oDOw9IvzDUjgB/Gn2teZhN+0b3/S5ZTlmXmIN8UWrfVww==
X-Received: by 2002:ac8:6d0a:: with SMTP id o10mr4974425qtt.141.1589313034050;
        Tue, 12 May 2020 12:50:34 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o18sm64003qtb.7.2020.05.12.12.50.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 12:50:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Null-ptr-deref due to "vfs, fsinfo: Add an RCU safe per-ns mount
 list"
Message-Id: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
Date:   Tue, 12 May 2020 15:50:32 -0400
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reverted the linux-next commit ee8ad8190cb1 (=E2=80=9Cvfs, fsinfo: Add =
an RCU safe per-ns mount list=E2=80=9D) fixed the null-ptr-deref.

# runc run root

[ 1531.635242][ T4444] BUG: Kernel NULL pointer dereference on write at =
0x00000000
[ 1531.635285][ T4444] Faulting instruction address: 0xc0000000005689e0
[ 1531.635299][ T4444] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1531.635310][ T4444] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[ 1531.635331][ T4444] Modules linked in: kvm_hv kvm ip_tables x_tables =
xfs sd_mod bnx2x tg3 ahci libahci mdio libphy libata firmware_class =
dm_mirror dm_region_hash dm_log dm_mod
[ 1531.635370][ T4444] CPU: 16 PID: 4444 Comm: runc:[2:INIT] Not tainted =
5.7.0-rc5-next-20200512+ #9
[ 1531.635383][ T4444] NIP:  c0000000005689e0 LR: c0000000005689b0 CTR: =
0000000000000000
[ 1531.635413][ T4444] REGS: c000001323aef980 TRAP: 0300   Not tainted  =
(5.7.0-rc5-next-20200512+)
[ 1531.635434][ T4444] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  =
CR: 24424282  XER: 00000000
[ 1531.635468][ T4444] CFAR: c0000000006f9eec DAR: 0000000000000000 =
DSISR: 42000000 IRQMASK: 0=20
[ 1531.635468][ T4444] GPR00: c000000000570000 c000001323aefc10 =
c00000000168aa00 0000000000000001=20
[ 1531.635468][ T4444] GPR04: c0000015934e9e98 c0000015934e9e98 =
00000000283df117 fffffffe4386c189=20
[ 1531.635468][ T4444] GPR08: c000001323aefc38 0000000000000000 =
0000000000000000 0000000000000002=20
[ 1531.635468][ T4444] GPR12: 0000000024402282 c000001fffff1800 =
000000c000229990 000000000000000a=20
[ 1531.635468][ T4444] GPR16: ffffffffffffffff 0000000000000000 =
000000000000007a 000000012479c68c=20
[ 1531.635468][ T4444] GPR20: 0000000000000000 000000c000000180 =
0000000000000000 0000000000000000=20
[ 1531.635468][ T4444] GPR24: 0000000000000000 c00000000516b870 =
c00000000516b858 5deadbeef0000122=20
[ 1531.635468][ T4444] GPR28: c000001323aefc38 c0000015934e9e00 =
c0000015934e9ea8 c0000015934e9e98=20
[ 1531.635652][ T4444] NIP [c0000000005689e0] umount_tree+0x250/0x470
__write_once_size at include/linux/compiler.h:250
(inlined by) __hlist_del at include/linux/list.h:811
(inlined by) hlist_del_rcu at include/linux/rculist.h:487
(inlined by) umount_tree at fs/namespace.c:1485
[ 1531.635672][ T4444] LR [c0000000005689b0] umount_tree+0x220/0x470
[ 1531.635682][ T4444] Call Trace:
[ 1531.635709][ T4444] [c000001323aefca0] [c000000000570000] =
do_mount+0xb70/0xc90
[ 1531.635738][ T4444] [c000001323aefd70] [c0000000005706f8] =
sys_mount+0x158/0x180
[ 1531.635760][ T4444] [c000001323aefdc0] [c000000000038ac4] =
system_call_exception+0x114/0x1e0
[ 1531.635799][ T4444] [c000001323aefe20] [c00000000000c8f0] =
system_call_common+0xf0/0x278
[ 1531.635828][ T4444] Instruction dump:
[ 1531.635836][ T4444] 60000000 2fa30000 419e0014 e93f0008 e95f0000 =
f92a0008 f9490000 e93fffb8=20
[ 1531.635860][ T4444] e95fffc0 fbff0000 fbff0008 2fa90000 <f92a0000> =
419e0008 f9490008 e93f0058=20
[ 1531.635885][ T4444] ---[ end trace f12075f6fac94362 ]---
[ 1531.748352][ T4444]=20
[ 1532.748433][ T4444] Kernel panic - not syncing: Fatal exception=
