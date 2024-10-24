Return-Path: <linux-fsdevel+bounces-32722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DD9AE21A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 12:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860AD1C2226A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB71B85E2;
	Thu, 24 Oct 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FveVS5lF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635D1B21B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764410; cv=none; b=IRjgpMs6ubMLtuhBTKGamfiFEo/Y20ls+MRVui78ulrBBdW3YWdCDFQYmo2h9m1exa/UkcccgKGMEoKCxHron5aGkn9vT1sGuOFdau2qLgh9HxhEVEuOblfgIVX8PdBxpg/d1OSVLR6oDyR5nYDwdkkb7WwfdmfkXSbNRPEnrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764410; c=relaxed/simple;
	bh=1SXHwYvGxJ9BPmfJOY2/9qWR1GopFtWFlacn1/muQb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6uxpCcDzO1BAyrL+2mitB6euCeuH649Y0M+pmKI1mU2K3gx1aXHgvZ76n/z6GbfRe2SibsypJJvelFMWPxVCwDNAlKtmAKcnPThS/4t2pb5+xtlRAHRYGWgVxvucm6oz/NM3INrqAxFARlcJXWQkwmn1JH9wMA/86PifzHB0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FveVS5lF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b2e4c50fso4518921cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764407; x=1730369207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4GJXZ6VV6u9+swn8OS/NUGDcEFuAchBQx+fi4/0gPI=;
        b=FveVS5lF4/2PSsCMhvdds9e9PuBygzKYc4iDGVsn3yuJSYCf3r3+qZp1yL8bxcLyLb
         iW3mMfHFAF2ei+kMQuev3eaWPlyW1amXq9tvzKwYEbvbOYUH0QV83TSHVclADn1BCPRv
         tHBZLepO56rt+6vc9DpIOYfqYaOCtwGGlk1Q30V917u+PqyyZdpcpoH/+lrFZtT9BTFk
         d9WkwYUd9oUVHcfzYalM3LrG/V6B84BUD8zstg3g9i37IuKCr7H/qMEK/SBo4cE0UtQF
         /lFTnnoGk3SOk5fbfRf3VLivCz9SSL6duLPDKU5V25StyNpXf/PiTQ8j38GbOHPSm0q5
         LPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764407; x=1730369207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4GJXZ6VV6u9+swn8OS/NUGDcEFuAchBQx+fi4/0gPI=;
        b=RKwvAiEe89BKDLsRcewJ0H08K56oPrCzeD3cp3cVm4az8I6rC28xSb97qCE4v09VeV
         FadWI30A4a1P3dlrM14D2KDP/42rTZihZN5Qj2V3gUODU2yz6KnOGfRSKh/qjpv3UXeA
         8+vkzWJns0/eY23I1gVPd6Es+Z9BEus7RuHzXlc8Wi95R6mJi3QZBaz9t2xMLc4aiZfS
         Eemb1LYwW3apHQmR35cctg8hi+XkPqJ53SFq4sV2KgLanMNwTB0fWuaFwAEBvWxAT83s
         rGL9btL07HNIQquL1LLbPcWTsOecqYYQVaQYRqGIcVTIBAenQg22ZB4SreGfIfvdmjdX
         os8w==
X-Forwarded-Encrypted: i=1; AJvYcCWY544m2XjBOxflrQ3mUZR/wO9hljTCeFzn+fohUIqg+VdxcMXk6AnWnGLY1jXuHMw0fXalDcBQsP3eJ7vT@vger.kernel.org
X-Gm-Message-State: AOJu0YwriyvOUwTYvsxx1LJ+xYrSiaC4bYsUX5toqawjZGAWNrD5irkf
	xShbbHvKKYQVl9Bef3tGKHhdmSlYSMOqdrjVPaIdljdost0hSfyE9gk910SDwzTV2eykatOeX8r
	PMHjX2kfNTFWTSRXYHigHB9EaDXk=
X-Google-Smtp-Source: AGHT+IEeOvKpbX0K0azcX1z3pz6A+s3knDSpdToBfowwXtC+5R7H1i5t/ZeoFcm+9zTdVPJ2sZlVe+d1jXlW22oCa24=
X-Received: by 2002:a05:622a:315:b0:460:9767:54b8 with SMTP id
 d75a77b69052e-461258c8af5mr16654601cf.12.1729764406784; Thu, 24 Oct 2024
 03:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721931241.git.josef@toxicpanda.com> <1a378ca2df2ce30e5aecf7145223906a427d9037.1721931241.git.josef@toxicpanda.com>
 <20240801173831.5uzwvhzdqro3om3q@quack3>
In-Reply-To: <20240801173831.5uzwvhzdqro3om3q@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Oct 2024 12:06:35 +0200
Message-ID: <CAOQ4uxg-yjHnDfBnu4ZVGnzA8k2UpFr+3aTLDPa6kSXBxxJ6=w@mail.gmail.com>
Subject: Re: [PATCH 08/10] fanotify: report file range info with pre-content events
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 7:38=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 25-07-24 14:19:45, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > With group class FAN_CLASS_PRE_CONTENT, report offset and length info
> > along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> >
> > This information is meant to be used by hierarchical storage managers
> > that want to fill partial content of files on first access to range.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.h      |  8 +++++++
> >  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/fanotify.h      |  7 ++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index 93598b7d5952..7f06355afa1f 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask=
)
> >               mask & FANOTIFY_PERM_EVENTS;
> >  }
> >
> > +static inline bool fanotify_event_has_access_range(struct fanotify_eve=
nt *event)
> > +{
> > +     if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
> > +             return false;
> > +
> > +     return FANOTIFY_PERM(event)->ppos;
> > +}
>
> Now I'm a bit confused. Can we have legally NULL ppos for an event from
> FANOTIFY_PRE_CONTENT_EVENTS?
>

Sorry for the very late reply...

The short answer is that NULL FANOTIFY_PERM(event)->ppos
simply means that fanotify_alloc_perm_event() was called with NULL
range, which is the very common case of legacy permission events.

The long answer is a bit convoluted, so bare with me.
The long answer is to the question whether fsnotify_file_range() can
be called with a NULL ppos.

This shouldn't be possible AFAIK for regular files and directories,
unless some fs that is marked with FS_ALLOW_HSM opens a regular
file with FMODE_STREAM, which should not be happening IMO,
but then the assertion belongs inside fsnotify_file_range().

However, there was another way to get NULL ppos before I added the patch
"fsnotify: generate pre-content permission event on open"

Which made this "half intentional" change:
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-       return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
+       return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
 }

In order to implement:
"The event will have a range info of (0..0) to provide an opportunity
 to fill the entire file content on open."

The problem is that do_open() was not the only caller of fsnotify_file_perm=
().
There is another call from iterate_dir() and the change above causes
FS_PRE_ACCESS events on readdir to report the directory f_pos -
Do we want that? I think we do, but HSM should be able to tell the
difference between opendir() and readdir(), because my HSM only
wants to fill dir content on the latter.

I think that we need to decide if we want to allow pre-content events
with no range reported (e.g. for readdir()) or if pre-content events must
report a range, can report (0..-1) or something for "entire range".

Thanks,
Amir.

