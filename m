Return-Path: <linux-fsdevel+bounces-13256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09186DE96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45451C20D63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C2C6A8C9;
	Fri,  1 Mar 2024 09:51:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDA6995C;
	Fri,  1 Mar 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286686; cv=none; b=kLz9yNTPmjS7bsUORvbu0yNAu/mEsmfXoiJUTqTexh8srPmeA3hrgG3vQrJa0ipmiE5e20Vigs1grmjtFbEpu+ls/ZyNZxaSUNKlUDpTWbv54BDCQwIdwAkiWvSqpxGSmCQL/JvGe43Y/BMRQIXZwE69tYhx4FyGq3sWiBbSkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286686; c=relaxed/simple;
	bh=IXPS1YTOuSXz2bhI7nEjXLQQJhT3X+YyX8FgPiHLd2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvsW3yISRazAi5bfZo5JkODacgjBb5P9Z1YdZpoJG4cynJfxQhV8N2JG0XMLR5fhy1xA9lSlvsmuGqs8huDudQ9iAZjmyS2Eh2q9wdjkpRmuwYpEyJlyW/QnbWHud5WaZQer9Kp7359QlxLIbyyU1X/+m1Mpx5caN1d+96oBPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7515F1FB;
	Fri,  1 Mar 2024 01:52:02 -0800 (PST)
Received: from [10.57.10.152] (unknown [10.57.10.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474DD3F762;
	Fri,  1 Mar 2024 01:51:21 -0800 (PST)
Message-ID: <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
Date: Fri, 1 Mar 2024 09:51:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
Content-Language: en-US
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240226205534.1603748-9-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/02/2024 20:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It is used to test split_huge_page_to_list_to_order for pagecache THPs.
> Also add test cases for split_huge_page_to_list_to_order via both
> debugfs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c                              |  34 ++++--
>  .../selftests/mm/split_huge_page_test.c       | 115 +++++++++++++++++-
>  2 files changed, 131 insertions(+), 18 deletions(-)
> 

Hi Zi,

When booting the kernel against next-master(20240228)with Arm64 on
Marvell Thunder X2 (TX2), the kselftest-mm test 'split_huge_page_test'
is failing in our CI (with rootfs over NFS). I can send the full logs if
required.

A bisect (full log below) identified this patch as introducing the
failure. Bisected it on the tag "next-20240228" at repo
"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".

This works fine on  Linux version 6.8.0-rc6


Sample log from failure against run on TX2:
------
07:17:34.056125  # # ------------------------------
07:17:34.056543  # # running ./split_huge_page_test
07:17:34.056839  # # ------------------------------
07:17:34.057114  # # TAP version 13
07:17:34.058564  # # 1..12
07:17:34.156822  # # ok 1 Split huge pages successful
07:17:34.214074  # # ok 2 Split PTE-mapped huge pages successful
07:17:34.215630  # # # Please enable pr_debug in
split_huge_pages_in_file() for more info.
07:17:34.225503  # # # Please check dmesg for more information
07:17:34.225862  # # ok 3 File-backed THP split test done
07:17:34.236944  # # Bail out! Failed to create a file at /mnt/thp_fs#
Planned tests != run tests (12 != 3)
07:17:34.237307  # # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
07:17:34.237620  # # [FAIL]
07:17:34.246430  # not ok 51 split_huge_page_test # exit=1


Bisect log:
------
git bisect start
# good: [d206a76d7d2726f3b096037f2079ce0bd3ba329b] Linux 6.8-rc6
git bisect good d206a76d7d2726f3b096037f2079ce0bd3ba329b
# bad: [20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e] Add linux-next
specific files for 20240228
git bisect bad 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
# bad: [1322f1801e59dddce10591d602d246c1bf49990c] Merge branch 'main' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 1322f1801e59dddce10591d602d246c1bf49990c
# bad: [a82f70041487790b7b09fe4bb45436e1b57021d3] Merge branch 'dev' of
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
git bisect bad a82f70041487790b7b09fe4bb45436e1b57021d3
# bad: [ce90480b9352ba2bebe8946dad9223e3f24c6e9a] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git bisect bad ce90480b9352ba2bebe8946dad9223e3f24c6e9a
# bad: [5daac92ed3881fd0c656478a301a4e1d124100ee] Merge branch
'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 5daac92ed3881fd0c656478a301a4e1d124100ee
# good: [acc2643d9e988c63dd4629a9af380ad9ac69c54a] Merge branch
'mm-stable' into mm-unstable
git bisect good acc2643d9e988c63dd4629a9af380ad9ac69c54a
# good: [0294de8fe7d7c1a7eddc979cbf4c1886406e36b7] Merge branch 'fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect good 0294de8fe7d7c1a7eddc979cbf4c1886406e36b7
# good: [83e0c8f0e777a1ef0977b2f8189101765703b32d] Merge branch
'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 83e0c8f0e777a1ef0977b2f8189101765703b32d
# good: [a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93] mm: memcg: make memcg
huge page split support any order split
git bisect good a739cbe236e0dd3b6ff26a01fa1d31c73d4fac93
# bad: [efb520aa333b2f11daaaaa13f4a598b5ae4ae823] mm: allow non-hugetlb
large folios to be batch processed
git bisect bad efb520aa333b2f11daaaaa13f4a598b5ae4ae823
# bad: [2258bdebb55e3ad3d30fd3849ddb955ff36825de] mm/zsmalloc: don't
hold locks of all pages when free_zspage()
git bisect bad 2258bdebb55e3ad3d30fd3849ddb955ff36825de
# bad: [7fc0be45acf2878cbacc4dba56923c34c3fd8b1e] mm: remove
total_mapcount()
git bisect bad 7fc0be45acf2878cbacc4dba56923c34c3fd8b1e
# good: [d55fac55da2f87ad5a99178e107df09770bbc411] mm: thp: split huge
page to any lower order pages
git bisect good d55fac55da2f87ad5a99178e107df09770bbc411
# bad: [4050d591c1aaf9336c08511fa5984827186e9ad1] mm/memfd: refactor
memfd_tag_pins() and memfd_wait_for_pins()
git bisect bad 4050d591c1aaf9336c08511fa5984827186e9ad1
# bad: [c0ba89c29ef559c95273feb481b049f622c43c17] mm: huge_memory:
enable debugfs to split huge pages to any order
git bisect bad c0ba89c29ef559c95273feb481b049f622c43c17
# first bad commit: [c0ba89c29ef559c95273feb481b049f622c43c17] mm:
huge_memory: enable debugfs to split huge pages to any order


Thanks,
Aishwarya

