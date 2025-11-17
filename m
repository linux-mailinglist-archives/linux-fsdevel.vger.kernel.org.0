Return-Path: <linux-fsdevel+bounces-68807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF5C668C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 00:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7830829792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2E30C60A;
	Mon, 17 Nov 2025 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gVt91z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045921E1E12
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421975; cv=none; b=IiP/mqHVOe9T/FaonJwqbDxVdEhgBGxT4O2JZeNOK5A2+E0Ra7/5F3lVvTkopEcFQPwqA7lXbFOXkC0VvDrmsPvc/LccU9dxhxaqapf9pLAapPwM9HEcMfZj3pzbHa8wG3vi4SPLMr3LL8jYbqqqlfIy6lRjrLiKOE36PXTBHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421975; c=relaxed/simple;
	bh=f0suFNj1TMueMd895zFgMpH7h4U8a6hdnbBs3C3LeDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsiNx96JY2KNYdcpC2lCG43RjqRIo7VyEmiVeLehWXJUOC8ylzmPANNv60YGIius4gxvBacHImveq8v61M/XgT2z39I/uuufzv5sX8OVUF9UALx+ROeypZ4AE1k7MRvSqMTBznz0hCfOqNJ/dQONxFJTX9EQcyXYSyYR7gzWvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gVt91z; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda6a8cc12so47076811cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763421973; x=1764026773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX6bRMh1USWJ4AZBp+j1tHX0n+lt9+VKpJ+mvPrGbdE=;
        b=Q+gVt91zKgF2g4Ofq7rJCAhjio8AidBE2jN9H0gb6WcN7Xftkey4/8RgvegBM7hWIO
         CByZ3adm/OaVJ0XVG1fVJoEEsM+YDGaRgUgOhC90lop6hs0Zy0O/q3zivUkX9PVHNadq
         Xro24f5vwMojTh6g2oVciu16K9O9YoxHCeHVyfA+WvyF4iujPHHb+BxNyHTGch/ek9RQ
         WlcxuOzWqrzgDcwK0C+6TjO85DLsxmFRmYU31CvdHQXFdvtGmBBVMznPV3dKa2durIJH
         0bwCDDZlHoDerfNxn4ly5tLpaVkf3bgEMQBX7EIBtuiKm/Sy9H3NJK5lF8tMn+oD+6m9
         rtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763421973; x=1764026773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qX6bRMh1USWJ4AZBp+j1tHX0n+lt9+VKpJ+mvPrGbdE=;
        b=MATD6Vf9u9Z8U3Lj6lex38wDtP8eUxbNA1Ob213MQQTE0gRYsrhib7zHsuKd9j8nnW
         TH7vsWTplXs1XBio4mj4221BFnwDY55D6Ogt+NkvegxoH9eAktiHO7I+23sGdkjyW2GR
         9zgreovcXBbQZJ9P+HO1EZ359qX7gdsY39nPDkhxVedwdPCt8xoNk6E/zXwgJ85a6V8O
         4+kc/K+axKleyjjc7C8rrQ2z/YWZToyPQgJ85un2THLLNcXCp20655QqdT/zSRKXVTs0
         Zu8E+fO5l9DRhz5vkvEV+UsIowrXif6Lug3n2+Gb5fZARmNGeZY1iMEd75H/S+ZXwHS+
         PeKA==
X-Forwarded-Encrypted: i=1; AJvYcCXzQTwImTTJSazQrORVR10kOCZdBhssWefewGTD07eyl5udBgV0hM/JCa4MoZTSkJWasL5GsknYnbOwQqO1@vger.kernel.org
X-Gm-Message-State: AOJu0YxiLt+QozWBEdXDZGL2/pXovRhr0e8HSVo7WzziNd/aVDWpx2c5
	HO8Ad/LP2yJM+oPjo91gjllkRS09N/AcwAhwTM26vctC8bdIbu/VYwIr+uUAfrC2ttdd+vE2n0n
	d7Fmq79iiB/RpcpMG0z90BnNn2y4lagM=
X-Gm-Gg: ASbGncsBvZykBFtIbD2u/FB46Ej5g4n7Uec6FikrDwinimUQcA/NAXsHjl41F694n5f
	5mKYq4mzeaqu0kkbYZ31q/2JN6rc3mSFDWrDduFiJ27YC+EucGaFxRDWdBCuyOp9lpPiRgUpDs3
	6c7wVA021aiMSMKG6x6KLjxurz54wjxZfsStsWlTr3vQYZTDOfWt0Hqt7ZQCe/tr1qB0ZB+fzS+
	apsHGK4MqvauhsR/7/NbLItTALayYYEe3Hji1njUR79Y2QurhQLasc8wD2Cm5r8XynLLQ==
X-Google-Smtp-Source: AGHT+IHwqUomjCBeiKO072Knq3JaJ5VTNNwXBCiZOaOgbdR884WHEtTu+PEN33o6+784ef3xSLpQwU4D6Fnqxn+C9C4=
X-Received: by 2002:a05:622a:15d2:b0:4e8:aa9d:f0d9 with SMTP id
 d75a77b69052e-4edf2130595mr174760651cf.38.1763421972718; Mon, 17 Nov 2025
 15:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-6-joannelkoong@gmail.com> <aRuJqxE3XRoLcWrz@casper.infradead.org>
In-Reply-To: <aRuJqxE3XRoLcWrz@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 17 Nov 2025 15:26:01 -0800
X-Gm-Features: AWmQ_blNbm1crrvE0g4eeB9LJqH3e2rmh8pB4_pAd1y7uKTJ4akKHmtAmBXWK3s
Message-ID: <CAJnrk1YO-vmd4eR_AodCN7Zp2J6WWryZ-zj-d92_QECSSUQGAQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] iomap: simplify ->read_folio_range() error
 handling for reads
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:46=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Nov 11, 2025 at 11:36:54AM -0800, Joanne Koong wrote:
> > Instead of requiring that the caller calls iomap_finish_folio_read()
> > even if the ->read_folio_range() callback returns an error, account for
> > this internally in iomap instead, which makes the interface simpler and
> > makes it match writeback's ->read_folio_range() error handling
> > expectations.
>
> Bisection of next-20251117 leads to this patch (commit
> f8eaf79406fe9415db0e7a5c175b50cb01265199)
>
> Here's the failure:
>
> generic/008       run fstests generic/008 at 2025-11-17 20:40:31
> page: refcount:5 mapcount:0 mapping:00000000101f858e index:0x4 pfn:0x12d4=
f8
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff8881120315c0
> aops:xfs_address_space_operations ino:83 dentry name(?):"008.2222"
> flags: 0x8000000000014069(locked|uptodate|lru|private|head|reclaim|zone=
=3D2)
> raw: 8000000000014069 ffffea0004b69f48 ffffea0004a0a508 ffff8881139d83f0
> raw: 0000000000000004 ffff8881070b4420 00000005ffffffff ffff8881120315c0
> head: 8000000000014069 ffffea0004b69f48 ffffea0004a0a508 ffff8881139d83f0
> head: 0000000000000004 ffff8881070b4420 00000005ffffffff ffff8881120315c0
> head: 8000000000000202 ffffea0004b53e01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
> page dumped because: VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio=
))
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1538!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 1 UID: 0 PID: 2607 Comm: xfs_io Not tainted 6.18.0-rc1-ktest-00033-g=
f8eaf79406fe #151 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:folio_end_read+0x68/0x70
> Code: 8e e9 04 00 0f 0b 48 8b 07 48 89 c2 48 c1 ea 03 a8 08 74 00 83 e2 0=
1 b8 09 00 00 00 74 c2 48 c7 c6 a0 6e 3e 82 e8 68 e9 04 00 <0f> 0b 90 0f 1f=
 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffff888112333870 EFLAGS: 00010286
> RAX: 000000000000004b RBX: ffffea0004b53e00 RCX: 0000000000000027
> RDX: ffff888179657c08 RSI: 0000000000000001 RDI: ffff888179657c00
> RBP: ffff888112333870 R08: 00000000fffbffff R09: ffff88817f1fdfa8
> R10: 0000000000000003 R11: 0000000000000000 R12: ffff8881070b4420
> R13: 0000000000000001 R14: ffff888112333b28 R15: ffffea0004b53e00
> FS:  00007f7b1ad91880(0000) GS:ffff8881f6b0b000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d7455da018 CR3: 00000001111ac000 CR4: 0000000000750eb0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  iomap_read_end+0xac/0x130
>  iomap_readahead+0x1e1/0x330
>  xfs_vm_readahead+0x3d/0x50
>  read_pages+0x69/0x270
>  page_cache_ra_order+0x2c2/0x4d0
>  page_cache_async_ra+0x204/0x3c0
>  filemap_readahead.isra.0+0x67/0x80
>  filemap_get_pages+0x376/0x8a0
>  ? find_held_lock+0x31/0x90
>  ? try_charge_memcg+0x21a/0x750
>  ? lock_acquire+0xb2/0x290
>  ? __memcg_kmem_charge_page+0x160/0x3c0
>  filemap_read+0x106/0x4c0
>  ? __might_fault+0x35/0x80
>  generic_file_read_iter+0xbc/0x110
>  xfs_file_buffered_read+0xa9/0x110
>  xfs_file_read_iter+0x82/0xf0
>  vfs_read+0x277/0x360
>  __x64_sys_pread64+0x7a/0xa0
>  x64_sys_call+0x1b03/0x1da0
>  do_syscall_64+0x6a/0x2e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f7b1b0efd07
> Code: 08 89 3c 24 48 89 4c 24 18 e8 55 76 fa ff 4c 8b 54 24 18 48 8b 54 2=
4 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 31 44 89 c7 48 89 04 24 e8 a5 76 fa ff 48 8b
> RSP: 002b:00007ffc4a4b8080 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f7b1b0efd07
> RDX: 0000000000001000 RSI: 000055d7455d8000 RDI: 0000000000000003
> RBP: 0000000000001000 R08: 0000000000000000 R09: 0000000000000003
> R10: 0000000000001000 R11: 0000000000000293 R12: 0000000000000001
> R13: 0000000000020000 R14: 000000000001f000 R15: 0000000000001000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:folio_end_read+0x68/0x70
> Code: 8e e9 04 00 0f 0b 48 8b 07 48 89 c2 48 c1 ea 03 a8 08 74 00 83 e2 0=
1 b8 09 00 00 00 74 c2 48 c7 c6 a0 6e 3e 82 e8 68 e9 04 00 <0f> 0b 90 0f 1f=
 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffff888112333870 EFLAGS: 00010286
> RAX: 000000000000004b RBX: ffffea0004b53e00 RCX: 0000000000000027
> RDX: ffff888179657c08 RSI: 0000000000000001 RDI: ffff888179657c00
> RBP: ffff888112333870 R08: 00000000fffbffff R09: ffff88817f1fdfa8
> R10: 0000000000000003 R11: 0000000000000000 R12: ffff8881070b4420
> R13: 0000000000000001 R14: ffff888112333b28 R15: ffffea0004b53e00
> FS:  00007f7b1ad91880(0000) GS:ffff8881f6b0b000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d7455da018 CR3: 00000001111ac000 CR4: 0000000000750eb0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> You're calling folio_end_read(folio, true) for a folio which is already
> marked uptodate!  I haven't looked through your patch to see what the
> problem is yet.  Very reproducible, you only have to run generic/008
> with a 1kB blocksize XFS.  And CONFIG_VM_DEBUG set, of course.

Ok, I see how we're getting into this state. For the case where all
the blocks get zeroed instead of read in, the
iomap_set_range_uptodate() call could have also called
folio_mark_uptodate() already.

This fixes the issue:
+++ b/fs/iomap/buffered-io.c
@@ -423,7 +423,9 @@ static void iomap_read_end(struct folio *folio,
size_t bytes_submitted)
                spin_lock_irq(&ifs->state_lock);
                if (!ifs->read_bytes_pending) {
                        WARN_ON_ONCE(bytes_submitted);
-                       end_read =3D true;
+                       spin_unlock_irq(&ifs->state_lock);
+                       folio_unlock(folio);
+                       return;
                } else {

I'll submit this fix to Christian's branch.

Thanks for giving the repro.

