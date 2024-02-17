Return-Path: <linux-fsdevel+bounces-11911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39068858F33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD509B22011
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 11:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B416A02F;
	Sat, 17 Feb 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqeokdX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE069DE4;
	Sat, 17 Feb 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708171053; cv=none; b=UsPL2Ug8kL4ZIAqsKb/IWcMty9alzqIn1XSwUgBbLj/CF+Wu1VbTRY0kK/HFfgc8OO5lhuryUR6FJbxKz/HA+feYwkTRwKg8scakOPD6+7W4AkkI/VrMH6JKNRJdZnIVeGHYO+mPun61b5clqkw3IMFMrRctIZE40N5duCOSpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708171053; c=relaxed/simple;
	bh=DYE5MHoB4iU6UqVOI9xCwDqXRm2zS5gEUdWLduWrELE=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xzc4gTCmQQEKM2OBwPUSTgoxuIwtBBgN5Z/t7G9S9EV9DNkpf34Eb1FTWJmkNKzr5wf2ld8vWAGYlA+P8JJTis3nNcSZCjLzaLpDwsc8xTCEHYPloebcdppjSlFkRLSrR/gCWhnQ8Pfrh+7h6jrSEwT41wx7p5N+gws0OQUmZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqeokdX0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4125f065ed6so856825e9.2;
        Sat, 17 Feb 2024 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708171050; x=1708775850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUsOgHzp8r6kWIn49FLfR/dfD+6UhIXiD2CyZpx4J48=;
        b=kqeokdX0ny9ziPwGVPJ7GXnOwcQ96fAr/D4Nwu7C7dDbswCWQi6gwnhZ6hpeg0wLhH
         7pOBLu0d+zllb8XclBVUaDlBAiSZXwB5wU/GrC4OF8pTh0YvCmT7x05J2afB+FRGy2K/
         m1HFHLPi7n7RWK+Z0T7QfNuzUYEtQgWJYx+yMR0m5Oo3kXjUUO0tGDuZ23OS8cZxqBh5
         rpObjSqMmDYFCN5jCKYE4bWOsHpIQe78vykXOhhb7nz3RahnEpVmws4vrQY5GOLAyYWh
         zd0+h9YPw0SbUcJbJCqWAKouz7A8jpVHNDFrBRafKqkBr71E4CJgTZJjqOqFRjHhTDBU
         /0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708171050; x=1708775850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUsOgHzp8r6kWIn49FLfR/dfD+6UhIXiD2CyZpx4J48=;
        b=j0CZHGM9jMc+MQ9qmBYv+up9rT9pWIKI9ZH8SYvoVauer4nDvREyDjJO+OIS/8ZiLX
         oknPJ5dQMQip6VKEXqXRlFC65ZdsiBjeW4HDELnbYkWMOzKT6QyuD7DD/PWGx0sOWoHg
         qSb+16P+pGz0p3LEc4eQCQsnki6hiOdoLDOW7JLLlSD5zLdHGVvSTU7z2RSHwvUzlULL
         Nv58EB62fSwF0+AmrxCbyuN/H8GXuUNMlHUj/d6i0B06B2zUi3gxr7PZeWMkOGr8Byd0
         Jbliaxk/HqsIOeWWFE3PXUkg2YwXveTajlrwWD4iDrcP/QEw46lWk0CFL/4kKiyupt01
         q8mw==
X-Forwarded-Encrypted: i=1; AJvYcCWYsE0aGjN85ZaTnsQ4KidKGVV5vwRrBvDQRNowHZ93XOa5OlXwUrc1r4oH9flf+16DjBspv5uV9e9jbqnrMquQ9hnerzL4ULatVO1EWNrppZqz670CDKsz9VD0tiWRHM6DUWs9M7KgajttlPUQhZBX856xuAp23Kar0vyy4qld4fHLTH5/z3pBo3Q4sw9+mz9Nv7+tuOsP
X-Gm-Message-State: AOJu0Yx/LNoTlkVh0eCGw/RsSbEjMQIQpTg42mSC5hclSnL9FzUeozZG
	JOZ26K2KE0aZgCCxI+6UlwH687CN1cYGiu1Ot7RzvHaOyGnHBVcv
X-Google-Smtp-Source: AGHT+IEgt4lASuS58P85SkCYtQ+4L6sOssHAkGTZm9qejp+87GdqbxGLue1Q9HifEME4xc7jobqShQ==
X-Received: by 2002:a05:600c:3ba6:b0:411:d89d:d7ba with SMTP id n38-20020a05600c3ba600b00411d89dd7bamr6456069wms.7.1708171049914;
        Sat, 17 Feb 2024 03:57:29 -0800 (PST)
Received: from 192.168.10.34 ([39.45.172.107])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm5096840wmb.20.2024.02.17.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 03:57:29 -0800 (PST)
From: Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Google-Original-From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
Message-ID: <0e96289fdbda200b9608284c7d5fb72546ce4267.camel@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
To: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Date: Sat, 17 Feb 2024 16:57:51 +0500
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-29 at 04:32 +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
>=20
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
>=20
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
>=20
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...
This is great idea. Instead of having a session to write
documentation, we can have a session which would be documentation
itself even if nobody translates it to text.

>=20
> [thanks to Amir for reminding me that I meant to propose this topic]
>=20


