Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FC2A468F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgKCNcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgKCNcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:04 -0500
X-Greylist: delayed 551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Nov 2020 05:32:04 PST
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:1:101::144:244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516BC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 05:32:04 -0800 (PST)
Received: from localhost (ip-94-112-194-201.net.upcbroadband.cz [94.112.194.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id C03D240006B;
        Tue,  3 Nov 2020 14:22:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1604409770;
        bh=EslcdwcXgj1XnBOxTil9bYiz7cxj/DhPm189tHKLjBA=;
        h=From:To:Cc:Subject:Date;
        b=k+kZ9IThZrgC/qNUVYq5VpKjcCx20H4O6+BAC5HrvroJseKHSFaRPVMx6fAiP/mbY
         6n/SGDjm07dD0dshZcXhvWAHAcdLYmNVBhkScR03a4RDfVbX1gMvstINrWPD3/U8+C
         3iMS53vlu/efR5NKgj7z5O5gN0xRINNoaRklKAHg1ukHSgBeLh9R+rkAlFPlTbpNCq
         WBaSaDQFzXoMHdZJ3fDFqBOOc/yOBjVY0oxgs3s4FaCZlwJuyu7ocxoHU5s13Z4yes
         U1Kn5sLdA7X0St+UwM7L0rpz+y6DWusT0/8hc7Nj+OfBaeroBsKouQ+A4IsYIRbHLT
         Y9SEJM20XEevg==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Lennart Poettering <lennart@poettering.net>
Subject: Null pointer dereference in =?iso-8859-1?Q?nsfs=5Fevict_with_CONFIG=5FNET=5FNS=3Dn_triggered_via_syst?=
 =?iso-8859-1?Q?emd-networkd's_debugging?=
Date:   Tue, 03 Nov 2020 14:22:49 +0100
MIME-Version: 1.0
Message-ID: <aa151d26-37a1-4836-b28f-33c46d9894e2@cesnet.cz>
Organization: CESNET
User-Agent: Trojita/unstable-2020-07-06; Qt/5.14.2; xcb; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I'm getting the following oops on 5.9.3 (and 5.9.1, and 5.6.7, all with=20
some unrelated patches, see [1]). In this crash, nsfs_evict() gets called=20
with ns->ops being NULL.

[    6.947411] 8<--- cut here ---
[    6.950502] Unable to handle kernel NULL pointer dereference at virtual=20=

address 00000010
[    6.958685] pgd =3D da1de5c3
[    6.961417] [00000010] *pgd=3D3fcd2831
[    6.965047] Internal error: Oops: 17 [#1] SMP ARM
[    6.969781] CPU: 0 PID: 199 Comm: systemd-network Not tainted=20
5.9.1-cla-cfb #1
[    6.977033] Hardware name: Marvell Armada 380/385 (Device Tree)
[    6.982991] PC is at nsfs_evict+0x18/0x20
[    6.987029] LR is at evict+0xac/0x188
[    6.990716] pc : [<c029aa84>]    lr : [<c027d40c>]    psr: 60010013
[    6.997009] sp : ecdefed0  ip : 00000001  fp : 00000000
[    7.002258] r10: c0c03e8c  r9 : 5ac3c35a  r8 : ef036910
[    7.007508] r7 : ed2d4880  r6 : c090a5c0  r5 : ed23c910  r4 : ed23c858
[    7.014064] r3 : 00000000  r2 : ed23c918  r1 : 00000000  r0 : c0c60190
[    7.020621] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=20=

none
[    7.027787] Control: 10c5387d  Table: 2cc4404a  DAC: 00000051
[    7.033566] Process systemd-network (pid: 199, stack limit =3D 0x7d1d3b46)=

[    7.040299] Stack: (0xecdefed0 to 0xecdf0000)
[    7.044684] fec0:                                     ed2d4880 00000000=20=

ed2d48d0 c0278804
[    7.052901] fee0: ed7bf0c0 0008801d ed23c858 c02615ec 00000000 ed23c858=20=

00000000 c0265d1c
[    7.061117] ff00: 000007ff 00000000 ed6930ec ed692cc0 c0c73ee4 00000454=20=

5ac3c35a c0140350
[    7.069339] ff20: ecdee000 ecdeffb0 c0100264 fffffe30 c0100264 c010a7b0=20=

ed26c200 be8b0860
[    7.077572] ff40: 00004000 00000128 c0100264 c069b5d4 00000000 00000000=20=

00000000 000000fe
[    7.085798] ff60: 00000000 00000000 00000000 c01401f8 00000000 c0c03e88=20=

ed7bf0c0 ed7bf0c0
[    7.094012] ff80: 00000000 c0c03e88 ed7bf0c0 0000000b b6f794d0 01776af0=20=

00000006 c0100264
[    7.102233] ffa0: ecdee000 00000006 00000000 c01000cc 00000000 be8b0860=20=

00000000 00000000
[    7.110457] ffc0: 0000000b b6f794d0 01776af0 00000006 0000000b 0177445c=20=

b6f80000 00000000
[    7.118673] ffe0: b6f4b10c be8b1a40 b6e1e490 b6d1c320 60010010 0000000b=20=

00000000 00000000
[    7.126898] [<c029aa84>] (nsfs_evict) from [<00000000>] (0x0)
[    7.132676] Code: ebff8a17 e1a00004 e5943004 e8bd4010 (e5933010)=20
[    7.138841] ---[ end trace 2b44d591054a9910 ]---
[    7.143482] Kernel panic - not syncing: Fatal exception
[    7.148733] CPU1: stopping
[    7.151455] CPU: 1 PID: 331 Comm: bash Tainted: G      D          =20
5.9.1-cla-cfb #1
[    7.159133] Hardware name: Marvell Armada 380/385 (Device Tree)
[    7.165080] [<c010f10c>] (unwind_backtrace) from [<c010add8>]=20
(show_stack+0x10/0x14)
[    7.172849] [<c010add8>] (show_stack) from [<c07eccac>]=20
(dump_stack+0x94/0xa8)
[    7.180095] [<c07eccac>] (dump_stack) from [<c010dda8>]=20
(handle_IPI+0x340/0x378)
[    7.187516] [<c010dda8>] (handle_IPI) from [<c0430e34>]=20
(gic_handle_irq+0x8c/0x90)
[    7.195110] [<c0430e34>] (gic_handle_irq) from [<c0100b0c>]=20
(__irq_svc+0x6c/0x90)
[    7.202612] Exception stack(0xecedbe28 to 0xecedbe70)
[    7.207678] be20:                   edb83d90 edb72bc8 c022a3d8 0000015f=20=

edb72bc8 00000000
[    7.215879] be40: 0013f000 edb72ba0 edb72ba0 ed7774bc c0cc0e20 ed777480=20=

00021000 ecedbe78
[    7.224079] be60: ed61d4e0 c022ac48 a00d0013 ffffffff
[    7.229148] [<c0100b0c>] (__irq_svc) from [<c022ac48>]=20
(anon_vma_interval_tree_remove+0x1dc/0x2d4)
[    7.238135] [<c022ac48>] (anon_vma_interval_tree_remove) from=20
[<c023efe4>] (unlink_anon_vmas+0xbc/0x1fc)
[    7.247644] [<c023efe4>] (unlink_anon_vmas) from [<c022f6f4>]=20
(free_pgtables+0x48/0xb4)
[    7.255674] [<c022f6f4>] (free_pgtables) from [<c0238dd8>]=20
(exit_mmap+0xe8/0x1b4)
[    7.263183] [<c0238dd8>] (exit_mmap) from [<c011c43c>] (mmput+0x48/0xec)
[    7.269905] [<c011c43c>] (mmput) from [<c0124430>] (do_exit+0x2d4/0x930)
[    7.276625] [<c0124430>] (do_exit) from [<c0124af4>]=20
(do_group_exit+0x3c/0xb8)
[    7.283868] [<c0124af4>] (do_group_exit) from [<c0124b80>]=20
(__wake_up_parent+0x0/0x18)
[    7.291815] Rebooting in 10 seconds..

Vlastimil Babka helped me debug this (thanks a lot!), and the ns->ops is=20
supposed to be set via net_ns_net_init(). That code, however, only=20
initializes this ops structure when CONFIG_NET_NS=3Dy, and I have=20
CONFIG_NET_NS=3Dn.

On how to reproduce, this is where the fun starts. I'm getting this on an=20
ARM board (mvebu, SolidRun Clearfog Base). It started happening after=20
updating userland from systemd-243.4 to systemd-246.6 (and a ton of=20
unrelated bits including the toolchain -- you know, embedded updates).=20
However, it *only* happens when that new enough systemd-networkd is=20
launched with SYSTEMD_LOG_LEVEL=3Ddebug, and indeed, here's what a relevant=20=

part of the diff of the updated systemd looks like (in particular systemd=20
commit f6dbcebdc28cabf36e6665b67d52d43192fb88df):

@@ -164,12 +158,54 @@ int device_monitor_new_full(sd_device_monitor **ret,=20=

MonitorNetlinkGroup group,
=20
         if (fd >=3D 0) {
                 r =3D monitor_set_nl_address(m);
-                if (r < 0)
-                        return log_debug_errno(r, "sd-device-monitor:=20
Failed to set netlink address: %m");
+                if (r < 0) {
+                        log_debug_errno(r, "sd-device-monitor: Failed to=20
set netlink address: %m");
+                        goto fail;
+                }
+        }
+
+        if (DEBUG_LOGGING) {
+                _cleanup_close_ int netns =3D -1;
+
+                /* So here's the thing: only AF_NETLINK sockets from the=20
main network namespace will get
+                 * hardware events. Let's check if ours is from there, and=20=

if not generate a debug message,
+                 * since we cannot possibly work correctly otherwise. This=20=

is just a safety check to make
+                 * things easier to debug. */
+
+                netns =3D ioctl(m->sock, SIOCGSKNS);
+                if (netns < 0)
+                        log_debug_errno(errno, "sd-device-monitor: Unable=20=

to get network namespace of udev netlink socket, unable to determine if we=20=

are in host netns: %m");
+                else {
+                        struct stat a, b;
+
+                        if (fstat(netns, &a) < 0) {
+                                r =3D log_debug_errno(errno,=20
"sd-device-monitor: Failed to stat netns of udev netlink socket: %m");
+                                goto fail;
+                        }
+
+                        if (stat("/proc/1/ns/net", &b) < 0) {
+                                if (ERRNO_IS_PRIVILEGE(errno))
+                                        /* If we can't access PID1's netns=20=

info due to permissions, it's fine, this is a
+                                         * safety check only after all. */
+                                        log_debug_errno(errno,=20
"sd-device-monitor: No permission to stat PID1's netns, unable to determine=20=

if we are in host netns: %m");
+                                else
+                                        log_debug_errno(errno,=20
"sd-device-monitor: Failed to stat PID1's netns: %m");
+
+                        } else if (a.st_dev !=3D b.st_dev || a.st_ino !=3D=20=

b.st_ino)
+                                log_debug("sd-device-monitor: Netlink=20
socket we listen on is not from host netns, we won't see device events.");
+                }
         }

Apparently, when debugging is enabled, something stats /proc/1/ns/net,=20
quite likely from a sandboxed/namespaced/whatever process context, and that=20=

something was not happening on the previous version of systemd.

Anyway, I'm so happy I can finally reproduce this "mysterious crash" on a=20
box with a remote console, so please feel free to ask for extra details if=20=

needed. I'll also be happy to try patches, etc. Perhaps Lennart has a=20
reproducer that's small enough? Something simple as `ls -al` from a SSH=20
session is not enough.

With kind regards,
Jan

[1]=20
https://gerrit.cesnet.cz/plugins/gitiles/github/torvalds/linux/+log/refs/head=
s/cesnet/2020-11-03---5.9.3
