Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F34478FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhKHD5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 22:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhKHD5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 22:57:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0771AC061570;
        Sun,  7 Nov 2021 19:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v8Q8ulvpm7yX7aBB7IJwART33Yz4GSqkalLUmAdhO9c=; b=Uy7I0BkYpuJ1o4zu4Pm8NKvH/2
        tCk03XoCpSP4rVeYm+6NS+trSXq3J/MgZQFcBRIrnZHK447/NgWFX+2368IuheodtuMe1Bc232ErZ
        pLRGylXc9WHKLXBs3uGlLHmqTUEifkh6FTARE+zfdIQAG5Rp9uHEqP4LJzbhyt+1csLRat/wS+TpT
        NUgfS6wrQyjgIrs/FDJDEMJhjBRbyrN/7umBFq2P0RFvINtt33SVhLEYeZM8uxXXnxw5QSp+S22W9
        5q9nWPc/yQCW2rM0TmLAk3KwmK3x72ml+D1BvD7rtOJB4XSyitYXS+uxZQaqf+vOAdPLuj2uKxqwe
        z5ZCe1+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjvhQ-00899m-FR; Mon, 08 Nov 2021 03:52:28 +0000
Date:   Mon, 8 Nov 2021 03:52:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Wu Bo <wubo40@huawei.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] fs: direct-io: use DIV_ROUND_UP helper macro for
 calculations
Message-ID: <YYie4D0U59hurOOd@casper.infradead.org>
References: <1636341011-6494-1-git-send-email-wubo40@huawei.com>
 <3b7c6fa1183d4567403382ae8ba439dcea4b7e02.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7c6fa1183d4567403382ae8ba439dcea4b7e02.camel@perches.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 07, 2021 at 07:17:07PM -0800, Joe Perches wrote:
> If you are interested, there are definitely a few more opportunities
> to use this DIV_ROUND_UP macro in the kernel:
> 
> $ git grep -P -n '\(\s*([\w\.\>\[\]\-]+)\s*\+\s*([\w\.\>\[\]\-]+)\s*-\s*1\s*\)\s*/\s*(?:\1|\2)\b'
> arch/alpha/boot/tools/objstrip.c:260:	mem_size = ((mem_size + pad - 1) / pad) * pad;

Might want to exclude 'tools' ...

> tools/bpf/bpftool/gen.c:184:		align_off = (off + align - 1) / align * align;
> tools/io_uring/io_uring-bench.c:140:	return (DEPTH + s->nr_files - 1) / s->nr_files;
> tools/lib/bpf/linker.c:1115:	dst_align_sz = (dst->sec_sz + dst_align - 1) / dst_align * dst_align;
> tools/lib/subcmd/help.c:119:	rows = (cmds->cnt + cols - 1) / cols;
> tools/testing/selftests/bpf/prog_tests/core_reloc.c:804:	return (sz + page_size - 1) / page_size * page_size;
> tools/testing/selftests/bpf/prog_tests/mmap.c:13:	return (sz + page_size - 1) / page_size * page_size;
> tools/testing/selftests/net/forwarding/sch_red.sh:202:		local pkts=$(((diff + PKTSZ - 1) / PKTSZ))
> tools/vm/page-types.c:943:			size, (size + page_size - 1) / page_size);

... because most of these files won't have access to that macro.
Definitely compile-test before sending a patch.
