Return-Path: <linux-fsdevel+bounces-27427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917F961709
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D0028873A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F91D1F55;
	Tue, 27 Aug 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJqFkNht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773A1C824B
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783644; cv=none; b=kFWRGzZso41nGqqcjHma4ODwSWBZbJ28ZT7OO2IGUPms5kBWdgmcDWLdFam1ilMZba2RNSfN6EBKCOarVqUcnRJYc04JfQQSamcWwAwgbkIgqSrOuqf/W97/PcmUwf0jt0EW1ee9YoTQ43iIqD7it4vTFopFwMFy47QQzNulvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783644; c=relaxed/simple;
	bh=79b/1q2s4t/telHFZnBcwfVLyM7KKyDmlWO0JmogiFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNrqRQ2jxPisfuTKfu67RIku5Uag5OAFLq/EG/Al6U5K/9B78p6gXs/dA8WIfEnhIOwSNSIXw39zSlDaOJAb0MN7dwjo9mUzs855lxwhcMUv4A/eTqRCDiSW0TaWTQgKDdmFBYURAw1GZQJjooCfB00DNgFmdKiYsXpjatakepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cJqFkNht; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so61544981fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724783640; x=1725388440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DExTwZMZtz5yc9KBU91nZu8gRhnDp+vsjXxHXMNDseU=;
        b=cJqFkNht60HBIhF27VYmteblkA8nqb1coD6RWvxqcWXfesvehvv9l9CDA95qnSPUDw
         Ay3fwF6Hqz1453o0S2T85YPYKuYixqo/iH8utaeXCVNzKFbwOA/M1Ps6Fgm2qxR+Wxqk
         PhOSwNDLCj3VGbbqdw+Y3LooAnUMqw4gUB2TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724783640; x=1725388440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DExTwZMZtz5yc9KBU91nZu8gRhnDp+vsjXxHXMNDseU=;
        b=GkN8S+BlQzsqxZzbDojiXj9abDnRFmRcOmALbtho+vpO+HATlQ2z0K6bDNsXZhTXwU
         /QR6lE+qbDBJIh0n//NjdjjUJF0ZIBoE3KDahARpFTbIJUR/sGi4b3TjZI5cGDQwnC0d
         POCSJkL74UHEZxY9foRmipMZ8U4r9EOJnhAv0KPyE0cFYz0u5gHJB2+eNDcqcG2voA3O
         MbeIZcJ5Jm8NEjZQL54fGzDJf6yQRSFM26JFTnJyR7KZT+w/2m3JJnWPELcUjHeyyGjx
         6wAaFL+tzCVfuDti1nzAS2hv7svz8XVUGz5PVR5oZmJEj3VQPQxKZttFWJDvMFTaJyqo
         +cSg==
X-Forwarded-Encrypted: i=1; AJvYcCU9QF1CKBh0WXpP0G6lYfcjUUyDr6EC78/l5fON8+3kkipieBLqPlYCpagw8HpM/wur3Tt7E/h9QFYGDI/w@vger.kernel.org
X-Gm-Message-State: AOJu0YwIfAevJMGmCONMI/zhvQianx+5Ll8GL7P+f0yu9G+wF5npbaYS
	9YG2VWdl9SNZiBAbmCtBPN1wANJ/GxkPgL7UF7LGNqv1D0S57LqBIGMyBWc7T/hj/id1qZ9+INz
	/wm8puA==
X-Google-Smtp-Source: AGHT+IGxiclSvCpOFe1+rHUMSfXLL5qBLXBd5JG9+re9ukryb4jmdIya0wLcQ0arlsg/RylJSVR5Yw==
X-Received: by 2002:a2e:bea8:0:b0:2ef:2016:262e with SMTP id 38308e7fff4ca-2f4f4745629mr125142811fa.0.1724783639622;
        Tue, 27 Aug 2024 11:33:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4ea8sm16721521fa.24.2024.08.27.11.33.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 11:33:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso53519911fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUwz/aRDixdJCW5/uRhT2mPfNKvOyRSmUV2iFjcrj4TwMOxmicwSN8EQ5uZyqLsLVs6kkMATnuQik2SKfD@vger.kernel.org
X-Received: by 2002:a2e:9c55:0:b0:2ef:2883:2746 with SMTP id
 38308e7fff4ca-2f4f4965089mr86417741fa.48.1724783638526; Tue, 27 Aug 2024
 11:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org> <20240827-work-kmem_cache-rcu-v2-2-7bc9c90d5eef@kernel.org>
In-Reply-To: <20240827-work-kmem_cache-rcu-v2-2-7bc9c90d5eef@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Aug 2024 06:33:41 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjqcRMKphfSb2zNZU0kefRFMqjEVxr=-k_zAF8=S_kCBw@mail.gmail.com>
Message-ID: <CAHk-=wjqcRMKphfSb2zNZU0kefRFMqjEVxr=-k_zAF8=S_kCBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: add kmem_cache_create_rcu()
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 04:07, Christian Brauner <brauner@kernel.org> wrote:
>
>  static struct kmem_cache *create_cache(const char *name,
> -               unsigned int object_size, unsigned int align,
> -               slab_flags_t flags, unsigned int useroffset,
> -               unsigned int usersize, void (*ctor)(void *))
> +               unsigned int object_size, unsigned int freeptr_offset,
> +               unsigned int align, slab_flags_t flags,
> +               unsigned int useroffset, unsigned int usersize,
> +               void (*ctor)(void *))

I actually think it would be nicer at this point to have a "kmem_cache
create structure", and not 8 individual arguments.

But this approach looks fine to me even without that.

                  Linus

