Return-Path: <linux-fsdevel+bounces-63488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F63BBE026
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BCB1894882
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8127E060;
	Mon,  6 Oct 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEVnoyUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47927C869
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753242; cv=none; b=AryjV+YUi1C4huAyWmSThksKIh/9k2NInbPEwZ5ks/Voq1wlnn5NmcnbEJdxs6tfD+GRlG1omSpXc5kSdfwn7CHnYjJYNbTYYuMUdQGIv1TgNDlZVKPVD3v5NZSt1NfCxXscvd2W1z6Y6Yzb8D152F2GnQVzKNXVvwKbAwojFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753242; c=relaxed/simple;
	bh=UJp7RolsMUHZN7Q7qTulrrtFzCt5CPP5p/bQu247Voc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWK0fOp/bfwr+MwOoSB7GQPUmELan0oYzXPedsYJMku/EFCrMMShBY9pNezl4vNSnBpKFRk4gpDKGBZ2VM1CqP66OHCI0HLxhcc1S+sxpEYeT7CrHUp/6yabL11pzd09Wm2/HhILyG8qi8tWkjUIEGih7OsGcUYOWMEUMhWcOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEVnoyUL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so8129141a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759753239; x=1760358039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrL0phxbtwcYAWxQ3FOdLeN1W9DvB0MwUwXu+o2snlE=;
        b=hEVnoyULNLmmVXusF98M4I7X2I5m/5GIVkpMiRL7P9fUBCFBAxuLEQcSj78QVpuWCB
         twogFgZopoBJguQ4c+t2mR0A0Aghj77ZVWu+49diY3VV5p8JWdDcRlupTStq+Ofo8a2x
         9sde0gAHsXB4p7DF+LR/MXs11gEMLYMCYlrq1Z4Pa+mtm30BkG8iH8rf1aIUQUWq4W8w
         8n3soZOkvMZto4PnHm0qrEUVucE4CM29ACCDQk4tZgAYJEvNyCUQzgAC2eWT74AQEwMj
         Wtfp5ExA1fJzHuJPMIPfCHZR06jY+jDqjQycXSk7avlD84U+p+t/hxFX5K+pBrnSKRQr
         OL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753239; x=1760358039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrL0phxbtwcYAWxQ3FOdLeN1W9DvB0MwUwXu+o2snlE=;
        b=hQSaqu4rmeoEhjLsx50OrubrusSrVP5O96e6oRkJslbgShahTB8Dc7kmoaW8VvUkSo
         j9kws64mpTf+huc9vAwUpkFIZZPnLnunnuOrl0zCl9xMacoq8j21jd6UG3efDrWR8Av+
         xwc17Si6SDSZ74Nmu7qjyUIRNXPeapaQwwgASfFE/jUJBUsc/vsSvxlFE1gPLpo/Oax7
         POMY8sHWIkYYaAnTloSWBC0gjvV3WjpdBila+Z2L1tk6rpoo/FFKJ5v2rpuUDy4QN0XA
         J5bOWBNK/PyJbIsyBlFbFHRUbv+a7T8Us6/S3WsH5Wx+4eOAKEcQx1cdcbqefJWWxYWZ
         67ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsg0QInOxb3+wpWBDusC6xP711QhO8xGAOMFIICI81u8lm+fn6ETbUFM0ISQarAGBav8OojtSZD1/qo1nu@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNsoOFcdb9qVeBF+O+cUuyNvu+jzSgvvgHWtZEjcXAjSSP0ae
	kEJSCrfKART5HDG6BkmUDX1hbWY95y+HerKqongM7J3oEXZwPGZyy/h6zCRXr1n7Q3yTKdzGNuT
	2Vci6/8CeE2MJyrbYd6OStt1SrgJFkRZWdQ==
X-Gm-Gg: ASbGnctK6/jkiIGGRcYpnh6bV7yKZOa+gqNnJpJL2YlzhrCv2QK6HZ6D2NnJrSj43s2
	dDdPlze6Q8uIyk+hRp0o/CjkcOCrnxGi/LXlZ8t6bWjziP6tl6HFwz2/bXjqKFZqXZNmiTcIK+4
	hdMgI8fzWSihz0bLkiQtO6wtNGYmbepZoRJPDlPRs8uX53dT6RHNndedIN8pj/6+9vfXYCwoJz3
	JjSYw8HEZlVaxXEcVp9syW+3lYqFE8kYec6JuOfI+YLFYdpw/maZTH8SpXYjE61mqTGMML7uA==
X-Google-Smtp-Source: AGHT+IETWefcq8gw2n4ALL0l81SdRUuET/WJavOZT/5HdxcH+PJFJtXUks1IJxr2y8maVZe6XORVjN+hQxlMjpgZGOs=
X-Received: by 2002:a17:907:7f0d:b0:b3e:9818:30e0 with SMTP id
 a640c23a62f3a-b49c2a59c15mr1591033066b.29.1759753238606; Mon, 06 Oct 2025
 05:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005231526.708061-1-mjguzik@gmail.com> <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
In-Reply-To: <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 14:20:25 +0200
X-Gm-Features: AS18NWCUHzufbDlED1IRCwWRQuPWlZsQxQKvzKtob8VW4zZ3AcPnNwifuCHrG5w
Message-ID: <CAGudoHFU7F07kavPxpEo7dxF1aWofu2i1xK_FENFhCRawK0s4g@mail.gmail.com>
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 06-10-25 01:15:26, Mateusz Guzik wrote:
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 22dd4adc5667..e1e1231a6830 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *ino=
de)
> >  {
> >       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> >                      !(READ_ONCE(inode->i_state) & I_NEW));
> > +     /*
> > +      * Pairs with routines clearing I_NEW.
> > +      */
> > +     smp_rmb();
>
> ... smp_load_acquire() instead if READ_ONCE? That would seem like a more
> "modern" way to fix this?
>

Now that the merge window flurry has died down I'll be posting an
updated i_state accessor patchset.

Then I would need to add inode_state_read_once_acquire() and
inode_state_clear_release() to keep up with this.

I figured I'll spare it for the time being, worst case can be added later.

That aside I have a wip patch to not require fences here and instead
take advantage of the i_lock held earlier, so I expect this to go away
anyway.

