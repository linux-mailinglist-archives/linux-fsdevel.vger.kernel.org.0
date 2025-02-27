Return-Path: <linux-fsdevel+bounces-42765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B2A485A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C992E3AA798
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EC1C8FB4;
	Thu, 27 Feb 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFGm/P6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAA1B4151
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674903; cv=none; b=Ua1Pqe+0MPM9JXhHw7eyOaBmc+QvH1ey8ng3R/m4KZXD6MH3vCLxkIh4dvbah4CAZTk+T0HyhKPlM3DXnQtKHHCfz+Az3eN4f9jOsEAzNmLowPxdrrxLh7LhQywplvomqC9md8iOFuOlZj3dSB8TFPg0iA4ocQc2hBV/Wwk0J74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674903; c=relaxed/simple;
	bh=kjNwow5X4ZZ01USyEwmrs9aAMem57HqtvhZwTRgcBNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBkn21D3gRxmiV19PN33m9W/Yy35Maon5Kvs9znv5igfYApbe6scFQc1XDu7UhrouL7JCqaZi5ZxfswPSV9gzR2JiyDdy8amOD48STcgc6IxAMGNPftFmlPW37IEVkDiO9fWSQnFlFiL1nyKor/781gYW6QMu8B83X3Dth7d0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFGm/P6E; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60a35eb84fso693503276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740674900; x=1741279700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+CwlNOwz6cX/UtBgNuuvuqtR0CZarS1LGfkpgdEQ4w=;
        b=aFGm/P6EA+fOrqfeuLBh8ZkU2FSqNU5NoCwbJjTQDRL/RTELoynFTZxgrNc5IgVccC
         uiODXHU85IT/fsY9H1nVeXJ/9xVnZ5wlBFGSaZoKGLGcI02CqfIGLoF/3Slw0W/99xdG
         ma1IOm9fn6p0hxaAiaV0NLnhYTN+FxZXi4PdMva+leh6+bRooqh3/lME7jeane7CZK7E
         LJuqf/KaqKBoVuJz/HrVfyF1UT8UwZ6hYwaLD00wTbz8nGIb6BiFauqKJMF1cXShsShf
         J59OenIJ/umBY/K6bMURTRnu6AVZG8d+2+m2kTVks93Sf7Li51OF7rnoO3Eu0LmAo2yx
         SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674900; x=1741279700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+CwlNOwz6cX/UtBgNuuvuqtR0CZarS1LGfkpgdEQ4w=;
        b=SrEg3k6CeCW59Ii7L3HpP28mvYmqnE46Kr41ym+10GDOmHtA6yxntu5Z05x0r6x3AO
         PXq1e8qVzVHhGNtOgm7lJhXLEgJGHhdehoRhqTMW2SQxFQMGF323S3ZKCzmXhE0QTxHQ
         nQ1MJocQQ88oqH/EH3nVkst/BJGbLHSgrKEiSi1CAY4p+bEffv6HYi25Yvpwh61mz9hc
         WfkzwTABsoh60AlfGkxuCx95ruAIGom+Y8OhLJ3j81cIm/aBgmo6uUc/6yzOVWZZfHae
         TGfBUyYZQlEySVi0gWWHlaccobM8yM8dYXXUot5OswIpqkZ7KbXlPrAwmvMUO1Z+LHkf
         AueA==
X-Forwarded-Encrypted: i=1; AJvYcCWO6Hl8NiahvMk9QsP0Za3IZ7G3a83/Egn0k88yQQplQqmeykAmByCF81rPUHQvovrBlWehpGwlHVDA9JcY@vger.kernel.org
X-Gm-Message-State: AOJu0YwuI2MdhHaLxa4HAhPJtVq1nUadghl1fYaDB3h27gOjux4HzKnf
	8OyLmFP3Qb6UFtZ6iBWdsDbmCKQ4HzW2ceEbS15nQZ8UA8sihBSfc7cQSeu7O8XCSjOQMGCUDSR
	x/D7C5uCeKt8SV2WIfREHwrTPaVSkgsZJ5KIV
X-Gm-Gg: ASbGncvZEYUB6EOraRwd77IJXUDn5BPIFh50Q9XiOIWIoJs44gEY46M7lmI+npFO5n9
	ihvy+AocytIfoYzKzJhlH5IhB158xbUzDDTBEGdAyP0jf5MqDFVMU7JyhHr9Ao8Yyf6rkpx6NxY
	KbsSCjtdI=
X-Google-Smtp-Source: AGHT+IFYI+8SraAdigQGx7lYdH5LUnt1/UBb+qYVnBDFc3+wD7MPjfWvDbf4Mkowsvjayh1/wuUuat9GLQUM9I01TCE=
X-Received: by 2002:a05:6902:2e0b:b0:e58:aa00:ffe0 with SMTP id
 3f1490d57ef6-e5e8359551emr21182111276.5.1740674900254; Thu, 27 Feb 2025
 08:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224154836.958915-1-mszeredi@redhat.com> <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
 <CAEjxPJ5V9z87c6pHVRemKxENoNq9TvqpQ3tJpLEbP4QEViZTHQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5V9z87c6pHVRemKxENoNq9TvqpQ3tJpLEbP4QEViZTHQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Feb 2025 11:48:09 -0500
X-Gm-Features: AQ5f1JqX1rQ6m62bB5eNpWIdO0cQOPLAxtXa7BRO08xtGHgf2ADpYVSS1Bp8tTM
Message-ID: <CAHC9VhTVBY7qkNQ-_vUWm_Y5bQ7OREp2hOWmfLizAXJs0f6Rtg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 26, 2025 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > Watching mount namespaces for changes (mount, umount, move mount) was=
 added
> > > by previous patches.
> > >
> > > This patch adds the file/watch_mountns permission that can be applied=
 to
> > > nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny wat=
ching
> > > a particular namespace for changes.
> > >
> > > Suggested-by: Paul Moore <paul@paul-moore.com>
> > > Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6j=
yovz92ZtpKtoVv6A@mail.gmail.com/
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  security/selinux/hooks.c            | 3 +++
> > >  security/selinux/include/classmap.h | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
> > merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
> > targeting for linux-next?
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> I'm not objecting to this patch, but just for awareness, this adds the
> permission for all file-related classes, including dir(ectory), and we
> are almost out of space in the access vector at which point we'll need
> to introduce a file2 class or similar (as with process2).

Yes, I've been paying closer attention to this over the past several
years as we start to nudge the permission count limits.  However, as
you mentioned, this isn't a new concern and we've successfully dealt
with it in the past.

--=20
paul-moore.com

