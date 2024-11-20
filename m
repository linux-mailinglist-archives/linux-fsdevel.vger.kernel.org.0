Return-Path: <linux-fsdevel+bounces-35336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D89D3F8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815691F210A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484D1552EB;
	Wed, 20 Nov 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2hxbWCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2414F126;
	Wed, 20 Nov 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118266; cv=none; b=cQo5M+9V376X5sGnLFfE96+Wb/6VnHvD95S+hoqce4pFuh1qVfE6R2nrGTwNffnfmGG17K8Cxmxl2MWeE9X3iW3AU8k5XgYmLRq31Q6M58qaZmd3YRTAdecaiG0VOU3/u0yUsBHwhx8YiTPxZLt8s7agGQgPNW1gne4RVRFAYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118266; c=relaxed/simple;
	bh=WRGyncbrrXIdlAfsQ6zZKXRnlgyQmZYvHV4189k1IoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1QJnPk8gF3+XUePHEhPvyTQYqrx7RQY7HmSwZvw87aWNpETRr/ylkoJW+JEm8TWo/V1zQ9v+0yGXUPQ5Ie6QpsdbWnbi+SBaxbZyWGjBMaxIJpq9O1E+ctMn+z1PO2uv4o5kt4ZyPCHj5KEP9iCbC/xEN2FRNffpHg9qN7/GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2hxbWCg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa4833e9c44so277514566b.2;
        Wed, 20 Nov 2024 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118263; x=1732723063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRGyncbrrXIdlAfsQ6zZKXRnlgyQmZYvHV4189k1IoA=;
        b=I2hxbWCg3HPw/t4HhcwaklPllEqR0ht7Dss6DB9p8UNV/aq0k6gix4kceJiOmqttoo
         ATbutt51T1Aa5uOeP1fXtAm6KhycIoQNwspsUpfKffuETUeJ1J0Idbs58CYc5JuXrAAx
         h5ZTse02yglHaUlsVMMoSzfY+wR8T8aIP/Dh+rDt/b1iz4tEzirjOO/V7r+IWCTLvA3J
         1Zzw8qBYyTKhQfEXADk/WtZmZWROaaKUm4uQRiWObVx6A2+Ge40HdQwMQPHxlUBWg1iD
         2iWZ0dlprw5IJQgzCfL8h/GIJqdJj0ekkakGIXXUeCznx8Y/AaQxrPJukhWkJGKzLfCN
         5Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118263; x=1732723063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRGyncbrrXIdlAfsQ6zZKXRnlgyQmZYvHV4189k1IoA=;
        b=eVRvHQLdie8eGCJ+J2mBNY3fBKqkkY9QmGcfe7zXCEnqHL6IMooHzaSRWFIYpy7838
         Ylwcct3OwvHWxNEtSsjC9RFJNWKfFbGwgu5LkKpOjr8fp0kl2exs5tWbYuoOkJzLbqrA
         wwaGCfkii2iW5HMC0JOI4YtkYXvCarDaBs2GBqSHavfuWuN5lcIR1soXQySTPp/c6uFX
         K48p9RNHfNaMgDUjtTzm1aaB0Xg/Y2IsBXcVv//kNYkhnLe+qkz8Dp/FoXDbuG2xzqtb
         3SsUrsqtAucz37zaLMAJTq8PZsRIDCWfzcS4etPYPJh7pSSXyjUEbczhKni/wZPqcMVS
         MoQg==
X-Forwarded-Encrypted: i=1; AJvYcCV/fWy+xCk6qX85DdUbMYeyUtG0SDSo4IxJnttRkZMWquFql8HL8J2lMjdOdyDeWatoAymqui6JGACEpA==@vger.kernel.org, AJvYcCWQbADsG3KLYbk14IGMcBGNx6FGU3zN57MazLt3us+q8ecbIU+N7+VxQBR1sVDe/sD3kJ3kffXsiFUA@vger.kernel.org, AJvYcCXOOJ5O9HnWFs5lMDhJD0b7/0HC6eFoeWcD/MykhGRJzSBuTC53kNaNdRFKrw8bkC/h1NEMcLpVMFBsL8VZLw==@vger.kernel.org, AJvYcCXY0pUUw6PKhfiBHLToLceKhhXhtrVUrWFjukTxOOBAadtr0B9LUl6ZIglSMFpG0ZOWx8M72fo74MiXlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZDbpjS5e682pRm4YmwIxlYCXoMvcOLrjvTXhUsBWAxG1HpKw
	rGz6wwzFHsVsCjzr99PbEgrQMugTuGmg10QMFSqcDfyMLn/oAwTth2TJD09xL2B7Eo385LslifR
	yD+kmaTD9RjpaWRLCSWqFdPAdF/s=
X-Google-Smtp-Source: AGHT+IETTaFGIGc118mum/twHaBKzMangpXAjhXpkJ0HKu8j2KHFNfZ78kJMQvPrrL5BxWEBj0d7O0zBog2tCKNlcyo=
X-Received: by 2002:a17:907:3687:b0:a99:f972:7544 with SMTP id
 a640c23a62f3a-aa4dd70b6c4mr310564366b.38.1732118262269; Wed, 20 Nov 2024
 07:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com>
 <20241120152340.gu7edmtm2j3lmxoy@quack3>
In-Reply-To: <20241120152340.gu7edmtm2j3lmxoy@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 16:57:30 +0100
Message-ID: <CAOQ4uxiyAU7n4w-BMZx9gzL_DTeKMPkBOy9OZzZYEsqkMHWAGw@mail.gmail.com>
Subject: Re: [PATCH v8 09/19] fsnotify: generate pre-content permission event
 on truncate
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 15-11-24 10:30:22, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Generate FS_PRE_ACCESS event before truncate, without sb_writers held.
> >
> > Move the security hooks also before sb_start_write() to conform with
> > other security hooks (e.g. in write, fallocate).
> >
> > The event will have a range info of the page surrounding the new size
> > to provide an opportunity to fill the conetnt at the end of file before
> > truncating to non-page aligned size.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I was thinking about this. One small issue is that similarly as the
> filesystems may do RMW of tail page during truncate, they will do RMW of
> head & tail pages on hole punch or zero range so we should have some
> strategically sprinkled fsnotify_truncate_perm() calls there as well.
> That's easy enough to fix.

fallocate already has fsnotify_file_area_perm() hook.
What is missing?

>
> But there's another problem which I'm more worried about: If we have
> a file 64k large, user punches 12k..20k and then does read for 0..64k, th=
en
> how does HSM daemon in userspace know what data to fill in? When we'll ha=
ve
> modify pre-content event, daemon can watch it and since punch will send m=
odify
> for 12k-20k, the daemon knows the local (empty) page cache is the source =
of
> truth. But without modify event this is just a recipe for data corruption
> AFAICT.
>
> So it seems the current setting with access pre-content event has only ch=
ance
> to work reliably in read-only mode? So we should probably refuse writeabl=
e
> open if file is being watched for pre-content events and similarly refuse
> truncate?

I am confused. not sure I understand the problem.

In the events that you specific, punch hole WILL generate a FS_PRE_ACCESS
event for 12k-20k.

When HSM gets a FS_PRE_ACCESS event for 12k-20k it MUST fill the content
and keep to itself that 12k-20k is the source of truth from now on.

The extra FS_PRE_ACCESS event on 0..64k absolutely does not change that.
IOW, a FS_PRE_ACCESS event on 0..64k definitely does NOT mean that
HSM NEEDS to fill content in 0..64k, it just means that it MAY needs
to fill content
if it hasn't done that for a range before the event.

To reiterate this important point, it is HSM responsibility to maintain the
 "content filled map" per file is its own way, under no circumstances it is
assumed that fiemap or page cache state has anything to do with the
"content filled map".

The *only* thing that HSM can assume if that if its "content filled map"
is empty for some range, then page cache is NOT yet populated in that
range and that also relies on how HSM and mount are being initialized
and exposed to users.

Did I misunderstand your concern?

Thanks,
Amir.

