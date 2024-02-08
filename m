Return-Path: <linux-fsdevel+bounces-10822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937B84E8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9AAB2E2D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03337155;
	Thu,  8 Feb 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuyNnJx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60836B1B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420088; cv=none; b=nidodO3StEiwpCPxYnSaphtFZCV91PdwwkDMd3yaVNrnlXDu0zUk1e3QvY9/TaCeu/iBhgzDln/nAe+HiS0EkcnssdEXbDO3VPqG0C72IZdbRgEZs38vEGxU8C18aaOUAYmekhIZqjDKfPRtjF7N65FIt5OCsmTnTIxytnnjI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420088; c=relaxed/simple;
	bh=buAslTj0PMl8/DpG0rVL1WOyBJJc4oRq4jcAq9OLjtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo+DeIanGpCHv+W/jciiz5ps4tiwZiPIUY+rpW+EAMTeF7HRFqXmSglQTC2fB4qtDt1a98zh/9Cjxf82BD5yLckzMyDViiJpW+jVyP0w51jROmenbhN1Q9NvbJ1S1nyGQ3wYSbWAPXjdwSlddxehZqvtrox/BwojmRcp/nqWgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuyNnJx4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42aadddeaf8so1335961cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 11:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707420085; x=1708024885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBtaiFxRREafbWE7AsxzsoYlAfbZUw/Nq8D6Dhfjt5s=;
        b=BuyNnJx4OmFI7Q/uV5wpNOUkZebPzVRHPXC4mFGm12fU6pQxEPBYXQ+4aVSLTAIAOX
         0WC1bNyu5jhPth4CDeJhZWNgq+6StMuGZmz5nm6d/RA/ATBr1gR7UzSqS0V628FEVVAh
         rak2ddSRTvyo4HHvvq346un2v+C49fP82HeS9M5ARvlNEAJP6yqqeOXIrFO7sXRBEJqV
         J2DBuT6cINzKjfIjgoM7eTIggNs/BDxvWJORalwepd8Wp3SqrVpLsFEG6UqTqLab5mQ6
         EkTuzaIs6pjTCoa+YMmgJjLJva/lirRtXkNylXPXBFOZg2pjoaljLlTvLouR4XtoO0nk
         oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420085; x=1708024885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBtaiFxRREafbWE7AsxzsoYlAfbZUw/Nq8D6Dhfjt5s=;
        b=MeYlDW2wt6Uf7wD6Zq8En9kod9KekKEIQz0otIP+poQW/mGukRApG2PtWOLcukjMTz
         M3E5l/2isdBD8zseDGfpIuyUqePmd8II/Na7uXm4BL6DaESWozD6v45BNqjxUoZb1l6s
         nZsFw3nJoROWTSbowAq4qoI+a6UqkpNLq+R7m0CvLXDkM3/VgQTnvffp+kdMQ7IZz23v
         R008I+oLUOXFp58/skvE7OWSVQ0RnPb5ndrmXh/bXJM7HyJcQ+TO4L4QoeBy1gNeLyfN
         Vi+On7VLf2SONPejb7aXUf+lwhFaQi+cNmZzhlzvXoeQj0BFMRYvW7T6UgZ6Q6hZPMHS
         oJHA==
X-Forwarded-Encrypted: i=1; AJvYcCXI0a+K6z/NgUXK9sQo/GQUUR2oKYulT7A1seq7odJuorrK+qBcojtO3LAZBCOaCeaLelZfETlX/8mlzkVtVdCqwQVUHHCcE2Mvn9P7vg==
X-Gm-Message-State: AOJu0Ywmb62x4w3lyjhb+E7M7Q/ewM/OcXMday7OkT+BHoEXihCyvtxj
	MZBK5Nn86f+gJwNn9K1X6lgV0QA2CRlN0uUyOgWsJC2tQqLHZNFVmzZagbgFcbq38mvksVGhgBG
	Ja1vg1ubBjxH+lyU8uCHbghh+6tPuT8vbJeA=
X-Google-Smtp-Source: AGHT+IFU2nrpoA5kLysd1yjIqYm/RPjJTyPt/bVu5JRLMBdPcnTkvNFcFRzboaZxtCwBIgOCKKaHZmscm+fQ4yyS9MI=
X-Received: by 2002:ac8:6605:0:b0:42c:582f:1b06 with SMTP id
 c5-20020ac86605000000b0042c582f1b06mr59399qtp.15.1707420085113; Thu, 08 Feb
 2024 11:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213172844.ygjbkyl6i4gj52lt@quack3> <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting> <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
 <20231218143504.abj3h6vxtwlwsozx@quack3> <CAOQ4uxjNzSf6p9G79vcg3cxFdKSEip=kXQs=MwWjNUkPzTZqPg@mail.gmail.com>
 <CAOQ4uxgxCRoqwCs7mr+7YP4mmW7JXxRB20r-fsrFe2y5d3wDqQ@mail.gmail.com>
 <20240205182718.lvtgfsxcd6htbqyy@quack3> <CAOQ4uxgMKjEMjPP5HBk0kiZTfkqGU-ezkVpeS22wxL=JmUqhuQ@mail.gmail.com>
 <CAOQ4uxhvCbhvdP4BiLmOw5UR2xjk19LdvXZox1kTk-xzrU_Sfw@mail.gmail.com> <20240208183127.5onh65vyho4ds7o7@quack3>
In-Reply-To: <20240208183127.5onh65vyho4ds7o7@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Feb 2024 21:21:13 +0200
Message-ID: <CAOQ4uxiwpe2E3LZHweKB+HhkYaAKT5y_mYkxkL=0ybT+g5oUMA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission response
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
	Sweet Tea Dorminy <thesweettea@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 08-02-24 16:04:29, Amir Goldstein wrote:
> > > > On Mon 29-01-24 20:30:34, Amir Goldstein wrote:
> > > > > On Mon, Dec 18, 2023 at 5:53=E2=80=AFPM Amir Goldstein <amir73il@=
gmail.com> wrote:
> > > > > > In the HttpDirFS HSM demo, I used FAN_OPEN_PERM on a mount mark
> > > > > > to deny open of file during the short time that it's content is=
 being
> > > > > > punched out.
> > > > > > It is quite complicated to explain, but I only used it for deny=
ing access,
> > > > > > not to fill content and not to write anything to filesystem.
> > > > > > It's worth noting that returning EBUSY in that case would be mo=
re meaningful
> > > > > > to users.
> > > > > >
> > > > > > That's one case in favor of allowing FAN_DENY_ERRNO for FAN_OPE=
N_PERM,
> > > > > > but mainly I do not have a proof that people will not need it.
> > > > > >
> > > > > > OTOH, I am a bit concerned that this will encourage developer t=
o use
> > > > > > FAN_OPEN_PERM as a trigger to filling file content and then we =
are back to
> > > > > > deadlock risk zone.
> > > > > >
> > > > > > Not sure which way to go.
> > > > > >
> > > > > > Anyway, I think we agree that there is no reason to merge FAN_D=
ENY_ERRNO
> > > > > > before FAN_PRE_* events, so we can continue this discussion lat=
er when
> > > > > > I post FAN_PRE_* patches - not for this cycle.
> > > > >
> > > > > I started to prepare the pre-content events patches for posting a=
nd got back
> > > > > to this one as well.
> > > > >
> > > > > Since we had this discussion I have learned of another use case t=
hat
> > > > > requires filling file content in FAN_OPEN_PERM hook, FAN_OPEN_EXE=
C_PERM
> > > > > to be exact.
> > > > >
> > > > > The reason is that unless an executable content is filled at exec=
ve() time,
> > > > > there is no other opportunity to fill its content without getting=
 -ETXTBSY.
> > > >
> > > > Yes, I've been scratching my head over this usecase for a few days.=
 I was
> > > > thinking whether we could somehow fill in executable (and executed)=
 files on
> > > > access but it all seemed too hacky so I agree that we probably have=
 to fill
> > > > them in on open.
> > > >
> > >
> > > Normally, I think there will not be a really huge executable(?)
> > > If there were huge executables, they would have likely been broken do=
wn
> > > into smaller loadable libraries which should allow more granular
> > > content filling,
> > > but I guess there will always be worst case exceptions.
> > >
> > > > > So to keep things more flexible, I decided to add -ETXTBSY to the
> > > > > allowed errors with FAN_DENY_ERRNO() and to decided to allow
> > > > > FAN_DENY_ERRNO() with all permission events.
> > > > >
> > > > > To keep FAN_DENY_ERRNO() a bit more focused on HSM, I have
> > > > > added a limitation that FAN_DENY_ERRNO() is allowed only for
> > > > > FAN_CLASS_PRE_CONTENT groups.
> > > >
> > > > I have no problem with adding -ETXTBSY to the set of allowed errors=
. That
> > > > makes sense. Adding FAN_DENY_ERRNO() to all permission events in
> > > > FAN_CLASS_PRE_CONTENT groups - OK,
> > >
> > > done that.
> > >
> > > I am still not very happy about FAN_OPEN_PERM being part of HSM
> > > event family when I know that O_TRUCT and O_CREAT call this hook
> > > with sb writers held.
> > >
> > > The irony, is that there is no chance that O_TRUNC will require filli=
ng
> > > content, same if the file is actually being created by O_CREAT, so th=
e
> > > cases where sb writers is actually needed and the case where content
> > > filling is needed do not overlap, but I cannot figure out how to get =
those
> > > cases out of the HSM risk zone. Ideas?
> > >
> >
> > Jan,
> >
> > I wanted to run an idea by you.
> >
> > I like your idea to start a clean slate with
> > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> > and it would be nice if we could restrict this HSM to use
> > pre-content events, which is why I was not happy about allowing
> > FAN_DENY_ERRNO() for the legacy FAN_OPEN*_PERM events,
> > especially with the known deadlocks.
> >
> > Since we already know that we need to generate
> > FAN_PRE_ACCESS(offset,length) for read-only mmap() and
> > FAN_PRE_MODIFY(offset,length) for writable mmap(),
> > we could treat uselib() and execve() the same way and generate
> > FAN_PRE_ACCESS(0,i_size) as if the file was mmaped.
>
> BTW uselib() is deprecated and there is a patch queued to not generate
> OPEN_EXEC events for it because it was causing problems (not the generati=
on
> of events itself but the FMODE_EXEC bit being set in uselib). So I don't
> think we need to instrument uselib().
>

Great. The fewer the better :)

BTW, for mmap, I was thinking of adding fsnotify_file_perm() next to
call sites of security_mmap_file(), but I see that:
1. shmat() has security_mmap_file() - is it relevant?
2. remap_file_pages() calls do_mmap() without security_mmap_file() -
    do we need to cover it?

> > My idea is to generate an event FAN_PRE_MODIFY(0,0)
> > for an open for write *after* file was truncated and
> > FAN_PRE_ACCESS(0,0) for open O_RDONLY.
>
> What I find somewhat strange about this is that if we return error from t=
he
> fsnotify_file_perm() hook, open(2) will fail with error but the file is
> already truncated. But I guess it should be rare and it's bearable.
>
> > Possibly also FAN_PRE_*(offset,0) events for llseek().
>
> That seem overdoing it a bit IMO :)

Heh! forget I said it ;)

>
> > I've already pushed a POC to fan_pre_content branch [1].
> > Only sanity tested that nothing else is broken.
> > I still need to add the mmap hooks and test the new events.
> >
> > With this, HSM will have appropriate hooks to fill executable
> > and library on first access and also fill arbitrary files on open
> > including the knowledge if the file was opened for write.
> >
> > Thoughts?
>
> Yeah, I guess this looks sensible.
>

Cool, so let's see, what is left to do for the plan of
FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID?

1. event->fd is O_PATH mount_fd for open_by_handle_at()
2. open_by_handle_at() inherits FMODE_NONOTIFY from mount_fd
3. either implement the FAN_CLOSE_FD response flag (easy?) and/or
    implement FAN_REPORT_EVENT_ID and new header format

Anything else?
Are you ok with 1 and 2?
Do you have a preference for 3?

Thanks,
Amir.

