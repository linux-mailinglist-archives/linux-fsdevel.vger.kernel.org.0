Return-Path: <linux-fsdevel+bounces-45942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E53A7FA17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E3E3BE104
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF1266562;
	Tue,  8 Apr 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TESI965T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECD263C8E;
	Tue,  8 Apr 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104890; cv=none; b=ILSPJCgPbZ2FKPfSxWF/H8IBFifS1b9ZbDcHJLAZKMLsMyT0Oi3iHQOyBDRoiszABxC7A6Wrapfsj7uTg4pW+frXJvQIyoW+taLZlW6h1VHdEt5RIl0GOAhpkKBr1BJUXO8gL+bfr19Pu2JD2EX8sEe2lpYxrPeJjUvHAWT4dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104890; c=relaxed/simple;
	bh=PtTeReiTLp+RqAL/cLFtmFLCbjN4w5rpWp84zoyWVVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBiy5kufmFb3e+WcMTht0PRjOQwvUoh6tOjuFjFY6sHBnwcz0HAiyp/oxDfmfVFggpn7ztzWIIXAyoL741bWLzz1sLO7xjwGAkWvR8PayCsFDmi8NLIyVH/p0WNpAHLVPAGLQQhQfGpX3phfGDZOsANI+WwSfNlIE6hamV0JdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TESI965T; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c0cf1922bso613841a34.0;
        Tue, 08 Apr 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744104888; x=1744709688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Bg64jM6tSWnXjFr3goi8956rwlNjPV/077kclDS9I=;
        b=TESI965Thjp7J12xnvY6T6sWo+7ztWU7FgzEgfkKwA5B/gm74mnQmV04Nn9/IZScEL
         FTY27fFz+9Uz4M/Vsc8snJjOr5+eh7UCz+Y42voJ1kpnxlMbaZrFVnWIL125rE8oEoRT
         a0plu39udGtdbQcglFmTnnF10asXbWgfr6Ix9TZs+J0RQZHea7E8U3PvXadnRoTa0BGO
         Yf20xSNV7UxD3eAdSqJLrPNOS29e/fjL9WabH753dG1XjyVAQUw5dj0M2Iw1REYKBaMQ
         Q00snLVscY8msZgDf9bxZ2572pZfPBlHllZCsGubuZ/8Vjyy6TPDwfsH73iFDU+jLZN7
         ybkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744104888; x=1744709688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7Bg64jM6tSWnXjFr3goi8956rwlNjPV/077kclDS9I=;
        b=M1bkVFo9nCDi15RYXZT6sSMlZj/OnzzhQ33+7hnZlVp+3iCLKuASjZttFSsHdl/iBW
         lm3D1YBGe2vJEpgcK3NVf0fGOWyvKfU657LcR+ctOx0tk+9NH3r0CtnLoG+5ZiJhvJCs
         u4hIErErxzqRnMbeu0L6pyRwfXwXhTh3PeQMcWuB7Mjrbfu8OzCjVkZ63U2wq5qMRwqj
         bM4Qlp/OVubiXTCws5W64Da0HAR39g4Da6AbG9wOTjml/sat1XTVIDYTMFgXMCgpmmiP
         M5+XqQJbgK2wls6m2r6JHypC668HWasYvz8w5Mh5qkuIHnvfw4k3sUMGzCwWXOuP1uea
         bIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNjMW52JnhZ3mYp7UhlZhUXYoh9YD7ZnI9dsRN2CNBXpNRImXuYCgBHWpxjojW37zeMFb+gYPWDe+GPW34@vger.kernel.org, AJvYcCWwSY90ciCn3kWFnqnVfoTT0LrHx+3wpzuinoLu6ttXJYvvPCIffLONkcvcYApn0lLN6n4S+FbO6sg8ZZEO@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZTy8pOSwYD/vwln0LwGs13QKno98j6m3ePhqIcIi8aEGA4e+
	YCDTf9hthsgHlzVYUq281PmCCk5TiarfyYWfW5THec5Zlo7mVYQPZFpY9XjvbtZAKLFDYiOr1/j
	q3qFvw7DZOdIf1icsU2Z0fbejY5Q=
X-Gm-Gg: ASbGncswbf/rJ/Kj25V40VO5ImMJ7yi3/y1Dz0zgjHLdz1hftkuQyeNGdvB7EuehRFb
	kHFrYd4Z1Tof6oQQ4XsdntI+z6IveuBdxzlXW2sASl28c+Cq6U3PNwwrDsKngCvZ7A0UZ/+lnbB
	qXLVKuhInczWwVgZQQWkNuLHUgiqM9
X-Google-Smtp-Source: AGHT+IF0RL92qSZNzUfU40xIFIvrvGm2xvag6WpHMC5o7D5ttqQSxe1/GUnQ2Gjqq953tDRmDPDtxGBEWbXMsdqtCLE=
X-Received: by 2002:a05:6830:6c10:b0:72b:a3f3:deb6 with SMTP id
 46e09a7af769-72e3665915emr9937036a34.4.1744104887890; Tue, 08 Apr 2025
 02:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner> <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
 <20250408-regal-kommt-724350b8a186@brauner> <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>
 <20250408-vorher-karnickel-330646f410bd@brauner>
In-Reply-To: <20250408-vorher-karnickel-330646f410bd@brauner>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 8 Apr 2025 14:34:37 +0500
X-Gm-Features: ATxdqUE9g2rEeeo1yAbwscarMFto7S559Ky8HZPkBzoWbN-Fw3wbmzlUemspT4o
Message-ID: <CABXGCsO56m1e6EO82JNxT6-DGt6isp-9Wf1fk4Pk10ju=-zmVA@mail.gmail.com>
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
To: Christian Brauner <brauner@kernel.org>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 2:18=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> I'm confused why that's an issue:
>
> > git reset --hard 474f7825d5335798742b92f067e1d22365013107
> HEAD is now at 474f7825d533 fs: add copy_mount_setattr() helper
>
> > git revert --no-edit 474f7825d5335798742b92f067e1d22365013107
> [work.bisect e5673958d85c] Revert "fs: add copy_mount_setattr() helper"
>  Date: Tue Apr 8 11:14:31 2025 +0200
>  1 file changed, 33 insertions(+), 40 deletions(-)

> git reset --hard v6.15-rc1
HEAD is now at 0af2f6be1b42 Linux 6.15-rc1
> git revert -n 474f7825d5335798742b92f067e1d22365013107
Auto-merging fs/namespace.c
CONFLICT (content): Merge conflict in fs/namespace.c
error: could not revert 474f7825d533... fs: add copy_mount_setattr() helper
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: Disable this message with "git config set advice.mergeConflict false"

--=20
Best Regards,
Mike Gavrilov.

