Return-Path: <linux-fsdevel+bounces-67631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B7C44FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 06:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BA53A91F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1AA2D77E2;
	Mon, 10 Nov 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnkKzoa5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B21A2C25
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751896; cv=none; b=I3n7H7JDZklEbLlJNJkbh14RmtNR/vs5VClPcpE44QLaD6SeaniPSdO1NBk440g6aBt48NM2lRSatzHBl1fEnykqyo+cIT7vBXDUhPuuXyPlJWB0fSy8daVlsaHMmsgou0eBi3E/WxCF/z/CY3eTf6W+o8SlW70nAjTWZw1aYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751896; c=relaxed/simple;
	bh=++gtEzpGcu6xgR6K6h2d4HU0XkRxkWJd8Bk1p3etrX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHuL2jarm6bXk3hj1YMF4yzy+ISVlfLI2qXNfHCAbQgQVfZnoLZGifnY54vQG2sxlenpoutqzvq8L/P5FUDHk9Dexjr9xK+UElRayLbL2Qw+Z1UslQ5M43Hvz7Dbqy9HfhkUPWpZuxQMV9pSatc2JyHzv88MMUvaeHDh7xbzrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnkKzoa5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324204so437097766b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762751893; x=1763356693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++gtEzpGcu6xgR6K6h2d4HU0XkRxkWJd8Bk1p3etrX4=;
        b=DnkKzoa5orHz/OBVEkrcrHNjom0BKADxK/yRNB3WXhn0UuadGTJL7dqhlUCGs5IKyv
         VnaE+FsCJ+p3p0y9xjuWElMNFVawmnI2LZUR0djKUoMbzsiMJY/4Won/1ZOf+o/2HAYd
         LboFyFxGEnd+Ajoe3g/XC5TXU0E7I854I7Xv4N9qUhpcrpeB7hpbwP76QZ9OVhQ84Si8
         7baD5Zpb32phpJYAimtJwbhG8Q9gQ1oxlVu+skVxKKfmzMYH2BThKnrAKOtds5owL1Ku
         H0ELX0bdbdus0D7beSqYpSUF5DtcTZhEBURmm6v3u8jdVNbgIjjyU/A075/kds41niLk
         KKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751893; x=1763356693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++gtEzpGcu6xgR6K6h2d4HU0XkRxkWJd8Bk1p3etrX4=;
        b=e+p6o1NfH4uiqor84KRXbqmwJzClyULvteHPWn+IF+s/WGaa4gSDNwz2Zhkna/iDpP
         p51c8HckMcPSag83UYDAPtmq8t59Y3CKKm85aPR7femFxyoa7FM25udTgpSafkN8Tohi
         LtCC8LMwcHe1dree+Tokl8zpXA+Y5xuFREeUBd1pnesbNAQBDsleCsdkk6gfrDoDTJzT
         irPmKBymV26vF/MQZX4Ae/zb5ReVJsD3VlqrZD8z8j+pmg8vdCPqM1it5ei9it9C1jEH
         KtlmtRFff/Kb4Qns3l5diCrkE3Un11iZ7l9x7GrwzC4lau3x3wJlp8zvvsN2xY11KOl/
         bglA==
X-Forwarded-Encrypted: i=1; AJvYcCWHqkSpuHKI0kHu+RkdzuiL8VjA2+PCS9rsP5LiyZo1WqQARV7HJUHBd9Q/Ij0HGINeAppZ8JcoCO/86mQ4@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGZcHm/z0U2NSrPXkOhfiRrZXUziMr8zePK/Lg/u/8M5Y6t1S
	3O5+hCCic3zJp9rxwPGbT6YZ6Xja+meDNuI+PG896KwXy4mY5KZij6pAa8yttBia26SaTFUU9r7
	unY4ApJ1gauAuBO+TauBHNJ3lh+Im+WU=
X-Gm-Gg: ASbGnctJ9vV844bn/CAvDHzzILPeCCNd6bfwY4mDim44gUVgTomazPsKBm9T/fbl3t9
	GEHe00wZAyxTrPT4CCr3vFuFW+MdpKbGUtKGBRRIERKeQJXe2+Ifgv6hiw3VM3KkiZSPylnfkI0
	UymBhGHhXKLEPXE1FG9ZzoPkQ56ekR5T2oBU+pntjSopuO8J1yw32IW0uoEGcxifzPpLnNzBf4s
	uS2cL0VeOOXUx0MxqcULtiugXJ0QTej5tqQV+oLQHYhEpHxiLkNTHXyDTEy4FXZSTGTAN+FSqHd
	3W+l
X-Google-Smtp-Source: AGHT+IHgUoBYSs1Ui5eLQ8OYfjFCd/t/iFFT0en1iYaWbLE78j1USxFDEmAp18V0mTVwTArsi++M2GNg1PkW0I18Apc=
X-Received: by 2002:a17:907:3f26:b0:b3d:9261:ff1b with SMTP id
 a640c23a62f3a-b72e029316emr628392266b.5.1762751892536; Sun, 09 Nov 2025
 21:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mtnf1eBTXnDQBiQYKrwEwUzxcxC5Nfv1NbiCdudQMaUZA@mail.gmail.com>
In-Reply-To: <CAH2r5mtnf1eBTXnDQBiQYKrwEwUzxcxC5Nfv1NbiCdudQMaUZA@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Mon, 10 Nov 2025 10:48:00 +0530
X-Gm-Features: AWmQ_blFf_ipmknB2PTyHkqoaG_0J7bKY1_oo8xXafjWkaNBZ9Paffyawvw0fJI
Message-ID: <CANT5p=p2jb2dmgQJw2jen_JcvUw8BJYV1Lq4pfUzuMVDpx=v2A@mail.gmail.com>
Subject: Re: New netfs crash in last month or so
To: Steve French <smfrench@gmail.com>, David Howells <dhowells@redhat.com>, 
	Paulo Alcantara <pc@manguebit.com>, Paulo Alcantara <pc@manguebit.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:37=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> Have been seeing this netfs crash over the last month or so
> (presumably a recent regression) for example running generix/215.
> Ideas welcome
>
> [Fri Nov 7 10:03:14 2025] run fstests generic/215 at 2025-11-07 10:03:15
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [Fri Nov 7 10:03:15 2025] BUG: KASAN: slab-use-after-free in
> netfs_limit_iter+0x50f/0x770 [netfs]
> [Fri Nov 7 10:03:15 2025] Read of size 1 at addr ff1100011b65d910 by
> task kworker/u36:2/69285
> [Fri Nov 7 10:03:15 2025] CPU: 3 UID: 0 PID: 69285 Comm: kworker/u36:2
> Tainted: G E 6.18.0-rc4 #1 PREEMPT(voluntary)
> [Fri Nov 7 10:03:15 2025] Tainted: [E]=3DUNSIGNED_MODULE
> [Fri Nov 7 10:03:15 2025] Hardware name: Red Hat KVM, BIOS
> 1.16.3-4.el9 04/01/2014
> [Fri Nov 7 10:03:15 2025] Workqueue: events_unbound
> netfs_write_collection_worker [netfs]
> [Fri Nov 7 10:03:15 2025] Call Trace:
> [Fri Nov 7 10:03:15 2025] <TASK>
> [Fri Nov 7 10:03:15 2025] dump_stack_lvl+0x79/0xb0
> [Fri Nov 7 10:03:15 2025] print_report+0xcb/0x610
> [Fri Nov 7 10:03:15 2025] ? __virt_addr_valid+0x19a/0x300
> [Fri Nov 7 10:03:15 2025] ? netfs_limit_iter+0x50f/0x770 [netfs]
> [Fri Nov 7 10:03:15 2025] ? netfs_limit_iter+0x50f/0x770 [netfs]
> [Fri Nov 7 10:03:15 2025] kasan_report+0xca/0x100
> [Fri Nov 7 10:03:15 2025] ? netfs_limit_iter+0x50f/0x770 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_limit_iter+0x50f/0x770 [netfs]
> [Fri Nov 7 10:03:15 2025] ? __pfx_netfs_limit_iter+0x10/0x10 [netfs]
> [Fri Nov 7 10:03:15 2025] ? cifs_prepare_write+0x28e/0x490 [cifs]
> [Fri Nov 7 10:03:15 2025] netfs_retry_writes+0x94d/0xcf0 [netfs]
> [Fri Nov 7 10:03:15 2025] ? __pfx_netfs_retry_writes+0x10/0x10 [netfs]
> [Fri Nov 7 10:03:15 2025] ? folio_end_writeback+0x9b/0xf0
> [Fri Nov 7 10:03:15 2025] ? netfs_folio_written_back+0x1af/0x3e0 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_write_collection+0x936/0x1bb0 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_write_collection_worker+0x13d/0x2b0 [netf=
s]
> [Fri Nov 7 10:03:15 2025] process_one_work+0x4bf/0xb40
> [Fri Nov 7 10:03:15 2025] ? __pfx_process_one_work+0x10/0x10
> [Fri Nov 7 10:03:15 2025] ? assign_work+0xd6/0x110
> [Fri Nov 7 10:03:15 2025] worker_thread+0x2c9/0x550
> [Fri Nov 7 10:03:15 2025] ? __pfx_worker_thread+0x10/0x10
> [Fri Nov 7 10:03:15 2025] kthread+0x216/0x3e0
> [Fri Nov 7 10:03:15 2025] ? __pfx_kthread+0x10/0x10
> [Fri Nov 7 10:03:15 2025] ? __pfx_kthread+0x10/0x10
> [Fri Nov 7 10:03:15 2025] ? lock_release+0xc4/0x270
> [Fri Nov 7 10:03:15 2025] ? rcu_is_watching+0x20/0x50
> [Fri Nov 7 10:03:15 2025] ? __pfx_kthread+0x10/0x10
> [Fri Nov 7 10:03:15 2025] ret_from_fork+0x2a8/0x350
> [Fri Nov 7 10:03:15 2025] ? __pfx_kthread+0x10/0x10
> [Fri Nov 7 10:03:15 2025] ret_from_fork_asm+0x1a/0x30
> [Fri Nov 7 10:03:15 2025] </TASK>
> [Fri Nov 7 10:03:15 2025] Allocated by task 74971:
> [Fri Nov 7 10:03:15 2025] kasan_save_stack+0x24/0x50
> [Fri Nov 7 10:03:15 2025] kasan_save_track+0x14/0x30
> [Fri Nov 7 10:03:15 2025] __kasan_kmalloc+0x7f/0x90
> [Fri Nov 7 10:03:15 2025] netfs_folioq_alloc+0x56/0x1b0 [netfs]
> [Fri Nov 7 10:03:15 2025] rolling_buffer_init+0x23/0x70 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_create_write_req+0x85/0x360 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_writepages+0x110/0x520 [netfs]
> [Fri Nov 7 10:03:15 2025] do_writepages+0x123/0x260
> [Fri Nov 7 10:03:15 2025] filemap_fdatawrite_wbc+0x74/0x90
> [Fri Nov 7 10:03:15 2025] __filemap_fdatawrite_range+0x9a/0xc0
> [Fri Nov 7 10:03:15 2025] filemap_write_and_wait_range+0x56/0xc0
> [Fri Nov 7 10:03:15 2025] cifs_flush+0x10c/0x1f0 [cifs]
> [Fri Nov 7 10:03:15 2025] filp_flush+0x97/0xd0
> [Fri Nov 7 10:03:15 2025] __x64_sys_close+0x4a/0x90
> [Fri Nov 7 10:03:15 2025] do_syscall_64+0x75/0x9c0
> [Fri Nov 7 10:03:15 2025] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Fri Nov 7 10:03:15 2025] Freed by task 69285:
> [Fri Nov 7 10:03:15 2025] kasan_save_stack+0x24/0x50
> [Fri Nov 7 10:03:15 2025] kasan_save_track+0x14/0x30
> [Fri Nov 7 10:03:15 2025] __kasan_save_free_info+0x3b/0x60
> [Fri Nov 7 10:03:15 2025] __kasan_slab_free+0x43/0x70
> [Fri Nov 7 10:03:15 2025] kfree+0x11a/0x630
> [Fri Nov 7 10:03:15 2025] rolling_buffer_delete_spent+0x80/0xa0 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_write_collection+0x119c/0x1bb0 [netfs]
> [Fri Nov 7 10:03:15 2025] netfs_write_collection_worker+0x13d/0x2b0 [netf=
s]
> [Fri Nov 7 10:03:15 2025] process_one_work+0x4bf/0xb40
> [Fri Nov 7 10:03:15 2025] worker_thread+0x2c9/0x550
> [Fri Nov 7 10:03:15 2025] kthread+0x216/0x3e0
> [Fri Nov 7 10:03:15 2025] ret_from_fork+0x2a8/0x350
> [Fri Nov 7 10:03:15 2025] ret_from_fork_asm+0x1a/0x30
> [Fri Nov 7 10:03:15 2025] The buggy address belongs to the object at
> ff1100011b65d800
> which belongs to the cache kmalloc-512 of size 512
> [Fri Nov 7 10:03:15 2025] The buggy address is located 272 bytes inside o=
f
> freed 512-byte region [ff1100011b65d800, ff1100011b65da00)
> [Fri Nov 7 10:03:15 2025] The buggy address belongs to the physical page:
> [Fri Nov 7 10:03:15 2025] page: refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x11b658
> [Fri Nov 7 10:03:15 2025] head: order:3 mapcount:0 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [Fri Nov 7 10:03:15 2025] anon flags:
> 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> [Fri Nov 7 10:03:15 2025] page_type: f5(slab)
> [Fri Nov 7 10:03:15 2025] raw: 0017ffffc0000040 ff11000100038c80
> 0000000000000000 dead000000000001
> [Fri Nov 7 10:03:15 2025] raw: 0000000000000000 0000000000200020
> 00000000f5000000 0000000000000000
> [Fri Nov 7 10:03:15 2025] head: 0017ffffc0000040 ff11000100038c80
> 0000000000000000 dead000000000001
> [Fri Nov 7 10:03:15 2025] head: 0000000000000000 0000000000200020
> 00000000f5000000 0000000000000000
> [Fri Nov 7 10:03:15 2025] head: 0017ffffc0000003 ffd40000046d9601
> 00000000ffffffff 00000000ffffffff
> [Fri Nov 7 10:03:15 2025] head: ffffffffffffffff 0000000000000000
> 00000000ffffffff 0000000000000008
> [Fri Nov 7 10:03:15 2025] page dumped because: kasan: bad access detected
> [Fri Nov 7 10:03:15 2025] Memory state around the buggy address:
> [Fri Nov 7 10:03:15 2025] ff1100011b65d800: fa fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [Fri Nov 7 10:03:15 2025] ff1100011b65d880: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [Fri Nov 7 10:03:15 2025] >ff1100011b65d900: fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb fb
> [Fri Nov 7 10:03:15 2025] ^
> [Fri Nov 7 10:03:15 2025] ff1100011b65d980: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [Fri Nov 7 10:03:15 2025] ff1100011b65da00: fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc fc
> [Fri Nov 7 10:03:15 2025]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [Fri Nov 7 10:03:15 2025] Disabling lock debugging due to kernel taint
>
> http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/=
8/builds/152/steps/78/logs/stdio
>
> --
> Thanks,
>
> Steve
>

It looks like a missing initialization in the netfs write retry code.
This initialization of sreq_max_segs seems different from all the
other places to me:
https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/netfs/write_retry.c#L1=
62
David / Paulo: Is it expected to set a non-zero value to this? If the
value of this was 0, we wouldn't have called netfs_limit_iter in this
codepath.

--=20
Regards,
Shyam

