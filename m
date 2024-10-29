Return-Path: <linux-fsdevel+bounces-33154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693D9B50EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C6AB245E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182F200C90;
	Tue, 29 Oct 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esSq7h+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0E1DACA9
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223089; cv=none; b=E14ALazcSw8erB/BaCA+iZYNMeQBYxMjhM+EGFYzGZ3bHwgwvGJ/LzK6aAt8rv+YpQU1su9bR3xSyY8kZ2bilJwLZVSwKirj2exy8DhbbpGVFmastQ4mVyzQzy9o8Svfvaf07E6HStfG/QXDdsKppuU3AF4Yc7fXXwcsJfSNbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223089; c=relaxed/simple;
	bh=5GuEVkLl2E7AH2QWLhrE2R5V38PFWY5b7lz6e0zRIqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok6SQXm7fLzG8X4m6iNa6QucCwT9+F9KQnxliTOgUtqvwpSdqfUANZSLEAYd7pTZs1iZo4jREWWi/ynbjoTTFpLHuBeykWSdKSmpXQm4Kz3yxblLOWJSC1Ctkf9Vwos/dTF6DQa1pEvGWvzDYS/ac3EpaWkrXByBdAAJRYdaepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esSq7h+0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so126204a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730223086; x=1730827886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5GuEVkLl2E7AH2QWLhrE2R5V38PFWY5b7lz6e0zRIqU=;
        b=esSq7h+05pkcN2i5HdjG55D99C8US1nQLccLAqCOWryf9tOCLaenw0W0cKC9lH12XN
         K0v1l8glLNM32nnh8fEqVqHX/lzbvLjh+QNVYp3z5V/orcEP07G+lke5I3bnonugI2aC
         Yes9uv0ulYBUuIzkUk2aDwsYKUrnLImCPhCn4t93poF8j0iQJTFxy10jW7VX8NfHXoIm
         akKDCOhf48T7vvqOXfOAK7JixWz+XnGylbut2fUO8C+Af9eNl29XMCLmskBuhwVwiIXJ
         Y0MPqY8DrLg8usBOOU+W3zaae1y6GRlpyJxUeETbPDpuofpmV86vN4KBYZfUmsfUpLKI
         NYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730223086; x=1730827886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GuEVkLl2E7AH2QWLhrE2R5V38PFWY5b7lz6e0zRIqU=;
        b=RNfzH9byuLBKQHvnND1tcssLPNxOLuwHARAoATB1babiyrvJjsc2bMSZ3rC+QlbgmW
         N2T8USFADPMFSA5NJtMbw7hX7YdK2cYwWJHJFMUsJJ3nEBMQmNfMQdRBP2H/ZBdHYA6c
         6Dl+xv5l9CAYMAGie8ywB8zCbla/oBzGvWbXo1Evplsl3irDIPHSql9gih7K4Ey7X3sJ
         nPByFIX+A+055wspf7ZpmmYBEZk/8DmL5cru2XnM2ZSDLmo/tC/JjxzNpr+S49XWQG4W
         eEH8rQCUvoGsht80HHoxqGJYMY3doeueVTeNp1cqHOs0Oe9sykzJPC9LbKXqTNUPF0p3
         vF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmwCXBcpusOuHDe2+CS+8Q1eDrIs3mciu9W3tvxx0dONstDrw6I6nsiHYgzn6QoebvuZT8chpsHSZCZI3q@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXwkZmzNyUVBNujuQLISdwPm9s3KWotXAS/b9XNNnwXxlOA7b
	VbvHBioUOn/cS2RQFvR+gGZ/WZVwW/UkRVFsZARfgJRzGpb+MvB8v3xuUOjY1MH0Hp/m02ZS4QN
	PSOuFwZlooB9TNhoSPqlVHGRxJN0=
X-Google-Smtp-Source: AGHT+IHxEJ90gf7HnvXwridsgNCYnQvJ9DWOzdPCn0AZinAuzI1ED2X0yes6xFLkUrMKLgG6kL9Gd8r9r97dW3K6fwg=
X-Received: by 2002:a05:6402:51c9:b0:5c5:c2a7:d535 with SMTP id
 4fb4d7f45d1cf-5cd2e3543f1mr2294787a12.16.1730223085790; Tue, 29 Oct 2024
 10:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
 <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
 <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com>
 <20241028-umschalten-anzweifeln-e6444dee7ce2@brauner> <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>
In-Reply-To: <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 29 Oct 2024 18:30:00 +0100
Message-ID: <CALXu0UcY_hm8y-G1hkP-GgxExCnMSjvXtXnUi5H3RvhLHXvryg@mail.gmail.com>
Subject: Endorsing __randomize_layout for projects! Re: [PATCH v2 3/3] fs:
 port files to file_ref
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 19:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 28 Oct 2024 at 01:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Thanks for catching this. So what I did is:
>
> You had better remove the __randomize_layout from 'struct file' too,
> otherwise your patch is entirely broken.
>
> We should damn well remove it anyway, the whole struct randomization
> is just a bad joke. Nobody sane enables it, afaik.

French Cybersecurity Agency (ANSSI) and the American NSA actively
endorse it, and want to put that crap on the things of mandatory
things for projects.
Maybe you can find some curses for them, please? Linus-style and loud, please!

Ced

