Return-Path: <linux-fsdevel+bounces-56551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6BB18F3A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9549AA15DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2211C3BF7;
	Sat,  2 Aug 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XAtq+/GB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78066C13B
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Aug 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754149056; cv=none; b=EOWCXpq9gdx4CV3OaynplTYhvnr+3ZBCCn4xIFPIaxm5YZHx4EnsqpFP5okvlhmGX4c3/NcOG5A3ZtuPqmAKcxf5gySmVDPRjcDipzQBV4ux9mjmiYwy77BJ2VIjN+ehhp6CgjN3GyKMgnh8/e6hhgzuWnirrUA0x2G+djO/TKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754149056; c=relaxed/simple;
	bh=r5BclxiNA2oHNLLunK2Td77xpt9TQVXBaWGBfY2UqXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTf2UGDBhKRBG0UOggtFnz+tpgiNPECAKDj1dtGJPVG4+63JOs139fxRCAqrKYhfnWUpZUtPzu30Sp2IE+vkw5zcrSVugtALjwUOiPpNNaMUcDN2lGp8FT4DdbWNySMizvjG+S79iMndSX52yLp6Me2cskkZPRX/GdLRm27DIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XAtq+/GB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e3ff43383fso19936435ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Aug 2025 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754149053; x=1754753853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04FKV/5jxBcAoTht60UjROgiF7iSlnQp8Ncc9Cilojs=;
        b=XAtq+/GB1qOsAPi1C1uMNsjlNdZG0pY91Tuo705P0vGIeCQ2ulLYjILvL6u8an64XW
         rF1c+hh6bg3MQp1hMdn5SUGZG/+h1TQUxrcGGbbxJdVbrlW46NNO55I+YkQQ/w4hORQt
         qjVdHGYrbYwud7y2nlnTP2u5/pgvltTQaXSMDlvEvc2pmFZ20D9JNEfj3Okk3g0ib561
         5H9q4VfwETJ3a8wgyMOjxv2U/CtiHeiNOAnAdzdAZKyRkeMvv3pQ+g74PKVIHPJSq/0L
         NY8/Qt+8y+HWtwlCkTQu5HkKlO+Jltnv4DzKXi5T2QkrjwjfirlHberh3j4/ZUnwHVj5
         2PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754149053; x=1754753853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04FKV/5jxBcAoTht60UjROgiF7iSlnQp8Ncc9Cilojs=;
        b=glOLYUlW5p+bAobcw/Nv2IidS9kv1kPLmDkCwe6jeRziXoSnIsZ7S/YSfRHPf5DehP
         RbmDfSm6LmQNIUuThLFa3V2m4PXjYGqMo0cr64y+ORhPJ5+HPoyQ4t0OnGxIq1iOTHtj
         EJSNA3f/u/yGoE4+TZO/Rfue54N5wor6yq1Xv+AduBwqGzsXrE7eTDmLC7pq5pSf2OPo
         zvZJG0/9M1CteVFZkIK+/NF4JZowxGAPpDKDxztXcF/kB8hR4nBEAL3MnvlrirFt7m43
         TXRzZyNj6drNmPnoFpx+CBsajMSj7aA7scLYLR9K7EUHP+jqAeqXSye7jcyoFfl2NUDf
         1ByQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZV5f9RS3imG8PN+BQXYQgGG2iA6Xrbz84xAZxiLKbz0X0YdBQfeBbWWNBk/Tu0kigasyIPqhZlI7cBOu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQ01ivAlyxpB4BVh8s5yYwAZL6O7wzEziRKTz3nXeGyGP527y
	oLLFH7JIClL7YgbKZiy31JDjGkptvsme+Iwke7gehDuzeh9tjX0hjfjQUEr1XwQoNIc=
X-Gm-Gg: ASbGncs5XmVonaJMeSfLdle53SQjex95BVv42glaCdwqmT+ol7yw/WZ62jszuJwol9U
	jS9yi7R7Eqnut/QVKTs57JLuT5HMfxrjD9T9wrLOesJ2hRiQuCFgEXbdaZn07Y5YVKKlfT/PM7u
	WZLkEQl9YyhsyKR/Z0U6CISlIQwOJrR2R3k6q97RTIscU2spkqqplMW4ACDIt1Acp5r5IkJTFU+
	DANP3D1F3ZKB0k43ZCSRGDO6H8ozEEhR2c+IZHbIDnOyiw/0pDB7RdJbmcU6Pu6ka50UyBzJYEs
	x286nyK5mioHodoEORAZnfwAZwd/Y0GNKuFA2BZGyR5B/GoIwdeS4AEePN8oTbuAeCLOhPWDC3q
	I81QJxlhGbUj9yt+JOA4=
X-Google-Smtp-Source: AGHT+IFpKu7HslfN99lpIdPLZvZStogsGBrzGWqBfvd20JQpD1Wdf3nzDTTCR48VUkNyC7cVFYirug==
X-Received: by 2002:a05:6e02:2382:b0:3df:347f:ff3e with SMTP id e9e14a558f8ab-3e416116d8bmr66728215ab.7.1754149053646;
        Sat, 02 Aug 2025 08:37:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e40297c3d3sm26117545ab.6.2025.08.02.08.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 08:37:32 -0700 (PDT)
Message-ID: <43716438-2fb9-4377-a4a0-6f803d7b8aec@kernel.dk>
Date: Sat, 2 Aug 2025 09:37:32 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] direct-io: even more flexible io vectors
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 5:47 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In furthering direct IO use from user space buffers without bouncing to
> align to unnecessary kernel software constraints, this series removes
> the requirement that io vector lengths align to the logical block size.
> The downside (if want to call it that) is that mis-aligned io vectors
> are caught further down the block stack rather than closer to the
> syscall.

That's not a downside imho, it's much nicer to have the correct/expected
case be fast, and catch the unexpected error case down the line when we
have to iterate the vecs anyway.

IOW, I love this patchset. I'll spend some time going over the details.
Did you write some test cases for this?

> This change also removes one walking of the io vector, so that's nice
> too.
> 
> Keith Busch (7):
>   block: check for valid bio while splitting
>   block: align the bio after building it
>   block: simplify direct io validity check
>   iomap: simplify direct io validity check
>   block: remove bdev_iter_is_aligned
>   blk-integrity: use simpler alignment check
>   iov_iter: remove iov_iter_is_aligned
> 
>  block/bio-integrity.c  |  4 +-
>  block/bio.c            | 58 +++++++++++++++++---------
>  block/blk-merge.c      |  5 +++
>  block/fops.c           |  4 +-
>  fs/iomap/direct-io.c   |  3 +-
>  include/linux/blkdev.h |  7 ----
>  include/linux/uio.h    |  2 -
>  lib/iov_iter.c         | 95 ------------------------------------------
>  8 files changed, 49 insertions(+), 129 deletions(-)

Now that's a beautiful diffstat.

-- 
Jens Axboe

