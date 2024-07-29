Return-Path: <linux-fsdevel+bounces-24416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3093F272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F93CB234D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3A14374C;
	Mon, 29 Jul 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWEOwGUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96625F873;
	Mon, 29 Jul 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248307; cv=none; b=PHKAL9Ez4eT8MJbB5sIKjVnrkRnN4sozXmXs2UEO/9DIbp9zchGyDR0EvP42nUPVkdQ5llL6dPdVD/UieYge+nE5C8RYJgtF3imzW6g9awQEOhW1TwGcthnHyBUyEy2UdyDiAcmlvG/ihQrcTfqnFmxo5NkM+AI9aIfYI5y/jYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248307; c=relaxed/simple;
	bh=Z6i/dw05jrVzJC72UKVz7DRgDDdCVqz4Gjyw/0WlU+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui6TrtsvGIZ/fu1nyeWJfbgPAzpy95od7Oplzi0Tn5WxB0tcfbQxDWJU2+YKGVy++9RZm1Pen2rpD2iZn0vmz+VIwyIEkC1TxhM1BHNIjlQ+bGKiuqrIN2RhrOcjDilmrlrBe2jYEDdsO0CBEVoUVQhih8h7Hhn3B7C+2ZxgumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWEOwGUu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so14541895e9.2;
        Mon, 29 Jul 2024 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722248304; x=1722853104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6i/dw05jrVzJC72UKVz7DRgDDdCVqz4Gjyw/0WlU+A=;
        b=SWEOwGUurjcGK4Y5bBgpCo/RSjSvq22HC3S6rnrD3Tlwyq2X1M77Ru8G7jQqPiDrb6
         KTxARP0HIxp4uMpv8MMQqCIknmiZNl9OQ7Zu1a1hJxK7F0ACPtGhyyg7KATfjf80Cy35
         6aESajfpwvrDqt+4iZg3jRuD/E7cO9tgRYkF7Q1WjyuJAZ7akHIdXKyX1qs5WOdOmRMF
         BO2Svh3rCZN6v+7c04Xoozf0eN/FpTswck8+Adc87to1UPyXuNSMdD5TraXehreNclGd
         S5zkjQCB3r8MhSmmKsn3ljcYenC4mPQ6W3X6IrM1IksakyESY9jkHH9p3iZjKql2eYVk
         IuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248304; x=1722853104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6i/dw05jrVzJC72UKVz7DRgDDdCVqz4Gjyw/0WlU+A=;
        b=qUWdWXtALjcp2445FHYsLjvEd+j48dt8Iy2HnkfE7Q349qk26a6mE68afhPL1w6oqU
         ezZFiQhLyXUDdOYCISaEv1ZKqnif8n6HkSpbv0ojpBIvDYWNzcBIg900jo9QI45JycHG
         LzyiBEOShRYBHWik1jckn8RIJ9ESNthL9y12euBCAep4iyEcChzUc1VXBJ+tCcNVOZ1G
         1l8S+vnBiCzuqxbhThpoWNkV77kH2u7ZHFBHIJFnk2zJNUHD0+d4rBd0kppvoESI8U+3
         JAhTPNx6U7PBdONSDM3QgoijeF3/xZj8oDSqU2cglXuotgBBgPi9ZrzyPAy5O/1bJyL3
         Kxiw==
X-Forwarded-Encrypted: i=1; AJvYcCWPfTnq/H/xNuEFYeQX7FKGtNPMLMLY7XBRvfcpduLAiCrZl29tNUQzQqdKp15558H5hfKkFJ1zwRLgyl8SEASy5GCUQ68V1X7DhOf/A/Q0Omj3R480xJzOStr/QNCF1koCjY1GQgNM
X-Gm-Message-State: AOJu0YxQyCrTcnbGOUhAPaBaxJfOifDslxlJdOPvuCEMkzFSEPD4xHJG
	s+DI1zmToikUEfRbH2DKw/qEhmQRUt4MDZNKFvw4cCF9p9JtjAXj
X-Google-Smtp-Source: AGHT+IG18514HKOtzbkzR3RJchNZQb9L6S2W9H0FE6f4Po2yJ5snbzks/hMJqXWbFpwjG108dfDbMw==
X-Received: by 2002:a05:600c:1c83:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-42811dd79fbmr46403635e9.23.1722248303867;
        Mon, 29 Jul 2024 03:18:23 -0700 (PDT)
Received: from f (cst-prg-68-42.cust.vodafone.cz. [46.135.68.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367f0e26sm11838333f8f.47.2024.07.29.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 03:18:23 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:18:15 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j88sn4d.fsf@oldenburg.str.redhat.com>

On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> It was pointed out to me that inode numbers on Linux are no longer
> expected to be unique per file system, even for local file systems.

I don't know if I'm parsing this correctly.

Are you claiming on-disk inode numbers are not guaranteed unique per
filesystem? It sounds like utter breakage, with capital 'f'.

I know the 32-bit inode allocation code can result in unintentional
duplicates after wrap around (see get_next_ino), but that's for
in-memory stuff only(?) like pipes, so perhaps tolerable.

Anyhow, the kernel recently got F_DUPFD_QUERY which tests if the *file*
object is the same.

While the above is not what's needed here, I guess it sets a precedent
for F_DUPINODE_QUERY (or whatever other name) to be added to handily
compare inode pointers. It may be worthwhile regardless of the above.
(or maybe kcmp could be extended?)

