Return-Path: <linux-fsdevel+bounces-4883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A0805770
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764E11F212B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAC67E65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtRBCOvJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB2CA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L8mYWXxlrXgsupSH2CXY7CTcm1b3JYzDyxWKSKXE7AQ=; b=VtRBCOvJXZaOm0qCWZ4nx2bDii
	OPYq0DP2A12j2OePosp4jQM0Z7MjE3XV1F4ZdK8atNcK+Xxws65+IYna4ScmREFXFqiQo/NoHLQ4H
	jz9sqnVk7EPlJE6m8OzVuIsquNq6VQgKf+mGKhimpM+RAHWcz4+gIdEEn+ebfFPf0Jv9babTiNN7d
	Blh6f7VdRocV+uUMo590Y94r/VfRnXRdvrNyAHQg9E3vYFQ0fmRc8ghCAXyt59HIcU+r1VyFrxYe/
	mvvHMWCHvstddPypXhb62ZrstUsMFMBPxhBGah73uK+OS+5x1tWQCoizOSc01z0SCdJnhP/AvYlG8
	RjxNh0rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAWUp-001xqw-Gb; Tue, 05 Dec 2023 14:33:59 +0000
Date: Tue, 5 Dec 2023 14:33:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Sanpe <sanpeqf@gmail.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com, cpgs@samsung.com
Subject: Re: [PATCH v2] exfat/balloc: using hweight instead of internal logic
Message-ID: <ZW80126YNGftY9io@casper.infradead.org>
References: <20231205043305.1557624-1-sanpeqf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205043305.1557624-1-sanpeqf@gmail.com>

On Tue, Dec 05, 2023 at 12:33:05PM +0800, John Sanpe wrote:
> Replace the internal table lookup algorithm with the hweight
> library, which has instruction set acceleration capabilities.
> 
> Use it to increase the length of a single calculation of
> the exfat_find_free_bitmap function to the long type.

Have you run sparse over this?  "make C=2" will do it for you if you
have sparse installed.  I think it's going to complain about missing
endianness annotations.

> +	for (i = 0; i < total_clus; i += BITS_PER_LONG) {
> +		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
> +		clu_bits = lel_to_cpu(*bitmap);

I understand why you need to byteswap at the end, but I don't understand
why you need to byteswap here.  You're asking how many bits are set,
and that's the same answer no matter whether you calculate it on
0x12345678 or on 0x78563412.

> +++ b/fs/exfat/exfat_fs.h
> @@ -136,6 +136,7 @@ enum {
>  #define BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent) \
>  	((ent / BITS_PER_BYTE) & ((sb)->s_blocksize - 1))
>  #define BITS_PER_BYTE_MASK	0x7
> +#define BITS_PER_LONG_MASK	(BITS_PER_LONG - 1)

I don't think this adds any value over just using (BITS_PER_LONG - 1)
directly.

