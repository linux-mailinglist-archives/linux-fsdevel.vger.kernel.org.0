Return-Path: <linux-fsdevel+bounces-26483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121395A0D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644CE1C20F04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BC7405A;
	Wed, 21 Aug 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SCqknAuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96192AD31
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252649; cv=none; b=W6lH2bvrvIqlR1F+IF8VbCOadGeuzpXG3exbJ7IifXS0NMGXTrlsnn7K0tqVtqaRRcNUN9NdBGr8iY0lOOdz8EFfbNYMhP8gfFUjUnrZ/f9szp+yOXocrnxsku578HDRLffMipPMLxaNtnwnbgsZnpeExXTuNY9ES1pVJceV1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252649; c=relaxed/simple;
	bh=H971C15Ad+WH+iKxDrHnLe8s2m4mMf+idN/ZyzxeeGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+2t/qXoshRT7SoCYFssHVaoCMrXViDBaOm/2nj2lUH3CraItQF5QwZ8lk3hBi13EBtaaykLjUHe8f6GVkDKESrS95ONAdDWLWdjT4d6MArFRaxZf38F29UuJX+SXhlDPPewc0sUSokWt7hzUinMp/Lea1E1YhZ4mdX7d7KixBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SCqknAuU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093705c708so6096756a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724252647; x=1724857447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eFY2ZHVHna5DXFQEUGBP5zdS8mS3uZitnyQS1oWXtQ=;
        b=SCqknAuUsOGM/rBLQVudtESgW1KGXAqVa99D7EiA8yeUF+1LKpOcs0VyinPZyMNys4
         YwEFBvnkjsvmGt8JVk3FV8z+TuzL9dkwD8tKdC964qo0O2MFsq63HewZbMaWdlHkNuQH
         S3WUVmhiJ91dXd8dkqCqftzpeqBSZau8zfUv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252647; x=1724857447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eFY2ZHVHna5DXFQEUGBP5zdS8mS3uZitnyQS1oWXtQ=;
        b=aKSWAoQhEIduoz00prP6c6Ds4EVeOlD/tkQy09aAzUyqhAnuxd7I8C9mmf/AmphwlR
         Axbz9kl/vJEsgxOrB2sNz3jk+EYJ4Hh/2qfYdmFDhvn/t+WztC9u0RC9XendeM+s1ZNX
         1K8RH8cHVKO33UfFIihKxU3+Jjh9KJjWgSF8hXcsw/WbwMyfZyYYmunJtKr6OybvPIED
         5NtemKDqVDSVhzh7v82ituKV6kHh23obDoIWY7jSGEXooJ2ZyvBIdcdSg+B/AWnbes9w
         Hx2bYY/dQA+t3N8UWlxkVauLw+h2vW5yQvPmAm41tqmWQ86r6gyd82y36kTRYJIYcCGA
         xUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHngpziy47c8XDukXmtQKA4ztnrjKYUtBMr4XODe5spEB+taAAIwkKWyvWA9g/DpghHphBmKAo+LxXzCSm@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSTFjrar92/DfXk2WXlbl6wikS+kEOk9ePpcNg8uuu+CZon9y
	ChvKx0U/dcr66CcA0PdtWJ6r65aE/ROz5OlXYqXLXAZgunexxaQ7rhvJ+T1Pi4eUhyLiOSA+6tU
	Qwh9YvV0KbNqk0qDEUjGq+N3t+Q+Oc4aq5fVp0Q==
X-Google-Smtp-Source: AGHT+IHLodPHYxeeKnpS5STwdSJcbaYMdHODvLA8eSxAVAtidiXvEbeEX6PbQrBOr+wwFSgLXdhMmtLgldtXAGNnfTA=
X-Received: by 2002:a05:6830:b94:b0:709:49fe:5a31 with SMTP id
 46e09a7af769-70df86f9871mr2845165a34.13.1724252646674; Wed, 21 Aug 2024
 08:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com> <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
In-Reply-To: <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 17:03:54 +0200
Message-ID: <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	joannelkoong@gmail.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> struct atomic_open
> {
>         uint64_t atomic_open_flags;
>         struct fuse_open_out open_out;
>         uint8_t future_padding1[16];
>         struct fuse_entry_out entry_out;
>         uint8_t future_padding2[16];
> }
>
>
> What do you think?

I'm wondering if something like the "compound procedure" in NFSv4
would work for fuse as well?

Thanks,
Miklos

