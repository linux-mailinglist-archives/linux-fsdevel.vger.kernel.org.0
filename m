Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDCC70B52F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjEVGjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEVGje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:39:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9AAB;
        Sun, 21 May 2023 23:39:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae50da739dso36512405ad.1;
        Sun, 21 May 2023 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684737573; x=1687329573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBmxCmNG5TbOL9hECYtzQYsyAMgW+U7Lbu2rwI+Qn8Q=;
        b=dyL7bFmf44VLQgc5jicE1PgJG8sMUKwO0jb+3iUXQiqKHq3sTHcWxSzWKGxmj+L6A2
         QVIT3zNPSeK1aZ/9i6+d/3/NPTrOcoGKXr4XMAeDIXZ74VFL/zEGyJ0tu8sGjVtXPSDG
         AByYNDncFsBJV2xrcmsLRjKQ/JIX4VHFFFeIiARhiqW6ImeWeMCvdRlTcs18V65qtzYW
         RQUwymWXiPlR9HB/FhfMiKtOo2iYIDKkAL8v7A01ysewmDhbEd9Alnq14/17wJ2r0COo
         oPCH47V4qBwWr2CfGbkO07taQr9EyxBTx2KR0EzQVSpKyiqamwQWinbl3QgJ6Dj0ytDt
         Bxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737573; x=1687329573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBmxCmNG5TbOL9hECYtzQYsyAMgW+U7Lbu2rwI+Qn8Q=;
        b=lNZAeHXCPRQwf8zb+0rWLEvVSbpQR5ab3vX1+0fQx/CYCCvv3gjGFYM7MhX93cm5SF
         5+E8nQkVVscrcFtkO3933rxkUK6szza5TWjFl1xDHlL1IUjx8a/JuEW04B0u2cOyeG/O
         ZUfs69OIJ1+CtGXAgk390nqE4btnMuyUjBdJKKbPUJBTIhnjTxtCQATtmMqjggUmTCQV
         HocM32I0z+FGog+mUvArMSHfi4YFIN5bvxlBCZEgsPmcCorQwTNpZxLHgac2Coc11Glr
         HnZODNQr3gvEZqsOr+j8+KzDTdYiet4YOF80yDxuIHTZ5yznspU3jOq/u41LOpR4i8ZW
         e8EA==
X-Gm-Message-State: AC+VfDyJ33/AtUpVXMSLCJw/hgazwnw1g3XXN+GbMM3JPn5Z2of9qUxf
        2dtzDpQYKaCYhfeAiqk7PJU=
X-Google-Smtp-Source: ACHHUZ6tJMvJggE8Q+oRsvOGPrINSkRCKhnSVHnpGKNhNUrLijJCzQv9s71jBG83FJ9Ei6iDIvK3jQ==
X-Received: by 2002:a17:903:234a:b0:1ac:85b0:1bdb with SMTP id c10-20020a170903234a00b001ac85b01bdbmr14354045plh.55.1684737572826;
        Sun, 21 May 2023 23:39:32 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001ae8b4dc497sm4011947pla.44.2023.05.21.23.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:39:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 01E97106ABB; Mon, 22 May 2023 13:39:27 +0700 (WIB)
Date:   Mon, 22 May 2023 13:39:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Pengfei Xu <pengfei.xu@intel.com>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        heng.su@intel.com, dchinner@redhat.com, lkp@intel.com,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel NULL
 pointer dereference in xfs_extent_free_diff_items in v6.4-rc3
Message-ID: <ZGsOH5D5vLTLWzoB@debian.me>
References: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iEMK2826TNLNRJkI"
Content-Disposition: inline
In-Reply-To: <ZGrOYDZf+k0i4jyM@xpf.sh.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--iEMK2826TNLNRJkI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 10:07:28AM +0800, Pengfei Xu wrote:
> Hi Darrick,
>=20
> Greeting!
> There is BUG: unable to handle kernel NULL pointer dereference in
> xfs_extent_free_diff_items in v6.4-rc3:
>=20
> Above issue could be reproduced in v6.4-rc3 and v6.4-rc2 kernel in guest.
>=20
> Bisected this issue between v6.4-rc2 and v5.11, found the problem commit =
is:
> "
> f6b384631e1e xfs: give xfs_extfree_intent its own perag reference
> "
>=20
> report0, repro.stat and so on detailed info is link: https://github.com/x=
upengfe/syzkaller_logs/tree/main/230521_043336_xfs_extent_free_diff_items
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blo=
b/main/230521_043336_xfs_extent_free_diff_items/repro.c
> Syzkaller reproduced prog: https://github.com/xupengfe/syzkaller_logs/blo=
b/main/230521_043336_xfs_extent_free_diff_items/repro.prog
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_0433=
36_xfs_extent_free_diff_items/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_=
043336_xfs_extent_free_diff_items/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230521_=
043336_xfs_extent_free_diff_items/v6.4-rc3_reproduce_dmesg.log
>=20
> v6.4-rc3 reproduced info:
> "
> [   91.419498] loop0: detected capacity change from 0 to 65536
> [   91.420095] XFS: attr2 mount option is deprecated.
> [   91.420500] XFS: ikeep mount option is deprecated.
> [   91.422379] XFS (loop0): Deprecated V4 format (crc=3D0) will not be su=
pported after September 2030.
> [   91.423468] XFS (loop0): Mounting V4 Filesystem d28317a9-9e04-4f2a-be2=
7-e55b4c413ff6
> [   91.428169] XFS (loop0): Ending clean mount
> [   91.429120] XFS (loop0): Quotacheck needed: Please wait.
> [   91.432182] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [   91.432770] #PF: supervisor read access in kernel mode
> [   91.433216] #PF: error_code(0x0000) - not-present page
> [   91.433640] PGD 0 P4D 0=20
> [   91.433864] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   91.434232] CPU: 0 PID: 33 Comm: kworker/u4:2 Not tainted 6.4.0-rc3-kv=
m #2
> [   91.434793] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 0.0.0 02/06/2015
> [   91.435445] Workqueue: xfs_iwalk-393 xfs_pwork_work
> [   91.435855] RIP: 0010:xfs_extent_free_diff_items+0x27/0x40
> [   91.436312] Code: 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 5=
4 49 89 f4 53 48 89 d3 e8 05 73 7d ff 49 8b 44 24 28 48 8b 53 28 5b 41 5c <=
8b> 40 08 5d 2b 42 08 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
> [   91.437812] RSP: 0000:ffffc9000012b8c0 EFLAGS: 00010246
> [   91.438250] RAX: 0000000000000000 RBX: ffff8880015826c8 RCX: ffffffff8=
1d71e41
> [   91.438840] RDX: 0000000000000000 RSI: ffff888001ca4800 RDI: 000000000=
0000002
> [   91.439430] RBP: ffffc9000012b8c0 R08: ffffc9000012b8e0 R09: 000000000=
0000000
> [   91.440019] R10: ffff88800613f290 R11: ffffffff83e426c0 R12: ffff88800=
1582230
> [   91.440610] R13: ffff888001582428 R14: ffffffff81b042c0 R15: ffffc9000=
012b908
> [   91.441202] FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlG=
S:0000000000000000
> [   91.441864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   91.442343] CR2: 0000000000000008 CR3: 000000000ed22006 CR4: 000000000=
0770ef0
> [   91.442941] PKRU: 55555554
> [   91.443178] Call Trace:
> [   91.443394]  <TASK>
> [   91.443585]  list_sort+0xb8/0x3a0
> [   91.443885]  xfs_extent_free_create_intent+0xb6/0xc0
> [   91.444312]  xfs_defer_create_intents+0xc3/0x220
> [   91.444711]  ? write_comp_data+0x2f/0x90
> [   91.445056]  xfs_defer_finish_noroll+0x9e/0xbc0
> [   91.445449]  ? list_sort+0x344/0x3a0
> [   91.445768]  __xfs_trans_commit+0x4be/0x630
> [   91.446135]  xfs_trans_commit+0x20/0x30
> [   91.446473]  xfs_dquot_disk_alloc+0x45d/0x4e0
> [   91.446860]  xfs_qm_dqread+0x2f7/0x310
> [   91.447192]  xfs_qm_dqget+0xd5/0x300
> [   91.447506]  xfs_qm_quotacheck_dqadjust+0x5a/0x230
> [   91.447921]  xfs_qm_dqusage_adjust+0x249/0x300
> [   91.448313]  xfs_iwalk_ag_recs+0x1bd/0x2e0
> [   91.448671]  xfs_iwalk_run_callbacks+0xc3/0x1c0
> [   91.449071]  xfs_iwalk_ag+0x32e/0x3f0
> [   91.449398]  xfs_iwalk_ag_work+0xbe/0xf0
> [   91.449744]  xfs_pwork_work+0x2c/0xc0
> [   91.450064]  process_one_work+0x3b1/0x860
> [   91.450416]  worker_thread+0x52/0x660
> [   91.450739]  ? __pfx_worker_thread+0x10/0x10
> [   91.451113]  kthread+0x16d/0x1c0
> [   91.451406]  ? __pfx_kthread+0x10/0x10
> [   91.451740]  ret_from_fork+0x29/0x50
> [   91.452064]  </TASK>
> [   91.452261] Modules linked in:
> [   91.452530] CR2: 0000000000000008
> [   91.452819] ---[ end trace 0000000000000000 ]---
> [   91.487979] RIP: 0010:xfs_extent_free_diff_items+0x27/0x40
> [   91.488463] Code: 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 5=
4 49 89 f4 53 48 89 d3 e8 05 73 7d ff 49 8b 44 24 28 48 8b 53 28 5b 41 5c <=
8b> 40 08 5d 2b 42 08 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
> [   91.490021] RSP: 0000:ffffc9000012b8c0 EFLAGS: 00010246
> [   91.490472] RAX: 0000000000000000 RBX: ffff8880015826c8 RCX: ffffffff8=
1d71e41
> [   91.491080] RDX: 0000000000000000 RSI: ffff888001ca4800 RDI: 000000000=
0000002
> [   91.491689] RBP: ffffc9000012b8c0 R08: ffffc9000012b8e0 R09: 000000000=
0000000
> [   91.492298] R10: ffff88800613f290 R11: ffffffff83e426c0 R12: ffff88800=
1582230
> [   91.492909] R13: ffff888001582428 R14: ffffffff81b042c0 R15: ffffc9000=
012b908
> [   91.493516] FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlG=
S:0000000000000000
> [   91.494199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   91.494695] CR2: 0000000000000008 CR3: 000000000ed22006 CR4: 000000000=
0770ef0
> [   91.495306] PKRU: 55555554
> [   91.495549] note: kworker/u4:2[33] exited with irqs disabled
> "
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: f6b384631e1e34
#regzbot title: unable to handle kernel NULL pointer dereference in xfs_ext=
ent_free_diff_items (due to xfs_extfree_intent perag change)
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217470

--=20
An old man doll... just what I always wanted! - Clara

--iEMK2826TNLNRJkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGsOGQAKCRD2uYlJVVFO
oysxAP9Q02Vq7ukcGo+qOuDS2nk6fTEJPCYz5pNezVhr6n3UXAD/UwGhmiex7pif
Jn5+120XMJF31Y6pjksERo62Wb8N5Ac=
=pj27
-----END PGP SIGNATURE-----

--iEMK2826TNLNRJkI--
