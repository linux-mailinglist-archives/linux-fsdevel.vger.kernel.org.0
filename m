Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094022621E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfEVKlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 06:41:01 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38034 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfEVKk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 06:40:59 -0400
Received: by mail-wm1-f44.google.com with SMTP id t5so1666860wmh.3;
        Wed, 22 May 2019 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=ufb5qrOtiYKTv9pZ9ZS/QeAeAuXKn/F7lIRNi3a9VdU=;
        b=H0FUcWCnaMxwwJCrWnU6trXMst+UzT0A3KfDdsjavwTS0is4016Q3VPAzlei/TNnK0
         oJ14HO1Ts8drsx9OzYwPe6Cq8fbzyAbEl81EINzkPXHo11H4qvfygJ64YflFdGnYYMYz
         J230pA09f/vNSwojUR/Qs5nr42silx8KzaYPbaKc+pfB7v/3o2E1AygFLb4WUk3U9Hfd
         OJ4qps05KinBarLOJd1ezQJAvzQKP/UYON9h93qJWNztnNU3lRg5eJenMpc+6XjefHF4
         Dk6SxsCTtoFqixHJr7AFj4ujXoZqzAW45Ipc9DgcCRI3WbxU60TN+QvYExC9ZhuEuGc5
         aLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=ufb5qrOtiYKTv9pZ9ZS/QeAeAuXKn/F7lIRNi3a9VdU=;
        b=JlB36tK7ZXY4IkdqVcOQAV+F2AD0l3QRUK7X0MbzfiMn3S4OHACL0gC4uinxb1NiSB
         mZCYCmm6ZtV6LUVCynFt4yZeJYkVofcyoKzB+8obex2zqsBibz3dlvUzanOPC3Rms1XX
         aKMjZ3EF98LgHNnT/PQy8au0WK4M22wxNknl8aRhsayWoUmTp58vBVpwWzA1gNSa+23U
         yRbpuxnbJS8NFy1tjJTYNSiHWEqoXQpY1TpjqGzitDzZ8QaSTBLqRotUIZ4thcziFZJQ
         XjO60Eu6bOE//9N+PzQr7bbcEJ3ZaXPc7Vbs8/bAEqG9HQxpIm9TjoRuEepbBEb1U2di
         6J+g==
X-Gm-Message-State: APjAAAVARkB8wK5GDRclyeLxFTl5HC4mTud1bXL2pWqETicITS2nqwnh
        khBhXkdW9o3pUAL6wOjDB2+eaOGNxAE=
X-Google-Smtp-Source: APXvYqwxabULwe+puwT2UrwV3hJZYXykw088FtbyfmiPtroWFSaOSyVygUMyXvlaZxBknG4bYc8+nA==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr7173440wmk.57.1558521657256;
        Wed, 22 May 2019 03:40:57 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id x64sm10820870wmg.17.2019.05.22.03.40.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 03:40:56 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Wed, 22 May 2019 12:40:55 +0200
MIME-Version: 1.0
Message-ID: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
since a recent update the kernel is reporting d_lookup errors.
They appear randomly and after each error the affected file or directory
is no longer accessible.
The kernel is built with GCC 9.1.0 on ARM64.
Four traces from different workloads follow.

This trace is from v5.1-12511-g72cf0b07418a while untaring into a tmpfs
filesystem:

Unable to handle kernel paging request at virtual address 0000880001000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp =3D 000000007ccc6c7d
[0000880001000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#1] SMP
Process tar (pid: 1673, stack limit =3D 0x0000000083be9793)
CPU: 5 PID: 1673 Comm: tar Not tainted 5.1.0 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup+0x58/0x198
lr : d_lookup+0x38/0x68
sp : ffff0000126e3ba0
x29: ffff0000126e3ba0 x28: ffff0000126e3d68=20
x27: 0000000000000000 x26: ffff80008201d300=20
x25: 0000000000000001 x24: ffffffffffffffff=20
x23: 00000000ce986489 x22: 0000000000000000=20
x21: 0000000000000001 x20: ffff0000126e3d68=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: a4d0a4a8a4fea3d0=20
x9 : 2f062c662d62dfa7 x8 : f2025989e6593ef3=20
x7 : b24a95208032f7e2 x6 : 0000000000000001=20
x5 : 0000000000000000 x4 : ffff0000126e3d68=20
x3 : ffff000010828a68 x2 : ffff000010828000=20
x1 : ffff8000f3000000 x0 : 00000000000674c3=20
Call trace:
 __d_lookup+0x58/0x198
 d_lookup+0x38/0x68
 path_openat+0x4a8/0xfb8
 do_filp_open+0x60/0xd8
 do_sys_open+0x144/0x1f8
 __arm64_sys_openat+0x20/0x28
 el0_svc_handler+0x68/0xd8
 el0_svc+0x8/0xc
Code: 92800018 a9025bf5 d2800016 52800035 (b9401a62)=20
---[ end trace 8d5c8dc953aa6402 ]---

This trace is from v5.2.0-rc1:

Unable to handle kernel paging request at virtual address 0000880001000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp =3D 000000004850c69c
[0000880001000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#1] SMP
Process read_sensors (pid: 926, stack limit =3D 0x00000000aaf00007)
CPU: 0 PID: 926 Comm: read_sensors Not tainted 5.2.0-rc1 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup+0x58/0x198
lr : d_lookup+0x38/0x68
sp : ffff000011ee3c60
x29: ffff000011ee3c60 x28: ffff000011ee3d98=20
x27: 0000000000000000 x26: ffff8000f28083c0=20
x25: 0000000000000276 x24: ffffffffffffffff=20
x23: 00000000ce97b3cf x22: 0000000000000000=20
x21: 0000000000000001 x20: ffff000011ee3d98=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000002 x16: 0000000000000001=20
x15: ffff8000e4b3a8c8 x14: ffffffffffffffff=20
x13: ffff000011ee3db8 x12: ffff000011ee3dad=20
x11: 0000000000000000 x10: ffff000011ee3d20=20
x9 : 00000000ffffffd8 x8 : 000000000000039e=20
x7 : 0000000000000000 x6 : 0000000000000002=20
x5 : 61c8864680b583eb x4 : 42bed11fefc04553=20
x3 : ffff000010828a68 x2 : ffff000010828000=20
x1 : ffff8000f3000000 x0 : 00000000000674bd=20
Call trace:
 __d_lookup+0x58/0x198
 d_lookup+0x38/0x68
 d_hash_and_lookup+0x50/0x68
 proc_flush_task+0x98/0x198
 release_task+0x60/0x4b8
 do_exit+0x680/0xa68
 __arm64_sys_exit+0x14/0x18
 el0_svc_handler+0x68/0xd8
 el0_svc+0x8/0xc
Code: 92800018 a9025bf5 d2800016 52800035 (b9401a62)=20
---[ end trace c9b8ee5d6aa547ae ]---

This trace is from v5.2.0-rc1 while executing 'git pull -r' from f2fs. It
got repeated several times:

Unable to handle kernel paging request at virtual address 0000000000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp =3D 0000000092bdb9cd
[0000000000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#2] SMP
Process git (pid: 2996, stack limit =3D 0x000000004b733f9b)
CPU: 5 PID: 2996 Comm: git Tainted: G      D           5.2.0-rc1 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff000013f83aa0
x29: ffff000013f83aa0 x28: 00000000ce9798e9=20
x27: ffffffffffffffff x26: 0000000000000015=20
x25: ffff800009268043 x24: ffff000013f83b6c=20
x23: 0000000000000005 x22: 00000015ce9798e9=20
x21: ffff800039a7a780 x20: 0000000000000000=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0d0d0b3b3fea4a3=20
x9 : f2862b1e24d6cb78 x8 : fac1836b95d6b53a=20
x7 : c1462108f502da45 x6 : 0847a816d22e0a31=20
x5 : ffff800009268043 x4 : ffff8000f3000000=20
x3 : ffff000013f83c88 x2 : ffff000013f83b6c=20
x1 : 00000000000674bc x0 : ffff800039a7a780=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 walk_component+0x34/0x2e0
 path_lookupat.isra.0+0x5c/0x1e0
 filename_lookup+0x78/0xf0
 user_path_at_empty+0x44/0x58
 vfs_statx+0x70/0xd0
 __se_sys_newfstatat+0x20/0x40
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x68/0xd8
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace c9b8ee5d6aa547af ]---

This trace is from v5.2.0-rc1 while executing 'rm -rf' the directory
affected from the previous trace:

Unable to handle kernel paging request at virtual address 0000000001000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp =3D 00000000649981ae
[0000000001000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#10] SMP
Process rm (pid: 6401, stack limit =3D 0x00000000e524cae1)
CPU: 5 PID: 6401 Comm: rm Tainted: G      D           5.2.0-rc1 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup+0x58/0x198
lr : d_lookup+0x38/0x68
sp : ffff000016993d00
x29: ffff000016993d00 x28: ffff000016993e70=20
x27: 0000000000000000 x26: ffff800039a7a780=20
x25: 0000000056000000 x24: ffffffffffffffff=20
x23: 00000000ce9798e9 x22: 0000000000000000=20
x21: 0000000000000001 x20: ffff000016993e70=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0d0d0b3b3fea4a3=20
x9 : f2862b1e24d6cb78 x8 : fac1836b95d6b53a=20
x7 : c1462108f502da45 x6 : 00000000ffffffff=20
x5 : 0000000000000000 x4 : ffff8000eb31d500=20
x3 : ffff000010828a68 x2 : ffff000010828000=20
x1 : ffff8000f3000000 x0 : 00000000000674bc=20
Call trace:
 __d_lookup+0x58/0x198
 d_lookup+0x38/0x68
 lookup_dcache+0x20/0x80
 __lookup_hash+0x20/0xc8
 do_unlinkat+0x10c/0x278
 __arm64_sys_unlinkat+0x34/0x60
 el0_svc_handler+0x68/0xd8
 el0_svc+0x8/0xc
Code: 92800018 a9025bf5 d2800016 52800035 (b9401a62)=20
---[ end trace c9b8ee5d6aa547b7 ]---

Regards,
  Vicen=C3=A7.

