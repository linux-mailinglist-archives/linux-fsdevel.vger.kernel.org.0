Return-Path: <linux-fsdevel+bounces-24925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4A946A93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DFA1C20AA1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF414265;
	Sat,  3 Aug 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZv2GstN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AA4683
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704436; cv=none; b=aIYDj8R72IQgLUEEj93hAjyCLvbATJbIkJWNvwOo7Hz1emZeZw3mdSKyUm4JZiQnmqfjPHvCZkcfw5dtU1SutpRxatPJ6jj2HsJvuPUB31YHkrpiq8VDZP85a6HSzR8cW3MvfWgReMlnMO55HwK1dno7vASsnPg7Kk+cPqIJ70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704436; c=relaxed/simple;
	bh=id6D9khfQYGPqjYICcde0Z/uj79oQ2jUL/FDvs207a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODa2CLC1wcR0kkzD68VsTtDlgIsfiUJ2M49T3mx/S6fI/ERPvKFdofb5zWOWiNq/ctxJlYTXbNgPQigtHjgv06ecCoIY80v4nlk6BeKCfb0KrFKdTzLrUuyCDRVRO3cRU8Yyk1hRNt5qVbpL9jbBTUZmFl5BQv/YObFhk49JsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZv2GstN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1dcc7bc05so564261785a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704433; x=1723309233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC8aoE+Oi87dl2bwCkuDy3tS6yNXiypa2egwfzVBvDs=;
        b=DZv2GstN+wdrSkrrEGL8l00vDwoDov3+g2FV4M00eOJWfbmN5cyhIkqw3Z6iELNlLU
         YKf7T62GMzOcjwGhzgMwnsnYCAeAw4jrI25UaH56aTOiW0iPhVF+v44Ut7Tv9XxsvQhT
         Kk2T+0HvhZIHzVccVgGGvYPnOW/e3d1rQViblREX6UP7gzD8m4ppsi0umpD50SzefzZ1
         hZISy/+ajjGTh+kvFIsfgPwraDCUmHwSwbYFuzIJdwJVhJ3b6xSyDX6YT+aOWoVYdBaV
         DLEyboa5uW61YMV1ub49Eku8f4HYE/Jy/iBIZwwveP5rZSnU7Ntx2vQBuVAcyhdJDych
         5/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704433; x=1723309233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC8aoE+Oi87dl2bwCkuDy3tS6yNXiypa2egwfzVBvDs=;
        b=NhXTlK+aNeAyoSjpF1scMDDV6L8KP9uR+U821wbF7QBIqPyyn6nYHm7O096VDDqM2s
         WRNIR5yg3NrjGOJwL29EYSdDW39qO3y7Wxl5CDw67r0pT0Z3qYz3VKwXESXk9iyb4KcF
         Qw8uVOKc0WytsQiJF2o1skk/GcmFO5uG70Q4z8CzDnIB7lTZQAcbEp0t4qrDEuLsCXIR
         BjGvcdW0ay6hqycydbS/hz5UXSEgFvETa1ODUhB4xrYUenlZ+YZJn/MzpafRfwIHpyL7
         cXJdUu7+zbr3QR2l8qFF6uemlz+4Wo6pTDbJNXgI6RTNshBK51qYT7zAkR2YrgBWKKWr
         Vt4g==
X-Forwarded-Encrypted: i=1; AJvYcCWXvSK7MLLhek0M5aET+LJydShjkas90DkuXwuRoc620BUh+bW/ZHYWjXXx39nOJug7fcBxOLoPPPUKrezWnohJrHpeOMmqOpHMdQvD+g==
X-Gm-Message-State: AOJu0YwKkwgj4hdrCgNOuGzL0nwJ/E+VEX8ViVBu2oSWHxlqH497LBRk
	7pFb2Oh0FiELSuEYLtLNsz0BvAPa0ynT8VrfHplwo8j7K8pvyBnSefb0b3Gc7p2n+DEQt7rAw8T
	N/YWFYIArE973gMl975L9uYqSJ8I=
X-Google-Smtp-Source: AGHT+IHGSNyHkYt5ejQ3lmbYKy3yP32evyGrJPRD2IorP3gn2D8HMKjrbPzTDuz3x+xezs+xWF8/9AWUWQEK/rt4oDc=
X-Received: by 2002:a05:620a:4711:b0:795:2307:97ef with SMTP id
 af79cd13be357-7a34eed18f9mr767935885a.6.1722704433379; Sat, 03 Aug 2024
 10:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <bd00d41050b3982ba96c2c3ed8677c136f8019e0.1721931241.git.josef@toxicpanda.com>
 <20240801171631.pxxeyiosbdhjzfvx@quack3>
In-Reply-To: <20240801171631.pxxeyiosbdhjzfvx@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 3 Aug 2024 19:00:22 +0200
Message-ID: <CAOQ4uxj+N5wQMOVXEUwWOgQPYipAtZNjxEL_Mu1G3V8us0TKRQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] fanotify: pass optional file access range in
 pre-content event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:43, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > We would like to add file range information to pre-content events.
> >
> > Pass a struct file_range with optional offset and length to event handl=
er
> > along with pre-content permission event.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > @@ -565,6 +569,10 @@ static struct fanotify_event *fanotify_alloc_perm_=
event(const struct path *path,
> >       pevent->hdr.len =3D 0;
> >       pevent->state =3D FAN_EVENT_INIT;
> >       pevent->path =3D *path;
> > +     if (range) {
> > +             pevent->ppos =3D range->ppos;
> > +             pevent->count =3D range->count;
> > +     }
>
> Shouldn't we initialze ppos & count in case range info isn't passed?

Currently, range info is always passed in case of
fanotify_event_has_access_range(), but for robustness I guess we should.

Thanks,
Amir.

