Return-Path: <linux-fsdevel+bounces-16785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16468A2945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36288B2279D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7350A6E;
	Fri, 12 Apr 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lx+6qBiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A6502A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910349; cv=none; b=c+cR7SVEoD7DUSqYnSK6pOX/YczV2jyzHBt7zVIJPMerqsQUUKX56JIeDkpjzclVWn9rCN03uWr12ET8aWMVAhn2IzRF9/uC3u0TKex3eVi9CHa9T07/Ijh40k5WMRxDleNJoJtQsMLf4bDy0AIYolWbQuLIsNE4sWQgEGUXqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910349; c=relaxed/simple;
	bh=Dmo9AHMMGGgPEoVGLppnwNRKTdIgSAyXTBQHGf7tPiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myqvgaaPy9Nq96+Cew0zkrPmDVHL5++3BbAKejD+nTU0JuvhcRVDR+KoXNIYEJ0WCLA738zPa3oQvy99oyG5vy0sJ9ZbNhYvqz76y881XWckXb23LeLxpKNDqt7ABo+KqrebVLd2ghzjkUwjVHAhUrIwCDwg0JbLUKIEBfbvPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lx+6qBiP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200afe39eso69424566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712910345; x=1713515145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmo9AHMMGGgPEoVGLppnwNRKTdIgSAyXTBQHGf7tPiU=;
        b=lx+6qBiPqTA7PS6gOqUaxac90vhjvIrMAwZwWTAxU063Rq9JSMtIWVf+vwM/Dvj3Og
         ZJVv89cpCahZmtSVjKB3OcSMGX/x9dYAgXUNH7bQ44VHR4c2LgY0HbaI2AU95iuXF4K+
         94ybAWN0h4wsWKZ62hSqlvv2ZZFijShndDA/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910345; x=1713515145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmo9AHMMGGgPEoVGLppnwNRKTdIgSAyXTBQHGf7tPiU=;
        b=tahhyQyfD/XDJ1ggtSUVI1G6FOktZo4SwUOLa/ny4e/s7y4B7YqNMMYbnluGFa6ij/
         16lwmVNLUnOtEoQ+RUAeZ5q1jWCz7UmSP9aXHTkQDLVnk+KyA1jVvh9Yo0dQgfljU76R
         s8Sfm0kFvvv6CoCz6D8s2kGXw2QXIyIkSuF3vAg4QmnFMueL+YNlOn44JAP5zOoPEzVw
         wJra9fQfSgyI4cfX3+9i4AlSIXLtfUiVXrsySrQ8LCdK13b2h0rvB9byXeMJHWVFy0j+
         mUWcHTuJntnD/M63LNtK0JYlT9jWPZAdIr03/0+2rLv8hGL/i5q5zUtO+cgHG1lkCG8b
         pFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokA+J4ZsxECS2uOgtMf2Wu3T+/giOM/RXefp2lz3hJtuKbQiE+PdrhDp1pLb3Pa4PR8W8JdB0rRHA+tKg+QFh0YWL3fkLIpEPyUIOsw==
X-Gm-Message-State: AOJu0Yy0Sl627f3J+pjl3nkCLxvuLCHOZ4xXtDi158Q0pBvByVt9uOOq
	h9SuT8mAc9yX6Zdw2Y+PEUAHjk/m0L5e29TgHrEy5d+Ackb+9Ab9LJClPw4Si21Gcb3IJ95rQ2O
	4vdFvNdAm6+heMpvT82owM4ki+c1ncu+gLT+oZQ==
X-Google-Smtp-Source: AGHT+IF/tkpRIAuXyA0t1Y5eApjLqAPPFZCcMNfzMite3UyAln6TWqPxc15w9WzHro50cc0Uh+9DZd+5i41uLfVrPhk=
X-Received: by 2002:a17:906:13cd:b0:a51:aeb8:bff5 with SMTP id
 g13-20020a17090613cd00b00a51aeb8bff5mr1548283ejc.69.1712910345406; Fri, 12
 Apr 2024 01:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240328205822.1007338-2-richardfung@google.com> <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>
 <20240409235018.GC1609@quark.localdomain> <CAJfpegt9hBADfGEAdsBjNShYHB68o7c=gHN29SZHqekdnYzkNA@mail.gmail.com>
 <CAGndiTMNuzKot7fKSE5Hrcm=9XQ-0=KsQCnt4wXVtkq0bmVvXg@mail.gmail.com>
In-Reply-To: <CAGndiTMNuzKot7fKSE5Hrcm=9XQ-0=KsQCnt4wXVtkq0bmVvXg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Apr 2024 10:25:34 +0200
Message-ID: <CAJfpegvt4ivELbyF-4qBRUX7wLxSCwpZ7fg2o7Kry-_gF3kRYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
To: Richard Fung <richardfung@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 21:16, Richard Fung <richardfung@google.com> wrote:

> Would allowing FUSE_IOCTL_RETRY for these specific ioctls be
> possible/preferable? From my limited understanding retrying is
> designed to handle dynamically sized data. However it seems like
> that's currently only allowed for CUSE.
>
> If that's not a good idea then I'll try to split it into a separate
> function if you don't feel strongly about the other approach.

It's not a good idea, because it gives complete freedom to the fuse
server about where to gather data from, and that's just an invitation
to malicious behavior.

So yes, please split the current one off to a separate function and
let's see how that looks.

Thanks,
Miklos

