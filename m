Return-Path: <linux-fsdevel+bounces-54215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC7AFC1BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 06:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416FE4205FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2976217F33;
	Tue,  8 Jul 2025 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZQ8X/nWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D41D7E54
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949929; cv=none; b=Nr97eoBiwi4SW3zUBcy2dUD9uYzPCr9IukSVIeUK6RQ0idP72VMjcEtHj6Z6Lw/vUR41HfIqfQMeAwtgskXv81+QyNsTIqQ1AeImXEZ78iKuIrVZHth6dsUEf/RvGU755EyEy+keJaUan2EnXqtf2lHTfIX6/MtTUkFi7BXB/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949929; c=relaxed/simple;
	bh=cyuVu0Zvm5Ok3FJ6+scXo4j6aYvJ2vTUs+cizbFEfPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRpOuRCPW5VVzcEbB7peks74e3RgeKP7FzQN4bNQZHNKI19EKMwuLnIQKpvAkQl2mIwIrHZxYR69C24XagSS0+rik1Fd9J6fvuIthG/xsjse2LPVU0KHdAhT5J3KhHH+vEnYrKF260Dj5jeBfbZMSdouSMnNpUO54+DjQQMLZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZQ8X/nWr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so5769917a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 21:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751949926; x=1752554726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqNJXRqxCyyydpdXfWSTJ2EExhN9/S2LJXo+S80XU9o=;
        b=ZQ8X/nWr1S4lafNfxeTSRwt7yIARs1tPBdp39WObmxjVNE04IdA9TfoGvbF6FU8Sk2
         jUSDQyx/FsQM8XX3B0WGaMd7mmX4aD1GZGoB5/h+uOGFVk5As8sjnoI0y4ZRTZbKkIR4
         ZAtvVXgoJqgxfIFAXREv68bL0Gh0ihoDHbKqpcFXzIY4RJLD25MuZPi84iA7WPKJamyw
         FmNRvAE0UqNPlE/m3bs8RrNlCXYRZb9lHklJsKsquhmuhnegic3nHpb8npmWuGprGBsW
         x3Iu7HvgmhEfzvN9P40ARzm0qncuEpAhtbhPQXSItec2LfOh+WU1XAvWemkSe13tQs2Q
         zbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949926; x=1752554726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqNJXRqxCyyydpdXfWSTJ2EExhN9/S2LJXo+S80XU9o=;
        b=xQZUU2TirqxBxUeZ2Da8KxrOuxXp4BXWXmSFhApDRqnnye1Xs1O8FqGlRrlu4ddPx6
         A2appZNGx2eSKhCVOMm87uIag9SdcrH7H+2bl3DFMVJWYOnwyO+klvlomq6xnbgepWBp
         +SaiZ05x2+lvgBXI4V/Leut9qFSqF2AELZADZGTDjBDViWlSlKeSUqkr+fgpaFhw4cbJ
         OFOdewO8OsTU5QgLqnc1C6fXdbsdYdp+rx6fHjPa2bCV2t/lw6U5WzGnjuy+tCrdlloo
         Yl2fzF/o4G0j6fAR+Hfh5tNvsbtg/kdVBgy3LY5tJI1HebC9UkCcskz176EtOksMCAh5
         yyMw==
X-Gm-Message-State: AOJu0YxeBpoZYtEWZeU0uSHeECDvrzQz1GnwtW2cEXR8o3NASRhBAHkk
	CQLe8tU0Wg1mNU8gcfvBmIqVerS92SbYOLFKR8Jsw1wABWFAor6/hJP8j7QPJ+rT08eC6ZGyQ+S
	xZYazH2PyEGK9LeVE11r3zyd95871BzelKSO+CiLTLg==
X-Gm-Gg: ASbGncuSLo3O8IZ/4JQs9JsWKlp/Pnis6PpIRl9XDcIpEpESxe8bOW7UzcwBm5gvWoM
	VFglVPFkYlfgYr6tetAyPvdkq3T419qnhYPiBvhojut2BLTv9L+aQn2MJBwlVNsJcvZ0ej7P3ee
	9HD2pCeidwbubJASLnIt3a/MEKACpbmjEEWGpJWJkYkcZCeQpor1XnApBfGhq98A4MBIUFohI=
X-Google-Smtp-Source: AGHT+IETYFQda78DtHooqQ3BAuCv43WpCt427AA99z9bQ5whlMvxg6MGcxRk/OIADdstlJE+HsC+VdHydGitg9T/H+o=
X-Received: by 2002:a17:907:9689:b0:ae0:d4f2:dffa with SMTP id
 a640c23a62f3a-ae6b055ed0fmr158366766b.3.1751949925746; Mon, 07 Jul 2025
 21:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV> <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV> <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV> <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV> <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
 <20250707221917.GO1880847@ZenIV> <20250707223753.GQ1880847@ZenIV>
In-Reply-To: <20250707223753.GQ1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 8 Jul 2025 06:45:14 +0200
X-Gm-Features: Ac12FXxgiii8qUvUobplOId_mZyl2t5XqOzi0KxyTJenDipJp-urULM8ZwIQBAA
Message-ID: <CAKPOu+9=AV-NxJYXjwiUL4iXPH=oUSF25+6t25M8ujfj2OvHVQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> You are asked to evict everything evictable in there.  It would be rather=
 odd
> if you ended up with some dentries sticking around (_still_ with refcount=
s
> equal to the number of their surviving children) just because in the midd=
le
> of your work a memory pressure had been applied and started evicting one =
of
> the leaves in that tree (none of them busy, all leaves have refcount 0, s=
o
> all of them are evictable).

They are not evictable, or else you'd be evicting them, but you do not.
Instead, you busy-wait for the dying dentry to disappear. (Which can
take a loooong time)

Your explanations do make sense, I understand them, and I think I'm
getting a slight understanding of the dcache code. But you haven't
even tried to argue why you implemented busy-waiting in this patch.
I believe the busy-wait was accidental.
I've been trying to make you aware that this is effectively a
busy-wait, one that can take a long time burning CPU cycles, but I
have a feeling I can't reach you.

Al, please confirm that it was your intention to busy-wait until dying
dentries disappear!

