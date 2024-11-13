Return-Path: <linux-fsdevel+bounces-34696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7F9C7C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7520FB2E802
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577B205ABD;
	Wed, 13 Nov 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2ADR705"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673416DEB4;
	Wed, 13 Nov 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525118; cv=none; b=Pmz/A7ZpNIUS6i/J+j9gMgLbNLRCEZ4CvBBfck8jedF2qyvp7uhoQwV2m1b2lU5k7UJfu0SRM9pkqX+aI7MbHRG0skdeaFS2mopesrWfoBrJKqYpIPoNqK4bykD1sTwn/c37YqmHoZ70QhVTpqdZ/yiLUm67ixockPPHHXkczTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525118; c=relaxed/simple;
	bh=HlfbFcV5sJcpj5zqs1ySc/VnU7ycIKL2nKgQXNS9MFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfO9NNhXIWkmUHBwvNAMXu/eqvD2xL8ktQT51r/r3IEFGbIpd1ppHqFICu1ycyJC8C3VoTkjaJdt15zIRablxJ50GPdF0pmFOlpF2GWNsgHVJHJkqNtQCnOxFA3d87b3DYhoIRL53cVdJ+yGt9K7OYVL5P7eGXjhRC0dWgQVxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2ADR705; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa1f73966a5so248262166b.2;
        Wed, 13 Nov 2024 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731525115; x=1732129915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q+8FNc2ytDg7RieFT9goBSoHoyxH/PoPvWuBdU9IS4=;
        b=S2ADR705P/WwKnilB4kq9tYAWgOtjg4GkOnQx6+iTn+bWBcsKKpNNRr233o80rjJJI
         sNA+s1SdeYTRbxdP886YlL4UZ5CRB9uCiQ6iVzcEJqaRTRBmwj/oAeQv6dap9dbB9j6f
         458eCQ9bxeaxFQKr0cfNWpDu0KcheOGKG9UWHI5EmftRlDs7ypBSeQ/vbHxpvzsxQHvZ
         W4s/dr7xANDqVWOfQGXiPZ8s7bgMQC1c103RkQK4XxLh0fOWPOl+UHjwIDLZKy74Alec
         nmp/Y23HoyDPcSZQBRCIj/HKt4UBljdU2VQzpQF6jnuLSogi7usL2JjXWTGYcuQ2onxN
         1aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525115; x=1732129915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q+8FNc2ytDg7RieFT9goBSoHoyxH/PoPvWuBdU9IS4=;
        b=ia8nyISWRetVuFkUcv6gmEIL4ala+1fMEleW8QxMB/ivW0zY68/SrQQPOxKzw8PiDW
         AptHEDtoBEjjRac8H4GVG8z+7q6157uXX4IK2TBoHY9AZnf/K0OgDG74F/6mVTMCaUS/
         N1HyHSIc4pKxouIsUtBRzt3J+5O02YZrZdVeDIOy7X836gKG8Ujfes8Ee++lhjMdo4SV
         QiTomgB1vGiiYVV4f19o8nZxb68j/bHtq7xeDy9koYN0TY9v/no9DvLVUB/m3lWG8+2y
         lpIDMOTdFDJte2AMvKuQKTk7O6quOvWFY4N3gn7W4NhBsSUZI6SHr7dVFCIDH/fCWwxP
         maUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkA0GoYNDAEAl7tCSSRq5fEnjpQ9waEKoJZfmDXcrPM6a8qJPG7vdejsRrSKRMSTqZrwiQLNIENo3DA==@vger.kernel.org, AJvYcCVUutivNnGtxF3BqQN11/oxAYqQEQMbeK6zJ3EjAf0eSEF+fUJd2REbtXmGi/hikQnVQv+uxINC15A+DQ==@vger.kernel.org, AJvYcCWYyuTcq7eUiOtli29I+No+BevXTCO7qKDfP3WAUDJr3VG+0qOlXM9viNFax5q6WG7TeU/RRUExkPWS+8cOzw==@vger.kernel.org, AJvYcCXuI0n8cF6erFC/jdhbp5WD3M6ewDoSUM6ddy0ZMUrmWxS5s21DqKadTG+F++8C4fZ+ycHwUZnpyXzC@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0682tTKkIhlvS5mSOfrrzLnzvw9sQeEToLrSGLD4LPy+Ix0t
	jxISgRIpHLJUVWIkbaOTDrxwYra8e5FV7BavBQ4udsA5LOrei6UOGZCXTaOsKmjgUuHt6tlcgYo
	3rKKI1A3NfmT1F9/b6Ty5jDnQIQ4=
X-Google-Smtp-Source: AGHT+IFjcv0P8IIDO97PcCN5S7SxQV9ik2hLtub35kKA7vznAH6u+jV8u+K37Im4T2XozTvcOCmVqkexlWfmeUKgKM4=
X-Received: by 2002:a17:907:3f8a:b0:a9e:c954:6afb with SMTP id
 a640c23a62f3a-a9ef0018b25mr2166360666b.51.1731525113311; Wed, 13 Nov 2024
 11:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
In-Reply-To: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 20:11:39 +0100
Message-ID: <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:12=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> >  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > +static inline int fsnotify_pre_content(struct file *file)
> > +{
> > +       struct inode *inode =3D file_inode(file);
> > +
> > +       /*
> > +        * Pre-content events are only reported for regular files and d=
irs
> > +        * if there are any pre-content event watchers on this sb.
> > +        */
> > +       if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
> > +           !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
> > +           !fsnotify_sb_has_priority_watchers(inode->i_sb,
> > +                                              FSNOTIFY_PRIO_PRE_CONTEN=
T))
> > +               return 0;
> > +
> > +       return fsnotify_file(file, FS_PRE_ACCESS);
> > +}
>
> Yeah, no.
>
> None of this should check inode->i_sb->s_iflags at any point.
>
> The "is there a pre-content" thing should check one thing, and one
> thing only: that "is this file watched" flag.
>
> The whole indecipherable mess of inline functions that do random
> things in <linux/fsnotify.h> needs to be cleaned up, not made even
> more indecipherable.
>
> I'm NAKing this whole series until this is all sane and cleaned up,
> and I don't want to see a new hacky version being sent out tomorrow
> with just another layer of new hacks, with random new inline functions
> that call other inline functions and have complex odd conditionals
> that make no sense.
>
> Really. If the new hooks don't have that *SINGLE* bit test, they will
> not get merged.
>
> And that *SINGLE* bit test had better not be hidden under multiple
> layers of odd inline functions.
>
> You DO NOT get to use the same old broken complex function for the new
> hooks that then mix these odd helpers.

Up to here I understand.

>
> This whole "add another crazy inline function using another crazy
> helper needs to STOP. Later on in the patch series you do
>

The patch that I sent did add another convenience helper
fsnotify_path(), but as long as it is not hiding crazy tests,
and does not expand to huge inlined code, I don't see the problem.

Those convenience helpers help me to maintain readability and code
reuse. I do agree that the new hooks that can use the new open-time
check semantics should not expand to huge inlined code.

> +/*
> + * fsnotify_truncate_perm - permission hook before file truncate
> + */
> +static inline int fsnotify_truncate_perm(const struct path *path,
> loff_t length)
> +{
> +       return fsnotify_pre_content(path, &length, 0);
> +}
>

This example that you pointed at, I do not understand.
truncate() does not happen on an open file, so I cannot use the
FMODE_NONOTIFY_ test.

This is what I have in my WIP branch:

static inline int fsnotify_file_range(const struct path *path,
                                      const loff_t *ppos, size_t count)
{
        struct file_range range;
        const void *data;
        int data_type;

        /* Report page aligned range only when pos is known */
        if (ppos) {
                range.path =3D path;
                range.pos =3D PAGE_ALIGN_DOWN(*ppos);
                range.count =3D PAGE_ALIGN(*ppos + count) - range.pos;
                data =3D &range;
                data_type =3D FSNOTIFY_EVENT_FILE_RANGE;
        } else {
                data =3D path;
                data_type =3D FSNOTIFY_EVENT_PATH;
        }

        return fsnotify_parent(path->dentry, FS_PRE_ACCESS, data, data_type=
);
}

/*
 * fsnotify_truncate_perm - permission hook before file truncate
 */
static inline int fsnotify_truncate_perm(const struct path *path, loff_t le=
ngth)
{
        struct inode *inode =3D d_inode(path->dentry);

        /*
         * Pre-content events are only reported for regular files and dirs
         * if there are any pre-content event watchers on this sb.
         */
        if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
            !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
            !unlikely(fsnotify_sb_has_priority_watchers(inode->i_sb,
                                               FSNOTIFY_PRIO_PRE_CONTENT)))
                return 0;

        return fsnotify_file_range(path, &length, 0);
}

fsnotify_file_range() does not need to be inlined, but I do want
to reuse the code of fsnotify_file_range() which is also called for
the common file pre-access hook.

So did you mean that the unlikely stuff (i.e. fsnotify_file_range())
should be an indirect call? or something else?

Thanks,
Amir.

