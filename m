Return-Path: <linux-fsdevel+bounces-20941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0E8FB0D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2392830A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0EE145358;
	Tue,  4 Jun 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HqktHl/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F5137921
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499661; cv=none; b=PsJzXxtDuDD6/ZplkMfc13CDo/Ku3hIi/EwhsdfA2EDgbj+evenE0pubsKyA0r7k1sawsxrp0HM/Z2NT/o501rkyMnNJAn0S5j8kzr7on+4KV7eAqb28PARkQ1esIJxF32kJNpNJvKPTsessXH+smws3R9Oxv0Vssw+Pb/zrT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499661; c=relaxed/simple;
	bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2UmcN7WzXwK/YJ9EmJaZ6zmnmudQsrpM+H2KTMeQ8AeupVQwB6L0D8q7vsH9JN0pOvOihz2EvD7+Qd49k3G4e8IvRWLy8aO2d6k6aa025xOd6cysxGXFmn1e2yWigGwZi+QcriuQURgFgs4if+oOAYMe8IN1QkJ4xkh3Bo7kYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HqktHl/y; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso34056971fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717499656; x=1718104456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
        b=HqktHl/yUJAzNFnAxORkC4KvcVsEvMGytp3raSwv7xvMaX2d97zOkPf3LMZ/CAIKNR
         7fvhHUvuHurVhiTZJOVBtyXZ183D/oJX7INDUNqyBEV8TM9KyAu3X5ifQwKXgjYZfnfH
         3a9OQxmlVsecFCSfUctx3Z54X5RNrMldRaoU2Jx2qj4w1mmj94FimYpUAunyoThPSGmf
         JVvTpN3eSFRFlvviVswHsnXK6Fl6CqD8XIVJ3u7ECvTRKT/B1/HGzmSWiO6D+MvNLeIe
         qVINAiw95Ekf8s/2+8s3JW2/IN2nv57XcqtgBK3rUBSgTRnHWj5HHGCL6WEnGyRmlnai
         G+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499656; x=1718104456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsuAqfneVxExio+uxNqT6IiAZUoZ4GqeLL6RRoRcxmo=;
        b=BbOdJi8SBO82pAhK4v5uQ7/fAUMyNHXXxyNgTwyv8LWWbLqZjKnMccOAelSZVwSs+C
         iT6GS1+h4IR2ztN5kslN/ufm5wRmySPpCPRDv49D93zsVKHpvQgywNiZFoqQuXtg9x64
         K1+cluUmnBvCWUxiB4Zarag9I6BXW6wqpKRbyMX1TUYz9KtoKDyBgUIzgN6QSu3HzGU0
         eoq28C8M7FBFL9FNaiGwRx/c/uB6iCVGMIl53ypoNlE8K2xgnkGC09JJS6rgeaS5hneT
         4iWM7yO6Dx2ZaS5H7V+dC4bl1100X2EeWXOPoMHDgGOHPZ/88iyQNIgzDLoGEdS5lL4a
         XYyg==
X-Forwarded-Encrypted: i=1; AJvYcCVkIbDv1xbx3D2wD7kcEwP/ZOftYlYkHbw1pJf2Jmk+La0nnzt/2IPJKVag5V4M2RZmUFMwdWOPoLGh8OJmPTmGHUV+hVpxci/7PjeC2g==
X-Gm-Message-State: AOJu0YzJTYen7w3snFUK1dzr5sZG9mICNPBZ5UnIlrFWKWohgA01Um7q
	rveMMcvVy+VLyKUEIRo+4aNpiy4EyySL++3MhMVZ/CuVsQEPO8WiV3VNw85iol67uXRIgGAorSf
	KguZVWe8nuMoKEIwEdhaRXrow47NS+OgslT+MPQ==
X-Google-Smtp-Source: AGHT+IGPM+K2hixyRUP9EcOT9Brv7YAnDET3OYQ68QdgVrS8wykAfmjuzPC7P+3Ds9ZEZVrJrtEUH6tY4nUhWlqN5Bo=
X-Received: by 2002:a19:8c4e:0:b0:518:9ce1:a5bb with SMTP id
 2adb3069b0e04-52b896aebebmr8354193e87.54.1717499656564; Tue, 04 Jun 2024
 04:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604092431.2183929-1-max.kellermann@ionos.com> <20240604104151.73n3zmn24hxmmwj6@quack3>
In-Reply-To: <20240604104151.73n3zmn24hxmmwj6@quack3>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 4 Jun 2024 13:14:05 +0200
Message-ID: <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
To: Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 12:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Well, I can see your pain but after all the kernel does exactly what
> userspace has asked for?

That is a valid point of view; indeed the kernel's behavior is correct
according to the specification, but that was not my point.

This is about an exotic problem that occurs only in very rare
circumstances (depending on hard disk speed, network speed and
timing), but when it occurs, it blocks the calling process for a very
long time, which can then cause problems more serious than user
unhappiness (e.g. expiring timeouts). (As I said, nginx had to work
around this problem.)

I'd like to optimize this special case, and adjust the kernel to
always behave like the common case.

> After all there's no substantial difference between userspace issuing a 2=
GB read(2) and 2GB sendfile(2).

I understand your fear of breaking userspace, but this doesn't apply
here, because yes, there is indeed a substantial difference: in the
normal case, sendfile() stops when the destination socket buffer is
full. That is the normal mode of operation, which all applications
must be prepared for, because short sendfile() calls happen all the
time, that's the common case.

My patch is ONLY about fixing that exotic special case where the
socket buffer is drained over and over while sendfile() still runs.

> there are too many userspace applications that depend on this behavior...

True for read() - but which application depends on this very special
behavior that only occurs in very rare exceptional cases? I think we
have a slight misunderstanding about the circumstances of the problem.

