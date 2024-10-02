Return-Path: <linux-fsdevel+bounces-30696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137B98D7EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE51284032
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2680E1D079F;
	Wed,  2 Oct 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDhDSkGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB729CE7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877256; cv=none; b=J2G3hV6oDd8jjYTmvTwv+KbQonATNlTO5BVSVaGXbqSyTxaro3N2FWPEBX6w3Nr0mQLsJvqU4UI2thu+osSymmIE7lGnCcuRAKJOJqsahpMI2cBaEhytzuSeyEczlTk3xRB5I5rUOL9JFpa4W+IauBm9b7H1bdgnBDaE07PdNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877256; c=relaxed/simple;
	bh=xP4CrSXtiMABFHWE5TrcTW5DZuAu5sagbE8Uzo9Savs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWoipDmcPUsFE8ELqzTDUtewVXszdO4HK/3FMOLRh+IuZfjEPPlKxAJE2K+Kfl7tfjnTx9waNvZDdxe1ONOD1uVjIzr8USNJ3yIEe+kCiKeAQt0h05mgbKpQdrDQ5W+sYxSMUXzbOqK+dknqAuYoNb4Up9uTyJyTJEOUKanJQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDhDSkGI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-709346604a7so3644015a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727877254; x=1728482054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP4CrSXtiMABFHWE5TrcTW5DZuAu5sagbE8Uzo9Savs=;
        b=hDhDSkGI2mYl/rWjcahAU5ujAQZT6sQb5tpa2HatjrAgqqAKudzLORPAkzpKMSeQRY
         rG4/SarsWrdzf6hPmHL85aAKIccd5gzvUSaOjWIMLWfRDA1oIxm8t0imtHIFmR9IF2ea
         1vCtKPJyhXa13uGOc5QcJe2BzQHpNIM4qbaBdsgdzOUENckILrVG0/1A4vmFrx4WwuUI
         5Ainbq+FaNaUBwnTJYPLrCVXVZGK6OcQoAmW6DzGLhaYPtfXVXdNJASN64NwEPCFwKnR
         cPio+7oPZ5JtXp0+40GnzJEIU6DeB1eULMXZDd5b6aMJn+yVjvEgN6MfAaqA79GyVS5z
         ke3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877254; x=1728482054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP4CrSXtiMABFHWE5TrcTW5DZuAu5sagbE8Uzo9Savs=;
        b=Arn+GOuizMANWmvTN0HMKfzMoC1926goJ/E4QU26Qxz/JCeZ+3hfYJ0qBtNzu0FE4P
         b+XD1dzaP4Z2wBdFisozpef/8DK5f5f6vQWcl/PnZJ96HvrIU+x2dYD9IWJZZRbNVipJ
         /h+txq3GlGH8d6JpgQblsz/7oyvLH5E2Qi1xCtF3/NJj3Rz+nggMraZxxaEg3q1Zx+LJ
         gMxlk3d2N7Val6TASY7lU2GwCMLauPXIga1gUdQVYn4rG3NMj0cfjR5zglPKJc/ghlRT
         HTm0Ea7JiouiAFfMTrTMqS94+b3/xCip4WqIbqKG+no/zb+q2lWtTsoSvV4O+dsc3QMa
         vapQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9oBPTA7xs1g8xP+vgcpAQ4h0DkAzRNoP8xQcbVyvuQgybCD3asB50Y/Oznqd8kLFeqC3zDaKvcKfvxAO@vger.kernel.org
X-Gm-Message-State: AOJu0YxTePiI+01E1YsiZL0edrrln4rla2UaWm9qpCfS5cDyLCakwdI2
	mL3XgEBjigs+7W/g/azanfdsb9Ybv4twx8HIVL1u58Zdv2J4mcS4ah3e5j+hjD2GUeakObqNUww
	J/eH66mbpVWbR93vVypiBle+Aj2s=
X-Google-Smtp-Source: AGHT+IGQzkGLJqcTeWWxl7W45a0PTEXeO1HinT+zeKJ1V0Y94zUlTn7lVNYfzOrLmyWUTzkjh8ASDrKEXAKoK7GVpwA=
X-Received: by 2002:a05:6358:7e8c:b0:1bc:d1ba:225 with SMTP id
 e5c5f4694b2df-1c0ced2b64cmr170924855d.10.1727877253988; Wed, 02 Oct 2024
 06:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927125624.2198202-1-amir73il@gmail.com> <20240930154249.4oqs5cg4n6wzftzs@quack3>
 <CAOQ4uxg-peR_1iy8SL64LD919BGP3TK5nde_4ZiAjJg5F_qOjQ@mail.gmail.com> <20241002130103.ofnborpit3tcm7iw@quack3>
In-Reply-To: <20241002130103.ofnborpit3tcm7iw@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Oct 2024 15:54:02 +0200
Message-ID: <CAOQ4uxgo=0ignH-2gSyWYmcCoAvQJA=o8ABS+u2_=iiBDvsLgQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: allow reporting errors on failure to open fd
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-09-24 18:14:33, Amir Goldstein wrote:
> > On Mon, Sep 30, 2024 at 5:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 27-09-24 14:56:24, Amir Goldstein wrote:
> > > > When working in "fd mode", fanotify_read() needs to open an fd
> > > > from a dentry to report event->fd to userspace.
> > > >
> > > > Opening an fd from dentry can fail for several reasons.
> > > > For example, when tasks are gone and we try to open their
> > > > /proc files or we try to open a WRONLY file like in sysfs
> > > > or when trying to open a file that was deleted on the
> > > > remote network server.
> > > >
> > > > Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> > > > For a group with FAN_REPORT_FD_ERROR, we will send the
> > > > event with the error instead of the open fd, otherwise
> > > > userspace may not get the error at all.
> > > >
> > > > In any case, userspace will not know which file failed to
> > > > open, so leave a warning in ksmg for further investigation.
> > > >
> > > > Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> > > > Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F342461=
9EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Jan,
> > > >
> > > > This is my proposal for a slightly better UAPI for error reporting.
> > > > I have a vague memory that we discussed this before and that you pr=
eferred
> > > > to report errno in an extra info field (?), but I have a strong rep=
ulsion
> > > > from this altenative, which seems like way over design for the case=
.
> > >
> > > Hum, I don't remember a proposal for extra info field to hold errno. =
What I
> > > rather think we talked about was that we would return only the succes=
sfully
> > > formatted events, push back the problematic one and on next read from
> > > fanotify group the first event will be the one with error so that wil=
l get
> > > returned to userspace. Now this would work but I agree that from user=
space
> > > it is kind of difficult to know what went wrong when the read failed =
(were
> > > the arguments somehow wrong, is this temporary or permanent problem, =
is it
> > > the fd or something else in the event, etc.) so reporting the error i=
n
> > > place of fd looks like a more convenient option.
> > >
> > > But I wonder: Do we really need to report the error code? We already =
have
> > > FAN_NOFD with -1 value (which corresponds to EPERM), with pidfd we ar=
e
> > > reporting FAN_EPIDFD when its open fails so here we could have FAN_EF=
D =3D=3D
> > > -2 in case opening of fd fails for whatever reason?
> > >
> >
> > Well it is hard as it is to understand that went wrong, so the error
> > codes provide some clues for the bug report.
> > ENOENT, ENXIO, EROFS kind of point to the likely reason of
> > failures, so it does not make sense for me to hide this information,
> > which is available.
>
> OK, fair enough. I was kind of hoping we could avoid the feature flag but
> probably we cannot even if we added just FAN_EFD. But I still have a bit =
of
> problem with FAN_NOFD overlapping with -EPERM. I guess it kind of makes
> sense to return -EPERM in that field for unpriviledged groups but we retu=
rn
> FAN_NOFD also for events without path attached and there it gets
> somewhat confusing... Perhaps we should refuse FAN_REPORT_FD_ERROR for
> groups in fid mode?

Makes sense.

> That would still leave overflow events so instead of
> setting fd to FAN_NOFD, we could set it to -EINVAL to preserve the proper=
ty
> that fd is either -errno or fd number?
>

EOVERFLOW? nah, witty but irrelevant.
I think EBADF would be a good substitute for FAN_NOFD,
but I can live with EINVAL as well.

> And then I have a second question about pidfd. Should FAN_REPORT_FD_ERROR
> influence it in the same way? Something like -ESRCH if the process alread=
y
> exited and otherwise pass back the errno?

Yeh that sounds useful.

Thanks,
Amir.

