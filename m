Return-Path: <linux-fsdevel+bounces-4688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2D801E7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 21:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CDE280D19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28F18047
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDJlzbWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FFC119;
	Sat,  2 Dec 2023 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=17v8pwtEO/9J4h+31aN7yWQ25FC4gANK2/bSdLAYPAE=; b=jDJlzbWvQenbWgKJqXxA+N8i1c
	iSZBWulz0POYLy/Kwj/tCqG0pTBoeXOVvyiFJ46htqAHd2me9MM5UJGk3Fol/W+FgjeLmlyuKcIZ7
	z7XAOeQ3i+z6nglG3Pbt2qZWjjOFX2QUU3yCDVrLmg0Yezcl40rm/Wk165vGa+zdYiMK0TysBT1sm
	qGcRH1Ti/SDAj3idiOfUIbiI5VgrI8RK9qjfmUWGRt2JxfWZxIwcDkd4sqsX3IUU10gXlVDEqsEZl
	9EdATz7UNyvSQV1NMfRJLxcylgNs1ZqswM4KBYLuzuJMpz25ex4mHYqmE5EXeGX3VltSC3ZviPICv
	LVhxBmDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r9VFS-00GhRF-9D; Sat, 02 Dec 2023 19:01:54 +0000
Date: Sat, 2 Dec 2023 19:01:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: attreyee-muk <tintinm2017@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Tried making changes
Message-ID: <ZWt/IpxyUu+4+bxE@casper.infradead.org>
References: <20231202043859.356901-1-tintinm2017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202043859.356901-1-tintinm2017@gmail.com>

On Sat, Dec 02, 2023 at 10:09:00AM +0530, attreyee-muk wrote:
> Respected Maintainers, 
> 
> I have tried to solve the bug - UBSAN: shift-out-of-bounds in exfat_fill_super, reported by Syzbot [link - https://syzkaller.appspot.com/bug?extid=d33808a177641a02213e]

Hi Attreyee,

Working on syzbot reports is quite an art.  The important thing to know
for solving this one is that syzbot will fuzz filesystems.  That is, it
will start with a valid filesystem and change bits on disk, then see if
that creates any issues.

> The issue is in line 503 of fs/exfat/super.c - by analyzing the code, I
> understood that the it is checking if the calculated size of the exFAT
> File Allocation Table is very small as compared to the expected
> size,based on the number of clusters. If the condition is met, then an
> error will be logged. But here inside the if statement, I believe that
> the value of number of bits in sbi->num_FAT_sectors ,at some point is
> coming more than the value of p_boot->sect_size_bits. As a result, a
> shift-out-of-bounds error is being generated. 

No, that's not what's happening in this report.  p_boot->sect_size_bits
somehow has value 97.  And it's Undefined Behaviour in C to shift by more
than the number of bits in the type.  But I don't see how that happens:

fs/exfat/exfat_raw.h:#define EXFAT_MAX_SECT_SIZE_BITS           12

        if (p_boot->sect_size_bits < EXFAT_MIN_SECT_SIZE_BITS ||
            p_boot->sect_size_bits > EXFAT_MAX_SECT_SIZE_BITS) {

so something weird has happened; probably there's some other bug
somewhere else that has caused p_boot to be corrupted.  Whatever it is,
it's unlikely that you'll be able to find it.  Probably this is why
there's no reproducer.


