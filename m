Return-Path: <linux-fsdevel+bounces-39093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D2A0C51B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C63A4289
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170A1F9F6A;
	Mon, 13 Jan 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFQcTB4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC61FA140;
	Mon, 13 Jan 2025 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809532; cv=none; b=VuAW81IsyxS2hYPyA1zGF3aFxmLAZyMjOeJ25P33uOkSq4RzhMc8a+vHAKg8GeAYLkJ5qkKC5tMgqHr9pkcsXMq0JpG6kuU/Lc+a4fXq7aNcISgi7+DCXhakRygYJgW5WG8PrHdkHGYXI87FN50Nrc3ff/+ZCKBoS5o2lBEHZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809532; c=relaxed/simple;
	bh=63sgJjzICDB/zQLV23GNFGJYs1slh00RiMwOPHExNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O33o1ZiME0coyeGKXBxE7ZggWHv98FR1zh/9TL8esW0rQmksoaNEV7gglFT2gsQOpHqUjTY985J+Cx7wOW/m7i480D10ZXLTopoHhCG2BuOb9/QGCdECXdWVqw2PqC8OSHt8bKfRlgVPRke7/xvnmCW2e3K6J++fheG6C1zVCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFQcTB4S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so70746445ad.2;
        Mon, 13 Jan 2025 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736809527; x=1737414327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFqUUj0QdJm5qDnw1Ljz6cwuPJ9cjiThS0ltMVoX+yw=;
        b=nFQcTB4S52EYfFj9AEnvhhGhD6d+E2XiyFlXSmd6Xzy1+bt0URo9Ss3+qvqhCSsI/p
         e8NuKrACoMS2RG6q1mBkQ2O8DAomDq0s+0+joZHIpRd4b66EmoHlyWOO+TG4Fw+KFwYN
         CQYPtSHpl8onFGpfLRAnDOy4f0q2NW2HnwG+kV7kc4wAU26tGN9NNn6HxzPxaunbj5Gy
         2BLhQaGcAUiPadFwJCyZGQUcVeS9bcYpOqjHwzhT3lgx9bRQZ9djM2UGtBO5vEfdIJmw
         q1fMSPsggRmk4JaZK0/E/WAXyflt7OJlGZ44VjES8f15we8aEM1lsYsh9S6w7FQFEy9R
         He+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736809527; x=1737414327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFqUUj0QdJm5qDnw1Ljz6cwuPJ9cjiThS0ltMVoX+yw=;
        b=u8WRfROnpNDxVWqUZZqjbqSFib3XN59G19SPIFkSTbDoK+cB9LeUii/y7gqLUQayGq
         AKMWV//DBcBYnPZO+aRtrVI35sJRHdCbv9aPdekNHsDuM4BkZMVo8aUAt8AUAbos1oUi
         6HN3gGneia7brgIJ+W84nM/w2CNOcO8EfdoKED0p//hRNxkvZ7dNWt3z+xFzrBjmkbO7
         KfWNvihzQ7nRlWluEbawRW6zDJJ/OTAzHoxWfrmmCO5NTGA0mI63niJfxpqQ5p2zDnBu
         2kpiK7fwXpDThbVDspiaxTqdEy3bT9KePTOinhN2PwxbtA16i2LoJUcm4sVoIIHdmoVC
         h6YA==
X-Forwarded-Encrypted: i=1; AJvYcCV+LVB3m9v471iKZSnMO/b+/pDlcWgciFaoSYMhpjCSzXlMWX7ry+GIIRAJRLIrVhoY8aB9ihpKIIu7POJJ@vger.kernel.org, AJvYcCW2GsFMFl2pEYhDcKGhFGRd0KDbIDVODl5A7hAqJOBvpoByN4yuezGNsBpYNxM0tti+7ApsGoBGm6fLIp+c@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+2lSOM0KliBjW+aY6sj9qijHJ5UiuDiSYLoe01b8YB3zCca6
	18gGTTTbk4WjpwJ7qAodmPU0tFiRNSTM8ATuJ7uFWln07WEz9eQe
X-Gm-Gg: ASbGncuZHfavX068fNiBZvOacQt7vxWLXgbvQuZcg2z392m5FWEpTJtVsiAK8sWSDyh
	S8BvDl/fnOtI9pWui9UzftqAXZpH9VyRYKJ6mgr52m6d2WbcwMNBC+Bo9v0Cd4fshSSy+vL4o3w
	2Q3J9OtVhc5c8Xpv17K+qnZAoLOSpdqC0oIa7N/oUNCAkszaPuQTm1okpdfESJsmEz2xgO1o65B
	EyCf6gQIjoxPl7x9Q3Nx6k2GF6U/Ljb4PWY7O58SqCPRU7hjXz/yp2gWZVQQSqti5EpKw==
X-Google-Smtp-Source: AGHT+IHidRxLfx9LKAF+iL7/QFF6Aokz8jo+zl8xaP4Z/8iOx+uE5qFFxQWorjB4unFdbZwqR7d1sg==
X-Received: by 2002:a05:6a00:39a6:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72d21ff524emr31835408b3a.16.1736809527288;
        Mon, 13 Jan 2025 15:05:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm6671191b3a.173.2025.01.13.15.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 15:05:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Jan 2025 15:05:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121100539.605818-1-jimzhao.ai@gmail.com>

Hi,

On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
> Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
> write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
> The wb_thresh bumping logic is scattered across wb_position_ratio,
> __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
> consolidate all wb_thresh bumping logic into __wb_calc_thresh.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>

This patch triggers a boot failure with one of my 'sheb' boot tests.
It is seen when trying to boot from flash (mtd). The log says

...
Starting network: 8139cp 0000:00:02.0 eth0: link down
udhcpc: started, v1.33.0
EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
udhcpc: sending discover
udhcpc: sending discover
udhcpc: sending discover
EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
udhcpc: no lease, failing
FAIL
/etc/init.d/S55runtest: line 29: awk: Permission denied
Found console ttySC1
/etc/init.d/S55runtest: line 45: awk: Permission denied
can't run '/sbin/getty': No such device or address

and boot stalls from there. There is no obvious kernel log message
associated with the problem. Reverting this patch fixes the problem.

Bisect log is attached for reference.

Guenter

---
# bad: [37136bf5c3a6f6b686d74f41837a6406bec6b7bc] Add linux-next specific files for 20250113
# good: [9d89551994a430b50c4fffcb1e617a057fa76e20] Linux 6.13-rc6
git bisect start 'HEAD~1' 'v6.13-rc6'
# bad: [25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038
# bad: [435091688c6715e614213d84b1426dfb86fb1c11] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
git bisect bad 435091688c6715e614213d84b1426dfb86fb1c11
# bad: [51bdf4c7090c8ab260e3a7e7ddaa5d9a7303f541] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
git bisect bad 51bdf4c7090c8ab260e3a7e7ddaa5d9a7303f541
# bad: [972ccc84da30e3fbab197c91caa10fbb04e487c8] foo
git bisect bad 972ccc84da30e3fbab197c91caa10fbb04e487c8
# bad: [243dd93e678dd4638b1005a13b085c3c5439447c] mm, swap: simplify percpu cluster updating
git bisect bad 243dd93e678dd4638b1005a13b085c3c5439447c
# bad: [09a3762697e810e311af23d10d79587da440e9dd] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
git bisect bad 09a3762697e810e311af23d10d79587da440e9dd
# bad: [6976848d304ef960e5ac5032611cfd8a9b1b6b01] docs: tmpfs: update the large folios policy for tmpfs and shmem
git bisect bad 6976848d304ef960e5ac5032611cfd8a9b1b6b01
# good: [1d3d61aef8467ce44ab3a06e6a0e3fcd930590a7] mailmap, docs: update email to carlos.bilbao@kernel.org
git bisect good 1d3d61aef8467ce44ab3a06e6a0e3fcd930590a7
# good: [4d9d1429f6deb91c66591074bbd8ca6aa4cba4dc] mm/page_alloc: move set_page_refcounted() to end of __alloc_pages()
git bisect good 4d9d1429f6deb91c66591074bbd8ca6aa4cba4dc
# good: [c1bc8fd460ebce85d7a768d8226861438e28bd53] mm: pgtable: make ptep_clear() non-atomic
git bisect good c1bc8fd460ebce85d7a768d8226861438e28bd53
# bad: [f8db55561f1b5c70ba2dd260206f295ffee9d1c9] kasan: make kasan_record_aux_stack_noalloc() the default behaviour
git bisect bad f8db55561f1b5c70ba2dd260206f295ffee9d1c9
# bad: [a82412684eaeda1ef8201472107de6a40843beec] mm: change type of cma_area_count to unsigned int
git bisect bad a82412684eaeda1ef8201472107de6a40843beec
# bad: [fcd31b7c35949323434d50416f896bc881a5c397] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh
git bisect bad fcd31b7c35949323434d50416f896bc881a5c397
# first bad commit: [fcd31b7c35949323434d50416f896bc881a5c397] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh

