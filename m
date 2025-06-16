Return-Path: <linux-fsdevel+bounces-51817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538FCADBB87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 22:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5381892811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69B214A97;
	Mon, 16 Jun 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLIcFmOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F412BF01B;
	Mon, 16 Jun 2025 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107143; cv=none; b=tVPU2XGtqTyqY3HqTUj7Lulolf2fhjBDM0meIPcXqK6TNMqjojXNfv+k5T4+riPuuboLfAY17qP6PXRTOiv/8lsnvmkECRhO7T5OP2Q0EUJVXEJBQ7AJli5lLGyPkwpnadUfdejcPWlBGZEERNWVMWkTwNl3BlaaWJ89UMNJe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107143; c=relaxed/simple;
	bh=yjNc7sIWw5Mku9206KHf9C/9aS7bSeippWl4XAaUfl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYmIiBBNr3QWrpWtoqwEWAAH6pexudFKGaDA78jXLOxgHfcLiBQPBsrGoSAv83AD99QXt31AHPyxU6XR0pUwe/PKooXfRBOeBijMPJXYBsNGjfT49V3FDA/Zi9XnDPUC/fOJu4uFHBlAgXYvM1l9YxbiXTZKR2oZWOSs+hbhxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLIcFmOj; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a3db0666f2so112483761cf.1;
        Mon, 16 Jun 2025 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750107141; x=1750711941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NUbKc6aK2XnIkpt4tJ07p4tXT+NOL6ujClKn2L62oI=;
        b=aLIcFmOjXAgzlD+1hoVU2GZHyTa6Bb0x8RkDTTlDWTpYbGL6ZQ91in5LNTE093cgV7
         blgEVbgFi3J8QBiaMDw9USc6SZk/YPHgHMQbAAfPQb7cAGU3o5WxY/BemevG8qv2+fLO
         OBXqhDQ/DH9U0KvXMe8igrbgEvzWISbMR0T8ibWgjbUZyojtXP6cxuON/w/cvr1XiDkm
         dnQjQ7NzqfkfBRdpB6OxgjFnbhiQU0B1DyrGUcWZ8y1Kc/egnaBXKgjHSpGn5vItVX3A
         mBnRMeYf9y1BpOVEEuhrq7jBhUd75F/y1QlFEJZpjh0Zuw3+u0gKqfyV5Kg/pAoYIuy9
         M1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107141; x=1750711941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NUbKc6aK2XnIkpt4tJ07p4tXT+NOL6ujClKn2L62oI=;
        b=bA7SNHm0eyurvYrdXu4C0AjfgmZztHrRYHZ64waABHVX0piOxfjiHi4xHBaoeyWVcl
         0yvMCBHNRfDc8lMHRBepSLs9Bh9w6z9fEZQ44GE7pQcseDEVJTnzMjZbcf6elAu8zh3s
         KchugVRZeDKflRcE+wQVoVd3cIJtDM2yzHpO9j0Ds7nVZZJ2+xtzIsYYkT7FDIU+Plnb
         V96tGePiINDOR+1bHW/bzJTVL8/QftXlypWBILIdb+F64j0rmIXpnjq5zt4CydnsC13p
         xVav90eqncSOFZZea1ngNfYzqy/9eGlDRvqkURo2kE9VE0NH08Nz749UjnrH2sbHTy5K
         jN0w==
X-Forwarded-Encrypted: i=1; AJvYcCVPyvoxWS7ri6oPNRUFXUm4+sceerPZlKHJOr4X12gF1oTDq/ZCAIlIN9lIo7wWOY2wmIzf9TLfbU/sLQ==@vger.kernel.org, AJvYcCVnV+ckTJ9MFVEd6yDFRjO9RNYcZAUGgIuwOsMFmPa7M665zhn1FEx5mQhyXrafy3dmR91/f1GI9/6s@vger.kernel.org, AJvYcCWt1HAQeZ87T97JT61gwtuCJ/H+gWE5SXr+QBC+e2iEIK/JK+czJ7z0zCW8/k57FBLaaaHkButgm+xnvaAsUw==@vger.kernel.org, AJvYcCWzrD4JD7X5dYkoX6lPYSZrjwJsy0i4nLm3BEVPj92OZr2HinH+mTFDPZLB3KK2Gd7bguLYcyfpLld+@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKHTtVzuqGM699Z1bsNMFpTO3IzJisHaYxWZM6WW4D5C3lltS
	hmmR4UzoYqAnLxZsF6Ri4PNwoV/eAIZ5GHe2mJHzj3Uky9ATmRioasKDPeHFTRRFiLmu3Hkm6b8
	kAWmsMjyb9chSLUvxcbTCmnFXxh6byDc60eKN
X-Gm-Gg: ASbGncuSqT84o9RqjhYvO6FuODox77NJrhpug0tbdzjsMDuAqVUybEqz/KtuYcx3UvJ
	DBTnHNIoowZ+76YTnVIgCnPgK6vGmXhXC/9QCMwejzHgOQ2h4pw+BRNeupbrgdw5VLeNhWGNfDQ
	8QOFagG9zXj/V3P3aFjdOAdX0V5ew5/f+Yu1hNBt5ryUN1QVeThI5WwGVCtKs=
X-Google-Smtp-Source: AGHT+IGS4t2zreLQPTsOmnz3YjnJlkQB4JQstwJ2reaaH3lerJxAbIQ8Al6iM9KX9mqUf+zE87y0s4V83niCn/6mzVE=
X-Received: by 2002:ac8:57cc:0:b0:474:f1b5:519c with SMTP id
 d75a77b69052e-4a73c596fd2mr165931551cf.32.1750107141044; Mon, 16 Jun 2025
 13:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-7-hch@lst.de>
In-Reply-To: <20250616125957.3139793-7-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 13:52:10 -0700
X-Gm-Features: AX0GCFuogwkY0gaMMAkWsBMtkDoY0xe9BZvnCtXb7o_PWtFPI2AQBBFyUKz9wvI
Message-ID: <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in iomap.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index f6992a3bf66a..d05cb3aed96e 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,7 +4,6 @@
>
>  #define IOEND_BATCH_SIZE       4096
>
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>

Should iomap_finish_ioend_direct() get moved to ioend.c as well?

