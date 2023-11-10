Return-Path: <linux-fsdevel+bounces-2725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8147E7C96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 14:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4A5B20F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9F1A262;
	Fri, 10 Nov 2023 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0mmhS55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BA19BB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 13:36:36 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9025A1D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 05:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=B/F6hY1U39mXEKW+6DLmtd5vO+5xmpcWERvWomUCoDc=; b=U0mmhS55AAKwyr4zCCdpWCl6Bg
	Ag09Z2QhICgLq72ntwHfOCgKHkPdMH2EdC9yvLVvnSdb1QHFSZ5gwIZU/aIVIn8A7syYZTFL9cmHQ
	/bm0WevEqiDlFSxSXM3gBEWgTbCYZc94ZxnRakpT/MCktbDfBMBte4HrZBbtjMnD06WgbhVWTbg4T
	dethwrZD73+PgOehkJEAmmDEpdL/l8X1CKX4TCBtHiW4Fi+KVHsXV+AN9GsErjiTEP1hRLW2qCNCt
	R7Id3YA4X0u0QJdwr1EIOHmPV6YRs9QcpyshqSWQZopx85vn4nICVxX6NQsb5y9CNnHKGKXkCtPWZ
	88hLnZ0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1RgS-00Dgu9-WF; Fri, 10 Nov 2023 13:36:29 +0000
Date: Fri, 10 Nov 2023 13:36:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] buffer: Fix various functions for block size >
 PAGE_SIZE
Message-ID: <ZU4x3IAGmLx457p0@casper.infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-6-willy@infradead.org>
 <CAKFNMokuZFWqoX_1uWm0-vTcbo_gESkNpv8J8Pw1G-Vwd=-D+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMokuZFWqoX_1uWm0-vTcbo_gESkNpv8J8Pw1G-Vwd=-D+w@mail.gmail.com>

On Fri, Nov 10, 2023 at 04:48:02PM +0900, Ryusuke Konishi wrote:
> On Fri, Nov 10, 2023 at 6:06 AM Matthew Wilcox (Oracle) wrote:
> > +++ b/fs/buffer.c
> > @@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
> >         int all_mapped = 1;
> >         static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
> >
> > -       index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
> > +       index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
> 
> Multiple 64-bit divisions are used in this patch, but why not use two
> stage shifts as shown below if there is no left shift overflow and the
> sign bit will not be set ?
> 
>        index = ((loff_t)block << bd_inode->i_blkbits) >> PAGE_SHIFT;

Here's what the compiler turns that into:

    3223:       49 8b 86 80 00 00 00    mov    0x80(%r14),%rax
    322a:       4c 89 ee                mov    %r13,%rsi
    322d:       ba 01 00 00 00          mov    $0x1,%edx
    3232:       0f b6 88 c2 00 00 00    movzbl 0xc2(%rax),%ecx
^ this is where we load i_blkbits into ecx
    3239:       48 89 45 d0             mov    %rax,-0x30(%rbp)
    323d:       4c 8b 60 30             mov    0x30(%rax),%r12
    3241:       48 d3 e6                shl    %cl,%rsi
^ shift left by %cl (the bottom byte of ecx)
    3244:       31 c9                   xor    %ecx,%ecx
    3246:       48 c1 ee 0c             shr    $0xc,%rsi
^ shift right by 12
    324a:       4c 89 e7                mov    %r12,%rdi
    324d:       e8 00 00 00 00          call   3252 <__find_get_block+0x82>
                        324e: R_X86_64_PLT32    __filemap_get_folio-0x4


