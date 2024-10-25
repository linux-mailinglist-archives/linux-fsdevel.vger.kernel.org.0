Return-Path: <linux-fsdevel+bounces-32888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D09B044A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAED1F23137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97918E76C;
	Fri, 25 Oct 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNA79RqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E129212178
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863565; cv=none; b=Qe9pYMiFkRG8iU6P/9LwUwxWmrVWu4YQv2ze+2uhAwUFEwMbEU+gptRsQYF/PvV96yRJk0rhjcapBBa5YRqzs0VQDhnvbSLvtGXSvxl195c/iby0cN+99JFNDxrHeWulNSt3Rw/WS+0wKnPIxcfNXGoVbiQqG7mEoAqt2EDZU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863565; c=relaxed/simple;
	bh=Zl85lTDG/vleetON+msLX6JYWTwLc4UufLnFgrtAKbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7y2MnEaTHKzJcfAB8KVc48cdXmz6Us5NaLVD1tvDbqWIg62LTOJaUg6w/wj08pmhDzYGD0iXYrhK663E5JSPdrGJ708GeI4tgu1kjmaKsGwVpp6VUN8duxFJ8NChiqUO6GFDuaunV2IANRZIBsG5tvC6TJ7GHh8lxRELB+9sAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNA79RqQ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e290554afb4so2376721276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729863562; x=1730468362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7D9S7QAV7TsoU4JdVj1aBhfYGrMdhSOO9cdOwGWgrI=;
        b=WNA79RqQzsVeyfw/+MVcvH5e78mhJhB84pxS0Krah7GlXpMOyvBH1ajwdI6Gwa/Zlt
         Pi621VaPN8UITcvhnOz4Jxs8iweyX4uZAHNNo+zv52+yIJrvzzRKQa5KHJaNOCiBUY7L
         NDSnpgXoYlTMiDIY71U4qeEJ92LUFd1pHqeuKdQ6lBJzte3AuMR70QYRoY7DuPn+Nb3f
         zZngNtychCgOHqCrqznHCfcUqjIV1BqvfJMqy5iZA2Tflr9T7nTwcBE09J+a98M4T1Ig
         U3bW1SC/Y2vYXsMloGYDVRbxUiQE+iJNQRdi8WE6cTKvJlPF2bojqHWWrsxXYEkQ87uW
         uvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729863562; x=1730468362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7D9S7QAV7TsoU4JdVj1aBhfYGrMdhSOO9cdOwGWgrI=;
        b=gxiBUXgRFHxTMIHWWSONu1uwc7q9vDu9INghzn1k7rtLUE0XrWN4OvTcuybML73G4h
         /AXTE68EP/S4re70yzwqsXy82j5via0iK6AdB7phhZze4UJa9+9O/UtBvN/hgxzoy/Sz
         +GlbleYDtZsioLJxB7OL3pb3BvFaD+o+5HYZ8QHwHqP+GQmaKkiu/VS8QfACERlm5VjT
         fADgNV5Nnv8gLLTsAqdsNNMDIpU80rmvB99pY5SkwI0DQDc9WzUgSzPvD4AttFIaUUo3
         uNQeek3rnQmLbo4atNkzQo+YVVzMEy5nR0m/jxfwDFZ3l0Gvs3y+MogED8tA4SgF+xZV
         xqXA==
X-Forwarded-Encrypted: i=1; AJvYcCUkCtKxwOU4oaRpBDUkDcCm8cGsY7K4hG3U7HnFkFVk/DI8heI8+Ak0+QBqS+iLNAnEM9+NTCqz/w8DjhHs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8sDVRLwVqDsPHmvIZLbq4EzMUHQzOgQODXah5BCxRG8MrUgu+
	Rw+BXPHBmO8jRibTh29UQA8ZCENIEIrz0B+jlOk3lLqhMk4+f06hN1AMqGRfOUeGOtik6oToySV
	Xa2vLMWy7DI4H4KQmFTKDK/fDT8g=
X-Google-Smtp-Source: AGHT+IE3Lj2mnhmvuEGWE16kf2IBXOakrzs3TD3/gYTyZV5A2ZtOhEk3V6btUccL6fRq/AS4FyxwMtAFbEJTtcgX9eU=
X-Received: by 2002:a05:6902:230c:b0:e29:2815:74f6 with SMTP id
 3f1490d57ef6-e2e3a653c4bmr9557118276.16.1729863562460; Fri, 25 Oct 2024
 06:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
 <20240801163134.4rj7ogd5kthsnsps@quack3> <CAOQ4uxg83erL-Esw4qf6+p+gBTDspBRWcFyMM_0HC1oVCAzf4Q@mail.gmail.com>
 <CAOQ4uxi6YR1ryiU34UtkSpe64jVaBBi3146e=oVuBvxsSMiCCA@mail.gmail.com> <20241025130925.ctbaq6lx3drvcdev@quack3>
In-Reply-To: <20241025130925.ctbaq6lx3drvcdev@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Oct 2024 15:39:10 +0200
Message-ID: <CAOQ4uxhtiEW6RstB18CAMdPA6=H5AvUxdwEix3iDw=wAfAOSBQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 25-10-24 09:55:21, Amir Goldstein wrote:
> > On Sat, Aug 3, 2024 at 6:52=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > > On Thu, Aug 1, 2024 at 6:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PE=
RM,
> > > > > but it meant for a different use case of filling file content bef=
ore
> > > > > access to a file range, so it has slightly different semantics.
> > > > >
> > > > > Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, sam=
e as
> > > > > we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> > > > >
> > > > > FS_PRE_MODIFY is a new permission event, with similar semantics a=
s
> > > > > FS_PRE_ACCESS, which is called before a file is modified.
> > > > >
> > > > > FS_ACCESS_PERM is reported also on blockdev and pipes, but the ne=
w
> > > > > pre-content events are only reported for regular files and dirs.
> > > > >
> > > > > The pre-content events are meant to be used by hierarchical stora=
ge
> > > > > managers that want to fill the content of files on first access.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > The patch looks good. Just out of curiosity:
> > > >
> > > > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsn=
otify_backend.h
> > > > > index 8be029bc50b1..21e72b837ec5 100644
> > > > > --- a/include/linux/fsnotify_backend.h
> > > > > +++ b/include/linux/fsnotify_backend.h
> > > > > @@ -56,6 +56,9 @@
> > > > >  #define FS_ACCESS_PERM               0x00020000      /* access e=
vent in a permissions hook */
> > > > >  #define FS_OPEN_EXEC_PERM    0x00040000      /* open/exec event =
in a permission hook */
> > > > >
> > > > > +#define FS_PRE_ACCESS                0x00100000      /* Pre-cont=
ent access hook */
> > > > > +#define FS_PRE_MODIFY                0x00200000      /* Pre-cont=
ent modify hook */
> > > >
> > > > Why is a hole left here in the flag space?
> > >
> > > Can't remember.
> > >
> > > Currently we have a draft design for two more events
> > > FS_PATH_ACCESS, FS_PATH_MODIFY
> > > https://github.com/amir73il/man-pages/commits/fan_pre_path
> > >
> > > So might have been a desire to keep the pre-events group on the nibbl=
e.
> >
> > Funny story.
> >
> > I straced a program with latest FS_PRE_ACCESS (0x00080000) and
> > see what I got:
> >
> > fanotify_mark(3, FAN_MARK_ADD|FAN_MARK_MOUNT,
> > FAN_CLOSE_WRITE|FAN_OPEN_PERM|FAN_ACCESS_PERM|FAN_DIR_MODIFY|FAN_ONDIR,
> > AT_FDCWD, "/vdd") =3D 0
> >
> > "FAN_DIR_MODIFY"! a blast from the past [1]
> >
> > It would have been nice if we reserved 0x00080000 for FAN_PATH_MODIFY [=
2]
> > to be a bit less confusing for users with old strace.
> >
> > WDYT?
>
> Yeah, reusing that bit for something semantically close would reduce some
> confusion. But realistically I don't think FAN_DIR_MODIFY go wide use whe=
n
> it was never supported in a released upstream kernel.

No, but its legacy lives in strace forever...

Anyway I included a patch in my fan_pre_access branch to reserve this bit
because what have we got to loose..

Thanks,
Amir.

