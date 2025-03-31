Return-Path: <linux-fsdevel+bounces-45368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB26A76A91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C816F2B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9E218E96;
	Mon, 31 Mar 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqV92YgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D762144B7;
	Mon, 31 Mar 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433136; cv=none; b=iuU8/MNBvhEBY8KUxpG7Pvm5yPlBMq8bJkDRVKAet2re7QjoZjgCAyj3Mta55OFiYFE9YT0cTN2rre7rN9aKAo7c3jbLnZg5HAlxdWtHlGyQUuimLn+E0351OzK8AsApoUWwL7ZlfObYaGm74qzxOk0wgagyjOhtYPYVcq0DKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433136; c=relaxed/simple;
	bh=el2X5wXllOd8pabLEXON7pKxksOCnyhI7k1tAyVFbno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC+uhaPLi4ubAMmqHMrnYGn6gZ7MYdtf6/ymYXBE4vDaoWQEyiuYg56h2eNDo+JqFze6XqiWxpC6mhIuMJfdDeyjiOvpGkiS4RHCQYiSgMg6KdiQ6FaEFMA78wkZbk1OWAgeCvZeEICNg5DwjUj1PLYkPr+AIZ74dAL+5NicSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqV92YgJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so4053408a12.2;
        Mon, 31 Mar 2025 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433132; x=1744037932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhFgfAj2RMpqpppmwK+eL/xEA40IhXM5Ujl4Qrl+JY4=;
        b=PqV92YgJI4bFhpGVAB5XGScZGRhryJboYjc9VU8T8qNEtFxz5SvT5xwCQIHGQFr3b3
         qKWBNaSrJlIVUi97nAXAP+HDF9gJVcMyt9IlV0vrKRFjwSgzss7c6GNrk7IjhWjwqBb1
         rnbEb5QC7SDWszhK/HVOv8Fh7J6pwpiuLA3gQ/5+Jn+KutUXgJUWsIMcbhR3Z9x1IB9O
         0TddfhpzIzMqZdf8UQlIN+233k6bQi2PR3XDv5MjEOMCqo0FPHuwv1fJg7fSA2MgHCOE
         XBxMnkTL6rDbu4aDIDH0SioBugfGoh/Kyi4DNgrn9pr9N0WcmXkmvtyK8p1KrH73xfRu
         TymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433132; x=1744037932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhFgfAj2RMpqpppmwK+eL/xEA40IhXM5Ujl4Qrl+JY4=;
        b=NLw87tTGAcww2pSAbFzCRCXs4EtzRUle/M7tHyJnzOK/q+1QE5Wv0zXgZ/lqp6MnOm
         NOAXfU8vn5DBZkWoQ7yL3ZBA090ALSR6PayBAMJ8yGWn/a3VTHGqmjMihmUVEdNxTZP7
         OW7DG90Apkw0svYOREAVIP/49EI9/LzKB2GnynmIfULwDw1INpDIGPrbSaI1oPyucgQS
         bwyUaLN52lmJgfC/r7KaPn3FgzML2T2090TJ5ZKTu4KkVGObQOmahnBHNr94ZLCIbc50
         Zy4cQ1IhBeZu2T3I4MUzAvLmW3/0LbYlFj+TotqS0PILz7H26avZLaay+oavG4aWkp/2
         j18w==
X-Forwarded-Encrypted: i=1; AJvYcCWNAVyLhPC1p6YeS4lw193qSNA8zIWLC3sc51qSoGZDqnVIUydyh2fFbqmoFk+EFX0zYqBh4U4WUuCX08m5@vger.kernel.org, AJvYcCXMRdiA2XZbB+R4wFEihFun+Vda7+7TPsMN8h5J3hUN7nvfOdg2W9hvQsYJCAATvu8zoQ5ptBe80knj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GwJk8TskEu22NdwEthGKCgkwGKSVeph8TXWUhq33AGYfZfGx
	MGtqmDz/RKyobaYLpXgvTMYYQlIj08DmCSqf/RvCOnv1k4pDRgOMoSI527pWQp7B/PECqfWLtf+
	NzG0XCWHT4Xo3rxQ9f5knoEG7xTekFznCpsg=
X-Gm-Gg: ASbGncvOFVY6WlWiHqbZzIUZwnYo8FDM393sxtAN8XMaVNe684qG3teXyq6cpTkYW5x
	TP/bq82F3atg4GIS/BW/e8NSUPxydx57aJj1oN/a5DqOy2dwgK5E0+tJ+3l0ue5TVvzeZLQEVjQ
	58ji9kfivtKV8uzLC6gdtbDX5u2Q==
X-Google-Smtp-Source: AGHT+IHcWWTr4lpkIFp3BNS2vWEgN2KpumiVNpOLEelM8W5+9Pu1b97vEQs3G5DVAACYv/fFGgnwL/KHaMOMXi8/duE=
X-Received: by 2002:a05:6402:84f:b0:5ee:497:89fc with SMTP id
 4fb4d7f45d1cf-5ee04978ca2mr6583442a12.33.1743433131442; Mon, 31 Mar 2025
 07:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331135101.1436770-1-amir73il@gmail.com> <CAJfpegsXBvQuJO29ESrED1CnccKSrcWrQw0Dk0XnuxoGOygwjQ@mail.gmail.com>
 <CAOQ4uxh9f7E0AWvf-vS7HOuZf6jhU_QfjnQFx7jr4E595y-9CQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh9f7E0AWvf-vS7HOuZf6jhU_QfjnQFx7jr4E595y-9CQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Mar 2025 16:58:40 +0200
X-Gm-Features: AQ5f1JouBnhIBOsAIwFpLd7JfGP3-th3EX2paD7JeWcOu1m5rp9hIxX7cx-IJg4
Message-ID: <CAOQ4uxiF27q+-3On0RYz_5bP_rPuKbBhDABeu480hWPQG2i1jg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Document mount namespace events
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alejandro Colomar <alx@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:49=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Mar 31, 2025 at 4:37=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Mon, 31 Mar 2025 at 15:51, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > > @@ -99,6 +100,20 @@ If the filesystem object to be marked is not a di=
rectory, the error
> > >  .B ENOTDIR
> > >  shall be raised.
> > >  .TP
> > > +.BR FAN_MARK_MNTNS " (since Linux 6.14)"
> > > +.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
> > > +Mark the mount namespace of the path specified by
> > > +.IR pathname .
> > > +If
> > > +.I pathname
> > > +is not itself a mount point,
> > > +the mount namespace of the mount containing
> > > +.I pathname
> > > +will be marked.
> >
> > This was the original version, but it was changed to take an nsfs path
> > (/proc/$PID/ns/mnt) instead.
>

Revised as:

.BR FAN_MARK_MNTNS " (since Linux 6.14)"
.\" commit 0f46d81f2bce970b1c562aa3c944a271bbec2729
Mark the mount namespace specified by
.IR pathname .
If the
.I pathname
is not a path that represents a mount namespace (e.g.
.BR /proc/ pid /ns/mnt ),
the call fails with the error
.BR EINVAL .
An fanotify group that is initialized with flag
.B FAN_REPORT_MNT
is required.
.TP

Thanks,
Amir.

