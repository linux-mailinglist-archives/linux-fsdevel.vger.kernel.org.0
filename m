Return-Path: <linux-fsdevel+bounces-40993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA06A29C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 23:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460A318844C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281821505F;
	Wed,  5 Feb 2025 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN6TKQic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CB1FECB8
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794040; cv=none; b=fLnsmhIj2QFCSzlWoFdzY/Mvm9nhVbrtIxC6XdChn7jqDkdyhgOmTbw0brHK3MOqryFmIry6WFehd8lBQnIhlZ+PXCxLu6H3zcqEBHMRycEyinRqYUkX0+Su/mYLPzHdGWIgrza5Yv/Q2gxU8i4sa683ZnA3h1fhbYJEvZuwhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794040; c=relaxed/simple;
	bh=2sAWp4BKRstE/uqXvvY7Uwb0ApJSKVu37ES7TDFqVLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RStDcbnSIfjfmDLFt7CP7LO3v6anqT5faxQ/rPdMI/6ARju9EfSXz2lZ4It7otLK5jmWcutCsKnY2fVYZvdYYGpuSwFAmKlAk3voP63mmT9BxBM4DjjC0pc3arGEukc9iRc3ODB3911c9tA5EK8CleMqHxDxcLovOYfH0d1kOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN6TKQic; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dce090bbe5so705121a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738794037; x=1739398837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sAWp4BKRstE/uqXvvY7Uwb0ApJSKVu37ES7TDFqVLI=;
        b=gN6TKQic3yWcVowR4xBtR9NFM1CLc5/jtwM0AXYkzMW/C42/oe9yR4pw8X+J3hL61Q
         M2XCu78eCbEPtQNtADVOaIoNMFRBXOTmbQ58GeudajYBKPVDrz3WassO5xGWHYN3qyGl
         rLRkfWBEE/67ihP0qxODahpnqGb3oanp4LtCXqktVl5exf5OAa2GTpthyvFhEFFY4Zal
         M7O52XllxqwitkBw8xPbLiEEVkPhzBFOWQi2CkBAltQhpMP2OQhPQna+ECjeVkajvnOI
         QsBRVKQ4EMr7rDyD/4oG9N2Vm0ILkUjtaMoS9fDRI3fPvLZuub7msINxy0IyBBUndZRW
         lkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794037; x=1739398837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sAWp4BKRstE/uqXvvY7Uwb0ApJSKVu37ES7TDFqVLI=;
        b=iA0JpgbgZU99DFpeGinSTb5yF1HJnvytBu/T9gSWeyL7uYVPPdHjOk/fCFrQkPP1W3
         M9wkRqo9kTd14Vo30i0Vso/iKVCAhSaE/KMV1rxlGjEYNnfYavxYRv3lJxKuxYiERiEn
         0JokbxRnKmJiqVxYSFuRw2qwgyOlJRQXcczFF5y0BW9dXcJNdY8nG1/eXX8cKe9Y9G9C
         HJHMeMUBrC6MLZ2suJNVNvk1d7E5WO6XmAlEgeG4CGpfigCS09G3//D6B9l60mDzpU/M
         BP732Ysfw0APZl4WzcRM64mwyf7jU2/FScRSHunNWuubBzRyNsXDlbVLSSF3Z5th02P9
         5UlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwlGBkKUJcRwwYjC46yuuy0vnKUDJhyR1LWmFwZ2xLwtWRt2BvRcuYzlNrQEo7z2f8zr2q8Qscm8ONxsZd@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTLzXu8dho6UiOFMdSkA/Og7JuXnXhvANqXUK6VImC1t0rW+y
	Ks/wExs6pf6K6Uu+DMzG55eftaqBKKYw0JHR8/2XUt5GhZbDjdEYlwy8id4mE0Xm9BikDr/zlxt
	rx1Dwht/SnftDTyUa8rCSWX0REpBdn5gTjto=
X-Gm-Gg: ASbGncsVNC/fwn9PzuEGAMUr/dQVSGPGpscdEZT//RGCDZBanLZgcqkmsaETbr46zn3
	ZQpUlYks/+YPSQOCtJFgpwlDqLEdocne+QgRTuAHe7PbVtaaSunKmI2k+o2VpCuwZnjjnu53r
X-Google-Smtp-Source: AGHT+IH5TpoDgyQPWVeRK3ow35/WZY33GB5zo4TsmXm8JpJc9Wl0NVL7L5IVXN5uG5NVxNeFSoz0/rMu6oJLV6g1CNs=
X-Received: by 2002:a05:6402:4342:b0:5db:68ce:2125 with SMTP id
 4fb4d7f45d1cf-5dcdb717867mr4839010a12.14.1738794037143; Wed, 05 Feb 2025
 14:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223205.861346-1-amir73il@gmail.com> <20250203223205.861346-4-amir73il@gmail.com>
 <qenzc7wi2ojknvcch7d4xac7p7fh7p47bws22fpuuiqtwpsbs5@wfk6rnyxiece>
In-Reply-To: <qenzc7wi2ojknvcch7d4xac7p7fh7p47bws22fpuuiqtwpsbs5@wfk6rnyxiece>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Feb 2025 23:20:25 +0100
X-Gm-Features: AWEUYZmAKrPTD63puhFUEqMY38TfLlyRqoHcSg0iEZSP3HRtUCfnqH4A8rFFnwE
Message-ID: <CAOQ4uxgF0j-VXz+6=J1B3ni-RCBTaRs5OMbqp9rv2_u=wXWfYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsnotify: disable pre-content and permission events
 by default
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:59=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 03-02-25 23:32:05, Amir Goldstein wrote:
> > After introducing pre-content events, we had a regression related to
> > disabling huge faults on files that should never have pre-content event=
s
> > enabled.
> >
> > This happened because the default f_mode of allocated files (0) does
> > not disable pre-content events.
> >
> > Pre-content events are disabled in file_set_fsnotify_mode_by_watchers()
> > but internal files may not get to call this helper.
> >
> > Initialize f_mode to disable permission and pre-content events for all
> > files and if needed they will be enabled for the callers of
> > file_set_fsnotify_mode_by_watchers().
> >
> > Fixes: 20bf82a898b6 ("mm: don't allow huge faults for files with pre co=
ntent watches")
> > Reported-by: Alex Williamson <alex.williamson@redhat.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/20250131121703.1e4d00a7.a=
lex.williamson@redhat.com/
> > Tested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> What makes me somewhat uneasy is that this relies on the fact that
> file_set_fsnotify_mode_from_watchers() will override the
> FMODE_NONOTIFY_PERM (but it does not override FMODE_NONOTIFY).
> This seems a bit subtle and I was looking into if we could somehow simpli=
fy the fsnotify
> fmode initialization. But I didn't find anything that would be really
> simpler so let's keep what we have for now.
>

Yeh, I noticed that too.
I did not have a better idea :/

Thanks,
Amir.

