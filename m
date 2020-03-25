Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A723191EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 02:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCYBtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 21:49:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36147 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCYBtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:49:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id d11so962536qko.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gjUYshtRC8gS4+hgSReNoWC87X/5lWQXqWSgZ70GfYA=;
        b=F4QiCniJLLW4wm+FpdTYsEH0yvgJ1uECCpd5X1/MrL3Edaxh5VnQjXpF1B3mAflaxS
         /hMw3mVcWgk8Dfh8xT6zdotoqFBSH8zYVvszix6Ks+e3UsGJvSaOS7TWtcL86wOKpLAM
         eXa2cdmD7FSuznEdyXyWoII/LtNpnIKgtju04dhpr71W5emCIUGgWq7K2PyvfypIV0UI
         9GdAEJ0M/FTJglJ+azqObYAWnUgDaQGUOYrmVuiZgFIWogTLJrHEJBxipxOPEGa3DSg6
         HAXTPyw+sGAVkYVZWHFUf2Lp56eeF2Qp1fodDLmfMkh0Lz2HSC5upRDltm9P+mCjrcAa
         fmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gjUYshtRC8gS4+hgSReNoWC87X/5lWQXqWSgZ70GfYA=;
        b=S8ZqWUQ5j5Fsk4PMBcH7MezXYuwuc590VqGoQNe7uQybpl8xfOoRlaNwdiuahrgsD/
         bCztY1HJ94Zf1I531wwLaSEbvG0351kQVtA/IMbtaI4ZjJ8t+f8LvMMZrHk6PNpHnwkr
         41CzFMitDtZn38E7lQyiVGTSGFQ7mAxOXWJ6EtpV6oDkfBzN81eq0IYlro67IBdfSFjb
         JF8XGlOtQVhVWy+oTs5NvFx8FpaXHjStkpGGnSAmhIPewk1xpQgw0MUwRsv4DAjV2UT1
         Lh32FSqXuY8vmIaZPAfbkib/+JddqfKYLXzsPp1ASTB5Syqf7w8M4X7VbhcrwUCXDyNJ
         iD1g==
X-Gm-Message-State: ANhLgQ30KqmrSl+CfCFrHRxhFyuu72ARhuw3kHt2kvsqT3WlfvBiumGj
        ibo/Rhjn7tCauRi0CRkej1YktnhiGfiYQg==
X-Google-Smtp-Source: ADFU+vuwElkyNzMaVUqeRfqjBzG64s8cjuLzOxG+hCbvmcqzxXj3pS4ExB59EhGZASfkBjjycvPzgw==
X-Received: by 2002:a37:9544:: with SMTP id x65mr784261qkd.48.1585100990794;
        Tue, 24 Mar 2020 18:49:50 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g25sm5109906qkm.121.2020.03.24.18.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 18:49:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200324214637.GI23230@ZenIV.linux.org.uk>
Date:   Tue, 24 Mar 2020 21:49:48 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 24, 2020, at 5:46 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Tue, Mar 24, 2020 at 05:06:03PM -0400, Qian Cai wrote:
>> Reverted the series on the top of today's linux-next fixed boot =
crashes.
>=20
> Umm...  How about a reproducer (or bisect of vfs.git#work.dotdot, =
assuming
> it reproduces there)?

Booting powerpc (power9 PowerNV) and arm64 (HPE Apollo 70, Thunder X2) a
few times could trigger it using the configs here,

https://github.com/cailca/linux-mm

>=20
>> [   53.027443][ T3519] BUG: Kernel NULL pointer dereference on read =
at 0x00000000
>> [   53.027480][ T3519] Faulting instruction address: =
0xc0000000004dbfa4
>> [   53.027498][ T3519] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   53.027521][ T3519] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256=
 DEBUG_PAGEALLOC NUMA PowerNV
>> [   53.027538][ T3519] Modules linked in: kvm_hv kvm ip_tables =
x_tables xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy =
firmware_class dm_mirror dm_region_hash dm_log dm_mod
>> [   53.027594][ T3519] CPU: 36 PID: 3519 Comm: polkitd Not tainted =
5.6.0-rc7-next-20200324 #1
>> [   53.027618][ T3519] NIP:  c0000000004dbfa4 LR: c0000000004dc040 =
CTR: 0000000000000000
>> [   53.027634][ T3519] REGS: c0002013879af810 TRAP: 0300   Not =
tainted  (5.6.0-rc7-next-20200324)
>> [   53.027668][ T3519] MSR:  9000000000009033 =
<SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24004422  XER: 20040000
>> [   53.027708][ T3519] CFAR: c0000000004dc044 DAR: 0000000000000000 =
DSISR: 40000000 IRQMASK: 0=20
>> [   53.027708][ T3519] GPR00: c0000000004dc040 c0002013879afaa0 =
c00000000165a500 0000000000000000=20
>> [   53.027708][ T3519] GPR04: c000000001511408 0000000000000000 =
c0002013879af834 0000000000000002=20
>> [   53.027708][ T3519] GPR08: 0000000000000001 0000000000000000 =
0000000000000000 0000000000000001=20
>> [   53.027708][ T3519] GPR12: 0000000000004000 c000001ffffe1e00 =
0000000000000000 0000000000000000=20
>> [   53.027708][ T3519] GPR16: 0000000000000000 0000000000000001 =
0000000000000000 0000000000000000=20
>> [   53.027708][ T3519] GPR20: c000200ea1eacf38 c000201c8102f043 =
2f2f2f2f2f2f2f2f 0000000000000003=20
>> [   53.027708][ T3519] GPR24: 0000000000000000 c0002013879afbc8 =
fffffffffffff000 0000000000200000=20
>> [   53.027708][ T3519] GPR28: ffffffffffffffff 61c8864680b583eb =
0000000000000000 0000000000002e2e=20
>> [   53.027931][ T3519] NIP [c0000000004dbfa4] =
link_path_walk+0x284/0x4c0
>> __d_entry_type at include/linux/dcache.h:389
>> (inlined by) d_can_lookup at include/linux/dcache.h:404
>> (inlined by) link_path_walk at fs/namei.c:2178
>=20
> ... and apparently NULL nd->path.dentry there.  After walk_component()
> having returned NULL.  Which means either handle_dots() returning NULL
> or step_into() doing the same.  The former means either (for "..")
> step_into() having returned NULL, or nd->path.dentry left unchanged.
>=20
> So we either have step_into() returning NULL with nd->path.dentry =
ending up
> NULL, or we'd entered link_path_walk() with nd->path.dentry being NULL =
(it
> must have been that way on the entry, or we would've barfed on the =
previous
> iteration).
>=20
> 1) step_into() returns NULL either after
>        if (likely(!d_is_symlink(path.dentry)) ||
>           ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
>           (flags & WALK_NOFOLLOW)) {
>                /* not a symlink or should not follow */
>                if (!(nd->flags & LOOKUP_RCU)) {
>                        dput(nd->path.dentry);
>                        if (nd->path.mnt !=3D path.mnt)
>                                mntput(nd->path.mnt);
>                } =20
>                nd->path =3D path;
>                nd->inode =3D inode;
>                nd->seq =3D seq;
>                return NULL;
> in which case nd->path.dentry is left equal to path.dentry, which =
can't be
> NULL (we would've oopsed on d_is_symlink() if it had been) or it's
> pick_link() returning NULL and leaving NULL nd->path.dentry.
>=20
> pick_link() either leaves nd->path unchanged (in which case we are =
back to
> the "had NULL nd->path.dentry on entry into link_path_walk()") or does
> nd_jump_root() (absolute symlinks) or has ->get_link() call =
nd_jump_link().
> nd_jump_root() cannot survive leaving NULL in ->path.dentry - it hits
> either
>                d =3D nd->path.dentry;
>                nd->inode =3D d->d_inode;
> or
>                nd->inode =3D nd->path.dentry->d_inode;
> and either would've ooped right there.
> nd_jump_link() hits
>        nd->inode =3D nd->path.dentry->d_inode;
> on the way out, which also should be impossible to survive.
>=20
> So we appear to have hit link_path_walk() with NULL nd->path.dentry.  =
And
> it's path_lookupat() from vfs_statx(), so we don't have LOOKUP_DOWN =
there.
> Which means either path_init() leaving NULL nd->path.dentry or =
lookup_last()
> returning NULL and leaving NULL nd->path.dentry...  The latter is =
basically
> walk_component(), so we would've had left link_path_walk() without an
> error, with symlink picked and with NULL nd->path.dentry.  Which means
> having the previous call of link_path_walk() also entered with NULL
> nd->path.dentry...
>=20
> OK, so it looks like path_init() returning a string and leaving =
that...
> And I don't see any way for that to happen...
>=20
>=20
> Right, so...  Could you slap the following
> 	if (WARN_ON(!nd->path.dentry))
> 		printk(KERN_ERR "pathname =3D %s\n", nd->name->name);
> 1) into beginning of link_path_walk(), right before
>        while (*name=3D=3D'/')
>                name++;
>        if (!*name)
>                return 0;
> in there.
> 2) into pick_link(), right after
> all_done: // pure jump
>=20
> and see what your reproducer catches?

It does not catch anything at all with the patch,

diff --git a/fs/namei.c b/fs/namei.c
index 311e33dbac63..d3ab3dd3e522 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1659,6 +1659,8 @@ static const char *pick_link(struct nameidata *nd, =
struct path *link,
        if (*res)
                return res;
 all_done: // pure jump
+if (WARN_ON(!nd->path.dentry))
+               printk(KERN_ERR "pathname =3D %s\n", nd->name->name);
        put_link(nd);
        return NULL;
 }
@@ -2096,6 +2098,8 @@ static int link_path_walk(const char *name, struct =
nameidata *nd)
        nd->flags |=3D LOOKUP_PARENT;
        if (IS_ERR(name))
                return PTR_ERR(name);
+if (WARN_ON(!nd->path.dentry))
+               printk(KERN_ERR "pathname =3D %s\n", nd->name->name);
        while (*name=3D=3D'/')
                name++;
        if (!*name)

