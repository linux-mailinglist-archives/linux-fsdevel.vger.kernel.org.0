Return-Path: <linux-fsdevel+bounces-26781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7795B9EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C581F242B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321E1C9DF6;
	Thu, 22 Aug 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V/QAxIym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E52D05E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339885; cv=none; b=pYZvp0fm/fNyaMytrqbGgjfmuJHrvmiUZRQTMRjkRugDwW0jooGWss44zZGD0S3vS/GxS0HA0VDNKy8Hni0aSlMBcR5vumj5XYM9NKnTPriKjJPtpTt3NEcxkS9Wx4ZWQIwLaYhkGOUsKlW+SItEq7Ml9N1+zaSIhlNh95SQgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339885; c=relaxed/simple;
	bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+m31qoVfPggrdBzg931owLfuX288c+VAgkaOOL4Zt5V8a8XOChNCdFMjvCZUBgi6fniAitLR2gZIMackEJYrRNTyFVb5QgyWgAaptvHO3UwOUSCPqSDpM85PBe5ZC1/WyZ5Mq2V7k4c+9HIqsS0Cmmja93hmGXHtv29tYIrb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V/QAxIym; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86910caf9cso140326866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724339881; x=1724944681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
        b=V/QAxIymVYh4HxgWZGdI9KaIyh9unWJyHte6KuzCTX53e0qnQD4Wta8WV9eqrl7b1j
         dOj15Xd/mUEcyL4MCh7lVteU+VcGtLzR6iCuS3vtVZGMgWaR/Mb+rtLwoPjs3eBml8QQ
         PofK7IIIxpL4uYA/jL0w0kY2C9hKIDsFrvzNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339881; x=1724944681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fl1xClMzidzVLaAGhQIy4FMjfSjkpp459jOzZzWS8YE=;
        b=Zf8E85iGjS/DhdrFrqS7MtJLuDIrL9qYTkSkSTe81Z1UoPloHytEz/rgRZZ0x/AyJC
         bWZbIz2Z/VlaEAnYJvNfljzChT6bbKBQXHxeDULd9N+86J8q79OuG6es6TBheWQnMM3h
         gB4GhdJVz6QOy2R9yw9DzZmHrDfa0BK1uW6Pg5itnqtgfdviJB6fDVOc0m8XtFFcLfOT
         /Lep/i75aA1muma9NJ64RtrrKBaU7z8fZCvLl/0ItlmXXCPq+RlbLqu7HnKPZarzNCSt
         pBFHegESLNHNJjqj0vYWmwOBKWkAlj4iWEh74/EI7b/vv+bxa6du86hI5SZxR8O5Gix0
         91mQ==
X-Gm-Message-State: AOJu0Yxk+jZKBg8rc2myR6GeW9W4QA6Le3+4cZ+O25JyD4YyWPf2wCEW
	4/JqYU/VCWsIVc4yBFBhmZZVTy7z9fHLMSXghy/loV2snVUOSqFzISnWE4t+clfZ+IPlknZlHOn
	raKNi7SLpCudo0V40dsqOWqo9WP+euP+bvLV+Pf8lYeZvpQUB
X-Google-Smtp-Source: AGHT+IGOx2S8RYrrO2KmV5F8eBX2ZNmhKR2OsBP7+OLhFCzIcQYvq7+iqWL3yTCj0laN2dze78uRVHH1qdmvhG/fKm8=
X-Received: by 2002:a17:907:3f99:b0:a86:9e85:2619 with SMTP id
 a640c23a62f3a-a869e8528b0mr24515266b.25.1724339881256; Thu, 22 Aug 2024
 08:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810034209.552795-1-yangyun50@huawei.com>
In-Reply-To: <20240810034209.552795-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 17:17:49 +0200
Message-ID: <CAJfpegtgp1brE3kY+juseZ+P_hfzbgYwG52eGc1BvR0XsBq2Bw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix race conditions on fi->nlookup
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Aug 2024 at 05:42, yangyun <yangyun50@huawei.com> wrote:
>
> Lock on fi->nlookup is missed in fuse_fill_super_submount(). Add lock
> on it to prevent race conditions.

It's okay to do this without lockinghere, because this is a brand new
superblock and and a brand new root inode for that superblock, so
there's no possible access from outside this function.

So just a comment should suffice.

Thanks,
Miklos

