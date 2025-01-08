Return-Path: <linux-fsdevel+bounces-38672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A70A065F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C5B3A174A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EB202C4A;
	Wed,  8 Jan 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bseA6JFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86D1CDFD5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367702; cv=none; b=fYdDhbXn6DkhVOa8ZqJ1NRO5YocecjEvDOLP3WRZetfauk0SJRnevayw3HGdmnD8g1Sl6YT1i/CBICDKMiD1Df2wIFknVShtuQ6IIR6bfr6iozJ6y4dUrsRgFlFtwzVvoxHBnFvWxd5Sx2B5uqgtCFvIYigUDfodpjNIuGUmUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367702; c=relaxed/simple;
	bh=5wflBhjiUNpr/VswJMcl+hTRaj/5+pXCXvTJSROph94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG2GWpvum3b9+Ai8aJsHy+O09hBjf0bjdsaqJM18Jv4syR9sX517qkg5yT134o3CroFFLw2c/ai1WYO29lOY2Q0grR6FLe+VzkWfaA3qZ61pSI4Ufl51Wpa7du6gtZc0k68zEavydqqoB2Hp8XRVhIPqOLqwwwP7KfnDfc6G7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=bseA6JFC; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5188c6f260cso64471e0c.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1736367700; x=1736972500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPPOJUA8Jw2xPw/74U7cXu4bDdqVFZi1IXSafaSWjTk=;
        b=bseA6JFCTIy8w8Oa4I0Qs2d9Z93a3gCR+TMdKVvu8LBB/bNBYXuhHbHb7Cmft4Ob97
         +wxzDygUBUT2AqNHhAPHNZRtqA9DrWwjwyTOhnNwCliFrcjL6XLY/Hp8XgN2Xx6Rjs3N
         K6KL0+0YiRbesJJ1w4Mo++OehKOEPNmL72Kw4oOu5huEHPxdVbObFPOFxM9p1MyWQ3jm
         Pvo3lL3xRGzgNt9aZ15n7fYgQEhy6GOoB76IpHLOvvVpATfVHZ8uZz2d3DD/jsyYDzUe
         uPypHGuW17TpzUM9uxVjb48nVCX5BLe0J6WaT8+hOg5N9P8qi5KSH+pRURjdJx3Hh9FI
         QAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367700; x=1736972500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPPOJUA8Jw2xPw/74U7cXu4bDdqVFZi1IXSafaSWjTk=;
        b=V1HKF35keWxUftYgkYms7NgszTtP73ptGXQtZQsBCawTaq8lDRcz0LXgnRk/KZoHdY
         js0NJUJfYLuLHOozqXoNH6nxvIDEwaVyY8flT94B9mVaDLI85WmxanwACABP3JeXB1GY
         l4JOnI4rDYvMXfxggLpmHbF8zAWNcdNWttl2XSqK37VYvjl+TwFLyYGjSIbkQeuTPgEs
         cTgQASuuX0CK/8ogIj8mAKcgJkeHr/+OroEvmH7ChPqPTJsADhk89s6cNMxhQRj1GHde
         Tei381hC+KQc0/JPbDtYylueCR+RkaGg5AoSAeQCmkT0eCiG0vWQcwHbQTni8GZmnI9e
         c2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+MgLx5dc322lBuiNldNscA5RTfjTKRR3kDHeLF4Ob5B9anLemH+pd1j8atpNzlJhNiPSPllWelKFtJxUi@vger.kernel.org
X-Gm-Message-State: AOJu0YysFf2PcI/1OE3AaEIWLMmNuo5z+hcygqTzbib7NotxI4enJVFj
	FuEBEZ7+WWe72BELIG9voQGaBHmfjzfoYKBzu4mKJbqgw48yTh62PV7wUjwM8KNWFM9oVX7B3tL
	+3zmg2h+vQ00BEZlkix7dhddjbRaf7E5RakUu
X-Gm-Gg: ASbGncvSpLBAgRYYGl2waSWEg/cmqRo9h+iazA+d7aVFo+Lp4RBXptYC12TbKvhu1y7
	AwHCG317XLJQxfUgnun+CH/LcAUDSOoIABDdBARs=
X-Google-Smtp-Source: AGHT+IFHh2KhVkMKo0aT26Uap+B0ZFkJ1uI6hFXJsafyzGiQ4oekuz41s10Hh3yymQFUlJjNyYIciu0DkWIOYf2FGo8=
X-Received: by 2002:a05:6122:50b:b0:518:81aa:899b with SMTP id
 71dfb90a1353d-51c6c46b315mr2869063e0c.6.1736367699844; Wed, 08 Jan 2025
 12:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105162404.357058-1-amir73il@gmail.com> <20250105162404.357058-3-amir73il@gmail.com>
 <CAGrbwDRVE8GdAaHmS78yVR3wqLtGwPiR=uHaygcG0moemovH1A@mail.gmail.com>
In-Reply-To: <CAGrbwDRVE8GdAaHmS78yVR3wqLtGwPiR=uHaygcG0moemovH1A@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 8 Jan 2025 20:21:26 +0000
X-Gm-Features: AbW1kvZU_iQgJLn1iamGJ4S5J9bc8duYF27SmBfx7z0m-tmK9TeaH1I8p1ULD1w
Message-ID: <CAGrbwDQprC-F9Pvc6gHu6HTudcQaQG-KF-L3eHmcyz4h+bTyjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: support encoding fid from inode with no alias
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 1:24=E2=80=AFAM Dmitry Safonov <dima@arista.com> wro=
te:
>
> Hi Amir,
>
> On Sun, Jan 5, 2025 at 4:24=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > Dmitry Safonov reported that a WARN_ON() assertion can be trigered by
> > userspace when calling inotify_show_fdinfo() for an overlayfs watched
> > inode, whose dentry aliases were discarded with drop_caches.
> >
> > The WARN_ON() assertion in inotify_show_fdinfo() was removed, because
> > it is possible for encoding file handle to fail for other reason, but
> > the impact of failing to encode an overlayfs file handle goes beyond
> > this assertion.
> >
> > As shown in the LTP test case mentioned in the link below, failure to
> > encode an overlayfs file handle from a non-aliased inode also leads to
> > failure to report an fid with FAN_DELETE_SELF fanotify events.
> >
> > As Dmitry notes in his analyzis of the problem, ovl_encode_fh() fails
> > if it cannot find an alias for the inode, but this failure can be fixed=
.
> > ovl_encode_fh() seldom uses the alias and in the case of non-decodable
> > file handles, as is often the case with fanotify fid info,
> > ovl_encode_fh() never needs to use the alias to encode a file handle.
> >
> > Defer finding an alias until it is actually needed so ovl_encode_fh()
> > will not fail in the common case of FAN_DELETE_SELF fanotify events.
> >
> > Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles"=
)
> > Reported-by: Dmitry Safonov <dima@arista.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiie81voLZZi2zXS1Bz=
iXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thank you for such a quick and proper fix, even though it was the
> holiday season :-)
>
> FWIW, I've pushed the patches locally. In two or three days I should
> have some hundreds of test results from the duts where the issue was
> hitting originally. Judging by code changes, I hardly doubt the
> original issue would reproduce, but might be worth getting more
> coverage of this code.

The kernel with your patches has run some ~500 tests on different duts
that previously hit the reported issue. It's not hitting anymore
(obviously) and there aren't any other new issues on those tests.
Tested-by: Dmitry Safonov <dima@arista.com>

Thank you once again,
         Dmitry

