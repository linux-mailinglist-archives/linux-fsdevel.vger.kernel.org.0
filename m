Return-Path: <linux-fsdevel+bounces-13368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0A86F0A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9464284A59
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22217BB2;
	Sat,  2 Mar 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su287Q3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87A13FFA
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388813; cv=none; b=fbrickNWSWW8o7GDgcDloN7pkj8DufrmSyoohKny0cLLXKtClBDiIgoEQLIPiWtnprsLLMnNBytQextJPbhWIFGaVSJSmBf+z0tGv2g25IXjG+55bWJgu4qDZbD6b88I/101NnjgJv6eLuzH1WapaCKBbDhzlkkRgDeGHynmQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388813; c=relaxed/simple;
	bh=iNN0MzPkf2CGDRv5J7QwEfALJ4wP7Net/HGNTZTtLJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BEZfSGPu+mu96GpE1FkUBnXjjVwu0DX/Z69+MkVbI2enaj7Gl9AT21jmuA/bWPCRqKg9icsBaYOP+xWTNkX9jHCwobER5zmBZ7N4gi4G2Yv2f/SixXEGuMYQUOcvw5xVMU4cnlrygm2JnvCV/QaMW5vRrTdfNC6KqDQfeBxlvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su287Q3U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7232dcb3eso23674665ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709388811; x=1709993611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKI5tRpZgcrp7k5E6TILzW0nYoavjh3k4z8aUf1JO/Y=;
        b=Su287Q3UhpzbOnCK4ZJrNFY1lpDRzq2nhwIiJl9L5jQKfrmJN0vakY8FcuCbWC5M/B
         enW9Q5EqltjXTkwDgZ4Q/GJaoyJn72pmlelVyqwMZ3dcyJ71Bs6WhrskTEluEWw2FQ9r
         CnKZRz6/zECKm87ys3E/h9M2lOdpeez/GXKOWcw4suyRTmkn5kwtwV56Gfr2/87HQj5s
         Oqn3Xtpb+58NCkKRgTfIFmqm+/002b85VgMw+PoOBy974otRBsYno9Gyq+Gzb+/YMTax
         2lBx3jivZ/HAwa1RU2jk229rA8jUwXee/CJljmk3ayBi3w1XnkaDVjY39CstPrG4b66H
         QPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709388811; x=1709993611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKI5tRpZgcrp7k5E6TILzW0nYoavjh3k4z8aUf1JO/Y=;
        b=qqWhumYpwSN2kiY6M3B3C7qeWAyFPIQlGxyf/8x5N2t6IzEjGL8pPkhVNwfXCsSqWG
         4arraIFBJHOjUi6gTBwNGW4A89Ec1HobF1Di6p/57yc1jXub7nWquoq5oivNfKwywgpP
         DzY4ohQcnS518J7qp5/ONUGJmIW7Zvun+mkzBpJstDwGhvZVRF0A80BLiOZ7pSaY2YxM
         irg+E7aXlFZuHFHvbvFQMtAav3Ks1wNc2fRvFGd1xWapRrNDOLZrodptOLbWQ2mJB27m
         gprv87ZQRxyOmXm+YMh0hDsc87BVOq9TwoVrWOJUrVU/UJ4Gg1NqgVKPV9+a+zR7B9IO
         lQyA==
X-Gm-Message-State: AOJu0YyhdEFSCwfb5W3uzDHpMMjOgHNdI1mzxKSHKA0M2a2L3bx9ATeg
	Lu1CY13WAwMtcdm6SgjkKS1yoZmHp/hUiCOdt8SV0o4rjxyU3Zhw1SogH+ORB2Y=
X-Google-Smtp-Source: AGHT+IEZ/KqmUwvewLOwkH82KgRvGrAEGvstYqbBA7/ivLIGKULeWJqsF5GQ/91QoJocp3L8w8ykDA==
X-Received: by 2002:a17:903:950:b0:1db:de79:8664 with SMTP id ma16-20020a170903095000b001dbde798664mr5417732plb.60.1709388811132;
        Sat, 02 Mar 2024 06:13:31 -0800 (PST)
Received: from desktop-cluster-2 ([137.132.216.132])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001dcac08a360sm5306328plw.175.2024.03.02.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 06:13:30 -0800 (PST)
Date: Sat, 2 Mar 2024 22:13:28 +0800
From: Han Xing Yi <hxingyi104@gmail.com>
To: willy@infradead.org, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] Xarray: Fix race in xa_get_order()
Message-ID: <ZeM0CBHF3mfz847s@desktop-cluster-2.tailce565.ts.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello! This is my first patch ever, so please bear with me if I make some rookie
mistakes. I've tried my best to follow the documentation :) 

KCSAN detects data-race in xa_get_order:1779 / xas_store:819. xas_store() uses
rcu_assign_pointer() for the slots pointer, but xa_get_order() does not
use rcu to access the same pointer, resulting in a value change from 
0x0000000000000000 -> 0xffffea0000488f00.

Use rcu_dereference() to access the rcu slots pointer in xa_get_order() to
avoid KCSAN warnings. 

Full bug report:
==================================================================
BUG: KCSAN: data-race in xa_get_order / xas_store

write (marked) to 0xffff88800b4cb150 of 8 bytes by task 239 on cpu 1:
 xas_store+0x6c8/0x11d0 lib/xarray.c:819
 __filemap_add_folio+0x61a/0xb30 mm/filemap.c:898
 filemap_add_folio+0x69/0x160 mm/filemap.c:937
 page_cache_ra_unbounded+0x134/0x3b0 mm/readahead.c:250
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0xc4/0xe0 mm/readahead.c:546
 do_sync_mmap_readahead mm/filemap.c:3150 [inline]
 filemap_fault+0xe45/0x1960 mm/filemap.c:3242
 __do_fault+0x8e/0x2c0 mm/memory.c:4266
 do_read_fault mm/memory.c:4629 [inline]
 do_fault mm/memory.c:4763 [inline]
 do_pte_missing mm/memory.c:3731 [inline]
 handle_pte_fault mm/memory.c:5039 [inline]
 __handle_mm_fault+0xd96/0x1df0 mm/memory.c:5180
 handle_mm_fault+0x227/0x6a0 mm/memory.c:5345
 do_user_addr_fault+0x2d5/0xf30 arch/x86/mm/fault.c:1364
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0xa9/0x330 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

read to 0xffff88800b4cb150 of 8 bytes by task 235 on cpu 0:
 xa_get_order+0x1a2/0x400 lib/xarray.c:1779
 __filemap_add_folio+0x44c/0xb30 mm/filemap.c:870
 filemap_add_folio+0x69/0x160 mm/filemap.c:937
 page_cache_ra_unbounded+0x134/0x3b0 mm/readahead.c:250
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0xc4/0xe0 mm/readahead.c:546
 do_sync_mmap_readahead mm/filemap.c:3150 [inline]
 filemap_fault+0xe45/0x1960 mm/filemap.c:3242
 __do_fault+0x8e/0x2c0 mm/memory.c:4266
 do_read_fault mm/memory.c:4629 [inline]
 do_fault mm/memory.c:4763 [inline]
 do_pte_missing mm/memory.c:3731 [inline]
 handle_pte_fault mm/memory.c:5039 [inline]
 __handle_mm_fault+0xd96/0x1df0 mm/memory.c:5180
 handle_mm_fault+0x227/0x6a0 mm/memory.c:5345
 do_user_addr_fault+0x2d5/0xf30 arch/x86/mm/fault.c:1364
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0xa9/0x330 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

value changed: 0x0000000000000000 -> 0xffffea0000488f00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 235 Comm: gcc Not tainted 6.7.0-g65c265174d11-dirty #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
==================================================================

Signed-off-by: Han Xing Yi <hxingyi104@gmail.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 39f07bfc4dcc..7fc225f3cf4e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1776,7 +1776,7 @@ int xa_get_order(struct xarray *xa, unsigned long index)
 
 		if (slot >= XA_CHUNK_SIZE)
 			break;
-		if (!xa_is_sibling(xas.xa_node->slots[slot]))
+		if (!xa_is_sibling(rcu_dereference(xas.xa_node->slots[slot])))
 			break;
 		order++;
 	}
-- 
2.34.1


