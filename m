Return-Path: <linux-fsdevel+bounces-32074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1839A040D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AC62852BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346C1CBA1B;
	Wed, 16 Oct 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfpNQFPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D34C8C;
	Wed, 16 Oct 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066778; cv=none; b=NVp+/5n8qllriKgzdx1t7dTPdywElEIozhXn2c0+7HI1KWBFAhMC9klrA/XDd2lWDcVmDvaRHakBX1of27ni/UzMayUgD82O/f2Qgf1LjPxW6kh57osr398H0HhPA6imKqaFqzbQt8mT7F7cIvM4tDgCZEcQXXDJEje7v0BzphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066778; c=relaxed/simple;
	bh=9AH5k/z4iXFxcwP3WulKOJkfDhRHtQFg0uwCzH/zy2o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=AR0SQu229qg8Q12ZBYpdARkp7NINfqTzoyqTI0IarguGpcT+xVtVjt9uv6wLHYx6CaU+qIs9Q1hxIh3z4tbciUL5UK7gtKAJMUA8dG9hOyDHR3XTb37MEUkipWou7kKnjRDVpe55lXFob2H17TPQRVY/kF5j6uNv4UBeGSWixd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfpNQFPX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so2231070a12.0;
        Wed, 16 Oct 2024 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729066775; x=1729671575; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Zz1AaXGqY/G5RDMad5jXoggb30t1iQFCpAiJuNflHA=;
        b=cfpNQFPXzQIgMGXuVue1UkKMS+V3sZXWaX3PHfZsr5iQeT30bTN1obziTbc0VXBXiT
         RZKBFQsLjV+GiP1bPLq08K+BlkpsQLyqxmjyWZchkYC0pwuhSTwC9jLW8jeGDsjM1+Sd
         pYci/5vH9nNE8aTkM0XJoko2elP4ijE4hxKCY6qN5O7Yk8ijpWDGN6+33hEzOBagzcWW
         scaiSz5uz6eyo1xDSfxK+Zf2XQyp9mC6nwWCIUcqwv2EO2lnqO0tqPjBCKxmyFV6MmiZ
         rJ5JWAr0pW7ooJGguwkwnGxN0UAs20bzJjpjWoEpTsaApTRJUaJu4G7vMH8VXE8197t5
         My6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066775; x=1729671575;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zz1AaXGqY/G5RDMad5jXoggb30t1iQFCpAiJuNflHA=;
        b=ZJCk9hbNw2wv7qeqgtlHjaFz5y0YNB9sOsHHzQi7M7TNDMjtYe+SehTgqo0OUjBiQf
         3eJAMX9+d2td6Tfzvfw7q0G0tVDgzjU0HC6XD2UMomP5GGw0jc7wW3SwJblcJjEnKy7o
         icEjJOKGNWDkgDCYtRnSwyXz0xeiWbYP4jwwJ7bMsnzTm4mspYXoLMga2WPTx3GCCMv9
         uQfTzYLfK2CPD8qjONbExc9ayEe4OmkU132ZWIJM2KDGHXZff/VuEUV22drkXLNLU+pt
         2RhvkTTXcBALZbqELQ1NV2BHlAAbL4+1oDv4uZCEwE7jaY+5gKYS3aoTXaXlVAKY1ivi
         iPPA==
X-Forwarded-Encrypted: i=1; AJvYcCVDKhRzQjVkeVx8xm7halptF+GAkjkVfOWfbC5J9CR8rXvghjyDQPDP1Dl67diiHRZKi2LXdm7sZuGnwf7e@vger.kernel.org, AJvYcCVoLHC+6+CbaU1xaN6Db1EQDH/7z55xpiLmaZFGC9gWrv10smUz2muypwxwsg0f1eHdXE69aR9DQo1v@vger.kernel.org, AJvYcCXrEWak6hPmEDJaf2BpMrrHGN6SMF8UNGAlb18R2YyJdzY6nWAqzLy4JYMYAIoQvyGTOTLV5CVwvLJehtk9@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3uEFnV86ln5yOs2jxQQk5z0/3VQYc5PCBw3ljDr41drjPx3g
	ffmtuDgWo1R1PdPt+/koeVjLAa3DteNWCuyn56rTKOgRlRvcjFAL+BatHA==
X-Google-Smtp-Source: AGHT+IEc9skK6d76EajafBRZgfm8Sy/T5svD1YzxOuBJXHFP361Ejw2sL+OkCkzsAVJGpeVArQ9qrA==
X-Received: by 2002:a05:6a21:39b:b0:1cf:ff65:22f4 with SMTP id adf61e73a8af0-1d905f72df1mr3728444637.41.1729066775409;
        Wed, 16 Oct 2024 01:19:35 -0700 (PDT)
Received: from dw-tp ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a41ffsm2538597b3a.136.2024.10.16.01.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:19:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Josef Bacik <josef@toxicpanda.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: provide iomap_want_unshare_iter() stub for !CONFIG_BLOCK
In-Reply-To: <20241016062344.2571015-1-arnd@kernel.org>
Date: Wed, 16 Oct 2024 13:45:54 +0530
Message-ID: <87bjzkihtx.fsf@gmail.com>
References: <20241016062344.2571015-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> When block device support is disabled, DAX fails to link with:
>
> aarch64-linux/bin/aarch64-linux-ld: fs/dax.o: in function `dax_file_unshare':
> dax.c:(.text+0x2694): undefined reference to `iomap_want_unshare_iter'
>
> Return false in this case, as far as I can tell, this cannot happen
> without block devices.
>
> Fixes: 6ef6a0e821d3 ("iomap: share iomap_unshare_iter predicate code with fsdax")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like a fix was submitted already for this [1]

[1]: https://lore.kernel.org/all/20241015041350.118403-1-hch@lst.de/

-ritesh

> ---
>  include/linux/iomap.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e04c060e8fe1..84ec2b7419c5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -281,7 +281,14 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
> +#ifdef CONFIG_BLOCK
>  bool iomap_want_unshare_iter(const struct iomap_iter *iter);
> +#else
> +static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
> +{
> +	return false;
> +}
> +#endif
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -- 
> 2.39.5

