Return-Path: <linux-fsdevel+bounces-27824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB60496457D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A89AB291F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D771B143B;
	Thu, 29 Aug 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq7uf0ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A61B1415;
	Thu, 29 Aug 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935811; cv=none; b=VKJUtKid0209fBOHBPXBwIRINvp6NtZP7hd8afziSiiphllRTB9WuCx3g91JoKMTjMUORD48bnHDXLsp/GHO4Esx1ht5GyiHscAPhXdJF17nQ8lSVAkOlR2864IMGF5LxGV3lmjCuj91TVukBjvTiItu8tnJdu1lq+KE5hUqrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935811; c=relaxed/simple;
	bh=LfSCKmw0/BJUJ964F95/aGYZ9qmVOStY3H19rr/nolk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9UGUexRoliPvdzAiPpCuHkbr65U/Y/n6jNvdk3BZqr+C0tbFkaRF1orxvslv3IXCmolyLw1KVWEMHZ5wNdvU4rKbNxyp4raWyV/XiKEDGWR79ynBDbk9ct2o8kaPo6sYK3hDuhgAwsYd+YdqWPVKwTdroNeyviNG/pvQxGkrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq7uf0ki; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70968db52d0so576631a34.3;
        Thu, 29 Aug 2024 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724935808; x=1725540608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87Xt3iZvibBSnMheRJRNqlcSZdIV5Fv5uwTTbjkUYLQ=;
        b=hq7uf0kig5vnhl1cJvM58hRpeCShEnDGqXSglnOTsxZ9AsmCaO8NXk3ZirX2NHaSNW
         cRql8HaMi4zJIQjWUYEU1wTSts35HCbRROOw54LWkhiuE7zDOmb7/6NbIwH22DgMukIq
         W7zDS4/E1ldrXqUPRbXIcp0G2oX6dRA91e9Ykl2szWnq5LS6TUyOztbdMvl+VFTi5hhr
         o8iRPnAmmb/9yyhu/NinPSE4XeEKuHzUO15+4B5J3thtyQ81+DI7ilFKsae8yoHOWYli
         Oge4ytOOb2dMqko2iiCrdBJsy/XfhWsaxHJ//nWWMp5M/KCdqcZrs8toczn1TqyV5wVF
         FuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935808; x=1725540608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87Xt3iZvibBSnMheRJRNqlcSZdIV5Fv5uwTTbjkUYLQ=;
        b=vVkJiRfYta+jmYuN6erQb63AL2oEPh82/cuT7KBaju45/KMuXADZzh+BEFdKawmMve
         BC9H0R9Noxl64hxA8X6ueALT4yuuKLZyOVN9RMZM8Ewb5Mr0Ls8n3jGkROBE9HGHAPpC
         TQvb5r46z+isD9+cmRCzaxk8Jtcavth9O9FK3YkeCVhRzxDOoJJpNcCGlGRv5fnLQTM7
         815GHt10LXUw9Xi7QZm/OnL1hlpEi3Twa8LB6/3EvdWedtRB6sWILCWFU3HAUy/4LucV
         qJ5okpG/plTpfUusWOuN5xOCcNjewwC1dzbNLdmg7bdGwNEKwojZrQo+h6Wp5EdR3wNQ
         BI0g==
X-Forwarded-Encrypted: i=1; AJvYcCUL2H6o/u4/tMgdPoEZDHi/s/P5KIUpe9N0T5uKuomnLUI8IA35/OcVBU5Gx4D8zy/b/Z/FSt688kc0owCc8Q==@vger.kernel.org, AJvYcCVLxu78aPgixTSBwtjCrTDf6Kv48D8Kmk5F0wWnraFIyngd2i9URqJ7HKQJ2g6AtlnLWQztjsk4xaPN32wPHA==@vger.kernel.org, AJvYcCWfo1uLCWSM2QtOJdh7Mw3SugehlzY4rvAkGz8HZ4GNWMgTgJe4X1fC+Ee9P+Y9vFYTjP4Z5hI+3uhj@vger.kernel.org
X-Gm-Message-State: AOJu0YyTd2HfXttd0DivWgT/kPVlyxMJhe53nX+n8bEGjV4OGx8fbxvX
	+SVEx7aEepAO1m3IEvJZKrgpHRNWo5h04zijhq+7riGSSG6rhfx5BOnxksMuoPUx35cOoPjZ98g
	RbS5+HCVpGk0xO20hLmOjXfWLZ7c=
X-Google-Smtp-Source: AGHT+IGT9E2+JJFVG63aD5jzMummcaDjfiwTyrwxdYlQH7uv/ISUdBWyKvTI2ZdWWqricgQZLl0+A4xmQmiU6J8eyTk=
X-Received: by 2002:a05:6830:4188:b0:709:339e:525d with SMTP id
 46e09a7af769-70f5c3e39e5mr2675449a34.21.1724935808513; Thu, 29 Aug 2024
 05:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723670362.git.josef@toxicpanda.com> <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3> <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
 <20240829114327.zm3ghtjic3abvucy@quack3>
In-Reply-To: <20240829114327.zm3ghtjic3abvucy@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Aug 2024 14:49:56 +0200
Message-ID: <CAOQ4uxiDD00LMNNMH1Y5SA83L-5mhwqG9mKe=DKyQ7Qrqk4eaQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 29-08-24 13:26:17, Amir Goldstein wrote:
> > On Thu, Aug 29, 2024 at 1:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > > > gfs2 takes the glock before calling into filemap fault, so add the
> > > > fsnotify hook for ->fault before we take the glock in order to avoi=
d any
> > > > possible deadlock with the HSM.
> > > >
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > >
> > > The idea of interactions between GFS2 cluster locking and HSM gives m=
e
> > > creeps. But yes, this patch looks good to me. Would be nice to get ac=
k from
> > > GFS2 guys. Andreas?
> >
> > If we are being honest, I think that the fact that HSM events require c=
areful
> > handling in ->fault() and not to mention no documentation of this fact,
> > perhaps we should let HSM events be an opt-in file_system_type feature?
> >
> > Additionally, we had to introduce FS_DISALLOW_NOTIFY_PERM
> > and restrict sb marks on SB_NOUSER, all because these fanotify
> > features did not require fs opt-in to begin with.
> >
> > I think we would be repeating this mistake if we do not add
> > FS_ALLOW_HSM from the start.
> >
> > After all, I cannot imagine HSM being used on anything but
> > the major disk filesystems.
> >
> > Hmm?
>
> Yeah, I was considering this already when thinking about btrfs quirks wit=
h
> readahead and various special filesystem ioctls and I agree that a need t=
o be
> careful with page faults is another good reason to make this a
> per-filesystem opt in. Will you send a patch?

Huh! I am still struggling to keep my head above the water
coming back from a long vacation, so I think it is better if Josef takes
that as well.

But here is a trivial, untested, probably broken, space damaged patch,
that should be broken and squashed into other patches in the series
if this is any help at all...

Thanks,
Amir.

index c3c8b2ea80b6..07c3cf038221 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1672,6 +1672,11 @@ static int fanotify_events_supported(struct
fsnotify_group *group,
                                 (mask & FAN_RENAME) ||
                                 (flags & FAN_MARK_IGNORE);

+       /* Filesystems need to opt-into pre-content evnets (a.k.a HSM) */
+       if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+           path->mnt->mnt_sb->s_type->fs_flags & FS_ALLOW_HSM)
+               return -EINVAL;
+
        /*
         * Some filesystems such as 'proc' acquire unusual locks when openi=
ng
         * files. For them fanotify permission events have high chances of
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index cbfaa000f815..32690e5c4815 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -207,7 +207,8 @@ bool fsnotify_file_has_pre_content_watches(struct
file *file)
        struct inode *inode =3D file_inode(file);
        __u32 mnt_mask =3D real_mount(file->f_path.mnt)->mnt_fsnotify_mask;

-       return fsnotify_object_watched(inode, mnt_mask,
+       return inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM &&
+              fsnotify_object_watched(inode, mnt_mask,
                                       FSNOTIFY_PRE_CONTENT_EVENTS);
 }
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fb0426f349fc..14468736d15b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2499,6 +2499,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT                8       /* Can be mounted by
userns root */
 #define FS_DISALLOW_NOTIFY_PERM        16      /* Disable fanotify
permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to
handle vfs idmappings. */
+#define FS_ALLOW_HSM           64      /* FS can handle fanotify
pre-content events. */
 #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move()
during rename() internally. */
        int (*init_fs_context)(struct fs_context *);
        const struct fs_parameter_spec *parameters;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ec1e88342442..b6845ab477d6 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -178,6 +178,7 @@ static inline int fsnotify_file_area_perm(struct
file *file, int perm_mask,
         * if there are any pre-content event watchers on this sb.
         */
        if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
+           !(inode->i_sb->s_type->fs_flags & FS_ALLOW_HSM) ||
            !fsnotify_sb_has_priority_watchers(inode->i_sb,
                                               FSNOTIFY_PRIO_PRE_CONTENT))
                return 0;

---

