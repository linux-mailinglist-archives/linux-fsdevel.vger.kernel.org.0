Return-Path: <linux-fsdevel+bounces-55900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA3B0FA6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E8E7ABBDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8841221F2F;
	Wed, 23 Jul 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8W0I84w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70A82C60;
	Wed, 23 Jul 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296177; cv=none; b=jjnwSLhFpQqKP9ngP7FQNEsLsUK+i2YnT+zZFAxfxheBQiFV8bmOUoF+Y8eXL9pgQtMHtKjiWn29ypbH6ev+X0PCNazrZfqv/H0MBXCA8KfoPLrTJdDpbmIHsfvMJuVKpLKOW/u+ih8Zmgzykd3yLz+sDePdJWCVuBXq+O1HApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296177; c=relaxed/simple;
	bh=+hrrbBh05niutr+3Uk0OIvszFhylUlqI1X7BO7FoodU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmN2oKgXORsH9xEaibSPxH78d3X9TU4z14ALuD1OvP9ktfOwAccKtg9cMOEjA83UEZPMj8I4tVdlzom+JEwPePyyg50FNDgUxqgXea1MHfRIGqfXeFrTTOKFeeMkAGrG7rzRAR9bnfBqLe8W586WXXFJMT7nYpwdg6+DKjnYCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8W0I84w; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab63f8fb91so2079061cf.0;
        Wed, 23 Jul 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753296174; x=1753900974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZEkdvyrNvf3uivlL8jNNyzaPuqLEPXHJb9U3qGdJAE=;
        b=j8W0I84w2Q17/3OiATOYRHXw3LQtkjCM4k24pFRRO730s0af7Wd5xalm/BVfzo/thD
         NOrgAklxdM/8DevYg5pll23cOyaNpMMApGhLCOjEUTmFpIx2YD7c74S8ghnu+hbsZYZ5
         JBbxkjhzyD8uB/e1xksrqJByQrBlohuFaVbPoXEr2Jwq50411C/YwY8HM6wMMujXNEyW
         GtDcxKPLNLKp+w9Z/m7rBeRVwzLVbYXXALteUxtUyN6FC77J111oDkNx/Zn2bQ1r8Jnb
         xeEJ+675kKe5O7ZQMOhV/DLUSGSJhLDYbQFk8VX/0GC6PMcRl6cGLNI6HZnFlRSQgHch
         fM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296174; x=1753900974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZEkdvyrNvf3uivlL8jNNyzaPuqLEPXHJb9U3qGdJAE=;
        b=tJl/rwM/q6X9qqnORwxiCtWgbg+gBv8m1lLpWPS1SP6GXbDDcJqv/xvAxViwYewovN
         ixG+Ux58Q1Bav7DnPDN86DToieJIN0PZ8tJ79zBL0aQFOWMgnX8EvTptzvKuLtsYap0r
         2Og/3uTKP8shmLcqvACI5LvybSKAFNnSmjDiZBCZ8avluHuUy8m+9cpQlBmoH48VTt4/
         XGzr+XvDbTEAHaqpIpaMQooqd3a4r4yp18FiL/wlfbJQX8u8ss2EbtzvmCHCqhNQgde5
         uquOtN3Xh5WTp+8J6DovWPOsNyYDUfLSzb4DxLVSWI99Ti9vUJHckp6eU7HX7xY+5odt
         DCkw==
X-Forwarded-Encrypted: i=1; AJvYcCV5QMtqSAqldNEaHZmUI/Y4vvUU9Myjpx3EyLd+1wEX6dhhzTTXAdu2INUNGbfoO8VgBbvZFogo50a05Mis@vger.kernel.org, AJvYcCVxtWvwzOfKdIgbrCntyRYHAMfOdc7TFWiIGEd7AV8scxIAdmtYrmn/fbBzymG8h/oMBOpZ0aoiThxQ@vger.kernel.org, AJvYcCXcmc+5ho+gbq4m3NEHLgJXJipwfwYLZZCtiAa7yES1jprVTpIZFBgqSQh1Yll/8OumQvzxd8XjWu48UeEE@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaNO+QMciWieQsDSuloZyy1SfIcszvJHtkcVkMAlNCxO1ovd5
	A8QYnyfhn2H9ZAOrjofMpCqG3u/TI5MZZYYe+6q1wx/8PgXOwP/fRDMtCzbtz1Y2q8g0HKNbdjP
	RJhLKHok8h866Kzap0i4UfzTAIsXlWPYNzcI2zgY=
X-Gm-Gg: ASbGnctIq44wzcxAwEwXyr2Bi2sNZODVp+PCosxYABcbZo6rT3pJqdGDvkAeVfPmdCX
	qaPAKAIQdToWqAr5auE1MfhuIUtENNNDLnin+3+yz9xjwqOrBqo3MX/ahWjanlemmHr1uBUS0Xg
	klDjX0oK3TBnfk+thky5Ab3n64zaf8ub3ldkL/DKPEOqZwWTzCac8X05CoAydUE6hXbxQ4NjJPf
	hFzv/I=
X-Google-Smtp-Source: AGHT+IGO7cbVDS21n3Qk88Ct5kAOPIiuVqMX2UidUg7DAriYwXvNqbv8HJfRWnbNGiz7dV8bE3thfN4BQRzFDUCNIPY=
X-Received: by 2002:a05:622a:1485:b0:4ab:37bd:5aa5 with SMTP id
 d75a77b69052e-4ae6df89ae3mr55794021cf.44.1753296174267; Wed, 23 Jul 2025
 11:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs>
In-Reply-To: <20250723144637.GW2672070@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 11:42:42 -0700
X-Gm-Features: Ac12FXznZ36tjQP__ZBzdOw_HvGQVb_DpY-StSaXMQ3PPkk_2TUI2pMhk5gnmcs
Message-ID: <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, linux-xfs@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> [cc Joanne]
>
> On Wed, Jul 23, 2025 at 05:14:28PM +0530, Naresh Kamboju wrote:
> > Regressions found while running LTP msync04 tests on qemu-arm64 running
> > Linux next-20250721, next-20250722 and next-20250723 with 16K and 64K
> > page size enabled builds.
> >
> > CONFIG_ARM64_64K_PAGES=3Dy ( kernel warning as below )
> > CONFIG_ARM64_16K_PAGES=3Dy ( kernel warning as below )
> >
> > No warning noticed with 4K page size.
> > CONFIG_ARM64_4K_PAGES=3Dy works as expected
>
> You might want to cc Joanne since she's been working on large folio
> support in fuse.
>
> > First seen on the tag next-20250721.
> > Good: next-20250718
> > Bad:  next-20250721 to next-20250723

Thanks for the report. Is there a link to the script that mounts the
fuse server for these tests? I'm curious whether this was mounted as a
fuseblk filesystem.

> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? Yes
> >
> > Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
> > fuse file.c at fuse_iomap_writeback_range
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Test log
> > ------------[ cut here ]------------
> > [  343.828105] WARNING: fs/fuse/file.c:2146 at
> > fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
>
>         WARN_ON_ONCE(len & (PAGE_SIZE - 1));
>
> /me speculates that this might be triggered by an attempt to write back
> some 4k fsblock within a 16/64k base page?
>

I think this can happen on 4k base pages as well actually. On the
iomap side, the length passed is always block-aligned and in fuse, we
set blkbits to be PAGE_SHIFT so theoretically block-aligned is always
page-aligned, but I missed that if it's a "fuseblk" filesystem, that
isn't true and the blocksize is initialized to a default size of 512
or whatever block size is passed in when it's mounted.

I'll send out a patch to remove this line. It doesn't make any
difference for fuse_iomap_writeback_range() logic whether len is
page-aligned or not; I had added it as a sanity-check against sketchy
ranges.

Also, I just noticed that apparently the blocksize can change
dynamically for an inode in fuse through getattr replies from the
server (see fuse_change_attributes_common()). This is a problem since
the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
think we will have to cache the inode blkbits in the iomap_folio_state
struct unfortunately :( I'll think about this some more and send out a
patch for this.


Thanks,
Joanne

> --D
>
> > [  343.830969] Modules linked in: btrfs blake2b_generic xor xor_neon
> > raid6_pq zstd_compress sm3_ce sha3_ce drm fuse backlight ip_tables
> > x_tables
> > [  343.833830] CPU: 0 UID: 0 PID: 4190 Comm: msync04 Not tainted
> > 6.16.0-rc7-next-20250723 #1 PREEMPT
> > [  343.834736] Hardware name: linux,dummy-virt (DT)
> > [  343.835788] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BT=
YPE=3D--)
> > [  343.836455] pc : fuse_iomap_writeback_range+0x478/0x558 fuse
> > [  343.837294] lr : iomap_writeback_folio (fs/iomap/buffered-io.c:1586
> > fs/iomap/buffered-io.c:1710)
> > [  343.838178] sp : ffff80008b26f8d0
> > [  343.838668] x29: ffff80008b26f8d0 x28: fff00000e7f8c800 x27: 0000000=
000000000
> > [  343.839391] x26: fff00000d4b30000 x25: 0000000000000000 x24: 0000000=
000000000
> > [  343.840305] x23: 0000000000000000 x22: fffffc1fc0334200 x21: 0000000=
000001000
> > [  343.840928] x20: ffff80008b26fa00 x19: 0000000000000000 x18: 0000000=
000000000
> > [  343.841782] x17: 0000000000000000 x16: ffffb8d3b90c67c8 x15: 0000000=
000000000
> > [  343.842565] x14: ffffb8d3ba91e340 x13: 0000ffff8ff3ffff x12: 0000000=
000000000
> > [  343.843002] x11: 1ffe000004b74a21 x10: fff0000025ba510c x9 : ffffb8d=
3b90c6308
> > [  343.843962] x8 : ffff80008b26f788 x7 : ffffb8d365830b90 x6 : ffffb8d=
3bb6c9000
> > [  343.844718] x5 : 0000000000000000 x4 : 000000000000000a x3 : 0000000=
000001000
> > [  343.845333] x2 : fff00000c0b5ecc0 x1 : 000000000000ffff x0 : 0bfffe0=
00000400b
> > [  343.846323] Call trace:
> > [  343.846767] fuse_iomap_writeback_range+0x478/0x558 fuse (P)
> > [  343.847288] iomap_writeback_folio (fs/iomap/buffered-io.c:1586
> > fs/iomap/buffered-io.c:1710)
> > [  343.847930] iomap_writepages (fs/iomap/buffered-io.c:1762)
> > [  343.848494] fuse_writepages+0xa0/0xe8 fuse
> > [  343.849112] do_writepages (mm/page-writeback.c:2634)
> > [  343.849614] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:37=
6)
> > [  343.850202] __filemap_fdatawrite_range (mm/filemap.c:420)
> > [  343.850791] file_write_and_wait_range (mm/filemap.c:794)
> > [  343.851108] fuse_fsync+0x6c/0x138 fuse
> > [  343.851688] vfs_fsync_range (fs/sync.c:188)
> > [  343.852002] __arm64_sys_msync (mm/msync.c:96 mm/msync.c:32 mm/msync.=
c:32)
> > [  343.852197] invoke_syscall.constprop.0
> > (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
> > [  343.852914] do_el0_svc (include/linux/thread_info.h:135
> > (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
> > arch/arm64/kernel/syscall.c:151 (discriminator 2))
> > [  343.853389] el0_svc (arch/arm64/include/asm/irqflags.h:82
> > (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> > 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> > arch/arm64/kernel/entry-common.c:169 (discriminator 1)
> > arch/arm64/kernel/entry-common.c:182 (discriminator 1)
> > arch/arm64/kernel/entry-common.c:880 (discriminator 1))
> > [  343.853829] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:8=
99)
> > [  343.854350] el0t_64_sync (arch/arm64/kernel/entry.S:596)
> > [  343.854652] ---[ end trace 0000000000000000 ]---
> >
> >
> >
> > ## Source
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/ne=
xt/linux-next.git
> > * Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/n=
ext-20250723/
> > * Git sha: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> > * Git describe: 6.16.0-rc7-next-20250723
> > * kernel version: next-20250723
> > * Architectures: arm64
> > * Toolchains: gcc-13
> > * Kconfigs: defconfig + CONFIG_ARM64_64K_PAGES=3Dy
> > * Kconfigs: defconfig + CONFIG_ARM64_16K_PAGES=3Dy
> >
> > ## Test
> > * Test log 1: https://qa-reports.linaro.org/api/testruns/29227309/log_f=
ile/
> > * Test log 2: https://qa-reports.linaro.org/api/testruns/29227074/log_f=
ile/
> > * Test run: https://regressions.linaro.org/lkft/linux-next-master/next-=
20250723/testruns/1713367/
> > * Test history:
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-2025072=
3/testrun/29227309/suite/log-parser-test/test/exception-warning-fsfusefile-=
at-fuse_iomap_writeback_range/history/
> > * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft=
/tests/30G3hpJVVdXkZKnB15v1qoQOL03
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30=
G3dvSFyHHQ3E8CvKH7tjU98I6/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/30G3dvSFyHHQ3E8C=
vKH7tjU98I6/config
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

