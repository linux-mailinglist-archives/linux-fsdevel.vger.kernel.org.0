Return-Path: <linux-fsdevel+bounces-68799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6AC66775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7E729297BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7FE34D935;
	Mon, 17 Nov 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaIkjuHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD83446AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419637; cv=none; b=FxWW74setUZmZ3y3VMZAZ2KiEBwFs8huf0jIw1jQpL+18vFjfq+Cv5+81ASr4QMgahawAoVER7Qnsqa/UCXMGtgEtHlivH26obvcrwXHWXaF1fIamWOJKFhkezviguagouO0QRiXHjRDS1jWPG4SBPkE9fHhp1szwD26WWBvpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419637; c=relaxed/simple;
	bh=UOAkVT0QBtGAkDYvikFyyvijQD/qAyngzgkE5TD1HUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lhjhLe30IzqrMaHJIo1YeEGD+XY7nOM7R8/YT+LZGdE4LQHXbyRDhjdrRKc/y80u44QDLiGg4JGlemOxGen9sEWjLDUwB/j1ziK10Tg+7yO/ZHfyMk7leTy0oGptY1jD6Vlxr2dytUuhAgZEsSQKFfqcgQj9szNj5flxYoL6P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaIkjuHN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343e17d7ed5so6200272a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763419635; x=1764024435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lad1asYiF8cA2ZLix/TncpNgjY0XYbNhIlYI0rkVv5A=;
        b=oaIkjuHNfUbrGyhMPZwfQCZEHL/97APKX17xVLxe3O4WuEiJi5BO480LsYRDCH3BsX
         tRIX+4BvKQ1yABIBjEkRqpZdSgUL3jkJ81FCZtIhKgZxe7StJc5aUV/BrzZ3YKRQY2/U
         YoGjhRShWaUNZenfYbwdAmmB4gXvyC68FRB5ngeKSYMFjHDAdTlrgK8UYOJDwiNeRrDd
         W9DmzkXNbA/tTclvV9wl6IHJF/fB1CCVkyKoXx1bPLH8lwIAYuDOWlg26GCVBpzbxkJo
         GPaUd8QLtd/gWi3gbZiY5zccdOlQ59u3cmiBJFMzqIzullKtSqS38GFKo/qiRn5Pvstn
         7k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419635; x=1764024435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lad1asYiF8cA2ZLix/TncpNgjY0XYbNhIlYI0rkVv5A=;
        b=TP9zcsdRBlEclUI2pZ63qyMDz24oyTaGaxk1JkoK7U6vhGMDYiK1i98pDHmrUZ+NJS
         FLrXbcVkaRr/KNWfUk+HPBkcK/PNsc+XHKz1chXl6nRnYZMIXi4PonoEKlbmdjABPnOk
         AhArQmnMMFSCBO/V4c/+sONdYp612HhfgPlGQITTnZVtyRkgjPp7KABR7U8KOkNDgXgF
         TdLCtsdMSLOb88lV0IrahtAJcSJluVrKTLsVqRiRgWipI+Hec3UfqpS2y02mwDVngkwU
         HEONIilwvy0wXky3q6hlIy8/8KzUhO6AUfl9q5RF9tO/HVp4aO7jnu4fa3lvMuXwG/wv
         axQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9vFx5Yxk/krsNOG57KTiXNUwhu4l0Z6T9lhq2ewhcqNht8GI/rGYQpz/5q9vbwznGmTpyu02XDJhdXTsR@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfHFDWkrAZ1UueCSOK+Mv1ZiZXcxXcmaEoYljAeIqG6c4uOVj
	vJfp9bZzkoHnIII+pNIUct3YGphbS9+rfW/9uD7bM6Vts8IcocqpfD9RbiJuPOLt7QikttR5PgN
	uXiAum1cDM3cORXmPkCul08sUrw==
X-Google-Smtp-Source: AGHT+IHY//5/zSbJ96y0G1CVtIuXJVFgzUswEPddLr7yG1C8L/6rE6jUZ9/sELe1ezgM/wYNnndev+VmhVo67HX+sA==
X-Received: from pjboc6.prod.google.com ([2002:a17:90b:1c06:b0:343:387b:f2fb])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:350c:b0:340:b06f:7134 with SMTP id 98e67ed59e1d1-343fa62bcf6mr15075381a91.20.1763419635363;
 Mon, 17 Nov 2025 14:47:15 -0800 (PST)
Date: Mon, 17 Nov 2025 14:46:57 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117224701.1279139-1-ackerleytng@google.com>
Subject: [RFC PATCH 0/4] Extend xas_split* to support splitting arbitrarily
 large entries
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

guest_memfd is planning to store huge pages in the filemap, and
guest_memfd's use of huge pages involves splitting of huge pages into
individual pages. Splitting of huge pages also involves splitting of
the filemap entries for the pages being split.

To summarize the context of how these patches will be used,

+ guest_memfd stores huge pages (up to 1G pages) in the filemap.
+ During folio splitting, guest_memfd needs split the folios, and
  approaches that by first splitting the filemap (XArray) entries that
  the folio occupies, and then splitting the struct folios themselves.
+ Splitting from a 1G to 4K folio requires splitting an entry in a
  shift-18 XArray node to a shift-0 node in the xarray, which goes
  beyond 2 levels of XArray nodes, and is currently not supported.

This work-in-progress series at [1] shows the context of how these
patches for XArray entry splitting will be used.

[1] https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring

This patch series extends xas_split_alloc() to allocate enough nodes
for splitting an XArray node beyond 2 levels, and extends xas_split()
to use the allocated nodes in a split beyond 2 levels.

Merging of XArray entries can be performed with xa_store_order() at
the original order, and hence no change to the XArray library is
required.

xas_destroy() cleans up any allocated and unused nodes in struct
xa_state, and so no further changes are necessary there.

Please let me know

+ If this extension is welcome
+ Your thoughts on the approach: is it too many nodes to allocate at
  once? Would a recursive implementation be preferred?
+ If there are any bugs, particularly around how xas_split() interacts
  with LRU


Thank you!


Ackerley Tng (4):
  XArray: Initialize nodes while splitting instead of while allocating
  XArray: Update xas_split_alloc() to allocate enough nodes to split
    large entries
  XArray: Support splitting for arbitrarily large entries
  XArray: test: Increase split order test range in check_split()

 lib/test_xarray.c |   6 +-
 lib/xarray.c      | 210 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 162 insertions(+), 54 deletions(-)

--
2.52.0.rc1.455.g30608eb744-goog

