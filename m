Return-Path: <linux-fsdevel+bounces-45367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D55A7697B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914B83B4AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1062165E4;
	Mon, 31 Mar 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVG0/U00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45C22257F;
	Mon, 31 Mar 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432568; cv=none; b=eI9Y72F3Hqhd8eZ791m7LHDkfr1K3M4Tsmdp5x0W2PioNqVv+4O17Fpc6h3zha9ORXpPmfUROf9ahFvYNt3Hln0TxdmgTgGB2fRc6SABfpgYS5pw+uKY9cg8SX272MNXIXCVfZWIJeGVnR0d4ScNb6KX+7kxd3UhoX1lanc5YzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432568; c=relaxed/simple;
	bh=xy6ASadLcy7iPKCYVjCqFOj5CZnNzcJHzloczxF8uoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTPJkel9U7Mkv8pNsoVCWpTkK8o+2n1Ynb7qEOM0OnEOcr464t6sazaWTc8xcdHSYgGFmdiRfYDrK4N1KoUPfYvC5naw2TZNtiTyW+VkoJitYLfdlmyZVTqvgiF1pyR4hmY6giJwBRG9nopwmu5MvZzQ4NRtU2lIG0h13VuJRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVG0/U00; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so8496433a12.3;
        Mon, 31 Mar 2025 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432565; x=1744037365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Du0r8c7U7aw4hguA8FfybRKzKw7DX4Xixhsc7YxFzU=;
        b=lVG0/U00w2RT9ze3izZWuSwpqpdNsyPZrgZUiLz2QVGaIvNMnirO3if6YtVJEaXCVs
         RKAAEzy7+wyXFN4dGOW3xGyEd4KzfPYpsKa8pHAPU2W0/ZP2xXQ7fJ9HCHJ2BWpHiKHI
         DjZx+SPDQl743c2sh94EwmetVQidKBCeDgxpDCS2dCO9VORQq1cE0AkmBD3SZX9+7xPw
         YVI97eS9EBmcTbjLiMOLd5Z4zuw8aPRz4Q6xRwSdCrdXk1ykw5c598Q97jGh5jJvigNS
         PsE4LKW5Xu4b1QolpqyWhorYRqW4r09LJGJuIQxokZFu0fmY+0bdBX4/qv27XO738Adr
         q8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432565; x=1744037365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Du0r8c7U7aw4hguA8FfybRKzKw7DX4Xixhsc7YxFzU=;
        b=n2oqEace2dcDDEYwrys9DNhZHpQ6l4fbbiAFaAjILGM55EnGQBD27bN2MyzPds+Kg4
         6eodxMXBard46is5pW7XC9IkMcvtHxKCpo0jueGeURhKsHYb/Xe5BUKmPVKblQzKrGJj
         LuKIXOVPNMThaYALHF5VyqQTgN7uMXE0j+1DPLuW22HWosjLe1NX8OHninrv+PIOjdXo
         LYLlHVtRdrbMz6dofPbIRJTN/VBnKfQBfK56T8FdaaoMAq3662Aq+P0rtvWFVNxEydKr
         gE2Tyy48RjGfquFzeTzpJ6/SAe0BDvLyfRcCfl3q7NN1kESS+B1HA86mUX/j4dXcjdsX
         LJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvp6+rec+EJOFPg3aPtPHJaokxWOIZo7o1fCFOR4lbvKGmT2hatTPXADyzcZFERfF84QUL6DqGcLRIj7c@vger.kernel.org, AJvYcCVGCXqDra4bGcjfkbQDfgokr3Uz0wfTjaK3V1GkY+eu+jvb1Dap4UbgmpDgV9Sa7lVS8XbFbTirQUSU@vger.kernel.org
X-Gm-Message-State: AOJu0Yydlwk947Z+kRiivwMPHuA5fKK30ka/lGzK1a7WRIMEsrWBJJcU
	/z5HhdTwx0Pbpy/34jjsVm3xtnC3coLZqc8mlXr4jKUpp0U+p0ncy2k9AY+28xWvxFc2lMi2zSy
	54eZ7wa0U9RkS22EOtBVXdccB+4g=
X-Gm-Gg: ASbGncuAGvUsbVmgA9AJeS5NK/A96Qm3qbbsKcJGHC1RUG0s0FnVMrrxdMfmG/OQ7eu
	tpyGNyC3+CJXUAmXR7sJhas3eCzmtbjmPnKRgrX75OF83hFfCL0MhaHjd3gk9MELPQPxaYrPT7P
	fE0bCtkmTf8p0RKQRTE5GbXTKnIQ==
X-Google-Smtp-Source: AGHT+IFnf9ETZSnEGm4xUkVE8kkNLLUe2JlGC1fXAOu9CPupgBZThN//sqDEXZ87u/MXtcQYHQeZ0adk+bKlKdwOGO4=
X-Received: by 2002:a05:6402:84d:b0:5e5:e78a:c4d7 with SMTP id
 4fb4d7f45d1cf-5edfcd4b272mr6808307a12.12.1743432564322; Mon, 31 Mar 2025
 07:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331135101.1436770-1-amir73il@gmail.com> <CAJfpegsXBvQuJO29ESrED1CnccKSrcWrQw0Dk0XnuxoGOygwjQ@mail.gmail.com>
In-Reply-To: <CAJfpegsXBvQuJO29ESrED1CnccKSrcWrQw0Dk0XnuxoGOygwjQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Mar 2025 16:49:13 +0200
X-Gm-Features: AQ5f1Jr8S1dz-i3HWEAc-frKf8TQuzkaH0amOfyugJSrfvXXfrkbJ6Hw_A9a8JI
Message-ID: <CAOQ4uxh9f7E0AWvf-vS7HOuZf6jhU_QfjnQFx7jr4E595y-9CQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document mount namespace events
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alejandro Colomar <alx@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:37=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 31 Mar 2025 at 15:51, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a dire=
ctory, the error
> >  .B ENOTDIR
> >  shall be raised.
> >  .TP
> > +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > +Mark the mount namespace of the path specified by
> > +.IR pathname .
> > +If
> > +.I pathname
> > +is not itself a mount point,
> > +the mount namespace of the mount containing
> > +.I pathname
> > +will be marked.
>
> This was the original version, but it was changed to take an nsfs path
> (/proc/$PID/ns/mnt) instead.

Oh right :)

Thanks,
Amir.

