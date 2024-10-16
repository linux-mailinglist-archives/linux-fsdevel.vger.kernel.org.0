Return-Path: <linux-fsdevel+bounces-32130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326089A10E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDEFB21A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6244207211;
	Wed, 16 Oct 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOut0aqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F8290F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100789; cv=none; b=pmcUgfilX3NaDuAuPxhMQFjVoKt8k8pkWXm3VtJd1x+kj32SHum0gssk/dVRJghW8huH8DiUnFlQSQrWmmLq4JxXL8WVg4XetDw7VTCDlefMQErjcU2yjW2im6FEetUq8iWe5zOiwOzpzlei6n8HUjcgcuEjnyKGKyu5YK0qOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100789; c=relaxed/simple;
	bh=ob755kLZw2ZpokzXhJd/ZcjmpuYfFF1fbeDzWtGBcUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSBXZbuJSbOYAEXzjQILDhH086+ufad13x0GO2hVaoTc+yg48JHdg8eskD6+rg5ET1Lw5FCIx/SpFd8siXyZOLfTJqcmsnLZ1ggox4/zXCHADr2T2tiOANiLH9J3iPMHD0DfEdTHJVyq845dpkoL59tZEfFme9mL+PY005eogT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOut0aqI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b13b3fa372so7337385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729100786; x=1729705586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0Noyr0n0Izi3nrlCNYhxf7X5LDup0Zn2kIBeGwp8/M=;
        b=XOut0aqIcRq85WgTGrBKH/MKR65Y110ZIhVJw79WBDr1AmKAioCzhxc34eL98aYtpL
         epfM5RbRrjwvhjsKFWqJ0OrIi49dMeH9LalCY/AkhmDI6gpP5NAqjsN8mBbCMKlhDi9Y
         VWBKRGFS/sdfBXGhOmAmbw8Ev466fW3YIy/Fo3So2w/BtVl/bUx7NiUoVLN2m8MeFpgj
         QnJ3mTNRK2arboX+h+7qzIuaywW4cqvDxmcdf0iwc1Fw5OL76OiplNxr99xBJOW0IVtk
         1vKGb784zR5+4fJvhOwgeEU/6/YAFUc2/IZMVYpkVOPToFlCjuA6GaLDfdY5Q0duavzU
         v68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729100786; x=1729705586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0Noyr0n0Izi3nrlCNYhxf7X5LDup0Zn2kIBeGwp8/M=;
        b=Y8CNvCC3SH/nMDNx94DFyF8nSrpMcNfPndbGqqHEi4uI2QIgtGdLFh6+m/YW9p6Aan
         jyddDOhqaX8jGnlGAwp2i43YgaduJdNzOHV1069C4eVt6DBWnok+o8Fd92HRaGoSqsru
         AsEBeCYW73IYM/IYpxqz59dNbN8fAWPX0gP1udwoAoOEaCcPRE0eo3eoXVAx9Hs6mjt6
         N/EAmtYwmdDc7XA9tktZeJMNhCwreKYz/MFtwoYZMUDVCxDE3ilvghk3YPwCUuoq/RiD
         iWfkxxmsWyBkEFof1EHFIR99ZoRROnEiPtZdV/16ehy64TPwickR1uxsVF5FLgowN9Y0
         CSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCcBkVG6XRe8phTFaNPSy3mvvwzce4X2Ti5hG9q+jskhbdCgh5suk82FsV78zB1f0WJ33HO31RE/OrHtva@vger.kernel.org
X-Gm-Message-State: AOJu0YykwnmvNsQ3fuTUq/RgcZu8XwZCjOjzPvWC7L/0pYZncRL2p/8U
	8JpqHuMRXWc3h57T/lyL6BD/Ec4/MFnII+d3e1DGXVqU3nebBYAXE/cGdNQXHI19oJi+hUdWPE9
	CsZ8As+VT9LUcD4sUbii+Gk8i/ED1U7Xk
X-Google-Smtp-Source: AGHT+IG7vurbW/oswt88ajmiA4bgA5SnRc0QdnXpU+20GLf0/C+LFwBEHQwsNZR/FWoYeYTUDmFBpcanV43aRGwQNqc=
X-Received: by 2002:a05:620a:4154:b0:7a9:bf33:c17a with SMTP id
 af79cd13be357-7b1417f84b4mr735313385a.33.1729100785489; Wed, 16 Oct 2024
 10:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003142922.111539-1-amir73il@gmail.com> <20241016154853.ndrdn6ldivww33px@quack3>
In-Reply-To: <20241016154853.ndrdn6ldivww33px@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Oct 2024 19:46:13 +0200
Message-ID: <CAOQ4uxjO3u9dKOO3XO8JZp_8Swgx7driLc1SeHaWBxSXnoWaRw@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: allow reporting errors on failure to open fd
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello Amir!
>
> On Thu 03-10-24 16:29:22, Amir Goldstein wrote:
> > When working in "fd mode", fanotify_read() needs to open an fd
> > from a dentry to report event->fd to userspace.
> >
> > Opening an fd from dentry can fail for several reasons.
> > For example, when tasks are gone and we try to open their
> > /proc files or we try to open a WRONLY file like in sysfs
> > or when trying to open a file that was deleted on the
> > remote network server.
> >
> > Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> > For a group with FAN_REPORT_FD_ERROR, we will send the
> > event with the error instead of the open fd, otherwise
> > userspace may not get the error at all.
> >
> > The FAN_REPORT_FD_ERROR flag is not allowed for groups in "fid mode"
> > which do not use open fd's as the object identifier.
> >
> > For ean overflow event, we report -EBADF to avoid confusing FAN_NOFD
> > with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
> > or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.
> >
> > In any case, userspace will not know which file failed to
> > open, so add a debug print for further investigation.
> >
> > Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> > Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDD=
D1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I was mulling over this becase I wasn't quite happy with the result but I
> could not clearly formulate my problems with the patch. So I've just sat
> down and played with the code. Attached is what I've ended up with - plea=
se
> have a look if it looks OK to you as well, it passes the LTP test you've
> created. Functionally, I've just removed the check that FAN_REPORT_FD_ERR=
OR
> cannot be used in "fid mode" because when we decided to use the flag for
> pidfd, it makes sense to combine it with "fid mode". I've also moved
> EOPENSTALE special handling to a more logical place now.
>

Yeh this looks nicer.
Thanks for the touch up.
Amir.

