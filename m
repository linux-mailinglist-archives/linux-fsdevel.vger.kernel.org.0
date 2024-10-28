Return-Path: <linux-fsdevel+bounces-33085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B99B395C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FA11F21D01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7D1DF99F;
	Mon, 28 Oct 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTesfLpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCB3A268;
	Mon, 28 Oct 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140997; cv=none; b=XfrMP5KLbS61Pbpt1mRJCWsI+I+6ZpLIsyV5DEU5jDn/cJ71lKQQ8GCjrSTIWeKWECYsYt6a/ezLR++QUgakdH0HvHTfw0/HUzfX02+fvnVfkPCLg+1qFchMg1fV0jAC3Dz7wXxkEIy9zNQZ8oNGJwFSPz145Z5CznMOv3heHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140997; c=relaxed/simple;
	bh=hZDW9WqjWuNKMYjcCSSCDzXV28y4hUdmwJYnvnbOIsY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SqfZHsVdXChl4V1TmLZOIMaqh8dFnijzXR/tOM85Q8jo784RwbYXx3TB12TS3EXgfjVMN8zIIlIyJHnx5vzNSExsIcmRkjxZJP++QOnbyL6I93QioVpODgagRKBjJAo6a8tnrGZf0NzQSXkzj13/1wpqKmQBN3L2xbrENakXtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTesfLpY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ede6803585so1183751a12.0;
        Mon, 28 Oct 2024 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140994; x=1730745794; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4/Me2eVv8lU1gEbAQKsDKN4O3ejsnyGDvUbN3UpB54=;
        b=mTesfLpYEnjC/2HlTzG/TDo5lhqkBJ/jjAeUMaP+33s1TvzxwCuCVGIrdVn3eivleH
         D9+UKMfpoGZ8o1tz/kzYEMYhV9C0bKfcYDb66qdiMabre0xN7+YvJlnuHvU9etI/qnQL
         vvn+wgri+ASCiLGgsD2b0jeM1a6qUcaKWgSi5nUdgpoZHQH8NolqfamwO+jXt3FqdqH+
         245V+efhJH52hivcVTgvLq+MaXSsyEPBeUh+4mUIR8PiYX+7m9DaLJ1N1WmZjk6DZnOf
         re9PfESqn0rW8MiUOZdmovnTJeCJXFiMhsVWQ0Qa6SPSvoweK9j5d8FqU8qvFWqbDyni
         4Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140994; x=1730745794;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4/Me2eVv8lU1gEbAQKsDKN4O3ejsnyGDvUbN3UpB54=;
        b=kOZK/+5J5ndqcDrPG4WCLSI+cW8vgOO2sqnBOH1obGqhOHS7pEx5ufIvSNT6taJbYr
         GAdxoPErVMHy6IANYs+d5XKAM/LaJItyElzF8leqUlwOORwHshDO8c1RoPBUlMdvR5Iy
         KGKcZItQsZKb8YCIsoy1vAq8fhQjmoM9AnfVB6R1h/FKIbKV7OF1l+Ikotbk9JdBETiY
         dnyD8nl6coGsqfVQtdTkCNzBHo2Y8ig973E+dXOUORMk7GMpeHe40LfvKf6HVqm3VcEp
         /4zBLXgezGLUIS5cO7pJ9xyqHXaTtEPnGqAt/aj6Dqhf3wXZ8xk8h9liDELJlRgMyFI4
         ezwg==
X-Forwarded-Encrypted: i=1; AJvYcCWMaVhENcd4x+NnS4ldDZqeOuBegWsxlwflDNWaCUrQutfZ8gEv8BRwD7efX/vZlrH8upT+Wd1cyJQVdgmJ@vger.kernel.org, AJvYcCWge8UWmXu8Fz0/rSSkqbyr6NfMmSTj0Vu8+buFvWUb14SuYpll1eawPvYriE/WY8c6btZnffBEwKixSsAg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qT+vV+RuS3Xwl6TEIHYrDUbXQ7U/WUK+fdKAGeWZD/trUgis
	JX0ZnIsTNP4CciEYayLYwPCWQzmRnmxhwaRkuW7z6LQG3X+eFqjRXWcsaw==
X-Google-Smtp-Source: AGHT+IEsPi5CnLsqPDuL34kjNvgLU7cQX769oqJlfbYM1E4LDRAIFJKDXg808cZWKd8btOzgvDe0Xw==
X-Received: by 2002:a05:6a20:b58b:b0:1d8:f97e:b402 with SMTP id adf61e73a8af0-1d9dc89879amr772134637.13.1730140993654;
        Mon, 28 Oct 2024 11:43:13 -0700 (PDT)
Received: from dw-tp ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3f0eesm6063729b3a.208.2024.10.28.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:43:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, Carlos Maiolino <cem@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: Do not fallback to buffered-io for DIO atomic write
In-Reply-To: <627c14b7987a3ab91d9bff31b99d86167d56f476.1729879630.git.ritesh.list@gmail.com>
Date: Tue, 29 Oct 2024 00:09:25 +0530
Message-ID: <878qu8m5r6.fsf@gmail.com>
References: <627c14b7987a3ab91d9bff31b99d86167d56f476.1729879630.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


We need not pick this patch up. As after the careful review of the code,
it seems XFS can never fallback to buffered-io for DIO atomic writes. 

Hence we don't need this patch. More details in [1]. 

[1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04

(Sorry for the noise).

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> iomap can return -ENOTBLK if pagecache invalidation fails.
> Let's make sure if -ENOTBLK is ever returned for atomic
> writes than we fail the write request (-EIO) instead of
> fallback to buffered-io.
>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>
> This should be on top of John's atomic write series [1].
> [1]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/
>
>  fs/xfs/xfs_file.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ca47cae5a40a..b819a9273511 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -876,6 +876,14 @@ xfs_file_write_iter(
>  		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
> +		/*
> +		 * iomap can return -ENOTBLK if pagecache invalidation fails.
> +		 * Let's make sure if -ENOTBLK is ever returned for atomic
> +		 * writes than we fail the write request instead of fallback
> +		 * to buffered-io.
> +		 */
> +		if (iocb->ki_flags & IOCB_ATOMIC)
> +			return -EIO;
>  	}
>
>  	return xfs_file_buffered_write(iocb, from);
> --
> 2.39.5

