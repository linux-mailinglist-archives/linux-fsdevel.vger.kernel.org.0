Return-Path: <linux-fsdevel+bounces-25791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD99506FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF1DB2501A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E019D062;
	Tue, 13 Aug 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRL68k6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901F19B3DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557485; cv=none; b=jYOBPEG9/kgc5jrOMdxO+MjO/OUZhcvqLfCl450dTMyax7aZJfB+yPQT//+2vMacOSw2nrXLemSENmf2ooUoNqM+SuT1ZZWhhmm56FI/XdaSPgcJBoJgMr3+9wkmeHLL4GkfnAJjCtC3b4FUxvYQd5zGs8PP8VPM1R0vUSYKPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557485; c=relaxed/simple;
	bh=2+3mKwKN/DzwKP4YbD4JOEg26XReV2gKBGv4hnu8/5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiTzT1Fj6VGUnq0aLFdhU1d5qXn+1nl3tR41VX2pj11K6q/Vf/co0ChFzm/rQZOSm0HemJCm95GdN9Osvw1dL34enb46zrZENCGfBfiws9kNioYrx1O2tzNYbct6ICnkFrHijhp90m+nVKXXIlwnW3NwOpchRq7eoCILzUu9J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRL68k6c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aada2358fso975373766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723557482; x=1724162282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0mBmJqYPdMwYO+Plkdz1ilwOC5DCYgyJ5lrVExuN0U=;
        b=mRL68k6cB3cquDsO+g1oXHscRlP/0A2vKWenJr4v1SYjcAMZcNtyB87syD/1p9lYd7
         +zSMxN/eulUV5GQrRwmLWNT2Gt1fsmn0PRCYqtEXm3+bK20/8xQfzWKysV7tsMxtkW9L
         cZdtYgc0d6gUt/Cqjkw4o6PG9RlGQ9ZMPYETKmmiEgKkaCtKFiLPhjxVZhrtcJV3QhAk
         x3KjYJUlY7wSSnBH7jarhkVgcZYBVN2MJMu+Y8GnNtAppQIuvO0q3VjoWXjILN4vQSo9
         vdssGrtc24b95cecKXMC5Ptnt/COa0a7wZzIZpXJ+PS+IyduIJ6uiBoXtGRqrLqP1C9H
         3L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557482; x=1724162282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0mBmJqYPdMwYO+Plkdz1ilwOC5DCYgyJ5lrVExuN0U=;
        b=kbzm6teXG8JH0k5o4zKeK3IA45hpI/m1y5nuAZlJq8lyqm8Zb6NgSFya62xRC0ZbsI
         31D8otw4M1jgWV6k8clCHzw/cwtQ40zS4ShrAQA8/QcFKipk+rXa6kHdSr+BG1Y+EkEy
         UTROUH/SzCNBr9W5BT6Go6NpkT5zPleozvNR1zejZql8syGSKT79pyyDQlB/FxCFc2co
         Jm/kz/wCBPh2w9VUKVGSGSbr9h3Kt5S9mDseYdgFhYM6rCQQX/v/cBGtUMIUK9w1uRFU
         JYazYnpXUOWCW/XMjGqLBzBjFfWyhCa3byafB2EzlUxFfufVjLhlMVbjZIq8OSi9uzSC
         YuZw==
X-Forwarded-Encrypted: i=1; AJvYcCU/TFobbv7497o30kEReG65u4Diy8iN2L2vV09DVuNqd+K13KJ0kFt0d80ZdAUiZ9abuEcaaTeHmlbk7oBpkmUHZvRpem+CPsu5aqg6Yw==
X-Gm-Message-State: AOJu0YwsjSvb/39/9R71iefu6PN344jbX9X5nQG677lOH1FvroFBeMLR
	GuL2oDSqYcG7RQpaJHWVR32BiAAcpy3Xa/f8Wufiy7WxaAu89w0TSXalZQea1WvYvXG8xDq2xA3
	evste6je20Et7XGtmz4KNvvWBENI=
X-Google-Smtp-Source: AGHT+IHJcd45atqT9smZjnQTIBPb1hyAKfz4M/mbpDNXmhsRIH2c1zaul238KViIyOLKuqnusEGy/hMXAdwWcLoZZJA=
X-Received: by 2002:a17:907:d5a1:b0:a80:f646:c9c4 with SMTP id
 a640c23a62f3a-a80f646cbe3mr230097766b.1.1723557481742; Tue, 13 Aug 2024
 06:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
 <99445ca03b6b3edc4b4943add498e2b29c367dec.camel@kernel.org> <CAGudoHGUocqSF=pFy4+ZcPMt9FC_F2E7p6cUXx61DA_ZFME=Mw@mail.gmail.com>
In-Reply-To: <CAGudoHGUocqSF=pFy4+ZcPMt9FC_F2E7p6cUXx61DA_ZFME=Mw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 13 Aug 2024 15:57:49 +0200
Message-ID: <CAGudoHH2pKgFC5XU-C_7UeZfLdm0Q+v17oNGTWgepTwnEmF8xA@mail.gmail.com>
Subject: Re: [PATCH v2] file: reclaim 24 bytes from f_owner
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:42=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Aug 13, 2024 at 3:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Tue, 2024-08-13 at 14:30 +0200, Christian Brauner wrote:
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index fd34b5755c0b..319c566a9e98 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -947,6 +947,7 @@ static inline unsigned imajor(const struct inode =
*inode)
> > >  }
> > >
> > >  struct fown_struct {
> > > +     struct file *file;      /* backpointer for security modules */
> >
> > This struct was 32 bytes before (on x86_64). Now it'll be 40. That's
> > fine, but it may be worthwhile to create a dedicated slabcache for this
> > now, since it's no longer a power-of-2 size.
> >
>
> creating a dedicated slab would be a waste imo
>
> If someone is concerned with memory usage here, I note that plausibly
> the file pointer can be plumbed through sigio code, eliding any use of
> the newly added ->file
>
> However, a real daredevil would check if the thing to do is perhaps to
> add a 48-byte malloc slab. But that would require quite a bit of
> looking at allocations elsewhere, collecting stats and whatnot. Noting
> this just in case, I have negative interest in looking at this.
>

Some massaging of the struct brings me back to 32 bytes despite the pointer=
:
- rwlock -> spinlock
- signum int->short
- pid_type to 1 byte enum

but I don't think making this work is necessary at this point

struct fown_struct_poc {
        struct file *              file;                 /*     0     8 */
        spinlock_t                 lock;                 /*     8     4 */
        short int                  signum;               /*    12     2 */

        /* Bitfield combined with previous fields */

        enum pid_type              pid_type:8;           /*    12:16  4 */

        /* XXX 8 bits hole, try to pack */

        struct pid *               pid;                  /*    16     8 */
        kuid_t                     uid;                  /*    24     4 */
        kuid_t                     euid;                 /*    28     4 */

        /* size: 32, cachelines: 1, members: 7 */
        /* sum members: 30 */
        /* sum bitfield members: 8 bits, bit holes: 1, sum bit holes: 8 bit=
s */
        /* last cacheline: 32 bytes */
};

--=20
Mateusz Guzik <mjguzik gmail.com>

