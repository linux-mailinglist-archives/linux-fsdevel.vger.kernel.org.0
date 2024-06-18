Return-Path: <linux-fsdevel+bounces-21897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA790DCDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 21:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CA31F242F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4816DC3F;
	Tue, 18 Jun 2024 19:53:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379E210EC;
	Tue, 18 Jun 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740403; cv=none; b=sj5csMur9l/+cK46TQ8aLCNcjPAW5uBhFYhtgVo7S7GTVPA+Ivy0EDq22/enZ8W/AzimrYzaVFgGmXxYAT2qKu49Zqp147HrVRwZDOoBCIDxsBm9EaopF3dIqpWmOoXTyg3WuYLS1ZSiRNsMNvLh+6x5Nner9pwoseLj7NGH9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740403; c=relaxed/simple;
	bh=eWNldh0fA+vF6SNTZKoJB9VnUA+3nIeMmjPBFEBYAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLSj/Vl/cESrqhUkMa+zYhd94SkYEUS2qmufkwivK6EP2PlY+NPawSIROOzyyaHQkfokhBgtY9k1N76/oM6xdyGPCXNlLUs3xwyraSFgM5/qWy15Z0g1M+7UL5uYBHL+3b6I1Ar6fgoAn1B428KIsCgsv3ON/RF3pfL1oT/uxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09AFC4AF1A;
	Tue, 18 Jun 2024 19:53:21 +0000 (UTC)
Date: Tue, 18 Jun 2024 15:53:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Takaya Saeki <takayas@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa
 <uekawa@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and
 fault
Message-ID: <20240618155320.75807db5@rorschach.local.home>
In-Reply-To: <20240618093656.1944210-1-takayas@chromium.org>
References: <20240618093656.1944210-1-takayas@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 09:36:56 +0000
Takaya Saeki <takayas@chromium.org> wrote:

> To allow precise tracking of page caches accessed, add new tracepoints
> that trigger when a process actually accesses them.
> 
> The ureadahead program used by ChromeOS traces the disk access of
> programs as they start up at boot up. It uses mincore(2) or the
> 'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
> this information in a "pack" file and on subsequent boots, it will read
> the pack file and call readahead(2) on the information so that disk
> storage can be loaded into RAM before the applications actually need it.
> 
> A problem we see is that due to the kernel's readahead algorithm that
> can aggressively pull in more data than needed (to try and accomplish
> the same goal) and this data is also recorded. The end result is that
> the pack file contains a lot of pages on disk that are never actually
> used. Calling readahead(2) on these unused pages can slow down the
> system boot up times.
> 
> To solve this, add 3 new trace events, get_pages, map_pages, and fault.
> These will be used to trace the pages are not only pulled in from disk,
> but are actually used by the application. Only those pages will be
> stored in the pack file, and this helps out the performance of boot up.
> 
> With the combination of these 3 new trace events and
> mm_filemap_add_to_page_cache, we observed a reduction in the pack file
> by 7.3% - 20% on ChromeOS varying by device.
> 
> Signed-off-by: Takaya Saeki <takayas@chromium.org>

Thanks Takaya.

I just applied this and ran:

 # trace-cmd start -e filemap

did a less and then:

 # trace-cmd show | grep less-901 | grep 13f730
            less-901     [005] .....    72.531607: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bad ofs=0 order=0
            less-901     [005] .....    72.531613: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bcc ofs=4096 order=0
            less-901     [005] .....    72.531617: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113b19 ofs=8192 order=0
            less-901     [005] .....    72.531620: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x114970 ofs=12288 order=0
            less-901     [005] .....    72.532039: mm_filemap_get_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=4096
            less-901     [005] .....    72.532104: mm_filemap_get_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=4096
            less-901     [005] .....    72.532107: mm_filemap_get_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=4096
            less-901     [005] .....    72.532497: mm_filemap_fault: dev 253:3 ino 13f730 ofs=196608
            less-901     [005] .....    72.532503: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x111232 ofs=131072 order=0
            less-901     [005] .....    72.532505: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x110099 ofs=135168 order=0
            less-901     [005] .....    72.532506: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11496b ofs=139264 order=0
            less-901     [005] .....    72.532509: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x10b061 ofs=143360 order=0
            less-901     [005] .....    72.532511: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x111230 ofs=147456 order=0
            less-901     [005] .....    72.532512: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x110c88 ofs=151552 order=0
            less-901     [005] .....    72.532515: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1119ef ofs=155648 order=0
            less-901     [005] .....    72.532518: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x111b49 ofs=159744 order=0
            less-901     [005] .....    72.532519: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11498b ofs=163840 order=0
            less-901     [005] .....    72.532521: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1149ab ofs=167936 order=0
            less-901     [005] .....    72.532523: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bcb ofs=172032 order=0
            less-901     [005] .....    72.532525: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1119f3 ofs=176128 order=0
            less-901     [005] .....    72.532527: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1171d0 ofs=180224 order=0
            less-901     [005] .....    72.532529: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x112ae7 ofs=184320 order=0
            less-901     [005] .....    72.532531: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bc0 ofs=188416 order=0
            less-901     [005] .....    72.532534: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x111ad8 ofs=192512 order=0
            less-901     [005] .....    72.532535: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1149b6 ofs=196608 order=0

I'm guessing the above is the kernel "readahead" kicking in.

            less-901     [005] .....    72.533002: mm_filemap_fault: dev 253:3 ino 13f730 ofs=196608
            less-901     [005] .....    72.533237: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=16384
            less-901     [005] .....    72.533245: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=176128 max_ofs=196608
            less-901     [005] .....    72.533644: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=16384
            less-901     [005] .....    72.533644: mm_filemap_fault: dev 253:3 ino 13f730 ofs=4096
            less-901     [005] .....    72.533652: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x110d59 ofs=16384 order=0
            less-901     [005] .....    72.533655: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1149a4 ofs=20480 order=0
            less-901     [005] .....    72.533658: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11498c ofs=24576 order=0
            less-901     [005] .....    72.533661: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x114969 ofs=28672 order=0
            less-901     [005] .....    72.533663: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11496c ofs=32768 order=0
            less-901     [005] .....    72.533666: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bc8 ofs=36864 order=0
            less-901     [005] .....    72.533668: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113b23 ofs=40960 order=0
            less-901     [005] .....    72.533671: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11497f ofs=45056 order=0
            less-901     [005] .....    72.533674: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x114981 ofs=49152 order=0
            less-901     [005] .....    72.533676: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x114983 ofs=53248 order=0
            less-901     [005] .....    72.533679: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11124e ofs=57344 order=0
            less-901     [005] .....    72.533682: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x114d97 ofs=61440 order=0
            less-901     [005] .....    72.533684: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x113bbe ofs=65536 order=0
            less-901     [005] .....    72.533687: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1161ff ofs=69632 order=0
            less-901     [005] .....    72.533690: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11622f ofs=73728 order=0
            less-901     [005] .....    72.533692: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116554 ofs=77824 order=0
            less-901     [005] .....    72.533695: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116553 ofs=81920 order=0
            less-901     [005] .....    72.533698: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11626d ofs=86016 order=0
            less-901     [005] .....    72.533700: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11621f ofs=90112 order=0
            less-901     [005] .....    72.533703: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116564 ofs=94208 order=0
            less-901     [005] .....    72.533706: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116582 ofs=98304 order=0
            less-901     [005] .....    72.533708: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116580 ofs=102400 order=0
            less-901     [005] .....    72.533713: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11657e ofs=106496 order=0
            less-901     [005] .....    72.533716: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x11657d ofs=110592 order=0
            less-901     [005] .....    72.533718: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116237 ofs=114688 order=0
            less-901     [005] .....    72.533721: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1162a1 ofs=118784 order=0
            less-901     [005] .....    72.533724: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x116569 ofs=122880 order=0
            less-901     [005] .....    72.533726: mm_filemap_add_to_page_cache: dev 253:3 ino 13f730 pfn=0x1161fc ofs=126976 order=0

Same here.

            less-901     [005] .....    72.533769: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=16384
            less-901     [005] .....    72.534352: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=16384
            less-901     [005] .....    72.534354: mm_filemap_fault: dev 253:3 ino 13f730 ofs=16384
            less-901     [005] .....    72.534358: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=0 max_ofs=16384
            less-901     [005] .....    72.534580: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=20480 max_ofs=81920
            less-901     [005] .....    72.534611: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=126976 max_ofs=172032
            less-901     [005] .....    72.534630: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=32768 max_ofs=94208
            less-901     [005] .....    72.534715: mm_filemap_map_pages: dev 253:3 ino 13f730 ofs=98304 max_ofs=122880

Just to get some numbers:

 # trace-cmd show |grep less-901 | grep 13f730 | cut -d: -f2- |grep add_to_page | sort -u |wc -l
 49

 # trace-cmd show |grep less-901 | grep 13f730 | cut -d: -f2- |grep fault | sort -u |wc -l
 3

 # trace-cmd show |grep less-901 | grep 13f730 | cut -d: -f2- |grep get_pages | sort -u |wc -l
 1

 # trace-cmd show |grep less-901 | grep 13f730 | cut -d: -f2- |grep map_pages | sort -u |wc -l
 6

Note, ureadahead ignores duplicate pages.

If these new events really do only show what is used and not what is
just pulled in, and doesn't miss anything, I can see it bringing down
the number of pages needed to be saved dramatically.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

