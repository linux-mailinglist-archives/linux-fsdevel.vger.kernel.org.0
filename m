Return-Path: <linux-fsdevel+bounces-45385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D8A76DD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F37C16AA48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008682147FC;
	Mon, 31 Mar 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDk2+ch8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C826AF6
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451310; cv=none; b=MZRXmYmDxt/Q/q9ESHuVqMKQymz4PXozrDdZSgqAvR93AwaHLXDlLTwXby3asA/oxkJdTyjK5uX1dgGBmVjR3ej1RCCUSzoHKUsGN7sIM2PGx7GdtgqmBwEUK3LM6+DLJwafDiyd+cRyTOrjTYQv9A2aU7z7V15KtbwlchprrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451310; c=relaxed/simple;
	bh=qXMGp8Kcoq4UqNEVtBJvLDTDV9N0nfLW2NPdpKOdhCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqVqTcYIF4vQMTFhxSOUsr5vDKgUh3dz7m4/tgYvhKE/g7t6JZYz63hJIuDISyNqCJLgbbByPUWlIxzaYGx903BqTx/asL7tpQxbK+VdYqHDWOejlQScyNFtzIDhz983uyaLQEar25BZUJ/2WitxtKs2QaAFTSwfoNWjpSQxF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDk2+ch8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47666573242so103151cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743451306; x=1744056106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9nuy28y5kwPzDz0y+tf+UJRMcXKrBUfAcJRz1FzxeQ=;
        b=JDk2+ch8/+uJEKRhpnRQri97U+fpNK0RYK2E/F8uPGg+RnQgis3SmCnN7MFkBFoXgy
         qqda9zY6divy+FLB3oLlHlpTQB7MbLegvKNaWQEW12PyQV/efqLBmLJYTlWXyZnG5wJS
         UV+ZGKiEgx6KCf6plB6O+JayG9ad7CDGOVuoKHCnn1tsUrBG3D2mFvedynvnTtmfDSoO
         R8ZlMMXd5j3uUzqEvQ/Ib0sNOU82BEqh7uTh1WM7BdQmiK24hXCqMWueFX16gTXG0Ow4
         DTWjaOEekqyWQWjrC7v8eOCPurxTMZtk50T6qpkeNr3V315Z6IjOtLa4ZslZwmsYFdQF
         wYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451306; x=1744056106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9nuy28y5kwPzDz0y+tf+UJRMcXKrBUfAcJRz1FzxeQ=;
        b=bJTgphwFWHAbOnlVmU1vuwzKWPfVaE4soCNPm5UG/cdyX8NQmNNqRXGTmyBhd2xsfl
         wvLTzlNLd24HyD01vVsmiDq/jT9tclWGmFCovOKdzEFeFZ2X/qhRe0f/qdEoYsUuQh09
         p6tmOV+JCzxrf/mHfs0CUWfJWPQJ4MmHvO2kwKJ+94RNyyyuYLYCGlOs/va1LI7p6ANM
         uLFsNZ9PawRH3VCFM0KmOQ945mgoHEaNuzAwR5C5Z8IxNOansXUFp1ZzFq0AwRu+0Zh+
         mhUKUsRCPzcKcKML6mTlF8CSMvJYx3/+P61WuSnGTogfn7muhqC69GQ8gkXXA807sPFj
         JyLA==
X-Forwarded-Encrypted: i=1; AJvYcCXatx2zOypETFSvcF8Vm6zbKiWAehlnqlW1G8XMXU/XXz3hN0XSxMxtndfR0ekErumpC681LntL1Ml3wU7b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oCqXKMWSDRh9/IKe5FPmp9qtHPuO1ZIkIUIoTKi9pejBJfTz
	pfqk4wVJc2X+gVx14xCaaILq7h/nrp24nTd/cIKeoYPiQwkkA6a6KMJ1oPW8suflYUzMvXjxJNR
	9ZNCE2knR/8C4uJZ4FbB1TYwojaRslKM4EX4Q
X-Gm-Gg: ASbGncuNjtVvQeZNsNNfaYXBcGr1NZajsXu1zwpjvaWSkRifu4Inh6u/708jqsCCIa3
	6BpUgce5X2UfPC5jv318fjHYqKlGFBn6AHtX5Mz7m9mR9NSxSRhtaoV05HPJemiOIv1MdSxGTXE
	LDvwE+13CkNyEH9zqLMsStnwfY
X-Google-Smtp-Source: AGHT+IG6SVL/xEjW2XwuqZrKWnwRBWznDZ4svsg/UKxPX5Xx6J17ftM2rL/BT3OWNY6s7xP1+9w86iUMc6uQEFjl5NE=
X-Received: by 2002:ac8:5f94:0:b0:474:fb73:6988 with SMTP id
 d75a77b69052e-478f641a721mr663221cf.24.1743451305915; Mon, 31 Mar 2025
 13:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
 <VI2PR04MB111475781D58AE4EA89988D9DE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <VI2PR04MB1114769569D65535C9DA20F0AE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
In-Reply-To: <VI2PR04MB1114769569D65535C9DA20F0AE8A12@VI2PR04MB11147.eurprd04.prod.outlook.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 31 Mar 2025 13:01:34 -0700
X-Gm-Features: AQ5f1JpePhHUWZusM_t9TPIZo822AgkF7iM7TPuWU_QIrWAEGhBQtPJ8-qIjL8s
Message-ID: <CAJuCfpFXqDvyk+ZyhtXKBTdEPM0JLyYFfLDN4jyn040DKtNeFw@mail.gmail.com>
Subject: Re: Ask help about this patch b951aaff5035 " mm: enable page
 allocation tagging"
To: Carlos Song <carlos.song@nxp.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 4:02=E2=80=AFAM Carlos Song <carlos.song@nxp.com> w=
rote:
>
> Hi,
>
> I get the function calling step log, I hope it can help debug little.

Hi Carlos,
Since you do not enable CONFIG_MEM_ALLOC_PROFILING, "mm: enable page
allocation tagging" patch would most definitely not cause this issue.

From the traces you posted I think the spinlock involved here is
zone->lock inside rmqueue_bulk():
https://elixir.bootlin.com/linux/v6.14-rc6/source/mm/page_alloc.c#L2310
I quickly scanned the code within that loop comparing 6.7 and 6.14 and
while I did not find anything obvious, steal_suitable_fallback()
function seems quite different. I would suggest profiling this path to
see which part might have regressed and go from there.
BTW, are you using pure upstream code or it has some out-of-tree modificati=
ons?
Thanks,
Suren.


>
> The spinlock_irqsave from 136.725021 to 136.966962_raw_spin_unlock_irqres=
tore.
> Around 260ms? It is Just one case, sometimes it will spend more time.
>
>                           dd-828     [000] .....   136.724980: fdget_pos =
<-ksys_write
>               dd-828     [000] .....   136.724982: vfs_write <-ksys_write
>               dd-828     [000] .....   136.724983: blkdev_write_iter <-vf=
s_write
>               dd-828     [000] .....   136.724984: I_BDEV <-blkdev_write_=
iter
>               dd-828     [000] .....   136.724985: file_update_time <-blk=
dev_write_iter
>               dd-828     [000] .....   136.724986: inode_needs_update_tim=
e <-file_update_time
>               dd-828     [000] .....   136.724987: ktime_get_coarse_real_=
ts64 <-inode_needs_update_time
>               dd-828     [000] .....   136.724989: timestamp_truncate <-i=
node_needs_update_time
>               dd-828     [000] .....   136.724990: iomap_file_buffered_wr=
ite <-blkdev_write_iter
>               dd-828     [000] .....   136.724992: iomap_iter <-iomap_fil=
e_buffered_write
>               dd-828     [000] .....   136.724993: blkdev_iomap_begin <-i=
omap_iter
>               dd-828     [000] .....   136.724994: I_BDEV <-blkdev_iomap_=
begin
>               dd-828     [000] .....   136.724995: balance_dirty_pages_ra=
telimited_flags <-iomap_file_buffered_write
>               dd-828     [000] .....   136.724996: inode_to_bdi <-balance=
_dirty_pages_ratelimited_flags
>               dd-828     [000] .....   136.724997: I_BDEV <-inode_to_bdi
>               dd-828     [000] .....   136.724998: preempt_count_add <-ba=
lance_dirty_pages_ratelimited_flags
>               dd-828     [000] ...1.   136.725000: preempt_count_sub <-ba=
lance_dirty_pages_ratelimited_flags
>               dd-828     [000] .....   136.725001: fault_in_readable <-fa=
ult_in_iov_iter_readable
>               dd-828     [000] .....   136.725003: iomap_write_begin <-io=
map_file_buffered_write
>               dd-828     [000] .....   136.725004: iomap_get_folio <-ioma=
p_write_begin
>               dd-828     [000] .....   136.725005: __filemap_get_folio <-=
iomap_write_begin
>               dd-828     [000] .....   136.725006: filemap_get_entry <-__=
filemap_get_folio
>               dd-828     [000] .....   136.725007: __rcu_read_lock <-file=
map_get_entry
>               dd-828     [000] .....   136.725008: __rcu_read_unlock <-fi=
lemap_get_entry
>               dd-828     [000] .....   136.725009: inode_to_bdi <-__filem=
ap_get_folio
>               dd-828     [000] .....   136.725010: I_BDEV <-inode_to_bdi
>               dd-828     [000] .....   136.725012: __folio_alloc_noprof <=
-__filemap_get_folio
>               dd-828     [000] .....   136.725013: __alloc_pages_noprof <=
-__folio_alloc_noprof
>               dd-828     [000] .....   136.725014: get_page_from_freelist=
 <-__alloc_pages_noprof
>               dd-828     [000] .....   136.725015: node_dirty_ok <-get_pa=
ge_from_freelist
>               dd-828     [000] .....   136.725016: preempt_count_add <-ge=
t_page_from_freelist
>               dd-828     [000] ...1.   136.725018: _raw_spin_trylock <-ge=
t_page_from_freelist
>               dd-828     [000] ...1.   136.725019: preempt_count_add <-_r=
aw_spin_trylock
>               dd-828     [000] ...2.   136.725021: _raw_spin_lock_irqsave=
 <-__rmqueue_pcplist
>               dd-828     [000] d..2.   136.725022: preempt_count_add <-_r=
aw_spin_lock_irqsave
>               dd-828     [000] d..3.   136.725025: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725028: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725029: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725031: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725032: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725034: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725036: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725037: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725038: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725039: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725040: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725042: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725043: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725044: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725046: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725047: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725048: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725050: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725051: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725052: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725053: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725055: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725056: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725057: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725058: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725060: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725061: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725062: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725063: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725065: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725066: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725067: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725068: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725070: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725071: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725072: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725073: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725075: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725076: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725077: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725079: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725080: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725081: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725082: __mod_zone_page_state =
<-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.725083: __mod_zone_page_state =
<-__rmqueue_pcplist
> ...
>               dd-828     [000] d..3.   136.820279: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820280: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820281: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820282: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820283: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820284: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820285: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820286: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820287: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820289: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820290: steal_suitable_fallbac=
k <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.820525: __mod_zone_page_state =
<-steal_suitable_fallback
> ...
>            dd-828     [000] d..3.   136.966945: __mod_zone_page_state <-s=
teal_suitable_fallback
>               dd-828     [000] d..3.   136.966946: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966947: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966948: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966950: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966951: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966952: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966953: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966954: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966955: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966956: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966957: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966958: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966959: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966961: find_suitable_fallback=
 <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966962: _raw_spin_unlock_irqre=
store <-__rmqueue_pcplist
>               dd-828     [000] d..3.   136.966965: irq_enter <-generic_ha=
ndle_arch_irq
>               dd-828     [000] d..3.   136.966966: irq_enter_rcu <-generi=
c_handle_arch_irq
>               dd-828     [000] d..3.   136.966967: preempt_count_add <-ir=
q_enter_rcu
>               dd-828     [000] d.h3.   136.966969: gic_handle_irq <-gener=
ic_handle_arch_irq
>               dd-828     [000] d.h3.   136.966970: generic_handle_domain_=
irq <-gic_handle_irq
>               dd-828     [000] d.h3.   136.966971: __irq_resolve_mapping =
<-generic_handle_domain_irq
>               dd-828     [000] d.h3.   136.966972: __rcu_read_lock <-__ir=
q_resolve_mapping
>               dd-828     [000] d.h3.   136.966974: __rcu_read_unlock <-__=
irq_resolve_mapping
>               dd-828     [000] d.h3.   136.966975: handle_irq_desc <-gic_=
handle_irq
>               dd-828     [000] d.h3.   136.966976: handle_percpu_devid_ir=
q <-handle_irq_desc
>               dd-828     [000] d.h3.   136.966978: ipi_handler <-handle_p=
ercpu_devid_irq
>               dd-828     [000] d.h3.   136.966979: do_handle_IPI <-ipi_ha=
ndler
>               dd-828     [000] d.h3.   136.966981: generic_smp_call_funct=
ion_single_interrupt <-do_handle_IPI
>               dd-828     [000] d.h3.   136.966982: __flush_smp_call_funct=
ion_queue <-do_handle_IPI
>               dd-828     [000] d.h3.   136.966986: sched_ttwu_pending <-_=
_flush_smp_call_function_queue
>               dd-828     [000] d.h3.   136.966987: preempt_count_add <-sc=
hed_ttwu_pending
>               dd-828     [000] d.h4.   136.966990: _raw_spin_lock <-sched=
_ttwu_pending
>               dd-828     [000] d.h4.   136.966991: preempt_count_add <-_r=
aw_spin_lock
>               dd-828     [000] d.h5.   136.966993: preempt_count_sub <-sc=
hed_ttwu_pending
>               dd-828     [000] d.h4.   136.966994: update_rq_clock.part.0=
 <-sched_ttwu_pending
>               dd-828     [000] d.h4.   136.966996: ttwu_do_activate <-sch=
ed_ttwu_pending
>               dd-828     [000] d.h4.   136.966997: activate_task <-ttwu_d=
o_activate
>               dd-828     [000] d.h4.   136.966998: enqueue_task_fair <-ac=
tivate_task
>               dd-828     [000] d.h4.   136.967000: update_curr <-enqueue_=
task_fair
>               dd-828     [000] d.h4.   136.967001: update_min_vruntime <-=
update_curr
>               dd-828     [000] d.h4.   136.967003: __cgroup_account_cputi=
me <-update_curr
>
> BR
> Carlos Song
>
> > > On Thu, Mar 20, 2025 at 11:07:41AM +0000, Carlos Song wrote:
> > > > Hi, all
> > > >
> > > > I found a 300ms~600ms IRQ off when writing 1Gb data to mmc device a=
t
> > > I.MX7d SDB board at Linux-kernel-v6.14.
> > > > But I test the same case at Linux-kernel-v6.7, this longest IRQ off
> > > > time is only
> > > 1ms~2ms. So the issue is introduced from v6.7~v6.14.
> > > >
> > > > Run this cmd to test:
> > > > dd if=3D/dev/zero of=3D/dev/mmcblk2p4 bs=3D4096 seek=3D12500 count=
=3D256000
> > > > conv=3Dfsync
> > > >
> > > > This issue looks from blkdev_buffered_write() function. Because whe=
n
> > > > I run this cmd with "oflag=3Ddirect" to use blkdev_direct_write(), =
I
> > > > can not see
> > > any long time IRQ off.
> > > >
> > > > Then I use Ftrace irqoff tracer to trace the longest IRQ off event,
> > > > I found some
> > > differences between v6.7 and v6.14:
> > > > In iomap_file_buffered_write(), __folio_alloc (in v6.7) is replaced
> > > > by
> > > _folio_alloc_noprof (in v6.14) by this patch.
> > > > The spinlock disabled IRQ ~300ms+. It looks there are some fixes fo=
r
> > > > this patch,
> > > but I still can see IRQ off 300ms+ at 6.14.0-rc7-next-20250319.
> > > >
> > > > Do I trigger one bug? I know little about mem so I have to report i=
t
> > > > and hope I
> > > can get some help or guide.
> > > > I put my ftrace log at the mail tail to help trace and explain.
> > >
> > > Did you track down which spinlock?
> > >
> > > >
> >
> > Hi,
> >
> > Sorry for my late reply and thank you for your quick reply!
> > From the trace log, I think the spinlock is from here like this:
> >
> > __alloc_frozen_pages_noprof =3D=3D> get_page_from_freelist=3D=3D>spincl=
ok
> >
> > Do you need other log not only this?
> >
> > > > =3D> get_page_from_freelist"
> > > > =3D> __alloc_frozen_pages_noprof
> > > > =3D> __folio_alloc_noprof
> > > > =3D> __filemap_get_folio
> >
> >
> > > > commit b951aaff503502a7fe066eeed2744ba8a6413c89
> > > > Author: Suren Baghdasaryan
> > > surenb@google.com<mailto:surenb@google.com>
> > > > Date:   Thu Mar 21 09:36:40 2024 -0700
> > > >
> > > >     mm: enable page allocation tagging
> > > >
> > > >     Redefine page allocators to record allocation tags upon their
> > invocation.
> > > >     Instrument post_alloc_hook and free_pages_prepare to modify
> > current
> > > >     allocation tag.
> > > >
> > > >     [surenb@google.com: undo _noprof additions in the documentation=
]
> > > >       Link:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml
> > > .kern
> > >
> > el.org%2Fr%2F20240326231453.1206227-3-surenb%40google.com&data=3D05%
> > >
> > 7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5%7
> > >
> > C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983046738%
> > >
> > 7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> > >
> > wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> > >
> > &sdata=3DAby13KyQjF5pcbYW%2BkfsEJLiaPmS2ZiJLUHJ%2BCr2JXM%3D&reserve
> > > d=3D0
> > > >     Link:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml
> > > .kern
> > >
> > el.org%2Fr%2F20240321163705.3067592-19-surenb%40google.com&data=3D05
> > > %7C02%7Ccarlos.song%40nxp.com%7Cdf027bbb97074fc2cde808dd67a1d6c5
> > %
> > >
> > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638780666983065790
> > > %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuM
> > D
> > >
> > AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7
> > >
> > C&sdata=3Dn0hjs2fhjYs%2BcnbrxHy4vFK6D4GFVL4%2Fu72anOOLiEI%3D&reserve
> > > d=3D0
> > > >     Signed-off-by: Suren Baghdasaryan
> > > surenb@google.com<mailto:surenb@google.com>
> > > >     Co-developed-by: Kent Overstreet
> > > kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> > > >     Signed-off-by: Kent Overstreet
> > > kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
> > > >     Reviewed-by: Kees Cook
> > > keescook@chromium.org<mailto:keescook@chromium.org>
> > > >     Tested-by: Kees Cook
> > > keescook@chromium.org<mailto:keescook@chromium.org>
> > > >     Cc: Alexander Viro
> > > viro@zeniv.linux.org.uk<mailto:viro@zeniv.linux.org.uk>
> > > >     Cc: Alex Gaynor
> > > alex.gaynor@gmail.com<mailto:alex.gaynor@gmail.com>
> > > >     Cc: Alice Ryhl aliceryhl@google.com<mailto:aliceryhl@google.com=
>
> > > >     Cc: Andreas Hindborg
> > > a.hindborg@samsung.com<mailto:a.hindborg@samsung.com>
> > > >     Cc: Benno Lossin
> > > benno.lossin@proton.me<mailto:benno.lossin@proton.me>
> > > >     Cc: "Bj=C3=B6rn Roy Baron"
> > > bjorn3_gh@protonmail.com<mailto:bjorn3_gh@protonmail.com>
> > > >     Cc: Boqun Feng
> > > boqun.feng@gmail.com<mailto:boqun.feng@gmail.com>
> > > >     Cc: Christoph Lameter cl@linux.com<mailto:cl@linux.com>
> > > >     Cc: Dennis Zhou dennis@kernel.org<mailto:dennis@kernel.org>
> > > >     Cc: Gary Guo gary@garyguo.net<mailto:gary@garyguo.net>
> > > >     Cc: Miguel Ojeda ojeda@kernel.org<mailto:ojeda@kernel.org>
> > > >     Cc: Pasha Tatashin
> > > pasha.tatashin@soleen.com<mailto:pasha.tatashin@soleen.com>
> > > >     Cc: Peter Zijlstra
> > peterz@infradead.org<mailto:peterz@infradead.org>
> > > >     Cc: Tejun Heo tj@kernel.org<mailto:tj@kernel.org>
> > > >     Cc: Vlastimil Babka vbabka@suse.cz<mailto:vbabka@suse.cz>
> > > >     Cc: Wedson Almeida Filho
> > > wedsonaf@gmail.com<mailto:wedsonaf@gmail.com>
> > > >     Signed-off-by: Andrew Morton
> > > > akpm@linux-foundation.org<mailto:akpm@linux-foundation.org>
> > > >
> > > >
> > > > Ftrace irqoff tracer shows detail:
> > > > At v6.14:
> > > > # tracer: irqsoff
> > > > #
> > > > # irqsoff latency trace v1.1.5 on 6.14.0-rc7-next-20250319 #
> > > > -------------------------------------------------------------------=
-
> > > > # latency: 279663 us, #21352/21352, CPU#0 | (M:NONE VP:0, KP:0, SP:=
0
> > > > HP:0
> > > #P:2)
> > > > #    -----------------
> > > > #    | task: dd-805 (uid:0 nice:0 policy:0 rt_prio:0)
> > > > #    -----------------
> > > > #  =3D> started at: __rmqueue_pcplist
> > > > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > > > #
> > > > #
> > > > #                    _------=3D> CPU#
> > > > #                   / _-----=3D> irqs-off/BH-disabled
> > > > #                  | / _----=3D> need-resched
> > > > #                  || / _---=3D> hardirq/softirq
> > > > #                  ||| / _--=3D> preempt-depth
> > > > #                  |||| / _-=3D> migrate-disable
> > > > #                  ||||| /     delay
> > > > #  cmd     pid     |||||| time  |   caller
> > > > #     \   /        ||||||  \    |    /
> > > >       dd-805       0d....    1us : __rmqueue_pcplist
> > > >       dd-805       0d....    3us : _raw_spin_trylock
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....    7us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....   10us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....   12us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....   15us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....   17us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d....   19us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >    ...
> > > >       dd-805       0d.... 1535us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1538us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1539us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1542us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1597us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1599us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1674us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1676us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1716us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1718us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1801us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 1803us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > > ...
> > > >      dd-805       0d.... 279555us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279556us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279558us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279560us+: try_to_claim_block
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279616us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279618us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279620us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > > ...
> > > >       dd-805       0d.... 279658us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279660us : _raw_spin_unlock_irqrestore
> > > <-__rmqueue_pcplist
> > > >       dd-805       0d.... 279662us : _raw_spin_unlock_irqrestore
> > > >       dd-805       0d.... 279666us+: trace_hardirqs_on
> > > <-_raw_spin_unlock_irqrestore
> > > >       dd-805       0d.... 279712us : <stack trace>
> > > > =3D> get_page_from_freelist
> > > > =3D> __alloc_frozen_pages_noprof
> > > > =3D> __folio_alloc_noprof
> > > > =3D> __filemap_get_folio
> > > > =3D> iomap_write_begin
> > > > =3D> iomap_file_buffered_write
> > > > =3D> blkdev_write_iter
> > > > =3D> vfs_write
> > > > =3D> ksys_write
> > > > =3D> ret_fast_syscall
> > > >
> > > > At v6.7:
> > > > # tracer: irqsoff
> > > > #
> > > > # irqsoff latency trace v1.1.5 on 6.7.0 #
> > > > -------------------------------------------------------------------=
-
> > > > # latency: 2477 us, #146/146, CPU#0 | (M:server VP:0, KP:0, SP:0 HP=
:0 #P:2)
> > > > #    -----------------
> > > > #    | task: dd-808 (uid:0 nice:0 policy:0 rt_prio:0)
> > > > #    -----------------
> > > > #  =3D> started at: _raw_spin_lock_irqsave
> > > > #  =3D> ended at:   _raw_spin_unlock_irqrestore
> > > > #
> > > > #
> > > > #                    _------=3D> CPU#
> > > > #                   / _-----=3D> irqs-off/BH-disabled
> > > > #                  | / _----=3D> need-resched
> > > > #                  || / _---=3D> hardirq/softirq
> > > > #                  ||| / _--=3D> preempt-depth
> > > > #                  |||| / _-=3D> migrate-disable
> > > > #                  ||||| /     delay
> > > > #  cmd     pid     |||||| time  |   caller
> > > > #     \   /        ||||||  \    |    /
> > > >       dd-808       0d....    1us!: _raw_spin_lock_irqsave
> > > >       dd-808       0d....  186us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  189us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  191us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  192us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  194us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  196us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  199us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  203us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d....  330us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  332us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  334us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  336us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  338us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  339us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  341us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  343us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d....  479us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  481us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  483us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  485us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  486us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  488us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  490us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  492us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d....  630us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  632us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  634us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  636us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  638us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  640us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  642us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  644us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d....  771us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  773us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  775us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  777us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  778us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  780us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  782us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  784us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d....  911us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  913us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  915us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  916us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  918us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  920us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  922us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d....  924us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1055us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1058us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1059us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1061us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1063us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1065us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1066us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1068us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1194us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1196us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1198us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1200us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1202us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1203us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1205us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1208us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1333us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1335us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1337us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1339us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1341us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1342us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1344us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1346us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1480us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1482us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1484us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1486us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1488us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1490us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1492us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1494us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1621us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1623us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1625us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1627us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1629us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1630us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1632us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1634us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1761us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1763us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1765us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1766us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1768us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1770us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1772us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1774us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 1900us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1902us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1903us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1905us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1907us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1909us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1911us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 1913us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 2038us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2040us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2042us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2044us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2046us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2047us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2049us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2051us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2053us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2055us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 2175us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2176us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2178us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2180us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2182us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2183us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2185us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2187us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2189us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2191us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2192us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2194us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2196us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 2323us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2325us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2327us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2328us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2330us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2332us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2334us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2335us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2337us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2339us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2341us : find_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2343us : steal_suitable_fallback
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2345us!: move_freepages_block
> > > <-steal_suitable_fallback
> > > >       dd-808       0d.... 2470us : __mod_zone_page_state
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2473us : _raw_spin_unlock_irqrestore
> > > <-__rmqueue_pcplist
> > > >       dd-808       0d.... 2476us : _raw_spin_unlock_irqrestore
> > > >       dd-808       0d.... 2479us+: tracer_hardirqs_on
> > > <-_raw_spin_unlock_irqrestore
> > > >       dd-808       0d.... 2520us : <stack trace>
> > > > =3D> get_page_from_freelist
> > > > =3D> __alloc_pages
> > > > =3D> __folio_alloc
> > > > =3D> __filemap_get_folio
> > > > =3D> iomap_write_begin
> > > > =3D> iomap_file_buffered_write
> > > > =3D> blkdev_write_iter
> > > > =3D> vfs_write
> > > > =3D> ksys_write
> > > > =3D> ret_fast_syscall
> > > >
> > > > Best Regard
> > > > Carlos Song
> > > >

