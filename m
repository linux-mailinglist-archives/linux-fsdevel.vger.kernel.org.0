Return-Path: <linux-fsdevel+bounces-71456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E7CC1A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C003022D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314133A02B;
	Tue, 16 Dec 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baCwjZpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4E339704
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874994; cv=none; b=FhpxnKTEi2GeUrU1iOUyBiVWhOM9p6HL5/iKYoWquyRVoXQtiEJ30xWGfg/J218IWwTbiaqajNU6MBG8+v5B8GrBuMMMSH+y4q2RDGi2B17mLoJfbLATC53y5xJiqf7I7Tok2h81g4lmlVcbQPlWdR6fdxxAteRaYe2AojWmCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874994; c=relaxed/simple;
	bh=wmB7jByI3tyTtYmvEQrJuXCiqFGmbXPnhndNhQ6oLlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlwmRvsEacL6nhiu4b6zI5iOkr7rAGHhyvMCKsL1jwvvyUHEjw+8mZXtbgYWeeDCcY5OKMRsXcwmwjIn+JDSWUPMDmUiVFZo0jO1PIo/rukucSz0nZJR+dgW/jO1sLkpHPRfE6uYZrtaHvJ3RNtzg+yF9CSKW4dwZi9xxqJEymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baCwjZpe; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso46197951cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765874988; x=1766479788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5VJ9mS7VUHEyMDLP0cVKFZtYw3s2Mj6jZMCjAh9oIs=;
        b=baCwjZpem455e0FmndGq79NBgB8zBqLFN23OpHof27T1BlFWm8D69gk0Dlbk2tksI1
         jLb8qKnoSVhQtegq7z2xTIZ92wp0UrdpMwlMCy1rdSJJYmJbAvncA1WE2lZP4/HPhnUI
         qK1+dEAbwIvSsFyZaNdQiwr9VEZjr0m8y1R6CVcw8quXYSqNoka2ShdjvR3fqEDcV/Ru
         TMPEui3B5FeGVfgROvU+hS1YXMcMjpwntAd3+8HLsiF7utu7yTJscFrXD8wxCV1k1q73
         TwbI2aPi3fSPl8xibViXNoeB126nvPIYD2zBHsxWHqUmUBjFBtLaK2KcKaaEkoRYLMZ4
         +xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874988; x=1766479788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5VJ9mS7VUHEyMDLP0cVKFZtYw3s2Mj6jZMCjAh9oIs=;
        b=pfbOpzCZeglGRKNE/J4+KPYnxEZSudr8qcHyrgn1rB0P1ag4VlweyGRm8LX9PA9XcM
         8R0xcVOnlq+9XIZI+6iFSn6A7KUIsDDqvslDXlwLGTLmSIGQMOJRUIGmZ5zzI8bIXQel
         7AqN7SbDvUECr6cWhH0ZegwVbYZYnA7KQABSoEgbOyaJZ03KD276dn1z2rr3miaW92Vt
         hI4G5ic5nwdo1VyyscLMii69KimO4Q/tE0gY4jdh8v0Urd4m6Vlo6Z49yIr9oz86jAm9
         O4cBYJMyQR/IIoAX91TS7uVkduIojbH+sUyCYzlOhhdsq+KaXDK1UNnlPXB0gaOglnKh
         eU+g==
X-Forwarded-Encrypted: i=1; AJvYcCVYcs1GVj7nBu2zrQda7hvcOP4jF59U9Xs20kAUOKDKK5JHhMyayXaaWDx82e9vVOGgSc9/nxtYgG5PHTVK@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXiOkYmnvAR6Ub6IEVN/+teTAtquR5FUPUyjifsaqn+WMl/KD
	6GFg/cEyrlqi65CwXmNKGbeD5LzIhNXQyQCZdl6t3KJw42aAAVsmcwnQHy15zi79KT/WSuobedv
	qX3bQzrWpYVgdqqreGUeojZc3VG2hx+Ek+O+M/4vSCw==
X-Gm-Gg: AY/fxX5D36FcANG+tNRLfLtqxkQ61Yxll8J0/leyWelCRLrhLIqfjvl6frEaJtvB2Ql
	nXC/YDldzDoDq7hQWGj91hcd0bksMipGpaVhw32isZMJxakWpsz++X/umODpcr6+SLUsfaw8pga
	S1UFQBVBKmgffukUd7xwlIqF3PQly+mficmWOFezYbLsMV1ACmL9T0eJIy2WzCVWzvXfvxL3Ki4
	qy8MlIWMUQgwGRSKwGc2a7bggbQBophGegoxVXg8j0sGfJWFjrfFFM+YYGpzRBtFnZFWdHEJQW3
	ldKM0W2cvYA=
X-Google-Smtp-Source: AGHT+IECrDzVebjYtq/j1XTKdU6nDaq7/PD6HFDAbFtjf+wkpYb6XSlwKzq25Wgyn6W0wfaemQGWDP/UMyCYv3mA4Sc=
X-Received: by 2002:ac8:6903:0:b0:4f1:ab28:d9f6 with SMTP id
 d75a77b69052e-4f1d04a8c54mr165998531cf.26.1765874988539; Tue, 16 Dec 2025
 00:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
In-Reply-To: <20251212181254.59365-5-luis@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Dec 2025 16:49:37 +0800
X-Gm-Features: AQt7F2qIaWWyTFzj3fOBRQtLpGiz5DBl_A4i1m6y5nAUQBgCQl2uQfs4TEHUo8I
Message-ID: <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 2:14=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to incl=
ude
> an extra inarg: the file handle for the parent directory (if it is
> available).  Also, because fuse_entry_out now has a extra variable size
> struct (the actual handle), it also sets the out_argvar flag to true.
>
> Most of the other modifications in this patch are a fallout from these
> changes: because fuse_entry_out has been modified to include a variable s=
ize
> struct, every operation that receives such a parameter have to take this
> into account:
>
>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c             | 16 +++++++
>  fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++---------
>  fs/fuse/fuse_i.h          | 34 +++++++++++++--
>  fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>  fs/fuse/readdir.c         | 10 ++---
>  include/uapi/linux/fuse.h |  8 ++++
>  6 files changed, 189 insertions(+), 35 deletions(-)
>

Could you explain why the file handle size needs to be dynamically set
by the server instead of just from the kernel-side stipulating that
the file handle size is FUSE_HANDLE_SZ (eg 128 bytes)? It seems to me
like that would simplify a lot of the code logic here.

Thanks,
Joanne

