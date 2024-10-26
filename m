Return-Path: <linux-fsdevel+bounces-33006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A29B15A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66752284B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562817E00E;
	Sat, 26 Oct 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+mfDthV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42B178CDE
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925942; cv=none; b=N2KArpHP4MoLdho6GZAs3s8DtjbzqdGRLxCCAATepICN9Ef1PNN3hsm3W6INFlS7IML05LJKDIJTy9DiVZF0Lk7Sxq3DlfIaI+jgTczCbQy6HIiD0+32DOoTvLuAS5IrIomx8cnCmrpnClfs5D5hmVUkbfN47LU/BMDteZit6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925942; c=relaxed/simple;
	bh=2B9lhrRJ5JlATo8YqENSD9i8//9D8UAYzuTx8nMWM/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEKF1CzDyx95CB0oBIG/PXtqg0cPboQkqxiiM8s5oxUj4PryyzscAR/twXBjO5CNLsiLJE461iDg+nFV0sAfhIg/HVpW6aRTC12IeN99a5WbG0mIuujHdBjQh2S4UquPnE1QIRo9HQ+K4a1YaqOLdxzEGvsWmQ4+/+LTdgf66cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+mfDthV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b14df8f821so195126985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729925939; x=1730530739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAgsx9q5ZE1smog5xTzBM1gw4ddi9eth+eADC9NtB5w=;
        b=A+mfDthVDuWhJDe19B7vGuvsPFqBn+Jav4vKtTrB5ooXCLHvBdWfXCPTFl3B/iTzlP
         WRxlBUgF7VJQCY1UjKFPHHnS6rtb+V1DJXKmwS7wyzScIDl0kvHMO22FjCm6ot/BFnqE
         9iS77z1m1ZZPFRToEiJAyOXSmW1bR7kjlLoMgAs8KupYd+N6N6asTdSV0ovL/DNN/FZb
         Sa5u+YdwAGT52IQ2jPABICBxV1hHAd2puke+ddx3KBTzrfkXqSJxs3p9SucnNfB4x+9h
         hTP5ayxQMkSGSc6Bzs5ZsSEQrcEqyxUXGOpSOWEDozisMABAHtJJWPtYKs7E9cj79MPC
         heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729925939; x=1730530739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAgsx9q5ZE1smog5xTzBM1gw4ddi9eth+eADC9NtB5w=;
        b=tpbhfprXEdrvWTlXPi7It2867hcuBmbZ4KqjC6a8fyyfVNUzeBHgeAHKZopto9UO77
         N8Q1bSaM169ciPw4faqcHWAE0Fjqdn6jOVrVgvHnWABypzhcB4zchlpPlgH8wmIO2L44
         8RcON+wwm+q2UbIfgwMOtqvMPFx7O4Ffl1fpcGOEW64GPXslb5aAEL8qOAa3sId6a6yt
         ucSoNS/ruepClkYjSRbAwIfNGGp7I1Ku8pEnlLg3AIcDjIrHs9t35BnPEI259mqja1XX
         4QBXrC0V/K2eawvJvMUycAsjObCqhCVR7fVhTRDQ2B6BiuT8hjZQgepTqCf3/hCFre1r
         X3VA==
X-Forwarded-Encrypted: i=1; AJvYcCWrgIb5u7tHSlrZfX+lBjdaVloTZ6TCAmfVe9FS1nduJ0zaHIzIAid8rbdC6tkkb703o6vGsUscUt9aw7vl@vger.kernel.org
X-Gm-Message-State: AOJu0YyAK7wH2hyRlIFGcYhbVHEkwX0eOJQTT10m97gFwbWnq4fw1R41
	RYWYuZNFL8uKWxUbvqkEcECEour11mmA76JL247n1i3pfbkYc77MFcGNNHkTXoPQGlAxV5CJguJ
	AttGRGAIYZqvWCuEt19BIQKgsk/U=
X-Google-Smtp-Source: AGHT+IEhFmOyf7poN2gD6kV1yUkqSu6xJyTAobr3epVAXwm1AAY2qb11EDWzEIfwEJeKWTgPj4dw2Zm99F71MUrLJYY=
X-Received: by 2002:a05:6214:398c:b0:6ce:1011:60c1 with SMTP id
 6a1803df08f44-6d185849638mr22110016d6.35.1729925938761; Fri, 25 Oct 2024
 23:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
 <20240801163134.4rj7ogd5kthsnsps@quack3> <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
 <CAOQ4uxi6YR1ryiU34UtkSpe64jVaBBi3146e=oVuBvxsSMiCCA@mail.gmail.com>
 <20241025130925.ctbaq6lx3drvcdev@quack3> <CAOQ4uxhtiEW6RstB18CAMdPA6=H5AvUxdwEix3iDw=wAfAOSBQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhtiEW6RstB18CAMdPA6=H5AvUxdwEix3iDw=wAfAOSBQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 26 Oct 2024 08:58:47 +0200
Message-ID: <CAOQ4uxjZkbQQjDbWi1jw5ErdhZATk1LqLF9NB3Un_TGDJROrNg@mail.gmail.com>
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Oct 25, 2024 at 3:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 25-10-24 09:55:21, Amir Goldstein wrote:
> > > On Sat, Aug 3, 2024 at 6:52=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > > On Thu, Aug 1, 2024 at 6:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > > On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> > > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_=
PERM,
> > > > > > but it meant for a different use case of filling file content b=
efore
> > > > > > access to a file range, so it has slightly different semantics.
> > > > > >
> > > > > > Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, s=
ame as
> > > > > > we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> > > > > >
> > > > > > FS_PRE_MODIFY is a new permission event, with similar semantics=
 as
> > > > > > FS_PRE_ACCESS, which is called before a file is modified.
> > > > > >
> > > > > > FS_ACCESS_PERM is reported also on blockdev and pipes, but the =
new
> > > > > > pre-content events are only reported for regular files and dirs=
.
> > > > > >
> > > > > > The pre-content events are meant to be used by hierarchical sto=
rage
> > > > > > managers that want to fill the content of files on first access=
.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > The patch looks good. Just out of curiosity:
> > > > >
> > > > > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/f=
snotify_backend.h
> > > > > > index 8be029bc50b1..21e72b837ec5 100644
> > > > > > --- a/include/linux/fsnotify_backend.h
> > > > > > +++ b/include/linux/fsnotify_backend.h
> > > > > > @@ -56,6 +56,9 @@
> > > > > >  #define FS_ACCESS_PERM               0x00020000      /* access=
 event in a permissions hook */
> > > > > >  #define FS_OPEN_EXEC_PERM    0x00040000      /* open/exec even=
t in a permission hook */
> > > > > >
> > > > > > +#define FS_PRE_ACCESS                0x00100000      /* Pre-co=
ntent access hook */
> > > > > > +#define FS_PRE_MODIFY                0x00200000      /* Pre-co=
ntent modify hook */
> > > > >
> > > > > Why is a hole left here in the flag space?
> > > >
> > > > Can't remember.
> > > >
> > > > Currently we have a draft design for two more events
> > > > FS_PATH_ACCESS, FS_PATH_MODIFY
> > > > https://github.com/amir73il/man-pages/commits/fan_pre_path
> > > >
> > > > So might have been a desire to keep the pre-events group on the nib=
ble.
> > >
> > > Funny story.
> > >
> > > I straced a program with latest FS_PRE_ACCESS (0x00080000) and
> > > see what I got:
> > >
> > > fanotify_mark(3, FAN_MARK_ADD|FAN_MARK_MOUNT,
> > > FAN_CLOSE_WRITE|FAN_OPEN_PERM|FAN_ACCESS_PERM|FAN_DIR_MODIFY|FAN_ONDI=
R,
> > > AT_FDCWD, "/vdd") =3D 0
> > >
> > > "FAN_DIR_MODIFY"! a blast from the past [1]
> > >
> > > It would have been nice if we reserved 0x00080000 for FAN_PATH_MODIFY=
 [2]
> > > to be a bit less confusing for users with old strace.
> > >
> > > WDYT?
> >
> > Yeah, reusing that bit for something semantically close would reduce so=
me
> > confusion. But realistically I don't think FAN_DIR_MODIFY go wide use w=
hen
> > it was never supported in a released upstream kernel.
>
> No, but its legacy lives in strace forever...
>

Speaking of legacy events, you will notice that in the fan_pre_access
branch I swapped the order of FS_PRE_ACCESS to be generated
before FS_ACCESS_PERM.

It is a semantic difference that probably does not matter much in practice,
but I justified it as "need to fill the content before content can be inspe=
cted"
because FS_ACCESS_PERM is the legacy Anti-malware event.

This order is also aligned with the priority group associated with those
events (PRE_CONTENT before CONTENT).

But from a wider POV, my feeling is that FS_ACCESS_PERM is not
really used by anyone and it is baggage that we need to try to get rid of.
It is not worth the bloat of the inlined fsnotify_file_area_perm() hook.
It is not worth the wasted cycles in the __fsnotify_parent() call that will
not be optimized when there is any high priority group listener on the sb.

I am tempted to try and combine the PRE/PERM access events into
a single event and make sure that no fanotify group can subscribe to
both of them at the same time, so a combined event can never be seen,
but it is not very easy to rationalize this API.

For example, if we would have required FAN_REPORT_RANGE init flag
for subscribing to FAN_PRE_ACCESS, then we could have denied the legacy
FAN_ACCESS_PERM in this group, but I don't think that we want to do that (?=
).

WDYT? Am I overthinking again?

Thanks,
Amir.

