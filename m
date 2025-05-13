Return-Path: <linux-fsdevel+bounces-48900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282CAB578E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9193B462FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188CB1A3160;
	Tue, 13 May 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bj/xFq04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036919CC3C
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147758; cv=none; b=pYCDQvwvCn92sIiClVzM+puKfLl6AIvDZQwJYotOHGBvMYGPtXW9h5Ds1JSWCzUKyRJ2FXMxcuC6Yp0ywfOVTPuHCWRL6oaJtnwfcXEy9OsUlI7m1IrZXrYFuopmO7swv2WE7NlebIoC6M9yHffVlfGJh0zPzJx1+9pOlmHMSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147758; c=relaxed/simple;
	bh=IH30o/V3WHvNch/5VZ2PDe0ULLqMzq5nHXYVrtZBu2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBhy0BqfN4pBz0s4MwSxUydHxTISURwjBlxYJ+n/3s7MEL0uD3xfjWYs82/Y+ENMlpBQm+UdvtOxrgYxchD+3qUKM6tHzK5OzBsQkjjccslQjBpWo/ZUbQpaZYNWHevh8TJmLTq8NZm0T19hWBfwfJwRfBpd9FTWl3L1mFOFqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bj/xFq04; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476a720e806so56681961cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747147755; x=1747752555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INtm454eLGLygSZvRwYLObcd+22LA4H68yKi06CR67c=;
        b=bj/xFq04riIveZFr1+ySeYCrlH6QCPcXUGVirrPJmk6D2LvMpt1IbcEle2EP9n2/bj
         Oo2xkZwjMTv6+rASJOyFwDrwS9QG93e6a7yx87fJPsHDyonf1ADOVD/SeRTIWHKCJUeC
         Ak1FKvcMWHGfeNSdEOo7UE4lX8xwPztdxSymE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147755; x=1747752555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INtm454eLGLygSZvRwYLObcd+22LA4H68yKi06CR67c=;
        b=eAYTEvnWygylquUoPly99JppV820EzH7C1pitSOipMYFOwX7oIgHQ+9FKZfrOBL+kq
         uXHSb4JXLFq8SReT++FvnRppQpd3PqGS2kZiZXVBUr3Hr7bLS2/fVjnSOG9V0gKvvWWW
         SXvPw5QV0kUJN1Ja59s5+x1/yx/ZpOsYSTT21b+w2tkRLTVgyTfp60gcU0tQhX2W1ReC
         VT5vjcd4wUWxKWNswd2oI9QATsmWOMLXu1cz9OaLuwPoxnT2XqkZfDrM3dJkuqJI9XGA
         2viFsvOdRCTH2LNaywJJpxJYkSn838fCQcvbCIio8QB+Id8ESGhSMjyVHyiN5Vimq0y9
         aYAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPO2elWAzuDRkeN1XORa1FJ8xZZfOCsb9xk3ZSGWbqorRyg5vAe5ZvBMxYqVC9gR2zrgQVwqcTAV9m0gRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxs6ti4lF4Qe+QCpqlPh1TOgQ3Q5Jao38iNO1+qNl9wnXTMOsq
	976i9T540K7UAM85BBoY5b8vyMQev1HfDMJ7/KyrHiv9LZ4VeLsufXfl+J4YcRPmDocW7zzJZjv
	fmY4jzV1klf0/6ghAYe+/jk3yVGFe87uase21Ag==
X-Gm-Gg: ASbGnctsg8OGms0PmEEnmRM08++uUegh7zd1GzmZY9QQGrFFabCFtn1DnKK/H10nH+t
	/psUZSDceolexhmY2AiigedkLGfHxS6rRwzQ8ddbs0iWOGBkp9uLkBdDIghAyPWkiXtaOun8RLA
	UDFoioVcqtKdSQ3IeaROEYvBFiA3wNa+0=
X-Google-Smtp-Source: AGHT+IHMi0b35guHXrgTtiZ4j0wyseNTm6kwyQgLvmBJw94DJ3doIxx6ELS5Iqpew7qaDUBqUQqKzwbuOQT9yZ9ZyN8=
X-Received: by 2002:ac8:57c8:0:b0:477:c04:b511 with SMTP id
 d75a77b69052e-494527633b0mr258676151cf.31.1747147754944; Tue, 13 May 2025
 07:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
 <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
 <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>
 <20250513-etage-dankbar-0d4e76980043@brauner> <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
In-Reply-To: <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 16:49:03 +0200
X-Gm-Features: AX0GCFvyVWM0cut2uVH6adta3DCW-B3pHCICF0MF4L8XeLO3CDW5Uw88AbDAlUA
Message-ID: <CAJfpegvFsWyUsDcN7qQOEArc6WF9xre+gkC_kjgbyXPBHM84kQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 09:57, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 13 May 2025 at 09:39, Christian Brauner <brauner@kernel.org> wrote:

> > The xattr system call as far as I'm concerned is not going to be pimped
> > to support stuff like that.
>
> Heh?  IIRC there were positive reactions to e.g. "O_XATTR", it just
> didn't get implemented.  Can try to dig this up from the archives.

Here it is:

https://lore.kernel.org/all/CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com/

Quoting Linus inline:

| IOW, if you do something more along the lines of
|
|        fd = open(""foo/bar", O_PATH);
|        metadatafd = openat(fd, "metadataname", O_ALT);
|
| it might be workable.
|
| So you couldn't do it with _one_ pathname, because that is always
| fundamentally going to hit pathname lookup rules.
|
| But if you start a new path lookup with new rules, that's fine.
|
| This is what I think xattrs should always have done, because they are
| broken garbage.
|
| In fact, if we do it right, I think we could have "getxattr()" be 100%
| equivalent to (modulo all the error handling that this doesn't do, of
| course):
|
|   ssize_t getxattr(const char *path, const char *name,
|                         void *value, size_t size)
|   {
|      int fd, attrfd;
|
|      fd = open(path, O_PATH);
|      attrfd = openat(fd, name, O_ALT);
|      close(fd);
|      read(attrfd, value, size);
|      close(attrfd);
|   }
|
| and you'd still use getxattr() and friends as a shorthand (and for
| POSIX compatibility), but internally in the kernel we'd have a
| interface around that "xattrs are just file handles" model.
|
|                Linus

