Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677C74EDCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKMMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGKMMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19B1720
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689077475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jciyvh7bPAJKrnb358k+MOZYCgue2kVbXpRfHdO7VwM=;
        b=U53MkUpGZxUFoV3g190vIj1bNiDfyviBkGMPotSNZdNjj15OSTKHV+w90Hcbwz0fKxdRdT
        H+Dd4E0rpXN4+ypMUZAlhjbaaGiBmm9oJUSUjA4/BSaZtNhi2uBiCmqaTCCnepWMCv0JXf
        pjXLxDORs5VqZUg0fZF9TfHrpL7Ad4M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-8WB8DNSZP4ajrQIethBppg-1; Tue, 11 Jul 2023 08:11:11 -0400
X-MC-Unique: 8WB8DNSZP4ajrQIethBppg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E72A1C47661;
        Tue, 11 Jul 2023 12:11:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA8111401C2E;
        Tue, 11 Jul 2023 12:10:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, James.Bottomley@HansenPartnership.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        axboe@kernel.dk, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christian@brauner.io,
        dalias@libc.org, davem@davemloft.net, deepa.kernel@gmail.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        firoz.khan@linaro.org, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, palmer@sifive.com, paul.burton@mips.com,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 5/5] selftests: add fchmodat4(2) selftest
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
        <cover.1689074739.git.legion@kernel.org>
        <c3606ec38227d921fa8a3e11613ffdb2f3ea7636.1689074739.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 14:10:58 +0200
In-Reply-To: <c3606ec38227d921fa8a3e11613ffdb2f3ea7636.1689074739.git.legion@kernel.org>
        (Alexey Gladkov's message of "Tue, 11 Jul 2023 13:25:46 +0200")
Message-ID: <87pm4ybqct.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Alexey Gladkov:

> The test marks as skipped if a syscall with the AT_SYMLINK_NOFOLLOW flag
> fails. This is because not all filesystems support changing the mode
> bits of symlinks properly. These filesystems return an error but change
> the mode bits:
>
> newfstatat(4, "regfile", {st_mode=3DS_IFREG|0640, st_size=3D0, ...}, AT_S=
YMLINK_NOFOLLOW) =3D 0
> newfstatat(4, "symlink", {st_mode=3DS_IFLNK|0777, st_size=3D7, ...}, AT_S=
YMLINK_NOFOLLOW) =3D 0
> syscall_0x1c3(0x4, 0x55fa1f244396, 0x180, 0x100, 0x55fa1f24438e, 0x34) =
=3D -1 EOPNOTSUPP (Operation not supported)
> newfstatat(4, "regfile", {st_mode=3DS_IFREG|0640, st_size=3D0, ...}, AT_S=
YMLINK_NOFOLLOW) =3D 0
>
> This happens with btrfs and xfs:
>
>  $ /kernel/tools/testing/selftests/fchmodat4/fchmodat4_test
>  TAP version 13
>  1..1
>  ok 1 # SKIP fchmodat4(symlink)
>  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>
>  $ stat /tmp/ksft-fchmodat4.*/symlink
>    File: /tmp/ksft-fchmodat4.3NCqlE/symlink -> regfile
>    Size: 7               Blocks: 0          IO Block: 4096   symbolic link
>  Device: 7,0     Inode: 133         Links: 1
>  Access: (0600/lrw-------)  Uid: (    0/    root)   Gid: (    0/    root)
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

This looks like a bug in those file systems?

As an extra test, =E2=80=9Cecho 3 > /proc/sys/vm/drop_caches=E2=80=9D somet=
imes has
strange effects in such cases because the bits are not actually stored
on disk, only in the dentry cache.

Thanks,
Florian

