Return-Path: <linux-fsdevel+bounces-61938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC202B7F9E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEADA17E87F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7537C106;
	Wed, 17 Sep 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtTJ71C2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2B333A98
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116733; cv=none; b=byva5EcnE9Ek8azVDz54lUVdGgTBqTyijPClm4uAzBFtHZEvwfQEn93o/4pcwsr/D0TPbIW/EoM7vZW7peoz8LikTyOS9iAO2KPZuOSGh3l8hIW7THnHsPJk/9jd221cU6BX8pAs4N1wSJjpUA0ey2LPTxtuXBs2fIf6bLvWQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116733; c=relaxed/simple;
	bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugkPCDBs0DwnPhSXfb4i8tvqKznWDnHTjNy/GPWA3Rl3km7SHy31uUoeyT2KbCSVyqV2zudfVIkRM0LEG2ajw7V1AIoZ7OcU0MJO5jUaQIUT9RfYr+wjBCSxcPl0HfGUGXCcGnoIY9R1r53yR6QeiibtJpjTKwxVO3r2+/Ro1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtTJ71C2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07c081660aso984101166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116729; x=1758721529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=OtTJ71C2+f60SZTiEhIWHBQ4o7kLP6xIlRwXDOQmyb2tfI7Ixqe3jdodyDCZ6I/pci
         VrYugBtsM39gl26uU6q8zCgyF3duHSoLIBD9gl91+nd7Px5uTUgcH93KyfqjILZ45oob
         2hyQT1b5NVbgDk8Otqi+IB+ja1semJyZPKvQsfEAC7hIng7aXqM1XAr15ts6n9oJs0l/
         gNxXp4EOLAnzzRWO/qH2GU7yPe4BIjcYQBgQAwknAMvNqZL7IxAeaJvAQQmxzrM6U+58
         Kh1khv7J8EK+n1DRN18PQrohtPa6NfRFhGUeWL6KmBB8uCPW5EUPeAG+sA/Av8BLTks9
         vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116729; x=1758721529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=XG7EF0YpdDudDjuoPP4kd6870n0ej6ZuhAiKL5fVLCccAY9Bui+fcE8jJSu1xAVaRc
         1X49NioQxtY4LckWhdLi3lVoZKPZMuxRh0iUMCn+05OEvICUUR0JH249kcg/fInXszWL
         phcUkJVSwsWGwJ9bejcFUkm3o+c7NHM+Y/LTo6n2myibQbkvMGg9wuYiXjLz01Cs7aia
         Cpcs6FTfY6Q+xgraueCDcEclvLgTnOTka5Lv6YKtoZTgry1OWqJujbHGrt7J2JchpFiy
         a/Zy9hnEz8jyLCIlcUXafgO/NTG9PnXql08CNna8WkrHhWdUqa0wMNuecpgmnTepxQN8
         zksw==
X-Forwarded-Encrypted: i=1; AJvYcCUXPVjq3T24cq6yMz9mjrI7stuyanLYFNsFJJC0vTtasWhp/zHalwF6b5lmVxR9WWuY4f6n8xWhWNY+Ywn0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhOCiEZDRX+uFVH88Ulc/Z/AsT9d51nYJ0IvPc/btjfqJFfnc
	0CfURnVYuQhJ+agv+EIHQqsowJkSRF23gYgd09VXDq1ETp8kRTzuZfVr19Mi7qWibT+oBujdkRA
	2TBzZeAUTJincUhwKZPpR4ux5P4aueA0=
X-Gm-Gg: ASbGnctD3/NtTqEUwm1rIA+BzfOy/gz/mx5oo94PPDb8my5ASGolSQ7Zyyt1APnPSA1
	roQpmMQLT43bOyAUQ+WzwE/vQaCyfPMBvBbzmTFbqnORzcqCO/PfHlPaHnqqWfZhBt/ElCzcxML
	MXjNKmZ7+aFeSvDi6rjVAzwvg9BIr3cqWfxg3vUKXqjsBQPjC0eYTz0LmUea5OHfNophJqdrcYW
	3HRgYtNa/p+v6QmNDQI1ptZZEPqRndILIK5YBoAGXNFeo8Urg==
X-Google-Smtp-Source: AGHT+IHJjSAqFzQR7vsvzpBHIle/SM7pkbfcfwBMTr+P1896d+alN/SQihemXVKbkiSRCNaNWJtZu6qP46KZEuNFGWc=
X-Received: by 2002:a17:907:3c8b:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b1bb5e56d85mr276690166b.13.1758116728681; Wed, 17 Sep 2025
 06:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com> <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
In-Reply-To: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:45:16 +0200
X-Gm-Features: AS18NWBMJGX1M7gmLnyGCZI8UTIw8c6hYUtKDGdB2cO4qtZ9mDWgO1MIhRf_XYA
Message-ID: <CAGudoHEhvNyQhHG516a6R+vz3b69d-5dCU=_8JpXdRdGnGsjew@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:39=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Does the patch convert literally all iput calls within ceph into the
> > async variant? I would be worried that mandatory deferral of literally
> > all final iputs may be a regression from perf standpoint.
>

ok, in that case i have no further commentary

> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).

Well only changing the problematic consumers as opposed *everyone*
should be the end of it.

> (Forgot to reply to this part)
> No, I changed just the ones that are called from Writeback+Messenger.
>
> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).
> It was very difficult to reproduce this bug:
> - "echo 2 >drop_caches" in a loop
> - a kernel patch that adds msleep() to several functions
> - another kernel patch that allows me to disconnect the Ceph server via i=
octl
> The latter was to free inode references that are held by Ceph caps.
> For this deadlock to occur, all references other than
> writeback/messenger must be gone already.
> (It did happen on our production servers, crashing all of them a few
> days ago causing a major service outage, but apparently in all these
> years we're the first ones to observe this deadlock bug.)
>

This makes sense to me.

The VFS layer is hopefully going to get significantly better assert
coverage, so I expect this kind of trouble will be reported on without
having to actually run into it. Presumably including
yet-to-be-discovered deadlocks. ;)

