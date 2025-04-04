Return-Path: <linux-fsdevel+bounces-45751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DEA7BB37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960BA3BA3C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728211CAA96;
	Fri,  4 Apr 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJLwUf6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68033997;
	Fri,  4 Apr 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763983; cv=none; b=Kw4AgrzeIpD1ZpPWPI79njTtMQ6B7qhEyDOwSEUWBFFEG73CGb3Cxc2hN5SE2l8s/Jr/6+3Nxt21bpirOgLXIUWu0hRzkOFKNFF50Rs943y327US5loNdamS8XgLZqT87ZsIt279vl+hOAnFqBk+pMIdfZMjNvxZWOyF5OSc6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763983; c=relaxed/simple;
	bh=SB8iXEHklqw3Ir2r/jz0VNhUWj35TBEE6tiMCyrRF80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMAd0K66Fw0RfyVvORc8tYw+eMfcQFfY6ve0iWPoRfUZy0dDlXHPaFasWqIYGusFEYTI6zThql/j/qZQnvNsISd020b7ATQvJJSNt/+7IVvDJSIYljcLDMawklUJr/PCLBm3vwb7hqMwYKlbSucBEAEt6vfH3vGIqtss1FNLJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJLwUf6k; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf3d64849dso290042866b.3;
        Fri, 04 Apr 2025 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743763980; x=1744368780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB8iXEHklqw3Ir2r/jz0VNhUWj35TBEE6tiMCyrRF80=;
        b=OJLwUf6kI6wrJ1DrpDmqPHmBcncJJUksMyULqs37b6yUKqHaiGciQ7Fy1+VWrjKF1X
         uNg8wJ8ogjxZAZ7JrkTcrQUgbut4syv6bNZ/ebd67ZUxpJf7IObQylce3mvfzh5eD6Zd
         qQFtGnQ/aYlLiOJ90hb1oF/COFFfs6sw4RFa010sA+T/bqrocXGratj+Cmk+sJdREogW
         WsdJTlWGDHrV+fKh7KhvUdvYRdry90qZQk6v8FL3wOP0CpgYPw6DZEIXm0JtmPOwRGbw
         MwNmcYZhWsLEKZDQ9xfU3V2dYiFYB9ZBilmm4diXqj8Euvc1J66LC1UjSffzgaJPecRq
         vVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743763980; x=1744368780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB8iXEHklqw3Ir2r/jz0VNhUWj35TBEE6tiMCyrRF80=;
        b=eBZpyik09ARLG9sm8AjXDyU/ErZ8LdG/CPGQazUZGjQyXI8V8rAVq5w9VY4b4ZH437
         YWBOiV0rS6ZkSx52GBbol4+AIsRWFLxSiOMRPd7lN+VSivPShtT7h+mV6YTlZHIwKJvr
         kHxRASY78aNpGtyCbH7vl6pobksfJdhbtPxnSmGJi4QvwLYSaG8pyYQBwqjf+/59wDmM
         ILyhU+/d4G1emGxL5GteyGRh4V/7sJU50Ej6BflWjNf9gaW0zct2XIcJMxz7erv+vN3T
         DN8TTnAquuwy4CAEOGCq5sC4H8M0q9sr0WnQh0Ikj5ksqL3UatYJasVEw3/S7qCB5Z3e
         7IvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsZnDbL+JFmP/0Li6JJyhk2+MnM5Pd5Hl+HPLvwLGBkBbAa4atsJZxDU507mv6HLYy2LmJALhPhkia@vger.kernel.org, AJvYcCWFrvlJg8PXTgear3mwBIvvKlQZKkn315Us3c11De4XNFV0yVhwGbwdFFLPRvIurH9ottS77qZQLSrlj/8x@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLFBYvmudXuLokinxFnNVCuFg64xHILizmS0H5X66qHiBD0PS
	VqYL9JVX4+yW6DrpVE+giC4+edaXinQJmYcxI67KL4A3UWyrZu3sCsKrZNEe3EC3IF8PTW7kDVY
	+Ki1T+uWtuw4bXMPZNGq8FJvLYzw=
X-Gm-Gg: ASbGnct4AZxmdVhtzU7LO/ekTNVd64oY6DBTpXFGKf5Gy4vq5VemxnS5S74xEIUuKin
	9XlY+lfiFFtDGQF+d5ZQW0mLrfG2pIWUZ5z/7AdX1GXSOxb/c3zcIkXzb87Wt/GnbCkri3pEk0x
	CmArYQJJCCGcrmtYBvHnMsmD8QGI91url1d5Wg
X-Google-Smtp-Source: AGHT+IEsbsIotXgJRtSW8MerLng1NyKdNjzX8eyJ9oIkv5i1NpYIMUazwlW5wBLxBgnKdkS5DqY1etrKFXyQ/H5VLZA=
X-Received: by 2002:a17:907:1ca7:b0:ac4:85b:f973 with SMTP id
 a640c23a62f3a-ac7d1819306mr212769266b.34.1743763980164; Fri, 04 Apr 2025
 03:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404075624.1700284-1-amir73il@gmail.com> <wrrbbdfca6j7bxbtyghf56cjjgwir6slf25s2amha7uxp3zgxc@6jicin3vldaw>
In-Reply-To: <wrrbbdfca6j7bxbtyghf56cjjgwir6slf25s2amha7uxp3zgxc@6jicin3vldaw>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Apr 2025 12:52:49 +0200
X-Gm-Features: ATxdqUFKrJQFa2_yObjXSbO7Z46vpXW99L0SVHdn6Q54-hljYUAfAzAkRhJ9rdk
Message-ID: <CAOQ4uxivA1BRLfTbPLN9Qm6bi-aaBm8WT_55rWcuuyihCtrd-g@mail.gmail.com>
Subject: Re: [PATCH v3] fanotify: Document mount namespace events
To: Alejandro Colomar <alx@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 12:21=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Fri, Apr 04, 2025 at 09:56:24AM +0200, Amir Goldstein wrote:
> > Used to subscribe for notifications for when mounts
> > are attached/detached from a mount namespace.
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> The patches don't apply, and there are so many that I lost track of in
> which order I should apply them.

It depends only on the patch that moves the FAN_FS_ERROR entry
and that's the only patch left to merge besides this one.

Note that my original FAN_FS_ERROR patch said:
"FAN_EVENT_INFO_TYPE_ERROR was missing from the list of info types"

But you've already added this missing value in an unrelated patch
that you merged. Nevermind.

> Could you please rebase everything you
> have on top of current master, and resend everything in the order in
> which I should apply?

Done.

> Sorry for the inconveniences!
>

No worries.

Thanks,
Amir.

