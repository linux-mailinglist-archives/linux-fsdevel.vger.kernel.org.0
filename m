Return-Path: <linux-fsdevel+bounces-41641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C07A33EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359983A8365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73EC24292D;
	Thu, 13 Feb 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Dg/FZGLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC122156F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448010; cv=none; b=m30JqM9FOiQYlq7qfO9nB4sPOn0tawgAdwFt2afCG+ByfhkGCGF3WRIdCWkcvOamGJwWv1AX6Dwp/iZS0zRAj5y4Q+xsSj/1SYo5jf/7N6BNQXIz5a6PACgV+yaeTV7QmQXC4Syq+vyTpORBqEV3mI1vlXVGAwHkyeHyHMwQUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448010; c=relaxed/simple;
	bh=jO0lN5x9guXp1a4LurUsJQThejvJaKRkotHrdOiQ9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW7tJDXMt9Vp8yjVYzTJvQEaPH6g3UccfxYMNUZrPx/ZPOqR55exfCighSlw3jf8rJvod35mNLninT7FGo/c+7fZKMTSF26LcVnPDGMTDc5qJbiXVnE4FhTRzM1RVkSwKQeJ+2+4hC8z3h6Repy/JVFzD6lMdGkws+e9/HXsqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Dg/FZGLk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471a25753a4so6257001cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 04:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739448006; x=1740052806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=Dg/FZGLkaZ7ie6M7KfJ0TS6y+1v6GfledRzDEjzhrFVkV7uxrcCLh+GQvS5H4KHXL8
         B51WJr8ZenjcTJprsEiiDlKCbKsZzxvg9FvDFhorRi45bII61nN42/Ul+A/gOXOVchwk
         Bary65zTIufxEg3GLS9b65341xcV8kC1py7lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448006; x=1740052806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxIbGeZdAUj59XbtP18FGXOievh8ogWpoWw7ACveybI=;
        b=kGaOKRle6bMwuugm2pt8k4qQ17G5zZY2Al1zw8ZTvquEABmh1maIOKGcNPqB87QpBK
         7YanRRQVOTha2FM9L02z4Md6KxLsyPpi0nMIbEYmxvdjLcZvP8vwX/YT789TAfNRc0Jv
         yo9OBlA5GVFLpUX0GxPRpeVTf67A3xd0Mq4XcKPkiNdjLjHPCpIudtgQM8c/2n1GDfup
         lSkqDs1iS77rJ4W8pTLd73zScqMFcR1popiiCSH8g8nANP45pfmOVzQbkIfLeW6HtO9r
         0ueOeNFicJ8O+Ovcs2gfX6/GvThlJF5mVAqIIPLYpLc5kGPsixyWcN4ufHgNTs/VT4Rd
         YvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVE9ImSTYwN7cD84HYn0OsCyZHyJwYhy/L5BJdV1PrhXCa52FUJFF78gLS2eosiGQDw1R12uxKHF4Stpsam@vger.kernel.org
X-Gm-Message-State: AOJu0YyLL/1tUWcvnbxpwhWP0cO8Txg5+5G1pUnPbZ80XcU1tGF/ZVVJ
	542Q6T8H7c91V0fYfWq7FOyARJBVVci06o+JUCPlP8QS7VWMAVxyOpXDZEfdBi4cR6sUDUW7Gk3
	9OfghZu6vCv2i1/YHXfAbKGcMhuo94FEIvu/feg==
X-Gm-Gg: ASbGncsSrflnPL2Ay6tTYg5fZYJSYjhNRQ8WEFxRKsAFYVbhqeZjzh+DhYnZ1XYuekb
	CWsWTB1MrLDMJYvPQU6+5O+yuM6eFYibG+uCh9mJQSvIBT4ER9sHTncGRqCiKo49VE8vE5w==
X-Google-Smtp-Source: AGHT+IECakDoTpDhiyRznxkiGj71HtCaKMx16upveVIQZiceah1ZrEWHrFOAhOuh92zW9TRY+grheUmpzNv0IRyez9s=
X-Received: by 2002:ac8:7e96:0:b0:471:bbdb:9f43 with SMTP id
 d75a77b69052e-471bbdba074mr60632641cf.24.1739448006112; Thu, 13 Feb 2025
 04:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
In-Reply-To: <7fjcocufagvqgytwiqvbcehovmehgwytz67jv76327c52jrz2y@5re5g57otcws>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Feb 2025 12:59:55 +0100
X-Gm-Features: AWEUYZlbIShCppFI0DHhIK5cm-ltnuxnlVq8Qowgi16SzeDjxo4poRs6xazAudA
Message-ID: <CAJfpegs2qoZHG4P+WiopDo92MxHQ_0QrZi0qMz7niannGFiPDQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 16:50, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-01-25 17:58:00, Miklos Szeredi wrote:

> >       fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> > +     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>
> I understand why you need this but the condition is really hard to
> understand now and the comment above it becomes out of date. Perhaps I'd
> move this and the following two checks for FAN_RENAME and
> FANOTIFY_PRE_CONTENT_EVENTS into !FAN_GROUP_FLAG(group, FAN_REPORT_MNT)
> branch to make things more obvious?

Okay.  git diff -w below.

Thanks,
Miklos

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1936,6 +1936,8 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
             mark_type != FAN_MARK_INODE)
                return -EINVAL;

+       /* The following checks are not relevant to mount events */
+       if (!FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
                /*
                 * Events that do not carry enough information to report
                 * event->fd require a group that supports reporting fid.  Those
@@ -1944,21 +1946,25 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
                 * point.
                 */
                fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-       if (mask &
~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+               if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
                    (!fid_mode || mark_type == FAN_MARK_MOUNT))
                        return -EINVAL;

                /*
-        * FAN_RENAME uses special info type records to report the old and
-        * new parent+name.  Reporting only old and new parent id is less
-        * useful and was not implemented.
+                * FAN_RENAME uses special info type records to report the old
+                * and new parent+name.  Reporting only old and new parent id is
+                * less useful and was not implemented.
                 */
                if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
                        return -EINVAL;

-       /* Pre-content events are not currently generated for directories. */
+               /*
+                * Pre-content events are not currently generated for
+                * directories.
+                */
                if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
                        return -EINVAL;
+       }

        if (mark_cmd == FAN_MARK_FLUSH) {
                if (mark_type == FAN_MARK_MOUNT)

