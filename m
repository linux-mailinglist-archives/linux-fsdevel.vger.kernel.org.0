Return-Path: <linux-fsdevel+bounces-40183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E1A2028C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE653A1435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74303D6D;
	Tue, 28 Jan 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+IwcxiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450A610C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023613; cv=none; b=g6nn5vbeDvUXda6En48l6g9G/ogF3K65uIw5sv1ZL9HfIZo3pbumaw9B35dgwnKZGAYpHZ4P2ch7pG8NQfonSkV0nJ+NJdqD4rI6/flk3DeKySkTMyZ5gngm9tn47sjli4/ZJSxraluiTIednpReId4EJ8T1RJnj4YKqTDiJCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023613; c=relaxed/simple;
	bh=6tMrZnh1Jrxzz2HzS8TrZY5Ys6IVgK89NRrA8nITm8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZSqYxul2JTastH9z7ibNkp90S36z3B9CdV6fnnzbdnQGI4k3Ahls28NO5NxMoc4WiCzk+4y2Oq7h8LstltBF5agNFtHglss0Lc6DtVeP8dWihYPbYCvmwthXubDGtzX+hWqL0P5Oaql/q7iNrCXu/84DZxvLecnmWgTFtZixvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+IwcxiF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a37a2a53so55536981cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738023610; x=1738628410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAIbzjnb44t/0Tbv3Q17EZ5l+P0B2Nww+IfOxXwfLR4=;
        b=i+IwcxiFxDJfamar4dRyogoMFJFcq9/OITwwMB1L/NwC1mft0JcZqACxZc+A7VbnQi
         hxP+4brzpZWl2Nmn2bA1OVONWa3s9p7/U7a5sYp1OwVFESgmpH3SCiOuMxhhvYCPb+GA
         mfYoncJeyGkTAhVtVgvWUTBS3HGiB8MLbRmn+6xGzB3zysiJY5Va2PfwPF78dgUwKI2f
         Jq2r2anDEOrrdZ26NcfLy2fBq7PJYk2uZIvd4D7NfkNlsROF3NQPftBPkyPt3X+Mv3w9
         PC7QbK2nzGLXZIf2FZbiTD7uua/VPFSzBkur/1dCC0wwroj7y2tB+amTx3XySzFYH4S4
         U6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023610; x=1738628410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAIbzjnb44t/0Tbv3Q17EZ5l+P0B2Nww+IfOxXwfLR4=;
        b=gwELbfCNC47HiYJ5pc5rtUv4Y4QpW3oo9+XPg6SBmpjwGpt1GCfYbGGF/KVt5kT7js
         VI3BhGloCAdNV7wDGQB/4FsbDiBXo7YPjE7nqg28SdZZW0/GK4y/s2L9hCKWcrgP7R9E
         kYVFPU5yilaBD4LWpye4SRpsOu3gh7c6HCO3X3GUMQUGAT+xyvoTtXlsh+7L9gwB9oEL
         9rwrrACKRXanZ5DtG971E85pMBKQjXYSYG3UbwTHnJj1C/MqP+YV4juwlR6FfecSUNzU
         M3RSF11MfE+EdcV6Cjf0MgMtGmZzcpTfyVpbn8aW6CwZT+MYWC8GU0JD9v0EoSZErppi
         WA0g==
X-Forwarded-Encrypted: i=1; AJvYcCWyLir3oyNmH2wb/PiBXoJslWGyTgs6NIgkV6PO3kQvkrn9U+1/v0Kp9rM3LuXQcQa6nmy0Yc2Bu0o7h1mU@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz4XUae7289G7Q3TAUHs8MF6s5DEZJGWrOKsIqyjCYfrXG+ud
	KN9kH4yZknl3hT9jaEVNeOwTQwzrrdifWQi0+Fqw/VK+NGT9zkt8vjJlAWEFbg6Bnd0KgVhesl1
	2CW3sE1Uzwh1O0dDY/L9qpOAjD+s=
X-Gm-Gg: ASbGncvA2yjjG+eMvnIetR+sjjktuktvtVDZi+Qs175iYeD50bmCDq1iKIxpM073ulm
	jcedlDoOse4MPzCft/pwHuEy1yT2DsUOF0tqISWF6i3BIdzTeV9zPoIYNJhO/CyXy+erv0tRK0I
	ZC1A==
X-Google-Smtp-Source: AGHT+IHXcpt+AF3v+BmIHyCL67IvaHy8ln+RguZwHXU/wPTl+KQxOP8YLjvOTbJRd1Pr8Rdr3ykT9yY9CoqvmT2b3co=
X-Received: by 2002:a05:622a:40f:b0:467:6833:e30c with SMTP id
 d75a77b69052e-46e12a8affdmr709244881cf.30.1738023610410; Mon, 27 Jan 2025
 16:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-7-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-7-7771a2300343@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 16:19:59 -0800
X-Gm-Features: AWEUYZlecohGUuMNbdlV88ViOXh9zedGLIzUcCRO4ke2iMHUVRFqcNfyoJOwRV4
Message-ID: <CAJnrk1bYGOjdrWXxqqrSZuK5ERvfbMrV0Eqxv+yh0w7rgLrK+Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 9:44=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This is set and read by different threads, we better use
> _ONCE.
>
> Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9af5314f63d54cb1158e9372f4472759f5151ac3..257ee375e79a369c180886647=
81dd29d538078ac 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -36,7 +36,7 @@ static void uring_cmd_set_ring_ent(struct io_uring_cmd =
*cmd,
>         struct fuse_uring_pdu *pdu =3D
>                 io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
>
> -       pdu->ent =3D ring_ent;
> +       WRITE_ONCE(pdu->ent, ring_ent);
>  }
>
>  static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *=
cmd)
> @@ -44,7 +44,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(stru=
ct io_uring_cmd *cmd)
>         struct fuse_uring_pdu *pdu =3D
>                 io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
>
> -       return pdu->ent;
> +       return READ_ONCE(pdu->ent);
>  }

Not an expert in this so there's a good chance i'm wrong here, but why
do we need _ONCE?  from what I understand, we only read pdu->ent when
handling IO_URING_F_CANCEL or when preparing to send the queued
request. It looks like it's always guaranteed that pdu->ent is set
before any reads on pdu->ent for the case of sending a queued request,
and pdu->ent gets read when making a request cancellable (which
happens when we register the cmd and when we do a commit), but it
seems like it would always be guaranteed that making the request
cancellable must happen before any IO_URING_F_CANCELs can occur? Is
there a race condition I'm missing where we need these to be _ONCE?

Thanks,
Joanne

>
>  static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
>
> --
> 2.43.0
>

