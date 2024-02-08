Return-Path: <linux-fsdevel+bounces-10773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12084E2C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED251C242C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AEC77F39;
	Thu,  8 Feb 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRSQydph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3C78B54
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401084; cv=none; b=b5HJsD2W35T5jHHkMju7Bapy+rQywG11QrzB7R6uMtV6DpqjmSnI2o5iHU/NlXD8i4TnpCe94UZeP1bggGwjQmFhETtRwcTWfrjUDyDSmuq+VtmfQhbT5D7lEA1etCnP1Ri/R3FFDCpS9j+wtH6PlG4v/G++2cN8me2262j65wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401084; c=relaxed/simple;
	bh=QD6clXIkocgZt1bPeduufhFjFPNwa6uhr7U3+URxgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpB2V0atuVjReV0yQCNmaeEsZy/slwCVnU7DevLh906lZilALYQgTXXaxGwCq+qQVnEif5GcvkaP7jsOx4K+uxpJY6CbKDy+e4T5qO3pCOklsT0l70YTW0YyKLHLvuGE/WlKkB3IIfXSq20r4PZpA/UinV44KTjhiYt8sKwyBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRSQydph; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78405c9a152so109970785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707401082; x=1708005882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD6clXIkocgZt1bPeduufhFjFPNwa6uhr7U3+URxgZg=;
        b=CRSQydphAo7iNSA3ZYyOnPgn7fOHwsJmQhA0SQbdoGcjykDZOJoFxjCcm/r4bSxt4l
         peH3GdqTHElvwbGQ9n16GmzYF8lRRR9H4P7wN2ZwW8No9qaetNrALJydLZKqzVpboLIt
         yUkrQtjC0fIClfNpPbclQokEpEH84rstnxU4mW9b+ptSAwX/n7LPmwhQpW1dBIh5aIxi
         aWJQjJCUVqqYclDiOnB8XTWY+KPP7dgkFU+IvBYp2+Y4S0l/X8SXUw+1KvIKlYKCCDVf
         HXvL0Y+vac8RVRReoBaqS17Jm+JAAUWO2r1JnRsUgL4RnuuOEFisPYmguAntIWPVg4JR
         1tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401082; x=1708005882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD6clXIkocgZt1bPeduufhFjFPNwa6uhr7U3+URxgZg=;
        b=rVHhDlPuHWHwXnDbNaVnSdXlJuWy1A/jNiHuhAVRGGhZW2i2QWt095WgHl0mdL8YUq
         x4QR3/zH7OxYJsioyb4IE9j+Lk1Q/JacaUlgGgvjgYmf+xwCdYQt2kLqwVUGrc51Vrhp
         LcffVvPPyfYVw+I/VeZsN8UzfLvZutf2L7rY3Lw2BnP84UjIE3zIH4EE4pDEA8yIFw0d
         IGn9WAtr4t2OFDN6G3ue6jVOxX2hifqF/XPb0VT1STxLvZLRFXqJalBdcyPCX8PJAG69
         Ho/eGImJKUbMyDsA/RKo6lmsE7tSgjnJi7zSO98FxOqN7w59/rQP6TTkbXmvDEcHX6FP
         SW7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbnUbqqb0/LUF+TaLkJ8fl04Ip0Ox6sm4vE1LI5R8s7gTBqkUZnyv3aU3/twkg4AGzil53SJs2/4F3BTL92xYNdULeYvya2ucvvBDrIQ==
X-Gm-Message-State: AOJu0YxRHmq6fg0Ql62SRvgS+ItPOfzX/vhCuAN1zSUFRhAuZmowb8Za
	woFxlo1EctesO0FvOoEpGKlmWrti3B6P4zFqrw3Q3Kx+97HMm01ZZjigqQm72uLwS3O1iYmrvjk
	SyTf/9C3OlETwKQO+XFF1zwxzjZM=
X-Google-Smtp-Source: AGHT+IFRMENgfG6PK+QYGvOu+zxRUIvR2dPpQob74VhMWo6G/OQQMZW3JMLXRbKfB+FTM2H1ZkzLChpWzQjS0T5E2cY=
X-Received: by 2002:ad4:4ee8:0:b0:68c:b635:f5b9 with SMTP id
 dv8-20020ad44ee8000000b0068cb635f5b9mr9296114qvb.12.1707401081588; Thu, 08
 Feb 2024 06:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208080135.4089880-1-amir73il@gmail.com> <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3> <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Feb 2024 16:04:29 +0200
Message-ID: <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > > On Mon, Dec 18, 2023 at 5:53=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > > > to deny open of file during the short time that it's content is bei=
ng
> > > > punched out.
> > > > It is quite complicated to explain, but I only used it for denying =
access,
> > > > not to fill content and not to write anything to filesystem.
> > > > It's worth noting that returning EBUSY in that case would be more m=
eaningful
> > > > to users.
> > > >
> > > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPEN_PE=
RM,
> > > > but mainly I do not have a proof that people will not need it.
> > > >
> > > > OTOH, I am a bit concerned that this will encourage developer to us=
e
> > > > FAN_OPEN_PERM as a trigger to filling file content and then we are =
back to
> > > > deadlock risk zone.
> > > >
> > > > Not sure which way to go.
> > > >
> > > > Anyway, I think we agree that there is no reason to merge FAN_DENY_=
ERRNO
> > > > before FAN_PRE_* events, so we can continue this discussion later w=
hen
> > > > I post FAN_PRE_* patches - not for this cycle.
> > >
> > > I started to prepare the pre-content events patches for posting and g=
ot back
> > > to this one as well.
> > >
> > > Since we had this discussion I have learned of another use case that
> > > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXEC_PE=
RM
> > > to be exact.
> > >
> > > The reason is that unless an executable content is filled at execve()=
 time,
> > > there is no other opportunity to fill its content without getting -ET=
XTBSY.
> >
> > Yes, I've been scratching my head over this usecase for a few days. I w=
as
> > thinking whether we could somehow fill in executable (and executed) fil=
es on
> > access but it all seemed too hacky so I agree that we probably have to =
fill
> > them in on open.
> >
>
> Normally, I think there will not be a really huge executable(?)
> If there were huge executables, they would have likely been broken down
> into smaller loadable libraries which should allow more granular
> content filling,
> but I guess there will always be worst case exceptions.
>
> > > So to keep things more flexible, I decided to add -ETXTBSY to the
> > > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > > FAN_DENY_ERRNO() with all permission events.
> > >
> > > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > > FAN_CLASS_PRE_CONTENT groups.
> >
> > I have no problem with adding -ETXTBSY to the set of allowed errors. Th=
at
> > makes sense. Adding FAN_DENY_ERRNO() to all permission events in
> > FAN_CLASS_PRE_CONTENT groups - OK,
>
> done that.
>
> I am still not very happy about FAN_OPEN_PERM being part of HSM
> event family when I know that O_TRUCT and O_CREAT call this hook
> with sb writers held.
>
> The irony, is that there is no chance that O_TRUNC will require filling
> content, same if the file is actually being created by O_CREAT, so the
> cases where sb writers is actually needed and the case where content
> filling is needed do not overlap, but I cannot figure out how to get thos=
e
> cases out of the HSM risk zone. Ideas?
>

Jan,

I wanted to run an idea by you.

I like your idea to start a clean slate with
FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
and it would be nice if we could restrict this HSM to use
pre-content events, which is why I was not happy about allowing
FAN_DENY_ERRNO() for the legacy FAN_OPEN*_PERM events,
especially with the known deadlocks.

Since we already know that we need to generate
FAN_PRE_ACCESS(offset,length) for read-only mmap() and
FAN_PRE_MODIFY(offset,length) for writable mmap(),
we could treat uselib() and execve() the same way and generate
FAN_PRE_ACCESS(0,i_size) as if the file was mmaped.

My idea is to generate an event FAN_PRE_MODIFY(0,0)
for an open for write *after* file was truncated and
FAN_PRE_ACCESS(0,0) for open O_RDONLY.
Possibly also FAN_PRE_*(offset,0) events for llseek().

I've already pushed a POC to fan_pre_content branch [1].
Only sanity tested that nothing else is broken.
I still need to add the mmap hooks and test the new events.

With this, HSM will have appropriate hooks to fill executable
and library on first access and also fill arbitrary files on open
including the knowledge if the file was opened for write.

Thoughts?

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_pre_content

