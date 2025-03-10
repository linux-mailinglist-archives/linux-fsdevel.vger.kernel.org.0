Return-Path: <linux-fsdevel+bounces-43573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71CA58F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13522165E20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE61224AF3;
	Mon, 10 Mar 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao6+T7ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126A22370A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598586; cv=none; b=g0mwd5enI3OG/P2p+RYzfwKLpIavOy+JjdSFhEc/2Fce0J7UKOvOaWlB70wTYO2eCs06y9MNSH58IlabkINfnVurIWw4P+ddA13+hLpbpa01+JgQysHdPzveC+wAWmNkfIQIRp3XzWyqDqfVrHbH9IvjgBlEaoA9gEaudCZ4jwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598586; c=relaxed/simple;
	bh=RUmpmLPxb6tA/tnIKe6C4t+jqMUvaEuSTByXIQ7Ng0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQn423NXAR4IBTeynjHUSALrfUbZvlH0oepT9hw4qxGdlSNuFNBcHSZc3Ls9OO0mMc5xcNhT7oPd0OnBySS9VYN+3j6beHIZ+Mm0+DKaxOJrnZb4jp0X+IjWmsHeHsqi+W2gYYZMSF1/yLC2T/FYVreS2/kCkyZfqTGHWNALhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao6+T7ER; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so2688605a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741598583; x=1742203383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAboIRzcgV1q/TYlTZSjjvhlNdK1FMpHA7xHuWCez98=;
        b=ao6+T7ERaSlsMDuJU4irSIa7VKI8R1CMTCp7Ch8NdIuYbAiNhpputl+yv3AYSVaNfd
         1eh+TdtuqxKtt4WdnwD6JnoH5Iq2bqFEC4WvoAHZeWGPbSsoG0Q4iDcEp1grztLsiaTo
         SWxr5YAT2q+DVHHlcyqL7dUEJaRpkj6ssYFcGSRSqfmqc2GNIbDAAsiEb0mO4qC70asf
         +hyPxgjwsPLdVV3qQa3FZVOAbCErElrh2YNUsPvBTFYmcDVyGwsU0trrJWlLXHmXpxnK
         AZSLa2sgET3FZImyABgy4lGYrXLY62lUuQC3QZXcUV+c2spY4181KVmqItWMZ80uTW+N
         FMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598583; x=1742203383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAboIRzcgV1q/TYlTZSjjvhlNdK1FMpHA7xHuWCez98=;
        b=D/7IEkPviCYrEO0Whm0axNzwuOJn8Cs1p2+qbzAVS+vrX3KAl9EzmtU1s7TvdgFCp7
         03kQeRPPufKZbLs8Qo6w5NUZRc+3OK/E7BiZmHJ3vBwmu1kjIkxyD2QSDW9b1T4CG9ic
         ZXblulosdJ9Rhhw4MDPBULwWxPJUbfdujVl9pi+SWhiePG3s4uCCflkdrmDv5zssOMvk
         zD8mJ2BRjEJDjSRooo1mrLMXN+qcM3EoPEn7748OyFh/5bf698TJzlA3yHQIUYdrt1s/
         gNxtH9hKIZtZfZ018ttEmFBxvSPEogf6fC7lyzNHhzFFgxMLonMuEy3HYU5/0vxQYwqI
         SFKA==
X-Forwarded-Encrypted: i=1; AJvYcCVr1TMLLEFy1xYOce5Z8Wxh/b8C3EUqbgTyTN1aGo3P3QJQLSMINYy+4dn6dicc2xuj4Z4N7I/W4Wr4wexW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8SBtOiupc6lLSLNQEYhCdbDAraONNIosMWRFsKsydOOCE0HN
	JPnTfNq0XYiV2CxlAZk3YRjDffjM0HTVzmxBHgrEobdZeYEksPKg5bJnOapTFZtl/D+miYQl9uE
	yCK9VdvALxND11aVZFJUpiiUDuh8=
X-Gm-Gg: ASbGncvWdQ/KiguTxEyxH1UX0n1mWmch6dC1xwXg/mxf/OpYtt2mzvoa6r39tH2ruPG
	fdHNlxtOpETxfcT6mfPFBOia7krFeQHuH5Imyqa1KbmaEnD+hMSZs9vSthSbsRzKcUsz8gNmNkE
	WbYkjRKtQD3IolSjcVTabuymy8WjJJV0a2PJxC
X-Google-Smtp-Source: AGHT+IGxkBqKIPzOZUgAlOlNSWViQzoaaRGDmAYIJE3uASicTDgmlcNArBcCTXaoBT2xHrPR8Wytw/r7KneLlauOS/g=
X-Received: by 2002:a17:907:1ca3:b0:ab7:b30:42ed with SMTP id
 a640c23a62f3a-ac2521295eamr1578104466b.0.1741598582175; Mon, 10 Mar 2025
 02:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309115207.908112-1-amir73il@gmail.com> <20250309115207.908112-3-amir73il@gmail.com>
 <20250310-pfahl-bauamt-48fbb48b63fa@brauner>
In-Reply-To: <20250310-pfahl-bauamt-48fbb48b63fa@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Mar 2025 10:22:51 +0100
X-Gm-Features: AQ5f1JpSkRJefJ4T3u4q4HD9l2Bp8WGj7aucL34CGaWYZBXp3eySTYc2BZginJo
Message-ID: <CAOQ4uxjha2ri1O1q2KCSkUVgoCX4vA8tqR45htUrqWbmRFiSmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in
 user pages
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:09=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Mar 09, 2025 at 12:52:07PM +0100, Amir Goldstein wrote:
> > In the use case of buffered write whose input buffer is mmapped file on=
 a
> > filesystem with a pre-content mark, the prefaulting of the buffer can
> > happen under the filesystem freeze protection (obtained in vfs_write())
> > which breaks assumptions of pre-content hook and introduces potential
> > deadlock of HSM handler in userspace with filesystem freezing.
> >
> > Disable pagefaults in the context of filesystem freeze protection
> > if the filesystem has any pre-content marks to avert this potential
> > deadlock.
> >
> > Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> > Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k=
3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  include/linux/fs.h | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 2788df98080f8..a8822b44d4967 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3033,13 +3033,27 @@ static inline void file_start_write(struct file=
 *file)
> >       if (!S_ISREG(file_inode(file)->i_mode))
> >               return;
> >       sb_start_write(file_inode(file)->i_sb);
> > +     /*
> > +      * Prevent fault-in pages from user that may call HSM hooks with
> > +      * sb_writers held.
> > +      */
> > +     if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> > +             pagefault_disable();
> >  }
> >
> >  static inline bool file_start_write_trylock(struct file *file)
> >  {
> >       if (!S_ISREG(file_inode(file)->i_mode))
> >               return true;
> > -     return sb_start_write_trylock(file_inode(file)->i_sb);
> > +     if (!sb_start_write_trylock(file_inode(file)->i_sb))
> > +             return false;
> > +     /*
> > +      * Prevent fault-in pages from user that may call HSM hooks with
> > +      * sb_writers held.
> > +      */
> > +     if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode)))
> > +             pagefault_disable();
>
> That looks very iffy tbh.
>

Yes. not pretty.
I am testing the alternative approach suggested by Josef.
Will post the patch as soon as I am done testing.

Thanks,
Amir.

