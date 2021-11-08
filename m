Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C644790D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhKHEFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:05:48 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:50062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235502AbhKHEFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:05:47 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6583E1010DF67;
        Mon,  8 Nov 2021 04:03:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 5720F18A60C;
        Mon,  8 Nov 2021 04:03:00 +0000 (UTC)
Message-ID: <d405db9dd4ff587093539a602c45a2aeb85db90c.camel@perches.com>
Subject: Re: [PATCH] fs: direct-io: use DIV_ROUND_UP helper macro for
 calculations
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wu Bo <wubo40@huawei.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Date:   Sun, 07 Nov 2021 20:02:59 -0800
In-Reply-To: <YYie4D0U59hurOOd@casper.infradead.org>
References: <1636341011-6494-1-git-send-email-wubo40@huawei.com>
         <3b7c6fa1183d4567403382ae8ba439dcea4b7e02.camel@perches.com>
         <YYie4D0U59hurOOd@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.25
X-Stat-Signature: z6m45bzpaqmq7mj5ade68bmwpe31jdax
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 5720F18A60C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/U21IkYUoZsjaivmPaxUhf0MAlvfim9b4=
X-HE-Tag: 1636344180-699605
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-08 at 03:52 +0000, Matthew Wilcox wrote:
> On Sun, Nov 07, 2021 at 07:17:07PM -0800, Joe Perches wrote:
> > If you are interested, there are definitely a few more opportunities
> > to use this DIV_ROUND_UP macro in the kernel:
> > 
> > $ git grep -P -n '\(\s*([\w\.\>\[\]\-]+)\s*\+\s*([\w\.\>\[\]\-]+)\s*-\s*1\s*\)\s*/\s*(?:\1|\2)\b'
> > arch/alpha/boot/tools/objstrip.c:260:	mem_size = ((mem_size + pad - 1) / pad) * pad;
> 
> Might want to exclude 'tools' ...
> 
> > tools/bpf/bpftool/gen.c:184:		align_off = (off + align - 1) / align * align;
> > tools/io_uring/io_uring-bench.c:140:	return (DEPTH + s->nr_files - 1) / s->nr_files;
> > tools/lib/bpf/linker.c:1115:	dst_align_sz = (dst->sec_sz + dst_align - 1) / dst_align * dst_align;
> > tools/lib/subcmd/help.c:119:	rows = (cmds->cnt + cols - 1) / cols;
> > tools/testing/selftests/bpf/prog_tests/core_reloc.c:804:	return (sz + page_size - 1) / page_size * page_size;
> > tools/testing/selftests/bpf/prog_tests/mmap.c:13:	return (sz + page_size - 1) / page_size * page_size;
> > tools/testing/selftests/net/forwarding/sch_red.sh:202:		local pkts=$(((diff + PKTSZ - 1) / PKTSZ))
> > tools/vm/page-types.c:943:			size, (size + page_size - 1) / page_size);
> 
> ... because most of these files won't have access to that macro.
> Definitely compile-test before sending a patch.

Always.

btw:

tools/include/linux/kernel.h:#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))


