Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D26191FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 04:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCYDYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 23:24:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36482 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYDYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:24:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id d11so1162898qko.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 20:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxxZGvRGJjfqPblxToXiOBcEL7NivaeSifGXK+WfYKI=;
        b=R2q/t0cPO8AvxdiJ5rMsHn5g+CRJvintIn2Sxpxo7FcBjadbCuQN9HNm++LD2upjyX
         hHLmhXpGq3JLJ1e3JSSaYLqAmrR5aoyCz35GmAclS1/pzzycXOy/dZZjFsffCV2tvwrL
         fnw1fr71wnxtpguvVVczxXv8m/22mA60/NEsrGQoC8sAseglUaWXxRiAYpwlZXMhydG9
         OicVMDO+jA5xACnQdrKuLyzmgxQlR5z0u4TxSgmCMwVBjwbn5InTdGkbvPuWmD8RSnQ9
         lJY8lgPvxYDPndInSeQoEuQ5IaTunHWOZYT/kqUDErQ49uEZqGSobzc8D5tug19Gqkvq
         dt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxxZGvRGJjfqPblxToXiOBcEL7NivaeSifGXK+WfYKI=;
        b=SjQFZTNXqW0AhJA71GGycHyTCU9b/7IUcbNJXP7PCiCBG2T8IRQgvLjoJM92RPwcaB
         5y+1vnHSWYotSJ6em1bh8nsGcY+orxZm5nuT3FaBzCydgxN1qYbZeVXZKsTKKFtAGJ8V
         KpzGIbqzeBo2hDCO0svHyKyqfq4DMUqZRB2zAY9jiFjTlM49+llcmhSXfI2V0Rv5XRT9
         NCTfPcTLu9Gzj0DZ62bqsOHkt2+ErKfIoENIUHpDE+0mQtqHC8eLvBXaUk/hc367vfv8
         TMZyBEiVguTNP6rvq3pCac/+pFOICJwvzq6DIR8ud3QABJ4aVVaAx4BgNNlbk+mMK40Z
         cIbQ==
X-Gm-Message-State: ANhLgQ0c5aQXGUIVUV1ZR3efn+WaQOVQcQByuFuwoWlmeEZnWDpRgvDz
        Neqd90QcT8geBl4ThjxbSeNA2Q==
X-Google-Smtp-Source: ADFU+vsHuAxJiNsoCz+bGbXTwfwJGprmIaLeu3KlQ3SbdBX963gzgHtcbXYptEKP7jPOJtdBM7Y8sA==
X-Received: by 2002:a37:c0d:: with SMTP id 13mr1013501qkm.417.1585106642744;
        Tue, 24 Mar 2020 20:24:02 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g2sm14695589qkb.27.2020.03.24.20.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 20:24:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325021327.GJ23230@ZenIV.linux.org.uk>
Date:   Tue, 24 Mar 2020 23:24:01 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 24, 2020, at 10:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Tue, Mar 24, 2020 at 09:49:48PM -0400, Qian Cai wrote:
>=20
>> It does not catch anything at all with the patch,
>=20
> You mean, oops happens, but neither WARN_ON() is triggered?
> Lovely...  Just to make sure: could you slap the same couple
> of lines just before
>                if (unlikely(!d_can_lookup(nd->path.dentry))) {
> in link_path_walk(), just to check if I have misread the trace
> you've got?
>=20
> Does that (+ other two inserts) end up with
> 	1) some of these WARN_ON() triggered when oops happens or
> 	2) oops is happening, but neither WARN_ON() triggers or
> 	3) oops not happening / becoming harder to hit?

Only the one just before
 if (unlikely(!d_can_lookup(nd->path.dentry))) {
In link_path_walk() will trigger.

[  245.766216][ T5020] WARNING: CPU: 65 PID: 5020 at fs/namei.c:2182 =
link_path_walk+0x29c/0x510
[  245.766242][ T5020] Modules linked in: kvm_hv kvm ip_tables x_tables =
xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy firmware_class =
dm_mirror dm_region_hash dm_log dm_mod
[  245.766289][ T5020] CPU: 65 PID: 5020 Comm: vdo Not tainted =
5.6.0-rc7-next-20200324+ #6
[  245.766314][ T5020] NIP:  c0000000004dbffc LR: c0000000004dc0e0 CTR: =
0000000000000000
[  245.766338][ T5020] REGS: c000200ec1fcf6c0 TRAP: 0700   Not tainted  =
(5.6.0-rc7-next-20200324+)
[  245.766374][ T5020] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  =
CR: 28228422  XER: 20040000
[  245.766415][ T5020] CFAR: c0000000004dc0e4 IRQMASK: 0=20
[  245.766415][ T5020] GPR00: c0000000004dc0e0 c000200ec1fcf950 =
c00000000165a500 0000000000000000=20
[  245.766415][ T5020] GPR04: c000000001511408 0000000000000000 =
c000200ec1fcf6a4 0000000000000002=20
[  245.766415][ T5020] GPR08: 0000000000000001 0000000000000000 =
0000000000000001 0000000000000001=20
[  245.766415][ T5020] GPR12: 0000000000008000 c000201fff7fa700 =
00007fffa6f0f360 c000200579ec7ae0=20
[  245.766415][ T5020] GPR16: 7fffffffffffffff fffffffffffffe00 =
0000000000000000 0000000000000000=20
[  245.766415][ T5020] GPR20: c000000c415a2498 c0002011e2cabd83 =
2f2f2f2f2f2f2f2f 0000000000000003=20
[  245.766415][ T5020] GPR24: 0000000000000000 c000200ec1fcfab8 =
fffffffffffff000 0000000000200000=20
[  245.766415][ T5020] GPR28: ffffffffffffffff 61c8864680b583eb =
0000000000000001 0000000000002e2e=20
[  245.766632][ T5020] NIP [c0000000004dbffc] link_path_walk+0x29c/0x510
[  245.766655][ T5020] LR [c0000000004dc0e0] link_path_walk+0x380/0x510
[  245.766677][ T5020] Call Trace:
[  245.766698][ T5020] [c000200ec1fcf950] [c0000000004dc0e0] =
link_path_walk+0x380/0x510 (unreliable)
[  245.766725][ T5020] [c000200ec1fcfa50] [c0000000004dc3c4] =
path_lookupat+0x94/0x1b0
[  245.766739][ T5020] [c000200ec1fcfa90] [c0000000004de010] =
filename_lookup.part.55+0xa0/0x170
[  245.766778][ T5020] [c000200ec1fcfbd0] [c00000000096cbe8] =
unix_find_other+0x58/0x3c0
[  245.766803][ T5020] [c000200ec1fcfc60] [c00000000096de54] =
unix_stream_connect+0x144/0x870
[  245.766842][ T5020] [c000200ec1fcfd30] [c0000000007cf860] =
__sys_connect+0x140/0x170
[  245.766881][ T5020] [c000200ec1fcfe00] [c0000000007cf8b8] =
sys_connect+0x28/0x40
[  245.766897][ T5020] [c000200ec1fcfe20] [c00000000000b378] =
system_call+0x5c/0x68
[  245.766921][ T5020] Instruction dump:
[  245.766952][ T5020] 38800000 7f23cb78 7fde07b4 1d5e0030 7d295214 =
eaa90020 4bfffab5 2fa30000=20
[  245.767003][ T5020] 409e00fc e9390008 7d2a0074 794ad182 <0b0a0000> =
2fa90000 419e0184 81290000=20
[  245.767031][ T5020] irq event stamp: 27044
[  245.767052][ T5020] hardirqs last  enabled at (27043): =
[<c0000000004db354>] handle_dots.part.47+0x224/0x960
[  245.767068][ T5020] hardirqs last disabled at (27044): =
[<c000000000008fbc>] program_check_common+0x21c/0x230
[  245.767096][ T5020] softirqs last  enabled at (27018): =
[<c000000000968620>] unix_create1+0x1e0/0x2a0
[  245.767144][ T5020] softirqs last disabled at (27016): =
[<c000000000968620>] unix_create1+0x1e0/0x2a0
[  245.767180][ T5020] ---[ end trace 7b3382b3d92e587f ]---
[  245.767202][ T5020] pathname =3D /var/run/nscd/socket
[  245.767225][ T5020] BUG: Kernel NULL pointer dereference on read at =
0x00000000
[  245.767248][ T5020] Faulting instruction address: 0xc0000000004dc008
[  245.767298][ T5020] Oops: Kernel access of bad area, sig: 11 [#1]
[  245.767320][ T5020] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[  245.767354][ T5020] Modules linked in: kvm_hv kvm ip_tables x_tables =
xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy firmware_class =
dm_mirror dm_region_hash dm_log dm_mod
[  245.767425][ T5020] CPU: 65 PID: 5020 Comm: vdo Tainted: G        W   =
      5.6.0-rc7-next-20200324+ #6
[  245.767460][ T5020] NIP:  c0000000004dc008 LR: c0000000004dc19c CTR: =
0000000000000000
[  245.767494][ T5020] REGS: c000200ec1fcf6c0 TRAP: 0300   Tainted: G    =
    W          (5.6.0-rc7-next-20200324+)
[  245.767541][ T5020] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  =
CR: 48228222  XER: 20040000
[  245.767579][ T5020] CFAR: c0000000004dc1a4 DAR: 0000000000000000 =
DSISR: 40000000 IRQMASK: 0=20
[  245.767579][ T5020] GPR00: c0000000004dc19c c000200ec1fcf950 =
c00000000165a500 000000000000001f=20
[  245.767579][ T5020] GPR04: 0000000000000006 0000000000000000 =
c000200ec1fcf6b4 0000000000000007=20
[  245.767579][ T5020] GPR08: 0000000000000003 0000000000000000 =
c000200ec118aa80 0000000000000000=20
[  245.767579][ T5020] GPR12: 0000000000008000 c000201fff7fa700 =
00007fffa6f0f360 c000200579ec7ae0=20
[  245.767579][ T5020] GPR16: 7fffffffffffffff fffffffffffffe00 =
0000000000000000 0000000000000000=20
[  245.767579][ T5020] GPR20: c000000c415a2498 c0002011e2cabd83 =
2f2f2f2f2f2f2f2f 0000000000000003=20
[  245.767579][ T5020] GPR24: 0000000000000000 c000200ec1fcfab8 =
fffffffffffff000 0000000000200000=20
[  245.767579][ T5020] GPR28: ffffffffffffffff 61c8864680b583eb =
0000000000000001 0000000000002e2e=20
[  245.767830][ T5020] NIP [c0000000004dc008] link_path_walk+0x2a8/0x510
[  245.767852][ T5020] LR [c0000000004dc19c] link_path_walk+0x43c/0x510
[  245.767884][ T5020] Call Trace:
[  245.767903][ T5020] [c000200ec1fcf950] [c0000000004dc19c] =
link_path_walk+0x43c/0x510 (unreliable)
[  245.767950][ T5020] [c000200ec1fcfa50] [c0000000004dc3c4] =
path_lookupat+0x94/0x1b0
[  245.767974][ T5020] [c000200ec1fcfa90] [c0000000004de010] =
filename_lookup.part.55+0xa0/0x170
[  245.768070][ T5020] [c000200ec1fcfbd0] [c00000000096cbe8] =
unix_find_other+0x58/0x3c0
[  245.768155][ T5020] [c000200ec1fcfc60] [c00000000096de54] =
unix_stream_connect+0x144/0x870
[  245.768255][ T5020] [c000200ec1fcfd30] [c0000000007cf860] =
__sys_connect+0x140/0x170
[  245.768358][ T5020] [c000200ec1fcfe00] [c0000000007cf8b8] =
sys_connect+0x28/0x40
[  245.768468][ T5020] [c000200ec1fcfe20] [c00000000000b378] =
system_call+0x5c/0x68
[  245.768545][ T5020] Instruction dump:
[  245.768609][ T5020] 1d5e0030 7d295214 eaa90020 4bfffab5 2fa30000 =
409e00fc e9390008 7d2a0074=20
[  245.768705][ T5020] 794ad182 0b0a0000 2fa90000 419e0184 <81290000> =
55290256 7f89d800 419efe8c=20
[  245.768816][ T5020] ---[ end trace 7b3382b3d92e5880 ]---
[  245.820494][ T5040] sda2: Can't mount, would change RO state=
