Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0127B7841
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 08:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbjJDG6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbjJDG6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:58:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23648AF;
        Tue,  3 Oct 2023 23:58:15 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ae2ec1a222so1160245b6e.2;
        Tue, 03 Oct 2023 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696402694; x=1697007494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXwmR+/3Lhqmxga+S8/sE/k6mhMWvQB9Ir68rrB9KbI=;
        b=fcV6NPSpwgTUxwOq4K3l2Y97PI0lILIkzDTLERWsZ5BYR8JxKnKyThMXSqj4ZOl9B2
         J55Q8xZbWGACNgTS0FMtcvk7X9C19JwAHCEXUyXA8LqSaKQSNj5ZfC7pKHzmSPAj+9Fu
         q1Zl11CzcTH9LkA0izhWk07ElaO5DiNgS/yNvK2plGVwyoTNaBHEnpsH3J066ozC1me/
         +ybnCVv45caqMUASmymRgPOomV73FNEkunXjM+xeNBbqov1Fz5c7qdLh4GCWFnU801CM
         PyTCEoBJgLGOrNKdjxVNqQsncdMMLC13pNebC17Sf3HF3shihiaelEzxt/D/H0lAjVXi
         bWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402694; x=1697007494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXwmR+/3Lhqmxga+S8/sE/k6mhMWvQB9Ir68rrB9KbI=;
        b=jCc1uMhNBEPRNrRCOZOo2wtnWkTgCS522ptNEj+qt7ofXcGuyJTJlF7ki1iiatulUj
         DOwJlojdIBe3CF5Rma3PkukZ/Z+PNTYoFdnjj0aJLczsphZ68fHvK1HsRBViTzaBLD5s
         w5Wnbl2u7d6baoRONs0v9xwzmTchmUzMSy5axKiW4Iwu++ljYf3+MIQxeBGoDu0AjrXF
         sBQWrMlk/F0nitSSwDW8OMJzwA7qtO9PaoqI2eCsOiI+26Esfuq3akeu4oSlCFw+udTK
         ws4Pkb2YkP/h6e9g3hL5QVIAVYS0E6aCzwVQ6A5v231Vf0lT9kUgzsS5EgVUCjt02Kld
         t3mA==
X-Gm-Message-State: AOJu0YwGrSNJ/NFqH1QJ3Mpq/5dor5e4/rqJuY0TdyKUCK483gH74Jq+
        /yapNOXfNea5BbSJIrVbRmw=
X-Google-Smtp-Source: AGHT+IGqsgWDkSM7doaaePtiYpnvMHIiKZHVQq+DdlenyLQukhdNxnwcflE6mDXiyk6HB9DH39hqoQ==
X-Received: by 2002:a05:6808:1506:b0:3ae:5e0e:1667 with SMTP id u6-20020a056808150600b003ae5e0e1667mr2115336oiw.43.1696402694356;
        Tue, 03 Oct 2023 23:58:14 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bt8-20020a632908000000b0056b27af8715sm2466712pgb.43.2023.10.03.23.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:58:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E8AC981A7EC4; Wed,  4 Oct 2023 13:58:00 +0700 (WIB)
Date:   Wed, 4 Oct 2023 13:58:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>,
        Linux ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.com>, Baokun Li <libaokun1@huawei.com>
Subject: Re: probable quota bug introduced in 6.6-rc1
Message-ID: <ZR0M-CFmh567Ogyg@debian.me>
References: <ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VKPvnRvQ0Pv/ixYX"
Content-Disposition: inline
In-Reply-To: <ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--VKPvnRvQ0Pv/ixYX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 08:11:11PM -0400, Eric Whitney wrote:
> When run on my test hardware, generic/270 triggers hung task timeouts when
> run on a 6.6-rc1 (or -rc2, -rc3, -rc4) kernel with kvm-xfstests using the
> nojournal test scenario.  The test always passes, but about 60% of the ti=
me
> the running time of the test increases by an order of magnitude or more a=
nd
> one or more of the hung task timeout warnings included below can be found=
 in
> the log.
>=20
> This does not reproduce on 6.5.  Bisection leads to this patch:
>=20
> dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu sho=
uld
> provide")

Can you revert the culprit to see if it helps?

>=20
> >From the log:
>=20
> generic/270 306s ...  [20:08:45][  311.322318] run fstests generic/270 at=
 2023-10-03 20:08:45
> [  311.579641] EXT4-fs (vdc): mounted filesystem d0e542a0-3342-4d43-aa1f-=
c918cc92aafa r/w without journal. Quota mode: writeback.
> [  311.587978] EXT4-fs (vdc): re-mounted d0e542a0-3342-4d43-aa1f-c918cc92=
aafa ro. Quota mode: writeback.
> [  311.592725] EXT4-fs (vdc): re-mounted d0e542a0-3342-4d43-aa1f-c918cc92=
aafa r/w. Quota mode: writeback.
> [  335.491107] 270 (3092): drop_caches: 3
> [  491.167988] INFO: task quotaon:3450 blocked for more than 122 seconds.
> [  491.168334]       Not tainted 6.4.0+ #13
> [  491.168544] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  491.168936] task:quotaon         state:D stack:0     pid:3450  ppid:30=
92   flags:0x00004000
> [  491.169363] Call Trace:
> [  491.169503]  <TASK>
> [  491.169620]  __schedule+0x394/0xd40
> [  491.169813]  schedule+0x5d/0xd0
> [  491.169981]  schedule_timeout+0x1a7/0x1c0
> [  491.170191]  ? lock_release+0x139/0x280
> [  491.170395]  ? lock_acquire+0xb9/0x180
> [  491.170605]  ? do_raw_spin_unlock+0x4b/0xa0
> [  491.170837]  __wait_for_common+0xb6/0x1e0
> [  491.171046]  ? __pfx_schedule_timeout+0x10/0x10
> [  491.171324]  __flush_work+0x2da/0x430
> [  491.171517]  ? __pfx_wq_barrier_func+0x10/0x10
> [  491.171747]  ? 0xffffffff81000000
> [  491.171932]  dquot_disable+0x3e5/0x670
> [  491.172134]  ext4_quota_off+0x50/0x1a0
> [  491.172332]  __x64_sys_quotactl+0x87/0x1c0
> [  491.172545]  do_syscall_64+0x38/0x90
> [  491.172731]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  491.172990] RIP: 0033:0x7f3c7c79eada
> [  491.173176] RSP: 002b:00007ffed2ff4478 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000b3
> [  491.173558] RAX: ffffffffffffffda RBX: 000055886a3997d0 RCX: 00007f3c7=
c79eada
> [  491.173915] RDX: 0000000000000000 RSI: 000055886bf43de0 RDI: 000000008=
0000301
> [  491.174271] RBP: 000055886bf43de0 R08: 0000000000000001 R09: 000000000=
0000002
> [  491.174657] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000002
> [  491.175014] R13: 000055886bf43ea0 R14: 0000000000000001 R15: 000000000=
0000000
> [  491.175373]  </TASK>
> [  491.175491]=20
> [  491.175491] Showing all locks held in the system:
> [  491.176706] 1 lock held by rcu_tasks_kthre/12:
> [  491.178126]  #0: ffffffff82763970 (rcu_tasks.tasks_gp_mutex){....}-{3:=
3}, at: rcu_tasks_one_gp+0x30/0x3f0
> [  491.180955] 1 lock held by rcu_tasks_rude_/13:
> [  491.182394]  #0: ffffffff827636f0 (rcu_tasks_rude.tasks_gp_mutex){....=
}-{3:3}, at: rcu_tasks_one_gp+0x30/0x3f0
> [  491.194388] 1 lock held by khungtaskd/26:
> [  491.196153]  #0: ffffffff82764020 (rcu_read_lock){....}-{1:2}, at: deb=
ug_show_all_locks+0xe/0x110
> [  491.199676] 2 locks held by kworker/u4:4/59:
> [  491.200722]  #0: ffff88800385cd38 ((wq_completion)events_unbound){....=
}-{0:0}, at: process_one_work+0x1f6/0x550
> [  491.201600]  #1: ffffc90000513e80 ((quota_release_work).work){....}-{0=
:0}, at: process_one_work+0x1f6/0x550
> [  491.202746] 1 lock held by quotaon/3450:
> [  491.203184]  #0: ffff88800afd60e0 (&type->s_umount_key#33){....}-{3:3}=
, at: user_get_super+0xd3/0x100
> [  491.204217]=20
> [  491.204373] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20

Anyway, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: dabc8b20756601
#regzbot title: dqput() fix causes kvm-xfstests nojournal test time longer

--=20
An old man doll... just what I always wanted! - Clara

--VKPvnRvQ0Pv/ixYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZR0M8wAKCRD2uYlJVVFO
o0YAAQCXj/x0ivIXS36slQzBtYpiBrScim99oNIsooNjGAJE+QD/Y0Q3eCfSCDAr
4Ox1OjcO2vxK3v/Otsa9cVU7kfNarg4=
=K0YG
-----END PGP SIGNATURE-----

--VKPvnRvQ0Pv/ixYX--
