Return-Path: <linux-fsdevel+bounces-44639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61DA6AE96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E688716412B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5952288FE;
	Thu, 20 Mar 2025 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsK9QkXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77C1E3DDB;
	Thu, 20 Mar 2025 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499193; cv=none; b=INq0L3SInxZwiUiKB7hl2qO3PG8TXx9pbqwjTvC+SrxL5JLm2zPp4zZ0orJ1B1FlrDxyvDG0bcVfWrSfrjK9yRhZffm3VZVE8PQAk3UCxaLfTBD3OU/nLUQfCybNCPRQ/yIEsHr1gN8pVuSglOk/t8+dj/hEJ47XyEgPQQwyFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499193; c=relaxed/simple;
	bh=67Rli1aMINRhNsEK6vbiKzUJhYIb+DD/lRRVWBz/1Yk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qGcPWlWVGAoMTlNxZW0cuF9xhQ25PUJnZHxSR4hA6tsM81N5uuf73/mblgK0s0vKAZed/Je+bhiCu5MhUPjhnPiOVGufE6yFUI4/c9QuRJAvmF2vgovPBq4Wy4hPPEm3qCdqr+V4D9YtX+X7IBXOSouNbQDxc6a683KCcpI9jrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsK9QkXp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22580c9ee0aso25645615ad.2;
        Thu, 20 Mar 2025 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742499191; x=1743103991; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zHVmJxf9G38/fiYNmkpuUJFgM3KpXEnE/rPC5REGcCM=;
        b=RsK9QkXphHlIMrkQIT0XlIqRFu9N/BBnh2tT/kfciCR5uzA8XWA/aMq42sqhItHyPa
         HM3kwKrQPjIpd93sVKk5YLQ33IP2G4tQeWRfFLJE629EKviYZwyzL99tk/HdGHvCjo7C
         NuKxUPjuM5IlASNmur2sJIIKa6NIaVpppwDkKo20nlrj6MA0Q4iAhfIYQcKH3IAUrQ0O
         7Sv9qgsaqXt+YD+fvSS4OXb+Bo4kK4Xb8XEKmWRo628Se4F3vFCuOpGNlxEsuEOxjF5G
         LYv1jPX8p5CKPmKdo9Q8hkVHfreCTQ6yDgkFeGbNENbczwYmYFFskw37Sub7QVBqu0QK
         bloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499191; x=1743103991;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHVmJxf9G38/fiYNmkpuUJFgM3KpXEnE/rPC5REGcCM=;
        b=wuU2msu/Fk3t124DnPUZehRxtoPheGIrql0pdxd2Dhv/FAh1xd6+Ai6VLQS7fcTWtk
         ZfrpuMGNZK6Ef5bVSLOlezW/hULxvjSOMe4pDQt5oQsOMkVLh3ZcUkYkmJQ4yd2rRA3w
         jXnqqAYW4Myvf2RW4HQyG7dXNBl25EqQMagIw1AA7nuXEzn+m44km3IIMJUSieARJBFj
         1t9nC2K0vrZvYJ4g/7Yz4WRN/cgno1nUjyEKHi75eJJDr2ZPTJz3ioRSBJ7Jpr4malBr
         yQM7P+3UZfAKsCMhhw5C9q7H3bC9eJ2c4GN+Ekv9qC6HgoIAvuAKrkXe7wLBmHMz8f9Q
         O5SA==
X-Forwarded-Encrypted: i=1; AJvYcCUIvy1qEzI8u50CBoCU0dhfRfvWCx2TTlbN5yuS0+Y1Ms2NvslZ9v8vzjElYOEmX4Lk3A7XYGwm5fam5yT2@vger.kernel.org, AJvYcCVVwBF7CnDbPMrPkIgUvhrrcXtWjnf6mEHwP69JUjGaVpvpqelWx/DTmEb7xo0TgwtbtFbLxl7nxAZ9@vger.kernel.org, AJvYcCW4Me0nbBteDU1ggSp4xeoH9thhyyD9ZVfyzr/arJmOm7wUBnBHBxxB39bCja26R/ZM2KZC8/e7LZ1e@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpycMFbMNHXNHW1MvBYtpP0IGNcgiARFa8fedhkSDTHCpoYC4
	v0LP0PwR9STadGz7PWWl9pNetLaivWV2BwlbqIIfYVuk2CfqJuPm
X-Gm-Gg: ASbGncu9vDdwGUzXEaeAOI09/H4inPxVYA8vRytiXUEsuvFALIAhNGe5B3F4H/eFDe9
	d22cApmoSGx5lW3yf+4JtpT49BdTxlfwNxJlu6vTMlmJa+zRhgNkwN4oKHbTaBwrn2i0SUadjUS
	gLUCwig0YmwqSHlu9WeWvEOs/PIu/EaisZLE608ll8vdLBV4h/6DTdo7650HJCdTGfglBjc65sW
	bozEgVvnNolTHA5FmdAqZa0R/BpGForVi63C3T/eYt41c3ee40d8qrfh3PFc+vrSmbjnT5jJ4su
	8HZpF1MfCJPhYkWc4tvKDU3O33UwguvoqXWG+Q==
X-Google-Smtp-Source: AGHT+IHGOMDIgVFAm5eHa6xBoB4g60AmPE2lbPYGqoWBuwkqeKe/nKrFEMTBiXvluqrnWb5TXYd+KA==
X-Received: by 2002:a17:902:ecd0:b0:223:325c:89de with SMTP id d9443c01a7336-22780c5467fmr8489935ad.1.1742499191155;
        Thu, 20 Mar 2025 12:33:11 -0700 (PDT)
Received: from dw-tp ([171.76.82.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811daa6esm1661575ad.163.2025.03.20.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:33:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 2/3] iomap: comment on atomic write checks in iomap_dio_bio_iter()
In-Reply-To: <20250320120250.4087011-3-john.g.garry@oracle.com>
Date: Fri, 21 Mar 2025 01:02:05 +0530
Message-ID: <87ldszsdl6.fsf@gmail.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com> <20250320120250.4087011-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Help explain the code.
>
> Also clarify the comment for bio size check.

Looks good to me. Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8c1bec473586..b9f59ca43c15 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -350,6 +350,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		bio_opf |= REQ_OP_WRITE;
>  
>  		if (iter->flags & IOMAP_ATOMIC_HW) {
> +			/*
> +			 * Ensure that the mapping covers the full write
> +			 * length, otherwise it won't be submitted as a single
> +			 * bio, which is required to use hardware atomics.
> +			 */
>  			if (length != iter->len)
>  				return -EINVAL;
>  			bio_opf |= REQ_ATOMIC;
> @@ -449,7 +454,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		n = bio->bi_iter.bi_size;
>  		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
>  			/*
> -			 * This bio should have covered the complete length,
> +			 * An atomic write bio must cover the complete length,
>  			 * which it doesn't, so error. We may need to zero out
>  			 * the tail (complete FS block), similar to when
>  			 * bio_iov_iter_get_pages() returns an error, above.
> -- 
> 2.31.1

