Return-Path: <linux-fsdevel+bounces-60317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E2B44A4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317CF1CC0A72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB52F60A3;
	Thu,  4 Sep 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdoMpTez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDF32F74D;
	Thu,  4 Sep 2025 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027814; cv=none; b=WAv4sbDQguUNJVnSM2cR4nBhM0d0KjdRwlfB8NjJgcOE1994C0IEZ9riTX3HGH/dRYT6z6mcV+zPUvJ8olfhV05Kw4fJXtDbOmbf0Xnt1sxLd1etQilHar3Nwtn7VZED7ctVLMn6kpaavIvFuds2NLyna/NrispYvJr1rO5aH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027814; c=relaxed/simple;
	bh=5SCN1V3bwWZaUcHIcEOXk3i1RvnbNprN+E8wGiIWb5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6KZjFR/b5u/NuengaAJMbz0dXxsgxke4xdU+74TWFf8jDDLZyK/dtmDlI5TFlFGBt0bqT77hfD3qgHrl9ZB756JXiMqknT4tqyrMprDvwuTrY2UHOj9p3/PEjfOiiTILLaQinasKkLbkanDnNUxNHP4LIqjfEQQKgE9eVZbIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdoMpTez; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b5e88d9994so3201171cf.1;
        Thu, 04 Sep 2025 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757027811; x=1757632611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iodUiBkCdUOR1HJyS4NzY3iHpVK699tt2D+XRmBC3fI=;
        b=BdoMpTezqAQGTtR8Yt2lWmyCMfvf4u3VF+ZoBIwRpivr2bIFrEtIZZ9BG1JLpefspc
         b+fUkMePlo7hkPCXtJo43+WztslQ1QM4DHWAcj/Xc3OOHb0ZqO9xken0ef6QwcFULF3f
         SE/qZaxP4DrAvEUEHP6nYZ/ynT5PWNMU2c5iiplgo9aFhrP7KouCfHkdKZAy7n/U7oS/
         4fb6MuyFquFcjQKr/6YGp2XEDk1J+P5kONDc6Co4eBaHPNpgGYA7xO/C5khQK2ATQsud
         lv7IZ8ndGINPlZkKEjgYvok1vUm8AuYWZGsWk7Et/XJ2+gVbi7uDQV9kjpgh+RhvWWvB
         8Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027811; x=1757632611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iodUiBkCdUOR1HJyS4NzY3iHpVK699tt2D+XRmBC3fI=;
        b=bMcridNeGorT9smqxuPMXpqm/8FGkkqJxE8SPx/SbVWfTT4QKqOCAcfF36eiXR79O5
         If6VV6sozZDgw4Po6rvBJdmLVJnmiH9KV7OgnXpXbhnmhKg76Dqo/JnDP/2BoeZQeQw9
         9mrZIcBVNdwuQUy6V5UYYwDaezgk4IttQ9xXUTj5evSdr4cYPDk1W6Uwp/CXKkHb/Oec
         A2dIv6O8ZEfxXuroMf8WKVXbls4XvsPBgA19WCX1TJ2PjMR+PR6xbT9wyMiir0aNjGmh
         Fa8WWtm52b4DUgpXLNnAtQj9SVlwvzt6snx9uquKc12A5yBhPti0v99E0+cgm+BMPSZa
         f0wg==
X-Forwarded-Encrypted: i=1; AJvYcCUYWYItDTEdlJgl45omR7PGcKv1SfOVs2oUbe3hXqC8O9J3q/RmPJasvE2KD0lthCnTtsXjnhQsQWg=@vger.kernel.org, AJvYcCUiGSoCUt83jOz5Qn5Rl3xzUWK5ecuFK9U1zcNFOxdTTMsjtxfHmRy+qDeJ7aA4F/loP42bqmgqyWuO@vger.kernel.org, AJvYcCWDqXN5CS12n867/S3Z/iymXyt2+/bxvwRM46VHE/7pOTjq2f4ClP2sDtjnh8HO5tA7iPS275wBgjNDSuR3MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMb6lEJWszOkfIxfKf5+vbC8WOyQwAqMMcCvAz/23/Sf6jaozc
	5+ZSd/VvzOt0LKN5gvqNsnGkPOL2bjXtZRYcJmOaykvQbZQwm9BGfzhSDZ0FiMCRQ8RYcP1ui7G
	eAGAa9YMTVwRPcg1ZhR3jumNZA/UAgBk=
X-Gm-Gg: ASbGncvqfrseFcXHLQu2uGN7ThhIeXNmzIDBbCI6TpOp6QxWcoB+B71uUyBHo7/MvhI
	BKXuiOCK9vcvgDX9iW75Kps4pDk2/R7z6eR/BYX/P/u3y9UyGFmfluvAbgHl2xWit8/8KpwebbB
	x0oKziM0LW5w8sV3wWXUhaWVatI+OZiqJunHE+HL+QVtqVQjNXhJka7DoIKnFUEN8prN6xUFmCv
	OzoSSr2
X-Google-Smtp-Source: AGHT+IHqEAnbqZo+Pm3duMlMf9rB8SqxAVEpYH+eDYzpUUTtF7ZxWxDHg9rxsLCyEm8nvzESUmX2NA6ETmwa4R2Se64=
X-Received: by 2002:a05:622a:4a8f:b0:4b5:de44:4ec2 with SMTP id
 d75a77b69052e-4b5de44524bmr44154231cf.78.1757027811489; Thu, 04 Sep 2025
 16:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-4-joannelkoong@gmail.com> <aLksOHVXfW7gziFB@infradead.org>
In-Reply-To: <aLksOHVXfW7gziFB@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 16:16:40 -0700
X-Gm-Features: Ac12FXwf3rLLeSklHNz8LN_IJAUV9KYffTMBORN5UGY0MP4oW8_y3azc_7OO4mI
Message-ID: <CAJnrk1YAiESiSy1rMpU6J+FycXEs1rvkS2jA31jusbNSYVuDVg@mail.gmail.com>
Subject: Re: [PATCH v1 03/16] iomap: refactor read/readahead completion
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:05=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Aug 29, 2025 at 04:56:14PM -0700, Joanne Koong wrote:
> > Refactor the read/readahead completion logic into two new functions,
> > iomap_readfolio_complete() and iomap_readfolio_submit(). This helps mak=
e
> > iomap read/readahead generic when the code will be moved out of
> > CONFIG_BLOCK scope.
>
> I'll have to look how this goes further down, but I don't really like
> the idea of treating bios special in common code.  I'd rather go down
> the same route as for writeback and replace the bio with a generic
> void pointer, and then either use callbacks to process them, or maybe
> have multiple versions of iomap_read_folio / iomap_readfolio_complete
> that just share the underlying iterator, but implement their own logic
> around it.
>

That sounds good to me, I'll make that change for v2.

