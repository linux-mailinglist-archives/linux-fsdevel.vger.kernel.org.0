Return-Path: <linux-fsdevel+bounces-50901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E1AD0CE4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B0217051F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910021C182;
	Sat,  7 Jun 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiQ2Ns8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172D13AD38;
	Sat,  7 Jun 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749292879; cv=none; b=P4+bsQNDzaQTF8N+SZ0sfeIqC0mqmK40JNX/ZPVTT/THD1StmV7VJRNceqLyTlBys1g9m8BmKGVrqDdnq2UqAXy331pJ2x7H5GX6fqAHlcAhw/3+gwXMNnU0EpWsfQI3OIXgFKVwQBnxyv1HZsFcUqt7Vcb7zP0kvp7rzHbr9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749292879; c=relaxed/simple;
	bh=Jn2nwtxhrD0LiVtEA05ZWEGUVk8dP/GC/5zmOhse/KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOE2E/AbpW1haE8wgtm8V4iD+We1VTjgUoWHj1TgQ+0RT6KlcIug0aHoMDVsRgMdMEIfI/ex9Ghr2kDGZcNxh4gBtD1q/gcmE+iymAnAnuYISOhKU7j+QZ3mIkCPHwtATDgvoUqcxqaCTOnGf70i8uxYnv0TfUlBJ8NXU+k4vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiQ2Ns8u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad88d77314bso554988466b.1;
        Sat, 07 Jun 2025 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749292875; x=1749897675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCc2AL+8GYTHWfaJdKFHyFfLcbynW+S8GO3AirZCWOg=;
        b=DiQ2Ns8uchRY1v4BGuyu8aMjJjW0m3g2oeLWR/Fvze6nVUyR2tIMIc2T/KXzPltn7h
         TsNFVOw4WjNXhv8AuWng7HxbRt/NP1fElC5kRV4GO4cyEGT9W8iwGz6wRP2nATLTnzIx
         0WLWLiV0OoqQPo+DLN0XL78uNtQHGDw6GK5Xsu9jbuSDekFUM8z47fP1ytHzjQjdaedy
         ApPLw6G3w2oVfUp+MOjkJlRTo81naC6z9RUHBLif2tGdtYJBjtAHIQIT71exNafUkF6n
         gawdd3fyqAE8FmBwGrMXdmuWGZ/xL2aJr9QdF4D2xc2L8CaH+/rgWxM5/UyWhmBTXpqU
         Qinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749292875; x=1749897675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCc2AL+8GYTHWfaJdKFHyFfLcbynW+S8GO3AirZCWOg=;
        b=mjd5PJ9sQ3pOdDK+hPjrro4xUDNcrLrqzngH6OevKrnUEpG5yfceaUei9UNPOKjj9L
         1UCaHKmkMneYySagf0QUguuW0We6KXv8veroUruAzHHAwWV6Q1tz1o6BFJGltvKXwnqw
         +43d0zbFT6lE9ATlxdqZ21BCgjUHNJPQGLl9GyrSKRY6OLJ03vp3k3AsJYM+XHBzBtZB
         8tL/hrX4XsRTaBaQNZRVZaxQoC76/dwNU++FsnqccHwbVIayhsMD8mmdEdNZBMJTgyWT
         KylRQHjjAt74+ehydwFjW1OiGg5kxxQb1E0vQweI8ou+lPkZeOfOFjWklk4g5t7xusJm
         k11w==
X-Forwarded-Encrypted: i=1; AJvYcCVD9KZYV0PHJ5POXDwBFlTdzuFeDR80TR0Fley98CT7bGhrbTpiytZyyC14bgemPH18ASEbY7nScSra3pgOwg==@vger.kernel.org, AJvYcCW+DP1c64G/gi4RV4u67CuHBAC26fVI/xq44DQwES9u2WUOiKcFQkat0YTDDH9jkCC3rM7w3BfRtVam9yUD@vger.kernel.org, AJvYcCW+WFgCkX190h7VZqhhtek3TsK5G5tZOzOZnYg/ad5t6BLd1hufrTFwk0JNPKl+VL76lSbTEI3oprhqlrBX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x0xL6W7PQ93KdGxuzCieSaOfurm9osqOuTaGlBpb4kw4lv5g
	lge5pEXgD/N7XCpw6t2+n/AQC+sfNKLWLKod1DkMAJCPlZ3pyBAWd5S9hCtFC2ofLe4bCXo0eEX
	MfC4a1fVvNg1aQt9XmKTWNG0jjGes+yM=
X-Gm-Gg: ASbGncsN24Ca9/hr80e0NVw+z4KsQuj4B0OyinjcffnqOPALnlmEz7LebpEatiy76yi
	tVZpkJ+0um9Nu7TGZBD2ZKyDUfE9nKNjW8FY2PxKfwjDgpR5iPAiZEayOQdVj9Bt8V5XRDFpLuJ
	MiOVc7oWEO76ATITJEb0D6iymZaubgI0s1
X-Google-Smtp-Source: AGHT+IGmGeCn46P5NspVOPkS27vYcSGjcKxmfhGr6FFoxv5+mZNtdASAwSMv/beOFpW7j2ByyNuxapTB32Jp/PXLSW0=
X-Received: by 2002:a17:906:915:b0:ade:422d:3167 with SMTP id
 a640c23a62f3a-ade422d3425mr99608166b.49.1749292874588; Sat, 07 Jun 2025
 03:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
 <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
 <CAOQ4uxjXvcj8Vf3y81KJCbn6W5CSm9fFofV8P5ihtcZ=zYSREA@mail.gmail.com>
 <CAJfpegutprdJ8LPsKGG-yNi9neC65Phhf67nLuL+5a4xGhpkZA@mail.gmail.com> <CAJfpegu1BAVsW5duT-HoMGiSXNvj2VsLNfTuzvF1-RLyVLDdTA@mail.gmail.com>
In-Reply-To: <CAJfpegu1BAVsW5duT-HoMGiSXNvj2VsLNfTuzvF1-RLyVLDdTA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 7 Jun 2025 12:41:03 +0200
X-Gm-Features: AX0GCFuOS-cNCbhYtnI1GPftVgZkMlWkuSQkk5a56vkarkoJju9FdW0Wtthagqc
Message-ID: <CAOQ4uxgFJCikAi4o4e9vzXTH=cUQGyvoo+cpdtfmBwJzutSCzw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.16
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:33=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 6 Jun 2025 at 08:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > I'll redo the PR with your patch.
>
> Pushed to #overlayfs-next.
>
> I'll drop this from the PR, since it's just a cleanup.  It still won't
> break anything (and that's what I meant by "trivial"), but it can wait
> a cycle or at least a few rc's.
>

I'll send the cleanup patch to Christian.
It's best if it goes in via the vfs tree anyway.

Thanks,
Amir.

