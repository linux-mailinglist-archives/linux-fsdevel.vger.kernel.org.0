Return-Path: <linux-fsdevel+bounces-43133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63459A4E7C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9693C188598B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3B290BB9;
	Tue,  4 Mar 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwQgtU9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B2208964;
	Tue,  4 Mar 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106512; cv=none; b=HezvLX6UVIXd2WbAEmVPAm3RacFtUAQ8z7QaiYbY3FCcrRnuteNpeyq9n+Qi6qzSSXEh8PuE+16gAbKtw2x0ePZByYyZyvdgFY/BrNLNJrp/gFJRd/CE819gcWV7S5vTo1+l+v2JLcYT86zKBe5kmzbyw9aDlZ5lPCdWX05hMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106512; c=relaxed/simple;
	bh=9/K+O+0tYHJFaa78bprTS8Tia1OXI2uQnSBiCDWvCBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HECEwZLfTrB5qZT+u/J/JcHGSLN/RQw+OQrnO0XSUPHb0b66gW1sm1tbx93D4cj3cY7de7WnhQBkJD9H2fhm5Q6yr1catykPD/ZyduqMDCHQn3bwoCbCxhUTdimtYDBL0zbY94a6MGmJ/52IsKWHE8QESSCPtOcZzsa/wqgvnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwQgtU9X; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso4567580a12.1;
        Tue, 04 Mar 2025 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106509; x=1741711309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFK6HmFdK7YWt3cfrSsa7kGT8my5O3BzbX19rAAqvNE=;
        b=VwQgtU9XitXF8OsdYOTtjbnZU2rZ9JWHzNCTM34RGm142NkJdc4xCf0Iq0XvcMUKew
         e2h/OiEKEHFHkG2lsBTDIxYuydkUtSyVxj4jLMNqGiVXpLtk3+wd3OJxbOyDmrd7w5ok
         cRakejfCsEDx20Mcy1PNHnYoIoLmzYugFyikToQoGFY+n9F5O1PudTeSMYgsEnUGnMlc
         Z0FPp4C8RagH9tPqm+DyuKjVu+5xeWB2SxkbFYq7hmRF+jXp9SYQU1t92+Bmtw9rSHyM
         Hv3pTwZLIK5vVzkz9sVt7OAzEtJ6kpo1vOVeAr7/DAW7zRZQV8HxeuoZLiHhIllY77qj
         TqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106509; x=1741711309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFK6HmFdK7YWt3cfrSsa7kGT8my5O3BzbX19rAAqvNE=;
        b=pgMGSe3pway/yfThooMiOnw99/CxWSo7B7/MWorS3BmNTMt/Abwm+7TXYEayiKG0b+
         7tVChZ+tonqMbDY4lnuh+1qwRTYKRa/+plZHSFJJOA5Y3fOqcULgDFCsCgfnoSDrXs3H
         wbwV4sFHjHhoH6tYc6kRvNHxdj+PtnOb1ng40tVEh8TVP1tiE5//5of+gfj4pB/WMGul
         f0l84OGcAtKN/74RnOS4a/YTFOHW9Mg2jp6gh/deVS0g6fQZ+w7pQJzB8PNrLBSe8mFs
         wTF5bgKG9M/AuvWfyxnNQ6iy+4RElr1TsvRFWgj3SkbXDNEvHefECN/CUpKFi2a/8HOB
         beyw==
X-Forwarded-Encrypted: i=1; AJvYcCWnsxNfOLWKwjJBL7IMBrHGcwG1lc75bT3XCy3e2mUB3FrlfuF8wbpjct20NZJSjCR+MHk3qz6iAwq9vT6O@vger.kernel.org, AJvYcCXYQpXuDM9HdNyiIHP5DXsZCRfWYJnyTJLArv3hEGbpwXrU4wDAHCnPRyPz/RD4lnlszl0jq4Ttxxj1LsLO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1k3aaDxvcXo8kMKQvWNO1//2IH6slnytoSiDWqSMeJEEoJ9T
	Er2tGSwrWzbEVHNqONcLJhzHWEMVRhnL3BN1lyc1h8Oi52nOVhS+rjeH68xZ6sI/zXkKFhWX6fI
	05c8tYdk89Pn4wDl3hU3PVCPfrqk=
X-Gm-Gg: ASbGncvJPyTipoxU7DYqL1odJWhqj+cXRpfi4uapChDB3bX2BkqrpiIR7F3xXup4XB5
	Fl5Gd5BMbDjAAgXNDruha42O7g8q6DuPY2vym6dnGVaauVxMfUiC8+5RVwc+zbycQY/1jWiTVyc
	+XlqQZdO9za6MOSzSjlUAa1Kx1MA==
X-Google-Smtp-Source: AGHT+IHv6t+cLD+V3ssA5LRroWRPT1uibEDUIe1gnBMn2tlNGU55Tvv6m7lj75UwF+cJ/k/Via1POhPddp7RAOerXRc=
X-Received: by 2002:a17:907:94c7:b0:abf:6166:d0dd with SMTP id
 a640c23a62f3a-abf6166d509mr1180483966b.11.1741106508351; Tue, 04 Mar 2025
 08:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304080044.7623-1-ImanDevel@gmail.com> <CAOQ4uxiaY9cZFpj4m65SrAVXm7MqB2OFSfyH5D03hEwmdtiBVQ@mail.gmail.com>
 <5tq33ajgtu62tvaiymf3st74ctkurgskq6xpx2ax53vdbayoce@jffpxkthro3u>
In-Reply-To: <5tq33ajgtu62tvaiymf3st74ctkurgskq6xpx2ax53vdbayoce@jffpxkthro3u>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Mar 2025 17:41:35 +0100
X-Gm-Features: AQ5f1JoWR-4RdHqjGH7KpFM8_ss2VdkgWqsEirCCn9BEf8-lDtoqBJQ_1J5D-5A
Message-ID: <CAOQ4uxiZfJYHrYmE2k0vWrgbLLbDQ2LTrVggYwL3pv4FUyjctQ@mail.gmail.com>
Subject: Re: [PATCH] inotify: disallow watches on unsupported filesystems
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:05=E2=80=AFPM Seyediman Seyedarab <imandevel@gmail=
.com> wrote:
>
> On 25/03/04 12:57PM, Amir Goldstein wrote:
> > On Tue, Mar 4, 2025 at 8:59=E2=80=AFAM Seyediman Seyedarab <imandevel@g=
mail.com> wrote:
> > >
> > > currently, inotify_add_watch() allows adding watches on filesystems
> > > where inotify does not work correctly, without returning an explicit
> > > error. This behavior is misleading and can cause confusion for users
> > > expecting inotify to work on a certain filesystem.
> >
> > That maybe so, but it's not that inotify does not work at all,
> > in fact it probably works most of the time for those fs,
> > so there may be users setting inotify watches on those fs,
> > so it is not right to regress those users.
> >
> > >
> > > This patch explicitly rejects inotify usage on filesystems where it
> > > is known to be unreliable, such as sysfs, procfs, overlayfs, 9p, fuse=
,
> > > and others.
> >
> > Where did you get this list of fs from?
> > Why do you claim that inotify does not work on overlayfs?
> > Specifically, there are two LTP tests inotify07 and inotify08
> > that test inotify over overlayfs.
> >
> > This makes me question other fs on your list.
>
> Thanks for the review! I may have overlooked overlayfs, but these
> following discussions led me to include it in the blacklist:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/882147
> https://github.com/libuv/libuv/issues/1201
> https://github.com/moby/moby/issues/11705
>
> Apparently, things have changed in v4.10, so I may have been wrong
> about overlayfs. I can test each filesystem and provide a response
> instead of blindly relying on various bug reports. However, let's
> first discuss whether the patch is necessary in the first place.
>
> > >
> > > By returning -EOPNOTSUPP, the limitation is made explicit, preventing
> > > users from making incorrect assumptions about inotify behavior.
> > >
> > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > ---
> > >  fs/notify/inotify/inotify_user.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/ino=
tify_user.c
> > > index b372fb2c56bd..9b96438f4d46 100644
> > > --- a/fs/notify/inotify/inotify_user.c
> > > +++ b/fs/notify/inotify/inotify_user.c
> > > @@ -87,6 +87,13 @@ static const struct ctl_table inotify_table[] =3D =
{
> > >         },
> > >  };
> > >
> > > +static const unsigned long unwatchable_fs[] =3D {
> > > +       PROC_SUPER_MAGIC,      SYSFS_MAGIC,       TRACEFS_MAGIC,
> > > +       DEBUGFS_MAGIC,        CGROUP_SUPER_MAGIC, SECURITYFS_MAGIC,
> > > +       RAMFS_MAGIC,          DEVPTS_SUPER_MAGIC, BPF_FS_MAGIC,
> > > +       OVERLAYFS_SUPER_MAGIC, FUSE_SUPER_MAGIC,   NFS_SUPER_MAGIC
> > > +};
> > > +
> > >  static void __init inotify_sysctls_init(void)
> > >  {
> > >         register_sysctl("fs/inotify", inotify_table);
> > > @@ -690,6 +697,14 @@ static struct fsnotify_group *inotify_new_group(=
unsigned int max_events)
> > >  }
> > >
> > >
> > > +static inline bool is_unwatchable_fs(struct inode *inode)
> > > +{
> > > +       for (int i =3D 0; i < ARRAY_SIZE(unwatchable_fs); i++)
> > > +               if (inode->i_sb->s_magic =3D=3D unwatchable_fs[i])
> > > +                       return true;
> > > +       return false;
> > > +}
> >
> > This is not a good practice for black listing fs.
> >
> > See commit 0b3b094ac9a7b ("fanotify: Disallow permission events
> > for proc filesystem") for a better practice, but again, we cannot just
> > stop supporting inotify on fs where it was supported.
>
> Following the same approach as 0b3b094ac9a7b ("fanotify: Disallow
> permission events for the proc filesystem") would require setting
> a specific flag for each fs that isn't supported by inotify. If this
> is more suitable, I can work on implementing it.
>
> I understand why it might seem like disallowing users from monitoring
> these filesystems could break userspace in some way. BUT, programs
> work incorrectly precisely because they do not receive any information
> from the kernel, so in other words they are already broken. There is no
> way for them to know if the fs is supported or not. I mean, even we are
> not sure at the moment, then how would they know.
>

Programs not knowing is a problem that could be fixed with a new API
or new init flag to fanotify/inotify.

Existing programs that would break due to this change is unacceptable.

> As an example, 'Waybar' is a userspace program affected by this patch.
> Since it relies on monitoring sysfs, it isn't working properly anyway.
> This is also due to the issue mentioned earlier... inotify_add_watch()
> returns without an error, so the developers haven't realized that
> inotify isn't actually supported on sysfs. There are over five
> discussions regarding this issue that you can find them here:
> https://github.com/Alexays/Waybar/pull/3474
>

You need to distinguish "inotify does not work"
from "inotify does not notify on 'remote' changes"
that is changes that happen on the network fs server or inside the
kernel (in sysfs case) vs. changes that happen via vfs syscalls
on the mounted fs, be it p9, cifs, sysfs.

There are several discussions about supporting "remote change"
notifications for network filesystems - this is a more complex problem.

In any case, I believe performing operations on the mounted fs
generated inotify events for all the fs that you listed and without
a claim that nobody is using this facility we cannot regress this
behavior without an opt-in from the application.

Thanks,
Amir.

