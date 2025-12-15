Return-Path: <linux-fsdevel+bounces-71366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A812CCBF5CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A5930210E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C7339B52;
	Mon, 15 Dec 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmLoifyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2A338904
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822196; cv=none; b=jLg646QRuT7yv22JXKr7K6dUpDEQSoTnxeBPpQKSihxmOguJo6iGTFhHa831z9cR0yFGLsuXkc/9odZO25bmcUhETRrDpzVxTZxLHpOy802C/j7A+bgoUPrjhvDYGiW1QIYmBJhdsRLAW5poOsuQb1GSuLw+CN9JGrzkXS5ZYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822196; c=relaxed/simple;
	bh=Gd8DcJXPdYpYzHvc8vztMt3k9avy5V2xDnRpZLOlOdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqRPJBvYo9qmW2g3MVk3MvHPEiT+o5h8n7Cv6h4sky0ij7yF1l5qfIziR5AbwjVvgj4jvZPUrYFLl3+qt1q25rrDvORuelbfn0vxvL0Km5Hlm2NRUmvFsx9oM/j61kzBzvM/akdIiVSrMGXSGj89UeGymqYntDsIZHEeVfUcscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmLoifyw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so7397630a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765822193; x=1766426993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQCL+HwWypxdtQ2FQkCr64ZPgIWt3g5fyAei1RWbYrA=;
        b=hmLoifyw1fvSeps5jeU0wBNUBzp/YsVg+wbUt3UFlyQOcxrwfTatRGmJ3ssHbM2Skc
         PzA5ECH34DNxtn33IwSHsK3qTNftQmgxzCqJYgPKh31Y1ld6J7zHxYWVWmZ9WmUcPpXu
         QiOe7wd1YfyBEqndOcfeUcA9wn/UGvr3GEhySKmKmGD/lMIKlwUIpPdISnriTCOOaOWT
         Jt2ZHG66UNL3H4vnLbvpOfDjUYKfcAWraS/gf3qXDmNNikOE7VTNX1/foyzoq/vC62kT
         a4oUDPsrICwR+auFs1yq+lg+1sb3cz0KKaLkvOZ4Yyq6VGhKiVdFxOeoDlFf9VYuv0vm
         uf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765822193; x=1766426993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQCL+HwWypxdtQ2FQkCr64ZPgIWt3g5fyAei1RWbYrA=;
        b=JNxGoBFOuKxU9jlEqux1jn2FdDyOjsgM2G9lke6T90TrNcdv2AeQOJd6Uc1f7v8uwq
         wPvoAyhZNaSTOOnlmkgy+hx44AX5s4/4XgWfF+9lFEqaB/pXtiqRjbqj1KRL7ThBAFjT
         3yquxq3tB00DgHSx9ofI4OcNWjbGafMOdtQhCGdfos75AF58Cw83as08ulXiyHX9pNF2
         UyBqRq+ARPKmLFF/Mn1jfZG8tFeLrAKvSlyccf1qk+PyijnPPjyBUds9ikNRw1yJz86A
         WS+89pRh4Sg3jL8x/0eJZNZDM6KpiuYFqnS9QxcyVDT6s15FTPru4Bw/iBteB0qsr5ZI
         IvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYUeCA2ofitZmp9RJCx3PABhVKTRpJdrvuGd9zROprDxweEv0wdd+MKXlvWawtHNxAahJoH4iJwp5RSA2E@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyipM14Vyw4BGJexPZTWq+y6YpF/R4WEZeXngtUjjaG50UHxe
	Uv61i35CFA9FHOzUynn5RGPNsjbS//dRYqBzXmI5fJOQQeQa2tb+ogCsKtcuFqtiemEfdKpglNy
	EJlDJHIrVA1a8sL2EpFC5SiIqJVBi5g8=
X-Gm-Gg: AY/fxX5S8ZvFt5aT/weqkjeM4jNK8BiwCpvYPEtEISQiGz7Q7ROFDAMf4ojRtmhmBP+
	zYvOKnpBU4E/0ySxZ/HPzbVy1B3IXWcPX8+ljcjkBrgt4kWgIofbJfgpjsyoNZYcPTLC9uRKBeS
	58mKCeaN2TIpBdbzEN7ThDPWYIUgZ1vDIirAPmjTJZc5LVQ+l7SggGZvDVSmah1Rtnrro7VCIue
	wJ8qQtoa/Bb0WHqeNulO7INpvhTU488dAT1jZFpmOGl5uhKvo0jiQu8LerzlTR6tfvo00gf0xsf
	IvwoiVNvqXJ8knbU06icMNNvUxhwEA==
X-Google-Smtp-Source: AGHT+IHcdsw0TmXCkgRXvoiHN56SVQuerdwwmxQLhKtsgwBAN+D7k0zVL6uUOdqPjF8LlyQU+mVT2sZysteLT5FPaVg=
X-Received: by 2002:a05:6402:5194:b0:649:2336:deed with SMTP id
 4fb4d7f45d1cf-6499b1cc740mr11313567a12.16.1765822192832; Mon, 15 Dec 2025
 10:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-4-luis@igalia.com>
 <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com> <CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
 <8bae31f2-37fc-4a87-98c8-4aa966c812af@ddn.com>
In-Reply-To: <8bae31f2-37fc-4a87-98c8-4aa966c812af@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Dec 2025 19:09:41 +0100
X-Gm-Features: AQt7F2pKvuVuAyuwmGAbS8nriYdpokIMqWKel66P15TG6hYFEU6W0p9LBRn7NRY
Message-ID: <CAOQ4uxh-+S_KMSjH6CYRGa--aLfQOeqCTt=22DGSRQUJTJ2bPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
To: Bernd Schubert <bschubert@ddn.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 6:11=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 12/15/25 18:06, Amir Goldstein wrote:
> > On Mon, Dec 15, 2025 at 2:36=E2=80=AFPM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> Hi Luis,
> >>
> >> I'm really sorry for late review.
> >>
> >> On 12/12/25 19:12, Luis Henriques wrote:
> >>> This patch adds the initial infrastructure to implement the LOOKUP_HA=
NDLE
> >>> operation.  It simply defines the new operation and the extra fuse_in=
it_out
> >>> field to set the maximum handle size.
> >>>
> >>> Signed-off-by: Luis Henriques <luis@igalia.com>
> >>> ---
> >>>    fs/fuse/fuse_i.h          | 4 ++++
> >>>    fs/fuse/inode.c           | 9 ++++++++-
> >>>    include/uapi/linux/fuse.h | 8 +++++++-
> >>>    3 files changed, 19 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>> index 1792ee6f5da6..fad05fae7e54 100644
> >>> --- a/fs/fuse/fuse_i.h
> >>> +++ b/fs/fuse/fuse_i.h
> >>> @@ -909,6 +909,10 @@ struct fuse_conn {
> >>>        /* Is synchronous FUSE_INIT allowed? */
> >>>        unsigned int sync_init:1;
> >>>
> >>> +     /** Is LOOKUP_HANDLE implemented by fs? */
> >>> +     unsigned int lookup_handle:1;
> >>> +     unsigned int max_handle_sz;
> >>> +

The bitwise section better be clearly separated from the non bitwise sectio=
n,
but as I wrote, the bitwise one is not needed anyway.

> >>>        /* Use io_uring for communication */
> >>>        unsigned int io_uring;
> >>>
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index ef63300c634f..bc84e7ed1e3d 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -1465,6 +1465,13 @@ static void process_init_reply(struct fuse_mou=
nt *fm, struct fuse_args *args,
> >>>
> >>>                        if (flags & FUSE_REQUEST_TIMEOUT)
> >>>                                timeout =3D arg->request_timeout;
> >>> +
> >>> +                     if ((flags & FUSE_HAS_LOOKUP_HANDLE) &&
> >>> +                         (arg->max_handle_sz > 0) &&
> >>> +                         (arg->max_handle_sz <=3D FUSE_MAX_HANDLE_SZ=
)) {
> >>> +                             fc->lookup_handle =3D 1;
> >>> +                             fc->max_handle_sz =3D arg->max_handle_s=
z;
> >>
> >> I don't have a strong opinion on it, maybe
> >>
> >> if (flags & FUSE_HAS_LOOKUP_HANDLE) {
> >>          if (!arg->max_handle_sz || arg->max_handle_sz > FUSE_MAX_HAND=
LE_SZ) {
> >>                  pr_info_ratelimited("Invalid fuse handle size %d\n, a=
rg->max_handle_sz)
> >>          } else {
> >>                  fc->lookup_handle =3D 1;
> >>                  fc->max_handle_sz =3D arg->max_handle_sz;
> >
> > Why do we need both?
> > This seems redundant.
> > fc->max_handle_sz !=3D 0 is equivalent to fc->lookup_handle
> > isnt it?
>
> I'm personally always worried that some fuse server implementations just
> don't zero the entire buffer. I.e. areas they don't know about.
> If all servers are guaranteed to do that the flag would not be needed.
>

I did not mean that we should not use the flag FUSE_HAS_LOOKUP_HANDLE
we should definitely use it, but why do we need both
bool fc->lookup_handle and unsigned fc->max_handle_sz in fuse_conn?
The first one seems redundant.

Thanks,
Amir.

