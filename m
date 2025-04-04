Return-Path: <linux-fsdevel+bounces-45750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE4A7BB24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0A13B7AA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137A1B4254;
	Fri,  4 Apr 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljK7Z3ME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46202B672
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763467; cv=none; b=kdHW+sRpNcpv77I5XS9wcbwLNuTEGMjSwDW58FPck/Co/KrnP6pp6aqPLvUB2UsskYpjFUUi5vqCC/0TwWyGAsDsxOzXZ2Lw+HJrzPxJLPqAb3yDB7bmpVFEfMbyCJuIWzxBKXaC7SZJ4xhNEFl3Wk2RPOkFuoCmjJ6vOjdCPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763467; c=relaxed/simple;
	bh=5ycnbXyC4hAWEohn6B0vdF6BodfCKpqPGneKwCnec8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q83GxrPJUXIzJOb+mDnIChDUo5ccbhTJHOs07c5MfhcVzBIwCHB2akL4a26HSTPpUZ7ONtGGvfDMAFLAQNSZ33pX+ml3sFGrAqDzhsT2/HgECKQudN1FrXtp12vs/48wJlW67mDCANAworh5m3PDcpDlBHOG5vxS6ASRx6s94wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljK7Z3ME; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso2416490a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743763463; x=1744368263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il3wHs+cVuLTp7IjVBcrk4KyAa8PBUKn0zbBssHigS4=;
        b=ljK7Z3MEm/oVScMcT82QghnNxyMhBWNEiNHCr+AWAdJKfuxfD3Vp0VBzApcvjTKWCI
         Wx9Q+JvA49DWB+fawlw5V6wQlkCl+F4gTR6U94w7LGpUSDCdUvwMPCK2wB4ftzo5MvnX
         2z4cmEUmeUYvc2VwSf8WVusJrKy918JlrxxCWCVrVW/jE4fLkQLtwuikZCnp/lTJzC3r
         21xU0FZeMTVn6nwvXHojHhRFyiZn9zKUEw0Fs/no4avurcU7Oa1UMiDu0jsYCOXJnDa5
         tCPhVXrn974hEND7jmQXo03rtcVrBL06GFTNaruEavzjzIfx3nNYKuBO9qC8YjhGKg7F
         vXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743763463; x=1744368263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il3wHs+cVuLTp7IjVBcrk4KyAa8PBUKn0zbBssHigS4=;
        b=t+YlonlTpHDOoWb7GdCZW55kfh+qypELEK1lxX8d6dba9dCqGdbIrDlcA7dv5pML+D
         N51UX6+JDLlqu2rwSBEEx78MqhRrFuf2xw+olpLIh0ghBurjJ/ZAjo9UBzzC1iePYbUL
         qDJDDPf/4OeIyBlyFe9mcut4SVqx5AQUIOdG4FUSCtlMq180/aSsOfypR19UOgbf8fym
         npOMzzHsLmSWykJOBOH3YnLMO1sAixOuen3tnbnXT12ZIjPdkaIyr7f0+IUqQ8C2WzWx
         rRB+d1Hh2q3BDPL0eex1k5E6VtYQkLgCUTNLkYNrDs7A1VBDTooQU91oTmhZfr9QSfVR
         JvgA==
X-Forwarded-Encrypted: i=1; AJvYcCUiGNPN7hPoHfVtnbhwrGajUeM7LiDZ4q4xBSWohRauJdllIxk7gzzVrzr/zy0DgfuhsDBjdIB5W3xqNsKW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyykk+YxRQcj2V3DosactBPMcjGH0OdAuSFVA0mOTJlvZVbFvgM
	IHFU2R5E4/JaD1UmJdQUzojvzpTTAQ+EV7fU3gw45qLseokwRSZDzAdo7YljD+9ru+6mwmZ31rE
	16LJOGx7AHMefsc6cbyodlF3dm9A=
X-Gm-Gg: ASbGnctPB9EV90Elns38BnlZ60Hg+y7c5F+ofBPaSlx6TigEYXTq8vERz3jKcbw0VBr
	fECgJM5giG0euP9Jzt0nLQy2Dmef3lwJJH/fbKWeyqak5UWxXLRMDpNuVvT73CXehquMHcH0+OL
	C846xQAqYKi/Jmo/zw9AXwgt4Chg==
X-Google-Smtp-Source: AGHT+IGwY+kUxbjLwMUhGW6FcToYaGX5MAPURs//LAo+LDM7pZtyhuA51GiYzI77/O7DPyY9dcYSpnoqbXXg/OBu1gs=
X-Received: by 2002:a05:6402:524c:b0:5f0:7290:394b with SMTP id
 4fb4d7f45d1cf-5f0b3e34895mr1927637a12.27.1743763463035; Fri, 04 Apr 2025
 03:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402062707.1637811-1-amir73il@gmail.com> <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
 <CAOQ4uxh7JhGMjoMpFWvHyEZ0j2kJUgLf9PjyvLeNbSAzVbDyQA@mail.gmail.com> <ba4cmwymyiived2xrxxlo5mi2hnnljkiy5mvlbzws2w2vpwwdm@pkekpc5d2apu>
In-Reply-To: <ba4cmwymyiived2xrxxlo5mi2hnnljkiy5mvlbzws2w2vpwwdm@pkekpc5d2apu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Apr 2025 12:44:11 +0200
X-Gm-Features: ATxdqUHTyPevR9L9OjwxKolYT3IBEsZvbPBJicJUVVD2fSgZ4jIUVUCtjaLCf_s
Message-ID: <CAOQ4uxgcv+1zaRKFgWQJYkEUt0pKs9Uuw8Pw0CvEoYHm2OQ7nw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on directories
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 11:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-04-25 19:24:57, Amir Goldstein wrote:
> > On Thu, Apr 3, 2025 at 7:10=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 02-04-25 08:27:07, Amir Goldstein wrote:
> > > > Like files, a FAN_PRE_ACCESS event will be generated before every
> > > > read access to directory, that is on readdir(3).
> > > >
> > > > Unlike files, there will be no range info record following a
> > > > FAN_PRE_ACCESS event, because the range of access on a directory
> > > > is not well defined.
> > > >
> > > > FAN_PRE_ACCESS events on readdir are only generated when user opts-=
in
> > > > with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events =
on
> > > > readdir report the FAN_ONDIR flag, so user can differentiate them f=
rom
> > > > event on read.
> > > >
> > > > An HSM service is expected to use those events to populate director=
ies
> > > > from slower tier on first readdir access. Having to range info mean=
s
> > > > that the entire directory will need to be populated on the first
> > > > readdir() call.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Jan,
> > > >
> > > > IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS eve=
nt
> > > > in initial API version was due to uncertainty around reporting rang=
e info.
> > > >
> > > > Circling back to this, I do not see any better options other than n=
ot
> > > > reporting range info and reporting the FAN_ONDIR flag.
> > > >
> > > > HSM only option is to populate the entire directory on first access=
.
> > > > Doing a partial range populate for directories does not seem practi=
cal
> > > > with exising POSIX semantics.
> > >
> > > I agree that range info for directory events doesn't make sense (or b=
etter
> > > there's no way to have a generic implementation since everything is p=
retty
> > > fs specific). If I remember our past discussion, filling in directory
> > > content on open has unnecessarily high overhead because the user may =
then
> > > just do e.g. lookup in the opened directory and not full readdir. Tha=
t's
> > > why you want to generate it on readdir. Correct?
> > >
> >
> > Right.
> >
> > > > If you accept this claim, please consider fast tracking this change=
 into
> > > > 6.14.y.
> > >
> > > Hum, why the rush? It is just additional feature to allow more effici=
ent
> > > filling in of directory entries...
> > >
> >
> > Well, no rush really.
> >
> > My incentive is not having to confuse users with documentation that
> > version X supports FAN_PRE_ACCESS but only version Y supports
> > it with FAN_ONDIR.
> >
> > It's not a big deal, but if we have no reason to delay this, I'd just
> > treat it as a fix to the new api (removing unneeded limitations).
>
> The patch is easy enough so I guess we may push it for rc2. When testing
> it, I've noticed a lot of LTP test cases fail (e.g. fanotify02) because t=
hey
> get unexpected event. So likely the patch actually breaks something in
> reporting of other events. I don't have time to analyze it right now so I=
'm
> just reporting it in case you have time to have a look...
>

Damn I should have tested that.
Patch seemed so irrelevant for non pre-content events that it eluded me.

It took me a good amount of staring time until I realized that both
FANOTIFY_OUTGOING_EVENTS and FANOTIFY_EVENT_FLAGS
include the FAN_ONDIR flag.

This diff fixes the failing tests:

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 531c038eed7c..f90598044ec9 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -373,6 +373,8 @@ static u32 fanotify_group_event_mask(struct
fsnotify_group *group,
                user_mask |=3D FANOTIFY_EVENT_FLAGS;
        } else if (test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
                user_mask |=3D FAN_ONDIR;
+       } else {
+               user_mask &=3D ~FANOTIFY_EVENT_FLAGS;
        }

        return test_mask & user_mask;
--

I don't know if this needs to be further clarified to avoid confusion
when reading this code in the future?

> > I would point out that FAN_ACCESS_PERM already works
> > for directories and in effect provides (almost) the exact same
> > functionality as FAN_PRE_ACCESS without range info.
> >
> > But in order to get the FAN_ACCESS_PERM events on directories
> > listener would also be forced to get FAN_ACCESS_PERM on
> > special files and regular files
> > and assuming that this user is an HSM, it cannot request
> > FAN_ACCESS_PERM|FAN_ONDIR in the same mask as
> > FAN_PRE_ACCESS (which it needs for files) so it will need to
> > open another group for populating directories.
> >
> > So that's why I would maybe consider this a last minute fix to the new =
API.
>
> Yeah, this would be really a desperate way to get the functionality :)

Indeed :)

Thanks,
Amir.

