Return-Path: <linux-fsdevel+bounces-58202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DBB2B0A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8183684687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61C271A71;
	Mon, 18 Aug 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHc6nVs+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209592594BE;
	Mon, 18 Aug 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542474; cv=none; b=XCecmVSO5J6NYEVd4ZOuqIGkcgcpdOspws7UByE13a954co6nlvpp0uJFqZQLp56J0shTHUSil5xgMF7MbnjAuo2b2UWi2ox9CQoX9CZHYJK4VzLACCPu/JJM0z2l7LcSXpVdMk6bBGC0fGKWlYbu6HRMPcIvjrYAE+9SRmaanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542474; c=relaxed/simple;
	bh=Es4yaf72SaShjHymooelegarDXtAiknkXgOn9COzJPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffGyen4ZRpvFYuvM0heeklY/5zwZk8OzkhMjP/yu/ISKtMaJMwMzwkm93IR8V0sXuhVRsNsAPVkwo6MSBzV8ZdONuxy9ZYUzodCNp5Shk6VGKRVEdv9US3C/DQ3DJW1r7oDKYyreoFAg+0//+3hXdF7xgelBKSTAG37fHWQTI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHc6nVs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B67C4CEED;
	Mon, 18 Aug 2025 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542473;
	bh=Es4yaf72SaShjHymooelegarDXtAiknkXgOn9COzJPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHc6nVs+etePKLBgZwSTnHPQ2YvJGw38oXbY0k12qsnm+CkLms9GBoMMN+mR3gcko
	 uHqg7VaBxpwYX0Vl+EoAtPwa7aFRok0UOU45kz8I43+xCLKaUmDPdty8N6IIuAMA5w
	 lZlseYvEmvZZJpOeVw1CxyD2IcrcRewheFq4Jt90jnbp1j6vaBR94ZL4uT+8q2NW2C
	 iKRH0w0z4xB49mOxjdh6n8Wu/SyzA0DzeE7PjakdqOda/9opyE0bw94yr6da0RbZ7k
	 uA3Qr52bP5fM6n5DX1EX+Mv72FDiegT91p6EML2+MDe9P9vH2/QAfuQV/aI3zTmGj+
	 4Jr715ssV/Xkw==
Date: Mon, 18 Aug 2025 20:40:29 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 1/7] gen_init_cpio: write to fd instead of stdout
 stream
Message-ID: <aKNznfmKOuMzCPzg@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
 <20250814054818.7266-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-2-ddiss@suse.de>

On Thu, Aug 14, 2025 at 03:17:59PM +1000, David Disseldorp wrote:
> In preparation for more efficient archiving using copy_file_range(),
> switch from writing archive data to stdout to using STDOUT_FILENO and
> I/O via write(), dprintf(), etc.
> Basic I/O error handling is added to cover cases such as ENOSPC. Partial
> writes are treated as errors.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  usr/gen_init_cpio.c | 139 ++++++++++++++++++++++++++------------------
>  1 file changed, 81 insertions(+), 58 deletions(-)
> 
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index edcdb8abfa31c..d8779fe4b8f1f 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
[...]
> @@ -96,23 +103,24 @@ static void cpio_trailer(void)
>  		0,			/* rminor */
>  		(unsigned)strlen(name)+1, /* namesize */
>  		0);			/* chksum */
> -	push_hdr(s);
> -	push_rest(name);
> +	offset += len;
>  
> -	while (offset % 512) {
> -		putchar(0);
> -		offset++;
> -	}
> +	if (len != CPIO_HDR_LEN
> +	 || push_rest(name) < 0
> +	 || push_pad(padlen(offset, 512)) < 0)


Thanks, patch looks good to me.

Just a minor coding style bike shedding: Starting continuation lines
with '||' seems to be rather unusual in Linux code:

    $ git grep -Ee '^\s*(\|\||&&)' **/*.c | wc -l
    64
    $ git grep -Ee '(\|\||&&)$' **/*.c | wc -l
    2553

Kind regards,
Nicolas

